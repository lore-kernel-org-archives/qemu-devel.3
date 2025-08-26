Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8C0CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrmD-000746-8n; Tue, 26 Aug 2025 07:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqrm9-00070G-HS
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqrm4-00083b-7D
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756207409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cBugJJub36Mrueq/357PIlWuiu3NshY04ejaBBzNfA=;
 b=DdGmB4ZyJp+MVWoGsmmayoe5MXy5vSnH4XpcTlQrsL3q5OYOKs7EKXsGz0YK0O9Ut6+u/h
 TqWWS/Ceio3tv6kJ4cFJ7t7DficWmaMqIuf6jWG8oqlUewTP/5EHeQlgG9M+7p7tFshm2s
 NB3wIHqa7/Nul4CPj0NlS9h26ae2ihc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ln517oLUNXGcS09OcrUoYQ-1; Tue, 26 Aug 2025 07:23:28 -0400
X-MC-Unique: ln517oLUNXGcS09OcrUoYQ-1
X-Mimecast-MFC-AGG-ID: ln517oLUNXGcS09OcrUoYQ_1756207407
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b10946ab41so131905941cf.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 04:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756207407; x=1756812207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cBugJJub36Mrueq/357PIlWuiu3NshY04ejaBBzNfA=;
 b=ONHtZLRyHuNluoCSyFeDlbwpyOyIpgdY85MP7dRPu9cMSP2StibMlJz1LowN1U6ipn
 3If7/e5SrCsD8/L2p61UFw4cwS1vU7FtMJyv+zrLGR9aIUYEUZKeXdrhDHIJX+2AOzjt
 UA+hp5GYGtYBJ6pRK8EDUv7cze2mg7BXD5QbGhpG/snvzklw4Bk1HFDhgxHfvrxcmX6A
 7Wa8kCbo2XEqS+ipbTSn5+w0nTUUl65nPnjk2Ey6rJpT09Aa4XwwcML6y8q8BbPbANmU
 IvPXryEaymVVwmY3BP+SOJcmxl5/CWut8NCOYGDqBEybII+1Iy8+qiJfU5o/s3ulnMNT
 KABw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/ICcEu881PkyZAHzG3kNJ4cn6WnHEuFRRK6loh8GSkFqL5G8pMFopcSC+hlMXMlkxTJ4LB4pAHvg@nongnu.org
X-Gm-Message-State: AOJu0YyE0jHeylKuHEKPILrWgHn6Nk4maNDd3cVJc5xUel0B8pcLQchn
 kqhvlwzVV+HPHB7XQrW4q/wSjpkciBS1VJ+eKoigcpbX5OoBZamwxdnaxx0Sq+BFKKGlGu5pdg5
 xZzyJXIERiO9tz+jYaZ299LGnl9qaMQO1yRnVXyi8/KeIBG8xZY2Ynzh/
X-Gm-Gg: ASbGncvon+E0Gv7v4JxuTSUM+CRe73LobRaJnlkPEOEta57dFj7JuGNxQNbpAG8NiGU
 iINxjmmzTZJFKq5E1ND06B5t1bMhjGEuFUD+LRQqTGRI+FdC0LwLrB2ZaS5vI/ITXUCTE6YcPmZ
 U2HQDzOC7Nf0kaQqjn75vfv/qsigCf5Ur2WK3pyeNMFU/BoXNCNma4Tt7OCocM6qG3Xm1QFKjuA
 kwKIU8qmgJmQU22e6uvSryUxAbUqkNrrAvqqkPqCBPHwXkpF+sIyzppASGmesiQML1n3nlxuVwK
 Qycc3+0wJiT7EbJBcI1lwFD04WV5fQ==
X-Received: by 2002:a05:622a:4c14:b0:4b0:7521:3ba9 with SMTP id
 d75a77b69052e-4b2e76f7ba6mr10849531cf.14.1756207407191; 
 Tue, 26 Aug 2025 04:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXBfMGyjW9CyAOH5d4T0/t6MBzTl+/Lg0erCZk3HzO3qqTRnSeZRe3UaBUnknpkPBdAfe83Q==
X-Received: by 2002:a05:622a:4c14:b0:4b0:7521:3ba9 with SMTP id
 d75a77b69052e-4b2e76f7ba6mr10849241cf.14.1756207406777; 
 Tue, 26 Aug 2025 04:23:26 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b2b8ca8d93sm70688711cf.18.2025.08.26.04.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 04:23:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:23:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
Message-ID: <20250826132322.7571b918@fedora>
In-Reply-To: <20250815065445.8978-1-anisinha@redhat.com>
References: <20250815065445.8978-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Aug 2025 12:24:45 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare it
> static, remove it from common header file and make it local to kvm-all.c
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  accel/kvm/kvm-all.c  |  4 ++--
>  include/system/kvm.h | 17 -----------------
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> changelog:
> unexport  kvm_unpark_vcpu() as well and remove unnecessary forward
> declarations.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f8..f36dfe3349 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -414,7 +414,7 @@ err:
>      return ret;
>  }
>  
> -void kvm_park_vcpu(CPUState *cpu)
> +static void kvm_park_vcpu(CPUState *cpu)
>  {
>      struct KVMParkedVcpu *vcpu;
>  
> @@ -426,7 +426,7 @@ void kvm_park_vcpu(CPUState *cpu)
>      QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>  }
>  
> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> +static int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
>  {
>      struct KVMParkedVcpu *cpu;
>      int kvm_fd = -ENOENT;
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 3c7d314736..4fc09e3891 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -317,23 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
>   */
>  bool kvm_device_supported(int vmfd, uint64_t type);
>  
> -/**
> - * kvm_park_vcpu - Park QEMU KVM vCPU context
> - * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> - *
> - * @returns: none
> - */
> -void kvm_park_vcpu(CPUState *cpu);
> -
> -/**
> - * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> - * @s: KVM State
> - * @vcpu_id: Architecture vCPU ID of the parked vCPU
> - *
> - * @returns: KVM fd
> - */
> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> -
>  /**
>   * kvm_create_and_park_vcpu - Create and park a KVM vCPU
>   * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.


