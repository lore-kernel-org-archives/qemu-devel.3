Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CE4C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEcm-00043b-9v; Tue, 05 Aug 2025 06:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ujEck-0003vM-2X; Tue, 05 Aug 2025 06:10:26 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ujEcg-0003lP-JT; Tue, 05 Aug 2025 06:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6nbvKwdj0cwXhb2HQO7kVjm6T23YRKcDfFZCc2kLb+cZ7bHiYlrjW97u6qj7cUvo5zFnlDFitFRUzuV06jQFNMJvchSbfqXMSlgpOLfpuQj3Y/JYyNCI7fcprov+J/fCQnG3eUyGlOOVl5WttDvm7fbkAj5oRIaN+fQ7OBEbgx3V8JX5HkX1Kw+t9DThsR1GgQ8vwV3Fq2i+dOH9cIX+ugACihvEw2idPxmbDyQoGba5ivyYkI4RiBPLd4G8ix2Ympn/Sm0dAuwdnX69XjyAspRBidImnSQq6SrMO+EZZzgZi/Es8nb7DLvsdJcxxskcgj55WsUnRJrWdgqtm498A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A4Oqp9woo7m7HztiOGak/R+bhlC+UPLy9MoYqlT86U=;
 b=RBJ95mL5MEnyA0QeDFK1j2DCZkFFJIh4RQZenYoS/w673A0oJHWdkYFrdnbBn67v70xwbYwVaZV3laZLUKb8s/tGW/1qGNljL+ZRqlyj++TYkTdoq+z1DEfcsnRnbYNMWrU/Tl6jWgGSZdXBhWEPP6zujkrziPa1Lrm9MUzFhtIzw6GAWrUQyTQskCpd0m0z3EIO1DC1ruHmgFAZFkfZ/1SAp05342RS8UIUxLn8J2fiioiuOznY+3PAMdUvi4mWQWO+Gwz+ZryWS9gXk9r4aVg0Zr0KGUTK3FApS7vQUE5i6Ftg9SfTDlBQ6Xsc9lQFlsGJM3V5EjyL1KYHGmOMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A4Oqp9woo7m7HztiOGak/R+bhlC+UPLy9MoYqlT86U=;
 b=aNLWY7okXJVShk6Z1vCS26zbYadXnMghaLmJ5c/03/bkvi+w4wBQ7C9kBgdkjWio7IBF8hesAxreQecC+r2o8iOSQThyzyeMnNB9/wfRG9Zl1oyS4Pv2y6sU9179qtTj28yK8IrhTYpw/BPdKXROM3hW1kt9dg+m7Tq+qYea65ayKv36ssTZPW2R2GkiVN58R1s31DxhjTu0ZYQ+hBuPsghmMWHYSCfWa0dkkRCMFQAfWxyd/iOyYepbx5SzhArTV98Cb98UZXADaQW27mzRVf948aozs259Lm03595BGchiFHZN/Q6LEJrKffPKEER41o3sUejZulfQD0TCJrkSuw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DBBPR09MB4555.eurprd09.prod.outlook.com (2603:10a6:10:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Tue, 5 Aug
 2025 10:10:15 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:10:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb9v6UGrCoAbtlqECp61EdLa3+x7RT9EgA
Date: Tue, 5 Aug 2025 10:10:14 +0000
Message-ID: <c02e98ab-bcb0-4f2c-b30b-be179eebfb49@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DBBPR09MB4555:EE_
x-ms-office365-filtering-correlation-id: d8727b40-fb2e-4a2e-0977-08ddd40845a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azIrRURoVHlmUDZtQkRrTUxPNncrand3dzE5OGV2YWZHcERocXdVeHZUL2JJ?=
 =?utf-8?B?eDR2OFVMTkR2VUloMjRQWVJzU3cvdHlLNkU3eHM5OGZ6cUVjellzMThVVDdy?=
 =?utf-8?B?cmZTN3J5emhlbllXMFBPYXUyN0wvUzhLZEZ3bGwzTUEybTE3MDErKzFxdS9I?=
 =?utf-8?B?OEV2dElYQU5wN3ozSFRiN0xCcVBZWFRTMUdhQy9PS3l5VklrZmhsLzNDOUdJ?=
 =?utf-8?B?QzU3clZNY05qM1Zscis2UWNSSDVKOHpjOVF2UVBwUjZod2s4VFQxdmZveXgz?=
 =?utf-8?B?TTlFenNvZHVnWE9SVGVja1FQMG9OQmt4cVozelhHSms1Z1gycExOT29NY0Rq?=
 =?utf-8?B?NGRGUTVoMkd3eDJMcTJyaGJzME5HTzUxNkxMTFFIYXQ5WG43LzRuUjhiam5p?=
 =?utf-8?B?clU4MnprZk9ZeXBXcDJxVzZ5TTdhWGw4azc5YnlSQUNIaXBNUnVzWkxPK3Rr?=
 =?utf-8?B?NkJyNFBJbFZ1UEwrVDRJUHBrc1hDTzlGaXNGNjllemU5M3NnZmhtSXlQU2ZM?=
 =?utf-8?B?MTFxbUZrZTVZQ2wxYW9KaWd6SCtiNWxPeHI2SHpyZXIzS2ducU1HOUttclVD?=
 =?utf-8?B?aVpmanZHbTk1bkRtemQvVEY2VHBOQUVmbEF6NzhVZFJidmVSd2h1K0o1OU4x?=
 =?utf-8?B?cHc1UnVWdTRlaENRNU4yaDZEczRJdXpRcUJ5YVd4c0ttRWFJeW42M1JGSzgr?=
 =?utf-8?B?UStvNnJLSFFVZVhnenI0blg1emdOYkdtM3NrL3NRalQvTm0rRlVMYlBZelpo?=
 =?utf-8?B?bVAyajJRaTFoSnUyMGFPQ1dQKzdUd2VLenV1OEdnOHpxdU4yZElCOFZ2UmJ1?=
 =?utf-8?B?S1JIUitKWk14S2x1djVjUHFiL2FZcmZwRmo1UTBSRjNrY2NxanRKNnQ0QXF0?=
 =?utf-8?B?Yzg5cStQY3RLeWptSmUxcndac0g3VnZSQkVwb01Vb25wV1c3YnpFaENqYlZm?=
 =?utf-8?B?YVplOExBOEJyalFkVHp1SkMrVlU5MGptanBkK1RERGxQSXlOMGU1RVhTbE5T?=
 =?utf-8?B?Q2I0dmdVN0V3dXhMajdLbW5jZ1lQdjQwRTEyRG1RMng1S01lbnJ5Ujl1ZndJ?=
 =?utf-8?B?ZkFwZXVqdHpaME1qVzBzRmNjTnVyUWdacVBIUG9FVlBkT21LSW1Rb05lWjd5?=
 =?utf-8?B?TlBTWTYzbStwbGFjKzZWdHo0bituZTc2SFA3Z2Eyc1Eza29GQ3dJWTVDUEtY?=
 =?utf-8?B?NWo3QVhZK2ozK21DSW81N3B3dFIvM21nRkZpTkpEVnM3R1FCUTZadGlablE1?=
 =?utf-8?B?STV2K296Ulpha2dPQUt4OHZaZGZPYlcyS0llck5qOVc5amROUzY5UUVDY3J3?=
 =?utf-8?B?MTlhNTNvYUdXcFBQeW9mOVNqWm1lbmRjdmpsT2k5NHlkUnpiUkpQcXYrQTZ1?=
 =?utf-8?B?YXhrTGxKM25jU09PNzF5VFFGRkQ2M0p0L2piQzdlcGh4NDBGS3gzcnZxclVi?=
 =?utf-8?B?MTBhbUx0VVhLekRmM21oczlOUExyY3ZEQzBvam14UkJDbTUwUzNTaTdIc0Mw?=
 =?utf-8?B?ak9YNHp3UmlJMktGOHBsVHlvK2luVHRoMUxlUTF5aXYxQSs2OEs0Nk9ja0lV?=
 =?utf-8?B?d1U4T1pTc2FTckNjZ0NadTBva0NCSW81RXF6Mm05aFdlOWF6ZEQ1cHRLL3ov?=
 =?utf-8?B?WThJUzVvSm1xdFZCNzVmN0l6RW5KL3JNaGYzaEFRVGMrZk1pc1BJNXdVbVZl?=
 =?utf-8?B?MVlSNER3c0oyNStnQysxWnJJeFJoQStwVUtYejBhMlJBdTJ1T3FkNk9LWmlT?=
 =?utf-8?B?STN5YVhkUXdwMDZld2hSdkhFcVV1RnNIdk9vZ2FtbkpLVElQOFdwSXlXeStV?=
 =?utf-8?B?L2NLdVMycysxVnBiVzJ5b3dhWXR5VnpVazgrOWNrMnQ2Q090UXVGTjMreHRZ?=
 =?utf-8?B?cUowbkR1OHk4L2Y2QnM3VzhNOG5jZk9QTHRFUTlxTlBjYmgyRzhLYU5leHJH?=
 =?utf-8?B?cUtta281OHh0cHdQMGNUeTM5UXJSMUV6ZExSTUdKYnhxb2J4Vk45ZUxpNkM3?=
 =?utf-8?B?eXgxTEptQW9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ci9kQVR6bzBrZkJhV1ZBenQweGtaTEQxTCtYcmxhajVsSmxwNWlrcUl3M3JG?=
 =?utf-8?B?RWNIN09paktsRDZxdE4zdjFuMDJnakxCb2VTMjdlbUVRVEpuSnBJcTg1UFVN?=
 =?utf-8?B?K3Z4OEttM1Q0dHdCNGNEVEhjWVBWN2syajZqQjVEWER6NzZVaWluQVVvYXRv?=
 =?utf-8?B?TUFTcVV2dVk4dTVFL0hxZDBKRE1YSFJVMnYybmRybGQvcDZsRmZyaXlFK1hv?=
 =?utf-8?B?RWxsNHY3c3lueWtBSUVxd2M4Wlc1bmRiT21RbmtDS0NyU1Z4ZlcvdWJrVUpw?=
 =?utf-8?B?cUxBTDJzbU1IMmhvSjBTK2x2OE5kSHlTNnFQUDVQRUpaUVhqS3RORVlnZWth?=
 =?utf-8?B?U1YyWGhwLys2Y2FVekdNWEFONmxaMXRpYlBiUllDenBmRWhJQXM1YU5OTDkz?=
 =?utf-8?B?TFpmOU9qVkZjN0F2bWJyWmhJcTREdC9EbjJETy9CT2xXemRVRDc2MVFLUitE?=
 =?utf-8?B?eFZPbXYxL3dMYUZZTjkxdktaR1hCbWhNa0xoNG1XcllaMW1LTzFEOHJEVkZC?=
 =?utf-8?B?TjNVRHRYcmxLc1RFaTU5ZkcrdjhXL3Y4K0sxWlJrNlJtOXN3UTFPK2ZBUnZV?=
 =?utf-8?B?ajFKckhURWxjUXNPUHhXZDN5WEdFTmM4YnVFVll1ay9ZdnlIbUpGTjNzaFNp?=
 =?utf-8?B?Q2JnYjB6UTdvaG85MG43OE93eVM4VndHeXZPekZvN2FZbW5BNGMrTVljbmJl?=
 =?utf-8?B?QmRCK1Q0eXp3VjY2V3Y0YmtkdVdKZ1pHd1FiZW51V2NMSzdJckdMWUhyWkpx?=
 =?utf-8?B?Qjg2b1JyeEMyZStrQmI1YlJlSXlKa3FQZ3lnRGloS1ZmMGJlRjRmQWIwU1JP?=
 =?utf-8?B?Z0tWUnNvaEJPdGxqOHBWYkYvbjRpK2dFaDhMQytWNUdWM2ZPLzROWS9nazlt?=
 =?utf-8?B?R2R2MWU5Q0NseEx6OHZ1WDduSFJYRWxmcHpqTTVlSUhmS3lzQWovaEVrZ21w?=
 =?utf-8?B?YW9wRDhTazJOOVZpb1FicWhpYnhydUk4c3FUcGZCMkNUcVEvendSUEtvU1Fn?=
 =?utf-8?B?cHFOQjhtRlBwakIyVkxub3NOL3dieVlvQWFYak4vd2pOdlIrWElndDVRT3ZD?=
 =?utf-8?B?UUM0UFAvQk5kYjNoT0laK3RNYTVxRXhzWDI0MWhkUUYydzBCbXhHZHFtQ0d2?=
 =?utf-8?B?M3YvKytmbVdnR1ZKM1l6cTgxUVZBVTR2RkpuOHZwZzQ2bCtlKy8yNUQ3dDBZ?=
 =?utf-8?B?QzREL3JjdVlkcW1mMXVydyt1QVB0alFiNDlLYy9GaVZwQUJwSDROWlJzaDZy?=
 =?utf-8?B?bEVBZGM1L2RKNkRhekdiaE1wY0VPcHUxUVR6eWFDNnVYajN6ck54QXRuRldW?=
 =?utf-8?B?V2lpWXJpQmYyOWh5MVEzajVPKzZMU1ZtNytmdjJqYjgwNzRhSWxnMW12azhu?=
 =?utf-8?B?elRpdEJ6UWo5ZVVhTDRYMmIyN0tNcWgvRzg1a0NmNVlCcTlUT3dlbDVzOUc1?=
 =?utf-8?B?YW1seGkwTWhtRWgvNDE1anB5SmdSaU9ld05CV1Z5Sk5iY01nNWlia2c0UWMz?=
 =?utf-8?B?RmlFaTRWelo5WkxrS1A3aVVyVjlCd0dpWDJjdmhzZ1RUZEFqSWtKY3pTR1Bh?=
 =?utf-8?B?UC9FR3h0UGpFRTFQV3o3eE5LMGNaVHRtaEJLcjJra2VHR1VuVXdkQ1Z2M2E5?=
 =?utf-8?B?ZnFickZtZ0dGMXE2R3lPNlpRYitrR1pTTUlBRTY2ZDJjUVpPbUk4MlpnWGl5?=
 =?utf-8?B?RU81UXBDaGQ1OXl4eGFQb1BVNDROampGVWtDdFpXZG1WYlFLVW1FN0ZMdlIr?=
 =?utf-8?B?ZHBUNzVLaFJEYWJjU2plemRiOEc0VHRzVEwwZnE5MExMQkoxZVpZT2lQdEtG?=
 =?utf-8?B?Tjc0Z3ZaOEl2djUwV2lac2syVlFBMDRwYmIrazFoS1l3MGZFeWNpeFlPaFVy?=
 =?utf-8?B?VXJ6eTFpSWxrMWR5UkQraVZNWVRieThMYkwxSnFOZGpyZjdxcGxmaUhxdXIr?=
 =?utf-8?B?b05vVXpvdWdCWGdkUmo0ck5BZ0V5a0Z1ZFFycExsT0VtdEY0OU53RUlnUDFs?=
 =?utf-8?B?SWVzQllkVUVySEgxVmNPQXB0SXJGcjExSDdmSTV0SXBIT0dWRk5MSGYzaFE2?=
 =?utf-8?B?eGZtYmJjOTU5bG1pa0xUS2Z0cUlnM2NSMkR2dWg0MGw0ZG04cC9LV0YwK3dt?=
 =?utf-8?B?SFUrejNIRDhYK1dUZGVzMlkvZytsNmdDcDdmb2QrTnU3VHVXR2NORnMzMyto?=
 =?utf-8?Q?2AUt1yeyvI7NYgD20xKGYA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C89F993A209AE3429306EE5543F67C74@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8727b40-fb2e-4a2e-0977-08ddd40845a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 10:10:14.9798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3URUJcp/UXJITM+ZvjMbLH8wSxrd2vtVATMLD1n2K7+rIY0wTLiZIZ6jKoXUHYV3hrcHxH0rUJy/ucxN1YHd9CRH/5gx5MNqDgkAa07uDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB4555
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGksDQoNCklzIHRoZXJlIGFueSBhZGRpdGlvbmFsIGNvbW1lbnQgb24gdGhpcz8NCg0KVGhhbmtz
IGEgbG90IQ0KRGpvcmRqZQ0KDQoNCk9uIDE3LiA3LiAyNS4gMTE6MzgsIERqb3JkamUgVG9kb3Jv
dmljIHdyb3RlOg0KPiBJIGFkZHJlc3NlZCBzZXZlcmFsIGNvbW1lbnRzIGluIHRoaXMgdmVyc2lv
biwgbWFqb3Igb25lczoNCj4gICAgLSBzcGxpdCBDUEMgLyBDTUdDUiBpbnRvIHNlcGFyYXRlZCBj
aGFuZ2VzDQo+ICAgIC0gc3BsaXQgQ1BTIGludG8gYSBzZXBhcmF0ZWQgY2hhbmdlDQo+ICAgIC0g
YWRkZWQgZnVuY3Rpb25hbCB0ZXN0cyBmb3IgYm9zdG9uLWFpYSBib2FyZA0KPg0KPiBEam9yZGpl
IFRvZG9yb3ZpYyAoMTQpOg0KPiAgICBody9pbnRjOiBBbGxvdyBnYXBzIGluIGhhcnRpZHMgZm9y
IGFjbGludCBhbmQgYXBsaWMNCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgY3B1X3NldF9leGNlcHRp
b25fYmFzZQ0KPiAgICB0YXJnZXQvcmlzY3Y6IEFkZCBNSVBTIFA4NzAwIENQVQ0KPiAgICB0YXJn
ZXQvcmlzY3Y6IEFkZCBNSVBTIFA4NzAwIENTUnMNCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgbWlw
cy5jY21vdiBpbnN0cnVjdGlvbg0KPiAgICB0YXJnZXQvcmlzY3Y6IEFkZCBtaXBzLnByZWYgaW5z
dHJ1Y3Rpb24NCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgWG1pcHNsc3AgaW5zdHJ1Y3Rpb25zDQo+
ICAgIGh3L21pc2M6IEFkZCBSSVNDLVYgQ01HQ1IgZGV2aWNlIGltcGxlbWVudGF0aW9uDQo+ICAg
IGh3L21pc2M6IEFkZCBSSVNDLVYgQ1BDIGRldmljZSBpbXBsZW1lbnRhdGlvbg0KPiAgICBody9y
aXNjdjogQWRkIHN1cHBvcnQgZm9yIFJJU0NWIENQUw0KPiAgICBody9yaXNjdjogQWRkIHN1cHBv
cnQgZm9yIE1JUFMgQm9zdG9uLWFpYSBib2FyZCBtb2RlDQo+ICAgIGh3L3BjaTogQWxsb3cgZXhw
bGljaXQgZnVuY3Rpb24gbnVtYmVycyBpbiBwY2kNCj4gICAgcmlzY3YvYm9zdG9uLWFpYTogQWRk
IGFuIGUxMDAwZSBOSUMgaW4gc2xvdCAwIGZ1bmMgMQ0KPiAgICB0ZXN0L2Z1bmN0aW9uYWw6IEFk
ZCB0ZXN0IGZvciBib3N0b24tYWlhIGJvYXJkDQo+DQo+ICAgY29uZmlncy9kZXZpY2VzL3Jpc2N2
NjQtc29mdG1tdS9kZWZhdWx0Lm1hayB8ICAgMSArDQo+ICAgZG9jcy9zeXN0ZW0vcmlzY3YvbWlw
cy5yc3QgICAgICAgICAgICAgICAgICB8ICAyMCArDQo+ICAgZG9jcy9zeXN0ZW0vdGFyZ2V0LXJp
c2N2LnJzdCAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgaHcvaW50Yy9yaXNjdl9hY2xpbnQu
YyAgICAgICAgICAgICAgICAgICAgICB8ICAyMSArLQ0KPiAgIGh3L2ludGMvcmlzY3ZfYXBsaWMu
YyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKy0NCj4gICBody9taXNjL0tjb25maWcgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIwICsNCj4gICBody9taXNjL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4gICBody9taXNjL3Jpc2N2X2NtZ2Ny
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgMjM0ICsrKysrKysrKysNCj4gICBody9taXNjL3Jp
c2N2X2NwYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjM5ICsrKysrKysrKysNCj4gICBo
dy9wY2kvcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE1ICstDQo+ICAg
aHcvcmlzY3YvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQo+ICAg
aHcvcmlzY3YvYm9zdG9uLWFpYS5jICAgICAgICAgICAgICAgICAgICAgICB8IDQ4OSArKysrKysr
KysrKysrKysrKysrKw0KPiAgIGh3L3Jpc2N2L2Nwcy5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxOTcgKysrKysrKysNCj4gICBody9yaXNjdi9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAzICsNCj4gICBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY21nY3IuaCAg
ICAgICAgICAgICAgIHwgIDQ5ICsrDQo+ICAgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NwYy5oICAg
ICAgICAgICAgICAgICB8ICA3MyArKysNCj4gICBpbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oICAgICAg
ICAgICAgICAgICAgICAgIHwgIDc2ICsrKw0KPiAgIHRhcmdldC9yaXNjdi9jcHUtcW9tLmggICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNDAgKysNCj4gICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gICB0YXJnZXQvcmlzY3YvY3B1X2NmZy5oICAg
ICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gICB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVs
ZHMuaC5pbmMgICAgICAgICAgIHwgICAzICsNCj4gICB0YXJnZXQvcmlzY3YvY3B1X3ZlbmRvcmlk
LmggICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc194bWlwcy5jLmluYyAgIHwgMTQyICsrKysrKw0KPiAgIHRhcmdldC9yaXNjdi9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIHRhcmdldC9yaXNjdi9taXBzX2Nz
ci5jICAgICAgICAgICAgICAgICAgICAgfCAyMjggKysrKysrKysrDQo+ICAgdGFyZ2V0L3Jpc2N2
L3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAgdGFyZ2V0L3Jpc2N2
L3htaXBzLmRlY29kZSAgICAgICAgICAgICAgICAgICB8ICAzNSArKw0KPiAgIHRlc3RzL2Z1bmN0
aW9uYWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIHRlc3RzL2Z1bmN0
aW9uYWwvdGVzdF9yaXNjdjY0X2Jvc3Rvbi5weSAgICAgfCAgNzggKysrKw0KPiAgIDMwIGZpbGVz
IGNoYW5nZWQsIDE5OTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL3Jpc2N2L21pcHMucnN0DQo+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGh3L21pc2MvcmlzY3ZfY21nY3IuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9t
aXNjL3Jpc2N2X2NwYy5jDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L2Jvc3Rvbi1h
aWEuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9yaXNjdi9jcHMuYw0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY21nY3IuaA0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY3BjLmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS9ody9yaXNjdi9jcHMuaA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQv
cmlzY3YvaW5zbl90cmFucy90cmFuc194bWlwcy5jLmluYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvcmlzY3YvbWlwc19jc3IuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQv
cmlzY3YveG1pcHMuZGVjb2RlDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9u
YWwvdGVzdF9yaXNjdjY0X2Jvc3Rvbi5weQ0KPg==

