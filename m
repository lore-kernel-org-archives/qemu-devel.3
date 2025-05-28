Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9992C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKpR-0007iX-Dh; Wed, 28 May 2025 13:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKKpP-0007iE-0E
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:44:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKKpM-00009o-87
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:44:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq7GG024202;
 Wed, 28 May 2025 17:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Ui2yrLANvBPwC8Zk9WDBaOEJLoGZD1fLl/i3Jtrd/7c=; b=
 VW/PwTl4jAb1NgLRR2fxKkGQJveQT8ft7QNbnrWlkdeASxYIMoogMRrdv8VNaiQZ
 5KKJv2/fvXei1LgexqdHqhdVnUfpIPAHpVSVQCmDBLUH6H9KWZltUmyiM7sUJEie
 7jFcACoq8ZMhze2/T24Qu7WFZnAC1lNIBLJurUXQl8eH2iIumCl91AQ7Ua+3iSjU
 HgVSKIMKsh8vMMh+tCPSbCE1062PDqyh9nLyVcnjPIH3RUbBCi9mGUMRERHDpyTw
 Jpk7VaCt3jHiMAzjq41IYgYUek6DLfBA/wt+jmryHPZ27EZXQWddCxlBb+kc1NqO
 Bj5+nRUjU6rkSUDr9wPcvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46txjp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 17:44:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SGjUt0024593; Wed, 28 May 2025 17:44:21 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jayyr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 17:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sctVmu4vXbjbSs72hV4Er53YuWyE3HfN6goHx8ervV3FcAMQoWWiVhCmCAwJq+8PBhrdIX8ydiRGDS3VSz0aZOS2YFT7mEa1mYFkqDjODG045qpJJUXcR+AuB03rmpd7Ea8yZ1LBPD0f3Xb45HNLEGe0FbxwMFra9Q6NqnSo1LwZoEmI4bn5ekBOXaqP+eyMvPapKfzx1lOfbOnv4rGfTEtoE+hsLKPop1WRYjWfeeUbs5oZUVY6Rw/bXsovTFgv1v8Zet+fBuflBP/3gdZkq+yhBGwEypdJO84/eCSuYsmIFG+zoe+kvRi/e2xzzP90JNqhBlzsoHHloE9L5xJyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui2yrLANvBPwC8Zk9WDBaOEJLoGZD1fLl/i3Jtrd/7c=;
 b=xcMXgUcMyz1pY1TUyA/8TdqLn2XBDmzT/t0PIa7gr0FL14EKmkMbsFJPWQM4Elt4cul3T1yEl2wiLvENMKkLWkwJUbgUDYGetmlBfFoB6+ArVMWrtjO427GVkcagF8NKBE4uSVadWkRxS3oHCPOgprpIQy9poRQbXONy/jxM5hZM6ziinbVNH7RQ4suvzH/dHP9oHlpa6DXlM3XPTy3VDsCaDUu/1kN9f2iUI1day2Zhk4qRHtKtGEkzd5s0E9GDY7Xf9d47W5O2YvnymRVWI4MY4axH+4oUWeTNTVnAzi73STYGnBZc2ZmR90qckoQ06mFpVCds1QFjNgmlf8qLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui2yrLANvBPwC8Zk9WDBaOEJLoGZD1fLl/i3Jtrd/7c=;
 b=PN3jXUUHdPmbA9fyFCVxh82ZzDXl25I6tyyevLPUvK4Z0Oo5I5KRMbzIulMhufXTq2WjwFd/VCQ/9ZN+GKBZOKCTW3RUlNqXek5Bq9+hRuc1LcGWv2Cyly53wdwY99Nl1Xx+eCU9A8oWxtSfU5yOnSwLgRNpF0dFLZ9jYrGjkpM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 28 May
 2025 17:44:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 28 May 2025
 17:44:18 +0000
