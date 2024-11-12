Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F926D597A9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyPL-0003hB-NV; Tue, 12 Nov 2024 16:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPE-0003gt-0y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPC-0004Sf-FH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso49108525e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446792; x=1732051592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCin0/w2synzn0FZGIgr1vxI2X92dhBNZih1bphjULs=;
 b=ibHexu1DI792LjNvaOBfB1IbL+fYkTHDVac7Y6HdCADewfcbLMX/iEAq0H+AgoTup8
 DHX1ntwnMnAuNzA5CZShd+Psfth9BvFBLXP9sAvdKLR4eD+pKRyySEBsLuLs463T1ghm
 fDcfCAGDzrt5YN/ZpHE8RrSZc6r1lVj7vlcEgKCnSMJkgYnlWKxgY1imlA2uWzY9pFX3
 o2OVVg8zrCAz33YZDloQh8CQ96/ZC5XIGiOm1cdeurM6TIjy3i13brhSOXJGkzePo60f
 CeUiORrbQZVvoznofOGeGtj6hC6aWAuxGA8ur72tmjmU5Hu6T9M+rh1FiXT3JiQQBGyG
 yfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446792; x=1732051592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCin0/w2synzn0FZGIgr1vxI2X92dhBNZih1bphjULs=;
 b=d+Tw7hOJX6shQzIzYFziSWjQrUvswYq3JTb9d7Qw7ilo6i9V0FMieaMPwKSlYydyZV
 HGP1U4i7BmtOfaof3//P4ufkrcceXl10JF1jFeQd5OpZUQku0bq0orNgvruteFk8O/65
 5KAdeZSq+M2tgSY/wU5ZN3YaFqKg2SmDCOJPKlZSxrZ+AxSzALpsgz3FhCrPZkltHtQd
 e4hEHXvDpoxECGi2fpMKRMzz8fZfpD2ndEh6XYM+YvwOQCSBHJUNJAHc4NmBK+SfcdwV
 i1o4asWBdqGMPg1LxiJHACT13Kijv3KehUI0X6HFJRSqC5ZCg/tIkLWZwW+2CsFWphs3
 hIug==
X-Gm-Message-State: AOJu0YwSRWNVDy9r+qwbK2sV2BxU0swcMvtnUAIKJdB7CMsEYgKHDD0j
 dryp9nZnCDrdTIdxomkLFm4zgYdy4aQimk8NJbhrFqtI68f/xjAgJ6hRc0fXiKEfJRk8BgvZ3Hg
 BbxRKvA==
X-Google-Smtp-Source: AGHT+IEKUxTM3kAaSJqUMJ1RJyE5mOhE2BWAIKYXKc6R6vindGnFUrgnrdhAy8/cKC8pXH53Yv4+Gw==
X-Received: by 2002:a5d:47ae:0:b0:37d:34f6:92a with SMTP id
 ffacd0b85a97d-381f1888ce3mr14167634f8f.51.1731446791891; 
 Tue, 12 Nov 2024 13:26:31 -0800 (PST)
Received: from linaro.. ([193.32.126.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec202sm16613515f8f.83.2024.11.12.13.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:26:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 0/3] plugins: generate list of symbols automatically
Date: Tue, 12 Nov 2024 13:26:19 -0800
Message-Id: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

Now that meson build for plugins was merged, we can cleanup another part with
the symbols file.
It has to be kept in sync between the header (qemu-plugin.h) and the symbols
file. This has proved to be error prone and tedious.

We solve this by generating this list from header directly using a python
script. Dependencies are triggered correctly, and the file is regenerated if the
header is modified, as expected.

v4:
fix second patch to apply cleanly on master (was applied from a previous series
to enable windows clang build before).

Pierrick Bouvier (3):
  plugins: add missing export for qemu_plugin_num_vcpus
  plugins: detect qemu plugin API symbols from header
  plugins: eradicate qemu-plugins.symbols static file

 MAINTAINERS                    |  1 +
 include/qemu/qemu-plugin.h     |  1 +
 plugins/meson.build            | 12 +++++--
 plugins/qemu-plugins.symbols   | 59 ----------------------------------
 scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 62 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols
 create mode 100755 scripts/qemu-plugin-symbols.py

-- 
2.39.5


