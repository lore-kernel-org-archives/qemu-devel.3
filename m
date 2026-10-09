Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD5CCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBOP-0005Ea-Fs; Fri, 09 Oct 2026 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGk-0003SM-QX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:22 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGa-0007yM-2K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:16 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a76ac0bdafso14879161fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554886; x=1792159686; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G4q3w1GbxfDtauogl7QvFhXf4+K7SEEens2HfxEHj9M=;
 b=rms3lzj/CIYrVO9s9qfdXjZeuDxUchQLjTL4HfWGMn6rsnuwY3N5j9pKxt7xs46fEf
 VMHySseQgBfVqBgEESoVugYQRknpVVYQVDOhpj+FsWbsDQuld09WFJl9s8nZMHWkkXec
 UgOcqK60RJqXAnf+VtRoN5bbPaI2t482u2gaDlp6QfZNohb5Q6DY6GD3gydxVlSY4hI1
 jieiWaJ0XgrEmUMCAglv+YQEVSV3i/QyK8c/2KfVAhOJEqfmoJQ4wsc0FYSVgjkUhZwE
 +DByBiDPLZsb6JdOTIa0KOjtx0+VNuHafeCTCcBFeg6pXRPj7OqLSxud9E9Gg1gXnEl6
 Ro6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554886; x=1792159686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G4q3w1GbxfDtauogl7QvFhXf4+K7SEEens2HfxEHj9M=;
 b=q5nY4l/hfBgSUkSsgiwdEbFSPu6drlKVbreC9pO1k9+Ku0X4iCGLdlZGI5DuWbZVT1
 LGFVimKsu01fDSWX0T7ag35F3lexiVxma7LOrn2OOlPvMqkKy14CcldzOzXc3lnSlkcT
 b8OYaw4yb6a9qjHhWrFog3w+b7/adaIyYufFafzoDznMDXwU9YGdWsk2m4fOX5BIdJCD
 m4dFU+kW0WwJnl7uNmtZh8+irJM6fcDTEpYbx7m+5xDOrnqYVHsO6ywp59Aoq59bjBFr
 yVA5gjQu93xZFuQF45VA8Msq86SS05w4XDDjwkGFv70E5NVrDpZbrOMxf+7qlaJaOcTX
 ZR1Q==
X-Gm-Message-State: AFq9FYKDeC0vVWYyAQCrkvNIDwfuZ31+mSZPYzjhMAqflZ5XR5bfrYLl
 FMfBkzk/8HBlEspdnOsW+AymiWGF/x6nKmWnQ+P5n86xy4v+mGed/H13fzf/5jUfWyQ=
X-Gm-Gg: AYBFou3N42MTv90LSHfNKvec5N5bSmC18G+2R9BB/024NDTCt+B2DK9jvm0CxTVqMbE
 ICUA/PsfDq0X7vLQHK5psGi+taBl3V82iV5gRhKi2rvOsXqrNym13dtxVS4DqNPxvv34agGBZ4g
 504f7S5vqWIrvDjk7EHhjwRpUbYkg4DaehHuZX4pxD+Gc5VTuzR0Wr1yqDBRB+AsUzMNXCQu070
 nZn2/Yg/ueHDB1cZYCW1DLvodbzgs1jG7af9DzQrk/V3XrcTNS0L0fDM23g6DP7TwkcHW/WR7N/
 gSXMtuVvEA1zJD5InrLWIv2mPQuBMQ+tXxtu8kZT/KPOyuWx+9cTfDXscd1Ma/oz48WPKcUE4Sw
 CFnFZdgtfk0VNGoOoDNo6VBqHDJUkY6OuNHk3n8EPub/jLnM1UL7+YGF3WqOJFACAQE/uDpCdfC
 3To4HGSlchWTRPVfCNBz3fHbIb85lFOZ6NbbrykRcz0ywXc29wNfihpKDupNBLE7ctzzB67zJHW
 WAMsUDBVG2RhgW7deWASfb/CPVKT1dixKfW9g==
X-Received: by 2002:a2e:a585:0:b0:3a8:7db9:3b2b with SMTP id
 38308e7fff4ca-3a9c4ebcd13mr3971881fa.1.1791554886346; 
 Fri, 09 Oct 2026 07:08:06 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cf5903sm7368481fa.42.2026.10.09.07.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:08:05 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 09 Oct 2026 17:03:02 +0300
Subject: [PATCH 1/6] hw/riscv/trace-encoder.c: move trace_running setting
 location
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-upstream-ntrace_filter-v1-1-8f061c9b24da@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=gGeyDS2hFxpV5iufNNIMTw2ovv0h2LPsg5wL6NWTroo=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQWG181IfDiseaFYPEyZPv/XjgHzpIN8UmC6
 gWNsfI1v4uJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 dvwkD/9XMmCGBWEdCBPegg3WJIr8V2t9AOMf0iJapFAoDrG3IbDh2QjHMvSUxUYRZGDRpQ3JZGe
 dDxa6EhghQKqS0Kj/O64YyZVM+/Jd5E36RhMetM8mMv72i1u8Ze+Sqbp7YXFm3VQHhZdXd8B2gN
 XArlcrKKUB4vyK7F1fM/vzp+mcvaVdEN/ycFvkKwpTMS+HXYRUNjDXy2FC+mUq/DHK9F+wRKloo
 1+jANuRKBgfGhgMtrUOHsxMepu5PDvLrqUTh+GqkteV3Etz71v6duZPVWRRRoRRkpLRjDIRfeLg
 sWSfio45ELl8fSdjjdkb1tC4gp698qwNDkCpYCRDoP2+6iLSJNhnnHxR6sdfUXXPqkJKAQz6MiX
 EEqvJFzmBT7TKoaHpC9lOzxbSw+dIJuIvozWp3xfz97/dqbLsFGItPzVOnFdhF+IwHbtsv87M7a
 48D3FaMT0bPsJsFKu9PsEH4dwYyfxnUXDDmT/w6opQuJ/lKEJngIeKwXM63VOelaKzWR1/QmYQ/
 T80/aW1U0etgtFrIyqdNtTiPxcGLRHpWOBrWhYtH6OMS+RbWibEs1yLguAN9AJp5zKmCkjZWMtu
 VkSI49C6j5/w2m8yUlfp5WrM0FQbc4OqqSWypec60iSVAa7PGLVr2mcSw0OQ/NJbniV7AdZ4wil
 BAjh/zvftBZ4MPw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Let's set trace_running to false after last trace emitted and to true
before first trace message emitted.

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/trace-encoder.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index d83bc95f35..11b07b0f3d 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -350,6 +350,9 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
             trencoder_send_prog_trace_correlation(OBJECT(te), env->pc, inst_len,
                                                   CORRELATION_TRACE_DISABLED);
         }
+
+        te->trace_running = false;
+        env->trace_running = false;
     }
 
     te->ntrace = (trTeFormat == TR_TE_CONTROL_FORMAT_NTRACE);
@@ -359,6 +362,9 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
         te->ramsink_ramstart = trencoder_read_ramsink_writep(te);
         te->ramsink_ramlimit = trencoder_read_ramsink_ramlimit(te);
 
+        te->trace_running = true;
+        env->trace_running = true;
+
         if (te->ntrace) {
             /*
              * N-Trace require to trace from very first instruction,
@@ -373,9 +379,6 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
             te->trace_next_insn = true;
         }
     }
-
-    te->trace_running = trTeInstTracing;
-    env->trace_running = trTeInstTracing;
 }
 
 static RegisterAccessInfo trencoder_regs_info[] = {

-- 
2.43.0


