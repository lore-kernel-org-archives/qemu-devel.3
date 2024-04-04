Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123B8CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2f-00049Q-Gt; Thu, 04 Apr 2024 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2Y-00044Z-OR
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2W-00062H-Sq
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNeiRXq5NIFyMROVxk11TKFtGiVB3pXkfi7BWGi1dvo=; b=Wq4jR53GmsHQaOTyJXhF3LXL3k
 n6bl0b/hxORmMB33meQUsSJpAOaAlJPY/45xtfpDVJGbAlRdkHGPBJe08SOx9qHD5gotQL2F0BWKa
 918aR5/YE6nC2pqFZ/HG2i+ei2TP7p5Ufqp92YKUcGctynqCwUMGXjyq4W/H8xUbIcQ4SwYtlVGjd
 RND2yGv+c57jJMkQMpB28usAQpTVpc7VVNKNP1bKpfmV+RO9jbiUULaa6sYkBkppRMuBqBLR/hW0s
 lCWUVXVXyH2Hawu6U5IGXh8iC0EH9jFVDsfwZ8AKaLhz2FzfyzHUklNb/XcGcQ3XE03bZYq5mnQnn
 /Wlpogk4vee3By6cNYA/FR5IBocFPWJGHjUz+KAmY7Khx9eT0VSHXVle/fGkThM0N0pXq91vMh5EW
 JeGgMQO7HMRcGObWvnNMr2UYBGpLGSa8OQcwBtCfAEm2mX2Wd+SrLftlxv+B7iNI9LLvVnX3UB6FG
 dtCt213ezp+1C27wSl3N88eJPt1Qm7rNAhPmsdgnuhlrfob/zBbsVw9/RyLlefFxizbKXH4x9ifD0
 /4Mgykg510b0Fk/ZO2mp1Aj0pW4RhkiSlqthDqiOw+9h2NGF7pgi7fV7zQb3ZJilRrSY7KrS/Bx31
 7KVTV2vacmuYULHtREQESqHlczhDMUslGugVGfg9s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1Q-000Bmt-0i; Thu, 04 Apr 2024 15:24:59 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:22 +0100
Message-Id: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/17] qemu-sparc queue 20240404
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 786fd793b81410fb2a28914315e2f05d2ff6733b:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-03 12:52:03 +0100)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20240404

for you to fetch changes up to d7fe931818d5e9aa70d08056c43b496ce789ba64:

  esp.c: remove explicit setting of DRQ within ESP state machine (2024-04-04 15:17:53 +0100)

----------------------------------------------------------------
qemu-sparc queue
- This contains fixes for the ESP emulation discovered by fuzzing (with thanks to
  Chuhong Yuan <hslester96@gmail.com>)

----------------------------------------------------------------
Mark Cave-Ayland (17):
      esp.c: move esp_fifo_pop_buf() internals to new esp_fifo8_pop_buf() function
      esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in do_command_phase()
      esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in do_message_phase()
      esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
      esp.c: change esp_fifo_push() to take ESPState
      esp.c: change esp_fifo_pop() to take ESPState
      esp.c: use esp_fifo_push() instead of fifo8_push()
      esp.c: change esp_fifo_pop_buf() to take ESPState
      esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
      esp.c: don't assert() if FIFO empty when executing non-DMA SELATNS
      esp.c: rework esp_cdb_length() into esp_cdb_ready()
      esp.c: prevent cmdfifo overflow in esp_cdb_ready()
      esp.c: move esp_set_phase() and esp_get_phase() towards the beginning of the file
      esp.c: introduce esp_update_drq() and update esp_fifo_{push, pop}_buf() to use it
      esp.c: update esp_fifo_{push, pop}() to call esp_update_drq()
      esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
      esp.c: remove explicit setting of DRQ within ESP state machine

 hw/scsi/esp.c | 223 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 81 deletions(-)

