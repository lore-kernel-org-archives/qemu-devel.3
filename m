Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705C6D49221
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD21x-0000Hl-RX; Mon, 18 Nov 2024 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21w-0000HE-3w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD21u-0005RA-JW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731937381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtrWG0BY5YXvtznR58NqvTwNft4cx/F8PPpsoNdE91E=;
 b=jGXJdwvSwL6eGpcv/GoUUn6IHDFxapecJdkkuw3H0/BDBJgfBlzKlvpc5UFHPsCPCRurEM
 9WdksjbdbHqRl+XzyH/5TUgI9BTrxOGOQ/K6Z8kgUNwYbqPWaGguuIJK8wMOI2s01ldcZf
 Iuyr6/zWG63YWJIxq5ccFkQveWCWvDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-Yc1jwTM8OxuMn2IoL3XmKg-1; Mon, 18 Nov 2024 08:43:00 -0500
X-MC-Unique: Yc1jwTM8OxuMn2IoL3XmKg-1
X-Mimecast-MFC-AGG-ID: Yc1jwTM8OxuMn2IoL3XmKg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-382480686f2so531600f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731937378; x=1732542178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtrWG0BY5YXvtznR58NqvTwNft4cx/F8PPpsoNdE91E=;
 b=hN8KhaNlRFWfBJlBkeKhrpbnijzOIce+FICkVB8iaqOoIQpfbiDu/bNjdnc2GB9NV7
 yhw9IlqNqli6zXhyRPCzKmhxdC2Mj1rnVsgEXdBZ7SH+X6Bz/uc05mX9nqlz1YVf+HCe
 ewGrXjtQWFtI+xJjd1wQC6FxkEmorMYW3IKiWZ29OWhRq2ZRo52RPvY+icyxZKwBUjcB
 5gaLKiAJ8bsl4OmIoZ/PnjJuwa+LEw0AGSb6fDpTBx6Ys752PAhAvfYiX+/mLbh/KC2k
 XJweDE9GVkUoBTfgjC2LKb1WsEKcnRRLedq73k+3m0v66HzC0krvDReIE1m3FjsoT86/
 wn/g==
X-Gm-Message-State: AOJu0Yz9u4gynF2cBr2w+tGw4dltsFVILhddymclfUfl1k5Wu0ac/Hf4
 d92oC+hi6a1df94TpXhh3gkJfsZd6C8ryPiFrSj7H5yONfQrQ07/qHNPqLhuwnW9lDKQ6m50bZk
 XAUFmeoDnzlfDh+rkPIVvmy64XX3cNLm8n21G5EZtKpiG6+7+86DtZczPdvvZkcTsCgPiGTjFBB
 2DUY19Pha+5VsJ7mA5fw3CUdwtu3Myx9O5yyIk
X-Received: by 2002:a05:6000:2185:b0:382:2290:3257 with SMTP id
 ffacd0b85a97d-38225aafafbmr6872043f8f.49.1731937378672; 
 Mon, 18 Nov 2024 05:42:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgolQJvEI/CIXalnG63a8lVZbj5LWTG9tnXB8cN2RvQFSPm6eTGjeyzBi3xs/359nsQS196A==
X-Received: by 2002:a05:6000:2185:b0:382:2290:3257 with SMTP id
 ffacd0b85a97d-38225aafafbmr6872027f8f.49.1731937378194; 
 Mon, 18 Nov 2024 05:42:58 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382398aa925sm6809834f8f.50.2024.11.18.05.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 05:42:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 2/2] configure: Use -ef to compare paths
Date: Mon, 18 Nov 2024 14:42:53 +0100
Message-ID: <20241118134253.2071319-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118134253.2071319-1-pbonzini@redhat.com>
References: <20241118134253.2071319-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

configure checks if it is executed in the source directory by comparing
the literal paths, but there may be multiple representations of a
directory due to symbolic links. Use the -ef operator to tell if they
point to the same directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20241111-p-v1-1-001006c68b7e@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 096b1fddb70..18336376bff 100755
--- a/configure
+++ b/configure
@@ -13,7 +13,7 @@ export CCACHE_RECACHE=yes
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
 
-if test "$PWD" = "$source_path"
+if test "$PWD" -ef "$source_path"
 then
     echo "Using './build' as the directory for build output"
 
-- 
2.47.0


