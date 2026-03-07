Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250CAF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyylS-0007IA-Hb; Sat, 07 Mar 2026 16:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylI-0007Ef-Il
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:36 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylE-00044A-OX
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so67904505ad.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772917226; x=1773522026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b3XgTKQvoAxwK+/6vlXUOVW4dXCKXl37nga98TMRqsw=;
 b=BBw1ECxf3VZIhAecvp4BMeXpYViDRsm7jED3KJKG4d7HbWfakhchqydPYPnzD1huAl
 yYkVzLe1iUr0DXF0X9pz00hMzIFXhJQ7nMw0UjDV9LOlJ+Auvxd+tjR4YLwI488qjDgV
 akDKap/27Fzh4jjbgweaabLIv6nv25TBvEdffgOPRL8vToSDp5shj/UH8jmrF+Shm/Nm
 QWEC8PHKU2y4yZTGwbbphlKVbDN0R0CjpArBz6Bpl0m2NCgfuzzkIeo3TwrmIO739bRk
 Leo//9RL0VTC3pP+Wf8efXtFknRSfYLNvrznBCZWhMMx5/J/M+UHUSDJn8JHbwPyoan4
 SZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772917226; x=1773522026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3XgTKQvoAxwK+/6vlXUOVW4dXCKXl37nga98TMRqsw=;
 b=n+e0GU/dmDlU10zDi8pW2ZP6vNTBP620QgCeWUvXtE4cZKUdE4YTR858WpE3DW/b7d
 ZrSC0R37EFW+ICYpJNsdjQRZlzjjXrkfDmSAXeCeK9WyFq0wMI1gNBHvEn5ly+DzfUMk
 5Q0cc3zd5vG0JDABh7LS0CTv0lHS+CcbxKyS0VCH+N2D0PQILCWwayh3TEFQ9+pPKXee
 bfX5p72DMwiVaC6pjEnOZiCwjCyQThfuT+GhqkKR0qC9USyyL0QzEiH6AY+wT6zcenJ/
 t87RKWey5Bf9mFWEjvXKdUrHKDghXdxlnLnDkT5E0xs1FfwkDbxUyo0efHaZCOEdisbA
 f82w==
X-Gm-Message-State: AOJu0Yy8tl+TfUCHjxJAtozWnpzGALVPmvfhOYreuwFicNvlImIHm6kR
 aIywz0vioZoHAL1nSXYoDeuGIDfyasq2rh6zHaBthnGYFWWZ5FNBhVYUJSu8+19v7vBgEhEpD6p
 Jo58P
X-Gm-Gg: ATEYQzyLHuD/SOZv1iWo6XIdT96E5yRtTscExmwm7fYD14KNFJe/WAhRjDj7h1WGDXL
 GQgUS2U1CiJqtlg2N8H9YrXwri2e42XpDcISJB9rCZAEOzE2PZT/9EdYjvwLxEaZ9Orvfy3NjWN
 cWEkezJPPPxXK/ZEVTAtFeUoAlCUrVNZj0d7q7IDZC45YHxHKcWAOly8P9XWRzrB2NYVxlz/Ipr
 chnr92hQW4JYy9vPO04cTvDJuwHQieeXM0i9cGYoW87eoXFTjwO0/vUqlgCTa/kbUEb59y3jC95
 Vg9UxGDHG1jeyvXEW4+v/zAsDE5pz11JRvVET0PBo38WJfPGD6/gMYbfORDFaEywcr82erTEM7H
 qajKBKwtyVpxhrz8myi3aDsCoYQlBs8JUhRky7o8Q89S30nfua925US6cEc1+g7t8/zlWK5UFUH
 6bxEgnLVTFE4BKpaT+UwlkbbQFBwrvwdZD4y4L6Uts9pH1+bWdVpnUKg4RLx7mlSgypZS4z9Dcg
 D+dWsd7aurmSdY=
X-Received: by 2002:a17:903:1aef:b0:2ae:4555:479e with SMTP id
 d9443c01a7336-2ae8243aa03mr68713665ad.18.1772917225643; 
 Sat, 07 Mar 2026 13:00:25 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f8cfb0sm79975935ad.67.2026.03.07.13.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 13:00:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/2] Plugins update for 2026-03-07
Date: Sat,  7 Mar 2026 13:00:19 -0800
Message-ID: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

The following changes since commit d41b9b44ac9a9c4d82cc74f59bfd1bdd4ac4014c:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-06 18:57:12 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260307

for you to fetch changes up to 1a1cfc0a32b4345d5ef3f643994ae409eac9b164:

  contrib/plugins/bbv.c: Check if file is NULL (2026-03-07 12:59:36 -0800)

----------------------------------------------------------------
Changes:
- [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized symbols (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260306051553.2778652-1-pierrick.bouvier@linaro.org
- [PATCH] contrib/plugins/bbv.c: Check if file is NULL (Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>)
  Link: https://lore.kernel.org/qemu-devel/20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp

----------------------------------------------------------------
Akihiko Odaki (1):
      contrib/plugins/bbv.c: Check if file is NULL

Pierrick Bouvier (1):
      contrib/plugins/uftrace_symbols.py: ignore zero sized symbols

 contrib/plugins/bbv.c              | 7 ++++++-
 contrib/plugins/uftrace_symbols.py | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

