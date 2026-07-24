Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA437C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEbh-0001pw-K3; Fri, 24 Jul 2026 08:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wnEbV-0001mK-M8
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:02:21 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wnEbT-0000IR-03
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1784894530; x=1816430530;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=B1eIOu+Ymn+na5Ic81KXobi5FJ+AsL+Y5iBfeueveLw=;
 b=VB5aMEPqFJXbJg6fdPxZicG1E6VqjPgxhYNWIwq7qu2wd//fhfwmEG1s
 xqDQgO4anWFjfRSngWEH17o9Dufr9xOQQDABGiRNXvPeLG4rT56e6ab1f
 MHv8TYVZOyhpJ5KuF4l31QiywByZT+svPbTRo0VgSf9iVbcWONt1LFq8j
 mA4VZLAr3t9E7dfOWDs4/9QsUKkQD9HfzxCWdQCKmmiq+kG8VBOM4cw7Z
 4y1g9grET1q0zau30zr9mZj2kOQfS/KwQnfiDpvXCjyVqX8ypyy1PEC2x
 4MThUnFEaQFgt3GAUNh2oYZjbECWj7929F7EJsCnSV60G8wIg7yIFKI4W Q==;
X-CSE-ConnectionGUID: VxOZ6ORRQp2jESoxB6AYCQ==
X-CSE-MsgGUID: 7AAllwwKRFOAbejLCe5Viw==
IronPort-SDR: 6a63543d_OOP09/DJsD0jr3+V/ZpnUSpUlQ5qxUzcppNkmzht+CWYtZf
 1GcQ2XHNJg5Kl/CnR3kQjjCCHPjgv5GgPP85NHg==
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; d="scan'208";a="48492354"
X-MGA-submission: =?us-ascii?q?MDEaBBmmjr1kJcN/RwFabld/jhiwC+koZqslYI?=
 =?us-ascii?q?UHfdLxf5H7d3XEfkEfMlqnJNjrh/LZ6A45sKg7dzUsjOmJt0ZXONreV+?=
 =?us-ascii?q?KwWFAlMF4R/gHe5KzSXj+is3hySTIAi4h5GdVD9nKDuO/Z10T3ekesNt?=
 =?us-ascii?q?h7TbIdMzWfUApl29jQ02YYjQ=3D=3D?=
