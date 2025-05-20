Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71ABC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFh-00017C-L6; Tue, 20 May 2025 03:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFf-00016H-BR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:03 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFc-00025z-ME
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725540; x=1779261540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=atha23AoxYQ83V54XBJZXJ8hMTWneWI/sfIVSgoqwnc=;
 b=Gd61vzQ2iQejv1hYGEwLOEviydfJWSmvuJCtzXQnPOF5mN6UDFakGw2r
 XAmzjkNoIZ5AvwxAs6v7yxkRsmCROp/vs3QRJK+gwLoyN9VCNt+w9b1Q4
 Ad8YXmI6l/WaolxAcFyir8VXU+A8neQMoNyOOLrejBp1V0mhHhzNZq6sG
 sPUJ6R4HFIpUQmvHbmFfHHkvGXZicKy9TZWnk30sTO846u4HXJuWbhVvd
 Z/8fcRWD4Oy+bNjL60pq8pP8EtH9JIzwgxZwkGFgceJ3fjqF63s8nJJ3g
 iT1YTnyNBeNl2QKV+StZ0sQlXswLlakcw9pzGE7Fdf0/V3MmpRYNLVnBf A==;
X-CSE-ConnectionGUID: IfKHoLSjRPCnHuwYBHI16A==
X-CSE-MsgGUID: RBWFoJJKSK2G0ucLincg1Q==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37197191"
X-MGA-submission: =?us-ascii?q?MDHqhsSyHvEQWdE8wsl93yowGseZ+tqXaA22PV?=
 =?us-ascii?q?/3rTzazHldqTcg/7IpLKVFxlTHR0Xkj283uTFN8DB4YxTRLPsV4tKo6M?=
 =?us-ascii?q?vs+rA3Xw3wnfsoBluvNSZ6WEc6U2HUIbR8yaKMObNLAr+pbew3mZhktH?=
 =?us-ascii?q?7Hx5xvbYYQ39FODOQ52uaJkQ=3D=3D?=
Received: from mail-am6eur05on2086.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.86])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIOeOz/WczUF1yalB3bf6pEj0k57eC19vskgWIJXLUpvdJX3oWENcKZ/WwJjgjMimmQKt0q09lNm2cJkmkQGWe3FIz3WYaAD+nQ/N3nmXZ5cyYi85YoPK4dUMgaMMMAcFv3dysXoVAxPfw6ZVP624jOCxyx2Rw1RWeIFJS+8PDHIjiSMJiiCVnNhfCpSpW7/mBB0S+5A7dALXeYCqCJ/Em3VBF/dKy10Nqv3JtNnUZSVCZ98H+AeR3aRJmEHEiK0jIly5ieLuFWHWrnE8Z/XNgc/g8H8TcE3PKqRi9tdLEL46tZOJtnk2d0SAIDySRgMZqEdjy+DeZkF8Bt5n8r5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDCYHwdkWUdDoESw4n4SITtONSjN1nj73RlpMXRY+b4=;
 b=vtfyhZAVN11/YfVpHD7TzVRf2XUUzt7CRqeI5U5hRl6z+H52IxzIxRwZq8FFHAoC9Ec8Jk+zuqP6seCh8FpyJxDoAQsu3+dKZsLSkm/Nhnq4iyQtPqaizVDrJKgol2R2fmh5k4L5bZmnPqbCnBPvBN2bP9qcbrT1ppQeah38YvXt/4+08WfJHAsg/HBumCUtdY+1azIpw9wFuNEUZXpvbtzKH++e2/9OPGRtJ4cBUyar4KfM0/caE2YKAP+IF23tLCKqckBfOF0ZNmhnZFyAQS+9fesDUOBzeQeDN5gXxEM351SWQg378DS6Q8nuahcq95zNG1nk9NeRvzIM04qttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDCYHwdkWUdDoESw4n4SITtONSjN1nj73RlpMXRY+b4=;
 b=a8DTYUPB+h/19pBelASfLdFF+h7U8FmIrFXf1hmJl9faDVkYhu1GCqb7TJAMe3II/VdWlycfRwCsuVEyC2D+GFhveSlAowIz8xNZjTGGC2BimIcg8APxxNBOOIrW2rEfNfsi+y04Ag4txgOpL6WW3zPRR8cyS11Q190dvZcY3GNcfD6LxpcTwxnVa97W9usgWdF1FEsjfkGMhgqHJr6AxAqpsX9Rh4NJDkOdAk4+sUixFI8g5fj9QPYOKRnZYuHhSrdW1zUrmMP8uW9MezN06yeJCti9dQENqum5q2ij/mIMseHLTjtQsoxYT1ABFKZxIILOFYsyoL3vfttpDuqpTA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 05/11] pcie: Helper functions to check to check if PRI is
 enabled
