Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DDEB594D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlg-00056w-Jy; Tue, 10 Feb 2026 21:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlW-00053z-UW; Tue, 10 Feb 2026 21:15:43 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlV-0001hz-HP; Tue, 10 Feb 2026 21:15:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YioJMyQ7/9f1fzmd4+obTx3C0w52x7amfR4XCGbGmrdcFI+q8bYAn0qW8EJpvpfmRA+/NXiS3Vg0dCWrN0t3OyR1ikEH3CtKq3Db1C3VgdcCeGvv6yJSrmxhCucbTQp5F22dvpsdjifLkLL8YiC536BpevqGGi+pQeeQfttvYJdtWFyXVLgqrrhJOyiVMhyiC/etaGqSbOciqoxctJK7SNF+D0jAO2ft/zPDNRV/1PRyNooifqv2/AxTRAnuqrb2eHnIWk4/SJakc7Qh686J66sOiNULymXK/TQvehW54EuWNoRpF0eqRW1RvkPm2IVgm8vyTkZfoNczEztPvDKZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5VSTSmvwbMRHZ/1Ev/cRZp8QygJ0KimtzOKbBYqEqE=;
 b=Gb6ISPNfGCCvTlV/JjAJCHbK+hjPHTb4k3ongn15uPhujXBTTucdXkCjj/Iya89Wus/OgJnKxp7U4Hq8tre9LvNGjdpnTEq8Kg8UfptEPph+Eb0u8Tp+dlYY0F/Tg3eRS9CbB4GCHTm9QlhBTLXwraXc2arrP05en6JuNyFKUvsfNoQB6bYn8nJtOwSl/SCXceHW0KRxuQ94j9WwcbMUhIQ91BEKDXN+NFR42Qfz1tsxCVyoM62xpkortQILYXPLlXsgKfw1c7Zm9rPPWGzZXfvrVJcqE3JV8sooz2DbHvmACieyqYTUFD3imjbelw6BoVmuV3/NHM81xKxxQek4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5VSTSmvwbMRHZ/1Ev/cRZp8QygJ0KimtzOKbBYqEqE=;
 b=lyP8b/QMjcFcAcuCKn3EbSV8BaSC+D71u1OvzTrl54vXMDMebvP5SpbGPZ1Llo3yvNCKemxlIQnMH9L0DLgNhWnBjLl5NEQUJp7Gq7EoetO1TSsmqIgaxszqMRiclQwv2xCkQ44AISnRZyLl1YUU0LbWTZeIQ9Eh2IlQClto7AMv5XWEHuxIPed5XTv+evT4E4yJ7DzvgCFiGLnhSn2IHQB93P5INe0Agx3UPaEz6/IJTXWJWhAX2OJpqO78wS47mRFs/RRaXITvjEXKZqcc0io+qv6hVKgMrA+pxjXCJ/iLa9PK36R4y2+BwmZ3pt0tXAKhByXMgc9Ng8WIp3K9Ng==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 02:15:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 04/11] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine
