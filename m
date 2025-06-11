Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA71C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLlo-00006Z-0u; Wed, 11 Jun 2025 09:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uPLlk-00006B-Rc
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:45:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uPLli-0001mU-Ef
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:45:32 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCtbgD004228;
 Wed, 11 Jun 2025 13:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=crXFBuw2J2n/Tcf16QSkbw7N18MSaH7RysvFWJWw/2w=; b=
 f6KLPJj72UBOZ+NJf7Uos7k4zv9ys/kMf8eAyLazlMoaLZOcJ0cspAEnIeA7QM2n
 VRUcwDqVOXN5AQWn7PG2E+g945iRC+HCEexr7gS+qL4+evEwwC34Jt0k07RHLTdG
 JX/OtfFYHxwd3fIKaGLjkFsL0MhlmQvmMqP8LKlelOOGJ2soD1XUeYAgIZb6WXCe
 SfjH5YoLHLSSoTKAf5+aU35mS4AVL7vlrq85bCY2h2DtXMonC6tkp7mIgPLAfH+4
 oJyG9XBOA/Vls1BTyWYR94pJoDEHMdUpHT86mT9H0CijZ8CKlodIpH93BoiVpYhV
 jHdzz46iXJlOdZ001l2dOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbeevu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 13:45:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55BCZ9A4020255; Wed, 11 Jun 2025 13:45:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvgedyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 13:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ6B2jBQBahIWCal6L3UUPWloTsXbjljkkBsiHPjnZqsPaaWKm+HeVVstBXhtvnUDV0o+OILRkuNzsqKYNRg0yM8qKkvApaSxgA6x5hM+mdqwxDjDUj2lQddqn0EYTKXXCaYO5NwtoTyPNjdnqMEOpzQNUoqebIHlIIxWjjwYbuDIK1UkAlaqmPqPhSimBbFwDuWVkuSMfNlVPWsjo558V6kJFLpE0XmVtrJ1hP+P11onqUL1gS1P5pFpZ0ErLKqe68+Rek5kXNfXZFX6qKeDeQEyforpxsI+R+pvsmK2eXj3iZENKLwinUDEbb/uD0ZMq8m/Dv7pPPaO7JZnEkkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crXFBuw2J2n/Tcf16QSkbw7N18MSaH7RysvFWJWw/2w=;
 b=zDgPexxo+ZIqzfSvJAVplEgNdHkmb3jlt6q9lvNAEjbwnauwTiPQuehiPNJmmvLUlZl1atoFAXIkKpu4LhP+hauRlu0ALLGVMN/YYB/t8BjhT6es/nhcrCsrJDRsvYpdaXUIuBXt/JqQtcPDWTDz+Q38bMT1ghtzA+qRCiwiXbio4mTCs9lW9fA/a3gV2IXLWRXXhnCqNHQY+RJ03AOkso4z6d8bEpSmDVt+9uAr5ikTx9AHoMLOAviVZ5aHj6yk3u6Ktr6jTlGYCM8LQErbtnxIiVW/Kwgg8KEm1WlAICfHzsleVvMUZzjdGtcdTXccRoPORDH1HeWuYu1hBQtGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crXFBuw2J2n/Tcf16QSkbw7N18MSaH7RysvFWJWw/2w=;
 b=cdM1Ii2o1YjydYWkjNW6KHbBF5OOHjek1g+bU5rSFfKjNv5fuEGaIyNcFwANaddNjPTh3SiruBSKpVrv8/B2OS0WlC4KuocXadyP03E5qiI1iFZfn+vriiWSKoYfynRY2roHjiGdD+vKYt1/wTIwbB82wK3dTn7i1DmLQiy3TT0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Wed, 11 Jun
 2025 13:45:20 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 13:45:20 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Thread-Topic: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Thread-Index: AQHb1wKXbwfaW55KnUG/YF2vFEM1RLP+ABMA
Date: Wed, 11 Jun 2025 13:45:20 +0000
Message-ID: <EC334225-4D4D-4CBD-849D-86103C3D8BD8@oracle.com>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-2-philmd@linaro.org>
In-Reply-To: <20250606164418.98655-2-philmd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS7PR10MB4832:EE_
x-ms-office365-filtering-correlation-id: 645b61a9-c1c9-4918-8b36-08dda8ee355c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T280cEIwRHRZSC9KTjRwWlpFVWZva2dFR2s3cGYzamFUVTVpOXN4Rko5c2tw?=
 =?utf-8?B?SFBlaW1KQnhhczVMdmkwUS9IbTNudXhueUhTMmxXYlhuS1pPci9hVEh1Ui9M?=
 =?utf-8?B?NmZWVVMrWmczMUg5dGZDMkkySDJVZDVBNU1wTENRTHM3SG45Y3YxSTV6NHZB?=
 =?utf-8?B?STN6UW5nV2k4VzlLNmM5SW9TUTBTcjFiU3ZVMEp1dksvcHBwRVZIZVF4OEJD?=
 =?utf-8?B?dzdUbmkzOTQybittazRSbWp3RGIrNHZ5aWRYcjY4M01UZkNDdlRkU2gvZ0lH?=
 =?utf-8?B?YjRqbyt2eU8yRVBzTk56OUVLNks2eWttdzZPK3V0WHdWQVBJb0Y3UFM5Ym5R?=
 =?utf-8?B?NEFXTjRzWVk2Y01HODhtM2xmdVdxc0dYNzdicEZ1KzNOOURNemhPVDl3anU5?=
 =?utf-8?B?UEpXUHJKQ01LdmxEVmhvUGIxZjFZWkdYbGppUG9oQ3d3ZUFIWUd1a1pjYVJV?=
 =?utf-8?B?U2dWTkFiTjlmNnBOcWJ2ZlpaZyt3SmxxaXY2U1FPTDM0N0lTSEZLdG1qS1lm?=
 =?utf-8?B?b2lndGYvbE5MZFZZbWQvT3hmcER5WTFYRmsvbGlQc25KcTB0YlpnLzFLc3A1?=
 =?utf-8?B?Y2JGTHBQeVB5NW4xN2VRK2hpOWZWMHJpT3o1QkU2UmR6TG84ZEZWUFBma1dn?=
 =?utf-8?B?Zyt2KzFhU3ZKNHFoRXEvSDZoL3Avb0FJcVpUVFQyektsblZLNGxFbFdmSlpX?=
 =?utf-8?B?S2V4ZHFRbnp1NHRJY3JzR3hNb0RPUjFKaGdlQksyYWppd0YrS0J0czVQcXdw?=
 =?utf-8?B?R2dmNjFzclFUaEJPR2V2VHpVZCtMSFJTaUJPaDBmT1lmM0hSTS9qMGlhMjli?=
 =?utf-8?B?MVhzeHNPMm1qNmNEem5XdXdqL2taeE93NEUvbG9ZZWdUN3oyNzhlb2tnT203?=
 =?utf-8?B?Y3QzQ1hXU3ZIK0psRTlpYTMrejN4a1R5ckJMbzk0V2RHN2xrakZkOGhudFNE?=
 =?utf-8?B?UkI2OUR0YWRYc2dxSmhnNHV2VFdmU3RWbnBDYklSWXg1U2dlRjNjSEJkYTJQ?=
 =?utf-8?B?UVZmRWZRR0JOSEFaVkRCOHNxeE9vaVBVaDNJcUdycVBjMzVCRVh3TUZKQzNa?=
 =?utf-8?B?dXE4YlF1eUdmVERHUGZVUGd5R0tiMnlldUpvU2JGNTQwaXNRWGFGdy94WkJB?=
 =?utf-8?B?dUhWQjZNV0tnR3JjTnpLT2Y1Unh3RFdEL3dPR0EvODE1bk01ZlVoNzY4VjZq?=
 =?utf-8?B?Y2RvZWg5QXJWZ3JsL0ZBaTdKNkNHSUIwTnYvZHk5bDI5YlRXK2pZVWZ4SGp2?=
 =?utf-8?B?VFRRRytkQXJEQnVNZ1BpcVpHTUliTnplOUh6TjRyVDlVQ3NueHl2QTZJeElY?=
 =?utf-8?B?STNBeXIxMWFCYnVlMEMxV0xZMlRjUEV5K2dXdkZYOFkzaHM0NUxTTEI3VHc5?=
 =?utf-8?B?K3IwUTZPYmZRbTQ2UXdUVGx1SHdmSUl5RlVjUnhOdnNJOU9tb1JQMXEvTFNB?=
 =?utf-8?B?TUZSSHFzMlp3bjRqdTZTSTFUa0dFWTB6YlVCOTBXNDFWaThCd2VtVDFTWjRI?=
 =?utf-8?B?Nzh2NHF4K0J3bUY5L0ZtVCtZR21TbU83aUhoSnhCa083RnU3OUprMzg0K3FP?=
 =?utf-8?B?T3NyRzdHSUliV2MvemR3cGlscHM5VEVLaCtZcTFFZSt5a1kxODhhU0svMWIr?=
 =?utf-8?B?L1lmK3RzdkhBc0NGZURmMEprbERzN2RBTlBZc3Vac01GSVJaa1Z2c2ROVkZa?=
 =?utf-8?B?NkphRTJDRVptcFdtL1YrUjd6cElWRVczV0VYMHdHWnYzYml2Rm9vcWJGd3ZI?=
 =?utf-8?B?VkJXVVRZUFFnS1Qrc3BGSXlkSFdFcS9sNmxubGwrb1ZGdWVQVlVGVGd6eGoy?=
 =?utf-8?B?S1JJL09DYzNzWW9hV1N5S2RpSXZ3a1lrVG92RHJROG1WWWZ2QnRzVVJSV3VS?=
 =?utf-8?B?SXJ3bzAzUHFsenFMTENMUDNHQkZuMHVURFFKSGlxblppZGl6VmxVVXhqQWVB?=
 =?utf-8?B?bjlnUktPd0lxQTNJWnZNQ0tRc1l5dExIQmY3STJpTXd3YitZWU5LZnpxbzNT?=
 =?utf-8?B?KzBOdlA4WEh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUVHUnRqcGxkYUY2U3FxbGlONUpLbnA1b3JKTzBOWDhvODR3VTYxb2lob2dQ?=
 =?utf-8?B?SURQWE0zalg2ZkhJYUJPK3N4b0hmRFhJQitlNTJ4TXNFY0xXVmEyV3RZK0c2?=
 =?utf-8?B?Zko3SlQ0SGtPS3pWS0NEWElQMmpoYXdwQ1VnekcwQTlxaXMyMEJOeHlGSEFk?=
 =?utf-8?B?VTV1NEhDV20xZVI1Q1BGbWJkeWR6QkdOTjBQY3VPUlBoSEVodXlkWjV6ZXhv?=
 =?utf-8?B?YjMvbjBPaDUxSkxiWE43UFBvU0RFVDlUejRLWUNoNUMrcGg3cnhwbys2N3JK?=
 =?utf-8?B?VHk2a3FvL0ZqNjY2TGFaSEdBQVVZZ1NBZ3RHOFdVeW00dVovc21mTmxveDBS?=
 =?utf-8?B?WGErUmlHTXhpSU9pbCtYWjd5WXYyMThUUUFlNFlTZytrVjVUWE9oVkN1RFZY?=
 =?utf-8?B?d21RUkJvK28xWmhyL3lBU0wxTHo4REh1NCtOVGtublhCQ2Jlc3p1MkZaOEEr?=
 =?utf-8?B?NkJHYThSdy8zNENiK3VHcFcvZUdpZy9wWVhLYmhQQ1oyU01zRHJjZVgyc1dK?=
 =?utf-8?B?LzFWdzY0TE9tL3p5VStjK2F0RHMxQmF5TnpRaGVEVkpnWjBHOFlXTEdqM01T?=
 =?utf-8?B?dlhUQW1PL1duRFExczR3T0F5bENZYzZ3VzVQdk0zclJOeHU1VDVXbWhuUUVS?=
 =?utf-8?B?R29EQk5lOHgrWmhpcDluTjI2YzZQOHQ1VVZLcmpZeURDRlVuMitOMFZUL3FO?=
 =?utf-8?B?ck9oWnBLSHNicUUySzhERi80VW1HMGhEQnVENDNjWklRdGMvLy9CS1JlS0tw?=
 =?utf-8?B?S3VpcVZ5VWZKYnAvbXBNZzVTTWo1SUFSN2c0WTEyeUpzbGtuVGlQSlpNZDBt?=
 =?utf-8?B?UmlURUZXRDJjSTJ5a2JvM0RvcFdPejlUVVZCOG5sY1J0YkxNMFNtOWRBWFFP?=
 =?utf-8?B?N3AwWk9QeXpwK1Zka0FXR3p1VHRmdGgyYU90Slpydk1MNkRSSUFtQndWSWF4?=
 =?utf-8?B?ejI5SmwzdFgzL09QT3g0Q1BCd3p5Y2tWbllYTEZpR3Vwdm5oYU1sZWFUeE15?=
 =?utf-8?B?VEtCcVhDTUJPa3ZZR1F3ZG5OajRXZkVEa0ZiQjFBM0oyenc2dTNMci9paGd1?=
 =?utf-8?B?S3RUQ2EraUZsTFcyTHpzR1NHdC9ydEtDSGo5NGFWV2l2b3JNV1ZmNXgrRjVR?=
 =?utf-8?B?ZTRORVJuMy9haVFKb25SbHk2VGN0L21xRm5ucTMwaStuY28vbEZUdW5lQ3V1?=
 =?utf-8?B?RWVFcVhhNVB2NlNwclV1U0RuK1NleVQ3WGEvdjUzdkl0UXY4V2ZkSlJnRkI2?=
 =?utf-8?B?Q2YvU3RidStPM0FyV0tERWsvUlM0T000VUxwQno1QWJpaittVFpSNkpWdm9J?=
 =?utf-8?B?NlhwVFJ1T1Y1YWtOSHVBUkcrVHYvaHVvN3BVT0V0bm01ZG15OGR1eHZXYXM4?=
 =?utf-8?B?bGpLUzhpZUpoVEZGdmpSeWV6bEI5Vm94RGltUVBrMHEzb1QraGU4TXBSeXlQ?=
 =?utf-8?B?cWJaY2czbWRqNEJuOGcrU1AyNzJBcUtQR0U4UElwRVVNQ1AxRXdhTGR1Ly9v?=
 =?utf-8?B?T1c0YThqeWhoTGZiWU9FUWpHcjRqVmxuSjBNeEFhbGVqMkJ0MGpnYmJNWHNv?=
 =?utf-8?B?bWM3TVpNN25iRWZVZGFNWS9GMm5YaW9hUEZLb2ZaMmYrdVZGWFBJbjU1ZC9L?=
 =?utf-8?B?Q3N5UGtkYUt6WnVuTHFqbGZxdlBia1NEWHhnbzlYN2ZlREk1dFZEby8yZzU1?=
 =?utf-8?B?OUNWRnJaMWRuc3JIbC9FYi9pNURZOVY2WWY2SHNMTTJGMHdMcUxFWmFGamQz?=
 =?utf-8?B?SjJUclU5SCtJSDhkZzBlc082VEFRRnNoa1VMNkZKZTA3T2hCNVhhSkIycHh0?=
 =?utf-8?B?UzArMkpOWGZzT2wxZHluM3VPblQralE0NjN2aW13akorOVdTbHVNSGJPQXpK?=
 =?utf-8?B?amVzelJMQ0E4KzgxVTVnb1BpMHVMV3dXYmxsa0oxbkdjQkV1ZXhKR0dkMW9s?=
 =?utf-8?B?QllpbFpMNDlTREU0YXZhUkZBd084Unc2Z2hraDk0YTJ5NUdDK3ZsN2EvaE1n?=
 =?utf-8?B?YUpKaVc0T0RVeGNlODR2K3dsNFlVSmp4ME4wcGo1OVQwL21kU3BjOFEvUUJS?=
 =?utf-8?B?VGJBWUo0MTVCT0IyVlc4bG9kUFFybE5wRXBSTitKRUp3YkdQK2lLcmFPWXRh?=
 =?utf-8?B?c2FuWnJIVUtSdTZCaEsxNkgwQUYwMDZocnFSTnhRUE1kUE5JeXZ2RmdpajhJ?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC58BBEE107A40499E708091568F80DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rw43jG8rF4AOs6x1LqVZRbdAJoKPlRQnjK0RiDx3eCxeNTHSd5MpCibeuYSpJ4kB7ueaBNBwGIkLgvDKZoYR/0zNzeN9eaORZfhd9c+20KBjs26jNp4U+ZJezGFyy5We12TvXHH/thHqkoUkZfao2H7XMmUxEyMrGi8w63iXEjnJf29hude2c9RXUkt+NU/zqpNmIB38yb4zvHHk06ztIFeWZJTgVWJYdH6yQ8f49I+3P5CZ+BkMHkcQti2D1IZt5v/CNX+/uSX9w+OECNvSBz//0UNlUu3hIsiKChfwIYkLppYJyKoV3ZPHOpsKNfeZ4Tt1+58UndDq6ImdG+eAt2al08mIZqylwVb73o8xp52hi1OOob8UJAPdcJXK4kCQnvYDQ9+S40Fip1jYfkzQGGf2ZCf86mFawC85K/sT1h5C3Ip7UEU3/rLGyuwYCalRKBUUbAY/gJngduUYqeZGqJFiDuUtOyAYndOiLIngt2D96vPru81lJOYtdkl+rmXBy9vPPlOQDp/IBlN9doaqijVVHYvbwwcmo/ijtcn97OqW3MVbHNz2eWadnw21r65uss0meJ/gGfIBOXFp/YZ1n+HOjAY/Qe7i18XkmriUVCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b61a9-c1c9-4918-8b36-08dda8ee355c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 13:45:20.7205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0uA2ParwshB2sOWemhizk5jAaRxNGO8rQooWgAq8Aij6de0vjP31MlKTzvfBQbQHLmer1a8sdbv5QaHuHsFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110115
