Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF988CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBOy-0005Rq-4K; Fri, 09 Oct 2026 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBH8-0003Uy-HH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:47 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBH6-00080O-FS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:41 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3a49a022221so30720361fa.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554919; x=1792159719; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ft0tcGu2gGawbMzaoRRdiqTE5DGODgbTUY11kMyRl2g=;
 b=fTWz6pSE43s3kcESoIbdmuchF0boc/PVypAoP2KqOVTRFwsL7xGyuGQ9UH50umZnk+
 3WWDiJSFKV/h6jvuSnxDNRVkYJnKvtnrr4GuMJUtRXtkXFyqxRKz4RzJoQTiQ8DODdHl
 y/7zBptxk2F/2wXqyEFx5rysqPy38bC9vzulV3oTabyGRFRnkT0sarXns8rX7Z/cTaCU
 YGJVQ+YG3F+RpoAwQ7v4lqJnn4F3DDg62KVKrXf1KmN4bM8VBY3eIM7ZreVm18qZvJbl
 MnLME+/CZbCn+D1i6Knu5EtJhTkT2f24mNicTv3WwpTa9fMiAMBdFaBf3dYiYAx5GkOw
 ZQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554919; x=1792159719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ft0tcGu2gGawbMzaoRRdiqTE5DGODgbTUY11kMyRl2g=;
 b=uQeCOk/ch0nKNXYSr1zyN/X2FkfaDX54ikC4JHmrJUaOY0Cfz/UZT68+pyRf/79Sw5
 Ywh5bGTUgWC6qW545HqPPkRpBWs0VWS7Tvrl6p1ess4yTnXxm49ENwm71VEo6ZpBFRHg
 SKQNahhekfDGtt+v/NRU0mIZTSEG1LJ+qHe8ybAv1x4qH7krpQexQQ84Fk/glD/lc/eX
 jMTjRSry+sJJOfonQy/9i5zGmj3vt29e4xHsQhCgDOLeLfBBlyGA+EhObZrRA8OpLOQg
 i0nanqZbdjYDz5m/jW0xiML3VeABQfFkhTuO9z8H3ndO50zbPPh0LHqmVqY2CAOJxXm8
 i4zw==
X-Gm-Message-State: AFq9FYKZmT130z7oDKRNUkPO4GqtkJH5BroJ+YkMSx1V3p7S2+z8DQx1
 xwNpUVMOo0wsBvcvdsGtXi0FytCXxYn4ofXBUmHeS6UvZI7N74+yVAw/UbFYrAfPNes=
X-Gm-Gg: AYBFou2Ew83r8TN71ZCT52y2/4ZPWItmhC3jEXkdZgt6lsnZGCVpSwmBisaA+kqnDeR
 h98UQveGENGMGz4PCF50hESUY6UHwUulGmvjTiE4XFlIrGeLJfEDxdhzqbMmSQ5iJGla2YUbOkj
 Mk7vnZP5Iwt7maR6B/OQdKW3Vct1C+eOXcu0Ik1eLA3P9+L3nM0yUvnaESkQ60qGziiGmZ7UGpX
 8dLumiafuKm+y9akJTzmD5fkeaXAIXfPh+OW+gozZpmOr0mJfnXvqqABKZRN0eXlJQOTKSut2EF
 26d+83Z7yrX+HcVTS4vZtF2H4yHVKXculqyGO4IV6kD9/Yi+Tfvhp7xmHHjgUTcgHUWyTEu5pCW
 kIB1IQRxZWQrC8wv0kPM0evov6Hx6CFXDFCKeRT6dhlwceHUAMiUDRbahzE3srkjXJng5b8ffCi
 8SrzWNrHV/ZotFZsAYzJC9w+tA/ucsVFEahseowcvSea90g3JgnvMr28Oa7GrhGLtIGHdGdAdzF
 Qw+jXuMuDjf/niFZ2Ea83WMvPF+nhprWd/zsVrb9PfNYIj8
X-Received: by 2002:a05:6512:3c90:b0:5bc:b531:51d7 with SMTP id
 2adb3069b0e04-5bcde6b3fbemr697761e87.12.1791554918479; 
 Fri, 09 Oct 2026 07:08:38 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddecfc20sm655991e87.84.2026.10.09.07.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:08:37 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 09 Oct 2026 17:03:07 +0300
