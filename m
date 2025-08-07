Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2626C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1U2-0003W7-TY; Thu, 07 Aug 2025 10:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk1U1-0003Uf-CK
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:20:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk1Tz-00067V-M5
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:20:41 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777Ms3F006996;
 Thu, 7 Aug 2025 14:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3mtypba7OAurtqceBmz0LXmYz/K3ImWCus1W54zPDH0=; b=
 P1XiCqV8JxF3r/1jSlFaJooGTVIiOYmMSA1ZuhuVUMJXGbUSfES4KRtBBqHj0bOO
 twi+bBasy6UvCa91Aru9eQLVPbPxveyZLf3pMccn+6m69vzcB/vz6LfylzESbRMV
 N3XaOmHdPYKnW8V5shIere15SZhOwilGRCLWopD5IK7q5MEW69OeyjdXG2BMU42D
 Fy+E+hfB23Krs+VrN7khC4h3xytRfVvpIME1qmygrJoI6BVtMEqMCBoLQwBmNIlW
 j2yyCfadUYvdEUjeR7665M0s8Kfk8PhhD2jB3/coVlXMb/H0e0LjsxemtuVBG0Qy
 ooBxfj4JS82uzdisdKYiow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy4c09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 14:20:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 577DHqsl005661; Thu, 7 Aug 2025 14:20:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwygyd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 14:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZxl+IrlSZMrX0H/QgyP7X2vvJrY82BpCB9zgENeU2pMdikB1X3oF3UfaxuPyt697Xe4si4yAhRonR16qvZ7OkY5om+IjlnQ5KVWr1UvJI0nWJpDuD3VmDPTXl19WgwJztLK4Ci9J2sXJy/MM7ZqSsd1QUmM50DTR65U7+qutPdS876sPwxCEmJOArJoQp9X7hDh5sSksCzqrfV9kTlJg6v/ovnQ9Jsx7HTy1ScHtLLboXVta0mwDIFyf1KUcp8xuq7fhA5oVYDpiEk586iLYWvjgnbqJ8m74D3TqDuTe/uI3K6bMGljbyH75EMRG3VumuJAMqlWbDvIfdyjNRG9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mtypba7OAurtqceBmz0LXmYz/K3ImWCus1W54zPDH0=;
 b=xb/GtcUG4uOiKQZTi0/AaBORvy/xC5dOo7bqQKMKPCcnMdwq+O40CGkkYEtwMDE6u9mfhMo5A9VVzxYt4bTRZP7Rrgbm5tuLFGptNssAAqTFpd64MoSSZSELnefieWR4MYjROLo7rInYhc+x++1g/5Y9a+DWqctfHZzRKcG0wn6ulRXTWsW7WIz2qwGEEKMZojv8HI37/ykuQWB42l3oYIp9lOL+mLIHv/Kmj5JGlR/0MDQaJ872ACF/VENhFVO/OsrBFU3pKKg5COvyA6xMxPkVe6Sm2GM3/0uXGCaHAoZgP0j6eJ3Byy1x6z8TbjU7yp6c5+v/tAYIUr2nv67+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mtypba7OAurtqceBmz0LXmYz/K3ImWCus1W54zPDH0=;
 b=xpPrbLxZjpHKGSP7vPlDyMkCtyBE+8nSvoGPl21QJTq8P0l344H57cssYVqoLT8PumIQui/DSTER3xvHvNplQw+tVu3zyTne+qW31VUo+fYz/a1LZiK+WVVBaudBzfg4g1p07nemE7Ag585+WrD1nwGoXUr+npAy5b2LZOqW37c=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 14:20:34 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 14:20:34 +0000
