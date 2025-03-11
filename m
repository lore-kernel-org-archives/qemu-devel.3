Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816B1C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwGQ-0008Vz-QQ; Tue, 11 Mar 2025 05:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trwGN-0008U8-Hk
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:51:03 -0400
Received: from mail-koreasouthazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d410::] helo=PUWP216CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1trwGG-0002FN-Sl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdFKfqtpv1s2CcPkXKsp4TheF/9bG8bJRtt4jPKzhYJ2BveANM6820y+PJf8DnxKqrJ9ELg5KcrC7FZZhBJEh2bOXE+oqX9cV88GwUte+Kn0lZ6u0s/WRxIjSN6mpSyKvaclmPAb/crcSxsqt1uCSE2ozdue4pSD1/I75dF5m7jQ2u/yr+xtzJhC7saSd6MCZdfu91z24gl44qz3ahA1sx9KttC02ntVw/+ZpPBpxr+fJdQ3oUJYv6QaQwfekdYcOmjIgvCy7hgISCcQDxlmBwa4mpeZ3AcZq7/S0IqwXfmRVs0i2tOCMGnAN9mI0BlqwqYTTdhTTLwI37lktqZAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAO7aT1i4/224Nw/LjVPrOksUnJRDgG3vKFxv+Z3mlk=;
 b=iOLQfevB8kErqQ1wJHTmy6CPSBfAPn3Gkye+JK5lR6zhDtw7wELHppn9GQ9Z+YmSfT56ihb/5ia3GFFeGSaH6egzDa5zaHLNg6P1vHakzvE7f+Iz6nEIHV4B//2ou26QmroKUgmJSwScgKwPs6kJR/5/lfVkgBPaGY8lqHuqbSs0yOoL75MchbAH3GmwpnSGMBc36TVSEK2iecXjwx6LInoBbmAI1NA+RRTCZJF5wMN/7IBrWDOkATtmBooB83mPM9rp+tJ5DQqgz1IN2vRYgakzapYkKnTvzw2RtyGDCz9hL9U5oTzAfVesL0zgGEn987er1uR/gRGvDWv247x+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAO7aT1i4/224Nw/LjVPrOksUnJRDgG3vKFxv+Z3mlk=;
 b=IuWCExVt59qpgUFeMQw2xzacv64OKlIqD2j2O0FWHEeECpo2dSREoPuSmPJZN4p3flD7qi0e0H5MMnYGQyGCizKGVfZYICB9x5U4N4/BuYWSAes3SeKzcdPgpHf9GVdHxbUhV8soBKKSUQ/B7CUDuClVcYe9F67bh5bOlJ4H9KQ1l1l6qYi729FJQFAsY/HqOGSaOCjAxBZG/kaAbAFs5pdHV4SZ/JBrXOZKLOejfSB9mdrJ6Fd5+R4eQZ1LlZXVDtJ52yysIW2iiiM5mOTV+RYJ2Kws/1uvkvIqCpRHCr+YCu+BXzIvvUzpwWBuYeA+wDcy7TqOH6EJ+RCbNkhOWw==
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::12) by
 SE2P216MB2754.KORP216.PROD.OUTLOOK.COM (2603:1096:101:289::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 09:50:49 +0000
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98]) by SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:50:48 +0000
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
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEYABLfwAgAn+2tc=
Date: Tue, 11 Mar 2025 09:50:48 +0000
Message-ID: <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: SL2P216MB1380:EE_|SE2P216MB2754:EE_
x-ms-office365-filtering-correlation-id: a2389719-0773-4944-a101-08dd608233e3
x-microsoft-antispam: BCL:0;
 ARA:14566002|14030799003|1680799057|19110799003|9000799050|12050799009|9400799030|8062599003|15080799006|461199028|7092599003|8060799006|10035399004|4302099013|3412199025|440099028|102099032|1602099012;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TaNFPNAXGM9N9OmigAZ02RvjWozTUp1NRYCwXq/1uJAoqlX1YmomWErnOY?=
 =?iso-8859-1?Q?8iH0yUzx20CxZ99m3f59MdQoSIqsH8LR56jOfaMOTEY7UjdFVo9IWDFg+j?=
 =?iso-8859-1?Q?Abu533h+iV1tJIj5l1vB6F4VDJo35qYgViWvqWfFhftrDkOcFmd3cWOjen?=
 =?iso-8859-1?Q?BtNrBc7iCsoyvrmJqjTdmlE2mOLSgj0tsfPiLiQYTTB9bSTBdNMz5sCk7D?=
 =?iso-8859-1?Q?3cFncATnP+Di93fTsP4RclE3fjjIw0i4L5TO6Ez1nIfslAhq4WEsWg15sT?=
 =?iso-8859-1?Q?f5RaQ1wIuYSdiN6jo3O6aX8vNKUM5tTrJJ5Rbh5PwuJiJGQ8XoBkLHRPoV?=
 =?iso-8859-1?Q?sflKW4d1Fj0VAaA0AQH0rYNEXBZ4KvwZS2ojkEPhXYK3juTMle7A6BK0Le?=
 =?iso-8859-1?Q?JboT+ETCF7fjadvPQSbJFB2Xc8Pbe2UzZ7rZDtj4JE7+Ktc0fIeuMQmEf4?=
 =?iso-8859-1?Q?HKAMydQQlsKSKSg4th5MB+QW/teqbqmLLXdKrSGCnr8O5UPpFwptxNB/Cb?=
 =?iso-8859-1?Q?s7icStZPuMJfIXyJ/QtpiWynXj/xKUgs0x1Y40tbRsSMY1RI+yY5H4s6hk?=
 =?iso-8859-1?Q?PxZCDQ6kRCyUFupM9Tvf0LUBpY4TNWZJt58vVDUga0PS+hU4onP6xTMoBR?=
 =?iso-8859-1?Q?5FZh1lLRyZfLMsFpgF9Rw2LCL1ryH4pJC0xUBYeMbJJ6an9wB8sl8tpAgh?=
 =?iso-8859-1?Q?9WepRJf/FLhywLX3iZ9Y59V8205VC02pfgyRYvhPim3q1v1Vi5uCUjebxv?=
 =?iso-8859-1?Q?wA1kjzNm206phzmg51a2fPxKPRNERNcCGhPhJihaFtrkg/uvwGXVvMuj3v?=
 =?iso-8859-1?Q?ZIF2d0+XVc9qAOIf/XuvbdDwRuAsDXWcwGfJTmQ9USTc/h99M+4ILWOn2t?=
 =?iso-8859-1?Q?9t9K/y9iMHViKGG/3uRNQylDKUHjUGygtHZ7m+8MfXoXgqO3QH8MXzUU1M?=
 =?iso-8859-1?Q?rkyB3+5VGygxk9ReVV2lhf07kgkgF0FWKAU1vk9neGfaUVn6H65ayFGBD5?=
 =?iso-8859-1?Q?m7sAw+nESlTZ3KKVj9za/55HYkT6lzrk66FIX64y0AyA5+GOMipQSGNg1S?=
 =?iso-8859-1?Q?YOSyScC4VayxRypzkwIATdrV32dr59r6Flz9NAGeZpBN9dHAIA2X59t7dk?=
 =?iso-8859-1?Q?kirGkLZf6KDD4JmdjFI5q4jizqfWx4DRHfotStdckXrBJaaZE7c3SHk/2I?=
 =?iso-8859-1?Q?Cnbf5C7raTHGHrkyhfvHkePA6dTE0CI0RkKATXkInEURmySm5ih8XDvuT4?=
 =?iso-8859-1?Q?JAca6vwTiMg3leUOhpYVSM3sg6tvQDkcY1/SEpMecYOZ4m1tPHNkVytg7L?=
 =?iso-8859-1?Q?Ot9c8b9/S6ysDFq5xDjwRiKLggF9nS8EHUjoMxopyLYNCgN6HDOWHEgVSj?=
 =?iso-8859-1?Q?HaM/9DaKHQpftsLwT0lQHodYR64obAd9EFGLo7yuMlMEtrj1wrnR4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u0XC6LV2LyXxZrk4s+Bvk2JohN9sq7Iy4qvnFdrlmEOUQV/JOlI/LR9MZ7?=
 =?iso-8859-1?Q?x0zpAE4QVkqNgsNkrwXqqdGA1jbBvde/4UR7lnnEZvByAoIE7QH1chrApL?=
 =?iso-8859-1?Q?lIxDhLnYdJbnIjX8SXLVKdB1C+8gWeWzieSHNB3NVI4W+BfN3s295cMJRm?=
 =?iso-8859-1?Q?PDGRULks2CAZUHb+9+hNJBTOwVxtAJjpRLUdJ8T745XtVOhS3+7DN3fP9o?=
 =?iso-8859-1?Q?euY2bHnUqcgyQtf6v5bQ5xDf95sO9L/7U4UuXx6qYN4L7nq9RYseG27zB0?=
 =?iso-8859-1?Q?weHF8mtG/eYaiuB4w3f7qswa1NE8C1bTcM/mkHsRv5dXW5M47y+a+6fhEF?=
 =?iso-8859-1?Q?mb3fDIglMXfy5TtExm+aA0xYsfWbJ5QOXCU2ty24vTEkr9m5T8C02NHenL?=
 =?iso-8859-1?Q?417SGSeCVEV/N2CYAfqdmQvLGI5xlJ5BB2EgrxUKOjmEUzOf0ps+YAKwnS?=
 =?iso-8859-1?Q?M8nUM7vuNREI3Z5b0AhpljCWi+g96BIN1je79AoS70FO818G2AoTFrvUD/?=
 =?iso-8859-1?Q?heqYrBE82TIQ+VRkw4p7Zb7IHbJ1UZPhOTUhT/YWfSl3hPRkHhmLR0VsVb?=
 =?iso-8859-1?Q?dcknbEBZiSndQRyvwnLOj7MtBVC86GU5hI33uVcBKVqooivTFSyGM1DHSU?=
 =?iso-8859-1?Q?Ovq6updZihdCfr6sTOwX60krD8lX9jawxvrEck7Ds62cDGUaqb/xej8oGV?=
 =?iso-8859-1?Q?AR9jbEawbEQ8z/q+6rEmaQDntkHjqnMBrnUkh9qPLdmGHX3XjybgdIbx8d?=
 =?iso-8859-1?Q?rIqNNLGJNx5I9h2ugiRq9pW8S4jyXzsRTgjMsxdRG07Y09+YSPo6Y00vLT?=
 =?iso-8859-1?Q?i8gQAo8KYo7C7cHjrS69adDzVnL/mM/uk/0nDAhTLYyqS/QDdkfKxCnPwS?=
 =?iso-8859-1?Q?h9WgxUIU2nFuJoST2wACSyvmrxjNMBa4H+3zCxa07sIjhUf0r/cevGm8Ai?=
 =?iso-8859-1?Q?v+z1EbnCeyLTx1T1ujakPIDGzN80mzEAT06C4lLH7lf1yqeyfEWOoM7wlK?=
 =?iso-8859-1?Q?Q0VxtLThaQ9n/yfr2a8IuNj97bzti23TNgJwDm71tlHAEsCIoYDs6xFwYY?=
 =?iso-8859-1?Q?8lCU+piQdp4ZYP0a58yc/Ul0AJZQCz+QZzbgqPxhrPdAH98BiXii3GKqCx?=
 =?iso-8859-1?Q?mKosh1knHrYGqGPVTuCuT4nFNILmAIXMx68RT/dMSrOmpq3u5AedkAS/Yb?=
 =?iso-8859-1?Q?OfGb4kxPZQfuGYWioTBo4Rag6ZatCINhIbMf663gk+nCH/fafh0ugoUbtD?=
 =?iso-8859-1?Q?XVCpGrtDgYOQdtbYibZvVM9Te30FefEGuIPb98DqiufoftaxrQ89W5dKuS?=
 =?iso-8859-1?Q?KWN5CfQL5PK/k9lVd1UHBhewsQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SL2P216MB138053F139E1B688D2BBA201CCD12SL2P216MB1380KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a2389719-0773-4944-a101-08dd608233e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 09:50:48.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2754
