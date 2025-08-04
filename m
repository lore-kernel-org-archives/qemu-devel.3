Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E7BC87FD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 06:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uip6r-0001i0-T1; Mon, 04 Aug 2025 02:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uip6O-0001V7-QO; Mon, 04 Aug 2025 02:55:20 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uip6L-0002ts-MO; Mon, 04 Aug 2025 02:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ern+qBHSszh4LNPB5hIzp2f57qOCloIEfYEq9DTfmJakzT6uzZxV+9xbVDucKYKSHtKBkesLh0btOvP4FMCqDGMxSf27KnKwQbpiny2WPxVw3QqNqTl0n/Ph6zxL4w8/SiIJ9vP1W7RReOtvd0oVCa9bOp6YaP4Y0kqowGizhsm0lf6yZTBTwh/Pcubfrmd23+/a9ePJK4VwyYtPTSyCHvOwh0u1w9kPfHbO/3YESUR5P+XpUmxF+53XJ5REbPVbpUxQ+/bbYBsUMPafybOMBSI7Ui1YfD3JYoRhQ3ggWgMPDnnY2MRQM8zVihf5oNYhwWFzO1jNtTPJ1NdvtYbkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8WK2hiSSSc7v3PwhWC5pRclXLNag35MeUS/SvQ9DSU=;
 b=qBFt2gb6Urh0rtiBMfyuJq15RCh3tbRuRMiXFMaPNWzkEsRWBILPMcmSxZgVt09Yox2MLjtccwceaeYPs7Mp2xwHAdjOdinYCJC5Q6BEPG85EycBdThj1hlRiS4JcabA2w2kxK8A+hhLK9YbR6cS9F3BDjykgCIbB9ANLVJG8ftzhW+irCcITwMWoI2F0jByD6ZSVqKovBex+h91MfE0LtLOuOtK5XpRuhHhN4JK+l78iYAuOeTB1WIpHxCR9VjFsHmIr3Rt8diGDfecIatNMyGiABcuvT/NmoyiDIqjTUeoUQ4F0onb0YfzsRrxHlxREhe/BKngHrGDNJaoqyCorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8WK2hiSSSc7v3PwhWC5pRclXLNag35MeUS/SvQ9DSU=;
 b=eXj+0TG1rIYv+/Gk7xfyeU85zwn6Yu1Sk5JdCR3tW5YA/RdCKQt7Ocn8BECMvvS0O1QkYKwZfl8QcS8W20UTjQuv7Vffs9Rm0DYZluQA50v/i7j2cAwUyy/2sDKtFIeMjrPbqH4ddtTDjekizsMJxiYVUBT/1nAcD1w4mUZ7el3olek2t/KrcnG+f+e3RMW2IsXydx2VXUp7e9JwQIN/SGeoAoZ3bO9EnbUCX5HuNpZqs6c+lZgc6bLz/qQYVX9hXG3fCxnCfltZtHgl+sP0KJ+1cynPl+ZUlD1Jr0tQM+M/Tje8uhF57nmSRfp6msiOu4iz8QPHinLYvuWrMkxllA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5848.apcprd06.prod.outlook.com (2603:1096:400:275::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 06:55:09 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 06:55:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register
 read on AST1030
Thread-Topic: [PATCH v1] hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register
 read on AST1030
Thread-Index: AQHcBOGf+NaDt6pEnUmo/De6cpsHuLRSCZgAgAAA+8CAAAQ5AIAAAEGw
Date: Mon, 4 Aug 2025 06:55:08 +0000
Message-ID: <SI2PR06MB50419C98D6C6F92511014B87FC23A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250804014633.512737-1-jamin_lin@aspeedtech.com>
 <08588dcd-d622-49f2-86ed-354a896d2cd1@kaod.org>
 <SI2PR06MB504111C126DDA681D08DDCBCFC23A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <9e06eeb5-e8f9-44d0-b755-f36ea6740388@kaod.org>
In-Reply-To: <9e06eeb5-e8f9-44d0-b755-f36ea6740388@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5848:EE_
x-ms-office365-filtering-correlation-id: 89d3c9e8-6202-4500-9058-08ddd323d9b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aUU3RXFuTTZZQXJKQmg1S3hTUHRTUzhYaVZsd095Tmgvc3hHQ2NUNEZxNUNa?=
 =?utf-8?B?MFB6TTd4czZvU2hERnRBMnJBeERrQXBqZXVic0FsSlZrbWQrVTZic3hFZUtj?=
 =?utf-8?B?QUxNNTJlVlJhQ051WTBXR1RuWkxsNzhuTU5PZkFnU1p3cThWb3JKTTZLSEhm?=
 =?utf-8?B?TTgrZGFYQ1g5OG84SDlRSWVob2hnd25qWC9OVFNtMEt0dEdmSlg5UEZiRjVO?=
 =?utf-8?B?Qzd6VUdIcmpqd3pZY3dMa0Z5OXZZbmZrdDluTS9tNGY4Skd4eDkwUkI2MDRV?=
 =?utf-8?B?OVdjbFpQZll2cE5TZUxKY2RRTnZUeGdzbkNKT3R4dXNRZFV5eGVOaUEwQ29K?=
 =?utf-8?B?cHh3YW5Rem0yaVU1OTdOb3BDS291cUpvMW9SZmV6TXZpbGQ3MDJRTnVBVWdx?=
 =?utf-8?B?TXVwZTlPSHk2QWo1Wmdxc3o2aUhrTklhRkxsdlBwN3Q0ejI3K3JMU0xxbTc3?=
 =?utf-8?B?czBlZlF3MW0wSEhWMXZSN0ZDYWxya3BQMlVuMzNRM04xVzNEaDlyK1V2YU5a?=
 =?utf-8?B?bnlqb3haTkN0STlKRVJtRUJzYTh0UDVwRGl2Wm82dmJSMTRXaGNKR2xkRlB5?=
 =?utf-8?B?dXVENUFBZ0Y2TEdmYVNnbnFsU3ovMGJST1RDdEFLVjQ2RzYvVHJ5TmdhUDFC?=
 =?utf-8?B?SjFtUXZCcHJrVjdQaWwycVBaK0lJK0xMeWNDTnVXN09vdmpUbndLeVhqNnZr?=
 =?utf-8?B?dmlYSFRBbFVyUE5kK1lhUkd5NHJUQ0F5SkxFb3FFdk1xaWdpRDJEajFEK0RL?=
 =?utf-8?B?T2REbmdLQmg3RTIwdjh1RXNLNzk4d2dqZHpkU0FLNDBCUXBxSkVXREZyMFFX?=
 =?utf-8?B?TXh0M2R3eEp0K1dKNVhNMFROcnYrRUdRait0NUg4bFVvYzhiaWNZNkJTQU5T?=
 =?utf-8?B?QTdVd1VDNE5PWjBodVlGbTBlYWgxR0FHQ0JZNUo0Rkx5TC9mNEs5eXk3dXIz?=
 =?utf-8?B?UTFpTmpnUlc3d1hYYVdaWUdBRU5aWXE2c0dlZ0pjMlpHcTRZQXZvR2NiVE9v?=
 =?utf-8?B?eUtCa3Qzcm5mNDNlVVByUDdhdFByYlVtenVJMFNPTFg1aEtyTTBaOEFrY0N4?=
 =?utf-8?B?d1ZXajM4bnhZeWxVdEtMY0JiZWZGaytjeVlCNDBiZ3dnVnQxaVQ5WkFIbjl5?=
 =?utf-8?B?K0dBYjdWVXM4dklzek1reHRTWWl5WDF1TlUvNzFyK2xwMldUZmNkTmxJQkF6?=
 =?utf-8?B?aDhPOVdETE80LzNsMXc1eFNBN09hMytPSm92Q2pQL3FURWpjcmtVb25RM1Vq?=
 =?utf-8?B?UGlUMEI5MzZHczVxZVNiam9KVVgzMHZLRDVEaXd3VURiNVdZaVpIYmxHTWtt?=
 =?utf-8?B?SUtyUjg1RGtxeHJwVzBKNXRVWFI2K3VDWkdhV09id1djS3k5L05iNkx2dVM5?=
 =?utf-8?B?R25qQkJhZDZuM3d4MnV5WCsrVmUzeURKUURWbmxLUVFnSktvWlZGOGw2T293?=
 =?utf-8?B?aXA0eERjOGVXeGZSRVF3bTRQSENGNE1DT3lWTXJhbkFUUmpUa2Q2UGpNWU5w?=
 =?utf-8?B?cGM2U1JOWVYzNGZXZURJNk5mZjcwQVlkcW83bEhWeTZ2U3gvNlB1bXB6ZHk0?=
 =?utf-8?B?Yy9idTJ1Nk1WaVF2SjNwZFF6bjBLZGJLMTM4aDRIUVZLMkZMVGJzbFRObVU2?=
 =?utf-8?B?NG5EMllzMXVqbTViOURjZ2V3WGRrU1k4cjZEeG9IU3plRkd4dldUZDJiNkxI?=
 =?utf-8?B?RlNjWHE2MDhxN2hqTWRiMEE4ZWswdk9TL0lmMGEzVkVpa0lqdHpVZWpwWFQ4?=
 =?utf-8?B?ZWJjUGdSbWwva0g2R1FmTGJKVFlmdWVrR1AzSXR2M0Y4TE9ka0dUTWJ4NWpv?=
 =?utf-8?B?VUR3di9aakFXeTAvdjk5NlBOdDZxMWZvT1BkTU14R3F5T1dLWXZlY0N5amNF?=
 =?utf-8?B?eEEzcVN3WlVxR0ZZb1pRRE5yZzAzeE83OU5rWlIyRWIyUjQrdGNvTjVodEdV?=
 =?utf-8?B?SkZvRzIzV0FJTlprc1RBOXlPV3NaUkM5SW1idDZxaXk0OFZMRWJYYzFaVW13?=
 =?utf-8?B?WGtaYS90dzZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1FxZmdBK1pRWVdnY1gvL0oxekhWRDVSZkZWMUtId3dEK0JEb0xaaUdhdHdO?=
 =?utf-8?B?K2hXRi9TN2tKOGlUbW84NDBkdzEwRWg4cVlGeWtLNFdpMEJ3bStUS2twN3p6?=
 =?utf-8?B?ME5rU3F1UEJTcitSM3FTbVdBak1zdUp0UFJiYWVZTEFRZEFzalVjZU1wQy8v?=
 =?utf-8?B?Si9lQ3RDUExKY3JOVWpBQnlHajM0SldyZHdiYk8wMUVZNGlvRk11d0tNQ0cy?=
 =?utf-8?B?cWdBeTBtdFB0U3pUV3FsOEFYdGxWcHZFRTBwelNsNzFoTEcwaUhZYjFPaFN4?=
 =?utf-8?B?YUJDUkhUVGZIUGhkVGVsc202VFhiRkdubVRWMmlQOWpjUDB4Q0dFMWhpNDRZ?=
 =?utf-8?B?dEFwWS8zTWMycE9CaWRQVzM1VGlNbytEc0ZmU2ZvUG9WeWlEUERoSFZzY0VK?=
 =?utf-8?B?SEh1TUUxUEh1ZWt3OVVPMjM1UjlmY09oYjdXQ3RuK1Q3b2c3YmhqY1lnUGxj?=
 =?utf-8?B?dnpXOVhRVHM4dlVWQ2QyRWNpVWY2RXpLdG5sRWlud0lZSXJkVVBKUUw5aDdN?=
 =?utf-8?B?cHFzSTJ5OThzOXN1ajY4V1RtMEZacFB0dXZlTU1ybFBNc3JJMVNDUG5JdVU3?=
 =?utf-8?B?MjBaVGU1TTFlOFVwRlFtdzcyQXBuOUp4NWMvaDJ6VlRYWkRvUU40WUFHcnlx?=
 =?utf-8?B?VjlRcHI0TWp3OVh3dGlEMi9qTFJ6bDJJMW5TNzlKUDVZaEp6dlFIRjNuZlBR?=
 =?utf-8?B?MUV6eXJSemZXQVJ3OEhSVFAzM2pNQ1d6QXlXa3g4dXNGSEFzc0gvU2pQYzdo?=
 =?utf-8?B?VnRHT2EySFZ2OXlQL21JcVZWMDkwSVZSQjk3WVFLYm0za2h2M1I4RUYwQlY5?=
 =?utf-8?B?L2FGcEtQRnlaYmd0SStYZVZQOWNEd3o0VE1uK0FFa2xmZExISEtaendaVDZG?=
 =?utf-8?B?ZzM0dStObWxSTkxSNEJZRXZDcDR3MVRINDdna3F0RTlHdmZJbnl5a1FOMGVD?=
 =?utf-8?B?SERGcEFiaks4TFJyZHFRT09NSy9QRzNXaXVTdmhab0dTMFQ0ZE1DSG9XT3NT?=
 =?utf-8?B?aU5JRnZvcHgvZ3hwZCtUV3RlajJPMFU4QUVTakJyODFQeEhaWjZvWWlBN0xJ?=
 =?utf-8?B?RWFDU1FsaEplbVV0SGt1aVFhaVVXZXdFYk52ZFpTNUs2Yy9Id0RaY3lPMTJO?=
 =?utf-8?B?UG90KzlPaXBuMENsSmo4KzZyNWhSS01ReGF2ZGw4L0xlUnJ5bjJvc0ZPVDNP?=
 =?utf-8?B?aEYyUkc2b3hLQWF5LzI4ZTU3MzJNZkNsNWFSS3lNMFV3cW4wV3NmQUFVcklJ?=
 =?utf-8?B?aWJPL29hL1hxSm1GR1M3WGIrNko3SGZLYjQ2L0ZtOEkyajhEV1ZYVVh0dzlS?=
 =?utf-8?B?ZnVyWmJsYlRBaUl6V0txZDR5Y0NWOU1COWdVS25ESmdLTE9XL0JDL2hRTkZ4?=
 =?utf-8?B?ck91UlFGOG9sWHNJd0pHWVVGMjNndngzRHJXMlhYMEJkbFZDYllPMVNyM2E4?=
 =?utf-8?B?UGtOV3pxL0pVZ1ViUHhtYTZLMGpNOFJEbldtMzdXZllJa0pwUVZ3OUY1dFBm?=
 =?utf-8?B?WGgvVHhvWkJyQXFyR2FxcGp0VWUxZitWdUJBY2FvQXFHYTlBVkNZblBXRVhF?=
 =?utf-8?B?Uzc5VnNVb3VJZkpMY1k0U1h0L2tMcGd6RlpaL0w2cGM0ZW8yaXlCMERQd0JK?=
 =?utf-8?B?ZVhMc0t1SHpibzBOVWNsUm1WdHNTenU4QXdLOURBL1Z6R2ovWXZrSGNhOUVi?=
 =?utf-8?B?eXVjRlZJUjB4c1RtQUlxNUlXZkNOUmZZdVprN3Qza25wVDc2RS9rR29vN3Vj?=
 =?utf-8?B?ZjJ1MUdac2JZclh1NmdIWklsd0lvZ3RUV1hRd0k1aWVIYmFwcUUrWEo2UnFG?=
 =?utf-8?B?NzNxREVTSjJIN0l1U3dvSHpQOHJUckloSGdIYVdVRE9FN2ovR05WbDEyR2xu?=
 =?utf-8?B?Wkp6Z21ycVlQUUY1ZjJNdnU0TWVHWGhyVHdmbklObGJrOGtnTnZXV2lvbEdm?=
 =?utf-8?B?ZDNlY01IbFgxVEw5OHhtL0hQTWJWR0t6MWYxRTJnZkM4eDdXTmZkYjFYUjRY?=
 =?utf-8?B?WXFhelBxVHJMTTdnSW5XaDdkL1pNMC9UVVp4anZFc2dDZkVYdFVDSldqOU91?=
 =?utf-8?B?L1ZnZ1hnUzVIZmJVVis3anI0djRuditzc1FsS3JScUdDZ3lZZ0w5b1ZUSlNR?=
 =?utf-8?Q?R1hFngtcfP0RZ0rfNuIMphhf6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d3c9e8-6202-4500-9058-08ddd323d9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 06:55:08.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqXVnZrznYKScU72iNNMwmJbTdX2x8JkUDI5bkVMF0PlEkiFiG7gwKYGoq0v+OL0D3vC0IgtLKbYRom9fYXnIHm9mqQK4svn5P5thfvpmfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5848
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCA0LCAyMDI1IDI6NTIgUE0NCj4gVG86IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8YWxpc3RhaXJA
YWxpc3RhaXIyMy5tZT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbg0KPiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3Qu
Y29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BF
RUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBo
ZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGh3L3NzaS9hc3BlZWRf
c21jOiBGaXggaW5jb3JyZWN0IEZNQ19XRFQyIHJlZ2lzdGVyDQo+IHJlYWQgb24gQVNUMTAzMA0K
PiANCj4gT24gOC80LzI1IDA4OjQxLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYywN
Cj4gPg0KPiA+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+PiBT
ZW50OiBNb25kYXksIEF1Z3VzdCA0LCAyMDI1IDI6MzMgUE0NCj4gPj4gVG86IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA+PiA8YWxpc3Rh
aXJAYWxpc3RhaXIyMy5tZT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz47DQo+ID4+IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExl
ZQ0KPiA8bGVldHJveUBnbWFpbC5jb20+Ow0KPiA+PiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5DQo+ID4+IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gPj4g
bGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4+IENj
OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjFdIGh3L3NzaS9hc3BlZWRfc21jOiBGaXggaW5jb3JyZWN0IEZNQ19XRFQyDQo+ID4+
IHJlZ2lzdGVyIHJlYWQgb24gQVNUMTAzMA0KPiA+Pg0KPiA+PiBIZWxsbyBKYW1pbiwNCj4gPj4N
Cj4gPj4gT24gOC80LzI1IDAzOjQ2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiBPbiBBU1QxMDMw
LCByZWFkaW5nIHRoZSBGTUNfV0RUMiByZWdpc3RlciBhbHdheXMgcmV0dXJucyAweEZGRkZGRkZG
Lg0KPiA+Pj4gVGhpcyBpc3N1ZSBpcyBkdWUgdG8gdGhlIGFzcGVlZF9zbWNfcmVhZCBmdW5jdGlv
biwgd2hpY2ggY2hlY2tzIGZvcg0KPiA+Pj4gdGhlIEFTUEVFRF9TTUNfRkVBVFVSRV9XRFRfQ09O
VFJPTCBmZWF0dXJlLiBTaW5jZSBBU1QxMDMwIHdhcw0KPiA+PiBtaXNzaW5nDQo+ID4+PiB0aGlz
IGZlYXR1cmUgZmxhZywgdGhlIHJlYWQgb3BlcmF0aW9uIGZhaWxzIGFuZCByZXR1cm5zIC0xLg0K
PiA+Pj4NCj4gPj4+IFRvIHJlc29sdmUgdGhpcywgYWRkIHRoZSBXRFRfQ09OVFJPTCBmZWF0dXJl
IHRvIEFTVDEwMzAncyBmZWF0dXJlDQo+ID4+PiBzZXQgc28gdGhhdCBGTUNfV0RUMiBjYW4gYmUg
Y29ycmVjdGx5IGFjY2Vzc2VkIGJ5IGZpcm13YXJlLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgICBody9zc2kvYXNwZWVkX3NtYy5jIHwgMyArKy0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0
IGEvaHcvc3NpL2FzcGVlZF9zbWMuYyBiL2h3L3NzaS9hc3BlZWRfc21jLmMgaW5kZXgNCj4gPj4+
IDYxNDUyOGI4ZWYuLmUzMzQ5NmY1MDIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9zc2kvYXNwZWVk
X3NtYy5jDQo+ID4+PiArKysgYi9ody9zc2kvYXNwZWVkX3NtYy5jDQo+ID4+PiBAQCAtMTg1Nyw3
ICsxODU3LDggQEAgc3RhdGljIHZvaWQNCj4gPj4gYXNwZWVkXzEwMzBfZm1jX2NsYXNzX2luaXQo
T2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkICpkYXRhKQ0KPiA+Pj4gICAgICAgIGFzYy0+
cmVzZXRzICAgICAgICAgICAgPSBhc3BlZWRfMTAzMF9mbWNfcmVzZXRzOw0KPiA+Pj4gICAgICAg
IGFzYy0+Zmxhc2hfd2luZG93X2Jhc2UgPSAweDgwMDAwMDAwOw0KPiA+Pj4gICAgICAgIGFzYy0+
Zmxhc2hfd2luZG93X3NpemUgPSAweDEwMDAwMDAwOw0KPiA+Pj4gLSAgICBhc2MtPmZlYXR1cmVz
ICAgICAgICAgID0gQVNQRUVEX1NNQ19GRUFUVVJFX0RNQTsNCj4gPj4+ICsgICAgYXNjLT5mZWF0
dXJlcyAgICAgICAgICA9IEFTUEVFRF9TTUNfRkVBVFVSRV9ETUEgfA0KPiA+Pj4gKw0KPiA+PiBB
U1BFRURfU01DX0ZFQVRVUkVfV0RUX0NPTlRST0w7DQo+ID4+PiAgICAgICAgYXNjLT5kbWFfZmxh
c2hfbWFzayAgICA9IDB4MEZGRkZGRkM7DQo+ID4+PiAgICAgICAgYXNjLT5kbWFfZHJhbV9tYXNr
ICAgICA9IDB4MDAwQkZGRkM7DQo+ID4+PiAgICAgICAgYXNjLT5kbWFfc3RhcnRfbGVuZ3RoICA9
IDE7DQo+ID4+DQo+ID4+IENvdWxkIHlvdSBhZGQgYSBGaXhlcyB0YWcgcGxlYXNlID8NCj4gPj4N
Cj4gPiBGaXhlczogMjg1MGRmNiAoImFzcGVlZC9zbWM6IEFkZCBBU1QxMDMwIHN1cHBvcnQgIikN
Cj4gDQo+IFRoZSBjb21taXQgU0hBIGlkIGlzIGEgYml0IHNob3J0LiAxMiBpcyBhIG1pbmltdW0g
bm93Lg0KPg0KVXBkYXRlIFNIQSBpZA0KDQpGaXhlczogMjg1MGRmNmE4MWJjZGMyZTA2M2RmZGQ1
Njc1MWVlMmQxMWM1ODAzMCAoImFzcGVlZC9zbWM6IEFkZCBBU1QxMDMwIHN1cHBvcnQgIikNCg0K
VGhhbmtzLUphbWluDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

