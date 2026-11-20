Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BB606A33D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=TIhWdzDB;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=vPTifXJZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULPw-0000mr-7u; Fri, 20 Nov 2026 05:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULPm-0000dw-Du
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:00:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xULPk-0007sy-0f
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:00:18 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7gCxJ1473788; Fri, 20 Nov 2026 01:59:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ez66g+ISqR/G92WmeFWnK5inhx+7t3q2tJkemHvcD
 3w=; b=TIhWdzDBhPbzfKBX5bso5fsECS+cM7O0TJiGvVchaaGx4ZGha8PLieYnv
 fOFakyAk64F6wj7yHJe7SuDQtLVWUf2uEnz68xWPt3K7lWozLE5YmYZLaUQrr6kZ
 cqssfzd+ntaL2nh+8FyhuptdMY3uxHxBoJCzpTHm4h/bZspaDf1DqACKjB37vxI/
 Ss5INAQ9JLy+R2G6+zKx6/w2bZUmZE6TxBERl5nqJtxqWKloif7iD9fF2HHcB5pJ
 88ZBeqWEfGnHfcNYy+qXZX1WmFIW10PhD8uwndgDuEFzk1SwR5j0dNPB+ne0yxOP
 5nlXwC0ISAoV1Gmv77tiFGbWafNrA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021096.outbound.protection.outlook.com
 [40.93.194.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4j1xjcu428-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 01:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQyg09Oqdg0PMtXksILxhKqS2Hn5sIoAAKyMwn0BxWo52F1E6qd2/6wKXmIsHg6JL8cuqkoQk/jws9Ka8cjOJ2VoCsZc+lidRy1SBa2a/hA4TROsQBRiBkdHgaTBkLk4mdJWnI5rTbqEokaIKIvCs2gTfKKpnnWdFjmAhkjtdOngW+Z7f3hwp1biFA+GR5bSNwXXmwxCWhnxk3ITAiP/tQmEyHRQ1Ac7bkAwz/0ZEYHZkopwJvEs1NtBsYMv8kNIrj14ej36Nb0w9iK/+g/lEOH/yXR6NXjhyUkp0WLeOod+knJr5DGvORJQOFnaLbVeumqfYriv0otBnEDCocTyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez66g+ISqR/G92WmeFWnK5inhx+7t3q2tJkemHvcD3w=;
 b=lw44u2P12tvncKWvaycFtWCmuts2FVWAT7cG/XUecBEzS3GqLicGh020gGJw8LF/0gOlBoAWDMY9OfDz5mxaHKROtOL7I1n2Cl4FF5rUGbXQEBlYXVim/AxOs2ROr36xe+Q0q/aeStcOwoS/Y1MCbB0RrTqvql2hISmzWXqzIZG+cKTq3KBfwR4uqMULhnaPbbFaRyFcjm4EtFvrUfWkwCQjhpsyIC2BQyNNG/MYtjJ5snHbcz07di4Wq1P9U3bakw1Kua6TVrDqFjpCTJJeaLBB8BacltxRZmywUK8+sp+UbitjOx8sn0XdLrT3TiRR2vEDawUg1swRh5MVBoyx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez66g+ISqR/G92WmeFWnK5inhx+7t3q2tJkemHvcD3w=;
 b=vPTifXJZLTUKOUxgc+qSG5Uj0yw1Q7G6xaEo7yIm90pvn9CNmtJHLGO1PyWpcStbtb3iLnSb9TzyGTsREOHt/zb0HAI04F47YxMknCcEi2lP4TlC4IKkuQKKRVnNxWh4LEq3Ps153hMK0aEkSa0VtOCK/CqysnK3xBJsutXuZgp0NGKMzIWevE39TQSBja1JVQNcCK2o3l81bemLb+PfF2fcUzrWYUD94jtrGsSqpRf+QYdPTBlMP1/FMXF7/v+JyMFtj8xHl33qhvYyNNf9OGZdj6Hmmv8MW2BDl9LsLzkrWQdniNTA53nNEOI9mJRmK0A0vG+vSRRfvR45K5p4Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8211.namprd02.prod.outlook.com (2603:10b6:610:ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 09:59:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 09:59:42 +0000
Message-ID: <b9ee3eb0-9a65-42c1-bf6f-078b0f34a5d1@nutanix.com>
Date: Fri, 20 Nov 2026 09:59:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
To: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
 <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0223.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc94239-828f-4256-1554-08df46ecff3c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BR6B0w/amx7drDrmweL4vn4n2YOeyaLtlzR4mAB85L2d/7ZhKBotR/6Li6wEi1KutSKXp2e86Ew3qxIdErKUU5wFIa7Rhp8ehPhn1chSLr8seYdmEdxSJSw1yx4KH0iakmkBmr1cpgQ1ibEe6HES7yt6Tvz2aNjgANmmN7wq0occiAqPRUuTSNRhYVedhPGhvRgE25HTsy4JZJ+8PA9jZBKRe0rFiR/QdeewkI/+G8Js6K5szdd8TeAIFijPfNVPllTMhC/w3JvlnzPaXxoZ+9Sw9KS5oC2ITAyVoA8u0h3c9go3dx+ZpnlHgh34EdELONaWOPosazGQHMHP9JuM+CXkfYAzV6m7XK73Y7HAb84vQF3jdTpLD5ScEE/Pvd8hRyJP7kiOEs/eiFD5jk4KVISTyD9oCj6uITywjSgshitCiUjAhHlk7u+E+HcxTtyDVpgA03mPAarzpGp9r5Bnj3Q6/1jsKQpGapWFND8zkLRCYw/7atmcQ8uq6KFOuQVWNpGF4rT2DLBIsP7kohFlkPXjJrkgRJMAA1f+HXam6wRFF3puJKu93daaCBBAIgT20NewDS+Y9J/rrSpS4djk0peytFhn932Alhf6P/5sON8BIpD974jfCTqaG0X+bmzuPCVk7/1qfKVSNPu7srdCtd8QenV0JQRx07u0n11I1Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czEvY284T1lybzZQQTc1RGtUc21DdGRNOTVyUGNEOTF3aHZzRnpHUTRjaXVW?=
 =?utf-8?B?d3lyVFh1V2pXTmpsQk1rd25NS0VqdU9nVHI1TUQxQkpUb2tFMk5XV2d2dzdq?=
 =?utf-8?B?TC8vVWF0b0krKzFQQ2FtNG9TVmhielRiY0MwVHBzTEY4ZnNyZFhOVkZVT2ZN?=
 =?utf-8?B?VVVCOEExdGpwTWZVb25qblNsQ3h2N3BubzBtYnJmMEQzdmFLc2VySXhBZVo5?=
 =?utf-8?B?VFhMbE1YMG9tZ0VMNEtsdUZ5Ylg5dTBpUUM5QnpObFJ6V1ZqWnZIRU04ZWhy?=
 =?utf-8?B?VFpNV1FPSGRwdGs2MTlSVzJnOVloekI1VGN1bS81akR1SDVPQWw1cW52bjNr?=
 =?utf-8?B?S3VybzltQ3JMTldSOEQzeEdiSWFsbnlUa3dKeUpFL1doZXFEeFJweG4zRDNN?=
 =?utf-8?B?SllsTVNiY0FLcjc1Rmk3Zldpb1pQdjBrVHVTZWhvOUQwL0szeFE0cFRIYXc2?=
 =?utf-8?B?M0Q1cnNQdURKT2wveWFCdHVGeGEwLy9sOCtFcXlmMXNaeitjS04rQW1oN2s1?=
 =?utf-8?B?VTIxTmxuL0IyQzgwNGlxUHlwT0hWRHdhRHBlbXh1R2xMZkZISnY0dWQ1d3lw?=
 =?utf-8?B?eGhiU2Q1RnVZQXQ1NmNxTCt5S0ZwMzlQNFBFcnBBZEwwNjlpUHA1OS9ZS093?=
 =?utf-8?B?WXJjZVZGbmZkeVBNS0IyMjhGc3JzQVJZU05WdDBmdXNCa1duMkxJbHUreXl0?=
 =?utf-8?B?Z2xXcUhFeXdJT3dqb3I3M2lOTG92MFlwMkd6RkROTmpOeFkxWG92Qk1RT2hi?=
 =?utf-8?B?T1pQc05tQU1Zd2U2eEV1M2V1RzQxRW9wME9VeHhlKzlNU0l3SEN4aGlDUldN?=
 =?utf-8?B?NTlIUmNaUm5OVHdjOGFlZERQYkR0dk9NY3BzdE9kaitCOEZXb3FScUtwZmd3?=
 =?utf-8?B?R2tWS1pnZTQ3WW0zczA4eEMyR3RSeE16OTZ5SmJVYzl4YjBRZEsyT0ZBY3FF?=
 =?utf-8?B?L08wT1AzbEFXektBSm5pRXBoODYwSVNpUnozVHF0SEJ3RjVqQ0hTc3VmVm1q?=
 =?utf-8?B?SUdZWG1CQkRtVjhaVHF6a2ZoTmNJcCswaE9WcFJJUElHeURzSnJCYjVqZFp2?=
 =?utf-8?B?Qyszb1dGZHozcnl6ZWlMMGdpN1dHY1hJTTM5SmpJQmFDVG9sMStxejdCamFE?=
 =?utf-8?B?QTcyZE1KblJqY2xLQ3JySC9lQkpSMElJVzNDbXo3R205eVJMd09xZytYQjg4?=
 =?utf-8?B?eXAxRnBNRERHZmw4emVvaHgyS1ZyVVFUSEYvTUNrVStoRG5sRng0dUNrVGtw?=
 =?utf-8?B?T3Fjb0pYWU50UGxaclZ2Wk1KNWJLQU4vTnM1b01USGEzYVB5YVhPTXkrVnZB?=
 =?utf-8?B?QnRWNnZsRTRaZGcwK0ZyN0hXME93dlZtVTZkblpCd0NZMDFmVGx6OEpOZ2Fy?=
 =?utf-8?B?cS9DZWR6RU9VMktXN0dhVldYL29WOE93amFLeWZJL04zd0ZvYkFMZ3dhWW1y?=
 =?utf-8?B?dkpBNk5iRy92Tmgyb3EvVnd1Q3F4NXFNZXF6a1RwNGk4NytadmkvSFNtT0s1?=
 =?utf-8?B?ZmxCWXl3UTluak9UdE81NXVJd0pSaXBvRWsxUG4ycVVvVCtrZ0tsYVlnTVhr?=
 =?utf-8?B?SnN3NHd3R1E3cllGVndma2taaTRpVUZGbTFTd1J6OTY0ZUxmSk4wbndxV21C?=
 =?utf-8?B?aVBOZURSNDB4U0pUOE5SZ3ZFVDBqWVRpVFdWcVhaTlVnVTlpUmM4eHNvbENj?=
 =?utf-8?B?M0trdHlZZDl5SWRvMXlRblJvWWNJeFV2YVZRZ0ZGOUpUTzlVQm5JdEpta3p5?=
 =?utf-8?B?eHVqUVhHLy9Va09KZ285c2cxV0h3TTMwMkRBckJhM3dkeHAxcGo1cWFQSE9W?=
 =?utf-8?B?VVlUbUxoUDdSMWVmamNDTXVuNmVlbnpqWVU0SzFXbWJqcDQzQXdNcVQ5L0hF?=
 =?utf-8?B?Z0w5Sjdja0ZQRDc4UDk0UFFkNU1PTGZCeS9hK0Z1OXN1Zmh5L2J1R2JpSzVZ?=
 =?utf-8?B?bGdCMmUycFVsNFpKM21NTUtQZGxERWpIelBJNndaMGZaNERMN0F2S2pNTnZY?=
 =?utf-8?B?YTVhOEV1SGZNKzViLzB4eEhDbUgyanBOMHVEc3BQdWxEYmo0QlIyWkN3bHlr?=
 =?utf-8?B?dGtHNXZsV3RteTVab2RtUXo0VXE0WC9LVXF2UEc4MXhWTkZYclNyQlJBelpj?=
 =?utf-8?B?WE9VNGpyRzIrNDBsWkpqWm9SbFlxUmN4VHpIVklHWDFkMHZzRmVMYVRmRlpL?=
 =?utf-8?B?TW00dVR4MjFDNkhmU2p1SGJCR1VnRUd3Z3BnemdSbmRxSWZib2ZqQ2g4Y0dx?=
 =?utf-8?B?MThmeHQweGNQLyttVjUxaGllb3RCaTkvQlBObGdlZ245dWtRYitqVGxoVHdW?=
 =?utf-8?B?VTR3Und5VEl2NStNUFdoSU5PcEppZ0p6b2c0elpKK1pXL3BsdDdGakhNaFo4?=
 =?utf-8?Q?EpK/EPM/4EYm/VBg=3D?=
X-Exchange-RoutingPolicyChecked: mXr4xyYOvvqyG0eMfiatDQflkd83DPUYgyRLupzncg/br8+FFH8TGLCaBym112fx3I8XP0e/NiZD+ONE9zrWfc0aWHXZfZFKDUJPUfuwtvfEn2EqUeGniBfic7Hg5MtbhiDGS3m00bBoIX/5Q2E/QzAplMcrRB06NQ9vGBjADd5By1+U+4JyQsplQiylgkB5AzK2C/mu9lQe0AeZSTJhO2HED+v+dwLEgBlhZjMupfxD+TGSu70wijtd1NbI+R9z1Xf0SeeYGir6/2OMjp9jRcC9cLERhtm6h3mbqJu/Q+XVrdTacriBktCJTheZ2J7cx84aa89cOudbdpZRd8LHgA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc94239-828f-4256-1554-08df46ecff3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:59:42.0307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJlBkoMgGPFW2Ycrj0ljgo59Ns9Sa7WAW0niLKL0ZlMn4I3Uyh1XpeDPxzM8Sq3YOl99w4HG/Vjx35BFko6nL22oXSFKRDLmh4hMA20tIYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8211
X-Proofpoint-GUID: fXicgcwVX9uXns-WLbfQ8PYFn65Cvi9V
X-Proofpoint-ORIG-GUID: fXicgcwVX9uXns-WLbfQ8PYFn65Cvi9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX/RQ0WCcCB8Uk
 lahQNO2mF5p7LlP0JXlNELH4c5+VGhs0DImK05fMQbSZUCEJqjsbcpdjw90TJ25J8OpwJleFXlE
 0YKVXxJwz/aZopSBOt9FM4HDIIJqrUMlqHKDSd4poN6UZPBiTa1UgLcjc35mSEfrm46suF4/VWs
 hA8ZbU88YBvRawGONbw54QbUXaQ+oC1b+y2Cx9/30dLPV0gYGXRxtKRYget2TW2bMMtB9Ao0VkW
 zcvuL8eAfgsr6O7vBkVe1Xd7yx5KNR2mu5+2RKbbCpOmobBKuyqiWeCiXSVKg+ZrViYica5y7xM
 syWU1xRMLqwy6WsE5HEBlcIGYfLDwOqUjt+QBBHNZD+bz0QyyZHjCHR8Ipk0CojQIEe3Gp3oE/s
 f4/fd0TAI6CbViRytnhJVy4k1WOahHIToS2pOyo9vD9nvr9G7TW5nJyCTMuh7o2f/Ci7VV2EoAk
 nYTaz1NSLxmz3Xf8IUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX4Gwr2p+6uG91
 NSc7Mm05azMXaHf5YCE80jw0Gv0ISQrk+NaVl47as2CHdag2ISasRvjntbhfU5PlxkAEAkRxhFn
 apiNO+IK/+zsIXWI807zTqcaDYzaym4=
X-Authority-Analysis: v=2.4 cv=dtFOmFg4 c=1 sm=1 tr=0 ts=6b001a10 cx=c_pps
 a=Y5OhYnybWnDos8loL9/x+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=oKzA-NTK9lomcI1IsmQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 08:25, Helge Deller wrote:

> On 11/20/26 00:39, Philippe Mathieu-Daudé wrote:
>> On 20/11/26 00:32, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> This is the third attempt to replace the existing 53c710 driver by
>>> a new driver based on the code of the lsi53c895a.c.
>>> Patch #1 is not meant to be reviewed, as it basically just replaces
>>> the existing driver by a new one.
>>
>> "Please do not review, simply accept".
> 
> Well, I agree, it sounds quite rude, which was not my intention.
> I basically wanted to say that it's a hard lift-and-shift patch which
> makes no real sense to try to review, as it is huge and replaces
> most of the code.
>>   hw/scsi/ncr53c710.c   | 3042 +++++++++++++++++------------------------
>>
>>> Please review.
>>
>> .
>>
>>> It would be great if this series can be included for qemu v11.2, as 
>>> the current
>>> driver does not work stable for any guest OS.
>>
>>   11 files changed, 1426 insertions(+), 2215 deletions(-)
>>
>> IIUC even v11.1 driver "does not work stable for any guest OS", right?
> 
> Yes.
> 
> Helge

As I mentioned in some of the earlier reviews, I have a lot of sympathy 
for the submitter here based upon my experience of doing the large 
rework of the ESP SCSI driver a while back. In particular when working 
on QEMU as a hobby, it can take much longer to find the time to complete 
any changes requested during upstream review.

My take on this is that we want to encourage more people to contribute 
to QEMU and unless you happen to be an LSI SCSI expert it's almost 
impossible to review a large rework like this - and this shouldn't be a 
barrier for contribution. It's clear from Keith and Helge's comments 
that this series solves real problems that users are currently 
experiencing with QEMU's HPPA emulation so I think we should aim for a 
more pragmatic approach:

- Aim for a basic code review based upon our existing coding standards 
to check that the device implements a reasonable object model

- Ask for proof that testing the supported guest OSs (Linux, HP-UX and 
NetBSD) doesn't trigger a sanitizer abort when built using '--cc=clang' 
'--cxx=clang++' '--enable-ubsan' '--enable-asan'

- Mark the device as not being included in the QEMU security boundary

- Update Kconfig so that the NCR710 device is only built when the HPPA 
target is selected

If these criteria are met, and given it only affects the HPPA target, 
then is there any reason why this series shouldn't be merged?


ATB,

Mark.


