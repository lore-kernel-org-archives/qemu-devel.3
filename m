Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9646C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawe0-0000EF-5u; Mon, 05 Aug 2024 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdq-0008W8-8J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdn-0001QM-An
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722860201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhBc4kBcQvINlkwSQbrMTAgcgpq8izcg/7xtkpClQ9g=;
 b=P907v58JA5g4vrFmy3V6mFGVLaB7onE/hhy95QiTP9WY9HyQWOfxq4+gx/rcCOLM20V3/k
 6Jfjl3ofMkXMmqiulJkFWjaXjmZW3Hu0EA8bf5RPZEzvf6IL0bNWlRaawhj0mG5RYsgkJz
 /BysAKQ5/CWv9fDizjqsYXfI/Vxj7IU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-6eflLuPxMkilUvVVKnkBmQ-1; Mon, 05 Aug 2024 08:16:39 -0400
X-MC-Unique: 6eflLuPxMkilUvVVKnkBmQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f01a8b90b6so124078021fa.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722860196; x=1723464996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhBc4kBcQvINlkwSQbrMTAgcgpq8izcg/7xtkpClQ9g=;
 b=Fh515ZrplgV9AtPMAuqPMmZPIIQpw5B9PNtQ0P9fVnzGmOV4fNiA0D5i/lxQ4704cy
 KWLYuszNSuQ9ZM2vOwvN5EY6gLQ4dmp7zKPprYZTkIm5yY5cyvnt7dObBfBNcQAYgzLM
 0Xkp6U6+24VOolRC2ymm4iKzsSz2GLtDW+3lk+2wDRVQSrzcUsWJNp7TAd69XnKacdB5
 nsTEEg2dmOs41dBSNc/ucDvLbx0aBlxra4/9bQSvU9CwjuUgg7Vbamdd99N0Y1z+9ddE
 u7D/R8cgHAbDfBIPormnofGhfOFP6PRkSeiR0aFtbo0hn+fPRibDnHskTaoKjaC5X+cJ
 hFKA==
X-Gm-Message-State: AOJu0YxX8BikjFplNlCQCbVPC2cHGOo+wApB3vqU4DbJD46/8QvHIajP
 NgHzh53gSITPnH1i1tB8TNwxSFc1l0mpkjMPCuTm2Dm3J2n2QCUUCQ/Rt62bvs4GWMkK+qubWSp
 xtAOk7eU7JT5z/AUDhySpbueHJ9cfNrngOMMQmCyH5ZK7Bsn7kBhBDqiztRqCKCBf+D5GWW1LBq
 xQrlEOqVMIz2R8xsgtJjYvOU6u2EgD92oUK4Bv
X-Received: by 2002:a2e:8797:0:b0:2ef:296d:1de3 with SMTP id
 38308e7fff4ca-2f15aa06186mr94825361fa.0.1722860196093; 
 Mon, 05 Aug 2024 05:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0wdbAMud1RAGAy9LAsPbdKk4ql8CseqqYvsMxrOrwWUdWg5S32t99xa5c0HGjkFejkKxM8A==
X-Received: by 2002:a2e:8797:0:b0:2ef:296d:1de3 with SMTP id
 38308e7fff4ca-2f15aa06186mr94825001fa.0.1722860195406; 
 Mon, 05 Aug 2024 05:16:35 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839c2dbe8sm4862933a12.37.2024.08.05.05.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:16:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zixi Chen <zixchen@redhat.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 1/2] target/i386: SEV: fix mismatch in vcek-disabled property
 name
Date: Mon,  5 Aug 2024 14:16:31 +0200
Message-ID: <20240805121632.482610-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805121632.482610-1-pbonzini@redhat.com>
References: <20240805121632.482610-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The vcek-disabled property of the sev-snp-guest object is misspelled
vcek-required (which I suppose would use the opposite polarity) in
the call to object_class_property_add_bool().  Fix it.

Reported-by: Zixi Chen <zixchen@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a1157c0ede6..a0d271f8986 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2422,7 +2422,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "author-key-enabled",
                                    sev_snp_guest_get_author_key_enabled,
                                    sev_snp_guest_set_author_key_enabled);
-    object_class_property_add_bool(oc, "vcek-required",
+    object_class_property_add_bool(oc, "vcek-disabled",
                                    sev_snp_guest_get_vcek_disabled,
                                    sev_snp_guest_set_vcek_disabled);
     object_class_property_add_str(oc, "host-data",
-- 
2.45.2


