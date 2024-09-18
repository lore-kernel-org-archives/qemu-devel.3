Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA243CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTK-00028e-3W; Wed, 18 Sep 2024 14:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTG-0001yQ-2C
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTB-00020P-6h
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEH7XELrrgRUk7dJEbjSFoDATfJsQ4JEpBQhyHZoeiU=;
 b=KanCymPRGiQdfJgMmiQ4P6YM1ljIzzVth/cD0jAzddI0b299tVEDUkCpFK9DyhNckLiRON
 rFGdX+vJymfKi0AcMRfDGvw33m+mfRjnRlU7QZpwzmK6+PYNqtA1RFv7FAPB6y49jw46uM
 tNnEwo3RkBZTZ7EwEGz4bJxw+WzWkhY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-TFSPAV-bMgCuZgltPCnLTg-1; Wed, 18 Sep 2024 14:32:02 -0400
X-MC-Unique: TFSPAV-bMgCuZgltPCnLTg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c5a32ec301so48485876d6.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684321; x=1727289121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEH7XELrrgRUk7dJEbjSFoDATfJsQ4JEpBQhyHZoeiU=;
 b=BxpoxwXt3DSE+pdnKGxEd2OGuq/knbbnXJRIl5zbbVqUf75o/p8OMRHoWJJpeafjdr
 wtu0kqZCI3SyZYLF2N3chm8CodwiwEsABETOgIVIVG0eYUGjvpaPSiFWPmJYuXwga+/c
 tFlBEymBazJ+4bqBZJJFE08IIjgdrI123uiTiqMga322AbszM3+okRAuz5UE+rxhOO32
 3/r7smIw+eN/1pzSfyWu49Rqn9t9fXOU6xTzyaZy88sbGlmiRp8dkz73vVRu+GBdC7q8
 JPByjP2/syhXz15O/N+vUr5ndJLvwHAWQi3LBgy6dNMskC2DNn//Zg6MLkX9dldzdSuM
 gQpQ==
X-Gm-Message-State: AOJu0YxnPFkeDM7XLp1Zck8T/qSXHXuRy3d70NPcc4MzmSH6VDpSiCPn
 Ta8DBDQCKLEASvULVfqNAiTG2SlYC2I7M4YAKZ5Re64k93yBrxLDoiPecMt4vN48ri8gyTO61kP
 K4yQ0KPRPxk5ZoEVvCuS2QEYcPYrqLdJg2Y0ED8npXT/KVP0otmE89Z0yTiuD9Du0kdJIXhW0sd
 L44G5yzn1BQN2OQUDPZ84+VHVF4tZCbe6pcw==
X-Received: by 2002:a05:6214:3287:b0:6c5:537a:ce43 with SMTP id
 6a1803df08f44-6c573539d30mr283698416d6.26.1726684321418; 
 Wed, 18 Sep 2024 11:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbgzGPMSJ4YTNlbE49Dk6/kMVygvukfp1Fa99RuwdKIMNjIMjCvXr5UOPNMGyMaG4z2EP3vQ==
X-Received: by 2002:a05:6214:3287:b0:6c5:537a:ce43 with SMTP id
 6a1803df08f44-6c573539d30mr283698096d6.26.1726684320849; 
 Wed, 18 Sep 2024 11:32:00 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:32:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Fea.Wang" <fea.wang@sifive.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 4/6] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
Date: Wed, 18 Sep 2024 14:31:49 -0400
Message-ID: <20240918183151.6413-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Fea.Wang" <fea.wang@sifive.com>

The follow-up transactions may use the data in the attribution, so keep
the value of attribution from the function parameter just as
flatview_translate() above.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Cc: qemu-stable@nongnu.org
Fixes: f26404fbee ("Make address_space_map() take a MemTxAttrs argument")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240912070404.2993976-2-fea.wang@sifive.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index d71a2b1bbd..dc1db3a384 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3274,7 +3274,7 @@ void *address_space_map(AddressSpace *as,
         bounce->len = l;
 
         if (!is_write) {
-            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
+            flatview_read(fv, addr, attrs,
                           bounce->buffer, l);
         }
 
-- 
2.45.0


