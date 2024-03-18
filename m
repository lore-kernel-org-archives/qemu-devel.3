Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E0CC54E72
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFf6-0007dV-0s; Mon, 18 Mar 2024 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFez-0007TU-Lc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFew-0004i2-Fv
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmhlT2tArR795qwjPsN2LzEPLg2rhync7H6puhjrXTE=;
 b=BUv0BQTH82hAVLmzhiuVX2okSzODjP8bzqROCNyskbsYP9p3C/W4sNRuSnKBd6mONDraPA
 Jvwwr9xC4aCzg3MGj2gxt0HFqebS09Hmc/gcZcPWCAvkfTya8wNJx9kuJ7PQhd5WqsR4v8
 bf/974LjjQ0AWaP95Kgrc9gcR81HXTY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-mFuCNvOkObKmi0pMRNOh1Q-1; Mon, 18 Mar 2024 12:16:19 -0400
X-MC-Unique: mFuCNvOkObKmi0pMRNOh1Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a5bae5b3fso4044828a91.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778578; x=1711383378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmhlT2tArR795qwjPsN2LzEPLg2rhync7H6puhjrXTE=;
 b=v1VTvedDmLMxKkLnLSXzuBf5ClWOCXF0lVMb7Le3qbZN05ZGGzkiWBgXSUPmMa+BpZ
 bhtheGb3rT1g9O9LxdLNCzuCRc6F/ncIyo97K2o6JqPR7JfinrBOey6n31o0Mr3f/o26
 avfNxM9FjblS75ouV7eG9iI/HPMb/RRvvVYnYSEE3lUZu0dhOBiYPUow5EkK/gQtU+qP
 XrtgovdFz8A4lpa5WAD4UFFvevDCFXAR1heUGfo6rCENPHkce/s6coJ7SnwOnkPrSL9p
 0L19YvHaaorBkrdd/Mo8+Zrdy0XvqDhxe10D/kvFaHeHyV9jiaijLG6re56Vl3Z26tVn
 xoyg==
X-Gm-Message-State: AOJu0YwjEwHYM4+yMZOxVsN0Li/f9NrQuUSSQhkTqjFdkARYgM2lVdIe
 9OEBU/BjPfUtnLU7Aah8cixb/cew1F0kwuz3SWe79lKuofMnTdaLAeEZ0A9OlU15/lc4dpANW2y
 39DJdx4REOZBLcVGA8kF1Dy/Bkjqhuq6KJn46z6H0t/1uMbMeOcoVK4ef1sAUVrz2hMi+3hy0fZ
 czU5X5R3b/nioy3lu7M77Ln8b1Af22CQ==
X-Received: by 2002:a17:90b:ecc:b0:29b:9a08:6007 with SMTP id
 gz12-20020a17090b0ecc00b0029b9a086007mr8519066pjb.46.1710778577621; 
 Mon, 18 Mar 2024 09:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq121vnI5TfSb1cb5Zm2WAVcSJJ9HyL76IXwiR6QccA5HrGz7qOv4smfwulKfkJqNi0qGxUw==
X-Received: by 2002:a17:90b:ecc:b0:29b:9a08:6007 with SMTP id
 gz12-20020a17090b0ecc00b0029b9a086007mr8519021pjb.46.1710778576841; 
 Mon, 18 Mar 2024 09:16:16 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 so10-20020a17090b1f8a00b0029df6fd2780sm6453073pjb.9.2024.03.18.09.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:16 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/24] smbios: add smbios_add_usr_blob_size() helper
Message-ID: <684b49fda6735fef7ee07bb2c628b37fa114ca1e.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Igor Mammedov <imammedo@redhat.com>

it will be used by follow up patch when legacy handling
is moved out into a separate file.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-10-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 30196d2911..090a6eb018 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1411,6 +1411,14 @@ static bool save_opt_list(size_t *ndest, char ***dest, QemuOpts *opts,
     return true;
 }
 
+static void smbios_add_usr_blob_size(size_t size)
+{
+    if (!usr_blobs_sizes) {
+        usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
+    }
+    g_array_append_val(usr_blobs_sizes, size);
+}
+
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
@@ -1458,10 +1466,12 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             smbios_type4_count++;
         }
 
-        if (!usr_blobs_sizes) {
-            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
-        }
-        g_array_append_val(usr_blobs_sizes, size);
+        /*
+         * preserve blob size for legacy mode so it could build its
+         * blobs flavor from 'usr_blobs'
+         */
+        smbios_add_usr_blob_size(size);
+
         usr_blobs_len += size;
         if (size > usr_table_max) {
             usr_table_max = size;
-- 
MST


