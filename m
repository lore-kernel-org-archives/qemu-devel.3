Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B4C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 05:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4YhX-0006Jk-CI; Tue, 15 Apr 2025 01:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1u4YhV-0006JP-Ci
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 01:19:13 -0400
Received: from mail-koreacentralazolkn19011038.outbound.protection.outlook.com
 ([52.103.74.38] helo=SLXP216CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1u4YhS-0003S6-Q2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 01:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra3WxrMp6g3ELLv1tWnXuShOv0xfyRzCHM702TsDZYIQNFEaPLNTtZe9gr8DFUjMx2QaNr5eDdEvzEQOqoyoU/Ni0tkwC6giGHLEY56BhRFymqiFUK9xAwHIzv612Z8Y3cPieaGsE065gzuE/RxDir4wkU2xbF4siZdEPHx65j6M9nwDM/tPFRDTTtMmQfF7AP3LT3Dg/gW7nfJseq43OmIpmbnf2tIYvCkJDbI8JjOGZ1UCX20FW7gm03i3bXZAtFJTxGzmlI9yXmEqaWAOv6d1A8AAr01h8aJksVo9cPy+WJgesIpIzV6XRs9SBkmSSLqy4yhStTThlYRkNJLm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAH41uNJpkzORBplteH/BPLFtiEqJm2cMxbhmtg+2tM=;
 b=vwNVqEAWLA6JfQUBtVG1yAAE3t+yx52Ekkf8gCI4XMG94pUoK6F6Kwci0mSoIPb0IJuaFlSgq9u7h10ZiUwPLjZl7Tan8LHOIYSeJNDNeOl05t5D3iNwpluY2hUjt/b0iE7JVvBSNuoOnCEgjV48XUqmR1UIlyiTvqu+I0vol6qSXAwykqwhmKw0fMmcTg9cifHfc0PlnJU/Mwm4XKEJaLGd5Gek9w8JUUKfMk3EVY8cNyCH9eLi6Sg/445a1m8IsfQgncBkts+Q6csmL7HPiAaP/NES7plqTyZOMGQlbwiKTgwKXkVwy9/0NDGU//UleIt0ZGR4O7zxFDGUwnkLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAH41uNJpkzORBplteH/BPLFtiEqJm2cMxbhmtg+2tM=;
 b=PXkNQ4eeaiWTuIfcLV2dtabCbdeMWp2AVsdNLHo0W6iCnKf6AS3z2iK/g7BDB1dbVbeNYYRMZ8R7P1a8YeRUcau8Pq92KIHORwbO+5R/EZyYncnYxb+6GzNL2Q4tgL/ekJPPb8OJ8ou08e9ut/xNMzJ/ZPsN6DUsydwXvNN43cLDRFhBrJxu+zD/hGEKwTZ1prRhx5ITprwoho1FydJ5HBoyjwGIuPNpc6vu1kqHJhpcbEfTrOm13F/Kd5F2R47SL+eGFg7gkCGTuKpkR55ZEKOrg5pFJWnzGIErOI1Em3m1aC7bwW8/Wo4KUc7L0XIio/HyGRirIn5aD1oXEyAiyQ==
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM (2603:1096:301:99::6) by
 SL2P216MB3020.KORP216.PROD.OUTLOOK.COM (2603:1096:101:287::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.36; Tue, 15 Apr 2025 05:13:57 +0000
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026]) by PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 05:13:57 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "amir.gonnen@neuroblade.ai"
 <amir.gonnen@neuroblade.ai>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "aabhashswain25@gmail.com" <aabhashswain25@gmail.com>, "aniantre@gmail.com"
 <aniantre@gmail.com>, "guptapriyanshi180@gmail.com"
 <guptapriyanshi180@gmail.com>, "harshitgupta5049@gmail.com"
 <harshitgupta5049@gmail.com>
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation
Thread-Topic: Issue with stoptrigger.c Plugin in QEMU Emulation
Thread-Index: AQHbqgkoRvQTBP5kkkqjjTRUTVHxm7OeaNfegAXLzWo=
Date: Tue, 15 Apr 2025 05:13:57 +0000
Message-ID: <PS2P216MB138840D6B266C381BE2A16CECCB22@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
References: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com>
 <87a58mg9hn.fsf@draig.linaro.org>
