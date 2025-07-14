Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AECC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGD-0003AO-Gb; Mon, 14 Jul 2025 19:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG7-00034O-Lu
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG5-0005PT-Q4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ni0t6xRkFvmRtTZbGD/fX48AdcEArrKXK6PgLqlkH/c=;
 b=EeS4/dbAopDy2RB5lvk3FgOO+9l6h0GrGyvsjANUzobBt1sArVJqxi/R/8IRFoDEX5p50X
 IRWpGT3WhdAl4sm8aKOmwz9AF+MHcZkeoYADdbjrl2XC9P6CBqvQetZ49RE+qV0kp/GAiC
 mE9sb+q6NojQ6eKFZ/INTL6yALicNEQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-FNHJeT56PqqKCJM0tW4wrw-1; Mon, 14 Jul 2025 19:06:50 -0400
X-MC-Unique: FNHJeT56PqqKCJM0tW4wrw-1
X-Mimecast-MFC-AGG-ID: FNHJeT56PqqKCJM0tW4wrw_1752534410
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so1774735f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534409; x=1753139209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ni0t6xRkFvmRtTZbGD/fX48AdcEArrKXK6PgLqlkH/c=;
 b=vDYKNTyAUWmKOYSrQwWvC+6I+t1PRhMGPztyyTc23uLbbs9zoo0XG/2Q/3BCwP2GcL
 ShMSbfKg/80viH3lca2rR9BxP1LdLcSHry/PT0qqs2gQa7SOwbTPS5ReHnztdepwZ7GV
 N4mraMMpVDBeDYbnwBSMlAvVBgVePa7xN3sjycjgOaHxgqWSqr6lWGimSvFLt2KGNmQN
 CG58xS++qHb0H8wPNGKyRxGMy1AEO+MyDHGWdrj6TlCFHyW56PGFRm7cU0YUhjITyog2
 qMlInRKouxORBDf4j+UBxUtZqbQTzFNFpx60UsfKFGErOZrnoNjqj3FcekEVWGr5Zued
 d6Jg==
X-Gm-Message-State: AOJu0YxXGngkPcU1iRlNbF5Uk+1HYutIQPyKPP0zbKk/0FvNXPg0IiE3
 2K99LP1sGca7AyShUZG9BoAhQSIompbRs2AZzbHZ0Z5ufpKIU4DrUqCLX5O+dsLlkk+Hc7KGKg6
 PEDaDeuiXHSIx1G9XfaC3ncm9fWmq+1HcEuYOOgEFZGPAe4SLfbN0Q6sMVP9Br4FqVOuWn3DvnN
 GJbNHtsScNat925t9rppMd/gNQo7Svh+N7yw==
X-Gm-Gg: ASbGncsTFWR0iIH2AIU3koG/+qbA7iC380j/AWf4Z/5ZTpX5DMXgE//nib11Vb37GtC
 m2Ed1TCAugNYTldxHQ0yg0VmHtm4WhHigPqWr0AzO4N6Go8rtrUh2JINW1mg4PIt3F0PeQeyJFE
 KNtxslZGkJ0Z/SNEvyR2GweyCfAWUO6aam0XSzjNzWFmL50NvEPvpw1XFYURuEQNZTDCyGDuFw/
 oTIUyaGMIz2ntuGHuy3U1sqQZu2pBzEyZ8Da2N+9zpTTxfbls/i4lhjXk7hbz0XYVplMGPjwu3v
 LZZugyWn9om1S8C73n5nu8eyYtZb4DZw
X-Received: by 2002:a05:6000:2d09:b0:3a5:85cb:e9f3 with SMTP id
 ffacd0b85a97d-3b5f1875b23mr8235348f8f.12.1752534409409; 
 Mon, 14 Jul 2025 16:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaQ67XfS4mi2osXpvctPBG782DUaJ5TY83uicGImNZrwNIWogWzFuinaEB5Ymt7uJ5JM7sg==
X-Received: by 2002:a05:6000:2d09:b0:3a5:85cb:e9f3 with SMTP id
 ffacd0b85a97d-3b5f1875b23mr8235333f8f.12.1752534408805; 
 Mon, 14 Jul 2025 16:06:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5f32ed100sm10614815f8f.0.2025.07.14.16.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:48 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/97] rebuild-expected-aml.sh: Add support for LoongArch
Message-ID: <c43ca0de62749286ee099baaf628b7f7b6e9844f.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Update the list of supported architectures to include LoongArch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250612090321.3416594-4-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index c1092fb8ba..cbf9ffe0dd 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64 riscv64"
+qemu_arches="x86_64 aarch64 riscv64 loongarch64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -37,7 +37,7 @@ if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
     echo "To fix, run configure \
-         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu,loongarch64-softmmu"
     exit 1;
 fi
 
-- 
MST


