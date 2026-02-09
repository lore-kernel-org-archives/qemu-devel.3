Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A27E78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNNw-0004ar-Jh; Mon, 09 Feb 2026 04:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNu-0004Ya-9N; Mon, 09 Feb 2026 04:16:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNs-0007Gs-DH; Mon, 09 Feb 2026 04:16:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byb00C78swLfXHPN004bAOqyVUW5icXjJBwnyRwDrbPsPdt7pWtAvR8H+AVi08vwnpmAOdvbttcLBeKawROztp6RlP/Hd7eixGtEK6slSwMwZ9ZFtSE3knSBL+7RlsJHA8jWA/+W0WNv2hfqa86qKPW3jM1gkOh6t0InUE0lEg9zOJpkFONLGtGCZby7lhaunJcgoSEg3vRimgMlCYEvdMA22pghaZnLOYZVNErR5/fs3klMkrLwTOJ8Ukzrs1dymZIds0zA1ahcZgWhQiRAGY248D5/5Cqtn38HGcibyJNP5dbmPqyCywtGdN44OtMzJAP1OwYK9Wt7jrdtroP6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNJGnvv7T716ktIxUUvnlNKynsTuSSmaB6lUz0Q6bU0=;
 b=fv7gJgmU4DsfSgNU6TDW13wKqqSPWIWJ/c6lT8UqwlVuteaj/BQEWG4YoFspAsWcj/8fen63tm/WOA1Oeze/4/IJbHAwBX4VjJfNjfn+ReymSY/yzNWFYXGIZWEtJRVWKfEkXmmbdjFm6zY5hyGnmipXBlGSrg3ZtjZ64tCBhDzj0aZLS6yhku2DIVw4ld+T3z3EPpZCcFHfQbr13aKdz0XkB12LcC485IyBokwC2quqRtfoBh0quSh6Zx5K//OpmdFpKTMqcrJHYmWbPQT7IWNVhuch2VAIj6NcSSogdHgZCP8ppoY7L7d2U9mUDlgMSU5WSxKOAbjFd6Wej1wKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNJGnvv7T716ktIxUUvnlNKynsTuSSmaB6lUz0Q6bU0=;
 b=LCGjlTaFRFqfXNidFFgbysHLQrpRD8LOs8A4SL7Ven5vvO9kh4lmFJ3j0LP2MJS5qK39F57khUcPhsJla77zQ2mM69VM1Q9NtICKku5yL1rAVUYmFMUCxQyhuVNg8HaNXw6+qint497FUGMXY9i4IEm0AKnlp3O0J728HCTCv3xdAugqUk407g/+0kY7uZ2C+OSWDZobSQ0eOMSOGXeQs4kwC5xolFuB7fBYN+u1BVdsGWJNRKL5tD2JQiJS0rqiHKCi1fvW1X3l3i08hrnerzMgimxcLvxjM28ODWg62h2PZi7+JfhixzSm//y7MGvWnuO2GcZpVnx+dms02ayFdA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5250.apcprd06.prod.outlook.com (2603:1096:400:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:31 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 01/20] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH v4 01/20] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHcmaTH/oGLrNr/9UuyTPMTKjqzHQ==
