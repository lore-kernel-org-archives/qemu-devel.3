Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8560C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeU5-0001Ew-Ix; Fri, 20 Jun 2025 12:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uSeU4-0001Ek-8v; Fri, 20 Jun 2025 12:20:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uSeU2-0006ZU-5K; Fri, 20 Jun 2025 12:20:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBjex022870;
 Fri, 20 Jun 2025 16:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=yIZnCEGNQk25T7ghxoBSbSb7/Qp7pd6yfOSEkkzPDM0=; b=
 lB5DiEki5BskksqAu8Lgp6vICYJoinxGqT0srAvdHe5JJiUyJQBQ3AwVrwLgSD38
 BI9SI0LccLuonOmRmldWx4KSL0g87h5zPKbB3V6mtRBq7WJM2t29ZFEqNIYre5bN
 veXlCiUUyPJFAWVOrYeoid86wf3KqwKfSMzwGRPO7+VEIAgSz47tkfh93F+9a/G8
 XeP+uOa97GlSDp2FOsvR0gIT3HdkpkWJ9oP8GroqOk2BXj9KYVGa5Ef3PO1uXSnb
 RwjQ41OoNXF4JAsUiaV8dMccUVs8koltlRPaKxEyHKLzf4TVEpmz4S6rlvxwSG0u
 WB1/fiWUIi6w5UxJSN9MIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv5bx5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Jun 2025 16:20:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55KF5ZIY021546; Fri, 20 Jun 2025 16:20:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 478yhcv0rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Jun 2025 16:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwdrocUiq09DLVQPbd1KdkJPQ4Sy4Sfkn8aDf3zNXxMyQlXTb+0MmASeXuaJe66q25ccOc5a368Zbqb5MpMRXShJPZAM8zXBTzCazv2Lng2a167L7JjPgr1WlTgQu0tWeTIgiRvK6wPK1uzkYjOpeXhOAYfzq7qaR6c3kw1PzBczCfdz3UNWrZiIV0LG4zNV32/+TX1nR13fCw1ROKTyzsCpjBKbaxfuvPktfSCJGkbkc9T0FOchuwwZSjcf8ga1QukDEXhhZsdN09mmLKi15BAW4Gc1PH5T/2f/JqU9ZgeUmKZxh+qBRfS4U5tNVg8YQ2nikhJzMzjZr3T30NUWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIZnCEGNQk25T7ghxoBSbSb7/Qp7pd6yfOSEkkzPDM0=;
 b=ozLs9pVPPsa6zGRUvIyrOO0oPM9e5rHxZeD+nz053qPCBJmUrjHLPbTpfSr+TXtMHnHBbfFEyUjsb1nUiYY9a0sf5j9cgF1MLuApdOHf8mWDRmAz1MWyFZJqN03sjaxK4xedwGqlzZlebFZzSDBo5iETTKlLAaWZMFZAoDV/3Nwr4d2SVCC+UFhxEgLOPw93Gc2fMr/+gWNfzMOL/W3I3qz9vzMGfQyF77BHo4QmEcvMCOzifd20z9WY4UTXLDmW9V2cotoPXjVNPeD8QsKEBH9we9mdjS14kNplOSxy3EtcTzmLqu98ML7pRdBj+AGkIk0WVxkI4LKoSV0ro4OXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIZnCEGNQk25T7ghxoBSbSb7/Qp7pd6yfOSEkkzPDM0=;
 b=OtBp58+HzpZ1zcWeoKGtYJhBDx5Mb/aL0CkF6K6c3vTUwXO/YcpnTShr+lNkUxU4bUZaqs5LDWV096jPZCp17jvheGeuwuq2OnMaOsGiYwdJwZbzlJyfptAAdk65DlJFI6JmfnAC4ONErcM+o1FYI0yaCDZOE8E0Gl85LEceCIs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB7692.namprd10.prod.outlook.com (2603:10b6:a03:51a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 16:20:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 16:20:37 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
CC: Alyssa Ross <hi@alyssa.is>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Topic: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Index: AQHbztBANNalBs/OM0mEgKpxsV1Eb7QHh2YAgAASmQCAAAUTAIAAAnMAgAL9PgCAAcISAA==
Date: Fri, 20 Jun 2025 16:20:36 +0000
Message-ID: <667E3301-60E3-49AC-9821-9086C8DBE4D1@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
 <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
 <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
 <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
 <01ab0b6e-ccd5-4465-98c0-70b8ec2ac87a@redhat.com>
In-Reply-To: <01ab0b6e-ccd5-4465-98c0-70b8ec2ac87a@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ0PR10MB7692:EE_
x-ms-office365-filtering-correlation-id: 364705a0-7cde-4b07-b12a-08ddb01663f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bUJJZXgxc2hONjNwWXlCSHIvOUhUNEJNTW94Y1JEMHkzSzdhRkZ0b29VUUJv?=
 =?utf-8?B?dXJlVGk3eXJVcFpnUUVTc2Zrc3kyY1JxL1lnN2o0bUpHSCtOQVBLVmJUQW53?=
 =?utf-8?B?bStrbXFQdDVlSTJ1S0VGYzRSeU9SK2x6MTZzbHJyci9DMlA0RXp1RGhOd0JX?=
 =?utf-8?B?eitQem1TVVRMcFZLZnhQeVJZOE55Yzd6U01NRGp5YmF1Z2kyRWJncTZTSDkw?=
 =?utf-8?B?S3FHbVNoM3cvckxQaHI5aWdmVHlDTXNIbW9pMmtFNjcwQ1RDbFYxWHluYnNO?=
 =?utf-8?B?RVMzVVJremF2ZGpYVGlKeFBuS1VaNjZMYURrS0JncC93R1pDYlRjUDF0VXpL?=
 =?utf-8?B?ZUxDMjdSVFRoUHM1TWpZeGVJQWkyTkd4TmZ1QmliUWZXamE0ZGV3MnpvelFn?=
 =?utf-8?B?TjlneHEzbFQ3MHNtWG9xWkZIS25JOFRzOHJEN1JsZSthZ3gyTmFuRCs2dTkw?=
 =?utf-8?B?SGtSWS81NlRWNWFrWFpxWGpoeUUvMXNURlY2eFlpY0FrcDZ5QUdZamgycXRt?=
 =?utf-8?B?bFFiSUdrbFdlaWppYk5yQWxrVzdPcjdsdDl1eFJUYTZhSStEUWtUbEhCSndl?=
 =?utf-8?B?ZFRJSVlidC82SWpXZkVIZE81YXRLUUhtRk5xbjROY2Y5TGZOQjc1OGhRREZI?=
 =?utf-8?B?bGdnek1vSUgvaVJmb0ZRZEpQV0QwUkg0UlZzejN3OWJjR2d1WEhzbnlCYTVX?=
 =?utf-8?B?NmhxSXBDN294WmVNbjZoZWVXOFFoRTNvV2pGSHlBMGhGRi9PTDZ3UGx1WTNI?=
 =?utf-8?B?U2VDTW5hK2hUOEtwNkJJTnROUWZNL3pBMHRJNzNud013eGNXQWZPWU9pcmwr?=
 =?utf-8?B?WGJEUkEyNWU2cDFKcnNpK2RSSHRxNzJROERiNnRJdnRrTXVRSm9iVGVlQk1L?=
 =?utf-8?B?OXhXNGhVdWlhbHltTEV3cDF0KzdpeFMxSkx5UGN6N2xHQ2RYUnlxK0lyd3M0?=
 =?utf-8?B?RmFwbWpaSVkrNEhTNXc2dVpQMGNCZDM5M29lejhmVUl2UlV2UW02b1F4NmJG?=
 =?utf-8?B?U1pac3NlNjRWd3FRVUJmQmtsaHJBRXFGNUdjQjRaNm05NGFzVy9SVS9GY2Jm?=
 =?utf-8?B?SGlBTHhSM002WXdUQThYRUZ6ZnlEelI4M1hJT3VRT2VGQS9NeWR6eE43bDRL?=
 =?utf-8?B?QlVFY3RjTzdvQzBtSDFZUEVCRWdpczYrZ0pVSmc1ZE1Rb3QxSDBsVC9lZEVD?=
 =?utf-8?B?NzVQYVNXamdFMzJrM3E2TDVMa1ZKTlZCMUd4Vk9tZ3BRYVd3T1lPZFFpQTRv?=
 =?utf-8?B?WCtjN01oUy9GRDlYcmpnM0hPUngzTUljSTRHdUtyeUtXODZNMjRlZlV5TTBU?=
 =?utf-8?B?VTVrc24wZWJWMnlTUXg2MHFyeDFGNU9qRi9VMjZFYnJWdUhtSWdxY2FlZVVY?=
 =?utf-8?B?TW5pMnR6Vm1hREFuR0dBVkVEWEduZ0NiU2MzWjcxRm0zdjNIb253ODRrQ3ZJ?=
 =?utf-8?B?NVZhN2Q5Z1ZIRk4vaVlYL0l4ZWhpWU9aSDJoMkJMSGhZaFN2enAzODZuU3Q5?=
 =?utf-8?B?dDRzK1VKTGI5N1JNL1JwcGNrMHFQSjRqUXdwcTk2SDVkNWtiNXFmdGkwZFlE?=
 =?utf-8?B?ZHB3Qk1LRFdYTG0yZG00UUYyRHBuY3RsczlHRWtKekV6VThyOHU5T3FrM1JB?=
 =?utf-8?B?QUF6R3NDZ0U1UVo2TVhBM2ozdXdMVk50dU9jRVo1cGZocXlGYXVoalExcHRp?=
 =?utf-8?B?U09BS01pQnhEY01Xdmc0THVUK29oblRGakh4ZkZKM2IvY2ZkenF1Y3F4ZGpj?=
 =?utf-8?B?UU0ydmRTRm9ydlJnYmlldThKdldqZ1QzNDN6WTYvQmpKTzJEa0kvdXFveVZG?=
 =?utf-8?B?S2NiUllVNDJ0SEhQRFRVRllqV2ovbWxVNG1Nd3ZZN3dkTzhMcXpFSHJ5SFk5?=
 =?utf-8?B?V29lS2JHbnhpbWxHY1k4Qk90S3B2R3E2UWJkZW1hWmhqSzRZazJrVU1MYlZy?=
 =?utf-8?Q?L0X1CFBqB5Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzV2WFd0SmNSNjBkMFF6QmN6WkRsdDY0ajY4T285MlFST1VEV2grTVBGbFlj?=
 =?utf-8?B?VFpmOFp6OTlxVzhUQS9ESC9zU083LzhnV3d5ckt5dzhLbEwyTVd4Mm9hamhk?=
 =?utf-8?B?YmtzVzZEcXVPZ3dLSzlpczJRUmlQaDBIL1NQa0k1cyswZ3lTdHRpd2lsUEQ4?=
 =?utf-8?B?UjVMYUhTMFFhZEhudEx2eUFEYlVZOHhUdTgvQWI4d05TS3Y1V2diR3FzZjl2?=
 =?utf-8?B?bTZLVytuYXNiL2xoWnZPVlJaZzhtZ2tTcUFiMjVNYXV1VUdEL2hLejhUdjhl?=
 =?utf-8?B?UDBKMjlRSVVkOUhtRFpGaHFra0t4WkFoOEJWaEl2bVNzTGFwSnc0dE9uWXpG?=
 =?utf-8?B?K211ZUtTRnBKRTRzakRsaCtEK1NrVGd3T2wrcFlUMnBIYmYrSE5LcWdLa0ZH?=
 =?utf-8?B?V21lODBYUHJacFZVdlNxNThaMFhwa01YSGZIRjBkdk0yWGxpSVlMNjdQRjVB?=
 =?utf-8?B?cGErTzFWSnlPU3JMNER5OC81Wk9sN2dwZGlXVDlZR1Fnam9zMGlya0RqQnBT?=
 =?utf-8?B?WExiUkdsZmtuZTJlcG1rZnVJREoyVWIvaEFkTHBnMjIveldrZVFyT0FobUdS?=
 =?utf-8?B?VVRybHJvTCtpSjJaYXB6aEpadUVaZC9JUUkrSHdpNVZxTk9waFpsTUQxZktV?=
 =?utf-8?B?bEdldUdDWlUxVjBVWG96dTYxT2VVaU96eGFFVFpZVWh2WmQ1YktKbXlBczNj?=
 =?utf-8?B?RVF5a0FsZXA5UnU2d1NJSngyVG1wcEFSVzA5U2FqcW82Um84dEdpRElRUWkw?=
 =?utf-8?B?d21QbUx4MEw1eFk2TnRINXgzNTNXR0hvSjNxSGhKWG5IaWEvYktiNWN1cEFI?=
 =?utf-8?B?U2RZNUF0QkhKZWJ5THhZNWd2TGgzNWhmenpPYTlKN1VWY1pRcmNFWmJMYzNq?=
 =?utf-8?B?Uy82WEs1bE9zcmtlWEtyTERIZDl0aFFZcjlZZUs2aWZ3U0VGZGh2RWd6R0N2?=
 =?utf-8?B?OUVhWVVPV1lsRUJFUDQwWnlKYTV4dlFRUTlXQ3pRMmxnNEFmeGhtNjJyQ0lL?=
 =?utf-8?B?bDB0WWhTRGNkdzNOWWVjYWxnUGU0QWZIcE1HZzZWUFcyTDJIQWd2YXcvT1pL?=
 =?utf-8?B?aEoxMXA4TFBhM0hoY1dPSE1EdFZHMy9JNktSZUJ1b1RSVlBETHhzbmZJbGpl?=
 =?utf-8?B?ZFl6cUlXVFRTdkc1dDZLamdzZHFaS0lGMFJxQmtqZWFWMkhPT2dpVFRhQ3lX?=
 =?utf-8?B?TkJCbHo0b25FQ3ZOVU1OaUk1TnF5RmJXdWZuUDQ4RndFdStPK2VCUkdNb1BR?=
 =?utf-8?B?bWFsaTRhb2p4N1hMVUdFZGNkYWxrKy9JY3JGUUdiQ2FnRG1mVE0yNmZjak9s?=
 =?utf-8?B?YTM3TFhaUVFkbG1LOHN5VXFCeHdRdkowbnkrcjBSUVNHdVFaZHREZCsyRnBZ?=
 =?utf-8?B?a1hSTFBrOTdLZ2toMnRxTUJ6MDFsVExsemFVc21LbVlDbG9nQ3dsdXZsZWVT?=
 =?utf-8?B?T1RQL1FTRVAzcUNCTGE1ZDRPUHRKRDl1Z2hOOGpqZEZ6dGpLS3BqRGhhampq?=
 =?utf-8?B?K2t6b0d0WnBHekNGL3ZvektYdkFZNURSelVJNDFmVkV5NzdCTHBJM2dvNUR0?=
 =?utf-8?B?UGpLM283Z25jQmliR2lNWTNBS3h6SmpKS3JWVHlkL3ZGRTYzd1VHQXV6VzBi?=
 =?utf-8?B?bHRuUXRDOVY1N2ZyRWVpTGNqZmZnVzRVNjQxaWtFbGNNQmgzQkphNU02QmF6?=
 =?utf-8?B?RUUvejJUY0FpZVIweUxPOTBncGpCdWR4NmRsSWl2cmVoN04rcExHTnpQdExr?=
 =?utf-8?B?bkoxcW5Jc3d2elREZmliVklXU05FcEVoaTQ2Y3dEckpZNzQzdG9WYzBIcE5B?=
 =?utf-8?B?cHk1U1ROanM1TU1tSWFDZUJmMzRBT0Ridi9weEFUY1hKNU1lTXU1eldwc2lX?=
 =?utf-8?B?MHpPcldIMU13V1ZJbW01OEFBc3ZiVnEzS2ZMRmxjRmpLbC9lVlhqS0FiRGxY?=
 =?utf-8?B?M0hBc1FxMVNBNUtLVnFPQXpCemxwcGJITUxnbmFDdFhVQkxjTFAyWmJzVEIw?=
 =?utf-8?B?TXYrVjVVaWY4NnFQUHNUMlNGWG45TnRnYmRISW5FT1JEUW4yL01rcFJkVzBh?=
 =?utf-8?B?cXFNMkFwaHFwV2RUdEY2S01wRWZtR3NEeU5FbmpUZWhSWjJham84U0xrcDFM?=
 =?utf-8?B?RVI2ZjhLL2praDFPSjZSK3ZFQXpPNXZ0UWk2dmo5N0NvbWg4b0NKWVRPdmk4?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <262CD5678431A540BDD07EFBCC1CFD53@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H8nWDxjCf3cju8yPo/xQ2c9BxhRmlbuwKG8Z/2p2/v8kAkFgVi2TyhWwS0KgwaqxslJDNpE7v4/IcmZE4Yldfj83xKtSC+0uD5xPgD3/AKOdvut6NS91uRZfegoyudQPQ/Fy0VwTmUXWHRodynTa4VLFNFjerQYz1eNtdPvhtL8tIH0H5Cv5wbvCgnr5fRUOgN80+LCU6aulfc7s+lvuFe6e6cY+RCQIex1euz2M/ZjQb/0FZdUR+JMOTxB21ZB4XXEAejOz8T6Btjq2Cexz+SQzuS4JXHS+ogYoN+u+f5h4K0/GuUzLCwWj5u5NWT5M6DtDrXCgqR/zA9PY8oCiEUen4AkA1v7/zKy+AktVdhiGrU5q6R1B8FKcjx+hCrjZWoXoPdK1cNUzUS1C3MGgFm7PJvwMNsRj4A+pMIXW4wQMj+1UoBEhoNLaOPHuLXCmu4GgCo+8zFjXIEeicAagNQ1fAa4PlmHfhdcHC8TAkh7QFYKAtpNEZjKcnEj2phkjqhyT6H+YM8/n8//x0Puh0CAAa9YZCz1kkPITuh7kkIAaivVLuWS77i0A1h1jhpHH70TmnJxu/xyF5FpRsuBBizlsIbtui44JG4vT2HxyFWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364705a0-7cde-4b07-b12a-08ddb01663f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 16:20:36.9460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUo9c3g4QqCdRMWhebETxXgnihy+ZrWlTyvxdCZHwcPnoSacdKYNUAkbDLAtpNzeYPaGdfKk+usaSOxq4+jkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExNSBTYWx0ZWRfX0bzVvWS5t1qv
 wdCoETO97FdT/ctg34sJzi2Qx1Sj04S2rhZjYP3CgcFAB0FiZXSa8BXxcOADUHvMT3RiWKebfUZ
 ZFLBz4R+nWAEmktFlV1DdXYCG9StGxc1BR6kKPPnDmDtGLvka/yregAMJwvNU+dkxLm00MNOVqd
 K8BldNihCT5HRhkVECwIuk7dTFxaQTnD+kge+ld+2BuZITZW02508fRgwzdvWhIywzNYBQ0lh2/
 dXheZ5gDmXckseAVpwTb5HxfiSkmmw61E7IH9nQTxbCHLa66P1CWvaqSR2WjmWc/u02lgBUkzDx
 +YEPuRLVEGRTtMGSL4NdzMNJO3TJTSMJvV4+J8bveI/U1yWpGIhiEW/eXgjzEVJS0ZXOsJ+jBbb
 zW5tvvoRoTg6xu0H4x3Gsv800Ow72ok4ZOfephU6LfY5bgrbgyJ6WLeQY7w1rXlkOr81xCDR
X-Proofpoint-GUID: gPxI_qkL-GeonZytuS5y3mIhxr4xDtMc
X-Proofpoint-ORIG-GUID: gPxI_qkL-GeonZytuS5y3mIhxr4xDtMc
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68558a59 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=cA2IU5OdAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=VjE4WKpw6TIy4wixHJwA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgRXJpYywNCg0KPiBPbiAxOSBKdW4gMjAyNSwgYXQgMTM6MjksIEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDYvMTcvMjUgNTo1
MCBQTSwgTWlndWVsIEx1aXMgd3JvdGU6DQo+PiBIaSBFcmljLA0KPj4gDQo+Pj4gT24gMTcgSnVu
IDIwMjUsIGF0IDE1OjQxLCBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+IE9uIDYvMTcvMjUgNToyMyBQTSwgTWlndWVsIEx1aXMg
d3JvdGU6DQo+Pj4+IEhpIEFseXNzYSwNCj4+Pj4gDQo+Pj4+PiBPbiAxNyBKdW4gMjAyNSwgYXQg
MTQ6MTcsIEFseXNzYSBSb3NzIDxoaUBhbHlzc2EuaXM+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+IHdyaXRlczoNCj4+Pj4+IA0KPj4+Pj4+
IEZyb206IEhhaWJvIFh1IDxoYWliby54dUBsaW5hcm8ub3JnPg0KPj4+Pj4+IA0KPj4+Pj4+IFVw
IHRvIG5vdyB2aXJ0IHN1cHBvcnQgb24gZ3Vlc3QgaGFzIGJlZW4gb25seSBzdXBwb3J0ZWQgd2l0
aCBUQ0cuDQo+Pj4+Pj4gTm93IGl0IGJlY29tZXMgZmVhc2libGUgdG8gdXNlIGl0IHdpdGggS1ZN
IGFjY2VsZXJhdGlvbi4NCj4+Pj4+PiANCj4+Pj4+PiBBbHNvIGNoZWNrIG9ubHkgaW4ta2VybmVs
IEdJQ3YzIGlzIHVzZWQgYWxvbmcgd2l0aCBLVk0gRUwyLg0KPj4+Pj4+IA0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEhhaWJvIFh1IDxoYWliby54dUBsaW5hcm8ub3JnPg0KPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4+PiBSZXZp
ZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
DQo+Pj4+PiBIaSEgIEZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGlzIHdpbGwgcHJvZHVjZSBhbiBl
cnJvciBvbiBob3N0cyB0aGF0DQo+Pj4+PiBkb24ndCBzdXBwb3J0IG5lc3RlZCB2aXJ0dWFsaXph
dGlvbiB3aGVuIFFFTVUgaXMgaW52b2tlZCB3aXRoIC1hY2NlbA0KPj4+Pj4ga3ZtOnRjZw0KPj4+
PiBJIGRpZG7igJl0IGtub3cgJy1hY2VsbCBrdm06dGNn4oCZIGNvdWxkIGJlIHVzZWQgYXMgYSBm
YWxsYmFjayBtZWNoYW5pc20gYmV0d2Vlbg0KPj4+PiBhY2NlbGVyYXRpb24gbW9kZXMuIE1heSBJ
IGFzayB3aGV0aGVyIGRvIHlvdSBtYW5hZ2UgdGhlIOKAmC1jcHXigJkgdHlwZSBmb3Ig4oCYLWFj
Y2VsDQo+Pj4+IGt2bTp0Y2figJkgd2l0aCBjcHUg4oCYbWF44oCZID8NCj4+PiBEb2VzIGl0IGV4
aXN0Pw0KPj4+IHFlbXUtc3lzdGVtLWFhcmNoNjQ6IC1hY2NlbCBrdm06dGNnOiBpbnZhbGlkIGFj
Y2VsZXJhdG9yIGt2bTp0Y2cNCj4+IE1heWJlIEFseXNzYSBpcyByZWZlcnJpbmcgdG8g4oCYLU0g
dmlydCxhY2NlbD1rdm06dGNnLHZpcnR1YWxpemF0aW9uPW9uLGdpYy12ZXJzaW9uPTPigJkgPw0K
Pj4gDQo+PiBUaGUgYWJvdmUgZGlkbuKAmXQgdHJpZ2dlcmVkIGFueSBlcnJvci4gQW55aG93IGlm
IHRoZSBhYm92ZSBkb2VzIHdoYXQgQWx5c3Nh4oCZcyBzYXlpbmcgDQo+PiB3ZSB3b3VsZCBqdXN0
IGJlIG1pc3NpbmcgdGhlIGNoZWNrIGZvciB8fCAhdGNnX2VuYWJsZWQoKSBpbiB0aGlzIHBhdGNo
LCBJIGJlbGlldmUuDQo+IA0KPiBBZnRlciBkaXNjdXNzaW9uIHdpdGggUGFvbG8sIHRoZSBsYWNr
IG9mIHRoZSBDQVAgc2hvdWxkIGJlIGRldGVjdGVkDQo+IGVhcmxpZXIgaW4ga3ZtX2luaXQva3Zt
X2FyY2hfaW5pdCB0byBhbGxvdyB0aGUgZmFsbGJhY2sgdG8gVENHLg0KPiBpbiB0YXJnZXQvYXJt
L2t2bS5jIGt2bV9hcmNoX2luaXQoKSBzb21lIGdlbmVyaWMgY2FwcyBhcmUgY2hlY2tlZCBidXQN
Cj4gbm9uZSBvZiB0aGVtIGFyZSByZWxhdGVkIHRvIG1hY2hpbmUgc2V0dGluZ3MgYW5kIHRoaXMg
Y29kZSBpcyB2aXJ0IGFybQ0KPiBtYWNoaW5lIGFnbm9zdGljLg0KPiANCj4gSSBjaGVja2VkIGFu
ZCBhZGRpbmcNCj4gDQo+ICAgICBpZiAob2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QobXMpLCBU
WVBFX1ZJUlRfTUFDSElORSkpIHsNCj4gICAgICAgICBWaXJ0TWFjaGluZVN0YXRlICp2bXMgPSBW
SVJUX01BQ0hJTkUobXMpOw0KPiANCj4gICAgICAgICBpZiAodm1zLT52aXJ0ICYmICFrdm1fYXJt
X2VsMl9zdXBwb3J0ZWQoKSkgew0KPiAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIktWTSBkb2Vz
IG5vdCBzdXBwb3J0IG5lc3RlZCB2aXJ0dWFsaXphdGlvbiIpOw0KPiAgICAgICAgICAgICByZXQg
PSAtRUlOVkFMOw0KPiAgICAgICAgIH0NCj4gICAgIH0NCj4gDQo+IGF0IHRoZSBlbmQgb2YgdGhl
IGZ1bmN0aW9uIHdvdWxkIGRvIHRoZSBqb2IuIEJ1dCBhcyBJIHNhaWQgcHJldmlvdXNseQ0KPiB0
aGlzIGlzIG5vdCBkb25lIGZvciBvdGhlciB2aXJ0IGFybSBtYWNoaW5lIG9wdGlvbnMgdGhhdCBh
cmUgYWNjZWwNCj4gc3BlY2lmaWMgb3IgcmVxdWlyZSBzcGVjaWFsIEtWTSBjYXBzIChzZWN1cmUs
IG10ZSBmb3IgaW5zdGFuY2UpIHNvIGl0DQo+IHdvdWxkIGJlIGEgY2hhbmdlIGluIHRoZSBhcHBy
b2FjaC4NCj4gDQoNCkdvdCBpdC4NCg0KPiBBcyBwb2ludGVkIG91dCBiZWZvcmUgZmFsbGJhY2sg
c3Bpcml0IHdhcyByYXRoZXI6ICJLVk0gaXNuJ3QgZW5hYmxlZCINCj4gdGhhbiBmb3IgIktWTSBk
b2Vzbid0IHN1cHBvcnQgYSBzcGVjaWZpYyBmZWF0dXJlIi4NCj4gDQoNClRoYW5rIHlvdSBmb3Ig
Z2V0dGluZyB0byB0aGUgYm90dG9tIG9mIGl0Lg0KDQpNaWd1ZWwNCg0KPiBUaGFua3MNCj4gDQo+
IEVyaWMNCj4gDQo+IA0KPiANCj4gDQo+IGl0J3MgcHVyZWx5IHRoZSBmaXJzdCBhY2NlbGVyYXRv
ciB0aGF0IHNheXMgaXQgY2FuIHdvcmsNCj4gMTowMw0KPiA8aHR0cHM6Ly9yZWRoYXQtaW50ZXJu
YWwuc2xhY2suY29tL2FyY2hpdmVzL0MwNEtGS1YyU0U5L3AxNzUwMzMxMDA1MjQyNzA5Pg0KPiBw
Ym9uemluaQ0KPiBXaGVyZSAiY2FuIHdvcmsiIGlzIG9ubHkgYmFzZWQgb24gdGhlIGhvc3QuDQo+
IA0KPiANCj4+IA0KPj4gTWlndWVsDQo+PiANCj4+PiBBbHlzc2EsIGRpZG4ndCB5b3UgbWVhbiAt
YWNjZWwga3ZtIG9yIC0tYWNjZWwgdGNnDQo+Pj4+IEJ1dCBtb3JlIGltcG9ydGFudGx5LCBpcyB0
aGlzIHdoYXQgeW914oCZcmUgcmVmZXJyaW5nIHRvPw0KPj4+PiANCj4+Pj4gQWx0aG91Z2gsDQo+
Pj4+IA0KPj4+Pj4gLW1hY2hpbmUgdmlydHVhbGl6YXRpb249b24sDQo+Pj4+IHNob3VsZCB3b3Jr
IGZvciBib3RoICctYWNjZWwga3Zt4oCZIGFuZCDigJgtYWNjZWwgdGNn4oCZLg0KPj4+PiANCj4+
Pj4+IGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQncyB0aGUgaWRlYWwNCj4+Pj4+IGJlaGF2aW91ci4g
IEl0IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSBmb3IgaXQgdG8gZmFsbCBiYWNrIHRvIHRoZSBmaXJz
dA0KPj4+Pj4gcGVybWl0dGVkIGFjY2VsIG9wdGlvbiB0aGF0IGRvZXMgc3VwcG9ydCBydW5uaW5n
IHRoZSBtYWNoaW5lIGFzDQo+Pj4+PiBjb25maWd1cmVkLCBzbyBpZiBoYXJkd2FyZSBuZXN0ZWQg
dmlydHVhbGl6YXRpb24gaXMgbm90IHN1cHBvcnRlZCwgaXQNCj4+Pj4+IHNob3VsZCBmYWxsIGJh
Y2sgdG8gVENHLg0KPj4+Pj4gDQo+Pj4+PiBJIG1haW50YWluIGFuIE9TIGRldmVsb3BtZW50IGVu
dmlyb25tZW50IHRoYXQgaW5jbHVkZXMgc2NyaXB0cyBmb3INCj4+Pj4+IHJ1bm5pbmcgaW1hZ2Vz
IGluIFFFTVUsIHdoZXJlIHJ1bm5pbmcgS1ZNIG9uIHRob3NlIGltYWdlcyBpcyBhDQo+Pj4+PiBy
ZXF1aXJlbWVudC4gIEN1cnJlbnRseSwgdGhvc2Ugc2NyaXB0cyBzaW1wbHkgZm9yY2UgVENHIG9u
IGFhcmNoNjQuDQo+Pj4+PiBXaXRoIHRoaXMgY2hhbmdlLCB0byB0YWtlIGFkdmFudGFnZSBvZiBL
Vk0gTlYgc3VwcG9ydCwgSSdkIGhhdmUgdG8gdHJ5DQo+Pj4+PiB0byBpZGVudGlmeSBpbiB0aGUg
c2NyaXB0IHdoZXRoZXIgTlYgd291bGQgYmUgc3VwcG9ydGVkLiAgUUVNVSB3b3VsZCBiZQ0KPj4+
Pj4gaW4gYSBtdWNoIGJldHRlciBwb3NpdGlvbiB0byBkZXRlcm1pbmUgdGhpcyBhbmQgZmFsbCBi
YWNrIHRvIFRDRyBpZiBpdCdzDQo+Pj4+PiB1bnN1cHBvcnRlZCwgbGlrZSBob3cgdGhlIC1hY2Nl
bCBvcHRpb24gd2l0aCBtdWx0aXBsZSB2YWx1ZXMgdXN1YWxseQ0KPj4+Pj4gd29ya3MuDQo+Pj4+
IFRoYW5rcywNCj4+Pj4gTWlndWVsDQoNCg0K

