Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F50C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsguw-00070X-0D; Thu, 13 Mar 2025 07:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tsgut-0006zw-7X
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:39:59 -0400
Received: from mail-koreacentralazolkn19011030.outbound.protection.outlook.com
 ([52.103.74.30] helo=SLXP216CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tsguk-0004WE-It
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJw08cYCO8K1Ya+jpD6XWSmnPzahQaB5kdcAxOUKDCibf75CDojeVW68Ovli7r+tD4T++JIDc0Z8a58wQw9Xw5H8lMctB5PN9wxLR7D8+gWTRQhg/myxZs8zPQROML2rDX/yP2uRYMpuH4JDyPWHPlgRa1+GSL4KPtzU+8IFHZRxIJh/6/7fbqpqSyzq69VLc++cFNTGygnupdIgEWAtH0sv0NAdD4RQbdgIh3mSc32tlld6CHTA9RrronGWNDI5Zl5Y4Dko+crYCtqMsJUv+eQ9cUodt8LyTirEt8CLAOsBk3KYh/hYcovhZAzrNrj/MiCXLxa2tI8c9Q2okIApFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GvMf6P/Txr0Mj21Kqn1zCSSXhiDFr+XNwa6zrhfp80=;
 b=ocq+xUZWFo8mAXxP5DFL78ERMtmiJqCTL8zGRHQAZClIMyyL3cmqLLGBICwvvfok7wSfhJJBZjR4mZTCI45cV0Qvhnkvab7WVA1sMS3w+v368zODhYPJfAz32ZBD7zljYjrvMDASo1QCTvxRTgrW+GYBJIFXOzZEFWVstMz0sD0GVq2GrAAoR2x62Dff9bnur1Ks6Wi1KY5AbVGurG92lSotPWIW9MAHG5m+pNDPbAFYo86HjRmJmeU7sxeXWuMIUDA6rmhEv6jIhlzNhnt6Hir7WoWUjHNvt0n6tG4zFE5iymHnub4LSr1Ffn8JLhX+GgUuMzHdSqsS+yCvQ/6ywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GvMf6P/Txr0Mj21Kqn1zCSSXhiDFr+XNwa6zrhfp80=;
 b=X3etfIhdJk5HQZJ4rRuWazZUxNI0lL7kupkFI9AdG0X00Oo9iwpw0uGKTPJyKnJLH2haBoZmMS4i2++UssIYpwBnEA75jibK1zA8QXWH4u9L2mjMPuoBazumlmLiEemZjWgpYxPPRZHXV/n64ASfhlMolo+QsuT2Dv6mS2kIYzkkzf8Pjc3nAmVGNC/fSevITypimYhFILuAOVX3XGiGgeyOips232zJtyeJadJnitAC34uaWH50ofwiOGV+I5avfioXI4e9JIcMvgEo+lYmlR1NV/XKfxFiYHh80tcqTom2RaKLAyebeFXolo8QOdFzqzGhveLvNZNrf3WFzp9gGw==
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::12) by
 PU4P216MB1534.KORP216.PROD.OUTLOOK.COM (2603:1096:301:cd::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 11:34:35 +0000
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98]) by SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 11:34:35 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>
CC: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 "aabhashswain25@gmail.com" <aabhashswain25@gmail.com>, "aniantre@gmail.com"
 <aniantre@gmail.com>
Subject: Re: Building QEMU as a Shared Library
Thread-Topic: Building QEMU as a Shared Library
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEYABLfwAgAn+2teAAM2LgIAAf5SGgAAhMQCAAei2ZA==
Date: Thu, 13 Mar 2025 11:34:35 +0000
Message-ID: <SL2P216MB13806B5994D2A1F4DC5E5685CCD32@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
 <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <2f1078d7-31bf-4940-aa43-30a45f7a07a0@linaro.org>
 <SL2P216MB1380316B32539524D1CCD831CCD02@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <ab0a0e8d-9c26-4225-942b-9d6996abfb8f@linaro.org>
