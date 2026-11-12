Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mE30dCjf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRGL-0007mL-Nw; Thu, 12 Nov 2026 04:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGJ-0007im-1V
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:31 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGH-0003RY-EO
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:30 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so3165508f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794476307; x=1795081107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SuPsx+itt22/Egx7rSA9wSsq78S2CWtrMNBwp/CjWiA=;
 b=mE30dCjf2sIMWjLOJ4yQzizGsIpe4pxjm6XjkJvZzjKCdBlblFg+1x0sN8ePF9FFnz
 pkypIVWgjxcapBmU752abnE3To88fXceLo895HMLty0d2/yyhndk5gcx5cJk3ZVtA+ku
 +nQg0Q+tyNuZyph7Ew0520IKeYIQ1V7DxaypoDVOGOdpj/26D9y063VJrCLET6lUlrIX
 REIcIqe1nil+mEvF5ZLnJNB6pB5xHFdbnyC70QZIBYqjboEK/+GahjpRJBbVSUF2mh76
 b557OehAAGnYErBUOKPxKxgdJpMZg9bs3temoSZLsQehxD12e0Pdg0uMA36lIg6rFK/e
 C8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794476307; x=1795081107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SuPsx+itt22/Egx7rSA9wSsq78S2CWtrMNBwp/CjWiA=;
 b=c+p7alrGhZXC/iWrwFJeJccA9lzK1psVI6p9XN8hM8YUigTY8exhLoZchThlrIMNhK
 dr8TZzo0VzCHLupXCwLu71o9TczylIp9go8kEkNKQXPvao8V5jKM91Qto8qGvwZsph9F
 X0lYqlRlpz5MTR68xvknS8GoKep97eKKY4yIHqdOJVQh5shMgCIftIXrBJPfXQpAyHlE
 Mjkr3mUl7VNeXAOF/e2qgN75t5D1Ttz5gEs6ru9+3EwcYPH5OOBQ0jZOqGBH2FEhct06
 m2UMJEU/mdrTVy6NtX2e7ZUr/mysd+Zddep2aq/VDxz3zmd8V9TKbDoekyYNsQtq1b8d
 CoxA==
X-Gm-Message-State: APuU4Z+l37jT0t5AfzCUVmV5a4T6hTARyVZLd89IZN2H7T5hKlVR6YwM
 tw4DnlZR5EZljHgnMH86yc+ekyMZKEMwDXuxZLRmjSaij5XiGApZRjJhhPsdlPHLvC1mt5D3eVM
 noRkK6og=
X-Gm-Gg: AYBFou1RWMOBiA/mXNJ6WvbI4rq3qnPRaoPd3lTnWyUM9nPKZB+sUL85fopaN5ImjMg
 t+rNsbfuah14P9et27f18qaaNvf7J4zLs1V7yfQrD/RsRe1zfreN/t/6YUGl3UMaLzH3k22oZ9T
 p0LLuBcqyeFeKZoPPZ/uXyjC3Yj+cM5rx2zdwjun1sJMZ39YtJhnKUJv4SKWyvk869DwZZdFge/
 gr5hzf4wIHXUGL2ERZq4sWQOKXfRdCPHKvhlp36P0mYU2KmpJnGwi3qDvjGinWcNV84dSqXXKtF
 iwF2SOi392zDTbbbsb3kT8GM5TZDgTn+aZJm2d7T5hDGusThyFELilS/kJcI8/zk+lW5064777E
 wOsOwc+9Fv3ztz3r8Vp64xPIv2vXldMnIBrmqKIzaAKlCJwgcKtZFtPXpEWn39pq7tSUFe4xW7o
 XLImPQXemVYmJ+b/hwnRL/M/t/ll854S2TI3dD/OoijRqUwapSwijBDUgRpRS5p9NW3npBHpOk8
 gZFgKIkHG1ovFy91v+sqb9mwrjzk5d6vJr9PilWIJCWMNcDwDVLCNpF1whYbVECesHHkQPeifJB
 68He/wu/p6BqJuS/SvCwpSA7Z4oMhmIvvIwy9xJCy+KNLrkaoucRctwZ8sN+dN52nfohmigBUWQ
 /LgoZ67+/qxh/rGSdO/gheT/IYfaFx9IZ5A==
X-Received: by 2002:adf:e194:0:b0:48e:3df8:74cb with SMTP id
 ffacd0b85a97d-499c5783ccamr8372540f8f.6.1794476307561; 
 Thu, 12 Nov 2026 01:38:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585923bsm16189279f8f.11.2026.11.12.01.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 01:38:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH for-11.2 1/2] docs/about/deprecated: Add missing "since"
 marker for OABI/NWFPE
Date: Thu, 12 Nov 2026 09:38:23 +0000
Message-ID: <20261112093824.2281467-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112093824.2281467-1-peter.maydell@linaro.org>
References: <20261112093824.2281467-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In 750c2d53ee4 we deprecated our linux-user support for the Arm OABI
and NWFPE emulation; however we forgot to mark the text in
deprecated.rst with the usual indication of what version it was
deprecated in.  We announced the deprecation of this feature in the
11.0 release, so note that.

Cc: qemu-stable@nongnu.org
Fixes: 750c2d53ee48f1e ("docs: Deprecate Arm OABI and NWFPE support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0891bbc44de..85491991383 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -441,8 +441,8 @@ across versions).
 linux-user mode CPUs
 --------------------
 
-OABI and NWFPE support for Arm CPUs
-'''''''''''''''''''''''''''''''''''
+OABI and NWFPE support for Arm CPUs (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''
 
 Linux for 32-bit Arm has had two major ABIs: the original OABI and the
 more modern EABI. OABI support was marked as obsolete in GCC 4.7 and
-- 
2.43.0


