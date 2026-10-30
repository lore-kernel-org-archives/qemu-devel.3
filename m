Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A3606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=U90aNBLv;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=ohTSj4+c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnO1-0000VP-Rt; Fri, 30 Oct 2026 10:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnNl-0000R2-7d
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnNi-0002Ry-Qn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:00 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBFsGa201530; Fri, 30 Oct 2026 07:14:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=/0CkMPowZBris
 4YLUm/janGfnk8Bqs7M2AUfBvtWv34=; b=U90aNBLvBWoMvOgn3l9NU4ZY9VCmS
 8poTrG7nl5EvHCXDPi3xnMuBk9J4bcbGHFAwB9Gh7DGsaT6dUIrOa68R4rvvQ6M9
 PS4Rs+Ogj9tyhdpaMQ8203gWAUa+XuhUhpHDqDRkDJObFuthQ0SxBIU5j34IYviR
 lqBy54i4uedl/KW9dskCNbtMVQMf3OeDfyRkr6rcwkH8N9aFgAOUCWKepiQtin+8
 Qv7VetWMLbGyswCBI6IJJkPKvPMEehDLS9Ge9SQSwK9T7G+giDlSDoMNmThXsh63
 jFi6u7L1612Sy8YqO+Rp1t3/iCWqOJru5XWVhT8DaVdBib2zSWlNpG/Dg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020077.outbound.protection.outlook.com
 [40.93.198.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hmc2mt48r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 07:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtnCK0HJs4JJ0phX6HlXfyXp067TQ8z+r5YiG2RIDigx8LhvK9DGlv5GYeCmt0CijpcaLIXdHQRiS1yiVc7FnPTaJkMpg7ExS7lLvAcuZKt1lN9qC0JxZkZ6e9j7CtO+9sLG/wBizuctkQyHeWQyGI2lvsIW7YHImsycWhFdUspM3kWB6COmttd51XtxEMf2iwxIhngvPVBn3vuV5nRaPnoz7d3PkvQXWN7bzkAO6mipOCWWkunPP3FhFbsKQAJ/6urDSc5sAHVBRx34WJYIPIXWy5XmymjcI3YdE+3a+jlB9Ceao6IsmWGPkFrT5Jwh1vlniVMezla1M8MKMf7vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0CkMPowZBris4YLUm/janGfnk8Bqs7M2AUfBvtWv34=;
 b=x3IIkruyEIwODQjra28FIb60V+c0qhi3Aefw+1YR49Q3yo5dCnVDQ1LINHORFeQvhMXT5PY73L9MBFkJDtDUoKC+8w2EVhTgib1AtxLrDDUcR/0M0iGPLGZ/m7hilNaW3dq9wJRQbM9BzokBXQxUukXJoK/MpDNE2pPwJb/bjF1No2QLapgRIIjWSjYPUJKZh4+C4ZZaYpJ5qijrzs8zgoLofTDjyA18Dbeg+NVI4u0yBFfutxvh6CZwWnPTlUB7clKaGNhdYtc45xOySdbzSvIK6xgjHeTYz7OS6HzVotQhfLcr8ATkElo37obpMHBOjQq93gPI9gegoTwxyaYxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0CkMPowZBris4YLUm/janGfnk8Bqs7M2AUfBvtWv34=;
 b=ohTSj4+cUnSnbkcOwcqetqStlxJcnXd1eYHOp2UGuiaM4Qifc/H8vuJtmCsvmpU3n/fDvbDyswWfhUV4lBpkwBIev+V1K7f+uR3+lw2bpxiGLkSQ3iyEuObEzJrKbH+hXEwmIiW5oge64AUD8FFcFLxc3aqxPgcSevEeo8bha+VFFsbV7fqYIRmTspXdrAAKIgLVpxLMDnbkCbWqoKkEiYFnm5J2Xnvi+AejM8wd4vhJafesU2/ioxu3QkaRV8hiUjFmeF9LUAwdIOVcmEMNRaS33YdD+tgGVUHdSR3zV1B3+Tj+S1dXtdczuXOfJH3WPef/vaT+mt6WszTvMoc9LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by CH3PR02MB9870.namprd02.prod.outlook.com
 (2603:10b6:610:175::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:14:49 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:14:49 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 0/4] Add clipboard availability notification to VNC
Date: Fri, 30 Oct 2026 15:14:38 +0100
Message-ID: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:803:14::45) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|CH3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b737e7-4c06-427e-4c71-08df3690289e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HU9VSyoBb+qlzrMnd4fTNu7p6m3uvP5mS+rNjHr1sh/89x/PP6tXWHOCIADmK8KCYQhwfJ0z9rQtpXZoTMokHF5ejJoG3v+YoA9ZMiTEVytDOLuA3PPFQJWVjS9E7QSSH0x3V0esEgBh4H4KPT/wLE+Tfl4Jy4mTb4YX1wh6aUFcgbQ2LDXLkBrF3dM3Ccnm8mVx94uTf8BpQdwHYu+yuHpJpf/W6bGpImtw6CpEJFz8k34urjd0I1nF+CJBbboP2ru9LhLW1xVeaLsbexbF+6GFxyYvZDZZrH1FYeEV1ClgOGc6grAMcZumFsf4MsWK9oxD1wqXZQhVRUAk1x9s6c7Hkv95O/EgM5JBQQEwX7JXm1DLp2ahoDfDxdXQQq4IP9BTigVMem9dEL+lVjnLONkjM0DoI20IHGvXw1ARXaCj4EzFytesxZxNTXhkSfIWqyDNhTi6J9BzhEDR1oA57L/2xshRCSyhIRSJfcycrOnyl+jbL1XSfI7UZJaAq5SWWj/fnJVSn55ZbwGntOv8D3rRwEFIi60Du/InAWTgP7nJQu4TapHZsKPfCfyIPXQG3gByfO9QYlSDy2WKq4V980QD7tLHYKgQrNtm6pxkFBkVuc4OjG2L4cRmKGCusL/8BJLohO4Xt9DhfcAbPK5OJSFHiuI3+E1K9BuhL5u7bso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkMrRWhabDRJQTF5MzlxSXpoRmZwSEY1K0tEVnRyUStxaWFYanFjQlJtV2JY?=
 =?utf-8?B?MllOTnNxR3hwRnNHYTZMMGErUkQ2Wk9IOUFUK1N0dXhiV0ZjcDNmWDNUVFpi?=
 =?utf-8?B?N1VzWmJQUXVoWDV3Ym1NYjkrd3JqZ1c4Sk9Oa29kbEhkNzgvU1NmcUJrVEJy?=
 =?utf-8?B?azRraG1KNmtZZE04Z01kWVRwYzlHUlUyak5IT3NKdEdmM2xBVytmbWdTdU5w?=
 =?utf-8?B?bzIwRmhVL2dyZWpJVXBLaStYdzdWam5vaVh1UGFIcTFwWi9peWJjYS9nOGt4?=
 =?utf-8?B?Y3Y4UFdCSFRwaUNIMTNhWlQ3ZEl2QlArbERaZ0pxaVYySzFiTlRuQjhvYVVx?=
 =?utf-8?B?WisvLzV5eC9OMTAzR2NvakxKNldBVmdSaENKSytlSytxT1VSNFJMbUdXMDA1?=
 =?utf-8?B?ZnlsTUtrK1ZFL0FwKzg5YkxFMjFDUzJ5RzZtc2JTeVFZYXZEVDFlUmo3aUdz?=
 =?utf-8?B?OUF0ZkJ0WE9wTXF6dGFsaytlU2NQZzNtRE5ENHZOWDdzOXlGakhKaGczUW1H?=
 =?utf-8?B?Q1lCV1RxTTdOZ3BNdUdDcDNiQ1JnQnc2SUc2SERUL0ZUU21Kbkdod1NvdDQ4?=
 =?utf-8?B?TERoOTQ3UVVrZVppRjZvUENnV0JXTlAyV3U4VUptYkxHNVJNMnV4Ti9nYUFD?=
 =?utf-8?B?V1hyaTZaMUdxc1BrQm1BWm5OWjhRMlovYVNKc3R4c1JKSjl0cGpBb0lpbEh4?=
 =?utf-8?B?VWZ6RXE3SGFBQ0tGV2FZM0ZVbVFZTVRLOHFlVG5RMFRTazdhSEJRWDJ4K2VQ?=
 =?utf-8?B?dzREWU9XczBuazErZFlXZDl3YnlQNHppVUcxZE91ekZjYlU3YzdYNmc3TWVm?=
 =?utf-8?B?WTQwbmV6VlY4eEoxUnB2QWlQTVoxZ0ZlWFZmZ3A5aEZ1UDlrUW5zM3phaUxh?=
 =?utf-8?B?UzFna0Nqb2NEMkpuanNGODBmQjVkOXpTTXNLYi9ORzZhVXlLZ2xYNkRzcnNs?=
 =?utf-8?B?dE1tR2ZmYW94RE03T2V2N0hCL1l4aEcvZ004SEtIMGdPOENZK3VWK0RtaG50?=
 =?utf-8?B?ZVduSGJUUFZNbzdwL2RsZlpFeUVSTlo3YmFhYUNkNkR6YUtxdHFwT01lSTRV?=
 =?utf-8?B?QWcwWGVZMTM1bHNzODRtdFBmSVZ6YlM1MTNvWTZEUGd1dWJkZWMzbUhTUU1F?=
 =?utf-8?B?a3hzL0s4VUx3MzRXN0dBaW9tcFROazdnT0RXaUEzUmxjcU9wQ1N6NVZaRk15?=
 =?utf-8?B?RnZncmN2U0JMd2dDNDViNExXbjE3cnpqSzNMV2ZVZS8wQ0pwRDAyOUNld3hx?=
 =?utf-8?B?MnVJM2lPbFhDajI1cmRSTzNIQmU5QXBWOFVPdVEvWm02bENrL3dDL2hIdUcx?=
 =?utf-8?B?cWp6cTBXTmFiLzJjRWhKTXlsMk1jdE1hNUJDeHNxdkN1Z2hQZTAwKzMyZUQz?=
 =?utf-8?B?ZkRqYW9vMXU5YTlVT1lqdUcyNnpqVVFuUmtWTFBka0xVajZsZ3c1anBrTFVz?=
 =?utf-8?B?NThvNzI1aFZFWTdibUMrdjQ4OG8rWjFjWFhubDFIZWVWbWo1eHRTRHN2RUJG?=
 =?utf-8?B?S0xkdWVCa3hkYjZzQmZTZkFiUEw3K2xaSUFFOFNiY2xEZTJFQlZDUnpCZHVv?=
 =?utf-8?B?Y0h0Q01rdGdsWFFSOWxWR0Yya0VlQi9sLytneDEwOTJKWjBSbGV4QnhsaXBx?=
 =?utf-8?B?UmtxZmthN0NVaEFIOE1MZ1h3ZHdSUjk5eGJjK2ZkcGJaeVp1azJrUllwTnFQ?=
 =?utf-8?B?YXM2K2NhaGxBOTNUS3JwTmhiSWlkMENZc3Y0czJndDA5NGRFTTF6OHQ1S3dl?=
 =?utf-8?B?QW52a3RhMHRnL0NiMHVMNklybHFnWnI2UnhWTmVzRTNaSkVRbmdwR0NLcGhC?=
 =?utf-8?B?ZGNJcGE2SWdmUW94M2NPNlowM0ExVzB1ZUtwTTdtY0doQlYzTHJyajVrM1dO?=
 =?utf-8?B?RW1wdjB1R1IvS0NHUHZpTTl0QnpaeUpmU2dTY1lEY3pmR1ptRFU2TWJXL2Nq?=
 =?utf-8?B?OEdsVW9WNEIyNTdJeDJVM2taQytYa2VYbXRzbDJaV0FGZUtVZzNHMHZNemh5?=
 =?utf-8?B?MjdJZFF2d3lsbmNxTHMrZnA4bU1XMmJUZlRZdER1MS9qUVdCYzA1NDd6UmQ3?=
 =?utf-8?B?d2p4WEI5eitkY0NnQTZlRWY5Mkk4SkZiVW44ME5NbUNWRk8zdjJxcWo5RnQ2?=
 =?utf-8?B?TXdnVk9UcmtKaDU1VEIvd0xwZ2hORGw3SHhqbnNaMm84TFJFa1dGR1dCRkEr?=
 =?utf-8?B?WWY0RTB3QkR4OEU4c3d5cTFFNGc0NlhCcUJ4QW1Ybnl1WlVtVUxoc1R1Z3c2?=
 =?utf-8?B?dWtsQzhGTXpIU3lNTjlZT3FZRG13Y2o5MmFjWG5CN01qNTNxMGJveUg0Tmpz?=
 =?utf-8?B?b3BYOE4rNXlMKzN4U0tMWW9BZXhDUnBoL2VuVE5VZXRZR1hxWVlYQT09?=
