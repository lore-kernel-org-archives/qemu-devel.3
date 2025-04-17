Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE4BC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ULE-0003uv-CY; Thu, 17 Apr 2025 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5ULB-0003uJ-Vg
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:52:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UL9-000694-Sd
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:52:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGN99m019609;
 Thu, 17 Apr 2025 18:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rfEsaLh+0KQVCJVqGuT1e0I1IKEvLOhF9K4hNttu53o=; b=
 V067Zl22WRjTU2TzYV0NuS84bb0+HmGpLK6HxPZ2YmmM+ggNRfGmVMsCcEEGgpTM
 BBPECyBGGZJOvCGbkfcE6KpDp7Efy8QochTsJ1PItQjfuhbxH+ZHzdk4vd9gKYOQ
 TUrnEm0RX+35haHScPK6sfcQHl9iexh8Ngfv4lwU2Xw6r0sKtougInYDNxKvU6eQ
 RtGNLpy46+6NXbkigZCAB9vpM4uhxx0uBCVSDJ5Wmyj7A/jUWZAs/dNHVu+jwvOS
 cjzq7ZIZsGuz2bVah+K2/aFgmQENaaPUXqKtAsgqT2/ysudT76Du0FFfmAPS0Ndg
 NcHAkSrKwti3FY1cJM3Q3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd7190-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:51:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HIouSK024638; Thu, 17 Apr 2025 18:51:51 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013059.outbound.protection.outlook.com
 [40.93.20.59])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d53wmrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdB9BsciEWx6hBopsFyVRmSV4YnkM36py6jRr7rl6p7pCHk7NMyAARFeR590xo+UO8KyFfbjxHV7l3ewTJfc1dzjWC08BssRRoRkPg4vjXi+6Ab9utxBpeZ4SclGXQYK2u/ZYxJfDPHJN5Zfs3EtgjmrfKRZnQfVgvushCVdLhB+0ObxW5OrplN5BIsYKY9k5ilnpoaypmunVjVRMb6/0zxd+9FF67KPLIZkn7NV3N/NIXOGDAzA8Tssi7JnWjXa5CkTjpsoLUgWxp9jEwjVwQTyk0Yo9WJWdpkqTTPN5DHo7uPDpUmAaRTz6UKeATEnNYYQrSFKkNYx7IJ0YwQhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfEsaLh+0KQVCJVqGuT1e0I1IKEvLOhF9K4hNttu53o=;
 b=Ri1ZRJQttmu2/YDe2kClmtRS1OIU5/iGT0FNjbPl/300hiG5a91Py6PutcrDRaf/DgQSPAeU4A9f0GJqeztFLoit+LxOM9lRUgkg7vj6yfAdp8RJXvDxSWRb31UZ1GrDDAcQ8gk0Xhyh73bHwJZR6zCT5cUED0m9XClRRpOfp820mLeLFpamPeOCAnUqaAFkmrqtXCYXUf8fGs8sg40OnqJy0bN0WaOr2LcRmWhKXFvy8smHUvpNXibl4lpElTL21LRygahDdCUeKwIibTA3njrCnY0Z8W5tjeU3Q0HvRniZj0Ug7YyHBEo/wioWKuiggaRKZCbhMsfKJ1j6eDAtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfEsaLh+0KQVCJVqGuT1e0I1IKEvLOhF9K4hNttu53o=;
 b=SHLS4jUCHNkKIob0ysYZlHK6L0F2nYCmz9Lqq10pN92z8xg8VequFdho+WwBpcwUx2nkJjwncBpGUiUINZtNokEZ+TtC2a5XSmzsanzjzSPj8bSIqu25buMf1pFNCs/ANHAZ1L+Ila+qEzpIQb25MDmB1WV36osU08l+6QOqEwk=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS7PR10MB4927.namprd10.prod.outlook.com (2603:10b6:5:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 18:51:48 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:51:48 +0000
Message-ID: <5ee459ab-a27e-4086-9b92-49372a5a303e@oracle.com>
Date: Thu, 17 Apr 2025 14:51:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204517.3043-1-annie.li@oracle.com> <875xj71cg1.fsf@pond.sub.org>
 <d2b18212-495a-469f-8c6b-50f0cf54dc96@oracle.com>
 <ea2f9a9c-a2ee-4175-83bc-d83540777b0b@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <ea2f9a9c-a2ee-4175-83bc-d83540777b0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS7PR10MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 306bde47-e05b-4c94-2d24-08dd7de0e8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9HalJBbUpSN05SbXJLRWV0NEdpTWovM0xEdGFseE9ubVA4ZEdkRlh6NEwv?=
 =?utf-8?B?YnRxelFBMXhDS003VWhrR3REUUN2bXQ1VW16K095cSsyZVBIWUVVWU8rMjYr?=
 =?utf-8?B?ZytObWZDdnRCVkx0b1JMd1JTMEpMS29pNHhkRDM2UkdBbWEyMDlVeHZ0eHNn?=
 =?utf-8?B?UExQSWg2aFJuUHJuS0lBZHp5UDhJaDFxWFZVN3BrcHJNYzFrcDZ3ZzJDMWF4?=
 =?utf-8?B?cDFTTU5aWE1makdDZDZjdUgrZjRWNXE2di96U2l2bmFIenozS1dXcUNjeUdX?=
 =?utf-8?B?cTVib3BraGxWRFpxSS84L1dZUjBjTFhpTVhNYWxSQkNNNy96WHZmakJIbU1Z?=
 =?utf-8?B?RGZ4Q2tYOWovZWl5a2t5ZEx3cmhTSmR0dzhKbERWdEd1dDhNTjQ1TmY5Ri9G?=
 =?utf-8?B?dHIzRHJ4YWlpZjBBN2hzdXZ3dFdGUU5WcGdST2c2VVJpMHBqWnV1OHdGWFhv?=
 =?utf-8?B?MEZGK1UzMzIyeFhtMHA3dEhtU0l5WUNWU0pxMTFzNWswbjZOQkErNTNJY2Nx?=
 =?utf-8?B?UFJGcHMrNHhORmFFdzVQWU43dDMvYzhhdnNNZXd3c3haYUZYcFZaelZFbTZM?=
 =?utf-8?B?SEJ1eW1sSmJnUzlNZ1BQV3FFM1dlM2NDNjdOV2RmeVFnL2E2WFJIdXVvL2Qz?=
 =?utf-8?B?NUVIMFpUdjNRd3BMeFBtcnRlbDlhNmNlT0pkdkxIbVI1d0ppL1A4amU2K09Y?=
 =?utf-8?B?SExpaVMrUWVoRXIyZnp3Qis2UVhpQTR5T3pjaUdBQzJNVTdGL1FZNFI3VCtH?=
 =?utf-8?B?N0NobGlTOUhiZ1VXRGlsYjEwQzlhUXpsSWF4Y2NrbUlTZUk3VGUxRU9ESHll?=
 =?utf-8?B?eFNOSVlsMUc5YzJta1g2aFNNS0tjYmZSR3ZUM2JkNkc2N3V1WnUxcTNtbm10?=
 =?utf-8?B?VWJ6Skd5YUNVelljWVpXYzVyRlFHemx4NmlYYUdFUGE4QXhVQzVUWE5CVEdk?=
 =?utf-8?B?NmNyL2s5U0VoL0ZkaXZZZXNnL3FKNW9LWUxzd0IxbkxwVGZ4N1ZkMjlKYW84?=
 =?utf-8?B?bStOQ0dxZlRHcmQ2d0p6M2lzR1RRMERLSkRLclpacWowRkd2UEt2U09CTC84?=
 =?utf-8?B?M25NMWhNQzcxaU02TDcrdWVDd3FwQ1hQc2FBM2d4czRpZUJVb0YrUXBOSk9R?=
 =?utf-8?B?dTFYWWdsa0M2aUVWNnhjWEIvN3lNL01LbmdWK21kanJoNzl3V2p3V1BpT3Nn?=
 =?utf-8?B?OCtOcDZGUWQrOVE1WDZMZlRwNHlvTlFoTVBqSzNaTnJmT3lIYktpUXFqOTJV?=
 =?utf-8?B?WlRuU0JvV3UrQ0cybmRTUW44V1Y4MlRFS29iSEdsYUY5WXp6NHV3bkZYWVJw?=
 =?utf-8?B?Wk5qbm5FYnE4bVBBM2g1QXpmT0NYcjJWMGtyS0EyQVFSdnJsUmlhSEZSV0ZL?=
 =?utf-8?B?a0pTT1ZWZEhwdnByRDZ1Zjh6SldTQnJzTlRpTXhRSGlmc1ZWM3Z1NnFYa3Z5?=
 =?utf-8?B?ckZ4ODJwbEhyRFhYeUFlYlFyaElJekg5UFU1R0NodTBJdU41RnNEZlo3aEhn?=
 =?utf-8?B?RTNLTDhIam5Vc08wR3NUalJUTTQ5bjBjQjFJb1ZWZHltbVZIaE5LYjhOR3dv?=
 =?utf-8?B?RUZZMk9CTTBrTFdmekIwQUdrUjRhZnY3MGtnN3NzYitmK0xrYkpldG1ZVVR3?=
 =?utf-8?B?UWZLbTFvREh3RlJPV1JicFZYZ0VkZnlFcGhGVURNdXpLc0xtZFVDTmRXTGRY?=
 =?utf-8?B?WEtZZE9iOWZQaGt3bW5iZ1FIK1dTalMyWE5yODF3ZkpNZys1ZmxkM3lPdVo5?=
 =?utf-8?B?UzVDTUNKeEVIZG9JM0tVaXVsNUp5Q2cvNTNiMWZSQU83UlZmVVJ5bnlxamJ5?=
 =?utf-8?B?U0NmckFiL3FxdUEvU28rcWRqYlU2VDY2OXYxUVViQ0UrQlNtSUI2cGdaOHox?=
 =?utf-8?B?K0hBRTJKZnIyUTZ6cEJsazBMUkFVenE1THU1TnBHcnFJb1pWbVNEdjIzL0xJ?=
 =?utf-8?Q?9q274K1thQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVIRkFjUUVXOFFVQ0RTL2hpSkhidTkwckRQeStsZllkdzIvS0EyWEZmdnhQ?=
 =?utf-8?B?THdWRFBxTzQwY0srL1RWazJ4SnRBS2lyeW45c3lySEY5VTRxaVFOcXRJR0xo?=
 =?utf-8?B?c0JMNGlGZ20wQ0tTR1NYcWRlbUZxWkFIa296Ly9KbUhNc1NwVkN6eTNIcTV0?=
 =?utf-8?B?ajQrOUgyRHFOekFzVDhaK2x4K0N3R1V3MVp2OGRTUDl2ZWlObGVVTlp2d2NG?=
 =?utf-8?B?cVpjeiswR0RVdlZ6NmVSc1RwMWJnVURrRWVnUEJtYi9sZmd2SHlPMGNsMWRi?=
 =?utf-8?B?WFNXNC9lM1pGd1IrMklRWjRhbHFoQzVzS0RFTzFXM3RKSnpsQnpGOURUaEg4?=
 =?utf-8?B?OXRuSVNLK3dFK3o1b3p0STRLbHBKZGt1YmVTdDJwV2xJR3JRSHFRRllhSW1R?=
 =?utf-8?B?OGVZVXZZbVVsWHZlaW9zNFdwOHBCeWRqbm1GSlA0Q2FDVTlOTUlUK2lIZWJZ?=
 =?utf-8?B?bXBUSUNiSi9NaVdCWWhGd0ZiRFVRNkVaTHpsL1dZRFFyZWZDNEhJR1Q4NXdt?=
 =?utf-8?B?NmZSWVlVc2JiZktpdi9VaW9oQ1VTVzRJVHhSVUxvK0N1aHhtVFpPaTBzdVlt?=
 =?utf-8?B?U3FrNlFWVlZYUkptbEJiWC9mMWhaU1lnNFc1SWUyRlhtd1lrY2Q5RnR4ZSty?=
 =?utf-8?B?azRMeEpKZDlIdVc2NlIwaCtjdkNsRDhBRUFlWkwwSEZNYytKM3VKRjFocEMv?=
 =?utf-8?B?eTJKZnN0UzlXc2lZbUlVc285bnU2VnFhNzNLSlp1WFRkRjlaRVFQb3UyTWRq?=
 =?utf-8?B?NmhUNVU0NUR4MXNUc0lFZEpVZWdRSVF1Q3VXRk1WbE1XNE82ZHNZNFdYRThy?=
 =?utf-8?B?TnRqNXd4Ri9kUmp4K3J3dWFINWpVTzBZSU9aWitrNGNiaDRPRzEvbEhHcGJJ?=
 =?utf-8?B?bm9wQjBadDh5K2R6dEpxc2NjSm5Wa1lWeUNvWGN1enJHS25qUk5manZGNXVZ?=
 =?utf-8?B?WHUwM2d6OU1zeVVJTnRRSVFkOUtyR2JOZU5pamVGa1djNkI5bDN1YjNaZlB0?=
 =?utf-8?B?WUxkT25LRjlvYUY5WUcreUFCbldaVDZQeHdjYkJ5a1lsb3VFblQ5WDJ1VFo5?=
 =?utf-8?B?SS9wQitiYVVvcE41TXhJYVBWLy9GVlpFQzEyQW0wQmNnUG1nRDZmUzd1QWVi?=
 =?utf-8?B?WmdYMGduMUZQVWJFMHdUUm1EV3o4ZytYTmR4dUp6a1BTcnErSGY2Mng3VFkw?=
 =?utf-8?B?NjNlV1BaazdVaVc0bFZ5Sm9ILzl0OHhiYzhyK0VYVytCWVZ3c3pPQVdXVHB4?=
 =?utf-8?B?WmZjVWNzb0V3TUVYNzNDMnUwdGJ3b1VRRmk5RDk2aDU1QUNzdUxEZm1tN1p2?=
 =?utf-8?B?Mkk5bmdXdEw1TXExTjJqWGVpM25rQmR4SFVSZzlYZ2VPL0dac1pLaUlnaDJS?=
 =?utf-8?B?eDNwZkh5RXBLSzdzNUkyaSsyaUVYOGhmVm1VUGEzeDRVdXo2QlFleWhtUWVI?=
 =?utf-8?B?Mlh1VWRZYVQ2K2hCMDhzYTZ1amIzZmlNUStVUTZ1WUZBL216ZTltUmZQZWha?=
 =?utf-8?B?cnMzOUZ1OURqSlNoeE43eGFMajZjaTBXa3dFaVhYZzdZYU4xc3QwY2Y3cWxr?=
 =?utf-8?B?am0rV3cwY3ZtVmxqT3huQTlQUkY4OTV5WmpWT3lxWjZGTG9HL0FCSFNiVnZT?=
 =?utf-8?B?SXVpMU9walVjSDdOdW1zeTZDemJzSTVTeDhxdGMyNTd0dnAzNzR1dzc4WUs3?=
 =?utf-8?B?cmZmNERMSVljUDBESEY0RWFYOVFNeGVJSC9LMHZaTkhicFh5bytrcm5hcU1Z?=
 =?utf-8?B?a2dLTERZazFUYmtxaHZVdW5wSjg2cmNpUFhCSVNZMTBkRk9uRkQ1U1Iwak9W?=
 =?utf-8?B?U2grN2NDNitkeUR0UEJEQTd4VTlsZlV6VXZyMTArbmxqVE5YYWFpVUVzYUZO?=
 =?utf-8?B?cUVaSlZWeWlYaHZQazJOOVpRVWRjTkdkc0E1dExlb0JXMFhGQlVNWm1aWVdH?=
 =?utf-8?B?cFMvbWxJMkRQUnFRYW9UdWltUWZ3Tmh6cTFMZER6OUQ1UWkzcTFqSlM5bU5M?=
 =?utf-8?B?TysvT2RML2hSbEwwVDFpckNQQVJTUFF0NEl1MGtTZVQ0NjFFdGJid01kaEM4?=
 =?utf-8?B?UHR2TW1WODJGYy81VVBBQ1VCRXJHZURlZGhWT29LODkraEE4eTFXRDJyZFZz?=
 =?utf-8?Q?Fw/PNc6+a5DwOnOVimm3uZqvU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ko/a5rZXeqHDArKMZherDiZ3udSziJUHSFACQueORgx4myf2GRArk9088gAZSeGI5WJumbBKiEHGfMEP+yQUyfkSCR1+VtaaHgR6afPqP/ZQpORCse7Aq6HUuDBTf3uDOahDtADbyXqgmflQGvUO451Ojb/D3KOusIG6srIw9wrh3KxXfs5ovFT+8eMizHPGhaqtqma6Boo9Bh+ZhhepZ1Q3qW12muFyGzr+v6cXg4+BDhjIBkVbsgE2VQarf4LDQwhQts0VvkGdHYkJZY0RxGFZbZHdvA8GJK+cweyAHWwUwy2ciVK8C7MDkMCw1gq7ceu58IVIlspLAEG8JOJ9VGdy3zPQtn1rxhWLTk8bflZsz580+ux07tKKZENPJxyE8x40Hy7wehZ8IoYolLbVfDfcITfyxizWs9ksUBKgpfuAESzppVtkGfJmF03JJToL5P1rWojRGu1aRxNjGaZYFn22+IpmyK5GwI31CI8ysIWsM1tRCNo/NmFBTfqU/NjdHMjv/2Ch/pZaSxhH3x2KtX/Z6Haro+ZjxQrIu4X23fno6/o+0kChTgJJ5mPrK/JnEXK1vqTHFoWuPK0bdpJaH/rLx0i44S4Mz2bJYvkby+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306bde47-e05b-4c94-2d24-08dd7de0e8b7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:51:48.8764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buR1QnEsSPcpH6P+4nnaG5M+U1ZMCx4BLPTfFluwY4xrnwa4WbgDltlzyseKPQh1ige4cgg6S8wfEglXBu0hiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170138
X-Proofpoint-ORIG-GUID: cMF_nCKvUJk2Ex1eHREHehdLeMvMO42K
X-Proofpoint-GUID: cMF_nCKvUJk2Ex1eHREHehdLeMvMO42K
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:37 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/14/25 11:14, Annie Li wrote:
>>
>> On 4/14/2025 2:31 AM, Markus Armbruster wrote:
>>> Annie Li <annie.li@oracle.com> writes:
>>>
>>>> Followng hmp/qmp commands are implemented for pressing virtual
>>>> sleep button,
>
> nit: Following

Oops! will fix it.
Thanks for the catch.

Annie

>
>
> Cheers,
> Gustavo
>
>>>> hmp: system_sleep
>>>> qmp: { "execute": "system_sleep" }
>>>>
>>>> These commands put the guest into suspend or other power states
>>>> depending on the power settings inside the guest.
>>>>
>>>> These hmp/qmp command are in '*_*' format, it is intended to do
>>>> so to align to existing 'system_*' commands.
>>>>
>>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>> [...]
>>>
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index a6b8795b09..0965e78f4e 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -361,6 +361,26 @@
>>>>   ##
>>>>   { 'command': 'system_reset' }
>>>> +##
>>>> +# @system_sleep:
>>>> +#
>>>> +# Requests that the guest perform a ACPI sleep transition by pushing
>>>> +# the virtual sleep button.
>>>> +#
>>>> +# Since:10.0
>>>> +#
>>>> +# .. note:: A guest may or may not respond to this command. This
>>> Two spaces between sentences for consistency, please.
>>
>> Didn't notice this, thanks for pointing it out.
>>
>> Will fix it.
>>
>> Thanks
>>
>> Annie
>>
>>>
>>>> +#        command returning does not indicate that a guest has
>>>> +#        accepted the request or that it has gone to sleep.
>>>> +#
>>>> +# .. qmp-example::
>>>> +#
>>>> +# -> { "execute": "system_sleep" }
>>>> +# <- { "return": {} }
>>>> +#
>>>> +##
>>>> +{ 'command': 'system_sleep' }
>>>> +
>>>>   ##
>>>>   # @system_powerdown:
>>>>   #
>>>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>>>> index 023a2ef7bc..285ce82e9b 100644
>>>> --- a/qapi/pragma.json
>>>> +++ b/qapi/pragma.json
>>>> @@ -23,6 +23,7 @@
>>>>           'set_password',
>>>>           'system_powerdown',
>>>>           'system_reset',
>>>> +        'system_sleep',
>>> Additions here are always sad, but inconsistency with the other
>>> system_FOO commands would be worse.
>>>
>>>>           'system_wakeup' ],
>>>>       # Commands allowed to return a non-dictionary
>>>>       'command-returns-exceptions': [
>>> With the spacing nit touched up:
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>
>>
>