In-Reply-To: <ab0a0e8d-9c26-4225-942b-9d6996abfb8f@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1380:EE_|PU4P216MB1534:EE_
x-ms-office365-filtering-correlation-id: c04656f5-1418-485e-32e0-08dd622307fa
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|15080799006|9400799030|12050799009|19110799003|7092599003|14030799003|8062599003|8060799006|10035399004|3412199025|440099028|102099032|19111999003|41001999003|12091999003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uqfERjB/d/zGIZH6GZo3k3IUqU3Erc3Q8toOw8HF+Ru6jy/cjrIUsDft8s?=
 =?iso-8859-1?Q?Z0oI4ka2iblyJZNSrxre7b9W6slRMMXvu8rmi1QBzRNCixrCA8dI8aadrF?=
 =?iso-8859-1?Q?3If9lPmt+JJI3HYZWvUfNoNKMeltDRkRQaMm1UkCDD83OSU86VD0I3Yvcf?=
 =?iso-8859-1?Q?rZLch81h6e+NyQQZs9zxupv5pvttpL5GFhWabhBWF6XGt3XKs1jr1MNBcH?=
 =?iso-8859-1?Q?qegZOZ0vWjbDkDyCn4AmAhLM+XbOW5nVvbH3NgmQC9ywfRUk1HmzAwHvlr?=
 =?iso-8859-1?Q?RJUEv9dc49aEjt312ANpBhWpvNqEXyew4ouJfq5txYSaj0HOtSrUIXS8vF?=
 =?iso-8859-1?Q?NoEUEJydhMlTtWjyJDW3zSZxrJmUs4HRz5GKqBV9Slg0ogddh1g5jnN8g2?=
 =?iso-8859-1?Q?s3tzgK9kWaZXH+1+ymlSoaVi+e2xMOAb4N1AElIHSN9skWGn3zMEY9gGC9?=
 =?iso-8859-1?Q?OYA3ZTaG2C+Jb3feZA9rWkDqXV5GePsSev3lHmpXNeHBBgDz0ksh/afVPK?=
 =?iso-8859-1?Q?UASkSbPMHOrRuSHhELp0bD+0+cPCID0nglwmctyaTVs9GKYe4BDeQJVa97?=
 =?iso-8859-1?Q?7lZEDcKfJ0csCyorqdAS1ldI4zszY0uFV6L1CZ64z0+EJBt2jSdh8vAcKq?=
 =?iso-8859-1?Q?VcdvdVNaHQEaAXBDpdnvvTF304mGKlfjk9ZvjkMbQcl38BcKu5/1vEZUmj?=
 =?iso-8859-1?Q?KRYtueHwBuQDe7DhyD/Yd29qBUa7Mazq8zbCgcKCzMa0ZUMAOm6jv9MEi2?=
 =?iso-8859-1?Q?sjeOyH+1RAaWoYCB/w1al/RzA7u6KWVXGJbInG2YvdTWtB/OXT99c30dnx?=
 =?iso-8859-1?Q?VhDfKBS9LIXYx63OL3EHnQj+C0PRUvFMJIRV7ZK4t4+yGXvA7zR4xZlSnU?=
 =?iso-8859-1?Q?ZvSjO5O6uCn+dWY8WblSXJ8ZfB1Dum5hraBTD4cjFVIbPT0WHfD1KKl+qN?=
 =?iso-8859-1?Q?y4EfsJOSnq8OGVOXQJjhHs/5dt0y2udIITQYb9NAXDee7PNzw45Lc2ImB8?=
 =?iso-8859-1?Q?f7qNEgxeXzRdgyVRjxJkYhYimn3jy/k+awgAfGYgMLXZtUj+qFq7BgRVvB?=
 =?iso-8859-1?Q?kMCkHcRGJ0yrh1E3/k0ipBT5ArzkMPmg7rYf5sllklXxBWzliM+HR58vWf?=
 =?iso-8859-1?Q?kPqO0ETBOQx+tmw1S7xWugUXXjsxbPZwGxu1yxlOSKqcXBfbPPRCZERxoy?=
 =?iso-8859-1?Q?Wa5hePZsvc44dtA37b5vc5wvS6+6fru78lh4KctYDCUgi6zfx1nZutKrUe?=
 =?iso-8859-1?Q?3Ht2qggNyCzv12VuH5Y+hQ6qnX2ojzLaT3tiuYazaRa6ShDHXtPNlbMmGb?=
 =?iso-8859-1?Q?HMSZtxsMRmiIwWw8gctc1HWs8w4ixo3oc7Vu1/4weL0ThWnstCBdIZkDd8?=
 =?iso-8859-1?Q?tJPT2v0J8ZahMgGNFCLrq75/80es3u9w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pjoTvwk0X35rTNhT8jr9/svFuLAGToG0JAsAqx5uutWZrTd/aeyXLowcL2?=
 =?iso-8859-1?Q?rTmjj3ZCPO6uGggQJd34cSndXBmaf5OcdNuzImdSm0w/Dr0H856n3joazD?=
 =?iso-8859-1?Q?Ac6FX9elHpkQFS6Bmjol5891JjuLU8NG3H6w53nStxmbLFZ/wUin/QvaWy?=
 =?iso-8859-1?Q?4wq4jyKLZzuHQAw+CL97TKlBIwp/SJS6sbGclScXRjzIuy4ehQYGCfVUHB?=
 =?iso-8859-1?Q?Bz65Tb6E0h6nggc6uwm4mRWvIoOv08DAtoQHrESwukju82WTlnBOpUGL9u?=
 =?iso-8859-1?Q?jKMrSmG6NeY6gOl+fQ25WNIXUtvHRbPiSYpU8exOrpgcwPYfq0Ype26Tno?=
 =?iso-8859-1?Q?ctPULVkgQt5hHC0lUf/fPo75ZvQJswO2Cd5kYKnD8+Q3ztFmeHfLEOEz9t?=
 =?iso-8859-1?Q?rV4uEFZ7/PwqxiETuREJ7chBU4gDYeStTLIXUKg0JCvhT3vRY9ymbLqy2C?=
 =?iso-8859-1?Q?PMfcVSrH0Ll6RsdIZYymnrXa7mVqPK4FkiuKOAtFTLQDOH9mqy/t4WRW5k?=
 =?iso-8859-1?Q?rSVGGrsBsYm5475sJOganRlRVslXjNqgXpVlUS87NTA57++EkyX9OjMWjw?=
 =?iso-8859-1?Q?yr74J+RwemJ03J/gUhFDM2i8QUBOVrGO0iFXY6H5qDEzbC1y2GNJhueaM4?=
 =?iso-8859-1?Q?/pFrvgVbPSUxBdGLgSX3xXrJZk9BaF4jrqmDE2P4M1zyB94FuXoxq44eGa?=
 =?iso-8859-1?Q?KkOJU41cO7NkIGhiBTp8EhSmd+k5NRm7YGE8+uo9BJ93MVIPZNScbv398x?=
 =?iso-8859-1?Q?Asf2JqNj3CODid/iKxOb+ht0WWbxdssae6p6RQTqC1uIIFCH65DZAcgM8w?=
 =?iso-8859-1?Q?yWGEFXeBFBoAuSOfFwyytCwOpff9T5Rj+6kCQO0klbY8LKezy87ha+9Rup?=
 =?iso-8859-1?Q?bBYVvIFJOJROnNOzY0tBQrcdLo9m6tpfdw4HDVkOoZpdfqh32pdTv5SpiT?=
 =?iso-8859-1?Q?z/BkSiPV/Is6BCNq4ZnDtlYhEq7smUItiZ/coI1Y8e/r2k2vxqUYIkxHNZ?=
 =?iso-8859-1?Q?wKAPnpaOOxWZXtPfTu6a9sOqRwftDkq4qH8LIws6GvaxASOqeWAR7VXN8Q?=
 =?iso-8859-1?Q?K4RaekaE6NK+VuUML0DeHjnKw2fkVaU6BIu7euxWx7av1On72dRPwSJ6L6?=
 =?iso-8859-1?Q?ANweRDg2uy9VbnLuJh+dol2AA3Go7ImuHSeVHW3reHyjtQzWAanu/pzoXf?=
 =?iso-8859-1?Q?rq7pMQtmYewpB+8amcksECGFdwv7V+D847yoD32WevL1AluX20Csnafp2y?=
 =?iso-8859-1?Q?ibgjS+wV6XDCF+ZcmATp94OPDNtCMpsPP9ZS3tWECC2bqyUkA9ocP10VcW?=
 =?iso-8859-1?Q?VfFr9+LhSAN3WQ0wSUhagQnzdA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SL2P216MB13806B5994D2A1F4DC5E5685CCD32SL2P216MB1380KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c04656f5-1418-485e-32e0-08dd622307fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 11:34:35.3631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1534
