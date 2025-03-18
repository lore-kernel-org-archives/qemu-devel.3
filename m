Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E01C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuXGa-0000T0-7u; Tue, 18 Mar 2025 09:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuXGZ-0000Sh-0D
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:45:59 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuXGW-0006LY-QZ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:45:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkKXfF8fRKedV8AQVYXTRCC+XNtOqEISFHfoK2UOHSeEduepsP3CDZzpckwsQx2PQ/nmxUOnx2WmdXmfO/garRdDOg+B+3aQa0SP0OnejOFAXsVHKPg22ukdwyvJKV9qU/Ph+q8yCjp3puFRr2/+s0wk587WwZ1R+YPGLbccDgU4u/GeSIdajTm/NlwbU/dHoMbNKSM+UkN7flNsr/rwlrxnNqEb/mJ2ExUgPmZyxkVaKm0npwsTTmt4ROhPPfscjLA7bB5je/kU2C1FgV3seVJkEsjv+k+himUCPl6fLG2inZrpGF7qyhioPH0Rri7RQPATfiqlAsjZqqnUtBDUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=Mp4EMvwgmoBvdyc2/Um92fGYK3rTtd5JljrhWGSPbAjm2K9mpMOs0yJ6/A+HI+ucKvErHWvis4hOmc96SAIRcSFhekPrbAngzjaMOdl0a7kzuhVdhjEmryXEZVFc7nC+Lc9pEbTKPDXWhYM3jLuofiqo6GBJQpMrHZ3k1Tf7sDbEGeHyuTxWi2xQvvoyevP94bYeRbWV9qkR8wu1lhVppiwJzP3kvC2GmtmVrmkNZkQE8mMR7ZRM7m1QMA0b+YU5QsYBUAIBn0Vumhcpvl1zh/+f4n6DCDjxu6E0BEQ5leDUyx/Vqld9YDv5LJiMIrbT9QKxeylNrc2bbMdhlH+kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=ChfPcZDRqmjQ/Yrg++WvUI5uQfT5zMf2PBU14gK7EqQTI+ucVDhLS5Gld6nl7XrRRldZDQeGKWEXYyqqW0uxUTptT08wFBuXB0b2i81Mtjx5PAp2h7ZifbSfgPpvQD0T8B5ClK2ZoNKdqOvSBazDxtjqr9zxvLkyntJxjZforCxo248r1Kx5sbzAx2zNz2/E90HHO96ahy1lwerYHzueNxNwIcLg/Iuk0385gqCrudTYGkLJ9v4ehRCsCknpn6WLa6f9GGOu4r/+O0Y8H671PJb7GRUULYsGRYIv7TTWVKmdTNv3WXM3VFvIMo2bemUcgxQdJsP4+KHSlWvE1uPOvA==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PA4PR09MB5697.eurprd09.prod.outlook.com (2603:10a6:102:26f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:45:50 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:45:50 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "yongbok.kim@mips.com" <yongbok.kim@mips.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeAgAlizQA=
Date: Tue, 18 Mar 2025 13:45:50 +0000
Message-ID: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
References: <20250312142545.113929-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250312142545.113929-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PA4PR09MB5697:EE_
x-ms-office365-filtering-correlation-id: f46fc89e-1dc3-4407-d7ca-08dd662331ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZGzcEy9AJz1RreUHq+C7XRoXJnVwgvjBc1IMe8f11xpKMBEF9PdjlUNQm0?=
 =?iso-8859-1?Q?T6rJD1lZKiXynzsijqOj0i9/VGq9zDoLLqguoywN5kKMwwnVnSnmdQcjC4?=
 =?iso-8859-1?Q?6Fs9Mp6jRIZZ2AIDYrtT/uRV/3CfyZoRZsymnJyrEI0z6Vl7bKfsh6Tw5S?=
 =?iso-8859-1?Q?cxtdonfEihstrs22h+Hx+Dt6It0FGIhQA/OrPcKmC2BnZTiUxkuWMEZdQz?=
 =?iso-8859-1?Q?NAY+n97JkeCb5Zr9DAolaf1R4xk132T6L8IY2RzNvL5zCKV+LbT1gU+d0b?=
 =?iso-8859-1?Q?xgAP8Uj9KG4F9w4LCxMnMuS69gMrujh45cebeWyi/FxyBUeAc1R9/ezMQj?=
 =?iso-8859-1?Q?T0opntEJf1/LCAJxkQJU+cmzGWLfC2oXuEqBcsnJcnDzZvJF4U5biaAksn?=
 =?iso-8859-1?Q?CDoAeWgDaht7fQD3AkYPmUf0CpJcHBh82J07PfHU6ATFBy/Az2nR4C+lrb?=
 =?iso-8859-1?Q?woy3rOrWTA6kPClSJm6fbJCPpHF6wmQBTtv7XTXFoJ5WEhQUNGeB6ZAHGE?=
 =?iso-8859-1?Q?Qfla0Rst1dB5oiaiB7BexoIlZTh7gf2Vf7cktitjJFZQR9JGz2g4vFZqlw?=
 =?iso-8859-1?Q?xZyfDVn73/U8LPYtFSSpfZce81aKw576jH11KlnhmciW4TMomCPo4yaXhT?=
 =?iso-8859-1?Q?GJBzqcmsO89iRHJPRKeYuC6MsRKzbjnAAAwGNKKtWhICY3N/kvFFarxAw+?=
 =?iso-8859-1?Q?7hKy8NQsF8xdwBxtWjHonH+csiElQB95AHDBURHA3co1xAAsIZTc9TIRGN?=
 =?iso-8859-1?Q?bddg3exsVlCjIDdka2oS+n8RocVWMx2Fx+YwXvWPbY67ztzJDEIeRBqlgN?=
 =?iso-8859-1?Q?U675epmp71R2ZV7T2Xz6EMKnZmEgw8OlbnlEocHUOoxG54kTdL3wCQTRyA?=
 =?iso-8859-1?Q?at1B/ONWqAh0eFrTWqVa7rlfGwZrnShQ6y3ft5sz3J2yHcqMbhRc4VIfjy?=
 =?iso-8859-1?Q?Yckw+JOJKTnZ3vXLMfpXVaSmOywl/XPot8fJMYkdSLuUj+mpl5yp0317lY?=
 =?iso-8859-1?Q?2xqTo5hqJeXMCQ1Nep6PCWhoG+YxCk7KvkuXUbnaa5Vje3H+4KpXgATX6w?=
 =?iso-8859-1?Q?eXg7vBCmj0U5H10iHVP7ft57QkKJOaG7Q/13UQzCRJmGVFMmNG/K4/Zm2W?=
 =?iso-8859-1?Q?kL8oNsoxjgiv/H6xRFjqI88eDPIXAZ3j6963xe8DGyTzr7I0qCcd0HbVj1?=
 =?iso-8859-1?Q?7puSJ8vFiRQZ3wgermfAHJbWrS9D4AKKd9fvs+vLTzaNNrhz7oR4RZT3uZ?=
 =?iso-8859-1?Q?6gsw4lV4XZVFdEzcG7PzOfmywnqquUZfnnpiuhpHowB6hB3tVsfq41bwyS?=
 =?iso-8859-1?Q?7FVQmrBzKaHutU/+h1L6ks1fwNBpwaRB3Dtb3czPPEPBrcujjsc2RsidNO?=
 =?iso-8859-1?Q?3muVrFw/xFuf8ujX/MADtS++tkDgLnk6KP3e1bxkhy1hKTReW1NaZLiQtK?=
 =?iso-8859-1?Q?0UdXEKCTKgbttpcXm9CtKqhQ6KDeclPFKrUhWKH2of1qp7xgYD9Bj/pNnA?=
 =?iso-8859-1?Q?LpUmXaGFssL7zhA7/jhNUK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?646pIXsKYNbCvXQgLJelpnouIUJmip6YedyHbe04u++w+3/WHZyHPK4YrK?=
 =?iso-8859-1?Q?tBtCWmW9EdO/Br9ilf/1asiZtJYXBhofDZJalgvRipnSpel1LrymlFsvop?=
 =?iso-8859-1?Q?MLMyATk5FlbcNbN8icU9QmU5/tIxppsEbK2oZQN8GJdVbnSYR5S3jI35m1?=
 =?iso-8859-1?Q?Epv/Y6sWvYFUxVyhBZNPc/OF+BwFzQEKEMWVEm4jyU1ZBIKNUVMATV8k1f?=
 =?iso-8859-1?Q?HvxrP+c/uqm+JEx2ZY1WztarcMlznMB08yeQbUc8ybLbkTBOgSrqWChGCo?=
 =?iso-8859-1?Q?8yOZ0od0NaL7v9T2+TI2rpJHfZq1LO3e4jNmsb4hc1sHhbGZxiONEfuMGc?=
 =?iso-8859-1?Q?nn3jXYrjwdvS5+YwIvXYZRX7k9GnQ/mFInc1D82C+fQICy6jZlhfpSxwn0?=
 =?iso-8859-1?Q?QL0aj65LrcPL8p7Pp3vnldJ4WxzA5bQtm67fvzQ349A9lxpKe+slSC2cx9?=
 =?iso-8859-1?Q?U37x83qxPpcdXVc/BPUCvrenIbL1S5F4K/Ajk4p8tz/pFthDtymYxPpyLG?=
 =?iso-8859-1?Q?xMoRAWUX03gPelg2dVOil1qZq2rP5g7StINoODs4lMPzrpq+izhUXd3OI0?=
 =?iso-8859-1?Q?7uv6uEz5GbmW6lkWmlVjvfnktn+oE2dUHlhGHqvvMv5ab3t13vxKYBcT7v?=
 =?iso-8859-1?Q?kal9At5jrtq4ZmgUpMcz0sVEEwpiark6lUzRgni5ppCoqYUbsZGTSP9ifj?=
 =?iso-8859-1?Q?9fHELoTbVJaS44oynHwhkxmOX7j7QcEmNjZwVuYDvxPDV4QIYLwdLPNcCb?=
 =?iso-8859-1?Q?Vr8TC2YegLJ+ctwNeCuMmYldqFUaiej+QKz5biZ7qJOnaiQUDDvlNhO5HK?=
 =?iso-8859-1?Q?WxYrZFz561bjX+wZxEwYJsZBbX+/w0JOzI3HTRD8At2Zzgwa0Uwdcc2e01?=
 =?iso-8859-1?Q?OOqwKyKPw2pcRcoSQx+zcqFdRd+cvk/gAkvsTVoYqmEumRHAiha7qOcawY?=
 =?iso-8859-1?Q?H1/Es7d3fuWpo/WRvE06lhw3cJ97aHApEwodKXIQ9LeVf3WgMYWjKkHlXV?=
 =?iso-8859-1?Q?yHBljzuOuUZC79iYr1weqQ9x3ft11fFqLT98RMWw462Pg8UYdyev7KIuAG?=
 =?iso-8859-1?Q?RBQhztX8UD+noXKRiIbVqnaBs+m2mqexqZyimjrgjbKeLGFSIHFixyjHBj?=
 =?iso-8859-1?Q?C31aHXbqIVN+v/VeuanzdSwve/nuTInLo/8Y/rcq4MkGycwtIdXyBKBgc9?=
 =?iso-8859-1?Q?7TLwaQVh67XZOf+KJELJ7FkeUVyLolChupod1BASTm9U2RinaR/SAxalbf?=
 =?iso-8859-1?Q?oYwsHE6IXLWpDqXPTVMRYVDVck7RIrl0mDC/J+QiHwbK5nTSgS8/z6k83T?=
 =?iso-8859-1?Q?e2mA4NJXBCVy0PpB9nc7pUHUGgLddGz0wnaokTyBBPr6brV3/hMyMAa1Gc?=
 =?iso-8859-1?Q?caNlVIY0E4efynKY4rT1AXfpzRFihKsaeB9UPoPaf8Z0FTzuqL3tdYngFO?=
 =?iso-8859-1?Q?0AG9rzrxIiB1zkRJCp1+gR01cRd4aLYfligUyRvaLfqkMaLEau5Uju1hf9?=
 =?iso-8859-1?Q?1D09Q4qlalVxW+KadzsxuCd2zgCLhVyiEGamOh2Sf7G7Z56kval/RpnZjw?=
 =?iso-8859-1?Q?Vx8BFHM1FakNh7RC3ptvTwuh51bwzHMVEguplj6R+e4Yu6X2rY3amNXd+c?=
 =?iso-8859-1?Q?MxYp2PHOmlJmt58YDYAT+mBI4001hOlcPNID0bnt90NOywZ+2nEINKvBFf?=
 =?iso-8859-1?Q?h9B15PHBQMpDlDYmOHM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46fc89e-1dc3-4407-d7ca-08dd662331ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 13:45:50.3239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH1VvPjcI9qQSlXopx1+qxYWiKp+p8gmNIPhkcFaqYyvjlFXr41kRUhJkKU9mGxtGoiVE28rPWHbiDbWGzg2ui29KEWW5QRAxvttkqJJSHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR09MB5697
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic=

