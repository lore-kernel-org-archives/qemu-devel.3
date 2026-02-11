Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0BEB594D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzla-00054W-So; Tue, 10 Feb 2026 21:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlR-00053F-GQ; Tue, 10 Feb 2026 21:15:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlP-0001ez-84; Tue, 10 Feb 2026 21:15:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqaZ79VmtFBHVxXIJys2hFTxMyvWW8+X+21poq6dK4Y6wxUntc8jiS0hiXMk8uyn0fRJszFz+ing1oa12P6leUHgeaX7AM2WoV+WDznEb/SjhGoZML8ObXzjeqhVXyNO2K1KmmDfn3aIij7sOnVYVWnugMTf6fnqahgWmS4vmYz8SSmLE3TYp4xXqGj1OSDqtNQ1J1G2JOUTMHO4cLLQpeKJ/PrF6TtugX5wZeBTRvdHC5z7tLXlNEXgatyZNb4IVggJ8+exegx5hLci/v0s0PzzcKihWerBP81ToFHaaTVbQRpZ8faDKXZpZLMutQhRl7xBrYS2FP/vHt22S5gJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLpuepQlhgKP316JZWx1Ct321AYA57nkSz9prM8OjBI=;
 b=tThiEg5MYXYoXF0wrZAIciYci/wkesmcMarSsMG6sfiBT4vk3J8qGppk5sn3EltDl3DsUCba5duJmWKLvY+LhAhdzd/JsLkgBvTidaItU1RJ+lS09WmvgKRkYjFXguCGKb8yXLE/Lip200apJYj0DzUEYvhwDq27a2ybjgvSC5d5A/2g52wiA5z2ASGryw1IZRs+lRVPvM1Tf4VmV1d255v53OyCuHBsY1u8qtDmxbnmRemUEH7ZxRfxfNxxSF3bdZdEY/XbFmN/BdUzQKA+9BV19bG6jcM39VAnYesZmU41DIQuuhXlud3JeXnDsb9nwOdFzGc5BtVLIgg2hzEM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLpuepQlhgKP316JZWx1Ct321AYA57nkSz9prM8OjBI=;
 b=DLjxOcpfAihqE9J65f/PyMbrQ85TeToFCr+jDSaAR8cVkezXIY2MSKiupY1hWgP9Vc6mnjXJ2/cPBkxUXoRqgMiJSTaR0o+7UN8nvqjLKwU8GFjmsjJFdSMRvtQjfyVKjWqda/W8eKdpZfDf62EUSy1+B5NjQxECRsmsm5ct6sXC23BhPfxem9Zx3IDiGgLXtDe5ggA+ztxGtUgsJx4ufhQdIHm02tthS+9HbkPSHfyl8O4MF4jlCnPwUag41q5kb0UYEnYGMxokJm0JJIprhP426FQ5Pv2T9IkJNz6kOjgrFm66dA3OERpqRmNxMkyrG4yUC5QBQPPScRED1H77Vg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:28 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v3 00/11] Support ASPEED AST2700 A2
