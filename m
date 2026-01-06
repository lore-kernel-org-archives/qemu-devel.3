Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8616DCDC19A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6sl-0004fr-KV; Tue, 06 Jan 2026 08:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6si-0004Xx-2Z; Tue, 06 Jan 2026 08:13:52 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>)
 id 1vd6sc-0005kM-Da; Tue, 06 Jan 2026 08:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1K
 +C0rvcapn1Nqrdu7wo0W8r/tCXwExwjYu7UiVeRo4=; b=XnQIteZS3N+i/2m2zg
 KLxZRqpstTKmmbQPhF5j0cO51Ao3wRQwCy2SdGIJ38qfPxF672Oq/OG/+Xo3ydy/
 yJhNHutSoMpfleWRPZOKK4PPgL2ebKWLhpqSScjwEaD18CL60/V3uiaHx7uBvgOX
 5NnsTp4g/0FDwZKY5LBm3Ut58=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wDnT4lVCl1p0+SgFA--.17566S2; 
 Tue, 06 Jan 2026 21:12:55 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: cminyard@mvista.com, peter.maydell@linaro.org, philmd@linaro.org,
 ani@anisinha.ca, pbonzini@redhat.com, shannon.zhaosl@gmail.com
Subject: [PATCH 0/2] hw/i2c/dw: Add DesignWare I2C controller emulator 
Date: Tue,  6 Jan 2026 21:12:51 +0800
Message-ID: <20260106131253.16192-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnT4lVCl1p0+SgFA--.17566S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4fKrWxXw1fur47Jw18Xwb_yoWDWrcEk3
 srG347Xr9xZFySyFyakFs5uryjka18G3W8Ca1YqF13WFyq9rnxJwnrKrZFvFWfJrs8JF4f
 JFn8ArW8Aws0kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1GQ6tUUUUU==
X-Originating-IP: [240e:36a:147b:2000:594:6424:e3:c901]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9RhKXmldClinQwAA37
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi all,

This series try to add DesignWare I2C controller
according to DesignWare I2C databook v2.01a.

Cause DesignWare I2C controller is commonly used
on arm soc chip, I add it onto arm virt board,
and also an at24c eeprom for r/w operation.

I also add the I2C controller and at24c eeprom into
the acpi table of arm virt board.

The code above has been confirmed with i2c-tools under
linux v6.18 kernel driver.

Thanks for your review!
Alano Song.

Alano Song (2):
  hw/i2c/dw: Add DesignWare I2C controller emulator
  hw/arm/virt: Add DesignWare I2C controller

 hw/arm/Kconfig           |   1 +
 hw/arm/virt-acpi-build.c |  32 +++
 hw/arm/virt.c            |  38 ++-
 hw/i2c/Kconfig           |   4 +
 hw/i2c/dw_i2c.c          | 517 +++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build       |   1 +
 hw/i2c/trace-events      |   4 +
 include/hw/arm/virt.h    |   1 +
 include/hw/i2c/dw_i2c.h  | 151 ++++++++++++
 9 files changed, 748 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/dw_i2c.c
 create mode 100644 include/hw/i2c/dw_i2c.h

-- 
2.43.0


