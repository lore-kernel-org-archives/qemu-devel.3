Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5673EE78D74
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNNv-0004ZJ-9p; Mon, 09 Feb 2026 04:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNs-0004YH-T0; Mon, 09 Feb 2026 04:16:44 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNo-0007H3-Rl; Mon, 09 Feb 2026 04:16:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FunROD5lbeWYqaYHjFwNwls/x7RY+VvHJ4lgkNjCUKFmUgGjoBNfWyJxyGaycvSloRExxkxpTWx1Ode6EMW0G+Y5sAOBpJRL3MtjQPbUCwATl9W+Kyy5ElW63Cx3evrFHfRf7Zp5bVp3L8DrT68bjhkhyXhoXdPmj1FIY35uzD3RkqfK4CMkcStVMjBAI/+6bk9iHtFCk0vtuxdSJETMprmJjseogclMjTEzsgiGLo5c7dGjdTOw38MqBXVR+akh88SAB7iKqv4zMznGLDt6nEDs22H7zZ0cafmS35MnhayImRb5BhsnV83SXFma/akZoLqom/Psiwoe2Kl0JpJ5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkCGLCsPdJW1XfnAqob4+MVdKWiMa731AbyxDnSUSoM=;
 b=lFynOMn7GZzG4dDmQRwGmAnK28xewc4dgvdrUR40uwTDbePzeiaF/R0kDGuCG4DlsDHgqfHk0qyjng2gtk+6SRzpAcD2qZbWlUl3Qn/EmjNaIL9jZqBhHMS54KyZkzcWF9XF8E8+jldmsHMhe5Ou4Vx89hldBZt+q0mR3lyuk8ebwY66gerk7IXmCvI34+jDheS0cQE7TKu0/ZwGNG3Jsoqath/2OyAVQv2ITtTNL7fTUY+2CoE8MriFZ7gxH1QnOlKLHJ1dkVkOsIQb+KXwgHOJO72kyD0dGEgA7jzfyIilivsOEkfGqXUOYnB4LPoD6XQkmfyFEG3yfpqwbuXptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkCGLCsPdJW1XfnAqob4+MVdKWiMa731AbyxDnSUSoM=;
 b=Feqn5m+UwRPFkvjdv2842Q49OWJQ09uIclWwYKH9kgqEWe5Z9Ly3Uoy/x/c/ViLwtns2uSBQq066mN980iwBAGeBzx/gOG5QFspDhdtSkXq6o7gNbhodj/Dozn5Ebq9XrMemdfvxh6Npr6kGlEwckqbezs7XcfSiN6XwmDSd4c4V9AR+WZ1DMO/HxZmJWqKxdwtw7MQMTscLoF7l5gKAak388EH9X2Bda1LxqpndKbjvwNxrstzT5i6VQj/qDEqFx/3X7EYE4S6XEfVQMolkB+1VbNxSL/PB7w9KOW78I/cA4IWFNTYkUPpszwrTNmq9P6kZWsAdbdz4YlwRy0D61Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:34 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v4 03/20] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Topic: [PATCH v4 03/20] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Index: AQHcmaTJw260U41XLEKhUbDPKQbasQ==
