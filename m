Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEC3FCB615
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWzs-0000tq-Mp; Fri, 06 Mar 2026 10:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWzq-0000st-8i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:21:46 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWzn-0006jX-Vh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:21:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so5552276f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772810502; x=1773415302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nTtO4V15SBXsLaKOKeV9ZGa2ZuUKS907kHv5RI3m5qA=;
 b=o8a/YZ2KTdpTzFgrb8WExTTHNCGPLc5ansqzOLmR/yy3ipX0TQYpqQdw3uK7U4UrQI
 mTclN/sQA6vdzLrDUDSoeCOYgM9b2qAIx2rIZdruK2Ta+wpHUr4rXOqrNhoj/LqyFSOd
 rtp/lcnk9/C7LKvi8ZbYN+yla9J+luB/q2LgxYfF9kA52Fkydhad3z9K7k58EggMdo5O
 ZKQ8vOzUjpghn1bszvuXXszAL8FFVFQDSyYJLzsStGjXiPhESSxbWwRP126eNRpTY3qM
 05iISPZvPyEcTkpnyWSDVvRksP0rq9ogz720QlFSfKvC1A7mPOyD8E5EmOOzQHO22IUW
 PKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772810502; x=1773415302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTtO4V15SBXsLaKOKeV9ZGa2ZuUKS907kHv5RI3m5qA=;
 b=FrsWi8X+AuJCHzAH+s3zXpk9+IrnYqjxW543iT3ziXAKdVDur0DgHar39d8Voz5m7a
 PIhVWacEihdtTaVikBcUH0PMK1f44FXCqKt1UIWk4RprqI91B1eV0MAGVeWH3aNP4D5P
 V3jCTZl+xMQyJFiUm1xpR82XDwYA6J0Du//FOMKQMN7pbOUAnJOwM5innpg1dgPQtbUb
 9lb/To3ZWl4ZACjqLPBlIcfZSf2GecF9HPNytHFRgutolBMIeykBpx7Oyf4EwseQj8tp
 AYdBqYEas7dUw9dUA+sI2wRczLI/1MUR32OJkZ5ad0cR99I9/Cj2PnxtqXEaoB8xTIMa
 NaRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyyscoGY/Tb1V2DuMWuip3fuZqrlqUAing0m6lWWym2VXtOJQFpKJOtQ9FnTyhKropSxxMEJSV8Ta8@nongnu.org
X-Gm-Message-State: AOJu0YxS1Mq8ocPVnDmkTS2KrDFl/botuV8V8WJfucZEQkoLAVHBMCQU
 AEVp8CyhN4TPfxDum8FSH4s9GdYQTLW0A9aANPLKWBAiPbumt6OI9L5RvNvwDqJfwGI=
X-Gm-Gg: ATEYQzweN+Rq1FAEYw1nLt71CZhiw3fRU0zqbMnUNGELdbNWmslTD+QYa7cJwDveVKa
 aLyg/Qr8N+bdDnC7WqsXhSWMo7ulZ8ekwPvDVP7qMDhtB7DVm6AMpr6PZOkDt/veOCzoivxWUgc
 dPo/JD2xmP91TC9wS/24M4PcYoo0tSTVpPnWCJ9FWDf5ORh/lCPn2BFAxG3kF1mlJWw7xYqGP9a
 RYEiOUHErR/8QRJY9MlaAZ9nXGSFgQ9/Yz32heaRCY/ohjlwyVoB2t6/K6uaZ0KBWQnm81VHwjM
 3zkI0s9k4YigzNHjyTCxSHcDnn+YtliNjEYce+ZB9irIDAJwbiK4NHRqPIXT8aNhrVNDlwyedRI
 xv96RAjZWoM18YZ4sP8HNbkesZ+pCEJBxC4hySNSO17x65CQvIzl7p+l983o9SOxF/uDqAkW2NE
 ocJEdt6k/W50klS04Jb6jfb7LJcKrNVKWQGEMZCRcJKdUucGezP/+P1UNHAE1aGpQn/+yg8VZBL
 lBEl3H2ewJxsVNSqp5rSEjv2W+W7S8=
X-Received: by 2002:a05:6000:2c10:b0:439:ab3d:1c27 with SMTP id
 ffacd0b85a97d-439da354a23mr4101198f8f.2.1772810502004; 
 Fri, 06 Mar 2026 07:21:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8daf2sm4951307f8f.2.2026.03.06.07.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:21:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/dma/pl080: Handle bogus swidth and dwidth in transfers
Date: Fri,  6 Mar 2026 15:21:40 +0000
Message-ID: <20260306152140.2191653-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The PL080 TRM states that the DWidth and SWidth fields of the channel
control registers can only validly specify widths up to 32 bits (i.e.
values from 0 to 2) and all other values are reserved.

Currently we don't check this, so if the guest specifies an invalid
value we will transfer more data into our local 'buff[]' array than
it can hold.

Check the widths; since the TRM doesn't clearly specify any behaviour
for what to do on invalid values, we choose to log them and then
ignore the channel for transfers.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3203
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/pl080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3f8acb03de..6262c3f3df 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -164,6 +164,21 @@ again:
                destination widths are different.  */
             swidth = 1 << ((ch->ctrl >> 18) & 7);
             dwidth = 1 << ((ch->ctrl >> 21) & 7);
+
+            /* Only widths of 1, 2 or 4 are valid */
+            if (swidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid SWidth %d\n",
+                              c, extract32(ch->ctrl, 18, 3));
+                continue;
+            }
+            if (dwidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid DWidth %d\n",
+                              c, extract32(ch->ctrl, 21, 3));
+                continue;
+            }
+
             for (n = 0; n < dwidth; n+= swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-- 
2.43.0


