Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F328ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 05:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sntSB-000794-Ch; Tue, 10 Sep 2024 01:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sntS7-000781-AF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:30:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sntS3-0006pG-Ti
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:30:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A2twH8004114;
 Tue, 10 Sep 2024 05:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QItfb+DCXWu3WpMbipplG6wfK1ySMJe9MddB+00XMCY=; b=
 IlkcmbhzYjRBMliEeJ1GpyplhTpJ7aHkS9U+RpPxt9HGwE8mK3fgNwhbqLQzYeNm
 Ud2mzqUkvQ6y47G3xcy2kP/tLZsO1j8SYgKWY4tEsgfoG9V/ENfJ0zwPhSWwfYEw
 3KZth9DzJP0odHpTPmoETSVIb8tRopKzvbHR1kAK17fRhk7+Sgw86EGkRCweiuCc
 EZon0a++FtZFMtWKqq7aZwM52MwNtgC+926IqXFWRAwIBNRh8baDrTTtwGinz/WN
 E3q3eZUUCCjyWWkdxGBHvlJIulG1zFKzMDYs8WLJ1TmhGTnCsu7Z9dzdzVhaAbW3
 M+1KEHnftQUYOju/rKoTSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbumdq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 05:30:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A2IBLk031577; Tue, 10 Sep 2024 05:30:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd98k2dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 05:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIusi3e0B5HTZgujV++imDWbBlWgvu8PSfg+fCbEOyiMZuxtaZ57rbW6seu6cIjngtPtKZewljFMx9akwBWEYEukUmRA1JQXQrOHXHb4aI7Fnvhhn/EUOwfU8e+ZLZeV20t8ctsReM4K7ay/gmsn6BX2Db6P+iuCQVJwSO45aHIiPEW43vGoTat33GotNXUEgfAEYlOBWEaWQExESZ/zRYKQ2LqliRX8j6ErxCh6zRMhoQL7Bze9NSNBs5XZAllWEtghuer6IsSuzZ0u1/fv18duWcqc6MKDrSqN6nVHJz2GbErNKMTJcERr7GpeTUZem/qlkWs75k92Ot7oWDGK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QItfb+DCXWu3WpMbipplG6wfK1ySMJe9MddB+00XMCY=;
 b=qn7cFaAodEKRS083AVI0i2l4hv3cbzK9LFDe2+Fb3w9VGtXCI+g4tX0cRNzxEuDxA339Y8aZPjLYf74mai2bgDjMXRvw5aRdekTFxZqGfTLjjDdGl3yh2T6/raBq+kpBwoWB2DTNQg7DfjN4XMz1Wxg8jaOxZLmyWt/q4Zx9AIQjve9jiIUglPnbvEc9b7AdkOHKuwqNQQg3ETpUBWBPpZRYJE8HuLYRg2igNMu8dpmZuHDFnhbLJ56ppix1uicHUcx3SLHJUovRI3YbJK6E/nuQ9AaEW3d/wdKUSQ8xtDjGi5eTuAn3MG1QeONLZoCD1qCmWwtO4uiNFwMiFEuWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QItfb+DCXWu3WpMbipplG6wfK1ySMJe9MddB+00XMCY=;
 b=fkOgUijnfTXFBfpB+JQIpgr1ftcsl1yEQ+If5PPc+YiEspHZpMgZOKIh6TSUChgi3NpRSV0NmNWfcQmt2Pz3OFfENjq1VOk2193jhjTLqINT7grsi4hG3riFu5gkV4BrvLDRhn7Q8y+SUTc8Mf3XQ0CIh+wd4Hb2R2EG6unN+vE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 05:30:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.7962.014; Tue, 10 Sep 2024
 05:30:01 +0000