Date: Mon, 9 Feb 2026 09:16:34 +0000
Message-ID: <20260209091629.823457-4-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: 728a777b-b16a-481b-4eb3-08de67bbebde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?N39kzuavx27LqtGlWMBMCbs+kB2NXE2P35DL1vvAfdFB5JUuM2qKBHaPjH?=
 =?iso-8859-1?Q?+oyEah0ceagkHczNFJ4sVfABu+CdSdANxeTFDEUPpNJZhwnYtJOMHcI0f4?=
 =?iso-8859-1?Q?Wh+1cEh4ScSW7IDxX1g6wx7RUG4Gt/cQRM3JV3+AXQyXjPfB8DtPjBv1wP?=
 =?iso-8859-1?Q?aPjNBjx91UABAFyayr6Gk4pPFg3FoFMk5xQF+H+sumJTbc8eIlTZRIyRb/?=
 =?iso-8859-1?Q?KFFwf7qn1OiTwg3Ug8Qq1hpS0BysIgZe67Ni4Cb23GDYjlHjV5R+rwYqjj?=
 =?iso-8859-1?Q?Qs2yFewk9SkM5ndqeSUgLt7zjEBzppeIza/l3qGNlLSzpU67xv94FYTCfT?=
 =?iso-8859-1?Q?0k6QBTUJ2jwS4caWe4xe6fK0kdbzvivY8dtHVek9Q16DZrKsgG72TE/ytV?=
 =?iso-8859-1?Q?OKsjAkcAXkygXw+m0UJ46faKVMC5k/sK2vkr2DB28ttOXAv7QMhNyUcYAe?=
 =?iso-8859-1?Q?Zg5VwzM4trge4oVQh1SwLhaK2+VyuAkPG1FacXrY+/tBFxNmiqnwhCWXZH?=
 =?iso-8859-1?Q?Fr6nWXL6jFiWraQb+NcuaVl00bAj/hpJXe3RThRUZrHRbq/YYIJKyGsW5c?=
 =?iso-8859-1?Q?wfHKQYGJWaFnL89uE9dMfJQc5x4JYWmsryQBVX+mkE78z4AsAqkMrt7EOz?=
 =?iso-8859-1?Q?JSlQrym9jdBbtvNGkF1aPMcCncL8uxHG2umTihO40gdDCAeSmcmEF5aSG/?=
 =?iso-8859-1?Q?Nws7H8KWyHIg1mZ/JeYBr///3lAD76RrSEz6aJal8sR9KxF6kXcvwwUphS?=
 =?iso-8859-1?Q?YlemiyG3AjNGGsGpt3w5P7yk8rUVn0o7MznW9j+jcmu3qbpfvJCtK32/7S?=
 =?iso-8859-1?Q?jMfCZLv99VkTHLBaeZaVv2zss1Yat8U2YJsSBikZqVNGa787scRGudZ6Lw?=
 =?iso-8859-1?Q?n1m9rwCu0Ec58Q6D6y81D9MU0Q8QwCEK1AAZdhgHFfaY7R+OpGwsJa/Qbg?=
 =?iso-8859-1?Q?pwJn1OK/mS8BhRuVKxsbX+2vQvk9S+7ikyt4MJ9Gt8Uwt6n4TZyNAp2uU5?=
 =?iso-8859-1?Q?kULQZ5zj+0N5teV0JhE9swCsB6gDnXSZAACnl51ir01JAHI+2y/wNX1wht?=
 =?iso-8859-1?Q?jh+8RrZUX4C4A2/u1Xv3ghPsSAUaQzZFZfEhj/4gxDUet9tVuXSIpBcjN4?=
 =?iso-8859-1?Q?+bDuisphBHtx30VJg4g46m282+Dj/bnF5MgqOYQX4SiJka34Dluth6M6vW?=
 =?iso-8859-1?Q?Cazhcr9fKTGnEIlJdbAsgKMjUktvU14N5sji+XDXT5c9WNPNt/ZJGMThnl?=
 =?iso-8859-1?Q?UNxRDOlu3x0VpZSH87SrUiE78Kq9qLXfjfv+l37iE/oV63KldQUrJBO/v+?=
 =?iso-8859-1?Q?dqAIdNcTSjok0NNc+mEeF50ld41wa/ct8zdaOMFMQXJK6rBQEW0tP/n44i?=
 =?iso-8859-1?Q?1/b3emho0/XuBC4CJV9n6MSPdp1pKzo/bkq8ZR1cLshU68zVtMdKXavk+x?=
 =?iso-8859-1?Q?ES1E3JH9mxMZ8B+WHIeita1Tb+bZkdH3jD1bzPuRnez5J1xwAk/ShhhENt?=
 =?iso-8859-1?Q?nam1XM1gP8DXIVT45QZAlCH+4Tdbx/iRrTb1kcBQ83AW2WPeIwPze3F4+X?=
 =?iso-8859-1?Q?3rDZyyk43OWkuAQm6zcTTWHX+CKuadqTxatS5oMl+pQs15pDCSqBR7oqFc?=
 =?iso-8859-1?Q?OWuGRE1FqOMOqfpLDSx0T+MVoCvWdQoz4CrHcxzjynxJGP8KTd+a0CQE+t?=
 =?iso-8859-1?Q?a0r0kLzBVFSeroCp0PY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?30qfMJRk/zuAW5zgaX8sBbZwPGc5nseDFSuwzTicYBx/Kxs3YiLrOM8vJT?=
 =?iso-8859-1?Q?IBjbRRlYZ2xV7AEbk1xQ9mUz4PcztEwCrmB/yusnaqS4daqeAE5r7EqHzP?=
 =?iso-8859-1?Q?mjr4BT8ujyWsOpICV3BsJdKWPxNYeL6m1PeH0huyceQjUcSGeXy16MV739?=
 =?iso-8859-1?Q?xgF3N6H+emVH4w7TasaGw1e0dtzFrIfA7JBHYRk0H+h8680AoXwPsg7GYg?=
 =?iso-8859-1?Q?p9fdmTahozmj7kedgsCLq4yJdBNMgbgSh2Wl8M9EQtuXkV8tYecJyj5l5A?=
 =?iso-8859-1?Q?fIJFGy0mPP5ieEEURzZt09CBiGPm8yTNCb+QBJIO9gaWMuEBHw3hbwHJil?=
 =?iso-8859-1?Q?XFAn2SKZh2kxdRdfOVNvoeP1vKflaZZKq/UZGyBj8u7SDRcCHMofbNli+t?=
 =?iso-8859-1?Q?pWg2VzCU1g1TRJoVkgzA+4UjZtS3igsQp3CubbuFhvUXSFgfwgeGL0FFSw?=
 =?iso-8859-1?Q?t7JllvSd90rU6ZY0cfLvS6lLF/AruyBkdFpDbODZDBQxMB8Iid7jAvSqLc?=
 =?iso-8859-1?Q?4P0kSKqDRdr8rJb1lOj3/nl2LSbTApvWlUwDsgxryXUkhv2CV3Dgl3leeC?=
 =?iso-8859-1?Q?RE3yZq1pby+L25Q60jJaR2W5J6mqbw478ZBDiW9oKp+cR0HI685SqvJdLP?=
 =?iso-8859-1?Q?Ke/cCbUyt2x7uNSog2h+sYPNlcnw6P+VfPqc7r6EbeVf66pKaHMxcXugEv?=
 =?iso-8859-1?Q?K47lo7D8pOjz3woeAtcNRg7+lKwckGdvByiCn6CETlmVLFbxVlFIviLlOU?=
 =?iso-8859-1?Q?zbUDBjPpGTkSbMDhMhJLAuiuK7oYch1rV4Py9tBf2FWMETLDlAAAsezVda?=
 =?iso-8859-1?Q?KhbunQ/Q1TsDdyMkmN00Tqu5WV3xpq4TZG6pqpdxyGHO+5mJIAGBr0tt/n?=
 =?iso-8859-1?Q?VRoqNkVhIaKxG7/U9QBtuARRg/qZjjUDo2UWFVy7qPgGtIzSFoDQyvVhH9?=
 =?iso-8859-1?Q?kDhAFJFSGvbA5uA078UfOKoqXShuo249lM+xDotcDEOkaW946BdobIbcn5?=
 =?iso-8859-1?Q?tHbXaqinSpqU6RQglzhN8bKRHNiVAxOI6cgMTn6mLr87zVxDzbwxinIS7P?=
 =?iso-8859-1?Q?kQUxg6HXe3p1YsrnZgEBpK2k0BrNN/LljexTvhsBsIn0oROrqTL9QX49VP?=
 =?iso-8859-1?Q?cdPFg/sNvy1Ytyu/5c29xHD/YNyJfexXH7zwQ3OOjLluMxsDXCJhc0u4rJ?=
 =?iso-8859-1?Q?d173LmQHX9a4iRSKWa+tmzRPcb3qDQw4LDYysSoZ824ONZVO3KfSqAM7xe?=
 =?iso-8859-1?Q?iVFLmUlpV/vTeCnqeU1sePsJ4NMOjHjuBSUOAvYiiLoim4Km96OXSfSyNC?=
 =?iso-8859-1?Q?zaoxcOnGZSUr1Fiwi+DXeuObicUCSJZ4HOtcvpmvoEXZVUSnlakeSljrzY?=
 =?iso-8859-1?Q?9tpbOZD+iDePtgpyF7iH8B8fcQ+D0k6dden55G8j9uOHodrolIvWnc3yE+?=
 =?iso-8859-1?Q?dDEA+lgo52yvn0cuCj+P3W/2TVEk4896JzIWQp8dwZ1bMyrrXAxgPIxmko?=
 =?iso-8859-1?Q?aHjQv5E6+r5VYo941lSCyV8u4TtWSeZNrqDZPnJSDpM6Kdx39g7eWZaKH2?=
 =?iso-8859-1?Q?3jvF6m5gF6ugvcikqKJ8QmDOec1tThhuryQJchkCNGXB9p5rxbJgCOuvwJ?=
 =?iso-8859-1?Q?nKa33KcnhaNTPY2i87FAAbLwMVijnuj9mlGUtyHBuuOU89vdkyXucWjzXg?=
 =?iso-8859-1?Q?7bBUhpxkmZZtEdj51kbJ0yV5AUP3rY3tCfWdXDyewoH+fTmbXLxBuDkp/S?=
 =?iso-8859-1?Q?+Y3QaMvYoq+eqDXqbGn3zELVx6nabetXYmUyFQh1FO5lzvR5FqfdKl7xOn?=
 =?iso-8859-1?Q?akqoleTt2Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728a777b-b16a-481b-4eb3-08de67bbebde
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:34.6008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9xVLm9LpwdV9PyRq8NKX++ayEEs0DzG/BCImAfzK71wKiqXv+yVJjT+sVcXJ8AoctWRRfTecVv7u9w6hqMD8aVbh99myWvAxeSdm30pLbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages=0A=
6 DW I3C controllers.=0A=
=0A=
To help reflect this better and to make it easier for other SoCs to use=0A=
the DW I3C model, we'll split out the DW portion from the Aspeed=0A=
portion.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |  19 +---=0A=
 include/hw/i3c/dw-i3c.h     |  35 +++++++=0A=
 hw/i3c/aspeed_i3c.c         | 183 +-------------------------------=0A=
 hw/i3c/dw-i3c.c             | 204 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/i3c/Kconfig              |   3 +=0A=
 hw/i3c/meson.build          |   1 +=0A=
 hw/i3c/trace-events         |   6 +-=0A=
 8 files changed, 254 insertions(+), 198 deletions(-)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 7a984e1f01..f8e13b6fab 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -10,29 +10,15 @@=0A=
 #ifndef ASPEED_I3C_H=0A=
 #define ASPEED_I3C_H=0A=
 =0A=
+#include "hw/i3c/dw-i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_ASPEED_I3C "aspeed.i3c"=0A=
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"=0A=
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)=0A=
 =0A=
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)=0A=
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-typedef struct AspeedI3CDevice {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
-=0A=
-    /* <public> */=0A=
-    MemoryRegion mr;=0A=
-    qemu_irq irq;=0A=
-=0A=
-    uint8_t id;=0A=
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-} AspeedI3CDevice;=0A=
-=0A=
 typedef struct AspeedI3CState {=0A=
     /* <private> */=0A=
     SysBusDevice parent;=0A=
@@ -43,6 +29,7 @@ typedef struct AspeedI3CState {=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
+    uint8_t id;=0A=
 } AspeedI3CState;=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
new file mode 100644=0A=
index 0000000000..4550ea45fe=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -0,0 +1,35 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef DW_I3C_H=0A=
+#define DW_I3C_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_DW_I3C "dw.i3c"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
+=0A=
+#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+=0A=
+typedef struct DWI3C {=0A=
+    /* <private> */=0A=
+    SysBusDevice parent;=0A=
+=0A=
+    /* <public> */=0A=
+    MemoryRegion mr;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint8_t id;=0A=
+    uint32_t regs[DW_I3C_NR_REGS];=0A=
+} DWI3C;=0A=
+=0A=
+/* Extern for other controllers that use DesignWare I3C. */=0A=
+extern const VMStateDescription vmstate_dw_i3c;=0A=
+=0A=
+#endif /* DW_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index fff259ff66..b0844d4da2 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
     FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
 =0A=
-/* I3C Device Registers */=0A=
-REG32(DEVICE_CTRL,                  0x00)=0A=
-REG32(DEVICE_ADDR,                  0x04)=0A=
-REG32(HW_CAPABILITY,                0x08)=0A=
-REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
-REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
-REG32(RX_TX_DATA_PORT,              0x14)=0A=
-REG32(IBI_QUEUE_STATUS,             0x18)=0A=
-REG32(IBI_QUEUE_DATA,               0x18)=0A=
-REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
-REG32(IBI_QUEUE_CTRL,               0x24)=0A=
-REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
-REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
-REG32(RESET_CTRL,                   0x34)=0A=
-REG32(SLV_EVENT_CTRL,               0x38)=0A=
-REG32(INTR_STATUS,                  0x3c)=0A=
-REG32(INTR_STATUS_EN,               0x40)=0A=
-REG32(INTR_SIGNAL_EN,               0x44)=0A=
-REG32(INTR_FORCE,                   0x48)=0A=
-REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
-REG32(PRESENT_STATE,                0x54)=0A=
-REG32(CCC_DEVICE_STATUS,            0x58)=0A=
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
-REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
-REG32(SLV_PID_VALUE,                0x74)=0A=
-REG32(SLV_CHAR_CTRL,                0x78)=0A=
-REG32(SLV_MAX_LEN,                  0x7c)=0A=
-REG32(MAX_READ_TURNAROUND,          0x80)=0A=
-REG32(MAX_DATA_SPEED,               0x84)=0A=
-REG32(SLV_DEBUG_STATUS,             0x88)=0A=
-REG32(SLV_INTR_REQ,                 0x8c)=0A=
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
-REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
-REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
-REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
-REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
-REG32(BUS_FREE_TIMING,              0xd4)=0A=
-REG32(BUS_IDLE_TIMING,              0xd8)=0A=
-REG32(I3C_VER_ID,                   0xe0)=0A=
-REG32(I3C_VER_TYPE,                 0xe4)=0A=
-REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
-REG32(SLAVE_CONFIG,                 0xec)=0A=
-=0A=
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS]=
 =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
