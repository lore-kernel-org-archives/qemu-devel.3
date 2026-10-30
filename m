Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TR/u8eBE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Yt+Tlrz3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMni9-0002GN-Vo; Fri, 30 Oct 2026 10:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMni7-0002FV-D6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMni5-0004oB-Uu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793370961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA5L0xlBbRNOB7eOpi05i/WjXaD2fX7brvXnm9Ha7BM=;
 b=TR/u8eBEK63c4mwXYN8tlWsuzcubbcD+1aErQLIfllPujlXM9svq17wklSXHUij90M4ots
 ncy+99PvdSy6mq8DEgYKguGBQZV8lWG7+KX8Q9nAvmIknxe7ysnWtKXjqyvU6NVqsgpT2+
 h3+On+/y6o4d0jvzwW4gnreWxEWVe3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-HHnqNmT1OZuDYNIIa-u9iQ-1; Fri, 30 Oct 2026 10:34:45 -0400
X-MC-Unique: HHnqNmT1OZuDYNIIa-u9iQ-1
X-Mimecast-MFC-AGG-ID: HHnqNmT1OZuDYNIIa-u9iQ_1793370884
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so653775f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793370884; x=1793975684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TA5L0xlBbRNOB7eOpi05i/WjXaD2fX7brvXnm9Ha7BM=;
 b=Yt+Tlrz39AzIcrTpN1/93bckSLQEnHNnm80B4L4WMhTL/O0OR6hkfwX2hARVHS6yXJ
 HV2W/8rx1duf2yarbbzjWME8Tlid0yCoSLXY7/X4zEdKyYOVgqET+AczGM6dq8LASOJL
 yQMqKw6nMu3HJniolP98vaeFjKMXZGby/yU5RhN/6MkfO0Sji0hHJJ/80exqSKMJ4a15
 TsORYoQpKO216CJ98kqux9UfVddD3A5M7QfhIzq0Lwj6i5+ZVERdV2SH8w1xlgymAz0L
 Qw5boyNj7I31IGzOKKfXl/yNJ9WvzIhS9WEoZzLYkmbUomPAv0Po+mGGY+Wq9DKmNDTo
 FxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370884; x=1793975684;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TA5L0xlBbRNOB7eOpi05i/WjXaD2fX7brvXnm9Ha7BM=;
 b=jtwjtRlksfurnvKNDKdYw70Btsg7l2Reg3jdIx+1K9AN7/L+c74vgNzNhGyHt32aK+
 Su0vN7JgxVHip1Dl640zPiLUIB1LU+r0rcZRfGfGucXM/Mc1ZlEspumXpO+T5fxf8Mzq
 P+0OvVBG9Pm0RcNWbruDv4sgAbOHyyFkVhjQ3z89fuePCGtsSX+ClVT8l/bjJipuiSvu
 zVsqfHZlf65Aq6j9Rb4XfJiJasrm0OoKclkVTu3z87c5HhYbmGjxkxPBpU3GchYQeFFh
 VhQjgnRZbE5kCcEtFaglzXsTLl4BPoI/b0D75T7YgwXffwkhodlcqw99FRVs/2HMNkcG
 wygg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1rFILBccNMHXrH9b9IcmiUuugSxBXte7iQGDY6FLxYEYwUgtWC/YjiEing2r6IWQ9PxcxHUisUGWH@nongnu.org
X-Gm-Message-State: AFq9FYIGtYL5LAyreGSVvit2daBLdhUYvllLLX0sGU087zS30CK/ZQVk
 ka09Fv8AOIVFPtfPH9/ZEqbyOFZM+Iacs+r0i5F6/cVGxT34JO6vocJAUhAfZ3kyuxwX+7b8jTj
 JkJWwv74mASgDmMyaT20/bA08saJuSUCzGBAPoLrhoM664n6YswyHRM0u
X-Gm-Gg: AYBFou2b5PJf5fJiwfcvyYCOvtYd4nu9QP89OVUlrSCjxoJrlerkxOh9R+3oFbWRDhq
 MJiztOHsSTF9n+5U1vLnw/ezro8C71fc5o2zyIbjgWNtRoZGQLsyTDBYbKmQCGFVTJf93tVmqOS
 UBNxqzgZS5Vh9+OwtKvWPrXbNejzngAL7kYeSykjCXdIdXfyqtVweuhX6TzOIJ2t+ZL6quIpWGh
 8iA0XVTnceqHYJQJ3ZQ0pobXD4tkEt7amZxJkxvg6qsEfPAegqdtM/zH2ROXOEDHur+EznApwgl
 1pOUeadk4Dr39IXc/Yv2aniMyByUYeO+ebZjWkulFTtQk7jTBVZVAGaxCrqAZLqI7mQRR5s7YZQ
 TlScmtcT2Oy0QqjZV05OFfGPQfROB/KdhrVvQrqFUqzfzAbxANeji33FNJPFfO4eOwDAHMGB03q
 IP/1Kt8m+RqtetLxn1jvyzSu7UvtONx3U1Vt0ky6//b4/FdB8v
X-Received: by 2002:a05:6000:250a:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e6e303c68mr6067309f8f.14.1793370883950; 
 Fri, 30 Oct 2026 07:34:43 -0700 (PDT)
X-Received: by 2002:a05:6000:250a:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e6e303c68mr6067267f8f.14.1793370883571; 
 Fri, 30 Oct 2026 07:34:43 -0700 (PDT)
Received: from seott-rh.redhat.corp
 (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm3102924f8f.59.2026.10.30.07.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:34:43 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 1/2] target/arm/cpu64: fix typos in
 kvm_arm_set_cpreg_mig_tolerances()
Date: Fri, 30 Oct 2026 15:34:31 +0100
Message-ID: <20261030143435.57230-2-sebott@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030143435.57230-1-sebott@redhat.com>
References: <20261030143435.57230-1-sebott@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix a couple of typos and a #xa0 space.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dcd0d698b3..96aeb6c7a0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -771,15 +771,15 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
      */
 
     /*
-     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
+     * TCR_EL1 was erroneously unconditionally exposed before linux v6.13.
      * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
      * when disabled for guests")
      */
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
                                      0, 0, ToleranceNotOnBothEnds);
     /*
-     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
-     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
+     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionally exposed
+     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
      * S1PIE registers from userspace when disabled for guests")
      */
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
-- 
2.56.0


