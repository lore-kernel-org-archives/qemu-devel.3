Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DC1EC145E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQui-0001Xu-NG; Tue, 03 Mar 2026 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQub-0001U4-HP; Tue, 03 Mar 2026 09:39:51 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuY-00025s-2r; Tue, 03 Mar 2026 09:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1772548767; bh=d5M/afdSPgWRnZKbdT3KdaPEatJDvdBLhxLeJxpi1QQ=;
 h=From:To:Cc:Subject:Date;
 b=PraS6ofAtVLU0VgYJbMNj/O2h5zOo3W8iwNMCpS44H7KwxceMLr5SQQ/mHXw8UXgt
 MuxOOimddYTctE8/esUXzunhjlwQTC+kZ6iB5Fz9Fe+JanpEutn5ng73p5kfNSqJGk
 6uUnOJs8mM4LllgjTJrBHNOmZOJbep2ezxX/FLCU=
Received: from archlinux ([180.154.0.12])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id 7F901C7D; Tue, 03 Mar 2026 22:31:57 +0800
X-QQ-mid: xmsmtpt1772548317tu5vbz0p4
Message-ID: <tencent_D3A83F7C6433B6B2D6C4513970FD0446D708@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn35WTagDrqoIzBKa4F9gsvfAe3ooNqXFT46G4MdeUsbIetD0H4r
 9YOaDEqExn0iSB2tpjc0BBZQSR66ce6WZFtxKGJ7i85C1zu0Dwq4VTNrUN+O302lvePwfa2v7Ra/
 IAbsrEFhmJ8PfIdAxGjFA3KbcYGqbrKJecw+MFZP2AbkBIZLsRiVkrH068F82DMTWPawZ3dZVtms
 dI5X/NNaqRUUaJ2Bj7dRitYNaNBCv+4KLrMjPwRVSiSWJsJ/x5nVE+lGPGlSgvQ8mPzZjMw0/ml2
 DTclLzICMUCrMFxQLb48qLi2c+/eB4hxXAG8XnmhDkIKKaBU6Ya4hQ6x9khqwki2BdgVSXNdj85X
 AjplFbZYVwIDr4Yn31f7Id2FlfONgEvU+B1HP58IfZDo11P9/9o1fFMxyVLq2RPYAJR40a+vY9WI
 x/AFINFuguL4F5Bu5/zZ23hc2vUBccErGcOBDwIUzr9EwE0pvEmJ/5254X8buGzvF5Cl1WV4kFOj
 h/bgiR93dwNNBPDtIKkVWLloWZRiT3rNWr9JkEEqFnvpFXVxARe3UwDnnuHu8tAhf3dQCSPVo02M
 fqNSSpdZ8nTd9eELR0MZgi7aIXhTkU/D15ky9jcFfNUqjbkRIT0eQvo2uvq/Kbs8FWjLP13Hnnjm
 2ceOOpnLS2Bt2XRbSIAI2S3UbLMznFQhNuJwd8zjevMFXdINJuRcUwfyK7tAp7Huif0XgcLkFyzy
 IrVamE6y540zs0PEvElKa5ZjL3nmuO/hWvH2kEnJaZFJmNsXrP9/pcam6zqSG90FKz8Uopa6oG2b
 xnsgjkMnI5n1RoUWdz2Jcic6tzZ/YdR8eFjk4fI+O0+5CDx5FW0tJDm+A3vKy1gFTPkS8NtFDOiQ
 4taJrXOmxc+pneR17V1iraxeY5TKW8XbOpHPAkliGI1Bw/H3eIfyrl0yEnaQ66GyYfYRIwSrJy3t
 XhGYta5584gB6szN4BMkdpNezA9hVrhaoa+O/Pz8TYj8IMSVh9atCjWOE6HSRV1aD4IdfIDpw4TT
 Fl11N4yRJgksdw9O+qLu4bbdSAdmg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, jcd@tribudubois.net,
 pbonzini@redhat.com
Subject: [PATCH v2 0/3] i.MX6UL LCDIF: add model, build symbol, and SoC wiring
Date: Tue,  3 Mar 2026 22:31:53 +0800
X-OQ-MSGID: <20260303143157.80437-1-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=1486344514@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Split the original LCDIF change into three patches and address review feedback:

- place the LCDIF device under hw/display and include/hw/display
- use registerfields.h FIELD() definitions for register bitfields
- simplify drawing to 32bpp host surfaces
- add vmstate migration support
- use SoC child device init/realize flow (object_initialize_child + sysbus_realize)
- add a dedicated CONFIG_IMX6UL_LCDIF symbol, selected by FSL_IMX6UL

Thanks for the review.

Yucai Liu (3):
  hw/display: Add i.MX6UL LCDIF device model
  hw/display: Build i.MX6UL LCDIF via its own config symbol
  hw/arm/fsl-imx6ul: Wire in the LCDIF device model

 MAINTAINERS                       |   2 +
 hw/arm/Kconfig                    |   1 +
 hw/arm/fsl-imx6ul.c               |  12 +-
 hw/arm/meson.build                |   4 +-
 hw/display/Kconfig                |   4 +
 hw/display/imx6ul_lcdif.c         | 435 ++++++++++++++++++++++++++++++
 hw/display/meson.build            |   1 +
 include/hw/arm/fsl-imx6ul.h       |   4 +-
 include/hw/display/imx6ul_lcdif.h |  36 +++
 9 files changed, 495 insertions(+), 4 deletions(-)
 create mode 100644 hw/display/imx6ul_lcdif.c
 create mode 100644 include/hw/display/imx6ul_lcdif.h


base-commit: a6ec632dca8c7d10743aff29345e5e9e5324228b
-- 
2.53.0


