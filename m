Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9561606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WsKFx+wF;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tiJo3Z7R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiXb-0002wN-1K; Wed, 21 Oct 2026 22:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiXY-0002vd-M4; Wed, 21 Oct 2026 22:28:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiXU-0003XZ-FT; Wed, 21 Oct 2026 22:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792636098; x=1824172098;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8NMAHqJVA8DyDHvqXi9o37bpWKFAvQ08xfqEWrM57PY=;
 b=WsKFx+wFJDw1q69cHQIXpucXm8oxEppG3vbhhDO6v8my2jM6e3wg9HNz
 vN4B1zZFEAalBVkgkJi3ikCBH32mP8elWWF/5PbuC+fKciHeQtR/qzw3v
 ozppoDGBB9gKzM5mVQHL4hKaH+hyRjpEX4QoxJxRh4g7vA4dYfgwefMSG
 J8oKxgaCU/AbLck/WyEjXqChZY7GIb2eRIyASR3DnaGh/7nOUS8DB95YC
 qiZNwOgNMwls6+05k6BQCIOE7Ei+rXi7tXFVyVeESkia2fnwBUQtXPtSb
 gx4RSXLUHZOTePIjL03rrbwQiteYrUsf3Dfpwg2RJH4wnLJjDD/4U4oQu g==;
