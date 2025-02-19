Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC680C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 16:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tknMN-0004UL-VK; Wed, 19 Feb 2025 11:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CA22ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com>)
 id 1tknMM-0004Te-8X
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:55:42 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CA22ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com>)
 id 1tknMK-0003vf-3C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:55:42 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc1a4c150bso13492885a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739984137; x=1740588937; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tSS/crWLI1n46EnaE/CdO35FER4SHdPfAC1ZYsNG/S4=;
 b=2GfOhoNj0ay6GDdt22Fxghb45GN/mhIqHQGFbBJA3LFesw458f63Pv5XS5Zr9b3g61
 faWFKA7VhWzKNpcnBQsyu6vMzIy+78nZe5dKkhY7G9jNxzIuEV1vGXFM7Q9pW9mIoym6
 C+QWW5FP0zwGLJ8ieUH0DXrXgCfEbX9bY3MzxKl5OESfteYt3dE0T8kBWUMhTuOzZdEw
 lKei+Fnra+xHzhfaea+v47AiM9+JG673J/i1hlfxgKPcDiPOh0wN3lxnGiJI8LdzUiQu
 p5qO1wtCd5lYHBgRxoxtURPoCIeyB2WK2oGitDSEQjdxG9io3+iJATnMGTzTd1NGWOVE
 OuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739984137; x=1740588937;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSS/crWLI1n46EnaE/CdO35FER4SHdPfAC1ZYsNG/S4=;
 b=Rh5aYaukrCYUoiLy9/9a/46M4ju60D0LWlVjw9QimejfM8WpkGx0pbR48DUBQgxCaw
 WGB6XEkHIuzTSXT9AYhGDkf67Ov4H/g2P8HySLy94lawpz1+xG8WNS00FnEXs6j9Otzr
 qNkuDH8YvlHKBwWJvD1yKwy0uco2uLof5zhFghji4OXhQ8BRjdH8UI++miuyGhr6g7gd
 Ay9Gp/Lyrl2ytxogNVj/jjRIKNT5949s3/RE3zHxzSDxtJhhnuPF28drrr3USHrsOuSL
 /Nw2+wgsjzNeUnT5jlKRRnYLemJNxur5OWDl190l54omGT5hkVSzFiODF25c1aJSsNQs
 VZUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgsca6sllOFRGPugXKKNvs1mivcuSYWYIbdjARnAiWuvCZ5TUJUkaQtheriYqHTEUhRHI7WI0fLN5L@nongnu.org
X-Gm-Message-State: AOJu0Yx4YgdBy2WHS1CAphVBGHepWgGsyvQVWPhXLsmvr893pSikKjhI
 6SKAsnZTyyFoier5O7bZg+8ISTkDD+ATOfLKdsf7Ler2zxHDCdKlYkl9N/iEaZfkiV5o8cFv8fv
 WergFuoJ5ejXBsr1Wfg==
X-Google-Smtp-Source: AGHT+IFH+Q3EjrukV0Ud5+e65AuFs8Bi2I18AIR8q9eC8aiQqDBpqd+t1Ok/qw2QzOdSwqEBKNIUJzohu1PFiWhN
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:2ea:4a74:ac2])
 (user=slongfield job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c4e:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-2fc40f233bamr27990118a91.20.1739984136776; 
 Wed, 19 Feb 2025 08:55:36 -0800 (PST)
Date: Wed, 19 Feb 2025 16:55:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219165534.3387376-1-slongfield@google.com>
Subject: [PATCH v2] target/arm: Fix signed integer overflow undefined behavior.
From: Stephen Longfield <slongfield@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, slongfield@google.com, 
 roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3CA22ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The problem is internal to t32_expandimm_imm, the imm intermediate
immediate value.

It's extracted via: int imm = extract32(x, 0, 8);, so the value will be
between 0-255

It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,
or 0x80.

Values between 128-255 multiplied by 0x01000100 or 0x01010101 will cause
the upper bit to get set, which is a signed integer overflow. From
Chapter 6.5, paragraph 5 of the C11 spec:
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf this is
undefined behavior.

Though this is a minor undefined behavior, I'd like to see this fixed,
since the error is showing up when I enable clang's sanitizers while
looking for other issues.

Changes from v1: From peter.maydell@linaro.org's review, only changing
the internal representation from int to uint32_t, and leaving the API
types the same.

Signed-off-by: Stephen Longfield <slongfield@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 68ac393415..d8225b77c8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3510,7 +3510,7 @@ static int t32_expandimm_rot(DisasContext *s, int x)
 /* Return the unrotated immediate from T32ExpandImm.  */
 static int t32_expandimm_imm(DisasContext *s, int x)
 {
-    int imm = extract32(x, 0, 8);
+    uint32_t imm = extract32(x, 0, 8);

     switch (extract32(x, 8, 4)) {
     case 0: /* XY */
--
2.48.1.601.g30ceb7b040-goog