Received-SPF: pass client-ip=52.103.74.30;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SLXP216CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--_000_SL2P216MB13806B5994D2A1F4DC5E5685CCD32SL2P216MB1380KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

What we are trying to achieve is that the QEMU should run for a particular =
number of instructions, let's say for example 10000 instructions and then p=
ause it's emulation. After a resume trigger is received to the QEMU it must=
 resume it's emulation and start the instruction count from 10001 (which ba=
sically means that the context should be saved).

In the previous mail when you mentioned g_usleep, I believe this shall not =
work (as per our use-case) since it will reset the instruction count to 0 (=
as per what you mentioned).

To achieve the use-case, do you have any leads/suggestions ?


Regards
Saanjh Sengupta

________________________________
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Sent: Wednesday, March 12, 2025 11:50:23 am
To: Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-Daud=E9 =
<philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lure=
au <marcandre.lureau@redhat.com>
Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongn=
u.org <qemu-devel@nongnu.org>; Alex Benn=E9e <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library

On 3/11/25 21:31, Saanjh Sengupta wrote:
>
>
> Hi,
>
> Thank you for the clarification. Regarding the last time
> /"Stoptrigger might be a better fit for what you want to do, and instead
> of exiting, you want to resume emulation after N insn. The function
> qemu_clock_advance_virtual_time() can only be used to move the time
> forward, and you can not stop the "virtual time" by design."/
> /
> /
> I did not quite understand this. Even if I have to modify the
> stopTrigger plugin, I would want it to pause rather than exiting.
> For example: It gets 10000 instructions executed after that it should
> pause and after some time it should then resume again execute till 20000
> instructions (because previously it executed till 10000 and then it must
> execute till 20000). How do I do this? How do I state the code to pause
> the qemu's emulation after 10000 instructions?
>

