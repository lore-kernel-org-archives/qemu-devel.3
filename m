Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E749CCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6oEq-00038Z-5f; Thu, 09 Oct 2025 06:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6oEo-000372-CY; Thu, 09 Oct 2025 06:51:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6oD9-0005Q6-Di; Thu, 09 Oct 2025 06:51:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5997u8fR000545;
 Thu, 9 Oct 2025 10:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=5UPRaXgrj0a/ETBPTk63BfqMkycUWe7ECkIHvqyzkck=; b=
 pN33H/xQgbSemQ4dGwR6Vo848jYauwOeu+QwtjYKANyZEy0iFkcOqAWJ0mgUkcRA
 v5Z+uuDvvJV4BqfSHFy4caxNbw3EkucGSyo/8eVtkr0+4ccLPhdERIxCp4RXtMbY
 dwq865lh3dtMrPw8fTWG4aWU53ozi7a8fTLsz6NNUUp7L3eVMp/6V/u5mnl7zCIE
 ZH0763lZpJRwq70rGdcgxKs1ujDrJylIVOtXsElME42aem60nnqH0At+kS68z62i
 RCOsu58hb/MhVIXpgs132C0WhnanSa5TmaQmDZHh8PIGsykXbnOJytYe7PZ7v3Hn
 nyOOppfSi68acymGPKRFQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8phavc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 10:48:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5998O75v022800; Thu, 9 Oct 2025 10:48:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv62fnue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 10:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHtY8Nn+t4b2DgAsOtpi0lJEeta9Z44l3Nz2lmWmAk1e5bBT9PS2ntz3fepEowWp/TAOaFfuUSc0Lhq7j+jCx0cQOLSUW/f2DoLrYYnT/cHrciVWMbpkGimUC22UqQtP8vH0CodaKYElMqWoG/OS4N1MDyCBSD29nHvyBtPKfKAhXlxkq5gkv8f7c1ZC99XUJ9gls4DEI92jIEy2qJfhymC5DtdNpCeRH2QJvjBh/Pa0hn6c1A0ApIK9gqVhlI4zOXraKdG+bwEVU3KMuoiyJiB9rAKyZwrTuqI57uNOPWGllwhPRVaD6lo1ac1VYJeVpi8TESnNvN96egdu+M1LDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UPRaXgrj0a/ETBPTk63BfqMkycUWe7ECkIHvqyzkck=;
 b=tMXSEP1WjDolZ0bIZcYVVOcce9xXRRGpfnk78JymGAKZCawIa1UqCP8dmol5scwE+7pIxL5NBjrjXmp7iI3wvYCWsZzLA3enT5QZTvq9YnOgopy7LPygzH9sRSo06JGWoqJuo8MgvOPTqPKXM61y5R3Xf85OA1F6lq3Rzjh9nufS1DmkC4+teG4aTsXk2Na/qAQS3xLDh0W1fa9iQiMWScoclnBtHyrrzNWSPCkHcgHDOWa2R914X8gZZWxmWiSPJTkJyCuDp1hsDhnkSlCK5mlFM1kheFt3dpYLzBecdTsaPLP9lr5ZgCJoczExljgqeMOm2t/oFr3bxQAJAoRHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UPRaXgrj0a/ETBPTk63BfqMkycUWe7ECkIHvqyzkck=;
 b=tr4B6gN7J0gXAt6myflnlKMUTOzdGo56ZU1gBSaWgzihGTkZ8L3g+uZPolfGRby/jYvgNLyNGj2N6MjLdvD4+eWge4BNd7E2v/T8xLQwLl2AR5nNSDDK9zHL50mYXlb5JAlTgmnrHRSuXfEAbk9rA2XVw6x0izshGGZyHIgUGOc=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by PH3PPF3B2A83235.namprd10.prod.outlook.com (2603:10b6:518:1::795)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:48:40 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:48:40 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 01/24] hw/core: Introduce administrative
 power-state property and its accessors
Thread-Topic: [PATCH RFC V6 01/24] hw/core: Introduce administrative
 power-state property and its accessors
