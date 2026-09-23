Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6622AC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qic-0004u6-0r; Wed, 23 Sep 2026 13:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x9QiR-0004lt-8n; Wed, 23 Sep 2026 13:25:11 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x9QiO-0002u1-W5; Wed, 23 Sep 2026 13:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcnzrOll05fh6pDU7W5L0Ryl4hip0HiqBNmKTpGexEk5cJD4amdMc9JRM0ECUo3iTOlBe74V/bS889Q2+zkj/9rW5ejCfnYQcp8jghVStiIabduQN3VnwU/R1Ueu1d9ITRMWB2L9GdClVTxtgoqskBXxYtfkrMDL62oeNB9S/WtirYTiys9n0H5mxQ3DFbH0KZT4FzZpCDtydv7FBEbCYFj6N39YyB0uDhUV/Cl/SvV9J2st/Uk1+XhcpKY6t24zfCPTxu/yi7vk6jdCiGmuwE2K8TxHTe/1Um1GjRERFdGun7VSMkoVGVo8gpMIvWMy6EWF4yNsVDZYgsPOzBCKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZm0XP7UnCJ61Vf/5pfuY/uFmUJXz+YYwcdG7cVU0f8=;
 b=Ilbi97UcoMZz+FUY+E/ZRS32oNSnp7HFSX6ARHv2IS6vKiL/EmRYu2h98wAVXyfK0GCa74ivsI3VhogVp2GL9QIJ+WM0h6/ydOYH0SiFOmulaQ90X7zm/oHLQtvI6zowLWvye9tL7gHRBxz2YYhocFlSdb5KH0IqDPDtu964Z/qvhHjiYM16FeGwTDPWhRkiH+WTsIPu34bGTY9wc9d60j63VatyjoxLdtU58Cqogu30Tc/7pIXku6hv+6CvBrNXAH0hi/saCagEVnRH0QldZIMRVyZjGM+0t8vLqivspH1zR38rj5i49sFE6fPDXmLGDL6ac4IeMM0OWTs4ztslUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZm0XP7UnCJ61Vf/5pfuY/uFmUJXz+YYwcdG7cVU0f8=;
 b=OKTQs/0mCsgLFb1m4BYz/Y/9kFlEEXVxZC+jwQSRPrYIt35vVCaBfACICpInCdvzPYf+ETcfuq/7fstusNq5TvaiZiAchv8cwndvf70+zdDK0QRG6PsVRnk46EaV6IPnw6b3cDCsDDGA6ZICpX0FFvXr4AtRHKhnCNYg1eA8OdgS39S7l+W+kRkFUT2uwirqAPry7eZmdeZTySJNhk23IPNchayRVRxTzMI4Zas/P4phg7E9/SXDwP7FUEp9Zm6wq5H5G6N2OZpIvCdyjYKjguyhM7900OWVpcBAoESYRJM6FVn3HxRQTqnetewTUP+7KwusQBpxSarRDb/8rXx5PA==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:24:59 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:24:59 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Subject: RE: [EXT] Re: [PATCHv3 00/10] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Topic: [EXT] Re: [PATCHv3 00/10] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Index: AQHdSPbhT7o8r4ZYGUSkQjT+w/vebbbaIJqAgAJKaxA=
Date: Wed, 23 Sep 2026 17:24:58 +0000
Message-ID: <DB8PR04MB71779F207064411F31E56DBC87822@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
 <DC17DA54-3C43-4955-A38F-6FADFAA2EFF5@gmail.com>
