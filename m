Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8146DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1bV7-0007TM-OC; Wed, 24 Sep 2025 22:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bV2-0007SP-6y; Wed, 24 Sep 2025 22:14:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bUn-0008Iq-Uz; Wed, 24 Sep 2025 22:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJNdAhLHItXKQbQvmaiET66R4BpXioLBxT0lk8AEnhKqLdafXOzPwK682YqnSA+uTbmdCaIoxp3lhb12Gwkj+iWbFoilJHyJz4NnCCW0g90mGgr68PYjfG9zmleGQCYMZJQw9mdqmXFnaxwldgsyrY2oVZetwsaeHFavMorc1yFxANHH9RW+ouD85zjkkBJ2vUQa3JSOnJUfNCD1sEWCkSBNmo6vkze7gmUTgHSUqlo9+vQUud52rdrUKXyVnDgVdXGkrm+tid4ziyZ+dFPBkTVRLOWayZAb6wl9rYPBFzK/Dl9lbBuZlGy8BmKlIOYAvjcXQ+5kWrwFGf7v9u61vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIXE+pMR5L1rvWdKml0ZziAxc0jX8f3fIh4pQpKxZXE=;
 b=eyKVJIQZMpdu/cG8anMjyOXdKZi2mGvbvGq4oLFAbQ5lw998Pi3uGRboXQbcOtaMKz72gBdJ0a+sxDxBfo0oPAtELRlRO7ecrwqhImpERt++4AXJwaOxealhBJhuKuqhe1nmd+afFpDa6B5GV6zLZ/g2c5/7uuDyxDiSi17eFZApwh98f4a7POWvjtUe0S3MoE2mBnm6dT64p+EDJ6X5jqHKexiA0HFMn3+qwATion9lC2l60DlyfHhSN+jREpwCE8q8WmsWpeyRtKh+VljnpBVBTvm5zdSJIZsdbbyfMq5hOeB/wlV0lXcvwpqNGD05oDMc9ZCysrEK+TaZfIiOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIXE+pMR5L1rvWdKml0ZziAxc0jX8f3fIh4pQpKxZXE=;
 b=YYCp9mWO96/GZbTfn8jHFC8OdlVyCpENPTrzfdK+ZRGje2f1/5ptfU4Wc7gbxPmC+rAawf/vkW6uYGQPZyOvSeGECnALs/Np5EiIOcGOgqazA86GTqDj8thpNeQO67jSI13hOc3fUP3o2jAOEymDIA0wlMfH5qg+0ZkShtiTKemIKy8x3iAVTr9xFBlV4v6Dn9IEhWqtc2bAIPbts57hEQ7NrnC28YUcq33kj39CokPaXmFRAZAIk0SWueRebIE9Z2AZtJr4GwDX6q7hFLhJwo8GLjU0DVho8TJomWt/+MoYzF1CEnL7J7gZzoYZZGFvZ0kDHvoqIc0eyqUinu7naQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5803.apcprd06.prod.outlook.com (2603:1096:400:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:13:51 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Thu, 25 Sep 2025
 02:13:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 5/7] hw/arm/aspeed_ast27x0-fc: Replace error_abort with
 local errp
Thread-Topic: [PATCH v2 5/7] hw/arm/aspeed_ast27x0-fc: Replace error_abort
 with local errp
Thread-Index: AQHcLRfu0NukvabzQ06x8TCjBGxZhbSiG5CAgAEN/OA=
Date: Thu, 25 Sep 2025 02:13:50 +0000
Message-ID: <SI2PR06MB5041E1F957CFFB023B9037BAFC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-6-jamin_lin@aspeedtech.com>
 <87fc57a4-cbbb-4c57-877f-900089e0a715@kaod.org>
