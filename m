Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A2EC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UIC-0007pf-3j; Thu, 17 Apr 2025 14:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UI5-0007jO-NM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:48:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UHs-0004qH-Mm
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:48:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMwFQ015340;
 Thu, 17 Apr 2025 18:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=f+JaYChY6Rhv5f++v7pdBKyEVWu2IV9PdA9ORVOptGY=; b=
 QpbR6CzMV4wYH+IlKRpOFigtLLi5em5V/1OSaQycYMFIz+/0y6IdBL/D4v6NGKri
 dvnHdN9ScpPGjRlMU2VCG/cR9yS9GGmOjGdnCJdYN9J96X1B7ZTn0sJtKQ8iZuWw
 BT88oI+Q8JdSL0OtHplq/a3GyyhHjdtE7EPdv9aaFiyNb3TGegon2TTKbHnRE6eK
 DcaESitZgD6lYIEHcNAIyqVkH1CVrKx0ItVHWeV8FP4FxFVj+w5GKSrQOALzh8ey
 jxjugK8127O544hBjpmwGbLnMZwB49zAH3j3c0gJgfl49PThTUf/NzjpniC9eW+H
 w3+zKeAShpTS13oiU/LQKQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944euun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:48:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HHEuLH009219; Thu, 17 Apr 2025 18:48:26 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3nnaa5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCvw8eG2xlmPRhyPZkC6VPpqXWzfun4mZQIcp9rguEjIMDCVtrr07iyjhzWOrqYoyzvUIi5DP/zA8yVSzOY9RNoxoKbj1iBWsTwGxDv19Z7xMe++0NvCoK751ai/x8jg/9+sZPNKLLJqDCIfpgk9DxMscXlSG7/LJ+Gyfj9ju+iLCufB8tXOR5DIt/s4BrbnQtktjOOnlWQhC5rZTxqmNPZzK7P5LVntucFHyOWEdDv8dgi6qmZkrGYYhsQSSssvPpRuH41CXXDbHoV310qiqv5pu6SQzjwsKs1D8Ur4NouD1fVz9b2cycBQHE6cyelRl5B0qhi511Sgiq7aBqmMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+JaYChY6Rhv5f++v7pdBKyEVWu2IV9PdA9ORVOptGY=;
 b=qnzR/1usSoXtjGwDkAeLUpSAjRehQgyJl4fNzS/ZKo775TykawiMozFXZlO3iX5nwo3cRWwdQqfLgAxNQt8QB5/f4JteJ7DOdC6JwDcCuKmwcBd7/pcjVjoxSv52dekInI7fK0qlHR1e9r8juuqnU7ua/BMpsZU1o/+eTAW/FCReEMK5UWM5LnffUOBPZ6Oqlu9Vfi132pBN1w3tsAphh5WvDs3x6iXY5l6K1mUteDS4bpa2u3Nt3H3bs7goTiFxKwO+JAyfzX//0U9hIE/itt3TBUwV1XVd5Q3j2kjR7FlRtmmfGTi8C1GXO7islKi/g2plyZRsc7Y1ATscuEtJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+JaYChY6Rhv5f++v7pdBKyEVWu2IV9PdA9ORVOptGY=;
 b=rvLsYs/+xIAilhLkydmIRQSDk+4Ty4kELavuqVWIEHCIvRz67Lt4vcR4bgK4lzEuE+/uaEq3VVYjRSAZAiMovnfdeKMEuSlPhUB7f7Sh91S1crdjBs8MYd+rLGfgHq6xnvojmpIxe10Fw+ONDnigvmLs5rswrjntUyGsITgZt2U=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 18:48:05 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:48:04 +0000
