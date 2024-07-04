Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063DAC31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPD8c-00020h-SK; Wed, 03 Jul 2024 23:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPD8b-00020M-CU; Wed, 03 Jul 2024 23:28:01 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPD8Z-0005IX-RK; Wed, 03 Jul 2024 23:28:01 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d566b147ffso143782b6e.2; 
 Wed, 03 Jul 2024 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720063678; x=1720668478; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2+C7IcpdJ79NejgUr+JInPmtNhkeAMJDu7Mdn8JKaM=;
 b=B1RUncWbjwz62Fc4hWrNDeFdA3jq5HhEV9gg/21mV2RQrczmAvQ6N/EEojggrMyu4A
 ka/4FspxIdhPr9TxfNdLcs/YzblaY92CxSGiOAtcul6rmJWaVHhU6jjZnyEA52NHLjun
 rqWBekm8M++OwOQVI8CqIAmAdP0dbr6NeTTNEuBLIQnwKiIwAb11gLAxDvvksk345j/J
 edeLEagaNASyIjLNFvCRHJ652gYjDgH7urKJtKpcNMTXjKWYZJnzrYmlILjECBif7U2z
 VlTkfDKJXYcM2rz/m1UUZYMrQFvCbVwX9+ZBNKs7ODOkEiK0J7O+SCY1bZV8x6v9i6j5
 8nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720063678; x=1720668478;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I2+C7IcpdJ79NejgUr+JInPmtNhkeAMJDu7Mdn8JKaM=;
 b=SqdS2X7d/RlQWZ/HsoDGXyGspPlwFJzCJoBiZhDthZIKN8sj/AlqHN9NpXw87Qjm3J
 5fdrcw9NKmSO2aOAUQLi1GQj1NFRwHkDZMoOafW6q8K5laJ4DricEIsPivqxI6RZ6wMj
 MyG7wm1J1KPySKdOAlsy4r15T4OPctAZbc/M8vmBaver437cmC5VDfka8oxtMWeProKN
 ynmxcMyEhd+tS6azqcabHMMlWkrEQ2jNNl24zilCy/SmKBwm5zgpSzQxJnWWwEokl4qp
 RJlhDWojhOcxkSzGK//K/6IFg0Tw14p2IuQ6SDc6527FAWl9AtTCMLqov81shnulF3xr
 8mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/QfoQsFe+Jt85/nuv9y1G3u2YQ6SGmWxr3aopoyDuDcoi5Jn4m5AOCw5OWb50YrWDUH8Q6L4p0NPR1/HUY5q3vDBTWprlDjnEainSOH129r6YKyDIqBRkCMA=
X-Gm-Message-State: AOJu0Yyn/DT7GFF0NMQJuQDcBxLuu6VKmeBwilde3UMl45MkBxWvoErO
 6UelCh8dcs+slUUYwkwCnpmWBwjqiyZeoshMvhFtdmyoGRk5aQvj
X-Google-Smtp-Source: AGHT+IEGlyu+NRmWlDH2wxZTHGG5TKQgpUk22AjSOy/xooV0LTDVe9GwBnQgvrQGuX2NtCNJ9vrOQQ==
X-Received: by 2002:a05:6808:284:b0:3d6:59a0:fccc with SMTP id
 5614622812f47-3d914c5e895mr545338b6e.24.1720063678156; 
 Wed, 03 Jul 2024 20:27:58 -0700 (PDT)
Received: from localhost ([1.146.95.80]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246c662sm11204052b3a.61.2024.07.03.20.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 20:27:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 13:27:39 +1000
Message-Id: <D2GFOGQC3HYO.2LKOV306JIU98@gmail.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 25/29] target/arm/kvm: Write CPU state back to
 KVM on reset
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <mst@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-26-salil.mehta@huawei.com>
In-Reply-To: <20240613233639.202896-26-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri Jun 14, 2024 at 9:36 AM AEST, Salil Mehta wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> When a KVM vCPU is reset following a PSCI CPU_ON call, its power state
> is not synchronized with KVM at the moment. Because the vCPU is not
> marked dirty, we miss the call to kvm_arch_put_registers() that writes
> to KVM's MP_STATE. Force mp_state synchronization.

Hmm. Is this a bug fix for upstream? arm does respond to CPU_ON calls
by the look, but maybe it's not doing KVM parking until your series?
Maybe just a slight change to say "When KVM parking is implemented for
ARM..." if so.

>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  target/arm/kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 1121771c4a..7acd83ce64 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -980,6 +980,7 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu)
>  void kvm_arm_reset_vcpu(ARMCPU *cpu)
>  {
>      int ret;
> +    CPUState *cs =3D CPU(cpu);
> =20
>      /* Re-init VCPU so that all registers are set to
>       * their respective reset values.
> @@ -1001,6 +1002,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
>       * for the same reason we do so in kvm_arch_get_registers().
>       */
>      write_list_to_cpustate(cpu);
> +
> +    /*
> +     * Ensure we call kvm_arch_put_registers(). The vCPU isn't marked di=
rty if
> +     * it was parked in KVM and is now booting from a PSCI CPU_ON call.
> +     */
> +    cs->vcpu_dirty =3D true;
>  }
> =20
>  void kvm_arm_create_host_vcpu(ARMCPU *cpu)

Also above my pay grade, but arm_set_cpu_on_async_work() which seems
to be what calls the CPU reset you refer to does a bunch of CPU register
and state setting including the power state setting that you mention.
Would the vcpu_dirty be better to go there?

Thanks,
Nick

