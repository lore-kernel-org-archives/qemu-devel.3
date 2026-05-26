Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8D4CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsN6-00077v-Ri; Tue, 26 May 2026 10:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsMx-00073S-RM; Tue, 26 May 2026 10:02:56 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsMw-0000Fv-7L; Tue, 26 May 2026 10:02:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdm7eYRTHPoIWwEyV1RsgnrllIJOn0H91GKBCIg2QLjwk8XMNC5kP9T9qTu+26kOMQCT3PxfZaRIa/qW9B6FIMrSlPEbiyZ2Cux6LY2M625uAV2Hnyysbwa+KFCIU/bB4dtte9znN/+3bLBDwDYJiIA4gd3uD0gv0oaJjigxkmoPYrPqhBwcRzaIHqSpoFA68q9kvB9ycM81DyHcRTeqGDunvp6vvkWYH/VDguum/V967BawbGJBxZDVrWrzEfLShKsY2mdHjLQktU6QEAa4Zd6u1ixjaFWKpafqfToB139ZLYXNVOXo5GlTS5GV700sUEs1CaYMwwNajx7Vx2jyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5KfwnF2NRH78qD8AaeT/KIHk1TyXIGNOESODyTblCw=;
 b=LZGtd3DonvvAon+fJUesrVBCc1TlLQ7jSmPnC+1Us7ZUqe6tz2ijVNW+EHVJCTzHB+r3/YRL8ZUsnJH0phqY8vAc49SuFg1ZtjH1wEJipeK7y3wUIBelokLBxFJSXcbiWBxkIPTKvk7jvYptkfspsc39/ECP5lozK4eBI08KTxpLRz+9d//m5oHGluMcEId/xXS86kW59ADrZT8cyiLpOs/yaWGeoZnzxfqiJ5D51IqzcugXiRT2oz7gZEmucPNzkDgEOb2yQmF8Ph/OTi03fgDZ6w+YF82kfEiqin/o/hDcCRT9oYRKSq3LrbjRNK9avUa+1CR7BDX9QvC7SKNs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5KfwnF2NRH78qD8AaeT/KIHk1TyXIGNOESODyTblCw=;
 b=YJ3EbZcq7T0LQ8liVNhgNYXFtJvDiU0lX/8Ikd4f1qQyXkuZvzlaEpV1mLXQU+i1Q2wQHCe51qUXu9n9Re+oflcEnZFB0188PxUav7YJgbEikPJ4G6Uk6JeNV3/RMjxn+fdsg4Q7KXYBhlt6k96wu6zegbUzBvj0t5Ay73MDvjBamnlIi1zBm2wIn1drSXFYXqAbA11+ICBv9dMIfKrRMtuNEbg8AMmWkgK+qrlNi0eTvdm4nBDpNPUKLOY1skJxSQLIp7SLhjeedhPV/KFJXSphm1hh3ddRUqIXxKMkY/V421A/Y8mcLY9ueXEDdNQswj6a09Cy1gWbxusKX44xvw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:02:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:02:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHc53vX8b5hQLEz8Ei+yyPG8IlkFrYYf/mAgAAU0JCAB7BHgIAABORwgAAU6gCAAAEKIA==
Date: Tue, 26 May 2026 14:02:44 +0000
Message-ID: <CH3PR12MB754860679276DAB70E0DAF4DAB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-21-skolothumtho@nvidia.com>
 <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
 <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <862edcac-d8b0-465a-bc58-11678ff15890@redhat.com>
 <CH3PR12MB75481CAA2DD727BC68C88AA3AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <c2b6e502-0bd5-4b1f-b2c3-dcbc760ca733@redhat.com>