-    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
-    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
-    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
-    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
-    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
-    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
-};=0A=
-=0A=
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,=0A=
-                                       unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-    uint64_t value;=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_COMMAND_QUEUE_PORT:=0A=
-        value =3D 0;=0A=
-        break;=0A=
-    default:=0A=
-        value =3D s->regs[addr];=0A=
-        break;=0A=
-    }=0A=
-=0A=
-    trace_aspeed_i3c_device_read(s->id, offset, value);=0A=
-=0A=
-    return value;=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,=0A=
-                                    uint64_t value, unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-=0A=
-    trace_aspeed_i3c_device_write(s->id, offset, value);=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_HW_CAPABILITY:=0A=
-    case R_RESPONSE_QUEUE_PORT:=0A=
-    case R_IBI_QUEUE_DATA:=0A=
-    case R_QUEUE_STATUS_LEVEL:=0A=
-    case R_PRESENT_STATE:=0A=
-    case R_CCC_DEVICE_STATUS:=0A=
-    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
-    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
-    case R_SLV_CHAR_CTRL:=0A=
-    case R_SLV_MAX_LEN:=0A=
-    case R_MAX_READ_TURNAROUND:=0A=
-    case R_I3C_VER_ID:=0A=
-    case R_I3C_VER_TYPE:=0A=
-    case R_EXTENDED_CAPABILITY:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
-                      "] =3D 0x%08" PRIx64 "\n",=0A=
-                      __func__, offset, value);=0A=
-        break;=0A=
-    case R_RX_TX_DATA_PORT:=0A=
-        break;=0A=
-    case R_RESET_CTRL:=0A=
-        break;=0A=
-    default:=0A=
-        s->regs[addr] =3D value;=0A=
-        break;=0A=
-    }=0A=
-}=0A=
-=0A=
-static const VMStateDescription aspeed_i3c_device_vmstate =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
-    .fields =3D (const VMStateField[]){=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_R=
EGS),=0A=
-        VMSTATE_END_OF_LIST(),=0A=
-    }=0A=
-};=0A=
-=0A=
-static const MemoryRegionOps aspeed_i3c_device_ops =3D {=0A=
-    .read =3D aspeed_i3c_device_read,=0A=
-    .write =3D aspeed_i3c_device_write,=0A=
-    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_reset(DeviceState *dev)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-=0A=
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d"=
,=0A=
-                                            s->id);=0A=
-=0A=
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
-=0A=
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,=0A=
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);=0A=
-}=0A=
-=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)=0A=
 =0A=
     for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; ++i) {=0A=
         object_initialize_child(obj, "device[*]", &s->devices[i],=0A=
-                TYPE_ASPEED_I3C_DEVICE);=0A=
+                TYPE_DW_I3C);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -323,27 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error=
 **errp)=0A=
 =0A=
 }=0A=
 =0A=
