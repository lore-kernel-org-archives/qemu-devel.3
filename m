Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA62C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnITQ-0007Zn-SV; Fri, 24 Jul 2026 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wnIT9-0007Wu-Ah
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:09:51 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wnIT7-0007lT-Rt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:09:50 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso465788fac.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784909388; x=1785514188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bBK2J/evuw2hHGBiaXcqazPp/F0RzOckukiDDPBww3Q=;
 b=haVVQAvl9LHqSIFshH9ZpKFDb141VM5v2uUAROKD0XtxAoDFH2QkXbHzeJIivtLih4
 5tuLbjxQ1kyo27i9bBpvIJY+JyE6VuWFqdOHnLjpDYTo4+UEUVRFClDuIrcaRbK20QIO
 oHF23CY/SZtW/2EpB1F67zbcwElWe5ay8tq1V+9S6vY220SAjbv3VQ/FzE9rFm/lhMDz
 y3IE3lXDShjTh5zDttCgLbr+iSB3K7KxGFX+CUbPSaqP/Q6BKS6xX4LCCl3NTONyMdbD
 wsHdqD5JvtSUGxFpyof9RRm9s9OhnwPxHKxnUUvwxUARGEnZ8cNF5OLmpwYcVIokWVF3
 CrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909388; x=1785514188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bBK2J/evuw2hHGBiaXcqazPp/F0RzOckukiDDPBww3Q=;
 b=bBGQbXo2n7+1iCSATEqY/inMrpods9ZkPUnAz3/xvIKV1mLHDAVkX4r/9fmQmvXap7
 liNFk46zRDgu3IGKszIjGLhhYhNqSwwawWr62RCqUiy7DBlqGm0vLX8Qwn+BlklFFwUw
 ZGksJoZoS6ndr/eBJtkC4um9GFX8B4FtyZTN7UxmM9wobF56kPHJdmEruPG6WczK0W0T
 BCF93XON+zYHvGE3YLgc4KOEKME9h5dIXPGfucdL58kC6+RQ1a4joJ44xOCVfpSQmu9t
 8bnmoRhu33AzXJTJqskAXSn5SkaAZbJwp9aFxxXzCzfkOHpmFDHWck9FZ9WpzpMzoyPR
 56sA==
X-Gm-Message-State: AOJu0YwVxF+WJxN3/oKRCuV+5rYaeUk4joWUvW7wofWQ2XSMA8SnFdBj
 +DituzkFtKXXcHcPHLB+fnw7NVL67eVr5lUTxevfbmdj/VS9VOHL2D8mRF+VWCTw
X-Gm-Gg: AR+sD12gdKVwpF/MdLq1utNU4HoKWFToxXKppUlh74AVhTAbwMx1U3Pmn/3qKWNjC/C
 V7QNSV1WPsqWMxLAamvF9ca9gOwSB4nMpE2+W3bIHn7MKWOD8who1a1cYYxIrQmfwQACgagFepX
 cVFuGE0AQXOzXUoWPBvROULidQFsCWtVEx90XruMIfB8Y2OIpNUAnNppCJ8HCibBJIq0Ntg9vlc
 F0Vqd5YprgjEC1rPdMsGRdB7f6Bk3ZMJrOT5+dZg8e3OEKXtPjKMUfu3ntNGvB0otq7iawBeGAl
 LXayecx2B4Akc9pbW+HwbhHB/+I2sRE2ititpfcddUp0IwY8JvuavQCvAOkYIteAdf8jQAXLJK8
 9Fl1lrpxqaEHfc1EDtLoZPvpoF7SL8OgMxThj7nfS71P50MXCZ1LjBKQGbAnEwF8ZwmyvOB7s9s
 C+TB17r378rvU7tfFefzH+xrk=
X-Received: by 2002:a05:6870:830b:b0:448:bf71:d13 with SMTP id
 586e51a60fabf-457a0f00fdfmr5000289fac.27.1784909388582; 
 Fri, 24 Jul 2026 09:09:48 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-457ab7405a9sm4542753fac.18.2026.07.24.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:09:47 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 1/2] hw/misc/mps2-scc.c: fix cfg7 write
Date: Fri, 24 Jul 2026 11:09:42 -0500
Message-ID: <20260724160943.52509-2-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724160943.52509-1-simonxhy0404@gmail.com>
References: <20260724160943.52509-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Change the CFG7 write function to modify the correct variable. This only
affects the an536 machine currently as only it uses cfg7 to store the
core 1 vector table base address.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/misc/mps2-scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 7877b31479..1ecb2879e3 100644
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
2.53.0


