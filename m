Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19565C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyeX-0002IS-Fa; Tue, 13 Feb 2024 14:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeT-0002Gl-Ip
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeP-0006D5-PW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r/D825CM+wgB3QynXv6y4XqG2rYUxZJV7YELfAYh23Y=; b=zMmZ4IeNRiVP1oGfeQuQVEfKZZ
 xryKSsq9Es+usdytNqg3+Q5EBEqphEq5GP3x9NN1AoBuvj0NGA2W+rJFy2IQebMm2JCslzH7MSVzX
 3L92WvE4ZYvLt4UpKYBZAQOQA9Z6KIsA9bzQJrdlR6PHpnP05wtYJ80LN5vWgRU7uYeaCBWrexLup
 l75kHJpm55uOvs5xLSEE/f4w8MFhCy/DR6cGUGEYXHc4yXmDElQ388WD2mT/eNLeoxbezhxm2+nfM
 /POf+lwIeibyOjMnaYm6lB/JfvfWLeGezzBPR3SHovQ5xKKczhdRGzt0ijMKVmQHkeE49bU95NkK/
 lgXpwr/dePG1oIHyomAjbvsgee0Sg+1XgkmnaJ4wu/rDbbq29DZyuTLduDbb7EN36jpBr+b/CLcpA
 7Kms5egnCENwFTBd1rh8mmTOUuA6GVNyAdUVCeb+5HSES8X8Jy0h+E+YBHanKfQ0IRPR72ZpQVfTd
 R0gtQloPUu8UWZy+UsebJlwVRlIxqN85b1PbZQlYOMHLgIy094/qElLnG9Gdoe7TK+LyA6DGgj/Kr
 u21IVdO8gvlyCE0b8y0nTEADbavqoGjzO1GYdbwYOXKVcaoscI5oAf51QDPAG2k9U+x275fI/ocPI
 CNkyIIIbcCky/djoftnwZ29tUiipTbFjFwWc7vK0g=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZydc-0008m4-6h; Tue, 13 Feb 2024 19:40:20 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:24 +0000
Message-Id: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/88] qemu-sparc queue 20240213
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit bc2e8b18fba33f30f25b7c2d74328493c0a2231d:

  Merge tag 'hppa64-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-02-13 13:56:46 +0000)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20240213

for you to fetch changes up to 78d68f312aec905edcb1dc5549a2c3a6f716605a:

  esp.c: add my copyright to the file (2024-02-13 19:37:28 +0000)

----------------------------------------------------------------
qemu-sparc queue
- This contains the rework of the ESP controller as agreed with Paolo

