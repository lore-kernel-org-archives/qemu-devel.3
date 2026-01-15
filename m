Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1114FD41174
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLPA-0002LX-F4; Thu, 15 Jan 2026 06:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vgLP6-0002Kr-Nq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:20:42 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vgLP5-00075C-1T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:20:40 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so580160f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768476036; x=1769080836; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42J8E2yjZd915Jl/XBPl4yp2FAGqLZDZu1rH8FK2eIQ=;
 b=ioMiWOgnzLY9ep+09M6seCtvona6RIU3ZhwZvHqquXAaL2jXC9wJpDQln7//I8WL/T
 ZwqQYmEhizqoXkXk+q/6Q7je8iYD7g+yqLZRgbW/F7UzDxZa5E+8b2RtB70Kk9IyUMrQ
 Az0sSjZi88+4yXXQmW12Z9N7Bp3Li6JrjFyCIBUKjvLmwjgb7gYX+AXAY+b9Sa0eT8o7
 wsFIzVtyZ5NV18P9msvfwJJBQ3TSiXHzYTVbzh3MytvKTrPrmO4ax1Qu5z7xCWWrlJvI
 JNVgJBZb4KrV45qH8XrKPlUhUv6rJ1sp0BrKu/BwJTYJTJjqDVwqBBThCriKgvCQw2/L
 lkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476036; x=1769080836;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42J8E2yjZd915Jl/XBPl4yp2FAGqLZDZu1rH8FK2eIQ=;
 b=hEGbA40k/o4F+oYIePNqf/bSYd6fjh45p+R4MATOi7HmFl+OMYRs5QGVHHNf9ecZt6
 Lgk442r34+soHAkSVAXIUExpbs1QDntK4f/3vTtY/8gVFAhVYuPinixWlpBysnC2oYD1
 2dB6iQ8i8LCY+G54qEtpdZLbsQlMHWCsOUpPAq5gzP2W6E7G/XDyIKvKaFy3DL9u5LSB
 oLQge5XbNbWk4RD7fyXM+MmsZYBHc0x6YInPDic/+PXVdQEsFtopkT5m7zDtCTzDp/HU
 +ADKHH9W2NrY9MX9KewGCve+ARiFUbuUTBzkR1nwu87/O3684w+4FoMGN+q0gU7hiJTm
 zWVw==
X-Gm-Message-State: AOJu0YxxjeWL6aabMdE4LHjvu/Sq/bidLzbdGXdzGXSKC39Ae9cA09Er
 2uXf8RrzJqAz5XwQrNkWtBXv+VLN+XaRjG+no9kAqZkagodRwosnzaslJLDmdj+oucI=
X-Gm-Gg: AY/fxX4XLKaxvabhT0PBygy4hKPaDSiy0XVDoTtRy7bKqxoTE9CQ4WksGJ8QCaMtH6J
 M1GvtPAKtmbkzCzIDCC7nlU1bZKXBirWCXJPk0hfDzC9MoX49g0Fj21tv1lpUnp61NNHIEEid9s
 zSfSaQGAkhj8+bkmgxlmGhsvxj6xo3aJwdX/qM1xs2t5/OOvTFNZ6xR//E/3MNKnmuUpmKb6eNg
 K0xSVnMbS9U3/ZgdAJ9Lc7ZGamTEjm1RVv8f+vEqHXhr6U8UEewREaxaxRpPCxyCugBYtEVipRY
 L+Kl+ZEihqNO/sQ9FWSJMCPXLYx3/uNrxMBw1XpDfI4Gs86xy8ze4F1zwIz6m0cRFRsCV197uf2
 dh6bgQqEGJoGI1MgP6zm4YtHL/tyCutzKy27YpEWjdquA4kfZTQiPvX17b/vabNPdxhs4JuB7Ep
 X/8+x/lFskyIicxG6ocI12U7ft3qm4ODhy/YO5dBtNEh1ATWXsQHXvM4i8N/MCb9PfIKfVbrNxJ
 /kp/RZfVklYlzKJl45sxgWX
X-Received: by 2002:a05:6000:200d:b0:430:fd9f:e6e2 with SMTP id
 ffacd0b85a97d-4342c4ee846mr6288916f8f.9.1768476036138; 
 Thu, 15 Jan 2026 03:20:36 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-214-23.home.otenet.gr. [2.86.214.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a778sm5302085f8f.3.2026.01.15.03.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:20:35 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 0/2] arm/hvf: Add SME2 support
