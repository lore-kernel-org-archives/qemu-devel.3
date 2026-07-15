Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E99C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzVj-0004t2-I8; Wed, 15 Jul 2026 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjzVg-0004sc-NM; Wed, 15 Jul 2026 09:18:48 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjzVc-0003wC-UZ; Wed, 15 Jul 2026 09:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=M5
 zYUR0H6buh/No8E5ysiI6UT1qLfnd82+C1wOVItHg=; b=WAAs7leSSJsDtA5ceh
 hCnHRmI+YamYAJp2x6enGhPA1kebu+UGYsq7j3EJeO7grJpKc2XaRs81OqFUCEpH
 9VBjRnBo61NfZXkh4sAsQyvZrhKXihBb4MtWgDTn7hGXVQlRYsw3yxUhQOIIAWgE
 wzoraCHSspvhIj7D9/Zrt60H8=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3f9ieiFdqI6DwJA--.41397S2; 
 Wed, 15 Jul 2026 21:18:22 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 0/1] imx_serial: add missing migration state
Date: Wed, 15 Jul 2026 21:18:18 +0800
Message-ID: <20260715131819.14827-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f9ieiFdqI6DwJA--.41397S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR7CzGDUUUU
X-Originating-IP: [119.4.20.225]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-R+592pXiJ-bWQAA3E
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi all.
The imx_serial is missing a migration status, 
resulting in no display on the terminal after migration.
This patch fixes this issue.

Thanks.

Tao Ding (1):
  hw/char: imx_serial: add missing migration state

 hw/char/imx_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: eca2c16212ef9dcb0871de39bb9d1c2efebe76be
-- 
2.43.0


