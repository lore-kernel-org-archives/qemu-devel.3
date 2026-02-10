Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBD3E9462B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdj8-0007mG-T4; Mon, 09 Feb 2026 21:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj7-0007ly-2W; Mon, 09 Feb 2026 21:43:45 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj5-000297-Ed; Mon, 09 Feb 2026 21:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykYC5tw3CrQG31uL/sr7uVAK28z8zHxREniNM9zXzbc+y5KSAQnAUqwv+Y5DAsFJ45t9BeM3xudB+gPqW3ee+G2ks+NuRpB9IVpUYbgzZHzAHPMhMahPQgaXg7b6BbaiKq83+svozTFaeW54slHN/0ExAr8ZIdqGXY3YYVWRSBoStKNcv2Qs4/kpye8qvOMYjG7gOL7J2aBRmsPvS3oEiFQssHwpGBr2ppPwm4Aa2GQhKu3mQLHLIPsl9blV7CrwhZRWUDnx3LwlYKfFoeRwbEREuO7uUZgyznHLSYA2QSO+1qwBxco12MvV9Qhp9jCFSYDBirhbJFvGNiumruVgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIJ+iLDykOs5id3btVzlcGsJPZIa12RQ9PR7n3dHKoo=;
 b=ooUNeWScZOujQK/OHWd/nuAAqnSr2IpCU9LqTPOrnUTFmRCQwMk+1jx5qdQ0hJfAB3V7ycYUNZPMmzVe79mJCfxWh5tVS0v3NlVgI9GsLOmS7YplCvAVKPvjrb2HuE988tLS92viPFHuU+4d6VsJuLaLpW1pH9TPgGbDTsmB8WF1zwBUB71vtf/CUwinpJ5QcOBaxs7aN6cjFQv/pxH/8W4V6WbMnyvkTpCyDojnmNPT4a6aVn4pm/ejJCxCBQm7plWdxAsJA0P7RleLqFPg6S6kpx2cDJSKyflwbRR8E0WyTb092TZZJ39TzoIvxw3PMghPCli+D6Vo6LSfcbyj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIJ+iLDykOs5id3btVzlcGsJPZIa12RQ9PR7n3dHKoo=;
 b=Mhj+WAXZDbJRuk9Ys09uFfq+0Xy9ICqH+lE+XlAanVdWRvRxo1GHe7UaECCPkU9drw6HlNMEmIqE1HBkdt2Lk8sWUZvgFtOtw+BILHy5qwPrnLAK1kSSXv7ONS8wE4Y7jv+sPT3d2guiZ3DNaWFRilOuqoST3ADEn9KrZ1/TbKKAycS06M81aKXA9oBcNh0L+mclVJ4fgyE8zRpd0iGqFb4FNG1v7lDvc9CacjP1rX0oc7KW9kqwM3lAFqlcmd1trPANtsQ1Rw22A1A1V3kgAjNGUY/BkPlUFoR3HYbqRoIn81fY/ohdLjHUSxWbTCqwTc/varGmD8MMrCSMfMrzpg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB7118.apcprd06.prod.outlook.com (2603:1096:405:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 02:43:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:43:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 1/2] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO
 handlers
Thread-Topic: [PATCH v2 1/2] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C
 MMIO handlers
