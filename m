Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08375E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ed-0003td-GG; Thu, 19 Feb 2026 14:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ea-0003kV-7R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eY-0000oF-F4
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso10381175e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529132; x=1772133932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5TB7v7tyHLBdJFOB1+obcBAq0Ula1l0DhGWQDiRy/A=;
 b=IJFC4yGDNs38vDmyL8XpWikdQKaWn4APZX1XJv+YW/qp0x4a7wVrIZ7+SOid0olMdz
 DtL4SatAvZvda4VwVSSAafPxb/gaBrm9MhZf/HNNC7Xw8lwyQ6lLpqlL9zYc5UzA30Rt
 M22qarFFTgUjKL040xl1FrhoEWx5TAsZttXEcilWC7E5KpeUkhljBMmXMYW1YJcgJdtb
 LgHppkMo10YMVaJ4zCmidBGguGmwKPMf6cRnDiET11mGRFVmgWAGKOs56YRNVqG2yDYn
 jRYvC++zE2if1ndRnu9i7Gdpf/8wWhHZIlyprGh4BsBd/zC6R7tFha+bFQDYk3Ax8WXB
 +gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529132; x=1772133932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5TB7v7tyHLBdJFOB1+obcBAq0Ula1l0DhGWQDiRy/A=;
 b=Rws3NxGioqZm+HYaYLSvPlFPHWOR1M1PnlvkdEeeDZCf3lDaEJH9OkedBuVc070pWW
 0nqqGIO8ieU9XkTpH5kRN68EgocQA+lLBihs4GoFAg7AWbg+JcKnYpI1AuHq4TZfVjDI
 JCBBkPlylfzDbxyeEboTC/vS+xI3MKjcmui5Ac1pxTGGP370Y5u1KhJ/djATIEuzLD1b
 3Zpv+FZ5Ibx/uDrSCEj8u0A/MVnB0zurMC7OrT6ewM50IhlTTQQ1+sr0vnK0neJfNmb2
 y+MaA9q4NuIs6BNsDOGP8cCpKmWi+C5g7r6wcHOuHIFQtznSTQ6P2ycDgGSfLwiseniN
 4y7A==
X-Gm-Message-State: AOJu0YyvukITskg4SFoaq9ppp29ng989dE3aV/bvRfADAPKZ5NO/0fS6
 DCwcfE4LV/G3eYyW5Wevl9e/VUW0jC4KatyvdXBM4FLlURWIELU5D0nvdJw52162WFm2L12Ldgc
 E3hgX8MCUbA==
X-Gm-Gg: AZuq6aJCzX57+N6UzrwSW/atrhl+5xIpatrEChMcKkyzjygqEyBPkK2aFuAYLEOMSyk
 2ma34GeLwIWRBl5naN68AW6M5u0QNR8oaspWykeRAcDBzAv+qSOCSDmYnrX42LgJHekaNCb4aSW
 qSeBWGAVScdHAwl+i4N0U0uJFILqVGJ847PRqlM8cetW2BUzzobKQj+yyY3cQrhdbkCIPRkUVdR
 NRSPT7PjZ9NjR6zhIii9Myge7Qxp0Hrq5hrVoNh2RJIe2PWu9DKjVCU+NqD5Wavw9B4J/6RPLcX
 N90G5bRpqiNqDxvxRAhgYOjmnxpkqCI+TuWyIe3eXbchnzk8y+rzDvaR1v8ugMPou4oQepN2XDw
 uf4XiT+i03Fx7abbu60pMSnzjvXfXrODY51RmBWMz8BE0mOpYgf5TrWzDRiRmYklWkRbeM1Nnwg
 DDHipvRtuq5ZRuA6j6keQClMfeP9T+VavGNJ4Jbboet8PIIe1sBm2LXFcs7cDfmcTpknRPasSR
X-Received: by 2002:a05:600c:310d:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-48398aefddcmr103139015e9.34.1771529132467; 
 Thu, 19 Feb 2026 11:25:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f0370sm40122825e9.11.2026.02.19.11.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 47/50] target/rx: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 19 Feb 2026 20:19:49 +0100
Message-ID: <20260219191955.83815-48-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

There is a single qemu-system-rx binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/rx/meson.build b/target/rx/meson.build
index 86dc231eb0a..d80ced11e2f 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -9,8 +9,10 @@ rx_ss.add(files(
   'op_helper.c',
   'helper.c',
   'cpu.c',
-  'gdbstub.c',
   'disas.c'))
 
+rx_common_system_ss = ss.source_set()
+rx_common_system_ss.add(files('gdbstub.c'))
+
 target_arch += {'rx': rx_ss}
-target_common_system_arch += {'rx': ss.source_set()}
+target_common_system_arch += {'rx': rx_common_system_ss}
-- 
2.52.0


