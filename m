Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3955CC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IOD-0008QL-9g; Tue, 07 May 2024 06:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IO6-0008Lj-QS
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IO5-0007d7-4Y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715078972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ti0wXm0yvKxFk/IcUXQzmvTAJt0gDIEZSIYDJ2MTpOU=;
 b=doIxDW8hRundziltevGJlWxVEHMk1ADPE1jLRaktXFkTkXe4pPnVvwGyvDTFdMClfs3xyL
 2RxyWPKU2HIt/PwWK+Grtl+yzbLzb8Xdvqy/lO0y7Z4D9Du7P5hLuzrIexgObtcGgMie99
 nMoIHNCrvNiR4/s/7cw2dNUQb+Bt9fM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-iljAQtYyNOaIJ6JL0u9HOA-1; Tue, 07 May 2024 06:49:30 -0400
X-MC-Unique: iljAQtYyNOaIJ6JL0u9HOA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a212d874so215908166b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715078969; x=1715683769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ti0wXm0yvKxFk/IcUXQzmvTAJt0gDIEZSIYDJ2MTpOU=;
 b=S8BVTWAjdsvTq9fxmd7kW55WbUu/a+4ZDB4m4hlbh+J2puj3b9euzFgjUsYuOzAm0X
 cR6RSFQpD3VwoTHDJNO8kYKKc6tqL+ZRA4Gq9JGMIIy6qKqs0sZ0g9xThp0xQY7O7otl
 KMrPZ3gjVVIuCyOYktdz7KnK9OXc0MS4R2K1+Y6aexqLjtdIQm2kdIPB9WTiRVP1wdmH
 2cTx+VYwYArvbKw+3IKPh8uIYhM1aXf+lIAXBOPtehrt21YLlPb6BsK82HHHlh6Uevj4
 4Y7HBgdyCKS+xHV/U+bjl9ZDcelzqgy1z6oAlo3Nej1oS4d639AC+6xy3W1b+xnVch3p
 poow==
X-Gm-Message-State: AOJu0Yx5yZoX2wYT/xOP4vysn4FZl+0DALMHCJeEgkS4tj4ts+xtKUbT
 bNBZ3E2tOvL248ubYiaD66n10noIr1NIIiaJdcqJBrdzFlx9UHKeuz2D/zfYP6lS0ZtiXDK60PG
 0EysM0xZLpmuR+NzV2duWLsIkUku8gsjAAlD91MJdStVcY/kfVQ/pJPiFF9rWtJRgGdq9QKIShN
 wvnG+vF3Ac6lPLTLEsjHU88VlQZ7UuYxB46jgr
X-Received: by 2002:a17:907:7da6:b0:a59:aa9d:3142 with SMTP id
 oz38-20020a1709077da600b00a59aa9d3142mr7048875ejc.37.1715078969059; 
 Tue, 07 May 2024 03:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeOBJvQVTC4es33OR5lWgN65OmXay+tEqDVjMH3RNBrmpWxr4OaGG/CRmfOlz6ARups1tmrw==
X-Received: by 2002:a17:907:7da6:b0:a59:aa9d:3142 with SMTP id
 oz38-20020a1709077da600b00a59aa9d3142mr7048855ejc.37.1715078968619; 
 Tue, 07 May 2024 03:49:28 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 rh12-20020a17090720ec00b00a59a0cbf048sm4576562ejb.13.2024.05.07.03.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:49:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] configure: quote -D options that are passed to meson
Date: Tue,  7 May 2024 12:49:26 +0200
Message-ID: <20240507104926.179301-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Ensure that they go through unmodified, instead of removing one layer
of quoting.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index bd85377a6ae..10fbe10ad9c 100755
--- a/configure
+++ b/configure
@@ -764,7 +764,7 @@ for opt do
   --*) meson_option_parse "$opt" "$optarg"
   ;;
   # Pass through -Dxxxx options to meson
-  -D*) meson_options="$meson_options $opt"
+  -D*) meson_option_add "$opt"
   ;;
   esac
 done
-- 
2.45.0