Message-ID: <d96eafd3-3961-4abe-9484-a1533f841c77@oracle.com>
Date: Thu, 7 Aug 2025 10:20:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <aJN7uOWSt10U7DMi@x1.local> <71a1cb1b-49b9-4a4c-aa6d-429aa3cf8a8a@oracle.com>
 <aJSmZ2kmOeStv6aY@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJSmZ2kmOeStv6aY@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:510:33d::6) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SJ0PR10MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ca21fb-5c0b-440f-51f0-08ddd5bd92b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjFHa2RUTStDOEMwUFcxUTRDQ0RBZlJ3dGdwZkVtdjM5YmZKaHlqN1BaNElZ?=
 =?utf-8?B?VTEraFczUTRaRFVvdHZ0di9qcWxJblRHR2xuVXh2N3I3Yy93cm8wSTBTemo0?=
 =?utf-8?B?bDBnRDlnR2k4U2U1cXBjbmJYbDgyZ3FqaldYUEREd2lMVVR3dyt5RmlWSXZS?=
 =?utf-8?B?bkU5akJJLzhiK0QzR0V6bUJzQTVpNnJaVzVVWDJaakt0NGk4a0plMmNlb2pv?=
 =?utf-8?B?dWdJanc2SUZhWFZyQmtiaWExdHp1RXJDeldoVmxlQlA2ODJrZjFhSmhycnlF?=
 =?utf-8?B?RVZqS2ZtcEs3cDQ0cnpmUUxoaS9pcTFuVE1WZWxpYmhCVFVIU1RVUXF5OENv?=
 =?utf-8?B?cS9TRS93ejBqMU1UK3dUQVZVa2dGS0daWXlDbFpWQVF2dHNRb1RhTVlkZWh6?=
 =?utf-8?B?R1lOcnJWM1lydUxPa1VJWlYzM0xZYWk1a01DV0p1THQ3bVhLV3hlQnhmRVlD?=
 =?utf-8?B?Z3pJMm5RbFBpU0x2UkdVVS9OeURiWGtCVEtZWitDVHZpQ001T0EvdTdWSHVx?=
 =?utf-8?B?WjllZjNScFhZK2NkVWJWZEhKUlhqV0RDa0UzL3d1dGk0WDV6Tk40ZGJqMFpM?=
 =?utf-8?B?VUMzR3lHbzl5bmFZMFhaNjZvdlBYdTh0bGd4L3d5Wi9PMXVsSG9CTkdUVmJQ?=
 =?utf-8?B?NTVVanpDMStSMTFjWmdFdGZYOFd2LzF2dUpOT1dtZFp4ZTVOSFNIb0RtZmpa?=
 =?utf-8?B?L2htOS9TUy9JeVVBTGIxR2dyMnlKWVlBWUVpNWxoUkljNDc3N29yZjJJMVZL?=
 =?utf-8?B?RXdKYmRHakxSd2xoYSt1eElUS0o1VlR6M1p1TTNKOUJrOXFDcU43dXZlVnJx?=
 =?utf-8?B?STBBYTM4azhSei95eTM1UCtUYkZHUzVQcmluL2tZYzZzaWxYeHdQZXIzTzFP?=
 =?utf-8?B?OTZicWxEMkl1NjJCOEtEZnRubzl3VkxaR3VrVVdPajU1eWdsWEJGZXJWamFz?=
 =?utf-8?B?MHZudFBuT0EyVTRrL0Nyd0ExTlcrcEM0b0x2Ri9vQkYxZldjblYxTWcwTkg4?=
 =?utf-8?B?cm8yL2MwR2ZGcEVvaFFiV0NiRjZjMGxOS25LN3VKRnhBN1NtZWgwc2h5WGFW?=
 =?utf-8?B?WmZJenhqOVJESEJnOFdkT1JGemF4eUc0cWlHQ1B3ZHlWejg5NnZMUXlXemJQ?=
 =?utf-8?B?Tk5nUXh6Rnl4YTQ4cGJwZS8vYUtnUjNNR1dmVUM5N09MZWFwQUtpNk41cTdB?=
 =?utf-8?B?ck9helZaTnBtL1JRaDZFaWpBcEd5Q0VRVDV6cjU4RG1VcXVacDJjdDVkUW1C?=
 =?utf-8?B?T2h0ekRLZVlGbWJvUjB4aDNwYnVNYnNhbW1BR0dIOEszQ0cxWWZST051TGc4?=
 =?utf-8?B?R1hWR21rU2xuOFc2Uks3eEg2amI5T3l2MzNJYW0vODIxa041Y0tLd0M2M3Zx?=
 =?utf-8?B?TVhxLzhDWXh6Y29TSWlTSXBQaGRHNjRNb1ovUGNPNS9iemkrRGpRelFlUHhT?=
 =?utf-8?B?cVJSZGUwZzRwRklnTmU4RnJYNi8vSW9kTVhVdVA4ek13SnU2WEtwTFpCNlVl?=
 =?utf-8?B?YXY0cHlScGZROWZKc0FQZjVaU0d3U0duMDc3cElFbEFZUmZXa2N5N3VFUzJW?=
 =?utf-8?B?b3d5SjlTOHluRnM1bmJndDlQU3BwYWwyd09XOTZ3ejlLQUlucmRLOEtXVWFp?=
 =?utf-8?B?U3A3bG1mL2h4RUY5STZrTVNES0FtY0JVRzJsMmlYdS9WOVQ0SHZMN01MeVZS?=
 =?utf-8?B?RlY4ZWs3SWRhVWx6ZHZ3K2JSTUlLNUxvZUVuUFVEcFp5U3ZkV1dXZWxIZXMw?=
 =?utf-8?B?eldIUklHWGhRZzNpK3NURjc0RkFsYlZpcEw2RHFnTTAvZTBraFZib3NxSnJ5?=
 =?utf-8?B?d3E5cHZMczJpMlFob3gzVFRMbXlMMENxaFBZRXdOWThnTnZuYWV6L0g3OTll?=
 =?utf-8?B?VEo3amFWMkZ4UVZRc0twS2xvMHhlVXc5dVp2ckRpOUxpWTZIOW1Hbm5BWm5t?=
 =?utf-8?Q?Sd4k+6UIRD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUloSklHRi8wSDU5aVB4b2p6SDRTTythbTRzTjZVbzZKa2ZHRngxczdVVGFw?=
 =?utf-8?B?SkVaMTVNbnN2N0JYc1Q5RlJXVFhBaHl4YXorRm9XY1l2ekhWNHZseWZvYUxR?=
 =?utf-8?B?SjVOcURXYVc5V05vYlFKT1VjNVVQdkk3ODRpbm0zUlFicDNjUGtRbGxDSEFs?=
 =?utf-8?B?QWNOSEtnaVhoa2lCNStGU1NNcVdkSzBjaVR0b3dKTFFBNWF3bURYcmx3bEx6?=
 =?utf-8?B?KzF2OFhaTldQSHNDV0M4cHFjSlRTakxSNUtzZDE0WUVrU0ROcVJ2d2NYL2tV?=
 =?utf-8?B?Y3NwMFFjNllnN00xazV3UzNZam16bmszRTlBKzRaWnN1bGhkcDRnclRPYXJN?=
 =?utf-8?B?Z1poNHdxRlQ1cFNseklKMHV4NUpjVExrdkN4bmtyRHFZcVNVa1Uvdk8yVWtj?=
 =?utf-8?B?K2ZZSGlSWUZIeituc0RSZkN6Zll2MUtuOGNFaHBJZDRGcFB6OWVKeWU0R1po?=
 =?utf-8?B?U0ZROWhTZHBpQ3V0UkpUQlhvZUk3cDRuL0k1OW5ZMWtEWTFxTHFjMlVjeHIw?=
 =?utf-8?B?emRMbjZIbW5qWWg4aWMxL3lLZkVRVTNydmR1ZllEWVZQdzI1bnhMdWU1RlpF?=
 =?utf-8?B?ckNCRlo4SkFWSDN6OEQyOTdaYmR6Q3NuY2dZWGprOVhINktIMjVnQ2J5UE13?=
 =?utf-8?B?RWZDajhBNDJrWFJYemtJYnV0NDViTjZIRElsQkUrRGhyTUh0V3k5Sm5kSmNV?=
 =?utf-8?B?THJuM0NYQjlZQWIrU1dDUm8vWmU0Mk1BV3dxbExpWFJ6ajRlK0Nvckc3RDVC?=
 =?utf-8?B?bnRxRG1QRlVnU0RjdXdpa2Uwb1NTOE9oZW14U3N0VEJpZHRIL0orSnVtNTdL?=
 =?utf-8?B?bVFCMzdDU3I5UGV0QjdDVENScUlZemlvQ2tjNThndUFCb2RsS0JOSkNmVnNa?=
 =?utf-8?B?ZG00b2FubEJ2UTUyZVZ6cSsvOHVabzhablYzYjBzRmZlei9KUldxTDREMW9q?=
 =?utf-8?B?ZU5XdEZ5YXlic0Y3RUFHWmNObUpkWGp2dXVzWkJUVXJ3WlNyT2lyeFZGUTYz?=
 =?utf-8?B?NG53YU1iUjZmVUJEMU0yYjFTYlZJQk9KT085eGZIeVdCTE1sbXFKWEZQU042?=
 =?utf-8?B?UjRtSG5MemFpKzdpR3J3QVBVRGxVM01Od2E1OWo1eHNlM0xnbnVPK0lEbGRS?=
 =?utf-8?B?WFp5VkFodkE3L0xjQjA2a1UwT3pmWTc0emVicHRjaGFSR3BqOUcrc2pSNjUw?=
 =?utf-8?B?MllFNUI4NS9WZU1qWnk3djRmVFd6d1dvT2tqOFg0cUc2b1ovUDZIU2prWHBu?=
 =?utf-8?B?TkV5SHBaUDc3aThWSFFGOTZGOXp4d3RnN2F0RHVMZTBiMWE5Zkl2S2ZpdEcw?=
 =?utf-8?B?S0Y0TXExeEliL25iaENkOWJ0TjJzczlidk85WGJwbCtOSzRvRlc4ZHI5QWxS?=
 =?utf-8?B?WHc1bFZWNURKcmFSazBjY0RHODhXczVmWWdBZlB4V2NYSFc3RWd4bGFBQWtp?=
 =?utf-8?B?ejNOYU9Vb043MFd1WGJuWnJJendjMzhCdDlnS0JUai96S2NmWkpualBZNGdO?=
 =?utf-8?B?Y0hDTDkreUNZT05UMVo5RVd4NWFQUnFlUnY3RXowWnJtVjZoa2NodU5Jc2tU?=
 =?utf-8?B?Tmh6aWRkN0RUS1VsZ3g5aHN5cTV6RFpaQkFzazROaDBtQ2VkdUFZOFJBSFRT?=
 =?utf-8?B?RUZBWEl3QlFRcUlEaHhDaW9qMk1XUzNDU3E3UFlSd0JlcThNTkpmcjE3Y202?=
 =?utf-8?B?WFBDbEFEVTg4Q3pqbDhkbWpTbGNZd0xHakdyMkxVNGFLQW1uTTFJdTBwTW1R?=
 =?utf-8?B?cjlkWllGOEZoS0VVR0JpU2RTSE44aEdSeWhpb0ROaE56SXBqMW1MUDRleldB?=
 =?utf-8?B?NHlqUWhVbGdXSkRDRktrSnAzMFVQQ1NjVlNIUldGcnplcVdNRC85RjIwM2FQ?=
 =?utf-8?B?QnhVM3N4bm5YbDVrT3JhL0Nzd08zTU1OU09tbmgzRXdSaEkzWEYxSlhOSFdx?=
 =?utf-8?B?cC9YeEhRMVc4bld0R3pVMjNUNUtjUDhWcGxKcTQ3aGNsNGhOaS9TOFoyVkR6?=
 =?utf-8?B?REpGZjh3ODA4NVlEaXpJSWloZ3RMSFI5WGtXZGdhQi9naW8weWs3Y2J1dGky?=
 =?utf-8?B?RU9YQ0FxdmpRZzBqa3FsMkY3K1ZjVVNDOGZTb2lUUFFuSTFUandjZGZHd1NN?=
 =?utf-8?Q?jXIRA4HNon46AW9gX3rzWMuYe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XwmMbd9yfYgCwV3Omivuq+OnM1aX+rM7yMVb88/vpSoGW5689lLqVmaGonykPGKHwjw7dnjSNl4uNvQ6wudLPuXhgX3QirxOq9b1PENE6HJi0d+heneXAJHOPxsLb6OQflJLICUQgnduDHoV3h+avahn51aVkN9tqtW9/HukPV8b1pSHJldxilWA9xAQmXn6OBJKGpr4zibIXtMZKn2HrTzcPAmR0uG5JGNttnjj5Ur4CN7FnGCQqxkBQ6XwzLhK+fLeFoeMvCL4BR7y8Se69SN1gBlqE6m9mdqgruxsDl3iDXzDMSGweUGVi+zc5h4J7PbH5APkBPEdUlF0pkdUL1EHJB9UL4sfed8fKb2/knbCu/Pu6RfUG1jKIF+jHHkb96YyKCPX4dgThOSrD9TsT8Jz85rKYY+/BeNq5yqZs2PS9c8QpjHQt4LgZQ6fF2MR6qq7/3Em1PtSBtH7oFn43EMREBlKxpU0fCfTMBVf9/tt0Q9HmQBAxHj0aMzE9JM6OPsNOlZ2/vn0m2axt5nYueICdcrpRq2OK4GrvVnDHTQ/U4gYQCpVC32RTQD1gn9T3PuLmBh3oG25L00KtsxO1QNImzt5oZu0akAWEydK+z4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ca21fb-5c0b-440f-51f0-08ddd5bd92b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:20:34.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNhhEdpBGY5/0RaGrBH7kBeTUD/BN0PmPq9xzn0PM0PwXOIk23Zb5tv4ekLr9cpOXDuItsiRsmdT29VCIsAZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070116
