Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE7E6403D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQoF-000087-7M; Fri, 22 Nov 2024 05:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tEQoD-00006N-Kh
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tEQoC-0006DL-1T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732270959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mWJHbvg5SeYLsjfAgYDCROVrO7UXlCe3qtrXBLDDuTs=;
 b=c4kYp+iMZBatT2IE/Tjsly6z15P38Hry0VS6+1MjVuNvLypoQ3EqJuINC9sKu0+jIxBzUg
 PPJwzTG37xEEuenHlyrF/Xui0w/Q5ULGMaNzWhZa8qzDwDghxgrliIwfFUS5Bb0L3KusV9
 s95SUK8CnhShF8HsiJcuR1Z1VeVJoHU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-fFolGp2iPtGNBcx-Snvd8Q-1; Fri,
 22 Nov 2024 05:22:37 -0500
X-MC-Unique: fFolGp2iPtGNBcx-Snvd8Q-1
X-Mimecast-MFC-AGG-ID: fFolGp2iPtGNBcx-Snvd8Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74E7E19560A3; Fri, 22 Nov 2024 10:22:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4579219560A3; Fri, 22 Nov 2024 10:22:32 +0000 (UTC)
Date: Fri, 22 Nov 2024 10:22:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com
Subject: Re: [PULL v3 0/8] Block layer patches
Message-ID: <Z0BbZfJid7VbvCUv@redhat.com>
References: <20241120105106.50669-1-kwolf@redhat.com>
 <CAFEAcA9M_-4=UdOTwV251qOxuELAxXtJW8QaZWTs4bUq7dJwxw@mail.gmail.com>
 <Z0BaQ0ahUn4ORhPS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0BaQ0ahUn4ORhPS@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Fri, Nov 22, 2024 at 11:17:39AM +0100, Kevin Wolf wrote:
> Am 20.11.2024 um 14:19 hat Peter Maydell geschrieben:
> > On Wed, 20 Nov 2024 at 10:52, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
> > >
> > >   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> > >
> > > for you to fetch changes up to 83987bf722b6b692bc745b47901be76a1c97140b:
> > >
> > >   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-20 11:47:49 +0100)
> > >
> > > ----------------------------------------------------------------
> > > Block layer patches
> > >
> > > - Fix qmp_device_add() to not throw non-scalar options away (fixes
> > >   iothread-vq-mapping being silently ignored in device_add)
> > > - Fix qdev property crash with integer PCI addresses and JSON -device
> > > - iotests: Fix mypy failure
> > > - parallels: Avoid potential integer overflow
> > > - Fix crash in migration_is_running()
> > 
> > Hi; the hotplug_blk.py:HotPlug.test avocado seems to be failing:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/8423313170
> > https://gitlab.com/qemu-project/qemu/-/jobs/8423313162
> > 
> > [stdlog] 2024-11-20 12:49:35,669 avocado.test test L0740 ERROR| FAIL
> > 1-tests/avocado/hotplug_blk.py:HotPlug.test -> AssertionError: 1 != 0
> > : Guest command failed: test -e /sys/block/vda
> > 
> > https://qemu-project.gitlab.io/-/qemu/-/jobs/8423313162/artifacts/build/tests/results/latest/test-results/09-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log
> > 
> > Looks like the test called device_add, it succeeded, but
> > it didn't see the /sys/block/vda node appear in the guest.
> > 
> > (The test logic of "try the command, if it fails sleep for 1
> > second then try a second time and if that fails call it a
> > test error" doesn't seem super robust in the face of slow
> > CI runners, but OTOH it failed the same way on both jobs,
> > so I don't think that is the culprit here.)
> 
> This looks like a bug in the test case that was previously cancelled out
> by a QEMU bug. :-/
> 
> {
>   "execute": "device_add",
>   "arguments": {
>     "driver": "virtio-blk-pci",
>     "drive": "disk",
>     "id": "virtio-disk0",
>     "bus": "pci.1",
>     "addr": 1
>   },
>   "id": "__qmp#00002"
> }
> 
> What it actually meant is "addr": "1". It's an unfortunate interface,
> but string "1" and integer 1 mean different things for PCI address
> properties... Going through QemuOpts turned everything into strings, so
> that masked the bug in the test case.
> 
> Should I just fix the test case and move on, or are we concerned about
> other users having a similar bug and want to move the change to 10.0,
> keeping device_add with iothread-vq-mapping broken in 9.2?
> 
> As far as I can tell, libvirt always uses the string form, so everything
> using libvirt should be fine either way. Peter (Krempa), can you
> confirm?

Yes, we're fine.

The code is here:

  https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_command.c#L572

The "s:addr" arg indicates we've reqyested "string" formatting for
the arg, which we've always done, because we need the ability to
pass the "slot:function" pair which can't be represented in int
format.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


