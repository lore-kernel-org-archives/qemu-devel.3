Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E2606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=EXALT.ps header.i=@EXALT.ps header.a=rsa-sha256 header.s=selector2 header.b=DoDK+Txb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1hR-0002w2-KH; Thu, 19 Nov 2026 07:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mohammad.Odeh@EXALT.ps>)
 id 1xTxpV-00027O-Fw; Thu, 19 Nov 2026 03:49:17 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mohammad.Odeh@EXALT.ps>)
 id 1xTxpT-0002fO-9T; Thu, 19 Nov 2026 03:49:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXWaiPPhzrNiPAam4+4s5MGn30XWWM1x6/bRo/hb5XM0CR+Nae8bPfX8XI3Nin54Rcu1uezrmyjllU3cA/TXAsYzepieEW8+pZkDnwgjbbwFaShGWZsmakHk1z6sJHjCgS8q9sQOcVA5DGS5wNQNapdYGfvG2m2SdmbKmzymuk1s+A+FI7KNJIlKxzvRLjsGwu0F9RGbqttnVNapDAs+EWSgVGB9r14zb2JesT3XjWclmktWAcQ3Tdv5x1zbGyl3jXQ9swto9LKhvjRL2hO0c49+8kW3LGrtMNdlYOCI6VxEqSQg+EpTiY4W8Nv69B6IvvW+JGas+GsDHVQdZGJcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8l3nD1yC65Aiz9j8R+nH3eQO1m8/vhlvCW27L3doqQ=;
 b=rDTVirkyxgqT/TOlZXfRTQIq842aCEY3vgGWYxYx0l78vh7rMLY+TP6MHYqn0jjMhAL7dWuWV4xQeeMz4FJGca82EWzUJANZ7YZo+mSgG5oNZEWU1rRQXRQ/OSfkOPBa5zF8hRtp0j3xHmIJQn/8klTy9LFBnThOCv7Won2BjPQeNFR6CyahpGBh/WcpfPuorgessV7W/tbPl3d2fVRdbkgUyh5k9yEw9FhjJ+d3N09loZ3qUqbPf4r8vOo1jcngvZVEV3vAFIH1i2LkRIytLPARJTsvtpDyFonFlQQh9KzWrEW3xIw6TLpGhicPSdRcR+D4K5BNdDxrglmSjuo7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exalt.ps; dmarc=pass action=none header.from=exalt.ps;
 dkim=pass header.d=exalt.ps; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=EXALT.ps; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8l3nD1yC65Aiz9j8R+nH3eQO1m8/vhlvCW27L3doqQ=;
 b=DoDK+TxbwBRApNG9jm67ma2ifIgskbrX9eICDsYQPIi4WXgnjxEWd7J3nFDxTD2WRU7CtxU16yXdw8fQrgCgx01G2RsdoQ0Ia3bBkHTJmp3HgB4Wk/4sGAKUwegXzimgG176EhV7cKFVPJpYOC0KhXVloDiPeXPRpvhgZacupOHW4FU7ClSwO2KSH81++F+/EfdOoKVf8Z4jBwQQKp8EM2bF/0HkuZyH13uxGQvA5Pgg66tZupbeSGiStOzcNaX1qpOMDrnFIny+M8KnBUtdkJzv/p6d5OIdc6kSJ59Kz3yTln60uZNQM3ziWWT8Z/klR0a0IT4+SQhdnLURKHiTuA==
