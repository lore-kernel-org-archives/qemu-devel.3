Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37225C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrD1y-0006DR-94; Tue, 04 Aug 2026 07:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD1x-0006DI-6p
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:09:57 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD1v-0001JN-2l
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1785841795; x=1817377795;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=En+8SSOz7lm/jNtlgyQKDNi/4EsD98xA2Q7TIChiMZc=;
 b=yBY1JH9KUxAN9ktzyFEVSZVY3K3EgLi+LraPEcBaVivuolcpknNdhF5e
 oXv0XvG48gwCTqCbbak0hVIVGvlucX2Pi+dCoYJCS4I2v7J/ZAfQP9a06
 QcQT2nkjgw58f1pK8QmEWWoBaj0Qzz9v5Qq6rV0GKUDW8GMbEswc5WkW8
 fmR73qGqyOrUgIq9+riAIEDwAz0kzNUpkb3nM0t8daxNAkwy8VyebtPn0
 uiH+K3erfG+qs6OxcUbUqo5cWG1vCPD5v51E3s3BahYa6nE3XUgrixI/B
 zJ//rEgxZsEssKlqW/gskSvX9wg35mKxAEC5UN3EhFdGEgOgis4GvOKOV A==;
X-CSE-ConnectionGUID: 4NCVFMkiQwqU4UmvU10N6Q==
X-CSE-MsgGUID: PJWTPCI0QiWZXtYZLI5uew==
IronPort-SDR: 6a71c87c_aglzMRecUG3y+Da9/I2HmXkjX9+PukcAQVg/ibw3HxgmxQi
 51lFkUgQxZSthmJTM5itIZnoOB40pv5yuTmHc+w==
X-IronPort-AV: E=Sophos;i="6.25,204,1779141600"; d="scan'208";a="48555025"
X-MGA-submission: =?us-ascii?q?MDFI7EDQsPLOXe/hG/nsyAVc7dTzArPG29OeYd?=
 =?us-ascii?q?BJwAILh08rRPE3ekqmTyBsGIuiTuiygrt+o/D5WbaQh2sdwJtK2qfaW+?=
 =?us-ascii?q?9xttEtKATT6H1bkpDe+PMbWLiHK+/UdnG3RJu3Q4w3OAugurrRxcTWXs?=
 =?us-ascii?q?J8sNUX+8nA+AEabe6PIYklCA=3D=3D?=