Thread-Index: AQHcmjcLKKxxCIbY+UuyMY04HaSIxQ==
Date: Tue, 10 Feb 2026 02:43:32 +0000
Message-ID: <20260210024331.3984696-2-jamin_lin@aspeedtech.com>
References: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB7118:EE_
x-ms-office365-filtering-correlation-id: ab9021c4-d4ab-4b2d-3887-08de684e2e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vaWQqLWAItlesJLvxrIUhY9mGBZOkkc++iK6i7saC2Mz57V93oUrrp7F/F?=
 =?iso-8859-1?Q?wWrvbS6kbOxLVnlgk9xjLCJE66rIzclw43Fpjnj8WNYlTfsFZfUEGCvbF7?=
 =?iso-8859-1?Q?mcuCLhV9j979BHctgwVEkhH250/xS3dTy3v50UAuArbGJvncc5A37vMM7M?=
 =?iso-8859-1?Q?n6ZbvexF7qlgY2aTq5xMl30jwrnV01sucUNQ0K5QrZXD3SiWbwmSDbcCs5?=
 =?iso-8859-1?Q?HAkkC8k7XkQ1ymGaqkduVQ9+StCaJ3FPur/5tr0SFk7EnTh/hh6wxOX2C7?=
 =?iso-8859-1?Q?yjfmt058N5gNNrHnf6a/d9D8SRVfMhl9b+ZGUsDg1hTo7NzaAU2cozxGmM?=
 =?iso-8859-1?Q?INSWPf60vcopLIySaxgc1kZ+OEdzV++t/+F6eelmTWkWVBssUoWT1YJRb2?=
 =?iso-8859-1?Q?S37PpJZG590Hy2c3W8d+KB7tsqlWvkTp0OvX4wOdTgiFbvzAl5NxPndx5c?=
 =?iso-8859-1?Q?eAOgnahp0rx7XqSANr7HcJIuve4uOod0jHxxX6hDyqjckodEBIu62IyZHb?=
 =?iso-8859-1?Q?1wn39jcmHIMh/F6qVw1UPXUIepAYOPE/omxFabhAdjqzJKbNmfQNPs68OA?=
 =?iso-8859-1?Q?bKCKjlld5QEZyqZnLKn8fUToAnQTl3/K/qh5Y1hFXxos3DykXZW8sXFcQq?=
 =?iso-8859-1?Q?EmDEKwYPr6zS8un7y6ZM4gAI2MBqHwCmtfApRxhSPmb/EiCQHRnXTyMM+C?=
 =?iso-8859-1?Q?xU+FfpLtkbtVzsIjC8LbIUusljPQB8qNzx7p7+X1/+JnZBxJAyAlHVF4mw?=
 =?iso-8859-1?Q?9QxAtZUvPq5JA9rWWS/uY424OqrvoQfjHCFeXZN26MjfEabDd4RhR31Wpy?=
 =?iso-8859-1?Q?wPcpj4S4mkEKu7OVu7FnlIxyxCe8FVAiIbLIjUllOiiCNWzhO7kah/rhWZ?=
 =?iso-8859-1?Q?NtaUEIudvAQCPXlO9lG25GchjPbIfGWVf2vTPEjllgQv/rAzYq1T7Xw2nQ?=
 =?iso-8859-1?Q?R8ONePJH0mGO3OcCTTdAiFXwEmGzlVAb7bwCWYVHHqwg0wOJIOt8Fe0oJ2?=
 =?iso-8859-1?Q?uze8tqnkE6dMLgxaiMs0T9LOuKCrbYW4Yrawd0icMEYs8gdv/MM5Im/l8+?=
 =?iso-8859-1?Q?eYLcCNzJod1YImr2apfYNu3PaP6EuHga4SQtO6W3rHWZq1buLrr0Z5DXQF?=
 =?iso-8859-1?Q?6+w+Cm1ZO0Nfh8ZOZ2OTIk7RDpcwFxYxEVH+g1Wq5qfqNYlKzo6/1J6K8r?=
 =?iso-8859-1?Q?uhdeHDd5k7pR4InOFOYYOzKqzPZyEacILScgzdGR97SuKtLm9gw5yDHkE+?=
 =?iso-8859-1?Q?pMEWYtLcuq0ZMhnLh7FSMdhv6xNjBrvk4sFB7Ex8I+rfkaCU2RCPz38Bk0?=
 =?iso-8859-1?Q?+Uextxmi0gdjljZ5anreZi4EZkLLW8SHyLc3EMLKkz+VNrFL4/Nh4Ob0UY?=
 =?iso-8859-1?Q?KoXhNBYl7CCoVz1guBZgh/k2f5HM51XCqkoT3ibVZud56Kcmt9ZjaFzKoL?=
 =?iso-8859-1?Q?EYDV9z8yrBbEThpIEt6OBX4Kh82rxXyJBTFDk99Ptd+tXmA60a5nt8/hly?=
 =?iso-8859-1?Q?KbZF7NJERSIAeN7NNsJTpF5fEXnQQ1s5sfBBXGe3bOo+XnO/5QnmE5dqTR?=
 =?iso-8859-1?Q?beZKr3LvLULF8Qh2uKofyvHUewT4fcNaYCUQMrdFG5hB8uBbHwVf0ixHMB?=
 =?iso-8859-1?Q?qhfEfVrnS7HXlsu6qjWLaLIvIbhR/skluT0t37guzJ/pXdpuS7TZZclkwu?=
 =?iso-8859-1?Q?3UJjgwKvHJ70qZNVCV8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3zThVCKAHrQFQLL7cBuFuNEy1HZE1O67EkWsxt6N0p6VIkQ9eDYlcFFWC?=
 =?iso-8859-1?Q?f6yQhiKFH+zdC4l3Yr/PrApnOUZ2iif/WnBqJTbNEwvJitaOqBXtCWSlJJ?=
 =?iso-8859-1?Q?JNIAsAie5ieWswZTUmGiEc+tNGqp04+7ho/kGnkdx2G7+5RZzZMFZm23bA?=
 =?iso-8859-1?Q?uTnfH7EEczBtDGTxOM3TsXvmb4fYXWaGuAtXBuKdHa6XPLXZuo/ZM09XOK?=
 =?iso-8859-1?Q?w8rX04P32MizLSOvRQfDSLhAm4OkguNH9GjwdeYBR/QbgS15juYwKbybHM?=
 =?iso-8859-1?Q?5lCWJX8hTkdvJwWystE2BHDWiHBmSCCXea+T++LvbUFQg+UxRqsMMkj2F+?=
 =?iso-8859-1?Q?u5nHREgVhGBinELvLr0hC6Yr+O7PG0TfNcPfvN3BotF++7mz7WFWt4eXcl?=
 =?iso-8859-1?Q?xndXi4tR/MHAiIZuB69XiVRs5Ic7nKXW4d4bhRDXO173vr9reFLMRn5BUb?=
 =?iso-8859-1?Q?hkDfh3EBbfkEfy+jdHnHkndjI+Qu7HKB7Q3xd+7dEny0Jw/OjdC7hncU1y?=
 =?iso-8859-1?Q?7GfRHDo9w/nrR5b7pyzG0SLYCeQ5hddHFnc6Kl0FbcNxtI7b1IItHfQWQW?=
 =?iso-8859-1?Q?2MXaJMoVo6uWrHaKjHe10feErhfVDwTFGVbFPXO1kQJPjj04sYVJ+2WRi3?=
 =?iso-8859-1?Q?FH6B6pMEgYbMhQCmzJV+FWalY6eytgRQCWta9oHObqiXMcXXgNhgpmj6nx?=
 =?iso-8859-1?Q?U2ujiOpYzTPR/FsUZMTgmWfODmBBYFE7pwFIDCa4h0sbozARRcCbH22K3k?=
 =?iso-8859-1?Q?P/fUi6uBBJ+E3eKrie5cV1onnIJItgxX0R87K3ioVJPqnZtFfEWBk8bVHC?=
 =?iso-8859-1?Q?b+n9OoEBaVsi+wksjuroBDlRdZekWaIlq8E+1ER+44pX0+JZMg65ECKqEx?=
 =?iso-8859-1?Q?etIHEbUYNmvN3HjgVgkw5tAaJ4ETipRykOEssE/v56htsmWiLo5R3CVsoB?=
 =?iso-8859-1?Q?s84U6r3UYGb5wRt0Q4+r9bUEfGZVTeipD/eTMlVAplaa2O+Qt1y+/i1r4z?=
 =?iso-8859-1?Q?Tyxtb1Hbk8dwwD5WWwtyBHIZdIvwAEZrBs71wAY+btwuBJAY70oLUNtiqU?=
 =?iso-8859-1?Q?Z7VU/+U90UWPuHbprsuAtyOA6+jRhDxTDlGZTtK34nNtClTKqYyPtJZnJk?=
 =?iso-8859-1?Q?0US3O+M83IQ9xNi5LPKuSUo3peonU7YFod2p9DiKHcMSZVcx25eA2Qvi8V?=
 =?iso-8859-1?Q?CO2Rzy/7WP9NiQ5S+q+r9QmJNvaHC4T37DmCa7o5pVt+afvfXq3Tm6FQMX?=
 =?iso-8859-1?Q?QzcEl8bTPF8laMwSI6b0+fTNLEQd8VtB2lw85LuxjZzvr6COYMHt4pTF4Z?=
 =?iso-8859-1?Q?lecVlqVJTYSw4X3CjTZ80TitnrvaN0H9e8vP4YUZad9A3TPObFTR+h8B9K?=
 =?iso-8859-1?Q?ersIcOGmqc6B+f3mj+XGI1/yWoQG1UoC8UQFvYrrBz7lUUnIadxSDB5W5r?=
 =?iso-8859-1?Q?1suU4Gsvqf6YFiKV9eUawP0eEfxQ2Yhfl9YA1q/0JjSg12Puih/8Bshdtl?=
 =?iso-8859-1?Q?3MDGiDc7CRtwlv566PJKZMfHKOn/XWK+8bxoVPVMONClR1PReDu3iFbntO?=
 =?iso-8859-1?Q?TnMhJIS3EoI7m/j2uf15ueFldJZDBkc2n9sr5PBRs0l68S8aINKgzAwfaa?=
 =?iso-8859-1?Q?WvIdGGwM+fijxCuNducu7rZ7kAU2lU2HQSkhhSTmZ8WkMkxcxdAlZDlTPn?=
 =?iso-8859-1?Q?+yrwFdeIoHH5puOXkwfP+A2biI1/S3rBT4ycUSbQ46QXLkyoxGslNIizsK?=
 =?iso-8859-1?Q?trdR9mm+FOdqC8GkNh6/pjSwwLHYcN9EoDVBZ9wkr2bPdLDU1WT5QEAKI4?=
 =?iso-8859-1?Q?KcF7VaWKVg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9021c4-d4ab-4b2d-3887-08de684e2e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:43:32.9663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21Vt0f1AbmxWHSoBdPFENIRf+DJ8F30ZvI613OfL8XRAn4pIUUCNRZ3AA3cB3ABYUuD8cguQFpLiI/QUoYRMdXDdrzsHR0Hm9c2zoDnKaVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7118
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

