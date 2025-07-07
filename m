Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6D3C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrWW-0003Rn-Bg; Mon, 07 Jul 2025 15:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uYrWT-0003Jo-E6
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:29:05 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uYrWR-0004zp-1u
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:29:05 -0400
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
 by mailout12.t-online.de (Postfix) with SMTP id 035AFE88D;
 Mon,  7 Jul 2025 21:28:58 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.150.188]) by fwd73.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uYrWK-4Fcx3R0; Mon, 7 Jul 2025 21:28:56 +0200
Message-ID: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
Date: Mon, 7 Jul 2025 21:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/3] hw/audio/sb16: reduce the CPU load
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751916536-A57F856B-FE05C0A2/0/0 CLEAN NORMAL
X-TOI-MSGID: b0fb70bf-4fd5-482d-9abd-e81c7aaedb78
Received-SPF: pass client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Three patches for the Sound Blaster 16 emulation.

Patch 2/3 "improve DMA handling" reduces the CPU load and fixes issue
#469 at https://gitlab.com/qemu-project/qemu/-/issues/469.

Don't forget to add the AdLib device to the QEMU command line if you
want to test the patches. The OPL2 chip is part of the Sound Blaster 16
emulation. The real Sound Blaster 16 used an OPL3 chip.

Volker Rümelin (3):
  hw/audio/sb16: introduce DMA helper functions
  hw/audio/sb16: improve DMA handling
  hw/audio/sb16: block structure coding style fixes

 hw/audio/sb16.c | 105 ++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

-- 
2.43.0


