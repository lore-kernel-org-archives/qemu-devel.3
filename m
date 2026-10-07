Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2402CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwt-0005uJ-1d; Wed, 07 Oct 2026 05:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xENF0-0008SJ-1E; Wed, 07 Oct 2026 04:43:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xENEy-0007E2-3F; Wed, 07 Oct 2026 04:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaJ4pS0oLC5yUzUWyAiQjjDCJ8f1dy8Xy2Xj3Wu+PFWxsN7PNda+dz6Bwb/qcRDdqiwXI+MPSMSI4uHfiH22WlSWGgScRraPp/Uwkg7Wuj4/32ROUuwx7cYQsCJoHzyauo73O/wQQ7VnjesHrTJDuotsOEI0gKDHnAp7uEgqIApyhv9/ZmJ5hBKUTnIIDMALg15gkkIf4VU97xMnliUjDwa00eAmWz9KFiJ3FVg2kFadiQFTvzBPUj7nbC9GIu/Bk/Z/DMX35b+W5NtNdk2dFWg4RRLNswLyujb76LwubJDyGpnY68tpFp/4ehm+pjrrNp4MIweLuzz3hVv+Yl1qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2iAF6Qtci7aMFA1FL8kv9Ui0FSM734j5HRSG9uuLz8=;
 b=cCZf4zNzFBMu1yDMu2AOKDQcwvZm9doUYe9YTTlAXfBze2g+loypseWfP+S9nrkKkoY4Od6NjtHfk3iKBc5TnZPDJ23R74MxJCMfiJp1z0PY+Q4OPCbhUWKYbM05ItuJJEHwossZcWt+Psl22ZSNfVSWgqB4H5/Nj46RbofvmnQXDJrw99z4rGEICZz0wfcHUpJoQkcmIynO1BJlag48G4XuskfcK+Atgwll352jxSjLOwhm946LFTAX1Wnhy9twk+zRdWAneVtOfMi+ELNJW/ZqcCmfnfsUcc/wKdOqWOaaLOwicAQXJRkIFkGF9d35s2csXZGPz0DOoljyxGRleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2iAF6Qtci7aMFA1FL8kv9Ui0FSM734j5HRSG9uuLz8=;
 b=HyF0O7ESBnw9HfPmI3fU00cYPOq7Xl6uJlG0F2hPkYNTndwDeodFH1Ywn14n429f3XO2/z3TT/dgq3HTqJEWa8iac/elw9U6a+fJzwPvNmhGen9aWzQWvjm6R3blkDiecAXLcWjuDmn4nrLkRD1aPqtO1hPY1p1txdufAm1If2n33tthxs9GVOXecQPZLjkyF/U9g3+8pfy59YNuUxeznNrM2HD3Tw0JCZ5w7xocsW2iWb01iJBY8U1UnhDOfRMQlmoh+ks0v5R9PzXK2xyRcQTSQ47IpY7KacpDANyostAVlew/tYS5qnBVkGDD0CdYNGzixU19DaH92ie04ozRtA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8578.apcprd06.prod.outlook.com (2603:1096:d10:8d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 08:43:02 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:43:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Topic: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdVHh3uLXv2VFpZkCIJ+Dg/sNXx7bupqoAgAKx2RCAAEPSAIAAKj7A
Date: Wed, 7 Oct 2026 08:43:02 +0000
Message-ID: <SEZPR06MB7362FDC5282ED7F6FC80C980FC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
 <179119075845.699310.5944945395562648270.b4-review@b4>
 <SEZPR06MB736267CA04EA7BB0EE82D87DFC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <CAMxuvazTUQ7Z2c2+6mUpKr1EJgaVTdxYqyeyZgb7LMRbAXfrEg@mail.gmail.com>
In-Reply-To: <CAMxuvazTUQ7Z2c2+6mUpKr1EJgaVTdxYqyeyZgb7LMRbAXfrEg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8578:EE_
x-ms-office365-filtering-correlation-id: 895a15c0-772a-4b24-c8cf-08df244eff98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 5/y3U339EH5Q3coN9bNNa+yTAP8DH/zj+dViDDCVz5CZ1LQ0eYx9tvmlYALTM4p+5D3Pov9QyXG5QFJlqhlh9zGCdp9qoxr1+9H5SYOzrfueasJdXeDCkke8PwA68P7ncAu9bcpZ5SPaUfKBp05rv9V++Eeya/ekMD7ypfvpLT2E9yZkgAjEVF9Ex/qMWrqNeB9SOiJaD05zunG8qra0XaNXVVX2tlKzOBXYY6e1fs7oxL0TlWlO4e9LSNEPLPaT4NIvxdy86/MKtS92MNAQ0r7eDW2x0TT6TR3/FIqylxKIiMwlTSqJedO7cr2u5E0KYpJrsnvCyB71oq3Y9AOUL9KZHVnuAfqDmFBg8qn7YJ7iKQncbe0oDNxMYtWz6mqw5io+DXHcmhFIDn5SGm3hGwAllgdocLLdaaFyfxnP2hXjJku4UkkOvYAiQvpwuNnfZc7n+/T879of/J9P5UshsdKpyjcWIkTWD4keELOW176REgmfoBEaUTDZ2Luf7rEDvOS/Z65tzl5v0L0YQB7/LXKY96asSNrVz7TunZd2FVfG/DrV7cBH6pGduofduQnOv7QwFb+dWDTtp/VKdQILE22UgzcY/Z6ntZ5Rnyni7LctD/8kowIQ/3ca0kqmTwku76mF77xvsqvESrlMhzbtXotDj8qMYUXeu0/Y/1SKuLPyeTB/EVkjQWL1o8uGheit/wHbn4VMIMNjjf+8jV4E0e1wMTWHDjigeCM/uhJe5I4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5nV0l0aVB2K29vZkt0a1Z1VGNmRkZkSXEwSm4zbnhnTmlPb3QzSXIrOTFv?=
 =?utf-8?B?YjlqQkw1TmFvblNsZEtuOS9LS09uc1JGSDY4MG93cWJ4eDBKMHhUMVNvWXpS?=
 =?utf-8?B?a0RtQ0JFcndoSzlyRkhTb2lXOGl5SmU1TmhhQ1BaeFFLUUZUekFxZWFnU0hI?=
 =?utf-8?B?S3pTRHlyUktTMDgzbUZTVnloNWhXSUZqWnZndFUzcFpUNkpBR1lCeFRtK1NU?=
 =?utf-8?B?TXR0LzlvTGhZV1plSnM0bk12c1JwVTRBdTJ0MEVNSlU4aUZpT3poVUNrMW5v?=
 =?utf-8?B?VGNtT2U4YUE3QVc3dVRjMkFTZGpkSDVMT2ZIUFF2SmxHSTVTMkNIZHFQMWxv?=
 =?utf-8?B?WUV3ZjVsTFgyZUljQlEwMjJHV2JCUHlXVHhZcVlRREdnaTlTOTNQOUM3OUds?=
 =?utf-8?B?V2w3eHptaGpkcTYvbzJUWkZPdVRxQUxkTUxJUlFnd2dOUlByZkJVcXNVWEN4?=
 =?utf-8?B?K2dzRTA1WjRBeTcxd0FldzRRMHZYZmxvZlhNZmVIQzg0elRtN1RrYUhka05p?=
 =?utf-8?B?d3g5eUlBVUhSbVFxcGpsK1NiWFpFN2dJNEY1UVY3dzBvdXRsOE8rTnJSaUpo?=
 =?utf-8?B?c1gxY3FwNFBrTGxlb1BqcEoyZExqV3hkREowVXRiQzY2aGJzRzZkcEluaWdn?=
 =?utf-8?B?SlJsMGNrSDZVSG5mb2YzQTYwR3lxNTFCdUQ5eEVWNllaYzVtdW4zNm5Mc2Rm?=
 =?utf-8?B?eXJrRS8va2wvbURKbGxlU0FhRTRTc1cvVXlVVHpoOTd5N21kaW9EY3VFVmVx?=
 =?utf-8?B?dlphUC9hd2lkOUd6Q2RxNnVpampJbWduV2RzTkV3VEtSNEtEa2ZrSlhpd3Nj?=
 =?utf-8?B?UHViaHlmeXlJMUZYY1hRZ1c1c0xxa1ZmaGw3R0NIVkJUcTl0UkNNZkdKQ1RF?=
 =?utf-8?B?bHU0Vk9YWnZTcjVrWW1vK0JZd25lbk55WlBycDhCcXd4VG5WaE1MYlQxbStk?=
 =?utf-8?B?aWVFdWpDRGsxbHMzeGVPTHJtZUVEM3ljMVVmVnNmb0xIQlViaC9rQndrdThM?=
 =?utf-8?B?c2o0YVR2RHZtNUUvTEp3S3Q3MjdjdThvSEV0ai9LQ0NOdHkvelhzcjc4NnFW?=
 =?utf-8?B?SmZuaVJvUjJhbG5VTERnV2dESjFlMHBxVUdTUlB1Z0gxZk04cE1mOFNiWGhE?=
 =?utf-8?B?SDZhNW9SS0lxejZTWDgvbXo2TUI0NmR1Z3VsYnVjQ3k0bW9mNmFjUlowbUsz?=
 =?utf-8?B?VmJhZUc3OEFCcUZoSGVQS2J4ckg0WUZQN2ZvMjMyN0NTeU1DRWxja25lSUJn?=
 =?utf-8?B?OWRTT1QxOE1ubzJWdUpya0x5bUZYOXU3ZmRidmpWRnVJT2U5dnNzeXJSMlBp?=
 =?utf-8?B?enIrR29xZllmNmorL2RZOEV2MmYxbVdieFI5K2RncHVUVU05N1dQcC9jYjJB?=
 =?utf-8?B?ZVQ5NUhUd1E3c1hqZXFjUnFVY1dwc2Z4OVFoSXhJSkZtc0FqcGk4ck05Sjg4?=
 =?utf-8?B?QjRWYUJ5b1hxeWR5aFcveHFjbUkzUlYwRWRRK2NGTTNJY2NUeXFLWmJrOEZl?=
 =?utf-8?B?OTVUN1Qwc0VlWkhwcTV1TnA2b0J0dFdkTC83SHM5c3JncHZJbGZmYXM2OVFK?=
 =?utf-8?B?dk5SajhtUlJxWk16OGZaeWk0YzVOR08wQitGa1Bhem1zME10aTQ3L3lZbVhJ?=
 =?utf-8?B?TGhJQ3YvdkxsVDRoYVQ1NHVEZWVxaW54QkpkMllxWXh6SC82N3dnMlpIenIy?=
 =?utf-8?B?NDJEaGlkSWlLSmlwdWp2dnA5RXFheFlmU24vamZBeDJoLzZUTXZNbnRUbGEw?=
 =?utf-8?B?NjBIRXdvaXllbzVuYlBFalhSZG55aEVtcFJrOG52UXJwdEFKOTFkQUFaNnJ3?=
 =?utf-8?B?QVVVWVFucjVleXR5SVBvczVkUUtTNzR0RWVNblZZSFFnQ05zOFlheXRaTDNV?=
 =?utf-8?B?ZUcwenNkWlBjdEYwaHpDa21lKzZySWMveXhQY1hxc2w3aDQ4clpab2FwNyta?=
 =?utf-8?B?M0R0ZXVQaDRmSDVXZUFTNGpFS1Q0V0Mwb3cwRE9iRTg2NVRhaEM4TFJxYmtM?=
 =?utf-8?B?RWp6aWNXUzkvNXVaWE9STGxyOEgwRS9HM05jQjBFb21KRnpsWnh0ZGxjTVVP?=
 =?utf-8?B?NW5hTkZqczhmcGxHeURVdEgwdmRnQmtKL1VXY093SWcxa25ldWh1bVNzMHNs?=
 =?utf-8?B?OUkrWlBjMjd2TWpTdFNOeVBoR0JHMU00c1VyMkt3NmR3ZHdYK3UreWt6SlYw?=
 =?utf-8?B?MGs1NFFtcFVqd2Q5ZXh4U05WZ3czZGxaVWhqRGgxRTBKYkQ2LzkyUW44L2pi?=
 =?utf-8?B?QnU5dDRjZnBYTUFxWmNZV05XcUNhNmJtRFkrWVQzcVlxNkd2VkxBV2FocExL?=
 =?utf-8?B?VzFIK1lPL1FzZFNtVnBteW9VY2hhZDJ3Y1RncXF5NlF6YUlib2NXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qnfiZ5pAP5CyGzVLSsVYkFAlgGWnD5whDCEczLxLiGRXhhU3lMBQ9zkpgOVTNw5B3DQeh2O0/THEE8b+luqrNr8GZRqB2IF8xvzhMCrJw3rhL99xiJKWj2WbTQ2Af4oXyXA9bLMfnZYXb46eyR9DpAwT1VHRIJd+WAYcwkb6XEHhuh0Sy72z2rUjfXiruJ1TAr0CT71a/P+3IMqoOWfBm9wziXSq/nKzuHFJLi3LqsitLtIacPaA82ph1KatpnnVXvkpmV8KBwbM37wRlCR1MDl2UgMTj1I5x4X3exN326Da/YpSIk8ZuaTorcARDRbyx+2ztAxZ6GLchk5ltt3wmQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a15c0-772a-4b24-c8cf-08df244eff98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 08:43:02.3803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEvZWw5eRy/ota/r2JifGSpy6OfuumKLCvWxLc52eLIOogX+BUPlPKaL4TtUgGJNlh/EaeiTKguPonOXz4d/B4bjqJ+tsgShcfpkYuEcZLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8578
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzhdIGh3
L3VzYi9yZWRpcmVjdC1zZXJ2ZXI6IEFkZCBhIHVzYnJlZGlyIHNlcnZlcg0KPiBkZXZpY2UNCj4g
DQo+IEhpDQo+IA0KPiBPbiBXZWQsIE9jdCA3LCAyMDI2IGF0IDY6MTbigK9BTSBKYW1pbiBMaW4g
PGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBNYXJjLUFu
ZHLDqSBMdXJlYXUNCj4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody91c2IvcmVk
aXJlY3Qtc2VydmVyLmgNCj4gPiA+ID4gYi9pbmNsdWRlL2h3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIu
aA0KPiA+ID4NCj4gPiA+IFdoYXQgZG8geW91IG5lZWQgYSBoZWFkZXIgZm9yPyBJZiB0aGVyZSBp
cyBub3RoaW5nIHRvIHNoYXJlIHdpdGgNCj4gPiA+IG90aGVyIHVuaXRzLCBiZXR0ZXIga2VlcCBp
dCBhbGwgaW4gLmMuDQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IE1hcmMtQW5kcsOpIEx1cmVhdSA8
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHN1
Z2dlc3Rpb24gYW5kIHJldmlldy4NCj4gPg0KPiA+IE5vdGhpbmcgZWxzZSBpbmNsdWRlcyBpdC4g
VGhlIG1haW4gcmVhc29uIGZvciBoYXZpbmcgYSBzZXBhcmF0ZSBoZWFkZXIgZmlsZSBpcw0KPiBy
ZWFkYWJpbGl0eS4NCj4gPiByZWRpcmVjdC1zZXJ2ZXIuYyBpcyBhbHJlYWR5IGFib3V0IDE2MDAg
bGluZXMsIHNvIEkgdGhvdWdodCBrZWVwaW5nDQo+ID4gdGhlIHN0YXRlIHN0cnVjdHVyZSBhbmQg
Y29uc3RhbnRzIGluIGEgc2VwYXJhdGUgZmlsZSB3b3VsZCBtYWtlIHRoZSBjb2RlDQo+IGVhc2ll
ciB0byBmb2xsb3cuDQo+ID4NCj4gPiBXb3VsZCBody91c2IvcmVkaXJlY3Qtc2VydmVyLmggYmUg
T0sgaW5zdGVhZD8NCj4gDQo+IFllcyAtIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBzdHJpY3QgcnVs
ZXMgYWJvdXQgaGVhZGVycw0KPiANCj4gPiBJZiB5b3Ugc3RpbGwgcHJlZmVyIHRvIGtlZXAgZXZl
cnl0aGluZyBpbiB0aGUgLmMgZmlsZSwgSSB3aWxsIG1vdmUgaXQgdGhlcmUgZm9yIHYzLg0KPiAN
Cj4gVGhhdCB3b3VsZCBiZSAibXkiIHByZWZlcmVuY2UuIEkgZG9uJ3QgbWluZCBsYXJnZSBmaWxl
cyBhcyBsb25nIGFzIHRoZXkgZG9uJ3QNCj4gbWl4IHZhcmlvdXMgY29uY2VybnMvZG9tYWlucy9s
ZXZlbHMuDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxsIGRvLg0K
DQpKYW1pbg0KDQo=

