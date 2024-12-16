Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE3AE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNATW-00048f-5j; Mon, 16 Dec 2024 07:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNATT-00048I-W0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:45:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNATS-00043A-1i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:45:23 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MpLG008334;
 Mon, 16 Dec 2024 12:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=pwuTTzcYd6l3ZOSo3fA7H/aHPK+griJRLSTLu4HksSM=; b=
 bfeFRFMhSeZOQ8Q+QxCnnSv/tcPKkbqgxsTkG7lLUv/CfZQEJsMWr+WebXj0LHOL
 suI8nVHJFdo9Wk648RG1q7AoHs221EGZykXJHUbd/IjIQziH0jdNOYE+jESVzerm
 D4UPy7PEc6rFzmMkder7Zy1/2PkJcI7DPLhOyYRRh/bD5mpHAikue1/HeezXFyo3
 5rbGKZ+sqPkayDo2qJ3pMR4r3X/HyrbhcQnv3ZR/13ILMMy2fU5EC7ClKeqyBkUR
 ZFaiOzXxL2nwUf0G6Jig0gHbmjqxps1PLJ9YlkH0ErsjCyTaLuRmISV+zI47iQf2
 WFfwI5S9++CNbWIOfN2bVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2b5j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:45:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGCDc3d035589; Mon, 16 Dec 2024 12:45:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f70et3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M85e2zbW5IkXNQCTynSHCX9y4o7JhbsmPzSEK1RZQdsS4wLuuSzQ29FmM2cCXIPPDtPVHatFRuIIkVj6mfkFoxCchIvInzSXkL5JOPo47qJJDzWJiNO9BY4CPBHEGKh2oCDJBNUMTmofU7rJV52caExbX50Sfa9OraEMve9CIevlXoTj3b4eWjk1ign6MKezGss0PxyhbFMoFazQS6R8YXwyeknwo3dCrEz/J6gZfb5x7NDTV37PGsQf3cxHmeE4KWHDtZQtDZIqEeGIOWcAC1MJZwaOLp2UvGQsoV09w20U3nKY+AgVBW0grMhG1F1PfOiLmYPqLX9gNh+obivCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwuTTzcYd6l3ZOSo3fA7H/aHPK+griJRLSTLu4HksSM=;
 b=ukgXUPpGxTpMgHOazy1wGjkp0uUz97/OAHPDUyRDQCS9au4Wu990xAO3Fe2vtlb45wA0EAbs7Gprjt7q3oNllduZWB523RUMC796YFYfcQSeTmD8i7ZOqC8NkbhD6gnZAgzt9r6AtVKAKyOnN26ZjZ3bXPnXaP/qh0/jX294ioQuGc1/dfI9Nt8vGnvAGvNzRI/9k7sv1fK3WXRDj9cbKbHguG1JIEHraMm2xNbe1aaDSaJi0iFIfdk9M0RxmxB+DTa/n7zGlnw223kU18QYimEQNNg5uvik9nrSwY/T3aZNQZjTrv5qK/WvzTBezn6SKt0KulvZasD0pNkSsON4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwuTTzcYd6l3ZOSo3fA7H/aHPK+griJRLSTLu4HksSM=;
 b=P/L1jWQewiCuURMKy2bA0SA8uvn4Gqjup8GLsF/i1CTUfM7ez40y69R5FwYN9S9EVL9oaEhrm/AQppN4pT2iYGOVXWD1iX34UAATVx6PSQ1TTtLN//1DGgOmu+nMD+QYSqqy4r+b+gYX8WuBms3tSw3Zuhf1cg+kdLTIAPY5CZY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 12:45:16 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:45:16 +0000
