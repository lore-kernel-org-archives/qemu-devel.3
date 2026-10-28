Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BF606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cWBjQKB8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PQnARhKv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HN-00037x-Hm; Wed, 28 Oct 2026 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HC-00023k-7U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HA-00041f-MX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwRrgt1OyddaLVMoYDG8conGheNVoih1cqkAYh0/GCs=;
 b=cWBjQKB8sVyVMcSfkZ+OcPIHRnuxSWiwGCAflt7OTCQgpqsnZyP58XUTM25QbozYkKjknP
 iJGgtXRSThbZSAyHowVdbKAERKPlAUuyhnkyB29+CXJFreKHGYkLKkkoA3+rAvA/uhlVuL
 eLUBGVfABYRQpWcldeycRn/SEmAarnc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-wdq-XmDANVqR6X5x2J1g9Q-1; Wed, 28 Oct 2026 13:17:14 -0400
X-MC-Unique: wdq-XmDANVqR6X5x2J1g9Q-1
X-Mimecast-MFC-AGG-ID: wdq-XmDANVqR6X5x2J1g9Q_1793207833
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so759270f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207833; x=1793812633; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HwRrgt1OyddaLVMoYDG8conGheNVoih1cqkAYh0/GCs=;
 b=PQnARhKvRy76nv3vNaZk6+W2uEzhg/6oodB9BMTShuKo86kHPu1+JcmSP/puTm6xnt
 YZEaiweT0kp5HGR0CzJ9gWW0JD5MjqalWK9pcV0RapDgTO9agRlFmFhmO9kd2coQwIvQ
 /gOppm7WarY7pE/8hlZG3fhdAZ+Vf6km+16aAb5oyr2gCoGpPQiefmnlD9AvRRSg2VR1
 GtYkyOcuBqx8iGFlEhhAJAdW73n+cWOKv19gpD4CX3NZ7IJAlmix/UCJ0CjxvIc5QUC5
 UYT0MiLPZFBqb2z5dfqi0eJ0nLW0t5zR2CGYZEYBxDETuf6BdrdnqMQOnPFxLI04E5vX
 lSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207833; x=1793812633;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HwRrgt1OyddaLVMoYDG8conGheNVoih1cqkAYh0/GCs=;
 b=MyKuU+GBPDpXdQsUV34FQecv/js02bTARboParEB/Y2e3la1wRjOdK2Z/H2kIZKu/O
 AVWXMAJWYCGBugTTicmhnqgbFq6jXn9kQu0QMCA2SV2UYih863eaKoUlWfRsauqw0D5V
 OLwFueBxJR2iA14tH6bu/GUD4f2kVUYUT8UjKB2cQhOg+9bTgNTh/gBys58oBijtz1IU
 AQRyV9EYQQLKJdRgGsF5C5wbV00SqkYSxyk9sQkQt3Up25+XfMd3O+55x+DMbliH2YtM
 7WfvLQCpOS86zupeXFmbIrCXHJZLHKZ+uQSZhXGhYZp4krj0cV8qAjAxZ+Zn/ObuNouu
 G8qw==
X-Gm-Message-State: AFq9FYKoAd94+WafJU+c9/SGcwmgX9Pib49y3ozSLsxT0rORNU/YFAIS
 Q42zWNTWfrS3ma04KRRE2XtOCpEnIbQty8b1a8Epx5BiyhHw+jPzIutL88xet8YDax8kfFvg4/8
 +WBH59+b/9L790BbjqfvLZJl6RvPVGLhrk717U5dxYnbzBfFjLw8EOeB2OzlUxDDZ2psduLhPYl
 jU5sJLNdzfQNdaMliW+mVSwxCFYMk4RuRmgA==
X-Gm-Gg: AYBFou2tVyCluN6iPpuvIV7rcfa4xraa16VP917T/wVzuK6m0C5CFY9gbhT5WgX6/Nl
 cWOkxCRMdHiCmd4NppL0T82D2VVUgT8fIvz7iTZ5/L2RFUO0/pNSjjeUDGNhLb4Ec+IZjw28+2M
 hmi/WSHTKZhO4MyIMhnbKO2gSGl5LqImtT/lGEYlyTlF2GRge7WMFrZHNrUroHT8hc21/znKmAT
 OtAWCDzZqdfnhjrJgcLhNxQRzv+Xq21Gs1s9t7dAulGCGPalvN99FXUdyd0xk7Cwlmpd8s9kVYL
 JB1QD1uL3tz6f56ABZwT84xYkCebN+dnm5Y0KAVxuK0umgC/x3yHsVyQL4hhBt0lX/D5uGIyS1N
 s3h27rvGp1OPm83FqL1Jdiv2B3LnIDZU2IBBg4Ccg
X-Received: by 2002:adf:fd0a:0:b0:48d:f7f9:6a29 with SMTP id
 ffacd0b85a97d-48e5d5b575emr5594521f8f.20.1793207833145; 
 Wed, 28 Oct 2026 10:17:13 -0700 (PDT)
X-Received: by 2002:adf:fd0a:0:b0:48d:f7f9:6a29 with SMTP id
 ffacd0b85a97d-48e5d5b575emr5594450f8f.20.1793207832449; 
 Wed, 28 Oct 2026 10:17:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm30655070f8f.47.2026.10.28.10.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:03 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 69/78] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Message-ID: <bb741be54f53e7e562b0b34364f1603da6df3638.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Move the VTDAccelPASIDCacheEntry typedef structure inside the
CONFIG_VTD_ACCEL ifdef block.

When CONFIG_VTD_ACCEL is disabled, this structure is entirely unused
throughout the code. Moving the layout under the existing preprocessor
guard prevents exposing dead type definitions and ensures the header
remains clean when building without VTD acceleration support.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020091955.1607161-2-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 4a9003c92d..46c1a29409 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -12,6 +12,7 @@
 #define HW_I386_INTEL_IOMMU_ACCEL_H
 #include CONFIG_DEVICES
 
+#ifdef CONFIG_VTD_ACCEL
 typedef struct VTDAccelPASIDCacheEntry {
     VTDHostIOMMUDevice *vtd_hiod;
     VTDPASIDEntry pasid_entry;
@@ -20,7 +21,6 @@ typedef struct VTDAccelPASIDCacheEntry {
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
-#ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-- 
MST


