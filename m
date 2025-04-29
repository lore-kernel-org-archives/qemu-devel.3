Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A924C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9qwN-0005qF-I6; Tue, 29 Apr 2025 15:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9qvs-0005lQ-Te
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:48:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9qvq-0003yp-2c
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:47:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TIWI2c022449;
 Tue, 29 Apr 2025 19:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=26U+rbxU0CN8iDPSVqUo7YBJqIHYVlikLVuO/nK37E8=; b=
 QctRDWdOyfac/Q16/RfpqCLyLvcZYEAvptrhfgecEiRpfftK/fq6cwb4JIdmTDWf
 Dag714j80aGkigcT5IrvGqqEKzv9vsWeISbrMhrZTemfIE9U2O8YmGTEDiJKnpj+
 E+UineMRBFUfqP1T1gbT80vyZJR4EOs5LuECVunXjsMXXD49z7c6vQ2rtDg+Wihf
 szE84Ez7bS6rk+s6QNv9WYpzEJyM7W+Qp1nAGq5sRfzNsLzBu2/JxIh7gmf6zd1u
 gS8RRQV6dCdtv7Pf++ZPH2yefgu0zMw6m4O3H/cll+AGTR9XvSadfmzjk43tzTNr
 g26OUcJSNmf63lMyhbWkmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b44ng4yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 19:47:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53TI9x5o035400; Tue, 29 Apr 2025 19:47:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azlp17010002.outbound.protection.outlook.com [40.93.10.2])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxa4h3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 19:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT0tBxenT+96SxHrqV3NNTzgNsUe5OsPcQuE0q3v4NxBnYh11qgfKQHGSobZmBmmeXsCHcpHw3H6pPTKEP3hxKz7twfwgePL+OCu6CI7/2/uO2m0u5WFTrpje32w6dEhAaPAEeFv8tXyr7kM9OI2Krl5MCababPyhrBWxBWbzgVzE5GaIho7i7ruwZ1JWJGIF2Thn4NxvgfwMLHQ+bN6cOSNFrbrJ4rZXEn8Wzaj3OtL5Prx4TyAngxrjS2IUcKtXDnxHz6b78M9/1+G8TOOSC78N0Zxv83SMgrLTYxAiIxmI09VMo8lX4/ecp4KlPx1DtY+o0O3eOlnV6uMycLoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26U+rbxU0CN8iDPSVqUo7YBJqIHYVlikLVuO/nK37E8=;
 b=MvvL9R+OBxg8ke7QtzhGJsSy8uVdLImZ/N/rQ7/gl9+zCnKM6264lR0EY1Jwitmw0urxr4qW71Up8vnAPjlmOjLchoghQNLXCCWRckzPpsBMofyIqQdJW5lomTzoah5IQGJ23lNiM1Ix85Qnzh4peavEJHd3D34TdcTSCoeoW9qLZF2f3zG8+0Bjb/QiJN5rFeO+3iad61mrMPrHe/Baf+QTG0nyEVY5ISaOUuvgyKx/Kd4/672XqOz6WOl777jecPYJuE/WIevQ5zoPKlrxu8gcNigDCQhoFl7i04qLriYMFTS/J9m82fI29aCvGROMyqNMLUa+aHXoTKecGOCmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26U+rbxU0CN8iDPSVqUo7YBJqIHYVlikLVuO/nK37E8=;
 b=aslioq/VCsgc4yeyn0kJFyaKvgqKt60Nn/1Xmm51lXGHmU8FMplKynEb+QRRu/qlpelkAn7wxhpc/00o788wtHWIwSB7jK+BoFE0HbQvX7GeDJ70g8+l33txMnpgTW6XO2PJnetI8kioGweBF8c7t7fpadZpnKL61mMccEPi7MA=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SJ5PPF7113AF9D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Tue, 29 Apr
 2025 19:47:41 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 19:47:41 +0000
