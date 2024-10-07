Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDC4CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmvu-00070u-Di; Mon, 07 Oct 2024 08:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxmvs-00070K-LK
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxmvr-0002nT-1s
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728304424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOUkwYcDSZL2GTN9G2ZbC1Y5U0iFcj2tuJCNb0ue+Sc=;
 b=HICSL4cRyCXokN3EY47SmRBaDCFaBlrA/7PWIBpOVkT0q/MWlTHDMVTizrACwSDSurmq3b
 5Q6K9/mZ4ZQlPyCL0XvOpbwlupSpTXniephFKrfgtCSNsNwGAi1csE0cKl83vrO5y7cUoe
 APP/CH04v/d055VOqeZUZduqOFWnQLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-JzHb1oi4PlyShXdpDD-3gA-1; Mon, 07 Oct 2024 08:33:42 -0400
X-MC-Unique: JzHb1oi4PlyShXdpDD-3gA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cd4acb55aso3660170f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728304421; x=1728909221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOUkwYcDSZL2GTN9G2ZbC1Y5U0iFcj2tuJCNb0ue+Sc=;
 b=ubqI7XG9ogXPCGkpz9LMe4WEXjj2I/n8tTiTmcj4KA5Zsfl0GrMWuZkkWHOhpqqRRb
 r/q6yGrkBR5wlXHaYgoUUF482/kBi6f7PxcGSmji65SPJcTESH2nVzZmaXRuHQ444QJB
 qpepMsYqazeY+nunIhWADgEg7QND0I4H2xKlLN+P9WqsINKHao90cspTRRyqnpvnjq2m
 ZunS2mrjRiASlL6OPmkwjhD+h4dw86z3+SqH3Xx3E3XcfbOFB+WWGCTIg9LSjKVV0Af2
 w5TvJlXwF2V8eLARAvu99yL4ZAAle/lKajmdmRfZajZndy3wFzo0hp7LVSBn9Tx28S0r
 PoKw==
X-Gm-Message-State: AOJu0Yw8lQC1n0ZXnhFfZAMRz9b3spM5zjzqCZN1jTuyUuwugFF6DrIm
 IPLunEvWuBS/zcGsa4/Ri3nSIgyoXlcwcH5KHn2FnzPxMRYMp/KhJLWz8zjD9mRS+elXSgyFqXT
 wJczestzlvMMRlDebhwa4itXPcqzAxklZNXIQFw9lLH6NxNLXY7TJ
X-Received: by 2002:a5d:4e82:0:b0:37c:cd44:bf0a with SMTP id
 ffacd0b85a97d-37d0e8dad83mr10186259f8f.37.1728304421514; 
 Mon, 07 Oct 2024 05:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7J0tOzOv/z+kjNWvAJjKW5nUMHFwt+/ZF4uo/6CHS+g/QaAMgy3OYYMfFWvPFcB3rpOwuVA==
X-Received: by 2002:a5d:4e82:0:b0:37c:cd44:bf0a with SMTP id
 ffacd0b85a97d-37d0e8dad83mr10186233f8f.37.1728304421116; 
 Mon, 07 Oct 2024 05:33:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b505sm5640156f8f.43.2024.10.07.05.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 05:33:40 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:33:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>
Subject: Re: [PATCH v4] i386/cpu: fixup number of addressable IDs for
 logical processors in the physical package
Message-ID: <20241007143339.5e4c512e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
References: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Mon,  7 Oct 2024 16:13:44 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> CPUID.04H.EAX[31:26] as expected.
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
> In addition, we introduce max_thread_number_in_package() instead of
> using pow2ceil() to be compatible with smp and hybrid.

though I'm still worried that we can't use pow2ceil() to match spec closer.
Probably we are doing something wrong if bit shift works while pow2ceil()
as described in spec doesn't.


Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..1b4e3b6931 100644
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
> @@ -6462,7 +6468,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= max_thread_number_in_package(&topo_info) << 16;
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {


