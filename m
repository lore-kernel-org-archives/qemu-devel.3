Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A2BCCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtOe-00075g-Ob; Wed, 18 Sep 2024 08:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqtOa-000743-1B
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqtOW-0005LF-UQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726660971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV6S1VCh0doUTbulSVSZZPti8+Bq2ZmWHttohLjGyFI=;
 b=QCwNUIKgnfbdEnW6llr1q7fMnAhGGckTvOl6/o3BHVV3TXpBsmsSkNc0LDd2y5BGBLjowm
 IM1Ed859m3AvA0/abhOKp8kuYRx3Mi+3P5conuEs6kkBR3v9D3vBobVcxSrssEZwscvNA1
 3UR3cgD153OtR/Sqdy5Smxd0VHJD/l4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Z_JCQa-FMGiJPC2Y4gONRQ-1; Wed, 18 Sep 2024 08:02:47 -0400
X-MC-Unique: Z_JCQa-FMGiJPC2Y4gONRQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso53359905e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726660966; x=1727265766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV6S1VCh0doUTbulSVSZZPti8+Bq2ZmWHttohLjGyFI=;
 b=pmEV0EKAfUYGau1N2MRzKsjwaXcI4iz22PHaw1dbRVR2AdOZV9elB50dA3zO7m1R7Q
 Q/x/diXcvjIKgmt/XiZWcNtEcAEjaChwafsJFfCaRajLmbW9xBh33KEdmJ/vfCsOvDgT
 C5qFMMokP04HUSecKcDg4nT7f9J4jM90a75mgAmSVY3XmVwFFqDkmGPmvmgRYs8mN7WC
 lChWYNDohXhcWh04LtuccA7mcPNwyX79jjFjqzr0hjMg94vhkMiNU72xbAdSoHHGpS6W
 ekWORusR4WHk2AyUnlmeCETdMPJDPPHO3LY1Y1F9lRT2jI66MVa73TMQHbCYZIMzHaLc
 MBGw==
X-Gm-Message-State: AOJu0YxuEAbKd0SAqb/Tf/R9a8DUjtjmVORFyRAvNJ+ChAy9jPCorhsz
 d8H+AsEnZqhHkDIQHg+nU14ok3zRLC8jPxd7tfaf9Nnp5i6fTv23SlXE3mbnkPFc/Amnl1OpRA7
 WcOtc2BlVPy/JzLaCbSechZxPCv5sGmYM4QtCCemQo/JlJlOx9uuK
X-Received: by 2002:a05:600c:5489:b0:42c:bb41:a05a with SMTP id
 5b1f17b1804b1-42cdb5789fcmr165196135e9.34.1726660966204; 
 Wed, 18 Sep 2024 05:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF69ptHbfjD5y+SPxYwHjw0onU6SroY7HgVGX2j2eYmWPxxBKRH6WUHADWcfpo0Zo+sMKIFrQ==
X-Received: by 2002:a05:600c:5489:b0:42c:bb41:a05a with SMTP id
 5b1f17b1804b1-42cdb5789fcmr165195835e9.34.1726660965708; 
 Wed, 18 Sep 2024 05:02:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e85ccsm12110732f8f.42.2024.09.18.05.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:02:44 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:02:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>
Subject: Re: [PATCH v2] i386/cpu: fixup number of addressable IDs for
 logical processors in the physical package
Message-ID: <20240918140242.2c360209@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240914110127.67690-1-xuchuangxclwt@bytedance.com>
References: <20240914110127.67690-1-xuchuangxclwt@bytedance.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 19:01:27 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> Execute "cpuid -1 -l 1 -r" in guest, we'll get:
> eax=0x000806f8 ebx=0x465a0800 ecx=0xfffaba1f edx=0x3fa9fbff
> CPUID.01H.EBX[23:16] is 90, while the expected value is 128.
> 
> Execute "cpuid -1 -l 4 -r" in guest, we'll get:
> eax=0xfc004121 ebx=0x02c0003f ecx=0x0000003f edx=0x00000000
> CPUID.04H.EAX[31:26] is 63, which is as expected.
> 
> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though theads-per-core should actually be 2.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> to solve the unexpected result.
> 
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c2e6f3a71..24d60ead9e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
>      return num_ids - 1;
>  }
>  
> +static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
> +{
> +    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
> +    return num_threads;
> +}
> +
>  static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>  {
>      uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
> @@ -6417,7 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= max_thread_number_in_package(&topo_info) << 16;

why not use pow2ceil(threads_per_pkg) instead?

>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {


