Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0453C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 12:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trz20-00008k-Ji; Tue, 11 Mar 2025 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trz1t-0008SF-QI
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:48:21 -0400
Received: from mail-koreacentralazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::2] helo=SEVP216CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trz1n-00068Y-CE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWbHok6yPcZw3mMHCEHdaeALypKKcUnp0S7vhXj5pTDjPL489Ho3KU8hLovvS3a3rhZSCp6XjOOArQlwUwsVhqGV0PRCXYRg1yrpsCNrgbkLMmWKd6GEQ/jopyetDpirBBuJkJqnmcC58P+v0AknaORZGsKSMdnA/B+NpgEz5455sBKcAwNkxJWlF2juQ5K1eAFVPPE3ESS1OrriOMJF5nVopoz0SCeriX+DBXjkhfQuwmmf/7uTgcAq2aZxqxN6CM9or4vOpeDmo7cHkOXpXUCL/R/84SLpeQOcV5Fqj1ZuXpCvU+eyi7u1eryJVUzLCvQ0+vKQQOOHuLcrjIX+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQD6W+FPtuQ37Jo4C1euKNvRj8pBCuCEWAOqyxsZrKY=;
 b=hthCPpE13Ey+HMm3vgQjIBvHZu+KAReU+lCxN2dhU4CHJhFTEB4N4cddlzEtL5SoOhDlePZ6U6e0LqX/anQdlQJUOWtpj3iezyi/62R/CXQ9UEHRIFYMGG7+mYvJpU0K7s6BvmpbA1s//mkduIEka1l9DvXFQta+8KUdjgG5nTVSENjVn9vd9FQSbSUqDwEiGbpoyGkxmnd8ZYl/PI22lLqsI+3QRzwO4gZPrNzpDJ1L8LOkDIUI9hdCHkHHj9c3R1doHeyrKdRoOzQk69NL+/n+GrJ71Gy7X1gUVDWwioqMl5bsVF8sWqfRFAKneW4sIsaKxfRUfeiU+bZWKO3Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQD6W+FPtuQ37Jo4C1euKNvRj8pBCuCEWAOqyxsZrKY=;
 b=lZZf14blGXZOUh0h96cEns4nxKOFAys+/ebKTi7taiPSiwRvv10UjVESi9vyzDFP+8Q42I+xqUCLIYzP9VQK76RXjS9gSjPrIY4UNdfLHyo273NgPgttvTkyZt1ZmBGN28EzL5Dl2XGo1sAPvhVR7D/F0k5SKORFyHOugb4uxgr4QtlsAX05S6ftgIeY5zugS8q31UBpDkl5NkxdmPGcEVffMKt/hRTwfr5D2qNRQG5QIpYwvlIb1iLpi+AFnFE2+pOBfqzeZ/dpe7g2oVIU6CSkR7bWGjk1DEzAizzosvtrzkYnijXby4TJCWh9h+ojN6n8d216+I2b4KvcSpCayQ==
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::12) by
 SE1P216MB1928.KORP216.PROD.OUTLOOK.COM (2603:1096:101:63::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 12:48:01 +0000
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98]) by SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 12:48:01 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>
CC: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library
Thread-Topic: Building QEMU as a Shared Library
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEYABLfwAgAn+2teAAEg+6w==
Date: Tue, 11 Mar 2025 12:48:01 +0000
Message-ID: <SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
 <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1380:EE_|SE1P216MB1928:EE_
