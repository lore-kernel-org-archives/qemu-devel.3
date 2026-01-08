Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872B6D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibm-0005Hn-Um; Thu, 08 Jan 2026 00:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibj-0005CM-Tr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:52 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibf-0005LD-VN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:51 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34e90f7b49cso1791509a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850246; x=1768455046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bSY4ASB8TWytr0VCEt+fHQs6O0YS3hmS4Im2JKimIBw=;
 b=Q63xeGrSj3uFhvzWFOZDACIEc2KePZ90COMpF1O4/QytW1YQEFOFVLCemwSDzWXjnf
 DzW9qdozEZrf8rA1g3vEFCCiE6abz5kusMD4dNapvJtQ+QFgcswdZ6tgN0i0khNL5+4n
 jm/aF48/Fu7uhiqYlYX4gy5tJb+KaC9pHl4iA9OdD1BIeC6QDNjt2v7a4Hhz1le8I3MN
 bVaoqgZaAGSLrvs8Nd2FrzRR6DYe2cG/YiAQzivFEKAEHXU/9HAKFtbq4jEi5eXVXxL+
 nqHfjjeWXXbwL4IFM5M2gqX6yT+TEAX3GeqRSuPNPGNTHOA8ca3W+tL4tHYQkrHbaF3J
 q+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850246; x=1768455046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bSY4ASB8TWytr0VCEt+fHQs6O0YS3hmS4Im2JKimIBw=;
 b=ZdSWzW9xL0LLZu8IBdtvkLSJJ601Rg7bwzN1mNg7KrKFOS1JPFtx/jA36vKxvcalpY
 WMfLVe8W0M/ZsbjTeQuqrVJSCMx8r7QDCx0u/C6F2WdPZjA1RyQuowLkXAtOJh9TMxCn
 xLXuF12a4cGixRnQ1F7BsrChXVb2NDZB8KFJ2Dhpk+nE6uLNY+oyOXOYIEUMK644ilY9
 1eTnfllYeYmTSM1lOHfxUjydL2rT9ag6Dao6m8rKbDQPSn+lnsuNmWlJEostUfNN2WbQ
 lUCSwwFQSDdxHEvOeP6kFd8lVLVmqn98Td4QeX2dp1E5DpLvLuyRdpH13ZxGPTmYj1B5
 O+qQ==
X-Gm-Message-State: AOJu0YytmBIQhvTQDKGDoubSllkAzDxwdkZ31OhUh5SBoXr+ZSLLZNuW
 76PmgzlJStLin91qJ2wMFNEY0pJDw6EMLkI8q5PEbdLc5GqtEPIjFAIZsh1tuAVZBPpNIiIy2qV
 zmhM1TJU=
X-Gm-Gg: AY/fxX4ipxoI/1Mwz+msoko3yR9oayWsX3mYSXvOefCG0Ipsl41y0xlzkpYOwBjEaT8
 0oU6ZTSh8tI3vDP/ZFLfFbn9qzFeZNwAK9ls2yT8VFDlL/z6IPvK524LsnEiR73UM1piPkN35mS
 9RQi52K2M638NCoq7kZNDsfvxwHKzbz9US4hQkUglf5on+RmjT+DWzFGWsZUL0BqBaKsS32ed/i
 pnI+ZG8YK2EU7kbgI/5c6wiUhiNc13MmgHPap6RuA0c/vmkPMdjTsk+zepjqShPZZ0tCpcWtR06
 p6BFRj0gQiMvHnO+Fv3HOYTj+geerczXP7OPY3RK/2exdJAEwfhi4J2pO7Gj9trDuicWBcXKQzn
 PB3ckdEpjyjWpr2yYx8+3SN0TZTrzgvb2xsqzrtLLNArfc8P38JUfkWLpOJn081SCELXc4oEPB+
 B4gWFyaNFezinIrhbwFw==
X-Google-Smtp-Source: AGHT+IEnFE2z2Rn+o65yqUQwiOZi8cu2qC3Y9YSF8q7Hp6oWBmh7vKB/28PBzo5YHZWfwFabG7d2nA==
X-Received: by 2002:a17:90b:5708:b0:34a:b459:bd10 with SMTP id
 98e67ed59e1d1-34f68cc2ab3mr4472332a91.24.1767850245740; 
 Wed, 07 Jan 2026 21:30:45 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/50] tcg/x86_64: Rename from i386
Date: Thu,  8 Jan 2026 16:29:39 +1100
Message-ID: <20260108053018.626690-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index 82a974aa6a..c860a3b61f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4025,10 +4025,10 @@ S: Maintained
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
index f93447123b..7c8cf08ad2 100644
--- a/meson.build
+++ b/meson.build
@@ -898,8 +898,6 @@ if have_tcg
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


