Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D3C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3TCZ-0004Bu-MF; Mon, 07 Sep 2026 02:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x3TCV-0004BK-Ua
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:51:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x3TCS-0007Xh-SE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:51:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873lKDN3235998
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 06:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=HvmaV8KpE6wqDkVL2IEgsLu+LOW/CDfli5c
 WaaGM8Vg=; b=e6cafz5Fvyy8RbKCWVNZ27XsDgGBW9boQ753DHCIEVQBR2COLdV
 aB84bVZyk8hgSLrYyAgBsep778uE9GVQXdwvF9wGwDH7RJNuG92DWHvsfbdvhlFf
 oX0vB0BXW1jYVzu7fjqTo3B2mrqxPRibDgUrTT4ABUpnti+myr09xiHu8ml/sFgr
 1J4YA9M4t6iZUG1G0/DSofzMAlIZxd1khBqpWyi3XhkiL6OXcvfo/TJJYOIMVktw
 eb/teH4O1TPD0f9m+b8dAQ2B9HYGkZ5cCwqNotFduyR0yKjEL1pyO/SwNWinywTF
 owEMfzDgndSYokMNUjKrVWB8vTBJWtDPBbA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga375k25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:51:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso4391751a91.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788763883; x=1789368683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvmaV8KpE6wqDkVL2IEgsLu+LOW/CDfli5cWaaGM8Vg=;
 b=YTbPiI9ixHPyvOKO/R7m7PyME13WrqMZimHJtaB1S/agRa0MCtXEd88MCtaoG3th1W
 hj2JNASJ9z3qAF1TwrIXupiys+7buQBtJ8EICjKugzSSBUmThv5onVWsVQ1yTMWFeglg
 sgEUgqiDY05VaszAHwqLm2YPhFGY21Ht+IZOo/IZjbsRGV47c0Cx38cc82T2PFqakupk
 LWZdr3Uiwvci7RqEPBK3RlmE65T4p/ri389W3Bf/vUlYlhcQnv/DwDQNwFaBkBttUhB2
 YAOQNs2EXLdHV4Xkvss27ExLofj42RrcEbzJBQJ4KY8LFuNzARsojBiYYfqbL8qEyafp
 ceiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763883; x=1789368683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvmaV8KpE6wqDkVL2IEgsLu+LOW/CDfli5cWaaGM8Vg=;
 b=T+ALyrY5ULxQkqakz34wZnreuQC14jp+iuiFjZfvQm6uL9N2jRwqxlR86fhOdYN9W+
 PVjnVnOuH4CLxEhBsQgwI2KlUr0X3lyfMdgE3us+7fJmbcntAkWZ3bC97OtJC6rh+7lM
 JSsPjqXddh+K17mXrHYFqrd1M0jeJcqHHIzFFqmrsR8TBF6elGKBNaawbnA0jbgIQsBz
 OqYgUJTmzeEeCKeUJetK3D6aBColnIHLKIXylg1sUTmfUKyqjGpddxup58sjOQeiRVXL
 oHSrdLy4jsVml8OuLutuV80iddW1LKLl1wkyKQY8p6IJvUWkOwPnybu0xvnntvUgJR0P
 5GEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSoA8lbGK5sSjpUg1kc7Re8I/k2N8fHs8dk73rduOFs1fLbO9uO9gEcc53ygccX+T80TmVg4nPrDcO@nongnu.org
X-Gm-Message-State: AFuF++me6kX8pKC5s/A2UPYVs2nm1NWKxFpnI1Xvo0DHISWgzIgNuPID
 Nhd2Q7FYaxHpXFKN6YR0BpyoWIhvHPvjfXWGGo0nA6r9fImH1abuxxJfjdwDJUJ9TWBkn43P+4m
 dvr4ArcAEhewqhEx+CTBgO6CeqUfZL/uTcrFZRfbORqhH9k+UEi9tqX0hrQ==
