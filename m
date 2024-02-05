Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9950C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWz6U-0001ef-Sp; Mon, 05 Feb 2024 08:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rWz6S-0001cr-Ht
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:33:40 -0500
Received: from smtpout148.security-mail.net ([85.31.212.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rWz6P-0001Zp-VU
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:33:40 -0500
Received: from localhost (fx408.security-mail.net [127.0.0.1])
 by fx408.security-mail.net (Postfix) with ESMTP id BC1D432295B
 for <qemu-devel@nongnu.org>; Mon,  5 Feb 2024 14:33:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1707140013;
 bh=/GkOTW0rnonER7P8VdJeHOCFEhXxANke2bCi7ufdGKg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hgmWbIuxpu2Nmovlq7MV4Xkk5Cckk1XKsw7gusEjznBmVQrU9QcrWKmYjAFRcEzg9
 AT2W+o6bVndJyIy9Njj8AJXK/AlJ+vwvpoSgPyHnuCQYt9VWGHep2g1JvNgJkkbWaG
 /HI7oL6kN3wChMA+d4pLGGvOK3Af9+bL1afY7IhQ=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 8728C3227F2; Mon,  5 Feb
 2024 14:33:33 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0101.outbound.protection.outlook.com [104.47.25.101]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 03310322781; Mon,  5 Feb
 2024 14:33:33 +0100 (CET)
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:8::13)
 by MR1P264MB2050.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 13:33:31 +0000
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c]) by PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:33:31 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <10bbc.65c0e3ad.24ad.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQsnHSCh7Pc59Rlsp4c1cmDg6XQrxfGm+aBhx8iLgHLHXX8KOdAdvMLWWWkj5JYgA88AaEIZMSwTjZ+JGqTz+gmpyB9RV5b8JpNfQZ6qfNxBeYrpVD4WcZiv0+BB5pdlFIvP0TMBS4oK+rUi5YkL2bqwinkWsLGiKHkhVaXtMF//eVoPitym8Ff/xb7RDQmmOt3csFUz31bj5AKsbKcPkFBOVMly7vjdtWEsyL3vymFaIdCrl2lFqvXCiwUgO1vohwWtLydFOq1/EaL/9nlEWWVXAB/5o6rfjKjlMAueUbLkxeVk7uK7fVQSxpUTad8E91nMKWH0NXqVH6RCWkUIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoQeQTwppCk2XBqZIj5sErD+0PvR7SR2NTw82qnUxuo=;
 b=C7O6qTLnlhV+KvGcCptRKUZi+JEikumWGD9zdQF0P+hT9QHNHMP8RULkAzpAHgG5yK8M0M6e9jjOei175Bhze50ium9tWgwHLXrP/yRrITe8g3uysLMLVnBfFNi+KrvexjjWStrts8LVTtbsCIY3dhiQpsttD3OqmBHN0NAdPPSIaLnIGY05sQuTooVJWAflofJWVTmwSosftY2D0UMcbNmZzM1xcd5fkLvZmTsJy/63QHBUXFn3E4L9tQfe8CVzc5OazaEDUdNE2f7UGx0cd1MI383SiYfSmAg+KoyoZaGH5mq2RUfyZY3iWgCVthkHyIrisOFbUWA/b1LUhJ+6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoQeQTwppCk2XBqZIj5sErD+0PvR7SR2NTw82qnUxuo=;
 b=QICjGiNj++Vq0CJ3SIBEMweufj/bkEkXlcWvABo29JkTIoFf10+6M5uYLYAoEsBGAqQlVDpQkRtFeInGzkjsVaHCUfPOhLeDc2hDGzQbRykQF9jE51GkBpoJ+DCNXw9WywHZQNmhbTAMatHbE78db++X4fglpsNpCNDJXXsgFCsASIQMJh6TV8lh3vLGB8XzHyTnI3lWUwXQcW4qMAUOiFLXaydbOI/C05dAeaOxeEVoQ7x0UY4SbJpwoU0bMF0l7s2pAwW7svY3Y/VedUDLDz9Q60qzdMfhuesY0g+PV6JCuZqq5PNYEEHOg4WbAMav+zodj9/RcMOPn5nEOWHgOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <933ca5e9-d6e4-6e3c-751f-116a6374446a@kalrayinc.com>
