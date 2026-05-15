Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF205CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyC-0004b5-EW; Fri, 15 May 2026 17:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy5-0003g1-9B
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:13 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzy3-0003G1-M0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:13 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcdaf06498so206182a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880070; x=1779484870;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aD3/gY2TQlala6Osa3hlpop/kKt6yv6iIOvXHix6Kvk=;
 b=06hJAyiP4c0bJt3VmB56jlV4RMD83neGO70AqRYvo08/c8Mb3/mYLXr7bFLGJvTF0U
 Z9lDTAIHSqjWIDIrQwPzsLqt1oYqvhNJnC/d4uEL/GqVUSdLDpRoA0EmPMWvcQ/Q3pSm
 jhozoKSo4nXaYxaL84pGz+91C4kQkL4k+CwVBQoE3sL38vLIhRKo2NBKFVbLgRcRl7hY
 /qqcvn0DVLVG/Maqo6jKbYlKhJNGGDnUCeWSyAc/o2c75er9F90dmg7adu18e7XprZZa
 ROSAYd2RTfUUhssUI748MIs1YFI6Y0JTi/0KNdGE9HWo2Fwq94bFK35bkferVCR8CYHx
 UR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880070; x=1779484870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aD3/gY2TQlala6Osa3hlpop/kKt6yv6iIOvXHix6Kvk=;
 b=XyK46G6oTNUJtA2YVFMVfoz7Mcg4jhdvhSdAsQpsJJ4KX+POCNhaCU+8rwnavvXnfb
 Mu2Kmwp0yQ7YdapRfoGYqVai5I0eGMh8HTepDC3R3XpXkX74m0zxO7U48KCuKwani1ZL
 so0rl7nTc337+qgTuc2qQHppEDoT1XjhmzMbE8pX8u7RmE5I5OWEu9o28bMmniTHwsIT
 wosrL91pomRNGsa8joP6JdDTVtAdSy2DTX/FLeOF68dwY72AQ8wLD9hsEYVHhzMN9d6u
 ZfuKAC+D4O6msg98UpQoEue1Za2CZacKAEUNe+hCLWnfWiE3fHt6S3cQ4c/5511d5+nb
 MeGw==
X-Gm-Message-State: AOJu0YwmNox4kCp5D3j/VNYChUraZTv13sFL4AC/LRNJzz45pH9Z2mur
 uvtb2mT90FKX1ifFE3/DArdUKFJ4WRho0PF3uyynPIMtawjPLZz7Q0GgOK1C2CBueJMaat9EPkh
 042G+iN4=
X-Gm-Gg: Acq92OEqgz61cTo3ebw+a1bZczJYvbWJv91sLwYihuW8jquF1XfONdR+LwfmZ3leaTT
 kg3/NaiV7FJx+iKVHXEUzrf14wV4TUxA16avw7AtnhuMsh+wc0C3Ok53W0Z0ByfLBUG2xoVDQQX
 bBaOH+OvwC5oNCx/EUszEBZan76Gbr9TG1fQXkF70EkjWCnmTsbu4PX1tSc4BmHw8Ncko1xZ0SF
 s1Y0VPY/8fR0/cs8JgykjjomvAGWGnW+xYfbVdAxQCepbVTv49OiVmXIP4yzpouZ2D28fhYDg/1
 xnjU0XR2XgfXHm9jCe7E3MsGez0WAcGK29tRpldQEL2i5CdNyaq7MdxKPVa9NL8yUZ8cXlhPa/J
 cP/yvpJEJJw5TWIuqJIGPwBOpoq6R5ZbCw/8X55JHpiYxkhmzsfdFkEagWIc8iHZDrPjJmcLsWh
 8k2CtKDSf4aw==
X-Received: by 2002:a05:6830:6017:b0:7de:c87f:53f4 with SMTP id
 46e09a7af769-7e4f2b3e96fmr3791516a34.15.1778880070332; 
 Fri, 15 May 2026 14:21:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:20:04 -0600
Subject: [PATCH 65/66] bsd-user: In specialfd, we need to copyin target_eventfd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-65-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=tkRSEuvAKbcL4S51GHOcEnMrv89VGiUdfq+mIx3htAA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43oYUaqZAvHhIjigHFuScMiSqM+v8io94a1a
 N6graQ1p6SJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 AAedD/43nHGgTq7jJju2eAt4Z5hpsASW5FM1EZZMuYiAGh3Ms582lAsKSO0G7ZJ8YlizRoUaEmP
 Utg01ZawH/MBYd/bj01oB13dnNgO9S770LuhWFGCmp4CvhugzzKlLfz2xBWGsFQL4iPtrO2DkKe
 tVCsCWO6hcywVcGHRuCHiVuQhXUe6tNRsuh4y8Cpa5YGIAMS1DzqnK9jx2CoYOgd6ZBJwr99VCJ
 k7Qiu1HU4GAjzDeOy7BMw0nivpaUgXfTNXdkvQG86o0LRvu9sfOFh3SXw0p5eUonSHnPsYXn1Vt
 pobrfv7JsgXzKU8xBN+HeXzipoYKxuO7Oc+06WGV4SwyC6szml6HjUV4ssrwFmIRd8sIvbIQ5u5
 l52TtPZ4K57VMk52ztZXaaYqKHKBK+ntv6JnNBOcsRClAhUH5wgbmcXPRQVVGrLcQncWr32wrme
 u1cVem0W38TaGczgj75rZgamQABOR2v2sV1uwl/bfc8DsNix+lZJ4/fvIDJf4yXQ30dWrvN2SVv
 Et9T1ZGdbHFTedZl9xk0eXGmCrYqw9WxYjGgM9JxWFEXVKCmj1QA6670TOfviWeUGBMiTmjwpOs
 UA/yUatHCFTvFDy2oQ5d6Qep3nv8PwnIoG5cPKb7XuUruS2ye7ANgGUqLEOylu8fXUu27+CqQQ1
 GDUZb+BOMpasFQg==
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
index aa8d8bda74..ea15ab25a1 100644
--- a/bsd-user/freebsd/os-file.h
+++ b/bsd-user/freebsd/os-file.h
@@ -110,7 +110,7 @@ static inline abi_long do_freebsd___specialfd(int type, abi_ulong req,
         struct specialfd_eventfd evfd;
         struct target_specialfd_eventfd *target_eventfd;
 
-        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 0)) {
+        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 1)) {
             return -TARGET_EFAULT;
         }
 

-- 
2.52.0