X-Gm-Gg: AYBFou19ZK0q5n8PdMq+mPPJPETOxGvwB0+NInJP9PmEZstN9pwn8mqucwj6+stiRnN
 iBgSItXo0YPQmhOtVohbtnZUXPqi8kgq5YvYN3Id1iS/ofWdmHf/K5ZS8XqvJT7JNsOe1atLsqA
 PxdUthNILICz1+tNT1n/EZ7DRI4cPuLid0DzaaibmxyHBCgU8Oz2AwewWPFInM/T8H2bght4IuH
 eVzcF0yhbr9DlRcNYpRKoNwZA3Nn5CyMlyUcy27+VWxbz7yGB9c0inGtlEVhEtAmFZXu0+zHQjI
 DlMS4aPaYXdQR7Gx9nLLpKj956cKVK830ETlVFlXNe+89o0nuSTYJSh8i8/m4Gs/cxkQX3ARS3x
 NphSalpRhifFUtqNqRf8DMKBQeHNsohvtaGDM6NDpfKU8cuhdLMf9CYslCMHzK7dKo3OlrXiVAs
 l9uOQQCk4nhaHCoOVW81p84PpL7A==
X-Received: by 2002:a17:90b:4ac5:b0:398:9beb:a2ba with SMTP id
 98e67ed59e1d1-39b087fb503mr30446614a91.28.1788763883346; 
 Sun, 06 Sep 2026 23:51:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac5:b0:398:9beb:a2ba with SMTP id
 98e67ed59e1d1-39b087fb503mr30446575a91.28.1788763882814; 
 Sun, 06 Sep 2026 23:51:22 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm39437142eec.15.2026.09.06.23.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:51:22 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Gong Shuai <gsh517025@gmail.com>,
 TianCheng TANG <lyndra@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] target/riscv: Fix LCOFI interrupt masking in sie/sip/mvip
Date: Mon,  7 Sep 2026 12:21:10 +0530
Message-ID: <20260907065112.2287127-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1exjIkZ3omrPQ82ALe7UcbWddqI2Tare
X-Proofpoint-ORIG-GUID: 1exjIkZ3omrPQ82ALe7UcbWddqI2Tare
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a9e5eec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=pY6yUR2m6-QEIg0VTF4A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfX883QrFUGxEHd
 iYPxtE1QgrpjWVIK4Lg9qQpT3BkW56+AduXIVg/0UnInJjlez+bG7rzH3cIHmhGwmL4QQ8xgsYb
 CvMYSLGgIN+JXgfkP4i5cw3yjf1P/Lw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfXwqdem9ED5QgA
 fIpF9+ZXuZkBBDeWqO93UnrSS9UDLxMD8+HU5K8zxbvcW0QvNuS+vPVvSwrJyz4XUwpcDvjR9k7
 YAUqnLUhlLZ+wc4+4B1u5nFRrP5Bu+g9e/GDPZspEtwQt/XBPUpnNsKvMHb7B9/blydvKTBNg3g
 xFMQ+uzvcqJVnnITYHbHJQ/BMEBywYAwTG6peOb9lB2IGSfiiySG2PA3eOjusi1weyWEwjeV7zE
 35FZ/mXWnM9ggBq0rLMPuhMLt7W33wi/DNPK1ko0Rh4X2xalBBJyRxdEYW3tF5kuHTvV7d6U/K5
 4uwKh1wGUJHxzyILw7ezeLtO4c5h5SEgl6B5e4WcXQvTaDKfEkF9PpKPXnVRSpqGeKNVWHJk0K9
 cLgauuMEXjVMUpSOzKOOsv8gG2EGERqEsy0bVcymIp9MRXmS601UZW0So2mWppmQSSLYOyD3Dnl
 ceJzny0YEdruYhn5mEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

Commit 27f9566dcd98 dropped bit 13 (MIP_LCOFIP) from the LOCAL_INTERRUPTS
macro and hence also from individual masks such as all_ints,
sip_writable_mask etc.

As a result, with Sscofpmf enabled and LCOFIP delegated to S-mode, the
overflow interrupt was raised in mip but was not visible in sip and it
never got delivered to the PMU driver. For the same reason, sie.LCOFIE
also became read-only 0.

Add back bit 13 in the affected masks, but gate it on Sscofpmf being
implemented. In addition, for the virtual interrupt path, mvip/mvien
LCOFI also requires Smcdeleg and Smaia to be implemented. Also make
LCOFI delegable only if Sscofpmf is implemented.

Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
Suggested-by: Gong Shuai <gsh517025@gmail.com>
Suggested-by: TianCheng TANG <lyndra@linux.alibaba.com>
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
v2:
- Fix the sip.LCOFIP read-back mask in rmw_sip64() so that it matches
  the write path.
