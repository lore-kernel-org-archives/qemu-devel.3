Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B32BC53215
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnITF-0007Xk-DZ; Fri, 24 Jul 2026 12:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wnIT8-0007Wj-Ql
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:09:50 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wnIT7-0007lN-HG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:09:50 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4518ad44e83so325169fac.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784909388; x=1785514188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8IvMsfbKwm20zX2K1vOpEBr7NC9psua0BzNL+gVOX44=;
 b=XiM2TAB1wOBr2hpSBsPhCrgp194rgA+QajTJP1jFbvM63qLf9ocjKFeZXH+VH0WgO5
 +tbdYxUj7yVwRaGVKl5EOxTxTZ9aJPD0dh13pYN8b7DyXEWJTEE3IaSq3BtHJ3g893ES
 Z5xdmfwUO9PYrR68pPpm6v/XBhb6doFT9slsHqjZ08qlo+B1luqGKHAp22zgygtGnmhT
 U9Ek0v5Fynedk/96cbHZ/rjtSxFnwH+HrHqnPNebR6XZXAWl5omF+YogvWVeUMCTXX3o
 g8VgePue4rPEQVNTUVkIb9NTBK/06gGs98hd2HuC9vXb0DOyJpgJstoKtV1SMxxU3QW9
 1vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909388; x=1785514188;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IvMsfbKwm20zX2K1vOpEBr7NC9psua0BzNL+gVOX44=;
 b=PHyBBhpA32kMicQyIRKz9I8Txmisn0xHD3Tx7D0xlUONjANAUyPaMDYlHV5eBQrp0k
 QxYNX4rFU6sbMtpHRM/vYgx0gf7FYK/Gmkx86jZjtIn7qaFE1RhDBkJDCjOgT2uvRyfS
 QBoCgiiu/ldprzjKMzv0V0KGClEXCGh7ML4GpuOQKznt8koQ+u0lZp64IfxY+D47ehd/
 RLTjlzYX8nC9WfkqDA9Vg8n3w1QQnmekt3ZVRAVoTrEU/GwsxiMa8oeCdmGNx4s62LiW
 YS06CZ0MXccYVaNxU4ck6GxNzJSZ+zA1scGt5b2WdFFXmDGP6zGk4WpWJmHvsogCowKO
 1AtA==
X-Gm-Message-State: AOJu0YxDeYJYUQWb+1xijKLN8RFhSB7bRmDwmYxY5NlWXiDj5mi47QwS
 FEWDNXAzWJ8qzcV4LK6NCNRZyD8CYTV3Oi/aUVPs17hWWT44DDR4ox+EuSsku3zY
X-Gm-Gg: AR+sD10PKp9pP4y6XkznCHHJlx3jVFxHZR1eQYEfCjV2cw3ZAHI/zGbk+7ZZ3ZDEeL7
 39gPUy1qPTklL61W3jd90qN3vgygzSeJLeuIRoX76D0xfrCKwnk+LiuIZ/qMgbjPt4RO6Q0IVzV
 PSjbnJGzZIhtWsj25V/XIVHt+WDBfEvm+yFFIqUIvi5zu93kbjOWT8sB5P3gTQ+mHZzKhn3sKgg
 VgShDFOZzr86Lg1WLBWojRutXsJsIABvZfsv7sckth0JgkeHPUQV4PC8bHPD2FDFNl84eTEcTQE
 3gsMqR99jJ95tDcgxCDZqwLVaNAU7+i0qMVQaphG6dWT53cAQ80kvXOY3EjOygjiOGWcuA7d8t0
 7Bc3Yx+sUe39HuT5LaqHwZs6ELZWzErEGbId315b0NP8L7SJBJdFm9M2F+Oa3HpT9riFISE6y2d
 DL7IeaE42iTFm3r7UrdkVJW/w=
X-Received: by 2002:a05:6808:d49:b0:495:ecd3:ba29 with SMTP id
 5614622812f47-4ab3571ccdfmr5102040b6e.35.1784909387572; 
 Fri, 24 Jul 2026 09:09:47 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-457ab7405a9sm4542753fac.18.2026.07.24.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:09:46 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 0/2] hw/misc/mps2-scc.c: fix scc_partno and cfg7 write
Date: Fri, 24 Jul 2026 11:09:41 -0500
Message-ID: <20260724160943.52509-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Split commit from v1 into 2 as they are unrelated.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Simon Xu (2):
  hw/misc/mps2-scc.c: fix cfg7 write
  hw/misc/mps2-scc.c: fix scc_partno field width

 hw/misc/mps2-scc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0


