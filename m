Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F7C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 19:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYADO-0007dh-Sv; Thu, 08 Feb 2024 14:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fi3FZQwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1rYADN-0007dZ-0s
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:37:41 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fi3FZQwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1rYADI-0005FM-Rv
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:37:40 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6048e351290so4958027b3.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 11:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707421054; x=1708025854; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=92fOOnHCkanWg80V2hAwSCwodLG+3/RgTATFlOBrVEc=;
 b=uonYE1leyPJN8S+akq0QDUYFPONU5tPfve28krn6TzSaKYLgF+Cx8aDlWuBnXOaPbb
 ZLV379hCmNvJXdXhOiB+O3/DmHkVwTmS/XZ49mr9y+1jaxGQm64urFhfvhx1OPyKKVHg
 TiStClUO0161Xt4ksYwk35Ne4mQp2IzvmHd534E0K99QUN+y7ICiy7ejOcs/Jo4QkKpb
 6CbyOBxo8PJ1HZDCbVAiFh1FkisScjAidADcJNbrkVX++vLeR5RU2nwiz3WtlSmFXPQV
 Wr8VkK7mc9cWVF6DgI5s4FLCGaL/BkT910iczaMOkL/DxBkZAr+17Tc6QFOn9dA1CsMW
 jtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707421054; x=1708025854;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=92fOOnHCkanWg80V2hAwSCwodLG+3/RgTATFlOBrVEc=;
 b=sBZEJ8TrAJjVHXDAi0BrPTlxQ1kldkYSTmbBay0XOHPJKA/TIOn1J38A/owVEJCHhr
 K8ipkLemP3s0Hm3sBdWl+KBCUOXQNNETNwOYon3ydfBZRN5MwUp0Xg4b996jsDb0ogvb
 7KHSP1v1sWc25f9wxDXJ7mdvgRksX5HgIReeSWwIEWh46nElgz1N5vslYGUoc3cj4mMn
 Z0a7VMWruQK0v2RLnFXknbrV3QkKuo9AyrubwLSbGjQyDrMkF2qt8EkH8ynWQHTOoNTC
 eOjmSKaKskGKwirZpBK+75cUU5vTE46INNMywg7acwAG1s1Yt4iU68PGd+hRQIMM8R2T
 Korw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRkxEIjVL+hpm1IcCufuXPcBOVR7IUAL6hGpvbiCNL3z2mlHU9i9Ki5QdgYApEiZJ4ddsXdW78OivKO2zKVY74EskKW0=
X-Gm-Message-State: AOJu0YyU7EknQkmYlwXpwa0BwM1BYKErkvgTZIl/CrgIMw0GDJlMGokJ
 iJIh8Rl1VdwQcYGBwOZPnHerYCw7+U8SCfj6yMVub2ygKfsY2onlZxdm+Zy2Ct4SfXaCAwpF2In
 nraMz3na8vlRljoy1MvZvjQEhrg==
X-Google-Smtp-Source: AGHT+IFp5/JNx1/wJ9qGd6+e5wyyt+anSDRgDvq+T0XiT94rz7Tt4azDKdWGvBrS//dyCm2/jF61Sr9mQNM8+am0C7Q=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:9284:0:b0:602:d17a:7f60 with SMTP
 id j126-20020a819284000000b00602d17a7f60mr58779ywg.10.1707421054552; Thu, 08
 Feb 2024 11:37:34 -0800 (PST)
Date: Thu,  8 Feb 2024 19:37:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208193730.2777982-1-nabihestefan@google.com>
Subject: [PATCH v2 0/1] Sending small fix for NPCM GMAC test to properly test
 on Nuvoton 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3fi3FZQwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Removing testing for PCS registers since that doesn't exist on 7xx.

Nabih Estefan (1):
  tests/qtest: Fixing GMAC test to run in 7xx

 obmc-phosphor-image-gsj.static.mtd | Bin 0 -> 33554432 bytes
 tests/qtest/meson.build            |   4 +-
 tests/qtest/npcm_gmac-test.c       |  84 +----------------------------
 3 files changed, 4 insertions(+), 84 deletions(-)
 create mode 100644 obmc-phosphor-image-gsj.static.mtd

-- 
2.43.0.687.g38aa6559b0-goog


