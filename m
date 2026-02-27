Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A2FEFB4D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxNm-0001hQ-Ru; Fri, 27 Feb 2026 07:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNk-0001h3-SN
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:48 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNi-0002ph-Kf
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1772196946; x=1803732946;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=+hdBdQ9KP+CSDhfvnG6x9Oq0okhl4XAY7gkl0I+lySk=;
 b=hauntMqv0FDPoyeanQU5LzAfGd7YM7AKYK6x8s8tBDD3j4IulAZg7PkP
 T05CeyKDVkQkgXeMT7TS36tT4dgPnImWNRdUZpdESPI1lOgTYiFr1iSmL
 x6PjD1E6C/pb4zU+cIAFDZk0MfSbFI2VYGNJ0bjETueHoleMYGJNCdqhN
 HsaUj1whMrWxLeZ4286Dw/3dnCMCw4rFtRzRQf3mla1eV2OG1iFjOR3T2
 9bDkN0jaMFgM0WMH3Zc2eW4fQ/urqwKrSlc5bZM+LN4kVv8TRGHYVudc4
 fU7pEHnwzHVxlWTViwSvlQ4kUy2UW/j0wThA3+xIDZ6a9FbGe6KQhqMIu g==;
X-CSE-ConnectionGUID: aN9Sz87SSBq4FkrrVt3XUA==
X-CSE-MsgGUID: NMSYkY+YSayFcvBPGwNDaA==
X-IPAS-Result: =?us-ascii?q?A2B6BgA9k6Fp/5oagoZagQmBUIJXcYFqCBUBAYQ4qjOBW?=
 =?us-ascii?q?YYEDwEBAQEBAQEBAQgBSgcEAQGCE4IuRgKNHyg3Bg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEGAQEBAQEBBgWBIYYJRg2GWwYjDwFGECUCJgICRhAGDgWDA?=
 =?us-ascii?q?gGCcxQGp2mBMoEBhHzaB4EfAQUGCQEKAYEKLohUAYFwhASEeoJPgUqBR3Z2g?=
 =?us-ascii?q?mECAoIrgw6CaQSCInoUjEqGTAk/gQJ4LAFVEw0KCwcFYYEFAzUSKhVuMh2BI?=
 =?us-ascii?q?z4XM1gbBwWFfA+IdIE9BCOBE4IcAwsYDUgRLDcUG0EBbgeNbj+CNHsTLCKZN?=
 =?us-ascii?q?q9WB4I4gWeMHpVUATKXYJMLLodlkHOKCoN/llCEPQIEAgQFAhiBfoFqDgdxg?=
 =?us-ascii?q?zZSFwIPkiHFdXcCOgIHAQoBAQMJgjmQEQGBHAEB?=
IronPort-Data: A9a23:fkF0R69pQbIqWN/KmVJxDrUDpn+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 2MWD2zUbKyDZ2ahedx1aYq+pEkAsMWGx4M3TgtvqX9EQiMRo6IpJzg4wmTYYnnOdJ2TFCqLy
 +1EN7Es+ehtFie0Si+Fa+an9T8nk/nUGtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn/glaYDkpOs/jd8Ek146yr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2nhc+RK9
 Tl4ncfYpTEBY/eQwrRNC3G0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0984vaVyi+
 8D0JxgESEG4lbLp+4mRU7VChd45EtWwDL427yQIITHxVZ7KQLjZXLnK6M8dx211j4ZUAureI
 sMVLzZiBPjCS0QUZhFOU8p4xrnu3ySjG9FbgAv9Sa4f5mHJ0A13lrv3N9fTe9qFbchSmEuCr
 STc4Hj5RxgTP9ySz3yJ/xpAg8eVx3yiBd9ISNVU8NZMpWaixV1QOSYfRHWwv9OBpVGYd9t2f
 hl8Fi0G6PJaGFaQZsH9Xhm9rFaAvxgVQd0WFPc1gCmVx7bZ+UCcD3kIQzpFQNgnssYsQnotz
 FDht8rkACEqvLCLRHa18LCSojWvfy8PIgcqbCsJXU0P7t/lrYwbihPJR8xkVqmvgbXI9SrY2
 S+WrCUuwq5JyMdNzbqn/RXOj3Sgq/AlUzII2+keZUr9hisRWWJvT9bABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:BlpFU6B1viDMl+LlHemN55DYdb4zR+YMi2TDtnoBKiC9F/by/f
 xG88536faKskd0ZJhNo7y90cq7IU80l6Qa3WB5B97LYOCMggqVxe9ZgrfK8nnBIXaissRa0r
 htaLJ3Fd33Cnh25PyKgjWQIpIbm4TCzYbtv93571pWJDsaDp2I5j0JbTqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3AhWvBFGnSQV1AC6mq/BZxv4OoYN/XOXT7nUzCcxC?=
 =?us-ascii?q?DMkxwFJOWU0Wu5PhUruM7zg=3D=3D?=
X-Talos-MUID: 9a23:phUrIgY+awPzCeBTkRrXtTJTd/ZT6rWAA14nqboZneWNHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,314,1763420400"; d="scan'208";a="22715524"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 27 Feb 2026 13:55:41 +0100
Received: from mkroening-air.local (134.99.235.10) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 13:55:40 +0100
Date: Fri, 27 Feb 2026 13:54:32 +0100
Subject: [PATCH v2 3/3] semihosting/uaccess: Use the cpu_internal_tswap()
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260227-semihosting-cpu-tswap-v2-3-cbdcdf39dd15@eonerc.rwth-aachen.de>
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [134.99.235.10]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
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

This commits ensures that semihosting data is properly byte-swapped if
the guest's CPU is currently in a different runtime-configurable
endianness than the host's CPU.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
Buglink: https://github.com/taiki-e/semihosting/issues/18

[1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
 include/semihosting/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 2093a49827..0911e3b31d 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -28,7 +28,7 @@
     ({ uint64_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap64(val_); ret_; })
+       (val) = cpu_internal_tswap64(cs, val_); ret_; })
 
 /**
  * get_user_u32:
@@ -39,7 +39,7 @@
     ({ uint32_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap32(val_); ret_; })
+       (val) = cpu_internal_tswap32(cs, val_); ret_; })
 
 /**
  * get_user_u8:
@@ -65,7 +65,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u64(val, addr)                                         \
-    ({ uint64_t val_ = tswap64(val);                                    \
+    ({ uint64_t val_ = cpu_internal_tswap64(cs, val);                   \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**
@@ -74,7 +74,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u32(val, addr)                                         \
-    ({ uint32_t val_ = tswap32(val);                                    \
+    ({ uint32_t val_ = cpu_internal_tswap32(cs, val);                   \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**

-- 
Git-155)


