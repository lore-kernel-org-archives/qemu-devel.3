Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22630C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYVgb-0007kb-C4; Thu, 16 Jan 2025 14:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYVgZ-0007jz-32
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:37:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYVgX-0003mS-35
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:37:46 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GJDCbm027261;
 Thu, 16 Jan 2025 19:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=bXFh0DpXEjhigs942vLG8XX29Y9iSeAzEL2DTDEXgf4=; b=
 b3UG3bpZD/srwO7UMzXO6hc4233iON7d4uQ4hb1DQfvD9qT65bpIkx3/Prd4xSSi
 j16IwE9G9YN14bzDobwIJy/Fn5U6E2gZz1QxbI5oGil7Ws9ukUOmhl6DGuG8TrPj
 ReC57gn4q8WfEM5wYXmo2pVFXDdx4qmCyHNlnLwM/UPv2fFXiS3IDDm0H0Pz2an8
 ytwS944Kn8KRT1w0zGJbAMPsKqDCIE7XNdGek9hjWnzaed8Gzi6ZjoUJjEAiGUzE
 Sg2aFE10w4R0ITEU08ku5zEp4NU0t8HohbEyYJvaNu3cl8smImne1dDjYwjf2kJ5
 BG6ESBVQCEWkQiK2DCPCgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 447830g1ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 19:37:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50GI5tYY020405; Thu, 16 Jan 2025 19:37:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3hkucc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 19:37:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebOcK0aeRCpGhgunkGaehehkFu5tG3VPaUvqHZ/4GkNjDne1nUoFX9nYMRbd/OMBWk4Xn9Xq695qbjiFFLzttlWlwwMY/iH76se6003snhIjPCss1PwhJmNr8ZCCU1kljQpytNGodyCeKEfu6FUDopmiJVBc0KrhHpXAZHP/qzpJbdoHX+ccXgxUb9WMlJoty1WHh381QrRSqzHlIppbOf8NYXx+6V8fCEL7+Iryfc56mRy9vKfhlL+KIO9r1N+26D0VA+C4UFvBSDgRosRGgN4E0TkypSCKD/NReiKCD+8u2XviMApB5T65QppWmPW9Y6TzmI1DpP7xQVn1rf4/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXFh0DpXEjhigs942vLG8XX29Y9iSeAzEL2DTDEXgf4=;
 b=MS39F4OLnU0rnGNEPAEl04xRj0NRhflS+sBSLwaZxBNWOGsi7EQhwqzWKXo0EpLfZvj5ds4y9kK/YFkWTlTKzUuYgyQwL2ug89yw9Kx6Vmbrx5u2xI7k6Ap58V6BLHP4cEJzp+40luI0gv2yHkvoWVAmRbevGV8GLEXsbdDUyPBdG92YnyjbN37uFZTw/GsaSfVmE3uZglW94uPA2tmx17A3ZKtOU66TiLWOGAIWZKH9rGIleuM/EK3lvMPchlA66JzbjXegzQRgHaWBWmIslfvhDtx3TgJ2LDszDN3s5NYcvvyZmvUWobvPBL19sPuz3Jmorn5RiCkSBk4IC9LhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXFh0DpXEjhigs942vLG8XX29Y9iSeAzEL2DTDEXgf4=;
 b=GSxVACQ7mMtxDvzRCS3ShIcyfF2RAi4SRnG33+E35aR29ttZror1mF283kOSfkP3gOSXmBY9czkxMJxDxvIL9bX3+J//co8pU9Dk/Cr3eK4wHL8dlHpimMMOEUTjnJ02X3/sUnbY8O8li/5riIWlIW3XSOO6CYsvn8ak+P8SRFw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 19:37:36 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:37:36 +0000