Message-ID: <a01fca3f-1411-4b4c-a87b-59f97776e14f@oracle.com>
Date: Wed, 28 May 2025 13:44:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 22/42] vfio-pci: preserve MSI
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-23-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-23-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: e398fd9f-a02b-4745-e1f9-08dd9e0f4518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWk2OXpqZzZ5V1Q2anlncUNLbXRRTktLWGxxRjd5ZnRaeGVFZitNZEFEOVhr?=
 =?utf-8?B?a2h5RW1YU0lEdEJlL3dOWm03b1VPY2NjRW9PM0J2bmpnM1Z1Z0ErRXg4MXc2?=
 =?utf-8?B?SmtvSkQ1eFhraWZBbkdqZHVPckZIM2hKY2dtUkRac3dlRjZZNVVXbFZuOUht?=
 =?utf-8?B?TkFDKzVYbTc3YzdEUXU2c2l1MXJLR09nRWViVXFEeU5PYkxkRldHR1ZsdFk4?=
 =?utf-8?B?QndRb2YrVHdqSG1tbmRWdVhNL3NVNldZMC9GT3M4WWhMMkdvL2t3Rk85SStF?=
 =?utf-8?B?SGpuZTBCYkRLMWt0ZjdCaWhYejE2ZElGVFRLOHJ0cGZKREFlQVpHaFFpU0hU?=
 =?utf-8?B?eDBreHNWQUllaWM0TnE0YTlHSXN5Z1VMMHBPekY4RmFDa0lBSVduNXNKVW93?=
 =?utf-8?B?cnlMR25GZElybEVUcjhBZnhJTGtITlhBcjVVUHlzQVBXWU55NEZzeFFoNW56?=
 =?utf-8?B?M29PcHNKaGFPU1I3Z1JzaXQ5OHZJM2Y5SmZBK2graktjdjhLUEsyczFCNkgx?=
 =?utf-8?B?RDAwVnpUZllnbVBqamkvU0FqbCtza3ZBUzFveitHVnJUS0srSUJuck9mTUgw?=
 =?utf-8?B?b0U2cEt3MWxkdGNrNmtYRGt2dTVuVTRLb2xTQVpVb3oxM3ZUMmxkS0RMdmpU?=
 =?utf-8?B?cHNwY0ZWSEhEVXdKQy90VWtYNmNXYWd5NTRHblFaUCtxdDRkUDcrU3drUFdz?=
 =?utf-8?B?cU9NSkx1WU9DZTdtSDZYMEozTEh3bmRBbzFnNUNyRytGeW5tTm5URTRNZEMr?=
 =?utf-8?B?NUFlNXNGWXBkcXpoRDdnNnh6WExFVWN1Z09ZU0JobHhWRlhZWE5mLzZkVjU1?=
 =?utf-8?B?azFUZWR5QzVQUzJ3Z0JPRWVvR3NQdVRnNE5UV2VKWHlkOW1seTNtVHBmVkha?=
 =?utf-8?B?K1o4WVRxOHIwejZOSWp5eXc0OXBoUHVocTVGY2g0Z2tOMEE4WkcrMlMvalEr?=
 =?utf-8?B?L25jUTlDdnUrL0RQL2x4VFhvcU9CTkhEWjg4UUpRcDdxS2RKNS93WTFDd0ZI?=
 =?utf-8?B?Mm5vRU44RlJxMTdyM040Q2RGUmIvNlRYcDlZSmdJWGEwRjA3L2ZWUkVkSFJQ?=
 =?utf-8?B?ekVCMmhDTHhLSFB5eVpCSDc3MnJwL0hFcHppZytnVUUwMXhPZUVJMkF4VmpT?=
 =?utf-8?B?UFBpTXRoQll1OHJrc0lzaXJWQUhHNzZUeE1MSU5MVTc5enhwbzJsWklEYk1r?=
 =?utf-8?B?dStlNnloZnFQWmYrdTM3NjhGUFp5dE8xd1B3aUs0dUt2Yk9VY082L1pvMG92?=
 =?utf-8?B?UVRHL3IzT2oxNlhRcjUya3dQdkxyVWo5eFh2cnNEUTlpd1NDRXYzWGdBS1k4?=
 =?utf-8?B?SnV0d1V3a1Jmb05IeEU3d1VIN0gyNWp5bUFRekF3QWJLWi80RG5BYWZIWjJL?=
 =?utf-8?B?ZFNBaWVtckF3a3pYc1ozUVMyN1R3RTFhNmsvL1ZPTXdwZnRaeTlHNFl2VVlT?=
 =?utf-8?B?aWlEeWplTHZNTlU5M0w1YnZFK0MzVHgvQmlpYjRGV0JTUHJjSHhGREoxUjRB?=
 =?utf-8?B?Y2tqam1mZW01KytkUkpCckJ5TkNuODRVc1BobC94UjkzeHdNRmVtSWNFMG42?=
 =?utf-8?B?cytiTkJnYzdCa0Y4VUZKVDVnMkNiVWhENjZJOWlHRVR1cTJCZWtCNGI3Q0FN?=
 =?utf-8?B?SEkyNVdNc01kaE5BNTBTaGRsU1ZhMmp5cXpvKzBCSVlsMnZOK2wxNkswcGxq?=
 =?utf-8?B?bTBVRFhQc2tPdGVuK3RIM2pib0dnNzJXVFFOeldxTzhKMmZHcHBDbTdMT0Fl?=
 =?utf-8?B?ZElxUytLT0pxbWFSVitzMHp4bWcwWW1WL0ptblg1N0hHQVpFSCtHTnhsbWZS?=
 =?utf-8?B?YmlMUGJZN2xTbnNhNk5QaUdHaXo3aHJ5ZkhENS9DdEtSQUhiV0N4YlA0cTVX?=
 =?utf-8?B?bGg0RlM5WWRpWXZWa0tiUVhROVpHS2ZSVkJteEM5OFpTTmRySjB6ZUliOWxO?=
 =?utf-8?Q?iGF7Hi0i4kw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpRYm4rV2RtNTNRTjJqczRtUEpCWFhucWsybDh2MGZhalNVK1h1bTMxTWNj?=
 =?utf-8?B?TXl1TVhSYW5Jam9obytNMVlhR3l1Q0pOQVB4ZC9FWXN5T3pWSyt2MGZzK3hC?=
 =?utf-8?B?dW1nWHZqS2x6QUc2b0N0RGxkNFhScnBleDFBcEFRekUrOGVKOWF6WjVVU0hu?=
 =?utf-8?B?NDBCS1VWTjNSV0pKbzFsWTNoTVYyRFVqeUgyaG56MkRCbjc1ZDh2cnYyOTF6?=
 =?utf-8?B?YzkzWGV1emYwbk9uMUlhbWpBRCtDLzJzMy9TTzJMOC9vUlkzS1Ruankrem9q?=
 =?utf-8?B?c1dNL05HZTd6NG82TjRkR3VlYVhiQk0rZlFpN3FhbENkazU2bXpyaC85eUh4?=
 =?utf-8?B?QkRDc2pYNWUzSWpyd3BraG4rMWxsQW9yUThOclVMZVVRT0tISUw1RnNXWVVT?=
 =?utf-8?B?QnQwaW0vbzhpQURxVEJnUjZpbG4wclE4M2dMTXhIUjRWWE91dFZtaUgyUitj?=
 =?utf-8?B?RDQ5ZndSQ2g4QzdKeko4Y2tpN2JhbGJxT0lyUnBjL3ZobGxMR3F0cGNqUkcw?=
 =?utf-8?B?OVkwUmxSMDZzVy83dzVoejhUVCsxaDlMRnpzdEQ1QzJRWHcyM1VXa0tyQ0ds?=
 =?utf-8?B?Q2tEdUJEWjlmVkhEZ21ITWVWdjhjQlJhVWVZZVdsSk14T0cvSVFWU2xXeUJz?=
 =?utf-8?B?bk9pVUVEVzlsTVdsc21pQUxmbTYvMVdMNDUxd2pYVXAxRWZUdjRaeEhQRlF6?=
 =?utf-8?B?SzJvV0JlVUhGQmhPVmJZLytmRi9jR3RnWFlFNTlsM1NtSE1HNTI5MVhkUVZM?=
 =?utf-8?B?SmE2cXFyaDd6bnorQlcraG1YajBnQ1NDTDBhRHdtRk1KOGxpd2lYempsOEV6?=
 =?utf-8?B?MTNXaTZIU3Y1SnNkb2JLY3pEU0NrMWJCMU9zelFjSzdPbmR3SmtiUGJGQkZL?=
 =?utf-8?B?WXNoVzJuUnhQMDlCQmc4T2NNVE9DS2JHOVVqai9tdlRCU0ZoOURGeXhGWHRI?=
 =?utf-8?B?WmNjY0s5endWRkgvQVZGdHdBbTEyeVJQTENMYjRsakpzRW92eTdKSVdiQ010?=
 =?utf-8?B?cjhOMFJoR0lJVzZhQ2c5K0x6YmNsRExBbWhXWk04M1p2VnVFYXpJR3dkVTRx?=
 =?utf-8?B?TnpLNHNLRzZha0xWQWRxRUVQUUxCNG5oWm4ydHJBS0dYTWFQaU9aTURIMWlp?=
 =?utf-8?B?OCt4endMTUNUYnMzU0RKWldmRVdtNGlZOGhtODZkTHh1aFNmWGx1dFJnRmMw?=
 =?utf-8?B?UkF5V1E2YnJidjdjbUxvL2ZHSllOazRKeEx6NFQ1Y2tkKzBDRUpQamVTZWVy?=
 =?utf-8?B?c2lYb0JNbTVORDV2QjcvN3NPc2NDY3UzTlZRV1NOazVOYVdXZzNSYmhpeURn?=
 =?utf-8?B?MTFpd2RnWmVOMmJsY2VGbS9NZUdhS21kN0xVY09IRXY4UEYzc0NDUDJnV0lk?=
 =?utf-8?B?UlFFV1k1ZkptazBxbnVLdEFWb1d2emZNN2FjV1c5eEE4ZGFuVERELzExRXc1?=
 =?utf-8?B?RHh3RDZObVlScEg2U2ZmY3FjVDg5ZDVVakZNaDFnZXMvczZvcndOcmw3dTFM?=
 =?utf-8?B?VG1YWVhNR29BTTU1eUZGMEVZWlRZSHdyMlkrQUMrZURjdXNTd2RGTjd2VDM2?=
 =?utf-8?B?Wlh1eUxjSjhMNFZzME5BRUZCVzhxVlB1Zkxsbm5vMzZjNmNSU2VpNlpqc0Nk?=
 =?utf-8?B?d1QrdE9mS0RoYmd0UkdvUC91ZHZGaHdUY2xadXQyY3dGTVBtN2FRMEJXdnhy?=
 =?utf-8?B?MHB2RGtkK3pUWHk0K281a2RpeUlEZ1hWcENwazBweEFuS3g1Wjk1SlZncVoz?=
 =?utf-8?B?Y09JUXNic3dFU1U2aFVnYk5lbUdTa3BwK1dhM2d4dnVIVXNYaDkrNzFPNVJI?=
 =?utf-8?B?N3B4emVmbldhRjRPSTduTkVOZ21nS3A1dDN1cnJWNkwrWkRDN1N6UVVhMVlV?=
 =?utf-8?B?YlFXcUZnN0tieExYY0dERjFtRVhNc21RZHVXcjBCUGxyVmJCM01YdXRPZHJl?=
 =?utf-8?B?TXJWMDlDSlVNZ0ozdVM1OGxmVXBRNFdCSlJiYUljZzFaWGkzMWxQTGlGNmlD?=
 =?utf-8?B?alJCZ093b085dGNDaVJvTnhXYVBhY0pXOEllVVdXTjR6UDZ3VkdqS05DSlJG?=
 =?utf-8?B?UEZrOUlMTStYY0l3ZXVsZWxGNGxvcVh5cjlMeVYxa29aYUI0NTBJbXF0N08x?=
 =?utf-8?B?UDE1Q0NQK2NKalZiS084QytJQ2I2RVZBVUgrYUIwcjFLMFd6ZXZZYkJvb0Jp?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1SJLJVhFt/srZHlGc1kElKoaiMa2IAyALuYSoFGzBjaFDCpzYQtIgqLkrcXr5brvpB9xHh5gMCubLJ/WqjKk4yCqcEcpCLv2yjCgT5mqVBNrjsgbdb7YS0ckCDJDf/onFux9hatXWewYBvNDSWdN59S9846WuTijYeNbpXXDHOKZEwWLGqNoXcsRMd/K8waeLaLM6xzhTXV+WtygtztsTxiQ7qsBR/L3FMgSP3LqlEbu5RFUmnZ6//IVx88UdaizLOLGSZsRiwQeue5WL2YoumDgzzMfGD6l+LtOfXoVR0vJdeEeVP0eRxH/Vm4+0LHdZuLgETXoKl7UrMi9yr8DfB0EWQJmaejaWk2JqU3/0+FVtJuhzqsdtxuhHLtPzryqhhRnoY9bgXnUvslEyNU3RPbgWTtx73F3rQb5mVtaOm+8+xv25IPjpZiImQbwL9DLVF7DF3EO4uIkxju8AEibI21nTZTQhjH2JcPddSc4zZu+/OQcoc9kM7RmKxXIlcWbgz/KmFJmqhpRjrN0tVVCKq6hq2JQJ1DJFmrHR8mZ17MBnG6/OpC9jlHEpD1CIjQ2kWxVr2ur9UhA7WBSbuwTqgE72MkcT6qrlv949+AHvuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e398fd9f-a02b-4745-e1f9-08dd9e0f4518
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:44:17.9055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEl8+6MdhmSoqz6TOYbz0iNo67WUhElWANkvJ7u76AH/mtp6J/FesUdpY8j7Px+uFE61GODEh+MMtvJLYLD5d4tWagh7+rqEN0WRPubLSNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280154
X-Proofpoint-GUID: iewwG5geBhDOGNtUwPZ1ZRwuQtb4VGIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1NCBTYWx0ZWRfX17TYuZ30RPqs
 VQgY3hEFb9WyGKwg7WTp9Dh4fKrWdFr7CCBUJsUenY2N4D9wtlRHRFXQwWcvV8LM1fVJg7vsLIW
 ZQgalmwq76gaYz6cV78nm5ROgbHXYC68rdZHLAVKep0mHrMOlelYUp0mvxJtk9sofUiRxbtYiXX
 Wauflbojx+aMavIWAn4a/ZYwiKy1wJd/EChYYqactbPqaJh9EfflebSemuQMLzDyWR/5A5Phi3/
 /ZKnzJPyQFtNbhdJI3FjCkaytyNx7VLbFYQ526UoHuOutzXs8jiXg/LgqRKbOUT1PNdZs/8gZEP
 EkKEIX5LHzuG26KdqYnDWF9hisOuouU/eJYejVTjE/qst0ETbsO9mMARhFTtL+Sbl/K4s3Zt225
 WzX/fZvZF8p4jMQL3kEy/DaIyt+4o95gmoYxv7pmOpWYtOY+kpdNgGUZIURQexJKaICOZjzC
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68374b7b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ohayWL_gj4mm3sVelG0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: iewwG5geBhDOGNtUwPZ1ZRwuQtb4VGIB
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Cedric,
   Do you have any comments on this before I send V4?