In-Reply-To: <c2b6e502-0bd5-4b1f-b2c3-dcbc760ca733@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS2PR12MB9822:EE_
x-ms-office365-filtering-correlation-id: 7b110d2b-a032-4177-8253-08debb2f7597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|11063799006|4143699003|3023799007|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: N9ngzyQVeY9w72agttSqdeDrhd5dokmB9KZV1bwzJ6zcoSYOjHvu87KRFGQv37J/tyeKvlLQKSDEVzo0Gpbvz6Yok2IH7BqRbaVKpSNCEmUH3mObyjx7d2h7y8qCpyY1B3SLexRPncdoZ3O/2KO42yPG6irs6fexem4FzxgJVN4CQlXQU/1Gb3zdTcFLzDrndORJaSwQhTrgkPqDfmi1EE0XpV3XqaxyKe7bE0xmFiWdCy1MjtsjOpiwEiLqX9DfcS5Qn19ynxImMyLHXxQZx8SO/DmC1hovCPkETSRcAGRzt2fic11LeTzHZPWBrVV7i9l89PoraXLKXinx1veMyrY5BYZGru16jvmpm13kTI+qeqe7oHXi85+j1JkLgqSHeFpGGsJWnLOoXMI1ZE99nb0eOkn39RJhaipgbYyJvgldbkbScllkQaPzlfzkiQhw/SKehysc7zAaaxatK7jNc2iNAKZK2PNnmsb+s5U5Equ21LAaPjeLLPVQ52k6LLq6kVMEe7VzDJ5U4QYmvWW/TfjWE4/GmtzccXXQd26TVtnbostsIYwnq+O9L6V3VYpvvbvAnt3gIPz6grskZBsMWIQMMyTd+2bQ8P1BheLnvhgrGSnFQ8nqmRVGHPAbCyR4L3iwOiQh880/+mgO4vfr1xjmNXVowD5qQ51uS+rDnClVa+DHXI0Vzf1s9jCw1m/sufhwFaFee6fbGEJnMQsRozgZI7X1/VGNJEdpCw+wCwqUv6iUIwuR0vFF1KclVpUM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(3023799007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXQxaWY0ZitIcmRlRXBtRXQzMHJ6V0lwUnBXTmFpQ2NySnZ6dTl5MEg0bW12?=
 =?utf-8?B?ZE5tQ0Jtall1VFc0YnNNbXh4TUZnQ0NVbnBLYUlzd1ZqMEJkZ2xvempaS2dQ?=
 =?utf-8?B?VkdoS2RaNGpqdDV2MXFjeU4yM2p0UitEYTRZcTdZd09HTmdSakl5TldyYUN1?=
 =?utf-8?B?WkFkcHhxK29VQm9UVkVXanFYUytIaWRjN2RmL1NrNFIxenJ4VlJTYmR2dDFU?=
 =?utf-8?B?c05BT2tkUjRFa2xrTi9sQk4ydXdKZktHYlU3WTh5VWVzTzVINUg4YmRraGxu?=
 =?utf-8?B?dEVyeUx5WkhDVk02UE9oVU5wTzQ2OVQ1eGtMQ3lDMXFFQ2RHTUFHMUFSeDMr?=
 =?utf-8?B?cEpna1FNTUpHOUhvS3I3TWExT1B6bHBnbFlGdmFTUDNCbXJDSE5lMy9ncGp6?=
 =?utf-8?B?KzlhdjRzc2poRktWKzFnaDVvYk9VTU5PaUxBWE9CYnJhZ25lT2lTVjMvNCtB?=
 =?utf-8?B?NFVCWnNpMTMwbUppb0xKNm9oVDRSTDMyREFobVNqc29pMmZ3bmF0bHRUUkVV?=
 =?utf-8?B?Q1JaQ3BIYzZEVnVNeUN2aWVqUFdlOXNHYjRPNFFpdXVwbmRHN1B1bUdobG5D?=
 =?utf-8?B?QXhRYWNoU0pRVVM1WWNZTjduTXVyOGFsWjdMcy8wR3c4cW1HTEtKLzZ1Ritu?=
 =?utf-8?B?WERGcUNzYU9CYlJ2WkFXYXpOb1oxUU15aEw4S0pYQi92REE2VkljWkwyL0hG?=
 =?utf-8?B?ZEt6UFhORForOHNleUEyTi9IRm10V3VGNlBxR3BLdHN0WmN0MGNoS3pqWlY5?=
 =?utf-8?B?SXViN1FMOFJRTFBETEltSTlHNGpteGx3N0o5Ly9tdlorWUFvQWNqeXoxTm1C?=
 =?utf-8?B?QlUyUy9YNzdnUDdsWnM5V2I1Vm83ZVY3RVlmTjl6WEFKYnNTUndnRkx6QjAw?=
 =?utf-8?B?K3NTS1RyakpFOVdDUnV1akZVTGwwRytDU0x5cG5vZkxBM05mWmJEb0F0VE1x?=
 =?utf-8?B?YmRQeFhLV1VDMW5wcUlTeC9OWjVaeWFLNyszL1N6VFVnUkc1Q2djenJTdWIx?=
 =?utf-8?B?T0NrRHQyb2ZDWG1xRTlsZnhwNkQxck9RTmNoRWNkNFlXSFdYeExwalhFTzlH?=
 =?utf-8?B?czVOUW9uYzVFUzhyd1htS0tpV01paWtlYms4UzdSK1dIdENkdHBFcXpUWXlZ?=
 =?utf-8?B?amR3L0lKNVp1azJEajN5aEI2Y2xoZU45TVFaUktUUWhBdzNFZ3kvZFUwNUJ3?=
 =?utf-8?B?UWliK2RsMUFrUWozRkFHelhERXlYbUJVVnAraW9XZDFGNE9PaG1panphMk96?=
 =?utf-8?B?WmZmYVh5M09IMFNvQndsVjhGN2VRbXYwa1JET1AxRUFlSm0rdUZqYTRDd2lQ?=
 =?utf-8?B?aWNSdjJ1Z3Vkd1BrVHJNdHF0bVdDWjQxWmQ4ZHRSY0NVUU9kcjhhNkpvc01m?=
 =?utf-8?B?VC90RXFkTXpKSGxySm1obHZsN0JJVHRCWVMyL04xeUx5RXUvdkloSWRFRFJq?=
 =?utf-8?B?RHZzWDRzQm5GdU94U29lc0FPRFNseVFhMzFVeXZSSEU0V1oxU01hdWdLb2V1?=
 =?utf-8?B?ek84c2NkMm5ubDFwb0NmWjN4YXBCYzVHZ2FlcE1wbWJ3b3pGR1Q2MWxXdDZZ?=
 =?utf-8?B?ejZNdS82R3AyUTRicUJNTWhESDl5d2NPRUFOa24rSUtJK2U4YXdvN0hvSjh5?=
 =?utf-8?B?b3ZqQ0pwM21qRmpUWTkzWHAzb2dsd2s0dWxiVytoYUxPeTZ3RnBMbVB3aita?=
 =?utf-8?B?L1hyaEpOTlhmTTNESXVhRjNYRTZKK256VWtUMXp1dCtZSU5OWFlacXBVSCtG?=
 =?utf-8?B?UjNVY1V1K1FSTTJmWHZQZEpGV0lMVVJtRUFoaGtpSXdpcXkyY0hia1IyczlI?=
 =?utf-8?B?T0tjaDJaVUI1N29IcmRoN3NnWFJMRHdWc04zU0tlWHlTeHg4UDg3aXA4d1dt?=
 =?utf-8?B?RGNDYjBIVzZFbWZRc2hDbGRZbWJYSnlreUhWWkhMSkFmMVNLUWZoa3pQTXE3?=
 =?utf-8?B?cGtNN3dvMndldlBPL1F4UDBQaVd0Q1hiRTNKM2lEN2craWZNV3ZlYzh2UjQx?=
 =?utf-8?B?WmkrZE56bkwwY1htM2RSRkdLbjkyMjVvdGZCWGI0YVZZdGQram56RVZFMExq?=
 =?utf-8?B?UWhoN3RCYzVRTmM4bWNIUmlKVjkwQllFR05pb3B1VmgxM2F3M2hHNDRNQlFW?=
 =?utf-8?B?T1dlQzJPSnBvQzhFUnBHQitoKzJRL1pxUjRlY1ZxOUxqUHNnYlhTa3RNcW43?=
 =?utf-8?B?NCtWWmZqMjM1ZSsvbWphcFFCQVdzVVY0am1mZFpRUEtFSmZlb1VncVhxUnRm?=
 =?utf-8?B?Zkx2TnFKOUNtUC9wWHBHcVp5NUR1MHBPYjFHcnhmcGR2aisrN2lUd1crNlZ3?=
 =?utf-8?B?KzBsNkh4alI3VmF4NUk0QU5ZOTNyOWlXRzV0aWRkdDRHTmoyUDA2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b110d2b-a032-4177-8253-08debb2f7597
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:02:44.3285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FeZtSMiSiMHhYfLKTlViHk4l5D5hDm5furRCP/TT+9aWZK9JLGbSOEqLTxoQL1K58na4MEyvSttNWbZBDT0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAxNDo1Mw0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAyMC8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBVc2UgbW1hcCdkIFZJTlRGDQo+IHBhZ2UwIGFzIFZDTURRIGJhY2tp
bmcNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gNS8yNi8yNiAzOjAwIFBNLCBTaGFtZWVyIEtvbG90aHVt
IFRob2RpIHdyb3RlOg0KPiA+PiB0aGUgYWNjZXNzIGlzIGRyb3BwZWQgd2l0aCBubyBGYXVsdC9J
bnRlcnJ1cHQuIg0KPiA+ICJXaGlsZSB0aGUgc29mdHdhcmUgY2FuIHByb2dyYW0gdGhlIFZpcnR1
YWwgQ01EUShzKSBkaXJlY3RseSB1c2luZyB0aGUNCj4gPiAgIGRpcmVjdCBWQ01EUSBhcGVydHVy
ZSAoYW5kIG5vdCB0aHJvdWdoIHRoZSBWaXJ0dWFsIEludGVyZmFjZSksIGl0IGlzDQo+ID4gICBy
ZXF1aXJlZCB0aGF0IHRoZSBWQ01EUSBiZSBhbGxvY2F0ZWQgdG8gYSBWaXJ0dWFsIEludGVyZmFj
ZSBiZWZvcmUgaXQNCj4gPiAgIGlzIHVzZWQgdG8gc2VuZCBjb21tYW5kcyB0byB0aGUgU01NVS4i
DQo+ID4NCj4gPiBBc3N1bWluZyB5b3VyIHF1ZXN0aW9uIGlzIHJlZ2FyZGluZyB0aGUgYWJvdmUg
cXVvdGU6DQo+ID4NCj4gPiBUaGUgcXVvdGUgaXMgYWJvdXQgdGhlIGRpcmVjdCBhcGVydHVyZSBh
bmQgc2F5cyB0aGUgc29mdHdhcmUgImNhbg0KPiA+IHByb2dyYW0gdGhlIFZpcnR1YWwgQ01EUShz
KSBkaXJlY3RseSB1c2luZyB0aGUgZGlyZWN0IFZDTURRIGFwZXJ0dXJlIiwNCj4gPiBhbmQgb25s
eSB0aGUgInNlbmQgY29tbWFuZHMgdG8gdGhlIFNNTVUiIHN0ZXAgaXMgZ2F0ZWQgYnkgVklOVEYN
Cj4gPiBhbGxvY2F0aW9uLiBJZiBkaXJlY3QtYXBlcnR1cmUgd3JpdGVzIHdlcmUgYWxzbyBkcm9w
cGVkIGZvciB1bmFsbG9jYXRlZA0KPiA+IFZDTURRcywgdGhlICJjYW4gcHJvZ3JhbSBkaXJlY3Rs
eSIgd29yZGluZyB3b3VsZG4ndCBiZSBtZWFuaW5nZnVsLg0KPiA+DQo+ID4gIkNhbiBwcm9ncmFt
IiBiZWhhdmlvdXI6DQo+ID4NCj4gPiB3cml0ZSAweDEwIC0+ICBBX1ZDTURRMV9QUk9EX0lORFgN
Cj4gPiByZWFkICAgICAgIEFfVkNNRFExX1BST0RfSU5EWCAgLy8gcmVhZCByZXR1cm5zIDB4MTAN
Cj4gPg0KPiA+DQo+ID4gIkRyb3AiIGJlaGF2aW91cjoNCj4gPg0KPiA+IHdyaXRlIDB4MTAgLT4g
IEFfVkNNRFExX1BST0RfSU5EWA0KPiA+IHJlYWQgICAgICAgQV9WQ01EUTFfUFJPRF9JTkRYICAv
LyByZWFkIHJldHVybnMgMCBvciB1bmRlZmluZWQNCj4gPg0KPiA+IEhvcGUgdGhpcyBhbnN3ZXJz
IHlvdXIgcXVlc3Rpb24uIGxldCBtZSBrbm93IGlmIG5vdC4NCj4gDQo+IE9uIG15IGVuZCwgSSBy
ZWFkIHRoYXQgdGhlIHNvZnR3YXJlIGNhbiB1c2UgZWl0aGVyIHRoZSBkaXJlY3QgdmlldyBvcg0K
PiB0aGUgVklOVEYgdmlldyBhcyBsb25nIGFzIHRoZSBjbWRxdiBpcyBtYXBwZWQuIEFuZCBpZiB0
aGUgdmNtZHEgaXMgbm90DQo+IG1hcHBlZCB3ZSBhcmUgbm90IHJlYWxseSB0b2xkIHdoYXQgaGFw
cGVucy4NCj4gQnV0IGFueXdheSB0aGlzIHVzZSBjYXNlIG9mIHVzaW5nIHRoZSBkaXJlY3Qgdmll
dyBsb29rcyBwcmV0dHkgbWFyZ2luYWwsDQo+IGRvZXNuJ3QgaXQuDQoNClllcywgdGhlIGRpcmVj
dCBhcGVydHVyZSByZWFkL3dyaXRlIGlzbid0IGFuIGV4cGVjdGVkIGNvbW1vbiB1c2UgY2FzZS4N
Cg0KIFNvIGZlZWwgZnJlZSB0byBpbnRlcnByZXQgaXQgYXMgeW91IGFncmVlIHdpdGggTmljb2xp
biBhbmQNCj4gSFcgZXhwZXJ0cy4NCg0KVGhhbmtzLiBJIHdpbGwga2VlcCBpdCBhcyBpcyBhbmQg
aGF2ZSBhbm90aGVyIGxvb2sgYXQgdGhlICJvdmVydmlldyINCnNlY3Rpb24gdG8gaW1wcm92ZSB0
aGUgZGVzY3JpcHRpb24gb2YgdGhpcy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

