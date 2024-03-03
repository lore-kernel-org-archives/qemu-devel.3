Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB78C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRA-0002Gt-1y; Sun, 03 Mar 2024 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR8-0002Gg-Ib
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:18 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR7-0001mn-I7
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:18 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dca160163dso35136675ad.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463076; x=1710067876;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MDPpZdzkFCU5J1swCsSX5D8I/lTikuo3763zNkmYNM8=;
 b=dKvhJnRaQacLN9Iwj/STwIp5LwfCRpb6Hzxq0hLGQ1UlbnSqhA4PiyFj3Jtn5cFqZL
 GfIGapSJdV/pwdswbUUkLnwX8MSTup12dwzqj5KBQSf97m8SwtSl6enOnMi8ivwjimGR
 t+gld7Al6wZB/sHCHMjEX7NYliEeUoV63z97FKndHQUbvY9UQCJmKmmg7UK+p9rpl7dX
 oXDCgTRCIl4joJ6KuPQp72mLjcUpROPTtb5DcPyUePzrInEkxGxJ9NIsScfrdpfeKAR5
 xx0bt0Pdjwsn/2lsaVRcEZ7AMWt+kjyewmrlHtT6T524E6tfYiOmeOB27m7kVyvy6TZv
 0yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463076; x=1710067876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDPpZdzkFCU5J1swCsSX5D8I/lTikuo3763zNkmYNM8=;
 b=pXRoFqE9CDydrXIPAm7zQM3eNk8d6UwLfkUw4KeaTZouMj6BAWdMJcHiqEJPHNQ3Ot
 Cw/766Q3mHUKd8gdMzjDMI7pg/XpCuDKvgVgG75AmjC7KGz7L2eJDaXVYaRmIiMP6Bfd
 pWTqOq8pDscjrgdYIrSphB0ErETCnhK3Od9J6TZ44A5mpToNGQGLbBmlDUNAbwYrnK1v
 7o16mWuubYvUiGZLq+mFbW2nh17m43ZjJbcbOOMvsRyiPVb9GQNJ2LeX5OoOxSCpM3MQ
 V52BI096hddLQbOVA/ENERyZXOer9yjy/Iz4HRZT8aRTBsU6l/dyzZA6RYgFtXjch+Kp
 GrDw==
X-Gm-Message-State: AOJu0YwDWouQy7yIXBqrjt2vKZZCLTQyEyEdTFXpexGo3x7++ER5NJcN
 WUwCZ3JeBqMo67w+T60ydeqjOGyge3jcizR4hwi4kHUg1zu12xtc6H4+LnX9gLBLc6MU0wIuxPq
 I
X-Google-Smtp-Source: AGHT+IHVajiJxUowtWrpP3NYpx/+EN/bjBAVRYuyrEDurRGn/xOzYR+hrGPvl2zYLkmq9Y9lx21QXA==
X-Received: by 2002:a17:902:e843:b0:1db:9a7d:2e6 with SMTP id
 t3-20020a170902e84300b001db9a7d02e6mr9807762plg.48.1709463076028; 
 Sun, 03 Mar 2024 02:51:16 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 w1-20020a170902d10100b001dbb14e6feesm6468768plw.189.2024.03.03.02.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:36 +0900
Subject: [PATCH 2/7] contrib/elf2dmp: Always destroy PA space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-2-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Destroy PA space even if paging base couldn't be found, fixing memory
leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index cbc38a7c103a..dd686280f981 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -553,7 +553,7 @@ int main(int argc, char *argv[])
     if (fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
         err = 1;
-        goto out_elf;
+        goto out_ps;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);

-- 
2.44.0


