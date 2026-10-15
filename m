Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057E1CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHxT-0005ZH-5Y; Thu, 15 Oct 2026 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xHHxO-0005Yp-N8; Thu, 15 Oct 2026 05:41:02 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xHHxM-0006vn-7g; Thu, 15 Oct 2026 05:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1792057260; x=1823593260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cLGjH/8OwwaqPCVPocqjiSat334/Gty8IywqYwh+szs=;
 b=sZa6F+RK+JLG288wAUk6D/PVFscxJ1Vq4LUncdkDpUK2Tw09xjSFDB2Y
 INPDAtUb711FrYBs/tz0Cd68fq48wBwM+KjClJfLNj8YXnjisQJmhkYWD
 yFN9ZHdEfYOjFP2747D7CTlUOKkAhSOI05dnnW92tKo+zXGN6LWxS1G9e
 d+zvsAloIu5xydYihJ8a3gtF3fHJhrnEaDCTm3NDficDaWgfCDBBj//bf
 XmY8CHvk8I3FScklx/DVZ6ja/Me6XMsyrQ+EZKKbWQ1Da4C+ruAQftJ+Z
 l9waVPMhjChGhwRLjafoC3xJir0Zj0uGek0hju3SriqRs2suKjRIzPDM2 A==;
X-CSE-ConnectionGUID: MjUNyufZRI2T9KD6bvJfxA==
X-CSE-MsgGUID: +eLOIOqhTUaCRyYwm3Vzlg==
IronPort-SDR: 6ad09fa8_GKhGtVNDoRD5EB3XcsqBUO0tOSEaj8ZmeCCwhlMxfur8KwS
 8gmJjFLCLoliDNv+FxWHC8SnzuiSkJw86S6iRzg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; d="scan'208";a="48958239"
X-MGA-submission: =?us-ascii?q?MDHkTwl7JEJUK8/JpkVKTB3h2iKFFhmAUmRGi2?=
 =?us-ascii?q?Hp7GebTsBGeMvjWDrxYy8b/Am+jNhGQsZ6e2T4Hm4OuOCC2p7VNBKoVl?=
 =?us-ascii?q?jsGyVFShAcdBbEdtsCWAU7Xpe/rrlzX5XbMMreLgmtX1Ve4ubBYHc3I5?=
 =?us-ascii?q?3KxlvtRBJAglNWSSLIX+WpCw=3D=3D?=
Received: from mail-francesouthazon11011035.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.35])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Oct 2026 11:40:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3L4MXvCrwK1Pfw0Y5ycbkem9b82uaco+gdYjY814r8Or6wLVTx0n4mbH5BLISFuYV7JtKd4XjAw//SM2TXJN2P//AOX5VhoJMRM/DMZbtrONIBEwNdz8xblwTnK+2+b9ajONCAirgfRp37H0I2MsKkMMlguRRPe4Goi/U5zRrsSWlSbP4wr5psmjScGgSskGVydMhHqDgKKPS/mTSeDhvwZsqVLDpqo4MI71kDgTQksadIwGnFypItEhUKuyqmnHmt0cKKwmqdkbNTDIbAsL10n8GOQeJz3yHcRtLJFKqGY06vcevHfCVHFV2hHyBvbK/GxAF/rE6bgfcp905L4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLGjH/8OwwaqPCVPocqjiSat334/Gty8IywqYwh+szs=;
 b=lvhKR+BHv9IvyECLaWslWqyvDoxQ+sf0hB3WA/CtwKdTiu6Ql35YKvXOoMJONX8bVYWUJ4+NiU9hlkwuE0EGKMYS+yJHhA5JNA3Lw0YhNSxHC+ha0/S63x9intoiIcsKUTRuM9Gyr6euPBJItk1ASrDM0O2H3zkTEvsoAtCIenPmrQVjO0JGbTROBRcjHNrvYJm52GZHxH6FjBbjndLhaPhJ0xVFgHZ+26pa7+2cex8cpUYFXdSbUMUe5x4wpSp15rn2/tZVPJWdEwhFo+cKG/G+vB2RyFxcWdiy0G0hGzT4yvU+0IQnWvzvS2bxMpGafCwYRKRLBCqkktlpRiat8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by MI7PR07MB072969.eurprd07.prod.outlook.com (2603:10a6:290:103::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:40:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:40:49 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "artem_mygaiev@epam.com"
 <artem_mygaiev@epam.com>, "volodymyr_babchuk@epam.com"
 <volodymyr_babchuk@epam.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "francisco.iglesias@amd.com"
 <francisco.iglesias@amd.com>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "eugene@nuvacore.ai" <eugene@nuvacore.ai>, "Ruslan_Ruslichenko@epam.com"
 <Ruslan_Ruslichenko@epam.com>, "takahiro.nakata.wr@renesas.com"
 <takahiro.nakata.wr@renesas.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Xu <peterx@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v2 12/20] system/physmem: Add ats_do_translate helper
