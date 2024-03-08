Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E5AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribg0-0002G0-RT; Fri, 08 Mar 2024 09:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ribfz-0002A8-7s
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ribfx-00060f-KZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909900;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82z7YFeKfbRewTWWU5PYsKxbVxv4r8YpYoe/jrvAsQA=;
 b=F0lSH3WDKa0NCWTVcv3HWJfYKnsgR7HAqzmcffo3FlqWipgthh04vLpmRx7HMHKgqFhQDj
 FVxi+DHa4whAeHf51YBMeOIT3VPsxCZI16PAexWaYebNiR45CgNQjPXYoU7kmd8/aE6gYk
 qOCDZOC8qi7AxhEwFmZovGl2casCjCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-qt124p8pNYC5X1TGzAc_1A-1; Fri, 08 Mar 2024 09:58:17 -0500
X-MC-Unique: qt124p8pNYC5X1TGzAc_1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C981087AA16;
 Fri,  8 Mar 2024 14:58:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC8B17AB3;
 Fri,  8 Mar 2024 14:58:16 +0000 (UTC)
Date: Fri, 8 Mar 2024 14:58:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH v2 2/2] gitlab-ci: add manual job to run Coverity
Message-ID: <ZesnhndkCIQs0WXL@redhat.com>
References: <20240308130507.582097-1-pbonzini@redhat.com>
 <20240308130507.582097-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308130507.582097-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 08, 2024 at 02:05:07PM +0100, Paolo Bonzini wrote:
> Add a job that can be run, either manually or on a schedule, to upload
> a build to Coverity Scan.  The job uses the run-coverity-scan script
> in multiple phases of check, download tools and upload, in order to
> avoid both wasting time (skip everything if you are above the upload
> quota) and avoid filling the log with the progress of downloading
> the tools.
> 
> The job is intended to run on a scheduled pipeline run, and scheduled
> runs will not get any other job.  It requires two variables to be in
> GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set up
> in qemu-project's configuration as protected and masked variables.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/base.yml      |  4 ++++
>  .gitlab-ci.d/buildtest.yml | 37 +++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.d/opensbi.yml   |  4 ++++
>  3 files changed, 45 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


