Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA940C36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyGr-0001Qj-NL; Wed, 02 Apr 2025 09:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyGZ-0001OT-80
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:36:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyGV-0007XG-UH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:36:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN4kx021787;
 Wed, 2 Apr 2025 13:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=V/WrSnP/m3anAQunoczegMc+0En5z6at8E8q1NDl6AA=; b=
 frhe9XBrFcwtkhV9MhyJOHRHiH4S5By7lvg1zSvQf5imlEHxgKPdTyv7SmHMB5G4
 EBkccwpBizYuY5F12nIfAEVcJajAbsyLgvsNtTEmcfD1HNzVYjisoFigZ+lK9HcH
 XlaH3u1gHoPzd5R2uSduWB93LafLQjsZzgOljKduyBhqV6yVGO/zGdRYExi3Zcpk
 flYqTHr3ay3tP57YD+rwbcAhRYSJe63czQV8l/rI/Vg8v4syFuGosZrUlbSA8IoX
 UeWobGU3MmImNjvn2Sqwkd1eWNI+8afUF/8uVfx6/T1qx9tcaDsdkUjSLZC/QVrq
 flz08TPbwDl4gs4NLMpvzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9j5u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:36:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532CiFBL016801; Wed, 2 Apr 2025 13:36:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aapkes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF0EGC0zsKLpkYom6LsJ7RSBAflBJXCJn6oGfbva+RAZR28+ejoFoZxr/MznYoH41DbvZL9Iq2YjJBgnZkI6OHjyoEPjhARnktPgtvW0rlXTPd9d4naPEkBBExYw/wJ109GkTnpslc2XdY7/fja0ZWGjpnmc5Z5klS29gfWoWRwxbuT75d6I8kGEp6ZRTRw7YR2qD05TRqpRDWyQjwy6LmeE25ohWsrMns0yp6v8b0G2Q6VbZDwA7g3cEBVh2o4TXu9wefkAudQGpjlpT3csrVmUk2iQgPbxGhrBkRIwP2HqpDDo+vmERn+sL3DuMTrlFw/ZV63SLWdlorgBAf2rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/WrSnP/m3anAQunoczegMc+0En5z6at8E8q1NDl6AA=;
 b=TYj3pP19TdNTs7QDoWeWEUHs09kSRfqkPuGkDtPUR+oyQp8zgHVGOmXGNSPZroDqDtCv6UdyjDXpBLpKF4rz60YkA+g+I7rtYuejMX7iG5Cc8UAJLd7+Tjw2ckXPR/cHlrpbgRVkmHbzvkqODVHNrd/yX01VS2XSrxEYvbC9ZuvWGUehqTJnNwMpTOycVXlzP9tZoHvuCijdM59GI8qV01uIOlKw5gjeBDhCgPjTeSCuw/UINeLzzT2maZo1VX4yiYOxF6gnAzn/rKlvLv66slIK9CSdSudCjYxnYBr2il5H96lsCWIUg0pPBo/qOiasO/QloiG78WnBrt/enPkD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/WrSnP/m3anAQunoczegMc+0En5z6at8E8q1NDl6AA=;
 b=A00tWvXgjvghUieGsotX3deP34MIHFdX4ORV+iOtGJ4Pzv364MRhdopZWWoZXNJBHC8kYg6snBmRMzAED44jTuBZvkVw1wogl3FKJBbzVnC+aBgEZEW0qRFfY+fEQ5t7Zgt48Xmjtirf1XHqtAcwQ7ah1EzL3cjTZhu0EB3D7FU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM3PPFEACE3F2B7.namprd10.prod.outlook.com (2603:10b6:f:fc00::c54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Wed, 2 Apr
 2025 13:36:17 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:36:17 +0000
Message-ID: <f228f741-5c6b-41f5-9491-bc470ec78111@oracle.com>
Date: Wed, 2 Apr 2025 14:36:13 +0100
Subject: Re: [PATCH for-10.1 v2 29/37] vfio: Rename
 vfio_devices_all_dirty_tracking_started()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-30-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-30-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM3PPFEACE3F2B7:EE_
X-MS-Office365-Filtering-Correlation-Id: c2704cb0-e8c7-4dcd-2254-08dd71eb5859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGNGSlVoNGZSRWFBS2o1a3Nnc2Iva0JIR3AxV3NGaXhIU21qN1U3ZFUzRW1Q?=
 =?utf-8?B?YmhSbFhoeS9pZE52YXVEaVZuQVpwSmVvVmgrUCt0MElScGhSdHBzVHRHT1E3?=
 =?utf-8?B?a0wrSkx3TnFLbngxRzc0SndBczRjSHdrZnh3SnJYMlJNYTVOb2dldXhnbDJP?=
 =?utf-8?B?WkNmb05aeG42bXl3N2xpVHdHWnlVZGpyRHFKRitvVGZhT3F3bkMxdWk5b1Fa?=
 =?utf-8?B?bExzMWZ6N0VCdFJKaDdUL2ZBaTdhVjRBNXlmY1BGTUltVmxVTWwrT1k5QmRi?=
 =?utf-8?B?UVgxSGxOZE1UTURZU3gyNXBTMGg0dU5YR1BLekxTZ1o2cE8vbE9hdHJ2S2Fj?=
 =?utf-8?B?STFqRXFGbGV6UzUxbEpOYXo2eEhLQVdQQ2lDT1djdndERXNESG10Z3U4TzB1?=
 =?utf-8?B?ei9MRitqTHNwaDZ6Nk5oUGdUUGMxcmUrbzVTaC9wdHdvSDkrOTU0WFpGQTV4?=
 =?utf-8?B?SmxJY0RINmlhaUlnYXVBYW1zcFB0M1pia29DSWtNakQzTGt0L1F2UHkySUxw?=
 =?utf-8?B?V1J5TkdMMVJGQkZWUjJ5ME55WTBVQzZYWG1QRG1uVklHZ3pTV2tvKytveDNQ?=
 =?utf-8?B?cVJEYVNtQnlWSUNRQUF5WEVtNm03Uis1bnE4QUtzRDdtQWhWQjdYeE1yWHJC?=
 =?utf-8?B?YXRoeDBDTEZjbG1TL3l3bWpkZlhMbWk2Sm9Mb1NUUWxBaGJFOURMZWcxWmJG?=
 =?utf-8?B?c1NTSklXM0hoTFNVNnlBbGllSTczemNHV2F4eTZHRG1HSTRMZEFIWkRXSTE4?=
 =?utf-8?B?OE8rQ0YzNllUbDc5OEMxbnR6WnIxMDVwdFNXT0lCYUxNTmFOdDhZTi9NVGIz?=
 =?utf-8?B?VDBLRXNEWmtmcFNUbVkyTUZWMnNXaUNnNnZHenQ2ZE5NalZrYkx5ZDBWVTJH?=
 =?utf-8?B?Q0tsbC9hcEZZU0ZOV1NXb3ZtVERSMkswR3dCQzkvbnRNbGd3djRxandpL1R3?=
 =?utf-8?B?SWxzdzJSNTlpZC85MzFiYkVmbjhjQTBXTVorYUtuWXBsbXZsaG95YnVCaTBW?=
 =?utf-8?B?S0cwU2JvbE9yQUsxdzE1Z3B5VGo4TDY2WWlhSFQwVG90eE5mbTRpY3V3bHhm?=
 =?utf-8?B?K3hobXI4R0dDeVJxUi92OW5zeUJNbmd5V3hlQy90a3RpT1BrMW5xODd0MmVy?=
 =?utf-8?B?czVnUlhZMXEvdzV4NFcxdFdMMnNFd3p4NHhiR0g0T1Z4a1llSTBYMnV5NnJC?=
 =?utf-8?B?emN4K0o4V0wyOEE3Zkdwb28zVGpGamZmaVNLSXd6cGRkclNhbFVOOXdHVU8x?=
 =?utf-8?B?dExWeXpTNVh1TFg1OFJvUHZiMEdycFg3a3VRMGoyM3plVUtCdERSYU5SYzYz?=
 =?utf-8?B?V2ZYMVYwY1FYTVZ2QW5jQ1QxK201MzFiMmZJNVpYTm5pbVFzbWFEcFkyWmRZ?=
 =?utf-8?B?ZjhlOEU1TGFRbHNSNmhWMG9rM0lSMDliLzNTbTBRcHMrckd5SmlYTVlsc2hT?=
 =?utf-8?B?VmZBQkxxamhRTVdKUFZPVkV4NGxZTEVueGExa2FSeHNxTWV3RTJCOFpicUdK?=
 =?utf-8?B?cjVnM2pBNXRlekt3TE9WcGdNUDRKZ1ZheEQ2UnFZeGF4b3R4bkVibFFxdk9N?=
 =?utf-8?B?TGhnMHNQVzJqNlFnU2Z4R1lYdS9pZldBcmVVTkhqVWhSZEQ1YS9YMFdFMmlQ?=
 =?utf-8?B?TVZONDFNVklrV2ZMMUhEQmxCMngvRk90QkRQaDlnR2Mxc1RIZEsvd2pTT0Rq?=
 =?utf-8?B?c2hVTlA0ZWJRSHEvclJaUSt2Ny8wMFBaeWt4eldrTVI0ajYwN2hBYVVWTEdm?=
 =?utf-8?B?RDdDUkFoL0ZtMWw3YXlqdXVoZ1krNGU0Qnl1TXlGbHNCbHpITTNZWXluZTVk?=
 =?utf-8?B?ZDZUMHpDU2xYSE53WklXdkQ3T2orMXZ2TSs1T0s0U1dIbllZVU9SYzJqWjRY?=
 =?utf-8?B?RGhhY2MvcDVybW5PRHZuYVg2aFM1VHlCQk9sanhYb21nd0NicGl2dGQrVW9X?=
 =?utf-8?Q?IBJgl1Mtgj0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZGaG9LeE9DaGhmN0VlTGhCYmJITXNtLzdPUU04Z0ZJYnBjMHFvOWRhSkh1?=
 =?utf-8?B?RzBhUmtmWkc2TEdwb2s0QjV6V2pVTnhVN2loWWZIbGpnR2J4SFhyRU1jUkdP?=
 =?utf-8?B?Q0IvZXBBckNxYWJhOEc0WWZldnhkc3JyNGtCYnVTK1FCNml6NDBkV2JnclFJ?=
 =?utf-8?B?SW5MU0lMZjZ1eGVUMkd5cnRrSWdOeTAvUWtTYTVuNmxRV2tBaDcwZkdqcjEw?=
 =?utf-8?B?NmlDWjRVZlB5K0oxOHlhODd0bFhsV2V6KzRQUi9VKzN6aUxmSlJUYkdnK0Jl?=
 =?utf-8?B?b1Q1WHpTQXJDd0VrcVc3VVhNU05SdWlxWjNUU0p6VHVlR1VLdHBIaFpMaUhT?=
 =?utf-8?B?d01jN0Zab3JnUC9rdnYyNjQ3OG1Jb0NKcS93d2RkWUZUcjc1UDdENWp6dDlR?=
 =?utf-8?B?MjQ5Nmt3eVBVRkVBTDlaVGtnQWU0cjdVY1crZGpmQVdlUE40dmNZMytvcWZh?=
 =?utf-8?B?cFJhUG9LakkvV0h6OGZvRkoyVmxYSFQxWDJ6N2xZNTk5QTVwWHNrWHF3Nld0?=
 =?utf-8?B?ZDRISTFzZFVMSUxwVjZVajNDM3NhY0FaOG0yN2NCeUowOWY5bWZSMmdtVTRp?=
 =?utf-8?B?QnlIOGlScDZ5ZC9TdzVXRFNhYWJXZ2ZXaG9GZ3R1dUlrdTROUHIydnhvUld2?=
 =?utf-8?B?azFzYTc2bXFXa0JSbW5iQnZHbHdHYjFPZTA3R1RSa2xjNGRlZ2FxK3gvRmg5?=
 =?utf-8?B?dGprUjVBaVpmbXNaSFk0SlVxWTkwaXBlRU4vTE55RDAxeWIyOG5BQWc2OGxS?=
 =?utf-8?B?RFdzdUpMaG5zanUvZzRZQjUvb2Z6WlZETXlmR0wza0JyS1hpWXNsWW1LU2hF?=
 =?utf-8?B?UVdGem50NGNubzR6bUs4TFV6OGU4eDBFbkpvMTQzT0V6NWd0VlVyYkEyQlJ6?=
 =?utf-8?B?aS85ODNxeGFIOHh5YXZoTFdTV0JFMDlhUHB1YjFXb3JrU09kdUVOTWdkeHh3?=
 =?utf-8?B?aHI0dUV5NG1Qb3dETCtVM2J0TUZHMHlNaTVSUVVlRXZ5NndJK21HRHZXWDZu?=
 =?utf-8?B?eFZXQ3hDaFgvSVBaRlZSak00UFZoYTJOUmdSdmdEMUtDeC9SR1hzN3pZVmRT?=
 =?utf-8?B?emExWnBzR2t5WUhOQnU3OEJPR0xLdFMwc0kzNTFYaTB4YnpiY3oyLytVWU1n?=
 =?utf-8?B?ZUlQQi9BS25TZytqdml0aGNRanZQSUppQUlsZ2pJMUVqZSt6MGx0MkdyVVFJ?=
 =?utf-8?B?WVArZEtTT2Fvdm8xVUZyeUJDMW93TzlVU2ZXTThETzlzZTdkcVBDb1k2OWpS?=
 =?utf-8?B?dHZmZEdpcS8rQTBtZnZZZXMxaDN6UjdERDdwTFh6d2VsSHljejdQMG1Rbk5I?=
 =?utf-8?B?Q3lNY3NYeFhNVTR4M2hGaURMWHhGazJpVVNraFlDQ2FaSXBvUWswd2xQM0Vs?=
 =?utf-8?B?TkVUSVJvdktPZHorTjlhalJhLytQZXRNMThOQ05JbHFnWCtpd1lQUlFpOThJ?=
 =?utf-8?B?c0hvbXhBdFIyYjRxNnN4NXFqVmNoS01RNEY0RDVReHN1VmF3VkhHQ2ZnY1Jo?=
 =?utf-8?B?aUFxVzcwMndCYlhsQ0NHM0doaXAvOVhjcmFtalpSWGtya1dCYTB1OEEvdUlT?=
 =?utf-8?B?YVFWd3Q2UE5OSmtkSVUwWjBnWUEwTllaMEltNmxDUzJsYW5LZG9CS3lucitx?=
 =?utf-8?B?eEN5WmVWdUhhd2xWQmFBM2U4NDZpMFF3Ry96WnljWlRhVmhDYjJGRWFidEtP?=
 =?utf-8?B?cGpjY0wwbGhsS2hyTW1xYXdEc2pkeWd2V3J3dVhTbjBGUm4rQzZUZ3ZUZEFr?=
 =?utf-8?B?ZDBiM21yWHdoY2ZoVjdzbk9acnM5Y1lUcWNvVWU2YmRzdjJoV1A1RXdUeThZ?=
 =?utf-8?B?dG1hcU53NHdLL0pyNWxUTVhhUG5hYTA5NW1LZGFRVWc2a004YnVkS3JURDRp?=
 =?utf-8?B?eHNhUHhtc04yRis3R21mbkRqWnFKbmthQWFZZVZMakVZK0E0TUVpcEN2TlNu?=
 =?utf-8?B?cEVkR016Y1VmQUlHbUU4eVcwZ3V6cGVHNDBrUUM1czBScGh2ZFRUcmVWRmNi?=
 =?utf-8?B?ejVuVU0wZlgxSmg3RXdHaGFXV0xnYUN2UDV0by9tVU15WHVid0hHU05id0Ju?=
 =?utf-8?B?cU9JYitQRnBoRTgweW1PeWNya3VjanlZR0ttTnFKajBWMGhJZ1JsYVpscnVk?=
 =?utf-8?B?NkNReVdMSnAwejZNUHg1R2ZGL0RveG1lYkVWcnZtUGJXM1lVczhsdEpIYkVa?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GmD+OtbyvShccCFuYypDmVm5W9n6mPAKGLXERA1WI5+lZ7gSUy/uuUleu6o7DTGK5a75tqMv/8CRxcefBjgIhI81XXDhQT5/QPr1GpZAkbvzlVmI+iNkSZw/laphRgCJujP+Gshgenpv0eMwxWdTgHTJP+fKe9Af8asGRwLNsjPwYfPUWVhB4GcLCinCLrk8PV7mOBfEXBGTMBtWV1wegEKYwvhHn5c4IhKthIK6E7a3jpSq/jlpYi405YXQ2or1lcsvMScAGNnM4tzX03gTIwrVzWDaZuLHMD3Kk/7VHHrYMBiYwYCo9QgFXEWxpRw5qCw7EWjc+Ce+oEc0w/BbIDielU0yNCxiUnNV5THffv99qe6b+w6IZkScd33YRTuhlJOI3xs9lkETVc+Gua+5cxjr9sjTyorLaHSygoSj9WesuSkKZjba+bNhLa/6+iY76ODD7sn1ZC5EbG51tOLme83akElYzRMWgeChGewj0v6Tc4+rZgmpV5lA+XzDLEiFI17ryfcXat06IBPTpQniNClEuS6j/lfVisD5lQr76UfdrsltHGNdKVtSUeNu74Z5bE6JnxTiegLWnDdQwAqo+2ljcyRguEdqQwDIk9ql8NU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2704cb0-e8c7-4dcd-2254-08dd71eb5859
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:36:17.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrDV5b0VOrTc7/dQPU/QzuHgL0zq8UM575yb+fc7IRL2lHD3s0ggLvMP31HvH1FvOT09/8u+SdPCKkL/9vlBjXX0e4Y5D39F2GnE3MMG9ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEACE3F2B7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020086
X-Proofpoint-GUID: -I8a71vt8tICrYkVa5B19M6SJKnFBLsl
X-Proofpoint-ORIG-GUID: -I8a71vt8tICrYkVa5B19M6SJKnFBLsl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> Also rename vfio_devices_all_device_dirty_tracking_started() while at
> it and use the prefix 'vfio_container_devices_' for routines simply
> looping over the container's device list.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Much better name indeed:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>


> ---
>  include/hw/vfio/vfio-container-base.h | 3 ++-
>  hw/vfio/common.c                      | 2 +-
>  hw/vfio/container-base.c              | 6 +++---
>  hw/vfio/container.c                   | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 04c87fe48bed75aa281a13f75a36e345036a9163..d00db365991aabf7fdee0c9306197920d9524ed8 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -89,7 +89,8 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                         MemoryRegionSection *section);
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp);
> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
> +bool vfio_container_dirty_tracking_is_started(
> +    const VFIOContainerBase *bcontainer);
>  bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 85dedcbe5933c55c6fc25015d3701aba43b381a4..fae8756ade1f85c29a8567adef87135ee111baba 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -56,7 +56,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
> +    if (!vfio_container_dirty_tracking_is_started(bcontainer)) {
>          return false;
>      }
>  
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7f11aad339e713ea09123f361425370d87762950..7121f68464b144bc397a3bccc36743b65232273c 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -141,7 +141,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>      return ret;
>  }
>  
> -static bool vfio_devices_all_device_dirty_tracking_started(
> +static bool vfio_container_devices_dirty_tracking_is_started(
>      const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
> @@ -155,10 +155,10 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>      return true;
>  }
>  
> -bool vfio_devices_all_dirty_tracking_started(
> +bool vfio_container_dirty_tracking_is_started(
>      const VFIOContainerBase *bcontainer)
>  {
> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +    return vfio_container_devices_dirty_tracking_is_started(bcontainer) ||
>             bcontainer->dirty_pages_started;
>  }
>  
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7436388a73a424b11e6bad9ce80b86c3792242dd..e827ae9167b780ec9776ab98974245defb57590d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -137,7 +137,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
> +    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
>              return vfio_dma_unmap_bitmap(container, iova, size, iotlb);


