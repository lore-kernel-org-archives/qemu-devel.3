Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72913F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OQ-0003ik-Fm; Tue, 24 Feb 2026 21:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OL-0003d9-40; Tue, 24 Feb 2026 21:12:46 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OI-0000T6-JZ; Tue, 24 Feb 2026 21:12:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsEoJcZ0CmV57UbyiGD9Qqumf9d8fSLGgGfsHkDPvaiipRXwvYijsgiYSBsNzSVBwCw9lAind3nNcQ3Qh2jzVQjgeVkT9qYmBSFOQusUioccJoq5i7av0nlDlv0tSFs5YUaHRt17fV2UPmOdx9sZSIEDkJszlr6CGcleA/7Yq/OJK7XI7IWlil9O+Uc73f4eyHu5JeV775QDh0gcZxLhx4wrmSGbmUUrENnFeht66orTs6FatiFa9JmQ3GCStfc7oaxc+Lkc5QcKRT+LGyAL/btJJulTkDf5tor2/jiRImJ51lzFete31Ql3rxx0XiWwL2jgdd3EidrLapUqSj0xPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=ks0Vn18wNOMcVS2UXp8vsrB+NF+KKuLVBThDoyxv+2y/sP/fKVa9UcS6mBgnx2CYJTWltFh1tRECq0t0YQSvOg+QF7S67sSAeDGqStB+wFQAI+ObJ0eB2zmHPMTEr3whD4PpdhiRoZcUkaPGoz9WQg9nWwJRv+WUBiqS84zPeynMG1FzRXhHVojUWWXzqCGjhXHMcoM0mKZNgPQ7jTOinVagnTxJUgGz2oJ4tfnH2+pgNYD/DD5zkPA7VLKr5GNrIjJAFUwbJ01ZvSPHUadotaF06dfkrQ/tZU++X9bmSvIf+kHeFm4nRCeET78OpOtVj3Q5Baz0sYk9ZyUAh3Bzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=Gbhyi1mTUveGsDTpqBaVRUMkZrsLF9ilb83dF2rb84p6BOM6fTa4j69TNzr9QZsdcLqd77vuN6RXiKJ+Gkysi1ro15NJchWOzHhJYf478LaOFfdHVFTdy98M6ofQGhQ10CfqRXxOhrbH6+ZH152wWDAvdW/zmQP3yrojcWcEl6sSbatMGFuwi6wQOBTz84JXTM60bSJaoeDLViyxMKoK1lecR5P6v5i+Z6RZSHw0uxJ4dWfOIbRtZLIHypqBEh/UmjIVxrUZcQv6MjobMzfZ5D5Y9KptwKQwij5tiDwJYnBKtn6YiJx+ToQ5cZ3q4XVnAHKF1DW8kWrtLbwjU3A6aA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5118.apcprd06.prod.outlook.com (2603:1096:101:38::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:33 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Titus
 Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v7 18/22] hw/i3c: Add Mock target
