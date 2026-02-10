Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC15EA3F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1J-00035A-Kh; Tue, 10 Feb 2026 00:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg12-0002xM-Gw; Tue, 10 Feb 2026 00:10:25 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg0y-0000GO-Iy; Tue, 10 Feb 2026 00:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcCk+SLcQIfz5+VlJCXSuIDIBoT0z8kvNNoPPms4/ihTnG0PdSxpc+HO5GjZKIxa0gFz04SPegDDU1tWlDYTI8Bm9Cv4MAqgaQfQUzm0/GO90Ysm5UiOiSfl3aTaaM6DYIiGr9EArzn6kLiLu2cdaZ70MkrkRXGojCJf4FKk4NbYGDScl1I+tTc5HCBg2SXhFeTBnc3k7fU7cR+5uRI9Vu8jfJAqmASCB2nr/158U+hPQH2nrOMhiUbk1h36JZw+Q73eE83YOZAPwPe0KsUesTXWrttCQqhXqRmV63g+0fCOkT/J8xoIfApvVRL0aIrpeXEjZkgf8+52QnkLZRb4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WoUIzdsld4DiPM5QpfODdKvFjQUNZymfgiAYFmgCUQ=;
 b=rOIO0EMDD3zBZIGWF48xTZagOzl2p3XqKh+ZRrMS9nhJfBqj5CysHnYhClSNcy8L++U7txg4ah9EHjQBzo8mf2xeuDC3cIXiVyVjO2ommbmMiQmELVacmV90GI4s7nroQrUZKJckHrLYb59A/6mE5AQdhEW0YTGC86l/0x8buYCkZhc01rsOVmRpWGGXRjIq4rl3Pziv/6jqVMCwL2ho/l3MSGCsUOQG4c/IfL5zvId0+HznzQ8tvHVBs4T8W3Ihzfk7WiFHAYmKAuFT0LE0AUAZJqN/iMW0o9IMNONtswb9pbqpYsVlSpTsgz/3Dskk2rSewkR//65yJtq+xMPFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WoUIzdsld4DiPM5QpfODdKvFjQUNZymfgiAYFmgCUQ=;
 b=dWJ1EdbokK58LEo23tS1VtO+n0YguKkGKC4NP/L52NA4XM6guGZ5mU6Zyccpczs4XqNZgaK7fgsSzwZaQO9+i19/Hi9Agi+0KY0/YEMMNAXGiyP+NzceiMSMNKzKKG7gF/LIoYaOY4TR+D51DHysMWyBTFxiBDBncD+K9O7L+8sUrmIGVkGZIx+LqD19meUcIgvj7tCP4l+Npp5kbnlT5BoeKqtfvD26NfGYC7UHPiKUxSXm88AotkM56JAA+XSeYE1HhHPtaGeaDE0kZe9CAvu39tEJeU1XAnGw4UaqZ68d9cQhUlSL0tV6cOhrv+On3rZFydY5jpNhtiH16c3JXg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:10:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:09 +0000
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
Subject: [PATCH v2 00/11] Support ASPEED AST2700 A2
Thread-Topic: [PATCH v2 00/11] Support ASPEED AST2700 A2
Thread-Index: AQHcmkuHYTnzfCEzjk2XK0DDlCkGtw==
Date: Tue, 10 Feb 2026 05:10:09 +0000
Message-ID: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: 9402c312-a5fe-4458-8020-08de6862a9ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?f/CtzbW3kyD8bLVzzGQ4Y9zORu0D+WcV2ai78NKNBXWgSwqdRbdzPJIPMV?=
 =?iso-8859-1?Q?MeRc7zkcn8gLeJqI5358txKHn1lmw4qbm6mUSrE5oxgBJHZ9T53dDw2T3y?=
 =?iso-8859-1?Q?11l5khPwJ2/mBYa+BbOl7kJuhre9lwPawgzcWM37M1xo95l1Sjc1pFv0NS?=
 =?iso-8859-1?Q?iVrdSGTbbPfvTiznTCXRz8hpG/waBkgiphOwvh0f/uw3snOfKxuKJz6FP1?=
 =?iso-8859-1?Q?7LpCDB3aSAs1WeU2Dv0ZWzBAewdTEssO1EqY7n0I3OkgvxtKfKPeMlqgLX?=
 =?iso-8859-1?Q?tsv1yeaW9GFcZ8JBhxSKa1AT4GnuABXTAnBJ2Y3bJ/DNPzmhSub83o3mAd?=
 =?iso-8859-1?Q?XrqfdYm8fP0wKWRFl+0B3egWxdIwK6n73L3Y+uM2fT7ytr2Ye5oPjL5gHB?=
 =?iso-8859-1?Q?AKtIDR8kdTJBSeBk2ci3griJ9MNKta3py9+rQrtArUrTytpzL3zlX7M2IZ?=
 =?iso-8859-1?Q?Z6K8iFQQB1LO19pEewwkcoaOeweQ1Ayc7kQasT7wpvKuGo62r2bvMkD7UE?=
 =?iso-8859-1?Q?wYVyd0fp3sZ5JhkfDR6lyX2LWbg041zMU1qNdQ1+qeiz4QKZgktyBPZm5r?=
 =?iso-8859-1?Q?6/votlEiiLIp+igEkz6M8ghhwOZhxTcy78lFYKRcOblZ8wsLItbIBD6UNX?=
 =?iso-8859-1?Q?H59UM8Dap+GW0dWeE+lAHYobUEc0vmQCQXWGJE995/l3t1v9JmokjABjxW?=
 =?iso-8859-1?Q?6J1uUVSyuMGIPotwUqVP5Ej3W6RAxmYjL3G+Q1ZWsvRaalTwDUprjmSESl?=
 =?iso-8859-1?Q?wQaAz4iXT19AIna4YRt4k1ZnNodC1ZfCUmHvGqNlSH7tcd2bZOSZXfevd+?=
 =?iso-8859-1?Q?6NTsAPU/gTUicmTCZoxlpNiQX/4+coXjC++aT5YtV+doDK1rWftlq8egli?=
 =?iso-8859-1?Q?5ymzKmrMMgObRqiYJqH9UkEmdMxPwAgMC43sKGgkqv5YZ6OVDLsjYY+CRb?=
 =?iso-8859-1?Q?WvysX9Ww4awtC6fJkwi+xzKsD3Tct5tLxPyoNYRL6P2tihBhj3R/UWtM6G?=
 =?iso-8859-1?Q?9lMYgce9B5CxoY86AX7IAAf0J+dRT3bWTeBAlexV2PJh/Roga52KSq3v75?=
 =?iso-8859-1?Q?bTemUdE2AKPiHmCDIhqv6XdZxYaSMaUyJ+Neze35Z3gJ6g3KuLL/FwMM2w?=
 =?iso-8859-1?Q?KgnOwAb1R9HgBb8lRbJjWWUcfWRABmZTL6o4wx2wra2abKIo8sWGP26lmd?=
 =?iso-8859-1?Q?LIYalGtqrJlDhrvDxBlrFD22LcWM04/oA7jEjHpiCQlkFqlCDDZBHAaseL?=
 =?iso-8859-1?Q?lj28UpnsyZEmA+ffpnlwYyLfjBac9Ry0Z+JNwRm0J5ZWYc0cLYonmrbw9R?=
 =?iso-8859-1?Q?qgcay/ai2KwRYItPzddcWmTZ0SNupqtoEJ6bkjjhwjjzV/6erzxy5ontgD?=
 =?iso-8859-1?Q?hoDZ+6KFI0+MUdCiKX4WOvs38oMjwOFPklmza678kM6jjqMITVhtq/vMYd?=
 =?iso-8859-1?Q?0VBqh1NbxykwGuHRnGqqJbzBbVbs+aiW5SUXIRSD9EqrddxAguUzjFjl3e?=
 =?iso-8859-1?Q?V7DufHPoso5TqyLkxEpWHmvUoT0moG8mA3+z1m/7WQIK0TPktNzYpx21h7?=
 =?iso-8859-1?Q?8w635jVlM8Eb5C8qnZ3O81N9wNYDRVu1zKtG26Y/TtMlCqmKbZdMRrPJHK?=
 =?iso-8859-1?Q?PiwhE6BKzTBlqunp2EW595ZdY1rgftuIms0igJuj/3C53Ibch9yO5ww8W6?=
 =?iso-8859-1?Q?z34aWy/OdTfHz/xBHSluy3Lx2Xt8ErJ773BgYXpe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aiBF3Ke+cPlm7fAW++3HZPBye35lXVKo79qdcr8mnal195PxBNPzFe0WMA?=
 =?iso-8859-1?Q?uw5O3SEME6MWi+fOPEH4OeKNW7tXwHDMGVrERZP7uzCu8WIzfw6R1gyhxS?=
 =?iso-8859-1?Q?+yhtl0h88dT3EFj+RuaS1UGxh/Foyh2k3rfDHXg+2My/PwVUvXIl4uy6+x?=
 =?iso-8859-1?Q?Ap8xlwA3n+w5avIcSd3NdWDusSbEyFeidO2V+K36ae1fq4ByNpSYcQ67v0?=
 =?iso-8859-1?Q?lj3godf4914POFeXlMSPUhMQz8SlwVHp/WxulbCh841TraWr1IciVKezoK?=
 =?iso-8859-1?Q?wANwv5TvyGAegTCiKH8JnPFExtK91Ta6mQq9Ae6UmCSw7FIA93Usk3eczA?=
 =?iso-8859-1?Q?o+1s6zSZx/g+MhVEep0aFma4C4chUObCjWWbMtCn3N/BKbSra8DOgq48P/?=
 =?iso-8859-1?Q?nK54gvN08Hl11JsF8mEeYlBNDoP8yjm94jtuVoNzAPWJ4+abq14hW/2OH4?=
 =?iso-8859-1?Q?r3d9wOSOKm1sY7mqmTE4VmsZHqc8DuX0WUo4aM3dTHB2XHKk36H9gJVhWv?=
 =?iso-8859-1?Q?4/QjaC3F1U21BJDqbj+w0iRB2xU6XiKB8TtXr7vvR4IS4TQ9tRYyga6Bho?=
 =?iso-8859-1?Q?dFiKC0fJjF5qRcuAgxc82oXl7SbbEyQQV50/cIPg4gaH5XASAHdw6yVOdA?=
 =?iso-8859-1?Q?DD+ygrcSTbhL4ShaNVocNaqmve9xr/8frUVhgtoFKImnfSwK//HsLIKtLh?=
 =?iso-8859-1?Q?usfxKQ6qlWXTbPd5AlddSjyafe4CsY0MUPBNADxLQZ3eJu1Uyon92DUDUT?=
 =?iso-8859-1?Q?rMxp/0Qmjv4FT5S42Ga+41B4s40tUlIwHFai348wCK9I875B4jJHmsAili?=
 =?iso-8859-1?Q?2RmTkdTmTBFVKdbxDyGodUuVuw9UrbIw7ZcjNW7LAbgpP37xdIDIvc2n72?=
 =?iso-8859-1?Q?hJHHyOpCa8JJDDVhPRjDBQXweUGeF/mYYcfslc4SWt+r6A3RcUq6K7GwAg?=
 =?iso-8859-1?Q?2Gq7IuUhAvqTrK5FvpPLMrPG2N7SWDSVUUhJ49lE9eIQeaDYko1GfNWDX5?=
 =?iso-8859-1?Q?XnKMTM9FBZF5Bv9FgyJzoVdOqLwvq6v6NpC43Zc1eXMIhw2VdHgyTBejYG?=
 =?iso-8859-1?Q?l3EHszEn8qkc6WLR5b2OseMjm8ghDqfsdIPbTFbNMEomSTvZnPZiuBtSDk?=
 =?iso-8859-1?Q?+qhToXFkIEKyZT4XnybTRcdtaP+r/sSc+2ajyWIqnJZGsRYKdq1C9bO/T2?=
 =?iso-8859-1?Q?PLiO32Mh5GlDfRaBdsqfbZSD6BAD1xBgbpddz8wn/GsF/OaxBETxvUguD0?=
 =?iso-8859-1?Q?46Jz5tDDVjqMK8QltsoY/87j1felIPCkViWVf5Fncv8H22fGpiQUr5GHCA?=
 =?iso-8859-1?Q?s3fKokeVb6WqDyBePWDKljHlzF2u3mDDkDbdR9FId/ftKQXeZEjE/HR8/Q?=
 =?iso-8859-1?Q?OYKp7YqDTnilu0l75mbfMYEcKH9PpDn8YAxeFg4V8Oqr+NcceZwD95A9Zi?=
 =?iso-8859-1?Q?V5IrLz/EQukTDfobge454vgNEZRPNmIznGN9s1XDQY+Br8NOeRCBvKYe2B?=
 =?iso-8859-1?Q?b9GAGwXh0FTwl+zu3ANYQmQsW/84XhuZShOFMXl8u9DO8KVJpuY8rZh7j/?=
 =?iso-8859-1?Q?O9q/uEBXgZlocSMfTay/yqfrrpN55B2D3urrVNPSSrXwXDSs7QbE2bXtNP?=
 =?iso-8859-1?Q?lsedxWKqGqbAmNfBgVJdXwtgNfkN+yVAQwAPKqJwY/QyqW9yHDSpYsreua?=
 =?iso-8859-1?Q?WBvYdUFVoUgwT/1QRI/V045AhpZLVfH17zKvxGrjWGEAswNV1h+NU21HmL?=
 =?iso-8859-1?Q?Qwnw2/vKbSqYVyHRGQxREkvBQGc5fNjtY9eQCpcmxz0y2Wi9S/BRyu9SYW?=
 =?iso-8859-1?Q?XYOC8Jntkg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9402c312-a5fe-4458-8020-08de6862a9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:09.5825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a76EW2WVppt5DFqS+UXaAuXTE1a82vl3Um7ZfYmw1L54k3zTJQTON84GmzuAZiwvWKGAKG9Q2qaaYUgoz7xwGBLRxio4WhuIZRKmeRbFKFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
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
  tests/functional/aarch64/test_aspeed_ast2700: Add AST2700 A2 EVB=0A=
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
 tests/qtest/ast2700-hace-test.c               |  22 +--=0A=
 tests/functional/aarch64/meson.build          |   6 +-=0A=
 .../functional/aarch64/test_aspeed_ast2700.py |  51 ++---=0A=
 .../aarch64/test_aspeed_ast2700a1.py          | 187 ++++++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  16 +-=0A=
 10 files changed, 310 insertions(+), 74 deletions(-)=0A=
 mode change 100755 =3D> 100644 tests/functional/aarch64/test_aspeed_ast270=
0.py=0A=
 create mode 100755 tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
=0A=
-- =0A=
2.43.0=0A=