X-Exchange-RoutingPolicyChecked: KEdslcLnOYQ6PH8p8xRIxe1G3lPtz9sfTzO0h/MpsI+20e3hHrpl4GN5LDES8Nf41oFI8CDk0yhQE0+vLicgjLiiAv+TsOuKR+r43uPOc8F9YE5guwbbYHr8lm0Mg889C1DvpWIaFdjKAqjpeABb4dKJPD+jN5iORIQONUhefew5IYs9ZnvpUCifWdVgI/xRrlWqW2YSdNFZHVePphFpV88Xn++UBFTKbS99j4U981WxyAS6l8YeZ6bB+LV/JXq8RVg48B3K85iYhNKuGjcXhfxDIUWU3tIl8ndVLW96IMuvBdxFGd+J1GamW7/4z/8P1foCo16Mivogcjpa1gDsFg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b737e7-4c06-427e-4c71-08df3690289e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:14:49.5842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBRRJbmCru1t1pdzO48tV2FgF6DEG8yAq9nBX2itETH9kpiXePBJxBbHDAAg4L/StW81c35K1RZzwEEo7ieBsLDS3iIlahgzldLcREkCPH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9870
X-Proofpoint-ORIG-GUID: krO87Z86Q7tZyWu3TGGwv2pNwBuFy61G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXxUDxWsmN+9ga
 ZO/hGxoWWF5QrNMcicATBlgTPRgo92Ja5kqHhpIOnY8OL6crqRA+bx8kT5OJpBybNJdJ/xEGlIK
 TLuQt/hEYCO2OcA5BzZ22x6YraoLZBa6OA5Yx7lQP9DFrZpJe7GRkZ/XnpHY2bSYAYrBEHNwdVd
 hUshRKrYePxDwN0QvfKtlwVDtgTUhgEl024OulmEv/dUJvC1I7PleP5xjsH3l58H17hJNgydUPP
 52rz0gqDct9fhvt3H+7xv6GZ+3zgsfvss7S77bLCwIS0M+Z1IyRZsz89dZrg1Jdf64qDpFjoRrg
 ZFxvnLK31wZxGqE2C468Fz5I9bUZCkcb/6uyC7hbHbzjX46b7bpE64jnC9pSgKAw6BXyw1jlUDg
 RHC3R8QLtW6vtUvS7a+6q+iQnTi0HNjgTovFTbQMrVCO82Ti9GWXNvQwo7Hw7xJelstv4nx9wyl
 83vf9uF1YZ7BSJXXOqA==
