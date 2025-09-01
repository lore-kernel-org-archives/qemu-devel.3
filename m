Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8226BCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszwM-00024h-LX; Mon, 01 Sep 2025 04:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszvz-000232-Ua; Mon, 01 Sep 2025 04:30:42 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszvt-00039W-7W; Mon, 01 Sep 2025 04:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+l5gVH2G+WIuv7mvUBmaTs1Y4igzFtYp6keGm63QYEL8m2fbDhTpPF+hMlHQRj/SfwLoijPt+LcCEgrhwM0W6d0npGuO+p9O3/EcdqMEvG1PZATpAUWhFqPBz1PkXPO5kh8+KDnm85fxtK6znDPonjeTedjMRrvJvI4gsoOBSJ0kyhU/rdnPhvPLKY3PE0mIzQQYcQZ3+zVZRm9sUrfCQvZZx5LYTMTT/cT/wkZvsKdjtuxloPIWcEwuCZoSWP3K7hHR5FDrj09+v6uVCYcYcRmG7X2ds7yRUOjW3R8lXUsxbJ9cS5twSTkN+YIsWK6C/9AuQBifrotlHZdugXU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOMKsybQSacr8RcuVX18bV0ClHvqiFY40xvtqFWnIc8=;
 b=g8AUDrSGy/ezJnHkEXf/qCkRsxVaHDHnCDoIcYVA3AOiYGObCl6IJBnqeqnp1HUJHK1nt5XrQ2+5poHQala+Zb/nVXcs5AutUJjZeqJsv1+kVqaSiBj6hDIirnH9GrJ14p1X8V7MGUEJs0JemU3DVJi7XnLIj7jUtkC5mDuI2NtOWm8JdsZUHPQBdoWLZ6AWH8NvEtILH1ziC1Z2A+81+oZbJQHqKkTqkCk5TN5eJAC//m4z1c4qCL3wfh2CRkcIv5zxlIbxaSEijS9cK5NHMBE5pvgHcnxPJ0JcxcavZGP/dA8pqxDwjVYdtMXu0NEhpQP9buh2De5bZgbKOq73lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOMKsybQSacr8RcuVX18bV0ClHvqiFY40xvtqFWnIc8=;
 b=OzcfeIX56O2+upwcSMtZfLDMtL2N5Lkv/+t8nhZ52CZJHCNr2RhzHzWo/OSpQ9mZvK91DVntVDaCYseNiVzO1eZPVn4mmzr+9vRYc9k2XOkKIzDDC82XNkX2J0e+YN2fDpWnWlnjrOXUSrtwXgPjNitkAK+yap7J8O7M91LOOQDuZd0YAWXVvhyN5skWnJ8FUdan8e1VS4odDt93ZHLPJw1+W7MlLKjzLJlNaNPfpcDA5U9ZA9kAmYYUo/1Jd5RHGmiSj/9Wk4Clr/8PFo0HFvRJN/l1OYSgEwCGEe4E3rNeAp/RLNyyOw2/aCor69pDF5BCtr5smMdP8R/lZ5Jvnw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB7947.eurprd09.prod.outlook.com (2603:10a6:150:279::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Mon, 1 Sep
 2025 08:30:10 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:30:10 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb9v6W1kBgImncQkWlgy4s7uggmbRZDbOAgCU5kIA=
Date: Mon, 1 Sep 2025 08:30:10 +0000
Message-ID: <00c8547e-dbbc-44d3-bcdf-122899d7dc2e@htecgroup.com>
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
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB7947:EE_
x-ms-office365-filtering-correlation-id: 3db0c193-ec57-4ffc-864f-08dde931c3c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2J2dFJZTnhWbzdQVEJLaytUejFjSU1wYWcxZVVOY2Vnb0hIRURLaWIrYkJ0?=
 =?utf-8?B?NlkxV01Ib0MxREJzSWp6MnVSeFdoZ1pYTzk2YW9DUHBTL01QN3d4cGtNQlg3?=
 =?utf-8?B?R3JaZHBMRlUxNWVmd0ZJcndDN2tmQjJvL3BFZEhTcU1sNTdYWjVHeGN4QWRH?=
 =?utf-8?B?TUR6ZGJjTE1qaXNnaVpYM3MycUNpWkI0bUJmMHFCNVhKZDZFQzZ5NkZKK3NC?=
 =?utf-8?B?KysxYUs3UHFRd3k0NXdNUi9hK3p2SDRhMnN5Z1M5eDEyQm9SRnFhNDlObGFx?=
 =?utf-8?B?eTBhdDhWSnFjRjRhdDRiMXZhQWhJdU9VMWFVMHM3TGpIZWRmdk1oeHV5TWdU?=
 =?utf-8?B?L29mRWdhZXZOcHd1TE5LNjNFWURHYVNRSWpYTm5SbENxSnovZlBnOGt0aisy?=
 =?utf-8?B?MlVSc1FTbEJDUW84SEY2azdPbEl2MUQ5MWtsWlJHZ2ZQMDdSTU81OXRZTHVZ?=
 =?utf-8?B?akZ4MDZwQ0JYZmh5dUM5Lys3UkFpVDBzaUlJcnBlN1haOXJuOFl2bTMyNXh1?=
 =?utf-8?B?UmdQVE0waGJCWERSVnd1dXZXNXNnSzZPS0ZpbTVXSDJpeWxEcVl2L05DLy8z?=
 =?utf-8?B?VzZFRk96OVhlYUFwcDRPQzUyQ0tKSHVabUFQM0VnalVSWDBhZGZYT0pueDdJ?=
 =?utf-8?B?RkVXTXVMazdVRzRoUTQ1QjRpS2dHTFRId21CT0thNDJWaDlJbGJKSlZyQXRw?=
 =?utf-8?B?UG92d1hoczNWOENrS3VEMW9nTUw1ZEU1NDJxTHh3R3g1TnhORm9IZElCQlgy?=
 =?utf-8?B?RDdPM2pFYTRwVUs1T25iQWRBSmdUSkJoeEExU3h2dTBsVUVJRG1aSDdlYnFV?=
 =?utf-8?B?WGpjSk51ck1hNFhMbzhXVE0vNWlPNlQ2dDM3NitDNG9BSnM0dWZiV0VDZXlQ?=
 =?utf-8?B?QmNRZ29RL0VlWkxISjA3VzBlYjRKbSsvUVN6djFhZERjdzcrbGE3U0R4cm9C?=
 =?utf-8?B?ejM1eWZKTXc2NjR4RGswWDlpMWtVWnZFTE1kVGNOK2hISWh2dkdDR3U5c1M0?=
 =?utf-8?B?Q2tmQVd3Tyt3a0VybWlFU3Z5VzA1M0w3ditnOGp0eXZEZE5BclYrNGxGbnow?=
 =?utf-8?B?eS9pbUcxVmdmM0dBeElPZDBLZWFyRlR1VGRtWE5zWW1RRUgrYzRTdjUxRWFl?=
 =?utf-8?B?ZUYzOFNTMFZiVmd5QURLSGNlM0xhelg5NHRKMWo1S1ZhMEpjVHlMMEZJdGxK?=
 =?utf-8?B?UUxoRkFXQWNwSzlZN0FaN1d6Skh1d3FsdTI0NzVVRlNCQlo1NGRLRlJRZlhW?=
 =?utf-8?B?SGhDSnRuVThKSTd5NlM3akk2SUNNRldpU0Nua1VadHFaWnRvaWpVb2p1V1FV?=
 =?utf-8?B?SllOWFo4OTZEWTRtV2p5NHFBcXN3Uk9peGpjSWQzSlF0VVhxOVhiWmhySjJO?=
 =?utf-8?B?MXl4NEFtQklPamxEYWxWeFAydWlXZzF3SFRINk53N3RKb2xmdCtUM1pheEZ6?=
 =?utf-8?B?MGZab3B5dUN6MytUVEVFZXdxNXVGOE5BbWYrOEJSZ3g3L29rdGtZcWQzc3p5?=
 =?utf-8?B?aUVZZzJkY3NGNnZNZS9INmxrOXpzS2F5UnR6MmlHL0p5TW9XUjFiekhJbWd6?=
 =?utf-8?B?QlB5SWhEM2hsL3ZOZFlER3p3dm5tS29XV1F4NFdzVWtmK0t4b2s2bC9TTUFs?=
 =?utf-8?B?ZVVFSjJLU1BMY21ibjNvV25QMUk3Y3NWTzZ4Vk53OEFxZEt5aXVSSzRRRldq?=
 =?utf-8?B?T2xDWlFMSG1xYk9vZEdodEVjRHp1WVl0MW5iODRmRzREWVFyTjUrR3VNWUdY?=
 =?utf-8?B?R0pEdjc4VmEzUnFGWHpvNTlLNlFoSmEwS0RVYS8rUzFtc3BVWEt6bS9tNlpL?=
 =?utf-8?B?UGx4bUs5eThGRXhuUHFiSjNKZWEvT21iSklVTFo5UllrR01tUE8walVreTB1?=
 =?utf-8?B?a0pCMnNIK3ozMDBhV0N1MGV1cEQ5WHJ3SVZienlSUW5wN0tEMFBVcnBDeUI4?=
 =?utf-8?B?V29nd0c5NDBsTXIwVlE4SXk1SzFYT3pSRU5KUjBMYld5UFV5bHhIc3lBNVRX?=
 =?utf-8?B?SW5JL2ozZUNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmdtaHZHalhhTXVDZWNuUmNsMmhNbDZHNnBRb3dtd3hiVFZTUFExK3Zjd2dv?=
 =?utf-8?B?eUE1RjhxOENnL3RtQUpPYjVJSjlnOEprNHhKanBCRC9Kc2puVlkxRlRpKzdN?=
 =?utf-8?B?M2lUWlpQc1FRNU5xK3ZBSDdnbks5bTFramRhSDdheWNqYWlIMURsSFIxU1Vk?=
 =?utf-8?B?VlhmY0ZXSjdjckJzbUQ4b2dGK2tHRFBvVS9Ob3JQVUtXYmZSTFFBZ1VVdFRl?=
 =?utf-8?B?bE43eGIvRmpPQUhqSzNNTEd0cTNORmFDaFdlWmtNcCtkaU1xVDRvQnQ4OXpI?=
 =?utf-8?B?bTU3WHJzaldpOUl0cXo0UDJyL2hVcmRUTGZUL1RtRlpuQVdnVThnbXhjbmlZ?=
 =?utf-8?B?aDZIWktvdjh5TGd2blF5bFNkY3VUWHZWOVB3OVB1cGRvRmtoZFZTaUNydFJN?=
 =?utf-8?B?ZmtPSnN1MXlkMytoMmpYb3ExSTdlOTN3Q3JoWG9RQXJSVUJEQTBha0xobjlm?=
 =?utf-8?B?cXQybUZjL1JzSDZiSW1oQ0w3bkhDRWhCcWxVWlBpdE1BUTdpbWh3cyt0YzVr?=
 =?utf-8?B?Q2lrNFpld3dxUExhSklmck1qNng2cWFLdXh3YzdINnljbFdzQmtZcnY4OWxx?=
 =?utf-8?B?T1N6MEpxVEs0M0QyNDJ3TGR4bzVBazFyZjduRnVGTXl2MFliQi9qL2xtM1Nv?=
 =?utf-8?B?bk01NktsMzVZODFjNlFpaEl1eE84ZlFyaEdwcytwbUV4Uy9DWC9abHV1aHRE?=
 =?utf-8?B?ZzFteFJrcWx3bzBPZ2o0RkUrakJwN3FYTzhQWlFKOTRWejZLa09raXpQSldF?=
 =?utf-8?B?MDllRVpLZlB3dUg3cnEwZVNkTjlqNHNxRk1JTUFIQ2lidG9mT1VzUHUyVExY?=
 =?utf-8?B?cjhOZWdtQ2pjMk5DTHNWV2F2Z2FOLzZjRUJPMzNKdHNnU29OaHVvQ3R0Q3Y4?=
 =?utf-8?B?M1ZZR0NZcDJlRmEwUStPSFhYTGV2TlltWUtxTTJveHYxZ0FZTlNnL2hYSWRi?=
 =?utf-8?B?TTlRNmcrZXpMNWhRdDNvWERvQ2w1N0ZTZTYxMHk5dVdnbmVKdndYUWRGTVJZ?=
 =?utf-8?B?RzJ1MStHT0hmSUtmcXAvQ1NuQ0FxUys5a2o2bHZ6ZUV2b2Zwa1J5UEZKMEcv?=
 =?utf-8?B?enBFelgycTRHUzhFSmR4Ly9adWZHSW5DQU5GQWxTcTRCcmZLVm5SQzd0d3pR?=
 =?utf-8?B?RFN4Z2hwZXZuRGRzUjFqZjlZYXByYW1oK0puRTNxdGo4d2lpQ1pJWWM0SjVZ?=
 =?utf-8?B?ZDRVRG9uZTBWaGhpV2drdWE3SE96RE01YTNFaTRGMTJMaTY3Y0FKQkwxVWx4?=
 =?utf-8?B?LzlQaXlzTUpzcy84ZlU1OHVjMG8vVGx5NTNIamxzek0wK0h0M2Y4VnBIS3Vr?=
 =?utf-8?B?Sm5GN3ZvSmpiT2RVcTJOckhQbDd6N1gyalQ5VFo3blloSHJMVk9aMDYvUUh5?=
 =?utf-8?B?KytWVWh2d29DUFdaOU1hWWdaVE54NnpYQ0hNY1JJaTFFMURMK2h1b083YXBv?=
 =?utf-8?B?ZEpwcVp0MEVadXJSUi9MS0VqWFRGZjEyOHBPZEV1WVgwV3JNTWJOR3BVa0E1?=
 =?utf-8?B?U09nK1hiWDhqOENGRHN4aTA1VEhESWtjQUVJWEdYS0VsNTdsTm1nWEIzdDc4?=
 =?utf-8?B?VUdYUzRobTlVcmwxejFtY2RCZysrWnJYTUN3WER0M1k5MmJRaWRObUpGL1pp?=
 =?utf-8?B?Y1RuNys4QTh3am9HYzNkS2lkTXFSd1BDU0pFK1RhZHplZXVTcTE2WjhWeFRh?=
 =?utf-8?B?NFN4cElpT3ZpSlpnWXVTVVR2Q2s3SFhWVElWWEpzRnYza2I1R2JwejAyMlQ2?=
 =?utf-8?B?Y1RweWZtVjFyclducmo2NDZQcWZ1eExzSFdTUFlFSFNwaU9rd0owZGZLSEZL?=
 =?utf-8?B?S3I4SkpHK0h2ZTh1ejlQZDFsbXVmeFpJaVpSaXFjQW5yenJLVjV3R3ptbTBH?=
 =?utf-8?B?d3hBWUZvdm94WUk5QnJ6dmwrUGs0WnFZdXRYNndKd3M0UlZFb0pnd29mUWhY?=
 =?utf-8?B?Sk9OZXdMcDd1THJMT1o5UGFQNFoyTlJPaDVMb2NHTk5ZOExpdDJYSkVSeGQ3?=
 =?utf-8?B?dHByZ1Vmc215TFBxVnJibDFkL1NjTkNsTjU3OW42V1JVam5Kd2dVOTJpcTRn?=
 =?utf-8?B?a2FFend4Z3FESzZhSzdFcDRSNGRKLzRCQXNKY0txTUowM216M2hOWXI5aXlM?=
 =?utf-8?B?QWh2cEUwcXdrcnkwcVprSkdkQkhiZHFuc2Z6MDhIbW84RXJPSXpkMmNnNGhV?=
 =?utf-8?Q?g5a8doTYMiEjN/oX5LIUQUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8F6D4F68C6D645AFABA1674668C7DB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db0c193-ec57-4ffc-864f-08dde931c3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:30:10.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /d4gsLcbjqYggEquA+IXOf61OpKtMWyA9ynyd2B8VDrtl7WNyaOykzoYW79LuoSUy4Lc0XsuuhVvVgDHexxW1EdIsT3UE3jl4Vzfuvqa7XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB7947
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
YXJhdGVseT8NCg0KQW5kIEkgdHJpZWQgc2V2ZXJhbCBvcHRpb25zLCBidXQgaXQgb25seSBtYWRl
IHRoZSBjb2RlIGV2ZW4gIm1vcmUgb2ZmIiA6KA0K

