Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D768FEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxNo-0001ha-H8; Fri, 27 Feb 2026 07:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNm-0001hJ-Da
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:50 -0500
Received: from mail-out-3.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNi-0002pc-KM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1772196947; x=1803732947;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=yZr4BeywM7F9IhJLv75Ry3iSOnc72LDHUlCtcspfmiw=;
 b=P39IoihAHRQh4dyrDrELv8PHBRn1+x4XerzDoClHo6xTFOuspJ/Z5vBq
 kgYTCU8H8kFrioqHkbI/E+XglPqSTxSUcahXWDgRiqti7ENYaH/cBgT8i
 RiCnZr6IxBy2jW+I/018CxZwVP3A3xmwQ2QO0QDwjNHcHItVRFxjk+EFN
 7sbZevaksBiur6E7PNRIhpgmTjO/vZrjhqGAmDYqum0WCGbsM/1VKXoI/
 RcY+USoWyxOwHo71HfnzVjPON4YFpZ6lEycEbiu+IVRmzg8xlJ+1WlFGy
 lYS5DozQ9GWbInB6bqzw/hhblEtlommjVQiE0R1F+qAmNxDEUrkehEP5W g==;
X-CSE-ConnectionGUID: TnutT7rsTmuVt8OZh7kBzQ==
X-CSE-MsgGUID: 8P2zr2IGSXCXh3euzXCOhg==
X-IPAS-Result: =?us-ascii?q?A2DEBgA9k6Fp/5oagoZagQmBUINIgWoIFQEBhDiRdJoYh?=
 =?us-ascii?q?AWBfw8BAQEBAQEBAQEIAUoHBAEBghOCLkaNISg0CQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEGAQEBAQEBBgWBIYYJRg2HBA8BRjUCJgJIFg4FgwIBgnMUB?=
 =?us-ascii?q?qdpgTKBAYR82geBJQYJAQuBCi6IVAGBcIQEh0mBSoFHdnaCYQICgiuDDoJpB?=
 =?us-ascii?q?IEOf4EjjEpihWoJP4ECeCwBVRMNCgsHBWGBBQM1EioVbjIdgSM+FzNYGwcFh?=
 =?us-ascii?q?XwPiHSBPQQjgROCHAMLGA1IESw3FBtBAW4HjW4/gjMBYywrIi6BCi6XUK9WB?=
 =?us-ascii?q?4I4gWeMHpVUATKXYJMLmQaKCoN/llCEPQIEAgQFAhiBaIIADgdxgzYSQBcCD?=
 =?us-ascii?q?44qGRyDQoUTwGJ3AgE5AgcBCgEBAwmCOYQPjAIBgRwBAQ?=
IronPort-Data: A9a23:dsJ/2KnLelumsx294JPcdKHo5gygJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbXWrQbPaLMWKncoogO4q19UNV7MCAnNNjQQtqpH1hQltH+JHPbTi7wuYcHAvPdJGZHBI/h
 yk6QoOdRCzhZiaE/n9BCpC48z8kk/rOHuagYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQtWo4ow/jb8k035q6t4GpwUmEWPJingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahw7id/
 O5wWamYEm/FCIWRwrhHA0kAe81JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwp6KTkmy
 BAWFNwCRiyFmv6Kn6igduxxuNhzC/vrY4A1qEg1mFk1Dd5+KXzCa7/V+d9VzHIr3IVHW+zBe
 8pcYDYpYBmojx9nYwxLTstlxKHy2D+mLmEwRFG9/MLb50DWxRZt0b6rM8DSd9qLQ8p9k0Geq
 3jNuX7mHhFfPdWUyTeDtH6h7gPKtXiiBdtISuHhq5aGhnXD/jYBEkc3emCLism50UOjSeJ0D
 Ewbr39GQa8asRbDosPGdwW4oXqBsjYYWtxZCep87xuCooLM7hqUHC4BRy9NZdginMs3QzUw0
 RmOhdyBLSVitaDQRX+D+7O8qzS0Ni4Ia2gYakcsRA8I85/prYc1gx/nStdlGbSyyNrvFlnNL
 yuitjcih7gDyNVRkqz950/bg3elqt7FQ2bZ+znqY45s1SshDKbNWmBiwQOzASpoRGpBcmS8g
 Q==
