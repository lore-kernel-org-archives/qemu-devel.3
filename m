Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2240C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFN-0007bH-Fh; Wed, 20 Mar 2024 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFL-0007Rg-0B
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFI-0004J4-M6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPsOwUjjkUpLlUz7R/yokVcshcFaiD3ddgkd17IA1sk=;
 b=ArmQ6Wc3l9yjWltg0KY7obwvnC1H3j4dInwY7ZnYTdVi25VP0KJVQnTiE+uprEQDefj75p
 nN3TstVd4Ruu6MXnOEQBZq2vDLQhdu4M6n3xVroAY/WnPurnP89FpgKh5DNloc+/n4LjUw
 B7xlUeH9sQV3Uk8YkjbLkBgU982tbks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-FI7ZvslKNoKeglyOAG6YeQ-1; Wed, 20 Mar 2024 06:32:30 -0400
X-MC-Unique: FI7ZvslKNoKeglyOAG6YeQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a464f5e2499so289071466b.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930748; x=1711535548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPsOwUjjkUpLlUz7R/yokVcshcFaiD3ddgkd17IA1sk=;
 b=nrb8/5D/++XFaydedRGpKUB4rGyUFCn7u8YAyZKwBcIknSL+qenpPvjczJBDS6zxAE
 Byssn3tC5eP6z9x69F9BA1ib7m47LDtZZtmsX1q5N41txFtVUNfghPMQKMb9nJYpMy5t
 ucWEdROJw0CWOhGuVN1ma0XmKi9Oc8c0n+Wrv/Fbz2yAKuDqJ6WI6gLJHJ3DkkSe3MZB
 Hl/tHvHWxe4VvGlQ7gUMTa98o+Dhif8slM3eHNoLaBkLoLhS6JCGxyKfWfyoRksm7ecP
 Odg10pDOs9BKFQuRosGw7F1D8+DNoz/HRQHnLaRTwGfn6U26QYIR7ldSqvf/5NuRbXho
 wcYg==
X-Gm-Message-State: AOJu0YzFCW6ASmqsq2F0JA23uNZPyb59+ZAKU/36eiRm3falHdWt90Vp
 Vzfw8VueXuvr9KqijCBJlVubWl+WOnC02nD0o4DEuAcpSdvjoaE71/T6GpcKPqFbOb+/XFbu1/4
 71NN2U9LvANk8S5G8YAOL7vyJU6DipYp1Cc7jeTKzV+tFW2hewojEvbbca9+MLcqiYxl4DOc1ex
 PHH7BXCX82bXe0nnAHToqYjpDBFMy45oS9EJT8
X-Received: by 2002:a17:906:6b09:b0:a45:ad29:725c with SMTP id
 q9-20020a1709066b0900b00a45ad29725cmr3219893ejr.62.1710930747834; 
 Wed, 20 Mar 2024 03:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0a1lo5Hin/qhEUKgl4XtFBu6GZCGkqbtwLofH0ikc5uyOvHg5nw/iJB7GWu4RCaIX7nx/vg==
X-Received: by 2002:a17:906:6b09:b0:a45:ad29:725c with SMTP id
 q9-20020a1709066b0900b00a45ad29725cmr3219885ejr.62.1710930747540; 
 Wed, 20 Mar 2024 03:32:27 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a1709066b1500b00a461e206c00sm7014509ejr.20.2024.03.20.03.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/6] tests/plugins: fix use-after-free bug
Date: Wed, 20 Mar 2024 11:32:12 +0100
Message-ID: <20240320103213.1048405-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
References: <20240320103213.1048405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

rec->count.score is inside rec, which is freed before rec->count.score is.
Reorder the instructions

Reported by Coverity as CID 1539967.

Cc: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/howvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 2d10c87e0fb..94bbc53820a 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -167,9 +167,9 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 static void free_record(gpointer data)
 {
     InsnExecCount *rec = (InsnExecCount *) data;
+    qemu_plugin_scoreboard_free(rec->count.score);
     g_free(rec->insn);
     g_free(rec);
-    qemu_plugin_scoreboard_free(rec->count.score);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
-- 
2.44.0


