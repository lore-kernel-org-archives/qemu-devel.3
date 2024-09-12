Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66981EEB599
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 11:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soiFT-0002K3-2W; Thu, 12 Sep 2024 07:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soiFM-0002Il-Iy
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soiFK-0002Eq-UK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726141461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqLZ1Juiyj+QU3EtlY5czW+qt7h0wAF37oPNnkKTgKw=;
 b=XhiT6KGZY/uDQtAzXrWs8bV5sW2T0ex6zygwNNL0nHV49/1YSyVvZBbURan5G4+UcIHY/u
 WatF0VOij7gSKgNoypE1PAW0Gpr3ixNHP15iEcs3Xq1EGZp0qveA9t1sFuZhZ+Rs8D8S+g
 JHIw4M27sCVmlHR09NW3bL2lYQCccC8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-snl6k5HiPSyWTIIAkKPk0w-1; Thu, 12 Sep 2024 07:44:20 -0400
X-MC-Unique: snl6k5HiPSyWTIIAkKPk0w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3771b6da3ceso402788f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 04:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726141458; x=1726746258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqLZ1Juiyj+QU3EtlY5czW+qt7h0wAF37oPNnkKTgKw=;
 b=QHqhOhKkDQofCQsKeLEbnHZZfYL2xX+i+fI8FnGy6nAMC9VVbPWhHNI+yp67HVMKco
 Jx8oIBKoXJx8Luu80zcjBg8tcIS92maQK+F8DL2U2zJtN2vqrp4bayPzI5Qp1zUQEMvG
 xl46dD9WrVqpe20WLEiNcLhN3E9Kvo7HFw/4Ewt9ARf94ePps69sAFK9dl0p3iKrqZO9
 4ifRLBb18U0GjTIpwQtfMlB8Z9t8rv4GHb7L+LQpFsQbM141xmY7r4itJeaN8t3f+UmE
 JfffVe2uFbTYOZ2ifD18aW3eLfgQYC/zdmdMJUkCQUQ5HiQpZXhJxk/QdWWW+Vf7haUU
 LxHA==
X-Gm-Message-State: AOJu0YxRZ0vyWfRZizKgvGTo49OA4yiJxG4r3T2LmsNun4+GGMrCsLQo
 rCJhSmKYonY1qUkDinvO8swcNe0P6SWzJgpj2A7XTLuUpwRbkKbe4mkVDd76Z4Qx6uOCZu8mr7b
 a9juFmL0MxHyQcSx5SbvKlhPwSglzg170qHLd7hRi13AZHj4nspaWk/DpPbQd
X-Received: by 2002:adf:ea8c:0:b0:378:81aa:2662 with SMTP id
 ffacd0b85a97d-378c2cd3b8cmr1396454f8f.7.1726141458369; 
 Thu, 12 Sep 2024 04:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0JB7+jddi2CJ1lAfbR0wJbV2sn9nULtNd/UU3eQFLSVrABk38JWqbqWRSLDJAAeJI6Cd6NA==
X-Received: by 2002:adf:ea8c:0:b0:378:81aa:2662 with SMTP id
 ffacd0b85a97d-378c2cd3b8cmr1396415f8f.7.1726141457139; 
 Thu, 12 Sep 2024 04:44:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956653c6sm14166750f8f.32.2024.09.12.04.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 04:44:16 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:44:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>
Subject: Re: [PATCH] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <20240912134413.71ace565@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240911135257.16278-1-xuchuangxclwt@bytedance.com>
References: <20240911135257.16278-1-xuchuangxclwt@bytedance.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 11 Sep 2024 21:52:57 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, some guest os uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26])
> to calculate threads-per-core, if we have 90 ht (45 core) in the
> package, we'll get "90/(1+63)=1" as the result, even though
> theads-per-core should actually be 2.

complementing above with problematic QEMU CLI &&
actual + expected output from 'cpuid' utility on guest side
in commit message would be much better than just above description.

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
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {


