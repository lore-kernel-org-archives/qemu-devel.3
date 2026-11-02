Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B4606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=HspxBZga;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=oHP8WfBR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsNG-0003H6-V2; Mon, 02 Nov 2026 08:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xNsIJ-0001ey-6w; Mon, 02 Nov 2026 08:41:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhisek.panda1@nutanix.com>)
 id 1xNsIG-0002lm-Is; Mon, 02 Nov 2026 08:41:50 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DAS2p1213991; Mon, 2 Nov 2026 05:41:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Hoh9viFBk2Ibg
 Y5MX1fLKI84371olPoLKR0xjzMYKME=; b=HspxBZga622sQyf4nl7dTNiRbJ3CN
 9STLFoE7+AXfJNe1EHezTpHgDR8SY/DM7nvfRNk95qbsrx6Dad4Dfmjq6HzA/5D9
 hhUX0li+ZJsn4L2js0miB5HK/UxPiVL7ElEfNxRFRTzODYu2Yz1mvDuBGkTfNZmJ
 hMRXTA3g09f6bGKB49MH6AoAo+k6dFdweO+cjuWmv2X2MJDM+0SFqEDCV+4XCYYq
 sCC0OOv7/rJb9vULCDLqecW3PRKvBJzi7YF3v/uYuI7a65pml+B97UZyh0wpRYtg
 5P4OY/HnOTIY+79Yq+rzrmz7Y3FWz0lbQPmTzACG9tx/7oTdVFFC9m9KA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020128.outbound.protection.outlook.com [52.101.46.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hnfvubjta-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 05:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnqeXXHwEP3pKyv1U3vNzSDGH5seE5IgSz6nkK1rwvQy6L1rrbUqt5LPemDaeTCQY9utgtC01UlWejEYG4G57P+1MCYjHwwlfgQPqK/fTyY6txxgDU0UJ05FF1r6mOwhGLslF4G62Y71vkk541S1cRJGKh8lM8Q7Zpk61HLIP4MkgG+IcvMYAZAJdMz3cHIymdvP7hh03hUFMCMiu8RxyhTxC+ITiNUpAkmgX9jtAKMt9GXCrEM8uFPVuyL1yM523ZX3twT7UQT6zKDTFY5kN1woZeYbB+jT8BiHXlQNMUg6H45SU91EgQj8iu8Tl15Yxzqh9QpmX5BEzICz7Z8xPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hoh9viFBk2IbgY5MX1fLKI84371olPoLKR0xjzMYKME=;
 b=ZZwssO4XO2+yBevlvspJqU0ct6uFVRXU0f+oCtPStqWiIV3fiEVNTsGeEqvVUjsTVFkVBugmJcgQAwl/NIiVmeeNfiuMCoUXyuLkZuKtEFe2e9WKdmVdJ1usn8A78PhfSYfGn64ndOzVMr9Uq9sStn0f0yICGXrS76dMDz06KPzK5kMXT86ly07Bbcxr8b35Vv9aIJjkRFbm6QnFHKdVfDz2/q3t7WmsckJHyu/TqYA8HkX2NLF9T1wOpm7Rip1FzUkQIWegfoT8I0jH70cfwTjz7/5U4XKq5rqNSrrS3QCODkwdBaEtxlCFARGKVVf4QzZYvsFlVULEGQE3D3im1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hoh9viFBk2IbgY5MX1fLKI84371olPoLKR0xjzMYKME=;
 b=oHP8WfBRLxeXFQwRqpmHKdK2Ey5jUJYZ0mc2RTOCeH1UMsiSoeBlTw3kEyrlb+egdI2O+CNGlW/qfIvp5qRzryY1AZ7tTPClTTjSV/TxdZailk+qOnO8kE7OieGhhSET0U2heRzo/ejDEq55+7mCpuhUKUhnwArcAeE85Ku6i20iVsfVScidzoU93QddSd3w1kQRxqO8p9EdzTjc/mjygrrHTuajOM26V7y/bAs3BGJp5ox12TYKI/EtpsyqE72R2ZCN3JIENViaZV4IAyaLaF3sDpTh+tiI7kjmdMZ4oMAJso35xHoK/AlYQlFW+1ckONyV3Ks/Pp/ENF2brds8dA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BN7PR02MB5329.namprd02.prod.outlook.com (2603:10b6:408:29::15)
 by PH7PR02MB10040.namprd02.prod.outlook.com (2603:10b6:510:2eb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:41:22 +0000
Received: from BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715]) by BN7PR02MB5329.namprd02.prod.outlook.com
 ([fe80::a3e:7534:76c8:6715%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:41:22 +0000
From: Abhisek Panda <abhisek.panda1@nutanix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@openvz.org,
 jsnow@redhat.com
Cc: Abhisek Panda <abhisek.panda1@nutanix.com>,
 andychiu <andychiu@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] ahci: Check Bus Master before starting DMA/FIS engines
Date: Mon,  2 Nov 2026 13:41:15 +0000
Message-ID: <20261102134115.282413-1-abhisek.panda1@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To BN7PR02MB5329.namprd02.prod.outlook.com
 (2603:10b6:408:29::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR02MB5329:EE_|PH7PR02MB10040:EE_
X-MS-Office365-Filtering-Correlation-Id: aa86f172-36df-4aed-3e3a-08df38e6fb98
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: GiZnmosTlC0z2ZPpqlH8TQdHoU5h3yj3QFvFp+fdUzPVcPKIuMX2TvQ4G2bZtW5iFtL6GWsh8BVbMh1OBawN92jK+Uqriu/udUVfGsj4T9EhTmV+0UjgJrH5b+lUAuK34vrxkF0vuH6l+9ejY6lrl0lNYZ7W6ciWy7scLfLO/9esyC1gr1HlrRqig0ye7jVgXXOxcai3PxglEBcHIiPlYeDEAICQ55vY74lQ+x/m8Ucy84aywdxiOzRYpXy8TToabXgYJSqJBlLuNx0V8xDA4hGAx1zLIzsRaF/Y8tRnyDTGP9C/+YXYpR2yj+rf3vf70BZNqlY5EKVyU7w1xF379fpIYcZyqm+ncFOjizdUk3LiJKRc6erDkCyKXEJXGy1aiW0v/MLgINcH+hvd0D2DnLxpQvZad2Aivqqpiv20ZuormdKr9na2zaQdNVfV8Fp6lBqrWXdXKBN5E9VvJQ3wIpoP+Z48vB+fyb8QCCf8rsqFc7aPP9aCNkvsc5y8EvCziZPtHvivwVADVYdjwunufI5+FEKtIbl3MZQnQg10JRMUa5t8gg/wTDG6Tq6Cc3tjXcM+HDXUIo+4iVcZNnzpgxuwPIqfXq7ZiowGgtriEVHF2nQ15KJJM+Y3UXIBjoKb3Nbs9Zwj1ikMvWwmIHDld0qUI/asPTXQt7vfeLUHmWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR02MB5329.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJUZXBFbFg3cG9KR2hldnZJS0ZoWTRXT2NPVnEzYklXZFVxdWZ6TjZCbmRm?=
 =?utf-8?B?Q3hvak9jUnp1OVI4SHQ2ejdJR1pNWWZZMWhvVjZWOERILzE0RmhWcTVXWjlM?=
 =?utf-8?B?RUZFZ1E2dXFadWR0S3JEVEFkM1ZNZ3NOZUs1QWVhTzRjdUtTODFJQ3NUYnZh?=
 =?utf-8?B?Nk1QYVc5WE9uMmNYbGZ5Wjl1MUdaUnJ3c01HeGhOc2NQb3JBYlYrOGhZL25R?=
 =?utf-8?B?Y0ZTTk9UVGVPbVBQd09UOXQzOVd1M0dEQnEyTzVObUo3S0hzNGhkclptMVNM?=
 =?utf-8?B?UDhnQUY2SXphT29Hb3JNdDNWKzBQV0E5SWtEamJGVzd6TThiUG1CV29ac3F1?=
 =?utf-8?B?bnVaZ0s4ZXlkVkJzY3hxZ3Y3S3JlVytSTFpaanpUVGVMVFVCVkhQR2Z3Z0JI?=
 =?utf-8?B?ZXg2V1dialJzblVXc1laNXRDYkcyWUM1TkJnQnhMZ0NjNHZvSVQ2bjE5cHVx?=
 =?utf-8?B?VkxwTnRWSzArTWlvUVJRRDA2NG14T0FBZTNCYmFrWGFLV0NDenI0ZEwxWVU1?=
 =?utf-8?B?dUhrRVFQVVJLY2NxQWFkQXpxaC9VZEZLNDBiV2xlQWZaRUhOMFRTS29jcWRk?=
 =?utf-8?B?QXNNQ2RYQWI1aVJ2akpRbDJ6QUxGOVVhOVMrZjNFYXprRFhzWUZzQjcySEQ3?=
 =?utf-8?B?d1RZeTRMKzNRYStqOFBkYmdia2lOY2dVbGgxY2NkZUtScE5HcGg5MkhXV051?=
 =?utf-8?B?bmhyWUNjVjFES1ZVZFdYVk41c1pQd1hJMVg4RXBnVkdTc2pKNzRpWTN6Wld2?=
 =?utf-8?B?VDVZazhBeUNNYXhPTnVlVUJrcndUR0FLMXk0bGtESVJ5SnBCL1JPbXFnbEVM?=
 =?utf-8?B?WjQzeTBiLzRlYVU5UjJpRlFnRVRBT2VjanpDbVYxakxNNzQyL1NlUzQySFN5?=
 =?utf-8?B?d2dWK3pLT1BwbVFTMDFFaXRnTTZLRGpZRDhRRlV3VWJKRU1LK0dHNCtSaWk2?=
 =?utf-8?B?dGtCNjVnL2ZYc0xQRUZyRWUwblBlZnBsbG4zRkE1SUhpdXU1VjBBM1pReW54?=
 =?utf-8?B?K1VBbDdCVG5sbHM3TFZVaDEwT3dxTXlZam1SUkZ3TGI3WkhreUR1bHFvOWxh?=
 =?utf-8?B?Z2d1Vk5reTZOZ3RqTjRBcURadzdZY0tqeHdNWFpWc3pzNFJ3OFFRci9URDlO?=
 =?utf-8?B?MXB2SjN3Ymhpakl5OFA2MElMYm9WQzg0b3RrV3I1dVozMi9DdmxodW5xckVz?=
 =?utf-8?B?dDQxdTZBdmhndVgzeTV2L0MvYVlHRkd3cjZGYXAyYmFJWUczY2ZtckxXbml4?=
 =?utf-8?B?QnFDVERxY0lxNnVZdWE3V1F0YmFNYWFSdWFLakIrMkVnL1Z0QmVWOE9pa09s?=
 =?utf-8?B?NEl6ZXJ0Q2htSnFJT3A0T1hqa1VrbXVzeHFJdTZvcUtmMG5LU1V0cDZoZEJq?=
 =?utf-8?B?WW9Xd2ZLVFFYWjNKVElkd1NMQ1NtTFV2WjZ2T1FVd09EM0RtbXVKdUhBaFBL?=
 =?utf-8?B?eE1xREdSQkFwMnBSaVdFT21XemljcEl0MVppaE1aeGdWNDh4VlBzWW9CUGxH?=
 =?utf-8?B?VFBJSkRzUmVHd3ozKy9QUVowNTJYbU5ROWhDd3plNW0yRWdTcGZqcFIrMEZq?=
 =?utf-8?B?VmIvdU1KYitrbTA2Q0FpbkFOZkdYbTN5RTE2TG1GWWZjOTVBV01LQUZMRFQx?=
 =?utf-8?B?OGpFYTJZYkJkRVZaZExFbEQ0eTZqNEVXOWwwNVovaEpYQ2RvdXkxUmxWWUtG?=
 =?utf-8?B?UWpVTEljSkR6Zyt0OGlLNWpTbFNKZDV5NXhjcm5GRVJFTG8rTXlxNzE3VEZT?=
 =?utf-8?B?SWorL1ZJcGpoak0vRCtIOXNsZlp4UjNaZVNUV0VsTGpUaytyT2hNUGE5MjdV?=
 =?utf-8?B?ZS9wd2tNMElzNlg4T0ZFaGx3MWgxS2h1YWM0K1Y4QkZtVFRCWXFZVU5BbmZw?=
 =?utf-8?B?Z2xzcmNrekk4WTVMVXFkZjJuVGxQTHUxenRPVEZRTU5ZYm41dE41RzhBWFBK?=
 =?utf-8?B?QlBFbEMzZkFrNnh1enlZcDFSekphNjdEU2NkV2g4WUVoVXF4SndodjVWZUkx?=
 =?utf-8?B?dDRuZ1p0bi9FSGIweFk5bzFkWlF0UmtlRGdGYldZNmtCeWJQN1BBM09GZjFm?=
 =?utf-8?B?dkJJS3gyc0dESm9UQ2ZPQnlJRGVNZ2cyZFZjTWorMDVJZjI1S1p6a0lWSGFD?=
 =?utf-8?B?eGpYTlNyQi9rbS9rUTQ5TFlxWm81aUMrSDZZL0NrT1NnVkdTYWw2WFVLT2Fv?=
 =?utf-8?B?bGVVYllOWEk4cEU1QTdjWjF3RUl4a0tPOGtUZFAyTHd4UzBkTm5RV1I1STd0?=
 =?utf-8?B?L2FhbVR5RWJJUXRJRmd1dUsxVG1kZXkxNkpvSnZoUW12SWpqMHV6ZzgvbVlH?=
 =?utf-8?B?bVRDNmpJWVFDckZDRGd6THVNNCtJWWZHblk2TFBlRXJuc3VMTk1CRGNnUkdj?=
 =?utf-8?Q?ctdPofAiBT8Bjl0A=3D?=
X-Exchange-RoutingPolicyChecked: JPT/VZa7Wpj7l0RsBT89oTVC+u1W+dfF/v6jczgMH/g8bXSuOXR6teHLDLTF5rhgdgfhviSbJcH3RDqU0FNiOcoHs904eFthfkb76VXCEjEo4Y0IWSS7oDiq8D5wbdpOLa09R2jQwrdC+km0ClYNQIPQQXf+YBnJJMlwRa4X0KIdaHZVqH2cvHOlAFhiWPdUP6tz0GLJnmlZCMexOUHhWUELPyFpbvWc8LcRaqAj5hjm7/JctR7AtOipu9aEoOcVh04lO5XVpfjL0TNktQIniDLFa3XXUpD6l9l/fuAsypUcoO/rFWc9StOBsKN0MJ2BJHt5MgKXXc1VmUDy4F3AEw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa86f172-36df-4aed-3e3a-08df38e6fb98
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB5329.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:41:22.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64eDCbKL1bH0VrPW7Nxlv1QcbIcRkowNjfYc19TBRQLWhXQCDTFKHgSEpvzeCry+SMp1IqrIS4J4JsSnBseZUugR4OZXUMfxAlpWXC4Q8KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10040
X-Proofpoint-ORIG-GUID: PZnlxt2OYe2G8B757bPVZPOa4NhrOBXK
X-Proofpoint-GUID: PZnlxt2OYe2G8B757bPVZPOa4NhrOBXK
X-Authority-Analysis: v=2.4 cv=EIaTQFZC c=1 sm=1 tr=0 ts=6ae89305 cx=c_pps
 a=gFm19s7yh3VV2LjzJhowOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=mDV3o1hIAAAA:8 a=LM7KSAFEAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=P63-nUMtiSz9dlS2xwQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX9doWlY82F1Qm
 CqHutiZO1PE93lmB3w6IN/hRAybvJ7OKZ0LB6abODR6D1DGL9bQyh4yN0ZidfUACY8Kz79d9LIE
 sy7dBGkQfyvkFbvbzQkM7dJ193jOw6Hg9W1wQ+NSSD9ru/ZnM9mEHOYx+Lm9TcOh4CsfT26T4zO
 uUhGMdy10CXQpR93ZLEaQnLs+Ye95ym+IceNygiUe+9wHmibpmu5s8aap5kkL2dFXdAjmh7412M
 D+BgKf3HPWJgOrY70Cj2loPiviafVqOPK+bJ0754jin6B6Vkb4mpQ7IImrcOYBhzNgKB2VrZafg
 iwiPQR5+dDdCyBAbdIPM/ix9TwegzMeOkjPLZbXt6KF6Z2bHOL19/Nwtcif5/xBclLtjuD/hjq8
 AHlsQyDoN9ES2FZg6JqCCTIqg885iG90Vzi2/H2ybdbzbLIsb6HmKqrTO+Fd/CBxwXCL2TCqov6
 f8RwWXnqFvg/pGKWnQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX2I7MccLtevyw
 DAhnXgEj+jmFr6OnHlQe/iBVhQIT7GlI+4xriN9XDf49NnHuxPrxAi6g+N28JBJr+xN20bbvIfx
 GsoPq8/2jcxC2zvab6rCKhaNN4lh1Ps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=abhisek.panda1@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:46:37 -0500
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a Windows guest puts an idle SATA drive into standby, it disables
PCI bus mastering on the AHCI controller but fails to clear the port
engine bits in the port command register. During post-migration
handling, QEMU=E2=80=99s ahci_state_post_load function checks only these po=
rt
engine bits to determine whether to start the engines and map the FIS
receive buffer (PxFB) and Command List buffer (PxCLB). Because PCI bus
mastering is disabled, DMA access to guest memory is blocked.
Consequently, the memory mapping requests fail or incorrectly route
through bounce buffers instead of direct guest memory, causing the
destination QEMU process to abort the migration.

Starting DMA/FIS engines when bus mastering is disabled might lead to
buffer mapping failures or improper bounce buffer allocations. Do not
start the engines in the aforementioned scenario. When the guest
re-enables bus mastering to access an idle drive, it should reset the
port engine, safely allocating the buffers and starting the engines.

Reported-by: andychiu <andychiu@synology.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: John Snow <jsnow@redhat.com>
Link: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01544.html
Signed-off-by: Abhisek Panda <abhisek.panda1@nutanix.com>
---
 hw/ide/ahci.c         | 17 ++++++++++++++---
 hw/ide/ich.c          |  8 ++++++++
 include/hw/ide/ahci.h |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 86f6297dc9..5f842eff13 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -172,6 +172,11 @@ static uint32_t ahci_port_read(AHCIState *s, int port,=
 int offset)
     return val;
 }
=20
+static inline int ahci_bus_master_enabled(AHCIState *s)
+{
+    return !s->bus_master_enabled || s->bus_master_enabled(s);
+}
+
 static void ahci_check_irq(AHCIState *s)
 {
     int i;
@@ -1625,6 +1630,8 @@ static const IDEDMAOps ahci_dma_ops =3D {
=20
 void ahci_init(AHCIState *s, DeviceState *qdev)
 {
+    s->bus_master_enabled =3D NULL;
+
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for no=
w */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
                           "ahci", AHCI_MEM_BAR_SIZE);
@@ -1792,10 +1799,14 @@ static int ahci_state_post_load(void *opaque, int v=
ersion_id)
             return -1;
         }
=20
-        /* After a migrate, the DMA/FIS engines are "off" and
-         * need to be conditionally restarted */
+        /*
+         * After a migrate, the DMA/FIS engines are "off" and need to be
+         * conditionally restarted. If PCI bus mastering is disabled, leav=
e
+         * the engines stopped because DMA is inactive.
+         */
         pr->cmd &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
-        if (ahci_cond_start_engines(ad) !=3D 0) {
+        if (ahci_bus_master_enabled(s) &&
+            ahci_cond_start_engines(ad) !=3D 0) {
             return -1;
         }
=20
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b00987f08d..8e8c2e108d 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -110,6 +110,13 @@ static void pci_ich9_reset(DeviceState *dev)
     ahci_reset(&d->ahci);
 }
=20
+static bool pci_ich9_ahci_bus_master_enabled(AHCIState *s)
+{
+    AHCIPCIState *d =3D container_of(s, AHCIPCIState, ahci);
+
+    return d->parent_obj.is_master;
+}
+
 static void pci_ich9_ahci_init(Object *obj)
 {
     AHCIPCIState *d =3D ICH9_AHCI(obj);
@@ -117,6 +124,7 @@ static void pci_ich9_ahci_init(Object *obj)
     qemu_init_irq_child(obj, "update-irq", &d->irq,
                         pci_ich9_ahci_update_irq, d, 0);
     ahci_init(&d->ahci, DEVICE(obj));
+    d->ahci.bus_master_enabled =3D pci_ich9_ahci_bus_master_enabled;
     d->ahci.irq =3D &d->irq;
 }
=20
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index cd07b87811..434a6457b5 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -46,6 +46,7 @@ typedef struct AHCIState {
     uint32_t ports;
     qemu_irq irq;
     AddressSpace *as;
+    bool (*bus_master_enabled)(struct AHCIState *s);
 } AHCIState;
=20
=20
--=20
2.43.7


