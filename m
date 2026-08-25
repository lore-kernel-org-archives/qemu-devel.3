Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E86FC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR1-0000im-OO; Tue, 25 Aug 2026 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys3I-00039I-Il
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:23:00 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys3G-0002Ho-LM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:23:00 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39c9a3acd40so37102601fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667777; x=1788272577; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OlODc9nuQVDAW70OI4oGX5kt5O8t1mabSFu826OaUbs=;
 b=KNeH4+mCTiiUUjsQcwlYauWU9p4ow655Q7ATmWIBndgLzZE6f8RWLlCFtbcHyKc2CK
 OoawDf2thC2gQg3J1v5ew3fB8cLhVgnof37iphFiXvLfLulAdCjja5vmANFeS441WrWd
 WwjyBHmHx0YAlZL/RYeHCips/7HjOY86Od+uIjgucWmzugqGoCuUWyeZ4cOuiJI9S4DZ
 vIDkStfvosYDN7IW7KsCvh2dUctdovK5cUAN+D1musAWc20tCMvvBfw+DPTrBTmirRlk
 E60qL+aQhFECT7VXDOqYMQX5AvMuOv+CiyGyOSApAhD/qXPYx8chfasEVYUV64XS4KTY
 Hkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667777; x=1788272577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OlODc9nuQVDAW70OI4oGX5kt5O8t1mabSFu826OaUbs=;
 b=AQDqxb8K+mWY1rdN3kxWWNoO0PkF+HS6N7QI69OEFFR16Bo3oHigR6+ZizCyAJzMCh
 TRVhS54p9Be2lPI8NaxMqb52VrjtOpml2idPX1dzwu64+3dgMY2CLv54velFy9hjIjMc
 9S/WlJ11PMhFV4UeK8GyMGkSLYP++XpWMOL9BeUBkIAtWbluSS7eVuEbDQBhQowjxIzD
 TyEb6GHCLqaIG5oB3VarOGzH0PRvNRAF+wFVVJLgr8bNQFAjTxAELDiiW+zqmHVJraeg
 eCEnTiqwTU3x6XqJ1R46RSr7BfeuFFAgt9PUETWrf3G1QYjSy3MQof1gzURbVLh83ltj
 lC7g==
X-Gm-Message-State: AFuF++kAvQ1KB6uYDOHREW9zQdMvKyL9hxhbyBTkpgz9W0lKF3DZjYcu
 q3az1ECU6IuOQFdWxZYfwl9lCCoFWTdPvN1wcWUW+EPOH0nX0n3FB2auHMbu6n03
X-Gm-Gg: AR+sD13njW7pyKweJdQVoTZouhG7mUXlpMldTm89hnT89ehYG+5+bCCmOywr9+3R7n/
 8e0LWcci8TuInjkaSwxYZrnThjgKy6oGcA7EdUnVJ8w7iQjGaAjjIvSndh1w57pp9w/f3+7L9mg
 NpC4cv59tvm1VVTXwMmoxGUvi8ygXhxTHAeuysWpAZgl7t22FpvqKMi+NMZ4Wj9mPP4JTHpvPlM
 BaYBNtGIsChDQM9UJTfk0OsKO+OA37nXqDd8xqGa1TJ5E7QmPvoBCuZSQR6XWSSowo4soHmmdv8
 fdXHuH4wp6lW3edtR3SlAIucAUxEaFjMmpbFgYJJ3hfm6TvdkQDkCrnioMOt1nWATFZOAB/SWug
 DEX2JktkVPTufyANjWO1ddeIBF+ZDHg483zv8tjcCy+fijNlUoyIjTdOp3D2uskMt2zWD4eQRjV
 3rBXFCFsa6WOX2Vi2Xy7y9pkPVZI5iAolltmds6bD3VXFhUz+QLBpIFZ88jf/7lTy2bsGtO4x3Q
 KmgpDa29gxBAkmptUJEkhS+BVroDA==
X-Received: by 2002:a2e:bea8:0:b0:3a1:ba8b:1e03 with SMTP id
 38308e7fff4ca-3a1ba8b2167mr75376731fa.13.1787667776786; 
 Tue, 25 Aug 2026 07:22:56 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:47 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:36 +0300
