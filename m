Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8DFC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6XQ-0002hk-2V; Sat, 06 Jul 2024 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6XO-0002hG-68
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6XL-0008BI-G4
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720276634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYIR22Y6ur7dGuiM4dyqKXye/Kx4OeEC8Q7B/SkT5So=;
 b=CGaABmyRyLxt574Aki6Itkn7lIBV760LwRmQlwZl4lcGGUnXMGRhJd3Yv8OIN/mkfCZpSZ
 BpXlZzPYj0H7YnKk43WalGWIHg5AIaEZmPsshXaUbyA4t3eU7K3Wgt/F3EbEkQ4M2lQQrh
 6DyfvxxKwL5DzSEW5FljAQpgY/iW4S8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-InM-HQzlNGCuvVR4CrkJfg-1; Sat, 06 Jul 2024 10:37:09 -0400
X-MC-Unique: InM-HQzlNGCuvVR4CrkJfg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e969d34bbso2886616e87.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720276628; x=1720881428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYIR22Y6ur7dGuiM4dyqKXye/Kx4OeEC8Q7B/SkT5So=;
 b=S7Jsxd/UUXi7CosqworIFeTSK/Gm/1VP7HEnuZDNAEo+W1eggdqUopmvldSx2iCtev
 dk7dZgwBIjhRzQJoGdzfbVh6qs15XMFsDD11T0QrTrlkfQi0A/k1PiiGh3Tm3df44vmr
 pFloP3Jojxj9u5s8CCCU9h0QLkIq88ic+dxpxY3/wBd+44vQf3NLyUKvFAvBAkawHzRg
 A0c739w6IUT3lCg4PKHK0cERY2dISFqKnwaIFT70BTtLpvc8sKIi6SdyYt22Ja0UOCiN
 zOCjjaUEsC+t6uIp3WPtHp0nQYm05wZhTB6pI2qvv9ambiDUTIiEnTjN+mXkKwR1wjDd
 T5iQ==
X-Gm-Message-State: AOJu0Yw9wrNVqj8wbxYWiUhUux0CXGxQWJ2TmLqPfMDQPo0m8pqbrh4p
 TCgK0HEuNfmOsWnrxE+MhE3zTSiRcvglUAlWo6lisT/PcK8NrpBzGFQfnK1nFCgG5GSLC6n0pV1
 JDFFeDEsVu3rd7c/AVz0LIEgnNAdweDtYLMK+RHHNAE2KB041KvmT
X-Received: by 2002:ac2:5dca:0:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ea06e62e3mr4360114e87.64.1720276627977; 
 Sat, 06 Jul 2024 07:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRERe2elgyQoXhs551d6jNqUU2+x/Ozc6nWcvxpIBeERzXMex7iIw6gvNLV28aDavgFZNCrg==
X-Received: by 2002:ac2:5dca:0:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ea06e62e3mr4360084e87.64.1720276627476; 
 Sat, 06 Jul 2024 07:37:07 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cbc6sm99529345e9.24.2024.07.06.07.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:37:07 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:37:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Message-ID: <20240706163704.524ba618@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-7-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-7-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 7 Jun 2024 12:56:47 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>


Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/exec/cpu-common.h |  8 ++++++++
>  include/hw/core/cpu.h     |  1 +
>  system/physmem.c          | 29 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 815342d043..240ee04369 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -129,6 +129,14 @@ size_t qemu_ram_pagesize_largest(void);
>   */
>  void cpu_address_space_init(CPUState *cpu, int asidx,
>                              const char *prefix, MemoryRegion *mr);
> +/**
> + * cpu_address_space_destroy:
> + * @cpu: CPU for which address space needs to be destroyed
> + * @asidx: integer index of this address space
> + *
> + * Note that with KVM only one address space is supported.
> + */
> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>  
>  void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                              hwaddr len, bool is_write);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index bb398e8237..60b160d0b4 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -486,6 +486,7 @@ struct CPUState {
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>  
>      struct CPUAddressSpace *cpu_ases;
> +    int cpu_ases_count;
>      int num_ases;
>      AddressSpace *as;
>      MemoryRegion *memory;
> diff --git a/system/physmem.c b/system/physmem.c
> index 342b7a8fd4..146f17826a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -763,6 +763,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>  
>      if (!cpu->cpu_ases) {
>          cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_count = cpu->num_ases;
>      }
>  
>      newas = &cpu->cpu_ases[asidx];
> @@ -776,6 +777,34 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      }
>  }
>  
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(cpu->cpu_ases);
> +    assert(asidx >= 0 && asidx < cpu->num_ases);
> +    /* KVM cannot currently support multiple address spaces. */
> +    assert(asidx == 0 || !kvm_enabled());
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
> +
> +    if (asidx == 0) {
> +        /* reset the convenience alias for address space 0 */
> +        cpu->as = NULL;
> +    }
> +
> +    if (--cpu->cpu_ases_count == 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +}
> +
>  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>  {
>      /* Return the AddressSpace corresponding to the specified index */


