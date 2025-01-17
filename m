Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1695C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCq-0001bt-L7; Fri, 17 Jan 2025 14:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCp-0001af-44
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCh-0002DP-8R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A81qJn2EL6E/QyMc/gOAoSx6A9iJTPC6iOP+Z5fufcI=;
 b=QSLF7rqyjU2wKC1h3Fujf/HnzZrbJXwsjV4ogrJ5CjcHqEoHp5RwPfFjbELOFlSqCQP1k7
 pU+PUMAHFhy+01swIz9FqbMYaQg7adw5g58AG8xOx2lisrOzmo3gZywJGm6AVTPUHwWYyq
 euifvoNqhJ9cUy2yrPVyv8gAsYn2wRM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-mU27WBnFNkSrN1kJjUUbuA-1; Fri, 17 Jan 2025 14:40:25 -0500
X-MC-Unique: mU27WBnFNkSrN1kJjUUbuA-1
X-Mimecast-MFC-AGG-ID: mU27WBnFNkSrN1kJjUUbuA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68952272bso289582766b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142823; x=1737747623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A81qJn2EL6E/QyMc/gOAoSx6A9iJTPC6iOP+Z5fufcI=;
 b=JhlgucIt2OaL288MfoT/1L476tISzPWd6B1ERTl+YIOeBPWpw62WtGWlhHw+mbnHmC
 PeXTNpat39VmZq0XpUxe+YDzY07iT7nk+nW226JKnGbSribDjLwWHy5bv1ATgQroacMc
 ypAz2uHdLyi4T6BKxUx+/5wLY4Nf/xSqJwFtONQKOF7v8oqLObVSkvGazl9WxKm+m4Q6
 2HxifAg1HNyOqLPO1fm16IoczEV+Enx0OPDT8zLZqpcq74KC1iehKqEqG3+AonaQilii
 mNik0L9PDpfYTcPRUZ2tLwTj8WxxtCXZdLcq6JYBfSNmNSegg7xbHGWSEVOC6dtrSSYk
 9AHg==
X-Gm-Message-State: AOJu0Yy95z6/0JSEgHwP4VYdNgE+9HfCljmV/fW1qfxkwZqUAF6GS3c0
 /L369aM9fPeEvH2kVET27kcOoYQuYVj+58ibfrrKv0HDsJ48Y4WS27GDkt9n6L3gU4r2zjGGOOi
 CyG57DhR42sK7OWXT3Q52F6vn+Pz6AleY4w5dYWJ6bFDg3MrG9EeWEqEaDivyRMlpPYUriZ+ksB
 v1WissMrTZWhR872lVpsTDkQQtXa1EXSDDD9SltRM=
X-Gm-Gg: ASbGnctgtPqZu+qx3bPv1USIO9mj24m3UDujqb2lE3rXCA/UveYi8lsqeiCpn2uQhgU
 OFoglJAdTB5TMdv0DUi5o4mkQAodHQNrCFktYSqxXEU/trXatvP+DmirwVK5lxHxy877cJ1Y/Op
 MXIl13PkSr5RbGKmAYYc+andg1ToyEIKcv5l7/RaFUtL+ITznmtECWv+bKIYhccCUE+NdXzaTah
 1u74Vq3aZGeZIGAvW2IUDVlLAI1CcHAN8/QniQ46S4s6wVAeodD2gInXASf6g==
X-Received: by 2002:a17:907:9802:b0:aae:8491:bab5 with SMTP id
 a640c23a62f3a-ab38b30e1admr345573766b.26.1737142823242; 
 Fri, 17 Jan 2025 11:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2DRY5RAxoi0USi7TxLjP6LuLwhm7HLPfDLog2RFrIdUOus5b4CwuEYkSzedMlE9HVgpG5AA==
X-Received: by 2002:a17:907:9802:b0:aae:8491:bab5 with SMTP id
 a640c23a62f3a-ab38b30e1admr345571766b.26.1737142822809; 
 Fri, 17 Jan 2025 11:40:22 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab3848b2047sm218476466b.0.2025.01.17.11.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 07/10] rust: qdev: make ObjectImpl a supertrait of DeviceImpl
Date: Fri, 17 Jan 2025 20:40:00 +0100
Message-ID: <20250117194003.1173231-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In practice it has to be implemented always in order to access an
implementation of ClassInitImpl<ObjectClass>.  Make the relationship
explicit in the code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index f573712550e..ab883e2faef 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -21,7 +21,7 @@
 };
 
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl {
+pub trait DeviceImpl: ObjectImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
-- 
2.47.1


