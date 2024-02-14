Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A847AC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFZ-0005vh-Gf; Wed, 14 Feb 2024 06:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEw-00050O-5T
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEu-0007Ho-Lw
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uf4Q9wGfIlQGBzOLWZQCxpB+JmyuulvBhB/9UEzfO+A=;
 b=VEwUcy8McP5SFM3WubDM/vKGiMy/gjaj/Bzip+V/l2CJFDVgVmdLu4vMeS+GOu2LtWHLLl
 wKwm5pE7CWGmExO0mMZRCc2AoKy2lUFkMmBnKbGxeXxU3/K8lHiHqzuosDUKcGvXGRAffh
 y9c+eEAu/E3NPdPLGvJKnfo+xozH5r8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-jOvTgSc6PjqmnAlFIVAwnQ-1; Wed, 14 Feb 2024 06:15:42 -0500
X-MC-Unique: jOvTgSc6PjqmnAlFIVAwnQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3d201e60f2so71831466b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909341; x=1708514141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf4Q9wGfIlQGBzOLWZQCxpB+JmyuulvBhB/9UEzfO+A=;
 b=iHVIpQ8gjon7WciopQ2Az6q3LEZ/BNTZq2uY9/CuXF7OMAPpOvuGP12QdXCLWEcNum
 qx5P0TkoakT+h99vDRubiPjNJOkVqL7dFPZeVHNKTawKrrCtkhAeLyEctyCjAWJc0cUp
 1GeaD82a2EvTHK0F56uyy7z9s0f4ZhI5ueDXoQjqi0jIQRjcNyiJ6Qb5ojSXlWuPALQv
 LTakKxV9U4KxWjxIFzoyU1TaZSEpUEgreIImmmcC3BrQ7gO2w4t+hOjsuWeRTZ/LBwcG
 V/ra/amQ0ePH9ptsgPuBgQnj1pJrUGsDSqwDpao3xb7uNpmm3tHDk8o1f0Wj2Jd+iOwt
 P8mA==
X-Gm-Message-State: AOJu0YxTdUVDtCuq9jUWXQhzM9t6+8zrYHcp7Z/mfhxN0GZoHu8FkUEu
 MAV3e3GJjF5gFvOZrkjcE/CDGP89CrwjL1kt5SqRhtY8YtKmvwQWD4lF2ZPAYF4o/O28uW8CsVU
 3IhsEgV/ImpYwqr8lIkTKRRf3hWYSqKYCoJmoKWETOH9kFsLAxe0Go+sFEpSkaswTxACXYutE3C
 CSyDewgQmSaROFBdWA9NhVwt+b/uirDA==
X-Received: by 2002:a17:906:f6d4:b0:a3c:a3eb:4c10 with SMTP id
 jo20-20020a170906f6d400b00a3ca3eb4c10mr1628533ejb.63.1707909341154; 
 Wed, 14 Feb 2024 03:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkA372y6SW6ww4IR24mwEOdcitcIbp9DkhnB5BKYBCCmiLYACOWFnC1lsgJDd3lZWrofTPpQ==
X-Received: by 2002:a17:906:f6d4:b0:a3c:a3eb:4c10 with SMTP id
 jo20-20020a170906f6d400b00a3ca3eb4c10mr1628516ejb.63.1707909340871; 
 Wed, 14 Feb 2024 03:15:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHPnSOA9eEWNPlYGqqJRpglthtcivzody29rPJAAxY5rjd6sJE947n6u2Mv435cCg4jXBxnawZwQlObMdSZcGFX03yAuRUrRXRM3iLN36wC6JaFPH5nNpX6RiHLiuok7nGNR4A4bnZtIM2xpylORn1Lcu
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ty8-20020a170907c70800b00a3d09d09e90sm1443404ejc.59.2024.02.14.03.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:40 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 45/60] hw/mem/cxl_type3: Fix potential divide by zero reported
 by coverity
Message-ID: <48461825af1bdc68cfa25fa0b698c958b65f7368.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes Coverity ID 1522368.

Currently error_fatal is set if interleave_ways_dec() is going to return 0
but we should handle that zero return explicitly.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-10-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1b92a065a3..71fcb44613 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -794,8 +794,13 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            dpa_base += decoder_size /
-                cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+
+            if (decoded_iw == 0) {
+                return false;
+            }
+
+            dpa_base += decoder_size / decoded_iw;
             continue;
         }
 
-- 
MST


