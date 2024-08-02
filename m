Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F916C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 17:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvnV-0003ml-HF; Fri, 02 Aug 2024 13:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvnT-0003lZ-9M
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvnR-0001A8-OK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428243f928fso47916905e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722618626; x=1723223426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtgEyTtmdyRcjdjt2y1oGZo8eOWPb0TaH0rssRrECwI=;
 b=CCTP8E/m9D4D9GiKvCVhf6vbWcFpRMyrypwMx4gncuBREl1TEYqXSg96AM6JFogC6P
 JWjmtIiGNvLnJdS6GT3OeORIiKgSa1f5JuTnovSltzhHivINJLqyfxre/SyQsoVJfiVR
 nHWg3Bn421W8C2iwMokvzxg1+I/vbSLLRqiHBAL6YH7YBSMfFfpNxF83MEX8Z2/Dblqq
 bpRWzd2jS9NzPikUdhee/976/avVaMBIflokGP84Ww2y/P/YQ70KShaPGQLTaoBa+gIR
 CE5EQF6OvTN8YhUNlq52P1BFgXNU9q9PJSeXz11n4cMmnJ+lHhsJt5k8QUC4xIfZGTsA
 fJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722618626; x=1723223426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtgEyTtmdyRcjdjt2y1oGZo8eOWPb0TaH0rssRrECwI=;
 b=K42He4RG9/28YFuFjuyQ3SbtjHKAmVnxfsjZIakPOhPvC1cVubDquXmR6adeTS7GJ3
 4k0E4cgue+sDhBUDmHbmDAnT+kmA05J0cpYcayb83gQucX5VC5wF1nGGMyM3jkztprPO
 A8WK6Vvc1KOPZA6U7TfhAXBvgn/W4Gs7mVU9pA8VjJxa0VbfRS7ZHxx0urVt4h/Rdlua
 gU3YL9MvAXVcVS6QZXNpweVzRLUIAcGc6tvnp+QqxMlTO3pgxLIX0iiCVAwLns6DUxP4
 ysabxVgA1OpH2Tp6jXDKDAL8n7EZllZS3J89FT+ia/YvI+fThWMEVbuhE7g7Eh/+AIzt
 ZWeQ==
X-Gm-Message-State: AOJu0YwojfC5Eb+NS8sHXuz+7YxQCL9uu9SyhBFNO/D5Jn+nQxhz117W
 4ewyHh38Pla2KsO8zV1LKAhNTuBVsD1ysPBfiTVARXFBFc6bx3hx4ItX/Q4mS3dGjm540T7Sv+T
 T
X-Google-Smtp-Source: AGHT+IF6XKyFQaFEPrLXoVB5dd2TV1SpBPCmrdLTbJZPJ5/NHNFuGGxNlH18eVjYF2ItTuS4uT7yCg==
X-Received: by 2002:adf:f90d:0:b0:369:b842:5065 with SMTP id
 ffacd0b85a97d-36bbc1a5f54mr3083283f8f.41.1722618626316; 
 Fri, 02 Aug 2024 10:10:26 -0700 (PDT)
Received: from m1x-phil.lan (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8879sm119653866b.211.2024.08.02.10.10.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Aug 2024 10:10:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v4 0/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Fri,  2 Aug 2024 19:10:21 +0200
Message-ID: <20240802171023.85719-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v4:
- invert patches order
- set wmask in DeviceRealize
- update patch descriptions (migration, Resettable API)

Philippe Mathieu-Daudé (2):
  hw/pci-host/gt64120: Set PCI base address register write mask
  hw/pci-host/gt64120: Reset config registers during RESET phase

 hw/pci-host/gt64120.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.45.2


