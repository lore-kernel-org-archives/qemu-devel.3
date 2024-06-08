Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2EEC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXS-0000cb-HT; Sat, 08 Jun 2024 04:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXR-0000cA-IS
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXP-0008KJ-6k
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETJt/YqPlrX8kijjJaRfSRYudKV0OHEIumVTtNruHEk=;
 b=Vmd+C8hiDU+g8+5Due1PLb9qUqP2k8HJubUrGhI0nBi76PBXKKUSWgocBQZ9jvXaWP0GK8
 Qv6W5qw7VX/Cch3cwXvqk0ZX5pGc0X1lscPDSOaOTrD9RlgKgjUXBiL7JKqco3FPK73FFK
 pInHZ4TS8qYGnuT8Lfl1G9v7jteYHB4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-4Bpkk75QO_6wJ6CmIl23dg-1; Sat, 08 Jun 2024 04:34:56 -0400
X-MC-Unique: 4Bpkk75QO_6wJ6CmIl23dg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6ec06ed579so66121566b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835694; x=1718440494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETJt/YqPlrX8kijjJaRfSRYudKV0OHEIumVTtNruHEk=;
 b=UFLrRYktu7v47/nTVNqjnYZnKLwriReNdUarKu39duasL8/sGSko5nFuGNky6dExR8
 HXMiPTNfkbjs24s2kyjAUnkDz1XB8KSaVdCapPGo9n7J8sja1YqBcOp/Cu5EMt+eaaWd
 iaAWTw1cxI2fLiXnQxY5d086MlqS2Pt/k/PVdaK8Z1T4DbX/FoTT4RTXhFYAh+S6PcZy
 r0FaGBSKqCreAOa1r5Zf/5nFoW/TgyJe0jdc7iXL4fVHzV2q0ez/jcTxL/M/ZFuwvkes
 g2oIw9etVVLRLAHGS2/arcAIcw8Sa0lHysMCWvTz5vhJxAfB0A0CSejHresRM15aIpnv
 Miuw==
X-Gm-Message-State: AOJu0YwggEOK07ZjuOlhrN+jN9IpMb/jltcENWQOEcKgSRliImqSfvbp
 1AKVFKhrXccY9ZZ2ei7fgjCpfNK0ZzPuCAcGwYP2LyuQelF9jfaPPuh8OhgN6utgg2z3Tvk1juk
 nqYITWqasuCc1SOq+oUHALeXn33uEmDkifoI66SiaK5jMI2pPbkyYGPt8sqcTP95irCxN/mBu4l
 f2Q7QvszU9vJvJXaUnj/8zwEvpji7Yccwf1FfZ
X-Received: by 2002:a17:906:fd86:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a6cca20a7f8mr415825966b.0.1717835693950; 
 Sat, 08 Jun 2024 01:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWZkNstecGWHR4aGkxoPIc8CkDen22AfnX7/s8wEzzDtmHDVwy4VLO3eXFmJM9UT80WOqvsw==
X-Received: by 2002:a17:906:fd86:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a6cca20a7f8mr415823666b.0.1717835693542; 
 Sat, 08 Jun 2024 01:34:53 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6e8803d1aasm168476266b.197.2024.06.08.01.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 13/42] target/i386: use gen_writeback() within gen_POP()
Date: Sat,  8 Jun 2024 10:33:46 +0200
Message-ID: <20240608083415.2769160-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead of directly implementing the writeback using gen_op_st_v(), use the
existing gen_writeback() function.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240606095319.229650-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ca78504b6e4..6123235c000 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2580,9 +2580,9 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     if (op->has_ea) {
         /* NOTE: order is important for MMU exceptions */
-        gen_op_st_v(s, ot, s->T0, s->A0);
-        op->unit = X86_OP_SKIP;
+        gen_writeback(s, decode, 0, s->T0);
     }
+
     /* NOTE: writing back registers after update is important for pop %sp */
     gen_pop_update(s, ot);
 }
-- 
2.45.1


