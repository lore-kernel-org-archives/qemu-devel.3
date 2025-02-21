Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6489FC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4S-0004VL-Gh; Fri, 21 Feb 2025 03:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Q-0004Sf-8H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4O-0005im-Go
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125256; x=1771661256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZMxFNyn4oXeMGzshPyBmqXxSzbY8yZSu5H9uG1CqPCs=;
 b=fIvdF6ECJmFVn4PWxheAbzCYuz7/sw4iL9+CjEKHOkN+iYY8vZeG1U1J
 wftXyIDSx5M50VuWf8eoCUKAl9pRhouhbjNsffIrGN8xH2tcCVM8BhMLL
 QX4SfzQQiAocDLjFLsJHEYcZ8RrtRhOO6PbWUhikj7xJxG9jQtXHo0th2
 Sdnsu7sFDjXU1Pxi5jj1DrN00JinUUw+II6X9jG0K84xbxv2/MYeL+D1v
 Arzx+ygSsH3O8jxxqO2UYK7jUNylhlBv/aWyb9dOOKq10VROwadQsD2Gk
 d1ZPfF6BIWVfXxCNLRNOZQhPGI+5kpm5ylWoYajjdsvty6dpr6funx4Fp A==;
X-CSE-ConnectionGUID: 3LtoQZzoQT6ToRmd/HL5Yw==
X-CSE-MsgGUID: d+MCsQJPSdq0W6LgHjDkoQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836640"
X-MGA-submission: =?us-ascii?q?MDGn29/tOF6aBCGooyBxZBeQuD0Z3fgieZmr0D?=
 =?us-ascii?q?Hy0IIi9LuoryWX8wU9srOvR7ozM8lA8ZpWOtwnwq7lO8XuVfYqwMZ7cP?=
 =?us-ascii?q?j3cGrjGW8pMmMqBk6cbQCuLBQuG/xn3c9PsrUBeCanhuEHS9UPC3XDFj?=
 =?us-ascii?q?1Wx+Mpr+JxWwmL+4hio/swHQ=3D=3D?=
