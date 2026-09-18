Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EA2C982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ag6-0006bx-SJ; Fri, 18 Sep 2026 11:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afz-0006Xn-Uw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:39:00 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afx-0003Gg-C3
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:59 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b78so836106e87.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745936; x=1790350736; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jwuu7aER9TfTIp7E9BxZvmKdyfieH7jGY+kASlRLGsU=;
 b=b/KrQMMdupOWA+cZeWj6N1fylsnx614reLfWy9n3YDs6tmUIK/O2lrwLXnaH4mC71H
 s1UlqaEL0/8wJTEmUotL4K3jlr3OYscI2k/7w66QRkO7Rt9RUpNDWC4y4hv7ipirW5rL
 uH2wuxQySHmeiu4UfIdxaB7WNrYKpeFvJ2NUXTTTNS+nNYS5a28OJuSnX/nfbXQt3V/E
 hJyMPQfuG31O41es/czXdOQt9TZWmTaqCMsZllICTosv540Zc5+VKZCSVxEvneNl7sBD
 zJtQe8mfdY0l3Zo6Kb8u2zaVI3vyDBdQaH4KyP4xVnm7z4469j6ct0X28YtAMoN47QMr
 lqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745936; x=1790350736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jwuu7aER9TfTIp7E9BxZvmKdyfieH7jGY+kASlRLGsU=;
 b=EtwPyTVaF2+p737dbNOWPauiCx9iMV4LvuXfCdmCYWIO4AvRo766QpDERihbX6CFwp
 Z6asXzlQE9HjsoVQox/ZzSQw/aUGJ3d/e+q/QhUHTZR7lOtD5XyL4inikiniXyC7VgN9
 hK1g3HF4pBmRtAY26AfFwWwI18eis4xYLIZlsO0Ar4ACRmvulYnge4OVmYRewxZy2V2J
 vTQrcX76uT2fi4OydS1+JzbU5D+sfaJ+aCA+DhMPrpMNSPHW52HT/Kcagr1SrzBRE0Ds
 xRxsXisLRY18kgF7GBg/CG/pMXvoyyVOSxlHScUOLb0/Qq6I3AKOJ07Pp1jVaoodSmep
 XzQA==
X-Gm-Message-State: AFuF++nh4Ap7oC58q8+u3SgFp0WG3fUUfTQqr+70hgcpQ4nbizcRB3bV
 K35KO1qQRKa3rvDTTCAwVrxkxctQllFVAqtV+Ep9jeA8tagCEdRgEVr6HIKAPloz
X-Gm-Gg: AYBFou0HNqOtgXixPru6kp/6xC+ANuzpUFidscZC3Fu8X4b9YGhddiU+0RoGn0KfpyB
 gkfwsKqY8lS8gKXz4BC8/In/3QHcdTwkjv51YE3ItTJywFJ9Q/KeEOm36SJ2QcSluJEGlE6gRIu
 yo43gLwMpEya4b3sRkeD62BBA9LNTraiudBJkP0b0X7pEIk3DHSvyPOk0AmjYwtZ6kQllbVk9VP
 Us82uULIpHly3tWE4Voz8kWJnJI71ZtqyyXh/yptkhUwbRRc4oMv+HhcWMu1lFs49UD9C3pWJ+e
 SHt5dT2OJQaUyfxqBvHPOyGoNN51QFSTXRFkLaMs5HVmIQQ+Cl5aHDl4xMFBM4vGS6w3p8n251K
 9EgCta9lxmhq6QI/K8UzQtBxOp5gTptgT+GjRbBcoCT8h94sC+9ByxHVj788KNmmdqJUNNujlbl
 Do3Xw6PdI8cRhIUaxsVdG3Iko3F1RPm0AcYpneXcJb3gIA/pkpzjwYesWikqXKQwNkyEOosw==
X-Received: by 2002:a05:6512:39c1:b0:5b0:1e16:e60c with SMTP id
 2adb3069b0e04-5b8c180b536mr1070660e87.25.1789745935555; 
 Fri, 18 Sep 2026 08:38:55 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c2753b20sm571984e87.33.2026.09.18.08.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:54 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 18 Sep 2026 18:34:42 +0300
