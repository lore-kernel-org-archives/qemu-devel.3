Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678D0E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9Y-0006bq-Ct; Wed, 04 Feb 2026 02:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZP-0004hs-88; Wed, 04 Feb 2026 01:40:59 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZN-0004IG-Ls; Wed, 04 Feb 2026 01:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkEjTvJVUNbJ7NQOy2gck6ja1vz7QeFTOsh1qEyuereSfxYWhWDsJaIFEhqMG/dwAYcnwuF7Y9gqztjefFqXQ7t0TQ9cO2joXWzIrf/rmEWG3pzmt4qMsZ/wdiOD1MGuYbJQxvAvEw4xIRPrMs8tTEPeSjzocHv0bTowx+2LE8CRqp4YSoevsAr6Ef9/bFq7P1XcAU87xf9Xy7pzMofV2MZSPMK8A1pT5fPBtIu0MQvjXoxJtFNPhcjS3/qb0DEGQmEn28eUiAr3oUItHeB6rdG5495cW7scB5vcMmYG4uva54dyKXz7cYiQFRtOhBbtSPv0rjItcm2D5b0yoy1hDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPt2N3SsbOYFyevGkUw4gnsuliemcGUBFq0JCVC/GIU=;
 b=tRuMhYjIzZETPiG8S4arzN7QecfInWLA4rJ8zcSb6SHjKibGqViq8DVnMV9xTHzEZFoCV6UeOCd45DF3UzF8LRDEZkdIf7uiSGmoOpmCqemMdu4eJKkqGoTFgISeNFBg/qwbwT6LM1yBzX+FkL8zRMss6NWpy8N96jn02migOSKwcFjxJPWqjaA/kMERSfAjffIDPamH7CXgYhOI4k2qWX7397QsTnWS+nFK4Du9i1C0S1d9omw9TTwV7BvQKiYI22kCPiSqZIb2V5AZTIwhon7exb8Ye5JsCavp3rCXeqFucqv/kuPLtX9jUDdrK33j8VCVkPqFPl5Z51Pdes4iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPt2N3SsbOYFyevGkUw4gnsuliemcGUBFq0JCVC/GIU=;
 b=KmbE80Y57SeMxXDP4mV5sMb/CK/kyketJ7nVRjOj3fFnbIdAq+Gkis+t/EWZpe2nGm6etUQ21pU6wnZ0KjNAik1wHZQoeq+HI3xwyNUtmP0JYGebqHvZdCOKGAdnepHB9jFqiNeDnzjFVgWWZf2rpasZiCqdXbvfREf4l/R3aOxHO2nE+OxhAsLEmvLjLI7/C9Y5ERPuXsjpPdemg8K4sH8ImVcw21rD1HT7UiJ5rG+xYJByWS1Q78uhwiXwDXWCC3WthbjX/qLQn3DSYOn8/V0TyRhQUw19qmJ2rd339uF+4iAFZQNsBU14CsPOn+Byyaf0LF67EfTIKG9gVltbMg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:42 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:42 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 18/22] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Topic: [PATCH v6 18/22] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Index: AQHclaEuu/1ED6sQC0mglq5zUJdeow==
