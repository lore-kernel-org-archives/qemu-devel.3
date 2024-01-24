Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06AFC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 06:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSX8G-0006ZA-S5; Wed, 24 Jan 2024 01:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSX88-0006Sy-Cp
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 01:53:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSX86-0003yr-7k
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 01:53:00 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3387ef9fc62so4742972f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 22:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706079176; x=1706683976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWE6a0kXr4+mWJuxQv9nh2OC8oCO5Yojb8LRiNARNgo=;
 b=kZubgUA/JhFjcTdqXgcMr4i8jTbNyJPsf/pAq+NRJetevTtoDpbf5GNhv6OxyzKoEF
 lCgGFxgNcqZm0Lu+P1KhPu6E1rJEsgQdoxtBHnypHiTYpTu4qESveQyBzo2MySuNGhX2
 EMTeczml2yzSovCHFexltGZ5BfT8Wz7FaeqDOmfnn3unZgbLPXAulWv8HVh1LVBe8+AQ
 Lh08TKUg4TEbqNMyWZLxLwPrrDf5GAYbb+EPValQhM0nwiA8PueeC2Pbz6pc9meofi4g
 I57eo3PLF13dZX5MiUfCLjSEjJ74muMIQJqYmfOcoJW9exOsv4KS48f3eiPAuMfpWHuP
 AUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706079176; x=1706683976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWE6a0kXr4+mWJuxQv9nh2OC8oCO5Yojb8LRiNARNgo=;
 b=o7VdOP06gp3WTcVGcYztFm6lwqhwmU2sJC4R8ka1vD1+i2yC/M1O8FjHM/2Wp6C2Hd
 m53qY2MARdx4JSeJDwbkpCJm0mWCKbOf/4UCSzbmN578lixzebiYrhs8ht43UwkC6abZ
 9v+B25Q2+FYRLlYOGxS3MJuL5xkofM7QyFuVTxBPqL6H197UEf9+kyrxaBYQg6WyNCtc
 pJTjKURYgXFRq0e0IaPckTVuUOiPSoKf/fe/SEIbAVal5etyILSPsBoT5E3Z/vQNHfPl
 nZQF7k8jwtk79yiHH2NZfRtpF7t+xvDbWX5DRg2sBxIM3uxDV+jzg4MedjkUtbKZ+6qz
 0n3w==
X-Gm-Message-State: AOJu0Yzr08+fOaUhA9P4Gvemzeu3I6eQV7MgZqAkSUwiPM/AIaqtBkiP
 0QpdRyGHYPJkJ4+iP+XelkIVqjfD9enxElFs81E65WWv0Wbq7aSlx74bU9z46QU=
X-Google-Smtp-Source: AGHT+IE7NuY/lYhgkKdv6F0i1+kGAHKrxDnEjEuRMgoCb1OOCMrvs8vyb015m1Je/GMW9zeETPUH+w==
X-Received: by 2002:adf:ec51:0:b0:336:6aa4:b62c with SMTP id
 w17-20020adfec51000000b003366aa4b62cmr248216wrn.49.1706079176379; 
 Tue, 23 Jan 2024 22:52:56 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 x4-20020a5d4904000000b0033928514699sm10581368wrq.2.2024.01.23.22.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 22:52:55 -0800 (PST)
Message-ID: <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
Date: Wed, 24 Jan 2024 07:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVME hotplug support ?
To: Hannes Reinecke <hare@suse.de>, Damien Hedde <dhedde@kalrayinc.com>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Titouan Huard <thuard@kalrayinc.com>, 
 Markus Armbruster <armbru@redhat.com>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Hannes,

[+Markus as QOM/QDev rubber duck]

On 23/1/24 13:40, Hannes Reinecke wrote:
> On 1/23/24 11:59, Damien Hedde wrote:
>> Hi all,
>>
>> We are currently looking into hotplugging nvme devices and it is 
>> currently not possible:
>> When nvme was introduced 2 years ago, the feature was disabled.
>>> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
>>> Author: Klaus Jensen
>>> Date:   Tue Jul 6 10:48:40 2021 +0200
>>>
>>>     hw/nvme: mark nvme-subsys non-hotpluggable
>>>     We currently lack the infrastructure to handle subsystem 
>>> hotplugging, so
>>>     disable it.
>>
>> Do someone know what's lacking or anyone have some tips/idea of what 
>> we should develop to add the support ?
>>
> Problem is that the object model is messed up. In qemu namespaces are 
> attached to controllers, which in turn are children of the PCI device.
> There are subsystems, but these just reference the controller.
> 
> So if you hotunplug the PCI device you detach/destroy the controller and 
> detach the namespaces from the controller.
> But if you hotplug the PCI device again the NVMe controller will be 
> attached to the PCI device, but the namespace are still be detached.
> 
> Klaus said he was going to fix that, and I dimly remember some patches
> floating around. But apparently it never went anywhere.
> 
> Fundamental problem is that the NVMe hierarchy as per spec is 
> incompatible with the qemu object model; qemu requires a strict
> tree model where every object has exactly _one_ parent.

The modelling problem is not clear to me.
Do you have an example of how the NVMe hierarchy should be?

Thanks,

Phil.

