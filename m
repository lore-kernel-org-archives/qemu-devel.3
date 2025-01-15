Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56AC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sK-0007A5-Cq; Wed, 15 Jan 2025 13:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r0-0000Mm-E8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qy-00077A-Is
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iBHg2OPngPHjw2/4BgKrx8Ylj0UqmearNkTjgWbPZw=;
 b=SXeRyA2uanXs9Avs563Ewi7PD7ewePUMhzCleyXse0ik8fxRw5nDrv4XWTbtrCFxx2OKeb
 tS10sg9BVB8VNZ7yqTxyd1jMr96tZjsCcHwufhNdmgUNS+WJo9pjL/s1/A4m2MMMDAqS4D
 CQljnQOpFd++5hWq49+0kov9FXM9IP4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-JHG4J0IjPZ22CHjvWp7agA-1; Wed, 15 Jan 2025 13:10:54 -0500
X-MC-Unique: JHG4J0IjPZ22CHjvWp7agA-1
X-Mimecast-MFC-AGG-ID: JHG4J0IjPZ22CHjvWp7agA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so37750385e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964653; x=1737569453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iBHg2OPngPHjw2/4BgKrx8Ylj0UqmearNkTjgWbPZw=;
 b=GCYMU0Om59eVbwQAgmqd8Zevc13ZlM2HLQs8M42gjTxj0GuUh0o4J4Skd+tUSTQDnz
 2uZ2WPzhY280XY08TL4zfQgf/wKXEKtMQZGIGD3wCgFllTPBkbNByMktkUku7lJ/m5hD
 rGB7xQGz4gvbXu9QYrGhlkv3cB7j733Fgkrkz7M1nk8caOHisHigT8yS3exiHT6TsHYz
 rJfWLZuckc+GLnfHg9OOSXlx6C0b5ue6RBqlA2vLtato+uPjnqfOz3TjeQU1xfJt3KPA
 aBoANCAgQZ6FSKW9KZbRTBFL6rhChg3oACLynjjO7sUUzQUfy+p6gy9z4WFGcl4dpkIL
 P5MQ==
X-Gm-Message-State: AOJu0Yz4/CqBwx9gzED8qu2GHqIQ5YHOZIaxNQEe+ojs95eMWqj+1NWJ
 5iIt5MYTy/EACsQhgtahF6rGZTC3GAsI5bYO5mEYk5yLafVsV2Nv7sUDhOG5w3iZponuT1tU7rV
 OcdtGcNQnX8L/mnDzR/upxXnML/kiaCzQn7pmbZt0ckYvyNGDP3zfiNamAcOD4A1DjzXwYk9LQk
 GCul5iqJWtoZf+mCR60g8OFjsfql3lmw==
X-Gm-Gg: ASbGncs+7LstwyJnPxuGOcLG/qx4ZuUDs/EoVDGlOlFePGsX4i+RC7lmA88ZGsE6zUa
 QcBAT546sjMphrSVv4UmZDjbSn3efujEobwAcnelLGTAJSQTzGqzmquPZwUM6NseoY7oQt3kxbc
 pNwfUYFbnAHjdjR3DWBFqsWr/dCBVY8vRKaYPLxPUrzkcvxEStEQnBsZGskJHzfapdRW5QfyzuK
 W3+UbXGDW1LkiUqE/UCzt1Rz/dhSH7cBn0pU6S/F7oCZlkaPJEU
X-Received: by 2002:a05:600c:138d:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-436e26849f2mr49916835e9.5.1736964653137; 
 Wed, 15 Jan 2025 10:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYWNt1gcTmJbIAQaT3qZS8+OwyZdqzGBwueOpfO26delrSiZ4FMufZR7Stiut5vK9BVseFbw==
X-Received: by 2002:a05:600c:138d:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-436e26849f2mr49916535e9.5.1736964652660; 
 Wed, 15 Jan 2025 10:10:52 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c5b2esm31238695e9.23.2025.01.15.10.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:51 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 44/48] pci: acpi: Windows 'PCI Label Id' bug workaround
Message-ID: <0b053391985abcc40b16ac8fc4a7f6588d1d95c1.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Current versions of Windows call _DSM(func=7) regardless
of whether it is supported or not. It leads to NICs having bogus
'PCI Label Id = 0', where none should be set at all.

Also presence of 'PCI Label Id' triggers another Windows bug
on localized versions that leads to hangs. The later bug is fixed
in latest updates for 'Windows Server' but not in consumer
versions of Windows (and there is no plans to fix it
as far as I'm aware).

Given it's easy, implement Microsoft suggested workaround
(return invalid Package) so that affected Windows versions
could boot on QEMU.
This would effectvely remove bogus 'PCI Label Id's on NICs,
but MS teem confirmed that flipping 'PCI Label Id' should not
change 'Network Connection' ennumeration, so it should be safe
for QEMU to change _DSM without any compat code.

Smoke tested with WinXP and WS2022
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/774
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250115125342.3883374-3-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 733b8f0851..1311a0d4f3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -654,6 +654,7 @@ static Aml *aml_pci_pdsm(void)
     Aml *acpi_index = aml_local(2);
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
+    Aml *not_supp = aml_int(0xFFFFFFFF);
     Aml *func = aml_arg(2);
     Aml *params = aml_arg(4);
     Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
@@ -678,7 +679,7 @@ static Aml *aml_pci_pdsm(void)
          */
         ifctx1 = aml_if(aml_lnot(
                      aml_or(aml_equal(acpi_index, zero),
-                            aml_equal(acpi_index, aml_int(0xFFFFFFFF)), NULL)
+                            aml_equal(acpi_index, not_supp), NULL)
                  ));
         {
             /* have supported functions */
@@ -704,18 +705,30 @@ static Aml *aml_pci_pdsm(void)
     {
        Aml *pkg = aml_package(2);
 
-       aml_append(pkg, zero);
-       /*
-        * optional, if not impl. should return null string
-        */
-       aml_append(pkg, aml_string("%s", ""));
-       aml_append(ifctx, aml_store(pkg, ret));
-
        aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
+       aml_append(ifctx, aml_store(pkg, ret));
        /*
-        * update acpi-index to actual value
+        * Windows calls func=7 without checking if it's available,
+        * as workaround Microsoft has suggested to return invalid for func7
+        * Package, so return 2 elements package but only initialize elements
+        * when acpi_index is supported and leave them uninitialized, which
+        * leads elements to being Uninitialized ObjectType and should trip
+        * Windows into discarding result as an unexpected and prevent setting
+        * bogus 'PCI Label' on the device.
         */
-       aml_append(ifctx, aml_store(acpi_index, aml_index(ret, zero)));
+       ifctx1 = aml_if(aml_lnot(aml_lor(
+                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
+                )));
+       {
+           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
+           /*
+            * optional, if not impl. should return null string
+            */
+           aml_append(ifctx1, aml_store(aml_string("%s", ""),
+                                        aml_index(ret, one)));
+       }
+       aml_append(ifctx, ifctx1);
+
        aml_append(ifctx, aml_return(ret));
     }
 
-- 
MST


