Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iUN4DhzE;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=R/q0tifS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMG1-0007Vb-MU; Wed, 11 Nov 2026 23:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMFy-0007V4-Bx; Wed, 11 Nov 2026 23:17:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMFv-0006Wv-Uq; Wed, 11 Nov 2026 23:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794457075; x=1825993075;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vRVFjHeZX7nio3Pjl7Vu3cZmmYZInGF50SBGKb4zKSw=;
 b=iUN4DhzEFH3kthqMUPrYhAy7mMJ9IO2Vn5O9kQK2sYnoUXPG6174tLi6
 lORlDX1LDGEJSfrfGA88OxQ5vM1tJRaJ6k7dmHDyjdxJA/c4P/Cq15tLq
 xR/UqV/2evvGW/9AJ0FINA8YJ8lAPfUha6BsLz0xlUStv08SWZcwSTD3p
 0OpPXYlnI+DEjG81UuDEzPjtByqv+srLSh+3nKkYxwvAJOAGaurywQGAY
 EcjX1er+l2htBYXcwT6hH8h9UsQjTxXVQ/g2Z2BsLjLDz3qeUJXAdXX58
 sVDcEF5Bpojsbp4vFZZV/14kq6Y2s+07E+eH6N5lwKrs8eYCGhPUJjP5z w==;
