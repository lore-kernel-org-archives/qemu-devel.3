Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwj-0004f7-Sq; Fri, 31 Oct 2025 14:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwf-0004XW-EM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwM-0006Cm-8Z
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso32170675e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935604; x=1762540404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYWusgSLwsq3JoCnz8OuuHdxyiM6ED8v8+TExKETtAY=;
 b=maYsWRvGMnjWfxy1iXqwT3IqaqpMOuuxGhLTz2uyMVVZzJudm22Jcd5AfqRhr8KABu
 QLNpK46DSKxPHQ2dnU+o5RsJexKuCZwWS6sAa2kPSWPqT37mInbF0u8+R1p3DQe8JY35
 630CdrWi+os00tfN/7jDvuTsw9D1ywoku5OZj6mqed+AZ+kB2vFaHnZuW6Icp8lstUdJ
 WMEb0vrlsngKYZQpJoo22r7jYmITOGd4YalmuRSuBRmCZcgZBARBahpq3KGxibpgOg9K
 lMnv8pjKKmK9z/bgdgZ4yOTIJWqtslAY8oxsKmaOGJeb1sgp5ynK+fZV4NYKLT0UHt5q
 C+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935604; x=1762540404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYWusgSLwsq3JoCnz8OuuHdxyiM6ED8v8+TExKETtAY=;
 b=uIQgBrnl5w/ZDaNyV5a/IQmWOtXCnydaWwBGdj8WTDKh9TK+hQjrBaAVE96SGWlMOa
 IBNfExBqZuF+XKz9Vs24dELuwb8hxMs1L0xZUgbOF4fWOuXxB9NhZTqZqdYyZcqL9a5m
 KSdALqIeAprwuRIbhks50RczhdFDLGpefCRtlg2I8Qxhitdl0WBDzszyHlvu+TuNSio8
 j4GbU3LIvpAS2oTVyeiRSZqUt6oh6mJN+/vuYwmGZ+Iafg3mZSHJ8Stw4Ckf6kFDqK/7
 OU78WJPQ5K+RAqYtOcfvEC7yktXtuydPBQXOIBtQ8BHk0l9DoSe0C+IjhCLVycNkS/Ej
 wUYw==
X-Gm-Message-State: AOJu0Yx6kxx7Bqi3AEs0RL2oAXJ84gOBVY5xR3vprD61czajDps3Pk0k
 DkTcWsEkXfN/YJS+QaD0Ph+Qfor8X7l4cGCOREvm3ttud21GJ6eru87NC3mkvK9Yae3iD0KqBdU
 SBLV6
X-Gm-Gg: ASbGncsu4prkF6rsay0b2qKtRzzK8/jW4eG60eYsfUTHYdoefrmSgRBcJkBeKBLe5ZB
 FRaoHiuHCXIjp+3RSG8tGErNN9s43MN0df07Kbv3xHxHe1LWtZdXjiXLjP4nNjmRA2JqflBVPJe
 lxwuUaPpn5N2hWvbfe/i4YoQY/S0LfjWb1ZBCid1Bz1ijOyZ5/JC6OVfulamlSSbYPdWypm/ZS5
 FdZeet3dzSxBJg1/AZOJJT7wAGEX6jKWmW/0IXEeTPavAXPBu0bbbFiIPXWsj0V7IHQrGSfxBT/
 WiLdWkGcUxkg39+RYGAtn2XqEPe315UmCJwfECSfcxPuLlIOC2uer5D9//XSTba+bd1Xq5eEJTh
 vORcOf00LoTW9gM/0Thf01AFrX2j8ByQSMqgxql8f4DIT+E1jR6qTQQ878uLG9mIUj08W63dLi+
 8/KJYMeQ==
X-Google-Smtp-Source: AGHT+IEWTATtu7YDs7WOHHtInrfo+7QmDGqX50hre4FpxulE6XvEyMQF5cPzl4vS+TdQPVQdlkfVAA==
X-Received: by 2002:a05:600d:8310:b0:477:326c:b340 with SMTP id
 5b1f17b1804b1-477326cb6demr20127375e9.10.1761935604137; 
 Fri, 31 Oct 2025 11:33:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/38] target/arm/hvf: Check hv_vcpu_set_vtimer_mask() returned
 value
Date: Fri, 31 Oct 2025 18:32:44 +0000
Message-ID: <20251031183310.3778349-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hv_vcpu_set_vtimer_mask() returns a hv_return_t enum type
(defined in <Hypervisor/hv_error.h>). Assert we succeeded,
as we are not ready to handle any error path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4c98faebbed..bbe0b24b821 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1782,7 +1782,8 @@ static void hvf_sync_vtimer(CPUState *cpu)
 
     if (!irq_state) {
         /* Timer no longer asserting, we can unmask it */
-        hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        r = hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        assert_hvf_ok(r);
         cpu->accel->vtimer_masked = false;
     }
 }
-- 
2.43.0


