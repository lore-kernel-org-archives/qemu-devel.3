Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B7606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsZAewhx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA5V-0005mh-ON; Wed, 28 Oct 2026 16:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA5O-0005cX-Ml
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:26 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA5M-0002Mm-6I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:26 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso3297571c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218642; x=1793823442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qeJic+QEw42e1R7DnD3Kz3eNjwxP8HN6flh/y3Ftq3M=;
 b=hsZAewhxJs9pRBCpOVtHdP7DjVbPuwRsc7TCdkOKS/bXEOQYVMJbVNrGmXfWsbnmAX
 BysNciOFt5iCU/Ijq3WF0phN0u7XiCDnXeckrmwmfDNKD/mIPecpqcvtHiqt2J3FMkWw
 kF/Ml+YU/8UMLH9Zy0+jiqUkDVaSerN4CAFzE/ZRHQjgVAHmyGdyyDM4/zZevpeCiJso
 wk2UxSTIURmvbDSEkL8tmSwwHmrYUeqG433YVFa0JRO+aQw1h15EElww80J/xour8QIp
 OIfvT7f6LJyErKtoaxL3UfGAQREOuUtQKPx1q9zd+h/d5awOhwfZwBUzwSvhGI0K2Mrx
 7j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218642; x=1793823442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qeJic+QEw42e1R7DnD3Kz3eNjwxP8HN6flh/y3Ftq3M=;
 b=EgeBkkUbMdLEwSy9PCiKA7sjbuP4mPBmVeO6WCFVYzwJfyUJINYP3VEjqGexI1lWQs
 Q1AFJ9oF20BcbTAq2qNwJBUasn0m447drrRSPpXbJGyTq43QBRZU+IwZ0gRHNHXhamyv
 OICEOcei6CHKCFIg58A1DCaValMvsgHRWddJZmyHzIh5zgFH0ApD2CHJNPxqDXF6othK
 spMCUaHE57jp13FDdVgp7za0aEBiGyo80H0iW/7LDqakpTAFZnaMFl14nG4lmfJkK7Io
 jw/VyoH22FuOu7DZ+MYruDiY/eJhDg2VoLE70pIQh6qTOLORSWfpzhtMO5lLATHY5TL2
 N7Xw==
X-Gm-Message-State: AFq9FYJk0oLiXKguYvRFzSvkW9uPRGY4ySMuRvtXRMw01hTpP5q+Ii+z
 A0rZiouNXwR8vHIe3Q6ilh0Dcc1azPswyuFTcsOHjoYQlcOC5lA66mIfiU4sg+/C
X-Gm-Gg: AYBFou37IOg+dn54CIx/dxdMjoo7LhwyT5JDdOpjUrpWGNKr0hT1ZhjC6E5iuBOxrJP
 csOR7oeIGNNOUECYbNLe4lNxdHYjAKQEJYvWZ0OXrcSKeidwwp0wUptC5NQ5nPJw0brp7dshMSR
 P7Gk0B3WVXexvKOmgJQtfPOrob6ETslkY+KeNR2TeSR7CYWtVEi4cDb045y0ClFeE0bj94aBNQL
 iVbl9fkBwjZQqt7h+YrkeGzTLtl1NFKlUiVw4rcW8pqE69wrVUGpLodf+CAomPXMcQBrTO7B4W6
 dQB2b0bocpjdN4bZqqJa2w/Dk1wyUvk84dY02UTdvWvyBhTG7NmodJVWSCFUDegXYB6H1yyBZpd
 zjvs0jfXIZPNWEp1UOBb/TMjfrCgOIkBTIdR35pJKT46mPJIG4yXajNdM7MMaOYeZ/a2O+k4AQA
 cesvkSjo4V5O3rEHmyRgpeQxFQorsfZhVrIXwIUiqdOpve9ANl+Ee4KZwZIyVZWfh3NR5S+9eF9
 FeVbGgdbGctbuRpqyII9YO3QEs/uyoVmdiL9+x7jXORa6UUkX+i7Mtf1XpMOZsWfwHHsX5m6u3l
 7lPtmc8Bwgela23KAx/+z8LNYhoDCgPP1bN5kf4Hie5JbI2Q
X-Received: by 2002:a05:693c:61cb:b0:369:f277:7f09 with SMTP id
 5a478bee46e88-36a2046b1dcmr5271033eec.25.1793218641889; 
 Wed, 28 Oct 2026 13:17:21 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:17:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 12/12] hw/microblaze: defer PetaLogix endianness default until
 init
Date: Thu, 29 Oct 2026 04:15:56 +0800
Message-ID: <20261028201557.2688-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..4abb6e0f0bf 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -83,7 +83,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
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
@@ -178,8 +184,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_lookup,
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


