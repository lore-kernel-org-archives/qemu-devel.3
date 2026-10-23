Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420BB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=Tblk0luN;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=cgjEM0zk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlU-0000gy-2d; Fri, 23 Oct 2026 11:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl3-0000Fv-Tu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl1-0002eQ-02
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6aFN3758148
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=D8jHRG3N9duxhZx3rePymt+A99mQaitrs4qRK1WBA
 Og=; b=Tblk0luNufswJOs08GrwLHVWFjr72dzxtUymcUS/uMuiTxobxr2Fs4e2U
 Wfc40JAZR/D4fb/cWRvUZYB4wHAZnDi9mphEGC5rU1nkyhcimHl0os0BX/tsb8CJ
 ryAJIwZO2Dzdnm8CC30uX2KbCmYV3DHiELlImOK0bgkDsS3tme1gkt3gGuHae1JZ
 RBtsLoTyYvjDlWYyGFkLR/aMAiIRZAAV/PVL76CKjkVkiBrrHdhJabAdxkt/9vDE
 0Et0z+RBo4rTDi7wURbuO+rRkcr508PYA1l2QPhr3SivRsJSCIdYjyLl3xpqrSYq
 ravZwEIc84B04dN23bXQbg8VcI/qg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022110.outbound.protection.outlook.com
 [40.93.195.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975d00w-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fia5n0fD5Q0CcZlweA7oYr6CuSjuAuT+6MnCHdiLhFm1mpdlj50eIy4SCp9P9zYb0j900JHEVWuyy4MmY6psG7OlTo1IWM4b1hrBrTWA83QYtQ7oK59fjSFy++bsW+W8HIa4v5OzbDrgZb6ofYC3E9WL/HalLgIbrRqUoNiDV1Vc3Du7YIhL7d52/O1dT+p5U3CEL/PAik7zoD4u5nikTfh2B6selmC9ots3uS4HuMYA0NbgMP28of/2ceBZ79N/q7GJMh3ggQoztzhk1nouXKnaiHTUjeUpc6R+z/eO1NBNEJGdPqTWYcMG0joMt1/aT144OCG3Wsg+QoMvkL4qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8jHRG3N9duxhZx3rePymt+A99mQaitrs4qRK1WBAOg=;
 b=nZu9x10oKZvr2FxWvmjjgCflhTwjNaRBHzwMVg4xb/Jtfj6Lgo+Jbf26EoGRHzQs492DwLW3G6RjLmI/Tx4iwIWLshg+H5eHwOVgDA8wP9ryAknvetAkzADas23qdsdsx5OdbSW05J+hwjEMEphtDCiS46nYfyIQ6bP/2Xb8diReuDzxnmYxDy/robkttzmlTNABj+cO363snPZjuVeJBrFmE92EbgEAw6hXmWNSYeortlHRjQCOrWPWA7OK89O+XXxzOY7uI5fyN0g513SVbgjI1AsJj7Pq6XkyJzoq4qvslNA9xkW965aWv/4TKh28+ascQTAjcyUZX7o8Nml8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8jHRG3N9duxhZx3rePymt+A99mQaitrs4qRK1WBAOg=;
 b=cgjEM0zkbT5Sjk+7gAqn7hfA6jQmlVFXoG6ONWw2gbP/9U8yXThslEqd20Kyq99R9Jf13eQM8/FZaUQpXXFoV+h+QRsDIjzkLSZOHrl08gtPS6Pby2kijvZK35g2zKMAlQ1/xyslJkuz4UmGLXOErEcI/vfy2RrismJp8I1DL9Y429bmrNSjQelxaz17Ank+82An9vr1MargDGbYcJX9LSUQ0TIShq5awZAi/6vVs8C5IG+hNxn8rObkmnInP06z/w+rGuVTFLL4QDFPu6emVmlA63t7lDgWOLwkbvXfuoLJdR0mwAQGAv2R4n3I4b+/nsFrtOP6Qa58cy0ZOVbmrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/28] xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
