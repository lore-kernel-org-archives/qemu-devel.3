Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF1606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=1sum7s20;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=ixqjrvjK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGjq-0006Kt-Q0; Fri, 23 Oct 2026 10:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjn-0006KB-Nb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGjl-0002Nt-U2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:59:19 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5uxu2349978
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MIaGAwPpeeFNEOhcLTQVF2UVlShAuYZ+2Ejj1IK0D
 aY=; b=1sum7s20Y7C8EcRdSzKQLJJop0Xv40j6Z4yIWzJg+xDccyaR01RDgC9CP
 gq88kPaZqiUw0vLK67YDOAKUyG/TDbGyXjze5CE1RoTZCwBbq8pMIDntvT+3xn5b
 gmRpMY4QnwHfC97GQrhkYQ1eVqxUDoNUGBi0GiRiA+jEDxohhXOTSD+Gfzt17oOd
 iUVCXeibUE/1UuXOfjTO94AMJBQzuyHIXc2LfAtN0SVGpS8qG0gGlY7UVN3QMLON
 u5BYg9NEv2LeL17w1eO1OXDMPWGrx49cxZDDWvSAX8YjBmU4Qv5zrnkKwAiNeSsV
 xtZU4hsvdXYsmlQtJvL3XmZcp3rBQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf972d2s4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwBuJg99rglTW7dHMPjWlzUH27EXyyqlP3//FQu+0qhSYXxfonLC2sKcuWCXgi3bJv3vYgEBgM5VTDIxvr7dn8GqS+sy+3V7OtZZFijlRFjuYcR9lDFdaY3DO2pvWxnS+wTLIHCpLLGRtv1FBmUU7SlwvFeflWwwOp4R1j+P2qVZIW0Mq9ev5g51D82G7yGACjJTmnofneXkhTWvDbnvchS+IBucrwezsoNRQltYyttTlkyxSqQIWP+lRKUYSZTKW5iMKmasxAmXiEO9djXIzY7CA0kzpTjmPN4ur2HjYpOtE6a6cieALCWwdOPfrx7ZCTpTnNXNrr+WHf9Bhkt21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIaGAwPpeeFNEOhcLTQVF2UVlShAuYZ+2Ejj1IK0DaY=;
 b=kDdE83HnV2ukXRJo8o/cCXthmyrsdSJsBxmt7N92qLs+mfcba+Ne3a/DGAsk9uIg6ndfrq+ey7IW1IfgX7GK2UKNQ/2rlNnK3AVhEErgFCgFJw6GxZrIj7pbMGlOmvOy/hA0yIEPO37SQfngTa0rVgB6+yx7XjPlaZuVwQDnTDz1ql+Iv5vcBM/On3Ope3rm7II6UfkHpBm8PytcVMQOTZrFCQxJdl6sWa5EkoOe3uUiPR3hejNFRobwOxpsSdwxsvyHKgDv2YRt7yq4WNGJbO+BY2WUnq4ZnYJFCVyD4mizX4kpoI0z8fxP24GE2obfbfMUjXkjIigHrL5ltzL6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIaGAwPpeeFNEOhcLTQVF2UVlShAuYZ+2Ejj1IK0DaY=;
 b=ixqjrvjKFZav2kHTci+T95DG7a3y/fjNcuX4xpyd4pJz/8b0mgaiQjnqHfM15FQAdhSa1qUsSw2p6JqXave6NW9b3JIqIf0X5i0uI1Uj+B20lx3XvLpokDjMK19FFGDZtT/rS20bBbF4nhPqGfTxEvv5A7N2Y1ZugV6dQHYwNEQetc3AylHNWaEI6u2QwLJwhwYZGqiJ4BipyrTNYG6kPIJBy0RXrMl1wwY1vkcXl1usyeQbxfTIkaw3EM2McRvqPFDyD8ZQAUEr0iKM4CnjNadGKvZ63Z2kiPpk11KeNMvmjta80+BzwY7SzfB3pgHP/tp2cjpeBpelSCbjv6XcJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB323931.namprd02.prod.outlook.com (2603:10b6:5:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 14:59:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:59:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/28] kvm/i8259.c: introduce TYPE_KVM_I8259 device