Message-ID: <0ba2cbba-33c2-47e1-adc4-d54184a2e0c8@oracle.com>
Date: Tue, 29 Apr 2025 15:47:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] amd_iommu: Sync shadow page tables on page
 invalidation
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-12-alejandro.j.jimenez@oracle.com>
 <4d766242-2060-4e30-b708-7cc5690732a9@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <4d766242-2060-4e30-b708-7cc5690732a9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SJ5PPF7113AF9D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eac1b22-df74-4fa8-7cfb-08dd8756b3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG1Iamc5bnNXS29XNWlUOGlITlNYaGVsVzRNWnBnSFF1dERLU1ozMXdVVHVN?=
 =?utf-8?B?L0thM1hhR3dTL0x2bEZMRUhGSzdSUHJLdHdDZmZESFJIcmNldVZQcnFWb1J2?=
 =?utf-8?B?S0pZZEloSWtaS25yaS96djU0SHhMWXZJWXJscVhIL2dnakpZeUxnZFQwMXlR?=
 =?utf-8?B?VVZTSVExZHVwcUs1dEtzTnI3ZUFtMk1kVGNiNkhvaDFuZUhPc25xRTJjb1Nz?=
 =?utf-8?B?amUwYmhSZENjT1ZaRlhsUDVLWWZuWUFQNkZkL214YTBldVlvV3BWRVcveUdT?=
 =?utf-8?B?REh6L21Fb2dPMXNsSWNkamJrRTllWDNHSyt1ZFU1Szd3VXNDMlh0QnNZT2Ju?=
 =?utf-8?B?bklJTTVUTUptV1pldW92ODd0NmZPbW9welJ0akRNWDM3d3F4MERKY3RxZGwz?=
 =?utf-8?B?QUFJVzQvdldMZnVudjBFOXZGbjdZbThINm90OWxYWW5OelZodFFqcktHUnVZ?=
 =?utf-8?B?RWxlVE5SRG5UTS9pUFFnSHhnZnZnSExIZVhZYmlaS1NnblpsRCt5alVHQUli?=
 =?utf-8?B?dWRNcWNYZTNqQ0FidU0zdVRJclhBSFJpNDhQRmc3WTY1cEZaK25taG5ad3ZQ?=
 =?utf-8?B?bDFmVEpNRVNPRWFPYjFUMWxqOTBUaEZMS290dmwwUGtSaXBEK242dDlydE9t?=
 =?utf-8?B?U0RkRG1sSmhKYTREeWNpSFFwOGd4cFYyT2NVT2gvMFF5M2lTdFcrUjZsRXov?=
 =?utf-8?B?RWVTNWV6ODdyTTEwZkMxOWNTN3ZQc0YwOFdxNWtyL1NVR1ZVcmhRL3V2Tjc3?=
 =?utf-8?B?MERWbEpEelVHWDJUcE9wUHdkTzBRV2RzZFlDTnp0djhTbEtTdXg2eDM4YzZ4?=
 =?utf-8?B?YkE3WWpmMFFlV2p5NTBsVksrZHVZRmZtK1laeGk1cHJEc01wUUVFTlh4ZGd0?=
 =?utf-8?B?VDdQQ2RTMnFXRU5UZkdwQ3N2NTJqQ1QwNndXSzFVUk02a2FiN084TWlabm44?=
 =?utf-8?B?dzFkcFJiTWZDWDlPcStwYjdxcXgvRTV1ck8wMzhlajJXaXBmbGkrYW5QNnha?=
 =?utf-8?B?RzdycXpmWWlxNXdrVkZ4SlpQZG0yMzUxVmFBdWY2eHE2SlBIQ2liLzFsckdI?=
 =?utf-8?B?WnpnNUhFdzBlbzgwRnlnM0JPRUdiS2xUMm00VEFoYlRXS0VySzluZGwydVlX?=
 =?utf-8?B?UE5EeUljQzJiSnJKR0pmelJnMysyN2NiME5lOVBkY0RsR3JiUU40NUw0Uk95?=
 =?utf-8?B?Z2x5eDN2MkI0ai81OUh0SlhVUEwxTHdPWmI5QUpxZ01UT1VFQzY4Q3Z3ZzJU?=
 =?utf-8?B?VksyRjdCZnFOYnR2U0M2empac1hOQm5WVm5mQnBncUV6WDc1dmg5YmJ4M0hH?=
 =?utf-8?B?ZG1SbTNidUg4dHIvWFhqVytNWnNYM1ZCRXEvSU45RFltcjRUdjFOdFpNd3pS?=
 =?utf-8?B?aEtsRURVK1lqc0QvMXR0dWNaU1pWRkI3NW5lZW5EbTFWdXJkSHVCN0d2S2lQ?=
 =?utf-8?B?V0wyRnhmcCtuSFFETlAyQU5FSnpGdTkwa0c5WmcwcW53TzdWdEJ2R2VIcXhM?=
 =?utf-8?B?UzU2d0VYS0ZjK2pSWTFxZGdrcUZXVGJRa081ZitPekh5Qk1uendFbFBLcjc0?=
 =?utf-8?B?SStRNHM0b2RERFVDcXVjV2ZBNE9vVGk1UzZwaVh5SnNBNHZhclFhTW9EZmNr?=
 =?utf-8?B?OHpqK0kraWpoR1I4SHdVc0ZKd3ZaT0ZIbDVjUHlKYnB0RmxxVncrRklzOWhm?=
 =?utf-8?B?cjQrb1lTbExydVkvcFFmNWVpM0YyRXI2QWpRY0NmWWExUW82dmpzMmFTUkE5?=
 =?utf-8?B?VHpCclN2UVBTQ2x2SGkwQ25OcmtST0dTdG1SRDlhTlFqZW4wTHA5c3gydmMv?=
 =?utf-8?B?djU5UDM3QVYxSm1sYWU3UCtHS2Zld2lJOGFaTHk0VGMwOHNGekhucU5LVE9o?=
 =?utf-8?Q?BO9fdZxY1L6zm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dlRFNjRHlrTnhBL242cDFmQktDV1R1Z3pmSThlUW1zS2hnT3FOTllNRTZC?=
 =?utf-8?B?NFlqMTZkaFdOUVpaSDBIN09EWGtwTVpjUVF4K3R1S25odGlMZGU5VWFHRTR3?=
 =?utf-8?B?WExZNzUrbW5IVW13RW5XeEFtK2w0SE5nRC9Lei9FdStjTURoVm1LOGtza0pM?=
 =?utf-8?B?QmdFZ3A3bCsrRnJXSEVnM3ZXM0NDbFcwY2NpWHFIYUQvdElMYUpJR1lUUUdo?=
 =?utf-8?B?VXdyK25kVHp5NGJvZHhSTHI3WTl1WG5TM1ZDdjRxMGdpM0NIaG9Nc1ltTUx5?=
 =?utf-8?B?cm5HdUR2VzY3TnVpSXlzZUtXY3B2dW5NcVY1QVNQTjlaaHRvNi93Zy9tblR3?=
 =?utf-8?B?dFVKN2JheTg3bXR2MSt6anRPa3dvY1JxRWRBczRQMEQwOE9DVy9LZk01Vm5C?=
 =?utf-8?B?OVRkbzlCM3lhUm92ZjBCcHM3Y3UvRDJ1UFVxaFUxUy9jVFhJdnVXU3FHVWdO?=
 =?utf-8?B?WlV4NFpmaURYeWkranRnM0ZQTUN3djRmQm9DNExNcEhqZ0xGeFhzQW54WVc0?=
 =?utf-8?B?RVAraUJPK1A4em5jZDI2V3pYQUF0c01KYTRKZjlWNTFDSWJmNXdoSGVSdDN3?=
 =?utf-8?B?dGs2SHpTbkJwMXpmREordi9SL2lxV1NCdG8zQ1JpNFhkVkx2aEZxY0dHRGFx?=
 =?utf-8?B?dVpBNCtQRWhSampZZXFlVXEzeUJ3SjZLWXhzb2dXN1A1c1FkU21qTGlLc1FM?=
 =?utf-8?B?R0JPVEozVzQ4bEFYbUR2VE9kRXQwZG50Q2U1V3RzKzdnVWQreHRDNGJvTjQ5?=
 =?utf-8?B?MWUxYWo0STZSdEJYdlpyWVQvQlo4K1NpYmhqQmNLbHVRbFZtaXYxNzRQbzVO?=
 =?utf-8?B?MG9EMGo3V1lDMnNEdWhRY0hlM1ZUUThZQXdPSzVmSlNsdlEvZHRuNFJya0lP?=
 =?utf-8?B?N0wzV0lRdE5BcDZXM200QkdMQWtFZ3plUm9Ga1hGdXRFNVBCTmNvekdjM2lq?=
 =?utf-8?B?b1Vrd0NFYXBGeWc2NjVsakl3NTdSbDJ4MnpQaEZxNlJmQmZVVmFBb1ZPb0cy?=
 =?utf-8?B?b2p3UmtmTCtPUkYySlJ5ZmI0R1czT1FnMDYvSVEzazJuUlkrcG5jR0d4SHRO?=
 =?utf-8?B?ZXREbzdCYWZvN1dvUDNPd3BUSk9GMExvRFBFY3FIZ0xtZjJvTHhFQUVoRDkz?=
 =?utf-8?B?c3JNOWxkVkhZMUlnUGNSUXlWSTlSSEdlTkpvOHVYY1lCMUlZR0JWVUloKzdS?=
 =?utf-8?B?eFhSVll5cnRnMkhPdXVmdGxmTDZUdjBGV3RuR1ZQbzJYa2Q5R1UwUlFXam1I?=
 =?utf-8?B?SFR2VUpmbkhrNnExdmhvdVh3WitLMTBRcTZiS0tBdjhuRnc0WFZVY3VLdmxB?=
 =?utf-8?B?eUR3ZVI5Z0t0aDY1ZDRRZTF2N3pzR2xrOUtYMkh1YWo4RE5nV0k1M3RtTXgv?=
 =?utf-8?B?NFh5Qmd6blNLNHU2YXRCQ3EzK09KNmtZQ1BkQWZEV2g2Qm5LRVRkSVg4NGFQ?=
 =?utf-8?B?TUxxb1hmZDJvS25zR0VVRkNBZEpiVjV2M1Z0NEVWbktyWSsvQkVLdTJ5M3pq?=
 =?utf-8?B?eFk1K3dNeHpteXpNN0NBU0d5THVEZ3VhY0xNQjVkYUNuUVViakVuVi9ieUhN?=
 =?utf-8?B?RzFPNWUwUWMrSEpWRkJqck9KRy91aE1RblB6eEVHUlVxalJSZndsVFBuV3VQ?=
 =?utf-8?B?YWZmOExHVHFDb2p3dzVJR1U1UjI5YnhZb2ovNGY1dVAvMmVGUmU5VFA2TDFn?=
 =?utf-8?B?UEN2WlZWaGJ0WjBmaHR2Lzh3QjZkNURHbFVwZU1DSW9id0lJa0lBeE5hY0N4?=
 =?utf-8?B?bThKVks4TjF5ak81cWVDUjNldG9tM2xqaU9halBSNVJ2aktURzR1TSt5QWRa?=
 =?utf-8?B?TjhBa05uZ3RQY25UdGtPdlIyVUR3WnhLYmF0ZFJyOVFLQ0JrdHdTWFNZeFRr?=
 =?utf-8?B?OVNaZzV6ZGVSL2JwTXN4SzhjaDlDR1lSdUI3WWdaazRiR0loUnU2T3B2ZTRj?=
 =?utf-8?B?ZDNacmthWDY1TWFWLzFMellkUXZNbE11dDhZa3dYYi9Pa2NPeVFSb3JhNXkv?=
 =?utf-8?B?aHdjUUpza0pTQkRkU2g5b2Q0eGIwN1U2cUhjZ0NQYi85ZmExMVpicjhUd210?=
 =?utf-8?B?dVdydjBZVDIvRDA3c0JVZm01aFBzeVA1cTBRbHBSb00zMnRzL0ZxbHMxWG9p?=
 =?utf-8?B?K3RmUnVKZnRQNUNoSzVMd2hnSEM1RERQSTYxSE92dTUxZi95dmdmbFA3YzhG?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nWeOHWrKy0DmLmPnNpjZ2iocfegu6K31nrX6Mtbvw4HaaZg+/mk3Zv+YidUYHycDuzBnzBJL+y0mKhMr0/HAGz7caHw/TeyLBGQamjQSa8KjacsktI2A8NGiSBFFHzbzUVyD6weEVZtk/ugos//Vxh96PpuJha3MOOk/V/6aP5vTqLVMdd12Y2NIP8AOhp34qrTnWB5S59njfm2Qftwt7AUbWdlu/L9YNDB7sh/Dk6/1VbzS3vhY19TuskHYVWFCDwH037i3GoM0L6PDzqZtyd99SRtWF2Knz6t3wPVKLq9fcOAWq2t4h7ZWDNQQEsFWJ5GyAZfrgrnAl2kF/XBwuTkIkugabj+bCZZT4A2CmtuyNR0ID0zuKsubrNKLMAr88vL4J/u9i6gG5j0F5Z8YPL3BJLMN3y3iDkUnrXd75M1GI/0Xtq7q3gxjfWS/z1ILxGkAG5E+PIsj2YOR+0U9eGV2kUT4VtQfI044cCZBhSxJyFTBmteOj4UMRSkhuqjxUoUIdxmoLoo8I07S2HPlff9Cb6ObX2xSf5YzPCqUBnhI7uOPaTE4WW9tPp1B4Ad1TuJMUNtl+twk9thLSxmCSFvRr998G23E9vB7kpatBHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eac1b22-df74-4fa8-7cfb-08dd8756b3af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:47:41.0154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOKF41oRjy7erQSXiGlDdiqLG5KSolXklX+qtNRMxNy+FTAfPu6fpbOYkBizGGHggG7kjscioHaTWGq9jmBrn87XtDvksSqrzYUhgFb5MYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7113AF9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290145