In-Reply-To: <87a58mg9hn.fsf@draig.linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1388:EE_|SL2P216MB3020:EE_
x-ms-office365-filtering-correlation-id: 92e27c32-ef88-4927-b7b0-08dd7bdc530d
x-ms-exchange-slblob-mailprops: Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYPuYOATY30klMMYHEiuuvsbBscKTM7FdNduyneGw/Sq05kRdA/Uw1qrJxcUtiYpo4BHeYvMg8SZ1yN4cyP0/mdan/LUSOOGKzBGfuUGSbOekR+EbiVcQTodM4vSNt4bMKeH3bPEyTLHdouXeQQjkLmpZGNcFwjtmKXjF2KS8zWNkcbnf9iazd3IEPMLvakLHYlgCP5cG0+IvJSHu5mLmeG6hIKtuR1KriE/DuSwP5Gpa/kCZ145FeelclycFnrmHYlpYD/KmkyRJ2ZQfMR5ho6dx68wL/FZZVPlW+xaYsYlfLZAgnO9dE1OYwz/LjLKnTkAUsMI2BuJTVVeyZw7YNhKCaLbv5Dvt4ViulO5Rc+F5ePmaLxTDey8Y96F0mqmuNqpkPpXcU421SXSc4WKkMsWdmu+zA3jKbKYBdwBaLYxOkNMS/vJENCDaUS1nXQPOQQhPJBFKsCsxsXfDIyk46tpdSRlN+QOJLGKqPlKCTHHWOnxv8Rz5mWT+vVR49vGBDyPvR4ToIED7dhuBoV4bD7+WYjmYArd6ZRZp+9DJvj7wbrYTEA0d6EGL9ViHRwKW8abS81JS22G2NkbA+nBNhQLG2FGnpJSTBZEB0sS9yCzdgYnddCoZNpRV7uaP/h+sB11eBEScxc+ge1a3JnV5nWHLk8xnQDXBtsxWxH1QiaTJ52zC0pUjJUMR8iJc3PtraJugCJlVK/ScI=
x-microsoft-antispam: BCL:0;
 ARA:14566002|7092599003|15080799006|8062599003|9400799030|12050799009|14030799003|19110799003|461199028|8060799006|1602099012|3412199025|4302099013|10035399004|440099028|102099032|19111999003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sQXgR0Q3h1uFCPEPMAUPEhDEsGGObaPgrteWvtSKLNwg+iqQdCAdPniz/4?=
 =?iso-8859-1?Q?rKblt9BWW75tRwiv4kD629iBBRD9O9EpTVjPMgoX8Abyza0L+xroms0kQp?=
 =?iso-8859-1?Q?sP5tHIQiZkDMpodmNEGnzNDdYCw3dBJtOWScfd0XON4RW5n8EQPd6GTzsz?=
 =?iso-8859-1?Q?GrCqZiaF30phYg1tqnRVxsd/fCGfn/rEctlBOTornPvUHkGovOIrXEY7Pd?=
 =?iso-8859-1?Q?FsNieWLVKgYLj9to9FCPGPCbXAdkOjXepU8Nm0N0F2yphaPiF3+pvUwETy?=
 =?iso-8859-1?Q?E4s2Z+hTiCpxwsAb8x9XlFfbz6AV54WupuEetNab8ROGVAwY8oUmXYXKh3?=
 =?iso-8859-1?Q?U3mhnMKTMARSVnpmJuLNUTAF6tUxu5n1F0k6s0FaByemY8OyKeDF/rni9g?=
 =?iso-8859-1?Q?/zMCGmtIEpumh1b1jXrYQDgpKpWMF4SDTrLRJV8EtCLNdRG/phTIUe44Jf?=
 =?iso-8859-1?Q?eGejVLFdHt0yy83gY71bHvA236zWfYXUJwBZUu9oe62sDZfUGqv2wwRLaq?=
 =?iso-8859-1?Q?ZSRQIPyZvHs3N/AzGXOgDAHqZDLZutVl9wRWyQONoqAwJFpAa3b2ZBMU1R?=
 =?iso-8859-1?Q?BNZGmGj6K3KzNYKo7/Dan7ktM+L61ApxMqyekKLBJIgCtx1wuXu22WdIGf?=
 =?iso-8859-1?Q?fAOE1tf0C1vUbHBcEYgRjFEKkJ+DZI8ju5+99UzlvKcenpgfxY7dyjmuAn?=
 =?iso-8859-1?Q?oVgevaZwkavHhyKKGJABGxlJ6GAPB1aH4AN0v4tbOKfe1Era0U/HUOxtih?=
 =?iso-8859-1?Q?og1U0NfO4j9Rx5cllcjYK8B5nCUxTu0nFByKU+7bVBEhqGju4U+lSlRGvY?=
 =?iso-8859-1?Q?ErMQzF6GqA4mFoU+m0WKV5H/Uz1aEjtRx5iUmh11V8MgyNOxh7sgoUoOCI?=
 =?iso-8859-1?Q?R0wjtOdT+x1O5s2cFGEvIi6w7f95OxzxhAENFzDDwCgxr/1eRDcuMNRO+R?=
 =?iso-8859-1?Q?ZJ4MDR0ehIgLzNcD1fCY0tuY+aBEwk7S4nMz960HMzoDE8icki477jbY7q?=
 =?iso-8859-1?Q?8TbFpqg8iKlAGRetxRUDZFuRYu42Fcwel54KThfCZNAy+tDSAGIEZVQwJN?=
 =?iso-8859-1?Q?rlTMWKdohcIIsObNfhkrcwfW0vKViAqUkYlj6mZ/9Sw2T0vZ97fb8ewzQ9?=
 =?iso-8859-1?Q?F/EHj3IhSBhDmYljc4JBkXCHweXUZgy293h01bOeVFq+wjHVm3nUqS3n30?=
 =?iso-8859-1?Q?sRO0BEvWJf/Pjc7c6SX88RfJ9zI2XCcnpdhhqvSNSQohF6+OjtEA+ypyY4?=
 =?iso-8859-1?Q?pNccN7BsVAtQHzApdtwHAAn/9TNrO6GBZCYtVYu+TGaPNLNTFxfzEVbBq3?=
 =?iso-8859-1?Q?qFoBRGiyR1k5pSlBoX2WBnsixpUshWe96Vfo391rUgAwBhOCiKJe8ZfyMd?=
 =?iso-8859-1?Q?QX052Qa6c6kFGP7rzF9wndYsYu276BLQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KVsLtoRtFGqQcJWKTJBF+Zl5YTP6W3fWJSMXv+Ffp9Q0uT/sIBzUflZudY?=
 =?iso-8859-1?Q?txW1xXUbsm/IDZ77Q5cof7Mgv73X+9xNJpk47qldlUp9cUz+g3nb2ZUrfm?=
 =?iso-8859-1?Q?IO2A3Evni3lUzbCJWPRotq9geBC1+gKhhfds1bBHmBw6j9hnzvqGDSgw67?=
 =?iso-8859-1?Q?6auAUN/QB+QnDJ22lFyga8WAaj2xEhI6NXqyUZbSITSvI+ukyCfHEqSIKW?=
 =?iso-8859-1?Q?UaIpLhw7A26GWlTtwvfcOyZ5vdGcJv5xu3PBiK+kYRxTfHzConhDpWNIZi?=
 =?iso-8859-1?Q?b8pDmvvtcHnfojh5t+G6TM4UyrJ5qyIRIxrC7eT6gIOTfckbwvCDCjNB3m?=
 =?iso-8859-1?Q?EEMMHSrBppczlO2dilQC97j54ZzHy/AjBLaw8NomSrpSPOR3Ko84lWd7Tj?=
 =?iso-8859-1?Q?Mq4oPGkURYgslml4hFuDGSc8DGyHV/OsdUDusridIZTBvXy3nJD4SAfuF/?=
 =?iso-8859-1?Q?QZ2SIbIcCYXSZjcU7eSLxH2Y9x9BW9iBiJk0lcH/JG/G3xXS3S979T1AAK?=
 =?iso-8859-1?Q?exi9qV4MPzqTc0ZU/O5LyD/t0XJRBKmmTqSSsSsFLHAjavh3gXGz5Yu7kD?=
 =?iso-8859-1?Q?gy4+gpgULp4mGGYiUJG971mnq4uSybEXjbMMgYANMI+d3IyLl0IoGWrCbr?=
 =?iso-8859-1?Q?maqv773yHugNuRKeMtHwH6Bo3yOGJwmHRwGnPqAIvElvEQQ4s5UozkaPO5?=
 =?iso-8859-1?Q?Xe8clYRGXiBfs/OBP1AQkGD3QQm4w2ZBf/RJyjjJXxQPQoD/32e/S/zmEL?=
 =?iso-8859-1?Q?5IX1E8HCJnc5Xj2y/48WeycjZvoaB3q4jGW4rs9taLPFhEPy1qaMf9IdVg?=
 =?iso-8859-1?Q?UmEaJUp3PKigAfoogWEgzy72shtUGnAJvRyfUzhZ61aojnyUPM92s1l2yA?=
 =?iso-8859-1?Q?zCRDZqizROcyZiY5zYeY780p2yEJKarn7lzrrDsj1HcPTGrYfDh8bNawRk?=
 =?iso-8859-1?Q?DvUC/AyKJxmJmJVWHa1qrLNDfUseY4i3PFn7JKt9fs07oidWK0tmzjBhim?=
 =?iso-8859-1?Q?uhPv1UrRvYgrbaJjLQ6uJ7rBK6CZn5So97lxN/jNa51eBWXRK8arm+5P+N?=
 =?iso-8859-1?Q?mM/nfY2LdfXkuOHwALHmH88d44nydC3z9jy6SVr2TuVCm+EV+GkZnlRzDt?=
 =?iso-8859-1?Q?XTgpgxX1tyZBEOgI6yrZI/M/bo3DkTJQjO8/DZ89vrdo6PDU8o1T6gTU4X?=
 =?iso-8859-1?Q?aqUeM0iFlUoAup+zLM9Jqmh3RjX4Nzpor65XKV/3AFhjnB9+9u3qQ9IO+s?=
 =?iso-8859-1?Q?q4uVsJQAABOZDhDqjoFKmA2PERaSNOCmYR2FNBu47sqFhx3kWqyhmKk5uv?=
 =?iso-8859-1?Q?DM8l1GnrQTFMV5qK/xu2XTY2mw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PS2P216MB138840D6B266C381BE2A16CECCB22PS2P216MB1388KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e27c32-ef88-4927-b7b0-08dd7bdc530d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 05:13:57.2325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB3020