Date: Fri, 23 Oct 2026 15:58:15 +0100
Message-ID: <20261023145839.34909-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB323931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1368fa-1c57-4b10-3f55-08df31163503
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: x79Mxsks6J4H8eIYyZtAVFg7GpJyM42ByRC8PeYcmjVEps3Mm4bf8/ACAix3/M+ULgaXTp1y6X17GoAsZjZK4UwxzBOP/c13y5ESprcnvxXauRLRLyL/QqgzsA+hMs7reeufnaTyozbFi7IcL6Ncsxz9Dm8vFCcGc/7ych1kMPP92EFP527z80hDJPAIaP5/afSp9B8fvVUWp4Z7nVBMTowZVprQTFnyJj1CBHD3UiCUwnzrwEmhOsh+Gi4tqiyBnCUy20wN1f23D8nbwZGbt+zC5+VcwlxQ0S1yavDH5EupBapfJOnSCuJrVUlB/cuq2wRQFDgwaNLNy/vhrIZe/fj+oykB5ScKS6YpGoQa1+9DPXiOAYEtu5Pdw0RsniitDNOwcvYW9miSjkuUBn2kwkXe3Swe+Eck66QXCa/0xgviQ5C4u5LV5KVWUeelDfF6vEIwN5nlNsm9BZRvJ2NqOVSb8aUJUYlpt3JuA++qQe6EtCSgNDQfp1RtKiGyV6WZRU8duSGahHOrrspsBkVhVpAvAfv+4ia/uFSzPr2GzO33dChASduVDsr4xwz7WBWZtkf6LD/VuMummxT7He2hVxFVdLkOrv8cEOk3FhbsyC0eIXF7A1IFbQtOiSlqXwpuMeQajvyt77cFQHPqEcNQdOsMRpeyMUx9APWznn65xWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6krqhDHx5GZp6YIM0Py5jlW+4WW7ItUjV+Sq8G4ZUIc1bCMXL9egaXSCW9RG?=
 =?us-ascii?Q?wediUcrsmaP6+oEX29MdPpmVplnPh97Q8YUcjl76Jt9u71NsXOj39o18A5qo?=
 =?us-ascii?Q?m+QaTnSpf3pCjJssNyUfZagGFJy6ZLdaHRVVuv863aX8z7xfT858i03ufONO?=
 =?us-ascii?Q?wTTjUlihNj2Ot+l2o2+asLI6MYLJtw4r55KcTDI/Wh+L4KDJ+q0WU4jQuAhA?=
 =?us-ascii?Q?23IFQFzIHhDxQCIMBQczl4GY+/k3y/m7dgy2aCE5UrVqgszH6WVf1hNIzcW2?=
 =?us-ascii?Q?gDFOvEOtypBw3Iaye9S2GtdpnpOoJbh23r5fsQt7OJYLbIAt4bQLprvkY2gu?=
 =?us-ascii?Q?6uBLeWaom7xjfrx4uBLriXiFM9l471GGMNJAfKh4CwSaTAVzMYhLdItIMouo?=
 =?us-ascii?Q?I2OHOCybxpS9CDKU+F34VNoCckE6bS05w4QNOtxNWY6cndiSFDsPcAyX1CNB?=
 =?us-ascii?Q?NtDrWB+pusQaF6je7iSWk9Y1ygjY+zUusoaMiU1rZeeNNcPNwy8NZdu7JOtm?=
 =?us-ascii?Q?faj90llAlLO1oiuWEmYZQoO/K7JxCmdc+icRiBwb1ZOGSup0IODdCZqYCaqz?=
 =?us-ascii?Q?OOBsRMTdA64JNEoRUA0ilP9zqeyqkYgUg+kBkTX3YRLk7WEcrr7CX74zf4hA?=
 =?us-ascii?Q?j2FLt0lGT38aWDmVJv/T6KF7iHESlQ5yvSydnA4WfFWMlyy5ITv6IkjZf96V?=
 =?us-ascii?Q?3w3/hpNpvijDLA7qTx8gMrToC2crFC4XGH/u7zvkEJlL+87HH6IFaZU6VitK?=
 =?us-ascii?Q?R5SFl87inoIhskfgxRUf9Z4/kp8ZiZtGlfG2OoOEIzDzPVvM+fPrmZom7Hf7?=
 =?us-ascii?Q?RekYNY+lLoH0k9MQOsX4k2Klq5AGpGv163AGaIvwuzvynYjTC2onLaNRoYtk?=
 =?us-ascii?Q?J/9nJY8bjbA2E7ETvOWjsUuLJsNch84t77XbyHF4whk2JkeLiyEbyFsvrmw6?=
 =?us-ascii?Q?J6gHUgI5aIeCn9j7wzj9qsHIlR/grlRzodYx6MlaevyD81ygULvll0uVrWzo?=
 =?us-ascii?Q?4oWXBJkeVrWIgALAFk68zciwZKfOLmaW1Q6e88h+nTlBJY+0/ltNyZczg05E?=
 =?us-ascii?Q?x7O1bBBW94C5UefsO7Vu1wYlMKj8OiB/U5+csRByp7RAvBx7GAiktGg4BbUu?=
 =?us-ascii?Q?4fYRi3U1+VLo+CVh0erA6DUegg5+UYjC2Ecr+L+n8RITYqJ3erWnvy3YiD4x?=
 =?us-ascii?Q?M/Wm7ZDC4MvkhqWBpwBw+temvrxqpl7uT/544/nqcpDTQk6qm7UQ1B4IUgA8?=
 =?us-ascii?Q?NBoQ7pQimpqQKCwHRA13XilQmcbGhJHiFyzusFeu9WneXcZzQh4uvbTGAk2z?=
 =?us-ascii?Q?dHw3dCad7ADnHBWREYQpd7/3L3bf7DKywBlw66/rxPKJtJmWDKn47fxLIqg9?=
 =?us-ascii?Q?fAxPUAaXY74fKrilOgmvIGqqIr8CTd1AMenGkY6RWjms/yHoXoOvdIrGyE6J?=
 =?us-ascii?Q?aqiijdlxFK4keo+OIy20JbcNaEI4ln3Sw1cYUiV2VyyE4sVGIW3P0XDF4AbK?=
 =?us-ascii?Q?1VaJNS+5m0onySXSfmhrpiCIX970WJiQLuRhxLFCR2vjU+01/hJKKb0GgUZP?=
 =?us-ascii?Q?/8X0uB+B9OIaxQcQB3qFmloJ13ftnjyJ7IHZ7eCkdyguv0LdKc11jXCGo6GH?=
 =?us-ascii?Q?gQqBOlLHDvccDOcT1ziHhQ0BtZ6OLj1wz6zkstp3uYq+zI/ma4M2Nf4x+mlW?=
 =?us-ascii?Q?JyIf27qKLJF8EnhD+6cpcNpEKsEWRAU/My9laHrfzhGE4ObOJc9qbafpkCnR?=
 =?us-ascii?Q?T5debBFWIfUKvG8KiQ2VSqgSV+mFLyE=3D?=
