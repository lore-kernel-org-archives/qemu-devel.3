Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B641DC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR5-0000kl-7w; Tue, 25 Aug 2026 10:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys33-0002xv-La
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:45 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys32-0002DX-0F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:45 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-39c7ef2b1e2so43390041fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667762; x=1788272562; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bolLN9ml9GRYfNtQRCTmpUIa3V/5kd3A2e7/75kEuKk=;
 b=hHdGcmasliBYnYYLVPF82DJbDDgG6gi0jWQpsUyc0Xom3BwNxlJgvMkuFtfLZHMLND
 ZYhBSTh9UGgZt9JK6FkLXD958D5hGDykXmOIkUYDrgDFFgTm/PNsqVbYT7r5Vc7DQ1T6
 5yQfvSjIZFjcET7nfXXcP6Sli6J1GLSQO00m09Cu/v8jmuzf8QGbtT7Ga3UNrWPPDPAo
 oXCu1sFZ9KYtZwO1uNTCxlA6HcXBe0Jvh/ykrGYJnotkNSbXZoliK+UQUPLvKaPSmiqb
 7cSHg3G5bkvRjxZJDKk6S3D5LOZq/9EHBhaeB0IgJMgy6H58x+WjkLJ4LL37arVK5MVx
 CzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667762; x=1788272562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bolLN9ml9GRYfNtQRCTmpUIa3V/5kd3A2e7/75kEuKk=;
 b=gWaslCYnHKC5YXyQn2CcBl90Uzv7uvJDRf4NN18EeTBGIGkKdgXGj60eF7KQML1/PN
 Fln6tX/sLBMluOlVoRe8t6DAU/8BVQJfVPoX52bXuu8Izk6vxq5vDmUgnYdNCxco/VL7
 SdJT1LECGjkzfflKCUJX5TOLXsmUspRi3XUI9d7lejAQcE9U2I1Y/+KWD8z4Ug2TH+23
 ykpi0NSBDdEDC5oeX+p81DxLOOzbNZHoG2Ft6hGujquPcTKaEDfo80XEwGJHLeNLl7a8
 BNsP+ew2Zfld4RK19TaJXKFVvaJ7JZKm+TDHs7fAmw96qacEyfqryWZIyXbEQOR2fnh8
 w5Nw==
X-Gm-Message-State: AFuF++kd+clBp69coojg4ibkms0q30b8mUkHXuzaquktTU5g7dFCL9Zv
 xaJ7f8PrdIYHqc0UKckj/H6rUcuiUpx8AvHdgEL+vYQ+vRzjfPMGRCN6
X-Gm-Gg: AR+sD10pfWOGK0glBOhswyRkHHBQWy2OaFSFsXFhUyU0+Id0gG3XK1/7cSqPo7vvyc4
 gM3Ujk8da8w00VHkeYx9emy/zOXLRQd8Eq46jgEmVTjf+eTOSQG7DIC2nF4g3kW6W7lHmOShrkf
 mD1jNxYSR6meglLndQDAFAZmCMpRV8LHIXNoBkCyghI9xvS++rn6MeBTh+40ub03NZe6dWyanKw
 qpHgwrJ6Ep3k87Msa/EA25RUHPPuS2+DoBoM6Yha1EEOmP5UcaMUfr3QfdpUAmiQW5DLR75iizH
 Qpd5VAIig+2HtIrcmxpAh5oBEYuvAh3P3s9htgX5n2391n+6+o5+Y2RsnYKMxJQxmCSiNBlkR4V
 AHDYxX4lZch3qlz/zO4NisWclbm4PefpitriHNNlTXhTJEOl/czgGHn2/irJzSWPv+lM/ECNTQy
 HCQ8Y8jVhJRj1IW+P5nhMW89zBB7QQEkKPJ0+RyaasMPZW9To28mwtPjRGCTTvb5BcQaC+96Fm/
 UxUJXpiiACceqXPsUKlnUb2uBWnTmhfWRnNt0ITbw==
X-Received: by 2002:a05:651c:a213:20b0:3a1:aab7:9bdf with SMTP id
 38308e7fff4ca-3a1aeb949bbmr60505331fa.5.1787667762030; 
 Tue, 25 Aug 2026 07:22:42 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:40 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:32 +0300
Subject: [PATCH 08/13] hw/riscv: add n-trace ResourceFull rv-trace-message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-8-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3823; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=fMLXbru4mJZ3lHay/UjVh/RTgqazBZ0Gw/xJM8uVpFk=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjK5u9WDpd9z74/7TAZI52FC+VD8frIinD1
 isHoAr63ECJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dhu6D/wOtZCAOs/Dq/7bmfeAEKlsq0oevyw+PN0NDcLM1ILh6UKOL7kc6a/W37iQPn65n40Tzgg
 2G1Wm1bElEOBYKFT/giMctGlA/ap3wviXYC9cib7MuJ5tIMSG2o3bRNKPQ60Xj8awur+1D9dPvw
 P9zEibdbdEqVbi6HApWQE6CvWrOnjvE9oO4TYaF4N6YybXn1fmTkkQ9mGJm8+weV16Om7Gm3nMA
 DjiaILRD43nPBUCdmy7LYZeUsZixKYM2vB/OdZuIUeZTVuzcf5Uoy1j/yAI/kehpehap6FzQbQA
 jvn5rlquiT2bHYeOEMJK9zUt7Y+wwVx+vH6FkzATZ27G/6h0ZRsOk875YRXS0r2DALpoIWRoRWd
 KHU/t4yB+vWXmaqw96gGCk+7G8N4k0UbI/8XOLGWO2eUFSI2Hrs9HMok9LlZ8dMgKv43+4Ind9E
 0B89Ug3dxaBDMIYTVX7R7t5w8PUjvQ0jiABjfWKQPcd4QcGpsKlaJah5ElWHtmIbexbqngP2zsJ
 fpzd7eqIetMrs9SZeywy+QiNlVT2BkHkub5XOTP6iQ/JFrPeuvnQbzO6ggdSKAA121Lj7WNhFqV
 q3GPOerExPD/NPJkT9ipx/mZCdCqBNauGt9kMyxIC23yhSsKaqu69WcRioe5zy/agB1t7EBgPOV
 A/GylP8bEpz3bhw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Add generation, encoding and sending logic for N-Trace ResourceFull
message.

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/rv-trace-messages.c | 29 +++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  1 +
 hw/riscv/trace-encoder.c     |  5 +++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 2ee38c4354..8a9a3c6955 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -359,10 +359,12 @@ typedef enum {
     WIDTH_FADDR  = 63,
     WIDTH_UADDR  = 63,
     WIDTH_HIST   = 32,
+    WIDTH_RCODE  = 4,
 } NTraceFieldWidth;
 
 typedef enum {
     TCODE_PROG_TRACE_SYNC        = 0x9,
+    TCODE_RESOURCE_FULL          = 0x1b,
     TCODE_INDIRECT_BRANCH_HIST   = 0x1c,
 } NTraceTcodeFieldValues;
 
@@ -371,6 +373,10 @@ typedef enum {
     SYNC_TRACE_ENABLED = 5,
 } NTraceSyncFieldValues;
 
+typedef enum {
+    RCODE_HIST_PRESENT = 1,
+} NTraceRcodeFieldValues;
+
 typedef struct NTraceFieldPayload {
     NTraceFieldType type;
     NTraceFieldWidth width;
@@ -425,6 +431,14 @@ typedef struct NTraceFieldPayload {
         .width = WIDTH_HIST, \
         .value = (val),      \
     }
+
+#define PAYLOAD_RCODE(val)    \
+    {                         \
+        .type = FIELD_FIXED,  \
+        .width = WIDTH_RCODE, \
+        .value = (val),       \
+    }
+
 #define PAYLOAD_END()      \
     {                      \
         .type = FIELD_END, \
@@ -517,6 +531,21 @@ size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
     return rv_ntrace_gen_encoded_msg(buf, msg_fields);
 }
 
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist)
+{
+    const NTraceFieldPayload msg_fields[] = {
+        PAYLOAD_TCODE(TCODE_RESOURCE_FULL),
+        /* SRC field is not supported for now */
+        PAYLOAD_RCODE(RCODE_HIST_PRESENT),
+        /* I-CNT overflow is not supported for now */
+        PAYLOAD_HIST(hist),
+        /* TSTAMP field is not supported for now */
+        PAYLOAD_END(),
+    };
+
+    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
+}
+
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
                                               uint32_t hist)
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index d113129d65..7ed8737d14 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -38,6 +38,7 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
                                      bool notify, bool updiscon);
 
 size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr);
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist);
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
                                               uint32_t hist);
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index face6f83b7..302458bfba 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -694,8 +694,9 @@ static void trencoder_send_branch_map(Object *trencoder_obj)
     uint8_t msg_size;
 
     if (te->ntrace) {
-        /* send ResourceFull message */
-        return;
+        uint32_t hist = rv_ntrace_encode_and_reset_branch_map(te);
+
+        msg_size = rv_ntrace_gen_encoded_resource_full_msg(msg, hist);
     } else {
         msg_size = rv_etrace_gen_encoded_format1_noaddr(msg,
                                                         te->branches,

-- 
2.43.0