Received: from KUYPR02MB9572.apcprd02.prod.outlook.com (2603:1096:d10:8e::13)
 by KL1PR02MB7430.apcprd02.prod.outlook.com (2603:1096:820:117::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 08:49:04 +0000
Received: from KUYPR02MB9572.apcprd02.prod.outlook.com
 ([fe80::74ac:ec2e:1920:2a0d]) by KUYPR02MB9572.apcprd02.prod.outlook.com
 ([fe80::74ac:ec2e:1920:2a0d%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 08:49:04 +0000
From: Mohammad Odeh <Mohammad.Odeh@EXALT.ps>
To: Samuel Tardieu <sam@rfc1149.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexandre Iooss
 <erdnaxe@crans.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Markus
 Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma
 <gaurav.sharma_7@nxp.com>, Jan Kiszka <jan.kiszka@web.de>, Bin Meng
 <bin.meng@processmission.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
Thread-Topic: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
Thread-Index: AQHddCSS89hM2ct8vE2pTrPFBsC76rc1GY80
Date: Thu, 19 Nov 2026 08:49:04 +0000
Message-ID: <KUYPR02MB9572B8DF47187FC6F82DC5CF95792@KUYPR02MB9572.apcprd02.prod.outlook.com>
References: <179449578952.8382.2790865629085512841-3@git.sr.ht>
 <87eccnzofc.fsf@rfc1149.net>
In-Reply-To: <87eccnzofc.fsf@rfc1149.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=EXALT.ps;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR02MB9572:EE_|KL1PR02MB7430:EE_
x-ms-office365-filtering-correlation-id: a1baeb8c-5ca6-4b2c-f469-08df4619f73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|8096899003|4143699003|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: KL2XsaD+blAr5G1QOclFawZyi6zGhI4wG7azw/NNDtBSlhawV+lql4O+BOUjAi8cwHJH5i2YdjDfh9WDrjTly3ruM+dAs6+/ymZG+pO3No/a6KbpzB6io9WmJLfmPjSf6Y7IOBClAa0Zwc2US+7mRyp+Hc9YiN6f9KtDxc3MWZClgzLyhVHGqa5RQEorQ/J6r+1mbZTg0YK7/S2+5dxOAhGGIzZAwZlw8i7o/xDtIZEMzXw1D5rOqtnUqpBvYLtzMuGldZ6BWWxJBGHFNJg4iw+3ehQIzjVhAho/eOqDummU8tXgTtEONCU10bpGNMz02mNLXyuQmF3KhnjKeVM3Z7bSq0aSbCQiv5XulJpdzQoL/GBJUN4gA4nBBU7z0snFRs+54LdSsri0YwG7Kly0WqQ189J/Qe7Jzxs4xkbBTODoF18DLHkyclvzzwNIUhGK3jclfjLS9NvuxVbAqIBctUo2xRgbvvOIduG8bXzjaq/YdDeScIQT2fL6AxWiB2GrflKHetfL8K6LYp/9/zDTfALNEn/XACobEXs6cy3KPd0LXZHT0ugXRUdMzDOIYfgqs/MIbWvQ3jtq7MaVhvmMtvP75qxifLfLYY23dsfRjkK1ewfBeNqE05iyLaiPIoUcv1AYCj9ytqYFNgZ5eW48L8qN1nJWZljlAU2bnBEtEEf4m3ktXwQM8bGbS+EQPnxL8pqf3iyB4KNg6CSlPi/duXQm3eQk7oceFs/cnlsGtaA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR02MB9572.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(8096899003)(4143699003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?28MwNchtoYeqfZl5bR/nLu0Qdu12YZfkbjdXbR9gmm0zBu0w4bzXBewuJm?=
 =?iso-8859-1?Q?TpdgePmKU6OQ7uEeRUGDmeRhOV96PAtbBPtP9y89lpVcWxjh4KGc3MLwHS?=
 =?iso-8859-1?Q?rgTQA5Og+24IMdHEKmIzqPyeZf5ovnCxKZqvXOw9H2vgW1CFlHH9fdSyl1?=
 =?iso-8859-1?Q?M8QM8sGQ2qlruMRxrXPAgp2WrzEcnVGsFxRw11JuaR9/eFZDY8t1ZPCjZu?=
 =?iso-8859-1?Q?CgWhovTyZRTcNfQSkz0EB26F4P/4a937csdC7Yinnq8WycttpAvjWzRhQO?=
 =?iso-8859-1?Q?UG6qdSbgT0UGn/k1S0PLXy5fZpdRqJF8ZlAgNbgdwkKUwRM4bwQL+FryUa?=
 =?iso-8859-1?Q?3WwdDNIWFXmtZTTueQhxdqdXrijqsfA1yBv3GQl/x+duShpvg9ApGe0L4F?=
 =?iso-8859-1?Q?Zu6B07ZDikUE3aU0MfN9gOSrthrf5RdSXn/RTGlaRlH7AbUi9qa/oVezrG?=
 =?iso-8859-1?Q?iG7CDNlazFI8dLTFFL/HsPFMb5n6trrDJWOTkgdSjnJUdCP1vBSIy9c/S7?=
 =?iso-8859-1?Q?xgjLYIFpi3TdDmMxru2SysolptdJpjMfYh1jWd/KVsRMAdavXb5Lqr7Sdn?=
 =?iso-8859-1?Q?tsoxm4wL9wlY6gHwRB+IMKNsoyiM+OCAZHMhOmOJ1eEV4HQZSPHGTjzL6A?=
 =?iso-8859-1?Q?dUH6r2wIrdyMJbYw86M/Bh6iT0hKRff8CPGRK1gELndJYV3QYsqlbtxxab?=
 =?iso-8859-1?Q?QiyTuN7cYEpa6jcmkPhHhyu3U/SmWgsLOUAZh9udIykQmUZvtSqbQA7fX7?=
 =?iso-8859-1?Q?7pG496PT3RuKoTNPjwhcc+q5vwaiFhv/1Oirz45Ns2/8pBXWGju7GxdE73?=
 =?iso-8859-1?Q?3kvqa5wN7Pwh56OZCp0xlBPDSsZ1NNpTMyb9hlwnwMMyZDUjQ7ScN8QI+9?=
 =?iso-8859-1?Q?PrZyA6KV5KVGSzT5mtTX5hRgzwcRsSnk20kMyROUKu7x6SKjN7TlM+o5Nj?=
 =?iso-8859-1?Q?6gmYTSEfk4oVYWNQol+KPRQ/6H9t6lLLfc7ZqkyYXz9y+iPeRf5O8PF1YE?=
 =?iso-8859-1?Q?PAhTW5/8pGS3dMOUScshiqkSskmFoW4ZL/BqjIp4Rc/Mb/Os5xeuU6yW3h?=
 =?iso-8859-1?Q?q7WbCObs3JYKheA0oAiR6VETFCI+knVrdqGqKr+BzQl+3GgQzatmnOeb6m?=
 =?iso-8859-1?Q?Q4RKBbq4mU471HD1F4AWWPlFGU5mL+nyaKBvwu8MlsetPEIVIH1jYQoPhG?=
 =?iso-8859-1?Q?laaNnh+K15OKYgLis/YjVDCVMrcTT2KulNsBFIONrduWGDD7Ne1km6NclJ?=
 =?iso-8859-1?Q?g8wROslwCGo61dRaVZIftsMUsIxJzjvhcIf8FbziMQDxNNPfU8mc0z7L1j?=
 =?iso-8859-1?Q?aq7em4TfDQD3nCIBCxvwXBL09xPVcjrdtctzRB2PPmMP57iNq5UgqA8mEh?=
 =?iso-8859-1?Q?0YSRLO6XlUes/8IAJOtrKx1slWTK4qh4SBPcV4FBRfk0L01y6PDuM+fGVc?=
 =?iso-8859-1?Q?FucCw4S+7mrtoKKjgGJ/wA7ij/9BPR4Dh5qYzOk/amdX/LSXwD3iEXgv9+?=
 =?iso-8859-1?Q?0iRhP5T1NnSwpyb8NzG7h+w2Brk7VOa13tk89xFXT02mQjTiESUcPZumBD?=
 =?iso-8859-1?Q?in20tRhjFR55+98hQalFLrPKlTKQbiCQNctXBaEr71j1eiCk4aWsy7jNW5?=
 =?iso-8859-1?Q?IKUE0OwL+nSvgRIBw1SM6yh4QlecddQiYD7JCM1u+/6U0nnYJY6dvPD38l?=
 =?iso-8859-1?Q?ALN6UNZm6EL6ZIC4++D+pJC/nrSHDDvbaAnOqCBup39Y4TcqwuLmrSUN+r?=
 =?iso-8859-1?Q?wedgJM9KjRxZoHybrU6sWLo/9+p2BEhUEMNsRASRRnDN4Z?=
Content-Type: multipart/alternative;
 boundary="_000_KUYPR02MB9572B8DF47187FC6F82DC5CF95792KUYPR02MB9572apcp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: EXALT.ps
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR02MB9572.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1baeb8c-5ca6-4b2c-f469-08df4619f73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 08:49:04.5327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7029a63c-976b-4a14-8112-90d649146372
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpenXZuxbS92z4RyiG6pxVswjgVEE7JU8xmMHQ0Rh2E04EPGwBsEN7UoIDg+ryJ5+bkKocuLU6ligxi19N0VdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7430
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=Mohammad.Odeh@EXALT.ps;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:57:12 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_KUYPR02MB9572B8DF47187FC6F82DC5CF95792KUYPR02MB9572apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Samuel
Would it make sense to rename the shared model to stm32l4_soc and make L4x5=
 and L496 sibling variants under it?

Regards,
Mohamad
________________________________
From: Samuel Tardieu <sam@rfc1149.net>
Sent: Saturday, November 14, 2026 12:40 PM
To: Mohammad Odeh <Mohammad.Odeh@EXALT.ps>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Alexandre Iooss <erdnaxe=
@crans.org>; Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Peter Ma=
ydell <peter.maydell@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Alis=
tair Francis <alistair@alistair23.me>; Kevin Wolf <kwolf@redhat.com>; Hanna=
 Reitz <hreitz@redhat.com>; Fabiano Rosas <farosas@suse.de>; Laurent Vivier=
 <lvivier@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>; =
Markus Armbruster <armbru@redhat.com>; C=E9dric Le Goater <clg@redhat.com>;=
 Bernhard Beschow <shentey@gmail.com>; Gaurav Sharma <gaurav.sharma_7@nxp.c=
om>; Jan Kiszka <jan.kiszka@web.de>; Bin Meng <bin.meng@processmission.com>=
; Shameer Kolothum <skolothumtho@nvidia.com>; Jamin Lin <jamin_lin@aspeedte=
ch.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>; qemu-arm@nongnu=
.org <qemu-arm@nongnu.org>; qemu-block@nongnu.org <qemu-block@nongnu.org>
Subject: Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine

~mohammadodeh <mohammadodeh@git.sr.ht> writes:

> Introduce the STM32L496xG SoC variant with its flash and SRAM sizes.

It is a bit strange to include it inside `stm32l4x5_soc.c` when it doesn't =
match the description. Maybe the name of the file should be changed to refl=
ect that it also cover the 4x6 SOCs?

Also, the STM32L496xx SOC has an alias for the SRAM2 at address 0x2004_0000=
 (in order to get a contiguously addressable SRAM1+SRAM2 memory area). This=
 alias seems to be absent from the code, as it was not needed for the STM32=
L4x5 SOCs which have no such feature.

Best.

  Sam
--
Samuel Tardieu

--_000_KUYPR02MB9572B8DF47187FC6F82DC5CF95792KUYPR02MB9572apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks, Samuel</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Would it make sense to rename the shared model to <code>stm32l4_soc</code> =
and make L4x5 and L496 sibling variants under it?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Mohamad</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Samuel Tardieu &lt;sa=
m@rfc1149.net&gt;<br>
<b>Sent:</b> Saturday, November 14, 2026 12:40 PM<br>
<b>To:</b> Mohammad Odeh &lt;Mohammad.Odeh@EXALT.ps&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alexandre I=
ooss &lt;erdnaxe@crans.org&gt;; Pierrick Bouvier &lt;pierrick.bouvier@oss.q=
ualcomm.com&gt;; Peter Maydell &lt;peter.maydell@linaro.org&gt;; Paolo Bonz=
ini &lt;pbonzini@redhat.com&gt;; Alistair Francis &lt;alistair@alistair23.m=
e&gt;;
 Kevin Wolf &lt;kwolf@redhat.com&gt;; Hanna Reitz &lt;hreitz@redhat.com&gt;=
; Fabiano Rosas &lt;farosas@suse.de&gt;; Laurent Vivier &lt;lvivier@redhat.=
com&gt;; Philippe Mathieu-Daud=E9 &lt;philmd@oss.qualcomm.com&gt;; Markus A=
rmbruster &lt;armbru@redhat.com&gt;; C=E9dric Le Goater &lt;clg@redhat.com&=
gt;;
 Bernhard Beschow &lt;shentey@gmail.com&gt;; Gaurav Sharma &lt;gaurav.sharm=
a_7@nxp.com&gt;; Jan Kiszka &lt;jan.kiszka@web.de&gt;; Bin Meng &lt;bin.men=
g@processmission.com&gt;; Shameer Kolothum &lt;skolothumtho@nvidia.com&gt;;=
 Jamin Lin &lt;jamin_lin@aspeedtech.com&gt;; Marc-Andr=E9 Lureau &lt;marcan=
dre.lureau@redhat.com&gt;;
 qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt;; qemu-block@nongnu.org &lt=
;qemu-block@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">~mohammadodeh &lt;mohammadodeh@git.sr.ht&gt; write=
s:<br>
<br>
&gt; Introduce the STM32L496xG SoC variant with its flash and SRAM sizes.<b=
r>
<br>
It is a bit strange to include it inside `stm32l4x5_soc.c` when it doesn't =
match the description. Maybe the name of the file should be changed to refl=
ect that it also cover the 4x6 SOCs?<br>
<br>
Also, the STM32L496xx SOC has an alias for the SRAM2 at address 0x2004_0000=
 (in order to get a contiguously addressable SRAM1+SRAM2 memory area). This=
 alias seems to be absent from the code, as it was not needed for the STM32=
L4x5 SOCs which have no such feature.<br>
<br>
Best.<br>
<br>
&nbsp; Sam<br>
-- <br>
Samuel Tardieu<br>
</div>
</span></font></div>
</body>
</html>

--_000_KUYPR02MB9572B8DF47187FC6F82DC5CF95792KUYPR02MB9572apcp_--