Message-ID: <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
Date: Mon, 16 Dec 2024 12:45:07 +0000
Subject: Re: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-4-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0114.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: f6783e13-9b1f-4c16-2138-08dd1dcf7dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzI1ZlJ3ajNjbnZlYkh6cmJKcFVmd0RGRXp5V3RSUXZ0Tis0d2c4bUNaYVZy?=
 =?utf-8?B?TSsvSlprV1BIWFNRNjVJZVlIdlVjU0lPajNxL2hsaUN0N0hIcVo0bGtiSXVI?=
 =?utf-8?B?R1JIdGRDOERtaWFPaGNZejdCWGVUK2U2Ym1pVEZnT09weEdtc1RmdFoxZW5H?=
 =?utf-8?B?VEhqUTRYazRLRFpHR0UxVHZCQjhWVTdoOExNQ0E0eTZxRkRxZ2lzYXdYcTh6?=
 =?utf-8?B?elpsQVg1Q0VVeHpLUGRZQVl0QXo2aS9zTGszM1d0bUNaZXZpQ2d3dTRyRDF6?=
 =?utf-8?B?aDJITjZ5ZWRja0orZ3d1NEVxdjJDa2srUE1qTktnWStkaWhUYkkvV29FN1E1?=
 =?utf-8?B?VERaWWJRaThqN01rejBrQVF0UU53MWJadENJU3ZCMWJIazBuN2w0THFGNWY3?=
 =?utf-8?B?bVVTb2g5bFljNlJZNVdPekdDVC9NOGl2OTNSTThERlR6UlVBTElvbHNBcjZZ?=
 =?utf-8?B?djN5NG1IYU5JUXNiOG5Fa2FlWXNreHp6bXRBM2NsMmZLT1AxY0hFd3orWHNj?=
 =?utf-8?B?bXBLSy8weXVPdFppTXRLZUw0MThqbDY0QVZWbkQ1cjhaL0VxalhNTk84clBm?=
 =?utf-8?B?RUt2MFBBTHZpMzRXOEYwOGdWeUsvZDdNVzVsUVd1RVdleWNkNFVBMmxKVGpy?=
 =?utf-8?B?dHhOcTk3NGV5dE1BSFBVUUFvOXFPQkxPVkFXT0VkUEIrWDI3U29NQkI0aVg5?=
 =?utf-8?B?WHZNWTdVZkpQN2pKd2VhMHlIamM2ajNmZFdEWUI5TjVsenZ6YTJqQ0kwS1lL?=
 =?utf-8?B?K0l2WEFRVDQxd01GUlJLRTJsbEk5czUxeFpYYjBmWU9WVXkvTGVXdGNxelRS?=
 =?utf-8?B?Z3ZHdmNmNWw0M1piWW9xTFdkYW5oTzNHTnM2TTFYN2xxSkFrbUtoU3Y4Q3pw?=
 =?utf-8?B?eWZwTTZ1ZmV4SzNyUUZxNW95M3ZIMTZFbU4rdmJXV21BMGJrZkFVeDhuWk4w?=
 =?utf-8?B?dWFzUHdUZFIxUndKamg2NjdvbjZjNWhkeVJFc2FCK01Uc0hLOEtiUFc0NVRU?=
 =?utf-8?B?NHBISUFna1hMSUt5ZDNoQlFNbTZ0eXBDVnZZNWxFd1l5dERDM0dDRllocVhH?=
 =?utf-8?B?b2tyRmoydFNhZExFcyticmtuMm1YM1R3eWg4dmRPZEx5QXdDUS9HckVhTnFi?=
 =?utf-8?B?ckptTkxZUTMydEFwZXI4NjlxNkVQd2lRclRlNnBDWXZhNXlURzl4QXpKczZq?=
 =?utf-8?B?T1c1TFhHbEZUa2Qxemo5OUE0Y0J2V0dBR2p2WFBWQnI0Sm1WT2M5OVdHa1dj?=
 =?utf-8?B?OHZtUVFOQlhPNjd6OXpJbExNeVNVTGV6eGVBRC9yWDM4QU8wL3A5N0hFbEZs?=
 =?utf-8?B?Mm5RREVaSWp6UC9vekwvbE9JS1pVaWdPQ2ZDclk0em1ZbWxOblVydzJMYnk3?=
 =?utf-8?B?cGp4ckVUQWsrMXV0dFF0SnNIQXpVS3pXV3dwa3VzbEZQVUpMNDJEcTM0eGVs?=
 =?utf-8?B?Sy9VaWFLeDNmeTlFMkVjWlVldmppZUQxT3VyWjY2K2NRdWp1a0xNcXo3MjR0?=
 =?utf-8?B?ckxwL05JZE9kMjhFV29mMVJpbTVGRWVvSjNBODFMRVBMRnE4YWQ0TmdyQXFY?=
 =?utf-8?B?aGhkR2J6clprWThBMkdaZ2lVMjJFNkE1b0k0dTYySDRueVFLd3BXaEYyRFNt?=
 =?utf-8?B?c2RrTkxZLzJnTXhsaWtuY2lVcC9QZkhkMGJ3MkxpWkFlN21DOXd4N0gzMmk2?=
 =?utf-8?B?d3QvMDJaZWZBcCt1Z2pnVlZsMCt2a2lIMmdjQjhGWHhyd1pCL1Btckw4cWpn?=
 =?utf-8?B?QkZ3UHpTeit1N2haMXdIWnlGZm1Xd2RkOWFTQnFvRTFxWlRvK2NwK0JkSFdT?=
 =?utf-8?B?eEhqTWFIS3VGQW9KOHZBbzNCckRhbnBHM0dqb3lJRmo1SDc5RGdsa01hZkUy?=
 =?utf-8?Q?jJO27X/yQHzzs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1FeC9ab1dWSERYdlNVbHhXZXNoemZTVGxBekk3M1poZ09KTng1dUFYaVJH?=
 =?utf-8?B?SCtGZE5qWitMdGVXdUF4UjNNaTI4aUhaVEo3eXp3VDJGYm14cDVBamt6WEdL?=
 =?utf-8?B?K0ZIY1huTjFUblFDUS9JZXZhNTU5azBsTjdDZGVOcDJZaWg4Z2NVa2ZMWTZr?=
 =?utf-8?B?c0M0KzNubVM2a3d0SzdCU2dpQ3RYTEtuWlhDcGNNRmVZTE8zajI4VVRpQ0tU?=
 =?utf-8?B?YzIrUENlS29UaFc3Y3k3cm1uamp6RVRIUEtaaWFLVnJKTmZuaTVUbjdKTXRT?=
 =?utf-8?B?ZEVSTkNCOE41Zjk5SXQ4cnNTa01ncG9YaFFtMlhic21RSWt5U2had2dkK2VR?=
 =?utf-8?B?VTgvWG83OGJ3bHF3MXJ2YjBqM3hEdDg2NGtlSkVhd3dXNm5PU1kwdXhTZkFN?=
 =?utf-8?B?aENGRnFKSytSaEhseVdIdEVrbVZqZ0xwQ2thVVZHbUF1a3BuaElJKys3enNh?=
 =?utf-8?B?ZEVRV29YbkhTWjFKQ3hkSCtrZ3FRazNEVUNvdDFPSWRjeXNzNlN5LzZ0WDJ1?=
 =?utf-8?B?WEpEMWRsVGk3bmtkN24za0ozdGhWSHRmNklLRnh4Tjc5ZXlEeGl5bmdudU1Q?=
 =?utf-8?B?QWt3dWpZaHVaK3dZZEM5K1hidjNvcWNid2p2c3pqVUlGNlljS3B6YUkrYUgz?=
 =?utf-8?B?VTcyVndEVy9lWmpvaVlzU0RFRVRQaWo1WlYyQXQ1YjNMVHF0bW93Ui83QTlj?=
 =?utf-8?B?ZUFDNnJ4czkvRyt0YVlNbW9HcnJodGh5SDhadGFkWHdyZ3pYY3YxMVB3bXZM?=
 =?utf-8?B?K1ExWGtjSHEzdFRjcU1jNllsVGdHVHY4UVVzRUZFSE50TzVZU0xOc1FReTBZ?=
 =?utf-8?B?VUJvYkxBYSt3eCt0NW1TVWozd3dZUytSbkM3cTBZR1dxUDU5a3UxVTNSN2Fv?=
 =?utf-8?B?c3cyL3hwZWZiQjhFZTQvL2NjaWdmS21kUjZSY1BiZ1hZcHdWQ0FIYnJXVVNS?=
 =?utf-8?B?R3RMUTNQYUlEaE1nUmRITFI2OEtoZjhvaWVuVGt6eU5nczVrcXN4aThxQ000?=
 =?utf-8?B?NVVIeTh2c1lUMWlLb3I5WEdHOEozNG9kYVoxa2hTNXpMWHhUbWNWOFAvbnk1?=
 =?utf-8?B?SnRhcGhCRDFhaExKYjhDdmxPL2QxejU3QXNlc212bk93aFhuakF3bmszMlIw?=
 =?utf-8?B?eW8zRnNhcW96alI4WVhIWDBLTFFDb0tZZzZYMWRrdVNrM1lKUTdTbUxJT293?=
 =?utf-8?B?RlVQU3dGMGg1SE9ETmhEcHQyc2cyZkNrY1JGYmdROXRJUlRwRmpGeEF0bk9r?=
 =?utf-8?B?Q3pTbHBRZWN4NTZkdGxUOEpUdDB6dG1CMXdNY3ZjVXVnTUF2ZVlpU3dlRjFs?=
 =?utf-8?B?cS9WdUJLUW8xdElhRGd5cWRhM3VHNExTUnYyam1jWWRmRG9RdTFCMlhXZzlL?=
 =?utf-8?B?Y2FJdjVWS2ZmVDlDamZFdm1DZFdrRnVKOWtwRFBBZGRwSzJTcGJoKzE0bzQv?=
 =?utf-8?B?R0p4dEVrSERBTzBYemJVQ0pRSFVPOE5jL1IwSXMxb2l4ZkVJbWlZNEhMZnZl?=
 =?utf-8?B?S0VaYllScHhpZCtYN3QxcnVMeURJZTFQdTQ3R3FYOG5vWlNMK2g0bS9VcE1P?=
 =?utf-8?B?TW9Wc3VoUkl1TEtaMkV6T2I5dkZSbEN2c1cwcksyWmxLbUxtQXpDMGlhWGFZ?=
 =?utf-8?B?cXFqcDdOTm95cDhoTnIzN2hBdU11V3pZclB1OEIwdWFSNjIrWEFKVFoyNytJ?=
 =?utf-8?B?Y3F0dXNhS1ozVjVWR2ZuV0MyRTRPelJGTkkrRTlPei9uWmNEUDNVZGJUYjlP?=
 =?utf-8?B?bFhWTjBPQzhiRGxjQzdaeWNBd0w1M0FhOTc1djlmVHEwenRkdlZWRkh2M0No?=
 =?utf-8?B?SVd4OE42TnB3UVpEU2YxbHBlSVJLMDhxdDRIK3AwM0ZKSWZWdVFBSlN5OUF0?=
 =?utf-8?B?WlVWWFU0Yjd4cTRvQmpCY0RuREJtVThoRGJOWWtpa2tMbG1WVjI4SHlIbGV2?=
 =?utf-8?B?OHp2ZWlGSncwZktPeWwxQlhCczFjMWRTcElBZE9QcHlDcGxpSjVFdEZuNStX?=
 =?utf-8?B?a1BwY3dUL3hjZis0cUlFUHp2UzJrRCswQUNjMzFYZm9LYkxZeTFtMXc1b3N1?=
 =?utf-8?B?UWhhL3JWQ1QwdmlpMDZEUWJldUxyR01xSVpBT2NMM01wYlVheVJaMDllTkZo?=
 =?utf-8?B?b2VMT3lyTm5Dc0ZLdkVSRWY2K29tSHF5UERhM3hkK2hoSHRNWXhIZTd2NG1h?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v2UDU3ojQgKgCiebv32nizydfh3KlvqFJ7Wk+l+XBmXQ0TQk6hFRpMqiKXbq+sn5xJ629urvThZC41yG8quFmtVcNOdWRPm8J+tbduCMSDrEW1u7uaSccQbyD8j+xiE27Ntw8PuOEAdlXaigIcn5An4+3TTOcVwp//b3riQk8CWKVY523/PcWqcF7wp3yQ/pexLyepvnk+PdabnDlPtTNEaNFMQ0wesBofR8mklyQk6xD1F5NgolErb/GvCmKc2dFtEC+m3iFPKclYMtAo0TcCBGmwhj7qCLU+AcZfsX5eFkwX0sr04q9MEyF52DbHa1TmWjfmE0J24EW8pt9swYq40/SzyYPV/njGlc+C24WD1OuDn0oYu6w9IKweL8SN5ga86Iw68gcMawY1QR65v+6FHplNLqM4aBA/ysWzbN8xFyQdO9i2xTyQKmHa55IBxBHzBAf4k+G8bG8J+0pk9tzAtiFq2kQGpUPjLzF+AKcUYKF52+Sv+1qYV94yacC7Laq+2fxf3i8mdHM8E6d9nEf0aThRCluI5IAqgPPwsk1ZJyh+K3uq9JHgU6hWooEUTyVcbJebhBGzJCFjjp/JRwGrSb2hz66LFD9KBy4QjQNg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6783e13-9b1f-4c16-2138-08dd1dcf7dd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:45:16.5913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKFjUodiAaJDqLAuN4FNRAWS/3wdkI6IXmpr5ccUGz/dlSYCkC50GHu2tkPmnpWBBOG9ue1DsitTL9nc3U5Wxb4yI4HJxvhHJ6jGhnjsfnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160107
