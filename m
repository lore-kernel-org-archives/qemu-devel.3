Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDCBC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz67-0007Wp-3V; Wed, 20 Mar 2024 12:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmz65-0007WD-3h
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:47:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmz60-0001Nm-5b
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:47:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ed4d8e9edso2279f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953238; x=1711558038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f28Lgve7cs5P6UUvlZuM8MvqzXkoUlGVTVgJRaeDumw=;
 b=bSpX+hrZWSnwmuZ9Uoy6OIphsXexWaLIffQo5OZPJhlv0hyaxOw5iOCmkKHJ0Dn9d0
 2pyipC+a66Pex7qTfXU4s37psxVzOnhWtPO5bpdBmPKd+L+0JZXA0EXU9hpa2pnx+ttE
 XhlGFCYWaZlCXW8T89SxRJwih6d/aA7ZhthIVFl25F56wlq8gZcVaVlHazr1TLRT4V8o
 jzcGsEdD1oC2nDHT0rR/Bp+AMCTFdiCVa56J9TqeWF4Q8WgWDTRyXiUWKCBYVo+XxVWw
 s2U3oBAx+kQzqnkadv4dXOA+1ZyWjDds1hmPab8pU+RKzlxabdLPyS8fxzC/PURLRLvg
 yb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953238; x=1711558038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f28Lgve7cs5P6UUvlZuM8MvqzXkoUlGVTVgJRaeDumw=;
 b=cMLiTOxF1jx3eKCSmYG7x9ekhcVzCRRsNW+DLw/8Fw0lcdbopVUZcuaGP8JMpWwuYV
 FhRoVSWkcl+bTI07R4WOvCMTMNK0nNPeG047faFIXmWG9elN8y57QKPW6RAx91B2Zj3m
 FXh5rU4YkzBI6b7xE0O/NY85uaVrgn7FA+aN+9LwLRbOcvzlJfnBjZ5Uy1FzzgH/M6Mu
 PeOqf/gyoc/q0OxuL5DgwT2xGpnBDFhEbMVPa/vycxWw4Tl0LsNuLxSarMHk+vTgQlxk
 wDwe953YLsyb2libpykpUOAx27I+a1OyX6aP7Z+QGTZ93K/jWUZV3rPd8WyYcV0d/C4W
 dTaA==
X-Gm-Message-State: AOJu0YwALVRDn6QjM+9qWa3bvaHye/QEfAz1MkcMAknxOM/33QmoG+Qy
 AZQ+nE5GCLP1fnHo2PAo7boonAmWHGfNFjY3IXLALYoSf68lVO5Ds7oCjBPi4zI=
X-Google-Smtp-Source: AGHT+IHQt7tMeDI1IZ4ADzjhPkFE0HsMdCGGe9U4nc+Ahw1xVybgLb7OZCBz9I3oukmJJeSIDWV6sg==
X-Received: by 2002:a5d:6505:0:b0:33e:1e0:2679 with SMTP id
 x5-20020a5d6505000000b0033e01e02679mr12789608wru.47.1710953238539; 
 Wed, 20 Mar 2024 09:47:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 bq24-20020a5d5a18000000b0033ed8643638sm11860260wrb.106.2024.03.20.09.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:47:18 -0700 (PDT)
Message-ID: <52f35af0-4b18-48c8-8e18-aa7b01f53848@linaro.org>
Date: Wed, 20 Mar 2024 17:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_handler()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-4-philmd@linaro.org>
 <CAFEAcA9kVkM16paZQfH1voNNjWRT3DmchepiMs045w+YA61Fzw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9kVkM16paZQfH1voNNjWRT3DmchepiMs045w+YA61Fzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/3/24 14:23, Peter Maydell wrote:
> On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Only s390x was using the 'cpu_index' argument, but since the
>> previous commit it isn't anymore (it use the first cpu).
>> Since this argument is now completely unused, remove it. Have
>> the callback return a boolean indicating failure.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/nmi.h           | 11 ++++++++++-
>>   hw/core/nmi.c              |  3 +--
>>   hw/hppa/machine.c          |  8 +++++---
>>   hw/i386/x86.c              |  7 ++++---
>>   hw/intc/m68k_irqc.c        |  6 ++++--
>>   hw/m68k/q800-glue.c        |  6 ++++--
>>   hw/misc/macio/gpio.c       |  6 ++++--
>>   hw/ppc/pnv.c               |  6 ++++--
>>   hw/ppc/spapr.c             |  6 ++++--
>>   hw/s390x/s390-virtio-ccw.c |  6 ++++--
>>   10 files changed, 44 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
>> index fff41bebc6..c70db941c9 100644
>> --- a/include/hw/nmi.h
>> +++ b/include/hw/nmi.h
>> @@ -37,7 +37,16 @@ typedef struct NMIState NMIState;
>>   struct NMIClass {
>>       InterfaceClass parent_class;
>>
>> -    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
>> +    /**
>> +     * nmi_handler: Callback to handle NMI notifications.
>> +     *
>> +     * @n: Class #NMIState state
>> +     * @errp: pointer to error object
>> +     *
>> +     * On success, return %true.
>> +     * On failure, store an error through @errp and return %false.
>> +     */
>> +    bool (*nmi_handler)(NMIState *n, Error **errp);
> 
> Any particular reason to change the method name here?
> 
> Do we really need to indicate failure both through the bool return
> and the Error** ?

No, but this is the style *recommended* by the Error API since
commit e3fe3988d7 ("error: Document Error API usage rules"):

     error: Document Error API usage rules

     This merely codifies existing practice, with one exception: the rule
     advising against returning void, where existing practice is mixed.

     When the Error API was created, we adopted the (unwritten) rule to
     return void when the function returns no useful value on success,
     unlike GError, which recommends to return true on success and false
     on error then.

     [...]

     Make the rule advising against returning void official by putting it
     in writing.  This will hopefully reduce confusion.

   * - Whenever practical, also return a value that indicates success /
   *   failure.  This can make the error checking more concise, and can
   *   avoid useless error object creation and destruction.  Note that
   *   we still have many functions returning void.  We recommend
   *   • bool-valued functions return true on success / false on failure,
   *   • pointer-valued functions return non-null / null pointer, and
   *   • integer-valued functions return non-negative / negative.

Anyway I'll respin removing @cpu_index as a single change :)

