Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE49C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXP02-0003qi-TV; Tue, 06 Feb 2024 12:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXP00-0003qY-Su
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOzq-0003XT-GA
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fe2ed8746so7682835e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707239552; x=1707844352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i1dFzNuelN4CWZqr8uaEvSpqTVCt5LiE59TikMBDyIk=;
 b=HVHQw1lljTt6F5XRIOwezXXBOWQhId6Qa2Py057iB+02/umEzxPgzuSIXAjnTG3Ea1
 QKiM16pX1YkCb5JnlYgHYrworVDhuTHl+QGHIGYWqMWgJZQGqvruDi0T4ktkQY+c/Zpv
 mWvT+4MYQ4A2nxPj2TnJgeRswSlOxjQ5dKOwtJVI2nHdPzg98E/oAB+Ywn84vzys0XQZ
 kfC9WdufeYgxn6+SRKJp+t2o5VJ2ECj6Gotc4jAxxO+E7Mb4CyYNnPeNAMNLYv/TDt78
 NbFO9VeMQczOHeU66jT8+H6VQ98mY1NW22yzxTVGj3mYkynLmHU5km+/5IizuQEM+Tyz
 0Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707239552; x=1707844352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1dFzNuelN4CWZqr8uaEvSpqTVCt5LiE59TikMBDyIk=;
 b=mxmF/MuepHWkP/Ot03PASfvD7XgTlBTo7QrNeiKpWCk41ay4VfkNOVg4wbfshVasq2
 gbsT8zBVligdMTfXgW5WXwoChEV+aetbBmoqvXTrV7heBp0VPAtVgl/09mi/IO2NnnjL
 ti85yokBtVtmbrHXbMfAFh10q/9apmNkVbxBMZcl3/UVI8pnwrfjsk4hOwfdnysVr9+n
 fmFve2yVvbs7XSmROES3xKFq6rKYBySqlEOaIhUBU+2oVwUy1n/3a3JLjWZYkMoL9lkO
 l8PAgMyOZpvpxOvU6DuHVlz+R8d/MuSF9XV8uzMhf3aWbETfJyY7IYu60HYzXQBHvieo
 2tJw==
X-Gm-Message-State: AOJu0Yzc6noyqweawSvoaQq8ftuhN7VBEb9x7nG849aBEyBQ26ngwcfr
 +3788L0AytrEA6tNMuGVk26Pg6NhMtTwiHy/uyqiuk+a6mT2mi+0kmfbzeifWgM=
X-Google-Smtp-Source: AGHT+IHy3N2KCJjS9leQJhbeV8g0MxysoGxmlRlmXEptJuOPQS0vkmBeJIAmzWnEai5baRvE+htnqg==
X-Received: by 2002:a5d:47a2:0:b0:33b:4965:cccc with SMTP id
 2-20020a5d47a2000000b0033b4965ccccmr1571429wrb.46.1707239552588; 
 Tue, 06 Feb 2024 09:12:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUKznLtooHjIW2Bm+BaK38iaM0PGz7R34U1So5C0PMAab14I/eAsmQYs4UlPdGilstXIOXUqnndWqtqODn9mZFQuy1AwrkqP96UBIvorPhK3YTcqIch0WOvzI03mwBGp+d8GHX9mPK3wAZgJyuUXC6UpZ4B
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b0033905a60689sm2561284wrt.45.2024.02.06.09.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 09:12:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH 0/2] Fix issues with npcm7xx and recent NIC cleanup
Date: Tue,  6 Feb 2024 17:12:29 +0000
Message-Id: <20240206171231.396392-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The changes to the NPCM7xx to add the GMAC devices crossed in the mail
with the NIC cleanup patchset, which had a couple of unfortunate results:
 * no qemu_configure_nic_device() call for the GMAC modules
 * the npcm7xx_emc-test produces some spurious warnings

This patchset fixes both of those. Arguably patch 2 shouldn't
be necessary, as the "nic foo has no peer" warning is a bit
overzealous for NICs that always exist on the board, but I preferred
the simple approach of silencing it rather than spending ages trying
to figure out what the "right" condition for the warning should be.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/npcm7xx: Call qemu_configure_nic_device() for GMAC modules
  tests/qtest/npcm7xx_emc-test: Connect all NICs to a backend

 hw/arm/npcm7xx.c               | 1 +
 tests/qtest/npcm7xx_emc-test.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1


