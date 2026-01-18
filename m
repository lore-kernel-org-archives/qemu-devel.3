Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE3C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhati-0002Jx-8o; Sun, 18 Jan 2026 17:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatF-00023J-Mc
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatD-0000XJ-Qz
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso23157085ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773894; x=1769378694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DzNQby4LQPUtVLwqs2IyxJ1FWe8jwshY5ovM9t1IBI=;
 b=AexYOkVuzDgojLEiFY5jIX2z7WC/gDCD0B1QXFr0XXw4RScvIZUHXkADVMfsBGP/ab
 k8ccj6/aBQIR6/G0GhPan8K/uvVDTZTKmjmgxAG8DByEOiowDdC+h/bjJ+HnLWoLNZez
 iCi2NrBc00jJmbh4653KQTyF2R+XGWL+x8pDQKZJZvwdSQPq8mU6JPiZhocasXBl2ffs
 Q7Nz5NO5dLu36VH873jz2fAgSj8uSc2naFScLo6LGrh/2Oqj/1KXfrkAZNQ35HnVgyR0
 YmZBX1sQaGOgIGJ7jhyik8StK1MbJfHeC9ddeAalwf/uFvi8VvuDfH3Zjx65heZ3ELNH
 boGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773894; x=1769378694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DzNQby4LQPUtVLwqs2IyxJ1FWe8jwshY5ovM9t1IBI=;
 b=dUjIJKj59e0xk4e6hgyr2MPL8mp00hEdlBkcw/UiDdFvZZt8ZpvVpe1zLY4YXaK7o5
 NaaraWSa1uEGlNF3KTCNW31B+t08xX5DsWwfxdH8PWGmW3LTcQ7kSAZWchAI4dBkvrVd
 pomgNKGj/reVqNKXhDKhnOEK2n+3m4QC9yPVob1Z2uqv+ZSFdV3qw5VKO18EfeUjM2wK
 eTU9jp2qlKz+DkvymneLlYT4TYzVcC+21I8ofxymanl/83pIGNIyQM1WXYBdl0TurTkA
 a210U4EdOUrSnCDhA5L3CnXh7yj5p5CZPNFVKXBpFmiJZVtKUCdM5lU++nmrol62mpvN
 WrUg==
X-Gm-Message-State: AOJu0Yz8tvBaF2Im0iyutfIB9yqZSNpaFkq1FKgZ+wMmOu8gKo7n3PT5
 fJih2t5BV/h6oEWn4XHRJLHqAy2Zk5T14UUiHDdZCwj+AjN9ACIP1OPJq0+jMYs/gJf14XBQjfw
 ELzPIltmc7A==
X-Gm-Gg: AY/fxX4lim6S3FGx1hcXDB7se3vZClRjgDn1rDLqS0+Kb6sItic99fnLPWyZeBHa/7M
 ofVvgv71yTLXgOdtSTGPUAFpWuxmyNoPWOcWhRk/YJ5ym2ShSMgshm5JTwWsdfxl9euhNxPAHyO
 5qkhwydzcoOJTa8MkuslUMjl5i5HFq2o5ghuIJi2ynr9H2onUgAkPKEMZeFkMPSxuizgretqSV5
 vgCyd4y6yMWIbri87mpIAS8b9LHnIVpPqETXuAYXCDuW4kjmxRi2QmYIr+NnVwm208dON3O1MZT
 PtHohxkwlvX8ezdF3DREXSABjkZRqeOMeYM9ugtVElZKhT/Kg8dWRIu4TsSRdVwrZp5kluQeDfA
 elyycoGdZZDDoy3XcWHcAa1a32f9aLkt/LeHiF5+oO6290+bVbsp39KgPaL79FsDVtc2g+QJGQ4
 DcmS5NtXJuMqVGo2pFTw==
X-Received: by 2002:a17:903:4b43:b0:2a7:3dab:ca99 with SMTP id
 d9443c01a7336-2a73dabcafcmr14650045ad.26.1768773894171; 
 Sun, 18 Jan 2026 14:04:54 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/54] tcg/x86_64: Rename from i386
Date: Mon, 19 Jan 2026 09:03:34 +1100
Message-ID: <20260118220414.8177-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Emphasize that we're generating 64-bit code.
Drop the explicit rename from meson's cpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/{i386 => x86_64}/tcg-target-con-set.h  | 0
 tcg/{i386 => x86_64}/tcg-target-con-str.h  | 0
 tcg/{i386 => x86_64}/tcg-target-has.h      | 0
 tcg/{i386 => x86_64}/tcg-target-mo.h       | 0
 tcg/{i386 => x86_64}/tcg-target-reg-bits.h | 0
 tcg/{i386 => x86_64}/tcg-target.h          | 0
 MAINTAINERS                                | 4 ++--
 meson.build                                | 2 --
 tcg/{i386 => x86_64}/tcg-target-opc.h.inc  | 0
 tcg/{i386 => x86_64}/tcg-target.c.inc      | 0
 10 files changed, 2 insertions(+), 4 deletions(-)
 rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-has.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-reg-bits.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
 rename tcg/{i386 => x86_64}/tcg-target.c.inc (100%)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
similarity index 100%
rename from tcg/i386/tcg-target-con-set.h
rename to tcg/x86_64/tcg-target-con-set.h
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/x86_64/tcg-target-con-str.h
similarity index 100%
rename from tcg/i386/tcg-target-con-str.h
rename to tcg/x86_64/tcg-target-con-str.h
diff --git a/tcg/i386/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
similarity index 100%
rename from tcg/i386/tcg-target-has.h
rename to tcg/x86_64/tcg-target-has.h
diff --git a/tcg/i386/tcg-target-mo.h b/tcg/x86_64/tcg-target-mo.h
similarity index 100%
rename from tcg/i386/tcg-target-mo.h
rename to tcg/x86_64/tcg-target-mo.h
diff --git a/tcg/i386/tcg-target-reg-bits.h b/tcg/x86_64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/i386/tcg-target-reg-bits.h
rename to tcg/x86_64/tcg-target-reg-bits.h
diff --git a/tcg/i386/tcg-target.h b/tcg/x86_64/tcg-target.h
similarity index 100%
rename from tcg/i386/tcg-target.h
rename to tcg/x86_64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a6e5bbafe..c39a8f54e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4057,10 +4057,10 @@ S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
 
-i386 TCG target
+X86 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
-F: tcg/i386/
+F: tcg/x86_64/
 
 LoongArch64 TCG target
 M: WANG Xuerui <git@xen0n.name>
diff --git a/meson.build b/meson.build
index 7993e4cfb9..594e7d42c0 100644
--- a/meson.build
+++ b/meson.build
@@ -907,8 +907,6 @@ if have_tcg
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
-  elif host_arch == 'x86_64'
-    tcg_arch = 'i386'
   elif host_arch == 'ppc64'
     tcg_arch = 'ppc'
   endif
diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/x86_64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/i386/tcg-target-opc.h.inc
rename to tcg/x86_64/tcg-target-opc.h.inc
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
similarity index 100%
rename from tcg/i386/tcg-target.c.inc
rename to tcg/x86_64/tcg-target.c.inc
-- 
2.43.0


