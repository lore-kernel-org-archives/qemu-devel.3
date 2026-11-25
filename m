Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18933606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBC5r+qN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8SC-0006WP-A0; Wed, 25 Nov 2026 03:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8S8-0006W3-8S
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:34:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8S0-0006Bz-Op
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:34:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso56893635e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795595638; x=1796200438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rCcXKFSweEzR/my8hCx0ufmJuZD5KJpcI2xZW8+oyXM=;
 b=HBC5r+qNrMSpzlYoS2q2sUjxfu8LMaEQdbVFfpHumuBpT8QTTDXtDLgAhfKJqmBOVE
 cKG6+6EyvYczaW7vaHll7gd/VB3ylfp/ZadezDh2BRRpLVTO06QzBRYJnPu15wW+Y6Ki
 KWnm45Y/5LMcYzEzYdAJD3vshpcRh7ljk2Jn6mzaOFyU7woz/lmf+7xmoZ8tXjTaK+9S
 khrmXDGhFU/4P4IzNtOMbJ+4c5LFWbZNBauPH23PGoaJy9XJPaSSmYzy8d8Y8PMM75s/
 k3Nqd36tnfH0HW+0Rks2K2MCWP3MGJ2bC4cHPC/m7dGlsS33f+kgr/iA4YUlBXyzT5rd
 XvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795595638; x=1796200438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rCcXKFSweEzR/my8hCx0ufmJuZD5KJpcI2xZW8+oyXM=;
 b=lSXhsfj9DMYHDPgE7qZhFErBruG9Ot6JoojS2Koz3ErlZS5smXEfrJ24jjXmFyzYS7
 D3xjAjGSgrb06UZC3LAMx4NZdVg9tCWKpXnk9EFUe8e7j/iEyGlxT2HLvjRPRc0L/H2x
 VH1Z8L5qGRwdLeVlkgBqW2p2gY5FkpmkDdOkTJO++y9L3PgRZ9w0sf2KabtGbwCPmRqI
 9+/5vXCv7QuggI5TcAx0Z+L+IRMwjw4xshgSeE3dtH1Xez8BKk8NHfp9YztgbAXC2ttw
 CjpEQZ/tuhepQb6SXSTxN8U2qDt/Mygkhd7LLxq/CrHzAzN05zZPPG8vSlIlIP9/bFPj
 QNHg==
X-Forwarded-Encrypted: i=1;
 AL+hErHna2beQn1i6Xl53JO29yUEJWXJ8o+JewB7EH7alT7LvI/tiZHCEkKWLr4LAN836RxulMBXAN6JaYxp@nongnu.org
X-Gm-Message-State: APuU4Z+PGjnTwgwHmwjbQZk5wuJmtGEICt77BQmoF6WYL21KUbQ9u+b+
 hn+fdsrercfGg3aG8F00vA3MnHg5qKbKVu8Xzc6Sm4Sp2jBlaEIY+jbH
X-Gm-Gg: AZFdTZfd3p/mf/U0Sn5nO7DdNCG3fT/QHen9/mM6+z0Jdb0Fo6AFG6kV9DuUTud8DSG
 rNHUO13Aa4fl7IOe7kJnvaQlJZWCdRVwYgycO6iWujqKr3ZquZrZRwkpVgoQp/AEKMpPiDnaDp7
 4IEkuaNVgPJqef8ygr+bO9kvY9NfAdPFu49l9i98L5WECtKN67Kyzrg09/cBnff/ADNaVT4lLHx
 MlMDAH0crybrs+0gvqTnPv7YIenUtrI5u3CfTsMD8zU0Lj/s0Roaw8yccUwwGfF7hyP8XaTFNX/
 Ksj8j7IoZFIoQSSPjQlbe5D2BHic0EWowdP/cS/7DUA636vVP9e7JfICFgsFCQFhUhEAvzIRH54
 F/Uo9+HwArhxNoD336Q+GKecoheCFUqpl0gLwtgmm/i+Dgy6ERuePDJ+OAMDpbi1Wd4x1jOb07n
 QxDCaxVUVqOXXSU21zBjNhdYE7pts2ylb4bzBi9x4i6O+bR2JRNP8hzNzA7/NGGH50DygD9aeMm
 2tmmJaltCJRM6XdC5qoFPha3RfbFxyNoR0drusjl6aAJrh1cKRNeVrIU68N08evB+W+Wl6jjGlI
 BBVBwS46VHXTTmEsYppYt4bwx8SQU5aTRIWiIIJS4nIPYzqXIxPtSCfOHf1zE8kfup8Gke+s05E
 i5jhf6n+6fbtdPQYg9AekcbaSfg==
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr331966915e9.12.1795595637893; 
 Wed, 25 Nov 2026 00:33:57 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm689837675e9.13.2026.11.25.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:33:57 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH 1/2] hw/net/can/sja1000: fix receive FIFO corruption
Date: Wed, 25 Nov 2026 13:33:49 +0500
Message-ID: <20261125083350.331457-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125083350.331457-1-haseebashraf091@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Remote frames carry a DLC but no payload.  Do not enqueue payload bytes
for RTR frames in PeliCAN mode, since the release operation consumes
only the frame header and otherwise leaves the FIFO misaligned.

Reset the receive write pointer on both hardware and software reset so
the byte and frame counts remain consistent.

Fixes: 733210e75465 ("hw/net/can: SJA1000 chip register level emulation for QEMU")
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 hw/net/can/can_sja1000.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 922431effb..580266cb07 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -57,6 +57,7 @@ static void can_sja_software_reset(CanSJA1000State *s)
     s->status_pel  |= 0x34;
 
     s->rxbuf_start = 0x00;
+    s->rx_ptr      = 0x00;
     s->rxmsg_cnt   = 0x00;
     s->rx_cnt      = 0x00;
 }
@@ -69,6 +70,7 @@ void can_sja_hardware_reset(CanSJA1000State *s)
     s->interrupt_pel = 0x00;
     s->clock       = 0x00;
     s->rxbuf_start = 0x00;
+    s->rx_ptr      = 0x00;
     s->rxmsg_cnt   = 0x00;
     s->rx_cnt      = 0x00;
 
@@ -345,6 +347,8 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
     buff[0] = 0x0f & frame->can_dlc; /* DLC */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[0] |= (1 << 6);
+        /* RTR DLC is the requested length, not payload stored in the FIFO. */
+        dlen = 0;
     }
     if (frame->can_id & QEMU_CAN_EFF_FLAG) { /* EFF */
         buff[0] |= (1 << 7);
-- 
2.34.1


