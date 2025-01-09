Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A34E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 05:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVlRW-00022j-60; Thu, 09 Jan 2025 00:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlRU-00021z-B0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:52 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlRR-0002jc-C7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:52 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso721337a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 21:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736401847; x=1737006647;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jc95od6IQg6f70QGQpCellZ5qI3E748aCTYw0+hwN6M=;
 b=TMaJJwCSoPQmyK35GmFmk8M2su1fpNn8k/KHVrPYphdhJ5MKNr8TW3cmUNUWTz21uP
 BQK4Ndv7oVmfXIvLFVggoZmRD5Dv5+S6JUhJEQiZHGwYkplt9LsdaCVirluHjYB2sLzw
 70gmf66vebAu08zCILVrsDwP83AFreBze97nDhTCnzE6/0A4oumIQo9L52NvV0PyFac/
 l1hMe3wDWo8k4f5qid8CoBL1AEPxtEh/N+StwTFU2Bse+eJgTvOsaYi8DW902ZbeP1kk
 GwdXHtlvmg+BTudtuUV/IhVb/0RsEK6QWncGA3cujaxFP0sKvRQe6O/9bb1KgEF6s4vR
 wU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736401847; x=1737006647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jc95od6IQg6f70QGQpCellZ5qI3E748aCTYw0+hwN6M=;
 b=tbCaCFgkfnS4BdVtXY8YUH0OVsL/Xzl8NHiPvmceQ3VQUVOvLsbXxPbpa1J3onvUX2
 Mp+FhW6WP4pZgfFY7nSAVi6zTDAlRKZTVNmXR3AUku+RqojGdxPu3UsrQx3j8gN3RVKn
 B50wWFQNGJ4UZGdTHkKgdSDR7YHaXUDJ1OwJF4JHUM28eS4YFMqVsvvOGp57Fd5jbCLR
 FLg2+Yc51sXfkREQeUU0eonwcraYPF/I7F7lTZbYdMy9pSZ05vWZv2XedUDHLPrYth5b
 F5EyjwLQ02pA6EBnwhlKpIrC4V663uVToXeyZDwNDEyQs0d7D5bRpRst97Q11tBrMjFV
 FO0Q==
X-Gm-Message-State: AOJu0Yzb6RIanKn5jvKLAFA/3NoQjGCaMxvXHuc3jiMEfsjOBtZX34pQ
 HuHdXG0Tz4m5B3kFgmzm9Yk5025TmJj18IrqJrOcs3viwyZeP5Q7LNShhzMlvm8=
X-Gm-Gg: ASbGnctvdC0Oxkdretu08Bh5CU0XR7WBSSVP4ac9jMNuS2ala6lE2HYYiSuR+Wa8xMz
 Dc2+gEc9mW0QdntE926HHV1zljpFno1C7ZmXwidScfFRGtrRncGiRnFxvEkCoj9jzYM2ELqZU8G
 4Y4MlcxuLbWrLlgpvp/u10uHhnXced61nmUnDsdjCZO6wlUgyPOY3iQteZv3yqWuJe4Olb6PQaF
 Kca0vXafkdNT6kFCXwD9ot3AwSrxzdU0mtYly0AM4L1xvWuk/sTjomllsI=
X-Google-Smtp-Source: AGHT+IGSsdc0DcgVVtQTvR0+LdFlHrYdwnblOCPSyX0rL+QavasK2yLQt9ZrVNsbyIgMAnmjouBcyg==
X-Received: by 2002:a17:90b:2748:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-2f548eac034mr7936209a91.13.1736401847059; 
 Wed, 08 Jan 2025 21:50:47 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f559469fb8sm450921a91.45.2025.01.08.21.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 21:50:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 14:50:21 +0900
Subject: [PATCH v7 2/2] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-san-v7-2-93c432a73024@daynix.com>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
In-Reply-To: <20250109-san-v7-0-93c432a73024@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

memory_region_update_container_subregions() used to call
memory_region_ref(), which creates a reference to the owner of the
subregion, on behalf of the owner of the container. This results in a
circular reference if the subregion and container have the same owner.

memory_region_ref() creates a reference to the owner instead of the
memory region to match the lifetime of the owner and memory region. We
do not need such a hack if the subregion and container have the same
owner because the owner will be alive as long as the container is.
Therefore, create a reference to the subregion itself instead ot its
owner in such a case; the reference to the subregion is still necessary
to ensure that the subregion gets finalized after the container.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/memory.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa83..972617b0192d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1855,6 +1855,24 @@ void memory_region_unref(MemoryRegion *mr)
     }
 }
 
+static void memory_region_ref_subregion(MemoryRegion *subregion)
+{
+    if (subregion->container->owner == subregion->owner) {
+        object_ref(OBJECT(subregion));
+    } else {
+        memory_region_ref(subregion);
+    }
+}
+
+static void memory_region_unref_subregion(MemoryRegion *subregion)
+{
+    if (subregion->container->owner == subregion->owner) {
+        object_unref(OBJECT(subregion));
+     } else {
+        memory_region_unref(subregion);
+     }
+}
+
 uint64_t memory_region_size(MemoryRegion *mr)
 {
     if (int128_eq(mr->size, int128_2_64())) {
@@ -2644,7 +2662,8 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    memory_region_ref_subregion(subregion);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2702,7 +2721,8 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+    memory_region_unref_subregion(subregion);
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.47.1