Received: from mail-westeuropeazon11010033.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.33])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 04 Aug 2026 13:09:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoJCK0l8UUMQ7MxTGIFaxGarR0DM1XraFjY9ByWedx+mXVWmWOGf/Nwex8YKeCiyMLuLONtnZZ2MirNTjMBeaj5fpxhWQgoK1Y50y3kbrm0hnBrXzJmgT/FiDrRhBJ3iRmVoVoKiAIiPGoK6Cp85VSaNOKE5Cglba8SMIB3fRaeDI5AHTm/vbVxDDlofnsSRjcE758HuGLxrryJk9bWOjfykEw2vuSqwqR0BzxI2kWflx8gJ5tgag1xemHhnCkFA/JK7LjdHpVKwW9fulDUHfyuyuERUD+DRGHlEKM8bHc7ma0NQ5FpCJBXC+3GM71SFrTGZa5r7fvSacazwCzpE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En+8SSOz7lm/jNtlgyQKDNi/4EsD98xA2Q7TIChiMZc=;
 b=Esk0/J095X811dfViFfgQLeXpNARwcyvPZ5FKR/xdNKZiJoloMOoVMPuqhX6ZuQZ7btwv05DrlgNMGEFEQjF3YZ9kY+duQKQVquSx5Ut5yaJFc4bgh6O3alhlqHhXS/EJat4ZPE2Swi90IxgXzVSKQglRD3M0Cb+abdcRZ3rtM8W7lFDbVz/VWpM9w7norpPT6qEiCInXT7Guw8h1Z5Z0CZ9SOStkm7MVeYr9OV8PvHpfwLg/Fq90qmuF2Wf6i9O9MUDIw7/HYQgmCZghu1tZhzr1DML80AKuQdjQkiRnIttIaJHLjimdSp2rZ6vOaaBPvfQqP24TCXgJYTmKMsI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6568.eurprd07.prod.outlook.com (2603:10a6:10:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:09:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 11:09:44 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Y7aK+COAgAKffoCAACavAA==
Date: Tue, 4 Aug 2026 11:09:44 +0000
Message-ID: <d73aa4f361f16d03e1eddaad6dc13a1371349b35.camel@bull.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <20260802124718-mutt-send-email-mst@kernel.org>
 <50bad4d1-4171-43b0-83d0-2d83bdb41c0a@intel.com>
In-Reply-To: <50bad4d1-4171-43b0-83d0-2d83bdb41c0a@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6568:EE_
x-ms-office365-filtering-correlation-id: 0339db9d-bb3b-4f38-83bd-08def218e3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: qfP42jt+5pBAA3rryZohjbowZqCr7SdYxlcekU69UmiV7iBIkfnQeLeeRsOyndeEr0corPzJDHcTSNZRRKkA7B2Xw+I8N2NGo5Bc9tkuVRv2ygvBlWtlMvIUEL3yrfQFVXq/0tJrJNrLJkFrwXQB5x0mR3o/4AbjjImmXf8hT+n4czDegBXjJV4x/ebq3sDA/dtQDhmFVGvWk0ypdEq+w92swPqtCD3DWbvU3QpxlXluDWxlpokhWWp1Sg+TDgrn8lHm/a1EJaM038a314IIaMHgoSpavxWCUrYmVQvMJso+6wvF9OJE0tz9yVWY3fKc4PtbdHapKG6Vw4sYa+IfwpvK/g4VWkfHGtL8hFOlktsNqp+wWX82id852ZmV/kj4BuDp23j4ZqNoNPd0Xbql8fVcojB0+o9zmH2ku00rzoUAfD8IDC4opzua1RkMFxZ06i4Dg74CRVH8ApE68w3+adtCQXKLvFiFOothNNKJ+IZ+2yC8YtQ1+Z598Q+G0ulGpt1hC9KyjVN86y8RJK2nchqipdL7P8pGOfj6Ni6tDk015CqtuF5kHC8l1LGRu6RckZqe63Vldn6l2prb7Au+3hNEEqJ8fjkPc2LuX9WvmbnWy864PlX5Cq90IsR0ScJVgHpl9j52sqUUSmTOr4hG7YR+mvYtTah8/r8uNUSovWPBNkpQgeEJxh8V2Uc48n3Ur+14gGDV+zPdwo0ozUplRO5ZpXiUxt2a7CoO7B6NYf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUorZ3lVRXRDaEpXaCtXZFVER0ZqdGJ2M05yVFZIaktLTStDUjhsd2V2alJR?=
 =?utf-8?B?SVNHcS9TODV6aVAra2Vic3hFU2t1V0QrNTNuc1gxU01zTEdtYmxhbHJ4L1ZY?=
 =?utf-8?B?NHFWUGRVMzZtM0luZEV6UEhwSDJndVJXODhNTU1NbFloOFZXeTZqelRFOGdk?=
 =?utf-8?B?ek1Tby9JV2lQYTE5ZVk2UG81WEt5aERTT0xYbC9GTHBBb3VVcjI3VXJHaHNx?=
 =?utf-8?B?VkFDZmlVTkJYNjU2cmJzQTc5MS9NczR3Y0ZNY2ZHdlY3YXBDN0daMW1pZHgw?=
 =?utf-8?B?bURyVGFjU0N3WkpNT3pvZzUzQ0JWT1JKVy9vOFUzWkxwaEFWb3lxWnROZEVj?=
 =?utf-8?B?QjZYR1NLT29DTHpMNGs5RUZ0bndhV2VNL1BpeDkyN0ZYRkxxU3RlemhLNzA3?=
 =?utf-8?B?eG53a3RtR1lVd3NUUWxuU3Z5cVMrQmY4cnV4TlFIem9WV1dUTkVqZGt5Ym9G?=
 =?utf-8?B?OGU4VUlMMkt5dUxNL0RHcXBsaE93aWFzcVNYZENTdmJudXZoYm9sZ3BMaUx5?=
 =?utf-8?B?WTY1eXJSWlI5SUhJQWpkVUQ3M0pVQXVUN0ltdmFKVVdhcW8yQzdvOUJReFlr?=
 =?utf-8?B?YTBaazc3UkVJSFlEQ1UxTnZBNStPYms2d0JvVldpc3Z6YTlvTG5mQW1pTDJh?=
 =?utf-8?B?eU81eXRidHJFVUJUZmlxeXVNTCt2T25OYmxJZWNWckE5Yk9FdFA4aTNtbDZj?=
 =?utf-8?B?ZXVnbERkU09hM2tndkZNamc0SmtEVjRmTDZOdG5mTmJzczZVQitTMWxTdzNU?=
 =?utf-8?B?cWJwUlNzeUZpNVgrNEF4elhDS0xOYXM5bFFoL0FKZ0ZZV2o0c0prMzdRRTF4?=
 =?utf-8?B?V1cvKzVIdnFvZGNja1FxdU16UUFwMnhwSnhIazFzcDI0OGhoVUozdlBqbUpJ?=
 =?utf-8?B?SWpjUHVVQmJqT0g4SzUzRENvZ215VVRkSmJkNWgzN0dKWElrQUh1MERWeVkz?=
 =?utf-8?B?TmQveDFieURNbTNSL1hQVWxHZytwRUxDVlMrVmNFRnptVEs3VGNVeUJkYU03?=
 =?utf-8?B?YW4zbDJXYmZhRWxqOXJWVFNWcWs1ZWNlTnM4NCtGbXhqZ3FIcjFzZGtrRXY2?=
 =?utf-8?B?RFFjRGFHMHcwL0V1amtINkpTdHhpeG1YMkRQaDhFSmR6RDhNN2xMN1o0K3lj?=
 =?utf-8?B?TXBIbG9yZE5KNFhGN0U3RmNENEd1czRKYmROYlI4RllwaE9iVGtnZ1NCK1Ev?=
 =?utf-8?B?VUhFaUVvOGpQM0JtVDUzVzJ2cWhxbFlVRzlqMFloRkpuZnk1OUkvY2s2TTZD?=
 =?utf-8?B?NFB4NXI2Rm90cTNleWRZZVUxdkJVM2ZyRnFBY0FLaEoyUlVyK3VlQXlTdVE5?=
 =?utf-8?B?ZWR3QkI1d2lERExNS0hlQmJIRGZ3NWJjRUNlSkxHYWZ6STVjSzE2UERSZ1ZW?=
 =?utf-8?B?OHI5aU5MazVUNUx4R2xpMHhnQ2d0bGNlZFYyQVdoejhCdzduVDB3dGxVSFdC?=
 =?utf-8?B?SzJGb2w5U1dwQUMrV3h5UXhxS3c4czJHZTVuWFNydXQ3RjVmSkZCUTdRWU5v?=
 =?utf-8?B?Y0E5blJNblg0R25IT3pxNUgwME90UW1sSVFIS1pLUXhWNlJjUDlEZk0wVm12?=
 =?utf-8?B?TXRDK1NlOXdTdVBVUjE1QmVkSGIwNklpUHlBZDhPb2dHT0ErNDB0bHo5MjV4?=
 =?utf-8?B?LzErZVFGaVByRFR0UEhMTXhHSkc3Y1psRmRpMWhqa3VvbzVES1VDdGlFQmRt?=
 =?utf-8?B?RlVTL05sTlFyZlZ1Ykd3OU0xdGRhdVZ1YUk3MGE2OG9Xcm81VVYrZEdOTkts?=
 =?utf-8?B?MnZROU1HMCtrY2lqSFQzY0FpV2owTExra3JNRDNLblNKUXlCMWtqdTZOWWxR?=
 =?utf-8?B?d1NtdlE5SmM0TENlMDhrZThUdVRLZ0RVOXFBSktMc3MwYnZSQmlrQldaQld0?=
 =?utf-8?B?dFRMRXM0aW5YR0NsUEVCNzQyeVI5MzNsMkViR0c4ZGhScFc4YS81ek4yMFVt?=
 =?utf-8?B?WUw0OUtvZ0VNaGlFMzVtK1pmMkttbitvRnMwNHZtZ25yZHIvOTYzeG1LMlpw?=
 =?utf-8?B?Z0xUV1RjNXRteFhXMWwwcFVXNWpsNm5lbllrZHNFUHBHNndmZFQ0U0EwK3pT?=
 =?utf-8?B?VEk3Y1ZkdFd4N2hSck51emdrMmtmNm1tTFdLWkl6VThsbDN6a1lxbmhTODZV?=
 =?utf-8?B?akppYVVncUJORVpid0RJUU5JeS93bkl2ZW82Y2YxTHZQa3NhM0RHWmZOMkx3?=
 =?utf-8?B?enB3eEZuaVpBNEJMdUVmNGt4UkFpY0l3US8xRFcrRmpNbXJ0VmFnelUxVzN5?=
 =?utf-8?B?S0VyQTUvUktNeUJ6ZUlYVnVrTEFRYXd0cFZ3QWd5SzVqZThuaGVWb2hneFBP?=
 =?utf-8?B?VEJuZkRRdjNoalJCU1FhcDJLV3NEZXFpRWZQRTdzL1dmYjBiWHU1b1c0czd0?=
 =?utf-8?Q?wgSYbV/RS5uFvRfh4SmwdjJLz/HSoQ4zUxbEu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F4C69264B868E4A89FF169CA13A4998@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BjFsQjGEeWiAiu73VS5EyzIgtAs+2pFh9+q9SYkxvbT47s/PCl5EVvgrmRKG3B7lisEKXZtujVD8Y2nbPcFS5YCIvaHcaG995+TcwMfJSj6yGexc4YKZmKrHN8SoCk5SmLUOpOwahNr7COXbt2dRzIQbtLq54QPVgxOUpO3tllG/u97EeKMoMGzmWVWCahYj6cYAbijE+sB8KbBLXDHk/xr/bYcERN51cE66uwK2xr/LN2G+YcN0J8Xy0aoXsMkKCRzS8ztZUseIFB0ghmTq4XbfqpzwSfcVq8xuYtJvnAm7BJ19iXm7hUTBjME/i0hxbJLuywVL2bvajO6hMD86ww==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0339db9d-bb3b-4f38-83bd-08def218e3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 11:09:44.4787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCttysYkldEt2a+ueshBk5NEiliMVIo2RL9VkcGmQVBx6XpFawddN5M2jEOjxDdTHGwFod/wWomvXqD+tarWAEJLAHiNPtOOdnzIZ4NAWXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6568
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

DQpPbiBUdWUsIDIwMjYtMDgtMDQgYXQgMTY6NTEgKzA4MDAsIFlpIExpdSB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDgvMy8yNiAwMDo0NywgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiANCj4gPiBPbiBTdW4sIEF1ZyAwMiwgMjAyNiBhdCAw
NDowNTowOFBNICswMDAwLCBDbMOpbWVudCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiA+IA0KPiA+
ID4gU1ZNIGluIExpbnV4IHJlcXVpcmVzIFNNUFdDIGFzIG9mIDc4MGRmZWQ2ODg2Mi4gVGhpcyBp
cyBmcmVlIGluIHRoZQ0KPiA+ID4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhcyBpdCBpcyBhbHJl
YWR5IGluIGxpbmUgd2l0aCB0aGUgZXhwZWN0ZWQNCj4gPiA+IGJlaGF2aW91ci4NCj4gPiA+IA0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxbY2xlbWVudC5tYXRo
aWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29t
KT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMyArKy0NCj4gPiA+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
IDEgKw0KPiA+ID4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gaW5kZXggODI0NTQ1MmQ4OS4uOWYyMTYyMmE0
ZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiBAQCAtNTEwOCw3ICs1MTA4LDggQEAgc3RhdGlj
IHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiA+ID4gwqDCoMKgwqDCoCB9DQo+
ID4gPiANCj4gPiA+IMKgwqDCoMKgwqAgaWYgKHMtPnN2bSkgew0KPiA+ID4gLcKgwqDCoMKgwqDC
oMKgIHMtPmVjYXAgfD0gVlREX0VDQVBfUFJTIHwgVlREX0VDQVBfUERTIHwgVlREX0VDQVBfTldG
UzsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBzLT5lY2FwIHw9IFZURF9FQ0FQX1BSUyB8IFZURF9F
Q0FQX1BEUyB8IFZURF9FQ0FQX05XRlMgfA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBWVERfRUNBUF9TTVBXQ1M7DQo+ID4gPiDCoMKgwqDCoMKgIH0NCj4gPiA+
IA0KPiA+ID4gwqDCoMKgwqDCoCB2dGRfcmVzZXRfY2FjaGVzKHMpOw0KPiA+ID4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPiA+ID4gaW5kZXggOTI0ZTkxY2I4YS4uZGY3YTBlZmE2ZSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ID4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+ID4gPiBAQCAtMjAyLDYgKzIwMiw3IEBADQo+
ID4gPiDCoCAjZGVmaW5lIFZURF9FQ0FQX1NNVFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICgxVUxMIDw8IDQzKQ0KPiA+ID4gwqAgI2RlZmluZSBWVERfRUNBUF9TU1RTwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0NikNCj4gPiA+IMKgICNkZWZpbmUgVlREX0VDQVBf
RlNUU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDcpDQo+ID4gPiArI2Rl
ZmluZSBWVERfRUNBUF9TTVBXQ1PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDgp
DQo+ID4gPiANCj4gPiA+IMKgIC8qIENBUF9SRUcgKi8NCj4gPiA+IMKgIC8qIChvZmZzZXQgPj4g
NCkgPDwgMjQgKi8NCj4gPiANCj4gPiANCj4gPiBBbnkgY3Jvc3MgdmVyc2lvbiBtaWdyYXRpb24g
Y29uY2VybnMgd2l0aCB0aGlzIG9uZT8NCj4gDQo+IA0KPiB0aGlzIGJpdCBpcyBleHBvc2VkIHdo
ZW4gdGhlIHN2bSBmbGFnIGlzIHNldC4gVGhpcyBmbGFnIHdhcyBpbnRyb2R1Y2VkICANCj4gYnkg
dGhlIGJlbG93IGNvbW1pdCBhbmQgY29udHJvbGxlZCBieSBhICdzdm0nIG9wdGlvbi4gU28gbG9v
a3MgbGlrZSB0aGlzICANCj4gY2hhbmdlIGlzIG9rIGZyb20gdGhlIG1pZ3JhdGlvbiBwZXJzcGVj
dGl2ZT8NCg0KSSBjYW1lIHRvIHRoZSBzYW1lIGNvbmNsdXNpb24uDQoNClRoYW5rcw0KDQo+IA0K
PiANCj4gOTUyZTFhNmU5MGViMjJhNmRlZmZhNGU5ODAyNzdiMTM1ZTlkMDc3Zg0KPiANCj4gQEAg
LTQxODYsNiArNDE4OCw3IEBAIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1td
ID0geyAgDQo+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01N
VVN0YXRlLCBmc3RzLCBGQUxTRSksICANCj4gwqDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJz
bm9vcC1jb250cm9sIiwgSW50ZWxJT01NVVN0YXRlLCBzbm9vcF9jb250cm9sLCAgDQo+IGZhbHNl
KSwgIA0KPiDCoMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9kZSIsIEludGVs
SU9NTVVTdGF0ZSwgcGFzaWQsIGZhbHNlKSwgIA0KPiArwqDCoMKgIERFRklORV9QUk9QX0JPT0wo
InN2bSIsIEludGVsSU9NTVVTdGF0ZSwgc3ZtLCBmYWxzZSksICANCj4gwqDCoMKgwqDCoCBERUZJ
TkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1
ZSksICANCj4gwqDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJzdGFsZS10bSIsIEludGVsSU9N
TVVTdGF0ZSwgc3RhbGVfdG0sIGZhbHNlKSwgIA0KPiDCoMKgwqDCoMKgIERFRklORV9QUk9QX0JP
T0woImZzMWdwIiwgSW50ZWxJT01NVVN0YXRlLCBmczFncCwgdHJ1ZSksDQo+IA==

