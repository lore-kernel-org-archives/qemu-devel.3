Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C8EC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCB-0002lj-Mk; Thu, 28 Aug 2025 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ures0-0001jq-7u
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:49:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1urerx-0002zd-OQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:48:59 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SENbWK025286;
 Thu, 28 Aug 2025 15:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wyH435/Z+amIzWOq4vgjtFJvdqVxq3C4sx8sG5+bvDw=; b=
 V1jedpLdPt45u+KmI63GMRymigigQ0F7B9VIIewFmW9gtKAwKqGTRgpbWo/4HG2I
 PQrKDpHo/iWoc3yG6EKvrgbZA6+NCaYa298yULeunocs3OfWgynOmHa4ZYwpY0ZN
 ZvTypCe26nPOvI0qxdmWYKxQM1QInnLgFBGtW+6K4ONsNRlekuIRWdCalc2070eS
 auto0fNTX58bnFvuuvZF/BGl1uGN57FRLx790rpJ5O5lgQP9zqe2LtgUN54E53m+
 ClBvjv+6UAckzSRBn1SeY6KEeRUWpLOlnhgt/h9wx/cbhYNP78OT1GjFzDPXTwf5
 1mdkOGL3SKOxhqEDI3RF7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jaru1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 15:48:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57SEf9h9005010; Thu, 28 Aug 2025 15:48:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43c61nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 15:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=herVVpcZtylIULVh5Bl5yUZBE/yzwapVPRt++zUjph5qWct2aWmoccTlhzMSpQYToFCUfEF+KBheU0JeguvbQ/ZXkJi7/QnmukleIUlLuu1pC9LD7q3Zh3OU3YwuF1domqi21YbyqHS7ZJY8y2c4oSEHUrYtoA+/7T+OPvphCQSlMkWOSq7HCPgNfmafO/TE42yQPoUS+PQhYzTizIzfstGMlO4ONNCzodkX3iXFNSFl/9Vl2lr9p6j4Ga2TnaoYjy+rMYGQKNUf+5xmn3Ljm2Jcib7DY4Q43LQePRld1wbn3cIRFwyD3vyvIvYGwtMVxRZ/Fl+lEizrX0OqaA5u5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyH435/Z+amIzWOq4vgjtFJvdqVxq3C4sx8sG5+bvDw=;
 b=CAx33GaOIdmmhAAHD2ct5zX7mVl3XaxCq0Lnmi+zM7uJn8H1SfqdNhMNDLL0TdmIMXu6EuXRIlxv5uo3Ey48ScBvLZO9UCB52eg203MwYwwxcbU9qiHJvYskpJT1xJ/hnzMFMJIbXaNk36JQgnLBL/wKiRVLmCFQDakZAcB/NTmtZ6v68pydd/2nOUC/cJ/i+IL5pZdJLJ2SNMlIfLReHUxU8H0WoClYzvlSDvdndX1YUiPLUkcuiGJyRwm0T2gzm2SFQ+ckEZa7VI5fWOqMW8MpgyvkmFRuDJIIW6r7dBm3CGPzxO6nSId/j2u7MwP8g9ie27mvGMtbYYIfrSn+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyH435/Z+amIzWOq4vgjtFJvdqVxq3C4sx8sG5+bvDw=;
 b=FeKfOsNUpX+AK9yO09cpe/IfHPuwMSVDRop+ocWReYyALf+Bx3oVZM11010rNRc+onmxmYX77iFLwMnkAbyGP8+M2d5ClTvrKz04wyL2gkYtZ73dYihvA0gRgyMQPujk3EoFE1t4qln6ZyKgfCyYTsiw6iSGQWYxRCJfz/fdEJI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:48:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:48:42 +0000
