Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0905C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnN-0007RX-K0; Tue, 20 May 2025 07:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnD-0007JH-KY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnB-00032Q-IW
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mgYSHkWd+aIUzWuoObJiO8RMau0iMJObXQde7QL4iU=;
 b=hzZC52NMisCOiiqbLfVCoc4WvdvlJca/rUDLu36MUqR9RrjDDBkrpXzwXu21ijKxLp3tlS
 M4Jbs43I/fF7OSTABglCiEaZ1W2Am3nTB+1QBtkHduxztGsIr3RnHQuZhY/qxepTiMwZMI
 q9rWon8Hts8iEoxf4maoqesJCeYH9TI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-cgbp4UobNWOKmtDlkXKfVw-1; Tue, 20 May 2025 07:05:50 -0400
X-MC-Unique: cgbp4UobNWOKmtDlkXKfVw-1
X-Mimecast-MFC-AGG-ID: cgbp4UobNWOKmtDlkXKfVw_1747739149
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso439027566b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739149; x=1748343949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mgYSHkWd+aIUzWuoObJiO8RMau0iMJObXQde7QL4iU=;
 b=V/Czw8Rin2kgCKRmJKRqVhZthNfXxwar6Wzip4r+OnKXtjCQLQZIwaNPEbL+OulO+o
 dMKO4c7NWxPZ9YziURVEb5Jdzf6WnOIJEyz9Y0eL1k5+qolv8HIVoteW+IUNK2nOhDP0
 pGDcD6GBrni7Egyrujz00g1jsPAPw/N7xpxEKf2aD9Fy5vZOTEmLlEQ3Jf0vxd3OcXJa
 NoglAguAhKwo5L1LaKgcDZgpGdhyHKWW1WWq7pomg8delGKNfMO+V2/5OsjjUAzPfiNi
 mua66QL5Qyk9ciFfnbU+vi09XLY/I/lCyG2r4V5D5pa1oOFLMCgOVSEex1D1b1ogh+HI
 eU4w==
X-Gm-Message-State: AOJu0YwNarBwX2cs82HnPUCMV2yUXrD/83W49ucduZJfOCv9h/T8lz8/
 YDXg/zGnrEfuqHgzBm1eBWw+emhGFKTjSUHmK984p/FseWYJUk5IQqbzL727kCt433AS31d4JUn
 ja5AyDSDTqUJoKwrILFpOHTImPj9kJawFuLbVcTRcYWxmx7Y85KbzqaiGZQoXhz41QphrW8vflK
 tloI0Lg2h3QKLO0Xx77aYlbKf7N8l2jlPDfHNrIhy8
X-Gm-Gg: ASbGncufSY7qt1U3+beBAubSWBa/msR3hqt4I/MCLW6gfRNbzhBpxStpbLj2uha2onS
 y6CaQf3OoSsNsP/YB3Fe1qALmf5WD5I+zTyRonNLSdYgUgq5TJHBIXq1wGWIP4oYBGN7mjlN6eH
 s7yRo25fLcvyPk6XuEJDcl+oI/eKXTzFnQFr1+tq5/Gpu7DSuFMfXtsaDvy7oobg5UGy4Fg8L4H
 /bIfOS+PNKybEz8actOLv6ALYFX870dXra55+1OVD9r/w0qYeTTwOjIT5gfaEE2yaQqDa/+EZKc
 s+3N1zYUHUvHuQ==
X-Received: by 2002:a17:907:970b:b0:ad5:2bb1:8c85 with SMTP id
 a640c23a62f3a-ad52d511cd9mr1489706166b.29.1747739148728; 
 Tue, 20 May 2025 04:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXGUSHs2/AQdu/ppolwpUvhDLe9nNqzyOxCKgqmwQ0A8DP7eC2uUz92OaD3mJfnI7w4O+Lw==
X-Received: by 2002:a17:907:970b:b0:ad5:2bb1:8c85 with SMTP id
 a640c23a62f3a-ad52d511cd9mr1489702366b.29.1747739148218; 
 Tue, 20 May 2025 04:05:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d277a2esm715706866b.83.2025.05.20.04.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 08/35] qapi/misc-target: Fix the doc to distinguish query-sgx
 and query-sgx-capabilities
Date: Tue, 20 May 2025 13:05:03 +0200
Message-ID: <20250520110530.366202-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

From: Zhao Liu <zhao1.liu@intel.com>

There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
their outputs are very similar and the documentation lacks clear
differentiation.

From the codes, query-sgx is used to gather guest's SGX capabilities
(including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
if guest doesn't have SGX, then QEMU will report the error message.

On the other hand, query-sgx-capabilities is used to gather host's SGX
capabilities (descripted by SGXInfo as well). And if host doesn't
support SGX, then QEMU will also report the error message.

Considering that SGXInfo is already documented and both these 2 commands
have enough error messages (for the exception case in their codes).

Therefore the QAPI documentation for these two commands only needs to
emphasize that one of them applies to the guest and the other to the
host.

Fix their documentation to reflect this difference.

Reported-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20250513143131.2008078-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc-target.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 6814708972d..f7ec695caad 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -361,7 +361,7 @@
 ##
 # @query-sgx:
 #
-# Returns information about SGX
+# Returns information about configured SGX capabilities of guest
 #
 # Returns: @SgxInfo
 #
@@ -380,7 +380,7 @@
 ##
 # @query-sgx-capabilities:
 #
-# Returns information from host SGX capabilities
+# Returns information about SGX capabilities of host
 #
 # Returns: @SgxInfo
 #
-- 
2.49.0


