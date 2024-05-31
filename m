Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41854C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyM4-0000pp-DK; Fri, 31 May 2024 05:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyM3-0000pc-4b
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyM1-0006WL-ML
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHsImDo6WLnYTKBZiyQPWRB9x08dsxBTYQKEQprEz+o=;
 b=bmouDFfjcSOUJycWBirJqrYLV+SzFeMdSYbsO8YKOqrJMVbBkicA4XD+KxTEjo1h/yyJKS
 99lwAbNKaZqx/ZTzHrQuJCmVgo7va42eA2hegjdgCIUPOLhS+F4iEodMe6OryjXoJNEx9L
 RcKjDWrHK6IyuOJYfhIhbFqR3RycRhk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-THeQeq14PCS8plBXp65Cxw-1; Fri, 31 May 2024 05:15:14 -0400
X-MC-Unique: THeQeq14PCS8plBXp65Cxw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6775812baeso32266466b.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146913; x=1717751713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHsImDo6WLnYTKBZiyQPWRB9x08dsxBTYQKEQprEz+o=;
 b=BegoSE87+EmD6yUwgcwSgUSHKyLPUsCgEEzIWl6cyxk8OqczP2vbG4ZqiY32ToqinI
 I9oObu5lCKW8X0il/YKyjhegzjb3dLV8V/ZXgE2QNGea3VzxcpD6nBkFOSlOxZVYO0x6
 +TcamIeaRyrYKlIN2zxS/FFibYn+0g91syUu68OQs2iUPUi0MyxIBC+zB6JD9jwGDar0
 J8G0hmVbShR0HqOXzKVA1V/O3gh9DIF/Xrj4MkhE40DBfCa27ifZ1huZk0j1sg7Va39i
 Pd5rar5Lyd4pFkNmzZyDA9R1OiwByq0fd74UMvdYOIBCuEBoHjgTBuzPghRXnrgyA5Of
 2iMw==
X-Gm-Message-State: AOJu0YykCGmRvqZhBgbRAt09uM7M7k4n6Ppc8zBQSQYX0orOEPfmzPhz
 NCWtpdd9qrzk/2zteQTllWlBEFuhngQymNTEYrRotbhqfms33G8JV6WXWIMKeyUdkgCFuxeOhee
 iNPOR+OWtAirq+VMM5lFHC6rW/fjVg+z/Boi88BXwRe3wZLeGiDf2D740QiBjMDAwlbhLlBM1nc
 /VBr9sfN922WBEEamwYMC0peAxJ/X67OI/tfIG
X-Received: by 2002:a17:906:f118:b0:a63:4e03:8abd with SMTP id
 a640c23a62f3a-a682263677cmr88213066b.67.1717146912781; 
 Fri, 31 May 2024 02:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZmscw80tunY2W7MP2IFudhaGoC/y8qoNe1/NDXVj5V47MrN0R/oSyAkVs7iwjdI1OZ+XvhA==
X-Received: by 2002:a17:906:f118:b0:a63:4e03:8abd with SMTP id
 a640c23a62f3a-a682263677cmr88211766b.67.1717146912304; 
 Fri, 31 May 2024 02:15:12 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea5869d2sm65744566b.107.2024.05.31.02.15.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] host/i386: assume presence of SSSE3
Date: Fri, 31 May 2024 11:14:56 +0200
Message-ID: <20240531091457.42200-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

QEMU now requires an x86-64-v2 host, which has SSSE3 instructions
(notably, PSHUFB which is used by QEMU's AES implementation).
Do not bother checking it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cpuinfo-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04f54..b413075b9f2 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -38,8 +38,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
-        /* Our AES support requires PSHUFB as well. */
-        info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
+        /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
+        info |= (c & bit_AES) ? CPUINFO_AES : 0;
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.45.1