Received-SPF: pass client-ip=2a01:111:f403:d410::;
 envelope-from=saanjhsengupta@outlook.com;
 helo=PUWP216CU001.outbound.protection.outlook.com
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

--_000_SL2P216MB138053F139E1B688D2BBA201CCD12SL2P216MB1380KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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


--_000_SL2P216MB138053F139E1B688D2BBA201CCD12SL2P216MB1380KORP_
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
<div dir=3D"auto">I have a couple of questions:&nbsp;</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:4}">
<li style=3D"list-style-type: &quot;(1) &quot;;">
<div dir=3D"auto">When I use the libstoptrigger.so: in that case the QEMU '=
s emulation stops after executing the defined number of instructions. Post =
this, the whole QEMU terminates. And while using the libips.so I am assumin=
g that the QEMU doesn't execute no
 more than the defined instructions. Please correct me if I am wrong.&nbsp;=
&nbsp;</div>
</li><li style=3D"list-style-type: &quot;(2) &quot;;">
<div dir=3D"auto">In my case, I want the QEMU to start emulation for some t=
ime and PAUSE it's emulation for some time; after it is Paused (it's virtua=
l time is also to be paused) and then let's say for after 'x' time period i=
t should resume it's virtual time.&nbsp;</div>
</li></ol>
<p dir=3D"auto"><span style=3D"color: rgb(0, 0, 0);"><img src=3D"https://as=
-api.asm.skype.com/v1/objects/0-jhb-d7-9966670e42dff0ab703863e5fc14f3ae/vie=
ws/imgo" alt=3D"image" id=3D"x_0-jhb-d7-9966670e42dff0ab703863e5fc14f3ae" w=
idth=3D"861" height=3D"102" style=3D"width: 861px; height: 102px; max-width=
: 328px; margin-top: 0px; margin-bottom: 0px;"></span></p>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I have added this segment inside the update_system_time f=
unction inside the ipsPlugin.c. but once the instructions reach to the defi=
ned limit the virtual time does not seem to stop.&nbsp;</div>
<div dir=3D"auto">Do you have any suggestions on that front?&nbsp;</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div dir=3D"auto" id=3D"ms-outlook-mobile-signature">
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

--_000_SL2P216MB138053F139E1B688D2BBA201CCD12SL2P216MB1380KORP_--

