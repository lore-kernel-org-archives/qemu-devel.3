Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C30F54AD7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o3-0003m6-GC; Tue, 24 Mar 2026 12:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54no-0003j0-VO; Tue, 24 Mar 2026 12:40:25 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nn-0005LR-FX; Tue, 24 Mar 2026 12:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUhqS672lImHlKAILa20gUbF9ycSDV73n0XCuqzMakCjs3JOzriu/KaMBvp/RsJ3eprHOriCmJQ3cubFnelltjIbuieU3ih8fB7v9cVtE24vo5d4iuC37/b4+mE4gb+eiCqa0inEVqOAfW/Di1ILW1emR4zhHvvfKTToDEg5STSpW4XGYAkscX3PFGp6j7TxMU4malXHB8mYHbuNnK1sL3OjAApm9twvCnbRv/vB3I2HLG1odHtgKRCH4/ah3+nDhVpwtmkW8hR0Cjo2gZgP3YZ20kVnSn1Y+bdwr7pYqfC1uFgwAuWfocjYyS95HT1ng2gpAXK4bxASMFI0NDxucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxVd0zelaishGslxdyEa99lT2O6AelHU8rBpcucPeZQ=;
 b=Iqik8gOp4RY+RxnMhJnVq/qqTpcdUbHBlXfNS27lvCJhQUHW1RhIgzj8y+fhkzO/dOD2QaD3XazqO5eNwQuvFHHrLdP3MUWdLwskTsdpcQ+kNyod0ec7qTRgzigWrXO435oX4dY3/MgfDwbjtiE/xhiMzFSYBTXArVtaVF0x603QYOXNeq60TcDURlbtvma2qGDAvUxVV/hKtFZh3je23JSE/hfLYiAPrWWEEbMZkGE/89hNtSaNPRPFK2PAPFhEkkLPniA6zzMIjJAjr96cii3pnez1i1EvcWjwWUXiI6t493R5FVYBPz81GVrMxASAa5gc2zH2awa/X/wiz9Gt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxVd0zelaishGslxdyEa99lT2O6AelHU8rBpcucPeZQ=;
 b=DVEQwXKsSuTxRH4qRBs4YHMtp4zfRhBeEgEWLyW+hBBug4cHqN7Bbx0C/Ea7kiFxgkM+UfIIVQAUk5S2avStpdaBHxynr2TAh69zVJcH1rm/HFBjcn5qcxWbzaWelcZ37ryxwmrll1EbRn7VtelkachTTieURHzdS5ttr178zp+Y5zcAxx9MReuylzqLnZpz7AyLfaZ8vFW9sgvTjinCDApV45OceMZgGtvRGFvgoWa65zz6vcimqhN3g3rdd9vkb0ZHF723ApPFfVthRzwrWWc+IVY7qybqV/Y4WVq1MzBsPQElMD43J8pmI0v2dFW2+HEKHCMgCIoI0GB0xFSwWw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6145.eurprd09.prod.outlook.com (2603:10a6:10:475::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:40:15 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v5 0/7] Add RISC-V big-endian target support