X-Proofpoint-GUID: 2BQFeA3cw_23pCurc9AVyQEgEXQVscld
X-Proofpoint-ORIG-GUID: 2BQFeA3cw_23pCurc9AVyQEgEXQVscld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0NSBTYWx0ZWRfX6GaLN1NlXOSF
 HwTSyAWEituUPaAdN2NMF7Pz4rGxj5+UtXuPRJbzVOJ2DxVI5rJKd0voi3O02cVjkr2oqix2Hwx
 UtQ5e/Dz660ignPysp6sqvX/mblDqNIPr4jtgH614l36tiEdt6vwh7EiCR652HpoMWwl0s/qPnD
 YmkP0Ts2aVWcLHVzkd/RlaJXMl/9OHrDpkCtBFDe2bb1Mhh+eOa1iA+lSbKCjEPrmygjC9dHi6f
 pu+6Vq7RBJn7/S6zH+FgRCTTMsAC1wNmKkZ5o+02T9KaVvVGcilcoWfEf4q/CCDy11a0adgVhBt
 UJ3ZrElyKfqJuQLy3/OFzoO10nXBQjgn1w/hzHs2g401wE1jEVmneb5y9Vwb5whAyWAtA43YV1S
 91z6YpiV
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68112ce1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10
 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8 a=NiuX8y8RPSVvljGXw6wA:9
 a=3ukUd95dSxbCPhwM:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:14638
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/22/25 8:38 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
>> When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the
>> address and size of the invalidation and sync the guest page table state
>> with the host. This requires walking the guest page table and calling
>> notifiers registered for address spaces matching the domain ID encoded
>> in the command.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 110 ++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 102 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 6789e1e9b688..cf83ac607064 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -97,6 +97,9 @@ typedef enum AMDVIFaultReason {
>>   } AMDVIFaultReason;
>>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
>> +static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>> +                                               uint64_t *dte, hwaddr 
>> addr,
>> +                                               uint64_t size, bool 
>> send_unmap);
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>> @@ -497,8 +500,7 @@ static gboolean 
>> amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
>>    * first zero at bit 51 or larger is a request to invalidate the 
>> entire address
>>    * space.
>>    */
>> -static uint64_t __attribute__((unused))
>> -amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
>> +static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t 
>> flags)
>>   {
>>       uint64_t size = AMDVI_PAGE_SIZE;
>>       uint8_t fzbit = 0;
>> @@ -515,10 +517,101 @@ amdvi_decode_invalidation_size(hwaddr addr, 
>> uint16_t flags)
>>       return size;
>>   }
>> +/*
>> + * Synchronize the guest page tables with the shadow page tables kept 
>> in the
>> + * host for the specified range.
>> + * The invalidation command issued by the guest and intercepted by 
>> the VMM
>> + * does not specify a device, but a domain, since all devices in the 
>> same domain
>> + * share the same page tables. However, vIOMMU emulation creates 
>> separate
>> + * address spaces per device, so it is necessary to traverse the list 
>> of all of
>> + * address spaces (i.e. devices) that have notifiers registered in 
>> order to
>> + * propagate the changes to the host page tables. This could generate 
>> redundant
>> + * requests to map/unmap regions when there are several devices in a 
>> same domain
>> + * but it must be optimized by maintaining an internal representation 
>> of the
>> + * per-domain address space, and avoid invoking a notifier when the 
>> change is
>> + * already reflected in the host page tables.
>> + *
>> + * We cannot return early from this function once a matching domain 
>> has been
>> + * identified and its page tables synced (based on the fact that all 
>> devices in
>> + * the same domain share the page tables). The reason is that 
>> different devices
>> + * (i.e. address spaces) could have different notifiers registered, 
>> and by
>> + * skipping address spaces that appear later on the 
>> amdvi_as_with_notifiers list
>> + * their notifiers (which could differ from the ones registered for 
>> the first
>> + * device/address space) would not be invoked.
>> + */
>> +static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t 
>> addr,
>> +                              uint16_t flags)
>> +{
>> +    AMDVIAddressSpace *as;
>> +
>> +    uint64_t size = amdvi_decode_invalidation_size(addr, flags);
>> +
>> +    if (size == AMDVI_INV_ALL_PAGES) {
>> +        addr = 0;       /* Set start address to 0 and invalidate 
>> entire AS */
>> +    } else {
>> +        addr &= ~(size - 1);
>> +    }
>> +
>> +    /*
>> +     * Call notifiers that have registered for each address space 
>> matching the
>> +     * domain ID, in order to sync the guest pagetable state with the 
>> host.
>> +     */
>> +    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
>> +
>> +        uint64_t dte[4] = { 0 };
>> +
>> +        /*
>> +         * Retrieve the Device Table entry for the devid 
>> corresponding to the
>> +         * current address space, and verify the DomainID matches 
>> i.e. the page
>> +         * tables to be synced belong to devices in the domain.
>> +         */
>> +        if (amdvi_as_to_dte(as, dte)) {
>> +            continue;
>> +        }
>> +
>> +        /* Only need to sync the Page Tables for a matching domain */
>> +        if (domid != (dte[1] & AMDVI_DEV_DOMID_ID_MASK)) {
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * We have determined that there is a valid Device Table 
>> Entry for a
>> +         * device matching the DomainID in the INV_IOMMU_PAGES 
>> command issued by
>> +         * the guest. Walk the guest page table to sync shadow page 
>> table.
>> +         *
>> +         * An optimization can be made if only UNMAP notifiers are 
>> registered to
>> +         * avoid walking the page table and just invalidate the 
>> requested range.
>> +         */
> 
> Hi Alejandro,
> I am not able to understand the optimization during "UNMAP only"
> notifiers. 

The only example I am aware of is in vhost, which can register for 
UNMAP-only notifications (or for DEVIOTLB_UNMAP when suporting 
device-iotlb capability for virtio-pci devices using ats=on). See the 
code at:

https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c#L896-898

And for more context, the comment at:

https://gitlab.com/qemu-project/qemu/-/blob/master/include/system/memory.h?ref_type=heads#L146-158

However, given that I am not testing with vhost, or implementing the 
rest of the changes to support the device IOTLB, I will remove this 
section. We can add it later if device-iotlb/ATS support makes sense...

I am confused because code will call the UNMAP notifier
> even if the pte is present (which should be wrong). Could you please
> explain why we are unmapping IOVAs with present pte ?

Taking this question in isolation, if any component registers only for 
UNMAP notifications, it means that it expects to receive invalidations 
only for unmap operations (with the correct range), and that is the only 
information it needs to work. So if you register for UNMAP-only 
notifications, you expect/know/trust the device driver in the guest that 
is managing the device (i.e. the address space) to only issue 
invalidations when it wants to discard mappings.

Alejandro

> 
> Regards
> Sairaj Kodilkar
> 
>> +        if (as->notifier_flags & IOMMU_NOTIFIER_MAP) {
>> +
>> +            /* Sync guest IOMMU mappings with host */
>> +            amdvi_sync_shadow_page_table_range(as, &dte[0], addr, 
>> size, true);
>> +        } else {
>> +            /*
>> +             * For UNMAP only notifiers, invalidate the requested 
>> size. No page
>> +             * table walk is required since there is no need to 
>> replay mappings.
>> +             */
>> +            IOMMUTLBEvent event = {
>> +                .type = IOMMU_NOTIFIER_UNMAP,
>> +                .entry = {
>> +                    .target_as = &address_space_memory,
>> +                    .iova = addr,
>> +                    .translated_addr = 0, /* Irrelevant for unmap 
>> case */
>> +                    .addr_mask = size - 1,
>> +                    .perm = IOMMU_NONE,
>> +                },
>> +            };
>> +            memory_region_notify_iommu(&as->iommu, 0, event);
>> +        }
>> +    }
>> +}
>> +
>>   /* we don't have devid - we can't remove pages by address */
>>   static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>>   {
>>       uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
>> +    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
>> +    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
>>       if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
>>           extract64(cmd[1], 3, 9)) {
>> @@ -528,6 +621,8 @@ static void amdvi_inval_pages(AMDVIState *s, 
>> uint64_t *cmd)
>>       g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
>>                                   &domid);
>> +
>> +    amdvi_sync_domain(s, domid, addr, flags);
>>       trace_amdvi_pages_inval(domid);
>>   }
>> @@ -1589,9 +1684,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
>>    *  0:  PTE is marked not present, or entry is 0.
>>    * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
>>    */
>> -static uint64_t __attribute__((unused))
>> -fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
>> -          hwaddr *page_size)
>> +static uint64_t fetch_pte(AMDVIAddressSpace *as, const hwaddr address,
>> +                          uint64_t dte, hwaddr *page_size)
>>   {
>>       IOMMUAccessFlags perms = amdvi_get_perms(dte);
>> @@ -1693,9 +1787,9 @@ fetch_pte(AMDVIAddressSpace *as, const hwaddr 
>> address, uint64_t dte,
>>    * notifiers to sync the shadow page tables in the host.
>>    * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
>>    */
>> -static void __attribute__((unused))
>> -amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
>> -                                   hwaddr addr, uint64_t size, bool 
>> send_unmap)
>> +static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>> +                                               uint64_t *dte, hwaddr 
>> addr,
>> +                                               uint64_t size, bool 
>> send_unmap)
>>   {
>>       IOMMUTLBEvent event;
> 


