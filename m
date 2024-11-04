Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60737D132CF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xrL-0001Lb-Dz; Mon, 04 Nov 2024 09:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7xrJ-0001Jf-65
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:15:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7xrH-00070P-6r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730729705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=D24NSV5flkZGHKkMCF2z3QcLJGjysJYdAQPvoBinGwY=;
 b=RnJzDRdy43wfbXdOeLvNQgTFzLSwNVyPKCU6C3cKD/tFuHuJ1BmepAFxd4cNyujimvTD/0
 UP4hJnbeyvroysl7GuT2SGK47yKCKy0XA3NRzCNdEk6GWPQA5jBHURu/rmCCavvmcFHCiJ
 SEHlypctH4DLw+ua7iCuRHZBHS4LRKc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-_n0nsSKAOpK8QLUyGAroPw-1; Mon, 04 Nov 2024 09:15:04 -0500
X-MC-Unique: _n0nsSKAOpK8QLUyGAroPw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso3057229f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730729701; x=1731334501;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D24NSV5flkZGHKkMCF2z3QcLJGjysJYdAQPvoBinGwY=;
 b=GHgt7V0VDihBTlDsmQ3CHjIsMppuXgq6PTr3iXOmjbBm20DeF/IUNeK7wtaYyv4eD/
 0Qz6V6PDhwllnY4VXeppEcz/3zDNpk995HV6qOxOUjS6LY8tZJTZg/qo2onyc3uVzkVf
 8+IoJ//UajO0Nj+s1Hae8ouTgUx9ufdFnvNjypkDqTQ+MisQuuC5Y4DkpmfXOa5KLerK
 7unl/hBXdFQT6bg3y6a2c7rTQN1GyG1KeMlT5TWpnb8JxHG3mRvgDXrrrGeSuGGF2bwP
 LSVDPVAB6xS3gts0YYq9ALokZpIri5GS74FGYlNx2ZFBPy/c4hIpZQEkUUAdcdTTJGRz
 w8WQ==
X-Gm-Message-State: AOJu0YyIPVeOWHInUYYzsgEo7zz0ZussgygbZtZFe8CvoSKaVFlnb4x8
 0f3tihF2VuqCKEfGXGubt28WPiD0LFGqupI3AY0BPKXYxPxeVjqZjKj1s8UcJ7VqkLgw0qCz5vg
 N9A/GSnGuBMGIrHsEXw7ARCVsoARllbt/hmGIbRbIuJU88ElgXN5Q8Ubb+emr6GlWMC+qxz/N1Z
 cFeL+J5MEyNpkro1D00MsMsjRzgcnBGg==
X-Received: by 2002:a05:6000:1848:b0:37d:5359:6753 with SMTP id
 ffacd0b85a97d-381c7a5ccbamr12535719f8f.15.1730729700943; 
 Mon, 04 Nov 2024 06:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkcN3sp8+SGi8HGIMAhiRvQoMn4K89J7d3rkVroPdAL7bvlGI03Rm9ZegJHfg5iJshaR+69w==
X-Received: by 2002:a05:6000:1848:b0:37d:5359:6753 with SMTP id
 ffacd0b85a97d-381c7a5ccbamr12535691f8f.15.1730729700496; 
 Mon, 04 Nov 2024 06:15:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad90sm13330579f8f.99.2024.11.04.06.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 06:14:59 -0800 (PST)
Date: Mon, 4 Nov 2024 09:14:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH] acpi/disassemle-aml.sh: fix up after dir reorg
Message-ID: <ce456091058734b7f765617ac5dfeebcb366d4a9.1730729695.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Fixes: 7c08eefcaf ("tests/data/acpi: Move x86 ACPI tables under x86/${machine} path")
Fixes: 7434f90467 ("tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine} path")
Cc: "Sunil V L" <sunilvl@ventanamicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
index 253b7620a0..89561d233d 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -14,7 +14,7 @@ while getopts "o:" arg; do
   esac
 done
 
-for machine in tests/data/acpi/*
+for machine in tests/data/acpi/*/*
 do
     if [[ ! -d "$machine" ]];
     then
-- 
MST


