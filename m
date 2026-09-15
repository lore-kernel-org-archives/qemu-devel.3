Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B3C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6TCb-0000En-HN; Tue, 15 Sep 2026 09:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1x6TCF-0000Bm-5p
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:27:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1x6TCA-0001rg-7z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:27:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FDMf661261199; Tue, 15 Sep 2026 13:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=prcAv76Wx1wd4lCHtM
 lHtTtyOKt0utZ3uMQ2XAZNHOs=; b=V1hy9gLQYIbIYY+bvCVDc/a/OPqk/NuUhs
 qCFiQ66U5LC6xk6qsfO1Of5vAaDnmHUbR/tDlWBzdTvomkXOm3Mw8GK1vbjOlHHZ
 gAXYOe5l4vcdvAXJwbzCs8HZq8FMOjb4pXul1XJkjN8YOLQa4aFXyml04i5xsUhZ
 RUW7F+CQ+XoUeG4zaNZtVL0yujHRgjNGOht6FEqMulbku6gJ2EHEX9OHMTP09Sqp
 UpDhr5vRmPTgdLBUm7HFkD59KUb/lv/ogIaTaQ1T/KyWxBGmAoGNXpZ9eS8stP2I
 DAmkRAk85WtA3owT9Snv/8rVrZN9Nc9abiIs/prtoemv8t+vVRbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxsbkqvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2026 13:27:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 68FDP5qU034394; Tue, 15 Sep 2026 13:27:25 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4gmw69y2pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2026 13:27:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONFuTc9l0sn+AFaedkPyz0zL+xTXCGcH7l6275xOcMpJLcT7TBMscH/HwoVoNXQUTF1eXt1slDh01zKuWTDHBNFsvkpvIMh//deXFk2v3ZdTOqCCAEYGP8zBe2y7Tpy79XV/+Aewer0e0yntxlwgcSXXOk+4q185ihBewiaVxvg4Nrl+3b04lyhneJx2twNTej3TytZ9NXgB8zumBWu0YpA4ptQzKfhQKzpqExl/gYBPk71UrhLZh3YgufXH5Dm1T7iSca+AFPJuNA73p8eTqVIvHiDW7hyWo8zxmiSpZEXWb1bh2Yzli9RjQZb2ZeD6JO2XW4uC8F90/2dA5U8RcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71tuAyJjvty2uTL+Io+cvVs7mE9yGT3dMhgZ8W+4OPg=;
 b=IvfGRw2nDn2qKQ0x+LPdOdqSNWFKpxZW9d/BmWxH/o5sLXqSqq+FBTkmveUlSJaHmYxmylFf8A+l3QgMwBp4JjMkiFBjwGZGJLMjPta125eOHHLAgG+Wrwp+iulXMyBaUnNtKO1LxPjWEBbCAJkCItLtsu9q4NjGqKPGuG18W9zsc8FRhJqtqlvsjPlMXU+UvHJ7dhBAiUKOxyFEkPOSvAW2DKE2L6Y5z3XIM4HO0+nd+eH55GgYVPQ6faiuxwsW2ertenaiwgC+9fnmzU9OfZ3RbEF8UDDWsx6axsx1k83d2Z7buHYJD3RlpCO9R1h2cMhhjea3x5rucczlWDRtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71tuAyJjvty2uTL+Io+cvVs7mE9yGT3dMhgZ8W+4OPg=;
 b=GS2sHUZNTzJud6g2rTDp+9Qm6nSdaMA1/rwHOjYo9FQDTyQ3/CPmNFcyGgJ80t/gr9g76udsxaAaHv8l5qbi6Rb/4ZAT23fHqCTAbijQndKtP88i1ccCtI5Ts/g6t9BL22BDwQePlPxgA9DELGgwRQtZNZh8fgflzJ5fMKEkfBg=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 13:27:18 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 13:27:17 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Owen Giles <owen.giles@hpe.com>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Owen Giles <owen.giles@hpe.com>
