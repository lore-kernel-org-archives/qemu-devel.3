Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2394CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8y-0002Xo-CP; Mon, 11 May 2026 05:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7r-0001x1-AI; Mon, 11 May 2026 05:40:35 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7k-0001R4-58; Mon, 11 May 2026 05:40:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDviJSXAdL34cVG+LcqeFxWEW//FUIDdqcfsPl/SG6XmUCCofU9mwbL83PvqlhTjsK6F329PY97s0LXcvNtME0T+xKSOQam04PqInYQ1kkwr4WOKHSwshHgauw5zNiCFxU8oA4xPrL1HNjEc5jGXhPRue3FHxAjX1vCtu6Xk77Q1kTCvNGg7VzpIE3H4/mYoMEo9eKGxuLa/buLMikyqHjrnZtZvIeO2oYjz9MZdj8X9XEB0xn5G7nczaox23rL6oYsizSA88ZcDjsWBdZb19SG3gqopXzWVE4wEBBGVWr/fGk8RAI7dtGPWyApAQSzo5FYYlieHZ1LhCpbJCnbn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClmaYx00rRlh5fC+rvPoc9gww6z60k4vJtDwWB980P8=;
 b=lxiYCmKnQwwe1F95c4WAKIPTLcxVd2VbzUMgjJKlxmYTTcm9bLeIYmCdKPYfp48SU4T8QyFhMInNlJKDssbRBLBzAsfiOGTfB0SHGYWvb2sSM9G73mRTwIFaYlcs5fXboc2E9Oj/tnL9Jp6JfMmBbC93/5/8NC00Cu4YKsdmVh2yx8Ejh1G6LvqpQ254Wza6qDGus4rhUgz+UC74mYfLD83uO2nKckxtKIBHpL6J5CyTxqGTQ8iQ0XgjLNMU62QFNNemG1rLJ5gGvpB0KLFfE+f84b02xImH5Zub0gIXD+2qi9uAtD+VUz3arj3LrdOTSOvVbfC50svB6se7NhiJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClmaYx00rRlh5fC+rvPoc9gww6z60k4vJtDwWB980P8=;
 b=fDmdB1E+4RZ2RDegzi6n8tqays1a3NtXX1IkyTQ1eP5wsMU9hql06zUnhwCor7pukJfw14+GXzUy8kegqQmMIpsozImIELEWqHEY6GTs5ushPdiqctP0SO/kc9+NzVVE909ImXiBlupcNtejX5X0MYhlElOMXxZHkgpzPSypjah7+uLQege4NbSjWM4sWWsm+vAGQES6UC2GdcyXr+wthGFdlCWDywG987gqbE2cO4k+0ngykuw6SKoxQBBKF5V0xLTh9BNyNC6U230cgEV9UrY8k+/cX0lFOy+irVancq/uH5PQ7VlOvpTIfRJJpeCyPGEtnXZCRE9BpKAXYKXZpw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:27 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:26 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Index: AQHc4SGJJFFTewwpskSfCNpEFr+omg==
