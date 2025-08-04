Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4787C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixYn-0005NQ-9y; Mon, 04 Aug 2025 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiw6y-0005gw-1p; Mon, 04 Aug 2025 10:24:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiw6f-0000OB-Mq; Mon, 04 Aug 2025 10:24:19 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6m6j021877;
 Mon, 4 Aug 2025 14:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RXEvZ5LmmfQ+eD0D+ElyswX46YmPSnKdjl3JRzyT/5M=; b=
 LclgiH0JVheyUgEhlO9c5KCRnVUhuKRTVcheV25EWe4FGgI9SbE7SIY/y7FlXmpk
 pX9qBpy+UPqfx3lx/UaLGwkAfvM6jRc6EPndDDPwqTcH78+2effjxNvL/AAZ0Qkg
 Kg3fXxT+/PbNgN/WTJHWceifw6B00DlLoUMX0emkp/Hp4D9KqvXGymERKXE9byX+
 2zoG7/42ZXcfYBAHp/3acvKrNm1c7+Qx9fJSYT3WiHam8y04PIb/11duz1rwknG3
 itb70y6rmD2V9uUcnjjx8YCestVeU7UsCHiswDkxHto4SHKs/9lJHo60PjGbdBtP
 oozts440728kNOMH+qJTtA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899kfat1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 14:23:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574EMeRK032075; Mon, 4 Aug 2025 14:23:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jupa9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 14:23:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIU1AlZE6qJlUAlcVwYgWEu4bjPV+pIu79OxZtAYfrxrCS/TPtJXQb+CaBuEN5A8oImOb+ksD1dEr4TT+H9Qe7b5pxNTix292/RmNhKza6WHFNzUzAznb7yVX4la7h+7sIASvamgT2AvJsV3dIhKrE8OClGxe7dwEjjoINlDVITLMvNkwd2n1JT4gA9tg8MidN4fbqemxOWhhZOSGmdlzIvGnY/u/NEAfa0XH1b0n5GsDRJw8l2RooQsWqIXmjivDm93EAmKuwOEuaO4Cf5Hdxa+Zw3f28MOCv1MSmOLTiC9shBacPa5EgLwKykmcWHuSOjPLZpJ6zCSVtaZ5uIjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXEvZ5LmmfQ+eD0D+ElyswX46YmPSnKdjl3JRzyT/5M=;
 b=sGQk21cbFpyfHoHeQGKLUFQfuj5sJHY+aKUe/NcuqzEUxnyww9PUc1FO2rUY4dKo6L01kb14oNFeblYbp0EO5efCVed61nWWVaWFUaw2sjE4gbQOV6QOLlWpMCkWqtnPVSxJJJJd3FaIqOgX4nE5vpryQik2PvziQVB6QD511wB7uAF8jBtiKx7lUy/GIzIbI4PyXuAr7neWRz0+rB9zZIcadZiwT+/7lmcCZqpffbwr4quTwYH6oZgNTYprnZ/V8yy9L72QmhO/0XoRxIY/+OvEgplnnYAa9QPmxt2JC6FRnNvdugl7zrwdZBCyW5AWHhL4ZMoo+7kkfv7J4hbV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXEvZ5LmmfQ+eD0D+ElyswX46YmPSnKdjl3JRzyT/5M=;
 b=ohiW82no6+/ak+diXTdwKDW9r2DAMXxusFruDLdyBbSvmJ6RAQDRl6gh1EfJgdZhhjyh+MXFXjG7WzGn2OAksgCESH/J3KPWIYTWNpZggtJXyCikO8KoFPiHQx6lP6u902zyc4Y/dTUryE5cmyzAd47l1Tp3jRnRWZsx/zP6ozA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 14:23:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 14:23:41 +0000
