Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12DBC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yI3-0006a8-2X; Sat, 19 Sep 2026 12:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yG3-00040M-Pu
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:50 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yG2-0008Rn-E3
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:47 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c197ff1f53so858776eaf.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836585; x=1790441385;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DETv+CjgZyBFHWbhuSop809p8a2VDLtxX9l7nrrCw0=;
 b=WdT6c81Fzhqsx3JhLJHvPjUid/6cA/SVxR5MohdbIzNJJN/iN/aXx01IHO3MnCAouE
 U/9YBWFaZLobTz+xA9JelW0BwVKgXd3qi3nk08+XA24woTaYSYyBzXpdlvCetbG462+G
 slAzqPZvtT6wYOSLOQmmaahTi0nYRx1H0OfYncvuklmclMdqy8sLnaY/gw3K5H3+zxrc
 SZ4qDnVhWGsM5yVbBYJtCSJr4nC7RCEWZKLsT3jekRffFWU8x1OqrWreWeXdWSvU3f97
 baJ+vVi5NtOIv08OF/mMiSNDsQzYyK5Ee1ibz9TlvhVhbwEbBRoJL/Fn4nhZdkSVHhrO
 UgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836585; x=1790441385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DETv+CjgZyBFHWbhuSop809p8a2VDLtxX9l7nrrCw0=;
 b=Bo0qihdb5AD/EOJHw8kzzfGg8xFIXleA/bxaQVxisP3+H8HdTCWLV76T2+CD8mcqhX
 qcShTlqBAP1cQmA2o35hMk8129/Mtmut5wMm4AnoAyYbZMpUI5d0L7zWW1U/HO0mEyIP
 iRkfKca20CEr71Mi3Ug0VlEFcsrnt3/lGQGVYigAyItKWzdoF28PZ6ItsLuMMEJXRkQK
 EmNZku/oGJ+xGGR+sBL0ICmmo0zj9MecmddrXAenjmig1CSNJl5SMMQnWOz0gii2Ld6A
 4MqOp3ts5TOU5Au7L5l+IQt+8z1/z6lK6R2K3DKoJcVvwAP3aGxBQgzjnMzmT0Xo87ZH
 IHwg==
X-Gm-Message-State: AFuF++kSxf2kP2V7dqaeJ+etPL5gXX5AQbw92oshIZIlKxG/lSGESNNL
 iN8hsFiGmErJz2Rfe4H51FEP4VvLxMdTOFK1zxcW310xxpWtU71G8zC6liKnDSio3+WqhuGtxY1
 c7pa9MGg=
X-Gm-Gg: AYBFou0vmimkfEfj+zL7D9608vmZNIElBQpRXR4MFwj8Z3dmwnexEguoWxdUS06phmi
 HvvqFCHYyEPgDWDnrN46xlExV4AeD9b9gpOo229vkQoAhgRI4rtZJU17wQxE7okYm47UrJeOOoA
 xHMNW9pyoICGLpFPRHcW8Hx4c7h/UdSKDYypNhle89RXNbb9ljbhwbSENpakvpPes7JoVgIAGUS
 Z/s1M1uGiAL3j9xkaCVCGT0Ic/yZmFsaBaGzi6jK4Wdpj+wI2mPvO5gCJLCl+8QnbrQ6lMidN+1
 epHBk6ymv+f8eBjjtC2v26dwDIernA8qpMiHP2u0mCSKp7/YwHSMUzKWZm7DKwSr67Zu21cq1bB
 MOuLRfrElLv8TL/pnigmnJpsAcNsRE17/D/aM0/r95nWOZ6HYnBhcZS25f/CLxgaUmXbKOjiDcm
 Apex0kCBNbayshdIdsBpkjFQpUg3u0nh2nGC93KqZQntDo2+0G0wzDEIcCuzqa82cu7Crb
X-Received: by 2002:a05:6820:188f:b0:6c9:80d8:a204 with SMTP id
 006d021491bc7-6ca9d55d764mr4881599eaf.65.1789836585344; 
 Sat, 19 Sep 2026 09:49:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 40/41] bsd-user: Move qemu_guest_random_seed_main to same as
 linux-user
Date: Sat, 19 Sep 2026 10:48:08 -0600
Message-ID: <20260919164810.70151-41-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
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


