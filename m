Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D55EE499C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 18:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soRv0-0000gH-9K; Wed, 11 Sep 2024 14:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1soRuy-0000fN-Fa; Wed, 11 Sep 2024 14:18:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1soRuw-0008EL-DI; Wed, 11 Sep 2024 14:18:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2068acc8a4fso1775885ad.1; 
 Wed, 11 Sep 2024 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726078692; x=1726683492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=aU6cUFmJn2TSCpp8MFgH7cqN0UnokgM82lvJ0ZpWykk=;
 b=Lqk5An8vvdyENPJHRcOj7TkDEEn99LaY+zwun7wzOqXDqWWJMR2dEQw6W6A+cGL2Fe
 dtMzRGLLXgOOfW4xO8zhG+amz6JWpV0IkGA79DEzr7QB/g7Y07oSjkplLUL75VGe4vQQ
 MWJ5UkDdAXHkBc9nFCaUMeobIBGUAzxfEjDnZcB0Pv1wtjxEVPCPy/XgtFM6eAcRBUrf
 ycKN+K6LyZVyvoQsd0kIGfmXIgPNSshMhNIrvBrx5ehAGvNmNJR6dgxS5Uuj/KoJ/P+t
 zMXTzunbFoXgymNj1EuWjOUEelTJVTXhnp5GjqnimL7KsislI5IpVGkoGWcE9BDuhhAO
 JVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726078692; x=1726683492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aU6cUFmJn2TSCpp8MFgH7cqN0UnokgM82lvJ0ZpWykk=;
 b=KWlkJaV9i6ygZQBIC/a0rghZn7YvDe1FXZokXNMvz4AoP5hcxrDSEm+LprHXF3vbxw
 xRGTP+WCDUNQc7PR9X7ePxXbg8yCeAVqeg+JmzG8pN9lwQlMZ3by5qHpg4PKqKRsi5EJ
 XT7xHSeb+EmwwgkX5lqbcru4pJ52LLvKHRvRvLSbfvdSKXUQ2j5f9p4+LzUwr5lMDsJ+
 6fKEd0g9VXcxSFqS6HHiMLGv1AmweMWUEhwTooQmzgpe9iHewwqe5YbixMp1O2tpW2ry
 vK2WPCtEP4UTEDUOhvj4MgjcxrECrNKH5QlYR3BTO0p/JU+wVK8ka4ZFcAB91q4gDeou
 i9sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqltPOIANtYqztz470dQJrRbWorUPYSuYAWcEsIG3pQ3ugijdaex8FVqjFylt3RsBNSvrUJ607/Sa7@nongnu.org
X-Gm-Message-State: AOJu0YyfbprdcaM5ZE64w0JqwzkztCU1FFWLIai+EU98f+8f4/1elM93
 bxv5B80/Kd415YS+6+61af99huaOSm+4GfiuYSTEJPVLTQMk12SGz6YWSA==
X-Google-Smtp-Source: AGHT+IE4I0I3Szfcb5n5161PzJYlxZNyknUoqZX3kL+JwU7aWqCga+aii1KFd/tEvzOed5LjBzDOeg==
X-Received: by 2002:a17:902:dacf:b0:205:8b84:d60c with SMTP id
 d9443c01a7336-2076e3998damr2986185ad.35.1726078691991; 
 Wed, 11 Sep 2024 11:18:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076af253a8sm2550655ad.51.2024.09.11.11.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 11:18:10 -0700 (PDT)
Message-ID: <5d9ff62f-d8d3-4a88-a74c-0013e9a58dfd@roeck-us.net>
Date: Wed, 11 Sep 2024 11:18:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
 <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
 <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
 <bdb443f9-376e-4d4e-8c06-9ba0c5482c5e@redhat.com>
 <09457da7-e692-4d9f-92b8-361f14b7a1c2@roeck-us.net>
 <CACPK8XfqOE-GJWgUwC+Kh5r9nT2Jo42R2zdka54sURDiR70j5A@mail.gmail.com>
 <b9b2d800-38d6-4fa6-9ac3-9604fb6f9ff2@roeck-us.net>
 <6beb87db-d963-48fe-88ee-abc4f55dd3d9@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6beb87db-d963-48fe-88ee-abc4f55dd3d9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/11/24 10:33, Cédric Le Goater wrote:
> On 9/9/24 17:10, Guenter Roeck wrote:
>> On 9/9/24 04:20, Joel Stanley wrote:
>>> On Sat, 31 Aug 2024 at 05:41, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Fri, Aug 30, 2024 at 10:09:25AM +0200, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>>
>>>>>>>> I solved the problem by adding support for IBM Bonnell (which instantiates
>>>>>>>> the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
>>>>>>>> copy of qemu.
>>>>>>>
>>>>>>> Hmm, did you copy the rainier-bmc machine definition ?
>>>>>>>
>>>>>> For aspeed_machine_bonnell_class_init(), pretty much yes, since I don't know
>>>>>> the actual hardware. For I2C initialization I used the devicetree file.
>>>>>> You can find the patch in the master-local or v9.1.0-local branches
>>>>>> of my qemu clone at https://github.com/groeck/qemu if you are interested.
>>>>>
>>>>> Oh nice ! Let's merge the IBM Bonnell machine. We can ask IBM to help fixing
>>>>> the definitions (strapping). Enabling the PCA9554 is good to have too.
>>>
>>> Instead of adding Bonnell to qemu, could we use the Rainier machine? I
>>> know the kernel device tree removed the i2c tpm, but there's no harm
>>> in it being present in the qemu machine.
>>>
>>> The bonnell device tree should boot fine on the rainier machine for
>>> your purposes.
>>>
>>
>> Yes, I confirmed that works. Ok, I'll do that.
> 
> So I will drop the bonnell to avoid redundancy. Is that OK ?
> 
Ok with me.

Guenter



