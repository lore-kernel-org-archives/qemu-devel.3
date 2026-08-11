Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2882C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtg8U-000654-63; Tue, 11 Aug 2026 02:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtg8A-00061p-Ch
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:38:40 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtg86-00039U-9i
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786430310; x=1817966310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+qHCCs36hZChbHVNAPa0ZwiwC0Crziyd8RfPlWW8IpQ=;
 b=W/VpeyuCn+UKBvN4/bPZEAs1cZe7rawgGzMt9gHz8h24h1q9NpXteyBR
 JDShO4LJ9TQNIUZJHF/e0nQR+Z8c0bU3v3rPuYnDwc95lfMHI3JjPi94i
 wKa2grCb8cdCOdZ1+CakPbouDrEcBVRZ5YZkP3ydhb+1JLKbdVCdHlZqq
 CdC9STsNnXek2H4eXJeIvS/h4XFwY22gwEyaxQvOyCOZw0qqT87VU3Rgk
 ro7I1RREqlpMoGexa9IfQs2nbrbjBqXviLyYuvcnHtOrV21m7kHPl68G+
 TWgTaoHp53Zom6u1W/ZDrauftbQ6Qkudh8uqBXacG1A+ndCf7T16rCD0y Q==;
X-CSE-ConnectionGUID: KAAf+e6kRLCFNazkOQZNPw==
X-CSE-MsgGUID: fkbGhlQ4So25G80zDHgT9g==
IronPort-SDR: 6a7ac362_BSOsxN5CtpNGAviiS2ctfVueB54k83KWYSXg5B9gdD0+TMv
 r2Rabz1qaKvxRbPyxnce/UzM/i/TRiFoRHu48xg==
X-IronPort-AV: E=Sophos;i="6.25,217,1779141600"; d="scan'208";a="48588098"
X-MGA-submission: =?us-ascii?q?MDGqc4HAEdkFe55JFsZ9Ta2dUz4FkcSCHNMOiv?=
 =?us-ascii?q?4GT01qewmKAkLbsXBDzCuUC9w99zWlsXndKvyFKXRyeAtWsxnnV/WoDZ?=
 =?us-ascii?q?g+e0y6dxXK31L8jDM+euj9k1OraPCFmmktO28DGxSRkz7KG9PtSl04zH?=
 =?us-ascii?q?abgy3sbDu2DF5551dE/SFhBA=3D=3D?=
