Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71655C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFjl-0006P7-NC; Tue, 21 Jan 2025 10:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taFjj-0006NH-2u
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:00:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taFjf-0001J2-6L
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:00:14 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LEfvTW027824;
 Tue, 21 Jan 2025 15:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GiENlQWGI1uRkWc6SDB4AmSFkPiSshTrLAlhv/9yvBw=; b=
 f/3ktVQJmn2ywbDIPThr7mHMBOf5Wlrk1ABFbYvQkziyq59PzNPGbP6QccrHlYrf
 7oz3C07nkVP4H6Hk7+bHM4TPzx+4Im2MJ6RZ66dVu7ld5673Hz62TXJJDWUqo2to
 OgU63DEaUaC5egRPNKOOF2lA4QbLgM7vAcNzUVRmv/VCS78cKTJGpSFS0qIuYcPx
 bSBp31ijlutECullSLCklXZ6IOJXMndo6STGxfLB+NU16TUkuSBEJtSpHrutFMwm
 yL5F1hIOaYrnthOOfYFUma2ZF8Akvv4wqT1kwBhPFS9CBwRcQ8wW8ClhraBMYkBX
 UafIO+0Vv+4C+NGlMEAeDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm5p7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:00:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LEk4ju005708; Tue, 21 Jan 2025 15:00:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 449194c161-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDnd3TKSHFN34c3MpqHYTZojepn/AxYxLpJBlbYr9wRQNFFkOfHVLd5+YcHADNlFNSYVYiCyMq1wSjWns+SPccWsQ8vXMoZ/AlskREONQSwF0mKjRx8S0AXQ7U3/T/SZ/Q6vPBAc+eGi9L4YbzDjc4gPIWLZuR46kxMiCbkzEkA/BVSOP9v0hiCf8GawUh4lp/rU/oLYNE6Z/1+dW/yS6pZy0PzBysmNfZwEzF3OYaIXZWfadd5a0XJ4VtF/wIrqKMn4ex82PIzv//LSpo3MrpUalkdnir/wgOrhnJRSVB8Ia9NhuAhY65Cnl1nC58epY1vP8kXAG7k23ydFynhYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiENlQWGI1uRkWc6SDB4AmSFkPiSshTrLAlhv/9yvBw=;
 b=Kp4LCE8DEQmYAe3Rkr/iqTlKhdsdJK8raLKN/PKBe0IirfY4RkJopzjID7bzB+DXbeqdA6OtB2XqXb5asi1S12kEb/8pvjmde93bVWe1mAmcQBd2nCUvJXn3EzIrzQSdw9mnyATBZ9721QF4zTU7t3iXNOoIfSHhg9OQeOUboy9ss3qBusCTyNfSGv2WX6gyRJdECrX/0g2xYgOLVEgjOUz083XjmbTMqPhoCcKLt6Ltnp2siZphEaoeLTaTMnAG9mQOjeNHHHZ4UFtadjGL54wCu9ch1fmLMstO41Ng8DyxyODuPWdQynOrtGeOdjwSLlxFJ/LJSOy3I8qGHaQI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiENlQWGI1uRkWc6SDB4AmSFkPiSshTrLAlhv/9yvBw=;
 b=P7pMSn7pyjUfUy7cTdkSme7KhqFkfu93fG4eXxphrgNcMEz9uXftFvOG5sUNDZLcjKPAooHfq2gZVVSXYwQ5w4u2/fy4TOomyTZLbv6/BWcaM8hIBPpB7dCbb03Icw62fKV7n+9QAoGKFJnc0+mKiIrqzaKIgmSIl0WQa+W5pic=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA0PR10MB6796.namprd10.prod.outlook.com (2603:10b6:208:438::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 15:00:04 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:00:03 +0000
Message-ID: <32b5458c-7528-4902-89fd-e7ae0c25ee66@oracle.com>
Date: Tue, 21 Jan 2025 09:59:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/5] vhost-iova-tree: Remove range check for IOVA
 allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-3-jonah.palmer@oracle.com>
 <CAJaqyWcVNaUkOSwe_BNbhS88+fOyXAPkuETGpak4k=uCdM=MFA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcVNaUkOSwe_BNbhS88+fOyXAPkuETGpak4k=uCdM=MFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA0PR10MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ac99fd-531e-483c-27ce-08dd3a2c47a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzJ5RWN4SHR2RzJXODMvUXg1ZTFjQ1RrQ1dNaitDVEtLRm52WVUvLzYzYTB3?=
 =?utf-8?B?MlpVdTd2cWFGZmNzK1REbUxPNjBVWlVzdjUxSzhmWE4vRjFDSXltSDhvMlB6?=
 =?utf-8?B?SWhRUFBrek1NemkyQ1BNM0pmcXZ3aW1TUDlDYURwWFJwSmFreGJnYnd3MTBP?=
 =?utf-8?B?V3NLWlFlUWR0U1cyN096bXQxSU9hVGRmdk5hRU9Yb3lHTXpGNFNsaHFrcE5o?=
 =?utf-8?B?cU5YNXV2a2krbEpXY1I4VVN6M2tmd0JuVURKMmZTbjIybWZMVzlxRlk4YVJo?=
 =?utf-8?B?K0s3aG9nUXhuNUpkSHhyTnpSYzlmNVFkQ2lIMVl3SUduYjZlLzhDZXphcHgx?=
 =?utf-8?B?dDZQMWxqcTkwT00zT0VKODR2dCtYd0EzUnh4UVFZYWd3aFhlRnQrWXVKODZ6?=
 =?utf-8?B?eGlJUlFxOUN1VG5BcmM0amlYM082YVpsZGxxdklhdldFSnZqV25pS0ZSVDRY?=
 =?utf-8?B?UDJNcnREL1BpSW5Bd1ROdEtWTkNVbzl3N0RNdEtOWVpKd1BKWjZkNnpmdjVK?=
 =?utf-8?B?UEpmZ0YrQVVpSzZKUUhlcitVTmpLRGtvTXlnZkJvdEdZck4yczBBN0d6RU1k?=
 =?utf-8?B?MWFSbXVpVFliNy9mL1BaSklYRkd3ZTVoMXJXNlZ3Y0hLL05GbEpIRVFYNjIr?=
 =?utf-8?B?K3BOeXBhWVBncVRGODJrMzM3K0I0MkN0YU54Y2FoU3l2SkZCd3k2M2Zad3Jr?=
 =?utf-8?B?MEJKZ3RTSjljU2Zrb2V0R1BLcW9aUEJld2l2T1A0MXg5MGhmMHMyYjZuaEpp?=
 =?utf-8?B?VGFOMy9YZEcyRTlDTFFJaFJxMTBiMk81TWVGc1pValUvMS9DTzl6MElSZXFI?=
 =?utf-8?B?ZTV4TG1pMkY0emJRQnJWa0dyaDlKQmc3UVFaMkFDODByZC92bHZYckJTMjNM?=
 =?utf-8?B?ODc2WUVjZituOS9peDViUThmdXJXMTNmNkU2SHdLSHNiR2VqR0VkSTlwVTFY?=
 =?utf-8?B?N0JUYStybjZkcXVsSEpYbENHMDdqMm45UmxjUlRVQTNVTUl3amZTWGdHb3dK?=
 =?utf-8?B?UDVQY2pZbjhlbUdiM2xJUUlZaSt6MVJKb1l4UDU1amhCQVp1NG14cGpEOXpa?=
 =?utf-8?B?U1JOOUo0NVNia0JNVFg4Z0g4bVlSNGtnVStKR0ZrQWJGYnZCY3RzS0o0ak9p?=
 =?utf-8?B?UEFOMFBqeXZPaFkxWElBWExtajRWdkFTZEppdGdlZjNhcHJsN2kzT2hFSzJV?=
 =?utf-8?B?N0xYSHNraXhhL3lEWC9GU3dnQWpJYVZWN0twV3hKSk83aUE2TlQ3bDEvQjRP?=
 =?utf-8?B?WjJHdGZYWVMyT05nTkc4MlhQVjBkT1JrWjFWWnBFRkhEM3pHN1NDd1dRdEov?=
 =?utf-8?B?UFhGRkhWVHJVV0pnSVMwYWx3U1JKeVRtbnpHeFZFd0V5b2tDd1M3UkZIZ2FE?=
 =?utf-8?B?a2oyQUJvVG9Zb050TFlJSnRNQXc3K0JoRG9kL1J0eVVTd1Q0cU13eDh6eEpZ?=
 =?utf-8?B?akpMMlJXVC9BY2paNTl2UnNCdmJCVWZRai9PUGVCTXpvUjRFUWZDcU52M1dP?=
 =?utf-8?B?SEx5STA5aVhwcjRTZzEzclNVUCs5SFduK1V3aFJ5bUc2dWJ6aHRFdUpVaEF3?=
 =?utf-8?B?ckgyRG1lMTB2QjcrdmtKSnZzc2EvcHErd1pkRk9FczBhdHg3VWIxNFNjUXB1?=
 =?utf-8?B?ek5QM1ZtZXRCd2RPRFhLU2d4aVZiN1BPRDQvMDhnRlQ5TWh6dkxmQVBSaG9D?=
 =?utf-8?B?TDBkYW43a0ZPaCtUZFBQcXFQMzdKSitOM3dmVm9YWUtnZmRCcGpoZzl6Vnp6?=
 =?utf-8?B?RGVLWTl4dnNud1NsM0ZCeXVXTC9kMERIdkJvUHMvK2RPcnN0cjZUSTYzb0Ur?=
 =?utf-8?B?YW53U0NMa3pvalV5V2dMUUZUOXJNZVFJMWd6MFlhQ0h0djN0czhwd1VhSFdp?=
 =?utf-8?Q?WKCaP9Bk/6Jc6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTY2TVlub3BNV2hZTDhHRUZUWEE5ZDlKdjJpdnhJalBWS3pOOFVEalQrUllO?=
 =?utf-8?B?R3hIbWFPcUViMzliSlo3RlZVRUg4OXQyMHllQ3hqcXJIaFk4TWRCQ3QzSVY4?=
 =?utf-8?B?bk9ZZVkwYUNMOElDUWVWWnJ6SjBnTTFJVlZFZ0lqZlNPeGVxNWJaUUxqd2I4?=
 =?utf-8?B?YURPWkg2UlFScEFTUnJUYis0WVhidnl1cGdHMFNoWUNXbWNRcmFFQWMwN3da?=
 =?utf-8?B?YUNNMHFBV1FJdzFXd2lrRDhhc3IzVGF4RTJEY2UySklJdVRjYjhDK1ZUMkMw?=
 =?utf-8?B?VDh3SjFDOGxtUXdvQ0ZnSjFBVEUxTk9WUUQ2SXI0YmV4N2h3bnNWUy9FZkpi?=
 =?utf-8?B?NmpiclQ2UUlwYUV5bkRBZmNKeXN2Z3ZMajczU2lSaFpqeWY5ZFdmTGtsUm55?=
 =?utf-8?B?dWNyZHJETmZGbEtQYUZLelAxTmJuUDVxL2h6MFNmRFBvOS9wMUx6akhIUFBO?=
 =?utf-8?B?TUlXYStZZmtROWRkVDhZT014SmlHdy8yOHI0MCt4UjBJdjhESE1NNW1taG4r?=
 =?utf-8?B?b2xNRVlCZEo5WWZNcHhwVVlib0R1MGtYMm50SmQ0Q3A3N2FBTWh6SWdQdHlN?=
 =?utf-8?B?NVM5R29mdCtXeWd3RlR5dE1qSnU1RThDZVBiZTF1MmNzVVJXbW1Cd0l2UFVm?=
 =?utf-8?B?UWVEMmJOa1NoR1dndk14SSsvdTNxVU9iNWh6Yk1kNDRaSmNwSStnM0pPR0No?=
 =?utf-8?B?ZjJxN1M3MkU1SXNxQUd4WE9OS3RhbllhSjdhZW1CMFpWdVZVVTBjcW1vYXNx?=
 =?utf-8?B?ekxYK2IxVDNxZS9ONUJ4LzFHcUxDZ01Pa0hCNHdSakMrL25HaG4xdTdORGpr?=
 =?utf-8?B?RSsrNzVqc1lVWW95ak84VGVicXVYTVpqTGxMOGxvcXQwaldRS21NTi9odU56?=
 =?utf-8?B?cXcyWDNia1BXWU55dUJZUHBidTl1dEZ6VmtCY1lnWTdyRm1tQktScFVNa244?=
 =?utf-8?B?TzNWOWt1bmQ0Nkl2QTByRExaVXZ4cEtLQ1AyZUltZWU5cnlublVVNVNteUJs?=
 =?utf-8?B?UU4ydFhQSVpaZTM1OVlKVWFqM3FhbW5hZDJUSHpRZXFQL2FRbUpXNlVBV1Yy?=
 =?utf-8?B?ZFNXdkVuUVJZVyticGpWekQxZkw4R1F2UHN2RTZJUk41QzBwZzcwWWNSaDI4?=
 =?utf-8?B?MFJ2WHhFSXlXazVQOUUxYVhpQWhKY3h0UXBKazU3THRSN3dENmY2WElXeC9l?=
 =?utf-8?B?eGxNMVd6STVvUiszZFg4SUZWZ3g2M3B2blduaFdTV2xBVWtQTk44dktYeHAy?=
 =?utf-8?B?VlYrb3Z3UGJGV0pxc1lhVW5kMGtPWUtSblQ5N0ZRUTFPUS80NnVsWXQ1Ty9U?=
 =?utf-8?B?SjdqV2hQU1Y1S3h3K1dudU13Q1U0M0tIY1paQ09qS2JmVWlsZGFoamE2aEhu?=
 =?utf-8?B?amk1TkJwRGxKSVVZYWUrTjYyVHFiSWZvV2xzTXFYQ3B4WlFpZEJFYXVaTWp5?=
 =?utf-8?B?SW5GM2k2QUh3TVFQZStUUTdidWxRMEZJSzVkMFgySDdQcUpNQ1dJK1NlcmJS?=
 =?utf-8?B?VG1OSjF0dVVxRmNHSUhKd2wzTE5ySE5rSVpNRFVFRHdCR0dkVEhTTXNaU2JE?=
 =?utf-8?B?RlpzbGlxYlZ4MFRhQm9Ld0ptOVZJMGtZNjN6MzV4aTcwOGJEMEJQODJtSnhX?=
 =?utf-8?B?cFJ0NjJsTGRLU0VRbjNPUEx6bnkvWll0WjBkcHVCSmdzZGVGUHZ1aDBONkRU?=
 =?utf-8?B?MkliaTNwb0NLOHNuQ2hlQkhISkpySzEyWlFZQ1diWkxwbVY4TXEyLzEyV1RN?=
 =?utf-8?B?Ny9UdlllMFVUY09LdDgybkRZTTNBN3NaV3dWMXBySHNENnJ1UGNVOXVKaC9X?=
 =?utf-8?B?YzZsNTFYazAzUzBQSXhoSnhYK1Evc1VNS1k0YlRGL2JUYndNRTRmOW9SbGV1?=
 =?utf-8?B?ZzU3LzA0OFl0aldMMWtjTlh6QU9wbGNOR2lRVVRjUExGeTBHN2xkcE9KRURM?=
 =?utf-8?B?LzUxK3ZybTlETmlIZXhCQUNIZmkrVmhUR3B2ajg0QTIyN2JJSVZIK3c1WVIv?=
 =?utf-8?B?UDNYWFFieWpmMFU0M09nZzdmV0RPQ01xdEJ2NUwrbmJDRW1lQVBZNSs5TTBq?=
 =?utf-8?B?b3lsaXlJQVVKQ1lPMDYvcENTa3lSS1NHYVdUMUIzM1NaZy9tdU5Ndmt0T2Yy?=
 =?utf-8?B?bWk0MWVIMVROendkYmVvRmJXSTdPRVNOek9lN3VKQTdXYXNSa2xEVnphTWxo?=
 =?utf-8?Q?UjfVkDfJ79V+CHbC33s2aU8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bCuxdifrZLGLmWps6OErpg3nRh1N5EA2GD6Fca/A0tHx+dVLGXkEZlF1zK0oCZcPz0R1ElY5291mH3OMZ0zYK4DuNs1YdlRv1ZU/glzbCXyDhUZtdWqMfqOV/RewcMsRAx4IKqX+pwlJUTyrmZAs3JrtMYr0RXfGe0InGFy2VOXX7771G5zxlTwHLsGmkkAdyXNaHuWN7BTd+dezk+IYmQxeiT/mOQePhIJ45G8GqvppEjJfBzq1PGo4YlnIcY0BR+CFwzAwkPJklxhxCiSU+ODVI3cwy3MApZk24LaZnAumWuYL4QpA4DPjSHaG6RgFovo14Z0PeLmbKFZy641GjT34f+Ow7eg6eb6Ij4yW+urYK312jQtwO9S1MGERU94b6fjDamvb49Xf8zXxo9R4ePJ6OyI0UvrgrYvSIu4ucfvPDXoxtD8gRLQUqJIWz050mN2+T//U2GrGxGeIbZr4IHxMYKaGGf8hoUhPp44OtosCV4r48CT5VQfax7F5JYh0X5Qq9JrbXEgg9wji3tV/yGVm7gq90kQvpkbYHSxW4Fa3wVdmzba31ZRths3tcJ3+2QtaT+LH2+uRGY5ZltCjj4fjLVTko5XCe2yDKkL2f1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ac99fd-531e-483c-27ce-08dd3a2c47a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:00:03.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gMWsqUq2fe8CYcVaAzZkMru82UymdVGQ+Nn6benBlVvHFFFoMHTA/Z8uaJjQLKspUdUAmIxZ4AxmPsizwysWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_06,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210122