X-CSE-ConnectionGUID: n5UhtnBpQUS+pd8iU57M3A==
X-CSE-MsgGUID: YsfXgm5wRUmhMGRrsHtK2g==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158698875"
Received: from mail-westus3azon11012023.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.23])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:28:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOdkJtRo3xoH08K64NPLIpuKUQNMKf1/rdS7WVLM0cROipq+/6/LvIyMoG8CgpIV733myQac1pFBqcKqY4+Rc3tOgJnSRpEhFHMUoHxYxQtock1/o0kz0Jk2OXJHJEragX+Mrk9MRk7aj8bry7qDKv+sGZo9ckSrTgjnyvV9Z8+L5ezYOk4eUvP6eGsU0zL3pDMmMZr1FynHBvFqTwkmm/TupN4LSQNwl06SoOvy99d4Ws+Tm3cmdX5z9cRU+KEikdNwi5+GRLInfPE8zRhxOgaZ7oJdV0YWlOUk8/IO+a5qSJ+f3THq970tr9agQZWp6DaMS2iSiBM6Z/fe2HT/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NMAHqJVA8DyDHvqXi9o37bpWKFAvQ08xfqEWrM57PY=;
 b=BM0e9dNljPlirN7J/9pE/IrjW33LBF3w2QBzxTqPPjI3OdeNGdd62HD0vlV+NkkpuEhKC1Uu0Nda5ylEBa890XjWOhQtyQMB1HO5Nh6A54Rv4jh0CO3/DMCtPO9Orowsp+rDa9zc8s/Pci7emsYuk/l9gKzmN7UdphDnEqas6oDDrLLp+GBIa8TpT/8EjiJaUu25hcPTkPbNcFKe4RuwEpqqTBkjlJEdmg99WUCvJ0iALhV5mFtyf8JPj7BpQzXVGAQUsB05XTWhXmm8Y1EH0k0ca9eMzYiDqkbnQjPNrFrIfMAyhVoR1hC8LaN3Wtk3z/0/Pa5O6iN8JibzO4RMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NMAHqJVA8DyDHvqXi9o37bpWKFAvQ08xfqEWrM57PY=;
 b=tiJo3Z7RIRYudAjm6RVA/CMKM4JjC4eqGBGx1zCK9L3Y7DKRD4kd3ev6rrNeqE7VYyTr2bwaeHSGmdSddhEEJnoDl6GNUIunp3TDz/A9XyHntgAaymYrv8GpAsFWaBlAdlXUwsDlxQwnlpBiseAdDrRS29YNhMuUD3v5vksb+dI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN2PR04MB6637.namprd04.prod.outlook.com (2603:10b6:208:1ef::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 02:28:15 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:28:15 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Topic: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Index: AQHdYYIZE7nDV5di902s7yZQvCW9QbcI1vYA
Date: Thu, 22 Oct 2026 02:28:15 +0000
Message-ID: <4ff27b51eb51fff64a8372e61dc51a8f448d0daa.camel@wdc.com>
References: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN2PR04MB6637:EE_
x-ms-office365-filtering-correlation-id: 4cebc527-6bab-4cef-4f07-08df2fe4206b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|376014|19092799006|38070700021|10067099003|56012099006|11063799006|261009223027099003|18002099003|22082099003|6133799003|261021121427099003;
x-microsoft-antispam-message-info: p9Odzx++oTMaRJSLJwvBLLp3su+crzIJHiC2s3P6sZ2BI6z0Ye0/vdf4dgBKIBG58+ShcUDI63JBhMQPI/IBXPw8tHeRNA4z/i1RQ1kn/xuC/U4CTq+tXyCMtOx3OEqD03FsRTKsrbdPnZKDSCXDceOJHS5pMqt8craAcVfOWYuVZNAnVg1B60Ygbtds0L2y3fGxxUm/TtfM822jRjtjVQQlv9JJ64DzYHAQzuxxOImv/VO1YTx9Qv+6vddnZFem4OX/3z+X5uiwK3/+oHbysYAYUy4kzoAYcZwDAf8dgBO1SUD0Rn+3uKXlPJXXgLUkVI/OJWubNxB/Fzy3CbZvfd9ibOHNP5gy0MGqhc0HIj3gYLA9GpxrClKUscwGHrN9MLa7vU+xDr6QcR5Z2MEsf7+Kr/2P2VQWJ/kx3DMt8lORD/hpH8WB54PPg9db3qfIZ9bCmPtNgPacP+1QtRhnOT6GgERtF5lTJBZrr634YaMeehp/JBmCCUUv2gBWFWZSeoIAcgqhGuVOC7Kv6izusFiEG5NrndNH2B6a2dvsqbWXiRLMikH3ThgA1zgi4IPQdlm6v/uiVByBlWb8RvYEnH+hZSDt+EX/beK6sECFvKDVIl/fqnt8SJfjgSShtyDFlmKI3ms/fRN3jehDaeJW1ip0YxBNtkeKe6lGRXn7z60=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(19092799006)(38070700021)(10067099003)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akxXOEE4MVBtejUxdVFhYkE2WnRKRVhKQktqZmVOTkUwVko5WThVQUtOVTNY?=
 =?utf-8?B?WkpsTXBPc1dvQm1xMHFDSFlnR0ZNV3JDOFEzQXVXNWZDTUVKVE9kOTkxbFVM?=
 =?utf-8?B?TG5zM2txTUZpUldLc28wbkhUbEZud29UM0srYThOUGlzem5wNDJnMWlpUnI3?=
 =?utf-8?B?Y1B2ZDIwbThtdlZHN3JrM0YzSlFoTVZWL3Job0VqQVlvUm1yU3MrN052RzBs?=
 =?utf-8?B?ZCtYRXV0WUZhaFRnU00wUWJ2UkwwV2Jad3JtTC80WHN5NUdKb2pmOTZXWXpS?=
 =?utf-8?B?VjY4RTBjbWdHTzFMNCtGdjgrNm42M3k2NlgyYmdUWXRSQk05a2lub00yVEFP?=
 =?utf-8?B?MWYwUVlHcU01OE1QbDkvU2kvenFSNmd2ODByUE9DaUYxRzVNMEFZVFV1ODAx?=
 =?utf-8?B?WHRzTXd4Qm1INEhjUjRtVWdVcmVhMGFTbDdURUlnYnlDV0VBbzVXYnRzMFh6?=
 =?utf-8?B?U05WRDVUaHppOEFrVnZhVGtIWTVVZ0NUaDlWSjR1U3c2R1krNTZHWWMzanhl?=
 =?utf-8?B?QmpWdGZzeXRmTUdRQ3Y2YURUMWtJa3RjaHppNWlWdGFsOHlYeE9nMkRFT09a?=
 =?utf-8?B?UStLemRWVVNPZm55WDVMaUk1ZldNNUhoSllVTjZPNUhUNXErbXlnVkkwS2Q2?=
 =?utf-8?B?V29QZVhrWUN4a1pHcm9DQ2ZQc29xbWZhREovZm1ONGZOUlBEaXhkZU4vMUpp?=
 =?utf-8?B?eHoraXBtckhaMi8wYnZ6TFR1cXM1RDRvcUdCNkRnTWZFV1lOQk5xVnZlbEVQ?=
 =?utf-8?B?a0hBdWUyN09MOGErTFlITEIzMWZGYUNGQ1V5Kzh5bzJNWUliYU1OaVlqdU4w?=
 =?utf-8?B?OHZaeWMyVkZRT2pCYXV5VnM5VXRVUXhzUXZjczlzbmtVdzRzNzNzVFJ2Y0E2?=
 =?utf-8?B?YkF4M2srVWJlMkRIRVp4cUJNQ2IyM1d4V0wzOFVXbGJhOHBvcHFFaU9QdHJq?=
 =?utf-8?B?Zm9ONDYwNFNXR25aNDY2Z1pVckVWRlE5NmxtdFlGVzFXWDUxRjdweC8wUjdW?=
 =?utf-8?B?YlBEZll4MHVpVktLcHU2VGt5R1hnQTFLYjY1aEE1cURmSWV4dm5xZDhMdWtS?=
 =?utf-8?B?dFQ4NEdueXZmaUs1QnpwWWRyTndVb3hmd3FycEhBSm5URjZNeEZMdWlUdTRj?=
 =?utf-8?B?UEZUUnAxcWRZU0JqT0g2TkNQb3ZUSFcxa2grejgrY3hxNURUZkE1Q1E3WW5p?=
 =?utf-8?B?aGY1dDlNL0hxUG5YajRJK3JYMExPWFVJOUswY2kxMGpBdTJINkNITTBSazFQ?=
 =?utf-8?B?WnNaczlhK3hEYkg0RkpDZCtJVEhVN1hSREk3L1ZQWWtDcHBsZ0czRmNtc2Vi?=
 =?utf-8?B?TlFjbnlZY2p0YWVVS0FselFMSndSdzJabTNzRGVHemhqWTR4RXdvRWZKTG9v?=
 =?utf-8?B?WkIrWDlMYVFBTkN1Sk9OeGYxSnFaam9lUGp3VG4wRUpGVFlmbWpBOFdITXhE?=
 =?utf-8?B?NjR5UHNtaU9tVWE4SzErVnBFTE5tZkhkejlLcEhzQ2gzK1BDSWlveDlReVFM?=
 =?utf-8?B?elBCbkFFaHlFMFFuT3JFSmUxNFgrUk5CTGRyOVQvYmlNSFlVdFJ4amgwcnU0?=
 =?utf-8?B?REY2dS9BTzF3QWNUQnp1UlhzN3NURWJaTlN1UG5teFFVTElmTE4yd1c0MFVX?=
 =?utf-8?B?SEkvM3A4Yk9mazhFdzB0emQxUmkxajNqcDZrQWdNMzJIdEU1NWpaMW1uZ0VT?=
 =?utf-8?B?WTRuai9pVUFYdWNKSG1XUVBnaFlEVHMyUWtPZy9VWmt1QSt4aHA1K0FYTXdV?=
 =?utf-8?B?UDkxbEgveCtQVWN5RXdSanJpRllMMjNSZmRFUkZlekpBTEM5WUphRWxnUG84?=
 =?utf-8?B?OFBzdG5oQ0RDMUhnbUI3TzYrbXZza2xiTWlVeVJPYmlsbWFnL1BRNEo1UEZh?=
 =?utf-8?B?dUgzUDdUSU9EV0pIQWQ4eW4rVndmbzNiaHNrU093bEI3QWZMem9KWUgrNDR0?=
 =?utf-8?B?UER1NnEwNFZBQ1cxTTZqWlNJZlpOSzI0OTkzQndSVVRRcEZFMWx6UWNwbElL?=
 =?utf-8?B?WllBNmp0Z2dISGFmNUM1dkdhWjlYYzdaVUEvSlNLcHUrbm40L1VWSzkvc0JZ?=
 =?utf-8?B?NlpYQkJzRGpEVVVxTTZPNFlGYWNEaWpNYWdjdVA5RVFJMFZiSGRiS09jcUo1?=
 =?utf-8?B?cy9yUXdBUDJ6RmNTS01xbDlXMm5yR2VqNEJkOXI3ZzlueFdpTk5wSThjaWQx?=
 =?utf-8?B?MHYzWTZodVFCLzg0YVFzUkpjelp2SkliSWFBbklaZ2FZaTl4ZUlFUVN1ZXVM?=
 =?utf-8?B?Q2NKTGF2MEhIZURYYStlVmh3NWx2eXgxRnJMS2p1ZTk3UGNKUlJnVmVZZEdK?=
 =?utf-8?B?dXdxQkdLcHZXMW1lVzgxQUViVC9TY2NtL0dkSVlSTklRb3hnNXJ2YTRtdCs3?=
 =?utf-8?Q?mhbEszBDWEKLXHYlTBN5hj7bTNxoLGvNe/7o3Eh6iifpb?=
x-ms-exchange-antispam-messagedata-1: Yb/hBivd/v9uqLEgUZtVL09rwvjdnKP81ZQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42B0EB733A651F4ABE382950E28D6BFD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L+ttjwVx6Ay7wbCJ+1KnlQbtpGPoFF9UGh4vFh5y2gUuRrU2Xyxed9KdBAdr5jn7m4R+6yScj4eISPSztgTCsdu2jt5RreEaGXD9Qx+Vr+VSBp+ZZQzZsgzHan+x0bj7KnZFufE6xRukupSdRrikU/oCuQw/ub10rkX5zKjFJj1fInbUX6d6Na2f7+TzgGXfBRTCshygW0CLSY9Fk/HavqHKE2bnSGmFF2wEkrLXjKbqOsDZlS5XD0RHG3s1lbNxjiIB89u/cD0vkMCc/eSiPthjgX54OJjtPP+XUvNLiQLXYJodqjMNfxn5dtGVIaozXrzx3KGcbvJF9hlvYt4+jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q+MpNGizKvQVE90LnLHeWTos4X02cj/N9k/OMpbM9QBmN9TC1wKwdhAO5wNprC2lJkqTK83yFSGbfIhcvfw3+xlmBnG4AWRIxEgxXIa1DZ+82IQZFTyrPIjNQXGeO9dJfUe5Q8mMlu4tVRwIJHIDlUlJwfEGY7tH5fdMimZE8eeRZFg+D5V3GOvZ8SqYXh7kpj6B4Urtj3pFIeuMvwgmEY54jxM2mP25lnpfviujVWIWSm+wTG7mXlAPQmnPII7uetusnkNLZCe+DjiEccOkZ8A8lFNaCOWgjxmuuDrt8K2Lmjc5GPHXsYIcVUZGVaeLsahC6+TZaQUYo6eUdT92D42hR286mFI5DUYlUh9Emyb5UyU7Hb+sEu0EzkVT9lP/C8iWjLEjgN45f7KyALQ1ryf1eKRNF/5uACYYkP2E0pohdyn+aleDF1iLBX9aiWS30YMIcizxrPu+Vr0d8BpycprCIg7tnOmkR9Rsi6RhG9mmthO4/u5TkB6BF5WcqNbgnIFXRo9KaeSijMKr8WlWXIwk5Qbnr95CLJS/pIYCBhurm//HIYia0FvP0wOoUl8Pa00og/KHCcHAxOkcdJAiHI9KpFvNPH4RJT0btSZMH1MQoSlaPwQWHOGKZL9hQhqL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cebc527-6bab-4cef-4f07-08df2fe4206b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:28:15.2266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYeuFwAQBEGuMm8F1+PuVybYqdbw09LjBCYo1yyqqIMIaPRPAUa2PrK1r83m6WLo9bb3bbxfIrrP9cSlJv7ZzRX2yCWNLPC+JHD4LtcWp2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6637
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE0OjMxIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gTWFydWtzIHJlcG9ydGVkIGluIFsxXSBhIHByb2JsZW0gd2l0aCBRTVAgaW50
cm9zcGVjdGlvbiB3aXRoDQo+IHFlbXUtc3lzdGVtLXJpc2N2NjQgdGhhdCBoYXBwZW5zIGFmdGVy
IHF1ZXJ5aW5nIGEgcHJvZmlsZSBDUFUuwqAgUUVNVQ0KPiBjcmFzaGVzIGhpdHRpbmcgYW4gYWJv
cnQgZHVyaW5nIHNhdHBfbW9kZSBsb2dpYyB0aGF0LCBzb21laG93LCBpcw0KPiBiZWluZw0KPiB0
cmlnZ2VyZWQgdmlhIHByb2ZpbGUgY29kZS4NCj4gDQo+IEZvciBldmVyeSBwcm9maWxlIENQVSB0
aGF0IGdvZXMgdGhyb3VnaCBpbml0IHdlJ3JlIHNldHRpbmcgYW4NCj4gJ2VuYWJsZWQnDQo+IGZs
YWcgaW4gdGhlIHN0YXRpYyBSSVNDVlByb2ZpbGUgb2JqZWN0LsKgIFRoaXMgc291bmRlZCBsaWtl
IGFuIG9rYXkNCj4gaWRlYQ0KPiBiYWNrIHdoZW4gcHJvZmlsZXMgd2VyZSBpbnRyb2R1Y2VkLCBi
dXQgbm93IHdlJ3ZlIHJlYWxpemVkIHRoYXQgUU1QDQo+IHdpbGwNCj4gcXVlcnlpbmcgQ1BVcyB3
aXRob3V0IGV4aXRpbmcgdGhlIFFFTVUgcHJvY2VzcyB3aGlsZSBhbHNvIGdvaW5nDQo+IG11bHRp
cGxlDQo+IHRpbWVzIHRocm91Z2ggY3B1X2luaXQoKSBhbmQgZnJpZW5kcy7CoCBUaGUgcmVzdWx0
IGlzIHRoYXQgd2UncmUgaW4gYQ0KPiBzaXR1YXRpb24gd2hlcmUgd2UgaGF2ZSBydW50aW1lIGlu
Zm9ybWF0aW9uIGJlaW5nIHN0b3JlZCBpbiBzdGF0aWMNCj4gYXJyYXlzDQo+IHRoYXQgcGVyc2lz
dHMgYmV0d2VlbiBDUFUgZGVmaW5pdGlvbnMgYmVpbmcgaW50cm9zcGVjdGVkLg0KPiANCj4gQSBw
cm9wZXIgZml4IGlzIHRvIGdldCByaWQgb2YgcHJvZmlsZS0+ZW5hYmxlZCBhbmQgdHVybiBwcm9m
aWxlcyBpbnRvDQo+IGNwdS0+Y2ZnIGZsYWdzIGxpa2Ugd2UgZG8gd2l0aCBldmVyeSBvdGhlciBl
eHRlbnNpb24uwqAgVW5mb3J0dW5hdGVseQ0KPiB3ZSd2ZSBiZWVuIHVzaW5nIHByb2ZpbGUtPmVu
YWJsZWQgZm9yIGxvdHMgb2YgdGhpbmdzIGFuZCBhIHJlZGVzaWduDQo+IHdvdWxkIGJlIGluIG9y
ZGVyLCBvbmUgd2hpY2ggSSdtIG5vdCBjb21mb3J0YWJsZSBkb2luZyByaWdodCBub3cgLQ0KPiB3
ZSdyZQ0KPiB0b28gY2xvc2UgdG8gdGhlIFFFTVUgMTEuMiBjb2RlIGZyZWV6ZSBmb3Igc3VjaCBh
IGNoYW5nZS4NCj4gDQo+IEZvciBub3cgbGV0J3Mgc2lsdmVyIHRhcGUgYSBmaXggaW4gY3B1X2lu
aXQoKSB0byByZXNldCBwcm9maWxlLQ0KPiA+ZW5hYmxlZA0KPiBmb3IgYWxsIGF2YWlsYWJsZSBw
cm9maWxlcy7CoCBXZSdsbCBkbyBhIHByb3BlciByZWRlc2lnbiBpbiB0aGUgbmV4dA0KPiByZWxl
YXNlIGN5Y2xlLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
ODdsZDdybWRpNi5mc2ZAcG9uZC5zdWIub3JnLw0KPiANCj4gUmVwb3J0ZWQtYnk6IE1hcmt1cyBB
cm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhl
bnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNCkFj
a2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFs
aXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMTkgKysrKysrKysrKysr
KysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IGluZGV4
IDA4YTRkMTRlYTEuLjQ2Yjc0MzAyZGIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUu
Yw0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gQEAgLTE1NTAsNiArMTU1MCwyNSBAQCBz
dGF0aWMgdm9pZCByaXNjdl9jcHVfaW5pdChPYmplY3QgKm9iaikNCj4gwqDCoMKgwqAgY3B1LT5l
bnYudmV4dF92ZXIgPSBWRVhUX1ZFUlNJT05fMV8wMF8wOw0KPiDCoMKgwqDCoCBjcHUtPmNmZy5t
YXhfc2F0cF9tb2RlID0gLTE7DQo+IMKgDQo+ICvCoMKgwqAgLyoNCj4gK8KgwqDCoMKgICogVGhl
IHdheSB3ZSdyZSBoYW5kbGluZyBwcm9maWxlcyBkb2VzIG5vdCBjb3BlIHdlbGwgd2l0aCBRTVAN
Cj4gK8KgwqDCoMKgICogaW5zdHJvcGVjdGlvbi7CoCBXZSBoYXZlIGEgc3RhdGljIGFycmF5IHRo
YXQgc3RvcmVzDQo+IFJJU0NWQ1BVUHJvZmlsZXMNCj4gK8KgwqDCoMKgICogb2JqcyB0aGF0IGhv
bGQgcnVudGltZSBzdGF0ZSBmb3IgdGhlIGxpZmV0aW1lIG9mIHRoZSBRRU1VDQo+IHByb2Nlc3Mu
DQo+ICvCoMKgwqDCoCAqIFRodXMgc2V0dGluZyBwcm9maWxlLT5lbmFibGVkIG9uY2UsIGUuZy4g
d2hlbiBpbnN0cm9wZWN0aW5nIGENCj4gK8KgwqDCoMKgICogcHJvZmlsZSBDUFUsIHdpbGwgbGVh
dmUgdGhlIGZsYWcgc2V0IGZvciBzdWJzZXF1ZW50DQo+IGludHJvcGVjdGlvbnMuDQo+ICvCoMKg
wqDCoCAqDQo+ICvCoMKgwqDCoCAqIEZvciBub3csIGNsZWFyIGFsbCAnZW5hYmxlZCcgZmxhZ3Mg
dG8gYXZvaWQgbWlzbGVhZGluZyBRTVANCj4gdy5yLnQNCj4gK8KgwqDCoMKgICogcHJvZmlsZXMg
YmVpbmcgc2V0Lg0KPiArwqDCoMKgwqAgKg0KPiArwqDCoMKgwqAgKiBGSVhNRTogYSBiZXR0ZXIg
bG9uZyB0ZXJtIHNvbHV0aW9uIGlzIHRvIHJlbW92ZSBwcm9maWxlLQ0KPiA+ZW5hYmxlZA0KPiAr
wqDCoMKgwqAgKiBhbmQganVzdCB1c2UgcmVndWxhciBjcHUtPmNmZyBmbGFncywgYXZvaWRpbmcg
c3RhdGljDQo+IHZhcmlhYmxlcw0KPiArwqDCoMKgwqAgKiBzdG9yaW5nIGR5bmFtaWMgc3RhdGUu
wqAgVGhpcyB3aWxsIGhlbHAgdXMgbm90IG9ubHkgd2l0aCBRTVANCj4gYnV0DQo+ICvCoMKgwqDC
oCAqIGFsc28gc2luZ2xlLWJpbmFyeSBzdXBwb3J0Lg0KPiArwqDCoMKgwqAgKi8NCj4gK8KgwqDC
oCBmb3IgKGludCBpID0gMDsgcmlzY3ZfcHJvZmlsZXNbaV0gIT0gTlVMTDsgaSsrKSB7DQo+ICvC
oMKgwqDCoMKgwqDCoCByaXNjdl9wcm9maWxlc1tpXS0+ZW5hYmxlZCA9IGZhbHNlOw0KPiArwqDC
oMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBpZiAobWNjLT5kZWYtPnByb2ZpbGUpIHsNCj4gwqDCoMKg
wqDCoMKgwqDCoCBtY2MtPmRlZi0+cHJvZmlsZS0+ZW5hYmxlZCA9IHRydWU7DQo+IMKgwqDCoMKg
IH0NCg==

