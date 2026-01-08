Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DDFD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibn-0005IN-TU; Thu, 08 Jan 2026 00:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibj-0005CU-V1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:52 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibh-0005Lg-FF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:51 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c0bccb8037eso1422505a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850248; x=1768455048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iR23AdMUntYuGtO0A2og2OYh7o9rVIfnr1jwtxBvY28=;
 b=ThaU9mWOsc0pwYYT7XQpH0UyljD4PwMVni9vp0apjZ1O4H8fVaJv2pmMftSVY5UZ+E
 Ekv5sy5OkNPUrCRdgxjMRJ8thPj2MUSxoOY5RHXFNV6kN1w+VtP0SrBlTKswU7OV9bs4
 vbthDFal1Fkgq1MFgNop1OLkPl/cgOwAMBqoP8aBAYVmRWmZ1PKzYHLaftUBnBW4H4oJ
 cpzypcoK+j8tPW0tt2v3ze+ovYtsl9Dhb+lyKl9jRax6UfpPGlpRn/Nez4fN/5z+8wX6
 vFF+l34pBM8MEpS9YNsFUXR5lcMJF6Jt0FfuzE1vxBWzz/GL5hPvsedCdk3EPHd1hldJ
 SXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850248; x=1768455048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iR23AdMUntYuGtO0A2og2OYh7o9rVIfnr1jwtxBvY28=;
 b=pycWyUS7BnJvYKRaERgwm1nejHYptb2M0m397BbD84oR1AfMNp2UNimjt4c7EyKWRF
 oqV+XvUi/ZKBQzni1Y8zKYehFLx6ZvERcW5nuWkPzHkzBnE3YhHpXX9l5lm76CRTEVki
 3x5yDE+5JsKuEF5yYLCfVRwYC850FIj9NViPBV0PrTm9KSyzdkl1c45cq1Maamz3ZUU+
 I7WyIm1wmFvg+K3KI8Hw0Sv2wlsJ5StAVI7EdKrvwoLKlPJnvm6TludK83v9/IC0YcaD
 +2iazIghSXaImh1FmgOdigGVDQlBEbhfq1doZi5dXjJPcTMNSEEiFsfTQNFd4fANFmre
 0XYw==
X-Gm-Message-State: AOJu0YxnxkWRLQSExKk1Y/5IZeunvuWkH1+RQN0Ts5psM9al1kYVEBPQ
 PrNuoeLknvmsIfj6qENboFf2a8/TgOAWMfFZtVnDJ4ocXpoqUAOfhKy7Pkr6ZN5Xg7v/pg7myAe
 u8XW2H/g=
X-Gm-Gg: AY/fxX6Ej6l4hFK7MLKvvM/yZxhnYjDISPE3WYbuk+cNfTPE/NMm82ub+5K0v1GHBwx
 AOzvtfyob74KtQgQC7o90kOfSAWeoKe4t6K3J2lOTIOEcbL9PVp6nfXp75gErYDesn/4VOVOL31
 YeBeSzCrivFkJawE6SQSBHZWdKGs0FJoZ9qnq+Ui/dEBum7zN3Pbafsz9kUD7+zqyk6IwzJ7SpI
 Dym0K8vzA7LAdIKoJ+6fksV3XBUzxOu2mz3nOgj1ege4MKaNZ0QvZ9fQ9oE0Vbnwbb3OoB4BGuN
 O9Qql/iJ8sCG2oLCQsoPSY/cFsz1Lj0O3FVEswKzZtbXltjJUd8vb0Qbt4MS5Kvm53EXeZ0Fxkt
 Ds32yR7w+2DHxbg5SAFYomte2eHTYMfoEpj7MnpEShsyWq7stpqDZQTFhnn85oftFDkAARlqZhC
 PpBRbabBK885o1P4qdRg==
X-Google-Smtp-Source: AGHT+IGI/713iTR4T08316KYpZr+iF/1eFzhBlqqmFvU+igiQKMpHkbsBYqsNM6eNT1k6GR2KLzGdg==
X-Received: by 2002:a05:6a20:3948:b0:366:14ac:e20a with SMTP id
 adf61e73a8af0-3898fa65ebamr5022793637.72.1767850247600; 
 Wed, 07 Jan 2026 21:30:47 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/50] tcg/ppc64: Rename from ppc
Date: Thu,  8 Jan 2026 16:29:40 +1100
Message-ID: <20260108053018.626690-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Emphasize that we're generating 64-bit code.
Drop the explicit rename from meson's cpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/{ppc => ppc64}/tcg-target-con-set.h  | 0
 tcg/{ppc => ppc64}/tcg-target-con-str.h  | 0
 tcg/{ppc => ppc64}/tcg-target-has.h      | 0
 tcg/{ppc => ppc64}/tcg-target-mo.h       | 0
 tcg/{ppc => ppc64}/tcg-target-reg-bits.h | 0
 tcg/{ppc => ppc64}/tcg-target.h          | 0
 MAINTAINERS                              | 2 +-
 meson.build                              | 2 --
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc  | 0
 tcg/{ppc => ppc64}/tcg-target.c.inc      | 0
 10 files changed, 1 insertion(+), 3 deletions(-)
 rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-reg-bits.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target.c.inc (100%)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc64/tcg-target-con-set.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-set.h
rename to tcg/ppc64/tcg-target-con-set.h
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc64/tcg-target-con-str.h
similarity index 100%
rename from tcg/ppc/tcg-target-con-str.h
rename to tcg/ppc64/tcg-target-con-str.h
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
similarity index 100%
rename from tcg/ppc/tcg-target-has.h
rename to tcg/ppc64/tcg-target-has.h
diff --git a/tcg/ppc/tcg-target-mo.h b/tcg/ppc64/tcg-target-mo.h
similarity index 100%
rename from tcg/ppc/tcg-target-mo.h
rename to tcg/ppc64/tcg-target-mo.h
diff --git a/tcg/ppc/tcg-target-reg-bits.h b/tcg/ppc64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/ppc/tcg-target-reg-bits.h
rename to tcg/ppc64/tcg-target-reg-bits.h
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc64/tcg-target.h
similarity index 100%
rename from tcg/ppc/tcg-target.h
rename to tcg/ppc64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index c860a3b61f..cf7d2fba2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4047,7 +4047,7 @@ F: tcg/mips/
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Odd Fixes
-F: tcg/ppc/
+F: tcg/ppc64/
 
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
diff --git a/meson.build b/meson.build
index 7c8cf08ad2..f9fb76ece3 100644
--- a/meson.build
+++ b/meson.build
@@ -898,8 +898,6 @@ if have_tcg
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-  elif host_arch == 'ppc64'
-    tcg_arch = 'ppc'
   endif
   add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
                         language: all_languages)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target-opc.h.inc
rename to tcg/ppc64/tcg-target-opc.h.inc
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
similarity index 100%
rename from tcg/ppc/tcg-target.c.inc
rename to tcg/ppc64/tcg-target.c.inc
-- 
2.43.0


