Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D984EC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZTI-0006lF-Fh; Mon, 23 Feb 2026 12:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vuZGE-0000C8-W5; Mon, 23 Feb 2026 11:58:19 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vuZG9-0007pC-0f; Mon, 23 Feb 2026 11:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1771865885; bh=6K0B5ssH2A9O7uCMMCrE+M5VlwvJQXKIZXBBohOM+lc=;
 h=From:To:Cc:Subject:Date;
 b=Sphylae/oUTps7N7yJl70Tg06xgu64RmxpmyAac6SD9OY3EeCc3X+71fEfeY2H9/8
 wZ/vwd0Z4tCIGcQX3WPkKY7MKrBGhZlexPkfAEigCXtJijPFP+E1gJFVFqjoQGQRlV
 UyYpf3H4FmbiSci1ZqH7GGT92bXMTYo3HV5Xf3kk=
Received: from archlinux ([111.52.70.122])
 by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
 id DAD8BE84; Tue, 24 Feb 2026 00:54:45 +0800
X-QQ-mid: xmsmtpt1771865685t0fsg6l21
Message-ID: <tencent_B692F5D92658BB452DC23D13EC5E33FD980A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GcyN8v9e4WoZyYC2WIm001jbS/aKPWF9wsmNcgiNkYvaqrt94by
 1HAY6LNXu4/iD2ZsgCWhBan2CviXlb+tgC4AQr7+lX9553sVQxIszsUcfV2v+Uv1tdIDq33G8c6t
 wM13N/DUgEyiYxo9Zud5DmzCnnyaq2R/sbt9YiK75uaL9vXogmPfMTz2wpKUtZh53Ftf5dmtVGRq
 TkPfbcMj1RUpdecj5dXOxNS0ZMuETK9MAtgJUvEeYf+6OfQbJXJn4jHrXPxiaxWH4UpP5Vxg0hVt
 t91jrZTkYXnNZPjqplJftF0Yk3IWSpmnmmFRDPHPU0f+ME8WUMI2+yQA3MO9ODbdc6AM4VjM7j9H
 BFx+lq2HpNkcTolU1NtAbIqjT9XgIMNKGqIoinYR/0zeiHtO7ByW7JkJaWhYwHZNGIqQEOO63ULI
 LyhxlBT2jQQf4S2HWKij5UtqKJAqkl77Yrz3eUAYrj2b2X25Y4pwn8vx7pG//mNT4tSKAh2Hts0A
 4b9FeesV76Nyu2U6XjwwdtcoAlC5HTga1xZt4dkLDIqkavKBSDD8by0s9Xdo+jy7pbhbKkOSz2y5
 v6h2Pj4DUt9xfYkJOjjuaMbTeY3XrujQYzgKZx2gzl5Q1c6tyDq/XvsH3UHVtFIpZNZj/3qHOqH/
 KTdJ9VrVgWnm9k739MHolA2VdGd0Sr+ZV5FRdR90KjEgNAxtAHC60LjExwlCJdVoUX24W9XzzO4S
 +vDnTUUsT0G9QiPv+D9IVMEGmoAnv+DMqbfpuKN2YKPDZ4TsPqoDvD/cfr3I4qNKR3UlLt3JEEmx
 95bpYfTm86EXcPQqm3cx6Rni5FNMil6oA4yp6Y8ub5aVc2evJiNag1F1NMxRdmYHZRZgckGk6M9F
 HpB33DkGzjSPkjCzsGpjpa6W6PU6HyJVwJmRy3wajj+oSRf0Ab5l5ZoZAUz5lV1o8rZeFOqMriJP
 lhkCmsm8keqHKhQcuUEQud4xEXxmsOD0DdT/Mpr8XBx66y0YFKAmqlI71P117fMUnbnR9jg0z5LJ
 3fbOgGV0rje1DSh0AV
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org,
	jcd@tribudubois.net
Subject: [PATCH 0/1] hw/arm: Implement i.MX6UL LCDIF model
Date: Tue, 24 Feb 2026 00:54:44 +0800
X-OQ-MSGID: <20260223165445.318433-1-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.49; envelope-from=1486344514@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Feb 2026 12:11:32 -0500
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

This series replaces the i.MX6UL LCDIF unimplemented stub with a basic
device model and wires it into the SoC.

The LCDIF model implements register accesses, frame-done IRQ behavior,
and framebuffer-backed display updates for RGB565 and XRGB8888 input
formats.

The series also updates the i.MX6UL MAINTAINERS patterns for the newly
added LCDIF source/header files.

Testing:
- ninja -C build qemu-system-arm
- perl scripts/checkpatch.pl --strict --mailback origin/master..HEAD

Yucai Liu (1):
  hw/arm: Implement i.MX6UL LCDIF model

 MAINTAINERS                   |   2 +
 hw/arm/fsl-imx6ul.c           |   9 +-
 hw/arm/imx6ul_lcdif.c         | 409 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |   5 +-
 include/hw/arm/fsl-imx6ul.h   |   2 +-
 include/hw/arm/imx6ul_lcdif.h |  37 +++
 6 files changed, 460 insertions(+), 4 deletions(-)
 create mode 100644 hw/arm/imx6ul_lcdif.c
 create mode 100644 include/hw/arm/imx6ul_lcdif.h


base-commit: a6ec632dca8c7d10743aff29345e5e9e5324228b
-- 
2.53.0


