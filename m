Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2FFEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXy-0005X5-Vo; Wed, 11 Sep 2024 08:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXt-00050r-4c
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXr-00012U-1F
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1muO7aVC7mT7zEk/C07F6EvF/ytJrxOdC9V2ewUNBQ=;
 b=Mob7F95if5U8dVn+OnY9qNy219VvEjuEovNta1FOHjvbKQh4xx5dN6aLIUMjKAOIwnlNP+
 HlTrOpWCmhuOi07qzXotN0H3RzbQ3eELSnDvhqsNVdgInkQugpLm/9ywbZmIxuckya7dEK
 yNy09Iid6AVtFiCCbfdGKDvLfaxhU3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-WQEL6bpCOK-zH8KGR2sPPw-1; Wed, 11 Sep 2024 08:34:01 -0400
X-MC-Unique: WQEL6bpCOK-zH8KGR2sPPw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c44e58a9so3450094f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058039; x=1726662839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1muO7aVC7mT7zEk/C07F6EvF/ytJrxOdC9V2ewUNBQ=;
 b=e9hiw+acnJaZN/quWpcZO8ttXTPp3kxe/Z7PDD1YxZxxkeuC8VEjd/1qmfGyInFzeD
 JhcPCPnAUoP2okLcqyRiwTjyxhsW7+jsldQcHUo7YI3g1oLn02bRMg+sAlax0WfzMRfP
 BQyABwUB+x14NkoyD83P+lYHB8CFJF+GiAAtetohKWUsuh3M/bLy7qlvejbxKjg0Vyvp
 Xt1ZbnWxqCQKKMu1BnmghjyekNhU57ud//AK74qhoIAC1T/cryACoT3CjCa8KQuwzFRZ
 +xKyQVHzSoumY6o92d6dZjo2jM4ZoyJPm0P2tN/30KzaTSlbJps1wqqb6BU6RNSuw3PY
 ClAQ==
X-Gm-Message-State: AOJu0YzpgTAQeeQENgCE8NJTKansaea1eQgg+FKYwwmiFNrLXsLSlQNI
 Cwp5wxr0WAJzQuU0G3168t/UR9FniCNkOPxSBygyURu0ztcgQAUm0F06f//Spvge1PjeKj2pdNT
 J/fAUDD5FgtomvHz14Owo4JsSpsTS3u9pB25KKDbiDUwnJbMlMQxYJyZVROmJq8Yt7FSJ/N8pmK
 gCxbDoDCJY1n9U0EXviZQbgOuLyAXdkBGXqpfDkxg=
X-Received: by 2002:a5d:558d:0:b0:374:bcc7:b9bb with SMTP id
 ffacd0b85a97d-378896100e6mr11198554f8f.35.1726058039461; 
 Wed, 11 Sep 2024 05:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU2UDkvAs+nt+uHc8F2lvTHNdGdImuFRcxGDWZQyAykrxIx5tQs/C6WWWJT4MeYg8cZ+NoYg==
X-Received: by 2002:a5d:558d:0:b0:374:bcc7:b9bb with SMTP id
 ffacd0b85a97d-378896100e6mr11198537f8f.35.1726058038970; 
 Wed, 11 Sep 2024 05:33:58 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789567609esm11470721f8f.59.2024.09.11.05.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Kamil=20Szcz=C4=99k?= <kamil@szczek.dev>
Subject: [PULL 05/17] hw/i386/pc: Add a description for the i8042 property
Date: Wed, 11 Sep 2024 14:33:30 +0200
Message-ID: <20240911123342.339482-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kamil Szczęk <kamil@szczek.dev>

While working on exposing the i8042 property in libvirt I noticed that
the property is missing a description. This adds a simple description
so that QEMU users don't have to dig in the source code to figure out
what this option does.

Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
Link: https://lore.kernel.org/r/15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7779c88a91e..f4df8637ef0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1817,6 +1817,8 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_I8042,
         pc_machine_get_i8042, pc_machine_set_i8042);
+    object_class_property_set_description(oc, PC_MACHINE_I8042,
+        "Enable/disable Intel 8042 PS/2 controller emulation");
 
     object_class_property_add_bool(oc, "default-bus-bypass-iommu",
         pc_machine_get_default_bus_bypass_iommu,
-- 
2.46.0


