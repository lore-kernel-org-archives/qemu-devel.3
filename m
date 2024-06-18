Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB28C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWzO-0003En-VA; Tue, 18 Jun 2024 07:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sJWzM-0003Bl-V0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sJWzK-0007n8-7z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tQEt026661;
 Tue, 18 Jun 2024 11:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=i/VaVPHXjIkvDB+23osRmH4gvzSbR+ckPOiWxc1s9YY=; b=
 C257UgzYK6Q4dCo7AaD+O8NllCD7BvL8H1yoUMYhUMS+Oj54JfwhVqbILqzazSY/
 ZZROSEztkrHcNBL5bShu8UrDJm//MLV6bLUqA86zLyfmOTUQonn9ZvequF27x9Jv
 EIxjABVjRUbAcnC8cyFw8v0M+IN8Vu5E8E1fXemiommRybQyB2+AW6b6B0/T9aoF
 xGm1xQ4hiUDFZ2/v/IiRNsRQrJKGcDgleESt4oJisQs8++YLsEtw24ABWoePLGE9
 Y5py2cFQNAgE7U+VvG+3apV6WUr0keotSceZK7HtoVABy93rqzcTvgVZuTNBpnll
 Ath9xkL5yoA3P1hbCfrfzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js4mwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 11:26:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45IAv7v6007029; Tue, 18 Jun 2024 11:26:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ytp8e8mm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 11:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZz+p7U6hhO4BfRAp//DWky3dW12f+CUV+t55aen/FlEEUXggYwcYqM0Fd9CslVYTNNhsX1mEeFy5bSfb9sbWTRhLzSQaDfhZwqqi9dhEv319qZqu2cNi7o3p6ODzvJDB8ErO6MUMookQFGCPSClwLXq+a5/Bapizf9/bvqlnakZSrNRLB0oiXVU9fk6bOoN9/m7KD6LdpKQ5vLG2iv7k0QepfmHLnAivBaBsHllAFgOUEnQjvcTF/aZIBvRsXhwsfk2CDm5g+sLl/iSg23wKyXeRbDERN9Sv0prZkYmE48u8XMHUbLdpiH7FSBsyVEcZ2W/BVvrBPpLvkPGxCsdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/VaVPHXjIkvDB+23osRmH4gvzSbR+ckPOiWxc1s9YY=;
 b=E5M/lxfxMnOhZzbyFJsIqYDLTF6pBqIHMzLQZijjG5GiqJy/UUa7jTMqwSm1DdKCil3NrLm+r+l5tbzRZ4Pj0wzaMUx01wCRKa7mnRrcI0hEZKSEtcDznnIwuPqW2UKYxvZK9B6NIdEIvnmL4Dk8oTTb8NBLfnupevVqKRjISP+4hmTOiysGT1w/ZExgbHgr4vIQf5egdhZquni062nUgEQ/5t0VvvHVUE3zcsCmHXlASBJ6wSS51RqiNb6HvHJMZMouDu6ff5GWDyedu6QlIGHAYIj9mX26qPp0vO30mjc42KEjH1JGjFSByRjZGCUPZsvYabDFfeQIVIIRsIcsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/VaVPHXjIkvDB+23osRmH4gvzSbR+ckPOiWxc1s9YY=;
 b=wudggHF2ux+V5RAcumqZttHBzetsKR3GOoHx3hWm7FYlMM6luNh91F0srO4Brw01Ltft4eTzH/P8/UMcL+K5oBw9Im9iaDYD2bAkYogvhcSIu+CHwh2lAM/xA0BBa0UwYS2WvmHL24+Zq3v3JXDSXPQ2RBmvpXgGJEtrLJQNczg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 11:26:44 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 11:26:44 +0000
