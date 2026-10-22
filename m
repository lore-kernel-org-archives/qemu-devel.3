Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DC606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CdyO7dX2;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=JEzwGwS0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjew-0005bA-Tq; Wed, 21 Oct 2026 23:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjeu-0005aQ-Cq; Wed, 21 Oct 2026 23:40:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjes-0001G0-Df; Wed, 21 Oct 2026 23:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792640407; x=1824176407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EH6jc+Lk4GQI4/xfO5wIxllNaOuoKj2kDW9Hnz4lMV0=;
 b=CdyO7dX2XtD/A/VZwlei1eVIvWheQo7S9bHY8ux2nKIr+D5wFv9YyMdm
 KQEZwgH8B9+Uoi+7mvjXqx12YYENPFYOJm5DfuQlG3pbCiGsZCpPjS6so
 GoJ90X281Z07UCPezhfE482FGCI2H+lT8qm4T3CLjKsugrVJ/mtLuN3Nh
 IFQT6LtmcbqTKQopIggiAg2IElvZ1wbM8sVU6cnjlSou+ph/O1DaTFgM8
 rBKMIk15avZVtWebOAimP6gviMDYZI7S+naDWbJdppCALXsO7vMUK5HAf
 +AzooNkK97wFw7cNpNAHbkJG+QlxXX8qVOkjrpDq1Vz95scTLe2BNop9u A==;
