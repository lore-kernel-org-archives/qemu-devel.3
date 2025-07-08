Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4436EC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFKj-0004V6-VP; Tue, 08 Jul 2025 16:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZEa3-0007w4-2a
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:06:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZEa0-0004TI-Vs
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:06:18 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AM29b006607;
 Tue, 8 Jul 2025 11:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Iz4UYZO4WjYwiI38oQdEkyjwOqb073kcqXCpYjQtsE8=; b=
 IWjmKAXKk3ySjyFWGpD5tEQiFYIMTrilj9BhQX1LThA6ewUgFPwCILt2qf+KQ/pO
 hUGlEdQSzInZjfj2l4dBSvzbQutpj7J2ajgPCscZQu7xc+fymE7EWv/n134jTUDx
 zdqBSTQgErNHOFdHsiqD1Xlofc+HbFx+4ZceM2m88eqpI3BSvI2i8TLlML1Adb/T
 8gVfEGCGnIwxWfz0sGF/LBjRY6PhLpZvGTzj8AyiCGbkj5y7PDvcCIiik6SznJ6W
 D7jdTNHxQq1zyzGjj9gloOJN35PrQ8TSdwroVIaHPNFSsN13VZzLWMATfH23uAma
 Jg+y5pkvd7zwt0a+ci0QKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s1gqr53j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 11:50:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 568B5fN1014029; Tue, 8 Jul 2025 11:50:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg9gq5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Jul 2025 11:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LslE0n95EZbNjsL6NyCfMRSgK0NejDUV6tsToww1tMM1YwOkWR8uROfVdH0zJlrz4ZVv9k642oD5BDn9C9PpgScxW3O0LMKgTyrgZ5UQqVJoAnImH9ptR3Vrqn8PiaS3gQ9fQTnRya46o0EXn1dh/U73MKMo7PxkUp06VowLhWtj2amSfZ3epaGIU9fyLpGJ1Vqcj/mg4MIQW4KY+cyceSWwGHwNCH4bavsoSEpJe5CK8soEdrHelnoX6pwaa2Gl4yv7WU2FG6o0wmRdSlY9HidMJYixoZ0/XdPfGTglM4gxoueR6ISeinfJV1sptakAc8HR6MBSS0tSlFbgcHQGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz4UYZO4WjYwiI38oQdEkyjwOqb073kcqXCpYjQtsE8=;
 b=PUTVDfiv0mbX///f+a8gLl3QXDfMnoCZKb7n1BfbNlZ+s604RUI36Q3ozPPFKZMFhElCXiVSeEBu1U6JsTcRCZZaUG+5HQODlKRRYgw2h8sj37tUENGTh/h9wo52WXux4gGP7JZqbQtWei32lNF+bikEdikFE1v765nu5bb+srQv0K3miP/KzziZFsNEOc1MnS7Ss5NBF/GzOC3MLO9sgY34tgvILFXjVZeWRbElL9ecaQcmUjV7TVlIm1wCezmFEeAv3rjs/lpGD8aiabGUyVfL36ulNND6Y3onDLno/d5tl/qhzADvDYh7IM3LuX99YtYRm3lLlal7QGLEaJS07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz4UYZO4WjYwiI38oQdEkyjwOqb073kcqXCpYjQtsE8=;
 b=Zmk7e91nBoUstVKPi0ZBpKxpAPC+57APTpu/qVbXGaQSBy/8ExaEC7ZbFn3ugtnzWIsaO4qMxhzvZ9yK8YY5OWrbStayYsmDbIIUkVGXyuafZMRbqsMu0VrxyXODXzJTFCZ2Jv/nkf8h5ep8doRIXPTtD7xDom+jL+gOQUxK6f8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 11:50:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 11:50:29 +0000
