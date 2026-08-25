Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF4FC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR1-0000ig-0M; Tue, 25 Aug 2026 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys37-0002zg-BZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:49 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys35-0002En-LY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:49 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a1f792efd0so2872881fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667766; x=1788272566; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kQWqq7RedaQTszwFuwjLMu+ThgSlnubcEuWTuLU4Ats=;
 b=XTIeCyqipzlO7YqTgB2AuntRREKJdO+HoLyQgtVJPajbj0eCkz8i0v/o1oONzyqJ3M
 +s78mkZD1UxN6bqp59wFkJviARRK5YBhb93ZHhEFXoSLwkT704uKlZ/AiNMJOtwNhISU
 8/dfvO48AZ4XRhtZB6Vx8Sklx44Q6GPCOMnCwtmzkb4PHLoYATTaoJhawOAr5S4YsMwI
 GgI+zydPt9mT6AAs31E990LQ3O1CBjCpUZEB0ftjA8nX+uZH5kFAWlZO6bUSBBDQevj5
 VkhX4Hd3f8h4tScKAjBxVIPNWBjQ31Tv6NKoGGaEMIpqJmW5V7SMDt0fC+FJLIdsP4v7
 qMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667766; x=1788272566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQWqq7RedaQTszwFuwjLMu+ThgSlnubcEuWTuLU4Ats=;
 b=WpGVBLMTaSJUhTPojs1KDjHe/q9q5GwPamKwBmV7/CyqXnAFRfe7BWAkTL7LGqZUJc
 18LPUjHkQGstrE1fY9zsYcvO6tNzXGv6i2VLlr7CiG8gOreXxpTMnEpCI8i619+oFJIE
 7zfVaFhmmIu5UaQJajmbtjZ4uS9KwJBbNILU5md70qhLk8r0PEQtV5eZHeEBFPlEK8lt
 PCIkRKrgkZ9sSXltav748yQr3QCATrl8LaKl7odkYd9X8faqr3FvCPBfyFpAelyrjjI3
 oyYhgJMXjg/8nYr7vnkqHMXLH0IgKwoMi3KGrMAx771EaFgMnIiCgD6bLqq2A3evyEoI
 J0Kw==
X-Gm-Message-State: AFuF++nCS1EwokbLnirmlFTXAXe6YFcMwxdnriqoACDpB5f7W4BFYpX5
 PGHagIhLPvarD4mRZVr6DgMbxoNMUKPbXaJBu/5q66lL8I0qt5i5GyvG
X-Gm-Gg: AR+sD10RaWfpNlbhlwSh8F47j3ptlQYXY91+lrWWgau5BOF46l1NhGjqlc2yE1Nu2Ra
 M9s5jlhx2gZlA2p9Jufr6nTXSnFmB06lLHkFcK0iFBmbzyeXGK409ZH1DOfsa2SV17MpMNqLCHX
 YFkjH4oDVl/a+r77AQ0H6cpU13nBNhWXuVI+7T+583pXwJmA97xC4SehCyG5yh8I470jIOF9Jxg
 Rla3Zib5BYfYiH80znLvzQZ9xnlmF/8o+1x92o3atQXIsSVGRkxdEx5nlvmD78/Ud18jO/DOB9s
 b2x16msxQoRjQbfewNQ19LLiaZdkg4hjSludmcGO9zk7UQ5zoHeI+ru38JzyOcforb1SZpAIjUf
 uwDCCHXjMmku8v8xaSvhrZYHZPUWxy/qxLSISskCvir17BzluiXA/hKqL+YgUcDlTd23yjCxYHz
 BmzqPeHzuvKDUazpkM5ROa3lYHC68ckWwYe2Il3lYQNDNAyyESRt8dkeoouTJvyJuWejMdYf9tc
 DEH+ZieR+/qpLCDFanU5juJPIbMBGngBOnor8ec
X-Received: by 2002:a2e:8a86:0:b0:3a1:f911:3d52 with SMTP id
 38308e7fff4ca-3a1f91144d4mr2912401fa.1.1787667765578; 
 Tue, 25 Aug 2026 07:22:45 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:43 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:34 +0300
