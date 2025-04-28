Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC5C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RCN-0002sS-Hf; Mon, 28 Apr 2025 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u9RCE-0002rj-St
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:19:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u9RC7-0001r0-My
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:19:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFq5lp029477;
 Mon, 28 Apr 2025 16:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2tyrksjbLGuB9463yVWqFAT60K1axam3gyDOCHH4u9o=; b=
 mwfbCilCUoyQN/X95lL4y9opOQFzHSu4HRc8plo7gmwud4puXdrvC9JlKyqvA7CH
 JMU3YlvfWCwdnkVwCT7VC3NCHX60ywdTjT9E1PKn1yDlBjLP4cABxZbAiwS4yELB
 ZRYPWarj40CrvtGpylUL28jsJOmS3l5fX7rZ9DNtedFdO2hbITK8szc18Fy8BL/C
 smClHiyeW6n8+mpZGmo5iqIntZVgzT4VkWZJZGPcSzhM46CQF6WUnzqT5Nx0kH2+
 BgpFhPQrT/JKwpHNsKkBeHHLZBeSgl4V3I6+QzU/eP54+DHF6pMNBD5tEI9c5Eym
 W3Rr6sH4spGCuEaTxeaxKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46acphg2sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 16:18:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53SFFcsI026672; Mon, 28 Apr 2025 16:18:51 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013061.outbound.protection.outlook.com
 [40.93.20.61])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxevyhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 16:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKuE8K9xX8GGC9Gq82AI+Ah/gr/kxylWlpAwEUL0W4xgrstw/XPXy3OY8U4O3LXCHmLni18ZmGgnUkEyYyO3aUWajY9m1bKIdLBKHrqzUXEJtMRrFV063fKN7O4ZRgIpb/06QqzsAI623SztI6xXQDkdZBPktJUDcTwfSQ8hEjZxEAslbHIE5h/rdpC1K6zwX7cs5VCyJThKGX5Sb7Mgwu02hclcC6AWosi5ucGJ0YEvSH4JBUP8Ys/S2LqCPu3+zuZJjFvZgsznBlrpuUltRlYe2S/N7LHv8OgM9jMrq/Mz/5AzndQ7jwYRi/YGUlNTj7WsCPv7a5/dX8t/d2zeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tyrksjbLGuB9463yVWqFAT60K1axam3gyDOCHH4u9o=;
 b=M+F8fwIqfeSccGAK6iyjRhXol7I8QnBUl4r1AZm2w60nSmCEys1IzxqFWhtUf1B91x05FMLOvluBfWX46YBi4fhVnlwam7TwLxQtGXfzl9mT0VS7ux0o3JhZcxXED9fs6DwPsn6OyYrb6GmiGF/njP6KWlENkCYcmqOa4VWtKHpzNn6uqGy2QQtv4/9Gboy3x1FdxjZQUNYNfJwv0DhH3/1oQosXvkPCqXO4gIPTcmBWmjYc2xP8MIvPwXjru1aslUA8n6iVQ0DRvDE8gti5QMS/wNPLJdn18dK+CqvOH9dUJ6USBHcctQJbVgdWasJcYR+S3zH1UJ4A+nmuhwmRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tyrksjbLGuB9463yVWqFAT60K1axam3gyDOCHH4u9o=;
 b=lADxP9yuMtk4cfqfw7ym+tctd2LOqFBvchKlOojFJ87u5sulriybElKR1QgA10EBD0Bh+8+4fdDamPZ7qcRkdLK7DiVt9s2AeSO/PXxwCQV23gJFLAm2UwJbkdnJAabnlVkCl8D3jb8Mw4khQ6dn3W1C2SFIplZ6UUG7yStg/3I=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7857.namprd10.prod.outlook.com (2603:10b6:a03:56f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 16:18:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 16:18:48 +0000
Message-ID: <3c5e9e8d-a3c5-4179-800f-2c11d38b7b02@oracle.com>
Date: Mon, 28 Apr 2025 12:18:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/6] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87selszp8o.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87selszp8o.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:408:ff::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 37606ec0-0a0e-4f4c-4bba-08dd86705b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OENTM3FOMVAwTUdaRmhYT2dRb0l5dVVoRHFmLzhHK2Fjb2lWYitSSkJ2WlZy?=
 =?utf-8?B?cnJPSzJXSUVKTU4waUlRTnhkcHdHSVk0YkdVS2dpdElab3B4R1hOSGI0aXpl?=
 =?utf-8?B?SkRPdzVlMVFEN2tuandWbEkzUG1zQUdWOFdnTDZQSUMwTjJaMVBlazg1QkRC?=
 =?utf-8?B?TEtQV2xHU1l4WDM2QXh3eWdaNS9vMmVqMzRlWGZ0Rit2V3pRWE94ODU5VlVh?=
 =?utf-8?B?dnQrc3IvNnExUiswcFZxamN4RzdEUWdleU9XdGZFRDZuUjJiK1crOHZ0MzZw?=
 =?utf-8?B?M1RRSmN0ZU1PQ3pTUXg3T0RZT3BxbVdwc2JDcWx2c2RUZDhWcG5Vak5MSGE0?=
 =?utf-8?B?OVNaL05NSWNFa1RqMUM1aFdKa3RvMTNDOHFQaUhGdmo2cFczK2xhRzd3NmNE?=
 =?utf-8?B?Rm04a1dLR1ZQYWtiUkJLMUVWYU8zNnl4V2ZJdTh6M0xFRldrL0NXendxNkVS?=
 =?utf-8?B?ejAvMVBTS1RrQ2pHVG4wSExucWxqb2pkYU4zYWtXWE9TeTJBcm9KQnhZTEdG?=
 =?utf-8?B?Z3JhTFFNWWlaeDQwMVpKTm11dlF4amVFV2lTc1hxeW4zWjR4QkRSNEg2MWdt?=
 =?utf-8?B?NlZ0SEV4cUNSYnVDZFU4S2piaEhZN1JrQUJYZGxybVB0RVFYNkZ1djQrS2ky?=
 =?utf-8?B?MmhKTUVQVnBzS1Rhc0JuMzRxSitOd3ByRFVkblY2cnlEcC9BK2lNcmhybits?=
 =?utf-8?B?SzJoRjBvVUtGbGgzVmVFT3lCME5PSTRJd21LcnBQY2gyTE5ST1Q0WlRlWW5D?=
 =?utf-8?B?bDVDbTJQc0pWNmorQ3FtTkh1dWh2ZFFCTUlnaUNiRy9DQ2kzYjdJejFLb0lt?=
 =?utf-8?B?WjN6bmwzK0thMXpLZGg4aFdmeW9ISGp5YnJyMlVESEl4S002dlJVdHYwS2ln?=
 =?utf-8?B?cEU1eWtURUh3eGQxOW1LZmU4QnpURm5mc05GYkxzdk1Uek50MkZLK3VJQ0Z4?=
 =?utf-8?B?U0pCc2ZxL01vckVEcFRUbnBrNCtia1Y0TEJCS1lja0wwbHZXZ2NSUklabXVp?=
 =?utf-8?B?NStmc0VpeTlmS25TeGVDUGtwcUNJRTVmOGFzdWw4Z1M1Y3V6UXVMdm1zWng1?=
 =?utf-8?B?NzBaMTRwM3V1NU80aDlocDRwTEVwQ3lmd1oyWVdOSEVmOCttR2xxa29tbzRN?=
 =?utf-8?B?MGgzdGdXb2dPeTRiSXB5dnEvMlhFNzZSdGIwYUt2ZW5VVm9EdjJRMGIrMTF1?=
 =?utf-8?B?bUt1UFNDUVRjeUZnVlV2MU5id3YrTXNDUzJFT3paOGJkOU9GdDZITHVSZU0r?=
 =?utf-8?B?RUV0L2pMRExqS2ltOCtaMzRZSXV5cmVmWjloZng3N1VGNEYybmFteHlWUVVV?=
 =?utf-8?B?Z3VBeFJMNEw4d3dtZ2xWQmhiWTRzK3hFdEN4WXhQeHRlL0NObUdoTHlaTVh0?=
 =?utf-8?B?R0J2Rk9EUy9qUVBwWTFyejRPaWpOdGV0dmJBaHlrMXJCOVhYYVBHNEowTTlR?=
 =?utf-8?B?aUJFcUVvT2Z1WCtlQWtPWDVzMnhPdlhhZnp2N2hIaDk3SEVONnZNSzByYzhh?=
 =?utf-8?B?SFhZVVFvQndMN0hwa0dqaTR1UTlITFJMVGU1MlIrWkIzbDFBdlRJQTNtNVVI?=
 =?utf-8?B?YXB4ZWRZeDg2MjZKbHFRZDJaQTVZWUtYLzdCRU9FRHN6VHhSaFpFUFNZSkdZ?=
 =?utf-8?B?bE5kZFB1ZWRKTko5VE9mTkZ1UWhxMWY2Q21TdDBBeHpJMUE0dkV4Q0I2c3M0?=
 =?utf-8?B?enpOSERaVHlJaWJEc2laZFB3bnJURzhvVnBCWFR6clRCbTJOOWZiVFBpTmNX?=
 =?utf-8?B?WlR3Q1RIUWNpWFZzUWQvOUoxR2lSNFlvOWxBUGxqa3dlNG9vSi95MTYxS0ZM?=
 =?utf-8?B?ditRRC9vQlU5UnAzR3d3VFpRZnlKd3J6UWNpUTZtQVBnZTZEejhXUXlldjRZ?=
 =?utf-8?B?K2VRaWV3TVV6a3AxQzMvQUJzcXpaRTZhTEZ1Y1c2Qzl5eEhaUXRvY3ZOaGJR?=
 =?utf-8?Q?0SKDazjojr8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NpYngvTkxlV0txbmg4VnJoMEhKMGFPZGpNTjV4Q29sbWRzMnBhdStQUG9J?=
 =?utf-8?B?QmtCOHhST1gzSGlHVzNHeENEdGNIQnZZOVBLY2tEMVY1YjBFWHdRM3R2MWM2?=
 =?utf-8?B?QW0xVWJPN2U2RjFUaVd3V3pVU3ZJRUZaT0ppM1FpL0IwdkpyOVh5Vys5MVZ3?=
 =?utf-8?B?NHQ4SmpHWGI0WmVBL0piS3VkdUNwTVU4dVlPc0FPaEtnU2xtNzBSZU1KMEts?=
 =?utf-8?B?TGh6OWhOUFVnYWdnTnFMRXM0Vit0UEVsMWtmdUV5M1BaRXQrczdOQld0TWE1?=
 =?utf-8?B?NCtIbGRBS29UczVGSVIxb2pkc1lScXIvcndZa29wMVBUK2VjZ0pLTVRsZHl5?=
 =?utf-8?B?ck1QbVk2azNHRkx1Ujc3Ni94VTFuV3UzVnNMRFRWV3p0MW1xbjYySUJQM0dD?=
 =?utf-8?B?ZDhiMXBjRXJYR0VJRVRxUEJ1S3VEQ3B3MWtkdW41UFBva3kyY1dNK2R5aEhz?=
 =?utf-8?B?d3piaFlFMkdCYk10TnpQK0c1VGZldGhnaTA2OXYvZDBLSGR1QWR4elZPaFRs?=
 =?utf-8?B?WHd6NUpSY1hINzR2MkhvMUg3Vlo1a0UyUmJjOC9uZFZXZkhpWnZnaGRVT1lE?=
 =?utf-8?B?TFVKYzdvWHYrSmtCcnM0N3A2bEN2ZmZsZE04NWhUKzd1ZG9SQmFMU0I0YjRu?=
 =?utf-8?B?UWhndmtWNkc3bzQ4cXZlRDBIbEJCT0hwWWhnV3BYc1ZxOGdrTnI4RlpsaEdF?=
 =?utf-8?B?L3FCdnBSbXlNYWozS016UW1rU0FhemtBMjF2MEo5NTVtTEREUmpJcHdEcXJl?=
 =?utf-8?B?bHBqNTFzVERJc1dLNUl6dDR4aHkxT2duaXVya0NvbWtWRy85V0srSkt2ODJE?=
 =?utf-8?B?bXo2L3g4RG1lbzRIbmxnaTJ1d1F0SzRDL1dadEQ3UFdrKzhLVUxKNlRTRG5P?=
 =?utf-8?B?WFdJdGJ5ZmZzQ2syNTg4cUlsd1lLMjRrdXFsdWRSdjJiYlBUb3JIaTl2VmNL?=
 =?utf-8?B?ckVlWUVQQmVUbnNSUldCSm1ETStMYXd0Y0VLbXNXTy9Ed2J2b1FFckVnZ1VQ?=
 =?utf-8?B?VCt5TWFjYlZTNHorQWxqRXoxZXUyejZEL2RISHZrQ1dJTmplUEFsbHRWN2VG?=
 =?utf-8?B?bGJjOVNlT1d1RVZaTjgvK3RScDZ2cXplL3pCTCtyR21JUzdGTVZveWZ1VXZU?=
 =?utf-8?B?Nzhwa0F4QzFzclB2d0ZyZ0JSZVp2cmxtMG1DdjJXMGIwckQreTRCeFRMKzNU?=
 =?utf-8?B?cjd2R0xxRWdBVGp4U2paT3hHWHZjbEFDbE5HSS94UUtkMlRkNnVTaTE4SWF0?=
 =?utf-8?B?ODNaaFVjdUFPM3orb0lydG5nMWdUL2lPSU1KWGZXOXpxeE9CS1hkTkJ0dFZ2?=
 =?utf-8?B?V3BPZm9wckZpdVlEK3paNGt5NTU0SE5rSVRZK0paQk5GK3JsNTVSRVUvcGhJ?=
 =?utf-8?B?Y0lrcm1kdkhKbGp1RW1iY3JMZU8yZFYxUkZITTkxTEpLTGRIcDFBT1E0S3Zk?=
 =?utf-8?B?M3ZNL25Ram5HdHBpY0I0ZDM4Q3NQeFFMb1FHMHBtaC9QQzhvZitiQnh5K1pv?=
 =?utf-8?B?VzZmT3RZSlFnTVR5NnE4WGNhK2tUNklJeW91Mks2VDN3Nk9wN1lhUzQvNTM4?=
 =?utf-8?B?WkM4YlFOUXRlMy9JUlVaVFVwaVpHdk0zMlEvMmxFNUlCRk4zZG1OQVU4aUhF?=
 =?utf-8?B?OXhNS0lmcW51d0JCeUpacFdzNHEwSmh2VkU5VC9lV243dHIrL2I3QUJFdktZ?=
 =?utf-8?B?cXR0YVg3V3lmeGFSQ1psR01vdnJOYUNEaEJLV0dGMUx4aUd4MUVkR2FvSEVZ?=
 =?utf-8?B?U3dmSkd2VzhTYzBkUE1GWTJCNjY4L0lydnJ1V3dvMjljcUJqYjZNNkp6L1lI?=
 =?utf-8?B?WkxHdDd6U1k1OEN2YTlJUGlaWjNWMkdKVGYybjJIWnUyaGRQd2xoeElKZjcz?=
 =?utf-8?B?YnBOOENWQjF4VHBMUHRrNCt1bzE0QXdUK3ZxTXNMWEFpL1owRU1mRFNFdEF2?=
 =?utf-8?B?YzZFdXRhQTlTaFlsWE01ZmUyd25SWHhJVkt0Wi9yNXhNOHNHTGVVMWVMSWZF?=
 =?utf-8?B?Zno3UE53cVExZmppcFgxZkxyS1VzbUMyUHhRSG56WEZXdnpiY2dMKys3bEtr?=
 =?utf-8?B?TjFVNDV5d092aW5HaWQ4UXhXaVBKOHdBYkZVVTkyNGc1aC94VzJGb29hZDgr?=
 =?utf-8?B?ZWFaQTJ0OXFxQVZaMjJGcFJLVDBsaGx4azVZbnVtKzJxbTJNcnJaS2lzMVpB?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lAVVGY8Vgd9VHR3X3M+zWaBMdn8eZ4pxHLSxl7xkGTTS1y75KaAzZV6xpwHPQL+AJuI4iYOlnd+c05Ig9d1ok0aNuNeTRgr8j4cm/9/H0yypd4sB+l8HSzJmpcrLGq+1pwuhAW/DkP1uCr9z3c4ruTaq8aakeWdX8rW/is0TyrZ2KWjr1smUKaSDy7D/GTq5mtj40MgyBcUf0NBlWrQ7/7SUGmiNKK1UfBq33FsagD/Kt3C3FXoeDFRUCj+7RKkJJBXadhRGoiKIh2cl/n2awvxOsdmtp+c3Y0fIYLMdP79fZzjYTiR0Co6NgmPzfCjilQBLYLo82DAeHxjLh0bZtk1nfgJKc30Va237f4s0k4plGsV1G2n/YQabtT4+9d3r0d6by2U8ro1LmfbvlQS4NSfgWjq6OmM3KWtCbGLT1vOsqbg6DEzdhunZ4xfV7xRpewa6CkTyfaDLMySoLwvBWu+ZqHzjhfYNOATMT8s/FQ9ugiw03ABpePFMAuwOe1aR7IfJktTDxoTK1ZHwemXK31h6YHrVzDAJ9nxBznDAs0X/onp88oAHgkAPRc/9MUXYDEWuD90eh4xc58uitCDsy0Rahu3KxHdDPOVP/St4sDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37606ec0-0a0e-4f4c-4bba-08dd86705b3f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:18:48.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ2S6OyU8j5sBf5v/31UV0bs2r8GZ4k1YhPm0Rp5U0K94jlYBpBRC8fbGS8arMHD58TrS+uOFgjMwEcG/GtjG2l3cDSSiV45SawvoehnihY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzMyBTYWx0ZWRfX/izPZVKLcacW
 fQies30Lu1ojWCnFgVoGWk++62KI3e6aE4smOBHQFcl398z3igyNW76IcsPdTjQV5+mu1EpsWkC
 R2KsZVGSmsrknRfMDf/NbUcwW0c/mkM8JvvkzGAWgAaS10OzyhtNkt0CnpFvxGE1ylGExoBrUJw
 lTK8T+0CQFGqwBECC63uO4080AOopXDeASz4UDSVAOWfp28/mtJqzldYeTG5ik6S6GeD1fuoaXL
 PBNQP1+pG86ko/kpSdFaQYm9BmottM+sDo2yKioqPjysl/wmUgMnVV6JgsWillgdrFo9mfnxFvq
 xSXyopQq3a05KaGcaYINBa4zhICZcAyOIJ0hz22WdH9Tdhl9RTqJzC9IO6Q1B2B8JLgyIxRPrsz
 bLmcZVhg
X-Proofpoint-GUID: rkqMQeWRrgiHyQCTlJCb2avZn1Mm3OT4
X-Proofpoint-ORIG-GUID: rkqMQeWRrgiHyQCTlJCb2avZn1Mm3OT4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 4/28/2025 4:04 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>>> Hi Steve, I apologize for the slow response.
>>>
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>> start up time.
>>>
>>> "Some managers"... could you name one?
>>
>> My personal experience is with Oracle's OCI, but likely others could benefit.
> 
> Elsewhere in this thread, we examined libvirt's use qom-get.  Its use of
> qom-get is also noticably slow, and your work could speed it up.
> However, most of its use is for working around QMP interface
> shortcomings around probing CPU flags.  Addressing these would help it
> even more.
> 
> This makes me wonder what questions Oracle's OCI answers with the help
> of qom-get.  Can you briefly describe them?
> 
> Even if OCI would likewise be helped more by better QMP queries, your
> fast qom tree get work might still be useful.

We already optimized our queries as a first step, but what remains is still
significant, which is why I submitted this RFE.

- Steve