Thread-Index: AQHcu6zk+cVmGNx/lUGTASbLuyOTgQ==
Date: Tue, 24 Mar 2026 16:40:14 +0000
Message-ID: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6145:EE_
x-ms-office365-filtering-correlation-id: 8a1dca5b-2fee-4703-2a04-08de89c4068c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: ae4Jx1WmaopYQ5855eI9NZ8uatAy+LR3Oi4pdNbJoqccC2+yuZE0QnIL0WkMUDuxjopjEXgA6al4AWV8kDMCu7wobaxd+nmt9ortxanyv2EIm7LAGNNdVsGaBLFNVc/MotLnSV6o9HO68f6HmV6tPNp+7HcN/L0ggSawIKKXLDMA0QhPbDyZaLKX6F4TWwuIPjJrb00hbA5K6ggqjfHEFwm01T8bZabU4X5FjufZirkCkYaOCloaFsFnoP742vsPJdcVBmNrQE8MT/z6a1DwZBQxW1yUFJ6wJvzES8GlGWElW9hG71OGH/KIVVWcyHbfyKmjGqvqkfHXJfykjmQye1pDwaC1oQ2WOBtis2vSCn+SwkefXKgxv0LbEzkzOSyiG1RsHQW12tZ2yX8PYgYd9Z2cerRFtUWFgaCmZ8kdXAM+mZmLXLdAn0STkj9ekmhTB9zQq1dxuD/Kuqv38PQThJhITHJUUOhBNX2tH47kIIS1nv4sTSVUGoNIR+zk16OPcwmC9spKhuN7+sG4ufy+n71YSvYvA3GKaNLFFubIxVor0gfVujEq4CNtBJvy/XIKnWsbh/XzWWHfO3QyfjQvYlJ9bazDm1nn9zoJBodt4JoD9N4Wu+qCmgNnxDXo5kfa28gMPmyJqC8gKAauZwNJG99pFxjo1lcz2F5NMDf2wu109xpCzEcMsdyWY+DBklZW3Uvbx3zTZ7WMA1B7ioxmas3Kh2JpIb+xaunAibF4Em3h95yBbgcgbHEO2TdGha/Z5kxLqaEyRY8XJbwHQBLefwQEuQtMeFigY2BkN2Pvl5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXcwUmNvMDB5ak5aWk9nbUcvNVpNcUpQMEF6b1d3Q1lrejBjYXVGZ1ZxWGgv?=
 =?utf-8?B?NStvYTRESFpsRU9EVHhubWNDQ3d6czE2WDNoWS9Cd0xrYlVjaE5NWXdSbW1Z?=
 =?utf-8?B?RXBwU29SaUd6OVRkZ2l6eG1rWkM4eG9nZ1Y5WDdGRWJOLytUMTZwV256S3cz?=
 =?utf-8?B?aHJMWjdEUWxjWWxJYVZVU3c1NDJrVDdydUh3bzdzcXhwbVpaSUc2alA2U05i?=
 =?utf-8?B?amt3YXpmanlSN3ZJaHpZVCtLa3FDc1lvclR4SFlRK0F1Skw5WUwxellGZUQr?=
 =?utf-8?B?Y3RPSXcrYU5zZXpBaGtjZ2JFUkRXQjlpamJDdkFveVAyeG45OEtad1VsSjRt?=
 =?utf-8?B?L1dWMnU0MVFxMzlqTDZDakV3Z25ZSXJmbUQycXpzM0IxZFhMNVFyTUVGbWta?=
 =?utf-8?B?TDZOS1h4WFA3QmdIZ040cGw4UVhTcXFJbFV6TmplS0wyMHR2RWMySXJrMFJs?=
 =?utf-8?B?YWhKbU93Nlp0VllyODhOdWxTS2dHVi81SVVDWFRZWVF2QWlTK1hxVHFrWjRF?=
 =?utf-8?B?emxzeS8zTm1qVGZ6VWFyWWVkUDdsdElGVWtWS0NsdjI4V21PelcvanJkS09S?=
 =?utf-8?B?K016MGZkVHh5bFpQNUpja0FsdDV3VS9EU3BqSXVqT1pCSUFSRVZibFk2V3pD?=
 =?utf-8?B?b0JBZHllTXdrQlYra2IvcjFOMHp0NmJ0R294MWUvdlNiVnc5c0ZtL09rWDE3?=
 =?utf-8?B?VjNzTmVKcXRsT3lveWdXZjBWdW9EQ2lRckpnS2xKMDJGMzlDbFpRYUo0d0JY?=
 =?utf-8?B?QVM1QVVXUnA0UUdwUDN4ZzlNVlMrMGQ0eHVkT1Y1c0Q4ekliYWIrVTBtTXZO?=
 =?utf-8?B?alZUanJhVXRjVkxadnY4S3VGbFIwYS84bmd5dmdLZ2JSRjFNTGZKV0tkVVpu?=
 =?utf-8?B?SSttckRxNW95WFoyWXplZjN0WFBKQjE3bnlLOGQyYmtnM1NMOUd3ZUsxejk0?=
 =?utf-8?B?eG96WERXc3BmS2pWQytoWXJFbGhqa1MzTlpVNlNicDJOVTdxRmtnb0FrUVVT?=
 =?utf-8?B?VVJWSmJxdGd4SnJhS3BOZDg1VFZOaUlMU0RCOXFPaHJsTFhacmVOMmEvSGZZ?=
 =?utf-8?B?OFQ5UERDdEM2dDlxUzFpRU9iTXI0NXdrd3V6SGc5OU1XZXBJb1AwVGR6emtU?=
 =?utf-8?B?emhGSG5BV3NvL25PKyt4QWNsWHg0N2hmR21oTyt3M2xiQXpOSVB6RHNDdk12?=
 =?utf-8?B?cHJGS3FBVHJXaFhtSVBFVmNtNXFkSFBCY1hCcEg4Ujg5RTE5VCs2Q2k2SE9o?=
 =?utf-8?B?SURJU0xWK0hsWkZUbWx0Z0xCUExWMXgvQXIwTFRqVHc3MGNjV215NGNndERT?=
 =?utf-8?B?eVI5elh3U1dRajQ5WXhZNENpb0JabXk1TWFQWE45NUt2dW5udFZwNUNsMm5y?=
 =?utf-8?B?VXV1UENGLzZYOGtmQWtneEc2blV1K1l6cGtPZzlrelVkOFJqdkFBNUNPRmEr?=
 =?utf-8?B?KzNSM0Qzc1ZuNW9GZ0tSVitWRk14NXBDV0FNbER3d1laMVdjNGVEVDAyWWZZ?=
 =?utf-8?B?cEdBeWpYcGRNTHNuMkZKR2hDTmN3eEJGOFZ0dkpUUjh3dzRqYU04UFAxS1BG?=
 =?utf-8?B?azdTa08zNW10b0NYRzZrdUZFZGtFUWpBUFYxMDZGdkY0YXVoNmgwNUh5R1hE?=
 =?utf-8?B?UnRyOXdmQXJqei9SbEhLK2N5VVNmaFRCazloRTdFd05DQWdhcEJ6cVV0bThN?=
 =?utf-8?B?Vll6Y21XQUJub2F1SlRnN1J4SHN0a1lraThnQVJiSkRaNFRTMytBTDBDMitE?=
 =?utf-8?B?MlBGZHpST3UyWkgxV1dKWDNwTDM4ZHphQTZBMFlwWFNQd1ZWYzhqVWthb203?=
 =?utf-8?B?UU1MQ3laSTRQbzR6R3QrUTlCZXJGQUtRTTlxd2RpWWgzS0lQZytvYWh3R25u?=
 =?utf-8?B?ZEtWUENJb1lFTDZXUzF5aXNtdUpXQ3pWUXJUYnAwb1pyYWprc1I4c2s1MDVu?=
 =?utf-8?B?Vm5IV2dqUkRBYlM2QW5KeUh6Z0RsRXV0Njlxc1grcUNac3VHM2w0THE2T2FJ?=
 =?utf-8?B?eGtmYlk5alNTR1dGZzV2RlZDbmF4dW5tck5CNEFTR09CbUtmOWFoL1MxbHVW?=
 =?utf-8?B?eFNVb2pIczRrRjAxLzg0cG1tRk43aFdud0lPZEpzaWxmU3c4T2VReW43dXIw?=
 =?utf-8?B?N0NFOFc4VHFYNUdlZ0RuT21xdjNWZ3MzNnk2bkhtZXpVTDJoYUNZMEdvWlgr?=
 =?utf-8?B?WnA2UHNIR0JBWS9FVzFoa2NDNTJLQ2l4dWpzNnVlU1EvU0FLQjdEb1pwUVgv?=
 =?utf-8?B?WlU3aitQMVh1OXFPQ3VqSHJsM3FnangzOEtmWEkwTlMzcXQydDRTQjlTSURP?=
 =?utf-8?B?M0VDT0pHdjFJR1NXK0p1U0txbzM3ay9nY084ajZMcU1nanQrNHBPM1Ixazky?=
 =?utf-8?Q?SvnjBqZn4R/wsS4ZZi9H3NBwpAIK9tnFXk1qc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E299F7F50E424C45AFA4B03F8FD33F35@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1dca5b-2fee-4703-2a04-08de89c4068c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:14.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXExQqhzY8rvsdENwpeX8fsDE3juP2xNTiQtisiBnXHnDm8G+tDZ+eGDZ9/qnjO3rrhSXWh0hNqoc+jv1hxDJdh1pYACpqndOQpTVkkFz6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6145
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