Subject: [PATCH 6/6] hw/riscv/trace-encoder.c: emit PTC message when trace
 started disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-upstream-ntrace_filter-v1-6-8f061c9b24da@gmail.com>
References: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
In-Reply-To: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Alexei Filippov <halip0503@gmail.com>, 
 Grigoriy Bereznyakov <gregoriy93.gb@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=hmvihcwYPu69+wUJJkFwl77m6Awy3R/i9UzfXrnluqQ=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQWFssTDmJO68YDYwr34WnSfp+ZM60PtMaCA
 SZmQpRXhHKJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 drIkEAC+eP50uXN994TEd5F1mJPa5oxIxYxHqebs5IXniaFN77Dg3KV8Iv0uTkmSLamcIVYfBZt
 P6hNHPvwipS5cb9Wqhm3eWR6HIX8nTWlqjXRfDzjrbMU4BxyMidQ5hIK6gCobtZ9EoV1fphIQvn
 Nrvh1j5TJOWD8B2TB9Hh/ImKYwYg+QgxlSsj0UoYRBafZd9bXtpCTroyH9x+NehcqLs+7R9Mod4
 X3UwIol6XnQOuUcBUI/CD6Pssq6ZEKYwJusTYxCs+YYgdC7yk/qkn2ewFyPI2OWyGTNeGwgsl5x
 Xd8ioTMbQJMEzMEDgqu3ISGv6lN/SANkhknklnQlh6K9W/tO4wEOOcDCEVfvtaa3KyRPTu7g2+y
 VbaPpt4MUC47p6urhrYyToHb5dokNan1Ag37ED6nCGF8KIilaIXrrEk5p/DuIsCWFsqaSuZZHXW
 wsygMfdcVdtIi5WML6aCPMMqem8HDvO+psCjzYXTlKc1O6P5oYRQ1Yeng5KDbIUm3VRFreOIbIQ
 uW7rVREvAgy+i5wsHKhiIoxcJmjpeeBSQtsgUK7q/5aU8qbEDLN03ZqZ+BXKRgaxbetP7uta6+J
 +FOZwQhL3PDcWbEI+m5vW4nxpIWzDwHEi4mrTO6SVPdTQA2dHu23fIHF5al6kTO/37d+GI/zIIw
 RtYmmWAr4atxjEg==
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

If we will enable filtering and enable tracing, we will see
nothing, but according to RISC-V N-Trace (Nexus-based Trace)
Specification v 1.0 p.8.6 Table 26 - if Trace starts disabled
ProgTraceCorrelation with EVCODE=4(Trace Disabled) should be emitted.
So, lets do that.

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/trace-encoder.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index e42c92d03a..71feefecd9 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -43,6 +43,7 @@ static void rv_ntrace_update_sync_msg_cnt(TraceEncoder *trencoder);
 static void rv_ntrace_update_sync_icnt(TraceEncoder *trencoder, uint64_t icnt);
 static uint32_t rv_ntrace_get_source_transmission_msg(TraceEncoder *trencoder,
                                                       uint32_t *src);
+static void trencoder_send_empty_prog_trace_correlation(TraceEncoder *te);
 
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
@@ -449,6 +450,8 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
             if (trencoder_filters_match(te, INSTRUCTION_FILTERING,
                                         env->pc, env->pc)) {
                 trencoder_send_prog_trace_sync(OBJECT(te), env->pc);
+            } else {
+                trencoder_send_empty_prog_trace_correlation(te);
             }
         } else {
             te->trace_next_insn = true;
@@ -1317,6 +1320,19 @@ static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
     return icnt;
 }
 
+static void trencoder_send_empty_prog_trace_correlation(TraceEncoder *te)
+{
+    uint32_t src_msg;
+    uint8_t msg_size;
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint32_t src_width = rv_ntrace_get_source_transmission_msg(te, &src_msg);
+
+    msg_size = rv_ntrace_gen_encoded_prog_trace_correlation_msg(
+        msg, CORRELATION_TRACE_DISABLED, 0, 1, src_msg, src_width);
+
+    trencoder_send_message_smem(te, msg, msg_size);
+}
+
 void trencoder_send_prog_trace_correlation(Object *trencoder_obj, uint64_t pc,
                                            uint32_t inst_len,
                                            TraceStopReason evcode)

-- 
2.43.0