Message-ID: <d97cd2cc-5cc4-46c1-bbe5-8ab6e97b1bca@oracle.com>
Date: Tue, 18 Jun 2024 12:26:33 +0100
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Maciej Szmigiero <maciej.szmigiero@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
 <8ca65f18-5a0d-4176-9bc1-f318d4ba4db5@oracle.com>
 <d6ef8a37-9337-433e-a0bf-ce50af20a734@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d6ef8a37-9337-433e-a0bf-ce50af20a734@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff94261-c638-4fc9-ab6e-08dc8f89885b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1B1bWZBOEtvUkM4cU5Wazg4ZkF2UFlqTmRURXF6amduWDJjazFCTksvL0Uw?=
 =?utf-8?B?b1kwdkFPRUVIMU02NHgzSzdOZjR0SkVEOUw2ZENTWVY0TWVWeWR3bnZmQ3da?=
 =?utf-8?B?OGRjdXB4WkQ4Tnh3WjJKNzlXbW9MUnY2SUJFZ0tYZTNsMFpMK0R6Y1hjV3d0?=
 =?utf-8?B?QXJjckN3SFNKZkVyOVRhcVdBVW9uaitqaklvaXB6UVZYVVhvMFRoQ2xkLzh0?=
 =?utf-8?B?TzBMNkVGSUYweU5YbDcvZVFFNWd0WmRBU1JpRTdtSE5LK04xZmZ1RkVaSXUr?=
 =?utf-8?B?WUZ6aFl5YjRMOFJLc1hMWDZPLzJrRFBnN2N3Qk9uUnVDRVJLOFc4TnJNbmZu?=
 =?utf-8?B?L3RQT3hLV0c4Smllek1zdWorSFdFZnNPS3p1TTh1OHN5YXBkdmtpS0xUZzRF?=
 =?utf-8?B?eThOTC90bHZTTVFQdTVpZ0Zka1A3b1EyM3FWS1RoMm1vMlA2Si9OL2hJQjdv?=
 =?utf-8?B?N0ZPQU1TNlExMndIbEJTcUtvc3pxR244aVpNb2FyYkpWVXdtcXhYMjN3cS9C?=
 =?utf-8?B?b2pmdE9XNFl6NjQyQVhxTVpBWVdpMXhsdmlGNjg5ek4yU1Y0WWViOWxoZW5J?=
 =?utf-8?B?R2p0aHU4c244Z21RR203YkxoaUc4NXZqT0FyM0NUN1ovY1IrelVnVDNIUFY0?=
 =?utf-8?B?NWNKQVNrM2V2RklIZDhnekdvTklVZSswMzBtYjA3T3FQZlFrQldZYUJNQVAr?=
 =?utf-8?B?ZzBGaHFOSzlBQWFlaHY2VkNLU2djNmJFZkNmNzIyUlVqM1REUFZXYitUaVhG?=
 =?utf-8?B?ejJoVEUxZXRLcG5KcVZxVjhqWmVvRVpMNnRGZXR0S3VERk5EbXBna2RLU0pW?=
 =?utf-8?B?ZFpoTXhoNHg5Qjk0RW12bEtjV2VDUm5BbTJQOWtZSm5DOGFIZkYvcEE4L0tk?=
 =?utf-8?B?SnIvNWpxZTFjU1B0OWVxQ3NyL1dIMlZqWEYvQXRqNSt5R2YrdVBPbkNvTi9V?=
 =?utf-8?B?b0liRmtSS2JSY3J5WFFycW9vamZsYzJkcEVoSVNKQWpONFZkVDJSU01hV0li?=
 =?utf-8?B?a1pvank1WlhJaXo3TkpJOVZBRnhyZlBJU1crZDl0MjllWkJwYlVVbzl0K2Ni?=
 =?utf-8?B?K3I0OS9nbzZWSll2QUR5L3pMdnVIOUJ3YkNwaGRqMi8xTmYzVkRJWnZML2pp?=
 =?utf-8?B?aWZjT0FxUUJPNjJEVzJMN05sa1p4MC91S3ZUYTRqRUNZOEdHeFBBRDhPb1cw?=
 =?utf-8?B?RWxVbTdycVFwS3prbmpMRm4vN3Z1aTdmV2dqSmlrNUlGRnpzSU9WVWRzZU1I?=
 =?utf-8?B?OGtjLzVHSWpzb0JhRWNtUFZRTHlvTnU1RGRpbUhDaXBkcDh2ckwxZGN0dmFv?=
 =?utf-8?B?NHlBVFZqV3BaL0dCMTg5dy9zQzB0QldRR3kvdHAzOU1UcDRMUnJTbThKTFll?=
 =?utf-8?B?UmQ4TXd0R3YzUWdKeVE1d1ZlMVpQQzduTUY0aHcyb0FmSkZBYTd2NlRTUVQy?=
 =?utf-8?B?NHl4VE0zUjJ6VU9JTUtmWWR3TWd2VU5YdUZJeURlM2p5WDdLSGMraURmNjFM?=
 =?utf-8?B?eHp6MjNyWmdiME9KT0RENmZicHIxM3M2bVlQYmx5NHc3eVNvM3pFSzlpd1gw?=
 =?utf-8?B?S0RXV1A0YllzR2ZTVDhzaUtnVW4wY0hnenRqdmpGbTBjV29md3RQRTB3YnlW?=
 =?utf-8?B?dHBPaFo0NGl5cERnWUNjN3lNUFlheEI5bUFadWhYTGZqdW5Jcjl1YlVYWHR3?=
 =?utf-8?B?cEZJYVZBNHNvMGlpTVNXYXRIMHdKMU92L0YxN0plcXZVRGgva0lFc2VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(7416011)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndZSTRGWEVHZTQvMEVKZW5UVmlNbUNNQ2ZtRDlka0VTVnY1VHJ4SWlqaW93?=
 =?utf-8?B?MlpIdXZxYzg4VnhOWldsOUlrZTZ6ckVEQ01ybzZsNlpPTFV6VmtwaDF4Yjlp?=
 =?utf-8?B?RlZCTVl2cjB4Y1FPMzFQK2czMW9oNTExYmFqcXczU1dGUEJDWFpPN0FlUXBF?=
 =?utf-8?B?TjBQcE9NOExadWR5ZWZ0OVdBZzZrUkhpd2xMNWZHU3QyRFlNQ1FhRjdSRnhv?=
 =?utf-8?B?ZUU4MEo0RktrMFJFeVVWTDNQS2xtSzB5MFVKelpXUnNIYkRzV3ZvcGFNeXZy?=
 =?utf-8?B?d1FjR3Y0dTVCcTVMZEVnNEhoRy9HeTljbW9acGI1Wnc5V3FIQmgzek8ycGQ3?=
 =?utf-8?B?TU9HUEtTdVRZTitFa0NBNSt3VWsyUDZUaGI4dno4OEVhUDFiVUJLelN6OTM4?=
 =?utf-8?B?REdrSUFDZDJUZkc0d1FmcW84NTFUZVNkWjNZN2lrU2c3RG01K21LOXdycXBj?=
 =?utf-8?B?azUxL21GOGZ6MFRpVitMbzdqdVI5MHlIQ3RIN1dJRjBOU3hMUWNENkpteGxB?=
 =?utf-8?B?S29vdXBJaXY3OGJXZWIyamxORndmSDNWUXRWMklGVFk5OGZCaXREWWI3Wlhy?=
 =?utf-8?B?WWJoYnoxL3E0MkpPbFlZdU56VGlibm4wZmNaZ1R3R0F1NXdFYWNUMGZocVlQ?=
 =?utf-8?B?bFEraHhrdHAycnl6OTRldUVhQnJaK013MU9tRkZGbHdVL1M5aDY0TXJieG82?=
 =?utf-8?B?Q0g1VG53anpjVFh6OVVHTi9rL2V4dEZBeW44elRwRmVjTytKV3dNUmRMM1ZH?=
 =?utf-8?B?U0dRK1lTQXErdDV6UTNYcjZ5aWQ1dHJERldLTUk1OTViZWxIQlZ4N0pJaW1w?=
 =?utf-8?B?ck1pczJhSXpzQjJHL2svVjRabm14RDh2clg4MlBzelQwNCtlTU5KSkUvTm9o?=
 =?utf-8?B?T2VzUkZpNERrQlBUZXhrY05KSm5ETll0NFUwWjlpczBNNFUvU2t0MWpKT0pp?=
 =?utf-8?B?ZXp6ZnIzNno3bVUwdkFkd1NNUnI2SHBtT2Y1MXQvcmFzcklocXZWUDV6WmJr?=
 =?utf-8?B?RXNNSFFYL1BwazZwRWNOS1k1a0VxZFVUWUxVdVhubWNMbXhLTFF4bUczZ1hM?=
 =?utf-8?B?NmVLTUJRNnBjSkhYZ2JUamREa3VyQktLVjNpMnpZRFk1RjVkL2xKcmNJTGdl?=
 =?utf-8?B?QmR0T2lLMDgxTXlFNWpCWVFSbFJvVGtiM0RURFh5bDAvdVRPcmFuVTJ2T21H?=
 =?utf-8?B?azV6WHlrcTF6bTlLNEVFN1hkOUtkM0VQRG13STlPQkZzQjF0bWJrRTBjbGtB?=
 =?utf-8?B?a04zd2JnUnpIckFVNlZ1T0ZXa1ZGSVcyRWh6OTIyeGxobm50MDNWV0FIZTVN?=
 =?utf-8?B?QVJGRkxWUXowbTF0L1RialYwakpVL1JJZ2k1RjZydmtSWnBxeXNtZWgzOVdH?=
 =?utf-8?B?TU5RbUdKZkRzVnBSeENiajBvYWJMN2J5aHZKci9qRkpDRmpoL0JnaUg0MW42?=
 =?utf-8?B?N3Q2cksySkRXY09JdUM0Q25mcWppbkp4QlVyZUxqV1dCVWNna3k4NThxTTRs?=
 =?utf-8?B?cHlMU2Q4TE93V1J0Nmt0NVlyYTZwUlpBNGJFREkyUmpPRTBtaXJwdmhZTVQz?=
 =?utf-8?B?YU5FQTlqYXdDNERZN2I0TFdrKzJoT2tDWWlLbk5qTERlNGlUdVZLcm41Mi83?=
 =?utf-8?B?OHhTTU1jR09UMXppQ2J5b3liMTVvS3pIckcvZnZDVVNzNmJyZ2RxdTE0RU5n?=
 =?utf-8?B?UmVJK2F3TDE2aFFGWWVjanRiM3hiSlhFb0hvNGRGSGxZZVd2WWRRbE5QRFFn?=
 =?utf-8?B?cHBiT01BUHdEd0pvZWhnbEE4RUUvR2pJaFdqc0YzUkx5L0crWU1tem9uTEIy?=
 =?utf-8?B?Q0Z6YWN5TTJnU1pOSWdDeDBRV3hhTzRCMDNHWk9naDhUay9TQ2kvQkFjd2o2?=
 =?utf-8?B?VDFWV1o5M29aYWFiQnF4d3huOUMwaC8rVmlEZkdVdk56cnFtNk0xK3BOQzEx?=
 =?utf-8?B?ZUZxZ0ZqZDM4WEtPUE11eHBQMGhBNFo4NWZFMDExYVNKT1A5dmVzOVZtY01u?=
 =?utf-8?B?WEpmZUZVcTdMNGFQQy9qS3kyY1FGb29IMEtVaEdWL1pmcS9jUlNSNTBMbUdH?=
 =?utf-8?B?UHM4RWxJZUFUOTFEbDRTZWF4bmN5ajBRZFg3bWpPQ3QxUXpPMml2L1l3THFK?=
 =?utf-8?B?STlSays3OFQ4T1V4YkxZbFhWSEMrZ1dvakNtdSs1TThnUkIrcEo1R2lDVitG?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nIjSt0ddvhUqF09yyL8joGLVs6Bb//ZQt7jDRBX2fyJc2Q4n/4aKnXu/mp7wMX6JOtKx4BjpW16/RTz+ZQyrmSjtUImYa1j3fXqVJU05RCxs8UdDnjAXSJFFGXrWRglGPgn/QVwr2MbWe+wYm75kuFOYxYe3QP85FU+XWlvzUZXUhIPrLN2OVU5I5of5QdboSYprvlJajyI+OViN+IFe367zXF/Mj+bGNU9Ndl9fKP/1pxER+7aL7pAnT+ihL7jmkClPtHrIU6FZlS7WQEvxUJFU+kemzdwu7c6gzCAKWIM8LrlIf6291xkJwBU/CJutgi3JSxVHM3/yGEe6iIuuhC8kWeyxM5fFWZ0cOO9KdaCch4yUMnNt2Jh9k2ltuKhBE5+LOLmXmTptlfGdmwc+L3sXZC1aIGLt+8HRi+AVlY577BZHnbTNiO5B6ON+93O+7K4PpT7TY3m2agsmmlK75hAvGc1ExDTV2Z9AtkKq3o1k5gzomfSGanuoNf/r7lzXjZxaYGDqx0LRY8i5OF4FcueRzTWwSGiBXcsnKpjfLK+kuR8K/22LnXihIEeH0VMy6KiJObKg8kSdxGS316VMJt50favkM4eMbN8+m2L36nU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff94261-c638-4fc9-ab6e-08dc8f89885b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:26:44.3200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beRbJbq4UP1xfvoubZI6Hh9kBUVfD2UL2jNoe69o30CAb7+UF2+pjusTIDB+l3nVWyjxaMFiod0OqNB7KRZjtup+lezm0r2q1FHVFD8LCHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180084