X-Authority-Analysis: v=2.4 cv=BoYIUoX5 c=1 sm=1 tr=0 ts=6ae4a65d cx=c_pps
 a=JgEvqxQRRezF4iQqG+e9bQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=NEAV23lmAAAA:8 a=58Cu2wI-0xELmuhQAW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX557+yxCqzZEP
 9TR6+vxwAqbqO5r1kjAiVHJTQLM/p2/wjvVdb16DYRrGMeoAUKb+bY1rrKpMLiZvp9AMn5UXpWG
 q2AuStlBJKe8kCjXNVRj4EfJkBLNEXo=
X-Proofpoint-GUID: krO87Z86Q7tZyWu3TGGwv2pNwBuFy61G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, a vnc client has no reliable way of determining if a
guest side clipboard peer is present. Using VNC_ENCODING_CLIPBOARD_EXT
allows the client to try and infer peer presence based on NOTIFY event,
but this only works if the unregistering peer has ownership over the
clipboard, otherwise the loss of peer is silent.

This is solved with the new ClipboardAvailability pseudo-encoding,
which adds a mechanism for explicitly notifying the client of
clipboard availability.

The vnc server will emit a notification in the form of a pseudo-rect
immediately after receiving the pseudo-encoding enabling this feature.
Notification will be repeated when a ClipboardPeer with .guest=true
registers or unregisters.