IronPort-HdrOrdr: A9a23:Awnb3aE+2gy+5yJapLqEy8eALOsnbusQ8zAXPiFKOH9om6mj/f
 xG88526faKskdoZJhNo7690dC7MArhHMdOkO8s1NSZPDUO2lHEEGgK1+KLqAEIcBeQygcy78
 ZdmxYSMqyUMbDH4PyKhzVRrLsbsb262bHtnumb1nF2UAVjbOV8/x50YzzrcHFLeA==
X-Talos-CUID: 9a23:+Ovjz2zei9ASJlVUe6RwBgUoHN05TiLH10vVPnGkWUFbSOKWY02prfY=
X-Talos-MUID: 9a23:W0/LvAQIrpmrrHWtRXS8vGtwLp1JzJ+eI3ANypgbqfmvEix/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,314,1763420400"; d="scan'208";a="315126415"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-3.itc.rwth-aachen.de with ESMTP; 27 Feb 2026 13:55:40 +0100
Received: from mkroening-air.local (134.99.235.10) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 13:55:39 +0100
Subject: [PATCH v2 0/3] semihosting/uaccess: Swap bytes based on
 runtime-configurable endianness
Date: Fri, 27 Feb 2026 13:54:29 +0100
Message-ID: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr2Jm7ZDSQElceQ/DopSBzsKWdCpoC
 He3cgGX7yX//R2EEpPA7bJDopWFYyigrxdw3oaZkMfCoJU2qlYGhZ7so2QOM7rlhVk2u+DQdCM
 NpLuGNJTtkmji99l99IU9S47pc96s9c/+K641KjSNaTvjdDu15k4xUHJV2rJHa52nUI0E/XEcX
 26j7NzGAAAA
X-Change-ID: 20260106-semihosting-cpu-tswap-b47debe274e2
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [134.99.235.10]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:48;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-3.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The semihosting ABI [1] states:
> Multi-byte values in memory must be formatted as pure little-endian or pure
> big-endian to match the endianness mapping configuration of the processor.

This series ensures that semihosting data is properly byte-swapped if
the guest's CPU is currently in a different runtime-configurable
endianness than the host's CPU. This is done by adding cpu_internal_tswap()
functions and then using them in semihosting/uaccess.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
Buglink: https://github.com/taiki-e/semihosting/issues/18

[1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
Changes in v2:
- Rebase and resolve conflicts.
- Rename virtio_is_big_endian to internal_is_big_endian (fist commit).
- Rename new functios from cpu_tswap to cpu_internal_tswap.
- Document exceptions for using these internal functions (virtio and
  semihosting).
- Link to v1: https://lore.kernel.org/qemu-devel/20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de

---
Martin Kröning (3):
      include/hw/core: Rename virtio_is_big_endian to internal_is_big_endian
      include/exec: Provide the cpu_internal_tswap() functions
      semihosting/uaccess: Use the cpu_internal_tswap() functions

 hw/core/cpu-system.c             |  6 +++---
 hw/virtio/virtio.c               |  2 +-
 include/exec/tswap.h             | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h            |  4 ++--
 include/hw/core/sysemu-cpu-ops.h |  6 +++---
 include/semihosting/uaccess.h    |  8 ++++----
 target/arm/cpu.c                 |  4 ++--
 target/ppc/cpu_init.c            |  2 +-
 8 files changed, 52 insertions(+), 16 deletions(-)
---
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20260106-semihosting-cpu-tswap-b47debe274e2

Best regards,
-- 
Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>


