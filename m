Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678CC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKt-0001Al-OD; Thu, 27 Jun 2024 09:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKl-00018F-Tl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKk-0006PI-B8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-706b14044cbso868103b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495520; x=1720100320;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y3Al/DkWdr7oNtWQmlrRFITkQePTtq0AALK4OUYETUY=;
 b=lPeMh6BUSXMhZknRYOo9Rira3NbdGSHeTgUErQqeDFzcqRXpqnKWb+2P5HblpLvOjj
 jQkXxbfRLKIiRj6/jM+my5ZA3LZB7TOFK+LQEfliyYJlsl/85JoKcXIleTMi4sopiup0
 nOF+zPFRi8bvaH1DGXnde1IlEoC4nbUVOxR2yQEPZXdOQBs8AQEJ8T98MZe3rlYhVhl1
 eylp8LDedrw0h6YDsBMphfxWVJUo1jQbm2fHjnIee25A2eLc09eRGmim2OJwZAslyfv2
 99zKHsTyOBkDBOBCmBMKqr8U1NZpdhpbSaoSl842X+9mZp/RwvZyZfdWqCGdraRy5LvS
 oA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495520; x=1720100320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y3Al/DkWdr7oNtWQmlrRFITkQePTtq0AALK4OUYETUY=;
 b=u4WbwAIAStdoneyV58CMcwTDXqXo1E3iIGLcsVwaGsR68DyRjVx9bAeUXCjTymEO91
 gTfpgSo0PloHA+DFOQCxbZEsEXtZD1BJYRQyGodCuzvt+BpU0/PUnDdFF8qfOcW21sbL
 Vr+h4EZRbd/xFPQpam3EHJwpRWvZNjrRn09F3c6frfhOxgmQcPBQ7YyiEGdBqRdTtMQF
 IqlPxBc/PmfRUKTdJmQ6shO1SORp73fflA3Fwij4hrayKHzY7ztjAWWOXaYv377ZPnlS
 lEdUD4AO5r0uewC7vW+92qIfzGSjRcc7o9AcW1P+xWfedvVgpO/RmBTr12+IyveXp/sa
 lFKw==
X-Gm-Message-State: AOJu0Yw0wBGtGtQy5nq3ifG6K3pwHuhiITLaYmHT+0e04p90CuAuSrp0
 R4gYCZw8lZOfSt9sLQRJFP+bP6SMh2jsikMzInVUMWtkprjxAhyPYmGW9nT8+78=
X-Google-Smtp-Source: AGHT+IHixATdz48pQww+mu3HBcr4wVkdvUAZf3x1lVxRgTZ61Ksvi18JOkIMtiIBBjcldi4x5EJhUg==
X-Received: by 2002:a05:6a20:a8a1:b0:1bd:22cd:a639 with SMTP id
 adf61e73a8af0-1bd22cda715mr7144503637.8.1719495519790; 
 Thu, 27 Jun 2024 06:38:39 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8fe9f1c35sm1441098a91.33.2024.06.27.06.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:48 +0900
Subject: [PATCH v2 05/15] spapr: Free stdout path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-san-v2-5-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index 09f29be0b9de..c02eaacfed0b 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -28,7 +28,7 @@ target_ulong spapr_h_vof_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
 void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
 {
-    char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
+    g_autofree char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
 
     vof_build_dt(fdt, spapr->vof);
 

-- 
2.45.2


