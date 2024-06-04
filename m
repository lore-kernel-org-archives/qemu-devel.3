Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B0C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwe-0005xS-Df; Tue, 04 Jun 2024 02:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvK-0004Ed-IQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvG-0007ZQ-A5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRhGc1/va0BMldmkMOF8FLn+sf/je1bF2hCX4br1ZJY=;
 b=awAIjqrHHgbSHotFqRIO46/z3SVaADlO8LBNZQvKG+L8iOeJOqUxpU4deoQZ++fItxvc6v
 eZYjfhOuhmK++2ODmzIb4c9vbrra9aWHNv3YwwfivTt7GkCR34zebbinV6xSCzerN3d6ia
 HFQQZNL7T5IHqc03k4x6ZWk126stw4M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-nE3Mse_9Nou50Om3tSAONg-1; Tue, 04 Jun 2024 02:45:27 -0400
X-MC-Unique: nE3Mse_9Nou50Om3tSAONg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5785176c796so2507501a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483526; x=1718088326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRhGc1/va0BMldmkMOF8FLn+sf/je1bF2hCX4br1ZJY=;
 b=iL3accBQYm7VfjJ+gJOe8KPD1ofB/K1kOJr58ih9bvCm4kjNN2ufw7hnafi6e/p46d
 mzCwnt/48N5iEk0QMKZrzdfGDXqynskpXMAV+Qsz1I19CFD3ivsbvu8SavG9UrGYWZTb
 nUtOn6MHTjL78tEFmal3QXUdg4zk2RD+DhXfPv98BN8zCxwk4Hi+mh3xcFmgCFSA44RP
 Oo2moWFReZvC+HkbgBd65nppkYr//wYXyO6YCIgsLEIksuliAl1miVquNDPJzqn5gVB4
 PUQ2pT6ImFM6iqQSC6BnkBW1rO7FkprphDmLgWdKnmjcQidj1Xl0BFippzT7q3+iUhFm
 qDaA==
X-Gm-Message-State: AOJu0YxoY89m42q9J6aWnepFfeOovfAqgsYKXGyaHc7DUq/QF1JjFXcL
 COGAVeBBJYfkf43H5EswzVq5NOvbtaUOl8qG7HU5XdSNkMC2UqcRxv7ectUCeIc3jHd7lf9k2Ra
 hIbvgfcYKkwCIXKSjGVB3RIm60nNE923NNL2RV+XliXXhe+Iek1IaA9rUfzOvmJryo8r+Po0DsL
 QJMVDXZ7ENqBc1mEJA5hfFU0hOn0Ahhb3By07Y
X-Received: by 2002:a50:bb03:0:b0:57a:1c44:581c with SMTP id
 4fb4d7f45d1cf-57a84cb3b01mr296823a12.32.1717483525940; 
 Mon, 03 Jun 2024 23:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGugWw5niIMHRfoA3JtZEatt3gMCB9XyYuhB0Jd7BN7brHFsX9r/9YrtVGC3PRalegtJwIZKA==
X-Received: by 2002:a50:bb03:0:b0:57a:1c44:581c with SMTP id
 4fb4d7f45d1cf-57a84cb3b01mr296804a12.32.1717483525379; 
 Mon, 03 Jun 2024 23:45:25 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31be7c04sm6829600a12.58.2024.06.03.23.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 25/45] i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
Date: Tue,  4 Jun 2024 08:43:49 +0200
Message-ID: <20240604064409.957105-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Michael Roth <michael.roth@amd.com>

SNP guests will rely on this bit to determine certain feature support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-12-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647f..914bef442c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6979,6 +6979,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (sev_enabled()) {
             *eax = 0x2;
             *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
             *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
             *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
         }
-- 
2.45.1


