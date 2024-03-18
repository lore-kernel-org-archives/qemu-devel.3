Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FAAC54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfk-00026d-6Z; Mon, 18 Mar 2024 12:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfh-0001vG-LJ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfg-0004pr-4l
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oudmh77QqdmxVDf9O5bZqapc21I8SNv8IFbcNJgWAaM=;
 b=BP88uBLdXlRSt+JNpUJeu2eFQu+wqBbqSVVAQKAeWOtQRN7XeL7Uw897i6I9c8/Kgza7ty
 QLwf7b6DWkSM+naBS4SOLu91Q9LlJYDN/YsqrEyrNU8TRyS9ON2mcsPeB9kCrOAQz5j+T6
 uE/iwmsag5nYEoVDCjd543Qw2XnhpxM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-M8xD82bEM6KZu7ZQ_1_pdQ-1; Mon, 18 Mar 2024 12:17:06 -0400
X-MC-Unique: M8xD82bEM6KZu7ZQ_1_pdQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-221bd0d2bf6so5985654fac.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778625; x=1711383425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oudmh77QqdmxVDf9O5bZqapc21I8SNv8IFbcNJgWAaM=;
 b=LgDhzbTdLHt9IRHRQ+aVyppY+FRerlSVDSaLPVfZc0XRxYX5rZRd/X4QmI7oVZLLyh
 rCvUmkMs3kjFJuiaKgT7rJS9QoKasQpiGmiGjLL/3QXh2CjhZWACx7Xo04nF1lLpQioP
 Dqn4RnOPH4rMRtnzMQwwnsFaPoYiLULS/iMSbrE1ZiqlHk2ch49bdBtiVa0WpNn97PE2
 ZzdL7zLU/k7a9KZj2qTVW6FoImOWXEwJ0cpqMikJWymV+CeHzWb8r6FuGuDhvQJlJaJD
 CmVZo+ewV237Ztq1jfimH01Wbm1q5nIrBaB7ZzgzwOogj4RZTQ88197IHa2jdv+AxQew
 B2Eg==
X-Gm-Message-State: AOJu0YyDDtwWTtvP5L9TqU/5Bw+eCqQre3HS/rgFcxy9wKaPVVw1m8nn
 2kzZzbq0GjEnHtTx3F4IkGcBgXfc/3jj97S5xppk1Fpwu3uEVuk9A6yYJ6QPtccSbL2E1fYQ58M
 5aU4rNrcCBUVUKmo5oqR2Ltd2flNpZqjMqw5fyfEpXdhJM6F7dwkZr6J/1SN+JE99zF8Ouras+d
 b1UkPaCXBeSKTCMbWp0c+Ro3p50gkheQ==
X-Received: by 2002:a05:6871:586:b0:220:8c56:d30d with SMTP id
 u6-20020a056871058600b002208c56d30dmr13292983oan.42.1710778624784; 
 Mon, 18 Mar 2024 09:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjOfmy111eUVW7u5ws+pOO/oIKXxreARKaqddZH2bSwYwY4uGjqF2RiUYv5s1Z5QLnyfZ45Q==
X-Received: by 2002:a05:6871:586:b0:220:8c56:d30d with SMTP id
 u6-20020a056871058600b002208c56d30dmr13292937oan.42.1710778624091; 
 Mon, 18 Mar 2024 09:17:04 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 y71-20020a62ce4a000000b006e6b989514bsm8431082pfg.60.2024.03.18.09.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:17:03 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 23/24] tests: acpi: update expected SSDT.dimmpxm blob
Message-ID: <86e372ad1e22df373878e5c1cbda2d5026a34331.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

address shift is caused by switch to 32-bit SMBIOS entry point
which has slightly different size from 64-bit one and happens
to trigger a bit different memory layout.

Expected diff:

-    Name (MEMA, 0x07FFE000)
+    Name (MEMA, 0x07FFF000)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-21-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/SSDT.dimmpxm            | Bin 1815 -> 1815 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 81148a604f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/SSDT.dimmpxm",
diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.dimmpxm
index 70f133412f5e0aa128ab210245a8de7304eeb843..9ea4e0d0ceaa8a5cbd706afb6d49de853fafe654 100644
GIT binary patch
delta 23
ecmbQvH=U0wIM^jboSlJzam_|9E_UV*|JeaVTLvQl

delta 23
ecmbQvH=U0wIM^jboSlJzanD9BE_UVz|JeaVy9Ofw

-- 
MST


