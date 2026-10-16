Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724CECCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaH-0007VD-Hb; Fri, 16 Oct 2026 09:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeY0-00069u-IV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:20 -0400
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXx-0007mI-BE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144093; bh=ZpVtpu4SyxPHs2h9wzmVMCToxxxyMwqpsBIIR9UlNYs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ko7e2+8p9Xm2P+44l9bkQp/gJKofW4bHDkA34cEgPa7gPdQ0sNr4gkMul1cjcBYsN
 /PVJT90Ro7G15JtaxSStHYvFgyssTxK6EUQ4Rg/qUsFmKbjNiofxB89fniOhkKwlrH
 J1BsE0eDRJiIYmOPE9kDzVBwBrGT2jii1gEjXGg8=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144090tmmvax2w2
Message-ID: <tencent_5414CB4CE9B1F60A7E9AC6041DE2F22D9B06@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uvP4r/eUtmqYI7Ja4clC0vXXOiaJA4kjBNc4AFhGkx7ABMDGxHx
 ruRkppUhZj8PeEUFuj6Uk9fOGLLQVBcQDRDrcZKHxjG8vgx2Kib7xPeY7u7VW86ztAsPasno8sla
 7d7p5DCBzC3eUZzrTIX9QAfizL4IQ309aJAmEFvKYFZbbwRc44J8HM17687WX5VNTmZvfucicDn4
 4hxkuNuD4L30iOi6MM6SREnzZxjPLbmTB0knJpZwd/xNRVx3kFqbI71m+0ZIOnZhRbC+ST30QBCK
 iXSdpkcE3oLtEv+rv+d9srt1pIoI9a7Ji17VnrYUqExprPM16MNcA/9GmvwQ+XAl3sixuwxgxkiw
 TfaMuCS+We0TR6QRWoJb3OwLuofBwZLPISlknAilHVCQFON0j6r5N4NFxPMVuk49UEZgIltkRUVg
 rpBQt8hTCM+RdzWqaV1VHhjU/DwIaIKZXnJ8TFTtOVWKsdEt6LH2DlkPv9x6vJCIWP6kCNCeJ2X2
 4eLEHCkuhKryaayMPfGZC+paNgzOqHotzefmUiGPCunJwbxcaKqEfQttai/g5/5Wx9WLYu63RTi8
 gAGAhKfeOFm5EORfu1Ps1lKZ5WyCB5GsJaY5C95bGZuBAHzff9qDy1nhsXifjlSk+PzTqYl7mmsX
 HQ4oj2s6lojSeC2WBTuqojWlUb7gqThHeV6e1HtY6HtXF57av6baXzxvzrH1bI7IWglA3HtGsxDr
 cGJWtRPiyOZvBjxBQmoXaXDPbqjhF9bl7+QLuFwyClZOXagdQjvvqh66Tzk+Ntu0mremsrrNCNl4
 kHADlXFPEOx3h1RTPvrWvMZvKIqIEs4LlOUCdFfOjR/yOiltzNJYMGqnWzXmL1hpw4VkaaIubZdQ
 SEfMAb9noOZIjbg5zXJ37LF5ZmgNoKfGu7xlAkfou7OoOlf1uKxJNUuN6wSRfY9kxh4P1EfuZm8F
 CMdZWdi3bSjxWrShjobcAB9ioIB7K7LtY2NAPM4zblax7KMYmWNyMmFbjJSKAz/USXeUXqkKk3KG
 DTrWJhfxTvD7arIIK6uAcq8tDUPoR9Ai+8kMbo60p4uZTn1UYCOkc5Uzy4RcWYKtfkxuVpH4eq4w
 Rl7MYv
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 16/37] hw/arm/mpam: Implement PARTID narrowing
Date: Fri, 16 Oct 2026 17:47:10 +0800
X-OQ-MSGID: <20261016094733.1898485-17-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.235; envelope-from=2118537295@qq.com;
 helo=out203-205-221-235.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:35 -0400
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

The MPAMCFG_INTPARTID register (0x600) was defined but never handled,
so a guest could not program the request PARTID to internal PARTID
mapping that PARTID narrowing is based on. Add read/write support:

