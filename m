Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49331C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSSM-0001rt-QA; Tue, 03 Jun 2025 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSSE-0001rE-Rc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:17:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSSA-0007Ri-Av
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:17:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AElaa012343;
 Tue, 3 Jun 2025 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jio56fKh8l7fxGFVN4UaEK/JV3DxTV6MJKis0lEqx9U=; b=
 OMBOe/Gg9FtUJg3A7Wc2x66aLBlbaJ2BHV68TwlA6BBEuEi58zGDt0vmt2r8w+PX
 yLHAN1x97Y5JTvtbPVYFnLZtKq2Q5nBunF39PD9fwqKieWY8vxNE2zMaaKul7jP6
 3i5IyPbXZV2klJEvIBNiXbUEbBKeeUgIBawoGZDSpqRKO9skjHM0p2wLRlYi9vYl
 AID/p5L7A28uMElJ6QWWdUJuK0X2FhE0blDbLdRy95/XNsRCZedXTqU1q0kPYfb2
 GRnMUMlUB/JImXmmsc0KmkMR1jnL8vaiMhKza0I+OBtHoDHWGbrdJaqLYPCXqjn2
 TJpN0vocgB2fnuNy58VNTg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8ka0ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:17:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553DdWFC016167; Tue, 3 Jun 2025 14:17:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79dhej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wScnYiCQQiig0z1d25kmnEebn4P9m1yNaC+igW9CxibtLxJtE2t9jHpx+P3ezUR1Ffs6VX72P0YPcbwUoa4/HbiCEttnc8zYItVetcXRonMpyUj/VEqiWOBLxrEzdrjNDUS6eRhwDEkFdUTxZ45KoWhvhYcgX37UvfhbiLS1CUUHmbX43qQBpTbuYEpGz/YT59hwtPaWkGXWwwbGtPZI53iDoIBUusFC4s3nMX85rBBUhM4gNM0/Q1g0+oYLEaa3JfUwYIHg3MgshxNGWUCyH4XCpoNU7dSoeuyza85SZkRks2rufe5dbnNRgzUBrEMP6fkCxfSSmTRMnwJrSwknzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jio56fKh8l7fxGFVN4UaEK/JV3DxTV6MJKis0lEqx9U=;
 b=SQtMGEOUFBNP69YrEPDCRLsh1C90d3mVopLIkMwH5/Wah+2dW9YcRDQ37RZJswFw17oWzW7cOnNZTpdAulvz83m3IDsC2WQtI4sDr1IIlvOK4PnCcWVJqXlnZgK9JaSXYnS4EQJIwSGIaJVxSC5k7IbOLqaihcLGS5eN6f5mCUdKljEXK43fAXvBiTZ6Q07GzcWPDLmpkE4VItMnzdG31moXdaoHF0VGn5s6ptQK6ICpPLPPSEYDFuUzljf+VW7hB1p0lyQVEhYrxTEPzN4DlnlhhmiESfYm5E7MIktDpBZ8B3quZhvW/+8kgVAc0KH09JcdCh9uoOOEd+MEeYvBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jio56fKh8l7fxGFVN4UaEK/JV3DxTV6MJKis0lEqx9U=;
 b=M8jlVkxR4Ci5kuQKi3/M2UM1wyHZO0ltQhGcAFRPwXZhPacoxUk0AmdyoveYl50En6b9yLQhbmFrsM7imIbzV2c4R0zh2miTceF9fPddrRqZzOWawVA4ZA2Ehk149ozSza+e8LMVJaUl3ZjGFUDW6TiVhUXQunbBAG9uvwry9UE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN4PR10MB5607.namprd10.prod.outlook.com (2603:10b6:806:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 14:17:14 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Tue, 3 Jun 2025
 14:17:13 +0000
Message-ID: <9dc27182-7b01-45de-9f37-6ca37cabff77@oracle.com>
Date: Tue, 3 Jun 2025 10:17:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/43] vfio/container: register container for cpr
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136AF510081213140C10899926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <71730241-a6f4-47f5-b7d6-964412b4d0bd@oracle.com>
Content-Language: en-US
In-Reply-To: <71730241-a6f4-47f5-b7d6-964412b4d0bd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN4PR10MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b212664-c955-4774-5ca9-08dda2a95635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTFwVXhTeVpUMWZKMW9DRWd5SEhFemhHT0hza0wyczNXVlJ4QlE1dG42QUk2?=
 =?utf-8?B?UXgvaHU4R2NrQlBaQUVWZHp4dE5EV3ljV0pnRTR5S09GTDR6UHFwWEpFTUVl?=
 =?utf-8?B?MnNuWjlIOVl1K0R4T1RFSWVnUFFtZWlDNWNQTkErWmVEeEowQVlZUjM1bUVx?=
 =?utf-8?B?V1lWL3hwQXNBU0taNk8zRjdUWjlmSWp0L0xsUUsyWHVlWGJySXlDZWVHM3Ra?=
 =?utf-8?B?MDRNRlNNOXZXMHpaRkJ1eDBYUVU5ZWEyeHVzUWpJbWFMVlpFVStJemNLcis5?=
 =?utf-8?B?S3IwSmFWY1Q5bmJNNCtodlNUZFRkQUFkSENOVDJ0NFlkUENuZEE3eW1jZ0Iz?=
 =?utf-8?B?WHdLV0ZMa2hMYXk3Z0trdmx5YUFBMFJpNzRxQ0ZkNjJzN3VyWDdWZjdRdWVR?=
 =?utf-8?B?L3hMN2JmRVV0blcvVEFvNS9zWndlTjg0UDNYamZNL202ZUUraEhZZkZHOVU3?=
 =?utf-8?B?RDJsUXBEYURoenl2K2p5K2t2OFJIK3ZueTJIUkNlYjRiQk1DRHlDZDA0T0JE?=
 =?utf-8?B?NjRZM3BiOUFtYzdGYTN6SXNYdXEyMGtqbzBnRitMOVU2Rm1nZVdrVHJabE1E?=
 =?utf-8?B?OG0zV1hMNGpvUVk4cWxlZjhpSHdQbGYydWhJWktXWm1RbHQwdDdiMVkxalp5?=
 =?utf-8?B?NFIwOE4wVlpFRlNaa2ZkNzZuaWRzV1g1cnFUc2RFYmRkNWVhR01semNndUVP?=
 =?utf-8?B?ZWlEVkx3TDE0STBhQ3hadjVNU3pBcXo3eFFXS3NlZG1aejl4TUZ6RVRRQUpS?=
 =?utf-8?B?N3VKcUhlREtYUHFESkpveHFIdVJnQ0Q4N0sxNldmczV6Vkw3a0dBcFMvVnpn?=
 =?utf-8?B?RFZ3bW9jTHE3VFVRc1pXL0k2b2g2aVU4UzNOVnY3ZmNVaFcvRnBUR3lRVWR3?=
 =?utf-8?B?ZHBsazVxN1k1Umx5VXVYVmVNTWQ0TmxyUlZyUWp4Y3pBZUxOYXREWVYyQ2o3?=
 =?utf-8?B?aG1tNVhCUlM3dy9EdmlzMW5jNWkxZE9CWlhJeGtDaWRuNjVDc01NRmM3MVNr?=
 =?utf-8?B?MEVHNG1TZU11UVlBV0Z4N1F6S2xBMmhHSHNSQ3ZVOFh3ZjB6V29IR0tJZ2hJ?=
 =?utf-8?B?ZjNlaWpnODM0TTc4c3FUMlFmSDFiYzloTE42WndXMXplaC9KV1NqVEo4UmV5?=
 =?utf-8?B?dCtYVkVmUE1iN2gwMWppckE4TExlYlg0WmdXaTZkSTJ6bjlZQXoxYUQzMFBy?=
 =?utf-8?B?MWdKOXBzV09XODY3RklzZkdNa2NFaGFoUjA3QmFtZTdXbDFOalBmOXcvSXJ6?=
 =?utf-8?B?VmJZVDVNOE9hZlo1MEtjYWMzdkRZSUxUZnI5TExrSmp6UFpUMkk5OGVOcGps?=
 =?utf-8?B?NHRQd3haL0tPL0o5MWt0N3J3U2RQOGxKRDFYK3E3ZVphWmNRNktPYWViVHRJ?=
 =?utf-8?B?RmtIUDMxNitUN05xUVQzSUdpRWhkUjJ6a2E2ZVhZQWZ5WWRSZXRzYVBYekpE?=
 =?utf-8?B?Uk8vSzVmbUlmRi95T0pPUkdwV1ozb2RxNld4Sjh5Y2lrNXZRUmpEZCtqN3dI?=
 =?utf-8?B?K1Q0Q1ExUS9saXpQUG9qeXRjWmRsWUlwRmp5dzBndDk0WVd5ak9yOU1OZ2pM?=
 =?utf-8?B?bmxhaGFCcGFqc05GcEd4VlcrVGQrUU54a2R0NzF0TTRWUnUrSXh3aVFPSFE4?=
 =?utf-8?B?dmZVb0w5Q0lyeUZiTGZZakllcERKZXo5Z0dFVlRsMkZVZndmMVJmZjArSmhX?=
 =?utf-8?B?SmhBeE9Cb2ZmUnJGTHhFTTB1UWdTT0VlTXA3MWkwNldIYnIxUW5TVjJnK0F6?=
 =?utf-8?B?bkd2czlsYmxFeTV1eXhSQWZ3bG84cFFrbWZuejRGOWVIMDJFRVVhUjI0K0lV?=
 =?utf-8?B?eFRpMWpYQ3ZpUjFwb09BRnlSMWhyclA3R1YxV3NtclFnWnpCUEVndTN4VGVa?=
 =?utf-8?B?MnhxR2pzYnBhQzVDMnJrUG1wNitzSzdpc0VSVkZINE5LRUVmN05ZZ2RYMDhR?=
 =?utf-8?Q?gS848MKyZ6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9Da1VTcHhzTmJEd2QxZ2JKVlY0cEhLeE9WWkxiUzZxK2JyOG5MekdxNkE4?=
 =?utf-8?B?VHFrcDMxT0I4Q2xsTzZMT0x5YWZpUzVITFNNRmhRVDJmQWx5dWNUemwzakxX?=
 =?utf-8?B?b0JVRkRBM01wTHlxN0pTU0h1SVhkRjdJVjA1WlBBR0ZhSURpM0l3MUR5QnJp?=
 =?utf-8?B?QWpoL09naThhM2IwTm8zYzZrSXljUjNYUkovQTlrM3hFYm9nTVJ6OHQxNDlp?=
 =?utf-8?B?MTAzUHA0L2FVVnhVc0pvZitvcGtQTVgzUDFQS3N0ZWpCT0hlZWx3Sm80TFBH?=
 =?utf-8?B?Skk2RGQwUnNVc1ZZR0ZnRnFGWkFZZTRRWEROMFhjWnNITlBDT21NdWlpMklL?=
 =?utf-8?B?OVlvSUpRN3lZZ1VDeTlBOE91a0JxbGhCM1E2VU1HUko2aUxlNjRzR3UwVUNv?=
 =?utf-8?B?dG9sRlVQL1lZMzJVbTZzZ3p6dmsrOG1kc1RsTlgwM0xxaG5tdVZlM3BUT2RW?=
 =?utf-8?B?QlBoTDdOR2p5OEtLMVpBSWhyZFc1am05NnFXOHV3SHBCeHppYkI2YVM3WWp0?=
 =?utf-8?B?c0QzUmwxRHMwWmJLRlJBVWRNVi9ReUk4YSsyNExudlhvckhFNU9LVE9NNDMy?=
 =?utf-8?B?MU15VGxTZW4ya1djQmtyUzBvRXhBYWs0Q3lGWFIrZGtVTHN1RDVsTkREL2NJ?=
 =?utf-8?B?bzU1T3o1U3lpNU9jNVhybFlBbzFZWC9oQVFWekZYTE5ZM2J4UWZyKy9FWkxD?=
 =?utf-8?B?RUs0NmRRYWMzdlpRLzZia0c0TnRXUUwrY204ZG1HcmdKQm10d0wvM2hlb1R1?=
 =?utf-8?B?S1FoS3pwL0hzNGo4M2doYVQ1SHk4UDREYVY0dlcrWWh3WWRWbFNYampscWVx?=
 =?utf-8?B?SExLczdJV2d3NWRUV3ZaOGp4WUpIQ0VsYjV5WnZKbmkvYUZtVVBGajNRQll0?=
 =?utf-8?B?WkZSRnJlWUVXS1F2dWJzems3L2lkT3llYmVJR1VOWkdUVHN4czlZazgvWWxY?=
 =?utf-8?B?ZU1LNVN2dFVrcHg5SU5KeWNXbmVpZXAxbFNmOEZSaGlKVmc5VUlNK3lZTHAw?=
 =?utf-8?B?TUhmYkpvaEtkOTJnSWlBZ3FuSktwWGpIUFl6ZEp3Nk9FMDc4cHJ2SWpReUxm?=
 =?utf-8?B?UFBKZTJqb254Rm96K2FpdXcxYUpoaUMvYjFPREk5NlRlVWhrbWQ3MDVHVkx0?=
 =?utf-8?B?UnJCbm9TNFFsTC9Rd0tRQ0k1eWM5NGUwbDFySUFBOEtwc0Z1cFdUc08vUlNt?=
 =?utf-8?B?cWhBNVJCa2trK1E1M1JnZW9SaE51SXN6Vndjb3VFWE9IaFVjUHFSY3h1VW5h?=
 =?utf-8?B?ajZRRXM2NmpmR0lvVDl1VkFCcW9IZ1lJY0lkMHBBS2hLZmhVWGxUbEtYUjYy?=
 =?utf-8?B?TXA0Skp2U2w1SUc3Ym9xc2JQeFZxYk5PNUtFZzBZRWp2S3dJRnVhT1A1Tk5R?=
 =?utf-8?B?UWxSSkx0eDBoOXNOQ1FyUGRMb3IwSE9wdzlUWmJyR25mQUVuSm5QRFNuaWNR?=
 =?utf-8?B?S0VqOEFJUVVnV1hScWVXUXhoblZ1K2VMM0QyemtLM1U1dGtWbUIzU2NOM0NE?=
 =?utf-8?B?VndiSTZNYXM1akFuQUR6Y2QvRkNKNXRxa2ZPR1N4SkhiMGRSQjNIM3Ezd3FC?=
 =?utf-8?B?SWhLNUxNZklyYXJLVHlzckNEc21GK2xHaDZLVUd1UUpyRXk5bjU2WnNxc1FL?=
 =?utf-8?B?eW5CcHdRK1lIVFRBMWdzZzg3OHFpbU5aTnBZcXU1Rlp3dWMxdmhXY1lUb2wx?=
 =?utf-8?B?dDRrKzY5TkM2eWVRV0NzL093dUVtcFJvcWcvaW5YQ1lpRG44REY4NnlSSzlU?=
 =?utf-8?B?TjZHUGlBbFVaeGRCZ3BjYUZnMW1EY2NUcnBtbWp4NUU2L3lNNmJ5R2Rqalpo?=
 =?utf-8?B?WXQrRkNJRzFRWWV3NUh2TnIxNElZZDFQcWZYdWZOWHpMSjhPSjZlNTM5K211?=
 =?utf-8?B?Ym1UWXZXaWJwemtsNXgrMWdjekV2NDROYWw4RmVZdkdhRFBvaDdCUmdld1BG?=
 =?utf-8?B?Rjk0SUZyeW51QUpzcTlJYTJJTHRxZHdGUGFXdGhFUVdFcExtL3lVb0VSMG5Z?=
 =?utf-8?B?RC9MdTFHRjZDamZnbEI0cWMxZEhxRG5GQlNDNTNPMk45NXUrQWU3TGtVaGQx?=
 =?utf-8?B?QTJmVWIzMTZGQS9MU2xuSFA4WFZKaXE3R2RicDU1aTNZbkE4L3VuOU0yNjY4?=
 =?utf-8?B?MWNCRUZQT3ExQlFINHUrV3picjJXczRQeVdPMm1PcjNSaExDdnhMNFY3bGFG?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GSI9CHkvjvg43vSJd5nuCcTEMGb9yTCiwfV5sKpXgGy3IlvH/etCJXmCujxZM/DZbtt4YkxfRCLmULwIGa9uLm2SJDqjuczYgjvhcACTTjRZQ9ZhOc2VKrA+C/8smNcw4eMwQvrzRaWhtyfzhd/Pk7HkM8eK+ZNsD3Hg/p23oAYt47QCZ0qF8s60kEh25XyO4lvWl+83WPsJcqmR0rfNvxcZkoT2xViSvsxQCxCQx80YHmR5ISX9yuwZfrT3c30yDy+YTIfM/ziKALRUaJpnUobOxW7KppH79F2gR+Uh3ZUcCvChlU7JXD6H00L1G2L7HdwBqD+HimeizgBuLeDna3a5kRj5jDy2el3SAwtgQw5WZzZnKa4Og0NmDuK/w8neHy1rk03Uv3J+B6Dq1azIWGuN7Imbaeg4BCb0FTqgq648yp1yBm9RH08Ino3LNxtbiBRxQyr/5U0Vb426w/9d/ByFrVfeCEgPOp7FfvwNcySMM6BGzYqVbRyhPQfMtDEBgNEA1aBsoIW6eb3tINBSKg9Uazaa8Xz/R46dFcQ8zbUQsqhS9kFFTuFNQ3yEfDkavEd0sSdYSTPD9mOt2lMhC9RigDIK51A9GbusDxOEJ0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b212664-c955-4774-5ca9-08dda2a95635
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:17:13.8758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rthdcYfx7W3HfCP1DgZh2cnnE/JOohkWfHnJKA4fNOEP1j1vTgsO1hE4s2SZ+7ZrfQpiUK2KrNDKk+kZy5O2PIDnI6oUfjr5wc1AU18QelI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030123
X-Proofpoint-GUID: Z1j3yfXNqaR2xH6P5kMdk8to3CFqcL6Z
X-Proofpoint-ORIG-GUID: Z1j3yfXNqaR2xH6P5kMdk8to3CFqcL6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyMyBTYWx0ZWRfX2z5QoXerea1Y
 rM6xIg+fZDXAN/w61vQShk3S1vuqxAnoPvU8bmhctaoUvBo88USatHnDdsP2TNF56tc3sqHXLWH
 gvcJbuE8xYj3sK1e6fPUrkhsjhjTcqX1Ib/0jIayXioybP0BwerlNF0RF2xTLm8vi4Vca4pXCDQ
 +elTaslyBTTvJK8vPIi1/qjWvEsUvj8Q8Fd6N7DDzGFM/7CmDJ+1guFiSHYKzjwCtuz1kAHtxM1
 zHTA4SNt7GOOFA3OOnn0sE8KXcONslRNs+6FVsEScW+OreKEXl4R2MkmJHqA3iPHlVmzMEHMRB9
 259+psAEVjoT/pNZcm9lIEHdyUTEt1dilAC6XwHvkwcwhxN90UTv647IEoX5LMU9wVJbrBieo4H
 n5WYT7gb0L6CyzKFdh9IrwRFErNHN8MmGpzGsVXAyqFrNnDXCe9QMhjHbQFvwAIgMPiMuIxp
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=683f03ed cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-AlQ0YkTUckXxXDdEpsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/3/2025 10:09 AM, Steven Sistare wrote:
> On 6/3/2025 7:57 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V4 09/43] vfio/container: register container for cpr
>>>
>>> Register a legacy container for cpr-transfer, replacing the generic CPR
>>> register call with a more specific legacy container register call.  Add a
>>> blocker if the kernel does not support VFIO_UPDATE_VADDR or
>>> VFIO_UNMAP_ALL.
>>>
>>> This is mostly boiler plate.  The fields to to saved and restored are added
>>> in subsequent patches.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> include/hw/vfio/vfio-container.h |  2 ++
>>> include/hw/vfio/vfio-cpr.h       | 15 +++++++++
>>> hw/vfio/container.c              |  6 ++--
>>> hw/vfio/cpr-legacy.c             | 69
>>> ++++++++++++++++++++++++++++++++++++++++
>>> hw/vfio/cpr.c                    |  5 ++-
>>> hw/vfio/meson.build              |  1 +
>>> 6 files changed, 92 insertions(+), 6 deletions(-)
>>> create mode 100644 hw/vfio/cpr-legacy.c
>>>
>>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>>> index afc498d..21e5807 100644
>>> --- a/include/hw/vfio/vfio-container.h
>>> +++ b/include/hw/vfio/vfio-container.h
>>> @@ -10,6 +10,7 @@
>>> #define HW_VFIO_CONTAINER_H
>>>
>>> #include "hw/vfio/vfio-container-base.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>
>> Now that we have this change, may we remove #include of vfio-cpr.h in hw/vfio/container.c?
>> Maybe this belong to patch8?
> 
> Yes, thanks.
> Patch 8 should not add #include of vfio-cpr.h in hw/vfio/container.c

