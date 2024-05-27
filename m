Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A2C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbsw-0002zx-51; Mon, 27 May 2024 11:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sBbsr-0002zZ-Ia
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sBbsi-000627-Az
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716822202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pN3HWtGIqnP0GqXCQ1sWAa/h2E4+woq+9QR/YhRIgak=;
 b=DGARDk8W13mIcZvdDUwSJQDIGk3YhrUkm1C5sTYnlvsQ+Qa2hxnqey+tTp9sVxvEjL4UpZ
 9B5AKQ+ExGXPJLgjsIkx0xwm6lZyqi/0rvwcUDWrBHphlb5Px05UzTWZabmsfKMyNHozQg
 MDdVfnn2PxLox6Es/1uW1angHGeZqqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-pJiOqME0Pkax2Mu7oXU4Cw-1; Mon, 27 May 2024 11:03:21 -0400
X-MC-Unique: pJiOqME0Pkax2Mu7oXU4Cw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42108840a38so11120375e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716822200; x=1717427000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN3HWtGIqnP0GqXCQ1sWAa/h2E4+woq+9QR/YhRIgak=;
 b=hNLygwOyFfUQHqIECMACJMorwi0yESu8OD76PSZuwxol1uW5pO1Vf8YWLzLoRLprMQ
 CMqTuLp60fO3/Z4ofOzplyHIwawJX2kLqTm9rg4a+AcU3LjM+rluNcv9ZZFzA+rR1a29
 ixiKv6A2dnt86ESCwUi0q5M1IeQkgUpmakfOf5GsbnODfFIALCUwEp2SDPYfRpgqIU/w
 s5usm2CgxC74JoRabxHHpo/ZKJDSntIUNP/7jfQd4roPQtaoXiirR/ONmAZC5dXx93T+
 AtJVK183yhzEBaSBCzwLMeDyQtcJXF/0D/0GcjbsZAVdjsHZDpN9OkAV+MLMnDZMTp6q
 60Jw==
X-Gm-Message-State: AOJu0YzCG4663YxCdZm9idbIeenEp8QW3OjDWfD1AaaT5ZMJg+vmZcHg
 cwnQTAAD29tHRRlzhFrVwzVz3jkWFRN1l3V0eSI9JG8bTHI0H6omQOx3nYTurtMuee7UfKDNGde
 ERpYTyahWabOnI/A6FuXKPUcAK/RMOaJb8pMEH1alCjf4u5uaW3qI
X-Received: by 2002:a05:600c:1f84:b0:418:969a:b316 with SMTP id
 5b1f17b1804b1-421089ec3admr83537705e9.1.1716822199812; 
 Mon, 27 May 2024 08:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMu8Z3v2H80Ad6Lx4lA99ImP/NH0q/HiySjpY8kj/ryL+m996wr68Vj76Yk+9JMC+hIvDTgw==
X-Received: by 2002:a05:600c:1f84:b0:418:969a:b316 with SMTP id
 5b1f17b1804b1-421089ec3admr83537445e9.1.1716822199437; 
 Mon, 27 May 2024 08:03:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420fc82cc41sm123575545e9.0.2024.05.27.08.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:03:18 -0700 (PDT)
Date: Mon, 27 May 2024 17:03:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>, Zhao Liu <zhao1.liu@intel.com>, Babu Moger
 <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi
 <dapeng1.mi@intel.com>, Yongwei Ma <yongwei.ma@intel.com>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH] x86: cpu: fixup number of addressable IDs for processor
 cores in the physical package
Message-ID: <20240527170317.14520a2f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
References: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 27 May 2024 11:13:33 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> When QEMU is started with:
> -cpu host,host-cache-info=on,l3-cache=off \
> -smp 2,sockets=1,dies=1,cores=1,threads=2
> Guest can't acquire maximum number of addressable IDs for processor cores in
> the physical package from CPUID[04H].

please add commit message, what you are actually seeing
and expected values as well.
And if guest complains about it also include related dmesg output.


> This bug was introduced in commit d7caf13b5fcf742e5680c1d3448ba070fc811644.
> Fix it by changing the judgement condition to a >= 1.
> 
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cd16cb893d..0369c01153 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6097,7 +6097,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;

in light of dies and recent modules shouldn't we also account for them here?


> -                if (cs->nr_cores > 1) {
> +                if (cs->nr_cores >= 1) {
>                      *eax &= ~0xFC000000;
>                      *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>                  }
above and also following condition

                if (host_vcpus_per_cache > vcpus_per_socket) {
                    ...
                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;

Makes me think, do we really have to have both conditionals,
Why not just drop conditions and always encode both values
to ones configured on '-smp' CLI?



