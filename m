Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CA6CD4F30
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxL7-00071k-6Q; Wed, 04 Sep 2024 17:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slxL4-00070U-Pc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:14:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slxL2-0005xH-Ew
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:14:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Kf1P5008314;
 Wed, 4 Sep 2024 21:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=gTKis+Wbv+IVSm+OII3jnH+SHemIEUDnt+7GbnoUezA=; b=
 nyOMeiJKpPXfgAvXxZTBWSITxvu7vSuiWk7+Y9MoeyBKQ7zRPrgzYfUO0CI1tOP9
 2waNF99u+vIcP39jkc+jwLbl6Pn7JcUk+SRSN1fndAqxGONek9BeWZSAPT4Tvcnx
 jeqh3frPXRxEH8WuXS/4kcpSWS4k8yDjLxBrUEB5FUrJkFaFSqeamJ5Os+w77qeV
 DrUJTCBwid8KdXsl4qk15Po5TxVc9+V0RW73EBHN4vJDUdZauKo+hLdXDIr4KU0Y
 8U8jkdkzvMefp0ctOVm/o3apWgCyBhses0+2ncbRd1azXHDAxy4kuR4SaIk1Laxz
 q/vxowQAql3hQ094fV0vug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84n9hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2024 21:14:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 484KWXPT023607; Wed, 4 Sep 2024 21:14:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41bsma483j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2024 21:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skgZkJtCuWJsaY41naB3Z/yFy+1dDJkvY2GYpCGDgcuAis0U3Wn5ebWlqsfNxUgT/Zck6fzGml6yH58GZMZ1zgA9fUzOkHIgN2BAsGtEalEcFmGK0E36rE1mxPkF96c3ZJfa0gn+nMbjFLZqsh6n2iCubrCSNTASa2gMl0Mfk3UNnNQNYBdet4FOiHwbbkMlO5Sz5MVjm/8+415LCpPAg0B7lqq1+Ebs5xckk8JgkOBxJeZfUD0Z0Aj1XOYINgOaYRqGSMwI4oLk44AZpdsTF5eHfSwBtxjnIlyVlRfTiPkV+C98BXMiHM4K62HlBekfNZSy+lqlkvAhfQzn4CP7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTKis+Wbv+IVSm+OII3jnH+SHemIEUDnt+7GbnoUezA=;
 b=FdK/miAup6M08/DpUSLJ88QniNusEs/9mTEqOPkTxEmAvN8N0uEbQqAZMFQ0KOFiFu3CdHwXfbIf0+kEYrBMVaLRjEpV+TcIoomo8aErxtg39QNzLZvbJsEBL5J6i2o1RkrdP+6OKPWOMXYPO7v30pzh7JFL61C3D3sijnE4QZafVDabVcFpRVNOLlVIELNWw4GjaxJ1CHUuRaMueiI/pMElSyAVU1UMN0plYoENjaQmximiF3hVPz03z0Gw1Y9S9Lf5ZMzMyLcZyVzpnzdwgr5jovZqZZzGD2uE381dCYTlqkr95NJNCHasUUTnUexgiPCP9wk6E8Cr9/kMn5Qeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTKis+Wbv+IVSm+OII3jnH+SHemIEUDnt+7GbnoUezA=;
 b=sXqYbO0v8mwxG8fuRFXmqRjbsuwHzNVv0qqpT2p+gcHENChVS9R8f/SxetK61cxLLiXo3t00W4HMfpYe7T5qnKY5cFcvd+sfC0sxllY/7gWURFQ93zF+nkxBdQa6p+76Y43KAjL3KMqkqX0u74Fv8Sn1iuHJb1fQTd4ZHjIk2rQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Wed, 4 Sep
 2024 21:14:44 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 21:14:44 +0000
