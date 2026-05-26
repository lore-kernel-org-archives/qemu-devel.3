Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C6FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRs4K-0001IO-HB; Tue, 26 May 2026 09:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRs4I-0001Hv-LX; Tue, 26 May 2026 09:43:38 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRs4G-0006Lc-Qe; Tue, 26 May 2026 09:43:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOJg7IhLXBhSxqloIpvNFDQehPmK8cgQSXZT+aOdEWuJanxvrDrF8YFRKNOqT56D5kOb9LyN/+lA6QorU0JnVRWrfUXRsbVzlkhfH4ODPlh1b0N1FKkR3w6cIrlAJWmDgJh4bmYADkrbiQBLhvF2dkt3vR/X9ZCJLZNRPP2W9Nu3KmtPXvEUN7xsal5VBr0sNPzHk8tw2RdCge2Ql2BQEbgSZHJtgU37Ol+/0/LvGT930d6Sz2Ph1MFE4//q377KFbZmfci7BtIawgnMnQSH1uceziOYh9r9EFDoRaG+nMEmN3xB2wDDrKQh5jbtDjhx9S3Rf3L2Xxuucfp+7SQQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aW+bxCrAaKslGie7MlgnPA2/INiM0fXZw6PvLe9Pt8=;
 b=VR4K9O2qDEirtT8Q32na5TddKTBqLeDjrSc5srEH3w3wd6KFpxT1V3jj8niwaEC9P79l5aguuZ/vGtGupeu1tZIemPqPkA5dwyKaNOffbtQD9unNLFIr8ewCudVxqyVR1CFRPfc348Jxztd9s3Rvk3sykNjBOVEZqVSa5+AoAPsDPQrYO9/p6fPeghzFJdMAx1FVZfhoa48WofZVwibbelFvxbNBiqJSTLwsCDzFZTOQAae9u6ZqjxcecDbt14a2sE1Qj8a4T5LFiOd+31WI5NzIMw5A6MdTL7/uI3TzViIIyZVFD5rnD0V5Gr5YFGh+l7mV2Go+jELjXU/afSMvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aW+bxCrAaKslGie7MlgnPA2/INiM0fXZw6PvLe9Pt8=;
 b=uluI39LE9Seeu64IllGigSda+qmHMvokiLiBvYoJVuE6hS4syYMtPMNffFblrJsPqq/djJkRjdokJBxGFtpOzhFRSU9KdQaEr0YBY0TLJ2KzQtoJqFZvV84+0bwJAjQXBsYdrLLoWyflQiqt925zx43/IESugL4g9+GJVt1fc+e/NsT1v/c3a4LbWlPPM5h9+X6Um/CUG3brgKwZ+JJ/sWEF5FUl9ulWG+KKEzADWskH3osZWChtwuYeXZzkhfBoWHg2nKIymYNgs16MXn9Ek/bTB0oeap9FsRb+MH+oliTB8PdXz72magBsR7oTF6puVGiMlG8CIqUi+yZd6LxHAQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 13:43:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 13:43:27 +0000
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
Subject: RE: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHc53vPgzHMdzCVJUyI0UoOS0aBX7YW4H8AgAAoG0CAAsctYIAGeJ4AgAAODIA=
Date: Tue, 26 May 2026 13:43:27 +0000
Message-ID: <CH3PR12MB75488D3B2AFE0EE773840709AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-18-skolothumtho@nvidia.com>
 <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
 <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548D57C770446ABED0EDB68AB0F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <589a36eb-2d60-4f9b-a385-9e47565eeb85@redhat.com>
