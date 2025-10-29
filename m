Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3358CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mk-0007VT-IE; Wed, 29 Oct 2025 06:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mg-0007Ur-WC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:07 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mY-00020W-4P
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735118; x=1793271118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZclR//jzXFISwSdcjtVDEEz2+y6UNrGCLQTxutVBYKQ=;
 b=UvUreN1ioi17DRl/Ug3ePHStKjSNDCoFomiDmKNDd8AuKkY9MLJ43T+x
 M6maGJwbEHUc6xnqEvg4LPHuawsdtiAPK2T8g5c+CtRftlDGWqIeyYMl8
 B3rFDGBbP9cgJc78s7Qa7gPmoHbRrH1dnKFKut3zpIs+vDRdaLrXp6cJc
 kLYe+wyuInWhp51cuGUFP0ZDAxMuYJDcn3tnk44GFu7ttJ3xV0416u+KU
 NaMMX/ar+/oJG2nDYBwPRZXwj8rySxvGhkBKIOdXKIGJtpPzA0iqsAU2U
 y+OFUmxwyQKx4rCaiBuYycFc66m7wnwjo36IYR1hrNdHg2IzSpoQwyCQY w==;
X-CSE-ConnectionGUID: QcEHOtUhRT2CXJ6nZCTZ9g==
X-CSE-MsgGUID: hazPUfG4ScGuCPBoqEB5tA==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178952"
X-MGA-submission: =?us-ascii?q?MDFQiJeIm9Z6i0N0i4fHqIk+CAOjFmnX+8SWpl?=
 =?us-ascii?q?g1QFnDdhMCfPu2L+X4qkeyD9bYAsGlPX9bN9V0/1PBCuunqJfKdaqOWt?=
 =?us-ascii?q?P1iTG1k7Isu/lS3+Hs8RW8noLIVhiW56vvPeR4ZHizeqvrvB6dJbh19/?=
 =?us-ascii?q?DXwcDiv8Cd6yfgA5R3/pOepA=3D=3D?=
Received: from mail-northeuropeazon11011056.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.56])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZQdO9b/hmasL/lSq9Z3wstfw3abRJ5/EYXTWTR98DEBHxInEQy7NglwSq+Q+70sjtDk6XAD1kvAfWkX9xqANNT1z7wZQfrXDnYfcetsHyzp306Fdhx6Bmf6wrHEOC8473izZW6t+RmWeXKWDk3k5fttoxPY6Nc1my4D7A7au/OYwPApi7GAQ7cqTEXMjIPvIimC3zvjMDD/W4hgxWk4kQgIix0f62taCSieGe2iiXRuqSIVq5JTDuTf5ur6H6M/T92L5j4/PJvrxffx218cxmEnsUiQ2FAj2femN+IBEP/VDBOzz1U6rrFmMQ2jSm810MAdNIPXgUyD+mxfKL8Q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5H1MVnNqAvCkmx7q/z7G0hiwONEnQH40cOVODXjR2c=;
 b=wg1/i8cbm5CwGEcQ/jBVGAnYfwuQOn/vLW8THdhSorxhAYNpFSodklLnv6c85eSj2Yp3lYm+IXCBhiOFbuRGEL8I0cP8uMUMPAUnNnLxqHHXL5tHnJRHyCjsW38AB5lMjBsEZjw8rBmHV57v9P6pplLlRdiCSoMpNXMbRYe1G9A+oeCoe24vyjpr0M4D+7IkG16WC+bLqUzYDxqz+fFvW9kegI6YQv4mg88peINB9QkIPniP0PfdJKZa2XIfVSh/P2DkXVoQDti9jevrUMSMAYUWJeRmNHP8xvMWoN2wTXk1zEN0Fv6Ui2yyh9SkYoiqgiV+B+9mlbUyq9Nr7zyOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5H1MVnNqAvCkmx7q/z7G0hiwONEnQH40cOVODXjR2c=;
 b=R5Re88q5wMOJIA0ULEocB5AsnGck16DyEg04CVSY/bSxbfhFV94FLi70x71dCjk9gaCoaLqYTjXzoIjBMB5CM+/GRAyobajQv9gfNkZ/FpEVo4XxNMxTarEKIxpo27fY7Qy2erWMQg/X5RSkETQXj1g7WuxuQZOVUATIVDuAAhHR67L6f8O5JWmHZxx/1XyscxaY31wqP8wod8tt0YNFpt+CPjYFdpXX6Us4jCpy/2R6NVDAfhGakNG93P+pDjxYf20vGVHY/GV4s6pMgxUqWH/YMlVkO5D6m6U1HmJC74kF+/FXEqzldebhculTXOvtq9Y0ZqymgW+6R6/RJQA8yw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 4/7] pci: Block ATS requests when privileged mode is disabled
