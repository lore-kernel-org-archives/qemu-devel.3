Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf3id-0001fG-JY; Wed, 01 Jul 2026 18:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ic-0001ev-0g
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ia-0002Zp-HB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so1413599f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782946062; x=1783550862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CF6aqiLW//pEasDlZ1FiMneWrrUaakDRnwqxP1YKszk=;
 b=L8Upn7qkGR7SwmiLPA8F8tEQ4qaShpq/JkiVtfeMotG3qFcrT+vaTsX5sq1/PwLnid
 XogDVTzWHEbo6d3jTNZjaI2q1dyO1ZVThzg6m1O4N5YLaty5WxfE3hwXIfSaRR6m+ogG
 z9F/3GK+S7hm4AeUlsSLjm5DprW7JK02tpZXKdx6d67vBp3LL3fwZWkh7gULVPNiMXJC
 QZUXFXRAwcPqWqtOwvXofzg/N8jGEMjKaOpa6CueKd5iGJPlmGIKnRy0xnjaPbBm3+kK
 5YUkNLQHDRd2kLLAbOQHZr4u/gBEqCFpP72xx6qd6U/rxc8rQ3HZMNo9REBONVjl3MTv
 3c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782946062; x=1783550862;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CF6aqiLW//pEasDlZ1FiMneWrrUaakDRnwqxP1YKszk=;
 b=Dw3pbMN6YmKorlygGtZgJWEjy6yGsFAdFynZAOxUHpyyBoiY2Qxu2bPW0cv4kqbo37
 ZAlzLyd+i9QvgnE8VRTz/oGnT966Ej+M8lrHD8/tW/CJtLrIFN2NFp+IdLo3M83cHDS5
 A5C8yR3VNajUASjc42LJzkZ6mXe4haHychQMa761Pzre6A+cpoLCAb9v/wKclZL29XaB
 3/Lfn9yjVEysVFBvBbF8GVS7wkvPeAaImSdI8ueDIu+3W8LEt5VBhqvELlMti7r5nvhX
 qON01cTBoKKMTN4asEADz/aPtbhVLXJiTgGZCj/NnTBYIzgGfOyTUy72Z7DfttkMgcqo
 GLuQ==
X-Gm-Message-State: AOJu0Yyph6AyHtvngDYWcUZCSXX10pbHN3BTmHH7jVAUDTtRIqZ2fIlJ
 AKddWoeweEoriwXuvBn1KHUk3p8fWkdCnVUCHop9h3WScI2XZh64xX1ClKgpqg==
X-Gm-Gg: AfdE7cmBVE4X9FI8f9aj3wX61dd/0F6vDvN4yIK6jcc8Wa5H0so7mXFrGQC0xU595NZ
 9P1fIyE1n3Jpohv6okQmkBIkz68f9xnz26SEuQiXOxtKmbI3olwEq8npJuCCyT0/uWu6RLfEC4Z
 9TX+oZubEcPYQ1bEWmXOeQAlVmdNJHPQ4cdUJ4F8cIaBMDcv9mKCAJ7lndq0NPsPHpkb0JIkYFX
 SU8lZt7Ktz4IizRA1Uh0R1vXsPX21Qr1FWu18qKwZgFuX62DJeW3RnF+CycRfQZqUBdIoYWxs71
 QiS9/CQPfsA/qZncBd6/fCu0UbLJbL2SQUVYDpOTorfiKtaXWUavUx4x9yT3DMheFLwq8wlHveu
 mD9l1aiB2b0STY9cj67ZcY7KhzN0mTn9PO5moVjdD0ppaEPA0lNfBMond1L8HWzfF3yPW+LUOWh
 3xVTkwQRsFrYCr/oeQXhZydIrgtckrOTkEyf0639o1Up93ckXpPurdQZhgRy7kDDkPaZX86LbHd
 z13CFbqALNwSKaSlYuGu8MUl8cuQi71EBMk
X-Received: by 2002:a5d:5f56:0:b0:470:390c:1e73 with SMTP id
 ffacd0b85a97d-477b39839cbmr4078896f8f.18.1782946062264; 
 Wed, 01 Jul 2026 15:47:42 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2d44-b300-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2d44:b300:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm3178614f8f.7.2026.07.01.15.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:47:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/4] hw/arm/fsl-imx8mp: Add inital FlexCAN support
Date: Thu,  2 Jul 2026 00:46:08 +0200
Message-ID: <20260701224612.48342-1-shentey@gmail.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Now that FlexCAN emulation is on its way into master [1], let's add it to
imx8mp-evk as well. While the real i.MX8M Plus supports CAN FD which isn't
emulated yet, the non-FD mode works well under Linux: It is possible to use
`cangen` and `candump` either way on the host and on the guest, as described in
docs/system/devices/can.rst.

This series consists of four patches where the first three are preparations.
The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK board.

It would be nice if this series could make it into 11.1.

Based-on: cover.1782140438.git.matyas.bobek@gmail.com

[1]
https://lore.kernel.org/qemu-devel/20260629120032.1645265-35-peter.
maydell@linaro.org/

Bernhard Beschow (4):
  hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
  hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
  hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
  hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

 docs/system/arm/imx8m.rst   |  1 +
 include/hw/arm/fsl-imx8mp.h |  8 +++++
 include/hw/net/flexcan.h    |  4 ++-
 hw/arm/fsl-imx6.c           |  2 +-
 hw/arm/fsl-imx8mp.c         | 37 +++++++++++++++++++++
 hw/arm/imx8mp-evk.c         | 64 ++++++++++++++++++++++++++++++-------
 hw/misc/imx8mp_ccm.c        |  3 ++
 hw/net/can/flexcan.c        | 61 +++++++++++++++++++++++++++--------
 hw/arm/Kconfig              |  1 +
 9 files changed, 154 insertions(+), 27 deletions(-)

-- 
2.54.0


