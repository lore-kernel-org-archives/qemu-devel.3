Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00165C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xARuE-0000UB-4P; Sat, 26 Sep 2026 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAZ-0002eD-HN
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:20 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAW-0001Tr-9j
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:18 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C51541400128;
 Sat, 26 Sep 2026 08:06:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 26 Sep 2026 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexrp.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790424374;
 x=1790510774; bh=pnarGXbP2sK+BhJc6nPIZM+3kz+P1sxlOPLdrc+ryPQ=; b=
 gKsKwbjaGp6RDQXm/BbqQSzN643LI+04hEIiskBuQB3tO7tQeQ0wJEXnCj+gbaTt
 njq+e06vulJG5Du05BuET8T4p+cG/A0HObVaBWzZ3VTdHrShMvRc9m9xDel+U8KL
 twETzYOPA/Y/6XFlVwCjKDn4Sx28aQmRFyuwUZfF3ZUbnykT8uGR3qQyJs7SizE3
 wnLOABempgcRR1Ddk0Qu2UM5ensIhsKOynx63I/8iJ+PeuebdQ9EAO2b39+fw4SL
 DxhPUooM6VbmyIxKw9mPNBkubgjBe9ZyhEJRCgKtdUrnEX7BQH70vw557xaUvYC8
 iREkDhRUx5vFU8jo0Xs4+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790424374; x=
 1790510774; bh=pnarGXbP2sK+BhJc6nPIZM+3kz+P1sxlOPLdrc+ryPQ=; b=m
 xC3YDxkj4lECZ9BPiIL8FW1DafUG8TNuXetDK+iegsAjlvzeTc1pgQRgYYC0SKeV
 9ayHgpttQ7EvTpfvpf7x33s0hSZYjSMiWvCjiE0hSKpMb8+XclqhT8dj6xK1lHf6
 mWct62MCG5mWRPHMJT5zfac/4pDfVYa/0wb0j76BdYfJA/5296RN6pg3YoqE9nhh
 cWSIqtpYq3cxVYOtlq4JIVi8NVFQ/r0pT8LputExTz+H/Nx7Oewkgs1OlgskIpr+
 8IhUe5pbKIAauXa+IHgA0w+BZjZVI1Ad/u0ljc7HZTUeyj5nLMbO5XVW3cuRO9TV
 3Sx7+F7fhG5uiYsW/YuAw==
X-ME-Sender: <xms:NrW3auRVDc6xbGWtENenS76C2RuUaK_KaHemViJPjnY7yYUfDloJbA>
 <xme:NrW3ahVGTIicsSN9Vep43D5vKZXV_i5OSpOh0Z-5-Eapl_Rj47GbAruaM3qeWWoA9
 97kR4Hd_Lj43otDUB9AYBzjm7VjvD0g61_PbcXvRVVsRyesWVZ5oF3THQ>
X-ME-Received: <xmr:NrW3aiQjfO9LfPtWX3dlnQlBt37nIQlz4GHHd4DKRohUVFNAjvjAtHzRxzkSAKSuyzw>
X-ME-Proxy-Cause: dmFkZTF/S6soafPrG1N09tUNQINptIEr6+akZOCHUST3G4ffc3AcUtYnff8CmVZiQTeaYD
 jDshNYNGx6RumNrbAuZGkF1MwrrAulwr7VZPXdtVMbxAZafQhEI3ccafG1PhCB0wtf3eah
 CrlWBPARH8dH/EbLOpEjun/QZVmYet5NN6k4RRwcBggBhfm3BkVD4yMq2OniM2Obp6Zhg9
 dUoDfhpQWY3ayj0evKCkn3Jxs3cO+55oAbwpX2foJOzDyLD228SiXG4otSN6IAwG0GoTkU
 LkM+p0uzNE3uUAcnaZSrp69WOsLDXstsf1ROkF5u19oFW8yFb1HFiXIWnCT7a8Z2lJFAh7
 O4VOsaa7Z1T4ZRCCwSDC7JU2jZNZXQXos8erUKG5SZYsy3GHpKzXPROogvUJdUO50sL2G2
 0YmpDWMBBC5B16r4x8+3iUCs3QDmvL7juLygpiyQUWzOIk8S2JNj7IUdtZ7yMI1ZHhR/J2
 ShTXnmn9rmpoxbTOz/kuw0pInVMds95Bk/OBF4Y1V9GecJAoFsJsl4Py74J9Q1jChU07/V
 iyJplALWxZTQH+huNLd6Hb66DzcWseopw3ytc3iwY2iHpXLzcTswX5QwBxqcSYVnroZai7
 grJY70lmcUe1oIH7eaoNNYt3Z9gVdKujTHRFYzHan27W3UK+l156TGrezFXg
X-ME-Proxy: <xmx:NrW3arkiUmT8B2Yii0g9nkOnUMoKukqPbr7tdw8mWXNXTN9or5gRgQ>
 <xmx:NrW3ao5eBEXEAcox_3qhzjCUvCB0kA7HTNc5Gdx1eOuFVwm13Sx4gg>
 <xmx:NrW3ahgykhKHoOpFIu9wNuMjfVOQ3zil99krd3-k499oeAYBq1Eh1A>
 <xmx:NrW3alHfyc3CaCSOWrf86nEW2YTMIzARepy829RFpu2Qk-F4DM5F7Q>
 <xmx:NrW3aoAf3bAv_s22igi0gSVis3GcIde5CD6oIwrulJdDOFXYBVtAfwrp>
Feedback-ID: i799648cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 08:06:13 -0400 (EDT)
From: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v1 2/2] linux-user/mips: pick Loongson-3A4000 if a pre-r6
 mips64 binary needs nan2008
Date: Sat, 26 Sep 2026 14:05:34 +0200
Message-ID: <20260926120534.240391-3-alex@alexrp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926120534.240391-1-alex@alexrp.com>
References: <20260926120534.240391-1-alex@alexrp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@alexrp.com;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:53:24 -0400
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

Before this patch, we'd pick MIPS64R2-generic which does not have 2008 mode, so
the binary would just fail to run without an explicit -cpu flag. Now it'll just
work as in the pre-r6 mips32 case.

Signed-off-by: Alex Rønne Petersen <alex@alexrp.com>
---
 linux-user/mips/elfload.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index ce2c4514f3..f3d3fc8dee 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -20,17 +20,19 @@ const char *get_elf_cpu_model(uint32_t eflags)
     case EF_MIPS_MACH_LS2F:
         return "Loongson-2F";
     case EF_MIPS_MACH_LS3A:
-        return "Loongson-3A1000";
+        return (eflags & EF_MIPS_NAN2008) ? "Loongson-3A4000"
+                                          : "Loongson-3A1000";
     default:
         break;
     }
-    switch (eflags & EF_MIPS_ARCH) {
-    case EF_MIPS_ARCH_64R6:
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
-    case EF_MIPS_ARCH_64R2:
+    }
+    if (eflags & EF_MIPS_NAN2008) {
+        return "Loongson-3A4000";
+    }
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R2) {
         return "MIPS64R2-generic";
-    default:
-        break;
     }
     return "5KEf";
 #else
-- 
2.53.0


