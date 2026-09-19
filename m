Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B47CC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yEu-0002m1-TM; Sat, 19 Sep 2026 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEs-0002lP-1v
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:35 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEp-00088p-CP
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:32 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae740487so1058434eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836510; x=1790441310;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nLDE8rSQgGkGSmO1rhlXeHCgMm2I4kYbhowtxMdHM6M=;
 b=ca+3/bysdOyhwpauEd6swzyMrVW+JLMMemCG/S8diKx6NOfRCuCk8+n6QjNnT9a4Om
 2dPntv8/V4Ww3Utdoejjffk4yGZMfAkD/JGjzF6KCDuIZF117nYuN+wnooZqH1UqJMu4
 NxySDhIAqUAZtMNXxncN/dSp+saYYyK7xaX82cZIjoTXS2hNUSlwTF1j5SfhseX0DB9d
 LDaRIqTNSZ6K0JOgZExEUQvJIK4+N7AH8nfG+FC2TRt8tzP6GL/6FzqYk2/ZIVjdIoh5
 BluSNw/IdaDnCbWIJkx0i/1+3Co77zy9rO5C/0HVIrz1TVSGtWSr2d2gF75r6MCqQLOq
 Ireg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836510; x=1790441310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nLDE8rSQgGkGSmO1rhlXeHCgMm2I4kYbhowtxMdHM6M=;
 b=FFNczMun0AvE+avV1xC3xLOr5y9fOYsn8tWKOlHh2Qnxr6/YKdz0BqECYvUcqf1I/q
 wJK3EWMzhTZwxVz23zEWLfdIp/3qOVPU7S7IZDphfY+0JDpYSWLB1FwfCRE4jBMtqLK0
 RROnd73n4zSeROwD3ObOCnw9pkUhA+GupcIgRsIvQLTx7mMF+WcH8eJPXTgVeW/gQ6wu
 JC2RHznbg2yT6EJraipLf/8aoUDE9MZHiY7y24IeLqiYU8fTpG8UimeA9ZwBs1CWUDrO
 ps9GrwEgwaZgk6mFCvv/sOx4n8F2y3NOU1PmCBYGti0jZUurtw8k44iMNqBahtHXBHnc
 WLwg==
X-Gm-Message-State: AFuF++nie9HlHpqVR9o1aec3j7kzCY9lMMspq5trdxaBOos57hHqvkrH
 b9jupmzYIDGcYOIuSw1PS0sl/FUJlzqpNHyaQneUXrW2gMc2oB+95lK37qnDl8H78Tyz2ZoQ/s/
 MC2+v0W8=
X-Gm-Gg: AYBFou3jx0C1WIm68tUh6qfWUeotivBqSnLHZ02g8B3LVcB1OTidvcHByK185Aj+XIz
 sQbdiIrkRVhp9oZAQMmmQQC6KvaAK6DEfceQLwEG+k+Dscsus4OYWHebzld3RuSKJ9TiuSQ3/E1
 kT7ROdKEJW6Ri6cPeiJQXJf+JxMONiid6+Jasq+pMMrRMOjZdFSFEHYnHULqYgaSOm+2P778YL8
 dsX9hJN5IVjKvaH/09D6iKmnEBgtdRF28dFzdPCIGpd+P5KAer0o2J4CzgoWprq+qhl+3tZQ8XB
 yED1wi07Byk22KYAn03uHdaTWyoktOb2MCoKvMXdNxXaRB5TDVml1UkGFfCmdiSmxN2Ot4TDCFW
 HL1GQnPXkyGtJBJjTKbPZ3GOCejopQzWOV2zcXCwh1UzYSJPFxZgA51jplSl7rvcB/tlfAppHo9
 Le44TsCpUbbhbyuU0v7V3vFNv1fdWkR4//y0Xp0saHSt6xJ9wvObZpCOhMzw==
X-Received: by 2002:a05:6820:4cc6:b0:6ba:a5cd:aac4 with SMTP id
 006d021491bc7-6ca9ca4bc44mr5523934eaf.50.1789836510271; 
 Sat, 19 Sep 2026 09:48:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/41] bsd-user: Fix copy direciton in preadv
Date: Sat, 19 Sep 2026 10:47:31 -0600
Message-ID: <20260919164810.70151-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

As written, we copy in the vector and data then don't copy it out, when
instead. Instead, we should copy the data out. pread and read are
already correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index dec59bd80b..7ef9470c4e 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -113,7 +113,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
-    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 1);
+    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
 
     if (vec != NULL) {
         if (regpairs_aligned(env) != 0) {
@@ -121,7 +121,7 @@ static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
             arg5 = arg6;
         }
         ret = get_errno(safe_preadv(arg1, vec, arg3, target_arg64(arg4, arg5)));
-        unlock_iovec(vec, arg2, arg3, 0);
+        unlock_iovec(vec, arg2, arg3, 1);
     } else {
         ret = -host_to_target_errno(errno);
     }
-- 
2.55.0