Message-ID: <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
Date: Thu, 28 Aug 2025 11:48:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b12dff-f03f-4d60-a579-08dde64a5d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty9LS0YvNVozM2FQaFpOVG9uUzdQSy9QeVNTaHdyU1E3ck1iTGczOXJ5cVlZ?=
 =?utf-8?B?MjJtcllIQ2hnK2dJeklQdm4rYlA1blpTS2xNMDV3OTlFMmJTc01id1p0SVd1?=
 =?utf-8?B?RmhHbWh5RDAzeXdLbVZvOTdSelpxNkdrcm1sYVM0M2d0Mm4yZDFFUXRwbFJz?=
 =?utf-8?B?VGhsTHdzVG83ckFxa0x2Y0RmckM0UnkrWjlGVUFXZkI3aXBSUFVxbW82RTJw?=
 =?utf-8?B?QWNDSXZpRFVOZ2R5aG9samdOMEVXWXg5eEgrM0JJemhrYXdZRTFFbFpxM0hk?=
 =?utf-8?B?dk4xOFpjbFRqZTRleUJleUY5YUVVUzhwbGRwa1E1SmNhaGdtN0hwMklmTm1S?=
 =?utf-8?B?Z0gzTmZuVCtVcm5WZmdDam0xaXQ4aWpiWkhENFZGTFNVVHBjejhVNTlqbi9U?=
 =?utf-8?B?VFZkUHl6OXl5VndxaTlESTk5d0xpQWQ4NTdwclFROWtxNVdQNFU0TUhwUTJT?=
 =?utf-8?B?WG9rZ0U4eHVEKzRjcDNKTnA2c0p2VW4zY0h3UnloVVM5Vm5YUG82ZFZDVDlF?=
 =?utf-8?B?cHJweHNYbFpBNU1vOE9NWm9BSm02czBlOXRqQ3RHZUFKdnZEYVRFQktZRWps?=
 =?utf-8?B?WlJtZ01EVEx5N0NDNzZMeFIzQU1nWW5LZzBEUS9HR3dQR3ZkVUdZZ1NMREpO?=
 =?utf-8?B?Nm45QkJkTU01SUl0Mi9vM1JPYjRsOStBSGVQaUx1SWxpcmNBSXU3d0RLK2dT?=
 =?utf-8?B?eGVNLzhoSkI4eWRaZmlhdGxPMXFYeUx5M0c3OWNkd0pZSkIwanBxVVZTVHFC?=
 =?utf-8?B?bGFBekUyNFVBUEV2R0N4VXZLMFJQb01RejBzWW5RVzljRHN0VFpBNG9SOFha?=
 =?utf-8?B?T2dNcFBmQnhUZVdCSkZVT0pGT0JsUUYyQVo1cnN4TEF1aTBTZUlqLzFmb1ln?=
 =?utf-8?B?bEp3Z21pUlFCc0xsaXpUT2UyZXNhejJwenVVZjZkM2FBOEx6YWFjckNLY2U3?=
 =?utf-8?B?KzN2cGRGUzNjb0I5ZmRsVk43Sm1reWRNZklPNXZCSnM0WVFOMWZHWk9Ub3VL?=
 =?utf-8?B?VEl4RFRVY1cwSzBDTmlZM0RlRi9INDFaWlRncm54WjhVOE90SlpaZ0JHY01s?=
 =?utf-8?B?YVhISm5oWlU4bjl0bXhOU3IzZWpTWC95NTB1WnRlalFpd0VqNU5pS2drenM5?=
 =?utf-8?B?ckRjNzhPQzk3d0pwWmRuelQrbmtmUmRRU1lnNjRUUXpkcUhOZHZYaXZ2K21S?=
 =?utf-8?B?bi9LbWdYZWVHOWF2azZ1eVFNNm1IU1ZqM0VzcmE3cU8xTjBRR2RQRUNLSjFo?=
 =?utf-8?B?bjNaRGhEajBHa2tJRE1XdHhRZ1ArUTRSalE5dkFETHQySlRUb2F2aDRGRWpE?=
 =?utf-8?B?Z3hVQkNXSzVOLytPTmMvVzN0RUc3QzRiWFJwSmkrRHBXaitKVUUzOFVibUhi?=
 =?utf-8?B?WUR2MXVBNFpYeEd2eGlpTUpLcHloM3BwU0FvUlp5b01FQ2FhZloybGdLeU05?=
 =?utf-8?B?WWd0NnE2TzJ6UnJuMHc4RTZkSXBoK3JTZFlwcVR0VXRDeVk3ZkV0Q2pheTNH?=
 =?utf-8?B?eXEySmFLdml0QU00T1Rhb0lSbVJyUVVhellqVmcxVmhpczNBN3g1bGpCTkFP?=
 =?utf-8?B?UzhyYVhQWmZPRFdRSmVhcDJYaVFXTlNwZmRFYTE4dEw1R3E3bi8yWitZZ2kr?=
 =?utf-8?B?Qm83b0FBTzZudFNIWk9OUGl3VG83U0pHS2l6M1hrVFRESGwya21YRWtndW9Y?=
 =?utf-8?B?Ymsvb2ZxaXdsc1RsNjkwQnkyWW1GZ1pHQU1CVndsQmdjaHhGaHNLQmpaTEJN?=
 =?utf-8?B?bDJZQlVCMnBTQ1lUYXZNQlh5K0FwTnlVNGxtYmJ3YS8vVTRJOUJnV3VZc1kx?=
 =?utf-8?B?bDFYbHo5V1puWXZBUkFvSmJ1ZXgwbDBEUCtKNTh4OGRKY3R1MHRCVlcxQlJJ?=
 =?utf-8?B?all5czA1K05MVzVSeVVQVHZ5NU9jUlk1cjZlRVV2L1JJclJGc1YwbGVydFl1?=
 =?utf-8?Q?st8OX7mSMhA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VOKzdBaGNYMC9NdG5EbWNVdzRkMHN4QktzWG5SQ1ZtRUZnSXlzOXlqUnYr?=
 =?utf-8?B?cXpJcmNSQjFqd3ZEaE5yM3N3dzhkMjM0eUgzVEtML2EzS1dyTGY5QTZmTXZC?=
 =?utf-8?B?am1FeUJpaTJBMHMvTkFpVlh3a1JmQmFWSDRqQkN2blF3WVgzc09OdW1mZTFk?=
 =?utf-8?B?cjBheGlkb0RwMHpwRXBiQUU0UWNBSnlDNHJNcjRENVo3TFJJREsxWHRIT0Yv?=
 =?utf-8?B?QnppRkNZejlrWVFsSG9NL3pLOEwvZHFaM2FRc211RVZMSkhSRTJuRFBKYkFE?=
 =?utf-8?B?YWdHb0tjMEc0dk1FNHNMWWVuU3ZEdmUwVXd2aUZ6WFNpYmtkeGhpd29yeTZi?=
 =?utf-8?B?TkV0SzgzeFBIY0JEMnFSQWV0SHV6N282eVBadENqT2tEcDB5aVV3RjNybGlT?=
 =?utf-8?B?d2psdk9jdU1lQlZSYXJCNXM1RlcrUzRwTWVBUEF6TkdSVERzZ2VzZ1FqYS8z?=
 =?utf-8?B?dnljdXYwV25UbG9wK3pFRWpsTkxFSnBXSHdkVDF6eC9Wa0ZVWnFRSUQrNTR0?=
 =?utf-8?B?Z09hdEtvWkRORlUyY2dDdk9sNGtRRW4xZWdQTmUzRGZqOHRuWTJidFIvbUtR?=
 =?utf-8?B?TU15OXZzNzBKWmhoYWt6MEJYRTJqV0pzRHMvcWdFVit1SFViQnVpbWtPUDRE?=
 =?utf-8?B?a0JnMU5QV1l3dTVsTW13VEtvRzZaUHdaN1QyKzJIeFgzTkJ0dUZqRkcrV3F5?=
 =?utf-8?B?Tmw5bG4yQU4rcEZaL3ZLU0srNlIrTTFRdzFvTzkzUGk1OU5HNUVCdm9rMnhM?=
 =?utf-8?B?ZGpWeTJNZE1jUzg3M3pqWXNIaHpsUkZjQVNaNE5ZVmRyRHdrSTVsU2xUMERB?=
 =?utf-8?B?RXVUTXExSng2cGRwWnJ2ZURLeU1FdGdpcUF1MUxkNDNKeWlMUWg5aStlaUZ1?=
 =?utf-8?B?MWszSnlOb0dKZVU1V3NGS3QzS0kxSVBMcmJJSFRZOTFFRjU5Y2JuRk1IQ0JQ?=
 =?utf-8?B?RWxGMG82eVFaR0UzcXFZeVlQR2g4bXFRa1BLeHhRNDRqbmxxS25ueGhSejg1?=
 =?utf-8?B?aDVuK1MyQnB6N3V3eGNTTitQMFJiRDdWNXZVczJMQWs2cFNraXkrNGhtdnZG?=
 =?utf-8?B?bzkvbzZBa2o1dGR6WmY5dWZPbHFlZUwwQisvcW5jRGhnaVBsR1duZDZYVWFB?=
 =?utf-8?B?enVtdkRuM0dON0lvNGgrdmJEVzJCRllacDNvZ25KT3U3ckNUV0l3Y1l0Z3hk?=
 =?utf-8?B?Mm9BNndlVzhFemRKYXZtejVycVZxQlM3UHZhQWd1bXVNSEF5elplSmIyTUxw?=
 =?utf-8?B?NmYreDJOZENMNVJYQ001WVFtWmVjUy80dVZaV3YyWHpNVWRDWUJDV3hJVFQw?=
 =?utf-8?B?UHcvQjIrOW1MdTU2ZFEreWZwSitTMUk3Z29SV1NZVGlEd0ovSDAxVzBnUThr?=
 =?utf-8?B?RFBOaVhDWFY0MVJ3ZVhhOE5aOXExaUZmaEQ0cURLVHlSN0wvRzZ0cE13aGNs?=
 =?utf-8?B?djNscXB5cG84L0lFa29DL0cxSXNNaDdLaXZvSGtPVWR3R3Z3TkVwT0RNRXR0?=
 =?utf-8?B?a0J4eHpSQnNBeldRTE5TTlZybVlRVkNDSVdEZGpwOWJrcmNJZldmYVJmeitj?=
 =?utf-8?B?RHJQK0kzbi9uaGkxVk5HZGVNeFVNbW5zcTRIZ3NGRVBPSVdIblVWdUtwYUpS?=
 =?utf-8?B?bTBBV3VPcGtCemUwM1Z1VmU2Y2pabmNrMWlvQkp2WlcvTGJ4WGZRZUdOc1hv?=
 =?utf-8?B?RW5kaEs0NlZxSC96MG5QRmsxa2NDNGFyWUpFOFJDTjhmVkpMUElpT2wzdTlV?=
 =?utf-8?B?NElaVXNmdndCTzFDYTNNNTJBT25LbjVjK3pkRHMwZHJDbVp4VWZ2R29hdW4z?=
 =?utf-8?B?ODl0TkI2MHlDaXZJTnl5c0lvZnN5dUNWNWc2d1c5U3JGeHN3Tk1VVUY1dHU0?=
 =?utf-8?B?citvUWFTNGJFZ2c1WXJhc1NDVlFMbklGOWlmZm5LMjZZRGRDbCs3eVN3QlJM?=
 =?utf-8?B?Ry9wY0hTTU9jSmlWQytlTnZyaHdtRXR5R1pBN1laTFd4eG9maTVTMDg4ei8v?=
 =?utf-8?B?SC9wQjdJMXY3VWFOeGNWNHBGR1A2VEVCZExoNDBGNUdSLzU1eG5aelI4b2Jt?=
 =?utf-8?B?UzdYdlF3a05oVlV5YzJuMHN6NzFhWUtrL3BSbW5wRGZLT0dQUHhsYnlNWXcw?=
 =?utf-8?B?cTZRWnRUL2FGS2Z3SWI5WFJZUGttR1ZtL2QxTmVmQWN5RSs0Mkx3U05RQTNw?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jFnGlViuEGL2oVc3zHE6XcGPEcXofaBX3StxHLNCaI9oRTw6JZlkHYr6cksSVSHMJvyFlc/tLy3nOT5ghRAlkp0dxpE80yEvrBX0T+4bjbp6r+uUL+3wwmf+JtqpjQEgW+BWKhQboTeL0TvekjEGIIGBUainJJpBiNNP6irF2s2J/hPeGTBcF1558tPbJR0K48mcwLmbwrv8NmBrdjpXW/RSHoSGzRkneYDkEmj4NGCYVI/8Ia7nbDHM1kzU9AWSRDU4Z5yWe/a93qvRytUkUbTzRtzZAEUIkpn5qE4KjURdbT7ACGXA1NMrTNlK6GgZidgbTpP4ZxGxK2oFlC2d7C5QqYFQ2xTEpM3ZRsMhmptdWfa+A9MlWBul4xKXPlaq7nvtXOl+g5CUtLFoQ6za5uG//Cp5B+wkwxPGQB602TJfbedelnwjCzLexNDjAucim5JcGsmeuUx7bNCxNELDPCrkR5a09ndjUp6G2fls2BEvDHIFAFkYdpHRdOwv9Jybbdr3hQqcfA+s4FSWMIsCpawiOj5Ds9skgqtltKz3C74IL9QR+793bQUP/WGbyX26EOmp2rBVuRw2uB58/XnKJCe7nE5P88hVF5XcZDy8ur0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b12dff-f03f-4d60-a579-08dde64a5d32
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:48:42.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obb3JBK5zKX/vEvz0Yg1LE9kizjOu9BLHNbFIZY/vAKJt02Hl6vPfubXoZeMceIdqVZC5BoSFHQX8SR2s7pfbdGQVQZgkrPiHmWA8rDaB2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfXz1CAKUFtEYzT
 1oWVGPf1SqEkfrRBSyRqDUjUGyXGC7+COgKn7l3BqZH4miJQp7vbqZwJbrhbJ6ROj0sN5A3cKpd
 N2QM/tBk52ewpI7/cvLB0RlgoXcPsSCPGJJTCZQ8tbRwpJlG7BPKlYzOGrI159wDjxCfDFS0Y6Z
 6bRxRRRaAIqJqWp2bQpSFa0+zF5+7IgWTB+CaAU30LD0tKOWYLIZTwp7iF6/HcTimrCoQ6FxcuN
 1CZt7+gCwqO03QUPG7fyK1Q3qZNUgi8jBVo1vtZUo2LN5hDqsnCBWMphfXYtA90A1Fpz4055Gle
 tg4iOLhrzFg6/MV5tXQGVtTeVe6W0f7dljUJn7zG+A/mBTXRyYFxeq99Q42Tr8PQaqawlUwMGVA
 XTeC3VI8