Thread-Topic: [PATCH v3 00/11] Support ASPEED AST2700 A2
Thread-Index: AQHcmvxKFStdr/iCmUS4WNlrSbnuiA==
Date: Wed, 11 Feb 2026 02:15:28 +0000
Message-ID: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: 827113f5-6546-4bba-ac5e-08de69136c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mi/hCjAZ+/fTic88P0ZfAPdQKCuKPoJ8HZoon1PImdeUweI/SDPaFI0a/m?=
 =?iso-8859-1?Q?RgTw/GB1F2gfXSz9eu8Y3KLsRoT83EliS2o8Z0xRozplZoZiqVmRJVjqz0?=
 =?iso-8859-1?Q?YvinZeHoKLTjjkV0LgQdrp8ijDpmibqt5fVu9kTY8P1jWobazAT+Gq2DWv?=
 =?iso-8859-1?Q?qVgjlel7x+yGIANYJ+fcHSNC9lqhMo4r7/I+y57Yhwltjyg+n/vdWLf5uN?=
 =?iso-8859-1?Q?Iux4KfoH/xEHtZkb9zrcfppoPqAGuYU8DVkv7IfEtGm0Pqoi2aDtjCI4jo?=
 =?iso-8859-1?Q?MVKI9pwiyMPSu2yD8Us2Ab/Yb+XB0ChtYFRnr5g+Y/Zm+T5kSbst2LtrY+?=
 =?iso-8859-1?Q?i7bMPQJmWeWeFyRSOrdSKYTlvkKUpuzc6H0570Y1Hkw/zdPtn0VJ3uS+9Q?=
 =?iso-8859-1?Q?Y9R3fgqLvu91IoUaJU3CTU0WzuuD8pWsNhhXUHOZ+LpxApNkHE3+TP/e4w?=
 =?iso-8859-1?Q?mRlzfsfIYq8JfM9uLQFqFH7g3c1d8qKSvuu3r/XStbaQVUa+uH8tc27PXN?=
 =?iso-8859-1?Q?yib5hq6VwOu5h/f2plL/C6YAJNLWfn5IqW3h9YAdUpSWudp79hxc0xjIwG?=
 =?iso-8859-1?Q?6U03aCaWXJE4MbLUnisnOUqLmufElgFQiHMr6GsAE2kjq0en5UAClHtvd5?=
 =?iso-8859-1?Q?urcNB8zYzvOLVMcBE4gJcsQ/1tQuDMe24c/qup0r7GX+hwaW6FrgP8HV82?=
 =?iso-8859-1?Q?AQbtxX6yVt/QSQhgYHRNltX+qVLLwR+tE804TQGwyAfshoGLCA9U0Onn1C?=
 =?iso-8859-1?Q?SCh4nbGVCSsQ/JWQw+jXJkvLJeKpO7hmQt8Ncs1MFZsuq2PDS3Ze2zpJP8?=
 =?iso-8859-1?Q?wjAQD2HZe93ROSAFHonMEOykzxf09LSDAkGEGCkCpONv9yi4KUgch8qtIh?=
 =?iso-8859-1?Q?cbKm++9ETTP0qt6XP/5In5bY3u5WFSiDmYWZTrmb7ZPccALc6FqoM25S45?=
 =?iso-8859-1?Q?ve1JpqSNdLM5r3GovL9CmuJua5oam+o1MkSTBM0bu5qFwdkIQXtsajIyTj?=
 =?iso-8859-1?Q?p/O2mq7L7pnMcQ8pNTW2Vn+YqJ2lkLCk3JjvSBEM5zDl1S6pxaiovIV6vx?=
 =?iso-8859-1?Q?I5ZcSrWDgbky+MJ6uS5/qwtuwewMeKfuMcZhuh9kRbLZpNMntb4pQiNNzT?=
 =?iso-8859-1?Q?w4JkzC0yZDN6MXdKORCVfEYcvzielWE67WwRXhzX1K99BOGIisHJ3KB9oG?=
 =?iso-8859-1?Q?CPksJjE+dzQ7gg+oy9sKXNQNc/5iTIvZroqQEQ+WTAbGeX7K1TZrlz0Bou?=
 =?iso-8859-1?Q?GACj4lAoUw5gTGtWyqMPYFanqMvT7YPlulJKa1hmDpX6zeRQrNnf93YG9f?=
 =?iso-8859-1?Q?0Gfcodrx5LtIHCCZtl9fwA9eaKuazRh5/v+6JkXXDeYssWbpAV+MPYPozm?=
 =?iso-8859-1?Q?G5JYKtV3vBlzlhCa236SX8I3pwHQskKXM+I+ky4EBpEUo/fpkGE+44anXg?=
 =?iso-8859-1?Q?5/81oweW9Rz1AhooxJi0Gu7wxq7xKVnqeXMFZphPCxCyN2g8fJr0XRTW/p?=
 =?iso-8859-1?Q?RXjjpJJrkiDJEaRfT0P8rM0Of6r9G+slVcd9vpAJ+jV/Trf2dgU7VK5tWh?=
 =?iso-8859-1?Q?biwI+e8uAqxu0ofdhfwvJKaTcejAANzsUCH8EOTAhpwwb6NCybxaLlFiOv?=
 =?iso-8859-1?Q?b/3XvPwSs6DK1d7zLyJY5shkaeCj+RfbynxJ1kUZFJW3/aHmPXeeSFBOTH?=
 =?iso-8859-1?Q?RECuy+6gfpbtkKton+NQd2imuGi8DLPXA2+2B/XA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MuFN+bHb/bgeL7DTS7IvgcgdopH1oWy06kRXBYS6IZjsL55MY/yT92rVlk?=
 =?iso-8859-1?Q?wZ6bveb10RyVO1B9UvAd8HGfoJibwwIDAD5duyr8ZN3chOQfLLALv4sD00?=
 =?iso-8859-1?Q?07WF6lS17cIZWJJeu3PW8pQW+iI0n2YClISCVm+mQ1Y+3AItpow9Pjx9p+?=
 =?iso-8859-1?Q?GFi2nUMVq2x2SscmXuxgOvMA96j4192th04uGUocjlpf0A9E4gKHjMaPEX?=
 =?iso-8859-1?Q?ZF+o1SAyB/OjSU7MSOLK1w6dZo/0WqvAg1Ix+RLxXkv+UBjfokVakSCbQ8?=
 =?iso-8859-1?Q?WBf31A34/N+cjNcwMCvqwnvItnu6MEZnq8lfRRprXiDVrM3W3oxUUzVZK8?=
 =?iso-8859-1?Q?8jHcdGOv4rvWcnz86eLLaO4oSLcAh5q5YNyctRyxCRVA3Y2e0geZusD1Pk?=
 =?iso-8859-1?Q?lVcuaQb95U4cqHZ1m8A9ndGPl7UEgtVcgIZbS/1+UnS8hkvSQW65TCDgJz?=
 =?iso-8859-1?Q?7Km1WF/z82X1iGClvd81F6a7E+9ipKNlReo6C9MArChh1Dv3rHUvcE3/rB?=
 =?iso-8859-1?Q?aTeVTTxAWZLi4bY3VS7rRLD3Yff73C9x1IfkgtIgZIhydSAPDBgSqNJ8bZ?=
 =?iso-8859-1?Q?MORY3CgMWZoVA9gURyurwL4NLa/GzMwO8xdO8CUBxlX06NrWqR3e/Ib0uM?=
 =?iso-8859-1?Q?ozKwDPKtG2XFe2A2CcsLC+RLk1mV1O7uRv8Pvrtbmf3TxbbwUB/1damC9g?=
 =?iso-8859-1?Q?pVEv0yxZMxQKj8kkB/Enaw4oc0tZO9031a6GonEwmDDf+pWYrOAyw6h3t3?=
 =?iso-8859-1?Q?uRsChMd3p2dHY3bo4SqnZOMxt3+/sbuv8c4t6O9WhMQ4kd8jXcn2TQOXuD?=
 =?iso-8859-1?Q?0Rhb98SjfPlJgQPCclPS+lSRwUOq3FEn5vmyMp5HdwhLUEehVdSmsx4m9Y?=
 =?iso-8859-1?Q?Fq8b29DvalBQ5W+pmydo3aFBYbnpvMtcrZvZj8qr16uHIZQerslP04UfHu?=
 =?iso-8859-1?Q?aUZTnrpaJcDIe48hQzdOY14Rv+NVoLVvq/3WMikzvYmJAS3wpljtvVYS92?=
 =?iso-8859-1?Q?R04zo7CUdO/buDwBMFt6NQ2NqufGQyjnjp9gPgXSIUSlfu69ox4cpfVzQG?=
 =?iso-8859-1?Q?xpNiOx4xioPpfQiZTZPVA66/Nj0IOtBXR5h6OKTGXDNnW8kYu4SXn34kJw?=
 =?iso-8859-1?Q?Z2Z1aUOF2x7nuFAt6FYoQ+IuUyaRRXdND6Z7vjnPhzh03ZtSUM9Rc6gKVe?=
 =?iso-8859-1?Q?mV8VWYULDxlptOv+5NYbs4+LEHq9JdKV4G0gPR3ioMFFLC+yvZJ8c6bvnv?=
 =?iso-8859-1?Q?Go4fAJXBJFozKf7gHXWg7KEpc2N/hD3wB9fS4OwuV5y7Ak+UCCMCaatPdo?=
 =?iso-8859-1?Q?X/nQwAw4PmnvN1JgeLLC2d1Htgkz+q1R3jw79V0sgP+UYD01C+kiJiccCF?=
 =?iso-8859-1?Q?H1IZxo3qim5I+F42nsFgnIG/QDFGHJAKQvDvoSMVVF92KzP0gKqVaBVJgU?=
 =?iso-8859-1?Q?axLyqUYPhHSKFLliWOTgiLXbvPygaoe8TKkhwfEinzppAH1x17zt06ykyx?=
 =?iso-8859-1?Q?Wr3YXvBYnaR6deKaK32u/+m1cnvkPmSn1A5IMk6JHKJTfEKzLEMaWTFazM?=
 =?iso-8859-1?Q?1QzOYzniGN4cO3uOJ4mFmNB1+JhZktv/H+ZGlSeftpk0DE4fYHSmoOa1mk?=
 =?iso-8859-1?Q?TZSh9z4eojclMBeLSif6+Gab1xsY4gBCdFr5zTCH1d3TAT4YWE40qCtGQT?=
 =?iso-8859-1?Q?RPDFgaoP6+bLARALylDGBRCp5jWSTR0tnECGUyGs+d4NwTwPF4lE8/GSf/?=
 =?iso-8859-1?Q?R3muUDgIo3ys3tfRNp+XG1jC2x+hd1HCI+Yvj83XXQOKEcTURSRvda//eQ?=
 =?iso-8859-1?Q?VqbNtlDhSw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827113f5-6546-4bba-ac5e-08de69136c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:28.0194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fh3vBgbqPKhMvBRNWWjCjIUs3kNEvFlUok/DxxvtiQt7XCpOo9yMvJzWFBGWgjeDA8FMia6Q3dfdvnVUZ/3WqUwr7VXpbWrgMaSQLg4FBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
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

