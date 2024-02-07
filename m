Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EDFC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY2v-0003Ax-Ff; Tue, 06 Feb 2024 21:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY2u-0003Aa-L6
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:20 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY2t-0000Wj-85
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:20 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso1740315ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274338; x=1707879138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEU/hJw5TC1eOVwox4NRRVOneFO8qr/5FlNmbbEKaKg=;
 b=aKlXbKT4EN0YtR/Pi66WdOjVtZ6bj7KTMJUyUPpsPsT98SF0y7Z0lo1AT2XDoqJCHy
 UN/9SDwHIbXwPP9TxCP6C5lqkyOk/uE51E5m/AABW4DpjwQhlDKVPTVEfDSkvebQ+zhf
 nsyADu+er3PXhrPuwtfDalwauuhhgxZW9+86pxEpI0hPk4Ig3LzLQVXiAyw7dXbOh86n
 MhFTLhnsgKlSt4FAPCzI9JUq92P73MhtOPyKtqtQwuqy9bamaYEFzeXlnGWFLCuvyXVE
 axDucYdKpYKBuTLgcLY0Bp4hO6r8z9RcN8q5fHGGbKBvX+1zmFackRj6kcsTN9/qSXiR
 kcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274338; x=1707879138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEU/hJw5TC1eOVwox4NRRVOneFO8qr/5FlNmbbEKaKg=;
 b=e5yU2vopLAyWP2VJkIBSdzFvj7GmuBpQwTB6A5lwsKWAY/YM95phdNlYW+3g8nuyiG
 ct8GGrEhnl5qnNXlkl+nWHb11A/zEYGpd0wTjzu5RQozwPZ1AZf9Py2xZbDHGy2Ovrfh
 KVG6JB5ZzoiWGk44DZ5UqIlZguAXoCmBvNCyHopiGWByLzsn2QnokJQsiC/qGlmL+lV1
 Cnpu9zMXZr6Oy9OMNLSX8JCuPouXrwLM/UNVYfRX9o46ei47aTU0Eh2yeGOEcrjz+smi
 t9HgBo2VABn3a34TNA4uzloptnoa/tLSMt76xeZgTMih1GqrOfbiZ95zVb0AsCvvsC+P
 zr3w==
X-Gm-Message-State: AOJu0YzUruB1GE1UWcF2S7wq1FK30Npgh7HWi2nxh7sUiH6WiEiL5b42
 qPwF2sNKjrpcx2sNF8N4d3Px3mZZ82+FqV3pc1Ij8xB4el54JCDr1Pr8pJ/q0v8vinl5eeRoeEF
 jPUo=
X-Google-Smtp-Source: AGHT+IE76AitspInymkiLeb0q+TTupwnRT5oaqVMIl/gEb+46TEC1D5Jt86M4ESBypOMuq4HufvaAA==
X-Received: by 2002:a17:902:d2c4:b0:1d9:21bc:c607 with SMTP id
 n4-20020a170902d2c400b001d921bcc607mr3939106plc.60.1707274337716; 
 Tue, 06 Feb 2024 18:52:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5y9TJR0Viu/ojyg8rbSkzcmPJW90jAOcq5R6982PxtOEJHZr48SWfBKspMXoASfh1QBseFwbwLPnBRMaZVtK2YgRPZ6wQbfmq
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 0/6] target/arm: assorted mte fixes
Date: Wed,  7 Feb 2024 12:52:04 +1000
Message-Id: <20240207025210.8837-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Changes for v3:
  - As if /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred is "sync".
  - Fix do_st_zpa as well as do_ld_zpa.  Oops.

Because of the above, I dropped Gustavo's t-b.


r~


Richard Henderson (6):
  linux-user/aarch64: Choose SYNC as the preferred MTE mode
  target/arm: Fix nregs computation in do_{ld,st}_zpa
  target/arm: Adjust and validate mtedesc sizem1
  target/arm: Split out make_svemte_desc
  target/arm: Handle mte in do_ldrq, do_ldro
  target/arm: Fix SVE/SME gross MTE suppression checks

 linux-user/aarch64/target_prctl.h | 29 ++++++-----
 target/arm/internals.h            |  2 +-
 target/arm/tcg/translate-a64.h    |  2 +
 target/arm/tcg/sme_helper.c       |  8 +--
 target/arm/tcg/sve_helper.c       | 12 ++---
 target/arm/tcg/translate-sme.c    | 15 ++----
 target/arm/tcg/translate-sve.c    | 83 ++++++++++++++++++-------------
 7 files changed, 83 insertions(+), 68 deletions(-)

-- 
2.34.1


