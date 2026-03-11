Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCB91125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MQ5-0003ox-H5; Wed, 11 Mar 2026 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPs-0003Wn-Lt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:14 -0400
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPp-0006QT-3y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1773246490; x=1804782490;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=T2sgr0VarxCFlxnt82rTuPeuMiKvOfETnoXuiBHutFM=;
 b=Y+8zRxiWfgu1+05aNhsSzMm6rjZjtjicdsXOx1VC5iwVbI0jG1oeVXnH
 Amk8ga+3GcTM+A0wGnVr9LSFYP5sLZClk6KAVEL6yx33ZYQa4uxa1ZZMS
 fF1TArkOW2cdzrNhC4sMv/5zNLISLf8thtPWBx1cJT+RG1JH7HS3jVHqX
 Iio3a7gLmROOfsO5oyB7ifAY1pxnJhfNilbev0j7BM7hu1GSz8bNdMONr
 8R34KZT1+ueL0Lwv0XwAzqWaRST2mDSCcZzgIYK+lHmjdi1WnDSxIUgHX
 O3Lm5dnfyVsnrI3pQppgqhN60pW7Gzw4Em+VRrBEAiBQwMl/YTdBXpXGW Q==;
X-CSE-ConnectionGUID: zNyHJNvqRhuZXelIGYeUpA==
X-CSE-MsgGUID: Z7LqjRyCRASViUzRxf/50g==
X-IPAS-Result: =?us-ascii?q?A2D2DQD+lrFp/5oagoZagQmFGIFqCBUBAYQ4kXSaGIYED?=
 =?us-ascii?q?wEBAQEBAQEBAQgBSgcEAQGCE4IuRo0kKDgTAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBgEBAQEBAQYFgSGGCUYNhwQPAUY1AiYCSBYOBYMCAYJzFAawaIEyg?=
 =?us-ascii?q?QGEfNoHgSUGCQELgQouiFQBgXCEBIdJgUqBR3Z2gmECAoIrgw6CaQSBDn+BI?=
 =?us-ascii?q?4wQgSyFZwk/gQJ4LAFVEw0KCwcFYYEFAzUSKhVuMh2BIz4XM1gbBwWFHg+Ic?=
 =?us-ascii?q?IE7BCOBEYMpAwsYDUgRLDcUG0EBbgeNdT2CMwEBYiwrIi6BCiMLl1CvVgeCO?=
 =?us-ascii?q?IFnjB6VVAEyl2CTC5kGigqDf5ZQhD0CBAIEBQIYgX+BaQ4HcYM2EkAXAg+OK?=
 =?us-ascii?q?hkcg0KFE8MsdwIBOQIHAQoBAQMJgjmED4wCAYEcAQE?=
IronPort-Data: A9a23:ZWUL0Kkollk6OipxhwBr0bbo5gynJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcC27QaPrcMWShLd8ia9izoB5QvcXTnNJnGwptpCwxFVtH+JHPbTi7wuYcHAvPdJGZHBI/h
 yk6QoOdRCzhZiaE/n9BCpC48z8kk/rOHuagYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQvWo4ow/jb8k03562r4GpwUmEWPJingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahw7id/
 O5wWamYEm/FCIWRwrhHA0kAe81JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwp6KTkmy
 BAWFNwCRgKllsKU5qyicOlxtPQuKOjEDY4iolg1mFk1Dd5+KXzCa7/V+d9VzHIr3IVHW+zBe
 8pcYDYpYBmojx9nYwxLTstlxKHy2D+mLmEwRFG9/MLb50DWxRZt0b6rM8DSd9qLQ8p9k0Geq
 3jNuX7mHhFfPdWUyTeDtH6h7gPKtXmnANJOS+PknhJsqG/M4nURMgw9b3KAn/iEmHSuVZUCc
 0NBr0LCqoB3riRHVOLVVhm1sDiOsxgaVtd4F+w84RuKjK3O7G6xHmgFSjtNQNgnssYsQnotz
 FDht8vkGTF19ricWH6Q8rO8qTK0MDISa2gYakcsVAYA/pzvrZ8+ijrJSdBsFrPzicf6cQwc2
 BiQszQ+iqVWlpRO3uOh4kzHxjug4JTEJuIo2jjqsquexlsRTOaYi0aAsDA3Md4owF6lc2S8
IronPort-HdrOrdr: A9a23:+alcL6G6Gy3rl2hWpLqE6seALOsnbusQ8zAXPiFKOHtom6mj/P
 xG88536faZslwssQgb6LO90fC7MBHhHP1OkO0s1MmZMzUO0VHARL2Ki7GN/9TOIUzDH4VmuZ
 uIHZIfNDUaYGIK6PrH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3AdPEBwWrcUSVQUlpnYPTexrzmUdIDY13/6mnJGU+?=
 =?us-ascii?q?lO1ZkTJy6eFKt4Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:aYKV/gYevYCryOBThWDInTNYJexSyp+QCX0fq4UI/JTcOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; d="scan'208";a="24084764"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 11 Mar 2026 17:28:03 +0100
Received: from mkroening-air.local (137.226.124.87) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 11 Mar
 2026 17:28:02 +0100
Subject: [PATCH v3 0/3] semihosting/uaccess: Swap bytes based on
 runtime-configurable endianness
Date: Wed, 11 Mar 2026 17:27:13 +0100
Message-ID: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNsQ6CMBDG8VcxnS2hB5To5HsYB2gPeoMtaWvRE
 N7dwuJEHP9fcr9bWEBPGNj1tDCPiQI5m6M6n5gynR2Rk87NoARZilLygE8yLkSyI1fTi8cwdxP
 v61Zjj9DWCCzfTh4Heu/u/ZHbUIjOf/Y3SWzrPzEJXnJZy6aVCpqhkTd0Fr0q/BwN7zpl0BYa2
 aYn+IkA7ZEIWVS9VnqoLlqL5khc1/ULqGDrShgBAAA=
X-Change-ID: 20260106-semihosting-cpu-tswap-b47debe274e2
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [137.226.124.87]
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:49;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-4.itc.rwth-aachen.de
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
Changes in v3:
- Remove target_needs_bswap() check from cpu_internal_tswap()
  Now, only cpu_internal_needs_bswap() is checked.
  This fixes the behavior on a big-endian host where the CPU currently
  is in little-endian mode.
  Thanks for pointing this out, Peter!
- Link to v2: https://lore.kernel.org/qemu-devel/20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de

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
base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
change-id: 20260106-semihosting-cpu-tswap-b47debe274e2

Best regards,
-- 
Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>


