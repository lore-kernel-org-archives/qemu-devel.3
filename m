Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384FC61DC4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzlBf-0002wI-4z; Thu, 27 Aug 2026 21:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wzlBY-0002vt-TE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 21:15:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wzlBW-0000W8-8Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 21:15:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RHBoF5684251; Fri, 28 Aug 2026 01:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vHzSz5sivbMO5pspH8DjguS3g/hG0kmK+IX+jcxp5Ss=; b=
 JapqR+XN5mCcEGg/2ymdJGFmnWdk6m944cSQTyY60rd8D925JLf0XgBvMjviXTWQ
 uh9KJmj8tZ11oAmSA8hHdPAfj8kxRRtSSMFwbIz2dHPUitc20cs7Cuu18bYTrBDL
 P1Z+P/pYsotF9sNylX90OiObq8t6LeWRMT4a54ScI9uhKyoQ9ZpkTXFPSVn6rX+S
 c3UMlT3NmWIS1uagpeBoCHasn+Htq8JOHbntflE0cWKGEFobRStf9VNOD7Op/i3c
 UxsMfYunp6d3KuQnTvEIb76EvbslwADggWzBQxQJdD/Z7T+A8J/2gEhygdG/nPrR
 u9Ztjatal2VoLAuorKJ7eQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72by93kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 01:15:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67S19sL8010866; Fri, 28 Aug 2026 01:15:00 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84bu3mex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Aug 2026 01:15:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IifrCEvV2wpgzBro7MmqCEwh0NyZuGsbw7r4TRJsaDcgD5qm0x+HTbq4d7jWuF1vLGqjx9UFH2tf7S6p6Fv6mJAY/CKxEYnV6F0SR6b9JCiXkMneSb8kS0UidKOqraSOU6sw1jjFny0fEcGeYGWZFhCxh4TiwutJ88pqdced/nwnTxDPj81t4woerUcMpJItLmIKKHFM/dopsrP+LLDD1poazOL0VgBzrfZCoHPqEGq452TWCrKAXAgzn3j8O5JgEXbkEL0bykifz+Hzw2lz1e0YOoFgzOyURnfXkAe+k8Q1hzxJ8QeO+BEQL7RL4QnUK+rNTnrmSTrfOaNCyaLD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx3tZwI6iwsoHG/4onxv8B+MH3ccSUnAqFGQxRfGn8k=;
 b=TdK0LFXO66MqO7ur847AfOBIsWHtDAGc4oGnsewVS9+YbCQSSdah0OIl4prgl85+x+ZOTR5cMeoMvzd4UvJTii47q4H0RJt3stAfkcHJ0bgfKdNAqxT9GJGTPI7R6Tf6udrAxlEuEL7zT9I3iowNjCaNE+zOIKsJsywSZYScZhCljH+/l24vZTD7U7UAZ0pk16v+3S5Eb3vqPs62x2x3oHU6ejQF1uDRmebSHShZUrDydNQed92ewGBLSt3G0cokkO1qX1WxFV86mL9hhIx6kDJGVLqBAE5J3wS3hbueMkGHZGsnkJJIUuqanMsL1nKhpcQYwo5tIMS6M4ah5a4/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx3tZwI6iwsoHG/4onxv8B+MH3ccSUnAqFGQxRfGn8k=;
 b=0IFoBpU1NfNS5DpbKx+XThixZlJeGztNdmURGLI9OEEa6gPAGvF9jsn6CL/Q4HVa03iPeyHTXzImuOmMmxumDbfzr6QNvjNNwgcWbHpGpHrAqv8L5kzhXBv64BJn7an3ytIh2dGa52HZrf9o03sMYS0AJOv3rLRyv39EuLeDywc=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA3PR10MB7994.namprd10.prod.outlook.com (2603:10b6:208:50b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Fri, 28 Aug
 2026 01:14:56 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 01:14:56 +0000
Message-ID: <73ade3bf-9c80-4aa3-852a-a7643f184ca8@oracle.com>
Date: Thu, 27 Aug 2026 21:14:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
 <14e2f520-e5fb-48a8-9fb5-9b8c451d2aea@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <14e2f520-e5fb-48a8-9fb5-9b8c451d2aea@amd.com>
X-ClientProxiedBy: PH7PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:510:23d::11) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA3PR10MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: aec46050-23ed-45cb-6f40-08df04a1c5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|4133799003|3023799007|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: QsnMrgjs+D7Vuv1JUEypCGaIUv0HxM1VU3s64mQeIEmFx8oaBjCaaASHWVC8cBCr6/wyMVJlyquGMTM8XrWeJDDJCN5wcD4s77Rl9TSXLOYxFe5VlZlqA/+DpCZvXcbJdbgHZccLaegJECXM4JJqonJRWDS5O4Kw27HOr8TZ4ytkWLJZ7A7id3pAU/dYeEXlTVJGxnNUORilCiTuROBv7QgL/0iTvOSltU2B+LmNOuLUt/iJazGcPo49KrVbk94N2KkUeQiz8eu5oHXSd5izB10FKx7VnEE6RczZ+PaDAXelP5lERZ5JB1Ex18TvL000XakEAkPqudwMotG9VfeHvOkQ2RQ2qfi+Z3bzN4vqmUVB6GpFNHByMPsfHelxiDtv6+mN/prDkRfZ97OPamDrGtELMlCK4x4oPjpr2OL/pdoSKmWk7SicS0RWBvmoyWXxIrVZCoOa4muQSNSP2REsVZ2lXGPxFsztPQ20Sxve+jm3xWr/ZZLXBT4dtW04CbvYp4GIc4MLs1bz8w8uoLynG/ov2gArSt8ZnX9P0rdYu8rAl7aAKgjNcsmFNObd2xpz7DD+Y+9PnMnIU4qnzb/LF2RXxOneAg/wGe1yeuhCSun8Zrv0PLLAhpsoX+ZeEjSu9CoQ7SQnl4pyGkwUhn3HlrfWW3DOMOs0kVD/5tXJUQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(4133799003)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVN2NTJyVVRTU1BBQ2dmQkpKTHhqSHVwR0R5SW1kVEhYYVdJWml4QnlMUHR3?=
 =?utf-8?B?MXQrb2dRWnlKaDVtTlNEVHVJTUY3VCtaQ1R2SUFDR1BFdGxjYTZrZzhtMzl5?=
 =?utf-8?B?YktFOG9UdldPb2RWS0FBNzdYQVE3a3RwaW5WRXZBNm1QUVlaT29ZOUVnNnRu?=
 =?utf-8?B?NDhXaWpyNFUwU0lqQ2M2eVFSR2h4bnZWc2V3TFpod2VVUnY5czJVbGs1Y3U2?=
 =?utf-8?B?dFhpRDZ5TmVUcWtqeEhoOUNtYnRaRi9JYXZKbFZlSUNyaGdFU29ZTlRQVExR?=
 =?utf-8?B?SG9OU2lVYVJWWWUxYTd5QWlQd1BUaXRxUnRlWDFDYW9mOHhKejZBc1BVRzc4?=
 =?utf-8?B?c2xKZFhjeGVzQXpVQzlNcXhCYmlCNThKa2gxMzVrQk5oNUNrTEptbVFvaHo0?=
 =?utf-8?B?ZTdYN0U5cWVqdExxbHNYZkM1M1g3MFNqNnp4SDhWZmhUVXdEQWxWL21rcGlQ?=
 =?utf-8?B?WU9lbHJZNmVtK1l2TGwxRm9PUnEwU281aUJpWm41UFZMdTNPd25acFRSVnRC?=
 =?utf-8?B?Ym03Rlc1Z0lnNkFIcEFPQ2I3VkF0S3h0RlNUVkxjbmNhZzZGTVFXYkVSbmlC?=
 =?utf-8?B?UDVGblpGU2FNa0VubUxuRjMvSmIrRFBpMC9yaFQwMnk2N0lEcEJoaFdtdFBP?=
 =?utf-8?B?YTB3NENsdXR2em1KSHg0a24wUGZPNUFUUWNaSDlRQzB6YUN0Wk5YRExvb3Nu?=
 =?utf-8?B?MFFTQUVvWkU2SWRtYlBFdUlxT1dZaUJXRzJ5eUg0bWpQd2NmcDZJcCtmeWRT?=
 =?utf-8?B?OWorMHZuNGVKOUUyVEx1elFMZmtMbmR6Tm1tMlp4aGRSVjN1dlV6YTZwZENB?=
 =?utf-8?B?MnZFdFIwaWk4UVNtWkMwNFF6dzVuQXFZejZjdHVoclBRWDlucUl5OHpDbzVh?=
 =?utf-8?B?T2ppd2Y1c2dZSm9EdVBhL1VsQjc3ZE5wcXprUWFKSGdxTXphQnBia3N0WDBw?=
 =?utf-8?B?ZmZrTFpUYXhaSVZ1OUtBSWowMHB4K2h1S1gwcnRQL2J6TGdiWU0rbVZBclor?=
 =?utf-8?B?cUpBNGN4WXJ2NkNWRzdSbmw1WnpncU1CYktoZ2grMDhDMHJxdnJLMS95RDdj?=
 =?utf-8?B?bS9BRnpnZ2E3VithNmYwc3dDdisrTFFNSUNwRHdZNDdMaCtsdEZ4akJvSS80?=
 =?utf-8?B?MlRQamZGb0VHT25TVzI0ZGVxSkJ2akFlN2ZjcnJwd05hektXY2taTXFDUnVT?=
 =?utf-8?B?VmltS3hmdEhwR1VycG9vR2ZSKzZ0Qk04MDBTb0tsLzZhTnZvU1QzMS9xQk1h?=
 =?utf-8?B?cURHa0lyZGxDNEQ0Tkl3U2pFRHI2Ukd1cWVNRERqVkxra280NGVFQktoTFQ0?=
 =?utf-8?B?TkpFcG5tYUdjRjNRcVhrczFoY2hFWmJ2Wmo4VDE1dGsrWjliajNXRDBPU0JJ?=
 =?utf-8?B?MzNCc1JCclB4dUlIWm8rV1ZjOGh5eDNxQnZqdUF5MHdlU3BiU2MvMG42bklQ?=
 =?utf-8?B?VVZ2cTFhVGViOHVrOHh1ZFU5Y2dFN3dwVWtOVkNVTGF5a2NzWm03blhuMzc1?=
 =?utf-8?B?eTFFZnBNNFRDQnpUeFU4NjVhWlNqdm15YmRjUm43cHlJTDlJNnFHcklDU2VD?=
 =?utf-8?B?d3VhbksrNTNqQzNEWDdQMWJseE80ZGc0WlZhQVI5cFQ4UUhETVpIa0I4NGlF?=
 =?utf-8?B?Tmk0ZWZ1cmZycVFiY2ZMN3l2SUw4L3lwZXNEK1RKUm5xeEdEL0NiTlNHYlVo?=
 =?utf-8?B?L05CQW9wVFk3cTBmdVIyVmxpS1VmSlhNRE9UTHE5V3diZ0RSY1poWGlDWFA3?=
 =?utf-8?B?L2dBYlFBQW50bjExSDdYWllmeXZDcGQwVVp1aG40eC9hMzZWNDhpdHJ0YjN5?=
 =?utf-8?B?bmpnZDJ5b1VRS1BudjJsbXpxVDJLZjlQTGNRZkV2TlMweXF3QVdnTFRZNExH?=
 =?utf-8?B?UG0vMmdVdnBLVjJYR2kxRlFaL3pWTWVxYjRCVDFoNUdVd21tR0xpTWZBTGpC?=
 =?utf-8?B?MnZCVUVWVEN5eDBjT0FxWERnNVBFcGxMRnBxS3ZvaTlNb3JLdURVUUd5d2J5?=
 =?utf-8?B?citLRHRjNGR0RVlWQkpTVXNiNWpQYmkrTnpOVlZORkdkbk9Ma0hlUlhqQXQ3?=
 =?utf-8?B?dmtlTytET0I1MUZRcTNGaDh5OTRYVkQrRFVtVlY3MTIrR0V6enNHMU9CZmVJ?=
 =?utf-8?B?eGhxbXkwbmdaTGlWcWlOS3VHUWxvYkoxOWUyYTk2UlR5d2RGdnQxaTVuUEZ2?=
 =?utf-8?B?QjFxS3BIWmdmcTlpTGc1MG9iOXV2NFBCRG5oVGswV2xjQ3c0OW05OEtMNWF0?=
 =?utf-8?B?NnNkSGNiM1RyMld5cGx5ZDIvMWtrbGpxb0pQb1BRVWF1ZUFDK2JscTl0YkE2?=
 =?utf-8?B?dldWYnVIL2djcFBObjh1OVo2RTBRR2J1c3VOQlJuNFRxL0c2ZjZuTk1xZ3Nr?=
 =?utf-8?Q?1aap1vkjnuLf2ODQ=3D?=
X-Exchange-RoutingPolicyChecked: XWqubOWKQXaRe3P4lIaZouybmdJkH21CvML2CIS8u5uD46h27KwDh66tQ7h60W5oVf/0BkMqtNMwRog7VZOOLIw09oYyVv2URCkHufJWxh1txagxzf3L4tTRsNZb3UQVMRM6dQH9i9/qL2YGWUlkSHXX9ADdFi5q/OJFPM27+gvM9I4gNpuhLg/6BSReQW5TY22Nyz0Dn3M17r74jMrS6IH6iF9wySwl6OtOQ1k2xHSl6Z6/+QngWd7E0rSwHgx/Jxn0qThEo161R+uAZKpHsu9o69YmcsFfrrn3JCdeaeJ6Ms5Rl398IgV9SIoYf+oJVKPilokr+yxox69Uk/OE8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X7JMNJZjl7bdGWdpptHHUGSYxFmvEyPIkUi0jWHQFJ2bKt2E9mk5+ExPJPuSOy0jZphA8fdPZoqaIYiaT1EY49/DhS/FwuJpA5PH+Vz4Q8TXc7ocJcDMVBXwOjvCuztyKe7YrnLqLUAwsI7jBf78zW5YXhKiWSbcA/LeBmN7JFY9QIy1uH1R9Hc4vIkkoh1TrkWLWSCWraJ4RKBIBe6TvpLPADYEH1zJi5xomZoC1ynpj/2fs4P8I018drKg34dXc2UxA26qqW8I6Mg2bV1CZX/kUVL6A4gKZs4bwclw3VX+2NNGIbGXeSah4b8y0NKrNn1sU2DrGjW/I5xnSCEputMbjjTxmQg6cqcaACYjFt/EC5FSIpdsAHguZu5OfLITp3YmrPqyd0I+VDpZy3XA4jbxVAvJjPHqfeVXSZyU/Oppmtow4eVDw/m3ssbQn6MMnTZkox13UFgEtKCj/MuAbJulJcmhC7yhoeBbJUTKDqpq4CJrxrZpwFJ0zOWqCroeiQX1W5/Hmdc2Xnti+a4luecUohPBVXKmcW5zRFpW+BTqtXq9lsPkw8rGXMA0FG1mIY77cQCkqQdbscrHjq60HG4DYOy3fM1sVmTyn2locao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec46050-23ed-45cb-6f40-08df04a1c5ba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:14:56.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQKuJOKXwKiYtnkmO4jVcL9agBIWUQh7fm+vZKFtDNr1V75q/9bHQwjkkibdn1kBxiODQwcJitT1mIfr3SgOzfU7SdeV0ZaJCoBPaIr0T04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_09,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608280008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDAwOCBTYWx0ZWRfX8/8uqzWGeuxt
 bClVEMJ2UhZzvc9LUxlOkkXG+On4/WHf/HoiDkLJr9h/gLYX8Ah5vna57ZFdd/+o2BL2iZX+HBB
 lVtrouPBcwl243YIZLyT/SfNyoiBmmB12vfkxt8z/XrCtZw3Bf51s/tCPvByAKtCoMKEoWhPHru
 DZhzS669UovKol5a5lfEmVptSdt02dIQ4PZPMi/wLV9NCvkxQE4nUVAs8jarty6eSZTTI6upUr8
 VybCwjWIdjf314LC91T7MU+DpVo9yw3iYxHHUFmwPPwy4RhBN1iOqpXBx+g9fyKprlbCy8dLYaA
 wQHF+c8JCbTKEeyIX8rIeHkWpUA7ZtRdNWAfFO3DA8HQ+4mT8roaDeXIKUL9EfUfLCaCxiLjRDe
 lScM+8cH0PMqpdkW5Mn3S3+5DCWB0VEahpHoGOFjw8b6KAzygF4QDOSXqG0bNaciGfnJXSI9gqM
 DJJ1PY/Q63Eaqild0EA==
