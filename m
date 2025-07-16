Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4503C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6LT-00044S-Su; Wed, 16 Jul 2025 13:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Jn-0001ho-9u
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:53:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Jl-0004Ro-6l
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:53:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHi9rR008594;
 Wed, 16 Jul 2025 17:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=9IsxjPfkDYBATUyoVV9Gwz159S1rki6/gtDQVfriG2A=; b=
 YWRHHKwQSQgbcMeQ9rASxs/+4kskEtnVGKMSQabRySEAPA2EZoUIKBUOupBrByfM
 NPS1VMiUqd68jiYEHmuwA5b6JiHxHJuaq78F+SuHHwvwW+A5Vb0WxSwE8WdTac27
 4W/Uhg1nnZUKxgxOCGwafQB6A/51rUV48GhKmArwAY2FtnqKtt0x3sekkw4tlOAZ
 3dYVD8eW4nNuncORkck3QE6B0zFf6DuCJtNK/QVcF6NmrvEFEQXc3c9+3mCP4LrB
 nTiUMdWUhJQ/uJomuecBJwRxXuBsA/7C/7QW6PbVh/IsHT7Fz8LlIk7qzEVwi9as
 c9O9Wx+ysxx/unh/X98NLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b1fu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:53:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56GH6VvY024152; Wed, 16 Jul 2025 17:53:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5bn740-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDIMs8vYDbLqY6AU9BwG+UaYRs8jGXc4by+n71FLCYo0Glwaud6UqT14ZY7DEFMHmqYZX4q1spQqUSASOXxVg/nBSRQCS7yDKpRydomeGu2ymv/wwKSkclgNEpfggjbGahBuPA+BvKDrr2G5X36Oc1a6rkyvgvufiY1b2NgyUvGGToPDm5VoevBkN6fO9AEDQETnlTr6zw+a9TxQpFfDJlbJuaSIolwQUUldiobOFudWR//SI/MjH8kEjuXwqF7VQZAi34snkf3rUxxC1krF5/aP9GL2R7oPEWkB9IJ9t+xIUvjCq3n9IoMsIBdnQXqSSQ1rXjzVUCCGUc/wdC2qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IsxjPfkDYBATUyoVV9Gwz159S1rki6/gtDQVfriG2A=;
 b=JK8Sf7CtP+OntK3IZPOMvhNtRGSbQ1NiIfOHDnHcZODttIvyVkc6wle9/MxC54KV188JRmKnwtWvjRr5BCDgomXP0OeTV9oRpIuRtjhEaN0AvBUvFIsEcePnpFET/yCZeKZQj4ST64Zl55yvAFkD1oJnp7igkI06eDYWDmQQr6ao+mT6ImGP35NfkriuS2dm4N8pcUQ+souqCkKeXwXqSbvmE5A/Q4VfoejWB1FSde9n52CLH9XGgdHGPnvrnt1pIVeSculE4qMmVz/M1kt9DT/UfIL/xqH2JwGaVyhtn3t2rbIe2Zw0Qaw3Z8UoEwIS2G+pXkkE30LHjA35dXnrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IsxjPfkDYBATUyoVV9Gwz159S1rki6/gtDQVfriG2A=;
 b=TqPNrFpffS+VXQpIs4ON/Q8PgIqxC3SqGh3/Mk8qnoW2A441ofQlT/hMyy2imaYiteayGJqJ0tDLirAsf7UbVBCYIP0vsiHcnlVsk8C96uMRVhvtsyc643c5SWPC2VrfExzyyDeVsZodcQCK5YwdqelEZgvWOs9uytADeuAYAUU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8472.namprd10.prod.outlook.com (2603:10b6:208:56f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 17:53:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 17:53:02 +0000
Message-ID: <07a5f25b-5031-4188-b398-76e42926e8c4@oracle.com>
Date: Wed, 16 Jul 2025 13:52:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] vfio/pci: preserve pending interrupts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
 <1752503222-222669-3-git-send-email-steven.sistare@oracle.com>
 <e4a50f6e-6950-411d-92c1-9bc83db44c63@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <e4a50f6e-6950-411d-92c1-9bc83db44c63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: beff5d43-8307-43c4-2edc-08ddc4919bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29scWtRWE5lY1hoSnlwcDdvamE5SmNhc205NWs4L1p1NzBjbzlMcTJncStx?=
 =?utf-8?B?TVUxOGloejBGdXkzZ2IzUTBQU1ZxbUM5dHFrWUZpNm9tem1aVTRQSjdValhZ?=
 =?utf-8?B?aWwvaXpoWlNGUElYZXVpdUFuSDBvTitlSFBnd1lDZGQ3KzVVSCs3QU40ZFlE?=
 =?utf-8?B?eG8xczdPbGc1SlpDVHJXcEhYTWoxdTc4cGZVQnh4LzdIb2FwTGVodFNtNE5N?=
 =?utf-8?B?SmN6MFhKY2RQUEpCandRcU1VLzNqeTd2VkNGNHRaTFREMGpBTDlNOVYwL0F1?=
 =?utf-8?B?OSs4NktFUVA2MVNkcURxUDBjWTV1aFNFeWZtZDlMYnQ1MnY1d2FZcGFkaGFY?=
 =?utf-8?B?ekZ3c1o5eis2djdvNVpHT1VJamw4NWJRbEJSc2U5YWFJbW5qVW8yTDlOdU9I?=
 =?utf-8?B?WEpjUGF1ZjhKRTdmRHpoMXA1VGhFMDI3L25yRWVFbEM3OHp3S25lQ01XSGV5?=
 =?utf-8?B?bWpLQWlseFFwbWtJaWNiS0YzWmxvSWxLNmcrNk5aaGFGQmhMOXdsczVuMUVX?=
 =?utf-8?B?QjZvU0RwNndISEVMYUZGQUFIa2wxMk03ck1aNlcvWk9HbWFNdlB2dFZMVkZQ?=
 =?utf-8?B?RXNaYXVjT25zeDBRWEsvNkE1d05jNFNHd21KQXhQYzYzZFNScHA4ZHh6dXhz?=
 =?utf-8?B?L0ZFSkx2M090dVowTzNORkx1VExwZGZJV3F1cVM0clR5NEJYR2JBdXBFUkg0?=
 =?utf-8?B?NnkrWVJMcklsQ09XM2FTaWpDMlVFbllhUG1VMUlVZnNFRXFPM0dRNWtpM1BD?=
 =?utf-8?B?NEpFV2tuNVpTRjMxQXY1dHdoNXFUaEd2aFpTUlNFYUpLMXkzeGhOWis1dFRj?=
 =?utf-8?B?YmI5V1dsVXQrVThaalV0VlRNZDlvMndSZ0pibHZzZmt6UHJrRVJUZVA3NkFo?=
 =?utf-8?B?Y2tMcHBXSGlzaExMR3VtYmNTbWNmcVQrUXZ1MjNpQWpxL0Fabk9mdHN3b1Rv?=
 =?utf-8?B?Um8xWWxWenlDNytDM21SYjllVSsyNW95UVhHbXpDSldDcTJVQkRLaGJTOU5m?=
 =?utf-8?B?NkZwSFJEbk9zRnZnbnU2S0hmTlRld2xSeWpDelY1MkE0Yk1pTi91N1RuMG5S?=
 =?utf-8?B?SW83dFJSbTlKckNTYmZGU2ZmM3k1V3Fxc0xCZGVTMVJWUjVNQk05WEdQM1Bs?=
 =?utf-8?B?aVpNYUVQVkp6SE9KaDM4ZCtOMzJEUHZ0eWlRbzZzZitqTWJtV0RyTzJZVjB5?=
 =?utf-8?B?Y0RiQjZZUDA3bnNWREU0KzZ2N0FDNzAyVU9zMHRoQjVqaklyVEc0c1lCTWpy?=
 =?utf-8?B?SVlBMlNjQmtJMGJjblhOMzl5aSszVDJQZ0FkYjdOSmpMV0ZtZ090TGFUZmg4?=
 =?utf-8?B?eGNwVVJPM2dTdmV1a1hRVW9sazB5TmRyRGFHb1BnSGNGbVc2WlhsdUs5d3pR?=
 =?utf-8?B?ck9UR2NEdFk3cFpxYWJEdlNzVWREN0pZdlpzN1IvRk9HLzNIOURPSkoycTV2?=
 =?utf-8?B?MEptUGh1K2hsamdhQXR1MXZDNjZxUFNqaE1Vbk16YkF4dnc2VmxwY1lveUVp?=
 =?utf-8?B?YldZVHlIQTFHc29MK1Z1NWk1WVNBRjhoaHRoTlFQbnRlVU5CSkJWa0xEUHdq?=
 =?utf-8?B?dGtKczh0dkhIRiswVWQyTkxzU09zOWJmcUdSWi9jakhnS2NVV2F4RUdMUGtI?=
 =?utf-8?B?VXp0ek1lN1Z5WGg3cUZCclRpS1IyUTAxUzNtdkNiNTZQbFc4dmgyT3BRTWd0?=
 =?utf-8?B?cCtEZDZ2WkhpOEd3eUx0MmRJbmg1L29pbm9zZkk2MVcxaHJZcFpOakFYM1Er?=
 =?utf-8?B?Ty95a2JSSk1DUEJmWkxiS2FWRjV5M2QwemwxZHRoUE5tRjNHeGVJQ045UElw?=
 =?utf-8?B?RVdmVVZ2cTJ3TlYraWdwK09lWGR0cHA4V1g4bFhWYW1PRStIaFhSQmN0TkFW?=
 =?utf-8?B?WUtCV04yVUpSZG5FUjZSOUh0dmZQd3hvRGRrNVk0ajJPOE4xQS9NdXp5eHRR?=
 =?utf-8?Q?4c76su6LM3A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHQySTZGcElWOFpYbW5qbDdxK01sbjExMWw4c0VMQitXcXVqRnl0dGFHb2Y5?=
 =?utf-8?B?QmllZUFiK1lYYTVIYUlxY0Z6WGpqUElmeU9ZN050UmtuWWQwRklyeWhmSDlv?=
 =?utf-8?B?UkJ5V2ovNTkwOWVxenJQekdXcEF6M1JYZUJpeENBN3hLSnI0WkV2WkIxNk13?=
 =?utf-8?B?UkJGQmZlVmo3WWJjbndrdUcwV1FOVy8zRFVrMjJZQzlRVS9DWEJQdUdRTGE5?=
 =?utf-8?B?dit6ekk1QWNoSXh4ZzNNSnAvY0Z1UVNER2E5NUVqM1JXazNrdER1ZiszVGx0?=
 =?utf-8?B?TWE4aENvcXJ1MW0wQUZ2Ynpha2EzdmpzTUI2eHZuZm5sUzNBVVk3Tk1OUkNS?=
 =?utf-8?B?YkRzSlVQU0cweTZqcmR5cDJ3c3YvTDVRYjZlWHU0N2ZSczZjbFFpb0FsNE4x?=
 =?utf-8?B?bkJBUHJaREpiUk5qZmFNYWNlbTZic3FOYS9GNkNZTFk0MEdrNUMwcTBYTnJp?=
 =?utf-8?B?dy91NzFwUCtFK1NVTUhZWW5DSmpvZnp5TVNkMnorYkE0VmhHWU1wc1hYUjNl?=
 =?utf-8?B?TVVmYUEyZFg5RjR5eHJJa054dCtIQW05czJ2WWRrWnpQZjI1T1gwSStWY0dC?=
 =?utf-8?B?aE5EbWY4SVMvek9jZzJJeGVlcXZuc0hFTVg4OE9FZEs1OTVVclZYNGMzK1I4?=
 =?utf-8?B?c2VFOS9qc0cxdlphdm9VQUtITktuYkZrYzdHNEFUOC80d3Q5VjI5NnhQV0FW?=
 =?utf-8?B?KzZOSE84WmpFYzl1RnNMcENXa1JTSzk4QVJma3UrVURKVFlkVmMrWjg4RXFj?=
 =?utf-8?B?Z0NweGF5Y3pnSXRUNWdhYXY3UnB2czNRMUtZQVRNNXgySVJoVHBCMUJ4VUxn?=
 =?utf-8?B?dEg0ZHZORGgzcWFITk1PSWovUk1JQ3luc05VNThnQjI5RU1BUENiTTdLS0xC?=
 =?utf-8?B?UDhtSGpRQ24vbUpxSVAxKzhrbW9SMjczK0ltS1N3NGgwMll5UXV4UVZRZWF2?=
 =?utf-8?B?L2I4elB6Tk41eGpyZEhRcjljZzk0VXJZSkJBTE5hQVBvR0J4SUpLYlZGK1Z6?=
 =?utf-8?B?S01vR0RveDgzTXZPYWtJT2hhVDRpNC90cjhxRUVzNDBtTzg3UWlTTHJGcDJ2?=
 =?utf-8?B?STVJTkEyU3JHWHRBaVBSd1hkUngrU0o3RXVWWGQ4enA4ZmNqNVBDaVVObzU1?=
 =?utf-8?B?Z25qTDhFdk1SbzNwRnB0clVRV1EzM1MzbUpCc3lSS0VRRlExdkxENFUwUWcr?=
 =?utf-8?B?TjNYSnJ6V0VFQWpaL3Nvc2xZc3pOZENaMkQ3UWVYV3B6NVp0ZEtqVEdhblUw?=
 =?utf-8?B?djNGQ3Mya3RNbzg0MFdoSlBkL0ZWMzhQaUJCZTZpNk9ualo0S0xaT1RaeU53?=
 =?utf-8?B?SWlSZUpQSUZCMEY4dkd4cDlyK0h1N3ArK3IzbGRVQXRoQkRVV0hYTURhZCtB?=
 =?utf-8?B?cU1JN05LSmZURzdtMlgvS1pXMmFMVVpMSkN0RndrbTNJd2dPTkpPVTF0cjg3?=
 =?utf-8?B?Zkd2NlpVNHU5MHFmNkViKzZDY0lnSFlvMmFWZ0ZBWU1KOHN6SmRCMWFvNGN4?=
 =?utf-8?B?OFQ3bVFKcWRRNjB0aDdRU1R5TXl1MERXZ1graTJzM2VQZTNCMGN0L2VsNUdw?=
 =?utf-8?B?MzNydFo5NE9jM2JJYlRmMlFoYlF6R2V0aWFzMjRvZFlqdGh5dVY0ekcrcU5K?=
 =?utf-8?B?eDFHT1BTcVJISGpoWVRDYldOY1Arajc3ems1OXdUL0RPeHpQYnNNaWpydkph?=
 =?utf-8?B?dFJTY3UvTzQxY1JvSmdwaThwVzVmUzhXK0JKWWEwa2x6YllUWlI4Y2JyWjJH?=
 =?utf-8?B?MXdMREpLeFo5Mlc0dlRMMWhOZUwwZjBwTVFnZnVDU2JMMEdzclRNUURsVDN5?=
 =?utf-8?B?aFR1K1R5U01NdG8vakVDdGNiZ1UxTkZVcXZ0NlNEd25FKzRuem40bllkZDhw?=
 =?utf-8?B?Zm5oSm8rb2lhbXZWVEZITS90d25GUmFVTGtBckthNVdNRlhtMzlNRTRNdUhm?=
 =?utf-8?B?WThKdTIxZUZsdlVzaWRCRnFhU20yNERSUWpBNmZRNmdyRTRIZ215SGgzb0NB?=
 =?utf-8?B?MmxHRDJvU0ZkT3hYRlhnbVpPSHFrQjdJUW9kcjJWMUhaT0tvWU1TVjJ1dTl4?=
 =?utf-8?B?Ylc5TkdLRVpFdEhjdWxkZTJyazJDQVZZcFNvdEdnVE9KR0ZuRi9EZFFwQkRO?=
 =?utf-8?B?blFzSjVXZW5RdnZUSGNpSmhtNG4zcWNWZnNDcG5rTlVXWnpxeXh3RldtaHB4?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sesBETV2AEKUu0ysVcjFDuZtLKI5XsreWpXcq+QrK8+W7CRvtzg/lznslC742vvWigAIyKkMhd4OohHcIUr2OiUxi+xk20Mms4hyAgBzNGFVHi/EydT6vsH1wlzTS6WMwAuYlBNfOkPFqfJOJvr4wKAc3LrvkPN/MF52wuD3rYi2mYP25GZC/mZnRb05RCbtCwU3fbeFtKmdmyR7RPLBiHbDm6MXR9ShMNHAu9zTgrzExYrTX7S615hR8tQPEwUv8U5zxe3OvN6au80I/y4qffagFkhaaioMvH8+QEcbtmx4z09Y8qqKfVmNkFv8KbTBHP4pyBdbVkQhxfzRS+EK04zEqCb1fKtKFtawaggFtR0gmKwM3ULMkeFDMKHP6G6DIw6IFFeGJonWPMnXXJC5zMh+KQdcGlcp/9AT/rt9smNGI7cWXwxNGFSyIhj5M07ZF+nqc4/7cIH7oWAaGPHYKSDOEbycUGIGSVRDEg71kccDvU3MY9x6lxYbFI6Zewa3Bj4eM8OCKVZhO9xBD5dqzUyLIJ+IQDyEslDpeWWJvAAhNccRgfTjpygcLHEv1MwyT5QGAFPD6Jw/emOOhTBCiSJRMKrp6SmzM06lljrL8mU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beff5d43-8307-43c4-2edc-08ddc4919bcd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:53:02.1724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY4FoTX12rwbC90tumyXeSKVexv1w4SCEJcW/3JkbkpmM7WALYawB0YvvKa0JPkD1tB8UAkPSjNhy93Kyajul092nQ/hG8p/gQ5MhK9Z19A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MSBTYWx0ZWRfX90agXf/yy1Fb
 w0IRKL4eHFonsrAyRTL0QEGFd3Qgdx5B6MX0RCTyyaxRQ/F5SfNrJHsIBsP3lHHBGYpT8jHRfr5
 YgQrMinRiiWZnDdF9DCFmDij5qsbo+zUdv2AP3sUMWbcZR975A2e+EpQBz4J/HtZRMHltCK1nI9
 bcbtvTX5RqdtEDg8pmUcPJFIvBU0Q1hMbzauKeFI9HT2xD2qCQ+pW+F+EQ3CRul0IkgfKdYcnBs
 5I8bcXAkZRq2IsydDweHg9tmmGKPyY7LXObWU1q6sNI7kGG2x8Rj4+lcBRipm/jy90WRyUqeWLg
 JPro8tAtEbrE5QteH+drSGCXHRUd0xre9shEQ1SfSBPFr7B90EX2q4yg2hlv/D7Sz7vnIOoFNsv
 nt/1LQzuIJbLAp2buvFOmo/CiIqmAMFO7Lm5IY/TD/PTbPKoUV6my791P6gRJZSbqpNhl1eF
