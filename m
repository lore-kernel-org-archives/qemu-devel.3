Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53203C021A5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZuY-0007ve-8J; Thu, 13 Feb 2025 09:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <meowthink@gmail.com>)
 id 1tiY5F-0007l5-5o
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:12:45 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <meowthink@gmail.com>)
 id 1tiY5D-000198-Ai
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:12:44 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5450cf0cb07so710968e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739448760; x=1740053560; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lxLNETzfoF2TNi1qd/UMpr9bz81cwKQa7/s2UhKkFXk=;
 b=a6BL7MwmqH5JHL2bmPsJN1IMOm7x5El2YH6de81fIUSX30E8rX216Lty5ise6RfQbz
 WwlyNlDMm5E7vUmz8Ju/AIYuqTRTkcpQYerHhmD88cih0gbpE2imtlfrLS5Iv4oUGfEb
 eXLRLdepLyOqCiwHysxm2PeQYKzLuUJTWZmv02QdQRlUWgCnny39nCmdvwqjCSnzje05
 HuOcO8bICZk7uiG03EEcLKPc1aYUuhHnFZUNckodgjFF/g32T9a9qA0ktJ/WU78nBllL
 Lww/zTPZ3k99hvgxEdekk7uf/3MWOdGWaNA8qddCFKD/RYOdF6f7L2umeScB4eJ+Y14K
 3V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739448760; x=1740053560;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxLNETzfoF2TNi1qd/UMpr9bz81cwKQa7/s2UhKkFXk=;
 b=VjrskaTviJN+7jTp2xpbjyS6SBc9PZq60og7R0JSdGmrE/TdWdsaLGSUtFEZSNJTdI
 StoXBtR5Q66V9RGDelksD++mu1eg+jWw8gfdrMiost9VjVFCHP5OpkKwgOXkgbtqyYA2
 a15/MI1EmBgJ4/ntmk8h0wHpZGwhcRUihECBjwu6m773SKjCsZdxr8EjA5STB2GH13w7
 3KHsRNC/QTIyXPykNKMKinrLTmL1VhdiruismgF2ENh+n1XsSsEmYJIkcqGPflfRGfgt
 iLCdnoJzYUJcfT8NF2IyoW4LZJ0IkQ5WHgM1xMa6ArVQwCVT/3icidUwSGtuKtHzcAJU
 91MA==
X-Gm-Message-State: AOJu0YyYp3nr3CE5iB8Z5nisuDLDDJSC8BV3JNq4OI3rvsHoxadlniqr
 qJOjR+i9DUYR3B5KCXc6Ejd9CqiwYPg9lDDHNKVQh3yJu5bPQnUtY6PlrnSfmvatceuMeI3IWKv
 N20dO4LJ5I7ECGHjUjQDcZ3ihOz+l9mRH
X-Gm-Gg: ASbGncs0S8yxPWZSEd9361zIKfoKwT7IV8ivJ6pVO8AbYH4y1l1r5PMALFUa1YWCado
 16DZmUwT6gYbO06xRNUXJcFkaQzuTgl+/MlgBrqVEHZ9yEw6RFkASfkXWFv7WHZfn4y4ZsSL4og
 ==
X-Google-Smtp-Source: AGHT+IFniNnFpcAPTSeycDLvYaIjh8qi6xLHYy6Tp3b5zW33mIH3XZE+Ier+7mMf3jefORg0VrN/MK8LhfAcr5Ij9rI=
X-Received: by 2002:ac2:4e04:0:b0:542:2e09:639a with SMTP id
 2adb3069b0e04-545180ea26dmr2065406e87.10.1739448759820; Thu, 13 Feb 2025
 04:12:39 -0800 (PST)
MIME-Version: 1.0
From: Meowthink <meowthink@gmail.com>
Date: Thu, 13 Feb 2025 20:12:26 +0800
X-Gm-Features: AWEUYZl6mDQopNWDMq02U84VeR9wEbm_aIpnlS1Uh_x4axoTIkDITOQvWyHlL1w
Message-ID: <CABnABob99XZCBwsWYQKKjT3aMWzodAzmTMM6AB7utVz_un_9gQ@mail.gmail.com>
Subject: [PATCH] bsd-user: freebsd/os-stat: fix getdents(2)
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=meowthink@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:09:44 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Syscall getdents(2) has been historically mistaken the pointer in the
loop. This influences aarch64 python3.12 built by cosmopolitan
/superconfigure thus been found out.

Signed-off-by: Meowthink <meowthink@googlemail.com>
---
 bsd-user/freebsd/os-stat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 3bdc66aa98..5e14331e0b 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -475,6 +475,7 @@ static inline abi_long do_freebsd11_getdents(abi_long arg1,
             de->d_reclen = tswap16(reclen);
             de->d_fileno = tswap32(de->d_fileno);
             len -= reclen;
+            de = (struct freebsd11_dirent *)((void *)de + reclen);
         }
     }
     return ret;

base-commit: de278e54aefed143526174335f8286f7437d20be
--
2.42.0

