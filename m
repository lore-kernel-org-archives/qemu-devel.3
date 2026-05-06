Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A5CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKe5U-0008FU-3J; Wed, 06 May 2026 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5T-0008FD-3z
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:22:59 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5R-0006uk-JE
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:22:58 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-362e30526f8so2835938a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778080975; x=1778685775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYSWkemQaqoQkoKcIl2AYQAU37UzapwtVVi6XvTz2Uc=;
 b=ITWuzNSEe3TWmN1og0xYp4ciU5FABfdPiFJ1W9jqQD+j10hyY6q8dtVMgE9gQA5S5j
 elECWihp/3BgLfh41IlvJ0a9MVpwSbQUYq0ZSjFrCk9MUX3QEpKq+i/jtBQEB0lUOOgD
 RjJ2YF6e43jnVnWJfQkjDWsumfTlOmCdB96wD8uvDWmuin7XWudqd90QJeUnybheTdFv
 GCdGNSCAvPcrUG/N2etpqbSb11nZ6yZ+15VDOJQWdxvdMiHvX9rofWZaC1KsGnSiu78/
 VD2f6tyfkwFBbgGy/hq7TK6WjzSYov4NWHxDpb3eUqap6bEin/GQ1HUHUBqOMdnBVg6Y
 Ht9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080975; x=1778685775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYSWkemQaqoQkoKcIl2AYQAU37UzapwtVVi6XvTz2Uc=;
 b=gSKUKmqQJD/i4NhhjJwOWJI3KhykXlQfWrRhfvSQnBPZn5IWN772Dg/e9OiyIWfqGR
 6yt1uLBauAP+FelU/lGsGGl6o9fOhLKbK9HhGljBa22w6jkPAJZkDHrC6TWQj3Wy+pWv
 0jJG9cctRoVgwT4SPUqk1ndi/jGKZMTRCVNuySxuO+IahmKtwoFM18xSrVP6PdwQiUJm
 ksHmUWcDVCVeMYHn3y8baiwQXRw/ytrNopr7zYk/qf1cDYOHCd/bnDVIcelYg0QeKffL
 BW3G9VDbbFKRrdqXJVmgUI3PJZMbtYWEWc4dZZ+wdEGtXmYNun5qQiliE3K+B2546OJs
 IvAg==
X-Gm-Message-State: AOJu0Yzq5ppd2YvXwcoLA9bdmRphTPU7Km3euW2JkHmBWbX3utQwKIpF
 pgIjzK75F/VQ+Sh8lulCIFpd2sSWXX9yNbMj1AsrNT+1zL/LbycTeOeYZZ1I2xbaUjg=
X-Gm-Gg: AeBDieuro0Wcu/Pi+UzJp2BQ9q9LDPrGqChOJy9zvqSKIJG6mmMmBm7XHdzQU4fuiru
 AbXNQXehDUNuQDOmhCDZFOoFrjJCuY2ImMWGRqPK3hEtV0AG36fv89Fz7Vhgl1slunIAPwk12QD
 FFNifHwWCsuYCy0SHJkNFazSv4S8zLmDZuTK2MkbPSVrbRs8yA6J5Kt42G/IvwUxu8WvAKwLEdy
 shbao9OAl37Zgq9iFM8QkNIBDxdzQx71NvY5WzcFvRUc+HIm4c8aYarRkgEydBQl61W+0krrvGu
 4uaPasrCnFC/r2US3YV3V/yNA1NVceSv8DMITw7xM7s/M50gDiO3Mh3goB08wEtoGoEzpvDvikG
 kNFIoCHJ1uuJdlKEld5Kb2EISoJIYWhn712UVSSekAY5lhT9j9E24ZxkGBM7boEwxl0BVvINjgJ
 AFhvneyFkYb32Y76TGqsIZ/6JbwXM2qKKRN9yPUVHQ2jpGjvwMBuR6djXeOYmf1Zni9BmsCA8dL
 g==
X-Received: by 2002:a17:90b:134d:b0:362:bb93:f25e with SMTP id
 98e67ed59e1d1-365ac775af2mr4296847a91.23.1778080974696; 
 Wed, 06 May 2026 08:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:6400:c000:f1c:edf4:b0bc:edd7:a9ab])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4c8a8e7sm3800052a91.13.2026.05.06.08.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 08:22:54 -0700 (PDT)
From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Subject: [PATCH v2 0/2] hw/usb/hcd-ohci: Fix ISO TD USBPacket handling
Date: Wed,  6 May 2026 23:22:45 +0800
Message-ID: <20260506152247.82336-1-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pj1-x102f.google.com
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

This series updates OHCI ISO TD USBPacket handling.

Changes since v1:
- Split the original patch into two patches.
- Replace the USB_RET_ASYNC handling with an assertion.
- Keep usb_packet_cleanup() only on the synchronous completion path.

Munkhbaatar Enkhbaatar (2):
  hw/usb/hcd-ohci: Assert isochronous TDs are never deferred
  hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet

 hw/usb/hcd-ohci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.50.1 (Apple Git-155)


