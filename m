Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB002C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwFj-0007KU-8Z; Wed, 02 Jul 2025 08:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWwFb-0007HJ-IG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:07:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWwFV-0003qg-S9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:07:41 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BjFvO004078;
 Wed, 2 Jul 2025 12:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=zZ9nD7ay671qPldk92Js8PHjEyfd0Ne89E3Qzzfbalg=; b=
 cJJMboG86V6UDf6NldGbHlCUErL6BvW370uhg3GCv/p3dQAKzawsb1CCwctP90eT
 YBNDv98N/s578W+sxEytOLDfuapZvQprWdZYAhrYWlV6tpK4CtmwVvgVKuSPJf6e
 VuHiO0Gjq+PgQfPJa2rd1NShFLYPfbDST9DXT+MkkNhwJ/M3yatZdgq5RI3O5bWC
 garwZDCR2v/2WLtzqBBVHLv3lUilkJ50j3sRsyuEFNIzr1eOIPR1fKWKy/oOaILC
 eZvf3v5CcMDdH8W2BeZdIyaIXBe3NE6OVA3ZdmtGYCh6Y9Wfb6XiE432mjE0b6ce
 IIBQMc12VriOZNvMDN7LwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6sb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 12:07:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562C1g2A024990; Wed, 2 Jul 2025 12:07:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ujck2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 12:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scSUGdOscNv7l/d7AvSdf1BmLTxxF2wuzwqBNSdyFmKT0tE6AhmmJRTskVydjrUgzmOGpFm2FbE4lGGqGUcRjqWH1sMtuR+YVkZoPt7rAGLSoZ5/jYVGZcwnTCzUWktZMrs4UXr1qf2INYXrtH9UJBI+R8CvcrZW/VwyNKOBuAbcqxwoVRrNhtiJD2k6bLiz938wvxqgqzi+xei55e4xVuCPHp4LKSfj9l+4uqMvu4sISVrWo8oRgF7ojbBQ15DgolcEQkXwJOxcpZxaGzuD/yL3Fj+4qmrEoacSq3bMX1BvfIqIb6Upp+ouWKVpA7jMqBL9qMEzeh6ULrNFyAxvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ9nD7ay671qPldk92Js8PHjEyfd0Ne89E3Qzzfbalg=;
 b=ezARUPplGVUY1KzcfMXf1SbYk0R5hwOWpGFRuhHmr1eaidBCnPZ6xqRJHN6OCL4OU6d8IX5M8fULVyYEnskXUPNePbeP/b/+N5Qx65f/VRgoFHjT+XLZ1Icaa+cmbfab6mNLPWcyq1cHWtW6I+CbS9ZoqXNXCp5lB5lIxNG6/mR3dZhcfFi1IQVsUvb41tyEpbfMEy1NojlLUBzN2z1VEWu1PNCkmsX4oAp2IumbWjWjFy9Dg+0OrhUsIGJZ/wM92ACSprDODWh0yd4aMSfOEVyQzkkF+v35Iw8S99p7UJS7EOICgUL4mo30FWed55Yig7SlAbmMgH7LlAOQZT6mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ9nD7ay671qPldk92Js8PHjEyfd0Ne89E3Qzzfbalg=;
 b=V9Iy2VV5bdMVIuWzZgnbZW5EPkEjr2ttPKCLfJY0kzG2F8EfLSs9+C7KV5m9R/4Dmz+evf0jDKlg7FCQ/uqXURcfgrjg/hmQiKOOlkY5XKlkxquO1jNnPDEXw/PrsAioOSuSCGeJwt3UuDv99uZdat1oRS8+usRUtL4aR3lyE1E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5926.namprd10.prod.outlook.com (2603:10b6:8:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 12:07:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 12:07:24 +0000
Message-ID: <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
Date: Wed, 2 Jul 2025 08:07:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250702120043.267634-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4ef8af-c677-44a3-e45d-08ddb961010d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3E4c2IrMG5TcndLVVkwMlNMazBlOVhrUFMxN0hVZ3p1WGxHWHo4V1I3RDM4?=
 =?utf-8?B?TGl2cCtIR2VILzlDQlNjcFZjSmtNNEhoQkVjWGp1Tjh3NVBaN1JFa2VyVEpz?=
 =?utf-8?B?TWNkMzdqYmttQ0QvTk9uOTcvbFF3NkxoaitCM0hKMXQ3K1lLZDBPWThtMmF4?=
 =?utf-8?B?Ni84WjVEUUU1SXFqanFLZzlBUU1BcWRENFBWeE92aFhjM1RSRUpVb0FJZUd6?=
 =?utf-8?B?YlQyM1hwOUUzYVprUDU2VEdacHBSUWJiMis3Tk9TL2ZTR1JNOSt2TGhBeEY0?=
 =?utf-8?B?RzNTcGxFdjF1VjB3djE4REhWajRrRlF6aS8xbGJydkhjUXZQb0JSU25kQmRi?=
 =?utf-8?B?Q2RURHYrT1VOaWFvZ3h4VmNXQ3cyc3hSdzhkRUlsRzJkYmdXUVpGNUt1cTRj?=
 =?utf-8?B?bW01ZmtKZXduM2JVUE5NWXduYVdyZFZud3doeWVqT1A0eE9PdE81blJreU1L?=
 =?utf-8?B?ZlF3SGRCUVV0MGc5bTNZbGM3aW41dTlQc090UG1ZTVhEZFpZeVZTWHpoZ0s3?=
 =?utf-8?B?eWs3T1FtYVdJejRpbHhtZkYxekY5bFAzV2tic0twMFVSRDRqRm5VYkVyc2Z3?=
 =?utf-8?B?RDZPM0I3VGlWMC9oSnhCajNuUFhFNlIyaTFkbTMrRHBvWDZaRFczZ0VvTTdM?=
 =?utf-8?B?bE04eUtxT3JUYjUxWGlJSG9tYVhLN1hIcC9MKzJTeUtIRGFCZmp2Rnh3YzlK?=
 =?utf-8?B?cEZtS0ZzK2JJczZHcmtSMjVGcVBhVk42TXVjRGVSL2Q3MjdUZTQ4Sk04bVNp?=
 =?utf-8?B?RjJheWZUT0JTM3M0eU1xR3M0TnJZRXdzaG1mMFpQWHd2akc5UGRVR21zNGtz?=
 =?utf-8?B?OC8rcEtIRGppSjl1RkwyOVRMQUFWd1ZYbWVHY2I0bE9lNXQvR2dVZ3RSclBG?=
 =?utf-8?B?MmNDUFJiQ3IyVVpxckUzU1VDbnh3S2JMTW1aM0FZbUtQbG5ZWTJHU3RJV1Ax?=
 =?utf-8?B?VzYybG9DZEFOL0pqRFJBeTZ6eW5iYTlFaTRsRHArMkdTUGFVYU9GM3pNVTRo?=
 =?utf-8?B?UWNHZUlnSnZ4S0xoQVBJd0crazF1MGQ0VDlNdnFoajBmZVNWUWVRTWhzeXd2?=
 =?utf-8?B?NlRVUUw2eGtXaGthRGlsd2tuT2NQZERsNWQ1ZXhaUkw0cWlvd0Q3cDZKaWN4?=
 =?utf-8?B?ZWZwNmZSWU1Wb2ZzcHFqK3RwQi91LzhMWHZWMjBJYlNITHp5dlFJcmRQYkZ0?=
 =?utf-8?B?UU0rSmJBa1Q0b2JwMjVGVTA4VUh3TEVwOVpIdHFVdTBjY1l4WUJOV1ZIb1lU?=
 =?utf-8?B?RVlPekg1YVhoOVduc0FpSU9DTS9XR1paZitrTzVDTkxuS1oybGdMazRZVmJV?=
 =?utf-8?B?UXFGUVdOdDJSeTAyZ2twTE9aTmQ1V3JRL0M5RktFYTlNTHlzQ2x2cElPRmkr?=
 =?utf-8?B?OWpQdHIxZ3gydzdrTU1neGdBV2ljWklDZGkrb1NiMUR0MldobkJqRk8zU3ZL?=
 =?utf-8?B?RGtocHlOQWMyTXZhbWhUNDY0THByeHkrb2QwcXZWNmQ2Vkk4dzFnNDVYaEdu?=
 =?utf-8?B?b1d6a0t5WXpVRUMrTmZPOXk1Y1lmaDBhbm12WkNVc2NIcGJDZi9QNncvMG94?=
 =?utf-8?B?WmxodUdPbGxUUEhOUEl5VEc4bWZxbTlKdHg4VFE0NjFlNlBCWGFMY0VwTUph?=
 =?utf-8?B?MEsyRk1RU3hCbzBzSDR0SDVBVnN4VWF6ZUMvNmdwa3FHekxHNjVmeW5nOUJB?=
 =?utf-8?B?TUtkU0ZITEtpMTV6K0Izb2x2NlZ1aHBvaWdsU2V2cmd4SGJneTNDamI1cEZk?=
 =?utf-8?B?bzVtRGxkN2V0Z2k5UlhBd05KdXgyc29BbTNWcklod3J5cTBSUXRFd1NNZTZD?=
 =?utf-8?B?bzY5cjRqVElreUIzenAzSEVsbjBqaEVxTU1OVEFRYmliUDVTM0R2RytnYjY1?=
 =?utf-8?B?L0pVTUQzbzBPc3JaYkdxRU5vdGF6RzJPVnh1SmpGcmtucitXanI4MzM1dnQz?=
 =?utf-8?Q?5j9yqpqIKFg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpmWDluazdSdXJEUXE1V2lxNXVURVlYUlBCZXlLTTdhREREME85b2hXOWlk?=
 =?utf-8?B?eVJFZEtCY2kyZVJSYnVRSW5UT21yUGhOZHU4NWNyaElBcG9ua2pZMWFlMExo?=
 =?utf-8?B?TVg4M2tWUmxMOHFaZDFNUmhCVnUrSG9SNnlEL3V1RFhvcElxVTdqV3hpVGx0?=
 =?utf-8?B?SEtSTGZiYU0xYytyMzd0WjcxUUlhajFuTkhUdEZ4Q21FVjVndVRJSDNJdXNO?=
 =?utf-8?B?SkszcGFqU2pCNXpYNHQ5a29WUDBXTjFEb1hOWUswS2dtdW1rc2Z5dUNwNk9Z?=
 =?utf-8?B?M3hmVEx2Y0R1UkwvYTdKdTBFRE5yRUppWmpzdk9JMVZrNmxzeXZ5VXo0WjYy?=
 =?utf-8?B?NVNNN1FjblpmdWNRWkhWclowcFBpTnEzb2l3Q1g2M0VlRGpSRjRtK0IzaEFk?=
 =?utf-8?B?bHFWODVBZWdlakhCTURvUTEvS0QwZHI4M3lpelhad29rTlZKbndoMElLZ2li?=
 =?utf-8?B?TlI0SW1USmtvb0kySHZnQk1RU2JoK2pyZXZCM1NjNmF0UDVsNjM3RUYxVDg1?=
 =?utf-8?B?NUNhbzl2bVRnQjVhaURpSHFDaFZVTU1GSEZGcllRYkMxRzdqYkNnaExUODhP?=
 =?utf-8?B?WW9nYVdMQ2Uvem1SeGk5Mmd0aTcxaHRLVFlJaEVzZ3IyQ1VKWGU4YThsSmNX?=
 =?utf-8?B?ME02MWdBRWd1alo4T3VBT09PK2hhaHMzT3MyRHdRRXlmN2Fpenl1OXh3aGh0?=
 =?utf-8?B?NlROanU2dE9ud3NnUW1aRWNQMlpYOWVqOThkcWIwUS90M056SWx6em5iYits?=
 =?utf-8?B?T0o1b1NDaFQ2MjFPcFR4QkJ5eTFMWkRoUi9FbDN6T1p3K2hGTUpWTHBOSmhy?=
 =?utf-8?B?VFNxQTV3bnBxQ1cyeWZQWmtBOHVwZEttUWFQVTZoNU9xZ3dIZTdZcVllUWxl?=
 =?utf-8?B?R2xXanY3OW5tWmk3cVZkRjZva2FhZ2VnMWVhcnBvcUZHNFUvT1pocW9IUGhC?=
 =?utf-8?B?R05TSjBEUmdLQUhSY0JYRHRSREVHWjI2cDh4bTVaOUxPTlVmeVJWanRyRXpj?=
 =?utf-8?B?a2YyYzB6OEwrdWFSQys4QWtRRkV2WXN5MmRpOVJjWWk4L3NvTDFHeDd3NDVu?=
 =?utf-8?B?a0lIRFREWHByZDFCMk9WMWgzaS80Y3E5RXRXOFYwcnJDZFhLODZHMmNqeWtk?=
 =?utf-8?B?VXFTbWMzWUI3Mm9NcFJKdDRhMTQzUzQvZ0xqcUY5V0lzWnl0NEZqRmtlaUdy?=
 =?utf-8?B?Wnc0QXphdU9HYU5sTHY0VlBONFduTUlGdTIvWnJjQlNXWFlFam1JRk14d0F4?=
 =?utf-8?B?c1lIUko2NHVKQzkyR0FuWi9hUzRNclpUVWNjcTNqTU9rUzVyVXF1ZDBXL1Ru?=
 =?utf-8?B?MUU0UnRicGMrRUJSazBLT05laXhaS3F3UDRidnhxTU1HWW5ENFFreWpIby80?=
 =?utf-8?B?UDAyUXJqWXBsbStJdzMveFZlVlpnbGhMbi9EazNXZUlvc1dEUmFidDUwdytO?=
 =?utf-8?B?MzBVaEV5YkRoQzJCQkJpSWV0MHdPQXZNMlMrYkhDUUhKQlZIai9sUlFuciti?=
 =?utf-8?B?V3pKTVBRNTNYTkM3UC9URXFGZnpvbnNpUVNseXhrWG9QOUNNUDYramtjWkth?=
 =?utf-8?B?U1ZVazlRd2trcERYZXJLV1FTaDdCaEtZUjkxTDhkS1NES0JCczFDbStlVDBu?=
 =?utf-8?B?TkNYa0F0UUJBRndxcS91bkFIZFE1eW1KWUVZeFpKTWJNMHNFeGdWMW9DMldy?=
 =?utf-8?B?cE9PMnZyOElBeXJsVEhMdks2UzJVSEFrTVdra0ZHR2pPUkF5UVFOV2E5N2Fa?=
 =?utf-8?B?enBGbU92elU4RW1Sc2dWVGZaSGlHTTVoWHh5elZROUc4RlIxMnFwM2x6c1Rn?=
 =?utf-8?B?b0sxcEZiSHhoSW8zZ0NuQU00dmdCbDVVdkdkWUlsaDNTYm4zOUg2cFVYWk9W?=
 =?utf-8?B?R3hIUlB2NlhHZitmVHdCTUZhTkMwa083dFRFa2tIK3BIeC9LNmZWUVNvYmN4?=
 =?utf-8?B?MmNQZXJhK29kOTViQ0RzbWRzZ1dwdENtUE9YdVd6U1hMejFoU2VYQmdieWNB?=
 =?utf-8?B?K3Z5c0RNa25zSXdFdmxWSDlKUE5NeUdBenU4UXRzaWZVL3BXRUhBRHAxOGJG?=
 =?utf-8?B?c2dnRlQrdHlZZi9LbE9Uc1hSQjRjR3VVeFloTlRpVlh0dzNqM01QeUtlRURE?=
 =?utf-8?B?eHlBdko3ZllkbkVpZzZtcy9QYWIvS0puSVZhaFVaRGdreFhyV0RKVFBsUHpM?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uVv87GsigsBBUVtdD1ZzxtR1AVccv71fYN7wTudZWhPlACXEuWDqIzBUImrl7uEGs+d6XfqdOJeXyWKfR4vCf5YeOIQwbfeFiH8jjkqCde3PnN72J1/EjB7Vt7N8nRVxi3viUgREEti1BfHIMHIVlxD4hCG/8m3zR0PAbi5ci5S2Wrv9iR8JMfFLVJctKMGJWX0HyGBmJeE2UfbenBrNBV4btTNnENcfRpvFDvAPWO8ITtDYJmsoh36hfM6vEOqzZFJRTQ4hhToQb2NvoS/iCswyECpIvYxFsnweLgcBcvOMAzfsOByraiS54+qVH8OCGeSbkN4FVvFzbHW39tuoQ/10tSV1IPzo2UrrVCuV0jeIiru9m/4Ua51nKHLD02bY4IM6a+Gz6XdFpGTRiRCRNwhByaR3gTMOEEZgwzyYkO+cuF72jiNZ8wus7j8RhHTdT7WtZt2Yvp1luvs3sf0J/N/LfpaLrrRgVvGpSFZh0vOBM1uOoc6YemZ0djIz/gNmqlBiKwFya3922KBg0HxA1vZijZeoNuRMSyb6+hxwQlggwKlCGfvsM2MaaH67caHJ3ftxJzR38TA6VXiii2S4us5igZDVVz3dKh12ytEIYI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4ef8af-c677-44a3-e45d-08ddb961010d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 12:07:23.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9N/4gcFla5UIBoVBYooqilIYyUiYb3Oj5lgtaHYUr7h1NBQH5HPIY+PyCxtwXK33InA6eFSqh7eCJf9qoePizIpjFXXPaS77Lbl9XbCu28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020098
X-Proofpoint-ORIG-GUID: _Axd95QoqOoYIy8nUAuRfpGV4tFyrdOc
X-Proofpoint-GUID: _Axd95QoqOoYIy8nUAuRfpGV4tFyrdOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OCBTYWx0ZWRfXw9OzhD2n1G7F
 V1P8lZCR/nPBJxY9kuU3sb4V5j94WyeSmCFZfSK45xgNc8HUL+6KTtMczrkED7XvshgL4mlNJc1
 K152+4NPAjsuQowletAsHiL2P7MicVl6PxzP4NiUX9DMIuLKtAMlHYXcI3ksB8KvhNbte6ylpZj
 ZSPBpegRYJc0xNnzbeUb/K28wUNXqAXZ16vkKzL2EqEw/NIKKZ4XgFt2j8aW4y0TAvb8R2TeQQW
 eqIQMqCf2HD9i2KfDvnW+rttpOKC83+lakrosLYK6Kq7Vgb0cml7ncmsMBltzeB76pGSSPmnX46
 jAJdRBkb3xaP3RiiuMj6oSwMU9IoClIY3YVNP75ylpeVNMGn16Na15OqcDSvXuLEmlhPdZe6gBX
 9egcamQ8HV9aRiF3yXi4ZL40gYdJveV0dryfOnkdr0c8l06krq30HV1yTVnxqg0iIGAZhAUV
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68652106 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=q5-aEeyz5-TvTPOi_UIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
> As the full cpr implementation is yet to be merged upstream, do not register
> the vfio-user container with cpr. Full vfio-user support for cpr can be
> merged later as a follow-up series.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This is fine, or I could drop my pending patch "vfio/container: delete old cpr register".
Thus the vfio-user container would be registered for cpr-reboot mode, which is fine
at this time.

- Steve

> ---
>   hw/vfio-user/container.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index 3133fef177..4ee99fc2cc 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -225,14 +225,10 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
>   
>       bcontainer = &container->bcontainer;
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> -        goto free_container_exit;
> -    }
> -
>       ret = ram_block_uncoordinated_discard_disable(true);
>       if (ret) {
>           error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
> -        goto unregister_container_exit;
> +        goto free_container_exit;
>       }
>   
>       vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> @@ -261,9 +257,6 @@ listener_release_exit:
>   enable_discards_exit:
>       ram_block_uncoordinated_discard_disable(false);
>   
> -unregister_container_exit:
> -    vfio_cpr_unregister_container(bcontainer);
> -
>   free_container_exit:
>       object_unref(container);
>   
> @@ -286,7 +279,6 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
>           vioc->release(bcontainer);
>       }
>   
> -    vfio_cpr_unregister_container(bcontainer);
>       object_unref(container);
>   
>       vfio_address_space_put(space);