X-Proofpoint-GUID: oU2qAIwlcuJjDlL2nV2UHETMXtvZMJXQ
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=68498874 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10
 a=KKAkSRfTAAAA:8 a=oLWMuky2diyIMM_BfaUA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: oU2qAIwlcuJjDlL2nV2UHETMXtvZMJXQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExNSBTYWx0ZWRfX3FJKs485VqVz
 795pQ7dTwXs6bLIh9hAcQ5Pg3i5ZB49VCWVkug9rJBiZneRWHsDQCig6sp5mFisUigqXxpIPpnh
 KgjYmnxPCN0+qAzZoFawWD3tjNagkAs3WrjXCiXi2Jg7PLbMlmSfApUemd8kNhXop0+zEvM81+q
 JgMzLukmFIQ2HBDdW8eVwsj5sRODLq5o9M7zXcMzojSZqhslaNqsn5yib5OvWudp0Sd9bYx31f9
 sFVBq3zNlv0EUIIYS0lKXcjEoMkyuSt4v/RUpiayU4rM9JF0dcprueSGCpS+cxk/XNUjJh9WTvh
 inXnjPVomTuAj78SSrixLyXYKIauxgQtv/tVlJx0GQTQIcn0OJuyzfKmiLybaV1XAXq7m7u0Yl7
 d3mx92jVMGaWi2wysqRc/Sj2np4hgIvmlPJ9CufYUofhiRaVNA0P2Z9HO16BT5Gm0ctZtZ64
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
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

