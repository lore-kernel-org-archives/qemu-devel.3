Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B9C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduuh-0006kA-GS; Tue, 13 Aug 2024 13:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduub-0006Pz-AB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduuZ-0002gy-Ow
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/JEbOJkwY4yqdkYnOaF1sKBNaU2b+I2B2V004N9EQqg=;
 b=CrZACC6Icmqf19kxNtHba7TQFubzfx3euGp7gqwMTz+tlK1QXpoRd6IqkJS0xub79px2ZR
 7HkPLCsvxZkl4Eyya7BBjobXM0HCj7kezf9/Kxc1GVb7+rGDwEkkZBu8y1rizaPQrMkK/Z
 RP4GJHguK64PxvA2VKn5fcnJ9FGfckU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-g5psPpo2MQSnprrFJbjSAQ-1; Tue, 13 Aug 2024 13:02:16 -0400
X-MC-Unique: g5psPpo2MQSnprrFJbjSAQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7aa3181bc2so413256466b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568535; x=1724173335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/JEbOJkwY4yqdkYnOaF1sKBNaU2b+I2B2V004N9EQqg=;
 b=QC12VoxC4GADG2CF5fDPdbjQhS/qHg6kz+BJTmpnjqlAFVL6bhXQI0e6AMznwZRUoZ
 DsyWtWuNA7XlAzwfKfKX/EC1wgOwB9EbPc6ivq1bwrYQbgeF35qxnm7KulyQYlvRa3lJ
 ETtm92MLvpRHAVVpHiBj9m1/YfCl+K3KH7hnPSeIVafiZEeJDMQ8qfdXX0T3hOSzqvND
 Ab+eR5OGh/qjGQx3Xj7kRk4IX1Y7C4TDb95zXee9eCOQsWWfDpkPTryqf0HABl7/decC
 1HrXvXFyQAAeYJ/T2hs/BgqfubCJsZ5EMM3aqb8nH2m+yq5fFweXGcMygdH52nxebKHt
 0T3g==
X-Gm-Message-State: AOJu0YxtvJEEetPxW/UL/LT9N6j9PchZzMPx3N3GQyuCFUY7/AzESo5Z
 RqgO87B7aRMTfYiGBtowpEmRVABzN7yJSC/VhCV5VeFrgyIPJD1OCbIpP3qjAAnbWsu92Bl2IQs
 C3v7dOgxZWASCaaZyajIHJGrNM/AFGDdU/KSYQMFvMl7RV/fuWyd2v/B10jlMSynNkzhUuLq2/d
 qWfZV5sgYztBEYNOnDaeXzslfB/Ng7D5fXdKPD
X-Received: by 2002:a17:906:730f:b0:a7a:c083:8575 with SMTP id
 a640c23a62f3a-a836643e5aemr3169366b.0.1723568535019; 
 Tue, 13 Aug 2024 10:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf9kk6SKB0MVFqLvWV47YXWdGR21pethTf9yrHpjC5bi87Xotuare/ckSZQ5qsjkFQyFn22Q==
X-Received: by 2002:a17:906:730f:b0:a7a:c083:8575 with SMTP id
 a640c23a62f3a-a836643e5aemr3166066b.0.1723568534436; 
 Tue, 13 Aug 2024 10:02:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fedd2asm83257866b.96.2024.08.13.10.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:02:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] po: update Italian translation
Date: Tue, 13 Aug 2024 19:02:05 +0200
Message-ID: <20240813170212.103524-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Reported-by: bovirus <https://gitlab.com/bovirus>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2451
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 po/it.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/it.po b/po/it.po
index c6d95172070..363b9bddf2f 100644
--- a/po/it.po
+++ b/po/it.po
@@ -65,7 +65,7 @@ msgid "Detach Tab"
 msgstr "_Sposta in una nuova finestra"
 
 msgid "Show Menubar"
-msgstr ""
+msgstr "Mostra _barra dei menu"
 
 msgid "_Machine"
 msgstr "_Macchina virtuale"
-- 
2.46.0