X-Proofpoint-GUID: CfzynTEjZhR0XAqEmFn2BJ8b_poJIg0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDAwOCBTYWx0ZWRfX9dcnwTxZzOta
 mSjxL8x0c3wgBdWnMt65NRfgvA6gWpCIxVz8wjeNwfDDYNas0bd7kaK23dfmZDpRbaGP0RG6xpp
 SbXShj1MfCRZ1MzdaiHVVEp97k2NpEgx5rAeATTXH5DPTbtvZw9a
X-Authority-Analysis: v=2.4 cv=fqTsol4f c=1 sm=1 tr=0 ts=6a90e115 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=RpNjiQI2AAAA:8
 a=zd2uoN0lAAAA:8 a=07qADqzUYRaE49RRyPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CfzynTEjZhR0XAqEmFn2BJ8b_poJIg0P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/27/26 2:18 AM, Sairaj Kodilkar wrote:
> On 8/1/2026 3:=E2=80=8A17 AM, Alejandro Jimenez wrote: > > On 7/31/26 8:=
=E2=80=8A32 AM,
> Sairaj Kodilkar wrote: >> On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote:
>> On Mon, May 11, 2026 at >> 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >>
>=20
>=20
> On 8/1/2026 3:17 AM, Alejandro Jimenez wrote:
>>=20
>> On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
>>> On 7/31/2026 3:=E2=80=8A20 PM, Michael S. Tsirkin wrote: > On Mon, May =
11, 2026 at
>>> 06:=E2=80=8A09:=E2=80=8A33PM +0530, Sairaj Kodilkar wrote: >> Currently=
, build_amd_iommu()
>>> uses "addr" property to build the device ID for >> IOMMU device and
>>> advertise it
>>>
>>>
>>> On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
>>>> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>>>>> Currently, build_amd_iommu() uses "addr" property to build the device=
 ID for
