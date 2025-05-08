Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE9C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCw4K-0003Q9-UJ; Thu, 08 May 2025 03:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCw4H-0003Pp-Lp
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCw4G-0003Pd-3F
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746690799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gbxJO53ELp7QdRPsg5yHxWLcQX9/Uk4NsOEVV/jcX04=;
 b=GRUBKA1T/E+N2cD0E4cwRBomF8pSWgpvtdzs0viGkPXXkffEJlghkp4xQGYMTw4VLncqRe
 M5vvQNMbT9J7MhWLVhW840PA4hfNFSH0Yl3hjF4BqMOehW/PNfYD9OZZBwsfUVCSUqDnVL
 lpGJlX9EWjupxkaSOrLQwAlN37+rAGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-tlbc0cPsMnGQ-ut4noFx9A-1; Thu, 08 May 2025 03:53:18 -0400
X-MC-Unique: tlbc0cPsMnGQ-ut4noFx9A-1
X-Mimecast-MFC-AGG-ID: tlbc0cPsMnGQ-ut4noFx9A_1746690797
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso781930f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690797; x=1747295597;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbxJO53ELp7QdRPsg5yHxWLcQX9/Uk4NsOEVV/jcX04=;
 b=dEUMzfPFgu8rgcZwUjPqleLaUCMPTdpszx/5FPBNo/CVMaHI1Xq3W/UK5WTMDuSNp0
 f6R5rt4RiQaRlKSnyKUft3jqe8+wfdYEdl7Z9BkM+3ATH+i0+qtPoZ5Bx6dJ/L5PPrZy
 ZvdBPkNcsBO+PjIXLHvdHVHIoJNy0bQYsLBriCBKNh0PRwMTpEJ315/kR3aeKF4u7vVh
 jJis1rRB5va0js42CGqlu797sNdR3XnX2PwC5kPvK9kGKr5bBbg9It6MVoDtv/zSd+wp
 6rH7fAde4i1eP4WEN6Ja0rgj7/L74FMnOCfGkTYIiStWyNNqcy6W+gr85KfnIOnJVbCI
 e4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqmp2zgXwJjirqFQP/Jz0PZWkwvBr8sTMG5m2i1kqucwPSCwnOAF+is4R17bp2DEPL5ZAN8c1K6+uU@nongnu.org
X-Gm-Message-State: AOJu0YykeLMFmswXh1wAWpiD7rHB95fS8NbuqlLR0sZLQWNAMKOH5prE
 lNOobx0j6/5MECjW9CoEwjWCPahtRKaItbaPcfPhMcrFdnWi14mwIH1nYl+vpbSpbqym37DqHYd
 1LAxIPRTm1LUCwrej7WPRJZqPrx6fWisuNRielDEupqMNCdf2hG5v
X-Gm-Gg: ASbGncu7Nc24Sk1RiBmufbqaes4TfvPBmejwNzrZT93HsK7r0j7aQH16wJkD5jGKDGy
 4l6JopLIhd9pAYQ507LNk/jy/HNwWBcc6ItNP1WqCGVFCUwdOD91VCrahFWx32GH/pG4+Psi5qa
 bKdS1sCdc1hMgMnHBcN4LvKQuukmR4bLfzL4qOcdXr2i0gdef1hZ4Vpswy05X1ssG9DwNWORNFk
 OWP4rC2tPYyDvrrkOgYNscioxWGzX864mjJTyX/sfTjhKCp1OcvoZKXEQsu3mHZB9OgTgyhbp+4
 jZPAIGl4/ERCZPYKjFhGwrZ3rtbP0eLneptq7vB0RQc7ByGo8WKw
X-Received: by 2002:a05:6000:2ab:b0:39f:c05:c220 with SMTP id
 ffacd0b85a97d-3a0b9941e27mr1993277f8f.22.1746690796865; 
 Thu, 08 May 2025 00:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkqOw8tn2oihZwFNwPrlEY4Qmh3cGFOgcTpvzujNRD0KkbbWSa2ZP2iC1LSe5Wcjrs5XA9w==
X-Received: by 2002:a05:6000:2ab:b0:39f:c05:c220 with SMTP id
 ffacd0b85a97d-3a0b9941e27mr1993240f8f.22.1746690796422; 
 Thu, 08 May 2025 00:53:16 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7caasm19644391f8f.54.2025.05.08.00.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:53:15 -0700 (PDT)
Message-ID: <2785e145-d69a-456f-8d85-03f7922531d9@redhat.com>
Date: Thu, 8 May 2025 09:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-12-philmd@linaro.org>
 <97eadaef-7c1b-4561-af9a-bd887e00d19c@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <97eadaef-7c1b-4561-af9a-bd887e00d19c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 05/05/2025 11.50, Philippe Mathieu-Daudé wrote:
> On 2/5/25 20:56, Philippe Mathieu-Daudé wrote:
>> These machines has been supported for a period of more than 6 years.
>> According to our versioned machine support policy (see commit
>> ce80c4fa6ff "docs: document special exception for machine type
>> deprecation & removal") they can now be removed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/i386/pc_piix.c |  9 ---------
>>   hw/i386/pc_q35.c  | 10 ----------
>>   2 files changed, 19 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 98a118fd4a0..98bd8d0e67b 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -755,15 +755,6 @@ static void 
>> pc_i440fx_machine_2_8_options(MachineClass *m)
>>   DEFINE_I440FX_MACHINE(2, 8);
>> -static void pc_i440fx_machine_2_7_options(MachineClass *m)
>> -{
>> -    pc_i440fx_machine_2_8_options(m);
>> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
>> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
>> -}
>> -
>> -DEFINE_I440FX_MACHINE(2, 7);
>> -
>>   #ifdef CONFIG_ISAPC
>>   static void isapc_machine_options(MachineClass *m)
>>   {
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index b7ffb5f1216..a1f46cd8f03 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
>>   }
>>   DEFINE_Q35_MACHINE(2, 8);
>> -
>> -static void pc_q35_machine_2_7_options(MachineClass *m)
>> -{
>> -    pc_q35_machine_2_8_options(m);
>> -    m->max_cpus = 255;
>> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
>> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
>> -}
>> -
>> -DEFINE_Q35_MACHINE(2, 7);
> 
> As noticed Thomas for 2.4, here I missed to squash:
> 
> -- >8 --
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86- 
> cpuid-compat.c
> index 456e2af6657..5e0547e81b7 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -348,11 +347,0 @@ int main(int argc, char **argv)
> -    if (qtest_has_machine("pc-i440fx-2.7")) {
> -        add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
> -                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
> -                       "pc-i440fx-2.7", "level", 1);
> -        add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
> -                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
> -                       "pc-i440fx-2.7", "xlevel", 0);
> -        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
> -                       "486", "xstore=on", "pc-i440fx-2.7",
> -                       "xlevel2", 0);
> -    }

With that hunk added:

Reviewed-by: Thomas Huth <thuth@redhat.com>


