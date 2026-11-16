Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D6606BD1E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=spH6fKGq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufi-0004UJ-CH; Mon, 16 Nov 2026 06:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuef-0003wE-Np
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuec-0002Dj-TC
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso37332985e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827619; x=1795432419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zOcK/FpIa2soozQBIj8qTA+KfQuG2+4S2+axJptJAD4=;
 b=spH6fKGqJ2z8jD+/2Xp55le0J2AAJ+uQXE6FkIhwDWeWoHoEn3ex3yuIzLI7u1f4cp
 jfkEQREeAgbASX+0DHR9uqMcM7BRYKne117cpi5p79KzGfZaKTtVvjDAN7UzY3+O7XMA
 eL0I3iOVZg3EWQjP+e7+djMgK6hjMvmR8iE4UVs+Uh7Af9XEgbWG3nwlGmH/JbHUvEJi
 HN6xIkGmKofQ8lorSI9InzfGqYTpccWMY58+aaULHwfJpQkl34Ltg385Fkv0vhhW9Cds
 Z9Yqs8KUOouEzWsykKqIKR7VVnSAYMsOoqeBIWP+mCygNwSry9q98dbnsc//pIdXzCHU
 OUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827619; x=1795432419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zOcK/FpIa2soozQBIj8qTA+KfQuG2+4S2+axJptJAD4=;
 b=20ZEHxrxh3E0NJ8s7e3wymWmB4jP2I+RwJdLYsOlZXLe+ODGqucfsv9S+mITkvgOiY
 hmQ+OrZOE0Abuj0XLPDrICiOYT8Cj/uzgpmQoBLMTCnY7NYnYYBqPzdaGjS0QFvCeAPn
 UH4JASbAjSq+DTdBeVQf2ozQEiPfBWiMh4EWydS0evVF45ZrCFiIMtdJxI5e5PrXjmZ2
 F/BxFhFlgoFWMPCLOyo/LKh9H+Wff+5WU/9whoQe2JGMIYoBrJPixD72KqkStYO+kV1s
 1Iqmlm43prWVm/wSsm8xT6qeSPZrdFobVTmx+pqUF7WbAFPB1dZJIkf1jtygvVLyR2zA
 2khg==
X-Gm-Message-State: APuU4Z8Ku7Gyt+2oXX4eCPWrb2Djn71C6Cg+jJUskj8g4ydLADE9dAVP
 8I2xmqh4/Q23u/GQu0DCXSBlK9TxIKbApDCK+CqSVR1VeRD98edcL8c062rRbW8Fg0lJ7qBScT+
 S/qX7N2o=
X-Gm-Gg: AYBFou3WqQWalJcleMDID/yCO3zAX7R+A1AdD/Jtypui+XGL8RC+ICES1xqctQ4KCB7
 4gwNXzYHMkgJyjBK+X9QRixjJ5Q+WUCWIJscvzlm6yo3V474J8rP/n9IcppCK5gW9USiGFEDfe9
 hf4ti1rFATl7ygSikuIT+sRytz8ZWbDY9rldtKi45Pqx+LvAFofakU8Jg89bCliQ4U78dxKA5PX
 1HqlSb88M0UvAVYTqXP40Q4T7GjS7tZx56pFSmPxNpsR8KkD8mOMbE6T9d+XQIMrrxXErFmtswz
 pbPW/DS3IeT3scBHQ0lLuDoo2z2OpDmz1YolHh+hHq9wJC2KS7qqWAzaEX+V++umvVGKTNg8+id
 qC0rXkdEEXcwtTuqlGA2FV8bJOLJtlUQ71k0G7SGeXpN5+mNRB+PnAgRSQ0JXbcZ5GfAjrsflsz
 GidC1/Ac+X/ArRyi2mRx/NWlDpjmEGZBEVU4hvxl2tBr5PDfqVIgHP4hNB0a61vq+nBqkVCpAwm
 EpisxXFhaRBHFBYJ9mjj3ZqWMTAhaTvVsFJsMN8IjDVAL5bVBzGitBlBj92MxeTzyCWS4/EkPfk
 pAeelmb5CMmXXW+YQl1LE29hm7vMooOOy0LhBrkCRqCJdQk4gqwByAH0g9PkOKNtO8XDjRLNBS5
 c2gnZY+8y6DIvm13dQWKFzRyYTVEaADsB0ms=
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb6f6a1e5amr80203685e9.2.1794827618633; 
 Mon, 16 Nov 2026 03:13:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/33] docs/about/deprecated: Add missing "since" marker for
 OABI/NWFPE
Date: Mon, 16 Nov 2026 11:13:00 +0000
Message-ID: <20261116111303.1692832-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20261112093824.2281467-2-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index de7d502babb..4188445ed45 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -451,8 +451,8 @@ across versions).
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