Thread-Topic: [PATCH v2 12/20] system/physmem: Add ats_do_translate helper
Thread-Index: AQHdWx731X0JMc9Ev0+s73m4HQw/Y7b8s+KAgAGoZAA=
Date: Thu, 15 Oct 2026 09:40:49 +0000
Message-ID: <d29965e800482e96e8f42c8307900f665eb61a69.camel@bull.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-13-ruslichenko.r@gmail.com>
 <07181e2fc148dce3c2152f450e9337b4b9a21f16.camel@bull.com>
 <011b142e-feae-47e0-9c67-6cc7277c5113@gmail.com>
In-Reply-To: <011b142e-feae-47e0-9c67-6cc7277c5113@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|MI7PR07MB072969:EE_
x-ms-office365-filtering-correlation-id: 251f7c3c-e66d-40d4-da10-08df2aa0654a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|11063799006|4143699003|261009221227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|10063799003;
x-microsoft-antispam-message-info: 9iYSbs0Vj41w71qWVQt0W6qoWJNz3N8w09yX2gQa8KnILuFk9kXfXmL+2uccaa4a+TvOp4oszz110/w23N3T3adULxKPfsGvJDMubhnJESLYE4iK/UJHNkjd4c6ISKvegImAtqJxA4//tWgfF5ADZugynT9Qlf/6FzwHMrZ5bIGnJveyCB9B3s/n8x/n/nTA1kOTRrWP2XJ1SCevFIJ/9+AsKUzMJ0eEJvNPdeGBh+9UBPj9MEDWAoA0GOrOb8l2snmkxdUC9h42I9e7EhYmQNJDRlCkf78bOaxXSgLvcFOEwvxh0dciWp7GM50+RCbW314DjRWTDK2FKzcDveRl/iwVVS6KcQfbEb6ciI39JW5hMPOCzWhUetOq02c71MoFSyL079PmYQhGWdi8x36+jkDJzgeaptAP7K6AebPQ07slT45sNvhKEhU79WNQmuGRnQ2L9DVYM7RFDBKXbYwtIoUNXVOFjC3gOilBbcTmVXu5krSHtYjyHKecHAOfD2XEPNh5c/MzZjDwAottqEqVeEBu8OsFHIHiI0z+l6E9QPVYv/x0YFRIuZmW5WicQjIGsbpaitSetsu4troMhqaNrAnbgqUM2Ix/hKqj3W8oaRcrvZ0pQFzqdACZZSulwjnxdSTREz1vTFJgXBKvqlaXUxG3awf6Tb8GmYQMTuhpbCZnDpx1PrIJPEd+0C0ppzWWNigBoetjUCkZL2S+BVCv5hf3UY7yLOQvhIrpnvD5s9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(10063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTdPWXY3ai9vZ3Y1ZVREazErdmhjWEhLMDlVS0pDWjMvUzQzYWNYaFhUb1RV?=
 =?utf-8?B?SVdjYnQrblRkU08vYXNUaFZBNCtUcUx4cm9iYmJ2dUJuM1ZqZGlKdGl2VDhQ?=
 =?utf-8?B?OUJRMUQ0NlBYeW1hWk9EbVhucDZEMmU0TWFEb1o2TGc3SGs0dTFuL1pYSXhG?=
 =?utf-8?B?L2FtNE1WYlMvbkZPWkFKZ1ZSWFQyV3MydkNxMEM2akpZOGEvalZLcHVDcDg0?=
 =?utf-8?B?SnFDNmdNemR0MTdxZFhsNXRiZm0vT3RYOGRjQ2g1aHlJSFVMQnhJcHZWQlBI?=
 =?utf-8?B?bDVpeThGWDJXTFB3WWd5YVBiUk5OeGJWRTBpcjNoVWtkcWswVENHSjVmbm1a?=
 =?utf-8?B?NzMyMnlJUzIvQXJiMVUxTmFjUVdrNGRXdW5SeDJtK2o5c09GSUJyc3BLV3Fw?=
 =?utf-8?B?ZElMTlNaOEdxc0xFaU1Ma3JVM0pmbjZGSUh1cDBaYlRRRGg3N2k0QnNyVGhU?=
 =?utf-8?B?M0RJRFNLbjFqY3RkK0FPUjZNcWlRUzZVUm9nQTdpY1JQbnB2ZnJVendMSFpI?=
 =?utf-8?B?VzRsT3Zwc095QnJXblg2Y0ZDNytjTG1mRGhlNFNLYnJSdDlndFhQTjc3bU9Y?=
 =?utf-8?B?S2l1RENFajFvV3o5bTNJMERwUkJjUHo0V1c1a3VlQ1RMQ2l5MzFxWlNmTVRS?=
 =?utf-8?B?aWdXTFdoWERlbDMwbk1VN0F1WG1ibk9LWDFEbGJQcGdPcElBNkNJcmN4aElP?=
 =?utf-8?B?Q3YwL3dqWXRXcXhvbE5CaThhSm1zYVo1TnozeUo2Q0s2YlJEaFBFTWd5V1Ay?=
 =?utf-8?B?R2JaZXl2UytERkZHcit5SkZOYllSeHNmVDBMekdLQ2FuWE10alZOZThDeERa?=
 =?utf-8?B?OUs2YXZQMjlSWDBUK3BicmF4NmxKVWtYdGtSK2xnMXhraVpjRXVDZVg0NkJX?=
 =?utf-8?B?MDBMQXI5SE54djUxWWtFSjBBWTlIQ1NscmE5d1pZeEJZSVp6bVd3Z3ZTYTVr?=
 =?utf-8?B?S2MrT0tVWVJQVk5xV1hmaThIbWpXY2VhUjlIb3I5cjNvWTZkK0lSRlNkemxQ?=
 =?utf-8?B?SmpCVlpNdkZnUkhaMVBwQUVPYXhJc2pqMHpFZW4va3QwOVhKakp5OXhGZEt0?=
 =?utf-8?B?WEowcFZLNnltenBWTHhZc2N2QkhJbXBKRFNjNkNBYkJwd2pjdFAwdHkwdUwv?=
 =?utf-8?B?ZnpNeER5OHowVlMyemRVOTI0ZHFZRjViQlRHNXh6UGIwM05uTDlRek0zVHpG?=
 =?utf-8?B?d2I5UmdTRHd2NFhrbVhxcG9CSjdJRjBaa2xadlQ3bGt4VnZaUm1RdzkzZG5t?=
 =?utf-8?B?UVlSTlNIalAzcXhZTEc2NGtrdUQvZVVZc0Fjd3NrSm8vN3EwSlZPUTI1Wllp?=
 =?utf-8?B?NFEyYnQ4RXgyTVhHZ1k0WDQ0MXJBWFF0bjRKZU1Ec1dEbkU0YWlnYTZyRUtP?=
 =?utf-8?B?dWNDMFJIK3lhcHE0OXVuNzRHZmRzVURzb21tVDZpcjN2VzlQNHIrNTYrbjJv?=
 =?utf-8?B?WVhmM1dBSW5iTUs0akQxMVZTRFd1UEpzbVFlaEdKbjlPVWh3OEp4bElOTTJZ?=
 =?utf-8?B?aWVaQkd6ckE4c1N5OW9EN1F5TXB1VTlkVjlUczh6dmt1LzBkd0MwZWlSYXZu?=
 =?utf-8?B?VlBWTWVyV1YxVDBLcEZyS0FhaGdUNkxqU0ZvWFpLdjRUU2hOTUpLdEpaN0pv?=
 =?utf-8?B?c25mZlA2YTRkYmtqZXNZRlhwVEFPcmJrQkttbnhrMVZscHhhQXlsaThBTHBm?=
 =?utf-8?B?RFVzdFhMRWdQQnZDZDlPWjNxZEFqU3VHWDNpZXB5KzFGd3Nrc2RlS3V0RDc0?=
 =?utf-8?B?VUdZSUErTlFpRE92MjNtY3B2MTdLVlBMNlRxUjhvUm44MnRqS3JNTjlOaXZT?=
 =?utf-8?B?Y1Fhc3hCY25CcXE4L2pvVjdCMHovVDlaK21uVFpMSStjTUIzbkdYdEIzYzh4?=
 =?utf-8?B?clBxRTFQWThUZFlTSHI5ZEYxTVVhY2ZXYStoNVExclJlZlFQUHJGNzFWUHNL?=
 =?utf-8?B?NFVLTWQrcm8yYSs3Mmcva3BVRk1DaWFiUEpLdHBmbTYzaWRQMVVBT2wybXVT?=
 =?utf-8?B?bWFrRUVkbGdBOVpoTzJCYStCYTIrYVFGZlhIWWtoUW1TdWZqWndra09zbSty?=
 =?utf-8?B?bmRGMk5SLzR6RzNmRkVJMnNqOTRSZm9rMlYzQW5uYXhrUEhYV0tldVFoZkd0?=
 =?utf-8?B?UjJneVhOVXQybHlDSU96Z1lTV21hTUh5azhYaVhpUENyTlMrZWFlTUVubXpL?=
 =?utf-8?B?SkR5aUZiMDBlZmFGR1JPaSthNWIwcm92d2l0NklGVnorN0lNTVFUc1EvUUZY?=
 =?utf-8?B?SFV6UDlmeXlVSjQ1VWptU01RbXFjeFlKZ0RPQmVJMFJPS2IvcWcyLzNJOGV4?=
 =?utf-8?B?M2hmRUZETEtUdnpOWVZRN1RuZ3RIRlJpWGN6dER3Q1JpSFpRRFZQUVNXaWRh?=
 =?utf-8?Q?slNoh4eHSxc6yMwHeHdueEcbxKVvTUIRrIQEL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <677558784E0AB14586B88F2E82D5909A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ms4Zhu0ohDOR1apbRbSuEOx7NRJiiyq/zucAwa8+dd7XbxfKUeUD19aQ9emMC8ZzcFvvzF6QtzoFDcpXk8dGnV6Lz/osX3Cte/nME1fjGyj9jGVpdYaN413Y9DEBoNDdhM66wxz1AenX/mTVY9WfCRE6Clp3nVYdZPvJGx19BLOsZ2falxqsvZCJjkQzGM4LkywkRSr0AtWTfYis8nWAgn8Jgr7FyRSZQHTz0ry1lYsIZzDuQMXJL5ZoTMsEz84DQBaksMnXCvkB09ocOc5+GvW/pYA/nVd0VKiZlU4a8KAkPji/rZYcTt+bToAXep/Wo/NMGGjzflPVeo1myODiRg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f7c3c-e66d-40d4-da10-08df2aa0654a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:40:49.1905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GqJASV/DJvIl3f9JgZ1WPBS9Iqyx6/shN+JaIvpU6AvRZeuT6nMCDVegsf8bMTft7m/THKZjMpOPayYt7D4ygWc9c/pku3lQHa91rQ/uik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR07MB072969
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

