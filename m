Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E2ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUE2-0003UH-Cs; Tue, 16 Jun 2026 09:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZUDs-0003Tu-QX; Tue, 16 Jun 2026 09:53:00 -0400
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZUDp-0005of-4r; Tue, 16 Jun 2026 09:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1781617961;
 bh=tHU5y87heH/tZ2bc0hPUKWeZlrXjMFafF8vMRqG5/uc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xk067gi07t5ndq/2bvLvWmyW/sSVysZQi4LGfBvatlLqudGvW+Qs5ssbtcdmbakcA
 WPHz64hHns0myWo+gcs9kSKBJIuHGB8uYNDddnDsDsR50XScuxFTpG22tg7SPDzLXW
 8zaTPvpt0OgOEtGAMI12nBcoMNDdO6QwjbpBDlkw=
Received: from GavinQin-Ubuntu24.. ([117.147.33.130])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D138C0B9; Tue, 16 Jun 2026 21:52:19 +0800
X-QQ-mid: xmsmtpt1781617939tmj20dn16
Message-ID: <tencent_2D121E3279F02830A927286382200AC3FE07@qq.com>
X-QQ-XMAILINFO: NU1WwRH9AHfmoYkaQoj/XBiAQuqQRUZB0idtAxTZ7F7282kgkDzMHEDzIq4dBL
 DQwUwCNJpxFYlYv1qv37eIiASolM1MxShTkta3h7RBi/2bUPYtYzSQ0y8S5tTa/Uc7SwhA/uWsbS
 ug3UnOKPscSBTzmbV58O2pvR0sOX3o16EJNC5zGeb3c1FOoePT1dQMOp29u6ml9MagqJJMgvuP6P
 a0dg7fKBm5PvWunevr8LJeK8vfxTxRA7A89O+1XgSEZhDfPaSqMo/mzFpK1L1gwZyVtlB2nKBcjj
 QY8DgyDCmyBSXhvL0oluum8EiLve7hj4+55L2aVKwOuUF6nz+m/XZgo9PoR1M9l/9hBVx2r+fRDY
 Sd72INv3hChA9r12tJ3BrcXuz36o+5U1YEjq/T6x7ap7D8HMevaTo5CWBXfKpSptvx7TFAYicrCI
 UWTqoYNeU9GNxuyW9+hPOYC9J9HdnHJllZosfizQKcO+9EoeCsLfnpOEMtmZ2DPepQY0Ts+6BsnW
 p7bA/kh36rZ9rv/yKUo30A0Y29FKN1sCUnQxmLjQsE1fUR5hjhEiPcjAJfyicQa4XKbZegG99y+K
 arcU1DqVLLCGwX+r880pHqtaxk3vuPDE9l6E+DlWs9rpymStGlb3+mKzn8GZLvGzOmsqhHk6LgCY
 wXpicBb5CHgfZnKFpDbqmGojSvdTMIVXKFdmKVN4is5ezFSaarQPaKqY9HbqWR8YpiWd/RAiS4f7
 Ie4RecBZWMVkwE9yKMeTYFjpEZdgoZLLWzcvxRWbGxoZp9ICwT/YxCyij0MKzovrI8iuQ+5K9G3J
 aWJNWIGEU2cFxogp+cddhh3Y0qP7GHM2rfkFdZ5U+pOIYt6RvtOrRBcbYs4E7tZA/RyxsTtrAa1Z
 K0/8L0rYYUkuCetBpxz9vfXIM7wdzplk9sNajnbm0vIdxNSeK++p1Omcn/WsLS2oeanWpRb2z1Fw
 L4jgX6SDTC27hMfurJEguotjHxrdz3wmdGZGqY/6aM/SYcxTXsW2L9QHgu+eDp+0jVPXuWpcldXc
 D1hqJ1ydJDQME+FlZojxGYSxwT/qEc2Cogem0yZnwjojzKBsoam8qpnmmee1t64pVr7ihCwA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
To: daniel.barboza@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qinzhengxiang@foxmail.com
Subject: Re: [PATCH] target/riscv: avoid abort when reading vtype before
 env->xl is set
Date: Tue, 16 Jun 2026 21:52:17 +0800
X-OQ-MSGID: <20260616135217.7587-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <96088690-464e-478f-9ada-465f44ccfd08@oss.qualcomm.com>
References: <96088690-464e-478f-9ada-465f44ccfd08@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.235;
 envelope-from=qinzhengxiang@foxmail.com; helo=out203-205-221-235.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks Daniel!


