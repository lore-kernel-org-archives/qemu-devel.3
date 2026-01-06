Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2DC47BF5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 14:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd811-0000XT-TU; Tue, 06 Jan 2026 09:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LM-0001De-NX
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:28 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LK-0006Qa-Re
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1767707007; x=1799243007;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Gyc605Oee09BkDbNn+RqelOfUjVXDdOvnXFHhbqMjiM=;
 b=MRfLvhfv67jvTYZFlDd1SgI7q8jB12n3Phns1NBlLXwxyKX8rqZt4Gk6
 GKEKq2kimfCpu+HbvkGkHml8FlWFLjxLlfQppm087RkgL2N6OE6E2Hy1H
 XUUm8d8JdD3pTWuULcRBPGRf9NsZdfKQ6ep1DunCnh/wsukqu9tHVfeG8
 B2qpqHspk2HlVKt6N4xMOJWFA2p71f5DwFkMR3conigBvCPkoEgx+Tg6n
 /oKZenbWR94F6axp/M/hZjLG64aI5KMWoIakn4U5wyDC91Fd+7XFL3FuB
 PVtl8F/nI5QsOMo7qwvmFD9PB/bCctSHEH+b+QvDaMo5x9qXuxyYNcPR5 g==;
X-CSE-ConnectionGUID: ztqdPzYHQ0aDwZOvvZqE0Q==
X-CSE-MsgGUID: 2wsSQh8+S5+Mfm6nh8vYfw==
X-IPAS-Result: =?us-ascii?q?A2CiAwD6D11p/5oagoZagQmEJ3GBagiET6wMhgQPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFKBwQBAYITgi5GAoxsKDgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBgEBAQEBAQYFgSGGCUYNhlsGIw8BRhAlAiYCAkYQBg4FgwIBgnMUBrAzg?=
 =?us-ascii?q?TKBAYR82gSBHwEFBgkBCgGBCi6IUwGBb4QAhHiCT4FKgj12gmECAoIrgw6Ca?=
 =?us-ascii?q?QSCInoUlRAJP4ECeCwBVRMNCgsHBWGBBQM1EioVbjIdgSM+Fz5jIQkFgmwGi?=
 =?us-ascii?q?QAPiVqBFQMLGA1IESw3FBtDAW4HkAqCd3sTLCKZNq9WB4I4gWeMHpVUATKXY?=
 =?us-ascii?q?JMLLphYigqDf5ZQhD0CBAIEBQIYgX+BaQ4HcYM2UhcCD5Ihwxd3AjoCBwEKA?=
 =?us-ascii?q?QEDCYI5kS4BAQ?=
IronPort-Data: A9a23:/x4/iKIFQhzM2rWtFE+RopQlxSXFcZb7ZxGr2PjKsXjdYENS1jcAz
 WIfDGDXOfqCamOmL4gib4jl8B4CsMPXmIdgHAsd+CA2RRqmiyZk6fexcx2sZXPCdqUvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuFYTdJ5xYuajhKs/vb9ks21BjPkGpwUmIWNKgjUGD2yiF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWaqYFF11ZP2cwIzxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjaMKVAktubD12i+
 tQKNCkBVgKyp9vuyZ6keM5ymPY6AZHSadZ3VnFIlVk1DN48XozDTrWP/oUd1XEqmdxOWP/SI
 cYUAdZtRE2bP1sWYQ9RUsx4xbr07pX8W2QwRFa9oKMt/2nVig9r17XrMdzaUtGNQ8hPlQCCu
 X7Gum3wCREXMpqTxFJp91r12LWfwHmqBer+EpXi6eVRuV3DhVdOSzgYUAW9oamnu0ChDoc3x
 0s8v3BGQbIJ3FWmS8S4UxCmrXqsuBkaVNxNVeog52mlw67Z80CTC24CQzNpbN0gvdUxAzsw2
 Te0c8jBHyNzsLCFDGnHs77StyyuOW0cISkOaEfoUDc43jUqm6lr5jqnczqpOPfdYgHdcd0o/
 w23kQ==
IronPort-HdrOrdr: A9a23:4Bx0sag7Fa0wqCgBANXIgIWWMnBQXiwji2hC6mlwRA09TyXBrb
 HLoB1p726StN9xYgBcpTnuAsm9qB/nmKKdpLNhWItKPzOWxFdATrsSjrcKqgeIc0aVygce79
 YDT0EUMrLN5C1B7PoSlzPXLz9P+rW6GeuT9IHjJj9WPHhXg4oJ1XYANi+LVkltAAVWD5swE5
 SRotBHryGtdHAebsGxAGhARO7eut3NmprpbRkaQwc97gODlyml5dfBYmKlNzklIkhy/Ys=
X-Talos-CUID: 9a23:nXo/8G/i+o8lxVts7b+Vv1wIA8wdYEz99S/ZD1CKLnh3eqS4EWbFrQ==
X-Talos-MUID: 9a23:nmhCJgacwASLu+BT7SD3vwhiZIRTvueLBkVTl5VWpfiKKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,204,1763420400"; d="scan'208";a="16285295"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 06 Jan 2026 14:43:18 +0100
Received: from mkroening-ud22.fritz.box (2a0a:a54a:c75:0:1df6:38e8:59e6:777c)
 by rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 6 Jan 2026 14:43:17 +0100
Date: Tue, 6 Jan 2026 14:43:06 +0100
Subject: [PATCH 2/2] semihosting/uaccess: Use the cpu_tswap() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260106-semihosting-cpu-tswap-v1-2-646576c25f56@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
In-Reply-To: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [2a0a:a54a:c75:0:1df6:38e8:59e6:777c]
X-ClientProxiedBy: RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) To
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
X-Mailman-Approved-At: Tue, 06 Jan 2026 09:26:27 -0500
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via <qemu-devel@nongnu.org>
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
index 2093a49827..6813873a2a 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -28,7 +28,7 @@
     ({ uint64_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap64(val_); ret_; })
+       (val) = cpu_tswap64(cs, val_); ret_; })
 
 /**
  * get_user_u32:
@@ -39,7 +39,7 @@
     ({ uint32_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap32(val_); ret_; })
+       (val) = cpu_tswap32(cs, val_); ret_; })
 
 /**
  * get_user_u8:
@@ -65,7 +65,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u64(val, addr)                                         \
-    ({ uint64_t val_ = tswap64(val);                                    \
+    ({ uint64_t val_ = cpu_tswap64(cs, val);                            \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**
@@ -74,7 +74,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u32(val, addr)                                         \
-    ({ uint32_t val_ = tswap32(val);                                    \
+    ({ uint32_t val_ = cpu_tswap32(cs, val);                            \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**

-- 
Git-155)