DQpPbiBXZWQsIDIwMjYtMTAtMTQgYXQgMTA6MjEgKzAyMDAsIFJ1c2xhbiBSdXNsaWNoZW5rbyB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDEwLzEz
LzI2IDE2OjI3LCBDbMOpbWVudCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPiANCj4gPiBEbyB5b3Ug
bmVlZCB0byBvcGVyYXRlIGF0IHBoeXNtZW0gbGV2ZWw/DQo+ID4gV2UgaGF2ZSBhbiBBUEkgZm9y
IFBDSSBkZXZpY2UgZm9yIEFUUyBhbmQgUFJJIChzZWUgcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0
aW9uIGFuZCBwY2lfcHJpX3VucmVnaXN0ZXJfbm90aWZpZXIpDQo+ID4NCj4gDQo+IA0KPiBUaGlz
IGhlbHBlciBpcyB1c2VkIGJ5IFJlbW90ZS1Qb3J0LUFUUyBkZXZpY2UsIHdoaWNoIGlzIHVzZWQg
Zm9yIHJlc29sdmluZyBBVFMgcmVxdWVzdHMgZnJvbSByZW1vdGUgbWFzdGVycyB2aWEgUmVtb3Rl
UG9ydCBsaW5rIGFuZCBpdCBpcyBUWVBFX0RFVklDRSBpdHNlbGYuICANCj4gQXMgaXQgaXMgbm90
IGEgUENJIGRldmljZSBpdHNlbGYsIHdlIGNhbm5vdCB1c2UgUENJIEFQSSB1bmZvcnR1bmF0ZWx5
Lg0KPiANCg0KT2ssIEkgc2VlLA0KDQpUaGUgaXNzdWUgSSBzZWUgaGVyZSBpcyB0aGF0IHdlIGFy
ZSBiYXNpY2FsbHkgcmUtaW1wbGVtZXRpbmcgd2hhdCBJT01NVXMgYWxyZWFkeSBkbyB0aHJvdWdo
IHRoZSBQQ0kgQVBJLiAgDQpJdCBsb29rcyBsaWtlIHRoZXJlIGlzIGEgcmlzayBoZXJlIGFzIHNv
bWUgSU9NTVVzIG1pZ2h0IHdhbnQgdG8gdXBkYXRlIHRoZWlyIHN0YXRlIHdoZW4gYmVpbmcgY2Fs
bGVkIG9uIEFUUy9QUkksIHdoaWNoIHdvbid0IGJlIGRvbmUgaGVyZS4NCg0KSSdtIG5vdCBzdXBl
ciBmYW1pbGlhciB3aXRoIFJlbW90ZVBvcnQgYnV0IEkgaGF2ZSBhIGhpZ2ggbGV2ZWwgb3ZlcnZp
ZXcgb2Ygd2hhdCBzb21lIGNvbXBhbmllcyBkbyB0byBicmlkZ2UgcnRsIHNpbXVsYXRvcnMgd2l0
aCBhIFBDSSBidXMgaW4gUWVtdS4gIA0KSUlVQywgdGhlIGJ1cyB0eXBlIG9mIHRoZSBzaW11bGF0
b3IgaXMga25vd24sIGFuZCB0aGVpciBicmlkZ2UgYWxsb2NhdGVzIGFuIGVtdWxhdGVkIGRldmlj
ZSBvZiB0aGUgbWF0Y2hpbmcgdHlwZSBpbiBRZW11IHNvIHRoZXkgY2FuIGNhbGwgdGhlIG9mZmlj
aWFsIEFQSXMgYXMgaWYgdGhlcmUgd2FzIGEgInJlYWwiIGVtdWxhdGVkIGRldmljZS4NCg0KSW4g
eW91ciB1c2UgY2FzZSwgd2hhdCBraW5kIG9mIGRldmljZXMgYXJlIHlvdSBydW5uaW5nIGluIHRo
ZSBleHRlcm5hbCBzaW11bGF0b3I/IFBDSSBJIGd1ZXNzPw0KDQo+IA0KPiA+IE9uIFR1ZSwgMjAy
Ni0wOS0xNSBhdCAxODowMCArMDIwMCwgUnVzbGFuIFJ1c2xpY2hlbmtvIHdyb3RlOg0KPiA+IA0K
PiA+ID4gRnJvbTogUnVzbGFuIFJ1c2xpY2hlbmtvIDxbW1J1c2xhbl9SdXNsaWNoZW5rb0BlcGFt
LmNvbV0obWFpbHRvOlJ1c2xhbl9SdXNsaWNoZW5rb0BlcGFtLmNvbSldKG1haWx0bzpbUnVzbGFu
X1J1c2xpY2hlbmtvQGVwYW0uY29tXShtYWlsdG86UnVzbGFuX1J1c2xpY2hlbmtvQGVwYW0uY29t
KSk+DQo+ID4gPiANCj4gPiA+IEFkZCAnYXRzX2RvX3RyYW5zbGF0ZScgbWV0aG9kIHRvIGVuYWJs
ZSBtYW51YWwgSU9NTVUgYWRkcmVzcw0KPiA+ID4gdHJhbnNsYXRpb24uDQo+ID4gPiANCj4gPiA+
IFRoaXMgYWxsb3dzIHRoZSBSZW1vdGUgUG9ydCBzdWJzeXN0ZW0gdG8gcmVzb2x2ZSBndWVzdCB2
aXJ0dWFsDQo+ID4gPiBhZGRyZXNzZXMgdG8gcGh5c2ljYWwgYWRkcmVzc2VzIGJ5IHF1ZXJ5aW5n
IHRoZSBRRU1VIElPTU1VDQo+ID4gPiB0cmFuc2xhdGlvbiBwaXBlbGluZS4gVGhpcyBpcyByZXF1
aXJlZCBmb3IgdGhlIFJlbW90ZSBQb3J0DQo+ID4gPiBzdWJzeXN0ZW0gdG8gc3VwcG9ydCB0cmFu
c2xhdGlvbsKgIHJlcXVlc3RzIGZyb20gZXh0ZXJuYWwgbWFzdGVycw0KPiA+ID4gaW4gYSBjby1z
aW11bGF0aW9uIGVudmlyb25tZW50Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFZGdh
ciBFLiBJZ2xlc2lhcyA8W1tlZGdhci5pZ2xlc2lhc0BhbWQuY29tXShtYWlsdG86ZWRnYXIuaWds
ZXNpYXNAYW1kLmNvbSldKG1haWx0bzpbZWRnYXIuaWdsZXNpYXNAYW1kLmNvbV0obWFpbHRvOmVk
Z2FyLmlnbGVzaWFzQGFtZC5jb20pKT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRha2FoaXJvIE5h
a2F0YSA8W1t0YWthaGlyby5uYWthdGEud3JAcmVuZXNhcy5jb21dKG1haWx0bzp0YWthaGlyby5u
YWthdGEud3JAcmVuZXNhcy5jb20pXShtYWlsdG86W3Rha2FoaXJvLm5ha2F0YS53ckByZW5lc2Fz
LmNvbV0obWFpbHRvOnRha2FoaXJvLm5ha2F0YS53ckByZW5lc2FzLmNvbSkpPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogUnVzbGFuIFJ1c2xpY2hlbmtvIDxbW1J1c2xhbl9SdXNsaWNoZW5rb0BlcGFt
LmNvbV0obWFpbHRvOlJ1c2xhbl9SdXNsaWNoZW5rb0BlcGFtLmNvbSldKG1haWx0bzpbUnVzbGFu
X1J1c2xpY2hlbmtvQGVwYW0uY29tXShtYWlsdG86UnVzbGFuX1J1c2xpY2hlbmtvQGVwYW0uY29t
KSk+DQo+ID4gPiAtLS0NCj4gPiA+IMKgaW5jbHVkZS9zeXN0ZW0vbWVtb3J5LmggfMKgIDggKysr
KysrKw0KPiA+ID4gwqBzeXN0ZW0vcGh5c21lbS5jwqDCoMKgwqDCoMKgwqAgfCA1MyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDYxIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
c3lzdGVtL21lbW9yeS5oIGIvaW5jbHVkZS9zeXN0ZW0vbWVtb3J5LmgNCj4gPiA+IGluZGV4IGE3
ZTAzZmMzZTcuLjIwMzJkMzAyOGQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL3N5c3RlbS9t
ZW1vcnkuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vbWVtb3J5LmgNCj4gPiA+IEBAIC0y
NTgzLDYgKzI1ODMsMTQgQEAgc3RhdGljIGlubGluZSBNZW1vcnlSZWdpb24gKmFkZHJlc3Nfc3Bh
Y2VfdHJhbnNsYXRlKEFkZHJlc3NTcGFjZSAqYXMsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkciwgeGxhdCwgbGVu
LCBpc193cml0ZSwgYXR0cnMpOw0KPiA+ID4gwqB9DQo+ID4gPiANCj4gPiA+ICtNZW1vcnlSZWdp
b24gKmF0c19kb190cmFuc2xhdGUoQWRkcmVzc1NwYWNlICphcywNCj4gPiA+ICvCoMKgwqAgaHdh
ZGRyIGFkZHIsDQo+ID4gPiArwqDCoMKgIGh3YWRkciAqeGxhdCwNCj4gPiA+ICvCoMKgwqAgaHdh
ZGRyICpwbGVuX291dCwNCj4gPiA+ICvCoMKgwqAgQWRkcmVzc1NwYWNlICoqdGFyZ2V0X2FzLA0K
PiA+ID4gK8KgwqDCoCBpbnQgKnByb3QsDQo+ID4gPiArwqDCoMKgIE1lbVR4QXR0cnMgYXR0cnMp
Ow0KPiA+ID4gKw0KPiA+ID4gwqAvKiBhZGRyZXNzX3NwYWNlX2FjY2Vzc192YWxpZDogY2hlY2sg
Zm9yIHZhbGlkaXR5IG9mIGFjY2Vzc2luZyBhbiBhZGRyZXNzDQo+ID4gPiDCoCAqIHNwYWNlIHJh
bmdlDQo+ID4gPiDCoCAqDQo+ID4gPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3BoeXNtZW0uYyBiL3N5
c3RlbS9waHlzbWVtLmMNCj4gPiA+IGluZGV4IGE0YTZhNDcxMGMuLjFhY2RhMjJlZGUgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9zeXN0ZW0vcGh5c21lbS5jDQo+ID4gPiArKysgYi9zeXN0ZW0vcGh5c21l
bS5jDQo+ID4gPiBAQCAtNTI1LDYgKzUyNSw1OSBAQCBzdGF0aWMgTWVtb3J5UmVnaW9uU2VjdGlv
biBmbGF0dmlld19kb190cmFuc2xhdGUoRmxhdFZpZXcgKmZ2LA0KPiA+ID4gwqDCoMKgwqAgcmV0
dXJuICpzZWN0aW9uOw0KPiA+ID4gwqB9DQo+ID4gPiANCj4gPiA+ICsvKiBUaGlzIGZ1bmN0aW9u
IGlzIGNhbGxlZCBmcm9tIFJDVSBjcml0aWNhbCBzZWN0aW9uICovDQo+ID4gPiArTWVtb3J5UmVn
aW9uICphdHNfZG9fdHJhbnNsYXRlKEFkZHJlc3NTcGFjZSAqYXMsDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRk
ciBhZGRyLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBod2FkZHIgKnhsYXQsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciAqcGxl
bl9vdXQsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEFkZHJlc3NTcGFjZSAqKnRhcmdldF9hcywNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50ICpwcm90LA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNZW1UeEF0dHJzIGF0dHJzKQ0KPiA+ID4gK3sNCj4gPiA+
ICvCoMKgwqAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbjsNCj4gPiA+ICvCoMKgwqAgSU9N
TVVNZW1vcnlSZWdpb24gKmlvbW11X21yOw0KPiA+ID4gK8KgwqDCoCBod2FkZHIgcGxlbiA9ICho
d2FkZHIpKC0xKTsNCj4gPiA+ICvCoMKgwqAgRmxhdFZpZXcgKmZ2ID0gYWRkcmVzc19zcGFjZV90
b19mbGF0dmlldyhhcyk7DQo+ID4gPiArwqDCoMKgIElPTU1VTWVtb3J5UmVnaW9uQ2xhc3MgKmlt
cmM7DQo+ID4gPiArwqDCoMKgIElPTU1VVExCRW50cnkgaW90bGI7DQo+ID4gPiArwqDCoMKgIGlu
dCBpb21tdV9pZHggPSAwOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCBpZiAoIXBsZW5fb3V0KSB7
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgcGxlbl9vdXQgPSAmcGxlbjsNCj4gPiA+ICvCoMKgwqAg
fQ0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCAvKiBUaGlzIGNhbiBiZSBNTUlPLCBzbyBzZXR1cCBN
TUlPIGJpdC4gKi8NCj4gPiA+ICvCoMKgwqAgc2VjdGlvbiA9IGFkZHJlc3Nfc3BhY2VfdHJhbnNs
YXRlX2ludGVybmFsKA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhdHZpZXdfdG9f
ZGlzcGF0Y2goZnYpLCBhZGRyLCB4bGF0LA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGxlbl9vdXQsIHRydWUpOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCAvKiBJbGxlZ2FsIHRyYW5z
bGF0aW9uICovDQo+ID4gPiArwqDCoMKgIGlmIChzZWN0aW9uLT5tciA9PSAmaW9fbWVtX3VuYXNz
aWduZWQpIHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4gPiA+ICvCoMKg
wqAgfQ0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoCBpb21tdV9tciA9IG1lbW9yeV9yZWdpb25fZ2V0
X2lvbW11KHNlY3Rpb24tPm1yKTsNCj4gPiA+ICvCoMKgwqAgaWYgKCFpb21tdV9tcikgew0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOw0KPiA+ID4gK8KgwqDCoCB9DQo+ID4gPiAr
DQo+ID4gPiArwqDCoMKgIGltcmMgPSBtZW1vcnlfcmVnaW9uX2dldF9pb21tdV9jbGFzc19ub2No
ZWNrKGlvbW11X21yKTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqAgaWYgKGltcmMtPmF0dHJzX3Rv
X2luZGV4KSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfaWR4ID0gaW1yYy0+YXR0cnNf
dG9faW5kZXgoaW9tbXVfbXIsIGF0dHJzKTsNCj4gPiA+ICvCoMKgwqAgfQ0KPiA+ID4gKw0KPiA+
ID4gK8KgwqDCoCBpb3RsYiA9IGltcmMtPnRyYW5zbGF0ZShpb21tdV9tciwgYWRkciwgSU9NTVVf
Uk8sIGlvbW11X2lkeCk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgICp4bGF0ID0gKChpb3RsYi50
cmFuc2xhdGVkX2FkZHIgJiB+aW90bGIuYWRkcl9tYXNrKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAoYWRkciAmIGlvdGxiLmFkZHJfbWFzaykpOw0KPiA+ID4gK8KgwqDCoCAqcGxl
bl9vdXQgPSBNSU4oKnBsZW5fb3V0LCAoYWRkciB8IGlvdGxiLmFkZHJfbWFzaykgLSBhZGRyICsg
MSk7DQo+ID4gPiArwqDCoMKgICpwcm90ID0gaW90bGIucGVybTsNCj4gPiA+ICvCoMKgwqAgKnRh
cmdldF9hcyA9IGlvdGxiLnRhcmdldF9hczsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqAgcmV0dXJu
IHNlY3Rpb24tPm1yOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+IMKgLyogQ2FsbGVkIGZyb20g
UkNVIGNyaXRpY2FsIHNlY3Rpb24gKi8NCj4gPiA+IMKgSU9NTVVUTEJFbnRyeSBhZGRyZXNzX3Nw
YWNlX2dldF9pb3RsYl9lbnRyeShBZGRyZXNzU3BhY2UgKmFzLCBod2FkZHIgYWRkciwNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc193cml0ZSwgTWVtVHhBdHRy
cyBhdHRycykNCj4gPg0KPiANCj4g

