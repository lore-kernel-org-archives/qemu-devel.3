Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DFCC35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvF1M-0007fy-GG; Thu, 20 Mar 2025 08:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvF1G-0007bl-Aq
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:29:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvF1D-0000yN-MG
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:29:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KC3dA0026723;
 Thu, 20 Mar 2025 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=pk9Ci3hsfc2VMNdXcoB1amRePig5M7RvJNP9F6PLVLQ=; b=
 cb22PixBV4x/mIGSaeFKCAPsoLDmBDrJw2Vd/sCmLaPgU4ZxfAYSByYeDOZxRFwD
 3j7xg91FbcEfUo4d5s8PvjNo/QSntAWX6aN5uJlssSz64A1ekY7Z4hCBO5DvTcV3
 9p3suppRpp/U1xMFS5NHn2U0WdGL6ivi0othtfLMp7+bgGOD7pcPfHo4uMAY/hZO
 LE/nun5dVCJvbAphvp9CHuy54mT7Fs/puz/v/ghV6Qh3NEcrtSknmmxXq8N5LGOK
 +isOtDZLZby5keXCs/+cFR0o77fuYDXccPqTvZHl0D6Kohlfd7Y+z9jub/n6eCeb
 zU97auzqFGKaOf3PIceqBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8nhhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 12:28:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52KCP7i7024558; Thu, 20 Mar 2025 12:28:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxbmavd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 12:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heeKxs2KF//qcC8q1l+nfq8x5qFHBkP7v/gTqMfkxbxIarLlIasZ7llYDIHcDU7KFyoX7ql9nlJyN9TBT8umHEw6qun5Gf8y3sWSR7AplA3h8XSlgUk5O0S0BYHBx1ay0PRbFeRivESmy+Fc0yGcNjYmsM6EyGaRuXyKg/1TZFqpAW0LrbCPPpayxXYyyS4zezBf1TtxH9ABq6vwYAWh2zCEVmbY8hmHQcmHaeWH7DoBOndImBit7RRu9LnSPSikzu6pxiaIYA8wVMUgWKgIVpEmPvgyveHQX8dMHy01AqgFt8mNJVyLoM5RIoF0AErOBvMHW/76572ecHvkSqp2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk9Ci3hsfc2VMNdXcoB1amRePig5M7RvJNP9F6PLVLQ=;
 b=TBOHTBsVPKcljrwlGpWTb6I+UmI5BFS0lrGzxbn2b9TIQHnkjw/E5PGhEbIhNftofVKAaTfk+u2Efd1X0hDD0klOMjcnm2CNo4c+OZLdRp+dzZbvbi1jHsPF+udoBTrqptNerfOYmvtS75qqFdsNYpc+ZLaX/G12pmlwYtO1goFtTKiM/yXqu36fYHqNXVsrBEknoHCsdrIsgNM6IvVJU9WSgdLvwwQIquZR7NPiCbcL1XaIS8sVqlSvhiWzmG6CMWmZEkJ1lP1RiapoB5iFiALtXJ6heAnNC7eVLqLF0fI8faE4V1OOKYz/NpXqwaIOo9H24dRr0A0qju4fnDxFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk9Ci3hsfc2VMNdXcoB1amRePig5M7RvJNP9F6PLVLQ=;
 b=LRYKbQR8VZREJmUHVNlcEdyNYmcVUyHJY5tPltWpu4SSx2DvgvRttsn07yUXV1XRhPhtHSSQMgVRlrvBOf74xQ/FcaBlbd4gZPbpk914OcNpXenvjRIGIEq98PM0RgGp04VC3XUXLyqt6uVUvPR21LfIjupg70H6pDFDPSZOuaY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7795.namprd10.prod.outlook.com (2603:10b6:408:1b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:28:55 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 12:28:55 +0000
Message-ID: <75449139-6edc-4ce3-a4a0-e3dc0f422ad0@oracle.com>
Date: Thu, 20 Mar 2025 12:28:50 +0000
Subject: Re: [PATCH for-10.1 31/32] vfio: Introduce
 vfio_dirty_tracking_un/register() routines
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-32-clg@redhat.com>
 <7d333f19-4deb-45ab-8756-ffd7e4a6c98d@oracle.com>
Content-Language: en-US
In-Reply-To: <7d333f19-4deb-45ab-8756-ffd7e4a6c98d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 852571fa-e729-4699-37ef-08dd67aac7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vnc3M1Z3cWlYajNnYzgrQmkvZ0h0UzhlMTFBVXI5cnpjRzl1UG5OQmZVRWU3?=
 =?utf-8?B?WCtqTDl4eUhqNHgvMjZudTlxbkxuNitGNjI3L0xyTnJ2d3FiTXM0WGpNMzJo?=
 =?utf-8?B?NHBDdXNuU0xPdWZFaERlb2pFS0NIWElibGxUY2M1UGMvb3hrb1hvMEtGc2Fi?=
 =?utf-8?B?ckR3eWpsNzJMVnk1bXp2aGRRNmVWbnllYnlzR1h1bUlkTDA3amQ1a3Bid0Rw?=
 =?utf-8?B?c3FxQWx5QkhIMGtyeHl2SnBGR1pQZU1xUzkwa2ZNbm8wWFZWSkRmQ2Nmaysz?=
 =?utf-8?B?SmFDUGU5Vnh2YllHRmZBay9ib05kb0pXU3dvbEFCYUp1eHFwM2VkMFJPbUZJ?=
 =?utf-8?B?d1oxajdncXV4MEhVYXRNRkhocE8wdStHdWdCbWRVUWZVQVVFbmhBVGVWRXFF?=
 =?utf-8?B?RHorWDBPRUlxMmJMNFk1ZGl4a2hjVi9vZ3NNeU1qaXFQNHRtaTN2N3BwYWJJ?=
 =?utf-8?B?TytOSWNQMmNsaFZZdDdFc1NiMnIyVDVrQmM4eHhkcG1zT0xxWWlSY1pVLzFl?=
 =?utf-8?B?NTBuRFN5d29oSjFwMEZnRDJMTGxXZG1YWnA0Z1pkTmJYUVo4VisrUkFmVVdv?=
 =?utf-8?B?RTMvQ3BSRUx2NkNQSmd2MUJ2WGJuK1VhNEFEQWx1WFEzcThHT291elRvRGpE?=
 =?utf-8?B?RTBYaEdqOVBrdWFTdnZ4Y1BtNUZXckpnRVU5MlY5MHVWR1RrUHhPUkF3Rmlp?=
 =?utf-8?B?bjUyUWNpR1lSdit0RlAyNUNSNHFOYjVDZTA5Y1oxblRtcFo0emFBRmxEb2I0?=
 =?utf-8?B?TGcrUTRvRmRuT01aa3pHeHNGVkR2YVAvQXFRdDRpZEJUTnF1d1c3SkZtb1d0?=
 =?utf-8?B?bWNIRWJnaEQ1YzVTTGlEcExjdk5sa0ROMVBKbDZiTHFiWHhmeGRUbkl0aE1X?=
 =?utf-8?B?UkdCWWt3bG9tSDZsRHg1T3hhcjdnc1lXMG1XQTNmRjY2TEhtMktna1hJVTVI?=
 =?utf-8?B?bUtJZlNUUEdpVTkvQXBtd2ZyVWxabFRTTkpnb1JsUjFaYVhsS1FGYlI3bUtl?=
 =?utf-8?B?NVpqZE5UV2hZTjhhdlhXT1grQy9ibjRyRHpmSmZDK0c3QWhZdkQrdWxBSlFT?=
 =?utf-8?B?ekpSeUExb0wwZktaU0VGdkkxbllmU2VsenBJS0hwSzNSMm5QRkxnTXhycFp4?=
 =?utf-8?B?WGMyUGlpTE03eG1HdlhzK3I4YjhKT3JjZ3lhM0lBUUptK04yellQL1BPMHdM?=
 =?utf-8?B?eTVaMXhOVXdTdU9qVThIbHJUZWtqOTlvTWFIRmlhbmZTMXdKUUxianRNRytM?=
 =?utf-8?B?M05aclN0Tm5kVENMTWNjWW9paWZlVnRHMjBzTE9EWkQyOSt5NnJSR3pTSkZ0?=
 =?utf-8?B?cVl1MVBNc1B0bUZBdmlGdS9FWkh5ODhRZ2Y2RWJKTGZXYm9TcFo2YmpUQSt6?=
 =?utf-8?B?QXJjckQ1MkhHM3VmRzJmSE1mUHllOUlOSXg2SWZmTVNHZ0p6YlI5emh6OHJV?=
 =?utf-8?B?eE93Vnhnd1VCYThpdFJWcEp0MzlCLzRzeFFkQzl3TFA1cWxGUTN6aWZYT3hC?=
 =?utf-8?B?b2xKWjd5bVdvM2NEU1Y1QmJXTGhUY1FaYkNXanNmSmY0cUZJemVwSDhaY3k5?=
 =?utf-8?B?MlVvU0UybU9CaXpmMnZ1S05kNjA4UzBqbnIzanZQTm9xWU0zd2w5SWVPQ3BW?=
 =?utf-8?B?RUVwandkSnNwOEhvWlQ2UHRFWWpzV09HTWZ2QzA3bWJGS1NMSllJQzZRcVEw?=
 =?utf-8?B?V2hFbU1uT1VpbG42bVVRaHRsZUF5SG10M2JpZEtEUTVvM2VKTkF6SlI5VGlE?=
 =?utf-8?B?QkkzbldxNEMwWk8zMDZtMCt0WVFNSThZQnMxQkc1Z3c2QmU4c2ErQUJQbUs3?=
 =?utf-8?B?eHNXMHB2U1RzRE1iZEV3eUNsV3lONGNRalgxM1VJSjhhU3JQemNWaGFnR3J5?=
 =?utf-8?Q?H5KIey2GaC6My?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRLZUlVNHNwdTZNdFFnRDRWUkJac2gwMm16SHVSZXNBZzJ6T0xMV2tJTytq?=
 =?utf-8?B?MkZBZjBTTmNPTjhDNjRsM01zSm9nRG5FbDRQaXUwMnZUcExjTUQzclJoNHdz?=
 =?utf-8?B?ZU4reUNGdWFzYkZPS1dkV2xDY2FDOGtScjBqbTFqQWk2dGs2NWRualhxRFYx?=
 =?utf-8?B?YVRDeHplLzZYeEljeTZTWkVybGZrL2gyM3NpZ2lwWTNtT0JJSXJVUnlwdVJS?=
 =?utf-8?B?akE3WWt0UWplSVVlVVAwR21SVE5SZHc0a1Q5SktDWU5tc1FUb0NoRUZaTXlp?=
 =?utf-8?B?UXRVU0p1aVNvVVVuVTJ0ZDQyVXNVS0ErTXJ1cVFVcjNWVGF1MjZHUlJvVFBp?=
 =?utf-8?B?OEo4VXNHVzJDSkhGYmErQklKZ2JIdjRhcHdrWXVYRHVxRW1sNk9Tdmp5K0dH?=
 =?utf-8?B?YjhncStMWWVrWmswYXZTTFhaSC9hYTVycFIxRGdsczR2OWxtYjlwY0RhTWMv?=
 =?utf-8?B?dXFmOVJGRFM1RnNhbk5XOVdES0FRU1czb0Vpbi9rc0dxd2xDNnhhMTZVWDF1?=
 =?utf-8?B?U3RKWk8xdzZpQm5HZC8wUk9pdklCOEFHSmlXaXNGb3Y4L0JUakgxLy9FK3Vj?=
 =?utf-8?B?ZzBaREhHRTAzZlEzNHFQbk16c2I2Rmw4RU90WTRRczZhY2hmZWQxcGFTUUJt?=
 =?utf-8?B?OXliQmxJTE5KTXVodThMK2tCVGMwZWhuN21PMTRid1ZOSWozcy9VVFZTV3Zs?=
 =?utf-8?B?OUhYYlVMQ3AwOXYyRnNWRERBOUZJYWN6L3BiTDYwUndXNWFRLzh5NUdsODBi?=
 =?utf-8?B?bjgwdmlISDRKNEtXYmJHSVJEUVM0Zlh4bUw4b05zWG1SdFRTRXlueVNhSVI0?=
 =?utf-8?B?Y2dYVy8xS0lzWTA4Z1BKcG1HM1RxNnhPcjM5VzArSEE5VVVicmllUDZkVFZy?=
 =?utf-8?B?YyttdlRnakpMSGNQZHl0V0RmZzVYTE5PTUFzSHE2SjlLWlQyaWttSU11eEg3?=
 =?utf-8?B?cG9kNy93YmthcWFLN29vRS9DNWlKY1FiSEFuUW5BWVhsYXJCVyt3UEIzWi93?=
 =?utf-8?B?TTROaHhabm05NEIrK0hoM2JJRk9pbFkrMndXd0NOeTJpY2RaQVdURUlNMWQx?=
 =?utf-8?B?THFXT3JWdHVIQlEyVWl0aUo2QWRpNnhmbFdBUW54d2NGYkxlVkQwVGVLZjZ6?=
 =?utf-8?B?elpqZUgrWFZTNFRRUjhiUVJ0MWVlNFpIVVVsMTk0L2dpWUI5MUdBaXlIL0M0?=
 =?utf-8?B?YjFqQm44VXRVOUNMNzlJL3VIRnNGRHF4dWpjbVY0TlFac2dtMVQyeE5zQy8x?=
 =?utf-8?B?a2NmWDFMYVB6RjRCbnllN1lrd2dRVk92d2Voc0F6WUlNelM0em9GUlVTWkxI?=
 =?utf-8?B?QUpGaXZtRVUyTDdCT3VaZHlTZ0IvMXBUQnBWdzVNbDFhdTEzclZBam82Y2sw?=
 =?utf-8?B?SGxpSm5ub3NBTVlDdWhTUFNPalJUKysxdVZ5NDRCR1VDZnVqZ0g2WW4wU0RE?=
 =?utf-8?B?cGVFYnNYczRlTnFrYkhKZ2ZjeU9GSHVVaWVRVE55aFRKTHNXZmpyWmxPWk1S?=
 =?utf-8?B?WlZDWmhyU1ZoaEdybTRvOUtVUm8yZDVCaXNjbmpFakJDY1FTS0RqYlNBdG1N?=
 =?utf-8?B?ZWQ4d1BBb1R1enJvaFBsQVova210cGhZRVl2MVNoWGpuOEFxdFF3L0Z0bDdQ?=
 =?utf-8?B?N1JWdVJWNVpzamkrRVVnV3I0RE5RSk40SFUwSnBzRmlMRDF6TE1uWHh4NHdJ?=
 =?utf-8?B?VkhWcVUyTkg1djBnMUU4azVyVDdJMEFTTFFwT3FyZk5OZTYwM1pTcXlvL0I5?=
 =?utf-8?B?UFk3cC92cDQrb01IdWlGekk5d09aNDNCUDNVVkZDS0RtR1ZPVEI3N1p4QWpP?=
 =?utf-8?B?eFdTYnkvUUNDVmFHdTloTVgyUzMwbnVpM1JzNlNTZjdrczBDb05odWxtNWY1?=
 =?utf-8?B?cGVCdEFPdEZBZ1FNTmhKV1BqSWhlUmRIQlo0cm4xd2VIKy9EdisyaStqb0ZS?=
 =?utf-8?B?UE5KeStZR0l0ZmlyaWNpaDNxUmh0cmh2YlFzUDgxRGdpSmU5K3VhS0tKQ1FM?=
 =?utf-8?B?QjZNMjJaVE90QmhhQjc2cjJhN0Zzd2d6YkxjZTk3akdsMmNreTRBa011Rmhi?=
 =?utf-8?B?d2ZHYVNmT2g2NTNVdWxpaWxIb3EzWncvVU1pTmNkaFV2bVRBVVlHcWlhVkh2?=
 =?utf-8?B?S1RjNDRiOEhJWTRUVWVwUGtHQlZnNU9FZ1ZYWkxwb2VDVkZnbjhGZnZuSnAw?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b93t3lc9wBxEWYB+GHPbqTbfkneDU3DMkE5n18mU0yLx3l5iCRHR01rLpPcNd7imGo8OtplhfUJqCwaz3z0BlS+gVy/eTEVR2X/rJ39XEvJR8Mf47dG/ijc7MsyHCPAZBGbqI7csnU+m66T3sdkIwNJcKRR6+MfSwm8OI45atd5WCuXM2vdaqwHYWTi8XZq93HNoO2HhAq3ti5hf4OHsU0RsQn8vlsfRGGP7R+CuVV/Py9nlmhYh7Jf1OTFejMnD9FGbxhx43k4dObX5Kf2RaCyaUceon3z+IxRa6xYD5cpITGkONYpWEYvxnn6TfQt4MbcKuI4+4rSiMALVchCbFuY8KyEURAE5eIgwVWsYlVy+/77cyauZ2uYvMHuHsXVL+scGh8HcDWHhakml1Iq3qaUgvFUfB+n+WOvfoPUIAKvut8Cl/S7l1BtFmmTO8zQn5BrbAW5jmbiTs7pxlIg7r9E+tBpd9vyryuv09ogjnQTDXa4ZGLlPlcBfLvLFuXFjfYu19x/h65BjzeApOMAB2ZXr1HmIjFOzdhvOOny8Q32F92hoiPtYcdYEKHKZHsBJoxbCFA8Vi75C8T6CgwGlRBBjFeSdir1nrV+5y+TPUE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852571fa-e729-4699-37ef-08dd67aac7d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:28:55.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zWIN8IhKBvpNjrG+uLVXQMhlSTxSoAUFyY8GFeeUAxEIYQKQ1ThH3CLjgpXw/B4Pa9CB4AGH67ZFUnLlwjlrCSdAhg6hN9T+puBiu6JQxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200076
X-Proofpoint-ORIG-GUID: 9dByqH51fNh6_ukkjKcFvmHSEKhUwWDT
X-Proofpoint-GUID: 9dByqH51fNh6_ukkjKcFvmHSEKhUwWDT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/03/2025 13:24, Joao Martins wrote:
> On 18/03/2025 09:54, Cédric Le Goater wrote:
>> This hides the MemoryListener implementation and makes the code common
>> to both IOMMU backends, legacy and IOMMUFD.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 

After discussing with Avihai, maybe the routine should be representative on what
it does and not so much on the namespace i.e.

	vfio_dirty_tracking_register -> vfio_memory_register
	vfio_dirty_tracking_unregister -> vfio_memory_unregister

Given that these have nothing to do with dirty tracking.

In terms of memory listeners the only function relevant in this area is:

	vfio_dirty_tracking_init
	vfio_dirty_tracking_update

Which have different purpose where we parse the memory ranges to construct 32/64
bit ranges for VF trackers.

>> ---
>>  hw/vfio/dirty-tracking.h |  4 ++--
>>  hw/vfio/container.c      | 11 +++--------
>>  hw/vfio/dirty-tracking.c | 21 ++++++++++++++++++++-
>>  hw/vfio/iommufd.c        |  9 ++-------
>>  4 files changed, 27 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>> index db9494202a780108ce78b642950bfed78ba3f253..6d717f0e918e47e341114c82ffc2cf520fc7b079 100644
>> --- a/hw/vfio/dirty-tracking.h
>> +++ b/hw/vfio/dirty-tracking.h
>> @@ -9,11 +9,11 @@
>>  #ifndef HW_VFIO_DIRTY_TRACKING_H
>>  #define HW_VFIO_DIRTY_TRACKING_H
>>  
>> -extern const MemoryListener vfio_memory_listener;
>> -
>>  bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
>>  bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
>>  int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp);
>> +void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer);
>>  
>>  #endif /* HW_VFIO_DIRTY_TRACKING_H */
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 7b3ec798a77052b8cb0b47d3dceaca1428cb50bd..1fcca75caba19353ad3063ae97b20c15f61564e9 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -616,12 +616,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>      group->container = container;
>>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>  
>> -    bcontainer->listener = vfio_memory_listener;
>> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>> -
>> -    if (bcontainer->error) {
>> -        error_propagate_prepend(errp, bcontainer->error,
>> -            "memory listener initialization failed: ");
>> +    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
>>          goto listener_release_exit;
>>      }
>>  
>> @@ -631,7 +626,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>  listener_release_exit:
>>      QLIST_REMOVE(group, container_next);
>>      vfio_group_del_kvm_device(group);
>> -    memory_listener_unregister(&bcontainer->listener);
>> +    vfio_dirty_tracking_unregister(bcontainer);
>>      if (vioc->release) {
>>          vioc->release(bcontainer);
>>      }
>> @@ -669,7 +664,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>       * group.
>>       */
>>      if (QLIST_EMPTY(&container->group_list)) {
>> -        memory_listener_unregister(&bcontainer->listener);
>> +        vfio_dirty_tracking_unregister(bcontainer);
>>          if (vioc->release) {
>>              vioc->release(bcontainer);
>>          }
>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>> index 8e47ccbb9aea748e57271508ddcd10e394abf16c..d7827f7b64adf3e2b41fafd59aab71e0b28c1567 100644
>> --- a/hw/vfio/dirty-tracking.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -1267,7 +1267,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>      }
>>  }
>>  
>> -const MemoryListener vfio_memory_listener = {
>> +static const MemoryListener vfio_memory_listener = {
>>      .name = "vfio",
>>      .region_add = vfio_listener_region_add,
>>      .region_del = vfio_listener_region_del,
>> @@ -1275,3 +1275,22 @@ const MemoryListener vfio_memory_listener = {
>>      .log_global_stop = vfio_listener_log_global_stop,
>>      .log_sync = vfio_listener_log_sync,
>>  };
>> +
>> +bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp)
>> +{
>> +    bcontainer->listener = vfio_memory_listener;
>> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>> +
>> +    if (bcontainer->error) {
>> +        error_propagate_prepend(errp, bcontainer->error,
>> +                                "memory listener initialization failed: ");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer)
>> +{
>> +    memory_listener_unregister(&bcontainer->listener);
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 7f354d86cd14270a70dc990860ad5b69f0310719..7737d552f310c54ae2e035198a1a83da8c3199dd 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -411,7 +411,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>>      if (!QLIST_EMPTY(&bcontainer->device_list)) {
>>          return;
>>      }
>> -    memory_listener_unregister(&bcontainer->listener);
>> +    vfio_dirty_tracking_unregister(bcontainer);
>>      iommufd_backend_free_id(container->be, container->ioas_id);
>>      object_unref(container);
>>  }
>> @@ -563,12 +563,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>          bcontainer->pgsizes = qemu_real_host_page_size();
>>      }
>>  
>> -    bcontainer->listener = vfio_memory_listener;
>> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>> -
>> -    if (bcontainer->error) {
>> -        error_propagate_prepend(errp, bcontainer->error,
>> -                                "memory listener initialization failed: ");
>> +    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
>>          goto err_listener_register;
>>      }
>>  
> 
> 