----------------------------------------------------------------
Mark Cave-Ayland (88):
      esp.c: don't clear cmdfifo when esp_select() fails in get_cmd()
      esp.c: move existing request cancel check into esp_select()
      esp.c: add FIFO wraparound support to esp_fifo_pop_buf()
      esp.c: remove FIFO clear from esp_select()
      esp.c: move esp_select() to ESP selection commands from get_cmd()
      esp.c: update esp_set_tc() to set STAT_TC flag
      esp.c: start removal of manual STAT_TC setting when transfer counter reaches zero
      esp.c: move command execution logic to new esp_run_cmd() function
      esp.c: update TC check logic in do_dma_pdma_cb() to check for TC == 0
      esp.c: move buffer and TC logic into separate to/from device paths in esp_do_dma()
      esp.c: remove unused case from esp_pdma_read()
      esp.c: don't accumulate directly into cmdfifo
      esp.c: decrement the TC during MESSAGE OUT and COMMAND phases
      esp.c: introduce esp_set_phase() helper function
      esp.c: remove another set of manual STAT_TC updates
      esp.c: remove MacOS TI workaround that pads FIFO transfers to ESP_FIFO_SZ
      esp.c: don't reset the TC and ESP_RSEQ state when executing a SCSI command
      esp.c: don't clear RFLAGS register when DMA is complete
      esp.c: remove zero transfer size check from esp_do_dma()
      esp.c: update condition for esp_dma_done() in esp_do_dma() from device path
      esp.c: update condition for esp_dma_done() in esp_do_dma() to device path
      esp.c: ensure that the PDMA callback is called for every device read
      esp.c: don't immediately raise INTR_BS if SCSI data needed in esp_do_dma()
      esp.c: remove TC adjustment in esp_do_dma() from device path
      esp.c: remove unaligned adjustment in do_dma_pdma_cb() to device path
      esp.c: remove unneeded if() check in esp_transfer_data()
      esp.c: update end of transfer logic at the end of esp_transfer_data()
      esp.c: consolidate async_len and TC == 0 checks in do_dma_pdma_cb() and esp_do_dma()
      esp.c: fix premature end of phase logic esp_command_complete
      esp.c: move TC and FIFO check logic into esp_dma_done()
      esp.c: rename esp_dma_done() to esp_dma_ti_check()
      esp.c: copy PDMA logic for transfers to device from do_dma_pdma_cb() to esp_do_dma()
      esp.c: copy logic for do_cmd transfers from do_dma_pdma_cb() to esp_do_dma()
      esp.c: update esp_do_dma() bypass if async_len is zero to include non-zero transfer check
      esp.c: move end of SCSI transfer check after TC adjustment in do_dma_pdma_cb()
      esp.c: remove s_without_satn_pdma_cb() PDMA callback
      esp.c: introduce esp_get_phase() function
      esp.c: convert esp_do_dma() to switch statement based upon SCSI phase
      esp.c: convert do_dma_pdma_db() to switch statement based upon SCSI phase
      esp.c: convert esp_do_nodma() to switch statement based upon SCSI phase
      esp.c: convert esp_do_dma() do_cmd path to check for SCSI phase instead
      esp.c: convert do_dma_pdma_cb() do_cmd path to check for SCSI phase instead
      esp.c: convert esp_do_nodma() do_cmd path to check for SCSI phase instead
      esp.c: convert esp_reg_write() do_cmd path to check for SCSI phase instead
      esp.c: remove do_cmd from ESPState
      esp.c: untangle MESSAGE OUT and COMMAND phase logic in esp_do_dma()
      esp.c: untangle MESSAGE OUT and COMMAND phase logic in do_dma_pdma_cb()
      esp.c: untangle MESSAGE OUT and COMMAND phase logic in esp_do_nodma()
      esp.c: move CMD_SELATN end of message phase detection to esp_do_dma() and do_dma_pdma_cb()
      esp.c: move CMD_TI end of message phase detection to esp_do_dma() and do_dma_pdma_cb()
      esp.c: don't use get_cmd() for CMD_SEL DMA commands
      esp.c: move CMD_SELATNS end of command logic to esp_do_dma() and do_dma_pdma_cb()
      esp.c: replace do_dma_pdma_cb() with esp_do_dma()
      esp.c: move CMD_ICCS command logic to esp_do_dma()
      esp.c: always use esp_do_dma() in pdma_cb()
      esp.c: remove unused PDMA callback implementation
      esp.c: rename data_in_ready to to data_ready
      esp.c: separate logic based upon ESP command in esp_command_complete()
      esp.c: separate logic based upon ESP command in esp_transfer_data()
      esp.c: use deferred interrupts for both DATA IN and DATA OUT phases
      esp.c: remove DATA IN phase logic when reading from FIFO
      esp.c: zero command register when TI command terminates due to phase change
      esp.c: remove unneeded ti_cmd field
      esp.c: don't raise INTR_BS interrupt in DATA IN phase until TI command issued
      esp.c: move non-DMA TI logic to separate esp_nodma_ti_dataout() function
      esp.c: process non-DMA FIFO writes in esp_do_nodma()
      esp.c: replace get_cmd() with esp_do_nodma()
      esp.c: move write_response() non-DMA logic to esp_do_nodma()
      esp.c: consolidate end of command sequence after ICCS command
      esp.c: ensure that STAT_INT is cleared when reading ESP_RINTR
      esp.c: don't clear the SCSI phase when reading ESP_RINTR
      esp.c: handle TC underflow for DMA SCSI requests
      esp.c: remove restriction on FIFO read access when DMA memory routines defined
      esp.c: handle non-DMA FIFO writes used to terminate DMA commands
      esp.c: improve ESP_RSEQ logic consolidation
      esp.c: only transfer non-DMA COMMAND phase data for specific commands
      esp.c: only transfer non-DMA MESSAGE OUT phase data for specific commands
      esp.c: consolidate DMA and PDMA logic in DATA OUT phase
      esp.c: consolidate DMA and PDMA logic in DATA IN phase
      esp.c: consolidate DMA and PDMA logic in MESSAGE OUT phase
      esp.c: remove redundant n variable in PDMA COMMAND phase
      esp.c: consolidate DMA and PDMA logic in STATUS and MESSAGE IN phases
      esp.c: replace n variable with len in esp_do_nodma()
      esp.c: implement DMA Transfer Pad command for DATA phases
      esp.c: rename irq_data IRQ to drq_irq
      esp.c: keep track of the DRQ state during DMA
      esp.c: switch TypeInfo registration to use DEFINE_TYPES() macro
      esp.c: add my copyright to the file

 hw/scsi/esp.c         | 1371 ++++++++++++++++++++++++++-----------------------
 hw/scsi/trace-events  |    1 +
 include/hw/scsi/esp.h |   18 +-
 3 files changed, 727 insertions(+), 663 deletions(-)