Message-ID: <5f3ee337-ee4d-4bc7-835d-fc9ba2469b10@oracle.com>
Date: Tue, 8 Jul 2025 07:50:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
 <526f5090-eeae-4eb8-8d1c-e006d9501f62@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <526f5090-eeae-4eb8-8d1c-e006d9501f62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b85e54-ad64-4b71-f115-08ddbe15a2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGhNYkR0dE9GRWdoNzIxTHpGZHJhaEZhV1pmVlVOUDA3NUZhM3RBY1BMR01H?=
 =?utf-8?B?dkN5VVYvVitVVmZGN2VoRURuV2I0eHZhdjV6akNrOW42c05FcCtDZStCcm1X?=
 =?utf-8?B?Ymp6N0xJTUV1RWVTS2lZcjE3elQyTjg4SitNSWdnU2tocis5MUJjMEVEdkFn?=
 =?utf-8?B?V3hCb1NEZlJucjF6WktTWEczRWwyTmpWUVV4cytyL1poVGExKysrMVVHcHZH?=
 =?utf-8?B?YlhhbVRKWWIwTXhHKytOMnYySURPZ2NSTGN1NDgxY3FQK1ZrYk9pQktKUkhp?=
 =?utf-8?B?WGNIVldUVnlGd3FkY0hCeWh2TGpwc2V3TzU1VXU0ZTJ6a1AwUXBKNk1PNTRC?=
 =?utf-8?B?UHVCdU5md2hCYjJCT3hDbVdseGRmbFVPWWxKVWIvOE9Wc2wyZkM4YzZvaUp4?=
 =?utf-8?B?WERVNUwyMW41TmwvTGZQTCtrU0t0S3A0RndaRFMzYnlIbEs4Z3JlSDhEMDh1?=
 =?utf-8?B?WmRpNlc5akg4MC81TzRrZ1J3eC9rdTF4TnRUc0FLSzJaejdZajFvbXlCeGQ3?=
 =?utf-8?B?K05VSEduK09GaHF3YUxnYlpjSnR5cW1MeUROQURRN0hCdkprM0gwVjFWNTEw?=
 =?utf-8?B?amlOc1phakRkWGlvbTBTdDNlZTlsWFZtd2xRZkc3eW5PYnZlZjlJN2VROVZx?=
 =?utf-8?B?clY0M3I2L0g1ZEl6WjNsNWNDdCszMjlzZzdTaTUwajlUWFBsdlZwb2ZKNVBm?=
 =?utf-8?B?V3JpN1gvQVNlNGoweWkrV1JLZExVSEVkOElTZkI4a0dRTGl2UDN6dnVmT252?=
 =?utf-8?B?M1lSMkZBdGFTTDRJd1BKZVFtVVBXdEVEV0gycVRzZEp4UkU5Y3I2bzFQNVhM?=
 =?utf-8?B?ckdUZjFGVkhwZ0VEbG1ZY1FiWWdCRjFwQVVUaDQraktsemd4NDc4OXcrUGtP?=
 =?utf-8?B?eTB5V2ZXQkJ3M3psWHFpMjM0cU93YXNuMUQ3SUx4K1lLaHdoaEVzR0o1NSty?=
 =?utf-8?B?WElYM05CUHdQc1Z0UWkrWk9qTi9Td1lHQTE4ZUV0WTA1b2M1cWxOc0RicTZX?=
 =?utf-8?B?L25XSERod0k1WjRtVWxmY2c1T09NUEdid2NzclFOMVlnK1VYckE0Mi94aEVT?=
 =?utf-8?B?YTZGdGxWaFJRYXNqM2VyeHlSSk5xTHF4T09RMU9HeUJaZXRDZzZrZ3NObUI2?=
 =?utf-8?B?allyWmVkZGQ5a29GaHhYSWwwcGw0N2lPOFNvWjVkNXhYZVBFOFZmVzljczJi?=
 =?utf-8?B?bDZQdFVka1VhdGU3UThmbTdHL05wSHA1Q0RnNUVYeVpKRzR2Sk85cFZtdnpU?=
 =?utf-8?B?YUE2bEJLamhOQWZLYnkxMUE4Q1pMMzhKSG1zWFVaamtVdmFqOElwQ0dyZlQ1?=
 =?utf-8?B?Z1NxU2dEMlhFK2ppWGE0d1RJbkZTazhHVVlrTkdCN0tYeEtTSFZoa20yTzJ0?=
 =?utf-8?B?UHl5S1dNQ3RTZzlDemJYbUhhZ2hEZGVpK2trL3gwWllKaFdWQUN3Qk9DZGlu?=
 =?utf-8?B?S2dVbWNGQmcyUlBQbXVaQzhwMlY2MitFT2pnK0J2RS9NTm5teFk5NndmT3N5?=
 =?utf-8?B?dGQ2cktkemN3aFJRV0w0aVMveHhDd25BQXZISlFPdlBNRXRFUEdpTDl1U2xZ?=
 =?utf-8?B?T21VN1BUeXl2ODN2Ynd3UEhUR1RpUXFMcW9UZnVBckV0UmRUb1dGcXBOaDgr?=
 =?utf-8?B?UTFJTXNkWXFsNnRkeWxVNlUxTGJxK0NyamUxanJ1MTdZWERQa2RYNFF5QWwv?=
 =?utf-8?B?MXFSMDFpcW5GMmxVNkF0N2VlcmV5VzZZTWYzVnVqMHdrdmE0R0pjRGxxbFpN?=
 =?utf-8?B?bmVoLzFiblNrYWNJUWF0RU4wRGtEZEpHbFc1aUVFaEp3ZlRId21DVUlrY3M3?=
 =?utf-8?B?a2FvVUt1SDlPTzkwbmdGYmUzcmtlZUhGbUkyVS9QV0xQOVFjek5DdnA0U3Zz?=
 =?utf-8?B?RDlMaFBaZHA2d1BjVHRtQ2MxM1R0aEgrME1nSzQ2RmVHZ1Y5ZUVSUDRjaHl3?=
 =?utf-8?Q?zP+IZCukzRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2Z3dm1BRG9EMXRhV2NkZ3NlV2ZGUTNEd1VMUS95aHMvVmNDcFZPU0ZWTkdB?=
 =?utf-8?B?SXpXVmtlU1JLbWhBaFZnV1JZLzNPKzZsR3p2amhieWNISzB5akdITkVLM2gx?=
 =?utf-8?B?OHlXNENjb3RBWFhBdjJsUU9Jd2RuK3NkNUtHRko1QXNEVHU0c2F5Q2dWUWxZ?=
 =?utf-8?B?cStiUmVLRjBudGIvb1NOckZJa3dGMC9FRm9QSEVnWTlyR3BKR1IzVHY5UXRW?=
 =?utf-8?B?TG9DZ1hGNnJ3emtZNjZxQkd5dTByTmt6cFBsNFpuaEZXRG1SMkxBR2F6b1Iy?=
 =?utf-8?B?elVEbmJLbWpNVjF5YXNwUG01SGFRVlR0WHp5YWtMck1qNllOOGFrbXA5a2Jx?=
 =?utf-8?B?VTh5U3B1eE1HaXZNWnJITklQNjFtVG1Vc2FqVy94anJWYzBwbjZTN20xL2ov?=
 =?utf-8?B?YkxRSW1mTEhGZzhZTXhPd0VndDJsV2pEaitlTmlhN3NldDFnbDNNKzR0OTN3?=
 =?utf-8?B?UEw0dkJOZE5XZ1YxVlhyMVUzRTB3Wk1vemUyQzFzclR3L3FVdjB4dGhYL2xw?=
 =?utf-8?B?dk11QVlOakpYbGdieXV2MmFYNVNDem80TkRxRDBLbTlodTd4SGpSOWVJZml0?=
 =?utf-8?B?UUMzMFQrWG9oa1dsSEE2bGZrUlEwaEJUUDhHUUN0ZWZOL1gvczBIMXRZYy9i?=
 =?utf-8?B?Z2lKaVljWDNNK2RtSEZLYXkxL0hXRHBwUTRySUxXU3p6TzFoRUNFSVpmWlBi?=
 =?utf-8?B?N1Nydld1aUhlek93dWw0SHVCQkFyMmZGQTF4SjVjRHU3MWxvWk9XSWtSaE00?=
 =?utf-8?B?L0N1TkJvLzNUNTVXZXVBMEtDc1hQSG1jVlR0NnYvdzNtQmNwb1hkczZhcFVm?=
 =?utf-8?B?cHZBdGlPMHkrcEE4OE9LcEVEQmlUWUFxRDRRSmlZeEwzMVZSS3BjbUd6eHpL?=
 =?utf-8?B?eFFJdVZVRi9ENHErSjJINklycGtTU1NTL0FtRFczODBVRVJCVmZBRW9ocmVn?=
 =?utf-8?B?ZU01eCtldWhLZU9DcEJmUlJJMEkwaS9uTmRiK1R3b0RZbGtUbnBGUkR2NjBt?=
 =?utf-8?B?RzNIU0hoNllaUjdtNTdxTHZuSVBMN2dtQkQ4a3V6aGlBcURydzhraC8rWm5h?=
 =?utf-8?B?WFVnTjVRMXFoMHVzNWdRRmtVNThVN201SnEzd3BHc2xpM09EMzYxbUJKK3A2?=
 =?utf-8?B?bUx6VERjeWp2MnVzQVVURXB4OGUycDluZS83RGE4ODRoc2xEeXlJaHdZODFu?=
 =?utf-8?B?aU5kNmZFN3Nyc2lNVmJ2MnN2dTV2dG4zWXc2U0daUnZoMUNtY1NGaTBEZnZO?=
 =?utf-8?B?K3Brai9xU3UyWk1QUjU0RjdzNEltdFdQUHJsWnk2cEVJTE4wNEVEU05oM1Jw?=
 =?utf-8?B?MklTaWJZTXFEUTFLS3RRUnNjYjV2ejRVUWVyKzZIeFlVOXVtS2lJWUVQcDBh?=
 =?utf-8?B?d214WVBiRzV0MEdPK2gxcEpLcFdiaDB1b2duc2xoSGtxVHJkRlZqRkRyZFpP?=
 =?utf-8?B?WTF0a09tcUpDclFRU255dTdtNEFKTFZlV2ljMEpKeXJrU2ZZNDhwRy80K25z?=
 =?utf-8?B?eWY4d0xQaUFPYjJvb0VwUlIzZDdOTUlrUXBJeGZ5aERjZHZFbDVpSFhJNDlh?=
 =?utf-8?B?YWp0a2w0aDdieHk0U0ZJOU95Z2RaK0hyVTlvVmNtRlh6U1RWZDZpTzR2OXFs?=
 =?utf-8?B?L1ZPeldQME8wM3N1c2JKVjlpeUFpWUU0NHB1K3hWQm5zaG1Kdm5wUTJHUVBF?=
 =?utf-8?B?QkpnUGJnYjVobkQwc0IwcjFnQ3dna1FyeFZhWWJjVk1TOFZIaUFRNUpnbFdr?=
 =?utf-8?B?WDY1aXV5WFJ3K2dpL0hRa21HTGFYbldOdWtFcnZrWENOZlVNZWMyTzZIUjFz?=
 =?utf-8?B?cHIwVkZOTUsvWGp5dytveEpWM04rM1dLbmFrSjZnbDRiZ0wzQmdhMDlwTGlz?=
 =?utf-8?B?d0RMN09UaGtOMEd0QUxEYmhwbGw3Q0R5OENDTlRhcVdhYlJCbk1DUFAxbjR1?=
 =?utf-8?B?eUJpVUNPNUpYU08vTDhacW03R2ZLU3BLNFJGbWxMSGxXTUlhcmEzanRmK0xk?=
 =?utf-8?B?anpZOVloQlpFY0pHN2M4aU95bEh0ZjdGUnBySytRK1g4aWtsMUhtYXB4a1Jv?=
 =?utf-8?B?VE5rMDl2Ymk4cWxuUElla0lQZzM5am1YMEh2eEZZbjRkZkFPNjg2Vlplcktl?=
 =?utf-8?B?TGZQQzBXZDZKYS9VK1ArcUdSVHJIMFpqSGxpa3pUZ3BOU1g1OElJOGVyRGpa?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1p7HF0VUvA9WTVsC2rQiaRv9jBgtMhWeRrvh01y8W3YllS6lx9sc3oxXpS/GT93v1pgQZPxYI5SRjWySk1Pk/DlK00fth2CWZPsKB1UcvcK8CzR9Orh0s8Pf544IBsWBI+F23srEcZVVaCM9B8G6d884dHUPrCynhI/JeyOwZMWZcj3DbWxspvrR7y3h4EznIevh8lt4h0Hh1vMmiw++bdhIA5NscgMR4k+5J/K0yeuAVqlc9NYiQNNDV3RFIN3CC02pdTIoPeSI4dQBScI393YntWH9Fu6SCV4FasSdBx8HEtEqTwSWJ5uC7GldPGX77IiRLHtzxe9Adi37gxOvyklM/110veTpPwM1EF0GIZvWUx9PsHBMlnHRSHZyrAeD+ezuv21jQDdu56Uo/3aqvuCzovuQ6O5jTrqxfaX6BXQDgpkFUAqHVztwEoirm1RYfXDorWo4h0RCkmbEAedHVhIS/kuThKcDI62Wp6sK/Zpk7I5hG6WzsYcc95IRnd/NKYHdRFbcBzVg8iea2KNLDjkXqz8qI9eSzm7fmJbT9ATPDkqKrlDNS9WZRzXd+MjuIcAio49aW1CBPdcFmWteXgn7Md19ngfbM/7VzDJ3wmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b85e54-ad64-4b71-f115-08ddbe15a2d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 11:50:29.5474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H+dA4Q/d2xZX5GpMbEY3pAZmi0JfxMKy/q/o0vZTqaRRmNYpbLDqFuZAUiBYi9vFTYMJmyTZePwlJck0KZXIZpWV693WptkqjmpcSq1knE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080098
