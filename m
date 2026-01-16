Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEF8D47CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYWJ-0005Zf-N4; Thu, 15 Jan 2026 20:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgYWI-0005Z7-2m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:20:58 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgYWF-0004vf-Sg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:20:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBxA/KMq/YC/AXV7/cV201HB/ts7ZuMtJvYnYFGxcM1bsYbgZpQkGXd1TxiFehkU37dT1JGijvlTEIdT7H26gk6fM9fDTsBo6Svfei3WBEQehj133wd0Km3E0qipuz6fNbzbCAxp7s6HUxtFCqdpPS/XFRhpHo0PKmTqHDF/KjgFNtkiZf88R472gpImTtdSYnVCZ8zzAJ0aEHa1BY88j10RMrA2iaUTIAxiJAaiIuE5WJ6LrKC5P+iMspXhP++V+hj4Z/BjMmDy+BORttb7ceAxKZJW0v45VB2aHqL67vxJ0IT+1PPeQsiF63YP/VvSySruZT2+RLHUO337JwO2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Mw7PAloW4kBjvKHPCrRQWizrRM2QMmeRduOKmAT7k=;
 b=OVy9bAdcy52Vx/IEwXpFphKFWf0s5kHDcWASUHEQc5FUuRyCa7Drk+GBoZ1SIkgMyCSH/EVD6yXudzxQD92pntR4GC6O4YDPK1Eb4ewiscTQv3NjdsWShvIdKk1h6luMO2ewsr9Rcmbc56HekIytnx7stjSy2wTqk+5342aKXORg5D+pkWas7hrb+8xwCS0CrT9LO8x5+W7JFtxxJgC1yY2h4Cs9LXZqnF0Z/J3gUsvtaUszWFQKNe4T/1Y27CFX69i9VI3BPHULKMP8n5WTpe84pfIs7fENge1YgLZkYOapS3vRBrCCG4awMHcn0vEAHYLf2pQFAgwO9XzXTgZcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Mw7PAloW4kBjvKHPCrRQWizrRM2QMmeRduOKmAT7k=;
 b=MtpcIBEnA5vMGqbk2rctIsIhA98g1yYUL9FQ//DfuazEnpdhFIf8yr6bCLvjSWaVpf1tlE/zYB0b3ffgwcIfiypm96suFXPSUCGYezHfJuqUKwMahf35PQYFXF1Qx1x+IpECTH0L+konQO0AZOfZeffrTw0e2Pn2v2rGOxoD8Jd/2kuqnaBVItNve9P4Hraj8/KDTxz7SFF1/6pZ6v4RlAth+MGRfbDHSaX3ZypxmOZP2tQp8e9JCN+QU8Du4j2vgq5/W/T11h66Z1nL3PdWQzL47FbNu+c4fpXEIqiPc4G4Xfqn6SXdd43OZRnYcS28gRnY1qLO3DoQxFdjPxTDFQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB6065.apcprd06.prod.outlook.com (2603:1096:301:110::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 01:20:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 01:20:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "komlodi@google.com" <komlodi@google.com>
