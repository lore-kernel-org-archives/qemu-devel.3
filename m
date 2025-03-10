Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FEDC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYBe-0002fA-Pn; Mon, 10 Mar 2025 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYBb-0002d2-BB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYBY-0001V1-8Y
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741594106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SVqfFpfoDG60gjNZIvZf6TG6Jva8VJJjYnJ5TQlFzU=;
 b=aEMxS7qb0eseW7JRd+bnwtaaC2gxKGjFTc4zgghKAJuSc3/yxk4FPI4s2bV6T5mvPZlMsM
 uwvx6k7c4uMSI7nxsTqPBcf3/So6J7DcD3Mx68pywJ40ss0FmyqZsM462udPt9uqqlfw80
 gBHvrvQs/0DJZd9SfFiA5j+ioBjjFik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-QgPD9UPzN_Ge-pi4rtmNxw-1; Mon, 10 Mar 2025 04:08:23 -0400
X-MC-Unique: QgPD9UPzN_Ge-pi4rtmNxw-1
X-Mimecast-MFC-AGG-ID: QgPD9UPzN_Ge-pi4rtmNxw_1741594102
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so6991665e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594102; x=1742198902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SVqfFpfoDG60gjNZIvZf6TG6Jva8VJJjYnJ5TQlFzU=;
 b=sBMvtBE9mIfsCVyupQBKCubOJtmkteBzq9VFELsX3EZMDsbwWMYDwPOJvIkpSi6cxQ
 2B7N8jJbcCFghQwLdYmK9qsDBkHPdMRjr5NkhQMCFzxrAoemA+DldeBh5lZaKxd2CObn
 hpSY/kjq15fw9XcGzUAqTuPwCloy53V55DM9bNDiwIJupUWt4vMxGd8M1zbZFt5blpfe
 ic/+C2krzG2XHrJ+Z7s22tjNCjtJKQa1I9A/Xyy6HndQDKHMlf6Ad5pTGzLIn5wyn0hu
 KdLWLKygV6pr8sOrDOc9TZPgZtp1pr3R1LP7205g7iGEc7aVDvliYH3VDuaAk1PU22bL
 Dffg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMZlBlPE3UUz2w1EAKOdZE7RNcs8Yxo8WFErrEJpGRvyucDplDmKwJ1gmWsm3XP0mYZjphhB9m9kuF@nongnu.org
X-Gm-Message-State: AOJu0YyXmimUugy0d/ZZ8qwqCFYxjXf0o+ZJDovY4l+AokG7Dvor3OWU
 aFCBLokxqK1ve/uvHKhH6DOmUXUNSq8QiDwh+mf90+rxyfWg/hDSe1xeb6BbSEW6Jj3d08SK4XK
 KmC4lgjojmychEH0+A0tPuSoGEU7NCdsRTAa5jY8U063UVURZSN38
X-Gm-Gg: ASbGncuoFkhreD+P4UNPBdi/DxY+vhDBrZLbxHTt73aGAJug1RJKX5mDURRdXeqblPI
 j5vf3rtEHkup5teebkKNVznwWpz9Y0C6ayPTHHqYZFk/jZwHL0x8xFW9N8//xWMdDKnEm3ASf1B
 R1HyiwoHwYYv4Dttf7QbwazUTiW5OYEH3QF6v1kF6IEn1WuiSHwMyzLIXADc9+KSp2gOkT99cuS
 OCS5fuvmi8coR+PEMSMDNR9QhXtAKq4Ageyr0Kvu9ukMnobAlAyCWgUrEzSVhRg/EO6alU+Tzbf
 Hdu0D3BF08npH72NODcNtQTGh8Jy6SSgmrRucGmAtyUaHpQl/krnH3YObplhLr4=
X-Received: by 2002:a05:600c:1e8c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43cfc0c92bcmr7549395e9.2.1741594101968; 
 Mon, 10 Mar 2025 01:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAvJo0H2j6esnE0YJy2idFdRJrPW3F+ziL9sDrU5Yt1vwPcmThEaW3VKBboPQlYFKcfohn+A==
X-Received: by 2002:a05:600c:1e8c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43cfc0c92bcmr7548915e9.2.1741594101489; 
 Mon, 10 Mar 2025 01:08:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfcbdd0a7sm9338655e9.11.2025.03.10.01.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:08:20 -0700 (PDT)
Message-ID: <ff98f698-3f5a-4b08-9e77-3814a74165e4@redhat.com>
Date: Mon, 10 Mar 2025 09:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] hw/vfio/spapr: Do not include <linux/kvm.h>
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-3-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:08 AM, Philippe Mathieu-Daudé wrote:
> <linux/kvm.h> is already include by "system/kvm.h" in the next line.
included

>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/spapr.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index ad4c499eafe..9b5ad05bb1c 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -11,9 +11,6 @@
>  #include "qemu/osdep.h"
>  #include <sys/ioctl.h>
>  #include <linux/vfio.h>
> -#ifdef CONFIG_KVM
> -#include <linux/kvm.h>
> -#endif
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>  #include "system/kvm.h"
>  #include "exec/address-spaces.h"
>  