Received: from mail-db8eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:34 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC658r0biGLVw+aJmd7NBqjJs31Q+KH4IQrs4E19DakYn/NrKJEn5x7xwgWgnw+y+Gv78tguPFal9ikQ4sJQUVUStbH/UNgyAM78NrPK63W0sGN1plOjHWv8VA99qTnrnQJW2QQWaRO7bsjY7FwzMCcNESedWJFCjdYMBd+jy3pmMboZTvfAxbo+f85Oy0G4Nu5Gb9K61TCV5VhOepwQ/HRNIEGVQnIKSdoj45gi6VUFw4MVI3X29IwX//cI5I70TDkhhYOFG9oJiTcImr0aYaCbHG7veo3QQsUcUlhoEebUawzpAcNh2NzAiH07dJQQjrZdjGvW/y4HnYa1OXmVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoZrbtGYuHsZPQVh6qQr/BjRYamm9IIebfREKOYlZWw=;
 b=WPuNSfnDd+5AaTBhT8T6zPUEvGadY4f5Bw5GZBRKtP2E3M2v8xEJk+/Zwq9XYIhGbPaywbnRyMd0s5SMkaPUMu1TEVSc13MuqzF+IryHQ8KpDTW30sYYlohFBDY0EH7Dz0hzTn4unhQj2DFUe16TJ2l1Dk6fs7KrATbqLZP3Iy7HTf3Rj7WL3MFEna8yLkb7z4r21G6QUQ/6b2sSFdlkENJtKxBdrFLehR8XjyEhgWJGBVBrXNF7pqiLF7g+j9XyDO2lCJrfggnJkX9N1WAyxlPStOD9JHjOl066WUA1Ech2KG0NIM+RUHpig/0LjXQPz1l4EED0Pwr9FfVHp7wDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoZrbtGYuHsZPQVh6qQr/BjRYamm9IIebfREKOYlZWw=;
 b=KRdd1Ve2V47IMxawlj9R+8A0lEyRAQLooZGvCuFicv2sx3NtiCwKqo/w9j+BNMPupBEVHMNbDijN1XKNspLR9MMdjLEAcp2Ra6k3kybZnjo3qvcc9Msr4eIqzJkRoC+08UgobayTyPsCn90oGBgw4PeFP+7sLdnjtUWNsKtDK4WcokclXhrx0xsrCRZeq3GC8NZDiopCPjY0RAxoSof1pgEIJV5LvXHiGfN0pm+44knjuwedL2AwCng3weytPzj+vGz46m7Bzx/jRnqP8DlTzN4ephBLKEwLkaFh6JV7osYJqaysFjpzUWQBxnWFL/wO3YMRkqmy1zfh4kA5YL3OYw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 04/19] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Topic: [PATCH v3 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHbhDeo2oCEPdpJvU+FmhuYREVi+A==
Date: Fri, 21 Feb 2025 08:07:33 +0000
Message-ID: <20250221080331.186285-5-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 29c6638d-f168-496a-cf22-08dd524ecb7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YdZ7qN7yveVMAhxVf2x7F4R5ACCIlmgabJXlx21jZokbjKAi4lT8OFgpCC?=
 =?iso-8859-1?Q?GDqKsMyZXYcuYWDkh9b2SFVmjpopXU7slIYSwKab62CLrVQjeA9rQ1PKEo?=
 =?iso-8859-1?Q?5QpzjmtVSyyuhMx+MaE0Lc3m3eJx9HWfmPMPe5U+AiZJXK8ShS31KU9/kg?=
 =?iso-8859-1?Q?MfZtfBzIHhp1xf6jGaY5agJCPx7fWxYV44FQyzku3KAjMG6N2M+N5ct5Xh?=
 =?iso-8859-1?Q?1pvsc5DpdXYVu+Ey3vNdzPGBZ4UFdMpg3JvzlKsF+wH7sauEl4RNGboIQd?=
 =?iso-8859-1?Q?Fn5AWCUrAdTJQPpXXCMRbcnv9ifIfuI6aepgmm1QkD6TZmUBPDfLuCmSO6?=
 =?iso-8859-1?Q?JO8LSjzucG+b9vmSEQAXxMNsauvGuJyp0RtQDTzvX2XmksUNmkcGHgh14x?=
 =?iso-8859-1?Q?UqzXdXTiG2Ipf6K6jNRx5/Bhs2YHyt+t1JSFdtxWxLM1bX6fNxaHMNJOA0?=
 =?iso-8859-1?Q?vtNgioLIDSEVYXsJvfiP68usl4b8uQz64xjK9U9xVgahqE6Pp1f6RRe/in?=
 =?iso-8859-1?Q?M8CripQeGOCTNnm2Ih6RxAaRwLG1Ji4A2lqatrij9EyAaPIKRN2vJrLa4g?=
 =?iso-8859-1?Q?Yzq8QiGedd1dk5dzizhlxvAqmgDCUE079muITaPEBp5HcEQBiiWDaj/8fj?=
 =?iso-8859-1?Q?3adMPph34WG2t4SwOGIKCib2gDW4pbGUEeAAwxRVmGzwhBQ+le4TWfHhyz?=
 =?iso-8859-1?Q?PDT6Tk+46ztVlg40LvPXZQ+xanGrMU3/NJhzIAAdh0jJkFgd5PGnaetZaE?=
 =?iso-8859-1?Q?W4P7XMm37TffTRfDaCA46XUMFd3qN9noDXYPqPzKWc4EXDc9LGluTEgZSe?=
 =?iso-8859-1?Q?lE3y3QEb76j/8/+B0HqhyDPjVecp8/ra3ep0jG+ayUH76vZe9jK1DutgSO?=
 =?iso-8859-1?Q?LQGKLCDh0WXKSxsQc8/5l/Ql5nG62Wl/FF5P+Uchb+7LzOwTC6jThsJWsT?=
 =?iso-8859-1?Q?ZpdWuJfNAsy88z4juSSWFbzTa50cdy7Il/5xquPbAV5SsSHyuk4QUXyeUl?=
 =?iso-8859-1?Q?tEjtkEWC3hN7sNY93wAX3ns8iDRtuMEVBRR7HcBLOtKrgRpEREdAhpKpAz?=
 =?iso-8859-1?Q?GX2lWWF8pyvNliN7zcgBT8rIYxVDDR5tpA1h6o/exotMyEFSMLlVkDbaF/?=
 =?iso-8859-1?Q?Dd31A43kjKdZqSVooLS8L4HjS1EF09TKfvVXsnQtewgKQ32ebsBFBiZ8Qd?=
 =?iso-8859-1?Q?1iRCmLecHgWVUZpDHIJfFbMkXscL7jDV+f9tvYdGYuHwb42V13FvrYsr/j?=
 =?iso-8859-1?Q?9roecJXAPYP7RGBB8PI+jY+lMZvMu7JmPOdK3LcqHlCW2Y+pOsx3/nc33W?=
 =?iso-8859-1?Q?2bEHGe1SfgcuscwViDaHvfCdT+XiHE/rXG6JUZ7ujWB4kxgMSZZH772U6V?=
 =?iso-8859-1?Q?2xwr69OLk6ZHi5Ik2eF5Zhowjco9+Wu2WdILX3sLQBrTGdI0Oy4pTanYzi?=
 =?iso-8859-1?Q?unMPCBzv25Ux2WiC3A3FyGsN9yC2rCMooXpdsrblWanrEOkGTLdPwGFptZ?=
 =?iso-8859-1?Q?Rm22ggJQaCRFhY11F/7FJX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hj2eMN7OJOuppLfewyEwPabAm52qTa6CY6S1nHEIXtemr0LLvNJv11on5A?=
 =?iso-8859-1?Q?6kn+gVVSxFiYNkLjn0+8dka8CtZn2dmPZEkGv6KY3VndJoa8vuo6r516kS?=
 =?iso-8859-1?Q?jqV0zpfpmNtrSMJHgY7wUr/yyZcScwCX70Y++CxbjoVaoa+w3L526UDM0M?=
 =?iso-8859-1?Q?yYtZa7kZtsKId9+e4kDOgp81gvOcO2QH/P0eE8/LCpydd0YQrK8/vu7HfI?=
 =?iso-8859-1?Q?XjOWVkhePi2SsZ2stnYbiE/i+ZsGbSxng8zNKZnIvX+LzVkp6WfDqzQWaF?=
 =?iso-8859-1?Q?VJH0+qZU52xjXM/Llt/7L2/VVne64f8tpNcZNbum0yRxdA0q/Gl4d7qoLQ?=
 =?iso-8859-1?Q?TAQB+BoMwNMEQJKL9beM/TT9Erdw4jepHQwsOCfpYlxpAKZSQulWPW93hl?=
 =?iso-8859-1?Q?mrRn72Q7fFmvNwoFT66Swmcr8n9nCLslcrii6iZZSIk3lIDmyYjfHdC2FF?=
 =?iso-8859-1?Q?QvkUrHMiiu+rwPoIkV7IT7dilEAXVh3oDAAyIfD2JejDemTnokMGC+/+tu?=
 =?iso-8859-1?Q?6Lk/bKhjF4cDIa51RI/+OZiAMSfLO+ZZU3RfgXS2hcuncVUpEA4x7WgJds?=
 =?iso-8859-1?Q?4jbGQKExwF6Sd+N/JCfJQK1F4wxt5rd86o7mB0O/dXg3dVhSZMaDurHI3u?=
 =?iso-8859-1?Q?XqIBUHVu/36QYrLmp5mG0NBzBNRH02WRzF903ghNBKIDyxX30rHqkVxU2k?=
 =?iso-8859-1?Q?MHsjau1j7TdjMn1WQvfh02B32WCxTcXT3SCny1ZCN3q8yeDg4lE1guUuAa?=
 =?iso-8859-1?Q?NLyaQPwRTo5hvU3f+0zdagb2gowne4UIlRSRFAVzAKzCIrsfEQo+EIFLJQ?=
 =?iso-8859-1?Q?ekVY00Yp2O9LPCmTnIaAJVTp6uR3GN5z377Fy9RUqr/ejrqJBg7PoTTEmf?=
 =?iso-8859-1?Q?gfAxkTScggiFFe/0EX2vafQS1SWAuTA6bNgOyxRcoUv+dLMYb+nvyAXzez?=
 =?iso-8859-1?Q?RjEtn9fb0CDk5ipD/fGAhHo4UKVgYRGGxCvI97RP0Ms0m238wv/MUlUHe8?=
 =?iso-8859-1?Q?ov4jendUgnOS0zRHBIuPcU2MtRMK8U5eUwIJQA9Be8qagV7pCJk1C0v20S?=
 =?iso-8859-1?Q?19V8Q9ehmvkOh8muBWPrcfGjIh+SHmbbzCpKvYK52eEd4r2z/6DJKRIrd/?=
 =?iso-8859-1?Q?CQl5xQadk1pPIAzhns5Nz6lLztHEXI17ZaRuVxS9Lv0f8TfGFkAaHYSbAU?=
 =?iso-8859-1?Q?3s99fJgkeLfYRyUkY6vhGzVpEoiZ/80xNIT9b9Mn+3vQfQUYeiDrDwntLN?=
 =?iso-8859-1?Q?yPNQphBVJKNCVEYWfpUIlaT4gyV5+Oi1R5kYjAA+CEjRvPXWZqpSvM+EDV?=
 =?iso-8859-1?Q?TqzTJdPwEPDAXRKB2IaVEenqfedPxDT2JvmTPFgdHgn7eThEwZAZ2mSAKc?=
 =?iso-8859-1?Q?mTZllzFo/i5wOtBAwhZ286+fBnlkOPVVJP1qhovRb1xSmNmOpIObJlJm4W?=
 =?iso-8859-1?Q?J1qfiR2Crfk+yuHorCrJhtoPMHV0Ic6KBi/znPYATHgcfSngqSiNrX8+IG?=
 =?iso-8859-1?Q?5umQjazYwldd29Mf85LEa1u5Zgq79R9VNBVTtMgl+CLqQrx+VKHr21IAqV?=
 =?iso-8859-1?Q?UU6U46yhfOErkuynd7fe0kbNJI+bbrj+E9Ouht8QTnhX1tSYjVZe2X19QQ?=
 =?iso-8859-1?Q?J6MppAr1HZQK9dYZuYJ5c0k+tiTJ7jXUeHfSrlqCOu6cdB+xNmeh0n9Uk7?=
 =?iso-8859-1?Q?dXHv+9ZKpIoeu6F8QE4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c6638d-f168-496a-cf22-08dd524ecb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:33.1131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKt3QEIaX7kZGn3seez/KavFXwn65a3gXMStPBtcqpDXz5Vrsa4CxFIaQFDJqtDF9VSw5lC4er8cTDZ+8SDsHIhmuAixeQrMiNMmlywUcVWsIwrSi0gIJJihsmjn5kDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

PASID value must be used by devices as a key (or part of a key)
when populating their ATC with the IOTLB entries returned by the IOMMU.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1b4aaffedc..a360119fbe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2511,6 +2511,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOM=
MUState *s,
                         .translated_addr =3D 0,
                         .addr_mask =3D size - 1,
                         .perm =3D IOMMU_NONE,
+                        .pasid =3D vtd_as->pasid,
                     },
                 };
                 memory_region_notify_iommu(&vtd_as->iommu, 0, event);
@@ -3098,6 +3099,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace =
*vtd_dev_as,
     event.entry.iova =3D addr;
     event.entry.perm =3D IOMMU_NONE;
     event.entry.translated_addr =3D 0;
+    event.entry.pasid =3D vtd_dev_as->pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
=20
@@ -3680,6 +3682,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryR=
egion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb =3D {
         /* We'll fill in the rest later. */
         .target_as =3D &address_space_memory,
+        .pasid =3D vtd_as->pasid,
     };
     bool success;
=20
--=20
2.48.1