Thread-Topic: [PATCH v3 04/11] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
Thread-Index: AQHcmvxMFkC7ncGjoUe4yY3sOPMbWA==
Date: Wed, 11 Feb 2026 02:15:32 +0000
Message-ID: <20260211021527.119674-5-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6541:EE_
x-ms-office365-filtering-correlation-id: d9ec7e7e-5662-421c-03ae-08de69136f4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+tDlR5jFUPlXmGlMkwJZMh/86G05tciQ6jElF8mcKLQwhJK90iM/K95ch0?=
 =?iso-8859-1?Q?SHIAhXCmvHMSlrZp4Snrc6+sw5xTpFG9EjSbZxStTDPZ+x/Hn7jHw2w82F?=
 =?iso-8859-1?Q?DCtwK7+LjSQNRL+bsuzd8nPsq++i5ZrD6RsJDR8JhsWt5NMR6cer1Il49/?=
 =?iso-8859-1?Q?nRUuBCPJt9+ywzWLyq1DVgZq7ZV5nEqsYwjNAcQ07VQ09pzgpJ6WqXxY+V?=
 =?iso-8859-1?Q?Xcvt2B1Ir6jgdWuxHGuPcgRNyMrGVCzEecUMmaQMc8jp44zNCOnmcjzmnm?=
 =?iso-8859-1?Q?ohmExHdsB8HyiKE5RCFZfbPfOzFarx9qx6mMd0VR3FVwQA/018gEO+0oov?=
 =?iso-8859-1?Q?fSnZ7daycywhxnXQdBVwClv7i//Mvy48Asz52Q92XnHDYyPJAPobj4uVVi?=
 =?iso-8859-1?Q?eF6m9qlp0toZdZ4pYuVxJiq+QPYwmG3gQJToJl1lnB7E6hZ+TW/uOo1NTN?=
 =?iso-8859-1?Q?i6sgpriWhq2tdffl6rqX6leWsXiCIi6l9j11hUxaVZ8EBPTrrniPv1l6kj?=
 =?iso-8859-1?Q?dNu25bM1+xwgzR6ACu2p0zvueM0qsEfzrNLI8MP4V8s/dvimtRK2xp3nlV?=
 =?iso-8859-1?Q?A1yI4zLWMwBRQQnWFBNfyPGslaoV7Zp1dIH1Zef4uDLu9mzw2dc0srNlNM?=
 =?iso-8859-1?Q?44iyD/hc8E1uZ3so+h9+xEq3YF4QfDmkghgxYkD8E3WKGerrRj6LVsPi2s?=
 =?iso-8859-1?Q?A7yRjPY+oyMNTuV/UKnuGqvq0Q06R50GgV5YrWQ0ceD/mL3JSlD4nEshJv?=
 =?iso-8859-1?Q?c5AY0yIuW4ihW15oBTyaGOLvsUHOEbVs9hoT0QTnw3s3FyFJ4GLeUQT4dG?=
 =?iso-8859-1?Q?/+WC/p8PqDG3hJ7TZ2Dc1PPD20jRyzRTBzgf8p9Lcczl632extMpWPFL9U?=
 =?iso-8859-1?Q?xTABNRgRVHsRXHzliJhkZjWyxXPbitzLnsDUrMmONL1c9JnWm0s8IgqeiD?=
 =?iso-8859-1?Q?xPwU+hFpaUfDA+8HOUeADE7x7Up0YHpi/VaVOJQbw5InXUFGF1yUNF6uKv?=
 =?iso-8859-1?Q?JVvabc/elUn1WXpzQ94S72HjLvbeT3wpTRKiXgBtlNaNL0cPNLPBli99O4?=
 =?iso-8859-1?Q?v1IDK5Csxpr0cSTEtAesZSL4l7dYD/WgQUsjdnMOZsFlt/jAUK5AGiBvGz?=
 =?iso-8859-1?Q?z9pMfkIUEgWfgi/QcooAv9XM6EkocTZwdSfk3v1KjN92v7FP4fPvZN3/NY?=
 =?iso-8859-1?Q?jSFVrBgqvoAk4kpSxApG2+FIrNrH3TlyjjKj4nA+jltxXhDztxvEDSdUTY?=
 =?iso-8859-1?Q?tfS7o46E3O+KZi5swjyOZ9GvTV37czpeComLGGpqI6HG6oDj/7Pgk43eJ4?=
 =?iso-8859-1?Q?qS0MsDINCuVP70vws9aHwfmhQHD/rMCO3rpH5MmVFObRu1XNnF2YnUCCs1?=
 =?iso-8859-1?Q?W9Nb5FuLhgFNJrru+3Arr7MEG8v1alozE5gYVLUeAsl8SUs5qFrfRUPx0V?=
 =?iso-8859-1?Q?NfbS1HFmcnDxBY0wflVzhvUAjFTE++Do9YGss6YDTkG5Sq+TCUse23+Lp7?=
 =?iso-8859-1?Q?BtletHCPKcifMXHmZkexhyFOVNas3vd2WDEa+bME3vhc7JFssKreTEDfsq?=
 =?iso-8859-1?Q?NVz+MLWC7k1/kQHgt4zgFAQ90r/3utz3b7jBK/0zHFirtzubfRr2+5rrtu?=
 =?iso-8859-1?Q?xY4Wsu2ZBhyURsiv9+1Jq3qBAGWsZ1Asa0//CEMyZ+90uimgwMhYHYa0hf?=
 =?iso-8859-1?Q?E6JcEsdvTWHqev75uz+Fo+btruehdNargWiDtZMp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWI1ANkGPfv2/L+Q/YwE/1yFBLRDWpCHKUUYSnibV5m8zo4dSYbppVEl6u?=
 =?iso-8859-1?Q?M12zVfq9WRR7NE6pvkficDRIS1W86Rt8oElLjMUqP9yJKCCjDAOB/ql1XL?=
 =?iso-8859-1?Q?h9Yr/j+18IJRWWEQPqQ13ymd4Q8NnvBcZx+MpskKkgS22GI/dWu2lKQjUL?=
 =?iso-8859-1?Q?aYfwTsH0/PtPXIevnSh46vvAiYgeYl2AFXLaADhHlcVGxZmSqeusMAWQz+?=
 =?iso-8859-1?Q?ZFjOSzXgGmmxdS18Llms2PyQWDhF8orTscS9ll3UBAHGd8XeJQ07CfwX/A?=
 =?iso-8859-1?Q?O9odDsBWvZVhhDMUA3LVhNhp4Jp/4sJRygTjOfEskCWGELwvqAlAaXRZ0V?=
 =?iso-8859-1?Q?iQpGYqEfB0kwcl79I2aNu3qwYE7+eResQ5p0m+JEtG88TIQJUNCL+cXCZ8?=
 =?iso-8859-1?Q?iPvi+oFyPEUp+TtRkQIgdpYJTmnsCWOfU24ZVbGcFvIIuZBcWyEqRZ7tho?=
 =?iso-8859-1?Q?bkPz8Olts2iIvxxkVB71W58uFvjbp3juLLNZOG8jpYDwaWFdHVcKMOT8LD?=
 =?iso-8859-1?Q?QVPcla3YfZ3c2J3Bzz6waF00RdQ7c+EaCLXqcKO2/IWwBN+qDOVmjstYX3?=
 =?iso-8859-1?Q?Zi1bX3DyXHH4z/9Sy21E0NHSWFj7hB5xrI78Fx7WynXDv5UXfp0YExDEWx?=
 =?iso-8859-1?Q?sF0HapZfyVyH/2uu5vTOkScKkfQzP2pYTU/JWJ9RtroIqyQWV+dQKja8Q6?=
 =?iso-8859-1?Q?GyoYx4whE+gc61Ju11oS4ONBTeOyqzHwVk/ADxSK22WcWEibOf0l4UFiSd?=
 =?iso-8859-1?Q?6GFBIAi2TeW9FAqH2hbmMAu65u0INn9t/of2mxYcZZV/NSfs/7H7mMzdU8?=
 =?iso-8859-1?Q?Y84QnzOU3W2JPKBvdFvn4FDe2bxBtZkYVmKzIBA23U631g2K+2BtrIrN1b?=
 =?iso-8859-1?Q?0mZBgUbcx4/idm39HtXqi5KEdMnQskL+qU0Vnm2g+W8EABPOmSp2NWGi1A?=
 =?iso-8859-1?Q?xHC8E1jGthSjcyjsXq/1KUtWItUMX3MJMufsGaT4pOrY/4kSWVOadl0+Hp?=
 =?iso-8859-1?Q?OX/EJVlyWXz1pHEzPTU1CD2M2lez5rpVncylr/Ox8vDO92KJPJ3On30U7F?=
 =?iso-8859-1?Q?wJ+D+Dd9gLFYoRK3lR1es1qOJgNWQzTPHqMrcaOaz0//yV6eeyp3gFrFYT?=
 =?iso-8859-1?Q?EHMifZPnW7TfZjdFZh0m3edbnSp2OnNF1U3IR4xnNNwU70C9GuHbIvpnDC?=
 =?iso-8859-1?Q?MgYfNITfLUxJxagkj/PnIDvsCZrqVtLvv+n5PJew3vTexTwdgVG20yIRVi?=
 =?iso-8859-1?Q?QpQDBVb2M8ikUSqjQN8x5TwZBnNch8BPMyFdRJp3u8xbaoTOupzCuTxcWn?=
 =?iso-8859-1?Q?mqbcD+hVM6EAuIb/bP5bH16i+D5KYEkdVJN5N/AMvHkJyL090c6iU9/8Li?=
 =?iso-8859-1?Q?f/mYs0EXdgdi4MHm7lppDYHB4STaMJNajTP7PC9r3OXlb1zH84OHcDemAX?=
 =?iso-8859-1?Q?vbLyVLTLqxMp975g7xunMOcoEMULK4eButATDFMUCFikGhlT4ruJWJN5NB?=
 =?iso-8859-1?Q?YLvxZx+JfBRMRU8HpHwR+cODhgX/qYsfxCiAyana7ZVNEsWZy0bf8kIdL+?=
 =?iso-8859-1?Q?ZNDSgbZj50jNv8Uc/V91Py/YhC+xfj8SXhP1cgicCDyg7E7HdcOZtQ8Fj9?=
 =?iso-8859-1?Q?/ILJfv/jGkAFXDvwA3T72PbKHP2vNhlJcvreSb69qYkXgULL4T2jS62z8q?=
 =?iso-8859-1?Q?ZhRx0YFfsb2t+kjNKpeIro6GdheGUJ/PZpEs/DXdciMhUGwXUnhJHKSMh2?=
 =?iso-8859-1?Q?ltzuwxkfyGY5CS/C/XGA2oBmYh10k2+EFgJkDHAUP/6BcxLTDpBxNXhIFU?=
 =?iso-8859-1?Q?NCVuDvdC6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ec7e7e-5662-421c-03ae-08de69136f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:32.5436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H71e3Rqxi9Vc55/wPUGAVVhpc8fsJoX/7/1Q2RlRVpiy47zDTmRI0C0cALTrOy0cYh+78vLif56XwO6XkeB9Q+5xSS107KPTyp4KLVNmSow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541
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