Subject: Re: [PATCH] hw/remote/vfio-user: Reset VFU region flags for each BAR
Thread-Topic: [PATCH] hw/remote/vfio-user: Reset VFU region flags for each BAR
Thread-Index: AQHdRIwXn2YmSIhHvU6Imb6LjRMmXLbPosJj
Date: Tue, 15 Sep 2026 13:27:17 +0000
Message-ID: <301193DF-ED94-48B8-85B3-65DD0E219A60@oracle.com>
References: <20260914205747.1540492-1-owen.giles@hpe.com>
In-Reply-To: <20260914205747.1540492-1-owen.giles@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|CY5PR10MB6190:EE_
x-ms-office365-filtering-correlation-id: a9f9e352-9eba-48af-87a6-08df132d1004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|1800799024|38070700021|56012099006|10067099003|22082099003|18002099003|13003099007|8096899003;
x-microsoft-antispam-message-info: YS1MMdOrbLr6KXhPq5Yl3OYO+LN5bBFFC6J45PWphBdBpRzSelflsG7diILa3bbwbO+jKdryN7z0XPyTDwKBZR8IVledU3jsqnv8KJ7G4rW35eGULsBQtOVJpFULyyqpbWOwVhQGeUwWxZfogCdLbhGMeJ56aa9K/xIKtl1LzmWmJEYRZXhjJ4S5RwDwxyN1ZWfw4j6mf2+comqMVy5gRfUNo6lfZbiHJ//cLmgR6D9GAwJ+pW7L2yGFdDtdsX9ps6c473xQeZzdtzfkHEWWVZCqk/xMO44bnT1abe5XKczFRx8MjkhtgX4/QeVQxoLzvyJ2EH7nqrPA4wdZ1g+JgWE9qtQRWwK9OKeixECti4tAQQQmLg+jFCfcI+aTuY4XfRmDNtAtiqlpkUHYR+1HPScJCgYhJapLgafn/yAksJrdcHRmZEVPimFCx/jUXVCWcnaeQOYHq6vgIX8Pq8lSGNYimGxmZVLPZ4UcYew/cUJ88AbMdjwaDKqbMVVjnBoswjwm73Cvtvcwh+CGh3qK3HBtkMLdqTTvnBaGNjJ6xKUOvfDGjx6GdymSlqDWie2vLjAlRzvy12g/UjvJ6dT0mhMr9IFisAaM3KpAQlUIUFDOq43kR4sx8Nv7IdQWXNTDOXFM/wgqSVuqNq+BtG208IWYSMXcN9Vuu48p4JaP0f8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(1800799024)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xTaFBnVWdUNzNZTGVnM0JiZXUzV0ppOHFkUTg5MzlIM3k5T0E2TDFXaE9t?=
 =?utf-8?B?TjBwb3Z2RG0wdDVPK0RhZUpWdlZrOU42SUI1dSs5dHJUa0xyODMrZm9LWHZY?=
 =?utf-8?B?Y2xZc0o4dEUzTkVUVmx5MnAzSStCc1pVR2UrdzJqTGVKZ2Y5WTZKRWtkQ1Bl?=
 =?utf-8?B?YW0zN0gzelRRV0EzUTR5cEMxK1diWTc2VlNidVo0YmtJYWl5WUtiSHM3QnFX?=
 =?utf-8?B?QU4xbVZXV09iN2VlZThrbCs0dk8xck50Q3JacFRzMWZyM0dpVDBTb0liUnlu?=
 =?utf-8?B?Q3F6M2RNalRTT0RtNERVZjRLMUVJS212c0JUa01JWlIrVzRBUmZtbmx0Sjhs?=
 =?utf-8?B?MU9NWmR1QnNCOXl5aDV4bU9hSDhlcDZuU2RWZkp4anJldlN4OXNTM1JVa2F0?=
 =?utf-8?B?M1gwZmZMQm1ncVUwMS9tRk9RV01ZQTZ6WHU2TXhWbFlLdXJwamdsUzNsZ3dP?=
 =?utf-8?B?NWd0YWJwNU9wSmsyOWtuWVBQQ2dtNFRzeTk3QXU2aWllbGhGVi94cW5nNVk3?=
 =?utf-8?B?aEc3Sll4MkJNRTJNdS90OEtiaW5jNFkwVHlkTmt6VXlHOTNuc3dqRkRFb3VN?=
 =?utf-8?B?Rm9CQ251dkt4Q3RRK2xnQTJTdzFxZjdHcWErQ2tzeFZBL1FodzZ2QkVsaDVy?=
 =?utf-8?B?OWZLQVBoeEl6UmZ2MTd0Q2MrYi9ZbGpRdVE4TUJwM1d3QVR5UGsvMXFWMG5l?=
 =?utf-8?B?OHJ1bmswRzVhREdDalZCLzVmMXI1NytsWCs5Q0prVkFyS09FWjhkbHQ5eHNl?=
 =?utf-8?B?RDcwV0VIenBwWkdWM0F3SmNkV0g2c3YrUlJmMmxwbmVqY2RFb21RekZDYzQ5?=
 =?utf-8?B?Q0d5enM0UkR4T3puWDhyWEZWME13citsZlBERjRhSVg2K1BRaTMxclVtVWJN?=
 =?utf-8?B?UmFCQWNNMi96K3VDQkxha2lMeVA3RmRIU2w4OWhrMDh2bEU2eUp3MHc1U0dy?=
 =?utf-8?B?c2U3VlRBcUlLWWxoNm9UL1ZINUFPelhKTEFyVWdqcmNQZDl4MWQxREdNMkRW?=
 =?utf-8?B?bjVQY3pqaUZzRGVRcWhqUEx6eXpjdTk0NkRBQUUvalNZa1dyelBPaFdmUk0w?=
 =?utf-8?B?aEczWHdYdmY5QnJ6MXVhWHFsN1BhZTk5cWJocW1qWDVNeCtEdnQ3RXFKZVlU?=
 =?utf-8?B?SlpYNXBid203SnA4MXlFTHZ0aFBveGQ2TGxPSzBUN2w4SDRGSldMcDAzRm4z?=
 =?utf-8?B?YVpFL2l0Qk1XQ1YxMmRzWktwRWdyT09qTnRiZ29oQ2VMbXUrTXBsdXVzZWNz?=
 =?utf-8?B?VllrbVpCMGxrRVVaTjk4ZXg3Y2VzS0hHWWZmTURKaloxZ1k5OTMyL2VmZFZ3?=
 =?utf-8?B?bXAzZzl0NzJpTC9hVllqY3Yva3ZpUGgyWXArcFl0L2hhSTFnS3c4SHlNZW9P?=
 =?utf-8?B?ZzJWRThkdnlGMllGM0RvZW1helhEdk5FeUpYQno2ZTVLT2IyN3NyRTNnZFJm?=
 =?utf-8?B?VjRjNXNDUEJ1YjFLc1lmL20xT0F2K2taWDBzbTd1WXo2Vzd2Z0x1UmhrNC9p?=
 =?utf-8?B?ck5BZko0dXphb3VsK2RCK1o3MVd5NDEvYUlCb3RwR1AxWCtXV29uV2g0dnBz?=
 =?utf-8?B?U3MxemFVNzFjVll6RHpIeHpoUHU4NkdVK3RkVS94YXBXQmNDalRWSmtYM2t5?=
 =?utf-8?B?UmMrSmcxUjh0KzVaN1NLWmhqME1FUy9wV1JHVzVDelk5d2FVOFNjSDE1cmNt?=
 =?utf-8?B?aHJtSFI5L29sRzBaSTRXRSs0TDI4TVA1cVlUcTM1aFg0RDFoZG90dTFjd1dN?=
 =?utf-8?B?WUJxZi8veDNITStKMTBLN1JGamUreVlOMk9MS2tzN1hFblFjZkozSFJCZmNM?=
 =?utf-8?B?dWZtTURIemUzdnVncHYrTXdNNDAyZ0FCaG5OSkNaKzZURzZNTTh3UFJKcFpF?=
 =?utf-8?B?V3M3MjUxamt6SjA4ZU5HQjJjbG9MMXNxZW1ZMU5oL0g3UEJPQnFBc0lkOVM1?=
 =?utf-8?B?aVdlbEtuSVhIL0tvWjRaVnBuVEdYVkFoZ3l6Vk5CVnRuYUViTlpBL1pteWRE?=
 =?utf-8?B?MDdsY0V3UkJpSDdnaS9aN3Q3QVRpLzZZYTBSUVRGTUJJOXRXVGJ1QlpncHZ4?=
 =?utf-8?B?NEFUUXNuVjZyS0N6M0xkSG5YeXVpWmtDVmxsUGVxQ3FMMTd6V2RPWnlNRmwy?=
 =?utf-8?B?Sk5tQ3lqVk15bk9RNmswZHp5aXd4TVFFRHFJaExzNmRWTFgvY3M4OG9PZHh6?=
 =?utf-8?B?K2xnOWxKdjhkQ2Y3RFRWcGNkSlBSYkp3R0ZYV2cvcnNxbFo2K1I2REFKTTRQ?=
 =?utf-8?B?VjFDVjRGMjArbHhic3U4c29YRzlneGh0VERhVDZERk5YaWh5V05Fd1J0eTlv?=
 =?utf-8?B?d3lpbFM2amJHQ2ZtemRmb2hxTnYxTnlvTjhyWXpiUnZ0NW1OOVdWK2JwaVZF?=
 =?utf-8?Q?bsUZ072oMFmf7boNztHMyjxlO/rjpTEm989m9J7LfSqtO?=
