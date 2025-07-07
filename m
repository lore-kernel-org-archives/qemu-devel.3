Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDCCC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYoJx-0002TM-E6; Mon, 07 Jul 2025 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYo65-0002wq-QY
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYo62-0006Hu-7l
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751903371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4kfDPJj48M0hWmEQ/7VvCIaZlwIKeOHROkeaDqCJO0=;
 b=SZS4Jh9l/GIfNvV9ilQcvK9rYdswedHUvoJSdLheNRpXpLMMrK7cnfpmBc6g87On4xZ5AL
 ecJMhacHmVLOIz3nuDZGffWA1ldZyqQlC9jALmRvKtlErx1RdEFgL6BsYOjAT8Ff6azCOC
 tw6aNOcFqQYDzeGTZtVq44FGVa5rv/A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-zD5XPQnZNMmnAWFj9cLkQA-1; Mon, 07 Jul 2025 11:49:29 -0400
X-MC-Unique: zD5XPQnZNMmnAWFj9cLkQA-1
X-Mimecast-MFC-AGG-ID: zD5XPQnZNMmnAWFj9cLkQA_1751903369
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so1340528f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 08:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751903369; x=1752508169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4kfDPJj48M0hWmEQ/7VvCIaZlwIKeOHROkeaDqCJO0=;
 b=FEPg0w7DvCpkYDdKMiiQH02PJyaVGAfBFdx79qO3hCRIPyI/nsCHw7tjiZplCtl0I5
 iiVRzvyLG2/ix7tTG1CpH96E0FX9tpBcAgb94wQ47/uulzYWNsye5FqexFNEEEWLEVEl
 +EdZX0Bdu3kh/CiPUlIu/JcPqnzQRpknXSx+Voc4HxtfjT+4WolosIyhMw2Pu0xv3DaB
 KrCGKpboMHONqBZAJ5EhRCNlwCkUF3kzdi0fRRWJ7qUQs6FcRfkgW4Z/bKo4HLdBSuFU
 hv1ofVcYN4Y4P3P8sqrUlblfyH2MJSOvYw1YMalt9TtcgfLbghje0f/wFBWm4R+AErzu
 JBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg4pLnVQMgc/cB31MZKHI+Lt7OK3A2MJ9dYXYRwhX6/VC1CME2bAPRjgPXZ0B0EMtD1I+Id8pPqPD3@nongnu.org
X-Gm-Message-State: AOJu0YzGkSIU822EMJM/gAuxZQ4m4h//K5GKBn28JycNTEkNu/cdHZkB
 zb3hSlqCklL7kwMXVObkSGVUcqS44l1M6LZIgB9/OYQUKK88b7v3Mq8Nm05xhuTwvM/Lz3VNwQ/
 VLvEpxwgTcUSx7t13wO9DghI2iL8zoVeCCBPhGF0seMiRz9Sa3p2A0q9K
X-Gm-Gg: ASbGncvmVHg0b8n6o4FjCyS/fw1fs3pB4+K5lqgwCTUrfJ4OI9ZYbKztTM7pa5P1M79
 N8pSre5HxrE/xTDwXcQsqzuoTj6ybjx/DHd0VVuIh5jCdYAJEjxgktG3uNeV+XZz1sX6DQdT35Z
 PdWxU0JaB6im3f8mKB/GkjkNx17+W9zKssKNEFT+RsUiiG1VjGR0UzjBBb1pI+yn6HvWfOK+WuG
 9iVs2VnLWJbkrrAqEcZLvrOpfXVQVIwIzAWT6Dxk2yK91RJliRpB0Y7oFDBSdpfY+SiTnruBeHX
 VNUOeA2/lCUmK20ApfdSKWY2j5a877wY15mfyTRMBpXzs4Y96AFv29d/LaS0vjBsXjc7BA==
X-Received: by 2002:a05:6000:4008:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b49aa186f4mr6743184f8f.20.1751903368499; 
 Mon, 07 Jul 2025 08:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLqmtk/PhuU0Q7kcre4CnRg/iMogk4sjW2ZIZk5tzC1rBTtW3vULQgjY1/dDM5GnfCjgHiA==
X-Received: by 2002:a05:6000:4008:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b49aa186f4mr6743155f8f.20.1751903368065; 
 Mon, 07 Jul 2025 08:49:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bea4a9sm142820715e9.37.2025.07.07.08.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 08:49:27 -0700 (PDT)
Message-ID: <0027ad47-173e-495b-bcca-363b43851d7b@redhat.com>
Date: Mon, 7 Jul 2025 17:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com,
 hi@alyssa.is
References: <20250707131530.1141759-1-eric.auger@redhat.com>
 <20250707131530.1141759-5-eric.auger@redhat.com>
 <CAFEAcA9VxC6CXK+iFFAyktuX1jsJ=znpamkvG5TuwowLxdWSsA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9VxC6CXK+iFFAyktuX1jsJ=znpamkvG5TuwowLxdWSsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/7/25 3:29 PM, Peter Maydell wrote:
> On Mon, 7 Jul 2025 at 14:16, Eric Auger <eric.auger@redhat.com> wrote:
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> Up to now virt support on guest has been only supported with TCG.
>> Now it becomes feasible to use it with KVM acceleration.
>>
>> Check neither in-kernel GICv3 nor aarch64=off is used along with KVM
>> EL2.
>>
>> Also add a migration blocker in case KVM NV is set as some
>> GIC registers are most probably not properly saved/restored:
>> ICH_AP*R<n>_EL2, ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2,
>> ICH_LR<n>_EL2, etc etc.
>
>> +    if (vms->virt) {
>> +        if (!(kvm_enabled() && kvm_arm_el2_supported()) &&
>> +            !tcg_enabled() && !qtest_enabled()) {
>> +            error_report("mach-virt: %s does not support providing "
>> +                         "Virtualization extensions to the guest CPU",
>> +                         current_accel_name());
>> +            exit(1);
>> +        }
>> +        if (kvm_enabled()) {
>> +            Error *kvm_nv_migration_blocker = NULL;
>> +
>> +            error_setg(&kvm_nv_migration_blocker,
>> +                       "Live migration disabled due to KVM nested virt enabled");
>> +            if (migrate_add_blocker(&kvm_nv_migration_blocker, NULL)) {
>> +                error_free(kvm_nv_migration_blocker);
>> +                return;
>> +            }
>> +        }
>>      }
> I think a better place to set the migration blocker is in
> the GIC code itself (maybe in kvm_arm_gicv3_realize() ?) : we
> want to disable migration for any setup with a GICv3 + KVM + EL2,
> not just the virt board.
OK
>
> I also don't understand why we don't hit the assert
> in gicv3_init_cpuif() that checks that if we're not TCG
> or qtest accelerators then the CPU doesn't have EL2 or EL3.
> It looks to me from reading the code that we ought to go
> through that function in the KVM case.

with kvm gicv3 we enter
kvm_arm_gicv3_realize/arm_gicv3_common_realize

but we don't enter arm_gic_realize which calls gicv3_init_cpuif Thanks Eric
>
> The rest of the series looks OK to me.
>
> thanks
> -- PMM
>


