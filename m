Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73627606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=PF5Al5Mi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnlE-0007Ui-RM; Tue, 10 Nov 2026 10:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQnlD-0007UQ-Ad
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:27:47 -0500
Received: from sonic302-21.consmr.mail.ne1.yahoo.com ([66.163.186.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQnlA-0003jC-Ix
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794324461; bh=DuCg5rLqIkcqApcKtr8LuuP2ryj5Rm2OAi/qpP1ta9I=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type;
 b=PF5Al5MiRPyuwVkjVlDm5/fqFQO+u1cWfVUIXB3ErtM8PkgwS+JtCmT+oKMXsaHo5vAqWcspdWUGUvrAdBwxQ2nF6HENLZk6ztnmWECTjikVE0sW0pdIxTp98gPY3hdkywfsGh47pewwAEB2TLUMxxNb/brEZLqKmD85Wzy5njiSzAZzoF0UhXGAnJq5XINVl5lSBMCNwVlNF90UNblv88lRpbExKchiXVt/VD8SXAmwiaLBOmW/WN6PvPKUITFLeDi/KUMI5H6Q88EPciinlms9VeRVez5/3jhiq05fjn42ud6j7Ovh4tMLq4XKtc/7rqgf8roGn4fCjV17c/Vf6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794324461; bh=2BkBLjV4lf1zHAlk5pX7rtm/HsoB9jS+72yMdXba5to=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=tBkkQM4AOzVThRNrO+LDXKmxlVPVYcVmnBSuTwu0Uy8ioYBhD/J5/sLASgS41tApqnijR3bcYH5YwOTq/jHxC71xDeJjIEkwWeG7bFphBMSrG/mJNFnOqwbXT8Ii4FHT8mRboCNDTzwrnaM83k2wxbKaSOV7Djw6/XXRMadvle7yVr81Cbci0PCZwyMlbEPnJ6ReaWiqaODq6KtrzLPFYcOQ1GFo7pNsxRZDwzxA4BqPn18VDOpyXPimKuPs8YI0WhnvXk+HTslSDuTbbXrxD/7uLxAr2vfgbRHDF1njkf7FX+eLtguUhfoyZBmjR/AyFCax7jMcf7uDCmCDWjD8Pg==
X-YMail-OSG: 6qu0z94VM1mahdLncb9n9NBQWcou3LzewJxCv9G64zpHoPT_rIDWRLTKt66hnnL
 fflmiXFx4.II3Y03X9CJTRwOun2qz9YlNHFJwNz6grU7oTxvNEbi_qUceHRa0qPbKVf9dOXyzPB3
 rD24WoRuqqq5L2BZodsOLa70CNkclg8P41acAQo8.xTWQ6tHNYjrw6e6OrVpoMZlGbdeJ2JM_Kp9
 kqjpEO.1JauL5RpxGLiu01VfHlWajAZdRuUqNBs6t23WX.MrEw2gXwgHESaHA7VbQFPRsnpjevOP
 MHA407QlrcWh3g3XsxcoLNyTsLEVgfZkVHp0y_Gb9fmOidtCwmoM1C2KPZ3nalvy39LTOFr1LlJi
 zMwDJDFD.BVAHuSsJK_EEyBSaQ7BXusygWHVzGLYeMb3_PddZsHtrIZMSennhe7HamTz8XQpiZms
 wHD4pTRjgOBvTdFa_VqLUkFEsL164ePIp0XyqRAD7sADLALsKz_ZJ7cApU2QYVaYSo7bFBk7zY_F
 2uFiDFkIfM6nVChEske1gm4IQ_0JWpFCmmSG0WLstio_x1sgKMFSt.vopoMngSBiMz3JxS7trfmm
 JjZrLZjBSdKUUoXVQBJSB.6jEAfM_sPxofGkuGoBamWpH4_KQsnMDupEzzg1SKKbQExCoOVMU1Iv
 kAFA.7tm_myXSZMQmTRlCCXD_2tVNDrhWJ2B5nacBBzIGgJZUovABjYGZa9oxVdqxeTvOpeQO986
 qzTxFkhckvA6LWtTtqMpDtJqgP4iy.EZcYmbp9d9hT2UkXnFAE1OjG2Q0eGbrGOYvPpAmGpI.W7x
 ny6vheLpBRl_UGrig12aJ9WwlHYgkfJscR6Cy6Fvzafv_oRcPAeLI8DYG198r3GWw_lcuacbml8D
 qvKAFnqo9ZiEHPja9rCh5NeBhMmy7XHyO384n192iMxY1BGjyhqj_eqp2_hJTLXOb.F_8nWnG6se
 clzqPmNCHiSexzk5GKsNi4YtogxPy9KBFCjwqgFsggAye4q.4XWfDMpbDsTnP26ru_O6aU6uCT7j
 XfAn1hJ21znl4Dus7Raw5VtvSIKGD_2zQsYbpMlAjB8odYeHrsGSeUEH12X3YcGQNAJJDVouWVxW
 n2DB_sapfBbf1Dc8HtIWISSALw14BuhKt7Tut7ZJF6nTiPWKEaw1hhCCviE4dA8DUcGcF8k85Gkp
 .K0UIRGt.2fYBl_TmNimSM14KEqZF85E4NVDhoT5CqlDcFwFfAhJE0Y.vP_ZkFSGsu9sPHXyzjoB
 3b3t5uic_sRkYwo.emD1mxYYPX384UKrxtNNaVzhZYCtt_ahNlIl1kPgogW1IWWrEzydH58X7SuQ
 OpeGPcpXdiAkZo1y67QSvB6BRldiDSkzpImDktYjW7kXKjWd8cbKZ2KSl66uc8YybqNzZo2EI27F
 p9HF0VJrgXFwVC5YKFShOSKEMCpeVGDG_GNPQjoLdNsMtIOJ11unfRkIXKrpIkymugCbymNEK_LI
 iYfUeNWVI3Xef_pJJyR96PxLrbHdAqfsaOsGOEQ98QPdxslBIAzQIeoJEgI3McodneEJVfkHAvqz
 7BRd2Q1JtM8Omxyvnivam1koX5xTY63ZmJiQOwbpcchod.NmtBlUnOhEHvNcdIFtsYcDuoPKUFK9
 1k1qwgDtXsm2A0D7bLMTppF8bOwN_.q4kc6iKhLS7G1EDxyuKgO0Upnq6vTVgkHiODWuKF2cgkTN
 sir.m7GfhUDeqzrnz8YoqguinwYdy52C5nER4g0cvfXIeGPsy4IRwM57_mjbMHs0wklvox4daTo7
 mhM7sxo7NrZcCnv8oqgxeYIPwmq51_QITkX2pGhrJuH1E3ksKOQZDv99oO_oWJNSKBLRAWj0CgQM
 AMmr9vrQ27A5Dzj95grVvDp6ub7jagxMlnCnaH5pY_0TnmXXdBuagpIIBEk1rnbH5b_F7lg3zdSn
 JsiypE2v_rjScV.CTj_afiKHvpJ7jrHx_eCKbk74_pIgn91tmT_ZhwpeesgsOe9dB4Hb0L2Ekh.8
 0lnSdwbR_neOgIyV0yGCyBigjH4xl5ZfUdKjUEgNBUFo8sCYfD.yN1Mohc2Yad5QVh19OvtxXH9.
 tX1dvFvmj4zGMD092UvADzFD2AVjEuNk8zB.LQfhoHDL3SUyY7d98UCv8F_WKFSGILbwKIxRoJy7
 IRubX70pugh6wVlpjGsY5zNfycYQl3UlK3uOAAjoLK3TrHZtdbJxNCj6sOa2oh94u9iLtB3TLPKN
 0akXbp29FmqJfWd5YMyw9AdNaLtXWatYnPx6ipik0tcQaEQ0NNSFQbbh4vBt53Z6uT2v_yFesSb.
 cxk3gNS27mUk-
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 83963626-b7ff-4699-a1e8-2caaef8dec51
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 15:27:41 +0000
Received: by hermes--production-bf1-6d6877594b-7nfrx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID d1dfb4e63609e0f295bccf483ae4413d; 
 Tue, 10 Nov 2026 15:27:38 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: qemu-devel@nongnu.org
Cc: Eric DeVolder <eric_devolder@yahoo.com>
Subject: [PATCH] target/m68k: Raise ColdFire bus access error
Date: Tue, 10 Nov 2026 09:27:28 -0600
Message-ID: <20261110152728.481267-1-eric_devolder@yahoo.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261110152728.481267-1-eric_devolder.ref@yahoo.com>
Received-SPF: pass client-ip=66.163.186.147;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic302-21.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

m68k_cpu_transaction_failed() now works for ColdFire
(access error vector 8). Previously it was only 68040.

Signed-off-by: Eric DeVolder <eric_devolder@yahoo.com>
---
 target/m68k/op_helper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 65eb69f2b4..580f26a540 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -237,6 +237,9 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 
     fmt |= 0x40000000;
     fmt |= vector << 16;
+    if (cs->exception_index == EXCP_ACCESS) {
+        fmt |= (env->mmu.ssw & 0xf) << 24;
+    }
     fmt |= sr;
 
     env->sr |= SR_S;
@@ -472,6 +475,18 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
     cpu_restore_state(cs, retaddr);
 
+    if (m68k_feature(env, M68K_FEATURE_CF_ISA_A)) {
+        if (access_type == MMU_INST_FETCH) {
+            env->mmu.ssw = 0x4;
+        } else if (access_type == MMU_DATA_STORE) {
+            env->mmu.ssw = 0x8;
+        } else {
+            env->mmu.ssw = 0xc;
+        }
+        cs->exception_index = EXCP_ACCESS;
+        cpu_loop_exit(cs);
+    }
+
     if (m68k_feature(env, M68K_FEATURE_M68040)) {
         env->mmu.mmusr = 0;
 
-- 
2.53.0