Date: Fri, 23 Oct 2026 15:58:29 +0100
Message-ID: <20261023145839.34909-24-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb40054-fd15-437a-7fd8-08df31165916
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Th7UWzKl3tyB4MWGK2+cBuYkZsK+ewVW7GNrMVyYNdIXhQDjgzk+JzfMTpRLlz2eAIS5OVbD5qClvWV9N3QO2V/X/QjtSmgu76/wXAld475tkoaB7e/2U/6fTWyl4i2QT69m/3aXqSTQeCM+UwyvAfaA88fJJoRn2Mp8w+4Sr2rRhfUkBF1fsnnLIkbeLAF0d4p2pgn8cKiIkhFYW/KdcULqr4BUR65aPZFhiw5csEzNABPrrfrV/yHD86BpM0/+k4EXrJ2HPwvANg3lsX+qL3TCAA9/6vXdP3vclKlFuybOAHIWgMY0Ln3diBt6N/rJllpKEzP9kbtA7duQVF4h4qy9/T5whIpnpHVfOrNUTE+EALCHlIG40N37Bb7der8/UjbM29fENI4lORyh7Dod9IAP0NcELqmzIfPWL2BVgdaRrb04ICcXpYoxc4s2zxZoeRuRFKDZrjcwE6ZroS4Tsfxhkh2qYzKIYapdJNrZ429gGyA1x/S5UzmaLEhQBm1FUZzjdXygJbRrtwbC3Rmkqb3ZinnT63pWhurv6PE3u8bXT94UKhM25gPpk0IvXEs6Qn6chsNRZpH7fwaj4vI6U3dOvnE4DA8Ry0Nprp3/HmElzIIiwIBg3/3qE9mtNqfrQZ+6/ucbwMjQMgdLfB8lh/7WjGI39rF/GV9YNBVlI/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFeNozimX/WapiZrifwjn7SUPt896jrvhXfFGYngByp0osg5hhI98CUaQkoh?=
 =?us-ascii?Q?qClJ/5CVHxgDtqK4GyBO89roltfbt/us510YOkCbUKx0T5iMT68M4Io4ZBhQ?=
 =?us-ascii?Q?v5HE4wG2tlwVzD+LPUF8sA85sfbUIUA/72USaG6pm6E3X9rFy3/W1DFivlla?=
 =?us-ascii?Q?5DZAXvIE1xe/NTMnlmrq0cbT9a1XNOE0WHLGUpTNHJJKdsMHm7ewf0EVGUe3?=
 =?us-ascii?Q?Ho7IFj8qt6FAlsEwUfVJR4wvIASNuNQAes44xtk07+8WLGr8Hufhqv+RDmeu?=
 =?us-ascii?Q?QOvZqDdnNdjcfm7D/MELeF4CuvT4JKVEHuy6quVxFg8xulem9zKnc5D2arHI?=
 =?us-ascii?Q?HyEuBU6W7QCNOmxMq3VAH0ww899vvNCiseCQX99yHEf5ssi4qVMA9ofbJp2S?=
 =?us-ascii?Q?Kq20niiPhODYDP3ek9aQUUu6vjI5xExxWjWuJ/IKcHD/ZpK/PxxvS52dzntC?=
 =?us-ascii?Q?8afSVrU6dJtN6k8VHrCewIDzuVfTIza8gFpXuQtUGOXJ3L6/Weg9J/6nnVxF?=
 =?us-ascii?Q?VLcOn8sxZzHOhyPFNqq91AdtKPBpDQ4djxy18Jvd6YTkVj9meJ9/cBArSwbj?=
 =?us-ascii?Q?jr0zPYcgHWXxTRoapxJjEQ00PGAZJnqAi7BQ3RlP9296bgBIAOWvfnCobt+u?=
 =?us-ascii?Q?n2OvlIUOTC65C+zFW+tCULuIhtIdS69D003LOJ6/0EaZ5E80Vf966r217Dof?=
 =?us-ascii?Q?yCkdJLxNYaEqVygkFGxqlEZHlSeZWd4nrkMoYdKO3rnbzCkQN97AIS/VvM41?=
 =?us-ascii?Q?uCxFP58L6XXnbqoYTQHUFhSK7k27s5mCe5VAP+7pbrV/iqm6FN4VHdE9y+D2?=
 =?us-ascii?Q?wkf9TVWP3Agmo3vNInplWiTZ7zOlosdY95kLW+KxdqJ/ADQ98SBiUb3/nWcN?=
 =?us-ascii?Q?MBzURleaRtN5cANv/ZjGxxktzmFucjIgZQ5jLKzI7LOdpTd3+cA7VWvqIm1D?=
 =?us-ascii?Q?o9h0qY63kzHL2LbShbo9ZyYiNFRv525f4Et0HG46jkVoZ1TUak6OjG8ZgRc+?=
 =?us-ascii?Q?KZC6YLdw861wnQxbJpIsVomCJpGe/9+DzfjSAkraE0HWG4IhF0xryBU78oOZ?=
 =?us-ascii?Q?ZA7Etnm1A8DC3QI+VMfgRRxjQfuIR6b6jN96riRMmFWuxKqMotNnj8c81UVe?=
 =?us-ascii?Q?iHmV1/RviS5TqDdBVteInzkGd5lRWRKXoGxK/JytTV8oWFx2s0/EvsOfKRQy?=
 =?us-ascii?Q?Fgxq3MiLy73DBJhTjiEGnI+PbjNbaf+Z6rIYGhYrz2r4xPXxtnASaOQYrFC6?=
 =?us-ascii?Q?OBtl51yGrGlSqzAEwXwjp4oAp+f9UjDY2u0EsVp752Ck1O7ZAftGVTCilIpw?=
 =?us-ascii?Q?/4DsXb7MoP+W0Z0dan4v0XfS/iDuApdtTemX9VQBOarOD0qKRXrZpIWOQwgw?=
 =?us-ascii?Q?RcDN0IqoAkCT34tUd/y6au3I0Vf3cN2imDzWd7kw1PP2b4ekkKdc3H1h/4AX?=
 =?us-ascii?Q?dRc8OXVcWMKvnX07a7maJGn0yhyAA9XVYyWOeaX2PrJ8EgrlqJyjVgfzFw25?=
 =?us-ascii?Q?+67kG582ZSJVz65XJv9zGKxyV5MwVF2zXzW1OClSXzsUV7iCt2THhSCrmagI?=
 =?us-ascii?Q?UFrJVlkkFn3z+4027dJm7FqBzyD3OuOwHXx055mIKvpnZbFAHGHuedtG2wUu?=
 =?us-ascii?Q?SxpvMedI7p929uDzenbFl8CU2EIKQVOCWliGFaX6pQo6u//vuUP+/BJUY+Io?=
 =?us-ascii?Q?mjk15ZJIgDfThcQnP5bJ033Uks/HOi5u2+73UZGG4/flzWhpINWozJecY3sW?=
 =?us-ascii?Q?eHls3b93KC027mRZyDtqb5LSXMWnWno=3D?=