x-ms-exchange-antispam-messagedata-1: l2i22wM/xQOnig==
Content-Type: multipart/alternative;
 boundary="_000_301193DFED9448B885B365DD0E219A60oraclecom_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YxlVmXQ2o+YkPhSuP9CjaoPwjdEEUq3Sf4U8zi5hHG/8ycOAPXSsyu5WfOLJwZXBE0ov56vKl5q8xXjJlXvtf1yEuAZtp+cwlvks3NIPRKExtpZb/QZDiaA2aV4tTF/b2zAatnJ2WPDCXQMIsYLcjCd4VLlgRGYnCPLBsFQrVMVBjUPGIb5MRtuKzb6cL/SRRY6UR4q1XFN4ZBcyNNAslSj1E9SKr6z+M56hIemDBPn4AGjY+yzHVfZvb12kC4yZc1rAVwnJYrTNz3i/hur159MnG16HO7+8L5ieRBIOzkJ2ek6MUOCSCt7eL08UH8ZBOAjt6OhMFAPRsFhhVCZ7RA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fr4lCATZfNuu/hBTHhC+zNaf0GF5A6CmqZFZZIZAsYiPdtlnmPsLwLDEExgc0Zk5Lm1WPZIZ08HYcnFd+oXcI4J1Wokvd1IemUiGWph8AltMzz4MiXyT5XbLkTQPbduT6QrO0rjCyGl8ERlfLYixp/gE8EKMdh9qctfU3IsgfWhsoY3RjYkfBuYIOwiHwflFcrQpzHYN/ixl0qw+srqnYBGLBGFBVfdFlScg3THNFd8XBDsWCp7KB1JxEoxmTEyMrmkFbRt70imzBjp29NB/oiigMSdz1KuPbvl0fgsWD2UMsLL//lA1S6pBGHmLrBHZRQUKJrYlK77a3RGHrz+6MUoE5tyC7sx4/A6C/Ibo5QzkiMeoVFxPXCnrATzANBGx++5ipNvgMEqfrSSRkJYw4LXUiCtSrQr1tM/5Nj1QAtwCzx30UQiSRi0x+zQGEj4eoZJDNVI+lUyc4wT0xIZtfLrtWMxOBuKN6IF4LwUEAhcXEobPHx2fmisSskWwdk0P4HSRG/drUQkEvYjrgYzKLyIypC7edY9xdTP4W03HaR/LteQuRuiHLAlbynnX4kkg6J+GUo52BpIAXABTbhd2QZqUSphNB74HGNy3DPBjnYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9e352-9eba-48af-87a6-08df132d1004
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 13:27:17.2867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3AiT3l1YLow+ZCk2R94fe8qkryhgO8Ptk8+9TY1aHysZnhHYpvN9dKONmYmOL05qnv2MnTFVvWZJWqLqYTG8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609150195
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX/YkaH8sZdnFh
 P8hy1hUy7MQav3xhMh1Ep6BEV2MfSs0Cfwg680JPM6+lygXgAnceh++iWbkSwJfsB5ojRMUjA4D
 gdepBAdMsGJGkz5wOrg2qdGX68NX557Lvh8cdfc7kIncEtROCM22kq/4+G5P9uw/92fjdHWNAW3
 6w3mXJHrikON4n8P901XoWYyXF6SuB1zVC6krPSFZidHfyGK/o5WjdZzdGGN5BvIq7ypgSdh/o0
 +2AZwkqLeBLPJKSmqcMNGylTbrPK1XA9/Ex9qASlaemP65nbnZCjWwb75XnWylK+dMcq8z9PHTC
 GC+TLm3Yr4hA9EHdK5FAgbkhfqx9Ak1aDEwrvpJklhVf3OUlxpkYYMODLe88gA6kUab4IwdYxx3
 0TwwsuCzSlKmW0oWevVf6giqRgg9OvfOENr4bfVd6gJlX7/4TOWrNA6drrkdQg57A/Z+Lyfm7Z/
 c56WrO+nPPnSROVxyfA==
