Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F25EE57C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP4k-0001xg-Bo; Wed, 11 Sep 2024 11:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soP4T-0000tA-TZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:16:00 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soP4N-0001Xf-SS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:15:51 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2689e7a941fso1068507fac.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726067746; x=1726672546;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNfBsIsefW8T3up2+JXDHYhN3Cq6xtXbQYfb2BK+Q6Y=;
 b=cSZf3GfXLDjpZ7BgY9KpmbJYgNOsJFELSqP0rcVJiDJwfaJdyKUDNe3BdJwudMceoN
 kBPFFwshV5AR3gJZr5QqPaKd8S8r5fEhXurpsAA6XLZ/7vD7hmvCurxJBDwouBtwcV3w
 JWI4ee2RjHwIHGwJOobMIoELn/ZANTZQ2iEzL5xeqvif7OdaKRybV8bZWfgsKs+V12It
 gXCYMRaLIgMfo9USGrFenFgUjnTv3atMLG0vA7cNp4VtGkkSjD9R93NT5LZln6CDlfCD
 php4wN40CwpGeE1PWY4m96cEpIkgdVEVFoSKRnzTsE0lexa5xf/54ziMmr8RO+6aTS0R
 ns3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067746; x=1726672546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNfBsIsefW8T3up2+JXDHYhN3Cq6xtXbQYfb2BK+Q6Y=;
 b=FLEnJLsow6n4j5aOZO0VlMg0CqiwGoNIGAr/BimXcJIWvVq+mAeQDzrBpq14PA43EL
 co+MpPxQl3IBSNjvy8WirO/9PB/YRKNMCPZmDYnLWnBLtlV1iEjAZB0ZbmNWO8ZdyiyV
 w3G3q0XYg7CXtkzFEo438Sqs0EntRe8T8+gBXV/d049AnmX1SuX+rPoRFs4+r8yGluf1
 leZL7aUCnGKxGyW4RZAZ2w/B++9Dcen7pqW333yGOmUhfT7kV7VJRFPzNHFqpahrNEdn
 XaNy6jNBGS0BLWHuqApFujr1DpD6jegaU4FKyZ+wz9JFHy6Dxmvih1r6sWWNYzRRL9+f
 6DvQ==
X-Gm-Message-State: AOJu0YyNdvjIJyK8Pugp7Xe/NlqAwKEZZUbvrAc8HDksH97aK7+9vOx3
 j1b8RNbU823TzE2QllHtTNPPhaRyMuER5dDcbERfq9AemwiLkniGxiZfjhMmsUY=
X-Google-Smtp-Source: AGHT+IGw3oK0jVGSyPxmvx7NJPi5+ULQlBJkVWIq6OMAGMaOVLfS1qB8AtVWf1ukgLWYewYF7cG44g==
X-Received: by 2002:a05:6871:829:b0:260:e36f:ef4f with SMTP id
 586e51a60fabf-27c1b4b015dmr2503365fac.3.1726067746129; 
 Wed, 11 Sep 2024 08:15:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fe11ad7sm83191a12.94.2024.09.11.08.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:15:45 -0700 (PDT)
Message-ID: <8127d7f8-4917-4545-be66-62688157224a@daynix.com>
Date: Thu, 12 Sep 2024 00:15:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
To: Matthew Rosato <mjrosato@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
 <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
 <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
 <8dbc553b-c3ae-4f11-accb-6dee10e9758e@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8dbc553b-c3ae-4f11-accb-6dee10e9758e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/09/11 22:53, Matthew Rosato wrote:
> On 9/11/24 6:58 AM, Akihiko Odaki wrote:
>> On 2024/09/11 18:38, Cédric Le Goater wrote:
>>> +Matthew +Eric
>>>
>>> Side note for the maintainers :
>>>
>>> Before this change, the igb device, which is multifunction, was working
>>> fine under Linux.
>>>
>>> Was there a fix in Linux since :
>>>
>>>     57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
>>>     6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>>
>>> ?
> The timing of those particular commits predates the linux s390 kernel support of multifunction/SR-IOV.  At that time it was simply not possible on s390.

Is it OK to remove this check of multifunction now?

This code is not working properly with SR-IOV and misleading. It is 
better to remove the code if it does no good.

It would be nice if anyone confirms multifunction works for s390x with 
the code removed.

> 
>>>
>>> s390 PCI devices do not have extended capabilities, so the igb device
>>> does not expose the SRIOV capability and only the PF is accessible but
>>> it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
>>> default Linux config which is unexpected)
> 
> The linux config option makes sense because the s390 kernel now supports SR-IOV/multifunction.
> 
>>
>> Doesn't s390x really see extended capabilities? hw/s390x/s390-pci-inst.c has a call pci_config_size() and pci_host_config_write_common(), which means it is exposing the whole PCI Express configuration space. Why can't s390x use extended capabilities then?
>>
> 
> So, rather than poking around in config space, s390 (and thus the s390 kernel) has an extra layer of 'capabilities' that it generally relies on to determine device functionality called 'CLP'.  Basically, there are pieces of CLP that are not currently generated (or forwarded from the host in the case of passthrough) by QEMU that would be needed by the guest to recognize the SRIOV/multifunction capability of a device, despite what config space has in it.  I suspect this is exactly why only the PF was available to your igb device then (missing CLP info made the device appear to not have multifunction capability as far as the s390 guest is concerned - fwiw adding CLP emulation to enable that is on our todo list).

What is expected to happen if you poke the configuration space anyway? I 
also wonder if there is some public documentation of CLP and relevant 
aspect of PCI support in s390x.

> 
> Sounds like the short-term solution here would be to continue allowing the PF without multifunction being visible to the guest (so as to not regress prior functionality) and then aim for proper support after with the necessary CLP pieces.

I agree; we can keep the PF working.

Regards,
Akihiko Odaki