x-ms-office365-filtering-correlation-id: da0fdf50-862b-4478-91a1-08dd609af595
x-microsoft-antispam: BCL:0;
 ARA:14566002|1680799057|9400799030|19110799003|14030799003|9000799050|12050799009|461199028|7092599003|8062599003|15080799006|6092099012|8060799006|3412199025|4302099013|440099028|20055399003|102099032|1602099012;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qFgkj45xOFCmKtVIbGKtLFmSgVWqRmkwBfsgmXE8DR4Ve2ThcnBTLPfiUm?=
 =?iso-8859-1?Q?eITdSUTaMuimYoSxpm0FtF2Kn44ONfQJ8jMuOlBGcIbqFXr4MCThXGd4bj?=
 =?iso-8859-1?Q?KJqwaRu8c8s+f7cMg+OiQBv8zM4mY+I6g8YDIWMN8BGtsE1XqbhlrR7QZo?=
 =?iso-8859-1?Q?40FIynBX496Dzd24WfaHPySqfESVQYZ6OMs2q8apvvZ7i94gVvpLtOBhsb?=
 =?iso-8859-1?Q?s5grQNQfJtXvRjtH0YkLYZ1XbJDuQqO/ay1bQZcvtbBu3Ou/gn4+8KS8AF?=
 =?iso-8859-1?Q?BPgSlGbhL6YDQZ/nLK9le6Slxsb3/JVlnM7VSMkNEVSYoL2bLGbwrzpp1o?=
 =?iso-8859-1?Q?LT4xdKSnoem3u7gTMpt1V8WWWzqfyE89fMoaYk4GgOiZMsNHaDS7URY/Gq?=
 =?iso-8859-1?Q?XlZaejK2PDQxFMKt1CuZgRwFt2Mo7ZJ+6gMm/Z4OT58B8mb4AtEDTiFFmT?=
 =?iso-8859-1?Q?xBC/4r9dGNXJLCwz9AvToXKHi6RpQZ8ufVl+XnMcrdGX4oWx/iD/hdh1ie?=
 =?iso-8859-1?Q?0PB7fY5o0ue3BrpsgQ80gwBLLDVxFzmXcrAye++qhmnDEVGX2HHVjOwg/O?=
 =?iso-8859-1?Q?i1JllDwc+pOBwiApsojklKSkHf3g2A4CkIpowfX1BM+pEU1etcOUIO6aK/?=
 =?iso-8859-1?Q?qSzkByCkV4Gab4MHqk2++hikXdSYO3YVETMskacDK9EWlRV8lgaYg2pydw?=
 =?iso-8859-1?Q?wSX+A83zhAPPNrg9y46Ch/8AlbAsG59kVVQ/L5LBu+W+jzSHELgRMexZfn?=
 =?iso-8859-1?Q?2CKN5CEWDPtoCF6Ak8akj/sZihQYdEdytIOhNGaATXsR3QVzb3bsS4/9hM?=
 =?iso-8859-1?Q?ktoBqQ0XIHZqVb0oj3q/TWaVETSQdLbXl++D23uNCkU195Lu2vUHH8cvl6?=
 =?iso-8859-1?Q?Qe4nAePpRkBom5RGFcs3hiuWwMNewv+iPygBb1mT0q/s3wrUWPV3zg2LcM?=
 =?iso-8859-1?Q?7dxiKEh9WKKuVdlIa+3F40WgO72flBZPE6huXFUBqv+eEhQFDMxuDLa/nV?=
 =?iso-8859-1?Q?1+xK8HmNEqNMkhUJkm0/i1ZyZDHgkBBCyNHAaoOa28ocWRnI98bJOWtbn2?=
 =?iso-8859-1?Q?xNxvr6kq6SG9My76pM1gZ59VFrxOQ4lVO+4NYVD9Wtez2/f4/Bg3+r+AqT?=
 =?iso-8859-1?Q?00mGBkpd40PXHKxskbhBu960NQSMger/Qllzy3Zl8J+7KyrAQyxaLcoIfh?=
 =?iso-8859-1?Q?LjgCy3qwvu0MakPJMimE7xqtfKXb/+OIqgYZvNCbxyeOIh44YYSo9BON1C?=
 =?iso-8859-1?Q?IpbnEa46fAaf3lVqdtE8UiDn9ZVIVL6XpZ5W2sEA8XurVPC6/tQ0plU4c9?=
 =?iso-8859-1?Q?UlB9EfDyrA3MAdaHIQ/gHP89z5ltDidW843w4cBrINTrQ3GcSatdJh7fXU?=
 =?iso-8859-1?Q?+7b7h8oyrWlLpsv4TJwR/Vxzh1vy5IqS9feMMfkmv7afdmmubBwL1GXlml?=
 =?iso-8859-1?Q?IyTq4HfcOTI2XTrj?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iaa9XIiXu3xwoiIrmk9qIdt1X5ueIraYnhFHmBY40lIieaVaGDpqI+u8I3?=
 =?iso-8859-1?Q?wRNAWT6R0mCXxS0g1ODS70J8TJuHFp5CHSGuiFgVYwdaUT/pzTV6k/mgwV?=
 =?iso-8859-1?Q?SXEo9bbEzN7bbk3oAPJTNQpm6Jq2jsnzH2NkPPtG4GoLLVjuR67e6Kk88t?=
 =?iso-8859-1?Q?+Xqw8rwU2V4saEPitCoFkDeHfxRo4fJA5iryIhm49YRxYEcxIDOw4Oa3ue?=
 =?iso-8859-1?Q?92Mxd//SaobnLz5NyGTK9RwcCIOwmV+z7d9lpRqIL/lx+K09r1qFqIkyek?=
 =?iso-8859-1?Q?KWBtnsP7sTuggqSJhSbdgq/1t43vAT3uJMtMsrV6jXWpUmEF2jwzXjjxlL?=
 =?iso-8859-1?Q?QffGaMPcx7ARxXAUEWx12wDVs8GkURmwagfAjgQ2AV/q+WNAKaijCiwIl4?=
 =?iso-8859-1?Q?Ror1AyqS7NrQO2aXcXi3bfSGov+fk7Mvx1i37ClROv3XXT9xQ4QLPOTso6?=
 =?iso-8859-1?Q?fEV7SDRCx//rWo21qRo0WO9Z1PcbcXOhXFSAkZ4Vy/xBDVX3u6qFqrI5UN?=
 =?iso-8859-1?Q?HN+hyRvS9hPT+WFf5Q9OWIpuOn/242zhSAwngGv1eHpHwD6/L0aptKpPaU?=
 =?iso-8859-1?Q?1d5OU6A1IHjdEY+LG8LGbjGOy1CIN55LNYTR0EV8HyKPRHjnzRRR76HSff?=
 =?iso-8859-1?Q?HIrJrxwSJT9re+igZnpZGDTYKSrDN+UgnqUIQG0UZAR9fgusvr3I0dN5OG?=
 =?iso-8859-1?Q?IaaH+ScsU/UoTFZugPFRj+DYoyyd3fQeN7rCStp8DK4qkJILAKYHro5BgH?=
 =?iso-8859-1?Q?LHM+8OkFnWrrWHJBic1SFAf08xPk6Q2/FR6iDqNwR6k2d9FoApVUSKt3RD?=
 =?iso-8859-1?Q?7EAn4qmLcK+0QuqvdAR3Bd8f+Wj9CzjNqaosnxVngAY86cgUA+nW9vqEMc?=
 =?iso-8859-1?Q?ILF3qihsWKZZ38pDFUYb5NMj65y9FDKTDJcCGrSFtHuw0XDgAFTnEF1UUM?=
 =?iso-8859-1?Q?Cq+IVU8SvHD3SW96PZ0C2HwL4HaFJXXQCgWw42yzsyUumZENukejQsAxoQ?=
 =?iso-8859-1?Q?wllQtgUIM4SI+nDZGrLxdvYpQdYGHtw5qhQ2jeR2bum61H1BfeVfekt1zW?=
 =?iso-8859-1?Q?P4JMdOd4+KFfRWktoXBBZwXbCgKnfJtX3jFFh/umu3mhyLPS8p/qfHqbMH?=
 =?iso-8859-1?Q?kHZlVWUiKsb1LV3aD+Lvpc5M40I99JyezHC2FD4WxRDmU6wL2oRpTyAjo/?=
 =?iso-8859-1?Q?zqurpnDXBAZpUu4immREbKcpbj7QOvE1Mwsm/Lqi8FkYw6jCgXLCeuGqb1?=
 =?iso-8859-1?Q?QYmgjxsnbNzw5+U1KrZ1tocBWxY9glVGk+wvSycV4h5cne0wdue4BxZMOq?=
 =?iso-8859-1?Q?Y9CsEODg8GvC4MlHK+8IAqoA1w=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_004_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fdf50-862b-4478-91a1-08dd609af595
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 12:48:01.7885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1928
Received-SPF: pass client-ip=2a01:111:f403:d40f::2;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SEVP216CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
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

