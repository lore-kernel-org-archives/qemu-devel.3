Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE5E7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 02:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLYyL-00063L-DG; Wed, 11 Dec 2024 21:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLYyI-00062s-Ur
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 21:30:34 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLYyG-0006Yj-4N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 21:30:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGFf53FAgk0NUiQogSiWUrhFUzjxqzWHJGa0NwyTwdY1AKRoYdrwzrCnb7fj4sCpsIv10jUYJ3ELePECIs5SJR3v7NtGDMTYlo/MUgtUksP+CG9d2Sx+QANBo4rV1VTP608ijXSjV1KFvFw8oaHueoxY1OzCGGMCBjGapwYzxqgEIsncEfHmnWHTmO/+hBLjPCy23+vSWYGB1E5EbvNWS8TBZ3SfCAOV4ZCyPaVzAQ+JPi1Dmmt7SZXgkFWaV32xlftfIsJ+TqumWi+AUpuxyXcEmWymZqUvBJZ2m8AWqKQsMvclc9OSi5Vb8qHrO3EPlRRK6sG48BuSJKDo61oQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N7YrEuneekPaGfXUjUqp3gDoCcAqvmWyWKDpZj0kDw=;
 b=TG7BXYooppk4KFstMigwvU2drbsamV3mVNS6AK67rgWWVvQOy230O6SscC7kj/CRUN/XAWMLlw1W1top2ft3G4Xfa4PWE9/yzWt9nFRfA2yC4Webcix2gXAe3fUIYJ+9Od7KW7Sq/7rqT/g9aYcpSgZX77ViQrym/UqHkm9OE+Mz/zvdwEH+vQL42G+x8lVMk6AReZ5di9eJeBr3N7PymM6pXu66EYV3jLqk4gkMpIES+Lt79GdXttkvuf9yKiy/99UypzywPDdb1zDFGw2p44V8/PbTOmZOYcHQaCJ4pt+H+MGv4AZhKBOHgP6aEnl1X5s/f0tumL3RmkMYAZX30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N7YrEuneekPaGfXUjUqp3gDoCcAqvmWyWKDpZj0kDw=;
 b=rMHowjrQbJ2+yklYo/1O9YDPscibVaOtunCkGAr2wP/zv+UClKs7wRqYkG9Mm9Ny1cjjVxoNoCUfPmXQ2z/VKqyFPMChMAMAkel1r1lSBbWkoR8RQM11ybqlCikeKX/lv4Dxqq/vpgaD48cEhPAfucEX3Ny+Y1lE+3+n52pJDnJ0cjfWzlRNZJXC3CwDnkIMjXODl1GXi+NFyrBkRKKJyvbPrKGjl6gz4WbbT/3kxpIWUW765Zp7p7ibSWgzN/sV61n9N2+zduE8QAmWT8W5I39Qb5GTCHOSCUrfIrUCBudunlKAw3SuZZkTjJOKknpzWlfhe6vF2KwHoPrNd1okXw==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEYPR06MB5514.apcprd06.prod.outlook.com (2603:1096:101:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Thu, 12 Dec
 2024 02:30:20 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:30:20 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Angus
 Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH v2] hw/virtio: Fix check available index on virtio loading
Thread-Topic: [PATCH v2] hw/virtio: Fix check available index on virtio loading
Thread-Index: AQHbS8j+0VtDyUqQlk6TIf56vZEBXLLg/YUAgADld+A=
Date: Thu, 12 Dec 2024 02:30:19 +0000
Message-ID: <PUZPR06MB47130AC6F169C17D9B833B74A23F2@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20241211123349.904-1-Wafer@jaguarmicro.com>
 <CAJaqyWcU8fN1ewYyZ1qDSdxWmr7SVbw8s+VKzO4_b63F8MS=Rg@mail.gmail.com>
