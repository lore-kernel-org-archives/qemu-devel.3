Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F22606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=EG3GRlJr;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=BO2Lqb6l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzZz-0007bb-6e; Tue, 10 Nov 2026 23:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzZs-0007Zo-LT; Tue, 10 Nov 2026 23:04:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzZq-0004Ko-E6; Tue, 10 Nov 2026 23:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794369890; x=1825905890;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VZiAWUSG/vshb8dk92iZlH2NHMoUF79Sdyg9hSGZoE4=;
 b=EG3GRlJrhXzvUKwdS+vqW+PgvTddSrmd2PLBD41aVE/P9HPc/TVijJXR
 MiqtYS3/JmZMrFzCvyaoUPY94qACMHCn9oPSvCjSwBdXG/Z1BO6k75mJi
 g6vX+UbWC1z4C3eKrzDI827+OQ2DATwY8Tzxok/6osGETuPtK6p1/Rqcn
 +8T2S8OFnjfQuOs58+eSfTehXfWS3R8zbwjzKbvoL5wjoroHINGLA3u9a
 oLqaa4uDh6G21+AdhfJNuXK3C9i7xx69zeQAN1lAovHe8Pu/fdq4+BpOA
 zKm+67/X4DahbnaQTvU3oHfHJ0EbHdbSzugb6PJTVUUkyCNhNqB8G9ypu w==;
