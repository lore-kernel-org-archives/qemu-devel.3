Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35635606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f8dI6v7w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RQ9UWdmv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7En-0005BB-NM; Wed, 28 Oct 2026 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E7-0004rc-69
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E5-0003Rf-Dt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYC50lkkXEjQTbdSFWhJZqZns8nXH5EWxQst6V+9DzY=;
 b=f8dI6v7wS5DWg8r53/D2GqH+pjm/13rd/EeF4qXejBL1zkF4qQtfs8kW1Fjzxctrxv0Pz7
 SVt+wKAfS6S5Y8FB8fYPAYW1xBi9fCO2I2+MzFgD34dJ/TAn4pbm7MzwOfwbkb7yZzxQI3
 vNUi2/OzsTUwVMEUs9/Hs/37FxmSKec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-s5z4Ywo9PPmv4YSRBHIHHQ-1; Wed, 28 Oct 2026 13:14:11 -0400
X-MC-Unique: s5z4Ywo9PPmv4YSRBHIHHQ-1
X-Mimecast-MFC-AGG-ID: s5z4Ywo9PPmv4YSRBHIHHQ_1793207650
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1e489f97fso12305095e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207650; x=1793812450; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KYC50lkkXEjQTbdSFWhJZqZns8nXH5EWxQst6V+9DzY=;
 b=RQ9UWdmvz+oibjfoLDwa1RMTLYnCe+WFDdfJfOALGfS4dtWHCNMdv0HBwnOHreKO8q
 jErT3fv3M0CMztrvGfYz8NyYK+WcIpYDhME7/fKWMP59imn5IVx/S2AeT4fWSjzH2eJo
 7KSxLB2IvBHi7kcMwAQndP1LuvFAmDFE8sFfP1IR5XYcqYuVrWf0NUiSj9gmKH3fRtaV
 soZbzs2JhaRvEPGzgxbuMaj2vrjyiI/RCA8BqowLBf7r2L1cfTsnzBnD3KTvDr8cWC3A
 ZywSzxUCeuAzqmKxoBkkm6q4kTjCf1pjKsiGVen9zpxXobYbKnleUytf6nYCgnMYRkm0
 oTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207650; x=1793812450;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KYC50lkkXEjQTbdSFWhJZqZns8nXH5EWxQst6V+9DzY=;
 b=1bAPKyjaaNS+ymKk69/NJGjDjc5wJ6LmdO6oZbdbLh2lE6qJQU9cR72npo5iVfgGfK
 Y+l5khIVagIMOGt7hzMueqDBBQFghUsLM9IYThFRWSmElDRI8KlQ1gZhLY58DgNPi6uv
 38nVPV56zZoq7CzriJlZydPCGwI/xH2qSU9RuI43DeyfuRorDB8UBSnboWt0srnPaaA+
 x+dCPQdSxr7r1tXD5wwpKNxLIBAGBUA+bhND/+uJ9wyBNvI3kCwVvDljp//jRuEm2aNE
 wrz0CrWsNmj0LemhxHIJuneVw24zf/PfjsbWS+/HpKzbTMxhT/csze+kR5x4RI81szyl
 NQEA==
X-Gm-Message-State: AFq9FYKYbfBNNLj6xLXKv04ZEPVxbt2kZuIEitqSdBOq1f1831T8ZF7g
 DrzpwAEDe4JeCGfmFDPiVKYGbN6LKqm3IhsdAZAnpAtqAKB/Rnp2iMs+u4vgQHuXw5fdcsbItQH
 /2gSHMAOBcNl3V6RZG1nLx8XNcPdNT52DV40NDLqgEqV/4wdrVlKvw8fchYUyyZnmdgAiPDtmLG
 fN/jQuh+J/3I4xnXMgX0t4QCfnJJt5ICB5aQ==
X-Gm-Gg: AYBFou2w7YCrNSFjRc2QwgJJt0K4krbzlSgU04OlpmrU8asApuwpWN6TlKp60OxD3Go
 AAmZx0bPSO563V3Zeu/FwzvLlvOel4k+TvsG/ZkafhEBHB4RLBoJkmf+4OkZRhch0hwrRvOtEiW
 bx34R9sH5aGJUqNmJWIIgSTmAFt812eBaxwGEe7IzRh6P/3EM4a2GN8h1yeJErIAQW7VAoVYZdb
 SmIazQwToBkvZb5FDLrhWoMn3dSZwb+uP1mPcoViUlW9i8ISm5l8diJkKDAUJZac9/nn33DYJf6
 aASqFJ8rPpH+JtZQK733+UBEVfebTV+0JUXYffRLRuhGoCbdXmHIFw2KCGei7tpYeT1QpOLcmg2
 /i3zHXLFG3KmqlzOa2NUWcVH6fLsran+d/aorPHo/
X-Received: by 2002:a05:600c:19c8:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4a966c418a2mr66407095e9.17.1793207650039; 
 Wed, 28 Oct 2026 10:14:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4a966c418a2mr66406095e9.17.1793207649322; 
 Wed, 28 Oct 2026 10:14:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm32211219f8f.32.2026.10.28.10.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:08 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 05/78] net/tap: tap_post_load(): poll only on success
Message-ID: <02c1873aaab76e53ec47f52ba1275a1b7449a4cf.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We shouldn't call tap_read_poll() if s->fd < 0.
Let's move tap_read_poll() to the end, after check
and vhost initialization.

Fixes: c4d884bb5444 ("net/tap: support local migration with virtio-net")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914175351.393680-3-vsementsov@yandex-team.ru>
---
 net/tap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d71e3dd117..8039b4e388 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -490,8 +490,6 @@ static bool tap_post_load(void *opaque, int version_id, Error **errp)
     ERRP_GUARD();
     TAPState *s = opaque;
 
-    tap_read_poll(s, true);
-
     if (s->fd < 0) {
         error_setg(errp, "FD was not loaded during incoming migration");
         return false;
@@ -503,6 +501,7 @@ static bool tap_post_load(void *opaque, int version_id, Error **errp)
         return false;
     }
 
+    tap_read_poll(s, true);
     return true;
 }
 
-- 
MST