X-Proofpoint-ORIG-GUID: B8G9to813hDCzqrlTOKcKY_JAn_7ZsYt
X-Proofpoint-GUID: B8G9to813hDCzqrlTOKcKY_JAn_7ZsYt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/12/2024 09:46, Avihai Horon wrote:
> During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
> is used to check whether a dirty page log sync of the unmapped pages is
> required. Such log sync is needed during migration pre-copy phase, and
> the current logic detects it by checking if migration is active and if
> the VFIO devices are running.
> 
> However, recently there has been an effort to simplify the migration
> status API and reduce it to a single migration_is_running() function.
> 
> To accommodate this, refactor vfio_devices_all_running_and_mig_active()
> logic so it won't use migration_is_active().
> 
> Do it by modifying the logic to check if migration is running and dirty
> tracking has been started. This should be equivalent to the previous
> logic because when the guest is stopped there shouldn't be DMA unmaps
> coming from it. Also rename the function properly.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/hw/vfio/vfio-common.h |  3 +--
>  hw/vfio/common.c              | 28 ++++------------------------
>  hw/vfio/container.c           |  2 +-
>  3 files changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e0ce6ec3a9..c23ca34871 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -296,8 +296,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
>  
>  int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
> -bool
> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
>  bool
>  vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index a99796403e..81fba81a6f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -229,34 +229,14 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>      return true;
>  }
>  
> -/*
> - * Check if all VFIO devices are running and migration is active, which is
> - * essentially equivalent to the migration being in pre-copy phase.
> - */
> -bool
> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>  {
> -    VFIODevice *vbasedev;
> -
> -    if (!migration_is_active()) {
> +    if (!migration_is_running()) {
>          return false;
>      }
>  
> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        VFIOMigration *migration = vbasedev->migration;
> -
> -        if (!migration) {
> -            return false;
> -        }
> -
> -        if (vfio_device_state_is_running(vbasedev) ||
> -            vfio_device_state_is_precopy(vbasedev)) {
> -            continue;
> -        } else {
> -            return false;
> -        }

Functionally the change implies that even if non-migratable VFIO devices behind
IOMMUs with dirty tracking would still sync DMA bitmap. I think this is OK as it
increases the coverage for calc-dirty-rate (provided my comment in an earlier
patch) such that if you try to get a dirty rate included the IOMMU invalidations
marking the bits accordingly.

Just stating the obvious in case this was non intended.

> -    }
> -    return true;
> +    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +           bcontainer->dirty_pages_started;
>  }
>  
>  static bool vfio_listener_skipped_section(MemoryRegionSection *section)
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9ccdb639ac..8107873534 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
> +    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
>              return vfio_dma_unmap_bitmap(container, iova, size, iotlb);

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