The commit adding the new vnc feature is preceeded by 3 commits adding the
prerequisite functionality, making it 4 parts in total:

1. Add PEER_UPDATE notification to ui/clipboard and call it on each
    register/unregister.

2. Add *guest* field to ClipboardPeer, which indicates that a peer is
    guest side. Currently it's only set on vdagent's cbpeer.

3. Factor out vnc peer registration into a separate function.
    Currently it's inlined in vnc_server_cut_text_caps.

4. Add the new vnc feature, register the clipboard peer for update
    notifications, emit availability message on set_encodings and
    on peer updates.

Changes from v2:
- Completed the process of adding a new pseudo-encoding into rfbproto.
https://github.com/rfbproto/rfbproto/commit/34f9bb5ec191839683609a7d01552f8e8f16bb22
- Adapted the implementation to reflect latest changes in rfbproto
(new top level pseudo-encoding instead of qemu range, use pseudo-rect
instead of new server msg)
- Prevent qemu-vnc from accepting the new pseudo-encoding, since it
does not implement it.
- Misc fixes.

Lukasz Kornicki (4):
  ui/clipboard: add clipboard peer update notification
  ui/clipboard: keep track of clipboard peer side
  ui/vnc-clipboard: factor out clipboard peer registration
  ui/vnc: notify client of clipboard availability

 include/ui/clipboard.h     | 28 ++++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 tools/qemu-vnc/qemu-vnc.c  |  7 ++++-
 ui/clipboard.c             | 35 +++++++++++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  2 ++
 ui/vdagent.c               |  4 +++
 ui/vnc-clipboard.c         | 52 +++++++++++++++++++++++++++++++++-----
 ui/vnc.c                   |  9 +++++++
 ui/vnc.h                   |  9 +++++++
 12 files changed, 151 insertions(+), 7 deletions(-)

-- 
2.43.0


