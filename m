Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A54D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84II-0008J5-Ki; Mon, 04 Nov 2024 16:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IF-00081w-B2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84ID-0005Nv-Jv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vprvKklVU3XFH5cq7J6dxp5ZuQRvYtysugY4oc0x0dU=;
 b=WEZw2/moKyF6KLHK2Z0gesoaXmU8AAchaRm/jdToLlG/WcOjNFm2DxwEVLlLla3N/C1P9W
 qYy3zQ1PmOU94fodznNPZklseroINkKODoOOqKn6oD+PtlYWwm8R74RMjsj90Pzq1hxy8W
 qIFzSP+BcGrkoCmVJs8KdDV+SW5weI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-T20wPS8cM-uDMVXnysvk9w-1; Mon, 04 Nov 2024 16:07:19 -0500
X-MC-Unique: T20wPS8cM-uDMVXnysvk9w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4317391101aso30654405e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754438; x=1731359238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vprvKklVU3XFH5cq7J6dxp5ZuQRvYtysugY4oc0x0dU=;
 b=s+XwURI4Jew4edrUDob8ujTwKra7Ao1ywnYU267Zl6k8LuxevqEAAKKsdB7BfRTLfM
 Hs7G5HuYJQMT039XkRldI4umbEfpsb0aIu2XFX1QMXkEGTtbFsXAiAOzmRd2IX1lviCK
 Kl00KvWwp9o9ucEp6SxrYZLJgZQixGwIgZiN9ic2DB7FMV3AfkaJjvJx/t13dS5izM4q
 sBe6bVxhoqAVgBqva39+a2TGNVdK9s0WhUK1EAQueadT9WkbNOF8bmncPsm9A3tv49OB
 AaGwqcoRMvDiOyUR57eJOTTZqP9SwZQqDR39tVcnK4454lGpeAR7KLUoi8vZRhb2R9V5
 OXvQ==
X-Gm-Message-State: AOJu0YzK3E0ramuiwRJi2Fk74GGLMNGngv8zQaRLd3MGZGAOmHt+qQbH
 36Wn8OG5kaLBdbMWGBR+0S4bF9N8+AVueofHCWnKJt+9aERetERrMHFw044V6WuLArUMcyacAPt
 +IqspjrTOSWiFf8+ZmcAdEJR3nGO8FNTEVg/h6WFyf4FiJyhXSv08pb3v5NPjCvK/lDJ2w3ybc6
 RiSeFI7eoH3nCn+nZ4DQ+rJi+Oyulfbg==
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr109793445e9.23.1730754438222; 
 Mon, 04 Nov 2024 13:07:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFxAqhEribnYGDcnTMzrSVWxFFC4H2juyyO/DSj5olVabGJGa+Y+9TE73CsxJ5J3tyQe5Fjg==
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr109793105e9.23.1730754437712; 
 Mon, 04 Nov 2024 13:07:17 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm198914825e9.8.2024.11.04.13.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:17 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 26/65] hw/i386/acpi-build: return a non-var package from _PRT()
Message-ID: <7916bb54319a56be5c5eca0c890a4d2aa22b9bef.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Ricardo Ribalda <ribalda@chromium.org>

Windows XP seems to have issues when _PRT() returns a variable package.
We know in advance the size, so we can return a fixed package instead.
https://lore.kernel.org/qemu-devel/c82d9331-a8ce-4bb0-b51f-2ee789e27c86@ilande.co.uk/T/#m541190c942676bccf7a7f7fbcb450d94a4e2da53

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 99cb2c6c7b ("hw/i386/acpi-build: Return a pre-computed _PRT table")
Closes: https://lore.kernel.org/all/eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-Id: <20240924132417.739809-3-ribalda@chromium.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d01e704162..508a6094aa 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -740,7 +740,8 @@ static Aml *build_prt(bool is_pci0_prt)
     int pin;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    rt_pkg = aml_varpackage(nroutes);
+    assert(nroutes < 256);
+    rt_pkg = aml_package(nroutes);
 
     for (pin = 0; pin < nroutes; pin++) {
         Aml *pkg = aml_package(4);
-- 
MST