X-CSE-ConnectionGUID: PWhZsHrtTheW4AjCkGHwfw==
X-CSE-MsgGUID: pEiflpuISDebUIXbZ0QBXQ==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="160629042"
Received: from mail-eastusazon11012046.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:17:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo0GTi6oxZU1pceC/WhzRk7/4+XVEfaP2VzjuYbBqA9X0HpYChxjq1tpnYPkQY8PmJpZG0BiRumRBGzGOj/IUWVKwn27L0MpU/zomRdxjmvwGq/sUesxSdkN95S9NSnx1yR2G5gZMxXwbhnB04IwKDlAdY2us9asYQhu1sW9uXS1JywR5Or+5xnYX8utVHPUNQM1lF1YlwhcuKt1UmGKP4v+QK0dy5oNP50WCQF72JZY2GJ+Xl0tiJ7ZT5MiXdPLe5NYo9AGiudYHbz4IwnvH1sUef6dQ7dpVebSaPECDbx88NgqtPE6AVOrYHFcOqro6kQU39CUuScegd8bQst/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRVFjHeZX7nio3Pjl7Vu3cZmmYZInGF50SBGKb4zKSw=;
 b=pmCgl2a5Wf8mSes8Fq3iKD6HTT0jOaOKxCEtfGUR0qCRpTBNZhncuO22vyVYh8hgAD2cKeYz261nBZVT1NEDmQelRFnnuxixbQdFZS8SF8cb3VvTlGIk1xO8/5oSLwMEeoDVgAQD36/B0eQzk8fWUlykE9D5M1jjOia6yRu0uXH9tyUqqut0eWT9MLV6EdBTOZh2iHvrCB9qM+OQ2BTllB6LSBkOWCU3ndKAdqV206fXffdE6liFv0mw8HGcs/F8VmQzV4+LN9RDypk28jNnbWKMnyl9AyV6G7C6rtPuAUiVMm2jw50TAurh7Q8Zxn3Um6wUTZIDaUxd1VmWZcFboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRVFjHeZX7nio3Pjl7Vu3cZmmYZInGF50SBGKb4zKSw=;
 b=R/q0tifSLllpTC0HHhoyRl4nwSavnOCfZCpWEk5rZjWb53jB7b0XwCXJfVg7zo+gxYl25Q+04Vn+adA01Pe1mJHDNDSehxDcOKvDncL8UD8OuCdPcALrhaIdI2cbSHeboaNGxI0maOCExyHGdyreVg+wrNI/EUwCOFz7chVb2Yk=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by MW4PR04MB7443.namprd04.prod.outlook.com (2603:10b6:303:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:17:42 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:17:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "nutty.liu@hotmail.com" <nutty.liu@hotmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Topic: [PATCH v3] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Index: AQHdZuTuoj0qvF/4f0G5cPZgKD9cxLcp67kA
Date: Thu, 12 Nov 2026 04:17:41 +0000
Message-ID: <e109006358a218c990d533509f79d08d1d73f213.camel@wdc.com>
References: <20261028140122.1560-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261028140122.1560-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|MW4PR04MB7443:EE_
x-ms-office365-filtering-correlation-id: c5497c8c-4cf0-4c43-d5d3-08df4073e4e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|10070799003|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261026140227099003|261102123227099003|56012099006|10067099003|11063799006|38070700021;
x-microsoft-antispam-message-info: jclYgqJDKl4yVo8U54JPFyUr+LZoXxw3V88/OuYFsW/N/N9CmaHB1vB14IQyddsHxRKMcm7PUL5fXJNNxbA5kinz3NaQ/Mx5azuIM/qy3P0DI4Rukkus0lTSq598g9J5mASTwa/OAOJZxginiSVYjPtPmUv0xBYRlf3igtaO+EVUhKLkySwrUrT2xSHXDLkYpKlRVkSpW86mitnOnezVphmZ5g1SUf0jAaiRb4pbTe3xKY8yKTkeGTge3nH0j42IM4VIUcIg+9u4CFXkddYzaAVqmQSFDHGcjlZhBiLMK6cHMxkePmxjwd7EdlWANv0b54x9OgxUmNeZdZ4bZJqQtgWAWZuhe++8HYVJ1UWWfHuMZQiFI8pvS3yxytlZZZzDqd8hU6ZwhFaBoL0EcbwBOZbp79seGs5nJFSWZoxm6o9kJ9pjzhYR3gfpYiWPeJOjOk8aB32bnHHmVxAUg1Dsu+/hnvMPoxBRCW00C1o1ToVEK+6O4tJVPJ9qFc7ccLu3n1Yi47V+iD/pnXpwokWB2x501WMNhO7ZUaBiQREdIRO2Pkacz6amMvSG296V9+U0e1ew/BgIBTbh13Myo8Ang4uhhu6wdT46v9iYQAsnKeffqt8EUY3x7yOb6J7uCHq2ogZe56Q+fkurWpxVVDX9iJdAxCNh2YHZv1NP8QPkukX3+9iVyNSnrU1pCXJL+cjgLUnUWHWE/Oxbu52xEfK4DNrDvpbcE+9KzUV/LG4/IPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(56012099006)(10067099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNQbU1PSUtvT1p2ckNQUkxGSU1BSlEyTGtjK3hzL1BTVzdaMngxdHlxOVNY?=
 =?utf-8?B?ZllqMkp4a0l0bWVxTXhPNGhRR2E5eGthNG9vMXhsMS8yK01xZkYxblJXcjhZ?=
 =?utf-8?B?R2hxdDc0bnpiQnEySUQ3Z2EydzZmbDlkdWh2OE9mY085NW1CZ1A0cURwdUJ4?=
 =?utf-8?B?TTZTWDFvNUFOWDNvVWFtZko4VEJZK254Y2xsTnRKK0pEWXpjeVg4V1RTUjlJ?=
 =?utf-8?B?Mm9VREJlVVNjUXJVMW9JT3puM0p1R2ZYNFNzdHp2WXZldENCcmJEN3Q1OXJu?=
 =?utf-8?B?VHE0TnczN283a1dpNmYyL2ZiSGtNRjBtR2hUNkVZUnNZNnJMUmtqL1RBMUZl?=
 =?utf-8?B?eTJaTzBYa3IySFJyRUJMNWROZVBnUGxmS292aVYzZkZWcHZkYmJVUmtSOFBC?=
 =?utf-8?B?SnFGdDhsV3hjVkRVMVk1UzVRY0pXSXFXOEJSM0VqVTVSWWpDQmpEcVdLTU1O?=
 =?utf-8?B?WWJpMzh6TjZhRklPTWpoMTZuR0lzWXN6dVVFaGxDUWFpUkE3V3VwZU1CaVBa?=
 =?utf-8?B?bTFmOFNkUnhJZmJLSWt2SkJvSEVqZFhaZnY4cEtMMkowck9TdEtjV1NOVkxv?=
 =?utf-8?B?Mlp2MUx4aFdxeS9wMVVHTVloRnJ3OHJsQUVEUU85VEFBMHh0U3l4LzNWanlh?=
 =?utf-8?B?RTdpU3J2cCtZaHByNkFOdnpiRXdNZ0cxMU1PM3ZZK2JUcDArYlNaM3k2cDlJ?=
 =?utf-8?B?WDNSNzVXcWRvZm5UWkVyZnl1SDBQY0VrN3dKSFFLd0p4N3k0S3o1UUQ0OXBJ?=
 =?utf-8?B?bTZ2Y1Nya1FTMVMyZjhPTjJodjBENUMrbWNBdE8rQVJTaFNsUTNHeTZKaVg5?=
 =?utf-8?B?c3p6bW0wdVhKc0RVSVNXSWdYQ2tJbGQrTVA4ZXROUWVmT3ROZTNJWTlXN0tX?=
 =?utf-8?B?YURxdDVndzVDMVkyM1Z3dWswVnhsMS8waURMN2hzLzROMEMyNXRUcks5cjNV?=
 =?utf-8?B?OVMrd0krd1RKL3A5Rk9ZS1dEZnlCQVFSc2pvcHY2UUlXbmZBZkJmSjUyODBn?=
 =?utf-8?B?UkFra29zeC9oUmYxSFFjbGU2d1UzZEFRT0EvbExnYkpDUmptQ084aU0waVdT?=
 =?utf-8?B?Y3ZNcEJQNVJjUXZuNHZxOXV1SGVFa3NDTzVTMFNOR2NJbGFNek9YaDM2c3Nr?=
 =?utf-8?B?UDc0THhaOXRSM1J2QlBUK1dvY2xGbXNrWC82YXU5TUpLM0o2Y2lyRWhCVkVX?=
 =?utf-8?B?eTZPakFobWpYS1BpUTRSNnNBRmlVcFNSYzJ0aWNWOE5SYmUzRk13a0ZUMlVQ?=
 =?utf-8?B?TDl1N1ZTelF1WTNTdDJ4aU8wSEtoUUpjczhJSkZoNy9ybjdQNDhNRW1ucWo4?=
 =?utf-8?B?bCsyeFY2d05sVlFjOENSNXpkNVgwZVhya1c3QWw2RUY3YTVPWkdYZjAxNmZo?=
 =?utf-8?B?VUdqZGNqSWpCWUorSk1hc2VVWkhXQUJEcXRpNlhjSFZnV004cW1QWUI1MVdI?=
 =?utf-8?B?VzBLUkFrSnZHNWc0RmZxUldybTRRdk9IdlpDQkdZN1lIMWJIZFhxZW1SYXYx?=
 =?utf-8?B?YmFMVm9xNnhxdWIzdnVrKzZPb09qcURGeUZHWXMxQjFuRnlnU2Z5VnFKWWtG?=
 =?utf-8?B?MjNCNDgyZmMxZ1d3cFV2NDhoR2VoTG12SkdiSjZxT3BpcVpKTFdIQU01S2hZ?=
 =?utf-8?B?aG1ldXJERnFpbm54QVYvd3ZZNTVFcjdkNjh5bHdFblQzQWczdVBtVlF3V2JF?=
 =?utf-8?B?Zm5EU0wxa1BHTHMzTzJuV3VSRTI1a1RJRTV3aU1vVExSZjFJeWRmaExsK0p1?=
 =?utf-8?B?Q0IxcVd3TmRFTlk3QzBoUTdtTmdxZTdnQlh2eWRGM1MzUjNMWTYyNFd2ZHd6?=
 =?utf-8?B?RFVOei9BWDFKL1VnTHpkdnNwUFJ6Vm40TUNBZmhtWkU3RTVVNStDU3FhKzVy?=
 =?utf-8?B?TUJVd1VRdlNPM1Flb1diR2FGR05HMnA2cU1XQWF1eDlHRnlrNmIxZW51aUQ4?=
 =?utf-8?B?TkRqZ3JHQ2lrVlZLYVY0N1NobGgvWXpJVWRtWjVuaXYxOTkzcHFKRTQ3NGYr?=
 =?utf-8?B?V2lmSm5VSXI5c283ZkpZeC9CWmQvYkthdnR4elg2OUlOa2hPRUcvbHBOWERs?=
 =?utf-8?B?ZFBMekhjbGR6ZVl4YXdDbkwzRmZsOUpra1dKNi96KzR0ZEZ3emVIU2oraThU?=
 =?utf-8?B?V1ZNUlFVdEVxWTR3ckRNQUhqRGRQNnZodkQ3NkQ4ZTR1SXZMQklhZnNuRUpD?=
 =?utf-8?B?SStjMXEzVG5DYUg4SDF0eEQ2S1QvdUpsMWhmdml6eStTaDEreXd1VlFndkF0?=
 =?utf-8?B?a1RKSzFkOUdKcWpmdG9tUEVOV0tLZ3ppMERXdnhxVm42MHhTNlIwcVJlTTBV?=
 =?utf-8?B?WjZsK0sySUk4aXdUUEhDNzdJMUZ3d09NQ1hEQnU4d2JzRi9wT2ozVzNYTmNr?=
 =?utf-8?Q?JGyJV/HyPdBKi/pYGrpIYWn/Gt6yUx/XPWpumwVF0KO31?=
x-ms-exchange-antispam-messagedata-1: 5sPTmUsvuPEpqIRbQjMboYgpnEyuv7qKfmY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66790549E3C9E4479467F4BE99E1AB89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J0g9OLkSe29R1XIX6XDOic9joZ4noeIeWP++e/h5lPoD1vaAVI3c/vQkYpyJ0ZXQgf0uewHDis5IDKmM+2rzVeUFzLwdkj78aojzZV6lnkJvut3x9m+BSN0g8qEePDiBF077jxBqumL5oM5L8Rq5iUNnRbxpHttlD95j2Y4b1ObxSuNpm7HO38VPjl8WzAhLfiiXFJjckiIFkA7GNXWXslOmbXgEDMYSxKCT/WzCGQBMp0mPGESLvSZSKQA0RgHPzd8Rm43T+hAhsqiwxpzkbFyUXRGgl/qGhXgzY34gi9IBEvqPVq8PvReZMiiMCXIu8MfeBRhjCzJ3JC/paOgCpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fpNgMbAI8akdsQvdRoKfnfG1usjGWokBpscT7hSmwzhYO3MHq1c+liw96yNlQfpQOpYJs6GVoqZxprOPXbOOXKHEem/AsC2NnfkByY31X190DK+GR3qK769g6tB0bPvda1biEIm653+70tmgsW6S9F+5kkMJpXO0uwYKWQQYSWn7vxNj8JIz1f4uOb3/bVw4pCpjYVJO1n5iMsvjib7S2upIHDl+7FvqptivapkC+lm9CvYt5yg3cV38LM5ZZjY2EDoKaESTISHa9U7tRYtitEaI8pudtG5ccjJ2X7S5wF7qhIavKRBJrIGRdGDJPuHvK/U6ZbG8tWH66TVUSubXGxt9YB9kN7xL3ZCCxliQn/IBoz+eIShZlKwsCetqrs5OtvMTJefJNDOHMxpvb6nBuML+q9snY7y0aq2xLE6wji503Khb76S72AVJznCbkI6TO5Qn3q9yESUFfzx+7lHcHXw3ucrgrc0qdgGbQP+bH/24FHmekTp17GVvm4y4efWpa9BkoMlKUf8/8sUHtDGxf9jhn5Vbf2mtyqlrYCtngSQIj6oziCRKrB4lQklN7fFDzj1KQOe2geM67GC4ajxMVFgx20ph66zbNum2Emitp6JlFFh2Hhl0nPA3oAFX49A6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5497c8c-4cf0-4c43-d5d3-08df4073e4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:17:41.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+vSIwETd+WBfxUYItfmQdu4h8TgGtPFapr3DToVZtNfNygeE0KNLUoZw7oFBDePo0aWcMPZxVt++L3n3eSqdFsxAJlqnR9Xx9DYUFaxMdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7443
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDIyOjAxICswODAwLCBUYW4gQ2hpIHdyb3RlOgo+IEtWTSBp
cnFmZCBieXBhc3NlcyB0aGUgUENJIGRldmljZSdzIElPTU1VIEFkZHJlc3NTcGFjZSwgc28gTVNJ
Cj4gYWRkcmVzc2VzIHJlcXVpcmluZyB0cmFuc2xhdGlvbiBtYXkgZmFpbCB0byByZWFjaCB0aGUg
Z3Vlc3QgSU1TSUMuCj4gCj4gVHJhbnNsYXRlIE1TSSBhZGRyZXNzZXMgdGhyb3VnaCB0aGUgZGV2
aWNlJ3MgSU9NTVUgQWRkcmVzc1NwYWNlIHdoZW4KPiBzZXR0aW5nIHVwIEtWTSByb3V0ZXMuIE9u
bHkgZGlyZWN0IG1hcHBpbmdzIHRvIGFuIElNU0lDIE1lbW9yeVJlZ2lvbgo+IGFyZSBpbnN0YWxs
ZWQgaW4gS1ZNIHJvdXRlcy4KPiAKPiBPdGhlciBJT01NVSBNU0kgcmVtYXBwaW5nIGZvcm1zIGFy
ZSBub3QgY29udmVydGVkIHRvIEtWTSByb3V0ZXMgYW5kCj4gY29udGludWUgdG8gdXNlIHRoZSBl
eGlzdGluZyB1c2Vyc3BhY2UgTVNJIGRlbGl2ZXJ5IHBhdGguCj4gCj4gU2VsZWN0IFBDSSBmb3Ig
UklTQ1Y2NCBLVk0gYnVpbGRzLCBhcyBRRU1VIGN1cnJlbnRseSBlbmFibGVzIHRoZQo+IFJJU0Mt
ViBLVk0gdGFyZ2V0IG9ubHkgZm9yIHJpc2N2NjQtc29mdG1tdSBidWlsZHMgYW5kIHRoZSBNU0kg
cm91dGUKPiBmaXh1cCByZXF1aXJlcyBQQ0kgc3VwcG9ydC4gQWxzbyB0cmFjZSB0cmFuc2xhdGlv
biBmYWlsdXJlcyB0byBoZWxwCj4gZGlhZ25vc2Ugcm91dGUgc2V0dXAgZmFpbHVyZXMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogVGFuIENoaSA8dGFuY2hpMjVAbWFpbHMudWNhcy5hYy5jbj4KPiBSZXZp
ZXdlZC1ieTogTnV0dHkgTGl1IDxudXR0eS5saXVAaG90bWFpbC5jb20+CgpBY2tlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0t
Cj4gCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIFJlbW92ZSB0aGUgdW51c2VkIGxlbmd0aCB2YXJpYWJs
ZSBhbmQgcGFzcyBOVUxMIHRvCj4gwqAgYWRkcmVzc19zcGFjZV90cmFuc2xhdGUoKSwgZm9sbG93
aW5nIE51dHR5IExpdSdzIHJldmlldy4KPiAKPiBDaGFuZ2VzIGluIHYyIChiYXNlZCBvbiBBbGlz
dGFpciBGcmFuY2lzJ3MgcmV2aWV3KToKPiAtIFNlbGVjdCBQQ0kgZm9yIFJJU0NWNjQgS1ZNIGJ1
aWxkcy4KPiAtIEFkZCB0cmFjZSBldmVudHMgZm9yIE1TSSB0cmFuc2xhdGlvbiBmYWlsdXJlcy4K
PiAKPiDCoHRhcmdldC9yaXNjdi9LY29uZmlnwqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqB0YXJn
ZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDU0Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKPiDCoHRhcmdldC9yaXNjdi90cmFjZS1ldmVudHPCoCB8wqAgNCArKysKPiDC
oDMgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvS2NvbmZpZyBiL3RhcmdldC9yaXNjdi9LY29uZmlnCj4gaW5kZXggMTFiYzA5YjQx
NC4uMGNmMmM4ZTFjNCAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvS2NvbmZpZwo+ICsrKyBi
L3RhcmdldC9yaXNjdi9LY29uZmlnCj4gQEAgLTcsMyArNyw1IEBAIGNvbmZpZyBSSVNDVjY0Cj4g
wqDCoMKgwqAgYm9vbAo+IMKgwqDCoMKgIHNlbGVjdCBBUk1fQ09NUEFUSUJMRV9TRU1JSE9TVElO
RyBpZiBUQ0cKPiDCoMKgwqDCoCBzZWxlY3QgREVWSUNFX1RSRUUgIyBuZWVkZWQgYnkgYm9vdC5j
Cj4gK8KgwqDCoCAjIGt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0ZSgpIG5lZWRzIHRvIGFjY2VzcyBQ
Q0lEZXZpY2UKPiArwqDCoMKgIHNlbGVjdCBQQ0kgaWYgS1ZNCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi9rdm0va3ZtLWNwdS5jIGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMKPiBpbmRl
eCA0NWFkNWUxNTI1Li5hMWVlY2Q3MmI3IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMKPiBAQCAtMTUwNyw2
ICsxNTA3LDYwIEBAIGludCBrdm1fYXJjaF9yZWxlYXNlX3ZpcnFfcG9zdChpbnQgdmlycSkKPiDC
oGludCBrdm1fYXJjaF9maXh1cF9tc2lfcm91dGUoc3RydWN0IGt2bV9pcnFfcm91dGluZ19lbnRy
eSAqcm91dGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50NjRfdCBhZGRyZXNzLCB1aW50MzJfdCBkYXRhLAo+IFBDSURldmlj
ZSAqZGV2KQo+IMKgewo+ICvCoMKgwqAgQWRkcmVzc1NwYWNlICphczsKPiArwqDCoMKgIGh3YWRk
ciB4bGF0LCB0cmFuc2xhdGVkOwo+ICvCoMKgwqAgTWVtb3J5UmVnaW9uU2VjdGlvbiBzZWN0aW9u
Owo+ICvCoMKgwqAgTWVtb3J5UmVnaW9uICptcjsKPiArwqDCoMKgIE9iamVjdCAqb3duZXI7Cj4g
Kwo+ICvCoMKgwqAgaWYgKCFkZXYpIHsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gK8Kg
wqDCoCB9Cj4gKwo+ICvCoMKgwqAgYXMgPSBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2Uo
ZGV2KTsKPiArwqDCoMKgIGlmIChhcyA9PSAmYWRkcmVzc19zcGFjZV9tZW1vcnkpIHsKPiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKgwqAgUkNVX1JFQURf
TE9DS19HVUFSRCgpOwo+ICsKPiArwqDCoMKgIG1yID0gYWRkcmVzc19zcGFjZV90cmFuc2xhdGUo
YXMsIGFkZHJlc3MsICZ4bGF0LCBOVUxMLCB0cnVlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1FTVRYQVRUUlNfVU5T
UEVDSUZJRUQpOwo+ICsKPiArwqDCoMKgIGlmICghbXIpIHsKPiArwqDCoMKgwqDCoMKgwqAgdHJh
Y2Vfa3ZtX3Jpc2N2X2ZpeHVwX21zaV9yb3V0ZV9mYWlsZWQoYWRkcmVzcywKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImFkZHJlc3MgdHJhbnNsYXRpb24KPiBmYWlsZWQi
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAibm9uZSIpOwo+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMTsKPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCAvKgo+ICvCoMKg
wqDCoCAqIE9ubHkgZGlyZWN0IElNU0lDIHdyaXRlcyBjYW4gYmUgcmVwcmVzZW50ZWQgYnkgYSBL
Vk0gTVNJCj4gcm91dGUuCj4gK8KgwqDCoMKgICogTVNJIHBhZ2UtdGFibGUgdHJhbnNsYXRpb25z
IGluc3RlYWQgdGFyZ2V0IHRoZSBSSVNDLVYgSU9NTVUKPiB0cmFwCj4gK8KgwqDCoMKgICogcmVn
aW9uLCB3aGljaCByZXF1aXJlcyBmdXJ0aGVyIEJBU0lDL01SSUYgcHJvY2Vzc2luZy4KPiArwqDC
oMKgwqAgKi8KPiArwqDCoMKgIG93bmVyID0gbWVtb3J5X3JlZ2lvbl9vd25lcihtcik7Cj4gK8Kg
wqDCoCBpZiAoIW93bmVyIHx8ICFvYmplY3RfZHluYW1pY19jYXN0KG93bmVyLCBUWVBFX1JJU0NW
X0lNU0lDKSkgewo+ICvCoMKgwqDCoMKgwqDCoCB0cmFjZV9rdm1fcmlzY3ZfZml4dXBfbXNpX3Jv
dXRlX2ZhaWxlZChhZGRyZXNzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAibm9uLUlNU0lDIHRhcmdldCIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgCj4gbWVtb3J5X3JlZ2lvbl9uYW1lKG1yKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAx
Owo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIHNlY3Rpb24gPSBtZW1vcnlfcmVnaW9uX2ZpbmQo
bXIsIHhsYXQsIDEpOwo+ICvCoMKgwqAgaWYgKCFzZWN0aW9uLm1yKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgIHRyYWNlX2t2bV9yaXNjdl9maXh1cF9tc2lfcm91dGVfZmFpbGVkKGFkZHJlc3MsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtZW1vcnkgcmVnaW9uIGxvb2t1cAo+
IGZhaWxlZCIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gbWVtb3J5
X3JlZ2lvbl9uYW1lKG1yKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+ICvCoMKgwqAg
fQo+ICsKPiArwqDCoMKgIHRyYW5zbGF0ZWQgPSBzZWN0aW9uLm9mZnNldF93aXRoaW5fYWRkcmVz
c19zcGFjZTsKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fdW5yZWYoc2VjdGlvbi5tcik7Cj4gKwo+
ICvCoMKgwqAgcm91dGUtPnUubXNpLmFkZHJlc3NfbG8gPSB0cmFuc2xhdGVkOwo+ICvCoMKgwqAg
cm91dGUtPnUubXNpLmFkZHJlc3NfaGkgPSB0cmFuc2xhdGVkID4+IDMyOwo+ICvCoMKgwqAgdHJh
Y2Vfa3ZtX3Jpc2N2X2ZpeHVwX21zaV9yb3V0ZV90cmFuc2xhdGVkKGFkZHJlc3MsIHRyYW5zbGF0
ZWQpOwo+IMKgwqDCoMKgIHJldHVybiAwOwo+IMKgfQo+IMKgCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90cmFjZS1ldmVudHMgYi90YXJnZXQvcmlzY3YvdHJhY2UtZXZlbnRzCj4gaW5kZXgg
OTM4MzdmODJhMS4uNTA5ODBjMDMxZCAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdHJhY2Ut
ZXZlbnRzCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RyYWNlLWV2ZW50cwo+IEBAIC0xMiwzICsxMiw3
IEBAIG1zZWNjZmdfY3NyX3dyaXRlKHVpbnQ2NF90IG1oYXJ0aWQsIHVpbnQ2NF90IHZhbCkKPiAi
aGFydCAlIiBQUkl1NjQgIjogd3JpdGUgbXNlY2MKPiDCoAo+IMKgIyBvcF9oZWxwZXIuYwo+IMKg
cmlzY3ZfZXhjZXB0aW9uKHVpbnQzMl90IGV4Y2VwdGlvbiwgY29uc3QgY2hhciAqZGVzYywgdWlu
dDY0X3QgZXBjKQo+ICIldSAoJXMpIG9uIGVwYyAweCUiUFJJeDY0IiIKPiArCj4gKyMga3ZtLWNw
dS5jCj4gK2t2bV9yaXNjdl9maXh1cF9tc2lfcm91dGVfdHJhbnNsYXRlZCh1aW50NjRfdCBpb3Zh
LCB1aW50NjRfdCBncGEpCj4gIk1TSSBpb3ZhID0gMHglIlBSSXg2NCIgaXMgdHJhbnNsYXRlZCBp
bnRvIDB4JSJQUkl4NjQKPiAra3ZtX3Jpc2N2X2ZpeHVwX21zaV9yb3V0ZV9mYWlsZWQodWludDY0
X3QgaW92YSwgY29uc3QgY2hhciAqcmVhc29uLAo+IGNvbnN0IGNoYXIgKnJlZ2lvbikgIk1TSSBp
b3ZhID0gMHglIlBSSXg2NCIgZmFpbGVkOiAlcyAocmVnaW9uPSVzKSIK

