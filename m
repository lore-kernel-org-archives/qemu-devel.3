Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1793BCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gp-0002tP-SZ; Sun, 21 Jun 2026 00:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gn-0002sg-80
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:45 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gk-00051W-NL
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:44 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a0db321df5so1689963eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015701; x=1782620501;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i8Pi8kyErJNzT7FzUGzu7gHRRT2l3zlLMMdTDg/Ha0o=;
 b=VqNNqMTtFVL17UxKI4V8JYhkJDkiNAW+9KsNnrcznjVTKSBQeOmp4Dd12sR+qurYLv
 Er6sIXdSnD3aasA0LUnD8tFbkDHj1nRBjQuRYbYJwE9eW0X5CVf6O/3e+G1kyWdPkYsp
 TmrLAxLTUmLuxAwp8nhAskjnD5P8eH39O3sneV1ayF0XTefBecJwrSlFO/fvqLE/Ta6M
 8qIuEwW6zULkVzgYpq4vZ1NqJ31HLNfMIB1dgjLDpIc2kbBGZB2JJJ2CsPQfoV1RaOho
 4dMpVfjpQJcoxCL5nCJQDtbPgxAH9WBS2crpGc3pxISz4EfKgmRsr5Z7/vBsh0G7Y5Dc
 CWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015701; x=1782620501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i8Pi8kyErJNzT7FzUGzu7gHRRT2l3zlLMMdTDg/Ha0o=;
 b=N37/eaLsKFjext4Ezc8GZbpKJ7sEnXWypNYv1RQnCFZ+KDMaPGMXuyk8SkWZQM6RT8
 JcxkaZsLzcWOr61SHOkEWll8f5hlKvAnyH8zl6MVeQ9nRYbmDNfr5Zm18o6OZJS+d70U
 /BlcX1WC1hEt4YMpxBGLmGl5YJ3LIpH0thCLQ759sdkzA+6U5y7YNUt6gBQhwswD4tw6
 6eN4RLeoPUPzse4Q49Q6RvpHIHdyl37xF8MHWfJzWftVwtMCg77vmFxarvO+8Osg64oY
 l7truEva19QpSHxaEYnxSRwSxJXsUvlYyRQ7ckgfPfT3S0mhCbqXWHu3spr9lRwGxSQm
 aOVA==
X-Gm-Message-State: AOJu0YwR6AwU6dCFBKAM8Lsvwg+g9PYHQ72QwrBzgFNeuWxOMt/MwH7/
 VG5X/1pEhNrx7fOSkaJcPW3zlkxQjRIqtsCI68N030XylXGY8DrjR7Q90RfEjt87wXc=
X-Gm-Gg: AfdE7cm4mMWCRM8XSlMla/xm4XCONAgtI/zuaXuZFl4fjH/ieojE1sn1xfagIv9DjmO
 pqhlk9uqTvOkiW5KGq6Xv1bmTdLx4RJ2e1g2wmViG4LkJJlm5AAgVTWrbreRz+JaP7juZGzcR5i
 /nou4t2HNxkc/v8WHWkzevESJb0bhiruVNErEdzyR1Oru2zFmoRi1iZYdbAP7cYXwmn8ErtzLx0
 t9pbO3/1JXp3+k/56frAPIt87aq+ttvd6gihk1j0tEqt5gaOOeJuTDhNvYCXEqq79Ct5m8ju4GX
 RwUEBIa44WXwxF2Shu5ONfxKnfNJY/6pUV0s0mEEFcQtBqi8zIaoFcoEkDrnK1Ub2ELicocZ7nP
 fuqmc8ux3xIbpRu5IMQYIhIv6efdBlySBNfRDxghIU/KNGIX+Nqy7w7VFxn9lVXfn99Wy/6T01e
 g=
X-Received: by 2002:a05:6820:1746:b0:696:2b09:5988 with SMTP id
 006d021491bc7-6a0d8d13ff5mr7219347eaf.40.1782015701523; 
 Sat, 20 Jun 2026 21:21:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:50 -0600
Subject: [PATCH v3 03/40] bsd-user: Fix copy direciton in preadv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-3-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9tnBDxKpznGCAZTCU65N4cpxt2zZdrlO9GbM1GMBpy8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z98QKiFiTE6hnlQMcAmv/MtwTLwXKdoRDjD
 mlyCpQToJ6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AJ8QD/9ZTIz9W79gUcSrR8c/e1SUNYFpFZ+qyBT7DwGFMwd1BALy3U5yAoV2gp5SnCfTAiVrwd/
 tyuTywujCQaLMQOVhnAMyzt11rcIjxi4bIY7/32MyQMdTyHHfQh4bt4AdOxLHlzrkpaQ/pCi2Dv
 8Y6l95iXawztbNtVwGQSc+k+ypzzKdCJz2LqKEERbmNFBnzESptFSckRlEbeLSrwpRV2JHwOKMl
 vkgIViryN10O5PggjCugE1DMNHkaGlwJFcALE7FbvApufEH/KnwvZSAiUwRPw3of0/KnsJSvlvx
 vtyIbzsG3L1yCdcJohM+gMDbdFc/zAQOXwO6PXIbj8EoFFIzwYgnuFusCTy/awZQ51wJ45r4a/R
 STPxHYLYChGZZ50w8NDWzph/fQEdehWNJwJ/nOMuKjWo/JlmXqdmen6tADwyITW8fuAh4Kdjs7K
 oi/pVCWaBe136O3aiE7XP2pJmqXICrxAhmmVMGaUEbY1vsGLpqv1XcuZBsnmeJi3qDMRl6erE6B
 9weOSGITjHwacmSnsCVQRkoCKOOWV/l1/PNEEWpvq4z5mahadGIwY5YYAe8OqgtOdgrhsRohvav
 ER8wD+XB9p731hLAvhIrWzEYgrZVlPuz79pXfMqq85jSqI+TGs0yb0bPXXF/BdCaJdW3hm38AJ7
 rN7LicQHn55nAVQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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

As written, we copy in the vector and data then don't copy it out, when
instead. Instead, we should copy the data out. pread and read are
already correct.

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
2.52.0