Message-ID: <b318619a-fed3-42e5-8172-e8418e1bd860@oracle.com>
Date: Wed, 4 Sep 2024 17:14:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n> <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n> <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com> <Zr93bOr1zrSZadf5@x1n>
 <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
 <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b4dc78-a2cc-4437-6f8a-08dccd26993f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlBKUndXR1YzUW1kaVdiVCtHcnpoQ09HUVQxcThPbTNwYjZmNTFGMit2OUFo?=
 =?utf-8?B?aSsvZnFpQ05SSFptSlFpdFhwcFhWdmZ5SXRzNGhVWHdYU2pyV3VQck5nTEhH?=
 =?utf-8?B?QUdKYVpVTUM1Wnk4NG8wRUVwUllCMHZSOVdsOUZ1UjJpRFk4b3NNOG05MW85?=
 =?utf-8?B?SkE3a3FRL1B6QnNEVlFRRXZVa0NadXdDVHQwRS9PcVJybTNrNkJvSXdFamRQ?=
 =?utf-8?B?TnNUVmszWURaNXBvUnZCQkJ4VFF1SGw2Z1U4dWdVUlRQR1NrMjUxSnI2NVlX?=
 =?utf-8?B?YnlmZnUzN1FkMEhpVzRLMUxLT0Jtd0J4SitpdldlY3FiTDR2U0VnZThJNFVN?=
 =?utf-8?B?Y2dqc2dQRmw2N1NDKzFzNU95VURpVWRoOGlkNkNmMlI1ZEtFRzhrNGlhMUlG?=
 =?utf-8?B?RnFzTStSa0FNaHMwY1lIN1pvbkt5TGd4SFlLalNTaFI0ZFBlV2ZtL05hNEtQ?=
 =?utf-8?B?TTNvK09wcElyRDJIS0FCVzRRZTV2cVp3ZjJNc1kvdk5FdCt2TDRmalZNV0tF?=
 =?utf-8?B?aFNwcnVybmpOT09GYWt5T0h3Wk1jQnVBR0xNd1EvNk5uZ2xySzlqRkR6Y3JL?=
 =?utf-8?B?ZDhDdTBPUzhGajlzbmFsYXRlOThmYVhnUlJ0cnQyTm01cE9SaWM1eGhqcXN3?=
 =?utf-8?B?MnFPVHJFYTVnOUYrREd2T2lsSmVqejRveGEyR05EekFuUzM5MWtzWG1YT09U?=
 =?utf-8?B?UlFQT0E1MVoxcU84QWZOV3BEQjZvOW02SU5IYTFjeDFkeXVZL1ljblJ4Nk1S?=
 =?utf-8?B?Y2dJY0VySUtnV0p6R3YyK1J0ZEtoRGpKbVJvaVQ5T0RBZ1V0UXNkNnA0RlJv?=
 =?utf-8?B?YTIrRThCMzNCOXh1V1BqNml4NlVheU5HQ2puaDZpMFd2VzJENVZ0d0R3NlU3?=
 =?utf-8?B?U3ErMExXQlh2N0h1bnlDTmhiUzVqbXpOM0dGYW5VclphckhpTkVvbmZJeVNp?=
 =?utf-8?B?Zk9sRTFDZGptSFdyYUN3VkxhK0N2bHBrMVh0SUUvbjZib21MYVZNMFh2cERU?=
 =?utf-8?B?cTlwV056Z253bFhWZjVJMCtRbTRtRWs2SVFIZ3A4WkQydUV0RDhvQkY0QnJB?=
 =?utf-8?B?eXlLMzEyYi9ZU1VzbnhnMmtTWXM4TWM4OWVqbHkrUElSM3hFN1Y4YUdxazgr?=
 =?utf-8?B?Zng4VHcvdWlIcHd5bzErTHR4WmJMSmdRcFl4Y1duRU9WQlN0dmVsQmh4bWpq?=
 =?utf-8?B?blZtTE1yZTBLUmltN0lvK3UxVHZ3d3VXTm5UdHM0aTNvWVVnNDlIcnN1citU?=
 =?utf-8?B?MnBpekY3bUsrMldVOXpFVzVQaUZoMXFpMlVUeUk5TVNpdnB6L0llR2hkWis1?=
 =?utf-8?B?SFRJaFVZekRvOUdHN3BsMGtLcnRCdkVUVThSS1VDQStlQXRLTVFoS2JoWDBw?=
 =?utf-8?B?cG1XV21SbldpTlNha2p2NUtJczBxVHQ1Tk16WUYva3oyeWhFWTZ6aVVnQVlC?=
 =?utf-8?B?YWVpNkJhZStMcFM5SUFnNURzc3hMdUt3Q3B1cjlKVFBLcjlZeWNEaGlYM0gv?=
 =?utf-8?B?bXV1ZUdPWldvSUNCbThrVG1vQ05aZ0Q4WDdwK0JXTVdYNDQ4dTVGRTJMTllK?=
 =?utf-8?B?Z0I0NVJMeWx3cSs4ZWN4ditIRHNFeWdQdWxaLzVubWJoSEpqZVJwOFVYMHFU?=
 =?utf-8?B?RDdmWkhpaE5pUUQ4ek5HU1N0cGRMcXFrY2s5TzlqcU5CQWtvU3RYUmFXVnVr?=
 =?utf-8?B?WW52c3BLNU5KQXZwNnpZdDdTaG8rSHE5UkZOVzNwREJXWGtkNTZHMU9ITXhO?=
 =?utf-8?B?RGZkL0l1b0Nidm5jWmxzMkFFUVJ5V3E2eVJNTFVvSmV3dFl0dUdxWHFCaTF6?=
 =?utf-8?B?VlA4dmV5QmhLWWZJS2Nidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si8veUpMOThjZDZGYnM2KzZnTmRESXhJQVRaak1VMXlIY3NWYjR1akxCeStQ?=
 =?utf-8?B?Tm9XeW5LSkhxVEV4c1N4N25LMTlxcWFqanlIaTA4bUhaMlFFVVlMb0VDZm91?=
 =?utf-8?B?a2tnM0J1MUNIZEw2YVN4QmVqeDZBNVlCS3dxRGMwYjFFdjZaOEZiNVZKY0o5?=
 =?utf-8?B?RXB2L2d1M3pJdUtFN2srT00vMXVIWFVMblBCUVJLN28zTXFEK3lhMFJKc3lj?=
 =?utf-8?B?Mk94SjFIQWlCT2xEMXZaODN2K2JhcTNVZ3VCU29MVmEzYkcvWFRRMjFDdUhn?=
 =?utf-8?B?VUh6RlJKd0hVL2JsQWJiQ1JPOUVMNjU3MTFrT2RkcDgxTjNFeTh5a1o5RmN2?=
 =?utf-8?B?RXJDM0ovM2g3NjJLQXZWVEpWcXlvcWROYXdGYW1uRGdTSWdpOGFwa05IeVRh?=
 =?utf-8?B?dk5uampnY2N4bFNIdzV5QlBHRm8raWZUYTA2RkNwZ1U2WVhqWGxydFRYRVpl?=
 =?utf-8?B?REtyQ25STkZydVVuRnlpQlA1TXRTeW9qeTJqRXRyaGdXME5KMGtrZDBuNXRK?=
 =?utf-8?B?Sm9LV1VIN2g3Z1FIWGg3QUlqU0owcjN0UForU0hhL0RMbGFPcDJlQzZtRU1F?=
 =?utf-8?B?STRDUEMyQTVHYyt6b280cXRIVFV5eXBnb21MTTF0Qkp4Sk5NUUswL1VpZTBW?=
 =?utf-8?B?clk2M1pCOWh1S0ZmQk1TOTUzT3I4a2lXcGFRL2NZVE1mUTEvZnMyWVIrL1M1?=
 =?utf-8?B?bVFTOVZKbDE3NFVZelNTclFqL3ZmRFN4dG52dnQzblI0dy9VbXhzejFwaUI3?=
 =?utf-8?B?QTV4THc5M1FZL2dTelk1SmwrcFByMmJoN2xVMTUyZFFLNS9BVG03L1h2OENP?=
 =?utf-8?B?MlM1aVJnTC9NRDhPc0JveFFDRHJ2YjFsTVhTZUtUdFEzSVV2WkxEYkppallV?=
 =?utf-8?B?VVFKSitNQzkwclZWTXUrMGJtUDI3VWdWeGFzTTdGZ2YybkU5ZHNiVDliZXFY?=
 =?utf-8?B?N3VsVFhJb1BLRkx4ckpXMVNiSlBJTlNDVzVIMTRkNUxmU1JsWWlsanJBOXFt?=
 =?utf-8?B?dnRTQU41bXplQ1YyeHpydXY4UjhKcWN5My8zOEo5THJ2Nk5zd0Y4emloMWxh?=
 =?utf-8?B?U24yOFVxaWl1M0VNV2xpeWx4U1hCRWU1SFQ5RkJ0MFlWOE0zSDVPNEhzZTVu?=
 =?utf-8?B?WjhhTGczd2QvbUl2a1RJRVFuMTlkYWNqL1pQSUw3VWdJWGk0VnNHN3JNakpT?=
 =?utf-8?B?eFpKNEZ2QWpEV0FCZEFVWTF0Rm1rY3Vnci8yc2VnYmpIS2dKWmZwejdnNXZm?=
 =?utf-8?B?eURxdFhFSFg4a0R3S09MbW9DM0YxTkNHb2xtM0xMeDFXdnZmaFZkMVpScStq?=
 =?utf-8?B?MVlNK2R5N1QzNmdNOFFjMU00RDFBdnhnQ3Nqb1p1a090Wmg4NWV2b0hvTTd0?=
 =?utf-8?B?dGdDbDFSdFFpMS9uTExjVDhwTTZZUHUzSDA4RTAxWDRPMG9yL1NqZTBzbngy?=
 =?utf-8?B?T01mVEdXM29HdjdPdmxrWTRhTjNBd0xXTWIxYU0rRGwyVWNJZC9EM0hkdDZH?=
 =?utf-8?B?d3ZQTjB3QzFNeXhHc3BESjFjUGRJczNQZmpIR0ZwWWdQbndLVjIwS3VaeFF0?=
 =?utf-8?B?K2I2eGtRb096eUxna2w2dW5RaHBmYlBUOWg0enFLZk1iUHVCVEtqd0RuWm9X?=
 =?utf-8?B?R0Fvb1BOSDBFQUJGTkhBMUFqb1VSWW1SdklsWDBwTnVDSThKUWRWQTRqUVRj?=
 =?utf-8?B?c3NlWHhPcGpDVkVwcVg5Y0NXV1JnSFZxL2l3aWNPSVc5Nkd0VGxRNSt0WjE2?=
 =?utf-8?B?T05ZaGxxai9DdEl5dkpwT0N3U0FTMHk2WE1xZy93ZlFaUDZFcVBuYVpuaEhL?=
 =?utf-8?B?NzBMeXZzTmUrTnBpRUhGRHdZcmFPQ1Y1RFZwNDdHUGNnMCsrZFRvVG5hZllz?=
 =?utf-8?B?SC9qK3pWMlRtYllUa0NDOFR5OE0wQ00rcUhUTXdLY1BlTWlEd3JGTFhaWXR5?=
 =?utf-8?B?dm5QREFyYldkcFllbUlFMjl5Z3RnVzh1MUFUQU92OGlUZkx4ajVuNXdQQlRm?=
 =?utf-8?B?cWpHMVhQK1dTMkJjeHBFbzNWRkJuMXhXdEJINnQ1VVNxL1FzTXFDSEVsMGRE?=
 =?utf-8?B?K2k0SVZQNVAxTGc5REovTFd1aDRzWm9tWDJiSUxnSFZnY1o3QzcvZ3RvNWI3?=
 =?utf-8?B?ajBEN3U1ZGxMM2ZHTDRyRnFrUWlnbXlBaTJaRU5sZnlnR2NaU1RwcDM2bXhY?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pWaZ9mA8WLhDBcomrA9NPt2qC+7PsR6d55/8dMlxov+xaLmUZbxyUgyILHqKBzxj3LYuS7ctBk7wjm4QAwJEAje+wQjxzWK7aTsUMywW+x+ZKr0hgS8OCBeTxFfl3JPzfCqvsDNemYV8oDybd+iSwwK4tpPfdERJKbAqehrvQcOf33K9VYKDqgNKoCYGCOhWzzi1rnDN1APsy/gubwEExTjPEXaMqKRQLk6CeEAMfd2EmX8eqgipojsGa3Hx03/LA1+yOwlTTiVb0slEgc7NAsZTaTtGos73aO5J5UtIiQKfRBAFBMQXn9z9FVaejjgJ9OU1Iwc5CnJS7ZLQHG0A7NpvV+J2Q8mosWIDSCKPvaRd+xTt6mF9Q6bEYJUSU45lZpvdpDGrJgL7q8MLj4Ydw7aMUerFxjmrnKODbozFCMWFjXvdUx5XBycaXv0VWyhzUSIs34t1KldJoBbGXhIno8RCoI3geEkq5IDloWc6oRAtxh6GMqE/Rj8uJOGmwwbAVgrCYYvjmpYCjL+za+6UpnfIxTppIMdFuhYQteAgCfWlqjoknGMqhNbEVbsWhGDlkVkxAWlq7QD9neiTH+sIItfKKL0TMC9+tute7Ga15xY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b4dc78-a2cc-4437-6f8a-08dccd26993f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 21:14:44.5132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bUYzAodgcyg5fGykRYOe9ITjysgC0f1kEi0VX8whR9VZUmA7GjjyiRQBaHGB+Z3JloN5RsjbNieuRgqNW4u8jBYT5CaGkR4fVa0HfkMjQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_18,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040159