X-Proofpoint-ORIG-GUID: kqCXOFco3wE8H57N5W31e7bcrSqSygsO
X-Proofpoint-GUID: kqCXOFco3wE8H57N5W31e7bcrSqSygsO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

[sorry for the delay, I was out last week]

On 10/06/2024 17:53, Cédric Le Goater wrote:
> On 6/7/24 5:10 PM, Joao Martins wrote:
>> On 06/06/2024 16:43, Cédric Le Goater wrote:
>>> Hello Joao,
>>>
>>> On 6/22/23 23:48, Joao Martins wrote:
>>>> Hey,
>>>>
>>>> This series introduces support for vIOMMU with VFIO device migration,
>>>> particurlarly related to how we do the dirty page tracking.
>>>>
>>>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>>>> provide dma translation services for guests to provide some form of
>>>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>>>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>>>> and remove the migration blocker when vIOMMU is present provided the
>>>> conditions are met. I have both use-cases here in one series, but I am happy
>>>> to tackle them in separate series.
>>>>
>>>> As I found out we don't necessarily need to expose the whole vIOMMU
>>>> functionality in order to just support interrupt remapping. x86 IOMMUs
>>>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>>>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>>>> can instantiate a IOMMU just for interrupt remapping without needing to
>>>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>>>> the same, but Linux doesn't quite support the IR-only part there yet,
>>>> only intel-iommu.
>>>>
>>>> The series is organized as following:
>>>>
>>>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>>>> establishes their first DMA mapping via the vIOMMU. So these first four
>>>> patches add a way for vIOMMUs to be asked of their properties at start
>>>> of day. I choose the least churn possible way for now (as opposed to a
>>>> treewide conversion) and allow easy conversion a posteriori. As
>>>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>>>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>>>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>>>> was doing in v3.
>>>>
>>>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>>>> DMA translation allowed. Today the 'dma-translation' attribute is
>>>> x86-iommu only, but the way this series is structured nothing stops from
>>>> other vIOMMUs supporting it too as long as they use
>>>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>>>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>>>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>>>> we've then tackled item (1) of the second paragraph.
>>>>
>>>> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
>>>> IOVA address space, leveraging the logic we use to compose the dirty ranges.
>>>> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
>>>> addressing limits. This tackles item (2). So far I mainly use it with
>>>> intel-iommu, although I have a small set of patches for virtio-iommu per
>>>> Alex's suggestion in v2.
>>>>
>>>> Comments, suggestions welcome. Thanks for the review!
>>>
>>>
>>> I spent sometime refreshing your series on upstream QEMU (See [1]) and
>>> gave migration a try with CX-7 VF. LGTM. It doesn't seem we are far
>>> from acceptance in QEMU 9.1. Are we ?
>>>
>> Yeah.
>>
>> There was a comment from Zhenzhong on the vfio_viommu_preset() here[0]. But I
>> was looking at that to remind myself what was it that we had to change, but even
>> with re-reading the thread I can't spot any flaw that needs change.
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com/#r
> 
> I introduced a vfio_devices_all_viommu_preset() routine to check all devices
> in a container and a simplified version of vfio_viommu_get_max_iova()
> returning the space max_iova.
>