Thread-Topic: [PATCH v7 18/22] hw/i3c: Add Mock target
Thread-Index: AQHcpfwz6dtr4P+XREmLu/9O1ZNFdA==
Date: Wed, 25 Feb 2026 02:12:33 +0000
Message-ID: <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 36161bec-2d3f-4506-ec15-08de74135626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7nnGWWv+je53cMP7//Vr+5i41qNp6PQyBRxcWHQQfywml1vBw+S2uC0V8v?=
 =?iso-8859-1?Q?DVbRTo+kelRQ1qKqelDRvNs8zX9nvZ5Tqv+vd0ZzvwaJ/aPCLOeY+deQQw?=
 =?iso-8859-1?Q?eKeZwnqeJwyWepl0QALgDDyf8dR0lzWaIRT9lLPAznyV0Cn2p3TTY0RdxP?=
 =?iso-8859-1?Q?LmQEhxFIM6EP2oSv9iI7lFCObs32NoUECMsYMy0q5R8o43m0tRxYJuQ585?=
 =?iso-8859-1?Q?eCaZ1xcqBD34OR2M8YU4pFzIXHCK1dD7t9kPXf8eXTsfvFdabmi7Miffgn?=
 =?iso-8859-1?Q?3LEnt2bzToWqnNkn3VtHU7JpIf5LTPnQsiOT83q8dZOy3moJLQN4bCg1cT?=
 =?iso-8859-1?Q?XkVJLJ2Ajx2iVA7Th8/lKuTy8TLF6o8pjQRz7kAySvboU4HwJ2tm/zWhHM?=
 =?iso-8859-1?Q?fxvShRsb87u4BGDa9e8mCxXvpXLsfCCjlofPm52pKsSQ0SFZHEZVwGi9Bz?=
 =?iso-8859-1?Q?oUQXFUkuLPI5gbE1TRB6cs0MXl5I0/EOOf6APhPvsZ8EcqsOpNmqcZcZRr?=
 =?iso-8859-1?Q?2h+556eoCioVhUCVENQtdBJtZlGH8ExTJZSOlBp4NulckDOWxDrDKRpY/E?=
 =?iso-8859-1?Q?QPyWicaeuiiZRcVGaOZSkldwcSB+Dh4FUhDqBjechrgwFeM5rLHkdnG2O8?=
 =?iso-8859-1?Q?v5LlMBwdkk/k5RX/CLpCVVFwxuq6q1AtmRcArvS2B7a+UfuT3KiFmJaLKs?=
 =?iso-8859-1?Q?LbJYEIksv8gcTVGiCGsYB2rGkZFYtr2RDwWO8zo/fWsvyLarKB+gd7Y3pd?=
 =?iso-8859-1?Q?vIQ/gIp+0npZ3iWHDUkQO7mIMLMvfr5nQkzL+8lEuxKiJ8btXyebF2T8uP?=
 =?iso-8859-1?Q?7PfavzeoxsOS1ONHtY1AeV2mABmrE6PK0CookDVX7HgljfKe8+x+mFFSfR?=
 =?iso-8859-1?Q?eIbLBAOxZl+9TcjDWFILVxsLrWiKWQwsEWyi9fmeUUE2bvV8a8S9Yb3T7o?=
 =?iso-8859-1?Q?TwXl/xM6MzQ2vo32zS92UtErQ8bm6RwVci0RUsPkGdqbHys12Gs4Ty/Lgb?=
 =?iso-8859-1?Q?bpVPew8hD5ud7Q50269QzuaWQ5SqV31dqUXrPkHTyYRve5hDDOriZgFUNb?=
 =?iso-8859-1?Q?2SOGAB7sHcVKkyN4r8d3ef9Yrh0muLpoRxSR+GkI6i0fw1cH9sy6nn8z+A?=
 =?iso-8859-1?Q?PuuX97cGPcIoVgrO1aCTKk+HRmh6WplBsigvvFc44yWYK3azCC8KB0drvV?=
 =?iso-8859-1?Q?nYZCbwXpo/wNHYnMqhCZrGyzTJwSx1Cxuv7J20ZfgrwvCUKSm27PDE6QMc?=
 =?iso-8859-1?Q?cgYW8K1GQ4Bbxrl48wzBIAOmsYz1A/EXDhF60j6LEGtpxo+e436AhuJTh+?=
 =?iso-8859-1?Q?mA0E5rC5yCutmqzb7z6oMs8Wnm+Nf/wO8FZgGfZ7QJKdDuLPk2MDV+hXn8?=
 =?iso-8859-1?Q?Sj45USQ1yen6fgnmtrNpgelzI/5dpzGvgTZEul4PTWQeOAD0UAz5jElwMB?=
 =?iso-8859-1?Q?lb2z/pCUw5xARI40B69d/256Omod3yCRP7dYqM/3GsPCOHwmHaJVDXn5ZR?=
 =?iso-8859-1?Q?/j9y/5w/ThcRFUi18p51QIfE9UtVhRsIFbg/zlGimAhBABBziNZ9C9SbPp?=
 =?iso-8859-1?Q?XXQs7tffkLfXepukeRIenZjAtAXJrgC/oR2inp5fjTIE/A8tQmO8RzoH8O?=
 =?iso-8859-1?Q?b4QA3AacvlALrOhoA8hb+b1Ic/QfkdvA19sgFNj+k+Vhca1XXyVonA8oai?=
 =?iso-8859-1?Q?Hnfz0nTdQ7xDwIwrDKPVmBuSTd0pLEqw4cV9dTuN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?44uXnRm6TClxBG5QQwtGTHVdLt6iqYHJ3PvrPqR9BCuSyK+1MCYSEVICLA?=
 =?iso-8859-1?Q?tc6/Aqth3PUl+4FiYWR6jfZnx9yLlU0SRRHOOlj+hvKJwZKe65YZv/Ey99?=
 =?iso-8859-1?Q?zU4IkZv6pit3XW3EegIMBUCvipRF+X8ewBeDOfZjqUrY7FzB+CmJP2XBpU?=
 =?iso-8859-1?Q?JmApWw543FIO70NcJ10H7L75KsPK2f7n2TmB7bHf0gU49lPAQ8rKmo72i3?=
 =?iso-8859-1?Q?/ztci1yXy8JcVQzEooZmcxBUiybanFpmypuyEtvmXV4D0XvnGXmCAkpQ5y?=
 =?iso-8859-1?Q?24i3AegKpOUooqg3+qvrpSSf6U58QxSHVic17unKjqBzuwcQgZeQ9q8WiN?=
 =?iso-8859-1?Q?+S/fquk99zmWxAFJ9BPQ3uSrvq3bTJb8P6+utugAOdVcqCSd6UC8yOhIv4?=
 =?iso-8859-1?Q?0XxZgsiIqTBUz/KQ2l95/i7YzmpfTn4SnZ/QAxeDT8JZbKPfXMbZtQsPh/?=
 =?iso-8859-1?Q?nc37+hQBH1aiw+Pzl6JPG+egvGd6pL2tjXMn79EPefv+7cHs56nZsu0a5h?=
 =?iso-8859-1?Q?Nz0N8J2piHGYjIQ2xTGankz05erC0c7xcBaz6EgJZ235oDQu7oMuV5NLe1?=
 =?iso-8859-1?Q?8+vtDKl0BvmpMSihFcvW42KHBuXu6fFcQPMSX8hR7UuOwfKe4+Kp+U9ggc?=
 =?iso-8859-1?Q?YuN6DuICFe8gPgp7pjAAGxkN805xMltrte2ARP0naFCVxYEKFkRu3419gd?=
 =?iso-8859-1?Q?N7Yqt4LlFwODW9e8mRbhX4rl4JDMqDJHffqMVWde+bxnWPypEE74P4cb0W?=
 =?iso-8859-1?Q?ltsQugvbtEXn+/hFYNjJr9EJCrC4BctNnVT5fB8oZrsmBVUGfuGWrQJafj?=
 =?iso-8859-1?Q?skrnIV5/AF0W/rUudbgB/gas234ivIqMrNSfgjNTqMcZw2Bb1zguY3anID?=
 =?iso-8859-1?Q?vGaIznqGV3b0O+FTCObjtnwecqN6U16nAj18SA3EvFldrM6jwgRwSY3ZBj?=
 =?iso-8859-1?Q?6bv0qOy1gB1wP3QXcSwwB5zPwtimVbqOCkOoFn/GLacOQt/GSQ+aafQ0Ej?=
 =?iso-8859-1?Q?3p7gKp/AhMJRtARyPIjX+r+83ffXznfc+5Bpq2SEgQUp/mHq2STmfFHHl3?=
 =?iso-8859-1?Q?UlQuM4mgAecjgTr894aOnW9pDa/DXtLvqT3rYIytS8JvCDbPPyvI3SV1x5?=
 =?iso-8859-1?Q?cSiV/freAWs6Zt9s1G/4SBp0VGvWpD1d47S/jP2obWoPovCWqD3VZD1c2m?=
 =?iso-8859-1?Q?U0R/BXMoc+uEFTuR8MHFU3DF+4fywwlBMA92s8r854ddijMdg44tjI7Mp6?=
 =?iso-8859-1?Q?LbmdCDhxIDsf0pBvhp2QnPDiqbz3ltVl8bsMG6KlNqphjscaWCLxlB/30B?=
 =?iso-8859-1?Q?8Sc/uZvEm3ox0u4WfeuEQRZXExwk6pCaMROE9N9Gk9A1McWhzToX4AszNX?=
 =?iso-8859-1?Q?UGDK1Bw3Fqpm+G1JhtNMeZ+3x4JlIh3oB595jT9txqFx6XOZBWvWgdr57v?=
 =?iso-8859-1?Q?w8rV7MZZ+zRAtzsm87CQzY3bJRZv+GoV+sKDHt8o0cdhmKTIwiBB6lhZZO?=
 =?iso-8859-1?Q?d0wTOsHVFr6bGakpGPBPh9sCsYhj2b+cjazD6h2oUQBnhgFAZV1x9zyXV7?=
 =?iso-8859-1?Q?f96raKu+yHwCjpLOAT+zE0EPV9ZiMXEGOf07Bes2U89Bp6yu9qvVnb7kUS?=
 =?iso-8859-1?Q?Z6qreIDrGC8Jn/7TL9iKz5/B06cQhQEZnxF7o4QXUfwwWJoEX4TQiM5UCe?=
 =?iso-8859-1?Q?M5oarFtvkpWdYjGXN1s/52XI3yWbLYIQ56VIAIELImGgITWHirLw7DXkju?=
 =?iso-8859-1?Q?nWRtny7cllK7z3Vy8PNz1ft2vWpDljJB/md2P8214KAqDLeZ9o82xxjR7m?=
 =?iso-8859-1?Q?I/DWacDjCw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36161bec-2d3f-4506-ec15-08de74135626
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:33.1321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7A7lZLmFVhawgTxdxX4yo4jqX5YQxWzG61Or7sJ3DkKny+Qje1qgM/yYXBcBPkYg3gKcL42g4p2aMJX1GJAsN1zrddBfuKBB4kBp1t+CWpU=
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

