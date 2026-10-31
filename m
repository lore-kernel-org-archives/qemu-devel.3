Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDhVLnpQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC9H-00034E-5w; Sat, 31 Oct 2026 12:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC9C-0002mF-39
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:38 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC99-0007nR-NU
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:37 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1ae18eb9ad0so1462544c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464894; x=1794069694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n0fy6txPXVLFBkZT0x5hxzLsyPhrX+VI0hJdqwY6DdA=;
 b=iDhVLnpQKBXENvrDTk+bnTEgb2jmncj1dy2qYL7dUkVizGTDAFsXZYRDXlulZsOAMb
 dbWaw7Ii2U7xEhuljdgB15XM+9W3aA3yXK04T3U82ZydVgO9VCmswmpatJKAHfHTbbLm
 0ce9eZxTl38jbziqnyI9t7us35L/wv0Z21svOFaCp5o6Gz72RNqSEOAqkevcZNwn9ZBh
 K3ykGYEfDqMWBLxFrvqw5lTmZccX1S1d3pimAnsfCvy+Sbs9nOGjjZu/TamgZ87ATXiE
 cse5Xdlqx4tofoxlGO+u92BKebWndgs35NdegyMsQy2HdNDIlZBSHGxieg6pHNbbSb4b
 d23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464894; x=1794069694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n0fy6txPXVLFBkZT0x5hxzLsyPhrX+VI0hJdqwY6DdA=;
 b=SHuxqJJjmQ7WgD3Yx1Tz3LgbxctA4+6/dVyWSsT05qrOUCsEk25E/kdd4V4j0hG+wN
 FA76yUvsBd+UFO1BMWYfTimSLxCSK+jTwMMKURaR4l5L1kUMbhZOsbxq+V1fZM5UMyFt
 GDhQC+wGVolKY3Oi6Al21etfszq787Il1ovFRaOIhc3KPCYzBnOjSmB46YTZYjWBy3lw
 MlQw3NlNik5fkr4cHx2FhdW33xHRcIaj5YDgyYRvgZkmobPPThQBimeehN/GVz2+Vm4y
 cKbmP69jPqjC/kW2RU1FxpCh9Lsl7Y7gZKv3WRM/NueM7Bf+mvDm4lWzikLRAIG6KwT4
 mvcw==
X-Gm-Message-State: AFq9FYIRsKOOghpB4tf6MX7oZEctS/pEDn4TIgI/Y18aTYsJme7PHzc1
 Yj6h8GqAMsRbtoySViTozaviVorA3NMdE7An6DH8K6MJM7j1XyixmST/1fqWIDP5
X-Gm-Gg: AYBFou2CSdgrtDkNH2sv5Gp+bUEzkmprBZETZPou2wQ+MAPuTnLE2ujxRQeiD8OEsB0
 NbsL5REgSojvTr8qOeFlacDACpxNLnywYcq1BD2KnWP9pLCvTLGFBGfdlOF2Y3whgEXNSeuCT8A
 wjdS81N8Xvp0bzlNwk7+lVPXcxgxVHEkiHKwnaT6mq0fOH44y4biF2wCgB3PvnP6w87L1KRz3sB
 jAHKzST40BByX7YMJLIIM0yIzgUHRtMl4vEMdJTBEYP/R5v9ZjCFv5baSWn5s/JpWpTNvazrcHc
 jnyZ7mQYqA5HgDuhwxBikgOsdL5nvrSYW1eHJeVfvrJ7/mR947ZfTZLGKVgovRQ4gE1ZS2JMOt5
 VJZYoKVtEi4aTw0NEsplppaevfW0sGTKV1He7iK2SphwfIzwDuSj4uMGPyeaBywDXIMA7bD9/zR
 46bsCpJe5+muP+fh9pVWYxwUNbbMhKPKmOxWwfqqKs1F+FwUoXjHnOTvkm+IrTSeIN2PtrAG7sw
 eXhYUU+G2kzyFtHpnV4gH1+MFPAJ9Q0fraXKIF1m3ZjWtYpr3XmM5kY3hlJdkwQl2/RWQZ9QwCe
 MZNdNJgm/KaGTINRRWBYxL07ZuUZjixDNywFDBwGpVqUCkWx28THAWWmyuMpYs+dg+Z2aA==
X-Received: by 2002:a05:701b:428b:20b0:1a3:dfb6:e593 with SMTP id
 a92af1059eb24-1ac5eea3690mr8130854c88.27.1793464893501; 
 Sat, 31 Oct 2026 09:41:33 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 12/12] hw/microblaze: defer PetaLogix endianness default
 until init
Date: Sun,  1 Nov 2026 00:40:07 +0800
Message-ID: <20261031164009.2048-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1230.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


