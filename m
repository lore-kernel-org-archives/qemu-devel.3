Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F9C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTTTx-0007cI-EH; Fri, 26 Jan 2024 16:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTTTu-0007ab-7w
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 16:11:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTTTp-00073D-Lj
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 16:11:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40ee418e7edso12407045e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706303475; x=1706908275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxYwthXZn31ySjM2DeVKX29v0Ws6VePUGUeM9gtZWoA=;
 b=JDyHEwqvqboDEDYNihCFNcIfscK5BYQxoaPaj7zQNDvQce41kvjJJ7wWCIoXaPO8Ny
 V2C2JM9kpYUFAtpXvyb+Qeb5R/mhscWC4bgWqWLQPNrm3/piv4BS/n5Q/AEQrJxJDRv4
 DgS03b2WjA0PboF5keTTl/bbAyy6WchopJLj8IiGlLvG2EcChbYI63uVPl6PRu59jT8W
 7iBNyeGdfQ+9oQiKVjYhLiGjnXCeT71Xf4L4Fu8+/6iCG+ssZWyL0XXqf13O0+9lvUUU
 NNVVWzO25VGIAXR6AB7iTn96O8KOVfsQdkbAAL+4FdRxTmR8gkSSyq8K2WRFj+u1yYk4
 laVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706303475; x=1706908275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxYwthXZn31ySjM2DeVKX29v0Ws6VePUGUeM9gtZWoA=;
 b=vuB8c/g9GfM/UfysTfgqkVjAlXqc6F8H88h8Gh/aIdq0/O7bpFkmLO8owpb6+ewjC5
 FXMXPHOgTHFWdiFzW67eV6dk9LiIJCiXRNQWwj2WoCyc+aH55EW3Y5ig3D3ocAOWDgIZ
 2AS9EwkLgbpFw2vWFd81xUd/+Ltf2bhl2wtF7f5kUN5I6+aFipQI5F2XkAp2npiWEhdx
 x0nHI7IhVkDwyZNCWFWTY2f6ix8aP7kSL1il/Ba4JfpnTHIF9JrpB71m8RwfzOU21f8h
 KtjU7goN1iNwPfBfR90XfVgzDHcZjMrYS1sGLzfuMkB+hZR3vq13dH3tIJl1d7xBTTni
 Yzbg==
X-Gm-Message-State: AOJu0YyQlbYg2LBLalHWy9cBpAQIGHLUWdsFfaMm+fR+2s9kr3cPoOPM
 Y1cesSfeT7itQRVDVuLYIElK2hNUwNzr6vY0JfECldyFIFPKgOww0uqTYsVGIzw=
X-Google-Smtp-Source: AGHT+IHPfVDNkHfFEZ920e1AvtHAgCTjycghkqkwfmMNm/uoHYkWmbEXdBjZ/pk1I5xFKz0+SjDwuw==
X-Received: by 2002:a05:600c:4ca7:b0:40e:5534:728c with SMTP id
 g39-20020a05600c4ca700b0040e5534728cmr286415wmp.136.1706303475465; 
 Fri, 26 Jan 2024 13:11:15 -0800 (PST)
Received: from [192.168.69.100] ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a05600c348500b0040e48abec33sm6615547wmq.45.2024.01.26.13.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 13:11:15 -0800 (PST)
Message-ID: <c4c07c69-11c6-4883-8ff8-1e5ec627d9bc@linaro.org>
Date: Fri, 26 Jan 2024 22:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bulk: Prefer fast cpu_env() over slower CPU QOM cast
 macro
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Alexander Graf
 <agraf@csgraf.de>, Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org
References: <20240125165648.49898-1-philmd@linaro.org>
 <20240125165648.49898-3-philmd@linaro.org>
 <135941df-2f8b-4fd5-91c7-40b413e6eae3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <135941df-2f8b-4fd5-91c7-40b413e6eae3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/1/24 18:09, Thomas Huth wrote:
> On 25/01/2024 17.56, Philippe Mathieu-Daudé wrote:
>> Mechanical patch produced running the command documented
>> in scripts/coccinelle/cpu_env.cocci_template header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---

>>   114 files changed, 273 insertions(+), 548 deletions(-)
> 
> A huge patch ... I wonder whether it would make sense to split it up by 
> target architecture to ease the review?
> 
> ...
>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>> index a8d014d09a..eb0613bfbe 100644
>> --- a/hw/i386/vmmouse.c
>> +++ b/hw/i386/vmmouse.c
>> @@ -74,8 +74,7 @@ struct VMMouseState {
>>   static void vmmouse_get_data(uint32_t *data)
>>   {
>> -    X86CPU *cpu = X86_CPU(current_cpu);
>> -    CPUX86State *env = &cpu->env;
>> +    CPUX86State *env = cpu_env(CPU(current_cpu));
> 
> No need for the CPU() cast here, current_cpu is already
> of type "CPUState *".

Yes, Paolo noticed and I fixed for v2.

> I'll stop here, please respin with the cpu_env(CPU(current_cpu)) fixed to
> cpu_env(current_cpu), and please split the patch by target CPU types.

Well I don't know, this is an reproducible mechanical patch..
But indeed as Paolo you found an optimization so worth not making
human review a pain.

I was about to post v2 but I'll see how to split.

Thanks for the review!

Phil.