X-Exchange-RoutingPolicyChecked: AIix4InMFkOaXFzrtvrsiatHkZnjYmXdBiMAP2t9jzZbfNDU9HfkHnDonwfgD/AvV04Gm0k77uXLIhaQxCENFEQKxJLTqyqxiM7mLOfJ29a7vvss7ktDozR3BOuYYM5++T/kHhjWPZQa7DM6esFL49GTTkHbOMSyl/Dhl2ZKm3u7jbRXs/miz2TM7zQY0PRFLi+D9mYPXYiw/BD6hBASnynw31o1+1FCpbZRKSd/OgKmPgOZor0lqDQIysTYw8kcLvMBnG76/0ctr08bBbDwU8kvOphVYdDEQ+oLC+5DX34UPcBI4l6bNPeQHFVPZ88gIvbAhspMfGz2dMzkb8NDNw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb40054-fd15-437a-7fd8-08df31165916
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:16.6383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6ux2fb80ZMy0ATY4i2g3gGthAbGGfj5wDcNQOgg8ZxlXEjLMGvLTtr/WSWJ51CyGql3JX5vfiBx5ATguVIKl9Gr5meqNdBdLAW/kGZs+LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7687 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=bRHUbswDDQXNzLfe2LsA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX0M4nGu68JJ1k
 4nhPONPOAo5q8c58lLBZJqWiusm+Z25mOHfG1dY28qIxEQ7QfanGZi3Jb6U8v4mPAsYH2VPC3tP
 nCap5Ao/xr5L7xdhtofrCkL+kzsQXBpDPC+NFjGwGD3MTmKEq9C2NLU4EmMrTeH0YD+vkqNmxeT
 b1abRD1Nwjc28GYKYWiNHlhVkFRODDflTsEHxCs0AS/vARe0fsbWmzdN3AwIsdBqok9gsvCmOod
 d65AI0A3cz0gc24+DI/pQ7pVnb01IcADDH/j1JiXHdFKjQYnAdO10YTzzR2+TBldxshTL74YKQK
 Nft+kz6TwDwK23THOYFJpkCcnnwkIQ4a7ip0o8YqWs4RucF8bu/rwaBSY0hu7y99GOQVRpkJ7Dg
 QXn9/tYvi0+vHiu0RdzIxwEXQdFM8e3NxEobZIQuJoNMCoJEOfqxeY42Ntq7yBhHQywDGzhiiAi
 AJqDh+s9F1t9SElLAvA==
