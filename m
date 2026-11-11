Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB9606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=nhpLxCmT;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=jxLaeaaQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBUs-0001Ju-Va; Wed, 11 Nov 2026 11:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBUr-0001Jd-Ae
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:48:29 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBUp-0001zA-BM
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:48:28 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0AUO3668300; Wed, 11 Nov 2026 08:48:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vt7kImTbaif63XgQKmfp5RAGPg9HomlXxEOpLfK0Q
 8Y=; b=nhpLxCmTzM8dvztKsoeu1uwJ8ql/t872hWTlgFlEIT2AnePAMHGz2AtN3
 1NJc5b72ZxvrIIuwRxZPF8ELd8kP7ts7QsfpEiDPmZJUVUWPcQWsAW/eS59dAei5
 qJP4p65pZk5LXJHLNlHmqSmtp2J8kGJj2QkDDLwn//nANw2KQiZOrUJ8ewGsEOyg
 IslApj/pylNc9FLWIOHei2w2VeCMf4I1hCCXaju2gLGWTMdwI5ByihPNmzn1U+Ys
 M2lbHepOmyQCqltSBKHyIgp4Wy7AgjS3IhH2LtSZBsd6eWdWu5ozMoi+PfrrmaUw
 yU58hCUbWYCLY8q1jw5qGPaqF+sFQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022098.outbound.protection.outlook.com [52.101.43.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hvjahsgha-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4U9rugygQ2KIuax5TRZGNqSwo6Jmsc4MpwZ9OcwVdMXv+7LsOlfFLX1xSeS7ASNaGQvqebL6VHA7QRGHo7+NKlPNgdBjcqqMDlQAnqhweOG5d1yG7qChk4YqT7N9NgE9N4teP075Y6sTECSP149QHfLUvqcGdH5+Y56I2vsC99ZTtxmoKIAompbxopvwS9HkjiXlogUDrZiMUSMJoU7HflCpDplRFCxrFde2IHWsXPNIYyK2ZMnJB6nxWUfKWbIkC/AzuG7khY+6wrhxjD4TmEDIcjvzlwseGrsCNY9Y+199rKbTeTxnQJctzMk6VEGDUax0GcwCYS8do4p+aIgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt7kImTbaif63XgQKmfp5RAGPg9HomlXxEOpLfK0Q8Y=;
 b=d40yyL8YRar/PqRCIJc/8MXBNuQaKH3uGv6ceDGfoTyoATXNdApqWJc44xIu22aU1NTuPFDZoag6EXmu+0+5NIEzqgEy5FZBhOYEBZreKtJKRmlBvPOhR7pLH9Cn5e9qAxm865indoSELQy3q2SBZuIJDQaZ21zD6QzSPMWKqHPKuZvdx1fit2Vka+zYTV4WPL7ZLbMpQjmXo1HLkLEP96bicz+p7lrWGuEab+0nUK7h3SW60j2mYYvx1EZWy5Nzpufb32dMVezd4xKbagid30xcOobmKhCOPgprbZZPa5qSvXZOTAfzuhVQcm+e3ID0+XxkoKWs+PzeSc05IDdSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt7kImTbaif63XgQKmfp5RAGPg9HomlXxEOpLfK0Q8Y=;
 b=jxLaeaaQMSfywnPK888HhXtyHD4ZMUyCbP/cA57SLgMzi3upTlVdKiWGKsi+SdZ7UG1+Wq6i6I/KffovP8aNi4zjzPq7AUs4sIFDFbDnSumQXHgoh7PnenN4bITqCkBRhqe1N2LiJuvaAgVnMNXh/n69ICA6fuPcGq1sxcKPV647NQxl6tdWZYESC5NClzTpj/owB+HvwXagN6u04SUWg9M8DSI3umUqe/huxqPhA9MCE1r3HGH0nlghGefe3DPWvUKai1276+oy+31CGv7fxG0fxRSwT6Z0QZ1og3oZP6VvNk31IYWWTxbtklVAcrERpy7zzWNxgCN+quLU2XXMkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8777.namprd02.prod.outlook.com (2603:10b6:510:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:48:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:48:15 +0000
Message-ID: <a9ee63a9-daa7-4e15-a627-f2ca5f909a81@nutanix.com>
Date: Wed, 11 Nov 2026 16:48:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] backends/hostmem-file: Drop useless validation of
 property "mem-path"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-3-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc7d389-41fc-4960-1e8f-08df40139485
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|261021123027099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xDBax6WTCzAuRcr3gHVYZuN0jrU0o3v/7gZLAOvLXoL07rYLprzNDxNbelS3TOCvZ2H4UOBnrhKtph4f2zu+b0l5SEtKh3WNVjhT2cRCQaJzJYdqexHhR08vlmEKhafrPmBI1u3kzwpkbx8idF6UWe/vP6HxH8CWoRQuKSl6dcjFGY0+W2nS3W02UGQX2jE8oy/rgAi/IWl2VxfM+lJsnBje2CdpKkVQIJg044VpKL/Iuq/Lv5KhLlM3C0EWpB7WFbF2lFFSLM2UjJpNovwp0fv49i0lDKf/wwogeDsOiBkXTvq2QQVBxF9F/AXX+oOUtCyCwESAIgMZMIEqUGYDAqJG5mVl0iG3bpnhoAVT1N3eawk33qyKoMTpSb2jO5476cbxaxCSJSyBHsQUkJSQlnA2gL8ahy1V1GWymbg2EMaRBmW1JQdGU+OUAv8AYW3Foi8bQQgUw2AY5MaPE/4tw+b05bct5kAaft3VCmBIygEof8HwYlPB6FtgH4w0+SwCSWOGG4n/k9hrlMbvJXE+bZb0j+fV6/rMCYTQGER+G8qRbfuZlf7qUq82jtjLFHvQuVB/CXepVrHypl57qxJC/TJ+yryxM8EF08l4d64PF3hEU4/7owyQf9vDM3n1SozwrbIOVh75ZbQKew5+Vr+sOuV2RVSJCG2u3dZ6hYc0tbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZENHl3QnBDRis5NTg0NEZ0WFBQQVhTU3VMMk5iQ0xMVlhNMWVTNGxZbCsx?=
 =?utf-8?B?dk84N2hJdGlFRlIwTXk5bHFxekhMWmltM1pxMHE4eEFVZ21CdzI2ak9ZYTdB?=
 =?utf-8?B?cFg2SS95ZnFIYWg4Z2ZaT1dwa3Bld1NvcVVXLzN1ejBVZ3VYaFdodkZCYUF1?=
 =?utf-8?B?LzNGU2dTR09JY3VHZGQwY3ZMeDlTaG14MFk2K3FJdmNNUURLNGF0UkxYSDN0?=
 =?utf-8?B?NW1SNWJwMDlTRm1MZGExZjYwM2VNSGRhelZmZlBUNUlYNkg2eHZoNS9VQktw?=
 =?utf-8?B?MEVFRmY2WXRvbVBsTXN4RWdBV1Q5cFk3R1NWU0lKMmRQcEd3YUg0dmZ6L0VC?=
 =?utf-8?B?OVNDRHRWRU5nSVdpWmUvWlpzNFVtTFVHTUxlUVFpWVFRT0RsL3FZN0ppaHJS?=
 =?utf-8?B?SkJyditaQ1dMd2hqaHR2NHVQMkZWOGhGblYyYk4vVnk0bGRDWllmR3BESis2?=
 =?utf-8?B?d3o5RTlLaUlFeEs3bUlSd2hwL3A5VWZLdW1FYnpFM1V2RmhpMWVmNGMyNDEx?=
 =?utf-8?B?b0p5VndkRDlFV2dUdWlOOU9xNi9jMEtqNy9nSTJxUHAzR2s0MDMvdlRVM2NC?=
 =?utf-8?B?NmQ2dWdIZEhhc2o5Z2M2STRzbyswVkVCbXhBL2Nsam14NnIyYlpHemFlR1V5?=
 =?utf-8?B?eGhSejRHZ1NsMmNwUWxCUXhvYVpoUXBRVmcwQWQ4Q1F5YjM3Wi9pQnhKcUxI?=
 =?utf-8?B?U2lkOVFHK0hjV1lFa0I0THBJM2JUZXY4NXdlT0greWFkVG94Z2dWdm9HMFNs?=
 =?utf-8?B?OUZGWHRkaDkxbzg3TEVNQXBQa2U0c2ZBNHZqZVhwZUFLNzdzbXBhY2NGdDBN?=
 =?utf-8?B?OUxyV0x0djFKTXppQlRsYVhYSVhjSUl4anRqRmVMbDZmZTY3eXJXbVd5aWp0?=
 =?utf-8?B?UUdOTVJJb0ZOaU9tRTlHd2wwYlNVV0JpcXRQZ2ZPa20zUWliS2hWT2lVOFpR?=
 =?utf-8?B?RXBsRDBadjBMS3h3OE1TL2pTcWt6YllENUNjVE1YTjV4cGNXSVlNUjh4OFdB?=
 =?utf-8?B?TWpKVGN5Z1dkeDBVeXlNcEpBVkNMRDFkR0ljUUJNZUJXdDEvdnFpWXFOeFdw?=
 =?utf-8?B?TmdoU0tvbUxqb2pGbm5EZ1IxVUVmaDBMMGZaUUxra0JWZjUwU0FMY2JldjN3?=
 =?utf-8?B?WnA1T0FGQzFrblRYK0RPUFBZdnNmelFuK2cwU2l1OHpLaHdiUXFVSmR4K21L?=
 =?utf-8?B?VzNtTUlWRyt3SWU5L3BZNVFrSTNmb2hQMVBHcmhTeDZaVDlHOVFkUFYzbFpP?=
 =?utf-8?B?bGI3SUJoek1DenRDdnVsZFYraFZ1ZCswOUl3ZWZ1M1hXVkVUcXpNU2FYdk1q?=
 =?utf-8?B?SERGY0xicDhySUdnaHFBQXN2cVRlRUIwR3pLVndKcm14bG1GbVFvQjFHbDRF?=
 =?utf-8?B?QTNmOWJnd296NVh0K3I0QmRJdENZUW13cy9NeWNacldXenFGV0JRSEJhUVVr?=
 =?utf-8?B?RzJqcm5zYUlrbHFMOUZtVnFHOWU3cExnL01HcHp5SnFINm9sRXZ6TVlSNWxw?=
 =?utf-8?B?b285dFB2Z2ZpS0xRbmlaZUprRzVtcGgvcWw5a2pLK3puM1QyZ3VzWnREUHp4?=
 =?utf-8?B?RHBrdElnU3AvcDBWekhXMEd2U0lHUUJERzZSaGVxdkx2VldKU1VPMmNKYVFa?=
 =?utf-8?B?UFkydzFpdy92Z0pVZ0RtR0lrRGhXZVRIaVZ3bER2Zml2WDgwRVFkcVN1TzVn?=
 =?utf-8?B?RjZhRmt4L3lmTU1jaVRTdE03RVNQcmh1Q1Ftc0JodS9YU2JIdFhubmdYUXho?=
 =?utf-8?B?VjJqTVF0dTVoQ1pPU0FCcXFYV3p4c3huNlVxRkpycjhYbHNlODFYaDJuYlB1?=
 =?utf-8?B?VWkyeFpsNlV4djRycCt4OFpWbGN5OXR1dmE1a2g0TFB5aDFYSm9vR0s3a1po?=
 =?utf-8?B?SmpvN2tFN3pDcjV5RXdtRk4rTm1ROFU0MmVxbFRxcndlNnJUeXlKWS93L24x?=
 =?utf-8?B?N05SY1NSSE9aTmZmNXYrYVlhSmQ3OUxaUVRkWllKNU10LzIvOWYwWDcyampz?=
 =?utf-8?B?ZWVHS0lyeG5hNlRXanJkRzEwUGJ6NnFCZlNDR0FzbEFTVzVyMG8rZUM4dmwx?=
 =?utf-8?B?NTJJakQrOFZnSmpzQnAwSWJNUGJsUmxZK2VxeVc4eCs4Y296dGNNWHRURXVL?=
 =?utf-8?B?T3VvbTBsNnFzb2Y3Tm9lVjNUR2x6c3NXMVBwV2pPVzNYT2E4cXloNnJERjVK?=
 =?utf-8?B?ak50Tmd2VWNXd0NMbFNjRVltM3dNRzU1bFdJRFQ2RmZ1SmNlbzJxV0VIYVpi?=
 =?utf-8?B?bGU5b0EzV2pSUkxnNU55WURCU2hSVXVUSkhNcjVwMVNYSE9laVN1L1BKYWJw?=
 =?utf-8?B?T0w1RU5oMzE4TDJQU09RMElaeTV5RmZ1cG5ub1ZTNWd5bXYycHV6OEhKb2Yz?=
 =?utf-8?Q?zOKsrfbswftBfBgA=3D?=
X-Exchange-RoutingPolicyChecked: UL1spSgDh0Zv09s0+0F6vJ1s//0M7F0Ms2GtrZDcs7QaXTFuzixqVtX+H4smLEW1gngjwFzLNXcz1hnqESujg1jkSNZh96Z+mSyrdXHzG+wCEdmzMs3tpng4lNkbfN+oRmo2fryhmYA9fAVyv0zRvySSHHMRGtQpt9RvM1uy8oO9PZwIGTpCnRMeWZwCjQVrazfPoT2vekrzL53Kdmk6sC74Eqgg7oG21qSGnwyygBFNKgtqb+vpZXz45hQAuafgDDa5t8kqclO+rJEBHxcaiwR3W8ggCwGx/SFM+EPsnDU2WDtrIZOIi+WbPhpwR1VuID8H6nxM+4tmH6LWwzExYQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc7d389-41fc-4960-1e8f-08df40139485
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:48:15.1309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTfFr/5gcFOUitcGujqyA+nr3yav7OZvovDv2yEQm9fzP+2HwTFkbxdJd1/Gvnrw/JUNcF2kGD5bMvh3/Kvwp6nV1KrEBTJuR7AAUfObBPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8777
X-Authority-Analysis: v=2.4 cv=G5aJgNk5 c=1 sm=1 tr=0 ts=6af49c50 cx=c_pps
 a=52G9BLf6iDL1HAe0xuko4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=2zquirEroGgav-hPdpkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rnkqAkyY4w2lZ-sV-_1eVrNZnC_duxVC
X-Proofpoint-GUID: rnkqAkyY4w2lZ-sV-_1eVrNZnC_duxVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX9ouN9oCLj1YL
 Cw82Toug3jBd9I4rCR9MpWtQF8n9d9xsl8sjpnM+CbEvWZxCpmjx5GnxjCvPxj2EJ/uKKXL/nrD
 zD0A175QX0DH5/uWI9NmCrM2/jxJZ+xQ4nj0Pd/C5ZuFFr7NLxbEQ81y1rkvRdsnedEewbhmDVH
 IiTYDmVlUWHW+1fmBWnFPX0fFhZZA3GA78AfWh5VZUTBCDIuSJUQbAmMvW119mxpJSNzTsxuA5c
 VVeEx683X5TKrZgpwlKMm/B1kc0r4s2UtRaZm92IzH1KtN1pBXM5GtgZjpcj5qfR6DoVE1O23aB
 HhYQcJS+/1uQ8EGw2amBsfVlLt+niAtvN7GjOAbh1FwEFy8rYRZ3YN3MkZanSXwGeqKVsiDCKnJ
 Hrk41jHvEzidQOswtkhlwi/PhQdWvI5HrvcDDajb7G1m0Nr74XG/iCaJo6N8WCIs2PYEX1ZIe9c
 asLM8/17bHGIG5dzqsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NiBTYWx0ZWRfX4eelU1tvOA/l
 3rO6qVOPiEDReK3fcJoC+OL6wzsGWCuavTq1f7wwYa9pJTfWyHzgtXpudJFLajLeKG2vGmappQ5
 W/yKRGq2Tvefh/vSfsBsg2QUCKIyDSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> A non-optional string property like "mem-path" cannot be null.  Drop
> the useless check.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-file.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 08d0382d76f..1e8f8ae6aa8 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -48,11 +48,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       g_autofree gchar *name = NULL;
>       uint32_t ram_flags;
>   
> -    if (!fb->mem_path) {
> -        error_setg(errp, "mem-path property not set");
> -        return false;
> -    }
> -
>       switch (fb->rom) {
>       case ON_OFF_AUTO_AUTO:
>           /* Traditionally, opening the file readonly always resulted in ROM. */

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


