Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096BAC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcOu-0003e4-VG; Tue, 05 Mar 2024 16:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rhcOs-0003dl-2W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:32:38 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rhcOp-00035S-Uy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:32:37 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3fb8b0b7acso782143166b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1709674352; x=1710279152; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WL8MhSoz/cEwgD4T8ycAxxawABipB4Z6srF5gkK0E3g=;
 b=NER47mW4VC9r7XiNpcMxaYL/bmB2+aLyzqlDvMapJ4gnvJnJkWJnR0IBlzve28FXze
 JrrcT7OOoAW21vtlqISJrNWWmK+GQrqW3dK05C3SAKUotdsHJZBIeJ9O0TbinsC6e6YQ
 f6NMNbVhnN/1B8Fsls9gsLocRCMusSO1sEYZYDRgfPg6y1aaMi1l4gkIjg5dpLWNwemD
 ENtPBXURh+jO2abOr8GICf/DZS4jQQ0K1MfNuUnBY60Cuh61yISRN2xoz4PF+eg1Xv7V
 OzHOia0Wuo3f8KnNYEn+6Mkeh8zzqciBmyusyd1Idf5+7m3F2RHsIYQ2Tsld3UUdwaO1
 i8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709674352; x=1710279152;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WL8MhSoz/cEwgD4T8ycAxxawABipB4Z6srF5gkK0E3g=;
 b=hqF7o76AS24ifpvoMAL453QVyexg5PVk2O3r/Ra6wsvqB1c7aThcsmhZYHIivyQNxL
 SUgCoR53Esy+WGtadMQ+z9rvWY2FxxOoRXGxWaYit5D+rEdF1IycJe6nlBUoPbohfY07
 j1NrpGfBvMGT8biAq4LEQsnaSXE6aGUP58av0oTktgAPv3d2DCIZrbPoU5MehsVwmcQ/
 IhxsWblRt/7rTknq1FLgMQ5BMO+dqw4Cw64vvo9NrZ9qLzvrunr4uHovpCQeSlpO4is9
 KbByOO31rGWxvDX0HrkDMBa6ew8Z6WIVCaD06djpGYyXrMjWmhXiDtnDd9cQfJm6aHCg
 jBfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW7+iAjx+loeDX7bY/hIpAlDE0KYMaMcEPurc9Ab7kteWHGOroIzqaIZZzHyP8/je4obijbXz/EfE6b+BSA7i287j43v4=
X-Gm-Message-State: AOJu0YzgLybHrODnk+RbvjOPs82BzvgtnTvsBvZIRVt32FOumETVcV6/
 xZaUr92S6LrM0EAkCQ4nEjUDSRe3I7ygywqXKUswoUkqxGsjCjpqDqg20vXNJ3rO6ze+DN8l5aG
 BhkKNS9LSMLXXhOy8fwCEImbSOothb7ssNT17Og==
X-Google-Smtp-Source: AGHT+IH6XnyoR+Z1CmjwJh3xT5gWzMZwfjZHCh7peuY+nVwTYuvPmBI9I4gKmEw/rC2AgXGPX3ySQIoSaHxFTp9h1JU=
X-Received: by 2002:a17:906:c7cc:b0:a44:7a34:e620 with SMTP id
 dc12-20020a170906c7cc00b00a447a34e620mr9086241ejb.4.1709674352484; Tue, 05
 Mar 2024 13:32:32 -0800 (PST)
MIME-Version: 1.0
From: Yu Zhang <yu.zhang@ionos.com>
Date: Tue, 5 Mar 2024 22:32:21 +0100
Message-ID: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
Subject: 
To: Het Gala <het.gala@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: permerror client-ip=2a00:1450:4864:20::630;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Het and all,

while I was testing qemu-8.2, I saw a lot of our migration test cases failed.
After debugging the commits of the 8.2 branch, I saw the issue and mad a diff:

diff --git a/migration/rdma.c b/migration/rdma.c
index 6a29e53daf..f10d56f556 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3353,9 +3353,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }

-    isock->host = rdma->host;
+    isock->host = g_strdup_printf("%s", rdma->host);
     isock->port = g_strdup_printf("%d", rdma->port);

which was introduced by the commit below:

commit 3fa9642ff7d51f7fc3ba68e6ccd13a939d5bd609 (HEAD)
Author: Het Gala <het.gala@nutanix.com>
Date:   Mon Oct 23 15:20:45 2023 -0300

    migration: convert rdma backend to accept MigrateAddress

    RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
    accept new wire protocol of MigrateAddress struct.

    It is achived by parsing 'uri' string and storing migration parameters
    required for RDMA connection into well defined InetSocketAddress struct.
    ...

A debug line
     isock->host = rdma->host;
     isock->port = g_strdup_printf("%d", rdma->port);
+fprintf(stdout, "QEMU: %s, host %s, port %s\n", __func__,
isock->host, isock->port);

produced this error:
QEMU: qemu_rdma_accept, host ::, port 8089
corrupted size vs. prev_size in fastbins

on the target host, which may indicate a crash related to the memory
allocation or a memory
corruption of the data. With the patch, it doesn't happen any more,
and the migration is fine.
Could you be kind to test this and confirm the issue?

Furthermore, I'm confused by the two struct:

struct InetSocketAddressBase {
    char *host;
    char *port;
};

struct InetSocketAddress {
    /* Members inherited from InetSocketAddressBase: */
    char *host;
    char *port;

To my understanding, they are used to consolidate the separated data
to a well-defined
struct "MigrateAddress", while the struct whose member receive their
data has a different type:

typedef struct RDMAContext {
    char *host;
    int port;
    ...
}

Is there any reason to keep "port" like this (char* instead of int) or
can we improve it?
Thank you so much for any of your comments!

Best regards,

Yu Zhang @ IONOS Compute Platform
05.03.2024

