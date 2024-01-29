Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E7C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURRv-00042b-7t; Mon, 29 Jan 2024 08:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rURRs-00042M-7t
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:13:16 -0500
Received: from smtpout149.security-mail.net ([85.31.212.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rURRq-000272-4O
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:13:15 -0500
Received: from localhost (fx409.security-mail.net [127.0.0.1])
 by fx409.security-mail.net (Postfix) with ESMTP id 66852349DEC
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 14:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1706533990;
 bh=i/F9rEEOvxb/Pk5UiFW2s3GOfQtKuHS5aDWr83PqGv4=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=Cx4pA7xREUESnlfBk+FF1ej5fGFnX+uy5cBAlVFXEnCmDRAUz0my9acz8lmRqjJVf
 I4nM8QPq96eeouy+uSg3yw0hH9aOFg0+9efIkMk+RjKhYg958K0AvzKPJyeuRgG3M5
 2t9BYa5fUVXy4hl/1TJasPl19wiut5tpCTv9GeP4=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 39A61349DE0; Mon, 29 Jan
 2024 14:13:10 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01on0100.outbound.protection.outlook.com [104.47.24.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id A6C9C349DD4; Mon, 29 Jan
 2024 14:13:09 +0100 (CET)
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:8::13)
 by PAZP264MB2815.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:13:08 +0000
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c]) by PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c%6]) with mapi id 15.20.7228.027; Mon, 29 Jan 2024
 13:13:08 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <a988.65b7a465.a4a51.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j72AG/UdtbhQzWV6kwnM3tONIMxGaypuaPQlJnu46PokdiptQDHvQi4tSYkv0ywd6sIQh1glH/VduxM7vWPiXTzMvco6M3GUJvqCKrJKW+N+tZ7S9KdZ+C7f/dXOezvnMfIOSmbYvFl1+CTipUtQ0JcdWcSwF/YaNMM14GtD/VtSYNASM80O8kN8nvmiT2T/rgyIpClu5qaeNuY8Cmx97aWjSrtAkCB8PwxR1fZVh6M4W7d6QdirFK33FcQlb3SEBIEbNr+u6J7EGmxXa9Opy5uxeZb28MJhT/zrtkBguEyKcdpKwVwhUY5aYrWoc4OVqGyg8w2xx+Jo4bIG1y0E2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVyanGKFYRZgbwI0fYxE6ZRRPSdxPYdYUYAp5vrfLiM=;
 b=aC7StpBAlbnng5DeTGFVfam6YRBMebwCsdudGyPBGIo8SotveZq8w+M32dowWfs/W/Nt4pNLo7J2JotDMFGHGKiQL4ABrZ/AVhuS8revs8aCFoqUzsBU85B4cVab5b4n6B8BZE3Ftqf5+sdthu+0kq+xpZAEw6CuDe1JOmm+MpE3zAeshBF3WKQd++3DmK0q3WVBTINUBByAXYyQMDHoJczvDj7ERELQaEO2LNC5VFq8Zm+xDU92OUTQOOt9xRkQVWFEcwSMoSf9ZTQuyl+P+W+vpEZ0uZvz7CYDj9s7TFSiUcjTbApfU/QxHMfqnbRQqxyJjRs7BM/8ihMxihtQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVyanGKFYRZgbwI0fYxE6ZRRPSdxPYdYUYAp5vrfLiM=;
 b=PKTTX8VAuUtg7FsaWb2rRRmhAe+1S85ueRR476obG0UBIjZyVGEREw2jHkombFjeFMA+M4J5EqlTpy03adeUgP1Ag/PS70ViPTLuZOszMSutIK9KVQHZu4ZqVKo7oVI2AKbwJyoPmPrq6FozhckNDQyuTpP5y7ia3HjpNeRCa1xPgdV+QsgIm7sYsd+hnEQn0zy9nUGMiYfKu1I2MJTloBchWsK3wWdSaVTg6sLlAOzR9aG3K1k1n7JWt3LDYuYEmsiTGMuH4V9F9284Yh74Dz19BNbfo4gZ5UUv9BZJZWwjuIXdWzxmo7PIGDcUn/dnZ9ToJHiq9+FkZ5or2HyYew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <7e35528b-cc66-d2f1-e3e3-7dece5620c52@kalrayinc.com>