Date: Mon, 5 Feb 2024 14:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: NVME hotplug support ?
Content-Language: en-us
To: Hannes Reinecke <hare@suse.de>, qemu-block@nongnu.org, Klaus Jensen
 <its@irrelevant.dk>
Cc: qemu-devel <qemu-devel@nongnu.org>, Keith Busch <kbusch@kernel.org>,
 Titouan Huard <thuard@kalrayinc.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?b?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
 <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
 <de06e322-37e9-4788-97a2-c9f16a68cd2e@linaro.org>
 <07625f96-4ca1-479f-b6b9-69c2a191de76@suse.de>
 <7e35528b-cc66-d2f1-e3e3-7dece5620c52@kalrayinc.com>
 <457e365b-99fe-47a9-88c2-9f3bd77b0443@suse.de>
From: Damien Hedde <dhedde@kalrayinc.com>
In-Reply-To: <457e365b-99fe-47a9-88c2-9f3bd77b0443@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::30) To PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR2P264MB0861:EE_|MR1P264MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c73538-9bbc-433b-a0c6-08dc264f0b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTutwbJKJKvruK8GjHeetQLm1kBhtsa01qgtx2p3klp1i9l++C1vTo1Z0a8QX1MTLmczChfEO599bJgxIS9bNMc+LOPzZsfzdBFJ3gGIs6Fe6LohBLiZj7adBiR+EYhHTWfViKAY0wvUTYD/5eSa8vIqywulWLgdQaonFnfoFNya6rfCP3a/3t/k6yaQXUQlNycCTDiKJwRt3Foxp0QvKufFab49ET2HAekBsID3Yja8K0LEW2rzdZ1Y3PYV6ytbGDnl7Izta1MdOgf1NR8bRhOf1h7MB3BjiDxiAm8+vwkifNFtvZljiHne+QpArPQQSWrS1xAp8x4cNcqIyc9l4atYOPnVIkTMiqnNlGoYq75MsBvMoBrySj2lAa3UfhyWKQjJihiqTdNRCMUy0wq7049XMGoCJon35LVIxu3kyfYQmBd8ktTnN5rlMwlkxbds6ZPqq47VhyXGxo6awkafG2fcVfVQGmJiiqfbYQJg4TJwtbyWqZ2s5L8wEgMhD8tS+JUXezK5Rn7CG26RpKaR9Hx2603fuhcKEP1uLuMiJc0JQlRdd7JA3cH1CHQxBjy1/rj5yLHYTkEIHBB40P8EGsLyawymLLQdrVRPmikNJ2/CUUgA6ywzgfpXTX2QjYBCOkroNYWt7B8vkMtwQaDxTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39850400004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(53546011)(478600001)(6486002)(6506007)(86362001)(31696002)(7116003)(3480700007)(38100700002)(66556008)(41300700001)(5660300002)(31686004)(2906002)(66946007)(66476007)(2616005)(316002)(110136005)(36756003)(54906003)(6512007)(8936002)(8676002)(83380400001)(4326008)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GvapViOoXp468+Wt+U302gtE0OzFZP6u1PrPcyxZC4vbctuxAwHmSlBm6pu4YbwDc8cuch3TJ0lIwZ4aXBfM4s4R4OTf9gTZBxBnEDoOlCBd/wq6VRYnRNDukfdZ034WNuhZTU2nGvgaDfdXeQYPQ/VaMt93B8GUMD3mpOGPnasJtgQq6S/gCnZgqhY9LDaJUrhV4dQWhDEQMMYyps+IN/WYKpHpNFh38xHqNbrZfvJkU9oXN9U3K+RI80bH1lhQ8V4YIr0xThheq+RxOUwwKr8y8V3rw6VcX2JMl2P10rZo7iebppLwNNZ/bmt/9BG+jfSutCM3ng049Vs+nhcH0KpAdKWFmaQfIm93CgYTztMhUSELyTJKAcMtaBtBEX4RVKHpNBD5W++OdkWHsRkXRxJIYk4nKEFJ5adNkv/BS3tbjjQZTks/cGuymVy+/ArGKh/KGBsGfo9WoQ0zR2f9Q9xhnqJLlvWarvDReKnXacBOX1ypgkmALnStpIoGbUWrDc5avqEiplTRLpbrd+ui2K+NTB5NmG54B47ZNRzLMiQXsQA5Z3WiYMEqUKy1cjSK6VlfEVpJMW1ZDkls6jGzX2ylPr9IbrSsug4GrLTwDcSmKlzfHOQF2p+IUurBf7tO3pw/GlTtVK38pILIiX2GfYplJ4FTdDw74DZNhmdkdCY9Pt0nckk5OVMQd98uBFa04tcrB4rlsz4qzPU7SiWOfEwN8Ifbes3GM1Dz5n5l6DR9dGM8Bxv3r5hZtgQaDup4yjd0bKnKtoU44rH0aQDIr5GKIFCIWM8o+jaLYnlfOrVe3q10kMmk2mL+k7NXvS7+t2WJK5hLsmmWuWpKfGIcf1MsMhHxKV6NOEzJQsulQI9fsztR0nQcW1MoHJx/lUd+o98dwMLPcp+NxAEL6CMUnyto8bvrlrota5j3c/AkoF9QD8xxI1qgqBAHDMOXS1L6
 M0w9M97n8Ve6ZfmBoJz8sX3nFLaR0ztjjOIwTMWegRDhxeOj8AxZdyPo/58BotHcD4yoTe6grx6SDIfpltIlghvoDBmA1tT9Eust3LLkLWH3ihUBd15NchZ8oxXlH0QMEz92VtBMHAa8RGtFfdaVo9D7kbxthIBWzxGt7j3nhDRHa60DJ7Ae1cpp15bXY0uYzDxHXienuPRWVy/YAiOHoETnGHnZ6p6+bC1haMWsyuumvJl+ZQPKBHLDY3705ToWQ2ElMuyp8HS2TlIuU3bI5R0inlpJnRuu4ZNjtq6VFwwXAoDBVS2yQdDujyyNbaJ+9VL8RwatOCu1eASBjG75IstDKwoJe5pLGhS+6fLdrO+nYD+CrXU2uS3QcErPrMXSoKOzAwImjcvvf+GZwuILST7WE3dWEEDIu46uXz9T+U9z93HVD4bEnDCbClvPvnZIfpedwj1cndvb8oqxZN+X3Leb8HQf+8P7k1D76zgp46ZlGYQkhEHRYBk3Fsi6KP6+X6kCdFIopMSIdA8rtFTZKQe/hClO1L61UR7pAIDgQTaZBvsF+C3KjoBnccdDVK2k31bXSKQRC4LwyG7ssP2olEbWAi1uelz2WCeh88fKd+PGD9SphwZXe0r1x5stLIQX
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c73538-9bbc-433b-a0c6-08dc264f0b25
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:33:31.2759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDZ9VEwybHPJBss7cSXJ6UZ0l2cNe7QTrpW6+h0f8diaaBsiyNmYevAvYrkE5D4XgE5cggqoOykqpYsF1v4k4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2050
X-ALTERMIMEV2_out: done
Received-SPF: pass client-ip=85.31.212.148; envelope-from=dhedde@kalrayinc.com;
 helo=smtpout148.security-mail.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.543,
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