Received-SPF: pass client-ip=52.103.74.38;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SLXP216CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_PS2P216MB138840D6B266C381BE2A16CECCB22PS2P216MB1388KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

The below command line argument works perfectly.

./build/qemu-system-x86_64 -m 2048M  -boot c -nographic -serial mon:stdio -=
nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda debian11.qcow2 -ico=
unt shift=3D0 -plugin ./build/contrib/plugins/libstoptrigger.so,icount=3D90=
00000000 -d plugin -qmp tcp:localhost:4444,server,wait=3Doff

If the QEMU command contains the -smp argument that is when the code crashe=
s. Would you let me know why the same happens and if there are any fixes to=
wards this problem?

Regards
Saanjh Sengupta


Sent from Outlook for Android<https://aka.ms/AAb9ysg>

________________________________
From: Alex Benn=E9e <alex.bennee@linaro.org>
Sent: Friday, April 11, 2025 6:07:16 pm
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: pierrick.bouvier@linaro.org <pierrick.bouvier@linaro.org>; philmd@linar=
o.org <philmd@linaro.org>; pbonzini@redhat.com <pbonzini@redhat.com>; marca=
ndre.lureau@redhat.com <marcandre.lureau@redhat.com>; amir.gonnen@neuroblad=
e.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongnu.org <qemu-devel@nongnu.=
org>; aabhashswain25@gmail.com <aabhashswain25@gmail.com>; aniantre@gmail.c=
om <aniantre@gmail.com>; guptapriyanshi180@gmail.com <guptapriyanshi180@gma=
il.com>; harshitgupta5049@gmail.com <harshitgupta5049@gmail.com>
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation

