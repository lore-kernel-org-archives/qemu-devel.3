Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D6C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPbcx-0007Eo-2N; Fri, 05 Jul 2024 01:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPbcv-0007EY-Ur
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPbct-0004Ts-SB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720157814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRl2ojit9NvtghK0Bj/fvvr0pzZm3U6iOSQWZZBTNn8=;
 b=Sv7CMxEdfCmOhxVOjK2phKlqotHtua5aJHStEDbi+vOM8ztODcYNcqF5Y9pMQujpfXZdH9
 I5C0CCv7isNPavrINiwH9dDrNyhqu1GLvVkbJN7rZwKczUlFYGBPg1Jz1r4tFeda3EiXjg
 rCj96uXn2Hi2BgX/r1dMo8Q1hwRhcdY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-vwhe53yLMT-ncJ26oK2XjA-1; Fri, 05 Jul 2024 01:36:53 -0400
X-MC-Unique: vwhe53yLMT-ncJ26oK2XjA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79d586c5e9eso169702685a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 22:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720157812; x=1720762612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PRl2ojit9NvtghK0Bj/fvvr0pzZm3U6iOSQWZZBTNn8=;
 b=ErwVE2dPe57cRu3QbGWsbbADCj/ejcXTH6N44q5DOP/T7LLoG3w9u3lS8Xkn3Lllr9
 R3mtAQp83Tk2bXlDTJQAxG5OyzIrKRZ1/0imQiZIb+I4iix7zRc5q41Qix7AKJ69gio/
 a+w5NHd+jRZ3uPqZ186Ssbr4hjzzjcqQJUDGc8cjv8ltmLb28/9vAJT7scCcaLnJm8La
 e8QnCojbnH9H2NAVJo7SGywZdShtpBJI4atigsNPO6vO5aEUroyZJ3eN0+XNp6yKnFxT
 8ojwMGQN3kONVuWMFo9ZxZJNn55G92Q/6qwH6BrnZthvbzOPhETB46IgthRzBBK0kmrT
 XNtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Py+k58LRvP9ELK3DhQdNGPo0lTOrOKGlDdV/OKO/yNyoe0DwVrp5w5xZc38OlLMLWH4kFxPdvpA/U8ACKVkOUef+TE8=
X-Gm-Message-State: AOJu0YwIcJnYJMUM8s7RskvGi8mxTBfSVEyRdo3UkSGFHR3nAINfJlKS
 xqr03BmOnsw7I+gT4fgFLsjTnqQg/Y2CBvVSi0y8Rh5cDsysK71d3aBlYMFzzO4aYf+LgEDfNiP
 DsCHF4rAii5Ax/6kH1IjPPJflRFomlZ3HxUCFZdCSRoY5e0eUsJIi
X-Received: by 2002:a05:620a:4627:b0:79d:582b:95b7 with SMTP id
 af79cd13be357-79eee273f8emr415180685a.52.1720157812618; 
 Thu, 04 Jul 2024 22:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH11AzuqfZnVJQTu9CB2Ko3sW0P5cakUSfFLkvIsuugMsCDawM9TnhTRwp9+AYX92Ia0c1M2g==
X-Received: by 2002:a05:620a:4627:b0:79d:582b:95b7 with SMTP id
 af79cd13be357-79eee273f8emr415180085a.52.1720157812322; 
 Thu, 04 Jul 2024 22:36:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d692f255esm740911785a.87.2024.07.04.22.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 22:36:51 -0700 (PDT)
Message-ID: <9d8e87ec-3f9b-48c8-8378-8102dacbc133@redhat.com>
Date: Fri, 5 Jul 2024 07:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] aspeed/scu: Add boot-from-eMMC HW strapping bit for
 AST2600 SoC
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-4-clg@redhat.com>
 <ba8b451ff51446c114fac96daa6e81abddf952a8.camel@codeconstruct.com.au>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ba8b451ff51446c114fac96daa6e81abddf952a8.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/5/24 5:36 AM, Andrew Jeffery wrote:
> On Thu, 2024-07-04 at 07:36 +0200, Cédric Le Goater wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> Bit SCU500[2] of the AST2600 controls the boot device of the SoC.
>>
>> Future changes will configure this bit to boot from eMMC disk images
>> specially built for this purpose.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/misc/aspeed_scu.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
>> index 58db28db45aa..c9f98c20ffd9 100644
>> --- a/include/hw/misc/aspeed_scu.h
>> +++ b/include/hw/misc/aspeed_scu.h
>> @@ -349,6 +349,10 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>>   #define SCU_AST2600_H_PLL_BYPASS_EN                        (0x1 << 24)
>>   #define SCU_AST2600_H_PLL_OFF                              (0x1 << 23)
>>   
>> +/* STRAP1 SCU500 */
>> +#define AST2600_HW_STRAP_BOOT_SRC_EMMC            (0x1 << 2)
>> +#define AST2600_HW_STRAP_BOOT_SRC_SPI             (0x0 << 2)
> 
> Maybe these should have a `SCU_` prefix for consistency?

Yep. I agree.  
> Anyway:
> 
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 


Thanks,

C.



