Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FFAC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RN-0006uI-Gi; Tue, 11 Jun 2024 10:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RL-0006sz-VI
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RK-0005y5-IO
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPch0uxETyXrwagH2Qpo9vfE2jSSoRJkvCU9KTWsNF0=;
 b=dNT1kY43TxMs9cS9RrNqsgmZ5vwRBqtMya+FB2kRkSmywK6oddP/GbsJaEb2aLemjORdG3
 gdf8Ie1nAcxW95IRVDZGV2WZKVJgJDFmxGW0EO1bdOajxhemftJZx/6Q0f/+ddnFj3c77/
 LjFxYK92nDR03GVQcNkeSWf2oYQbNi4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-39AxKCaAOd6acOvMm4p7bQ-1; Tue, 11 Jun 2024 10:25:32 -0400
X-MC-Unique: 39AxKCaAOd6acOvMm4p7bQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c82112f15so1626372a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115930; x=1718720730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPch0uxETyXrwagH2Qpo9vfE2jSSoRJkvCU9KTWsNF0=;
 b=hISUF2pwt5e4pWfbT35bQsDl9ekW31ESJX/VXbP26orNkOXVHms2Yl+SE5j0e2rOfO
 K1LfMHNXRDpOyUVDTXMtRsbpTPHQR8J/qTc67wEXb0c9BO9yiZX3lL41DMcC3YlMz1gP
 aUSump9sA9rsp+1CMvXzhfYocMaLSFO7hdFWeVn4mAwObrLzJFeccgQHzjX7UNFpusSn
 p0Me0lTJyB5zNyaIQRd+i7CF4fq4Fb64qZfg2Se+Fi23WlQSAH1Fs+FVc961YjDvlstK
 L4Rn6gNnMYqYsvzB+c6TBy7Mc+xBw4TdqVkm8Sp0ftCNuGQjUlBd85yJ1xczB/cmxRoJ
 YWSg==
X-Gm-Message-State: AOJu0YwW5uVfHUL7OukEACgg6y20o+wFrNxcGolfhQS7lei8K0k/JVsA
 /M7BwQqwH5jEQu6r2e/IUNfthmh+PPhIA5ctwX7JwnSw4VQsvlr1+G7ikZfkSwPuyjZgSvjXx/p
 ZJPvfPBicV88eULPpCgT+ee/vql+dnyL79BGzYNC+hMLqCT6HGP/md3X8K+lIFzS7d2pf+E2MKK
 g+48i13U3N2l1NWoJf0jhojmq5AQWI1f5HpHE/
X-Received: by 2002:a17:906:57cc:b0:a6e:fd41:6315 with SMTP id
 a640c23a62f3a-a6efd416449mr550070766b.69.1718115930627; 
 Tue, 11 Jun 2024 07:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQlRu30n2VyiLe18psoofrVjKIFvaMHgw79XBORkgBIJBbuXkuTS0x/RgzedHH+pDsvvSgNA==
X-Received: by 2002:a17:906:57cc:b0:a6e:fd41:6315 with SMTP id
 a640c23a62f3a-a6efd416449mr550069366b.69.1718115930167; 
 Tue, 11 Jun 2024 07:25:30 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f41a25e9asm11023866b.90.2024.06.11.07.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 03/25] i386/sev: fix unreachable code coverity issue
Date: Tue, 11 Jun 2024 16:25:01 +0200
Message-ID: <20240611142524.83762-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

Set 'finish->id_block_en' early, so that it is properly reset.

Fixes coverity CID 1546887.

Fixes: 7b34df4426 ("i386/sev: Introduce 'sev-snp-guest' object")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240607183611.1111100-2-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 004c667ac14..7c9df621de1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2165,6 +2165,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
+    finish->id_block_en = 0;
     g_free(sev_snp_guest->id_block);
     g_free((guchar *)finish->id_block_uaddr);
 
@@ -2184,7 +2185,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
         return;
     }
 
-    finish->id_block_en = (len) ? 1 : 0;
+    finish->id_block_en = 1;
 }
 
 static char *
-- 
2.45.1


