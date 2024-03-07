Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1C0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAs8-0004VT-91; Thu, 07 Mar 2024 05:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAs6-0004Ue-AV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:06 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAs4-0006wo-PD
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:06 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso447045a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806862; x=1710411662;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A243LVbp1AwfUXsMdD+blJLZP6SXZ8l0TiQS7QSUs3I=;
 b=UWRMnzh/F4b9L8Pq8eqgnVks7/8o0ay0RDn9WeAg5EKCivtjEIDDc1x5SzT43IW6CL
 8G7AkWnsAFKSTWV7XXC1NLJoX5gxZDNSQsIJfnNyvoRunONi94b2OVaEUBzMhmKT9i/u
 7FvcbDLiqUR6VT1q8C5T56os3LCcpPu9O/VDKRlLeLVXe4lA2ekha06WK5KUZhsZ6ukt
 Xali47RS6sVbcCBQ2KUJAG/YmQx0P7mlOjDoyGokl3jjo5hk6qOKtN4G6mbLnb/FYSsW
 lLDnoJZWjKvtDTQen57/1cf0fRurh+c8epwsw5O9lkAEFu7ynbo9IVNRcF3lD0H5vulq
 qdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806862; x=1710411662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A243LVbp1AwfUXsMdD+blJLZP6SXZ8l0TiQS7QSUs3I=;
 b=uAfT3S0cnJkvez4q4EDLbnpltdBtGzkCLTk92uo5AZ/liFk5gt2ayMhFX8RQ/uVVH8
 RBPNPb7zKj9Z8iT5zT+DD8XeqdMEkxzFe6T6F5KztFeU+yolA6C7AazoNZtuhF2JqeyT
 oMEXvNvG2A1sDJADJxl/lenLJXfuQEqWQ2II9PXIglozRwazy3/DK1fCqZuZfXnvowVu
 XGz2bHNHrM2ehVRBn7zJ5Gf69jnKoI6+FYJTtzrwWBvr9gD69npGBSPHq3grdoTmdLIW
 /7hS7PPfrrerfWEWrKZL0Ch+DZV44dmvuTY4M35jz6av3FO4tSz6a4HD4pCPP7fzd9ri
 9TYw==
X-Gm-Message-State: AOJu0YwaNRNVdOPvcieAfq15KgQUiqe6VYgFUEYnquSXfVWNsAu3Yfdm
 DG5OLWwtDwkKipU0H9C7alGoZcyAgikChfvSqF1/I4F3ZT4O1GIbnueAolPGhxw=
X-Google-Smtp-Source: AGHT+IGUCFoQOtFxB2kfMcmD4JSLZQKCfT7IcmiLym6Jv0rYE0VcfgpL6we/hPnrwDnD0GxC6XsfJg==
X-Received: by 2002:a05:6a20:8422:b0:1a1:4ebd:db with SMTP id
 c34-20020a056a20842200b001a14ebd00dbmr9029900pzd.24.1709806862357; 
 Thu, 07 Mar 2024 02:21:02 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ei16-20020a17090ae55000b0029b73ccf4fesm1200735pjb.30.2024.03.07.02.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:47 +0900
Subject: [PATCH v4 04/19] contrib/elf2dmp: Change pa_space_create() signature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-4-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

pa_space_create() used to return an integer to propagate error, but
it never fails so let it return void.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.h | 2 +-
 contrib/elf2dmp/addrspace.c | 4 +---
 contrib/elf2dmp/main.c      | 5 +----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 039c70c5b079..c868d6473873 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -33,7 +33,7 @@ struct va_space {
     struct pa_space *ps;
 };
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
 void pa_space_destroy(struct pa_space *ps);
 
 void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb);
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 6f608a517b1e..4c127c9b1ec4 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -57,7 +57,7 @@ static void pa_block_align(struct pa_block *b)
     b->paddr += low_align;
 }
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 {
     Elf64_Half phdr_nr = elf_getphdrnum(qemu_elf->map);
     Elf64_Phdr *phdr = elf64_getphdr(qemu_elf->map);
@@ -87,8 +87,6 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     }
 
     ps->block_nr = block_i;
-
-    return 0;
 }
 
 void pa_space_destroy(struct pa_space *ps)
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 86e709e6da3a..8a71e2efd281 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -543,10 +543,7 @@ int main(int argc, char *argv[])
         return 1;
     }
 
-    if (pa_space_create(&ps, &qemu_elf)) {
-        eprintf("Failed to initialize physical address space\n");
-        goto out_elf;
-    }
+    pa_space_create(&ps, &qemu_elf);
 
     state = qemu_elf.state[0];
     printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);

-- 
2.44.0


