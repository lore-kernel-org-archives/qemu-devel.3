Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A373EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbGd-0006fX-AQ; Fri, 22 Mar 2024 05:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbGb-0006fL-BT
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:32:49 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbGZ-000807-Vz
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:32:49 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-429de32dad9so12514641cf.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711099966; x=1711704766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK+9yRKUKzgO+toUFNyttunP9TjjWWzFsOj48XWUWIU=;
 b=ELGatM7yx6RR0FqCxnD4lFIBLOBOAlXaZxs7mmcYnn8XPkR/X9UlahYQDcf/KC03Zb
 u8M0g9/xy8fkFfb0xs/ryNkEeZs+sjyqHtpGi5ZV5zyq860NjiD1X9hckGfIap+8PYwV
 +QfPAK6OogYTg8HItHhKRFnlgZ+RGZqe+6vuXtFcHkwC2sDWZtge9MI4k38V9UAyv6hI
 gZI52AoTRBwEAfVz52YanyytIBl+1V8louN+9MjHuzNke36Dq79/kgKtnfXjBoxeqoN+
 d3p4Kp8I8xZmsupv8SQ5ztq/7SWAVxcsAjOftUwlSu/ErCDfREY0rPiE4ig15qgKWkO8
 WZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099966; x=1711704766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NK+9yRKUKzgO+toUFNyttunP9TjjWWzFsOj48XWUWIU=;
 b=nCChSWSNxn/ckLS3mCgki0XpFtLjx+qYv73xadT7cPU6sxE8mW1/EqEU5W/uAQFZKk
 f6Zc3XV1dDifb4Qejcc1cIeSvAhaxrqqQRRwD1T83tQElGUKwple3WDgQe+cbOudpD+F
 XH0lzLr/tsnDeotps3ixLgTnJXh3uHDhDFUcCUUItNfXFjujOaJqQf+tAIl/9ynyZUH8
 An/uydz4/npOxk6jqsyHychz07JBhO30ILcgMrUk0nXnQ8LSBUC1ECNu3xeotqjbSiCs
 8ud+kS9DFNEI4fv4nNeS3hXYs+t6+FuZmX7rQFRJf4Ds311XcSKN+o2vutQr4ZPkrmAO
 qKZg==
X-Gm-Message-State: AOJu0YzrMmoP//ZMeXXzjMSEo9M6g6WXEliSrhxubZMF4CqAyDZN0tCq
 bySI1Uh386WpCXQ0evlj3AYOQ0sL0GJsDUMGmUygBW/Pw7y9GsjIUNKWa6WoTXOerbw0cOck74R
 lr2dH18+C2TncnME5/Z9F8fGzTgKmkQQpJksXpM6dDAT7L9lDItPpE+hASQ6nKgCebWjkX7L8zd
 CXcDWGE92rctl02vBo40B28oQyuZ1jJzt7jgURYg==
X-Google-Smtp-Source: AGHT+IFFJCsdCgR5DUtw1hd2CwOyWmrOEhbETvWEYEROB7qnCvIBf4WgLwDNwQL5ZlvLFBkDw+G/Sg==
X-Received: by 2002:a05:6a20:1b27:b0:1a3:703c:c809 with SMTP id
 ch39-20020a056a201b2700b001a3703cc809mr1743467pzb.21.1711099580884; 
 Fri, 22 Mar 2024 02:26:20 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001e088a9e2bcsm1380380plg.292.2024.03.22.02.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:26:20 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/4] target/riscv: rvv: Check single width operator for
 vfncvt.rod.f.f.w
Date: Fri, 22 Mar 2024 17:25:57 +0800
Message-Id: <20240322092600.1198921-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322092600.1198921-1-max.chou@sifive.com>
References: <20240322092600.1198921-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=max.chou@sifive.com; helo=mail-qt1-x830.google.com
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

The opfv_narrow_check needs to check the single width float operator by
require_rvf.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 6cb9bc9fde8..19059fea5f7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2817,6 +2817,7 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.34.1


