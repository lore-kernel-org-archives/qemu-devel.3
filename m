Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74377C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0ym-0004kw-BG; Mon, 03 Feb 2025 13:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tf0yk-0004kd-Kj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tf0yi-0001ch-St
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738606523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ERF8dmEQGHJVHf4szwBA/PuACgIVSUu9BmSPbvt4GZc=;
 b=SMGmkK9ZUpSiHCRSGFzX/V+NcdojBO9n1m3zJrlUHASdtMB4seFKBWoGDCG1kG+se4/TfM
 ExVJV0zM/6pbjBE5y7ZmcrjOZ4Ab4XEkh5dSx4bVkVPYh9d2w8G6j+Xf5QtEJdNBUQ1a4g
 DcVR9mk4ucqgc0JAZezh4a8UzDxHyNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64--K73LjK4OnecBRStXhmTfA-1; Mon, 03 Feb 2025 13:15:20 -0500
X-MC-Unique: -K73LjK4OnecBRStXhmTfA-1
X-Mimecast-MFC-AGG-ID: -K73LjK4OnecBRStXhmTfA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38c24cd6823so2393577f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738606519; x=1739211319;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ERF8dmEQGHJVHf4szwBA/PuACgIVSUu9BmSPbvt4GZc=;
 b=fTW2OvfvZJjRAqFvHeZG75GMtVULnXWrnL53lR/62l5ENfLNoxk4t5HqsUjWz1btGR
 uRIzIchGAHKy8RQBxBygy60WImGo2bICZDmbmVm3eX8c+DYs4RVn9bkz56Ng5Rn2sJYG
 xlxZMxoy1wgYmt47PIlRuHQ1IeTAtO1c9QteRo/nKCXoI1c46Eygvawf3M4wyxtp7sVg
 cBdSJohQHIEdlgIqK4c8rnLoqTNY9FPYy6aTODM9ihma2y27NrNNf5hvUTrRn/4rmEBJ
 gsuQ4pRgwL0m55u6B23qQyGjPXzg8mjgaMcuYdtsIdUmM0SsfOmoGCmV0iuhYmNoNeec
 WynQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq/8cOJdDaxAA1n7sc6rNgIf/JyingF1rdo+S3OgVZBjxi7aOLOhqUyqqHDfhlFrBLsHOTHmLxJUIh@nongnu.org
X-Gm-Message-State: AOJu0YzHM2rR77XzLd0FTn4QuDbC5UJ4jST9QMqthmIgWwdVqdfMdipo
 BR8tDnq0xDMfjLi1dexoMNtWKu31Gk5MVpHatfkk5F9RfEO/zQt8loo8288ZnMbGbTxh00kwHqY
 sZroVrUygKn7hYaPby87sWJDK0DEl/xH99ltdRn6+qOe8pzcgOLgN
X-Gm-Gg: ASbGncti2+igus0wo3eWQwpfq3YzZFthfaZS3RQwhwwSFOBfQe1dfq02CMSrIEDpwSL
 WuU7BvdknwtexVKtpLBKf5/Y5bp7cwigpETkRegkrYNOOEYTKkZZzNGip43sCmYpV8nmNpveEza
 DGBQaaTz/4bMmnbQd/1GRuJu6ViPXKDw760eP15tKA1iAp1T0Ilx4/tjSe76OG9m70xIAtc/RfL
 jhdTvAkWBborxFqhGZiejM04LbwCD6LdsonJirEALtbsIm+wS/Isu+eBUpUlig58KVf0Glm46UQ
 ZskVUA==
X-Received: by 2002:a05:6000:1fa6:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38da53da590mr217214f8f.20.1738606518983; 
 Mon, 03 Feb 2025 10:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVHivnAr77z1I6fHQzEsVljcDP6WfD456NiIpuInK14RTqPRFNYIiz1fCjtEa4ynUK3OSuJQ==
X-Received: by 2002:a05:6000:1fa6:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38da53da590mr217201f8f.20.1738606518630; 
 Mon, 03 Feb 2025 10:15:18 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0eccc3sm13658344f8f.18.2025.02.03.10.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:15:17 -0800 (PST)
Message-ID: <5f2ce1a7-e62e-4f43-a033-7353aaaef763@redhat.com>
Date: Mon, 3 Feb 2025 19:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 51/52] i386/tdx: Validate phys_bits against host value
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-52-xiaoyao.li@intel.com>
 <CABgObfb5ruVO2sxLCbZobiaqX-3h9Q+UKOZnp_hhxfJA=T-OJA@mail.gmail.com>
 <774945ce-04e2-42d5-83fc-97ad08647101@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <774945ce-04e2-42d5-83fc-97ad08647101@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/2/25 15:39, Xiaoyao Li wrote:
> On 2/1/2025 2:27 AM, Paolo Bonzini wrote:
>> On Fri, Jan 24, 2025 at 2:40 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>
>>> For TDX guest, the phys_bits is not configurable and can only be
>>> host/native value.
>>>
>>> Validate phys_bits inside tdx_check_features().
>>
>> Hi Xiaoyao,
>>
>> to avoid
>>
>> qemu-kvm: TDX requires guest CPU physical bits (48) to match host CPU
>> physical bits (52)
>>
>> I need options like
>>
>> -cpu host,phys-bits=52,guest-phys-bits=52,host-phys-bits-limit=52,- 
>> kvm-asyncpf-int
>>
>> to start a TDX guest, is that intentional?
> 
> "-cpu host" should be sufficient and should not hit the error.
> 
> why did you get "guest CPU physical bits (48)"?

Nevermind - I got it from the RHEL machine types.  The fix (which does not have
to be included upstream, though I would not complain) is

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e0ab41bcb7b..7aca8219405 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -444,6 +444,7 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
      X86CPU *x86cpu = X86_CPU(cpu);
  
      object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+    object_property_set_bool(OBJECT(cpu), "host-phys-bits-limit", 0, &error_abort);
  
      /* invtsc is fixed1 for TD guest */
      object_property_set_bool(OBJECT(cpu), "invtsc", true, &error_abort);

but it also needs the patch at
https://lore.kernel.org/qemu-devel/20250203114132.259155-1-pbonzini@redhat.com/T/.

With these two changes, QEMU accepts "-cpu host" just fine.

Paolo