Thread-Topic: [PATCH 05/11] pcie: Helper functions to check to check if PRI is
 enabled
Thread-Index: AQHbyVdzkprVx0ysDU6OsxuY2ra/vA==
Date: Tue, 20 May 2025 07:18:57 +0000
Message-ID: <20250520071823.764266-6-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10037:EE_
x-ms-office365-filtering-correlation-id: 65ac28d5-b825-4872-d254-08dd976e9601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HIqjmr1xU9fY/G8Zd1RI27F6uBVaytnOwBYRX9+MPTZFOJBjTR7vqrn6KP?=
 =?iso-8859-1?Q?EKV+YhSr7Nn9MWcU6WdAPbrIDRUv/vE/YMxPS2kHlELKoiL0q5+C/ye3Vw?=
 =?iso-8859-1?Q?g9FF1g1VchbI2xT38hD3YRqxVGil0LxfylrbjmOjC7vFvTXIqVhBdCvLTq?=
 =?iso-8859-1?Q?/Fbxh09h3+7a4mpj+aEBdYEYbqyZ4hfZXlWtShU7euSBhGHThMdwt9GF/k?=
 =?iso-8859-1?Q?ofemcL/AtZ+9KSMS3tzn4DuXaqNTQ5ryhqhl1MsTX2s+4PjwWZ2TJk1cJT?=
 =?iso-8859-1?Q?oP1tBVWUQwatU7iJgAeHaAtDqmrgPkCdIAOJoynh7tNwomZ+MgNfucVqti?=
 =?iso-8859-1?Q?NU8wSWEivaIWLyZaNs+fuUStrZJielGuW98Tjv6Oz4326v6Nc3MMt4FA+E?=
 =?iso-8859-1?Q?64RM4aI5bXcCoWAj48+3C7ntjL16831b0fYTFAbmk0xVfSxx57b4/O9xkZ?=
 =?iso-8859-1?Q?zj59IWWGVA6AWjqb5NLMpFTqfqLy7O2kyNRG2kOGaekf9n0T/0yelke+v/?=
 =?iso-8859-1?Q?amDCQ+XZffpMEwGt5ofkiFkH8Z12w/5xbPUQDldvWtplKkfdWabst1JCFd?=
 =?iso-8859-1?Q?thHwxOGFHdB8AsJvxevXkH9X7KDZTsQgcPOj+K0WLbh6kXx1ZWElFaw5Ml?=
 =?iso-8859-1?Q?4GxqRM6+3oLbucqepr7V27ClWNrnnwAp0BsxtplrGMecT0rtFak6UwyqXs?=
 =?iso-8859-1?Q?gVAL4wEPBZLSQ8gZWsbM/wADe1WJqwxamxtby+RNv1n5eizRvXotZufEpQ?=
 =?iso-8859-1?Q?BYJXoHDHML9UdCJVKmZG8+VQo3Abse/PaFYYqTe9zZ/pan7o/usKIvb/DN?=
 =?iso-8859-1?Q?azAowZFJZ6RScmgyy8AGFVbVsE4Gg799Pzp1vSXGkCGNnKfUjy6WaDMn8g?=
 =?iso-8859-1?Q?VKDkZ3t0tAHysNn4OgK+jZmlTEkiLYCv5hxKp9IKh5Z56yyE6aYP5pPHNl?=
 =?iso-8859-1?Q?eoERUgQb4/p2q0haDBZBUuvEFfN2lhFP24r8KCQH1AphQFCMlwlgTVVAm0?=
 =?iso-8859-1?Q?Iv1WV+7KQiPjCuzciqkugz2ip5JQw3r1uH2QaRiMA/AsQV84ldDM9u1bcf?=
 =?iso-8859-1?Q?xh4nRknP/D+Yqrsb+OZOo4y8m+hTm9wf/EFJLVc+zFX24EXJLI69iSCaHz?=
 =?iso-8859-1?Q?tLyowN/eYgyKtDggZcRoLM4mdbK3EWNilRk8GFRIyy0bLgskhVFBMwYs25?=
 =?iso-8859-1?Q?yudGEcTRbWTTBzyID8Sv4FwF8gS99PisXV5tM7wwNKw8vu8hP7HjBW5qJQ?=
 =?iso-8859-1?Q?XuAEHX4X3aY0QYRF3F5ZOY77wWUq/i4a2d8YGSZMU4t3wxBaX2lIvhalja?=
 =?iso-8859-1?Q?b7MpCRGMr7j3k83DmjaVETPeAVHoQ/jVc2mnWKElrp1CICxFkgLO6EMLdi?=
 =?iso-8859-1?Q?ZwXD0akwh2Icb+mISG9IuDyBSkgkfC71wG5lleY7GGsoYJ2EdB8KX1F0iF?=
 =?iso-8859-1?Q?h+UZusf9xeX9MtKC9GPyZ6NKJU5kaVMuMG3xIaYbN1UIzDuE+eO9onaWoz?=
 =?iso-8859-1?Q?qEfA0ItCePaagLWiugoUJXdH3Kuig2X60WBtlEAjJsZnNbSda/K09n/Sjm?=
 =?iso-8859-1?Q?09b6fJ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FMVpuDgwunKHVBsomukiCVWmiYjyQI1QcglbMac+pXpoQaS3YULy9zR94/?=
 =?iso-8859-1?Q?+kh2WxjiLZ5AZOvLurJxgNV5ZPi1AcZPH5o30HR1s2NGVK2h7+59aP2sOz?=
 =?iso-8859-1?Q?ZCecO6RTrVIhCtTFhRAvyGnIiZWCEfEBdbZM5+uJ4sIA01bRIqFQHZwBe7?=
 =?iso-8859-1?Q?8zgpY4KX312iQH+8HvcYxxHD8G3Tmvq6SQg4dxs7XXIM3oiXl6Vg7lFNSb?=
 =?iso-8859-1?Q?l0k/jjSjWrKKJxnHxo9KNkIi2Z6SApvPC7Cb6nWxEQnncIiqF3VDb8IbN9?=
 =?iso-8859-1?Q?AT/C/cdUpiPbVvOFwDKvbBl26HB5fu3uhu9GOvVG8yaI4U8ficlUWEc+TW?=
 =?iso-8859-1?Q?lAcNk9ilb2hYuc0zCgZZQLt/6snnyLiQVEJCvk/Y6z9QaMyQ649gtAy/MO?=
 =?iso-8859-1?Q?XaZkiu5OaAkir6kmS86QsuXEj7+AjgQHpBR4nvnsdvGsMEmK8bo8FJeTSg?=
 =?iso-8859-1?Q?ohS5oyktzXSMZrgiqlcIvN2smArNRikATvXTzX8W45jh0zhGA01oVZWebN?=
 =?iso-8859-1?Q?DV3O2DV7Ji1mgGe2aXN4HoflthHwGLSDi+7gAz/t5Sdu1or/V2ZbnRryaf?=
 =?iso-8859-1?Q?8FUgMqP6RMtuiVfbQiDxF/UbNW5KyPOtOZ/jYIw2xjuYd+Up6Eg0pIEacp?=
 =?iso-8859-1?Q?8FJP2PM7gtkhA9H9Wpe9WFk9rnPuC3DKIAIYDd6b8TYXl1DQWbxB4IA2vd?=
 =?iso-8859-1?Q?6WP8jZv8+0wgDGjWx/lkt9IRuNooMkRYwyiF1uxzkpcQyqfTjG9H01HrAS?=
 =?iso-8859-1?Q?is1aBCIovVkprdYsNR1QjONeva2xyonWzvI/t/Y3BdOxeewj+tBPiUU9oS?=
 =?iso-8859-1?Q?OtoJWq1JCYiQ6ZdOt+URWES2M/UCv5fKykjuoR+B60dQkNy80nXS/SGYBp?=
 =?iso-8859-1?Q?P0wuA3AlKQW9jmpc4C1K5GDv1MMubrvR9iqTbWk/BApX2kqwZ8aKwhy94Y?=
 =?iso-8859-1?Q?2JMIhmXb3CVhxJZOwkKbqO5e8WmN6xNU61eRuMmP1Zki5bObViciQhu+3s?=
 =?iso-8859-1?Q?7hIGp2h/0V3Ks/eVcluOAf7xh2JkKObuFgcyNPSa1eymXhDcSCU6ga7G3F?=
 =?iso-8859-1?Q?yA4Q1ihd8ZrqMIWMxwVZ2kcLNeeZajTMz0+uNxhIBMjOTYNeQA8PyKIwN+?=
 =?iso-8859-1?Q?c3kcY/UREX/Tqie9NR3gMKzMqmuMb7VhrMo7SckVezcVncz2WAn1R9y3/h?=
 =?iso-8859-1?Q?1yVb/Jjp7GQ8sSR6pFnkKHt7f/DG1AcO2eXIS7aVi9phbaegTxZQIpMASI?=
 =?iso-8859-1?Q?TLd+xpY33kdu3hPHU8KhsnC6M5p4SK/vL1G5z1pM8lA0mC37TT9MvJ3QlS?=
 =?iso-8859-1?Q?opUDEZ+gO3yBUL/VzQDMEdlbndSoq5IdenSylh45ltEDoQLos/NSfgAlNC?=
 =?iso-8859-1?Q?2f3hN5I0g3wci8rx5jB/4rwpy7TI16NHzZskd38ppdcN/I48O7RqMF64zi?=
 =?iso-8859-1?Q?qajr2wdU7kn+9hDL1BCJGlilZ6JJ6Uy3EW9SMenTfwUTr/wSA0h/v2Cykh?=
 =?iso-8859-1?Q?V3Z2qP5jTNaAgo1m8uG8SVx2KHl2cll2JfE6p8bkjTkSo2dlSaJXYwm+/6?=
 =?iso-8859-1?Q?xreJlzaPG7+utvJRN3hyaZt8sByxKfDibHTb5qmlMxXagg6qzfGAcCVnZJ?=
 =?iso-8859-1?Q?Pb6uOMcjvHROUSU9rsH8KDyGFn08W+Ws1tuU5nxRprVcGotsSLHcp7etBZ?=
 =?iso-8859-1?Q?dEn4DAE+ByEuWUKouUg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac28d5-b825-4872-d254-08dd976e9601
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:57.5258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhjuVzSqzNqjYhiYXhyOGEo3McqFHaKOngDWOrq1/Q4kDeDv83hncmTwGnH16fJZvseCHrw8W3nlPjG52n4iFmuccTGnpf0edGDTDvXfFof9sAUOXewcWJLor+GWYJyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

pri_enabled can be used to check whether the capability is present and
enabled on a PCIe device

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 542172b3fa..eaeb68894e 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1266,6 +1266,15 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, =
uint32_t outstanding_pr_cap,
     dev->exp.pri_cap =3D offset;
 }
=20
+bool pcie_pri_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pri_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pri_cap + PCI_PRI_CTRL) &
+                PCI_PRI_CTRL_ENABLE) !=3D 0;
+}
+
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 17f06cd5d6..ff6ce08e13 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,6 +158,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_p=
r_cap,
                    bool prg_response_pasid_req);
=20
+bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.49.0

