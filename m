Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CABCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyA-0004Pr-Ls; Fri, 15 May 2026 17:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxu-00035m-1t
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:03 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxs-0003Ba-JI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c7b282e21so153826b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880059; x=1779484859;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9E1Cs+9YzSmm3WBGPknJAKNKqM2g2pEPkRw+0Ns5p+Q=;
 b=0reIoROFTTFTFQvMn7nqG+5xUWnHOVB8HYtio+c+HKX0RfXyAC+ryHgdBHTtelQrWx
 ur48QNYWayyFPNB82BkZaAtyJ6/FLJHDlGLtGc9WZk2aj+R3+YL+LlLh51q3roKHUBeg
 c63F/bJ661m4xPV0IkMPbWuygbGpjVLHjWb7bv25cBN4xI2iWzpxVwtOY37maxy6vWrk
 z2nedAzhpvd7M117eCRTcp4KZi6bfrdVK83UG5rDAz0oNJCy0teiRls3/jfwqo+Wi4xN
 ADnPCIkAFql8Fe6zyEaHXpdZlyAacW7o3g1Mfy+2O6wyWPLpdmTKw+zN2mD9DnzTLhFZ
 brtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880059; x=1779484859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9E1Cs+9YzSmm3WBGPknJAKNKqM2g2pEPkRw+0Ns5p+Q=;
 b=AwPjuFsZ2XZS7SXrJq2CvR3AI7VeIsacLoSUp0UbkMaRPXJWMkqcU/PSl9S0ASf0j0
 ymP1BuKKt4FenEuMe5SqfKjgdLyX6MoN6kIiveX46fX5j3pWXXic5UQHGRpQwQQssl46
 1QQjGuT7Ly7RnsKGaE3x8FGDzUMUN9GzmJArR0bEnJjuu8OlQp9aYBpkUGPV5/7tamPt
 73Jg79aeyRA7txxEuYlrgR2JS3CXgZUirBWZVcKwFDPIv5ZDrrjMtKA2NQCw59p++N0l
 z5qbwMqZsayYDRGdOigs5Ia4JPbR08WLLF4xhOh3E6gDnLB0w+DH81wJTyvl26P3aIYq
 0irQ==
X-Gm-Message-State: AOJu0YyiJKmS3luVk7QWLCecaEQ4wxWUJhb3QYCcYTnQm3DxoBjDe1FQ
 UD/R8vogPvzatc5AxS1IyAlt8Z+dt1ucP2frUWojS4ZrVn9pyFuMGYI1Ct6C5RzAYgDKd499AP1
 HCHfmlG4=
X-Gm-Gg: Acq92OEDMkxuyKN9fosUXSY7Lfa4pNdrkoV+hdnCKer+HiZSgjK713iiDMFgvQ490iz
 LOddS+mT9Lqkzkqk7M1x7pwKT6/ErixB2uRh8uRkQKWJzbLOG4M40ST7m74gFPzsmY9tfZd4fH1
 v8wnAwqwriUsGt1ITi4Y7QyrQ+Dxjla3h2cIHKtVjkuxSNpg87Env7ccXtb23L07cFf331JfnkJ
 zqP/TLY8v1Bi5XDFndPqWr447CB89jQHG6jHATttzpBjCEaamAUgYKe3IbdM0ENYpJU53G8HR8V
 TcGeV2dobQAv+7fhNoqo5zLvyQUBadp6doz4ORxyooMBBeP2YzedLfjtGjatRlisq34ICXH3HAw
 cHGJ8xpZnOJLpIDtxxp64OH1cDo/TFTOUbReqxJh8mg4BfHGi6pPUFFQfpjSopfhpwJT43/Mtdt
 i5XwAFd8IqQg==
X-Received: by 2002:a05:6808:c298:b0:479:d4b5:c19c with SMTP id
 5614622812f47-482e564d3d5mr3578659b6e.1.1778880059091; 
 Fri, 15 May 2026 14:20:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:54 -0600
Subject: [PATCH 55/66] bsd-user: Convert TARGET_SO_SNDLOWAT to SO_SNDLOWAT
 not SO_RCVLOWAT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-55-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xgPDcJukIu9icYY+USe9Z7bonFomfnsBoCz8xcyKIKg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nI8XhFT5vgdi3nswjUpOBfRZXRYIJQM0Sr
 gjjMKN3ljOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AFRED/9Bs+/MkkxCScNhLQsA64tpgSZ54RxEr+y8nLXGGE8F1tXblL+WU9dZOKJSsz4gh4NXIXg
 dTSeqGLn22RTM8JJBQLczzssg3J6BeqJb7uOrcMz+bQG1WYtSp5dScsm9BVSZMhz9Z75pP6LGI/
 HSVFCUqLg/f26/6ltYmRxga+yNHLs2XvUGtTnhcVdhJN8Pya+PakabSOoYpZpXykbqHofFiCbhw
 L0EsSlpZbaykUrXqKRnQukCYP77701z79qgQWhedgrZhHBAGnRBjjm+0HyOKlE5L3Ln9wnOa5lm
 rP+fyDFiZAkdMbIDFChg0t3qcm10X2Fu31ZFRXn1rorRTNJvQFhKYKnoYsc+FSPq5oXgsR/ungg
 apPful+4OfMrY/2NQIOVbzlwAw1+oSsTCvzoC4m/VzPgfkUvr8gkBmlrWSfKyL3exXr+CODjbTu
 9v1HAZmJqNDf/4nVAui4zuZbMxyTmRIyZND5orFqyb6/FeReFyu8uA8r0PvcLvAjOwp1M7upWjy
 1Uf14ipcOBjFTI8dVnLRiPW6MwbAmLoJe6MPW2Ad4wu5d3M4DsOiG1A7DRQqugXH3mSHSE8lEA2
 H22rS6neRp00cz5kheruaVVl9FMWSCZKwo8MyltESxwGyxZ6Wdo/8VkEqu8ZcQRqOVFZG81GrPY
 P8cWY6GLEPgq8kQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index 05c22f2f0c..01ef5912db 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -331,7 +331,7 @@ static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
             break;
 
         case TARGET_SO_SNDLOWAT:
-            optname = SO_RCVLOWAT;
+            optname = SO_SNDLOWAT;
             break;
 
         case TARGET_SO_RCVLOWAT:

-- 
2.52.0


