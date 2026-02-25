Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB02F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OQ-0003jE-UB; Tue, 24 Feb 2026 21:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OP-0003i2-9m; Tue, 24 Feb 2026 21:12:49 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OM-0000T6-Dw; Tue, 24 Feb 2026 21:12:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qk8cabw4TyfKWjZpu7KHBwIgIvFCZiEY21RsVL+5drfQijTa6jOy1Q+LfRJytj7IB8eHyb2K89Q/5+68axViskWQn1hZY3f4tQYdjamH6WMpvGJJNCX6GWs/yObdAEJezum8ufq5a5gnDuiFyUjm1N1am0ogvXeZWa43OsspPpzXGCWZS0z9/8b+B2n1Pm8e5RzNeJFj/+e4qNEWzfee2IPYe6m86rSa/hCN5LjPkXGOoFKUh4rAAfqAlXnRTOo35/eAZFCm9dYtYcaKQjhsn9AVdxJDXkNTirkpzcxwG8g61gjqGgAxMgu68nIPGzllSxfPR5mq8j4YsjHqWdAn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=ZzJLoWOPmfptAHSQuo0Kd/x61ahX9aEhMCEqtI3M/q1WfjO2Pn9itZ4QJH9dU9H9NbFdPIQNRxtBfSOK6irIgYqnkKhPFdegzLvHVrf40CJbvH0zM60uYPFzFRUVnvcURgcy6rIjlEaAdfqRWl9o/7esce+4A8shd5dRqNuRvE/k70O0rJm+st7BEt73Bfk53Uyv/0lAulU3BqhERiMBnuT1LDESOtTcOhuEtoZc4qBlGsSmM5Mwq7ESJelmz0V6UpjhJ30izdwRFrJmv3po1ftUviLFgkxC9iOjOhOMFrFngBHTk3Up0Wm7J8RwTC8atXI9r0V2MKXmqC6QkaKeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=mOv7mZfK/uuQC5R4LHTnd2XAeK1ReIi9xUzMkteJYTIqoECdEax0/0tdQ5yNa2rms1bB9FzATdKCCPMkLzpkJ7QLVzKm+66iKrVW3K02OJWXjxcpd0i2FZPIEHTg/R2iF6UfQbotADnwqKHS5N9XOAk1gMOb+Q9fNk55N+OjmZMfxJo7NC4250CQHnfXYX8em7IX8/KaeM/XJcuXhy+j2MtAiHXXgdAlwxLJUs+QSOGg/UEes2ih9sf37Avyxa2q+ESusC25RcqBHpyPSFrjFqduepDk+jvqRAkiIJ2jM4ZBQeuxo/BYn4u+3K2N1P8nxULuHd3dvq+S2R6Uv1WHmw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5118.apcprd06.prod.outlook.com (2603:1096:101:38::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:36 +0000
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
 Venture <venture@google.com>
Subject: [PATCH v7 20/22] hw/i3c: Add hotplug support
Thread-Topic: [PATCH v7 20/22] hw/i3c: Add hotplug support
Thread-Index: AQHcpfw1LaIaA77RokWGxjO0FjCimg==
Date: Wed, 25 Feb 2026 02:12:36 +0000
Message-ID: <20260225021158.1586584-21-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5118:EE_
x-ms-office365-filtering-correlation-id: 740396c2-b5da-43de-2c30-08de74135848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aFvfHCCPktbGvuChUmflXIbCHMuiwxO52A//1b84nDo5zrOHY2Yi5Oz29m?=
 =?iso-8859-1?Q?kqpEiP5hT16cSiYaUYM2HSPCKoxxBIPb+2bOhtXueaGe7AgS1jHppTyKNP?=
 =?iso-8859-1?Q?aK1aiUPegWR5oEdAE6C2f5DcO/MaoUbeHigVmYswsTYgYLZaDwaAczPXO8?=
 =?iso-8859-1?Q?kXd73gCWyjEHarfvIJ4maffW3gNITCd61vK567vt82Y+wjVUaQWeb6Tzq0?=
 =?iso-8859-1?Q?RaG2h6fr14BEjaIPE8UkhxZKiT9ODCEyiXl/zxFlLShIBOFPeYUvjFAIsJ?=
 =?iso-8859-1?Q?RBNSrCO8dLU2e65LN3x6QJ29utnbbHuiLpmnRW+Bmkl9Tt8YNKKSkXEaL3?=
 =?iso-8859-1?Q?JmHFRVgzmJeWA/znHQggzqZXiL9kUnXEoCCev5BgyOrBlkM6tU7s6RT4oe?=
 =?iso-8859-1?Q?KSAnpqKFwd9/UJ65836lkPnFotviYjDGp96pxhoP9kn+7cT2a6SpxauoEK?=
 =?iso-8859-1?Q?bl9oeNervHKfJDGlPLYc0cMj92kK701lNy13jCePuJ+C4SvSxwT1H1GxWW?=
 =?iso-8859-1?Q?InLUi0MhQKlXAMGMzdY3XMW/yor2tbD4InhivAA4iFtZAApPtm5140+TQA?=
 =?iso-8859-1?Q?rjqchLRTR6oAjIIF4VLw1Q6qP45nlX1xrhPXCV1vmgTMR2wtEegh7n2TBz?=
 =?iso-8859-1?Q?4LQXZMYPdKAbX0SowdHl5Azz1oOaQl/UC88gjLWdezrp9RUbNdsiZzT9Bm?=
 =?iso-8859-1?Q?VHrCkqrn/Wzj0SK/YFvLv6HQ81Q2Rm/+wyPN17o5vT/aYpYW0P6DCb1k+/?=
 =?iso-8859-1?Q?ujOPmQ9Yrw2Sc/h2zAKEE719emv+P34oRS6Ry2mNnXNZ8nRqA8bCgNlfUa?=
 =?iso-8859-1?Q?qKqfm2lw7xtyZl04RQpzL6EX2i37Rq9gTELSDqwEGPxtLmQhBddtrHf1wk?=
 =?iso-8859-1?Q?UqyrQ//yyb19j8oB4NbhiKETmAthE0whroSFmW9fj5sGeC9xoA0r+N3Cjn?=
 =?iso-8859-1?Q?zQk/cmLyq3kWo5US9+eEIpg2Q4uxrBogS+5YoWEhb0dsWEgN+0S0pnFn7J?=
 =?iso-8859-1?Q?FdPQRmWyWKrox9eRduWfFlgNVu9l7vItW3BApV+AJKNCaBF1/0PH6WcVeI?=
 =?iso-8859-1?Q?rxTl/tO1vtDmUSONvQ8w8sh6V+772v4osT70DL90gn71rtyHwl2/tgfqCt?=
 =?iso-8859-1?Q?Cb3sq2z/6yLeG2+3SjVGfMSvJ2sHbde4X97kwdcwNWI7dvhHRPueFweNAN?=
 =?iso-8859-1?Q?lb5hZFP2vP0MVHjMJG5F23A6T1WH9Dfn2dftG7Eg9NtEd8PlUfcwSVzHMv?=
 =?iso-8859-1?Q?uKGh0ZY12eSkwyEMcdJe4mSPYxJtyQffw6Hab+50vY8c2pglTw7LpwxgE+?=
 =?iso-8859-1?Q?pYHhtjkMBFuZ7Ey3zM+NOI0S639KPsKa6caNsKFJRWOyP+iSWcNoMjL8mC?=
 =?iso-8859-1?Q?di7K4KEqihla3smMxN5ofE9lHK6ulrywTut0iIpTO30xd2QcHbNlZ93YZj?=
 =?iso-8859-1?Q?yv6kr2ceDdfXVLxeLCUsazZppPlI/SIf9Tb7+QesaeA1PKdYN43CukzkDy?=
 =?iso-8859-1?Q?DA4ZznBcbjzfknEN38FVCJ9D8NWWv7CkqvQVNIHT0SZVyF1qgcVE29RnFK?=
 =?iso-8859-1?Q?QmgxGb39BU99RCF5BhOoQs+yM+GzMmEXO9b4NZHJphgZebFwgyy2e9hOjm?=
 =?iso-8859-1?Q?zFdymZ2i8nc+1G94fDqC6wVwgar0mGdb6Sn0G/FgF/SPXU/Qs8ZhHR1L/r?=
 =?iso-8859-1?Q?ENmZDPdn0XH0J3JMSuPXaRU8MTHzmRrPVrjudxNv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qlE0QqcyygRdwt0Mr92yWnoJZL4GfMdDFMvEgYiLUCB2/V+hS/5WeCWoED?=
 =?iso-8859-1?Q?GEcoYtnQfDXnARP0aKeLnBoki/STWGQ8dx5Uthr3d3cq+pF/G2SK5GQ/Fe?=
 =?iso-8859-1?Q?yTDQ2xyvRNzTGCNsR9i6RlYQcjEc45t9UICl1R5PiGeB2pJ9gk618jb6Rh?=
 =?iso-8859-1?Q?gIbxM7SJmF72AWNI1jtKCsAggJEAv3Youihk+M22MPLTjzuqyuJxSZzVRO?=
 =?iso-8859-1?Q?950HrJn7az692iT/cFK4dpO64vTtwz5CPVluCpbIlcp5UhKbqt2Tryctf6?=
 =?iso-8859-1?Q?vde1Rv8sKZKbW6e2O4hB/aa7s/EE/1n/c3a0YJYiu1kG4m4sVKimu6349c?=
 =?iso-8859-1?Q?cFKm414qQ1yYdiXiEIlWGdv9gSPNmA2KqXYBf7WpmqdQ2ItSNt2P9B331/?=
 =?iso-8859-1?Q?N2Q/9pjqm8LrsQWaWc7oe6V0EtHQ0+8yckS02pSU2ChJ/G4x4AiLsVuxW3?=
 =?iso-8859-1?Q?HsqvMKgYQ0rH4/nxW3vvNqUaW/0gIoATRtVRSW6IcSoE4fY9JjhHIfe8xC?=
 =?iso-8859-1?Q?kIvwHy03OIG2F0DVgvXi2JasdYW9AYm4eCm7GnDfnxisF3WuwTOQ8E49/0?=
 =?iso-8859-1?Q?onAV7PMM2ONynIwmSLkZBe33243eil4pr9wAc5/fBSwpesSgbRdC+6/+bV?=
 =?iso-8859-1?Q?unqASniO6GnyOEACCfmcZmBRExuKcCe2EUBIVpe7UzlaF2BbcJmgzZCDZ3?=
 =?iso-8859-1?Q?BJjZ+ZnP1lCX7EjgdsV7wBenB0nxTefwLlJAj5mlUxBLRclftEBzPfjU2h?=
 =?iso-8859-1?Q?wYFnoNknmbk1z3Li8N5HJrsLi34lO/5491YtvNu4HM5yuDQ2DcpIaKmV9t?=
 =?iso-8859-1?Q?RP6wGE42Ib1vLwKwZmoWg6zG8pPF9Qg4+U6u/qbP2gwl5fnfmBzaXs7o0O?=
 =?iso-8859-1?Q?LhGJG1Ui4TI+eYSsbfD+IBz9nQ4Lpb/LbLesLaSVUv+GR0P307UTfxWUbx?=
 =?iso-8859-1?Q?sPzqR0ZfCq0zRSiAk7Ke8QF43DxFyCcF5Ovw8d7bDOfJOq2OUuz/eB6v+G?=
 =?iso-8859-1?Q?VwikcgZF3QpQuobVFIlMy8kWLJRHwz3kliti9ITE5jzjvF1WW03L/X+IQ5?=
 =?iso-8859-1?Q?yhM3rp6dnqOmF60+AnfLWxXEgICvIwjj+4TuFLh7VEVnAK+KKTFuuW+fF9?=
 =?iso-8859-1?Q?ihrDah1BbSzn4NdiF1xPvIwajK68RQHks2S+9/FXSRnHw9o/YTWiMBcqYu?=
 =?iso-8859-1?Q?iFZ+GIYhAkf8jFf5RtM0CXr6Ybfy3pUXIvxOji6LIFGcp5wibAOvN9tENb?=
 =?iso-8859-1?Q?5kxh0XQ97hVnyqBwAjopKuAy4VTbrf9jPEzJXSbcg9xP8jHZxfWYP7XOTd?=
 =?iso-8859-1?Q?ZzOCRA0N1e6gtgWG+jEcuqpM6Uk3SdaBKsFvViPT9EssMk0zxeUEVxkujU?=
 =?iso-8859-1?Q?hTk6FXztkGvo5Kq4a7jKAt+Lfa4M+fLC/rdUfRRdJ84yHyxTdN+39W7fcW?=
 =?iso-8859-1?Q?EMWgYWnDIVoBTNTiMlqxNWhBBXJVf+CabkbgCihIP09FZ3Jph5SxKUS0Al?=
 =?iso-8859-1?Q?nFpTk/05ZtCmKxo/rmTVUr39+2S7ivuGwOWjwDYjhW1tFN3EeaI/dAxDzT?=
 =?iso-8859-1?Q?7j9B0I2SF+RjOTX4JJ47ksT+Y4PwRpMFt8n68cpXcEf2RzAOtUcnFjpmUw?=
 =?iso-8859-1?Q?dVnRkavozAcybNapzOjkNWet3qUMHWvpUa7dyHJKWJeHl2qu5GgimqF7Ix?=
 =?iso-8859-1?Q?2O+VFYn3+SeQb+BVvPQX++v6vhl2JKVL/4ChO+7P7i7DLzFDEB3m4zg3ZQ?=
 =?iso-8859-1?Q?803jNoA0zW3XXfcNvKlwxCRX0RGetVjybbpNoLd3Xyv9cmn65eYuVl2BaP?=
 =?iso-8859-1?Q?G5K84eU8AQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740396c2-b5da-43de-2c30-08de74135848
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:36.7313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BEFWFqMhNBcbEXosZxo3g2LSKo6zeQWDFHI5T/HwFLoqYB7Y6Rsh6+uRRZCVgjp9PkYbFtQlGk3rt0TKUZOItAUkqecvDM6wufj6dgIQfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5118
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This adds support for hotplugging in I3C.=0A=
Conceptually this can be thought of as an I3C target being physically=0A=
socketed onto a board.=0A=
It is then the target's responsibility to go through the hot-join and=0A=
DAA process so it can participate on the bus.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/core.c | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index 22e6e226a7..8a37099ce3 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "trace.h"=0A=
 #include "hw/i3c/i3c.h"=0A=
+#include "hw/core/hotplug.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 =0A=
 /*=0A=
@@ -26,6 +27,17 @@ static const Property i3c_props[] =3D {=0A=
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
 };=0A=
 =0A=
+static void i3c_realize(BusState *bus, Error **errp)=0A=
+{=0A=
+    qbus_set_bus_hotplug_handler(bus);=0A=
+}=0A=
+=0A=
+static void i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    BusClass *k =3D BUS_CLASS(klass);=0A=
+    k->realize =3D i3c_realize;=0A=
+}=0A=
+=0A=
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
 {=0A=
     return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);=0A=
@@ -633,6 +645,11 @@ static const TypeInfo i3c_types[] =3D {=0A=
         .parent =3D TYPE_BUS,=0A=
         .instance_size =3D sizeof(I3CBus),=0A=
         .class_size =3D sizeof(I3CBusClass),=0A=
+        .class_init =3D i3c_class_init,=0A=
+        .interfaces =3D (InterfaceInfo[]) {=0A=
+            { TYPE_HOTPLUG_HANDLER },=0A=
+            { }=0A=
+        }=0A=
     },=0A=
     {=0A=
         .name =3D TYPE_I3C_TARGET,=0A=
-- =0A=
2.43.0=0A=

