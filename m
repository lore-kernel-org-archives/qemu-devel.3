Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081E4F8E49B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 01:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDXog-0005cn-Pq; Thu, 16 Apr 2026 21:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDXoe-0005cC-S2; Thu, 16 Apr 2026 21:16:16 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDXob-00053T-N2; Thu, 16 Apr 2026 21:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou94RaDpTzh7R+br4GeCYJuq6ghCJWacGdkHZd1Qw08a00BNGlKsENHNzsqL5SYPMM28iGNzbT2QFUSoYiNEd6XNWbJL+16Rsk21KJr34dmFukTdQ7QuaagQmKBBKylRGuiXvV5EHi44TwmJPE2wAfIFnvOm9gmE7DouxW9tYutO2x0sIxP9+pmVnZq0AE+iESazC8LQhEdu4Ev9HaWkkOmK02j3MKN5YQYZR9qzd4IpfP1whUWybSBkghqfLU8JoVwPbeAgu8aGaLhiRSQXCmwEdG6v5tPpnurxXYKAQtMYLb5NWU5S6Hu1s8WlDwng8FJFFELqF+e66dm4xEWNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKvmDcLafk3RPtCFjX+esrM/9ByXS03vIblNKwniRu8=;
 b=WfHCuOlGIAN9zvoin7eTN0WdMFmPG75cYXbdaukY57ucxgSdJcaaIfuPPYkyx/9fYUDk2TxR0M2MvRUCxcD0ylotOEqnjbu5EmsJOXCdMuDc+E1EuBGOTGL6kardkpwZMQ/rx4XlaB3NtULk5+Qlmr/rHxONrK5t9P70HCGSP/sZO/uEC0UN7G9WZbJplXkC8I8iQLU+0OHyx0ClX5spGmcJM/JEInGGwATImrnPzJvsqFnuCsCnSkuXygZXZ+1Z5NoJtF6k0iY6QZO1mFZ2e2+OtH8cnWj8eR4j2ucf6II+eLkPLz+BXE/eEnqbrOzNlaezRnTfgJwvChrLUTlhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKvmDcLafk3RPtCFjX+esrM/9ByXS03vIblNKwniRu8=;
 b=HFMNNxCywKFggi67keZwQ5VfOGyyIu7AgjgDBOj9QD2OrpvcVjDvLHF7JTK5tsboEEr0EK/PK44G9N3I+HJeMLHams0LGemuu1wqmIDfGL84DiYd42ZjHGT0K51M6HZprrOr5lrjD3g8rMxWfzbMJqy2mdziR8bmj333TQhVwxBcUEzOvemQHqr+utWJ20zVYw1gBKS5x1Upy8+32n546Iim0+LCrGdOI2fkhmNaVabDTaZw8yrfYvhPgrLTE6e/PLAi9ywP6ZXsRVz7lfLa+LNJV/dHL644a5af38LJ8jk+g0mrc7Bu3wDSyGFUuxoUYsBcYVEQTgg7loQNKUGVfg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYUPR06MB5927.apcprd06.prod.outlook.com (2603:1096:400:350::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 01:16:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 01:16:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Topic: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHczUNFhK5MCMsaPESXZcYoH3r+fLXhmSoAgADa5RA=
Date: Fri, 17 Apr 2026 01:16:05 +0000
Message-ID: <TYPPR06MB820623725F12A9326E19B44FFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-2-jamin_lin@aspeedtech.com>
 <d7e9d943-fd8d-dd48-5a86-e54613c466dd@eik.bme.hu>
In-Reply-To: <d7e9d943-fd8d-dd48-5a86-e54613c466dd@eik.bme.hu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYUPR06MB5927:EE_
x-ms-office365-filtering-correlation-id: 2edae423-abd4-4bb2-8e8a-08de9c1ee5db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: qh2B4G5FOskhDS/cQ5QBZkzPM06GktQ1jAhpsaKFdhro9b9w9ZP2kNLod8ALb6P17HMIcfHcYotEtd0Zmn3O73Yu/3xlkQbSmUeOndhkXVPoIKklOSlHTXcasINJv2YAQUoP1bzDIwYIBX6HFMUvl8G7dVQUiCT9kDYImbHZ3HXxt0lohWJZtlNALWSlzKmUqQjsf6ix+LDAOJ8jGuF6GL5oN9eVaGcA0BgCH6GwoeWQX0RxVzxQW6GFv6sWTa90EITY/etCEvEv8zLa6ZEG7bbEibGcpqBGoH2NF4OWbbD3cDSm6bVZu5MftK9Ei1cqc8L9SZx0DNcC5/54D/Cmy31jeYbqmxDgTZMnJucdiTMaNrXY7xyqyqCLhjXfnM6lPnasFTFj/0ua8FaIiTbgj70jPzJRtkxblrvSmYiPtLtXUnltJNcjQuFmhYWZE9zXoLouyxZo2pjE+O3HNEg6N2ovG6fZvwn/HIaOUHthuG2M5hkU+wc/pNaHehxf6srN2bVyXY+XOnTG03f18/WkWqTFMo7IkzBG4YrkTTMMxZ44bUHUeFFO8K+sL34IlvUMq/wuMYs1sv3EX3zcQwNktqH2c/nTEN7YLXxWI+bIFWtV4ZRbtaxfd2x3e/6Bs9U9LKKstX2csk7YX1+LeFESIG0F2kqa0z0V45rfq57QHyJYuTYL0RE2aplPvFjQzMzfx10gRYhH0spsxuCIe1MwJsMal5mxBbzYlnoYOICGoIxs6JU2hCqx/3fEf/czcICPSvm5YOpQnrxZzelDhk6L+Fu9zEMmTaJeKXe9vKxgjGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HFMXT3M3YTE1ui99TGpfeno174zf5hu8wW2ZZ9EnhJ7uww0mLGYVtDOMWz?=
 =?iso-8859-1?Q?EizKn/4o+6QIy660lw1asNL+vKVnLlnFxLonoTk2bsUL2zE5AJP0LtWKuD?=
 =?iso-8859-1?Q?Q42t2H2vGHHQltlRO1yflw2aVVbZ9VDCjqrNK3Ud3k3DafxtyTtC9rexdI?=
 =?iso-8859-1?Q?SIq4DkT13XWDsVBiBupluUDGDEUcxTJxe5pN4PqeBajFdP9smZ/dvGyvDz?=
 =?iso-8859-1?Q?7o1n9KJdG/4njJBYntK6NdKpJDCLifQ9+I0AjWbpqDqjqT2EmLZETcX/Ke?=
 =?iso-8859-1?Q?tTBFzu73GLPUB+2raBjFX/ALQigSgMihCJP2e6GG6GL6aIoP7phoOylFTh?=
 =?iso-8859-1?Q?6kG4cOIJv3nrtidPztLcxLVvTHT8mELbEdLZcvNNQ7aPgq0VTy9LGAyLFZ?=
 =?iso-8859-1?Q?Y2S2tNwskdX2mXRvtFzWzVArkSgV+WMMiNSfgtDMRym7aBvp60ofXhCywW?=
 =?iso-8859-1?Q?Lcmo1X9voERfC0DC1iouZ2b6T/VdPLZl70Oa+AJebLTekUrPFhRKEHhgt+?=
 =?iso-8859-1?Q?LDQHqdT3j7FvBkgQTKfCBAA8NwR/UHE34p8UKGVU0cGmUgmMqRkaPx/3up?=
 =?iso-8859-1?Q?2dGe0DgiRcrpL0EhDzaYAPK8vRhYLIXk8Mv4ev6flEuprvMmOmttm/NHSg?=
 =?iso-8859-1?Q?x3p8ae0tMDEBX5eXEoidrSKrxKDK/VzyogF59y8ivYJkrR/8DlrwwEkZUj?=
 =?iso-8859-1?Q?4i9UTaYFi3bq8Cy1I+f/N/J7Wqg2qR8mBAk1PlnrHFlURbwFDYg1KpplmI?=
 =?iso-8859-1?Q?WLrPYKfslf1uKff909H1tb22lokeg6lWdd7ONkkpk+N+9GykookBJRd78s?=
 =?iso-8859-1?Q?zHawQwlJ5p3/nBGTPLEIRcDsTh5MCLIS8/gArH9YaImOqzQc+P1GupNeke?=
 =?iso-8859-1?Q?ARmcrcUl9TIpDSJJXfTIDvN1aVXBcc0OWmyemLT9b8chjtOEQnV9c1qdPX?=
 =?iso-8859-1?Q?565cQkijwlY30LS03obVxASq/Z+gi4F3IwRWCp6Eq0G9YyUTcaGVMdzQCa?=
 =?iso-8859-1?Q?4HlM0NVFxpFgqDroINsDe7UYkrpUD0sr+mJ+ljFJ+8MauOkNmUudukuxGo?=
 =?iso-8859-1?Q?FJ7BuakswQa2lopNG+q5cjhDgw3oyh2H4fuyLwGAuCPuIHdjndx559NPJs?=
 =?iso-8859-1?Q?Z4AXJYILSjz/mOzrMfH/Sd51A/IvCi+IlzfM1pimSk6+19eXFGtnW9BHz1?=
 =?iso-8859-1?Q?n2DPGncIqmf27Eqn3IKMBWuYMRv21Zex/LvwpTAIBQGEipXvU0mMp4hrTt?=
 =?iso-8859-1?Q?dFrEVtV3oa6I5ipRbFPKdk08aLObpBpj/Qt5tJ9oKtu4P0F3a46hhBo5yO?=
 =?iso-8859-1?Q?B9caSJaDTlBNKBCAmN0I/9ytoCkmHpb7JtLlcx0j2DDH6DOXkSvNAOTQ1d?=
 =?iso-8859-1?Q?44AbsdixBj9zeB/xPxe5hj/k5nfuhM+qfosJm2MuE9DXM9a3pJiPfTE2GB?=
 =?iso-8859-1?Q?ahlyyPdfMQ4mel/yIiLlnI3UNN7849c+e1UQ2RXO2o+9W6mFjYMKjF3eNr?=
 =?iso-8859-1?Q?fLOY90sZ2KvJXdQ/vzj6+fQNERdlEIrDLKjoPIcnxQyPDEaZhtmi46MgjH?=
 =?iso-8859-1?Q?V3P5nsIefZRZMzHunvXVVqC4H+UAEPkDhoX+9thcvMPna4dSBB070lw+Mg?=
 =?iso-8859-1?Q?cGFhMXnR2G+UEGWvm+QvGWo01F138MNrb29hLuQLyEa2jL+4w3+vE7yeNo?=
 =?iso-8859-1?Q?E1YzplgeO948SIUcdVzn6lgZ9KCek1anjf/3UrtKsvtrK3VZ+OyrTekVIS?=
 =?iso-8859-1?Q?daPCP5xEb8UfjP7RgxrFg0TfJ5N6hUIdb8EymEundWHITCjKkpPfvIph3h?=
 =?iso-8859-1?Q?ebgSK7PERA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ITxCW/8rjMuScqufhpuT4YwNQGcfCdEfW4KDIrHWvRuso2jSlfyrcRDIIYyQbXF9zXX3D126WBfaVrbmwwj9/D4c4RVC6FdWjCP8RtoGvL7tOejNjYZFaH5aUIZGHLSx6yBhmRxxl0hYNwDPLOf2kSa/haStmoIa52HTEA5+IQlFo/49HK3dDBq4B74UO7EeracLuCz55Q6UFidxMBQphie0lQFhhJb2IKLtqeDZahGXw2udDkkBUWr+k0KYGMvB1rEjKtdvQ/fth+G8T/22fab0mHdyascdJyLJWTVKEKi6+jERXV0wm9xCzgZNT8/eSEP+itL/mTYl/Qk5hmnbnw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edae423-abd4-4bb2-8e8a-08de9c1ee5db
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 01:16:05.2039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GnpYTeindyDANcPhxcwhhI9U2QD3Z9Xc+iXCNloJA1nWuyRnPkfiV7PuIx5jn4S5EVo/ylbO0V3xckuwenVRSq0QBrln0gSHD3nrMVBlyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5927
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Hi all,=20

> Subject: Re: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
> structure and dead code
>=20
> On Thu, 16 Apr 2026, Jamin Lin wrote:
> > The EHCIfstn structure, defined according to EHCI spec section 3.7, is
> > currently unused in the EHCI implementation. Remove it to reduce
> > unused code and improve maintainability.
> >
> > Additionally, drop a block of disabled (#if 0) code in
> > ehci_state_advqueue() that was never implemented. This code path is
> > incomplete and has no functional impact.
> >
> > No functional change.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> > hw/usb/hcd-ehci.h |  7 -------
> > hw/usb/hcd-ehci.c | 11 -----------
> > 2 files changed, 18 deletions(-)
> >
> > diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h index
> > 0ae8c06331..3aec0e047c 100644
> > --- a/hw/usb/hcd-ehci.h
> > +++ b/hw/usb/hcd-ehci.h
> > @@ -202,13 +202,6 @@ typedef struct EHCIqh {
> > #define BUFPTR_SBYTES_SH              5
> > } EHCIqh;
> >
> > -/*  EHCI spec version 1.0 Section 3.7
> > - */
> > -typedef struct EHCIfstn {
> > -    uint32_t next;                    /* Standard next link pointer */
> > -    uint32_t backptr;                 /* Standard next link pointer */
> > -} EHCIfstn;
> > -
> > enum async_state {
> >     EHCI_ASYNC_NONE =3D 0,
> >     EHCI_ASYNC_INITIALIZED,
> > diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c index
> > 57f930b099..5ea8461f70 100644
> > --- a/hw/usb/hcd-ehci.c
> > +++ b/hw/usb/hcd-ehci.c
> > @@ -1756,17 +1756,6 @@ static int ehci_state_fetchsitd(EHCIState
> > *ehci, int async)
> > /* Section 4.10.2 - paragraph 3 */
> > static int ehci_state_advqueue(EHCIQueue *q) { -#if 0
> > -    /* TO-DO: 4.10.2 - paragraph 2
> > -     * if I-bit is set to 1 and QH is not active
> > -     * go to horizontal QH
> > -     */
>=20
> Is it worth to keep the comment in case it's still valid to remind we hav=
e
> something missing here?
>=20
> Regards,
> BALATON Zoltan
>=20

If we decide to keep these comments as reminders for unimplemented parts,
please let me know. I will resend the patch series and drop this patch.

Thanks,
Jamin

> > -    if (I-bit set) {
> > -        ehci_set_state(ehci, async, EST_HORIZONTALQH);
> > -        goto out;
> > -    }
> > -#endif
> > -
> >     /*
> >      * want data and alt-next qTD is valid
> >      */
> > --
> > 2.43.0
> >

