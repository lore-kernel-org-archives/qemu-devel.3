Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtym-0003VW-1y; Wed, 20 Mar 2024 07:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtyi-0003SR-SX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:19:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtyh-0000k9-9n
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:19:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e1d327595so4371097f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710933565; x=1711538365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lj+zkkGMQz/HhiRz/nq+wThBF91u9rXrZSwBR5Boelc=;
 b=DmgnqaqC9tmmN6gX+VaBV5Zq1TDO9xTg4T9A6zsC7DyyWqLQ47WTDTmeE8XH6ISY9z
 8md5N8O8OtV9cxCuCj+DReNbsseqS+qaY6kag7PNx61XA8+VCfXBNhFkPaO4XziYefZL
 toea5ovJ7bvMSX0z61fjg7UR/2PRm26GTlE+THB8ITGjSrJfgPhP8UVG4CvOfvLSf8fo
 v++hX7mOMhLlSeo1SlAY7KVeyNGX/K1++CUTm9tRiMzmY2asu3863QWSfvT/s3KHR45u
 XnuK9yVKed5jkWl+F1VtNhgXipgWedpF4t1pflSUyKSwLZKJZGQ/j3opgG69oE5FT/c2
 0rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710933565; x=1711538365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lj+zkkGMQz/HhiRz/nq+wThBF91u9rXrZSwBR5Boelc=;
 b=SnANtrAU/5wkb1s7hvoAXQLuNXJOt60OQ5YXRy13NGRZFKzzvOwwMzIi/0JGttLoNg
 OUWrkyzzjRejjUlDHgC8z4MLRgt/oLaBFyw0bkUdD0ouRS2Kb0RYOsTxul2KgXvfELbm
 zS16EIQoqTxkMw8O2Q6CQLPLfIUOywY2gi2wIM6DTQC8CjZYFmsdR2Cg4WhOrHJmfx2e
 DVrlBEVKTmWHUxj0pdQJh2BOQXvQIcjuXkCrBZd3MyUO7J5fAOvwEd4q8fj+FbUI4It3
 LOxmNIKZfl7KOUXiiWjePudvtAnR9fPJVG51L1GerQUxrDkvv6K1dn3mCsEE5Q0LmKwY
 pkgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn0rIbGkNb0NWNYCOefw4Lc01ldk2mmnuqYeVXIaWCL6m8l6NSJEoKm9nV25RDlcNscZzrV0aOdLzxbzql8fXA+N8kTPg=
X-Gm-Message-State: AOJu0YyPEqgZ6ct0jW2lEghGP8/TgYShj9xnJ4GphPnzaA8MI1eQ7m5K
 1tjwmHpdQ7JGMNBq05GJSIXCcO51u94dP5hv+Zh73xC1JWRC6BJ9IHeiYfS+a40pmD/Bg0gueO4
 m
X-Google-Smtp-Source: AGHT+IF/KDpLEbAehUpiGLGYeeZS99BJqd/1yYJFkH627MblSe/TuguMHn7kLvvhZRlp/LXgs4rmlw==
X-Received: by 2002:adf:e5d1:0:b0:33e:c604:dd3a with SMTP id
 a17-20020adfe5d1000000b0033ec604dd3amr9573447wrn.58.1710933565334; 
 Wed, 20 Mar 2024 04:19:25 -0700 (PDT)
Received: from [192.168.64.175] ([92.88.170.201])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a5d49d1000000b0033ec91c9eadsm14583999wrs.53.2024.03.20.04.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 04:19:24 -0700 (PDT)
Message-ID: <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
Date: Wed, 20 Mar 2024 12:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 16:19, Thomas Huth wrote:
> On 20/02/2024 16.08, Philippe Mathieu-Daudé wrote:
>> Have s390x always deliver NMI to the first CPU,
>> remove the @cpu_index argument from handler,
>> rename API as nmi_trigger() (not monitor specific).
> 
> Could you please add some rationale here why this is needed / desired?

I'm not sure it is desired... I'm trying to get the NMI delivery
working in heterogeneous machine, but now I'm wondering whether
hw/core/nmi.c was designed with that in mind or likely not.

I suppose in a complex machine you explicitly wire IRQ lines such
NMI, so they are delivered to a particular INTC or CPU core, and
there is no "broadcast this signal to all listeners registered
for NMI events".

> 
> Thanks,
>   Thomas
> 
> 
>> Philippe Mathieu-Daudé (4):
>>    hw/nmi: Use object_child_foreach_recursive() in nmi_children()
>>    hw/s390x/virtio-ccw: Always deliver NMI to first CPU
>>    hw/nmi: Remove @cpu_index argument from NMIClass::nmi_handler()
>>    hw/nmi: Remove @cpu_index argument from nmi_trigger()


