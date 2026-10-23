Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=jjH6xHie;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=ASbK330m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlr-00013T-Hd; Fri, 23 Oct 2026 11:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl3-0000Fu-JR
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl0-0002eM-GM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6aFM3758148
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JqyMFoL7Y/LibKh9OFoOz9QXIrFgTUPraw49u8SCA
 sU=; b=jjH6xHieVrRHup0HK27Lno02l1UvcZxdBp2UskLEZ5DikOyZIhwyACPy1
 bQ0DrsvHLjg7h5qeANc7zlzOFXS8DoMWSvr0Tey3tKQ73PdijN4+Fv3jPOvKLfGU
 aLpGK+Qw9kdyJpumO6l2CuvZBpbac9jlfXEdw9dUY5jMcVjMGs8nObnqBexZvvhB
 8nbWovADOO6MpHHpSnqIFMSSe921Jp9BXr9Df/Qof+kHcgYUffcGI5kgS4ma9iW2
 XDs6vaHFehaNhqhU74IjigzB0se9LdkKo7OQykIBl/JnXp4vwPo+uraLCyZ1YnvF
 rXYtc7o8QB/cUp2prNESmzlYCIKiw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022110.outbound.protection.outlook.com
 [40.93.195.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975d00w-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNOWYnUruwDkvCPdFDpHwc5tNpaHq6+TFqZjLifgK9ghwWQR9qOLWejerKtql2XXVysWLThyyWWbJ8A84IbDO4sysOwEkdQbf9vL9O5XB/oN3oummUvpFaBWe3BCcXvq3pS0zq83qupHVTNGyunw7tILcTGQTBEbp0rVRHUBmaGTXiTGjJ6M48N5f/YaGpRNewgTgVCTqIo8dZCv+tnN7uDA/WUzQHPH70AtvB9Y9A82UMXdEGbUqaCSiT6kfDYr/Kd+268P0w0J7ZIWFS+35KS+Pr98b/1WzMc5/fTbn+oRR8I6MKxCG8vYV2tOnWd0HNK0W/sMNSb9yuOmxK71vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqyMFoL7Y/LibKh9OFoOz9QXIrFgTUPraw49u8SCAsU=;
 b=LSqp8EHZi8VqRo0tLga5TyJyk5FddlkEcp8wU4pQL0NOCczCNJwQdP8iW5Vjyxrr5QxoKNTj9uWaVKTLMIbdGEq53gtPM8tosETXF34RXoG/RlFc8b6A+rn1Oqzd1b/yHgmT90FcPbRfO0o+p0xEqjnN8zM50kKYHEm2YKtLeTo+CbywlVlBv5OQPHg2AwYSvbPJIP22B79oMA5VezrCipUJp01LWE9GbgYBRyXsJWlKcnmPuL1xkLFW0B8ZSTESAVb4owH7nzI148VeIetvvFExsSJg4Ro+C0VP3+c412i7FK/bSLsazITgA0oKuQ4JNEtgMp6BxG6NbyCgK3P7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqyMFoL7Y/LibKh9OFoOz9QXIrFgTUPraw49u8SCAsU=;
 b=ASbK330md+V6U9ZSW25QLzdCsPXwpnCA6aJok0DselVmwe/kkPPEf4d6Iwzw/i0Rytm+9g3unWw6gzyv3E9Dlob8PstYjoT6BblDwuSCR9i7emSraa/ZAnVvyG5GHpo+LcTe+oSQHWUaPu3ZzgC2EmyxKkOzrbNC/00HQKFvTpUe1dlAqc01WQ3Cl4hVoDPgt0zaFjMz31KyAfWDmkKDZ0fKF0U212MP0EESd2Dv792LeqlTY1sZC3bs+NMK4s0N6YBuqH0vJaAcRlzaIsy/dLsiUt13sLhZA8KVnAYv50s5iUqN7VokVa701D+Gl2hGqiyweTeFgRHc+lxX0OCDsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/28] xen-hvm.c: rename xen_interrupt_controller_init() to
 xen_i8259_init()