X-Proofpoint-GUID: sAA9MmsUelFOgNnEnJ0J2FI3bJnEhaJx
X-Proofpoint-ORIG-GUID: sAA9MmsUelFOgNnEnJ0J2FI3bJnEhaJx
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6877e70e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WxoroXzrINmn5u2JGcEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

OK on all.  Patch V2 coming shortly - steve

On 7/16/2025 8:40 AM, Cédric Le Goater wrote:
> On 7/14/25 16:27, Steve Sistare wrote:
>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>> dropped.  To fix, disable pended interrupts during cpr save, and pick
> 
> 'pending' interrupts is more common.
> 
>> up the pieces.  In more detail:
>>
>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD to
>> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
>> After this call, interrupts fall back to the kernel vfio_msihandler, which
>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>> eventfd.  When the route is re-established in new QEMU, the kernel tests
>> the eventfd and pends an interrupt to KVM if necessary.
> 
> 'triggers an interrupt' maybe ?
> 
>> Deassign INTx in a similar manner.  For both MSI and INTx, remove the
>> eventfd handler so old QEMU does not consume an event.
>>
>> If an interrupt was already pended to KVM prior to the completion of
>> kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
>> subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
>> state to userland prior to saving it in vmstate.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr.c              | 90 ++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c              |  2 +
>>   hw/vfio/pci.h              |  1 +
>>   include/hw/vfio/vfio-cpr.h |  6 +++
>>   4 files changed, 99 insertions(+)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 2a244fc4b6..ae2a6b7acd 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -198,3 +198,93 @@ void vfio_cpr_add_kvm_notifier(void)
>>                                       MIG_MODE_CPR_TRANSFER);
>>       }
>>   }
>> +
>> +static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>> +                                  EventNotifier *rn, int virq, bool enable)
>> +{
>> +    if (enable) {
>> +        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
>> +    } else {
>> +        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
>> +    }
>> +}
>> +
>> +static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool enable)
>> +{
>> +    const char *op = (enable ? "enable" : "disable");
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int i, nr_vectors, ret = 0;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        nr_vectors = vdev->msix->entries;
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        ret = set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>> +                                     &vdev->intx.unmask, vdev->intx.route.irq,
>> +                                     enable);
> 
> I think 'ret' is an errno, we could use error_setg_errno()
> 
>> +        if (ret) {
>> +            error_setg(errp, "failed to %s INTx irq %d: error %d",
>> +                       op, vdev->intx.route.irq, ret);
> 
> I'd prefer to :
>          return ret;
>              }
> 
>              vfio_pci_intx_set_handler(vdev, enable);
>              return ret;
> 
>> +        } else {
>> +            vfio_pci_intx_set_handler(vdev, enable);
>> +        }
>> +        return ret;
>> +
>> +    } else {
>> +        nr_vectors = 0;
> 
> 'return 0' is as good.
> 
>> +    }
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +        if (vector->use) {
>> +            ret = set_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
>> +                                         NULL, vector->virq, enable);
>> +            if (ret) {
>> +                error_setg(errp, "failed to %s msi vector %d virq %d: error %d",
>> +                           op, i, vector->virq, ret);
> 
> If errp is set multiple times, qemu will abort. This routine should
> return at the first error.
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
>> +            } else {
>> +                vfio_pci_msi_set_handler(vdev, i, enable);
>> +            }
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/*
>> + * When CPR starts, detach IRQs from the VFIO device so future interrupts
>> + * are posted to kvm_interrupt, which is preserved in new QEMU.  Interrupts
>> + * that were already posted to the old KVM instance, but not delivered to the
>> + * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM instance
>> + * in new QEMU.
>> + *
>> + * If CPR fails, reattach the IRQs.
>> + */
>> +static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>> +                                 MigrationEvent *e, Error **errp)
>> +{
>> +    VFIOPCIDevice *vdev =
>> +        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
>> +
>> +    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
>> +        return vfio_cpr_set_msi_virq(vdev, errp, false);
>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> +        return vfio_cpr_set_msi_virq(vdev, errp, true);
>> +    }
>> +    return 0;
>> +}
>> +
>> +void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>> +{
>> +    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
>> +                                vfio_cpr_pci_notifier,
>> +                                MIG_MODE_CPR_TRANSFER);
>> +}
>> +
>> +void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
>> +{
>> +    migration_remove_notifier(&vdev->cpr.transfer_notifier);
>> +}
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 8b471c054a..22a4125131 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2993,6 +2993,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>   {
>>       vfio_display_finalize(vdev);
>>       vfio_bars_finalize(vdev);
>> +    vfio_cpr_pci_unregister_device(vdev);
>>       g_free(vdev->emulated_config_bits);
>>       g_free(vdev->rom);
>>       /*
>> @@ -3442,6 +3443,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>>       vfio_pci_register_err_notifier(vdev);
>>       vfio_pci_register_req_notifier(vdev);
>>       vfio_setup_resetfn_quirk(vdev);
>> +    vfio_cpr_pci_register_device(vdev);
>>       return;
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 80c8fcfa07..7989b94eb3 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -194,6 +194,7 @@ struct VFIOPCIDevice {
>>       bool skip_vsc_check;
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>> +    VFIOPCICPR cpr;
>>   };
>>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 80ad20d216..d37daffbc5 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
>>       uint32_t ioas_id;
>>   } VFIODeviceCPR;
>> +typedef struct VFIOPCICPR {
>> +    NotifierWithReturn transfer_notifier;
>> +} VFIOPCICPR;
>> +
>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                           Error **errp);
>>   void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>> @@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
>>   extern const VMStateDescription vmstate_cpr_vfio_devices;
>>   void vfio_cpr_add_kvm_notifier(void);
>> +void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
>> +void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
>>   #endif /* HW_VFIO_VFIO_CPR_H */
> 