By using g_usleep to pause the current cpu.
As well, it's needed to reset insn_count to 0 to count instructions again.

With this command line:
./build/qemu-system-x86_64 -plugin
./build/contrib/plugins/libstoptrigger.so,icount=3D1000 -d plugin

And with those changes to stoptrigger:

diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index b3a6ed66a7b..77fd413cef1 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -41,11 +41,12 @@ typedef struct {
      int exit_code;
  } ExitInfo;

-static void exit_emulation(int return_code, char *message)
+static void pause_emulation(int return_code, char *message)
  {
      qemu_plugin_outs(message);
      g_free(message);
-    exit(return_code);
+    /* exit(return_code); */
+    g_usleep(1 * G_USEC_PER_SEC);
  }

  static void exit_icount_reached(unsigned int cpu_index, void *udata)
@@ -53,7 +54,9 @@ static void exit_icount_reached(unsigned int
cpu_index, void *udata)
      uint64_t insn_vaddr =3D qemu_plugin_u64_get(current_pc, cpu_index);
      char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ",
exiting\n",
                                  insn_vaddr);
-    exit_emulation(icount_exit_code, msg);
+    pause_emulation(icount_exit_code, msg);
+    /* reset instruction counter */
+    qemu_plugin_u64_set(insn_count, cpu_index, 0);
  }

  static void exit_address_reached(unsigned int cpu_index, void *udata)
@@ -61,7 +64,7 @@ static void exit_address_reached(unsigned int
cpu_index, void *udata)
      ExitInfo *ei =3D udata;
      g_assert(ei);
      char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n",
ei->exit_addr);
-    exit_emulation(ei->exit_code, msg);
+    pause_emulation(ei->exit_code, msg);
  }


> Moreover, I tried an activity where I was utilising the QMP protocol to
> control the virtual time (with respect to the IPS plugin). In that
> context when the QMP stop is triggered, my virtual time does got freezed
> until the resume is triggered. Does this mean I am able to manipulate
> the virtual time of the QEMU?
>

I am not sure of how it works, but the plugin interface only allows to
move time forward.