Subject: [PATCH 12/13] hw/riscv/trace-encoder.c: remaining fields to
 ram-sink as RO values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-12-f8be2f40d2fd@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=nChScbCmlZpsS/dciRJfDHDLa0YqwUCXTFFwrp2ZijI=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUj6HcUndJfplk/LTo0FbeXVuCR6RnY5n3LY
 Kk3f+59+yKJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dhYgEACTt3kqi2YsFVkLO0ZE9FQGRlLHyIVX7a4viLh6UAcYxNboclk/Oc2lhSmWIkz7R1ELUem
 FpiFaMA0Mbkn6awRoDQQjfkHt/WEzLX2s8DzaMO47OkV1r/7sFetzZZbrgIcv5KU75NDze8rUyc
 J2MtqGNYkzhUrvyKazlJL3ODTLtzFtTQx3zyzCdRqnKe7702eIXjYvDrwm+5M0GzIeKUUEEgPta
 /2lNysUQxEdfJwkCZM4UfJAVWHZajTe+o5Ry6mNgJlbVuQi2fPOLo0riFOfPzBD+Nv3ESfZDD68
 TB+IsXpD2iP8U6ZPKHudsVo3nUAgAFjZPh8+J/Vfw7y3GsCCeVplXN2pGNW22U64jt7vMc0nJB0
 JAyn9adaEd3e0W8xZG3E19Ng5oWzR0us/SP1HxYZkoVZA6QZLLNsMo0/derHaDChSrhCGgbsc4c
 YEB5LakquEytaQy3PtG15G2Nm4LiWprNgmUJYgsM9jQn0vDz/Q7cat0ky1Ce88jfIsLz/ub7q/y
 lHJ+HlpaD5Z8iECor83WTO9hIEBNZzxEnuKFVAUjOhutzj9aDkf8RNXZQySi+9BAwMO3msyKKq2
 w/dYdwx6P/BwAerQWlUGELWtVvZN4GiP9CcSfkfqNvg5qCFYlA7CgqdT+Fq9JuOlCuXAafja98G
 GPr/wgWATQSK0tg==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 - set trRamActive RO = 1 (always active)
 - set trRamEnable RO = 1 (always enabled)
 - set trRamMode RO = 1 (only SMEM mode)
 - set trRamStopOnWrap RO = 0 (not supported)
 - set trRamMemFormat RO = 0 (memory formatted as plain bytes)
 - set trRamAsyncFreq RO = 0 (alignment synchronization packets disabled)
 - set trRamHasSMEM = 1 (RAM sink supports SMEM)

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/trace-ram-sink.c | 22 +++++++++++++++++++++-
 hw/riscv/trace-ram-sink.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
index c273335fec..03ffa9caae 100644
--- a/hw/riscv/trace-ram-sink.c
+++ b/hw/riscv/trace-ram-sink.c
@@ -40,13 +40,33 @@
                                R_TR_RAM_IMPL_HAS_SRAM_MASK | \
                                R_TR_RAM_IMPL_HAS_SMEM_MASK)
 
-#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8 | R_TR_RAM_IMPL_HAS_SMEM_MASK)
+
+static uint64_t tr_ramsink_ctrl_set_hardwire_vals(uint64_t input)
+{
+    input = FIELD_DP32(input, TR_RAM_CONTROL, ACTIVE, 1);
+    input = FIELD_DP32(input, TR_RAM_CONTROL, ENABLE, 1);
+    input = FIELD_DP32(input, TR_RAM_CONTROL, MODE, 1);
+    input = FIELD_DP32(input, TR_RAM_CONTROL, STOP_ON_WRAP, 0);
+    input = FIELD_DP32(input, TR_RAM_CONTROL, MEM_FORMAT, 0);
+    input = FIELD_DP32(input, TR_RAM_CONTROL, ASYNC_FREQ, 0);
+
+    return input;
+}
+
+static uint64_t tr_ramsink_ctrl_prew(RegisterInfo *reg, uint64_t val)
+{
+    val = tr_ramsink_ctrl_set_hardwire_vals(val);
+
+    return val;
+}
 
 static RegisterAccessInfo tr_ramsink_regs_info[] = {
     {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
         .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
         .reset = R_TR_RAM_CONTROL_RESET,
         .ro = R_TR_RAM_CONTROL_RO_BITS,
+        .pre_write = tr_ramsink_ctrl_prew,
     },
     {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
         .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
index 0a7225642c..e516b73e00 100644
--- a/hw/riscv/trace-ram-sink.h
+++ b/hw/riscv/trace-ram-sink.h
@@ -28,6 +28,7 @@ REG32(TR_RAM_CONTROL, 0x0)
     FIELD(TR_RAM_CONTROL, MODE, 4, 1)
     FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
     FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
+    FIELD(TR_RAM_CONTROL, ASYNC_FREQ, 12, 3)
     /* reserved bits */
     FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
     FIELD(TR_RAM_CONTROL, RSVP2, 5, 3)

-- 
2.43.0


