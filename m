Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A8606A33E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcIcR9PF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3Tw-00078X-NA; Thu, 05 Nov 2026 14:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tv-00078G-Je
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:43 -0500
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tt-0002AD-UX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:43 -0500
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so3478043c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908240; x=1794513040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SqfsJahb0343aGHyFL6VfVG8oC0BEkKW5Of59LmFpI0=;
 b=KcIcR9PF7GVtK822CpgDuESegoPtsKsY6fiwFloLX3/uGUnQ6bJKDpC2PHgiHKXlap
 wht4hF+JRPISZe4r6WrrWuDBCsowCWL/GbTmDBN5QYq9ujVFKIUuWiQ+GslaeOlyDLZg
 SRcH7I5pyHytUxlMVlzPAj+3CaRLIwGzgv/X/OLDzanB9zWIEiPeuOOuGmxBSNSR6ehd
 qrmvFQoc6nb8KPttJI9bbPFCyWX7x1grIey/6Svx25Y42uEAfe14HqI/+hleDBzIn/BH
 +pY47WU8yJ9GiMjsktrAYrdrXjLgrzrBaqNFkwHyh1F1Zhpdx/FSVvCSZIhGKQSGROvC
 ZrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908240; x=1794513040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SqfsJahb0343aGHyFL6VfVG8oC0BEkKW5Of59LmFpI0=;
 b=ypR3jjSiv5vZNMz6Sh351L3ExrC5aHVgBJqJu9ckIeKKasrpMELxRlKcJutg5GyJYO
 noQrLCSHN1jKT1uYF4QGUefS4qvilBD8qG8aafVqCwlmOo1ZXovbjiMICgw2JipbEQny
 tld3XDl38mwYiXC0rPH037b4ZD+2PuiALFrVSm/AU3s1i/l20OZxsRBfai1eGE89LD+1
 8NM4LLCRp09Ym91SdwA7M0J0CfI5h+RxOcWtxyH69FRscwXcNjQghlkdcArnCXEX6qgS
 4t2hZYkyy//MKqhYHLaQ/mVVcBUYK5R0KvZoCKaIuZU4cVvDrup/IKxo/HevSVQmsrC+
 CcTA==
X-Gm-Message-State: APuU4Z8vu3/v0F5jI1eAJlQCmeM+ZxGVrW0aOC5catBz2h/3Pktgue3R
 iDJxHRi2E2qCBnJ5ENhTTGfEHCm/WMbMbatRDm1KT1/71cJ4F7B6EmDznOpvz3Y3OWs=
X-Gm-Gg: AYBFou2B3ou8xXLb74H/SaYnzxZJNfz5gEcdOSsC7FRqlxviZDhGRAqM+v/fePLFt8A
 wjPyyz5+0zVU5qlJoHrhLJ//of1t5lHzjjOpsAZMPNoBloqgijNJgpKw6bDoGwRzw1VzKRWNOWq
 AIZky68WLcaFMsXdDOZvKj5zay2vPaCDztJV6K/R3KvTAy07uG0Q7qlHLzGSDqAEAMCQ/qXqzOf
 2nAGF6KG/gEC0ULQ/TftxGXIcuQlow9H14H6COhKhP5yMUlhZqEvtUNRtbUaJI7X3FENqp1hVzj
 ymM9y4PEYO5OsAzKu1ucAxFv9xHwYyUm/qh1uA09BoiCBjhZS3lvpLIhYFIe92NC6edn3UGhS0k
 nHxbFYPDq54cjuXJtIrfpmrrNjKTv6IcInoXpTLBMdtrwVrNYXSqP+JK87Zgl5AP0guWLrjY1vz
 n+AfTAQoTu3TEK9DKgMHn4iRCD0DrR4Or1WLqxrxTaQsRA38C66IYOcWX94H1D3RYOiQO2xUhA/
 3HHbzkIjnSfliU3MEZk2NmhLJgcHdaNzVLFNbilDAeOzF4OdUEip1wc0SD3LGOwNiFimunv1iux
 us9LtGT87gDVoifBCKFrKZW+wqluIYLmw8Pl1x2aGiyhHWbk
X-Received: by 2002:a05:7022:1216:b0:1a9:f3d2:6262 with SMTP id
 a92af1059eb24-1b25d38a432mr6216c88.36.1793908240119; 
 Thu, 05 Nov 2026 11:50:40 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm19459875c88.4.2026.11.05.11.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:50:39 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org
Subject: [PATCH v2 4/4] hw/microblaze: defer PetaLogix endianness default
 until init
Date: Fri,  6 Nov 2026 03:49:57 +0800
Message-ID: <20261105194958.1117-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105194958.1117-1-luoyonggang@gmail.com>
References: <20261105194958.1117-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PetaLogix machine read its endianness default from
target_big_endian() in class_init. In a multi-target binary the target
is not selected yet at class_init, so the default cannot be computed
there. Set the property default to "unspecified" instead, and resolve
it to big or little in petalogix_s3adsp1800_init(), where the target is
known.

Until the machine is initialized, endianness reads back as
"unspecified" rather than big or little.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 4ad04801ce..27f5e477a3 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -84,7 +84,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = psms->endianness;
+    EndianMode endianness;
+
+    if (psms->endianness == ENDIAN_MODE_UNSPECIFIED) {
+        psms->endianness = target_big_endian() ? ENDIAN_MODE_BIG :
+                                                 ENDIAN_MODE_LITTLE;
+    }
+    endianness = psms->endianness;
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
@@ -179,8 +185,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_type_info,
                                           machine_get_endianness,
                                           machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
+    object_property_set_default_str(prop, "unspecified");
     object_class_property_set_description(oc, "endianness",
             "Defines whether the machine runs in big or little endian mode");
 }
-- 
2.55.0.windows.3