/me nods

> 
>>> First, I will resend these with the changes I made :
>>>
>>>    vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>>>    vfio/common: Move dirty tracking ranges update to helper()
>>>
>>> I guess the PCIIOMMUOps::get_iommu_attr needs a close review. Is
>>> IOMMU_ATTR_DMA_TRANSLATION a must have ?
>>>
>> It's sort of the 'correct way' of relaxing vIOMMU checks, because you are 100%
>> guaranteed that the guest won't do DMA. The other outstanding thing related to
>> that is for older kernels which is to use the directmap for dirty page tracking,
>> but the moment a mapping is attempted the migration doesn't start or if it's in
>> progress it gets aborted[*]:
>>
>> https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/
>>
>> The above link and DMA_TRANSLATION is mostly for the usecase we use that only
>> cares about vIOMMU for interrupt remapping only and no DMA translation services.
>> But we can't just disable dma-translation in qemu because it may crash older
>> kernels, so it supports both old and new this way.
>>
>> [*] Recently I noticed you improved error reporting, so
>> vfio_set_migration_error(-EOPNOTSUPP) probably has a better way of getting there.
> 
> Yes. So, I did a little more change to improve vfio_dirty_tracking_init().
> 
/me nods

>>> The rest is mostly VFIO internals for dirty tracking.
>>>
>> Right.
>>
>> I derailed with other work and also stuff required for iommu dirty tracking that
>> I forgot about these patches, sorry.
> 
> That's fine.
> 
> I am trying to sort out which patches could be merged in advance for QEMU 9.1
> and your series has shrunk a lot since it was last sent. I might resend the
> whole to cherry pick the simple changes and get some R-b tags.
> 