In-Reply-To: <87fc57a4-cbbb-4c57-877f-900089e0a715@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5803:EE_
x-ms-office365-filtering-correlation-id: 93293345-5f8c-4854-d05c-08ddfbd92b41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?emdtOHMyNjJYZ1grMWlSRzQ2WnNjQStwT2ZGbzZTYXMrRXhCblNGdXJEYURl?=
 =?utf-8?B?TW5Qd3dOMTdLdEE2NkhGbmJETTIyUFFseDN6WFdKL1RwVDFhS0NDSXhKbU9T?=
 =?utf-8?B?U1Y4RGh5eUJnWmhadUpLb0c5QlVlTzJ3aUp4Q00rUTNWMkM0VDRyL3cyZ2Vw?=
 =?utf-8?B?SnhFMHRFL3F4SmVRd2N6VjRrd3dvMVEzc1REeDI3RElpY1lPK2NQQTdLdDVU?=
 =?utf-8?B?VkJXQXF0eThBN1pNSGFQRHEwT2VRRVlkM2d1M1UzQjVDOGdRM2xOSjVac25D?=
 =?utf-8?B?bWc2QmJBcGVydWVZUzZhd25kZUFDMm9XVnMydGlBUDBYY3lXaGRycEtJSVpt?=
 =?utf-8?B?Nmh6L28yMTU1bktmdGZhemhna3VaSnd6WmVWN0UzNS9WQVVlWGhnVUhoMFlm?=
 =?utf-8?B?MDdQU1p1QXZ3NmNaUit6QnZJT0I1emVtNEc1UldKSnlwMTVCMEwxN0FEdlBx?=
 =?utf-8?B?QlkwN0xlV3BDa2RiY2JVR0cwcW9LNjJNSU51aGxoMmxwcStBK0dxc3lGQWlU?=
 =?utf-8?B?VDdoM2Y0ejR6Z1hCRVllem1YdVNZYWdQNUwwQndlT2szVGFHY2Q1d2FIREda?=
 =?utf-8?B?ajIvTmVqdWk4M3RRbjJKVUxUVHRUMmFkdTNsMTBFSHQ0clRVUWJFK3NJdkF6?=
 =?utf-8?B?RjhacWVjSkxYRHVrNVlTUmhNZVpjNWNFdkJBcysvTHBqOGlTWFdrbXJ6YVJ3?=
 =?utf-8?B?R0hoR1VXdWVXdVBpRVljcXFMRjhiY2RBeGRaUWlZSGhCb01JYXUwZGZKSkk0?=
 =?utf-8?B?TXpEam1mTkJvaFZOMEVVaDN2bk45d21BSmtoVDNVZHdTY0FGRWh6SDJkMlBX?=
 =?utf-8?B?WXVWQllhWUtCUmhCQXdWdEFaYllCblhQNDN2YXZWN0c5TTUzU3FWTW5jaFpt?=
 =?utf-8?B?SnZXWkFhUUdRR2xPL2Z1S3dkTUtLUWRkZ2ExNWQ5cnVucy9yenFkWGtPaWMz?=
 =?utf-8?B?dzI0d3VNMVlZYVB0UDVsbFlpZDZNUzdqWWNSZTF4OVdIU0Q2c0gvb1hpUXlV?=
 =?utf-8?B?UnBOeW5sUTMxMjluakQ3eENUbXZlKzJ3V0FPcHZHWVV1WDBoUzZBaThYdXNa?=
 =?utf-8?B?WlV5Y1pqZ0lNeTgyOHVmTFdnSGExa05Jckh2Tnk5enZRcUNYckxpa1RLZG5L?=
 =?utf-8?B?Tk15M3FYVzFVdFBPdXpBRmNoZUh0bGpaMFc0YmhGd0ZGaWpvZldwRzF5ZGE1?=
 =?utf-8?B?Z1g0TWs1Wlg4M0R3TXFNQUxSVmdSN2kzZkZBdHpMbGxjZGVtYzJrRk02NTM2?=
 =?utf-8?B?eTNiUnREeGVmTUVsZ0ZDSEdZTlluaXRMNHhiaW9JcjNwclV5TVhiY2pIa21K?=
 =?utf-8?B?N1VjK1l1SDB2OE03TG9OU3NRbUF0WGhVc3d4NFhsU3RxYlhPMlRiV1Q2OXhH?=
 =?utf-8?B?NFFWdVZtUE92SXRoRXQ3aTVDWGRFM1Z2U3ZycUtWdE5wTi9PaGluZUhRT2hy?=
 =?utf-8?B?SWtHQ0NDUlVSQUpBbFhXOGpMMGcweFl0UDVYemJiSnBKcitaUnJZd0pLdnEz?=
 =?utf-8?B?b2tsdE5Vcy93bU1hb2E3M1VXT28yTUhuYmZ4cEJBbHVRN1Npa1BrdXVWckhS?=
 =?utf-8?B?VkV5WWx4bmc1VWYvaUpPOXNXUjg1Qk5BWWhpYmdveXYwWk8wSUdEODE3LzVl?=
 =?utf-8?B?dnVuSlExRjErdDAyQjNPUm84TG04MmxzdXJjYVg1ZjkrT3UyNmo5dzlOYWRY?=
 =?utf-8?B?MEJCYlVsb0dBNUdBQVhBY294ZXJ2T2VuNEllYzZKOWRFZjN1YUNFMlI4b1pM?=
 =?utf-8?B?NERacC82UmI4TTlrSlZZYkhVUXgrcFp4NFpjUngzcXNHZncvK0ZHY29rclE1?=
 =?utf-8?B?MG9GUFZLVWxiWVVaRFdnMmphaVZJTzIxRENGcHdKc0o3cjR6dGdYaUVyMXli?=
 =?utf-8?B?bGhXV0Vtd3NpdmRJN3duc3VueWVhZ1Z4aktnUVA5dGVXUStQaXpIMTduampy?=
 =?utf-8?B?cER5cGgxYVM4V3hGczdKSC9lVXBuemFHT1FlWVI1b0hHbm4zakppK3FPTDBP?=
 =?utf-8?B?Zm0wNld0VzlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MENWN2FQeTg3MFVWMC9aakh2dmk0c3VpQ3dId2w2OHp0T2F0c2N3ZGc5MFVE?=
 =?utf-8?B?SlVQUHFNVEJtaDBYQWRHUmZwUExZTmxtMHkwcU5tUTZPRkFiTHdsNmZKNzY0?=
 =?utf-8?B?RzVpd1Q2dktGbktIejdtQVZ2dExoUHNCNW01MXNDNDdoKzFEemQvYUlQb3k2?=
 =?utf-8?B?OEh1cDJZbHFpOHRvaHF3dWFnVU1NbjNUQ1g4R3Z3Sm43VjhObnM3VkU4MmhD?=
 =?utf-8?B?alVQd0JESjdpakNjcUpuYTBoSlVkT0E4bExOK0MvOWM3QWFuQmJNenR6OGdR?=
 =?utf-8?B?R3dlN3Zia3M2dHcwbU8rdnV1M0pLVnh5RHJGMEtJQkVpYjZOeDV6YWhyck9K?=
 =?utf-8?B?V3ZPWEVVK0syMlZhYlJzQkJFZ0hab1JUN3pIc1NrbFlaeVFmcEtiKzZJU0xY?=
 =?utf-8?B?aXpnS2tYTHVIQmFSZVV6K0U0Y1RQeGdObnBlcWU2ZEQ2Mk5IcFlmbURhekFl?=
 =?utf-8?B?RkRIakNnZC94ZS9RNVZDU3IyaFFOY0gwWTd0TDhjTW1KMkhJWkhYMTdHcW5h?=
 =?utf-8?B?WVNHdURrSERSbk9vdG4yZzFWNUg5ZVBoLzl0d2IveHBMSVhvUmZKYXJnM2Fi?=
 =?utf-8?B?YkNoTytoem5DaUdkRXVhVVpZQjA3ckRRZFQxTTlCeFlaMlphcFJ4V0dNSE1L?=
 =?utf-8?B?azVLUnRnK0N4UURSYmhJTGJXSnZraFRic2JvQis0SnZseHhFUHZkQ3JCVENF?=
 =?utf-8?B?eWZ5dW1aZmsyK3NuQmhhNWNQNWdITWVRTFd6c3dBOWY2Z0p2RlBleTU5Qndi?=
 =?utf-8?B?MHNyTzV2SktGcklCaDFhZU1RdG1zSXI2T3FwTHV6S0loRUZ0c1dJTUwyTkhF?=
 =?utf-8?B?WGp6em5CdXQvcm4rVmZ5aHd5MStCalcrcE55Y0NVdTZVa2JWTklncjNWVHJy?=
 =?utf-8?B?aGQrODI1eDF0VWtIdFRwZnRieGIvV0djN1k0cCtaMHJrMFpQamcwMjNQUGxK?=
 =?utf-8?B?MkZLaEcyK3JQQXltOTBnN0JoK0sxTFY3Yk9LYWxMaUlPalpLVEY5SkVDcmtF?=
 =?utf-8?B?b09UaXV0RjFVNkFiVHlUZTRuT0ZZMkdWanlSbDFlUlZJUUJoVjRVZlJUZ045?=
 =?utf-8?B?dEpmYVB3YzM1OElBWnZlWVlzZDFGVzFZY1FDak1iZThyanE4MHA5Q1pIVWlE?=
 =?utf-8?B?V0pWSTlTaWJrcC9INGhYYUtwZFZ5SldKdUVzR2MyWFJoRDNuMEw5WkJHbFVL?=
 =?utf-8?B?aEpPL2xJd3hGZ2FmYmFRMTFFUmdQVHZTUXNoNDNDN2JRR0JVb2N4LzV6ZElo?=
 =?utf-8?B?amZhcmx5RnlHZUg3eEZXejFSSmd2NndxSEVPZFVaSzJQZ09ZS1VDeSt0dFRX?=
 =?utf-8?B?djdaRjZmN3RwdkxWZ21iQWM3WUFIODhCZDloMnZWNldoRy9ad0NmVXdBVWZ2?=
 =?utf-8?B?MDdSR2JHeERBM2VJRTB4dDJ1TVhzSWVVU1l2NlpUQkpFYU5jTkhZdElyNHZT?=
 =?utf-8?B?ZCtjZFA4RmdzRDlQMVV6emJaeXZrVTViWTNLM21IQ0hhU1VaSVBsV1VHZUNj?=
 =?utf-8?B?NmlzM1VFNG53T0hsT1hWUFNNeXU5all6M3l2MUwrL2ZNd29RM1BVdE1HZnZZ?=
 =?utf-8?B?V0hsOTJPcUpqMjhLM3k1dDFoTWxYYTVqUzRyT1BpUk9pcm1wWHhjMDN4WmhS?=
 =?utf-8?B?SStGUHA3WnQ0Qkh5OEpuM1lzQWJkRWZqUDJMRCtMQjNPemdKaVAzMElORUZj?=
 =?utf-8?B?OWsyQjl3d0RsQmpSelVLaURWT3M5YjFMZEpPVTBSY2d2OFA2aWxaSERIZFFF?=
 =?utf-8?B?U3V3SkdRZ1NjZ2RHK0Y1N0h3OUlQYmpxcHBvT0wyZDJ6ZU9xcFg4SUFNSXVU?=
 =?utf-8?B?cXNORFUydkxZNkx5WnBZcXV5UzgxZnlab3RldyswN2hHZmxhNzJoQ3Vldy9U?=
 =?utf-8?B?STM0RkZ4WFZKc09QVlRlaHNSYVJvaElWMHIrMlVPZWgzL0dWZHptWGF5OWtC?=
 =?utf-8?B?K1lnY1RSUUVoY0c3TDNwU0dPdHFSVEpFOFNNOHVQc1hSR0tveitJdlR3K0VW?=
 =?utf-8?B?VlVoQ1AzQy9TQ1ZydjN2ZDY2SXR4Q1czMktYdFRJZUJaYWN0ZzQ2YWptK3VK?=
 =?utf-8?B?WnRPVWxyajllazhBcWs0NlpGeHdvb0hVNUZCMENhYURvL24vNTdwOUNXMFVJ?=
 =?utf-8?Q?eKEFsoXs01oYMofMSkYRkZl1L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93293345-5f8c-4854-d05c-08ddfbd92b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:13:50.8600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9H/OjpmF5qTid8Ya1SZObneMzh9trab2z9WT2bu7wUYtbFUtURSYYs0o0tN1xBg2Am8tl5lYUTfPRuxDmdKGiRNrxBZ4juqCl1fldtV+WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5803
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS83XSBody9hcm0vYXNwZWVk
X2FzdDI3eDAtZmM6IFJlcGxhY2UgZXJyb3JfYWJvcnQNCj4gd2l0aCBsb2NhbCBlcnJwDQo+IA0K
PiBPbiA5LzI0LzI1IDA3OjU1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBpbnRy
b2R1Y2VzIGEgbG9jYWwgRXJyb3IgKiplcnJwID0gTlVMTCBhbmQgcmVwbGFjZXMNCj4gPiBlcnJv
cl9hYm9ydCB3aXRoIGVycnAgaW4gdGhlc2UgcGF0aHMuDQo+ID4NCj4gPiBUaGlzIG1ha2VzIGVy
cm9yIGhhbmRsaW5nIG1vcmUgY29uc2lzdGVudCB3aXRoIFFFTVUgZ3VpZGVsaW5lcyBhbmQNCj4g
PiBhdm9pZHMgdXNpbmcgZXJyb3JfYWJvcnQgaW4gY2FzZXMgd2hlcmUgZmFpbHVyZSBzaG91bGQg
bm90IGJlIHRyZWF0ZWQNCj4gPiBhcyBhIHByb2dyYW1taW5nIGVycm9yLg0KPiA+DQo+ID4gRGlz
Y3Vzc2lvbjoNCj4gPiBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoKSBjYW4gcmV0dXJuIGZhbHNl
IG9ubHkgd2hlbiBpdCBmYWlscywgYW5kIGl0DQo+ID4gc2V0cyBhbiBlcnJvciB3aGVuIGl0IGZh
aWxzLiBTaW5jZSBwYXNzaW5nICZlcnJvcl9hYm9ydCBjYXVzZXMgYW4NCj4gPiBhYm9ydCwgdGhl
IGZ1bmN0aW9uIG5ldmVyIHJldHVybnMgZmFsc2UsIGFuZCB0aGUgcmV0dXJuIHN0YXRlbWVudCBp
cw0KPiA+IGVmZmVjdGl2ZWx5IGRlYWQgY29kZS4gSWYgZmFpbHVyZSBpcyBjb25zaWRlcmVkIGEg
cHJvZ3JhbW1pbmcgZXJyb3IsDQo+ID4gdXNpbmcgJmVycm9yX2Fib3J0IGlzIGNvcnJlY3QuIEhv
d2V2ZXIsIGlmIGZhaWx1cmUgaXMgbm90IGENCj4gPiBwcm9ncmFtbWluZyBlcnJvciwgcGFzc2lu
ZyAmZXJyb3JfYWJvcnQgaXMgd3JvbmcsIGFuZCBlcnJwIHNob3VsZCBiZQ0KPiA+IHVzZWQgaW5z
dGVhZC4gVGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBsYXR0ZXIgYXBwcm9hY2ggYnkgcmVwbGFjaW5n
IGVycm9yX2Fib3J0DQo+IHdpdGggZXJycC4NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC8yMDI1MDcxNzAzNDA1NC4xDQo+ID4gOTAzOTkx
LTMtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLyMyNjU0MDYyNg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
ICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyB8IDI3ICsrKysrKysrKysrKysrKystLS0tLS0t
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jIGIv
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBpbmRleCA3MDg3YmU0Mjg4Li5iMTVjYjk0
YzM5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gKysr
IGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBAQCAtNjEsNiArNjEsNyBAQCBzdGF0
aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiA+ICptYWNoaW5lKQ0K
PiANCj4gDQo+IGFzdDI3MDBmY19jYTM1X2luaXQoKSwgYW5kIG90aGVycyBiZWxvdywgc2hvdWxk
IHRvIHRha2UgYW4gJ0Vycm9yICoqZXJycCcNCj4gcGFyYW1ldGVyIGFuZCByZXR1cm4gYSBib29s
LCB3aGljaCBzaG91bGQgYmUgZmFsc2UgaW4gY2FzZSBvZiBlcnJvci4gVGhlIGNhbGxlciwNCj4g
YXN0MjcwMGZjX2luaXQoKSB3b3VsZCB0aGVuIGNoZWNrIHRoZSByZXR1cm5lZCB2YWx1ZSBhbmQg
cG9zc2libHkgcmVwb3J0IHRoZQ0KPiBlcnJvci4NCg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3
IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBmaXggaXQuDQoNCj4gDQo+IEEgZ29vZCByZWFkaW5nIG9u
IHRoZSBlcnJvciB0b3BpYyBpcyBpbiBmaWxlICJpbmNsdWRlL3FhcGkvZXJyb3IuaCIuDQo+IA0K
PiA+ICAgICAgIEFzdDI3MDBGQ1N0YXRlICpzID0gQVNUMjcwMEExRkMobWFjaGluZSk7DQo+ID4g
ICAgICAgQXNwZWVkU29DU3RhdGUgKnNvYzsNCj4gPiAgICAgICBBc3BlZWRTb0NDbGFzcyAqc2M7
DQo+ID4gKyAgICBFcnJvciAqKmVycnAgPSBOVUxMOw0KPiA+DQo+ID4gICAgICAgb2JqZWN0X2lu
aXRpYWxpemVfY2hpbGQoT0JKRUNUKHMpLCAiY2EzNSIsICZzLT5jYTM1LCAiYXN0MjcwMC1hMSIp
Ow0KPiA+ICAgICAgIHNvYyA9IEFTUEVFRF9TT0MoJnMtPmNhMzUpOw0KPiA+IEBAIC03MSwyMCAr
NzIsMjAgQEAgc3RhdGljIHZvaWQgYXN0MjcwMGZjX2NhMzVfaW5pdChNYWNoaW5lU3RhdGUNCj4g
Km1hY2hpbmUpDQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGdldF9zeXN0
ZW1fbWVtb3J5KCksIDAsDQo+ID4gJnMtPmNhMzVfbWVtb3J5KTsNCj4gPg0KPiA+ICAgICAgIGlm
ICghbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmcy0+Y2EzNV9kcmFtLCBPQkpFQ1QoJnMtPmNhMzUp
LA0KPiAiY2EzNS1kcmFtIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBB
U1QyNzAwRkNfQk1DX1JBTV9TSVpFLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMEZDX0JNQ19SQU1fU0laRSwgZXJycCkpDQo+
IHsNCj4gPiAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPiAgICAgICBpZiAoIW9i
amVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoJnMtPmNhMzUpLCAibWVtb3J5IiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoJnMtPmNhMzVfbWVtb3J5
KSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCkp
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycnApKSB7DQo+ID4g
ICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICB9Ow0KPiA+ICAgICAgIGlmICghb2JqZWN0X3By
b3BlcnR5X3NldF9saW5rKE9CSkVDVCgmcy0+Y2EzNSksICJkcmFtIiwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVCgmcy0+Y2EzNV9kcmFtKSwNCj4gJmVycm9y
X2Fib3J0KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNU
KCZzLT5jYTM1X2RyYW0pLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gICAg
ICAgfQ0KPiA+ICAgICAgIGlmICghb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5j
YTM1KSwgInJhbS1zaXplIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QVNUMjcwMEZDX0JNQ19SQU1fU0laRSwNCj4gJmVycm9yX2Fib3J0KSkgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwRkNfQk1DX1JBTV9TSVpFLCBlcnJwKSkN
Cj4gew0KPiANCj4gb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoKSBpcyBjb25zaWRlcmVkIGFzIGEg
cm91dGluZSB3aGljaCBzaG91bGRuJ3QgZmFpbC4NCj4gU28gdGhlIGNvbW1vbiBwcmFjdGljZSBp
biBtb2RlbHMgaXMgdG8gcGFzcyAmZXJyb3JfYWJvcnQgYW5kIGlnbm9yZSB0aGUNCj4gcmV0dXJu
ZWQgdmFsdWUuDQo+DQpXaWxsIGZpeCBpdC4NCg0KVGhhbmtzLUphbWluDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAg
fQ0KPiA+DQo+ID4gQEAgLTk1LDE1ICs5NiwxNSBAQCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2Ez
NV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiAqbWFjaGluZSkNCj4gPiAgICAgICAgICAgfQ0KPiA+ICAg
ICAgIH0NCj4gPiAgICAgICBpZiAoIW9iamVjdF9wcm9wZXJ0eV9zZXRfaW50KE9CSkVDVCgmcy0+
Y2EzNSksICJody1zdHJhcDEiLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBU1QyNzAwRkNfSFdfU1RSQVAxLA0KPiAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEFTVDI3MDBGQ19IV19TVFJBUDEsIGVycnApKSB7DQo+
ID4gICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICB9DQo+ID4gICAgICAgaWYgKCFvYmplY3Rf
cHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJnMtPmNhMzUpLCAiaHctc3RyYXAyIiwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMEZDX0hXX1NUUkFQMiwNCj4gJmVy
cm9yX2Fib3J0KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBU1Qy
NzAwRkNfSFdfU1RSQVAyLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gICAg
ICAgfQ0KPiA+ICAgICAgIGFzcGVlZF9zb2NfdWFydF9zZXRfY2hyKHNvYywgQVNQRUVEX0RFVl9V
QVJUMTIsIHNlcmlhbF9oZCgwKSk7DQo+ID4gLSAgICBpZiAoIXFkZXZfcmVhbGl6ZShERVZJQ0Uo
JnMtPmNhMzUpLCBOVUxMLCAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gKyAgICBpZiAoIXFkZXZfcmVh
bGl6ZShERVZJQ0UoJnMtPmNhMzUpLCBOVUxMLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICByZXR1
cm47DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gQEAgLTEyNSw2ICsxMjYsOCBAQCBzdGF0aWMgdm9p
ZCBhc3QyNzAwZmNfc3NwX2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lKQ0KPiA+ICAgew0K
PiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzb2M7DQo+ID4gICAgICAgQXN0MjcwMEZDU3RhdGUg
KnMgPSBBU1QyNzAwQTFGQyhtYWNoaW5lKTsNCj4gPiArICAgIEVycm9yICoqZXJycCA9IE5VTEw7
DQo+ID4gKw0KPiA+ICAgICAgIHMtPnNzcF9zeXNjbGsgPSBjbG9ja19uZXcoT0JKRUNUKHMpLCAi
U1NQX1NZU0NMSyIpOw0KPiA+ICAgICAgIGNsb2NrX3NldF9oeihzLT5zc3Bfc3lzY2xrLCAyMDAw
MDAwMDBVTEwpOw0KPiA+DQo+ID4gQEAgLTEzNCwxMyArMTM3LDEzIEBAIHN0YXRpYyB2b2lkIGFz
dDI3MDBmY19zc3BfaW5pdChNYWNoaW5lU3RhdGUNCj4gPiAqbWFjaGluZSkNCj4gPg0KPiA+ICAg
ICAgIHFkZXZfY29ubmVjdF9jbG9ja19pbihERVZJQ0UoJnMtPnNzcCksICJzeXNjbGsiLCBzLT5z
c3Bfc3lzY2xrKTsNCj4gPiAgICAgICBpZiAoIW9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpF
Q1QoJnMtPnNzcCksICJtZW1vcnkiLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgT0JKRUNUKCZzLT5zc3BfbWVtb3J5KSwNCj4gJmVycm9yX2Fib3J0KSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKCZzLT5zc3BfbWVtb3J5KSwg
ZXJycCkpDQo+IHsNCj4gPiAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIHNvYyA9IEFTUEVFRF9TT0MoJnMtPnNzcCk7DQo+ID4gICAgICAgYXNwZWVkX3NvY191
YXJ0X3NldF9jaHIoc29jLCBBU1BFRURfREVWX1VBUlQ0LCBzZXJpYWxfaGQoMSkpOw0KPiA+IC0g
ICAgaWYgKCFxZGV2X3JlYWxpemUoREVWSUNFKCZzLT5zc3ApLCBOVUxMLCAmZXJyb3JfYWJvcnQp
KSB7DQo+ID4gKyAgICBpZiAoIXFkZXZfcmVhbGl6ZShERVZJQ0UoJnMtPnNzcCksIE5VTEwsIGVy
cnApKSB7DQo+ID4gICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICB9DQo+ID4gICB9DQo+ID4g
QEAgLTE0OSw2ICsxNTIsOCBAQCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfdHNwX2luaXQoTWFjaGlu
ZVN0YXRlDQo+ICptYWNoaW5lKQ0KPiA+ICAgew0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpz
b2M7DQo+ID4gICAgICAgQXN0MjcwMEZDU3RhdGUgKnMgPSBBU1QyNzAwQTFGQyhtYWNoaW5lKTsN
Cj4gPiArICAgIEVycm9yICoqZXJycCA9IE5VTEw7DQo+ID4gKw0KPiA+ICAgICAgIHMtPnRzcF9z
eXNjbGsgPSBjbG9ja19uZXcoT0JKRUNUKHMpLCAiVFNQX1NZU0NMSyIpOw0KPiA+ICAgICAgIGNs
b2NrX3NldF9oeihzLT50c3Bfc3lzY2xrLCAyMDAwMDAwMDBVTEwpOw0KPiA+DQo+ID4gQEAgLTE1
OCwxMyArMTYzLDEzIEBAIHN0YXRpYyB2b2lkIGFzdDI3MDBmY190c3BfaW5pdChNYWNoaW5lU3Rh
dGUNCj4gPiAqbWFjaGluZSkNCj4gPg0KPiA+ICAgICAgIHFkZXZfY29ubmVjdF9jbG9ja19pbihE
RVZJQ0UoJnMtPnRzcCksICJzeXNjbGsiLCBzLT50c3Bfc3lzY2xrKTsNCj4gPiAgICAgICBpZiAo
IW9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoJnMtPnRzcCksICJtZW1vcnkiLA0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKCZzLT50c3BfbWVtb3J5
KSwNCj4gJmVycm9yX2Fib3J0KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgT0JKRUNUKCZzLT50c3BfbWVtb3J5KSwgZXJycCkpDQo+IHsNCj4gPiAgICAgICAgICAg
cmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHNvYyA9IEFTUEVFRF9TT0MoJnMt
PnRzcCk7DQo+ID4gICAgICAgYXNwZWVkX3NvY191YXJ0X3NldF9jaHIoc29jLCBBU1BFRURfREVW
X1VBUlQ3LCBzZXJpYWxfaGQoMikpOw0KPiA+IC0gICAgaWYgKCFxZGV2X3JlYWxpemUoREVWSUNF
KCZzLT50c3ApLCBOVUxMLCAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gKyAgICBpZiAoIXFkZXZfcmVh
bGl6ZShERVZJQ0UoJnMtPnRzcCksIE5VTEwsIGVycnApKSB7DQo+ID4gICAgICAgICAgIHJldHVy
bjsNCj4gPiAgICAgICB9DQo+ID4gICB9DQoNCg==