v1=0A=
  1. Add AST2700 A2 SoC support=0A=
  2. Add AST2700 A2 EVB machine=0A=
  3. Alias ast2700-evb to ast2700a2-evb=0A=
  4. Switch AST2700 FC machine to use the A2 SoC=0A=
  5. Update functional tests for both AST2700 A1 and A2=0A=
  6. Fix I2C Fix Out-of-Bounds access issue=0A=
=0A=
v2=0A=
  1. AST2700 A2 is functionally identical to AST2700 A1. =0A=
     There are no changes to the IRQ layout, memory map, or peripheral=0A=
     configuration; the only difference is the silicon revision.=0A=
  2. The ast2700a2-evb machine is largely identical to ast2700a1-evb.=0A=
     The only difference is the default DRAM size, which is increased to 2 =
GB.=0A=
  3. The I2C out-of-bounds fix has been separated into a new patch series.=
=0A=
  4. The increase of the I2C device register size to 0xA0 has been separate=
d=0A=
     into a new patch series.=0A=
=0A=
v3:=0A=
  1. Rename to test_aspeed_ast2700a2.py for AST2700 A2 testing=0A=
=0A=
Jamin Lin (11):=0A=
  hw/misc/aspeed_scu: Remove unused SoC silicon revision definitions=0A=
  hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions=0A=
  hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support=0A=
  hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine=0A=
  hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to AST2700 A2 EVB=0A=
  tests/qtest/ast2700-hace-test: Use ast2700-evb alias for AST2700 HACE=0A=
    tests=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Rename AST2700 A1 test=0A=
    to reduce test runtime=0A=
  tests/functional/aarch64/test_aspeed_ast2700a2: Add AST2700 A2 EVB=0A=
    functional tests=0A=
  hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine to A2 SoC=0A=
  hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM size to 2GB for AST2700 A2=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK=0A=
    image for FC tests=0A=
=0A=
 include/hw/misc/aspeed_scu.h                  |  11 +-=0A=
 hw/arm/aspeed_ast27x0-fc.c                    |  15 +-=0A=
 hw/arm/aspeed_ast27x0.c                       |  36 ++++=0A=
 hw/arm/aspeed_ast27x0_evb.c                   |  29 ++-=0A=
 hw/misc/aspeed_scu.c                          |  11 +-=0A=
 tests/qtest/ast2700-hace-test.c               |  22 +-=0A=
 tests/functional/aarch64/meson.build          |   6 +-=0A=
 ...ed_ast2700.py =3D> test_aspeed_ast2700a1.py} |   0=0A=
 .../aarch64/test_aspeed_ast2700a2.py          | 190 ++++++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  16 +-=0A=
 10 files changed, 286 insertions(+), 50 deletions(-)=0A=
 rename tests/functional/aarch64/{test_aspeed_ast2700.py =3D> test_aspeed_a=
st2700a1.py} (100%)=0A=
 create mode 100644 tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
=0A=
-- =0A=
2.43.0=0A=

