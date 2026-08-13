Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuLZG-0005JS-UR; Wed, 12 Aug 2026 22:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wuLZF-0005JF-G5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 22:53:17 -0400
Received: from mail-westusazon11022136.outbound.protection.outlook.com
 ([52.101.43.136] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wuLZD-0004B6-AX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 22:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJccr2p+NcrVy+jSL/T+pE18pIPIwAMpTdEimaVgzjDFaO5Xij+r70vy9I9wgA5VzzhBfPOH1u/65y4B8jlQg70IW4iIgAWrKtBSsd63BCMtiHGwcI/WyLr3hIR+ki5Hmui1Hhc/MtSIPVzF+0ICSbkbLiFaWRBn7mTNIwwnNa5KsK4lYacG4vXA+S5EI8E4Ik4OfI/txaOoFuR9Vmnu7WKRU9qweKIliSGIQ7faTJ4mILc/mzuDvVpW+En10JV85XOR5B0GemD6z/r5i2UE3wMndFT1qvavp0aq0alILbSJf6qRm6VC2LKhhhPBp5p4Jl12BWWI8+vVUm/5XorTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWkoPzkllVN8Z/HmMvzd41Z50OkcctmtE84ukEe6sI0=;
 b=uh20X8pvUpP8qTLjegd9cBoiUxV6yekg/BAy37gk1mU1ZcO7idX0mReGCbuSVziX0WoNhKc0CIyruLYksXWKkCKGbQeZAAZGs+ienQC5k8jl5lm2+Ysp2tB90WYeET7VjSwagmT5YBTmqxjMAES0lu+sJYA7FF8DRYhlAo6b95CC7gN0V+uCVdgomKsGR9K8zfBZ2FTev2RfigJh6RRVUppqFX8xtlzOmzI8dhvL1QXQioeR9Mxcle4rEiOmrvkbuALR5oc25qQ0Cs06FgU0vULvc+k0gKDTOQD4pSXuvxwRrmdl/gxWUTR3ThdK8ntwyj/v+TsPFbRKPRQtina0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWkoPzkllVN8Z/HmMvzd41Z50OkcctmtE84ukEe6sI0=;
 b=cZ4csobtlGDX1uA579k87OUs1lUrlcg++yOBfY++lGriXT4t+P1KNmrlBc7iAnvYOQme2lDanANleNOshRHLI36KteqfBS/InghYZeZNjDRulx6VCGnCbOdIibvLgiT4SB/6r3r8FeMCSs/q+8l8rdlgqI72hEcWNFHXaPwsGsCWrnIcsQhxkIXwLlEmpJXyvzXraOUlbtwuWO12qBPxpBYslcp6d+LGzjC5Vx1g9oVM46yzQQf79b2iW7AWKP+wl9ZQusfLEvbejW8UZZtpdjELG6wJOJrB7AvrFlLB5PzbZ3DGVFxwLztJgbwt8qZth4WMKls1hK9B6fgON4EgYg==
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DM8PR18MB4438.namprd18.prod.outlook.com (2603:10b6:8:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 02:48:07 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 02:48:07 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: =?iso-2022-jp?B?GyRCMnNKJBsoQjogW1BBVENIIHY3IDAvOF0gQWRkIEF4aWFkbyBTb0Mg?=
 =?iso-2022-jp?B?QVgzMDAwIGFuZCBFVksgYm9hcmQ=?=
Thread-Topic: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board
Thread-Index: AQHdEpmPDmMn8g/k5ECk9T61i6k3z7aXlXmAgALUCACAAQ2EKA==
Date: Thu, 13 Aug 2026 02:48:07 +0000
Message-ID: <SJ0PR18MB4479960E52944B3CD1ABCF0CD3DB2@SJ0PR18MB4479.namprd18.prod.outlook.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
 <CAFEAcA_=DVVwQYdpwnhbzF_GwR9gZp4sJa-C97caA0i7zofADA@mail.gmail.com>
 <CAFEAcA-CRhcSEQL8wWMjyLJR5j8x01d7dXRNpfHDds8qC1qzcw@mail.gmail.com>
In-Reply-To: <CAFEAcA-CRhcSEQL8wWMjyLJR5j8x01d7dXRNpfHDds8qC1qzcw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4479:EE_|DM8PR18MB4438:EE_
x-ms-office365-filtering-correlation-id: bf9edc99-36d7-487d-9b62-08def8e54de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|56012099006|18002099003|22082099003|10067099003|8096899003|38070700021;
x-microsoft-antispam-message-info: 6shzIF1cxG1lC06XiYXE1yJ2WQFs+GSS40AW00xNNLPGEnNam0Yx6rSMMi1zWXWwMy+sRUeeeXodrWFMTCzuz0YBHoyrxWYz+CUxtXraBiPI2olqI56q5IYucQWMrBf63b/E7bNeW1EppdA+b4GHBPl8+6R8Vkgn8rWmhP3LYEDCALstSYnIO6LtwcAKvfuU2/aocPo0V//kzvX1rjnts1LNQ7YJGHXPWuNz/yIZYd5Gb1R/hbzMd3Ocgbm6P361kRTpMXYAaKurcp6qzuZWgQrB1izu0zHcv5IGhk8gfP+0SMBx/dwrFHai5xaWe1tZLQOw3aehsLTMUJ2QTjSzuu0wR/rqSg8xWcN2Geq9Of/7Je4LgvL3isZugxh3CEgPLevIcecTj1FDPWFPK8XC063PIPMxaEc/EL37jxJxic7jQfiQ0GENVRyZXYDuYQq59sAJai3ukOduRjYVRGCgmGZ3a1JgE9uWMiaCzHqyEVWjr3kWr3m1vDK681QjAg6O/+CY09OnhY43bxcJQgoHAC0bxJsBjjcf376/y7nPWCwCHUOPzBkzyI04RvAxgLIliG+jTdYGf018/LL1IITstiDAv7SXGKnHJlTwtaggAH4ioZyv6/cosH4boqCmPOezB9t0sviC16gUiVE6Eo1Cz7+U/a/kntDkfyxa2CVGO5/JAwmreCiAJA1GDnJunxHY2eoBqZwxKjoBrjatrI+wJV2+6AxckgS1FaKTNk+xxV0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?c1VlU0JTdzJGdE93WWhPRExrdEhNVENxaVJFanJ2aFN0Sk9uTG9zYkpE?=
 =?iso-2022-jp?B?OHpWOU5QTTEwTmhVcEhTc1dmeS9TSXMreTlqaVk0T1VlNFpxQUJsYlM4?=
 =?iso-2022-jp?B?MmkrNE9iOEwzSTlzVTRuRUZYSC9PSnlzQUpFZHJqYVVlVUp5RGNuaE95?=
 =?iso-2022-jp?B?MXBseC9mNzJKNzBFTlJMYnBRL0NkWjlZMFZ2VGlaa2Z3VGV1NkhUMk1H?=
 =?iso-2022-jp?B?Z1J1Yi8zSUUvYkV6YVBWeDV4RFpIQVFyTXplQXhocS9EcnhlZWdOcERD?=
 =?iso-2022-jp?B?MjY5YUMxVXJ0WWVidU1SMW5DUFpqY3ZzdTdINTB5blIrck5OOS9obFZO?=
 =?iso-2022-jp?B?enh4QVRrcEZ0YUV4bXltTi8ySlRSVWI3T2UzSjJPNnN0VXNad0V0WmQr?=
 =?iso-2022-jp?B?RE93QUlQL3VyeHdqaXNsUWlWOVdtNG5VSUM3WjJmbFJYSWx1QWRsMklO?=
 =?iso-2022-jp?B?OUhxTnc5NzMvQlNnbmVUSnIwWldjaFBVNit0aUZlekRORkdFdHZSK1NM?=
 =?iso-2022-jp?B?UVZCVnl1QXdFV0d4czBuZUlYMFJYeUFKZDZnTW5hR3BjUXhWOUNUdUFi?=
 =?iso-2022-jp?B?TXM5eCtFMWZoTHFYUzFNUVk0bW5Vcms0R3pxYis2dklzNGdDd1FobmVy?=
 =?iso-2022-jp?B?VmZXV2gzZ2g2M2pHdnZsMTRsaVNUTnY1ZXB3VCtNQ1owbDQ2bDNqR3F0?=
 =?iso-2022-jp?B?NjZIZUd4L1VScFlWZmt3dTlxZmRVVDU0Nk9aQU9kZ1BYVTducFQ4QkJV?=
 =?iso-2022-jp?B?Q3I4Z3dYRGlxU3FRMTg2TkxYeGZuTUFEdVJMVXVNc3dZUWFMTjJ6SUJs?=
 =?iso-2022-jp?B?UStPNUlmelNTVzE3MUtLbE9JSUo5V1k0V2gzRTVFRVlaVjF2MmtsZldu?=
 =?iso-2022-jp?B?c2dmK3ZmeVVodVhUVU9lcWdINVJHUUliS1llUHhicnVlalJoWUxLOHAv?=
 =?iso-2022-jp?B?NnYrU3k3WkdveTFYbkRIdUJ2aXYweEhpbVY3N1N5MjJCc25FSU1JMUZC?=
 =?iso-2022-jp?B?MFFvWlFYZGFkWFZkUzJBTWR5bC9NUTBFbXJ5UGFDS1JyOU1aL1AzYVJK?=
 =?iso-2022-jp?B?T0tzQmZGdzN2bG1qVTNOdTZqaVRoN1BVbmcxYUgza3dFTTlNRkpIR1R2?=
 =?iso-2022-jp?B?SlEzekRPNmJjdmZUMnNpVGh1Wmd4WDBQZFhhaTF4ZHR3UzR2cW9vdHNy?=
 =?iso-2022-jp?B?U1VXQXpyUTRNNlZwNUpxUU9YK2REY2NMNGlwTjhLcHNNMzRmbEJDL0Js?=
 =?iso-2022-jp?B?OEpFdVpTb09idGxHcjBPbGs0SEdKWStPWmk3RG5Ic0tTZ2dDR2V5NEJG?=
 =?iso-2022-jp?B?dWU3dDk3TFFnb3Q5c21sUlFNS2NSMTh0Wm83MUd6UU0yQk9VUTlFRUFR?=
 =?iso-2022-jp?B?cnZIS2xQN3ppdzRwK01IWC9SSjVlcEtqZGxMUitFQkxHdkl6SFR4ZFpH?=
 =?iso-2022-jp?B?aGEwUytielJWSSs5ME55YWVDYmdEcVowOThPNVhneGl1M2V6S3BZTDFS?=
 =?iso-2022-jp?B?V1BzWnAxNEpnTFRNbytzV2FibkUwajdLQWtveFowSEJKemFkVHAxTzJQ?=
 =?iso-2022-jp?B?Z1lHdTFzVDBWc2hTTUExMjM2c25lVHdJSDJKa0hrMWMxNERlSVR4cjky?=
 =?iso-2022-jp?B?MjkrVnpSV0pSZjRraW5xdjAxZVlxTzBjZGwrWGtBOXJBZkdYdjI4cWk3?=
 =?iso-2022-jp?B?VlQycEppS0M5UjJDdW5wQ2lpNW96Wm13MGFQT04wRUw1K2xoaHVrdnAv?=
 =?iso-2022-jp?B?Mk0xWGE2VWFuNHhSQ3J2aDRqdTl2R0E4RXF0OEUzbDh1bzNqYnBoNjM3?=
 =?iso-2022-jp?B?eGtYUUx2djF0bHAyK01ZU0xPaklZUmdzWENMZmYzT0lnTUVLZ3lTRDZk?=
 =?iso-2022-jp?B?UnhNWjlreUdYUzU5em5oSFNESTZxQ0J6RDFDSWF1SG9UTW9BZ2huL2FO?=
 =?iso-2022-jp?B?MDlYWkpHR3JNUWtWMGR4V0dNNXRmNlB2eVcxLzlGeS8yRy9nSFlWeWRJ?=
 =?iso-2022-jp?B?WVVOS2VsVE5GN0I4QnpqSVlOQ0c4MUpYMTJibGVXZnFJRDNQZ2N2Nmpa?=
 =?iso-2022-jp?B?L2J0bFpNdHlnMFc4cmRRbVYrK1lrZUVLQVdlOWNCWnJKeFpJRy80cFg5?=
 =?iso-2022-jp?B?dGw1UE5XU3BsZXJNQ0hZTC96MXNmTTdtTUFZd2U3NjVSMFdzazR4aS92?=
 =?iso-2022-jp?B?b3dCbTNlcTBjbDZQTDluc1hIa2k4elh4YkRkeFE0dDZZcGhlcGVUVlov?=
 =?iso-2022-jp?B?dWU4KzNJMld3ZXUrVjhHWTd2QjNaV3pnMlcxUGc5a3NjMUFhWXBOZVFW?=
 =?iso-2022-jp?B?WDdvVFBsTmdxenliblhxT0ZPeFl4RDJFT3ZQUEJ4N1ozSWdES2t2WWJw?=
 =?iso-2022-jp?B?bFFNUHl5OHRpL0FaanpkZWVoVlQyblVRZFhoRXVUYlZHbk1NUmkzUnZv?=
 =?iso-2022-jp?B?M0kvQ2pFOE1TYW4wOVB6eU9XTWhQRmUyaEFyTXpHYUhoTHROdklJbUQ4?=
 =?iso-2022-jp?B?S0swSnBJ?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR18MB4479960E52944B3CD1ABCF0CD3DB2SJ0PR18MB4479namp_"
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9edc99-36d7-487d-9b62-08def8e54de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 02:48:07.0608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbvb5MsM+XWP2oTN80Ps2O0l1qy5s1YUKxNVWYsPSNoXCQ85wyuZ4lFV7M088vXuDwnbAbKGC7HLWLI2fzNSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4438
Received-SPF: pass client-ip=52.101.43.136; envelope-from=kchiu@axiado.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--_000_SJ0PR18MB4479960E52944B3CD1ABCF0CD3DB2SJ0PR18MB4479namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for your help
________________________________
=1B$B4s7o<T=1B(B: Peter Maydell <peter.maydell@linaro.org>
=1B$B4s7oF|4|=1B(B: 2026=1B$BG/=1B(B8=1B$B7n=1B(B12=1B$BF|=1B(B =1B$B2<8a=
=1B(B 06:43
=1B$BZ@7o<T=1B(B: Kuan-Jui Chiu <kchiu@axiado.com>
=1B$BI{K\=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; philmd@oss.q=
ualcomm.com <philmd@oss.qualcomm.com>
=1B$B<g;]=1B(B: Re: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


On Mon, 10 Aug 2026 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 13 Jul 2026 at 08:31, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
> >
> > This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulat=
ion
> > The model for Axiado SoC AX3000 supports
> >   4 Cortex-A53 CPUs
> >   Arm Generic Interrupt Controller v3
> >   4 Cadence UARTs
> >   1 SDHCI controller with PHY
> >   8 Cadence GPIOs
>
> Thanks; I've applied this to target-arm.next ready for when
> the tree reopens for 11.2.
>
> I made a couple of minor fixes to save you doing another respin:
>
> (1) you can't use %lx in logging printf format strings for printing
> a variable of type 'hwaddr' (it isn't a "long" on all hosts, and
> this won't compile on some systems) -- you need HWADDR_PRIx . I
> fixed some cases of this in patches 2 and 4.
>
> (2) we don't require the "<public>" and "<private>" marker comments
> any more, so I removed them from patch 7.

I also found that an issue with the Kconfig info caused a build
failure when any non-arm target is enabled in configure. This
fixes it (and makes the kconfig match how we do other board
and SoC kconfig stanzas in hw/arm/Kconfig):

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d0ae131628..e22c34a2e1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -728,7 +728,6 @@ config ARMSSE

 config AXIADO_SOC
     bool
-    depends on ARM
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
@@ -739,4 +738,5 @@ config AXIADO_SOC
 config AXIADO_EVK
     bool
     default y
+    depends on TCG && ARM
     select AXIADO_SOC

so I am squashing that in accordingly.

-- PMM

--_000_SJ0PR18MB4479960E52944B3CD1ABCF0CD3DB2SJ0PR18MB4479namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks a lot for your help</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B4s7o<T=1B(B:</b> Peter May=
dell &lt;peter.maydell@linaro.org&gt;<br>
<b>=1B$B4s7oF|4|=1B(B:</b> 2026=1B$BG/=1B(B8=1B$B7n=1B(B12=1B$BF|=1B(B =1B$=
B2<8a=1B(B 06:43<br>
<b>=1B$BZ@7o<T=1B(B:</b> Kuan-Jui Chiu &lt;kchiu@axiado.com&gt;<br>
<b>=1B$BI{K\=1B(B:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;;=
 philmd@oss.qualcomm.com &lt;philmd@oss.qualcomm.com&gt;<br>
<b>=1B$B<g;]=1B(B:</b> Re: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK boa=
rd</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email originated from outside of the=
 organization. Do not click links or open attachments unless you recognize =
the sender and know the content is safe.<br>
<br>
<br>
On Mon, 10 Aug 2026 at 16:31, Peter Maydell &lt;peter.maydell@linaro.org&gt=
; wrote:<br>
&gt;<br>
&gt; On Mon, 13 Jul 2026 at 08:31, Kuan-Jui Chiu &lt;kchiu@axiado.com&gt; w=
rote:<br>
&gt; &gt;<br>
&gt; &gt; This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for =
emulation<br>
&gt; &gt; The model for Axiado SoC AX3000 supports<br>
&gt; &gt;&nbsp;&nbsp; 4 Cortex-A53 CPUs<br>
&gt; &gt;&nbsp;&nbsp; Arm Generic Interrupt Controller v3<br>
&gt; &gt;&nbsp;&nbsp; 4 Cadence UARTs<br>
&gt; &gt;&nbsp;&nbsp; 1 SDHCI controller with PHY<br>
&gt; &gt;&nbsp;&nbsp; 8 Cadence GPIOs<br>
&gt;<br>
&gt; Thanks; I've applied this to target-arm.next ready for when<br>
&gt; the tree reopens for 11.2.<br>
&gt;<br>
&gt; I made a couple of minor fixes to save you doing another respin:<br>
&gt;<br>
&gt; (1) you can't use %lx in logging printf format strings for printing<br=
>
&gt; a variable of type 'hwaddr' (it isn't a &quot;long&quot; on all hosts,=
 and<br>
&gt; this won't compile on some systems) -- you need HWADDR_PRIx . I<br>
&gt; fixed some cases of this in patches 2 and 4.<br>
&gt;<br>
&gt; (2) we don't require the &quot;&lt;public&gt;&quot; and &quot;&lt;priv=
ate&gt;&quot; marker comments<br>
&gt; any more, so I removed them from patch 7.<br>
<br>
I also found that an issue with the Kconfig info caused a build<br>
failure when any non-arm target is enabled in configure. This<br>
fixes it (and makes the kconfig match how we do other board<br>
and SoC kconfig stanzas in hw/arm/Kconfig):<br>
<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index d0ae131628..e22c34a2e1 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -728,7 +728,6 @@ config ARMSSE<br>
<br>
&nbsp;config AXIADO_SOC<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
-&nbsp;&nbsp;&nbsp; depends on ARM<br>
&nbsp;&nbsp;&nbsp;&nbsp; select ARM_GIC<br>
&nbsp;&nbsp;&nbsp;&nbsp; select CADENCE # UART<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AXIADO_CLK<br>
@@ -739,4 +738,5 @@ config AXIADO_SOC<br>
&nbsp;config AXIADO_EVK<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
&nbsp;&nbsp;&nbsp;&nbsp; default y<br>
+&nbsp;&nbsp;&nbsp; depends on TCG &amp;&amp; ARM<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AXIADO_SOC<br>
<br>
so I am squashing that in accordingly.<br>
<br>
-- PMM<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR18MB4479960E52944B3CD1ABCF0CD3DB2SJ0PR18MB4479namp_--