Date: Fri, 23 Oct 2026 15:58:28 +0100
Message-ID: <20261023145839.34909-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 07adb6d7-ed2e-4a6d-129c-08df31165703
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0kLzyaUilUAQmzKCoSAUamBycf3pDT8GVa4W4j+X74DpBr8pdG/2itiudV1Ith2VB/thhclJgBwwSf4SU+DcAjavZITgtcGfAYrOY9sFCA5MQN4dtcBEsm9DRWRWrrlN2krtRQXER5eiK9aBOuTAgVl5EdneOxKEVE/fufBzju3wOhUIcZh9ddks2gQOHWizyIH5YfDU24IEkmTczSM1K9fBetiahBWIhBxwzMbfHTG34kMMw6KvGZWt+jvbZsilKPQqUdCPxNkU7WSSNvDJM3DPQKFV3eSAIH2RtRKOYIdBgDp6m1Srv0csrTOsIWyIL/Yt17vRPqrSDzJx6FJ1VftNk5/Kexn3Z8nQ8LYEhNlSFaADYBOORZPF/aj9cehHWqV61DsWxlg0pYnwkQ/5G+fzBQcK0jk4epcKK+umvb4YiGHXODUdFzV+fAuL/Au9a6dYrq56Fm6kZ/Yjoq8VQxR6x2cgROBsL9mebNnbFByVvsS/actYhlqr3LXit3etEJnZDgWwlK27M1zNWYmhnFZmckqpQmOdxkr2CiICLyNim3omCok4WnfnkIzbqh/eJD6F9D68SoDKiEAEIiShk6ybwSMH8l6MySE9ztokTQN+fBjmPonfQs/9yVUYx29LfUn/Ub9BjWRk9ybpW6e8bmY6cucEFlODFgeIvqthZ2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+i0bH4d/4FdjE5fQNn0+rlVmi8xPvBD1AYted64TWhqwztjpV7+yV7wk1/B?=
 =?us-ascii?Q?klK6dwMFjwmJ6Z69K2U6tEvK4TG9UBWyl9at5PEqgsa73IsU5CSz3277bugT?=
 =?us-ascii?Q?MTBTIyoDokvOW01Ze2L4PanfgB8+vAPoiMPQX3uI8pHVb3og2l8O0Ad0c0pQ?=
 =?us-ascii?Q?V4w9kFnTufFRNbWwKb24VNJOyCEIRi/xnN03oDlw3MEgT/H3P5N9V+81IlB3?=
 =?us-ascii?Q?YJT5rsj4vk8b8G6REwtSSt7pgqZCvmsMKidb1kxkoR7z15imuM2HAYoXLVML?=
 =?us-ascii?Q?YFdUbwXOdQ5P/DWHK6HjfzzX0Wx5zpjCG0KM5Y2J4tovePbk6R+ICOxgScGl?=
 =?us-ascii?Q?8r/sJe8ajCm3xBmS5zD11tUXOqouIif8TDEUwOcJo9CHogT7jAc7z1Hz7J8j?=
 =?us-ascii?Q?mfbYXzJqMTiJ4xl4D072mVNJgNBdtIIFFn8H+EeiiJJvyBVl9ecVbld2JwJs?=
 =?us-ascii?Q?1K9xtmAnjA3UUOdjhUzWY96GZsEdTnylQOt51ERNwS/SEleBfKxSv6UqZGdc?=
 =?us-ascii?Q?Wyr9rKWIt6YdMutJ/du0mq+F+dAbplGzhD/EbbNRd/SX7ONd33UsBg5qwyXr?=
 =?us-ascii?Q?wrAmbifXFLZ1gqkRLtxN3cd3Z9dROo3sOvMTXHV/RITCfJ/x8s+4cWs5yxtG?=
 =?us-ascii?Q?TfzVMPmXyg0fqEgVUGBwxXduPtATi+yhL3N4eh+TpMVNWBV0Wm4JYSvEdB0d?=
 =?us-ascii?Q?m6eMDoaH9nMuAWEDIv1enbZHvC+pAbTnx7iFTlOwwWcfGeKqNEzcaPV4nB1r?=
 =?us-ascii?Q?3Qu5choQ36HgvBvzHgm7PKibLJbPp6RAz065NGJ1y/qm+da5FnrpXH88GN8h?=
 =?us-ascii?Q?LjoM5tXzM8EG3S08wndy10d5HTK7ovcCXGxX3MW5E5SyyqkadEJz1Xy0pl+a?=
 =?us-ascii?Q?9oT7EbJIXPY0XQB4JJi5ItCVGUuhuqJ/xieLSiMh2uDPSc3HIRRrUD/N1mHe?=
 =?us-ascii?Q?IwVsiOY1PQl7V6BpC/4XjA9tDh/PnPDktsezP5uxlDSG9irbb5nTtZ6M7JDK?=
 =?us-ascii?Q?jG9H0l6fVW/lh9D49KbTUzj5TGey73oFLMCSeWPS9rh0ws9gWxZigKWpM4Bo?=
 =?us-ascii?Q?tjxeWxYpy5oVuc3hayPhvxUnaOUD7uC8fflsu4CZkjTXCrD2uiCZzjqI5BRO?=
 =?us-ascii?Q?1XE1HgYOFf1wnMJubqZwjzDVc5zuk+gbYTGKnC/7ELfi9nTaNal1MAUvySAD?=
 =?us-ascii?Q?L5ZgPXNDE7UIgWAaswrtaVaHxt2Di6mfNo22zYrhkeiIIQSuTsIj04C/Ovz4?=
 =?us-ascii?Q?qv40Y8kGV4A3VUpziWBdp8Jm5N/jqeLcipsnHhti9JNvD+RlpCWWW4sMkDzI?=
 =?us-ascii?Q?Hu5w2Ge9umElkQiL+oPjtNX9VfZv1pZ96gH8/FkE77jj+WCkfSuGpm1YI5yH?=
 =?us-ascii?Q?Dh+hcAAY4FdXPHvTyVi2cFiHBveE5T7HvQjSUfhPgZSQnl5c+SZPguf/cjD1?=
 =?us-ascii?Q?RwmuVNxBHRho0pBCbARurDgDIXIZCH7roLl0r6kWgbIuEzngqoElxSeaNKX1?=
 =?us-ascii?Q?vrRM78SZhRiXNag9svv/bJVVWn55ajN4xrwT8s8RtjzioLY+/VuX7sSfjsTb?=
 =?us-ascii?Q?KKURiKz9kQ1EBK2akkLrMq9O9S5SfLZXoO4uZVLuWaCmTI9NnN1qRREsMPPF?=
 =?us-ascii?Q?iPhxIC3ikMgxe3ZIfc6AIAWZe7OD3qU0VirGR1SL2iFqef957Pa+uZolEZ2M?=
 =?us-ascii?Q?T3ZI31g5eYJouzC73j8mRCG4rwWvUPzWHbzdQlOIbeEyytP0GMYGwkXppIPD?=
 =?us-ascii?Q?kH9+8emfkK93oBT/WIfbySyGOaYxhjc=3D?=
