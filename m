Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB0CC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfBT-0006YS-9G; Tue, 15 Jul 2025 08:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubeke-0005r6-Jx
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:27:19 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubeka-0008Hr-G3
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1752582432; x=1784118432;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rqnyUGrpkcIsGM2Em2QaDz2oWGEZ530UbFNaaSmynZY=;
 b=KcbPJWYQ/QAyQg9PPHPQSHCII2KiyFCdQd0zVO8xPJp4MWSZ2k7XqjSy
 XftER5OPVQm1gG2+gflCvlz8S0XrZio14YEz46BWLTOa+HJP9QmVY1X78
 AMzlw8i9BpGC81yiimmlA0DBDniV9zG0yykSFFAlGvp1E6deZ5dP26ID8
 ADjI0cskJQ70JLf5MD7T7tTakzSHRw6/7YDbo53rR/QD1sxB8G+YDP4wk
 ac3r2K/pUUwAfdEMkKqlOflYXM8XORRCCt+FA3WuAjTpwhYMoRL9fnwHq
 eInw7y3Gxf/MVBQ2742Twml4HGrO2AIJ3WEuRXcBrHCdHodjFTquJK/ed g==;
X-CSE-ConnectionGUID: qXiFn/p0Sqe6whfedmwG6w==
X-CSE-MsgGUID: opxg48s7RV2sGvjTwJN7Ew==
X-IronPort-AV: E=Sophos;i="6.16,313,1744063200"; d="scan'208";a="40358067"
X-MGA-submission: =?us-ascii?q?MDHRb5yo15MlcJPj9x4RcE6yPec8V+1oFFGBUo?=
 =?us-ascii?q?/YChAUuy6hQ7rgql4DIQGK4EvP1BOeMmC+jVHLrffWN8w/6JiIWrhmBx?=
 =?us-ascii?q?wcvYenw97ZzZ6H8nhxVLqFmgVDlfKQHlSQcf0cGEmwh+K9fTRJUtSq5d?=
 =?us-ascii?q?p2cLoVdJKjVi54yb0Z6IFIWg=3D=3D?=
