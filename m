Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE51C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpoz-0007FA-0C; Tue, 30 Jul 2024 12:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpoy-0007CY-C1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpow-0005n9-Pd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722357329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gU4KL7Moiqu87bnz/09iJuwrZndoiDMXIGO3bUZjXbo=;
 b=JvvddD053Qa0PmkcO0le8N4DlWqH7i+CxQSqsY86Ht1d0tdclfwnwcQ3ifSBeF/5gMCeYt
 V6tKEM3vNpHSzSUJ42dLPXD7ii9aTgx9V1u6U1b8ooiVHhWec9bFBZ/fZioASzbt8w+fvs
 c/57XKJhl6uu+YdrjB95IiXknM/zukU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-8MrrKn0EP42Jl0QE0RLm1Q-1; Tue, 30 Jul 2024 12:35:27 -0400
X-MC-Unique: 8MrrKn0EP42Jl0QE0RLm1Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7bcaa94892so418994666b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722357326; x=1722962126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gU4KL7Moiqu87bnz/09iJuwrZndoiDMXIGO3bUZjXbo=;
 b=jkPcYbmEJPscSaXorRpp+dsJ5479tRKM17+GxDQti83FuU2dsQaQdQyYO1tRc6Tu7C
 z2u3HxxMmvk7YxZocta6k3lppa1nGsV1MuIRsK9X5duGFd859h1HaGwbVO+YbxAtOZ7s
 0z0nK3vAkF0FlHAL3cS7AspcmjvPpcdiDvkTqqMQAnz8tBqKEaPgfmGFDM13i2adtGy7
 I6iCsq/6oADKAfpGWnB+Qks57mynPb9AHdmv0yKU7jlpAz8eWIbQOYKR4WL0pAPV7pPY
 OSUjvLCGMjScHo4kZg1Rgvslgp7BfllAHCf2Xns6ruLGbrucAxOsh1XAlDcdWkKFuald
 8zng==
X-Gm-Message-State: AOJu0YyEW6/Bfit8/36OazqE6SuJtx3IoYuBRUQMKxoVe9c4RwX0uD3+
 Td/7WKeBpV2lc8WmaeCCMchWt8vX7dcSBQ004zBRHfs9e70oi9Rn1xWobXbpRCO5V81TXcZOuau
 3vtHsTs5lw45/uBHqndAotIhgERkOAratcauIA5AiVTEjVDdo6T/IR3udR6KcgOWkxFqrR0UjEB
 86g5vXDlsbWJ2FhbTcn3elpryxMbs8FVrJbOht
X-Received: by 2002:a17:907:9443:b0:a7a:aa35:4099 with SMTP id
 a640c23a62f3a-a7d3ffad2a9mr815191066b.26.1722357325674; 
 Tue, 30 Jul 2024 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CIcIIVtpD8t0KpIYltz2h/fHgkkVVjOZ3d47l/wPIUg4HxhMKXpaq3mDqxlZ51Md8LgAdA==
X-Received: by 2002:a17:907:9443:b0:a7a:aa35:4099 with SMTP id
 a640c23a62f3a-a7d3ffad2a9mr815189166b.26.1722357325168; 
 Tue, 30 Jul 2024 09:35:25 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb9202sm656205966b.209.2024.07.30.09.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:35:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: aharivel@redhat.com
Subject: [PATCH 2/2] qemu-vmsr-helper: implement --verbose/-v
Date: Tue, 30 Jul 2024 18:35:16 +0200
Message-ID: <20240730163516.83566-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730163516.83566-1-pbonzini@redhat.com>
References: <20240730163516.83566-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Similar to qemu-pr-helper, do not print errors from the socket handling loop
unless a --verbose or -v option is provided explicitly on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/i386/qemu-vmsr-helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index bac3ea70393..1644ac72da0 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -54,6 +54,7 @@ static enum { RUNNING, TERMINATE, TERMINATING } state;
 static QIOChannelSocket *server_ioc;
 static int server_watch;
 static int num_active_sockets = 1;
+static bool verbose;
 
 #ifdef CONFIG_LIBCAP_NG
 static int uid = -1;
@@ -265,7 +266,11 @@ static void coroutine_fn vh_co_entry(void *opaque)
 
 out:
     if (local_err) {
-        error_report_err(local_err);
+        if (!verbose) {
+            error_free(local_err);
+        } else {
+            error_report_err(local_err);
+        }
     }
 
     object_unref(OBJECT(client->ioc));
@@ -431,6 +436,9 @@ int main(int argc, char **argv)
         case 'd':
             daemonize = true;
             break;
+        case 'v':
+            verbose = true;
+            break;
         case 'T':
             trace_opt_parse(optarg);
             break;
-- 
2.45.2


