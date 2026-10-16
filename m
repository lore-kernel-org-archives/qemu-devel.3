Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7138CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHheE-00030T-6A; Fri, 16 Oct 2026 09:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf62-0004kW-5u; Fri, 16 Oct 2026 06:23:30 -0400
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf5z-00037d-RD; Fri, 16 Oct 2026 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146200; bh=P4QEWHWxu3smbmXGTdRl4D3hYj1Tmc5JUeNQNVV/GXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j2J0iqwoonXmQB6Y/HE/iFugjNNhIWa2QPZr5YQsiOw6Dsn5w6dwKbNu79KfctO9m
 c9u4WcTb6QZhLbBIiEAqG1fFG6HJxP4LqJ2T5kzAD0JqHZulrELKmouV4AAxsLMc8y
 Gv1G/sI4GeQL3xS090lYMIczQbjKuuSrIXRj/Gas=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 5D1998CC; Fri, 16 Oct 2026 18:23:17 +0800
X-QQ-mid: xmsmtpt1792146197ts5j1n7n3
Message-ID: <tencent_E465298E19C263CF95CFB481097FC4B25B07@qq.com>
X-QQ-XMAILINFO: NXatl/9/kmcOe3wy+VEszbEf28EQsUO76bs7lfNvwF/s4DlVU1VEFAnJOLzA+g
 3ndxsNDY+Nzcit8hkJdYkjHGwY3H9s8RQNdhviT0ag64eMT0v8c3OnSA71v8VSkPxC6PxwkE7FcH
 dGquo31YR8GolO/pa6S3A47wCO6xNZZ2E/9is1DH+2XIqAqfmmUuSgeT75Qkh5fg+rRy103KRxHh
 FTJilC64i9kIxVTZee5JBsKDwUKX/HD8dHhwrhXyMB3CJYs4cCh8XSMoaK7nnW3V4Mj0cZ6Bqklu
 oB0k7m4jGhGuJ+QXf/Vbz+i6Xs6pcl+1u405LgLDlXGmHH7o+mo3oAQOqbK+AdD1B5/KtCGVBaTd
 HHka+7xRNCtriD6OpMLzDVj0n/nJZ1QgeT+PIHIN9qUdNYxarmGJeyYIP7ZkOSjVEqzUtraXMQGs
 im1avYLGLM+LdjcuW/ENrJVVF8jMTviH1RCB3Vtbyu19MFVpbuZF2ILZmQOolhtW68+5s2NSkQ75
 nwdGuhkjMMLzIQzF/R58CzBL0YThbgYzh4WqtoKqtjmDE/dGu1cMytNwaPgsTpxA/s2ZdXNIwUpJ
 u214w/QsLQxezRDRZH1Y4riEMrw+8k0xUVWNwf6iA7zgoZtzfEZlVX0erglwnk03zGRgYCihC4zD
 Cpd9MaqGBSLhJYOp6Nrqnnxm9xBQWW0sBQXA8RxW0woevKRuXF0pgmWt5Y5tOcgNHQPDuT2wI82l
 ajsXIqQRJlwPZSi1Q8/1oHC2EZG2WixJSg3mCuAsbyfpyQgEdlH90CH/osLFEHip+t6lCtqCs5sL
 O/GsJlJYK6+doCo0bDOmMRC2JXwQUX8FIvc5cHcM0t0fWLojuVSddrt5c+0G9A7oLHwJHSy/mYfH
 1M0rZvxgRaFZWqCWyPh+ZM0IUoVS24/UlcHlz54LIRhEKtE1OCXwVJR7C2EysB9GBNWFr5wQ8pjM
 LM/hgQNbOM5r8GFYCxCmPWzsXbMi4cDcd2gftIEhaWFB7WxfaJz+9YNRMO6kBhHfHhxGjidMf8np
 eK8v+s/aOQUeUYC4C77S26BOJd76h9ewYQFZJG6lK6rOMYu43w+wqGM9vSKOfTTQEClgNoclFVNK
 ud/d3z
X-QQ-XMRINFO: NV153Ut7BKVGEBPxNGBppa2DJCr1urzIPw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 27/37] hw/arm/mpam: Advertise PRI on memory-side MSCs
Date: Fri, 16 Oct 2026 18:10:47 +0800
X-OQ-MSGID: <20261016101058.1900808-13-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.240; envelope-from=2118537295@qq.com;
 helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:45 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jinjie Ruan <ruanjinjie@huawei.com>

The arm_mpam driver picks the MBA-backing class for the MBPRI
pseudo-resource, which requires the memory-side MSC to advertise
HAS_PRI_PART -- without it the driver never exposes MBPRI even
though the register is handled.  Assemble the same PRI_IDR view
(INTPRI, 2 bits, 0 = low) as the cache subtype.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 1bd76ba..50c8a8e 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -991,6 +991,18 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
         /* Memory specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
+        /*
+         * Priority partitioning on the memory side too: the driver exposes
+         * the MBPRI pseudo-resource from the class backing MBA, which
+         * requires the memory-side MSC to advertise HAS_PRI_PART.
+         */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    HAS_INTPRI, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_0_IS_LOW, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_WD, 2);
 
         mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
                                       MPAMF_MSMON_IDR, MSMON_MBWU, 1);
-- 
2.43.0


