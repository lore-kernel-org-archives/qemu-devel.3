Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4D91098796
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQd-0002v8-H6; Fri, 20 Mar 2026 11:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQc-0002up-98; Fri, 20 Mar 2026 11:06:22 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQa-0002Q3-9N; Fri, 20 Mar 2026 11:06:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey4AV7/gh/FMWmibrJWPxgNM43QI53y8QQb9qoJOz9K8MVWGESfqIZY7wopLL6eEFt1yt4T8jwuwmUDKpduEN63b6oPMcuLuDjuKVRzhn+1EiPtf1Oeq/34uAkvsaSHML6Ean6SZ8K2k1EIpjVNvrS7dxNIvGHeUAprCWWVvpucPGxmadNegbYN+93x4TlvKRr56MCIY5WKBUpSFof2nj5aeqFhjs9fyvVejm8TAzUaG0SdelqNuHuGs3QN1gG7Kp+d6DNTY47jxkypde+6wP8RzyNDjhxppizwHtpKjFtl3idxjFEw5Nx9V7cesgl2p60RnvvMsMqLt4F2ke1g/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=XL1TpZykv3gfxD87p7P67u179ri5ANkRmam1H0AAcvc9teK79Wm3K9wNrdLyu4saoVea+gudK+A+gYbVQyAgaNkLNaSNUH3tE0BRSMtr1YvuAdETxdGRh0E87/5jQP+rYjYkMbVzqNQdMidrGZYM9pobakZmcoIkyylJYGdAOkAQNIF7RsHKUVMY3QD9YSt+rU3+MpWilL07ilGixvIvIJEVOp313mxKqz+Vd4xA5Cx1+09aFVL2JaUd6gvNldcbmeT6mQzUC7mrfF8miGtRt/U6/GcPSBcvDIpvuap8xbWu8W/8V7sp35SxYICp72/2ETH4CmyAwvVT3z9OSo+1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=eFHOn2YyxlVGyBTDXzi1IMwEG9i37WHJmkrSaXuiyq9f2on1EAUxzgcF3s3GhPBxkGa5YAlCyXynrrmqKull4ORCrU44jAssI9+BqJzoZFhqw34l44qf0Wy8O7+YSiVW3jdHspnR9HkC+fgolSfbfheyY/cUQKHJdpDnDiE8nsfLTVrr/qk5wAwPDO2SxNrBX/HKtnhJgTuSSZPu/7RGQwj9jM2x/y5rjH5Ve5D+lzW5jsIZ8hEpd+jSFb4ZskS4iLYXY3iDNWV0qf68NFigLViL/boQBmwgCWAR215JDlP2bubMGGGkue2nB347WFXWYosd76mwygKEGX5LBvtCaA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:06:01 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:06:01 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 6/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v4 6/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHcuHsQu7G51v/OY0ipe6MVjgMSug==
Date: Fri, 20 Mar 2026 15:06:00 +0000
Message-ID: <20260320150552.169480-7-djordje.todorovic@htecgroup.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: f8bf845a-a4c2-4123-3c37-08de86923301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: xx/UWCJupT504FyNA7vJzD5AUiUxO63BSUPgd0CRIS1+9q+06IFP6msBjuz1Q2S41FYWKE7JkfBKRAllnQQPDic0GJcyDcI5/ksJ1aMg8lQ/CnnmTesWrd/LXuaX7P9IptZ3A7TbnhAw22GdhbyppBZOuwFpGFgGBJBz3RolNxVztnq1tDDMaU3qUrnaOpJnuJYEt04PnTevzVHjzrcUkEpfk+UoadzArZPcFo3vzvU10Q2VxLI11D6Ph1sB1H9mbSU1RKzGJgFLbrkkIRBbm+Pjk1Zxmd0CkOFfNAZD5iOed5E/RH24esmXjm/v17qtuIjrAMkUzBKrDAKduGvrxBM4f8uzZ5pNRYcbDRcadZdy3VjzXxwGz1o1kjNP8F6gQU4sOePen+8PdDRjow9vcEV4coqTZ1LEQzzSsveYsFIsZjSSZyCFJL/n7yl2cQJFFruhEmK4dSMVB5cFhM2OzkTf/HKpcqwNjRv5SB5PD/sFivXWd4dNX6YCV2A4wnCM5rHqHCgSt1Kg/O8lnCiItVkDYw2d4sAmg2OK3EZ+XPczTqqQn21bpz7fjXBLnOhYbCk39sR3b1XuuzB5sNI9W8pa5sXhxZ0Mjo3Z+wDxoqA4sMzWuU48W3hSYEX+rv4kzNAjtPYUHRwZfsEKkUatGSZBZ5u63Qh+ZJ4GMUaaN1isvDAkiYQyaVmaaTLHs2nyle/VhcONTCvERFvaK6AKBI5mAOmKgc3UPuIUkOjvDjLlgPHxtLdKPsVcGJdovdwrt232WwfCG/FbICzGWXsQ0g22O5WioZJBkMucI3qejJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNac3E0RkFuenZXbzc1RHFnaGYzdVpoNXdiZWdEcXpJK2hyNlJyY2xRKzdu?=
 =?utf-8?B?aE5jdllNQ1paNmUvMy9Dc1NGdE95aDIwY2l6NGptNHkyT1ppUTJOcjRBWmZB?=
 =?utf-8?B?cEJIbWNobGpyT1prUlhBZ0xpVHhXakpHS1dKamJkZWpmZUVMdDJVKzJ2eTY0?=
 =?utf-8?B?L0JhVHdxVmhlWGdLTmFDT3FQSmJTcXM5S2FZSEEyT2R6S0ptSkhMNTJHaG4y?=
 =?utf-8?B?akVUM0hEYm1veS9COE9adDJDSk5DcTB5TUtmdThlQmFQenQ3SFJaRkZhRldK?=
 =?utf-8?B?WW1HSjVTNmhnUS9lQ1lhWFhTem04NHJLTFVneGU2TzltTERsekhwa0tzR0Ur?=
 =?utf-8?B?V1JRZGY2MHZOOU01NWZBcWUyT2xNdWtxY1lVQk9Ram54eE85TFU5WGsybjRI?=
 =?utf-8?B?czNyY1gvNGhrRUZCYTk4TWFyR3psRENMSmsxbDFCRnVmKzFwQk9JR0x1TWIz?=
 =?utf-8?B?KzZ0bmpPYll5aG5JajlyUTJZVElXQ1I0R3NwcUpaY2RJWGJaZmdZUThCVVpk?=
 =?utf-8?B?S3MrSUVDSnUvcG9vNm9TZWxMRFJiUUFHU2oyMFhCNWQvc2x2SHNSSkMvemds?=
 =?utf-8?B?T1NGMEtDZVFYTFNMcWRpUHFXU3F2ZnJGL2pvc2pzYU10TTNPcEF1emw5Qk5Q?=
 =?utf-8?B?b0s0RW1DMnR5d1RGMkdrbWpCMTdtOURQMUhyZnhwaFhuYVVBZUl5RTZDUlIz?=
 =?utf-8?B?YWxZdWRRa2Y4SjhzRE9nWnlEdHBxMy9INDdKMU5RbGZnOEdQdGNDRGZsWk51?=
 =?utf-8?B?eW12cmJubmQwNUNNYUdHMWpVZEJ2TW5MNTFOYWcyeDg0cWZtdVRFTEdieWlL?=
 =?utf-8?B?QlZPYnRYQTlOTXA4eFYxMTVyQ2FoeXgxQ244cGl5YTZiQkE0SWVmcnpGYTds?=
 =?utf-8?B?OW81L0ZteXNIVUVkQlZINEZsMkl6VS9sa2FFZlN4dDB3c3ZhWW9Bdm1sQnpL?=
 =?utf-8?B?OHF5V1daMkI2RVNJZ2xwWEV1eWZPLzhEaHo4bVNZV2VUdHoxWTNlUkduVlBS?=
 =?utf-8?B?ZytiM3paT1RxQzlLQkVaVUhVanlpd3JMbnhRVnlwcjkzeXpxVDFvYUZIcWo2?=
 =?utf-8?B?LzBKaEFESTBCdVEyVzZVUUQwK09mTlFOOHdXaXY3c0haN2tvdWRGZHJtK3lh?=
 =?utf-8?B?dUp0bllCUVJZREZKL1ZrTUJvSnNxcGdJUWlQYTFCUWIzSjJaSnF4OGhPVmNw?=
 =?utf-8?B?MkpUSndBV05tRmEyNGNRV1gxaThEUFJGNmJBUHdBeWttSVZMM1YyNWR5M2Ir?=
 =?utf-8?B?TGxjMjcvcSt5TU9HT1RpMWUzSVBCQWZLUXFDY0NuWlM4bWdjRkk5T21EUldD?=
 =?utf-8?B?SVpwTmhwWjR5aWwzZ0QwYXZSQ09ZMDJEcFhyc1JqeEJzdkJQVVh0SFcybkda?=
 =?utf-8?B?TUtvdERLWnNCTk5ORTRDU2lLL2U3K2hmNFhYYWRSeVlqb2VVSmxaWkpDYlFW?=
 =?utf-8?B?SWxkdGFlWUVsWnNrek5MUjBoU3FoWDcyWEVVNHFhYW9Ydk95bGpzd3FHMG5l?=
 =?utf-8?B?MDFoRlZ2Z3c5TmMraEd4eDZjUG9Na29kRnpoUjlqNUIzdWw4bVYvSmdFdE1y?=
 =?utf-8?B?SUNSdjc5MUpFYlRrN2VJTkZkYitySUFDbDlKcGxvcENJR1Q4c0c3VHhmdlox?=
 =?utf-8?B?VEpRaStUOFBMTmd5eTVEM3c5Mk91MEozMWVlQkZrNDJ2MTd0em9KbnVYMTBz?=
 =?utf-8?B?TGJESHRvSXNzVm54dUhMY3hJR2U4UW4rL2tueFNVQjAvY0VUTnRjY2Q1c3ZM?=
 =?utf-8?B?RlBZeFhMamJzMUEvYmNEUEIzd3dKbTJEUGo1YnAvOFJOMnZHVHRHeS9oV1pL?=
 =?utf-8?B?dmo4S3BBZ0xuYzl1M3RldXBUWUpId1VrbEZ3N21LaDhzamp6c293MkM0QW5O?=
 =?utf-8?B?VkVwMm05TWFCT3YvMS8zQ0pZb1A5REgyb2FidVZrT2l0TjZhSExCWUxIVzhS?=
 =?utf-8?B?VzZyQUNrbTNVbHBpY0x3eG5OUmM0Uzg1TTRxOTliTk1sSXd6ZXRLZUhDMmZ5?=
 =?utf-8?B?QXIrdWFBSCtGaE5abXVJTW9BK21yWUc4Y1FTZHAzVUJkTWdGS0JyRGNWMDBO?=
 =?utf-8?B?ZUswMmFRbkZOVDlCcmhkUnIrT2U1SXFvb2czSnA0MmhxTzczUmtrbWN5ZVR4?=
 =?utf-8?B?L2VzNjNmbXFNc3NiSXVXOXVBYmlPenI3Rm9OcEplT1Y0OXpZUFkxREFnRWtj?=
 =?utf-8?B?MGlxWkdzY2tDci9hWm9Sei9nY1BTSTdncHh2QUtTeFJuT0hoN1FpSVZRR0xv?=
 =?utf-8?B?MXFYTGZRNHBtWW1TelVzWVBxdFlGbXNCOEFkUUdsTjBKMXRHY2RPQUxDM3ZO?=
 =?utf-8?B?Y1VTTnJOeEd6VzAwSzdpK1luL2xhZ1ZpMUFHaHJYYlo0ZlFQUzF2VmlsYVRt?=
 =?utf-8?Q?PuirOL8LAk/ZsMCIbNms3Fsozcmoa1MuW3/n4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6D87A535CEC8A408A629853A4D8EA23@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bf845a-a4c2-4123-3c37-08de86923301
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:06:01.0085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgan68snSfEBnIZy9NwM1UW2y195xRy4ureMLnmphwdJn7gB11ZIcEAaQeqWKBwR+ByrEg02nIDOwxMxl6+7d40CK7iPtnZbbe8OzCB/VTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IGMy
ODgzMmUwZTMuLmIzZDMzZGExM2UgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTM2NSw5ICsxMzY1LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTU2NiwxMiArMTU3MCwyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

