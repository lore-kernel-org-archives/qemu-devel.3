Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7841C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsY-0004vD-PI; Thu, 07 Mar 2024 05:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsX-0004q2-PL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:33 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsW-0007BZ-9a
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:33 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so376135b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806891; x=1710411691;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+hvr6O3ORvjAgJg+6YyeFVM5M5tHwrDPGaC/yhxpOs=;
 b=edEN9G8aIFLBqHy1kI+n9Vy4Yxzd0XzU1jwxcbC7Ccn1qOZz7Lbg+tGoEdD9QOWggQ
 Iw4QxyNv2FrdNnTtbSkQDx/BWS/9TskUtwbIj/WWGeTusxni8bXxCpv7DpqexxbH7VXN
 BsTk7TMsbtebn+8y0oac8vLybB8FAAPuH57Zdp3YU17xqf9UccxAC7czjEGxos4Q6P8x
 +mjaGXlI2XpZs6nlSYPa3icBjYc2hhVqs6CzacU2d4uazNhB2YVNwiaNOUkdEjNoAvQs
 NyigP6nxUr2cu1u3Tu2lETfbS2O9x4hQ8zpXZyZFFssKdx3YsJZTn0gXYKquB+YcQnZa
 aM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806891; x=1710411691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+hvr6O3ORvjAgJg+6YyeFVM5M5tHwrDPGaC/yhxpOs=;
 b=KoZbsVMTDqXL8A1mDBydv9WhV34nEi9NKTU95bR1SMd7envQtyHi2fVNZs1Ei6hdLH
 H76ltEIqxsoTm8txD/O7KbtyZ8lsZFwH3wIuX5wJqB7SjV+HxIW4ZUAouYySVyb5DrM2
 g3rAqdRjxTBId+dhGfVoonR4ogS/4+gVhmEL/YoCv5T++5K2V1jZxBLZIDdXJ9Y9fwuF
 KvKWDciAb06OHbV220ti5phLjajvw2JYzWsM8KbIJbRI/4X4SuDq2fha9EEryUqa0GKp
 0R/id0q2bMS/E0ODF7Io/BOWrW5P7LlL/lmRYWW9sshQVVCchfJ6aBdHEW6y6CfjHA04
 9rSQ==
X-Gm-Message-State: AOJu0Yz9fw8UHKZe8dv6MNo6vkfnGuO1yTIEqMz3dYE1wxXGXjhdDfiI
 mvh5mnNKVDHWvlMC6T3ihueixXp5Jnu/+6sWqDO3oqKPsuUHe7CS7/1JLmlia3R5SztWU+poBiQ
 X
X-Google-Smtp-Source: AGHT+IE+5K8qNDUXcyBZ8B5kfZtu1smKEb2NTTloy3SIIj84alLgPs4HIz0J7yI2piRYpT2ixl1Kkg==
X-Received: by 2002:a05:6808:6297:b0:3c1:e999:467d with SMTP id
 du23-20020a056808629700b003c1e999467dmr7439216oib.40.1709806890801; 
 Thu, 07 Mar 2024 02:21:30 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 u23-20020aa78497000000b006e5092fb3efsm12237604pfn.159.2024.03.07.02.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:54 +0900
Subject: [PATCH v4 11/19] contrib/elf2dmp: Always destroy PA space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-11-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9347b0cd5a2d..32dc8bac6a30 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -549,7 +549,7 @@ int main(int argc, char *argv[])
     va_space_create(&vs, &ps, state->cr[3]);
     if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
-        goto out_elf;
+        goto out_ps;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
@@ -634,7 +634,6 @@ out_pdb_file:
     unlink(PDB_NAME);
 out_ps:
     pa_space_destroy(&ps);
-out_elf:
     QEMU_Elf_exit(&qemu_elf);
 
     return err;

-- 
2.44.0


