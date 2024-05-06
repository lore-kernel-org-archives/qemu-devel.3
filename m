Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33EC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9p-00083S-Tt; Mon, 06 May 2024 03:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9o-0007rS-4R
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9l-0001ma-My
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S79rhkI+WG9h3dJSlLxh3jusQtha4EiVXb01UkoHtUo=;
 b=WeYJQ0RPs4emCV3+l0DfqSOrQl+m7oNx9BbGD7AqDXoI7DkKLAxp6sQ4aQ35T6XLrFgXVk
 ZmQ2/mqv6HlX7Q2gV4iONsTD/pbpffMnArI4DvIKefslIheJWuMukX4H23pc0nHxMWFV/H
 93MI8UWFvKbcryKjYgWi8LplHoEgLDI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-FqkpD8lQP9CFP2FBlhCxag-1; Mon, 06 May 2024 03:53:03 -0400
X-MC-Unique: FqkpD8lQP9CFP2FBlhCxag-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59cbb6f266so53765366b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981982; x=1715586782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S79rhkI+WG9h3dJSlLxh3jusQtha4EiVXb01UkoHtUo=;
 b=Og81JOIlpLPeiwScfWN/eDmmfe/9YCTLj/GGWf05lFHx0RH+eJWAUkBJY4im0rL7HX
 2w7kpPwSh1ZzwppFGistJxOxpL4I9UrySjpoh7UknWN1DwiAG+0wPjv5XaxmU0BBpqFy
 cgmU7SHNnLYwffp+gIEwk9WcXMK1yX+sNMOC+7leUXjd0NIwQJIuinndMQf99fA5UKEa
 oihyfXmiKIQbTTQAon7onuLRiAmcHVEcavqpIUWJQ1yBx4I0CIoptXsF0m+xXW/hsFwd
 Ccez3VytXKkIGbnbIkx8Vks354TRiBIxtJNCQCnFaOjgaOnUoxR2OTmoZCrJFOdZHqvU
 4BBg==
X-Gm-Message-State: AOJu0YwMBgJtPEFe6Z2azVnWpChvPJLpsfMjEG+5+F/JhCh1bGNZ64ig
 koTb5W7k+yXiqmVe2pQ+1A1UkkP3f9rF4i1Ewx88U2xyJGKTi4JwKpfe9laaf99yekAT94y7eHD
 L2UlejFeSLh59+QwRTFca01yiT0ASsmPssavZVg/jlG1U2o2nGtNZRMYKbUnzBa9SE+BF+FOAA0
 9HtXxk8vdS7jNww37OWJ1l/HJTPdwoR17f7u7M
X-Received: by 2002:a17:907:7e97:b0:a59:b1cf:fea0 with SMTP id
 qb23-20020a1709077e9700b00a59b1cffea0mr5169006ejc.19.1714981981884; 
 Mon, 06 May 2024 00:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuo4ay43Y+SD3eAJ8jLaiHiOsgjHFvB9uAHvQnNFuMkwXxBPaUQgADOFmg1HBNB3qgp8zS9Q==
X-Received: by 2002:a17:907:7e97:b0:a59:b1cf:fea0 with SMTP id
 qb23-20020a1709077e9700b00a59b1cffea0mr5168987ejc.19.1714981981546; 
 Mon, 06 May 2024 00:53:01 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 my9-20020a1709065a4900b00a59ba75059asm1963522ejc.153.2024.05.06.00.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/46] migration: remove PostcopyDiscardState from typedefs.h
Date: Mon,  6 May 2024 09:51:17 +0200
Message-ID: <20240506075125.8238-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

It is defined and referred to exclusively from a .c file.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h  | 1 -
 migration/postcopy-ram.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ab24ca2876c..2b1948a19ac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,7 +96,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct QBool QBool;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index eccff499cb2..34197795482 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -44,7 +44,7 @@
  */
 #define MAX_DISCARDS_PER_COMMAND 12
 
-struct PostcopyDiscardState {
+typedef struct PostcopyDiscardState {
     const char *ramblock_name;
     uint16_t cur_entry;
     /*
@@ -54,7 +54,7 @@ struct PostcopyDiscardState {
     uint64_t length_list[MAX_DISCARDS_PER_COMMAND];
     unsigned int nsentwords;
     unsigned int nsentcmds;
-};
+} PostcopyDiscardState;
 
 static NotifierWithReturnList postcopy_notifier_list;
 
-- 
2.44.0