Message-ID: <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
Date: Mon, 9 Sep 2024 22:29:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
 <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25)
 To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa3c6c2-279b-42c5-8859-08dcd1599dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUlvTXA5RHR3V3FVelhWNHVWRENZUjk5blJFb1JYdjFRRS9ONmRGY3I5Wjc3?=
 =?utf-8?B?TFY1akZ4ME9HSmZET013UGs3bDgxcjBUcHorT25VR3FnUk13SExPWkVKdzh3?=
 =?utf-8?B?UTFXU296NFgxVVFPNTVyNVdsREJIVDZQSmR4ZkI5S3ZUai85VGxDT0d1dFpB?=
 =?utf-8?B?a2tXVjNoSm1Iem5EUUFQcDJ0aEVwUy9DV0FiRzN5S3FSZkFKN0xDRlJoZlk3?=
 =?utf-8?B?dTBtTWpGL0IzMGRmcThiZkNnTjFYamE5cnJtZ2g1ajUrZGhvYzhkZFZScXNO?=
 =?utf-8?B?MnBwallBZ21RdnVVNEJjdVAyUzhGdGliL2JnTnlEY3ZOVXN0a2hLMUx6UnBV?=
 =?utf-8?B?T08zM3JLbjREalpSWWFpTkw4VFN6Z2JSVmZxYW9tSlFxOVJQME5hRGdEYVlV?=
 =?utf-8?B?ZjVsWW5pM3VEdTY5QkdEb1U0eEdhbG5KZ3pqV3U1MWtXU0h2Y20rdXJzWWdE?=
 =?utf-8?B?MEdmVUFrdmE0QThBRWZzb0hQTENiSE53YTVGazNMOXQ0dUJPbFlQZ0ZBUDZy?=
 =?utf-8?B?aFUvTzlTb1RvdlVzZFBubDhSS2I3djBKSWtxM3FZZ0xvOGc5ZXFlY2JueDI0?=
 =?utf-8?B?Y2ZyODRnZ0VkVTZlbFNXaVJKV2dEd211Vm1wUUVnZkNUQkFXaWQ5RVhVL1Zz?=
 =?utf-8?B?dFFNOFBhNXl1azV0b3l3STljU1k2SjljZ0RTMTVsekxYZ3FMTm1mVmFNVTQr?=
 =?utf-8?B?Vk9Qai9XdldKOE5kQnJNVjhiVjJ4K1AzS0x1ZDVSRzI1OGdCUlJSMmlKT0pI?=
 =?utf-8?B?WVpudEc4Q25xK1dCWnNaODJyM2k2b2ZOQ2t2V0J2SHJWN2ZzRTVwVWpiQm92?=
 =?utf-8?B?UExZUFNWTElmMWd0SEVRbGdhNTJQVml3S0x1NHZucUpVZVpmY0I3NXJYMzJT?=
 =?utf-8?B?VXhjaW5kUlh4NFZ4THBvZEo1S2lGV1JQKytnVVB4dVhUZVFqMER6RVVITVNP?=
 =?utf-8?B?N2pvOUdVYTBOYmhnVkRkdUVPbi9FZVozT1lzN3RLNjBQVmxZNnZqMEZFUUlQ?=
 =?utf-8?B?U1FEK1B4ZFA3NDA2NzIzSS9MaFQycHF4Z2k5dTY3SW9SWFgwcDZNcmdET2Vu?=
 =?utf-8?B?cHFBdUU2aWdGZzhub0JVaUYyOGxUUGZCNmd0TitGU0N5ZGhRUXI2Vnl4UnJq?=
 =?utf-8?B?K2lUZW1kalNRcllMaVZxS3Y4aGpnc21INVdyRjRnd1MvSW9jSDZwc3hrSzRa?=
 =?utf-8?B?cGJqOEphSXNndzNuWUJlMWxLeS9iRVB4WHRWMmtHd2QzUm9kamF6R3JxVEZl?=
 =?utf-8?B?ekhLWkFYVkhSU3kyZUJ5UHYxVFRjQkpQTTRiZ2Q4TUl6T2xaKzRSUWdodnVu?=
 =?utf-8?B?dHhuc3RBV1pYelBSMGVVQ1BkSmNCdi9EVzZaZGtJOHZCdU5qRis2eWhwNTQ1?=
 =?utf-8?B?MUd3UEFaRkhsejBGVDJSRXVROXVNbFRweDk1RXVtUjBSWjhPV3duRnczOVBX?=
 =?utf-8?B?Q3lUeVhQY0NLYXh4bHFlNnRUTHVmMzNoNy92TjFHNWZhc0Rid1JJbklXSlZk?=
 =?utf-8?B?NXJLeTY1R013MHZZL25kTG9IbDZ2TnpMemNTMDVzZmJ5dGZqQVVCeTVNNHNH?=
 =?utf-8?B?NGNlYzJ0dmMzSTc2NVJ4VzQ4WllJUnpNNlpSVnh5YXI2NWxLeHJ5OXNKYVVs?=
 =?utf-8?B?NFA3NElaeEY1VzZYUVdvTGtXUUxDQVVhRFJ0N2UzNEQvTVJRdjFOTWZ1OWlq?=
 =?utf-8?B?azNJRnRnUFhWZithMnB1OFpKaTVlcFBkem5HVUhBK2JlSUFDWnZiWTU1WDVu?=
 =?utf-8?B?SUU1NnM1aGpubU9UWkJ4allTMUNROS90MnVvS2xQcTh4dXozYmdDUHAwMWtK?=
 =?utf-8?B?clVJWjdBVVZHYUw3cXJqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRHMnZDU1krc0FZbWF6M0MxTDVoYlIyVE9ndVhHMTc5RVlZK0JQR04xOEp0?=
 =?utf-8?B?ODhieE94RCtvWllxeWdQMk5seEtmb3BKM3hTWDM1NlR2aTg4ZXVJUUhZUnVE?=
 =?utf-8?B?RW1pRXFnWXBiVmEzZWlUa3N1bGREWDM0ejNNdXlUd2FFYnp2VUNMYWNCbitP?=
 =?utf-8?B?Qytrc3piZTF1Lzk0czhwbTdnUEYzWVhRdjJKWnBMeFdGblNZVVlkazVVekVW?=
 =?utf-8?B?ZkoxVjZEU1VvbUdhNXlIRzBUczJNcFpxdVB0cHk0UkpjdXRPRXVoQ1MxcGUy?=
 =?utf-8?B?dUQrbjdPTUxJam9MNUsrTEpzVEZrN0NOS0kwWTdUbFVXVFZHY1JpWE5tbUN1?=
 =?utf-8?B?bllWSTcwZnI5R3RuUkRMK0h6YkRlZys2ZTFoZUszMFBsQ1A2R3lJS3M3VHYy?=
 =?utf-8?B?NCtIMnVrN21kM00yWThmYjcxSmxLbHRSbGw4YThKVWxpUStQcnZJZTY2WE80?=
 =?utf-8?B?R0crYVhZem1qU3ZzQ1UzUUFtd2ttN213bDlzL1FZaDZFKzk0WlNGc3dWTmNa?=
 =?utf-8?B?cmF4R1dCQVNraWE1SDl3eDhRbkQ3RTRFU1RvZi80V0ZSK2dERW1TUHZWWk0x?=
 =?utf-8?B?aGtWVi8yWTA4b2VpdDE2b3k1ZmsxTCtxQzIzZ0VoWEl4SFMyY1F3VVUyNUlm?=
 =?utf-8?B?T1RWK3BhK2NiQ05rdGRKajdpR1E4SGVXUkUrc0Y3WG5wcEd3MEtjbjNhQ0RI?=
 =?utf-8?B?UVFNSzNQSEJ1OWJ1RjFqVWNsYkN0WFlwc0g3WXJoWFdid05LalFCT0JMU3Za?=
 =?utf-8?B?Sk9OL1ZadmdENFdhODZNQTRJUlVqaHhKQ3NhWndjWUc1K0h2R214WFNsVytE?=
 =?utf-8?B?SmV6RzBOcEtCOUQwZ0w1bERscVcyL2N3OXBnQ2U4WGs3RGJWbGcrR1JhZGJa?=
 =?utf-8?B?U2pzVTg2WWd3MW9FdXlaVUhnUnhBaGs2UHVpcXlvdkxBYkhuUURiMzQwZkhC?=
 =?utf-8?B?eXowSmw0TTB3NnlGUm1JTmlMTXR1UHBZS1BPMnF6cXZwMGF1VW4yclUzNHBa?=
 =?utf-8?B?ZXBuaHVoOXpYRHJNLzJxcVoxc21pWjUrcXdVK1JNZS81a1F1bWxCODdLZU83?=
 =?utf-8?B?OFIyTmZ0NUs2cGI1eWtCQVhKR1BaMnBINFE0YjBlYmQxUmJBV2c4dmFxQnlR?=
 =?utf-8?B?THo1Q1gzMjJxVHVrbGwrRGxWeVVaalRraHRrNEtoWW5IVkJWcW4ybnVjcXRR?=
 =?utf-8?B?eEFydlZxMzQyYmx0RjNhb0hXV2JxVTRkdVZzQ2dxL0k2Njdzd1BiR3VYaEFS?=
 =?utf-8?B?T2htL3hkMmIxOUM0QmVCeUdaT2ZwQjVkbHNNMHVHSDMvakVqM1A1SjhhdlhE?=
 =?utf-8?B?Y3J5d2xRY3lQQmdqZHllUmkrUHFaRGk5b2FJTXk0WXRYOUVKbGpaMGQvZ1RN?=
 =?utf-8?B?YlBsd0wwQkE0S01vZkdhS2c0b3dWcFFPTlFjOUVMRWR2UkFmNkJKcFpyclJ0?=
 =?utf-8?B?bmloUEROZmVVN0Z6SUJwNEdhZEY5TTNDNXZCUVpLM3NwNUcvSkg5VkZiWGp3?=
 =?utf-8?B?c2dQWHJoM1c3Y0JvT0NVRndlOVBjTjY3TzRicWZ2U1Y3Rml2Z0JFYys3SEh6?=
 =?utf-8?B?Q2h1djNRd3FlSnZSa2VsRDZwNXJ4OFJ0eEJZdFNTZ3l5d0xkUmxoYUxGcHNO?=
 =?utf-8?B?YmtNaTlhdVJORFNHZUdXbWVXTXFYZk04dWhNK1lwLzVCWkxIYzYxSlRxOWNx?=
 =?utf-8?B?WjYvSnJ1QUpDMmZUelRxZEpyMUdGa2JXNnlnUm5iT0IyUW90S3haYkNmVkJK?=
 =?utf-8?B?SXVwSW5KeDZqZFpXOVRPUFo3N053TlhUcjdoY1VmNGxLaFRJZmJ4ODNuTE9Q?=
 =?utf-8?B?MkVEbHNGb1NDc1RJN2swVTlmcDBwcldLOC9tcEtMcnF1UDZaa1lYQU9RMER5?=
 =?utf-8?B?SzBWVFlNTk80bVZJQnRXSE9vbUxJMEh6YzBNeDVOVmFvRFFyekh3U0lKVGdO?=
 =?utf-8?B?SlJ0QktaM1JuMmhGRGU3WHdqaWcyT3psZWxhMDNOUlorbWR0N2RnZlpVMnUw?=
 =?utf-8?B?Z21QbUdHMjBBVzluOWpMOTBwN3lyeEcveE9CS09VcUlHSGJOdVMxYnVNRzlL?=
 =?utf-8?B?S0ZSMWVFeXlzcHNUZ0taT2E0U04wd3o4NmVUYkRVaUkzeTRUaHlGYWM0YmF4?=
 =?utf-8?Q?GDJUooG5rmQraod0+jw+kyO08?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ekpC//DhIwfPHMprQj043DEcQnKDJplUO3C81JBrgbpRvBUETamKyhlXxEBy+SloV8G3zdHURpZ4gEdNkZyuMnkYsfYwP8tlpHa5hfp+0FaWlVvqsXc8Sq/0Y0qmXb3Xbau4F+ofEEYSfAHQnBGHmZsOf/aVGmj4TrNIWjK6I5sQCnsBR1Id7kLiURQ5qSn9Gv4t/wr0LBgJt/1O2dHLY/btnuGSle7CPdtXoyYpMtH/jkoIJBaNPwPoYkqAMmlbXd52/Jj1uGWvczm7SQahHSa6s1pkgHVinI0UwEFj9F5l7+5Rv6+JLkEIniJ+SKwOTFIrSERROeX0hgohpyqgXREfEYl4ApUB0b4UVR7qj40WJ8GVkeRsEjZbm1JpdD2EQNCy8alYlKFDYvDV+cAkbjNRgfJSDriHaviGjBOb659qa66ardajrlHzKBEvLE5TwWFRs3Op9s5K43yoVlRGLTu78vm2XlCO2zgeh54SNUxGWWpNriRrarmQXPyud23Lu/HxwJUT8IzXHwhtlnNyY6pMp4MyJLSmFaZAKUZ3pX2L+M6QXg89YPoNcH5IU3pN8tCl5xMinpqQvp/cyOLy6K3MIwS+L5n24JRBSuRy9Is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa3c6c2-279b-42c5-8859-08dcd1599dea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:30:01.3476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJYvk86fkCFl9Zj7qBcwPrsiT3OALdt2FuwZvifqYJbbpNa18xeoGfW+7iOuLdZDjPaq9DIsIa9GkpMvMA/w/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100039