X-Proofpoint-GUID: wa30sRW4uLm2Bzc29L_173lhoy0oNNXi
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b07a64 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Z8FVFtHqNtQr8NiJu9wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wa30sRW4uLm2Bzc29L_173lhoy0oNNXi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/23/2025 5:53 PM, Vladimir Sementsov-Ogievskiy wrote:
> On 17.07.25 21:39, Steve Sistare wrote:
>> Tap and vhost devices can be preserved during cpr-transfer using
>> traditional live migration methods, wherein the management layer
>> creates new interfaces for the target and fiddles with 'ip link'
>> to deactivate the old interface and activate the new.
>>
>> However, CPR can simply send the file descriptors to new QEMU,
>> with no special management actions required.  The user enables
>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>> is cpr=off.
> 
> Hi Steve!
> 
> First, me trying to test the series:

Thank-you Vladimir for all the work you are doing in this area.  I have
reproduced the "virtio_net_set_queue_pairs: Assertion `!r' failed." bug.
Let me dig into that before I study the larger questions you pose
about preserving tap/vhost-user-blk in local migration versus cpr.

- Steve

> SOURCE:
> 
> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :0 -nodefaults -vga std -qmp stdio -msg timestamp -S -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on
> 
> {"execute": "qmp_capabilities"}
> {"return": {}}
> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
> {"return": {}}
> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
> {"return": {}}
> {"execute": "cont"}
> {"timestamp": {"seconds": 1755977653, "microseconds": 248749}, "event": "RESUME"}
> {"return": {}}
> {"timestamp": {"seconds": 1755977657, "microseconds": 366274}, "event": "NIC_RX_FILTER_CHANGED", "data": {"name": "vnet.1", "path": "/machine/peripheral/vnet.1/virtio-backend"}}
> {"execute": "migrate-set-parameters", "arguments": {"mode": "cpr-transfer"}}
> {"return": {}}
> {"execute": "migrate", "arguments": {"channels": [{"channel-type": "main", "addr": {"path": "/tmp/migr.sock", "transport": "socket", "type": "unix"}}, {"channel-type": "cpr", "addr": {"path": "/tmp/cpr.sock", "transport": "socket", "type": "unix"}}]}}
> {"timestamp": {"seconds": 1755977767, "microseconds": 835571}, "event": "STOP"}
> {"return": {}}
> 
> 
> TARGET:
> 
> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :1 -nodefaults -vga std -qmp stdio -S -object memory-backend-file,id=ram0,size=4G,mem-p
> ath=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on -incoming defer -incoming '{"channel-type": "cpr","addr": { "transport": "socket","type": "unix", "path": "/tmp/cpr.sock"}}'
> 
> <need to wait until "migrate" on source>
> 
> {"execute": "qmp_capabilities"}
> {"return": {}}
> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
> {"return": {}}
> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
> could not disable queue
> qemu-system-x86_64: ../hw/net/virtio-net.c:771: virtio_net_set_queue_pairs: Assertion `!r' failed.
> fish: Job 1, 'sudo build/qemu-system-x86_64 -…' terminated by signal SIGABRT (Abort)
> 
> 
> So, it crashes on device_add..
> 
> 
> Second, I've come a long way, backporting you TAP v1 series together with needed parts of CPR and migration channels to QEMU 7.2, fixing different issues (like, avoid reinitialization of vnet_hdr length on target, avoid simultaneous use of tap on source an target, avoid making the fd blocking again on target), and it finally started to work.
> 
> But next, I went to support similar migration for vhost-user-blk, and that was a lot more complex. No reason to pass an fd in preliminary stage, when source is running (like in CPR), because:
> 
> 1. we just can't use the fd on target at all, until we stop use it on source, otherwise we just break vhost-user-blk protocol on the wire (unlike TAP, where some ioctls called on target doesn't break source)
> 2. we have to pass enough additional variables, which are simpler to pass through normal migration channel (how to pass anything except fds through cpr channel?)
> 
> So, I decided to go another way, and just migrate everything backend-related including fds through main migration channel. Of course, this requires deep reworking of device initialization in case of incoming migration (but for vhost-user-blk we need it anyway). The feature is in my series "[PATCH 00/33] vhost-user-blk: live-backend local migration" (you are in CC).
> 
> The success with vhost-user-blk (of-course) make me rethink TAP migration too: try to avoid using additional cpr channel and unusual waiting for QMP interface on target. And, I've just sent an RFC: "[RFC 0/7] virtio-net: live-TAP local migration"
> 
> What do you think?
> 