Date: Mon, 11 May 2026 08:38:26 +0000
Message-ID: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: 7fcb8fc0-39be-4d2a-cf2b-08deaf38abc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: Z/kgFJBhlIF6oq33iADIB0qv7U5bPvbkChHzb+F3quUvjRqaX5YhufJJT4kpPx3LILi55nM4Jqd7Xkn6xY1p8mZuNdr75U5Chi1+onpkYwVTPgpp7LJSV1+pDF1blvdQO5kmD+XMwKPy3IQe5xhNAtHR1ckDHgZPkApEyYApWh1EvMEzQdHkz/0ttJnxV3x8FM1eg2GnQvuLOWq3foE5n9N20xhXe3gX+dxvtV3aXQ1bZ16oMPw1kOO2Nrr/nELJv/wG1bfqor/FMu4fcsNRAR89sVsJ4QUOcaMztKGTj7Vwx0LbRJJfbyTvSFEPDFMhWCjL52OsPX6vrejEKQcHaYU8VjB3A6LK+yZ26/CLrkvJ7JZ9hCzNXdod7j1aAcNRoACuhEQRb/u2VCSUGWKS43i3ddLtRk2BDjpEsks/C7f1WZ0pdJYe9H+y5ZIkj5Y4RIje2NeIap7Ufl1Q1IZaaRsRV5usImgjOUKpt9ATdBHw0sZDvbUgb8k8VLuk/NylGQ8VdSpLONw+0J9YEphFPOFfnS9XAPlG4nh4fdj9Qi7FfYmeKDMEpFCdPEGDsBMThjH5LHPrIM9r5jNpauH7npv2kNeiGgReus/eaS51CN6fkAdqj6er2BBJMiHP/hHXtvsJJU7BQfiT+MSASOkrwC71jnVgVaAlrKwiSSo2PqpivvAcd140mhvspBMNwemZosLYn71G4lpAp/8IfpCw78QzsXW7h8WWibrjJk9qeXniX9JxAP7dH+PJG3yXFaGK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpSL1lRNXo5c0JEcmFjRnpxVGZoZFRwUkI5SnFHWXFmNWdoWkRkMnZkNnhB?=
 =?utf-8?B?bDRnRVd0QTRYd3hyOEpGNkYyYWRFeUdyMUI5Y0oxMEtmZjRtVm15QUJNTUJ6?=
 =?utf-8?B?cVJIOHpFNFFPbjdwb1pjWFBKTUlkK204UWtOZC9lVTA3T2F5VU9JOHl6RFRW?=
 =?utf-8?B?c01QdE1Kc1RJVEh5d29sa2h4aWc5NlZyQ1VZMHhPeDRvZU1LWldXUDdKaUNH?=
 =?utf-8?B?RHF0dS9DampkeUhYeWNtbmFzZGFCMERNL2VLVERGQkdJYjYrTWNab1F2QXRt?=
 =?utf-8?B?QjExUi80WFQzQXBxRmtkcGV6eHI3V0JoL01DNzc3c2ErOC9vZlNwRk9od3Zh?=
 =?utf-8?B?QjhTcVRFakh4Y2NvckRGbmpHRjZEQ3FJK05jN2ttRjJnMVg4QVgwK1pBTlpI?=
 =?utf-8?B?ejJDWGs3cWxVakdZQUttOUhkWTJzRld3UldPNW43YjJNSUtzRVRsUFBmclVv?=
 =?utf-8?B?MVhzMzZBWStZTnl4R3d1NkNWK0N0a2k5ZWprNGxzTUFmVGhTci9CeGRxWVdG?=
 =?utf-8?B?SWxiei90VWhJcG82bWlwdUkwV3NhaVIvVlFubmRHcDdCSEtDNHBocVp0Nlpq?=
 =?utf-8?B?TlBwelN5SWVYRk9NSUFIK0wrdGdpdVJDUlF5TnQraWhIMEdGaHFSeFdpOXVs?=
 =?utf-8?B?aVlPK0doYzE4UjY5Z1NEL2p2WXJ3d0NkRVBRYUMxNG5ia0hHc0tVaWZiUzJv?=
 =?utf-8?B?cHIvbDQzUUdoUzBXQmlVMGVUZEhHelgwT21YcGpCTU9LM2lRcklmNUF5U2Nu?=
 =?utf-8?B?ZkZxK0ZPSkJxODIyNU9tL1JJd09NVlJmdDBxd1A5S1RTaER5SjFZVGsra1Jp?=
 =?utf-8?B?aDNIUmRxUThVVXZnRmU1RUhWOHpJTnVJMTBhU0dUL0tweHdwYWpwV0I5OXNC?=
 =?utf-8?B?NTVqTUpPcm1nai9yK29yL05lZUI3YmxjYnMzeitIME5DTG1FNWNZQURtQUh1?=
 =?utf-8?B?ZGNVNGZ3Q0RsZnlPdDlQTEpSS25FMHFxbVdPTVgvY2h1U1RtYmFyMGVLbXZ2?=
 =?utf-8?B?aUhnTU5rRTFjMVFYSjVLMmp0bFdTRTNBOTRJaWFWL2V1TTllbzZyUmE1R1dp?=
 =?utf-8?B?NlRuaURUUkxPaEFubXN0blhXbWsvU3B4YnA1WWo5UWU2NHFqc3Q5RDV1TWRp?=
 =?utf-8?B?MjBVQTc2RjZGRy9iblZaRklKRDMxdnZBMmlVMTdvcFpTeDJXbVhyd1J2aUQ4?=
 =?utf-8?B?dEZEVGhQcWYxMnhMM0pJK2FtbmtxOHN5YVRBSHd0eC94ZzdwUkEwMHVMb1Jj?=
 =?utf-8?B?dGxiUWdjaXRDRzNZRmhFS2lwU002UHZwSjlwcXVMMndIN21MNUtuc0hmTU95?=
 =?utf-8?B?aEFlSE8zdmp0VktjVmRkNFdEZVFDMDk4RkIvMHdxSnErQW9yblVwSGpScEFC?=
 =?utf-8?B?NzEvb1ByckF2TTZ0R2pNNnpOUlpQT0VCN0FUZXE2NXVQdmhUYzN3VHh3YXZR?=
 =?utf-8?B?VmMxQWRQUXJ0bTdXYW1aM2VoVWg5M1Fwb1liejdRMUVtQkQ1S2xsQ3ROU0p2?=
 =?utf-8?B?NXVxNTRkZmJPRXZWMHZUVEQvV0VXeG4wU3BwRk43Q3hMeVZSQWE5SWhnUVdL?=
 =?utf-8?B?bFdONkc4M1RhaE4yN0JZVE0rSzV5YkRVMHBGSCs2eGlaQjBFamcvTVNDa1Rz?=
 =?utf-8?B?K2RZYUV2cWRtMnRmTjhxdnNYRWxjZU5rNktKNmZzd2ZWbXVhZUFVaXNNUGxK?=
 =?utf-8?B?TW1KRG93QUFEcUhLMkFkdHo5MjhFSDVZSk02REc3NExvZlErMXVjWGVDNS9s?=
 =?utf-8?B?d1hTYndXNzFjQkNKWEovSHg1emtnWnBTQ0pEV1ZnYTJ3KzFaWkdMQUxKZXR1?=
 =?utf-8?B?UVRSTUt4OTRIWmIveTVsa2h0MlhjeGZIWHZYc3lrL2w1SjRJSmVDL3FBQ1Ry?=
 =?utf-8?B?cHdneW05bHpZejFuSlFQWUtFMEgrbDFrQlJtS0dVa0gzcSt1UEdnN2FJMEdK?=
 =?utf-8?B?dzJXeEJMcHozZ2QrV2ZlWWhHZnl3SlRGQ2FVc3dXSzlNWVFYOHZZOVR0dzlQ?=
 =?utf-8?B?VEg4OTRwazlTcUxId2VvaU0zS3JRV0pEY0pVRTJ1L3RnTzE2ZHJPQm8zdjZk?=
 =?utf-8?B?OWtrVDNadzRjaWlIK3FvaTlzUkhnVXIzZkViUE4rWndVbVU1K1A3bTJMS0JI?=
 =?utf-8?B?VmNIeWtvSllpK0h4YU02aEc5ejFNRnB0VlZ2Ly9WZE1QZVJEeXJGRTNGYUZy?=
 =?utf-8?B?TVRFNGd6UVlnaUVUUkV6Z2NEbDVKSWUyakV1bDY4WEtRdmcwNko5a0NYZWF6?=
 =?utf-8?B?UHM2UTU3N1VpanFseHlsdlBjb1g3M2JWOE10dUk0YStyTS9HRWNXQUdtblhu?=
 =?utf-8?B?eG9IaTJ0dGpQZ2xTQjRod29EQ1pHV3doVFBFcFNXNDJEYjVBOVp2Ui9VMlly?=
 =?utf-8?Q?l1vYj2FVfCW+a4eLN3hvKtcwkJb1pPeQNlmYZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6F076CA8F421D40AB3019AD52D0CB74@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb8fc0-39be-4d2a-cf2b-08deaf38abc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:26.7810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuUfUJJDJv7mSo1lQ9+qX+aFlBhLevq7ZtYrImJovQI3elFnwzcA2bkLTiRNQgF0DGT8Ybw/IDhC9VF0xSw5BkUNyxY/G3UYcjZO0umldUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