Date: Mon, 9 Feb 2026 09:16:31 +0000
Message-ID: <20260209091629.823457-2-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5250:EE_
x-ms-office365-filtering-correlation-id: 0a33cf05-8873-4476-4972-08de67bbea1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YgyIZhNFSoCCFQoOAcMvtsF3+J7f7hk4xC0jRGIbf4R7SexCCZ/e9NNqN/?=
 =?iso-8859-1?Q?eEZhYsKO2wnXNt/nvGQ2wvuSAxHlNcX3JA4bNBqn+EGfUxu0iVAB7NUnaa?=
 =?iso-8859-1?Q?eBhBarR7xdGXAuHFO6YHXLhXRuZiFTjd/wea/n5uhoO+k28IrJdvmvjA+k?=
 =?iso-8859-1?Q?8uyX+qQUyzCYZ/e99tuIjtlT0oDb260fiFHZDBAwJ7xLV7MvX0LqjVwt48?=
 =?iso-8859-1?Q?MeF0vofXOtVkUXiV9EaDpC7R9gt5OdcaEnQhwz3LhtoWp+SHu6h2Kfh6ai?=
 =?iso-8859-1?Q?VmBd5f7ziZyAyVUGyyF978XKud8RgERumizHD3FUosKmQ4V+63Scdh9b4l?=
 =?iso-8859-1?Q?wbAcAQfOO3e18nA3j6fblYadH42kfyVt+sjuXJOeF+PqwrAb6YuhIcuyQw?=
 =?iso-8859-1?Q?G5zfGjuUzM8Auna6EFAEfRb5hD3lIrNcuADyUs+sa2j96SeMYV96h8M6j2?=
 =?iso-8859-1?Q?4bng821WvlomR3crnzfglTmL02CHpQehx8mCUHA9iCW8qfwYyLiggt0Vaj?=
 =?iso-8859-1?Q?X/MLFUEFDHE7fJP93IElkZ8Iqyq4kt8DdTntSgX7lNp1yEeYi1oBfpXl7N?=
 =?iso-8859-1?Q?aKp3nzpP3cvFOXbSFX6zerYiitERTsXsh5eFAncsoWTjbBTJu0Zrm8mnZA?=
 =?iso-8859-1?Q?oFMsN/ngNHU1Ri9bcIU72K2/MNfiGVkaboXpUHi0WqpbaZ8mGWqbBNCMWN?=
 =?iso-8859-1?Q?pK+E2st6xm40G8gA4hFvpiQ1wktTWnRi8ym4SJPxuVJbx3qT8SY4i4cU+s?=
 =?iso-8859-1?Q?VsSguwjZCmxGYLGVrqiajwpUJl7ufGRklubvUqVPFe9VtTlKKQSAAYDIJU?=
 =?iso-8859-1?Q?zfAuOkBAAGl5FHHmWtQrXurqRYndeRRUu8m4cMtXqd1qQbcHQk4nuPG7yE?=
 =?iso-8859-1?Q?5Th4AD+jT7ye2UpORC/zstlUrsu+rqtJwcbDa3nIR6MB6PaXjx4uN9Qk4+?=
 =?iso-8859-1?Q?I+oR2M4acQuddhTpQOh0pxlmgoUK4P7cHK2nP1dKvIULVbyWGMmfIDGspn?=
 =?iso-8859-1?Q?8BpSnEAR6ioTz3Vf4Tby4XY5Ohex2OjtqYlUL8hdUb9g7TppGyFz4yMh9C?=
 =?iso-8859-1?Q?L2kxFM/PZpOvxPi7ijFnSLx2aCF+bF28cTTe5mPZpP+ajTB+mRH8TJPjkp?=
 =?iso-8859-1?Q?WK1m5t9xuVCq44qrHac5N8ZbrCrcLM8npkQM/TJATiGuope9DdFo1ZCQjt?=
 =?iso-8859-1?Q?7dTd8BRC7o+qVISvto4Mdg8u8ZL0xpiXUWna5GvE2CKpZbAdwj1C8TXzj2?=
 =?iso-8859-1?Q?0DXVfuIxVz/SruGwjoxNnx61J+0ZPgvlqNWPeuH0IPX/dYsVRtTterm0+O?=
 =?iso-8859-1?Q?vDE7g+HIB1SqNHWH7XiTxqti/G5nC25nUigDl3fe2CWtVZoehOGdvLwKI3?=
 =?iso-8859-1?Q?S7aWH6ErKWdIfI8suKHyFuNTgb8Qp/Wo+jgqOeuXuMGMG4oV2VTkRW5WU1?=
 =?iso-8859-1?Q?BgN1wgJu4DGNXrseAIaXsr9oLrgboNWTfeYYOeLMMJtOxTce8ooFMz6Pft?=
 =?iso-8859-1?Q?0ppY9gX7RHpL9vc8Ssw9raNLl8WVrYtt56Lq14EDFEcmlqAsTMC1n6umA9?=
 =?iso-8859-1?Q?UIFJWhoSoW9rLGRswsUcJ8z+/iQL6cpb0dE6aK/+H22/LWIhsfY5YXT1BP?=
 =?iso-8859-1?Q?GIWN+XvR/eXQEFZVQM+WN64pGuudAwBZFzZs4tFl7KGWe+7qOrHP4cVfee?=
 =?iso-8859-1?Q?huNcCNwJ5E/CIWRFyY1vKkBLKLsjW2YJ2Va0nVBn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7eY55Cb0hpTVW+MA97pzyQ5ffBYEDe4vOYQomCRSeiYVrgN7+otnWjbmGr?=
 =?iso-8859-1?Q?CqTZiTh0y2/d9YDrDco4+XY13LxpzpP6rCGDDMsX0mYp96j5nRRj6Efwco?=
 =?iso-8859-1?Q?d+7e4DEIFQT0mhYKTPBbsy3t9IPWnV0HbhWJjuVRfVGvNOd3nVrjY1A0rI?=
 =?iso-8859-1?Q?ef35OnZI4RO4fvVKeGuwED9J/5zptElJ+7mbLBi5NPxdqlh26ICDgzbzD7?=
 =?iso-8859-1?Q?icgDL4n/PUt127cnRD+B0hKqfMnlU/4zmw2kxPQCY1pzY30tU306WwI88O?=
 =?iso-8859-1?Q?t/AjNG1vU9TWlefWYVNI10N/m7ko0ZqDLK+B2NJOZsc9eNmDE7mdvr1xB7?=
 =?iso-8859-1?Q?2Ftb3krGZDNp+8OT55TFAF4URkgF2lC49LxFK8N6DUWFRM3g4jmSuPVXH8?=
 =?iso-8859-1?Q?+qz7+3N1ajUzHVmtHdRLSrfV2l01YWLUE3tj1puodWhdq3IIffcw1r5czG?=
 =?iso-8859-1?Q?rIvTOY+YfKFnQnWOBmvrntKGvd5a/IzEkuw4FPMWbL9ORFwB5XOkjHFV2L?=
 =?iso-8859-1?Q?0gSxDJBEWVmKgLDPvWJQ77Gk5RbQpEU/GqA+5iSA49MQaQleAYKWdA75la?=
 =?iso-8859-1?Q?qn09S0F+Rb442sWk/DGUXjAVtQ0zfUigoDZpqOug7JlcG19DDDTXegrKLM?=
 =?iso-8859-1?Q?7qnUhHbJkWm6veuxf8vPwDr3a7VkYIMkvc6YtaVxurvM7XjgKrsRAhsbA8?=
 =?iso-8859-1?Q?j/2cHEyMasGIxyq+wtR1KKPPv1Oxbjj/oNIRWxtTaUu6XYlBAb/w7WaPJy?=
 =?iso-8859-1?Q?Hk33xtBfg13kMPC7qQDhEyoNJdxNe+dwCs6NRnpRDzgPPMQkyx1J48SdNo?=
 =?iso-8859-1?Q?uBmLhWnsk7qS9aYSHDH1B8hPWI5Wvo+BOSosf8CQNFVaNUjBD68F8ZydUn?=
 =?iso-8859-1?Q?2PgxadykvwDjetdG4JTcHacxazR4CJmA3WbkramXzV8F3cyK4CblPzs/gS?=
 =?iso-8859-1?Q?Nj94JIn3X4Mr/pBbf4frSSU/DCtC4RmVd38HeoVc1MDYOoJx2thsbKohUz?=
 =?iso-8859-1?Q?xtSjqJqrO3Q/etRsl+mGCrzRIZDf4tMZI71J07Fn7u6abl5AGejAJkzUy5?=
 =?iso-8859-1?Q?No633o/XBCC29kkIRetoj/cXcEEFsGRd+YpolTTZ10muDbtmx6+Jx6KsMs?=
 =?iso-8859-1?Q?ueoGS0Xy6uHoVoMFC8c/PNiYFv6da42A+Q0NFu3knKsc+mISnABCT/WNvl?=
 =?iso-8859-1?Q?Q08GYXem7rQ1Lr06nSR05+3CF9NZQrY8C8Ji7QdAN5gQdbrE13/ly+FrSz?=
 =?iso-8859-1?Q?Rf4M6qRVbAGFNkggl6ugWVYTLMgMouROAqkuKms+F+/8qUYErKF7fB5+46?=
 =?iso-8859-1?Q?Rhg4nAOSYD0sUwRNdXdnJHMk2oAt1pVk1+ryUMTIJEsLMt3+SHwPNQ55a2?=
 =?iso-8859-1?Q?WDItSms3NZhvQ6e0eKysTeViZZTyzHWFie27qo1N1UXnZJwjPfIFsVyolh?=
 =?iso-8859-1?Q?ryOItsrekV4sias9/HoHocZS0l2A/2+2U/0U0neW3LB/AO74rvkz2qvKUU?=
 =?iso-8859-1?Q?ylDr/8VpU3XoM5ufZhNoAx39WRBvQN3Jhib2nQhNsDQgkosuUOKMHTJeTa?=
 =?iso-8859-1?Q?W4pktLc7N/yUh3XQ7UY4ELY8R0ryqGKO1xgiOjHjEiDjB1sv8vwxb2BCh3?=
 =?iso-8859-1?Q?GH27QJNyssAD2hwv9mbygDuy67pbIY/eVtt/b3bp7ZXT/0v/Kg5Su9uhle?=
 =?iso-8859-1?Q?BF/p+UlFRmE0+BodOgwvz3lBcLQ4RXSF2fkHqPl2e7Ah/w9KfEXnChUKJr?=
 =?iso-8859-1?Q?H4C+nCeT307vljbt885Chwm0uVKmzIE/5bkAJisQkwRmC3ZFnXgsKbt8Re?=
 =?iso-8859-1?Q?XHGmYMQB4Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a33cf05-8873-4476-4972-08de67bbea1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:31.7192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVjCwyLkQEGafIEbTgmLnUZiPUZsdSx+Jg+fxQqnd17rYKfq8Y8nGMbwSRoNWVgEywV1s17WCWwfEbhGcfjVr+JUs7iRMRJtK1arsqnSuGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5250
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build=0A=
files.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 meson.build                           | 1 +=0A=
 hw/i3c/trace.h                        | 2 ++=0A=
 include/hw/arm/aspeed_soc.h           | 2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h | 0=0A=
 hw/{misc =3D> i3c}/aspeed_i3c.c         | 2 +-=0A=
 hw/Kconfig                            | 1 +=0A=
 hw/arm/Kconfig                        | 1 +=0A=
 hw/i3c/Kconfig                        | 2 ++=0A=
 hw/i3c/meson.build                    | 3 +++=0A=
 hw/i3c/trace-events                   | 7 +++++++=0A=
 hw/meson.build                        | 1 +=0A=
 hw/misc/meson.build                   | 1 -=0A=
 hw/misc/trace-events                  | 6 ------=0A=
 13 files changed, 20 insertions(+), 9 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (100%)=0A=
 rename hw/{misc =3D> i3c}/aspeed_i3c.c (99%)=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