Message-ID: <63d52f3e-5d29-45be-986c-3827a5c0cb5c@oracle.com>
Date: Mon, 4 Aug 2025 10:23:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>
References: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:510:f::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: b90c9be0-607d-4567-19a9-08ddd362830a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGpXZDhsdHhQbkdQTVFsNlNhdXhoaGRvTGVmaW9HVCtCc3dzVU9mbGpBbyt0?=
 =?utf-8?B?RXFTb1NjM3VMeEJaVmVzRG9ydFJTOGdicktvRDNnbllJVSt4S0Fqc1JxQU5i?=
 =?utf-8?B?ZkFWRXRvbThWdkZzWjlYK1MvcXpLRVVXYktON015Q08vUFEwaFVWRno3YThs?=
 =?utf-8?B?MTVJMDhIQ0t4Ykd3V3dWaU1VQU91NnQ4c0MybWdPUGRRbG9ZNjRjR2RCSG4r?=
 =?utf-8?B?UWZKMmlJKzZlQzdWOVhBMzZnZkRLeHpja0dDNjdDVmRFQ0IxZjNGRXBVRUFN?=
 =?utf-8?B?THdrQmxBMkQrdHFMV0lEbEZBNm1hL1J4UEZlaTArYzViS0ErR0xZMHF2MzJ0?=
 =?utf-8?B?MFpoSEJXQ0J3RmExWjZiKzdPYXB4K1BwanFqOTk4dGVxbFcxSWZaVk10emtS?=
 =?utf-8?B?VE5jRG1za3FJZ0YvVjBMVmRxNndITXB4U3kvdEtMcm1kcGpJUUROY2R6U1Rz?=
 =?utf-8?B?QlBCeXNTbmFUME1OdjVlamFHRm42eUlmWW9Yb3QrajNRMndKWExoWkEwdHBs?=
 =?utf-8?B?SGQ3bHdacTNJMHdWd05VN1pzNkd6bitjZFhEbXFwUVJ0cDVaOWQ1N0NSZDk3?=
 =?utf-8?B?T0JTdnZlZ1FzeXRTZGFibVVxcGpyQVlPZExRR3RDeVp6aVVqK3VKME5XbUl5?=
 =?utf-8?B?bEtUOXNuUERaZTdjTzY1Mks5L1hjaThPUGVVKzNVVk9OQWZqVXpJSzdnUG5l?=
 =?utf-8?B?MDYybkY1U29oRFp6SFF2YjEybGtHM0Z2R2FnWEpkRHdYOWdEbHhaREdxQlJU?=
 =?utf-8?B?UTJablMvV3NJTmNRUVhMblFsNW1JdmdVVkNrdTVCNlpHb1A1cFpyY1AyeFdL?=
 =?utf-8?B?K2FaSWtnRmhOZU9yanMwczRld09yaDBTalF2ZHo5YjVoYW1pTGRSODFWQU1M?=
 =?utf-8?B?YmRvL0NWRCtVMG5uSStUU3J2SEhYbGdOV3VmY0tic0lwZytkWTRNSG4zbDF6?=
 =?utf-8?B?S3JPSmZleTBobGlzU2xERjdhRzl0R1hmN3Awbkd5ZUR4eWdjSlovL0JyYnN4?=
 =?utf-8?B?a1hHVzh0aHRWcW5EblpxbEFIUWJrb0xZNnh3K0IwN01TWm9zQlU4czZNMDNs?=
 =?utf-8?B?ZkVudVJQREczTEllV3BlUStKWGgvRlhmWTV5Q0xvb1ZYWnN6TkR1UGgvNDIz?=
 =?utf-8?B?UzRqd3FXYTVEbHY2dk10TUNBREh4WUtUWjRzcmw4aHZDaHVWaVg3RWs1YVg4?=
 =?utf-8?B?QXNiWjB0M2xFa2FFVHAwZnpHMnVZMUdnVjc3MDJLQ1VoRlViY2RMS3czRkFy?=
 =?utf-8?B?OWFHV0pFMk03Q1hOeGtuWUpwNFZLQUhyZzVzb3dRYlhpOVBMK05FcXh3MkI5?=
 =?utf-8?B?MTU4bllMSmdwYWxQUDNGWmFtSGFqb08wdlFDc01rNnlLTHowVEtBWlZhTDNV?=
 =?utf-8?B?dzAxTkhjWHFRazlIUnFPVmJmbENRL0dWZllZcS81M2VlbXgyUnBteFFSQUhl?=
 =?utf-8?B?QnkyaGx4U0FXTDJUakVwazE0ZUNrSHliRytIZUc5QjUyeUwxMHRlSXFYbmZ3?=
 =?utf-8?B?b09tOHM3Y25GT3Y0N3EvcTJoM2VHSkwwdnRsUkxua0Y5ZEh1TE8wRVN2TWVh?=
 =?utf-8?B?MERVczJ5RnNMWVJ4eU1KRVpHczVLWUd3UWFRSCt0Y1JkZmJ5bWNwSFNwNmp5?=
 =?utf-8?B?a2JtS3hPSUJ6TXVEbFRuRi9NQXdxUlBnSDNhbHhXUm1EdGM4ZU1meTFOc21P?=
 =?utf-8?B?VDhZSWRYZzFqTmF3d2thRkpiS084M2w3czZUR3ZjYmV6WVVzWXJjQTFUQWZ5?=
 =?utf-8?B?WFFPM3pxZHBEWHYrZjdPM3BqT0NoNUVzYjNaOG92b3JIN3hMa3V2ckk5cytG?=
 =?utf-8?B?MWVqMWsvdFcvUVdRdjJDSE1hSkl3YUZyR1ZuTHFGMDZTTDE0U2JHVDMwSVdQ?=
 =?utf-8?B?M1ZmU3lnSCtYL1ZUZ05CQ3FoQ21JRTVoQWgrQURDNHFXKzBUaUlib2lTTkpE?=
 =?utf-8?Q?ZVpt6bAtS20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUN4NEtVQWZpSC9hbVpxbjR6T1F6bm8zKy9vR3ozQzM2b1ZqSm5pdE1rZi9s?=
 =?utf-8?B?aUNLc1ZuRGZGWS9KaDdOd1p6dFIrZ1JDSjFLbUNGNFVuMDRDZ1BleWZ0U1ZG?=
 =?utf-8?B?eDltWGxIazIyenNhWFY2cEpUY2pBRkltUGJmYkpla2h0ZWVZcG5jd2RnTTgr?=
 =?utf-8?B?aCtPRlVrKzNzM0JHMmdEMXBZZG9ZMzZzUHBNaEo4d0h5M0MraTFRZC8vUU5l?=
 =?utf-8?B?MUhoQzhGcEdEL0xhbmtyb09NTUxBSHZOY2xUQ3BHMDlweWZDYjF4bUU2bVpU?=
 =?utf-8?B?dmlLMzlLZHF4Q3drUlI2bFJGWktyWlkrbGRRSkNwSHphei9JVzRjSGZRN0xQ?=
 =?utf-8?B?NGVYVmNLbldZdWh5SklWTDJOalpuWlVFRldqM09waDJVc2NLTmw0enBJMjJQ?=
 =?utf-8?B?QmZnY2NlZEhKRmVJVmJtUng4OWlqZWhnby9mcWJGTmZzVUVoZ1lRMXlIeEti?=
 =?utf-8?B?MFpZY0tFenQ5Y0JmWFJlY0hQNzBtZzdJaXNreXNDc1ZnRHNrNDE4WnFRS29E?=
 =?utf-8?B?OUp5SFVialkyZnV2OTFsWGk2NTFzZElNUzhjdWNlajhxTzRUSlRPR1VmSUw2?=
 =?utf-8?B?d1ZxUUtSQUVCSGpWOEs3M0l6Uk45bG8yTStNaHJFM3IvL0owZ0E1Mmx5aFlt?=
 =?utf-8?B?OUVYY0NvUjVtRUhuc0dOZjlXRVdLeHJaZ3RSNlNHUENwWk4wb0k0NXhGRVJl?=
 =?utf-8?B?MWZkcmNrRlptb2JCdEpjLzVZNlFtSXFVYWlPVnNmZnROd2IzbEF0Y2ZZWVlJ?=
 =?utf-8?B?bHRJZ2ZLY3BmL2tXTFRFOE5QSWlWUzhhNWRoaHY5bTg3WDJOM2U5UUNBM3Zy?=
 =?utf-8?B?K0tHRjByRWc1dTlXaUsvZnEwcm44d2hUUE41ZDQxdVdPclA0R3E4KzNoZG5s?=
 =?utf-8?B?Y0Q0dlp1bEh2Qi83SGh4cTdVOWJlZkxzQUMxZngyUzJRb1BPaWx1TUd1VVpp?=
 =?utf-8?B?ZGVsRWhoaVdJcjRSbFNkUkIxTFV5c2JqSHBaeTBDQXZzcFA3dXo4MzQ5ZEZC?=
 =?utf-8?B?aC9HRXowUXpWNEpkQkJ2Ymt0Rm1HNzFiUU1oeGF0TWhlRnRBUDVkZlUrSDIv?=
 =?utf-8?B?UHZNWndhdmYrL2tHaFdGNkJGSkMxVDVUZWszZnUxTWpNcGtsSWdSWnRMMzhu?=
 =?utf-8?B?T2ZtTlFVTjh3Wk1udFFiNUJadFZHNE8rMUFiRWxuZGYyQitkUGc4d2ZLL1Ew?=
 =?utf-8?B?UFJtV1Eza1dYU0FReE1jcUloc2FhR2JDb3U3dEEvanpQVURSTGIrOXkrRW1R?=
 =?utf-8?B?Z2IyT0NyYVFPdVI0UXRjOFB3blFMYTVyZmE3NFQraHg0R0xHQTR6TE9uV3VF?=
 =?utf-8?B?WjhOY2lVSWJBOXVLVWxOMHZwUkNOSC80cUF6dHp5OEtiQjV6NzFqOGNHM1BE?=
 =?utf-8?B?QmFRb290dTBlUTZqRVRtWG4yNjYxeUVqZkZpQnhIVXFCVDdGMytXc3FHQjdv?=
 =?utf-8?B?aWluN1hST040eUJ2TGg0bFpqcGo0WGw1bFh3aVVOV3pmNGhRemsyNU9HL2tP?=
 =?utf-8?B?MG54dVBzM0JaRWphcERJRFlFSWFNMzAySHMyVisrL2tEU2p3ZnlTNVBqSUlu?=
 =?utf-8?B?WUxaaGlCMDBPMXRHcHZBekdGRzdqTU95c3JzMzdlbitXY0RhWlpHTjNIejhX?=
 =?utf-8?B?eGZUVDgyMXVHdkJTZS9RREI5NDhwNjJwZzZPWXJnV09SM0FPT290U1k5anN6?=
 =?utf-8?B?OVpROTBXdFRmejlmQy9KaXk5MWZRNGU0QW83dlVvRlBPV3UwWGRXYTUwN0x2?=
 =?utf-8?B?aFhWQ3NjdXRBcFNzWmNPSmRzVldQeVFDWCt1QjhGWkFZQW9VVmpEWEhuY1NP?=
 =?utf-8?B?YlFXbTVrZGJ2TENkZ1Mxa3orYUFldVYrdkp1dDVSVUxTMGp0ZGFtcnl4MEE5?=
 =?utf-8?B?ZUhvK0xXK0J5S3NiMGVadHNlWkUvUlRhR1BpTjllZFVQMEJLMWluNW1abzNW?=
 =?utf-8?B?ZklROE40QWREcHRkZmJYZ2FDaDl2U2hjdGovb0dDL2tTSHpBZzA1UXFiRVVa?=
 =?utf-8?B?cTVVWWxYV2RyUDhYbGJvN2tlSmRxN3RZck0zcHlOMUE1b0YwZWZ3c2QzVnRZ?=
 =?utf-8?B?UkRydldqRUMrSnZRODhGT3pKNmUzT0ZnUk9xS2JyVitiMGhnYlcyUTdpU2l3?=
 =?utf-8?B?S3JiZkdSSlRYb3JxVXhqUjFoS2xGMGQ3RmhhQ3lUVUNuR1dHdTNZMnZYdmFH?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yYqkhVK0BI0Kq4EaExnUMWtKmbIPoYRuoYNpp54Dd/0V/x8XVo0qQ7r8GasWZyYJQZK+QeEWp2+az6WNdID44pniDDt0u3od1+s8rL5enbYSGVmwroTvyFdB3eFSe68Hw8saC3rIO2kax1m5XB6JDF/u1GKbXNh1Nk7EVRFm2xbR+72XMNEEukboQqvK9SxkzyYSEuzyBcLUbaitChGSUD219yZTlkN7GIDJra6OrHTlouvpGRasZUfcXys8fdZdRXap3isUO/z67I9KPWnYW5D/hGNhNu9cK5oIyb2gR29sZfbVAcmR3TigZX05M0nFpzordA8AxVma9EoWh9tv6AKoiCX5lpdOIHcJCem32+gSRQm2KMxhIYPqcLDFO4MGIy8gvldFa6eFXBFbmEpYoeYszgn7is8bFG9mb6Ke9FvZE/U5E2zCDB2VnICGmti8JIvXNo0inEl1YvMN79yhlgg6VqbwW9zUCmBFZ/ufWLGXjvLeLf7dvvOAddfj9cmtK2UMLFwovpV8YWLqijf56KqpZGAQgxY6kPBH7c67HXPH5e2hWoePy78MyHvwsTOQnVqsAQkpzXZnH0ABbGtyNjiblQ1r4wc+i9KCu+Rib5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90c9be0-607d-4567-19a9-08ddd362830a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:23:41.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj8Y5mr4tFbKwGDYUR1gYXhPH166UXb5MY6raoaT77eMpXy/dO5tZf2omIBUqn0DvXj8ly9lS4w++Pw+GNtBln88XD4YJboO0+J0w0+E9Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfX1/7KPk4noVmT
 EjOmcTHRdzDO6+EhfOYf/kOGqGtwLy4oC1V9Nd/Vg3BIV+ypbczk77zH4I+QHKV2f4CC12ubicH
 Ozp921X1A3HZ/ZY3PVZspaX/8Y5rFuH8ZHU9IMVauT/pII79teQZ+RBCZwnVHGHhdp5MUV7nKiT
 Qg4Bs2nBw26eCxpyd44LUn3yM3r2uRDnX9ayrYCBzUgP1ToNumsK9WwlMGoWf19da/DcnGHYBeY
 uKwlrtBSm8YvInrDYnLpj6fKTUdp8Ri+BRHXoW+T8lx4Rudz5/qXfZyrUtlbl2V/1XzmFhiPW8i
 wwLAxIUMJeU40wsiJpTRI7Fo9UWI7+4wTWVn5AOkMBgcja7YN2narNrru0xdpiWOK0afAsTIXe7
 B6nKydSZ9Y+pvXw4AhD+cSje5cX/+OT/4XTL0AVvakWpwebNqG/KHtjhIR7lTg5cwW667NJN