UmViYXNlIG9uIHRvcCBvZiBtYXN0ZXIuDQoNCkRqb3JkamUgVG9kb3JvdmljICg3KToNCiAgdGFy
Z2V0L3Jpc2N2OiBEZWZpbmUgTVNUQVRVU19TQkUgYW5kIE1TVEFUVVNfTUJFIGJpdCBtYXNrcw0K
ICB0YXJnZXQvcmlzY3Y6IEFkZCBiaWctZW5kaWFuIENQVSBjb25maWd1cmF0aW9uIGZpZWxkIGFu
ZCByZXNldCBsb2dpYw0KICB0YXJnZXQvcmlzY3Y6IEltcGxlbWVudCBydW50aW1lIGRhdGEgZW5k
aWFubmVzcyB2aWEgTVNUQVRVUyBiaXRzDQogIGh3L3Jpc2N2OiBNYWtlIGJvb3QgY29kZSBlbmRp
YW5uZXNzLWF3YXJlIGF0IHJ1bnRpbWUNCiAgdGFyZ2V0L3Jpc2N2OiBGaXggcGFnZSB0YWJsZSB3
YWxrIGVuZGlhbm5lc3MgZm9yIGJpZy1lbmRpYW4gaGFydHMNCiAgdGFyZ2V0L3Jpc2N2OiBFeHBv
c2UgYmlnLWVuZGlhbiBDUFUgcHJvcGVydHkgYW5kIGFkZCBkb2N1bWVudGF0aW9uDQogIHRhcmdl
dC9yaXNjdjogQWRkIGVuZGlhbm5lc3MgdGVzdCBmb3IgUklTQy1WIEJFDQoNCiBkb2NzL3N5c3Rl
bS90YXJnZXQtcmlzY3YucnN0ICAgICAgICAgICAgICAgICAgfCAyNCArKysrKysNCiBody9yaXNj
di9ib290LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4MSArKysrKysrKysrKysr
KysrLS0tDQogaW5jbHVkZS9ody9yaXNjdi9ib290LmggICAgICAgICAgICAgICAgICAgICAgIHwg
IDEgKw0KIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEx
ICstLQ0KIHRhcmdldC9yaXNjdi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIz
ICsrKysrKw0KIHRhcmdldC9yaXNjdi9jcHVfYml0cy5oICAgICAgICAgICAgICAgICAgICAgICB8
ICAyICsNCiB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMgICAgICAgICAgICAgfCAg
MSArDQogdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgICAgIHwgMjgg
KysrKystLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2YS5jLmluYyAgICAgICB8
ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZkLmMuaW5jICAgICAgIHwg
IDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydmYuYy5pbmMgICAgICAgfCAg
NCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYyAgICAgICB8ICA4
ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZ6YWNhcy5jLmluYyAgIHwgIDQg
Ky0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnphbGFzci5jLmluYyAgfCAgNCAr
LQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2emNlLmMuaW5jICAgICB8ICA0ICst
DQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZ6ZmguYy5pbmMgICAgIHwgIDQgKy0N
CiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnppY2Zpc3MuYy5pbmMgfCAgNCArLQ0K
IHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3htaXBzLmMuaW5jICAgICB8ICA4ICstDQog
dGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeHRoZWFkLmMuaW5jICAgIHwgMTYgKystLQ0K
IHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3ppbHNkLmMuaW5jICAgICB8ICA0ICstDQog
dGFyZ2V0L3Jpc2N2L2ludGVybmFscy5oICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKy0tDQog
dGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMgICAgICAgICAgICAgICAgICAgIHwgIDMgKw0KIHRh
cmdldC9yaXNjdi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgICAgICB8IDIyICsrLS0tDQog
dGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L21lc29uLmJ1aWxkICAgICAgICAgIHwgIDEgKw0KIHRl
c3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2VuZGlhbm5lc3MucHkgICB8IDU3ICsrKysrKysr
KysrKysNCiAyNSBmaWxlcyBjaGFuZ2VkLCAyNTEgaW5zZXJ0aW9ucygrKSwgODAgZGVsZXRpb25z
KC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2Vu
ZGlhbm5lc3MucHkNCg0KLS0gDQoyLjM0LjENCg==