--_004_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_
Content-Type: multipart/alternative;
	boundary="_000_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_"

--_000_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi,

You can find the image attached.

Regards
Saanjh Sengupta
________________________________
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
Sent: Tuesday, March 11, 2025 3:20:48 PM
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>; Philippe Mathieu-Daud=
=E9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 =
Lureau <marcandre.lureau@redhat.com>
Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongn=
u.org <qemu-devel@nongnu.org>; Alex Benn=E9e <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library

Hi,

I have a couple of questions:

  1.
When I use the libstoptrigger.so: in that case the QEMU 's emulation stops =
after executing the defined number of instructions. Post this, the whole QE=
MU terminates. And while using the libips.so I am assuming that the QEMU do=
esn't execute no more than the defined instructions. Please correct me if I=
 am wrong.
  2.
In my case, I want the QEMU to start emulation for some time and PAUSE it's=
 emulation for some time; after it is Paused (it's virtual time is also to =
be paused) and then let's say for after 'x' time period it should resume it=
's virtual time.

[image]

I have added this segment inside the update_system_time function inside the=
 ipsPlugin.c. but once the instructions reach to the defined limit the virt=
ual time does not seem to stop.
Do you have any suggestions on that front?


Regards
Saanjh Sengupta
________________________________
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Sent: Wednesday, March 5, 2025 5:20:38 AM
To: Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-Daud=E9 =
<philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lure=
au <marcandre.lureau@redhat.com>
Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongn=
u.org <qemu-devel@nongnu.org>; Alex Benn=E9e <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library