Date: Mon, 29 Jan 2024 14:13:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Damien Hedde <dhedde@kalrayinc.com>
Subject: Re: NVME hotplug support ?
To: Hannes Reinecke <hare@suse.de>, Philippe
 =?utf-8?b?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Titouan Huard
 <thuard@kalrayinc.com>, Markus Armbruster <armbru@redhat.com>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
 <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
 <07625f96-4ca1-479f-b6b9-69c2a191de76@suse.de>
Content-Language: en-us
In-Reply-To: <07625f96-4ca1-479f-b6b9-69c2a191de76@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR2P264MB0861:EE_|PAZP264MB2815:EE_
X-MS-Office365-Filtering-Correlation-Id: 787a4732-8489-4883-d9f7-08dc20cc08ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAiWPsoddivmkVlWyy9KclScEf350bLiA5oB1iFCeMy4iusILKYLTLyXi9ytiXG45LZzIdi4ACkmxrn0VqlRW3Z5jvQvx5PCdod/vcUnWhUBFIa3RXRq8WK/MotMwtKMEBtZDR/SFRFmujbAZ4k+apvzC2aeqrcab/VbyPHJETO2t3xMzZkcxhnlN3EZnQE8ncuUK9xCzH6Y75PjIhj0t8M87zUv4I+KuxKs+t93+lO0EfN7JpPlme0OpAKdDJYw6z6pTgxFcszYv8HJiampH+6FYcII5Ex4/TeQrx4RV/BYhcvJZZWDxdRhWvY7M9F5hjwLx42Byi4th2VqHuW5dqfWXF8iQ3BDWlaBcfdehYwgMAuoILmzJsdiLndpmtEFjJAE077w81OnhO2rwr/K0P5L52ZWvV5kg7UIgQYaNQlSzLWPUsoot48IhhIjpmNu8yi3VOUmefauRx7mDDsi8oQVdw0+kLxNeJWkMniWK41VNnu284G8IP+JFPvaeRVpTFuFy7oC1HG7B7DZCWztWVxb8pRNueRiG0q5DVvxBmduert6+kQkDzj/7rfpKxjhj2yJNwMbgzYcmIs6ep7y+FYP9LuMnB582zu5iRlbeZC8fRWMU8fCAPzBhUwdvqRHpqeLgLiEn31VJDttvf81Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(2616005)(6512007)(478600001)(6506007)(6666004)(83380400001)(26005)(7116003)(5660300002)(8676002)(8936002)(2906002)(4326008)(66476007)(66946007)(6486002)(54906003)(66556008)(316002)(31696002)(86362001)(110136005)(38100700002)(3480700007)(53546011)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +TDZ4wRT1AMONJgIYJFHjpzuhmNkhL1PjDCeVIqwxWjUBevmmrkn0+PYO/g6PTHrP5+RXIDBtuYO5twKCHYb6QD7juM8s0i2beAWQK134EYE+wpVvo8bHw4v5F20p5eaDRyfxSx5byOMGZwSrRXT4+6cuyjBQGppU+PoE03wZ2WEpOXjJhn86t9FDOBBG3yIv46m67/LuNABhHvmnftLOySLhTl3FwmjJfla9V+3aVhF0x3fmy3rHfXDVeYKAF+/c23QXrApQXWUNG7DUKRw3xWzUHBzqv76HcoUAevJTGHT6zhQPlFuzdvbQ88Hg4thDNG5wPY+fGvWpH0M3h2f9AgZs+Cxk0eOUdElpTp+Ej8Ci+wzFN1HDcxFsOTtd4hrNqPLdPwy6hPZk2ItxOLpMZW74A9Skz9lDFLruFCcO07nMjQr2WgqNcl4SizhjMypC6metvPvrfR1OgNamq+LnDAeQDUZM7aTwAZpsWWqYHRjqdO0Kjv0Jr/GpIaDLFgal6d91qPnYnbnKwf6gHV9tiypzWTWv8RNZaCA1F2x1sOn8Va4ibHqa957Iz5U8NdbPtU7yCLEFLVbWXJcRzWHBVHa0Dx6C3pCtEMbfGxQhBRqVh6YVAT9OAsbR0jWEZbjtdSSb0YJ02q6WZAVcy9fhUHS/YW7bONDqEJlTjK5B5dDaG+AIzUGXx8dQK6UuCCQl7IwtckkC1Ijw49Bgu26UeUeoyPOVDn5Gmfz/tJrh//MwfCqIeJjwKiqQsHQaY/SAzawTbkcDdR2sR+nBA4dsuWpSqWy+UwQVQoCh7mIwgoRtTnjgKz6mCpD0HUg+65MfF6DHlZl1JY0ZFKf6cu0V6YB0DN1Sk0yxTyT20bI9a9gr3N0QC5rgP4NwhFxq6ttGq4jXnItDjo8Y2g0Qmzyd5gyLvFXcBTTEsFiSYMqvkMptHufVPux4K3px/75+i+O
 tmX0W9KpPjabT6ymR2oXecYKIM/3nOo5v8baaNP+qZuzI8mbtzQt4gsYKgClNVrWjxAFYtNL1ksZ6+zZKyvPpgFkZYRU0fLdUkLgiVQgf/QQhRaft3J0nVVdzpxQELxZ9IQYD3WqWnHDJ7koDyRzjsai19by9PlHSghke7MZAJu3N9+pd0Cmf9X5iMa5E/Do087X8MILfu5F5TylsTeNoHAMSm/yZNKPPnjJaQmLQtEhrGDmlzyHWa86Z5fPHMhfBye8uqDmjlbKZYHIPUDj2LDL157U28h+6ujnvdf3yEYbDWNQgbljb1Mr5hh/vwh7rGpjVCe8c1EInGxkg0Z5RM4h62a5rzPJ/XFNUcSkWGs8Cb29UN8T9tY8kKe0FwqXe1vGDRK4a7smvE7Y+L3A9MmaFoOpvbqFzzygssFO/84RZFEmvjh7T6ZAi8PBbk1kbtjtFCksdXM4gHTSGQuR0bOc0YQKQm32l1i0S/5RzGk+sbTW9Gt8bV1KPHKGDFI26/XzzERBtULTcVru9VjaH85ZDI3rpWeT/C1ta2rZWiXmejfcYBJl6vfzAgurGUSX8/jxtPQqnBHLOLcUfaFx938QeGyx+hTMtzklEGv3uL5e9WLii3ExWYxPtrIv+QiA
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a4732-8489-4883-d9f7-08dc20cc08ca
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:13:08.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DNdA9km3olWPYRaIwNXzrNHWRSQBNUYFDT/OkqnDCEs8Z4XV9Uv1JZkAoadCd/TpSTA//livEXbxmP/aQnzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2815
X-ALTERMIMEV2_out: done
Received-SPF: pass client-ip=85.31.212.149; envelope-from=dhedde@kalrayinc.com;
 helo=smtpout149.security-mail.net
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.241,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 1/24/24 08:47, Hannes Reinecke wrote:
> On 1/24/24 07:52, Philippe Mathieu-Daudé wrote:
>> Hi Hannes,
>>
>> [+Markus as QOM/QDev rubber duck]
>>
>> On 23/1/24 13:40, Hannes Reinecke wrote:
>>> On 1/23/24 11:59, Damien Hedde wrote:
>>>> Hi all,
>>>>
>>>> We are currently looking into hotplugging nvme devices and it is 
>>>> currently not possible:
>>>> When nvme was introduced 2 years ago, the feature was disabled.
>>>>> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
>>>>> Author: Klaus Jensen
>>>>> Date:   Tue Jul 6 10:48:40 2021 +0200
>>>>>
>>>>>     hw/nvme: mark nvme-subsys non-hotpluggable
>>>>>     We currently lack the infrastructure to handle subsystem 
>>>>> hotplugging, so
>>>>>     disable it.
>>>>
>>>> Do someone know what's lacking or anyone have some tips/idea of what 
>>>> we should develop to add the support ?
>>>>
>>> Problem is that the object model is messed up. In qemu namespaces are 
>>> attached to controllers, which in turn are children of the PCI device.
>>> There are subsystems, but these just reference the controller.
>>>
>>> So if you hotunplug the PCI device you detach/destroy the controller 
>>> and detach the namespaces from the controller.
>>> But if you hotplug the PCI device again the NVMe controller will be 
>>> attached to the PCI device, but the namespace are still be detached.
>>>
>>> Klaus said he was going to fix that, and I dimly remember some patches
>>> floating around. But apparently it never went anywhere.
>>>
>>> Fundamental problem is that the NVMe hierarchy as per spec is 
>>> incompatible with the qemu object model; qemu requires a strict
>>> tree model where every object has exactly _one_ parent.
>>
>> The modelling problem is not clear to me.
>> Do you have an example of how the NVMe hierarchy should be?
>>
> Sure.
> 
> As per NVMe spec we have this hierarchy:
> 
>       --->  subsys ---
>      |                |
>      |                V
> controller      namespaces
> 
> There can be several controllers, and several
> namespaces.
> The initiator (ie the linux 'nvme' driver) connects
> to a controller, queries the subsystem for the attached
> namespaces, and presents each namespace as a block device.
> 
> For Qemu we have the problem that every device _must_ be
> a direct descendant of the parent (expressed by the fact
> that each 'parent' object is embedded in the device object).
> 
> So if we were to present a NVMe PCI device, the controller
> must be derived from the PCI device:
> 
> pci -> controller
> 
> but now we have to express the NVMe hierarchy, too:
> 
> pci -> ctrl1 -> subsys1 -> namespace1
> 
> which actually works.
> We can easily attach several namespaces:
> 
> pci -> ctrl1 ->subsys1 -> namespace2
> 
> For a single controller and a single subsystem.
> However, as mentioned above, there can be _several_
> controllers attached to the same subsystem.
> So we can express the second controller:
> 
> pci -> ctrl2
> 
> but we cannot attach the controller to 'subsys1'
> as then 'subsys1' would need to be derived from
> 'ctrl2', and not (as it is now) from 'ctrl1'.
> 
> The most logical step would be to have 'subsystems'
> their own entity, independent of any controllers.
> But then the block devices (which are derived from
> the namespaces) could not be traced back
> to the PCI device, and a PCI hotplug would not
> 'automatically' disconnect the nvme block devices.
> 
> Plus the subsystem would be independent from the NVMe
> PCI devices, so you could have a subsystem with
> no controllers attached. And one would wonder who
> should be responsible for cleaning up that.
> 

Thanks for the details !

My use case is the simple one with no nvme subsystem/namespaces:
- hotplug a pci nvme device (nvme controller) as in the following CLI 
(which automatically put the drive into a default namespace)

./qemu-system-aarch64 -nographic -M virt \
    -drive file=nvme0.disk,if=none,id=nvme-drive0 \
    -device nvme,serial=nvme0,id=nvmedev0,drive=nvme-drive0

In the simple tree approach where subsystems and namespaces are not 
shared by controllers. We could delete the whole nvme hiearchy under the 
controller while unplugging it ?

In your first message, you said
  > So if you hotunplug the PCI device you detach/destroy the controller
  > and detach the namespaces from the controller.
  > But if you hotplug the PCI device again the NVMe controller will be
  > attached to the PCI device, but the namespace are still be detached.

Do you mean that if we unplug the pci device we HAVE to keep some nvme 
objects so that if we plug the device back we can recover them ?
Or just that it's hard to unplug nvme objects if they are not real qom 
children of pci device ?

Thanks,
Damien







