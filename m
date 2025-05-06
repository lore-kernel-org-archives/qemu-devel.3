Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF1C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFj-0004dG-0I; Tue, 06 May 2025 11:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFH-00041y-PE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFE-0002CD-Q1
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqmZ1Q/DSGXGQuEc9+2vNyAFTCNLqHbJJqjylFfQo1E=;
 b=PS1v/nVvcAiOVA43qRikm2XtwFT7Pok0GHnNxalFGeT2EiLY/mFMJmfjSpT0no783P0QM2
 EW/2+rJKSxn2QsKEmP3fB26sNgQOub/nox1KkdB9HvSJVE9ksrnJrF3FXLT3OVv1s34gaP
 M8tFwNBo/GBQhz8hdzV3frU7YiFi9nY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-ChwbrfC4PAmBVnlteNxXlQ-1; Tue, 06 May 2025 11:30:06 -0400
X-MC-Unique: ChwbrfC4PAmBVnlteNxXlQ-1
X-Mimecast-MFC-AGG-ID: ChwbrfC4PAmBVnlteNxXlQ_1746545405
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so29905805e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545404; x=1747150204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqmZ1Q/DSGXGQuEc9+2vNyAFTCNLqHbJJqjylFfQo1E=;
 b=pc9AuJpSwGUMXPqVJSSJbp6toIkUZSR5+fjigIj7Iexo8zxMhAOIXo5JWOJbhHXdyD
 h6TheoMzEy8WOrDUqiq5Rf00oo77hmCjA4noKIWBQBZziP8qLLc1Ismtbaj2/KbBGepM
 itXDRZlxEyFeX1bU4613gNhg9ql1MRRyeSX3IU+4RUDCVKjr3wx+/eC92B1tJMD1Sb0V
 ZhlkKVdZOSKKU3pVqyseht2jO5HsM1jOju3cZCCIbOoI21qjVxQTqT3fI35gNbYm52NS
 qMZhe4Mwr6qWEqF9KYWEOzNUDmecY0rJqxinzB+tQ/8kG90ADMmBcgWue/tsbPqLKNvU
 Sl2A==
X-Gm-Message-State: AOJu0YwOcosECUX+dBCUKphBTzrydVDjsigdS2frWtZ1UFcgglJfRUAZ
 DKJlaQ4G4msyu7IuoYJNCrQ8xYEiEww6/u88U5u7f7TRKoTeGvDQqDqFML4P1t5E7ZGtrKLdtJE
 fLt+mEXvjDiq9Wr1o5kOxEAAydaBvNZ5lZVAI59XS+uJrV+7nBkCNUrzVpZTaBejgrgFebyTkmI
 AB5JmBpyFdms45ksFLdJ/sgdrBy/h+P4231kMH
X-Gm-Gg: ASbGnct6FP3nR1S+ArOKUelYYWw9gc7HTGmjLINRnTZuD3xWKAyX+gpCP15fPxDL/zt
 igjnFypMiTRyvBQnj2tQ41eSfczyjkVDEqm00z2jllwNZisGsxJ88tqcXJoErZPl42KXTjYfp79
 EvnL31UH+mxlW+UBLnEtbdzyDdlfCj4+iKbrpqKJPg1XWXk5XBmKldM5522QtYpagpZh49qVFis
 sVsuRiCLK2WmY3imnEBHfgut95rTmWBM0WLzUY6LAvw6iY6iNDiDG8q2naY6ZDA5o9F8nLOVTba
 hMHpjZTHRTEfo9s=
X-Received: by 2002:a05:600c:37c3:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-441c48b03c6mr119765305e9.2.1746545404580; 
 Tue, 06 May 2025 08:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEONxT7HyvI4xklcUmnv3xCDwHGB2nwJufb1iPMVLXNzm5q5ScuV2Bd0LNn7xT4TnE8xBj4tA==
X-Received: by 2002:a05:600c:37c3:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-441c48b03c6mr119765045e9.2.1746545404238; 
 Tue, 06 May 2025 08:30:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28082sm217263045e9.34.2025.05.06.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 17/30] target/i386/cpu.c: Fix type conflict of GLib function
 pointers
Date: Tue,  6 May 2025 17:29:12 +0200
Message-ID: <20250506152927.222671-18-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/8ee6c2b02c97d5db358c3eb290d00afe71d1ceb7.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21d5ed222..1ca6307c72e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6240,7 +6240,7 @@ static void listflags(GList *features)
 }
 
 /* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
-static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *class_a = (ObjectClass *)a;
     ObjectClass *class_b = (ObjectClass *)b;
@@ -6261,7 +6261,7 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
 static GSList *get_sorted_cpu_model_list(void)
 {
     GSList *list = object_class_get_list(TYPE_X86_CPU, false);
-    list = g_slist_sort(list, x86_cpu_list_compare);
+    list = g_slist_sort_with_data(list, x86_cpu_list_compare, NULL);
     return list;
 }
 
@@ -6318,6 +6318,11 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     qemu_printf("  %-20s  %s\n", name, desc);
 }
 
+static gint strcmp_wrap(gconstpointer a, gconstpointer b, gpointer d)
+{
+    return strcmp(a, b);
+}
+
 /* list available CPU models and flags */
 static void x86_cpu_list(void)
 {
@@ -6340,7 +6345,7 @@ static void x86_cpu_list(void)
         }
     }
 
-    names = g_list_sort(names, (GCompareFunc)strcmp);
+    names = g_list_sort_with_data(names, strcmp_wrap, NULL);
 
     qemu_printf("\nRecognized CPUID flags:\n");
     listflags(names);
-- 
2.49.0


