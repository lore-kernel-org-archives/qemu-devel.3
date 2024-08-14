Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F0FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNY4-0001dJ-E0; Wed, 14 Aug 2024 19:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY3-0001cq-Pf
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:36:59 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY2-0006Vt-Az
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:36:59 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-26ff51294c4so340074fac.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678616; x=1724283416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0fMYCzEpAflnqdXJ+mHKpT1nx2a+UfFr0qfxTWmEKw=;
 b=qEDVlhdfP5D+8PmPImILA+del3wTY+XKpl1XKwhLzzkr3jR6N0o6x/61UHdPdeuImh
 PoBQ+ca2wa3J1UN90BEM5q7L/7/w3p2rEXOpnjWIWnRBQcIhGfbXLfI0Qy/3bRLdn3eW
 /TCCt5878TjbsaG9q1FWz5hMkNGDW60kMt0RT/+2y0dvMnrQq6lYYdKQxCsQaxklSsgK
 NAZCV5HCO9/VkbhJ/tf2EsljnzMXG/WFXKKp04BZ7KPgSB82oER0qCh0d9PC4xx4kPk8
 SoWxiRuxvHY57Fn6pBYvEVkBd1kqL8Gxf5DpVHITLbPn5KadZF1j/miz2npUdqJmc9Ae
 GkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678616; x=1724283416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0fMYCzEpAflnqdXJ+mHKpT1nx2a+UfFr0qfxTWmEKw=;
 b=rqxwMG4HKH7z6DTol++Vyxdx0BymIgnZyDOeYiA4Pnz+zJpbTwb8LzkZs5nIuUvC5P
 DfCTMmgUJ+5TGZNX0zeYmq63xCmKlD2jEvSybza4jrg32wB0P4MD/giGSq4mUBI4Aipk
 4G4recDQbWjwNL2kSpRcxNnNeCJ7VJ3bBAYZeuJ8KL0gTZOke+dov7JM5emQHh1lelwK
 wOccmEm0fosi0aKDDDiP2zqX5SH49UruusK51O/JuYxV5uQJmA5HU5BAMRHg67nALVH9
 cBmwBq5Vg6rJC9Dk3EJgkEJLDqvn4ghw5oT5J4E/Krbuh4yrLdReujuaLL2u6AuTFDG0
 hn/A==
X-Gm-Message-State: AOJu0YxP5XlN2NXrky1Df+fypqXymTWFudg1CKSTmAAUW8UkWTYaAxAw
 G3OodzTaJ4NyhxMDf2yu/nJHo7dKnn2CzKnZ0vtEygyjD7pgmz/YxUlUMf+Xc/ne6j3ywrsh7kD
 qcAE=
X-Google-Smtp-Source: AGHT+IHusb9SoXaxUwrwU67R+ivOHd7P1z/bj2G3qZlCj8wyEnsH0hY6Dj1UMG2uprcFu4MRRYZqFw==
X-Received: by 2002:a05:6871:205:b0:260:e7ed:27f4 with SMTP id
 586e51a60fabf-26fe5a97efemr5249384fac.27.1723678615795; 
 Wed, 14 Aug 2024 16:36:55 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] contrib/plugins/execlog: fix warning
Date: Wed, 14 Aug 2024 16:36:40 -0700
Message-Id: <20240814233645.944327-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Found on debian stable.

../contrib/plugins/execlog.c: In function ‘vcpu_tb_trans’:
../contrib/plugins/execlog.c:236:22: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
  236 |             for (int n = 0; n < all_reg_names->len; n++) {
      |                      ^
../contrib/plugins/execlog.c:184:12: note: shadowed declaration is here
  184 |     size_t n = qemu_plugin_tb_n_insns(tb);
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/execlog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 1c1601cc0b4..d67d0107613 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -181,8 +181,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     bool check_regs_this = rmatches;
     bool check_regs_next = false;
 
-    size_t n = qemu_plugin_tb_n_insns(tb);
-    for (size_t i = 0; i < n; i++) {
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n_insns; i++) {
         char *insn_disas;
         uint64_t insn_vaddr;
 
-- 
2.39.2