Subject: RE: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Topic: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Index: AQHchcf4AeTU1f63gk6KDympXQdmeLVTadwAgAAAgQCAAJOH4A==
Date: Fri, 16 Jan 2026 01:20:48 +0000
Message-ID: <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
In-Reply-To: <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB6065:EE_
x-ms-office365-filtering-correlation-id: f911cab6-09a5-4120-fb93-08de549d7b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bDZicWFPVi9xZW5HVE10Q2N3N0FpOG4vdjU1L1ZhR28yM1lKemdSanEva01p?=
 =?utf-8?B?Skw1YTYzYkI0NGgxU0NaU2xQL0pKR0pKYkZnT2JIUGR6NGZXTnFCemhISjEz?=
 =?utf-8?B?OWlreHhhL0pqZlF6MlVOanhwRlc5aVRKbG5VYUlxR25WSko3aC8zTlNMZDlY?=
 =?utf-8?B?bmgzemNWVnFqL0hwRWxJam56SnpvV2NBM3psU3hFcThLeEdzRDBDR0xqZnZF?=
 =?utf-8?B?SWZLTWgwcnRuMjZmSVljQjdSZ0lVUE9ISE5RTG1vbXhCb0FZb0swa3BVTFds?=
 =?utf-8?B?UnFIR0hwTkhRVURBREpucW1Za0dabnlSZERrdXpVTmR4QU03eDZXVVlwcEJG?=
 =?utf-8?B?cWhUaFZmc0Q2ekFVZmRXc0JlNFJaZFVUaHZZUzVLWGRmeEdlYTN5bmozSU9Q?=
 =?utf-8?B?VTJaczN3Kzc3SGtRei9RMlpKRkN1a3pNSTRJSzhyTHBpNHVMTUU2K3BLd3RK?=
 =?utf-8?B?ZGYrTDRMUGd4N0NyTWUrcWxGc0lYZlRUdFBrSFJLNjRaRjVEa0NubTR1NUFu?=
 =?utf-8?B?VldNTlVFQlhBWW9LbndYTWpXeVpwbVlnTDF1SGh2UVpwbEk3ZlZWY1ZKQWhY?=
 =?utf-8?B?eDNQOHBvalVqSjZXTjdQSzdxMFQ2ZlBDOWFsQ3dtTWxKWHdqNVdxOGJ1alhj?=
 =?utf-8?B?WENaSjQ1Q0l4TmZFODA2endsZGEyejMzOTdaSkd3S3pPZHNGQy9sK3ZWZnI1?=
 =?utf-8?B?REZlZlF4RisxdDF3bFZ5NWdLd242cDFid2dsdzV5SG9BYmRSOGhHbTRzQjRz?=
 =?utf-8?B?cCtRNG9ndzcxbHBFNS9XSFVlYitra3U5VFlGWEI2TUFSVGsybFBHdVU2ekph?=
 =?utf-8?B?SDZrZjhhTTBpa0dJbk5zM0xDQXVMNXpsQmtsckVkVEg0UnY3eEtJR3pSWWdt?=
 =?utf-8?B?RUpJVnE5SGlrLytYMk5WZjJpSmxUazRrVHJTTGhjd2sxMGIrbWdnYWlONThN?=
 =?utf-8?B?UWJ1MGp1SUhLSjRtcFQ2WnY3UlBUNXdEZThGb2JtVVFlSVdsZjdpaC9QUml3?=
 =?utf-8?B?K2NIckJzTEdhVDRibmtKRjJ6U1RYcllQek0wYjZNaFRxeFk1Mks1dXZnV2Zz?=
 =?utf-8?B?YlI0Z2VHTzRHQThxTVJ0LzdNQUVKMVFwMXpxejN1VnBMVXNwNElLYzl0Tmpv?=
 =?utf-8?B?bzdmK0M0NjJ6RGMzb2tmK2QwelJkTHRzcTVLaDQ3VWxiZTRvWnV1S0QvQnhW?=
 =?utf-8?B?SkdGRkErc244ZWR0b2orbFVnVm1RV3g5RDEzVWVMRzNJeW5lMFQzb2wxd0da?=
 =?utf-8?B?czdBUGtFUGJYelB6K01QUCtYZ1l4WDBsa3cxQkxZam9DSXNxSElZQmoybEJx?=
 =?utf-8?B?MkYyK0tJekgrV2prTEFNZEYzYy96WFFFSXV2bnJKSDAvS2wrd0RjYjlPalFX?=
 =?utf-8?B?ek1DTzdPWUdhcW9qbi9rNDRLekhFaWFUTFZxSkRDemVpSU5iamcvK3NFaFUx?=
 =?utf-8?B?S0IwcW56UnVNQjdSZnZEM0tGbmtmZjE5VkZtQUtFWWpuWFNSVVdwRkdIcDBs?=
 =?utf-8?B?T29GQnh3d0M2UmZBTUFnVVV3c1lReFpHUDJvY2I0UlR2UUE2OUkwWlFwa2c1?=
 =?utf-8?B?N2lPSXZ3WERtbVlRb2kzMUpJQSt5YzJBUUVNZDZ4cHd1ZFk4eGVoY0hrczBV?=
 =?utf-8?B?dmMrS1JUYU45c2JoamprUldzMEJHWGRCczhReTgzR3pENDlaTkRPVHF2czJy?=
 =?utf-8?B?TnF3MXl6c05rbGhzd1g2QWovYVdOK1Z2ODh3MlNCSVVxS0pQYy9Fc0ppK2Z3?=
 =?utf-8?B?MzhXQnVZL1E3SlVlaDgzSzlmVnRKM0xJQ2xsQlFXeVE0MFIwYkhBdGtieG94?=
 =?utf-8?B?VkNQV28vci9PaWRPRi9SK0tCSTVYZ1FKMG1TbStIVWZaREtBNWpDSXhEUysx?=
 =?utf-8?B?MSs3TzN0L3oxUXdGd3V5Ni9NdGNlWWZKL3FzdnlJLzZoRytmT2NPUERNN3I1?=
 =?utf-8?B?MnRGcUY3MTU1dldxV28wK2hRVHlIKzd1UEUzVzZ1NGx5RUtzb2U1NjZod0F0?=
 =?utf-8?B?a1g3cklOdHE5akVxRnA1Y05qbkJ5Mm1ZYVVzWFhVQWxBVWsrZGZoYWJmSlpj?=
 =?utf-8?B?c3pjV1NDaG51V0dRNXh3bnpyZlcwRk9rSGx4U3BRWnFzd2ZPM1p2N244Q0Q0?=
 =?utf-8?B?eC9sTEFxR3FxUXlhdmRNZDNCaXdtdTRkV00wWVIrTjhXZ3BEQ09FdlYxZGw5?=
 =?utf-8?Q?HEQ3JwpZyv++8IN5jWg+D3s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXFFRCs3VXFTQUI0cStEMlpqRnorbFpJL3pmYklqbXZNalRad3Y0M3pYY3lt?=
 =?utf-8?B?NGFyd0xhaXcybVN5ZU1vYTZTMTBCTWtGTXcrRzUvSFc4Qm5UZkthdklLMWNN?=
 =?utf-8?B?alZhSVkvWW41TmRtZ2pHTnp6VGVSbEdXWDFqbGpTNmlMUmpsbTZDUk5FVmMr?=
 =?utf-8?B?MFI1MkdVcHhBcEVXQyszMzhVc3BtMy90SUF0dE5uN2FYdjBwTnM0bEJpNXlQ?=
 =?utf-8?B?TVBreU9YYnBWUW9EQkN4L3Y1UHdycVVsVzVmTEdqNkVxK3RaK0lDRStUOHp6?=
 =?utf-8?B?Y21YVlJuZWU5VURoK2NwVFplb2hYZ2pWKysrdHB0SjBKc2tGbEJFRnhRcEdr?=
 =?utf-8?B?NEx2emhYbzlpUURYd2dPSkNMMXp5OUpNU3pCVnFvNFpJYXVtVVJzNFdwMTMv?=
 =?utf-8?B?dytSdlA4eDFoenpmaFR1Q3Zac1ZIN3lLUTB5WkxvME9xdFpyZXVmVUhud2hy?=
 =?utf-8?B?ZkRSNTFGUVEwMkRNZDNjMG45elA2RkM2MGZVUkZDSnhCNEVSNnpsSkhJNE4z?=
 =?utf-8?B?WVo5bXl0cGJmL1RKWEo4bjNNeEthWjZCS3kxREdLanVDNTV3S0NvcjNtTU5V?=
 =?utf-8?B?SFduSy90SUc2djhxNEpLU1kwOG95RFlYY0IyNDRWODF3UHJMSTJEaFNyTW1E?=
 =?utf-8?B?aDYrVDQvdXdwTGxYYnllMU1SaVc0ajdsRmlsM2FNQ3pMK0RUTkRScTRZZ2N5?=
 =?utf-8?B?aFhYRGVTTDAzbHJ3TkJjcFFXZHVoellJVEtSeWJtYUhDM08zQ0lEZkdjSlZU?=
 =?utf-8?B?blBvZTEwejEveGhaSks3T3dKVGtNVUlKSnZyWGtkRGo1OVkvaGlzeDFjcHZF?=
 =?utf-8?B?QTVzTFBmZkVwbHhKdFRWeExZTkRucE55cWJtOUt4alNDRVl5bS9KWjRDM043?=
 =?utf-8?B?enJFaHhuLzVMNXF1SW1QL2xRVWFEanNvRXU4WHN2K2FKT1lLNFZLR25GVmhx?=
 =?utf-8?B?V2ptWTV5MWpXZERzV1R6dFZYTG1LVldoLzF1NGszSkMzNTE1clBvT3h3Um9i?=
 =?utf-8?B?a3hhUFJISkN3VmRRdVlZNkNVV1RJTDFpbk9hRm1wZk55QWRWUm9QNkw4Znhu?=
 =?utf-8?B?T1FQeFFkM0krWDhkeGZsU1V0OUpkdmdySk5iQWJKaGxkRHRQTnZHSTBhTWgx?=
 =?utf-8?B?SlYzejVqZnREWVRoODl2RlhiSSt0VHo4VkI3U1BPUUJDU04rY0FpYkZTclBx?=
 =?utf-8?B?MnZsUzFHM1RvcG1JL0FQblA0aEltekpGZ3FocG1aNDdQNGxPUk9sc1lvY1dx?=
 =?utf-8?B?bmVoRjI5LzM5TnFrZzJJbzFlUkpvMURCeW9FeDRVMTIzb1FsUjdqNkY3dkty?=
 =?utf-8?B?NkQvMGhkaXY5Ni9vcy9ZWlhIbGtiQnR1MWlmanVrQmlzK0FMTkhRZlpqMWFh?=
 =?utf-8?B?RWhaMko0YXhQMW14WlNJTk44elZQZmlNdXYvR3dvdjAyNDlXT2JFMHB4ckVa?=
 =?utf-8?B?TmhmcFRsWE1FN0xUK0ZFSlUrNFVwVzJnV251aTlWUlh2V0xtd01IS3AwM2hE?=
 =?utf-8?B?elloR1ZuR3M2dEJ4UGxweWZHTHZFUSs3RW1uNk9yVGlaVVBCM2FkT1NacE95?=
 =?utf-8?B?S0hscjlwWGdDNElPMTYrRFlEQ2l5Nlo3RjJKd3dqQ2NBbTMxVExlS0Q5ZmVL?=
 =?utf-8?B?Q2RMV1RrV29rZDExK3JqTDk1Wno4dzlyUHQranp5MXJMeWNLUVAzQ1lrZE9D?=
 =?utf-8?B?eXdkOXRyeHNlZVdMdWJpRE85L1BlaVR3LzRCemkzZ1ZqM0REYXhPUU9zQ0M0?=
 =?utf-8?B?WUQzU282Y0dPUy8wdkM3akxNRngvM0xQYWpKVHN1WTU5Y3dFT2NMbG5BN3VX?=
 =?utf-8?B?UjdLRmVsQU96T2NIWnNqbnd1S00rMXVMTVBGdmp2K21reVovMEZYcVBjUVhj?=
 =?utf-8?B?V0l4bWszb0lSS3dvc1hhc0ZIdmxxYTVOQmZ3WkVhQlgrOWV5eXVhUzdjZWxL?=
 =?utf-8?B?N01teHVIVEI2ZGxTYStrNVFVU0pzdW9DTkQ4Y29uYVVmeVpQWkJwdlc3VDd0?=
 =?utf-8?B?OUhwL0huOTBmakFWUGpvUU9WbS8rRXR2RHB2QytyU0J5aXIxSUZYK3YxSHYr?=
 =?utf-8?B?ZGxNWEhJZW1ycTM5Y3FpbVZzNGl1by9YVU9KVG1MbitoMnA3aU1LbjgwRVNF?=
 =?utf-8?B?U1p0OUxnS1B6VldJUmVrOS9JaHFtL21nR1JpVEs4R0NudndoMnE1NXltcFl1?=
 =?utf-8?B?emw0MVZiMFo2bnRpajgzejB0bDJ6UmsyVVk5UlJ6azZFelRRZDF1VXNoVy9j?=
 =?utf-8?B?Ky9WS0pPaXFFZzNIMWdpNTQ0SGhhTVNUU0RoTStNemNOaUpRYzdvWXhrQkRr?=
 =?utf-8?B?ZUovdUNad3lpNG10MnV3dEtteVBzM012S2U0VkVvN2JSQmVUSTEwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f911cab6-09a5-4120-fb93-08de549d7b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 01:20:48.3002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kg2XpQxV736Ni3qE9LWN1wmxkYm4I8xoea23u9DfPIbMxi8aGpV3b6tT5IxsTITiXnus7wmVo5MviJsLNTU1LzpF6ibZ59nDQJC36osBaFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6065
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXks
IEphbnVhcnkgMTYsIDIwMjYgMTI6MjEgQU0NCj4gVG86IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0
ZWZhbkBnb29nbGUuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
VHJveSBMZWUNCj4gPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgd3VoYW90c2hAZ29vZ2xlLmNv
bTsga29tbG9kaUBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBwYy1i
aW9zOiBVcGRhdGUgdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0DQo+IDFjOGU5NTEwYjIyYw0KPiAN
Cj4gaG1tLCBJIGRpZG4ndCByZWNlaXZlIHRoZSBpbml0aWFsIGVtYWlsLg0KPiANCg0KQ8OpZHJp
YywNCg0KSSB1c2VkIHRoZSBmb2xsb3dpbmcgY29tbWFuZCB0byBnZW5lcmF0ZSBhIHBhdGNoIHRv
IHVwZGF0ZSB0aGUgcHJlLWJ1aWx0IHZib290cm9tIGltYWdlczoNCg0KZ2l0IGZvcm1hdC1wYXRj
aCAtbyAuLi92MS1wYXRjaCBIRUFEfjENCg0KSG93ZXZlciwgd2hlbiBJIHJhbiBnZXRfbWFpbnRh
aW5lci5wbCwgaXQgY291bGQgbm90IGZpbmQgYW55IG1haW50YWluZXJzIGFuZCBwcmludGVkIHRo
ZSBmb2xsb3dpbmcgbWVzc2FnZToNCg0KLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIC1mIC4u
L3YxLXBhdGNoL3YxLTAwMDEtcGMtYmlvcy1VcGRhdGUtdmJvb3Ryb20taW1hZ2UtdG8tY29tbWl0
LTFjOGU5NTEwYi5wYXRjaA0KZ2V0X21haW50YWluZXIucGw6IE5vIG1haW50YWluZXJzIGZvdW5k
LCBwcmludGluZyByZWNlbnQgY29udHJpYnV0b3JzLg0KZ2V0X21haW50YWluZXIucGw6IERvIG5v
dCBibGluZGx5IGNjOiB0aGVtIG9uIHBhdGNoZXMhICBVc2UgY29tbW9uIHNlbnNlLg0KDQpmYXRh
bDogLi4vdjEtcGF0Y2gvdjEtMDAwMS1wYy1iaW9zLVVwZGF0ZS12Ym9vdHJvbS1pbWFnZS10by1j
b21taXQtMWM4ZTk1MTBiLnBhdGNoOiAnLi4vdjEtcGF0Y2gvdjEtMDAwMS1wYy1iaW9zLVVwZGF0
ZS12Ym9vdHJvbS1pbWFnZS10by1jb21taXQtMWM4ZTk1MTBiLnBhdGNoJyBpcyBvdXRzaWRlIHJl
cG9zaXRvcnkgYXQgJy9ob21lL2phbWluX2xpbi91cHN0cmVhbS9xZW11L3Zib290cm9tL3FlbXUn
DQpxZW11LWRldmVsQG5vbmdudS5vcmcgKG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlKQ0K
DQpBcyBhIHJlc3VsdCwgb25seSB0aGUgbWFpbGluZyBsaXN0IHdhcyBzdWdnZXN0ZWQ6DQpFdmVu
dHVhbGx5LCBJIHNlbnQgdGhlIHBhdGNoIHVzaW5nIHRoZSBmb2xsb3dpbmcgY29tbWFuZA0KDQpn
aXQgc2VuZC1lbWFpbCAtY2MgamFtaW5fbGluQGFzcGVlZHRlY2guY29tIC1jYyB0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbSAtY2MgLS10byBxZW11LWRldmVsQG5vbmdudS5vcmcgLS10byBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmcgLS10byBjbGdAa2FvZC5vcmcgLi4vdjEtcGF0Y2gvKi5wYXRjaCAt
LW5vLXNtdHAtYXV0aCAtLXNtdHAtZG9tYWluPW1haWwuYXNwZWVkdGVjaC5jb20NCg0KSXQgc2Vl
bXMgdGhhdCBJIGluY2x1ZGVkIHlvdSBpbiB0aGUgLS10byBsaXN0LiBEbyBJIG5lZWQgdG8gcmVz
ZW5kIHRoZSBwYXRjaD8NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2
MDExNTAyMzc1OC4zNjAwNDQ3LTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLyANCg0KVGhhbmtz
LUphbWluDQoNCj4gT24gMS8xNS8yNiAxNzoxOSwgTmFiaWggRXN0ZWZhbiB3cm90ZToNCj4gPiBP
biBXZWQsIEphbiAxNCwgMjAyNiBhdCA2OjM44oCvUE0gSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+Pg0KPiA+PiBGdWxsIGNoYW5nZWxvZyBzaW5jZSBs
YXN0IHVwZGF0ZSAoMTgzYzlmZjgwNTZiKSA6DQo+ID4+DQo+ID4+IEpvZSBLb21sb2RpICgxKToN
Cj4gPj4gICAgICBucGNtOHh4OiBGaXggdS1ib290IGNvcHkgc2l6ZQ0KPiA+Pg0KPiA+PiBKYW1p
biBMaW4gKDMpOg0KPiA+PiAgICAgIGFzdDI3eDA6IHJlZmFjdG9yIEZJVCBib290IGxvYWRlciBp
bnRvIGZtY19pbWFnZS5jIGZvciBmdXR1cmUNCj4gQ2FsaXB0cmEgTWFuaWZlc3Qgc3VwcG9ydA0K
PiA+PiAgICAgIGFzdDI3eDA6IEFkZCBDYWxpcHRyYSBNYW5pZmVzdCBib290IHN1cHBvcnQgYW5k
IE1DVSBydW50aW1lDQo+IGxvYWRlciBmcmFtZXdvcmsNCj4gPj4gICAgICBhc3QyN3gwOiBGaXgg
Y29tcGlsYXRpb24gaXNzdWVzIG9uIFVidW50dSAyMi4wNA0KPiA+Pg0KPiA+PiBDb21waWxlZCB3
aXRoIGdjYyB2ZXJzaW9uIDEzLjMuMA0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5h
YmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnkg
Pw0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gVGhhbmsgeW91
IGZvciB1cGRhdGluZyB0aGUgUUVNVSBiaW5hcmllcyBmb3IgdGhlIGJvb3Ryb21zIEphbWluIQ0K

