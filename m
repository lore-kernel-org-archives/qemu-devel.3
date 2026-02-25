Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F32FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOC8-00084J-W4; Wed, 25 Feb 2026 18:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOC6-00083w-EG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOC4-0004LS-Aj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so2778325e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061682; x=1772666482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zq49UqUamgmlzp204m0FNL5ioC8LH/gIGw7R+uH3vZU=;
 b=DwLRNR3cHQAJ+JJxtBvT8CBy9XjwAQygjUfjQl+1IfI12u/QArp9EceLD0FdzS+ftp
 WeHj1Z/GNAbDfKhy7xdpiJYlCVxjhSlIlm2qz8dYxyVWYEiex2wpntHtw0vIULaPBvdc
 RE5+x9apZWCPQ1iEkEW8Uy8vOkSPREbe0TULDG4UBaal1qti0GgpkRMxyvdffSG8vanW
 oVjC51jDLVRFsufLH8Dz9HTt9USi1KpdsYay3eTyvbfBZ+WCYvC9u4fEyf7xtxHuv6O3
 HF+DFFJlMuomBRzc4IOOu8DQdoQVrZJaD1H9rjRlOpn7pTf5JyZwT2xmyaDn5p7pliC/
 +mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061682; x=1772666482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zq49UqUamgmlzp204m0FNL5ioC8LH/gIGw7R+uH3vZU=;
 b=oXdoCp1Q77TfMN6heXCp9SrzEqgX6ZiXvqJKkucJP3Tzm2X7fNfpn05dVzXj9vibdc
 QK674kG6F0Zjeq7uutgavCmQkT7JePNReiVTDppSt9tCwS1x4pvDAiBDaK4MV2GneFma
 sGWYBzngbX2sR60YA/vWw5mcOVjVt0T+iJMNPaiTLYYySVpbUjWNY/lbKvvNa39jTLl2
 /1Qpv26PXjv2Ml7UQbM4HMcCz2zI/+l2UE0mJmUB4FFxoIa8ar7KV6s9wrnk7PP25bqv
 HmH6Cwxhc3nESjn6wq4O2x+9pTRi5g6P696k9AB9LserMYV++2XCJgVoFX6EOftyOSdz
 asCA==
X-Gm-Message-State: AOJu0YxhXBvysfn0nH7eSSdEyHSMsbSn32NVS0dM55piGaCuCz9yEPeS
 BcI0ga3GaxuXr3YGbk5I2CWJOcHRBG3c4JQdgOyezGEzApwsqqeS4VOQJ9JnE4UKDXyA+E4HD3F
 zWG9P4ts=
X-Gm-Gg: ATEYQzw8YnDndsg2tZgZtWPQpbRpkyUzgiSbHCG/07KK/sPwKoILSHNmRUUykGldW0c
 aZSjLgr4bVbVS/QXMUk/2jf60Mh1A8BAiPTnfEh+ciGd/TgOLOHc6TdCbBQtFGPY9NcZ44nseoe
 BMFHOd9aaWXh4uNU4DmFfQRwbxUldAwowVT1Q4o4cju+yHRi+i3/0oY5Kl2BwrEeZoqXPcbdWaO
 x8TBwx+DxahwVxyFxYJS9gyY2o1B5pCy1OR0E0tClxmBClUaOh0+goMRc801JLpKbcXXgi7BVCP
 vPIvS5K7vwx+AI5MUslIKyvibtkwQJwHXqc3Zn20TtsxfMaJ5WfTsBNMhAAa9tF14v936y0tBmM
 cuYdTn4jRu6pkIOKjrMvwCpd1huEJETnzhllYiT31aq71trQ1RVq+bAqgbS3LHLdBhq2lSh4Hm9
 q67OwX73l97Zh3G0GMZ3t7d44EI8xwRgUtsPyM9sltScHNkAOfSFLTrdX5GASVFB+95BIi64wx
X-Received: by 2002:a05:600c:37cc:b0:47e:e20e:bbbe with SMTP id
 5b1f17b1804b1-483a95e9b65mr291185645e9.25.1772061681711; 
 Wed, 25 Feb 2026 15:21:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43987f3ed03sm16958080f8f.16.2026.02.25.15.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/70] system: Reduce 'arch_init.h' scope
Date: Thu, 26 Feb 2026 00:14:03 +0100
Message-ID: <20260225231411.96482-64-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Better to restrict qemu_arch_available() scope so it is only
used by generic system/ code to parse command line options.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260213175032.32121-6-philmd@linaro.org>
---
 {include/system => system}/arch_init.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {include/system => system}/arch_init.h (100%)

diff --git a/include/system/arch_init.h b/system/arch_init.h
similarity index 100%
rename from include/system/arch_init.h
rename to system/arch_init.h
-- 
2.52.0