X-Proofpoint-GUID: SPEZSu_eilBOKQcqKT-fJBsoiufMbUlL
X-Authority-Analysis: v=2.4 cv=dY0VTnXe c=1 sm=1 tr=0 ts=6aa947be b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=RpNjiQI2AAAA:8 a=MvuuwTCpAAAA:8 a=yPCof4ZbAAAA:8 a=0thZwZTv52yYttqKn0EA:9
 a=QEXdDO2ut3YA:10 a=tqdMzFhGG8mD8GCBlf4leDhY3gs=:19
 a=sTxRpBpiy98KL1WkT8X2XIWo+SM=:19 a=_b7VWbQT49lICa4H:21 a=_W_S_7VecoQA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: SPEZSu_eilBOKQcqKT-fJBsoiufMbUlL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX2kkMbkJQyULX
 DvZmyaGDfDSfTXDaJ5h8RXWJ9nPdmstTN86Q/4V0+0tCf5M9GKuR8jTOMN4Pe6N14LIKi0fHN2w
 36A/9rXMO3CKy2z7qx0i4+VXZS9MxDEDlkGTskD37UQyP9rmb6xC
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_301193DFED9448B885B365DD0E219A60oraclecom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Sep 14, 2026, at 5:00=E2=80=AFPM, Owen Giles <owen.giles@hpe.com> wrote:

=EF=BB=BF
flags is only initialized once before the BAR setup loop, so if a lower BAR=
's io_region is read only, every subsequent BAR will have its flags set as =
read only despite not being read only. By setting flags to RW in every iter=
ation, each region


flags is only initialized once before the BAR setup loop, so if a lower
BAR's io_region is read only, every subsequent BAR will have its
flags set as read only despite not being read only. By setting flags to
RW in every iteration, each region is properly assessed and assigned
the proper flag.

Fixes: 3123f93d6b85 ("vfio-user: handle PCI BAR accesses")
Signed-off-by: Owen Giles <owen.giles@hpe.com>


Thank you for the patch!

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

---

Notes:
    The ROM case of the read-only check is okay, as the ROM will always be =
the
    last in the loop, but the other check is what can result in unintended
    consequences.

 hw/remote/vfio-user-obj.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index a0498d218fa..67687c841a6 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -519,14 +519,15 @@ static vfu_region_access_cb_t *vfu_object_bar_handler=
