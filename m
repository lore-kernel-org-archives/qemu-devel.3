Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE54A112583D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KuW-0005vI-4Y; Wed, 11 Mar 2026 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUy-0007CE-UT; Wed, 11 Mar 2026 10:25:21 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUu-0000Kn-56; Wed, 11 Mar 2026 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1773239108; bh=un+fO6utzHBLrdQ++Q1vvuMQfAIf43kwvCKZAjAmfHA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VGYLtUtYF82SVVBh1NqFhhkMoHKI6ucVIpGyU7IOz7w96aSSB1Z4p76V2uKexZXrQ
 TwjXVuRDx0H7MUD8fpw2BGPSASlEQjDVfKsZ7AgckIfDoYA9BrEe/gQaQFuAPlkcZo
 VJckgk1MQ+nUbCrCUnGzY7Eb+QdG/sIrAKXT64Ws=
Received: from dt-VM.localdomain ([175.152.130.74])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6460A831; Wed, 11 Mar 2026 22:25:06 +0800
X-QQ-mid: xmsmtpt1773239107th3qvlhrm
Message-ID: <tencent_7A1227883216A4103DA25F5A585E86DFE307@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JumEERZiuJPG1Q72Fh1U+WTp/5sIGSWo9gSj2ObD7Vgk5nKvTZxp
 RG71QSaix8gEd4j+uePw3rMYeXujZU/KvxpFzmOX5SvQ4rC4A96IsvVAt/biLG5LNh/95nX87C1h
 YAmLrmK8rxDv5uruBHXQLuIsCS0XJnLKhFvMU0sB/xgbEooqlvkCUSLCSiR8ZNxvvkVy08RBm+Aa
 ObmJLzKea5WjQ7VjBjVB5qLGpBcqC7jFhq1u+MZi/Scpf4BThGy/ehIF824xSkyRCTbQiss/54Ur
 yGkYQ/d1KxtYbEOFyNXSahkhMUcpaYQqjNF9WUg+8b9gb1W54mCw7IjyXFqSV2xAXTR8cUurEMrR
 HY5XaYtzMWUX3YF+/TMkwnog0zyfMllG3knJgt6EkswBaRN9OOCzdrGLiF5gsL0pu0dmDQktAPgj
 VHwIHKI/2BeWlnsGCgOBpxBd1rx43tpnmnt2ZJDhtSexOrZhIfmtmAY9BNfe4O84xD3DtunJWfOB
 3f2FZaR9B0OTfoZ2OCYY8ze+ATr/z3LkgeAxUvQdOVEMbz1QjQPbuLRqfScZWt3Refc8HjbB6aAL
 YHxDmOmTMXKJxDl4kEdjFUOoiTb5oSXd447oqDvSMCdO++a+ex88mBtKszHTiKAOC3BqhGBRVVq+
 /Cg+bWrXmHIPkNUUFJnuoxgT3jNLY0APFWXxCai8WLnjADmDKQLIWnBHJQjRIH9zJtvC3/G0g+Z0
 sWYZLpyq/mXrbdzqSFGWg4gcI3Pc8TAldq6ErdUFl3q7Mdt+sXV5F6d9Ex0b1FxPKf2mTKg+68Jj
 TvkG3LuUrMC2Difbt1X/EDWH0OfkhOD0BDcP7ieLfTipKBBdi0u8xYXb0Qo1Awf3l9Vhge708anu
 6v/r3MiitlcpZ31b6dWFkZswX/m6a47Lm2M1N1MnQGr/Dfh1F87xREOkmksnPAhB3MqoxcShpaYo
 DquNOwpDpr4keFR0Vs1uGRAIPXg2HQe8C6FurrAqtk/yq0elB085APxKBqB76khaUC5hVuUr59xX
 Ky/M4E/09yVkq6+rmpuBiut7pNrhE0pwko2KhE+mEt9DtgoXe//LR3s8AQg9M=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: 1774596582@qq.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	TaoDing <1774596582@qq.com>
Subject: [PATCH v1 1/3] An interrupt is generated after the DMA transfer
 complete.
Date: Wed, 11 Mar 2026 22:24:56 +0800
X-OQ-MSGID: <fbe39deb69ed4a3da783407342eb14b59d77c7bb.1773236195.git.1774596582@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773236195.git.1774596582@qq.com>
References: <cover.1773236195.git.1774596582@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64; envelope-from=1774596582@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Mar 2026 10:51:41 -0400
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

From: TaoDing <1774596582@qq.com>

PL080 cannot trigger interrupt correctly. Reproduce this problem in a simple way.

In the versatilpb board, the interrupt output of pl080 is connected to the 17th interrupt input of pl190.
By reading the status register of pl190, determined whether there is an interrupt generated for the corresponding input.

The basic address of pl080 is 0x10130000, and the basic address of pl190 is 0x10140000. 
Read the value of the address through the qemu monitor.

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x11223344,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e4bf001,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4

Qemu monitor
    (qemu) xp /1wx 0x10140008
    10140008: 0x00000000

The result correctly after fixed
    (qemu) xp /1wx 0x10140008
    10140008: 0x00020000


---
 hw/dma/pl080.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3f8acb03de..1a39954f04 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -309,6 +309,7 @@ static void pl080_write(void *opaque, hwaddr offset,
         case 4: /* Configuration */
             s->chan[i].conf = value;
             pl080_run(s);
+            pl080_update(s);
             break;
         }
         return;
-- 
2.43.0



