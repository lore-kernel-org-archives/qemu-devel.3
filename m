Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59327C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpoEO-0002LT-Q7; Thu, 28 Mar 2024 07:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpoEN-0002L3-T8
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:47:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpoEM-0003kH-85
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:47:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56c3260a714so1080064a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711626456; x=1712231256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4AtBj66MJbdKBFZaSnAUUCmTDrgwtHXfJDqG5USEWME=;
 b=dRObrws+yUOprffVTwrU2AwIOizFZAuOAaabTttO0f8wxTIPqjIwtkpdjHFfQ5rCsm
 9orWw/+FxYSI0ya3p0t/kzGu0jQPv1kr4tGDpuFbDQAx0JM1vT4AvHYfzucKr6lgKtb6
 D17Z2DWPQvwrKeE9WOo0LQby7qzYScDpmt0/YtLkwMBTOHjD5YXP5HB03MOTwUEg/gh7
 dWaqB+r7fKUjpT02rR+b+VlFsqC8cmP15zAlg+pWOIbFK6yyM9TJse80hmLPzXIddSRD
 3Yu1Dy0x5mm45AYc6ADvpT9aThI9IGmkzKJp5OVIxdZ1OeM4PvfuA9ajio6HhFbMWBdJ
 fj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711626456; x=1712231256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4AtBj66MJbdKBFZaSnAUUCmTDrgwtHXfJDqG5USEWME=;
 b=Vd4VAleGAEw4ZRJCrLqEdgbj7IdJZloZdrqOCMs1UaZ/8y5T9Zr3SahrQdeyD3L6Ni
 vXfCF6uSnRrdAz4s8CAvIA9BugrmDc3gs4CNHAiHQ7c2C9co+yrorgN3I8NPDn3+jRm7
 5qzWK7eIaPVVfqOkqdPrxKZ2B+IIAsvtpNZMikU7oq+r+iQ6QE11Sn7mNiUMq6uwaprz
 INs958H1jMh9cxIZf+MbrRhwkavnMa6qBHEAFZnYCN3ClX2S0eAbAz1lmx5GCQJEeAUq
 abB0z9glhTp8d+lxYSNF54/JqwVf/dolzgZmrA1zdjw7VFiHIy2+5ishxvhlMXjmRjTx
 Sk4Q==
X-Gm-Message-State: AOJu0YyLQNd3DqicF+IAuxhYCLYXWGBjUeoTjIeH5W0yp+VrW/2vEMah
 qmqQygV6CNqlGc4vsz+zJdiXgqgkJ+4ZtgoYOUxJxIuguISlOmj9F+FGvQVZTzU=
X-Google-Smtp-Source: AGHT+IHOWX03Ac8Ij+YpOiGYzFFeumAtiE+ZyTgbmimPIehWQ2xS62EpoPWxx5TLIHzp7gvoYTyELg==
X-Received: by 2002:a50:d653:0:b0:568:b418:6999 with SMTP id
 c19-20020a50d653000000b00568b4186999mr1837472edj.16.1711626456566; 
 Thu, 28 Mar 2024 04:47:36 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 q4-20020aa7d444000000b00568d6a20717sm752546edr.52.2024.03.28.04.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 04:47:36 -0700 (PDT)
Message-ID: <5907ef17-f7f2-4204-a38d-887934004ac0@linaro.org>
Date: Thu, 28 Mar 2024 12:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 19/21] hw/i386/pc: Remove 2.3 and deprecate 2.4
 to 2.7 pc-i440fx machines
To: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-20-philmd@linaro.org> <ZgTnu5RlRYiSd++R@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZgTnu5RlRYiSd++R@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhao,

On 28/3/24 04:44, Zhao Liu wrote:
> Hi Philippe,
> 
> On Wed, Mar 27, 2024 at 10:51:21AM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 27 Mar 2024 10:51:21 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 v2 19/21] hw/i386/pc: Remove 2.3 and deprecate 2.4
>>   to 2.7 pc-i440fx machines
>> X-Mailer: git-send-email 2.41.0
>>
>> The pc-i440fx-2.3 machine was deprecated for the 8.2
>> release (see commit c7437f0ddb "docs/about: Mark the
>> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
>> time to remove it. Similarly to the cited commit,
>> deprecate the 2.4 to 2.7 machines.
> 
> I suggest split the deprecation of 2.4-2.7 in another patch.

Thomas suggested to do it in the same commit to avoid churn
in documentation:
https://lore.kernel.org/qemu-devel/2a01baa6-b6a3-4572-94cd-63b2eaab7b38@redhat.com/

> And when a old machine is marked as deprecated, is it necessary to
> set "deprecation_reason" as commit c7437f0ddb?

Indeed you are right, I forgot that.

> I tend to set that field since boards.h said:
> 
> /**
>   * MachineClass:
>   * @deprecation_reason: If set, the machine is marked as deprecated. The
>   *    string should provide some clear information about what to use instead.
>   *...
>   */
> 
> And that field would be printed when user boots the machine.
> 
> Additionally, could we define rules for deprecating old machines?
> For example, if it's more than 8 years old (as commit c7437f0ddb) or
> after how many releases, the old machine can be considered for
> deprecation.

Daniel recently (last 2 months) replied to a thread with a
coherent rule set, but I can't find it.

Older post:
https://lore.kernel.org/qemu-devel/YeXNoKzsFeIPSy6E@redhat.com/

> Thanks,
> Zhao
> 