>
>
> Regards
> Saanjh Sengupta
> ------------------------------------------------------------------------
> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
> *Sent:* Wednesday, March 12, 2025 2:14:47 AM
> *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-
> Daud=E9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>
> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
> devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=E9e
> <alex.bennee@linaro.org>
> *Subject:* Re: Building QEMU as a Shared Library
> On 3/11/25 02:50, Saanjh Sengupta wrote:
>> Hi,
>>
>> I have a couple of questions:
>>
>>  1.
>>     When I use the libstoptrigger.so: in that case the QEMU 's emulation
>>     stops after executing the defined number of instructions. Post this,
>>     the whole QEMU terminates. And while using the libips.so I am
>>     assuming that the QEMU doesn't execute no more than the defined
>>     instructions. Please correct me if I am wrong.
>
> That's correct for both plugins, with the additional note that libips
> does this per second only.
>
>>  2.
>>     In my case, I want the QEMU to start emulation for some time and
>>     PAUSE it's emulation for some time; after it is Paused (it's virtual
>>     time is also to be paused) and then let's say for after 'x' time
>>     period it should resume it's virtual time.
>>
>
> The virtual time variable in ips plugin is only related to this plugin,
> and based on how many instructions have been executed, which is
> different from what you want to achieve.
>
> Stoptrigger might be a better fit for what you want to do, and instead
> of exiting, you want to resume emulation after N insn.
> The function qemu_clock_advance_virtual_time() can only be used to move
> the time forward, and you can not stop the "virtual time" by design.
>
>> image
>>
>>
>> I have added this segment inside the update_system_time function inside
>> the ipsPlugin.c. but once the instructions reach to the defined limit
>> the virtual time does not seem to stop.
>> Do you have any suggestions on that front?
>>
>>
>> Regards
>> Saanjh Sengupta
>> ------------------------------------------------------------------------
>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> *Sent:* Wednesday, March 5, 2025 5:20:38 AM
>> *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-
>> Daud=E9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-
>> Andr=E9 Lureau <marcandre.lureau@redhat.com>
>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
>> devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=E9e
>> <alex.bennee@linaro.org>
>> *Subject:* Re: Building QEMU as a Shared Library
>> Hi Saanjh,
>>
>> depending what you are trying to achieve exactly, plugins can provide a
>> solution. It's convenient and you can stay on top of QEMU upstream,
>> without having to create a downstream fork.
>>
>> We already have plugins for stopping after a given number of
>> instructions, or slow down execution of a VM:
>>
>> # stop after executing 1'000'000 instructions:
>> $ ./build/qemu-system-x86_64 -plugin
>> ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin
>>
>> # execute no more than 1'000'000 instructions per second:
>> $ ./build/qemu-system-x86_64 -plugin
>> ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin
>>
>> You can see source code associated (./contrib/plugins/stoptrigger.c and
>> ./contrib/plugins/ips.c), to implement something similar to what you
>> want, but based on time.
>> Would that satisfy your need?
>>
>> Regards,
>> Pierrick
>>
>> On 3/3/25 21:53, Saanjh Sengupta wrote:
>>>
>>>
>>> Hi,
>>>
>>> Thank you so much for your inputs. I was able to create the .so file of
>>> QEMU.
>>>
>>> Actually, what we are trying is to understand and explore possibilities
>>> of Virtual Time Control in QEMU. In short, what I mean to say is an
>>> approach via which I can tell QEMU to emulate for XYZ time when the I
>>> give a trigger and then pause the emulation by itself after the XYZ tim=
e
>>> is completed.
>>>
>>> On that front itself, do you have any inputs/ideas regarding the same?
>>>
>>>
>>> Regards
>>> Saanjh Sengupta
>>> -----------------------------------------------------------------------=
-
>>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> *Sent:* Tuesday, February 25, 2025 6:29:44 AM
>>> *To:* Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Paolo Bonzini
>>> <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>
>>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
>>> devel@nongnu.org <qemu-devel@nongnu.org>; Saanjh Sengupta
>>> <saanjhsengupta@outlook.com>
>>> *Subject:* Re: Building QEMU as a Shared Library
>>> Hi Saanjh,
>>>
>>> here is a minimal patch that builds one shared library per target (arch=
,
>>> mode) where arch is cpu arch, and mode is system or user, and launch
>>> system-aarch64 through a simple driver:
>>>
>>> https://github.com/pbo-linaro/qemu/commit/ <https://github.com/pbo-
> linaro/qemu/commit/> <https://github.com/pbo-
>> linaro/qemu/commit/>
>>> fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f <https://github.com/pbo-linaro=
/
>>> qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f>
>>>
>>> With this, it could be possible to create a driver that can execute any
>>> existing target. It's a sort of single binary for QEMU, but shared
>>> objects are mandatory, and duplicates all the QEMU state. So there is n=
o
>>> real benefit compared to having different processes.
>>>
>>> In more, to be able to do concurrent emulations, there are much more
>>> problems to be solved. QEMU state is correctly kept per target, but all
>>> other libraries states are shared. There are various issues if you
>>> launch two emulations at the same time in two threads:
>>> - glib global context
>>> - qemu calls exit in many places, which stops the whole process
>>> - probably other things I didn't explore
>>>
>>> At this point, even though qemu targets can be built as shared objects,
>>> I would recommend to use different processes, and implement some form o=
n
>>> IPC to synchronize all this.
>>> Another possibility is to try to build machines without using the
>>> existing main, but I'm not sure it's worth all the hassle.
>>>
>>> What are you trying to achieve?
>>>
>>> Regards,
>>> Pierrick
>>>
>>> On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:
>>>> Cc'ing our meson experts
>>>>
>>>> On 22/2/25 14:36, Saanjh Sengupta wrote:
>>>>> Hi,
>>>>>
>>>>> I referred to your mailing chains on suggesting QEMU to be built as a
>>>>> shared library.
>>>>>
>>>>> *Change meson.build to build QEMU as a shared library (with PIC enabl=
ed
>>>>> for static libraries)*
>>>>> *
>>>>> *
>>>>> Could you please suggest what exactly has to be enabled in the meson.=
build?
>>>>>
>>>>> I am confused on that front.
>>>>>
>>>>> Regards
>>>>> Saanjh Sengupta
>>>>
>>>
>>
>



--_000_SL2P216MB13806B5994D2A1F4DC5E5685CCD32SL2P216MB1380KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">What we are trying to achieve is that the QEMU should run=
 for a particular number of instructions, let's say for example 10000 instr=
