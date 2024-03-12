Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F58C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbJ-0000Pl-Nj; Tue, 12 Mar 2024 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAap-0007ZR-M7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAao-0004Oy-5E
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBULQTyw/cBuXLWadxHOJ8GjlhZzF81MHpi5mkmgU0I=;
 b=WUvAHO5XM7ThL5C0mM54i06sZrjpqRqDxUUXd+9A7o5k9fYwymI6GoAVH7WZwoNX2eJkn1
 V6IHK3t1aNAK56hqwy7wl+nslw2ZKs/VfTFVjYxho5G9KTC40kXux5W8K6R0yY7kDowYJZ
 ep+THSmh0JpmnivH0sb5MFQazkL7fmk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-eGKl3PvKP2We7xRUD4-1hQ-1; Tue, 12 Mar 2024 18:27:28 -0400
X-MC-Unique: eGKl3PvKP2We7xRUD4-1hQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d468f7779cso3600881fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282446; x=1710887246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBULQTyw/cBuXLWadxHOJ8GjlhZzF81MHpi5mkmgU0I=;
 b=kojqw2up9N16bC+nOP6L24JxPw4tqFOoIgvLlAgFJQ+G0zlRl5v85zIAsLEwvbH8Xs
 0mMJC3O1S5sr1F1R9wpJFrX/Xcv1W3eOjiTII81p0ZcCcyA2rjDQdZrPj9lSIMVDekgL
 Rc2XqdNLmEr2VLKDomeAb4JTA4xRTiVUxAvNpsYA2WPkfbmTlpAWngozq69jNUHz99ZE
 XjEh0ISlCyaK5UcEfcvMi7TsivjYi9MdXOTI/2jSVHesjgy8GJt+L5I5iA6dYqkTGo/T
 lj9OzpetJoWtRuWKZySNUAZ3Lzfu3pFLvgkQgOEERD5VWvgsngoQdPpGeFr7UG22YSky
 DkVw==
X-Gm-Message-State: AOJu0YxjDPWyD0gbQyUAn0SNfr3SWHl3eNaOhq2odgJ+QuVJYjL7RS3x
 QC1nHOdQBS4s3swA/gi30946tcEs+eLIOQtrpUjtVeTn6gR9kKCD3cQe8yQzTQe76As7c3jdO7m
 4HVrnMl2cbYvCbOi7siPy5xfMlImlMU5qQqTWjxzTkyhUQcprQw4QYagO3yWdTVtdJN1bvh4wi6
 TIE8OP3xqkrJy+FrRUwYzsmE90dZWYYhe4
X-Received: by 2002:a05:6512:ac1:b0:513:27a1:24cb with SMTP id
 n1-20020a0565120ac100b0051327a124cbmr1220494lfu.51.1710282446264; 
 Tue, 12 Mar 2024 15:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBJlRJm45tw8nSf3m96fIX0dBg9+ATVRCHcfVPcXIrv3z5nzZBbV0/mkZh64QXI68PAG9kbA==
X-Received: by 2002:a05:6512:ac1:b0:513:27a1:24cb with SMTP id
 n1-20020a0565120ac100b0051327a124cbmr1220469lfu.51.1710282445684; 
 Tue, 12 Mar 2024 15:27:25 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 hg22-20020a1709072cd600b00a463c821e4dsm1260636ejc.10.2024.03.12.15.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:25 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 36/68] hw/misc/xlnx-versal-trng: Check returned bool in
 trng_prop_fault_event_set()
Message-ID: <305446015848f0b5d71b817b53e7e02b08c36ede.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in trng_prop_fault_event_set, @errp is dereferenced without
ERRP_GUARD():

visit_type_uint32(v, name, events, errp);
if (*errp) {
    return;
}

Currently, since trng_prop_fault_event_set() doesn't get the NULL @errp
parameter as a "set" method of object property, it hasn't triggered the
bug that dereferencing the NULL @errp.

And since visit_type_uint32() returns bool, check the returned bool
directly instead of dereferencing @errp, then we needn't the add missing
ERRP_GUARD().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240223085653.1255438-5-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/xlnx-versal-trng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index b8111b8b66..6495188dc7 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -644,8 +644,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
     Property *prop = opaque;
     uint32_t *events = object_field_prop_ptr(obj, prop);
 
-    visit_type_uint32(v, name, events, errp);
-    if (*errp) {
+    if (!visit_type_uint32(v, name, events, errp)) {
         return;
     }
 
-- 
MST


