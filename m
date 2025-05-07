Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF81C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 17:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCiha-0006I1-4e; Wed, 07 May 2025 13:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@percivaleng.com>)
 id 1uCi7L-00045G-Jl
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:59:36 -0400
Received: from mail-cy1usg02on0625.outbound.protection.office365.us
 ([2001:489a:2202:d::625] helo=USG02-CY1-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@percivaleng.com>)
 id 1uCi7I-0008Dr-3Y
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=VXIcmoz+UHMQgid5FbPmwHMQ3wi/mnn+3BRHV8mstLIFjA7uGgucG6ABiLj18jGK8d/xmocIn//wvZ3C2Teq7JcodBHbTlAqWs04xtpLnw2Q/mGrkMoeYQK1mItFJPDMfgrA4MkuHvyFaZRQcsDzM7a8r7dBqMWWQCf+15rWKvnVz81qiZefvyNx/USXldjHr8sWFi1yufjUKZyAmr8ENow6xVJQFYuVN/qIk84HmWiWXVE+AbmbZJ0gHhH0eXFBObbus8wfgxHteg2cTftUGxJH7u3+HM71JhbuxYzMATHkpi/wRvcSLWqatAN41/jxL0FFSj+vor3zzbR8MliOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5Y4GOTVPO/YESTsASBCwv0YSgTL5ZbXHPJmgBFiU0Q=;
 b=kQLvJJTrp/YH62qHJLvdNqSb2z9eTu1uKZIRL2VMkxMqXDdpn5KbKtIFKhxOTWHH+OeX0B3EqQWNxu21Zu1hz5wRaC5nctwfBmuSTHQcZO5ONyc65L/4QMvrExYVq5z1Qyp5yb5p5poWFfWIwluuawI0tIMEmh9kDmRF2lKPKCzRNuLTJtYobl8iTOg8WUiGFsP3DJYzlHUrycRebwkUZV7ewYsQoU3AGAmNPUPuUMPT/SUnTnpg9XBYkAQNNHWLsPGKEwsqV4F2v/VeT3py32V7TlKho/FT8TKyrfmncxWTeiJ9vBrB7puZm3K7qt66VEDOumJPZTGrH1Y0owFMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=percivaleng.com; dmarc=pass action=none
 header.from=percivaleng.com; dkim=pass header.d=percivaleng.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=percivaleng.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Y4GOTVPO/YESTsASBCwv0YSgTL5ZbXHPJmgBFiU0Q=;
 b=wIrN7v4PLSJ5m3J7I/j5vQZ+p+ZEcIfwhO+NQDS+EpXPqJ3YXX9KpEiJ7lRd7BOAwIQ/YbWHXBRG/OnXWL1giE9P98+CPw8Kj3xtzjnuLfy2JShkQbGtl/sHzamSQUaEUBO8lNoAQ3jrKyqv8l5kHr6srmXyI+rvYbYeDB4Nu7QzeUoVphun5eZN9kWnlFuc8pz/oJ3dW4DMF9AKcZ9OxMSxcLPy/PqisWgia7yCvtb+hQ/hLfaDycuY5kDxG7EOZ5m1kn8ZbGCNmuEd26oWk6IiTyvBwPNl+z8GZ0u2JjQFMyjafTC4ZSvW1iiku4xDx97v9nC6+axXpzhk9Um40g==
Received: from BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a5::20)
 by BNAP110MB1853.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 16:38:28 +0000
