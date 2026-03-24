Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68B9F54ABA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52QE-0003jI-Dy; Tue, 24 Mar 2026 10:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w52Q8-0003ia-2Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:07:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w52Q3-0001VV-Po
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:07:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCBxYH3886408; Tue, 24 Mar 2026 14:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=WJQqTGMPx4cDLiLCK8/rz06brv3AiKbEo/oKi8++esk=; b=
 ajltrG3rn5vqa88AQquglOj7glvN691o9BYiAaOSeBllFJOqvfi4MprbkwgnoVol
 ZMZ35ffIC/Jwkk+uKoCOSxxv2zJOR7SlGziQGhAFMzstacUqYVfyk5eUiBhWC165
 4WVQLTV6dnPgvsMej0atmrX2fediXbkntDrF2H0vLFYpjNSmOeXvYFNHWD+lPu3Z
 +nZ5Hxmu2kwwtlolsM2y/pXnX7lG2fkmlJui0RjTvx5u5H5q3sejjIvkBR1dpQym
 eCLF0VX/tk6ZVhoLrsVQS3oXwoPBJ3eC6049VNov/fImyaWg/WLeBSpJ0j4zpd4q
 i095J1yXkJiZDRI474g5Ww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnm7gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:07:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62ODPTbE039894; Tue, 24 Mar 2026 14:07:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hs9pgbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXP2pvyxfMD7UblshcrsVnVbKYoJAhQnwaUoBkaiiAx90IaHzGJwFQu4sQqTb9PajdzMYtGOt01nufzJ7oWISNUUZhAVuwLI9iYK4dCdz8juyrP4q2blNPe8pYUj4Y3uhnVzy6rc8U/GJQXUemq0XB4RXrU4cXZtZ2tMJZaDx+vV8tZJVdRDmHScrBTkChvBBETIgVeuoNuwy8MKm2Vqv4hSG9vUMuWcoC17kNogafPHPtWV+3wgJ5F39gahhWJAk8vH9TdTRlOX8Ap+g93HJ5zaaggGymWOznEwVmznDVOAFEkklS4VdJpeQKknWBPb4DzpiYjO7p/is0Un9p5KZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJQqTGMPx4cDLiLCK8/rz06brv3AiKbEo/oKi8++esk=;
 b=PMiMpUK3MW6JFsugAFNiIv1Jj2YKxPLm5p6SJh3sEv+LDV29xTDLzLJyZrpXtVhHtHMRHHrn9PJFjxuS/OWzqPRz3o3a6iCpeX3JSAY1bc/SFxB32hGV3gRqqck8uyD5i8w3+2ux7thxNfdzpw5dn8unM+Md/7ySLwz/OmoMzrHqErwqgDoutBmtjp/v/XX0BmcFfGswLls7LfPPSyZ3ll/WFqX4WPpYeqb6uQG+aCXxzyC7Rhg6Jxd238DVgIOKT7vZzcFWi2muKqZU3b28qhEBMuLE0WyuyJ1n4ioDcRf5VdCgD9dEGpCzOTArmXAsDsO1bngqhLj7uY0JrYyFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJQqTGMPx4cDLiLCK8/rz06brv3AiKbEo/oKi8++esk=;
 b=jMXTM3FZt0glAs7oBRtq5U7si2PNLbVDBZ3VylpNuf4RNnqGsHrRXP3f2NVqHvPJ90jxoBSl0FlWfdhhV2GbUqRPZov2hAwz+txIXduvXb1+c0eM5N8lJPXjOQmCT6r4UABq5zxca5wLMcBSxruOJAimPQ5W6TGdYXuhz9FQikY=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:07:20 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:07:20 +0000
