Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3434EC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLkS-0004rg-Q7; Tue, 23 Jan 2024 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLkA-0004jH-Kn
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:34 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLk6-0002oX-JD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:28 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F3224032F
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706035402;
 bh=cpcO92XOl2zNt9sq2MJVJ7XaxnnPhG6+lYWq+HSy79Q=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VNH+ihOZtior15lJDTXQOwfIbhjbhh1EZmXALZAqmuKgDTlPixlCUKjTyS1XHmuYb
 PDV6vsUZVnzI0qVXORxaS79TpYBD74EjQxih5BHNrNjuMCJ1S9nkcLMGHN+GFbMRVb
 tCGLgoqhWMGSF2yeJkyZLTLlleY4oO5X/VGp+zwMxgEtJKbctUdY9gawzdEiClVkOQ
 WW18iWs/n81547Fcs2mso5XlBzmKXLm0YP9Age6ErL8QxF0CLJSDK9Itm33TkuqEC2
 JfuxxebM7iXPM4R2eBiD5RZ4SjsSpyEaDPEm9bV/x6IB8qVbvNlsBfsTI7VfpCPGxU
 Zlq23DJ5mVa0g==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33944381671so464065f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706035394; x=1706640194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpcO92XOl2zNt9sq2MJVJ7XaxnnPhG6+lYWq+HSy79Q=;
 b=NYGLbBdLmamSn9StTgDCZjxjWcgtxqKTyyXhIGNHxdJsaabNKGMKwrZAe8Cfj8GCcM
 K7HiqZssYleJb6X2bm/fBXvki3r1ambY0E/38XukYQnQFOzTPqqVotS97MDoi4wGUb4L
 BHxhy7zLL3usJ+BCdcvweoyODOmEeovVssJJhGHuOjJ7E/LBXdSmcJiU1oTr4FUG9EBj
 1x30Ob6EN0Pi3hPKpy6KXAd80M1XhqT7szNNxeAM4CROTCd4n66BwA981IQ8HTLFKh6c
 Tqek36UCQe6Ec1DxmzXVWtjZ2TWuS3phBUm9FzSncquUWpQG3ENr9QSVvrSlIq1vEgXa
 FVvw==
X-Gm-Message-State: AOJu0YxIaEM1sLw16YftuSTULGOHeAYQh9DPiMa6ANQNstmNm4xeNjYA
 anEapmMVAiY6hO2IMLs4T8qYs9j+sn3chDUY3EVXKHI25TsYUaRkwZ3lhH9Hn3RQv40+jOuB7Il
 gNW0Z+V2cDezqyJTfN0/6tTZp3rB1mrcRCTZpLQkfCssDF2RNwgO75MFm15A8fADCdXeU
X-Received: by 2002:a05:6000:1191:b0:337:c658:9952 with SMTP id
 g17-20020a056000119100b00337c6589952mr3233715wrx.107.1706035394513; 
 Tue, 23 Jan 2024 10:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu0IRY8+uf1KeQwVMffTCixbfa+fmoMjDnc3VXSJ4eZMwG8v35HE8xmwzX+psaF/O6gw4x/w==
X-Received: by 2002:a05:6000:1191:b0:337:c658:9952 with SMTP id
 g17-20020a056000119100b00337c6589952mr3233701wrx.107.1706035394265; 
 Tue, 23 Jan 2024 10:43:14 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a5d6ac9000000b00337d392c6c3sm14180252wrw.13.2024.01.23.10.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:43:13 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 4/4] qemu-options: enable -smbios option on RISC-V
Date: Tue, 23 Jan 2024 19:42:29 +0100
Message-ID: <20240123184229.10415-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With SMBIOS support added for RISC-V we also should enable the command line
option.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v4:
	no change
v3:
	no change
v2:
	new patch
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d90bdffc7a..935aec7cb9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2697,7 +2697,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 17 fields\n"
     "-smbios type=41[,designation=str][,kind=str][,instance=%d][,pcidev=str]\n"
     "                specify SMBIOS type 41 fields\n",
-    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH)
+    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH | QEMU_ARCH_RISCV)
 SRST
 ``-smbios file=binary``
     Load SMBIOS entry from binary file.
-- 
2.43.0


