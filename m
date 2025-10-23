Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A377CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv25-0001hb-Hr; Thu, 23 Oct 2025 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv24-0001gf-6T
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:07:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv22-0006Mg-7t
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:07:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711825a02bso6620705e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224824; x=1761829624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUD9VjEjc/+uf3h+hW1mjHVxk+h9JxXhL/sKrTHkMf0=;
 b=GCJ/GRgpDsjh9xA1uIy9R2HzW0BAItUg2P+I8ZzOWPrJbOT+IuL1oVtiSQT/jcpt+Q
 bUICuH52fiAmpraKMYM/7pijKgmgDophvU09eHqQCQ9rH2HgA3fEYPG/5lSI6V+EiBQf
 IGMvNZj1xsXqFkDi47MlEqbEwDoihom510rl/iUrUktANqyBkM0ThHt/ovMNe/Jq7DG1
 MrRRDQCIoRJek+aAxRNBPxeaBN/2AyzjCGL/IyVFU0RE82VW75YNMnFuv3tEduDT1ric
 QzCBI8eBmBYk3xXO1CvijZ8pUOe3WBPr8bgWcoHzcEqDKBVIYjaWQHdPTMx57n5UTSZW
 5nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224824; x=1761829624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUD9VjEjc/+uf3h+hW1mjHVxk+h9JxXhL/sKrTHkMf0=;
 b=m8PRA3N8aOIC/QxfKhML7WvMwa5KPztONAK8iA/v5y2zNh1ZTcE6edw17ulCSCcp3+
 4dFlFXKI/VguZXRfPt88CMuJGavy2Psrs1oYLSARAL16IvY+e/J9WJxhiIDDFqenfj3a
 U+l3DL8Cj9fqiff2m+VMVWKjF7ULQ/4HdyaRDiXcWDO3F32/XyEME1OQV5O4Dfu1n1ID
 KNxi3EunjCl08MzIx0SnifLh//Igtv2+h+70EbXwWByrDjnYP5FH+63VZIKaRj8RxdQw
 65xKKnJhAXEdSUrdIvZ1Jc3PO3l+I9S2od0gbLekls3xHGKQ1j54izTHe+NS+6NblQ60
 O/Hw==
X-Gm-Message-State: AOJu0Yys9jJ+LI3+WntvpSKzoHQezrQF1FjPqsXllPElvX2Qsp1eTk9X
 jCnWbK8poDcGa5iQRNY3WKOpAKzm7PoUeZxTo/iLnm2QvKeDlHDmZWgy8bpRDXRRSqJPVysartf
 2Wlyf67M=
X-Gm-Gg: ASbGnctkQGwrRvhjEwmTsn3Qf0lZ3s4VAGaC3v1QuckPVbdizQzz6ouIu4MyMusqM11
 WqBTC4/GAQY7nCRpw/+x7/1MepnUqaAdtXypOI2x0rcSaPIfNbdXhuMWxZdshwNHhDxt19NQ1mX
 YvXweYVWo5w/aUyYuCd40O/zxNNKo3xZmtR4HIvUA9kf+r0HOlIOm2aWIT3z3GmtL7GhnA0Zf5p
 kg3CLTtqQVqBQfND6kEguOYK/Rlhsw5n5Aa6YCy9BJFrLnuGOXtIMk3rJy6vLTjDMZocbCJr368
 2zZGer6vQM8EN4kmNSpHA6l+PIMJxBdbpqKPgD3udCJlGtaQC8vn43vJmt8mRhmFgJiOA85Mhye
 2j4/9ZdXh5MYOyVzolEwcfCNHPdOJU3JjfeGYTq1gqy7qgmuDv/frT2NjB4TJtlrKufH1X5Bv7C
 R8c9AwP+DdokAoAIpdn9jC08Azev/of9zH+QDTQDBgvyxSGLFDTRcfnNVkFVSP
X-Google-Smtp-Source: AGHT+IENDPQ5lhOGTVg85xuMpTGQAYdvenEYRDfQGhyjdalAp0NV2em7ZAGR2Wy79H4xgqIFNeHX7w==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:ed86 with SMTP id
 5b1f17b1804b1-4711791fbdemr173502435e9.39.1761224824197; 
 Thu, 23 Oct 2025 06:07:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4281314sm96584315e9.4.2025.10.23.06.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 49/58] target/arm/hvf: Flush vCPU registers once before
 vcpu_exec() loop
Date: Thu, 23 Oct 2025 15:06:25 +0200
Message-ID: <20251023130625.9157-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c83bffe46ad..36fa67caf62 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2011,6 +2011,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    flush_cpu_state(cpu);
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
@@ -2026,8 +2027,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
-    flush_cpu_state(cpu);
-
     do {
         if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
-- 
2.51.0


