Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE54C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6syq-0007St-IP; Mon, 21 Apr 2025 11:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u6syn-0007SA-Ef
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:22:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u6syk-0003QX-L1
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:22:41 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAmnZ015791;
 Mon, 21 Apr 2025 15:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Z/0Ukri77k1shIWZBXTGOFf3x5qy+Q4/WeK6Tc/LTjE=; b=
 Xrh0O333M7DVeVX9rN+SQjK9zAH89EJ6nLDlrT79fU7xdNvcmYtp10aAgntW3Mfk
 GycqHqo9F6R3OccnRRqCV5FxIUpFwsLD0YEBrcIbzYfR711+Bp9AgJBTf/tPelWf
 1i0uJUVAsXTUwjFKnssqMNxnOX4gp/mXdzlE+4xYRqqc7IyNvFU8I2v5F8yuqgQz
 SO5RAjFduXPDLv69/VhKsPmSdpvyzACWGJ93qjAVW7G0t3jOUi7nQcYW7paY+nvY
 aL1qgyCgPhfQ4MijbIpLAX0nF0MYEbO2sJLYESwhDOe5a3tbkrDtrZPe0AjvkHsa
 EpnRQEbYLwB/0MZTCTKghQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0aq7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Apr 2025 15:22:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53LEq98M002971; Mon, 21 Apr 2025 15:22:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012014.outbound.protection.outlook.com
 [40.93.14.14])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4642985h26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Apr 2025 15:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWHKhW77Zxt2UOygUSY014EdGLRAJ8YntK4Sp11ukt4eXqJghaL6GMMSfHqvGHkEHqN15od826eWrQl2OWQ6orwFEuMPWFOKaX0e5R6Z57vadXMKPd52cok+IUxKIGRnF+19yQoQ9EspzPyA6aN8Ax1T4JtLWQ+Slh8VRgw560tQJYxMwEA7U6m04CcNHe/dqHCJCBiLlMOnQlUTwdpRGtW1t7qMmz/TASQYWt6DW7A+z92i9Goo3Uy+62iGG0ilS7tpav/zvpV3cZambbnqEE7RZfB+zLg1C+UvTyV+/WJt8273n3mPjDmscmf2ADgtZbb+H6uAPOg/aMup17Hykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/0Ukri77k1shIWZBXTGOFf3x5qy+Q4/WeK6Tc/LTjE=;
 b=RnQDfe2d3HyeUtiKh6Vncr527T8XfIYY5rs4pLW5CEVH8Ekb+Qa/MlwzUJXhKAB7g0f+8FW2w89bCNU6lXX9eQz/x6+JWIuGQjUgoShYHnZfgeiDT3QrDXeMijiZNkEeX1rjRPWcyOHmfym9aG5banR//K2qwgyYUcbBxYhjUfnq3bD21eU3BJoi+VBUiqog/BpiAEMNar4UmFi9b7RHS3PDg3q31Ut4Ws/att8Lem17KiPg/VE/NZOl/ToBcfOpWdC9353qAsA6HcNJ6BtsnoKOnLoGsjNnOmKk1SUdnW4XHSKjkEabtQv+rCqUmMDThOWDaym8oKpkxhmxAxECaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/0Ukri77k1shIWZBXTGOFf3x5qy+Q4/WeK6Tc/LTjE=;
 b=tCJJng/uiK7nwminxQlveZyQ+L5eQ91/h20t92eNeAW5F1r051yoWkHC3LHdUpFTuBV9LNgz/cVNZ/4UsBQsIRbWS7UBdOdo0mqJ3M2KY+qKoj8L2ZsruGHVKnOM4rkx8xL3fjDcnzMxiYm8gVBmAKe6CC9pchXN58ecfB48RhI=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:22:26 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 15:22:26 +0000
