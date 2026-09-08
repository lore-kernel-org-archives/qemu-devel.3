Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEDAC79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qLw-0002B4-JI; Tue, 08 Sep 2026 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3qLu-0002AI-Sa
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3qLr-00006p-Kv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxW_CHup9qrLcJAA--.28335S3;
 Tue, 08 Sep 2026 15:34:32 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxDc+Eup9qSQ0dAA--.29522S2;
 Tue, 08 Sep 2026 15:34:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] loongarch queue
Date: Tue,  8 Sep 2026 15:35:43 +0800
Message-ID: <20260908073548.3249551-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDc+Eup9qSQ0dAA--.29522S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1xAr1fKF15ury8WFyDJwc_yoW8Xw4rpr
 y3u343Gr48Jr9rJrn3Jw1UXrs8Jrn3Wry7X3W3try8Jr15Ar18Xr18Jry8XFyUG348Jr1j
 qr1rJr1UWF1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The following changes since commit 35500e5c41aec76cde59befe750600dac7a9e37a:

  Merge tag 'pull-aspeed-20260906' of https://github.com/legoater/qemu into staging (2026-09-07 13:33:12 +0100)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git pull-loongarch-20260908

for you to fetch changes up to 970657e490c05b0d2dd8ffbd68466d22685083d1:

  hw/intc/loongarch_extioi: Add extioi interrupt status display (2026-09-08 15:26:56 +0800)

----------------------------------------------------------------
pull-loongarch-20260908 queue

----------------------------------------------------------------
Bibo Mao (4):
      hw/intc/loongarch_dintc: Add loongarch_dintc_cpu_by_arch_id() function
      hw/intc/loongarch_ipi: Add ipi interrupt status display
      hw/intc/loongarch_pch_pic: Add pic interrupt status display
      hw/intc/loongarch_extioi: Add extioi interrupt status display

Xianglai Li (1):
      target/loongarch: clear the registers when cpu is reset

 hw/intc/loongarch_dintc.c   | 49 ++++++++++++++++++++++----------------
 hw/intc/loongarch_extioi.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/loongarch_ipi.c     | 42 ++++++++++++++++++++++++++++++++
 hw/intc/loongarch_pch_pic.c | 38 +++++++++++++++++++++++++++++
 target/loongarch/cpu.c      | 54 +++++++----------------------------------
 target/loongarch/cpu.h      | 34 ++++++++++++++++----------
 6 files changed, 196 insertions(+), 79 deletions(-)


