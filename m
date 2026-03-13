Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B063105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13mm-0007Nb-48; Fri, 13 Mar 2026 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13mT-0007Ms-Hb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:46:27 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13mQ-0007Cj-KX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773413182; x=1804949182;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xnGTp9RDRnVLmPse94UymrxCzmBQv2lVR1qxywcdUxU=;
 b=UywWXqEjFVUKt5IDiM3nkN3Win35xrA1B/P4o3nbCOhAeSLb9Ylk4CPZ
 qZlqR78rftMq9xzlFln2yXe1i5Fq8b1aIDvBpCZ9u2pp46NWTD1pgYwt3
 SrMJFX3/1fI8ixKXFbUGMX2S1elyB0Cv8Qf44qKHMMnkxIHiJ2evPvgFB
 uTJpYHDs71Sh89LD5Skmg2NF5o6e9qVE6pUDKDeZgm9T3z2Ee1S2dlbCT
 3icF3Yk3AKW7vvDd8JZAMjh2T+p0v+dTa8b/lhMlItrWO7LPw4EWlLQbQ
 io9jkzafP0WKTciDv0V9QzhXdpM3hqWa/WJEIc5ihoa4iIJhJcu/LiywE g==;
X-CSE-ConnectionGUID: gCIvtMZQTC+8//k7YgLiUA==
X-CSE-MsgGUID: pQ2ppu3aT3y8l6UumbAdag==
IronPort-SDR: 69b42338_C24KBunLnstSGPBqxaa3QAt6NtjvyccFLq2WWoBW/YU2Ze+
 YHN5YYXMij5ai0HQPeZE52FHHo9LukedVdKRXEg==
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; d="scan'208";a="49105885"
X-MGA-submission: =?us-ascii?q?MDEwAQpb+S5oi+w3/0gst6EaX3N8KcMCuAHbqx?=
 =?us-ascii?q?zEn/KEBXpK0qK0wwJIqDaCtqIOO69UB/eiftprkmFCBc5yqLYjHQLJLC?=
 =?us-ascii?q?nE4ZCvKSTBWKGEOH0I2R+brEosUW9J+cw6+I8HVNOTAy9nTmPE6USTB6?=
 =?us-ascii?q?Xvy7VtbEH8+nDRF+pTqY1n6Q=3D=3D?=