- Gate LCOFI on the Sscofpmf, Smcdeleg and Smaia extensions, depending
  on the register being accessed and on whether it is the virtual
  interrupt path.

 target/riscv/tcg/csr.c | 59 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 002f7e69c1..966a0897bb 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1812,7 +1812,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
-    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
+    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS;
 static const uint64_t vs_delegable_ints =
     (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
@@ -1874,6 +1874,25 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
 static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
+static bool lcofi_present(CPURISCVState *env, bool virt_int)
+{
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+
+    if (!cfg->ext_sscofpmf) {
+        return false;
+    }
+
+    /*
+     * For the virtual interrupts path, we also need to check if smcdeleg and
+     * smaia are both implemented.
+     */
+    if (virt_int && !(cfg->ext_smcdeleg && cfg->ext_smaia)) {
+        return false;
+    }
+
+    return true;
+}
+
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
                                 target_ulong *val)
@@ -2248,6 +2267,10 @@ static RISCVException rmw_mideleg64(CPURISCVState *env, int csrno,
 {
     uint64_t mask = wr_mask & delegable_ints;
 
+    if (lcofi_present(env, false)) {
+        mask |= wr_mask & MIP_LCOFIP;
+    }
+
     if (ret_val) {
         *ret_val = env->mideleg;
     }
@@ -2299,6 +2322,10 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
 {
     uint64_t mask = wr_mask & all_ints;
 
+    if (lcofi_present(env, false)) {
+        mask |= wr_mask & MIP_LCOFIP;
+    }
+
     if (ret_val) {
         *ret_val = env->mie;
     }
@@ -2349,6 +2376,10 @@ static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
 {
     uint64_t mask = wr_mask & mvien_writable_mask;
 
+    if (lcofi_present(env, true)) {
+        mask |= wr_mask & MIP_LCOFIP;
+    }
+
     if (ret_val) {
         *ret_val = env->mvien;
     }
@@ -3784,6 +3815,10 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    if (lcofi_present(env, false)) {
+        mask |= wr_mask & MIP_LCOFIP;
+    }
+
     /*
      * When mvien[9]=1, mip.SEIP is read-only and reflects only
      * the external interrupt signal from the interrupt controller.
@@ -3897,9 +3932,11 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
      *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
      *  that come from hvip.
      */
-    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    bool virt_int = (csrno == CSR_MVIP) || (csrno == CSR_MVIPH);
+    uint64_t lcofi_mask = lcofi_present(env, virt_int) ? MIP_LCOFIP : 0;
+    uint64_t alias_mask = ((S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS) &
         (env->mideleg | ~env->mvien)) | MIP_STIP;
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
     uint64_t wr_mask_mvip;
     uint64_t wr_mask_mip;
@@ -3928,8 +3965,8 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
         alias_mask &= ~MIP_STIP;
     }
 
-    wr_mask_mip = wr_mask & alias_mask & mvip_writable_mask;
-    wr_mask_mvip = wr_mask & nalias_mask & mvip_writable_mask;
+    wr_mask_mip = wr_mask & alias_mask & (mvip_writable_mask | lcofi_mask);
+    wr_mask_mvip = wr_mask & nalias_mask & (mvip_writable_mask | lcofi_mask);
 
     /*
      * For bits set in alias_mask, mvip needs to be alias of mip, so forward
@@ -4132,9 +4169,11 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
                                 uint64_t *ret_val,
                                 uint64_t new_val, uint64_t wr_mask)
 {
-    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
+    uint64_t lcofi_mask = lcofi_present(env, false) ? MIP_LCOFIP : 0;
+    uint64_t nalias_mask = (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS) &
         (~env->mideleg & env->mvien);
-    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
+    uint64_t alias_mask = (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS) &
+        env->mideleg;
     uint64_t sie_mask = wr_mask & nalias_mask;
     RISCVException ret;
 
@@ -4379,7 +4418,9 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
                                 uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
-    uint64_t mask = (env->mideleg | env->mvien) & sip_writable_mask;
+    uint64_t lcofi_mask = lcofi_present(env, false) ? MIP_LCOFIP : 0;
+    uint64_t mask = (env->mideleg | env->mvien) &
+                    (sip_writable_mask | lcofi_mask);
 
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -4392,7 +4433,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
 
     if (ret_val) {
         *ret_val &= (env->mideleg | env->mvien) &
-            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
+            (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS);
     }
 
     return ret;

base-commit: a925240509d1b4b656cc480f1cc79ba4d7c8bc08
-- 
2.43.0


