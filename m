Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F0CC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9V-0006w3-Cl; Mon, 06 May 2024 03:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9P-0006Zy-CM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9N-0001jR-2d
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DStBOVuOMmNiEoCX8orG6MRwWNCRdkFLsbdf73i2SnU=;
 b=ivAqDiJrHtJpvbbmfSzpjCqYvBm3i6c9wZALzysB2oFli12hkLcU1LVCNGdsnvUhgVE++A
 qBrQCPJ+ulm27nwPMC/ZRQvUfQdQA5Qrm+nXRFJLZjEAMNMLuaH5fmVUWGEEZ20dSg3Zgu
 PA+Gmuyd3toFWbz9z5hp5G0VT0hAkw8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Zec38qQJN8KGz8oNffmcEg-1; Mon, 06 May 2024 03:52:38 -0400
X-MC-Unique: Zec38qQJN8KGz8oNffmcEg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59ab39c8b6so108764666b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981957; x=1715586757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DStBOVuOMmNiEoCX8orG6MRwWNCRdkFLsbdf73i2SnU=;
 b=X+OzXG1Uq0+ntna2IXWvsoWW18UL1yQiZe0+8oJ54I45yQW3RVH8Bl/+nevw5q1HG9
 Aav/aKtpYl6cLxPdwOnpQIt2KOgNJzr1+h+1/1vokc5pnWZ7Xx5M4WGjYpxwiuH+Uewe
 EU5XnF4mu6J52Sfh3CdCS/s4UrxOvRk7g9lw5RBhDYD37riJwBgBUwjr1z6h5K628ApQ
 JhBDBtkfGlklVJTDYo+9RbIoP6HRqtl0yJr8tK3eAtvl7dB2//H7SH3jjKR2yhualT0v
 IewtxC9cTyaAP9WWyk+IgFjEiCMLSYKxm3AczyLXE1lgnLVRP01ZJioqvsHuNumNmU9R
 XgqA==
X-Gm-Message-State: AOJu0Yxtqq6UZ5Xt9uFZv/Rf+l6vsqQbqw58U6WkDZ92658MDEeQu1zq
 TQzzxe7iZtJuMm0V/DPHgtuldFNOzye24kx/JuQ7eCHp9GVlzc3XIe7789ZutCo3aTUol+FOksn
 Zz6LPwd2jWha579sGjD8YQDfJkPhwZ0CThZhDTaui/Ctp0CQqiX/4bqRfvqhEhkotOqjbl+OFsS
 N8+ptcXIycfolzPHLRIB2pNUVNj6evE1A2NK+k
X-Received: by 2002:a17:907:94c1:b0:a59:cdf4:f939 with SMTP id
 dn1-20020a17090794c100b00a59cdf4f939mr1434285ejc.3.1714981956771; 
 Mon, 06 May 2024 00:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgPVtQ9nPlYPZc2v9qdz8sHrzfGCINPXEIEAnLVZyGaqajrIo1wEBKtnkmVodDkM2X16mdJQ==
X-Received: by 2002:a17:907:94c1:b0:a59:cdf4:f939 with SMTP id
 dn1-20020a17090794c100b00a59cdf4f939mr1434269ejc.3.1714981956342; 
 Mon, 06 May 2024 00:52:36 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fw14-20020a170906c94e00b00a59bf41edbesm1842051ejb.146.2024.05.06.00.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Wang <lei4.wang@intel.com>
Subject: [PULL 28/46] target/i386: Introduce SapphireRapids-v3 to add missing
 features
Date: Mon,  6 May 2024 09:51:07 +0200
Message-ID: <20240506075125.8238-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: Lei Wang <lei4.wang@intel.com>

Add the missing features(ss, tsc-adjust, cldemote, movdiri, movdir64b) in
the SapphireRapids-v3 CPU model.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Message-ID: <20240424072912.43188-1-lei4.wang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aa3b2d83912..e5723f232c0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3970,6 +3970,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
-- 
2.44.0


