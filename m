Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754C606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weppa9YB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxC2-0001KY-3a; Wed, 28 Oct 2026 02:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBw-0001Ge-Ji
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:23 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBu-0004qh-1W
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:20 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-181516de561so523748c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793169071; x=1793773871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yUNIvB3FxzBkZ+ejHoX3nLFFjBvTWomjc/HNnaE4vXI=;
 b=weppa9YBwaB4MecJm6cO6YV+NuuL8rCNU+isly7DeKTpJASKRMiKmiuAg//lPTJEKK
 J24wyvRbAl46gVv5DVSIiIXpsKkzxRRMJe1yBGrfNHzhPJe3x9Tqn6MO4JVmpWckqPb5
 ekRuEmW9V+tc8af+quiCcCtbbWNLdmbU+lmYO/NVvKWpNWwudjjvDgUHUqgSE1h9Ikbk
 nMjWOnS08kSjyspnO3XtTYXelD55818mwnjtii7sbeOlUYKSlTw1smJkiBfZgKQvX7sq
 +c54qsoTEj8hyxG/V/GsRzJACMIXkUbL3UYggipZxWAXjY9Wxbk+TyoB9fl5OVPunzEK
 Hrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169071; x=1793773871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yUNIvB3FxzBkZ+ejHoX3nLFFjBvTWomjc/HNnaE4vXI=;
 b=qRwDP7zHcZCIPzf6FFC2egjAJSnad1bgcogkoKKKAQPxvKyAtMS7/+rHQXO4vhSuoQ
 tqVRUYV1o4Ht/HRHseHPFZ2RyRW6Jn/XSNQ0bgKenGYMaTB11+GuIoZG6lUIBSPe3qL5
 J8kRIHZpy6LhVBYl/hMDrGZ2UWqNAZjgM2AiX/oOJa6OYRO9dqi209eatLHIPFc1zRif
 TpFsjzo3BowMNp041+VCvCCJw3BG//1sATez7cuN1bFoAiwhH4fiGmqvhxoBf+Z+t7VL
 NhWt885i8XmzLMT+mKU2RANES+HmF5aiII7DvrRgWy2z6yfPEjFJ44ofDwb4P/TM57E5
 De7w==
X-Gm-Message-State: AFq9FYLXmxx8Z8GFYhLOFtQkji0ipN0Daz/zKac4TDigU9qRB7pa02b7
 keqcKLqb71TbgbRyyqY7f/UTLpWGtHwWblP42O6LmJPjlDh3/sL6cjgSLSvqso8b
X-Gm-Gg: AYBFou2UuLi2Wfn4eu/T9FQ6QrXAZlYXce2G2D+6GGtTqHtq7357Snvdzfu0Isga8eL
 HJEfgQ1+/pAUaN1Ofbw+i1tqDIZbIZz5gujQi+6KZRaN2W15cag2K5sVtOvYlDyyg4aMWgLHMo4
 uI1LU0NPYlPGjn7UnG+AA/Z/WdcVkHnD3fRgb0Tlhku0GjaEDoMJLkrAfSN5Nx4dhTTMs5YE/cd
 3g5h5zNxF7bN72sA3iBWpjEGNBRgWxdHvHnWS9GlUMY33Xgflzz0n9CQE6A+ARe6LmqJGxDJ5p7
 dR7Hw/L/Tse1HkYbi0h618Lrwp81L9L8Wc+iY1I0Gpu7r+FyXYBQHvSAQ2bfriJg8mi9tLd8MdH
 PbjrYEIFkuQsocC8f0upLnveW6VTkPYsBicfZ71/R27f/8j7LTvzZpI1DkXkyjIoK1ZAVq6+G/5
 nhKpuQl++3rsnGp1+KSoOMgISGgHF6xmsXQcobDOn5sbUjmyMbw7+mLSXpE7QRuhxLSYzGRah+i
 yG/oTlaP+teUovMXcCFvlPa0qHa105CE5xu7WwRjSUXsIalXlqxyhSUtv30YxafWyHf1euFhji8
 vj/ndj81JRJxLeVUUwdL4txgJn3Mg290QaasVtb3tXagzt/OJQ==
X-Received: by 2002:a05:7023:a49:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-1a79e564725mr721664c88.20.1793169071311; 
 Tue, 27 Oct 2026 23:31:11 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm4512584c88.14.2026.10.27.23.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 23:31:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 3/3] Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu
 to riscv targets"
Date: Wed, 28 Oct 2026 14:30:48 +0800
Message-ID: <20261028063049.2530-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028063049.2530-1-luoyonggang@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is redundant now as all accel-$cpu_type parent is already registered.

This reverts commit ec65e16fd2ba012d57b1bbfcfcd04c31c4111924.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2a7796c382e..1369b7c4ded 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1754,7 +1754,6 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
-    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.55.0.windows.3