The ASPEED I2C controller exposes a per-bus MMIO window of 0x80 bytes on=0A=
AST2600/AST1030/AST2700, but the backing regs[] array was sized for only=0A=
28 dwords (0x70 bytes). This allows guest reads in the range [0x70..0x7f]=
=0A=
to index past the end of regs[].=0A=
=0A=
Fix this by:=0A=
- Sizing ASPEED_I2C_NEW_NUM_REG to match the 0x80-byte window=0A=
  (0x80 >> 2 =3D 32 dwords).=0A=
- Avoiding an unconditional pre-read from regs[] in the legacy/new read=0A=
  handlers. Initialize the return value to -1 and only read regs[] for=0A=
  offsets that are explicitly handled/valid, leaving invalid offsets to=0A=
  return -1 with a guest error log.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  3 +--=0A=
 hw/i2c/aspeed_i2c.c         | 22 ++++++++++------------=0A=
 2 files changed, 11 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 68bd138026..1ba0112cef 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -36,8 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
-#define ASPEED_I2C_OLD_NUM_REG 11=0A=
-#define ASPEED_I2C_NEW_NUM_REG 28=0A=
+#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
 #define A_I2CD_M_RX_CMD         BIT(3)=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index fb3d6a5600..741c7a7297 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -94,7 +94,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus=
, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
-    uint64_t value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
+    uint64_t value =3D -1;=0A=
 =0A=
     switch (offset) {=0A=
     case A_I2CD_FUN_CTRL:=0A=
@@ -105,7 +105,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
     case A_I2CD_DEV_ADDR:=0A=
     case A_I2CD_POOL_CTRL:=0A=
     case A_I2CD_BYTE_BUF:=0A=
-        /* Value is already set, don't do anything. */=0A=
+        value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
     case A_I2CD_CMD:=0A=
         value =3D SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus-=
>bus));=0A=
@@ -113,21 +113,20 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus =
*bus, hwaddr offset,=0A=
     case A_I2CD_DMA_ADDR:=0A=
         if (!aic->has_dma) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func=
__);=0A=
-            value =3D -1;=0A=
             break;=0A=
         }=0A=
+        value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
     case A_I2CD_DMA_LEN:=0A=
         if (!aic->has_dma) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func=
__);=0A=
-            value =3D -1;=0A=
+            break;=0A=
         }=0A=
+        value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
-=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, off=
set);=0A=
-        value =3D -1;=0A=
         break;=0A=
     }=0A=
 =0A=
@@ -139,7 +138,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
-    uint64_t value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
+    uint64_t value =3D -1;=0A=
 =0A=
     switch (offset) {=0A=
     case A_I2CC_FUN_CTRL:=0A=
@@ -159,13 +158,12 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus =
*bus, hwaddr offset,=0A=
     case A_I2CS_CMD:=0A=
     case A_I2CS_INTR_CTRL:=0A=
     case A_I2CS_DMA_LEN_STS:=0A=
-        /* Value is already set, don't do anything. */=0A=
+    case A_I2CS_INTR_STS:=0A=
+        value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
     case A_I2CC_DMA_ADDR:=0A=
         value =3D extract64(bus->dma_dram_offset, 0, 32);=0A=
         break;=0A=
-    case A_I2CS_INTR_STS:=0A=
-        break;=0A=
     case A_I2CM_CMD:=0A=
         value =3D SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus-=
>bus));=0A=
         break;=0A=
@@ -176,13 +174,13 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus =
*bus, hwaddr offset,=0A=
         if (!aic->has_dma64) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",=
=0A=
             __func__);=0A=
-            value =3D -1;=0A=
+            break;=0A=
         }=0A=
+        value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, off=
set);=0A=
-        value =3D -1;=0A=
         break;=0A=
     }=0A=
 =0A=
-- =0A=
2.43.0=0A=