In-Reply-To: <589a36eb-2d60-4f9b-a385-9e47565eeb85@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PPF73BED5E32:EE_
x-ms-office365-filtering-correlation-id: 2ce19630-9696-401b-0a9b-08debb2cc404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003|3023799007|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: 6MSnZoQNZ2okopvHF5doZ//Mt0pf5riDEfuGapDiCmi/c4uxWRdSbEGF2CFv5STkyPdglIZ1BVMoC8s+Yw/otvbDl87UJxcMxL2QUTvEoMV6PZxDZz27KKx7D2iw4reFrXLbKOn09lNbolL3id+kKQyPWWWzwXimrmIhUxMUlgJlzZL8Simw+ux+RAD+nYxlEIJZA2frU+BX0gFHID8U84kfrHAZnQZXC529XfhTdU0umom3u5P6Tq3dXhlBaNlARUsiZU8zj6BsHp8NThK9BltxZNpkMiOpSPBL8/5ppCGn7pZ35JqDy/NU+lBsQkH2BoMGhRZ/CsPTCoo0Ry2wWc+24ThE2xAZTXdXbjh5F22Jdit6vrNXloWFqxPLQWkP3ED1VgoG87ckozFmWMRxJ0uNOAUsomLG1oTm4YRYIxhv/qhUFZToix/MhWTx/NYfMCW/ym9vFvAFo/hpcXO+i1rF2v7PoajSAPQhUqFFR5SaVDgA92qXCDvL8M4r8Q31CgKIq+CZ8gK4O3Q+swzeKDro4ObKJH+g96nYEfDnQrThL7zodOglncOuyarUIKwnxqcmhk/mQqaCWmv54K0ezcG/UDpaRmTTbqx/ntxt4e/jmuwY/ASI1jdJP9UsSEwamgUqhyf0LN8RyW508OqefbvZxvO5k6MQRQNoUxnq9Ld0ovgj7YG/5LhRk/7SpVavhsmHaaCS7viQXjGz6Wz8MUwyy0em2NDigEwj/oR+D6zjCNr9GWiqBgaWUY35Ly0l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVhV29TNk9CYi9EMFAvdEd4cWx5ck9tV3NucUtZUVhLbk9SZGRqZllrQklE?=
 =?utf-8?B?RnpyTmdKNGVkUlBQRnk3VWMzbzd1dlRQNVBvY3RHb3UvczQ1aGZPa0lQUndz?=
 =?utf-8?B?RHIySkdGc0YwY0FSTUd1cnpjclNDUDEvVmNZUkhPWHFnVXBpbms3cCtOKzFD?=
 =?utf-8?B?Q3F1YjZ3eUxuc2V0WU9zYnZCVXNSZFVpYSt5ZnJ1MWxBYTR6UXFoMHVHR2dW?=
 =?utf-8?B?NThDNHIwcDdVVkNMM2EyTzhTTlR5ZUdrUnRsRk1VeCtVRURjR2EyTjcyNFds?=
 =?utf-8?B?UEkzVnBQdCtZMXNvdFRXa1RXWVFFRktDRmRwTm1wS0NicVgyRTlFSjBPUU9H?=
 =?utf-8?B?WnpyMHNuK0dlcm85bWxkYzZIOHBDclljRk44N2FHSEZtTjE4VWp1ZmI3ZGVS?=
 =?utf-8?B?d3ZjS3BMNUs2R2VlQjlYZlIwZENPV0xPK0pOQkZSV3lRNkxjV0ZBNG5mWDhX?=
 =?utf-8?B?VEVxeEltTFhKRmV5QlRETzlsZWNOQTNDazJQQWQ5Q2lwQStFTXBqQWdKc1Rv?=
 =?utf-8?B?T3NHWkVJZ1BOd0wxYmpiend1a09JRVB0bjVTMlVTUEJXNEtDR0hNM3g2dXU4?=
 =?utf-8?B?blBTekw1ZnNWYVVScExabm9KU1U5ZmdrYWNwUUxMZ00ydUlycTFHUCtjUll2?=
 =?utf-8?B?bFozVUwvc0Y3Vk9LVlYrSXVSYXE5VkVON0NWNE92bTNIV3Yxd3BNM1dRYmI5?=
 =?utf-8?B?dDJEYXQ1OUhQWm5mYlNQNG9DaSt6WmpEbFZ1YUphMnNKMzVGclFMS2NDU3Jz?=
 =?utf-8?B?MCtkRUtOZkFqSy81OXhJNnloRjhHRWNLMXZWWnJLNngzNjgxdkRKK3V5RS9C?=
 =?utf-8?B?bDZleGVGVW9JUyt0YnpMWFFKSXU4aHFVdEppS3FXQXhickE5bldTYitma0p2?=
 =?utf-8?B?MnA0V1NiRGdoU25udlU2WkN1Z1d4MzR3VmdJa1h3Rkl5UC9US3dVYU5jMFBp?=
 =?utf-8?B?Mlkya0xCelJsamllSUF2M1VvbzB6Q0VBblgrSFFkRTNVSzNnL3pIQmtWTGhY?=
 =?utf-8?B?N1ZOdm1WaFR4eXF2c0xlVlg3R1p3b0I4akJMYU1tVFlyMWtlQ2FSVjBsK3Jk?=
 =?utf-8?B?NVJRWC9tQ0swaWxJN2V6QjE0V25KYm5OQVdUbGNSY1IxSGpaaWY0QjY0MWdp?=
 =?utf-8?B?djVIbXZFajY4QWk4TW4xZFFxeGZRK295VXliYTc5aCtnRGhIbDI1YThINlpo?=
 =?utf-8?B?ckc1LzNuSTdqZVk4RGVRUXpRYWNRMTc5dVBqZ1hyWnUxUUJQcFcyM3hnZTJW?=
 =?utf-8?B?aVQreU9uNFpUQmdFZlEyV3RnalBQQnlsb2RLbEtIYUQzaVFQZjl6dWVNRjVN?=
 =?utf-8?B?RVZtSGRySXVVdVhaUG1aMzlmbDU0VFBYMUhoZXBSd3BJVnBQRHU0WWZqNnlm?=
 =?utf-8?B?czFyOC9MWDVxWmZFMFY3eFpydi92MC90ZnZLMUgzR0prNXNEMFlmSWdlR21m?=
 =?utf-8?B?anM5VGxhaG13allNc01DTnY4ajhkS3YrUGlQVExrbml3RGt3akhUUjVTM0My?=
 =?utf-8?B?eDZmeFBtTW1KNERxVGNpNnhjamRrb2kwcmthVnZ1ZVluK1kzM2c4eWdhcm9l?=
 =?utf-8?B?M2J3elE0V0JvQnJDb284aW5aT2pMZDZJYWVIN2JZUStoZEh3cXB3aWwvd1k3?=
 =?utf-8?B?bllLdWhYc3c2VzBzTUozYzdkQzN2eU1KU0g5YTE2d0RyVVB3WnBrME02eDJp?=
 =?utf-8?B?dmRDenZHMi9jVWVOa0ZKOHhmWjcrcUtiSllGL2NVamVzODlGQjlxQlFlNmxz?=
 =?utf-8?B?NENlalEzRjZOb2w4OEc1U3EzczJGVjljNW5xTXNXRDc2ejJ3dkEzVXdZVXB4?=
 =?utf-8?B?b1FkdW5wSlZicGxremZZNkRPZDVlWEgyMzlPYmhscVJvV3RQL1oxbFZleTZo?=
 =?utf-8?B?MGp1VjNZWVhJaUZuV1Z6K1NSTzVWSDFtVVBYYnpCNGRLS0ZGSHE1Qkp3Nnd1?=
 =?utf-8?B?bEl3OEpKNkI2eWpYZ2IvTldkQUh5aldIZ2haN2VJbW9XeVh3Z2o1Y2Q2RjhE?=
 =?utf-8?B?ajdLQ3Nwb1dzWGE1a3l3RndXWlNBY2dIcG5JeUxxb2hRa1pSZzh6OTYwOXpz?=
 =?utf-8?B?QmZrbGRPMEkyeXA3TFdKUndkRHRmQXMwSWd3dHFtaWZuTzlta1BMT25qWVlV?=
 =?utf-8?B?bzJ4d2V0ZDcvTDBTaUhCc2VnZ3hqcFhBcC9pOEM1RGpSTFB4N3pjeHhUTDhI?=
 =?utf-8?B?ZWx2T2ZDQXRMNUZWZ29WWEJzVEIvRldLeVpteElCRGRSQ0MvblYzRVhQV3R5?=
 =?utf-8?B?bGF2MDhoQmJBM1pwN1pVd2JCeDF0RDBwOVI1SFJvblVVOUlWM0dLc0pRcjQr?=
 =?utf-8?B?a3ZCZG04bWVqVnlHamorTjlsTitCZzdDMWVROWd4bklpSytCd0F6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce19630-9696-401b-0a9b-08debb2cc404
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 13:43:27.4599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGGSL3RA8DJ43EkxLP7V/fUy8aT75ClpAeLk89WuH4ZFnKTsqZOUNqWnsn6RhbEojLKl9kopY536Jtyh47d3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAxMzozMg0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNy8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBtbWFwIFZJTlRGIFBhZ2UwDQo+IGZvciBDTURRVg0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNS8yMi8yNiAxMjowMSBQTSwgU2hhbWVlciBL
b2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPj4+IE9uIDUvMTkvMjYgMTI6MzYgUE0sIFNoYW1lZXIg
S29sb3RodW0gd3JvdGU6DQo+ID4+PiBBY3R1YWxseSBpcyB0aGUgd2hvbGUgaG9zdCBwYXNzdGhy
b3VnaCBwcmluY2lwbGUgaXMgbm90IHJlYWxseSBleHBsYWluZWQNCj4gPj4+IGFueXdoZXJlLiBB
dCBsZWFzdCB0aGF0J3MgbXkgZmVlbGluZy4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgc3Vt
bWFyeQ0KPiA+Pj4gZm9yIGl0LCBpbiB0aGUgY292ZXJsZXR0ZXIgYW5kIGluIGluZGl2aWR1YWwg
cGF0Y2guIE9yIG1heWJlIHdlIGNhbiBsaW5rDQo+ID4+PiB0byBhbm90aGVyIGRvYy4gUmVhZGlu
ZyB0aGUga2VybmVsIHVhcGkgZG9lcyBub3QgcmVhbGx5IHByb3ZpZGUgdGhlIGZ1bGwNCj4gPj4+
IHBpY3R1cmUsIGF0IGxlYXN0IHRoYXQncyBteSBvd24gZmVlbGluZy4NCj4gPj4gRmFpciBwb2lu
dC4gQSBzdW1tYXJ5IG9mIG9wZXJhdGlvbiBpcyB1c2VmdWwuIEkgYW0gdGhpbmtpbmcgb2YgYWRk
aW5nDQo+ID4+IGl0IGF0IHRoZSB0b3Agb2YgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmM6DQo+ID4+
DQo+ID4+IC8qDQo+ID4+ICAgICogVGVncmEyNDEgQ01EUVYgLSBvdmVydmlldw0KPiA+PiAgICAq
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAgICAqLi4uDQo+
ID4+ICAgICovDQo+ID4+DQo+ID4+IEkgd2lsbCBwb3B1bGF0ZSB0aGUgZGV0YWlscyBhbmQgc2hh
cmUgaXQgZm9yIHJldmlldyBiZWZvcmUgdjYuDQo+ID4gUGxlYXNlIGZpbmQgYmVsb3cuIEhvcGVm
dWxseSwgSSBoYXZlIGNhcHR1cmVkIGFsbCB0aGUgaW1wb3J0YW50IGRldGFpbHMuDQo+ID4gUGxl
YXNlIHRha2UgYSBsb29rIGFuZCBsZXQgbWUga25vdy4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBT
aGFtZWVyDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9o
dy9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IGViZjEyZDA1OTcuLjVhMTAzZjM3Yjgg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9h
cm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC03LDYgKzcsODQgQEANCj4gPiAgICogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gPiAgICovDQo+ID4NCj4gPiAr
LyoNCj4gPiArICogVGVncmEyNDEgQ01EUVYgLSBvdmVydmlldw0KPiA+ICsgKiA9PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4gKyAqDQo+ID4gKyAqIE5WSURJQSBUZWdyYTI0MSBleHRlbmRz
IFNNTVV2MyB3aXRoIGEgQ29tbWFuZCBRdWV1ZQ0KPiBWaXJ0dWFsaXphdGlvbiAoQ01EUS1WKQ0K
PiA+ICsgKiBibG9jay4gSXQgbGV0cyBhIGd1ZXN0IGlzc3VlIFNNTVUgaW52YWxpZGF0aW9uIGNv
bW1hbmRzIGRpcmVjdGx5IHRvDQo+ID4gKyAqIGRlZGljYXRlZCBoYXJkd2FyZSBxdWV1ZXMgKHZD
TURRcykgd2l0aG91dCB0cmFwcGluZyBpbnRvIHRoZQ0KPiBoeXBlcnZpc29yIG9uDQo+ID4gKyAq
IHRoZSBmYXN0IHBhdGguIHZDTURRcyBhcmUgZ3JvdXBlZCBpbnRvIFZpcnR1YWwgSW50ZXJmYWNl
cyAoVklOVEZzKTsgdGhlDQo+ID4gKyAqIGhvc3Qga2VybmVsIGFsbG9jYXRlcyBvbmUgVklOVEYg
cGVyIGVtdWxhdGVkIFNNTVV2MyBpbnN0YW5jZSB2aWENCj4gaW9tbXVmZC4NCj4gPiArICogUUVN
VSBlbXVsYXRlcyB0aGUgQ01EUVYgTU1JTyByZWdpb24gYW5kIGRyaXZlcyB0aGUgaG9zdCBrZXJu
ZWwNCj4gY2FsbHMNCj4gPiArICogKFZJT01NVV9BTExPQywgSFdfUVVFVUVfQUxMT0MsIG1tYXAp
OyB0aGUgYWN0dWFsIGNvbW1hbmQNCj4gcHJvY2Vzc2luZyBoYXBwZW5zDQo+ID4gKyAqIG9uIHJl
YWwgaGFyZHdhcmUuDQo+ID4gKyAqDQo+ID4gKyAqIE1NSU8gbGF5b3V0ICg2NEtCIHBhZ2VzLCB0
b3RhbCBURUdSQTI0MV9DTURRVl9JT19MRU4pDQo+ID4gKyAqIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKyAqIFRoZSBkaXJlY3QgdkNN
RFEgYXBlcnR1cmVzICgweDEwMDAwLzB4MjAwMDApIGFyZSBIVyBhbGlhc2VzIG9mIHRoZQ0KPiBW
SU5URg0KPiA+ICsgKiBhcGVydHVyZXMgKDB4MzAwMDAvMHg0MDAwMCk7IHRoZXkgZXhwb3NlIHRo
ZSBzYW1lIHBlci12Q01EUQ0KPiByZWdpc3RlciBzbG90cw0KPiA+ICsgKiB1bmRlciBkaWZmZXJl
bnQgYWRkcmVzc2luZy4NCj4gPiArICoNCj4gPiArICogICAweDAwMDAwICBDTURRViBDb25maWcg
cGFnZTogUUVNVS10cmFwcGVkLg0KPiA+ICsgKiAgIDB4MTAwMDAgIERpcmVjdCB2Q01EUSBQYWdl
IDAgKGNvbnRyb2wvc3RhdHVzKTogUUVNVS10cmFwcGVkIGFuZA0KPiByb3V0ZWQNCj4gPiArICog
ICAgICAgICAgICB2aWEgdmludGZfcHRyKCkgdG8gZWl0aGVyIHRoZSBtbWFwJ2QgVklOVEYgcGFn
ZSAoYWxsb2NhdGVkDQo+ID4gKyAqICAgICAgICAgICAgc2xvdCkgb3IgYSBwZXItdkNNRFEgcmVn
aXN0ZXIgY2FjaGUgKHVuYWxsb2NhdGVkIHNsb3QpLg0KPiA+ICsgKiAgIDB4MjAwMDAgIERpcmVj
dCB2Q01EUSBQYWdlIDEgKEJBU0UgLyBEUkFNIGFkZHJlc3Nlcyk6IFFFTVUtDQo+IHRyYXBwZWQu
DQo+ID4gKyAqICAgMHgzMDAwMCAgVklOVEYgUGFnZSAwIChwZXItVklOVEYgY29udHJvbC9zdGF0
dXMpOiBtbWFwJ2QgZnJvbSB0aGUNCj4gaG9zdA0KPiA+ICsgKiAgICAgICAgICAgIHZpYSBpb21t
dWZkIGFuZCBpbnN0YWxsZWQgaW50byBndWVzdCBNTUlPIGFzIGEgUkFNLWRldmljZQ0KPiA+ICsg
KiAgICAgICAgICAgIHN1YnJlZ2lvbiBhZnRlciB0aGUgZmlyc3QgSFdfUVVFVUVfQUxMT0M7IHN1
YnNlcXVlbnQgYWNjZXNzZXMNCj4gPiArICogICAgICAgICAgICBieXBhc3MgUUVNVS4NCj4gPiAr
ICogICAweDQwMDAwICBWSU5URiBQYWdlIDEgKHBlci1WSU5URiBCQVNFKTogUUVNVS10cmFwcGVk
Lg0KPiA+ICsgKg0KPiA+ICsgKiBUaGUgZGlyZWN0IHZDTURRIGFwZXJ0dXJlIHN0YXlzIHRyYXBw
ZWQgKHJhdGhlciB0aGFuIGFsaWFzZWQgdG8gdGhlDQo+IFZJTlRGDQo+IA0KPiBkaXJlY3QgdkNN
RFEgYXBlcnR1cmUgcGFnZSAwIHN0YXlzIHRyYXBwZWQgYXMgb3Bwb3NlZCB0byB0aGUgVklJTlRG
IHBhZ2UwDQoNCk9rLg0KDQo+IA0KPiA+ICsgKiBtbWFwKSB0byBwcmVzZXJ2ZSB0aGUgc3BlYydz
IFIvVyByZWdpc3RlciBzZW1hbnRpY3MgZm9yIHVuYWxsb2NhdGVkDQo+ID4gKyAqIHZDTURRczog
dGhlIGRpcmVjdCBhcGVydHVyZSBhbGxvd3MgcHJvZ3JhbW1pbmcgYmVmb3JlIFZJTlRGDQo+IGFs
bG9jYXRpb24sDQo+ID4gKyAqIHdoaWxlIGFsaWFzaW5nIHdvdWxkIHJvdXRlIHRocm91Z2ggdGhl
IFZJTlRGIGRyb3AgcGF0aCBpbnN0ZWFkLg0KPiBzZWUgbGFzdCBkaXNjdXNzaW9uDQoNClJlcGxp
ZWQgdGhlcmUuDQoNCj4gPiArICoNCj4gPiArICogTGlmZWN5Y2xlIChkcml2ZW4gYnkgZ3Vlc3Qg
ZXZlbnRzKQ0KPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
KyAqIDEuIEZpcnN0IHZmaW8tcGNpIGRldmljZSBhdHRhY2ggKC5zZXRfaW9tbXVfZGV2aWNlKSB0
cmlnZ2VyczoNCj4gPiArICogICAgLSB0ZWdyYTI0MV9jbWRxdl9wcm9iZSgpOiBJT01NVV9HRVRf
SFdfSU5GTyBjb25maXJtcyBob3N0DQo+IENNRFFWIHN1cHBvcnQuDQo+ID4gKyAqICAgIC0gSU9N
TVVfVklPTU1VX0FMTE9DOiB0aGUga2VybmVsIGFsbG9jYXRlcyBhIFZJTlRGIGZvciB0aGlzIFZN
LA0KPiA+ICsgKiAgICAgIGNvbmZpZ3VyZXMgdGhlIFZNJ3MgVk1JRCAoZnJvbSBpdHMgc3RhZ2Ut
MiBIV1BUKSBpbiBWSU5URl9DT05GSUcsDQo+ID4gKyAqICAgICAgZm9yY2VzIEhZUF9PV049MCwg
YW5kIHJldHVybnMgdGhlIG1tYXAgb2Zmc2V0L2xlbmd0aCBmb3IgVklOVEYNCj4gUGFnZSAwLg0K
PiB3aGF0IGFib3V0IHRoZSB2L3AgU0lEIG1hcHBpbmcuIEhvdyBkb2VzIHRoZSBrZXJuZWwga25v
dyB3aGljaCBTSURzIGFyZQ0KPiBzdXBwb3NlZCB0byB3cml0ZSBpbnRvIHRoYXQgVklOVEY/IHdo
ZXJlIGRvIHdlIHBhc3MgdGhpcyBpbmZvPw0KDQpUaGF0IGhhcHBlbnMgbGF0ZXIsIGRyaXZlbiBi
eSB0aGUgZ3Vlc3QgU01NVSBkcml2ZXIsIG5vdCBhdCB2ZmlvLXBjaQ0KZGV2aWNlIGF0dGFjaC4N
Cg0KRmxvdzoNCiAgLSBHdWVzdCBTTU1VIGRyaXZlciBjb25maWd1cmVzIHRoZSBTdHJlYW0gVGFi
bGUgRW50cnkgKFNURSkgZm9yIHRoZQ0KICBkZXZpY2UgYW5kIGlzc3VlcyBDTURfQ0ZHSV9TVEUg
b24gdGhlIFNNTVUgY29tbWFuZCBxdWV1ZS4NCiAgLSBRRU1VIGNhbGxzIHNtbXV2M19hY2NlbF9p
bnN0YWxsX3N0ZSgpLCB3aGljaCBpbiB0dXJuIGNhbGxzDQogIGlvbW11ZmRfYmFja2VuZF9hbGxv
Y192ZGV2KCkgLT4gSU9NTVVfVkRFVklDRV9BTExPQyBpb2N0bC4NCiAgLSBpb21tdWZkIGNvcmUg
KGlvbW11ZmRfdmRldmljZV9hbGxvY19pb2N0bCkgZGlzcGF0Y2hlcw0KICB0byB0aGUgVGVncmEg
Q01EUVYgZHJpdmVyIHZpYSB2aW9tbXUtPm9wcy0+dmRldmljZV9pbml0LCB3aGljaCBpcw0KICB0
ZWdyYTI0MV92aW50Zl9pbml0X3ZzaWQoKS4NCiAgLSBUaGF0IHdyaXRlcyB0aGUgaG9zdCBzdHJl
YW0gaWQgaW50byBTSURfUkVQTEFDRSBhbmQgdGhlIGd1ZXN0DQogIHZpcnR1YWwgU0lEIGludG8g
U0lEX01BVENILg0KICANCkkgd2lsbCBzdW1tYXJpc2UgYW5kIGluY2x1ZGUgdGhpcyBpbiB0aGUg
b3ZlcnZpZXcuDQoNClRoYW5rcywNClNoYW1lZXINCg==

