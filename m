Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E77C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslcK-0005ap-S2; Thu, 13 Mar 2025 12:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslam-0003TU-8Y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaj-0005iC-6d
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4342517a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883966; x=1742488766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=D2GOKrmSClC8JXIjKEplR8HBkvlhtxDJWx2tbMOYRX4Z+UN+7S+56lRidKKWkqc9JX
 oklBMCcKrTwe/qTWooEdKmRoIgQHbCps7B5t3xmh/BKn19I66CfYG9fUB9Qztiz5achm
 ii3MrXV2ntm77ra/h9r5eyVmeUtj5m/My3Iu+5kHL0Us7c3FpOXvwYHMBDj5p8EI9FFd
 NhBFFEKpaDrhQUPuS/Uc1JiOJvQ/YDuK3FVJglwewN9QJT8JUgvfo0+ZQAthKFNnbSvH
 ETxsiws9SHiWtQAec3VXPhpixnWrPcxMC/WSl4mwj/pOyDboYbFw2p21kxCDbKerGb0D
 Q/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883966; x=1742488766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=PAtc81G3Ixh9mXiKSpPvqLwSXHGHEejl8iHmxuzMpBb3CYBuhKUHzjcI7LkxKjK6tq
 AINng9Ox3EtD7iVU7VNkZTLeT6N7vs7HcvT2+HVgqPQaHmX7KhhNzkyVnFk6DUo/ip9r
 2KvxaxE0nNZ9IukcMHTglu/a5v6ofv7V79EmuD+ycy1uYgPVVrlfdx7B90sQy8ffp565
 2ejXjNRAUYNUF+Tzyoiy4Yi2TX7XzJGmnOUtRJLTUVN/ZHf42S/SKeQoXgBcJbwNhfaW
 s9Cy/PdND0caQl32L7Of+FmNyHzvP+/0krnoZakrQgw4etnM8sXohD6dRFWqWYhLIWpW
 IUtg==
X-Gm-Message-State: AOJu0Yy2SF8x3rg0BiWCIXIA4ph/gMbwvfwLtW+LcGaxbjzR6/N4e2U2
 VFkQRmQAJnvFcAfcaI7uOMUblf+yaqwp2imFWITZ2LFnTeVRZlk2WzbX1mhP8oBZJi+0TiCYzJi
 aDZQ=
X-Gm-Gg: ASbGncstY5h6OA7ogKT7BiT8CYOL+D+vTkgz/yTtd0mxMfMNbHW3sNOPXLo5XEBb/vR
 A4paIxc0Q0qOKQ2ZqNva/VkHCyLGsHNF2XmIDP2qH7J0y0p7BRKIDQnQC8rVdRkn4G2JFY5usi9
 Bf8gpbfyliOTpt+rip2Q0apButGISUtgnKO8Szu4uf6UI4Y0v+RTPMe05b1F8jdLs4wufNgBduH
 ene1CF9T2doHoclB/1xyiO/JvujLVonV9XWjNnj82vRgigCo3l4NLn2i0UGxZ5Bh+pc6GWIgdff
 2XxyTnLff2AE+GktJge3yNinqY04OyCrXrJ1Fc3DotJk
X-Google-Smtp-Source: AGHT+IF4AzvOcFWztZZ2bxlYvUCRcZgJhJkixRgg9I+5NbaWKKn606UlzAb4zSHX4i3sVnz0TZr9yg==
X-Received: by 2002:a17:90b:574c:b0:2fa:30e9:2051 with SMTP id
 98e67ed59e1d1-30135eab105mr4295980a91.5.1741883966469; 
 Thu, 13 Mar 2025 09:39:26 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 13/17] system/physmem: compilation unit is now common to
 all targets
Date: Thu, 13 Mar 2025 09:38:59 -0700
Message-Id: <20250313163903.1738581-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index eec07a94513..bd82ef132e7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'globals-target.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -16,6 +15,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.39.5