Message-ID: <cbe7eff3-179d-4bc7-8fcb-ab0ab805a46e@oracle.com>
Date: Tue, 24 Mar 2026 10:07:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/14] machine,virtio-net: add early-mig property
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-2-jonah.palmer@oracle.com>
 <CAJaqyWf5==jZxJErazeAea1NxpGB2SFNdpAPh7bi5tc69FytTw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWf5==jZxJErazeAea1NxpGB2SFNdpAPh7bi5tc69FytTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:510:4::12) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: cf62fc85-08fd-427d-f1e7-08de89aea9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9JMAy9NoLzXvAhcbYK/HdymSyytQz3VAyMB+7wgVY26lny9EymdZFupzoi8FuCmQDtkE/rKYxcEUoUaE+rxL8Iw75pia4qrPjYrjXpxAIgvoBQsHlAVnq1H8dBz+mJWJMMqGqzjkG9M9gXLmR+2A575B2g0C4rMmyl552rG1yWaAWTE0ob+E/0Opv1BS7zJMzb27wmp4pxE6HFrnsQ8+/ubQ95Ntugu149SfBonAID9Ual1Jpw5ywt8PT9FhohiCb0OT6OVkXwtbD8eBJTL9+fA2XZiSQnbC4weQSA5Ncno782UecMs931dh2zOdQAw7N689TRlYKJGAySJ9KgD/1VhHqgn5umYfNiMF1yEOVDdFXg/go2x47Q433fZ3JO5FlzL4DjYeLv+o+XtmfSiw95n3fCP4m1tMkmzqgy5IrBJGbNmcYY/ORy7vjnKggKGa7ocGhpr9YL0jL5VF9CeeZycimOiaNgXI6mg3nchLr/SuFD+WbIxw7ihAU0DGII/pUFofg4EBwb2Cd1kjWiXXpY4XFqS+USKbRx445vdLeXNvSndf/Vruk+l37z9Bu/++JFxY1m0SpYYDDjGoie1r9EIZJ83Ous4vhR7dbZ5z1BDV4RooW4rWu3+NJyY7pf6PfXEB6TrtlKRx9+HJ4GVNjQK+rv2pi926jD1vaq4DAn8EwDud6xUraS2F2ozims4F9g4p3lAHlUbgYbAAXfEz92hRMKaRP9hjno529V87No4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkwvOWtxMDJWRkgwM1JvcmFsVnVpcHhlRTZOWHBHZGprWTYrWDdLYXA2dHR2?=
 =?utf-8?B?OFIzQlV6WFI3WVdGTXVSUVBTTXlRdS8xbU15R3R4RDVSVHFuS09oMFVJTk1x?=
 =?utf-8?B?MXN3SXUvazZwanZDdm9qdHhGWnNYbXJTbkNMZW9ZYmUzaEdLOGxZaW9PbVZl?=
 =?utf-8?B?S3hvcFB6aFI5MVlRRkk0NWpWU0NEZGlZVjI3aWNTdHJEOTcrRXNGK2pscUNR?=
 =?utf-8?B?cjlScEJ0QmM0eFJiUHA3eENqOGs3cXdLSzJPRXRsRDJqMGhVTHg2VUl5RWx0?=
 =?utf-8?B?L25mY1EvcXhhNHluSmdDUUxaaDZlMUwrZFVvVk4vKzNZcDNOUlI5NHFQNlUz?=
 =?utf-8?B?MXEyMWNUMlk4cUt4RityNDVsOEY3bm5Oa1orM0grRFhITE5QaW1TY09TRUFI?=
 =?utf-8?B?Z25rWTlrYWFaS2lmVXVrSzROUWduZVNTN01heVdYOTA1ZThGdzJEbTdOMDZs?=
 =?utf-8?B?T25zWjZrZTFjeGRxdk8xOERVWmZxOVJJV0V5M3o0M0pFdTUvWmNuS1ZDOWJ1?=
 =?utf-8?B?WWVKS24yL0xGVkVJbjk0ckRtay9wT0YzWUpKUFo3SmkwemdtYStUNEh1U0JH?=
 =?utf-8?B?b3FFMHRNWHVKQzdLVWwyRnBkdUV1NEU3bDFHdUh1bUVoSUIzaUU0djMrUmtW?=
 =?utf-8?B?MXcyUGg3WDdzUmRZR21TNHYwVnZGOW9IRGxvbGZaK2NqbDd1bTd3Ym5XbjIr?=
 =?utf-8?B?Mko3enMzRmIvTnI4ampPa01SU2dmbGQzZE95YXBiY2g5bmxablpGcnE4L2Yr?=
 =?utf-8?B?dFhIbHh1MkViM2JHMnZIK3U0Ym85ZU0rN21Ea0xhTm1wajJBdHpVUUlibEpL?=
 =?utf-8?B?Q1NzMTBNMDl1dzZhQjkzMHZ5U2xCMXdyQ2M3QmZWMHhCYWlSaGdGOUp0cTF2?=
 =?utf-8?B?a1Z5bUMrSEd2SEl6Y1NNYzByRXRTcU5iOTZjUWx5dEs0ek55d1I1RGlZakw1?=
 =?utf-8?B?S1NNVGxQczlxQ3cySFFJcStvaWZFR0pLbk1FS2dLVU9jTmtJV0NoWGZkeEdp?=
 =?utf-8?B?dmNTUXU5Z2NKMDEzRDA2aW1VR04yYkh0YkR6OXg3RXVtSlVLNDV4YVBxek9J?=
 =?utf-8?B?ejRHakU2MEtjMjhNWERXZWlkTDlmVktRL25UQWVQcU1YRUFWSGJGeTU1VTBM?=
 =?utf-8?B?WHFqYVA4aGM3MVJpbG0rREp3L0lMUUxxSDdRM2VNVHFSQ1EwblRDV0dSRVVu?=
 =?utf-8?B?dXVrYVB6Z0Y2RVRvQnhQWjhzR3RKcTlOR0V6VmRNZE9sbi9DRE9nVDhIYWNx?=
 =?utf-8?B?VlltSVhPZlc2emJDb0RieUNSVzlUQ3cvMUtRTit0UjNRb3JXWlJITGQ4ODVB?=
 =?utf-8?B?alVZVVJ2bWorQXNqb1drbDhZZE5Hd1JmSVFqWllhL3MvMWxTQ3UyQldzdzdk?=
 =?utf-8?B?MWp5MXpZcHBNeFhHYlBaaENvb3hvTWlIaEE1Q1QyOE5rZUZLaG0zUjErb0JU?=
 =?utf-8?B?QUN0a3Nmc2x0eEtjenlSUFJ6R2ZoWUZrWnU1Ly85RWhnM0E2U1VHMHU1S0hy?=
 =?utf-8?B?VkErR1RCTi9qdGdURW1BR3pBS25SUnlqUnpKUE15U3RpVE5uMUdEa1pRQ2tk?=
 =?utf-8?B?Tm95bWdsVU5CRHZNQ0xESThJWUVpS28xNTNMTnVPZXd2K0VsZHZ1STBxWHhE?=
 =?utf-8?B?dDJYcEtzMjRYSy9mRktuK0tNOGtSdjJwdkpwMUh4V1dqQU5rWXRkOURydWpG?=
 =?utf-8?B?S3luT2R0by96a2VuMVl4dWlHSk0rV0NFMUQ0VHJFVGoraVYyY0NIWDR2VEhK?=
 =?utf-8?B?bXkxNEJqWCtyZERLdEVlUDJZeUJNdjRpZDZVbHlQWE9BQ1pMbUxqUkFwSnF5?=
 =?utf-8?B?QU9jY2RJWDFJQ2p5Mm8zTEVNa3h1T01hUE84MjlSYzFqTVZ2VTdCc2JJd2l0?=
 =?utf-8?B?dEZsYlVoRXJIMkZjcTJ1bElPZGwzY3laSVM3aXRDaUVtUXNPR1ZhT1pVRDRJ?=
 =?utf-8?B?OERMSDVXcWtZa0xnTE8yWmRKd1dzM0lSbnRnVHhnNkNOSERGdFRieDZKWUtw?=
 =?utf-8?B?K1d0WmpSTWo5NlBtZFdHMFNHdUdtUzZTWWViUm1mMFFRYi9VRkpYYWNvSmln?=
 =?utf-8?B?bEErTEJlQ2xIMThiTHhBVkVic0xNVDMxakFxSEhUdk53ZENQZVJRR2cvZ2hO?=
 =?utf-8?B?dXQ0ODNuR0NCUkQvTHpjL29WTjI5Ykxma2tQNGNUTDhxUE1mNEZvbE5ydjht?=
 =?utf-8?B?UmdBRTBMdldoeTN2UlJJRUlubFlrSmt3VkxiZUNhS21jWjBCL2MyNE9lc0gy?=
 =?utf-8?B?Nk41aDlDVEowRHVQWVQyL3lWMHRPSUZndzh4cVZiNWVyYVVvZFl0aW5QcFFy?=
 =?utf-8?B?M2thd2k3ZmlJaVQzRGtsL001ZGo4RHZWaytkRjRCd2hVVGx3QUpSdz09?=