Date: Wed, 4 Feb 2026 06:40:42 +0000
Message-ID: <20260204064016.3515639-19-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 83b27ba2-5df9-409c-9184-08de63b8515e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q1VCQ1R5SkhRVWwvbkpFa2p0dnFIblJOYitDK294V2ZzMXdhWFAxVEZWOWNW?=
 =?utf-8?B?N0RNVFJ1Umd0dE5MenhmUzUrMUh1OUZPWTl1YlluZ1lvaHBYSkhzWnNabC9s?=
 =?utf-8?B?YWN0MktteHRFaE1WZG9aVFZFTzk2VW5vVHhhUWtVWUhtaXc2bGJvTVZzM2g1?=
 =?utf-8?B?WEE0UUFHdW15SEhJTzNia2VQKzlzbzJvUUNaUkZSdWhubVl0R0JQUEhmTmYy?=
 =?utf-8?B?bXR2K3dkN3JnMUdKUkZockJJN29RdGM5a2tpSkNqU0d5bWliL3lqekNWV1VT?=
 =?utf-8?B?dld2S1J4R1JtTXdnT1RncXpLV0t6bEFxZ2k0REZ5Q3ByVlhpcG9YcUlFc2th?=
 =?utf-8?B?R3o2VUo2Ni9SSHFvSGNtdkJjU0NMRk9aeEh1TmVMMGQwcUUva2Y4Zzk3bFVt?=
 =?utf-8?B?bzBrTmZmL0FhTzhydy9HNDF6K1lUTWptSkpDaFUzMEcwZzFFdDVzT1FMVnQv?=
 =?utf-8?B?ZUcwakF5ZkkzdXJVekdCWDl2cTBKOUs1eW4wYktmZ1ExWjdrYmtYcmdWTTZj?=
 =?utf-8?B?T294VE5UTy9lS3RhaytQTkk4Rm4zV1lpUUNhdTBLby92WEZQZ3ZVN1dMQ01j?=
 =?utf-8?B?VE1UZ1ZDVHArNnJISXFSQzQ3Yk04NkcwSDNZcGNYbTZXTHVvNXVTNmVoRktI?=
 =?utf-8?B?dXRpRG96a2RCb3Z0a1pFOWx1ME1mM3o3Q0k4K0l0NGwra2svaHplcFF3MVhl?=
 =?utf-8?B?U1FHQm5lblI2QjNIQ1Y5VldGckZEUzhmazBHRWFHY1huT0RjQlB4UkJBOERB?=
 =?utf-8?B?OWZYMzRYSDBjWWR6dXhXZERJWllpa0RDV21xejV6OHpnSzdXRGszZkpoemQ2?=
 =?utf-8?B?VSthaksyME00UG1sZE5xTlU3ZG1YcktuYTJ0eDFjcmkwRXBYNWdiZ1pqUGQ3?=
 =?utf-8?B?N3V4eXUyVjBHUE1ZdDZ1d29GSWdOd0d0V2ZRc0I0cFVmRnNsb0JjbWUyT3hk?=
 =?utf-8?B?bm1SWUlpYjJSMjh6YzZUdWFVSHFuOW43d1ZqWW9DRFB3a0FPY2lmVURPVmoz?=
 =?utf-8?B?N2ZvMVBkK3JFcFBtUkZieXdLOWQ0cVVHT2o3SlNadDhMNThhNXdrSmMvRnVu?=
 =?utf-8?B?Ti84RE5Ua3dmMitIZGc3dm5UdjcwWnFsclY2K2JUYnhDaDVyQU0zNWtDejBj?=
 =?utf-8?B?aSsyQWQ5RmxTQ3F2NytuMEtzc3ZqK1VUNkpmeklTQTJGWDdSa2hXRmFjUURq?=
 =?utf-8?B?ZEE2QXEvT2ZvK1hjditWUHVHN2pBSzAzUWhPak52aDlZQnVtbDk0c3hYaFNh?=
 =?utf-8?B?ZDR6c3pHNWw0cmFOS2JCM2RyK2t1L0VaMXkwMVJOdjRtSTNFL0F3QzVuOW16?=
 =?utf-8?B?UDZLcndPdVhQZXZOZ01kaCtyKzNWY1kwek5nWDN1NHdTcXc2eGl3VHJibFFD?=
 =?utf-8?B?WHMzMis4L2xueVNXRHAvUy9YYzkrVGRPUkJsenpyRllDSFlxZjdZMlYwUGNh?=
 =?utf-8?B?V0x6alhRRjNmelJESjlKalgvMmNBQU9aQnovRlltZnhSQTlocnFnNjRDdGlK?=
 =?utf-8?B?eUQyNXZyM1FXeENaQ2RmYzR1dTM2Y1ZkQlhDT0pPa0JZU0tjU1NXcVJ4S0p3?=
 =?utf-8?B?NVlOVUU2N2FRUUJySkhlaTN0R0NsZGNxTmxKN04rZ0xKYXlzRjgwNWN1VHU4?=
 =?utf-8?B?SWtUSE5xRkdOaUNTY2lsYWE4SUxRZHhLV1pzWlMrTHlWM0NFMnczQko2RldD?=
 =?utf-8?B?cWZrazNpaFpncVYzUGZZQmZEMUhHK2RkNVA4WGpIUGV2TDQ1RzVjeHpPNTFU?=
 =?utf-8?B?cVllL2o5dHhHUElua0xNSnQ2UGQ1OXlNV0lYYjA0Si9Va05rN3paUGNWanNB?=
 =?utf-8?B?WUlnQmhMMmFNc0pyM3c4WUlCbjV2YkxrUytiOVJZZHF1MFY2a3B2SFg0cDFH?=
 =?utf-8?B?ZE1Pa0VlMFFDak9Hei9ELyt6dVFNSlh4UHJzODZOZzNIMzNZNG5CbWVBRk1z?=
 =?utf-8?B?eFZNV3hXeitXL1l2SDd5N1ZZak9uZExsZnNZTlFEOGZkZWZIbjZaQlFmVTcx?=
 =?utf-8?B?YUlrYlRrZXV2VHl6dHBsN2I4Mkc1MWFFcGsxbWpJeDIyM2djUU5rY25lNVZu?=
 =?utf-8?B?eUszUVUwaEJtb0pPdjEzS2E0aGdmYmxHQ0FvWGU3NXZicm1hQjFoZ2R5aTFI?=
 =?utf-8?B?aUgvVEhkaEhtaXo0ekREQ201NnB4VGpqS3Z6WU01REo1aVVlZ245aHIwTGgx?=
 =?utf-8?Q?LFQUqe8hhO07Gtn6e99vLsQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0krT2ExT1pjL0N1ZnMrUWlJM0E5aG9ocmxIVTdyejBYWlVJRjBIRWpGaDdw?=
 =?utf-8?B?QTY1MjIvbldVdEd2WS9FaytrMWhWcjVoUDJPQzVmT2w0YnVWRU5RSWw1Tk9H?=
 =?utf-8?B?MkVqaUVEbEdjM2NlRDlDRkV2bmVGYStISkQ3djlVcjRGNUQ1ZHdrOGY2dTQw?=
 =?utf-8?B?Y2JXRDFoQjdXc2grb0RFMW0vVHpyRnBYV2VlSVNKSFpOWVpGLytaUXdNbGxr?=
 =?utf-8?B?VEgzS0xKdFA3eWlUY3RZYllYSTVNb1pHaGtPMStJU0tlYkJGaVM3SStGbEFQ?=
 =?utf-8?B?Y3kwM3BSR1lBbG8xOW1aTHFwdGtRbUF6TFlFbEY0TXVLTmMyc2Q2bCt0VU93?=
 =?utf-8?B?N3hiZmZaMWhiUFRTY1dGb1RVYjVnVXVQTjF0eXlvWHIyQXNNcHVPMXZVT1Fz?=
 =?utf-8?B?OEhHeGtBSHhRT2pwVWI2ZkFIdGRvT1RvUUJkd3lnMUpIakh4djAybWFaWUYr?=
 =?utf-8?B?ZU4yMTY3Tkt0aUl1emYrTkw4TjRJWmFDTGlzNmRiSVY2TzlzMGhkU29FYkRk?=
 =?utf-8?B?K3Fza1oyQXI0bGFqa3BJaFdNMlVrcmpkWGJKWlI3ZUdqV1FDUnYrLzB1VzF3?=
 =?utf-8?B?QjlTdlpsbTlPMnh1TTNISVpNcUU1dFZpbXhLVktQcWpvSW1MYitYUWZlbGxw?=
 =?utf-8?B?N2pTSFpWM3pJaG1abDJYS1Z2dFIzSmVvY3dGTUh3TmRoU0kzSWM5NWdvSFB3?=
 =?utf-8?B?WnZDSnNLdmNuRjIwSmpoUzI2L0JLOVdoS2d2ZVFZN1JObnRrTHpTQlZXRjZi?=
 =?utf-8?B?QWVHc2R0aURHVXMrcVhsQVNNRUtLUTRMc1ducyt6a2VHVG9uUWxQMWFybHRL?=
 =?utf-8?B?WHBTaWtDZS8xSHRUaWwwTktuRmVtYVI2MjFJSjZXZVM2ZlVoZ05Hb2dJazVp?=
 =?utf-8?B?ZVlRY2g0SUdhWllCa3dmbUUvUVg5ZmF0Nys4Zmh1VUpSQ2ZvblZEcFdXQ3Q1?=
 =?utf-8?B?bDFpaXJNMnY5U0lZUUg1dnJ5WmVmV1gydWo1QWl4amRNUXVKMFdjckgvU2Y0?=
 =?utf-8?B?bDFuWlM5UXN0QkIyM05NRTYzckxDeEhiTmorbjlFYlVqTjZ4YnF3d0drMFhV?=
 =?utf-8?B?ZDZkMDV5OGRBbFNJQ3VIWlpsRmlvaC9TRDM4eWlUZ1grcTQ5RFRSVTZYQnJR?=
 =?utf-8?B?WGw2UXlDT2hwSDJPRkZSUFgyckc0Q2QzRlp6aXdDazZ1MkFNUkxRUXNLR2gx?=
 =?utf-8?B?VjVGdlgrN2xUcjJaWnBnZlZiclBqbzdrU3NGNElqMlgvcVEyNVRQb1RBQStS?=
 =?utf-8?B?ZkdvdWwybWJSY0RrV2tTaFdHcHlCK29paHNrK2RrSWl5N2c2WXlpOTVjd28x?=
 =?utf-8?B?TFdOTXZab2h4TnNvNGc0aHZxUlU5U3UwRDRHOUtoM29vejBFN0J5Vk44UjNr?=
 =?utf-8?B?MkV4MjczdElVOFlhNnQ0blhyNXBBMjhuL2xlNkR2Y0s2OU1QbGpUYndUMFli?=
 =?utf-8?B?bHVOZ0orZjh0SW9BdDRiZUpOWEo4L1BkMjBPUllzQjBQVzhLOU5HSXdKdWhp?=
 =?utf-8?B?RnV3S0ZDOFRoeUk1NUU2MlQ5VXVHR2xMQmZkQjdZK21GSm9HaU1SdE5kWUhW?=
 =?utf-8?B?VW1XSE1zOGhWb29rNmx6QVU0SDYzRUdOQnViVEo1VEU5L3RpcDkrTTNTS2ZZ?=
 =?utf-8?B?Z09WRXVlc2xPUXQwVHNNNkQrb0dOenNNYU5SVUc1N0U1eWRVSlNYQlFRT0VP?=
 =?utf-8?B?bGxSSldKckREall0UzVoMTFvNHpYTU1hNDhUS3IxRjdxL2dFeFd3US9kVG16?=
 =?utf-8?B?Z1JGelk4OEdXTWxCTHRDNnJEZ2ZlS3Y5bzY3TzBSMEgxWE8rNjZZRXdqSkhm?=
 =?utf-8?B?dG9lczFhVWI5NWg3L0VoNys1RzJoTXM0ZGNGM1JGN2RScEExcWZSNlMvQyt2?=
 =?utf-8?B?MVJQaDRFR1NPcTFielpxK01ZY1NxMnc1bXMxQm1BU0YyTUlsZjRyNHAzMG5x?=
 =?utf-8?B?b3o1R0o4MzY4UjVGbXg0Qko0SkFCb2FOaVp6ODJEZEdPeUdyL1pPZGxNcENG?=
 =?utf-8?B?Y0w1Q1A1a2RRaW9keG1FSWNmSjBjMHlTOXYxWmQxbklZU0JoYktKTG0vYWZy?=
 =?utf-8?B?Rjkzam1Nc0I4cGUyWnRyWU8xY01kK1ZoS0Riazl1blJxRGd2d2VaVitJZmNl?=
 =?utf-8?B?RDA2bEtoWERPdnB5WWJMUnVuSFZlSW40d2d6YXlWWUw1b1Rzcm8xZzg4N3Ax?=
 =?utf-8?B?NHZuaGZzTDBkckNsV3MxSnpxN2piMVFGZ203UzY1aXhuS0VEVFVyQVd0QlFs?=
 =?utf-8?B?QXYvbEdyeEtJbWFXR3ZEb2plOGNZQmF6cjVBZ2VjV0U4SlBVdnlVNURicWZO?=
 =?utf-8?B?L3IwV3pSOXpHTlRLRmxUb1VDRGNhbU95dUFabmdGNTV4djFyKzVRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b27ba2-5df9-409c-9184-08de63b8515e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:42.2860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bVWfuzW0fMwUrYiqWqVPHaT+QAyC15OHDRQ4/84rC+5Ur50jkw/8XFiIxBr6daogcE9rga/qC2XfiJjsnCInjzEBK4wUi5FOBylwMqrJDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