X-Authority-Analysis: v=2.4 cv=Z/HsHGRA c=1 sm=1 tr=0 ts=686d0609 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=4riZc8Qjg92iqy8GitEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf
 awl=host:12058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5NyBTYWx0ZWRfX+sjmJ9XBuLSp
 1g+neHTwmqQyZlHynfnr1lhIdU8iK5q9aVBDPJz1wGN6cI1n9SJGnhq0+lJ/AroVxT9g43eGswJ
 ug9P7EL+HAVkqodH4Q9AAInsmSDnYWBW91SzRVOJK8r5OPzJAbVTE1oc9mIrTo/BeL8XpC8v8qG
 o/3ERiPm6VJGh1MwLxwVnri4ccUn9nOvQYHUe+jOFTVgxed60uLq7iHYnkT0830MCcOhGNbAa9n
 KaAjWZL83VdYBoa8zulvVw/W4GJp1cgrGMCMdtQGzJ8wacGebF1BISXHW0h5LP1m+4QCRJTRkRd
 PEB065WDuPHKHtHiX0+NEn20WS/j7Aho9USivPYW+YQEc5g/aiyOOSOkuOCKIg8oDlGUQG2QoA1
 0uAiQyrgVwLi2rjnyTrCUaa7/G21u8zOBSmaLzSqtPwG482nFejPUjSg4aQEKvqEw99+x+WJ
X-Proofpoint-GUID: khlprWYphRMK-bj3ergbzBcbPUrazklO
X-Proofpoint-ORIG-GUID: khlprWYphRMK-bj3ergbzBcbPUrazklO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/8/2025 3:14 AM, Philippe Mathieu-Daudé wrote:
> On 12/5/25 15:47, Steve Sistare wrote:
>> Define the qom-tree-get QAPI command, which fetches an entire tree of
>> properties and values with a single QAPI call.  This is much faster
>> than using qom-list plus qom-get for every node and property of the
>> tree.  See qom.json for details.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>   qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 128 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Hi Philippe, thank you for reviewing this.

Markus has requested that I drop qom-tree-get, and only provide qom-list-getv,
to simplify things.  Do you prefer that we keep qom-tree-get?

- Steve