In-Reply-To: <DC17DA54-3C43-4955-A38F-6FADFAA2EFF5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-23T17:10:46.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|AM9PR04MB8953:EE_
x-ms-office365-filtering-correlation-id: 02dcb5a5-3140-4bcf-6bb9-08df19979788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|19092799006|10070799003|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info: LtrOBqucO+ixClUEfbdWYG/dnD41/ELnjQEhjgStgv/23YOvQvVlFVzeEZIbx85fAFyHI6mcbdxEGzOApXYx1IgdYoIjdeEEZ9qenUSvPgQr52vU2gwwuWjo34uzhPB8P8IpVrl67CPLEyt5vVTQXXCt+l6lAqCwXBzAi43/sX0k8069adKc4tezsYPvii2ZoeP5jdtkdC6njECLmJ8CEFH+w7avuITPUnkI5lmHVPUs6rN+FFrzVcDy+FV4XJ1pTM2Lp5ukfKJCNT+8A2lTVDcy33nfkRpb3lOUVH2NuzVnQlEGSU2B4no49sj59IjkFDkm4E6se5frUiTPuxX60loXwG8nFtqGzh1aPIr/RI2M4BDhZe8/a1na/5xOi/ovAbAN2etpiFGpsvdeYDOs1E/nrEGk8Bap3mXtPitgrc5SAf74S+u5kU8g/tgvsw3F2VoY+M2DcQMqLAvKGVsx9/WfEGpW43ldkT2L9DGVhHOkQAxRJypq7Y3f+kZhNNqoz99NkfYkYMSLB/yNaq4GIpvPbqSmhJVMQfzFFIVKBST2ArG0yjsoFVDR1VcLk2gl6vaxS6Oa8lfyUjCn9i1j6Pm+Ni4x80aLEhk4bRtz3NeTCpjjGzn7k3xkC4cTe0m/HW2Q+8yOxbSChbreak1cfunhIvD02Z0lF8OzSKFUEX+egKuRtdzZHeJgZ8ariYmQ5IUStVrv1qYV5KYf6jE1NGDbUGHc/hDDpWS98cjy2+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(10070799003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(10067099003)(38070700021)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFvRGNSMUhmS2FYcWl5ejRwSks5UzVoTDBYNzFPR1BCTDU5d28yMzlkRFNy?=
 =?utf-8?B?NXhqWUdud0xPOCsvdnVYYnhaeURmRjQ2eDhvK0xCK0JuTTdudVVVb1FJaldn?=
 =?utf-8?B?dkZTdmF1L3pJTEVmRDV6bE1id08vYXRxNHFZdUwwV0Y5bldhc2MvbWRYNkk3?=
 =?utf-8?B?dmpNTGRZT0Fwb3M2MXI5UUxXa25qQVgxVTQzR0x4bDhMeDlLOW1tcmRsd01y?=
 =?utf-8?B?dG9Idm0rdDRYb0VMUWV5b1d0dzg3Um5ZNXUzbjVNdW1OQS8xTFBrbnpaSVZu?=
 =?utf-8?B?VlNkcVRqRmFtZmdXSGpIamZaZi91OGhVSGZraXVtazBkbklwVzZ6K21yVmVK?=
 =?utf-8?B?aU44NGxXZEl3WHhvVnliaHRzRHNUWE5leFlwMjdXYVk0M0tENEorTkVlUFlJ?=
 =?utf-8?B?SG9MSC9kaUhUMXNVMDNIL3lJc25BakpmR2t0Vi9zcTB4UG51enhMKzdONFNE?=
 =?utf-8?B?VTNaL1ZsckZnUWxGbXBidmVMRm1ZUTVCRVRhUW5yU2svbTg0WGU2N3VtZ214?=
 =?utf-8?B?UkZDWFBDWi9sU0l6SzcxSXlIeXpXc1dRalR0T0tRWjExS3hzVlpldGIvWFBX?=
 =?utf-8?B?NDI1bFJsZldPM1hySG93dDZhazY1Z1B0TUtDdnZkYkdEUGdOdGdtMGk4L2R2?=
 =?utf-8?B?eEJPSkxtYkJ4aUR1ajdsRkZFV3AwNW5ueWx4ejhHdS9yMld4RHdIbHlIS3M0?=
 =?utf-8?B?NzZvT1FQV28zU2JMUnJkb3grSG5yTUF4VFdRbVpPTlBtZXpMRVhtalVwVTRU?=
 =?utf-8?B?VFRBOHpkcUc2dlNHZGNsODJDNE92S2xOVDNFU0dKWXJpbkUrVldGSTBmcXlU?=
 =?utf-8?B?UVFGbHRRRmV2dG90Z2V2TlMzcExhZW55TE4xWHRCZnVIOG8zOEM4cDZHQ1Y0?=
 =?utf-8?B?TzJaaXlFYmM2MGUwYWtzMnhNR1lzcWJDajRDYjNDdU56SkkySkh2cmZQeDJQ?=
 =?utf-8?B?QzRRcS8ydXJjN1AzSktuaEs5QThwamVCeHZPdU1PbzFJRnFRZml4TG5QUlB6?=
 =?utf-8?B?c0NHeHNMY2MvMldSRVJOenl0SUtJeXRsTnNVM1lGRUY5ME4zbVBsNlNkeEox?=
 =?utf-8?B?Ni84ZzlrZzVUcDB6bEduMEE2UkpPbUlBbG92bENaRkZsYmRVaW5TWDVRQWpP?=
 =?utf-8?B?UXo0U2FkcEJ2VDVyMWJiTzlYZ0xRdzdENjEwN1RCVVhnY1Fxa3BmUyt5azAz?=
 =?utf-8?B?bWNhcjlzcEE4VVBNUkg4TzNscXJkL0pWc2JIcDlHaHZnTjFJbjJQNFNkTDJF?=
 =?utf-8?B?dUlvOGlPNWtwdFRoa3dzeTA0dmNUeFV2RXJkRXZNUDF1VWRRaXowWnhzekJp?=
 =?utf-8?B?TGE4S0dIaElVd3VBTWRMVnA3cVhjQVZ0a0w2US9Jc00wSTNQcWJjQ1BTWVR2?=
 =?utf-8?B?RVZ0VEJ3V2p5aHkveUsrQlFuWVhEME8yalRhQ1R2dWVvY21NWmJ2MldLM3JC?=
 =?utf-8?B?SzZzWERRUTBsT1hnM211dlVxckoxOWd4WkRvTXc2cG9rb0IrcENNOFFHYW1n?=
 =?utf-8?B?RThmaE0raUgxMUR1K3JjSDJNZVYySFRTMm9zVnZqMjg2cnlRRnRva0VNeTJO?=
 =?utf-8?B?VXRLN25VV2FRWlFxYmxmZkViS0xwcE9LV3dXdERBQ29hWjZlWHQ4STVkSDcz?=
 =?utf-8?B?MnhIY0lGVGExeXl0QVdsellLV2JPaTRlU0tjK0xvUkE1aVhqQzZCS3pabVRp?=
 =?utf-8?B?TW9ocEoybmN1R1JtNDFJTTZhN2s5bGlNcG52cXpkTGorbkkwWWZ3VStuaVNs?=
 =?utf-8?B?dXFsU0l2Q3AxQXU3ZDNVZWVUM3VHdWYwTjRoa2FvUHExd1dWZnJTYlFvcWM3?=
 =?utf-8?B?aTk2MEY1WWVsRnRRVmNNQUtsZkNPSjhwVjRMNjNQQ2N1MlplaHhSYjNUQWlZ?=
 =?utf-8?B?OEExdUR0b2hLSXJxNEhHRU1jdUt4M2YrWFdVblg0ZFZOMm43MFUwUWdVT2tJ?=
 =?utf-8?B?WjlBMnlGR2ZhZENBZTBBeFlVOGZCRzNDdTRsbURQSGUva1h0ZHVDZDNoNXAx?=
 =?utf-8?B?ajhNTndaTjZyWnl0MDF2aExad2hieEhZTW4yUGhrb3lmMmdXUmRLZSt5dFZu?=
 =?utf-8?B?NFNidnNFZjE4YmNNMElYandOUXJPd3J0N0pwVHBjSDliV0xYMGdwWG1JUFc3?=
 =?utf-8?B?c3QydjNTQ1orN3lOUU1iWHQ1SnI1NUVhek43Q0xnenB2eEVPVkxKZ2o1Mmh3?=
 =?utf-8?B?T1dYTGNEMDcwUzAyc3lReFNrdmE5SSsxTm00S0gxK2lnSVNldzdwam9vWVBP?=
 =?utf-8?B?YlhUM2Y4aGdoSlhpVzNxSjhLY2w5M014L0dNbEJRMGlRcXBXZEI2QlhFMlds?=
 =?utf-8?B?N2hJTVBZcjZuazBJVmtGR0Y2TFVrZ0VLaDlMZVBsbldZdGtwV0lrb3JPekNt?=
 =?utf-8?Q?Wsmvl+JGc9FizVqhSQs/E3/FrtTImgzJtTqu3FwZBFmiX?=
x-ms-exchange-antispam-messagedata-1: t3g/KsGDvXhdAA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dcb5a5-3140-4bcf-6bb9-08df19979788
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 17:24:58.2899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77Oh2hFyDIwpKvtU/+6fEqXyzrbuMwdgwYqpySwoU38NPge3//Rd+NXiiED14/pHl7vVDI+OXyhDbErSmCaycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
Received-SPF: permerror client-ip=2a01:111:f403:c200::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdtYWlsLmNvbT4NCj4gU2VudDogMjIgU2Vw
dGVtYmVyIDIwMjYgMTE6NDINCj4gVG86IEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0Bu
eHAuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBxZW11LWFybUBub25nbnUub3Jn
OyBwYm9uemluaUByZWRoYXQuY29tOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbQ0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENI
djMgMDAvMTBdIGh3L2FybTogQWRkaW5nIENvcnRleC1NNyBBc3ltbWV0cmljDQo+IE11bHRpcHJv
Y2Vzc2luZyBib290IHN1cHBvcnQgZm9yIGkuTVg4TVANCj4NCj4gQ2F1dGlvbjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9y
DQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2Fn
ZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4NCj4NCj4gQW0gMjAu
IFNlcHRlbWJlciAyMDI2IDExOjU0OjQ4IFVUQyBzY2hyaWViIEdhdXJhdiBTaGFybWENCj4gPGdh
dXJhdi5zaGFybWFfN0BueHAuY29tPjoNCj4NCj4gSGkgR2F1cmF2LA0KPg0KPiA+Q2hhbmdlcyBp
biB2MToNCj4gPg0KPiA+VGhpcyBzZXJpZXMgYWRkcyBBc3ltbWV0cmljIE11bHRpcHJvY2Vzc2lu
ZyAoQU1QKSBib290IHN1cHBvcnQgZm9yIHRoZQ0KPiA+Q29ydGV4LU03IGNvcmUgb24gdGhlIGku
TVg4TVAgU29DLiBUaGUgTTcgZmlybXdhcmUgY2FuIGJlIGxvYWRlZCBhbmQNCj4gPnN0YXJ0ZWQg
ZnJvbSBMaW51eCBydW5uaW5nIG9uIHRoZSBDb3J0ZXgtQTUzIGNvcmVzIHZpYSB0aGUgcmVtb3Rl
cHJvYw0KPiA+ZnJhbWV3b3JrLg0KPiA+DQo+ID5UaGUgc2VyaWVzIGludHJvZHVjZXMgdGhlIGZv
bGxvd2luZyBwZXJpcGhlcmFsIG1vZGVscyBuZWVkZWQgZm9yIEFNUDoNCj4gPiAgLSBHUEMgKEdl
bmVyYWwgUG93ZXIgQ29udHJvbGxlcikNCj4gPiAgLSBHUFIgKEdlbmVyYWwgUHVycG9zZSBSZWdp
c3RlcnMpDQo+ID4gIC0gU1JDIChTeXN0ZW0gUmVzZXQgQ29udHJvbGxlcikgYXV0aG9yZWQgYnkg
QmVybmhhcmQgQmVzY2hvdw0KPiA+PHNoZW50ZXlAZ21haWwuY29tPg0KPiA+ICAtIE1VIChNZXNz
YWdpbmcgVW5pdCkNCj4gPiAgLSBFeHRlbmRzIHRoZSBDQ00gd2l0aCBNNyBjbG9jayBvdXRwdXRz
IGFuZCB3aXJlcyBpbnRvIHRoZSBpLk1YOE1QDQo+ID5Tb0MNCj4gPiAgLSBFbmFibGUgQ29ydGV4
LU03IGJvb3QgaW4gaS5NWDhNUCBFVksgZnVuY3Rpb25hbCB0ZXN0DQo+ID4NCj4gPkNoYW5nZXMg
aW4gdjI6DQo+ID4NCj4gPi0gUmVtb3ZlZCB0aGUgdXNhZ2Ugb2YgZGV2aWNlX2NsYXNzX3NldF9s
ZWdhY3lfcmVzZXQgaW4gaW14OG1wDQo+ID5ncGMsZ3ByLG11IGFuZA0KPiA+ICBzcmMuDQo+ID4t
IFJlbW92ZWQgdGhlIHVzYWdlIG9mICdzbXAnICwgJ21heGNwdXMnIGFuZCAnZW5hYmxlLWNtNycg
dG8gbWFrZSB0aGUNCj4gPiAgaW52b2NhdGlvbiBzaW1wbGVyLg0KPiA+LSBDbGVhbmVkIHVwIGlt
eDhtcF9zcmMgYnkgcmVtb3ZpbmcgcmVkdW5kYW50L3VudXNlZCBjb2RlLg0KPiA+LSBVcGRhdGVk
IE1haW50YWluZXJzIGFuZCBpbXByb3ZlZCB0aGUgaW14OG1wIGRvY3VtZW50YXRpb24NCj4gPg0K
PiA+Q2hhbmdlcyBpbiB2MzoNCj4gPg0KPiA+LSBBZGRlZCBhIG5ldyBwYXRjaCBmb3Igc21wIHJl
bW92YWwgZnJvbSB0ZXN0X2lteDhtcF9ldmsucHkuDQo+ID4tIEFkZGVkIGEgbmV3IHBhdGNoIHRv
IGludHJvZHVjZSBJUlEgc3BsaXR0aW5nIGZvciBpLk1YOE1QIEFNUA0KPiA+aW50ZXJydXB0DQo+
ID4gIHJvdXRpbmcuDQo+ID4tIEFkZGVkIGEgbmV3IHBhdGNoIHRvIHJlbmFtZSBGU0xfSU1YOE1Q
X05VTV9DUFVTIHRvDQo+ID5GU0xfSU1YOE1QX05VTV9BNTMsDQo+ID4gIHNpbmNlIE03IGlzIGJl
aW5nIGludHJvZHVjZWQgbm93Lg0KPiA+LSBJbiBHUFIsIHBhcmVudF9waGFzZXMgbW92ZWQgZnJv
bSBnbG9iYWwgdmFyaWFibGUgdG8gY2xhc3Mgc3RydWN0DQo+ID4tIE03IHJlc2V0IGhhbmRsaW5n
IG1vdmVkIGZyb20gdGhlIG1hY2hpbmUgdG8gU1JDIGRldmljZSBtb2RlbC4NCj4gPi0gQWRkZWQg
SVRDTSBhbmQgRFRDTSBtZW1vcnkgcmVnaW9ucyB0byBzdXBwb3J0IHplcGh5ciBmaXJtd2FyZQ0K
PiBsb2FkaW5nLg0KPiA+DQo+ID5TaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYu
c2hhcm1hXzdAbnhwLmNvbT4NCj4gPg0KPiA+QmVybmhhcmQgQmVzY2hvdyAoMSk6DQo+ID4gIGh3
L21pc2M6IEFkZCBTUkMgKFN5c3RlbSBSZXNldCBDb250cm9sbGVyKSB0byBpLk1YOE1QDQo+DQo+
IEkgdGhpbmsgeW91IGNhbiBjbGFpbSBvd25lcnNoaXAgb2YgdGhlIFNSQyBzaW5jZSBJIHRoaW5r
IG9ubHkgbm9uLQ0KPiBjb3B5cmlnaHRhYmxlIGNoYW5nZXMgYXJlIGxlZnQgZnJvbSB0aGUgb3Jp
Z2luYWwgY29tbWl0Lg0KPg0KDQpTdXJlLiBJIHdpbGwgdXBkYXRlIHRoZSBhdXRob3JzaGlwIGFj
Y29yZGluZ2x5IGluIHY0LiBZb3VyIHNpZ24tb2ZmIGNhbiBzdGlsbCBiZSByZXRhaW5lZCByaWdo
dD8NCg0KPiA+DQo+ID5HYXVyYXYgU2hhcm1hICg5KToNCj4gPiAgaHcvbWlzYzogQWRkIGkuTVg4
TVAgR1BDIChHZW5lcmFsIFBvd2VyIENvbnRyb2xsZXIpIElQDQo+ID4gIGh3L21pc2M6IEFkZCBH
UFIgKEdlbmVyYWwgUHVycG9zZSBSZWdpc3RlcikgSVAgdG8gaU1YOE1QDQo+ID4gIGh3L21pc2M6
IEFkZCBNVSAoTWVzc2FnaW5nIFVuaXQpIElQIHRvIGkuTVg4TVAgZGV2aWNlIG1vZGVsDQo+ID4g
IGh3L21pc2M6IEV4dGVuZCBpLk1YOE1QIENDTSB3aXRoIENvcnRleC1NNyBjbG9jayBvdXRwdXRz
DQo+DQo+ID4gIGh3L2FybTogRW5hYmxlIENvcnRleC1NNyBBTVAgYm9vdCBvbiBpLk1YOE1QDQo+
DQo+IFRoaXMgc2hvdWxkIGJlIHRoZSBsYXN0IHBhdGNoIG9mIHRoZSBzZXJpZXMuIFRoZSBwYWNo
ZXMgYmVsb3cgYXJlIHJlZmFjdG9yaW5ncw0KPiBhbmQgc2hvdWxkIHJhdGhlciBiZSB0aGUgZmly
c3QgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzLiBSaWdodCBub3cgdGhleSBkZXBlbmQgb24NCj4gY2hh
bmdlcyBpbiB0aGlzIHNlcmllcyB3aGljaCBwcmV2ZW50cyB0aGVtIGZyb20gYmVpbmcgY2hlcnJ5
LXBpY2tlZCBmb3IgZWFybHkNCj4gbWVyZ2UuDQo+DQo+IEdlbmVyYWxseSwgdG91Y2hpbmcgdGhl
IHNhbWUgY29kZSB0d2ljZSBpbiBhIHNlcmllcyBpcyBkaXNjdXJhZ2VkIGFuZCBzaG91bGQNCj4g
b25seSBiZSBkb25lIHdpdGggZ29vZCByZWFzb25zLiBJbiBmYXZvciBvZiBhIGNsZWFuIGhpc3Rv
cnkgUUVNVSBpcyBub3QNCj4gaW50ZXJlc3RlZCBpbiB0aGUgZGV0b3VycyBkdXJpbmcgZGV2ZWxv
cG1lbnQgYW5kIGluc3RlYWQgd2UgcHJldGVuZCBhcyBpZiB3ZQ0KPiBrbmV3IHRoZSBzaG9ydGVz
dCBwYXRoIHRvd2FyZHMgYSBnb2FsIGluIHRoZSBmaXJzdCBwbGFjZS4gTWFrZXMgc2Vuc2U/DQo+
DQo+IEJlc3QgcmVnYXJkcywNCj4gQmVybmhhcmQNCj4NCg0KWWVzLCBpdCBkb2VzIG1ha2Ugc2Vu
c2UuIFRoYW5rIHlvdSBmb3IgdGhlIGd1aWRhbmNlLiBJbiB2NCBJIHdpbGwgcmVvcmRlciB0aGUN
CnNlcmllcyBzbyB0aGF0IGFsbCBpbmRlcGVuZGVudCByZWZhY3RvcmluZyBwYXRjaGVzIGNvbWUg
Zmlyc3QgYW5kIHRoZQ0KQ003IGJvb3QgcGF0Y2ggY29tZXMgbGFzdC4gU29tZXRoaW5nIGxpa2Ug
dGhpczotDQoNCjAwMDEtMDAwNSBody9taXNjOiBHUEMsIEdQUiwgU1JDLCBNVSwgQ0NNICh1bmNo
YW5nZWQpDQogIDAwMDYgICAgICAgICBody9hcm06IEFkZCBJVENNL0RUQ00gbWVtb3J5IHJlZ2lv
bnMgKG5ldywgc3BsaXQgZnJvbSAwMDA5KQ0KICAwMDA3ICAgICAgICAgaHcvYXJtOiBSZW5hbWUg
RlNMX0lNWDhNUF9OVU1fQ1BVUyB0byBGU0xfSU1YOE1QX05VTV9BNTMNCiAgMDAwOCAgICAgICAg
IGh3L2FybTogQWRkIElSUSBzcGxpdHRlciBmb3IgQU1QIGludGVycnVwdCByb3V0aW5nDQogIDAw
MDkgICAgICAgICBNQUlOVEFJTkVSUzogTWVyZ2UgTUNJTVg4TU0tRVZLIGFuZCBNQ0lNWDhNUC1F
VksgZW50cmllcw0KICAwMDEwICAgICAgICAgdGVzdHMvZnVuY3Rpb25hbDogRml4IGkuTVg4TVAg
RVZLIFNNUCBjb25maWd1cmF0aW9uDQogIDAwMTEgICAgICAgICBody9hcm06IEVuYWJsZSBDb3J0
ZXgtTTcgQU1QIGJvb3Qgb24gaS5NWDhNUA0KDQo+DQo+ID4gIGh3L2FybTogUmVuYW1lIEZTTF9J
TVg4TVBfTlVNX0NQVVMgdG8gRlNMX0lNWDhNUF9OVU1fQTUzDQo+ID4gIE1BSU5UQUlORVJTOiBN
ZXJnZSBNQ0lNWDhNTS1FVksgYW5kIE1DSU1YOE1QLUVWSyBlbnRyaWVzDQo+ID4gIGh3L2FybTog
QWRkIElSUSBzcGxpdHRlciBmb3IgaS5NWDhNUCBBTVAgaW50ZXJydXB0IHJvdXRpbmcNCj4gPiAg
dGVzdHMvZnVuY3Rpb25hbDogRml4IGkuTVg4TVAgRVZLIFNNUCBjb25maWd1cmF0aW9uDQo+ID4N
Cj4gPiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICst
DQo+ID4gZG9jcy9zeXN0ZW0vYXJtL2lteDhtLnJzdCAgICAgICAgICAgICAgICAgICB8IDE4OCAr
KysrKysrKy0NCj4gPiBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA0ICsNCj4gPiBody9hcm0vZnNsLWlteDhtcC5jICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMjI3ICsrKysrKysrKy0tDQo+ID4gaHcvYXJtL2lteDhtcC1ldmsuYyAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNSArLQ0KPiA+IGh3L21pc2MvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTIgKw0KPiA+IGh3L21pc2MvaW14OG1wX2NjbS5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDkgKw0KPiA+IGh3L21pc2MvaW14OG1wX2dwYy5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAxNDYgKysrKysrKw0KPiA+IGh3L21pc2MvaW14OG1wX2dwci5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxNTUgKysrKysrKysNCj4gPiBody9taXNjL2lteDhtcF9tdS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzI4ICsrKysrKysrKysrKysrKysNCj4gPiBody9t
aXNjL2lteDhtcF9zcmMuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgNDExICsrKysrKysrKysr
KysrKysrKysrDQo+ID4gaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNCArDQo+ID4gaHcvbWlzYy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNSArDQo+ID4gaW5jbHVkZS9ody9hcm0vZnNsLWlteDhtcC5oICAgICAgICAgICAgICAg
ICB8ICAzMyArLQ0KPiA+IGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfY2NtLmggICAgICAgICAgICAg
ICAgfCAgIDMgKw0KPiA+IGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfZ3BjLmggICAgICAgICAgICAg
ICAgfCAgMzQgKysNCj4gPiBpbmNsdWRlL2h3L21pc2MvaW14OG1wX2dwci5oICAgICAgICAgICAg
ICAgIHwgIDYyICsrKw0KPiA+IGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfbXUuaCAgICAgICAgICAg
ICAgICAgfCAgNTMgKysrDQo+ID4gaW5jbHVkZS9ody9taXNjL2lteDhtcF9zcmMuaCAgICAgICAg
ICAgICAgICB8ICA1MiArKysNCj4gPiB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9pbXg4
bXBfZXZrLnB5IHwgICAxIC0NCj4gPiAyMCBmaWxlcyBjaGFuZ2VkLCAxNjk2IGluc2VydGlvbnMo
KyksIDQ5IGRlbGV0aW9ucygtKSBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBody9taXNjL2lteDht
cF9ncGMuYyBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9pbXg4bXBfZ3ByLmMNCj4gPiBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9pbXg4bXBfbXUuYyBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiBody9taXNjL2lteDhtcF9zcmMuYyBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS9ody9t
aXNjL2lteDhtcF9ncGMuaA0KPiA+IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2Mv
aW14OG1wX2dwci5oIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGluY2x1ZGUvaHcvbWlzYy9pbXg4
bXBfbXUuaCBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBpbmNsdWRlL2h3L21pc2MvaW14OG1wX3Ny
Yy5oDQo+ID4NCg==

