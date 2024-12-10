Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jt-0001Bw-Eg; Tue, 10 Dec 2024 11:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jr-0001Bk-G1
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jn-0004bn-JR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434e9716feaso20302845e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846726; x=1734451526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/byaHlenbv2G/58kQe+Mms4UB4dFjrLQEpUg62eOH5k=;
 b=AXbm+zmTi2rcI85CX29dDitS5RfY3pQYupMTZYVFdsgmTOb1sf5rfNfL6/fOQiFhlL
 mr1Lk15GKsbfAwmAKflopOvo1iYc/B1oqbBap2KDo+Cvt4QtU8Q3Z1PhdfWnzgR6pvHS
 lq+OE9j01Bpn6f68FJU18OlYiI05ZqeRO404dpjxdhv3xb4TX2ScsHHrWOH8I2RWaFHj
 ZAl+jPjXN/hEI+F5pdj/rMasFo82GMCjlMxAEqU6SuqgW76uFG6s0oPvkCfswxHG6HFR
 mRnkQndOuCdpReBw3++UFONsastXtLrIElcdJAGsb4yQ1DFKLu5qyVkJW8dvXxWVxR3p
 rZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846726; x=1734451526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/byaHlenbv2G/58kQe+Mms4UB4dFjrLQEpUg62eOH5k=;
 b=UsIM6esLdIDWtR/R0Oizf87DJxOEl+FOeAaZlD3mHrSA2UldXf72Ux/crnnSj0+k97
 llYn2Xl/GPt00oeBqhgV1U0MfKbdxPoTu1e7spe0Y0h8+Hf892fNGYQCwitGX7M0neUx
 1EyL9eKg9uHc4+mRmC7ErzFTCSot8ZtHi3ToZeG0UP+YylsehCttuouAqtiBTB92ueVV
 6aZrYVeqco95+xkwnnnMW72azBVQq/GCgO9Wx9uDmFai9r0uFhbFLeTeiwTq2R2uj7h2
 X1PIWFyDg5iTw7XTwTppUMUCfU3H2+fiOoLrvmNuWF57WlCO8ExyCNj6I9IeTzz3SP1G
 hS1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZm6iNw/VjLR71zaFIOZvm7a9/df6exazqraJNs6HDeylr+K3PpiAnmRGLZAApAQd0cbhFFnYXv625@nongnu.org
X-Gm-Message-State: AOJu0YzEv8Q8U5OHn9X/NKOxA6k3mvHcN2G31cKZVpPTDX7vCli1yYFd
 3yf6Ox/mh9X6hn3g86freYIJnw/tLft1gfxsSxlBv/oaV3iXB3afCqlJpwKhNgtKd2iomdfEiAe
 w
X-Gm-Gg: ASbGncsRszIECn1HxEycY1gswW0LC0HEnii1lOY4iEkZJGNoAlAsK0shPEkwpCqvBmV
 mR1z/a/sSSLa3Zj+klENtIwvFhR9CYH+XH7gzjDZAf9++BiUAzR3rSZLrjPDvscAmlG3F5O8HrX
 r3K3P0y7XLjGsgZoifgen626Iwa8qnVHkml66fBsveO8uHYx2YEEXXkogLuil9RgfjW+siWXeWk
 BRdkX6d8CL1nNXNEpOB9pr8UTDdr4wVoYyd2CIJcuXz2Jpp7jTSTvjVgXDZ
X-Google-Smtp-Source: AGHT+IGFhqYNCRBltJU9G8KVO/JHXHZc/6zsyuYsB9H6AeVLSMEk6YH3TrwC5E3WodAC4B1KsJlqbQ==
X-Received: by 2002:a05:600c:a0d:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-4361b085895mr6771635e9.31.1733846721907; 
 Tue, 10 Dec 2024 08:05:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/arm: Move TLBI range insns
Date: Tue, 10 Dec 2024 16:04:48 +0000
Message-Id: <20241210160452.2427965-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TLBI invalidate-range insns across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |   2 +
 target/arm/helper.c        | 330 +------------------------------------
 target/arm/tcg/tlb-insns.c | 329 ++++++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+), 328 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 722ac5bb884..fe838bcfd97 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1142,6 +1142,8 @@ CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
                            bool isread);
 CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
                              bool isread);
+CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
+                             bool isread);
 bool tlb_force_broadcast(CPUARMState *env);
 int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
                        uint64_t addr);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index baeabb5ec73..376aa9aecd5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -388,8 +388,8 @@ CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
 
 #ifdef TARGET_AARCH64
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
-static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    bool isread)
+CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
+                             bool isread)
 {
     if (arm_current_el(env) == 1 &&
         (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBOS))) {
@@ -4856,202 +4856,6 @@ int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
             : ARMMMUIdxBit_Stage2);
 }
 
-#ifdef TARGET_AARCH64
-typedef struct {
-    uint64_t base;
-    uint64_t length;
-} TLBIRange;
-
-static ARMGranuleSize tlbi_range_tg_to_gran_size(int tg)
-{
-    /*
-     * Note that the TLBI range TG field encoding differs from both
-     * TG0 and TG1 encodings.
-     */
-    switch (tg) {
-    case 1:
-        return Gran4K;
-    case 2:
-        return Gran16K;
-    case 3:
-        return Gran64K;
-    default:
-        return GranInvalid;
-    }
-}
-
-static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
-                                     uint64_t value)
-{
-    unsigned int page_size_granule, page_shift, num, scale, exponent;
-    /* Extract one bit to represent the va selector in use. */
-    uint64_t select = sextract64(value, 36, 1);
-    ARMVAParameters param = aa64_va_parameters(env, select, mmuidx, true, false);
-    TLBIRange ret = { };
-    ARMGranuleSize gran;
-
-    page_size_granule = extract64(value, 46, 2);
-    gran = tlbi_range_tg_to_gran_size(page_size_granule);
-
-    /* The granule encoded in value must match the granule in use. */
-    if (gran != param.gran) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
-                      page_size_granule);
-        return ret;
-    }
-
-    page_shift = arm_granule_bits(gran);
-    num = extract64(value, 39, 5);
-    scale = extract64(value, 44, 2);
-    exponent = (5 * scale) + 1;
-
-    ret.length = (num + 1) << (exponent + page_shift);
-
-    if (param.select) {
-        ret.base = sextract64(value, 0, 37);
-    } else {
-        ret.base = extract64(value, 0, 37);
-    }
-    if (param.ds) {
-        /*
-         * With DS=1, BaseADDR is always shifted 16 so that it is able
-         * to address all 52 va bits.  The input address is perforce
-         * aligned on a 64k boundary regardless of translation granule.
-         */
-        page_shift = 16;
-    }
-    ret.base <<= page_shift;
-
-    return ret;
-}
-
-static void do_rvae_write(CPUARMState *env, uint64_t value,
-                          int idxmap, bool synced)
-{
-    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
-    TLBIRange range;
-    int bits;
-
-    range = tlbi_aa64_get_range(env, one_idx, value);
-    bits = tlbbits_for_regime(env, one_idx, range.base);
-
-    if (synced) {
-        tlb_flush_range_by_mmuidx_all_cpus_synced(env_cpu(env),
-                                                  range.base,
-                                                  range.length,
-                                                  idxmap,
-                                                  bits);
-    } else {
-        tlb_flush_range_by_mmuidx(env_cpu(env), range.base,
-                                  range.length, idxmap, bits);
-    }
-}
-
-static void tlbi_aa64_rvae1_write(CPUARMState *env,
-                                  const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    /*
-     * Invalidate by VA range, EL1&0.
-     * Currently handles all of RVAE1, RVAAE1, RVAALE1 and RVALE1,
-     * since we don't support flush-for-specific-ASID-only or
-     * flush-last-level-only.
-     */
-
-    do_rvae_write(env, value, vae1_tlbmask(env),
-                  tlb_force_broadcast(env));
-}
-
-static void tlbi_aa64_rvae1is_write(CPUARMState *env,
-                                    const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    /*
-     * Invalidate by VA range, Inner/Outer Shareable EL1&0.
-     * Currently handles all of RVAE1IS, RVAE1OS, RVAAE1IS, RVAAE1OS,
-     * RVAALE1IS, RVAALE1OS, RVALE1IS and RVALE1OS, since we don't support
-     * flush-for-specific-ASID-only, flush-last-level-only or inner/outer
-     * shareable specific flushes.
-     */
-
-    do_rvae_write(env, value, vae1_tlbmask(env), true);
-}
-
-static void tlbi_aa64_rvae2_write(CPUARMState *env,
-                                  const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    /*
-     * Invalidate by VA range, EL2.
-     * Currently handles all of RVAE2 and RVALE2,
-     * since we don't support flush-for-specific-ASID-only or
-     * flush-last-level-only.
-     */
-
-    do_rvae_write(env, value, vae2_tlbmask(env),
-                  tlb_force_broadcast(env));
-
-
-}
-
-static void tlbi_aa64_rvae2is_write(CPUARMState *env,
-                                    const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    /*
-     * Invalidate by VA range, Inner/Outer Shareable, EL2.
-     * Currently handles all of RVAE2IS, RVAE2OS, RVALE2IS and RVALE2OS,
-     * since we don't support flush-for-specific-ASID-only,
-     * flush-last-level-only or inner/outer shareable specific flushes.
-     */
-
-    do_rvae_write(env, value, vae2_tlbmask(env), true);
-
-}
-
-static void tlbi_aa64_rvae3_write(CPUARMState *env,
-                                  const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    /*
-     * Invalidate by VA range, EL3.
-     * Currently handles all of RVAE3 and RVALE3,
-     * since we don't support flush-for-specific-ASID-only or
-     * flush-last-level-only.
-     */
-
-    do_rvae_write(env, value, ARMMMUIdxBit_E3, tlb_force_broadcast(env));
-}
-
-static void tlbi_aa64_rvae3is_write(CPUARMState *env,
-                                    const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    /*
-     * Invalidate by VA range, EL3, Inner/Outer Shareable.
-     * Currently handles all of RVAE3IS, RVAE3OS, RVALE3IS and RVALE3OS,
-     * since we don't support flush-for-specific-ASID-only,
-     * flush-last-level-only or inner/outer specific flushes.
-     */
-
-    do_rvae_write(env, value, ARMMMUIdxBit_E3, true);
-}
-
-static void tlbi_aa64_ripas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                     uint64_t value)
-{
-    do_rvae_write(env, value, ipas2e1_tlbmask(env, value),
-                  tlb_force_broadcast(env));
-}
-
-static void tlbi_aa64_ripas2e1is_write(CPUARMState *env,
-                                       const ARMCPRegInfo *ri,
-                                       uint64_t value)
-{
-    do_rvae_write(env, value, ipas2e1_tlbmask(env, value), true);
-}
-#endif
-
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
@@ -7312,133 +7116,6 @@ static const ARMCPRegInfo pauth_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
 };
 