In-Reply-To: <CAJaqyWcU8fN1ewYyZ1qDSdxWmr7SVbw8s+VKzO4_b63F8MS=Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|SEYPR06MB5514:EE_
x-ms-office365-filtering-correlation-id: 2fc23272-3c2b-4952-4185-08dd1a54ec4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UHd2dUZ0eXBqemdSVTlXUlVKMzlFSnZoL0phTTBCaENaakZQUTRKVVZsNHFX?=
 =?utf-8?B?dUhQci9IaEZEcVRSUmo2WHBtOW8zOHJvWkxrYVA2QUxsZDBBMnlOSm9ZbGd0?=
 =?utf-8?B?L2cvMG1TTXRzb2xsUFdrUGwralVhYTRRd24xdWdmZ0REdk1zTExCVVNmN2dQ?=
 =?utf-8?B?UkJjNXlqYnlOZmwwcUZyR1pvZUF3OHJMR1RhQys4dUVoN0NSWmF5OVg3Ni9q?=
 =?utf-8?B?R2IxNWlzenZUNFBRbDNhUnFTNWkvYUZpc3dYS09IM21JTnZJV0V6Mzl4Z1VG?=
 =?utf-8?B?akt6VmI1Q2g1bjUrNW1pa3FzTEJqaHFGS3hnN1VjVHhjcFYzWExxalo3ZTJF?=
 =?utf-8?B?ZHdDOGQ1d1NJS1VOUWZFUWtnNWlCM2kvVGpoZTFiZUQ0RFpMNVJkZk9QVUxq?=
 =?utf-8?B?c0NObzQ2L1FiMzNaZ2RRM0lnZEpRcnZ2Zm43U3V5WDlkcGpqNHJoSC9uQmxT?=
 =?utf-8?B?ck9qTlAwVWJ4WDF2YU1JQ2ZMcTZVRTlHS2xiQTZuTnd3eEI0UzhOdEVuc0ph?=
 =?utf-8?B?RXJvQ2NoRlh5dTl5b1RJZTlYV1JFTHZrcmVjSmVOdFBGd2lUQUJCY3RyUEVK?=
 =?utf-8?B?TzVMeFoxcU5KQU5MV2syc0hwUFBlS1JsbGxiZGQ1S3haYzAvV1J0R1NraEpX?=
 =?utf-8?B?MFhnQ1JmSzVudDl5bUNiUjRVdytHN3NFbGxnR1lOalhyeTJlQitDM04yblFv?=
 =?utf-8?B?ZXkvUjJLZTNqQkg2YzE0Q1l4OEwvdCtld3Y4eURCWXI0UDRPUkJmZ3kzQS9y?=
 =?utf-8?B?dERpUjU5Zlpmb1VCd0dIUUlBYm9Ha2RQQ2d0RUlWZXVYR2Q4bVpGdE4xMGl4?=
 =?utf-8?B?c3dmY0tIaDE3NGI5SjhGMlpuOFhpNnQ3NGlsVXhUZyttbXZ3elZHazdDSld4?=
 =?utf-8?B?czdOVmZrT0IxSzBUWXFsMTh2bDJhaUwrMkxsT0JCZ0t1MWJyS3diUXRRV1hW?=
 =?utf-8?B?S1FSVEFMb0MyamNLOFdjWXZmSnZpcjB6bVZ3K1RndGMreEJ4L0Zwd21NWCtQ?=
 =?utf-8?B?Qml6R0xxbmd2cEJsVU01a05uZnRUclIvcVpDRTlkdlJ2YXdoNnZEdStjekhI?=
 =?utf-8?B?YW56MTdTUWdRbGkyTWh6bnBQRTZBbUh0dUFudkc2YXhLRWJkVFJNUitMcFl5?=
 =?utf-8?B?R0czdnZVcTR3MzYwa1g0VFg3cFkrVmZ1d0d4YWRoRjd4SU9ndXNaaDQ3cXpH?=
 =?utf-8?B?bytuUGY4MUN1WXJQaVdaQTNyd1UweVRFL1NVekZybkZyQXFOYlljeWEya0pJ?=
 =?utf-8?B?dCtDTnA5dzhXcDQrMXVZVHhhaHZRTC9tNGFYem80QjE3c3RBR01lMWRMekY5?=
 =?utf-8?B?WnhjcHNvZmRpendYVVBhWlVKQkNveEtuTC8xQkhrZm92WXFRZUxoQm5zNWl0?=
 =?utf-8?B?N1E3SGhCSDZVOGRTdFkyOUxNRVYycUxRYjdyK3Myc2xMYTV6aTdwMTljTWVs?=
 =?utf-8?B?SmFiQUx2dXE2RmZTbmlmZnNNaWw4bVBlVGxOSTlZNVZrM2x4bmY3NldJVG1h?=
 =?utf-8?B?WnpRV0VxcU11bnpkZDZkRVRvQ3kxbTAyK3hZS1duZFNZM2IwNHZ5MmxQdllI?=
 =?utf-8?B?S2Q0UlNaWCtrSmZtdHlEKzFlbU5oR0hCOTcyZjRhNDh2UmFLdVhEY3YyMTJD?=
 =?utf-8?B?NXZPTkMzVU1MZjVWRERGa3piODllM3F3Z0RHNGZSTXJ2d3lUbWZSUURnSi9H?=
 =?utf-8?B?c1p3cm9nV2xESjhjR3pQS0pHbTdYazFlYTNtczZzSmVLcUVFSEo3M21TMW0y?=
 =?utf-8?B?ZXJwcU9yR29pLzFDMXNCSjJBdlRhSklVSndiRnJSWGJUQ2pzUUZ0SU5OVTVQ?=
 =?utf-8?B?MlE3alVlTWIvelZDVnVSNkRCREJsaGs4UVYxR1pWNThpdE9vazNsWTJzaFMv?=
 =?utf-8?B?NFcxUTFPVFcvb3IwSGpyQWZVaWt2KzFrazRDb1RYMEpIOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFNxT2dXQlVYSU5kODRCRnVGVm93bUdzODV4TGh4Yk1ySUpLQ1ZyU0lLWEdn?=
 =?utf-8?B?VkJsUU1oSk54eVFqOEpGbk0rTzFZLzlmdWowS1V0czNqU1gxeFdjUjNmWThQ?=
 =?utf-8?B?ZHg4eHdhNCt4b3BSNHJuUzJuM0tmY1JpVjIvQWpVMG1tclpMekcvWHk2YTVQ?=
 =?utf-8?B?TDhnb1BXdnp1NFNBZU90MzdvYWFGZC9nQVd6dk1Wei9VbGFCM28wNU1JKzZO?=
 =?utf-8?B?TzVnNVBsTzZyeXYrUGdYams4dVZmTUk1UkZGUFZ3LytrMGpDSit0bWQweDUr?=
 =?utf-8?B?VmdPTVN6ZFdac3E2UHVKSHNTSjMxZVRVS21uMVdzU3d6STBzNDA2V1kvQTFw?=
 =?utf-8?B?NkJSbmdTa082RmFtcDdCMWJ3c0dEekt5UkJ1NDlvWGVCMlJiMmFOYnAvaE9H?=
 =?utf-8?B?U2RqNkM3ZktoN24xSm4vd1FqZFdHWUdsa0JZMW9HZFQrT01ScDJ3Y3ZhaVVv?=
 =?utf-8?B?OEZjUnkwMTdpWllTMFdndzVvRjNncVRybDB0WG9KNGhiZzJ3N2ptSU9jOUwy?=
 =?utf-8?B?MXJuZWpLVmN0Nlg5MldPUXVNcGh6T0NOeDdFa05nZXBqcXhmZm5LdTVaMnpQ?=
 =?utf-8?B?Qk8wblJDa1VEY1dIcUE5ZHdaRU5hM0dMNW9MSEJPS28yVnZmRzFnQ3h0aFl1?=
 =?utf-8?B?ZzJEY0lNNkl5K05qSDZWYm1SWkc5SXgzYWg4aWRlSWJqaG5FS2x6bkp5OHB0?=
 =?utf-8?B?c1k1OVo5eHQzV2NSRVhZNUNVNktpV1AvakFMRGw2T2ZHUDJBMFdOUlFPV3A3?=
 =?utf-8?B?WDYyY2U4NDdheHZpWjlyWFUxMkVaK045NDViaVcycVB0U2hMdFpCOU4yOGtL?=
 =?utf-8?B?MFVFaElVZ2twS1gvUmlPcjFrRFBXdXZpTlpVU1lwQ2t6bUgyb3plSXErRmUz?=
 =?utf-8?B?bmMrNzhrK1VYWEZJREkwZVliUlhBZWtQL3NhbGNNUHgzNGx4czhuR1hRMzA3?=
 =?utf-8?B?RWk1YjdZMVdJdWI5RmJ1S29qVVBQbWlyM0x5djRhaFZPODRralVIejZQVFhO?=
 =?utf-8?B?amNWMy9HVENHK0JsZzdmR25hbHJpK2NZcFMvdXovZkl1dk45VVhrZXZZdDdm?=
 =?utf-8?B?di9RK0JicHRLMlNwNEtEdlNNU0twbCtQOEdnYVlrOERRSHhrTXpDMTQ4bVJQ?=
 =?utf-8?B?RU5DbHBJRnFuVTZZSEJqMEE4NUFvMmxjanRoemZXNU5kM0VPSmhFOUo2aktj?=
 =?utf-8?B?dGV5Rk1UMlE2Y3R3ckdvTHU4N2NMK3o2RkpMNDRMVVpJY0RMeXJrOS9FR0lD?=
 =?utf-8?B?T3FpekdKb0dSWkJsQktVeE9aLzFveTU0SEJ4Z0xiclBGNms5cGxZRnQvTEs1?=
 =?utf-8?B?TE9DNTdyQzEyNmRBbVZNcmhsbHA3TEZuV3VVaGNJZGVvczhOcUZvaGZVaEE5?=
 =?utf-8?B?RExFYXpKZWN4R2ZlOFh1aXVQZGlZdUc2M1FxZ01HLzJicnAxQURNUmpIVG9u?=
 =?utf-8?B?VlpFQk1ZK05EL1M0Rkh6V3NGR1FLY1JoNFloajg1b09PMHpoU1NrbzZCZ3ln?=
 =?utf-8?B?Z1YwWU9CWW1JSGpwWG0ra0RJSFVnaFNSS2JMeWhGR3E4dzVoZ09XeldFelgr?=
 =?utf-8?B?amlCUHpkT3Z2R25nMy83bWluNzF4Qk9EMzY0ZE9MMmUzRXBBYlQ1bHZydFU2?=
 =?utf-8?B?TEVvWTR0bHlnQ3hhMUI1UzBUa2V2Q0VPVFZidW56aGlCdVJzZGEzdm1JZEpu?=
 =?utf-8?B?MXpkOHZsbFk3VWZEQzFJUnBZdzlOalgyY0RVbWE3UEEzM3JZU0xOQ1plK1ps?=
 =?utf-8?B?RlN5ajZLQ1lDbHY2R044MVZIWnYyaEtMblJDNk80b1c3THYrWTFpV21LQ2dT?=
 =?utf-8?B?TFNqMGZXcGdpOEJOV1hyUGVKRENGWGU1OEQvOTkycjB2cUIyckJIWlR6OGpP?=
 =?utf-8?B?TjlSZEJHMEx1S3ZUWEx5M05TVHptaGdPQml2U2VBaXRtUHRmNFJ1MW9LK3Qw?=
 =?utf-8?B?Lys1REl1UkNaUGxqUTJSRFVhYlgzTitpSkhFcnBkbU1WNFhTOStNc25XMm5H?=
 =?utf-8?B?UGFPc1NPTnFUNnF3T0FGU3N4Q2xUQllMMUJGcFBZSWpCRHdDVTZwb3kwSGtp?=
 =?utf-8?B?V2hZSEx5ZnF0bVU2NFIvcFdqMTRHSVQ0MTNMeVVsSXVVTWVkWk5USm9iVVd0?=
 =?utf-8?Q?uh1jHajYeGTtTM5qSirYNnOYy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc23272-3c2b-4952-4185-08dd1a54ec4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 02:30:20.0019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vuoxkek0mEgX/WBpwXupIsWAZsBfR+1CusavTB9/R37pbyjHcJ9ZbS8S0wezOrPNFS1RkMYZtGfNBYTRk9K8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5514
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=wafer@jaguarmicro.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXVnZW5pbyBQZXJleiBN
YXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDEx5pelIDIw
OjQ1DQo+IFRvOiBXYWZlciA8d2FmZXJAamFndWFybWljcm8uY29tPg0KPiBDYzogbXN0QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGh3L3ZpcnRpbzogRml4IGNoZWNrIGF2YWlsYWJsZSBpbmRleCBvbiB2aXJ0aW8gbG9h
ZGluZw0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VU
U0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0
YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25p
emUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9u
IFdlZCwgRGVjIDExLCAyMDI0IGF0IDE6MzTigK9QTSBXYWZlciA8V2FmZXJAamFndWFybWljcm8u
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFdhZmVyIFhpZSA8d2FmZXJAamFndWFybWljcm8u
Y29tPg0KPiA+DQo+ID4gVGhlIHZpcnRpby0xLjIgc3BlY2lmaWNhdGlvbiB3cml0ZXM6DQo+ID4N
Cj4gPiAyLjcuNiBUaGUgVmlydHF1ZXVlIEF2YWlsYWJsZSBSaW5nOg0KPiA+ICJpZHggZmllbGQg
aW5kaWNhdGVzIHdoZXJlIHRoZSBkcml2ZXIgd291bGQgcHV0IHRoZSBuZXh0IGRlc2NyaXB0b3IN
Cj4gPiBlbnRyeSBpbiB0aGUgcmluZyAobW9kdWxvIHRoZSBxdWV1ZSBzaXplKS4gVGhpcyBzdGFy
dHMgYXQgMCwgYW5kIGluY3JlYXNlcyINCj4gPg0KPiA+IFRoZSBpZHggd2lsbCBpbmNyZWFzZSBm
cm9tIDAgdG8gMHhGRkZGIGFuZCByZXBlYXQsIFNvIGlkeCBtYXkgYmUgbGVzcw0KPiA+IHRoYW4g
bGFzdF9hdmFpbF9pZHguDQo+ID4NCj4gDQo+IEkgZG9uJ3QgZ2V0IHRoaXMgY2hhbmdlLiBJZiB0
aGF0IGhhcHBlbnMgdGhlIGRyaXZlciB3ZW50IGJ1Z2d5IG9yIG1hbGljaW91cw0KPiBhbmQgdGhl
IG5leHQgY2hlY2sgbmhlYWRzID4gdnJpbmcubnVtIHNob3VsZCBtYXJrIHRoZSB2cSBhcyBidWdn
eSwgaXNuJ3QgaXQ/DQo+IA0KDQpEdXJpbmcgdGhlIG1pZ3JhdGlvbiBwcm9jZXNzLCBsZXQncyBh
c3N1bWUgYSBzY2VuYXJpbyB3aGVyZToNClRoZSBkZXB0aCBvZiB0aGUgYXZhaWwgcmluZyBpcyAw
eDEwMDAwLCBsYXN0X2F2YWlsX2luZGV4IGlzIDB4RkZGMCwgYW5kIGF2YWlsLT5pZHggaXMgMHhG
RkZGRi4NCkF0IHRoaXMgcG9pbnQsIHRoZSBndWVzdCBWTSBkcml2ZXIgc2VuZHMgYSB2aXJ0aW8g
ZGF0YSBwYWNrZXQsIGFuZCBhdmFpbC0+aWR4IGlzIHVwZGF0ZWQgdG8gMHgwLg0KVGhlIG1pZ3Jh
dGlvbiBvY2N1cnMsIGFuZCBsYXN0X2F2YWlsX2luZGV4IGlzIHNlbnQgdG8gdGhlIHRhcmdldCBR
RU1VLiANCkR1cmluZyB0aGUgbG9hZGluZyBwcm9jZXNzIG9mIHRoZSB0YXJnZXQgUUVNVSwgaXQg
d2lsbCBjaGVjayBib3RoIGxhc3RfYXZhaWxfaW5kZXggYW5kIGF2YWlsLT5pZHguIA0KSW4gdGhp
cyBjYXNlLCBsYXN0X2F2YWlsX2luZGV4IGlzIGdyZWF0ZXIgdGhhbiBhdmFpbC0+aWR4Lg0KDQo+
ID4gRml4ZXM6IDI1OGRjN2M5NmIgKCJ2aXJ0aW86IHNhbml0eS1jaGVjayBhdmFpbGFibGUgaW5k
ZXgiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FmZXIgWGllIDx3YWZlckBqYWd1YXJtaWNy
by5jb20+DQo+ID4NCj4gPiAtLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gIC1Nb2RpZnkgdGhl
IGNvbW1pdCBpZCBvZiB0aGUgZml4Lg0KPiA+IC0tLQ0KPiA+ICBody92aXJ0aW8vdmlydGlvLmMg
fCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLmMgYi9ody92
aXJ0aW8vdmlydGlvLmMgaW5kZXgNCj4gPiBhMjZmMTg5MDhlLi5hZTdkNDA3MTEzIDEwMDY0NA0K
PiA+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8uYw0KPiA+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8u
Yw0KPiA+IEBAIC0zMzYyLDcgKzMzNjIsMTMgQEAgdmlydGlvX2xvYWQoVmlydElPRGV2aWNlICp2
ZGV2LCBRRU1VRmlsZSAqZiwgaW50DQo+IHZlcnNpb25faWQpDQo+ID4gICAgICAgICAgICAgICAg
ICBjb250aW51ZTsNCj4gPiAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAgICAgIG5o
ZWFkcyA9IHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+dnFbaV0pIC0gdmRldi0+dnFbaV0ubGFzdF9h
dmFpbF9pZHg7DQo+ID4gKyAgICAgICAgICAgIGlmICh2cmluZ19hdmFpbF9pZHgoJnZkZXYtPnZx
W2ldKSA+PSB2ZGV2LT52cVtpXS5sYXN0X2F2YWlsX2lkeCkgew0KPiA+ICsgICAgICAgICAgICAg
ICAgbmhlYWRzID0gdnJpbmdfYXZhaWxfaWR4KCZ2ZGV2LT52cVtpXSkgLQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgdmRldi0+dnFbaV0ubGFzdF9hdmFpbF9pZHg7DQo+ID4gKyAgICAg
ICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICBuaGVhZHMgPSBVSU5UMTZfTUFY
IC0gdmRldi0+dnFbaV0ubGFzdF9hdmFpbF9pZHggKw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdfYXZhaWxfaWR4KCZ2ZGV2LT52cVtpXSkgKyAxOw0KPiA+ICsgICAgICAgICAg
ICB9DQo+ID4gICAgICAgICAgICAgIC8qIENoZWNrIGl0IGlzbid0IGRvaW5nIHN0cmFuZ2UgdGhp
bmdzIHdpdGggZGVzY3JpcHRvciBudW1iZXJzLiAqLw0KPiA+ICAgICAgICAgICAgICBpZiAobmhl
YWRzID4gdmRldi0+dnFbaV0udnJpbmcubnVtKSB7DQo+ID4gICAgICAgICAgICAgICAgICB2aXJ0
aW9fZXJyb3IodmRldiwgIlZRICVkIHNpemUgMHgleCBHdWVzdCBpbmRleCAweCV4ICINCj4gPiAt
LQ0KPiA+IDIuMjcuMA0KPiA+DQoNCg==

