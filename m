Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3865CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOA2l-0006XZ-09; Sat, 16 May 2026 04:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOA2i-0006XP-WC
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:06:41 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wOA2g-000167-68
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1778918798; x=1810454798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Vj0JN0e0Jq11zYdyz2/+GgBGpCdQpXBqvsH1hsTFnFk=;
 b=jLRb73IVKVgGHDrpGOMbM2kL8xtCWuwm9VV97SB18EFGmuBCOmud0opD
 Wyxpj3bl3Lhci8ZrkRf8vcIX/JsWUnO197zDyV0yJGZrZSQmU28dwYgF4
 uwzudi53of3jqEHrpRP0MvAKUNcQOAHYvSlYm+d23YMTxS+O/gFsXrB7B
 FVF4Q0Ktd5qSJeD9oADa4fRv1ae58SdfY2X4KPm606pOuQXnGuDXFiG5E
 xOP7gacl0y7xuWJrw3XXyt34DoR/J9oDju/I81aG+Wu3mvMKPw/scZ2Q6
 5pHNAkM7ETFzXv3Em2AyYbd6O/SEoN66Ga7tBUsZ6TE1X0lcNute3yP0V Q==;
X-CSE-ConnectionGUID: UW2ERem+TsKDa4rQ4RyrFg==
X-CSE-MsgGUID: +//Moc3WTZyjuidiGFAIZA==
IronPort-SDR: 6a082587_/SvwG+uxInywxZPoA5T2gCME4ACqM/WjqilAT+qSdxwshdi
 H95MjJJnV+ijS0zf/xfp8fL61Clt42WfWDTINtA==
X-IronPort-AV: E=Sophos;i="6.23,238,1770591600"; d="scan'208";a="48018412"
X-MGA-submission: =?us-ascii?q?MDGKH7i0s23dBAazJhAX+QGDBEvo2x6rt7yKdY?=
 =?us-ascii?q?si83ftNCOCobkXbKnfaPkJhyGxt+1IThZ7kSjJXOt/LpOhwcT3drPpwc?=
 =?us-ascii?q?h4bEDLzYiJF594VRK4oIO5CsnrwAd0YFr1SrWJ25OdDUL9q9tU4opZBw?=
 =?us-ascii?q?ViPyg3iUDZhR+AoPyS1l8LfQ=3D=3D?=
Received: from mail-northeuropeazon11010052.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.52])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 May 2026 10:06:31 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znd5y9EOUZrXIIPZCvYtEd85PVjUU+fo20vKa9aD5NkokZhathuGVc1cKBNiHfpI/Q3Ep3l2oeuA8FjHuA9f+RSpEycn36s3d7mCesRZSqRiLKLKx2YA7d5nXObMs2K1GS847TSfr2IX4v67sBXueXHp99IHW2p/w+tXudCz3dE4k9D1xiU1tDy2UUTo8VvfzFM8D5Us9ugdY64mA1gJ8dCHUohiG8FTfi3xz3yYV/TRVKmvkKhB1FxDvC1KWpe9NJb/H1lQKI4yl/4KBZzR/BpY4BMsd8ACE67NqiwucKm/6y9k2RdmmJifgyVv54imvXwHc1SrNL8+b4Z0PXQtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj0JN0e0Jq11zYdyz2/+GgBGpCdQpXBqvsH1hsTFnFk=;
 b=QgX0VCDPZeSS/BSczJAfMr0YuHXrnN//67LIeqlgFTkHt2AebIoT3WsgMoIgK5P0MD2etzGD/hD1u5fnLsl6fBlMFGAlJigJgxKRw7CvWBKp8eRtJ5dTIa6R8kZsV0sqBF62mGLjblnR8oQL2a7/7xswg7iNeFfJxqc2aV8qPzu6k+MR+vLtp5+hRS9b440xO7JLMqM1NCC6a12yk6m2TzGX6HSsyI/hHSbn8DeYLbJlpmwp9jehiUTLR63ToTaoZQ1WYOeqRz+xtyO6+NwOEluyQclH3TMS1xTVyP477bNOiERqO/VW4j/44uMR4mg/1ix716ef870cnQ0CEA0roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB11255.eurprd07.prod.outlook.com (2603:10a6:10:60d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 16 May
 2026 08:06:29 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 08:06:29 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v5 07/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v5 07/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHc32mV4gCHtesDIEOKVGtx6+c7nbYQVsKA