Message-ID: <df432912-de0c-4a77-8008-0c07b23f42f0@oracle.com>
Date: Mon, 21 Apr 2025 08:22:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Trying cpr
To: "Dr. David Alan Gilbert" <dave@treblig.org>, steven.sistare@oracle.com
Cc: qemu-devel@nongnu.org
References: <aAZKaMkKYPlmBMcZ@gallifrey>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aAZKaMkKYPlmBMcZ@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|BY5PR10MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 895a6b25-f1bf-4617-aeef-08dd80e852b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWVySFdRMDF0SGdSRWd6VW81OWRtTVBLZFNMV1hQMVpkcitMemtVSGxKV1Zo?=
 =?utf-8?B?UFpQSVl3OCs0SEJ0eDlLdGtjcThBY3lTelZZRElFZm1raVkxSUc4NFZCd0FI?=
 =?utf-8?B?L0VoK0YwQjFMdE8wY1JhTlFHWnRhOE5Udk1mTW8zY0x0V0xmNE9TSERWZ0pL?=
 =?utf-8?B?R3BIUi96elpIN2RtWTg5U1RGQVZ2bmljL1RkOThYZGdKd3pqQ0pqQXpEb0JQ?=
 =?utf-8?B?OU9sS2h1Tnl1YUExamEwcGQ5RzZvc09JdVJ0bWsrYWcybzJnWktFd3ZTeGpr?=
 =?utf-8?B?TzFGRlZFajJkSlpYbnlpSk93RlRFenRLZGxVRkZwYlQyV3hvMWI0QmJJVDhQ?=
 =?utf-8?B?eVVJSkJIS0QrZGwrd21IdGdmWXN0aUk2cnQ4dHZ5YTFHaDNNYlhkaUJkUThu?=
 =?utf-8?B?cU9Nd1h0NDF5cmtnVS92eW5Uc2k2UWtXb0h1UnJaMXNyOFB3TFdGYXg0UlhJ?=
 =?utf-8?B?SjFBYWI1RjVUOEl0OCtvVElwd2pkeDkzejBhQms5TSs2dFc0VEVPc2gySWhN?=
 =?utf-8?B?WFBjNFNhSlFycmg5eTlFZkI0S01QREdTSW5xYURnaUFKTFNzUWRjazhXL3Qr?=
 =?utf-8?B?Sy8rTDBwWUZybGI3VlEvRVZlc29YY3pBV1NEWVpQeXcwd3llK1JleWUzMDFP?=
 =?utf-8?B?Uld4VEFjQ0hNaFlBNXlualpheUFDdkhWMTZiWU02cUdxbGdwUDZiNUwvUmxB?=
 =?utf-8?B?UVg5K0lkYjFBcFdRNEpmRjdxY0FkNUNrZk9DcDBFVnhZSEJlbWVGTHJ5c1J4?=
 =?utf-8?B?azlsZFN4VGdhM2xNbkNRUGYxRFI0YWRRcjFKQnJCVFZibFpYb2ZaWXpQQWtD?=
 =?utf-8?B?WmVGN2ROZFFOLzFLR2Z2NWhGRVNHWEN5RzFQOTJPcExXc0xBbi9BR0NSbC9V?=
 =?utf-8?B?bkRrQk84QloxY1lpZjBRUUdJVUNwWTFDZmhPTmRNeHd5RVJMQ3VvbnJEd0dK?=
 =?utf-8?B?amtDRWdVR1lpV0VWaktNaG91eGh1Rmo4YThOOC91eVpORVlNTWZNWUMxYTlx?=
 =?utf-8?B?SDRBalFQZXJiWGdZb2VzM0s4Q2s0cktBVDRGNFVzd08xT3hVSXpSZktFVlJh?=
 =?utf-8?B?WXBoRGU3VTMxaWgvUEpjaDVKeFA3aVRMR01EeExVOEFzVlVQbG0rV1hXT0Z0?=
 =?utf-8?B?bVRrOGVkeitKa3VwV055bDhPUU5mRHJkZThXWXlWUE9jMGN5UmY3eURESEJR?=
 =?utf-8?B?RjVnc0JrNlg5Q0kzR2NPZE03N2ZVZnJlMHcvWmtBQkkremVSVi96OWFlV3NO?=
 =?utf-8?B?MlFSMERMUmZPOXRHVXBHeERzY0I3cm1ueGg5dUMwU1k5cWxKaE5hT1RoTFF4?=
 =?utf-8?B?TTJ4b2drZysweTZKNy9kaUJWaTcrWW1wYWZzWDlvdE5tRFprellQekNXY0sx?=
 =?utf-8?B?cFhjZmJ4Y21PUkNVeGgxOWF5NmtId1NzbnpYbTYvTWlvQVp5R0hyTCtkdXgr?=
 =?utf-8?B?UUJiMUJTZGR2MzdYN09hYTczd0s2dU5MZEtLQW5QcXo4N3Q0dXkvWjE2TTdM?=
 =?utf-8?B?cENEaFB1K3N1amdSdEIwZEE2L1VWTlFjNDQveTY1U3d4KzJRQWg1NHI4bWRv?=
 =?utf-8?B?cHVjNHI5YWVBV25TVW9ncVgwSEM0ZXJtTjhOSTBNU0d0UVhMNUxvZFU4Z2lU?=
 =?utf-8?B?MWJuNEJJZHhycHpqNExJdXo4RGJGMEhsMnBrZWN5OFJ2UThTRTd3Zm9Xd0pZ?=
 =?utf-8?B?QXJxYmd2emZxRURCekloNTB1L3YwQnhPYzB6OVQwenpyaGtXM1BhL1o0RFJC?=
 =?utf-8?B?K2w3UldoNURQbm81L2FXdlZVbTRLaTk4NHZuWVI3TVpMM1JMMGszaVp2ckxn?=
 =?utf-8?B?ODUya2JiYzV1cEVqU21oYUlTVFBjOWFkZHYrTG4rWnJKSkc3OWEwc1JRNSto?=
 =?utf-8?Q?ldHBa1z/jMdom?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJvZlcwYlVheFBvVU9meFE0RVZYeFBhN0daVU9JMTc0bC9BczljZEl5NDVv?=
 =?utf-8?B?c1JLOGhRb1hsczdnaEZwUlpyb2JuSlZyUEVlWVJWaTh5U1JaTCtKdTQyZEhl?=
 =?utf-8?B?VkZaSmgxb3BUdUJzUjlhSVJtcWxlMGhEcUc0b3d6NW1xb3J4YWdLVk1LY2E1?=
 =?utf-8?B?anhHclY3Q3BiclZoczErSVlwMVY3bDV0WXZPeXFkM2lVbGllcWRFUmd5ZzJC?=
 =?utf-8?B?ZE9JS1dhN2RoaWtvUDNEdWZlaitaSkdUNDJjMHBZUE5ldkF4bys1aEUvVUNI?=
 =?utf-8?B?bWtZV2lqNkd3Z2c5VDZUdzR3cXJWMWFTOVZXWFFrVis4ZHVMRWZaTU5LM1Fj?=
 =?utf-8?B?NlNsMmhjazNJYlNiRVBVUnV5SEJpK1JwY3VEZzJ3dktoeFhsTFNzWk1xU3Fy?=
 =?utf-8?B?K094UlZTS01seXRuaE5tYUY5TEJXUkxEUTNPellXdjVrY29wVTIzSi9pakV2?=
 =?utf-8?B?SXhJNU05Qzl3T1lPcHdFQ1NoYk5lUE52aTRQYmo0T205azg2bzBqRkI2dU1k?=
 =?utf-8?B?ZE9salFMRm9FN2NIRis5Y1BxSTh2dFMxUU1TNGZCZ0ZlUmRhSTM0ek9Pa0VX?=
 =?utf-8?B?SU5GZ2k5cmQxWlZRbGFnblZZMUlUNEl0aVZMN014eHF4YmI2SURUR0NSYmdW?=
 =?utf-8?B?VGQ3V3l0TVFxT1hydmM0ZjdoUDlVU2VZOGdpVnRpbjhudEJXVzFYVXJyak40?=
 =?utf-8?B?UDJKbnVIcnlvYkZXLzc4Q3hEd3l1enpnRnl3SHhaejl5NE9neWxqb0NqeTR4?=
 =?utf-8?B?aGtoeTZnWFMrbElQSXFWQ2Zhc0NpN2NqWlRuc3ZhcnV1QjNKVExHWksxdVVN?=
 =?utf-8?B?Yk5Cd3dWVlNJa2tmMjBwSDBMUFJjdTVtVllJSzJ0T3BlWU1DaWhmTDJKekl6?=
 =?utf-8?B?L2hCUFpCOGxYaHpzVStSSzJRYWxtVFRiZ25vc3NvbHhyYXJNRGE2L2lRSk44?=
 =?utf-8?B?WEc4VTFCdkpSVWZyMlZvcCs3ZWFYc2ZnSWdQUi9zc29QbWdiSytpMVJKVkNO?=
 =?utf-8?B?TWtvb2NYUWxIUHgwYlJKOFB4YlZZR3g1YkFhcHAzSExzM3dhOENzaGdiQmpG?=
 =?utf-8?B?NkJkY0ZRV2ZNVWFSVFZJTW1hMFZMZTRvbHhjM3NvVTFYeU1EY3MycjFxT2E1?=
 =?utf-8?B?Q2Zndk52SVVTWmlXUzllVHBKVDVkc1Zmdm9vSTk4Rmswcjk4SjIzQ3BJWlQz?=
 =?utf-8?B?UGQzbnNrVnVFYkJzSEQzQTJDOVIwb0tJWXRnZExHYVNDTXZxRjQxRzlpSU53?=
 =?utf-8?B?QzVNUElSYzJRZEpEbnV3MDNZc05hbWtzMVpPQ0VyQ0haV0hLWlU3NVhkc1BC?=
 =?utf-8?B?QUMxOTg2ZFNDSlBnWGJWRjBSTm9GNWErdW1oMVVBTVhJa2doWnIwMUFwUHZj?=
 =?utf-8?B?V05KUUV6TkJvTWRJYVlyMFBneFJvN0pqL2JtQ2M3YTltSjVOUjVHSEZacS9m?=
 =?utf-8?B?TTQ3VVRGVFhRM3pIMlg3UzVUSElUUGt0Q1k2VE5ua01jRGk1ajRMMENuK2xm?=
 =?utf-8?B?RnVqdzU5ZkxwaVlJS0FmYTBGbXNHRzJIMU1EVkJFUDFxTXRnU3M3Y1l5aTJ6?=
 =?utf-8?B?UWJBM2psTnJydXJwVysydWZsSFI2eUFYa1V3dnNEMHJXT00xZnpNZXkyMEtF?=
 =?utf-8?B?T1g2MWpxZExMa2ZNbVEzaTF0NlBNZDQxOVUvK1FUSCtwVWJFZUtlVTdVZ1JZ?=
 =?utf-8?B?VTBvRkIxRDluUFA2dmR4dE8xclozbGNXVU00TmVOZFF3ZzEwQkR1bmtMZDds?=
 =?utf-8?B?Z2o0UTFqdUtDb2t4QkQxcFhwNW5sc2xHVGRlOHZDcy9DWkI0QmV6V2MyTVhB?=
 =?utf-8?B?cCsyS2piUUwvNnZXcjVXenZHeFZlb29WQ2UrZCtMaTB2QiszNzkzdFBEWktr?=
 =?utf-8?B?a0tUTGhRRjd0UzFGbzZNOENURWk5UFZVdTdNOUVuSnAweHdlNkNodkYvQnJR?=
 =?utf-8?B?U3dSVjZaVDBXVjF6aTRsRXB4cEw4QnR0cWFKVVlkUmZLeEZ1cytJODNLSUpL?=
 =?utf-8?B?VWtHQVFFaVAvR3hiZGtORHV3djIzbzVSU3NmTHJmZEJrcDRhQldYMUs4bGdx?=
 =?utf-8?B?WDFGNXVScHJnK2tUT2ZnMHloQWlYc2tLSENtS1p5Qy9QcjFqRFE5YURNT0lk?=
 =?utf-8?B?bktobzgrZ2U0clFKWXBzdVUyeHFvT1k1bUxpSnJIYVk3YXlxNHZZN2c3SkdU?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xXh8Pbg+nYqB3J2pZoRZ8Ibr9Ndu58pGyydIbeOOMHfTII9UWEEkEuVM/WWgchT44nKSLSBBErXq0U+YCVCjEaLtNkGy509KhksLCHFL/fZqDcAoCNgqpU4osydGNBId+pWNs4g3s3zZNPxIBexJbHuY6/lXa7f00Ui8AU8xZwr04+/CwdqSvvER+dJvgItOddG0kHJMb6E9njdDyiRQsaP32QUhK4F9aMPAEOlOHHg7L3WjqJBRuSVDbr1xnAeWeVotkL4YijR5lexlxnp8/1wBH5ykashEYWyDkG+HS/22l+ecgVFEF2ZeNrNGhRh5CWXM5CChOSsruAbSwk99cBNdeb/t6rOVjecR3QjWgC0wPHqcreZpfh18GBSzVofJsqsWXfZdP+HJGbVwHpC211Hg7X5NibzBFd3MIXPT0tBN314OvnuTucx/MrQIZPEKNDzeXt9Dnc12KSznyXTf0Te6Tw2M8sm5bJnRQyS3f0/Gc8HFCPUf8SeHvaxbTqMXBPWuKrwRUbnrBfMwmtQp68CgNJjGEsnhrGU/uTYKu6RCU4bRk8mPMB5MYu92e3WIzq5M8/ltia73IAY/xwlXOhUHFOqp6Aebf/ty7pvFJSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a6b25-f1bf-4617-aeef-08dd80e852b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:22:26.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYn13kw+noymVxQ7/mMrbD0MGnDr2FD+mUid5cjeUq8uJeUUicd35BgU4OvMmwNTRWfU77RWUZSsF5u9GBulyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_07,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210120
