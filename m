Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB226C44507
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrCt-0005lR-ES; Thu, 09 Jul 2026 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whrCZ-0005aB-1Z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whrCT-0004PR-Vu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783612928;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ4jwR/MhhnjHz2PbFK3r1/kvcPHuNb9esx6XuUrq8s=;
 b=cps1jaJD0IzMYXwD+3AnvJMYBaF+B+CjmWL2ucjgpApVEtmT6HKXkVSgmLA2fXEUzXVWfE
 XlHAy/q0LvV299N6hkVnoS4T4hTATuhPuywEwfGX2W0DYVL52mcI3TKwn++PHWpj8ya4NK
 88zs7TQ/1tpvKcc0O+zUup/ccWHDjOM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-YDxybqXbMAq9u4fGqIuWeQ-1; Thu,
 09 Jul 2026 12:02:05 -0400
X-MC-Unique: YDxybqXbMAq9u4fGqIuWeQ-1
X-Mimecast-MFC-AGG-ID: YDxybqXbMAq9u4fGqIuWeQ_1783612924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D1111800597; Thu,  9 Jul 2026 16:02:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0E318005A3; Thu,  9 Jul 2026 16:02:01 +0000 (UTC)
Date: Thu, 9 Jul 2026 17:01:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
Message-ID: <ak_F9r-TdJSq8f5m@redhat.com>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_A20foem8Ry_-M@redhat.com>
 <360aa513-7d40-4a49-babc-f579a1ecf441@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <360aa513-7d40-4a49-babc-f579a1ecf441@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 09, 2026 at 08:55:08AM -0700, Pierrick Bouvier wrote:
> On 7/9/2026 8:40 AM, Daniel P. Berrangé wrote:
> > On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
> >> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
> >>> When a developer's environment is already within a podman container it
> >>> is not possible to use 'podman' again to create containers. It will
> >>> usually result in wierd errors such as:
> >>>
> >>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
> >>>
> >>> Podman offers the ability to talk to a daemon outside the container,
> >>> however, which could be leveraged by QEMU.
> >>>
> >>> This can be used by invoking "podman --remote", or equivalently the
> >>> separate "podman-remote" binary:
> >>>
> >>>   https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md
> >>>
> >>> The current 'podman version' check is insufficient to detect the
> >>> inability to launch containers, so it is replaced with the stronger
> >>> 'podman info' check.
> >>>
> >>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >>> ---
> >>>  tests/docker/docker.py | 10 ++++++----
> >>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> >>> index ff68c7bf6f..9e18b984f4 100755
> >>> --- a/tests/docker/docker.py
> >>> +++ b/tests/docker/docker.py
> >>> @@ -76,14 +76,16 @@ def _guess_engine_command():
> >>>      commands = []
> >>>  
> >>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> >>> -        commands += [["podman"]]
> >>> +        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
> >>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
> >>>          commands += [["docker"], ["sudo", "-n", "docker"]]
> >>>      for cmd in commands:
> >>>          try:
> >>> -            # docker version will return the client details in stdout
> >>> -            # but still report a status of 1 if it can't contact the daemon
> >>> -            if subprocess.call(cmd + ["version"],
> >>> +            # 'version' is not sufficient to prove a working binary
> >>> +            # for podman. 'info' is a stronger check that is more
> >>> +            # likely to correlate with ability to create containers,
> >>> +            # and required to detect the need for podman remote
> >>> +            if subprocess.call(cmd + ["info"],
> >>>                                 stdout=DEVNULL, stderr=DEVNULL) == 0:
> >>>                  return cmd
> >>>          except OSError:
> >>
> >> Taking a look at why tcg tests are slow to compile, I reached this
> >> commit. It seems like that calling 'podman info' is 5 to 10 times slower
> >> than calling 'podman version'.
> >> Thus, a container run now takes +1s when it was 0.2 before.
> >>
> >> On my setup, podman (remote) version fails correctly if it can't
> >> establish a connection.
> >>
> >> The commit description briefly says
> >> ```
> >> The current 'podman version' check is insufficient to detect the
> >> inability to launch containers, so it is replaced with the stronger
> >> 'podman info' check.
> >> ```
> >> but it's not what I observed.
> >>
> >> Do you have more information about what is the exact reason we can't use
> >> 'podman version' for podman-remote?
> > 
> > My developer env involves toolbox, which is a wrapper around podman:
> > 
> > "podman version" is not an operational check - it is effectively
> > nothing more than a variant of command line "help". Just shows
> > the binary can print to stdout.
> > 
> > By contrast "docker version" is useful as IIUC it shows you can
> > connect to docker daemon, but podman is daemonless so the 'version'
> > chck doesn't offer any useful proof.
> > 
> > "podman info" is an operational check that correlates with the
> > ability to actually create containers.
> > 
> > ⚙️  [host:fedora-44 ~]$ toolbox enter almalinux-toolbox-9 
> > ⚙️  [podman:almalinux-9.8 ~]$ sudo dnf -y install podman
> > ⚙️  [podman:almalinux-9.8 ~] podman version
> > Client:       Podman Engine
> > Version:      5.8.2
> > API Version:  5.8.2
> > Go Version:   go1.26.3 (Red Hat 1.26.3-1.el9_8)
> > Built:        Tue Jun 16 23:52:20 2026
> > OS/Arch:      linux/amd64
> > 
> > ⚙️  [podman:almalinux-9.8 ~]$ podman info
> > Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
> > 
> > ⚙️  [podman:almalinux-9.8 ~] $ podman --remote info
> > OS: linux/amd64
> > provider: qemu
> > version: 5.8.2
> > ..snip...
> >
> 
> In this case, isn't the problem is that the environment should not have
> podman installed if it can't actually create containers?

podman *can* create containers by using the '--remote' flag, which
is what we made work in QEMU.

> Considering this, I think it would be better to have a "fast" default,
> that only checks version, and leave the rest to the user to make sure
> their env is correctly configured (or that they remove podman if that's
> not the case).

My env is correctly configured so that podman --remote works. Doing
onmly a version check will make QEMU not work once more.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