Thread-Topic: [PATCH 4/7] pci: Block ATS requests when privileged mode is
 disabled
Thread-Index: AQHcSMIDk1rPoaMwlki0oPrxz4icpg==
Date: Wed, 29 Oct 2025 10:51:44 +0000
Message-ID: <20251029105137.1097933-5-clement.mathieu--drif@eviden.com>
References: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB10962:EE_
x-ms-office365-filtering-correlation-id: 74c04ef9-6b04-4ee6-3e3d-08de16d9267c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WENz1S0iB5UbV+wZQx57ZLeJ/mbN2Q/ffxzhzzyajokpFejCh5TUU7BzgK?=
 =?iso-8859-1?Q?0wSmPHQPtPlqXNEegjm7/+ma5oFF8f5s29gpy4WErijUEipU6qKcWFNhJ4?=
 =?iso-8859-1?Q?gIAgKguTsNv/aLKvsmIaH76VCbW7kT+x71+Nv4O/mElKIdw87Eu1Ro8Yw2?=
 =?iso-8859-1?Q?vqAueWWHDPPg8QH+5Cyn/+Y3YQJsKv3QpOOLCS9SXM2pUqElTIoFu4kxSe?=
 =?iso-8859-1?Q?Nn4TL5nWcY6hdnkSHJaJ8PTSAH/lLcGDUUyewWazrrAHVinojdNP6Pm63T?=
 =?iso-8859-1?Q?gbGEwBsh17Ewrq8PeZPsyhUYGKS0VYyc9iNraf4GypBPCtejmNt6ImocJ1?=
 =?iso-8859-1?Q?guONnm4+FJj0E3ir6c5uzi1U8C8XK9gZ2Vb8hHIVVd8uSvww1A7WjpKXRh?=
 =?iso-8859-1?Q?Asu1b0+BL8+3guVwzQu4I5n37J8zPfeMo9bOZQMR0lhoIoQ9YnfpM7iFFn?=
 =?iso-8859-1?Q?gjKjACxu3tWQp04gG6Ha/kieV4EAT9W/ocgggKnh1Uz3n4KlPFyhlYPcdK?=
 =?iso-8859-1?Q?d3ho9x1xCQvxUBgW6SBYrik0VkwfcFpNKiIlJsZGaFFxD3H/BNJQyZeW7s?=
 =?iso-8859-1?Q?SzICQP8W/7XVr7bahrP9vpxNUP05LEJdnooBZRoSRVHH+sh35eKfzT4ywb?=
 =?iso-8859-1?Q?UDo5FJSV3eKmiR3S9hgONIPs29CZb6oBH5uNc/OyEqfEHpvXz/RqHSMOaD?=
 =?iso-8859-1?Q?ueMd+Cp/Efgg5sVmKi7RrWBu77beIQJ5TuQr5hgpchQG5JhIBhkiI8VKjJ?=
 =?iso-8859-1?Q?okXvxQ9gc7aHvdf9oClbtakKi++6FHtG7d7+TnF0opFdYclSlefgZeDNPI?=
 =?iso-8859-1?Q?znB7Ra6tiTSXt4AOgBwYRj8Mg1tDoEfkL2engzEIkxUZEMwCB8T5B4L6dj?=
 =?iso-8859-1?Q?NmYFL2vy3XdWAm+gcYr7hQ1svxmGwrFfBqOs3xqCQZff2hNGQP/S6XtCKC?=
 =?iso-8859-1?Q?iOYwKtEJi5jyIXPBo4ESsfiDLvtlvAl80rUlLgQdv7AqxheRMg1jm092eD?=
 =?iso-8859-1?Q?EIfnapI38MCgltVHSrcDsPrO6M3YF2l13GIHEX36hnuLkEUR/jgTEtmDjb?=
 =?iso-8859-1?Q?0YlR74482ojeP1fd/8hQuAdqb9dJZ1++1plgMVJnRUdrpkME2BRug2a4Sg?=
 =?iso-8859-1?Q?sym+sBp7u0OTpNWD+NYwaFXtH6XzzWBH/Gj8tTL50TJ+nCirNvSJNYw/Bz?=
 =?iso-8859-1?Q?c+qzapiY+x4VqViT2QuE0rq/My3bUOipU/gQgvgVSF3bfr1gj9zT5D0CKK?=
 =?iso-8859-1?Q?75LXc071WffPar5mOc+r4gFOH1VOoUNYiRlst5GxE1UsnDXgybrlF0AyDL?=
 =?iso-8859-1?Q?e1+ihXAHsw0CKYUuizu1sRvB/zNZQKjWDm9VfDRy6F1r56gni4sC/Aav1y?=
 =?iso-8859-1?Q?muU7AZcJxRY4ENE5CsHY9RsyeDjAX8pDpSIa+0TubyTQw7Vc8j3BiV1dBr?=
 =?iso-8859-1?Q?hetAd2O/nuXshLXEDlWPjQHnteIOehTXRT4Y4QvxfqYmV4PsykL8z73/Go?=
 =?iso-8859-1?Q?S5h4QJbUPqvV1iDyTNXdAp6TV4ffNTk6X8oudVa+fKOv4ioBeLicAiVLCX?=
 =?iso-8859-1?Q?MdVDUjL6YaJsPej/agamQcr7yR7K?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?51V0OgBRXf7xVoq0mL6jOaJClq6C33tu0UvVJVg2Z4W1cImrFhCf85iQWx?=
 =?iso-8859-1?Q?Q5Bw0Dej2vaciYKpEJAf9IoMJL6oA68MLrGOMFtFGwWKmNdxpe1o0RtCvp?=
 =?iso-8859-1?Q?2LDjtSRdy1ufVsiLPvmWz1pWjmq9cgfCHbwYcG7HCHduNFg8TL31X49tYY?=
 =?iso-8859-1?Q?FxH/Uo2P6cGDtGKPUy3S+I/1PXDmRldm9s1dPCoU826HQOjglnjFHwVPGY?=
 =?iso-8859-1?Q?Xb3mM1PLXs9bnZKgAfTfPigOZtyw+txkMf4XLWImVZ1BeL2rVLV2GIwRTG?=
 =?iso-8859-1?Q?v//ocNukJu4AESkEC6ti/yBQenzmn70BHnCCqlMgE0Decz9MMErLdii+Vm?=
 =?iso-8859-1?Q?SOcNirP2+Bkp9FZFyeJS5nIHDNw2Psw8ZCrv+Amu26z/jdCR+ecFR7a5kH?=
 =?iso-8859-1?Q?qLsLUMRdIT0CL+iu9srvsJeFl1fMWJ7uJrf9Z0b14L650kT/SeFb6DeC0B?=
 =?iso-8859-1?Q?qXwaZLX8eaNnrRb40hj43k/ltu5xznto235SazpvDyJNLENiuYb5a90cbD?=
 =?iso-8859-1?Q?YvjEcW9KdejTfBdXeruJz1Kn2vT8F6ddWzG0BvaSS64/8T4w1fVUH1tyA4?=
 =?iso-8859-1?Q?UkudoH79n6OfI3e6b6qMPR53dfFNOuh+60pZzc2eHnUm4PvqZ4Jbl6GJWv?=
 =?iso-8859-1?Q?iyj54+30Ngo7Z6hpbN0DfN3A7cdjs53/7qDv4ZEF8KzYC1Ci6eFf9q8sGi?=
 =?iso-8859-1?Q?YloCFxzlnUQuDL2alqLkQOL0EONxWsnUhzTeMgkXz6ML/7x+c5F69IebXe?=
 =?iso-8859-1?Q?81m7rjxTRO/M8sIHLUncYBNd6l7b3fqjh6YCK5YtAf796D5T8xwS9TwLai?=
 =?iso-8859-1?Q?NowPUzpykVtK1cBkZnB9cXwW2Dsw6LB6Zcb7cRbeW4Q3yu45jUpplyEBS2?=
 =?iso-8859-1?Q?CSrXdS3EgT21i6s2YTINoCi+7+hhn2kcR1ZBmcR7mg7xqssh9ToL6qugqc?=
 =?iso-8859-1?Q?StniLQCkc0RIe8RE994TxVBGvoFkmvKOjd9HNJzLv8cA1np9Wq6T+GJsGz?=
 =?iso-8859-1?Q?uBnthJofUQYzzmfDCcYMvUSmxT63vfJWPmICejluggr3JP+hqJoHpHaVnI?=
 =?iso-8859-1?Q?RUZeC6A5pm+NBfeBqf9ZKQ3UGebQMLcYJJr5HrKbSbAsg11PKvKkQhsY6S?=
 =?iso-8859-1?Q?lpWXgSx7Negw1b8fbCia1EUTjrBJyRm5mIJFdb/prrsdG2fRTB7tLqxiTN?=
 =?iso-8859-1?Q?7YlTmJ0a/FxretEfEMV0IGYkC7XHgrbQU56ofaYSzWpf45W0lLAA8b0ttZ?=
 =?iso-8859-1?Q?sBbuRhChex/TMBWFqFariL6vIxDaSdTq+G0+3oitzW5vhkXCEza4tkPjBd?=
 =?iso-8859-1?Q?NRS+CinFf6QeFnKxRHdtkGX0jaEq8N+FZj3XeeL87I3+2heQc9o/HtG/2y?=
 =?iso-8859-1?Q?iNpsqI4cFps6+VlCYaTaNrH9YuqCGY8UBDfQzlkXI5a2amc8QDXA4IvsvW?=
 =?iso-8859-1?Q?5LlR4ksqrVXtY1OzpWbzrHQc6mLDx+znQLc2gQd0fOom6birGVBErAlE0C?=
 =?iso-8859-1?Q?NECfi8mznzg6SqhLEqWs1hs6K3ZQLp5ZjKyf1jbkzUCDde2WZSWidve4X3?=
 =?iso-8859-1?Q?hdAP8gyqGmQ8DoWPJaoZymLYHPrR/XUuLb2xf0E94dd6FYr5xis4CYie3V?=
 =?iso-8859-1?Q?CRax/6Z+faEiq5UHf8iKPNFSk2mYdYi6PZEdAKP86KtHY06Sc+8T2hEiQa?=
 =?iso-8859-1?Q?DXZyzwdMGbaOwt7QMtA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c04ef9-6b04-4ee6-3e3d-08de16d9267c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:44.2097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBUJAWi4xCP/XetIBYZheuz0RIqYGlWYXyN7xeVP4fF4cm2GNCXpsAnkJoaKBdq88as91vsLMutuGZBHQHMQQpzSAjwxAFtekCL2vp4LRky0BR6nTRftJS3u9yCHzTwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10962
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index acc03fd470..3c304158ac 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3096,6 +3096,10 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, =
uint32_t pasid,
         return -EPERM;
     }
=20
+    if (priv_req && !pcie_pasid_priv_enabled(dev)) {
+        return -EPERM;
+    }
+
     pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
         return iommu_bus->iommu_ops->ats_request_translation(bus,
--=20
2.51.0