Message-ID: <56b1ce86-5e77-423f-8b55-a23bd201493d@oracle.com>
Date: Thu, 17 Apr 2025 14:48:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, armbru@redhat.com,
 miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
 <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
 <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
 <07dfb619-d563-4735-ba39-6ff4561d368b@oracle.com>
 <8e48b403-6f30-415d-b8e1-30fc772f1d7d@linaro.org>
 <a7240b57-6f86-4172-9607-7324dd1b13a3@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <a7240b57-6f86-4172-9607-7324dd1b13a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:408:20::25) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ba0ff5-62a8-42e2-5303-08dd7de0631b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVZza2srVjE2OEhXdjBKa2FCM1pFd280YzBSZytqRFV1azF1ZjBocU0wdU9w?=
 =?utf-8?B?VEp6SlNOUWU5WFduWFZlL1B6ZDVmbks2OVphLzF1V2JrRE5XWWIzQ0FnU3JN?=
 =?utf-8?B?YzNIMjlhcVJRcE82S1VCc1FVbE9XUjJDaFI3WHpiVzcxb3BxZVBWdEd1ZCtT?=
 =?utf-8?B?WVdGUXRBMGxxMlR3NkdzMlFiZzhOaFFJMFZRM0NaQllIU0p3Z0Z2U3BtMWpw?=
 =?utf-8?B?WXhTbVc3bUNPUzZQZjczOUtKdlZCZzNEMjhZcWpFdHE1YlA1NjNuWVV2eUda?=
 =?utf-8?B?UUMwWG0zamV4dGFxVEl1dE1NMGprRysrMDNwUlY0SlZoYU1uRUxueDdIcElX?=
 =?utf-8?B?bEJITE9RU2xZRWlVS0FrOTAzRGpWd0pJQkhROVZpL2ZtUk5sRlpOZW8rSDVC?=
 =?utf-8?B?VHFGQm1vOVFhVnFJLzFHSTBKTDQyZjFvRkVaNEtBaFVxU1VuL2w3TUhaVTJu?=
 =?utf-8?B?bWxUTXF0Y0RkMmd5TkVpRVhuUUx3V0FyMk45VS9hRUs5N3Y2YldObllVM0Rh?=
 =?utf-8?B?bWY2dllBSW9DbFFNTTB0NndyL0RoU3RyUXhLQkxMeDUxT3VydytGbUtnSEtJ?=
 =?utf-8?B?b2haanFubXdnRDdmbFRLVld6OHk4RGZVNkR5RE04SUJmbW5xd3BxQlN1c2d1?=
 =?utf-8?B?eWdvMGJtdC8zT0QzaVFzS083ZWY4SC9oemZVV1Q2SEJ6OUNnMmJ1akQxdWJu?=
 =?utf-8?B?Z0dHWjBHWm15MHRMaEh4MTBFSis0UVM3ODJMb2kzUC9hQmlOdkw2S29EcDVG?=
 =?utf-8?B?dFMxckZMdGdocHUxNU51VlRTbndBMTQwOTV5Z1AxbnZJOHlNeWpnbnhvOVFx?=
 =?utf-8?B?Q0JRUVFLV3B1ay9oRzRRQzJwZXpzbm40SUw1SDJnbSttRjFNaEZPd3BQbTNH?=
 =?utf-8?B?OERZY2s0ZjN2eW9HTEpkZnYzczUvR1lrRTgxU0VCV0xEaUcyNWtRWTNPL1Zs?=
 =?utf-8?B?T3JzeUJvZFZidWUvL0dIQi9sNkJIYW4wWnVMblFJS2tLQmhMbjREeUYyTGFR?=
 =?utf-8?B?MEgwNFNTMnZWbVVJN2Joa1craSt4UUFmOWxMMWpaR1o3Z3pVTysrTTEvSGw2?=
 =?utf-8?B?ZThlRVVBdnYyL3owOFFTMEpDRGR2ODJveGV6dWhaRmtLSlJUK3lhWWZqbWtO?=
 =?utf-8?B?UFBjR2NEUE9HNUFLRm80Z1l6ejArVkhwSldmVmo0R3g5L3ZNL1ozdjkzdTlk?=
 =?utf-8?B?OE1hZ25aSDh4WSt2QXpKWWlrRFlPT1RqUldQQmRYQ1pYVkZWYmJlRE1mZXBD?=
 =?utf-8?B?MzhBQWdQTHhKZHJJL09YZWFneWxNM0E1Z3hNOHB2a3RvaUVPTU5PQkFMRmtH?=
 =?utf-8?B?dTVPNm5SVUpUc1ZCNHhDRm40cnVJSW1kMHlGS0xXdzh1Z1ZnT2dlM1dYRVhI?=
 =?utf-8?B?L1JLdVdzMzBLR1A3N29WNmp5bGtyRGgzblczUGc2TUVnMTVNMHdmUGpja2ts?=
 =?utf-8?B?Vm90ODc0SVNsRjc4K2tnK1d5MTd3M3Z6cE84OGQ4THl1Y3lMUE1xRkpDMGhQ?=
 =?utf-8?B?STVBbnFpT3E5R1dFQU1GRlk0WXM0dzUzbnZ2UTVtUkY1TitYTjlXeEUrdHVp?=
 =?utf-8?B?b05TNEJSZHdYTlJrZW11NjVEd3R4d3NGYUFCNWRJWVNCOFlIUVBCaExpVDRH?=
 =?utf-8?B?QXdmSkZyNlprU1pTSGhPcFVtd0RMYmpUaUQvaUsyS2pHZWQ1dzRCd1owME8w?=
 =?utf-8?B?bm05R2p3aGhjOHkrRTcxVVkrTHR6ZU5qTkk2bmJQR2V0MERjZExWK2prS3R2?=
 =?utf-8?B?TDFKVWdOclgyRmExdlViVWRkK2NJVThiTGd0b09WSFY0LzJEaEJJeFdaTkJt?=
 =?utf-8?B?ODMzZTRhclR1VVY4R1NSaWxjdG5rTnFLdFNzQ0pjQ0hnVThrVy9nL2FhdWhV?=
 =?utf-8?B?V0N6ZGpBc3BnTkpFVjRFSjF5bEpnaElpL2hQQkx1THM2R0hzQUdDVVFXeDI1?=
 =?utf-8?Q?Epl/Etrpnqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRnZWVtY1JraFllMWgvN1BpQ2M1SHYreG4xNWdrSVZMYWJ4TVJ3Qkc2bUE2?=
 =?utf-8?B?MUxrVU5YMGxCNzc1Y1pnd0tCdm1ST1dTZE5xQUd2RjdtZ3plRVBsSzBhdVQv?=
 =?utf-8?B?RGx4d0F3aDduKy90NjZoVHZkbk1DMGdvSlplU2xXZ0QwWlFKU0NmTlNEUERC?=
 =?utf-8?B?VUoxM1loV1FGbGo2RnozejI3anMrcFN3QVpUdUJ0blFRK2RzTk0zSitlTTRK?=
 =?utf-8?B?bWVzcWgxYVI4S29KMHREamk2ZDdjWW5PZVYyVUJPU3lKVnpMQUtJaGNhejVI?=
 =?utf-8?B?alZDK0hxNk56bGFFS3ZkbXBNUE0wS3NVdzRGR1NIZ3oraEQ0a0tmM0ZlSndn?=
 =?utf-8?B?b0I0ajJWOTZKdVJOS2tqR1RWakdaT3pFbXJaRjRENHY2Mm5JR2NUWW52dHhn?=
 =?utf-8?B?T1NiSDNkbDNXVW03MENOM05waW9RZmE3dmJoZkU0STBLcUFERlAyRzE5ZzZs?=
 =?utf-8?B?allyWUVWcytMVDJ2ekRTMUdoanF0QzJ6TWJyRXJLeGN4N1VHSXZ0ZGp6dWM0?=
 =?utf-8?B?WkRzUFc3N2xnOW1KNDhVbGpFcWxZb1JGNEJ6eTZrSnhXL2J5Wm1xNThYZmpX?=
 =?utf-8?B?OHZrUWV6cXhYT1VPRW5TbmdETFFqTG5sdVR6bUVIZEhuWWZib2hZNFhYUnRm?=
 =?utf-8?B?clhGOGpJWlNZWUhBTzN4bzZKRTNsSnBOSEo4Q0RUWmVCaWVRVE5lMVIxM1ZH?=
 =?utf-8?B?d3pPUXhzSmtrYUY5L2lMSTdNRHZsOTYra1FGdGx3aFJQd0U4cEJXMDNZL3NI?=
 =?utf-8?B?VUVmRUJCQjBtRzRHSE1hNlpDaW92UXFYRENaekFWT0dKbW5xaG56d0ErZ3cw?=
 =?utf-8?B?dVJiMVNRdTlubW0ydFlKUnA4UWtkeE1mSlcvMVVZc0xkdGJhTVNQQTJlTm14?=
 =?utf-8?B?akY4ZmN5Nm5xQWJKRXJxZ2svOU1HNXhqNmY3WGF4SjVlWloyay9vakhReGJa?=
 =?utf-8?B?cTU5bVAwekxGNkpmMEYzc256eHZpaWhXTVJ1S0VnNFV4dXMzLzdOL1hKY2x2?=
 =?utf-8?B?c0FXTUlFNTFOeE5tMG9MSVI3Wkw5ZUJETVJ0NGtDbmM2dlAvQk9MZmx0a0FU?=
 =?utf-8?B?eXlmOFNqR0ZybUZLNjhjUzZhQk9ROHo2RjNPK2JPUFlOeWVIaDQ1UGx2L0ZY?=
 =?utf-8?B?bEFYSThMb2plZW5CNDBKVnc0bU9pU1d3RmVHRXNpcTZjekNUaWZEcHp1Vmxz?=
 =?utf-8?B?ZFY0azFETThtV0NDRXNXeUp6N3dWNHFnYUxyanRPYThianYzMUJIdFM4V0Rv?=
 =?utf-8?B?LzhUS0Q4Si9oQ0NzaVRvQm1DZVdhRThTWGZ1NVEyQUhYc3pHS1dVVU44bWRP?=
 =?utf-8?B?SmJDUUFKeHZZbzlRUXRpRnN3QklROW5ONnFoWUtTTE5HSmg2emxOQXBtSE9r?=
 =?utf-8?B?SXh4dW5ZeXMxc0kvUjV6RzYreURWaURKemFsUVkwT1duY2Q0eVNSUjhWK1hj?=
 =?utf-8?B?RVQ5cjFnVWNYbE1sLytsMWh2ZHpaUjhjajE5QzlTZDJDNnJBZDV2YUE4aXNI?=
 =?utf-8?B?K1RQdWs2d09RSDJ0NkFMdkNkRXdPbTFGSlBLaTB5NkEvSGdKUUMwZGVYNkFN?=
 =?utf-8?B?YSt5YlVjajFWMUhETmNWYjltYkJOVHQ0T01HNjJjUTlUc2pXaDA0VHA4UXZq?=
 =?utf-8?B?R2ZrWmFNTXdKd0ZxbXpZby9VL09CTHF5MlJsOXZBTm02YUNZWVZPVnB2VVdQ?=
 =?utf-8?B?TnNoNDRiSDliZU1wUzdPNTFWVWt0Y1pqOHRaRDhWYWpJZGVLblhsaU53NUI5?=
 =?utf-8?B?TmppdWY1L283MkFJV1JpamkxOEJuWHBFYTR3SFlHSEdrQ3pCK1NLRXZnT3JK?=
 =?utf-8?B?dHJ0U2lndW9GTU5xQ2RyR1djNDRZT1RzbmxuMEZ4TzRKdnRBZVNxdWwyL3cx?=
 =?utf-8?B?UWlqa1J6eElMUEw3aHdpaEY3VGJqcVY3SmcrM2dPTGZUUHBhaTJuZ2Y1L3Qy?=
 =?utf-8?B?bkNwSDQrK2lXRVBkNDJWejlxN3hqYnFRSnR1TCtHVWQ4aEh4MkV3OW5TMHMr?=
 =?utf-8?B?VnhPdXVhZW5VdnpqMnRITTlWZjJ3S294MkFkZEtiYVpHRzRmWFdieFQ3V05I?=
 =?utf-8?B?Wjd6bnJKSTJGVzFXZ3ZWZTJybW10cHdLNVNyeEJQZmljS2l3ek5TTzBnNGlx?=
 =?utf-8?Q?iNGvY70+tMZeyp34LOr46zkx8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vQDJhRytStvlWwbq/w1xPeVq/bfYmvyWQyWEpXtq9mjnXpTlI4oFubjFQamJvgQJS2d0u8mxPiw2l/ooj3VTL54dn0MB1+ooFbcrKgvkOmVXvgEWzhz67AOVQjxcffETE4Qmcj7te5AkIBiO7EIddAWN2RMeTlwSbUDKdmrI6qKN+OLIlzzqHm8eO+bvroeacNjeRmYD4HJinaBSbUTvMTZ4R/42CR84l7RatN2FxIpug6NN6gqOUlGfaDzs6uvvrxCQ5+ZzNr56YBXXRsXINQEX4sYa9viUBYijnOL8fHvw/7UWqq2CVYIUFY/6tdla6+OmlPMv9jU4QaQWM8FJTzRT6pxHga+OMf6KKrQD0OzLcVwXZRYYNs3PjQR0m9sQySpyUDgcpKYfmP4v+I2gP8kXGCAazviZ1BgMhPR2fRyLx8Xdn4CwO5E3vYvQI03bKImMECfj34500Ur6WBoLhf3JGOUoTuoqBLHK1oqE3hX48yFqZOXOtN7MH7QASPIIrp2UJHX7ZwepgsFOg4WiLIkiDrDlXkMyC3Tf917ZlQJ9KGe7SUNOEW7RyAD3V6WhF5nqtuv+X8VNDXRAm/k7FPOjztJIeN/nYoOJMHy0Pos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba0ff5-62a8-42e2-5303-08dd7de0631b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:48:04.7930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Msqenhxv1A2RYdU7VSS96eZDnmNel0I8j5W6167lW2hlL2RZHWaMimsDMwfXb8/yuSwS8mwq4PhfmG1wo2xRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170138