Received: from BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM
 ([fe80::8f4d:9507:41d6:8228]) by BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM
 ([fe80::8f4d:9507:41d6:8228%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 16:38:28 +0000
From: FOSS <foss@percivaleng.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue
Thread-Topic: [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue
Thread-Index: AQHbvTch5SU6vEjPVkKNr4843+odcLPHS/vw
Date: Wed, 7 May 2025 16:38:28 +0000
Message-ID: <BN0P110MB1882C48884953FCFBD6CA230C688A@BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=percivaleng.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB1882:EE_|BNAP110MB1853:EE_
x-ms-office365-filtering-correlation-id: f8ce66e1-e011-4475-9039-08dd8d859874
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?T73owzLknnmk6PQ44FNwHBjci0BMQBncomFY9UjIEXPxnCC/dP/Dnu51ubsr?=
 =?us-ascii?Q?rcCEMoEH+Qt1Al8KAt1c9lRhgnZgpFzWN9eUJVrB9MHcxYUizwlPXSthqmsO?=
 =?us-ascii?Q?vq/r8dk9Np6WZiyzv4yMS0yKLP8Ezpnj/0sqREMPLfjHevpHkuvJersAskUD?=
 =?us-ascii?Q?lJjIrqWQMdjJbtAUqLYQcMCTe3mHkYyajZfws7vuwxuI0boliRB6k4u0FZ6D?=
 =?us-ascii?Q?pbOVTXSwKvNqLuXsHGx/LddqmQ1aupukPIjjFnpScDxU+qVx2pzjhZAdgvZs?=
 =?us-ascii?Q?kWYHotubk8vODoTcNowS473VSV8uQOvkpnR3H+VvuxrJTZbYAxZcb3GUyL+C?=
 =?us-ascii?Q?mjWrLuj2NcGt1q+lo9EZ26yzMBfIoFVH7lGrzCytpVd5ZEqn8wYm7wgAxHJe?=
 =?us-ascii?Q?5MJaBVQde9xHjU+/6R1ZKpZ0NiYFS6IyJIh5ds+rO5mp4fmOQNzMHkbREx5Y?=
 =?us-ascii?Q?ARMHli4ghRoPi0GCiwpQZ7X32tmhzC72ZPahNfi0YRE08rgDjj9zMiEUE0zZ?=
 =?us-ascii?Q?UFbpc7ZeOXLfo8bNvEAUAAsM7D03btvbzp/a/x7re6iidWP40iT66kHBegRs?=
 =?us-ascii?Q?jk3F6ukb4imEw8I9HH8A64sS5279NHfCsduEG7KLKakwf3JESnoykZU1W2Bh?=
 =?us-ascii?Q?26sdIZHkWKd9roufgNlrH81g4U9vwyMHdMKdy09NOJLAdwJOiz9utUI0UeRX?=
 =?us-ascii?Q?YL+zpVbn756zfJreF3X9IkBeCX9KtJJbCd9i9q+R21uInqTG+j/FrI/i3Tgq?=
 =?us-ascii?Q?HX9x7BY3h30tg/OlBCKMYBYG8xHcBVQZOWKxowT/G/2A3d3TJfYU02fZZACY?=
 =?us-ascii?Q?603357jFwqqbo84EOdj8mjSEVAqiUPiRni8Ytc7JMC/GUaS+9Fd6ZNgCVBN2?=
 =?us-ascii?Q?FU4eBNfdoZkBhQN19Pk874vMSgPhwDaXhrXlDK9o5QCklkC4I8liqrLewf0j?=
 =?us-ascii?Q?pSeCP6Jf7XdoVgW0gl9QkEiE0WFWCE+iRm6rDwFSdtrqNIDGxXE28XWVfHLo?=
 =?us-ascii?Q?HD7oBTetn5p1kaF24IQO3bjSRlpxSKIPIWRSrvHdD60QskKSc6jBIiVEsGPb?=
 =?us-ascii?Q?1SqQOKiHaayios5xUXzgSeivbqaF+uP7oGCj3emJL3elBrKeZueb6GGsHbFw?=
 =?us-ascii?Q?nZ+ehggrXDEIIII0/t/x1CFph13psOaAzl00qZnZs3grsmANysCvoy+MBUlB?=
 =?us-ascii?Q?W3adqEbJfz1Ha7Vy3bQbFs9d1EPJ+b3Nj5xmGyc/blW7aeY6mvKHReaxbrap?=
 =?us-ascii?Q?92iihIt3C6KJMuGRrzkRQHM+1D2NPlsVr1ErKJn6wNmp+9BZjBuyw2+pMSJC?=
 =?us-ascii?Q?Sqsc/RlJwIxTWsm4zI8px8ku/l0nFzAnSo+ffEWJ7s8fXHhYLyx6psUxcj/W?=
 =?us-ascii?Q?cuklZoFmqtQ0eaf3rqjUE4W4siSGP6hnrIqiOIoKKKmjk4A+K4LD1dVpJ41p?=
 =?us-ascii?Q?nii26G/evY3aqMVlE57OddDO3s+izb4WZN22dj5UVs6I2CXlaI/3w/ThvgJM?=
 =?us-ascii?Q?mx1HLOo/8xfUY78=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(8096899003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sxcKabH7wHeKFTSVOZVyu6bAfQvTVkoGZEIVs9PLNwJtX20YJuacoJDPMenZ?=
 =?us-ascii?Q?Tvlx/VbCldBfwSFL56EixLW+tSTb7btjIxktHfRwzo/2dzWhDbrK5XDgrY5Y?=
 =?us-ascii?Q?BDrCMZL8kLSQmC5SJCvrbPaCvlkB6lSBJk4Uy5sfelUOCR8BXGrq/ygzbIQJ?=
 =?us-ascii?Q?uJxNp7EL3olXmOPqRXkKfLaKYZdLeuHMHTzs6wyYxs4EHLUyILTrfrEqNSoC?=
 =?us-ascii?Q?ZIuDCLBEkkc0Y3gBxCkHsZC67FX2iK95Ggu/bsw8TpzbwyEFXHvcCW8kNVIh?=
 =?us-ascii?Q?hP5JDCtC5gXLd69Jj41fsfNWrpwhADWEah+WjrKYLghFVvx7eD1N7ZTmHhAH?=
 =?us-ascii?Q?OppQv+JYy+oocwEC88R3nrDJfCRPWA/4tuUZRcCSpBn6DRgIbzx5IYefgxTP?=
 =?us-ascii?Q?4J9vEfz+14FKkv1NgWNAGNqPRjNWgH+YruGgV5ioxCrS82hjTHZ28kzh+cNG?=
 =?us-ascii?Q?DMXDLRS4s/pXQMoC71VDpNRnBrutrTkkmm9kRlJyaHFLX+uWVreAjudltcru?=
 =?us-ascii?Q?2MxfA+ns7HD7LVC50lmKHnVCNBuOsFbvlfraedw7SHw+KtSOSa/ZodG9oMyZ?=
 =?us-ascii?Q?4Dv3H80aVCorB+61TW+d1tPNJnDFJuyoZ/xCgjEy2MLgSd3MXMevobydSqGJ?=
 =?us-ascii?Q?CnVpj+r74rRbfGY9NuEkPDeJ3SEnFS1ur/AoDCBcPze89sx9dVo3TRs/8t+5?=
 =?us-ascii?Q?pEgCtczbIDC1BjixUsJUH2Bykqx2Oo++f37poA//foQW14kV/Y1J96T+GRaI?=
 =?us-ascii?Q?itzn9drowUDcIUawTd/oRrwX+4/TlYf8cmn7vQQxlBaT78p+hUnAVA48i2QL?=
 =?us-ascii?Q?Nk8lLm22MVl9/BKBWWkWrb6F6zMw1IWYMcoPHH6vIAPReTnqc8Sf3jAt1IoD?=
 =?us-ascii?Q?YTrqoZ9fQzifmtFCfWlM+zd/TfJyroIzACU195WKayv3COo8Ut8hQeiZ79ac?=
 =?us-ascii?Q?l/q62/6yBVrRM7L0BAs5G7GvK37OIDjlyyuUB+kQYktxwmPZmj1puTAbtHTp?=
 =?us-ascii?Q?XY9jVGKF2iusoJTSbVlXn7ztrpz80VgSwwPn2kKDryXxr/uNR5OHZYEAYn1U?=
 =?us-ascii?Q?E9sp17hWIFD9e1l5cwhIjeicz5e/2zujycxCcelj4YgbecxibijDhHc7qQnh?=
 =?us-ascii?Q?inSQUrdB0P8mSLoric4TGEJUqQG1c0h9kbMrvT8tYgUQs+dRIv0TIhfV7EPI?=
 =?us-ascii?Q?UX+R6NxA0Y03JGGNSgYX4V2sH2yS/ZqV/rBXqoZT1YlTlvd4I+ncG6quQ5M9?=
 =?us-ascii?Q?+PwT80zFdGwK2awHNNbBaxyKKNM9M/PpAOjPM5p3FulU7rgqa5ML32nR36Pe?=
 =?us-ascii?Q?vDf9IBUu6k887YRqjYCEzqATY0V2/luke987F/eP8vNhty/9ZUkpvhrszaJ5?=
 =?us-ascii?Q?AwC7Z15NJ4T+KLPzR03iXvLkZckZVnZDLEbOAr68Mq5zwjSnxtayUK5n7SGg?=
 =?us-ascii?Q?vw+OmP9OFrbRMBEmYAPsWfNxYqUEFMrKYJaaUYpIJIxTnCKfPrZEx1d+wTGI?=
 =?us-ascii?Q?zOdicRpZbCEBiKc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN0P110MB1882C48884953FCFBD6CA230C688ABN0P110MB1882NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: percivaleng.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB1882.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ce66e1-e011-4475-9039-08dd8d859874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 16:38:28.3895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e469936-b9c4-4e65-a905-faf8e5ffac80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BNAP110MB1853
Received-SPF: pass client-ip=2001:489a:2202:d::625;
 envelope-from=foss@percivaleng.com;
 helo=USG02-CY1-obe.outbound.protection.office365.us
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTTPS_HTTP_MISMATCH=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 May 2025 13:36:57 -0400
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

--_000_BN0P110MB1882C48884953FCFBD6CA230C688ABN0P110MB1882NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thank you for working on a fix for this! Should we include our functional t=
est as a patch to test for this in the future or do anything else to help w=
ith this?

-Percival Engineering
________________________________
From: Richard Henderson <richard.henderson@linaro.org>
Sent: Sunday, May 4, 2025 8:57 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: FOSS <foss@percivaleng.com>
Subject: [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue

[You don't often get email from richard.henderson@linaro.org. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]

As detailed in

https://usg02.safelinks.protection.office365.us/?url=3Dhttps%3A%2F%2Flore.k=
ernel.org%2Fqemu-devel%2F174595764300.3422.13156465553505851834-0%40git.sr.=
ht%2F&data=3D05%7C02%7Cfoss%40percivaleng.com%7Cbcd8ed34f3e342df86f008dd8b4=
e40b7%7C7e469936b9c44e65a905faf8e5ffac80%7C0%7C0%7C638819890414363571%7CUnk=
nown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z=
MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Di%2FTD9xTTxa4eRse=
MhadW%2FLw3hPMDp2sPDJF%2BzIzjfJw%3D&reserved=3D0<https://lore.kernel.org/qe=
mu-devel/174595764300.3422.13156465553505851834-0@git.sr.ht/>

there's an issue with an unaligned access that falls off
the end of the last page.  To solve this, we need to know
about the state of the cpu, so add a new target hook.

There are arguments to the hook that are currently unused,
but would appear to come in handy for AArch64 v9.5 FEAT_CPA2,
which we do not yet implement.


r~


Richard Henderson (12):
  accel/tcg: Add TCGCPUOps.pointer_wrap
  target: Use cpu_pointer_wrap_notreached for strict align targets
  target: Use cpu_pointer_wrap_uint32 for 32-bit targets
  target/arm: Fill in TCGCPUOps.pointer_wrap
  target/i386: Fill in TCGCPUOps.pointer_wrap
  target/loongarch: Fill in TCGCPUOps.pointer_wrap
  target/mips: Fill in TCGCPUOps.pointer_wrap
  target/ppc: Fill in TCGCPUOps.pointer_wrap
  target/riscv: Fill in TCGCPUOps.pointer_wrap
  target/s390x: Fill in TCGCPUOps.pointer_wrap
  target/sparc: Fill in TCGCPUOps.pointer_wrap
  accel/tcg: Assert TCGCPUOps.pointer_wrap is set

 include/accel/tcg/cpu-ops.h | 13 +++++++++++++
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/cputlb.c          | 22 ++++++++++++++++++++++
 target/alpha/cpu.c          |  1 +
 target/arm/cpu.c            | 24 ++++++++++++++++++++++++
 target/arm/tcg/cpu-v7m.c    |  1 +
 target/avr/cpu.c            |  6 ++++++
 target/hppa/cpu.c           |  1 +
 target/i386/tcg/tcg-cpu.c   |  7 +++++++
 target/loongarch/cpu.c      |  7 +++++++
 target/m68k/cpu.c           |  1 +
 target/microblaze/cpu.c     |  1 +
 target/mips/cpu.c           |  9 +++++++++
 target/openrisc/cpu.c       |  1 +
 target/ppc/cpu_init.c       |  7 +++++++
 target/riscv/tcg/tcg-cpu.c  | 26 ++++++++++++++++++++++++++
 target/rx/cpu.c             |  1 +
 target/s390x/cpu.c          |  9 +++++++++
 target/sh4/cpu.c            |  1 +
 target/sparc/cpu.c          | 13 +++++++++++++
 target/tricore/cpu.c        |  1 +
 target/xtensa/cpu.c         |  1 +
 22 files changed, 154 insertions(+)

--
2.43.0



This electronic message and any files transmitted with it contain confident=
ial and proprietary information, and is intended for use only by the person=
(s) to whom it is addressed. Any use, distribution, copying or disclosure t=
o any other person is strictly prohibited. If you have received this messag=
e in error, please notify the e-mail sender immediately, and delete the ori=
ginal message without making a copy.

--_000_BN0P110MB1882C48884953FCFBD6CA230C688ABN0P110MB1882NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you for working on a fix for this! Should we include our functional t=
est as a patch to test for this in the future or do anything else to help w=
ith this?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-Percival Engineering</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richard Henderson &lt=
;richard.henderson@linaro.org&gt;<br>
<b>Sent:</b> Sunday, May 4, 2025 8:57 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> FOSS &lt;foss@percivaleng.com&gt;<br>
<b>Subject:</b> [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping is=
sue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[You don't often get email from richard.henderson@=
linaro.org. Learn why this is important at
<a href=3D"https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/Le=
arnAboutSenderIdentification</a> ]<br>
<br>
As detailed in<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/174595764300.3422.13156465553=
505851834-0@git.sr.ht/">https://usg02.safelinks.protection.office365.us/?ur=
l=3Dhttps%3A%2F%2Flore.kernel.org%2Fqemu-devel%2F174595764300.3422.13156465=
553505851834-0%40git.sr.ht%2F&amp;data=3D05%7C02%7Cfoss%40percivaleng.com%7=
Cbcd8ed34f3e342df86f008dd8b4e40b7%7C7e469936b9c44e65a905faf8e5ffac80%7C0%7C=
0%7C638819890414363571%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi=
OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%=
7C&amp;sdata=3Di%2FTD9xTTxa4eRseMhadW%2FLw3hPMDp2sPDJF%2BzIzjfJw%3D&amp;res=
erved=3D0</a><br>
<br>
there's an issue with an unaligned access that falls off<br>
the end of the last page.&nbsp; To solve this, we need to know<br>
about the state of the cpu, so add a new target hook.<br>
<br>
There are arguments to the hook that are currently unused,<br>
but would appear to come in handy for AArch64 v9.5 FEAT_CPA2,<br>
which we do not yet implement.<br>
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (12):<br>
&nbsp; accel/tcg: Add TCGCPUOps.pointer_wrap<br>
&nbsp; target: Use cpu_pointer_wrap_notreached for strict align targets<br>
&nbsp; target: Use cpu_pointer_wrap_uint32 for 32-bit targets<br>
&nbsp; target/arm: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/i386: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/loongarch: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/mips: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/ppc: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/riscv: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/s390x: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; target/sparc: Fill in TCGCPUOps.pointer_wrap<br>
&nbsp; accel/tcg: Assert TCGCPUOps.pointer_wrap is set<br>
<br>
&nbsp;include/accel/tcg/cpu-ops.h | 13 +++++++++++++<br>
&nbsp;accel/tcg/cpu-exec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&nbsp;accel/tcg/cputlb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 22 ++++++++++++++++++++++<br>
&nbsp;target/alpha/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 1 +<br>
&nbsp;target/arm/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 24 ++++++++++++++++++++++++<br>
&nbsp;target/arm/tcg/cpu-v7m.c&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/avr/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 6 ++++++<br>
&nbsp;target/hppa/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/i386/tcg/tcg-cpu.c&nbsp;&nbsp; |&nbsp; 7 +++++++<br>
&nbsp;target/loongarch/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++++++=
+<br>
&nbsp;target/m68k/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/microblaze/cpu.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/mips/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 9 +++++++++<br>
&nbsp;target/openrisc/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +=
<br>
&nbsp;target/ppc/cpu_init.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +=
++++++<br>
&nbsp;target/riscv/tcg/tcg-cpu.c&nbsp; | 26 ++++++++++++++++++++++++++<br>
&nbsp;target/rx/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/s390x/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 9 +++++++++<br>
&nbsp;target/sh4/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;target/sparc/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 13 +++++++++++++<br>
&nbsp;target/tricore/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&nbsp;target/xtensa/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 1 +<br>
&nbsp;22 files changed, 154 insertions(+)<br>
<br>
--<br>
2.43.0<br>
<br>
</div>
</span></font></div>
&nbsp;
<div>
<p style=3D"color:red">This electronic message and any files transmitted wi=
th it contain confidential and proprietary information, and is intended for=
 use only by the person(s) to whom it is addressed. Any use, distribution, =
copying or disclosure to any other
 person is strictly prohibited. If you have received this message in error,=
 please notify the e-mail sender immediately, and delete the original messa=
ge without making a copy.</p>
</div>
</body>
</html>

--_000_BN0P110MB1882C48884953FCFBD6CA230C688ABN0P110MB1882NAMP_--