s[PCI_NUM_REGIONS] =3D {
  */
 static void vfu_object_register_bars(vfu_ctx_t *vfu_ctx, PCIDevice *pdev)
 {
-    int flags =3D VFU_REGION_FLAG_RW;
-    int i;
+    int flags, i;

     for (i =3D 0; i < PCI_NUM_REGIONS; i++) {
         if (!pdev->io_regions[i].size) {
             continue;
         }

+        flags =3D VFU_REGION_FLAG_RW;
+
         if ((i =3D=3D VFU_PCI_DEV_ROM_REGION_IDX) ||
             pdev->io_regions[i].memory->readonly) {
             flags &=3D ~VFU_REGION_FLAG_WRITE;
--
2.34.1



--_000_301193DFED9448B885B365DD0E219A60oraclecom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html class=3D"apple-mail-supports-explicit-dark-mode">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
</head>
<body dir=3D"auto">
<div dir=3D"ltr"></div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr"><br>
<blockquote type=3D"cite">On Sep 14, 2026, at 5:00=E2=80=AFPM, Owen Giles &=
lt;owen.giles@hpe.com&gt; wrote:<br>
<br>
</blockquote>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">=EF=BB=BF<!-- BaNnErBlUrFlE-BoDy-start --><!-- Preheader T=
ext : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">
flags is only initialized once before the BAR setup loop, so if a lower BAR=
's io_region is read only, every subsequent BAR will have its flags set as =
read only despite not being read only. By setting flags to RW in every iter=
ation, each region</div>
<!-- Preheader Text : END --><!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">
</div>
<!-- Email Banner : END --><!-- BaNnErBlUrFlE-BoDy-end --><!-- BaNnErBlUrFl=
E-HeAdEr-start --><style>#pfptBannerf262sar { appearance: revert !important=
; color-scheme: revert !important; math-depth: revert !important; ruby-posi=
tion: revert !important; writing-mode: revert !important; font-family: reve=
rt !important; font-feature-settings: revert !important; font-kerning: reve=
rt !important; font-optical-sizing: revert !important; font-palette: revert=
 !important; font-size: revert !important; font-size-adjust: revert !import=
ant; font-style: revert !important; font-synthesis-small-caps: revert !impo=
rtant; font-synthesis-style: revert !important; font-synthesis-weight: reve=
rt !important; font-variant-alternates: revert !important; font-variant-cap=
s: revert !important; font-variant-east-asian: revert !important; font-vari=
ant-ligatures: revert !important; font-variant-numeric: revert !important; =
font-variant-position: revert !important; font-variation-settings: revert !=
important; font-weight: revert !important; font-width: revert !important; t=
ext-orientation: revert !important; text-rendering: revert !important; zoom=
: revert !important; -webkit-font-smoothing: revert !important; -webkit-loc=
ale: revert !important; -webkit-text-size-adjust: revert !important; -webki=
t-text-zoom: revert !important; letter-spacing: revert !important; text-aut=
ospace: revert !important; word-spacing: revert !important; background-imag=
e: revert !important; mask: revert !important; accent-color: revert !import=
ant; place-content: revert !important; place-items: revert !important; plac=
e-self: revert !important; alignment-baseline: revert !important; anchor-na=
me: revert !important; anchor-scope: revert !important; animation-compositi=
on: revert !important; animation: revert !important; aspect-ratio: revert !=
important; backdrop-filter: revert !important; backface-visibility: revert =
!important; background-attachment: revert !important; background-blend-mode=
: revert !important; background-clip: revert !important; background-origin:=
 revert !important; background-position: revert !important; background-repe=
at: revert !important; background-size: revert !important; baseline-shift: =
revert !important; border-collapse: revert !important; border: revert !impo=
rtant; box-shadow: revert !important; box-sizing: revert !important; break-=
after: revert !important; break-before: revert !important; break-inside: re=
vert !important; buffered-rendering: revert !important; caption-side: rever=
t !important; caret-color: revert !important; clear: revert !important; cli=
p: revert !important; clip-path: revert !important; clip-rule: revert !impo=
rtant; color: revert !important; color-interpolation: revert !important; co=
lor-interpolation-filters: revert !important; column-count: revert !importa=
nt; column-fill: revert !important; gap: revert !important; column-rule-col=
or: revert !important; column-rule-style: revert !important; column-rule-wi=
dth: revert !important; column-span: revert !important; column-width: rever=
t !important; contain: revert !important; container-name: revert !important=
; container-type: revert !important; content: revert !important; content-vi=
sibility: revert !important; counter-increment: revert !important; counter-=
reset: revert !important; counter-set: revert !important; cursor: revert !i=
mportant; cx: revert !important; cy: revert !important; dominant-baseline: =
revert !important; dynamic-range-limit: revert !important; empty-cells: rev=
ert !important; field-sizing: revert !important; fill: revert !important; f=
ill-opacity: revert !important; fill-rule: revert !important; filter: rever=
t !important; flex: revert !important; flex-flow: revert !important; float:=
 revert !important; flood-color: revert !important; flood-opacity: revert !=
important; flow-tolerance: revert !important; glyph-orientation-vertical: r=
evert !important; grid: revert !important; grid-column-end: revert !importa=
nt; grid-column-start: revert !important; grid-row-end: revert !important; =
grid-row-start: revert !important; hanging-punctuation: revert !important; =
hyphenate-character: revert !important; hyphens: revert !important; image-o=
rientation: revert !important; image-rendering: revert !important; isolatio=
n: revert !important; lighting-color: revert !important; line-break: revert=
 !important; line-height: revert !important; list-style: revert !important;=
 margin-trim: revert !important; marker: revert !important; mask-composite:=
 revert !important; mask-mode: revert !important; mask-type: revert !import=
ant; math-shift: revert !important; math-style: revert !important; mix-blen=
d-mode: revert !important; object-fit: revert !important; object-position: =
revert !important; offset-anchor: revert !important; offset-distance: rever=
t !important; offset-path: revert !important; offset-position: revert !impo=
rtant; offset-rotate: revert !important; order: revert !important; orphans:=
 revert !important; outline: revert !important; outline-offset: revert !imp=
ortant; overflow-anchor: revert !important; overflow-wrap: revert !importan=
t; page: revert !important; paint-order: revert !important; perspective: re=
vert !important; perspective-origin: revert !important; pointer-events: rev=
ert !important; position: revert !important; position-anchor: revert !impor=
tant; position-area: revert !important; position-try: revert !important; po=
sition-visibility: revert !important; print-color-adjust: revert !important=
; quotes: revert !important; r: revert !important; resize: revert !importan=
t; rotate: revert !important; ruby-align: revert !important; ruby-overhang:=
 revert !important; rx: revert !important; ry: revert !important; scale: re=
vert !important; scroll-behavior: revert !important; scroll-snap-align: rev=
ert !important; scroll-snap-stop: revert !important; scroll-snap-type: reve=
rt !important; scroll-timeline: revert !important; scrollbar-color: revert =
!important; scrollbar-gutter: revert !important; scrollbar-width: revert !i=
mportant; shape-image-threshold: revert !important; shape-margin: revert !i=
mportant; shape-outside: revert !important; shape-rendering: revert !import=
ant; speak-as: revert !important; stop-color: revert !important; stop-opaci=
ty: revert !important; stroke: revert !important; stroke-color: revert !imp=
ortant; stroke-dasharray: revert !important; stroke-dashoffset: revert !imp=
ortant; stroke-linecap: revert !important; stroke-linejoin: revert !importa=
nt; stroke-miterlimit: revert !important; stroke-opacity: revert !important=
; stroke-width: revert !important; tab-size: revert !important; table-layou=
t: revert !important; text-align: revert !important; text-align-last: rever=
t !important; text-anchor: revert !important; text-box: revert !important; =
text-combine-upright: revert !important; text-decoration: revert !important=
; text-decoration-skip-ink: revert !important; text-emphasis-color: revert =
!important; text-emphasis-position: revert !important; text-emphasis-style:=
 revert !important; text-indent: revert !important; text-overflow: revert !=
important; text-shadow: revert !important; text-transform: revert !importan=
t; text-underline-offset: revert !important; text-underline-position: rever=
t !important; text-wrap: revert !important; timeline-scope: revert !importa=
nt; touch-action: revert !important; transform: revert !important; transfor=
m-box: revert !important; transform-origin: revert !important; transform-st=
yle: revert !important; transition: revert !important; translate: revert !i=
mportant; vector-effect: revert !important; vertical-align: revert !importa=
nt; view-timeline: revert !important; view-transition-class: revert !import=
ant; view-transition-name: revert !important; white-space: revert !importan=
t; widows: revert !important; will-change: revert !important; word-break: r=
evert !important; x: revert !important; y: revert !important; z-index: reve=
rt !important; -apple-color-filter: revert !important; -apple-pay-button-st=
yle: revert !important; -apple-pay-button-type: revert !important; -webkit-=
backdrop-filter: revert !important; -webkit-background-clip: revert !import=
ant; -webkit-background-origin: revert !important; border-spacing: revert !=
important; -webkit-box-align: revert !important; -webkit-box-decoration-bre=
ak: revert !important; -webkit-box-direction: revert !important; -webkit-bo=
x-flex: revert !important; -webkit-box-flex-group: revert !important; -webk=
it-box-lines: revert !important; -webkit-box-ordinal-group: revert !importa=
nt; -webkit-box-orient: revert !important; -webkit-box-pack: revert !import=
ant; -webkit-box-reflect: revert !important; -webkit-box-shadow: revert !im=
portant; -webkit-column-axis: revert !important; -webkit-column-progression=
: revert !important; -webkit-cursor-visibility: revert !important; -webkit-=
hyphenate-limit-after: revert !important; -webkit-hyphenate-limit-before: r=
evert !important; -webkit-hyphenate-limit-lines: revert !important; -webkit=
-initial-letter: revert !important; -webkit-line-align: revert !important; =
-webkit-line-box-contain: revert !important; -webkit-line-clamp: revert !im=
portant; -webkit-line-grid: revert !important; -webkit-line-snap: revert !i=
mportant; mask-size: revert !important; -webkit-mask: revert !important; -w=
ebkit-mask-composite: revert !important; -webkit-mask-source-type: revert !=
important; -webkit-nbsp-mode: revert !important; -webkit-overflow-scrolling=
: revert !important; -webkit-rtl-ordering: revert !important; -webkit-ruby-=
position: revert !important; -webkit-tap-highlight-color: revert !important=
; -webkit-text-combine: revert !important; -webkit-text-decorations-in-effe=
ct: revert !important; -webkit-text-fill-color: revert !important; -webkit-=
text-security: revert !important; -webkit-text-stroke-color: revert !import=
ant; -webkit-text-stroke-width: revert !important; -webkit-touch-callout: r=
evert !important; -webkit-user-drag: revert !important; -webkit-user-modify=
: revert !important; -webkit-user-select: revert !important; border-radius:=
 revert !important; inset: revert !important; contain-intrinsic-size: rever=
t !important; height: revert !important; margin: revert !important; min-hei=
ght: revert !important; min-width: revert !important; overflow: revert !imp=
ortant; overscroll-behavior: revert !important; padding: revert !important;=
 scroll-margin: revert !important; scroll-padding: revert !important; width=
: revert !important; block-size: revert !important; border-block: revert !i=
mportant; border-end-end-radius: revert !important; border-end-start-radius=
: revert !important; border-inline: revert !important; border-start-end-rad=
ius: revert !important; border-start-start-radius: revert !important; conta=
in-intrinsic-block-size: revert !important; contain-intrinsic-inline-size: =
revert !important; inline-size: revert !important; inset-block: revert !imp=
ortant; inset-inline: revert !important; margin-block: revert !important; m=
argin-inline: revert !important; max-block-size: revert !important; max-inl=
ine-size: revert !important; min-block-size: revert !important; min-inline-=
size: revert !important; overflow-block: revert !important; overflow-inline=
: revert !important; overscroll-behavior-block: revert !important; overscro=
ll-behavior-inline: revert !important; padding-block: revert !important; pa=
dding-inline: revert !important; scroll-margin-block: revert !important; sc=
roll-margin-inline: revert !important; scroll-padding-block: revert !import=
ant; scroll-padding-inline: revert !important; display: block !important; v=
isibility: visible !important; opacity: 1 !important; background-color: rgb=
(194, 212, 212) !important; max-width: none !important; max-height: none !i=
mportant; }
.pfptPrimaryButtonf262sar:hover, .pfptPrimaryButtonf262sar:focus { backgrou=
nd-color: rgb(162, 177, 177) !important; }
.pfptPrimaryButtonf262sar:active { background-color: rgb(130, 142, 142) !im=
portant; }
html:root, html:root > body { appearance: revert !important; color-scheme: =
revert !important; math-depth: revert !important; ruby-position: revert !im=
portant; writing-mode: revert !important; font-family: revert !important; f=
ont-feature-settings: revert !important; font-kerning: revert !important; f=
ont-optical-sizing: revert !important; font-palette: revert !important; fon=
t-size: revert !important; font-size-adjust: revert !important; font-style:=
 revert !important; font-synthesis-small-caps: revert !important; font-synt=
hesis-style: revert !important; font-synthesis-weight: revert !important; f=
ont-variant-alternates: revert !important; font-variant-caps: revert !impor=
tant; font-variant-east-asian: revert !important; font-variant-ligatures: r=
evert !important; font-variant-numeric: revert !important; font-variant-pos=
ition: revert !important; font-variation-settings: revert !important; font-=
weight: revert !important; font-width: revert !important; text-orientation:=
 revert !important; text-rendering: revert !important; zoom: revert !import=
ant; -webkit-font-smoothing: revert !important; -webkit-locale: revert !imp=
ortant; -webkit-text-size-adjust: revert !important; -webkit-text-zoom: rev=
ert !important; letter-spacing: revert !important; text-autospace: revert !=
important; word-spacing: revert !important; background: revert !important; =
mask: revert !important; accent-color: revert !important; place-content: re=
vert !important; place-items: revert !important; place-self: revert !import=
ant; alignment-baseline: revert !important; anchor-name: revert !important;=
 anchor-scope: revert !important; animation-composition: revert !important;=
 animation: revert !important; aspect-ratio: revert !important; backdrop-fi=
lter: revert !important; backface-visibility: revert !important; background=
-blend-mode: revert !important; baseline-shift: revert !important; border-c=
ollapse: revert !important; border: revert !important; box-shadow: revert !=
important; box-sizing: revert !important; break-after: revert !important; b=
reak-before: revert !important; break-inside: revert !important; buffered-r=
endering: revert !important; caption-side: revert !important; caret-color: =
revert !important; clear: revert !important; clip: revert !important; clip-=
path: revert !important; clip-rule: revert !important; color: revert !impor=
tant; color-interpolation: revert !important; color-interpolation-filters: =
revert !important; column-count: revert !important; column-fill: revert !im=
portant; gap: revert !important; column-rule-color: revert !important; colu=
mn-rule-style: revert !important; column-rule-width: revert !important; col=
umn-span: revert !important; column-width: revert !important; contain: reve=
rt !important; container-name: revert !important; container-type: revert !i=
mportant; content: revert !important; content-visibility: revert !important=
; counter-increment: revert !important; counter-reset: revert !important; c=
ounter-set: revert !important; cursor: revert !important; cx: revert !impor=
tant; cy: revert !important; dominant-baseline: revert !important; dynamic-=
range-limit: revert !important; empty-cells: revert !important; field-sizin=
g: revert !important; fill: revert !important; fill-opacity: revert !import=
ant; fill-rule: revert !important; filter: revert !important; flex: revert =
!important; flex-flow: revert !important; float: revert !important; flood-c=
olor: revert !important; flood-opacity: revert !important; flow-tolerance: =
revert !important; glyph-orientation-vertical: revert !important; grid: rev=
ert !important; grid-column-end: revert !important; grid-column-start: reve=
rt !important; grid-row-end: revert !important; grid-row-start: revert !imp=
ortant; hanging-punctuation: revert !important; hyphenate-character: revert=
 !important; hyphens: revert !important; image-orientation: revert !importa=
nt; image-rendering: revert !important; isolation: revert !important; light=
ing-color: revert !important; line-break: revert !important; line-height: r=
evert !important; list-style: revert !important; margin-trim: revert !impor=
tant; marker: revert !important; mask-composite: revert !important; mask-mo=
de: revert !important; mask-type: revert !important; math-shift: revert !im=
portant; math-style: revert !important; mix-blend-mode: revert !important; =
object-fit: revert !important; object-position: revert !important; offset-a=
nchor: revert !important; offset-distance: revert !important; offset-path: =
revert !important; offset-position: revert !important; offset-rotate: rever=
t !important; order: revert !important; orphans: revert !important; outline=
: revert !important; outline-offset: revert !important; overflow-anchor: re=
vert !important; overflow-wrap: revert !important; page: revert !important;=
 paint-order: revert !important; perspective: revert !important; perspectiv=
e-origin: revert !important; pointer-events: revert !important; position: r=
evert !important; position-anchor: revert !important; position-area: revert=
 !important; position-try: revert !important; position-visibility: revert !=
important; print-color-adjust: revert !important; quotes: revert !important=
; r: revert !important; resize: revert !important; rotate: revert !importan=
t; ruby-align: revert !important; ruby-overhang: revert !important; rx: rev=
ert !important; ry: revert !important; scale: revert !important; scroll-beh=
avior: revert !important; scroll-snap-align: revert !important; scroll-snap=
-stop: revert !important; scroll-snap-type: revert !important; scroll-timel=
ine: revert !important; scrollbar-color: revert !important; scrollbar-gutte=
r: revert !important; scrollbar-width: revert !important; shape-image-thres=
hold: revert !important; shape-margin: revert !important; shape-outside: re=
vert !important; shape-rendering: revert !important; speak-as: revert !impo=
rtant; stop-color: revert !important; stop-opacity: revert !important; stro=
ke: revert !important; stroke-color: revert !important; stroke-dasharray: r=
evert !important; stroke-dashoffset: revert !important; stroke-linecap: rev=
ert !important; stroke-linejoin: revert !important; stroke-miterlimit: reve=
rt !important; stroke-opacity: revert !important; stroke-width: revert !imp=
ortant; tab-size: revert !important; table-layout: revert !important; text-=
align: revert !important; text-align-last: revert !important; text-anchor: =
revert !important; text-box: revert !important; text-combine-upright: rever=
t !important; text-decoration: revert !important; text-decoration-skip-ink:=
 revert !important; text-emphasis-color: revert !important; text-emphasis-p=
osition: revert !important; text-emphasis-style: revert !important; text-in=
dent: revert !important; text-overflow: revert !important; text-shadow: rev=
ert !important; text-transform: revert !important; text-underline-offset: r=
evert !important; text-underline-position: revert !important; text-wrap: re=
vert !important; timeline-scope: revert !important; touch-action: revert !i=
mportant; transform: revert !important; transform-box: revert !important; t=
ransform-origin: revert !important; transform-style: revert !important; tra=
nsition: revert !important; translate: revert !important; vector-effect: re=
vert !important; vertical-align: revert !important; view-timeline: revert !=
important; view-transition-class: revert !important; view-transition-name: =
revert !important; white-space: revert !important; widows: revert !importan=
t; will-change: revert !important; word-break: revert !important; x: revert=
 !important; y: revert !important; z-index: revert !important; -apple-color=
-filter: revert !important; -apple-pay-button-style: revert !important; -ap=
ple-pay-button-type: revert !important; -webkit-backdrop-filter: revert !im=
portant; -webkit-background-clip: revert !important; -webkit-background-ori=
gin: revert !important; border-spacing: revert !important; -webkit-box-alig=
n: revert !important; -webkit-box-decoration-break: revert !important; -web=
kit-box-direction: revert !important; -webkit-box-flex: revert !important; =
-webkit-box-flex-group: revert !important; -webkit-box-lines: revert !impor=
tant; -webkit-box-ordinal-group: revert !important; -webkit-box-orient: rev=
ert !important; -webkit-box-pack: revert !important; -webkit-box-reflect: r=
evert !important; -webkit-box-shadow: revert !important; -webkit-column-axi=
s: revert !important; -webkit-column-progression: revert !important; -webki=
t-cursor-visibility: revert !important; -webkit-hyphenate-limit-after: reve=
rt !important; -webkit-hyphenate-limit-before: revert !important; -webkit-h=
yphenate-limit-lines: revert !important; -webkit-initial-letter: revert !im=
portant; -webkit-line-align: revert !important; -webkit-line-box-contain: r=
evert !important; -webkit-line-clamp: revert !important; -webkit-line-grid:=
 revert !important; -webkit-line-snap: revert !important; mask-size: revert=
 !important; -webkit-mask: revert !important; -webkit-mask-composite: rever=
t !important; -webkit-mask-source-type: revert !important; -webkit-nbsp-mod=
e: revert !important; -webkit-overflow-scrolling: revert !important; -webki=
t-rtl-ordering: revert !important; -webkit-ruby-position: revert !important=
; -webkit-tap-highlight-color: revert !important; -webkit-text-combine: rev=
ert !important; -webkit-text-decorations-in-effect: revert !important; -web=
kit-text-fill-color: revert !important; -webkit-text-security: revert !impo=
rtant; -webkit-text-stroke-color: revert !important; -webkit-text-stroke-wi=
dth: revert !important; -webkit-touch-callout: revert !important; -webkit-u=
ser-drag: revert !important; -webkit-user-modify: revert !important; -webki=
t-user-select: revert !important; border-radius: revert !important; inset: =
revert !important; contain-intrinsic-size: revert !important; height: rever=
t !important; margin: revert !important; max-height: revert !important; max=
-width: revert !important; min-height: revert !important; min-width: revert=
 !important; overflow: revert !important; overscroll-behavior: revert !impo=
rtant; padding: revert !important; scroll-margin: revert !important; scroll=
-padding: revert !important; width: revert !important; block-size: revert !=
important; border-block: revert !important; border-end-end-radius: revert !=
important; border-end-start-radius: revert !important; border-inline: rever=
t !important; border-start-end-radius: revert !important; border-start-star=
t-radius: revert !important; contain-intrinsic-block-size: revert !importan=
t; contain-intrinsic-inline-size: revert !important; inline-size: revert !i=
mportant; inset-block: revert !important; inset-inline: revert !important; =
margin-block: revert !important; margin-inline: revert !important; max-bloc=
k-size: revert !important; max-inline-size: revert !important; min-block-si=
ze: revert !important; min-inline-size: revert !important; overflow-block: =
revert !important; overflow-inline: revert !important; overscroll-behavior-=
block: revert !important; overscroll-behavior-inline: revert !important; pa=
dding-block: revert !important; padding-inline: revert !important; scroll-m=
argin-block: revert !important; scroll-margin-inline: revert !important; sc=
roll-padding-block: revert !important; scroll-padding-inline: revert !impor=
tant; display: block !important; visibility: visible !important; opacity: 1=
 !important; }</style><!-- BaNnErBlUrFlE-HeAdEr-end -->
<pre style=3D"font-family: sans-serif; font-size: 100%; white-space: pre-wr=
ap; word-wrap: break-word">flags is only initialized once before the BAR se=
tup loop, so if a lower
BAR's io_region is read only, every subsequent BAR will have its
flags set as read only despite not being read only. By setting flags to
RW in every iteration, each region is properly assessed and assigned
the proper flag.

Fixes: 3123f93d6b85 (&quot;vfio-user: handle PCI BAR accesses&quot;)
Signed-off-by: Owen Giles &lt;owen.giles@hpe.com&gt;
</pre>
</div>
</blockquote>
Thank you for the patch!
<div><br>
</div>
<div>Reviewed-by: Jagannathan Raman &lt;jag.raman@oracle.com&gt;<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<pre style=3D"font-family: sans-serif; font-size: 100%; white-space: pre-wr=
ap; word-wrap: break-word">---

Notes:
    The ROM case of the read-only check is okay, as the ROM will always be =
the
    last in the loop, but the other check is what can result in unintended
    consequences.

 hw/remote/vfio-user-obj.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index a0498d218fa..67687c841a6 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -519,14 +519,15 @@ static vfu_region_access_cb_t *vfu_object_bar_handler=
s[PCI_NUM_REGIONS] =3D {
  */
 static void vfu_object_register_bars(vfu_ctx_t *vfu_ctx, PCIDevice *pdev)
 {
-    int flags =3D VFU_REGION_FLAG_RW;
-    int i;
+    int flags, i;
=20
     for (i =3D 0; i &lt; PCI_NUM_REGIONS; i++) {
         if (!pdev-&gt;io_regions[i].size) {
             continue;
         }
=20
+        flags =3D VFU_REGION_FLAG_RW;
+
         if ((i =3D=3D VFU_PCI_DEV_ROM_REGION_IDX) ||
             pdev-&gt;io_regions[i].memory-&gt;readonly) {
             flags &amp;=3D ~VFU_REGION_FLAG_WRITE;
--=20
2.34.1

</pre>
</div>
</blockquote>
</div>
</body>
</html>

--_000_301193DFED9448B885B365DD0E219A60oraclecom_--

