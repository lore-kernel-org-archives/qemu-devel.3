Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE86C5478C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbRt-0003Du-Ce; Sat, 02 Mar 2024 21:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRr-0003Di-Qz
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRq-0002yk-BO
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:31 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc49afb495so33593965ad.2
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432369; x=1710037169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RetBK3jXuV9g3YrPo2xNIsRzO3XNKvJOCNv8dEWU9JU=;
 b=gJd2jC4AiEI/RN0PwrNfNcmBRG/nLclkdf0UtEpLANVJAkgT2LeZkp/NjxdGEkBu19
 5FDG1qBo9Qdoj8sd4FfsOeI1pw0077Dxqy0nb1KPCdAkURQnBQiPR3CWPGW5SHRpWfxe
 LNhn6iLOpgTGx40NLczH1DyRbVmClVEQFnHhRI4KI+sYfQnxfRqLHWF1n1B3PHPv8fEU
 6rOSLWEPaFSuaHrfaiFqkgqZTBjwMNz9iz0lj0ZBB9+ZAxtRJDedZZo6vd2kIvJ07FSn
 WCOR5Jog9BJVmsmqPZDjQQiSbbH1aufSNDq9dP9igvdXTE9gi5LcsJmf2vhbr9sDn0D6
 uqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432369; x=1710037169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RetBK3jXuV9g3YrPo2xNIsRzO3XNKvJOCNv8dEWU9JU=;
 b=t6pMD0SwrvFcFPrQC0EbAMLMhBDQTnHve3+AqERn8Ev1OGaaaM7NlcjS6eS5SBOyIq
 ai2SvUQYV6q42V4YD6b8YAb7BOATWv2AiymCpu34s+/HInpgyPk1CRWod/gZ3ehHiVY3
 1Daf88rz3NKheHCZoxCkpmYoJGE/LqJJMBQlQuNzrLc3Bore+g8etxlyjT/G5hThfJqJ
 7AFT9GhDIEti8IhA5Wf+Lc+4d10wx4qMDTt3aTxCliOLGNVgl1OHREsOtNZpBbJAuKD3
 quAr82SoUbX3EneIxGohwR1tc2O6f6LYtM6DbD8Y8RWPPrKbG8XLplSRJiA2uMplTwOX
 vwvQ==
X-Gm-Message-State: AOJu0Yzs84nFzwebqhKNiFj+8K3RZeCTribA6A7BEK5S7CtEfXjBTdnt
 RF59UMq2W9DBqNoiSv2MmXsEzwL/x8K4QGtTFdbRUdcj1FEKHUnhxNObRWqL2vcWDZeicHfO7Yq
 O
X-Google-Smtp-Source: AGHT+IHR4O94C+J2z3XNXcWvfMYMIycagblkOZmxeY+UvghPaprk25QNB0vpwHiQoDDFT2xuFiKViA==
X-Received: by 2002:a17:903:1251:b0:1dc:f157:51bc with SMTP id
 u17-20020a170903125100b001dcf15751bcmr5515798plh.3.1709432368773; 
 Sat, 02 Mar 2024 18:19:28 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a170902dacf00b001db5ecb2899sm3512578plx.162.2024.03.02.18.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 18:19:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH 0/3] target/hppa: Fix some wide mode displacements
Date: Sat,  2 Mar 2024 16:19:22 -1000
Message-Id: <20240303021925.116609-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As reported by Sven Schnelle, fixed via decodetree functions.

r~

Richard Henderson (3):
  target/hppa: Fix assemble_16 insns for wide mode
  target/hppa: Fix assemble_11a insns for wide mode
  target/hppa: Fix assemble_12a insns for wide mode

 target/hppa/insns.decode | 49 +++++++++++++++++++-------------
 target/hppa/translate.c  | 61 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 26 deletions(-)

-- 
2.34.1