X-Proofpoint-GUID: _jo1zREO2QpmrBEv2yKAhlUROOMWf5So
X-Proofpoint-ORIG-GUID: _jo1zREO2QpmrBEv2yKAhlUROOMWf5So
X-Authority-Analysis: v=2.4 cv=VMvdn8PX c=1 sm=1 tr=0 ts=6890c27c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HvWwsLQvtK_Our9jDwUA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fabiano, could you sanity check this patch? Thanks!

Peter, more below:

On 7/21/2025 6:24 AM, Peter Maydell wrote:
> On Wed, 16 Jul 2025 at 19:07, Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Close a race condition that causes cpr-transfer to lose VFIO
>> interrupts on ARM.
>>
>> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
>> to arrive throughout the transition to new QEMU.
>>
>> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
>> future interrupts to the producer eventfd, where they are preserved.
>> Old QEMU then destroys the old KVM instance.  However, interrupts may
>> already be pending in KVM state.  To preserve them, call ioctl
>> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
>> they will be picked up when the new KVM+VCPU instance is created.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
>> +static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
>> +                                  MigrationEvent *e, Error **errp)
>> +{
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
>> +        return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>> +                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
>> +                                 NULL, true, errp);
>> +    }
>> +    return 0;
>> +}
>>
>>   static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>   {
>> @@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>                                  GICD_CTLR)) {
>>           error_setg(&s->migration_blocker, "This operating system kernel does "
>>                                             "not support vGICv3 migration");
>> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>> +        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
>> +                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {
> 
> Why did you change this? It's the general "if no support, can't
> migrate at all" check, which seems unrelated to cpr-transfer.

"If no support", then cpr-transfer should also be blocked.
It should have been added earlier.

- Steve

>>               return;
>>           }
>>       }
>>       if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>>                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
>>           qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>> +        migration_add_notifier_mode(&s->cpr_notifier,
>> +                                    kvm_arm_gicv3_notifier,
>> +                                    MIG_MODE_CPR_TRANSFER);
>>       }
>>   }
> 
> Otherwise the patch looks OK in general shape, but I know
> nothing about cpr-transfer so a review from somebody on the
> migration side would be helpful.
> 
> thanks
> -- PMM


