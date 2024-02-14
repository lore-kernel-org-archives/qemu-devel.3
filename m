Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF43EC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFP-0005e4-6a; Wed, 14 Feb 2024 06:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF4-0005A2-T8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF3-0007Jh-IV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K17K/uN0886Kn47U734ewDBEWNLSENKFpu38B+iNS80=;
 b=YVx+55WJWmrRsvt8TXZZikCC7XyvetD9aQxaVPv1wFBpQt1rLlwm9Mi9rWZFQVEyCtwQBB
 2lOVzBg/xlMsaVOvcrE7dDDszB8lkLfZqB4CPjOG+pbTrC9nR6E/oTb1CKMuVQ67DVPLhl
 mf8QrBTita1bcg3Fk/f+wi/q5AzK+lU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-nycbCbexNlOHydhJBBFjhA-1; Wed, 14 Feb 2024 06:15:51 -0500
X-MC-Unique: nycbCbexNlOHydhJBBFjhA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2cb0d70d6cso340244066b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909350; x=1708514150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K17K/uN0886Kn47U734ewDBEWNLSENKFpu38B+iNS80=;
 b=H3f+SHIvWeCcYIuL4dh493qrNz84M6kC8sVXXQXbCTUtzohWpDK8BRzqifRhJzmvIH
 FMVxTS1MqAKPQjn/qzvWoF1n2YHcog/blhhs5TMNNvF7lmdBNo6eewut5Fa8p6+iXFg2
 xFt7wl2Erd1W/0agrIZiFspnCLslwv45eotuKbmY+/qhcHsBGOIpT6hOZytvhwR9zdDA
 Lk7mLzcu442Z7oDiawFihWMpvqEMNohwFv9BbDi+30NdHfED7SGyc55FtLQVj3cYk43g
 rSQhW44GzZMyNCR1bVIB14/k7US7pzlrtsJ2NVyjIIU25Be/eMxALM3fj/B5Yd89aEcy
 53Gw==
X-Gm-Message-State: AOJu0YxWZQAmVUydBeKKr1339VPpbR1/PJM3b3oqeUi0Nb9pIo+ysxfb
 BO1Ef/mHshcjczmvIR0DcMqyHe0ou1JWZPc4LL3joYubSFT9yeNI2pKzMGE5IyU9AQ2HBFN9WmG
 EGCCJkPn0Yt45F2zBIansKeSA7el1/S9lnttlcDUVnY25/mE3tmXGBNzHliO69hh9LOHy55rwEu
 avbRXTX5Kt81NFDCgMntVsva5yQ2O0fg==
X-Received: by 2002:a17:906:a2c9:b0:a3c:8299:9c5f with SMTP id
 by9-20020a170906a2c900b00a3c82999c5fmr1524904ejb.75.1707909350167; 
 Wed, 14 Feb 2024 03:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9ro8RzYCRQT3ChPXndgElsvWkD4U4e0zmV+QarAOpok0ZrKscCzCutBzJNvgO0dc7TqTYFQ==
X-Received: by 2002:a17:906:a2c9:b0:a3c:8299:9c5f with SMTP id
 by9-20020a170906a2c900b00a3c82999c5fmr1524882ejb.75.1707909349757; 
 Wed, 14 Feb 2024 03:15:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWcX+cy8xzEBOYB9PvKS3QeNB7mqfN3Jy1g9t23D6ICCt4iHIS88MR+WnmWv/H4jDkapfoDTvz8NE7YZcnjvgxgQ2qP5V2agaYw9jClKL027arCX9E0CJM5XCygInKgi50gROFtHLROwG2/aZ6ke3DqJ7voIHo=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a3d120e311asm1316390ejc.117.2024.02.14.03.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:49 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 48/60] tests/acpi: Update DSDT.cxl to reflect change _STA
 return value.
Message-ID: <b24a981b9f1c4767aaea815e504a2c7aeb405d72.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

_STA will now return 0xB (in common with most other devices)
rather than not setting the bits to indicate this fake device
has not been enabled, and self tests haven't passed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-13-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/DSDT.cxl                | Bin 9713 -> 9714 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9ce0f596cc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index 145301c52af9a17242bb306c210f8a7e0f01b827..afcdc0d0ba8e41bb70ac20a78dcc8562ca0cb74b 100644
GIT binary patch
delta 64
zcmez9{mGllCD<k8lPUuP<Nb|X6BX6{S>uD9;-j0~S)C(%d^zGhJY9GlodY}#3=GW~
UL^$JvLmU~FaB*)wsA#|f0Fwq1RsaA1

delta 63
zcmez5{n4AtCD<k8qbdUf<M)kR6BX6`SmT48;-j0~Se+w$d^zGhJY9GlodY}#3=GW~
TL^$GuLmU~FFm67iXutvhh3yhn

-- 
MST