Date: Thu, 15 Jan 2026 13:20:27 +0200
Message-Id: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHvNaGkC/22MQQrCMBBFr1JmbSQTTWJdeQ/potRpM6CJTCQoJ
 Xc3di38zfs83gqZhCnDuVtBqHDmFBuYXQdTGONCim+NwWjjNOJR5QcZFcqsUFvvPJ56axCa/hS
 a+b2lrkPjwPmV5LOVC/7eP5GCSquJetu3OX9wlzvHUdI+yQJDrfULOoSiT6EAAAA=
X-Change-ID: 20260114-sme2-hvf-105767189521
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=ehbrwOichnlLxH7AGqQJD2uv79r+o7S4dFAolUUu9f8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBhTTJDSkZhQkV0ZWxUSlM1dTVmaW1TME56Tm54CkYreDhzQUlZN3p0R0xPWW96
 VG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVdqTmdnQUt
 DUkIzS2Nkd2YzNEowSWxjRUFDRkdKYmJYRXlzcU9rd3ZZMWM1S0dab0tQcUw5UDlycWxNbjJWVg
 ptMC93RGtOZllHWnRLUjZacHhycTNiRFdwK0hCZUVJTjFVblZ0TW1QNGJxTE9uVUxSZXRDZm9kY
 042WWNXbTJjClErM1hVZVU1VTJ6aGNDdjBPWm0wSmNDODhxa2ZiZ2RmeXM5UnVQZGFjSnBsOFl2
 ckRoLzVZUU9od2xOYTBkd1EKVDRmdys5V3hEOTR1NlZuNjE1R3BzR01IMmI5WmlMT3hSYlkxamh
 wRlpvTWk5ZzV4Y3FMSDRmQVM2OHE2a1VwVgo3Y1NKV05rWGRLZjFsKzVaZWlGNUt3cmtqTm1IQ1
 E3MUMyTUkwS05aR0dJN2hpUmpRVDFoclVCZXNXMDZmWlJDClord2RpY2cyK1ppc1RUWFZJc0RYc
 GhLbm9pZmJWb2sxWXphSHZiNm44cFNXeGE4UzloTkhOUnkzZVFYMndVdmsKb3Q3eHVvUUpFQ3VJ
 VFVEWlZRdGo2ZnBWK1N3WmZxbFFJa1hLWW1XbkNVbUtoVklzUmU0ZTNIOGFoVnVpUjhZWgo4Q1l
 pQWtPeUkvU3RjbEdvZzdTTWhKc0lHOGpNTW16V2cvb0pyK1NRQzZScXphUkd5UzV6dEdDMFpLTG
 hnQkp4Ck9CaDAwM0lOOHI1Wk4vTHZzMG9GNE9Zci8rRC9NT0NvS09KNmR4MHgwZXJsQk1FU3E0M
 is3YlIxVmhIczI3LzkKaVh4U0lzQURrYkVHUXRkY0dTdWdrb2UxdmxzWEJuT2sreldlN25qT0dy
 VmcxSEhHQUNqbTJ1Y0FwQ2REZGJsbgpiOGd0bHJRek9aemFaMmsycnVBYnJUVjhvM3FJc1QwSkM
 0UUVtaHJCWHYxU1N5YVJndkx6NnJIUyswS3BNc3RlClRQWk1nZz09Cj1sRm9YCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

M4/M5 Macs support SME2, and HVF exposes this functionality in its
public API.

Add support for it in QEMU.

This was tested by running an SME2 benchmark from Arm [0]. savevm and
loadvm during the benchmark's run were used to verify migration works.

[0]:
https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/1-get-started/

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Added stubs if hvf 15.2 headers are not available (suggested by agraf)
- Link to v1: https://lore.kernel.org/qemu-devel/20260114-sme2-hvf-v1-0-ce9599596736@linaro.org

---
Manos Pitsidianakis (2):
      hvf/arm: handle FEAT_SME2 migration
      hvf/arm: expose FEAT_SME2 to guest if available

 target/arm/cpu.c               |   4 +-
 target/arm/cpu64.c             |  13 +-
 target/arm/hvf/hvf.c           | 310 +++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf/hvf_sme_stubs.h | 158 +++++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 ++
 target/arm/hvf_arm.h           |  41 ++++++
 target/arm/machine.c           |   2 +-
 7 files changed, 519 insertions(+), 17 deletions(-)
---
base-commit: cf3e71d8fc8ba681266759bb6cb2e45a45983e3e
change-id: 20260114-sme2-hvf-105767189521

--
γαῖα πυρί μιχθήτω