X-Proofpoint-GUID: hiKzPlC2DdzCPzUpDkSOkZSJ60eqsoDx
X-Proofpoint-ORIG-GUID: hiKzPlC2DdzCPzUpDkSOkZSJ60eqsoDx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX/t8AzmbSMsQB
 p89fftGjfhcwQ4wYY7EbNsYW8tIEwYoBS5GIMaCzzsAmRQL8zqnXbVAj9z8PXIfcCBLKcHA/P/L
 w0X57FCAOBbtNapZujaR5B4/K46AisQ=
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

This device represents the Xen PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-24-mark.caveayland@nutanix.com>
---
 hw/i386/xen/xen-hvm.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index af3a90987c..b2378fe3f0 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #include "hw/core/hw-error.h"
@@ -69,6 +70,12 @@ static unsigned long *dirty_bitmap;
 static Notifier suspend;
 static Notifier wakeup;
 
+#define TYPE_XEN_I8259_PIC "xen-i8259-pic"
+
+DECLARE_OBJ_CHECKERS(DeviceState, DeviceClass, XEN_I8259_PIC,
+                     TYPE_XEN_I8259_PIC)
+
+
 /* Xen specific function for piix pci */
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
@@ -114,9 +121,28 @@ static void xen_set_irq(void *opaque, int irq, int level)
 
 qemu_irq *xen_i8259_init(void)
 {
-    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, 16);
+
+    dev = qdev_new(TYPE_XEN_I8259_PIC);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
+
+    for (i = 0 ; i < 16; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
+static void xen_i8259_pic_init(Object *obj)
+{
+    qdev_init_gpio_in(DEVICE(obj), xen_set_irq, 16);
+}
+
+
 /* Memory Ops */
 
 static void xen_ram_init(PCMachineState *pcms,
@@ -760,3 +786,13 @@ void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
         hw_error("Invalid ioreq type 0x%x\n", req->type);
     }
 }
+
+static const TypeInfo xen_i8259_type_infos[] = {
+    {
+        .name = TYPE_XEN_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .instance_init = xen_i8259_pic_init,
+    },
+};
+
+DEFINE_TYPES(xen_i8259_type_infos)
-- 
2.43.0