-static const Property aspeed_i3c_device_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *d=
ata)=0A=
-{=0A=
-    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
-=0A=
-    dc->desc =3D "Aspeed I3C Device";=0A=
-    dc->realize =3D aspeed_i3c_device_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);=0A=
-    device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
-}=0A=
-=0A=
-static const TypeInfo aspeed_i3c_device_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-    .class_init =3D aspeed_i3c_device_class_init,=0A=
-};=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -351,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c =3D =
{=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),=0A=
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICE=
S, 1,=0A=
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),=
=0A=
+                             vmstate_dw_i3c, DWI3C),=0A=
         VMSTATE_END_OF_LIST(),=0A=
     }=0A=
 };=0A=
@@ -376,7 +200,6 @@ static const TypeInfo aspeed_i3c_info =3D {=0A=
 =0A=
 static void aspeed_i3c_register_types(void)=0A=
 {=0A=
-    type_register_static(&aspeed_i3c_device_info);=0A=
     type_register_static(&aspeed_i3c_info);=0A=
 }=0A=
 =0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
new file mode 100644=0A=
index 0000000000..c949579ea1=0A=
--- /dev/null=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -0,0 +1,204 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/dw-i3c.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(DEVICE_CTRL,                  0x00)=0A=
+REG32(DEVICE_ADDR,                  0x04)=0A=
+REG32(HW_CAPABILITY,                0x08)=0A=
+REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+REG32(RX_TX_DATA_PORT,              0x14)=0A=
+REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+REG32(IBI_QUEUE_DATA,               0x18)=0A=
+REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
+REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
+REG32(RESET_CTRL,                   0x34)=0A=
+REG32(SLV_EVENT_CTRL,               0x38)=0A=
+REG32(INTR_STATUS,                  0x3c)=0A=
+REG32(INTR_STATUS_EN,               0x40)=0A=
+REG32(INTR_SIGNAL_EN,               0x44)=0A=
+REG32(INTR_FORCE,                   0x48)=0A=
+REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+REG32(PRESENT_STATE,                0x54)=0A=
+REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
+REG32(SLV_PID_VALUE,                0x74)=0A=
+REG32(SLV_CHAR_CTRL,                0x78)=0A=
+REG32(SLV_MAX_LEN,                  0x7c)=0A=
+REG32(MAX_READ_TURNAROUND,          0x80)=0A=
+REG32(MAX_DATA_SPEED,               0x84)=0A=
+REG32(SLV_DEBUG_STATUS,             0x88)=0A=
+REG32(SLV_INTR_REQ,                 0x8c)=0A=
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
+REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
+REG32(BUS_FREE_TIMING,              0xd4)=0A=
+REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+REG32(I3C_VER_ID,                   0xe0)=0A=
+REG32(I3C_VER_TYPE,                 0xe4)=0A=
+REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
+REG32(SLAVE_CONFIG,                 0xec)=0A=
+=0A=
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
+    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+};=0A=
+=0A=
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+    uint64_t value;=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        value =3D 0;=0A=
+        break;=0A=
+    default:=0A=
+        value =3D s->regs[addr];=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_read(s->id, offset, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
+                         unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+=0A=
+    trace_dw_i3c_write(s->id, offset, value);=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_HW_CAPABILITY:=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+    case R_QUEUE_STATUS_LEVEL:=0A=
+    case R_PRESENT_STATE:=0A=
+    case R_CCC_DEVICE_STATUS:=0A=
+    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
+    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
+    case R_SLV_CHAR_CTRL:=0A=
+    case R_SLV_MAX_LEN:=0A=
+    case R_MAX_READ_TURNAROUND:=0A=
+    case R_I3C_VER_ID:=0A=
+    case R_I3C_VER_TYPE:=0A=
+    case R_EXTENDED_CAPABILITY:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
+                      "] =3D 0x%08" PRIx64 "\n",=0A=
+                      __func__, offset, value);=0A=
+        break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        break;=0A=
+    case R_RESET_CTRL:=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[addr] =3D value;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+const VMStateDescription vmstate_dw_i3c =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]){=0A=
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),=0A=
+        VMSTATE_END_OF_LIST(),=0A=
+    }=0A=
+};=0A=
+=0A=
+static const MemoryRegionOps dw_i3c_ops =3D {=0A=
+    .read =3D dw_i3c_read,=0A=
+    .write =3D dw_i3c_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
+static void dw_i3c_reset_enter(Object *obj, ResetType type)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(obj);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+=0A=
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
+                          DW_I3C_NR_REGS << 2);=0A=
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+}=0A=
+=0A=
+static const Property dw_i3c_properties[] =3D {=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+};=0A=
+=0A=
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    rc->phases.enter =3D dw_i3c_reset_enter;=0A=
+=0A=
+    dc->desc =3D "DesignWare I3C Controller";=0A=
+    dc->realize =3D dw_i3c_realize;=0A=
+    dc->vmsd =3D &vmstate_dw_i3c;=0A=
+    device_class_set_props(dc, dw_i3c_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo dw_i3c_info =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+    .instance_size =3D sizeof(DWI3C),=0A=
+    .class_init =3D dw_i3c_class_init,=0A=
+};=0A=
+=0A=
+static void dw_i3c_register_types(void)=0A=
+{=0A=
+    type_register_static(&dw_i3c_info);=0A=
+}=0A=
+=0A=
+type_init(dw_i3c_register_types);=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 8344b9769f..d545ecd712 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -546,6 +546,7 @@ config ASPEED_SOC=0A=
     select FTGMAC100=0A=
     select I2C=0A=
     select I3C=0A=
+    select DW_I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index e07fe445c6..ecec77d6fc 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -1,2 +1,5 @@=0A=
 config I3C=0A=
     bool=0A=
+=0A=
+config DW_I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index fb127613fe..83d75e7d5c 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,4 +1,5 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index cdf7cb07f6..2d944387db 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -3,8 +3,10 @@=0A=
 # aspeed_i3c.c=0A=
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# dw-i3c,c=0A=
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=

