Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B28C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluL7-00063f-TN; Mon, 20 Jul 2026 16:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL6-00062o-7g
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL4-00065U-Pk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso14469285e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784578305; x=1785183105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LgRFB/oAk9Vb6Dp39nHDMiixlW8E2fZ95ocnpRXZ3u4=;
 b=kn3WcqxXS6zJs5okS5kscifH/YXlHbbmdsmmwunE7ENYNpMErmeSkKxdvZG1aVBW9W
 SGslBm6RDochniwbud9kWtxjUXwuakVo9tOF4a7vr52t2ibAjFQE2AjxKlTZhHmpds1X
 VWObhhgmXg9Cmr3MMzo0TxCfssq7VehQ2HRTNM/h2wrVswRtQOnogK+DNSVx8Ul9Syjr
 JpXSQrmTCflI09CmK635aQKYg1tqaJl5ioyuC6Oxb+Gf/5/E3SJkN96yvH6xxaQEv3R5
 LmK5iW43FA2Q6e2QebVWUW7f4+X2Em1fjnT10bltEPIVDrm2eBqCgqTrMJ4hUiHJPq4H
 3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578305; x=1785183105;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LgRFB/oAk9Vb6Dp39nHDMiixlW8E2fZ95ocnpRXZ3u4=;
 b=D2WQny7DES2QnJsC9uRk7ISSGmpO/pFydAuA1Q40uBAvEFNPmEONZ+T8vJSVoa3QWH
 3ksS0mvW988RXXCU6LvTSYoesx+ig9tlPiUtMJVvAfY4bxdxsauy1nwaeU/YkxUa0CNA
 s2oVzdUKEUL2SOzqKZ221O08WxhXtno2TmiGX+drae2sqS2VOLYgggbnYX8PfOA1aBWm
 Rfsucw/5zcws4vPuioxGe+b3s4xCC515o9EFhJheza0myjqc2tOY2d/BMhR4ml5x9nX5
 RlZFlJkcd60Jade8qOBQLFV9ZxtlKltBA26YzJZbYGHVsCDegRKR2TyxYcjhhx9k7ZzO
 M3mA==
X-Gm-Message-State: AOJu0Yzv2CC2YykbFVTJSd8WXPC2AH3Zg1MTMoTkslTsVzHBKDAQ+b89
 BmuW7oUKEuAxplB9bW3lfwsKdKJJXw9acyZAfPCXYEeI6CwvOK5rVJ0sAJ36Nw==
X-Gm-Gg: AfdE7clImefVnjehLyNS2tGLnH7az62whPgxjiPF7YV6IH34NKQt6AsspaOI49NDMwh
 Eu0e2U7sc2h4RV1GuFax5WjmlHrGr8wYBZIBmDVcp712rFQBipp0JdvYs0LcxN2LxjXLNMyG+/n
 A+ItwYQIHYFjpqGoVahjU8XacZ77lHOaa13ky738J/uw+wGwIZWTGGF/mMnvR2E2PVaQJwqOFmq
 NCqoO/GeptY2qdNl57auNsf99Cg2+6Y1N79eI728QsBffrNl5+dffgVVPRKM1EqiUQ8l8qkUsQ9
 /5lVeQSSQFjOLhXSdF3RpdNdkfgrmPeaGOq8W2yqUsUWPy9yMc4sBPbLHSy1C/ZgYCWk0eDoMjH
 fCn5PvQwnTs7kv0SY5wyby9NA6Ud2yScLZnoybhdnhGQ85jDWzR+ZIOKpuPxXhrhNi7KNO3/RfH
 XyHRBqA9EJNqn6Z11URYEytMtbbIKr0xinu6E10x4SBMOAR6PNA2o3ohrm79K1cdN0zDhaP+zVZ
 EVGFlbYMzM5GCtvMT/o4SlRHFjktIWdU9SA
X-Received: by 2002:a05:600c:310e:b0:495:52dc:73a1 with SMTP id
 5b1f17b1804b1-49552dc776bmr118571975e9.29.1784578304840; 
 Mon, 20 Jul 2026 13:11:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-225b-5200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:225b:5200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm15934935e9.10.2026.07.20.13.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:11:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/2] SD & SDHCI fixes for-11.1
Date: Mon, 20 Jul 2026 22:11:31 +0200
Message-ID: <20260720201133.24796-1-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series fixes two issues in the SD subsystem. The first one could send QEMU
into an endless loop or crash it (depending on whether assert() does something).
The second patch fixes possible file system corruption in e500 and imx25-pdk
machines, i.e. the ones using eSDHC rather than uSDHC, though I could only
verify that with imx53 emulation on my imx53 branch [1].

v2:
* Add missing R-b tag in first commit (Bin)
* Fix typo in commit message of second commit (Bin)
* Fix topic (fixes are intended for 11.1)

[1] https://github.com/shentok/qemu/tree/imx53

Supersedes: 20260719211923.1079282-1-shentey@gmail.com

Bernhard Beschow (2):
  hw/sd/sd: Fix error case for CMD18
  hw/sd/sdhci: Extract uSDHC-specific quirk

 hw/sd/sd.c    |  3 ++-
 hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.55.0


