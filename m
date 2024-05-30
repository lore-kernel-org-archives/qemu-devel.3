Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCADC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjJI-0006Ge-OC; Thu, 30 May 2024 13:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjJG-0006GG-AL
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:11:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjJC-0003wU-TO
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:11:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44UFTf8e005999; Thu, 30 May 2024 17:11:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DplbNe4LhoZdejJMkxpujrG5ubJd14xHMs8cq3OhlWZ4=3D;_b?=
 =?UTF-8?Q?=3DghAvAECjCUAzpjLpurFCTOVpmpzYVfMVx6ubFEqODShSp2UwfHXlNbY3oWd6?=
 =?UTF-8?Q?dLyR83UY_4UBQS4dKSiZUsPfuVlyzMohVEq4s964idbMzzDDi7QJJDlLdY3yT56?=
 =?UTF-8?Q?WASzMp6pwer/fr_//EySAkgrlCORYskQf9YtwZk9YAHT0+1ffnfo1GH0D7Y4a8k?=
 =?UTF-8?Q?Bl/Bu4XnZHZAH353IOf1_GseY1mUliLAu7fqPW/LBWB88QzOUPtYLF14E7xFOLI?=
 =?UTF-8?Q?eRm1Ci05uFeOGyGF4aMcYtmLbq_wDYwUmzAkwwy920qVmIX8gPHGWWP7izAGiQo?=
 =?UTF-8?Q?YEwnb7RKItmGuDaW5eXab/Jw0JuHlFoh_VA=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg9j24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:11:17 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44UGdVnc026719; Thu, 30 May 2024 17:11:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc508u8xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNxl7MDdvqJa0+TlHkqypEvbGejfjRE2CT+PqyHSn+Uud0vccTj+nLPj8J46JZKJJFV0HgX1z1z+KbzIFtmc0aWxZLj2opWueR+/9gDUWzPuSITQHOFp5+8NvN7urN5qWaQCYqjGc1XVP2dCzBH45eyHhj6UJIh7IfiY3qjTO/Ql8/U3pRzdQbTVofCrw/ityiQ4r5zisurJ5UmjWtqXYvRdcK72E33Me12JHqEcx013WQB1vW97lS+XanD64fBykVYP41Vj5LaMKfZ/weYpM5ImJlaTOTqQcfG2Oly4gL5IAQF3F61dNZ2gIYRLc/8+j28KVbGeTHYE0dZCXJuX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plbNe4LhoZdejJMkxpujrG5ubJd14xHMs8cq3OhlWZ4=;
 b=K0442ytu+6TZuZhAP5UKnIPs8KeW2Hk+eYaUVzjjC5hkc2+owRdmO8a2UHJais2t33nhTD2ybmlWL+esHJq/KH8tCBwiGBFwQ2Jaf940GiwMz3CE10X1L6/SNjEVkaxhn+IOs0geJXbGTCtURpU32gtG8p2JbAGEhlWGAB0e12UFc0aG/2jFL3N/kfRdYpCfimOXWO1pp0VLiefhjnjjPcOwULRB3FPRZEXQvIynsQAw4m9d5KvbJqKe7mgpiu3dhobOcN8qZhBqziZuKNGpW6TZ7S/QTNJxgYxB+14zNldvw4UJZWn0xDb8SOTEUOkTDXgMO+kzZC0HG7QQeVxeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plbNe4LhoZdejJMkxpujrG5ubJd14xHMs8cq3OhlWZ4=;
 b=YOKiM/rooD/pAsI6ZaIskopkHlyn7UA6BT0x19TzgkSLdlzHTcDHqSzCrUrxbOcqtbMrAPoNqQIlEoHDLX88WIP6cvqpfNXRwVk5zHJhnbai7/C5LPUIT133IbkbmcNZF7BlLKia4sE/vJJn+LOQteNBbWtNgoye7jxqDGdT+34=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:11:14 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:11:14 +0000