Ditto for patch "vfio-pci: preserve INTx".
In both, I made the changes you requested in V2.
And I will change all "reused" tests to cpr_is_incoming as we
discussed elsewhere.

You mentioned these possibly conflict with vfio-user, but it would
help to get your stylistic and correctness comments on these from a
cpr-only point of view before I send the next version.

And as I mentioned, I propose to block CPR when vfio-user is used,
at least initially, so you can ignore vfio-user in the cpr load paths below.

- Steve

On 5/12/2025 11:32 AM, Steve Sistare wrote:
> Save the MSI message area as part of vfio-pci vmstate, and preserve the
> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
> then the vfio-pci post_load handler finds the eventfds in CPR state,
> rebuilds vector data structures, and attaches the interrupts to the new
> KVM instance.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr.c              | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              | 40 ++++++++++++++++++--
>   include/hw/vfio/vfio-cpr.h |  8 ++++
>   3 files changed, 136 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 6ea8e9f..be132fa 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -9,6 +9,8 @@
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "hw/vfio/pci.h"
> +#include "hw/pci/msix.h"
> +#include "hw/pci/msi.h"
>   #include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
>   
> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
> +
> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> +                             int fd)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_save_fd(fdname, nr, fd);
> +}
> +
> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    return cpr_find_fd(fdname, nr);
> +}
> +
> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_delete_fd(fdname, nr);
> +}
> +
> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
> +                                   bool msix)
> +{
> +    int i, fd;
> +    bool pending = false;
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vdev->nr_vectors = nr_vectors;
> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
> +
> +    vfio_prepare_kvm_msi_virq_batch(vdev);
> +
> +    for (i = 0; i < nr_vectors; i++) {
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +
> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
> +        if (fd >= 0) {
> +            vfio_vector_init(vdev, i);
> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
> +        }
> +
> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
> +        } else {
> +            vdev->msi_vectors[i].virq = -1;
> +        }
> +
> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
> +            set_bit(i, vdev->msix->pending);
> +            pending = true;
> +        }
> +    }
> +
> +    vfio_commit_kvm_msi_virq_batch(vdev);
> +
> +    if (msix) {
> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
> +    }
> +}
> +
>   /*
>    * The kernel may change non-emulated config bits.  Exclude them from the
>    * changed-bits check in get_pci_config_device.
> @@ -58,13 +123,39 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>       return 0;
>   }
>   
> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int nr_vectors;
> +
> +    if (msix_enabled(pdev)) {
> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
> +                                   vfio_msix_vector_release, NULL);
> +        nr_vectors = vdev->msix->entries;
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
> +
> +    } else if (msi_enabled(pdev)) {
> +        nr_vectors = msi_nr_vectors_allocated(pdev);
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        g_assert_not_reached();      /* completed in a subsequent patch */
> +    }
> +
> +    return 0;
> +}
> +
>   const VMStateDescription vfio_cpr_pci_vmstate = {
>       .name = "vfio-cpr-pci",
>       .version_id = 0,
>       .minimum_version_id = 0,
>       .pre_load = vfio_cpr_pci_pre_load,
> +    .post_load = vfio_cpr_pci_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1bca415..bfa72bc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -29,6 +29,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "migration/vmstate.h"
>   #include "qobject/qdict.h"
>   #include "qemu/error-report.h"
> @@ -56,13 +57,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +/* Create new or reuse existing eventfd */
>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>                                  const char *name, int nr, Error **errp)
>   {
> -    int ret = event_notifier_init(e, 0);
> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
> +    int ret = 0;
>   
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +    if (fd >= 0) {
> +        event_notifier_init_fd(e, fd);
> +    } else {
> +        ret = event_notifier_init(e, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +        } else {
> +            fd = event_notifier_get_fd(e);
> +            if (fd >= 0) {
> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
> +            }
> +        }
>       }
>       return !ret;
>   }
> @@ -70,6 +83,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>                                     const char *name, int nr)
>   {
> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>       event_notifier_cleanup(e);
>   }
>   
> @@ -554,6 +568,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>   
> +    /*
> +     * Ignore the callback from msix_set_vector_notifiers during resume.
> +     * The necessary subset of these actions is called from
> +     * vfio_cpr_claim_vectors during post load.
> +     */
> +    if (vdev->vbasedev.cpr.reused) {
> +        return 0;
> +    }
> +
>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>   
>       vector = &vdev->msi_vectors[nr];
> @@ -2937,6 +2960,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (vdev->vbasedev.cpr.reused) {
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -3004,6 +3032,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (vdev->vbasedev.cpr.reused) {
> +        vdev->req_enabled = true;
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index e93600f..765e334 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -28,6 +28,7 @@ typedef struct VFIODeviceCPR {
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
> +struct VFIOPCIDevice;
>   
>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                           Error **errp);
> @@ -49,6 +50,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>   bool vfio_cpr_ram_discard_register_listener(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                             int nr, int fd);
> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                            int nr);
> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                               int nr);
> +
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>   
>   #endif /* HW_VFIO_VFIO_CPR_H */


