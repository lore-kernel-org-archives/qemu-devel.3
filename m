Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53180D3C912
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLtW-0007Lt-4m; Wed, 10 Dec 2025 10:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLtK-0007KM-Oh; Wed, 10 Dec 2025 10:14:12 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLtI-00009g-PR; Wed, 10 Dec 2025 10:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEZ3n9LOwmRpSF2By100CXz1IeH/b9FNMCXZ/JB+eOTBhWhXJzsjL0T/X0x7zFpY8iFa2h0DMU37WFX1KLwRy1TTgB26QHHZFFA6sgfoi68fNcouT+Sg4UK9lhFs4IerUZnUMisEn64LVIm/LB8bE6+d6hxoDivMjwYDMHfznX0Kur+fco3FLn9NmowevIjCxzLRLAKbwA1uhELGrLi9Wf2s5yshpBRX5tE8DRPUTJkgyt/3CtTYiERso4VruZ4vLRolam2dS2fhIBbrmuQZYllwptQ0FKb16s5FuKWGFmLkOtPfAaubxP3ecGcHftGZnt3SgMGu3z//WVQv6aeVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+C8uN6b4uePC7zOCckVhyprKAB7bX0V9WcopQDA1v0=;
 b=JFHQPyHBPlV+vFUELSJs9U6JDOpecEKM9n2icXg0B8Eo+OmgAeCTmDyNwmnm5IKmbqZ4vx64DcheOHgNEAqTwDk/Z9Ooq6IRddv2ntjkoc+bTg39OjcRQRs0egyo+BIFx5Cv9QOF2f21aJew8sNdmKPcCzbKc97FQgu6I1LEkby6E+k1qZ5XBGOH+jqbkfngUrSAYi/VjAuGpWQ31VspGrhR33eR3wu8DdkEfKUzXbMid3R8PFOuoYiMiKnqNCBv2vvWsVPzQUNWVvPas4xy/1rj5zvIZJkDK/vxYmWAEtXuv2yEc2fZ+3X//nYR2ZfexqartbmET0+qx5251HQvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+C8uN6b4uePC7zOCckVhyprKAB7bX0V9WcopQDA1v0=;
 b=Uurpxkimb0k9Lh8m5PFY5IE0d5UlJQhODf5dAzFw3JR2DovCajQAn+6D7nxX4tYYsRKYhJ8mAWxrILpRZpsjz833PQsfqZ3+lU3sicnOBM9GegLo7Qn56ivTe4ueHW/wPzi7E4zFZzybPeqlvm04jLMvNYL5V4A5WXWPsMjbi+wc9Q9HccATUDYDeFGCaGGZCcG1mR/7yzeSkrW96MUU+AwSAyHqf0YdS5GglfjUZ3wbt7UBeMbauyrPaizoMuuWCqWb7nuro8H/AaF1ymzX3aLD3kPnZjqMwQcEzkFADQHKfj7qfZTig04LOpey2xifnoZa9uJpA/84Mm4LPzpvzA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 15:13:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:13:52 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Thread-Topic: [PATCH v2 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Thread-Index: AQHcZP/Ydv9Xl7ZJq0Glm40LrrrF77UZJA2AgAHgmjA=
Date: Wed, 10 Dec 2025 15:13:52 +0000
Message-ID: <CH3PR12MB7548DF3F1D52660D516AC4A5ABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-2-skolothumtho@nvidia.com>
 <bf00d499-cbe9-4e14-a79c-a601fd19a558@redhat.com>
In-Reply-To: <bf00d499-cbe9-4e14-a79c-a601fd19a558@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB9036:EE_
x-ms-office365-filtering-correlation-id: 974b9bae-e07f-4c08-eebc-08de37febace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cFJlZnZFN0NNeUVmbitkbkpoRUorcTZVWjBTSXFxL09IaTY3ZDhLV0JyUnV2?=
 =?utf-8?B?VmhOdTV5LzFoZCtWcUhRaVV4NlpaZlRzMjVNWnZySXpiMGF2ZmFiVHhYZjdM?=
 =?utf-8?B?czRBOThqb0hlYWQzQjVUUDNoT1h1VUFMMkZtR3dKVlRUUDY3TDdmeDl3NkNZ?=
 =?utf-8?B?MVpjUEMxck95VHE5QTFJYVJXTkRUQU51U25OUWhhZXQrNlZYQU00TGdhQTNm?=
 =?utf-8?B?STNIQ2lXZ3ZBUHFnU0k2d3h1cXE5TFhmVFI1STZ0M0VCdEFEU251T2FQcnVO?=
 =?utf-8?B?YTBSRnU5UXNHMG1IcWVjK1A0WUlZZGN1VjJTNHVVaUd2S09VNGdNSjhtQ2dk?=
 =?utf-8?B?YWpRbEFacXZPZ0lneGtzTlZCdXZiQ0ROM2srOXhOT3p4NkhYWUFodU1XNXFH?=
 =?utf-8?B?WGtOR1VBakxsRmJTS2F3VmRzMEZrZ2FMd3JFN0xFaUZ0RXo0MGtVVVhVNTht?=
 =?utf-8?B?a0V6YXVqVGVrY3FGcyt3cXdUMWRxZTZ2cGNJdWJsbXNnR21Ha1NGa20yUTBM?=
 =?utf-8?B?SEpuU0JuQW9STFUza2FZWEs3azlwTGpGTENiSE5QQkJvMUwycWRzbHNZY3hI?=
 =?utf-8?B?N3V6amNSK3NqNFNEWTJGQkZFajBiRDFnbWFMT2tnRGdKZnVRWmpjcjhCVWdK?=
 =?utf-8?B?Zm5mM1FJRXVJUXpmOWo2bEZMcVN0R3JDbVNGSEM1MjN4MG1LNW4wYUovdVll?=
 =?utf-8?B?SnZnQUpmVUVJMmhHbHRvZUQveCsxWW8wbmkxS28zWkZKc0VOMXdDRUdFbytB?=
 =?utf-8?B?aXhraVd6bktRRE4ySytYbWdxdFU5TXZwYVFEWXErYm1WNnZVVjJQdDhLZ1A1?=
 =?utf-8?B?REo2RzU0QkZiVFBpeDJDSjhENmIySzVlNGFvOVhBMHNRSlVrQUE0OHI2L204?=
 =?utf-8?B?UU1YczRMTFhJM0l2OFV1L05nQXF1djFZK20zWDdIZjBlbHdCT3F1aVM3dWJE?=
 =?utf-8?B?a3I3U0NrblpPODhqdlNXeGhxQmZoc2hIRnk0NVcwYUVLTHRqdEQyejlXTzVJ?=
 =?utf-8?B?SHRWUVB6S2dsbHdhN3UvaEdKZWpjK09yMGZiOW54WDhtRzlMQ0hnaU1ldW5j?=
 =?utf-8?B?QUI5eUxYU1VBL2U4MU9EU2RObEt0Z2RJNEFwRnNSR1g4WFRGRmFXVmJmSUpm?=
 =?utf-8?B?K0tyV0N5RWxPREpIUVVZSitPRU01UTVTKzZ1Y0FWQ0dnWE5ZNk5pa1dOalVV?=
 =?utf-8?B?SnQrRitwWFovZjg0TDJnU2hjR1R6ZW9SdnRFR0lDbDVwZGo3THp3aDd4d3Zj?=
 =?utf-8?B?Q1dMWlN5eHhERkNuWjBoQThaTTBVSG5RZ0lncUJnZ3UzK3NlUit1Vy9BOUxS?=
 =?utf-8?B?cUhia1BGYUxzZU9mWm9MMytFdFJ5YzA0UnlDMVNGMGJjUTRLMm40QzFDR0hB?=
 =?utf-8?B?bW02YlpHNmY3Mm9TTllWU1BzeWsyakRCbk9ma1VYRU1BYVV6b25wVm9ZUEE2?=
 =?utf-8?B?SjZiNERZU1hwQmZqN3lxbC9hdUduUlZ2VmJrUjNmZW9iWW84YjBpRmpUb2M1?=
 =?utf-8?B?aDBSenUxYWx4ZGxEM3lwSFQ5NVdRRjBjT1BwV2twQmF3MTVheExyTlZLdzlY?=
 =?utf-8?B?UkdrbUhLZHBqUjlGVWRlbTFjeVRSV1ZMS1MwWC90bkUvdzdwdFV6SEpkNldJ?=
 =?utf-8?B?dnpzejB3cE1zMEpXQUpPUTgzeTdXZXZyWlRhbG9IMmdXWVhTSWhzSlBrZWtW?=
 =?utf-8?B?RG5TaU8raVN4YUNTbDJGRDV6VEpZOUdBT0RlZXRCY2NhYVg4eEpSdHB1bW5H?=
 =?utf-8?B?T0lLUzEzSlNYUTRDMWw3OGhBVmRENFFhSExyNWp1T3EwWmtudDloSmhpVnVj?=
 =?utf-8?B?QnlHUmVTbitCaE95ZE4wV3RBWUJXNXU1bkFnUUFVbzFFZUIwdnk4eDUwT3Zw?=
 =?utf-8?B?MTBDL0xnZzczV29INjJsOWdBMlUxU2JHcHB6N0RDVVQzdUU5Mzhad3RwcEE4?=
 =?utf-8?B?N1NKU2NFOVgzbjRQMndhQUVQVjFaVWtFcWFEeHB1Nmdsd0RTdXExU0pIM3Jh?=
 =?utf-8?B?emhMdnpaclBSaUFjSnA2VnFkL2VHRTEySlM1Unpxa2ZSZzZmaGlXWXdTbzNQ?=
 =?utf-8?Q?FDZXXO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhmTC9wNklSejRMTXJ5eWRDckJ5M2VJdTJVU2pwc2hKNHQ3UVV0KzJXem1F?=
 =?utf-8?B?UjVuNjVNYU4reTJTUUhyeFlvSUx2SWs3YTYvM3B0b0tUMEUwWDcwTDljdVI0?=
 =?utf-8?B?VUU1VG5CYXlvN0c2NUc0b25VOEY0Uzd6QTIyMFJoVmhuWVpkcjFKMUxmQUpF?=
 =?utf-8?B?aCtWbk9VcUtpNW96eERvak1IUWdZc1VFSWdVekJxdFFFcmZ0Q2J6QlFUbHg4?=
 =?utf-8?B?VXBES1JKOUhROXRUYUtUZ1dxMmhLcHBOQ3NEVHBMaVVxNGRPWDZXUkhmVW5t?=
 =?utf-8?B?c0VDMFNJSVB2SEpvZnZydXVabGRseVVKVG95R2I3RXpYQ3BxTzNZYldRbnBm?=
 =?utf-8?B?TVg2Q3RBUVQwc0tESnNaSzhJbTFoaVNWTENiL09UYU5pdGZnNnprdnRrR2ZC?=
 =?utf-8?B?dTNTSnk2VnRFNWxEa09Md0cxMmFkRXVlUndOL0FGUVFkRU9DY2pBeHpnakxE?=
 =?utf-8?B?dFZhTWlpM3FEOVVxaWxNMjFPK1htdDE0QkZDVDlPZm1nZGxrUDd5TXJlUTN6?=
 =?utf-8?B?YjUzaHRtYnZpcDZuSzJtQWJIOXNOR3dNOElTSHNIcDZMa1pDOXBuSnF3SjJC?=
 =?utf-8?B?bklkZ242S1k5ZjR0T3h2dys0Nmk1bWFQcVZBZkN0aXgwTCthTzFPS3Btdm0v?=
 =?utf-8?B?eENVcDZRZ205MlJwcHpMWW1pZ2hTTUtBZTZiM0JsSTlIMEFpMzZwUmVpY0x4?=
 =?utf-8?B?aFpUY0piREJVNmI5YjVSb054bFFpN3NhYUtWRVB3Q1NiWFZjem5HNjA0ZkUz?=
 =?utf-8?B?NVBUWk1zQ0FvZEJZaGUycHNPWDdxbWkwVThNRS9ZRzVocmVBdWgxb1NCQmh0?=
 =?utf-8?B?Y0NCeUkxQTY4VUNEQitpWG9uVzdOYUdlZ3NLS0dBem1yNlZ2ZWtFVzlscHlh?=
 =?utf-8?B?emY3WGkzOEpDMlRHenJIdTc0Q3IyQ1lSNm9qWWVycFpMQi9kQmZXY3BYU2RK?=
 =?utf-8?B?NUFtMUtNYlY0cGZBSUV2NEhwT3VPeGx1V0lSSjJzRmQvak10WmFjYkpRNUM0?=
 =?utf-8?B?RmdDSW9NeExLYW9kZmlsRGoyUWxmbElUc21OUmNEMjVkNmk1VzNOdjVQR01t?=
 =?utf-8?B?MXRTOGU1cVZZM1A2RkJLRktSZ1ovV1daNHp4Y2E4Ty9MOEZuUDdrcjhDcEt5?=
 =?utf-8?B?RDlUOGRpa3VwQmJnc2pScHNERlhEMnExRFpvZGh2dVNWdWtwWVVuRExocUFF?=
 =?utf-8?B?WmpzNlpqRk9jS3c2bXVYbituVzN1WTNPUUJPVjBQaEVmaVdnR05JejRwbFJa?=
 =?utf-8?B?WS9sVmRycTZjdk9PZWwzaGdXWDVNZUpjSm40Qm1wcTJ4eXMrNWM2a0hKS2U3?=
 =?utf-8?B?Qjhmb2hmMm5meHc3TE51alB4eUd6MktwdEtVd0VjSnVxU2xFeGh3U2xaR1p2?=
 =?utf-8?B?ZDdlOGJtQjMyUUx2Y2tWSzA3RDM5STZPWCtBWnNKMDdseHYwUVhZcTR5QkVW?=
 =?utf-8?B?ZGplQ1dMN2lMUWZwOFJxclcvdm5nSjBqUkFXNThQUTNvaEtDMy96cFVQaGhV?=
 =?utf-8?B?U2xjbnI2VHEyR0RxOXlNNitNekZCc3U3cUpqYlpibnpqbzF2WldMcmNNUUpP?=
 =?utf-8?B?MHVzTVpqVnVSaEpOM1FtTERzT0d0Y3NSWHZieUU1dkF6bElUVWxtZlhtR3R2?=
 =?utf-8?B?UFkwb3htWmJIV05BN3FoQXFWVzRsZ0x2Y0RMWDRjd1U4dnViMmh1WkNkelpI?=
 =?utf-8?B?N2YwUGFmQnZrWmFvdVB1Uno5Q1VUdWQ4MituSnNHOTZ3ZXFpYW03eDltVkVu?=
 =?utf-8?B?VlpvdmJ0OE13SDcxV25pZ1A4aFJZMEhZVmZCditHY1NHdFBEVWJzTWZiQXJs?=
 =?utf-8?B?dXNMSklrSUlFUklmMVNwZ0hyL1hZVlFUNVA3UU9RQ2tvK0tEZTJIMVBZZ2gr?=
 =?utf-8?B?N1ZheFBKZUxpOUw1SlJOUStTcTM2OVJZTnhuMDVsajlldFhBb1p3M0pTdnJh?=
 =?utf-8?B?dTZnMWx2UW93V2NSdmluWWFsYStMN242QWtGbCs4YzQwbWFnYU9ZdW5SUlhT?=
 =?utf-8?B?SWxzSUJyeEhBY1gvZCtUcE1nOHMybHRNS2QxeHBtNVN4MC9nNTlWYVhoaUpv?=
 =?utf-8?B?MzVyMU5DcVBXckNWQjE2KzVHdEQ2N3AwK2M1U1FnMXhFVm1HdWVtUmVIRGZY?=
 =?utf-8?Q?rOrqcviZ/QQF2rVwQXLNpDPUX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974b9bae-e07f-4c08-eebc-08de37febace
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 15:13:52.8246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JykqUAsW+x/16NAjMtM/vNaNKpLqljNpgfQ996amQaVkhRp6plaRLhHSYxb+yzOgAaa4HCuSOOecf8iP2Q1Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
Received-SPF: softfail client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwOSBEZWNlbWJlciAyMDI1IDEwOjMyDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuDQo+
IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47
IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMS80XSBiYWNrZW5kcy9pb21tdWZkOiBJbnRyb2R1Y2UNCj4gaW9tbXVm
ZF9iYWNrZW5kX2FsbG9jX3ZldmVudHENCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlv
biBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMTIvNC8yNSAxMDoy
MiBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgaGVscGVyIGZvciBJT01NVV9W
RVZFTlRRX0FMTE9DIGlvY3RsIHRvIGFsbG9jYXRlIGEgdmlydHVhbA0KPiA+IGV2ZW50IHF1ZXVl
ICh2RVZFTlRRKSBmb3IgYSB2SU9NTVUgb2JqZWN0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Tmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBi
YWNrZW5kcy9pb21tdWZkLmMgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGJhY2tlbmRzL3RyYWNlLWV2ZW50cyAgICB8ICAxICsNCj4gPiAgaW5jbHVkZS9z
eXN0ZW0vaW9tbXVmZC5oIHwgMTIgKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
NDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2JhY2tlbmRzL2lvbW11ZmQu
YyBiL2JhY2tlbmRzL2lvbW11ZmQuYyBpbmRleA0KPiA+IDcxOGQ2M2Y1Y2YuLjYzM2FlY2Q1MjUg
MTAwNjQ0DQo+ID4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+ID4gKysrIGIvYmFja2VuZHMv
aW9tbXVmZC5jDQo+ID4gQEAgLTUwMyw2ICs1MDMsMzcgQEAgYm9vbA0KPiBpb21tdWZkX2JhY2tl
bmRfYWxsb2NfdmRldihJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IGRldl9pZCwNCj4gPiAg
ICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4NCj4gPiArYm9vbCBpb21tdWZkX2JhY2tlbmRf
YWxsb2NfdmV2ZW50cShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+IHZpb21tdV9pZCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB0eXBlLCB1
aW50MzJfdCBkZXB0aCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCAqb3V0X3ZldmVudHFfaWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgKm91dF92ZXZlbnRxX2ZkLCBFcnJvcg0KPiA+ICsqKmVycnApIHsN
Cj4gPiArICAgIGludCByZXQ7DQo+ID4gKyAgICBzdHJ1Y3QgaW9tbXVfdmV2ZW50cV9hbGxvYyBh
bGxvY192ZXZlbnRxID0gew0KPiA+ICsgICAgICAgIC5zaXplID0gc2l6ZW9mKGFsbG9jX3ZldmVu
dHEpLA0KPiA+ICsgICAgICAgIC5mbGFncyA9IDAsDQo+ID4gKyAgICAgICAgLnR5cGUgPSB0eXBl
LA0KPiA+ICsgICAgICAgIC52ZXZlbnRxX2RlcHRoID0gZGVwdGgsDQo+ID4gKyAgICAgICAgLnZp
b21tdV9pZCA9IHZpb21tdV9pZCwNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsgICAgcmV0ID0g
aW9jdGwoYmUtPmZkLCBJT01NVV9WRVZFTlRRX0FMTE9DLCAmYWxsb2NfdmV2ZW50cSk7DQo+ID4g
Kw0KPiA+ICsgICAgdHJhY2VfaW9tbXVmZF92aW9tbXVfYWxsb2NfZXZlbnRxKGJlLT5mZCwgdmlv
bW11X2lkLCB0eXBlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFsbG9jX3ZldmVudHEub3V0X3ZldmVudHFfaWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYWxsb2NfdmV2ZW50cS5vdXRfdmV2ZW50cV9mZCwgcmV0KTsNCj4g
PiArICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVy
cm5vLCAiSU9NTVVfVkVWRU5UUV9BTExPQyBmYWlsZWQiKTsNCj4gPiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgZ19hc3NlcnQob3V0X3ZldmVudHFf
aWQpOw0KPiA+ICsgICAgZ19hc3NlcnQob3V0X3ZldmVudHFfZmQpOw0KPiBjYW4gaXQgaGFwcGVu
IGlmIHRoZSBpb2N0bCBzdWNjZWVkcz8NCg0KSXQgY2FuIHJpZ2h0PyBJZiB0aGUgY2FsbGVyIGhh
cyBub3QgcHJvdmlkZWQgYSB2YWxpZCBwb2ludGVyIHRvIHJldHVybiB0aGUNCnZhbHVlcyBvYnRh
aW5lZCBmcm9tIElPQ1RMLiANCg0KVGhhbmtzLA0KU2hhbWVlcg0KIA0KPiA+ICsgICAgKm91dF92
ZXZlbnRxX2lkID0gYWxsb2NfdmV2ZW50cS5vdXRfdmV2ZW50cV9pZDsNCj4gPiArICAgICpvdXRf
dmV2ZW50cV9mZCA9IGFsbG9jX3ZldmVudHEub3V0X3ZldmVudHFfZmQ7DQo+ID4gKyAgICByZXR1
cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgYm9vbA0KPiBob3N0X2lvbW11X2RldmljZV9p
b21tdWZkX2F0dGFjaF9od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQNCj4gKmlkZXYsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBod3B0
X2lkLCBFcnJvcg0KPiA+ICoqZXJycCkgIHsgZGlmZiAtLWdpdCBhL2JhY2tlbmRzL3RyYWNlLWV2
ZW50cyBiL2JhY2tlbmRzL3RyYWNlLWV2ZW50cw0KPiA+IGluZGV4IDg0MDhkYzg3MDEuLjVhZmE3
YTQwYmUgMTAwNjQ0DQo+ID4gLS0tIGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzDQo+ID4gKysrIGIv
YmFja2VuZHMvdHJhY2UtZXZlbnRzDQo+ID4gQEAgLTIzLDMgKzIzLDQgQEAgaW9tbXVmZF9iYWNr
ZW5kX2dldF9kaXJ0eV9iaXRtYXAoaW50IGlvbW11ZmQsDQo+ID4gdWludDMyX3QgaHdwdF9pZCwg
dWludDY0X3QgaW92YSwgdSAgaW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUoaW50DQo+
IGlvbW11ZmQsIHVpbnQzMl90IGlkLCB1aW50MzJfdCBkYXRhX3R5cGUsIHVpbnQzMl90IGVudHJ5
X2xlbiwgdWludDMyX3QNCj4gZW50cnlfbnVtLCB1aW50MzJfdCBkb25lX251bSwgdWludDY0X3Qg
ZGF0YV9wdHIsIGludCByZXQpICIgaW9tbXVmZD0lZA0KPiBpZD0ldSBkYXRhX3R5cGU9JXUgZW50
cnlfbGVuPSV1IGVudHJ5X251bT0ldSBkb25lX251bT0ldQ0KPiBkYXRhX3B0cj0weCUiUFJJeDY0
IiAoJWQpIg0KPiA+ICBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmlvbW11KGludCBpb21tdWZkLCB1
aW50MzJfdCBkZXZfaWQsIHVpbnQzMl90DQo+IHR5cGUsIHVpbnQzMl90IGh3cHRfaWQsIHVpbnQz
Ml90IHZpb21tdV9pZCwgaW50IHJldCkgIiBpb21tdWZkPSVkIHR5cGU9JXUNCj4gZGV2X2lkPSV1
IGh3cHRfaWQ9JXUgdmlvbW11X2lkPSV1ICglZCkiDQo+ID4gIGlvbW11ZmRfYmFja2VuZF9hbGxv
Y192ZGV2KGludCBpb21tdWZkLCB1aW50MzJfdCBkZXZfaWQsIHVpbnQzMl90DQo+IHZpb21tdV9p
ZCwgdWludDY0X3QgdmlydF9pZCwgdWludDMyX3QgdmRldl9pZCwgaW50IHJldCkgIiBpb21tdWZk
PSVkDQo+IGRldl9pZD0ldSB2aW9tbXVfaWQ9JXUgdmlydF9pZD0weCUiUFJJeDY0IiB2ZGV2X2lk
PSV1ICglZCkiDQo+ID4gK2lvbW11ZmRfdmlvbW11X2FsbG9jX2V2ZW50cShpbnQgaW9tbXVmZCwg
dWludDMyX3QgdmlvbW11X2lkLA0KPiB1aW50MzJfdCB0eXBlLCB1aW50MzJfdCB2ZXZlbnRxX2lk
LCB1aW50MzJfdCB2ZXZlbnRxX2ZkLCBpbnQgcmV0KSAiDQo+IGlvbW11ZmQ9JWQgdmlvbW11X2lk
PSV1IHR5cGU9JXUgdmV2ZW50cV9pZD0ldSB2ZXZlbnRxX2ZkPSV1ICglZCkiDQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQu
aCBpbmRleA0KPiA+IGFhNzhiZjFlMWQuLjk3NzBmZjE0ODQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5j
bHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5o
DQo+ID4gQEAgLTU2LDYgKzU2LDEzIEBAIHR5cGVkZWYgc3RydWN0IElPTU1VRkRWZGV2IHsNCj4g
PiAgICAgIHVpbnQzMl90IHZpcnRfaWQ7ICAvKiB2aXJ0dWFsIGRldmljZSBJRCAqLyAgfSBJT01N
VUZEVmRldjsNCj4gPg0KPiA+ICsvKiBWaXJ0dWFsIGV2ZW50IHF1ZXVlIGludGVyZmFjZSBmb3Ig
YSB2SU9NTVUgKi8gdHlwZWRlZiBzdHJ1Y3QNCj4gPiArSU9NTVVGRFZldmVudHEgew0KPiA+ICsg
ICAgSU9NTVVGRFZpb21tdSAqdmlvbW11Ow0KPiA+ICsgICAgdWludDMyX3QgdmV2ZW50cV9pZDsN
Cj4gPiArICAgIHVpbnQzMl90IHZldmVudHFfZmQ7DQo+ID4gK30gSU9NTVVGRFZldmVudHE7DQo+
ID4gKw0KPiA+ICBib29sIGlvbW11ZmRfYmFja2VuZF9jb25uZWN0KElPTU1VRkRCYWNrZW5kICpi
ZSwgRXJyb3IgKiplcnJwKTsNCj4gdm9pZA0KPiA+IGlvbW11ZmRfYmFja2VuZF9kaXNjb25uZWN0
KElPTU1VRkRCYWNrZW5kICpiZSk7DQo+ID4NCj4gPiBAQCAtODYsNiArOTMsMTEgQEAgYm9vbA0K
PiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmRldihJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90
IGRldl9pZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB2
aW9tbXVfaWQsIHVpbnQ2NF90IHZpcnRfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgKm91dF92ZGV2X2lkLCBFcnJvciAqKmVycnApOw0KPiA+DQo+ID4g
K2Jvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX3ZldmVudHEoSU9NTVVGREJhY2tlbmQgKmJlLCB1
aW50MzJfdA0KPiB2aW9tbXVfaWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgdHlwZSwgdWludDMyX3QgZGVwdGgsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKm91dF92ZXZlbnRxX2lkLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpvdXRfdmV2ZW50cV9mZCwg
RXJyb3INCj4gPiArKiplcnJwKTsNCj4gPiArDQo+ID4gIGJvb2wgaW9tbXVmZF9iYWNrZW5kX3Nl
dF9kaXJ0eV90cmFja2luZyhJT01NVUZEQmFja2VuZCAqYmUsDQo+IHVpbnQzMl90IGh3cHRfaWQs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHN0YXJ0
LCBFcnJvciAqKmVycnApOw0KPiA+IGJvb2wgaW9tbXVmZF9iYWNrZW5kX2dldF9kaXJ0eV9iaXRt
YXAoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdA0KPiA+IGh3cHRfaWQsDQo+IEVyaWMNCg0K

