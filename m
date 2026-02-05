Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB497EA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpeB-0008Sm-Qt; Wed, 04 Feb 2026 22:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpeA-0008SK-OX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:10 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe9-0007aH-7e
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:10 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8230c839409so419593b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260588; x=1770865388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyM1KVtyy0hDttGKfHUCbIHI/k1X94S9617WLVg4QG0=;
 b=Axk61TC71wpv225Jln7nP5Jj25iS8J3+pUqLRn1XruWck3E1cbSwHCjlUcIV1JSsey
 4rwYJsf/g7T0stOPwkKsm/YJVJ4a6xrnttjIbxiID3P8AarjqZC1gI3QdEXc3rxwQRFN
 qy7q5kv4AL8pbWnFXnT8GBHHK8I7gxhuA3W6zYt7MLh9XZznHKOKnMEZPXuEqz3FK0YO
 vpGfo4vwntfWlNwjydyVADRxbvb9FSi/1VL2We9OfTLYxkZnVoKnmvnRt8oQrj0HxnQd
 ngkNzp/PX6GkKc4wXwbG10Krc66J2G1Dr2LZ9dDJl/5iMvdq9YoGw5jiw5yMgqlKq7z7
 o0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260588; x=1770865388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XyM1KVtyy0hDttGKfHUCbIHI/k1X94S9617WLVg4QG0=;
 b=G/HYJmbW2psLRENEKiOKCzlEZLcO6Ga5nJAGT2PcCvGPDomzhILABdTxo+8wCWECaZ
 n3/bA3JD/YfkqMYg0kpsZ5yDXUzi8QeDdTvNQsu2KwPlyzaEWt0sIeQvySKygjcE8l0Z
 Q8jYj/wkZoFMTNruDXyURZMlj7RPw9KMS+2gslhQTmqCBftmVr3Aep1J68bbuDNq2rAK
 Hxz9/VLdcDP6sCKiOtZ8K5iF+yuUE5DpmKx5GI2QRKJCFTkat2r/MP4MV3EIqPoRNd8V
 gN0ZrJ5p1L2P57kQaIYVAXLLoH3xnHMHSUBYtSnS6el2eB++HBDyB9qzwk/8c7Jzkk9c
 42SQ==
X-Gm-Message-State: AOJu0YwNkfW0jHTlP0wherafmgwrC/li8SmzCl7NOFclGhUmtQUqMNDg
 QMyBdZfvX+YY73oWEwus3HCaMrhEaiVTOzmOOgqYQ74MAOMgex3rZ6dy6IQKdpaDq6zqkc8OEUE
 lSO330snBGg==
X-Gm-Gg: AZuq6aL6IPt0ouyRmupMEcalXid994Kpq+06FO4akJKgjoOjQXUNKjXYD+76p5FhhCx
 14NXMjEOjl1MMkKKKszWHsA+NAeXm+nVNRA6d13DDc+HgpBtQURkt2jJDMyZ2bZb9T/qhS2aPGc
 rTCET9LUbcIvVg5f8Suyy7ic/s3DDpeQj3yopQBJROiNrumFmyWWinIYH2pbtbAn7kT80y0tBUC
 bg2ff2UJUBMUkPA6Zm5saEoGUOaM9PxxbYdAlhh9nM3aWHqFvKUfgT417/iTU0BckQLXxHG4TsF
 PmschiJoAyYBnU4y7JUZpmC4SPIHDqaZiM6knZJRl+EYOZrBQuQIpglDY1Hp74TsByyf0vZcQRc
 pq444C5DTQAdREttuIlfZaiAnYtGuPXKd9m7/Fz+z6NtCbgQOyMxgaNzW8lfQJbB467tv9ulndS
 FZ73HZwFNK76V43XrdIf+n
X-Received: by 2002:a05:6a21:3a85:b0:38d:eeb9:8f6f with SMTP id
 adf61e73a8af0-393724d7d7fmr5158047637.72.1770260587557; 
 Wed, 04 Feb 2026 19:03:07 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:03:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 6/6] hw/or1k: Rename or1k-sim.c from openrisc_sim.c
Date: Thu,  5 Feb 2026 13:02:44 +1000
Message-ID: <20260205030244.266447-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Match the filename to the machine type: or1k-sim.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/or1k/{openrisc_sim.c => or1k-sim.c} | 0
 MAINTAINERS                            | 2 +-
 hw/or1k/meson.build                    | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/or1k/{openrisc_sim.c => or1k-sim.c} (100%)

diff --git a/hw/or1k/openrisc_sim.c b/hw/or1k/or1k-sim.c
similarity index 100%
rename from hw/or1k/openrisc_sim.c
rename to hw/or1k/or1k-sim.c
diff --git a/MAINTAINERS b/MAINTAINERS
index b739cd59b1..e6c70b2b1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1493,7 +1493,7 @@ M: Jia Liu <proljc@gmail.com>
 S: Maintained
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
-F: hw/or1k/openrisc_sim.c
+F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
diff --git a/hw/or1k/meson.build b/hw/or1k/meson.build
index 49c274b848..a5c23f4f5a 100644
--- a/hw/or1k/meson.build
+++ b/hw/or1k/meson.build
@@ -1,7 +1,7 @@
 openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
 openrisc_ss.add(files('boot.c'))
-openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('or1k-sim.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'or1k': openrisc_ss}
-- 
2.43.0


