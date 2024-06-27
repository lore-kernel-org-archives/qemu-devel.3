Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8209C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKS-00010a-3R; Thu, 27 Jun 2024 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKO-0000x4-6U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:20 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKI-0006Ko-Uo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:16 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-37613975e20so32090265ab.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495494; x=1720100294;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iP3blhpOG/UV/59pEfGGJ3KAPs2EsafUmQmrZ34OeNU=;
 b=ya1gGsoQ2CQVRQo+m5Qrb8oPuIrJ1iX5+rMCOhMPN02gxzF2MHP8z+5gnXjor9N3Gi
 kZRBcRkLN2HMZGkhfMJ4e5qY0cDZTOAjDKT5oECmIud2ZHjO6jIgZzhNaEK3Ju2+fKPI
 ZLZKZbo69iebt6pl6sa7KwMYS0UWJe22ZJ292mqkr2Z9uRrHrdUkPqnEJ1BON+Gz7rRl
 SVkT+odnLf1zk0EZD0MZEw8hWM9f57TVLj0mLSrPORxFmNCpxzRXpF0KTlOtxj1HrlzM
 TR544uyY7WXfbnocgO/Li7qe9s36C4AAkRk0BGHs8tiwQ3L8h4u+vxeAPnGRNK9BDPHl
 gIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495494; x=1720100294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iP3blhpOG/UV/59pEfGGJ3KAPs2EsafUmQmrZ34OeNU=;
 b=TPC7X6ILcb/HoAU9ts6W5Y5tepZjMutaMistAD6SAd19toUFkSvGCBbeMl3XJeJw9M
 Z8G9Vv2SEbFVty6utY+s66nYCz9YF8vrScFDcgALxHW5Pap2nFkAeR+b5CU6eNJalDKm
 PPhE6hY+jI2xWqjG8O/WQjzuiKSqYOE9xjhlhYe2hGtrfN7q5EeqrG0fGQiCEjdNV0yf
 IB6v/ceW9lRW+DWY7u08cMOfsOLhuJrXX0OIzHEKLL3Wx+n8BqXcZTBjXZo3wYhHOF2m
 vHRoBpfIsbZx0fj3Yb6RR9J9HNAAotTvtIK/V3OvAltklBs892rvBNSIScICcaWaFByu
 1moQ==
X-Gm-Message-State: AOJu0YwMmblqV3BZvmbMV7B2gw36H+/2nqQVCCG5f9aSSOySAuFwZc/0
 Svj7CEd7tuRKXYCCB2BlKCr/gbO4K+hy+qwMQdEiukD9kUF5KBfImgrQmkfliwk=
X-Google-Smtp-Source: AGHT+IHf3jIhWTbSTXHSifyb26fGEQBo1unk8u+4a2sfQG0Lwv5b0drDi6cRG7DTmmvL6lxvgvJh9g==
X-Received: by 2002:a05:6e02:1a44:b0:375:b381:9ad1 with SMTP id
 e9e14a558f8ab-3763f5aa404mr177979675ab.6.1719495493754; 
 Thu, 27 Jun 2024 06:38:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-72746793be8sm1089226a12.48.2024.06.27.06.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:44 +0900
Subject: [PATCH v2 01/15] cpu: Free cpu_ases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-1-750bb0946dbd@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12d.google.com
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
---
 hw/core/cpu-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index f131cde2c038..a3073c17d098 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -289,6 +289,7 @@ static void cpu_common_finalize(Object *obj)
     qemu_cond_destroy(cpu->halt_cond);
     g_free(cpu->halt_cond);
     g_free(cpu->thread);
+    g_free(cpu->cpu_ases);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)

-- 
2.45.2


