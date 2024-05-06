Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAp-0001xB-Qd; Mon, 06 May 2024 03:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA9-000091-5Y
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA2-0001qV-SI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714982002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoGDH+Rv7yjyMA09L6ivkS5qMJY1NeD7GH9r1OMOy2A=;
 b=aDhsmsP3E8GAgmn8YDzj9R3uyfZUSNdG+pdv/OskIFd2dpKrMZIgsrEw/Fpm/8Gz52/34i
 FFQYhtus/pyJcmdVtUJhz4X/ju1TgLtfzVMtwhniGz6YDZ2+ofg/KR8oeZLj3Po2SaDaO1
 /G9T3dCsrBkZG7cnY7qht+SWjqlVyiE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-RRL5lvGRNo-iRUmMz4SKqw-1; Mon, 06 May 2024 03:53:20 -0400
X-MC-Unique: RRL5lvGRNo-iRUmMz4SKqw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59cdf2141eso36414766b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981999; x=1715586799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoGDH+Rv7yjyMA09L6ivkS5qMJY1NeD7GH9r1OMOy2A=;
 b=i/nvzzthgpgDDsNcx+OCalnHQA5Z1VAinyO4hef+2QTkxkvYAyNPL1zjr/iFuXccls
 DTwY9La4K0lwtg0SNxoVMYSZBnu6vOVl1okjee+R5C8gcIH0La8iklxLPFIzqtNoBvOd
 sFt2bk0/zKf2prVDvKuQ+IGJKrCO+sUGK3WJaLSHrdnNLhDibtJabj72d/SmN4Y5BYaz
 5MnPdJ26zumfY5PsWe2ZFM2QtbMhmDVDKn17LDlmImaoikLiavYizgj8jg7ukFLkJYRe
 qHjHjhx3V5C6s2Xh73cEn2R/5MUYphh0rcNg+dUdJf1PZTblHBwrwGpKSU2h/18tiJIo
 AoIw==
X-Gm-Message-State: AOJu0YwOXMOUdRbhDpA0MDPdSusaBy+KFq+UwWs0D9AhGKCaCfKlDplX
 Xbn7IqExaS1oUuJJXSpdIIa9sD5X+OYmMTMyR+uTqYSFyndGdYpTycFFfi3om1DW/3mOgwqgRzZ
 IBy6YeJAz5ID4HYpooG21ro1UY+k3KkaiTSfrp+g/gVnUkdBjNMPUrhl5KTM+ARYNr710+qQxA4
 +7Zi/RHKdyuwp3ga9PQf4eqZiDA77TlANkbpvC
X-Received: by 2002:a17:906:b012:b0:a59:d6d8:b24e with SMTP id
 v18-20020a170906b01200b00a59d6d8b24emr480232ejy.22.1714981999226; 
 Mon, 06 May 2024 00:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqpZpb2xfiTNorA4wyKgRAykP6qSIhP4NTxuFfg/io7y1wA/7mTNSlVcXNPtNbJmfmTKr0fw==
X-Received: by 2002:a17:906:b012:b0:a59:d6d8:b24e with SMTP id
 v18-20020a170906b01200b00a59d6d8b24emr480222ejy.22.1714981998937; 
 Mon, 06 May 2024 00:53:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bm26-20020a170906c05a00b00a5588a9fe66sm4868540ejb.86.2024.05.06.00.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/46] migration: do not include coroutine_int.h
Date: Mon,  6 May 2024 09:51:24 +0200
Message-ID: <20240506075125.8238-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Migration code needs no private fields of the coroutine backend.
Include the "regular" coroutine.h header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26f..6c612c03819 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -19,7 +19,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qmp/json-writer.h"
 #include "qemu/thread.h"
-#include "qemu/coroutine_int.h"
+#include "qemu/coroutine.h"
 #include "io/channel.h"
 #include "io/channel-buffer.h"
 #include "net/announce.h"
-- 
2.44.0