diff --git a/meson.build b/meson.build=0A=
index 8c6c0a9a32..d20ec383df 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -3602,6 +3602,7 @@ if have_system=0A=
     'hw/fsi',=0A=
     'hw/hyperv',=0A=
     'hw/i2c',=0A=
+    'hw/i3c',=0A=
     'hw/i386',=0A=
     'hw/i386/xen',=0A=
     'hw/i386/kvm',=0A=
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h=0A=
new file mode 100644=0A=
index 0000000000..1e0c4eadf0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace.h=0A=
@@ -0,0 +1,2 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
+#include "trace/trace-hw_i3c.h"=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b185b04186..d7b3647ca1 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -23,7 +23,7 @@=0A=
 #include "hw/timer/aspeed_timer.h"=0A=
 #include "hw/rtc/aspeed_rtc.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
similarity index 100%=0A=
rename from include/hw/misc/aspeed_i3c.h=0A=
rename to include/hw/i3c/aspeed_i3c.h=0A=
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
similarity index 99%=0A=
rename from hw/misc/aspeed_i3c.c=0A=
rename to hw/i3c/aspeed_i3c.c=0A=
index ac6db214ee..fff259ff66 100644=0A=
--- a/hw/misc/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -10,7 +10,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
 #include "qemu/error-report.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/core/registerfields.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "qapi/error.h"=0A=
