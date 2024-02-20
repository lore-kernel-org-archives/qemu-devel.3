Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVHR-0001lD-2H; Tue, 20 Feb 2024 13:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVHN-0001kM-H7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVHL-00012r-Sh
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708455341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBr+QAEde/+MM4vvWNC/ypHCwwetosf18ybEHNRwVK0=;
 b=H1yI6QfhAZ5Z0/qX1ForBGcJrVSAPBDRhZsNy7KjrYosOi1GBbCrwl2whgJSyMi4DyNTY0
 jgIdv+VA0aRvzqGT50OaMIUs1yyleqebIMSxYeiASnXdS2bH5UoLiRqlOhUtUCkMLS5nn6
 Vr+Wo6h/qL2j7OwYI6OAwoVlu0LmGRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-VP0UnZUqN7enDOdMxVHWzg-1; Tue, 20 Feb 2024 13:55:38 -0500
X-MC-Unique: VP0UnZUqN7enDOdMxVHWzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6732F83FC70;
 Tue, 20 Feb 2024 18:55:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A84071C10C0F;
 Tue, 20 Feb 2024 18:55:37 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:55:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
Message-ID: <ZdT1pyGMcsNGja3M@redhat.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:46:37PM +0100, Philippe Mathieu-Daudé wrote:
> On 20/2/24 18:44, Peter Maydell wrote:
> > We don't support 32-bit Windows any more, so we don't need to defend it
> > with this CI job.
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   .gitlab-ci.d/container-cross.yml              |   5 -
> >   .gitlab-ci.d/crossbuilds.yml                  |  14 ---
> >   .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
> >   tests/lcitool/refresh                         |   5 -
> >   4 files changed, 135 deletions(-)
> >   delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
> 
> 
> > diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> > index d19d98cde05..987ba9694ba 100644
> > --- a/.gitlab-ci.d/crossbuilds.yml
> > +++ b/.gitlab-ci.d/crossbuilds.yml
> > @@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
> >       IMAGE: debian-mips64el-cross
> >       EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
> > -cross-win32-system:
> > -  extends: .cross_system_build_job
> > -  needs:
> > -    job: win32-fedora-cross-container
> > -  variables:
> > -    IMAGE: fedora-win32-cross
> > -    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
> > -    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
> > -                        microblazeel-softmmu mips64el-softmmu nios2-softmmu
> 
> Thomas, is it possible to add mips64el-softmmu to the cross-win64-system
> job or is it already at the timeout limit?

If its too close to the limit, we could add  across-win64-system-part2
job now we freed time from the deleting the win32 job.

> 
> > -  artifacts:
> > -    when: on_success
> > -    paths:
> > -      - build/qemu-setup*.exe
> > -
> >   cross-win64-system:
> >     extends: .cross_system_build_job
> >     needs:
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