>>>>> IOMMU device and advertise it throught IVRS. But this property does n=
ot encode
>>>>> IOMMU bus. This will be a problem if IOMMU is attached to different b=
us.
>>>>> Hence use iommu pci device which provides bus, to build the IOMMU dev=
ice ID.
>>>>>
>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>>
>>>> But is this called after firmware has enumerated the pci bus?
>>>> And I guess OS better not change that bus number eh?
>>=20
>> The above line sounds fairly threatening :) so I dug a bit more into the
>> details.
>> Short story: I tested placing the IOMMU behind a PCI bridge, which the
>> implementation currently allows, and the guest can (easily) change the b=
us
>> number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS beco=
mes
>> incorrect.
>>=20
>=20
> Hi alejandro,
>=20
> Could you please share the steps and commands you used to change the bus
> number inside guest ?=20

Sorry, my earlier statement was ambiguous/confusing because I used DeviceID
referring to the name of the IVRS field, but can also be taken as a portion
of the BDF. Let me try to be more clear:

I did not change the IOMMU device or function values (I don't think that is
currently possible). What I was able to change is the secondary bus number
of the pcie-root-port above the IOMMU. Then this changes the IOMMU BDF
(more specifically the Bus part of it).
I launched the guest with this topology:

  -device pcie-root-port,id=3Dpcie-rp1,bus=3Dpcie.0,addr=3D1c.0
  -device AMDVI-PCI,id=3Diommu-pci,bus=3Dpcie-rp1,addr=3D0
  -device amd-iommu,dma-remap=3Don,xtsup=3Don,pci-id=3Diommu-pci

