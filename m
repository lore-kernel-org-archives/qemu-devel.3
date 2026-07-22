Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB3EC44512
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmQqz-0004WC-UZ; Wed, 22 Jul 2026 02:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmQqs-0004Uu-8b
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 02:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmQqq-0003Bq-3f
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 02:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784703281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9qS3+jlyeK15KPAYimukyJlTAprsGF+GK/BODQqMPw=;
 b=cvI50oxOGKLSd+IFZ967QMImELr42FD7D5PoY/rW6NG78dlUJB61UyW6q11txx9TsiuK+N
 YK4tuur4c0pgstRyyzREduC4fxTbYjXXlOqBatJVIRd0+HM4mRcsVYirnMJJ5dmGaNnwfI
 4JX4CFeGSV1YAd7sEwvhnifoyH2Hgmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-qtuNr2b0MmSGjxeoJANSjA-1; Wed, 22 Jul 2026 02:54:39 -0400
X-MC-Unique: qtuNr2b0MmSGjxeoJANSjA-1
X-Mimecast-MFC-AGG-ID: qtuNr2b0MmSGjxeoJANSjA_1784703278
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso5007012f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 23:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784703278; x=1785308078;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F9qS3+jlyeK15KPAYimukyJlTAprsGF+GK/BODQqMPw=;
 b=bL51zyFUz95Iw8VSlcMeAA3XL63MDrSn1kfQrZ2rufKz8uFFID+i8zBaU5DpVp2AoI
 3gKSKe0qYG/6G6X0AIQ4zPAbgucZuHzendzDnd8CD/XsHsuWL6mUYndGTS5T/K1JAtuo
 OUkgDyMMWrvEuJfzn8+QzmKEziyfaD5toh//ohF21hcw5l9d+F6LogV22SQxRpOZoquH
 RRIlKnQEpXRB4a06K2nHnJNULIGmIk5XXNU7ShSvooTNHasb2MaAmJe1nkiSL75H0FZw
 tSXvBGhnLmgMVv2UDSAkWsWJc+h8KKKUh46DbVHI91MEcfybUNMYeVKbJcoscwwrNNzL
 yt+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpbfn/Qt8HcVSYVCntieLXnKIi7EjrtTvavX7U02WT39B0/wYw/GDnFGECJDXr8fXUnePD2etAGlxz4@nongnu.org
X-Gm-Message-State: AOJu0YzvK0X5cpQW1dURk4LU6EX2fsoVYXpZ16pbGUaMJ2neEHxRkUpN
 ly6qheewCY3AcjFIGAcJu9WEGJPNGBhhECyUbhDqd3fkPr7tOJZiWuthc30MsDEuojS2/XD3k7p
 o8a9rsKyMWd6axLuTQMGYDWdDa++ns2j7oTsXZD74JdRk2DHfrNcwZjy5
X-Gm-Gg: AR+sD10yEanoAbiDWMiE6btVXgDVTQ+YiK9CGKnzX9BGQsWeaSnJ3N+mVucBFAz6XQc
 Dg7kbt3JpMD3FlfCwa8ZOZjBFZgGxDtTTvV5uBcxU3vSLalsZrvdcQVsGTmGqrGFF96SPN2cL1q
 pfkDUnOwZZ3SJrX3gkOLOE9cOpYSmajAuOsnPbqO9/aMYp/b/KGlcGFk8DTsd9kcUVVydCnno1m
 k2F6iOl2gOno7oZtyDMsXcqTmtgsp+9MVj0OSXRk5qfB+8B5WdiukHaSy13d2+GkA3pZhYeI/Dj
 O3pYHCOcSWPrnS+M6qvcgypmY/pKasVNUc6Ebgtz38ofwyDdlLitV8v34fxMcn06krHrH0gKTvG
 Xk1FOMT98rybf4UgLfxY9tTV0VDwIlK1GAVC5elTJO4ospIRk
X-Received: by 2002:a5d:5d82:0:b0:47e:9f16:c0bf with SMTP id
 ffacd0b85a97d-47f62326f0bmr26201952f8f.30.1784703278350; 
 Tue, 21 Jul 2026 23:54:38 -0700 (PDT)