Message-ID: <fe25b4b6-fd39-4c2a-a104-343b59b405b6@oracle.com>
Date: Thu, 16 Jan 2025 14:37:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 23/24] migration-test: cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-24-git-send-email-steven.sistare@oracle.com>
 <8734hifujq.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <8734hifujq.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:408:f6::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: af3604e7-bff1-490f-473b-08dd36653adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFhicDlWR21NZUdhSDNmcTQrQkE5eHJnKy9vUTFsbVY0RHM1MkM5cFBBVnQ3?=
 =?utf-8?B?UG9SQmdkRjdIMlBraFlRSHhHUUhRRGpsRUxPa2VROXNOYTR4ZXp5OFJ6UHRI?=
 =?utf-8?B?Wk0vNm1PZktDMER1TTRPeVZxaEtmS3Y1TG5icUkrc1JxNHZyT2ZnUStha1h1?=
 =?utf-8?B?WGxpN2N6WWgxVURRcGYvMTV6QTMzTnA1Zndzb2Q0OHhhc0UxY1k5MzE4bjFy?=
 =?utf-8?B?Yk50TC92SzFBd1A3eWs2QkN3ZDV0Rjl0VmlucTVTd0EwWXpUVjl1aWJDUVBB?=
 =?utf-8?B?WjIra040Q0RqaDNHMWJIeFVtV0FtRVNHQmttbkhKNXNnbHBWYk0yUTluVURH?=
 =?utf-8?B?cm9QODFiV1oveUNpRUtIV0RYVDhoWjVXUXVSVHdQSG1Oa1lwU3NPS0dTU3VU?=
 =?utf-8?B?elk3VGEwNlJ0MFFCaXRDWDdWSTk3L3oydVdxQVJOVWExKzQreGw1aElQTWZI?=
 =?utf-8?B?Sk5nSGN5MWVscWtuTU5keFIzOFY5Q1BJQ2xIdGt2SjdwMTF4aG1hMEJtZjda?=
 =?utf-8?B?M2hBOWN5amFVK3JQTjNTczJ3OVMyMm9qU3J5bkhYWHZxVlpxZUhwMjlISWUy?=
 =?utf-8?B?MldWNGliNWVSaVZuTVZ1MXE2eGwwNXJyMjkwMU1GcVJocUtXOGVIb1pCVjA1?=
 =?utf-8?B?WkZlRXRYbWNabXZSKzFQQTNsVGlWWW03UDF6aUsrMTExVW53YTMwS2J3Rm9N?=
 =?utf-8?B?WGd6eDUxN3FxcG5MbXdFVW1WYU1NeHhtNkdtYlpKQUhWWnh1SEYvb0NQZVZs?=
 =?utf-8?B?MDVxRkFrR1pDU21ZWUVmSUhXa1dickxUeFdYLzBZN2hQbzlpYnorVHQ3WTBn?=
 =?utf-8?B?dWZudGk0RUdLVGFHUU12V2N1NE85SG9xeTdiOVAyZWhSRG9ZTDRMdmU5N0RR?=
 =?utf-8?B?aEpaNElYSkpHNFoxUXd5cCtCQjMvTS9OSktPREgwUFpDVVA1Y1hTblB5bGVN?=
 =?utf-8?B?a3dXYTgvak9rVUhheEZ2ZTVvcGw5Y2xsU0xUeDV5SGRHelFhSnZ5ZzUvdXJ4?=
 =?utf-8?B?YVhqZmUzRW04eklaVmlXMlQvaTgrWnVDWDd3eVNYWTdvblMrTDhiOWpTdWFH?=
 =?utf-8?B?S2gzZDh5REd5S1VxYXdTb0o2THA5b3lxZ1RxY2FyZi80L2t4M3J3RFNnUEdr?=
 =?utf-8?B?ZnhmaEFaZThWQ2EwYjdiSkNYNHZRMUxzcXVtMkFWL01RQ2pNSkxFSEhxRGhN?=
 =?utf-8?B?anNDdUlBTTd0R2hRc3F0U3JXNG9VZFMvaXRGWTB3N1ZkVml2aVdhLzU4UXkv?=
 =?utf-8?B?U2c4SzdIOTNEdjExNW1qK21iSE05Uml3TnBWY25vWkYvOHRSZXdmNjhWZG83?=
 =?utf-8?B?RFlpTlRpejJsODZvd1U2TmF0K01aQWkxTHQ3MGxiN09ibENlNW42czVSTWtE?=
 =?utf-8?B?UFVnYkFidG45UlNZaWpFcXFTdEVwd2Nnd0N0cE1sakVoWlRPeTkwbFFER0ZO?=
 =?utf-8?B?UkYydUE4d1BrcEUwMS9HZFUwcXhlaHVHRG9xbVZYZHVhcU9vQzgxZGFtTEdK?=
 =?utf-8?B?RFErUFpuWlNtOVZkNGJ6cWlXV1I3WHBsUFVSdmF4VDFwdEFGNlpKa2hmRmRh?=
 =?utf-8?B?cjFsRC80dVh1M2pJelZxbGZXUjZleDRYRU9MNGd1Q0JrU3d0eEdVNXFCb21W?=
 =?utf-8?B?VFdvQTRocFAvN2ZCRTZXMFhMUS96eUhFNGVNQXZYakl5K3EwaFQ2RHJQS2xp?=
 =?utf-8?B?aVR6TzdwYlpWYVBDWXM4S0ltODhQaEs2RW9nVWpiZUMydzBtVW93V0JKYmk0?=
 =?utf-8?B?TDFsVEtBTFNMQXdKWTAwL2Q5RDkxWVNnS0FZeGI1d0xranU4SEJVL1hlWEdP?=
 =?utf-8?B?aURnWDZDTndjT1M1MGVFTUN5SmFkNklqU2lMQXk1ZTdMdTVMclVQTnlseENx?=
 =?utf-8?Q?1P0ZCoSeJG8oo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdUaGdpL2lHS2Z3N2RtUk56MmlVdVpqUUhxWFQxQ0E3NE5US2szZ0N2SWR3?=
 =?utf-8?B?VEdrbUlPTUxsTU9Fd2E2MWtMZ0JURUxlUkNJb3lUU24rNThoS0NPclRldFVz?=
 =?utf-8?B?WGJrSUhxdndJN3BMeUZwcFV4K3pWbFk1eXhnSmJiaXY4OEpnV1FtYnU0MnZU?=
 =?utf-8?B?NUNMNTR3b3c0dnFRU1ZYcy9zUzZPQVZkQmlCSkdIbUN3MjkrT3REMVFSRVo5?=
 =?utf-8?B?cE8vYnVlSGRoNlBsNVFvTzVuM3ZhaHUwSHVwL1BDTmIwL2NCcmdWWHJIV2hD?=
 =?utf-8?B?OGs3U1VWQ3B6ZWpabi8xNFptZS9ldkZWbDhaUkZVMmlOTjlHcEwwQ3MzcjdE?=
 =?utf-8?B?MlBIV0RPT0MzNEdrV2RFRzdsOVN3dE5PYXhYTHJYWXVFeVZMRnNPclZWQ1FM?=
 =?utf-8?B?ZndCdGdXZDRxRzhjekl1dGRTa3ZkU0k1TVFlL0JubzRlM093UE45QkN6MEJF?=
 =?utf-8?B?V3YrWEI0RXdHdVBxeUJPVTkzaXEwZXF4SytMaDdWUEE1SXF6ZXNvbU9XdFRk?=
 =?utf-8?B?WXNpWWtKd255Mld1RnBCaG8wUHFaWml4aEszQmltWVpWQUY2elpCcy9BdGZC?=
 =?utf-8?B?aUVZY3g5NEZ0ZUFtQXl3VVozN0o4SC9HYndwTG9BZmVyenRDbjNVUlM2eTUv?=
 =?utf-8?B?S3dwSXh5ZXdMNGl2WGVLZDNMbncwVnRxZlJrNml1eWVZNW54N1JYbVVSdmtD?=
 =?utf-8?B?ZVhBMVd0aGdZWGdzQUlFMGRmdzM1MzkxS0N4M3p0RWp4amZsMXFIeitlS1hT?=
 =?utf-8?B?WVF6NnJlb2U3Z01IOUlTTUdqeFltT29KdTB2bU5KVnRhVFFoeEUxcTV1cVAw?=
 =?utf-8?B?WlQwclk1M2E1alZEd3A4NGZmbldHZzVaYVNIYml1SE1mVHVtckVXRVE4UXlT?=
 =?utf-8?B?RlQxSlJvQjIyOGdXUENGUXRPb0VyelVPdWI1Qk1WZW1qZHlLSmpncjM2TWRr?=
 =?utf-8?B?S1VIS1hmY0RwSElyNTMrblExdzAwL2tMdHVBbTRXdVI4OERpajAxeGNVNStN?=
 =?utf-8?B?SEtVNzUya0t1NE92dWRwdGZ5WW91NWU4cm4vUUJZZmJFWE9YY1Fxdi9ZMDU5?=
 =?utf-8?B?KzVLemNPaE9HdDA5SFM2ampwOGt6bXkwOXJjY3lLYjV6T1NxdXlPK25nU3RP?=
 =?utf-8?B?a0hmcnQ0OE5QZkdJTk5LcEFMY3YzMlZFejNEZ2xnYnRrcGhpUlgyVkdGUVMv?=
 =?utf-8?B?dW5xczZoZ1BiZ1IxcmxxQzc5aDk0ckFtc21wS2pjdmFyQmRyU0xYWEhiZ0V0?=
 =?utf-8?B?UTg2TldMZUI4WDh6NDB0ZzcvQVRFR3Q3QjNDZ05GWllKWFE5M3ZnQng0bFg1?=
 =?utf-8?B?ZEJONTQ5Sm9HUUZVZFhCYS9jQkxBNUZCb2pOOTBLUVczaHpNd09VWGtDcU1w?=
 =?utf-8?B?TnZJejVyNmNrcWdqV3dEWiszbG4wbWtuYVEwemRBTy9vL0dSZkdmbWdTd0U5?=
 =?utf-8?B?YmFiMDZJV0p2NmdCaVhnTnZLeE8yU0ZCNTZ3UWRWQmZyZVE1Mk01M2tSZ0dW?=
 =?utf-8?B?YWVVOVRWamlNKzVNMnhWNk5IZTNnb2JIL0RQdW85b2dDOVJOdnJjcVVhSE45?=
 =?utf-8?B?MXNCRWtiMmNLOGVYRkVXUElEei93UWZ1OW5oUjkvWWV3Y0J0SUh2MVZYQ09M?=
 =?utf-8?B?MHErc0ZFb3NhcTZaMEpPcUhnM1YwZmRJVjhpU3Z2eEpySDFLbXFFUXR0SFFD?=
 =?utf-8?B?RUE3ZWtOUlMydnl6aWw0SlJBQzQyRWdHbXNKaU9MNkVvVkVnL2xWd2JON0Vs?=
 =?utf-8?B?YXdrMGI4ZEV5NFI3aTRhSkkyako1aTVIbkRDWVB5VU1DRDZKd2Z5eWdXYVBG?=
 =?utf-8?B?MVRGalNJbWVxS1hPbjUzZEQ1VUIyemhnRzJtYm5BWTVYWnpaUXV6dWtOcmw0?=
 =?utf-8?B?T2REMjRIS21qMC8raExUTGhvMFovTFZhMkt1U3IwSkNkTjVkOXdKRG5wb3lI?=
 =?utf-8?B?cnp6dndqdlU3TXhpZ24xOG9rQmVGdzVDWUR6SHgwaDF0V2g5d3d5ajltb0ZL?=
 =?utf-8?B?bXlKb0FoK3BCMFBjWVdZTFcrUWRBdWFacU1TcUxFREpkK2ozdUFJRzVsVDF0?=
 =?utf-8?B?NUZuUmF4WCtCL2x0QVJEU1dDMlQwandHUlJER1k5bjlsUW9VdHJXN3RTZExw?=
 =?utf-8?B?L1VhdVgzSFYxTlM5WUFNQVZWcmt4WXZoQnBEbEdabkpwc2h2VXJ0SnJXaWh5?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ph/expfcKhXQRnbyMXB2cL6YsqaQjmgc48MPzsncfnxDaJn3kd0xpw5BMCI1Ac1NeTSCGDQ4KdhzpxCGiSTVIdj7ZD+rbGwMdC1n9n3ak+UjZTq+DmtVck7/jxVfd5jCfIbRPcgJCDHuSdL8X2J85yw/NJfEEeGkF+suQPnihnt72LAySejmO71kVL2Bl+TJVnVHH0QfLiPD9qFOjh293i6mHHX8xj5aZq5W+0wINNN3GgaARuUolDmI86B6mUOYxz50s5q0LUANP0E69PFedj9rPRajai4meye2bB9Yt9eW3soJeVUiGaMi0lMTunGPZ0MWUfx+7dOnC82dUEpkrpFloF7FXo9BDW9hJAj6IaMNNXy4WVMYRrujRhyUrG8Iax3gV8bBegm3NraiNvcX0YAIiuNAPaBsUeC3D10j4IsyCKurGrJTJKt2OEfexGRmarGz/rjJ5ofZQ7cKu1j51i3lCVjK3r/aUlhFWCgaV7JrBhVXhLlBGvAXu/Uw+AI1HOm+QjGXvtkQjeZlrsdty683VeOKrnhAUuFbRlgX2xEUSQmfl4+sI7CGKgvWhWeUCesI+DoLNiKzb03pXYdcwNLxQgwUUUZqu7ufEXQS4YE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3604e7-bff1-490f-473b-08dd36653adc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:37:36.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Gn2DvoiE0FFkWwIf9rf5vY5oLgkmvyM2U46Djn+wPGkN212PlsjTFhm4gQ1BWFtEsHfvPh71a6Bl9A3NnsY3ofviBwhRzn9wKuZTOxHt5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160144