X-Exchange-RoutingPolicyChecked: NXT26lpNVtIVqRPdp+ZL+37eSC5R96xLwCG4oUFomP4TCfhFgNTPUqhaedslqCR4EdfcGBFgfTE/tRsTC24UEtBZyZ30ZRcBzqxVypQXSvd/KGjutOpfB6vSAZK3hhX9qcjyFx2uXJ1pHD5DU5PzrEnx6OsovbFZv53EPYrkJzfEBx/cmD7k0jWIPyCIWfW+WjUqhBTdaDKR96Js3yBL/oW58vCR+KzT5GaeccTIZl9Z/7rhp4ag4dZRYc8ISI2mvWexwt9cYVd4JxZhHWPx6q5fQkPxwOQ5PzSUnOTh+u7XcRILgFz09OpbSblZFRQjDePw6aPXzD45jS7M4jkdrA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q7yz+vxvVa9B1J+eehTX0S2mI0MqfaNI/fE2G5UxBYxEqpZZ8Rr5AA4SfSktsTIbgb9tThUCYQnSbZZr7SMeEmV7L3juxIiqxBQXz4Mp3EkTNWt4lS1wGq8Wur73WG74gHmfWWoUULYKDPLQcltAmXzWd3Nc86IIVutLltQSbaz7A3iImpBJde7t62c786Z1LRFIIwqXevnw9CJzOtAWDVf4R298XojCgvGWbHlGpB6CKtsqp3NdZd5/gFgWdWC3ZtalQKoJtwc57OH1EdC/hrXLWwxme6w28GtaoUAHd6k0mWZyLyO8Fmak2ol07boGHncXJIEmclcnAZvPnIU15sNWVCbLd6/NOSi2RmGAGdFJYwmk92jlUkI54x1PnS9KdVWtQJFbqe99yyfP3vGMR+p3Tior2oibkHCwJl0OlVhoTlHNjyRMip07Q+68NZCeJJlAZ2nElrXmYyAu1wb+U4bZDaYPjhnStMYk483Rq9P/85eYDBc+9YPY+O7Ew/p4/JJl9e9TwLm9qAsvvfCgC4Po657orQW9P8E0n7Z+D02s1YBvZDShk3kmHsBpLShsMdPk9zMsry69wnHSqx14SNf80ze2f4UuGMhgaQmr4wQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf62fc85-08fd-427d-f1e7-08de89aea9f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:07:20.4245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UFxPZNc7EZu7VwE+nnVEZkVOsS9JbvpErcJlgfXs0tzA6Klo4wOMqwD2UlFRpdrm6+gkqPvDBV5acjWXza80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX1NvQ37LPJoVu
 12jE6wUxZ8M2ErcP7RhQn1rkqSDfFU3TZl7cEKS2BK6uS8V80vyhUcfbJqxN3/+mQQieeOiBiT+
 MlggpY2SFSSGPyMZebwyF6p40Y5Ph18eiUR2l2aDqpR6QTcFeExLpp7Yv22wT1gGP2/mm424GYo
 e2h6zsEOtJpW51McTciXYttUOrmAPIFV+Svty65sffA1ZHroqYCE6Lmf8u5LMBlG+jMrZPlMOKj
 bn1rnE3wePJTetWD6e5iJfDnnA2o1vavdIM/ZZONQeGr9W+tGaxEf2+pMQo9yeu2F4ZgFwJGviK
 SP69Ua93ibd2rQoTyp6Bio+UeCMooLCeSLP3Cx/hew6UtFU2HJIhqr/pRiHls2eLGrYghDJ20sO
 WcFsH4B0aNCkJbteGV1LzpnLZCBeKlAN20fqSeKEGWehNnW8gQ0V0lE/6zfKlr477wVm4C2n8gJ
 PbR4pgM0/xCuZj/JMow==
