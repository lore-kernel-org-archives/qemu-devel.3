Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8uA-000419-1T; Wed, 03 Jul 2024 18:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8u7-0003zq-FP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8u5-0001fI-Vv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1oVRcGRoVnZxLtAHt3a+cAY1LWRp/f7zSpgrYQ7D4JQ=;
 b=SMFSyLHtTdXOtCEuljm5bbmragCyaW9gZ5EmaIi85/hxfaatQu7oRd1dLbwtOk00fOnzR4
 HYsU/qHnQUaa48VJEsrT7AhHDEkTyNKEI2iE9FWL1UPKffvGpYZhkUiIQM9jN+SZ12wC19
 WiY/aTEfpZqqe/csF+NbdbWcQNN23+E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-ntHMIserPt6nrlzEMP_xRg-1; Wed, 03 Jul 2024 18:56:41 -0400
X-MC-Unique: ntHMIserPt6nrlzEMP_xRg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-58c537ae6c9so2521a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047400; x=1720652200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oVRcGRoVnZxLtAHt3a+cAY1LWRp/f7zSpgrYQ7D4JQ=;
 b=PyYE2ieJ0QSQIXjtq12pMZYf5QGgwNWktmzKzQphH24jPPL1C/egACb6n902J2dFIb
 +jQxPnkZ/xmEuYBV5G73qLzWIhuMLUyQJw0pEWofm4/80zv2aZydwPpqqbohQz1oCZrV
 05UWQPRZuykB+MybusKtngOQTQQ73PfDhy6oTzicSGkKpDqJSfnFIafkwWdk/csSAUs5
 /60E7hqTOp+PiZhBZEJr/mZxACw9E1lXlWE7J64L1SaD6R4W5v/EUhm9rg4zNTUMNzHp
 0sw6mV0hQ5VssW8HMJWqw9biFZxQppY0rDeEGZtUGlMgSum94rwuNhmiS1JG35y2yt/k
 Bd9w==
X-Gm-Message-State: AOJu0YxIZSM4gApQ0F6lvsFr9Ocr5VU6irZVp8d7badlMlTOnLyW/yyK
 slu4xk+ydVRhZSkSVBeDRvvTbgVLvFC7KY75mmLIjzTMYVguoP04wbDgqOPm8xwkSgHZrxmor/Y
 X1e8R8iK9Vq18trP5VbjRLoaP3ePAxWYJcPpAYwudXph66IyCgOgoZzVp8TNkZzt2+xCC8wVCFQ
 WuigkA3NS7rdSKJtOvuIB21IHsoArXSA==
X-Received: by 2002:a05:6402:1e8b:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-5879f9849a9mr9898923a12.19.1720047399704; 
 Wed, 03 Jul 2024 15:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuphDOjpkxQrmECF0kal6y5Q9p5QSAbT+KR4MktLQlWDRykJn/y7802L78UWRH8cXC7jYEwQ==
X-Received: by 2002:a05:6402:1e8b:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-5879f9849a9mr9898903a12.19.1720047398893; 
 Wed, 03 Jul 2024 15:56:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58c9061becfsm1717241a12.83.2024.07.03.15.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:56:38 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:56:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 69/85] meson.build: Add RISC-V to the edk2-target list
Message-ID: <008115bba06a30b13b3fd86cade8a280490e06f3.1720046570.git.mst@redhat.com>
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

so that ACPI table test can be supported.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-12-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 54e6b09f4f..efd3d4c6e5 100644
--- a/meson.build
+++ b/meson.build
@@ -93,7 +93,7 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
-- 
MST