X-Proofpoint-GUID: DM5uFBwC9fDOibO_8-3EnDYql8jJTHY2
X-Proofpoint-ORIG-GUID: DM5uFBwC9fDOibO_8-3EnDYql8jJTHY2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/16/2025 2:06 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
[...]
>> +    /*
>> +     * The cpr channel must be included in outgoing channels, but not in
>> +     * migrate-incoming channels.
>> +     */
>>       if (args->connect_channels) {
>> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>>           out_channels = qobject_from_json(args->connect_channels, &error_abort);
>> +
>> +        if (args->cpr_channel) {
>> +            QList *channels_list = qobject_to(QList, out_channels);
>> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
>> +
>> +            qlist_append(channels_list, obj);
>> +        }
>>       }
>>   
>>       if (args->result == MIG_TEST_QMP_ERROR) {
>> @@ -735,6 +751,9 @@ void test_precopy_common(MigrateCommon *args)
>>       if (args->start.defer_target_connect) {
>>           qtest_connect(to);
>>           qtest_qmp_handshake(to);
>> +        if (!strcmp(args->listen_uri, "defer")) {
>> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>> +        }
> 
> Paths that don't call migrate_incoming_qmp() never free
> in_channels. We'll need something like this, let me know if I can squash
> it in or you want to do it differently:
> 
> -- >8 --
>  From 62d60c39b3e5d38cac20241e63b9d023bd296d2f Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Thu, 16 Jan 2025 15:40:22 -0300
> Subject: [PATCH] fixup! migration-test: cpr-transfer
> 
> ---
>   tests/qtest/migration/framework.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 699bedae69..1d5918d922 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -753,9 +753,14 @@ void test_precopy_common(MigrateCommon *args)
>           qtest_qmp_handshake(to);
>           if (!strcmp(args->listen_uri, "defer")) {
>               migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
> +            in_channels = NULL;
>           }
>       }
>   
> +    if (in_channels) {
> +        qobject_unref(in_channels);
> +    }
> +
>       if (args->result != MIG_TEST_SUCCEED) {
>           bool allow_active = args->result == MIG_TEST_FAIL;
>           wait_for_migration_fail(from, allow_active);

Thank-you, though it would be more direct to avoid creating in_channels when
not needed:

     if (args->connect_channels) {
         if (args->start.defer_target_connect) {
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
         out_channels = qobject_from_json(args->connect_channels, &error_abort);

- Steve