X-Proofpoint-GUID: hxjKcp5tAmgPWkFtBsb1TdEe_IYEzF4s
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c29a9c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=kXBxxdcygrCaJWKge4cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hxjKcp5tAmgPWkFtBsb1TdEe_IYEzF4s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/23/26 6:25 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:20 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Introduce a new 'early-mig' property that enables the early migration
>> path for virtio-net devices on machine types >= 10.2:
>>
>>   - virtio-net-device,early-mig=on
>>   - virtio-net-pci,early-mig=on
>>   - virtio-net-pci-transitional,early-mig=on
>>   - virtio-net-pci-non-transitional,early-mig=on
>>   - virtio-net-ccw,early-mig=on
>>
>> To preserve compatibility for older machine types (<= 10.1), add compat
>> overrides in hw_compat_10_1 to keep the legacy default (off).
>>
>> With this, machine types 10.2 and newer enable early migration by
>> default while older machine types retain the previous behavior. Users
>> may still override explicitly via:
>>
>>   -device virtio-net-pci,early-mig=off
>>   or
>>   -global virtio-net-device.early-mig=off
>>
>> Follow-up patches will implement the actual early migration feature for
>> virtio-net devices.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/core/machine.c              | 5 +++++
>>   hw/net/virtio-net.c            | 1 +
>>   include/hw/virtio/virtio-net.h | 1 +
>>   3 files changed, 7 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 6cf0e2f404..1b6c7db119 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -45,6 +45,11 @@ const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>>
>>   GlobalProperty hw_compat_10_1[] = {
>>       { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>> +    { "virtio-net-device", "early-mig", "off" },
>> +    { "virtio-net-pci", "early-mig", "off" },
>> +    { "virtio-net-pci-transitional", "early-mig", "off" },
>> +    { "virtio-net-pci-non-transitional", "early-mig", "off" },
>> +    { "virtio-net-ccw", "early-mig", "off" },
> 
> Is this needed even if we mark the VMState as optional?
> 
> The source might not be able to send the device configuration in some
> cases. For example, if it cannot shadow CVQ. If the destination knows
> this field is optional, the QEMU source version is irrelevant.
> 

I think it is still needed, yes. This series adds new VMSDs that are 
registered as top-level savevm sections, and, IIUC, a destination guest 
using an older version of Qemu would not be able to ignore these 
"unknown" sections, even if they're optional for the source to send.

The compat property also preserves the pre-10.2 machine-type default, so 
a 10.1 machine type doesn't silently change the migration behavior when 
it's being run on a newer Qemu version.

I do agree though that being unable to shadow some state should be 
handled as a runtime check for early migration (like we do for 
vhost-user), but that's separate from a machine-type compat default.

>>       { TYPE_VIRTIO_NET, "host_tunnel", "off" },
>>       { TYPE_VIRTIO_NET, "host_tunnel_csum", "off" },
>>       { TYPE_VIRTIO_NET, "guest_tunnel", "off" },
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 2a5d642a64..12b3456ca2 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -4258,6 +4258,7 @@ static const Property virtio_net_properties[] = {
>>                         VIRTIO_NET_F_GUEST_USO6, true),
>>       DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>>                         VIRTIO_NET_F_HOST_USO, true),
>> +    DEFINE_PROP_BOOL("early-mig", VirtIONet, early_mig, true),
>>       DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>>                                     rss_data.specified_hash_types,
>>                                     VIRTIO_NET_HASH_REPORT_IPv4 - 1,
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index 371e376428..ddb141fefc 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -230,6 +230,7 @@ struct VirtIONet {
>>       struct EBPFRSSContext ebpf_rss;
>>       uint32_t nr_ebpf_rss_fds;
>>       char **ebpf_rss_fds;
>> +    bool early_mig;
>>   };
>>
>>   size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>> --
>> 2.51.0
>>
> 