Message-ID: <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
Date: Thu, 30 May 2024 13:11:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n> <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zld-iWfa3_yEWgn6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0004.prod.exchangelabs.com
 (2603:10b6:207:18::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b57c6b-6ee7-43f7-4f2a-08dc80cb82d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGJQOE00OEMzZkdiSmxpT0lab21DU0t4SWU1SFAxM2VRY1U0UGw2V0JCWUxq?=
 =?utf-8?B?ODZwMUtWR0YyMlpJMEtGc2Y2VXB3MGd4NTBFQ1FUUmNNUEhFYWxia0M1dExE?=
 =?utf-8?B?SnhHQkdqZVIzWXplMWFjQzBidktsby8wNHUyVnBITEFjazJjSVpRZytlekhz?=
 =?utf-8?B?NVNLdFBMZ1N1dGVnbmRTMml1bk5RKytRVzBtTG9wOUFuVWNlUTRQQkxDR2tC?=
 =?utf-8?B?ZXRXaFVXOGVOekR3MlpQZW9XRXRnZXZDVlJIR0Mvd1JMb0NCemlZNlhqVWN2?=
 =?utf-8?B?Nk10VU1lWnVaN3JQRk1Ud3NEc2YyWGs3VFM3am1OV0JKMlgxMU9zMHlUMmVy?=
 =?utf-8?B?dHZ3QVN0TDY4dnJTWFdpUXlPaGZJZHMvYXFWTWROSzVDZjZkMVNXNG9zeFV1?=
 =?utf-8?B?dVV2ODlWNW1BN1J0Sld1cEhEajErbUFpR1BPakZoZ3NuSk11TUp0RkhxbXU4?=
 =?utf-8?B?VXRwRDI5L2lmcno3SGdnNnZkVWhHOW5kdnV3b2pCUWhZMVY2Vm9pLzE0SGla?=
 =?utf-8?B?VGhKVFZTM041NFBFOU5QYW05bHdwZ1k3KzU3NHFzWExkMmIrbmpwL1h2TjJa?=
 =?utf-8?B?Ry9vRUhaMnlwTlJ5OE4xQjFNRmM4WWkwWWxjeE81ZDBuT1B4dHJVSGovbUkw?=
 =?utf-8?B?Sk9MV2dTemVlUVhMT2s0OUp6NXlHdFdjelN5RjJXMWVwMTgzS3Q2V0IvUWsv?=
 =?utf-8?B?VWp4WmJsd0MxcWs5QU13YUVhQ2dDamtMM0xvSmwyUmlCVmtnV2Z1UExTVk44?=
 =?utf-8?B?YUtNdHRoVnlMQ2RBaGZyQkxyQTJSZEViT1l4WXhtZy8ydWZtWlFKYlFGR01O?=
 =?utf-8?B?MHNDZGtFN29FTjdjTCtKUzBxSXJqcGkwZjBhanlvVkRrZ3RTOUptUTlVRG1P?=
 =?utf-8?B?OTNmejRxTnVybmNqdjlIc0sreHZHWDBtcU9aeFg5Wmh6YWR2VkxXRGEvdzdh?=
 =?utf-8?B?em1FekFVV0tRS3pqSjNJRm5UQ2NCc1NDMDBwWkFWTVhHRXpmc2NIZDhPdmlr?=
 =?utf-8?B?YnJMZWVhc3FWbVhpY1ptQnlHWFAyaGxMWFRSZU5zN3l3Ymt3OERiK0Z6QWQx?=
 =?utf-8?B?SHZPd0pldG55TjRJTS9HYVBTQWh1YmpCMHBjVzJoRmhKbjVOaElWMmtVc1R5?=
 =?utf-8?B?NzVxWnBoYVd3OHcwOGFnaHExdklQOGhJSUtlVGYwYlZIVWdMWlllWk11S1Bp?=
 =?utf-8?B?NmRScGhZOFZ4MGhBTzI0b3I5N0Q0aU45WENjTHBsaGd1aUtoOE5vdXBHUzZq?=
 =?utf-8?B?Mko2anJQSGpKR0tUUEdud1p0MXN4cEFkb2dicHZiaWdLc1lOOHlOSEJHVk5G?=
 =?utf-8?B?UE9oN0FiL1cwdEJPWjVKU0xObVN2U2F4MDVGR21EZG9ORkNGUDhFZS82Y0pU?=
 =?utf-8?B?Q1ptSlRKTWxWK0MyRVRuNG14UkZZZE9NWURKclVhRGtZWlBMNjVaRXZwOGJz?=
 =?utf-8?B?M3FtRjNFRUxlTmp2bWgvbHBWMlM0VmprNnVkUG1KRUJzSld4bWNsS2pnZi80?=
 =?utf-8?B?c3A3dU1iWjVuRXlyMVdTM2c1ODkwc1RhSXhOT2VhRE1OaWN3R1ZhTUpaNWFl?=
 =?utf-8?B?eEk1Tk93WWRublpjOHY0VXdpaTMvd3N1U2I4WGVVT0xPeWM1c0dpcXRGQ2Q3?=
 =?utf-8?B?TDlXakxvQ2VCRmd2cmlBTDV4UVRpTmpBOWE1b3FTUC9WNjJSMHJSdEcxYkpM?=
 =?utf-8?B?UGs5TFVMYk1nT05YZTRnSmZYN0VaWkJKYzFPa2xSeGp6YWV4TzM1WUV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Qzc00yblR0QjJpTGpmRDBmY01IUGYvaW9iSDVBYjFxcGRLcW9IVDRZMmtW?=
 =?utf-8?B?dy9mVmpPRkRIcU1aNll1YjRZUVFtckY0MVdCdm93WXNuQ2RlTGIzSkxRMGNE?=
 =?utf-8?B?eWtiMVBkV3Y3U3pyaVdZRlVERE9JSjFvbnByMW5iYXZUZkdIY0lyQkYzRDlW?=
 =?utf-8?B?d2xiUVVZT2xydWxwZDJ6d044VDlpZUUwbzNWSEtibFJVdE01TkwrdVY2bFVY?=
 =?utf-8?B?ZG9tSTFHdjdmMDFmT3BDcVVkOTgrWkxEckxEakhVQ3htRU8vTW9PN2xTVDFW?=
 =?utf-8?B?WSt6eUlUbHRPeVBhTWJIQ3h6djJtSEMvTmxERmlrNTA0SXhUWkNmM3BLR0ZD?=
 =?utf-8?B?Y0lxaHRiT3pZWDU5TURyUDNpVlA0VTI2eU9qT1lKNFh4ZFdaRkpJUWZndmJC?=
 =?utf-8?B?SUl0WjluY1dmTGJZTXVxUWc1N3hseGJQUkJrcEtEUzVOcEE5ajlVZitqQW9B?=
 =?utf-8?B?MmR5TGVPTlBDL29YZGxBTi9zVEQvK2FrZXJsNlZrQ0JyVmg2K2h6aThjWEJS?=
 =?utf-8?B?MnZVa2NWNTBuaWNKdjdkb1ZrZmZNSkhaSEYzNmkwa29jT2JlU3gvVFpNNHVY?=
 =?utf-8?B?cDVYVVJLcXEzZ09qUkVzaytRWWdON3JHQW5WeTdaRFROUEtwUGtoejgxQmti?=
 =?utf-8?B?MFg4RHdKUFZKZHMxNlRzUXdBZDJSWUlkclhaVVJzKzhCaTlzd1N2TWhoREd5?=
 =?utf-8?B?U2hqVFJoUDhqbWJra0crZFlMc1k2MFNLZXlDVVRPNzF1b1hncDNlcWxzMTdp?=
 =?utf-8?B?YlMvRHovdzZrSG54aTBmSGRIZVFnbjU1RDhObkNuSDh4RjFtTzFseTBqV3VB?=
 =?utf-8?B?ekhXSFlscTRzaFdVOHdwajRNSmxnSDJ5WVVadm1XeXpvTUYxSmFod29sc1dy?=
 =?utf-8?B?dUkwS1lCMmVCN1BsT1UzdlJRTmF5YTlIeGM1MU1aNXR2TnFjSW1VT3FUYWx4?=
 =?utf-8?B?Q0FESXd6L2FLVm9NRFh3SGtKK1k3Nms2OE55RmliRGMzL2pTaU9NeXJ6YjJW?=
 =?utf-8?B?VEgzR2VFVE5LK05yZ05DT2UrQ1NHNEtWSytIRnl3clMrS3NkTWQxNWlmeXBC?=
 =?utf-8?B?WnZaTFlPQlcvb0hTWE1YVkE1VWJYM21lY0FpaG9lL2FnRnZHK2tzcjVBZGlk?=
 =?utf-8?B?VmFualQ4djQzZ2hXWldNdklGbjkyWjcwRUkvUnY1NXdoTlZkNjZnQ2h6aGFC?=
 =?utf-8?B?V2IyeUNqZ080d0pDMDAweHRBTDBDZVNzUnhLZkhOeUhObURQeHVoaWF4dWk5?=
 =?utf-8?B?U0tPYU9haDlEVmpGYXJPbGVaSXYyWERodVA2YXJlYnpLTk5SdVh6RjlaWEFk?=
 =?utf-8?B?b2daTjBiZ3ZMcHRzSzhMbWxpWTVORVg5TkFYL0VsOGxEM05aVnBTN0J5ZG00?=
 =?utf-8?B?cHQxSW12OHpkVkxXcDd1UXM3YjBDM1RHMjFvSmtBTGdudU1FWXdORGJTVXRO?=
 =?utf-8?B?MVpDMC8rVEM4V0F6dDVYNVBkVCtXMk1UblNsekJ4bC9PSm9kVk9TMnJTb3pJ?=
 =?utf-8?B?ZFRYT3RvUmJ1cEwwRDE3SEFsL2M5Z0JLK2dXRUlablhvVlVyRVZaV01Pc2Y3?=
 =?utf-8?B?RHhwTVVMamdqWVZFT0s4Z21mTTJGWlhIQ3JodENIR2tmWEtPT005NUJ6eVlG?=
 =?utf-8?B?bC96eEJ0TThQZ2Y2M2JVSnRuV1VGNnZkMnZhK3cxd3U5ZnFOOVkyZGliaVlO?=
 =?utf-8?B?NEFnOXhsNS9CdTBzMWtFMXh5WHNGMDBWOHp6UFRhL3ZrWlk5ZHJYa1BUbmor?=
 =?utf-8?B?bmhnVEp2MjdrZ0NvaStSVXNLNVhHbG9GQlhzWk0ydmF3Y21aQ0t5TUtLQ25i?=
 =?utf-8?B?MUJiY01KZkp5ZVlETUtuWUtvbzFaT3NPQzFQMlQzbHYxUTREb0xOaW90QUpl?=
 =?utf-8?B?czlsaE94TXYrT3AvRTgwR2VjWmdlRGNvcUxqOHErLzgzUzZSTHg1NjY3RTZx?=
 =?utf-8?B?SzJ3bmlTOHMzbWV4eFBsVDBtUEFrRFFJSVNFS2FmNHdnVy8yc3RJOFA3dmxl?=
 =?utf-8?B?cEtvdW8wa2FJNllseXRCQ2lXWjdOQkd4WDNrZms2MUF2M2RGMzJYWm1sZllM?=
 =?utf-8?B?VW5hQWl1RFVaNy9sakxmZWp0NEpRcjNCY0g0NjI4VHh0OEF5Mzg4RDF1Ym1x?=
 =?utf-8?B?bXc1U3ZQZ2h1ck1XY3ZzcllvZVpidkUxaFdkOHQvTWdYNTFDRkdKbkZHaWpn?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBojdR2FZcC7wICa7k9LPPbxknJUw6AbaG9O7yACMENcBUqR+DMuC20NJG4LrKTZNHV9+XDgT98ANC6NNoR+EbgGfhXv2CImr/9kSYIyrAeBiccx+grSoHPYUMOSKkXQC47MyAwwaqSG2Ioz3oghNeX2k9mCAvsF7vpGpYUjVSIAymGri+mzAFuXAbf3mkKoptoyhA4rz4fqhhaOHzGf/7nOcPnVSFoMuMgDSpXXfJ4oso2HXQfKalNg389bdLkFN2nQab6bm5jmIxUF7cCpT7dR1zG1aIuYqWjnwIWji4wg8+yKWA2tdKN9rSLxHOX1qA8UlsGdPsRdvF7PCG9sq51uKyqns6Vq3K5Lm99Y1eo9TDCXriYpLn+TJY8RSaw3g0uG6wdhAfTgQgONgs3YRHDCfRfsUVI7obaPyO9th94c31O4oR0NA1L6GOFF+DSq0ycyW/6k3x8YGraFS0zBT30m2/jpL0jVtbVcJPfoCJqr1OgLfgkFqJYkLcmtRiDIIZyIqLrikPllJcay1JH+Xem9kPet9mISsarCQeq6IXvTYV238vH9FQfc6djyqWqix2FJMBAuamyd7LSkIrVsq22pX5GtoB5zyatBowGODvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b57c6b-6ee7-43f7-4f2a-08dc80cb82d5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:11:14.2522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUaoP1qYzVKO/rYhfZR4vbTJ3OIjoy4anP0S4OMhCtnvhVldGrkmqmvD9STH27vMt8lCz1jI4EHAgRC/ikaZkhKpvIadc9aicjeLDmCM3kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300127
X-Proofpoint-GUID: pNLdDlvAqZ-4x8AUKY-VniwP5kq5lKga
X-Proofpoint-ORIG-GUID: pNLdDlvAqZ-4x8AUKY-VniwP5kq5lKga
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/29/2024 3:14 PM, Peter Xu wrote:
> On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 49f1cb2..ca04a0e 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>>>>                                          uint64_t size,
>>>>                                          Error **errp)
>>>>    {
>>>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>>>
>>> If there's a machine option to "use memfd for allocations", then it's
>>> shared mem... Hmm..
>>>
>>> It is a bit confusing to me in quite a few levels:
>>>
>>>     - Why memory allocation method will be defined by a machine property,
>>>       even if we have memory-backend-* which should cover everything?
>>
>> Some memory regions are implicitly created, and have no explicit representation
>> on the qemu command line.  memfd-alloc affects those.
>>
>> More generally, memfd-alloc affects all ramblock allocations that are
>> not explicitly represented by memory-backend object.  Thus the simple
>> command line "qemu -m 1G" does not explicitly describe an object, so it
>> goes through the anonymous allocation path, and is affected by memfd-alloc.
> 
> Can we simply now allow "qemu -m 1G" to work for cpr-exec?  

I assume you meant "simply not allow".

Yes, I could do that, but I would need to explicitly add code to exclude this
case, and add a blocker.  Right now it "just works" for all paths that lead to
ram_block_alloc_host, without any special logic at the memory-backend level.
And, I'm not convinced that simplifies the docs, as now I would need to tell
the user that "-m 1G" and similar constructions do not work with cpr.

I can try to clarify the doc for -memfd-alloc as currently defined.

> AFAIU that's
> what we do with cpr-reboot: we ask the user to specify the right things to
> make other thing work.  Otherwise it won't.
> 
>>
>> Internally, create_default_memdev does create a memory-backend object.
>> That is what my doc comment above refers to:
>>    Any associated memory-backend objects are created with share=on
>>
>> An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
>>
>> The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
>>
>> +#     Memory backend objects must have the share=on attribute, and
>> +#     must be mmap'able in the new QEMU process.  For example,
>> +#     memory-backend-file is acceptable, but memory-backend-ram is
>> +#     not.
>> +#
>> +#     The VM must be started with the '-machine memfd-alloc=on'
>> +#     option.  This causes implicit ram blocks -- those not explicitly
>> +#     described by a memory-backend object -- to be allocated by
>> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>> +#     RAM when it is specified without a memory-backend object.
> 
> VGA is IIRC 16MB chunk, ROM is even smaller.  If the user specifies -object
> memory-backend-file,share=on propertly, these should be the only outliers?
> 
> Are these important enough for the downtime?  Can we put them into the
> migrated image alongside with the rest device states?

It's not about downtime.  vfio, vdpa, and iommufd pin all guest pages.
The pages must remain pinned during CPR to support ongoing DMA activity
which could target those pages (which we do not quiesce), and the same
physical pages must be used for the ramblocks in the new qemu process.

>>>     - Even if we have such a machine property, why setting "memfd" will
>>>       always imply shared?  why not private?  After all it's not called
>>>       "memfd-shared-alloc", and we can create private mappings using
>>>       e.g. memory-backend-memfd,share=off.
>>
>> There is no use case for memfd-alloc with share=off, so no point IMO in
>> making the option more verbose.
> 
> Unfortunately this fact doesn't make the property easier to understand. :-( >
>> For cpr, the mapping with all its modifications must be visible to new
>> qemu when qemu mmaps it.
> 
> So this might be the important part - do you mean migrating
> VGA/ROM/... small ramblocks won't work (besides any performance concerns)?
> Could you elaborate?

Pinning.

> Cpr-reboot already introduced lots of tricky knobs to QEMU.  We may need to
> restrict that specialty to minimal, making the interfacing as clear as
> possible, or (at least migration) maintainers will start to be soon scared
> and running away, if such proposal was not shot down.
> 
> In short, I hope when we introduce new knobs for cpr, we shouldn't always
> keep cpr-* modes in mind, but consider whenever the user can use it without
> cpr-*.  I'm not sure whether it'll be always possible, but we should try.

I agree in principle.  FWIW, I have tried to generalize the functionality needed
by cpr so it can be used in other ways: per-mode blockers, per-mode notifiers,
precreate vmstate, factory objects; to base it on migration internals with
minimal change (vmstate); and to make minimal changes in the migration control
paths.

- Steve

