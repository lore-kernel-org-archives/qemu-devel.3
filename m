Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9843BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFp-00050s-7a; Tue, 06 May 2025 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFO-0004B1-5b
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFK-0002D2-T7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+B/e/jQLvjp1zUQjAa3+VY4igRcEr7YAVAoc3I64Dmw=;
 b=QKkncQ6+LLDxjEB1iKMt+iSOd18pUTULxcXNbbNGyE7I4kjd1ZUY35rjHS0U1bUHW42SFE
 cQFen7byqaYIcf+wSaUiV17ysthW9FXpGtTOt/x/DAl/kB66SUYW4U9txVI8LcHrDLKY77
 OaU31/0bBPBWq2wBqilKDqd0ms7Jjcw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-o8nn04ALMQ6XC5kO0kSnFA-1; Tue, 06 May 2025 11:30:11 -0400
X-MC-Unique: o8nn04ALMQ6XC5kO0kSnFA-1
X-Mimecast-MFC-AGG-ID: o8nn04ALMQ6XC5kO0kSnFA_1746545410
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so29906415e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545409; x=1747150209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+B/e/jQLvjp1zUQjAa3+VY4igRcEr7YAVAoc3I64Dmw=;
 b=rzhWEDCyAb9oXyhjpPMykNZmEMJhNQCcqcn0/HJWPAvSWWkBQey3ByvQ4vQ5oIxsc1
 UYRC/ZOWd7rnuT78i3LAZ6hqmFy3K3g2UbpP+w7kb76/xniXh7pXSztfJpfVAnfpb2iu
 rb24NCZXv3UihIzse0rHOg5WMRmuLMbse7VVTh57xEOy3u12LRvXXjs4oPbsCv7mlPZg
 Ow65/x1IGLUTz7Ox0SmrJmdbupU53zs6SlGBEmAAZFCKnylkmDAzgQiXRPsqilkJcs5H
 LhqV26HkkJ72hOd4PneNGRS2v/dFY6ZwXd+nOEJK0RnUM3lWiNkpoaJsYIcQwNBbgdHC
 ZEew==
X-Gm-Message-State: AOJu0YxY0GTgX9AwiIQ6UzSYLvFON1N9xdANSvraW93/s6WRJSPTH+SG
 xEgNkG4R0kr7bZ8LCKSOyUMHij/NS9kcr+GTpC66ikS/yE1NoBOrDYb+wvEmIsnqcsu+fCKgQ6s
 KuA1ylJ+XlvmDSU4CdqIw9VYWoW1XLehnW9SYxdIzyYWfcPm5uaCi72YcbU7vactAzZveGznXij
 XyVhqnU2NDyV5zu+5EzoFfx8MxMHbWtZ5Qs7p8
X-Gm-Gg: ASbGncss9ylG8ErOrY7cP7XyixBqRZItA/yaylhs27GGEKWWkyWI5Io3OP2XbVGr2sv
 XAjIDk5Wax+fl5URrbUy0wUrhAoWyTVaFcqpk3cAmfQTwTXFpd/F4ikRBB4Vvd6AoGE4eQ0ZoPo
 R1mI4NnOSXBx3enhLszn1S/DveB7T0GhgekLCJIThsiGcwCeOaccWR3lM3A93wduN5hRKXXBsEB
 4IFlbrHgEkqocifXTKDrh0LQp1qSDn6VTTHrqblhZw1DEfbN3vpFWK0FTeocNexnBcxWzw+U7Dp
 qm0oif4C5+GT4hs=
X-Received: by 2002:a05:600c:1d9e:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-441c48bc8f0mr100993945e9.8.1746545409169; 
 Tue, 06 May 2025 08:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHfUnO3MIXYaxDuV/X4gxFY5IO+XsnLzED0/hbvDB9vlSOM1HG3cS/p+THYBvpO/5aYiVaiQ==
X-Received: by 2002:a05:600c:1d9e:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-441c48bc8f0mr100993635e9.8.1746545408742; 
 Tue, 06 May 2025 08:30:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee39esm172303685e9.21.2025.05.06.08.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 19/30] target/s390x: Fix type conflict of GLib function pointers
Date: Tue,  6 May 2025 17:29:14 +0200
Message-ID: <20250506152927.222671-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/e91c4e266b839f62b5c41173a05896b210ae1180.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8951f1b36f9..954a7a99a9e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -373,7 +373,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
     const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
@@ -415,7 +415,7 @@ void s390_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_S390_CPU, false);
-    list = g_slist_sort(list, s390_cpu_list_compare);
+    list = g_slist_sort_with_data(list, s390_cpu_list_compare, NULL);
     g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.49.0