X-Proofpoint-ORIG-GUID: gfqe8B9XFYbRV9QQiG_fsP5oTNtdXJ7m
X-Proofpoint-GUID: gfqe8B9XFYbRV9QQiG_fsP5oTNtdXJ7m
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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



On 1/16/25 12:02 PM, Eugenio Perez Martin wrote:
> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Removes the range check portion in vhost_iova_tree_map_alloc.
>>
>> The previous patch decoupled the IOVA allocator from adding mappings to
>> the IOVA->HVA tree (now a partial SVQ IOVA->HVA tree) and instead adds
>> the allocated IOVA range to an IOVA-only tree. No value exists under
>> translated_addr for the IOVA-only mappings, so this check is no longer
>> needed.
>>
>> This check was moved to vhost_iova_tree_insert in the previous patch
>> since that function handles adding IOVA->HVA mappings to the SVQ
>> IOVA->HVA tree.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index b1cfd17843..f6a5694857 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -93,8 +93,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>       /* Some vhost devices do not like addr 0. Skip first page */
>>       hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>
> 
> This is not a static function, so I guess it is better to duplicate
> the check if needed? Otherwise a buggy caller can create invalid
> entries.
> 

Gotcha. I can drop this patch then.

>> -    if (map->translated_addr + map->size < map->translated_addr ||
>> -        map->perm == IOMMU_NONE) {
>> +    if (map->perm == IOMMU_NONE) {
>>           return IOVA_ERR_INVALID;
>>       }
>>
>> --
>> 2.43.5
>>
> 


