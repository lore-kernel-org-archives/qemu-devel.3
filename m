Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF187C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrkk-0007vk-JR; Tue, 11 Mar 2025 01:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trrkP-0007q6-Mj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:01:50 -0400
Received: from mail-koreacentralazolkn19011035.outbound.protection.outlook.com
 ([52.103.74.35] helo=SE2P216CU007.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trrkF-00061e-Ih
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGuhotQgbk2il01OsV3u6BoToppJd9qAbHonRjcE4Y1XbanyMg4X/CHT2AsV4eL0tx7qHR0Bxc+OiPEVdSU9RzFUHsyrciDvcLOZzSvLAEwYwb1Xv6+P04zxOHWjLUdVDmlOhZZnZ83rot80bzxvdrpGpwf9ePu2YaJbqk5TsC6TGo9+YRK4nYhRrzGjM5aqafGr2pbOVe59rmWUsukGahPkKuBYJC8zExjEwbDh+Jv7YBu+/i/N46FbKnEuoNTJ134NaEZmYWv0Vvlyml9avQY8y+tXW7+HlM6afJnAZHz5bPWh7sKxCLn/gw40fZtygUOSb2dwEcGA2EI4rx7dyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGV0+YYtH1kXHIkHc2u0ul8OXOI/b/DCOnyuMC1iYOY=;
 b=kVgRWwn6JG1Fruyy2qBDMuP+7z6O/4FnYWI5OZUopVmCowwPwMCXj2TjHKUOpXj1XjsvEAsNR2ShvtaQMXDDFSevm8sSWDSwxRr1pFova+PxHuZixxih4VhG8z3d3LJrnKxkW6rlFyzRoWPjQTxob3MWBYdDG/GUHf0YAseXt9ga79Ix9iaeOHqGVflmcSrXRZmImM0pWtzCTV579YZmREIRdb/Du8YJ+YXMiiyfAQKCXiye6qoc71JJrfD0htKPebJ7MP6etzrJBpCR6daYQJoxH/lul6+WuyKZhKxtvLcVKtXnbmL9xHQG22rTzi2P4Z7SpZIL9QREVpn60/D3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGV0+YYtH1kXHIkHc2u0ul8OXOI/b/DCOnyuMC1iYOY=;
 b=VkdUiNTrSotaexWnjW8q5pHpvjb1XRqQD/aHpBnqrYUoeG5rFIVhQH8oSlZtn9Sr5DlxUkccLHjCNf6iKOWZYvSxlVqlnqnbYj4hGipMhj1iUnQ6318pWQjFw1hG+KHHicJgKcXeG7UO7x7/HBYIwc9qVaAyjbE+7CkM5T8Fd2ZTjFtrFbPqmF9qH16iRb0A7Y/j6AyYgeWDQnaWNXWWrCb7JtozpsORhXbUYq7wJ/ZeOl0hIJqyd+orbXbaTCg4Dqqf1k5hMJqgAolh7ey/sH3W1B8rieoIkULaaCCZZjtw3Nz1yDjvOitBOrjXN4aC3E8//LbYeL9zR4A7LGDu0w==
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::12) by
 SE2P216MB1410.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 04:56:23 +0000
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98]) by SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 04:56:23 +0000
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
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEYABLfwAgAnA5FQ=
Date: Tue, 11 Mar 2025 04:56:23 +0000
Message-ID: <SL2P216MB1380306AF61E049C7E61FCB9CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
In-Reply-To: <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1380:EE_|SE2P216MB1410:EE_
x-ms-office365-filtering-correlation-id: 956c3c96-b873-42a6-b401-08dd60591296
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599003|461199028|9400799030|14030799003|19110799003|8060799006|7092599003|15080799006|12050799009|10035399004|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LxRG4/aghF1E3K30xvzbZFWWSKilKIIQvFrbFafBDxTnUgf8d20P4fmmlC?=
 =?iso-8859-1?Q?M5rCHPHzd2i9PdKq39x4zmT5MREuLa4uDtehfKaxzjh221SInhiHFjJY+7?=
 =?iso-8859-1?Q?A/zitMhA2UWZFl+4zFUebuKxs2rm3+WRAbcE9LAqtx/u76QamhoTN0lust?=
 =?iso-8859-1?Q?CUpYMioY9omiZvTfMxRTLhwrZZ7vbojjUr/5Bxfn7olFzB2AlOp9LGEX8H?=
 =?iso-8859-1?Q?Ny4ACM7XOvTYyGVfsRWzr4MOrAMR1hWQDFkixaDakFaIyMnGE7zHh9d1qI?=
 =?iso-8859-1?Q?gzn3QElju/PNk72/GUvr6wkLKzc/9noUZLbtmglaxfjr/s+xit39IbutnR?=
 =?iso-8859-1?Q?RsknTm8kLMOQKIqyoPasETnatK8si3kKlQLNH/UfO0b7nu8+vBC08XLnyn?=
 =?iso-8859-1?Q?ov7bG/Ac/gLRraoTTzw+F4Frl51mmT0wNKdfAPHFCiNhhq74OajLjmtlmp?=
 =?iso-8859-1?Q?oM5ZfBPVXbbgVNmB8NapMX4nWEeeua2hvEXo3a4rY3lKMJQZKUb1nHD4HO?=
 =?iso-8859-1?Q?tB31k874Cc6mbGTYSC3qr2Xl2cqo4TvkEqrIhqlstwuTERMvOwTEe0PtrG?=
 =?iso-8859-1?Q?KNRpyTkkfNoCsA2muwpbwiQIva9CL2tOfx2GgK7qGWXAbAKDYMc197LYlH?=
 =?iso-8859-1?Q?VLKD3+GAG0sSXkhlQhusVwLBvWdmyUNjxH4oZA43bYns+4c2T3+4Nv4GSH?=
 =?iso-8859-1?Q?8DzB9RMWOu3x5g2xXDuEK8Q6rIr2PnQSclvNm/BA1B51pTzFA/EfZb6vnw?=
 =?iso-8859-1?Q?BqdqnZdAiDWFFJvJRhDvoy+Jqsl5MVIEbzyHRk703zVkNe4nBUiYwXFnlG?=
 =?iso-8859-1?Q?c/gdlIZenE8LFg5Ixu+nq647k3rz8lMgAVIrkzIo5rVPB0G9Sxt12fymR/?=
 =?iso-8859-1?Q?+Rkl5rX/kbNwwjNFW6wL9NauuzEeDjoLNPK5yMW1T+9h4l0gojy73p+b4C?=
 =?iso-8859-1?Q?fvmSZTgkpbqx9tmNFtELifAUa58tvWfcDeliTqx/ISISBdeJmNyrTUge4z?=
 =?iso-8859-1?Q?CiVqyESLcdXbQxrr/drbIc5a9grRbUlzwGy3+Lqm86Q0/UKkUeABZmQcgE?=
 =?iso-8859-1?Q?EXKwH605A7TDun3rdj7NAR9x6xrXO31CbreLHScrV+ciUXckek9xBiWj+R?=
 =?iso-8859-1?Q?zvKv/Rv6s3oBz5Epm8d3pQF77IQktFN6X0TMKGB0oy/ZnkJfanQHs5teAq?=
 =?iso-8859-1?Q?I4Jot+P5euvPEuPo5KAfYjOHRm8qdlk/nR19c17sqiqPCYwAs8wn4TW/2p?=
 =?iso-8859-1?Q?l3R+vYRfJTvsjkDA97OSugp3Ybbw1JeZ69tWcAJNs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XLn8uHQqayXxn0fUXGt4c2uj78dUQPVIKmxjIQ8UNXLQcnezPkVaTbv1f2?=
 =?iso-8859-1?Q?oYtlLnWKzFzenBmrqIrLVjZc9P6NuDG2WCyaKQptkt7VXRkAOFN02iYAp3?=
 =?iso-8859-1?Q?8T8hOUgT5lbAxHBhen4HWBH+7SO9BA1E9CUs4i+Sb6o1Xp+b6Jv0DR5lQ/?=
 =?iso-8859-1?Q?LUjJm/RCQcA+KkwTovq3NCGkNLVkS5YHJ2GegIcLGHyFbw3XVPGzswC55/?=
 =?iso-8859-1?Q?woOVQKg24i4oBGXQGFLU3Nr20Q6Ub86Ye1SpWGQzQhiKiYXxl2lEQXB9lf?=
 =?iso-8859-1?Q?c/foAPUTr0iPhSoCO5fTWArCLWe5g/j8EaSzMXli60Z3O30h4xdnt4njSV?=
 =?iso-8859-1?Q?C8bldjrw31/Ir4tNxKPNmzItpbKBoOpVLsGLM+JrFAwq2Wsezup67iHzii?=
 =?iso-8859-1?Q?yinVDUXWh65gdJPhOyN1slUzQgW1ItVxQPPMhr2DuFC3ZrPJ1ZLnWV+qfj?=
 =?iso-8859-1?Q?RNBTKjOlWH+6bC66hJuqxx4hcsp3xk3UnXNbrNLbG1h51EUiPejXd1y8V6?=
 =?iso-8859-1?Q?jo4Nr6Aq2CThgnS0qDagyoXd0Ti1fvrCQk5lE+Mws8EkhkvVbTxDL/UC9b?=
 =?iso-8859-1?Q?ugNGPK2sDYmAE71abT8UYznE1Q7KXNAKcd1GAJ+sj+Cc2onSev1qLo5wE8?=
 =?iso-8859-1?Q?D22elNc/6Qp9K9oNbcG3n+ut6Xjec93/lX2oug03B19hFAW7NMWacNHqRg?=
 =?iso-8859-1?Q?4yrk9ou0Hy8ly0tG7nKBN8HKxx4PyCFZafCnOE7XEEtuvl5083cxYA4CDR?=
 =?iso-8859-1?Q?RldgO9638l9htnXrB6tVP/8FwhizNiH8Za8XYEzluj2Dd6+EPV7Qz8n5VC?=
 =?iso-8859-1?Q?tQpVJ5WmuhA594gTxfqQYBnwI3T5/l4FiXQzAGbppQS+RMtgpd2oCeKqe1?=
 =?iso-8859-1?Q?l+n8IToaus+VQYUmWSPFoVxWSWkv+ZRJgX/MRTa2sPv5jJSNtZFXppqwIv?=
 =?iso-8859-1?Q?da3TYBf3baFBOfCq7+PrUPvftuXveU/P84+7NIkwA+3ESXCdc1m6dDDOv4?=
 =?iso-8859-1?Q?by/m/QxxqXET2zlZVHkvp7bB2dYDshGhZCpqlKP6rcPCdtE4FBEMgwvTf1?=
 =?iso-8859-1?Q?l7Zpr8qILnEORgSjKVcfmTtSfEjshgwh9LiEKDK2GfSVhqhMR4cDJH63Zz?=
 =?iso-8859-1?Q?7BELv+PyUN0aYwMSTFR37miXG3VrC8qwozwYVnB/NEpw+wHPomRwEv/zKS?=
 =?iso-8859-1?Q?Ds1CH+nDrSbnhTiOadyKHHNr3lQu7u8xhw30+eWXqQw0BDbRko4ldyq6XJ?=
 =?iso-8859-1?Q?6gA5DRRuHtvqjIChgqfu5mQeea8V2i0hSj857QAYnBKR8g8S50W0cOifvZ?=
 =?iso-8859-1?Q?hFTHsjmOlZJN0Mi25exok76A4w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SL2P216MB1380306AF61E049C7E61FCB9CCD12SL2P216MB1380KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 956c3c96-b873-42a6-b401-08dd60591296
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 04:56:23.6297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1410
Received-SPF: pass client-ip=52.103.74.35;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SE2P216CU007.outbound.protection.outlook.com
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

--_000_SL2P216MB1380306AF61E049C7E61FCB9CCD12SL2P216MB1380KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your inputs. Let me check with the information you provided. =
Will let you know if I am stuck with something.


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


--_000_SL2P216MB1380306AF61E049C7E61FCB9CCD12SL2P216MB1380KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto">Hi,&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thank you for your inputs. Let me check with the informat=
ion you provided. Will let you know if I am stuck with something.&nbsp;</di=
v>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pierrick Bouvier &lt;=
pierrick.bouvier@linaro.org&gt;<br>
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
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Saanjh,<br>
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
</body>
</html>

--_000_SL2P216MB1380306AF61E049C7E61FCB9CCD12SL2P216MB1380KORP_--