QWRkaW5nIGZ1bmN0aW9uYWwgdGVzdCBjYXNlIGZvciByaXNjdiBiaWctZW5kaWFuLg0KDQpEam9y
ZGplIFRvZG9yb3ZpYyAoNyk6DQogIHRhcmdldC9yaXNjdjogQWRkIGJpZy1lbmRpYW4gQ1BVIHBy
b3BlcnR5DQogIHRhcmdldC9yaXNjdjogU2V0IGVuZGlhbm5lc3MgTVNUQVRVUyBiaXRzIGF0IENQ
VSByZXNldA0KICB0YXJnZXQvcmlzY3Y6IEltcGxlbWVudCBydW50aW1lIGRhdGEgZW5kaWFubmVz
cyB2aWEgTVNUQVRVUyBiaXRzDQogIGh3L3Jpc2N2OiBNYWtlIGJvb3QgY29kZSBlbmRpYW5uZXNz
LWF3YXJlIGF0IHJ1bnRpbWUNCiAgdGFyZ2V0L3Jpc2N2OiBGaXggcGFnZSB0YWJsZSB3YWxrIGVu
ZGlhbm5lc3MgZm9yIGJpZy1lbmRpYW4gaGFydHMNCiAgdGFyZ2V0L3Jpc2N2OiBTdXBwb3J0IHJ1
bnRpbWUgZW5kaWFubmVzcyBpbiB2aXJ0aW8gdmlhIHN5c2VtdSBjYWxsYmFjaw0KICB0YXJnZXQv
cmlzY3Y6IEFkZCB0ZXN0IGZvciBSSVNDLVYgQkUNCg0KIGh3L3Jpc2N2L2Jvb3QuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDgyICsrKysrKysrKysrKysrKysrKy0tLS0NCiBpbmNsdWRl
L2h3L3Jpc2N2L2Jvb3QuaCAgICAgICAgICAgICAgICAgICAgfCAgMiArDQogdGFyZ2V0L3Jpc2N2
L2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKy0tDQogdGFyZ2V0L3Jpc2N2
L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjggKysrKysrKysNCiB0YXJnZXQvcmlz
Y3YvY3B1X2NmZ19maWVsZHMuaC5pbmMgICAgICAgICAgfCAgMSArDQogdGFyZ2V0L3Jpc2N2L2Nw
dV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgMjggKysrKysrLS0NCiB0YXJnZXQvcmlzY3Yv
aW50ZXJuYWxzLmggICAgICAgICAgICAgICAgICAgfCAgOSArLS0NCiB0YXJnZXQvcmlzY3YvdGNn
L3RjZy1jcHUuYyAgICAgICAgICAgICAgICAgfCAgOSArKy0NCiB0YXJnZXQvcmlzY3YvdHJhbnNs
YXRlLmMgICAgICAgICAgICAgICAgICAgfCAxMiArKy0tDQogdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L21lc29uLmJ1aWxkICAgICAgIHwgIDEgKw0KIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90
ZXN0X2JpZ2VuZGlhbi5weSB8IDU3ICsrKysrKysrKysrKysrKw0KIDExIGZpbGVzIGNoYW5nZWQs
IDIxMSBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfYmlnZW5kaWFuLnB5DQoNCi0tIA0KMi4zNC4x
DQo=

