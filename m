Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDFFCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGMU-00039z-0h; Wed, 24 Jun 2026 01:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wcGMR-000390-Ry; Wed, 24 Jun 2026 01:41:20 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wcGMO-0003MU-0W; Wed, 24 Jun 2026 01:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1782279676; x=1813815676;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BwiWQyexpHEKIB3eefghYEbj9FDIRMw1sx3syCjPnIs=;
 b=P7WyyRgRCwIXuokGS7PVvVfN0elBymu2jnvjyw4Km8ugzyFEWRN/zIFN
 qmIS8vfHwB1InC3M2M2WchkHxb4nqj3bqhvLmMUTN+HTZURZkuHphNBQH
 P0KxECsrG6nvRs31dH1kFO7ezMMaD6TNafFa/KGkfSO8xca32gC/Cbh/1
 jYuH9tOkoSCU1LOTEBdbXHID0eCq1EZd/aUA/u4RnCMHvsNhXUe06VXPe
 /baUT4f04wtHmZ6al/AB7a1bFvOX4ogPGfKiS2QjglbJaWKk6A9JhtHqr
 8e7GazKTO6T1H8BcFP2/a9vQ+85WYkaYCrZnu9cEF1oDDhDUalOFN8ax6 g==;
X-CSE-ConnectionGUID: mxx/ookHSg69mqApWgPIuQ==
X-CSE-MsgGUID: mOIDyHXFT2q+f0RJyXaCdQ==
IronPort-SDR: 6a3b6dec_QNyiB7Yb98jIRYHtHAIrul5W3iZaSpgwBMLJkL950aJciRq
 bMkPoo3xyFZw7cGG0UFu4rINq1uwPQDhyAsBqdA==
X-IronPort-AV: E=Sophos;i="6.24,221,1774306800"; d="scan'208";a="48293940"
X-MGA-submission: =?us-ascii?q?MDHQ/b01kKAo+uAgKu4M8sOXvzi8yGKTqjIAx2?=
 =?us-ascii?q?pr0Dw7cZ7fFjGkQ40rkZHLwrgnbq1BVwYTcgBQVRensEa10iapIzwxUW?=
 =?us-ascii?q?ufPfOyULstYdX4+0SJbJ7oJQayjUxHEK2+xbdFM/vWxKo4gw72I1XCmr?=
 =?us-ascii?q?TWfuZehKIFqs7+K9aaBqzAvQ=3D=3D?=