so firmware placed the IOMMU at 01:00.0, behind root port 00:1c.0.
Inside the guest:

# setpci -s 00:1c.0 PRIMARY_BUS SECONDARY_BUS SUBORDINATE_BUS
00
01
01

# setpci -s 00:1c.0 SECONDARY_BUS=3D02 SUBORDINATE_BUS=3D02

so the write is targeting the root port (pcie-rp1), not the IOMMU endpoint
itself. After that the IOMMU BDF in the guest is 02:00.0. IIUC the standard
lspci output displays the old BDF that has been cached by the guest OS when
enumerating the PCI devices, but setpci and lspci with option -H1 will do a
raw access and show the new BDF.

# lspci -H1 -Dnn
[...]
0000:02:00.0 IOMMU ... [1022:1419]

The IVRS table is not rebuilt following this guest write, which is I think
what MST is warning about.

Now we need to decide whether that operation I described above (which I
found researching ways to force the change to prove Michael's point) is
something that is considered valid. Perhaps there is a use for it that I am
not aware of, or perhaps it is just another way that a guest can break
itself and we are just supposed to let it.

I do see your explanation about why my initial proposal is too restrictive
for the future. I am just not sure yet what the right solution is.

Thank you,
Alejandro

I would like to run few tests around it but I am
> not able to change the PCI ID of the IOMMU with setpci command on root
> pci bridge.
>=20
> Thanks
> Sairaj
>=20


