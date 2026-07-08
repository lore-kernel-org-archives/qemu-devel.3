Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA46FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjf-0003CJ-Cc; Wed, 08 Jul 2026 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTje-00034a-94
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjb-0002yL-Gy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso3468255e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522724; x=1784127524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4/76z9AwZCGlFXWRWhxdwp80YrRiItouGyhJLAV+VU0=;
 b=j6j2RioPgfZKtyv5mNUP9jTMWe47mmeLpArO0YW1fVqi0JJzHsRUXcly309E6ef3yy
 f69wNdj2stwC9wJAB+jHbY0TlvskfR7y2Uw+Ku6cvtsX+YZDZlCskQjhPX5T27PSNcEV
 hHi+oPEOz+5GzIPqBu8m2Re5Cj4o0VM9W6tJ0hCd4swPLaO+24Z7D80sZS4UWyg7zTSJ
 a7NVezaIf0wm2/TupqaZzJ3kiWflVDoMopD30cTMrqdYVBgJ2wHrpTakWNf98+THwlts
 qbj+fXbUQeApr5c0CkHZjfk7nuf/yiRbFBy4t7QFALw7xMwOPbt2Jn9e2xoF2DK7iTFU
 c0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522724; x=1784127524;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4/76z9AwZCGlFXWRWhxdwp80YrRiItouGyhJLAV+VU0=;
 b=tKfohqvilva5WHnKEsI9FLMxoLV1IUT3QQfnQ7O8JVkCypP0MekPi/i87K4g5YWGT4
 yaGzvGj2mOF9rGIOiMVFpQvOc6ikIHtYJ2KDNx7PVpkvE+pC/rcGHgrAf4+9JlugJFYt
 fK2wD2Hr5ZQZs2es7Ld6ONGwklFyLE/72RbaY0Qur3aFVd8ZNSnCYdKifvYjPvq4yKem
 315ctdVPyqta2RV6NWOMqPj3m82yOwlCfaXB9DqPWyFW03APUqUQK/CqKY+5LiMe6ZAY
 nmzIzJ6jrVRE4hB/yqSj+MMwNC5lJeWNZozJvIpbAVEIvxVxd7F6ZZGTUrdAar4pBW1Y
 sVfw==
X-Gm-Message-State: AOJu0Yy28Kp4kllEa5hUANWzWrDW7mOzMYJUm7+awD+Xa5cJlsi/ClNB
 Zpuc2ih3HUlXTz/1N/jMQtUqn8MYVDsAnBfTa7cYakM3bA2jKP/iigpiHpgLrhHEMjQ=
X-Gm-Gg: AfdE7cmj9Y3nrUmo/EI86xNa6ms0BUhddEbck99Bi9EG8in+V1nFlUszMFO+McwBwVq
 NpIWdpVFqMd1gAgDWUT9F8QUJQQwafIvsg9F8Bjz17kAerRQPO+R6HkTiXJRtTY67VsIgkvFhpj
 bShs3nGcExlgVBGI4tdAKa6l0zHqyC39Y8DT8LmQ2BvJgciQhr8m0wn3HieL1a1mYjvpz2pbQfq
 6Rg9NfKKQn4B2zBiUnidkhlNarfqLSIpMwM+SslAs9YnKX9QgLOIVdztusZvgvgJHKuXNH84xry
 TP2EtPqwWpIg3M/DR5SVzwLI87TLMEfw2Zn1e62YlIBBU6j2XdvR/+ugMILVOf/kWoeaW99RJIe
 YTL2QWCaW7csjCUNkM9QQqHSexX4Uk5tNXXXfqYZasNt2/rlYNDoV/qxtdcRTNu5UNiQGnTmuEK
 5b6HcHjxq/XFJ9
X-Received: by 2002:a05:600c:1f8e:b0:493:c337:db18 with SMTP id
 5b1f17b1804b1-493e68a7496mr27226005e9.16.1783522723562; 
 Wed, 08 Jul 2026 07:58:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a25cfsm77596105e9.0.2026.07.08.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF5985F8F3;
 Wed, 08 Jul 2026 15:58:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/8] More Arm FEAT_FOO documentation updates
Date: Wed,  8 Jul 2026 15:58:33 +0100
Message-ID: <20260708145841.3032079-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

While reviewing the latest Arm ARM (M.c) I found a few more feature
names that have been added for old existing features or we forgot to
update in our emulation list.

These are all documentation updates so should be good for merging
during softfreeze.

Alex.

Alex Bennée (8):
  docs/system: declare support for FEAT_EVT2
  docs/system: add big and little endian features names
  docs/system: document FEAT_Secure
  docs/system: document FEAT_MTE4
  docs/system: document FEAT_IVIPT
  docs/system: fix sorting of FEAT_S2[PIE|FWB]
  docs/system: add FEAT_S2TGran[4|16|64]K features
  docs/system: add FEAT_HAF

 docs/system/arm/emulation.rst | 14 +++++++++++++-
 target/arm/cpu-max.c          |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.3


