Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C82E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVA5c-0005zn-6v; Tue, 07 Jan 2025 08:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5a-0005za-AP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5Y-0007MX-Kj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283dedso154590135e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736258262; x=1736863062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eYDkVruTPbeywuSuzwkP1y/8rZYhZBrKATsH8FXrn2Y=;
 b=Gal7tPPhhaOUi+as0JXGkZc1/RwfnBpgraRIUHFCfvfZFcTnzCRwZX1QwPb2ZtyF9b
 QcCG1ydqq91l3ZDWxlteGNgGPPvxtA6tpBfxoV94abFaD9SWxaeV0y4TWstEBhSQ44QF
 CSxilQ49uYSuuLUxeZuhQ/cUX6ORDPlII15siDIIq01okbf1flec4Lgr1lS2e3iN00BU
 JJNTomgE9ieShPlvvEckwxLyE8B3mDWmxv/UMMzBmi1U8OAw7a6z1IXn/TrreSax8LUB
 VFVbIW2cyMdWeLwhSOPhTJMQmnNXiJ2kkBOj02+7ue48TQ2ZhUuJNW6snrJhKfDdHUFN
 5TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736258262; x=1736863062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYDkVruTPbeywuSuzwkP1y/8rZYhZBrKATsH8FXrn2Y=;
 b=iqMph6BRjTzD7mctkuTCgf6woYTsDca/i8guhm72CQWRD37AyGqZhOAhFWyu5PqFJB
 PUy7XxDBS+56v91R3W9Nl9O2v08uoYhtX7OBjizsD/taSh+m0lChlTESqbGncrVIsnFM
 gYRouwKavWmw6jV4bpWRJJbzV4E668CdXs4zlUsAwTGgjjLMAmoUFsi1UrErb0XUnP/b
 caL1aatbiT7/M/9l7MTydYsISCYIEsJWWCGmLPtCi04TdrqWGK6Yp8rUWkGd3Tm36Q3x
 1H9cl+k9RDMntO+b7FVzzvYpYNzduVTUh3PNa6vXqlESzw/BAlcBhLXMPEiGwhImz8ZB
 n47A==
X-Gm-Message-State: AOJu0YzXFO6VHrzWlige3Uar+nwzp2amxmn0gHmqKjTqhWS/R5jDP2zN
 g6VrhbzEquSTBdXOQs/cG/lRgfYMQ1r4a6+NwA/6c4Pvuxi3Crxg/kkiEiuS5rMFqZ0UciuTGCF
 mk8s=
X-Gm-Gg: ASbGncsrK7wm59V1K7L71mBxuiOp4j6TfY9QMKkGAiUv+uHK1SnCycFFwHqGmkb1PHP
 itSumpPtilYLvg/QVYcI3t4PgFiux3crI8WCS30yLGQtoOvH610cKpJnQuhaT0jaBVH8Io2AfNN
 7GqlvHdKJa7DeEge6Qey7RZfYI3xcowhXUx0I58H2JsnHcJx+0LJvunDvDoZZ13XRGPatI3DK9E
 zdxAq/BtKRaaVhjxXcArTy1UAGT/hdgonyNNnQkJnKNZcuV0hnu5922e5crIXj2iODjEzoC2/9q
 pYfs9djoIr1ZG11Yizwr8xbGg5TX3Pc=
X-Google-Smtp-Source: AGHT+IFiFAjLVd33nqRGE/SSrg86VRHt2fYvHn/Ja2QYFPwO9ackCRcAYmsgNBX3dJaz1TLFxuq7DA==
X-Received: by 2002:a05:600c:4f03:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-43668645cf5mr580286485e9.15.1736258261724; 
 Tue, 07 Jan 2025 05:57:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472casm51290740f8f.45.2025.01.07.05.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jan 2025 05:57:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/2] target/arm/arm-powerctl: Restrict to ARM cores
Date: Tue,  7 Jan 2025 14:57:37 +0100
Message-ID: <20250107135739.48324-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since v1:
- Factor cpu_is_of_type() out

Philippe Mathieu-Daudé (2):
  cpus: Introduce cpu_is_of_type() helper
  target/arm/arm-powerctl: Restrict to ARM cores

 include/hw/core/cpu.h     | 9 +++++++++
 cpu-common.c              | 5 +++++
 target/arm/arm-powerctl.c | 6 ++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.47.1


