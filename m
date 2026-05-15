Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569EFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyH-0004iX-Ur; Fri, 15 May 2026 17:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxq-0002x5-66
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxn-0003AA-Qh
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:57 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dca00c1591so112150a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880054; x=1779484854;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RrguVS2mRJ1rnG7tfp8gdtbrhheg6nSgGQTNfMClxT8=;
 b=wCzj75BHQzulczpGRkga69GmwDkoeihUr+u6LSJQdvdAwj7h/q+8zEXyFGQrhNI60F
 9aYotjecu0aGxGIcmGYDg8tJWgjWncqBN5TWhyYERTSnx5xBOTDcvPuN8ehnJblg/OyR
 sNGm8QUNy/fAGSU526wHAl2DYcMAfmWxx6ZLanIxdSvRV+Q1G2E6PboMU/QiOko6Pbki
 v5FqxbVKVIQSy8+kAvMtUsnakS/DqCi9Y0fa1JGH1dlFc0LCp9DrBYB40g0dEW7HPfHt
 NZRdUG85mueMz9KR2P7GSzHLoAglEufMBuxZLI7A0DpaLPZSfzqIiD/fhcr3lI8TaN1a
 JZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880054; x=1779484854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RrguVS2mRJ1rnG7tfp8gdtbrhheg6nSgGQTNfMClxT8=;
 b=Eb0Y9xpUsktSz61WZ7nBFy1fQAcDLt6x+X2cqp3WzZxQ/Wd8ncDxJhTn4DyHj4cddm
 npCwkGKO3Wmui4Oq3Qhe/Rhwc+fIf3N5BGI4Ir7PzW2kLVPuaXULePOPRlHKkoGmXrXv
 y6oEflp8y3inC280b9vYK4iaTVkqIY/o8FxYIWmwTsAh2TKiTXIRCxas5SZXVJJn1PQl
 N7wduICeFMr8X0gAKtZ4u7IsPx5HEiWubq77pjRA+0Hsp0fbSi1HJG8E7pFCBb/ekmqb
 uj5K5HLVp8FsBlXMt2SU5oFnmwlriPujuulHuwzy1vlt/t0mEOTgb5xdEuysBSfWjqX3
 fvHw==
X-Gm-Message-State: AOJu0YwxpMhDGO9qnIoy+5kO3mU3sikCXrMzFr+S+XxNSG83Q5A5tMOW
 A+3o7gzESkeMhCF46VRtertcDTNUuK5frI92NXYLIcp3dDd2QBcz6Pnj0xNuaj1TOm2o19xz/mT
 MhrgShOU=
X-Gm-Gg: Acq92OHI9/Q11GVpB684W6gMsjaVg+8jOwDWHCFmYQIX/YyVNauIfgAGMomg7s/qh6v
 0siy+IlBxUTYmBkMuzpoT2AWZ1B3qm/OLRu65bHbQvbRLlLWC6Dszba6BNgTPJSETtKNEg4upKp
 11pMAUQpwm93O5E2xmonKrRceyuwZdewZ6YzScIA7YgnQx1NtQ9fUw9MpI0hjK/0SdAIueA2mvz
 Kfg4s7HcgbI7WK1C/Cc93edD2avn8SkwPZj4LMv/PeEkLJaVy4Ryw5egQN2bwIk4fNsgtgrLnhm
 lz0/MzmpZ0s2HKVKLU6dtNsNG0GM61WLFtxm4Shv33vquThOElomid8s3b85BwmAhVW2vuvSZeS
 iO0JOSly6q0QKtitL8tVd/xaDOCFIEeChx9foBCChVXZX3ojqsIE+PYa8JAHkqHzhFX8mqfMT8r
 yEamDp5zxOMA==
X-Received: by 2002:a05:6830:6614:b0:7d7:d615:3040 with SMTP id
 46e09a7af769-7e4f2b865d1mr3961895a34.17.1778880054191; 
 Fri, 15 May 2026 14:20:54 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:49 -0600
Subject: [PATCH 50/66] bsd-user: __acl_aclcheck_file should check
 t2h_freebsd_acl_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-50-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=wI5CDqmTpikk9GFJ92lcU8HxCzddz0RdGXIAsa87IRw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nHlgD7/d8rgCfFtpO36emrD642/J5QoMeJ
 k/u31+9Q9mJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 ALZuEADTT83vvQnlxTcSMPWxyCT6qXILFskzM7XZZcdxUDKVbw9Ks76c1oJoRvG9gWus9l/N1R/
 1GRf6wnV7guHFNuwjDAqvetN29JbwL2HuxyOsoOi7fNT9sBeRa/c3M7GEVRHCzNqs6vWQCJRaEZ
 Rwg58jmZEpErBSvB6FXiWY27cIDb2Wcesw0Svs//2rmK1BmjEjZabOwSApCy5qvPE0dy7vTl/WQ
 JBKWLIJcKtI7OYU8IQWyA27rx0lAi0efsgiN4WVI5IeHeMwmz3TIpDBIeg5fLdM3bF/rx3nLeYw
 t74h0SgRhQX+Llmvw5HyM0DW0XWOQbCI1jz3JrK2KtLXLmeQUzwvpRiUPoWXMO538rUEUOZRCfP
 ZacUJjKt6FUY/iQzzLYNU7LY887daXfsBIGA6sd36W+5jktt7Tur1TstfU3TUNWIk3Fb7A2L+1I
 eR4wMKYSu67qkoNKJo2a16yAFE8T8WtCkohCYg+FiFbj4rARmGOndec55C9OzuggdGPR92jNHMM
 Dk6wmJ/7WKVlEzufiz6Jl1gLkMITc2pLO+qM6AUcGcKMdfXkPmsEL7UdvJxJ/T7vTJCLPCuuWPV
 NFJw2F0LT3IxNutijlrK7OlUwxRU71JrurV4YSHF83cQ/Cjk168xeA55WIlIL5Ar15KpY7MCGTv
 bflhjvWdA71nOIg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Check the return type of t2h_freebsd_acl_type so we don't use garbage.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 0414a2e479..97c0f76559 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -407,6 +407,9 @@ static inline abi_long do_freebsd__acl_aclcheck_file(abi_ulong arg1,
     acl_type_t type;
 
     ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
     p = lock_user_string(arg1);
     if (p == NULL) {
         return -TARGET_EFAULT;

-- 
2.52.0


