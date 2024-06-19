Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F2CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwgW-000171-28; Wed, 19 Jun 2024 10:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJwgU-00016t-4t
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJwgP-0007rC-OH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718808786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n2Kpt8fJBdOEwXt35JZ5EsgT8fl46K2U5CWU8pBbsO8=;
 b=B/W7iJWx7Qu2t1fft0lDXUmvlneGuvjIqvfWP8cRJiTCAu5+J9wA9BJsbScufZ7kKlrNZ6
 Yepz1+G5kWZH3VyhfgwB4DBp3bnRV0CpOvAgW5u7Jqm1Of62jCtb45sEMKDE1qL1b671g9
 +VasRbIVjC7UcDiy2grJKZgcst3OfbI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-DoUBOyjgNl6aE2Fir5ZPCg-1; Wed, 19 Jun 2024 10:53:04 -0400
X-MC-Unique: DoUBOyjgNl6aE2Fir5ZPCg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44212083709so19709461cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718808784; x=1719413584;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2Kpt8fJBdOEwXt35JZ5EsgT8fl46K2U5CWU8pBbsO8=;
 b=eBwzzF0Exs1vvfs8hQEtlq8cMmsBLs9wJgC2pnSzWuMtcjzEd1vz8+aZyhoZFzftAh
 7lJh9ivVzlCFrQF7O6OfY8tufB/RzopHAbtIIuiIAg+l3NGNY6y/zWV6M9NKk5ZegpP7
 7P2fYH4wUt/ls/P5VzB+/Ok9dtvJKBfKoe8Ibfh7aTNmxfDahZ8+2kHu+vzA9U2Cq4Qf
 wSjYeDpnmvbxRKfAit9R0xjwA+mBpUW19zbtnvzp15USXevWuiLPoTr+ehIMO84MPVji
 0dDHL3hEHMD+NywDtpLckjKz5QEj+oHcE583a0tmWxTxKMftb4Lk6lko2JFo5nzPcI4I
 ZV4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3NU5AeLCntJYDhqmQFFZPC01i3pzkZHe+nMUjAOZ9zMwln0ieRxchOkmsLOIPICT7x3n63xFYL21XC7KfpOQz2cBnmSg=
X-Gm-Message-State: AOJu0Yxk1ueZxAyITOAxeIQ/KZXMMUUiB2TbIgiWEEJ1e+AqpA5c4TdJ
 VPnK1DhnyVsnqRt13U9LQOIPgeRdiq+Nd1AiaDqS1Rkp1tZoaCPF0i6SCsAbk/hH7a4coo56MPy
 Ub0xUPQNn2FZjokWPssYqbqWv1HvD0Uq1ehSpwaX4hjAsO0rPg+sq
X-Received: by 2002:a05:622a:1189:b0:441:24e:6464 with SMTP id
 d75a77b69052e-4449b93f587mr91757641cf.14.1718808784135; 
 Wed, 19 Jun 2024 07:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXH0+5MxJ+DFaELjmYPlFk7Q80t9YH0lzi9fD9xzhFoaMtDjlXax9JXGhrJqD/wJKMbJFLPg==
X-Received: by 2002:a05:622a:1189:b0:441:24e:6464 with SMTP id
 d75a77b69052e-4449b93f587mr91757401cf.14.1718808783793; 
 Wed, 19 Jun 2024 07:53:03 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f2fceea3sm66496181cf.78.2024.06.19.07.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 07:53:03 -0700 (PDT)
Message-ID: <d0135269-25c8-4156-ad0e-9b3b4b9159f5@redhat.com>
Date: Wed, 19 Jun 2024 16:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20240527131837.2630961-1-zhao1.liu@intel.com>
 <ZnLwFPb3iLNiC8li@intel.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZnLwFPb3iLNiC8li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/06/2024 16.49, Zhao Liu wrote:
> Hi maintainers,
> 
> Per my communication with Markus, it seems this renaming matches the
> "local consistency" principle in (include/hw/boards.h). :-)
> 
> So do you think this change is acceptable?

I don't care too much, both ways of naming look acceptable to me...
... but in case somebody else wants to merge this, FWIW:

s390x parts
Acked-by: Thomas Huth <thuth@redhat.com>

> 
> On Mon, May 27, 2024 at 09:18:37PM +0800, Zhao Liu wrote:
>> Date: Mon, 27 May 2024 21:18:37 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: [PATCH] hw/core: Rename CpuTopology to CPUTopology
>> X-Mailer: git-send-email 2.34.1
>>
>> Use CPUTopology to honor the generic style of CPU capitalization
>> abbreviations.
>>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   * Split from the previous SMP cache RFC:
>>     https://lore.kernel.org/qemu-devel/20240220092504.726064-2-zhao1.liu@linux.intel.com/
>> ---
>>   hw/s390x/cpu-topology.c         |  6 +++---
>>   include/hw/boards.h             |  8 ++++----
>>   include/hw/s390x/cpu-topology.h |  6 +++---
>>   tests/unit/test-smp-parse.c     | 14 +++++++-------
>>   4 files changed, 17 insertions(+), 17 deletions(-)





