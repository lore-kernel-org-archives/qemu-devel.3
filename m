Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61EAF419A0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzum-0001Et-G0; Wed, 15 Apr 2026 09:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wCzuj-0001Ed-7x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:04:17 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wCzuf-0007Ow-34
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1776258253; x=1807794253;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q5KE/B8fpCzRC+j5REjVqOl7APTVQSfyesdaTA4w1t4=;
 b=DFzT9Ma7/6SX9JBFulCl1B2uPzb2dzrGAXibMV+kFdbMW+3lsnhdS3gK
 Eva5Qd099WTA1iqdlXCAkscoppC9MVs1JdKkFH2aCgHkRk/RTfc1JqTVF
 8bNHU6xZrYTUqm+CLxR53Ad0E/sWEHPtVqiQyeWfv4aiU9HmJ95baYPL4
 akDTgNr+IiXy04xV2lUyqKPOwf2C/uhihI0tutR14y7vYShWGMBuTxgNl
 CfDhL1fffqz0LXLWFo5DK6D7ynj07Jvk0f2SFH0yqQ//+EP/2neRpnHUQ
 wEwahji27nKmtoofsult8Li8O9GW7tjf/t/SN/htx4bxmITHKcRrgw+hH g==;
X-CSE-ConnectionGUID: qgbY0sF7Swqq63UWxdlM1A==
X-CSE-MsgGUID: lAZQCQyzQeCOv2VO3hDJNw==
IronPort-SDR: 69df8cc7_VxgdSacb9zLvCFLi7CxuB6VNRXJw5rCWRZ6wqo3vWQOElh3
 cc9y7bMnIoCsjFEHgHni1H/DsDEB0HtqeWmM1MA==
X-IronPort-AV: E=Sophos;i="6.23,179,1770591600"; d="scan'208";a="47537657"
X-MGA-submission: =?us-ascii?q?MDG1Od/WvYN5cIm9xxdVk1mAkUH9g3nJXdUqoe?=
 =?us-ascii?q?i0rJ57/M0JvsvKh2D0PJSYaFq3aaEOLkOFxAKieFPCi5UZfoaRiUv4R7?=
 =?us-ascii?q?jyoIf9xtgc7oIzK6qs9g/lajK2GHf1fkxREKjy1ikIf5K/Ru47wX5Hb4?=
 =?us-ascii?q?Xfn1pgN4d1TvOJn1ZtjyMZ2g=3D=3D?=
Received: from mail-westeuropeazon11013061.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.61])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2026 15:04:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rmx/2O2WI73um4O8Nyhm3Lvm1o0IBkDG3tu8lHXU1raw8szCD1fhyrZosHmbwkW097Y+sfV/Xcp1iCghSTof4t6t75VDvgAK/U/1j0KUgGndPHv0RGXdnqiwRlLCi7ROFBcCseH1uF2LXKDhV+XPf0Cz9CRgvjz5yonccHWzaQDmKrLi5cWIoLlRNcvefJ6roQaFOmJ4YZ63lwwDfu2kD6qRULvnHsHXuLzgaBZlafFXjFn8l9r0XbM6XHlnzb1otuWs2k/pVFHI/LhhICMg3ovy9IwBPAkQq4BkDKpnD4E3LK8F4Kh2ahW7iUBK74Gn4P9kurfg2AtvPKN+3mofYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5KE/B8fpCzRC+j5REjVqOl7APTVQSfyesdaTA4w1t4=;
 b=aYnMHPyzGxYtzXXbmE2yT5GvV++o3L6E9cHlAL53/xL1OFyulAt/32np+uvhtLzZC2ItxOPlziCOzmVD4u1KZEpc1TjpxgcVl7rvGgRHE+cV1tiBaWpFRQSkfP12rxIczEbO7jLeFubN3sICDQv++MGVp6MF5+czif4cIlAbJBcl+FhaRoPQi1u4BOATNo0xdJEAMvSPf7gQarPayUJqadGgepXmYibHSuQJRKQ7MpWBdT/h1Kx3s5Z0Afx5rDDIR3E9FXBoGREXK3AJi5lRse1ThD/sdDl0W71dhdXg0xjbGtud3FbLxRvYS0YYhSgYzPo0PpV7yJkT16z04ws09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9124.eurprd07.prod.outlook.com (2603:10a6:20b:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 13:04:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 13:04:03 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH] intel_iommu: Re-expose VTD_ECAP_PT
