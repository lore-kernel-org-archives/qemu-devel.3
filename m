Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEADC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcszU-0004PA-Fi; Tue, 28 Jan 2025 16:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tcszS-0004Og-9q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:19:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tcszO-0004l1-RA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:19:22 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLHIYJ014316;
 Tue, 28 Jan 2025 21:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Do2uWwJgd6wp8T/Zg3wu8htiAWCHyIeRFDbJkQxRc9o=; b=
 WVevwW1r/RsARr5vCkiKbwLxEPcsQGL/a4mICcB5dSPY8Svzq9lEpUBQ2Fjk0WaK
 Du3zQV7bjb8XBkts89wdGBH18S1hHhseHLz0BF509qrh6rH0piR9v2x4f08aLT69
 55J8+AMKC1K9bkZkYP/Vzq7psTji33wY93UkJWny3oGcY5Gm5LYH0tcxkkeKUF9g
 eo+67WL+3KwBmgMW5dVUMljOfHouvaVEDDhWdNS65ooIOz+f8VuJkeOqYuLVDTh0
 hFNBmJxCUrhofJ1fz1Bxh2iAxGhSTwcQBrFwuewu2UP1QdSKnRXEKcI7IphxJ6Xj
 jhMKPiBWAnO+94vnEeEhBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f70u003r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:19:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50SJLSsh005356; Tue, 28 Jan 2025 21:19:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd8yuej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 21:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtfPCOl6mtqOzbDbAhFxWVmNrey/jOq5F7InAtQ8TnYM3YHZ3bwfBO8GqrOoOj/5F3QeMC9AQiLT9Z2h9UjURRsxnaFtzH/192lbDwy9CSGMGgUaiH70o9gg/UnU7BfB1qYLZH3g1bxsQpoc5LKVUXZO3gtNNDjnKqAf+tofcONRWKXR4RMhzo+IraNz725FYkOe5P5ILvsBEqf6UXpyicO8kfZZ3Z7Sg44y7F03Cv2F5HhZT4BDVVj3unwulvb1fqiGWjM72t4wO/+oruCVhN/eer329itifc2kx3MTL+WOd8/BZhxixuJBI+o4fIPMU+S5uQDZ5hCx+hi6O566+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do2uWwJgd6wp8T/Zg3wu8htiAWCHyIeRFDbJkQxRc9o=;
 b=qHMC4kzJe4Z8Nh99fIgJPtCWh0VO1oKR+C/BKVlR31X3ByY8Ikc0rk/lghWg0Zeoz5s5N98ctHjKvGHuxUIB0WmfNgb9lqGVvFvlVSh4tTSid42cZba/WvX+QbUHdXbySD2zvRL+KLpnJz854/IBHwFJmSKEeVex6sTRgmdC5M6c/h5mTvsCNHUnqtCO8IIZYVK4e0QudGjE8c+enBpc2r/T7pRbgosdWTlIfM1/s5sUIXDz7T19WcGGZx28T3KJfMqkGf4UQohgSDpK+ubPBKpRURZtSptLlesIEsLGVyzJH6BFYJ3JGjO5scNCrP8zkwdvXGdPkWpa//GhW8Bh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do2uWwJgd6wp8T/Zg3wu8htiAWCHyIeRFDbJkQxRc9o=;
 b=rghrPVS+VxzTYRFhkbAeMEx5PZsz7EcPCUT40fCRAmdUrd3Zj8+FhBuaQeJWUgs4BpdO5k9TpqVa6ST2FdcCrEL3fUV6HtDC1JqkONoTjHastPyBpufR0sKChPxlzv3QD2+4k+CNBhBu5BuIEh0yJOyO4ARF3a8Gv+PzrT1LAGk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB8166.namprd10.prod.outlook.com (2603:10b6:208:4fb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 21:19:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 21:19:10 +0000
Message-ID: <631f048e-22f7-43c8-bf19-7ecaf3072f7e@oracle.com>
Date: Tue, 28 Jan 2025 16:19:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <87ed1eakxr.fsf@pond.sub.org>
 <2ae6c272-837c-4d88-bcfa-fc7719cc447d@oracle.com>
 <87bjw5tv08.fsf@pond.sub.org>
 <3c5ef58e-8f2d-401f-9cbf-42598ab6287d@oracle.com>
 <878qqvgnj8.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <878qqvgnj8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:408:70::47) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c74d316-6abb-43e5-5804-08dd3fe167bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enFPVytNcHFLWHJyeGpvcEF1WDdRUW5WNWdmZ1FvbTNyWjV2VFdlNEkyVytk?=
 =?utf-8?B?RUtXRFVqNC95VTBwL3Nvc0lLN25POEdJWERoUDBRTGVxb01nUFpCdXorK3pM?=
 =?utf-8?B?NUZuUkM1blAvV1ZreDRFNnloREZuY2k2M1o2dHBnNnByY0lYTzRWUXZ4NU5E?=
 =?utf-8?B?Y1hjL1d2MFdzUk4zMzc1cTRCNzRoLzBKRWhrOVhSWHpWaUtRSyszRmI2NDZD?=
 =?utf-8?B?MER4ang2LzdLMy9HMGJ5R1Y2aXFwS2dZNzQ5ZVk5elcxaDJNSlRRczFhUVVF?=
 =?utf-8?B?VlhmK1pQTE1IMG92YW5ITzhHTlZRQmR4QTNERVJndDFzeUltQ2N2anFlanNx?=
 =?utf-8?B?OCtGZHduK3l5Y2JGSHRIV1BuY1U5UGJaRkdUNnFtdXN4QmpZeCtXN0NDeUg4?=
 =?utf-8?B?VWV3ZGNUVGRVY0MxblFqNGcrQkR2aWJyejZnQzZzcXhqWVBCZXkxQkhXVnZZ?=
 =?utf-8?B?RTFxRWYxTjBSbHhNODRjYmJrOGFKL0M0MTNISmVtNW56YldIYmlsQ2wyNzBW?=
 =?utf-8?B?MUpWa1ArTXFMM2RWY244MVFRdGJOemw1azE0Zm0xV252ZEhQL21HNFJERW5V?=
 =?utf-8?B?YVhsRWErSFgyc0d6cGgzakNBUVY1ZDZzV0E2VXprWlVKNkcvcVFyVFZmeTJl?=
 =?utf-8?B?bmtlNGk5MHcvL3Q2cVBTSnNMM3o3VE9RUzFweFVMSFhUMVNHZVRVVW5PYzhQ?=
 =?utf-8?B?Vk9lanErV1ZYZDFKL1Z2WFl1aS9wQSs5QWtVT0VhVEY5TXlPUkQ0MXN5SlZz?=
 =?utf-8?B?Nzk2cTJpVnhIVUt1NUVrVEZrSVhsSWhPUXZQODZUTFJvYWZnZFc3TFZISTRq?=
 =?utf-8?B?elFvaEdtajBwcndUelg0N2FuV0VkVFNnTkxLTSs5Q1hnMzQ2bkIyRWpGbGdW?=
 =?utf-8?B?ZmVSMFdsRkVKeEQ4N0IvV2NHWStxelNJdU5wb1p5VmErbDhRYUtHS0M0MWQ1?=
 =?utf-8?B?bExCcUh4aU5iRElDZGVsQnJFK01uZ0s2SnA5b3U3cDBZTDIxQ1V0eHRvVHY4?=
 =?utf-8?B?R0taRG9aUHAyK0kyL1V5MVB5QTVMV3ZyS0dQV3oxYzRQeElVbDdYR0ZQejdv?=
 =?utf-8?B?RFFQMktmZUhSQ3I5dmRRNEtHMTFmNERMQkZaZlB6Rjd2MUE4OFJ6VGVKWDlN?=
 =?utf-8?B?YURzZFBJa2VEc0FrOUFiN05lSjZtQ3MrSGlQNzI3VDEreTlpcHdzLzN0Zi9x?=
 =?utf-8?B?KzdTUGgwSXpPWVRqRGozQWlLRkk3aUZnS21DOGVmNy9ORFo2RkhNYjVwVkF5?=
 =?utf-8?B?QXRXZDVwTEFMS0o4Q0RFTCtBeGttQk1mSDNjclVHekxGMFRVd3RDOUFQcHF2?=
 =?utf-8?B?UGJwaDliNTNIZnl4OVcwRjFpZFpra3I3cEVTYzBmbElsWmtNcDdZRUdISnRN?=
 =?utf-8?B?ZTBzZmRqTW5ialVKalNxK3VqM1F6U3dFQ2RjTjAxUUo0ckNUVGN1WGNOUkJV?=
 =?utf-8?B?S05YQXhWMUFDSW90TTFwMWZkMEVDOTk5ODR4blhPVmg1M3FIQUNqTnZvaUlV?=
 =?utf-8?B?ckdCVTlScFhWVTFTbVM0VnBuT0l6ZHpzakNLUUtnMDM4MVYwTWlONDNSRkFr?=
 =?utf-8?B?Nm1uVitwTmwwY0hZbStMVHdRSEJYWVFKN2paaytNYnJHZnlCUkpPdW9uOEg3?=
 =?utf-8?B?dEl2NWpSRmdseGJGN25nMnZ1Slg1NmlQbk9oelQ5WlI5UlZmVklOdFRySm1I?=
 =?utf-8?B?a1dma0wvQ2RrMHhxZTk2YVhlSC9zbUVySU90OXBlOEsyb1BCZGNiNVNQVkFs?=
 =?utf-8?B?bWU2a0dKSlo3eHdLMWxSQXArT0VUQ3hGMkZMbk12MnhqVy9kaG4wS0UrUEJm?=
 =?utf-8?B?a2E1ZmQzSjhvejlZVUtOYlF1dndaY0lpNFFGeWxEclE0ZnNFbGpnUXl0WjEz?=
 =?utf-8?Q?MOnKgHJ18AwZw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGQ2Rmc3V0twNWVmaFRHMUdVMXBqbmRVM242UkRYdUZXZVNNdGp6UTRZaGdS?=
 =?utf-8?B?ZTNobU1HZE5vbUZsd1NkbXJkLzV6dlZzMTUrUEUvclAwRGhub3dYdEVpbVVn?=
 =?utf-8?B?NkVub2tYamZTZG9CRExFYXNVNzJia2VvcGhCV1EvUHhUVjNRbFQrRXc4Uk04?=
 =?utf-8?B?ZUw4dDl0TjQzcDJCZjQyNUVwVGtmNGFsVjhjTnBUQlc1N3NsakFkem01L1Jn?=
 =?utf-8?B?T1Iwb1BYRmpWdXA0dEJpTG9xeHlPLzlkeERmRURKSXB3NEUxRW5UUmtrMXZm?=
 =?utf-8?B?MCtZb0hocU45WE5XTWZpNm9VbkJjSUIvMWZuZS82QWxVeUhJbndyQzJxQjAx?=
 =?utf-8?B?QktBeGkxM0Nyd21Wa0R4dCtIMTZXcFJzcEM4REdOdS9uTnFod09TanRKUGlh?=
 =?utf-8?B?YlROVk5KcVQyK2NtQWRTdm84d1JxNEhlNjJvdnRCSEZkN2cyYlZ1MTlxNWFl?=
 =?utf-8?B?Ry8zUms1ZWV0ZzI2ek9LMnZvOXlUMlFiU29BS3ZNQXNkT1lSeHRLRGZjZ2h3?=
 =?utf-8?B?aG1idmlrRTAraTFldmhoMnlaMkdEL1hobWNaaWVjNFpIS0J6dW50L2NqOHBL?=
 =?utf-8?B?d3h3dFFRVDdzbE5NRXBSWGhLVW9uMHlYWFlKdGVQSlM3Y2pHY2VMQVcvT2Q5?=
 =?utf-8?B?MkFaK0w0cTdMNWdFdnNvaWRvQ2dtMEMzanRTdFpqOUdBK1hMZHBKN25xeGlL?=
 =?utf-8?B?SXh4SWgwSjhMVVFwSHd0ZDhybFFxVjFieTNvRkg3R2NkalJmdnRaaUpOSnUv?=
 =?utf-8?B?dXFTcXFwbkhPeHNuaHJjRWpOV1hxS0J0K2YxaTFOOFdKMUxWUkFBYUwycTU0?=
 =?utf-8?B?STk5UFdyelJLSVRJSjkvQmtZQXpaSmt1MkxySHVOek5tZmdPNG1MUEdUczB5?=
 =?utf-8?B?RUJ4dWJVdGQ3dUo2YVdFOHpnV2tLZFlDM2k0VU9vckRGZnBBNUVzQUg2bGZT?=
 =?utf-8?B?K0lYSDNhSm95bTFER0wxeXkrTldPMmw0Sk5VSkgzNC9BYktFV0JpaTdUeDFj?=
 =?utf-8?B?UFpDM3RaaGhia1I4aWtPQllnRmxFQUdrckpGRGtWVnp6Z0xKUC9IN2s0N0ZF?=
 =?utf-8?B?Z2VhcE9pZ0M0aHk2OVAzNHhUc1hMTnQ5WnplSU1MREV4WTIzYm9QOXhMb0xU?=
 =?utf-8?B?VDZOaXdRZys4anBzTDdWYnJBSXZTZSs4T21QeVh0THVaanlxd0MvQ0V4elIx?=
 =?utf-8?B?OU5SVWZOV28zd2ZhdjIxdms2T21RakhMMi81VDlUbUtjaExlNHZOa2ZHUE9J?=
 =?utf-8?B?b3pKS25SVXovZzhnOXNCbUN2OHpIalp2SDhLWFg4QzVzL3I3VGN6ZGNaSVRO?=
 =?utf-8?B?UnhHSVN3TWt0SDEwV3JGdEIxNXpnNHRFMkRCL1VHOU1SNkVhVHJCbzNJeGJD?=
 =?utf-8?B?bVRYTTRHM1VNYVFBUUZScUI1VkFJanpsbEdkaE50YnB0WlllUWJ5cXkrSURj?=
 =?utf-8?B?cXhJR094d0E1Z3NxZVdrR2E1aFpWdExaWFdpRGl6ejlnV1pXODhDZFNwbzcy?=
 =?utf-8?B?cUQ2YmtRM1NieHFIdGpteDJ4UkErT3dqY01nWUNid1cwQzNBb3NwdGhyM1k0?=
 =?utf-8?B?M1N3cUFuVWdYMENKZ1FYQ2VKMXpKMUxqVFlyb2s1N0hnZVY4LzRTdHFXMCti?=
 =?utf-8?B?bmIxeGpRQ1JIS2lidkViaVgrRDNKUUFsK2EvdldkSnRWczc3d0RsSnNiRVRq?=
 =?utf-8?B?VFJqTWlML3dxeFNyNmtIbE1CcklmZFk2M1NXQW5nVDlEQWo3VU9nTVpOVWJG?=
 =?utf-8?B?VEpQNkhGODJuWk1yUHA3Mi9KQWpmaWE0Z2tNMXUxNnBNZHZnVVdWVG93cjVH?=
 =?utf-8?B?V2RYMXhaeVVoWkdHWjc0VGNkSFI0cVJ5QTF2RThzd3AycU9zMHY5N2xlQlhi?=
 =?utf-8?B?RUtacHRUejM3YTUzVmlhdzJJUGQzck81bnlxRStKbEZkVXdpWVJ0b0FNYUZx?=
 =?utf-8?B?TjFMc21vYzlwZmMzSHQ4WUYyZS9QL1kyelBxUC9ENFNBMnV0WTJiRHRVbHpN?=
 =?utf-8?B?NGNhbG5wM2t6Q3ZXZmlsQnQ5MVBTY2NOWFluQmdLM1RWN3RkM2JYb082OTVQ?=
 =?utf-8?B?WnY4alFzNC9UM0V0NWJRcWljMThUM2JnREJBOEoySTVldG1ranpEMFZrNEtL?=
 =?utf-8?B?MWZ1Rk1vVXYwM1A5RS9oTUFRZVVSQmM5U295MjB1aUNWdWRFK0hJV0tOZnZF?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m1Yff1xRGzPv0af1RVnrT89NrFHjBASEYNsDQ5Cdam2sx99OHA8WxMOoP4e3eXQJoVaz8TK4IqGG8xRVFxd/S1MS6wqDCm9aozM8AmoxxXrbJ8nO+zz/y04C/C8nxqhCHIZ5Z7TmnESD3CF/7iS0K1pAHBLmzgggx4AgSwmP+MwP7tXckjzRzxSc8G+5yUniQSFpXYA+kdV8bf5uYdg7sLXGvevlzKZqef6f4H6m8QieHctaflD/YLzhtFXCg700pn9nFqUaQ9T6zTcqGoWMT/iYn5m9pwViqHtxJU2TJDO5Bv0LURGtXk6zMK5Lm/qLHTkVBrksH4B5IJw8U1+fjyIpgvDtS3p83q1qTVyEEFroNlaXkVBSJgCeKulRFzKHIZVeiqYPCIipV1MqRAe8EdaBaY2WzS1gWB5lEOnKzjXWRZmPH38SWEzEKCsqPYGoO+19GzLPOmli7mKZdL0dliMb9/p6+JgdCyYW3vKO7mehBU/8nViLLXYphlKwXk/+iSDQQf6CtKbusGCGo3CfmLpuagUesYdLE1PCVlMdK08mHyDO4K17qwQSReOKoBxKhVryPEdEwseuDCORyiusLcID351ccnO+tL0ORZVzH+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c74d316-6abb-43e5-5804-08dd3fe167bb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 21:19:09.9052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWXaUdOxj0qmkmvQ0g1lBHGC+wijxg6Xi/o7wd1m/HyWShZLG6FJSj6Bn9E4MdEJBQ6GatdXQIEomdm0f6utMvSk0W/EcpTuyloUY0a22f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280156
