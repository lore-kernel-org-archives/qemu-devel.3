Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C5C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQV4-00069G-CM; Wed, 26 Jun 2024 07:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUw-0005x4-VJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:35 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUq-0004om-BQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so53930905ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400047; x=1720004847;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iVExPEERs03d8J7JOBkBCKVU3MF1YFO5OIPVbHq+rGo=;
 b=PJKT2esgUPOSw4PI1EviJa7jzgkEzKz8wr71MnZDp2IK/jlrk+dCS3nlm0ms4jHOvp
 qzYXEEUc/MZ24ig7zqKsLZJVV30vCxYafjzoGSuq2+a4Tec4G4ex8Y+Z8azB7MCfXh8a
 92ws+Sy1yHDe/bRz3IqbfEw06HO3nO0AsUrsbFIBr9ho2nQmfZ3Rd22oICkkUCD2luW8
 dhHBOzk2whFQcRUJC7nkbTQzPB7J0iQrvoq3tF4d2n8RHO3HMI7RKEBDwwChLpBG4uxy
 +Z/i0nJ3TlyXNRyD/5+B4efdhXeoW4iHTC4pjsG7rg9OF7PP+LSRcjZlVxw+AmXmhedH
 kZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400047; x=1720004847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVExPEERs03d8J7JOBkBCKVU3MF1YFO5OIPVbHq+rGo=;
 b=OuApOCNywMR+5ddyTi8KKA6t7yvN3WgIbLM5msSVa/LcSh5TgbjqoAKpYSnY9TMeWw
 7/eUXdAYnzgf3r9xlpSMB97ONacC3TIWWGeRBHuZaS2hME4KltxtkBMebyt9oIhP4LSl
 SYMdUwbRHCPLaEI9/FK/VBFVNDUQINYScz0NVovaeEXA3J60yI+XeTXq7DBT+GPpDwX0
 cuzo0wTpeXV6lRkTVSB0JZBTMxGJSCr6T2NSBzaeJEUmAV2wJEgOR2+TvH3RwhRpezpP
 fBcIVhFGcSxwu9d9gExGx2KV2kY4yLEB6DpTHX2pGbnCCCE6FLiSrlWEN240oubV3Q/F
 Hclw==
X-Gm-Message-State: AOJu0Yz4cGKmBSVKLFSlJ68/vAaAMu+PqQh/uUkUZmqKLLuKVkphU/qJ
 nvgDW46CuHuyRMbKBu1iT6YuXVaqyu2E95uFXi9fdQZz1RUe5T1bZ9/YqDGhcm0=
X-Google-Smtp-Source: AGHT+IFHZSiES9BZEEPk+NXe29hftgQvC9L7D5dfAK7MIvE4y2e9kzrX+7AOJKzd50WKmiX8oIWT7Q==
X-Received: by 2002:a17:90b:1d89:b0:2c7:9b9a:7619 with SMTP id
 98e67ed59e1d1-2c858275bd3mr9505817a91.32.1719400046756; 
 Wed, 26 Jun 2024 04:07:26 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8e3d5c212sm658497a91.39.2024.06.26.04.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:31 +0900
Subject: [PATCH 08/14] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-8-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

A memory region does not use their own reference counters, but instead
piggybacks on another QOM object, "owner" (unless the owner is not the
memory region itself). When creating a subregion, a new reference to the
owner of the container must be created. However, if the subregion is
owned by the same QOM object, this result in a self-reference, and make
the owner immortal. Avoid such a self-reference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 9540caa8a1f4..6645da02c658 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+
+    if (mr->owner != subregion->owner) {
+        memory_region_unref(subregion);
+    }
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.45.2


