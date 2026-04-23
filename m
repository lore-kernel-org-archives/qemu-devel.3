Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F443F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquh-00085z-H9; Thu, 23 Apr 2026 06:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquD-0006bK-EP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquC-0002Rn-19
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so4381779f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938609; x=1777543409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ugqpbtwvm5Gd4soksvRZxwbioF4y2I/h5kbMLra7Ac=;
 b=cK5vajTUFmkNySgWv92GFwsT4fn4/AZaWmT4Y5YjA9z094KXxWu9V8lxmiI2/jFCUn
 NTW18aukL67O+YFdsgPsY1xqqypkfsF7ZzVY9FgRrExyWyJLcGfrx2+dW6CP71ze4tD9
 /4d4Tid3VQvsxxNnSOBBScAmwLyFFckc0pgF/BDHiAqyE8aHD5jV9R8bSsVPYEkz4HHv
 GBW4lkNkaHzoVK7E/QyifpuB/HoDgKtze4ft3S1dp8zvxG235jfHtqiPaddNm7Ux6VSt
 m6KqI/18/QTotnM6pE0xgpVsB2ypJo8dKbcr3zN1opONVpNDOVVnxnInx5BGA/1oej4M
 XSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938609; x=1777543409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+ugqpbtwvm5Gd4soksvRZxwbioF4y2I/h5kbMLra7Ac=;
 b=U+xIziUP9VBsclaLeEpBKCAAoMRM7fZzb2gKyg3mzvaewaLvyXAbgiYKMsCdjEqmnx
 ZUPqhHGTDKL//sbDnr7mjjA4Rt0ijchTIthX6IF4D1TQ3AwTYrXKyVkDHqOM0kOS6J+W
 BYoDmgADx7ZLbTtHWeqB9n3mLyNBmE4WKY2LIFQr+e+uPEC9Hx0OxiZenMgXI3RbGBRQ
 dOs8UtjiWF8gziHUKd/q7BXR4EgFdNoCX6DqEV6Mgqx1oSeQjmnMFQSWwIhADqqJ4pnt
 j8hyCjK573LhnZTK+IBGF4EOwORiBunPec2+Ag4WYDn6DZgRCPbSyqbs20I2xe0GvVQs
 2HQQ==
X-Gm-Message-State: AOJu0YwmAsku6k4jOMC8GSTfX5I3o811QlPlq6o0zomghR03bniyO8Kh
 /jNBk8Aig0UGPEFfG9lpWkIN1Nu+bTIGuo6Mxr0tRRt1JYb0YmwG7NNTuWOEdWZNqDCBl8AsJPB
 xF92Z
X-Gm-Gg: AeBDieuyI4nhgpE89+4i02I5iedO3/dCAYV51FJk2tS0rJD3czYbM8vCkrhsenJmdDW
 6lTctCBjtdojW9adQBXIRchFsZQ5ms76VxfkdC69cGugLCHdE1AJJtEuY9xThTE5WOprc3ZuhWx
 eN9tHn92gCOSpy4tGfev46PK1bWantQNINMztBx923gdJmi/dwlZTqX+V2vRgx7l/QZ3XZ0AC7V
 zO5a1wHwmD25PvCv+6L6lfMLmdpx8zvKy9GrRh2yPc/P7A8QU6xr+LtDO1t7DweT3GS1DOvMLwe
 iaSk5U4s4FN/T5w4Tuo8u7IYwYRqeptO7jyVa+HkcAo3SKDRpbrokbimlj2u2iKrZuVOmZTIPkZ
 pjLE+UxwGF3QiXBwVKoUKGwD4cWvL3uOXtDzZYPPiBTKsmjncbhaJWblnA+XD+MKrDrjiVPBTdf
 s4uVjNAV8gbMApVYXFlbATprGbYMMOR3ZSP/+cyPVDqeWojj2HmS/PTTijhMikgEGg+DUWjSuTg
 411nrQhZjvS3f0fW5pQhnd0IXJNKZO45lKUwb20sw==
X-Received: by 2002:a05:6000:2087:b0:43d:6787:9933 with SMTP id
 ffacd0b85a97d-43fe3dcae81mr41666148f8f.13.1776938608664; 
 Thu, 23 Apr 2026 03:03:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/59] MAINTAINERS: Remove Ryo ONODERA
Date: Thu, 23 Apr 2026 11:02:22 +0100
Message-ID: <20260423100229.2941820-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Ryo ONODERA has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-22-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb05deefbf..ddb2633ebd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,7 +671,6 @@ F: include/qemu/*posix*.h
 
 NETBSD
 M: Reinoud Zandijk <reinoud@netbsd.org>
-M: Ryo ONODERA <ryoon@netbsd.org>
 S: Maintained
 K: ^Subject:.*(?i)NetBSD
 
-- 
2.43.0