X-Exchange-RoutingPolicyChecked: ts4YbrG1HrBtnCN9e+EBcFeAoubERht/h83+k7ZB30diMHvGSQI3UmmZqjmQhsJdkEkvEl6tVdkanpmTYMEfLI3E5eeKLv4I1pp6GDVZoaDofles2GifmmW0/tIwyAjf1v0IQ8Sxv/LM8qxy3Zw1sleUrtmZiWv4Fq9yN4Y6Z4P5oFtcxhYhQrZdp3x0uybqm12QJ3mKAGyQK8XdjyzmR1Su4KZHHYXFpnfXdTE9Q0xcMjyfFCVvafV4g4L+/KMZWb28oB7DwdADbgZwaXYxCc9xdy4MvykyBbRLZUX9ljvnW5I+mkOkYYIUWfLoTthNrn/u7vdTjxMTonP43TJtDQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07adb6d7-ed2e-4a6d-129c-08df31165703
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:13.0043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZDxwHYrvSPNarn/kpBcQgr+J3khm6W0lStNif5aJYEeETCCb3KWBkCyDapnHY1S4H/4uF6sF+y33IMdoCQvaYkEMJHPrj/mnF29cFhpV7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX6SyIETWwx6l8
 T/qAF/EcxyvmC9/P4ceD+T3cYwplTUvWkCuxdkcF7OLSUzkWtWWQ80u2nGc0+Cr1oghOxoxMaNI
 /G0Z9gEZqg4U8oR2egvteV+MtRITSd7n2O8Y+mpL4LCCv7luDWdtB4QTuP/JRfab5yta18MVRtQ
 gwRgO8jceWckXj3MxTaN/jn9HO3O8EKz3SgFDp3at01qZ8TyV6oCNI9VsvAL/2rtFjs9xXlIsVR
 g7P97DUXzYM5PrnlO2pYLKGn0xp/zUb2vrQUJH+ePuEG3e3w4W6JxBFG/+p1n7jxEHi1T1goIMo
 wXO3ii1GHgEQArC0mk5K1pYYaX8lLhxNV20uvQ1DDZ8jAwA69kKC55IEFEfL2MZRK/ErN/1oikH
 bh1tNnTGrFISNAJoBdFxW3Tkf7YYpw==
X-Proofpoint-GUID: ZWZy4Vv8n7E02yl225MqJnBNcfVTF654
X-Proofpoint-ORIG-GUID: ZWZy4Vv8n7E02yl225MqJnBNcfVTF654
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX23oVy3irc/Ks
 BgiZ6nAwbA5odt2LyG5cxOSttriPOuEdeuoqcu9S/UffkNB7/3KW+4+FZLN2m25nTyx5toVoxsK
 +VuXZ2Dz9xTKJJuYsrn8hxcCIApQBdQ=
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7683 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ufYRZG4kn_nPcl-B8swA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This clarifies that the interrupt controller being modelled is an emulated
i8259 implementation, and brings the naming convention in line with the
in-built i8259 and KVM i8259 implementations.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-23-mark.caveayland@nutanix.com>
---
 include/hw/xen/xen.h  | 2 +-
 hw/i386/pc.c          | 2 +-
 hw/i386/xen/xen-hvm.c | 2 +-
 stubs/xen-hw-stub.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e94c6e5a31..ee4ed4f11b 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
-qemu_irq *xen_interrupt_controller_init(void);
+qemu_irq *xen_i8259_init(void);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e3..dbfd55de30 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1167,7 +1167,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
     } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
+        i8259 = xen_i8259_init();
     } else {
         i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3ce082e07..af3a90987c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
     xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return qemu_allocate_irqs(xen_set_irq, NULL, 16);
 }
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..b3e27f0292 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return NULL;
 }
-- 
2.43.0