Received: from mail-westeuropeazon11013069.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.69])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jul 2026 14:02:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAhfcQHFc1RmUxkolKiDC/XZsGKNm6yIgLh9GC0LI3iZrYI/2M1Q8h+z/KUfQdwbWqebvm36RzNVxFMfnxt/4YVIhW2pi9i6IstRayfkeKFL8v/68Ebif2Dsjk1EEbKbt0Z5OvwH8GyteErgC2fyQB/EW3/p3znZAezhgH3hVKrQJFg2qaiYACNyJg9KhhKgy9mpG1HLMJMt5kE70WM8GqOGe6Ttfo12J3hxkdDfx2DuGqwJULVCttKbWj2Kj9ugNg7mLKlmCCKw78B4WQXVHcMOXfWc51b6rjhQkPLZ39crN4j6evEKfXUAJp9aV1+X6+6OFOGJELjXmf6qilCNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1eIOu+Ymn+na5Ic81KXobi5FJ+AsL+Y5iBfeueveLw=;
 b=XzZmbGDKJv/ddTXmUpqAnbi0aYbb6aKgMyu4+ovBkgD3eQedO0mr3W5VQ+TmM2MztFezeRHddKj33ugfh6015BK6/8llcdIkFAFBI0A1gqtN0gsEwVD6zlo3yEHrf7Su7tTDjsDlyjeTyVgygTpqt+ONjdv+FgYrIv7wr7sQSt+Y36elJ87mn5VRhbSsmeTNIbMuEFmtLREqNe7aH+CZ8NnvLMxVnp0YDDmhTRKvuCDm5ma4mT2ZB1LNEub8MZs5rQdyDExTD4Y8BcViMZhLk9Hn2yBTT46NGHsk00UY6QKDeaklUiKjP11ZRKAwl+ipq0ZkriYuPOkSLncdrP0lNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB11492.eurprd07.prod.outlook.com (2603:10a6:800:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.5; Fri, 24 Jul
 2026 12:02:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0270.005; Fri, 24 Jul 2026
 12:02:01 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Topic: [PATCH v2] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Index: AQHdG12+ugJmxoQDwUaH45x2quwn9bZ8i/wAgAAFvwA=
Date: Fri, 24 Jul 2026 12:02:00 +0000
Message-ID: <ac84fcfd7b64e5282ecd16d4e4d339f183dd1b21.camel@bull.com>
References: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
 <20260724073954-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260724073954-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB11492:EE_
x-ms-office365-filtering-correlation-id: 3a1bbaf0-15de-46b5-1296-08dee97b5e96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4133799003|10067099003|4143699003|56012099006|11063799006|6133799003|13003099007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: u0eWVnRorhcrY3ydKlR/spS1sQGJP7nfg06wRYY5SV74AZSN/MfMSUUQ8AUhTIzsMdQOlO+NNid9F0oJQfB/VB96PeyBqQnYiuwCqYma6T8ppPAw40i9EDD5ZAnVxXI/Iq9VvotEWx0sdtcUVz6qnzSloDbvxxvY02LQAgJsxeBAt8jaSyWkwnslwNemQ0+m5T9sbwtonSg1XFWndeqwATGUnQVXXEpBweozjuMVAXhWGPpoO8rvrNH67uoy3SSVEW+kwKqSlUCgZG8K9+AKdsVNEyTotSPITEhQ84PEhjsDZb4UImacrs58bUr6UfLORsspxV/ZwBGLEsCi+V9bw0ntdH0YsC+H/tg1BJL8CwvbLCUVlc2iyPeTHpt8VBHlyTu05U1k45mK2rurMU8bKLm1w/w6J7qKBpihnPoHzNofMeaSZVJyCJxYO47+9WhBQ4axwMZax3WtAnbZt8P7f4OzWyUDj+gcn5w0zLPoHY2K8pXR620qHqex6/w2P3YjDCd95kQ/YfJ4OpiN1hSPO/l5JOW+0HyZt8stl4oZEyAtv+9D5hwP/nvN/kyUg9AQYNiv2D586CjnvAn/7HHZU5gmUQCxJMFiYE04fjbp5oAvRw2PMhz08U/3YJqmGVEHJlf0+dCJbQtoZn1PISKKPj5c//GsPeHPZuqbH/3vGSc6WlFRI/P0NWuYoQH+3xPhgg0O+Mzf1ukVz/TmSX8f4y4XWp1cbU2OreEPiR6l7Ig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4133799003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(13003099007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0twQzVPUGUrc1NVa3U2ckxoeE5kenBIV2FCeWwrL3BPbE1CdkROVnRzYWtH?=
 =?utf-8?B?Z3FMRWFrMzlDU2NtWjcrdW82aXBLK3RiUUtIQTFOV1Y0RVlRNWxPeVNRVEJn?=
 =?utf-8?B?UEUzQnZOWG5rV1hqMmFNcFR2czBySzh1ZzFXd1JOWUUxaXpOMGlTdU5wWXUv?=
 =?utf-8?B?Z2MyMTR0SFBkVmdjUkNGaGd3b1pKS0ZubnFOZVBqL0M1bEtNaVB1MVk3anJs?=
 =?utf-8?B?Y2o4ZUFLOTZra21GMXRKR2ZrTTlsZlhRTVdLbENER3g0dHcyZEdOMmRpUjRi?=
 =?utf-8?B?a1NzN2o0UVBqc09OM0tySTExeHBOYTZTamM2SmUrNmM0a0lzTGR2eUk5THQ3?=
 =?utf-8?B?VTRGUGU3MVVCQ1dKL2xlNTBuTjRraUdlYWFRbElpOGRIWFlLUWxaZ2RjL3Vh?=
 =?utf-8?B?QzdrNWlONkFIL0ZzcnFUNlF3ZmlzNllHOHdJdzY0RzB0RFUzajlzbGNTM0ha?=
 =?utf-8?B?V0FrY3F6NWNmcFpyV01sRHBJU3k2R25JbmVkbEFhMHMwUzAyc05VV1EvR001?=
 =?utf-8?B?b0hUUlUyR1NYR1FnWVNWV0lUajJzc1Z2OThRSWV4bGxzS0l1S1VCZVZDbXdv?=
 =?utf-8?B?T0VwallzSStYbFEwN3NVTlc4a1ZPTEdUenFTZXY5SzBpMnJvNmJ3Z1d4Qnlx?=
 =?utf-8?B?TnYzNVJ4eThwZ0p3UWFVekpieVZhaUFqU29PeVNkd25oYWtUK1lvRkJwY0U5?=
 =?utf-8?B?TmlEYnlZREFDSm9ES3pSMS9yWlhzM2ZUL3ZHUU1BVTdNcGxscUFqL0Z4ZUwy?=
 =?utf-8?B?YlhJSi9oNVFsQ0UxTitXKzdPa0hxUGFTK0tBNUxtVmhjKzB2a1BmU1F5NXg0?=
 =?utf-8?B?bEF5eVU5elROeDBXUWFvcllFUFluSXg5dWlIWEp1cFdxT2g2TjA2YkR4eEZq?=
 =?utf-8?B?Vk5ZRmFKenZtWlN3Tkw1SGRza1NORHYxSTF6dkVMODNSV3ZNaUdWam91bHo1?=
 =?utf-8?B?ZW9GWTJjeW9LVXl0UkhhRHJ3SjM2QSt5RmpyL2o5MFhvR1BkSHIyYlZwOU4y?=
 =?utf-8?B?bDZ2bFFDcW1TalRVY2hvVEIxVUVSckNvUGlGY0EyMHJ1QXZzQzhzemZybEky?=
 =?utf-8?B?aGdFa1kzWDluOTlWZXlwMGkxbzdiUXhuWk1PUndXYnRHRTJmWVQ0blBOeEJw?=
 =?utf-8?B?NzVJNFFqRnVFam9SNkFSakVoWW43VlY4YmR2cGdlbWRNd25zb2Y2TEZmMW15?=
 =?utf-8?B?N1c2enF4cU4wdUNRdnVIYXQzeFB5VjF3dEwvL3pTU3BjbnFWZWUyeURmM3Yv?=
 =?utf-8?B?cFlnU1MyUEVoTlVRb2g4RitsUUpsdjVVMlN2emFRMDdBejR3TlhUZGZ3Tksr?=
 =?utf-8?B?cjNhQUFpMnJNZlpuSWhubEgvVzYyUVBYbWxyZ2dxWXhmZ2tqS1BWUEh0RmxI?=
 =?utf-8?B?V3g1cmFnOE5nc2JmZXRRUU5UU3I1T3I3cmxyTE4wNlJaaVJaV3VZbTlmR2h6?=
 =?utf-8?B?T0tjZ3lCVzlDcnUxaE8rZ0M0NmRvY0Y5OWlITXlMeGErMVpOMmtOU3plWUhP?=
 =?utf-8?B?TFp1V0tXZ1UwUmJIbC9TOStLSXVJeDQyc2dTTk9ENk5wRHpIdVBoc1RUME1o?=
 =?utf-8?B?aUc3VFhsMVRueXhEMGkwOVcyY2lRTzZienpMWVVmd1F6ZVdzVnhLOW4ybTVr?=
 =?utf-8?B?R0xGTks3OTZvaEhPeHNEM0k0UHZQWFBEOVJqOWEvSjdwSWd5UUYrNHNpOGpC?=
 =?utf-8?B?Uy9QSUFNRFBvVGxvR1hZaVdpMitvZmlCVkVnTGtzNHB5SEtzMTU2NHlKdFBn?=
 =?utf-8?B?cGFZekpSSUdpbUw5ckdYbmJmeFdVVzZnWURndkF1dk5MRFNWVDg1N2tqRTM0?=
 =?utf-8?B?b0tUVzdjcTFjVEEwdjM2TnRKTkZkVHRDRkpMZThPSG5NYVNERFZWeGYzWUlm?=
 =?utf-8?B?amVtUVgvaXdyZW1hVGVZVWNncDRoNFR6Y3BaNUZFcG9wRGtCenp5cEhuNWhi?=
 =?utf-8?B?cExTMlNMbUhYTkliY0NaSjg3NS9kd2ZJN2ZWYnN5d3ZxVHZINThiQjYwdkZm?=
 =?utf-8?B?bEs1K2w2SjVKRzVQSzloSy9QUHQyUEhsQXN4bUFyN2h0Y0MxeGFqdTBkRVBP?=
 =?utf-8?B?SGNhdVNDOW9neHBULy9KY1pRSEhRbjNvNWtUSkc4bEVRSERvR1ZzeWwxVmk3?=
 =?utf-8?B?dFMwanoxUHVycnVkTDU3UVBNQkNpMDZrNnlrOTdackU0enFYd0FwaFNjYWp3?=
 =?utf-8?B?K3VVNFkrWjI2OVRQUUhWdmxvMTFMNXJlenBYUTBEbG92QW1qUmJlUkpoTHo5?=
 =?utf-8?B?QTdhOGx4dnRHTkJpQlRFM2tHb3d4VTVJeFRYeVI4NTVWUzBLeUpENUdSOHVs?=
 =?utf-8?B?YUEvZTVKWkJqaC9hVUVXR0tRYnJESVEwSDZqQlN0a2FnRkdybFFSaE9nSzJF?=
 =?utf-8?Q?ty2XPOKP8iphGaBmzJ7+8h639JOrVQ5wZYuZK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A731D7D8FFCF408740B66B3866CA0F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AGJ56nLFqPSeW3HMLg7eULj857004uKLjxryIjb0PDvACgLa7tY5gb6FrHQBquDWouJrjgRobtZnku1voEGmTrVyh8vV13ytmTFSI/KYUewtiicvFtdQykG0Ng+hI1UZXkBFlVeNWUqdHW+H/t0r3UNNjkAi/p9o4Itq0h5iqYEc9bdwC/tGn0RtYMB3cm1uM1EZGEHzx5SudrCJ6RaSJza1JKYO4gHD+CGpKxPN5Vqmp7NeT5kk0haawKtW7Nl+cSkesOjzuXS0HgGtMGYEjgdPpqisV4ifZwWK90+JRdltQDgFl2A/PON5oDDS5H8fk8iqzFAVeIScjlk8bN42BQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1bbaf0-15de-46b5-1296-08dee97b5e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 12:02:00.9993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzgt6QXQ3MlH6Lq6Y5GVJ8CZpaXjHkAoZT0v2djs3nWt6EtQ3hQrjTxU9nXzjdZONjGNpUVwn06IZPlrLnyVgLYSZpgUvB1BZaou1wAWsMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11492
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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

DQpPbiBGcmksIDIwMjYtMDctMjQgYXQgMDc6NDEgLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBGcmksIEp1
bCAyNCwgMjAyNiBhdCAxMToxNTozMkFNICswMDAwLCBDbMOpbWVudCBNQVRISUVVLS1EUklGIHdy
b3RlOg0KPg0KPiA+IFByZXZlbnQgYSBidWdneSBkcml2ZXIgdG8gZXhlY3V0ZSBtYWxmb3JtZWQg
aW52YWxpZGF0aW9uIG9wZXJhdGlvbnMuDQo+ID4NCj4gPiBBZGQgdGhlIHNhbWUgYXNzZXJ0IGFz
IGluIHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGUuDQo+ID4NCj4gPiBMaW5rOiBbaHR0cHM6Ly9n
aXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy8zNjE5XShodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM2MTkpDQo+ID4gRml4ZXM6
IDZlYmU2Y2YyYTA2NiAoImludGVsX2lvbW11OiBQcm9jZXNzIFBBU0lELWJhc2VkIGlvdGxiIGlu
dmFsaWRhdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxb
Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGJ1bGwuY29tKT4NCj4gPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PFtwaGlsbWRAb3NzLnF1YWxjb21tLmNvbV0obWFpbHRvOnBoaWxtZEBvc3MucXVhbGNvbW0uY29t
KT4NCj4gPiBSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPFt6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb21dKG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPg0KPiA+IC0tLQ0KPg0KPg0K
PiBjaGFuZ2Vsb2cgaW4gdGhlIGZ1dHVyZSBwbHMuDQoNClllcCwgbXkgYmFkLCB0aGFua3MgTWlj
aGFlbA0KDQo+DQo+DQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDkgKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiBpbmRl
eCBiZjRmMGYyZjZiLi44MjQ1NDUyZDg5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+IEBAIC0zMDIxLDYg
KzMwMjEsOCBAQCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElP
TU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4gPiAgew0KPiA+ICAgICAgVlRESU9U
TEJQYWdlSW52SW5mbyBpbmZvOw0KPiA+DQo+ID4gKyAgICBhc3NlcnQoYW0gPD0gVlREX01BTVYp
Ow0KPiA+ICsNCj4gPiAgICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPiA+ICAgICAg
aW5mby5wYXNpZCA9IHBhc2lkOw0KPiA+ICAgICAgaW5mby5hZGRyID0gYWRkcjsNCj4gPiBAQCAt
MzA2MCw2ICszMDYyLDEzIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKElu
dGVsSU9NTVVTdGF0ZSAqcywNCj4gPg0KPiA+ICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExC
X1BTSV9JTl9QQVNJRDoNCj4gPiAgICAgICAgICBhbSA9IFZURF9JTlZfREVTQ19QSU9UTEJfQU0o
aW52X2Rlc2MtPnZhbFsxXSk7DQo+ID4gKyAgICAgICAgaWYgKGFtID4gVlREX01BTVYpIHsNCj4g
PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIHBpb3RsYiBpbnYg
ZGVzYzogaGk9MHglIlBSSXg2NA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
LCBsbz0weCUiUFJJeDY0IiAoYW09JXUgPiBWVERfTUFNVj0lbGx1KSIsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVz
Yy0+dmFsWzBdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbSwgVlREX01B
TVYpOw0KPiA+ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICAgICAgfQ0KPiA+
ICAgICAgICAgIGFkZHIgPSAoaHdhZGRyKSBWVERfSU5WX0RFU0NfUElPVExCX0FERFIoaW52X2Rl
c2MtPnZhbFsxXSk7DQo+ID4gICAgICAgICAgdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUocywg
ZG9tYWluX2lkLCBwYXNpZCwgYWRkciwgYW0sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVlREX0lOVl9ERVNDX1BJT1RMQl9JSChpbnZfZGVzYykpOw0KPiA+IC0tDQo+
ID4gMi41NC4wDQo+DQo+DQo=