Thread-Index: AQHcMm8Lsj3BKjcdPk6lUcW7E/o1b7S5r58A
Date: Thu, 9 Oct 2025 10:48:40 +0000
Message-ID: <31EB5635-20F2-436E-A15D-15C951C5F039@oracle.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-2-salil.mehta@opnsrc.net>
In-Reply-To: <20251001010127.3092631-2-salil.mehta@opnsrc.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5894:EE_|PH3PPF3B2A83235:EE_
x-ms-office365-filtering-correlation-id: e4633a5b-0c42-40c1-1086-08de0721687d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?OHhSTUxkbmUxaStTTFBSQ2l2Q05kNXJ0YkN4S05qMDJ5OTlSeGtpVDgvNHA1?=
 =?utf-8?B?MTZJQzV0di9XNy9MTTh4c1V4dnNtOUFxZThjYWdMNEJDRmxCclV4aC9YYnBQ?=
 =?utf-8?B?dHNFc09RTW5XRVpWRjRMT0Q1WUxNSDgrdG9Yd1BoOGlDUCtTY1E3N1JRZXdD?=
 =?utf-8?B?ZGV2bWxCemhiR3pXdkhOSkd6Y3FpY2hXd2pYbmtobFhocjY3VTVEYVV4K2l4?=
 =?utf-8?B?NXBmRFVTMUhrTG9lejB3Vzc0aXFJODRSU2kzTFV4QktlUGJzTE9jTUZ5OW9M?=
 =?utf-8?B?Z3M0V1F0enBMNkE4SmxkOUxnbEZ3MWQ2TEFxRHhCOEMxS1NIWlU5WmRkcUJp?=
 =?utf-8?B?cGgxWC9DdE5zZHp5d1BHNDFDNWk1N01VU0g2akVSYVBndG5RQTdKamVDTFZP?=
 =?utf-8?B?cTZHMU40VkNtTmpjcitnLzFkZisrS2VBdE9WaGE2QjhoS1hDQktEWWhBOVpK?=
 =?utf-8?B?Q01ZTkNJMS9OekZ2NUI3cGpnM3RQM3c4VnFteUJpUXEySk10Z2tSc01UM1F5?=
 =?utf-8?B?SEZxMUtpZnFmK1lMb3d5aHAwYURJSG10UTlWOTFaMXdYYmgzdzVCN1dRdUUz?=
 =?utf-8?B?cHdjS3A1cEwyR3lTbGRXaFIyckhwSmhtNDVidXEzdkdCdWY3M3B0VlV2Wjdh?=
 =?utf-8?B?K3FmMUljeGZYKzdhRWF0WmV6V0pJNkxjLzlqeGhscGtHQUpZS2FUQk1wMFRJ?=
 =?utf-8?B?Ym1Ra3Jac2lDKzNFV3c5NzJZUHZOQTFzUE5hcjVvWWczcit1NndQeTFyeS9X?=
 =?utf-8?B?VXRIVEE2VWdicE1GRWwvWElYa09KU1JEbnpwUkY0Z2NoK0xRZWlXQWUycHlp?=
 =?utf-8?B?WmpoV2QvMytRdENFVWwzYzdzelNmQ3o4NW1IRG1HU2kyRGNQZzBMN0tYbHpM?=
 =?utf-8?B?MkxNbE12bzhSa05mUzhabXFuL1dXdnVsVkhSOVFLT2VRcnNNdG5XWlgzWEF6?=
 =?utf-8?B?SzNIZUx3QzVPSmU1TVptMEZBOFllNEVIdkhteWIvR3VzZmFjdjNuT2d5ekdW?=
 =?utf-8?B?Z2ZVVFp6bTBHbUVNWHR0MlZUWTJDejNQeCtGNVVsNnhCMU1ZRURGSnNQcGNF?=
 =?utf-8?B?SDNRZ3dBMFFYQkxyU1djbmcyVVlHakdYWjZVNTNKbElSM09UYzZPMXF3d2g3?=
 =?utf-8?B?ZWUvRlJMYjR1em04dDQ4Z2M3UVhUeVo2U0tQY2pVZlV2RHBXYVBUUHVpcVRW?=
 =?utf-8?B?Znh5eVhVMWpObGs2emY5VEdHYVFYN29UN05UTlVJSlZaZFFCOHBPRjJSVjhO?=
 =?utf-8?B?THM5T3BOcGFHdmtLNW5xOUtpVnlUZ2RDTFRsdXRKaUhlT01FazZLRjNYM3NC?=
 =?utf-8?B?OEY1bDdjTm5DZmRsRTdqNGNtWEtRSTBZQTFZbW40QlhWNDhQVHZkamQvUTBU?=
 =?utf-8?B?ZlRvZjNtMTJmY1Fqc0RpN0l3MDN1aUdVcms0eXRvSytBbjFkbjAyUlZTaTRY?=
 =?utf-8?B?WXdGam13bVUyT1hDYmpxT216blZ2emdGczlvYVRiR1RMV09ZSHozcVNoWEVD?=
 =?utf-8?B?bGZ5SXJ4VnEza0pHVEtvZk1kbVBBdy84dFBBMFRNamRyaXFnLzA3UGw1MkRt?=
 =?utf-8?B?YmtlaU1UZENJemloWVlrdWNhQTkzaTRIWjczUnVjejl1ZlIzak0vb0gxRXBj?=
 =?utf-8?B?WGFuSUM0dkt0QjF2L29ma1g0OGlrcnIxQ0ViTjJHSDdqUVhFZ3BzbFhUb2la?=
 =?utf-8?B?RkFlU2FXSGthR3htR1MzL0NXY2c4dmZuL09hbmcycjl2Tm5DamFrM09sNGhC?=
 =?utf-8?B?MUpzY2JFNndyN0hJVWh5Tm1nZTMrSGlROTdiKzd5RFhKTDNrYzY1cDl0Z1M0?=
 =?utf-8?B?NjFKbmQ4YVY2UHg4cUxyYTFCL2Q0UVpTTGcrSnZURml0eDBYczZBU3VTNFZS?=
 =?utf-8?B?R241T3Zid0RJS3VBWGpYQW54RlIrUDJWYUQ5Z1lBUjFNcEp0KzJrdC80aHVF?=
 =?utf-8?B?LysrNHp5QkttZGdVVExOM25xN01hQm0yWGNGK2hBSjNHZEVhZXgxeHJCbFFu?=
 =?utf-8?B?a3JjRHA2Ky9ZYWhoYldCUnFvTThoWW9MUUk5TE1iZS9EQm1ZZTNMcmlVSXpF?=
 =?utf-8?Q?OUDVzQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5894.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmNVRkdmNTdrdTZGeDZDaSt5aUpRRXA2V29oOTE0WVBpRldKR1pmZ3N3UWJo?=
 =?utf-8?B?T1Qva21hbEhsTlB6dmhCaWpDanloV3M1Vm1uVEp2N09obzdkQ3l5aDZ0K1V5?=
 =?utf-8?B?OGtUdElIbzA4eEtxMjBhQmpUL3NibmNISFc1RmtzRnJocVl2ZGppcFFxR2JL?=
 =?utf-8?B?Wkp3RVU0R3RJclRYZEdpTG50Q1JxRXFlY1duTE5EYWlBbjlGUE15dTZsT3Y1?=
 =?utf-8?B?UmQxRkJteU9BN2hjZ0ZGRjhuL0g5b05pT2pHV0NTS2w5TkQrYXZ1TkF3aHla?=
 =?utf-8?B?cG1XaitYRkJZN1RkMWZQaDYwNkpmQk9USmg0Nkg3NVFIVVd4K05GTXVsMkNq?=
 =?utf-8?B?ZDhMeGhSZTB0RXNoQ3N2SHc1djFRRDI1YjVQbHYwRnVld0Q0T3dveElmakc1?=
 =?utf-8?B?NzVyZEJXSnAyUkRkbFJ5eDFXOU1zdi9iZkExS1htdHREWmhJazJHWjY0b2Jy?=
 =?utf-8?B?VkswN0d5RTR6d29ndHdHR3BpUzJkTDVvNmNIT0NYQTdPY1lYUXVEWXJqNkta?=
 =?utf-8?B?OVZocEdSZCtPaE1DTFNCOHNpQlVKS3I1Q0wxT1FsQVVYV0RRc0dEeHVpMWph?=
 =?utf-8?B?bmxSejFvTEJ5WG9lY1RndzNYMEcwbXY5WEthd2dNYUhEWUdvZDZxYm9FN1lk?=
 =?utf-8?B?WUJqMVNpRThlYkhWT1ZDNVByV3gzTlpKSTVqRThKMTFadlRpSmV1N1JPb3Bn?=
 =?utf-8?B?UjBYdm84L3lMVWNRU2JwZTdtbDcrZXA0bzQ4RExRWEVaMDJDcXpRTHZKanha?=
 =?utf-8?B?RVVXSXM0MFUrYzYyb1psajZPRDVCeE10eXRZZ0IwUzRTM2M4NGZlTVE2RlV0?=
 =?utf-8?B?ZEFrVkQ5ZHR4Vmh2TjVQODlPenZuRU1YbkVlWFBFaEVxMjhrdE01b05nQ1lH?=
 =?utf-8?B?Ti9qTmJVNXI0SEFPZmJhdnJERzZhNEFEdlk4WXNqY3A4cVJKMU5oS0l0eUpI?=
 =?utf-8?B?ejVMZXZKMXp6Y0laNVZ4bVdONjhYUmlUYWxZSGorVXpuZkJTWCswbjc1QWVp?=
 =?utf-8?B?QTRhRjQ3eGxITlhyeDNROTRHSmZKM05vNEwrY1R6WkRldEpWS1VWT1JKNWtt?=
 =?utf-8?B?OXNKNkJYRWM1N1N1QU9pUFNYYkFWWXFXanRFYWJBclNNM2VFNElnSnBrck84?=
 =?utf-8?B?d1A3eFFsbUI5MmtKVjVWVVlkMkJiNHNEeDVpMGNReDI3cHdGVEJTUDc4K3hW?=
 =?utf-8?B?Z3hrazRDRXJ5SmlhYTNaVTV0UG12cFZjVWNSdngyd3hoeDdXaXVscW5oTTc3?=
 =?utf-8?B?TDVka216a2pQZmtnRjcvczVwTktGdWk3a01RWWxtaFBsOVF1d0FKK3paUnR5?=
 =?utf-8?B?RW1VTnB3TFMyRFc1Y29QYVJIT00vL3cwOG15RjNTeHE0b2VNTHlyaS9GTjhB?=
 =?utf-8?B?Wk1TUTN4T09HZ1FydmgwcHhqdjBucTEyUC8rYWdVUTJBdXIzcTRITWxVYXpw?=
 =?utf-8?B?WDk3UjcvcXRpNGNIY044dWxZUDY4TGdVenBFdTVtcHVjRVA2Z3UvTVQ3Sm5R?=
 =?utf-8?B?WkloUHhvU1hMT0p6NzdhQmozdjl1YkRxakMvNE02Ukt5TTJWTFlQR1ZuOGFm?=
 =?utf-8?B?dmN6aHB2bkZxc05XUGNNeSs1VlRpRWJyRVhOdUttcE9JS0s0UVF0VEg1T3c0?=
 =?utf-8?B?UnRGZlgwdVJrRlplclZCcjlaSHdoV0dTbGxSYjYwSDErZHZIMU1QSlVBKyta?=
 =?utf-8?B?UlY2MlRnZG85eERhOEUvaHo3MVptZ1BLL3NtZVV4RGVGc0xXbXFKL3ZyZHhn?=
 =?utf-8?B?RVN1MmJZeW5qa252ZGJ3T25UVXQ3b3NKNTdIdFh0S2lENEJ2WWcrbmh0L0xp?=
 =?utf-8?B?UTlpYTJFRCtyTlROaTlYYzVIL0VNQ3A1M256WDJzQlY3dmtWSXJXUndWOHpS?=
 =?utf-8?B?RGN2b2FiV0dvWkcweUFsSXR4K2NCK2dXbUk2S0RjcWUzYlpqcmdZSGdXV1lk?=
 =?utf-8?B?NWRYRXljdlVaY2twSWFoWHVFOGVvZ3N3cnBKeVMrRWRaNDNIV1VpYWtPVTFF?=
 =?utf-8?B?N0RtUTU4N3F4elZnc25pT0hKbXEzZ2RseFZ1WnJzdkNiRGViMS9SRWt4VVRx?=
 =?utf-8?B?OWJ0WnlrUVhOSGg0WmlGcFRGSGp0dDVYRW9hZVA0cXc0SUVSYThKVTdjN2h6?=
 =?utf-8?B?WWdweml2T3VZcUtwcnB3TXRnbmlnOTk3T1hOaEtmODUwenBtRzQvNE1leDJO?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B40C679C7B996849AF1F0B6759BD0582@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sfkB+aYdlcpxBlpxPW33CnuWj58nCt6CGtlbfQIP8oIhSdL0Mw2jhAKrRxH95DdeURRd4+upNfkrtsdJFCYvcrzyQ9/VMoB0NVWbqjNWO7e+8h63VldGV7d0ObrmMPwt6vvz9sGH4HVy5L2BABFIrj3JDKa0TbGz/JmvnFdrTb8ociBt6hgJQqTbwucm2FSXNNxZBkvQom1WXoFDO/kcYpYpirQuXpWOx60wgpugaMfNMn77uZb1peJdjxjrZbzKg73rL4JVk5stJGm+iJxLhlSwqx6lscuqNVU6GsD1bArr5hIFlwSiReoaTxUzXs2ZnTn/ERRBAMp1APbbIV2TBGwgfeG0UM3DDG6KTQt7u1RA8pEVK1ntBDpedS+M/bDPf/jp2A0NbbvadZwg8Gw3roYV34whfDRni2KgG9UZ+Whc+fTGw/b2aNmC4W6ElYB+6wYygWHsEH5YYJa8ViLR51fF3kN7NjB3pW0scW5XnKwu3IQ9wF5qG0I8jgyDX+g8+lwosgpdEItssU19+PgJjK0QUFlb9Mdw81bsx4F4N9eP6QCpSMAQ7lf8MDb1Wb0pBkyb2KS+fjSLpa91f00keOGylOSvLigPTR/G5SwswSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4633a5b-0c42-40c1-1086-08de0721687d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:48:40.1340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wX/Y8yp3lf+Mv9j1ZWFx+AXErU6UIGmWVvpOmTHfuiwUWLFiIwCWOU+Kf7fs+R9pfIZiDo9P1pYfAkG4xWguiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3B2A83235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090062
