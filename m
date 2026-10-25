Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB8606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fzKbDy6A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3es-0007Du-SK; Sun, 25 Oct 2026 15:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29P-0001d9-U5
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29O-0007vz-4C
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1979439f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949812; x=1793554612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YyzHTYW0aPl8oKC5B+8AEtYCDjnBMpJYj371kM/t9UQ=;
 b=fzKbDy6AsBmB5DzKCRuEvHBENfgLkkRIrBEBHVYs73gm1uO3xlSHCS7ldCPN+HWtjV
 gUbsGYyC0gpGucfirIhnMJgdi9S7kJr0yCJA3PZ5+jO/ZC8q3KUnJWlRgX4vtFh6BrZP
 HWPbgEtfecCsBBbKrxto//UmWRdnWfJ0udFH0R7lSbJBAxIinf1Ya8U/IgmedKpOn8Rw
 QK1dA0XUpWJ5PQZmtvjl68nJYRtAC/qn+HJrpp8SKlLeN4YMPgQjIXeoHdZMqo3iTuvb
 JOFwN39HWRJ1KZ9Gm6itbbCdVVRgIQ8MZW88kTygB4ibB+MSCUiaxHwsIzDi5oj93e7Z
 aVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949812; x=1793554612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YyzHTYW0aPl8oKC5B+8AEtYCDjnBMpJYj371kM/t9UQ=;
 b=GAw+sCxCz/yhVjJk+hlt5HtIC4GNH4fiic+Us3AO57utkFMXIwgvLRbMyHSKDBf7up
 8buu3ACn5ehVEG4lyJUhfTnd7fIZX3RqaKZ0KdKHBW5io/UN9zYSw5p69/OPmpcJerIc
 8z8Stu2hnLtGGjwD3HzUPY3SpO13rdAjfGsuXznLAZV9Pqju8LhDN98XVpSZ+x+uH4gf
 KGz8ZGqYfJH5t80Xrm31lxWZHWjB7t6e86et0IUcd3bNAr3MehB7o7xbsRyCIAEFbJeL
 0HVkx0h2n082lHOK6WUcFZu+mgtQveQMNu15Af1mQ0ZCFcFmKb7eDEWppKzHx9V94yem
 dSVw==
X-Gm-Message-State: AFq9FYK2de6Bsda9rm49sHYKlFRtkemNKa2T4pTSaT2WZMF9VQ0i0M04
 0JGb0QRxc6rlHoWl051q/nKEfc4985oReHwMdscmtcwW/4zCof7Et8iDduXG
X-Gm-Gg: AYBFou1c8KjU3oGDzQdufthkHRXXabNawrtZ7P3/lbAEEbI++nVtcdAttPN7YVgRSzV
 j4oc/Nxq2lAcMJoqMIOg4iPPYMUjT/0pwkn52hN8GwX1KbYE7Iy8bYNBzvHNFTIqwdYqZR1M3h9
 Tt87aLheroVpZFZ6aTYJeYiohruhau+1BeQuTzm54XrxySAo7CFjCjW5bow0xUJeUDb9TD/p9C5
 5Fx7VnQTUs6QCIt9bpcCeqK1GHmEnXVnKcG6K2D4P3kxPvHSc4d3xgmmsbag38eioMBXLAVt2j0
 bCGsUhubWXKX2R5okSvhnsDRDP3GThVn3jFV1p5fux39gHzPkXwLUnUqAaIlGg3VHGnFJHKG7Xu
 cn2xJyWBfEhhXwWBxuI8DN51vQ0PDKzJ2l2cHI4ievjwqSqTC57AbgNFF97YlLRJoE7attTLKKs
 ZYOhTnOdvp8h2fPy/I0MxwnBCV+r3IIWIqsuneUk6r39KPT7B+jbw7bHksTH7ssVsPXwdM2yhP8
 05UEXyBidl2msRNXqP1VOX4daNtMbeDw271Y3E=
X-Received: by 2002:a05:6000:2312:b0:48d:faa4:5b66 with SMTP id
 ffacd0b85a97d-48e3eba7bd7mr7779477f8f.36.1792949812305; 
 Sun, 25 Oct 2026 10:36:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 8/8] hw/audio/gus: fix 16-bit DMA heap and stack buffer
 overflow
Date: Sun, 25 Oct 2026 17:36:25 +0000
Message-ID: <20261025173625.3372689-9-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 15:13:16 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gus_dma_transferdata() processes DMA data in a byte-copy loop.
When the GUS is configured with a 16-bit ISA DMA channel
(gusdma >= 4), an extra byte is copied per iteration (the high
byte of each 16-bit sample), doubling the effective transfer
size. However, neither the source buffer (tmpbuf[4096] on the
stack in GUS_read_DMA) nor the destination buffer (himem, sized
for 1-byte-per-iteration) account for this doubling.

With count=4096, the loop copies 8192 bytes total:
- Source: 4096-byte over-read past tmpbuf (stack)
- Destination: up to 4032-byte overflow past himem (heap)

Fix by halving the loop count when operating on a 16-bit DMA
channel, so the total bytes transferred never exceeds the buffer
sizes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4653
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/audio/gusemu_hal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index f159978..1b0db02 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -534,6 +534,12 @@ void gus_dma_transferdata(GUSEmuState * state, char *dma_addr, unsigned int coun
 
     if ((GUSregb(GUS41DMACtrl) & 0x80) && (!(GUSregb(GUS41DMACtrl) & 0x02)))
         msbmask = (const char) 0x80;    /* invert MSB */
+
+    /* 16-bit DMA copies 2 bytes per iteration; halve count to stay in bounds */
+    if (state->gusdma >= 4) {
+        count /= 2;
+    }
+
     for (; count > 0; count--)
     {
         if (GUSregb(GUS41DMACtrl) & 0x40)
-- 
2.53.0