X-Proofpoint-GUID: a6M-qFjWvCrQWlDDGAA7NYTy_-tvCaos
X-Proofpoint-ORIG-GUID: a6M-qFjWvCrQWlDDGAA7NYTy_-tvCaos
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 4/21/25 6:38 AM, Dr. David Alan Gilbert wrote:
> Hi Steve,
>   I've just had a go with cpr-transfer, it's quite interesting.
> I was just trying it on my (AMD) desktop.
> 
> * I was running with qemu displaying graphics, and after migration
> the source display got updated every time I moved my mouse into the
> source window; the VM was still stopped, but I guess that means
> the source GUI is still parsing the guest VRAM and displaying it.
> I'm not sure if there's any other interactions - e.g. is there any
> situation where the source GUI will try and write into the shared
> guest ram?
> 
> * Given that you pass fd's over the CPR socket, had you considered
> passing main migration fd's over it as well, that way you'd
> only need one incoming.
> 
> * The guest noticed the time skew:
>   timekeeping watchdog on CPU1: Marking clocksource 'tsc' as unstable because the skew is too large:
>      'kvm-clock' wd_nsec: 556248511 wd_new: 4a93129e69 wd_alst: 4a71eaf0aa mask: (all f's)
>      'tsc' cs_nsec: 514023131 cs_now: 1047f1d8489 cs_last: 10414538c1 mask: (all f's)
>      Clocksource 'tsc' skewed -42225380 ns (-42 ms) over watchdog 'kvm-clock' interval of 556248511 ns (556 ms)
>      'kvm-clock' (not 'tsc') is current clocksource

Here the guest kernel uses kvm-clock to measure the accuracy of tsc.

While there is a chance that the accuracy of tsc is broken, it is more likely
the kvm-clock's accuracy is broken.

That is, suppose the TSC is still good enough, it is marked unstable because the
kernel uses an inaccurate kvm-clock to measure tsc.

How about the guest kernel version? Does it have the below patch? Or is this an
AMD server (by default X86_FEATURE_CONSTANT_TSC isn't set)?

x86/tsc: Disable clocksource watchdog for TSC on qualified platorms
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b50db7095fe002fa3e16605546cba66bf1b68a3e

In addition, I assume the cpr-transfer doesn't re-create a new KVM instance (fd).

I used to encounter similar issue during vCPU hotplug.

KVM: x86: Don't unnecessarily force masterclock update on vCPU hotplug
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c52ffadc65e28ab461fd055e9991e8d8106a0056

David Woodhouse has a patchset related to kvmclock and live migration.

[RFC PATCH v3 00/21] Cleaning up the KVM clock mess
https://lore.kernel.org/all/20240522001817.619072-1-dwmw2@infradead.org/

Maciej also fixed a similar clock unstable issue.

target/i386: Reset TSCs of parked vCPUs too on VM reset
https://gitlab.com/qemu-project/qemu/-/commit/3f2a05b31ee9ce2ddb6c75a9bc3f5e7f7af9a76f

Dongli Zhang

> 
>   (That was hand copied, probably with some typos - who knew the
>    GUI doesn't let you copy/paste from serial0...)
> 
> 
> The source commandline was:
> ./try/qemu-system-x86_64  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -qmp stdio
> 
> The dest commandline was:
> ./try/qemu-system-x86_64 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -incoming tcp:0:44444 -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}'
> 
> Dave


