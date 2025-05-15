Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4D8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcJl-0004xS-6J; Thu, 15 May 2025 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFcJj-0004x0-30
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:24:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFcJh-0001gM-5S
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:24:22 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1n4b023207;
 Thu, 15 May 2025 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=a0OsHHGBPX9IrXU1Nzeoy+t06ajgTXbUp+Fu5751atI=; b=
 gadoFr6VDZXGaw+0JOcrrWOMlDO7CRNG55iUg2qp5lWY3asRBkD+DGJbbv9Xn6KL
 +ocI6EsGXryznWGWPvJNemXHeRIjZbbq82HLY7yydSTPN8RHi50FiWS0trFmxKhl
 T//1DO1ChqkovQQx6Jnh3J6Lht9ql/R+fHCjnplJers48Es/CUU1OFoDYbu+xfRq
 GC8DJAr3tw1bB7l9VXk3MkyldGqr23UDHZu8WH2DRnaXtLomK9Te3TqFkL6TBxfF
 KiJO+a9uyK2QXfkca6d11Y8w4k6//idQdW6fDbgd2FazQMcVP56Lk19G3BT9k874
 QepqJL3jj4wYhI39fn2P3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccvw02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:24:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FH8jYR016293; Thu, 15 May 2025 17:24:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mc35409p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMJu+8ndncqFRUYeSRpPkr3ffqTqaSkuT9yRgawwLbahOplyeB3zFv177jDW+N+IFb7VjCzLtcyfPjd6L0P4u+O3fIF4oX1doABmlX1fOK/dQb27Pp044YLR20nV8jWrMOCqdiubtT7/31bHTE/GFlBGUnPC5F2GBgnCWE2sndQS0LmH91nBWEnhLjWzegUc/Fj23Li6wRZlP8H2iqxazlQdhdqe1ArhxuszMNuoKaJaBBGNuLrc24aKlv1DVZUUPGl7+hR7jucjXabKnk8Cu/7htk27T5KuWGkGgg/gFtRhhbfj3dxlc3jPpm44QSmZrQEJunXPsGpQfKKRvv1qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0OsHHGBPX9IrXU1Nzeoy+t06ajgTXbUp+Fu5751atI=;
 b=w8SUZPWczYvvNVqWrG0gKyKZifVuA/nknkJ/YjtcuyJGT194fgVoSJNXk14Q25Cd/J05p1rH/MYf5oxfGZeRT9eaWBXawvtmk4lNgwu/2I2+3EHsZfXq7O3xcANRGNFFzkFYLqCgT66HsblcuZzwRuVzV0PpGUUlPrs6zKoSx9ru0hF+J4wgKGNT0iL73ONutr8uU/LSm9iBNH/SQ6xabebOQY0IzZR8YBmiQ3S/tMhPUkfvTGiU9M1CKuGVw0gdKsPbqJqyIv8hSKvHQEAX91mAF+EuTrhls8P3mOua4pOmHPmB8WPTmjFG4NoIiHouTKqyxgO48lQ9QbXyudLhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0OsHHGBPX9IrXU1Nzeoy+t06ajgTXbUp+Fu5751atI=;
 b=y+wZtqNqSnonA35t1wUljGT4UCUoVpYmEtBW7Eugn84r68YutA6zhVUPkDUciJcxOi2xktg8cMmpf0db4weJU56m2CqhXRxc50uhHVy3KWhFAosoYcja0fjJbOGcIvRgv6X/p8EgTQOojzA+f14HQEJ4RBazOLT95kCYKbNcqrI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 17:24:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 17:24:11 +0000