Subject: [PATCH 6/6] hw/riscv/trace-encoder.c: implementated SRC field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-upstream-ntrace_msg-v1-6-16a56ad8e0ef@gmail.com>
References: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
In-Reply-To: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, Alexei Filippov <halip0503@gmail.com>, 
 Arseniy Semenov <ar.semenov@outlook.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19037;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=gzM9vrAuBzAc7bhHHZaDet26/wtU7ADA3trdZ6HVnlo=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoNeoCQbG++sX+gPTmx5+uNkEfPSWfoDK7tH
 wkd0e7uAn6JAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 dlCGD/9csEX6jIhMkH9lFaTGSRg6/eKWL3/JZgcDgADSCv5e9+NfnpTVxHSrUI+MMq3wYNSKZFT
 hHa9eJQfBj4ttLjPpieIIOwaKarKJjq6DVWPbA5Ucl80WXWJS+H0f6kND0SRj9p0PwGoMktWCUs
 4egppAfjzDx8azs8VPYuZDI5x3qa14WIqLW4Yy8GIxcyiSKD7wOrt1YwTEDNX1w81x1vNSiyQR5
 cbfhblqRjvmosUm/kBLN724SLW3rMzqzujdBQNOQCH3zsb91IoU/+d71P8sTvkdMBBCtoUWALkG
 GCK5v4MpcWtToHSy6vtWlYqwfX0DNWRQn4a26zlbORpDCIZm5pI8PtrS9UxKalkeUXTx4Rs1Vy0
 scYPTdeDVwEQm16W6tqyZCW55oVwNppvRremk3TRFc2I6SaVKTdHRGb8WE00HdhKOIrLpgBPbc8
 WxxeoN3zLxChXDF9TrbDvPSEn7lB4xXTKlQyGX5qWgck76NvTUxfG72NS+/Q6+H16c8RAEcQ/WL
 WhDgXSig+MZPGqeq3ljKkIcrzuh/2k9WS6DlA0WdwoPojTgW9SMeVGKMczMU+cW2wgb6Xo++VGr
 aRcQIbk5iRqBgSxk5L72PEOG6ZeGQacYntd9mUrMEqG+aNGHe6EfqHnJSOGsCclmX/gE9cy8IYN
 zCwL9/reK0RsrZA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=antikostya2@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/rv-trace-messages.c | 46 +++++++++++++++-------
 hw/riscv/rv-trace-messages.h | 19 ++++++---
 hw/riscv/trace-encoder.c     | 94 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 130 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index f3647e89dd..354f33ff27 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -350,6 +350,7 @@ typedef enum {
     FIELD_END = 0,
     FIELD_FIXED,
     FIELD_VAR,
+    FIELD_CFG,
 } NTraceFieldType;
 
 typedef enum {
@@ -498,6 +499,13 @@ uint64_t rv_ntrace_gen_process_encode(uint8_t format, uint8_t newpriv,
         .value = (process_msg),             \
     }
 
+#define PAYLOAD_SRC(val, wdth)  \
+    {                           \
+        .type = FIELD_CFG,      \
+        .width = (wdth),        \
+        .value = (val),         \
+    }
+
 #define PAYLOAD_END()      \
     {                      \
         .type = FIELD_END, \
@@ -521,6 +529,10 @@ static size_t rv_ntrace_gen_encoded_msg(uint8_t *buf,
      */
 
     while (payload->type != FIELD_END) {
+        if (!payload->width) {
+            payload++;
+        }
+
         for (uint8_t offset = 0; offset < payload->width; offset += nr_move) {
             nr_move = MIN(MDO_BITS_NUM - packed_bit, payload->width - offset);
             uint8_t chunk = extract64(payload->value, offset, nr_move);
@@ -575,11 +587,12 @@ static size_t rv_ntrace_gen_encoded_msg(uint8_t *buf,
     return buf_byte;
 }
 
-size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
+size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr,
+                                                 uint32_t src, uint32_t src_width)
 {
     const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_PROG_TRACE_SYNC),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_SYNC(SYNC_TRACE_ENABLED),
         PAYLOAD_ICNT(0),
         PAYLOAD_FADDR(faddr),
@@ -593,11 +606,13 @@ size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
 size_t rv_ntrace_gen_encoded_prog_trace_correlation_msg(uint8_t *buf,
                                                         uint32_t evcode,
                                                         uint32_t icnt,
-                                                        uint32_t hist)
+                                                        uint32_t hist,
+                                                        uint32_t src,
+                                                        uint32_t src_width)
 {
     const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_PROG_TRACE_CORRELATION),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_EVCODE(evcode),
         PAYLOAD_CDF(CDF_ICNT_AND_HIST_PRESENT),
         PAYLOAD_ICNT(icnt),
@@ -609,11 +624,12 @@ size_t rv_ntrace_gen_encoded_prog_trace_correlation_msg(uint8_t *buf,
     return rv_ntrace_gen_encoded_msg(buf, msg_fields);
 }
 
-size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist)
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist,
+                                               uint32_t src, uint32_t src_width)
 {
     const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_RESOURCE_FULL),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_RCODE(RCODE_HIST_PRESENT),
         /* I-CNT overflow is not supported for now */
         PAYLOAD_HIST(hist),
@@ -626,11 +642,12 @@ size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist)
 
 size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
                                                    uint32_t icnt, uint64_t faddr,
