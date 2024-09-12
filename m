Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41D1EE57C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodWI-0001FU-Oa; Thu, 12 Sep 2024 02:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sodVQ-0000sk-Lv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:40:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sodVM-0001zy-TK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:40:38 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db174f9050so208338a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726123235; x=1726728035;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEk3TNqDrtgAr9xqiFpmkkws7Z6jxQQ9KRqsWJM80X0=;
 b=05FJCca3X40bFgz6Q76SbzRnug66l9ixLuFAnjMYd9xwmW8ta7EGry84enEtjiW3qf
 bnmN/26vjisNVWM0g3fInNhaEr4xuqWKY0qUl+c951WrMi9v8TXPsV9hx9b5owlkLtqT
 Yw5ErTSY56nxximMN14ayVtvibaGRouUfCVQySFu77sf7frO0t8V+nnZQw55y3oU26VO
 T049LzeyYx1jb2Oh5ze18oqo28gje2Vvf/sFyrNsoKfEWdKlcPU424sbpD3yP45qQ9tL
 vprfJ6uHoAvKr3EBr9uLJjJbh0YCgkExDmajNmVDFqomznOqbEU3CKhP4GkL+Ug+VG7F
 qrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123235; x=1726728035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEk3TNqDrtgAr9xqiFpmkkws7Z6jxQQ9KRqsWJM80X0=;
 b=VVOClkce+SUDYxRecWkx6Rn8OVPKbE8WZBs2OX+anSghBt5ekAakLPnEIjgaxwGOVv
 N0/lKTthwch6DzW0X7VHIZulLDm4p6BgiDsmXJunmYpoXr51pHeyR031AIWyZAKvI8NJ
 BfPkfXeMBTnPl6SyBiL4ZnMpR6U2aEnnAg4tCfUMnYMo8gV6vEXlbNgLrvAxP9exsGd9
 tCDUFNgjnufI75hKP/PNisaahj4cPM2Y5egCF7vcNxwskEAjWFNeTopXrXE+UoDFDmHH
 EllkiMhnyPR0sA23MVaxcs6WMY335hMYnD0AE5Lg3q0UeM6t/mj7ODYz/UD65BFYhmp2
 gpKQ==
X-Gm-Message-State: AOJu0Yyxhw577faHCW2YNnTEK1Cx3LTniYI4o749X7Wwo2cVl4CdCfWc
 bww7h9M3dO1Z2/KUh/0xiN2oGbrZ1OOV6N3Sj0Yhh6G2d9weCK+tAn9iWDFXEA8=
X-Google-Smtp-Source: AGHT+IGHgEnACTF/mEihj3HBHr7VJXtGYbn6bs+5iejj1h1NPEkAXUT5Z3bvP3JFtZMCTHNrjN7I7w==
X-Received: by 2002:a05:6a21:164a:b0:1cf:54bd:393a with SMTP id
 adf61e73a8af0-1cf7620c101mr2100631637.37.1726123234449; 
 Wed, 11 Sep 2024 23:40:34 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090926fcsm4075644b3a.99.2024.09.11.23.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 23:40:34 -0700 (PDT)
Message-ID: <3ea67905-fa37-448d-9872-d8fc70613ed0@daynix.com>
Date: Thu, 12 Sep 2024 15:40:29 +0900
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
 <8127d7f8-4917-4545-be66-62688157224a@daynix.com>
 <a58519cf-90ce-4bdf-aa5a-04c3526d7192@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <a58519cf-90ce-4bdf-aa5a-04c3526d7192@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/12 6:11, Matthew Rosato wrote:
> On 9/11/24 11:15 AM, Akihiko Odaki wrote:
>> On 2024/09/11 22:53, Matthew Rosato wrote:
>>> On 9/11/24 6:58 AM, Akihiko Odaki wrote:
>>>> On 2024/09/11 18:38, Cédric Le Goater wrote:
>>>>> +Matthew +Eric
>>>>>
>>>>> Side note for the maintainers :
>>>>>
>>>>> Before this change, the igb device, which is multifunction, was working
>>>>> fine under Linux.
>>>>>
>>>>> Was there a fix in Linux since :
>>>>>
>>>>>      57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
>>>>>      6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>>>>
>>>>> ?
>>> The timing of those particular commits predates the linux s390 kernel support of multifunction/SR-IOV.  At that time it was simply not possible on s390.
>>
>> Is it OK to remove this check of multifunction now?
> 
> Yes, I think removing the check (which AFAIU was broken since 6069bcdeacee) will get us back to the behavior Cedric was seeing, where a device that reports multifunction in the config space is still allowed through but only the PF will be usable in the guest.

Commit 6069bcdeacee predates the introduction of SR-IOV (commit 
7c0fa8dff811 ["pcie: Add support for Single Root I/O Virtualization 
(SR/IOV)"]) so it did not break anything, strictly speaking. Ideally, we 
should have taken care of the check when introducing SR-IOV.

> 
>>
>> This code is not working properly with SR-IOV and misleading. It is better to remove the code if it does no good.
>>
>> It would be nice if anyone confirms multifunction works for s390x with the code removed.
> 
> Even if you remove the check, multifunction itself won't work in the s390x guest without these missing CLP pieces too.  When I have some time I'll hack something together to fabricate some CLP data and try it out, but it sounds like Cedric could use his setup to right now at least verify that the PF itself should remain usable in the guest (current behavior).

Well, it seems better to keep the check for non-SR-IOV multifunction 
devices while not enforcing the restriction for SR-IOV.

Multifunction devices without SR-IOV are created with explicit requests 
by specifying multifunction=on for PCI devices. Such requests cannot be 
fulfilled without multifunction CLP so we should reject them.

The situation is different for SR-IOV. SR-IOV is a feature inherent to 
specific type of devices and gets automatically enabled for these 
devices. It may make more sense to ignore just the SR-IOV part of such 
devices and keep the other functionalities working.

The current code implements such a behavior, but it is accidental and 
semantically wrong. I will correct the code to explicitly allow 
multifunction for SR-IOV.

Regards,
Akihiko Odaki