Date: Sat, 16 May 2026 08:06:29 +0000
Message-ID: <aceba155a42c75d1a6c2e5a40cf35d6653e9038f.camel@bull.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-8-zhenzhong.duan@intel.com>
In-Reply-To: <20260509040819.1044702-8-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB11255:EE_
x-ms-office365-filtering-correlation-id: f2431c17-cdd4-491a-a114-08deb322091d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: QmkWC0TJSqDzsdGsjySunFJCtkN0NNYvWgKlbENUSlyDMS4MGgDeRFl/iVq+NR23nDRamo7Rts8u0uYyQAtu+8XJR3Ag7znR/HH++o7jSV/4JIDWu3YHaFEEWKRU1ddOaDTDRzPQF2pSjXh0N+GXLSYApaGeDuUOautZZHzSdq76u0oZAw2m640MIGDN4gKMs8xqjvVSTRiKBMJZ51+TmAfyAkZrhJRREcepIyABCHxSihD1Kj+lXtz9xguMa/w1eU6Yfh9MKu6DMPiZ/IrA3lMd1V/SYo7xcjsO1CI8b71cnVe4U7VuFBUYQ9OzFpd7OqAY2XY8/Mp+Rp3AtRCqfyLgRO2LOg+adhcVKobTef2xqs69c1YDyhdciE1OW5kW1MnFPTIwF5skhfdfeC1LpzyXBeT/JC50JhOtbrUADIEOndEem/80mMHwDQdduP4T0HA3x1SOrMNh3ItPHX8Uz+Gp3zgQnmjJPH4e4GKe2ueJdkvHUBPNETm4XGkPqmjYiwDoaHQEJim5sVhCV8hsm4izv/CUMdsFJKKnfeoUCy9xX8Go6ElOZDhmkUO3OCFTTuA8Z84zLI0B+8KpFJih1JbDYclXM5rYRe3b6VcvrTuP+PiW5gl/uirgnr7bVbYGXP+BbnHPmv9cPsEvXRSSThZdrr/Lyn+A6HOCdSefQxaaNEnbmQhDQE8nWG6U16tBdUDLGd4NZEVlfvrsD128n6uxzUZdTYzglNyB27stQlDTbq/7Lh2W7PwE3R1X/4v1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWczUDcycXRHa3VONWF0akJGMm4vOUphanM4VUw4ak1JaHI2cU5UYkZ5TUlM?=
 =?utf-8?B?c0x0MHlaeVlOK3FCbVVHbWlzYjRFMmdUL1Y1dFMwYVJxbTFmSkJNbENGYi84?=
 =?utf-8?B?UEh0WHhaQ0h0Z3pXOE9YREs4NE1pSmJXUGNJMGNIRmVsWHFQZ3VNZW0xdzVM?=
 =?utf-8?B?aklaS3YzQjBLRUlNdUVEQ01Ga2lLdEVlbVl6QlFoVDdIOXN3S0pMenlvNmE0?=
 =?utf-8?B?alhDYktZU05RZityR0VYaTYybkJjbG5iZmNBSFFFNVozb3dQU094bFlkdm40?=
 =?utf-8?B?dnZodzY5L2JESmF5RUoySWR2bFFwMmhiRUxzRGhGWTFhblEwa3ZOYW1iQlc4?=
 =?utf-8?B?K3pIbTBpWUtCemkwUm43TmkzL0xpaFZMYVlQc1hMREJxa3p2a0VUekRJT0do?=
 =?utf-8?B?STA2bHRndWhhZzNPUWZMa3dvZHF4ODZMVnJ5eDFHUk8zM3VEckFmUURpQlQw?=
 =?utf-8?B?Wi9NaHhXZXVieDRjR3VraUdibnpNMmJCVnRpZXk1NnVMdTl5TkhGTW15NjBJ?=
 =?utf-8?B?ODdCK1BXUlNaMlVET214SDhxcG5QWXdTcVAxcmFpM2d1emtmOGhzRkZMOXZR?=
 =?utf-8?B?eE1pOVBwSHovcVRrWW8yYk5LOHVhc3JjWDg1SGRjNU5mL0s5UDc3VG53RnBR?=
 =?utf-8?B?TU9zYUs1eGZWbjZ0N0ZGUGJhT3ozK3RVQXBVR0huN0JDeG5kQzhSeEN5bDB6?=
 =?utf-8?B?SXVOK2ZveUNVeklnS2RVQlg5U3NDV2lNWW1jOW4yWnJrQmdrVDFQbElCT295?=
 =?utf-8?B?R29mOC9sU3FXNG1lenlrM0NVdzQ2M0wzTmpRUkNkWlN6Z2FGc2hveXlkMU9I?=
 =?utf-8?B?dGIzOVFSSHlqZkhKR1htVlcwM2dTN2dWb1RPZTBwMndnL2xvdlpGK0EzcFdH?=
 =?utf-8?B?V0xvSldLK0wrcmR3QTVaZEpIbTI1U3p5eTZzV0NPc1FOZ0RoS3B0K1ppNXMr?=
 =?utf-8?B?VVlYQUNxMGlQTkF2eHhvRkd3NXlLK0QrbElqbC94WGdHZm4ycW5pK2dnRlYz?=
 =?utf-8?B?OE1Xa2hGU3Y4VVY4YkRqLzMydklqTXdQQXNRbFlSV1ljdVloVjlaeUQxQ1hP?=
 =?utf-8?B?Y1FFcnBvY1RpeDFMODA1MlF0VlNvdTQyZ3haNWJMN3JGcHRVS0IydHU4UCtu?=
 =?utf-8?B?T0pKeklkZS9sVUpSL3RPbk1aZlI2YUFDdFlWaVBEUEM0ZzdZUStadTVWQm11?=
 =?utf-8?B?S2V2enQ1VklxMzg0QzVGdFZ2NFVMVFpZTHJqOW1JSUhkZ0daaU05S3gxd1B4?=
 =?utf-8?B?TXpOSjR1MzZjWmJ0bWVLVE5wOTltQUh1b3hZRUNtbjFnVGkxbHNNelBtRU85?=
 =?utf-8?B?UERXalRNRTQ1V056aEJQNURxcmNoSjZDOGlnN3lHVFBnNzhFR1Z6QkhjL2E0?=
 =?utf-8?B?amlIbHVaL2Iya3NIUWMvR01XbTZMWVp3RG0wRFBpQ2MwVXV0ZjhiZXZjaCtL?=
 =?utf-8?B?dm9TRmVtWkx2RmZrVTZTUEpvRVA1bnU2Qm9UU2xBcUorMXVYeDNEelgya1FC?=
 =?utf-8?B?QUg3Uy8ydkljSUhsNEtPdEYya2wyR3RTOFJ4bkJOdUk5d0lVLzQvZyt1ZkRL?=
 =?utf-8?B?dENkUC9kNkVXWTRtUUsyTzJlSWlGd2dHK3p2cURVNGc5NUJLNlhYeXNPakJ1?=
 =?utf-8?B?RmcyNWRRUFV6bDh0bzJSQUJXaGgrVkxjdGxSWVZOR3Y4Q2NUYzJublNYU1po?=
 =?utf-8?B?c2krWkdLem53SnNEUERMWkxXNDFwVWx0ZDRYWjlHZVNQRCtXa3lrb0hsN3hw?=
 =?utf-8?B?dUQ0Ti90TTBiejd6MTFKUnZSd2RicUlxOXllY3dGWTR3U0F0MDFGUFYvVEQ1?=
 =?utf-8?B?a2U0VkkxcHROeDg5akRCaFdkc0tjYUk2czdJdUw2azJ3d3Faa1p3RUtEeWJW?=
 =?utf-8?B?TGZydE1XejZnQ1krRFU4bzJkd0ZkVFlnUWxaT0RSaHowTVZ6ZlovblhBUGF0?=
 =?utf-8?B?dGRNMk9OQ0hZYURROWFhT3lndU5CUWRPTWdVOUlaMHBHT0M1NXdvVG9WUncv?=
 =?utf-8?B?K2ROYTVvOTNpZjBEaTMzM2k4aTBVUUJjaHZGVjZRMjVTVUMyWDRDVWg5SW5x?=
 =?utf-8?B?WWo1TERUL2pTMVU4aHAvTkxlZ2ozRG9xOG9PbjBhRHRtTCtyR0RFZTB5UTRP?=
 =?utf-8?B?STI5bmV0MVBrYzhHL0RTK0hWUHAvYWJRcVpPTzJMUXZNS2EvSktKMTNMNll5?=
 =?utf-8?B?NCtRTTRVaDcrY1ZRWEFHd0YxQ3d1bmxkT2Z0b3ExQjA5ZzcxRjU0d1I2OEIy?=
 =?utf-8?B?Mmd4UmFmVnJ0VGUrSUJRVmQ5S2FLd3NWek5xM3pFcHY5bjVVQXMrVEFsbFY0?=
 =?utf-8?B?SmVLQkk1bkcxTlNFVDZ0U1JXUHE0RHZJU2Q3RXBKR0RqVk9ncnlNRFBzRXBi?=
 =?utf-8?Q?lWvjqt4ZnZm6yYSQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76415B2C2DEC6C45ABB5DE360B09FE7A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N9lpMAROl1iBR7zku7SFgRnKFJZsPMB9+GTv37hHkXLO27xpXZJNhera8O99g5s83YNWZvVORoihwz00iugtYqwmc5jYM+AU4TFrvubJHeSdKBxQtfFfb6hEu6FfOtrCp/Lsc1N87LSUoWnb3LjIwH9kvkq9LsQMcBuswtFt9A9WiF53DqF+ck127CTRIIMWF4Y9a8jOwv9rp/EPFk01qA1F1Y2fgl8GJXAErIW+6/Xf7qnglmyah7tyI/4oxdw4iiuUJ4IWlxBtjO1fiz0wTb7NZuPbAVbphh6JvMyIlTAV7a51leQv3MTqswF2DEZh2sPuZbRqiUmRGGbGoChHjQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2431c17-cdd4-491a-a114-08deb322091d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 08:06:29.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnHgn5vhMbGK7GRyKwriujp8nzjKyobcE25SJzI1TZUkcCI6YELITxQVdl3MLAJAb1IjsyCnYn4noDVehfT3zo7htErQ11PQpdnGVoNrZm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11255
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tPgoKT24gU2F0LCAyMDI2LTA1LTA5IGF0IDAwOjA4IC0wNDAwLCBaaGVuemhvbmcg
RHVhbiB3cm90ZToKPiBJbiBwcmV2aW91cyBwYXRjaCB3ZSBpbnRyb2R1Y2VkIGEgZ2xvYmFsIG1h
Y3JvIElPTU1VX05PX1BBU0lEKDApIGZvciAgCj4gdGhlIFJJRCBhdHRhY2htZW50LCB0aGlzIG1h
a2VzIHRoZSBsb2NhbCBtYWNybyBQQVNJRF8wIHJlZHVuZGFudC4gIAo+IERlbGV0ZSBpdCBhbmQg
dXNlIElPTU1VX05PX1BBU0lEIGluc3RlYWQuCj4gCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGlu
dGVuZGVkLgo+IAo+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDxbeWkubC5saXVAaW50ZWwuY29tXSht
YWlsdG86eWkubC5saXVAaW50ZWwuY29tKT4gIAo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50
ZWwuY29tKT4gIAo+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8W3h1ZG9uZy5oYW9AaW50ZWwuY29t
XShtYWlsdG86eHVkb25nLmhhb0BpbnRlbC5jb20pPiAgCj4gLS0tICAKPiDCoGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8wqAgMSAtICAKPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuY8Kg
wqDCoMKgwqDCoMKgwqDCoCB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0gIAo+IMKgaHcvaTM4
Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHzCoCAyICstICAKPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCAgCj4gaW5kZXggYzdlMTA3ZmU4Ny4uMDE0MTMxNmY4MyAxMDA2NDQgIAo+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oICAKPiBAQCAtNjE1LDcgKzYxNSw2IEBAIHR5cGVkZWYgc3RydWN0IFZURFJv
b3RFbnRyeSBWVERSb290RW50cnk7ICAKPiDCoCNkZWZpbmUgVlREX0NUWF9FTlRSWV9MRUdBQ1lf
U0laRcKgwqDCoMKgIDE2ICAKPiDCoCNkZWZpbmUgVlREX0NUWF9FTlRSWV9TQ0FMQUJMRV9TSVpF
wqDCoCAzMiAgCj4gwqAgIAo+IC0jZGVmaW5lIFBBU0lEXzDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwICAKPiDCoCNkZWZpbmUgVlREX1NN
X0NPTlRFWFRfRU5UUllfUlNWRF9WQUwwKGF3KcKgICgweDFlMFVMTCB8IH5WVERfSEFXX01BU0so
YXcpKSAgCj4gwqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMcKgwqDCoMKg
wqAgMHhmZmZmZmZmZmZmZTAwMDAwVUxMICAKPiDCoCNkZWZpbmUgVlREX1NNX0NPTlRFWFRfRU5U
UllfUFJFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwVUxMICAKPiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAKPiBpbmRleCAzNmFm
MTNjZWUzLi41ZTVkY2RjMjc0IDEwMDY0NCAgCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAKPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIAo+IEBAIC05NDEsNyArOTQxLDcgQEAg
aW50IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0
RW50cnkgKmNlLCAgCj4gwqDCoMKgwqAgZG1hX2FkZHJfdCBwYXNpZF9kaXJfYmFzZTsgIAo+IMKg
ICAKPiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7ICAKPiAtwqDCoMKgwqDC
oMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAgCj4gK8KgwqDCoMKgwqDCoMKgIHBhc2lkID0gSU9NTVVf
Tk9fUEFTSUQ7ICAKPiDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFzZSA9IFZU
RF9DRV9HRVRfUEFTSURfRElSX1RBQkxFKGNlKTsgIAo+IMKgwqDCoMKgIHJldHVybiB2dGRfZ2V0
X3BlX2Zyb21fcGFzaWRfdGFibGUocywgcGFzaWRfZGlyX2Jhc2UsIHBhc2lkLCBwZSk7ICAKPiBA
QCAtOTU4LDcgKzk1OCw3IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJ
T01NVVN0YXRlICpzLCAgCj4gwqDCoMKgwqAgVlREUEFTSURFbnRyeSBwZTsgIAo+IMKgICAKPiDC
oMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7ICAKPiAtwqDCoMKgwqDCoMKgwqAg
cGFzaWQgPSBQQVNJRF8wOyAgCj4gK8KgwqDCoMKgwqDCoMKgIHBhc2lkID0gSU9NTVVfTk9fUEFT
SUQ7ICAKPiDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFzZSA9IFZURF9DRV9H
RVRfUEFTSURfRElSX1RBQkxFKGNlKTsgIAo+IMKgICAKPiBAQCAtMTUwMSw5ICsxNTAxLDkgQEAg
c3RhdGljIGludCB2dGRfY2VfcGFzaWRfMF9jaGVjayhJbnRlbElPTU1VU3RhdGUgKnMsIFZURENv
bnRleHRFbnRyeSAqY2UpICAKPiDCoCAgCj4gwqDCoMKgwqAgLyogIAo+IMKgwqDCoMKgwqAgKiBN
YWtlIHN1cmUgaW4gU2NhbGFibGUgTW9kZSwgYSBwcmVzZW50IGNvbnRleHQgZW50cnkgIAo+IC3C
oMKgwqDCoCAqIGhhcyB2YWxpZCBwYXNpZCBlbnRyeSBzZXR0aW5nIGF0IFBBU0lEXzAuICAKPiAr
wqDCoMKgwqAgKiBoYXMgdmFsaWQgcGFzaWQgZW50cnkgc2V0dGluZyBhdCBJT01NVV9OT19QQVNJ
RC4gIAo+IMKgwqDCoMKgwqAgKi8gIAo+IC3CoMKgwqAgcmV0dXJuIHZ0ZF9jZV9nZXRfcGFzaWRf
ZW50cnkocywgY2UsICZwZSwgUEFTSURfMCk7ICAKPiArwqDCoMKgIHJldHVybiB2dGRfY2VfZ2V0
X3Bhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIElPTU1VX05PX1BBU0lEKTsgIAo+IMKgfSAgCj4gwqAg
IAo+IMKgLyogTWFwIGEgZGV2aWNlIHRvIGl0cyBjb3JyZXNwb25kaW5nIGRvbWFpbiAoY29udGV4
dC1lbnRyeSkgKi8gIAo+IEBAIC0xNTY0LDcgKzE1NjQsNyBAQCBpbnQgdnRkX2Rldl90b19jb250
ZXh0X2VudHJ5KEludGVsSU9NTVVTdGF0ZSAqcywgdWludDhfdCBidXNfbnVtLCAgCj4gwqDCoMKg
wqDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCB9IGVsc2UgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoCAv
KiAgCj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcgb2YgcGFz
aWQgc2V0dGluZyBvZiBQQVNJRF8wICAKPiArwqDCoMKgwqDCoMKgwqDCoCAqIENoZWNrIGlmIHRo
ZSBwcm9ncmFtbWluZyBvZiBwYXNpZCBzZXR0aW5nIG9mIElPTU1VX05PX1BBU0lEICAKPiDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBpcyB2YWxpZCwgYW5kIHRodXMgYXZvaWRzIHRvIGNoZWNrIHBhc2lk
IGVudHJ5IGZldGNoaW5nICAKPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXN1bHQgaW4gZnV0dXJl
IGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLiAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgICovICAKPiBA
QCAtMjEyMiw3ICsyMTIyLDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShW
VERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsICAKPiDCoMKgwqDCoCB2dGRfaW9t
bXVfbG9jayhzKTsgIAo+IMKgICAKPiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lE
ICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsgIAo+IC3CoMKgwqDCoMKgwqDCoCBwYXNpZCA9IFBBU0lE
XzA7ICAKPiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01NVV9OT19QQVNJRDsgIAo+IMKgwqDC
oMKgIH0gIAo+IMKgICAKPiDCoMKgwqDCoCAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZyb20gSU9UTEIg
Ki8gIAo+IEBAIC0yNDg3LDcgKzI0ODcsNyBAQCBzdGF0aWMgdm9pZCB2dGRfaW90bGJfZG9tYWlu
X2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQpICAKPiDC
oH0gIAo+IMKgICAKPiDCoC8qICAKPiAtICogVGhlcmUgaXMgbm8gcGFzaWQgZmllbGQgaW4gaW90
bGIgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IsIHNvIFBDSV9OT19QQVNJRCAgCj4gKyAqIFRoZXJl
IGlzIG5vIHBhc2lkIGZpZWxkIGluIGlvdGxiIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yLCBzbyBJ
T01NVV9OT19QQVNJRCAgCj4gwqAgKiBpcyBwYXNzZWQgYXMgcGFyYW1ldGVyLiBQaW90bGIgaW52
YWxpZGF0aW9uIHN1cHBvcnRzIHBhc2lkLCBwYXNpZCBpbiBpdHMgIAo+IMKgICogZGVzY3JpcHRv
ciBpcyBwYXNzZWQgd2hpY2ggc2hvdWxkIG5vdCBiZSBQQ0lfTk9fUEFTSUQuICAKPiDCoCAqLyAg
Cj4gQEAgLTI1MDgsMTAgKzI1MDgsMTAgQEAgc3RhdGljIHZvaWQgdnRkX2lvdGxiX3BhZ2VfaW52
YWxpZGF0ZV9ub3RpZnkoSW50ZWxJT01NVVN0YXRlICpzLCAgCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiBJbiBsZWdhY3kgbW9kZSwgdnRkX2FzLT5wYXNpZCA9PSBwYXNpZCBpcyBhbHdh
eXMgdHJ1ZS4gIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSW4gc2NhbGFibGUgbW9k
ZSwgZm9yIHZ0ZCBhZGRyZXNzIHNwYWNlIGJhY2tpbmcgYSBQQ0kgIAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogZGV2aWNlIHdpdGhvdXQgcGFzaWQsIG5lZWRzIHRvIGNvbXBhcmUgcGFz
aWQgd2l0aCAgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFBBU0lEXzAgb2YgdGhpcyBk
ZXZpY2UuICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSU9NTVVfTk9fUEFTSUQgb2Yg
dGhpcyBkZXZpY2UuICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLyAgCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKHZ0ZF9hcy0+cGFzaWQgPT0gcGFzaWQgfHwgIAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh2dGRfYXMtPnBhc2lkID09IFBDSV9O
T19QQVNJRCAmJiBwYXNpZCA9PSBQQVNJRF8wKSkpIHsgIAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICh2dGRfYXMtPnBhc2lkID09IFBDSV9OT19QQVNJRCAmJiBwYXNpZCA9
PSBJT01NVV9OT19QQVNJRCkpKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250aW51ZTsgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gQEAg
LTI1NjMsNyArMjU2Myw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGUo
SW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsICAKPiDCoMKgwqDCoCB2dGRf
aW9tbXVfbG9jayhzKTsgIAo+IMKgwqDCoMKgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZShz
LT5pb3RsYiwgdnRkX2hhc2hfcmVtb3ZlX2J5X3BhZ2UsICZpbmZvKTsgIAo+IMKgwqDCoMKgIHZ0
ZF9pb21tdV91bmxvY2socyk7ICAKPiAtwqDCoMKgIHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGVf
bm90aWZ5KHMsIGRvbWFpbl9pZCwgYWRkciwgYW0sIFBDSV9OT19QQVNJRCk7ICAKPiArwqDCoMKg
IHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGVfbm90aWZ5KHMsIGRvbWFpbl9pZCwgYWRkciwgYW0s
IElPTU1VX05PX1BBU0lEKTsgIAo+IMKgfSAgCj4gwqAgIAo+IMKgLyogRmx1c2ggSU9UTEIgIAo+
IEBAIC0zMDIyLDcgKzMwMjIsNyBAQCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lkX2ludmFs
aWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCAgCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZ0ZF9k
ZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksICAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYgIAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRfYXMt
PnBhc2lkKSkgeyAgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2dGRfYXMtPnBhc2lk
ICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSBQQVNJRF8wKSAmJiAgCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAh
PSBJT01NVV9OT19QQVNJRCkgJiYgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnRpbnVlOyAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gIAo+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11
X2FjY2VsLmMgIAo+IGluZGV4IGJkMTIzNmMwNzAuLjg5NDBkMjQwYTEgMTAwNjQ0ICAKPiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIAo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfYWNjZWwuYyAgCj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCB2dGRfZmx1c2hf
aG9zdF9waW90bGJfbG9ja2VkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsICAKPiDCoCAg
Cj4gwqDCoMKgwqAgZGlkID0gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgmcGNfZW50cnktPnBhc2lk
X2VudHJ5KTsgIAo+IMKgICAKPiAtwqDCoMKgIGlmIChwaW90bGJfaW5mby0+ZG9tYWluX2lkID09
IGRpZCAmJiBwaW90bGJfaW5mby0+cGFzaWQgPT0gUEFTSURfMCkgeyAgCj4gK8KgwqDCoCBpZiAo
cGlvdGxiX2luZm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lkID09IElP
TU1VX05PX1BBU0lEKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIEhvc3RJT01NVURldmljZUlPTU1V
RkQgKmhpb2RpID0gIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIT1NUX0lPTU1VX0RFVklD
RV9JT01NVUZEKHZ0ZF9oaW9kLT5oaW9kKTsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qg
ZW50cnlfbnVtID0gMTsgLyogT25seSBpbXBsZW1lbnQgb25lIHJlcXVlc3QgZm9yIHNpbXBsaWNp
dHkgKi8K