QVNUMTcwMCBleHBvc2VzIG1vcmUgSTNDIGJ1c2VzIHRoYW4gdGhlIGN1cnJlbnQgZHVtbXkgSTND
IG1vZGVsCnByb3ZpZGVzLiBXaGVuIExpbnV4IHByb2JlcyB0aGUgSTNDIGRldmljZXMgb24gQVNU
MTcwMCB0aGlzIG1pc21hdGNoCmNhbiB0cmlnZ2VyIGEga2VybmVsIHBhbmljLiBNb2RlbCB0aGUg
STNDIGJsb2NrIGFzIGFuIHVuaW1wbGVtZW50ZWQKZGV2aWNlIHRvIG1ha2UgdGhlIG1pc3Npbmcg
ZnVuY3Rpb25hbGl0eSBleHBsaWNpdCBhbmQgYXZvaWQgdW5leHBlY3RlZApzaWRlIGVmZmVjdHMu
CgpUaGlzIHdpcmVzIHVwIHRoZSBJM0MgaW50ZXJydXB0IGxpbmVzIGZvciB0aGUgSU8gZXhwYW5k
ZXJzIGFuZCBhZGRzIHRoZQpjb3JyZXNwb25kaW5nIGRldmljZSBlbnRyaWVzIGZvciB0aGUgQVNU
MTcwMCBtb2RlbC4KCk5vIGZ1bmN0aW9uYWwgSTNDIGVtdWxhdGlvbiBpcyBwcm92aWRlZCB5ZXQ7
IHRoaXMgb25seSBwcmV2ZW50cyBjcmFzaGVzIGFuZApkb2N1bWVudHMgdGhlIG1pc3NpbmcgcGll
Y2UuCgpTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNv
bT4KUmV2aWV3ZWQtYnk6IEPvv71kcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+ClJldmll
d2VkLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4KVGVzdGVkLWJ5
OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4KLS0tCiBpbmNsdWRlL2h3
L2FybS9hc3BlZWRfYXN0MTcwMC5oIHwgIDMgKysrCiBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29j
LmggICAgIHwgIDIgKysKIGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAgfCAxNSArKysr
KysrKysrKysrKysKIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgfCAxOCArKysrKysr
KysrKysrKysrLS0KIDQgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oIGIvaW5j
bHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaAppbmRleCBiNWNiMGE5MDEwLi5mN2JkNGU4NjUw
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCisrKyBiL2luY2x1
ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgKQEAgLTE5LDYgKzE5LDcgQEAKICNpbmNsdWRlICJo
dy9zc2kvYXNwZWVkX3NtYy5oIgogI2luY2x1ZGUgImh3L3dhdGNoZG9nL3dkdF9hc3BlZWQuaCIK
ICNpbmNsdWRlICJody9jaGFyL3NlcmlhbC1tbS5oIgorI2luY2x1ZGUgImh3L21pc2MvdW5pbXAu
aCIKIAogI2RlZmluZSBBU1QxNzAwX1NHUElPX05VTSAgICAgICAgICAgIDIKICNkZWZpbmUgQVNU
MTcwMF9XRFRfTlVNICAgICAgICAgICAgICA5CkBAIC00Niw2ICs0Nyw4IEBAIHN0cnVjdCBBc3Bl
ZWRBU1QxNzAwU29DU3RhdGUgewogICAgIEFzcGVlZEkyQ1N0YXRlIGkyYzsKICAgICBBc3BlZWRQ
V01TdGF0ZSBwd207CiAgICAgQXNwZWVkV0RUU3RhdGUgd2R0W0FTVDE3MDBfV0RUX05VTV07CisK
KyAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgaTNjOwogfTsKIAogI2VuZGlmIC8qIEFTUEVF
RF9BU1QxNzAwX0ggKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBi
L2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaAppbmRleCA0ZWEyNTIxMDQxLi5iMTg1YjA0MTg2
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgKKysrIGIvaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oCkBAIC0yOTQsNiArMjk0LDggQEAgZW51bSB7CiAgICAgQVNQRUVE
X0RFVl9JT0VYUDFfSTJDLAogICAgIEFTUEVFRF9ERVZfSU9FWFAwX0lOVENJTywKICAgICBBU1BF
RURfREVWX0lPRVhQMV9JTlRDSU8sCisgICAgQVNQRUVEX0RFVl9JT0VYUDBfSTNDLAorICAgIEFT
UEVFRF9ERVZfSU9FWFAxX0kzQywKIH07CiAKIGNvbnN0IGNoYXIgKmFzcGVlZF9zb2NfY3B1X3R5
cGUoY29uc3QgY2hhciAqIGNvbnN0ICp2YWxpZF9jcHVfdHlwZXMpOwpkaWZmIC0tZ2l0IGEvaHcv
YXJtL2FzcGVlZF9hc3QxNzAwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYwppbmRleCAxNzQx
ODY5NjRlLi5lOTAzMDJjMTFiIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYwor
KysgYi9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYwpAQCAtMTUsNiArMTUsNyBAQAogCiAjZGVmaW5l
IEFTVDI3MDBfU09DX0xUUElfU0laRSAgICAgICAgMHgwMTAwMDAwMAogI2RlZmluZSBBU1QxNzAw
X1NPQ19TUkFNX1NJWkUgICAgICAgIDB4MDAwNDAwMDAKKyNkZWZpbmUgQVNUMTcwMF9TT0NfSTND
X1NJWkUgICAgICAgICAweDAwMDEwMDAwCiAKIGVudW0gewogICAgIEFTUEVFRF9BU1QxNzAwX0RF
Vl9TUEkwLApAQCAtMjYsNiArMjcsNyBAQCBlbnVtIHsKICAgICBBU1BFRURfQVNUMTcwMF9ERVZf
U0dQSU9NMCwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NMSwKICAgICBBU1BFRURfQVNU
MTcwMF9ERVZfSTJDLAorICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9JM0MsCiAgICAgQVNQRUVEX0FT
VDE3MDBfREVWX1VBUlQxMiwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMLAogICAg
IEFTUEVFRF9BU1QxNzAwX0RFVl9XRFQsCkBAIC00Miw2ICs0NCw3IEBAIHN0YXRpYyBjb25zdCBo
d2FkZHIgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7CiAgICAgW0FTUEVFRF9BU1QxNzAw
X0RFVl9TR1BJT00wXSAgID0gIDB4MDBDMEMwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9T
R1BJT00xXSAgID0gIDB4MDBDMEQwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9JMkNdICAg
ICAgID0gIDB4MDBDMEYwMDAsCisgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9JM0NdICAgICAgID0g
IDB4MDBDMjAwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTJdICAgID0gIDB4MDBD
MzNCMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdID0gIDB4MDBDMzQwMDAs
CiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9XRFRdICAgICAgID0gIDB4MDBDMzcwMDAsCkBAIC0x
NzgsNiArMTgxLDE0IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX3JlYWxpemUoRGV2aWNl
U3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICAgICAgICAgICAgICAgICAgc3lzYnVz
X21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+d2R0W2ldKSwgMCkpOwogICAgIH0K
IAorICAgIC8qIEkzQyAqLworICAgIHFkZXZfcHJvcF9zZXRfc3RyaW5nKERFVklDRSgmcy0+aTNj
KSwgIm5hbWUiLCAiaW9leHAtaTNjIik7CisgICAgcWRldl9wcm9wX3NldF91aW50NjQoREVWSUNF
KCZzLT5pM2MpLCAic2l6ZSIsIEFTVDE3MDBfU09DX0kzQ19TSVpFKTsKKyAgICBzeXNidXNfcmVh
bGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+aTNjKSwgZXJycCk7CisgICAgbWVtb3J5X3JlZ2lvbl9h
ZGRfc3VicmVnaW9uX292ZXJsYXAoJnMtPmlvbWVtLAorICAgICAgICAgICAgICAgICAgICAgICAg
YXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9JM0NdLAorICAgICAg
ICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgm
cy0+aTNjKSwgMCksCisgICAgICAgICAgICAgICAgICAgICAgICAtMTAwMCk7CiB9CiAKIHN0YXRp
YyB2b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCkBAIC0yMjcs
NiArMjM4LDEwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNlX2luaXQoT2Jq
ZWN0ICpvYmopCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT53ZHRbaV0sICJh
c3BlZWQud2R0LWFzdDI3MDAiKTsKICAgICB9CiAKKyAgICAvKiBJM0MgKi8KKyAgICBvYmplY3Rf
aW5pdGlhbGl6ZV9jaGlsZChvYmosICJpb2V4cC1pM2MiLCAmcy0+aTNjLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UpOworCiAgICAgcmV0dXJu
OwogfQogCmRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC5jCmluZGV4IDgyNDIyNThkZjQuLmQzYjMwNWZhN2EgMTAwNjQ0Ci0tLSBhL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC5jCisrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jCkBAIC0x
NTgsNyArMTU4LDkgQEAgc3RhdGljIGNvbnN0IGludCBhc3BlZWRfc29jX2FzdDI3MDBhMV9pcnFt
YXBbXSA9IHsKICAgICBbQVNQRUVEX0RFVl9QRUNJXSAgICAgID0gMTk3LAogICAgIFtBU1BFRURf
REVWX1NESENJXSAgICAgPSAxOTcsCiAgICAgW0FTUEVFRF9ERVZfSU9FWFAwX0kyQ10gPSAxOTgs
CisgICAgW0FTUEVFRF9ERVZfSU9FWFAwX0kzQ10gPSAxOTksCiAgICAgW0FTUEVFRF9ERVZfSU9F
WFAxX0kyQ10gPSAyMDAsCisgICAgW0FTUEVFRF9ERVZfSU9FWFAxX0kzQ10gPSAyMDEsCiB9Owog
CiAvKiBHSUNJTlQgMTkyICovCkBAIC0yMjEsMTIgKzIyMywyNCBAQCBzdGF0aWMgY29uc3QgaW50
IGFzdDI3MDBfZ2ljMTk4X2ludGNtYXBbXSA9IHsKICAgICBbQVNQRUVEX0RFVl9JT0VYUDBfSTJD
XSAgICAgICA9IDAsIC8qIDAgLSAxNSAqLwogfTsKIAorLyogUHJpbWFyeSBBU1QxNzAwIEludGVy
cnVwdHMgKi8KKy8qIEExOiBHSU5UQyAxOTkgKi8KK3N0YXRpYyBjb25zdCBpbnQgYXN0MjcwMF9n
aWMxOTlfaW50Y21hcFtdID0geworICAgIFtBU1BFRURfREVWX0lPRVhQMF9JM0NdICAgICAgID0g
MCwgLyogMCAtIDE1ICovCit9OworCiAvKiBTZWNvbmRhcnkgQVNUMTcwMCBJbnRlcnJ1cHRzICov
CiAvKiBBMTogR0lOVEMgMjAwICovCiBzdGF0aWMgY29uc3QgaW50IGFzdDI3MDBfZ2ljMjAwX2lu
dGNtYXBbXSA9IHsKICAgICBbQVNQRUVEX0RFVl9JT0VYUDFfSTJDXSAgICAgICA9IDAsIC8qIDAg
LSAxNSAqLwogfTsKIAorLyogU2Vjb25kYXJ5IEFTVDE3MDAgSW50ZXJydXB0cyAqLworLyogQTE6
IEdJTlRDIDIwMSAqLworc3RhdGljIGNvbnN0IGludCBhc3QyNzAwX2dpYzIwMV9pbnRjbWFwW10g
PSB7CisgICAgW0FTUEVFRF9ERVZfSU9FWFAxX0kzQ10gICAgICAgPSAwLCAvKiAwIC0gMTUgKi8K
K307CisKIC8qIEdJQ0lOVCAxOTIgfiAyMDEgKi8KIHN0cnVjdCBnaWNfaW50Y19pcnFfaW5mbyB7
CiAgICAgaW50IGlycTsKQEAgLTI0Myw5ICsyNTcsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdp
Y19pbnRjX2lycV9pbmZvIGFzdDI3MDBfZ2ljX2ludGNtYXBbXSA9IHsKICAgICB7MTk2LCAxLCA0
LCBhc3QyNzAwX2dpYzE5Nl9pbnRjbWFwfSwKICAgICB7MTk3LCAxLCA1LCBhc3QyNzAwX2dpYzE5
N19pbnRjbWFwfSwKICAgICB7MTk4LCAyLCAwLCBhc3QyNzAwX2dpYzE5OF9pbnRjbWFwfSwKLSAg
ICB7MTk5LCAxLCA3LCBOVUxMfSwKKyAgICB7MTk5LCAyLCAxLCBhc3QyNzAwX2dpYzE5OV9pbnRj
bWFwfSwKICAgICB7MjAwLCAzLCAwLCBhc3QyNzAwX2dpYzIwMF9pbnRjbWFwfSwKLSAgICB7MjAx
LCAxLCA5LCBOVUxMfSwKKyAgICB7MjAxLCAzLCAxLCBhc3QyNzAwX2dpYzIwMV9pbnRjbWFwfSwK
IH07CiAKIHN0YXRpYyBxZW11X2lycSBhc3BlZWRfc29jX2FzdDI3MDBfZ2V0X2lycShBc3BlZWRT
b0NTdGF0ZSAqcywgaW50IGRldikKLS0gCjIuNDMuMAo=

