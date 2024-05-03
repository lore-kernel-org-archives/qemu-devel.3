Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80625C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p74-0005iv-Kg; Fri, 03 May 2024 05:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2p72-0005i8-V7
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2p71-00043w-80
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714728109;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCOR+fvrvU4+yuZ2wEb/ubktbSdstrDPnOI1ZRfnG0Q=;
 b=PcuFMUfFJLm5O3uzo5nbiUkGVR5zJc9fb16LTqbQmdflLTmASGqSfi1519FGJsgLRU4caN
 d88GIimW2YFn84TQGPiwM3yMD5NazKHcPAsUHktfmubmsWrL0cRQwjFkhTfN4O4PcX9Nst
 SIQQkLQl+V/7Mdq2wx0Hi3Rxpf9Z0W8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Ka8FtfaXMYOqShq7PkAeVw-1; Fri,
 03 May 2024 05:21:45 -0400
X-MC-Unique: Ka8FtfaXMYOqShq7PkAeVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A44528EC107;
 Fri,  3 May 2024 09:21:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C9040C6CC0;
 Fri,  3 May 2024 09:21:39 +0000 (UTC)
Date: Fri, 3 May 2024 10:21:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
Message-ID: <ZjSsgHEz9zR6YSdT@redhat.com>
References: <20240503071634.841103-1-mjt@tls.msk.ru>
 <ZjSbRsOpJsTdTh6l@redhat.com>
 <e8db4fec-5c7c-42d5-bba7-a85b09f0a358@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8db4fec-5c7c-42d5-bba7-a85b09f0a358@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 03, 2024 at 10:51:57AM +0200, Philippe Mathieu-Daudé wrote:
> On 3/5/24 10:07, Daniel P. Berrangé wrote:
> > On Fri, May 03, 2024 at 10:16:34AM +0300, Michael Tokarev wrote:
> > > Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
> > > This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
> > > 
> > > riscv64 in debian has been non-functioning for almost a year, after the
> > > architecture has been promoted to release architecture and all binary
> > > packages started to be re-built, making the port not multi-arch-co-installable
> > > for a long time (in debian, multi-arch packages must be of the same version,
> > > but when a package is rebuilt on one architecture it gets a version bump too).
> > > Later on, debiah had a long time64_t transition which made sid unusable for
> 
> "debian" (even "Debian")
> 
> > > quite some time too.  Both such events happens in debian very rarely (like,
> > > once in 10 years or so - for example, previous big transition like that was
> > > libc5 => libc6 transition).  Now both of these are finished (where qemu is
> 
> ("QEMU")
> 
> > > concerned anyway).
> > > 
> > > Hopefully debian unstable wont be very unstable.  At the very least it is
> > > better to have sporadic CI failures here than no riscv64 coverage at all.
> > 
> > IME of running Debian sid in CI pipelines for libvirt, it is
> > way too unstable to be used as a gating job. There are periods
> > weeks-long when packages fail to install, even for relatively
> > mainstream arch targets like x86, let alone a new target like
> > riscv.
> > 
> > Running the job by default is sane, but it should not be made
> > gating until in a formal Debian release IMHO.
> 
> So it is waste of resources, and each time maintainers will look
> for failure and notice "oh this is still this broken image" and
> skip. Hard to see the gain of bringing that back TBH.

Michael has indicated he wants to see the result of testing of riscv,
to validate stable releases don't regress.

Having it non-gating allows the possibility to look at the job and
evaluate whether a failure is due to genuine bugs, or distro problems.

Having it gating guarantees the the pipeline overall is going to be
marked failed whenever distro problems hit, which is worse as it
impacts everyone using CI.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


