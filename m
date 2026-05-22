Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88693CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNE-0001ZU-Ej; Thu, 21 May 2026 20:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN8-0001Ys-Mg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN7-0003JF-34
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ba928852a5so46545005ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408252; x=1780013052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Orvef3Lr8ScCtwyYa/KmPBR8h6ryXFV894KyNRaZwAc=;
 b=QP1nRgmuFbzHkJmNmGOAgpkUVSYAG8BxleF2mdJ7iP1BgqxSVD+9HKd4pT94TYTVZV
 jH5bVujFwPj81B/llhWq/7njkejMkrp4BsTMLD90wbnzjtISOkQKdG2R8ldW5hpbmS2l
 m+hcN1HE1Z2MLDw75BeQcRhhqd2913aUlN5hdBIartzjnu293SXsUtH0fnJ3jeYzPShn
 ChI8Q4eUOu+LPjb4VOJJLNBimjk+1j4fXqHT2s90uaWUpxsMz5mIZnYW2Rh3ycNvLqo1
 VB7U0NxaT6pRq0IWIjcg9h5Ysq8Dsxn/0qZQWofidtrqh7TGcia5oag5MNm9TUGynZ7W
 iD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408252; x=1780013052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Orvef3Lr8ScCtwyYa/KmPBR8h6ryXFV894KyNRaZwAc=;
 b=KIX/OEDxnsaRVcH2SA6IWm9eazL5J3nTFHbbdyUVQtQIrj+5nXSJlykrfxAoPCmYNP
 OxWWsSt21ZMJKFhntn471ICvBxD9dQRdd1D8FpiEiaahfMjdZByTcH+tZDRkxGCBr5YU
 fM/2u5vdQUMlY9hqziiQE3Ket+acEowfgnCYAHNV2kZ1V0Adymy1tpzy7+w0Hj3TaFMt
 +HioBZiv3Ktx6lJoSV24hqZP4JAT4Cv8DWYjXh28DPLbuO5ytgUJGFcTIs5OPN0zvqC3
 D25aWp85Bd47aXjTsurw6ipD9usNWesxsx2Dh03kXALVuy3cdWE38Jrfd3OHm7rkKkBu
 KBHw==
X-Gm-Message-State: AOJu0Yx0D9yy4HS1dWjTrpL834N9hiq0ep3fspL6KvQB83ydjpFFvUT9
 tEO1/VhNZeUu6CdePpa2wDKAH5Ni9qws+w051M4nUshcb/UhshxoA/puokF+LJ/9
X-Gm-Gg: Acq92OFvWd/2nehe2n9kmVgnbkMG8und/XSoG83vDtuwDWvW71g3Uy9v7XpMGUxG6KT
 sw6pz1t/LganScrVaFFCe6q2WFsU8+QSqJAoGawcZumijbyD101i/W03eQnSgnLNfOgDX0AApsf
 Eg69FKoH1ZXZSaNLSsL3275BnYO25+cjmTvNBkA+xqGZvq8SPMP8j6LGZmw9+pKOmmyj4l/lbTz
 RFZXb6xX7YR15ONVDFP04h5zF3CzScJJ1vVhHVivhJa/9h0F3T8poBkyZjcNm87+8AWB61+jm3E
 FWC/QCMBZBlFX1WSo8VzqNQE2qxG3LhIBo7+pDVwvQF0stvFJPui130ppZ1NSgjV85Rhgh+1CI9
 M4dElC8ePKiSO3YOU/NFSUp0VDhe5+DeEe5qJib7d5r2HTZc62c15+P9rw4+hermzURYPcNyxH9
 +iN66XObCmDDPxV70PwpILvdzpYWnE2+8pG6CyKsr52A==
X-Received: by 2002:a17:903:1b4f:b0:2bd:9b0f:5f2e with SMTP id
 d9443c01a7336-2beb07bac6amr9852185ad.22.1779408251768; 
 Thu, 21 May 2026 17:04:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/48] hw/char: Check interrupt after txctrl register is written
Date: Fri, 22 May 2026 10:02:47 +1000
Message-ID: <20260522000324.23255-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Frank Chang <frank.chang@sifive.com>

It's possible that the transmit watermark level (txctrl.txcnt) is
updated when the user writes to txctrl register, which may decrease the
transmit watermark level to less than the number of entries in the
transmit FIFO. In such a case, the interrupt should be raised so we need to
call sifive_uart_update_irq() to check and update interrupt when txctrl
register is written. Otherwise, the interrupt will have to be delayed
until next TX FIFO transmission is processed.

Suggested-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260513030503.3665414-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b4de662d61..b9bbaaef59 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
         if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
             sifive_uart_trigger_tx_fifo(s);
         }
+        sifive_uart_update_irq(s);
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
-- 
2.53.0


