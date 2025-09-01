Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B392CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszmh-0005FN-5X; Mon, 01 Sep 2025 04:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszmY-0005ET-IE; Mon, 01 Sep 2025 04:20:57 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszmW-0007e4-Kr; Mon, 01 Sep 2025 04:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts8QChuLY2XO97HTIeNeHuL+fJ6Ht4ErbkwUmjrFMzUNH5eDuggz2qNG0CUb7Rq7SKbmD7oEG9XW4Jmc06rnB3BFPCuALA15KTgyXqoPLbbqLBbzBPJ7JG5X8qyXcpfxCOwUlgSW8eQYB6PH3E2wxihrYsaVQZPth4VM2Iq5O3DQESNEmsanVYgvTnuH1KhyTo9eb9Uq8elJlEsYOOMUHpgY+XZxEwu//jnwQ2lyVN8imDwQZq5H3EsSBiDmUUgziAxPIlKgmBBKZl3Yjb+3CSCeRIKN7DOAs+ZBKoe+0zu0mO8IwKj1rrg/A8b6Vq1up/QyEoWJpoI04vjtsJFVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/PIfbv6fYuEIXMtUnfO6LB1JdQO8zaRmBNjU8AuZCY=;
 b=TmgA4VmpCo4m3dOOcEqnJro/9fWN2CA0V04e93v0gQqVaKY2ey4LwB42upA5VtVO0VdtHJa9uyny++Oym7tiavI9mvPT4Wbo677ojeFfJHNpPEtuqiywogz+PJR/TQU06M0DilPT7ZnzJFzLvOoZvF//oDqs1V9adJZjUvb05s3LHF96RuWwEZcaHKecAqOGDo/4r1WwKAW0ec3LxQVY5z2WDqF7z3j3la/ebNEnRFk80gBeu+/GGNT69R2rdrsqHd5oa+Pq7DCWyFFlDEa1e1Xzah52n/fuYyqOOKf4Cm1D5SslLqaM0QNSCf09gIDVM4uWYu0uFDEXgfxUpVqBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/PIfbv6fYuEIXMtUnfO6LB1JdQO8zaRmBNjU8AuZCY=;
 b=fQHlNShjAVNyvq4q7G3zz8i/YWyy29Jxhy2KcbZ2zGS8rRhSM1IL9tQh+2jL+MBSelqs2h5tINLr/Mil0eS3RzZ8eYmKyW2bjSlSNMPJn2ckaGIiipuO7Gqi2CQTR58p2p7YrqEDeKEFSbzyDg7kz3GuAg/CGnlmmp8spF9HL0HXljGTtSFaON7ioqtBFq2MFeTFBCexlFa1dONSJK6ubEdF3L9Jeq8tYmR0V1vVId2hXP6I2y2mx+xMYBWYHztiPhvhyUs71BR8JbOs5jCxOT7gYv+AOxhkU7DHvZxlvLsQIURLuOtKkURVXVBPDgjBrf0w+JWc3r5g5aidIhoJKg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4154.eurprd09.prod.outlook.com (2603:10a6:10:128::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 08:20:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:20:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb9v6W1kBgImncQkWlgy4s7uggmbRZDbOAgCU27oA=
Date: Mon, 1 Sep 2025 08:20:43 +0000
Message-ID: <e0e8724a-04ea-4f5c-b356-6543c512f4fc@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-8-djordje.todorovic@htecgroup.com>
 <87427d18-af1e-4815-b95f-75bae32720d3@linaro.org>
In-Reply-To: <87427d18-af1e-4815-b95f-75bae32720d3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4154:EE_
x-ms-office365-filtering-correlation-id: 5e095a6b-aff0-4936-ab20-08dde930723c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXVGYThzVFRoR3JwMjlrcjFCcUxad1JRaTFuTm85MHVKeTdQRnVIVTBnYjcr?=
 =?utf-8?B?d09lMGhIV3dUOFhBTFNKSldqazVQL290Q0FoZUxEOGZQT0xRYmpZbnRrSmND?=
 =?utf-8?B?b0Z6SHpESmtaRmNqanFMWEs2cnd0M21Va3U0ZXVBamhqdFNXYWd5bVZxSzB2?=
 =?utf-8?B?K2NrcDd2dmlVUkRPMnhaSDBnL0FXTlFrS0p3b045OGZMTWlLMFdUREtyZ3ds?=
 =?utf-8?B?TmhpNGJPblVtcUFlMWpEdHBMRUUyQmpLUmFvYWFaQmh6V1FTSThoeHY5Y0lU?=
 =?utf-8?B?VnczTWhOSGRWdjFwbUhYcmh4ZXZaR2xjTWJzZ1lTV0wzNGpjbGRZRVVNZmxZ?=
 =?utf-8?B?MDlWSW5vRXBBeG8wN3BlKzdtRDNaK0Uvd1JidE1reFFvMVJSc2x1SCt4enFt?=
 =?utf-8?B?VE10ZEdZMjhPMk1PSlBEL3hpNWQyMXFiZ3JjLzlwbnp2bmlqRjZuZVd2M2Ja?=
 =?utf-8?B?TDdQUWpjWGdnTUcrQUhKSkF3eThGRUZUZlFyMExIU2tSRHFOVEdIdU1ZYVAr?=
 =?utf-8?B?eGplSmNwWG85a0szNlNMQ1VvM20zWnhYUDVmUjFrK2lYSFdIM0YwWTVxY1g4?=
 =?utf-8?B?cWIxd2x2UkxvSmlFWEZpUWVGRjlmSkxYblZ4cC83SnFoalpaRFZXRDF1a3RR?=
 =?utf-8?B?SFVUUTJZb3FTZW9xVnp1ajU3bWh1UXljWTJIWU9GUzhnN0ZoSHRCUHY4VnZE?=
 =?utf-8?B?aWdZcDY4NnpoU1RaZVBlVlZ2UDJGZCs0YW1hRHBRcXF6OFdFeHlrUG9hWkNj?=
 =?utf-8?B?SkFMQk0zMTJQcmc5UFlaSStqbk5GWmkwZXZvVkhIby9VRGNDNDJ3b3I1c3pB?=
 =?utf-8?B?N3lXWlY5SGpEZUZBMEZUdUgwVEFyM0s2WDB0WjdONzdJeExMSllnek1peTRp?=
 =?utf-8?B?MmY1S1ErQWlXbWNCNktZYWVzRWRHdGt1ZUcya1k2S2dRUFgzVWhQcXo3dmd4?=
 =?utf-8?B?R2dSc3N1ZkpNeVJCTElZRFpBUTNkeHU4YTdrd1AxUk9FRTlkUlppaC9YSDRM?=
 =?utf-8?B?cm54cUVrNDNxMjhmTExTY1BYeU9lR2w3aXhQWGRaWlNFMWgzdkk4N0pZdi9l?=
 =?utf-8?B?eCtRUThGWHlCSXl6Q3ZBWEdmQzdYTXc0aytOWUhTaEJLT0t6QVcwMVdtSkNi?=
 =?utf-8?B?MTV6QnRsSDhlajhTM0g2R25qOW84eWFKNmNRem9ON1YxSFlvMkVSMWtITExD?=
 =?utf-8?B?SlM0OGpDWFBDdDYyQTJPdjBZbGp1UTR0RUhjRXpzQVVFSkdsM2NKM1hiTEo5?=
 =?utf-8?B?ZmxNUjVzd1I1WkI0VzNCa29zSTFUY1A5cm9aRkZFZUIyaDc5ZndwYU0rY0Vh?=
 =?utf-8?B?aHdYS3ZnWlg3b3lUTy9la2ZZeDN4R08yVnNHQ21sZXFsQ1Rvb1MvMW8yNVA5?=
 =?utf-8?B?Rm9Ec0xpZ3hCOG1zSUtjenhJeHIvODZkSFMzWXlPRVZXdVo1MDJkMEMvejR3?=
 =?utf-8?B?cWtSZmhWVGdhSDlRMDQvRG03UFpsaSswMDZrbmJrT2RrdGxTeGpTcTgydEYw?=
 =?utf-8?B?bHJNUERicTh5VGRkelFqbGRpSGU3My9WcStXM2IyNVJSZlJpSHhmU2RRQjYw?=
 =?utf-8?B?RnFHWitoK1BwRnJrSUtpZVh5bk0zQkU3cHQ2eVgvTk16VTlkUzlkaHlhbWNs?=
 =?utf-8?B?ZzZwRzNUQWkyWEdRUG0vQW1OUHVhanZjN1lJcWFyY2JOZFZ5d0Z5eGsxK0hD?=
 =?utf-8?B?dmt0WVNPOGlCc1lnUjNXUTNyWHhmVzFpalJDVW1PakpJNmxORDg5a3NRclBn?=
 =?utf-8?B?UHFaY3FhSHYvUWRGWFQ1c2wwdC9oVTFWTmdwaTNveWY5SVMvN2VrWURyenVZ?=
 =?utf-8?B?bVhzM1FnWUdmWS9XSXZjSzhidzFsQVNhMTR4ZERKRXNJSmp2bkN2KyswM3Rh?=
 =?utf-8?B?c0dDcmhQUG9haHFEaGdqeUtlcEluVytLL1pKWG0zUFpvbGljeSsrK3k4Q08x?=
 =?utf-8?B?MUQ0elJaQmVpalpwSDR3L0U5Zk1ienpWTHJGOVEvMUdZcFNjcWIvZHdpb1FQ?=
 =?utf-8?B?VkFpR0NOSnJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2F5OWlZZ2ZraWt1NWpndW1vd0Z5N205WDVsMGFhckJyZnY3dlByZUhuS2hQ?=
 =?utf-8?B?Z3psWHZ0enJBWkRPc050ZUprMlFPM3FWZXM0MnYxekplcVBOZUxSN21JcDUw?=
 =?utf-8?B?YVIydEtWM0t0NW1qUUFMdzc1bUQ2ajdBUFBXVnBJTnA0aGVkUXE0K1JwMlRq?=
 =?utf-8?B?TXNCSEtUNUk4ZUIreXFCa2V1SzBjaVNyek1qMHNuYzZWK0VrdGNqS1Z3cmZm?=
 =?utf-8?B?bVk2RXpKV0FyNWFNQm5xVEpna2RHaWd4a0pHSVczdC94dnd3a3pacTJEMmNu?=
 =?utf-8?B?SnBoWkZTQTVXNi9XelFtWFNxL0hpaGhFZzRwa0p2WmtIMHFLc25XNEJzNEhJ?=
 =?utf-8?B?SERMT2FtN3p5Vkc4dlh5NytJL2VyaVpoNXhKTGlSdkd1TWVsR1pjcXdma1Bj?=
 =?utf-8?B?cTlYY2dwaWRYRWVZSWM0cWhzMUM5SUxXUVlKd1JCYVpsQjQ1bWtDVXMvSmhS?=
 =?utf-8?B?VVYza1ZJcCtNbEpqQm1hcXRIRlNMVElDdXdzTTJVT3UzdytZWHpLMWYrUVBH?=
 =?utf-8?B?a1dwa0lVbk9HaW5JT0RtMndGR3UzRERidW9jaG5oQXpYK1U2UGZ5TEtDS29F?=
 =?utf-8?B?WnhNRXlGbHZsREdsUWVFYzB2bExhL1pZWWQ4bW94eGc4ZWlFZGZsanJGVmFH?=
 =?utf-8?B?anhqRFNwRjdObWs0Vmxkb2VGMEg2dmtXQzJuSWdjQVB6ZjJ2dkVFbUoxNExk?=
 =?utf-8?B?V3pRMnVWSVBXZlVSOVI3bzU0UXBIUDVDZ05XRXUvTW0rTjJYOUhLdm5xcml1?=
 =?utf-8?B?VzJ4NXFlRmtscndZZ0pMM1FVbUV1Y0RMZW93ZUR4RUpQNzQvTWd4NjNSWUJz?=
 =?utf-8?B?UUc4aGpONXVtNFVFUWMveU51T3d6NUNvRlZwWDRNVksxRnBNL0swN2VFMTBV?=
 =?utf-8?B?SG9RT29aVWZINGl6OFZiVG9sQnNrMFZsSmFaTTdvRGU2MFhPSktaOWU4ZGFZ?=
 =?utf-8?B?Q2FIZmNGbVJZMTVPNE8wMzZoM2xPalFLL0dtdmZlSkQ0ZDZXKzRoVFliTWV4?=
 =?utf-8?B?bXRKUWZKK0dwK2pLdXhtbWtIcURSWnJ2OTlFUlN0alNlRENIbkpqT2dlVXJy?=
 =?utf-8?B?dVNNdyt3eDdCMGgzK2E0d3g2d1libzVSZkJnb2lnYTlHMDVISnl2ZGFDZWtO?=
 =?utf-8?B?UzZUTytURGNUUURpY3h1eWtDVzdQK3lSWUNvM2JNakg2QlhsTmQvendQSzJM?=
 =?utf-8?B?QnhpYVRISU5YbGp3ZG5WYkpMZWR6ejEycmFHV0xud3VWVmsrYW1VKzd4OWlZ?=
 =?utf-8?B?RTVmaW5KMnNEMGZWQnU0NGRjWGxQdldtT20yNW1rY3h0Wjl2N0VHQjhBR0Rt?=
 =?utf-8?B?cmlUNG1KQkxLdURtZWt1aUhUcTJ4aU5kSzR4K3czRlZQTGFOOExmTkVIanpm?=
 =?utf-8?B?dVBRdjJtelhnTHc4NnhQeVo4UURDZFNoQ2tsZHdYS3JVaUlzWVdhdXdINlpL?=
 =?utf-8?B?Umc0bUdja0xzMWp2b3ZoaVNESm1YTnNzdU15L0VnWDI2UlFEUzI4NVR2bHF1?=
 =?utf-8?B?UFJOZ2tTci9pQkJQNno0bytCZlB4bW1JQ3JNODBWYmdNckFuTk1USnBUNWd0?=
 =?utf-8?B?NkhoZnk5b1lIYWZjV2ljK3ZoVUlhSzFLMmFpZEtwUVJ4eFFXSmhzSmJQZ21v?=
 =?utf-8?B?Uk9IUFc2OTZpZVZCenVnSTk2dWYvcDZUY3hXV0pHTVkzcVRBUGUvWmdMOU51?=
 =?utf-8?B?RDhOMnZxYlpGaDNSc21YamRsM1RrY3FkeURTVUZsclNQSjZ3d2xuZkVUVTJK?=
 =?utf-8?B?dm1KVmlDZ3IxMjFFZGR2Y1JjanRsSjBkZHArTlBnTkpab29hM3I2VVpuQU1j?=
 =?utf-8?B?OGx3dHpSTHYvNXpnYzBCVVhYUHNIQkRRSFNMUVBvU2hDZE5ncTJtcW9RSUhI?=
 =?utf-8?B?WHR0N2QvRkRsVW1Lc0Zvd0YzdjI5djd0ZVNSa3lkajdPOFhra1NNTFNBY0Vj?=
 =?utf-8?B?WHV4d0c2TTFGYS9qQmJvWmY2QU9Da3Q2TUw1a3BKUWlZM3k2N291NnFpNzZB?=
 =?utf-8?B?TC9DUndwblduQW5ka2d6Um9vTG4rdWRIUFRIc28rUmJETVVnekhvUkRqTDBY?=
 =?utf-8?B?Y1RXNk9QSktrdXpHdXdtYzlyejdYOWVCTVo2WVBtYXp6OGNDeUM3TGVTTnFM?=
 =?utf-8?B?cnU2bTErRjlIOU83ZEJYUlRoWDRDMjlLMkgzZnA3dkZJQXhJaXpzc3U3cnAy?=
 =?utf-8?Q?DYdgvdi/m+WmZy8PySLu/RA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7598F992312A724D8EE8C8C7CCA95A95@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e095a6b-aff0-4936-ab20-08dde930723c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:20:43.9002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRk5BGpcRKTuTvxrB3Bjmi6mWoPJMqKaOyFAwiVBixQAscm6OwEfqwIbUFMGWQ+RfokcRpES7H7+bT1xcfIPSdFqkpZGkVy9l6NtCaBSHgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4154
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTg6MDIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IEFkZCBNSVBTIFA4NzAwIGxkcCwgbHdwLCBzZHAsIHN3cCBpbnN0cnVjdGlvbnMuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4N
Cj4+IC0tLQ0KPj4gwqAgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArDQo+PiDCoCB0YXJnZXQvcmlzY3YvY3B1X2Nm
Zy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4+IMKg
IHRhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDEg
Kw0KPj4gwqAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMgfCA4NCAr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAgdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjMgKysrKysrKw0KPj4gwqAgNSBmaWxl
cyBjaGFuZ2VkLCAxMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPg0KPj4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfY2ZnLmggYi90YXJnZXQvcmlzY3YvY3B1X2NmZy5o
DQo+PiBpbmRleCA5NzM0OTYzMDM1Li5mMzVkNDc3ZjI3IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0
L3Jpc2N2L2NwdV9jZmcuaA0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaA0KPj4gQEAg
LTM5LDcgKzM5LDcgQEAgc3RhdGljIGlubGluZSBib29sIGFsd2F5c190cnVlX3AoY29uc3QgDQo+
PiBSSVNDVkNQVUNvbmZpZyAqY2ZnIF9fYXR0cmlidXRlX18oKF9fdW51cw0KPj4NCj4+IMKgIHN0
YXRpYyBpbmxpbmUgYm9vbCBoYXNfeG1pcHNfcChjb25zdCBSSVNDVkNQVUNvbmZpZyAqY2ZnKQ0K
Pj4gwqAgew0KPj4gLcKgwqDCoCByZXR1cm4gY2ZnLT5leHRfeG1pcHNjYm9wIHx8IGNmZy0+ZXh0
X3htaXBzY21vdjsNCj4+ICvCoMKgwqAgcmV0dXJuIGNmZy0+ZXh0X3htaXBzY2JvcCB8fCBjZmct
PmV4dF94bWlwc2Ntb3YgfHwgDQo+PiBjZmctPmV4dF94bWlwc2xzcDsNCj4NCj4gQ2hlY2tpbmcg
Zm9yIGFueSBYTUlQUyBpbnN0cnVjdGlvbiBpbXBsZW1lbnRlZCB0byByZXR1cm4gdmVuZG9yDQo+
IGV4dGVuc2lvbiBwcmVzZW5jZSBzZWVtcyBvZGQuIENhbiB5b3UgaW1wbGVtZW50IHRoZW0gc2Vw
YXJhdGVseT8NCg0KV2UgZm9sbG93ZWQgd2hhdCBoYXMgYWxyZWFkeSBiZWVuIHVwc3RyZWFtZWQg
Zm9yIHh0aGVhZCBpbiB0aGUgc2FtZSBmaWxlLg0KDQo=

