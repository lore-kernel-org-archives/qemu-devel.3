Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A9BCD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphm-0002g0-3b; Sun, 31 Mar 2024 03:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphl-0002c6-0t; Sun, 31 Mar 2024 03:34:13 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphj-00026N-FN; Sun, 31 Mar 2024 03:34:12 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so2168180b6e.2; 
 Sun, 31 Mar 2024 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870449; x=1712475249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6z5Y0v6eGC54OE+cts/dJAT+Yj1Pwc4rTiSVsRg9/I=;
 b=QLKDn2gonyZWB0ydXmbk1c/Sks3aQj4QBsOkjOmkGwrg4sgbJ8J/9MzxHFLgcZ+RI/
 AnXAvBLCN/ehUkjW5DmEQAfwcn+LojgrEVR2bAczcxFJpk1L+DECS9vyPOu9+DTpQJ4Z
 4lsCUIEzYkE6S3Pfj7fYpEllpuPon1IEKXWrEOcUk93Gz45QPdKzuIt1znCOuY+me86K
 zO1BcXy1k0NijAKaFqJvdJ2jFjOFJAyoXJ+3hx+KxUSzXTl7Cr1gCXYjAcvJxEUcF8kK
 16gBTsYFrUbTnD1/jg9uG+3u5C1LYJ0cWJu5JFsPP4n5MoqAS2zVREnjVEgGqKGUz3z3
 u0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870449; x=1712475249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6z5Y0v6eGC54OE+cts/dJAT+Yj1Pwc4rTiSVsRg9/I=;
 b=AaKjJ4LXMeEgl1RVwr+jQrBAvfniZFgRKzBepmO5bxy2c3eLoHXLzBtnrpPOgx+MGb
 0VGRqzy1kggkRiL54tKGqpl0qRRHZp7NpEm9pzW6eMZlEepz8BzqJC/tP2kQulpq+2nm
 UAJYkSJeLpjw3GxGGzSn2PRDIeefsvxfOG8srzGMSc0hBNRAvP9ey+3hRvWNw+ti6Qln
 rJlaYidc0FPF3p705qK6HNKY+MTvh9jE0k3WN9hNWCtb1IS+mcSvVmb/5k+Yad/gHuJY
 59b/5XvteQODfhN2zHqpuhJ94VZ7DqR1ITzZDw4cLkn5RgUYrRq2ExfGPVDaVJAi9b7k
 qvbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2JpIpfyovjiTj0fALQZv3NQrjItIbLXQF3q3bdWYNuB5EgGmSZdCnPmhCW1+3mfqFh5qE2xYxhk0N19rWTXfvtk3o
X-Gm-Message-State: AOJu0Yw0XNCcr6ucEQj5239Ur83f4MHiejiZd8NQmQgzE3zwhP6blne6
 ZaCofXRtnlLoZVMV6K2kMgMn1l6CITc9t5vJmQU64wwtWSbY+3MZNjxTIM2Ghr0=
X-Google-Smtp-Source: AGHT+IHq9O/DJ0jpTKHGMUBv9wQEiR4ErXQmOFwgBgEUHUkhFEmlFtwxvOlq2ZkgqOTT3hIolomU8w==
X-Received: by 2002:a05:6808:2198:b0:3c3:c9cd:8c42 with SMTP id
 be24-20020a056808219800b003c3c9cd8c42mr8386400oib.36.1711870449354; 
 Sun, 31 Mar 2024 00:34:09 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] spapr: nested: use bitwise NOT operator for flags check
Date: Sun, 31 Mar 2024 17:33:38 +1000
Message-ID: <20240331073349.88324-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
References: <20240331073349.88324-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Check for flag bit in H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE need to use
bitwise NOT operator to ensure no other flag bits are set.

Resolves: Coverity CID 1540008
Resolves: Coverity CID 1540009
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 936659b4c0..c02785756c 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1511,7 +1511,7 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
     if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
         gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
     }
-    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+    if (flags & ~H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
         return H_PARAMETER; /* flag not supported yet */
     }
 
-- 
2.43.0


