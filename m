Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD154CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyL-0004sX-Sa; Fri, 15 May 2026 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxz-0003BM-SF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:09 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxy-0003Cf-Cn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:07 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcdaf06498so206138a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880065; x=1779484865;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doWUqhLZ0XkK2oAH1laIExT1sLr//X68uA6DuBdHRVM=;
 b=C4r9tTBnONvrCrzDTUMCwDZEoZWTukfl0VLDPgj9E5R/lSabweAxeVTf4v0b1csYKF
 xV5ZT3tgnJwjDrb1IuTrdyqBDgltngfgXLQ29vFIbjmrt6N/Jx0freJ7v6HO8dh9Uhq+
 zIhlmEQhjqGFvanvVEPOpi9WRdiYZBXWJcZ1rdYJLatK3HYitp2QMhnVapzOSvn3s8pc
 oiFyTp0cHDouZYxxTpFRQbBxqRLp2bVWGpQNZdFPLGkvV+cTQNxceTmZXEolvunJ2H8e
 hJbQXPBcyP3yxnFrhKm3E55leK/M7Zoax4bOBn0s+BJTOTB7DiWMsy792ja3EUNGr8gK
 8HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880065; x=1779484865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=doWUqhLZ0XkK2oAH1laIExT1sLr//X68uA6DuBdHRVM=;
 b=M13FFpeQXnApTEpUhGBRovNQjidQq8rGzq4DP0CuwFAL5ZkxjpnsMWgq4MneWq08Sy
 OUnUw4tSy92fkr2g0bJoziMQpGv1UniwWQ9nvI1gnTSvvzYeYQTYspY/KBEOugAqz8M8
 30xNoyHA5LL+PoN5X3LOrMQaM5RJ7LIVzhbCM2NwSycypPjmCSmHa4i28GHvVn5GQHsX
 flzhfY3LdmzVSta1HJFQliXIZPPCz5QA0SsFsPySP8YRVqTz9P9f8cWxFOTn2wxa8T6d
 vnnY8/XxpiJwB2gcVVJuOS7hRqHoV9tPZaaBrVMzhlVKG7YiiTytZPivWWcm0EmOdiEY
 Vvpw==
X-Gm-Message-State: AOJu0YzK+Oh7uCxaLyhg/ty2waYqANjOiyiHptF8bOx7gTElcMgkVxxU
 4PfFaDIXVnmkoiKM5ayCNejTd2/kIIZGeKo4STNT8P0trtOc8Z045ujDaLM8S0bUB0RSoe5ORja
 SOddZYHE=
X-Gm-Gg: Acq92OEb3yrHpRDw4HFkUXHZtkRjimTGqJQzOCEFEOTkWb4E4Alfso5xe+mP2E3nscI
 ZKw9igQJGnoDSBE8QbyOz+D+184D38zbuf2ldg/6PQpjLjT/FGcaENgPYljgpPaaTquh7P6sA8t
 X8ZRQ4oiMrmZ9NxcgIQPPc6Mlw9//fx68AJWLe3yuGFjzsZDUOEF0TiSHq5gmgi3s/DPr3mT6aB
 VU6o4hOjLxrRY03bd9aq21CDkSXRLRzs6y3K89/R8GrBW6fo0kfL1NimQoajgMYH2ijBDAlCGuB
 FVCrwxYpINkp5fimssZaASMUXIwOnyf1gmR50jzhIYsrYP5A9nvmxB1djdpXp4PsfJ3UfL8y2jj
 cWIZLpjUzzdM+Jb/H/PEETOxbXwW/W5rKG38C6IdQ9Ls4RuZcs7qVmlKYrHsYLhJKyRZekP9avD
 uEjQZo0c6xZA==
X-Received: by 2002:a05:6830:6f4b:b0:7d7:d0f1:a132 with SMTP id
 46e09a7af769-7e4fa0455d6mr4225338a34.22.1778880065089; 
 Fri, 15 May 2026 14:21:05 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:21:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:59 -0600
Subject: [PATCH 60/66] bsd-user: Don't leak fd's when we can't writeback in
 do_bsd_pipe2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-60-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=oM10BvModYCxqmK+8TD64lP93U/kbr+8QGoH/74327w=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43olNGALQV7MprBXXzERtx3K/LHoaurjKEHT
 g2q7BE4g+qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN6AAKCRBsHNEofbAR
 ALPTEACB8dqIskijP/QvKpplubFZFV5qfYnggOlAtndUGOjfapbmpwU9TMXq/5PDzIQXh1G60aR
 gQGvsB4NOBgiG+FazsoRpuIOuaaRGDGXZ18IHY7mFIMnuDVG6dKQJzTIlEYFmCJA7D2FtCYGHP+
 VQWIqBMM2Qe1gWVKPE0T3191FRmjd5OmxyG5dP08oB9Xvvu5sZkjtXtxN6728B8OtuNDpaZj3GT
 /cJ9mX1lDb6gh3cMDhdfPtMUyCX35411yzIFHXJ9vBdejGSUdXKxitNWzbUfY/W9OYohQqJ3Bup
 jYCRvm48vloCt2kozURDAa8vP74aZy+m1TEJh9f9tbCsEAaTVW/JP5RbTHWNug5g5fELCy+d8Y4
 jhOTlUlXTuCXkxMQ0NdmqagPrQaG2UzjpH+Sg1UNhMdOJLDxWGLT8tr0JUv+0iM9IGvYyGo9cqm
 Q1Gfzs+YvvCP1f2pLbnO9OKUc5i0MVxfSG1VuuV0lUkBXl3451UskstHl88sRNNcBOuk40j84xg
 I2sgoUG4P2cZSYF6ij8avMblS8et5ciNS7gLkPl7WwHFIokXodftYTHJnauAE3Q8K4D9AGghete
 KV9+bvZ3VAMl+G+QnnYo1NoX/pm6OdRUXtG0SiuoFdJmXN4H1rCQqSJdGpQouGW+72dcj3PdkBl
 oozMQ55KSYvijdg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

When we can't write both the FDs back to the guest's memory, close them
so we don't leak them.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
index bc31064a50..aa8d8bda74 100644
--- a/bsd-user/freebsd/os-file.h
+++ b/bsd-user/freebsd/os-file.h
@@ -34,6 +34,8 @@ static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int flags)
      */
     if (put_user_s32(host_pipe[0], pipedes) ||
         put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
+        close(host_pipe[0]);
+        close(host_pipe[1]);
         return -TARGET_EFAULT;
     }
     return 0;

-- 
2.52.0


