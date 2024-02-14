Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387FC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFc-00060q-MX; Wed, 14 Feb 2024 06:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF2-00058n-Db
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF0-0007Iz-Ae
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fN72J8WFo/Zhfl2CffZ0fQwcDGfJHksFH3RcOtTuZe8=;
 b=UqN0QEHUOTDIVq3+XsGQ/5P2qXNzRquUPdqcKBvB7QKUyGWGCBa52NGWM6nRsilpTjuGdB
 FNS45o6NU9168d28aogvkfDf8eJWoTkIhcxAFmWlBpGM32uFYpH6Rr1tSG2lHd17nhTbZX
 BPljTqKa8dEEWlZuMavOpdiTwgmxUYc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-D0D05RZFPVWLauXp_ikMYg-1; Wed, 14 Feb 2024 06:15:48 -0500
X-MC-Unique: D0D05RZFPVWLauXp_ikMYg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5621c809a3bso452539a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909347; x=1708514147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN72J8WFo/Zhfl2CffZ0fQwcDGfJHksFH3RcOtTuZe8=;
 b=uQKTRiuu7tcsVhnOvwYux30w+78Q6+LkawNpaZkQQxIHrBGBItKyXnfUpS8C1xnFyf
 bJEe3rLyxZLxnphvdSd+5iLCcLALOYx2eBHA6eNby8RtxJL9iHcfbNXV+RDtY4hPaDGN
 LI/y7/2tvD3jgcjh6byQX//ug743UHm2Qc41tpSJ2fP+U52vmilORA1rW1uW+nVoQpwj
 wuSrhR+9zOH6GBjMb2mshwFZTIItHLwfU7sxOWEUxABA6V0ieG/ZpeNB7XsaoDYs1cYC
 /ajrfBs/SuxfyFBxPa0MZHhJrrxEhqkvEUQCljvYxrCqpuF4zmngn2f05WZCKnelJyzA
 GjNQ==
X-Gm-Message-State: AOJu0YyB5M4l2XeZhVyVx17rFVRTdMdZNG3t8jR9YFiMoZawjoVW6kjF
 0PzF9NAKbQS5a5r0ml9cowhT+hnQfAKixgt2Rp6kdXp7hDj2HSg8u80s3wGQT5FlBusem23qxuo
 cGuCIuvJiEIWH4xYqraEZFmNfj+NIDEEUy3LzWRw/sdypEHAFUtgTe+IhIV1EDy0b3J4Lxu520p
 3lj5rGjIJwOTHPwUOx9IweIGiriq+1Sw==
X-Received: by 2002:a05:6402:6d7:b0:563:906f:4171 with SMTP id
 n23-20020a05640206d700b00563906f4171mr48809edy.18.1707909346985; 
 Wed, 14 Feb 2024 03:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2inKnnQZXSTc38j06fXNv/Qm5ehexs4T0dLjIipcBJlyOy4+oa0xYf608qMCASnFXkw+DQA==
X-Received: by 2002:a05:6402:6d7:b0:563:906f:4171 with SMTP id
 n23-20020a05640206d700b00563906f4171mr48788edy.18.1707909346640; 
 Wed, 14 Feb 2024 03:15:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLqZBjidmXq5/6GbRdJN3FwsNBUZBvo+5WavW6BjtG2mn8jO5BpcZ+0HeMxLZAVJ0myX8bCA+D1mg1ni4a7cZC79wTOi4EKeK0Oc+umUmEfAhshXZsg29kES4qOWsUKVynnCc34josebIC5Z6G1iJmHCfnL/mYQ7IKL0VPwa/n0op1LR4zK9LVitudZcqZFqWFcC2PhJs7gcgUygil1Yj9DdqfZnaG33BcrZ1GZ3xlzRpYNNDDnIvgq+HpmbBzDW+u0pdAQ+VqCXky2XthKvWrCeCFjpOUDC6z
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 p5-20020a056402074500b005638caeff4bsm121063edy.22.2024.02.14.03.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:46 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 47/60] hw/i386: Fix _STA return value for ACPI0017
Message-ID: <d9ae5802f656f6fb53b788747ba557a826b6e740.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found whilst testing a series for the linux kernel that actually
bothers to check if enabled is set. 0xB is the option used
for vast majority of DSDT entries in QEMU.
It is a little odd for a device that doesn't really exist and
is simply a hook to tell the OS there is a CEDT table but 0xB
seems a reasonable choice and avoids need to special case
this device in the OS.

Means:
* Device present.
* Device enabled and decoding it's resources.
* Not shown in UI
* Functioning properly
* No battery (on this device!)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-12-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d5c6c94474..d3ce96dd9f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1415,7 +1415,7 @@ static void build_acpi0017(Aml *table)
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
 
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(0x01)));
+    aml_append(method, aml_return(aml_int(0x0B)));
     aml_append(dev, method);
     build_cxl_dsm_method(dev);
 
-- 
MST