X-CSE-ConnectionGUID: PXU5bV1iTzS/i0vDzgvvjw==
X-CSE-MsgGUID: oXFCXG5eSNy8rJJ/kmnvRA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="156364579"
Received: from mail-westusazon11010015.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.15])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:04:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAiS54eGKgxMS/km9Jkna3Y7dGsmQAArVfxrBbnlyd0BTD6OrRO8+XgExpDY0wSXfJRWg7YgkMoME5UZUzhbKBXHMSVjVOIP42qiy9qSx3G7wMwOBikYqWLVBGV2TR8YqcI84mL5oWV2YFI4EBdW8NEhn7Q4+Ohj4/fVygntD5Js8Fs+8Vp44O8suP3sf05/MH1SKo9fCuzYiyb/rmlLQR1MFrOqsyNjJmmOUoWWcVtb0WTzvr8QIoqhqVv3MQCYKf0NNCQV6/sS1gsHmA1imi2bVEIN9rKgfPl9ksHnCvdj7ilETY5OqO/Y6rGEu+OxMAge9Zy1MDQ6gdJv3aL5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZiAWUSG/vshb8dk92iZlH2NHMoUF79Sdyg9hSGZoE4=;
 b=GtLVI3bRV9cfYrA+B8EDzsa44eJQbRE673t0AH3Weu/i7XrSyWKTvBIFugF3jUzJgPrIajbBpz7vYQdDYIzwcvTYmbLCiYcRPA1W6Kb2vWjkB7sv44z2LK10q4igbyll9D5vPtgT0AloqwW+iSJT28BYdjlH1NkYqHf7QUYH1xMJxaB2lFCEjZZE8q9xt3dZsaiuhJR3nzX2ExvfPoiOGZHLymSTD3jvFUi6MggrFcqzdpT0ITWSPk6I0P1KJlLC7A72CH8bshHw5R+aWsfYNnn0spwExqa2JaSCY4eVZG43bdzBGM/d1/Wc81IiuRiGJzwVKoBEUePK2drGJ2yzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZiAWUSG/vshb8dk92iZlH2NHMoUF79Sdyg9hSGZoE4=;
 b=BO2Lqb6lVtHUEljuru3OafFu3o3Zhz3EgL6MtxrPg4EamgGQkWbdz/7dkHJ22aDWmXvKa/piwYaPetGrdsBpvekD0G6GA71tHQrVmqoGjFoaQeEzuH7z55MXbR/2kafEGua+2+EvLQjihLY5+1tlraoFb1p7MRsKNJNvO6xufD0=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH0PR04MB8475.namprd04.prod.outlook.com (2603:10b6:510:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:04:46 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:04:46 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lyndra@linux.alibaba.com" <lyndra@linux.alibaba.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/14] RISC-V TCG PMU correctness fixes
Thread-Topic: [PATCH v3 00/14] RISC-V TCG PMU correctness fixes
Thread-Index: AQHdWH1CLw7vP6WphUSa1UOkukA9yrcPPB6AgBk2eAA=
Date: Wed, 11 Nov 2026 04:04:46 +0000
Message-ID: <eea7a693a2c2fcb212d9d436f75d60f04da042c1.camel@wdc.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
 <b7570d0b-0c22-410b-be3a-db05a53e95f7@linux.alibaba.com>
In-Reply-To: <b7570d0b-0c22-410b-be3a-db05a53e95f7@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH0PR04MB8475:EE_
x-ms-office365-filtering-correlation-id: d871023f-f861-46e0-cd7a-08df3fa8ec48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|19092799006|376014|1800799024|7416014|366016|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|38070700021|4143699003|261026140227099003;
x-microsoft-antispam-message-info: 5uEZhP6k3F/mOZKjXJDyI1ULOJa1hdmxGhD1N1MqLzk+na+PKgdgRRT94TneWI7J5/r6ilRR1n36dfuJnKMinaPjevih+gWpo1l1Ve6bsf2dOJKhSpPSjo9nKna8ioHbD2revxGcA2jHE7dVI3sYQGRv0mVJC9jQ4TY73u+81j177o8Yjq9py844Kzzcg0B9HbfAZWA89EZtJJn8j4fwOu6VXwTtj24VanUiNd6yoe/3pQ42n/CtJ03Kd4PMQR056AB0MxX6qdcaTVmpPJxTDWP2PTc3ax9+yQtRHO6nsqCgJxMr6aSmgbEnMnlaH+B9N8N8rON/8gdJe9RbxY/u3ZuTHdikqbyQ2MZul4VCCp9Zow++AipWqHCl9JvZp/1qASpu5fJv8RcTgPsaH8v0lPErPYZZdw9FHaKm6uSKk8YJi8D5aJYAmjByWPBLdw2qARWmGAjh+g0odZvlXVGtVSJneH/P9UFrnNY6o6BquXnt3WLjfnWdGvpiUrx9QnoAHJqa+ECeEn2INRepMI9LYDc3m0JKUu0j9mELB9/w2C9zSQfnUPck8IyzGiO2wmk7Y5vTJrIMAg6Lh0Zw5KdWbkByCOyl5nQQCyBdYzp3mJYRntR/Kf2H2ciIL8UCS7wb2dyfvYrbxsnukRiJjKROF+1c/RO7CMSOgiFzPhUp+zw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(19092799006)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(38070700021)(4143699003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3lYajAwVHNFT1F5RFdOL0xGRlcrYis5d0twUlVsVkF2NmVlNUUwVDU3L0tp?=
 =?utf-8?B?aDV2MmdwSU5CWWdoMHQyWUE2K2RHS09BMWJvTUJxUG9zbTJlUUJvNE1iMHdR?=
 =?utf-8?B?TE1abUpDcXAzSk9jakg2ekVhSENZQnh0MjQzSmlwOUQvd1pDVWVJdkhpY08r?=
 =?utf-8?B?Um96bTR4NVZvKzN1OVNYeUovQUtYMTB2bVhFdWlmbVoyMXJBTW00aVdROXR6?=
 =?utf-8?B?ZlNlajJsTHBnbi9yZmtyb0FUUmNGUERnWjhuNGlzU3hCWU92ZnRMOUJCa0ZP?=
 =?utf-8?B?eThpVnpLU1VNU05mUmpQMkRTK0crTlRoZUl0dEVPKzR3TWFRekdpZlhEejlC?=
 =?utf-8?B?dDNyUkluRURkMTl2c1prMmpXK241dCtrYlViSStnWTQ3elI5aGFGTjRUbFVK?=
 =?utf-8?B?MEhJMTdhcHR3UHZ6SzlsVkFSMmtNSTNCL3ZzeW1yNGxwTElBY1hwUHlvWURH?=
 =?utf-8?B?UHo3aWJnZm5kSnJqa3dVaTN5aW1nMzV6ZjBianJ2V3FsdFhtVVVqbzRrT25D?=
 =?utf-8?B?TVhucysrd2hZWnNtTmZSUEpVY3B4LzkyQVcyRkx6L2E4YjR0UGxOU09jT2x1?=
 =?utf-8?B?cldLYnN5S0tLN2FlRFhrOHlUb3hsbW5DRkZyaHpVOXk3Z0ZrN01RREkzZmZR?=
 =?utf-8?B?V0xvd1h3Z3FmRjNjZTVGYS8vZi9aT0puY09FUzQ4MU5ybW5CUU94UE40ZGFR?=
 =?utf-8?B?M1Y3Ni80eWRHUFJYMlJYWmZsMGkwSUJXeWtWVjc5NmwyNmg3Q1p2d25KWU0z?=
 =?utf-8?B?M2ZBanVCWm9leDNtNVVQZEtzaElkajZ5cUJKYlVrUWNUSVh3VGxvcFlzSVRR?=
 =?utf-8?B?UFhEWklLaFJHTWNhZTFOLzJMVks3d3dyQ2NVVHNKQitXKzhDbnZ1L0dwMEl0?=
 =?utf-8?B?dEZHeE9VM1FjWWpZTGZqWnhOb1R6K1FJWUFHUVBVNHZQbEhza2dxU2xaWEhz?=
 =?utf-8?B?S3VyK1NsWjV3aGhyYng0NnFHWlVIV20vcDk1VkF4OU5TdjZCanFSbTZyYXMz?=
 =?utf-8?B?bDRyWmNEN2FtUHBQOTI5VDJZTkVyUXNRbTB1VVZHeVJmanZyeDBDUHZvbitB?=
 =?utf-8?B?bS96Z0hJbzIvS2o3bEVQTXVKYk1mWFIzT0xKUWk5c2VzNXFDMGpQRy9Fb2ZK?=
 =?utf-8?B?Q1RXcS9FVExyMldJb2VSMm1HTkViOTlGVFd1NlNBek5Ka1ZTcVI3L1ZZVGVD?=
 =?utf-8?B?eFFNMmlvVWNka2Y4OXhKMDFaTkZnV21hWXNSSTV5cTBudHhPY2lnSzdJZ2FF?=
 =?utf-8?B?R2hXWmU1Uk5WSmlJNFVOZ1hqUU1kZm0vUmVRZlVSdWdOVkNsR0hNZndlckpa?=
 =?utf-8?B?WnVBZ1BaNThDMjcxcU5JOU9lemNPNGxNak0vZi9kTzRyU1Mycmoxb1ZxTlEx?=
 =?utf-8?B?TStOUHVZY1AwRDd4R0JPdmxrdnh1Q2d1V3dvL08wUmlLZWRsSFJvV21yanha?=
 =?utf-8?B?Sm9jNUhTUDhzNDBzU3hBdlVSZTBJYVFrY0pvYXZya244TG5ET0RhcldQdzNu?=
 =?utf-8?B?eEFuNjB2L1ptSzdUdytRbklLcENDMmczaTZyMGdKay9ob01nUWFQdkpmSWtC?=
 =?utf-8?B?cjRMYjFLYitKZEtRVGRKVlliTkM3MHkzYXI0ZlFOK2tIdURrSFoxSC8yZ0NZ?=
 =?utf-8?B?bDZtOExBeUVUNThSZ0NiTnl5eGxzTGF0dE16MEJHN0JzSlA2dnRaUjQ2RGJh?=
 =?utf-8?B?T01CZnd6c3BMUjNMelIyY3ZPdW83cktCdDhybVVyajVGK2lISXg2NVltRUtF?=
 =?utf-8?B?LzdLK3cxejRpTjdJbFZ5UmNiYmJqSlJUeG5uR3RLSUpzclFiVXFNTlhVR3BS?=
 =?utf-8?B?WExqN3o0REFuVVEyc2lycnFzQzBMMGN4TGdIbERVR3V0SHppSXNBcHlkMXZt?=
 =?utf-8?B?dHR4eG4zK3Q3bmxFSSt5UkxPR2RXdFdPRTg5MnJlYzJtNjA1YUgzTjZzS0Zi?=
 =?utf-8?B?R3BNQ0tpc1VXc2pScTJGUTBtUkRZWW91MU5hdXBndmRRRnpiSmVWaWFQMDE2?=
 =?utf-8?B?dG42ZG9mQk12dnRKclFQZ25oenBoWm5KTjIrcGgyUU8rVG1tUlhMaTM2dWZ2?=
 =?utf-8?B?Z1pZdWcyOGFGUDdWLzRTcmR2S0NidzV4NDNTZDRqYm1VbU4wVjBKSnR5M1pp?=
 =?utf-8?B?ZXViMnBaQ1ZaSTdWTS9tSTZXUU9wZkVGVTdUUnFoQkZxNG1mQm5WdVZyVUhh?=
 =?utf-8?B?SkFuK2lKTFpYSDJCcnR3ZUdFdXZsa1hCRVBqQk14eFdQRi9pVXRjemxNUEF4?=
 =?utf-8?B?OWlnQk1CREhleVBQU1A5c21PNWJESmRyd1I0SDM5U3dPa3p6N25NU0V6VnFk?=
 =?utf-8?B?Z1g1eHdCbEErWGdCV1hYK3l3UEtWOFdFSXNlZnVjbi93c2lRQmVnSmQ3VHRS?=
 =?utf-8?Q?tXJboyamDHtFD7qJDci4f+NzPHbg7sQlQGkyzYuDnaQqN?=
x-ms-exchange-antispam-messagedata-1: INNdP8ookug/XluT3Bp1Pwx7UxvKeCOQomc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6919855C3ADE864795F0671216BB4980@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hcyHrU2ERwPQYzsZQ4G9N445ysqcGipomqvdvbLpbunEJ5C+lQUDYUY0M7WWkKs/3XZqGs0pS5v781/UH2GRhHylxg3/ITU+Z2s3OR08Rs4FpQbMxAN10Hg8IcBwupfgYJXCA+TlGzYwLJOm1PQm/6mOo38B3AIaD6CXUatyrB78UZuuPK6mmoLkdjvCD2csZYDLFZFn2q42MSwOs8DqkdQ/tIu8TFhm0jVm/Sa1+godF6Ezn+LqNv42TA35neBoyP2pjRBETYvjpTCWUc3dlOQsyRJ4G1ajwJToPGdwgjaDy9j/WLPtyOb9zBBrQ62qXQEFLUCFchfxr+qrWKU8HQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dMdOwDZjjN8prcTotJJDK0NwbVVmPA1CqauSg29pqQDUtKf8linkRo4X8FKWEACdPVCmq7dJRGj2EBL/Qd5zIPICZ7zSansBmCRY3d0hXH2EGci6jhLM9oo7NC9AzfRxwH2/IhSBGc9tGTlMZALIKJ67JD/eci/Cipg5hTAU88VgQIP69/1jpURY2fwo4PAHW5xXXellrW++57qR4rgaVvfxjln/6at2yTdxWBehNpeMFIjH1VnbImnugx5KxaBToqUwhjG/51joVbqGi9QSU93YhdZzgfHO4eyeMbhqF5BomOltgXFJIqu414WeqfyRdv4kmpsJG6NJJfiGwPpm01oCBx6BEIdPXCqH/3pXBZlN4hn+7UOIomhy5D4B+Xjw4eEjpfRmQbqEzu8fYjawMi70OtbDRadzZH/vkonZZ+dJL7x3KOsmM0xJZErfVujKqasuFou0crY2mtErZJpzWxmQHwfYRV2BKB/bh8ilWl5e6UhHEOQ/QS/DvFHszsZ+8JJvz452gcq6yb6QW5kohgqcqWvJb7aykqlh7/VNn7V6w++P6kz2gijJRrgMe7IScfVtdiDdKyDLleHS3S+l9v4/b2E3iw6HD1mq1fpPznTHztKR6IfMwFD5/W1OmwOx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d871023f-f861-46e0-cd7a-08df3fa8ec48
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:04:46.0880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cB2LJcm4cRRj9tS3GtR5AuGvsG/u6oJXB4PPhNM1/+O9w2JGvbOv4EYaObFbXeJMGSik7CFQcaRtuYUoYyGXWzxyNm6DPw/gOupdunqKUnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8475
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjAzICswODAwLCBUaWFuQ2hlbmcgVEFORyB3cm90ZToN
Cj4gSGkgQWxpc3RhaXIsDQo+IA0KPiBUaGFua3MgZm9yIHF1ZXVpbmcgSGFyc2hpdCdzIGZpeCBb
MV0uIFBhdGNoIDkgb2YgdGhpcyBzZXJpZXMgcmV3b3Jrcw0KPiB0aGUNCj4gUE1VIG92ZXJmbG93
IHRpbWVyIGFuZCByZW1vdmVzIHRoZSBhZmZlY3RlZCByZWFkIHBhdGguIFRoZSBwYXRjaGVzDQo+
IGNhcnJ5IFJldmlld2VkLWJ5IHRhZ3MgZnJvbSBEYW5pZWwgYW5kIENoYW8uDQo+IA0KPiBXb3Vs
ZCB5b3UgbGlrZSBtZSB0byByZWJhc2UgdGhpcyBzZXJpZXMgb24gcmlzY3YtdG8tYXBwbHkubmV4
dCBhbmQNCj4gc2VuZCB2ND8NCg0KWWVzIHBsZWFzZSENCg0KQWxpc3RhaXINCg0KPiANCj4gVGhh
bmtzLA0KPiBUaWFuY2hlbmcNCj4gDQo+IA0KPiBbMV0gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNjEwMjMwOTM1MjIuMzQzMzUtMS1oYXJzaGl0MDA3a0BnbWFpbC5j
b20vDQo+IA0KPiDlnKggMjAyNi8xMC8xMCAxNDowNCwgVEFORyBUaWFuY2hlbmcg5YaZ6YGTOg0K
PiA+IFRoaXMgc2VyaWVzIGZpeGVzIFJJU0MtViBUQ0cgUE1VIGFjY291bnRpbmcsIG92ZXJmbG93
IG5vdGlmaWNhdGlvbiwNCj4gPiBhbmQNCj4gPiBtaWdyYXRpb24uIEl0IGlzIGJhc2VkIG9uIHYz
IG9mIFplcGh5ciBMaSdzICJ0YXJnZXQvcmlzY3Y6IGZpeCBSVjMyDQo+ID4gZml4ZWQgY291bnRl
ciBhY2Nlc3NlcyIgWzFdLCB3aGljaCBpcyBub3QgaW5jbHVkZWQgaGVyZS4NCj4gPiANCj4gPiBU
aGUgcGF0Y2hlcyBhbGxvdyBtdWx0aXBsZSBIUE0gY291bnRlcnMgdG8gc2VsZWN0IHRoZSBzYW1l
IGV2ZW50DQo+ID4gYW5kDQo+ID4gcHJlc2VydmUgY291bnRzIGFjcm9zcyBzZWxlY3RvciwgcHJp
dmlsZWdlLWZpbHRlciwgYW5kIGluaGliaXQNCj4gPiB3cml0ZXMuDQo+ID4gVGhleSB1c2UgY29u
c2lzdGVudCBjeWNsZS9pbnN0cnVjdGlvbiBzb3VyY2VzIGFuZCBjb21wdXRlIHRoZQ0KPiA+IHNo
YXJlZA0KPiA+IG92ZXJmbG93IGRlYWRsaW5lIGZyb20gYWxsIGVsaWdpYmxlIGNvdW50ZXJzLiBU
aW1lciBjYWxsYmFja3MgcXVldWUNCj4gPiBjaGVja3Mgb24gdGhlIG93bmVyIHZDUFUgaW5zdGVh
ZCBvZiByYWNpbmcgTVRUQ0cgZXhlY3V0aW9uLg0KPiA+IA0KPiA+IE1pZ3JhdGlvbiBzYXZlcyBj
b3VudGVyIHZhbHVlcyBpbmNsdWRpbmcgcGVuZGluZyBpbmNyZW1lbnRzIGFuZA0KPiA+IHJlc3Rv
cmVzDQo+ID4gZGVzdGluYXRpb24tbG9jYWwgc291cmNlIGJhc2VsaW5lcywgZXZlbnQgbWFwcGlu
Z3MsIGFuZCBvdmVyZmxvdw0KPiA+IHNjaGVkdWxpbmcuIEEgbmV3IGNwdS9wbXUtZml4ZWQgc3Vi
c2VjdGlvbiBjYXJyaWVzDQo+ID4gbWN5Y2xlY2ZnL21pbnN0cmV0Y2ZnDQo+ID4gYW5kIGlkZW50
aWZpZXMgdGhpcyBmb3JtYXQuIEFsbCBUQ0cgQ1BVcyByZXF1aXJlIHRoZSBzdWJzZWN0aW9uOw0K
PiA+IGxvYWRpbmcNCj4gPiBvbGRlciBUQ0cgc3RyZWFtcyB3aXRob3V0IGl0IGlzIHJlamVjdGVk
LiBTb3VyY2UgYW5kIGRlc3RpbmF0aW9uDQo+ID4gc3RpbGwNCj4gPiBuZWVkIGNvbXBhdGlibGUg
Q1BVIGNvbmZpZ3VyYXRpb25zLiBLVk0gUE1VIG1pZ3JhdGlvbiBpcyB1bmNoYW5nZWQuDQo+ID4g
DQo+ID4gVGhlIHJlc2V0IGNoYW5nZXMgcHJlc2VydmUgdGhlIGZpbmFsIGNvdW50cyBpbiB0aGUg
b2xkIHByaXZpbGVnZS9WDQo+ID4gbW9kZQ0KPiA+IGJlZm9yZSBlbnRlcmluZyBNLW1vZGUgd2l0
aCBWPTAuDQo+ID4gDQo+ID4gVENHIHRlc3RzIGNvdmVyIFJWMzIvUlY2NCBjb3VudGVyIGFjY2Vz
c2VzLCBkZWxlZ2F0ZWQgcmVnaXN0ZXJzLA0KPiA+IHNlbGVjdG9yDQo+ID4gYW5kIGZpbHRlciBj
aGFuZ2VzLCBtdWx0aXBsZSBjb3VudGVycyBwZXIgZXZlbnQsIG92ZXJmbG93DQo+ID4gbm90aWZp
Y2F0aW9uDQo+ID4gd2l0aCBhbmQgd2l0aG91dCBTc2NvZnBtZiwgaW5zdHJ1Y3Rpb24gZXhjZXB0
aW9ucywgYW5kIHJlc2V0LiBUaGUNCj4gPiBSVjMyDQo+ID4gSFBNIHRlc3RzIGFsc28gY292ZXIg
ZnVsbC13aWR0aCBhY2Nlc3NlcyB0aHJvdWdoIHRoZSBzaGFyZWQgY291bnRlcg0KPiA+IHBhdGgu
DQo+ID4gDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDI2MTAwODAzNTE1MC4yMjIzLTEtZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbS8NCj4gPiBCYXNl
ZC1vbjogPDIwMjYxMDA4MDM1MTUwLjIyMjMtMS1mcml0Y2hsZXlib2hyZXJAZ21haWwuY29tPg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRBTkcgVGlhbmNoZW5nIDxseW5kcmFAbGludXguYWxp
YmFiYS5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIFJlYmFzZSBvbiBt
YXN0ZXIgZjk1ODdkNDA0NWM2IGFuZCBaZXBoeXIgTGkncyBSVjMyIGZpeCB2My4NCj4gPiAtIFJl
cGxhY2UgIkVhcmxpZXIgZXhwaXJpZXMiIHdpdGggIlRpbWVyIGV4cGlyYXRpb25zIGJlZm9yZSB0
aGUNCj4gPiBmbGFnDQo+ID4gwqDCoCBpcyBjbGVhcmVkIiBpbiBwYXRjaCAxMSdzIGNvbW1pdCBt
ZXNzYWdlLg0KPiA+IC0gQWRkIGEgRml4ZXMgdHJhaWxlciB0byB0aGUgdmlydHVhbGl6YXRpb24t
cmVzZXQgZml4IChwYXRjaCAxMykuDQo+ID4gLSBMaW5rIHRvIHYyOg0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTAtcmlzY3YtcG11LWNvcnJlY3RuZXNzLXYy
LTAtNWRhNTE1OWEwYzY0QGxpbnV4LmFsaWJhYmEuY29tDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2
MjoNCj4gPiAtIFJlYmFzZSBvbiBjdXJyZW50IG1hc3RlciBhbmQgWmVwaHlyIExpJ3MgUlYzMiBm
aXggdjIuDQo+ID4gLSBSZWdpc3RlciB0aGUgc3lzdGVtIFRDRyB0ZXN0cyB3aXRoIE1lc29uIGFu
ZCB1c2UgLWJpb3MgbG9hZGluZy4NCj4gPiAtIE1lcmdlIHNtY2RlbGVnLWNvdW50ZXItcnYzMi5T
IGFuZCBzbWNkZWxlZy1ldmVudC1ydjMyLlMgaW50bw0KPiA+IMKgwqAgc21jZGVsZWctcnYzMi5T
IChwYXRjaCA2KS4NCj4gPiAtIFVzZSBDU1IgbmFtZXMgb3IgbG9jYWwgQ1NSLW51bWJlciBtYWNy
b3MgaW4gdGVzdHMuDQo+ID4gLSBVc2UgVUlOVDMyX01BWCBmb3IgZGVsZWdhdGVkIGhpZ2gtaGFs
ZiB3cml0ZS1tYXNrIGNoZWNrcyAocGF0Y2gNCj4gPiA2KS4NCj4gPiDCoMKgIFRoZSBjYWxsZXIg
YWxyZWFkeSByZXF1aXJlcyBYTEVOPTMyLg0KPiA+IC0gTGluayB0byB2MToNCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTA3LXJpc2N2LXBtdS1jb3JyZWN0bmVz
cy12MS0wLTVmMWY0MTQ1ODk4OUBsaW51eC5hbGliYWJhLmNvbQ0KPiA+IA0KPiA+IC0tLQ0KPiA+
IFRBTkcgVGlhbmNoZW5nICgxNCk6DQo+ID4gwqDCoMKgwqDCoMKgIHRhcmdldC9yaXNjdjogUHJl
c2VydmUgUE1VIHN0YXRlIGFjcm9zcyBldmVudCBzZWxlY3Rvcg0KPiA+IHdyaXRlcw0KPiA+IMKg
wqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFN1cHBvcnQgbXVsdGlwbGUgY291bnRlcnMgcGVyIFBN
VSBldmVudA0KPiA+IMKgwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFVzZSBWTS1lbGFwc2VkIHNv
dXJjZXMgZm9yIGZpeGVkIFBNVSBldmVudHMNCj4gPiDCoMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2
OiBQcmVzZXJ2ZSBNSU5IIG9uIGRlbGVnYXRlZCBjb25maWcgcmVhZHMNCj4gPiDCoMKgwqDCoMKg
wqAgdGFyZ2V0L3Jpc2N2OiBQcmVzZXJ2ZSBtaW5zdHJldGNmZ2ggb24gUlYzMiBtaW5zdHJldGNm
Zw0KPiA+IHdyaXRlcw0KPiA+IMKgwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IEZpeCBSVjMyIGFj
Y2Vzc2VzIHRvIGRlbGVnYXRlZCBQTVUgcmVnaXN0ZXJzDQo+ID4gwqDCoMKgwqDCoMKgIHRhcmdl
dC9yaXNjdjogUHJlc2VydmUgZml4ZWQgY291bnRlcnMgYWNyb3NzIFBNVSBzdGF0ZQ0KPiA+IGNo
YW5nZXMNCj4gPiDCoMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2OiBSZXF1aXJlIFNzY29mcG1mIGZv
ciBub24tZml4ZWQgZXZlbnQgb3ZlcmZsb3cNCj4gPiDCoMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2
OiBSZWJ1aWxkIGZpeGVkLWV2ZW50IFBNVSBvdmVyZmxvdyBkZWFkbGluZXMNCj4gPiDCoMKgwqDC
oMKgwqAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtaW5zdHJldCBleGNlcHRpb24gYWNjb3VudGluZyB0
byBIUE0NCj4gPiBjb3VudGVycw0KPiA+IMKgwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFByb2Nl
c3MgUE1VIHRpbWVyIGV4cGlyeSBvbiB0aGUgb3duZXIgdkNQVQ0KPiA+IMKgwqDCoMKgwqDCoCB0
YXJnZXQvcmlzY3Y6IE1pZ3JhdGUgZml4ZWQgUE1VIGNvdW50ZXIgc3RhdGUNCj4gPiDCoMKgwqDC
oMKgwqAgdGFyZ2V0L3Jpc2N2OiBDbGVhciB2aXJ0dWFsaXphdGlvbiBtb2RlIG9uIHJlc2V0DQo+
ID4gwqDCoMKgwqDCoMKgIHRhcmdldC9yaXNjdjogUHJlc2VydmUgZml4ZWQgUE1VIHN0YXRlIGFj
cm9zcyByZXNldA0KPiA+IA0KPiA+IMKgIHN5c3RlbS9jcHUtdGltZXJzLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPiA+IMKgIHN5
c3RlbS9jcHVzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQ0KPiA+IMKgIHRhcmdldC9yaXNjdi9jcHUuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArDQo+
ID4gwqAgdGFyZ2V0L3Jpc2N2L2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE0ICstDQo+ID4gwqAgdGFyZ2V0L3Jpc2N2L21hY2hpbmUu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOTIgKysrLQ0K
PiA+IMKgIHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAyICsNCj4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjc4ICsrKy0tLS0tLS0NCj4gPiDC
oCB0YXJnZXQvcmlzY3YvdGNnL3BtdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNzkzDQo+ID4gKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+IMKg
IHRhcmdldC9yaXNjdi90Y2cvcG11LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDI5ICstDQo+ID4gwqAgdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArDQo+ID4gwqAgdGVzdHMvdGNn
L3Jpc2N2MzIvcG11LWZpeGVkLXJ2MzIuU8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOTAgKysrKw0K
PiA+IMKgIHRlc3RzL3RjZy9yaXNjdjMyL3BtdS1taW5zdHJldGNmZy1ydjMyLlPCoMKgwqAgfMKg
IDUyICsrDQo+ID4gwqAgdGVzdHMvdGNnL3Jpc2N2MzIvc21jZGVsZWctbWluaC1ydjMyLlPCoMKg
wqDCoMKgIHzCoCA3OCArKysNCj4gPiDCoCB0ZXN0cy90Y2cvcmlzY3YzMi9zbWNkZWxlZy1ydjMy
LlPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDExNSArKysrDQo+ID4gwqAgdGVzdHMvdGNnL3Jpc2N2
MzIvc3Njb2ZwbWYtZXZlbnQtcnYzMi5TwqDCoMKgwqAgfMKgIDk5ICsrKysNCj4gPiDCoCB0ZXN0
cy90Y2cvcmlzY3YzMi9zeXN0ZW0vbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoCB8wqAgMzUgKysN
Cj4gPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NC9wbXUtY3ljbGUtY29udHJvbHMuU8KgwqDCoMKgwqAg
fCAxMDcgKysrKw0KPiA+IMKgIHRlc3RzL3RjZy9yaXNjdjY0L3BtdS1scGFkLlPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcyICsrKw0KPiA+IMKgIHRlc3RzL3RjZy9yaXNjdjY0
L3BtdS1yZXNldC12cy5TwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwNSArKysrDQo+ID4gwqAg
dGVzdHMvdGNnL3Jpc2N2NjQvc21jZGVsZWctbWluaC5TwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDc4ICsrKw0KPiA+IMKgIHRlc3RzL3RjZy9yaXNjdjY0L3NtY2RlbGVnLXN4bDMyLlPCoMKgwqDC
oMKgwqDCoMKgwqAgfCAyMzMgKysrKysrKysNCj4gPiDCoCB0ZXN0cy90Y2cvcmlzY3Y2NC9zc2Nv
ZnBtZi1jeWNsZS1vdmVyZmxvdy5TIHzCoCA1OCArKw0KPiA+IMKgIHRlc3RzL3RjZy9yaXNjdjY0
L3NzY29mcG1mLWV2ZW50LW92ZXJmbG93LlMgfCAxMDMgKysrKw0KPiA+IMKgIHRlc3RzL3RjZy9y
aXNjdjY0L3NzY29mcG1mLW92ZXJmbG93LlPCoMKgwqDCoMKgwqAgfCAxMzQgKysrKysNCj4gPiDC
oCB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoCB8wqAg
ODggKysrDQo+ID4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1taW5zdHJldC1lY2FsbC5TwqDC
oMKgwqAgfMKgIDI2ICsNCj4gPiDCoCAyNiBmaWxlcyBjaGFuZ2VkLCAyMjUyIGluc2VydGlvbnMo
KyksIDQ2NiBkZWxldGlvbnMoLSkNCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogZjk1ODdkNDA0
NWM2N2NkMGQ4ZDhiZGNkNWQwYmI1YjZiMzk1YjYzYw0KPiA+IGNoYW5nZS1pZDogMjAyNjA4Mjct
cmlzY3YtcG11LWNvcnJlY3RuZXNzLWZhODgwZmQ5YzQ4ZA0KPiA+IHByZXJlcXVpc2l0ZS1tZXNz
YWdlLWlkOg0KPiA+IDwyMDI2MTAwODAzNTE1MC4yMjIzLTEtZnJpdGNobGV5Ym9ocmVyQGdtYWls
LmNvbT4NCj4gPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGZjMDlmZWJiMzdlNmVmZjE1ZWY4NjBh
YTQ5YTVkNGY4NWEwZjJlZTkNCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo=

