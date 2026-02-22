Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C87C636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASB-00084N-Ke; Sun, 22 Feb 2026 09:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARm-0007yi-0Y
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARk-0006fa-JM
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Im7oNw2Zu+WcIRrJsnueW164kyYoY+VkGWcj5I81nLU=;
 b=BGsMLfqFQVXOztYiwPeZd/xxwYjVEYkCWybjlBFqEXtARYw+XgNCMMMNEPavcXM+0szrRJ
 Et15+XN94Ur5bvNGOVpGQmcgiMFzidUqwLuKy6E6gdtJgi/54Xwc64CyPx6jt6k0tbg459
 dl79g/lV4jfz+/FbWkjqPviNtGL8QnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-RDFGr-yrMXGnbdGyRo9Yrw-1; Sun, 22 Feb 2026 09:28:30 -0500
X-MC-Unique: RDFGr-yrMXGnbdGyRo9Yrw-1
X-Mimecast-MFC-AGG-ID: RDFGr-yrMXGnbdGyRo9Yrw_1771770509
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso37563435e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770509; x=1772375309; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Im7oNw2Zu+WcIRrJsnueW164kyYoY+VkGWcj5I81nLU=;
 b=kV8RON78J4pC/v+lZ8qN17MtGBBSPeDww732yBa9PUN99Ps3EOJBVoFV0w/F1kviKn
 qRnu8cy1Te4oT6BFs7Jei6BVGbodqOYzChJPGAJLkDWzgCQgZEj183zCQUgRJxdPY+WZ
 SHlWXsacZb+yjdkPcYb0BSyDXrJV8OuMs72lIW8TN8x+mW0Obrm60Cy2AdH2syvPuU4d
 iwxaDadjMfEYtgWGRkfV3prlBSfEtExyKeA8WNjJNhD4ZNZTOYGnRMwdiht0JTcYdqZn
 S+O5Np6w6w0Oe1yHq6ou+QbKec0da31ssSGfKGwM7wMBo71aaov9/g4IkMVnPmjKglrB
 fl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770509; x=1772375309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im7oNw2Zu+WcIRrJsnueW164kyYoY+VkGWcj5I81nLU=;
 b=KqTn8g3S4oeCmHH2P0WNbXYmAS4rGGYZoZ6nGPUEI6ZKe/+cydx1Syv+c3GklDiX6+
 xeMY6osD3RtD5125t3f982rA+U1kEftGEY9Ux6F/A/jn5I6pMFRagLaY+FzzzpOlQI3e
 nCwZWxqp37C7p4Y8+ZfKx+Yzcn7C/B1vKPMAx+SJEiVZxjx4rI9kzcLSo/6yfZgNPw1C
 Phl7bJJdS6Yly9ri+J6lTN0cxlxj0rStssrkbH5XOgNzRSYpaU1dHC/IeZSAOSI36YPC
 7W2Dkqjv90ztbHE3JJOY0ulA5wb9Z71JqjzB/sdzkwoQixtx9XUNy+MJj2ObgzD+OXNh
 0Rzw==
X-Gm-Message-State: AOJu0YxjV8i5hbCJ+JQNhxb6CTx4yOwK8rh+hOTj09E6Sl9cLjQAgeE9
 t3v+cqi19WQCpyzgmpRM9KGPFd/87un8tPaWdDvviOk2kMcejULyeEZdWah9LADrnLaD4pFPTRB
 cvOMrFm3HEKEamNhYyfyokXHEJGWRsOJsntD7BklvEUiy3lnHUn/soO6bBkibWaZ7u1x/dZcO+C
 wij4aM+7G5QSTrgrQvJAui+dB3IVNzVhh1Iw==
X-Gm-Gg: AZuq6aLa4uja/kq/gXL4MPKF0JrTHcM1vsK1+wGC/M9pu22dEBiIQMocuHgTAxeOdH8
 W7Tresuf4XxZwD8yItNwJLd82QsYhCmYBKEVmR9jpG8X1RS+TvYTlEEZwCOznGbxVrWxh4z15TL
 OghAUoeoOPHbSJs+VB5JQSjwScASdv4F4mwWYIufDF5vvfC+VJJySzOQTZhl7Hz07gUDwKU6g5I
 iMn6U7albGz5J4lj/VQR7xQW+JxsATqrtiOnBc94ymjnApcnP/s02YlRdGhU5D5s+6+6jgsV4Jg
 1KvgWD/ST93TdrnZpWOotxlpLpKMvBA+ci+f6Dp6+svdQGunCDDrCXl+aqqreKT1bglCR8LsxTx
 dOAntfcvmiY7cs43yoFzlF/YZl0DxJKXh6V4yUjgzW0vq9g==
X-Received: by 2002:a05:600c:1f8f:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-483a95ee63amr123422505e9.35.1771770508608; 
 Sun, 22 Feb 2026 06:28:28 -0800 (PST)
X-Received: by 2002:a05:600c:1f8f:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-483a95ee63amr123422095e9.35.1771770508162; 
 Sun, 22 Feb 2026 06:28:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75b4dsm194822945e9.4.2026.02.22.06.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:27 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 05/33] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
Message-ID: <4d0830ea34abed563f15d3a236bef83a9026a7e8.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

/usr/bin/bash isn't guaranteed to be present. Switch
to /usr/bin/env bash.

Specifically, on Darwin/macOS:

$ which bash
/opt/homebrew/bin/bash

Rename disassemle to disassemble in the same commit (typo fix).

Adapt the correponding message in rebuild-expected-aml.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260210041248.14701-1-mohamed@unpredictable.fr>
---
 tests/data/acpi/{disassemle-aml.sh => disassemble-aml.sh} | 4 ++--
 tests/data/acpi/rebuild-expected-aml.sh                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tests/data/acpi/{disassemle-aml.sh => disassemble-aml.sh} (92%)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemble-aml.sh
similarity index 92%
rename from tests/data/acpi/disassemle-aml.sh
rename to tests/data/acpi/disassemble-aml.sh
index 89561d233d..62e1991ace 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemble-aml.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/bash
+#!/usr/bin/env bash
 
 outdir=
 while getopts "o:" arg; do
@@ -7,7 +7,7 @@ while getopts "o:" arg; do
         outdir=$OPTARG
         ;;
     \? )
-        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
+        echo "Usage: ./tests/data/acpi/disassemble-aml.sh [-o <output-directory>]"
         exit 1
         ;;
 
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index cbf9ffe0dd..af45cf3007 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -57,7 +57,7 @@ old_allowed_dif=`grep -v -e 'List of comma-separated changed AML files to ignore
 echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
 
 echo "The files were rebuilt and can be added to git."
-echo "You can use ${SRC_PATH}/tests/data/acpi/disassemle-aml.sh to disassemble them to ASL."
+echo "You can use ${SRC_PATH}/tests/data/acpi/disassemble-aml.sh to disassemble them to ASL."
 
 if [ -z "$old_allowed_dif" ]; then
     echo "Note! Please do not commit expected files with source changes"
-- 
MST