Saanjh Sengupta <saanjhsengupta@outlook.com> writes:

> Hi,
>
> I am writing to seek assistance with an issue I am experiencing while usi=
ng the stoptrigger.c plugin in QEMU emulation. I am
> currently utilising the latest QEMU version, 9.2.92, and attempting to em=
ulate the Debian 11 as the operating system.
>
> The command I am using to emulate QEMU is as follows:
> ./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -serial mon=
:stdio -nic
> tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda debian11.qcow2 -icoun=
t shift=3D0 -plugin .
> /build/contrib/plugins/libstoptrigger.so,icount=3D9000000000 -d plugin -q=
mp tcp:localhost:4444,server,wait=3Doff
>
> However, when I attempt to use the -icount shift=3D0 option, the plugin f=
ails with the error "Basic icount read". I have
> attached a screenshot of the error for your reference.

icount and libstoptrigger are independent of each other. You do not need
to enable icount to use libstoptrigger.

>
> error.png
>
>
> When I remove the -plugin argument from the command the OS boots up perfe=
ctly, as expected. Command utilised in that
> context was somewhat like ./build/qemu-system-x86_64 -m 2048M -smp 2 -boo=
t c -nographic -serial mon:stdio -nic
> tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda debian11.qcow2 -icoun=
t shift=3D0 -qmp
> tcp:localhost:4444,server,wait=3Doff
>
> I would greatly appreciate it if you could provide guidance on resolving =
this issue. Specifically, I would like to know the cause
> of the error and any potential solutions or workarounds that could be imp=
lemented to successfully use the stoptrigger.c
> plugin with the -icount shift=3D0 option.

