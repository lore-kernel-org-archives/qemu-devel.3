Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930BAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHKF-0004RD-GW; Mon, 14 Jul 2025 07:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0Q-0001NZ-JU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0L-0001xx-J6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBwevjOhRk6EkhoFd3vWdZKDnsxohT7/wN7rE5aDxAg=;
 b=aPfnXe3mVvJ7Z/Px9UsyMAp+lq0kG6aXEs1ESmC53EuOScHsd84zLZmgQsPawAuF2T/j6a
 ayxJ6a+kmr2TmcQ5f7EXqIaQwrhfzBrLDZtultUw/lVeWublK9IfYfC1mqT7Op0tvBQrkl
 GALAFNr9hQQpbk/1a26n7zIZjlU/nnY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-O2dXi3ngMpqN9XAxmj7idA-1; Mon, 14 Jul 2025 07:05:51 -0400
X-MC-Unique: O2dXi3ngMpqN9XAxmj7idA-1
X-Mimecast-MFC-AGG-ID: O2dXi3ngMpqN9XAxmj7idA_1752491150
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1416982f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491149; x=1753095949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBwevjOhRk6EkhoFd3vWdZKDnsxohT7/wN7rE5aDxAg=;
 b=dF6jki/7aEbg7+ygtOUsLQ0ryfQ/R0hBoPaxOin9KEyOYaQkhDJDfGVQxFUeeM6m7L
 8cN15Wb/2z28pV3S59Gpunm8aTW3b58cxQ6v6iVt0Emta8mQ/8iCsVT/RN9pdX9x0ADn
 YBc0MV2cfGxB/DAvjgKqVJyD0Jbpq7/4hP7LjZEfhZAgrKG+rw9i76an8DOrHJ6d8bip
 w7FfDjX1imG8LdFFTFbbp5BG2597P714k10W/VGNqTKxXg2tfSXn0n+YNaEv3xoEm6oS
 Zf14R3/CAmDd1I6Y3iW/sv+gIvLCZgb2NSk5qDkRQ7fsEq5ozCr1b7lCRc52rnbvbpWu
 ujZA==
X-Gm-Message-State: AOJu0YzJC7bWRz0gw4Jef925YHfkBCR8sVbzMScPPg5/FMC5zP0hC/mu
 h+uU/yUSw9sH3XfiQOHxYGvRS86jXxFbj6zxQp8ULVUjKdkpg8GkEZ/Z/PfEswtsY6pFHVswCuk
 ir/Jni85CMXgbcPftAMLdzNj3tSYalym3WuzTK94Jm7NDf1CIjeTer9gO8cG+2vxts55qSX9+dc
 1v7tiP0x+b2lM3kE6rw9CfsSaa75z6UT2C1iqa6JUF
X-Gm-Gg: ASbGncuH5uEz0fScMh7cHhDx9ad0Jnx9ostOrNHvaXapu/DzmY3oV0nRbjmHj4R1a1Z
 Svesov9MPo8ELU+41zpZnBP/n+dwcllHKpZbKElSPiHSYRjhU2CNO31CsxIOJ22elnqWPxyAzsw
 uxm8IFPKpRuSR3BZ+UhB+VWMVNf07Z0BjQh/FguyuuL3dZy8kCVsUggzZv8Hi0bLcFgqa6JqWs2
 6XMIWm9lkbOl6AyOUdhhU4WB5Q36ri3KpMyOH0hu6QDBBvTvoBfw9DbxmeA4gaW5XmeveN7+VKy
 cx68L+MFmqoGWVcQDf2Bh1hNXI/Y+FZPTsj90agrGoA=
X-Received: by 2002:adf:e186:0:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3b5f18debd5mr12150444f8f.57.1752491148635; 
 Mon, 14 Jul 2025 04:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3CtiCjNnS3zYqf88BuiobIylpZ9ILgZlGY8K7rcRW3Zd9I1K7jWjFuxPKGQc18OMlIomWSg==
X-Received: by 2002:adf:e186:0:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3b5f18debd5mr12150414f8f.57.1752491148166; 
 Mon, 14 Jul 2025 04:05:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45617dc1fccsm38365675e9.5.2025.07.14.04.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 38/77] i386/tdx: Remove task->watch only when it's valid
Date: Mon, 14 Jul 2025 13:03:27 +0200
Message-ID: <20250714110406.117772-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

In some case (e.g., failed to connect to QGS socket),
tdx_generate_quote_cleanup() is called with task->watch invalid. It
triggers assertion of

  qemu-system-x86_64: GLib: g_source_remove: assertion 'tag > 0' failed

Fix it by checking task->watch.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250625035505.2770580-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx-quote-generator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
index f59715f6175..dee8334b27a 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -75,7 +75,9 @@ static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
 {
     timer_del(&task->timer);
 
-    g_source_remove(task->watch);
+    if (task->watch) {
+        g_source_remove(task->watch);
+    }
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
 
-- 
2.50.0