OK, sounds good.

> 
> For the record, here is my watch list:
> 
> QEMU series under review:
> 
> * [v7] Add a host IOMMU device abstraction to check with vIOMMU
>   https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com
> 
>   Needs feedback on the PCI IOMMU ops. vIOMMU "iommufd" property ?

Part of the reason I suggested splitting it to allow other things to progress as
the IOMMU ops is related to the nesting.

>   Pushed on vfio-9.1 branch.
>   * [RFC v2] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
>   https://lore.kernel.org/all/20240607143905.765133-1-eric.auger@redhat.com
>     Pushed on vfio-9.1 branch.
> 
> Need a resend :
> 
> * [v4] vfio: VFIO migration support with vIOMMU
>  
> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>     Refreshed the patchset on upstream and pushed on vfio-9.1 branch.

/me nods Probably deserves an item on the list too related to this subject of
vIOMMU and migration after the vIOMMU series is done:

*
https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/

>   * [RFCv2] vfio/iommufd: IOMMUFD Dirty Tracking
>  
> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
> 
I plan on still submitting a follow-up targetting 9.1 likely next week with
Avihai's comments on top of the vfio-9.1 branch after I sent some dirty tracking
fixes in kernel side. Though it is mostly to progress review as I think I am
still dependent on Zhenzhong prep series for merging because of this patch:
https://lore.kernel.org/all/20240605083043.317831-8-zhenzhong.duan@intel.com/

> * [v1] vfio: container: Fix missing allocation of VFIOSpaprContainer
>  
> https://lore.kernel.org/qemu-devel/171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com/
>  
> Other interesting series (IOMMU related):
> 
> * [rfcv2] intel_iommu: Enable stage-1 translation for emulated device
>   https://lore.kernel.org/all/20240522062313.453317-1-zhenzhong.duan@intel.com/
> 
> * [PATCH ats_vtd v2 00/25] ATS support for VT-d
>  
> https://lore.kernel.org/all/20240515071057.33990-1-clement.mathieu--drif@eviden.com/
> 
> * [RFC v3] SMMUv3 nested translation support
>   https://lore.kernel.org/qemu-devel/20240429032403.74910-1-smostafa@google.com/
> 
> * [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
>   https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/
> 
>   Yet to be sent,
>   https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/
> 
> * [RFC] Multifd device state transfer support with VFIO consumer
>   https://lore.kernel.org/all/cover.1713269378.git.maciej.szmigiero@oracle.com/
> 

I think Maciej (CC'ed) plans on submitting a -- simplified I think? -- v2 of
this one shortly still targetting 9.1. But it is largely migration core changes
with the last two patches on vfio.

	Joao

