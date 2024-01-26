Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4734C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNNd-0000kG-Rf; Fri, 26 Jan 2024 09:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNNS-0000jD-H6
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNNQ-0000tq-4y
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706280014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lGdCLCAFhzxGZy+vKK0dVykqjUNjWVDHRNUj1FjAZBY=;
 b=GgsRFzBc4WKNgMyhBWZr5ccfDAg3wVEftB9HlwIur48rMuYiAScac/FBF4NyZrPJsZKdj6
 SMFrJINO7+McHvFL8VurRjha4bZcamgekfepsV/WhxDg9Pq6Q1+UJzi85K7DgflCCrPqdW
 Wu0J+6UguUophAfqyM9SJIhcE7blLMc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-6Xz-QpfpM5Okx8auFeaJ9w-1; Fri, 26 Jan 2024 09:40:13 -0500
X-MC-Unique: 6Xz-QpfpM5Okx8auFeaJ9w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-685c9384ecdso5193096d6.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280012; x=1706884812;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lGdCLCAFhzxGZy+vKK0dVykqjUNjWVDHRNUj1FjAZBY=;
 b=T8Kd4//iAIGPJOQSq/DewljQPC0P4+PEPn+EtOjiAjyXQbVOtPs4LeO+3JrutTWk8e
 1PVRyVhVwaHAD7P4agRyiOGuAt5htyvny17YpTikz09dkZBRC7yE6Zqa/3beCusyWPZP
 KPvqBr05pKiri28ue6Oscihgt6xt+xdJXb4dof1yNXZf2q6nVtf0KJO/Lq6W7WPe8juK
 +DGy/OzLBnHeeYnplTRt7EGkGTkvslq9SouhAfORaRYHXFqsnOCB7+IwKy0jPBvv+PIy
 Xi/uvrc1cXp16tfozGTxLJ/7qTITfAqarx/Grr7k/ALZ1T24EHHXwM9MPbaRA0IleeN8
 etrg==
X-Gm-Message-State: AOJu0YzvZqso4qYHMWyuEFPr1PUzghiRol1z656+oOg9hwNYqLXdH1df
 /Ltn+dlV5mfiA4i7DJ5uS2zzPBfYB+qHeeXwVhW/9KwS5lWsQCfmdaeqcPLHaEpvwpFCs/S2G6g
 Xcl7UgVbpZr8GhUoqej/H8AbXQLCsnZ/q1lFtxNZXo6lpNGWUy0il
X-Received: by 2002:a05:6214:2427:b0:683:c2b7:bee8 with SMTP id
 gy7-20020a056214242700b00683c2b7bee8mr1913073qvb.72.1706280012571; 
 Fri, 26 Jan 2024 06:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4AmBMkX6eIgFaMDf5jvVBNtU3kFgID2kR6VXcPzKNnuP5oFOc3Mgv/LdMR4JZQkSviiTu6Q==
X-Received: by 2002:a05:6214:2427:b0:683:c2b7:bee8 with SMTP id
 gy7-20020a056214242700b00683c2b7bee8mr1913006qvb.72.1706280012246; 
 Fri, 26 Jan 2024 06:40:12 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 qj10-20020a056214320a00b00680d39626fcsm555489qvb.47.2024.01.26.06.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 06:40:11 -0800 (PST)
Message-ID: <c9b9e382-fd31-429f-b4e1-cd01e751d871@redhat.com>
Date: Fri, 26 Jan 2024 15:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/46] net: add qemu_{configure, create}_nic_device(), 
 qemu_find_nic_info()
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
 <20240108204909.564514-2-dwmw2@infradead.org>
 <9218c20b-8ba8-402b-bea5-856cb51156dc@redhat.com>
 <0914e6a51218793cca3121879ef21b39d9aac612.camel@infradead.org>
 <72f116bd-f9ce-4d61-bb21-b615f15eb4b1@redhat.com>
 <20c19bd1f19ebc2b1c0100f447a709dda076f721.camel@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20c19bd1f19ebc2b1c0100f447a709dda076f721.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/01/2024 15.34, David Woodhouse wrote:
> On Fri, 2024-01-26 at 15:24 +0100, Thomas Huth wrote:
>> On 26/01/2024 15.16, David Woodhouse wrote:
>>> On Fri, 2024-01-26 at 12:10 +0100, Thomas Huth wrote:
>>>>
>>>>> +/* "Please create a device, if you have a configuration for it" */
>>>>> +DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
>>>>> +                                    const char *alias)
>>>>> +{
>>>>> +    NICInfo *nd = qemu_find_nic_info(typename, match_default, alias);
>>>>> +    DeviceState *dev;
>>>>> +
>>>>> +    if (!nd) {
>>>>> +        return NULL;
>>>>> +    }
>>>>
>>>> The qemu_check_nic_model() function that was used in some code that you
>>>> turned into qemu_create_nic_device() used to set:
>>>>
>>>>        if (!nd->model)
>>>>            nd->model = g_strdup(default_model);
>>>>
>>>> (in the qemu_find_nic_model() function that has been called by
>>>> qemu_check_nic_model())
>>>>
>>>> Should we do that also here to make sure that nd->model is not NULL afterwards?
>>>
>>> Good question, but I don't think we care. The qdev_set_nic_properties()
>>> function certainly doesn't propagate nd->model to anywhere.
>>>
>>> I renamed nd->model to nd->modelname in a patch shown below, just to be
>>> 100% sure I'm not missing any other code paths which might consume it.
>>
>> Ok, thanks for checking! Maybe mention it in the patch description in v4, so
>> that we've got it recorded somewhere that nd->model might be left at NULL
>> afterwards, but that there are no further consumers, so it should be fine.
> 
> Makes sense.
> 
> https://git.infradead.org/?p=users/dwmw2/qemu.git;a=commitdiff;h=694f82bc09080
> now says:
> 
> 
> net: add qemu_{configure,create}_nic_device(), qemu_find_nic_info()
> 
> Most code which directly accesses nd_table[] and nb_nics uses them for
> one of two things. Either "I have created a NIC device and I'd like a
> configuration for it", or "I will create a NIC device *if* there is a
> configuration for it".  With some variants on the theme around whether
> they actually *check* if the model specified in the configuration is
> the right one.
> 
> Provide functions which perform both of those, allowing platforms to
> be a little more consistent and as a step towards making nd_table[]
> and nb_nics private to the net code.
> 
> One might argue that platforms ought to be consistent about whether
> they create the unconfigured devices or not, but making significant
> user-visible changes is explicitly *not* the intent right now.
> 
> The new functions leave the 'model' field of the NICInfo as NULL after
> using it for the default NIC model, unlike the qemu_check_nic_model()
> function which does set nd->model to match default_model explicitly.
> This is acceptable because there is no code which consumes nd->model
> except this NIC-matching code in net/net.c, and no reasonable excuse
> for any code wanting to use nd->model in future.

With that feel free to add:
Reviewed-by: Thomas Huth <thuth@redhat.com>