It's likely the instrumentation libstoptrigger does has changed the size
of some of the translation blocks leading to the error being triggered.
To know exactly what is going wrong we would need to see a backtrace of
the failure. The case:

        if (!cpu->neg.can_do_io) {
            error_report("Bad icount read");
            exit(1);
        }

is basically saying you are trying to read icount at a point its not a
known precise value. Any attempt to do a device access should trigger a
TB recompile so the device access is on the last translated instruction
of the block. However if a TCG helper queries time and its not the last
instruction in a block that would trigger it.


>
> Regards
>
> Saanjh Sengupta

--
Alex Benn=E9e
Virtualisation Tech Lead @ Linaro


--_000_PS2P216MB138840D6B266C381BE2A16CECCB22PS2P216MB1388KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto">Hi Alex,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The below command line argument works perfectly.&nbsp;</d=
iv>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);">./build/qemu-system-x86_6=
4 -m 2048M&nbsp; -boot c -nographic -serial mon:stdio -nic tap,ifname=3Dtap=
0,script=3Dno,downscript=3Dno&nbsp; -hda debian11.qcow2
 -icount shift=3D0 -plugin ./build/contrib/plugins/libstoptrigger.so,icount=
=3D9000000000 -d plugin -qmp tcp:localhost:4444,server,wait=3Doff</span></d=
iv>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);">If the QEMU command conta=
ins the -smp argument that is when the code crashes. Would you let me know =
why the same happens and if there are
 any fixes towards this problem?&nbsp;</span></div>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);">Regards</span></div>
<div dir=3D"auto" style=3D"font-size: 14.6667px; color: rgb(0, 0, 0);"><spa=
n style=3D"background-color: rgb(255, 255, 255);">Saanjh Sengupta&nbsp;</sp=
an></div>
<div dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Sent from <a href=3D"h=
ttps://aka.ms/AAb9ysg">
Outlook for Android</a></div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b>&nbsp;Alex Benn=E9e &lt;alex.bennee@linaro.org&gt;<br>
<b>Sent:</b>&nbsp;Friday, April 11, 2025 6:07:16 pm<br>
<b>To:</b>&nbsp;Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;<br>
<b>Cc:</b>&nbsp;pierrick.bouvier@linaro.org &lt;pierrick.bouvier@linaro.org=
&gt;; philmd@linaro.org &lt;philmd@linaro.org&gt;; pbonzini@redhat.com &lt;=
pbonzini@redhat.com&gt;; marcandre.lureau@redhat.com &lt;marcandre.lureau@r=
edhat.com&gt;; amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;;
 qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; aabhashswain25@gmail.=