However, I see that Cedric has staged these patches in vfio-next.
We can make these tweaks in a future patch.

- Steve

>>> typedef struct VFIOContainer VFIOContainer;
>>> typedef struct VFIODevice VFIODevice;
>>> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>      unsigned iommu_type;
>>>      QLIST_HEAD(, VFIOGroup) group_list;
>>> +    VFIOContainerCPR cpr;
>>> } VFIOContainer;
>>>
>>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 750ea5b..d4e0bd5 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -9,8 +9,23 @@
>>> #ifndef HW_VFIO_VFIO_CPR_H
>>> #define HW_VFIO_VFIO_CPR_H
>>>
>>> +#include "migration/misc.h"
>>> +
>>> +struct VFIOContainer;
>>> struct VFIOContainerBase;
>>>
>>> +typedef struct VFIOContainerCPR {
>>> +    Error *blocker;
>>> +} VFIOContainerCPR;
>>> +
>>> +
>>> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>> +                                        Error **errp);
>>> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>>> +
>>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>>> +                             Error **errp);
>>> +
>>> bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>                                   Error **errp);
>>> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 0f948d0..7d2035c 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -643,7 +643,7 @@ static bool vfio_container_connect(VFIOGroup *group,
>>> AddressSpace *as,
>>>      new_container = true;
>>>      bcontainer = &container->bcontainer;
>>>
>>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>>          goto fail;
>>>      }
>>>
>>> @@ -679,7 +679,7 @@ fail:
>>>          vioc->release(bcontainer);
>>>      }
>>>      if (new_container) {
>>> -        vfio_cpr_unregister_container(bcontainer);
>>> +        vfio_legacy_cpr_unregister_container(container);
>>>          object_unref(container);
>>>      }
>>>      if (fd >= 0) {
>>> @@ -720,7 +720,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>>          VFIOAddressSpace *space = bcontainer->space;
>>>
>>>          trace_vfio_container_disconnect(container->fd);
>>> -        vfio_cpr_unregister_container(bcontainer);
>>> +        vfio_legacy_cpr_unregister_container(container);
>>>          close(container->fd);
>>>          object_unref(container);
>>>
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> new file mode 100644
>>> index 0000000..419b9fb
>>> --- /dev/null
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -0,0 +1,69 @@
>>> +/*
>>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include <sys/ioctl.h>
>>> +#include <linux/vfio.h>
>>> +#include "qemu/osdep.h"
>>> +#include "hw/vfio/vfio-container.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>
>> Ditto.
> 
> Yes, this #include vfio-cpr.h should be dropped from this patch.
> 
> - Steve
> 