Add a new AST2700 A2 EVB machine to model the newer A2 silicon.=0A=
=0A=
The ast2700a2-evb machine is largely identical to ast2700a1-evb.=0A=
The only difference is the default DRAM size, which is increased=0A=
to 2 GB.=0A=
=0A=
This change adds a dedicated ast2700a2-evb machine by copying the=0A=
existing ast2700a1-evb configuration and updating the DRAM size=0A=
accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0_evb.c | 27 +++++++++++++++++++++++++++=0A=
 1 file changed, 27 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c=0A=
index 31f7d61117..32d944848e 100644=0A=
--- a/hw/arm/aspeed_ast27x0_evb.c=0A=
+++ b/hw/arm/aspeed_ast27x0_evb.c=0A=
@@ -50,12 +50,39 @@ static void aspeed_machine_ast2700a1_evb_class_init(Obj=
ectClass *oc,=0A=
     aspeed_machine_class_init_cpus_defaults(mc);=0A=
 }=0A=
 =0A=
+static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,=0A=
+                                                    const void *data)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->desc =3D "Aspeed AST2700 A2 EVB (Cortex-A35)";=0A=
+    amc->soc_name  =3D "ast2700-a2";=0A=
+    amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
+    amc->hw_strap2 =3D AST2700_EVB_HW_STRAP2;=0A=
+    amc->fmc_model =3D "w25q01jvq";=0A=
+    amc->spi_model =3D "w25q512jv";=0A=
+    amc->num_cs    =3D 2;=0A=
+    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;=
=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    amc->i2c_init  =3D ast2700_evb_i2c_init;=0A=
+    amc->vbootrom =3D true;=0A=
+    mc->default_ram_size =3D 2 * GiB;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_ast27x0_evb_types[] =3D {=0A=
     {=0A=
         .name          =3D MACHINE_TYPE_NAME("ast2700a1-evb"),=0A=
         .parent        =3D TYPE_ASPEED_MACHINE,=0A=
         .class_init    =3D aspeed_machine_ast2700a1_evb_class_init,=0A=
         .interfaces    =3D aarch64_machine_interfaces,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D MACHINE_TYPE_NAME("ast2700a2-evb"),=0A=
+        .parent        =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init    =3D aspeed_machine_ast2700a2_evb_class_init,=0A=
+        .interfaces    =3D aarch64_machine_interfaces,=0A=
     }=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=