X-Proofpoint-ORIG-GUID: M3JSDVxs7dFoe3kv7CRCyOJdWRoYMd_r
X-Proofpoint-GUID: M3JSDVxs7dFoe3kv7CRCyOJdWRoYMd_r
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/28/2025 6:56 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 1/17/2025 8:44 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> On 1/7/2025 7:05 AM, Markus Armbruster wrote:
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>>
>>>>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>>>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>>>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>>>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>>>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>>>>> descriptor of the device that locked them remains open.
>>>>>>
>>>>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>>>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>>>>> be sent over the normal migration channel, because devices and backends
>>>>>> are created prior to reading the channel,
>>>>>
>>>>> Is that an artifact of the way QEMU starts up, or is it fundamental?
>>>>
>>>> Hi Markus, welcome back and Happy New Year!
>>>
>>> Thank you!  A late happy new year for you, too!
>>
>> Sorry for the delay, I have been heads down preparing a new series.
> 
> No sweat :)
> 
>>>> This is a deeply ingrained artifact.  Changing it would require radically
>>>> refactoring the information passed on the command line vs the information
>>>> passed via monitor.
>>>
>>> More on this below.
>>>
>>>>>>                                               so this mode sends CPR state
>>>>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>>>>> prior to creating devices or backends.  The user specifies the cpr channel
>>>>>> in the channel arguments on the outgoing side, and in a second -incoming
>>>>>> command-line parameter on the incoming side.
>>>>>>
>>>>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>>>>> which allows anonymous memory to be transferred in place to the new process
>>>>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>>>>> objects must have the share=on attribute, but memory-backend-epc is not
>>>>>> supported.
>>>>>>
>>>>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>>>>> arguments to create the same machine, plus the -incoming option for the
>>>>>> main migration channel, like normal live migration.  In addition, the user
>>>>>> adds a second -incoming option with channel type "cpr".  The CPR channel
>>>>>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>>>
>>>>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>>>>> a second migration channel of type "cpr" in the channels argument.
>>>>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>>>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>>>>> resumes.
>>>>>>
>>>>>> The implementation splits qmp_migrate into start and finish functions.
>>>>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>>>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>>>>> main migration channel.
>>>>>>
>>>>>> In summary, the usage is:
>>>>>>
>>>>>>      qemu-system-$arch -machine aux-ram-share=on ...
>>>>>>
>>>>>>      start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>>>>
>>>>>>      Issue commands to old QEMU:
>>>>>>        migrate_set_parameter mode cpr-transfer
>>>>>>
>>>>>>        {"execute": "migrate", ...
>>>>>>            {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> [...]
>>>>>
>>>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>>>>>> index f31deb3..2210f0c 100644
>>>>>> --- a/migration/vmstate-types.c
>>>>>> +++ b/migration/vmstate-types.c
>>>>>> @@ -15,6 +15,7 @@
>>>>>>     #include "qemu-file.h"
>>>>>>     #include "migration.h"
>>>>>>     #include "migration/vmstate.h"
>>>>>> +#include "migration/client-options.h"
>>>>>>     #include "qemu/error-report.h"
>>>>>>     #include "qemu/queue.h"
>>>>>>     #include "trace.h"
>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>> index a605dc2..35309dc 100644
>>>>>> --- a/qapi/migration.json
>>>>>> +++ b/qapi/migration.json
>>>>>> @@ -614,9 +614,47 @@
>>>>>>     #     or COLO.
>>>>>>     #
>>>>>>     #     (since 8.2)
>>>>>> +#
>>>>>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>>>>>> +#     new QEMU instance on the same host with minimal guest pause
>>>>>> +#     time, by preserving guest RAM in place, albeit with new virtual
>>>>>> +#     addresses in new QEMU.  Devices and their pinned pages will also
>>>>>> +#     be preserved in a future QEMU release.
>>>>>
>>>>> Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
>>>>> guest pause time by transferring guest RAM without copying it."
>>>>
>>>> "Checkpoint and restart migration mode" is ambiguous.  It would be
>>>> "Checkpoint and restart transfer migration mode".  That's a mouthful!
>>>> "This mode" is unambiguous, and matches the concise style of describing
>>>> options in this file.  Few if any of the options in this file repeat the
>>>> name of the option in the description.
>>>
>>> True.  But will readers understand what "CPR" stands for?  Do they need
>>> to understand?
>>
>> No, IMO they do not need to know the full spelling of the acronym to use the
>> functionality.  It is spelled out in a few places now.  It could be spelled
>> out in more places in the future.
> 
> Alright.
> 
>>>>> If you want to mention the guest RAM mapping differs between old and new
>>>>> QEMU, that's fine, but it's also detail, so I'd do it further down.
>>>>
>>>> I'll strike it.  I agree the user does not need to know.
>>>>
>>>>>> +#
>>>>>> +#     The user starts new QEMU on the same host as old QEMU, with
>>>>>> +#     command-line arguments to create the same machine, plus the
>>>>>> +#     -incoming option for the main migration channel, like normal
>>>>>> +#     live migration.  In addition, the user adds a second -incoming
>>>>>> +#     option with channel type "cpr".  The CPR channel address must
>>>>>> +#     be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>>
>>>>> Permit me to indulge in a bit of pedantry...  A channel address doesn't
>>>>> support SCM_RIGHTS, only a channel may.  A channel supports it when it
>>>>> is backed by a UNIX domain socket.  The channel's socket's transport
>>>>> type need not be 'unix' for that, it could also be 'fd'.
>>>>>
>>>>> Suggest something like "This CPR channel must be a UNIX domain socket."
>>>>>
>>>>> If you want to say why, that's fine: "This CPR channel must support file
>>>>> descriptor transfer, i.e. it must be a UNIX domain socket."
>>>>>
>>>>> If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
>>>>> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>>>> UNIX domain socket."
>>>>
>>>> OK.
>>>>
>>>>>> +#
>>>>>> +#     To initiate CPR, the user issues a migrate command to old QEMU,
>>>>>> +#     adding a second migration channel of type "cpr" in the channels
>>>>>
>>>>> in the channel's
>>>>>
>>>>>> +#     argument.  Old QEMU stops the VM, saves state to the migration
>>>>>> +#     channels, and enters the postmigrate state.  Execution resumes
>>>>>> +#     in new QEMU.
>>>>>> +#
>>>>>> +#     New QEMU reads the CPR channel before opening a monitor, hence
>>>>>> +#     the CPR channel cannot be specified in the list of channels for
>>>>>> +#     a migrate-incoming command.  It may only be specified on the
>>>>>> +#     command line.
>>>>>
>>>>> This is a restriction that could conceivably be lifted in the future,
>>>>> right?
>>>>
>>>> Yes, but lifting it requires the big command-line vs monitor restructuring
>>>> I mentioned earlier.  IMO that is far enough in the future (and possibly never)
>>>> that adding a "Currently" disclaimer would be deceptive.
>>>
>>> Now I'm confused.
>>>
>>> Earlier, you explained why we can't simply send CPR state via the normal
>>> migration channel: we create devices and backends much earlier long
>>> before we receive from the migration channel.  Correct?
>>
>> Correct.
>>
>>> Here, you're documenting that the CPR channel can only be specified on
>>> the command line, not with migrate-incoming.  Isn't that a different
>>> problem?
>>
>> They are entangled problems.
>>
>> * cpr state must loaded before backends are created
> 
> I understand this is fundamental, i.e. CPR state is *required* to create
> backends.  Correct?

Correct.

>> * monitor must be created after backends are created
>>     (because the chardevs that define a monitor are backends).
> 
> This is an artifact of the way we configure monitors (use of a character
> backend) and create character backends (all at once at a certain point
> in startup).
> 
> Some management applications would prefer to use the command line just
> for setting up QMP, and do everything else in QMP.  Understandable!
> They need to use QMP anyway, and mostly eliminating the command line
> would simplify things.  Moreover, only QMP provides introspection.
> 
> To enable this, we need to provide a way to start a QMP monitor early
> enough to set up everything else.  If we pull this off, "monitor must be
> created after backends are created" is no longer true.

Yes.  It's a big change, which is why I ventured "unlikely to change any
time soon".

> Aside: in my view, QMP and command line are transports wrapping around
> an abstract interface.  I'd like to have them wrap around the *same*
> abstract interface.
> 
>> * migrate-incoming must come after the monitor is created
> 
> Fundamental.
> 
>> ==> migrate-incoming cannot specify the cpr-state channel
>>
>> This restriction is unlikely to change any time soon, if ever.
> 
> I wouldn't bet my own money on this :)

OK, "if ever" is too pessimistic.

>> I have documented it as is, without speculating about future state.
>> If users do not like it they can request changes.
> 
> I'm not objecting to your doc text.  I asked to better understand your
> thinking, because I needed that for a competent review.
> 
>>>>> What happens if a user tries to specify it with migrate-incoming?  Fails
>>>>> cleanly?  What's the error message?
>>>>
>>>> It fails cleanly with a pre-existing error message that could be more
>>>> descriptive, so I will improve it, thanks.
>>>>
>>>>> Maybe simply:
>>>>>
>>>>>             Currently, the CPR channel can only be specified on the command
>>>>>             line, not with the migrate-incoming command.
>>>>>
>>>>> with a big, fat comment explaining the restriction next to the spot
>>>>> that reports the error.
>>>>>
>>>>>> +#
>>>>>> +#     The main channel address cannot be a file type, and for the tcp
>>>>>> +#     type, the port cannot be 0 (meaning dynamically choose a port).
>>>>>
>>>>> What's "the tcp type"?  URI "tcp:..." / channel
>>>>> addr.transport=socket,addr.type=inet?
>>>>
>>>> I will clarify.
>>>>
>>>>>> +#
>>>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>>>> +#     with the '-machine aux-ram-share=on' option.
>>>>>> +#
>>>>>> +#     When using -incoming defer, you must issue the migrate command
>>>>>> +#     to old QEMU before issuing any monitor commands to new QEMU.
>>>>>> +#     However, new QEMU does not open and read the migration stream
>>>>>> +#     until you issue the migrate incoming command.
>>>>>
>>>>> I think some (all?) instances of "old QEMU" and "new QEMU" would read
>>>>> better as "the old QEMU" and "the new QEMU".
>>>>
>>>> Maybe slightly,
>>>
>>> A second opinion from a native speaker would be nice.
>>
>> I have appreciated all your feedback and made many changes, and it has made
>> the code and documentation better.  Thanks for that. But right now, the V9
>> patches are queued, pass CI, and are ready to roll. I would hope at this point
>> that no one would consider "old QEMU" vs "the old QEMU" to be a showstopper
>> that requires new patches to be posted.
> 
> Certainly not a blocker.  If we decide it's an improvement we want, we
> can easily do it on top.
> 
> I routinely point out lots of little things that aren't blockers.  I try
> to be clear what is a blocker and what isn't, but I'm far from perfect
> there.  Thanks for your patience!

Thanks.  Sounds like we're good, and Fabiano can proceed with integration.

- Steve


