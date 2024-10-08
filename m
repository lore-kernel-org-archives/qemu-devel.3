Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B69CEFC21
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syBya-0006va-5z; Tue, 08 Oct 2024 11:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syByN-0006v6-MN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:18:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syByK-0007vo-F4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:18:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtbmD031997;
 Tue, 8 Oct 2024 15:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9HH0a5DjnpqdR/pyP12yiCgD6BzFRhAq84VQszahYBc=; b=
 eEiePYnNZNFCB2LQep9E2H/it73pfJtNtZNdfdAVeqX8rshdWN01vLy7QipsdE1w
 uVuFw+mgdaSB/uV/fjLQhvMhwO2TJWCxjJv976olJFdhSVOuVDexqrLvCxCW3kdJ
 RgA/ektRq/zZRnJ+wuNkjaG2S2PAT5rVFiFqgHGRlTBC0S2OBbhhapvLfZ+hjUTg
 DECCGmsAjrmHX2h2Zwq/QuYaY/0tfRnCDXfWJVRMzg0wLXn/C+CxUUe5fnPHwghF
 KRig3GaBeUk7HvY0URQfTCHD5carx3BohuQfRsW/sF9HB8OAcqKUzUFa39YkakzS
 GhtXqjD3I5pZXMfg4A6Wbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ye3bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:17:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498EjKi4011411; Tue, 8 Oct 2024 15:17:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7a9g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0QFCQ/Z4ddBDwq8UhBj/P5bFNF/iTillg6bLT0ga8gPVHNjb+5SbXPO4nuzbDdIGWDlp/V4XeVAydih414uJDKNWP3tivoDlWytQBuzxz2MR94l3ABCKKez7+p/lwbNvV7RqxgBzZ4SMjPnXCHLBxWI0YgyJPVUJqS4UP8MHwMLpZ4eipQmJkcI4EN+ODS7hCavAKJ0vssItn0SHpMTGiq8FSebYLuS8tiwiAp1n+r7Dxh+XvRpU4LDKO9W7+y7Kdt0uYdZgRKSlVSFdIV4iJB2oUKp4FIvpFqoHA+6CPi9VqFVmbFJoPZr4cKYgSzrjAow/f8E8A1jinBIYjr/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HH0a5DjnpqdR/pyP12yiCgD6BzFRhAq84VQszahYBc=;
 b=wHIdQFg3XsoEC3jnRl3vdADEPxjsCnUQE+HpVgqQ5QVa4pQJdjPjtJ+YEpLtKkKEjzNjpMelf9ncKYcB0GC2bWgRspaE2c5E78898O/S8hzY0S2DEJDrQzKr8nTZaZ8353vzGAhoelfdRTfxZzSL3MTwlX0CrskIEwW3aSgvfc+U9hejVPwam94CgHplyWOE1TepwC9jZajFNQbG0z+nYTQi4q4ARjLwNwXNrVpgWu7QMFDhRPv1Wu9DsOwocZBchfO13Xh17UfaYkyaOjtqeu2UaXhFqG0HHT1gLbfUt7B3F6eLVx8aMPkZN8L1Tpi8Zl2SimiTurknqvY7OuBYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HH0a5DjnpqdR/pyP12yiCgD6BzFRhAq84VQszahYBc=;
 b=nMhrI8B5xkdJLIxLdUWkhLSqxYriKPuTI+RXPQ4n5Wj0h2p0Dh2f1RJW6UwOfSpyPscSRaaAiIAajsjWhCzlNtb9VwqQ2pgRCwOvTyVTEh/aKtKe5kOEw8QpTLt0xFhpYkzuAg8sMP/mJaZQp/htUWAY8Zryg1CoqSRuoqr5a/4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Tue, 8 Oct
 2024 15:17:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:17:49 +0000
