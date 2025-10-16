Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75606CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N1Q-0001SJ-SV; Thu, 16 Oct 2025 08:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MzG-00065z-00
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mz5-0000Vv-K2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42701f2ad61so260507f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617282; x=1761222082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wqu+i/9am3Ydoax6jOhAGzrHPg1Qj6gt1vx87Z+86SM=;
 b=TojfHdWAp4gY6D9wqxg5yOLK+V7ilarfeYQSlzQha7M+GS3B+S/t8vN5Ny+VdRdwlK
 3xDpxBpV92T3qKFHvG0YnSqCmuU3CynPITwGfLSzK1qGlzLJ+Kq+B1jQ7bjfhVpY2zNi
 CxAOGPEjXmNUwt/1xscHnjv5Khx7lFY9rIriQvFiZ99P8mJRQH6Tl8TDuL9LEpnTLb32
 M2l6p6DbbLvLGKCSy9GtwdHYTTd00o5nFbeDOVWsJO1BQf2mLFD8oVgFSsOlnPUz/9YK
 gAq8tKPSjq3yX7IDFZPRvevF050svgR+JCIjElNoWk0Oq7QtEmrYkuZ3nMOZH2N7DlEo
 18/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617282; x=1761222082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wqu+i/9am3Ydoax6jOhAGzrHPg1Qj6gt1vx87Z+86SM=;
 b=FMVeHU1BHWK+R0jRRNukQmMvCpHnZEQk5+w3zjzFdJEz0PAkEK03N4MR1Df9KU8BSN
 kLyPM4ElXL8IGEcqmxsW84ZsKDZjHtSfDyQhUi0lYZoQQ784jYG3/POOpbfzdO6dsFav
 WZ90ADGSpDagfc/czH4jxhqol60qky9qQCBikrm3Vfy15v8qs8W9GMMDhRFjf15LnGvR
 HX8k64tVTvP1xG1WAoq//6/OLVtpWTnDajASSJM9mDDfT1xU0tA0geGFUONZ6F22WbWX
 X4AABfRhs8+rRxC0usqRgXRc2fSfngB8F7Z4XiQkb0CZoqwdt46LiTy93Vj/6xcLip+h
 RSDA==
X-Gm-Message-State: AOJu0YxT/kAAHFuLV/h+2ho0av8ltvUpA8tJL/Bv4yzE9cCxCCq/M6+g
 Mptn0onTaLF8ysw8Fz4JuMXD5Jq/pYf5Hgbs4+RS4q/3UlWgzF9IJ+o1jmjEEs8Yqc0/ZVXEuQe
 Q9VAeStY=
X-Gm-Gg: ASbGncvrpLwTd3Ro53PI5C758FvABDdz/oDYyuJSIE5+NNIQE95JmBdJsR55cOMl848
 fJNO8ID7WmpHV2AriHuzP259uBQpoEoJHk6fet16tDNYJRLrNJAsyodBDgc1hOeMIET5lSMww9u
 /a7D1OBNPcBDIdeHgxxXoaIplB39q+HGBrEAV7DRofkR/iFOjCdgSggN3PP8i4irf6l1CQx/Vm9
 EOxO3v94o+6SRYn9IBT0eCYZSrIi4l/QakKx1Yv9XtHLLolHndayOfUZHzCy9f/Q9ALjBc3ktai
 mTS/yWrwshuxJ/ZrEKCd4EeInQyGGmnzRa52LGp5GHI0p2+FzoZfX3gNvD2F8W3jKeyeHFy7ahF
 g1Qf3+gBYTECo4jtTlILJWhjLmYQu2p5+E8xyqItcolIhWWqVf8OaDkNIBLfTRzv1M1Q4/PEu03
 QBt0b9mxzL1ZrM8uhS9kSe74CZLxMtKyvre5xgPUlXSmNyXTIyuMC4qw==
X-Google-Smtp-Source: AGHT+IHglHr7eTT77ykxWZI4m6CDKBp6kJM0f7ogpXAhd1pm06H+BB9LIg93nbjlhElmcqwS/OVuZQ==
X-Received: by 2002:a05:6000:310b:b0:425:7f10:d477 with SMTP id
 ffacd0b85a97d-42666ac2dcamr17361511f8f.2.1760617282149; 
 Thu, 16 Oct 2025 05:21:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426d0d9050bsm32554307f8f.13.2025.10.16.05.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:21:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 75/75] =?UTF-8?q?mailmap:=20Unify=20Cl=C3=A9ment=20Mathieu-?=
 =?UTF-8?q?-Drif=20emails?=
Date: Thu, 16 Oct 2025 14:15:31 +0200
Message-ID: <20251016121532.14042-76-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Do not let git-shortlog make distinction between:

 . Clément Mathieu--Drif
 . Clement Mathieu--Drif
 . CLEMENT MATHIEU--DRIF

as this is the same person.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20251009070512.8736-3-philmd@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e7271852dc6..15bec72470e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -136,6 +136,7 @@ Chen Gang <gang.chen.5i5j@gmail.com>
 Chen Gang <gang.chen@sunrus.com.cn>
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
 Christophe Lyon <christophe.lyon@st.com>
+Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
 Eduardo Otubo <otubo@redhat.com>
-- 
2.51.0


