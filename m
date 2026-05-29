Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A5BCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57b-00067S-0O; Fri, 29 May 2026 17:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57Y-00066S-OE; Fri, 29 May 2026 17:52:00 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57X-0007Z0-0h; Fri, 29 May 2026 17:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091512; x=1780696312; i=deller@gmx.de;
 bh=zkCvQGV0S+k8vtMtYQ+DXgjKjWV6ngUHcnFo0H+GlXk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iE5q8ml8OrAYnv46R/Hx4mP+IpzHsaOgrgj6ApfjOIUV4/OZNCSHOIJVPLk2ENkL
 NDWLHFbr+tO/jnZtBYYyt+T78hn8cL6iH0zb4of3dfvu+xXH2M0/3wDDW4+BSmkNI
 c0IPI1/pmPmNGkob6jLzCob4dWtfmg/uxG1amOfwslaqWTMZBkVUHSYomjHVjGndl
 TF1O8Rhh+5/ULfkDZ7r7G0gSz8Vrhskmmpw5ix/JHVRoR0LnRZIbmT+swozudixRl
 yEZxlLz5KEhJP2T+VJ9y33IhL2Rsv7FZ/PCQ/Wx8UyzmTKg14GDFVdxHCjbPB3468
 nIwZ2V6Gqx+fXvJSQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1x7Q8U06q6-00m8Or; Fri, 29
 May 2026 23:51:52 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 09/10] linux-user: Move init_main_thread() prototype to
 user-internals.h
Date: Fri, 29 May 2026 23:51:18 +0200
Message-ID: <20260529215119.73244-10-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3/glxNCCrzssD8vep0zLk6VzNT27mV4tNxlJ9M25d5CREE/ceF1
 k0mu97vK5ApvKsjSTxBnz//a3k7jTznhcx01WJjKpgT8D+nEr4mqDgxOCZGVvl8hcmKgikW
 ELtVHpuEOZ76kmZq6vYbMOCPxHkuuNwo9I5Ytlq+OWObXj+euS+skoYNlvhDQL9dVxXCy2Z
 zOMVJ5LRJ05X6QGEK9cew==
UI-OutboundReport: notjunk:1;M01:P0:CF/EE1S30tc=;jDnLU8s9W4MaUanyf0vjBQ2LJhy
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The init_main_thread() prototype is needed only by code internal to
linux-user/, so it doesn't need to be in qemu.h (which is also pulled
in by various files outside linux-user/).

Move the prototype to user-internals.h, and give it a documentation
comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/qemu.h           |  2 --
 linux-user/user-internals.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 7f98fb2607..474489f046 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -371,6 +371,4 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
=20
-void init_main_thread(CPUState *cs, struct image_info *info);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 21daf422b7..fbfd12237f 100644
=2D-- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -194,6 +194,21 @@ static inline void begin_parallel_context(CPUState *c=
s)
     }
 }
=20
+/**
+ * init_main_thread: Set CPU state for main thread
+ * @cs: CPU context to set
+ * @info: information about the image being loaded
+ *
+ * This function must be provided by the per-target code. It should
+ * set the initial CPU state based on the information about the
+ * starting binary in @image_info. This will be at a minimum setting
+ * the initial guest program counter and stack pointer; it should
+ * also set up any other guest register values where the Linux ABI
+ * defines that they start set to some other value than what the
+ * guest CPU architecture gives you out of reset.
+ */
+void init_main_thread(CPUState *cs, struct image_info *info);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
=2D-=20
2.54.0