Message-ID: <025423a6-8cf8-4300-91f2-13be32ec2c5c@oracle.com>
Date: Tue, 8 Oct 2024 11:17:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
 <ZwQDBc-8niK2A0Vt@x1n> <ZwQMRlSSqP0i0ITb@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwQMRlSSqP0i0ITb@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0784.namprd03.prod.outlook.com
 (2603:10b6:408:13f::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dbd9e8-145f-4685-5561-08dce7ac5ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUFhaitWRHI5U0xqaEswd3NVY0gxSm5hRzJaSzFKdzVXOVI1V2lQOVk1TFRL?=
 =?utf-8?B?bVFNRWVNMVBRR2hZSFRzS1pOOFlJY2ZrYWZRU1V2VkVpQkZlcEtwK3dMMkxl?=
 =?utf-8?B?aW9UdTlWWmNkWkNEejB2Mkt2TmpOU3J0cmxVMzUyc2phOGRQQjJ4OTRpcVQ1?=
 =?utf-8?B?NUdqdzlwdGgwYlpkOVpQQzN2RUFRR3Q4b0NMbzFKeEZXbUVKR2JhTkk5emw1?=
 =?utf-8?B?eUc1Ym5kcFFNY1ErR2k1cCtBeDVremlBVHFUMUZiQjdkWUVqTG5MQU0wRWJ4?=
 =?utf-8?B?VDhFMHJVVUZXb0owVEQ3NXhXQVV3cVNzSlp4d3ljYjF5Nkc5SDljaFVzeXdh?=
 =?utf-8?B?bm5PY0xDYUJzOGpIM2d0bTNRQUN2U0JzcFFHWEpybkRLOGYwR0RvZjdqcitx?=
 =?utf-8?B?QzFqNXdMSmpHZnA1YUhoSDk4cUthRWhXU2wwcGN6R2dLbmtWa2crWUdWT0gz?=
 =?utf-8?B?eFdtcjlWUkFoS3JJU1VqVU5JYVdTcjJXcllVUE43RVN5MHdaeUlnZWpidUpp?=
 =?utf-8?B?STFaMjEraWpmYUJFV3pUUEc2S012Q0Z2aFlyYXBpOENBalFydm1STFVQNnBP?=
 =?utf-8?B?YmxoT3laNE13ODFVQjZjMmp3ZXlJeWxEUGFUKzgvV3p4NkpPb0x1Q0ZYR2Vi?=
 =?utf-8?B?TWp3NmRobndsakRSTjlZZFloTEhOMm5sbGI1c2t5UnRzYzhPdGk2NXJnREJ1?=
 =?utf-8?B?dmhERkp1YzN4ek1HOGVoaXJubzdXanFtNXk5azRyYjM5L1ZZTktzVDAxN0JD?=
 =?utf-8?B?YU9teHgrcVdMQXp4SDlYeVk2OCs4L09aZ1RBMzFHR3FDejdxL3p0YXhYQTBs?=
 =?utf-8?B?bG14Z0NyRzBIRVhLcmR4dHFZbkxNMHdzaHJybXNEejNYMTh4RVNhZldLSWtG?=
 =?utf-8?B?T1JHRVB5K29GQUMvUlF5K0tBSjBHZzNpVFpBN0R5a01TbmFabnVuRSs5d0pM?=
 =?utf-8?B?Q0gySVdMQlQ4WDh0RlNla2JPZCs3NFgwNzhYNkp6RGNJbmU2dEE3WU10M3hY?=
 =?utf-8?B?M0dKQzg0VTZpbVlvS1V0MDN5OWNLeXNpWTZ2bXBzYjErNEhyL00xWmt4bThN?=
 =?utf-8?B?YVYwbXkrLzJlNm95d1hWcTBBdkZXTHNpT0owQkc1ZjRRSVpqcWhOL1h5VERB?=
 =?utf-8?B?TWtCSEl5dnVuQ1hFOXFRQnV0ZDNKc3VaNG1rcUx5cUh6M0pBUUxodS8zMnV4?=
 =?utf-8?B?RzdJcFlKM0pGays0cDJGeDVPQzJ1UHJpbzE5c0ZMY21sQXRxTTZkYnVYQk9u?=
 =?utf-8?B?OFlkSjBRT25mTHdMVGsxMVF2U3lOQUtsNmU4MFNSbk9JeTh1MVNTRGRqcHBa?=
 =?utf-8?B?S3lFMk1KTE5TbEhpZzRxQitKb2drYjdmUyt2NVFyQW9DVCt1eitUdGNUUnYx?=
 =?utf-8?B?ckpkUit3TFZpT3ZTWHR5WHhocWFRVE5XZWFVMDVIcjlhd2Q4c2tES2NSUmxw?=
 =?utf-8?B?dGpmV3VhaDhDbk1FVUM1RVhjdDk2bHNzcFNjbG9FczM2ZzBoZW1Bb1VmdUQ4?=
 =?utf-8?B?eDY2SjNkUWltZW5EY0VmUkJicldIRjl3TEhkMGdVeVVKU3AxbGdWeXY3RUNJ?=
 =?utf-8?B?d3lnQ1hYVUFodEVPajlQODRCZjZDT1pwWWlETG1jNlV0Q1pyelEvVHh6K1A3?=
 =?utf-8?B?azBCbmRTL2ZsYzk4SmVyc0JZeSt1MkpkTUg5amdJZ3dzVGt3UlBKY3lxcXZi?=
 =?utf-8?B?NTdzMklQbzlZUjZLNG1nSFk0ZjFYdXhoSnFuaGtLNnhWYkQwa0RLRlJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRlQmREb0tRaU9sK2NwbW5UcDJUcEdBcjVWMk52eUpWai9EaVU5L1dMNEVX?=
 =?utf-8?B?WVpMdTFQa2ZDbUp0Q2lxU0hQc3NVYURIUzNDMWFjY2dqbWpEMlVOdzg2elZ4?=
 =?utf-8?B?T0xTbXFGSFg3a1BsRzNSeGpDa0tXZ0x4N0hqTGJyZzdOaWlRSnlMbS9HdlVS?=
 =?utf-8?B?b0NNSUZFblNnVUxHWE12dFVKNmx6bkJwZUdRbHh1dzlKTFdmVitXcEpDdWFn?=
 =?utf-8?B?MXNuSG5wSWpDVlZjY1ZFOVlzVGU4RVhrSThTbi9DcmlVa29WRys4cVpxOXdq?=
 =?utf-8?B?czRQYmFWb1pxcWpWeE5Lb3I2TzdtL1hrUktDMndpbzZaSUlReUJMQVJhUXlG?=
 =?utf-8?B?aVd4TC8xSkZ3WW5ZQndPemlYT3N1SFVPQ0xYTmdDWHJ0VnU4bDZRcFNVRE9L?=
 =?utf-8?B?QjBhVVo0b0NUR3RZRXhzMEd2N3VkUjRtVmkwdUFWMW1OODhGZXd4T2ZYbk5s?=
 =?utf-8?B?cEhjSU5Rb0xncmdwM1p3dUJxRUFRcFBlMEo0SURxZ2xMaGRTU0RmbjB3QkQ2?=
 =?utf-8?B?aWtHQjNhRkZpTFJOa1I5SFgzOW1sN255QVBubUFLTGdoUlBSNU5TQWhaU3RS?=
 =?utf-8?B?aFZOdGsxaVpLMkpBREFzSE0zV3JMWGMvemV4QWZqOThQV1p3V3ZsNEdJeG1h?=
 =?utf-8?B?M3NqVFNkV01vT1NaaVJvSmVreXVQVnVRaTd5dW1KTy9oQUlIYUxuVzc2YzN3?=
 =?utf-8?B?SWVXK3pCZXZEc0NEZkE2cHN6cnEzTysxSU4rRE0vOGc3ZStjTVZNYWlmTkp0?=
 =?utf-8?B?dk5QM0IyYUlGQ3VQT0FSdHAxR05XZmREMkZTaWtoeGtiNmd3aDkvaitWWTJO?=
 =?utf-8?B?ZzhjUDJIMWtLcFg5NGpONlV4WHZVVjNpZ3N4SFpBTXJtckRBNVpxWk4vVWRX?=
 =?utf-8?B?aGQ3L2dUeU1maHVUSlhSMWlFU1R3TEkrMDdXZ2hPME5GRnhkb3l4Z0VYUXRt?=
 =?utf-8?B?UzlJUUJQS1IyNUM1TnFVUUtyQjFsRE9xekUyUXRhb2lQNHZNay94ZU1lZ2p6?=
 =?utf-8?B?LzdueGV4Q2JiYktXVFdoUzBlL3YxcFMva2NKckJsdlZkMlV2c0czUFFhZWUy?=
 =?utf-8?B?bGg3dXhJR0VKbHROa3VUUFdYYVFscVpHa3NMN0xST0lXTG04em1FZzBFU0pW?=
 =?utf-8?B?cHpVNGVwdHlkR2RlbHFFNzZqYmRwRDhHTVMzZWhUcmhmQndDNVgzYVg5OThL?=
 =?utf-8?B?UkdsdGJ5by9wYm1pT3pTM3YrSm1CYWdNOHdkUHdDVXN3N0pXbjJiYnNUbkx1?=
 =?utf-8?B?NWNYQ2RiSkhweTFZL2RYUE5pMlE2WWRlQVE1enN6Uk1vbmYyZnhqbUFTb2p3?=
 =?utf-8?B?aXM2ZnE0SFQzRGo1TjFPcTljSXFVZ1QyaktweFV5SHRYcXdTR1N2QmpoRHFj?=
 =?utf-8?B?bzJNcVVjbFVoQTdGVi84UTgyY21YSjJkem45UFRBZkVzNy9GaHVRYmkvVVc2?=
 =?utf-8?B?c2VleE0vZUJtVE55aGtRdFFKQVdoUHJ2LzRTbTVwY3dWem9lWXViK3lGSGVP?=
 =?utf-8?B?NE9iWEVUTHZQMVM3SlJja1d5RkhWSE9oYVVab1hPN2xnUzVHSFgwMGc5aUlx?=
 =?utf-8?B?V1BIZTZYYk95d0c0ZjV2Wlp0VjhWaVBLWDE1ZjRlamp5ZUVndGVLYjAwa0sy?=
 =?utf-8?B?NTdKTGJIZ2xDdHpkVXgxM1RTVGVkZWNNQnZmVWZrSjBKd0xmeFFSUkZEWjYx?=
 =?utf-8?B?R2c1U1pTZjdqdktsTnRPNzZ0SUdUQkRyL0ZHT1BtVHI0MDhiOFZ1ekdMV0Y0?=
 =?utf-8?B?SWJ2VDJDVGZFV1pXTjZIUE4yRmVXV0dKM2JSUC9vWDdCN29MTXBxN2lveCtx?=
 =?utf-8?B?NllTazJ6OEhiUEloaW1xK010TjBSUFNTMHFFWEt6VzIrSks1TENoZmF1cUtN?=
 =?utf-8?B?d0NlOHZRcDZ1L0NYL1l5TXExamcxbUV2VWtnTTRNUjhWamhNSHFwYzNZNXBv?=
 =?utf-8?B?VUZIQmZjd0NBa0FTSTBmNkZDNTlrRGJkc0ZiTkI4aFNRTi96V3BTQmNIQlgy?=
 =?utf-8?B?Ykszd2FvU1V0aGt0MHRqa1BIZ0dSTFNtTUVyR3BSOTUyR0QxTjd6aFVvekk1?=
 =?utf-8?B?NmlCUWlPWkw3QWJxWWFlRkdKNllJWDg3THFmVVU3RlYrUGNRNjRoNkhNa0FG?=
 =?utf-8?B?RXhkcmdpQjRYcjZzazMyaytZODdBVzVFN0hYYnZpNjZPcklJMmRza2ZLaWpk?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QoInbUIJMRVV/ZmfY9hZU9hU01pAdICyn0pwl/ESv0eSkVNe8yFzmuie0EQxzZUDaEb4LOQ7StLssmejCXAeqsr1cmFwBWhES809AnxxSneire6XioAwEWJrvr6UyEwRlWOFTSUZYpaN1stC9w17o83WYvhqam6a6CssZUi9zNFg/WD3rThp2ntUtuPLGfdJ2XHfc++8hW72ydmuHyDiatvOV1/N2m+AwV4d4pXuvellQwfdpVHx0/xwFFZfGnwjjQhFQ7N5kx/kHTvKiCwpg06Gs4m3SLrD2SyjYf82eW20mW+x/wZPswsqHelVdMWoD4uEuIICIcUkF+DM7fPgBgjVTckwPkeKWA1LF6428WYHZpfHseKt7wPKqMHsjk1MHY6b2GNDTelaV5fh32itBIBNR9kDWd9g9NrPKAGkQeUiJIbsvloYLed0hqEue7xy/X9Eyz3D3rUsknE+YatzJ5T4UhyC9sDb1XWkGg9QDq6X0X1wjBFCYutbpuQkVZPFHyGBlpyf0Z0+Q2abOfEJe4RvtBiqsL3hi+udZehjVr5G0dURyvZ0wUQJRIVAd9kLmLQf1l/dhRW5991/Q5fdeDILRqkeVYnXL4HJdxd7I8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dbd9e8-145f-4685-5561-08dce7ac5ea4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:17:48.9302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8klf9gwFPDFMIml+L3bZjUEDmq7FM6H9D/mic9jdAajChar+UuPIo7DzvPsSFeyUlrL8TwYNAxgUXmRoHbO9vhK8Lfh8efGxQ3K/aqQ6pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080096
X-Proofpoint-ORIG-GUID: wjiBUFr4sWmvVf2VSBnrZqhs6GW1D6Id
X-Proofpoint-GUID: wjiBUFr4sWmvVf2VSBnrZqhs6GW1D6Id
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/7/2024 12:28 PM, Peter Xu wrote:
> On Mon, Oct 07, 2024 at 11:49:25AM -0400, Peter Xu wrote:
>> On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
>>> Save the memfd for anonymous ramblocks in CPR state, along with a name
>>> that uniquely identifies it.  The block's idstr is not yet set, so it
>>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>>> creating a block.  QEMU hard-codes the length of some internally-created
>>> blocks, so to guard against that length changing, use lseek to get the
>>> actual length of an incoming memfd.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   system/physmem.c | 25 ++++++++++++++++++++++++-
>>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 174f7e0..ddbeec9 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -72,6 +72,7 @@
>>>   
>>>   #include "qapi/qapi-types-migration.h"
>>>   #include "migration/options.h"
>>> +#include "migration/cpr.h"
>>>   #include "migration/vmstate.h"
>>>   
>>>   #include "qemu/range.h"
>>> @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>       }
>>>   }
>>>   
>>> +static char *cpr_name(RAMBlock *block)
>>> +{
>>> +    MemoryRegion *mr = block->mr;
>>> +    const char *mr_name = memory_region_name(mr);
>>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>>> +
>>> +    if (id) {
>>> +        return g_strdup_printf("%s/%s", id, mr_name);
>>> +    } else {
>>> +        return g_strdup(mr_name);
>>> +    }
>>> +}
>>> +
>>>   size_t qemu_ram_pagesize(RAMBlock *rb)
>>>   {
>>>       return rb->page_size;
>>> @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>                                           TYPE_MEMORY_BACKEND)) {
>>>               size_t max_length = new_block->max_length;
>>>               MemoryRegion *mr = new_block->mr;
>>> -            const char *name = memory_region_name(mr);
>>> +            g_autofree char *name = cpr_name(new_block);
>>>   
>>>               new_block->mr->align = QEMU_VMALLOC_ALIGN;
>>>               new_block->flags |= RAM_SHARED;
>>> +            new_block->fd = cpr_find_fd(name, 0);
>>>   
>>>               if (new_block->fd == -1) {
>>>                   new_block->fd = qemu_memfd_create(name, max_length + mr->align,
>>>                                                     0, 0, 0, errp);
>>> +                cpr_save_fd(name, 0, new_block->fd);
>>> +            } else {
>>> +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
>>
>> So this can overwrite the max_length that the caller specified..
>>
>> I remember we used to have some tricks on specifying different max_length
>> for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
>> host so the size can be bigger than src qemu's old ramblocks), so that the
>> MR is always large enough to reload even the new firmwares, while migration
>> only migrates the smaller size (used_length) so it's fine as we keep the
>> extra sizes empty. I think that can relevant to the qemu_ram_resize() call
>> of parse_ramblock().

Yes, resizable ram block for firmware blob is the only case I know of where
the length changed in the past.  If a length changes in the future, we will
need to detect and accommodate that change here, and I believe the fix will
be to simply use the actual length, as per the code above.  But if you prefer,
for now I can check for length change and return an error. New qemu will fail
to start, and old qemu will recover.

>> The reload will not happen until some point, perhaps system resets.  I
>> wonder whether that is an issue in this case.

Firmware is only generated once, via this path on x86:
   qmp_x_exit_preconfig
     qemu_machine_creation_done
       qdev_machine_creation_done
         pc_machine_done
           acpi_setup
             acpi_add_rom_blob
               rom_add_blob
                 rom_set_mr

After a system reset, the ramblock contents from memory are used as-is.

> PS: If this is needed by CPR-transfer only because mmap() later can fail
> due to a bigger max_length, 

That is the reason.  IMO adjusting max_length is more robust than fiddling
with truncate and pretending that max_length is larger, when qemu will never
be able to use the phantom space up to max_length.

- Steve

> I wonder whether it can be fixed by passing
> truncate=true in the upcoming file_ram_alloc(), rather than overwritting
> the max_length value itself.
> 
>>
>>>               }
>>>   
>>>               if (new_block->fd >= 0) {
>>> @@ -1875,6 +1893,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>                                                    false, 0, errp);
>>>               }
>>>               if (!new_block->host) {
>>> +                cpr_delete_fd(name, 0);
>>>                   qemu_mutex_unlock_ramlist();
>>>                   return;
>>>               }
>>> @@ -2182,6 +2201,8 @@ static void reclaim_ramblock(RAMBlock *block)
>>>   
>>>   void qemu_ram_free(RAMBlock *block)
>>>   {
>>> +    g_autofree char *name = NULL;
>>> +
>>>       if (!block) {
>>>           return;
>>>       }
>>> @@ -2192,6 +2213,8 @@ void qemu_ram_free(RAMBlock *block)
>>>       }
>>>   
>>>       qemu_mutex_lock_ramlist();
>>> +    name = cpr_name(block);
>>> +    cpr_delete_fd(name, 0);
>>>       QLIST_REMOVE_RCU(block, next);
>>>       ram_list.mru_block = NULL;
>>>       /* Write list before version */
>>> -- 
>>> 1.8.3.1
>>>
>>
>> -- 
>> Peter Xu
> 