-static const ARMCPRegInfo tlbirange_reginfo[] = {
-    { .name = "TLBI_RVAE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAAE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAAE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-   { .name = "TLBI_RVALE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVALE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAALE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAALE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAAE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAAE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-   { .name = "TLBI_RVALE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVALE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAALE1OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAALE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RVAAE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAAE1,
-      .writefn = tlbi_aa64_rvae1_write },
-   { .name = "TLBI_RVALE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVALE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RVAALE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIRVAALE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1is_write },
-    { .name = "TLBI_RIPAS2LE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1is_write },
-    { .name = "TLBI_RVAE2IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-   { .name = "TLBI_RVALE2IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-    { .name = "TLBI_RIPAS2E1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 2,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1_write },
-    { .name = "TLBI_RIPAS2LE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1_write },
-   { .name = "TLBI_RVAE2OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-   { .name = "TLBI_RVALE2OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-    { .name = "TLBI_RVAE2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2_write },
-   { .name = "TLBI_RVALE2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2_write },
-   { .name = "TLBI_RVAE3IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVALE3IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVAE3OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVALE3OS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVAE3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3_write },
-   { .name = "TLBI_RVALE3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3_write },
-};
-
 static const ARMCPRegInfo tlbios_reginfo[] = {
     { .name = "TLBI_VMALLE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 0,
@@ -9389,9 +9066,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
-    if (cpu_isar_feature(aa64_tlbirange, cpu)) {
-        define_arm_cp_regs(cpu, tlbirange_reginfo);
-    }
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 528265404de..a273c6f4b58 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -6,6 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -562,6 +563,329 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
+#ifdef TARGET_AARCH64
+typedef struct {
+    uint64_t base;
+    uint64_t length;
+} TLBIRange;
+
+static ARMGranuleSize tlbi_range_tg_to_gran_size(int tg)
+{
+    /*
+     * Note that the TLBI range TG field encoding differs from both
+     * TG0 and TG1 encodings.
+     */
+    switch (tg) {
+    case 1:
+        return Gran4K;
+    case 2:
+        return Gran16K;
+    case 3:
+        return Gran64K;
+    default:
+        return GranInvalid;
+    }
+}
+
+static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
+                                     uint64_t value)
+{
+    unsigned int page_size_granule, page_shift, num, scale, exponent;
+    /* Extract one bit to represent the va selector in use. */
+    uint64_t select = sextract64(value, 36, 1);
+    ARMVAParameters param = aa64_va_parameters(env, select, mmuidx, true, false);
+    TLBIRange ret = { };
+    ARMGranuleSize gran;
+
+    page_size_granule = extract64(value, 46, 2);
+    gran = tlbi_range_tg_to_gran_size(page_size_granule);
+
+    /* The granule encoded in value must match the granule in use. */
+    if (gran != param.gran) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
+                      page_size_granule);
+        return ret;
+    }
+
+    page_shift = arm_granule_bits(gran);
+    num = extract64(value, 39, 5);
+    scale = extract64(value, 44, 2);
+    exponent = (5 * scale) + 1;
+
+    ret.length = (num + 1) << (exponent + page_shift);
+
+    if (param.select) {
+        ret.base = sextract64(value, 0, 37);
+    } else {
+        ret.base = extract64(value, 0, 37);
+    }
+    if (param.ds) {
+        /*
+         * With DS=1, BaseADDR is always shifted 16 so that it is able
+         * to address all 52 va bits.  The input address is perforce
+         * aligned on a 64k boundary regardless of translation granule.
+         */
+        page_shift = 16;
+    }
+    ret.base <<= page_shift;
+
+    return ret;
+}
+
+static void do_rvae_write(CPUARMState *env, uint64_t value,
+                          int idxmap, bool synced)
+{
+    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
+    TLBIRange range;
+    int bits;
+
+    range = tlbi_aa64_get_range(env, one_idx, value);
+    bits = tlbbits_for_regime(env, one_idx, range.base);
+
+    if (synced) {
+        tlb_flush_range_by_mmuidx_all_cpus_synced(env_cpu(env),
+                                                  range.base,
+                                                  range.length,
+                                                  idxmap,
+                                                  bits);
+    } else {
+        tlb_flush_range_by_mmuidx(env_cpu(env), range.base,
+                                  range.length, idxmap, bits);
+    }
+}
+
+static void tlbi_aa64_rvae1_write(CPUARMState *env,
+                                  const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * Invalidate by VA range, EL1&0.
+     * Currently handles all of RVAE1, RVAAE1, RVAALE1 and RVALE1,
+     * since we don't support flush-for-specific-ASID-only or
+     * flush-last-level-only.
+     */
+
+    do_rvae_write(env, value, vae1_tlbmask(env),
+                  tlb_force_broadcast(env));
+}
+
+static void tlbi_aa64_rvae1is_write(CPUARMState *env,
+                                    const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    /*
+     * Invalidate by VA range, Inner/Outer Shareable EL1&0.
+     * Currently handles all of RVAE1IS, RVAE1OS, RVAAE1IS, RVAAE1OS,
+     * RVAALE1IS, RVAALE1OS, RVALE1IS and RVALE1OS, since we don't support
+     * flush-for-specific-ASID-only, flush-last-level-only or inner/outer
+     * shareable specific flushes.
+     */
+
+    do_rvae_write(env, value, vae1_tlbmask(env), true);
+}
+
+static void tlbi_aa64_rvae2_write(CPUARMState *env,
+                                  const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * Invalidate by VA range, EL2.
+     * Currently handles all of RVAE2 and RVALE2,
+     * since we don't support flush-for-specific-ASID-only or
+     * flush-last-level-only.
+     */
+
+    do_rvae_write(env, value, vae2_tlbmask(env),
+                  tlb_force_broadcast(env));
+
+
+}
+
+static void tlbi_aa64_rvae2is_write(CPUARMState *env,
+                                    const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    /*
+     * Invalidate by VA range, Inner/Outer Shareable, EL2.
+     * Currently handles all of RVAE2IS, RVAE2OS, RVALE2IS and RVALE2OS,
+     * since we don't support flush-for-specific-ASID-only,
+     * flush-last-level-only or inner/outer shareable specific flushes.
+     */
+
+    do_rvae_write(env, value, vae2_tlbmask(env), true);
+
+}
+
+static void tlbi_aa64_rvae3_write(CPUARMState *env,
+                                  const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * Invalidate by VA range, EL3.
+     * Currently handles all of RVAE3 and RVALE3,
+     * since we don't support flush-for-specific-ASID-only or
+     * flush-last-level-only.
+     */
+
+    do_rvae_write(env, value, ARMMMUIdxBit_E3, tlb_force_broadcast(env));
+}
+
+static void tlbi_aa64_rvae3is_write(CPUARMState *env,
+                                    const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    /*
+     * Invalidate by VA range, EL3, Inner/Outer Shareable.
+     * Currently handles all of RVAE3IS, RVAE3OS, RVALE3IS and RVALE3OS,
+     * since we don't support flush-for-specific-ASID-only,
+     * flush-last-level-only or inner/outer specific flushes.
+     */
+
+    do_rvae_write(env, value, ARMMMUIdxBit_E3, true);
+}
+
+static void tlbi_aa64_ripas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    do_rvae_write(env, value, ipas2e1_tlbmask(env, value),
+                  tlb_force_broadcast(env));
+}
+
+static void tlbi_aa64_ripas2e1is_write(CPUARMState *env,
+                                       const ARMCPRegInfo *ri,
+                                       uint64_t value)
+{
+    do_rvae_write(env, value, ipas2e1_tlbmask(env, value), true);
+}
+
+static const ARMCPRegInfo tlbirange_reginfo[] = {
+    { .name = "TLBI_RVAE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 1,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAE1IS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAAE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAAE1IS,
+      .writefn = tlbi_aa64_rvae1is_write },
+   { .name = "TLBI_RVALE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVALE1IS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAALE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAALE1IS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAE1OS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAAE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAAE1OS,
+      .writefn = tlbi_aa64_rvae1is_write },
+   { .name = "TLBI_RVALE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVALE1OS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAALE1OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAALE1OS,
+      .writefn = tlbi_aa64_rvae1is_write },
+    { .name = "TLBI_RVAE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAE1,
+      .writefn = tlbi_aa64_rvae1_write },
+    { .name = "TLBI_RVAAE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAAE1,
+      .writefn = tlbi_aa64_rvae1_write },
+   { .name = "TLBI_RVALE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVALE1,
+      .writefn = tlbi_aa64_rvae1_write },
+    { .name = "TLBI_RVAALE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIRVAALE1,
+      .writefn = tlbi_aa64_rvae1_write },
+    { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ripas2e1is_write },
+    { .name = "TLBI_RIPAS2LE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ripas2e1is_write },
+    { .name = "TLBI_RVAE2IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2is_write },
+   { .name = "TLBI_RVALE2IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2is_write },
+    { .name = "TLBI_RIPAS2E1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 2,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ripas2e1_write },
+    { .name = "TLBI_RIPAS2LE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ripas2e1_write },
+   { .name = "TLBI_RVAE2OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2is_write },
+   { .name = "TLBI_RVALE2OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2is_write },
+    { .name = "TLBI_RVAE2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2_write },
+   { .name = "TLBI_RVALE2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_rvae2_write },
+   { .name = "TLBI_RVAE3IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3is_write },
+   { .name = "TLBI_RVALE3IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3is_write },
+   { .name = "TLBI_RVAE3OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3is_write },
+   { .name = "TLBI_RVALE3OS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3is_write },
+   { .name = "TLBI_RVAE3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3_write },
+   { .name = "TLBI_RVALE3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_rvae3_write },
+};
+#endif
+
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -591,4 +915,9 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
     }
+#ifdef TARGET_AARCH64
+    if (cpu_isar_feature(aa64_tlbirange, cpu)) {
+        define_arm_cp_regs(cpu, tlbirange_reginfo);
+    }
+#endif
 }
-- 
2.34.1


