Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8230CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcngC-00064Y-Dq; Thu, 25 Jun 2026 13:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wcng7-000647-UJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:15:53 -0400
Received: from mail-swedencentralazon11023119.outbound.protection.outlook.com
 ([52.101.83.119] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wcng5-0004KE-Tc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGnN2RVwpgyBJKMa369vZOjwwWt84LI4d256DWiDp7AlgQYj0PV/fSmWNz/3oUnsKzXmipE2a4Obw7COTyTi7BqTmC3gammh7LQfjsk3IiHqnBWqwJn35RheF5tXjcED+WCsI1ubrPg7iS1AXzJ1fQSVjTFtFNtxZZMe8IrIsJyPat4sZeVzevgXuk1VF1GMB6TnNRO7eZ3GwmZngQp3xNgzNbs4Jq9KPBUnXCzIEOKd7eY3+cxhYHNagQneqy2rz/Fn/OYHdBij6sQQgWZ64+wAo9UWrpFsimwNvZ+5V8ernZefnW7RxVRfl/j/YGRK1ZaGlrMixPef8DGZ/UQRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWDqnM5wHGgjLWr7YDcw3P5gT//SKyOL5T8LVEpssAI=;
 b=e6yM93SBZLd+OefQy2lsGcWTV4mW6WMskJd+CwNEd+0fDkee+xCgo895jFg9cy+Di2DYlz76N6N3F2KVfAibt+yfY+SrzTm8pI9fXNcOmaJ0fB8TcOV1tZuJofQ4GT0OYvVCI4s4SB0NAgAphHHxN2h97tkGW0p223fNgurT+FbiOGkHlNB+4s5hi6WEpHORctNt/L7ZnTnyLLW2XAG1Fo7j+DZRb13AgKgGjEkUzSdaC0QIXHGmqQMd61eGJBKVU5u4IbqzCMAHNMg4+/gpudfee2EcffvCENyIFznMFh3NEOsMyWorbI5/jmHpvx2UCu0q+2oOrMNb8L6NroJJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWDqnM5wHGgjLWr7YDcw3P5gT//SKyOL5T8LVEpssAI=;
 b=A2wxNKeALtLqz72rhnOaRVbAGn1rAu2y3jkLXSsbpzN06nuWcVNAnqvHGAC+rLj9bDymLu5HwnpvQAB++avCg2rXe9s6+IJkQPnEDZxF7Li7JUxjuRA0dtJDukiR7vA4EgAKUMfs08rS5wf7J9JzeDw5MB1ij5O6SG8bIbmhtP9mE0O7WVFKM987S7aQ4OTYMi12urOjlXtNvQyguob+9xzqpXtUIBIwbOE/m3+KkkPE6BZVqblEFLQgDGvRgvXu2rVH6q6LJ+4+va7Vq5v1Q86AcRQ3d8zuJ2MPXq3M/gzg9Gg2lG5MdFfDDBwsBBRw+SqxlNiZhFB8gdSmFjqysw==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by DB9P192MB2030.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 17:10:44 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 17:10:44 +0000
From: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "balaton@eik.bme.hu" <balaton@eik.bme.hu>
Subject: Re: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
Thread-Topic: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
Thread-Index: AQHc/ar9YJqHiU/Xe0mIuMVmAWI+gbZBgZgAgA4MfMI=
Date: Thu, 25 Jun 2026 17:10:44 +0000
Message-ID: <GV2P192MB34648A31A933E7C0FFCCEDDA85EC2@GV2P192MB3464.EURP192.PROD.OUTLOOK.COM>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <15686e53-4cab-4739-8b32-334ae567cf47@oss.qualcomm.com>
In-Reply-To: <15686e53-4cab-4739-8b32-334ae567cf47@oss.qualcomm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|DB9P192MB2030:EE_
x-ms-office365-filtering-correlation-id: e992b7b2-e048-48e4-9184-08ded2dcb135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|4133799003|4143699003|11063799006|56012099006|6133799003|22082099003;
x-microsoft-antispam-message-info: v170Ob7GJ2/xrfSj5EkXTtci0MDnGfdg3aUlFkc2e3dfRrJMc1LPwdrJgfxHZSHgIRw5Tg3dLLwHm2UMzuHyG9sHJjVX95gMBhCjm1txzF9tFvx/kCegWqWgQI9zZk2ipY3BFcvNh1DgCsOU8M6xo/8fUNcDRz/+dBb0BOB804OHaubbnqz0X1IXfRc0l1/lJ1Q48qD6klJeczUwEqLkiihBJTSahgcNWM47Z1987AGLZBs4scCkBDM9rLIgcWcTZ5FzWRl5OYkPiNryJqZPSf34nTe/bWDwjORo+zA1teD+5Ue3dhgGf0ZfXZ8fJEeMzLCrOJ+Z9EHykhZu+yl1hmYsbai9lMTeJ2XHeZMF21/LZvxjO/A8j8F3zgg9WeilXLX3GpoXKmW7M2wAtCWY+MAu5WjAGner+gMyqV8mriVtpIfDaSMO0YsDFVCQ0uxuSKbGHwMXgqJitzghHHf3oulxXkaeIikXaSaRqrh6eLwjreEuSeFR4G6ro1buhioNJRWeiJAZOxr7uKAG090ydtrjQflMI5kkrBq2citlpjwi0lH5c2ySdOInX5G7mbSKD/pzEU8kfScbBToqhbbbWYVetRUyC9hrH+YbbDyslT8eZb5dyR6VD4KxkrGXnLN1LVcexGAyKrgKak2Z9onrGJ1HYtFB/rNc99ATUGivzMSP7RyDPtWiRiv2Ntp9+4sUKbYxoiVg06l4UMlBXJMsHQZkW66Nu5aPdRAdeQ6wRGo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(4133799003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nrs0F7/4IxCAD1rmNvjKx7uW4QqgRMdYmM4EUJqMOuzI78xbv1dr0lAuef?=
 =?iso-8859-1?Q?VtG7Cb6iemw/+nIE24wMZIBmn6Ue7OTaQ3RXOb0J1sQeq6Svy7D1KC9FYZ?=
 =?iso-8859-1?Q?aEV6+2Rto9AaF9CiHTKqECqGNZqmUUiKnd6vHfgNT883HnjqMHQ4uLCkE2?=
 =?iso-8859-1?Q?xEA1WzAxFez36XvKNgvAt5GJDwdIJ3Gc137O8qpQfpXsMQ8EYhL7NBp7+a?=
 =?iso-8859-1?Q?KwOYX0JbS7Hmgg9tjyqcEDjTjx/z6rmqNCNjUxXIJuFTdNGnUI6eTbI5uv?=
 =?iso-8859-1?Q?gRy5PuA9IT0JK6iRLUOPiDc6JsnRo7Be3w8cfjJWoQL7Iz44D0gxyx/uSI?=
 =?iso-8859-1?Q?hFP3S8AtQDctC/gVGNmPbmlaEaw2rJ2pkTW9HSSp3Jw7CdmxOHuvz0ldxE?=
 =?iso-8859-1?Q?xajPgAK1ZnqVOAy2M2xy6rftrwv9KaP2Iva5lwgp4mmfBD3VEWarvPqkTL?=
 =?iso-8859-1?Q?oiiT9bhg9xdBWjqHoND71A7yDTZ+OIALmepIQDbg3E4sPD11mAkV8Fl6BV?=
 =?iso-8859-1?Q?ZDjCV7bVrunlANUVAxzIsR3gUrTkn114i86/YxsQI13NiwklIcaqrP7IQ7?=
 =?iso-8859-1?Q?ZFRjdZ8XXLz1a9ILOqjpxZArcBvmLyK7u5WgbYGvfV6Kg2nN2nDPtoqrFC?=
 =?iso-8859-1?Q?u3rYx/mNZkgLsSUphydIWhp6kVdziWL19WlLEY0GIOccA0zgKB1SOF6Em8?=
 =?iso-8859-1?Q?7qiLGDxu38NOYuANLVzra+pM41r1/WOMRg0iOaBCX4V8wYz1RQE5ghYngx?=
 =?iso-8859-1?Q?QSJsx9/PkzuGqBi4Z0QZ/gLlaGUk5bH+Yi3OmERiS3iqCVdMPOUeFZ2Dfw?=
 =?iso-8859-1?Q?YHGR555kjNX3ejzGj/NYOJOl8vrnxXUGx9v0sdfUazf6vFiNa3m1+q5OVr?=
 =?iso-8859-1?Q?bamvbZtS8+O/y8iSco1Aee7NiRWx4aBE3FvlX/BnsekYnvsnueuSeIlG24?=
 =?iso-8859-1?Q?9226RAeLo3SbCctxJpgB73WYgLydwdO7IFcXSJdMMJJ2Gt3Ggdcy0xgTJD?=
 =?iso-8859-1?Q?Hu36F4O3wHJyrvr7Wcwibl7FtHZx1zlXbxy05QptqqoA+FYGrW9mkFfN5S?=
 =?iso-8859-1?Q?qsinPyY+q6ucDi129aUIsGsawkr4ukWoCDW9y78PzfZuU8P728pCprd6Oi?=
 =?iso-8859-1?Q?LTDH195VJE2jE4kClazrlhfIl3H7I9x/M2N7yIgULF4bHWXBESHShTyqQn?=
 =?iso-8859-1?Q?eelSOYysn/o1qxawxFndbpcK/yWNNyPlu+L+T7lUCUu9chZrvAI1yRFZA0?=
 =?iso-8859-1?Q?VYan7LjX1s0cGcedi3wchn4MmNjpPhIQ5vj1I39WKaOGOBoq8OZp3KLhBD?=
 =?iso-8859-1?Q?YcGzesGE2ul4eHf4fsD/iRb1j/Bh0RBM+F56VIHbX3/5RAiW66NmzlEc2f?=
 =?iso-8859-1?Q?B8KSX+T8mkR4OZbMSy62gqMtmGqfPUkJjGNLOXiCiCjXsUs8K78QVzb62G?=
 =?iso-8859-1?Q?0B0/aSwHz6GUeC3bPiv6Cdu9Nq/u1qjLtPxQfvmbK37uI7cTeH6WIg8XzL?=
 =?iso-8859-1?Q?jEvIzVelZRn0OCwApC63j25l9v7accM6XsZIEnyKiBxad7teT4Bzcvn+7H?=
 =?iso-8859-1?Q?0Y0WqZ0AKfQUFa21Q83F7pNcAQUTzZIVADBW9nOeVWM83hHoKk5F104KrW?=
 =?iso-8859-1?Q?g86V9RSDLpoh6Nqaw8NaKU/ia3TuV+Ft/RppB5lJb5Fl8TvZ9TbgR3pxeP?=
 =?iso-8859-1?Q?k6OZ++9EC6DXJNied8RbssYz/3xyKmbWha57pzfOSfFU7rf6ljFvXxQG4o?=
 =?iso-8859-1?Q?Mk09KkK/g9UYWLFgRknpxIMBtN1c52b7vCt/8hBN1qbOwuhYIfkKHeIVhb?=
 =?iso-8859-1?Q?eknHsj411A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e992b7b2-e048-48e4-9184-08ded2dcb135
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 17:10:44.0291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6YPDbN8EGO8/Lsopy22GH9XA2p33IZa7D8WhT3FhSBm/3PkE32riw1WglxqN1aYJXVgAAKmk0a1WhngX/X3nHAdk6f1T3NM/R0kxN7Bowo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB2030
Received-SPF: pass client-ip=52.101.83.119;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

>From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>Sent: Tuesday 16 June 2026 7:32 pm
>To: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>; qemu-devel=
@nongnu.org <qemu-devel@nongnu.org>
>Cc: alex.bennee@linaro.org <alex.bennee@linaro.org>; erdnaxe@crans.org <er=
dnaxe@crans.org>
>Subject: Re: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vC=
PU structures
>
>Hi Harry,
>
>On 6/16/2026 9:12 AM, Harry van Haaren | OPENCHIP wrote:
>> From: Harry van Haaren <harry.vanhaaren@openchip.com>
>>
>> The existing code in execlog was never upgraded to the Scoreboard
>> API, resulting in a bespoke implementation of per-vCPU datastructure
>> handling. This had some race-conditions, and causes segfaults with
>> a simple multi-threaded program and two instances of execlog running.
>>
>> The patch here refactors the custom GArray and GRWLock code away, and
>> uses the scoreboard APIs like the other plugins. This solves the
>> "printing while expanding" race-condition of two plugins with multiple
>> threads in the guest, and hence fixes a segfault.
>>
>> Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
>>
>> ---
>>
>> Hi Qemu-Devel!
>>
>> This is my first contribution to QEMU itself, but I have worked on
>> DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
>> mailing lists for patches and some QEMU internals. I've read the
>> 'submitting a patch' guide, and ran checkpatch... so basics should
>> be OK I hope!
>>
>
>Welcome, and thanks for taking the time to contribute this!

Thank you!

>It seems like there is no cover letter for your series, which is where
>this paragraph should go ideally. Also, I think its presence is kind of
>mandatory for tools manipulating it when having more than one patch, but
>not 100% sure.
>
>I recommend you to use git-publish
>(https://github.com/stefanha/git-publish) which does the right thing out
>of the box and make sure your series looks like any other. Yet another
>tool, sorry, but at least it's one of the "standard" here.

Understood - have used cover letters before, but not using the git-publish =
tool, will use this for future patches/sets.


>For the rest, I'll comment inline on the patches.

Thanks for the quick response!

I've not yet respun the patchset as I'm also getting the "footer" removed (=
I wasn't expecting it to be added).
Will resend patchset (in-reply-to the 1st patch) with cover letter etc. onc=
e that is completed.

Regards, -Harry

<snip: rest of message content, including footer>


The content, data, and any attached documents to this email are addressed e=
xclusively to the addressee and are confidential and/or may be subject to a=
 non-disclosure agreement. Any use, forwarding, disclosure, and/or copying,=
 in whole or in part, without authorization is prohibited. If you have rece=
ived this email in error, we apologize and, please notify the sender or Ope=
nchip immediately, and delete it from your system.

El contenido, los datos y cualquier documento adjunto a este correo electr=
=F3nico est=E1n dirigidos exclusivamente al destinatario y son confidencial=
es y/o pueden estar sujetas a un acuerdo de no revelaci=F3n. Est=E1 prohibi=
do cualquier uso, reenv=EDo, divulgaci=F3n o copia, total o parcial, sin au=
torizaci=F3n. Si has recibido este correo por error, te pedimos disculpas y=
 agradecemos que lo notifiques de inmediato al remitente o a Openchip, y lo=
 elimines de tu sistema.

El contingut, les dades i qualsevol document adjunt a aquest correu electr=
=F2nic estan dirigits exclusivament al destinatari i s=F3n confidencials i/=
o poden estar subjectes a un acord de no revelaci=F3. Est=E0 prohibit quals=
evol =FAs, reenviament, divulgaci=F3 o c=F2pia, total o parcial, sense auto=
ritzaci=F3. Si has rebut aquest correu per error, et demanem disculpes i ag=
ra=EFm que ho notifiquis d'immediat al remitent o a Openchip, i l'eliminis =
del teu sistema

