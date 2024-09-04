Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437F8CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slkYM-0006FI-Hr; Wed, 04 Sep 2024 03:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slkYK-0006Df-5x; Wed, 04 Sep 2024 03:35:44 -0400
Received: from mail-tyzapc01on20719.outbound.protection.outlook.com
 ([2a01:111:f403:2011::719]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slkYE-0001uq-QP; Wed, 04 Sep 2024 03:35:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkYMAjWS7mZldpEyXVP8j8uAER0ytcw8kDCohKt/duwrZk6tvW+py8+QndAQbCKqLql8x0h7EEduQqPS10g0+WZrSTsUX+lpVbraFCwfjuo1UjnURx9JXzcE9ZFDvaXSwCWxt6Ue6Ai4BIcLaAXO1HyGamSawdjs+/c9E2DEl+4fnzUR8dNh25kPbkCCKTQ/LoThDdlFCrnd7CuqbbQ//jXzNbiaWQgfmv7N5ENAIgHPn1nWUWrvhYx6DeqXxAca+guaQnVUE3aUADASoKiNOv2S+EhvqkI+cCvQPDc23HowhfT8foPwK11qyxR5diwQOSg6gv9ISi82jBy13d+oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l0boDy7ZVKS+EsaniTP0lHK+B1Cc3jbrfRefXd4WBg=;
 b=wXlPlhfUOwj+PhBYQqS8bECz/uVtWKizyfS60HRL5nuTYJatjYvPAPPbFCG/3qgcQGt6AQCU/0G9Jcrl7vAoWyWxIyAYzfp4cxtETmbHU5Oct83SJKzz8EIKTlgFej5RbqQ7qHPyoAKWNmix1cJOZzfHolM42qhw5JmxgnJoFr/xfx5JznYLg0RUI3ihzmsZNTvlLhaMeLdQfAPv7W6b5DkTuxyVg43oHhlJ+dLSY7RRKqKNwgAAfzBRHe5SErSewJN/NKwgcdYK1dXMEG1iIBb/Lk7aKVTUMNaSeqM/wnIH/TBgSl19d4zyjDf+EEq8UUkGKnymBTiHFNugJPt3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l0boDy7ZVKS+EsaniTP0lHK+B1Cc3jbrfRefXd4WBg=;
 b=mf/wlsKZY5pE+SV5bg86XPP7wGDUYsIhIvrTCyJCriDOgs43xbRr34AuxLQeTCuRBsR0J8j2jY1euGk2hejpQ3ouxQHwR3l20Zc3bS3fiH/iKp05MX92BtZepBKhIAzftZlnCDEZAkPCiCE91eCFxpK+Uykx6TTr7g33idP0nfJ2aQXm9Xr5aiOnYpAg7UuNS+PRP+VTv0Jc7FGno7xlJMeKkAMRD2ThRdbaeH8BK9m574H7231zTrDCzKPX2F0uLeXoMsxpQ0JPcwsZXKJJs4u/TTQZrc8DTe6moUhvT2t75l+3cVnesIBi8QF1mHikb8w3lzre/5qpyn6mHqKeug==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6091.apcprd06.prod.outlook.com (2603:1096:820:d5::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 07:35:26 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 07:35:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v3 00/11] support I2C for AST2700
Thread-Topic: [SPAM] [PATCH v3 00/11] support I2C for AST2700
Thread-Index: AQHa/dxA7Q2YMqG9Y0mc3Ke+FSE3BLJGGq4AgACzhRCAAG5FAIAAAOUQ
Date: Wed, 4 Sep 2024 07:35:26 +0000
Message-ID: <SI2PR06MB50412AF41EFDEBB0938E7F97FC9C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
 <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
 <SI2PR06MB50418DD956AC152E4E0911CDFC9C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c418168b-eb5c-459c-85b1-c7766102e558@kaod.org>
In-Reply-To: <c418168b-eb5c-459c-85b1-c7766102e558@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6091:EE_
x-ms-office365-filtering-correlation-id: 8e403229-7320-4542-5e39-08dcccb424e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?dHZXYUZobUxHTzVpVzNCbFVOWk9xYmhpeFBCRHVDQjBHalNLUnBzeW9MaDZt?=
 =?utf-8?B?ek5vWi9DNFJRWEdZMkxJR1V5WXhHVlo0c1E5TDRGMDFKSnBDVVhrdHBmNzIy?=
 =?utf-8?B?MG9zVGtSczVIbzRXUWFZVzYzN2xzMnMrTHBHRURpdnNjQjdKQWpzWHdqeXpr?=
 =?utf-8?B?cHZ5eC9Db0RicVhQcWxiZXBUMlpZS3JISG13WFJDMGFKMTNKSlp3Q1NTTTI3?=
 =?utf-8?B?Qm1NUXM0N3JFNVhnZWNMeDZQUHFEaGExQzVpbnptR09yMVc1azM0aVY4dm8z?=
 =?utf-8?B?djdQUm40L3FoQUJuWXl0YXVKQjJDNHZiSXd6SHRVb1JMSUtWaWplbjA5N0ty?=
 =?utf-8?B?Qkx0dHlldWRqRVpmQi8vVHdnR2hnWmRBSzcvQ3VXQm5VdUtwb0pJbktTRlBX?=
 =?utf-8?B?WHFHQ1o2Y3dVQVc1QVlRZ3ZVakhJRGxyWUI1WTA0ZVZtQ3NRRmlVNGcyRmQz?=
 =?utf-8?B?ckxkYmlrWG53MDBYSlNYY3lKdExobDdqdlI1QlFwNkhRYjQvTmxhUVR6em9E?=
 =?utf-8?B?SnJ0a3U5a0kwU0ZFZkZZNzVXVlZ2bmRTUFhGZjh6VEdZZWQweDF3Rlp6Zk0y?=
 =?utf-8?B?L0tiWHNaL2NXd0IwSzBMT1NOV3p5RC9Id3hIYTNMc1RJVFpTcXN3MEVzcjJB?=
 =?utf-8?B?VTUzZTN4ejB5MGhDSWRSZHRjVWw5L3Q2Q0Ywc2I4K21Td3E5YjV6UWxJOWhj?=
 =?utf-8?B?N3RLQ25ybkJLMG1RbG01SGJ2T1lmbTZsS1JFK0NGWVA2c0dHTEUzUVMvZGY1?=
 =?utf-8?B?ZkM5M0E4WFJadldoTmJoRklsV3U1L1loUHVTVjR6MGVPK2swTDdmdHh1VW9u?=
 =?utf-8?B?bTJsSzUxQnltRnIvcUpvVDBoazJmbDVXY01pVFJMRWJ6M0RsUldkdDJQQVNC?=
 =?utf-8?B?a2NtSy9XVUJGaCttd2J3SWFQcnUxWU5nMXlyT0hBbHdtWXZKTUNKaTBTbjQv?=
 =?utf-8?B?ektabnIrS0VzbTI4MG9ITE1zcWdvc3FuMkNlbHpCclFsK3libFFyRTdiRUpo?=
 =?utf-8?B?RHhyN3N3UnlVbVgvS3h2clpJdFllMTFkeXMyQXdjYk02MUxvSkpnZERuaTVt?=
 =?utf-8?B?Y1hzeGJGSWdGKzlvVHVaSjJMNmlUVVZXeUdzVGFvcjREYWpsbzNlM3FRbUpX?=
 =?utf-8?B?Uytxa0RVT0JoSklJZE1BRjBsR1NTUktGcGRxM1dFdnlaRUdBN3hpT3FvUVRy?=
 =?utf-8?B?MHFDZ082Vk02UHhYTjMvMVp3U2lXZXRwR1FxY25STkhqRXRpb3pEODdWdGh0?=
 =?utf-8?B?emFFSWxWbVh0cU56dEo2amwwNHRoZFN2dXBTTjZKSi9PN0ZwZXoxMDhvTWEz?=
 =?utf-8?B?RXhNSVppeUNOYTB5OXdCQUdIMHBURWZUbUN3ajNJeEMrdXZzZEx1MW1OcjJj?=
 =?utf-8?B?dGJyNWhCSGVVc3ZXZ2Nib0FvS0IvN1l0d3EyWXF3TDRwYldyYTZOMlZWMCt6?=
 =?utf-8?B?TzFYVFRaTmdrcFhkbncyWUozRnE4N0JZbks1dE83WEpBR3dOSk1UTTRIYmRX?=
 =?utf-8?B?UERqRUl1NjY0TVg0ZXZrZVpoT2VUUy9UU0s0YnU0bEw1eGROcEhUaGZZeGFZ?=
 =?utf-8?B?TWdDU0REZ1I5a2x4QUc3QjVXOGhWb01iS1prWFFpTHNlL1ZtdWxDV2pOL04w?=
 =?utf-8?B?bkQ0TzRUQnlTME1XOUsyWmppaTJ0Qlk0aWxzbmFObjduTHV3NzdwUFhrYnlv?=
 =?utf-8?B?bENtQnVwNlJDZDFXdEQ2TytGUGwvMjZ6MlJqb0I0bEprSG9na3MvcjVSVVZJ?=
 =?utf-8?B?YUtDcFhJYXFoakxDQzJzekx0L3FVMUJsUndUQlhVNGZMMjBMWHhObUJ3VnJM?=
 =?utf-8?B?a3M0Y2FkNjYvWkIreDlTcHcyM2w5dlFhMDBPNUZYOThOeXgwNC81bCtDQUtP?=
 =?utf-8?B?NWp6cTdQZ1ptWkRZNkFlZE96czM5bmRlZE9CQ0F2eVpDTGo2Z25NcnU3QTc5?=
 =?utf-8?Q?RZir0XOgQ59Y/6OAtCWJjNxCD1FIN37d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkI5RjZHd1lRejFkMWRkb2Fhc1RjcVVqRzJNRE1NUldGbTRJVUhJdzBJWnpt?=
 =?utf-8?B?TlRyRnZnVW9JZFd5eEJWSm9tY1AvZEdIZ0grc0RHdE0wdGgwUk0xeENPQUJl?=
 =?utf-8?B?ZUtPTkZhdnVaV0tPQ1B0NjZ1aUpNV3NoZGE3WFNtZEtKNXJPcnIwMWVtMkJT?=
 =?utf-8?B?dXZlQVIxeSsrYlEvVmdodlpzbSs0U1V1ay9RZ3VhNFJWUzlHMnQyenIzd3BR?=
 =?utf-8?B?V080M3hsa2lxK3h6ZjlVWlExUnU1Z1UxTnkzZXNxaVhkbUxvQlpTR21qVTlV?=
 =?utf-8?B?NXBrZE1DdGdocmxxaHVnZ0ZWb2dKVTFJb0U1YU5NVW4ydG5pM0dKRS9Ib29E?=
 =?utf-8?B?eHRFQmJKZDl5cW16R2VGU0xPYlQ2M081N0RaZDdGK1cvMytYek1MVG5ielRQ?=
 =?utf-8?B?WktYRnJlaGg5NHMwQWpEcGxnaDQ0Y2NQVDkraGFSREhFVC92YXpUZFRqZWJu?=
 =?utf-8?B?V3dlYm9WNm9YSEFPMHdDbDkxdzhLWm1LY1JNa1VuUHdteHZVRTlrQlVSeDVF?=
 =?utf-8?B?Q1RkSkxFeDEwSmZrcWpRMHdJNEJ6WW01cjVmazcvdWs4WnVCSVBJK1FIRGs1?=
 =?utf-8?B?aDJEVkhGYkNpWkNodUxUWDhoRTJ6dXF1Vy85Y1BqMkFNYll0NlpYOHhTT0Np?=
 =?utf-8?B?cldwbXhWdTFzMWxQV25TS0NaMGlpYXBubUdMMWhGR3BNVUJBTU5XOGZXbHVl?=
 =?utf-8?B?TjJPUEZtRlRHOVdZeU0xWktITWZ2aFJ3SHgreGxZUjFBTEpSTnVXVnZsZkti?=
 =?utf-8?B?QVhPSC94T1MvZnpvY2QrSW14SS9QQTlUMTJPUnpPdGJVV2V1ZE5zYU0vTXRU?=
 =?utf-8?B?cjB5d1FoM3JibFZDWmhDR1dFcm1la0Q1d0RWcHd3QkNJVmVlbTJwUGpKMTQ5?=
 =?utf-8?B?NCthUEs5Z3ZER1kzS2p4NS9NalJwV1hGNkl2YmlkVVJCU2dpMkFFMWJyWnVN?=
 =?utf-8?B?RmZ1MmlKOUVRK3VkVitLU3VBbU51KzNGeDhCNVNhenRTTU1EOGhlcWJJbzVh?=
 =?utf-8?B?MGp2QURqaHJnMjlKZmp2a25UNmZqVmdjZ2tBMmZhcmVPbHY3R29JUU9zYWJ4?=
 =?utf-8?B?TmhRVHpzYnEyQ0VQMWxPck5LYVNwcVRWT1VDbjByZEovZzI2T2lZWVFJdEhu?=
 =?utf-8?B?SEtYYWRwYW1ITk44TVl2NzVmVy9WMlFZNEtBaHJlN2xaMGRQUlVPOWNwM0dj?=
 =?utf-8?B?M3k2MVZwRDVadVJxalpqN2tUTllLOG1CcTNkSGZxR0NuQkVHQXlmNGVMRnp6?=
 =?utf-8?B?SW8vUVJScUVJWG1vV3dUVlI5ei9tOUhzRFdmVnl6QS9KaGc4UGJNY1NYY0tl?=
 =?utf-8?B?N1BDU0JERzFCaWFUKzZuYytOMTJvemZ6U0VnaXA0QURLQXBUbFg4RkJqOVJz?=
 =?utf-8?B?UGY3aHZDWDVFeXRkeEtSdnVNdDVRdDAzMG05UTBMZFJJYkhzZHhCTWFjaTR1?=
 =?utf-8?B?dnR5UTY2R0xVODd2ZFlLM2ZmSWVRQ1ZCU3pMRzU5dW0weVZiMUU3aGNNTmNW?=
 =?utf-8?B?RG1XYS9TYTR6TUc2ckdUaUZYdFNFZE5WREhlbUZ0dkVZNE5zQldzbk9ERG50?=
 =?utf-8?B?MWFPNFJ0eldsSHpucVRxdWVHOHBKL2tjZ1d6Mml2OE50RHFZcDBFNWRSQWlG?=
 =?utf-8?B?dGdQM0hvR1RYOEw5SDJjNEk4bmxMLzBxRU0yb1Rsc0JYdDlsdlJTVlFOWWM1?=
 =?utf-8?B?R01DZXd2a0NEdUd3Vjd4SEN6enJQMGxPWXlGMWZiNlovWmhFaUZ3N0llQVhG?=
 =?utf-8?B?TnAxT2VtYmhON0tXY01OcGJxUkxRMjdSTm91clZEM0h5ZFBpVmlSS0J6REhh?=
 =?utf-8?B?UmNmdWgxeFZ4TXhTcXlabUdSN09jbzRMNERJcHdzQ1pCSmJjYitpdmdZWU12?=
 =?utf-8?B?UklBeTBsa2tqak1tdU8yN1hvSi9YNzBEcDE5VDhvbTRLKy9CRHVmQk9rZzBq?=
 =?utf-8?B?cHZxb3oyUlExM2dROWppdU5mdHk2TDh2ZlVtUUg5aTh4Nll6aG41alkrL0JJ?=
 =?utf-8?B?MUxhRzhpeUYrNENwVWpzUVN0VVJVV0VTOVhWN05NYmZ3VXlyUlFRdnloMGh2?=
 =?utf-8?B?K01ob09LVWRPVkZ4N2o4UXpiKzQySFlLbG5ReENWU3VNZUhjYlVkKzloWTZC?=
 =?utf-8?Q?xH5dQpdwNdKUKkuPyhiGrN42Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e403229-7320-4542-5e39-08dcccb424e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 07:35:26.4289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FRYgZT+3rNhamBeDF1BV5EdXCCjO8dgxSRoXoCfYyKx0TekcUG1kmHUUDrFuHchb2m6dni7yrqGN17CQYgaW210QcW6k9EOeqiKF3msHak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6091
Received-SPF: pass client-ip=2a01:111:f403:2011::719;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MyAwMC8xMV0gc3Vw
cG9ydCBJMkMgZm9yIEFTVDI3MDANCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gPiBKdXN0IHdh
bnQgeW91IHRvIGtub3cgdGhhdCBJIGFuZCBUcm95IGFyZSB3b3JraW5nIG9uIHRoZSBmb2xsb3dp
bmcgdGFza3MgZm9yDQo+IEFTVDI3MDAuDQo+ID4gMS4gU3VwcG9ydCBib290IGZyb20gYm9vdG1j
dShyaXNjdjMyKSBpbnN0ZWFkIG9mIHUtYm9vdChDb3J0ZXgtQTM1KQ0KPiANCj4gT2ggbmljZS4g
VGhpcyBpcyBhIGdvb2QgdG9waWMgZm9yIGhldGVyb2dlbmVvdXMgbWFjaGluZXMgIQ0KPiANCj4g
PiAyLiBTdXBwb3J0IEdQSU8uDQo+ID4NCj4gPiBBZnRlciB3ZSBmaW5pc2ggYWJvdmUgdGFza3Ms
IHdlIHdpbGwgdXBzdHJlYW0gUUVNVSBhbmQgc2VuZCBvdXIgcGF0Y2hlcy4NCj4gDQo+IA0KPiBU
aGVyZSBpcyBhbHNvIHRoaXMgaXNzdWUgd2UgZGlzY3Vzc2VkIHByaXZhdGVseSBvbiBTUEkgd3Jp
dGUgdHJhbnNhY3Rpb25zIGZhaWxpbmcNCj4gb24gdGhlIEFTVDI3MDAwLiBJdCBsb29rZWQgcmVs
YXRlZCB0bw0KPiBhc3BlZWRfc21jX2RvX3Nub29wKCkgYnV0IHdlIGRvbid0IGhhdmUgYSBnb29k
IGZpeCB5ZXQuDQo+IA0KPiBXaGVuIHRpbWUgcGVybWl0cywgY291bGQgeW91IHBsZWFzZSBvcGVu
IGEgZ2l0bGFiIGlzc3VlIHdpdGggeW91ciBmaW5kaW5ncw0KPiBhbmQgbG9ncywgc28gdGhhdCB3
ZSBkb24ndCBmb3JnZXQuDQo+IA0KVGhhbmtzIGZvciByZW1pbmRpbmcuDQoNCk9rYXkuIEkgd2ls
bCBvcGVuIGFuIGlzc3VlIGhlcmUsIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVt
dS8tL2lzc3Vlcw0KVGhhbmtzLUphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

