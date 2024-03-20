Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74FCC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFN-0007ab-BO; Wed, 20 Mar 2024 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFH-0007PY-Jd
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFE-0004IC-HH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tP3AQ3pbPz8m6UOga6Zsv2ln7wozO0aBuqOElcXzXaQ=;
 b=Q7nLzq+T27FMwKVZr9Zt5cHGxDtskenD0Tir7lgORPzg/pEwYnZZ2Ss5ZpLka6BTmhv52Z
 7rhenb8BhhLhUjHq8TvxTJkHl2Hv3Hnk8Yql6r94uUnQ28oVUzhxzAYrNFgZ/P+AlTUbQk
 pd9n6zzBOY+o1n3kWCrSxm4bNJMDEJ4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-x3VMJdPkPFC8G37QMFCYJg-1; Wed, 20 Mar 2024 06:32:26 -0400
X-MC-Unique: x3VMJdPkPFC8G37QMFCYJg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a46fd54fbc1so5647266b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930745; x=1711535545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tP3AQ3pbPz8m6UOga6Zsv2ln7wozO0aBuqOElcXzXaQ=;
 b=Y2p+BHEf2gHIEq5aVQIoIeOWzPFUSPoTD5Vy3jS0aVT+PG1cULmuwBWR18dwXt97Jl
 coHLd4HnHVMjl/AFVstwVwOkb8PyYBTZdKJNDmzvlDoxLc5S8/cZkjWslINEE4w0S8zI
 Mjl/I9/A3P40VbHifD5GoHTr4PZ+OCAPl9pHD9P2e9dQ8D3aMuVO3wVZBLk/LwwEsSxZ
 d6D9wg1dDljZv5rkpIZpahxcue3RU/I4nUCambohWJi0p3ic0qd3bcNLoQ/Gr5PkKgy7
 orAv0xTlGAAJ6leSFIMXcWqoXielFm6RXnPyRzF3h4MoRxLsyNzm3QHdpgtOBnm2M4A6
 maWQ==
X-Gm-Message-State: AOJu0YzZSMhvm4mL7Qx+Fko0Jw99oqwAdI48nwTsZsKWY6Dlcsf2cc1d
 yvrdwr7Bp7jcGzxDIBCjj8vSQcHKsW+NDAQtTns8FruL2C8rObMkcBZorhcvObR/i5AIVkKbCWr
 4rPZV+xIqpCRu6/8fOiqdQ/hCD4yKsMYEPLsEIzSvlbLGdFm8GUcHk0jOYVV4W0u3IhCun0W4dt
 gI/jOPTtH59YC8jy+6T7cVh+K6TMtJNaQHX8T0
X-Received: by 2002:a05:6402:528c:b0:568:c624:9177 with SMTP id
 en12-20020a056402528c00b00568c6249177mr10709816edb.35.1710930745156; 
 Wed, 20 Mar 2024 03:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pzCibz8Uhdu+ZMuSMseOfPsBi64Hi7C2qmjOdz0qzDHzGrZkEXyOGQJV7LhNxDpiTboHKA==
X-Received: by 2002:a05:6402:528c:b0:568:c624:9177 with SMTP id
 en12-20020a056402528c00b00568c6249177mr10709795edb.35.1710930744698; 
 Wed, 20 Mar 2024 03:32:24 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 cn25-20020a0564020cb900b00568c3a2f4f8sm4527242edb.74.2024.03.20.03.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 4/6] target/i386: Revert monitor_puts() in do_inject_x86_mce()
Date: Wed, 20 Mar 2024 11:32:11 +0100
Message-ID: <20240320103213.1048405-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
References: <20240320103213.1048405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Tao Su <tao1.su@linux.intel.com>

monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
may have a parameter with NULL monitor pointer. Revert monitor_puts() in
do_inject_x86_mce() to fix, then the fact that we send the same message to
monitor and log is again more obvious.

Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Message-ID: <20240320083640.523287-1-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda1..23ccb23a5b4 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -430,7 +430,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_puts(params->mon, msg);
+            monitor_printf(params->mon, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
-- 
2.44.0