Hi Saanjh,

depending what you are trying to achieve exactly, plugins can provide a
solution. It's convenient and you can stay on top of QEMU upstream,
without having to create a downstream fork.

We already have plugins for stopping after a given number of
instructions, or slow down execution of a VM:

# stop after executing 1'000'000 instructions:
$ ./build/qemu-system-x86_64 -plugin
./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin

# execute no more than 1'000'000 instructions per second:
$ ./build/qemu-system-x86_64 -plugin
./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin

You can see source code associated (./contrib/plugins/stoptrigger.c and
./contrib/plugins/ips.c), to implement something similar to what you
want, but based on time.
Would that satisfy your need?

Regards,
Pierrick

On 3/3/25 21:53, Saanjh Sengupta wrote:
>
>
> Hi,
>
> Thank you so much for your inputs. I was able to create the .so file of
> QEMU.
>
> Actually, what we are trying is to understand and explore possibilities
> of Virtual Time Control in QEMU. In short, what I mean to say is an
> approach via which I can tell QEMU to emulate for XYZ time when the I
> give a trigger and then pause the emulation by itself after the XYZ time
> is completed.
>
> On that front itself, do you have any inputs/ideas regarding the same?
>
>
> Regards
> Saanjh Sengupta
> ------------------------------------------------------------------------
> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
> *Sent:* Tuesday, February 25, 2025 6:29:44 AM
> *To:* Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Paolo Bonzini
> <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
> devel@nongnu.org <qemu-devel@nongnu.org>; Saanjh Sengupta
> <saanjhsengupta@outlook.com>
> *Subject:* Re: Building QEMU as a Shared Library
> Hi Saanjh,
>
> here is a minimal patch that builds one shared library per target (arch,
> mode) where arch is cpu arch, and mode is system or user, and launch
> system-aarch64 through a simple driver:
>
> https://github.com/pbo-linaro/qemu/commit/
> fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f <https://github.com/pbo-linaro/
> qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f>
>
> With this, it could be possible to create a driver that can execute any
> existing target. It's a sort of single binary for QEMU, but shared
> objects are mandatory, and duplicates all the QEMU state. So there is no
> real benefit compared to having different processes.
>
> In more, to be able to do concurrent emulations, there are much more
> problems to be solved. QEMU state is correctly kept per target, but all
> other libraries states are shared. There are various issues if you
> launch two emulations at the same time in two threads:
> - glib global context
> - qemu calls exit in many places, which stops the whole process
> - probably other things I didn't explore
>
> At this point, even though qemu targets can be built as shared objects,
> I would recommend to use different processes, and implement some form on
> IPC to synchronize all this.
> Another possibility is to try to build machines without using the
> existing main, but I'm not sure it's worth all the hassle.
>
> What are you trying to achieve?
>
> Regards,
> Pierrick
>
> On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:
>> Cc'ing our meson experts
>>
>> On 22/2/25 14:36, Saanjh Sengupta wrote:
>>> Hi,
>>>
>>> I referred to your mailing chains on suggesting QEMU to be built as a
>>> shared library.
>>>
>>> *Change meson.build to build QEMU as a shared library (with PIC enabled
>>> for static libraries)*
>>> *
>>> *
>>> Could you please suggest what exactly has to be enabled in the meson.bu=
ild?
>>>
>>> I am confused on that front.
>>>
>>> Regards
>>> Saanjh Sengupta
>>
>