X-Proofpoint-GUID: NhbQi7Ds8rwdYwGN0ZjPe8Tq_gy2oMXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExNSBTYWx0ZWRfX1WbX2luQFUu7
 fc/91W+VJz0+QMkSDoJqbx0U8A32LAH82nQd4qwk6zYth6m8GWbk3hRc+j+Q0Uq+oNSSlR/TJUC
 v1hpkKtejcZ2mGI+Crd2q+birzIAdbhDf6Mzrxw7nWtbfqdqgpYQsfFxUQVhufZrvMvM4M9CEag
 MPKNqUInqkWxQB8wVTc8GY52FgHbmDGoheGxR9YEixpmu07VNiGx2ukbbgdic5UvOWG7vnpsOs1
 m8mCjxPe+HF9yVSQuX1arSAHm6icTNbqQK2XLx8K/8+I3942tPUbaysuwbf7e7r6FBJpVHhI0G3
 JR77nDIYzit+2WtwH+RbInaSS7jl9Wzme/E/PbF0OWYjXXIgeA3tiszRo2lOZmQfWBw4zh/oB9z
 uXly+jboWGh+Mak8RtG4u36ZThsno24zKEc0kVBkRCKA//N1EylaZ7gW3WvGL2LLizGCNgpG
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6894b635 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CW8NoS6W4d_MTKokdm8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: NhbQi7Ds8rwdYwGN0ZjPe8Tq_gy2oMXI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/7/25 9:13 AM, Peter Xu wrote:
> On Thu, Aug 07, 2025 at 08:50:38AM -0400, Jonah Palmer wrote:
>>
>>
>> On 8/6/25 11:58 AM, Peter Xu wrote:
>>> On Tue, Jul 22, 2025 at 12:41:22PM +0000, Jonah Palmer wrote:
>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>> virtio devices, where supported, to iteratively migrate configuration
>>>> changes that occur during the migration process.
>>>>
>>>> This capability is added to the validated capabilities list to ensure
>>>> both the source and destination support it before enabling.
>>>>
>>>> The capability defaults to off to maintain backward compatibility.
>>>>
>>>> To enable the capability via HMP:
>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>
>>>> To enable the capability via QMP:
>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>        "capabilities": [
>>>>           { "capability": "virtio-iterative", "state": true }
>>>>        ]
>>>>     }
>>>> }
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    migration/savevm.c  | 1 +
>>>>    qapi/migration.json | 7 ++++++-
>>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>> index bb04a4520d..40a2189866 100644
>>>> --- a/migration/savevm.c
>>>> +++ b/migration/savevm.c
>>>> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>>>>        switch (capability) {
>>>>        case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>>>>        case MIGRATION_CAPABILITY_MAPPED_RAM:
>>>> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>>>>            return true;
>>>>        default:
>>>>            return false;
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 4963f6ca12..8f042c3ba5 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -479,6 +479,11 @@
>>>>    #     each RAM page.  Requires a migration URI that supports seeking,
>>>>    #     such as a file.  (since 9.0)
>>>>    #
>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>> +#     devices will track and migrate configuration changes that may
>>>> +#     occur during the migration process. (Since 10.1)
>>>> +#
>>>
>>> Having a migration capability to enable iterative support for a specific
>>> type of device sounds wrong.
>>>
>>> If virtio will be able to support iterative saves, it could provide the
>>> save_live_iterate() function.  Any explanation why it needs to be a
>>> migration capability?
>>>
>>
>> It certainly doesn't have to be a migration capability. Perhaps it's better
>> as a per-device compatibility property? E.g.:
>>
>> -device virtio-net-pci,x-iterative-migration=on,...
>>
>> I was just thinking along the lines of not having this feature enabled by
>> default for backwards-compatibility (and something to toggle to compare
>> performance during development).
>>
>> Totally open to suggestions though. I wasn't really sure how best a
>> feature/capability like this should be introduced.
> 
> Yep, for RFC is fine, if there'll be a formal patch please propose it as a
> device property whenever needed, thanks.
> 

Gotcha, will do! Thanks for the suggestion :)

Jonah


