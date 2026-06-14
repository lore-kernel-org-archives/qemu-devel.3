Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB3ACD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDN-0008Du-3V; Sun, 14 Jun 2026 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCu-0007RC-OO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCt-0002WM-A6
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCsEBchDqMJf36ggGyZ9NuiwogF7rzLKHNisGDcVuX4=;
 b=b/Kv1hNpdtiPwsN3HWtwo7GVP6z5pNMaSMVWK0KGfuWRZr1PFuyYX8AIDpDIhpQ6ZN++Fq
 ldfoek/Bw+bNsG+2lvC7utGf5G1R2Fbg5jFV4L0kYG5foTPFpLSQDtrP6G5Pi0m1uIbTYk
 06dEhGd+Ws0gJ5Cg9DLvDqTYH/PKuyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ikBQojwANz2hyHAVxh74AA-1; Sun, 14 Jun 2026 15:09:17 -0400
X-MC-Unique: ikBQojwANz2hyHAVxh74AA-1
X-Mimecast-MFC-AGG-ID: ikBQojwANz2hyHAVxh74AA_1781464156
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso23756675e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464156; x=1782068956; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cCsEBchDqMJf36ggGyZ9NuiwogF7rzLKHNisGDcVuX4=;
 b=TQ/Rjr6KcFlfpBjnz34aaMwNxxasbaYofkuYgx3AoZE54p0/QdtES0RKhHWtqvNgam
 dQHF+IA9VetwMpPRBpAzjRRIXq4fQuSYhhwqKA7on3RoWoAO/tZhaBtLt5ubDLBsCyaz
 M50Gxizp1d+SNqUuCRQroEf8OivLI8lJjCpJoa5ywJ75pXqoY3tmrmd3ZQE0RtIlCrpf
 nJUJ4aeL8lAqpmfCbNsHUzA9pS8gNlxvUETPsZhaRVqGNd23B2MqV9cHD+FrgAH03VBu
 1XmaTCmHoeu+mhwLYvXegziZTjfPgV/Mkjx0avSSwHADF0EBMqVZGpb1dV+GNgg02MBp
 CXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464156; x=1782068956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCsEBchDqMJf36ggGyZ9NuiwogF7rzLKHNisGDcVuX4=;
 b=HslCWJtFWLjzoBazzC6cteMVNM1kmNKbHvw7RThPfr0DwiQ5iWSF/VPPrufvzTpMF5
 VZJLDwsm/sSxIxwvYS1Qn4HMfdDzSAF/fXb3USmNbfkEqAeh3lgIzohfAhxvG28HnN3y
 SWp7dzvGHeSc/WdQJxli6Zps8tRjcIwv+dAzjmF+a1WXD6ZVQgHGAjas7syykWYnC9D/
 N7EjhHqim4gsTInR9RrMaDd8Z+dwBTgDBeuKbA8DnXU16LuCuNFX9PugqwTi5B4A/6zI
 NjSB6SOV71UvHCEj9BDhxId5HcelDHsa8O7IP+ziXof0JuDacs+1NjBv6KQYpCQua0Ew
 yz2Q==
X-Gm-Message-State: AOJu0YxHjgO76tt9je25vJOv9m4PsB4O6sh03qni6cfT6kAZxPCLetnQ
 5rP7MAqz87j9Bc+YHlGSA0xq5IUY4vSdWRUgbWUyPfRJuLWNYfanAPhq2Df+Bw9d8WWBT0Kg6iB
 ERSwYUnuoggyV75KeWbiakWbrsVHDMF8En7tEXSSxn5wMPKF3FU3HmfTqzrQXpaLdvpkbFsUk2f
 krdi4V60PgJFaehbgiNzIn6b3mQhDTibgh/A==
X-Gm-Gg: Acq92OGMBl8iByXrb9K2BsMtF6piFaTZiP6wahEmaug90Dv8dEQYWVQ3iX9qke6pv6e
 bU94rQK0sLgcwUz6H0WN8aIPt/D/omFH3d8D75HoFA98Pwuktza7UVC9cQ0lc71KW2e8khaP073
 9sHu0m+iR7V6j/h7ldGI2IXd3mXHta5Lbh/S8OGX7Y1hWyC7rdMRH6ZYMj6Wrd7Bf2B8JyNbkfl
 1fNaglUfx6K8/pp4HgWmrvjBHGaSHmtsHUdd2R9UHCPNYQkHHl8ol9kHahil6cU2jrysWSb0+Xv
 Mt4ESLoirXjPgGxuzPmc7YSEtdGjxBUJfv5sbPOe9l501ZXEhHJPNydxjN6D5vZUe0R3Blf1yOn
 9NIprRIDX7kuy7wcn2fCx7y41mbDYgTkA3UackHh1NMA=
X-Received: by 2002:a05:600d:8494:10b0:490:c7dd:de3e with SMTP id
 5b1f17b1804b1-490ec521187mr100016235e9.31.1781464156379; 
 Sun, 14 Jun 2026 12:09:16 -0700 (PDT)
X-Received: by 2002:a05:600d:8494:10b0:490:c7dd:de3e with SMTP id
 5b1f17b1804b1-490ec521187mr100016035e9.31.1781464155816; 
 Sun, 14 Jun 2026 12:09:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm29152046f8f.35.2026.06.14.12.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:15 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 084/106] hw/i386/pc: Add a proper owner for the ioport memory
 regions
Message-ID: <653f3b5a15bbc3db564639f7ee50c547f61a002c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Without a proper owner, the memory regions show up in /machine/unattached
in the QOM tree, which is something that should be avoided.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260217141827.534426-1-thuth@redhat.com>
---
 hw/i386/pc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503..a6958b4054 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1051,10 +1051,12 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     MemoryRegion *ioportF0_io = g_new(MemoryRegion, 1);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    memory_region_init_io(ioport80_io, NULL, &ioport80_io_ops, NULL, "ioport80", 1);
+    memory_region_init_io(ioport80_io, OBJECT(pcms), &ioport80_io_ops, NULL,
+                          "ioport80", 1);
     memory_region_add_subregion(isa_bus->address_space_io, 0x80, ioport80_io);
 
-    memory_region_init_io(ioportF0_io, NULL, &ioportF0_io_ops, NULL, "ioportF0", 1);
+    memory_region_init_io(ioportF0_io, OBJECT(pcms), &ioportF0_io_ops, NULL,
+                          "ioportF0", 1);
     memory_region_add_subregion(isa_bus->address_space_io, 0xf0, ioportF0_io);
 
     /*
-- 
MST