--_000_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">You can find the image attached.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Saanjh Sengupta &lt;s=
aanjhsengupta@outlook.com&gt;<br>
<b>Sent:</b> Tuesday, March 11, 2025 3:20:48 PM<br>
<b>To:</b> Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;; Philippe M=
athieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redhat=
.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
<b>Cc:</b> amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e &lt;alex.be=
nnee@linaro.org&gt;<br>
<b>Subject:</b> Re: Building QEMU as a Shared Library</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">Hi,&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I have a couple of questions:&nbsp;</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:4}">
<li style=3D"list-style-type:&quot;(1) &quot;">
<div dir=3D"auto">When I use the libstoptrigger.so: in that case the QEMU '=
s emulation stops after executing the defined number of instructions. Post =
this, the whole QEMU terminates. And while using the libips.so I am assumin=
g that the QEMU doesn't execute no
 more than the defined instructions. Please correct me if I am wrong.&nbsp;=
&nbsp;</div>
</li><li style=3D"list-style-type:&quot;(2) &quot;">
<div dir=3D"auto">In my case, I want the QEMU to start emulation for some t=
ime and PAUSE it's emulation for some time; after it is Paused (it's virtua=
l time is also to be paused) and then let's say for after 'x' time period i=
t should resume it's virtual time.&nbsp;</div>
</li></ol>
<p dir=3D"auto"><span style=3D"color:rgb(0,0,0)"><img src=3D"https://as-api=
.asm.skype.com/v1/objects/0-jhb-d7-9966670e42dff0ab703863e5fc14f3ae/views/i=
mgo" alt=3D"image" id=3D"x_x_0-jhb-d7-9966670e42dff0ab703863e5fc14f3ae" wid=
th=3D"861" height=3D"102" style=3D"width:861px; height:102px; max-width:328=
px; margin-top:0px; margin-bottom:0px"></span></p>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I have added this segment inside the update_system_time f=
unction inside the ipsPlugin.c. but once the instructions reach to the defi=
ned limit the virtual time does not seem to stop.&nbsp;</div>
<div dir=3D"auto">Do you have any suggestions on that front?&nbsp;</div>
<div id=3D"x_ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div dir=3D"auto" id=3D"x_ms-outlook-mobile-signature">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Pierrick Bouvier &l=
t;pierrick.bouvier@linaro.org&gt;<br>
<b>Sent:</b> Wednesday, March 5, 2025 5:20:38 AM<br>
<b>To:</b> Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Philippe Mat=
hieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redhat.c=
om&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
<b>Cc:</b> amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e &lt;alex.be=
nnee@linaro.org&gt;<br>
<b>Subject:</b> Re: Building QEMU as a Shared Library</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Hi Saanjh,<br>
<br>
depending what you are trying to achieve exactly, plugins can provide a <br=
>
solution. It's convenient and you can stay on top of QEMU upstream, <br>
without having to create a downstream fork.<br>
<br>
We already have plugins for stopping after a given number of <br>
instructions, or slow down execution of a VM:<br>
<br>
# stop after executing 1'000'000 instructions:<br>
$ ./build/qemu-system-x86_64 -plugin <br>
./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin<br>
<br>
# execute no more than 1'000'000 instructions per second:<br>
$ ./build/qemu-system-x86_64 -plugin <br>
./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin<br>
<br>
You can see source code associated (./contrib/plugins/stoptrigger.c and <br=
>
./contrib/plugins/ips.c), to implement something similar to what you <br>
want, but based on time.<br>
Would that satisfy your need?<br>
<br>
Regards,<br>
Pierrick<br>
<br>
On 3/3/25 21:53, Saanjh Sengupta wrote:<br>
&gt; <br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; Thank you so much for your inputs. I was able to create the .so file o=
f <br>
&gt; QEMU.<br>
&gt; <br>
&gt; Actually, what we are trying is to understand and explore possibilitie=
s <br>
&gt; of Virtual Time Control in QEMU. In short, what I mean to say is an <b=
r>
&gt; approach via which I can tell QEMU to emulate for XYZ time when the I =
<br>
&gt; give a trigger and then pause the emulation by itself after the XYZ ti=
me <br>
&gt; is completed.<br>
&gt; <br>
&gt; On that front itself, do you have any inputs/ideas regarding the same?=
<br>
&gt; <br>
&gt; <br>
&gt; Regards<br>
&gt; Saanjh Sengupta<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
&gt; *Sent:* Tuesday, February 25, 2025 6:29:44 AM<br>
&gt; *To:* Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzin=
i <br>
&gt; &lt;pbonzini@redhat.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@=
redhat.com&gt;<br>
&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u- <br>
&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Saanjh Sengupta <br>
&gt; &lt;saanjhsengupta@outlook.com&gt;<br>
&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt; Hi Saanjh,<br>
&gt; <br>
&gt; here is a minimal patch that builds one shared library per target (arc=
h,<br>
&gt; mode) where arch is cpu arch, and mode is system or user, and launch<b=
r>
&gt; system-aarch64 through a simple driver:<br>
&gt; <br>
&gt; <a href=3D"https://github.com/pbo-linaro/qemu/commit/">https://github.=
com/pbo-linaro/qemu/commit/</a>
<br>
&gt; fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f &lt;<a href=3D""></a>https://=
github.com/pbo-linaro/
<br>
&gt; qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f&gt;<br>
&gt; <br>
&gt; With this, it could be possible to create a driver that can execute an=
y<br>
&gt; existing target. It's a sort of single binary for QEMU, but shared<br>
&gt; objects are mandatory, and duplicates all the QEMU state. So there is =
no<br>
&gt; real benefit compared to having different processes.<br>
&gt; <br>
&gt; In more, to be able to do concurrent emulations, there are much more<b=
r>
&gt; problems to be solved. QEMU state is correctly kept per target, but al=
l<br>
&gt; other libraries states are shared. There are various issues if you<br>
&gt; launch two emulations at the same time in two threads:<br>
&gt; - glib global context<br>
&gt; - qemu calls exit in many places, which stops the whole process<br>
&gt; - probably other things I didn't explore<br>
&gt; <br>
&gt; At this point, even though qemu targets can be built as shared objects=
,<br>
&gt; I would recommend to use different processes, and implement some form =
on<br>
&gt; IPC to synchronize all this.<br>
&gt; Another possibility is to try to build machines without using the<br>
&gt; existing main, but I'm not sure it's worth all the hassle.<br>
&gt; <br>
&gt; What are you trying to achieve?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Pierrick<br>
&gt; <br>
&gt; On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:<br>
&gt;&gt; Cc'ing our meson experts<br>
&gt;&gt; <br>
&gt;&gt; On 22/2/25 14:36, Saanjh Sengupta wrote:<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I referred to your mailing chains on suggesting QEMU to be bui=
lt as a<br>
&gt;&gt;&gt; shared library.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; *Change meson.build to build QEMU as a shared library (with PI=
C enabled<br>
&gt;&gt;&gt; for static libraries)*<br>
&gt;&gt;&gt; *<br>
&gt;&gt;&gt; *<br>
&gt;&gt;&gt; Could you please suggest what exactly has to be enabled in the=
 meson.build?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am confused on that front.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt; Saanjh Sengupta<br>
&gt;&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_--

--_004_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_
Content-Type: image/png; name="tmp_5e620eff-26a6-46e0-b25b-a1c257cf28eb.png"
Content-Description: tmp_5e620eff-26a6-46e0-b25b-a1c257cf28eb.png
Content-Disposition: attachment;
	filename="tmp_5e620eff-26a6-46e0-b25b-a1c257cf28eb.png"; size=21530;
	creation-date="Tue, 11 Mar 2025 12:48:00 GMT";
	modification-date="Tue, 11 Mar 2025 12:48:00 GMT"
Content-Transfer-Encoding: base64

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

--_004_SL2P216MB1380A9F4FADBC9B5DCA4DBB3CCD12SL2P216MB1380KORP_--