X-Received: by 2002:a5d:5d82:0:b0:47e:9f16:c0bf with SMTP id
 ffacd0b85a97d-47f62326f0bmr26201912f8f.30.1784703277935; 
 Tue, 21 Jul 2026 23:54:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm3227267f8f.35.2026.07.21.23.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 23:54:37 -0700 (PDT)
Message-ID: <980b8a5e-2c9f-4a7b-8014-15cc96831cf0@redhat.com>
Date: Wed, 22 Jul 2026 08:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/19] target/arm/kvm: Read all ID registers from
 KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 prerna.saxena@nutanix.com
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-7-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260716213858.609699-7-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 7/16/26 11:38 PM, Khushit Shah wrote:
> Try to read all the ID registers from KVM. KVM may return ENOENT, for
> ID registers it does not support reading from userspace. Ignore those
> registers. As this list is small, in future we may anyway want to
> handle those register specially.
>
> We want to do this so that we can expose more or less complete
> host feature view to management stack, as for migration, we want both
> writable and non-writable ID registers to match.
>
> Also remove the unused 'cpu' args throughout the call-chain.
I will integrate this fix in the parent series
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/kvm.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 63b3727e05..42ff731f6e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -292,14 +292,14 @@ static int kvm_feature_idx_to_idregs_idx(int kidx)
>  }
>  
>  /*
> - * get_host_cpu_idregs: Read all the writable ID reg host values
> + * get_host_cpu_idregs: Read all the ID reg host values
>   *
> - * Need to be called once the writable mask has been populated
> - * Note we may want to read all the known id regs but some of them are not
> - * writable and return an error, hence the choice of reading only those which
> - * are writable. Those are also readable!
> + * We currently try to read all the registers. If the read fails with
> + * ENOENT (KVM does not identify the ID register) ignore it.
> + * Some of the registers that errored with ENOENT will anyway need special
> + * handling.
>   */
> -static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
> +static int get_host_cpu_idregs(int fd, ARMHostCPUFeatures *ahcf)
>  {
>      int err = 0;
>      int i;
> @@ -310,26 +310,26 @@ static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
>          uint64_t *reg;
>          int ret;
>  
> -        if (!sysregdesc->writable_mask) {
> -            continue;
> -        }
> -
>          reg = &ahcf->isar.idregs[i];
>          ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
> -        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
>          if (ret) {
> -            error_report("%s error reading value of host %s register (%m)",
> -                         __func__, sysregdesc->name);
> -
> -            err = ret;
> +            if (errno == ENOENT) {
> +                warn_report("%s error reading value of host %s register "
> +                                "(ENOENT)", __func__, sysregdesc->name);
if there are expected cases where the read is failing I don't think we
want to warn. Add a trace point instead.
> +            } else {
> +                error_report("%s error reading value of host %s register"
> +                            " (%m)", __func__, sysregdesc->name);
> +                err = ret;
> +            }
>          }
> +        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
>      }
>      return err;
>  }
>  
>  
>  static void
> -kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf)
> +kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  {
>      /* Identify the feature bits corresponding to the host CPU, and
>       * fill out the ARMHostCPUClass fields accordingly. To do this
> @@ -415,8 +415,8 @@ kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf)
>          SET_IDREG(&ahcf->isar, ID_AA64PFR0, 0x00000011); /* EL1&0, AArch64 only */
>          err = 0;
>      } else {
> -        /* Make sure all writable ID reg values are initialized */
> -        err |= get_host_cpu_idregs(cpu, fd, ahcf);
> +        /* Try to read all the ID registers */
> +        err |= get_host_cpu_idregs(fd, ahcf);
>  
>          /*
>           * temporarily override the CLIDR_EL1 value since some host values
> @@ -595,7 +595,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      g_free(writable_map);
>  
>      if (!arm_host_cpu_features.dtb_compatible) {
> -        kvm_arm_get_host_cpu_features(cpu, &arm_host_cpu_features);
> +        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
>      }
>  
>      cpu->kvm_target = arm_host_cpu_features.target;
Thanks

Eric


