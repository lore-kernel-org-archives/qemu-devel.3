Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F117E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByE-0004p5-IQ; Thu, 19 Dec 2024 03:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByD-0004lk-Ei
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByB-0005B4-Ub
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGo68GKQt2yaNvuhV+blTkjMLtUKgFZE8YyZBqUmje8=;
 b=fuxeoYQGo1ddxNSCGfI1JYMfGua9hHS1zTTHJ9ZP7Ax2uPkMbvCDL9npf0F+R+Lro0petg
 3/MVwHohAMitFTC7izQDMeeEvK5DDWdSkSJ3r8yqzXZjI84Kf00gAylD3u0yR+qQh0NP73
 Sw7vsUlU9bIaf5mAf8b8BsG+rxDKb9g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453--XHByr-7M7OP7N9HlQ6hgQ-1; Thu, 19 Dec 2024 03:33:17 -0500
X-MC-Unique: -XHByr-7M7OP7N9HlQ6hgQ-1
X-Mimecast-MFC-AGG-ID: -XHByr-7M7OP7N9HlQ6hgQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e00ebb16so221742f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597194; x=1735201994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGo68GKQt2yaNvuhV+blTkjMLtUKgFZE8YyZBqUmje8=;
 b=rvGT0iyg4ukiS4qk+XCLl8b3u9i45x3vyY/9EWH8ae8kZQzEkpZneRiWQ3zKgYlXEw
 PStu+5HR5qStC9Vuxbay/azXjBdsjRWiXc/t5JuG/02tqHar06Cda0XkMz0/4gtia5c+
 gDdMCB8GRCa+6bwj4eGkgnunUYbHMAjKAPpfDZYlEw5AIZ6Kj874P1TYwWFPB7/cSviD
 rnpfUgAwblkHbTAvymExR9QcAou5TW82ojFv0sToiA6rXrDFbt0GbmjNYXpLxlTxxb3/
 QBPe4iFDb8Y+bSCbfJL9VPoqr2bksnE8Ga2tiymCAmqRFtQZWmQnAlViBIzZmtIEeQZ/
 NR4g==
X-Gm-Message-State: AOJu0YwmbVqJ2ckz8N5B8c+xkO0olriVFcMVTQolZPPleAr9g1gT3P5g
 H0n3IA8bVJxJtWLm8PzkbbwWB1u54jRibnITP2Iz0eC54/g42yaxUAZ3h9lrJDMrT6idR6oljKr
 NfVOO1yT6Cu9BS+9q5lcwiyJIPRPRp4dj6wRXQVa8n9JL3n85Kihv2knHK8s6/IXAx8k/Kdez17
 RpBAEddGTcePWErTBs1wKiEk/f9KhtLl0qKSTo
X-Gm-Gg: ASbGncvWOs7xtPyD5gVTPoNsVVKlfJLd8y8971leQ8iTIbVdPelNsjOKez/PU5V/loS
 im5UkSi0Xj2DziFZZXhyEjxt740CTlfWZ3lQOzqs/Tuhsof/Bd93bRqk1qm/0G0V+jXt11x5E/k
 9mAqQyrZBEzmMMVd5C5SbBROFZrDANqgqjgp3Sq9zMWxm4MJUL5LSOUj2Ra/Ca7JXgYmwhBqgny
 T6XYHvurrLFcukBV1EB7Cgu5r5GMdOobdxbTYkhdPK38VhDlM5EOm3DEdaA
X-Received: by 2002:a05:6000:1449:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-38a19b373d5mr2230036f8f.43.1734597193173; 
 Thu, 19 Dec 2024 00:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF458w2rB/jba9OyVCFQhwtp9itQ68U5m2QOZTBBkDc9Ocstmd+dCO3/cDDsx33va0UzLJuAQ==
X-Received: by 2002:a05:6000:1449:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-38a19b373d5mr2229996f8f.43.1734597192734; 
 Thu, 19 Dec 2024 00:33:12 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832c45sm981633f8f.32.2024.12.19.00.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/41] include/hw/qdev-properties: Shrink struct Property
Date: Thu, 19 Dec 2024 09:32:08 +0100
Message-ID: <20241219083228.363430-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Before, via pahole:

arm32, a 32-bit host which aligns uint64_t:

struct Property {
        const char  *              name;                 /*     0     4 */
        const PropertyInfo  *      info;                 /*     4     4 */
        ptrdiff_t                  offset;               /*     8     4 */
        uint8_t                    bitnr;                /*    12     1 */
        /* XXX 3 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    16     8 */
        _Bool                      set_default;          /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    32     8 */
                uint64_t           u;                    /*    32     8 */
        } defval;                                        /*    32     8 */
        int                        arrayoffset;          /*    40     4 */
        const PropertyInfo  *      arrayinfo;            /*    44     4 */
        int                        arrayfieldsize;       /*    48     4 */
        const char  *              link_type;            /*    52     4 */
        /* size: 56, cachelines: 1, members: 11 */
        /* sum members: 46, holes: 2, sum holes: 10 */
};

arm64, an arbitrary 64-bit host:

struct Property {
        const char  *              name;                 /*     0     8 */
        const PropertyInfo  *      info;                 /*     8     8 */
        ptrdiff_t                  offset;               /*    16     8 */
        uint8_t                    bitnr;                /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    32     8 */
        _Bool                      set_default;          /*    40     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    48     8 */
                uint64_t           u;                    /*    48     8 */
        } defval;                                        /*    48     8 */
        int                        arrayoffset;          /*    56     4 */
        /* XXX 4 bytes hole, try to pack */
        const PropertyInfo  *      arrayinfo;            /*    64     8 */
        int                        arrayfieldsize;       /*    72     4 */
        /* XXX 4 bytes hole, try to pack */
        const char  *              link_type;            /*    80     8 */
        /* size: 88, cachelines: 2, members: 11 */
        /* sum members: 66, holes: 4, sum holes: 22 */
};

Afterward there are no holes in either structure.
For arm32, size 48, padding 2, saved 8 bytes.
For arm64, size 72, padding 6, saved 16 bytes.

Saves 20k from qemu-system-aarch64 on a 64-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-22-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index ef3fd7b4ae2..3680cd239fb 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -16,17 +16,17 @@ struct Property {
     const char   *name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
-    uint8_t      bitnr;
+    const char   *link_type;
     uint64_t     bitmask;
-    bool         set_default;
     union {
         int64_t i;
         uint64_t u;
     } defval;
-    int          arrayoffset;
     const PropertyInfo *arrayinfo;
+    int          arrayoffset;
     int          arrayfieldsize;
-    const char   *link_type;
+    uint8_t      bitnr;
+    bool         set_default;
 };
 
 struct PropertyInfo {
-- 
2.47.1


