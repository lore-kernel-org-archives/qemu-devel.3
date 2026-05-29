Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D241BCD6E43
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDu-0002x8-21; Thu, 28 May 2026 18:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDs-0002wZ-5B; Thu, 28 May 2026 18:29:04 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDq-0006wu-EZ; Thu, 28 May 2026 18:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007336; x=1780612136; i=deller@gmx.de;
 bh=zkCvQGV0S+k8vtMtYQ+DXgjKjWV6ngUHcnFo0H+GlXk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=je+F85xnuB7yzKihEN0YsRq3kQZI/2ZPRgMf7oQWcJZ1AD4QwZDSfA6Api/12eBp
 DvN4KlBGetoUNpnlutOWby1WJARcdHLIKYlqGEUf8p7zT7kZTzrH7kj+TLt8YOcpE
 Olxhrf2LdsaGvl/gE5ABsOW3UeQ3Cf+6n0DmZdDnjC2BRIBFh29fSO3fdcw4/9mpJ
 Rud8xU/PPTfyaKIZcE0e/RUYEm29yxdA8+HObOjrQjQ6y88rvsQMi6D5fGRRmrKux
 yJ7b3Ve7lE2Cd45qlCac1ZUYfHl+6HWudTDFLRbsHgcRQZBBSarjNOwtkpmvUmfiu
 mqXxMF5kn1gaJ1G3LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1xD1DV0esb-00qtrL; Fri, 29
 May 2026 00:28:56 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 09/10] linux-user: Move init_main_thread() prototype to
 user-internals.h
Date: Fri, 29 May 2026 02:25:46 +0200
Message-ID: <20260529002548.19293-10-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njAO7l9LNvby1qfdw44xRGcbpIkIU6hc1I7+W59hz2rI0ianjuU
 snGoR4R5nXetVH378T6BbSCK0WnuSonEYEneJ4oPqJ+OcxO/m1fTg+qTxVZpxFGf2LS7v2A
 vbtfqJq/YlnRtM0Xw0bHgbMvvTgxq/HI5+OWZntSuCNaGETkwWlffcyxseidHnAKh+0hzjj
 aoxUqqzTUQ3rbzL+iU/zA==
UI-OutboundReport: notjunk:1;M01:P0:+SRWw1k9GQc=;GIDyqiRUZma5LPloyuSW/U+7BaK
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


