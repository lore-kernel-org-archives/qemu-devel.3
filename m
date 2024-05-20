Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32BFC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8y1s-0003Sq-K0; Mon, 20 May 2024 04:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8y0O-00039G-P6; Mon, 20 May 2024 04:04:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8y0N-0004cL-2n; Mon, 20 May 2024 04:04:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1edc696df2bso76773035ad.0; 
 Mon, 20 May 2024 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716192261; x=1716797061; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HLSOlbk8MkRDlwV+ug+nW4TY34NAp2SioguHodiQJo=;
 b=PlRL27dYUlk2uKO1trw0DUBGEQ4gBwbVoumLHRIzdNJkUZnPB9eUOT+oHw6pYw8lRu
 PpUFn4EdJ0J+SaghN9l0AjfgoM2uLcuNfxkhjgWYQiF5WvckpHr9bOFDCBYbvWYbUwnp
 NHO4kgKmQ314E2uPY1TA0y8AAYsJTAzk253wTlnPJHg4GCWja9r/25YIsp/wHdoH7RUE
 R0BZ7CEiUcn23bLeTyeMo2jaAOMG0XiUeg451l7BJ0ol8f9nbJd0DLxjt4eURSEbBiEA
 0/Vjc9FYgTwWCmr1Z25aI47LgHDUcTpL9yHCUevr46wuBV9oHEwoJ2LlZgTaqvn+tfNL
 EupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716192261; x=1716797061;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2HLSOlbk8MkRDlwV+ug+nW4TY34NAp2SioguHodiQJo=;
 b=NYes2O3dsX9hVT+GfsXDRKN+xjifcsoGoQbJaIFtKvLfx47eBfK74yg7fCft7i2AFC
 w6qpi8n3xmlGEZIX0kw4Ueq80m1EyBnwLqPsfe2gps2yz7O3bYI3PqO2vjmhettuCLqt
 e5C9G3+c6yH0eFTMfrU3VsvBtDY0jVRJlGTMHrwwXF6rio4JsuAr5X2992TQF79QKsMX
 WRYqO91PLtYQrieYP/EoUWFzKqfifJxP04M5tC/13urGCgSVshyyTWO+XW9dsa4kG57d
 x9qxjgv0TKB3KMjO8hz4BcJUqlp1O68GNs/bTADZNyfIBpl5WWAwqWk97ZZ98RjkJR5x
 900Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfBxnFYVHg9uCL3ch6yqci8kTi7aUgBVySR4VZozOPuqzh+ccrhqSMAYA0yQThUHUZuY6rBbaRNRIyGZkmBaSQfaCiI+Km1aFaZ4vA7Q88GaW+Ef77ylAnZvo=
X-Gm-Message-State: AOJu0YxuykW5yuVirt7OClwiirxqFm7RHx99QjjXtPlOrdTT9uavh7Nz
 OZ0b4TZDac5/Uahneh44G1ISKdsLAyG4TqY34kGuJJN8lXJeolQT
X-Google-Smtp-Source: AGHT+IHCcnxMQZJJT6z9Ihx57EeT4LXDGcMlaXuZFNRkJMcpCkXKIAH6Wm1D74NRgWhfucnNiURczg==
X-Received: by 2002:a17:902:daca:b0:1f2:fb02:3dfd with SMTP id
 d9443c01a7336-1f2fb02401bmr37797175ad.11.1716192261169; 
 Mon, 20 May 2024 01:04:21 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad9da4sm197233065ad.107.2024.05.20.01.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 01:04:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 18:04:03 +1000
Message-Id: <D1EBDKJQ19G2.7K7FS8Z9BA5D@gmail.com>
Subject: Re: [PATCH V9 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Shaoqin Huang" <shahuang@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240519210620.228342-1-salil.mehta@huawei.com>
 <20240519210620.228342-2-salil.mehta@huawei.com>
In-Reply-To: <20240519210620.228342-2-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon May 20, 2024 at 7:06 AM AEST, Salil Mehta wrote:
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU=
 thread
> is spawned. This is common to all the architectures as of now.
>
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but t=
he
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doe=
sn't
> support vCPU removal. Therefore, its representative KVM vCPU object/conte=
xt in
> Qemu is parked.
>
> Refactor architecture common logic so that some APIs could be reused by v=
CPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/ol=
d APIs
> with trace events instead of DPRINTF. No functional change is intended he=
re.

This is a nice cleanup and helps with ppc hotplug as well.

Has there been any architecture code posted yet?

Just a few minor thing:

>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> ---
>  accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
>  accel/kvm/kvm-cpus.h   | 14 +++++++++
>  accel/kvm/trace-events |  5 +++-
>  3 files changed, 67 insertions(+), 16 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..9cd7d69bde 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -128,6 +128,7 @@ static QemuMutex kml_slots_lock;
>  #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
> =20
>  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
> =20
>  static inline void kvm_resample_fd_remove(int gsi)
>  {
> @@ -340,14 +341,53 @@ err:
>      return ret;
>  }
> =20
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu =3D g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd =3D cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}

Could you move kvm_get_vcpu up here so it's next to kvm_park_vcpu, and
then you don't need to forward declare it. Call it kvm_unpark_vcpu() for
symmetry with park.

Thanks,
Nick

