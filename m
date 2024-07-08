Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D29C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiI9-00086F-7I; Mon, 08 Jul 2024 02:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiI7-00083V-CN
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:03 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiI4-0001nY-Eo
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:02 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bfdae7997aso1927319a91.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421757; x=1721026557;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UaPFfT+leH++H8fthM/ZJoF5CcBN0CIUxVYvtNppWVI=;
 b=WhDZgAtLwWpxEHvOGGTGFrjYr+Bgfpn//cXtdQ4SA9e96qoFSUs02GvvRJtW75p1LV
 0SwDbPGDrbhyXCGBApQVF1yLpOUaJeU035K7H1HJBT3Dv+2/Wt4LmRDE+JGXL5KJJt1B
 5fMd9dMXJ0ToEMAVHYLbPEHnUSkgsUj4IyAi3MDOylTlIKM+66+2+Lcrc4yPLVZQayDF
 3A+r2ghJOjwLKdLIXlgfcd2Qdkwb8ZIHdahYpnSI/AAscWSnx+OHKPmt5LLgD++E5uDs
 eALMxs2nhCURTMvSHfwqRlnD6qPyD0cPJTRqWGhdvW0iEAIUNZoaVTfPh0GUkj/06zZ9
 BArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421757; x=1721026557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaPFfT+leH++H8fthM/ZJoF5CcBN0CIUxVYvtNppWVI=;
 b=YIcGj3ZKGDTYOl5CT3T+Y+8V8tJW/LlessvBgFiTjbRuZs4qLIVHeTs/fcqpcbv3he
 0vmhFUy6UcpYDG+AA/Y+WIaENU7aKGqaeivDxiCy4YBtEnrSHD3lTLavY8bHNRC4Vj02
 sSKufYN9Hr4UD+sWLYaARWvEuSjWTm46UDSPtfLrifANkc+fuUAWvzHVdXUDQyOhxkka
 3tYZYBABEnvFluKKkSy4tDwiyufPs/ra26o3rl7flptdOqo5p5CSkKeYVOl53ULOqiQl
 Gv27OK6LWYQtyTJtODVCRZa2H5a+6BFyNQvMzxpr0RxaKb2/28xxbwYNqn5hdQSgTN6V
 27VQ==
X-Gm-Message-State: AOJu0YyKaJrGxa6ykS8gvonwwRncTMDhySHM6xWezEFkAoQ0AqUbK0Dz
 4bsVHiTGzlKRKarD0FXs5ZMPZEJwUyPWgEH1QYtc1q6Rupq0D0LZf7/pRSoqFok=
X-Google-Smtp-Source: AGHT+IFYGr3yln/+vkC8c4wuU02zkUuJv0AQykl/zlen2nQtgSYYTijPjewoiwEJtSC9clBwrdPHDA==
X-Received: by 2002:a17:90a:c582:b0:2c8:452d:e634 with SMTP id
 98e67ed59e1d1-2c99c890807mr5397148a91.45.1720421757292; 
 Sun, 07 Jul 2024 23:55:57 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c99a95b572sm7393441a91.18.2024.07.07.23.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:55:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:12 +0900
Subject: [PATCH v3 1/9] spapr: Free stdout path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-san-v3-1-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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


