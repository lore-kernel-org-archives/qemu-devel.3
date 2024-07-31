Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10D1C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7MD-0006iL-2K; Wed, 31 Jul 2024 07:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7MC-0006eu-1a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7MA-0006pz-Lj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EV2mr0xjlD8I0ffhcoIthBmy7Vwwm1tNrboAunzoeDA=;
 b=LKPwr/pck0uaFPWXR8d7T+7LpPw3p+7sCoyaQ53jFaO61ph1OavMEA1wTJvzFIDg+bhl4b
 lpty99bkKNpUSiLCsbYuzGTs/QkQ+4Omq35VdSblefmy/La86BiN9efjiBkjW7AjLaIz3e
 Fo7Uarh1D66ow6gp+BL5LjVtuV9W73Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-r-7XXpaIO0qX3M_Oy2I2Kw-1; Wed, 31 Jul 2024 07:18:56 -0400
X-MC-Unique: r-7XXpaIO0qX3M_Oy2I2Kw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a8a38a4bcso248894366b.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424734; x=1723029534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EV2mr0xjlD8I0ffhcoIthBmy7Vwwm1tNrboAunzoeDA=;
 b=uEvjmnDGRZwyNDRhwPP1awM13cWCCh9gChQ1OuSSd2QCloC7Z6vL4fZaWLD/Di7nZJ
 Orwo2x/8pAj14NDM6XMGvfYqWzlSqWqSnKaUYTrmiLDlYWw9XaGA/EJTJFCpq4Ln748c
 plT3TUGJG/NmQ6jfDwjInAnP567pAIWJfnqmSeNQXAEIaa6+DIWLEuO+Ffdt64aVvZpv
 9Sdc48mhjCR1o+p1ojgCz2oEMxyspiv7AC2IT1fZKxNkVFuiCaiRLZE/sfFO8z63dLWv
 JQrlqFLGlubiUvMB+ka1RpOjylKUsXPCmcsEw3o+aiUDkycMvKXQwwipU/LDQTTVBeCx
 Rbgg==
X-Gm-Message-State: AOJu0YxSv6CZLM6GRKVNi1xXb8tBNFjW+dfLTcWnValFyErSt/r3cU/v
 9Qxt9c+0Ecxx3GL4vhAR9w34iQUDIDb8joWlhCbWfzUVwMSaPgS2GxdYnlH8//FGIZfUNZtLFEv
 2UP+XHsglI+wfe9GjS7fdHhsoZLVBksPDCDz7MRN4gTUxDM+vlUAbCdogYdY6N8GH9xU+ceB9az
 LbgmgKrzGTW4o+UnAO/bKNTo+6lREf67ObRyHp
X-Received: by 2002:a05:6402:26d6:b0:57d:669:caf2 with SMTP id
 4fb4d7f45d1cf-5b02317d0a3mr14495172a12.25.1722424734653; 
 Wed, 31 Jul 2024 04:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7zHnVt7DRPrWIor5mqy5dZIgpU/a4Mw86c+ii0dl1hXAuomGRwncvq1aI6v6Bj/amnhQYZw==
X-Received: by 2002:a05:6402:26d6:b0:57d:669:caf2 with SMTP id
 4fb4d7f45d1cf-5b02317d0a3mr14495160a12.25.1722424734273; 
 Wed, 31 Jul 2024 04:18:54 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5afc05c7a44sm6913068a12.6.2024.07.31.04.18.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] qemu-vmsr-helper: implement --verbose/-v
Date: Wed, 31 Jul 2024 13:18:06 +0200
Message-ID: <20240731111806.167225-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

Similar to qemu-pr-helper, do not print errors from the socket handling loop
unless a --verbose or -v option is provided explicitly on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/i386/qemu-vmsr-helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index 585eaf88b37..a35dcb88a3f 100644
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


