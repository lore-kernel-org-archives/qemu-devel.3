Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB64AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzsR-0001i9-IF; Tue, 25 Jun 2024 02:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLzsP-0001g1-Eo; Tue, 25 Jun 2024 02:42:01 -0400
Received: from mail-psaapc01on20717.outbound.protection.outlook.com
 ([2a01:111:f400:feae::717]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLzsK-00030l-F4; Tue, 25 Jun 2024 02:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMEF8UE7aKl2jUgkWa5PmfQO0eSMuRYTw2TcHwsewiCfuiR7Ud2rTMDqTGX+AvrLTwwztt9enabFHKK3vaq7O4F6HCoU5AUcjCr0gcEz+XKht7TeFixpJeus8/udZLOqpG9NcnvD4OCDcBScX2vd4wZNIuz80r4PBOZLbdPhXKzP0ipOZGHXnhxCxQNxfeET80HqxGexMlC2m7RBfngf8Kfa8Yt27CJg8hFUDe2+XfBZU8L76cUFn/xviWuc6a018qQgxAgNE9L4GuZevzlg5LVti6ejEmD7otzb3FdUfs70x+xYiggy/1brsnxTRvpfzxzFDaiExS1SXPlfkbvT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooyAuIuOCtMUy72qxPGtmvqP59YIJWZdGc4nM6A1e5o=;
 b=Erc9OUnEXuM7lJUEt27jYwZiiknTEqpEq26u+jYhauVKUfMYZm0TvAx2BGGpuoaCldTUaXJjX+AJ4z5iuPqPPZrALgEJLQafVdDaMmOv+DWU6cVB0HkcgFZzMfXg2ztgfYm/R1Uj45gdiBiChldQViLM3bmDc7CiNMc4yv2s7VqaAe4e0DH1DkSc1yr/NuKr0G2qyEi6GPmGGHzFfVAtvEBIjEHS9liDcnUzEt9Ro0PD1ptsiQ5v8ZtJ6+8oHAkelBpxroLEWBZe05t2Km91E1a4QpaC8EOA2dZdrKAIgRSBzjNb/qGm3YEFhHDnv0idYNOrwIZAaVt7RjRM4tmjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooyAuIuOCtMUy72qxPGtmvqP59YIJWZdGc4nM6A1e5o=;
 b=WyJFPT8eZs0RZSU9FxkD6OIXL+Og14Y3N0mgSBceEL/Kkgz0z6guI2azg66aprk8ZekbO4p3XJmBH7R+pawp9NPtBxQuw3v3t8gHVlOD0gLp2U70VSOdBJQHj3g50kzAnaxN/yZy8ZpsYzHn43Wkbo3tTxqlxJ6ZRdACdcSm3rGQEvg++MtOjrZi59I5jRliEjDDaGMoNw5O4IbJP1rRoNAqgwMIY8quJYQAPUkeojZlGLB1+Ab9DOBYn9+jx5+Durzqu1UbKG7dz48uB78+MmJcBhhoDb4n3p8IZ4nEjS/jp5a4onjIy4vlKfkNw0/EwZoiK8BEViz3d4B/W9RIGQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6093.apcprd06.prod.outlook.com (2603:1096:400:33b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.26; Tue, 25 Jun 2024 06:41:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:41:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, cmd
 <clement.mathieudrif.etu@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
Thread-Topic: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
Thread-Index: AQHaxqIVksRkQEAAIEeptYffZVrMR7HX/MgAgAAA3YCAAAD/gIAAAa7AgAAG2oCAAACgIA==
Date: Tue, 25 Jun 2024 06:41:41 +0000
Message-ID: <SI2PR06MB5041AD322F8FB92007925225FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240625015028.1382059-1-jamin_lin@aspeedtech.com>
 <20240625015028.1382059-2-jamin_lin@aspeedtech.com>
 <24dbb79e-cdcc-4415-befa-e6351c8f29b4@gmail.com>
 <69656db3-24a7-447d-b2b2-49a938744be4@kaod.org>
 <d698609b-4760-4932-999b-4d4754021421@gmail.com>
 <SI2PR06MB50415148B5224AB52D485D02FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <7974a26d-4ad4-445f-a3b3-71c08984ad16@kaod.org>
In-Reply-To: <7974a26d-4ad4-445f-a3b3-71c08984ad16@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6093:EE_
x-ms-office365-filtering-correlation-id: 9a836ad5-a99a-4f53-4c71-08dc94e1df95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?SG54SmZiNEl1emE5bXhsd00wYmFOV1pDTWl6VVl0aEVNS1Z1WmNUZDJCS09m?=
 =?utf-8?B?MGg5MUhvS0Z5aUFGRll6Nk40NlJxTWhYMHZBVm9hQ2MwSTFSS2ExMjRDVmhX?=
 =?utf-8?B?SkcxRXJkTUtIS00xdEFoMzhxZG1sZFFxaGNCT2ZGN3h6anpETGNmT2lkOTFE?=
 =?utf-8?B?Mk8rM01naERrK1REZFZDTXhuWE4zTkgxdTR3V0dFTmRhTit6SzNCcTVMVmNu?=
 =?utf-8?B?bnpYWFB5eWZFV2dCZE9RSjAzMXZRa2RZK3ZrSnBRV3BEZmFLRFlScEpSaGp6?=
 =?utf-8?B?dlRvUEtaa3JEa2xkTWpaOHJORWcrYmFpYm03OVZVT3N6VHJ1dzhHV1N0aC9a?=
 =?utf-8?B?dFdybzhsWFNRcGJCaTJqMW9kTExLOFZQRW41SHVFaEk2SVRrT1VzSkZHdHgw?=
 =?utf-8?B?akdBRFJQSWJnaGxFcFNQYWpZSzRYNzVPRVVKWlIyL25FUzlMcTNZUGVnNmFt?=
 =?utf-8?B?SThpcG82RjhxeENzK2F3a25BYnQyS2dIdzBKSkRHUlAvbXRGN1U5cHdCcURm?=
 =?utf-8?B?dFA2UTh4c3hodEJMVnJ5TU5xeFVjak5QeFZJRnhUbkFQcXlIb0d2ZWpvYVJy?=
 =?utf-8?B?dnRuRzlCc0tucGNpbWtWcXdZMlNKZ3RoVE5UaGdESW9EMVhzNlQzdlQ0UmdB?=
 =?utf-8?B?bVRYUDlHdUYrYk9DZyswQjhMN1h3QTNsS0hQZEdORldEaDA1c3VCbTRkdWFs?=
 =?utf-8?B?Z3U5QmpUV2NpUCs3Z1hicDFiR1hKaWV3a1c2Vm85Nlp0ZndiVzIzS2hBUzZ6?=
 =?utf-8?B?b0NITTliVkJqVHdIcTR2YXRxeXdjMjJpckNvU0RzSzJvOVNKWTdkZ25qaitq?=
 =?utf-8?B?TkZpdk50UnVQditjU1hwUWNKbkhkZEtHalA2aWIyNG94SGtGT0RteGdvbXJK?=
 =?utf-8?B?Rm54SGYyU1pQTHZwa05mbXFERXhqenpqUTlZdjZwTyt2RkhFZjlHTC8yWXNq?=
 =?utf-8?B?b20wM2tTeG14ZXB1YkhPbE1STkM4OG1MY1hwSW9ibXNzZGsvdnh3Wnc0d3Q4?=
 =?utf-8?B?Z3VKSHEvK1UyMHRzRjJPQ3ZyMEJVdDNJdDRtOUlRVVY0MDlXcTZEamxpMDY5?=
 =?utf-8?B?MmJXVnV0LzVFWnRTSmRDcysyNml6bFRWVU9PcjlWdklLNTJMa3Q2S1VLYTZ2?=
 =?utf-8?B?NENoWm5SWFlQMmJtZUEydWxhcU5tdlJUUXBGd2ttN3ppY0pkS0ZQS2hJYThu?=
 =?utf-8?B?bzFrK2E1aWdydFpLcmY2VE1md3QwOGdjRTMvTW05b3BlQzh1RHk3SXhkQ2dB?=
 =?utf-8?B?ajRVSDhUVm5vR3cvaUtTMFNuclp3MVE1eUVjazU1Q1JSRE5zZEQ4MzQyejh0?=
 =?utf-8?B?emVPQ0o0Smd4Rnd3TXN1VkpCVkVNSUorUythZGhEbEJzR1hoWEVRZ05TaElp?=
 =?utf-8?B?M3hhWkV5RkV5ejUxV0d3OEhyWUJLK0FxcHN3bC9IL3ZBVWJ3UnZmbjRkcElJ?=
 =?utf-8?B?WG1kK1U4TU9ta2hhcTlnU2oycEpFcmZsY3M3djFEYWNkaXhlQldkZDB3TUdD?=
 =?utf-8?B?Tm44bGZVRnFmMHhGVWwvK1JVbEVZWng2RjdyeUlaeWpvSnQ3c2lnZ3FPWjBp?=
 =?utf-8?B?OGdCZlVrNW1JaGJzQ2lSMlhvK0c2b1o0eC8wTmF0VEFPYTdhVHNoVnFrRFRB?=
 =?utf-8?B?Tmo5QmErU09FU0dFMDAvb0dFK1cwa01Qa2NwenlLZXpVUTNOOGZYeFc5RmV2?=
 =?utf-8?B?MXlMakJJYmFjWnJNemxKMmVyc3NuTzAwVDJaR2U2bU1hWFdCeDNaTnFYNmpM?=
 =?utf-8?B?dWZhVGZRdVdTQzBCNWh0aFdsN0lEemZHMWViUjFrVVZVdUUweGZ5dHJqZFhq?=
 =?utf-8?Q?DGuo8zK3WNN+Fxz6iBfcUPYRQUsKlCN3or/1Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(376011)(366013)(1800799021)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R29nUUFwUXhiUjIwTEd1UzNTZUp5T1NQMHRBdlhpZnpKTFhZNXV6Q1ZuaTZi?=
 =?utf-8?B?T1d3NktKUmpJMDc3Rlh4MEY3R2lSODhzV05vbDZieW56SjBCNk9RNXY2Smdq?=
 =?utf-8?B?UjV2VDQrWEpra2J0UDNHNHhnTkh1Y094N1E5bGFiSzc1UU01bWRUTDZ2VXZ3?=
 =?utf-8?B?Uk90aTdJSmlPaFNRY1pTMFZoKzh5MVEwTkJYTDJXTEhxS0MyaGhERGpka2c2?=
 =?utf-8?B?TEZhc2hBRytxQlUrK0NtdDI0cklUZlZ6V1BvbzlwcE9KR0VZa2tVYWNjNDAv?=
 =?utf-8?B?UlV2cDJ3T2ZwbEJKaVEvQkpmWnRUNm05MEZOVytIREFwbUFPdlJMcjUwb0VG?=
 =?utf-8?B?RXVIRHpLelprUWtKNEd3STlQcnJ3TzNQdWp5SnlFakpsRlJJTTJybjJvR00y?=
 =?utf-8?B?VENRMUJsYS9yTlhTMnU4MDRRSkF2VGZtOW50M3AzbGxFWFU1N2VLUDdMUU5S?=
 =?utf-8?B?UzJsajdBR2NJMGtyNkFsdVVRMDNtU2NTN0luRVBXYTNKakVjUjRUMHJZVGpl?=
 =?utf-8?B?MFVjOVNraDFRRWw1WUxHUFMydjdVa2VKZFJoRmhTU0VacVFRRFhCSGNjNVBt?=
 =?utf-8?B?N2dsaEhjc1AwYUVYdVZobEN1SGJoK0V1elJ1UlQ1azI2cXNUa2V4TUV3Szg0?=
 =?utf-8?B?TkhuaXg4WEpTTTViamFrSFIvOXVlL3JFOW5nMEpnWU9CVG1heEx2QjFvbXR3?=
 =?utf-8?B?STJ6UWZtYWQ4eUZ5V3RaOE1maWk1UGNub3BzQWY2VkdxTUsyS2hWL3JieTk5?=
 =?utf-8?B?ZVFvT1B4SCtYWXZtMmxmd3I3bFNmaERMNEx0OG9pU2U5NVBUTDNiNDZwK1VP?=
 =?utf-8?B?NkFPVXRtVXI2ZGxjaVQ2MSt1WnBYcndqWnlGem9DU3kweUcrQThsNzVBbFo4?=
 =?utf-8?B?ckpyeHdxWFVENDQyd1Z5M2RxTHpTd0ZHbzlsc3RSdzBNOE5CaWRHUFZoNzNM?=
 =?utf-8?B?UUNscTJrMU5ma2laNmRxUUo2VDdXT3dGZU14K0NaNUIvZU4xRzdYMEZMUmFn?=
 =?utf-8?B?UlJLUTlLajN6UEZ6U052NWxVUGFyOFNveEVPYTB1MERzK01tRndvcm5lTHh4?=
 =?utf-8?B?WFgvVDJOK3dld3lDQzV0VlFmaHlYeGJxMWN3dHMxUFJ4WUNXTjR1enE4bTdn?=
 =?utf-8?B?TXByc1lMRktLZUlCaCtyUFJDTUl5LzJ0V2RPQjdiM3k2TUxsdThmd2l5NEFS?=
 =?utf-8?B?VmQ3YWUvMmdlTHZEcDZ4N0xlNGpiaDFSUGtiZGZxL2k3YVdkSkhMZThUa0R4?=
 =?utf-8?B?SnBMbmR2c1pwYm42MjlzZm9zTzU4WHVlVGRGSVpZYkdBTGJEVFcrRGFtMUds?=
 =?utf-8?B?eFJ0TTUzcEcxaTd2WStscyt6OTIyVWJWTytQNHVKZFBjQzBHWENlRUZoUmcw?=
 =?utf-8?B?RjFFaUZHMHpmTWF4SFhhTDFKUFQ1ZXdkamFxenBZc1BsYUg2VXdBZXl6cWFn?=
 =?utf-8?B?YmF6UlRqUm41N3FZcU53Y05PamNWUHZLaVU5K1hpRFFpenBUODlyZ216Wnhs?=
 =?utf-8?B?ZWl5K0lFOVNVZEZ4WFFmNE40T25WeVNKaXhpbE9sNGR6cGpkdVJlc2lnMldi?=
 =?utf-8?B?TUJvaXFUZWJBVGxmbW1pcnZDelBUQ29WNGY3bVhlU0k0ZDZSWmN5amVkQ1ph?=
 =?utf-8?B?YUNwZHlZR3dINUhKdUpFRHJDa2JSd0hUTUxCNk9oWWhJeVozOFZLQUl5dDZn?=
 =?utf-8?B?b0h6eklkTGVJallid3hrL2FLQllmNHQrMG9BTEdtMFh3MnZlaEp3K0I2aVVF?=
 =?utf-8?B?ZWtuT3VTQU45aXRZN0Z1NmUzSzlLT0htbHlVVmpnRG1nSjBNNnJseDYyUVk0?=
 =?utf-8?B?blhlMUdZK21HYVBoa1FFTk1ZNGxqek1BSGRyVEdiVlo2dVlDblNrR1RhYzQ0?=
 =?utf-8?B?Rno5WXFaV0lrUXE1NGV5MmpaTTIzcHQySkpDZVgyK3gxb1Q5ZzgwNmlDSmty?=
 =?utf-8?B?UG1WN040RmlFbEVjWlRpKzJwbHhJUnhIeSsrTnp4K0w5endkRkIzZmxmYks1?=
 =?utf-8?B?U2kxUG4vV21hRVd2NEpUUlNhb3YvL1F0NFYzWjZybE5ybFZXOGpSc1Fxcnpa?=
 =?utf-8?B?eG4ybTJWT3o1c3FiVWFjeDE2ZEl2dloyMFF1WFpLZTJ6UEtPNmJiUktGMlJY?=
 =?utf-8?Q?RopRKSoyKr+rCP6CgEFVZyrE9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a836ad5-a99a-4f53-4c71-08dc94e1df95
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 06:41:41.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzoIQwgAa7AWMXdz10eQ/Xx4a04GwW6byn58PW7fGZv7aFrenvvWDCsiScpEKZu1R7MlW/qxw2OkUZPr7M1VMbBO9LiHIaSE9AqD6rDi1ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6093
Received-SPF: pass client-ip=2a01:111:f400:feae::717;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjUsIDIw
MjQgMjozOCBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBj
bWQNCj4gPGNsZW1lbnQubWF0aGlldWRyaWYuZXR1QGdtYWlsLmNvbT47IFBldGVyIE1heWRlbGwN
Cj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNw
ZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBBbmRyZXcgSmVm
ZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsNCj4gSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT47IG9wZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1Abm9uZ251Lm9y
Zz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5v
cmc+DQo+IENjOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMS8yXSBhc3BlZWQvc29jOiBGaXggcG9zc2libGUgZGl2aWRlIGJ5IHpl
cm8NCj4gDQo+IE9uIDYvMjUvMjQgODoxNSBBTSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIGNt
ZCwgQ2VkcmljIGFuZCBQZXRlciwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+PiBGcm9tOiBjbWQgPGNsZW1lbnQubWF0aGlldWRyaWYuZXR1QGdtYWlsLmNvbT4NCj4g
Pj4gU2VudDogVHVlc2RheSwgSnVuZSAyNSwgMjAyNCAyOjA3IFBNDQo+ID4+IFRvOiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgSmFtaW4gTGluDQo+ID4+IDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+Ow0K
PiA+PiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUNCj4g
PGxlZXRyb3lAZ21haWwuY29tPjsNCj4gPj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29u
c3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleQ0KPiA+PiA8am9lbEBqbXMuaWQuYXU+OyBvcGVu
IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+ID4+IGxpc3Q6
QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+PiBDYzogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gYXNwZWVkL3NvYzogRml4IHBvc3NpYmxlIGRpdmlkZSBieSB6ZXJvDQo+ID4+DQo+
ID4+DQo+ID4+IE9uIDI1LzA2LzIwMjQgMDg6MDMsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0K
PiA+Pj4gT24gNi8yNS8yNCA4OjAwIEFNLCBjbWQgd3JvdGU6DQo+ID4+Pj4gSGkNCj4gPj4+Pg0K
PiA+Pj4+IE9uIDI1LzA2LzIwMjQgMDM6NTAsIEphbWluIExpbiB2aWEgd3JvdGU6DQo+ID4+Pj4+
IENvdmVyaXR5IHJlcG9ydHMgYSBwb3NzaWJsZSBESVZJREVfQllfWkVSTyBpc3N1ZSByZWdhcmRp
bmcgdGhlDQo+ID4+Pj4+ICJyYW1fc2l6ZSIgb2JqZWN0IHByb3BlcnR5LiBUaGlzIGNhbiBub3Qg
aGFwcGVuIGJlY2F1c2UgUkFNIGhhcw0KPiA+Pj4+PiBwcmVkZWZpbmVkIHZhbGlkIHNpemVzIHBl
ciBTb0MuIE5ldmVydGhlbGVzcywgYWRkIGEgdGVzdCB0byBjbG9zZQ0KPiA+Pj4+PiB0aGUgaXNz
dWUuDQo+ID4+Pj4+DQo+ID4+Pj4+IEZpeGVzOiBDb3Zlcml0eSBDSUQgMTU0NzExMw0KPiA+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
Pj4+Pj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4gWyBj
bGc6IFJld3JvdGUNCj4gPj4+Pj4gY29tbWl0IGxvZyBdDQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+
ICDCoCBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyB8IDYgKysrKysrDQo+ID4+Pj4+ICDCoCAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQg
YS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+
Pj4+IGluZGV4IGI2ODc2YjQ4NjIuLmQxNGE0NmRmNmYgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+Pj4+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4
MC5jDQo+ID4+Pj4+IEBAIC0yMTEsNiArMjExLDEyIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9yYW1f
Y2FwYWNpdHlfd3JpdGUodm9pZA0KPiA+Pj4+PiAqb3BhcXVlLCBod2FkZHIgYWRkciwgdWludDY0
X3QgZGF0YSwNCj4gPj4+Pj4gIMKgwqDCoMKgwqAgcmFtX3NpemUgPSBvYmplY3RfcHJvcGVydHlf
Z2V0X3VpbnQoT0JKRUNUKCZzLT5zZG1jKSwNCj4gPj4+Pj4gInJhbS1zaXplIiwNCj4gPj4+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm8NCj4gcl9hDQo+ID4+IGJvcnQpOw0KPiA+
Pj4+PiArwqDCoMKgIGlmICghcmFtX3NpemUpIHsNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHFl
bXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIlczogcmFtX3NpemUgaXMgemVybyIswqAgX19mdW5j
X18pOw0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+Pj4+PiArwqDCoMKgIH0N
Cj4gPj4+Pj4gKw0KPiA+Pj4+IElmIHdlIGFyZSBzdXJlIHRoYXQgdGhlIGVycm9yIGNhbm5vdCBo
YXBwZW4sIHNob3VsZG4ndCB3ZSBhc3NlcnQNCj4gPj4+PiBpbnN0ZWFkPw0KPiA+Pj4NCj4gPj4+
IFllcy4gVGhhdCBpcyB3aGF0IFBldGVyIHN1Z2dlc3RlZC4gVGhpcyBuZWVkcyB0byBiZSBjaGFu
Z2VkLg0KPiA+Pj4NCj4gPiBUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCj4gPiBI
b3cgYWJvdXQgdGhpcyBjaGFuZ2U/DQo+ID4NCj4gPiBhc3NlcnQocmFtX3NpemUgPiAwKTsNCj4g
DQo+IHllcy4NCj4gDQo+IEkgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggZml4aW5nIGEgbG9uZyBz
dGFuZGluZyBpc3N1ZSBpbiB0aGUgU0RNQyBtb2RlbCBub3QNCj4gY2hlY2tpbmcgdGhlIHJhbV9z
aXplIHZhbHVlIGluIHRoZSByZWFsaXplIGhhbmRsZXIuIEl0IHJlbGllcyBvbiB0aGUgInJhbS1z
aXplIg0KPiBwcm9wZXJ0eSBiZWluZyBzZXQuDQo+IA0KPiBUaGFua3MsDQo+IA0KV2lsbCBzZW5k
IHYzIHBhdGNoIGFuZCB0aGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBoZWxwLg0KSmFtaW4NCg0K
PiBDLg0KPiANCj4gDQo+ID4gSWYgeW91IGFncmVlLCBJIHdpbGwgc2VuZCB2MyBwYXRjaC4NCj4g
PiBUaGFua3MtSmFtaW4NCj4gPg0KPiA+Pj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+DQo+ID4+PiBD
Lg0KPiA+Pj4NCj4gPj4gT2sgZmluZSwgSSBkaWRuJ3Qgc2VlIHRoZSBtZXNzYWdlLCBzb3JyeSEN
Cj4gPj4NCj4gPj4gVGhhbmtzDQo+ID4+DQo+ID4+ICAgPmNtZA0KPiA+Pg0KPiA+Pj4NCj4gPj4+
DQo+ID4+Pj4+ICDCoMKgwqDCoMKgIC8qDQo+ID4+Pj4+ICDCoMKgwqDCoMKgwqAgKiBFbXVsYXRl
IGRkciBjYXBhY2l0eSBoYXJkd2FyZSBiZWhhdmlvci4NCj4gPj4+Pj4gIMKgwqDCoMKgwqDCoCAq
IElmIHdyaXRlcyB0aGUgZGF0YSB0byB0aGUgYWRkcmVzcyB3aGljaCBpcyBiZXlvbmQgdGhlDQo+
ID4+Pj4+IHJhbSBzaXplLA0KPiA+Pj4NCg0K

