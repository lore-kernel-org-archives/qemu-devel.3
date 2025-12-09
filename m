Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D473D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlAt-00079o-5p; Mon, 08 Dec 2025 19:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36WY3aQYKCuQeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com>)
 id 1vSlAr-00079O-5t
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:49 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36WY3aQYKCuQeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com>)
 id 1vSlAp-0007Rd-FP
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:01:48 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b99d6bd6cc9so10324505a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 16:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765238505; x=1765843305; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qKWZSsFPlt3/m4vph5eKz2W5qe9VhtT1w47FAZxOtFM=;
 b=2+8Zyi1qb5YWTxbPwSAVjp0PqKg+o/IU+HpPyI9CqCp1fASy45hu5c0IMM8kZWgsqT
 Hu2uGduGPBzSiWJKfbF/v9wP2tbvbJBU7L7jqL9XzrlhdZZf7pMb49voXnMdgK4UxOS2
 xKyOpsTs/vp3t28ccyveYtuJoMnpWCM5UtiA2DeEEk4CynuIzWqOn1siB7jIzS1C5sKm
 u+VYfGAu5sFAa7utAOU7Hy7w45lWFj+NqQHeiJDkVpytGzfEGhy/dAW0zRfeeEEnrj83
 q8YaarvNNxK8u58FAsr7m/KL3eciRrxFCoqoEJPQPTlEjnUQGcfA6EedN80pmWePbI6I
 WWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765238505; x=1765843305;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKWZSsFPlt3/m4vph5eKz2W5qe9VhtT1w47FAZxOtFM=;
 b=Fa+5OJd2begGHPdC/mBTWTCLrNTavlcuzMzoXmsjhIEMxkLqozdn8PQGMercfN5mFa
 KVkbLbM37kx666klehwylQoEpRAvwDRHxZsA7Q9DYrvXIUpnQf6foWjirpB1s8Fal3u7
 36XBgK0Vm+TezyO6sy+3mUGBF3GaQv2I9rRZp2++Tr2u4tNd0eYd4aOHbM2KTacjgpUi
 5qhBgqZ9rxm3eE2ykTvbOEdVmVK+UNtGqYAFyL/YCvvdKHxJ6y9PbaW1AfiwrIxPmhA9
 WSt47cIk7oBVQuUvct6kk8u1oa19Cd7pjNYbCgAdUi7bNKSSySzyknWmrBPvLWa4ylt/
 e39A==
X-Gm-Message-State: AOJu0YxlMmeY7sXSqHkMSlt8qPqq45KajgE4I3wy23Xf3bFlMDilIGwv
 s7gyQZOUy1Ezev63U8rwt0vjTJ/8l9AS2GCzLh4m7lByc/4sAUy7KhRCg8JcDgQHuBfltzKdqKW
 4tNm5Gdv1HGVqWhF20lJyEJ3jFTFgzSMjYJGV+jsi6xCkWhbRBIu3PyeN8EqzqrnYlro6NKcBRQ
 MhSPjvJjeF8sxEUjZU+5S2UMtNBJslHJUj6OU=
X-Google-Smtp-Source: AGHT+IGpkxfvMz65SRPUSd4SnHoyM/eUXQXveI+c1Bvf2J3jMDMZzk4iibtM2Ne4EAhcbKQ0WBX20cPauKA=
X-Received: from dyec21.prod.google.com ([2002:a05:7300:2215:b0:2ab:9468:d9cf])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2414:b0:2a4:3f9c:9af8
 with SMTP id 5a478bee46e88-2abc7153739mr5639729eec.9.1765238505238; Mon, 08
 Dec 2025 16:01:45 -0800 (PST)
Date: Tue, 09 Dec 2025 00:01:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANxmN2kC/1XMQQrCMBCF4auUWRvJRBupK+8hXcRkmg5oExIJS
 sndjQUXLv8H71shU2LKcO5WSFQ4c1haqF0HdjaLJ8GuNSipekTZC5MjkRPZRw4C3XFwpC0ZraF
 dYqKJXxt3HVvPnJ8hvTe94Hf9QfofKiikuEml5XA4oZ7MxYfg77S34QFjrfUDv40b36kAAAA=
X-Change-Id: 20251105-aspeed-sgpio-1d49de6cea66
X-Mailer: b4 0.14.2
Message-ID: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
Subject: [PATCH v2 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO (SGPIO)
 controller model
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=36WY3aQYKCuQeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This series introduces a model for the Aspeed Serial GPIO (SGPIO) controller,
commonly found on Aspeed SoCs such as the AST2700. The SGPIO peripheral
provides a large number of GPIO pins that can be controlled and monitored
serially.

Improvement to QEMU:
These patches enhance QEMU's hardware emulation capabilities for platforms
using Aspeed SoCs, particularly for BMC simulations. By modeling the SGPIO
controller, QEMU can more accurately represent the hardware, allowing for
better development and testing of firmware and software that relies on these
GPIOs for various functions like sensor monitoring, presence detect, and
system control signals.

Impact (Before/After):

Before:
QEMU lacked a model for the Aspeed SGPIO controller. Any guest software
attempting to interact with the SGPIO register space would find no device.
Firmware features depending on SGPIO pin states or interrupts could not be
tested in QEMU.

After:
QEMU emulates the Aspeed SGPIO controller on supported machines (e.g.,
ast2700-evb).
- Guest firmware can configure SGPIO pins, set output values, and read input
  values through the memory-mapped registers.
- External entities (like test scripts or other QEMU components) can interact
  with the pins via QOM properties (e.g., to simulate external signal changes).
  Path example: /machine/soc/sgpio[0]/sgpio0
- The model generates interrupts based on input pin transitions, according to
  the configured mode (level/edge), enabling testing of interrupt handlers.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
Changes in v2:
Split the v1 into smaller commits and reorder it for better review:
- Link to v1: https://lore.kernel.org/qemu-devel/20251106-aspeed-sgpio-v1-0-b026093716fa@google.com

---
Yubin Zou (6):
      hw/gpio/aspeed_sgpio: Add basic device model for Aspeed SGPIO
      hw/gpio/aspeed_sgpio: aspeed: Add QOM property accessors for SGPIO pins
      hw/gpio/aspeed_sgpio: Implement SGPIO interrupt handling
      hw/arm/aspeed_soc: Update Aspeed SoC to support two SGPIO controllers
      hw/arm/aspeed_ast27x0: Wire SGPIO controller to AST2700 SoC
      test/qtest: Add Unit test for Aspeed SGPIO

 hw/arm/aspeed_ast10x0.c          |   6 +-
 hw/arm/aspeed_ast27x0.c          |  26 +++
 hw/gpio/aspeed_sgpio.c           | 348 +++++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build              |   1 +
 include/hw/arm/aspeed_soc.h      |   8 +-
 include/hw/gpio/aspeed_sgpio.h   |  68 ++++++++
 tests/qtest/ast2700-sgpio-test.c | 152 +++++++++++++++++
 tests/qtest/meson.build          |   1 +
 8 files changed, 605 insertions(+), 5 deletions(-)
---
base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
change-id: 20251105-aspeed-sgpio-1d49de6cea66

Best regards,
-- 
Yubin Zou <yubinz@google.com>


