Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D557ACAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v238P-00086P-NM; Fri, 26 Sep 2025 03:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v238J-00083U-0b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2389-0004PC-5m
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758872667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AI7sUTUKoL7AYrFNlqLqmbps8zGiAH4x6BVDovmGhOc=;
 b=V9jG5dZ5Tib8dvPyrt+U2OQFYhU8BJEjyg8qVRdJsyyAO5xEFR4cv/zlm+Fs00cUjK9Lp6
 mMT45DzuFxvTBxkwRhIOlTfKRNn5PdeA7tElw5B3nTuiiS3sSqtgW8xaWKb/rYlDhNXCQQ
 bE413Z4aLx3h3L3VuAjVBFUpnCNXpR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-1XBsSgStNoy6qoVS_raRcA-1; Fri, 26 Sep 2025 03:44:25 -0400
X-MC-Unique: 1XBsSgStNoy6qoVS_raRcA-1
X-Mimecast-MFC-AGG-ID: 1XBsSgStNoy6qoVS_raRcA_1758872664
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e31191379so11987985e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758872664; x=1759477464;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AI7sUTUKoL7AYrFNlqLqmbps8zGiAH4x6BVDovmGhOc=;
 b=lxciNi+ddFnpFsPrnNoctmHsGi1DPFZBgENIsSY38cDilEikGjtHA59+LsEaLDjsOy
 mZl8h7RswyGLRhbnZSRuCZkW6w7NTqYFl+Tu3mQhzazV1BtBIP0ihq4ip1ynAzy5mrka
 oFCKoXSCJS6hVzv7H+o98Tauz+9j93MrmkkBEfr5d8qIUcHtN6yRP+aGR148apIfQiW6
 n6ghMqulIsj3SAFOvES2P66Sg5c+C26aDMdbZWKblJDbwYoC0zeVePJrip0kie/l5qL9
 MpwxZQUCjaCc7tXwhtgqOei6pt4zerO+kWbG1r8ZIhbLuXxV7/XT1ux1fDiUuqn/+l02
 GSbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmkgkBaFLn5qrTYj7703H14JPnbF60p9Jwfxi/RD87FR8Gy3Li8gyverwnjH9VKfl11Elq5duISN52@nongnu.org
X-Gm-Message-State: AOJu0YyiDGDVoEXGWXVljmlb06c4HZdot9/lNYLPM9VFbGIXG8q+vOgQ
 eI4NFtHsOREKDAzXuG/qugz+3k/3avScMhbs2UMNgtz+EgwURYx3RtXKEHPMqdqG09YivX3dqyx
 SpssW6PnWqM36VQ5OQWpi85yJYfQXNGoSQTSmiEOl8qHYt7YQqK1Gb4RB
X-Gm-Gg: ASbGncucGwUjndSJNYzMqloVUlLs7VNKLE3JvZgFyuG9pwbK8xWVeH643bACUMevyx7
 LLiGw+DMDkuh+s2Nlnyu1Mn828NCobTy6Ig5MtelYS18TOA3L4QNYt9EYyuc8esbPNddbc94ML+
 aa8jeY7FEstWvIM9NLurRYSBHT1U94bveXOoVSD2ROGadrWo5GTmpjIRuQItnukMTlAGy9qNPGr
 F7eV26AasyfEWOZyql5ocbrDbdTKAne6bLOkaqmhiQh37h0FIB97MliKnw+AkCmwzBUKHMeuMqj
 wNz50OcjEl4yGyjfsSm56Zd94K/Jf2rnXOGDobdjdITqS9cKakHrY3gDdiT/OP6EJm6Ia7JNxV7
 D/pY=
X-Received: by 2002:a05:600c:4f56:b0:46e:2c37:7474 with SMTP id
 5b1f17b1804b1-46e32a032dcmr75074965e9.31.1758872664246; 
 Fri, 26 Sep 2025 00:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFajnTc2tbRwH57O/k8NRRvV5Zcc/S8J2wU5L6Q+LKIw7v1sR259zv3kF7ZnHD5RAOFC+9zbA==
X-Received: by 2002:a05:600c:4f56:b0:46e:2c37:7474 with SMTP id
 5b1f17b1804b1-46e32a032dcmr75074715e9.31.1758872663867; 
 Fri, 26 Sep 2025 00:44:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e330db1a6sm33227425e9.3.2025.09.26.00.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:44:23 -0700 (PDT)
Message-ID: <dd378cbb-4876-496f-a079-1b8f1cecba79@redhat.com>
Date: Fri, 26 Sep 2025 09:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP and
 ensure correct device realization order
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
 <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
 <SI2PR06MB504175E8604D90397E631042FC1CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <078f252f-774b-47f8-bf94-6b1de8e70359@redhat.com>
 <SI2PR06MB50413935D3232A7618C71605FC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SEYPR06MB5037311A981103C166149A94FC1EA@SEYPR06MB5037.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SEYPR06MB5037311A981103C166149A94FC1EA@SEYPR06MB5037.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Jamin,

On 9/26/25 05:13, Jamin Lin wrote:
> Hi Cédric
> 
>>>>>> 3. Migrate all ASPEED coprocessors (e.g. SSP/TSP) to a common
>>>>> AspeedCoprocessorState.
>>>>>
>>>>> Is 'AspeedCoprocessorState' a new model structure minimizing the
>>>>> number of sub controllers ? if so, looks good. Could be merged fairly
>> quickly.
>>>>>
>>>>
>>>> Yes, I am planning to use the new AspeedCoprocessorState instead of
>>> AspeedSoCState for SSP and TSP.
>>>> struct Aspeed27x0SSPSoCState {
>>>>       AspeedSoCState parent;  -------> Change to AspeedCoprocessorState
>>>>       AspeedINTCState intc[2];
>>>>       UnimplementedDeviceState ipc[2];
>>>>       UnimplementedDeviceState scuio;
>>>>
>>>>       ARMv7MState armv7m;
>>>> };
>>>>
>>>> struct Aspeed27x0TSPSoCState {
>>>>       AspeedSoCState parent;  -------> Change to AspeedCoprocessorState
>>>>       AspeedINTCState intc[2];
>>>>       UnimplementedDeviceState ipc[2];
>>>>       UnimplementedDeviceState scuio;
>>>>
>>>>       ARMv7MState armv7m;
>>>> };
>>>> This change consolidates SSP and TSP under a common coprocessor
>>>> model, reducing duplication and aligning them with the new
>>> AspeedCoprocessorState abstraction.
>>>
>>> Aspeed27x0TSPSoCState and Aspeed27x0SSPSoCState look similar. Could
>>> they be merged ?
>>>
>> Thanks for your suggestion.
>> Will try it.
>> Jamin
>>> Thanks,
> 
> I am considering making the following APIs common so that both the Coprocessor and SoC can use them.
> 
> The Coprocessor state is AspeedCoprocessor
> The general SoC state is AspeedSoC

Yes. If you need a base class to maintain common routines, you could
introduce a parent too.

For rest, please send patches. I rather discuss on a proposal than on
an unrelated email.

Thanks,

C.



