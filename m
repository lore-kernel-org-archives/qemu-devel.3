Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF8C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbCU-0000zI-VT; Thu, 30 May 2024 04:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbCQ-0000yY-2g; Thu, 30 May 2024 04:31:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbCO-0003iX-9I; Thu, 30 May 2024 04:31:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bdb61c5fdbso474474a91.2; 
 Thu, 30 May 2024 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717057906; x=1717662706; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yI5snCzsOCCe0HNmK9idyv6neabQY9wRhjCaB41YCZw=;
 b=Pxv/MyXNrQHDDC/sFsszq5kuvcB3cyH0KNi3xWkVdpxAEIjaxmpkocZQM/wwu8Bwba
 ECHcBd7LOJBbAf0WLlGmzjxA+AQHBTQhm+xytNHhUfDIppLqZ43Pb/jX+ylyIPF9fwnh
 sxKnsBPaaOynlHCyKbNNB1WpZ4JqHTlycKuRyEXqYyE9kibxiNzdp+CN+UJSNpEOyrH6
 FAPuclkIJ4AGV5ULRQCOJ65WHEmzpdC1++jFxZFUMIu0wb/hLJ3G7CuQcqQ7MP8t4E1A
 SPxQrsihBWqPX+RFLLKyt5cvQEZuE4dpPITtSNH4Vhmy2ogTlXO41BVULwpTIDyGJZXt
 11uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717057906; x=1717662706;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yI5snCzsOCCe0HNmK9idyv6neabQY9wRhjCaB41YCZw=;
 b=ggJGR2sMbPyGRlKcrGFgzT86XfYellXq+myMHlSyR1rNOeomDslXTEuvGKFN2tjVPt
 ItAd+wIDXTvr8BKatMPQWqODZPRFNjIdUE303pX3Te4Mb3ya+QN/J05g+ZpHLMt34Rsj
 Hu/QSXkI49gasKtxANPK0iFOgL+c3MgVvfwAlzuzGKKW9/KYNnZL0qv+weEN0hkc0TH8
 OBxIHBhjlUbXPHPwDmSyXkpoAwYG74ivJqwzoh2VarF+DdlPvWBSV5HJpSaloZw3ZbkU
 tsaKPa1W9p12B9WOnQSBCy5XkNajE0DI7n3dWAaq+4mR33v/4DscHA/Yjmyr2VGDTCh2
 zwAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwNthpOcF8XYfx6vIcORSok8lj6ENaVxspwreedg8v5AtwbNujVAlx9nbgl1nejp6Fyls2nQtMv21cfRYZe4YpIbgmEgk/iInup0oq91n4hPhz0RVbvlqxKs8=
X-Gm-Message-State: AOJu0YycIP1BE8EHcrPtU4IALA2ceoRuzY1ZY8cAOhN7/CpIHatJTPjz
 hGVuGF3V9bjFc+eXhZUsUAeedfnnK/xVI7E6Xv/wqmiCm3Cc/75S7fn4yg==
X-Google-Smtp-Source: AGHT+IEEzDl2iY7YsmFDZ7WMpthth+PH/s8BrftLm5SrvglATAEaIIDvpihQnPrnmzylcOR1J6bNQg==
X-Received: by 2002:a17:90a:8cd:b0:2bd:e639:686c with SMTP id
 98e67ed59e1d1-2c1abc3b456mr1493355a91.23.1717057906107; 
 Thu, 30 May 2024 01:31:46 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77a1eb2sm1110119a91.51.2024.05.30.01.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 01:31:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 18:31:40 +1000
Message-Id: <D1MU85R4BGCR.1BKTI2APY26X7@gmail.com>
Cc: <danielhb413@gmail.com>, <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] accel/kvm: Introduce kvm_create_and_park_vcpu()
 helper
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523072614.256172-1-harshpb@linux.ibm.com>
 <20240523072614.256172-2-harshpb@linux.ibm.com>
In-Reply-To: <20240523072614.256172-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu May 23, 2024 at 5:26 PM AEST, Harsh Prateek Bora wrote:
> There are distinct helpers for creating and parking a KVM vCPU.
> However, there can be cases where a platform needs to create and
> immediately park the vCPU during early stages of vcpu init which
> can later be reused when vcpu thread gets initialized. This would
> help detect failures with kvm_create_vcpu at an early stage.
>
> Based on api refactoring to create/park vcpus introduced in 1/8 of patch =
series:
> https://lore.kernel.org/qemu-devel/20240522211111.232114-1-salil.mehta@hu=
awei.com/
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  accel/kvm/kvm-cpus.h |  8 ++++++++
>  accel/kvm/kvm-all.c  | 12 ++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
> index 2e6bb38b5d..00e534b3b9 100644
> --- a/accel/kvm/kvm-cpus.h
> +++ b/accel/kvm/kvm-cpus.h
> @@ -46,4 +46,12 @@ void kvm_park_vcpu(CPUState *cpu);
>   * @returns: KVM fd
>   */
>  int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> +
> +/**
> + *  * kvm_create_and_park_vcpu - Create and park a KVM vCPU
> + *   * @cpu: QOM CPUState object for which KVM vCPU has to be created an=
d parked.
> + *    *
> + *     * @returns: 0 when success, errno (<0) when failed.
> + *      */

Something went wrong with re-flowing the comment?

Don't worry about resending for that just now, at least until we work
out the dependency with Salil's series and ready to merge.

Thanks,
Nick

> +int kvm_create_and_park_vcpu(CPUState *cpu);
>  #endif /* KVM_CPUS_H */
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index fc30e5d5b8..d70ca62ff5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -398,6 +398,18 @@ int kvm_create_vcpu(CPUState *cpu)
>      return 0;
>  }
> =20
> +int kvm_create_and_park_vcpu(CPUState *cpu)
> +{
> +    int ret =3D 0;
> +
> +    ret =3D kvm_create_vcpu(cpu);
> +    if (!ret) {
> +        kvm_park_vcpu(cpu);
> +    }
> +
> +    return ret;
> +}
> +
>  static int do_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s =3D kvm_state;