uctions and then pause it's emulation. After a resume trigger is received t=
o the QEMU it must resume it's emulation
 and start the instruction count from 10001 (which basically means that the=
 context should be saved).&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">In the previous mail when you mentioned g_usleep, I belie=
ve this shall not work (as per our use-case) since it will reset the instru=
ction count to 0 (as per what you mentioned).&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">To achieve the use-case, do you have any leads/suggestion=
s ?&nbsp;</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container" class=3D""=
><br>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;"><strong>From:</strong>=
 Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
<strong>Sent:</strong> Wednesday, March 12, 2025 11:50:23 am<br>
<strong>To:</strong> Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Ph=
ilippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzin=
i@redhat.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<b=
r>
<strong>Cc:</strong> amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.a=
i&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e &=
lt;alex.bennee@linaro.org&gt;<br>
<strong>Subject:</strong> Re: Building QEMU as a Shared Library<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 3/11/25 21:31, Saanjh Sengupta wrote:<br>
&gt; <br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; Thank you for the clarification. Regarding the last time<br>
&gt; /&quot;Stoptrigger might be a better fit for what you want to do, and =
instead <br>
&gt; of exiting, you want to resume emulation after N insn. The function <b=
r>
&gt; qemu_clock_advance_virtual_time() can only be used to move the time <b=
r>
&gt; forward, and you can not stop the &quot;virtual time&quot; by design.&=
quot;/<br>
&gt; /<br>
&gt; /<br>
&gt; I did not quite understand this. Even if I have to modify the <br>
&gt; stopTrigger plugin, I would want it to pause rather than exiting.<br>
&gt; For example: It gets 10000 instructions executed after that it should =
<br>
&gt; pause and after some time it should then resume again execute till 200=
00 <br>
&gt; instructions (because previously it executed till 10000 and then it mu=
st <br>
&gt; execute till 20000). How do I do this? How do I state the code to paus=
e <br>
&gt; the qemu's emulation after 10000 instructions?<br>
&gt; <br>
<br>
By using g_usleep to pause the current cpu.<br>
As well, it's needed to reset insn_count to 0 to count instructions again.<=
br>
<br>
With this command line:<br>
./build/qemu-system-x86_64 -plugin <br>
./build/contrib/plugins/libstoptrigger.so,icount=3D1000 -d plugin<br>
<br>
And with those changes to stoptrigger:<br>
<br>
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c<=
br>
index b3a6ed66a7b..77fd413cef1 100644<br>
--- a/contrib/plugins/stoptrigger.c<br>
+++ b/contrib/plugins/stoptrigger.c<br>
@@ -41,11 +41,12 @@ typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int exit_code;<br>
&nbsp; } ExitInfo;<br>
<br>
-static void exit_emulation(int return_code, char *message)<br>
+static void pause_emulation(int return_code, char *message)<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_plugin_outs(message);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(message);<br>
-&nbsp;&nbsp;&nbsp; exit(return_code);<br>
+&nbsp;&nbsp;&nbsp; /* exit(return_code); */<br>
+&nbsp;&nbsp;&nbsp; g_usleep(1 * G_USEC_PER_SEC);<br>
&nbsp; }<br>
<br>
&nbsp; static void exit_icount_reached(unsigned int cpu_index, void *udata)=
<br>
@@ -53,7 +54,9 @@ static void exit_icount_reached(unsigned int <br>
cpu_index, void *udata)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t insn_vaddr =3D qemu_plugin_u64_get(=
current_pc, cpu_index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *msg =3D g_strdup_printf(&quot;icount r=
eached at 0x%&quot; PRIx64 &quot;, <br>
exiting\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insn_vaddr);<br>
-&nbsp;&nbsp;&nbsp; exit_emulation(icount_exit_code, msg);<br>
+&nbsp;&nbsp;&nbsp; pause_emulation(icount_exit_code, msg);<br>
+&nbsp;&nbsp;&nbsp; /* reset instruction counter */<br>
+&nbsp;&nbsp;&nbsp; qemu_plugin_u64_set(insn_count, cpu_index, 0);<br>
&nbsp; }<br>
<br>
&nbsp; static void exit_address_reached(unsigned int cpu_index, void *udata=
)<br>
@@ -61,7 +64,7 @@ static void exit_address_reached(unsigned int <br>
cpu_index, void *udata)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ExitInfo *ei =3D udata;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(ei);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *msg =3D g_strdup_printf(&quot;0x%&quot=
; PRIx64 &quot; reached, exiting\n&quot;, <br>
ei-&gt;exit_addr);<br>
-&nbsp;&nbsp;&nbsp; exit_emulation(ei-&gt;exit_code, msg);<br>
+&nbsp;&nbsp;&nbsp; pause_emulation(ei-&gt;exit_code, msg);<br>
&nbsp; }<br>
<br>
<br>
&gt; Moreover, I tried an activity where I was utilising the QMP protocol t=
o <br>
&gt; control the virtual time (with respect to the IPS plugin). In that <br=
>
&gt; context when the QMP stop is triggered, my virtual time does got freez=
ed <br>
&gt; until the resume is triggered. Does this mean I am able to manipulate =
<br>
&gt; the virtual time of the QEMU?<br>
&gt; <br>
<br>
I am not sure of how it works, but the plugin interface only allows to <br>
move time forward.<br>
<br>
&gt; <br>
&gt; <br>
&gt; Regards<br>
&gt; Saanjh Sengupta<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
&gt; *Sent:* Wednesday, March 12, 2025 2:14:47 AM<br>
&gt; *To:* Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Philippe Mat=
hieu- <br>
&gt; Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redhat.c=
om&gt;; Marc- <br>
&gt; Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u- <br>
&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e <br>
&gt; &lt;alex.bennee@linaro.org&gt;<br>
&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt; On 3/11/25 02:50, Saanjh Sengupta wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt; <br>
&gt;&gt; I have a couple of questions:<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; 1.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; When I use the libstoptrigger.so: in that =
case the QEMU 's emulation<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; stops after executing the defined number o=
f instructions. Post this,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; the whole QEMU terminates. And while using=
 the libips.so I am<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; assuming that the QEMU doesn't execute no =
