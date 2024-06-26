Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF69C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQUs-0005r0-6i; Wed, 26 Jun 2024 07:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUa-0005gM-Ka
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:12 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUT-0004iN-E2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso4711376a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400023; x=1720004823;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hHflsNUlf0krU4+kDJRTbEl0rU+aWlAR1DnSBXEnGRI=;
 b=NdMvlcJVHT9c5bfKIGnRRZ/o7s+orbVtxInFdJmZfajwgiw8VKY6eamj6EbmjaWc9S
 Kypw4dmL0K24sW8m4zY7ydRTQ27Idpxc916/c5JuHv0JDgqeXlqZDgtYT0/F9SeBRhEy
 FzafFa1cN4Y4iU3kFz2PlN/PMR8Z/57dkBCbfAFEM/knKr7yklC267j/4AK7krmdN2hD
 b3X7dPIJygXDFB0dHyz9WAkWGT6y9pNmeOskQl2VVJBIsAuPfMjiWClZip4O/eBZvU1a
 BTlF8D3/f4f7Pxf/Hzeph6PlozPTx1sfuphnxOeXSf0vVQ9F3FGeCL99xzXPtmiGHU48
 fNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400023; x=1720004823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHflsNUlf0krU4+kDJRTbEl0rU+aWlAR1DnSBXEnGRI=;
 b=s/W6z3TXXBXuuO60+3Z7UKrQpuOCMkdFBrhDkZgOdt8U29ysVj5beMVZY8rn2i0TzO
 oB2drqYK36Z87Z1BY+Je8ECDb69rQzuJNLRDcVjjd2OPU+1QIxYq/52M0dQJ+R6PscCI
 +4CdWV3uT1dv3SBInbX5ArD2JphUiJ+M02r74TB908DQj9sqidOWhcVD5nk62XbSOXLl
 xIWA5qX4XR4FGvY2t9oOkK9hW01SaQYZoSuQchY3iYWE+eR4pIsu0Gd06oSDJI7QB7w1
 +UtUwfoek+4Ad6kDVDDDkqFYxgugYKD+lQxJh9rFNZpXXnGNKhiFXYxhzWjStuyKnvII
 bXeA==
X-Gm-Message-State: AOJu0YxP2JiYP1NiCqFIkOjuFZV5mYMafKggve2Pa6QV+or+u4sNz89x
 9uhzoloLMNtDECOn37MQa9aHraUS3SwenEgEHJs/FRSzTJBeZ5igw7P+hBVq5vE=
X-Google-Smtp-Source: AGHT+IEVt4in5VKGiMWbgfza8PvhkVGfPJcperKBRoRNL31xxHf2zwlIVtjISGk/ZZcjgSQh3kkVXw==
X-Received: by 2002:a17:90a:f190:b0:2c8:a8e:c1cd with SMTP id
 98e67ed59e1d1-2c86124b458mr9135582a91.11.1719400023087; 
 Wed, 26 Jun 2024 04:07:03 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d81d2f15sm1371829a91.55.2024.06.26.04.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:27 +0900
Subject: [PATCH 04/14] spapr: Free stdout path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-4-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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