Received: from mail-northeuropeazon11012008.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.8])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 11 Aug 2026 08:38:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tohdBywQyUV4+2a1V57xyNSsACmRGEghgaJ54EYqfIDT2bct2biCwxnX/H8cT/EG2MZLRupkpqocIjOM6nwDos0fgqpQZB3nPMMwdQ691fQMJyajD+f/FnCDoKE+7DP89ruxaIYCuHG4rlvYFRlHlz1v8NEox3heUGbc6vYiMIueeasMnbL4eJd/46KdGCrPp5o0uvOCh05gAnhQB2Yb/QLndFqiKllybi/NINMIX8gx7K8BGJEx96cBE1WQvbFYVmpdWDdadCqC+WCCocevcidaVB5xo0pSFni6obuxG66sNptQJ6ptdmZP1YkDV+fcPf1wxw7IXPVE1QYarGrqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qHCCs36hZChbHVNAPa0ZwiwC0Crziyd8RfPlWW8IpQ=;
 b=EUkkh2pkdFSyhzdM1BHwqDeFR8XSY3pzD+rIeV54IEiWJlGwlCTiTJNYIoTk3qgpr3VmsnyhwV0W0xRqPYJvZzllt/HOYilLOFG5TtuvcT8hHtXqWRjUMv0qes7KCC+0FBlnvCjZS3i0P2f5orSYjFwYXV/Lbi5PRotnAQGTpK0qJJWQe6J7d3RRG1akdBCHYNGiMV4V/KUzRyxc9hWg1apkJufcb1v2O9YBXVNl63O6gF2/6ILCcJ85mCulhgsxsLc/BJJtLH2Ku8AEbjbFLXA3aIJIQ3Rjtm9z12jAPJ7zwEBf3vaQc1X+mvjo5YAWXgilNX7re/zN9+I5kWF2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AMBPR07MB11785.eurprd07.prod.outlook.com (2603:10a6:20b:72c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 06:38:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 06:38:24 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v3 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Topic: [PATCH v3 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Index: AQHdJXapzRRoHALxMU6Nkdbd7JHTVLaYbRWA
Date: Tue, 11 Aug 2026 06:38:24 +0000
Message-ID: <b47384ede6bc77248473b248ad8c16fbc892bfd9.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <20260806073825.363468-3-zhenzhong.duan@intel.com>
In-Reply-To: <20260806073825.363468-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AMBPR07MB11785:EE_
x-ms-office365-filtering-correlation-id: 22207b33-1cc5-4c62-8fed-08def77324db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|3023799007|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: E/ii+DfFtxiJ6IsSpRfDJSMpFaqTZavQ3ZPnuCtWCLeIB/1HJkdbmm5yYu6HcJgHIBJDtSVLpae7FlAcEA2Xtw/gOdhl1E2tvFlnQnvwPlnDrnESU/euvs6CR5/Q3LaRMZeS2h4xXJw38QyYp6FJ0tgRGsb0Z5KR+UKO/qO8/gavfijvjG87JLAQVUCQP3jEOG/EhR0cQv3Ev+J21+6md/xRp2AyQbtNtu0nLoxSjHeq/A7VpZ3254I48Vp2pxyp7UGmXp7e3Yr8JLPZEWYwUwtQvKtLZii3xKPj2XMPEdBnRhRwaEqjKe3sYCk0SyQ/zUQP476AXFvoiwYsFckw0rkmNBFzAMfKLeXIqxG+RiyL/SeRZR03oiS84F6b+gbGy5B8dsgcebCanLL4V6yn7Gqb2H9jhSwhATU1ZhLUN6BzWSPiMTyY9EUCUowY7OKx+1m10RavR9bUe7lGw7q5X1US6SYRjWLlnHyqeMBinM0We9ej8zly23vGOTT9Uho6qfa8BCzyFXAe/P5MfnmshlKqItuwLwqth+K+KXSz3IYafuW0o6pGhiCqXiwt0Sla5TAi9EKq08Jq3HmWMHFTRTpacONBODABpnmy0gtu310E5D8s/aoxXSyFQl/V7xmqg5JSh2ngIOsmygxnLR/BhsIvpw96uDQsBMs60jMtGUflxl7P3oe2emoFuYFa8CMrOv8ZfbIjNgNWmpgIjdWWWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlZtVlBlK1M0WnVxVUFtR2lhOXNSQ1ZQT2x4VUFIMXZreTVYL3lVK3I5YWF4?=
 =?utf-8?B?RU5HK08yRThaTTNSQmRDcExoRTNIVnhraWc0TlJRUHhXTW9zTmczSHZKcm5R?=
 =?utf-8?B?dFg5by9xWDFWaCtzV2VwWUU4ZlVHZWNxck01Rk56bFR1N05KeStJTGNydGFm?=
 =?utf-8?B?Nk5BYXF3WFZSUFBCbFpzUURSSTRkQVFuVUlZSlQvWUNmc2hpcUVRR2pPY1hM?=
 =?utf-8?B?ZWZwUEVacUJ5TmNCOVlsejJjVEZkTFFpb2VLbW15aWRzYUVUWkI4VGo4UVRY?=
 =?utf-8?B?NTdYZDVQRUoweVlvRGRxVVoyQjVBZk9Ic3BvMFdDSGhQYlNkZXhldzh4emt1?=
 =?utf-8?B?QXFCRkhxOHlESEhzUk41N2gyVVlNWDF0MDJQWHZWWklCZGNlejl1MzgwaVhS?=
 =?utf-8?B?YjBtS2dDamFqczVCdDFFcER5OVFhL0UzSm9rS2wwRDhVTmxOMFI4RnpnckxM?=
 =?utf-8?B?ZmROSFB1Q1R2S3VTVFZaekgyZzI5aFZCYVBxWXFrRGNPdUxPeEQvV0R0ajRB?=
 =?utf-8?B?cGZxN0IvUG13UTV5dlg1MWd6R3dKcW4xSW1YMWxXZExYKzVtTFl0c1hMaGtX?=
 =?utf-8?B?MGNscWh3R0VYZ0s1RGdXUk1IZE5zdExSai9QeExZMWgzQnVidXkzQVB6M2VZ?=
 =?utf-8?B?ZERSeEVpRkN3MGNHeFdZQTBmNk1XdmdOZXgrRVJVTGtTRmZ4a01VRXRIcmJp?=
 =?utf-8?B?TjVHanEwUUZzRGFYR25ZQzhMdS9IS1o3YnNjWlB1NCtaSEdRUFFDbTFBekgz?=
 =?utf-8?B?b0lKZDU4c1lSKy9yMHU1YXU3OWtiTVEzNHg4T3BkY3NyemRCN0xLK21UUUVo?=
 =?utf-8?B?YWdsU1p4WlFFTUVGZzMyeHY0UC8wTWpnUWpBekh1WE5qc0ZpcmxFWVZ3c0cr?=
 =?utf-8?B?NHZiMlVVUFJYQndPd1BOQWN2WG1vdGU4ZXJrZVl0Q2xVQWRJUjVabXhDUngv?=
 =?utf-8?B?R2FkMHZseW5XS0Q2Z2o4VVpBTDZIRUU3MEU2cnFUVmgveE1HVkNUd0cvNGw1?=
 =?utf-8?B?NnlZV0R0cHRkSG5oOHJYNWl5S2c5SlRLVTA2RjZ6RmJkVDFNdExlYWk4ZE5u?=
 =?utf-8?B?UnYyc3d0cDVzRHVZd21FSm5jMU5paFpIb1VWenNKMGFsYUc4d1F1N085eGdC?=
 =?utf-8?B?bnFETDEySTRuZC9jb2lwcVRVM2lvRUhTbC9WUG5IdVZnamJIMzB4RnZqaVB2?=
 =?utf-8?B?eFhvcHBSUEVXL0xJeW81SXNJblhtRXpvY3JaK0xSV0xacjNLYWtTRkt4aUVQ?=
 =?utf-8?B?dW9adnk5OHdiKytxVXNrRWRwYzhzYmtuckZsRWNhcHE3bmFaeE8wenZ5Rkxx?=
 =?utf-8?B?Nm5JcW55M0NZMUlHSUNkU0dvV0JMOGQycEtTU3lpVVhJZThUYno5WCt2OGxr?=
 =?utf-8?B?RFhDQ0UwcGZvVmNtZ21ZZmZYR2xWRkJtMUhSbDE4YVFnMTBJSnVsQk5WVFdQ?=
 =?utf-8?B?ejRPN3Y1TnFPM2tYcDRDMEpKdEtJRHRoeGk0UUMrKzNOUWIvd1Q2MS9NOG9O?=
 =?utf-8?B?Qkw5NHdCOGVZN0lFOEZObDRrS0dWM3dsVDNUN1FWRVM1VXFnZVJtNHlIYUVM?=
 =?utf-8?B?VnloalpGSGFKaEdDMkhsK2JVMmJIZVJWYVdoTXJtaUpSbW16ejNXdnBtL24v?=
 =?utf-8?B?Skw0dFpOamJUZFdPWnQxMmI2QU4rVEdNWFdNQWZweUw5UjY5WlVKcmw1RTdV?=
 =?utf-8?B?WUdFSm9vY25PbHE1SFlUdXRuNGFGZVI4aTkwRHF5aksrNzZjZlhFZXJVd05Y?=
 =?utf-8?B?NnR4RmpQaEYzNUViWDRFTUV0dEVVVlFLTVZhUVFpNktEM0lNU3pjRXBPKzF1?=
 =?utf-8?B?SkVEaXhhTG1Xa1hpdmZOZ1Zkb3pwTVRQaXY2MHhmME9GRlh2UmdkNTBQR3Rw?=
 =?utf-8?B?U3J5ck5hQko2MlhDdzVnc283NExVTGV5S0lyczNRWngrYUhQTmpGZFhnNVdM?=
 =?utf-8?B?Wk0zWnpSUFRKVnJ3SEd2c1J4NDRRMDJ6eDZIZmJsQ3BiNTZUUG9SZDd5SVdB?=
 =?utf-8?B?RklQa0dnV3dJN0JFR3lCelV4ZUlLQm1DM01HWm5uUDc3OVhwSzhGSjhSbHlF?=
 =?utf-8?B?MGpFMDFjbGQrd01iMjIyTHc2R1ptbmJXbWhRb2NGdG5VY1IyUlBOVVJKZVV1?=
 =?utf-8?B?cEQ2TDFOVmtkUUM1QkFlcUhOdVNiWG9FYk1LWmMvWjZxNU90Vkt6VjlBU3JS?=
 =?utf-8?B?c092Uzh1U0dBZWVMak4weXRUQURIUXYxVlBXZG5oRllOSE9GQWRqLzErVnFD?=
 =?utf-8?B?QTdkODNUQmgyVGRKSU9tTGMwUzVYMkpkSmhncHNkWE5xdDJwdXJaL211Nmth?=
 =?utf-8?B?OThqTHdVbHBxUnFkMTNXVE5zam42MTdrQzcvQldwcGw4RS9UZkR3RkdQSGdp?=
 =?utf-8?Q?NFFEUsJUselVbtqelhjccUWou20e6A6Yb8KkX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CA2F2753EE64944B93E35BE14103A1F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YhQTr31CzZW+ns+bKHN4YLvrYCn/dyntpdh+wxyOpOeDiHexdw3EDAnGw6q9Iqzi7Cq6/5++mhapaLH9RDhoZNxxprrp8/JtI++7Ggpr4MP3Ur5s9G+nhTM9m4YqFtDXR5CpRDkOOKIREmXAINnQ0O/xFY6rvjsX815oRG0OloqpSmu1fep+s+K6YisEC+yyVOXpeCGCPS0v4uNqBd7XHGJxqAeoGuPdsWt8iWdJjnmJAA/kxZCsV7hIuDai1VGoj0Z0UDlFoWiqyG8rvS0T34lI0xHZ94LkKVP37PyZLBnNrL48LYVTFr0Db5DwgAcvzdsFQ9ZZY4PaKS22hRtAVw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22207b33-1cc5-4c62-8fed-08def77324db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:38:24.4252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc/YA5WrtqzNd2hIQpQIBn6xuBDJduziP0XMfA093v9LBV5N9dDyvIGrU727lMz2bplVb40030stgelLetK01eKMAZQ+bY7inLHbkSpcPYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11785
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

DQpPbiBUaHUsIDIwMjYtMDgtMDYgYXQgMDM6MzggLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBBZGQgYSBuZXcgaGVscGVyIGZvciBJT01NVV9GQVVMVF9RVUVVRV9BTExPQyBpb2N0bCB0
byBhbGxvY2F0ZSBhIGZhdWx0ICANCj4gaGFuZGxpbmcgb2JqZWN0IHdoaWNoIHdpbGwgYmUgdXNl
ZCBpbiBod3B0IGFsbG9jYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVs
LmNvbSk+ICANCj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDxbeHVkb25nLmhhb0BpbnRlbC5jb21d
KG1haWx0bzp4dWRvbmcuaGFvQGludGVsLmNvbSk+ICANCj4gLS0tICANCj4gwqBpbmNsdWRlL3N5
c3RlbS9pb21tdWZkLmggfMKgIDMgKysrICANCj4gwqBiYWNrZW5kcy9pb21tdWZkLmPCoMKgwqDC
oMKgwqAgfCAyMSArKysrKysrKysrKysrKysrKysrKysgIA0KPiDCoGJhY2tlbmRzL3RyYWNlLWV2
ZW50c8KgwqDCoCB8wqAgMSArICANCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmggYi9pbmNsdWRl
L3N5c3RlbS9pb21tdWZkLmggIA0KPiBpbmRleCAxN2JmMWEzNzI3Li5jMjg3NzY3YjExIDEwMDY0
NCAgDQo+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCAgDQo+ICsrKyBiL2luY2x1ZGUv
c3lzdGVtL2lvbW11ZmQuaCAgDQo+IEBAIC0xMDYsNiArMTA2LDkgQEAgYm9vbCBpb21tdWZkX2Jh
Y2tlbmRfYWxsb2NfdmV2ZW50cShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IHZpb21tdV9p
ZCwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90ICpvdXRfdmV2ZW50cV9pZCwgIA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVpbnQzMl90ICpvdXRfdmV2ZW50cV9mZCwgRXJyb3IgKiplcnJwKTsgIA0KPiDC
oCAgDQo+ICtib29sIGlvbW11ZmRfYmFja2VuZF9hbGxvY19mYXVsdHEoSU9NTVVGREJhY2tlbmQg
KmJlLCB1aW50MzJfdCAqZmF1bHRfaWQsICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgKmZhdWx0X2ZkLCBF
cnJvciAqKmVycnApOyAgDQo+ICsgIA0KPiDCoGJvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3
X3F1ZXVlKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QgdmlvbW11X2lkLCAgDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1aW50MzJfdCBxdWV1ZV90eXBlLCB1aW50MzJfdCBpbmRleCwgIA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDY0X3QgYWRkciwgdWludDY0X3QgbGVuZ3RoLCAgDQo+IGRpZmYgLS1n
aXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMgIA0KPiBpbmRleCAx
NWYyYTUxMzUwLi5mY2NkNGU2NjBjIDEwMDY0NCAgDQo+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQu
YyAgDQo+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYyAgDQo+IEBAIC01NTQsNiArNTU0LDI3IEBA
IGJvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX3ZldmVudHEoSU9NTVVGREJhY2tlbmQgKmJlLCB1
aW50MzJfdCB2aW9tbXVfaWQsICANCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7ICANCj4gwqB9ICAN
Cj4gwqAgIA0KPiArYm9vbCBpb21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxKElPTU1VRkRCYWNr
ZW5kICpiZSwgdWludDMyX3QgKmZhdWx0X2lkLCAgDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ICpmYXVsdF9m
ZCwgRXJyb3IgKiplcnJwKSAgDQoNCm91dF9mYXVsdF9mZCBpbiB0aGUgc3RydWN0dXJlIGlzIF9f
dTMyLiAgDQpJbiB0aGUgc2FtZSBmaWxlLCBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmV2ZW50cSBp
cyBpbiBhIHNpbWlsYXIgc2l0dWF0aW9uIGFuZCB0aGUgDQoNCkZ1bmN0aW9ucyBpbiB0aGUgc2Ft
ZSBmaWxlIG5hbWUgb3V0cHV0IHBhcmFtZXRlcnMgdXNpbmcgdGhlICJvdXRfIiBwcmVmaXguICAN
Ck1heWJlIHdlIHNob3VsZCBkbyB0aGUgc2FtZS4gIA0KDQpNb3Jlb3ZlciwgdGhlIG91dHB1dCBm
YXVsdF9mZCBpcyBfX3UzMiBpbiB0aGUgaW9tbXVfZmF1bHRfYWxsb2Mgc3RydWN0dXJlLiAgDQpX
ZSBzaG91bGQgYXZvaWQgdXNpbmcgaW50IGhlcmUuIGlvbW11ZmRfYmFja2VuZF9hbGxvY192ZXZl
bnRxIGlzIHF1aXRlIHNpbWlsYXIgaW4gdGhpcyByZXNwZWN0Lg0KDQo+ICt7ICANCj4gK8KgwqDC
oCBpbnQgcmV0LCBmZCA9IGJlLT5mZDsgIA0KPiArwqDCoMKgIHN0cnVjdCBpb21tdV9mYXVsdF9h
bGxvYyBjbWQgPSB7ICANCj4gK8KgwqDCoMKgwqDCoMKgIC5zaXplID0gc2l6ZW9mKGNtZCksICAN
Cj4gK8KgwqDCoCB9OyAgDQo+ICsgIA0KPiArwqDCoMKgIHJldCA9IGlvY3RsKGZkLCBJT01NVV9G
QVVMVF9RVUVVRV9BTExPQywgJmNtZCk7ICANCj4gK8KgwqDCoCB0cmFjZV9pb21tdWZkX2JhY2tl
bmRfYWxsb2NfZmF1bHRxKGZkLCBjbWQub3V0X2ZhdWx0X2lkLCBjbWQub3V0X2ZhdWx0X2ZkLCAg
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCk7ICANCj4gK8KgwqDCoCBpZiAocmV0KSB7ICAN
Cj4gK8KgwqDCoMKgwqDCoMKgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQg
dG8gYWxsb2NhdGUgZmF1bHQgcXVldWUiKTsgIA0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOyAgDQo+ICvCoMKgwqAgfSAgDQo+ICsgIA0KPiArwqDCoMKgICpmYXVsdF9pZCA9IGNtZC5v
dXRfZmF1bHRfaWQ7ICANCj4gK8KgwqDCoCAqZmF1bHRfZmQgPSBjbWQub3V0X2ZhdWx0X2ZkOyAg
DQo+ICvCoMKgwqAgcmV0dXJuIHRydWU7ICANCj4gK30gIA0KPiArICANCj4gwqBib29sIGlvbW11
ZmRfYmFja2VuZF9hbGxvY19od19xdWV1ZShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IHZp
b21tdV9pZCwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcXVldWVfdHlwZSwgdWludDMy
X3QgaW5kZXgsICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHIsIHVpbnQ2NF90IGxl
bmd0aCwgIA0KPiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzIGIvYmFja2VuZHMv
dHJhY2UtZXZlbnRzICANCj4gaW5kZXggMDA5YTI1YjBiZS4uZGJiYzhlYTdjZCAxMDA2NDQgIA0K
PiAtLS0gYS9iYWNrZW5kcy90cmFjZS1ldmVudHMgIA0KPiArKysgYi9iYWNrZW5kcy90cmFjZS1l
dmVudHMgIA0KPiBAQCAtMTcsNiArMTcsNyBAQCBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hX25v
bl9leGlzdChpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcywgdWludDY0X3QgaW92YSwgdSAgDQo+
IMKgaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcywg
dWludDY0X3QgaW92YSwgdWludDY0X3Qgc2l6ZSwgaW50IHJldCkgIiBpb21tdWZkPSVkIGlvYXM9
JWQgaW92YT0weCUiUFJJeDY0IiBzaXplPTB4JSJQUkl4NjQiICglZCkiICANCj4gwqBpb21tdWZk
X2JhY2tlbmRfYWxsb2NfaW9hcyhpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcykgIiBpb21tdWZk
PSVkIGlvYXM9JWQiICANCj4gwqBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpbnQgaW9tbXVm
ZCwgdWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBwdF9pZCwgdWludDMyX3QgZmxhZ3MsIHVpbnQz
Ml90IGh3cHRfdHlwZSwgdWludDMyX3QgbGVuLCB1aW50NjRfdCBkYXRhX3B0ciwgdWludDMyX3Qg
b3V0X2h3cHRfaWQsIGludCByZXQpICIgaW9tbXVmZD0lZCBkZXZfaWQ9JXUgcHRfaWQ9JXUgZmxh
Z3M9MHgleCBod3B0X3R5cGU9JXUgbGVuPSV1IGRhdGFfcHRyPTB4JSJQUkl4NjQiIG91dF9od3B0
PSV1ICglZCkiICANCj4gK2lvbW11ZmRfYmFja2VuZF9hbGxvY19mYXVsdHEoaW50IGlvbW11ZmQs
IHVpbnQzMl90IGZhdWx0X2lkLCBpbnQgZmF1bHRfZmQsIGludCByZXQpICIgaW9tbXVmZD0lZCBm
YXVsdF9pZD0ldSBmYXVsdF9mZD0lZCAoJWQpIiAgDQo+IMKgaW9tbXVmZF9iYWNrZW5kX2ZyZWVf
aWQoaW50IGlvbW11ZmQsIHVpbnQzMl90IGlkLCBpbnQgcmV0KSAiIGlvbW11ZmQ9JWQgaWQ9JWQg
KCVkKSIgIA0KPiDCoGlvbW11ZmRfYmFja2VuZF9zZXRfZGlydHkoaW50IGlvbW11ZmQsIHVpbnQz
Ml90IGh3cHRfaWQsIGJvb2wgc3RhcnQsIGludCByZXQpICIgaW9tbXVmZD0lZCBod3B0PSV1IGVu
YWJsZT0lZCAoJWQpIiAgDQo+IMKgaW9tbXVmZF9iYWNrZW5kX2dldF9kaXJ0eV9iaXRtYXAoaW50
IGlvbW11ZmQsIHVpbnQzMl90IGh3cHRfaWQsIHVpbnQ2NF90IGlvdmEsIHVpbnQ2NF90IHNpemUs
IHVpbnQ2NF90IGZsYWdzLCB1aW50NjRfdCBwYWdlX3NpemUsIGludCByZXQpICIgaW9tbXVmZD0l
ZCBod3B0PSV1IGlvdmE9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0IiBmbGFncz0weCUiUFJJ
eDY0IiBwYWdlX3NpemU9MHglIlBSSXg2NCIgKCVkKSI=