X-Proofpoint-GUID: xTLLZGFi5bcjrH3II1X3pIwRGf61Fu-H
X-Proofpoint-ORIG-GUID: xTLLZGFi5bcjrH3II1X3pIwRGf61Fu-H
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:32 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/16/25 03:24, Philippe Mathieu-Daudé wrote:
>> On 15/4/25 23:48, Annie Li wrote:
>>>
>>> On 4/15/2025 11:29 AM, Philippe Mathieu-Daudé wrote:
>>>> Hi Annie,
>>>>
>>>> On 15/4/25 03:24, Annie Li wrote:
>>>>>
>>>>> On 4/14/2025 11:18 AM, Alex Bennée wrote:
>>>>>> Annie Li <annie.li@oracle.com> writes:
>>>>>>
>>>>>>> The GPE event is triggered to notify x86 guest to suppend
>>>>>>> itself. The function acpi_send_sleep_event will also
>>>>>>> trigger GED events on HW-reduced systems where ACPI GED
>>>>>>> sleep event is supported.
>>>>>>>
>>>>>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>>>>>> ---
>>>>>>>   hw/acpi/core.c                       | 10 ++++++++++
>>>>>>>   include/hw/acpi/acpi.h               |  1 +
>>>>>>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>>>>>>   3 files changed, 12 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>>>>> index 58f8964e13..00a9d226f0 100644
>>>>>>> --- a/hw/acpi/core.c
>>>>>>> +++ b/hw/acpi/core.c
>>>>>>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>>>>>>       return -1;
>>>>>>>   }
>>>>>>> +void acpi_send_sleep_event(void)
>>>>>>> +{
>>>>>>> +    Object *obj = object_resolve_path_type("", 
>>>>>>> TYPE_ACPI_DEVICE_IF,
>>>>>>> NULL);
>>>>>> Is it a fair assumption there will only ever be one QOM object that
>>>>>> provides the TYPE_ACPI_DEVICE_IF interface on a system?
>>>>>
>>>>> I supposed it was, but I might be wrong(seeing some classes have 
>>>>> the same interface). Please correct me if I've missed something, 
>>>>> thank you!
>>>>
>>>>     /**
>>>>      * object_resolve_path_type:
>>>>      * @path: the path to resolve
>>>>      * @typename: the type to look for.
>>>>      * @ambiguous: (out) (optional): location to store whether the
>>>>      *             lookup failed because it was ambiguous, or %NULL.
>>>>      *             Set to %false on success.
>>>>
>>>> Since you use ambiguous=NULL, your code will only set %obj if there
>>>> is exactly ONE device implementing the ACPI_DEVICE interface created.
>>>>
>>>> So far IIUC nothing forbids creating multiple ones, so if you expect
>>>> only one, you should add code to handle the "2 or more" case. Or at
>>>> least add a comment.
>>> Actually, there is only one QOM object here.
>>> There are 3 classes involves with TYPE_ACPI_DEVICE_IF interface.
>>> PC, Q35, GED.
>>> For x86 system, the PC or Q35 machine doesn't use GED event, instead,
>>> it sends the GPE event.
>>> For microvm/ARM/virt system, GED device is used, its own 
>>> TYPE_ACPI_DEVICE_IF
>>> is involved.
>>> All these objects do not exist at the same time, so it is safe to 
>>> assume only one QOM
>>> object exists here.
>>
>> I agree this is the case as of today, but I'm not sure about tomorrow.
>> AFAICT nothing prohibit instanciating more than 1 type implementing
>> TYPE_ACPI_DEVICE_IF.
>>
>> Anyway we are just trying to be more cautious here; up to the
>> maintainer.
>
> Annie, very soon probably the GPEX device will use the 
> TYPE_ACPI_DEVICE_IF as well.
> GPEX is used in Arm machines (like "virt") and due to the support for 
> ACPI PCI hotplug,
> which needs to be routed through the PCIe controller's hotplug 
> handlers and the ACPI pcihp
> device before the hotplug event is finally delivered to the OS via the 
> GED device, it also
> will use this ACPI interface.
Thanks for the info.
>
> I can think of something when adding the ACPI PCI hotplug support on 
> machine with GPEX,
> but even for future cases, could you please add at least a check for 
> the ambiguity and
> assert for no ambiguity here?
Sure, will do the change similar to the following,
+bool ambiguous;
+Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, 
&ambiguous);
+assert(!ambiguous);
>
> I suspect the only case we can have an ambiguity is when we have a 
> device that
> needs to do something more complex and then deliver an event via GED, 
> so specifically
> here for the sleep button I think it's ok to, in case of ambiguity, 
> select the GED
> device by default.

Nod

Thanks

Annie

>
>
> Cheers,
> Gustavo