On 1/29/24 16:35, Hannes Reinecke wrote:
> On 1/29/24 14:13, Damien Hedde wrote:
>>
>>
>> On 1/24/24 08:47, Hannes Reinecke wrote:
>>> On 1/24/24 07:52, Philippe Mathieu-Daudé wrote:
>>>> Hi Hannes,
>>>>
>>>> [+Markus as QOM/QDev rubber duck]
>>>>
>>>> On 23/1/24 13:40, Hannes Reinecke wrote:
>>>>> On 1/23/24 11:59, Damien Hedde wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> We are currently looking into hotplugging nvme devices and it is 
>>>>>> currently not possible:
>>>>>> When nvme was introduced 2 years ago, the feature was disabled.
>>>>>>> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
>>>>>>> Author: Klaus Jensen
>>>>>>> Date:   Tue Jul 6 10:48:40 2021 +0200
>>>>>>>
>>>>>>>     hw/nvme: mark nvme-subsys non-hotpluggable
>>>>>>>     We currently lack the infrastructure to handle subsystem 
>>>>>>> hotplugging, so
>>>>>>>     disable it.
>>>>>>
>>>>>> Do someone know what's lacking or anyone have some tips/idea of 
>>>>>> what we should develop to add the support ?
>>>>>>
>>>>> Problem is that the object model is messed up. In qemu namespaces 
>>>>> are attached to controllers, which in turn are children of the PCI 
>>>>> device.
>>>>> There are subsystems, but these just reference the controller.
>>>>>
>>>>> So if you hotunplug the PCI device you detach/destroy the 
>>>>> controller and detach the namespaces from the controller.
>>>>> But if you hotplug the PCI device again the NVMe controller will be 
>>>>> attached to the PCI device, but the namespace are still be detached.
>>>>>
>>>>> Klaus said he was going to fix that, and I dimly remember some patches
>>>>> floating around. But apparently it never went anywhere.
>>>>>
>>>>> Fundamental problem is that the NVMe hierarchy as per spec is 
>>>>> incompatible with the qemu object model; qemu requires a strict
>>>>> tree model where every object has exactly _one_ parent.
>>>>
>>>> The modelling problem is not clear to me.
>>>> Do you have an example of how the NVMe hierarchy should be?
>>>>
>>> Sure.
>>>
>>> As per NVMe spec we have this hierarchy:
>>>
>>>       --->  subsys ---
>>>      |                |
>>>      |                V
>>> controller      namespaces
>>>
>>> There can be several controllers, and several
>>> namespaces.
>>> The initiator (ie the linux 'nvme' driver) connects
>>> to a controller, queries the subsystem for the attached
>>> namespaces, and presents each namespace as a block device.
>>>
>>> For Qemu we have the problem that every device _must_ be
>>> a direct descendant of the parent (expressed by the fact
>>> that each 'parent' object is embedded in the device object).
>>>
>>> So if we were to present a NVMe PCI device, the controller
>>> must be derived from the PCI device:
>>>
>>> pci -> controller
>>>
>>> but now we have to express the NVMe hierarchy, too:
>>>
>>> pci -> ctrl1 -> subsys1 -> namespace1
>>>
>>> which actually works.
>>> We can easily attach several namespaces:
>>>
>>> pci -> ctrl1 ->subsys1 -> namespace2
>>>
>>> For a single controller and a single subsystem.
>>> However, as mentioned above, there can be _several_
>>> controllers attached to the same subsystem.
>>> So we can express the second controller:
>>>
>>> pci -> ctrl2
>>>
>>> but we cannot attach the controller to 'subsys1'
>>> as then 'subsys1' would need to be derived from
>>> 'ctrl2', and not (as it is now) from 'ctrl1'.
>>>
>>> The most logical step would be to have 'subsystems'
>>> their own entity, independent of any controllers.
>>> But then the block devices (which are derived from
>>> the namespaces) could not be traced back
>>> to the PCI device, and a PCI hotplug would not
>>> 'automatically' disconnect the nvme block devices.
>>>
>>> Plus the subsystem would be independent from the NVMe
>>> PCI devices, so you could have a subsystem with
>>> no controllers attached. And one would wonder who
>>> should be responsible for cleaning up that.
>>>
>>
>> Thanks for the details !
>>
>> My use case is the simple one with no nvme subsystem/namespaces:
>> - hotplug a pci nvme device (nvme controller) as in the following CLI 
>> (which automatically put the drive into a default namespace)
>>
>> ./qemu-system-aarch64 -nographic -M virt \
>>     -drive file=nvme0.disk,if=none,id=nvme-drive0 \
>>     -device nvme,serial=nvme0,id=nvmedev0,drive=nvme-drive0
>>
>> In the simple tree approach where subsystems and namespaces are not 
>> shared by controllers. We could delete the whole nvme hiearchy under 
>> the controller while unplugging it ?
>>
>> In your first message, you said
>>   > So if you hotunplug the PCI device you detach/destroy the controller
>>   > and detach the namespaces from the controller.
>>   > But if you hotplug the PCI device again the NVMe controller will be
>>   > attached to the PCI device, but the namespace are still be detached.
>>
>> Do you mean that if we unplug the pci device we HAVE to keep some nvme 
>> objects so that if we plug the device back we can recover them ?
>> Or just that it's hard to unplug nvme objects if they are not real qom 
>> children of pci device ?
>>
> Key point for trying on PCI hotplug with qemu is to attach the PCI 
> device to it's own PCI root port. Cf the mail from Klaus Jensen for 
> details.
> 
> Cheers,
> 
> Hannes

Thanks a lot from both of you. I missed that.

Damien