- Writing MPAMCFG_INTPARTID stores the mapping for the request PARTID
  selected by MPAMCFG_PART_SEL; reads return the stored mapping.
- At realize, initialise the map to partid % num_int_partid so the
  indirection is always in range before a driver programs it,
  mirroring the Linux driver's fallback mapping. MBW_MAX also resets
  to 0xffff (full bandwidth) for every internal PARTID, matching
  hardware: an unprogrammed PARTID must not read as zero bandwidth.
- Clamp the narrowing indirection lookup to num_int_partid, and wrap
  MPAMCFG_PART_SEL writes into the supported PARTID space (the
  narrowed space for INTERNAL selectors) so a guest cannot trigger
  out-of-bounds accesses on the emulated arrays.

A guest driver can now exercise PARTID narrowing: several request
PARTIDs share one internal PARTID's configuration, and the guest can
re-map them at runtime.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 441356e..91d1c31 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -285,14 +285,18 @@ typedef struct MPAMMSCState {
 static uint32_t mpam_get_nrw_id(MPAMMSCState *s)
 {
     Mpamf *mpamf = &s->mpamf[s->ris];
+    uint32_t intpartid;
 
     if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
         return s->part_sel;
     }
     if (s->internal_part_sel) {
-        return s->part_sel;
+        intpartid = s->part_sel;
+    } else {
+        intpartid = mpamf->cfg_intpartid[s->part_sel];
     }
-    return mpamf->cfg_intpartid[s->part_sel];
+
+    return intpartid % s->num_int_partid;
 }
 
 typedef struct MPAMMSCMemState {
@@ -404,6 +408,17 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->esr;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
+    case A_MPAMF_MPAMCFG_INTPARTID: {
+        /*
+         * The map is only meaningful for resources that implement
+         * narrowing; others read as zero.
+         */
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
+            return 0;
+        }
+
+        return mpamf->cfg_intpartid[s->part_sel];
+    }
     case A_MPAMF_MPAMCFG_CMAX:
         if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
             qemu_log_mask(LOG_UNIMP,
@@ -482,12 +497,38 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                           s->num_ris);
             return;
         }
+        {
+            /*
+             * IHI 0099 7.2.1: the MSC does not check PARTID_SEL on write
+             * (the first IMPLEMENTATION DEFINED behaviour); the selector
+             * wraps into the supported PARTID space instead.
+             */
+            uint32_t limit = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL) ?
+                             s->num_int_partid : s->num_partid;
+
+            s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL,
+                                     PARTID_SEL) % limit;
+        }
         s->ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
-        s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, PARTID_SEL);
         s->internal_part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL);
         mpamf = &s->mpamf[s->ris];
         mpamf->cfg_part_sel = value;
         return;
+    case A_MPAMF_MPAMCFG_INTPARTID:
+        if (value & ~MPAMF_MPAMCFG_INTPARTID_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to INTPARTID Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_INTPARTID_WRITE_MASK, value);
+        }
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to INTPARTID when !HAS_PARTID_NRW\n");
+            return;
+        }
+
+        mpamf->cfg_intpartid[s->part_sel] =
+            FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID);
+        return;
     case A_MPAMF_MPAMCFG_CMAX:
         if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
@@ -619,8 +660,25 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
 
     s->mpamf = g_new0(Mpamf, s->num_ris);
     for (i = 0; i < s->num_ris; i++) {
+        int p;
+
         s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
         s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
+        /*
+         * Until resctrl programs the map, wrap each request PARTID onto an
+         * internal PARTID so the narrowing indirection is always in range.
+         */
+        for (p = 0; p < s->num_partid; p++) {
+            s->mpamf[i].cfg_intpartid[p] = p % s->num_int_partid;
+        }
+        /*
+         * per_nrw_id is indexed by INTERNAL PARTID: it has num_int_partid
+         * entries, not num_partid.
+         */
+        for (p = 0; p < s->num_int_partid; p++) {
+            /* MBW_MAX resets to full bandwidth on real hardware */
+            s->mpamf[i].per_nrw_id[p].cfg_mbw_max = 0xffff;
+        }
     }
 
     memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
-- 
2.43.0