-                                                   uint32_t hist)
+                                                   uint32_t hist, uint32_t src,
+                                                   uint32_t src_width)
 {
-     const NTraceFieldPayload msg_fields[] = {
+    const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST_SYNC),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_SYNC(SYNC_PERIODIC),
         PAYLOAD_BTYPE(btype),
         PAYLOAD_ICNT(icnt),
@@ -645,11 +662,12 @@ size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
 
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
-                                              uint32_t hist)
+                                              uint32_t hist, uint32_t src,
+                                              uint32_t src_width)
 {
     const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_BTYPE(btype),
         PAYLOAD_ICNT(icnt),
         PAYLOAD_UADDR(uaddr >> 1),
@@ -662,12 +680,12 @@ size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
 }
 
 size_t rv_ntrace_gen_ownership_msg(uint8_t *buf, uint64_t process_msg,
-                                   uint32_t process_len)
+                                   uint32_t process_len, uint32_t src,
+                                   uint32_t src_width)
 {
-
     const NTraceFieldPayload msg_fields[] = {
         PAYLOAD_TCODE(TCODE_OWNERSHIP),
-        /* SRC field is not supported for now */
+        PAYLOAD_SRC(src, src_width),
         PAYLOAD_PROCESS(process_msg, process_len),
         /* TSTAMP field is not supported for now */
         PAYLOAD_END(),
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 5b75dc0a7d..af6184f498 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -37,20 +37,27 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
                                      uint64_t addr,
                                      bool notify, bool updiscon);
 
-size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr);
+size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr,
+                                                 uint32_t src, uint32_t src_width);
 size_t rv_ntrace_gen_encoded_prog_trace_correlation_msg(uint8_t *buf,
                                                         uint32_t evcode,
                                                         uint32_t icnt,
-                                                        uint32_t hist);
-size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist);
+                                                        uint32_t hist,
+                                                        uint32_t src,
+                                                        uint32_t src_width);
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist,
+                                               uint32_t src, uint32_t src_width);
 size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
                                                    uint32_t icnt, uint64_t faddr,
-                                                   uint32_t hist);
+                                                   uint32_t hist, uint32_t src,
+                                                   uint32_t src_width);
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
-                                              uint32_t hist);
+                                              uint32_t hist, uint32_t src,
+                                              uint32_t src_width);
 size_t rv_ntrace_gen_ownership_msg(uint8_t *buf, uint64_t process_msg,
-                                   uint32_t process_len);
+                                   uint32_t process_len, uint32_t src,
+                                   uint32_t src_width);
 uint64_t rv_ntrace_gen_process_encode(uint8_t format, uint8_t newpriv,
                                       uint8_t is_virt, uint64_t context);
 
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 7d8b5d4fae..d83bc95f35 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -41,6 +41,8 @@ static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
                                              uint64_t pc, uint32_t inst_len);
 static void rv_ntrace_update_sync_msg_cnt(TraceEncoder *trencoder);
 static void rv_ntrace_update_sync_icnt(TraceEncoder *trencoder, uint64_t icnt);
+static uint32_t rv_ntrace_get_source_transmission_msg(TraceEncoder *trencoder,
+                                                      uint32_t *src);
 
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
@@ -94,7 +96,8 @@ REG32(TR_TE_CONTROL, 0x0)
                                    R_TR_TE_CONTROL_RSVP5_MASK)
 
 /* trTeControlEmpty is the only RO field and reset value */