X-CSE-ConnectionGUID: wYAd6UbDTqikUOCCiPfh2A==
X-CSE-MsgGUID: rgkvd4x6RVy7dbwlTpS85g==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="154477618"
Received: from mail-westus3azon11012008.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.8])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 11:40:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wutv9z9+/cOU5tjWjD0S546jli6d/fnWuWXqelRmQRLzgWl7HcyCXPx9blX/XtrPMMDRw0tRFKRzqU6I2U4AlYzrXTDXuwKTDmea3j6/d0be4Azt4Cv82NDc5/HBVpwwM5cTsp/W95zTdOBKzVVJZo4/TQ1KKcup0MqtO9KIZOhjiaydftfqazfK6U29FjGSzsZs3dwJYynkD3ytYxSSHbF+W1vBRb8a5Gw42AS4sav7y9a6bpRNzaKLjTr3D4obbompmQqqguyMJhEg1GTTOWjGvs4bQsGj1zMdatidd4smj7YIuRxteVS3A+jtbnk1Xmmuv2jwHeT3E1Qg9s287w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH6jc+Lk4GQI4/xfO5wIxllNaOuoKj2kDW9Hnz4lMV0=;
 b=iXnTtpL+1OtnlLlCHyiXwtZnEHckXlI2ez1jNgnxZPw3eIS5MMCXAzbtG5uIWUGiyHcC3tm7KF7MDz6O3KpIeN852tR/P+nUfAEZda4WWQIhjh7vLfMsy1bPTlWC3ylgQ73kRIzKF+vNZpiq2sfkS6rTyTXwHTr9Os6EW3/Z6rDHLvkvkFRveROHFDa0xcvqmZcjfwZCkgEtSQIC4uTiN3nJ2QNRV1lwgTzeFhpITf/LxrwmZ4vcrUk+GkbpDtbXY0vbk3oeaGPtocDPEoMMwwzojSuWB0/4j0b2DopveE/LlVv3AoEOv1Q5UoyTvPeBfSPGkfi7HSzFQbopWh+RTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH6jc+Lk4GQI4/xfO5wIxllNaOuoKj2kDW9Hnz4lMV0=;
 b=JEzwGwS0Ft4zg9WK0IDjM3krSRAF2FyZUA+tO2lF+2wB9KAIfC5d51nko+qJJhSZgFJe9gQ38KIvWhKaj6O/OSmomY0D565TTOr/S7qCumgHO66Vd6Mk0V9PWhQE3qugYf0aspG1a65rUYqiUcwzreIttlIXjPx65m1iy4HVzcA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB8103.namprd04.prod.outlook.com (2603:10b6:8:2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 03:39:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:39:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sebasjosue84@gmail.com" <sebasjosue84@gmail.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/pmp: unlock all PMP entries on reset
Thread-Topic: [PATCH] target/riscv/pmp: unlock all PMP entries on reset
Thread-Index: AQHdRY2Z6Ww1vv9fckaWTX+BJn2URLbQ/DSAgDgmsQA=
Date: Thu, 22 Oct 2026 03:39:55 +0000
Message-ID: <ba06d1597bb8e7f3c68e77d4b8c999fec3b410d3.camel@wdc.com>
References: <20260916034331.2390427-1-sebasjosue84@gmail.com>
 <0ebf4cdd-d5be-41f0-adaf-d540f3dd0793@linaro.org>
In-Reply-To: <0ebf4cdd-d5be-41f0-adaf-d540f3dd0793@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB8103:EE_
x-ms-office365-filtering-correlation-id: 91f9b445-d8ed-4ed5-ee7d-08df2fee2390
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|19092799006|366016|261021123027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: hYV2eF7Ta37qlp2S3NysQVohvhg6bMuICkC10b0cWzsI2onITKxtn40bjdIZ0O4qieOfTQsFkcIvLQl0TkvqbWVrWZhw57DON1E34JRKJ+30H+S/0qVIy/CKse7ywkA2dBKY4GcNCZMpo0GtUUxAW/L/8JLk6AT2zIWpraoLjdch5YjxfV/i+BstQ4RldDfc9UtX/Wcfo7gclmufDWQvysJu4fVWiNnnZYYqfcwWdTPygfBH13x4mmB7bucbMZ8P9boSCbqCJEAqaaJwDB32527XLMhXEGU80T8UtXz8wVo5LZDQZvHVGd9kkQhmKkiSsaky9tQsPpfihCgv2V2UW/65tKS6IO4okZLVHPaJu6Z8z7VkaatJsMY8UAfV/98G5jEumGcYY+N5er7aJoq36uWXsOQUMII+fSf4Q2dxlscS+6khJX/p7s1pMbtuMB7sTKoDiUbE5SjDM1JlkX82K8Il/IFW271jYSJA6yQrZSlcYGYgiZxQypWtC73H4G6tkW/xYWj6hNCJehpZyOkR5KEpWWNQFIXZgFiRxs5vmxBK2cymkzBVe+tEvjYPrvgF0O7VJQ2fn0xwQbClk87UrZsBg/EXoQeHqlHsokaXAICKk5JZ1GFjtP8jAEiLdrbFKeJw3Z5f6dtZraNP1mzOGdmJ3AvZAtTANSev9mrINb9GEhr7Q9ZxElx0k4u945o2z5p4rB5ud4aGk+4fICA0kzJ4xpHfXLg5rwsdvKGIli8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(19092799006)(366016)(261021123027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlYyb21kbk5CaTNzNm12djlwWXU4RHcvYXFjMmhPeFRJWXFmNUZuYnNiL283?=
 =?utf-8?B?aTFmbXNWa2U5d21LVXhvc2xlRFVCUXQwRzRITE51L3lEL0hNbjFIeC80eDU1?=
 =?utf-8?B?ZEFlVzN1N09SeXFNNGl0N3FJbU5RajhFZGhDb1poSnJ5OVRvMjZQTUlrNVh2?=
 =?utf-8?B?YjNhNXVnZ29vT1hXRXEwaFJmdTUzeEJ2TWFkWmYwcDRlZUxITWlHbVppWFVp?=
 =?utf-8?B?eWxDUjZrWUN4VXgvRHRjUDlkdmQ1cUdJWDBYeFZaMjdHNHB1c2ZRRGtNMldv?=
 =?utf-8?B?OXZnZ0VscnVaR0xVOHUzVys2UlNvRGhtSFBLNGlHRFg3NDVGUnpkbDIwalRG?=
 =?utf-8?B?UUlhbktVcThFNmRGSFlyR0tvOFliNWNkTG1CSXhOZGovSDFrNUJORld1SXJq?=
 =?utf-8?B?OWIwNE52YWl1SUJULzJWK3RPcHhVS3VaNlNpMzRncHVxVHpNL0JrZzRFaThw?=
 =?utf-8?B?a0JhZXNmSFhZanFhSmxxZGNLeG00NndGeXhiMW92WVo5ZUtJQjJybDVhVmNM?=
 =?utf-8?B?dWRMOTlyb1ozbE5kSWhXVnVGbW9Eckw1a256b0FFOWdLRk9VbHU3MVZZY2E5?=
 =?utf-8?B?SThaRHNyUHIxYW0wMi9IQ0cyRWQ0UEhncVBRb3VRWTZjY1RHQ2FIVzVIOFFF?=
 =?utf-8?B?UTZvRFpZY3R1dFRaWUQxYWF5MTFyeExESCtEODU4RlRUWHhkeldqbkxPcDQx?=
 =?utf-8?B?Zno5UkFROTI4QTd2NGFBVDZpZVNsMHdKUGN4Y0lPYmovUjNSam5vUWt5N2ds?=
 =?utf-8?B?RjhMYUV4d3BMSGQrbWYwNjIrbnUvc3Z3Y05KWmR3ODhNY2hwUzhpbkFEbkdl?=
 =?utf-8?B?dFRqV3Y1YlBqRmd4RkVzdUU5NVVwZTZTYWNRZll4Tm5PbnJGSGM5eEozSmhr?=
 =?utf-8?B?UWVCTTlPaUIrUHk4TitSRzJyTmtpMWY5dGQ4d25zSVUrNzdCS2FBYlQwSmdj?=
 =?utf-8?B?eHk5U3FaQ0hpWmRhNEJYSk1FcEhybTdwZERDL3kwUXc0Y2pVVGY2S2VQMC9D?=
 =?utf-8?B?OCtKTWRRdEFmY2xFY3hrb0FlM3FCaGVUQ0Q1QUcyRDMvb1hZU0tVeFpWc3By?=
 =?utf-8?B?c2Y5R0ZXaDQyWW5CMStlSXV3Um5FeVh1U0xZRTA3bzlPbWQrQW1jM1RwR2x1?=
 =?utf-8?B?SWlNRVY0c1NxcWNUMXF1YXdzM3JhWC9ETVdpcTcyVjExWTJmWEhvamd2TUls?=
 =?utf-8?B?N2NFd2JDbmRnV0o3a1dXa0N5T0ZxVkowNkxwTTVqOGFWSjdUNy9mMXh5VjY3?=
 =?utf-8?B?UHJIRlFiTktVWVlJTHZGd2JRbGJ6cmovREd0bmphOG1WMlIyMUNZaEMzK0k4?=
 =?utf-8?B?RlJ5NENvUVdxd216TUlIaS9Gd3VaejV2NXBpWS9kYWlyOUllVjRTRFliNVNv?=
 =?utf-8?B?Y3FrQkpZcWJEbng1RHlQSXYzN3J4UURxUUhLMFZibWE1Z2dDb3hXSGZ1TGF3?=
 =?utf-8?B?ckVzSTREUDdzQTgyWjFLWDdXbysvc3BYekxMLzZPSVNsU3RrYnpjUWZjYTRC?=
 =?utf-8?B?b0w2MnFXbmRaVlM3bXRra2hXSnE2YkhSOVpFUEcrUnZsSCtGVGNkQWZHMzNz?=
 =?utf-8?B?ZStwVzB2ZCtTZCtNdEpDOGgxd0Fkck9idGdLVDM5WHIyK0VSV1NjdDZNeVp5?=
 =?utf-8?B?UWdabjhaL2xVMVVrdUJwYlIzcDhHb2Vmb3ZkWGIvQVRnbXZUN2piNGZ0dit2?=
 =?utf-8?B?NUZxVmllYzhabEF3ZkZ0L1NqcEV2OFljZm1tbEEyZ3FnaFR5L2RxWTZVd3pK?=
 =?utf-8?B?dDFvaXphQ1lQRktWRmc3cUNXc3JzQ1BpcUpmNE1BWFVQbk9Jb09sdm9tL2o3?=
 =?utf-8?B?WWYzUjVMQXUwUjZOYUM2ZFJrbU9DMm1DM2cyRXZqQm5vTkdRdVVaRHFzelA5?=
 =?utf-8?B?Ky9tRUNBQ0JaT2lVWlRSNTdYdnhwVUVZdFJFaC9wZjhJam5HK1pjTDFQQWV2?=
 =?utf-8?B?ZjM2K0dMYUxCZkRoMndvZ2xJSktud0VYR01MdWp1SXdBQ1c3WUttWUVMNnpG?=
 =?utf-8?B?VG5SS25NL09CYzFBbXpxcUN1QlBrclJmQzR0cEFnVE4vL0xHUllQVU8wYStm?=
 =?utf-8?B?S2MxNjd5M1NiSG5CMGJuKytqeHpSbGd3NjRrMUQrNFFWNzJmZlRJajRKZklV?=
 =?utf-8?B?YUlKenZXWFV4QW9RZFM2WFVuT0xTNnZXV3VPbWwvdzJkZjdLby9iRmh6QldM?=
 =?utf-8?B?bWwvMUxmTThrNEpDZ3VvVEFYTThTQjQxWHFmV3Z1N0ptdm5yam1wTUt4NTFB?=
 =?utf-8?B?RnRaWFViNXFrekFBbGo4aGFLdWE0eUVaejNVaVdWQ3JhOUh0M1FYSU41Sy9t?=
 =?utf-8?B?b3ZjOTk4Zk5OVGZsb0Q4RGlzK1NrQ2JvVWhEVTFzd05RRHh5ZDc5K3U0aW9C?=
 =?utf-8?Q?pAyazINAEyYU79GHGpJ3zhmcqtg+GxYUI+c6UheRxlAw0?=
x-ms-exchange-antispam-messagedata-1: 252DoOxQ53Lmb/Z21miqgTZbRn+nMBoQr40=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0536E20A6F91FB47AE6D2D3A5D078FAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z6U8e1U5xfddv3aaqIlWOw5MSGsN2cQ87I/5kNm29AUVYWN7mzFjPuMuI/wROOO032o7BZGoINoiZqvXZafRkSJSTnwaXRv0wYAskZ1BnvsMc3kPTFpEIwpivn6yUMWjJ4z8KR5zNqGQ9gjUCKLFKIJf11WdxS0e4KM+45YAqsYjzQrEnNiYTRnthpLUllYCyOGmnucM4cm/SPhJz49/sMt+FCfy/QIn22dwN5gZNzMX1upJQHQItOKxenq4sgtMM+2+xtxQ5MnIcYz5Ituf5LBzgdFm2ulbrfceZSj0HNBsCZ9hLjYp4OtcQJuoJhzPv+wOAorHjiPCT5W5j4Jlig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H7NPo3K6Ej0tVTz5YxoA9RlKuoG+C58Bnr7HGY3e2Pmtowt7TyZjEW0H/gMfythTGB/WdmMNEhllaaDInutmvdmGBMfxh8HbcO+/o/AlaUuVuNyfMcq3AXXjIaHJFdUU1NkxIZ3oeqsA0Sk/H7vaxv4dVW8u/s5fYxF69BDCButTrazhqo7zXVuQ4ZPEP2jbhoG7zL/JJp3BN82KVr8bx7CVpy05cYQLNcIftLM7pI5Tl+v1tpHXL4/mZdsXIL//RqCFFn4gf0AujTpBDwaAa+Fqe5NNYuVsFjbvIzbSRESqqZsvXZU/H/EWjIo/z473IX793G+lO4gr+St1vZptLzisXEq41KjM1xEaHH7MVCC+QYrDCg7R9IkImWbMOQrFYg5ZNpUZuKN1L1DmUb0gREI/N7+V+js99NPRMNqeUa0Y4uYEih0BL7XwEYIUv47A4atnhKjQkBebQgNCthGK8ZKxtNrluKlHvt3o0QSBV8UlKJr5UDTIwJv52HLVBheJ9gcjlnNtd9NgnXx5VjtkaURXoCkO2SxQtrOGMOfSoZ4SGv+0zLLS5CL719TePdqDItPMNb4shFag7oDmOY3yxmm7O5jnin8sqMMDWDZKc9Fz+9dFrWC1fvr+rX7MUrAy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f9b445-d8ed-4ed5-ee7d-08df2fee2390
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 03:39:55.4867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wm35lb28g/fKTIA18PqutF/U5Q5/4RDhSuuG3Rdm8vBFg5t3+yt1CIClHUHICyM8CzkEIVEVAXkQERK7BppbKaYNdDijD1q90xAsH1KS6ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8103
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDAwOjEwIC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gT24gOS8xNS8yNiAxNzo0MywgU2ViYXN0aWFuIEFsYmEgVml2ZXMgd3JvdGU6DQo+ID4g
cG1wX3VubG9ja19lbnRyaWVzKCkgYm91bmRzIGl0cyBsb29wIHdpdGggcG1wX2dldF9udW1fcnVs
ZXMoKSwNCj4gPiB3aGljaCBpcw0KPiA+IHRoZSBjb3VudCBvZiBlbnRyaWVzIHdob3NlIEEgZmll
bGQgaXMgbm90IE9GRiwgbm90IHRoZSBudW1iZXIgb2YNCj4gPiBpbXBsZW1lbnRlZCBQTVAgZW50
cmllcy4gV2hlbiB0aGUgYWN0aXZlIHJ1bGVzIGFyZSBub3QgY29udGlndW91cw0KPiA+IGZyb20N
Cj4gPiBpbmRleCAwLCBldmVyeSBlbnRyeSBhdCBhbiBpbmRleCBncmVhdGVyIHRoYW4gb3IgZXF1
YWwgdG8gbnVtX3J1bGVzDQo+ID4ga2VlcHMgaXRzIGxvY2sgYml0IGFjcm9zcyBhIENQVSByZXNl
dC4NCj4gPiANCj4gPiBUaG9zZSBlbnRyaWVzIHN0YXkgbG9ja2VkIGFmdGVyIHRoZSByZXNldCBo
YXMgY2xlYXJlZCBtc2VjY2ZnLCBzbw0KPiA+IG1zZWNjZmcuUkxCIGlzIG5vIGxvbmdlciBzZXQg
YW5kIHBtcF9pc19yZWFkb25seSgpIHNpbGVudGx5DQo+ID4gZGlzY2FyZHMNCj4gPiBzdWJzZXF1
ZW50IHBtcGNmZyB3cml0ZXMuIEZpcm13YXJlIHN0YXJ0ZWQgYWZ0ZXIgdGhlIHJlc2V0IGZpbmRz
DQo+ID4gUE1QDQo+ID4gZW50cmllcyBpdCBkaWQgbm90IGNvbmZpZ3VyZSBhbmQgY2Fubm90IGNs
ZWFyLg0KPiA+IA0KPiA+IFJlcHJvZHVjZWQgb24gLW1hY2hpbmUgdmlydCAtY3B1IHJ2NjQsc21l
cG1wPXRydWUgd2l0aCBhIGJhcmUtbWV0YWwNCj4gPiBwYXlsb2FkIHRoYXQgc2V0cyBwbXBjZmcw
ID0gMHg5OTk5MDAwMCAoZW50cmllcyAyIGFuZCAzIGFzDQo+ID4gTCB8IE5BUE9UIHwgUiwgZW50
cmllcyAwIGFuZCAxIGxlZnQgT0ZGKSBhbmQgdGhlbiByZXNldHMgdGhyb3VnaA0KPiA+IHRoZQ0K
PiA+IHNpZml2ZV90ZXN0IGRldmljZS4gT24gdGhlIHNlY29uZCBib290IHBtcGNmZzAgcmVhZHMg
YmFjaw0KPiA+IDB4OTk5OTAwMDANCj4gPiBhbmQgd3JpdGluZyAwIHRvIGl0IGxlYXZlcyB0aGUg
dmFsdWUgdW5jaGFuZ2VkLiBXaXRoIHRoaXMgcGF0Y2ggdGhlDQo+ID4gc2FtZSBwYXlsb2FkIHJl
YWRzIDB4MDEwMTAwMDAgb24gdGhlIHNlY29uZCBib290IGFuZCBjbGVhcmluZw0KPiA+IHBtcGNm
ZzANCj4gPiBzdWNjZWVkcy4NCj4gPiANCj4gPiBJdGVyYXRlIG92ZXIgdGhlIGltcGxlbWVudGVk
IGVudHJpZXMgaW5zdGVhZC4NCj4gPiANCj4gPiBGaXhlczogNGJmNTAxZGMwMTE4ICgidGFyZ2V0
L3Jpc2N2OiBwbXA6IENsZWFyIHBtcC9zbWVwbXAgYml0cyBvbg0KPiA+IHJlc2V0IikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQWxiYSBWaXZlcyA8c2ViYXNqb3N1ZTg0QGdtYWlsLmNv
bT4NCj4gPiAtLS0NCj4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnL3BtcC5jIHwgNCArKy0tDQo+ID4g
wqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYyBiL3RhcmdldC9yaXNjdi90
Y2cvcG1wLmMNCj4gPiBpbmRleCA0MWI1NTUxOWE4Li41Mjg2YzZhYTkwIDEwMDY0NA0KPiA+IC0t
LSBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMNCj4gPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3Bt
cC5jDQo+ID4gQEAgLTIwMSwxMCArMjAxLDEwIEBAIHN0YXRpYyBib29sIHBtcF93cml0ZV9jZmco
Q1BVUklTQ1ZTdGF0ZSAqZW52LA0KPiA+IHVpbnQzMl90IHBtcF9pbmRleCwgdWludDhfdCB2YWwp
DQo+ID4gwqAgDQo+ID4gwqAgdm9pZCBwbXBfdW5sb2NrX2VudHJpZXMoQ1BVUklTQ1ZTdGF0ZSAq
ZW52KQ0KPiA+IMKgIHsNCj4gPiAtwqDCoMKgIHVpbnQzMl90IHBtcF9udW0gPSBwbXBfZ2V0X251
bV9ydWxlcyhlbnYpOw0KPiA+ICvCoMKgwqAgdWludDhfdCBwbXBfcmVnaW9ucyA9IHJpc2N2X2Nw
dV9jZmcoZW52KS0+cG1wX3JlZ2lvbnM7DQo+ID4gwqDCoMKgwqDCoCBpbnQgaTsNCj4gPiDCoCAN
Cj4gPiAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBwbXBfbnVtOyBpKyspIHsNCj4gPiArwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBwbXBfcmVnaW9uczsgaSsrKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgIGVudi0+cG1wX3N0YXRlLnBtcFtpXS5jZmdfcmVnICY9IH4oUE1QX0xPQ0sgfA0KPiA+IFBN
UF9BTUFUQ0gpOw0KPiA+IMKgwqDCoMKgwqAgfQ0KPiA+IMKgIH0NCj4gDQo+IFdoeSBpcyB0aGUg
ZW50aXJlIGVudi0+cG1wX3N0YXRlIG5vdCB6ZXJvZWQgaW5zdGVhZD8NCg0KVGhlIFJJU0MtViBz
cGVjIHNwZWNpZmljYWxseSBzdGF0ZXMgdGhhdCBvbiByZXNldDoNCg0KIldyaXRhYmxlIFBNUCBy
ZWdpc3RlcnPigJkgQSBhbmQgTCBmaWVsZHMgYXJlIHNldCB0byAwLi4uIiwgc28gdGhpcyBkb2Vz
DQpzZWVtIHRvIGJlIHRoZSBjb3JyZWN0IGFwcHJvYWNoDQoNClJldmlld2VkLWJ5OiBBbGlzdGFp
ciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gDQo+
IA0KPiByfg0K

