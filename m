Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5854E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHd-0004J5-S6; Tue, 17 Dec 2024 17:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHc-0004Ij-Sv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:16 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHZ-00018j-39
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:15 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728f28744c5so5443533b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475391; x=1735080191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMDwQlE3l0KKa7P5lbeW0nhoWgR5/Mui2HXPodnjcRo=;
 b=EZaar5tKTrCAjHivfNNmdLuo7DHj2zJTPwLO3+tQ2/tsN0Dn7hX0AbVvN7YoEtuipj
 qzk3+eR4DJiXyE10e446UXMn15j42j7lXCs8PII+1qnW65EwxdLw9nzsuGDfQt8LjT5t
 ZeBLzUCer8fKiuoPZkrUjzl4ESra/1NlHCm8amURJFK6QVipTJMh6TfipxAW1FQsNmlz
 ydbkdVGXq8QqQAzrbuwn0/aB3vbWxBnL3q0T56/x/8hJcGEjerwN+GYBdj3AMo4txjs9
 VGgpKTkNLJILWe6WyHjhR0TXu5vlOpAF0z812eaKjJB743dCNM/fGLrwhJYVTarfEey8
 cTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475391; x=1735080191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMDwQlE3l0KKa7P5lbeW0nhoWgR5/Mui2HXPodnjcRo=;
 b=nbWHA2naut8nT4P3b3HPGCenPM0ScApzQAYqs3fcVn3hyDJu1lVjWXT8JffoEvivyV
 Cq5vKxvNs2nFJ06/UUZWh0vsuresIMXX0lFGs1UgwligcStxcbVP7uCzYVEb0RhQb3Iv
 EsSzLNhjyQddAFjF0OlarzYO6juuVIUxd+La3NfPjDPpJHMCiFXkoi1+9uZcx0gJVAXY
 L6RRE01kGFlR5yEjKTPcowr7xL8BKurZDednRhznM7I2kPgswSJBxU7EU5DBYG/aPoQI
 AnbwxZYi3P6JyOLhrNfHxj1L9cskDaZUpBNm92jZVepaRzitgMM/otd3FW2unDJG9WIS
 cwuA==
X-Gm-Message-State: AOJu0YzxojLQRmcnBBz/Ncnc4/95RiuW3EFyBl5BE2ejdKeXL7mJscPD
 ilgsKzH/CxUGEiby0BIcYXT0+2WmIClM39VEwyJVw85owh16RXV7+WlJTNIxgXI0tMwuedMY634
 cuco=
X-Gm-Gg: ASbGncv9/sQH7l0wmcD944MWCqsS72FxHBMjxzTicCBbM71vsTJx6OfWVIzwDys0POh
 X4TYPtpw4EZecHps9BFFoqt46ZZQz7vVmfAAPWtj2Dcc7X1CbY6aBOhk68gTvBUblSx2GoDod+5
 nMv4wMMo2JoBzeUGmkJRMBbrDVyEY9oH5PgNPSyi8arNli5iMhBVMZ5oGst8361O7I/izhXUWS0
 RDF6Tr9DGDH9JkGrufq0wyI7xB2z8xaZnwPYObfJ4k8RK9NM3CH/g0o
X-Google-Smtp-Source: AGHT+IE8f34zBMELnL4l1SA+4UpYCaULbwZkjbMJqC5q/RbITjhIlarLbDGtwX+LOYyZbtm8SNZwWw==
X-Received: by 2002:a05:6a20:6a1d:b0:1db:df34:a1d6 with SMTP id
 adf61e73a8af0-1e5b48a4612mr1126803637.42.1734475391556; 
 Tue, 17 Dec 2024 14:43:11 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 01/11] tests/tcg/plugins/insn: remove unused callback
 parameter
Date: Tue, 17 Dec 2024 14:42:56 -0800
Message-Id: <20241217224306.2900490-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205d..0c723cb9ed8 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