Subject: [PATCH 10/13] test/qtest/riscv-trace-test: add test-ntrace-simple
 qtest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-10-f8be2f40d2fd@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=u/j6vcQM7k0pTFM2HSNc8/6vg2UaZinTYLqw9EGZH8I=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjO2g5yQ0MsohYMag+dK4GDKF1aXlR/RfnY
 2lUKDtNdJGJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dgF2EACcCKhxwO+xhni4novkLXLTm83T4n455Gp//hLAbUQqRDO1M+N+HsFEBf3vl57HBD0KshC
 sMJL4VmgMsAHGO4JRd4xoRICF97hxQbeAwJhxzbmOBs+Ch5MEFLo8qwLSj6DX9cqpnAMAbns1Hf
 NNK5sUVTedOLLEDxEcJdhks/3DV63mZwmjBCZpku86nbc1zFRQ8G30e/QmUq5SXeMQV857OfWPg
 9I+/f2BOdGoqtCr7Ow4vjL7gC6M+bsVfxC+5Nrvu+bCZ+MvAZBqLBF56xzA0H7gsGYgKNZ9nrLI
 DMqjXFR1g4RP+O/wGYkieb6TEgUQWh6GYZcKVci3uL8FcDSbrcV7zR9RoJgEVWbB2uCUkGvRBjn
 5jglDGfWuxL+kIuHdYKOzd8LqRUcHoXzldiYdJizsjWVnvJoSxs7FZLbEZOt+/aejicqeHqEboX
 GWa7pJ3ufEFIRLhNVXSG2VY4gcsHs1g7IGYmN36Y1RYhlRVTwkp2/C8crq6S6M1ymQ0mGDef1t6
 UXturTrxuN9ZB5+Vl8PTY2N9G6vHPo8nOtTeemflk4dwVCUbjewnpsYqdpIfxCywGyBHr0dNMsi
 mqWZAwo5Mo+egcjnPsp6HmuJcTFbdQBEH8bdT6wYLKTxdBFDcpstuEI2lKTGHUb7PCwXozVD0qc
 1PT0RopBJ0PuLog==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x229.google.com
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

Add a simple smoke test for the ntrace encoder/trace ram sink integration
with the RISC-V 'virt' machine.

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 tests/qtest/riscv-trace-test.c | 59 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/riscv-trace-test.c b/tests/qtest/riscv-trace-test.c
index fe1cc85358..66069f7a56 100644
--- a/tests/qtest/riscv-trace-test.c
+++ b/tests/qtest/riscv-trace-test.c
@@ -21,6 +21,7 @@ REG32(TR_TE_CONTROL, 0x0)
     FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
     FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
     FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
+    FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
 
 REG32(TR_RAM_START_LOW, 0x010)
     FIELD(TR_RAM_START_LOW, ADDR, 0, 32)
@@ -99,7 +100,61 @@ static void test_trace_simple(void)
     g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
 
     g_test_timer_start();
-    for (;;) {
+    while (true) {
+        reg_tram_writep = test_read_tram_writep(qts);
+        if (reg_tram_writep > reg_tram_start) {
+            break;
+        }
+
+        g_assert(g_test_timer_elapsed() <= timeout_sec);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_ntrace_simple(void)
+{
+    QTestState *qts = qtest_init("-machine virt -accel tcg -d in_asm");
+    double timeout_sec = 0.5;
+    uint64_t reg_tram_start, reg_tram_writep;
+    uint32_t reg;
+
+    /* trTeActive := 1 */
+    reg = test_read_te_control(qts);
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ACTIVE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ACTIVE));
+
+    /* trTeEnable := 1 */
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ENABLE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ENABLE));
+
+    /* trTeFormat := 1 (ntrace) */
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, FORMAT, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, FORMAT));
+
+    /*
+     * Verify if RAM Sink write pointer is equal to
+     * ramstart before start tracing.
+     */
+    reg_tram_start = test_read_tram_ramstart(qts);
+    g_assert(reg_tram_start > 0);
+    reg_tram_writep = test_read_tram_writep(qts);
+    g_assert(reg_tram_writep == reg_tram_start);
+
+    /* trTeInstTracing := 1 */
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, INST_TRACING, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
+
+    g_test_timer_start();
+    while (true) {
         reg_tram_writep = test_read_tram_writep(qts);
         if (reg_tram_writep > reg_tram_start) {
             break;
@@ -116,5 +171,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/riscv-trace-test/test-trace-simple",
                    test_trace_simple);
+    qtest_add_func("/riscv-trace-test/test-ntrace-simple",
+                   test_ntrace_simple);
     return g_test_run();
 }

-- 
2.43.0


