Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0796DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyQ-0005UA-FI; Tue, 28 Jul 2026 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyK-0005TB-6R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyI-00037u-Ht
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so2015204f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241905; x=1785846705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sF5ANGg9CnMLAqUhXEe7W18cwbSEdbMjW/HalmHe198=;
 b=Oe+RQO5t1Nnpt63ZedfQQvZW984G2k5WdlptRbDDi4Wd8M2VOM6laP7GQUQWjTxOJL
 neG7o4d1lf3Qfm/RymeDCHRx+2ZbHSd1TqkZ/G4oYGgEf5+5J/QalhA7Elce566cIgWa
 GpKD0K1UBsf8a74pp7jBeuFR265DBShMZr+YE9wOk5mTdMSGEx1YdJEEeyzU5FtQaCgp
 LF5X+9+AbLk4ehGvb4I9XSSmKmUJG3zb5XClk6iZ7AFVVnuwERGnH1qbzFdzMLgo/cRW
 7Z869QyuDM0LWE/uAYg3t/YDRMe4xF/VjYtFQQG8wL9+5H0gbLhyFA1AGNCLBYs4G9d/
 BunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241905; x=1785846705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sF5ANGg9CnMLAqUhXEe7W18cwbSEdbMjW/HalmHe198=;
 b=FYfKNxmrH/N2ZvtU/TIrgjcKIQqwNld5gfqr87iO8h3y0zcbcJ6L2au1mtUcnPn5Cw
 5mj0rIFnUNB2qC2yMR4ope1VLmMnDqvM0Z5pbR7AoZaqYzyLc0ijX1vFl/q486vNDPTY
 SZ6d1Ms/vNmNAW3KYvEqnqMSt7m4sUmb6xhRNyaUvOJnf1ly6TsFPowUXx8isSuuiyd6
 uQ00Y7jLIiZY2Rt38Ys9pXFOu22Ol6kTgKT78VXF0R57XcLzQY0ikhyUkDKmB71trycM
 ysAS9C6DsLfK2CosNKNA3cEUY9vYWN4uy0DJrCxRufZp9Z5fWHu8KnZM0atq4mzmme7o
 NWlg==
X-Gm-Message-State: AOJu0Yyyd3yzjzBcWAQl8P0CpwbvsFCOBVUJS9KUFpchVx+r+eObi+a5
 3RwA2gpzm+ZJEmniInL8NkQEVXroJxR6VFD1T/KjFBci/+lPCuzgNpVuBaUJz9hppkQpP48ELNO
 08iLP
X-Gm-Gg: AR+sD11rlLNvfexK/2Xf3E4Ac53SxPFDB8qWpGUrQhsP6VoWmceGTqVkEftjTy5N+gB
 copNlW7Yp9NuS9VGd/emQG6vvt5CINFpDu5mjVZRUcGf/cUZGZzewU0ESvLC0xWPWuPrZ0l9PgL
 DNshqf3ZbY3bewfirclkSEcuA0NFEjfJr9NZGyq7hPXxiJ79mnz1vPvqAjNY+8qHhooEqOdgLYi
 Emi/BKfezBGebwsylaj7iSAr2eyR3dqTeKwWvHwY1q2YuAj9XrSHrKqzZ8q+J8fLB4Vi0+vWp32
 hPc0yjR8yIh0jnxaOzNq9CfxcuyJR/IcN2AR44jIEiaHK1qheArVLXH7bAETmI2tw1ZpkqWrp4S
 PgD+m6TAnISaakZ3P6HGFVbIaU7XgQMeCtBF/1kWZICR3yGnylRzu6H1iusAmUjPlZ7gtfa+PKA
 fOfiQqdssfBWBkppiNCIslbW9P8rGmVYXd3J1DAiIvbrE3MmS9v+hGx7cHyoW39ctfzqcWUmeaP
 ezGGo8Pn8M=
X-Received: by 2002:a05:6000:288a:b0:47f:810c:8abe with SMTP id
 ffacd0b85a97d-47fb1f1099fmr2555353f8f.36.1785241905108; 
 Tue, 28 Jul 2026 05:31:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] hw/misc/mps2-scc.c: fix cfg7 write
Date: Tue, 28 Jul 2026 13:31:22 +0100
Message-ID: <20260728123127.1711653-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Change the CFG7 write function to modify the correct variable. This only
affects the an536 machine currently as only it uses cfg7 to store the
core 1 vector table base address.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260724160943.52509-2-simonxhy0404@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 7877b31479c..1ecb2879e32 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -299,7 +299,7 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
             goto bad_offset;
         }
         /* AN536: Core 1 vector table base address */
-        s->cfg6 = value;
+        s->cfg7 = value;
         break;
     case A_CFGDATA_OUT:
         s->cfgdata_out = value;
-- 
2.43.0


