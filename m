Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F6C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmLN-0006v4-DX; Thu, 27 Mar 2025 08:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txmL6-0006se-LR
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:28:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txmL3-0006XT-Le
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:28:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8MuOj003432;
 Thu, 27 Mar 2025 12:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9J88y93zm7CbZvdWMv29+gRxkThq9x8j1JX9FqqgfL0=; b=
 U7TDTYumHSnVQcxut5mQ0LagumPXf58AD/plXKI+nhgAG7EvPmIKNePafvNbYlao
 eBEyUgg/2yl8ALmdiIAMqrj/QGxcBr8EW8odfcXJuGshodtgqamYgTRmD6BhEfMg
 ju1rFQT3jsNPP2yo1nXm56ielwM0fhVbcLbZ1DH8NCBlQdDiZD44rhWXejUY26I4
 liHg6c+9dH+rU6T8AAPE1M0TggwBaGsMmE0R3xSiZch5xXEuc5T4xbM6OczR+tAd
 SiEQMWvW03hFaDW/Sm3mT4Mo5HePUh9CTlAc4Dg+wrA5ookIk1Z4C96kvPpcfaqS
 XMGKJxa8Zm+MxzcOdgBGhQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45mqft9w94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 12:27:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52RAc6dg015212; Thu, 27 Mar 2025 12:27:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45jj94sy18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 12:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEqG68YwQicZaPG9QPnn6VyoBqjJCx1EJQzEXlVaowScoRzFcFz8QXHQsHRLI95hWCVIKTOTsR7hEfCw3dSA5h4l9jpXXSBsq042obuxHX6oOVYtrP7hTORpIQJ3CTzWLUpHF7bJQMJSjWd71MSZhSGaPtvqg41xSmcP4rWHryR7tp6hEyLkpkLGMc3bTfUatL9jcQtXJjcOaLQSXlaKdcgd25eS+ZSgDkSEtag/ttp+aN50Uqwqxtz8796kkAvLdb1Ry9+itSCVjL1pfVb8dBLtdWCwv3GFo3uakvIigdyYv3fXYGU2R4vnHAqNRNonwfMUeLCXfMI7EnLYuYJgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J88y93zm7CbZvdWMv29+gRxkThq9x8j1JX9FqqgfL0=;
 b=FFQGRShEc/6WYakGfVqBQAJdrB0J0XxTcFqqggabgznH2OsLbXZyP4dcP9RQ0dvHkyEfpvDGkh6vAZVytjnXOHYyfCTDX0GPHs5NZt3TElqUUaVy6n2B1Q6DFtpUUk9QCXCS5lqZY1I5fNEh5TSd0XuroQq/rHrEzSijfszeAVtvsFKbHpafUdoR5sOP3WsIC5p1ZDmaAHQZp6arMk/CTco8etNYJqIJmhhYO/LNkglt1YYYQ2v/fhbe4g+0Ax/TV3ZZScFUTfx3LDmtXCmZrZl0ugziJhNGMBZ5YfTL+XVpKbTzg2+PhhEeQ6M/cEfKDAYhcaybkBzOd+BkaephSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J88y93zm7CbZvdWMv29+gRxkThq9x8j1JX9FqqgfL0=;
 b=UnyR7iEZKoZBlFaFjgMGfap5ICFHlW9/Xr0gyq80l96ngSWXW61f7mdm+HyV/k9/uuIOC4iT41Js8Eq/EQ0x5l+0YwR6Zffyrfk5bATenWKCiyIBl6i/elt+XPiKDMQML94eugdiPPonlKdVgyC2HWKbB2itgXM8HqxUAw7VSBE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB5194.namprd10.prod.outlook.com (2603:10b6:610:d9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Thu, 27 Mar
 2025 12:27:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:27:53 +0000
Message-ID: <307f12e8-7de0-42b2-97ab-997c2dc3f39c@oracle.com>
Date: Thu, 27 Mar 2025 08:27:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
To: Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
 <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
 <174301860426.2151434.16431559419990134889@amd.com> <87msd7a6td.fsf@suse.de>
 <20250326213443.jl3r77hqh6gy2h4w@amd.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250326213443.jl3r77hqh6gy2h4w@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bab904b-b0b5-482b-e953-08dd6d2acc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUtpK0c4Q1d1NUt2OU1vZmhDR25XbndpTXMzTk5uUytCeXQwODdpYlpHRTVQ?=
 =?utf-8?B?MEFMN1Y4aG1oQTduY1NodEtlMy9TYUxoMHRZUk1UNFpudGhFeGh5Y0tITWZ4?=
 =?utf-8?B?SmpKNzlIMHQ3eU1qVnlqTkRIMTZWZWJZMkZERnhxUEw1dEw2ZkhYdmpBN0dV?=
 =?utf-8?B?eTFkb0crTm83NXIvdlQ1bnNJdXVmSVBzTG5Sdi9JVzZlREV1OEQ0MzFrWDY3?=
 =?utf-8?B?Qk5mcVBWaE9FalVCa1ZidExoWThDUzh0NC9tWm5uN2RuUDlnelRtSE51UHlG?=
 =?utf-8?B?WUM5b29pMWtkdVJiRVFLbDRyWUYyaVk4ZElXYmVRWFVUSWYxZ2gwZll0NFpn?=
 =?utf-8?B?Nmc5TlFUZFFzK1pFK1dkMkxHSThmeG1TTmRjcDQvVFdtaTFMTTcyZ0JzS2ZE?=
 =?utf-8?B?RzlOYW40VXZYWlhVdjllRW5GQW9jLzI3M1YydDJuNGxXWjZ5a2xFT1Z5WjdL?=
 =?utf-8?B?UEkwRGN1NHpVVVkweTUrWkhweFJQWlMrWElKMmhEUXlMY0ZTUXhyYkp1QXZH?=
 =?utf-8?B?cDdlK0JhY1JVdnR4M1B6MzllTThuU0RrWm5xdC9DV05hUlVFWVVGMjFCNnYv?=
 =?utf-8?B?T2lsdWJ3ZDEzUGlrbnhuNC9mUm5DUVcwcGZCZ0ZYNjFBb3UweW5oODVwV1B0?=
 =?utf-8?B?SjB2a2NFazJmOEE0NS9kWEhJSlYzelBheHZTYVBybWpIM1htN1hMcmZsOENz?=
 =?utf-8?B?ZkpZNFpWbHcyVjg4T292Umd2d0k1bHpLVHNhbUxkMTBMY1pmS1JFRGtDNS9t?=
 =?utf-8?B?K055UGdDMXJZR05NRlhYSzI1bk9hMFFiNWw1aTU4cFEwSjBkMS84ekJZbDdw?=
 =?utf-8?B?QnVIM2pwanAzZTk2aGxkTktTY2RncjFXazl4ZjByVm9FMDFkQnpodHhCNng5?=
 =?utf-8?B?a1hUcERRdDNkS0krUkwwWnQzSmhVTmxtdUdPRnFteVlYcUh3aHVwdWY2SHdp?=
 =?utf-8?B?Znc2RWQ2bEVNd0E3cUw5U2dvNSs5bm44eVExZFcvR3lBTDU4SWRzVS96TFh6?=
 =?utf-8?B?UzRZdVdjRkRid0VMZE40UnBGS2dPL2ttYi9UcGFFSDBMZ0wzVUg2ZTVwTklV?=
 =?utf-8?B?c0xYdDErMGVtNlREUTUvV2owWFgzSVo5UkZGUkVPYTVEazJYSkdhU2xzN2tB?=
 =?utf-8?B?MHFZRkNiNFJMVGdIWWpySDRGdkl1bnJ0bktwWkVwV1o3dHkvKzZqcEl5K1li?=
 =?utf-8?B?Z1E0bmVHY2dnQmJUS2d6RDQrOXlhOUV6MmRhNVNZRmJSTlJYT29qN1AxWm1K?=
 =?utf-8?B?YUxKaWhxOFZnRGptZENnOUhzN212dGg3Z2lRNHFRSmtJMlVZcFhrdDRlb2JL?=
 =?utf-8?B?d1A4ckZndWFqdmVoZUU1RVB4N2ZOc0ZZWitMeEZlM2FSWGRMcjc2Uy9HUWZt?=
 =?utf-8?B?N0lZcVR4Rk03WlE1a0xRczIxZDI0L1JVYSthL2dJaU1vQkVzZDRaQXJXYlhD?=
 =?utf-8?B?ZFZhUWZrU2pQeW55K2RCRzNoT3FHeVVsVmtlUHRoRUlieUtnN092QWFpZnBM?=
 =?utf-8?B?Z2xRNmhxc29SVFZRSXpzUnBNdzZRMmN0ZmxaTitlNjhkQkk5RHB6bnNiMnNn?=
 =?utf-8?B?TWRMbXUvOHFXRWRvdjY5UHpWWFd1UWI2bHFKRldMVzUwTUx3UVd6elhxZUlQ?=
 =?utf-8?B?M2RrVDNnaVJ2VHFCeENHWmF2TmV6QksrQTkxZXl1TldwSHl6eVBSNlNLSjdU?=
 =?utf-8?B?NXFuQzFGaHNlZWJFNVAwcFZ1dG5FMzU0eTh0ODJHRGthRkZjRmx6V29NUlg1?=
 =?utf-8?B?YVZwdEVFTzREaEhqQTcwbXZ6TndQTFdpYXdqV3NjRm4rdEJqeDBaSGVwdjJ2?=
 =?utf-8?B?aEVVUGJidmxsNVNSekxzSG1PQWU5ZDFKOE8zeUpEM2l4UUY2VFJiQngyMkJa?=
 =?utf-8?Q?8mF6AZ9ciyStL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFwY0J5OTVTaU5PUXZYdnFGVlRQMDRBQkpTU0RMWU8yclJjTTh5OS9hWUdG?=
 =?utf-8?B?ckp0eFZaWFlHeXZSTTc0VVVwNC95MEFSMGx6aFlNcVFyYjJtQS90NkxFbTRE?=
 =?utf-8?B?eHhkck1TaUROY2g1cnZ4d1I5Y08rZ2JobitsYk5Rd0p5d0JrTFVxNTBPTGts?=
 =?utf-8?B?Ly85KzNENWdwMWRDdXhuVWVSdUwySGZDeDZ1aCttNVM3M29kLzU1UnJhaHpr?=
 =?utf-8?B?U20veUp0cHIyZVp6Y1p3WUNja0ZGTDBvQTlJMTE1M0VsaU43R2J3a1N3TjZ5?=
 =?utf-8?B?aEJVNzYraWlia3ZqcC9McnBUK1NKYXV6ekRuTDdmbDZIak9uYk1QcGtJQ243?=
 =?utf-8?B?QUV6dnNDOXFraHBYek0rRmF5QlVCYnk0V0JtWXRFZ3pEM1NQekN0QVFuaHVt?=
 =?utf-8?B?Qzk2eE1jT0hIRnFTL3lmVDVQQWJYRVNpL2pVMjh0UkQ2eW9OdkdlU1UrWW95?=
 =?utf-8?B?c2dHL3pJbWtJYTl6T2xvR3U3OUhnRDdJVzlCWnNvSXlSZVRLeFZnVVZ2aENH?=
 =?utf-8?B?MTNEaVVIbTU0MXJSZjNSTGV6U0MyVFNzTHhMSTZXbjFjSWsxTnYyTUdyemha?=
 =?utf-8?B?RUNidU45c1ZxYWlsdFFIM1pyODBETHJsT1lPZlJlRjd3SjZmWTJiNVlYT3Ju?=
 =?utf-8?B?T1JHVGs2NXNQckdOYXJiZ09hOCtvN1NMVEl4R2trdkRFM0JBalFFTzcrazZm?=
 =?utf-8?B?S04xNjliNTFvcnZNb0hNeVozRUg2TUZCZElFbU5RODFnaEhiUTV5WkNhbmh6?=
 =?utf-8?B?a3hMU1l6aGVlUlBWQkpSZW1mVzAvZVJITEZaSzMveDg5ZXhWSWg2RTU1U0dG?=
 =?utf-8?B?ZHZuandZZTJ0VFdzSjBSTTdMd0ZTTXJvWlNPNFhERzZONGl5K09CMUo3N1FH?=
 =?utf-8?B?V01BRldWbDgxa2IvcXAvRExGRGcxN2lHRGdQU3RPaTg0dkJUSUxnVWwvVkV3?=
 =?utf-8?B?d2FLQXlybTlsaXorS3hBQ2JsOHpMSzNCRFl4MUw3Uk5pczc0TE9jSFVEcUl0?=
 =?utf-8?B?SlgzeVI5dEJ1eHBOVk5FR3Q3MkZ3QkhmZlRZZHM4azN5QTVCcXlGVGozalJy?=
 =?utf-8?B?UWxBNFI5TzVPM2RETnpLbk1XY1k2bGV1QVFNMlVZOTNmVWVrSzNsM3VWTkdX?=
 =?utf-8?B?MGQyUzVRNUZBS2J0Y2diNWFVNnhLdDJURFQxT0FMQUFwVWNacWdhc0ZRbmI2?=
 =?utf-8?B?SXVmWHhCNlBGaDFDZEZIdVFkODBQWGhGd1IvcUd4dHdKelQ4bU1BQUE5UU5F?=
 =?utf-8?B?ZUxPUmMydzZKZ0Yyd05OdFh2akpzUWMraFZWOWY1OUVGN0xwOFU1YkhVRUlF?=
 =?utf-8?B?YlZmakJXVFV4TC82ZjRCRk5ZdkFjSHhpc1JBLzJEeVVlK2NxQjQ5bjRvcUZl?=
 =?utf-8?B?TW9nai9lazA5ZXlCU25SR3ZqZDZCZHh0OUd4bllGd29JaVVjTXZRQWZjZzFr?=
 =?utf-8?B?NEJiSC9TZWRabngrRm4zK0NWSitLczZHMXl3OW01SDBCeGx0VW9vdi9vUGFN?=
 =?utf-8?B?bE56NnZ1NnpzOW5qbjhTaHFYbnUxWGd1SzUvWmI1d1U3VzFqck1DSEI0dDBv?=
 =?utf-8?B?b3c1S0VVcHJ4T1FHb096V0xEUmp2MjJTWnhtRUY3V1c4V2syWGUyMjhxcFhz?=
 =?utf-8?B?VFRwUVhQall3VzAyd0VBNFVtY3ZPaVpZb2gyV0cveWY2c25wRWMzYURSYUl4?=
 =?utf-8?B?NGxSalpDQWlwTWtkMFVXK1MyMllRWktjZ2hhTU1PU284TFNla0UzaHM5Vkpt?=
 =?utf-8?B?bzlpK2hLZnAyeXVEdDQrSzBiN0kzVHpiN2wyZTJUZUZxQTM5eWxkUFZ1d1lq?=
 =?utf-8?B?ZTZTbk85V0xFK0QvTGZoYVZDMEFDbnM3aFVXbHlKVnlyeXNTek96ZUpIQ21v?=
 =?utf-8?B?RmhTa0NkWWNBOWJtQU1mRmc1Z1YzU21aTkt6Ujc0TWpUbmVIWjRUbjJhcEd2?=
 =?utf-8?B?RHpyM1p0VTgyV29MNHVvd3ZTUm81QTI0S3h2V3J2MXZyV25XeEE2WWtBQ3Q5?=
 =?utf-8?B?ZGpSMC9CSGhvb2NCUWJZSjFON3NBQUFINi9STG9CamlySVZwV3ZrTWc2R3dQ?=
 =?utf-8?B?ZDMwOCtDclNhVDBvazRxejhDaVJtWGhRVGJJTmE2a2NLYzVNMGMxblQxVThi?=
 =?utf-8?B?R0swSCtzQk52MUtkaGxLL2g3WFRGWDRvbExORzh6VGNZbkxUM3loRDg5S1NI?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xa4Xvk1Yawhd1/OUQTow4fpPid8JpjI3BnklF9Lc5ACdF05Yj5IABnPu+RvRMTTivJ06pESbZGlMm5NEBraqPxNs6NSJwHW8o/sTibxfAOOeIbGSvt30roQHgA6CBo/HPILGrQgvXEtLqBo6khcorh3eEKuRnPaeMQkHPjvv5cOsVebK/bBewfm1bimkzMlL8zhIlEVlVDFlDRRddL5/AKY0tFWNrLDTovuA0EMRixcQ+vDviisewwvksFjo4qfFatsGjcHekwZXSEjeY2hokTc99eWYF0XBvFJjqygLMkXRAOSs6QGCmqK3l6rGzLQ5wWWDv2Va5a38lj3oBarchYTqvhcfKlyltHv6T0LphTjPV4PCjQY3jZfe86Tkuhforpj+BwlqvYbv/6zVB9r5I5CgSnOA3g29IyOgzMkcGYrfqSvPEU18BIUDHlwe+oHJQwEC/zFEj6ZoZcSJVfe9lBrSDIcZX6qSn+xk2wBitOiBxQwBy50KU45jGciy/xWdIxUUxcLROoUjZ4/bj26juXpree6ND7iZp5uTLg6fS4kERipWX0DekG+9EIe/4fPUBv4XNHQL8EMmkAj7wYdYiA0589732BZ7l2WJOHYwdy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bab904b-b0b5-482b-e953-08dd6d2acc0c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:27:53.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfrBXT/OdhWFa/0Ziqnqgh0wCL0W08b7brTCrFjHGwcL8lAX2Issrn/49zpqUHTY+Uq6sD1cF7daiftTk5vjlRVRxDtqkd02oMCUIJFq+LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270085
X-Proofpoint-GUID: -xdMDh0nRZZ0aC-pGSrC1O5akAaVaG_U
X-Proofpoint-ORIG-GUID: -xdMDh0nRZZ0aC-pGSrC1O5akAaVaG_U
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/26/2025 5:34 PM, Michael Roth wrote:
> On Wed, Mar 26, 2025 at 05:13:50PM -0300, Fabiano Rosas wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>>
>>> Quoting Tom Lendacky (2025-03-26 14:21:31)
>>>> On 3/26/25 13:46, Tom Lendacky wrote:
>>>>> On 3/7/25 12:15, Fabiano Rosas wrote:
>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>
>>>>>> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
>>>>>> in the migration stream file and recreate them later, because the physical
>>>>>> memory for the blocks is pinned and registered for vfio.  Add a blocker
>>>>>> for volatile ram blocks.
>>>>>>
>>>>>> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
>>>>>> sufficient for CPR, but it has not been tested yet.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>> Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
>>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>>> ---
>>>>>>   include/exec/memory.h   |  3 ++
>>>>>>   include/exec/ramblock.h |  1 +
>>>>>>   migration/savevm.c      |  2 ++
>>>>>>   system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
>>>>>>   4 files changed, 72 insertions(+)
>>>>>
>>>>> This patch breaks booting an SNP guest as it triggers the following
>>>>> assert:
>>>>>
>>>>> qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
>>>>>
>>
>> Usually this means the error has already been set previously, which is
>> not allowed.
>>
>>>>> I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
>>>>> It looks like the error message is unable to be printed because
>>>>> rb->cpr_blocker is NULL.
>>>>>
>>>>> Adding aux-ram-share=on to the -machine object gets me past the error and
>>>>> therefore the assertion, but isn't that an incompatible change to how an
>>>>> SNP guest has to be started?
>>>>
>>>> If I update the err_setg() call to use the errp parameter that is passed
>>>> into ram_block_add_cpr_blocker(), I get the following message and then
>>>> the guest launch terminates:
>>>>
>>
>> The usage at ram_block_add_cpr_blocker() is correct, the cpr_blocker
>> gets initialized and registered as a migration blocker. The errp only
>> becomes relevant later when migration starts and the error condition is
>> met.
>>
>>>> qemu-system-x86_64: Memory region pc.bios is not compatible with CPR.
>>>> share=on is required for memory-backend objects, and aux-ram-share=on is
>>>> required.
>>
>> Since errp is an &error_fatal, it causes QEMU to exit, so this^ error
>> message is bogus.
>>
>>>>
>>>> The qemu parameters I used prior to this patch that allowed an SNP guest
>>>> to launch were:
>>>>
>>>> -machine type=q35,confidential-guest-support=sev0,memory-backend=ram1
>>>> -object memory-backend-memfd,id=ram1,size=16G,share=true,prealloc=false
>>>>
>>>> With these parameters after this patch, the launch fails.
>>>
>>> I think it might be failing because the caller of
>>> ram_block_add_cpr_blocker() is passing in &error_abort, but if the
>>> error_setg() is call on a properly initialized cpr_blocker value then
>>> SNP is still able to boot for me.
>>> I'm not sure where the best spot is
>>> to initialize cpr_blocker, it probably needs to be done before either
>>> ram_block_add_cpr_blocker() or ram_block_del_cpr_blocker() are callable,
>>> but the following avoids the reported crash at least:
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 44dd129662..bff0fdcaac 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -4176,6 +4176,7 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
>>>           return;
>>>       }
>>>
>>> +    rb->cpr_blocker = NULL;
>>
>> Could it be the cpr_blocker already got set at ram_block_add() in the
>> RAM_GUEST_MEMFD path?
> 
> That seems to be the case: in some cases ram_block_add() sets cpr_blocker
> when (new_block->flags & RAM_GUEST_MEMFD) is true, and then soon after
> when ram_block_add_cpr_blocker() is called on the same RAMBlock:
> 
>    2025-03-26T21:08:15.092427Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c247e4c880 new_block->cpr_blocker (nil) name ram1
>    
>    2025-03-26T21:08:15.124710Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c2480fde00 new_block->cpr_blocker (nil) name pc.bios
>    2025-03-26T21:08:15.126190Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c2480fde00 rb->cpr_blocker 0x55c2480fe050 name pc.bios
>    2025-03-26T21:08:15.138582Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c247e3c1e0 new_block->cpr_blocker (nil) name pc.rom
>    2025-03-26T21:08:15.138938Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c247e3c1e0 rb->cpr_blocker 0x55c247e3c890 name pc.rom
>    
>    2025-03-26T21:08:16.185577Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c248db9200 rb->cpr_blocker (nil) name /rom@etc/acpi/tables
>    2025-03-26T21:08:16.187140Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c248085620 rb->cpr_blocker (nil) name /rom@etc/table-loader
>    2025-03-26T21:08:16.188029Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c2480ce220 rb->cpr_blocker (nil) name /rom@etc/acpi/rsd

Thanks everyone for debugging this.  To summarize, ram_block_add_cpr_blocker already blocks
guest_memfd, because rb->fd < 0.  The fix is to delete this redundant code in ram_block_add:

         error_setg(&new_block->cpr_blocker,
                    "Memory region %s uses guest_memfd, "
                    "which is not supported with CPR.",
                    memory_region_name(new_block->mr));
         migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
                                   MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
                                   -1);

I will submit a fix (unless Tom or Michael would prefer to author it).

- Steve

