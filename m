Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9FCF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbK-0000sY-1i; Tue, 24 Feb 2026 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutau-0000LO-71
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:01 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaq-0001IU-Fe
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso3250334a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944055; x=1772548855;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9HAHp2eGqV/T6gC1AiqdWHhJeslTmnwP/pOM4ajrSM0=;
 b=k60Fnd9udU8klutUTlfVKhe/+dHmwyofYzi65jEQPuVSNt8uJVA0YDILgcvwFKARGI
 6d82t9D1HYfW49NH9uM5fAmTJMpA1Bi0X7T2Uk/W3SsHqrBt+S/nEJSDyeA5vmdgq9ov
 36HuIPxs4ByqeX4yiBbBVFoPmGA+vkszT9NVtOeEkBcpgEEc66hWIb1mIN1POc65KLa6
 taw14DFcSdUNK7C7baHeEHELwaApocbIlD/qOR4M0RpQgtCVmi6b9zi+JhyDLU++OZug
 gOVAxgbltLLWyx1ce0I120hmYfqL4O5AzUQf5Bi5KJ2Ihwiz8GyScQUv7GNBsj546eDZ
 eaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944055; x=1772548855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9HAHp2eGqV/T6gC1AiqdWHhJeslTmnwP/pOM4ajrSM0=;
 b=L3R4UIUbZFRgBDyFaS8WNs57hn4rRgbEij6K2EksuvgVHMZqzY3zgVbr6iiI6cCE8m
 wnAGpZLQUYiJULxTWdbrxDoQ5VF9eFZc0WH4z+tg82YSqvQbxbXNn5T72rLhATE+r1Sz
 BD/9AFOQb9VHmSAzuEbUSzNDdqslWshDx2HanDa0aig61PRgd4otHyNA96GLbv8oMvYm
 9kPCJLoq1WcbUvWssY31ihBNnQkubTTrXRbk7X0CDxWDgJodSX/L88bgTRn5oqo1NF2T
 sp/DnIqfblCSzmFKITa69WPCUwDDxU4AVw10lNehGtEDLuhQLfHXuD5ncMNz9wqZsiag
 Fl5g==
X-Gm-Message-State: AOJu0Ywmqd8jTaJM/lex/zmv6cO6vTLazUKBcKiS+Fgo470G43/htyFt
 Gn2eSxbotxvAZLMYspFm+D2WBmjsAqLtYUSZL9AEBFIaHcVrkoDtOXZO7eA6DwYa1FtWSRaYrxg
 NggnBr6o=
X-Gm-Gg: AZuq6aLMU2thJFqArvZScFKuUabExW+Q0mG0zJIhHkrSJWbtJrGbIuW0v0L56rg/RNX
 AigAN6C/qOoFpvH4wEicmhzTrU8OTOR0fRIngvfuvLtlVJ/CK/TzTUAHinBVg4YpuPvo0RWtMBF
 4nO5a5J4sh7XeZqzFfiswqEnvJsdUsP0n+jxt9xgfk5A5aBRtzeCikJ0Kh3LAznB7T3yXWQ2ZjW
 U+I7JZ/c1SEFVACe1GWyhuRRkwl1A6/C2U5WrmgSucv7WkAeJchvI9mbvZSiMurtbyDzo7XyEml
 7dUwGUib1cP1DvPWBe68WKMbRFPnr7/zFtVuUKb6OPB7m56ozo+mUgK3QR3hebNQg+Yd3rZLTkJ
 wivzxhj8PSqrYZlSQDEA4OiM4VRsTP7rxPpDllU2MSXjDhF6h+uECAXGY55QdjQgmBZZlyhi2zF
 UsXmGLffVVxA==
X-Received: by 2002:a05:6830:2b23:b0:7cf:d58c:37c3 with SMTP id
 46e09a7af769-7d52bf6bd7amr6214679a34.27.1771944055091; 
 Tue, 24 Feb 2026 06:40:55 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:54 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:35 -0700
Subject: [PATCH v4 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-11-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=uTQUitK5xISck5snIAEayDZejrsfRER9aFZurjjKZHI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnshWejM3I6CuRyChiVxTVmjC6+cU8A3u0L
 MUADG7SH8+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 ABY5D/9q16XWfIW+1ZmzvuesCwFO1yPxGNvaP9sCIgMxPh0Hwh5zAse9phmAWZCUKXARZZ1Q1qt
 M2a9TeAOTUVYsPbpt4xwACg33f/H7Yn3CHpczoPisCMyO0f6nIzRKG/W/gf59U8rvHl2LeL8riy
 oeu/DeBM6JzZHe9S1fEfX5Lo3T764+Dixc3Ea2lOrgfeqWCxqbKLL5mreGgAIhUC0IMRivZRijH
 ZIbbSCOq2o6C9ztD17pU9I367SSuYmBr2s4MgKm77iDhSprwoIU0udjDxCVcuTn5lhCiMbPYtTS
 HAluDMiuTYaMLzh2U2v19wwXOXPz2j6xnH2UXu16bdMO9RmWDqm8idaJWAJEDPJY6D9lFvmi399
 vV9u1lPe3htgQkq7LocaDnzq54H/y4x+TW2iIrWTqfqQX8yuIl/uQrBX0gZdCwvjuLNN3d2BL7y
 2abfft4EPLmuO7auWEwlpzjr+7xNWRYva3FPkcLqG7KDCRwBd72hDCJCqVo53Yh7MteiHGUuedK
 s9igk3mAYUJ+byD98lOOqApJC03Qfj8o9v1OsVPqgxxkt5eLrjxn33+R2JdUtihxF4nHXbqvKRV
 2/ye41ehfrs0DYaZ/ttc5hUAhRMerAGnEpOQfax5y3WC1KL4KPQzJTjfHo8dAYOKQ3vgoV05U8G
 YyJVnCTpScNo82g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
rather than directly accessing kernel-only members. Handles FreeBSD
64-bit time_t except on i386.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5b02006313..5e5a590227 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -136,3 +136,30 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
 
     return 0;
 }
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(host_md, 0, sizeof(struct msqid_ds));
+    target_to_host_ipc_perm__locked(&host_md->msg_perm,
+                                    &target_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __get_user(host_md->msg_cbytes, &target_md->msg_cbytes);
+    __get_user(host_md->msg_qnum, &target_md->msg_qnum);
+    __get_user(host_md->msg_qbytes, &target_md->msg_qbytes);
+    __get_user(host_md->msg_lspid, &target_md->msg_lspid);
+    __get_user(host_md->msg_lrpid, &target_md->msg_lrpid);
+    __get_user(host_md->msg_stime, &target_md->msg_stime);
+    __get_user(host_md->msg_rtime, &target_md->msg_rtime);
+    __get_user(host_md->msg_ctime, &target_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


