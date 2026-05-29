Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F68DCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjEK-0003Fl-IV; Thu, 28 May 2026 18:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjEI-0003E8-Ak; Thu, 28 May 2026 18:29:30 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjEG-00070f-Hp; Thu, 28 May 2026 18:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007338; x=1780612138; i=deller@gmx.de;
 bh=lt/Mmc+bT2vzqUqwyRnnOIgWS5pSwQouTPDb1uInhns=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gZAlU50sW+Bz2mDDrxPNDjhiHZafGVTOYBuCBIwZqlmll+peEjo3iHoZmoGQiuhn
 zTZKG2B2YcnXi1d3HmYQaPDkX2+i7r9KQrVL6YRnPgiCuvJg1XaX5mR0qbbP8oLpH
 AqOU6aIyUPZObKER6GNVlzuv/cwF27dQmkJojiwo6BPIF0BmNmRsFi6lxxF25SGim
 mjilGM2oe0zLZGSYl8imxVvvF8gaQX78+z4bQEVj9HMZaLJQHcEjQLlf3rOJLIqB4
 MIH3rZbjZ7q5jrckxdj6fPqgIs7YeiNnaA6Xrjw/KsIw6iNfjSZa57fZuUd7UTtoZ
 /R2E9R8P6YOipHF3dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1wQXMQ0hDs-004rcE; Fri, 29
 May 2026 00:28:58 +0200
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
Subject: [PULL v2 10/10] linux-user: Move cpu_copy() to user-internals.h
Date: Fri, 29 May 2026 02:25:47 +0200
Message-ID: <20260529002548.19293-11-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uEC6jM5Y71OzI6bF1+IG973MLZHnhroNDIb302Us9IU9J+A07C8
 oIFczqda5YH3A7ALtFjx6LtO38viQthBLsd+olVBIsVUkoL5GC6uuEYBrILZD7iG2K6rxUn
 kzJ35fv/ccE3KHpPpw1+AKx3W6zmvCFwkyFsNCYsfU9usq0vmbWlOD5OEKkBOn7ZBj0Kjbu
 e0hjyoJLrR2XMwbDMC8EA==
UI-OutboundReport: notjunk:1;M01:P0:I9NfkSwf4U4=;L1H5svjNp7MNyTtyIb+AppLxCbz
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We only use cpu_copy() inside linux-user, so we don't need to have
the prototype in qemu.h available to code outside linux-user; move it
to user-internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/qemu.h           | 3 ---
 linux-user/user-internals.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 474489f046..07fe801628 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -368,7 +368,4 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
=20
-/* Clone cpu state */
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index fbfd12237f..0380d44fe9 100644
=2D-- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -209,6 +209,9 @@ static inline void begin_parallel_context(CPUState *cs=
)
  */
 void init_main_thread(CPUState *cs, struct image_info *info);
=20
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
=2D-=20
2.54.0


