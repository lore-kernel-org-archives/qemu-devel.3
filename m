Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 23:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMbB7-0002kI-5R; Tue, 03 Jun 2025 19:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uMbB5-0002k5-Re; Tue, 03 Jun 2025 19:36:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uMbB3-0002RI-CF; Tue, 03 Jun 2025 19:36:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553MNXus027266;
 Tue, 3 Jun 2025 23:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=B9pdpdu1GAvbS+w2OtWCu572c70QkXxd1yGwAJTmt7U=; b=
 UyBJ3p52nfRrtHPmDV1lMyKbOXnu3+fkMtSZRdl5g75nYDSP78ELF2lckao/QyQn
 g+y5l7ZTwpChBDTdfHPfbmk/lHXgUts4D0hDOxW7BbK52vL5T20+uY6yVFsohvRl
 SMxwXNQCaArns7DqebKrPTTBNP5KOMfubAKxWECocZFsEK9vYNToBc6VB8vYKClv
 T9IfdbYm1KCHBCXVPUWSSJhlH0dwP2RknZa4P6v+SSpWUIIpLZh7pzqhq4dorvRk
 Ck6ia6GU5CRVHHF8C7fmSqB1ir06H6X6tcTjeKQeVsRJCp7gcRB2Eh5xu56S9V5w
 SZgkjnun5jXeIy7kyNy0xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kaxrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 23:36:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553NAxO7040095; Tue, 3 Jun 2025 23:36:05 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7aadxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 23:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB7YUKXTrHZMJQFdoTe730p80jCAr2TTWpMwvmYwngEUTDdl1Se9Hrd4Vr3GHNGtoBCNhLV5eTBugt/zD+aPjW9YZbDbStHJ/Ax2RX0L13G9Wu8v7TR/m+vsNupuoZHxoFZhKEMjoB31JoBSKPS8S9sH5g8RGB5BN1m8OmqXKcFts4v7CzRih4BX4IR49StQXk2vNU4SFSO6XztMRh/qkrO8rv3wc+ByOoqm7C5TdqCUfUTKNbPx/K6rI3Z7HBac8wv/J9yE/FI1ra3w9yETriDpv3U3aE9OCsVGeU6o/3QNuzkAwCWMO4VSXMICkaMtKttiZES6UEr+N05Tpj2Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9pdpdu1GAvbS+w2OtWCu572c70QkXxd1yGwAJTmt7U=;
 b=B9kH4N1E3NvUYKJiitRqWlQga8ztyxAFpxlMGrhM5vYFKxJgZUVS/NzLdDOq9kDTAlBYvCLM84lVigC5cLdjWXTqO0tlbcZm96dPMkKihPpZGYCQuyIMPJnw14BQ9tFyww8PqvwB/seC3Lo6KSM6Yb1fBjEkzLHUgriadSDKekzKPKLAebIJH9IBdz7zNL/N/xJnDtRwqHRcn3gkCCWzuzuJGpiMK4lekSchianoZ1WehOQywkz0Dd60tlEYJW2KMEl15MK1dVRL8+AIXD7q6UgLBKP82wKqdKwzdkzxn0W5bexlOLLG8n5tk/gKRe2K4cjOvdXZA94E5SR/e5Dhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9pdpdu1GAvbS+w2OtWCu572c70QkXxd1yGwAJTmt7U=;
 b=DCiTxzyS+QLOnrddD6C4YF9b7W/Q4HDN8pVKdQmD6YDuIeJR7TNah2WeHWSiQjdKaBySZ+vwYsehPMt7MZ8zYxP2Mkvt8E0JkiIi2HQtV1oJHtTb3Y+ZUn9SCSkK72zggTN3i/VVnY19b5JKnBFC6morp8zxZVhBvoNM8RiMYG8=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH3PPFD7011BF84.namprd10.prod.outlook.com (2603:10b6:518:1::7c8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 23:36:03 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8746.035; Tue, 3 Jun 2025
 23:36:03 +0000
Message-ID: <bcd4d7b1-3872-4354-ac2a-af5ea0d80ec3@oracle.com>
Date: Tue, 3 Jun 2025 16:35:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/nvme: revert CMIC behavior
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
References: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
 <20250603-nvme-fixes-v1-2-01d67258ffca@samsung.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250603-nvme-fixes-v1-2-01d67258ffca@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH3PPFD7011BF84:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d8c325-aa2b-4142-6ec0-08dda2f76736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1puRXFRNjRta0ZGTDJ2K2h6N1FKUE04ZXBkdnFXMkd0bnN6Y3NOQ0JsUDhW?=
 =?utf-8?B?Tmh0WVE1R0NpMjZsNjA1OEJrcU5lM0V2bGJNdXhmWFpjb1dQVmM3UDhiUnNz?=
 =?utf-8?B?L09QbHFHcXJsdGhicEY5VDgyTUhJY3JuamxjY3Jhd3JvUUk2ZmhiR3lGb214?=
 =?utf-8?B?endXbkxqYWdUcjBrSHV3TVNZdENKNW1vS0toemF5ZEVSNmJvWmJ6VzZoVi95?=
 =?utf-8?B?UmdnZkpnTlZDSVEreVJVQVZBK29YamJuUkZGeStiaU5FWktiRHBsUVEwbUR1?=
 =?utf-8?B?N3h5RjBzYW03T1h1dXc0ME5aTThhRWNzZldOa2RYM0NrdUdzRk1rUnppV1dj?=
 =?utf-8?B?MEpNaGN4eEs1Y2lLblUrbjJKWkpRTFRyY1F3NlJ6bHR0VEEzK1pYVTJiWDJV?=
 =?utf-8?B?eXVNaEYwU1RHbDBMbkszUFFHTmlUL3NrSkJlcHhsT3FtUXlLR3N6UU9tMTU4?=
 =?utf-8?B?bUsvM0RWYW45Q2lJVDNvTGE2Rms4ZmQ1RXN4Y3dwSHhqajB3bTk2REhxdWFY?=
 =?utf-8?B?eVVUcG51cXVBbUxZOWx1eldsUU5qa0pCUEtacFhJYUN0ZWhsV0Z3L3Y1SU1U?=
 =?utf-8?B?dnVtaGVWSmMxWiswU0tUODZPVmRTNXJzN1BjUStMb3U2N21Na0FYTmFoaXQv?=
 =?utf-8?B?ejA2dHI0RUVNTEFrYm03cjhvZkhscmpmTlEzTXZXNFJiR1Y5NlR1dUVvdWVr?=
 =?utf-8?B?MklaTjg2NVcrR1NEeXNCbzhjRG0vbVVtNkZPQ3VUTGFtc214ckZhKzJXZVha?=
 =?utf-8?B?SVc4T1ZiV3BCdDFkRjZkTDhtaHNxekI5ak1lNlM5eWVjUDhYY2JuNy9DU0U1?=
 =?utf-8?B?YUhYYkl2TnFTTk9jaVQ5bFMxaGphdXc1aWpDaGY5RkFEbksyczV1Z25kT2tY?=
 =?utf-8?B?Yy91UmJvQlFRQnI1T1Vha3RhdnRsVzFOWGdsbGllNjJjV0cxUVcyZE4yQTNS?=
 =?utf-8?B?ZGN6ejVqbGwxUHdPaWRrZDg0RnFoRUl0c0VWeDFORG90UXY0cFRCTXdYSnFj?=
 =?utf-8?B?b3VPdWlGYWd2SWlvNFdSLzR2ZGtFL0F1Z1BFcVJ4UmR0dVNjUUFRTit4MGpt?=
 =?utf-8?B?bUNtNnJkM2xJTk95MGhkOS9oUGhiZ1krVk00M3JBZWZkbS9TSkxDTUE1Yjkx?=
 =?utf-8?B?b3FMZ0hJa3VRZi9FMmorMy8rc3V5bWxQbnV1WmJqdXhPZEdNSTkrNW5Fc29G?=
 =?utf-8?B?WE1WT0ErbjZRSjVvU1ZNc1cwMkxVNE9BZGJSRWQyZEIvN2NzUG1mcm9sTm9T?=
 =?utf-8?B?OXJhUXpBSEFHNEVBWk83SDREZFZjNGZhdXFxNm43ZUlGamIyeUhXSmtWanpQ?=
 =?utf-8?B?b3l1QWN3cE5wKysrQmo5Nzk4dWYvVU9iM2psQTJHc0FWWG1qdzVrd2lXM0Iz?=
 =?utf-8?B?Rit5bjJCbUErSUJramVIZFRmK3QxRk43eGJYSUQ3c2ROcXBaQmpKdTZDcGtF?=
 =?utf-8?B?b2MySEIxa1NlSG1Rd21JK29oa2VhNzREVTljenVuOEIrdHdXaTZvZWpFaDNz?=
 =?utf-8?B?RFNVZzlxMkxWUG9oSWltcFQ3M0ZjUE82cUxreXdoT0JJYkR1MEZOWVprN2FB?=
 =?utf-8?B?V3R4REJ3dDBpZjJ5eDhKZnhxZ3JBTTRqbURtcnV3cXJnRkdXYk8vNTdZY1Fj?=
 =?utf-8?B?MTFMNmlXQWFaa1d4aVEwVUpaWnlQSWtUL2E2QWhIQngreDlKM1VIOE1tQllS?=
 =?utf-8?B?MVhlU3pQbjBqNE5IbXhremJQSVJSYzV0STRaaDNlSFUxYWI1eDU2L0toWU1X?=
 =?utf-8?B?YjNHa2xBUkFRU1RXcnJ3UGZCR091aWFCaHFhRnhwY1ZYdTdvTFcwVVd4S1Jo?=
 =?utf-8?B?djBXNktvT1ZtdWxvQ2FPR241dU1vRjVjdHd0aWJhSDFhb0F0T0ZJL043ckEr?=
 =?utf-8?B?Q3FhMENzdkVRYkI2VnlMbmJXendnYnBuUlBXNnNXdm9BSGpKVDI1MU5XLzh6?=
 =?utf-8?Q?kVlpqPpoh2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdybXJWSk4xU3orSk1hQmo4dHNGaTR2N1JYWXV5aHpBVWkvdUU0R05LTHNw?=
 =?utf-8?B?NjFMK01RMnZ2QlpMYk1IMDhzWDVWVDJYcndhalZ2bjNyRFdESk11aE5Fek8w?=
 =?utf-8?B?dUZ2ZVRnbHArdzhmS0RvYzRDVGJONUZVMlppKzNaRzFaN1FEZkRXeGhvejJH?=
 =?utf-8?B?WW84N0U1Skx0SzJwL3kreUlEZE9mbFZ1SmQyL3F0OFVxcllTNm5XbElpSW8r?=
 =?utf-8?B?K0F4elVrWXFBeTZsWG5GZzVSTnQ5ZFVyNGg4Q2ZvTUF6b2IvM3kxOHJ4VThP?=
 =?utf-8?B?V241d25kdzVZNmp6d21GV21DeCtseTIzNk4yeFVPZmJoRDZSYzJXMS8rRmh5?=
 =?utf-8?B?VnR4M0hSODFzbWw1cHAzVWRYN2p1eEpOY3BqaDVLQTIwbDV5djU1clRWQ0Z4?=
 =?utf-8?B?SG5meWFOSVR4RXVLczRsaTZoTHpVRG5WZWNwK1NaTGg4M2JaOWhEOVJqcTJj?=
 =?utf-8?B?bi91WnpvWEltcTVoUDJxRGFERENneTZBM1puckhITURRVmsvV21iTlA0djNY?=
 =?utf-8?B?MDc2dHo4eEM2Vjk4OW1hamdyalEyS0htUlBOcWVOZDI5dHI5SGRRdG9MVU9i?=
 =?utf-8?B?RjFhWElobkltbFh5bkJEMWpaN215S0xtalUzWFVudFhtMDZacnlFMHZMeVNE?=
 =?utf-8?B?V21qZmpoTnNkQ3oyZHlJTUp3clpVVmMxd1RJaWtFZkU5OHRrVXhvZmQ3cVBS?=
 =?utf-8?B?K3poRDI5dDh3K0h0cGNyNUR0RDlnT09zY0JNTi9pOHNEelZHTkN4MWJtK3di?=
 =?utf-8?B?a0hGdVdqbmdHZ3lHbWMxOVFjVzFkOWZWWjhlclo0OVJ4SXNCRlJlcmdTRDgw?=
 =?utf-8?B?ZmtVQklLaENnRWxaeXp6dVhxazJuVkhLbW1YVXlGUjFPNktLSWdqd1RXRzRD?=
 =?utf-8?B?dHluaEhkc0l4QmpnOHc4Z2d1eTBmZ2dEUzhvZGhVZUF4eGREZGRWUCtTUEJw?=
 =?utf-8?B?OXpZSjUrMUV0cE8wNmE5SUNyRFFDWU9NNTZ1SDU1Mmhwb09GZU12MVBxZy8w?=
 =?utf-8?B?VWNLK2lYTFV2REpNZVFvQlptQmsySGR0d3VWc2F3Q001UC9zOXplVC85b1Y5?=
 =?utf-8?B?ZUtueGcyaVhRbmI2aHBZcldHSVZTUjlnQjU1TWhyUWExTXdLY2lnYnV3Z093?=
 =?utf-8?B?eHRmUEZMRDZTa3JWT3pkL0ZudDBuNnoxZjhINllVZnVYNFlLK3hMaXdkaWxJ?=
 =?utf-8?B?UFp3dzJEZktSclRQY050TWp4Qy9HdTI2QWZuOTltUUFITGZ2VzFjOVBGWE04?=
 =?utf-8?B?MVpsUjZYVlJ3cWdKNTZFS0txcXRpam1Kd05vNWhSM2p1bmZJazc4YUd5eTlP?=
 =?utf-8?B?SGJ3VkdFdlRPTnpDSGtFemRWSXR3eUF2Y1ROVVZZTENjSHV4enNDRXhLZDdl?=
 =?utf-8?B?R2NKTE81cE9JVmxKbjlFb2tyMUpKdFhDTVNnUDNaTm8vc3cySkN1V0loVWdM?=
 =?utf-8?B?OWt2UTAxbzdQRnVtcmo5RUxVb0hTOTh4MmMyRm5zVGdWSkNndEN3cGhoSHJP?=
 =?utf-8?B?YXRyeGQ5Q0k5U1FnQXQ0T3hZeXhEQnkwNG9XRjJSeHk4R2VzNzl2THM2UHAr?=
 =?utf-8?B?cW5Dd3BsM1NoQVRTZjFsNjd4a2srOWVTZXBnTzZWSHBMb3kyd2taeWd1RnFw?=
 =?utf-8?B?OCsxTVNBRU5OVnAyQVBCTWovZnlVbXNPODBKcHJKdk5ucHBZUGNZZjdLVU9C?=
 =?utf-8?B?ZTJPT3NmMG1PSUFBMExyV1hSemxWd25FRjBaRkJiQjZpMDdFLzFzcnc4bGgw?=
 =?utf-8?B?Rm9POVloU0tQdW1OSzZ5cjZJVXNHZkI4VTdmSkpOMlBmMkNYNmkrSXlGWXkr?=
 =?utf-8?B?OEJ0UVp4c1ZtNG9zSWlUcGplK2dPbGR5WmNxY1BDZ2FKaFBvOFRoUFFlRThK?=
 =?utf-8?B?cm8wd2w2M3JtekJYMnBQb1Z0QndpVEtyRXdzRzNieit3QzdxN2huYjN5ZG5R?=
 =?utf-8?B?bUdBVEdvak1EOEYxTWdkZCsrU3NxeWhqNlFMUS9SNVZSVlZoUmJtWFRacDRJ?=
 =?utf-8?B?MHBCL3BURXZMbzlhNUJsTHdmdUNXb0lBY04yTFZMMmxpUTkzaXluejUrYTZ0?=
 =?utf-8?B?b09YWDRGMC9nOGt2bitTOWdZTWtuUTRzcjMzUGIrczAvNjlYVDZ0bUtEMURN?=
 =?utf-8?B?Q3lLRXU1TDZCTklGa3lnc3ZOTzMzZUE2OFpSaURZdTFsMWZsRkIyNWduMzA1?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nYyofnlbkcFCSBtVkRh9WEHZE1npjP8szEBJiS2H2/xye9qyR2AXLNSCQCsT1U5Au/gx1j64cq4k6sFh3fOlNShrVQt/WxEKikEV+k/OdQwsVv8V0rAuF7KqO0efN0e9gpX2XYRblyjKDr3okTAeg2X0xf29L89qnaeIIC657wQDUqQ6JR8lP5r6ZvIsPyc4DHCP/mtmM9SU25BBZdS86UmUv2rA6+PRS0bVuIKQOEITUy01bGQceWT/rj+xlrGvcLXuxPJeJYhTe9SIpwsbEdOE4DC9tFyAmJk1RlebCegVisR5IK2kVi5muKva3ulh6gkBOFEFS1mFx4Mkuqy7CmgEAG4qTGceFya7Sm2Rcp6jdaBmgNeDxPZm8XZeb0jTCTH4IOuKD50ikECN99L+3f75ZYnplj+kXLlCa51FXAjEqJJbvgNyZK5iaJer34aUPaldhH6PHQIL/1RQRdmMMN7+ZYzzYMFUk7EbWKGkwQnQ1+6Fwyl00aHdk0W/JHuO+AWMLTDro8XbLEm00ZGjqBu7fWnITr6d7PU6zH8jN8zhvOcgEVDqiffu9mnLmuueKU+UHPy/gNFHmJRYrLnXjSCV6GGvZlwmF/7x9x8C7IE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d8c325-aa2b-4142-6ec0-08dda2f76736
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 23:36:03.0733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcPlyojENxNOhulFb6vCuUzWoauvXrhixUPny+o8SOrTZBTHuB9PnXKVGs3ekZdZeRjstKDcxC9yTEqBImJznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD7011BF84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030202
X-Proofpoint-GUID: Y3qB-PgAD0xVBemileyOHHyYLGE07ljA
X-Proofpoint-ORIG-GUID: Y3qB-PgAD0xVBemileyOHHyYLGE07ljA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDIwMiBTYWx0ZWRfX9ZSIaobhpujH
 x3ruj+agz+XJsLG9gvPdkJ62wNhfCvX5bAL6V+jJxdeVA+NGU+dgSRhEqegrD53x7GIlCcRhx+P
 clxWOSSiq3QMPPbeTwdmmNdCeJo+EkaQH5UkMoHtgoY6E/ZnHUXoC4IU6c9g/l/PQmxozHpk4x2
 aEhT3WTWnVddWriUtg7uxHIfCSJP7h+TYbvQsLr2DvUug2r8zrRAf1/31NC/nEvZ3bCphvZLZ1/
 h8pym4EVRuXIwGWS4M1t1LvM6RtQaALgtcLUBgq+cgDrnh1CAYRMCLzs4LDnJBfX9gXaZDHtpvf
 Q2xxUcnGb2dt6dfbm5uHkU2aUExugTXm2FEAobYUS2W9yppgNl3qioH0z27RqlA9TUt4akrDPvz
 trPyyJO3QhDcJc3zADUF4UDfVT3GGpAYFq0bsw8lDLRVyAGDgOzZF1a38W/gIxXumyG9sFlt
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=683f86e6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8
 a=j6NyUXS7kQ9PlDmix-wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13206
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
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


On 6/3/25 5:59 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Commit cd59f50ab017 ("hw/nvme: always initialize a subsystem") causes
> the controller to always set the CMIC.MCTRS ("Multiple Controllers")
> bit. While spec-compliant, this is a deviation from the previous
> behavior where this was only set if an nvme-subsys device was explicitly
> created (to configure a subsystem with multiple controllers/namespaces).
>
> Revert the behavior to only set CMIC.MCTRS if an nvme-subsys device is
> created explicitly.
>
> Reported-by: Alan Adamson <alan.adamson@oracle.com>
> Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

Tested-by: Alan Adamson <alan.adamson@oracle.com>


                                 Before 
Fix                                      With Klaus's Fix
subsys with 1 controller        # nvme id-ctrl /dev/nvme0n1 | grep 
cmic         # nvme id-ctrl /dev/nvme0n1 | grep cmic
                                 cmic      : 
0x2                                 cmic      : 0x2

subsys with 2 controllers       # nvme id-ctrl /dev/nvme0n1 | grep 
cmic         # nvme id-ctrl /dev/nvme0n1 | grep cmic
                                 cmic      : 
0x2                                 cmic      : 0x2
                                 # nvme id-ctrl /dev/nvme0n2 | grep 
cmic         # nvme id-ctrl /dev/nvme0n2 | grep cmic
                                 cmic      : 
0x2                                 cmic      : 0x2

no subsys with 2 controllers    # nvme id-ctrl /dev/nvme0n1 | grep 
cmic         # nvme id-ctrl /dev/nvme0n1 | grep cmic
                                 cmic      : 
0x2                                 cmic      : 0x0
                                 # nvme id-ctrl /dev/nvme1n1 | grep 
cmic         # nvme id-ctrl /dev/nvme1n1 | grep cmic
                                 cmic      : 
0x2                                 cmic      : 0x0


A bug in the Linux Atomic Write feature resulted in the 
atomic_write_max_bytes being set
to zero when cmic=0x2.

# uname -a
Linux localhost.localdomain 6.15.0-rc3+ #1 SMP PREEMPT_DYNAMIC Tue Apr 
22 14:34:09 PDT 2025 x86_64 x86_64 x86_64 GNU/Linux
# nvme id-ctrl /dev/nvme0n1 | grep cmic
cmic      : 0
# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
0

With this fix:

# nvme id-ctrl /dev/nvme0n1
cmic      : 0
# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192



