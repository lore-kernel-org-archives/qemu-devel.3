Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD10AEFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6G-0001hK-J7; Tue, 24 Feb 2026 00:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6E-0001g6-II; Tue, 24 Feb 2026 00:36:46 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6C-0001J8-Q4; Tue, 24 Feb 2026 00:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH+zfLSFfegIZcyKQDSJCQTNV46dSOgjbaRV7fwhs7du8Ptwbd24zwAdkav8+ZkYQPQ6IdRsEOw+yUgocesAF/Ppj89g2h9/kZGpcYIwSaWJgvceIPGV56aqrU96C9zCyn1P7cFvrK3Y8U2UNbPImCP7hAwkLjq9+BP36d54zb25hsQsB/n01ypQGguoCEkPkZZpBTj76srYCl2ZR5H06UuZH5okRnVBeFo0+AJ/ZTh0RJDppYBgu7Y68gwiRFuge4190iL4Mr6fxi34Qpra/2sVlrXtnx2xzMnuXOou1y3CfoqeZWj2GNInyITGZBJ89M7WTH6qbqdwT+/YMW5gHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=WTOkopsQ5rqGFiePY7TbjvQd7N0Sf3MDh2gfF6ThYBp3FVbhRTUMANI1HTQm96bcRaiE2MQWHGB3Z8zwJqcGlflZbl0t9wKWD46FNviDibz80FtDpCu6WjNXY+0ifp/djgP7+1I82GOxxslOQ/0pgmWENHTH+iOwobm5f85G6eMa3o+NgiKw/+QUUtFFQWDFVl22ZjiKBOCBk4JZD9GRHmO1Fzgyb6ixDU3zmu/oyxrScqmlJKEjf98eyoy0uzSNUW0GSOvyMCA4Ym9O9foB11yaHvgn2YKzIn/PN0I9GKQB9FCY53+hpTLsjoO6DuKsY0G1voh3gYbybdY6LM0D8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=WPHaHuRmqzS5/6jBX+6zPwq8j+bo7tn9LZdLOSsYCS5rjvpKBtpiqMofQ2dLHV9P63BhEUUMUuZic8uMtX193YMFF/9PJveVr47uzGzBUIbCn3BweBMmKJvoQRdaxEpHsAsBva0sybyvA4IdlSXtfmzKXfTkLRBzkkgR7YkSrE2k3EIsqUjnLattmdbzjCaIGxKgG72Sx9QS6/CFqygP060zfIzxm6qABbVqRDW5nTUPz05LySuWHRzunFuftrBaxDx2aU/Y+KTg3B2dUMjmh7JWa3xXSObiJEXWf84ELkkpJTN+23SHnyiGwFmDqJbVPCzydWy+S/qNsZc/YTQjnA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH v6 12/22] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH v6 12/22] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHcpU+HZlF+lq1YFkWJkMc+lKNdPQ==
Date: Tue, 24 Feb 2026 05:36:31 +0000
Message-ID: <20260224053613.589102-13-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 47391198-02af-48ba-82cd-08de7366ab57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jnkqjUvYSiWPZteFcflsMj44t4ZbXewnOKHlURVqf1gJKQtrnE56nkfMC7?=
 =?iso-8859-1?Q?CWPF5F/Rfl1dkiTRqIyZNimjZb4RB+mtyugDqjemMc7TS28NPow1Hd7pUy?=
 =?iso-8859-1?Q?CX+u2pVZXLiyXMyPWQ5zucNx0B8FCM1BL79bX2Yo+S4OcOOSVmZcfZEnug?=
 =?iso-8859-1?Q?J+CwwC823GcxsmsWlLfixgxQmFgLl/nNWCOVzPEkH0mDlNTe45pVbmfIxC?=
 =?iso-8859-1?Q?jlSw/eWcktDYBN9mh6qoUtxLZFDdJJyzVXw+jUuR4SyD5ZazRtO75C8Jks?=
 =?iso-8859-1?Q?Z4TCzHrCq6YGl0iTncD2Y8ZjYpurIyXFedjGK/Un/L3MkLKWBHE/I2vVd1?=
 =?iso-8859-1?Q?TBAYFfCbR6an08wNOgbEvuIHGd25eQfHBbtjPe8M3kJoZuQg+EinVWLno6?=
 =?iso-8859-1?Q?uf4JFdfHEOnmYRS6zw74xQLiryjNrMUYET5Ood5KH/UDcDKnDYnW2TIFMr?=
 =?iso-8859-1?Q?DJqIMcIKcjYb7ejCl5CaZEFDjT1IFkgJpbnwlEtqNzCav0LmgpWLWQgUUx?=
 =?iso-8859-1?Q?UORaqYpG0acSRN9BcJVtgREiPtvUjc5IgfctFtOxXPJd7xuS81FmlaIZU4?=
 =?iso-8859-1?Q?LmLrtFzkS1dxPIseDIzsZOqvWOnvbsjFDgRkmcaf9zwysF2PbaBV64giCp?=
 =?iso-8859-1?Q?F4hu3hCXrTNVJHIzBdm1aAKwII3H8/K9yBPapfsn4aQ0gVwK5Iq4Bxyvbq?=
 =?iso-8859-1?Q?zXr1416hepCxnY57wmaQc2g7Kxi4W5zqGtIalu+GDETFifVpZkNpbFbIs1?=
 =?iso-8859-1?Q?Ec+tsyr8kmiqSIHjSVQXmZT0ZAbEAxOZXSjlc4gCK24T4RE+J5jmPhiWZP?=
 =?iso-8859-1?Q?XOBIBL8a3wDjZs1BaHCpYO/YIyExNLLSIyVDFopBZwmZy93S4IzYVsNFeQ?=
 =?iso-8859-1?Q?I2bypohWh04NGySI0l5bJ0na1B8A+h2NUichMvehkayrb4euGcjy0SHDj/?=
 =?iso-8859-1?Q?Vr4FPc7DASuObu8FuKdUi8p18G+Sa3u9Y7MV6+dxxd4k1T7UvyRMvRy71E?=
 =?iso-8859-1?Q?0eMiMCDmKz9F14oG5ZN0HRrLnXAubMWIOVASEmn6jayAPN/5SBkQqpGoA+?=
 =?iso-8859-1?Q?r4sq4Fj4AdPJQ3/SfgVtDT/ljAnbBcblFXqz81G/+IAHPWzMLRdWvZa10G?=
 =?iso-8859-1?Q?4Ys/0B2cBh6U0B9P1BJLXmKJjL7oUNfwpBJR46JW8QljvXeCBfJOK81jLT?=
 =?iso-8859-1?Q?tHUT9VelPbuvXTz7Pq8eFp8T2DfadRKQp2rSVgjGtDiqPAil5wJhpSkO/9?=
 =?iso-8859-1?Q?QOZ5bQkCm7y1a7s1DdhwmlVRC7qg9Ir2c8GLH4QR3i+z1FfiRqbVFeVf2M?=
 =?iso-8859-1?Q?lwOrkS+I5Vo9xNmRR9faXk7Ai2wjy7YSxunP9bxqn4oR/fcGqC1tJWYX8D?=
 =?iso-8859-1?Q?0UUIUCjgu5H6kAYzo/cmKR1ftSAqxuxT9jHmGd5guA8nnFVYDOzT/eIv2v?=
 =?iso-8859-1?Q?AzMNK5IHXuahvNs9w7LZcXI9dkOpxdIzwZdTgAM8G0v3SXff0YyGoJJQrh?=
 =?iso-8859-1?Q?dFzimy+dOKMFaZ7QnOSZzua+bgwVLrkPY8SxiHhP1CBSyD/lg1REenrFNx?=
 =?iso-8859-1?Q?BPBSvHN164iKKu1pYUE+WKY8LaexCbgXDFLh9ZmoN5x9bma5WDLPRzWcPs?=
 =?iso-8859-1?Q?UyIiurZmVfXVLhJZmT9BqFWdV8a+N4m0cljSJ50V7c1Fk1sNwQ3U3YbwxK?=
 =?iso-8859-1?Q?+03VrXscPuvgh7/HJB4QnaUJ2R3DDIbtAxhDIkQT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BvbZig/PeJl7ZaVS3Dt9X1EBNrSj/ISklFu0IyPtuN9uUuJYmlGBjGnAsp?=
 =?iso-8859-1?Q?t7k9F/tGmZi2YhXFe0SCIMz1PyYP6PoEO9s9l9NiFTQYw3MSDPFxztwH61?=
 =?iso-8859-1?Q?3qxggk8/tjUt6Zg8q7zEImsAIqr/hp+hjJISQAfKdq4mwac8lMKShGhYyR?=
 =?iso-8859-1?Q?CZBm1UMwviHyrPid1/qhX6jGU8dC96IqxGTsWtsRiooSolSgu0gv/ssrFX?=
 =?iso-8859-1?Q?cDlI8supDAq8pA76BPJnTZmxf1PlAs3y5JdVQVoGqQYvIZj4Ka90dXwPpR?=
 =?iso-8859-1?Q?ZGrVWsNDf6483JEgM1OyVI7Z6lHBsqN2eEY7+3JqF/yJUOoaxrAS2Z41+y?=
 =?iso-8859-1?Q?zdq4zeUS+X/pI+tfSF9R7Yk00/0P1dQpywRtvhhnTHrwenZwV/opqzvSkK?=
 =?iso-8859-1?Q?li0qMiR6Rbp+Y3cQBZxn/aZMKEcybNFdmGakMe8R0qSDouV1VXBP68xQUI?=
 =?iso-8859-1?Q?ZNLQhAqiiorGVU+thiPBYKis+PfL/C0n/ilHdtGXhrZ1m5KBF5qIB8JzQ7?=
 =?iso-8859-1?Q?sg3cqDaaOap1su/yUKmmzy7oG/myFzcTEKaUUG1way1Co/zLlmoGgu/Srk?=
 =?iso-8859-1?Q?xVBfNwOCBIZwVUDiysUNpxOBZ1/eDFYE/c3i62zrXG6GZv/a3R4ku5TN0Q?=
 =?iso-8859-1?Q?w2hALPzRwlYCQZKdAPine4OlkWrz5HaA1YS3alF2P7bV6A/ma89rqLMzB7?=
 =?iso-8859-1?Q?P21/6PqYLbPpotJM/V0eeuDnWp1AlWlKVMSicHtIbHTg8kzt405t6Y0YO+?=
 =?iso-8859-1?Q?0M0DHcayzQ4NvTwdjrUU+Fee8Kow17Oe7lSyZ0INGpVXN72Qn57+56iZ0x?=
 =?iso-8859-1?Q?Ql0s4VJdZvvbF+VjxzM1n5aRnS1tMg1PlzFVdHAeSYb2X6zgE58e45ke0v?=
 =?iso-8859-1?Q?WgkwjqU+UKO/Yn+wh95vUuBB3tuA9sofH98LOXZbSoUjBZLnzm6jH17HdQ?=
 =?iso-8859-1?Q?jhfRwWSzVW4SAhMMWVvvFroVJG6BylCzwCzPG6Q/CYyyIO7XOo6rOsQWhi?=
 =?iso-8859-1?Q?NM2G0xt6QsLnFEismEkEeKHocCmgpxIMMJLvJkYuTNgwU2hoI+J2boBCvj?=
 =?iso-8859-1?Q?B9XLQ2QSQ705groKY9HVIGmarNDtojzyobi6phAeFP/ZZftiZ77JpgEwS8?=
 =?iso-8859-1?Q?G/vijEMbfi4VLZV3Sq3TFdPOcRRi5bURT2KIDItA8QUYsOR0srD02c+LkV?=
 =?iso-8859-1?Q?VSjdG9and1BvkriFQCY9dPfkbQLjYXA8msmFNZp6ScYw8bL4DJri+XMMb/?=
 =?iso-8859-1?Q?UvMlpuqLWducSw/OjXWLu0o32fzAASzwgo8/TtO9X6cW3B+nR89ntWVUJd?=
 =?iso-8859-1?Q?1M/NCXt0sXZmKdybAF9vCuWnU6CBPv/EBBuvsMx8LN1uYKnvVg1SLrhsOE?=
 =?iso-8859-1?Q?0KczHF7wTwge4gxmUI4SFEXOBAdKxCVOfvg0KiQ+F5CF4LuU97P0A17Tcv?=
 =?iso-8859-1?Q?Y0Jli6NyO554TWBw0HL96CkxQs9Zr1uKXt61COQmHmODM2jmoNc9YbdcmV?=
 =?iso-8859-1?Q?g5iIT3MBSvGaxlpa3GbdtG4HVZLNfeqNS5FBGLp95cL5KkVnGicqrG4oGH?=
 =?iso-8859-1?Q?WrKJ1nfnKT6xnSJ7DpZhbU1cC6Wi3E+0WRSPGn9MM+fUkKzdnb0mELdyh6?=
 =?iso-8859-1?Q?r/66SqBXlqkS583PiIlF4KDGYldY5Oyjq8FLRViYodd7UKxZpmd3sKqCJy?=
 =?iso-8859-1?Q?1o+xs/AvztH5Zg1gCjwQt8iebrfcSrWSCx1hC1oE2I/nRJ5i5E2xdyci/G?=
 =?iso-8859-1?Q?bVgveM4Oo0SLE2e5J+F4bi2fO/77CMpjjHRY5EJKgN85ejegTYbT3CvI96?=
 =?iso-8859-1?Q?rXUpzq79VQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47391198-02af-48ba-82cd-08de7366ab57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:31.7089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QBcY1Gw+fSxQvNBJd6WmzCLqnvyDAMExyWzO7XNv/Yt0cBWIi6+9IxgGIwvt2E2IMlMa9+NkeYx8zAodGpzgcpDux3voKdc+Rolu/GJP9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
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

Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Hao Wu <wuhaotsh@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 56 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7ca99fb87e..0b99c7edfb 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "trace.h"=0A=
+#include "hw/core/irq.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_update_irq(DWI3C *s)=0A=
+{=0A=
+    bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
+{=0A=
+    /* Only return the status whose corresponding EN bits are set. */=0A=
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */=0A=
+    val &=3D 0x3fe0;=0A=
+    s->regs[R_INTR_STATUS] &=3D ~val;=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_STATUS_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_SIGNAL_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */=
=0A=
+    s->regs[R_INTR_STATUS] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        value =3D dw_i3c_intr_status_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        dw_i3c_intr_status_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_STATUS_EN:=0A=
+        dw_i3c_intr_status_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_SIGNAL_EN:=0A=
+        dw_i3c_intr_signal_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_FORCE:=0A=
+        dw_i3c_intr_force_w(s, val32);=0A=
+        break;=0A=
     default:=0A=
         s->regs[addr] =3D val32;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

