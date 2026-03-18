Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D6510775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2upf-0007Jm-6x; Wed, 18 Mar 2026 13:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2upa-0007H5-CQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:37:18 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2upQ-0002MO-NC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:37:15 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso155636a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773855426; x=1774460226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zj10rYnO+npsJslo1dI9gtLqeH8twmoLY57z6+6WU8A=;
 b=WVonlLDRTvvNiAYAna/1ESqY7W78MHuRC2YAVEujAfKVGNJWSODoo8UL0ypj68osW6
 7IAkxFlCQZoKUpf7w6CUMC82x+dpVdM7NUZKhZGgMlAZ67tdflmDVNPDyBQM+1qpgCFn
 1UQXbf3+wHE3vXCzVxxsXcoL2ulFQSWIq5MnCiP9pvKR/RqPqIFbNZ50h7+7KtehQ437
 sQLrxzcxaqnE1+BWo/4z/whlA9u/GhIZX1s5OPc1wDIQcP3iBuvZB+kkbS1r1kJiheEN
 xjDbQR2MxnQj87+Qfjj/RWs2uy/GGvE8bspDca9k9TBZxnlHEDbyAtn54695qr+L8ypP
 0X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773855426; x=1774460226;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zj10rYnO+npsJslo1dI9gtLqeH8twmoLY57z6+6WU8A=;
 b=BlZpJ7SpzZIiKTME2S0Mpl6ROyCeEbDz6r5QJUVbngoP3kBuFhs+Tj7LUxAvAyCeVq
 nQSx6ATo+xeWtFcmd9Ld+riR7Az/gqFBNS2UHg3701PRskso4fooaRYxE8B3rFe+650b
 c/wbGSmtKFDcfcl6TKbcZe5LN7JQ8T1yL6Wu3UKormg4TYKZej3zhc7wmfbtMKUmt4jL
 O1exEAyiRtSor8BEoiPsEvi07xPaVYk2xPGtv5nP1EcqV5GvBPhgPTKYyYI2Gk/fsAjG
 BgiestvvdZlUmsH/7Cme+EPDb/qu0NJ9wWPygqF7Q0mbq6COZeXMoo61xr9wMMnAGGUi
 VKtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxwz+1TL9PexEKXjoGOdEaxAzyZH1wY4xYl0zU+5Zvv0qb0kJPbJGB75SVw3CsbaMwQIU9UOGRhnnA@nongnu.org
X-Gm-Message-State: AOJu0Ywf4EPtGZiaUFVNzeMHsd/dSliyQENVFWpNv+Qq+hCv5FSWT4rc
 YASFgLuy8kMAUOzIT8ukTUbiidYFeiAM8pwzYf4kzXQmT7Vyh/WXjTXoz76/EcXidgc=
X-Gm-Gg: ATEYQzwq/Awc3Y5XJfFM97OuzOA+OaEWf3WIL8tDSz8CjNlsKM/iFt/4rrxlSEfQoU2
 ls58/k2Z8WQDDcYsW3Dp7iqDlt7SGNl+GmIs210n2VPXrOCEz09au80NDo2bGZcvCLQGZAGJ090
 4psKiPmJJzyBbknhOxBo9q9IlsZalyGEjCJVZ4Ze8aFDRLRFKCxe7Ofsw1eQBnDysbgeyXQlCfu
 WwktRJMBNdyj2Q8heL7GhvESOg8G0sG/3Q5Wvoo+zgodEHoiO7Y+GGS4RMUMPVXs9J8KvTexNmS
 yAUaujgN5hYbn7BgAYGLQM8yzI18UiHf2vWskUd2jLvAFPaIhdiTl2V1MxwmvipWrRPUx37LmrB
 u+9NT4+36ZuxuxLLZi/wxTihh20ttEXCFPwaKLng0yt+T+KHOVu1WFm4NVnBtqkKiv5GsQzZ0Tt
 FKpHRSgU/AQ95bCHaDB5THhgIuo9FsWWp+T6tnFsQ3otWKjlwTja6a6Yv5N8oobYugl75g
X-Received: by 2002:a17:90b:3b89:b0:353:356c:6821 with SMTP id
 98e67ed59e1d1-35bb9e9cfadmr3704088a91.8.1773855426151; 
 Wed, 18 Mar 2026 10:37:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc62f8e6bsm176419a91.10.2026.03.18.10.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 10:37:05 -0700 (PDT)
Message-ID: <de24b377-1c7f-426d-b31d-16b1879ad813@linaro.org>
Date: Wed, 18 Mar 2026 10:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-4-pierrick.bouvier@linaro.org>
 <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/18/26 1:11 AM, Cédric Le Goater wrote:
> On 3/17/26 20:42, Pierrick Bouvier wrote:
>> Add stubs for needed functions.
>>
>> As well, we need to add pixman to qemuutil library dependencies since
>> pixman is transitively included from pci.h header, which is needed to be
>> able to include prototypes for stubs we declared.
>> In file included from include/ui/console.h:4,
>>                    from ../hw/vfio/vfio-display.h:12,
>>                    from ../hw/vfio/pci.h:25,
>>                    from ../hw/vfio/igd-stubs.c:9:
>> include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or directory
>>      10 | #include <pixman.h>
>>         |          ^~~~~~~~~~
>>
>> On OpenBSD, opengl headers are not available in default include path,
>> and thus we need to add opengl to list of qemuutil dependencies.
>> In file included from /home/root/qemu/include/ui/console.h:9:
>> /home/root/qemu/include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h' file not found
>>
>> Finally, vfio_pci_hot_reset_info must be forwarded declared on non linux
>> platforms:
>> In file included from ../hw/vfio/igd-stubs.c:9:
>> ../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>     265 |                                     struct vfio_pci_hot_reset_info **info_p);
>>         |
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Duplicated Signed-off-by. I can fix when applying.
>

Oops, that's a rebase mistake. thanks!

> Thanks,
> 
> C.
>