X-Proofpoint-GUID: Hyfl5AuUn4o2OfWpgMuY9jzDquR0Z8NO
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e7930c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=N4eUw1WxAAAA:8 a=i0EeH86SAAAA:8 a=zSC0GnXanVve9kOlji8A:9 a=QEXdDO2ut3YA:10
 a=TyhWUHtFaNKhBFvZzOnD:22 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: Hyfl5AuUn4o2OfWpgMuY9jzDquR0Z8NO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX0JqPOAQH+9T5
 QCzgSgqmakUlyAWG5ZrCKskuhAXpmhL8Clq/FZd7eWTcp5JBpHTtayBr+IeRN3+emCTFx/cXIRp
 UKMAp9doiDNgpKkk7Mm97Y378IdCgcvNxXu3sWwRI5Ieb6ZbQQShuOYtT910uFK5EoxtoNPi32P
 Z5pt7Zo7T9QgKZ9eO9OsMkrMo7aZ+0DmKZKLQxlz9vRCFndibu/HojFf8PQx/OvUsg/P197Mitn
 IROkd7eTl8aEg1UYj6WkDDAe1srQiPvkSQxSpcTv6IljlyQXR5zUTGkIbyX+ZthN8y6J2hOHj7P
 4zsUHeTo1Uc/V7U0Gozxmx/fiJ8/Gqkvnqb3u2/MoL0BuHYEsFgb2Te3J5JB9pymjDcXWoNwZst
 jUcfo57jbuoe3IHdCkgBDq3AiYlK3B0b05SUbvDLxre2qgLEb1Q=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

