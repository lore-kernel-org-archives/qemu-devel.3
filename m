Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C64C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nU-0008RG-Bu; Wed, 03 Jul 2024 18:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nS-000848-4U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nQ-0007B7-Dd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=WgLq6QlIeamBYY8ZSudbE0T6nMRJFEl6Dl/17l1lTZe1AFsegEtrFVyhm7En6ka9TJmkDe
 KtAbfx1fd9fSuF1XvltNn05OY7if4PHCDRV/DIDft57OEon1o1XjnGBZWYR+5Mdklv4xpm
 N5CZMBz8jA6y4AI8PWDPY9A2h3V3YLU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-mQA2QOvIPTyiyCkbFsE4kg-1; Wed, 03 Jul 2024 18:49:50 -0400
X-MC-Unique: mQA2QOvIPTyiyCkbFsE4kg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso41640f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046989; x=1720651789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp+XdzPzdo45On8QxmeO3KbH8ukLhYQRI6dbRMmEeEA=;
 b=g7zBafCAjBvlYnRYoQxYUo2paHLXW3Xw+Oy4cfeLqEooC4yB9NFTnqZ3ZjdMFdc9kC
 Da9zqjCrHwNYEw29KLSDi2nAyJVtXnZ04xsS7eLkLOF3SpFNgID252cGFvWqy+p8BV9u
 2rAvmH0R1JG/tbOl0rSxCH0QiozT60IaOGrfkGccWAvLgwZS2JQv7NU5tYXwPCiU7lml
 SifRKb1mcM5MDWu99vm/dEghDni0rTeYceF1FmTlsjqmZ9w/raTrp0v93n1fygr6W0rQ
 VIaM5ieIFkePPPNtzfafmEKf9dg+xhK7TqSyKCwPJQQyuvEfrwewMechGnLEB0Bek+8o
 9P8Q==
X-Gm-Message-State: AOJu0YzG1yD+QOl937xZWdU9TWWIHMa2BAEkPbStjpdIa8vIXVpfCiko
 tKQqLVwETc+/V+i6QUTWWzvc1bfoMkPc/3BsgRU398TaM5kZLqrUW4l39ZqeGzXRR8SWeagYa4b
 s3tyZdt3WLCRMZF+YmIHs+GeBZwmB62m27gtNVfRcB1/PJI3hKz26c0gF3eiGsCcLA3E8oDoZSg
 cQ53It5OQxuKdczpwY3aGZCEXNpD0QVw==
X-Received: by 2002:a05:600c:2d44:b0:425:5fe5:f273 with SMTP id
 5b1f17b1804b1-4264a443e54mr262075e9.26.1720046988858; 
 Wed, 03 Jul 2024 15:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy0AEjGll0NdaFcLsXu/dJZs2t9ZR5+kuPZTJLug7ifo6pHl95fprhPkFzrUgQSU89DDgmKw==
X-Received: by 2002:a05:600c:2d44:b0:425:5fe5:f273 with SMTP id
 5b1f17b1804b1-4264a443e54mr261905e9.26.1720046988280; 
 Wed, 03 Jul 2024 15:49:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d5100sm1239325e9.4.2024.07.03.15.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:47 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v3 71/85] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Message-ID: <0f130d9e372552ef900bfac062ffc6a77b4049cc.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

Update the list of supported architectures to include RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-14-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index dcf2e2f221..c1092fb8ba 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64"
+qemu_arches="x86_64 aarch64 riscv64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -36,7 +36,8 @@ fi
 if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
-    echo "To fix, run configure --target-list=x86_64-softmmu,aarch64-softmmu"
+    echo "To fix, run configure \
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
     exit 1;
 fi
 
-- 
MST