Thread-Topic: [PATCH] intel_iommu: Re-expose VTD_ECAP_PT
Thread-Index: AQHczL5zu7eE5OGysUqASVMPREHk27XgFvoA
Date: Wed, 15 Apr 2026 13:04:03 +0000
Message-ID: <6fd7a51125963dabe9e9b3732e2ece5086b666d6.camel@bull.com>
References: <20260415095832.9631-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260415095832.9631-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9124:EE_
x-ms-office365-filtering-correlation-id: 1aa98b98-d0c6-40a9-7606-08de9aef7807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 8mkaVSDK4nAgYl4KpV+KO9BcKQrBT0rCfqkSyVFLaCXaosDwf25bN6St9DvJsaFnaK7Hlbdb8dIglAZobiRKQtP+KBH2ytK9qb1BP68Uh42YUzT9R1yPLW3Ti2EkEMjEEs9DG26vlZkB1XZ8ZfqHyNdCh9kgdY6UMO7H1uZuio6TUvZYdQOOckT0lVK7BrxIUHuObA8ID2yq6eE0/dXVErAbvClA6PcSBAQXD/IKAmSi3pd+QtM5zdSrcSlMm6y4f04g/FTEXaCvRekKH80exoj3Gbcjj0eOE15Ob3/aQjIsgb8qOCT5WTptGfH8qOZK/zIB9epTLnolE+JpmK/dAImXeWZMPbohANjFzOmwXob2alHIQ0SGxwoJ2zOCtEU1tgdt5RTX9ibew7vD53T6nEmnd1G8vRvXT+ISxirIJeTIivvDog79Nm4qNrtHwBkAG9dUnLRwI4qCvlOODQd+30/ndEUtQ3svHXAcA9jV9jTjhkuU1+sICVssEbsVcna1Ih0oHGj5WR/0xvFIjcfGPiKlKrXQXEw9UkLLd8peh/vF+U+m5nrDpy6tBksT89gu7MAvEcyAp7PkSieDPM+83TVkuRkcGgjTmUcCETlaX4VZPiAMKfMj1fSMnckj3laeVUaqXj9usKuxFNpzGGsUDiMa0hDg/zPtsVvCWYkYi2ViUqZC6MNOsj8VWaXBVuV8BZ9Tt5C8m17Ycmewk4cWmH21t7Joo0xwsLh0C7Z+Om8+RxfQV3rxsE6YbAkKdjku
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExpNUc5b2RQVnFaR2dpdFJialJ4UUdhVmZZQWN4QzI0ZC8zb2lUMXNsaW81?=
 =?utf-8?B?Y2djWVRuWHMwUzhOeHk3alhwcEY2STZ5cFlRMmNsWjVlM2VOT1haSmY3cHZX?=
 =?utf-8?B?OG0vaUQ5OFdEVGs3L3F2SWFwMU4zekZVS0RoK3hJbFB0OE44UGpUZWlPZjV3?=
 =?utf-8?B?OWU2K3dtRitTelJJemZpemtBNlBIT3BTRk4xWXRNZktqY3Iya0VEbkF1L3lo?=
 =?utf-8?B?OExFWWNMOUZuaEgzQXIzakRBYlBoZ1oxcHB6ZCtTRFRaUlVselF2Z1hJZ2x6?=
 =?utf-8?B?NzNHTGliUHZnb3RQSlliRVdWZmZhOW9JUTc0UHRoclZPYWJPb29HRlgxRk5h?=
 =?utf-8?B?WGU4N0Y5aUFPaWFJeDllR3Q5QnY1eVFMSjM2VDRaTkdFcmcwQW1yemlmM1I5?=
 =?utf-8?B?R1loRTBvdmFkSUtDQWxGSGtYKzQ0azNFMVRpaC9VZUVtTFhhQjBEdFkyT2Rm?=
 =?utf-8?B?MUxYVjRDSmdxbmR4K3V6RmFLWHJlZFRaNmF4UUJ1a0JPMm5iUWlGMjZhRVln?=
 =?utf-8?B?SG1ucjRhQzg3WHMydis0OUlIVjZMS1E3cUVWSDYwUTc0T21iQTdWbUJ2NDdZ?=
 =?utf-8?B?VDZyRjUrYXhOclFFSVZuNFM3THpOSlo0UFFrL2pvaE5vUHVpN3owVG1iSU1U?=
 =?utf-8?B?dW9mOFVIK3pIYUVwQzlpcGNoS1JTRGcvd3JxY0Y3YTdLcVJQckE1cmovMFFK?=
 =?utf-8?B?SnZkMWsrOUp2NndJNnU2ZVN2MTVOSzNJK1I3MGVjUzRDT2JEeFpwOS9Mb3lu?=
 =?utf-8?B?STc3bzIwMnM2eldDbU52aTQvMXBXVG1LcndNdUNwRWllMk9VRTRYRC9NenJw?=
 =?utf-8?B?aElDNUkvWVB5UzJrbDFiTng1cnBZN0JYVm1YZ2FlTmt5a0RuUGxiS01vdi9l?=
 =?utf-8?B?UHJROHY0ZGpBdTVQaG5rYnZwTlJYNHhRem9PK0JYY09BRldQTWVodVZ0Mjc1?=
 =?utf-8?B?NzF1aHUxSStzUG5pak9RK2QvbGRrcGRhY0hKM1RiWmZxZmxQaGsvUit2OFRQ?=
 =?utf-8?B?SG43b0N1QlBDb3RvSWh4QWlwYnZTM0ZjNUl2TFNmOTNvRkhUREN3bTR5di9L?=
 =?utf-8?B?am5hODdPUmtsNHkwbk4wOXVVVjZUaGQ1aVh4RDZjM0YyT1YrU1J4alJTQ2No?=
 =?utf-8?B?WUVLaHFKSGFCTDRUQ3FuSFhNS2FHMlB6ZnhoUEdVS1pjM3JzRmMrUmdtSkhJ?=
 =?utf-8?B?ajVFL2lheW9RMUpIeE9DcGJrMm5XQTZ1ZDdZb0c5VVpLWE1zTWNPMnFrNTIr?=
 =?utf-8?B?NWhHTCs0S0s0cW1FSnJ1eGFabFFXcUYxMGhxMXFFSFJQbGhpZHJGWXhjbFFU?=
 =?utf-8?B?b3BIR24vcC8zTUJmeTFJV0lTSGh3Vk42a2F2MlFqMnVWM2c5dEkyV1hoK3Bv?=
 =?utf-8?B?NHZOV1FKOFQwUDF2OVR2THVpNkFuNVhMSjUvTVFNalVuK09Zb1lWdE9YV2pB?=
 =?utf-8?B?NG1iZGt2ei9peFMzbmc5ZXRSenMrNVlqT2tibGdoMDRJSTFYUXppTzlzZXRP?=
 =?utf-8?B?L3c3VjlnakdGTGREbGZKTjFQc053dmZCM1UwbWNhSFZ4RUtwbEhXenV1SHZh?=
 =?utf-8?B?aFpSYXltcTFhQ2lteGdkMzVIN2lPVEdxamNmSlFvWWd6STdvS0UrZDNkSlFx?=
 =?utf-8?B?S2ZBcnhQSjlSaEYwbWswVHd0MTlqd3g5RWt4blZxdzcrSEpHVGZHOFVvaWVs?=
 =?utf-8?B?QW9ObkRSaUt1S2xLM3RZWXNBcWhoQUpOUW5BQUVkRTFnNnJtYWJBY2IyNEo3?=
 =?utf-8?B?KzEwWHQzK0xnc3pnem96eXlnbUJuUlIySkJoR1EwbE9neTNTMGFtb3hkUmtW?=
 =?utf-8?B?cWl4YlBNQXZCcjF5MEM0NjM2b1FDMmhvZXk4UUF6b21WSHFQMEozZllPSjVH?=
 =?utf-8?B?NFlyeXh0OXhrSDNrT0h1Vm9iS0tqVHdyUWJNUFdEcWI5YnNiTlZtZjdnVnRN?=
 =?utf-8?B?bEFQZUpmOEcyTElqdzZHaHdJbG5DZ01LWWFjaWRZRHhPcWJyQm0xRkRjUzA1?=
 =?utf-8?B?dnpwRGlGdTRtRXpENGJPNVhyKzdDSkk2VnFGM0JlMTNxS2VsT2tsTklDZ29r?=
 =?utf-8?B?N0V3QThoY3dmeG0zNTZvRWltRzBxeDcxRXFIOTJaRVlqbmtad1FEYUs4ZXMz?=
 =?utf-8?B?TE9vdG1EVkxEZjBrbVBDMW90aXJ4UlNxbVcxcjd6blhYTk9vVFZiYkZ2elFn?=
 =?utf-8?B?T0NPZWZocUZQaUgvNEI5L1A0MFZjMFR5amY0NVgySnRJNjBvMEw4UlVBbXZw?=
 =?utf-8?B?MlBxb3YxZ1dDUlN5YXl0c1RWK0I3dlVESlA1UnRxM3NCaGVWckRweFFjQ3hU?=
 =?utf-8?B?SGdvQUZPeDF1ZkN0R0F4dUVPMDVMMUp5NFpXNzgxWGhFdm1pc3k3eWNLYjFq?=
 =?utf-8?Q?HSbyXoqBgT+G/mJSvw29DTu33krV6w3mVNvQn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BE351A9578FF34DA3C5678717E9526F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o3b2L5ZnUDkudtm7glJvlYLsxpMWDpNroVG3boW7PoDzF0k1AY8ntCuwgcYqiJZpl/jR0te3rtf0JR1DbdfvyrQg4n4rRWZFbCd0dgCI9fl5Bb04Daxr7C3BhnzuRlplGmPw/fvRtMoV6k2vtcwwFGW8qU3XzvmJuqkCeD1GeXqTDv76rL2zHJOrMXUyECCb2LGLi7ZgKbgTl5Er3yuRMw862+FflLvyQoLL1KKpgRZRJ2Fw999qy2xCcKXsPSmjVfKP1qKW1aRujcWCdBTwcWoySbb447IXec4z97ZiwacJTsIQctFSZhWusDmJpfL/ATMuh6F3hPMhZ4CMabrvyw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa98b98-d0c6-40a9-7606-08de9aef7807
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 13:04:03.4125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9kCIYsmYjHJZphspX2mXFRkoJB/HSo8/+QOVDp/VS57z1FCQd+Yd7vBDmDtEsPBImm4bSXwc1f7Kg/UbMRHDRsDkD/0PEwa5PGPcW6k1G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9124
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgWmhlbnpob25nLA0KDQpIYXZlIHlvdSBzZWVuIHRoaXM/DQoNCmh0dHBzOi8vcGF0Y2hldy5v
cmcvUUVNVS9DQUZGRTJhdnJIREtaZDVtN2ozRTN4NT1GPXB6bi0zYzl2ekdXUDMrOS1BVlB3UW5n
N3dAbWFpbC5nbWFpbC5jb20vDQoNCk9uIFdlZCwgMjAyNi0wNC0xNSBhdCAwNTo1OCAtMDQwMCwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENvbW1pdCBjN2IyZTIyYmQ5NTcgY2xlYXJlZCBWVERf
RUNBUF9QVCBpbiBlY2FwIHJlZ2lzdGVyIGFuZCBzZXQgUEhNVCBiaXQgIA0KPiBpbiBjYXAgcmVn
aXN0ZXIsIG1ha2VzIHZJT01NVSBwYXNzdGhyb3VnaCB1bnN1cHBvcnRlZCwgZml4IGl0Lg0KPiAN
Cj4gRml4ZXM6IGM3YjJlMjJiZDk1NyAoImh3L2kzODYveDg2LWlvbW11OiBSZW1vdmUgWDg2SU9N
TVVTdGF0ZTo6cHRfc3VwcG9ydGVkIGZpZWxkIikgIA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFu
QGludGVsLmNvbSk+ICANCj4gLS0tICANCj4gwqBody9pMzg2L2ludGVsX2lvbW11LmMgfCA2ICsr
Ky0tLSAgDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMgIA0KPiBpbmRleCBmMzk1ZmEyNDhjLi42YjhmNzVhOGI2IDEwMDY0NCAgDQo+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyAgDQo+IEBAIC00OTk4LDggKzQ5OTgsOCBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQo
SW50ZWxJT01NVVN0YXRlICpzKSAgDQo+IMKgeyAgDQo+IMKgwqDCoMKgIFg4NklPTU1VU3RhdGUg
Kng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7ICANCj4gwqAgIA0KPiAtwqDCoMKgIHMt
PmNhcCA9IFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfCBWVERfQ0FQX05EIHwgVlREX0VDQVBf
UFQgfCAgDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREX0NBUF9NQU1WIHwgVlREX0NB
UF9QU0kgfCBWVERfQ0FQX1NTTFBTIHwgVlREX0NBUF9EUkFJTiB8ICANCj4gK8KgwqDCoCBzLT5j
YXAgPSBWVERfQ0FQX0ZSTyB8IFZURF9DQVBfTkZSIHwgVlREX0NBUF9ORCB8IFZURF9DQVBfTUFN
ViB8ICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERfQ0FQX1BTSSB8IFZURF9DQVBf
U1NMUFMgfCBWVERfQ0FQX0RSQUlOIHwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBW
VERfQ0FQX0VTUlRQUyB8IFZURF9DQVBfTUdBVyhzLT5hd19iaXRzKTsgIA0KPiDCoMKgwqDCoCBp
ZiAoeDg2X2lvbW11LT5kbWFfdHJhbnNsYXRpb24pIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKHMtPmF3X2JpdHMgPj0gVlREX0hPU1RfQVdfMzlCSVQpIHsgIA0KPiBAQCAtNTAw
OSw3ICs1MDA5LDcgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAq
cykgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmNhcCB8
PSBWVERfQ0FQX1NBR0FXXzQ4Yml0OyAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9ICAN
Cj4gwqDCoMKgwqAgfSAgDQo+IC3CoMKgwqAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlREX0VD
QVBfSVJPOyAgDQo+ICvCoMKgwqAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlREX0VDQVBfSVJP
IHwgVlREX0VDQVBfUFQ7ICANCj4gwqAgIA0KPiDCoMKgwqDCoCBpZiAoeDg2X2lvbW11X2lyX3N1
cHBvcnRlZCh4ODZfaW9tbXUpKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBzLT5lY2FwIHw9IFZU
RF9FQ0FQX0lSIHwgVlREX0VDQVBfTUhNVjs=

