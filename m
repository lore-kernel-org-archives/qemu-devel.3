Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B135EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6e-0001vh-TB; Tue, 24 Feb 2026 00:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6R-0001l9-RS; Tue, 24 Feb 2026 00:37:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6P-0001J8-DO; Tue, 24 Feb 2026 00:36:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R07fcl0Nc/CFhnP/uuI/0lg9yNbAH5T4wELpigyqcr8z/U5EXcM8R7xLZVo3fDSi0wDqkI0+20h69sffoTRrMLU7y6qofzUqlD4DlPzCjeOsJIj9wnGxRrD9LM0ZFVptJPWCLNqCWPmWk90yKuYPNebi2IgKvqyB5nVahCgXzkNj2OFNLZllOFuewblY1afbr7ewVUUys7sKRFV1dK50mOsd3NEg/Cl1momh4h+wYij2E4D3GAlNsbDhJD3TWf5Qo9TtyBGLSYqms73Y6MU0EJ118AYOqwKUxKOli8xukMWPI4S2yhle/t8/vKrWXTULa/c2vOveytJaROA+oefOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=qTTRnmcnDNirgquz3zocPW7rvVQO+ysvkk4Ak5a5LRRW1DWxAQWfXrDr+Hd/+CzBWXbLWwWoQyFZaAbKGrjwWAtZQnoAUjY1eFIpJO5Xk27qTR30LXkCT+vuyut5nlve3V/jwZmPqp4GH4ke4F5xomVFJwGVOyMQMduGCQimu1pllnLIL3jYlM0/mwhGxRMmUlX/tfHuTq0xRePNlbN5r7O5mFyIdoL+JTELnaIiIJ/1FH0fLfmjODD3RqBgpfXbSeb7ie5X34mGxqg9zob2dDCdeSZ9ZYqui5kby7q0DL8fMCiEKI7GB8duvns0jAYyYC8vZ91Rp8RJKcLHg63Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=cmI0Tq12RiyFmuwRUjBXY9MxUuMRPZzmw42tCr3IyaoMpc09q7E2TqikVy39bhmvGITkgp7ztNO+aJkU0DyAZ7DKejsilvq4j4A1kCORzUvY+6xnVDmokrpIbgB8GbnS3C/ozYq3mem56R/5VaH6qc3vpaze7VoE5yHOyJBa7kDVKjw6GkyH6qpQ9MFgnLcLX3XgTpfjEOZK//xq8WttIRBedUwvYWUPYM7BQpJdEjCFAxtpr5enwksrtxhNx1mKlX89DUV1xnycZ1NnpJ+UP0gFMMYU32xdcwCjelUrFAj9aIn6AG4JL5OJ7lIw/l4q3X0Rrlq8e0hVhiCVsnjrYA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:41 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 19/22] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH v6 19/22] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHcpU+N6oBpTJpa80Kz42Z6pYkjoA==
Date: Tue, 24 Feb 2026 05:36:41 +0000
Message-ID: <20260224053613.589102-20-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e37e921a-965f-49f7-a511-08de7366b07b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dyPgFRyranjuuDzoVPNJWXIHtERNCMYeqWJPE2HQVXPL+4bU1QAIrqlVCw?=
 =?iso-8859-1?Q?AnKKaPRiB30Vxfr3CC7dEm4zrngkG3P76DdvUfA3TMV6rMTAFrEiQrD3ow?=
 =?iso-8859-1?Q?VaiQ2Zhd12HqEM7wP/+LP7dZh3PP4Cxmif7QuKssZqDXmoMjvynOW+8Vgo?=
 =?iso-8859-1?Q?avGivc7+TFjLTD/0sjR0elYAqdIyQEkwLVYiI8lWAyhBQoLyNdGRjoXjBj?=
 =?iso-8859-1?Q?fCwOdx0mg9bbnM4q5NR9rS9OgQZmApSMEQbVQ/D2NzVzFZIUGXx58sZdEg?=
 =?iso-8859-1?Q?eWyvs6ZZwbhJTZ9AGp5xj2FohIQKtyPEpaC5jRy91pcHGaE4jRJN3qr6oG?=
 =?iso-8859-1?Q?h2oYTVeQPwTb9dkUZ53OrE+OyQWX1fOLeLKPU3WNSEyQWyPd0QmxB3OLdo?=
 =?iso-8859-1?Q?2OJKA5vJrgUzsZI5aPYUVxJwFjToeKOyuUZoNNSSycmtFuYG54XHHUD99H?=
 =?iso-8859-1?Q?u6s9sREKMap6aumtc3/ap/xIRIjCqyJ4/iWiQQZrHT8BDGuB8SRAdEkJWR?=
 =?iso-8859-1?Q?fau5eV7Y5CRP+iuBiVAVMtK6pvsAiJ4Ae0xXEkm8AzpXFaSfpYT8sLKhRB?=
 =?iso-8859-1?Q?CRioRy0bw/Myx+PWZtqok4sTD7MINCAYF7tu3a//aG4K4l7O3ENqqitGqJ?=
 =?iso-8859-1?Q?3vfScC4jVkfroa5wVDMIKUKZOQfZnY5VfUtyrDWWKprIwLeY45wvTmu3ra?=
 =?iso-8859-1?Q?+JbKWxx0efsRHdVvrMZXlrN0Pir+DU7Pz8vHx5ExeHHyhbpQTCSYl1GSJx?=
 =?iso-8859-1?Q?Ov7KB9bpOETc3D4rz/VxrXo15zJwSrUue4IzGQ1pJbFHEv/is7RuzM+5OZ?=
 =?iso-8859-1?Q?/7jvQjzjb25lXs4wkNiuOMB8ExXvHHzL0itGpSqknQMNvMAsNYMSI64Ap5?=
 =?iso-8859-1?Q?tvyvYIi6Vku2+R1RcEWuxhue6gm+Dz24NIO7dnXAhLj6JUuV69BzbdUpkH?=
 =?iso-8859-1?Q?M+q9gZ7h09sjkA7dkdRyMC0iu4PrQiJS68jv3f3QVoIUDVFXjsGuD8Qgpp?=
 =?iso-8859-1?Q?WsdLkhgCjs0mKQGC1Jg89iV3oyt1BUZ85Hufc021bAc3RfnlvA9ceXoKcO?=
 =?iso-8859-1?Q?SR1V0lN3DAf0ejgXSZyLOkL30TBvuhL0ELj5XLb5jEtaqB3a/lGTDaMFbW?=
 =?iso-8859-1?Q?vF+Uf9meRgDaMXQZ0VZrnDJk/XiRQAZSSCo60TMJXMJC8E9F26OsbkWy2g?=
 =?iso-8859-1?Q?UuAiVbI4fdfF3hjz+NDI+wU0w0bC1iFgAfQfnpWPQFLJkrZoH9tOO+8LHK?=
 =?iso-8859-1?Q?PEd0DFqGXm9Xhi3lXM8vkjBF37wT1DD+vNlj2XN0HcPRMGOcFM+jAurNwS?=
 =?iso-8859-1?Q?12R4CGvPU3N0erVGBnKf/S2EtqgFI/3hagZGgVHypWTsRqa4FmKkaIKlzw?=
 =?iso-8859-1?Q?tw0bTE+mAkH+TyCE+mbIAFmz3WLocYrtTAQSf3xfKg0ckHbMXPeyjuMwcp?=
 =?iso-8859-1?Q?42o7YErl+/U5pmcyBzzNhHoYEDxgiOZtKJgPFgUHZ1i9uz3UhLTrRdUtdK?=
 =?iso-8859-1?Q?djCyXma1zeOpBL1uioMU2oXt/SkKNq/z138cooEvxfBuyHlphFjDib6TTJ?=
 =?iso-8859-1?Q?4ovRM0pt384gQtI/Tq0ERQ8OHrMBqmib313WmhRaf5JpnM7eHyYkQ4IcR6?=
 =?iso-8859-1?Q?0lQI3C0RCS2M1lNkzR6n/Ui70/ySIcBcWNKHwnBbu7c5B5jeGqaoaSGpit?=
 =?iso-8859-1?Q?09EsvSsiLgUCQKdAr337EBZ87uImvId8XaNysTIf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RMs8w8KiI9+aOxVW6UVdrWRXHxBNBFvfUxy1SYUWtzkm5uhAkjEkQXxSW2?=
 =?iso-8859-1?Q?RQr2KDnXmyD5/vGpY0cqRSf52RA/SwADBwvhMcKEQQVDLvdaJlRvnYoKJO?=
 =?iso-8859-1?Q?fCdg/7hM+mxVW1rJP4QD2cm0jXDwNdMxX2Ia+vNKI3XZeKctG9TzXd4gUQ?=
 =?iso-8859-1?Q?fhm1n/sWJLSyBA0oiMuzIktxFZqBWL8he5nP8oEHBQ5siT198qDyT3fgXT?=
 =?iso-8859-1?Q?DzCxBH9fLoo7+3PPt1BQxk/ZU3GNa+yWeGhkY4AarbEnJsnD3P2hbFtGEs?=
 =?iso-8859-1?Q?ZuhLKsO4A6W/+HMrQnW4aCB8fKVrsnOE0L3qR5zMrhkEafmiBkZ8CVSBJK?=
 =?iso-8859-1?Q?0045ZjsxQRSGEuJxbQBPnMk5PKx00owjyGt6SpF3wBylHZogKA4lbSjxlF?=
 =?iso-8859-1?Q?9w/L6Y0oWGJz6C9cAmOPq8qH0iMISt6mJulx4R9QHILyGP5FF9hAmK2YEo?=
 =?iso-8859-1?Q?3x1ldUt0Rtw0DpciZs2zpmgwOHq882hdnkJ/V1kkC5WpeIDaz/1JvbczBu?=
 =?iso-8859-1?Q?K2c4Jg4lNpFduGZsUlVqUV2x5BpHGCza4r81XTXerILmWwyd6NygvjS3xF?=
 =?iso-8859-1?Q?kmwyIIAQNBjO8z7JdVtTRf5bBZAJiiZDi45dtZVkxRWcxLe/1LuiFvQ3wd?=
 =?iso-8859-1?Q?yNMnH12cv+Gm+saCqr1dibOdlXdXwyJ7Zp8n+5EXrZiicCblH5V/ywV0Ks?=
 =?iso-8859-1?Q?7gIzxKsPHdWFMakfo2ahJDDw3qIrmjkgH2I9zqNVmYa0TcLUKsTHaHyasp?=
 =?iso-8859-1?Q?m+APzWtJPQ4C4NZE8a6nvD5JF8ZpIaomuPKaQ5x2bQ1l5Q2yC87JHgh+RM?=
 =?iso-8859-1?Q?gq0xrFwlJk5drqO3qBz4N92SxTVcNnQfKSUAsA5F67fhtxp4qBjMp6BJJV?=
 =?iso-8859-1?Q?C4Wgs5Whe0fO4UAHuuxK4ypOAKbuxU2Um475zK90RKavh1YyHfVJSmgeze?=
 =?iso-8859-1?Q?wskvPAJvQV6yfKZd2ijKjACNahIEbduumQ2J4GsCoWcOZ1dEV4zkB0S448?=
 =?iso-8859-1?Q?0X1ohDW+x5w8G5+b5rMq7VoZfd17xt3H/YK3xSrRVIr7/1acNSBjoNIgfM?=
 =?iso-8859-1?Q?Ybve5J68FD6itZFwflV0iZNRJ6RH9vwY64s6Lm5dVNKAhbjzndDvFUrHQk?=
 =?iso-8859-1?Q?cWoMJ+p6oZMIE+g0csF7cgi05vXonbFdumsH9UPpjn8vaTwibjdgnhYxz5?=
 =?iso-8859-1?Q?SaOVxB5sbQ25tNphbw9nwm9AlLdCPRATWP9jQUiMYYTbyLerzNKYIbs8EY?=
 =?iso-8859-1?Q?EKIiqX34HsW9AWlroizq1iHbIj3Ii35MrqobEW4Wr+Kmc/8CU0RUr7hTEg?=
 =?iso-8859-1?Q?SXAEQFFwzu7YaHDVKmFZhYqpLtw8FAyi2WbpNQWWlTVjgIx4pKHJyrG8GN?=
 =?iso-8859-1?Q?WerDA28oSXpJQGHPsMHYJzdKkyH+X//uxi/CX9PtgJ8Bi2msqxJp/jRy8P?=
 =?iso-8859-1?Q?n9ivEXytGh1A/j4o9Ib/yN589kiKmU0xW8J6tUwCzfWEqSQnhEYoNHOATt?=
 =?iso-8859-1?Q?97Ut8NWtYHkyeNyQyzqT3ec0tLFqzt9FoSVWaIFqZpmNiSWmWc+FIljgo2?=
 =?iso-8859-1?Q?CIm2Ephu9/MbtuWjBZoiMQozQ2nF331e7nbBL4eRQnsTsPB5kXQn8bC/vx?=
 =?iso-8859-1?Q?UiCacwKhGKwAbkH32Dfv2VA9lbeQbVeflGec7N7O846Anv3SPJNL1ZX583?=
 =?iso-8859-1?Q?OVoe86Sl/0ourBl23JyR/qbVZjJG5dCyvAvhFJGJb7ovYCgq7WQDyL2aMp?=
 =?iso-8859-1?Q?3hnzZcm0Wcj5hk8Q+9UNcs9/LqGlrdzqz8vx1RQYMbHUaBiKS7sUjQcDmI?=
 =?iso-8859-1?Q?VfTkQ8uoag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37e921a-965f-49f7-a511-08de7366b07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:41.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCyIxAd9K7FmpsdcAOGW0RxiMw2VhT7btl+5UjmURXe9A8saU40s1V2cMOCbR+4u3fcmgYGinxFd0iPIAeQaJz1HzK6zj6R1J5EbwT6FPK8=
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

Allows us to attach the mock I3C target=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index d545ecd712..3396a32fd7 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -547,6 +547,7 @@ config ASPEED_SOC=0A=
     select I2C=0A=
     select I3C=0A=
     select DW_I3C=0A=
+    select I3C_DEVICES=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
-- =0A=
2.43.0=0A=

