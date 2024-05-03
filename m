Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195B6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nv1-0004Bl-9l; Fri, 03 May 2024 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2nuy-0004BS-7h
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2nuw-0008Gd-8P
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714723517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NaEA4T5TEedJ5dGkD6+twX6XNI4GpEHWx8GsX2bB29Q=;
 b=gLr8r+onnUKlZN+fyOAgVUoP6EQewYM/XIp+DoHfMoN4StZtchLPiTaS6JxwaJ265x1i6U
 A6HspK1CeZ7mDDcq3GzGsHz9sYdY89CqffEAsR2rMbPNMm6kw2kEbcWBICVM4CRhed/oQJ
 oeCwaKhWhanoZ9sflR0Esn0MYrfLiO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-o0xgm5uLM7aJJx9IYd8vNQ-1; Fri, 03 May 2024 04:05:13 -0400
X-MC-Unique: o0xgm5uLM7aJJx9IYd8vNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56174812C4F;
 Fri,  3 May 2024 08:05:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6064416D94;
 Fri,  3 May 2024 08:05:12 +0000 (UTC)
Date: Fri, 3 May 2024 09:05:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] Re-enable riscv64-debian-cross-container (debian riscv64
 is finally usable again!)
Message-ID: <ZjSatbLY1U8QQRaw@redhat.com>
References: <20240502194046.830825-1-mjt@tls.msk.ru>
 <3ce937fb-afb9-4ea2-97ab-b8dc0952e9be@linaro.org>
 <9969663a-0f00-435b-b507-fb6a429cb4db@tls.msk.ru>
 <2cdaeac2-d57b-4daa-826e-d57d55d5dad0@linaro.org>
 <34584520-cf5d-47c8-a8a2-ca177a89edef@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34584520-cf5d-47c8-a8a2-ca177a89edef@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 02, 2024 at 11:54:15PM +0300, Michael Tokarev wrote:
> 02.05.2024 23:41, Richard Henderson wrote:
> > On 5/2/24 13:08, Michael Tokarev wrote:
> > > This thing works now with sid/unstable, this is what this patch is about.
> > 
> > It worked when first introduced, then failed, then worked...
> > Sid is too unstable for our usage as a gating test.
> 
> unstable can be unstable at times.  Generally it works, and can fail
> during short periods.
> 
> riscv64 didn't work since it got promoted to release arch last year, due
> to non-working multiarch because many riscv64 packages in debian had
> different version numbers compared to other architectures (due to rebuilds
> of binaries).  Later on whole sid was broken by a large time64 transition
> and a lot of breakages in this area.  This is now being completed and
> is migrated to testing, which is finally available for riscv64 too as
> a release arch.
> 
> I wouldn't switch to testing just yet, because at this point, unstable
> will usually be more stable, or, rather, it will be broken for much
> shorter periods of time than testing, due to migration delays.
> 
> It will take some more time for debian testing to become more or less
> stable in this context.  But lack of riscv testing already cost me a
> *stable* release which failed to *build* (8.2.3 fails to build on
> riscv64).  So I think it is more important to run this job on sid
> than not to run it at all.

JOB_OPTIONAL requires a job to be manually started, but is
non-gating.

We need something intermediate, that always starts the job,
but still keeps it non-gating. You'll see if the pipeline
job for riscv is green or yellow (failure), and can then
check if its a real failure of a Debian failure.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


