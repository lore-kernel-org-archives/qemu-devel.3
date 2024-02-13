Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413B5C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3l-0002x7-PF; Tue, 13 Feb 2024 10:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3k-0002uC-OX
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3i-0005X5-FM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddz/xp+FHATs0HtSax3jhPBsKh0ayriSqzKxrZz01xM=;
 b=cW/0lMNR9VjrZ6vLOdHrmvNHcRoXZhCuYHC2iGHTuRyKub5dFSnjheRD3S6CN39POyJKq+
 hNCA4MqSr+1NRZ3InJwn55UPlooxYMPp8xFHdPgB2OSroR3sFUcxbDu8tk54ZRP/8FmtYl
 IFmL2gI76RPAEXQFpVLiJXXuLu9VbME=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-2Sd7wkKAMeyqTnIpqjcMaw-1; Tue, 13 Feb 2024 10:50:56 -0500
X-MC-Unique: 2Sd7wkKAMeyqTnIpqjcMaw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d0a7ab562eso27930701fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839451; x=1708444251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddz/xp+FHATs0HtSax3jhPBsKh0ayriSqzKxrZz01xM=;
 b=penwIOCKnV71sv9Usqo1gjQWKkbqZzUXvWwIC/I4PHcNsvVNRW3N2C73TbiXpZqLzI
 rEfO2RQfLw+ov7qvHbarUSXkUluGs+4JGvZLdF+xn1RJwDt0TMQh75iqTgjpaKM74Ocp
 KKL1HME0ZSk5m9ZjB3WoCj/MnCBzVrIr5DI9LvwybIeS/aLx7J50diPwnCzuJUlzk02z
 3TvApWVucQHiPSusjEt9TPaI5Gx5XgdIiHVGTwGSvsRJsTvQu50+J45rsgzgDW4q0TNQ
 uDYc4eTwBsg/RhZkNts43zMHsCIrbzoiHf1+52N2bT15TwQSjKEUC2LU9Xu6BKUdJXUO
 rsrg==
X-Gm-Message-State: AOJu0YxbxRL98Ha4VHD5a+jrRP7I83yNBzMEQUAROwwZsr7gT8pojVFG
 Ho2xELSMbEAA1juDNx6/8NGZtCp1Rt1sanbblQ/DEefBQ5gmAXOmSjarFQTc8l59W0x2tSWRFgc
 CcfdffN4AHdj7XUwzdXPBfIpnlr+eSQw6ark7ZeEUQJCQ22RrNqtafiZWy/5tykvlR1kfB1JDZL
 3W1Bnw7G+Sp6Fjb2jr897LXSU7xBCMVEyog/dR
X-Received: by 2002:a2e:8e85:0:b0:2d0:77b1:de8a with SMTP id
 z5-20020a2e8e85000000b002d077b1de8amr975291ljk.0.1707839451502; 
 Tue, 13 Feb 2024 07:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGap8N//dGr9+/PoifOWtUTu8SAXuDZ92kB+eZhywRh7MxEz7RLOGXaq2Cmj5aSVwuITy4wZw==
X-Received: by 2002:a2e:8e85:0:b0:2d0:77b1:de8a with SMTP id
 z5-20020a2e8e85000000b002d077b1de8amr975273ljk.0.1707839450976; 
 Tue, 13 Feb 2024 07:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFYJtbToZfL+lfLnx/3jhHAg3LpP3jo2EMfjfdaiAFPqsHt0cwLJgpDlNBVavYuyIavIHD+nlREk2D7VeQqypRZU93wwIKQC5hsGYfTwXsIkhOzXS/
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a2e7407000000b002d06d48ddffsm544796ljc.70.2024.02.13.07.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 4/9] isa: fix ISA_SUPERIO dependencies
Date: Tue, 13 Feb 2024 16:49:59 +0100
Message-ID: <20240213155005.109954-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ISA_SUPERIO does not provide an ISA bus, so it should not select the symbol:
instead it requires one.  Among its users, VT82C686 is the only one that
is a PCI-ISA bridge and does not already select ISA_BUS.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 7884179d08b..5df3c09cd51 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -15,7 +15,7 @@ config I82378
 
 config ISA_SUPERIO
     bool
-    select ISA_BUS
+    depends on ISA_BUS
     select PCKBD
     select PARALLEL
     select SERIAL_ISA
@@ -47,6 +47,7 @@ config PIIX
 
 config VT82C686
     bool
+    select ISA_BUS
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-- 
2.43.0