more than the defined<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; instructions. Please correct me if I am wr=
ong.<br>
&gt; <br>
&gt; That's correct for both plugins, with the additional note that libips<=
br>
&gt; does this per second only.<br>
&gt; <br>
&gt;&gt;&nbsp; 2.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; In my case, I want the QEMU to start emula=
tion for some time and<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; PAUSE it's emulation for some time; after =
it is Paused (it's virtual<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; time is also to be paused) and then let's =
say for after 'x' time<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; period it should resume it's virtual time.=
<br>
&gt;&gt; <br>
&gt; <br>
&gt; The virtual time variable in ips plugin is only related to this plugin=
,<br>
&gt; and based on how many instructions have been executed, which is<br>
&gt; different from what you want to achieve.<br>
&gt; <br>
&gt; Stoptrigger might be a better fit for what you want to do, and instead=
<br>
&gt; of exiting, you want to resume emulation after N insn.<br>
&gt; The function qemu_clock_advance_virtual_time() can only be used to mov=
e<br>
&gt; the time forward, and you can not stop the &quot;virtual time&quot; by=
 design.<br>
&gt; <br>
&gt;&gt; image<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; I have added this segment inside the update_system_time function i=
nside <br>
&gt;&gt; the ipsPlugin.c. but once the instructions reach to the defined li=
mit <br>
&gt;&gt; the virtual time does not seem to stop.<br>
&gt;&gt; Do you have any suggestions on that front?<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Regards<br>
&gt;&gt; Saanjh Sengupta<br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
&gt;&gt; *Sent:* Wednesday, March 5, 2025 5:20:38 AM<br>
&gt;&gt; *To:* Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Philippe=
 Mathieu- <br>
&gt;&gt; Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redh=
at.com&gt;; Marc- <br>
&gt;&gt; Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
&gt;&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;;=
 qemu- <br>
&gt;&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e <br>
&gt;&gt; &lt;alex.bennee@linaro.org&gt;<br>
&gt;&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt;&gt; Hi Saanjh,<br>
&gt;&gt; <br>
&gt;&gt; depending what you are trying to achieve exactly, plugins can prov=
ide a<br>
&gt;&gt; solution. It's convenient and you can stay on top of QEMU upstream=
,<br>
&gt;&gt; without having to create a downstream fork.<br>
&gt;&gt; <br>
&gt;&gt; We already have plugins for stopping after a given number of<br>
&gt;&gt; instructions, or slow down execution of a VM:<br>
&gt;&gt; <br>
&gt;&gt; # stop after executing 1'000'000 instructions:<br>
&gt;&gt; $ ./build/qemu-system-x86_64 -plugin<br>
&gt;&gt; ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin<=
br>
&gt;&gt; <br>
&gt;&gt; # execute no more than 1'000'000 instructions per second:<br>
&gt;&gt; $ ./build/qemu-system-x86_64 -plugin<br>
&gt;&gt; ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin<br>
&gt;&gt; <br>
&gt;&gt; You can see source code associated (./contrib/plugins/stoptrigger.=
c and<br>
&gt;&gt; ./contrib/plugins/ips.c), to implement something similar to what y=
ou<br>
&gt;&gt; want, but based on time.<br>
&gt;&gt; Would that satisfy your need?<br>
&gt;&gt; <br>
&gt;&gt; Regards,<br>
&gt;&gt; Pierrick<br>
&gt;&gt; <br>
&gt;&gt; On 3/3/25 21:53, Saanjh Sengupta wrote:<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Thank you so much for your inputs. I was able to create the .s=
o file of <br>
&gt;&gt;&gt; QEMU.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Actually, what we are trying is to understand and explore poss=
ibilities <br>
&gt;&gt;&gt; of Virtual Time Control in QEMU. In short, what I mean to say =
is an <br>
&gt;&gt;&gt; approach via which I can tell QEMU to emulate for XYZ time whe=
n the I <br>
&gt;&gt;&gt; give a trigger and then pause the emulation by itself after th=
e XYZ time <br>
&gt;&gt;&gt; is completed.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; On that front itself, do you have any inputs/ideas regarding t=
he same?<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt; Saanjh Sengupta<br>
&gt;&gt;&gt; --------------------------------------------------------------=
----------<br>
&gt;&gt;&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<b=
r>
&gt;&gt;&gt; *Sent:* Tuesday, February 25, 2025 6:29:44 AM<br>
&gt;&gt;&gt; *To:* Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paol=
o Bonzini <br>
&gt;&gt;&gt; &lt;pbonzini@redhat.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre=
.lureau@redhat.com&gt;<br>
&gt;&gt;&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&=
gt;; qemu- <br>
&gt;&gt;&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Saanjh Sengupt=
a <br>
&gt;&gt;&gt; &lt;saanjhsengupta@outlook.com&gt;<br>
&gt;&gt;&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt;&gt;&gt; Hi Saanjh,<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; here is a minimal patch that builds one shared library per tar=
get (arch,<br>
&gt;&gt;&gt; mode) where arch is cpu arch, and mode is system or user, and =
launch<br>
&gt;&gt;&gt; system-aarch64 through a simple driver:<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; <a href=3D"https://github.com/pbo-linaro/qemu/commit/">https:/=
/github.com/pbo-linaro/qemu/commit/</a> &lt;<a href=3D""></a>https://github=
.com/pbo-
<br>
&gt; linaro/qemu/commit/&gt; &lt;<a href=3D""></a>https://github.com/pbo-<b=
r>
&gt;&gt; linaro/qemu/commit/&gt;<br>
&gt;&gt;&gt; fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f &lt;<a href=3D""></a>=
https://github.com/pbo-linaro/<br>
&gt;&gt;&gt; qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f&gt;<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; With this, it could be possible to create a driver that can ex=
ecute any<br>
&gt;&gt;&gt; existing target. It's a sort of single binary for QEMU, but sh=
ared<br>
&gt;&gt;&gt; objects are mandatory, and duplicates all the QEMU state. So t=
here is no<br>
&gt;&gt;&gt; real benefit compared to having different processes.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; In more, to be able to do concurrent emulations, there are muc=
h more<br>
&gt;&gt;&gt; problems to be solved. QEMU state is correctly kept per target=
, but all<br>
&gt;&gt;&gt; other libraries states are shared. There are various issues if=
 you<br>
&gt;&gt;&gt; launch two emulations at the same time in two threads:<br>
&gt;&gt;&gt; - glib global context<br>
&gt;&gt;&gt; - qemu calls exit in many places, which stops the whole proces=
s<br>
&gt;&gt;&gt; - probably other things I didn't explore<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; At this point, even though qemu targets can be built as shared=
 objects,<br>
&gt;&gt;&gt; I would recommend to use different processes, and implement so=
me form on<br>
&gt;&gt;&gt; IPC to synchronize all this.<br>
&gt;&gt;&gt; Another possibility is to try to build machines without using =
the<br>
&gt;&gt;&gt; existing main, but I'm not sure it's worth all the hassle.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; What are you trying to achieve?<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Pierrick<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:<br>
&gt;&gt;&gt;&gt; Cc'ing our meson experts<br>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; On 22/2/25 14:36, Saanjh Sengupta wrote:<br>
&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I referred to your mailing chains on suggesting QEMU t=
o be built as a<br>
&gt;&gt;&gt;&gt;&gt; shared library.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; *Change meson.build to build QEMU as a shared library =
(with PIC enabled<br>
&gt;&gt;&gt;&gt;&gt; for static libraries)*<br>
&gt;&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt;&gt; Could you please suggest what exactly has to be enable=
d in the meson.build?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I am confused on that front.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt;&gt; Saanjh Sengupta<br>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt; <br>
&gt;&gt; <br>
&gt; <br>
<br>
</div>
</span></font><br>
</div>
</body>
</html>

--_000_SL2P216MB13806B5994D2A1F4DC5E5685CCD32SL2P216MB1380KORP_--