Received: from mail-northeuropeazon11012036.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.36])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jun 2026 07:40:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjYa8Y5Xc9gV3A3MJrhROHqWYG96H4nnXALyfHzhNu9qF+1FjWNgaHtzwLONb0vaqhhhXiPNmpKmNkLe7OS9xwncGiCqfJkkIWBfddTtW01Xhy+lS8OVela3aFzzIjJBGWlb8yK0A0tcqwwjBAouW9EHWLQHmi4UmFP8jQzlOw+VbX5qZNIvN2UV0BWlSVCb86JfKD4u97D1vTzAq1Z9uwxjEulq/WpwR2O8IWUrKKhw0QscWSRfhscnfaSf3oHDNGMx8NaGB1VPBAb8S57pXaV2cfY4fVFDvYxzQhlDBoDncSLhhlERhtgAARz8f6MDVEOuUPhCNamDIzgfMxR6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwiWQyexpHEKIB3eefghYEbj9FDIRMw1sx3syCjPnIs=;
 b=McBisCx8CKu6PwSw60+GljFFUv6A9OlFqYovruzjBDi7PU3HmrQKciIGFH7NE29aCDDDmZBZby8Gx1jfe5xtW9NdJr5ZDilRyv56epOHB5ewFEMoNJP1BM7u1wk0I7Mp1oAf6agONUmp+8NnRK8slWQxYw9UT3jk6XvXBZ5g3V16GSSHmGU+TTvhJUTPFQUrOJRWSVs+AfTYR0b9wLPj1LQRQ0rnfTbi2luC9zKBBbchziyZaFLsWKscg6BbwSPR1CpmqkviGPsrv6xEleBnV2FI/nLYoydzX3ILu7TdKztlIQrXsJLq55YqWx0B0xD4aKjvTSG5DDuNvVd4dIS0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB10096.eurprd07.prod.outlook.com (2603:10a6:102:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 05:40:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 05:40:56 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, no92 <leo@managarm.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, 
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Topic: [PATCH v2] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Index: AQHdAumad8yR5iG+Wke7SeJVXLz6/LZL2xSAgAFXJYA=
Date: Wed, 24 Jun 2026 05:40:56 +0000
Message-ID: <0e37033a142f1831c1007825bf497c8c56e80b57.camel@bull.com>
References: <20260623082223.1431499-1-leo@managarm.org>
 <20260623051234-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260623051234-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB10096:EE_
x-ms-office365-filtering-correlation-id: aaf98356-2ec4-4f83-335a-08ded1b329c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|18002099003|22082099003|13003099007|4133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: jD4Y+33sjCFXOLL+K34qHf97Y/Z58obWdC3tsHKUWLmzqe21lqrPArOENV7+i6YgpJfHogcJg/vHLCKnAYrwdQK84bwFxnQiqhQJoCzfbknofMvSywjNYRXcni2fHlUmEinkbZ3vvcY1p5Ylq6rkyGD19/eMlT8vAzNFgWR/axgvqylV6GGX1ZKw2S0Xs/lCVVLCtLz0O+lBCTQRMArydhxpIssec2GKIMzG4WqqnPt+NM/CdZYK53DIv+ZtZ2iiQ5J1M2zq/jfGHUB8k0cnOiFBI4o75C3oFImoeI2yySk2GHyVoc00k6DV1tlKBg+I4z3a0+yb7fxZeHdBNJWP92WWsAgiBO8ioTmXXwMSgVJVwkJUzrGECc2syq/5iLzCQwiyqx28RgPZ7wQEYoncQSUIjekyuvpt44RUujDLC2LDReuyk3KbOqW1MbePk1DE0S+DG9qS4PtxcjBSPw5ZH0h4T8hmo5T73GWSvsBu4FafJ8Gmuq5O9i3ej9KNFge/AOdsit57hm/I6yA9PbIDznT7gaDnxYsurUwqO7U2Gphzb8TVa9uIuCo8HU24Pvh5K1Kvp6aam0XLrGQjxFjPZyRlZTlhO7r//veWg+JmLR4rNBJ7yjU5RnFL7Pa9wUCBGcBPp+WOll7Lk2KT+DHh5nNk+dM7j8gahAv1j9IFKuZwr39GudEt8x/RsYkS64IMtSUd9W2jQpqtT5MAvKmVJOtI5qGGkfzecMPhLCuteN0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(13003099007)(4133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXI5L3M5UmpxTmgvS0cwdGMzMFh4N0E0Uk96UVk5RlhUY2FDU1Y0NTRyZFMx?=
 =?utf-8?B?WDVzY3RONGNiUGgwYmMwRDhVMDJWU0lIV0QxZTNWMHkvQ09ZYS9JaFZ3VlNO?=
 =?utf-8?B?WVBRTUs0eVdJMlB0WUR2bXpLZFo0V3ZTalFibE53eDVKQ2I4aUJFYXo1RXlZ?=
 =?utf-8?B?eURnUEZCamIxdUVvYVRPSnZoWWhVb1ovQjdmVm14ZGpSTTlvZWVoeXZLdEtj?=
 =?utf-8?B?M3ozMXdVS1pUTjlRaWtJS0lVZGdQMk9saG5ZWTdGRm1ZZTVhSEpCTjNSYkVU?=
 =?utf-8?B?YzVrOGNyWXgySytuc2FTTFVyTHRENENBcnpYV1hWMjNIUWk0SHB0RHpDKzJE?=
 =?utf-8?B?bERXSnI5R0JycVNIVlBhMUE1dkFVMGdndGw3N3dseUVEN0RPMTAybkVRcUxT?=
 =?utf-8?B?bVlrUnlDZ2xTLzlpOUprK1NiUEhRd24zRmo2QldxYkVsdjhnb1p4S3pZamVi?=
 =?utf-8?B?Mm9acFVWM2ZrZGNiMlpUN0FrSnV0b25BSXJpNVNvQTh2bkxnWERlQUc5UUZa?=
 =?utf-8?B?QnAxb1FadTRsdW0yMm9hcGNlZWd5U3FPTkxUSHVQeU1WdWsycXNRc3FFRzVT?=
 =?utf-8?B?dWxQRE5pSTdrSEpvUDNscGZRQnMrMmEvNFQyOEppd1FtblltQlBkMWdNQlN3?=
 =?utf-8?B?cEVzREZxT0NtLzRack10N2hId29KQWFLQVYvbmV0OHJTOTBNL0dEcTM1U3dl?=
 =?utf-8?B?dUFQd2xmaXJ0TStvQTFod1dqL0JHSXpMd0ozUTAyR0tjVy8rNm9nOFZMTklu?=
 =?utf-8?B?R1JiKzJ5OFV1NlhSVy9PUENwWlcxK0x0TkhyNjludGpDZ1J3Rmp0QjFOUXB4?=
 =?utf-8?B?K1R1bTl4U2g4Ymg4L0NhUXlJRlVLUXFVL2gwSktLSkgwaE5SQUVzbzFXMDh5?=
 =?utf-8?B?RFB1dHpZT1R0WE56b1I0TVh0OW95QWFabnJFZk9NWDlobVhDTUdxMjR3QWFC?=
 =?utf-8?B?bnFqbWR4L0ZBU01LWjlhcDk0dzN2NlNlRGp1RkRRdEhZOURONFlIUkpCZ0p6?=
 =?utf-8?B?QTIwcitFMjVlc0Evd1VCTE8zZE8rT3pRSlM4S2o5Zkk4RVNxdDZpa3hEb2dm?=
 =?utf-8?B?YldDQ1VKQXNkamoxRjY5UlNsTERTdEdOQSsvTzhmT1BJajJiNWZ0aThDVGZ2?=
 =?utf-8?B?MjliZWhFeTN0YWplUlk4anJKK3lhaHU2UlkyWjNWdy9jcnNqS3hncXJQZ0l5?=
 =?utf-8?B?eG92clpjRlhvdTdMQ1QyMDJVZExCQmN3am5nbVFacFJDSC93elRKMjVaK1FZ?=
 =?utf-8?B?eWhDY0I1Qkw0QnZCRmZkVjY5UUIxNGo2ZmF0VXRsVkJJVGhZU0hOcVdpalNE?=
 =?utf-8?B?REIzVFlYcjVXUlROYU5PU0xXY21rbFZGalNIN1F1bm53RGZ2R0xGbTYwcGk5?=
 =?utf-8?B?WmZWYzhiMUpDRnpxUnkrYU14eTY1Z0MrRWx6c0d0cmhMZTlhRW5xcS9PSEwz?=
 =?utf-8?B?dzM2dENsUGRSQU5HT20zQitPVUN1bE9pWnczZ05VMXpMOW1KOWhQV3d5RVVl?=
 =?utf-8?B?YUFMTFlYQVF1WlJ6UER6by9ZSThaeEoxSERDV3BWWTdrOTg3UVlwM1VLaXBN?=
 =?utf-8?B?V3FrdmhLZUlndktMeU1qQTlNN0dYSlF3bXZYZ1IwQ0FoWVBiTi9BcHdhY010?=
 =?utf-8?B?MG9kMmNSUC8xS05HNC9XNnJDNnNZYTBhY0pGdmI4dmJEeFZkaWVCWGkxRGdm?=
 =?utf-8?B?cFFjc3pBNjVVZkxwQ3g1Q0kzcXh5TVZ2TWFNanVUQjBOMk4vOVNTMXRndGRI?=
 =?utf-8?B?QWVJV1lycUh5d0R5Q0pkSGpueVZFTzZsdEV2aG1CZzV1ZllmZkhXRzl1QVI2?=
 =?utf-8?B?TE0wT1ZaVUY2L2RrK01URDdkeHk4akNzSVZLajRWRVVSeHFXZ25LRHJ6Nisz?=
 =?utf-8?B?eTRMQWZYcHZJL3ZZOGp3Qms2WVgwWE85N2Fhb2laTWZFVUkrRE9NQ3l0T3ps?=
 =?utf-8?B?dElDOXgwdVRwdjJhV1FnT2pBaElUUUpPaWdFV0RmbnVRWTVlay9WZkhKSGMv?=
 =?utf-8?B?ZWltSXR1V2M2ZXl2UU5OYXZWWVhjbWl3bWl3Z3pHMW96QzkwQVBzOE5ZbU5i?=
 =?utf-8?B?aGU2NUlMTVk3VnVJNHp6TjFXNFhCVEF2NE03QkVUU29semxYbDZJS0s4VDBG?=
 =?utf-8?B?OUx4NXFTYXB6YWtUSWlFcVkyNi8vVFRJRzlzeHhUb01Dc1VFUnVmOG15M0ph?=
 =?utf-8?B?aDNYYzk1ZVEvakd4Ync3S3lDWmpLT0luNkdrZkpwZDlkY2h5eFhBNm9QZS9Q?=
 =?utf-8?B?b3lkSDd2amZlOVpwbW9IOE5lcUxNVkZrZzFhcXNmMjc4MThlNTFuSjhXZ1h3?=
 =?utf-8?B?a2V2WGpoYmVoWXpSbGY3ZU5SaWdFbG9aN3dWelV2RGQ1OU9KZ0JKT3dNNTRD?=
 =?utf-8?Q?JAPYwLBfgD44ocRLRf1+ozelvtUCgI7rXlSRE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB71C7C3B43CF44D85B32292568D5644@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NEqZBY/JTKzYO9BuXwnT/iTP5ccJbr7oJKr1RZDcwZZQBYcu3rFvAgl/p6QodpkC0m0BUZLW5gWfducMvDVklVeUsZ6+RkebsphOrykP5+sw11ZH+7PSS0LcAfzokUGtHau6e3LyrinNpazD64clWdJFNvsrRyFSPUYCMK3zIL7cVRNU+psWQiHHtz2VFgf9paWCF9sDxnad5RCl/n3l5lOHb+dRYDZwODszCB3nuRbAhhkzfW9h6URb1vHGjJUdy+WMuTFzzxG9pHAuqHUVpXQpK1FiCMFP5XfT3CS8Azj39Nhjs7GYHm+z92D+0E9M0YBsYGyDdjZxkkpLI3MIOw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf98356-2ec4-4f83-335a-08ded1b329c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 05:40:56.3167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZiLOy98cURro7CHer98LoncG/6CC5yMrrlX7EZ3Tg/C+49QQZS39lJBjM3KxKSRupjQRJd0Gqmn8qp0FClnJlXMMkJk3890AadkrgvLfEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10096
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

SnVzdCBub3RpY2VkIHRoYXQgdGhlIGNvbW1pdCB0aXRsZSBwcmVmaXggaXMgbm90IGNvcnJlY3Q6
IHNAaHcvaTM4Ni94ODYtaW9tbXU6QGludGVsX2lvbW11Og0KDQpjbWQNCg0KT24gVHVlLCAyMDI2
LTA2LTIzIGF0IDA1OjEyIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24gVHVlLCBKdW4gMjMsIDIwMjYgYXQg
MTA6MjI6MjNBTSArMDIwMCwgbm85MiB3cm90ZToNCj4NCj4gPiBXaXRoIHRoZSBjaGFuZ2VzIGlu
IGM3YjJlMjJiZDk1NywgdGhlIGBwdGAgYml0IHdhcyBzZXQgaW4gdGhlICh3cm9uZykNCj4gPiBj
YXBhYmlsaXR5IHJlZ2lzdGVyLCBpbnN0ZWFkIG9mIHRoZSAoY29ycmVjdCkgZXh0ZW5kZWQgY2Fw
YWJpbGl0eQ0KPiA+IHJlZ2lzdGVyLg0KPiA+DQo+ID4gRml4ZXM6IGM3YjJlMjJiZDk1NyAoImh3
L2kzODYveDg2LWlvbW11OiBSZW1vdmUgWDg2SU9NTVVTdGF0ZTo6cHRfc3VwcG9ydGVkIGZpZWxk
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBubzkyIDxbbGVvQG1hbmFnYXJtLm9yZ10obWFpbHRvOmxl
b0BtYW5hZ2FybS5vcmcpPg0KPiA+IFJldmlld2VkLWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYg
PFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAYnVsbC5jb20pPg0KPiA+IFJldmlld2VkLWJ5OiBZaSBMaXUgPFt5aS5sLmxpdUBpbnRl
bC5jb21dKG1haWx0bzp5aS5sLmxpdUBpbnRlbC5jb20pPg0KPiA+IC0tLQ0KPiA+IHYxOiBbaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDYyMjE2MjEzOC4xMDQ1MTcwLTEt
bGVvQG1hbmFnYXJtLm9yZy9dKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NjA2MjIxNjIxMzguMTA0NTE3MC0xLWxlb0BtYW5hZ2FybS5vcmcvKQ0KPg0KPg0KPiBjaGFuZ2Vz
IHNpbmNlIHYxPw0KPg0KPg0KPiA+ICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA0ICsrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4gPiBpbmRleCA3NDRjZGZkMmU2Li5kMWFmN2EzMTM1IDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PiA+IEBAIC00OTg4LDcgKzQ5ODgsNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJ
T01NVVN0YXRlICpzKQ0KPiA+ICB7DQo+ID4gICAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUg
PSBYODZfSU9NTVVfREVWSUNFKHMpOw0KPiA+DQo+ID4gLSAgICBzLT5jYXAgPSBWVERfQ0FQX0ZS
TyB8IFZURF9DQVBfTkZSIHwgVlREX0NBUF9ORCB8IFZURF9FQ0FQX1BUIHwNCj4gPiArICAgIHMt
PmNhcCA9IFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfCBWVERfQ0FQX05EIHwNCj4gPiAgICAg
ICAgICAgICAgIFZURF9DQVBfTUFNViB8IFZURF9DQVBfUFNJIHwgVlREX0NBUF9TU0xQUyB8IFZU
RF9DQVBfRFJBSU4gfA0KPiA+ICAgICAgICAgICAgICAgVlREX0NBUF9FU1JUUFMgfCBWVERfQ0FQ
X01HQVcocy0+YXdfYml0cyk7DQo+ID4gICAgICBpZiAoeDg2X2lvbW11LT5kbWFfdHJhbnNsYXRp
b24pIHsNCj4gPiBAQCAtNDk5OSw3ICs0OTk5LDcgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0
KEludGVsSU9NTVVTdGF0ZSAqcykNCj4gPiAgICAgICAgICAgICAgICAgICAgICBzLT5jYXAgfD0g
VlREX0NBUF9TQUdBV180OGJpdDsNCj4gPiAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgfQ0KPiA+
IC0gICAgcy0+ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlREX0VDQVBfSVJPOw0KPiA+ICsgICAgcy0+
ZWNhcCA9IFZURF9FQ0FQX1FJIHwgVlREX0VDQVBfSVJPIHwgVlREX0VDQVBfUFQ7DQo+ID4NCj4g
PiAgICAgIGlmICh4ODZfaW9tbXVfaXJfc3VwcG9ydGVkKHg4Nl9pb21tdSkpIHsNCj4gPiAgICAg
ICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX0lSIHwgVlREX0VDQVBfTUhNVjsNCj4gPiAtLQ0KPiA+
IDIuNTQuMA0KPg0KPg0K

