Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDDFC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMX3-0006zw-Bg; Fri, 26 Jan 2024 08:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMX1-0006yj-1f
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMWx-0003Z9-C9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706276762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gGKgT2BouFnH5blaH26ztR8G6CnT324T0Q33w49jIj8=;
 b=Djk4kW1fPMc+f3PUhrnc/IehAS2BTPyDKEESGcXghwAA/1wEvygdFVGzTZ5iRNJrXwUfK0
 YyY4GZpkfXBl7BFxwjM62DjrilWcCA3Lf4rs4qhBR+dS35frX4+bWrFaQ+Om2S4bI7TgBe
 5uqasL1oMMu75SZBDYqeX5iMZPyDCys=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-WdOUb7HQOM6JU-sqhL_ozQ-1; Fri, 26 Jan 2024 08:46:01 -0500
X-MC-Unique: WdOUb7HQOM6JU-sqhL_ozQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68194fcd1f1so30399286d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706276760; x=1706881560;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gGKgT2BouFnH5blaH26ztR8G6CnT324T0Q33w49jIj8=;
 b=X5r+JRvSnnfGknB8tjubnOQfWb+4y57thQqmpZYAWIzfSgnLQX6ljc3GfBPdptjnIW
 Tw3WPQYEDY+iueTQSKUBPo+nQ/sKSx7/0Y6SOYyJEfvaiI/E/Zx7VaBnsGoWaRQhWyRk
 jpmDZAn0xSyBMlUqNRf7rq78dIJc6Mn5Lxyl++dSQVZYW81pv81/eukq4q3K9xYGnSDz
 +8mlARUIIw9lneDzoWhhQBjrAMSC0trtoIInleFx6mpFmUYUncs377Eq6XLSQrVpxe43
 FQdOwnLtHQDwIdx/rv7DE0WertuEV6zmr9pyofiG9dLrEsagsdzEgcuAx/oLEmEj/M/A
 cULw==
X-Gm-Message-State: AOJu0YxRdq1LfSpt2ELJvbnGTh8peofGxABZDx1WySyDsYiqxFVPGQN9
 55c8lbUphSMloSNpQLNmLp2DiexEXiJdPoGMUhkuSkXfY5LDbavZ5+BTRp+crdrY92gKULkCnAk
 QRnyYHZAEeUHAVMVczM6kv4md25JfDXUrj0TXrJEop6SywGLwoz2p
X-Received: by 2002:a0c:da88:0:b0:681:929e:28cd with SMTP id
 z8-20020a0cda88000000b00681929e28cdmr1377284qvj.19.1706276760617; 
 Fri, 26 Jan 2024 05:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXKYlPOQk0ygMtmSNAnT+cgcujEGgjsco4aR9b7xYzMbYrF8XJ08TBjdWESprAFCfhBHUXeA==
X-Received: by 2002:a0c:da88:0:b0:681:929e:28cd with SMTP id
 z8-20020a0cda88000000b00681929e28cdmr1377232qvj.19.1706276760344; 
 Fri, 26 Jan 2024 05:46:00 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 qo12-20020a056214590c00b0068181b61183sm528291qvb.31.2024.01.26.05.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 05:45:59 -0800 (PST)
Message-ID: <4ee5a881-4a23-4410-b6fd-b1124bce3dc5@redhat.com>
Date: Fri, 26 Jan 2024 14:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/46] hw/i386/pc: use qemu_get_nic_info() and
 pci_init_nic_devices()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao
 <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bin Meng
 <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-6-dwmw2@infradead.org>
 <d6b0fd22-92ef-4873-a19a-e7752bfddd2d@redhat.com>
 <b618c5e3163a3407c413464edd5f638f1c8563fa.camel@infradead.org>
 <da5f845f-dfee-48de-9fc2-af27b83a615b@redhat.com>
 <983ce258a214a0cbe6aeaabab01daed47a2e1066.camel@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <983ce258a214a0cbe6aeaabab01daed47a2e1066.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/01/2024 12.25, David Woodhouse wrote:
> On Fri, 2024-01-26 at 12:20 +0100, Thomas Huth wrote:
>> On 26/01/2024 12.13, David Woodhouse wrote:
>>> On Fri, 2024-01-26 at 11:43 +0100, Thomas Huth wrote:
>>>> On 08/01/2024 21.26, David Woodhouse wrote:
>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>
>>>>> Eliminate direct access to nd_table[] and nb_nics by processing the the
>>>>> Xen and ISA NICs first and then calling pci_init_nic_devices() for the
>>>>> rest.
>>>>>
>>>>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>>>>> Reviewed-by: Paul Durrant <paul@xen.org>
>>>>> ---
>>>>>     hw/i386/pc.c                | 26 ++++++++++++++++----------
>>>>>     include/hw/net/ne2000-isa.h |  2 --
>>>>>     2 files changed, 16 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>> index 496498df3a..d80c536d88 100644
>>>>> --- a/hw/i386/pc.c
>>>>> +++ b/hw/i386/pc.c
>>>>> @@ -658,8 +658,11 @@ static void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
>>>>>     {
>>>>>         static int nb_ne2k = 0;
>>>>>     
>>>>> -    if (nb_ne2k == NE2000_NB_MAX)
>>>>> +    if (nb_ne2k == NE2000_NB_MAX) {
>>>>> +        error_setg(&error_fatal,
>>>>> +                   "maximum number of ISA NE2000 devices exceeded");
>>>>>             return;
>>>>> +    }
>>>>
>>>> error_setg(&error_fatal, ...) quits QEMU, so the "return;" does not make
>>>> much sense anymore.
>>>> Now, according to include/qapi/error.h :
>>>>
>>>>     * Please don't error_setg(&error_fatal, ...), use error_report() and
>>>>     * exit(), because that's more obvious.
>>>>
>>>> So I'd suggest to do that instead.
>>>
>>> It's going slightly in the opposite direction to what's requested in
>>> https://lore.kernel.org/qemu-devel/34e2c0c6-4e04-486a-8e1f-4afdc461a5d4@linaro.org/
>>>
>>> I was thinking that a future patch would let the &error_fatal be an
>>> Error** passed in by the caller, and not actually hard-coded to be
>>> fatal at all.
>>>
>>> But sure, unless Philippe objects I'm happy to do it as you show above.
>>
>> Now that you mention it, I'd also prefer having an Error** parameter to the
>> function instead, that's certainly cleaner. So if you don't mind, please
>> follow Philippe's suggestion instead!
> 
> Right. There's a whole bunch of functions to untangle, that take an
> Error** but don't return success/failure independently as they should.
> Or don't even take the Error**.
> 
> Rather than trying to fix that as part of this series, this was my
> compromise — making it easy to switch that explicit &error_fatal out
> for a function parameter, but not trying to shave that part of the yak
> myself just yet.

I think the nicest compromise is to add the "Error **errp" to the 
pc_init_ne2k_isa() and change the caller to pass in &error_fatal there ... 
further clean-up (passing the error even up further in the stack) is out of 
scope of this series, indeed.

  Thomas


