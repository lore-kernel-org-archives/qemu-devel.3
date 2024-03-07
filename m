Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E05FC54E5C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAs1-0004Ro-Cf; Thu, 07 Mar 2024 05:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riArx-0004OV-IK
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:20:59 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riArw-0006qc-2l
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:20:57 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso630097a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806853; x=1710411653;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D5kUM6n9+j+qbS1SUPTKf/+dgcMdpwuEc/L8WCg7irw=;
 b=X5NkaWZSsSZhQo7NIesYwNStXrDDOQStBZExsIR8KarZrWWt/5SvgsrSfzc1Fow6u1
 gJpfux2/LVWIQE2cLvWyQqHl8amEHBJac6wY2B62gwkAdBBRWfe0AfioSO3tsGbTHn6D
 x9Hw7IqOyqZNPuzoKHP+HzXcgoAfPG+DntNN1AnAty9gFpEo5gAH2L/byYqq072vwnhi
 MiESO4U/NvS1zdGZqsSeRGFo2BcjBD3CD9uNUym7pevrosyBDTBG60hxietMc8ZBCN93
 MlB+0/97Wmefk0B6CNuFf3ydKo621xpp/szCvRek5pViOYPSLcZ4rz56f/UZyHGcBxaz
 rwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806853; x=1710411653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5kUM6n9+j+qbS1SUPTKf/+dgcMdpwuEc/L8WCg7irw=;
 b=UtQGz8hU/UL2Ytt50AbJLKR+f+PqJDxIo/d662z3TFY3uTusYkZC0LOjgcbWyM2472
 kOPZ38zoKtFPCv9PHQBu6GnWAceG92PRQih3DN20qr4NF9yrYMhxFbaeI1QDIiRudiX1
 GmPpzTOkRqGOo0uQx2TJQI8jZomN+rtzYGAwf/8LALmihWt9XdITLiZAFZytZssMnWz6
 53+u9QrQwgZoOehLFMxBQvHyFqem1kW1EG5GnGwU7YMDQPpgItWC2/EHzZ+No2/sMAMD
 R0LYVmD2WRIwTmMEeP1L2QUz+ejsFbi6/J1pPdltyDMGwttqZy1we8ZYNN9tH9cix9Hv
 uDBg==
X-Gm-Message-State: AOJu0Ywju54pkHT+hrgRuvQPxxwWR7j5xCT53fQbMgAwdf79o+9g2TEZ
 D2k09jRdWjWnKlU5iMJ4WZmgsAgsq0HcCJ2U0wui0OMbH4qSaCSvcKVbIOTdp8qxX2JhHZapKUM
 4
X-Google-Smtp-Source: AGHT+IG/BP+CMvtNKeNBxVJNQQQPYRwZajj1WLf5260/BULR9evmpbMyeimALlMxFDqkx/MjPm384A==
X-Received: by 2002:a05:6a20:3c9f:b0:1a1:45e4:845a with SMTP id
 b31-20020a056a203c9f00b001a145e4845amr8091556pzj.11.1709806853183; 
 Thu, 07 Mar 2024 02:20:53 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 h15-20020a170902680f00b001dd090a7c00sm8800575plk.292.2024.03.07.02.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:20:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:44 +0900
Subject: [PATCH v4 01/19] contrib/elf2dmp: Remove unnecessary err flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-1-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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

They are always evaluated to 1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 40991f5f4c34..abf17c2e7c12 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -177,7 +177,6 @@ static int pdb_init_segments(struct pdb_reader *r)
 
 static int pdb_init_symbols(struct pdb_reader *r)
 {
-    int err = 0;
     PDB_SYMBOLS *symbols;
 
     symbols = pdb_ds_read_file(r, 3);
@@ -196,7 +195,6 @@ static int pdb_init_symbols(struct pdb_reader *r)
     /* Read global symbol table */
     r->modimage = pdb_ds_read_file(r, symbols->gsym_file);
     if (!r->modimage) {
-        err = 1;
         goto out_symbols;
     }
 
@@ -205,7 +203,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
 out_symbols:
     g_free(symbols);
 
-    return err;
+    return 1;
 }
 
 static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
@@ -228,7 +226,6 @@ static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
 
 static int pdb_reader_init(struct pdb_reader *r, void *data)
 {
-    int err = 0;
     const char pdb7[] = "Microsoft C/C++ MSF 7.00";
 
     if (memcmp(data, pdb7, sizeof(pdb7) - 1)) {
@@ -241,17 +238,14 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
 
     r->ds.root = pdb_ds_read_file(r, 1);
     if (!r->ds.root) {
-        err = 1;
         goto out_ds;
     }
 
     if (pdb_init_symbols(r)) {
-        err = 1;
         goto out_root;
     }
 
     if (pdb_init_segments(r)) {
-        err = 1;
         goto out_sym;
     }
 
@@ -264,7 +258,7 @@ out_root:
 out_ds:
     pdb_reader_ds_exit(r);
 
-    return err;
+    return 1;
 }
 
 static void pdb_reader_exit(struct pdb_reader *r)
@@ -278,7 +272,6 @@ static void pdb_reader_exit(struct pdb_reader *r)
 int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     GError *gerr = NULL;
-    int err = 0;
     void *map;
 
     reader->gmf = g_mapped_file_new(name, TRUE, &gerr);
@@ -291,7 +284,6 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     reader->file_size = g_mapped_file_get_length(reader->gmf);
     map = g_mapped_file_get_contents(reader->gmf);
     if (pdb_reader_init(reader, map)) {
-        err = 1;
         goto out_unmap;
     }
 
@@ -300,7 +292,7 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 out_unmap:
     g_mapped_file_unref(reader->gmf);
 
-    return err;
+    return 1;
 }
 
 void pdb_exit(struct pdb_reader *reader)

-- 
2.44.0


