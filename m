Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47942EEC2B7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 01:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuhJH-0007y6-PL; Mon, 23 Feb 2026 20:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuhJA-0007xX-8k
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 20:33:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuhJ8-0001Re-DE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 20:33:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so35904045ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 17:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771896828; x=1772501628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zVvJ0JS9T3OxrmvJhyE51viE0cls1f/Ts048p5Cxx+c=;
 b=SpqH/eIIgGQtQGMiAFMjEcUm3haetqvpXqwGy6BIecu60SfjEBpdbpv73YpJebjsfi
 p31nARxl5KzQLh7M+5Vvuts8uYcsGo3TrxQphF8jkiTsmso1o9ojkv0yqo3Zy0u4vMuP
 Doe23wE64CVFr13Fb+jAECvuVCnIHS0rAOnn6j2C7uY//VOj4eJpBVh/Cb2BwyNYA/Qf
 SCDd0tkxu8LRf/tDpxYDdDN50L06zYATGlVS4/6L48ATnz3DRqHAhF57QLp25R9SBlF/
 vc6QZG//oUMDlwqKXrTgdwmdW+SNFBz08SJdCVcZV5VWbcIV7Qiz94j+++xsLrWk3DQ2
 U2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771896828; x=1772501628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVvJ0JS9T3OxrmvJhyE51viE0cls1f/Ts048p5Cxx+c=;
 b=kEiofvvLhw1MdYRhstPdegFgCbvRDDeK7hFepnuU+pUefKBtrEefSOZTb0Y+tT7zIR
 LmZxW3IuS8ZS7nuOlZ2V8LSDsQ46ALLH8Jwtjz1vMWhTLEAgEh/evMzWuVlCwtT2o3z1
 oP+7vm8g77Y5G4IjAW1c6VgzF7V/8ouwUmFkmxfsdAkjCzupFdbEJBOy09sR5Y2oWR3K
 4DVLqiP2p9vuyoGAxFjol/p2vJj/aFokarsLHSQY5mS9rezcgZcYiijHAKO5EUA+r5aW
 qBJrp1/KVHCeWumZACSUIF4wv+XN1H/3GwJ0PW/ma/11hYQTvAoNyfIEwe3ghT1N/gfm
 NkyQ==
X-Gm-Message-State: AOJu0YwJZJX9v26hpfSsS2BYO2dzlnuT3LuAnEQorPaHm45R0XI3DMOE
 T+I1WgBznKEp2uDk7AHNXC69k3vT6UD6SliRsv7Wt/SmCBxyL3A5wcPnUJe0zSpHwAXjZiyQisb
 s918S
X-Gm-Gg: ATEYQzwYn6gwswnPvPEfsMkhTHS5wwqFHZtglsX6rYpjX/0w08eCUx8tSfFfzc2rpG+
 0YKMPeR8JOLeYZv3t8xacoGM0WWbfYsoR41RinPQKdj3rWXzTvMSXS+nOUi2Qd4umbblvmx3uBf
 0cbeOeqsd1SkrlimEXkJ12roo8VftdOr1kk9KGPCfy1nKbMwpOOKi4UcarQr8zixG8JNe6PE0I6
 IDcA456JjbKI11ZoAPuVSbaBelH9z8AMIeIGT0LOTGaQS0gdTbybnndLQqeo8ZA68SRqyjQSw2B
 ti8RGB74oJ8yuY9UhocK9muFdziUaKIvgSK8Z36D5EWgeOGxK8WLkCnb8JJFMlxkRyEVAn9y8Ie
 XJqMBe5DJOGJPh3zfHXRAZiauCB3RsdrDEqh9TJdMRqITjdVtHle3AZIU7zi89MAFX+/3hoCmKn
 YKiz3Bvbpz0w/JmmbFoJMNe9LxQ9WFY3ASB+nWltRP3yieSuPNX1WOTSB5Hwj4DwFLCbS5slKER
 7PvuafY0SYGl1s=
X-Received: by 2002:a17:903:1b66:b0:2a7:9163:8e68 with SMTP id
 d9443c01a7336-2ad7441990emr96950965ad.6.1771896828407; 
 Mon, 23 Feb 2026 17:33:48 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7503fcc5sm87006115ad.76.2026.02.23.17.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 17:33:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins update for 2026-02-23
Date: Mon, 23 Feb 2026 17:33:41 -0800
Message-ID: <20260224013342.2470297-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:

  Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260223

for you to fetch changes up to bd3d912b77b5d2b13ac7b055cb5ad33d5a86dcb8:

  contrib/plugins/uftrace_symbols.py: filter out some addr2line error messages (2026-02-23 17:32:40 -0800)

----------------------------------------------------------------
Changes:
- [PATCH] contrib/plugins/uftrace_symbols.py: filter out some addr2line (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260218172356.938236-1-pierrick.bouvier@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (1):
      contrib/plugins/uftrace_symbols.py: filter out some addr2line error messages

 contrib/plugins/uftrace_symbols.py | 3 +++
 1 file changed, 3 insertions(+)