-#define R_TR_TE_CONTROL_RESET R_TR_TE_CONTROL_EMPTY_MASK
+#define R_TR_TE_CONTROL_RESET (R_TR_TE_CONTROL_EMPTY_MASK | \
+                               R_TR_TE_CONTROL_INHIBIT_SRC_MASK)
 #define R_TR_TE_CONTROL_RO_BITS R_TR_TE_CONTROL_EMPTY_MASK
 
 #define TR_TE_CONTROL_FORMAT_ETRACE 0
@@ -127,6 +130,22 @@ REG32(TR_TE_IMPL, 0x4)
 
 REG32(TR_TE_INST_FEATURES, 0x8)
     FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
+    FIELD(TR_TE_INST_FEATURES, NO_TRAP_ADDR, 1, 1)
+    FIELD(TR_TE_INST_FEATURES, EN_SEQUENTIAL_JUMP, 2, 1)
+    FIELD(TR_TE_INST_FEATURES, EN_IMPLICIT_RETURN, 3, 1)
+    FIELD(TR_TE_INST_FEATURES, EN_BRANCH_PREDICTION, 4, 1)
+    FIELD(TR_TE_INST_FEATURES, EN_JUMP_TARGET_CACHE, 5, 1)
+    FIELD(TR_TE_INST_FEATURES, IMPLICIT_RETURN_MODE, 6, 2)
+    FIELD(TR_TE_INST_FEATURES, EN_REPEATED_HISTORY, 8, 1)
+    FIELD(TR_TE_INST_FEATURES, EN_ALL_JUMPS, 9, 1)
+    FIELD(TR_TE_INST_FEATURES, EXTEND_ADDR_MSB, 10, 1)
+    FIELD(TR_TE_INST_FEATURES, SRC_ID, 16, 12)
+    FIELD(TR_TE_INST_FEATURES, SRC_BITS, 28, 4)
+    /* reserved bits */
+    FIELD(TR_TE_INST_FEATURES, RSVP1, 11, 5)
+
+#define R_TR_TE_INST_FEATURES_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                         R_TR_TE_INST_FEATURES_RSVP1_MASK)
 
 static uint32_t trencoder_read_reg(TraceEncoder *te, uint32_t reg_addr)
 {
@@ -182,7 +201,6 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
-    input = FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
 
     return input;
 }
@@ -266,6 +284,32 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
     return val;
 }
 
+static uint64_t trencoder_te_inst_feature_set_hardwire_vals(uint64_t input)
+{
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, NO_TRAP_ADDR, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_SEQUENTIAL_JUMP, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_IMPLICIT_RETURN, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_BRANCH_PREDICTION, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_JUMP_TARGET_CACHE, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, IMPLICIT_RETURN_MODE, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_REPEATED_HISTORY, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EN_ALL_JUMPS, 0);
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, EXTEND_ADDR_MSB, 0);
+
+    /* set SRC field to the max value for now */
+    input = FIELD_DP32(input, TR_TE_INST_FEATURES, SRC_BITS, 12);
+
+    return input;
+}
+
+static uint64_t trencoder_te_inst_feature_prew(RegisterInfo *reg, uint64_t val)
+{
+    val = trencoder_te_inst_feature_set_hardwire_vals(val);
+
+    return val;
+}
+
 static uint32_t get_inst_len_at(uint64_t pc)
 {
     bfd_byte packet[2];
@@ -348,8 +392,9 @@ static RegisterAccessInfo trencoder_regs_info[] = {
         .ro = R_TR_TE_IMPL_RO_BITS,
     },
     {   .name = "TR_TE_INST_FEATURES", .addr = A_TR_TE_INST_FEATURES,
+        .rsvd = R_TR_TE_INST_FEATURES_RSVP_BITS,
         .reset = R_TR_TE_INST_FEATURES_NO_ADDR_DIFF_MASK,
-        .ro = ~0,
+        .pre_write = trencoder_te_inst_feature_prew,
     },
 };
 
@@ -550,7 +595,9 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
     bool send_ownership = false;
+    uint32_t src_msg;
 
+    uint32_t src_width = rv_ntrace_get_source_transmission_msg(trencoder, &src_msg);
     uint32_t icnt = rv_ntrace_get_and_reset_icnt(trencoder, curr_pc, curr_inst_len);
     uint64_t uaddr = rv_ntrace_encode_uaddr(trencoder, target_pc);
     uint64_t faddr = rv_ntrace_encode_faddr(target_pc);