X-Proofpoint-GUID: ZycE1gwwi1u862PEjRI03QZH7nusBOsB
X-Proofpoint-ORIG-GUID: ZycE1gwwi1u862PEjRI03QZH7nusBOsB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/20/2024 12:29 PM, Steven Sistare wrote:
> On 8/16/2024 2:34 PM, Steven Sistare wrote:
>> On 8/16/2024 11:59 AM, Peter Xu wrote:
>>> On Fri, Aug 16, 2024 at 04:36:58PM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Aug 16, 2024 at 11:23:01AM -0400, Peter Xu wrote:
>>>>> On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
>>>>>> On 8/15/2024 4:28 PM, Peter Xu wrote:
>>>>>>> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
>>>>>>>>>> The new user-visible interfaces are:
>>>>>>>>>>      * cpr-transfer (MigMode migration parameter)
>>>>>>>>>>      * cpr-uri (migration parameter)
>>>>>>>>>
>>>>>>>>> I wonder whether this parameter can be avoided already, maybe we can let
>>>>>>>>> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
>>>>>>>>> in the same channel?
>>>>>>>>
>>>>>>>> You saw the answer in another thread, but I repeat it here for others benefit:
>>>>>>>>
>>>>>>>>     "CPR state cannot be sent over the normal migration channel, because devices
>>>>>>>>      and backends are created prior to reading the channel, so this mode sends
>>>>>>>>      CPR state over a second migration channel that is not visible to the user.
>>>>>>>>      New QEMU reads the second channel prior to creating devices or backends."
>>>>>>>
>>>>>>> Today when looking again, I wonder about the other way round: can we make
>>>>>>> the new parameter called "-incoming-cpr", working exactly the same as
>>>>>>> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
>>>>>>> be reused for migration incoming ports?
>>>>>>>
>>>>>>> After all, cpr needs to happen already with unix sockets.  Having separate
>>>>>>> cmdline options grants user to make the other one to be non-unix, but that
>>>>>>> doesn't seem to buy us anything.. then it seems easier to always reuse it,
>>>>>>> and restrict cpr-transfer to only work with unix sockets for incoming too?
>>>>>>
>>>>>> This idea also occurred to me, but I dislike the loss of flexibility for
>>>>>> the incoming socket type.  The exec URI in particular can do anything, and
>>>>>> we would be eliminating it.
>>>>>
>>>>> Ah, I would be guessing that if Juan is still around then exec URI should
>>>>> already been marked deprecated and prone to removal soon.. while I tend to
>>>>> agree that exec does introduce some complexity meanwhile iiuc nobody uses
>>>>> that in production systems.
>>>>>
>>>>> What's the exec use case you're picturing?  Would that mostly for debugging
>>>>> purpose, and would that be easily replaceable with another tunnelling like
>>>>> "ncat" or so?
>>>>
>>>> Conceptually "exec:" is a nice thing, but from a practical POV it
>>>> introduces difficulties for QEMU. QEMU doesn't know if the exec'd
>>>> command will provide a unidirectional channel or bidirectional
>>>> channel, so has to assume the worst - unidirectional. It also can't
>>>> know if it is safe to run the exec multiple times, or is only valid
>>>> to run it once - so afgai nhas to assume once only.
>>>>
>>>> We could fix those by adding further flags in the migration address
>>>> to indicate if its bi-directional & multi-channel safe.
>>>>
>>>> Technically "exec" is obsolete given "fd", but then that applies to
>>>> literally all protocols. Implementing them in QEMU is a more user
>>>> friendly thing.
>>>>
>>>> Exec was more compelling when QEMU's other protocols were less
>>>> mature, lacking TLS for example, but I still find it interesting
>>>> as a facility.
>>>
>>> Right, it's an interesting idea on its own.  It's just that when QEMU grows
>>> into not only a tool anymore it adds burden on top as you discussed, in
>>> which case we consider dropping things as wins (and we already started
>>> doing so at least in migration, but iiuc it's not limited to migration).
>>>
>>> Again, it looks reasonable to drop because I think it's too easy to tool-up
>>> the same "exec:" function with ncat or similar things.  E.g. kubevirt does
>>> TLS even today without qemu's TLS, and AFAIU that's based on unix sockets
>>> not exec, and it tunnels to the daemon for TLS encryption (which is prone
>>> of removal, though).  So even that is not leveraged as we thought.
>>
>> Also, the "fd" URI would not work.  We could not read from it once for cpr state,
>> reopen it, and read again for migration state.
>>
>> Nor multifd.
> 
> Am I wrong?
> 
> I still go back to my original statement: -incoming-cpr  has equal or greater
> "specification complexity" than -cpr-uri.  It is not simpler, and comes with
> restrictions.
Hi Peter, before I post V2 of this series, I would like to reach agreement on this
interface. I cannot tell if you have gone quiet on this thread because you agree,
disagree, or are on vacation!

- Steve