X-Proofpoint-GUID: JpDU86SHLI9jfsAypPZOZFzqo_jYCtXG
X-Proofpoint-ORIG-GUID: JpDU86SHLI9jfsAypPZOZFzqo_jYCtXG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sorry for the delayed response, it seems I missed the email reply for 
some reason during the long weekend.

On 9/2/2024 4:09 AM, Eugenio Perez Martin wrote:
> On Fri, Aug 30, 2024 at 11:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
>>> On Fri, Aug 30, 2024 at 6:20 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
>>>>> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>>>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>>>>>> will hold all IOVA ranges that have been allocated (e.g. in the
>>>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>>>>>
>>>>>> A new API function vhost_iova_tree_insert() is also created to add a
>>>>>> IOVA->HVA mapping into the IOVA->HVA tree.
>>>>>>
>>>>> I think this is a good first iteration but we can take steps to
>>>>> simplify it. Also, it is great to be able to make points on real code
>>>>> instead of designs on the air :).
>>>>>
>>>>> I expected a split of vhost_iova_tree_map_alloc between the current
>>>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
>>>>> similar. Similarly, a vhost_iova_tree_remove and
>>>>> vhost_iova_tree_remove_gpa would be needed.
>>>>>
>>>>> The first one is used for regions that don't exist in the guest, like
>>>>> SVQ vrings or CVQ buffers. The second one is the one used by the
>>>>> memory listener to map the guest regions into the vdpa device.
>>>>>
>>>>> Implementation wise, only two trees are actually needed:
>>>>> * Current iova_taddr_map that contains all IOVA->vaddr translations as
>>>>> seen by the device, so both allocation functions can work on a single
>>>>> tree. The function iova_tree_find_iova keeps using this one, so the
>>>> I thought we had thorough discussion about this and agreed upon the
>>>> decoupled IOVA allocator solution.
>>> My interpretation of it is to leave the allocator as the current one,
>>> and create a new tree with GPA which is guaranteed to be unique. But
>>> we can talk over it of course.
>>>
>>>> But maybe I missed something earlier,
>>>> I am not clear how come this iova_tree_find_iova function could still
>>>> work with the full IOVA-> HVA tree when it comes to aliased memory or
>>>> overlapped HVAs? Granted, for the memory map removal in the
>>>> .region_del() path, we could rely on the GPA tree to locate the
>>>> corresponding IOVA, but how come the translation path could figure out
>>>> which IOVA range to return when the vaddr happens to fall in an
>>>> overlapped HVA range?
>>> That is not a problem, as they both translate to the same address at the device.
>> Not sure I followed, it might return a wrong IOVA (range) which the host
>> kernel may have conflict or unmatched attribute i.e. permission, size et
>> al in the map.
>>
> Let's leave out the permissions at the moment. I'm going to use the
> example you found, but I'll reorder (1) and (3) insertions so it picks
> the "wrong" IOVA range intentionally:
>
> (1)
> HVA: [0x7f7903ea0000, 0x7f7903ec0000)
> GPA: [0xfeda0000, 0xfedc0000)
> IOVA: [0x1000, 0x21000)
>
> (2)
> HVA: [0x7f7983e00000, 0x7f9903e00000)
> GPA: [0x100000000, 0x2080000000)
> IOVA: [0x80001000, 0x2000001000)
>
> (3)
> HVA: [0x7f7903e00000, 0x7f7983e00000)
> GPA: [0x0, 0x80000000)
> IOVA: [0x2000001000, 0x2080000000)
>
> Let's say that SVQ wants to translate the HVA range
> 0xfeda0000-0xfedd0000. So it makes available for the device two
> chained buffers: One with addr=0x1000 len=0x20000 and the other one
> with addr=(0x20000c1000 len=0x10000).
>
> The VirtIO device should be able to translate these two buffers in
> isolation and chain them. Not optimal but it helps to keep QEMU source
> clean, as the device already must support it. I don't foresee lots of
> cases like this anyway :).
Hmmm, this scheme will only work if the aliased map doesn't go away 
immediately. If the BQL is not held or an unmap is to be done out of RCU 
critical section, it's pretty dangerous to assume we can be always fine 
to work with the other overlapped regions. In my opinion if we have to 
work with the HVA tree, it'd be ideal for the caller(s) to get more aid 
in helping figure out the right IOVA range in match rather than for SVQ 
or vhost-iova-tree to blindly pick a random one or break up contiguous 
range into pieces (in an inconsistent and unnecessary way). This would 
require a bit extensive changes to all the callers to pass in more 
information though, like the GPA, or the RAMBlock/MemoryRegionSection 
backing the relevant guest memory, along with the offset.