SGkgU2FsaWwsDQoNCj4gT24gMSBPY3QgMjAyNSwgYXQgMDE6MDEsIHNhbGlsLm1laHRhQG9wbnNy
Yy5uZXQgd3JvdGU6DQo+IA0KPiBGcm9tOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2Vp
LmNvbT4NCj4gDQo+IFNvbWUgZGV2aWNlcyBjYW5ub3QgYmUgaG90LXVucGx1Z2dlZCwgZWl0aGVy
IGJlY2F1c2UgcmVtb3ZhbCBpcyBub3QgbWVhbmluZ2Z1bA0KPiAoZS5nLiBvbi1ib2FyZCBkZXZp
Y2VzKSBvciBub3Qgc3VwcG9ydGVkIChlLmcuIGNlcnRhaW4gUENJZSBkZXZpY2VzKS4gT3RoZXJz
LA0KPiBzdWNoIGFzIENQVXMgb24gYXJjaGl0ZWN0dXJlcyBsaWtlIEFSTSwgbGFjayBuYXRpdmUg
aG90cGx1ZyBzdXBwb3J0IGJ1dCBjYW4NCj4gc3RpbGwgaGF2ZSB0aGVpciBhdmFpbGFiaWxpdHkg
Y29udHJvbGxlZCB0aHJvdWdoIGhvc3QgcG9saWN5LiBJbiBhbGwgdGhlc2UNCj4gY2FzZXMsIGEg
bWVjaGFuaXNtIGlzIG5lZWRlZCB0byB0cmFjayBhbmQgY29udHJvbCBhIGRldmljZeKAmXMgKmFk
bWluaXN0cmF0aXZlKg0KPiBwb3dlciBzdGF0ZSDigJQgaW5kZXBlbmRlbnQgb2YgaXRzIHJ1bnRp
bWUgb3BlcmF0aW9uYWwgc3RhdGUg4oCUIHNvIFFFTVUgY2FuOg0KPiANCj4gIC0gRGlzYWJsZSBh
IGRldmljZSB3aGlsZSBrZWVwaW5nIGl0IGRlc2NyaWJlZCBpbiBmaXJtd2FyZSwgQUNQSSwgb3Ig
b3RoZXINCj4gICAgY29uZmlndXJhdGlvbi4NCj4gIC0gUHJldmVudCBndWVzdCB1c2UgdW50aWwg
ZXhwbGljaXRseSByZS1lbmFibGVkLg0KPiAgLSBDb29yZGluYXRlIHRyYW5zaXRpb25zIHdpdGgg
cGxhdGZvcm0tc3BlY2lmaWMgcG93ZXIgaGFuZGxlcnMgYW5kIG1pZ3JhdGlvbg0KPiAgICBsb2dp
Yy4NCj4gDQo+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB0aGUgY29yZSBxZGV2IHN1cHBvcnQgZm9y
IGFkbWluaXN0cmF0aXZlIHBvd2VyIHN0YXRlIOKAlA0KPiBkZWZpbmluZyB0aGUgcHJvcGVydHks
IGVudW0sIGFuZCBhY2Nlc3NvcnMg4oCUIHdpdGhvdXQgeWV0IGFwcGx5aW5nIGl0IHRvIGFueQ0K
PiBkZXZpY2UuIExhdGVyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgaW50ZWdyYXRlIGl0IHdpdGgg
aGVscGVyIEFQSXMNCj4gKHFkZXZfZGlzYWJsZSgpLCBxZGV2X2VuYWJsZSgpLCBldGMuKSBhbmQg
c3BlY2lmaWMgZGV2aWNlIHR5cGVzIHN1Y2ggYXMgQ1BVcywNCj4gY29tcGxldGluZyB0aGUgZmxv
dyB3aXRoIHBsYXRmb3JtLXNwZWNpZmljIGhhbmRsZXJzLg0KPiANCj4gS2V5IGFkZGl0aW9uczoN
Cj4gIC0gTmV3IGVudW0gRGV2aWNlQWRtaW5Qb3dlclN0YXRlIHdpdGggRU5BQkxFRCwgRElTQUJM
RUQsIGFuZCBSRU1PVkVEIHN0YXRlcywNCj4gICAgZGVmYXVsdGluZyB0byBFTkFCTEVELg0KPiAg
LSBOZXcgRGV2aWNlQ2xhc3MgZmxhZyBhZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQgdG8gYWR2
ZXJ0aXNlIHN1cHBvcnQgZm9yDQo+ICAgIGFkbWluaXN0cmF0aXZlIHRyYW5zaXRpb25zLg0KPiAg
LSBOZXcgUU9NIHByb3BlcnR5ICJhZG1pbl9wb3dlcl9zdGF0ZSIgdG8gcXVlcnkgb3Igc2V0IHRo
ZSBzdGF0ZSBvbiBzdXBwb3J0ZWQNCj4gICAgZGV2aWNlcy4NCj4gIC0gSW50ZXJuYWwgYWNjZXNz
b3JzIGRldmljZV9nZXRfYWRtaW5fcG93ZXJfc3RhdGUoKSBhbmQNCj4gICAgZGV2aWNlX3NldF9h
ZG1pbl9wb3dlcl9zdGF0ZSgpIHRvIG1hbmFnZSBzdGF0ZSBjaGFuZ2VzLCBpbmNsdWRpbmcgc2Fm
ZQ0KPiAgICBoYW5kbGluZyB3aGVuIHRoZSBkZXZpY2UgaXMgbm90IHlldCByZWFsaXplZC4NCj4g
DQo+IFRoZSBlbnVtIG1vZGVscyAqcG9saWN5KiByYXRoZXIgdGhhbiBlbGVjdHJpY2FsIG9yIGZ1
bmN0aW9uYWwgcG93ZXIgc3RhdGUsIGFuZA0KPiBpcyBkaXN0aW5jdCBmcm9tIHJ1bnRpbWUgbWVj
aGFuaXNtcyAoZS5nLiBQU0NJIGZvciBBUk0gQ1BVcykuIFRoZSBhY3R1YWwNCj4gb3BlcmF0aW9u
YWwgc3RhdGUgb2YgYSBkZXZpY2UgaXMgbWFpbnRhaW5lZCBieSBwbGF0Zm9ybS1zcGVjaWZpYyBv
ciBkZXZpY2UtDQo+IHNwZWNpZmljIGNvZGUsIHdoaWNoIGVuZm9yY2VzIHJ1bnRpbWUgYmVoYXZp
b3VyIGJhc2VkIG9uIHRoZSBhZG1pbmlzdHJhdGl2ZQ0KPiBzZXR0aW5nLiBFdmVyeSBkZXZpY2Ug
c3RhcnRzIGFkbWluaXN0cmF0aXZlbHkgRU5BQkxFRCBieSBkZWZhdWx0LiBBIERJU0FCTEVEDQo+
IGRldmljZSByZW1haW5zIGxvZ2ljYWxseSBwcmVzZW50IGJ1dCBibG9ja2VkIGZyb20gb3BlcmF0
aW9uOyBhIFJFTU9WRUQgZGV2aWNlDQo+IGlzIGxvZ2ljYWxseSBhYnNlbnQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gLS0tDQo+
IGh3L2NvcmUvcWRldi5jICAgICAgICAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gaW5jbHVkZS9ody9xZGV2LWNvcmUuaCB8IDU0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiB0YXJnZXQvYXJtL2NwdS5jICAgICAgIHwgIDEg
Kw0KDQpJ4oCZZCBzdWdnZXN0IHNlcGFyYXRpbmcgdGhpcyBpbiB0d28gcGF0Y2hlcywgb25lIHdo
aWNoIGFkZHMgZnVuY3Rpb25hbGl0eSBhbmQNCmFub3RoZXIgb25lIHdoaWNoIGVuYWJsZXMgZnVu
Y3Rpb25hbGl0eSBmb3IgdGhlIGFyY2guIEl0IG1heSBlYXNlIGludGVncmF0aW9uIG92ZXJhbGws
DQptb3Jlb3ZlciBib3RoIG1heSBiZSBpbmRlcGVuZGVudCBvZiBvbmUgYW5vdGhlci4NCg0KVGhh
bmtzDQpNaWd1ZWwNCg0KPiAzIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9xZGV2LmMgYi9ody9jb3JlL3FkZXYuYw0KPiBpbmRleCBm
NjAwMjI2MTc2Li44NTAyZDYyMTZmIDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL3FkZXYuYw0KPiAr
KysgYi9ody9jb3JlL3FkZXYuYw0KPiBAQCAtNjMzLDYgKzYzMyw1MyBAQCBzdGF0aWMgYm9vbCBk
ZXZpY2VfZ2V0X2hvdHBsdWdnZWQoT2JqZWN0ICpvYmosIEVycm9yICoqZXJycCkNCj4gICAgIHJl
dHVybiBkZXYtPmhvdHBsdWdnZWQ7DQo+IH0NCj4gDQo+ICtzdGF0aWMgaW50IGRldmljZV9nZXRf
YWRtaW5fcG93ZXJfc3RhdGUoT2JqZWN0ICpvYmosIEVycm9yICoqZXJycCkNCj4gK3sNCj4gKyAg
ICBEZXZpY2VTdGF0ZSAqZGV2ID0gREVWSUNFKG9iaik7DQo+ICsNCj4gKyAgICByZXR1cm4gZGV2
LT5hZG1pbl9wb3dlcl9zdGF0ZTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQNCj4gK2Rldmlj
ZV9zZXRfYWRtaW5fcG93ZXJfc3RhdGUoT2JqZWN0ICpvYmosIGludCBuZXdfc3RhdGUsIEVycm9y
ICoqZXJycCkNCj4gK3sNCj4gKyAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gREVWSUNFKG9iaik7DQo+
ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0dFVF9DTEFTUyhkZXYpOw0KPiArDQo+ICsg
ICAgaWYgKCFkYy0+YWRtaW5fcG93ZXJfc3RhdGVfc3VwcG9ydGVkKSB7DQo+ICsgICAgICAgIGVy
cm9yX3NldGcoZXJycCwgIkRldmljZSAnJXMnIGFkbWluIHBvd2VyIHN0YXRlIGNoYW5nZSBub3Qg
c3VwcG9ydGVkIiwNCj4gKyAgICAgICAgICAgICAgICAgICBvYmplY3RfZ2V0X3R5cGVuYW1lKG9i
aikpOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgc3dpdGNoIChu
ZXdfc3RhdGUpIHsNCj4gKyAgICBjYXNlIERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9ESVNBQkxF
RDogew0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBUT0RPOiBPcGVyYXRpb25hbCBzdGF0
ZSB0cmFuc2l0aW9uIHRyaWdnZXJlZCBieSBhZG1pbmlzdHJhdGl2ZSBhY3Rpb24NCj4gKyAgICAg
ICAgICogUG93ZXJpbmcgb2ZmIHRoZSByZWFsaXplZCBkZXZpY2UgZWl0aGVyIHN5bmNocm9ub3Vz
bHkgb3IgdmlhIE9TUE0uDQo+ICsgICAgICAgICAqLw0KPiArDQo+ICsgICAgICAgIHFhdG9taWNf
c2V0KCZkZXYtPmFkbWluX3Bvd2VyX3N0YXRlLCBERVZJQ0VfQURNSU5fUE9XRVJfU1RBVEVfRElT
QUJMRUQpOw0KPiArICAgICAgICBzbXBfd21iKCk7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAg
IH0NCj4gKyAgICBjYXNlIERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9FTkFCTEVEOiB7DQo+ICsg
ICAgICAgIC8qDQo+ICsgICAgICAgICAqIFRPRE86IE9wZXJhdGlvbmFsIHN0YXRlIHRyYW5zaXRp
b24gdHJpZ2dlcmVkIGJ5IGFkbWluaXN0cmF0aXZlIGFjdGlvbg0KPiArICAgICAgICAgKiBQb3dl
cmluZyBvbiB0aGUgZGV2aWNlIGFuZCByZXN0b3JpbmcgbWlncmF0aW9uIHJlZ2lzdHJhdGlvbi4N
Cj4gKyAgICAgICAgICovDQo+ICsNCj4gKyAgICAgICAgcWF0b21pY19zZXQoJmRldi0+YWRtaW5f
cG93ZXJfc3RhdGUsIERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9FTkFCTEVEKTsNCj4gKyAgICAg
ICAgc21wX3dtYigpOw0KPiArICAgICAgICBicmVhazsNCj4gKyAgICB9DQo+ICsgICAgZGVmYXVs
dDoNCj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBhZG1pbiBwb3dlciBzdGF0
ZSAlZCBmb3IgZGV2aWNlICclcyciLA0KPiArICAgICAgICAgICAgICAgICAgIG5ld19zdGF0ZSwg
ZGV2LT5pZCk7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIH0NCj4gK30NCj4gKw0KPiBzdGF0
aWMgdm9pZCBkZXZpY2VfaW5pdGZuKE9iamVjdCAqb2JqKQ0KPiB7DQo+ICAgICBEZXZpY2VTdGF0
ZSAqZGV2ID0gREVWSUNFKG9iaik7DQo+IEBAIC02NDQsNiArNjkxLDcgQEAgc3RhdGljIHZvaWQg
ZGV2aWNlX2luaXRmbihPYmplY3QgKm9iaikNCj4gDQo+ICAgICBkZXYtPmluc3RhbmNlX2lkX2Fs
aWFzID0gLTE7DQo+ICAgICBkZXYtPnJlYWxpemVkID0gZmFsc2U7DQo+ICsgICAgZGV2LT5hZG1p
bl9wb3dlcl9zdGF0ZSA9IERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9FTkFCTEVEOw0KPiAgICAg
ZGV2LT5hbGxvd191bnBsdWdfZHVyaW5nX21pZ3JhdGlvbiA9IGZhbHNlOw0KPiANCj4gICAgIFFM
SVNUX0lOSVQoJmRldi0+Z3Bpb3MpOw0KPiBAQCAtNzMxLDYgKzc3OSwxNSBAQCBkZXZpY2Vfdm1z
dGF0ZV9pZl9nZXRfaWQoVk1TdGF0ZUlmICpvYmopDQo+ICAgICByZXR1cm4gcWRldl9nZXRfZGV2
X3BhdGgoZGV2KTsNCj4gfQ0KPiANCj4gK3N0YXRpYyBjb25zdCBRRW51bUxvb2t1cCBkZXZpY2Vf
YWRtaW5fcG93ZXJfc3RhdGVfbG9va3VwID0gew0KPiArICAgIC5hcnJheSA9IChjb25zdCBjaGFy
ICpjb25zdFtdKSB7DQo+ICsgICAgICAgIFtERVZJQ0VfQURNSU5fUE9XRVJfU1RBVEVfRU5BQkxF
RF0gID0gImVuYWJsZWQiLA0KPiArICAgICAgICBbREVWSUNFX0FETUlOX1BPV0VSX1NUQVRFX1JF
TU9WRURdICA9ICJyZW1vdmVkIiwNCj4gKyAgICAgICAgW0RFVklDRV9BRE1JTl9QT1dFUl9TVEFU
RV9ESVNBQkxFRF0gPSAiZGlzYWJsZWQiLA0KPiArICAgIH0sDQo+ICsgICAgLnNpemUgPSBERVZJ
Q0VfQURNSU5fUE9XRVJfU1RBVEVfTUFYLA0KPiArfTsNCj4gKw0KPiBzdGF0aWMgdm9pZCBkZXZp
Y2VfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqY2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+IHsN
Cj4gICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhjbGFzcyk7DQo+IEBAIC03NjUs
NiArODIyLDExIEBAIHN0YXRpYyB2b2lkIGRldmljZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpj
bGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXZpY2VfZ2V0X2hvdHBsdWdnYWJsZSwgTlVMTCk7DQo+ICAgICBvYmplY3RfY2xhc3Nf
cHJvcGVydHlfYWRkX2Jvb2woY2xhc3MsICJob3RwbHVnZ2VkIiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXZpY2VfZ2V0X2hvdHBsdWdnZWQsIE5VTEwpOw0KPiArICAg
IG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfZW51bShjbGFzcywgImFkbWluX3Bvd2VyX3N0YXRl
IiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkRldmljZUFkbWluUG93
ZXJTdGF0ZSIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZkZXZpY2Vf
YWRtaW5fcG93ZXJfc3RhdGVfbG9va3VwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXZpY2VfZ2V0X2FkbWluX3Bvd2VyX3N0YXRlLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXZpY2Vfc2V0X2FkbWluX3Bvd2VyX3N0YXRlKTsNCj4gICAg
IG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfbGluayhjbGFzcywgInBhcmVudF9idXMiLCBUWVBF
X0JVUywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZihEZXZp
Y2VTdGF0ZSwgcGFyZW50X2J1cyksIE5VTEwsIDApOw0KPiB9DQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3FkZXYtY29yZS5oIGIvaW5jbHVkZS9ody9xZGV2LWNvcmUuaA0KPiBpbmRleCA1MzBm
M2RhNzAyLi4zYmMyMTJhYjNhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3FkZXYtY29yZS5o
DQo+ICsrKyBiL2luY2x1ZGUvaHcvcWRldi1jb3JlLmgNCj4gQEAgLTE1OSw2ICsxNTksNyBAQCBz
dHJ1Y3QgRGV2aWNlQ2xhc3Mgew0KPiAgICAgICovDQo+ICAgICBib29sIHVzZXJfY3JlYXRhYmxl
Ow0KPiAgICAgYm9vbCBob3RwbHVnZ2FibGU7DQo+ICsgICAgYm9vbCBhZG1pbl9wb3dlcl9zdGF0
ZV9zdXBwb3J0ZWQ7DQo+IA0KPiAgICAgLyogY2FsbGJhY2tzICovDQo+ICAgICAvKioNCj4gQEAg
LTIxNyw2ICsyMTgsNTUgQEAgdHlwZWRlZiBRTElTVF9IRUFEKCwgTmFtZWRHUElPTGlzdCkgTmFt
ZWRHUElPTGlzdEhlYWQ7DQo+IHR5cGVkZWYgUUxJU1RfSEVBRCgsIE5hbWVkQ2xvY2tMaXN0KSBO
YW1lZENsb2NrTGlzdEhlYWQ7DQo+IHR5cGVkZWYgUUxJU1RfSEVBRCgsIEJ1c1N0YXRlKSBCdXNT
dGF0ZUhlYWQ7DQo+IA0KPiArLyoqDQo+ICsgKiBlbnVtIERldmljZUFkbWluUG93ZXJTdGF0ZSAt
IEFkbWluaXN0cmF0aXZlIGNvbnRyb2wgc3RhdGVzIGZvciBhIGRldmljZQ0KPiArICoNCj4gKyAq
IFRoaXMgZW51bSBkZWZpbmVzIGFic3RyYWN0IGFkbWluaXN0cmF0aXZlIHN0YXRlcyB1c2VkIGJ5
IFFFTVUgdG8gZW5hYmxlLA0KPiArICogZGlzYWJsZSwgb3IgbG9naWNhbGx5IHJlbW92ZSBhIGRl
dmljZSBmcm9tIHRoZSB2aXJ0dWFsIG1hY2hpbmUuIFRoZXNlDQo+ICsgKiBzdGF0ZXMgcmVmbGVj
dCBhZG1pbmlzdHJhdGl2ZSBjb250cm9sIG92ZXIgYSBkZXZpY2UncyBwb3dlciBhdmFpbGFiaWxp
dHkNCj4gKyAqIGFuZCBwcmVzZW5jZSBpbiB0aGUgc3lzdGVtLiBUaGVzZSBhZG1pbmlzdHJhdGl2
ZSBzdGF0ZXMgYXJlIGRpc3RpbmN0IGZyb20NCj4gKyAqIHJ1bnRpbWUgb3BlcmF0aW9uYWwgcG93
ZXIgc3RhdGVzIChlLmcuLCBQU0NJIHN0YXRlcyBmb3IgQVJNIENQVXMpLiBUaGV5DQo+ICsgKiBy
ZXByZXNlbnQgYWRtaW5pc3RyYXRpdmUgKnBvbGljeSogcmF0aGVyIHRoYW4gcGh5c2ljYWwsIGVs
ZWN0cmljYWwsIG9yDQo+ICsgKiBmdW5jdGlvbmFsIHN0YXRlLg0KPiArICoNCj4gKyAqIEFkbWlu
aXN0cmF0aXZlIHN0YXRlIGlzIG1hbmFnZWQgZXh0ZXJuYWxseSAidmlhIFFNUCwgZmlybXdhcmUs
IG9yIG90aGVyDQo+ICsgKiBob3N0LXNpZGUgcG9saWN5IGFnZW50cyIgYW5kIGFjdHMgYXMgYSBn
YXRpbmcgcG9saWN5IHRoYXQgZGV0ZXJtaW5lcw0KPiArICogd2hldGhlciBndWVzdCBzb2Z0d2Fy
ZSBpcyBwZXJtaXR0ZWQgdG8gaW50ZXJhY3Qgd2l0aCB0aGUgZGV2aWNlLiBNb3N0DQo+ICsgKiBk
ZXZpY2VzIGRlZmF1bHQgdG8gdGhlIEVOQUJMRUQgc3RhdGUgdW5sZXNzIGV4cGxpY2l0bHkgZGlz
YWJsZWQgb3IgcmVtb3ZlZC4NCj4gKyAqDQo+ICsgKiBDaGFuZ2luZyBhIGRldmljZSBhZG1pbmlz
dHJhdGl2ZSBzdGF0ZSBtYXkgZGlyZWN0bHkgb3IgaW5kaXJlY3RseSBhZmZlY3QNCj4gKyAqIGl0
cyBvcGVyYXRpb25hbCBiZWhhdmlvci4gRm9yIGV4YW1wbGUsIGEgRElTQUJMRUQgZGV2aWNlIHdp
bGwgcmVqZWN0IGd1ZXN0DQo+ICsgKiBhdHRlbXB0cyB0byBwb3dlciBpdCBvbiBvciB0cmFuc2l0
aW9uIGl0IG91dCBvZiBhIHN1c3BlbmRlZCBzdGF0ZS4gTm90IGFsbA0KPiArICogZGV2aWNlcyBz
dXBwb3J0IGR5bmFtaWMgdHJhbnNpdGlvbnMgYmV0d2VlbiBhZG1pbmlzdHJhdGl2ZSBzdGF0ZXMu
DQo+ICsgKg0KPiArICogLSBERVZJQ0VfQURNSU5fUE9XRVJfU1RBVEVfRU5BQkxFRDoNCj4gKyAq
ICAgICBUaGUgZGV2aWNlIGlzIGFkbWluaXN0cmF0aXZlbHkgZW5hYmxlZCAoaS5lLiwgbG9naWNh
bGx5IHByZXNlbnQgYW5kDQo+ICsgKiAgICAgcGVybWl0dGVkIHRvIG9wZXJhdGUpLiBHdWVzdCBz
b2Z0d2FyZSBtYXkgY2hhbmdlIGl0cyBvcGVyYXRpb25hbCBzdGF0ZQ0KPiArICogICAgIChlLmcu
LCBhY3RpdmF0ZSwgZGVhY3RpdmF0ZSwgc3VzcGVuZCkgd2l0aGluIGFsbG93ZWQgYXJjaGl0ZWN0
dXJhbA0KPiArICogICAgIHNlbWFudGljcy4gVGhpcyBpcyB0aGUgZGVmYXVsdCBzdGF0ZSBmb3Ig
bW9zdCBkZXZpY2VzIHVubGVzcyBleHBsaWNpdGx5DQo+ICsgKiAgICAgZGlzYWJsZWQgb3IgdW5w
bHVnZ2VkLg0KPiArICoNCj4gKyAqIC0gREVWSUNFX0FETUlOX1BPV0VSX1NUQVRFX0RJU0FCTEVE
Og0KPiArICogICAgIFRoZSBkZXZpY2UgaXMgYWRtaW5pc3RyYXRpdmVseSBkaXNhYmxlZC4gSXQg
cmVtYWlucyBsb2dpY2FsbHkgcHJlc2VudA0KPiArICogICAgIGJ1dCBpcyBibG9ja2VkIGZyb20g
ZnVuY3Rpb25hbCBvcGVyYXRpb24uIEd1ZXN0LWluaXRpYXRlZCB0cmFuc2l0aW9ucw0KPiArICog
ICAgIGFyZSBlaXRoZXIgc3VwcHJlc3NlZCBvciBpZ25vcmVkLiBUaGlzIGlzIHR5cGljYWxseSB1
c2VkIHRvIGVuZm9yY2UNCj4gKyAqICAgICBzaHV0ZG93biwgZGVueSBleGVjdXRpb24sIG9yIG9m
ZmxpbmUgdGhlIGRldmljZSB3aXRob3V0IHJlbW92aW5nIGl0Lg0KPiArICoNCj4gKyAqIC0gREVW
SUNFX0FETUlOX1BPV0VSX1NUQVRFX1JFTU9WRUQ6DQo+ICsgKiAgICAgVGhlIGRldmljZSBoYXMg
YmVlbiBsb2dpY2FsbHkgcmVtb3ZlZCAoZS5nLiwgdmlhIGhvdC11bnBsdWcpLiBJdCBpcyBubw0K
PiArICogICAgIGxvbmdlciBjb25zaWRlcmVkIHByZXNlbnQgb3IgdmlzaWJsZSB0byB0aGUgZ3Vl
c3QuIFRoaXMgc3RhdGUgZXhpc3RzDQo+ICsgKiAgICAgZm9yIHJlcHJlc2VudGF0aW9uYWwgb3Ig
dHJhbnNpdGlvbmFsIHB1cnBvc2VzIG9ubHkuIEluIG1vc3QgY2FzZXMsDQo+ICsgKiAgICAgb25j
ZSByZW1vdmVkLCB0aGUgY29ycmVzcG9uZGluZyBEZXZpY2VTdGF0ZSBvYmplY3QgaXMgZGVzdHJv
eWVkIGFuZA0KPiArICogICAgIG5vIGxvbmdlciB0cmFja2VkLiBUaGlzIGNvbmNlcHQgbWF5IG5v
dCBhcHBseSB0byBzb21lIGRldmljZXMgYXMNCj4gKyAqICAgICBhcmNoaXRlY3R1cmFsIGxpbWl0
YXRpb25zIG1pZ2h0IG1ha2UgdW5wbHVnIG5vdCBtZWFuaW5nZnVsLg0KPiArICovDQo+ICt0eXBl
ZGVmIGVudW0gRGV2aWNlQWRtaW5Qb3dlclN0YXRlIHsNCj4gKyAgICBERVZJQ0VfQURNSU5fUE9X
RVJfU1RBVEVfRU5BQkxFRCA9IDAsDQo+ICsgICAgREVWSUNFX0FETUlOX1BPV0VSX1NUQVRFX0RJ
U0FCTEVELA0KPiArICAgIERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9SRU1PVkVELA0KPiArICAg
IERFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9NQVgNCj4gK30gRGV2aWNlQWRtaW5Qb3dlclN0YXRl
Ow0KPiArDQo+IC8qKg0KPiAgKiBzdHJ1Y3QgRGV2aWNlU3RhdGUgLSBjb21tb24gZGV2aWNlIHN0
YXRlLCBhY2Nlc3NlZCB3aXRoIHFkZXYgaGVscGVycw0KPiAgKg0KPiBAQCAtMjQwLDYgKzI5MCwx
MCBAQCBzdHJ1Y3QgRGV2aWNlU3RhdGUgew0KPiAgICAgICogQHJlYWxpemVkOiBoYXMgZGV2aWNl
IGJlZW4gcmVhbGl6ZWQ/DQo+ICAgICAgKi8NCj4gICAgIGJvb2wgcmVhbGl6ZWQ7DQo+ICsgICAg
LyoqDQo+ICsgICAgICogQGFkbWluX3Bvd2VyX3N0YXRlOiBkZXZpY2UgYWRtaW5pc3RyYXRpdmUg
cG93ZXIgc3RhdGUNCj4gKyAgICAgKi8NCj4gKyAgICBEZXZpY2VBZG1pblBvd2VyU3RhdGUgYWRt
aW5fcG93ZXJfc3RhdGU7DQo+ICAgICAvKioNCj4gICAgICAqIEBwZW5kaW5nX2RlbGV0ZWRfZXZl
bnQ6IHRyYWNrIHBlbmRpbmcgZGVsZXRpb24gZXZlbnRzIGR1cmluZyB1bnBsdWcNCj4gICAgICAq
Lw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuYyBiL3RhcmdldC9hcm0vY3B1LmMNCj4g
aW5kZXggZTJiMjMzNzM5OS4uMGM5YTJlN2VhNCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9j
cHUuYw0KPiArKysgYi90YXJnZXQvYXJtL2NwdS5jDQo+IEBAIC0yNzY1LDYgKzI3NjUsNyBAQCBz
dGF0aWMgdm9pZCBhcm1fY3B1X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lk
ICpkYXRhKQ0KPiAgICAgY2MtPmdkYl9nZXRfY29yZV94bWxfZmlsZSA9IGFybV9nZGJfZ2V0X2Nv
cmVfeG1sX2ZpbGU7DQo+ICAgICBjYy0+Z2RiX3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVl
Ow0KPiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gYXJtX2Rpc2FzX3NldF9pbmZvOw0KPiArICAg
IGRjLT5hZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQgPSB0cnVlOw0KPiANCj4gI2lmZGVmIENP
TkZJR19UQ0cNCj4gICAgIGNjLT50Y2dfb3BzID0gJmFybV90Y2dfb3BzOw0KPiAtLSANCj4gMi4z
NC4xDQo+IA0KDQo=