Message-ID: <73c898a4-46bc-4f09-9b2f-41d1744d024e@oracle.com>
Date: Thu, 15 May 2025 13:24:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
 <aCJfQ2jJ-B5q8hRW@movementarian.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aCJfQ2jJ-B5q8hRW@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 246ac021-6773-442a-ae22-08dd93d54e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z09ZYm1mOS9QNDZTQWVzUXJHQUNsbmRTV3RhTFhuK0pCVklPTVBnM2NNU0h4?=
 =?utf-8?B?T1Q1YTBlNC9zd0Fpb1JWaTVJOWF0TU5heDFBWDlsZy9FQ0dQd1liTklBOUQ1?=
 =?utf-8?B?MHJVbTBmSklYaHd5eVdvMVcraWdBQ2cxT1lsOW1ydU03VWJGK0xFcWVtd3ZX?=
 =?utf-8?B?TDRzOWdhOE5ZeUZnUmp4V2pzYkNDRFpLVDJ4d0ZKWXhHSjVpM3FYYS95VUNN?=
 =?utf-8?B?VzNRNDQyNkoxVHBkNmNkSGZ2enZaYWd1VGxUNnFKSVFacjRTUW8ySVI2R3lE?=
 =?utf-8?B?QzMyTi9WbloxRElOaDFDM0hTKzM3S0J6OHczYnl5WjRNQ1BLNy93NzlGdUJT?=
 =?utf-8?B?V2hCZWh3Wkl4VXFSSW0zc3U0K2NUSzhWN1d5aisrak41Mk12V0Z3VFYrd0gx?=
 =?utf-8?B?N3VSWjZ1Vm5xd1FTRm1yRVUzMG5kcnA2ZkxacmtiL0l0a2tlRXJPcjRveEdG?=
 =?utf-8?B?d1lJU0R0VlFsMGlFbjNVeUdRcGtwRWs1bGNIeWlheWEvc3JVUU5sN00zaG1D?=
 =?utf-8?B?K1RFRGtJaWhtZ1ZaTUxRQ0krc0pVOUJtV2pOVHZoSHUwSzZXMUYvQ0NtOFFw?=
 =?utf-8?B?LzFxcHovWVJsOG96M2VESGRYczZ2VjArZHJTemNYemtnczI0elhKaUZmdzEx?=
 =?utf-8?B?STZodnU1R3h5UmRyK2NxTUY1NElJNVBpNW4vdklpSTQrSlNCUUw1bzVBVkFR?=
 =?utf-8?B?L2Q1d2ovZFdrT1F3T0lxcUFyM01MY1Q0aE5oWXhiME5VZ0lKbGR0WHJ6S2tL?=
 =?utf-8?B?RXJCZXlpSG9PUmJNSWxnQmdsNnhoMTV0N1FEYVlkR0lneFliZkxwU3ZyZm1V?=
 =?utf-8?B?RU1YdEU4djBOeTN5M1BkelFqTnBIcko2QW9SYmtoMStEWHp0eENrRlE3WmZv?=
 =?utf-8?B?RlczUVVDd2IyeHdWb1pBOWxldFhZUWRZdzRMMjkycDc4TzM3dFA4NkR6S29I?=
 =?utf-8?B?WWN1RkEzOVhzZm9PdUlsQURLMzYzaHorZWNES3ZGSzZhR2x2M3dvaHlXNUNX?=
 =?utf-8?B?RDI2dC92OEFXU2hRb3VCMGNIeGUxc2Q0anpUZ0xqR1hjK25hMGJycHF3SnJP?=
 =?utf-8?B?YTk3aFAvMHlNWGZoYkRMT3krVDdaN21CbmZkNDcrdGl2cTBDNGV2WFBseS96?=
 =?utf-8?B?NzFESm9qMWJZY045UlV5S0lQQXdvWVBvaG8xQUJUQU9aeEUxenYwTVpZRjJo?=
 =?utf-8?B?RGhGc29UKzUvYXVSYlpEbnE1bWlHRmdlMHpUMktVUWQ5amJsWHo5cExzUndM?=
 =?utf-8?B?KzN1NlZEejlUNEliWWNxd0cwWUJ5Q1hqNDNLbG52TkM0WlFqTUFYa2ZZY2xh?=
 =?utf-8?B?cHpoMkJtVndqeUdpZFZIckRZeFVKZ1BGNmlvUjB4TVNzSC9aTU1LQ0V5cG5D?=
 =?utf-8?B?dWI3THJRRVFCRG9uaUJReURzdnc0cFNsWXRaM1puWDZ6OU5TcXh2VllCU3RR?=
 =?utf-8?B?K0laKzlHQ0pabVpzd1lhcHQvaUVSSXBZMEFTT2dCcFF2c0xwM0JhcXE0eGEx?=
 =?utf-8?B?eXliMFB6aWdJMmR5Zlg5bm1mT0s1MnMxR0orbmJpRks0dlpXMU4vZ3FLSTZT?=
 =?utf-8?B?dWtSNFRLQmo2dkNCR0hHampVN240RDFIN3Fhd1NETEo3SU5kS05PRzVZdGJK?=
 =?utf-8?B?RHVPeGdFNWlCbVg2QXk1S3BIZy9FWTRKS0tOSUxrRTlDQVJvNWFDa05UdjFr?=
 =?utf-8?B?TTJLRUg1TGhabGFCR3NJZlRJYkljZnhzUWJrbjk1aS9IT3pqa0Ywd0xxTVZI?=
 =?utf-8?B?dEsxM1RKZ3ZsQ3FXZDZvQmFBek9WM1ZFdFI4Vlp6VVU5RVlmQzVQRkpHUVB0?=
 =?utf-8?B?ZlFUOXNuQXlPMDUrRndiblNJZTgxOXpNMTJLd29hSVFXTlFtdFB0L29xekwz?=
 =?utf-8?B?VWlHVVNsL1hIUWZSWnZINXdDeU1XR0ZueDF1Rko3U3VuUU8wbUQ5SUFkNWVn?=
 =?utf-8?Q?9E5RB5TTtlo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZldVQvaTVvWHh5TkxTdE55Y0ZRREZMMENMNFdPak1aaXBwNzNzUWNkMDN5?=
 =?utf-8?B?MmcxWXJ2Y2NLYjErWWV1VmZMNzRzeU1IdlJoVGVQQXlENU9USk0wTnhobmdN?=
 =?utf-8?B?VE1mVnBTaEUyRk1QMXJQNjBhZ2ZkVHBuVnFWc1ZrTXBiSWNDYUZFaC9OYU5C?=
 =?utf-8?B?U083ZzB5TTNzZTlsZTBnNElRN0NUUHNWVUNCSFM3My91Tm5vQ2M2dGQyYTVS?=
 =?utf-8?B?aWJ0K3B6K3lrM3NKNzZmN3VVamh0U3R3RmNhdi92WEl3czc3V3Fvei9JM0Iy?=
 =?utf-8?B?RC8yVWhkRHdweThudlk0RXlKVUFnbWNDd0wvWlZWRGVlbm1OaXVCMldRWTNX?=
 =?utf-8?B?RFN6Uktrckp0WTA5UFRjanZ2b1BBR1ZocGlBYTdTQ2N4dnZKL0ZxR2hVekR6?=
 =?utf-8?B?NFh5dGt3eDBIQjlFdXpKQnZqRWhRSlkxRHRkMFJiME5ja0FpWGp1enlFaEZL?=
 =?utf-8?B?UDNPMW5DaXV5N08vYzlIOEJKb0x5UkdzUU8rUUJ6YVpYNTY3Sml1Q0RFNkFT?=
 =?utf-8?B?Rnl5K1duckxmejc0Njl5aURRdEFFbHRuVjlRRmVFV1JNU2grN0RqRWt6N0xt?=
 =?utf-8?B?UFI5V3JJZDdLeU93bnZDV1grN0V6K1dnRnJGOXcycmljdmxqRjUwdjgrK2Z0?=
 =?utf-8?B?ODZyWG9pM1M5MllWcWFIMVBqRHZjQWFWd2IzdEQrRVJJcWt2UmRGTjhReko1?=
 =?utf-8?B?R25wdmIrcnYxSTRFUHIrM1ROekt6SFB5R3l1SDVnVFk3Y0UwL0FsdTlqZ1Vy?=
 =?utf-8?B?WXRHcDVrQnZCK3QwK2NPMUY0RW9yVW93TC9yd3hZVGdVMkpIZEdVVmZRb0JJ?=
 =?utf-8?B?Z2dvYnlhUVdQSUY2QlViV2JxSkVESllpeGN0dytOSTlZeGNKVzVHTW9FenFx?=
 =?utf-8?B?Nk96OFF5bldSNVhpd3psNC9neWJkdVJmcFBmV2dDcitSVDlrM05Nci9RSGhN?=
 =?utf-8?B?ZVp4Z1lUVU9nSWh1NnBQeDBLeC90TkpnWVhnRlFQZEQvT0h0K2NzNm9nYW5N?=
 =?utf-8?B?N3FVN1JoQml4T1FMeGhtalIyUEZ1ZEh6MWhsRlZGN1RYNWVETHJEK1NXRSt5?=
 =?utf-8?B?azViUFJGbnBRczFJMDRXOHBVMkx6TzhVZzhUNkFHTGFrWUhTOHAyN3F0Mi9I?=
 =?utf-8?B?bnVsaS8yYlFna2ZyNVJmUGFuMDROUzUzTGZkVkErSm1jQVp6STlxWnd2TW90?=
 =?utf-8?B?c0pYTHFMalR2c0RnMVJHOVpWMy9Jc2Z3RG9xQXhNVTFHNEd4ZllEcE1COGMx?=
 =?utf-8?B?d29ra1pMMU9YWlBRcXh3am1kOUxUVHN4ckx1S1JieEJiVFBwbGxwZlBnV1Vl?=
 =?utf-8?B?S3Buek1FSHZJZnJJWUdyK3VNVjhpcy9qOXoyWXd6YXA5ZW5LdlNVd29TVW9y?=
 =?utf-8?B?SU5UM01KUUdUaVV5YVo4NDhhcm0xRWRVWFQ1WG9TQUM0UHlMZHA0bGZxd3Nm?=
 =?utf-8?B?T3pDT1ltZDdDanV0eTU3ZUZZdzl1N0o1cDh6VEM4ZzkyS2NPME9KUU9wUWtv?=
 =?utf-8?B?NkluellLREhhWUJxZ3lxZWI2Q1YyZmZSWjUrYjIwZ2dHT011bU5XZEx3Y0kv?=
 =?utf-8?B?RzJLMkM0MFVzS3lJZUtSUzJJUHNPcEtBbkRGc2xyVCsxMW5pT2h5TVRVMGFr?=
 =?utf-8?B?bnB4clZhRlhYTVhkWkV2bThhbm9tejVoREpwaGxuU1kza2Jwa2FkUE9RaWR1?=
 =?utf-8?B?ZUw0dVlkUjliOFdxTVVGcERONkNtMys2cm1XejFCRHlzZDUvQWIzbnRpdVBj?=
 =?utf-8?B?Uk5iYW82M0xqblQ0ZklJYW5EUXhFLzluOTlQdkRiTEZsSzJ0Ri9iRWhSWmU5?=
 =?utf-8?B?RTFCSlFmNEFPQ1Z4dXRhZFQrbDdJSXU3M0JrU0FKeHBpM09RdE1XUFZwSGpJ?=
 =?utf-8?B?RmEza1VLYUtrOStFVVBqN2hBc0FNUWlJRGtaWEFzRUsxWDVYZ3Rpd0V6Qjdq?=
 =?utf-8?B?eURRb2ZkNGE3cTZiR2V2NlY5N3BkZk9LOHY5Rnc5cEs3em1sWDNKeEFtY1RB?=
 =?utf-8?B?emNMa1NYOXhQZk1IOCt5d2d6a0xObFFlREwzcExWVitTZmJ4R3Rxby9MNlE4?=
 =?utf-8?B?ZlFIY1VDNVdJdWI3OG1TRWVrYnhvb1daUkEzYjNTL2RTR0Exb1ByVmo0VXZl?=
 =?utf-8?B?SWs0TC9QZkNyTVI2YWNRVXVTSTZ1QnA5aysrTWxZMXAxcTQ5MTBGek5LYlJC?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: glwl8SMEClZgJS+oBXB24TFnFf+uTzpgbTTSR2y6FdwoP2CrGB/Y7yi6H4/EhrDC2Gb6gU1xy0WHC+zlVqFvXjRc2l3A7rUwB2o2diohLQ0L+ltmh2NKOzvfl2R7bdRHTMupawXYxn5zYXr5zr1CG/3yCffUC/UXbdrhYXipiFmjeuogfn7eJKskU8sRujEzC9158SzQfMyMmY5EycIqh0/Y4rCFPsYj5uYWjnFu7mxUjJIH5B7C9hwkd+2yXm8ll3JRrGks02r/8zudNRlUyb3q3LDyiQ6/6rOElSeeXzaRZKU1aqNGBULpFKk/X6KT4wfqrWPQqd0Bq3ki2lieV20cSHc6XP08Y+YeVU590VTzujXqdBfHOOM+lthAbvSlw0y+w9ua6umL4r1dgIe04MRTwAmLOnYVztGblEtQvb3rvxhm47Nipcz1VYaLd2TN3lMgfHmeKrjY8WfWPbk0XWjf7SXL/GFdomk4GSOGgTm5RTswAd6dw6AdY40T6H1dycW2jm5MmRyPEUFQS5V041CUXO9fzj+jKQCA8K1y11XZVdKs4q1x71by4rTiDg8+z15H6govZ7mk+M0y23YXZeIuGnT/EmFFBlhCpsKCzSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246ac021-6773-442a-ae22-08dd93d54e8c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:24:11.3495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uqLIWd2hXT/9VhOlg0w5u/b2PfQtaB+sXz0IllIw71U1L6b7F70s/SHxmbbN6/6oNx75S2Zk0AhG24fKp6rt+pQcYoVDrbrEHTaRyfqCLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3MSBTYWx0ZWRfX8L6gk0i5NOHa
 h+tZ+WGI2nya+dindKQT8k0krs63ZEQA4xv+C5BnZS7YyosfrxQyecJIOQb4zf7rMb2ekwqvUl4
 t0hVfEghbypq2VLKXyDzYjj9SpaNfqNIlYJwflknfmuNuuis5h5dDa53v0Wk7SRFN0MQjKsHW1l
 dOB3jmAmc4+GJBG/HJtPwcktsLc28UBYKyCb9cpIUz8FHX5jh/6EGdD69TyMjZKr7IBhyDskNOO
 AFUI0oIjbSWQfhUJYCp8L3DqPTihf+NIvFYNuAwwetTXFm3Hp1ZXyo67ZI1taIuyV1LvDgRva1d
 ej+efbJuPOhk4a68uq5NDjRpy2IQEeOcLJODJ2dI2qvdqr+PQtVyYiZ686rvNwTnh7K2F2jYQiE
 qOzPb/vHOEhBbcognRh83H4yB54FVVpjN8Np/EaXpIl7L7IN4HT6pjrd1mLpRo/bH24SX5sN
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6826233e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=4UG5aWVIlXOsvKnA4G8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13186
X-Proofpoint-GUID: rKF8Y6-xTujSY_v-Tt2ckIiASxvQk3qH
X-Proofpoint-ORIG-GUID: rKF8Y6-xTujSY_v-Tt2ckIiASxvQk3qH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/2025 4:51 PM, John Levon wrote:
> On Mon, May 12, 2025 at 08:32:37AM -0700, Steve Sistare wrote:
> 
>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>> region that the translated address is found in.  This will be needed by
>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>
>> Also return the xlat offset, so we can simplify the interface by removing
>> the out parameters that can be trivially derived from mr and xlat.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Steve, would you consider splitting this out from the full CPR series and
> submitting as a standalone, as we both have a dependency on doing this, and your
> patch seems much nicer than the current one in vfio-user series?

Sure.  I just returned from vacation, and I see you submitted it.

- Steve