diff --git a/hw/Kconfig b/hw/Kconfig=0A=
index 9e6c789ae7..c53f94d96a 100644=0A=
--- a/hw/Kconfig=0A=
+++ b/hw/Kconfig=0A=
@@ -13,6 +13,7 @@ source fsi/Kconfig=0A=
 source gpio/Kconfig=0A=
 source hyperv/Kconfig=0A=
 source i2c/Kconfig=0A=
+source i3c/Kconfig=0A=
 source ide/Kconfig=0A=
 source input/Kconfig=0A=
 source intc/Kconfig=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index c66c452737..8344b9769f 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -545,6 +545,7 @@ config ASPEED_SOC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
+    select I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
new file mode 100644=0A=
index 0000000000..e07fe445c6=0A=
--- /dev/null=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -0,0 +1,2 @@=0A=
+config I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
new file mode 100644=0A=
index 0000000000..ebf20325cb=0A=
--- /dev/null=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -0,0 +1,3 @@=0A=
+i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
new file mode 100644=0A=
index 0000000000..3ead84eb45=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -0,0 +1,7 @@=0A=
+# See docs/devel/tracing.rst for syntax documentation.=0A=
+=0A=
+# aspeed_i3c.c=0A=
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
diff --git a/hw/meson.build b/hw/meson.build=0A=
index 1022bdb806..e05dc4864c 100644=0A=
--- a/hw/meson.build=0A=
+++ b/hw/meson.build=0A=
@@ -35,6 +35,7 @@ subdir('dma')=0A=
 subdir('gpio')=0A=
 subdir('hyperv')=0A=
 subdir('i2c')=0A=
+subdir('i3c')=0A=
 subdir('ide')=0A=
 subdir('input')=0A=
 subdir('intc')=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index d304a98498..96b6705b7d 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: fil=
es('pvpanic-mmio.c'))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_hace.c',=0A=
-  'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
   'aspeed_pwm.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index d6af2fcf85..b88accc437 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsig=
ned size) "SSE-200 MHU wri=0A=
 # aspeed_xdma.c=0A=
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%"=
 PRIx64 " data 0x%" PRIx64=0A=
 =0A=
-# aspeed_i3c.c=0A=
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-=0A=
 # aspeed_pwm.c=0A=
 aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 =
" data 0x%" PRIx64=0A=
 aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx6=
4 " data 0x%" PRIx64=0A=
-- =0A=
2.43.0=0A=

