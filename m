Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pbtbk6ph;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R9z132zQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMni6-0002F9-JN; Fri, 30 Oct 2026 10:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMni3-0002Eb-S6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMni2-0004nz-Cy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793370957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9HoDy1Tx6gNEjwMWbZHwxdCtdDapQQ7mAdhRiFhnG8=;
 b=Pbtbk6phO1ug0EYPTh9if+lCwmSyrHzj645/kQmMyQWsRmuTyMBmM846s6QGDb54YpQTJm
 v3DFS47kYaB0o0KTjGM49uH15dr4HIV0NL15NP/J6/ChAr866LdkUOyfXSHYl10mxqhhyU
 qGqS64WAPD5CzTJ2Uojh4YeCiCrsU4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-5J4xZa0iPvqDvJb0s9Zl8A-1; Fri, 30 Oct 2026 10:34:45 -0400
X-MC-Unique: 5J4xZa0iPvqDvJb0s9Zl8A-1
X-Mimecast-MFC-AGG-ID: 5J4xZa0iPvqDvJb0s9Zl8A_1793370885
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0ef019a4so607078f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793370885; x=1793975685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9HoDy1Tx6gNEjwMWbZHwxdCtdDapQQ7mAdhRiFhnG8=;
 b=R9z132zQgEiUAEs+JgHzqRTosVPqsY78dEws1hNNaajSQD5kN9SNBk10RJ0GSayuNr
 K7jt867o4rtiTpKSJ3SHM1D8LUseLjHeGrMMAL8vNxdVkF2CobmmK8Upn2tvqighNbwM
 YC+4zGaCXoQsHUO8NejsKokf6oYbwR4mMSJoqL1aC9jxb04KOdIeleKds87OtVRfBpgc
 xCcoBat83OCryPjKZbkiPMBXqk4h+k54yLSgtEjfocD8j/lYyf60SWFunhHlQYOVqWvy
 8+XM1D8PaL2oLB7AvY0gDfthBRCxGPP7Xzxd56MC8v7+PN2uYol4iwx2EPlaUyojovd2
 j97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370885; x=1793975685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y9HoDy1Tx6gNEjwMWbZHwxdCtdDapQQ7mAdhRiFhnG8=;
 b=alNv+sNKLgegNkoO9IJOi5NaTjB2xdcyujan/RzdLSwpXI53x6wXry5s9sbcKH+e4W
 0fKk/GqKy+VnkuGzo9Kj0t4LT+HBOiGuxo+KIUM204+stum8U98e2X8/cYoyUrZ99aN/
 XR/kxsrxSGDzoM1Dii6M9EAZ20cncJrfKBEbtWvl31cMMeWmEN6vsLmp5yDCFpNLyBGv
 HKquG5OL54QWZrWrD/dQiL3ZNpUbq/wsLgmV8VN0AQ99uMD7EWXWWLDopuCwHPV6azL2
 6wz/MmQzstyRHH40nd+8gZmqFAVdUxgZJzAnYLQNUW8IYHn4xgHcIPiQodQaSegG+vN2
 eUSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlPXkanEGZvfOq+uENP21cxMrwFWqT0y6bD3f0uR7GJxtps9C/mGVBMRSyJtrFlGbBFqQF2RgGonMr@nongnu.org
X-Gm-Message-State: AFq9FYI7uWDHcNvm7VTwkhS0i713YyUMX0v3Hhm8K2EQr7VHRNy4u5g8
 Ao1Ky4Vd434aPMBP08kCczPbwuOYbq+cCtqsKMyfpMJNbY6WMnb5esay65ZDr6yOl5Wm6Qg1ucS
 n4wsCbZjVYn7lG7RezkZqrng4rf3OzwqTDoWdTEpSDpMgiViSCWrpCVFz
X-Gm-Gg: AYBFou3lb8be11LpnMo1ujjCNb025OpOQHsa/kM+8i9HaKCDXuyWYyNXayecAtVopzp
 OSnYc5+ZHGynMDe1PzcS4wioE+p+To0LsKDED4v7SNtQNOoHQ4MYmFn5MvoSYxrAgzblFcsPUM9
 sixDGpaILU66RjY2fdffGZvQbf5ULTK4PSLyeUqCtORdh++Ed4u6u4pQdjUQQ45KkRwvIlE20SU
 Wlh95/IL17CNAUWV1QXz4bMUgXd3vgKmtoN/Jk1LRZ0cXB7M+6hVaDkekL0GXdL9GspnKlJn05M
 plyYHF6/+/34A5oUkvso+AxiAn/ghVqz0WYWJG7fqNOVm5RMEWys0LcfHY+0eEFhSf4xEzeUGxU
 k+YEA3u40sHHxlXYzo51oxRVFeXy7Fff64eLQRFqZGOcFyey0+z4PbeGUATZzr/DdvBKVo2QaI5
 3Ghf55Za9hWZlrks16VnwU9fdp4rLQftTNxwYQO2U4Wlh1ZYUn
X-Received: by 2002:a05:6000:4914:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e6e5008b4mr6301869f8f.26.1793370884689; 
 Fri, 30 Oct 2026 07:34:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4914:b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e6e5008b4mr6301815f8f.26.1793370884360; 
 Fri, 30 Oct 2026 07:34:44 -0700 (PDT)
Received: from seott-rh.redhat.corp
 (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm3102924f8f.59.2026.10.30.07.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:34:44 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 2/2] target/arm/cpu64: Define cpreg migration tolerance for
 PMMIR_EL1
Date: Fri, 30 Oct 2026 15:34:32 +0100
Message-ID: <20261030143435.57230-3-sebott@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030143435.57230-1-sebott@redhat.com>
References: <20261030143435.57230-1-sebott@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PMMIR_EL1 is exposed from Linux v7.3 onwards. Backward migration
to an older kernel would fail without cpreg migration tolerance
definition for this register.

Since qemu does not set KVM_ARM_VCPU_PMU_V3_STRICT the guest will
RAZ this register for both the old and new kernel.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 96aeb6c7a0..1547ad1cd3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -787,6 +787,14 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
                                      0, 0, ToleranceNotOnBothEnds);
 
+    /*
+     * PMMIR_EL1 was unconditionally exposed for linux 7.3 with commit
+     * 453f6ff04b8d ("KVM: arm64: Expose PMMIR_EL1.SLOTS under strict
+     * PMUv3 UAPI"). Tolerate backward migration to an older kernel.
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 9, 14, 6),
+                                     0, 0, ToleranceNotOnBothEnds);
+
     /*
      * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
      * from v6.15 onwards. Backward migration from a >= v6.15 to an older
-- 
2.56.0


