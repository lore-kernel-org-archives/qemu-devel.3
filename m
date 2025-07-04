Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62607C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjHB-0002y9-Ck; Fri, 04 Jul 2025 12:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFZ-0005ky-J8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFW-0006yn-AV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so7312435e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646412; x=1752251212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DkTSO4+nXD9QRlGDotIAv2dmeYUwEn5geWqK1xGsZLQ=;
 b=WcEGePZOdxLf1KjwT+UHGOdPW2hm1ssnzhsxZgPr9uVx6k+N4K9GB2nDxeu1gp4oU2
 a2yQlNqVqTIocrWq4P9TaiRO3t44zj4rmIM7vlMtzLHyk1pbOqTxwz3KL/7dtRBraMeH
 ESpod8MawkP2z+yUKES2DAF6AX9TJU8xvdtUaL6EjvpBCRoGJl3negRlriJw+y+kNUM8
 5FTMbvfN0T7pa9QBOqj60Pgs+Z4VygzKBMZ1j84EjbX32zK/2ooi1QTa1Zi1849KOo5n
 92MP1TqCuLzt1RA73VpiMjixtQtyiDqwaCGtRIKlf+tn55b68wmEMOqVlQE2GSoGsd0n
 zA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646412; x=1752251212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkTSO4+nXD9QRlGDotIAv2dmeYUwEn5geWqK1xGsZLQ=;
 b=sSxpQ/Y/o8ICQf+Mg31Bym2JHgiAHqVdBMqDnPxDPMPQ699XTVUI29AZIoNYEKBbP9
 wjT4BuoW3U7RsAa8YApubiuQUUQnJIR5sCWY9DQogkzRu+DedMEt9xCAy6waShmeZR+T
 +Mq9zq8uibmSqsj8QmCPfvutpmMvdVEU23yWmEDZO7OSLrX9RkXinaOdZlxKAQPVucfS
 XV7vMHGObehBHmN9x5opEAKqnrPzq8vOGtIuZoofKwwndL/dL1YVTGKzQCYdN4OPvOue
 mWbOqKs2JxVQSjk+4qm9fNRvRHcziMGnQO4xCmRg2u/1ielALCpbKCOUd+7sTxxkJsqi
 3EXA==
X-Gm-Message-State: AOJu0YyJzWBFuVI+g6Ooi2WuTdU53e+03phYMT++wrPUSiwZ/p9frfVw
 Z6teGzodSMg2W7BfNAzZSyqEgqQZPOZryVFMJgDuLQZNBvbRBNtgMXhSZbPHs3yShaXy7zjwVS9
 SJ7BB
X-Gm-Gg: ASbGncuCfNK6gbA7nUILMNJuHTwjrFcyzwGRqUtLzRwh2MFud8vc2O6CmcPSGoFlVhn
 ZDC0oZ36N/pPHzo1+Wds+DfJ65PSx8uPX5riPlw3YmAIX+FXsFFFhXQYOZB4szBHAWT45+oRS74
 n6HQuftp4u9OC6cI2qCoDN/Koo7Ef1F4Tf34MmhvPy8ts+nVkYh7vqRCgZYS1B2im8136WCDsoh
 26q/Kxp6NRfQLM5NbLCo5y1b6FciDyaggKfgGRxZ+IU/pYNoZe4u4qu2UucKljSGEr9eyLqo6Ps
 kiwWT7ACG39UXGctYpbSFRBNsNhTcS/G8AhQOVf8dzvUeHl07/MP5rCcArNOTnE0CIOh0ZrmcyO
 R9C4=
X-Google-Smtp-Source: AGHT+IG4y/+A4ynRghbfU/hh4756nsy1D2KIfsj8lKeR5TyB6k6B8NVn7DZTYBiAn9S/PLd4cowMxw==
X-Received: by 2002:a05:600c:6819:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-454b3116294mr30595725e9.11.1751646412330; 
 Fri, 04 Jul 2025 09:26:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 116/119] target/arm: Implement FMOPA (non-widening) for fp16
Date: Fri,  4 Jul 2025 17:24:56 +0100
Message-ID: <20250704162501.249138-117-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-105-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/sme_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  4 +++
 4 files changed, 63 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 2b22c6aee50..fac70a82b92 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -137,6 +137,8 @@ DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
@@ -146,6 +148,8 @@ DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
@@ -155,6 +159,8 @@ DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8ad86f707ed..3c58fdd2a0e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -183,9 +183,11 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 ### SME Outer Product
 
 &op             zad zn zm pm pn sub:bool
+@op_16          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 ... zad:1 &op
 @op_32          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .. zad:2 &op
 @op_64          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .  zad:3 &op
 
+FMOPA_h         10000001 100 ..... ... ... ..... . 100 .        @op_16
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index eff0ce74808..d23d9f08d29 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1002,6 +1002,57 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
     }
 }
 
+static void do_fmopa_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                       uint16_t *pm, float_status *fpst, uint32_t desc,
+                       uint16_t negx, int negf)
+{
+    intptr_t row, col, oprsz = simd_maxsz(desc);
+
+    for (row = 0; row < oprsz; ) {
+        uint16_t pa = pn[H2(row >> 4)];
+        do {
+            if (pa & 1) {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint16_t n = *(uint32_t *)(vzn + H1_2(row)) ^ negx;
+
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pb = pm[H2(col >> 4)];
+                    do {
+                        if (pb & 1) {
+                            uint16_t *a = vza_row + H1_2(col);
+                            uint16_t *m = vzm + H1_2(col);
+                            *a = float16_muladd(n, *m, *a, negf, fpst);
+                        }
+                        col += 2;
+                        pb >>= 2;
+                    } while (col & 15);
+                }
+            }
+            row += 2;
+            pa >>= 2;
+        } while (row & 15);
+    }
+}
+
+void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 15, 0);
+}
+
+void HELPER(sme_ah_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                            void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+               float_muladd_negate_product);
+}
+
 static void do_fmopa_s(void *vza, void *vzn, void *vzm, uint16_t *pn,
                        uint16_t *pm, float_status *fpst, uint32_t desc,
                        uint32_t negx, int negf)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 782f4080611..119a5665e67 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -569,6 +569,10 @@ TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a, MO_32,
            !a->sub ? gen_helper_sme_fmopa_w_h
            : !s->fpcr_ah ? gen_helper_sme_fmops_w_h
            : gen_helper_sme_ah_fmops_w_h)
+TRANS_FEAT(FMOPA_h, aa64_sme_f16f16, do_outprod_fpst, a, MO_16, FPST_ZA_F16,
+           !a->sub ? gen_helper_sme_fmopa_h
+           : !s->fpcr_ah ? gen_helper_sme_fmops_h
+           : gen_helper_sme_ah_fmops_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, FPST_ZA,
            !a->sub ? gen_helper_sme_fmopa_s
            : !s->fpcr_ah ? gen_helper_sme_fmops_s
-- 
2.43.0


