Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DBDC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuic-0002hv-C3; Fri, 30 May 2025 04:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiY-0002fM-RX
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiX-0004gH-6r
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RS6NkNuicN22cppwE3868JJ1vrcCIE30ciMJOFo5c6w=;
 b=CEPgvrqSfvNuSsMwZ2CZcnWrbVu+sFzRJIImbkUEquKW2FYXJ3PDHAD6+sZ4NdA//IMG2I
 00BmgREYZCVCeRS6guxG/nEoL/3OboeQDS8xt/dQ+E5/LZVeG75tsdZP8orZoecM5CWYhm
 dv+C3sfjL91mn0oKW3PQBrUOlxxA0UI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-8A5t8oJmP5-YGtwXXLNeFw-1; Fri, 30 May 2025 04:03:51 -0400
X-MC-Unique: 8A5t8oJmP5-YGtwXXLNeFw-1
X-Mimecast-MFC-AGG-ID: 8A5t8oJmP5-YGtwXXLNeFw_1748592230
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso128604266b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592230; x=1749197030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RS6NkNuicN22cppwE3868JJ1vrcCIE30ciMJOFo5c6w=;
 b=N/QgTdzI7AvsHsFP0maZo1iwGtHCucgH09pmURC62kaiEOHHfAZy2r0MCJaHTTh+rQ
 asrhqUxS7HV0MbqASEN8J1ObR+XFD+SQGdGp+xrbmd4iZCYIuPFG4KlYidhmXhdKg6Pm
 b1/jmO/ry/in48yaHJhHGhzSgZgSIGl2fpakFXrfoKowuAIHdDSNh8mrjvsawpb3SSDI
 xDWOXGstiVPy0B659w3iE8+BrvFsD/XESGDENgrPQc9k1aTP1izuevpxRUWTSscLwERJ
 oPT8IcANm/oLK8OG2oCpVMzbY205n6Ygw6IFRawdIZvORTR890pnzvnzwaJd5a4pqf9w
 m3EA==
X-Gm-Message-State: AOJu0YwJAcyq361n6k5QlkCFNuqb4V1x9nwCWK0IqOOK9tnfj1tHjiVK
 R5ziSffebRew/ednSWa7olm/5+KbXaQbPwS+yAqiWLM7F/yLUTLmLdE/zMfDoHP+6HTDcQ/o1KY
 8uve4f9N/ISaW4mLRiaNT0kslreMRwfHZxMycC0cLnLImbcp1SNQFQCGeIU/10O7HWFM7xNTppB
 JKV6KATvrLAxnvXOrjlcSicqjytxQ5pzCTzfz4lCbm
X-Gm-Gg: ASbGncu8ZuaF8RJ7fZ+CQJUwBuqlEJse5IiJpyo9qWpjkg2KdhVKh7JlABR1Oi+Lyag
 Fvkg5QiTSE6x5Sv/F+ZGbasayKnCMpo/yGgptZSHPIOVHn7Wdxzgy53y3EU5R0ZobneGWeSfKXr
 B/9qHAbJH1dUIjkuRIbE9mXKyidsECWgyb5+9T5DSEt8vwFyWntBJHQjacPN9RjeRhM7TaI9TcS
 a8bfYRB7dBwaZwnNaU4aAvs971eznAw7qkB9oEbHdEHoSoWicutf2OjIT097mghvkGCcNBRos7f
 NZqwJJFp1D2McQ==
X-Received: by 2002:a17:906:6a09:b0:ad5:5447:6ec2 with SMTP id
 a640c23a62f3a-adb3244b7bbmr198161866b.53.1748592229716; 
 Fri, 30 May 2025 01:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwqSK4c3tIVbuKW62gwkNC+WXhrSR8UgOdFlud+sIB0t13w65s6AuDSEAId9pOhOhzIEc+3A==
X-Received: by 2002:a17:906:6a09:b0:ad5:5447:6ec2 with SMTP id
 a640c23a62f3a-adb3244b7bbmr198158766b.53.1748592229279; 
 Fri, 30 May 2025 01:03:49 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fecf6sm279883666b.30.2025.05.30.01.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 14/14] docs: update Rust module status
Date: Fri, 30 May 2025 10:03:06 +0200
Message-ID: <20250530080307.2055502-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

error is new; offset_of is gone.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 34d9c7945b7..29ae59395e8 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -155,10 +155,10 @@ module           status
 ``callbacks``    complete
 ``cell``         stable
 ``errno``        complete
+``error``        stable
 ``irq``          complete
 ``memory``       stable
 ``module``       complete
-``offset_of``    stable
 ``qdev``         stable
 ``qom``          stable
 ``sysbus``       stable
-- 
2.49.0


