Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44C8CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1i-0004i4-VD; Wed, 09 Oct 2024 08:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1h-0004hg-Ea
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1f-0005Qs-MC
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dP5VLpH/CdfMrO+j/wA9qzkuALnn3Rt2eGfiqdxtHY=;
 b=TMrBt3PJ/7PC5kWdjrw0CZyxhutrCp/6l2LfA7m3modMfjtzKKo4klR9EJorGqNf42DZFB
 bAHfURCIIgzx/CP3yvIWCS7VkStevktVJD2ATPbCXjR3KW7virSIex+b0mLywMBmLavpIT
 /vRRcjGcTbtkdssfNWX3mkneV+IqbXw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8UTeEMiRN6-_Nh8eELdQCA-1; Wed, 09 Oct 2024 08:42:46 -0400
X-MC-Unique: 8UTeEMiRN6-_Nh8eELdQCA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-835428b766dso46664839f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477765; x=1729082565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dP5VLpH/CdfMrO+j/wA9qzkuALnn3Rt2eGfiqdxtHY=;
 b=DY2h+yPqzTNdClKzYq7qJ7qzs8u/1/nYN0jbYD8F0wuVhle0ihZR5gaFsM5IIMc5q6
 vuc9cLctpSstlv8dolHZKStqW/cp5oVtv8cFuhSwEKjGdsg9TTWJdRuGtlsy/ifw7Y3p
 eKoTkWuXvf/SszdRhSPlpfoTC4wkw3sVF03g7ck1K5smCyGyW/jHsJx1S9lcXaxuJAuq
 4kkj52HjNtwgf0FQ5x6rbxCjazsw66Y2OXeZh1D17TmmKPeu2/XvFcRZwfEAARV/2Wre
 8oa1gVXdY/gvEDz813q3EUBJOwYQA0ri/t075xmQrzTRz7BSR8NFas0dF4G3gNxQ2eQl
 4iFg==
X-Gm-Message-State: AOJu0YwCfai2OvqO5HemqTaX92yXhtXSNLrlNtwrm0je1/wihp1OLhOj
 p5hVl/8C5i5BHHk8fcXzhVT5nXuNfT7s4UzPjjuEx3dPsR7xUEY4vXFaSSUIu41rifFcStjv+L8
 Tni64znXN2kiyJuFBAR0M9AneDapOAsTJpg6ewRw5HBDzQ0x8H6tNvyDb9a0AD7ZAX6X1v1U/hg
 zkXSBMvJEIaggI1EuF7ta3sogZ/NxawCYsgA==
X-Received: by 2002:a05:6602:6b07:b0:832:40d0:902a with SMTP id
 ca18e2360f4ac-8353d4a294bmr302685939f.6.1728477765096; 
 Wed, 09 Oct 2024 05:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwjy2fxISajlh32nV/U7MGRfMgnrbid48+PkBRgkRJpAT5yUqjLydvqLrZl7XaxQUUj/xdpg==
X-Received: by 2002:a05:6602:6b07:b0:832:40d0:902a with SMTP id
 ca18e2360f4ac-8353d4a294bmr302683139f.6.1728477764634; 
 Wed, 09 Oct 2024 05:42:44 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL 02/12] migration/multifd: Ensure packet->ramblock is
 null-terminated
Date: Wed,  9 Oct 2024 08:42:28 -0400
Message-ID: <20241009124238.371084-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Coverity points out that the current usage of strncpy to write the
ramblock name allows the field to not have an ending '\0' in case
idstr is already not null-terminated (e.g. if it's larger than 256
bytes).

This is currently harmless because the packet->ramblock field is never
touched again on the source side. The destination side reads only up
to the field's size from the stream and forces the last byte to be 0.

We're still open to a programming error in the future in case this
field is ever passed into a function that expects a null-terminated
string.

Change from strncpy to QEMU's pstrcpy, which puts a '\0' at the end of
the string and doesn't fill the extra space with zeros.

(there's no spillage between iterations of fill_packet because after
commit 87bb9e953e ("migration/multifd: Isolate ram pages packet data")
the packet is always zeroed before filling)

Resolves: Coverity CID 1560071
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240919150611.17074-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-nocomp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 07c63f4a72..55191152f9 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -17,6 +17,7 @@
 #include "multifd.h"
 #include "options.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -201,7 +202,8 @@ void multifd_ram_fill_packet(MultiFDSendParams *p)
     packet->zero_pages = cpu_to_be32(zero_num);
 
     if (pages->block) {
-        strncpy(packet->ramblock, pages->block->idstr, 256);
+        pstrcpy(packet->ramblock, sizeof(packet->ramblock),
+                pages->block->idstr);
     }
 
     for (int i = 0; i < pages->num; i++) {
-- 
2.45.0


