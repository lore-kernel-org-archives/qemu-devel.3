Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EA7109E520
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W9Q-0000vY-SX; Wed, 25 Mar 2026 17:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9Q-0000vK-0Z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:32 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9O-00033r-Cy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:31 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a288a2c00so148151a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475549; x=1775080349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v0OWEd6zf+GmSEV32do0Lj65+YbxECd0Cq7MhND7Zfo=;
 b=HnhAei2PW6Pb4Io5ruAuKXbgCzjqaVg5BaQ5x9NnpaoOEB237H1/9QPfa8CvXDk6bh
 fiQXnXMhPt5JsZW1xsC85PTVr1qZ33ozhantn8BqzIcUixH1DPlk9XKtyc/HsWEu4lqj
 viatPSu0Z5j6HWPBX+61ExZAt/1qauSxZSt9fYcnnFTC+rFI7msDgHDKXLwqcCNdspH4
 tKZ2BMUk4J9Jzq74E1JaaiZ9BoTXl4b7x6udL74OTHcMS/dKjeE+Btgjs1WWusQv2y+K
 +pi5qXwK3dHzlBG5c49Rs2oFZD2iwlpHHXwMoA6bT5nofvIxWoU0Nlgh3iiEoGXVdcTE
 Dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475549; x=1775080349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0OWEd6zf+GmSEV32do0Lj65+YbxECd0Cq7MhND7Zfo=;
 b=gfnVWj7WDCVK19Z07QJ7NbYqSt8hliMGDujzmMumu3KPgabbQyOGwRl0Icgc8HsOz7
 ZK5XESZ16djljYcfREQmtF385e5X5UaXGCCjSP6oY7hV2Qcn0b7r8qA3F4LHerKJIRM3
 1qvxynOCEUjpxsDX0pKbgZehIjK52nhRw1opn/87/tPYwgiqwLpWPtmZXXCr9slbYiCV
 Sb1mFs1nyN6X8IMln3b2UmGc2wlHDAQ70PBJlGaJ4fQK8qH6/apYoxXUGIk7qh7TVhu0
 Iz/xYosuSHn/xlQOzxUxVlGiRpl8ji8uhQkQ6/f9582X519zREqGb8AdmLLuoemimtwN
 sibw==
X-Gm-Message-State: AOJu0YwRU/DFuA+O2fgtbSRPHHpGmWIbraUsgdqwZ9PncDK3czC9Unz0
 JTrkq51h/AyMXnH59BJQdyKNsiZgcBt0VCkjRPJU10QIPgza4Nd90W1GYcC4HLpJRRRhaUSNZ9O
 uW/EPUHI=
X-Gm-Gg: ATEYQzy8c3JQsSQycbgihF76FfvdJw613jELVNlAz5zCLzP1MeADLow1GctHscXAzh0
 ghj+CzlbycTUjExDjgGUcCDSta20VLE3Edv1Ev2tw6SBCzmd4raBCQKogDho9Jd46SCb9rMTuV3
 25a3RQKDpmT4unjT/2g4/TZ8ZTnKBsLQGv4HcA3YyLiehnDx8Mogi+eGr/cNCl8ZZ46FRXbfZJb
 4H++hJc5zA8PVWSy4Ga+KaWjOLCkV8UYluJSSp01zx5o1XB1BgplwMERM+Ng1Mub0CzLVAZ0/Ha
 hsp0SmaJn9XRLiFQheb8q0y1XxVAixRD5LaPxwMviVlLxF3KXxa6+6e3knVEe4Y3+/BhGu31p23
 JNETcxDNkFmp4SXirY1mhV9xjzP8dKO24qcOXe4bDjNWgSU2VHQF/8anGh1K8JLiRr9YFv2WCky
 pHRaLzKXaVb5B4MmoVt/V/j8xbNIqauho3YZE/Q573heHmdaCsP1wue7DRmPGnFLCNiI0J2BD92
 Dh5
X-Received: by 2002:a17:90b:570c:b0:35b:9896:cbd0 with SMTP id
 98e67ed59e1d1-35c0ddc7c64mr4823341a91.25.1774475548764; 
 Wed, 25 Mar 2026 14:52:28 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0313eedasm6402987a91.5.2026.03.25.14.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:52:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/3] plugins: fix endianness for qemu_plugin_mem_get_value()
Date: Wed, 25 Mar 2026 14:52:19 -0700
Message-ID: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260325

for you to fetch changes up to e074c90947a162f795fe85a46e98922c887d6985:

  tests/tcg/plugins/mem.c: fix endian swap in update_region_info (2026-03-25 14:51:15 -0700)

----------------------------------------------------------------
Changes:
- [PATCH 0/3] plugins: fix endianness for qemu_plugin_mem_get_value() (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
   Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-1-pierrick.bouvier@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (2):
      include/plugins/qemu-plugin.h: add note about endianness of value returned by qemu_plugin_mem_get_value
      tests/tcg/plugins/mem.c: fix endian swap in update_region_info

Richard Henderson (1):
      tcg: Pass host-endian values to plugin_gen_mem_callbacks_*

 include/plugins/qemu-plugin.h |  5 +++--
 tcg/tcg-op-ldst.c             | 52 ++++++++++++++++++++++---------------------
 tests/tcg/plugins/mem.c       | 12 +++++-----
 3 files changed, 36 insertions(+), 33 deletions(-)