> About the permissions, maybe we can make the permissions to be part of
> the lookup? Instead of returning them at iova_tree_find_iova, make
> them match at iova_tree_find_address_iterator.
Yes, if there's no easy way out we have to add this extra info to the 
HVA tree and make the lookup routine even complex (or duplicative).

>
>>> The most complicated situation is where we have a region contained in
>>> another region, and the requested buffer crosses them. If the IOVA
>>> tree returns the inner region, it will return the buffer chained with
>>> the rest of the content in the outer region. Not optimal, but solved
>>> either way.
>> Don't quite understand what it means... So in this overlapping case,
>> speaking of the expectation of the translation API, you would like to
>> have all IOVA ranges that match the overlapped HVA to be returned? And
>> then to rely on the user (caller) to figure out which one is correct?
>> Wouldn't it be easier for the user (SVQ) to use the memory system API
>> directly to figure out?
>>
> All of them are correct in the translation path. The device should be
> able to work with a buffer that spans over different IOTLB too. You
> can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
> If the region is not big enough to contain the whole buffer, the
> device must keep looking for the rest of it.
Yeah I see why you prefer working with HVA tree even with overlapping 
ranges, as the current API virtqueue_map_desc() that returns the HVA 
already wraps up the translation internals well for e.g. when span over 
different IOMMU.  Are you worry with the vIOMMU case where the GPA is no 
longer cached in the virtqueue elem? Maybe we can add also that 
information to the elem even for vIOMMU (we can defer doing it until we 
add the vIOMMU support to SVQ), so that SVQ can just look up the GPA 
tree directly in the translation path?
>
>> As we are talking about API we may want to build it in a way generic
>> enough to address all possible needs (which goes with what memory
>> subsystem is capable of), rather than just look on the current usage
>> which has kind of narrow scope. Although virtio-net device doesn't work
>> with aliased region now, some other virtio device may do, or maybe some
>> day virtio-net would need to use aliased region than the API and the
>> users (SVQ) would have to go with another round of significant
>> refactoring due to the iova-tree internal working. I feel it's just too
>> early or too tight to abstract the iova-tree layer and get the API
>> customized for the current use case with a lot of limitations on how
>> user should expect to use it. We need some more flexibility and ease on
>> extensibility if we want to take the chance to get it rewritten, given
>> it is not a lot of code that Jonah had showed here ..
>>
> Let me know if they are addressed here. Sorry if I didn't explain it
> well, but I'm not trying to limit the alias or to handle just a subset
> of them. I'm trying to delegate the handling of these to the device as
> much as possible, as the device already needs to handle them and the
> less we complicate the QEMU solution, the better. Of course, the IOVA
> tree is a very self-contained area easy to rewrite in theory, but with
> potential future users it might get complicated.
Sure, understood. I just want to compare the Pros and Cons for each 
candidate, so that Jonah won't spend quite a lot of time to come up with 
complicated code, then soon find out all or most of them have to be 
thrown away, due to short sighted design which is unable to cope with 
foreseeable future use cases.