@@ -562,12 +609,13 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
 
     if (sync && trencoder->sync_cnt >= sync_max) {
         msg_size = rv_ntrace_gen_indirect_branch_hist_sync_msg(msg, btype, icnt,
-                                                               faddr, hist);
+                                                               faddr, hist, src_msg,
+                                                               src_width);
         trencoder->sync_cnt = 0;
         send_ownership = true;
     } else {
         msg_size = rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt, uaddr,
-                                                          hist);
+                                                          hist, src_msg, src_width);
     }
     trencoder->last_addr_reported = target_pc;
     trencoder->last_icnt_reset = target_pc;
@@ -583,6 +631,22 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
     }
 }
 
+static uint32_t rv_ntrace_get_source_transmission_msg(TraceEncoder *trencoder,
+                                                      uint32_t *src)
+{
+
+    uint32_t src_disabled = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, INHIBIT_SRC);
+    uint32_t src_width = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_INST_FEATURES, SRC_BITS);
+
+    if (src_disabled || src_width == 0) {
+        *src = 0;
+        return 0;
+    }
+
+    *src = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_INST_FEATURES, SRC_ID);
+    return src_width;
+}
+
 static uint64_t rv_ntrace_context_encode(TraceEncoder *trencoder,
                                          uint64_t *context_msg,
                                          NTraceOwnershipFormat format)
@@ -633,9 +697,11 @@ void trencoder_send_ownership_msg(TraceEncoder *trencoder,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint64_t context_msg, process_msg;
     uint8_t msg_size;
+    uint32_t src_msg;
 
     g_assert(trencoder->ntrace);
 
+    uint32_t src_width = rv_ntrace_get_source_transmission_msg(trencoder, &src_msg);
     /* By the Ntrace specification process len is format + priv + virt, which
      * is always 5 bit len plus context field.
      */
@@ -646,7 +712,8 @@ void trencoder_send_ownership_msg(TraceEncoder *trencoder,
                                                     newpriv, 0, context_msg,
                                                     context_len, &process_msg);
 
-    msg_size = rv_ntrace_gen_ownership_msg(msg, process_msg, process_len);
+    msg_size = rv_ntrace_gen_ownership_msg(msg, process_msg, process_len,
+                                           src_msg, src_width);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -728,13 +795,16 @@ void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    uint32_t src_msg;
 
     uint64_t faddr = rv_ntrace_encode_faddr(pc);
 
     g_assert(trencoder->ntrace);
 
+    uint32_t src_width = rv_ntrace_get_source_transmission_msg(trencoder, &src_msg);
+
     trencoder->last_addr_reported = pc;
-    msg_size = rv_ntrace_gen_encoded_prog_trace_sync_msg(msg, faddr);
+    msg_size = rv_ntrace_gen_encoded_prog_trace_sync_msg(msg, faddr, src_msg, src_width);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 
@@ -843,6 +913,8 @@ void trencoder_send_prog_trace_correlation(Object *trencoder_obj, uint64_t pc,
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint32_t src_msg;
+    uint32_t src_width = rv_ntrace_get_source_transmission_msg(trencoder, &src_msg);
     uint32_t icnt = rv_ntrace_get_and_reset_icnt(trencoder, pc, inst_len);
     uint32_t hist = rv_ntrace_encode_and_reset_branch_map(trencoder);
     uint8_t msg_size;
@@ -850,7 +922,8 @@ void trencoder_send_prog_trace_correlation(Object *trencoder_obj, uint64_t pc,
     g_assert(trencoder->ntrace);
 
     msg_size = rv_ntrace_gen_encoded_prog_trace_correlation_msg(msg, evcode,
-                                                                icnt, hist);
+                                                                icnt, hist,
+                                                                src_msg, src_width);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -889,11 +962,14 @@ static void trencoder_send_branch_map(Object *trencoder_obj)
     TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    uint32_t src_msg;
 
     if (te->ntrace) {
+        uint32_t src_width = rv_ntrace_get_source_transmission_msg(te, &src_msg);
         uint32_t hist = rv_ntrace_encode_and_reset_branch_map(te);
 
-        msg_size = rv_ntrace_gen_encoded_resource_full_msg(msg, hist);
+        msg_size = rv_ntrace_gen_encoded_resource_full_msg(msg, hist, src_msg,
+                                                           src_width);
     } else {
         msg_size = rv_etrace_gen_encoded_format1_noaddr(msg,
                                                         te->branches,

-- 
2.43.0