Received: from mail-westeuropeazon11010031.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.31])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Mar 2026 15:46:16 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qekyZsKV1myP3M03lDAaDq8SqyhxvDgZ7krklTMcKLiu7TcWaBulwl7DaswSkyYNWWI1W4Frc7yKIVttJ1YYrhddo7+7U3eRh33wn29p/TCAQbKt6qsoWlw34TEfSSQD5Em0y/Mv7rzwRtkU+94lRN6fugYDK0kTrSSDHk4iNSdFcbNxlVBi65RxihS3T66BMsjL0DoVGUluaEgKwKFR/PqUf8+yN/PZGe6N5U04yAPPZmyz+gq7GjZMCB/LsfwYxyMUcAQLnvZ6aHYoOy24/QFikDIw9cTQldnOzeCqD1WYvNDXmmQaGzmxESNf0cPC4Kjn6bwLrfFgJcTnlKkQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnGTp9RDRnVLmPse94UymrxCzmBQv2lVR1qxywcdUxU=;
 b=lLjKgqRMzsgM0cNaF8Zirf6oNIDXidydpbGLDhtw0xIfTHwCLxgJFWOl1iCe63D7hLdW02JAY8Fl9l8ZvLcpTTQLsbBhbX7tsrot+ce7IxKoV1DrpVXiEZDi1bSjZjGZwuCybURGKTi0hbS1r0FHDIA8C2qFkbrH20YjAUTh4V24JPSbRxm47zwDf8IIErioF0A++G85np/HySf5Ih5uO6jsk7osKiFoHYTNTB7z23TZZoPzWvUdxluk/v36lBxLFzVapNJ9cgqiacDjKPsMrClXYU2hCU95RlCNL4VGYteKfGy0sNpBicqKVJajZxTvbg46X/J3xF21Y2Y3EskWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB10058.eurprd07.prod.outlook.com (2603:10a6:20b:683::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Fri, 13 Mar
 2026 14:46:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:46:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: Yi Liu <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
Subject: Re: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Topic: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Index: AQHcsFskubOEgFc8HEeHP9N2sSLBHrWqQIEAgAAvLACAAbVQAIAAanKA
Date: Fri, 13 Mar 2026 14:46:13 +0000
Message-ID: <e30107f96aa82e1dff5e5e3ed81ecc2a28c93e44.camel@eviden.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
 <0478ab32-cec0-4872-ad09-340a73cce7eb@intel.com>
 <ca81cba3d96c61558ff3058b6deeff3b7716b658.camel@eviden.com>
 <dca00276-bf80-4cea-81b4-4f81c96d9a2e@intel.com>
In-Reply-To: <dca00276-bf80-4cea-81b4-4f81c96d9a2e@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB10058:EE_
x-ms-office365-filtering-correlation-id: e91b9b14-37f0-4cfa-8716-08de810f4620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: L3TqgPLJR7vB5h18YMWLRjk28H8Halol2Jh56Fyz8dCvhlc9oL8J9M1IEM+gcfo/m9wbQ/4E7Ux9TD1Cv5uxYNsj+UTTR340IUXfPr/W4nLSqsT7nRU/2CBGfs30ojXIyUEUmLA0E81ITBMCu+d8DSmcHX8KDWVnktTij6Nl5ZKNzih+ySEjFL4XrrMeIvMTjdDu3WdOmZ7boDTPg39Rlu0eoM3t4FlGPCuUykawFM4fg3EXTNhF0CHnmvb3RyKweaO4/iU98ZHQDTJMUuN9zN7Vg9eu7kbUabMBOo2QmQQTK3KOJla/8iZUkbjP2YMoSolHoP71CcUKG6TEhRV54TSs/NMh/OxKIzoBP9Ot4xdq/oEAwG1IdizOyXQFdHYecZjZersQrkR2gHLc8znrZJKTWmaLulPJHJLRrl88WD6baoNqq0Lc7hfJuqB+VK14qAIOLYVZK0r2v0pq+j4n/2VDK7As9k1QM+IIBjQLSeydNZolkAkWYIiqzXvxseFVHs5wOZHzp94gSGflfLeY2rVo+V9UmZRKVME+eUQRCeMy4gmCEgjqrA80RNMxsE+7/JwV6SUJJ+IKWTvOU/V+LaZhAJhUnGlb+BNdpIQNt9ayYfuB1SbooYjLQVIgOdAgXrbCxmxbfmLjPcjgUAjgOL8pRFR5VNF1ISO6WDXBMdoMozcPzOCbVaqXFF2Xq1uQVRAqeOhT7sNGbNfuJvCCaLWwHfQTnHmfyezP7lndBWKVIoYN7UubY5dNJay/MLGRHHuQ1EGPEUX3MO1tkHOFZZBwuH/IlR2Y69gtKrez/Ng=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVdyS3QwU3pJSVRIVW4zdjAxZkp5Wjh0WFRLRTRMTldCTi9OaUZUT3pRREdR?=
 =?utf-8?B?eE5SRHNBc0k1OC9YZm5oVDZqbTNrR0NYZjlINk9NUVZIWi9RZXIrNGoxdDhh?=
 =?utf-8?B?bkoxVldrSGF5MUV0Yk5pUDQyYmtqcE5GNGFFa2hTVTVYMnhGL2lXRkQ3Y1lh?=
 =?utf-8?B?aG41V2k0dGRtbDNoUzNrTkpsOWloNW80RmdrQm9FWTkxRHIwS0k2cmdOQldk?=
 =?utf-8?B?cUxlQ0pTczRjeEZ5WUdZZFgxbllkVzhpUVptdGw4Nzhkd3hYaTBONmhmQkln?=
 =?utf-8?B?ZmQxdWVCeFZKKzFVY1Q3SmRKSG5seEs1NmdSTGhBN3AwbitQZFFZbWxWMnJF?=
 =?utf-8?B?ZVE0WUxzWm4zSXRmbGJZWU95MGhSQit1YTM0dk9GQmwxcHBtWU5mNk9kS09n?=
 =?utf-8?B?di8wMSt3by9tWmUzVTR6aDVtUzZFSllKOG0rQ0tub0dPV3N3Mi9HWTlYM283?=
 =?utf-8?B?NndZMVFGa3g0QytRZE1pcm9ha3RJVjc0TGZXdmh3LzlXZVV4VlBNTC9icmFD?=
 =?utf-8?B?THE5WVc1SXNiM0lONDZOTCszSXIvcy9IZ2FlbHNMeG5rbWo2WHl4ZGhJc0d0?=
 =?utf-8?B?b0pYVG1VRVBZRXBFUkxLajVBS2kvWmZ5aUpEZmVMR3VyODhONkwrb0RuY1V6?=
 =?utf-8?B?RzJ4MTVTTnBWc0xUaTkrSkc0RG1PUkE3Nlc3NmhsQi91U3hqbmRtUUdETzZU?=
 =?utf-8?B?SHN5VGtOT0ZLOUFaeXZOaHMreVhyQk1ISVpTQzlka3FjcWt3MnVyV3QzWU5J?=
 =?utf-8?B?b2pITWRyMFlTM2hQVVZSOUtibGVrQkpzNW1jcWt1b1Z0Ri90VTBXeUJQRnd3?=
 =?utf-8?B?dVZIQ2tXMm0wdjJWaWRRUmNhNzR2a214Zy9FWndrRkZqTzhkd3BuWmRsUExP?=
 =?utf-8?B?T3loWDJDMDNGR1QxenFWaHdrbVR4dFZVdTdYLzFjcmdRaHBTYnZZVGpCeVAw?=
 =?utf-8?B?SUFReXptS1RjVFhCQUxidFNtT2d5SHlnZzFPUjVUcUpnMlNXV3pkWC9tYzUz?=
 =?utf-8?B?cFBhYjFpWWFvMTVhbUFqTnZ5SFhneEc5NlBWbkFoc2xtWnNEdHN1UGZZRURt?=
 =?utf-8?B?Y1R3RVNGVDdQNVorOEo4ZXQza3IzUHhBK2JPRVVOMTI3SmpycFl6WkY3bm1R?=
 =?utf-8?B?UWNhTFdSQmpCMHA0Njh6VlYvRGdiU1R5cEhrdGs1Z01JMXlXamM5bHJuKzNm?=
 =?utf-8?B?MHdDNXdsU3Y3cUpZZGkxY1paSW42Yjd0aXBQV2JGdmFEZ1VVWE0vNWwySmlV?=
 =?utf-8?B?cUFlcHB6ZmZQS0JjcENUeU5wZHpKcDdLUzBja2l6RnB1d2FkOS9hVTZFQ0ZB?=
 =?utf-8?B?T3R3dTlPRmRxK0JRSGlsaUpwc2FGajZDRzFZZDNRMmVuQmdrTDJIcE5ieWEr?=
 =?utf-8?B?MGE4NHdoNG5GbFZOWTA2c0lEdGJCUzVJUFJuOFVxY28zNGtjemhUT3BlM2Rq?=
 =?utf-8?B?K0l2VWRNZHZaZlE5c0hlbm1zdDdaQkNidU9NQ0REemtyRjlrTzg3a0M1S3M2?=
 =?utf-8?B?Qmd3a1lhZjlmL3ZtR0J4T0xSQ1cyY0F4MkI4VTdXRjVaNXVRT0Q3SU9ONjFG?=
 =?utf-8?B?WG44Y1NrL2ZaWU5ldi84REpHdHN6WmZrVE5BL1VyNmdoTDFLZlBLYndMYUZl?=
 =?utf-8?B?WkE2TFJhaGZZVTZxdGVQZ1VXQ056Q3J6TlRQZEhrREJSa1NUSkpoTGIwY2J6?=
 =?utf-8?B?SW5wTDZyRWFlY3VOL0xOcERrNXpSeUZjWTJadWtoL1U4NEVMbGoyelBySkhy?=
 =?utf-8?B?VVRnWVNiL1VyMi9tVGFRK2s4VzAyMnlvSUVRTm9VOGQwbC9DUU5KRTB5TzJV?=
 =?utf-8?B?M2JpZEJTLzJyaGQ0aDRZK2dlZjNYQVgxYkZGWTJLek0yRnNrNzFVUHJuVUNX?=
 =?utf-8?B?N3BHb1puSWNxQXVMQ0c4K1BuNWZNK3RrOE00cDdVek0wR3pSS0dMRHhhSjlz?=
 =?utf-8?B?VVJJWFpnb0tTWVFDQWJnWk1jMmtFSXIxeVEwQ1Zmbnl4RWY0Ui9EUDBCM01i?=
 =?utf-8?B?b1ZKTlNFdVQ5Q1UzcUI3b0FpNC9hb2tHTUxYYnZDM0lzT3ZlVVh0b1NaUXFy?=
 =?utf-8?B?bGxieEhhdEFoclRiSlFodmVtOStnVGNiYWZ0RCtWeHZrMEpFdWtESzZ4Qkc0?=
 =?utf-8?B?UjhLRCtadmp2ZThsOXBqakUvMmpMYVk4MXByWXd0ZkVnaHhlZmZ4aDFkNWN2?=
 =?utf-8?B?ekEwV2EwamhJVm9xeW9VeEVTc2RCWTZTZnBTaGJsMWo4Uktqd29kOEM0OVZv?=
 =?utf-8?B?MitkSFRzRFhCYUpjVmhaeGlrbUpBYzZrTTJHbHNhSHJQUTJIK3VZcmlsOHFk?=
 =?utf-8?B?b0FxODJ3TS8yODRBYkVheXl5L1pZNEFFbWhUOWVlMWo5UFQzN3VNN0YzN2dE?=
 =?utf-8?Q?78KN5HAXxWSLJSzSfygsSwfpNSsESCO+d9W8W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36A83240F5CA064295E5E695003BB043@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rXzOyFW42Fz3ZcmBw0AOPGbcpLcu8jOo0DVkyYB/BwZXj7lM2+Z5S0Ww+HkZ4MMQxzpwruxUfXL03pu4QafmXpTWrKvrmdSrZHl+TquBNckZwjolWFRPOIZHDRP7G3LKX41tcELhaCluqGinXBrP0dd0m3JS4Loa+4CIidVpmoVwp+m8D7wPGMQ4UC9tED8+b/mdJnZvlKKt1bGFOz8RsQ8iaYrBYeIwSkashoeLG9IrkJWq6z5lNWwt8yflQjj9Uq5NP0lmUcsjFcfMNcR1eMKC2vMYHOiXqX18zB1RI6c/7Q5ROEqpoiAwV8D+OMBUAS7GJdw1iIxWyhgnGVh8bg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91b9b14-37f0-4cfa-8716-08de810f4620
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:46:13.3808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50W5ULdU9GN1FB4wRzvkr0DIuTya0ayQFvNdaK6jri/q3Q1mPszrR6/EYf3Gxlu+im1pRrC5IU3H9kROvVHu/atiVi+wNSmR0ZECZCBcLBNM3SUoiLwaIdR2P1VWAsfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10058
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQpPbiBGcmksIDIwMjYtMDMtMTMgYXQgMTY6MjQgKzA4MDAsIFlpIExpdSB3cm90ZToNCj4gT24g
My8xMi8yNiAxNDoyMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiANCj4gPiBIaSBZ
aSwgWmhlbnpob25nLA0KPiA+IA0KPiA+IE1vcmUgZGV0YWlscyBoZXJlOiBbaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC9uZXh0L3g4Ni9zaHN0ay5odG1sXShodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL25leHQveDg2L3Noc3RrLmh0bWwpDQo+ID4gDQo+ID4gRHVyaW5nIG15
IGRlYnVnZ2luZyBzZXNzaW9ucywgSSBnb3QgdGhlIGZvbGxvd2luZyBmbG93Og0KPiA+IA0KPiA+
IC0gRGV2aWNlIHNlbmRzIGFuIEFUUyByZXF1ZXN0IHRvIHRoZSBJT01NVSB3aXRob3V0IHRoZSBu
by13cml0ZSBmbGFnIChzbyBpdCByZXF1ZXN0cyBSVyBwZXJtaXNzaW9ucykNCj4gPiAtIElPTU1V
IHdhbGtzIHRoZSBmaXJzdCBzdGFnZSBwYWdlIHRhYmxlLCBmaW5kcyB0aGUgbGFzdCBwdGUgYW5k
IG5vdGljZXMgdGhhdCB0aGUgVyBwZXJtaXNzaW9uIGlzIG5vdCBzZXQgKEkga25vdyB0aGlzIHBh
Z2Ugbm90IHJlYWxseSBSTywgSSBwcmVwYXJlZCBpdCB0byBtYWtlIHN1cmUgaXQgaXMgQ09XKQ0K
PiA+IC0gQmVjYXVzZSBvZiB0aGUgY29uZGl0aW9uIEkgdXBkYXRlIGluIHRoZSBwYXRjaCwgdGhl
IElPTU1VIHNldHMgdGhlIGRpcnR5IGJpdCBkZXNwaXRlIHRoZSBhYnNlbmNlIG9mIHRoZSBSL1cg
Yml0DQo+ID4gLSBUaGUgZGV2aWNlcyBnZXRzIHRoZSB0cmFuc2xhdGlvbiBjb21wbGV0aW9uIGFu
ZCBkZWNpZGVzIHRvIGlzc3VlIGEgUFJJIHJlcXVlc3QNCj4gPiAtIFRoZSBrZXJuZWwgcnVucyB0
aGUgaGFuZGxlciwgc2NoZWR1bGVzIHRoZSB3b3JrLCBhbmQgZW5kcyB1cCBjYWxsaW5nIGlvbW11
X3N2YV9oYW5kbGVfbW0gKHdpdGggZmxhZyBGQVVMVF9GTEFHX1dSSVRFKQ0KPiA+IC0gSXQgdGhl
biBjYWxscyBoYW5kbGVfbW1fZmF1bHQsIF9faGFuZGxlX21tX2ZhdWx0IGFuZCBoYW5kbGVfcHRl
X2ZhdWx0DQo+ID4gLSBJbiBoYW5kbGVfcHRlX2ZhdWx0LCBpdCBydW5zIHRoZSBmb2xsb3dpbmcg
ZnJhZ21lbnQ6DQo+ID4gDQo+ID4gYGBgDQo+ID4gaWYgKHZtZi0+ZmxhZ3MgJiAoRkFVTFRfRkxB
R19XUklURXxGQVVMVF9GTEFHX1VOU0hBUkUpKSB7IC8qIFRoaXMgaXMgdHJ1ZSAqLw0KPiA+IAlp
ZiAoIXB0ZV93cml0ZShlbnRyeSkpDQo+ID4gCQlyZXR1cm4gZG9fd3BfcGFnZSh2bWYpOw0KPiA+
IAllbHNlIGlmIChsaWtlbHkodm1mLT5mbGFncyAmIEZBVUxUX0ZMQUdfV1JJVEUpKQ0KPiA+IAkJ
ZW50cnkgPSBwdGVfbWtkaXJ0eShlbnRyeSk7DQo+ID4gfQ0KPiA+IGBgYA0KPiA+IA0KPiA+IC0g
cHRlX3dyaXRlIGlzIGRlZmluZSBhcyBmb2xsb3dzDQo+ID4gDQo+ID4gYGBgDQo+ID4gaW50IHB0
ZV93cml0ZShwdGVfdCBwdGUpDQo+ID4gew0KPiA+IAkvKg0KPiA+IAkgKiBTaGFkb3cgc3RhY2sg
cGFnZXMgYXJlIGxvZ2ljYWxseSB3cml0YWJsZSwgYnV0IGRvIG5vdCBoYXZlDQo+ID4gCSAqIF9Q
QUdFX1JXLsKgIENoZWNrIGZvciB0aGVtIHNlcGFyYXRlbHkgZnJvbSBfUEFHRV9SVyBpdHNlbGYu
DQo+ID4gCSAqLw0KPiA+IAlyZXR1cm4gKHB0ZV9mbGFncyhwdGUpICYgX1BBR0VfUlcpIHx8IHB0
ZV9zaHN0ayhwdGUpOw0KPiA+IH0NCj4gPiANCj4gPiBib29sIHB0ZV9zaHN0ayhwdGVfdCBwdGUp
DQo+ID4gew0KPiA+IAlyZXR1cm4gY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNU
SykgJiYNCj4gPiAJwqDCoMKgwqDCoMKgIChwdGVfZmxhZ3MocHRlKSAmIChfUEFHRV9SVyB8IF9Q
QUdFX0RJUlRZKSkgPT0gX1BBR0VfRElSVFk7DQo+ID4gfQ0KPiA+IGBgYA0KPiA+IA0KPiA+IC0g
VGhlIHB0ZSBoYXMgRD0xIFc9MCBzbyB0aGUgZmlyc3QgaGFsZiBvZiB0aGUgcHRlX3dyaXRlIGNv
bmRpdGlvbiBpcyBmYWxzZQ0KPiA+IC0gQXMgdGhlIENQVSBJIHVzZWQgZm9yIHRlc3RpbmcgaGFz
IHRoZSBzaHN0ayBmZWF0dXJlLCBwdGVfc2hzdGsgaXMgdHJ1ZQ0KPiA+IC0gSGVuY2UsIHB0ZV93
cml0ZSBpcyB0cnVlLCB3aGljaCBtZWFucyB3ZSB3aWxsIHJ1biBgZW50cnkgPSBwdGVfbWtkaXJ0
eShlbnRyeSk7YCBpbiBoYW5kbGVfcHRlX2ZhdWx0DQo+ID4gLSBBZnRlciB0aGUgZmF1bHQgaGFu
ZGxlciBoYXMgY29tcGxldGVkLCB0aGUgd3JpdGUgcGVybWlzc2lvbiBpcyBzdGlsbCBub3QgZ3Jh
bnRlZA0KPiA+IC0gVGhlIFBSSSByZXF1ZXN0IHJldHVybnMgYSBzdWNjZXNzIGNvbXBsZXRpb24g
Y29kZQ0KPiA+IC0gRGV2aWNlIHJlcXVlc3RzIHRoZSB0cmFuc2xhdGlvbiBhZ2FpbiB0byB0aGUg
SU9NTVUsIGFuZCBnb2VzIGJhY2sgdG8gdGhlIGZpcnN0IHN0ZXAsIHRyYXBwZWQgZm9yZXZlci4N
Cj4gPiANCj4gPiBOb3RlIHRoYXQgdGhlIHNlY29uZCBwYXRjaCB5b3UgcmV2aWV3ZWQgd2FzIG1h
c2tpbmcgdGhpcyBiZWhhdmlvciBhcyBpdCB3YXMgcHJldmVudGluZyB0aGUgZGlydHkgYml0IGZy
b20gYmVpbmcgYWRkZWQgdG8gdGhlIHB0ZSBtb3N0IG9mIHRoZSB0aW1lLg0KPiA+IFRoaXMgaXMg
dGhlIHJlYXNvbiB3aHkgSSBmaXggdGhlbSBpbiB0aGlzIG9yZGVyIG8uTw0KPiANCj4gDQo+IFVu
ZGVyc3Rvb2QuIFlvdSBtYXkgd2FudCB0byByZWZpbmUgdGhlIGNvbW1pdCBtZXNzYWdlIHNsaWdo
dGx5LiBJbiBteSAgDQo+IG9waW5pb24sIHJlZ2FyZGxlc3Mgb2YgYW55IGJ1Z3MsIGl0J3MgZXNz
ZW50aWFsIHRvIHNldCB0aGUgZGlydHkgYml0ICANCj4gb25seSB3aGVuIHdyaXRlIHBlcm1pc3Np
b24gaXMgZ3JhbnRlZCBBTkQgdGhlIGRldmljZSByZXF1ZXN0cyB3cml0ZSBhY2Nlc3MuDQoNClll
cywgdGhhdCdzIG15IHVuZGVyc3RhbmRpbmcgYXMgd2VsbA0KDQo+IA0KPiBJZiB5b3Ugd2lzaCB0
byBoaWdobGlnaHQgdGhlIHNwZWNpZmljIGlzc3VlOiBzZXR0aW5nIHRoZSBkaXJ0eSBiaXQgIA0K
PiB3aXRob3V0IHRoZSB3cml0ZSBiaXQgaW4gdklPTU1VIGNyZWF0ZXMgYSBzcG9vZmVkIHNoYWRv
dyBzdGFjayBQVEUgdGhhdCAgDQo+IG1pc2xlYWRzIHRoZSBndWVzdCBPUy4gVGhpcyByZXN1bHRz
IGluIGluZmluaXRlIFBSSSByZXF1ZXN0cyBmcm9tIHRoZSAgDQo+IGRldmljZSwgYXMgbm8gYWN0
dWFsIHdyaXRlIHBlcm1pc3Npb24gaXMgZXZlciBncmFudGVkIC0gdGhlIGd1ZXN0IE9TICANCj4g
dHJlYXRzIHRoZSBQVEUgYXMgYSBsZWdpdGltYXRlIHNoYWRvdyBzdGFjayBlbnRyeSBhbmQgY29u
c2lkZXJzIHRoZSAgDQo+IHBlcm1pc3Npb25zIGFscmVhZHkgY29ycmVjdC4NCg0KQ3J5c3RhbCBj
bGVhciwgd2lsbCByZXBvc3Qgd2l0aCB0aGUgdXBkYXRlZCBtZXNzYWdlDQoNCj4gDQo+IA0KPiA+
IE9uIFRodSwgMjAyNi0wMy0xMiBhdCAxMTozMCArMDgwMCwgWWkgTGl1IHdyb3RlOg0KPiA+IA0K
PiA+ID4gT24gMy8xMC8yNiAxNDo1NywgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+ID4gQXZvaWQgdW5pbnRlbnRpb25hbGx5IGZsYWdnaW5nIHRoZSBl
bnRyeSBhcyBhIHNoYWRvdyBzdGFjayBlbnRyeS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4g
PiA+IGhtbW0uIG5vdCBxdWl0ZSBnZXQgc2hhZG93IHN0YWNrLi4uDQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiA+IEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUgZGlydHkg
Yml0IGlzIGFsd2F5cyBzZXQgaW4gdGhlIHB0ZS4NCj4gPiA+ID4gSGVuY2UsIGFuIEFUUyBkZXZp
Y2UgcmVxdWVzdGluZyBhbiBSVyB0cmFuc2xhdGlvbiBmb3IgYSBjb3B5LW9uLXdyaXRlDQo+ID4g
PiA+IHBhZ2UgaXMgbGlrZWx5IHRvIHRyaWdnZXIgYSBQUkkgcmVxdWVzdCBmb3IgYSByZWdpb24g
dGhhdCBoYXMganVzdCBiZWVuDQo+ID4gPiA+IG1hcmtlZCBhcyBkaXJ0eSBieSB0aGUgSU9NTVUu
IEhvd2V2ZXIsIENQVXMgdGhhdCBzdXBwb3J0IHNoYWRvdyBzdGFja3MNCj4gPiA+ID4gZ2l2ZSBz
cGVjaWFsIG1lYW5pbmcgdG8gUFRFcyByZXBvcnRpbmcgVz0wIGFuZCBEPTEuIFNldHRpbmcgdGhl
c2UgdmFsdWVzDQo+ID4gPiA+IGNhbiBjYXVzZSBQUkkgcmVxdWVzdHMgdG8gY29tcGxldGUgc3Vj
Y2Vzc2Z1bGx5IHdpdGhvdXQgZ3JhbnRpbmcgdGhlDQo+ID4gPiA+IGV4cGVjdGVkIHdyaXRlIHBl
cm1pc3Npb24sIHdoaWNoIGxlYWRzIHRoZSBkZXZpY2UgdG8gZW50ZXIgYW4gaW5maW5pdGUNCj4g
PiA+ID4gbG9vcCBvZiBBVFMvUFJJIHJlcXVlc3RzLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gYXBwcmVjaWF0ZSBhIGNsZWFyZXIgZXhwbGFuYXRpb24gaGVyZS4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBGaXhlczogNjVjNGYwOTk5OTkxICgiaW50ZWxf
aW9tbXU6IFNldCBhY2Nlc3NlZCBhbmQgZGlydHkgYml0cyBkdXJpbmcgc3RhZ2UtMSB0cmFuc2xh
dGlvbiIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8W1tj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAYnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFp
bHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSkpPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gwqDCoCBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyICstDQo+ID4gPiA+IMKgwqAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+ID4gPiA+IGluZGV4IGQyNGJhOTg5YmYuLjU2MTQ2YWFmYzEgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gPiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4gPiA+ID4gQEAgLTIwNjYsNyArMjA2Niw3IEBAIHN0YXRpYyBpbnQgdnRkX2lv
dmFfdG9fZnNwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtVlREX0ZSX0ZTX1BBR0lO
R19FTlRSWV9SU1ZEOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IMKg
wqAgDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCBpZiAodnRkX2lzX2xhc3RfcHRlKGZzcHRlLCAq
ZnNwdGVfbGV2ZWwpICYmIGlzX3dyaXRlKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
dnRkX2lzX2xhc3RfcHRlKGZzcHRlLCAqZnNwdGVfbGV2ZWwpICYmICp3cml0ZXMgJiYgaXNfd3Jp
dGUpIHsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFnX2FkIHw9IFZU
RF9GU19EOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IMKgIA0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gdGhlIGNoYW5nZSBsb29rcyByZWFzb25hYmxlLg0K
PiA+DQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IFlpIExpdSA8W3lpLmwubGl1QGludGVsLmNvbV0o
bWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+DQo+IA0KPiA=