Thanks,
-Siwei

>
>>> The only problem that comes to my mind is the case where the inner
>>> region is RO
>> Yes, this is one of examples around the permission or size I mentioned
>> above, which may have a conflict view with the memory system or the kernel.
>>
>> Thanks,
>> -Siwei
>>
>>> and it is a write command, but I don't think we have this
>>> case in a sane guest. A malicious guest cannot do any harm this way
>>> anyway.
>>>
>>>> Do we still assume some overlapping order so we
>>>> always return the first match from the tree? Or we expect every current
>>>> user of iova_tree_find_iova should pass in GPA rather than HVA and use
>>>> the vhost_iova_xxx_gpa API variant to look up IOVA?
>>>>
>>> No, iova_tree_find_iova should keep asking for vaddr, as the result is
>>> guaranteed to be there. Users of VhostIOVATree only need to modify how
>>> they add or remove regions, knowing if they come from the guest or
>>> not. As shown by this series, it is easier to do in that place than in
>>> translation.
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>> user does not need to know if the address is from the guest or only
>>>>> exists in QEMU by using RAMBlock etc. All insert and remove functions
>>>>> use this tree.
>>>>> * A new tree that relates IOVA to GPA, that only
>>>>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
>>>>>
>>>>> The ideal case is that the key in this new tree is the GPA and the
>>>>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
>>>>> the key and translated_addr is the vaddr. We can create a new tree
>>>>> struct for that, use GTree directly, or translate the reverse
>>>>> linearly. As memory add / remove should not be frequent, I think the
>>>>> simpler is the last one, but I'd be ok with creating a new tree.
>>>>>
>>>>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
>>>>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
>>>>> this tree, and only remove the associated DMAMap in iova_taddr_map
>>>>> that matches the IOVA.
>>>>>
>>>>> Does it make sense to you?
>>>>>
>>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>>>> ---
>>>>>>     hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>>>>>>     hw/virtio/vhost-iova-tree.h |  1 +
>>>>>>     hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>>>>>>     net/vhost-vdpa.c            | 13 +++++++++++--
>>>>>>     4 files changed, 70 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>>>> index 3d03395a77..32c03db2f5 100644
>>>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>>>>>>
>>>>>>         /* IOVA address to qemu memory maps. */
>>>>>>         IOVATree *iova_taddr_map;
>>>>>> +
>>>>>> +    /* IOVA tree (IOVA allocator) */
>>>>>> +    IOVATree *iova_map;
>>>>>>     };
>>>>>>
>>>>>>     /**
>>>>>> - * Create a new IOVA tree
>>>>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
>>>>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
>>>>> implementation detail.
>>>>>
>>>>>> + * - IOVA allocator (iova_map)
>>>>>> + * - IOVA->HVA tree (iova_taddr_map)
>>>>>>      *
>>>>>> - * Returns the new IOVA tree
>>>>>> + * Returns the new VhostIOVATree
>>>>>>      */
>>>>>>     VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>     {
>>>>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>         tree->iova_last = iova_last;
>>>>>>
>>>>>>         tree->iova_taddr_map = iova_tree_new();
>>>>>> +    tree->iova_map = iova_tree_new();
>>>>>>         return tree;
>>>>>>     }
>>>>>>
>>>>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>     void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>>>     {
>>>>>>         iova_tree_destroy(iova_tree->iova_taddr_map);
>>>>>> +    iova_tree_destroy(iova_tree->iova_map);
>>>>>>         g_free(iova_tree);
>>>>>>     }
>>>>>>
>>>>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>>>         /* Some vhost devices do not like addr 0. Skip first page */
>>>>>>         hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>>>>
>>>>>> -    if (map->translated_addr + map->size < map->translated_addr ||
>>>>> Why remove this condition? If the request is invalid we still need to
>>>>> return an error here.
>>>>>
>>>>> Maybe we should move it to iova_tree_alloc_map though.
>>>>>
>>>>>> -        map->perm == IOMMU_NONE) {
>>>>>> +    if (map->perm == IOMMU_NONE) {
>>>>>>             return IOVA_ERR_INVALID;
>>>>>>         }
>>>>>>
>>>>>>         /* Allocate a node in IOVA address */
>>>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>>>>>                                    tree->iova_last);
>>>>>>     }
>>>>>>
>>>>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>>>     void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>>>     {
>>>>>>         iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>>>> +    iova_tree_remove(iova_tree->iova_map, map);
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * Insert a new mapping to the IOVA->HVA tree
>>>>>> + *
>>>>>> + * @tree: The VhostIOVATree
>>>>>> + * @map: The iova map
>>>>>> + *
>>>>>> + * Returns:
>>>>>> + * - IOVA_OK if the map fits in the container
>>>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>>>>>> + */
>>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>>>>> +{
>>>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>>>> +        map->perm == IOMMU_NONE) {
>>>>>> +        return IOVA_ERR_INVALID;
>>>>>> +    }
>>>>>> +
>>>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>>>>>     }
>>>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>>>> index 4adfd79ff0..8bf7b64786 100644
>>>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>>>                                             const DMAMap *map);
>>>>>>     int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>>>     void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>>>>>
>>>>>>     #endif
>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>>> index 3cdaa12ed5..6702459065 100644
>>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>>>         if (s->shadow_data) {
>>>>>>             int r;
>>>>>>
>>>>>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>>>>             mem_region.size = int128_get64(llsize) - 1,
>>>>>>             mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>>>
>>>>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>             r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>>>>             if (unlikely(r != IOVA_OK)) {
>>>>>>                 error_report("Can't allocate a mapping (%d)", r);
>>>>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>>>             }
>>>>>>
>>>>>>             iova = mem_region.iova;
>>>>>> +
>>>>>> +        /* Add mapping to the IOVA->HVA tree */
>>>>>> +        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>>>>>> +        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>>>>>> +        if (unlikely(r != IOVA_OK)) {
>>>>>> +            error_report("Can't add listener region mapping (%d)", r);
>>>>>> +            goto fail_map;
>>>>>> +        }
>>>>> I'd say it is not intuitive for the caller code.
>>>>>
>>>>>>         }
>>>>>>
>>>>>>         vhost_vdpa_iotlb_batch_begin_once(s);
>>>>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>>>>>      *
>>>>>>      * @v: Vhost-vdpa device
>>>>>>      * @needle: The area to search iova
>>>>>> + * @taddr: The translated address (SVQ HVA)
>>>>>>      * @errorp: Error pointer
>>>>>>      */
>>>>>>     static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>>>>>> -                                    Error **errp)
>>>>>> +                                    hwaddr taddr, Error **errp)
>>>>>>     {
>>>>>>         int r;
>>>>>>
>>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>         r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>>>>>         if (unlikely(r != IOVA_OK)) {
>>>>>>             error_setg(errp, "Cannot allocate iova (%d)", r);
>>>>>>             return false;
>>>>>>         }
>>>>>>
>>>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>>>> +    needle->translated_addr = taddr;
>>>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>>>>>> +    if (unlikely(r != IOVA_OK)) {
>>>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>>>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>>         r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>>>>>                                needle->size + 1,
>>>>>>                                (void *)(uintptr_t)needle->translated_addr,
>>>>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>>>         vhost_svq_get_vring_addr(svq, &svq_addr);
>>>>>>
>>>>>>         driver_region = (DMAMap) {
>>>>>> -        .translated_addr = svq_addr.desc_user_addr,
>>>>>>             .size = driver_size - 1,
>>>>>>             .perm = IOMMU_RO,
>>>>>>         };
>>>>>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>>>>>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>>>>>> +                                 errp);
>>>>>>         if (unlikely(!ok)) {
>>>>>>             error_prepend(errp, "Cannot create vq driver region: ");
>>>>>>             return false;
>>>>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>>>         addr->avail_user_addr = driver_region.iova + avail_offset;
>>>>>>
>>>>>>         device_region = (DMAMap) {
>>>>>> -        .translated_addr = svq_addr.used_user_addr,
>>>>>>             .size = device_size - 1,
>>>>>>             .perm = IOMMU_RW,
>>>>>>         };
>>>>>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>>>>>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>>>>>> +                                 errp);
>>>>>>         if (unlikely(!ok)) {
>>>>>>             error_prepend(errp, "Cannot create vq device region: ");
>>>>>>             vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>>>> index 03457ead66..81da956b92 100644
>>>>>> --- a/net/vhost-vdpa.c
>>>>>> +++ b/net/vhost-vdpa.c
>>>>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>>>>>         DMAMap map = {};
>>>>>>         int r;
>>>>>>
>>>>>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>>>         map.size = size - 1;
>>>>>>         map.perm = write ? IOMMU_RW : IOMMU_RO,
>>>>>> +
>>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>         r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>>>>>         if (unlikely(r != IOVA_OK)) {
>>>>>> -        error_report("Cannot map injected element");
>>>>>> +        error_report("Cannot allocate IOVA range for injected element");
>>>>>>             return r;
>>>>>>         }
>>>>>>
>>>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>>>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>>>>>> +    if (unlikely(r != IOVA_OK)) {
>>>>>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>>>>>> +        goto dma_map_err;
>>>>>> +    }
>>>>>> +
>>>>>>         r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>>>>>                                vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>>>>>         if (unlikely(r < 0)) {
>>>>>> --
>>>>>> 2.43.5
>>>>>>