X-Exchange-RoutingPolicyChecked: iXDE3tW7CtNhSTrG/F8rBMczkTgfFOPha7yKdpnqrN8JjnDxe7nfbLXL44VXVvwE9AOG+FUOAfsohkP6ZLH6yiptl4M9SgkWG2qoOjpmqb60eLbmLnddwN2ufYV9N9CAxB9k9xA/7mBOXC/HuII6f3/K77B8MET/8X3tLJoILG0zlKWNmrkOLd9iA4rU8jsWt8J4+PDnSacLpupSeLfm34cSHEWzYc+TwX8Y6A2B/5b0WqT90wblTy/gSGFoj3hVCeJWOwLJL3LY6ZCBPKRe9VIjUR89V5Qa6miZciaU2uztMyfcJvmIc9zdiAKH6RjS1WEIDh00dZf16oT3CD0W8g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1368fa-1c57-4b10-3f55-08df31163503
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:59:15.9807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgWHfwGTijOmvgYFg9mWV8st3o0Z3em12SHaD3A9S3yZs1z1ei6elJfGWz2gGO8JecRkmT/JyD/a/pV83Cjl2DTW1xLy+TfWa+DpTPbzq98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB323931
X-Authority-Analysis: v=2.4 cv=SpMFe/O0 c=1 sm=1 tr=0 ts=6adb7644 cx=c_pps
 a=BYyRvCY9Lsi29fIAjJxbIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=lKrOaJ4ZLGcPJhkerdAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 96pngvBBoMILGCQAWWNkeN60cE6KmQ5X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX4SMUrsng1k5+
 8Wb7y48qZRiyGkiD2zPtF/xVHTFXNXgQyA6vXraw/NPtjARxQzNal+FgPEsllCqLrQVi1Ju08DL
 m9PxPvdmrNZCZbZcApLB3NA0aKLCm7Y=
X-Proofpoint-ORIG-GUID: 96pngvBBoMILGCQAWWNkeN60cE6KmQ5X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX15Jk2rQDMhd0
 dBxZMxWnKW+ekGVmumcL0JoEnYyB6Ax588yClBOLR3GVtymueo6h1cEmpWABH00EMkoVEqY7P7I
 ioiNSNbynHVt9svXt7W1+pFCWG5dCgB4H0oT041fc1ze+BpFtokvbcI0wkLlAq2EWGRLEs/MWl5
 wpnGCBi7nO+tbZs6UUTn82RcL04DLWx2pbyN258ad2JHzN6VajEkCwkZewfoMCOk9RwUTlFXZrh
 KcMaQ4XK811nZABcGOL9Q+1IPR2JthmuMBuQzh9l/wp6jGO1hceLvV6Zm0lL11hZKVkY0+3rOda
 vSW37mQ5X+3OQTIKulFpzDZ4tG6K/yBnuDqtOeZH/igDl83vWwUUWCtzjLTCAV8M6nX3rKYLgI0
 GeKbO4gXl7O1H+VGMhw17I++1HLuHQMzxu4nvcRwoobYJbNPiiU3LfZKMM8QCWZNSm3r/DU6jUn
 ioMmHi+kpqZZD+LTLpQ==
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

This device represents a single KVM 8259 PIC and its associated class and
ensures that we can safely embed the device within a container device.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-10-mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 85176dcf80..8ae5dd39b5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,9 +20,11 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMI8259Class KVMI8259Class;
-DECLARE_CLASS_CHECKERS(KVMI8259Class, KVM_I8259,
-                       TYPE_KVM_I8259)
+OBJECT_DECLARE_TYPE(KVMI8259State, KVMI8259Class, KVM_I8259)
+
+struct KVMI8259State {
+    I8259CommonState parent_obj;
+};
 
 /**
  * KVMI8259Class:
@@ -154,7 +156,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(I8259CommonState),
+    .instance_size = sizeof(KVMI8259State),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMI8259Class),
 };
-- 
2.43.0


