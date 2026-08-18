Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6871C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThk-0005qN-CS; Tue, 18 Aug 2026 19:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThi-0005g6-7K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:50 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThg-0005LL-M2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:49 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44cd237446cso394005fac.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097527; x=1787702327;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJW1pLTwuH0t86bH48YzFfYCkbVwg260DU7bLqkOZXU=;
 b=I1pGz+ZQufrhQxbpr02vRtpRVIfi1b3VfWTWJLzqvDnDyj7Wx4RVXtk4gsXiJCWvU8
 O6CbC0MTxBRys7o1GEJxyBWF6DkN382g/eAshRwlziQSqiQYRp7gY0jp/u8RvPv4OZqG
 Fp5WKm74polqA/GNka7eFgNrE+l404WuzlQKGaUcoI9NFe1pglTYmwO52DteRCVXjBSB
 JFgsl4OLg0rzg9w9vnruoKSemRUGJLvcGSRiWE95a1npm4SARwAqP5yAGLNFb0fE1QcB
 3GeeeZbs9+I876yrUVC9ZAC1FJD0A8wP4e2YoxL4I9Rkm6uPJStHip2FnhREIC2nZZ8B
 oKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097527; x=1787702327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJW1pLTwuH0t86bH48YzFfYCkbVwg260DU7bLqkOZXU=;
 b=qK+/OTC3xMbbo7r7X6+lDW7MzwJi1JK34W6WNmQzUcyxStBSqbWSIP248gqN8EEcHQ
 V6mOjamx5l+nb6TxKBB+/DaAfhm76xwm5SsgqP7wTdUnsxAr80tkYRfO6Khi8Bokz38L
 ShAUX0Pd0lJIC1q+JbteRp8fNZ45672p0KceL0HRVQucQjjB31J/ccHNsAaby4owXCYr
 K8jNb2W20mATTkdBSQPbSg5FVTCYkFU8mDQoQysLMxOCFtazImeDRegh5kZUTKvyKnLb
 SchVtbS+Vo6H+W95peZeyfcAlVskkLrhp0vF4saLePI676ejGfE8l+1zdQDr5Ay90Ks0
 o5Hg==
X-Gm-Message-State: AOJu0Yy1smNL/LR2Pe7meky5n/buCPEv0UmAu5Xf9mBXEBbmOe+fZlw9
 ltsqHmyV8+mePF4s4YHzxmDqtrD9DbyiT0uen01ZTmdadtfhwcyZ0G124ay/jD0rePk=
X-Gm-Gg: AR+sD13ddxWrDz25m8w41sdYfah7uVBnFHkEVaP9kn6XLXXdxCf3DDB8KkM5YdT1yrO
 F6A7SUvYZhkTusl8fqyU+zYrjWyexglqvQqvpyphbV66wgdIDP1cMAo8+jF+irOaXd128FDMiL/
 fHM/hnDA1iuTO0Gw6xHnuSo5iOttFM9EDqDzhvOOoP7vTW1Vljo5X1Do9KIrErHGtSutiiPWRzt
 nEUbcsc9CmGnysvURnYbzAtIPIUXSXVGOJXHBPzSFZev9j75ClHzuj23vnw7s88jYOesh8urRDY
 ls+wBCH9j9rSoukLLmAiqumEypul6nt0M4FLPFPOIkse0MNbH/HKS+o121bYJ8i/5WRsKaLdlxd
 8RpXefK7mD5MpQhFb+moTm3r795QB/x/FmWmAvG3WVEDynNodQx50W2zgwPGBq2JUQx2SJKGscW
 CM5Z3pewTSf/GJzob1keG7SmayM4U5Pm0i6OY5z+uojSnqoR0=
X-Received: by 2002:a05:6808:4f54:b0:4b2:8ee8:8a38 with SMTP id
 5614622812f47-4b2bc475822mr428212b6e.0.1787097527584; 
 Tue, 18 Aug 2026 16:58:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:32 -0600
Subject: [PATCH v4 39/40] bsd-user: Move qemu_guest_random_seed_main to
 same as linux-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-39-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=WlvRC0WvL6l8+YYkFsDz555g+6PhNOds2e8soTa30oE=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFdqkvpySVN8hfsOA79dwD/z/Z7xfAbmg2Yn
 T/CTS1Z0OKJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxXRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCvcRAAptiGAprgirPS5pSQgc5ScOo/FPZy5zS
 crVM3OS7NkRlju9NMx8idyHXn9Qo20PgaC97lviaaNfhFFEtojbvcw6yadCLRIMnHgat8OuEWFy
 xNN6aLNvOYYjlO+p3Ju21bAfeEW6dyht8WCw9TcWdXQ3WcGpu1ivmUSVpYoEjZ/1aK/EFXlkoj1
 t0szTjddUykLogACpNaM9Ko4CbaVdB0DEifQ7AEGrbdmw3sNXPiNshyEf+OqzAFleNwWbyfoUL2
 Q4tHIRA0UNkGxcXD/Asd64lDkBvmtpNNZlsIsClQJpK0IPnfyjw3vGk+C1T2bQYfofSXwqv0PQ7
 xWTJfq3NIjDJi/mgKmDfLfBLUCdnmXs/hZbDgQR603PoFsGf4R/DhzYo+NaCO/1Hl64j7jYzZm3
 Egc21RXG/DeOMaW4EocZIMb1kpKy2p1HaLkA+pZaSG9uiTfnhmIcINAjxEDGeNm++vwGBVj8Ky+
 a0PPD87dmVErlFq6J6Unrm4kDQ2mPgUSVq4sUAiLT2Stbo0onU7yCncrzAHI9x8QhIPYoSxuNF1
 /cJi6lM8eaJ0sF0WkSZwHDbus+w7CrbEorpIxeNI0bGcFWLvHxUm/wV21uy1hvyBLBi+OoSUt9F
 ZNMeNIMcvGMfCenXA4Fxvp+/VBJTj2aAlalCN4V0meR94ueB8XBk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
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

Linux-user initializes this before doing the environment stuff. Go ahead
and move it there for consistency, though it doesn't matter since we
don't use it until later.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 2fbbfc3d86..13cd752b99 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -541,9 +541,6 @@ int main(int argc, char **argv)
         do_strace = 1;
     }
 
-    target_environ = envlist_to_environ(envlist, NULL);
-    envlist_free(envlist);
-
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
@@ -557,6 +554,9 @@ int main(int argc, char **argv)
         }
     }
 
+    target_environ = envlist_to_environ(envlist, NULL);
+    envlist_free(envlist);
+
     /*
      * Now that page sizes are configured we can do
      * proper page alignment for guest_base.

-- 
2.55.0