Received: from mail-northeuropeazon11010016.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.16])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Jul 2025 14:27:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B27YSQbydntd2uuziDRZRp/xQ4MeNQquybwu/ed6oGAm9MfXTHejBIk/G55U1H91DnK9Trj7B5waczNYXpEKISbWe7tmRk8+D01OXp+JF/FVjIuag59q++iH6JrH564MCYXM/3RoqfscjfTpyWxWWC1N3DBMH5x4kiF67TKU8T1VibyBjRTAM8vgx5Zh508WybDa/uno5xMxc+PgabCsN91RUnZJEsH1Z5DeabWsKx2AM2KROO/Y6ZcKJ/oPoJWDc1tNKWIjCpANlgm02Zxl2DBuRmdEa4zPPwoqzqZLAsaiPldPM6+08GptRQtkRQVMntnaPcbrBD521Od3eWcI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqnyUGrpkcIsGM2Em2QaDz2oWGEZ530UbFNaaSmynZY=;
 b=jpB/qnQ8Kw6dHEAF1kpaQzZC2n2n8Sio40X1kxBEYvKTiC1RljX8VRMlmq+iAEolcfAke3OfM7XxLZ+maP89HXuC00h+9lnSM7Z1KVt6lXInSLSM1yn6xuyPxBrwbSFS4if06SVWlEVw26IM9KdgIzOYdyZfMChPN9/Ewy9SBmNW565b/zTAB14hizOvvf5BRyeX1DSVKtWeR4PyRZC7nvJ5PViEdQMb0QQUydbpdUkRXligEffo9VlmmYhxhZHDjsPSRFInLFZAPVDRrC+912/FKxWeyu7M6VPKPN3vsLZ7miPuSB9AYyF0+5w91MyH865me3xUylcKp/ZijSKAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqnyUGrpkcIsGM2Em2QaDz2oWGEZ530UbFNaaSmynZY=;
 b=qQqjPa0iaXpoleFFQUDWf83wGqU1Uk1SRUNV2ttAptfsmCRVk6kYW5Rsq91k385Lv1/SSvm0YEbrGB0yYyvizOg1BXhkxgBoLhYGJHL8T386FHrT8joryiT4d5HLLpwVneCq/kH32kgu8SlW/Fo07MYZ64TOrWUnJ72vnnBKsByZZFRPjgsWVdyRiLq87bb+xT4tiUEbcSOjztwhOGvLG4f4pyWiGaagfsJeTXFO950dSnd4BF2qspq9Jvti6OISuWJVYnYqxRWJNj021j3fSWVsWlLPrSr+77ipRxejVsKq4d3dlS1J4uZyG/KlTIc0AjCtZqZf52c0m/woW837jA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7546.eurprd07.prod.outlook.com (2603:10a6:10:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 12:27:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 12:27:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: David Woodhouse <dwmw2@infradead.org>, Konstantin Belousov
 <kib@kib.kiev.ua>
CC: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 "jhb@freebsd.org"
 <jhb@freebsd.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Topic: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Index: AQHb9JVtonfMGrKluUCpVZOjgLqK0LQxrd+AgAAlOQCAAE5sgIAAk+0AgAAmEYCAAELGAA==
Date: Tue, 15 Jul 2025 12:27:05 +0000
Message-ID: <d84bdcab-3d2e-4731-a9aa-b8094fbaf7e8@eviden.com>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <7cf6b91c1e1ea8b50d116f738215bcb55732b214.camel@infradead.org>
In-Reply-To: <7cf6b91c1e1ea8b50d116f738215bcb55732b214.camel@infradead.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7546:EE_
x-ms-office365-filtering-correlation-id: 1ed6bf24-8f60-4c8f-8f2e-08ddc39ae900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QVU5ZXhOQjgyUmpPMmtibnBkODcyM29TNExpOEZqemJPTGw1ZW5Iem53NHJu?=
 =?utf-8?B?MTcycmp1RWRqaFZwMzB5c3R5ZkQxOVUzRFpUM1RVaVdUNU1RbVhrT3pYc21p?=
 =?utf-8?B?Z1dEOTNjU2xuNnpMUTdRWUhlN3FlNW9Zc05lWXF3T1Q2dnpkUldtclBublNH?=
 =?utf-8?B?UHRPNDIxN2VUOEo3azhFOXBsR2hhc2pjZ0RUc25aYXhodHVzaHlyeHl5ejBB?=
 =?utf-8?B?WVRTVWR2VDhmWEkzYi9mcnNabldZQWR6YVYzbnhyRXNOVzdoRStTM2J4Mk94?=
 =?utf-8?B?cUM4emg3a08yTW01dDNoOU9FTGNMakhYMFN1SzhzUXRkK2o5Q3ViWEQ0UXkz?=
 =?utf-8?B?aktwZ3pXTU1hMTd2amt2d1l1dGt4WVVsSklFbTBobVkvenRMU0NMcUFYT3gx?=
 =?utf-8?B?N1E0eDhBQ0k5aW5qbE95b0l1blJ0a3poK2lhczhVd05PWDhCR013eXNvdk9K?=
 =?utf-8?B?YXNnZGVmS3gyc3NlNE1ROWlkRDYweHlOakM1UXViTEI4UTZUZ1BmNGVjQ056?=
 =?utf-8?B?WWhRQjFENVAwemtWblY1a2lxbFJMMFJLY054WjdXeXNxY29IaFNSbUpQbXVE?=
 =?utf-8?B?elV4UE9zdmc3SnZ0M2E2NFFjbXBFUWZ0U1VrU0dOY0NpRFNSOWw2TCtkdEVq?=
 =?utf-8?B?T1dqSmlWQ3VnRGVtbkxIKzgzUTJxM0o1Z1ZpZE5KZnB3a1dDbURKOEpFdExF?=
 =?utf-8?B?L3hGL0NtaGF2c1F0V1hqc3p0TlF2RTM0aWx3MXpLcndXVVRSUHJQYVdtSUQz?=
 =?utf-8?B?UTRXNlJnTW5WQzFpUEZNMW5qbjNsME9nTHlFWGtLaVYzVG1NcXJqYnJsTFRi?=
 =?utf-8?B?dDViNDdJQmtzbXFiSzV4eDVyN21UQ2R1YmJZcEtpQWNtVncwdXVtOTRGRG9j?=
 =?utf-8?B?Z2Q5elM4UkVVUHFrQ1poZTlLTHkwZUgxYlJjZW8yVHZoR2g4Z3NIOFZSeE5Y?=
 =?utf-8?B?WW1pZmdHcW5iSDZsM2dHVi9RYXZ2SjYvUEh6RlNWWUNzUTBhVUFWRyszdGIr?=
 =?utf-8?B?OGZNeTRlUWVINFY4ZVN3SlpMcEVNSDBLTXk2c3ViVEFKSUVSY0hqWTVqUnFZ?=
 =?utf-8?B?bG5qMVF3eFVjZFBEWFhjdkozUnVEUXZxVGFjKzlVSXcxZEJIVmVhbWFtRzFI?=
 =?utf-8?B?Nk1NZDFDWkpIcnZ5WWhLeVArcHZiY1E0RFZpVG4zVW1Jb080WEFRNWNtcStI?=
 =?utf-8?B?WlczMk5CTFl0WVFmaThySHRtdkNmSFIvdmtrZ1NPNkU0QlF0c1J4SFpNTmxT?=
 =?utf-8?B?c3JxSmRTaldnZG5VU01KVG5PQk1TMWVQV1VMVUZlbjBLZWdYUEQ5bW9BeTJH?=
 =?utf-8?B?aDFMNGtwZWNtTWZSeVdudmNYOVdWNVJvL3hndE1scjU2ZS9jWExiZlA2NVhl?=
 =?utf-8?B?ZVNhSXBFakd2TG9UZXpCdzVCMTJlRG1ZQTRZSW82OXRFN3BhYXhacm9WcElN?=
 =?utf-8?B?VnRXQlhaRkIzcXBISnF6djlKc0RQbGJ3WUthNHA0TWhES0JLL0ZGSks5OG5v?=
 =?utf-8?B?R0lOU1laWlVrbkFrL05qaE9xcXdweDl3NFhLZFNUMk93SXArYzdHMGNBMVNT?=
 =?utf-8?B?cVlTc2x6RWFheEgyUkdjbnl1emJUekpCVVU1ZzZMZi9LY3VmdGI4dlFCOGEw?=
 =?utf-8?B?cXQyWnZ5RHZhT2YvRVRGUHZvR2FVZUZmemZtakp1VFFIZThyS1NhMFNVQUdl?=
 =?utf-8?B?OTZqbXBwVi8xRHZvWU1zdnBCSGJSTVN2YlFSMWdLWGV4NWpraVk1Mlo0VzBC?=
 =?utf-8?B?b2Y0c25FazBIQTRmck55ZmJEVmhxSGtlbE8vMHl3RDgyei9MMVBVR3ZobVd0?=
 =?utf-8?B?REJRS0R2ZUZBeUtYb0xSeUVXdk9MaUdMd09FaU84Z1ZQTHFick9EVytDeXlp?=
 =?utf-8?B?Z2RrMmxNYWVneXVxSldpakg1SVYwTDFIOUxjNVk1RHFMODl0bU9ScG90M2g5?=
 =?utf-8?B?UVhtb1RzVmQ3RjFycWxoZ0FLVWJKNEFNS0lHSTVRaHFHNStKby9pUlh1TDlM?=
 =?utf-8?B?RmRZTmhVTS9BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHpwbnAwdXdrY0Y1TE1DaGIxemNoQXNYdW9kbmxTMmRjNzE3RDVUck41dEdW?=
 =?utf-8?B?VFhDd0UycUtRWXpHcHQ3UUdpSGNxNDlrWlJJTTFEMXo0azJBSGJiTldDTVQv?=
 =?utf-8?B?VTlqNndwVURxN1M1NThwbHNVaUFjb0pGbGpRZmdXNEJVckxqOHRYSktIc1RZ?=
 =?utf-8?B?c0tMTjRpb0dYT21UN0NaOEJmL0pBMU9CUWdLNFQzdkJsOXZ6Y1hFeWpQc3p0?=
 =?utf-8?B?azhSL2trUEhOc0xJd3hnRzVwRFd5TDNwcHMwdElDMkRYeXMxRHpzNTh1U1pr?=
 =?utf-8?B?S3NuWmVyUHYvaEFyYmdIRFpucWw5MGJUc0RRakkwMkN3UWlYeVA3REpjeWpH?=
 =?utf-8?B?SEF5Y3p2VmQzOVRVWkx6QnRnYjhsVmdrVUt0NXlGYmowT1V4Vy9lR2paREpn?=
 =?utf-8?B?K1AvRjM3TEgrdFNWWHZ5bnMvOFAwdkJvWHpKaW03Z241czlEd0JiendyNXB4?=
 =?utf-8?B?QUF3MlRCeDBXYkZ2UUYxWU4wYVNybzQwaSsxVDVIRDhtN3Jzd0Vqd2s2MFVN?=
 =?utf-8?B?Rzd3WGdRcFIwZnVaTzZoM05LcllNV2hobXl4M0NMbmRVdWVSVVVrUkp1bStW?=
 =?utf-8?B?VTNwcU41ZVdmSlpjOVh4NlBVWDZBZ1J1SHV4eDJybXJ5QzV4YUpYZUZ2VDJ2?=
 =?utf-8?B?ZWRxYmxSWTFkckdtdUs0Zm1kSDFXeTVTa2dKZWQwWC9GMVhBMWd6Q2d1SXRv?=
 =?utf-8?B?bzNudXF0YXRkY1RJc3dERE5kZTNOMFJxSkEyKzB0b0J5cXdvWmZWQmF2MEtK?=
 =?utf-8?B?cjNyWko0VG5XR1VTekQyUFNua2lzekk3YXhWY1phN1BCeHpmRklXR2NsTWRi?=
 =?utf-8?B?NWJEZ1Z3NmpybWE1Q3EvVEMrRW01OXJLd1ZVdGJ1TXlzNC9oaVdDSXc2dnRZ?=
 =?utf-8?B?SENSVzlEN21sK0U1M08yOWtHbmY2NmlUZStJSVlIbU5RbTVkL1MvaFM0Yjg1?=
 =?utf-8?B?MUw4UHpvOUdoNmtwQlRaNzdpejJvTXBtQTZUQU92UjVjMUx3MlhEcjFac1R5?=
 =?utf-8?B?dkRHVSsvQlladHFEbW9zelJyUTZuNUh5Qmx6cEtQcTJud3NEckVJR1ZXNlBm?=
 =?utf-8?B?a3JwWENQZEV3enBIVkd0dkd1V0J3L0UzQkZweWlVbXhsYUFJZkpIV3BXS1hP?=
 =?utf-8?B?YXMwcWxkWnRaZ045WmorVkgzVEVpSFFOZzdXZ1F6c0pMQ05GTGlkdHBvOGta?=
 =?utf-8?B?VXFKUzBwdHVTWHBhOFZOT2wyWlNWZGtuUlFaMW0vYUFlUzRNQkF2Yk1vaHFt?=
 =?utf-8?B?eUpnblQ3NnhpbDltbjFmc3dyTEN4ME8welplY2lNSXdEQ3Exd3NmMWQzcFRG?=
 =?utf-8?B?QlJBR2w3LzR5NGxVU1NodS9jcmtlTFUwOXJTS1k3TU9raEc5a1hLOU5QazQ4?=
 =?utf-8?B?N0k2LzVpdmhESXhwY0wxcXFuV0pjTzNBMUhWenhpOWpnVFowQ28zNFdvUldE?=
 =?utf-8?B?bldFR0lRRjJhbk1VMTY1U2h2N081UTJnVEQxQWx6SVQ3cmxTdWYyUzRQNERE?=
 =?utf-8?B?bzAwUytGMGMzQisrSm1McitTbXBobEEvdDFBMnpoYllzV0VkelVGVzAxOFdZ?=
 =?utf-8?B?bTJRQU9sT0JON0VJSHIyTy8ydGtZa1B4TGRuT0lNV0NQM3ZWNnRqSmpkWDFM?=
 =?utf-8?B?WGRFWFFySnkrbUhQTjFsa3FUL0hHbkErQStRYnRZenpjK0hobGlvRElvUm9K?=
 =?utf-8?B?TkhiSUlOQVppVVpLM1UzT2NtY00xMlhmWFI1TzZpRnNrdm5HSkl4cW5xM21W?=
 =?utf-8?B?Zks1K05WNFpMdzFwNXdqYTNyaVFoQjVyR2tZayttTWY0SnhFeUxmeE55R2t2?=
 =?utf-8?B?SitRS05PMEIzUENTakJBb081SisxTklJc0RPLzNYR2NHMFJmczIrU2J5Wnlj?=
 =?utf-8?B?dElXWXd4RGw4alF4NFhKTE1nWVE3OHlKRmQrU3IrSVJCMndZdFVJR2tmczB4?=
 =?utf-8?B?MjNwdlQ2OG4xN29WelZjKzhjTmZac0tGbXFQQmJZa3B1Skg5aUNWdllNUEdQ?=
 =?utf-8?B?VXp1OFo4ZWdvSmlyMEdWMUpIQ2NWR0FiUlZxMWxNTnRhckI2cnZ5TW9mMk5t?=
 =?utf-8?B?bUc1TmJERWZJRnJ0ZURWdjBjVFVuUzlFN2c2ZHFPVkdKOCsrUmovRXVqTk0y?=
 =?utf-8?B?RjU0bWtROURyMHZYTUtjWXFCeWZyTjN1OWZVQ3lqTWtiU2dpRzhoV01FQzJt?=
 =?utf-8?Q?ueABZPPOA2ZZ4UUJHjKXHhQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60C2030A7A676E47AEE8D480259AC9DC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed6bf24-8f60-4c8f-8f2e-08ddc39ae900
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 12:27:05.7442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9fdVBhMaP5kb/0RQRqZXW7tyVBesYuhJ7+JCuHqdF2I/QioumGp83j6ac5oNlH0MdyigQ6UYpzJrtqfx4h/5OKdpLOr040jjMRa17d2bnLpil8gjMEFhLEruUcKlje1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7546
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE1LzA3LzIwMjUgMTA6MjcgYW0sIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4gT24g
VHVlLCAyMDI1LTA3LTE1IGF0IDA2OjExICswMDAwLCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3Jv
dGU6DQo+Pg0KPj4NCj4+IE9uIDE0LzA3LzIwMjUgMTE6MjIgcG0sIEtvbnN0YW50aW4gQmVsb3Vz
b3Ygd3JvdGU6DQo+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFj
aG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KPj4+IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZQ0KPj4+IGNvbnRlbnQgaXMgc2FmZS4NCj4+
Pg0KPj4+DQo+Pj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDU6NDE6MjJQTSArMDEwMCwgRGF2
aWQgV29vZGhvdXNlIHdyb3RlOg0KPj4+PiBPbiAxNCBKdWx5IDIwMjUgMTU6Mjg6MDkgR01UKzAx
OjAwLCBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gd3JvdGU6DQo+Pj4+PiBIaSBE
YXZpZCwNCj4+Pj4+DQo+Pj4+PiBPbiAyMDI1LzcvMTQgMTY6MDAsIERhdmlkIFdvb2Rob3VzZSB3
cm90ZToNCj4+Pj4+PiBGcm9tOiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0K
Pj4+Pj4+DQo+Pj4+Pj4gRnJlZUJTRCBkb2VzIGJvdGgsIGFuZCB0aGlzIGFwcGVhcnMgdG8gYmUg
cGVyZmVjdGx5IHZhbGlkLiBUaGUgVlQtZA0KPj4+Pj4+IHNwZWMgZXZlbiB0YWxrcyBhYm91dCB0
aGUgb3JkZXJpbmcgKHRoZSBzdGF0dXMgd3JpdGUgc2hvdWxkIGJlIGRvbmUNCj4+Pj4+PiBmaXJz
dCwgdW5zdXJwcmlzaW5nbHkpLg0KPj4NCj4+IEFyZSB5b3UgdGFsa2luZyBhYm91dCB0aGUgb3Jk
ZXJpbmcgY29uc3RyYWludCBtZW50aW9uZWQgaW4gYnVsbGV0DQo+PiAiUGFnZS1yZXF1ZXN0IERy
YWluIChQRCkiPw0KPj4NCj4gDQo+IE5vLCBpbiB0aGUgdjQuMCBzcGVjIGl0J3MganVzdCBiZWxv
dyB0aGF0IGJ1bGxldCBsaXN0LCBhdCB0aGUgYm90dG9tIG9mDQo+IMKnNi41LjIuOC4NCj4gDQo+
IFRoZSB3b3JkaW5nIGluIMKnNi41LjIuOSBpcyBldmVuIGNsZWFyZXI6DQo+IA0KPiAiVGhlIGlu
dmFsaWRhdGlvbiBjb21wbGV0aW9uIGV2ZW50IGludGVycnVwdCBtdXN0IHB1c2ggYW55IGluLWZs
aWdodA0KPiBpbnZhbGlkYXRpb24gY29tcGxldGlvbiBzdGF0dXMgd3JpdGVzLCBpbmNsdWRpbmcg
c3RhdHVzIHdyaXRlcyB0aGF0IG1heQ0KPiBoYXZlIG9yaWdpbmF0ZWQgZnJvbSB0aGUgc2FtZSBp
bnZfd2FpdF9kc2MgZm9yIHdoaWNoIHRoZSBpbnRlcnJ1cHQgd2FzDQo+IGdlbmVyYXRlZC4iDQoN
CkZpbmUNCg0KPiANCj4+Pj4+IEkgdGhpbmsgdGhpcyAiaWYgYnJhbmNoIiBjYW4gYmUgbW92ZWQg
anVzdCBhZnRlciB0aGUgaW52X2Rlc2Mgbm9uLXplcm8NCj4+Pj4+IHJlc2VydmVkIGJpdCBjaGVj
a2luZy4gSGVuY2UgeW91IGRvbid0IG5lZWQgYSByZXQgYXQgYWxsLiA6KQ0KPj4+Pg0KPj4+PiBX
ZSB3YW50IHRvIHJldHVybiBmYWxzZSBpZiB0aGUgbWVtb3J5IHdyaXRlIGZhaWxzLCBhbmQgdGhl
DQo+Pj4+IGludGVycnVwdCBoYXMgdG8gaGFwcGVuIGFmdGVyd2FyZHMuDQo+Pg0KPj4gUGVyIHNw
ZWM6ICJIYXJkd2FyZSBiZWhhdmlvciBpcyB1bmRlZmluZWQgaWYgdGhlIFN0YXR1cyBBZGRyZXNz
DQo+PiBzcGVjaWZpZWQgaXMgbm90IGFuIGFkZHJlc3Mgcm91dGUtYWJsZSB0byBtZW1vcnkiDQo+
Pg0KPj4gRG8gd2Ugd2FudCB0byB0cmlnZ2VyIHRoZSBpbnRlcnJ1cHQgZXZlbiB3aGVuIHRoZSBE
TUEgZmFpbHM/DQo+IA0KPiBZZXMsIHdlIGRvLiBUaGF0J3MgYSBxdWFsaXR5IG9mIGltcGxlbWVu
dGF0aW9uIGlzc3VlLiBKdXN0IGJlY2F1c2UgdGhlDQo+IGJlaGF2aW91ciBpcyAndW5kZWZpbmVk
JyBhbmQgdGhlb3JldGljYWxseSBnaXZlcyB1cyBwZXJtaXNzaW9uIHRvIGRvDQo+IHdoYXRldmVy
IHdlIGxpa2UgdG8gdGhlIGd1ZXN0LCB3ZSBzaG91bGQgc3RpbGwgYmUgYXMgc2Vuc2libGUgYXMN
Cj4gcG9zc2libGUuDQoNCmxndG0NCg0KPiANCj4gDQo+Pj4+DQo+Pj4+PiBidHcuIEknbQ0KPj4+
Pj4gYWxzbyBhc2tpbmcgaWYgVlQtZCBzcGVjIGFsbG93cyBpdCBvciBub3QuIFNvIGxldCdzIHdh
aXQgZm9yIGENCj4+Pj4+IHdoaWxlLi4NCj4gDQo+IFJhcGlkbHkgbG9zaW5nIGludGVyZXN0IGlu
IHRoaXMgY29udmVyc2F0aW9uLiBRRU1VIGN1cnJlbnRseSBoYXMgYQ0KPiBndWVzdC10cmlnZ2Vy
YWJsZSBjcmFzaCwgZm9yIGNyeWluZyBvdXQgbG91ZC4gSSdkIGxpa2UgdG8gZml4IGl0IGFuZA0K
PiBtb3ZlIG9uIHRvIGZpbmRpbmcgb3V0IHdoeSBGcmVlQlNEIGRvZXNuJ3Qgd29yayAqZXZlbiog
d2hlbiBRRU1VDQo+IGRvZXNuJ3QgYWJvcnQuLi4NCg==