Adds a simple i3c device to be used for testing in lieu of a real=0A=
device.=0A=
=0A=
The mock target supports the following features:=0A=
- A buffer that users can read and write to.=0A=
- CCC support for commonly used CCCs when probing devices on an I3C bus.=0A=
- IBI sending upon receiving a user-defined byte.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/mock-i3c-target.h |  52 ++++++=0A=
 hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++=0A=
 hw/i3c/Kconfig                   |  10 ++=0A=
 hw/i3c/meson.build               |   1 +=0A=
 hw/i3c/trace-events              |  10 ++=0A=
 5 files changed, 371 insertions(+)=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
=0A=
diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-tar=
get.h=0A=
new file mode 100644=0A=
index 0000000000..8c6003ae8b=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/mock-i3c-target.h=0A=
@@ -0,0 +1,52 @@=0A=
+#ifndef MOCK_I3C_TARGET_H_=0A=
+#define MOCK_I3C_TARGET_H_=0A=
+=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+=0A=
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)=0A=
+=0A=
+struct MockI3cTargetState {=0A=
+    I3CTarget parent_obj;=0A=
+=0A=
+    /* General device state */=0A=
+    bool can_ibi;=0A=
+    QEMUTimer qtimer;=0A=
+    size_t p_buf;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    /* For Handing CCCs. */=0A=
+    bool in_ccc;=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+=0A=
+    struct {=0A=
+        uint32_t buf_size;=0A=
+        uint8_t ibi_magic;=0A=
+    } cfg;=0A=
+};=0A=
+=0A=
+#endif=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
new file mode 100644=0A=
index 0000000000..875cd7c7d0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -0,0 +1,298 @@=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/mock-i3c-target.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+=0A=
+#define IBI_DELAY_NS (1 * 1000 * 1000)=0A=
+=0A=
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,=0A=
+                                   uint32_t num_to_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    uint32_t i;=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < num_to_read; i++) {=0A=
+        data[i] =3D s->buf[s->p_buf];=0A=
+        trace_mock_i3c_target_rx(data[i]);=0A=
+        s->p_buf++;=0A=
+        if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Return the number of bytes we're sending to the controller. */=0A=
+    return i;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)=0A=
+{=0A=
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,=0A=
+                              uint32_t num_to_send, uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    int ret;=0A=
+    uint32_t to_write;=0A=
+=0A=
+    if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
+        mock_i3c_target_ibi_timer_start(s);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {=0A=
+        to_write =3D s->cfg.buf_size - s->p_buf;=0A=
+        ret =3D -1;=0A=
+    } else {=0A=
+        to_write =3D num_to_send;=0A=
+        ret =3D 0;=0A=
+    }=0A=
+    for (uint32_t i =3D 0; i < to_write; i++) {=0A=
+        trace_mock_i3c_target_tx(data[i]);=0A=
+        s->buf[s->p_buf] =3D data[i];=0A=
+        s->p_buf++;=0A=
+    }=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    trace_mock_i3c_target_event(event);=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        s->in_ccc =3D false;=0A=
+        s->curr_ccc =3D 0;=0A=
+        s->ccc_byte_offset =3D 0;=0A=
+        s->p_buf =3D 0;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,=
=0A=
+                                           uint32_t num_to_read,=0A=
+                                           uint32_t *num_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+        /* Default data rate for I3C. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D 0;=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Support I3C version 1.1.x, no other features. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D 0;=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D 0x01;=0A=
+            }=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+        /* MWL/MRL is MSB first. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
+                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
+                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            s->ccc_byte_offset++;=0A=
+            *num_read =3D num_to_read;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t =
*data,=0A=
+                                            uint32_t num_to_send,=0A=
+                                            uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    if (!s->curr_ccc) {=0A=
+        s->in_ccc =3D true;=0A=
+        s->curr_ccc =3D *data;=0A=
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);=0A=
+    }=0A=
+=0A=
+    *num_sent =3D 1;=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCC_ENEC:=0A=
+    case I3C_CCCD_ENEC:=0A=
+        s->can_ibi =3D true;=0A=
+        break;=0A=
+    case I3C_CCC_DISEC:=0A=
+    case I3C_CCCD_DISEC:=0A=
+        s->can_ibi =3D false;=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCC_SETAASA:=0A=
+    case I3C_CCC_RSTDAA:=0A=
+    case I3C_CCCD_SETDASA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)=0A=
+{=0A=
+    if (!s->can_ibi) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_do_ibi(s->parent_obj.address, true);=0A=
+    int nack =3D i3c_target_send_ibi(&s->parent_obj, s->parent_obj.address=
,=0A=
+                                   /*is_recv=3D*/true);=0A=
+    /* Getting NACKed isn't necessarily an error, just print it out. */=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("sending");=0A=
+    }=0A=
+    nack =3D i3c_target_ibi_finish(&s->parent_obj, 0x00);=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("finishing");=0A=
+    }=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_timer_elapsed(void *opaque)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(opaque);=0A=
+    timer_del(&s->qtimer);=0A=
+    mock_i3c_target_do_ibi(s);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_reset(I3CTarget *i3c)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    s->can_ibi =3D false;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(dev);=0A=
+    s->buf =3D g_new0(uint8_t, s->cfg.buf_size);=0A=
+    mock_i3c_target_reset(&s->parent_obj);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_init(Object *obj)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(obj);=0A=
+    s->can_ibi =3D false;=0A=
+=0A=
+    /* For IBIs. */=0A=
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_el=
apsed,=0A=
+                  s);=0A=
+}=0A=
+=0A=
+static const Property remote_i3c_props[] =3D {=0A=
+    /* The size of the internal buffer. */=0A=
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100=
),=0A=
+    /*=0A=
+     * If the mock target receives this number, it will issue an IBI after=
=0A=
+     * 1 second. Disabled if the IBI magic number is 0.=0A=
+     */=0A=
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, =
0x00),=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *k =3D I3C_TARGET_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D mock_i3c_target_realize;=0A=
+    k->event =3D mock_i3c_target_event;=0A=
+    k->recv =3D mock_i3c_target_rx;=0A=
+    k->send =3D mock_i3c_target_tx;=0A=
+    k->handle_ccc_read =3D mock_i3c_target_handle_ccc_read;=0A=
+    k->handle_ccc_write =3D mock_i3c_target_handle_ccc_write;=0A=
+=0A=
+    device_class_set_props(dc, remote_i3c_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo mock_i3c_target_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_MOCK_I3C_TARGET,=0A=
+        .parent        =3D TYPE_I3C_TARGET,=0A=
+        .instance_size =3D sizeof(MockI3cTargetState),=0A=
+        .instance_init =3D mock_i3c_target_init,=0A=
+        .class_init    =3D mock_i3c_target_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(mock_i3c_target_types)=0A=
+=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index ecec77d6fc..d5c6d4049b 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -3,3 +3,13 @@ config I3C=0A=
 =0A=
 config DW_I3C=0A=
     bool=0A=
+=0A=
+config I3C_DEVICES=0A=
+    # Device group for i3c devices which can reasonably be user-plugged to=
 any=0A=
+    # board's i3c bus.=0A=
+    bool=0A=
+=0A=
+config MOCK_I3C_TARGET=0A=
+    bool=0A=
+    select I3C=0A=
+    default y if I3C_DEVICES=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index 83d75e7d5c..e614b18712 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -2,4 +2,5 @@ i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target=
.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 39f33d9a50..9e58edec99 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -36,3 +36,13 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx=
8=0A=
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
+=0A=
+# mock-target.c=0A=
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8=0A=
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8=0A=
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8=0A=
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "=
I3C mock target read %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx=
8=0A=
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) =
"I3C mock target send %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI=
 with address 0x%" PRIx8 " RnW=3D%d"=0A=
+mock_i3c_target_do_ibi_nack(const char *reason) "NACKed from controller wh=
en %s target interrupt"=0A=
-- =0A=
2.43.0=0A=

