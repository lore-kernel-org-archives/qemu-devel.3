Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775281125854
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MQ6-0003tX-RS; Wed, 11 Mar 2026 12:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPs-0003Wm-Lq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:14 -0400
Received: from mail-out-2a.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPo-0006SA-Qm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1773246489; x=1804782489;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=+lX0kQwVmxvfq4f4pP95/st/xJ6ocK16Un5I4Y4JhL4=;
 b=XqWHLgrJHPZJFmyho229Q7JlEVvV16Qay9ia1q8RzHXVyCR4GEaN05MH
 khSGe8Zb2pO13jaMvbIPvA/3oh/qp9D+rfimvM+mvCNJOGIUfp6c0BjPH
 zylltd6OVygLsTIVsud3Z3iYGtyJr2/GcqBDctBW/InwFiRpa+haTwyIg
 lLffzVr79aLRtR2myR3VFkQFhEwiO0N/dAmvgZJad9IvSq7e4+M1GVW+O
 Ti+QuS8ad/GMs5fekACWitrzrNleZdgGDkiW/nj88isRhnm+W54kzTOeC
 3VBhaiZH5bYDkeHlJ9sPgPDUfGPI1yYz34luH/6RfDbc7Q20AzB+agSLT g==;
X-CSE-ConnectionGUID: EcBXGUCvRPmmFar4uN/a4w==
X-CSE-MsgGUID: tSPFDkqrRfaiu4dblL2O3A==
X-IPAS-Result: =?us-ascii?q?A2DOBwD+lrFp/5oagoZagQmEJ3GBah0BAYQ4qjOBWYYED?=
 =?us-ascii?q?wEBAQEBAQEBAQgBSgcEAQGCE4IuRgKNIig4EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQYBAQEBAQEGBYEhhglGDYZbBiMPAUYQJQImAgJGEAYOBYMCAYJzF?=
 =?us-ascii?q?AawaIEygQGEfNoHgR8BBQYJAQoBgQouiFQBgXCEBIR6gk+BSoFHdnaCYQICg?=
 =?us-ascii?q?iuDDoJpBIIiehSMEIcTCT+BAngsAVUTDQoLBwVhgQUDNRIqFW4yHYEjPhczW?=
 =?us-ascii?q?BsHBYUeD4hwgTsEI4ERgykDCxgNSBEsNxQbQQFuB411PYI0exMsIoFyl0SvV?=
 =?us-ascii?q?geCOIFnjB6VVAEyl2CTCy6HZZBzigqDf5ZQhD0CBAIEBQIYgX+BaQ4HcYM2U?=
 =?us-ascii?q?hcCD5IhyD93AjoCBwEKAQEDCYI5kBEBgRwBAQ?=
IronPort-Data: A9a23:6wvEEqyx7dPdnh0tGdp6t+cWxyrEfRIJ4+MujC+fZmUNrF6WrkVSy
 TAZCz+DO/yIYGXxfIpyaoq1pksGuJDUx9dhHFZorlhgHilAwSbn6XV1DW+tZX/Ifp2bJK5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX+s9JIGjhMsfzb80o25K2aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/111lq+tMJ
 OBl7vRcfy90ZPGWyLRFO/VvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGEV0r4fPI1Ay
 RAXAB0GRCCsusmo+oq+T8dlnJg+Co7iYJxK7xmMzRmBZRonaYrcX6XH9ZpDhnI5wNpRAfabb
 sZfZTcHgBboOkYTfA5MUNRkwqHx2yWXnz5w8Tp5oYIy6nLPzQo306LqPdzUfNOiSMJTk1yT4
 HjZ42S8CxgRNNGZjzaImp6prraQzXKkCN1CS9VU8NZ2u2W96m8KEicYXFqm/fWzjmrkfIl2f
 hl8Fi0G6PJaGFaQZtD5Ug3+qnOCuBMRc95RFeQg70eK0KW8yx6ZB2wBQhZFadovrshwQiYlv
 neRks/kH3pquayZRHaZ3rOVqzqoPm4SN2BqTTYJSBZA79T9rYUbiBXJQdB+VqmvgbXI9SrY2
 S+WrCUuwq5JyMdNzbqn/RXOj3Sgq/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:mxKSEaw6AdXIdfiGPflgKrPwWb1zdoMgy1knxilNoHNuHfBw+/
 rBoB1k73PJYV8qMRlKpTnqAsO9qB3nmKJI3Q==
X-Talos-CUID: 9a23:EUCA1GM55VJ39O5DdSJNxGEpMd4fSnjY4n7Kf1KeTm81V+jA
X-Talos-MUID: 9a23:sMZORQpzHdcTOR9L9Foezy1ZDOlE4L20Mk4EkIhat8OAEXZXYB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; d="scan'208";a="178978787"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-2a.itc.rwth-aachen.de with ESMTP; 11 Mar 2026 17:28:03 +0100
Received: from mkroening-air.local (137.226.124.87) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 11 Mar
 2026 17:28:03 +0100
Date: Wed, 11 Mar 2026 17:27:16 +0100
Subject: [PATCH v3 3/3] semihosting/uaccess: Use the cpu_internal_tswap()
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260311-semihosting-cpu-tswap-v3-3-8e239575ec08@eonerc.rwth-aachen.de>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [137.226.124.87]
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:45;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-2a.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