com &lt;aabhashswain25@gmail.com&gt;; aniantre@gmail.com &lt;aniantre@gmail=
.com&gt;; guptapriyanshi180@gmail.com &lt;guptapriyanshi180@gmail.com&gt;; =
harshitgupta5049@gmail.com &lt;harshitgupta5049@gmail.com&gt;<br>
<b>Subject:</b>&nbsp;Re: Issue with stoptrigger.c Plugin in QEMU Emulation<=
br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">Saanjh Sen=
gupta &lt;saanjhsengupta@outlook.com&gt; writes:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am writing to seek assistance with an issue I am experiencing while =
using the stoptrigger.c plugin in QEMU emulation. I am<br>
&gt; currently utilising the latest QEMU version, 9.2.92, and attempting to=
 emulate the Debian 11 as the operating system.<br>
&gt;<br>
&gt; The command I am using to emulate QEMU is as follows:<br>
&gt; ./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -serial =
mon:stdio -nic<br>
&gt; tap,ifname=3Dtap0,script=3Dno,downscript=3Dno&nbsp; -hda debian11.qcow=
2 -icount shift=3D0 -plugin .<br>
&gt; /build/contrib/plugins/libstoptrigger.so,icount=3D9000000000 -d plugin=
 -qmp tcp:localhost:4444,server,wait=3Doff<br>
&gt;<br>
&gt; However, when I attempt to use the -icount shift=3D0 option, the plugi=
n fails with the error &quot;Basic icount read&quot;. I have<br>
&gt; attached a screenshot of the error for your reference.<br>
<br>
icount and libstoptrigger are independent of each other. You do not need<br=
>
to enable icount to use libstoptrigger.<br>
<br>
&gt;<br>
&gt; error.png<br>
&gt;&nbsp;<br>
&gt;<br>
&gt; When I remove the -plugin argument from the command the OS boots up pe=
rfectly, as expected. Command utilised in that<br>
&gt; context was somewhat like ./build/qemu-system-x86_64 -m 2048M -smp 2 -=
boot c -nographic -serial mon:stdio -nic<br>
&gt; tap,ifname=3Dtap0,script=3Dno,downscript=3Dno&nbsp; -hda debian11.qcow=
2 -icount shift=3D0 -qmp<br>
&gt; tcp:localhost:4444,server,wait=3Doff<br>
&gt;<br>
&gt; I would greatly appreciate it if you could provide guidance on resolvi=
ng this issue. Specifically, I would like to know the cause<br>
&gt; of the error and any potential solutions or workarounds that could be =
implemented to successfully use the stoptrigger.c<br>
&gt; plugin with the -icount shift=3D0 option.<br>
<br>
It's likely the instrumentation libstoptrigger does has changed the size<br=
>
of some of the translation blocks leading to the error being triggered.<br>
To know exactly what is going wrong we would need to see a backtrace of<br>
the failure. The case:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cpu-&gt;neg.can_do_io) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_re=
port(&quot;Bad icount read&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
is basically saying you are trying to read icount at a point its not a<br>
known precise value. Any attempt to do a device access should trigger a<br>
TB recompile so the device access is on the last translated instruction<br>
of the block. However if a TCG helper queries time and its not the last<br>
instruction in a block that would trigger it.<br>
<br>
<br>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Saanjh Sengupta<br>
<br>
--<br>
Alex Benn=E9e<br>
Virtualisation Tech Lead @ Linaro<br>
</div>
<br>
</div>
</body>
</html>

--_000_PS2P216MB138840D6B266C381BE2A16CECCB22PS2P216MB1388KORP_--