SGkgUGhpbGlwcGUsDQoNCj4gT24gNiBKdW4gMjAyNSwgYXQgMTY6NDQsIFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiBo
dy9hcm0vdmlydC5jIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC5jIGIvaHcvYXJtL3Zp
cnQuYw0KPiBpbmRleCA5YTZjZDA4NWEzNy4uZDU1Y2UyYzBmNGUgMTAwNjQ0DQo+IC0tLSBhL2h3
L2FybS92aXJ0LmMNCj4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiBAQCAtMjIwNSw3ICsyMjA1LDcg
QEAgc3RhdGljIHZvaWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICAg
ICAgICAgZXhpdCgxKTsNCj4gICAgIH0NCj4gDQo+IC0gICAgaWYgKHZtcy0+dmlydCAmJiAoa3Zt
X2VuYWJsZWQoKSB8fCBodmZfZW5hYmxlZCgpKSkgew0KPiArICAgIGlmICh2bXMtPnZpcnQgJiYg
IXRjZ19lbmFibGVkKCkgJiYgIXF0ZXN0X2VuYWJsZWQoKSkgew0KDQpEb2VzIHRoaXMgbWVhbnMg
VENHIHdvbuKAmXQgcnVuIGFhcmNoNjQgTlY/DQoNCk1pZ3VlbA0KDQo+ICAgICAgICAgZXJyb3Jf
cmVwb3J0KCJtYWNoLXZpcnQ6ICVzIGRvZXMgbm90IHN1cHBvcnQgcHJvdmlkaW5nICINCj4gICAg
ICAgICAgICAgICAgICAgICAgIlZpcnR1YWxpemF0aW9uIGV4dGVuc2lvbnMgdG8gdGhlIGd1ZXN0
IENQVSIsDQo+ICAgICAgICAgICAgICAgICAgICAgIGN1cnJlbnRfYWNjZWxfbmFtZSgpKTsNCj4g
LS0gDQo+IDIuNDkuMA0KPiANCj4gDQoNCg==

