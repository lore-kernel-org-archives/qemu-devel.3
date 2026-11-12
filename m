Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEED606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0W/3TQI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+XwZPAC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYwJ-0001O4-PK; Thu, 12 Nov 2026 12:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwE-00019v-0L
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwC-0001po-B5
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EI25TRLF9UjR455PTauuZEfrTDnUNF78SPw53fFzs14=;
 b=A0W/3TQIN830bbBSpItOga179PHXKD5se+/aHTZ/x0kv9iSeQJwALD2WRE+mytN8jD05tC
 VT+sOJCzEW3LRby3UnIwhX0/LQvWGhtFVHKzy4wYyofIiLVH4fNbr5ut244RLznA5tPy6k
 dmKXG45NzBdchfnnyRPt3hq9GuEuqjY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-W__em6xGNGyMmZ4QPrZbRw-1; Thu, 12 Nov 2026 12:50:14 -0500
X-MC-Unique: W__em6xGNGyMmZ4QPrZbRw-1
X-Mimecast-MFC-AGG-ID: W__em6xGNGyMmZ4QPrZbRw_1794505813
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b0a9de9c2aso9467a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505813; x=1795110613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EI25TRLF9UjR455PTauuZEfrTDnUNF78SPw53fFzs14=;
 b=I+XwZPACB4/bhjgqR9wXZenWHctgBIppPTai6p8PEwU6vtS5Ljuny/uo67QsGSBgMj
 YBp41O3liGfTt6JsMMT343zvU7goVVFoCr4ISZ1aChn0i9Pv3x8ao9QZ1pU08iJS2sXL
 b+tIi31/fTKXlHsB4PO0U1GlhAkPNZef9GeG1RE25lJbVKjDZzZ71VGD7TdHH3ZTL1LK
 5YWFMX7Zd+LRowXZRxV3FxIoy/luBShkF8fNLnvuZHPo4TRP7BkzvvYseCG5jW6YhsdL
 C1V2VG25kdPAAUya48HjYvbNESQlQIURBFnCu30r/QJXgg0qIxBMBRu6mgoMAdONNA7F
 Wvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505813; x=1795110613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EI25TRLF9UjR455PTauuZEfrTDnUNF78SPw53fFzs14=;
 b=SmjkaQ177LbASINtB51JZMW6uJktJbObVyaBz0S7THmIQfUb71RVJ1gZ2uB+4O2kzH
 8BymVdEwLpRpPf6avQvn4JWUz7E5rvOe7oe/gT9mqH+VAMO7tDDYO0bTdInyUvrzDtU2
 6eI9qYH6/s99ZaUrTgIR45JBg1SBk2DTEbgytsEfbGZ8Gxjd7+1pz8THVGPfbYwBDygT
 O490eGvQ8za13dCGJ8y7ouyhx8pqPibUObXkuIU6JjdkJfb7bnnE7mU6VHyBkEiPP+iQ
 lL5j3kih7mgZ9IxCnAAp2rV9whLli6rKYfPJG8y+FRnhw95XjibDzSS4Fz5OyEjPguxu
 wsKw==
X-Gm-Message-State: APuU4Z/hBXxwg/IhitgJpNfhTu96yhag9RMWf7S1ompCLZLwRJdPM0Nx
 Fi/5uWcn70ZeNUVKa1RY0P+6X8G0m4HPnrUWF1bB8RJHDutklLzyIj7/yGa4wzRa8LBOszBpYh0
 /EE8pr61pF8SlNZTqIX4JRH3rww8bfqs5HHaQfFvKrbM6T2MBLS+JExXS9MGekG5sN4GALU2IkD
 3OlWdFE7OOHqwk80XaQ+MFfX0j2puhdCd31ojBM+T/3A==
X-Gm-Gg: AYBFou0zQO8hmQb+W7wBnEdGhu8B+/3Dzqfb1I3ZCz5CQs1jzlOpXKWEswMltbn8TUR
 WR1Gkm5SWxgkecM5/+B32FFzWIXO8XXpyMd+AnvpSDyb/z+OMy25Z/NwvVzlQmUcml1YfjoSyG/
 bzG+b5HfrH1fgBg+CWzVeyUJ2IqdwAaPZ2WisnXdTpnYKNOPmOWn7JOdHhppO139MROQeoOi0uC
 s/rashQdJ6xgxtLr0uffxAu0pk1tpx+B/3YHNP3SveWkv6gkxnOrgXglYjIrfvI83it1J3tK026
 EtwlK1T0cTtzVYuOzyYpktr1nCuKym446fbgV+7aiojMHE+Aqf748FVWams21Kvyz6c8etrLGLZ
 tWne+QdI5cHmwON2GtePbGf3Qr14Mq+Fc/QV8ICSqCqOwig==
X-Received: by 2002:a17:90b:1d0b:b0:3b0:8947:fad2 with SMTP id
 98e67ed59e1d1-3b182fb2981mr6196742a91.53.1794505812814; 
 Thu, 12 Nov 2026 09:50:12 -0800 (PST)
X-Received: by 2002:a17:90b:1d0b:b0:3b0:8947:fad2 with SMTP id
 98e67ed59e1d1-3b182fb2981mr6196716a91.53.1794505812235; 
 Thu, 12 Nov 2026 09:50:12 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18851ecsm82700a12.13.2026.11.12.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:50:11 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 5/9] hw/usb/dev-mtp: Validate container length on first data
 packet
Date: Thu, 12 Nov 2026 18:49:02 +0100
Message-ID: <20261112174907.158825-6-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_mtp_get_data() subtracts sizeof(mtp_container) from the number of
bytes received, without checking. A short packet or a header declaring
less than 12 bytes makes these unsigned values wrap around.

Reject the transfer if is smaller than the container header.

Cc: qemu-stable@nongnu.org
Fixes: 88d5f381ecb2 ("usb-mtp: Introduce write support for MTP objects")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7233470558..6fd92e5a68 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1784,6 +1784,13 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
             return;
     }
     if (d->first) {
+        if (cpu_to_le32(container->length) < sizeof(mtp_container)) {
+            usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
+                                 0, 0, 0, 0);
+            usb_mtp_data_free(s->data_out);
+            s->data_out = NULL;
+            return;
+        }
         /* Total length of incoming data */
         total_len = cpu_to_le32(container->length) - sizeof(mtp_container);
         /* Length of data in this packet */
-- 
2.56.0


