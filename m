Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC604606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WMXZ2m+b;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=kiZM8vgb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK5hP-0006xB-AD; Thu, 22 Oct 2026 23:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK5hO-0006wo-8F; Thu, 22 Oct 2026 23:12:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK5hL-00059h-TG; Thu, 22 Oct 2026 23:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792725130; x=1824261130;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tcD911lU9EyS5FPr/9Rg62KGSL1SBQJ9+ms7TyQNG+Y=;
 b=WMXZ2m+bSoKd5vMK2EWlp7FVofgncCQ7iG6o3f/TGarsmYoVWhSDi/TI
 q0Ym5QvhE5FbuLtkQMrrF52PsvzhcoxtA3jCdjdBo2s++yGknoixoq1Ni
 KChJ1ULfKysHrhRPNl+9iwOQI8sAPUos0RC0mwjW/sQK2ljiyxwmVh4fz
 0I9IRiQ1clv5ix8n5ILAyhCyLrV/7vnGwosLWYBz8yvyJM7WXDimuVAn2
 eOKHCmDGkcXCMNaZV52GBouePR0QA2sq+zYfaZ//IcyNuBiEnX1GynNiV
 4HeYoe6jbzCo5sHwHAA8TpaXru3qhBIkXcVAvqCblBMlHNlN9fpMYW6Y+ w==;
X-CSE-ConnectionGUID: FyPkx3fdS2WfsOeWHo4ayg==
X-CSE-MsgGUID: wszjs4C0Q+aUbw6TK23+pQ==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="154577151"
Received: from mail-westusazon11010032.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.32])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 11:12:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP0D9LwFuDiDvQzLknMpAKWXI1mKS8AKadRWv0EdPP7C+PgC4KznzCAGGKCp0xZ9lQlP1KaNCZBDveTtjkHwDVrj4y06NbuziOym1YPkJNQV1S1yJvpPziVZeZm7P+gsABel5NqJELUJrVawC+58iDdxwjihtb4UNBaifAu53CrFGfwdg+8gWq2k+IKbjuD9AcKNqozidAp7uRGEdGiYr3ef+/hrDObgZ4tCOEjygo+fGIWPk06wPZ1V9gJkrmti/bMlb6GlD3uH4NlWaGP3Kpr4q3FXQKYXSdQR8Nsrbt/aNfbPoRcM7jhlaU6Qd++M6sxXKsORf2DRVx0uw9rZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcD911lU9EyS5FPr/9Rg62KGSL1SBQJ9+ms7TyQNG+Y=;
 b=QD4D9O7475+eW5WaPpku2CMrajGibVB6BoIXQmCWQRC4aNFh2I06e8T1fIjhx+j1ahM0UY9CzMGEyEYe46EEpI3jt/mFK/xpU9PnMqWlFscp9eS/iLD/5M2vPBpVy/4P3EvmScLx4Kl36Sclbz7IkpDEhZkIOcoYd0E/KG4vbQoBeRyS5sj74/LOoPd6U1CoeiSvF5vASpK87WLTY2fAMt8+8/e1cgC+wym65TpJHr2PcgVdFaa/vVqylFKkiD46ZNb9r7WSVY+rbXIXpGh6zOALFRXSf0yH54jthAXGfNlxs+w64/LMNBq0wnW/uJ8HPuVcVYaE7UxsJp/LzPVM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcD911lU9EyS5FPr/9Rg62KGSL1SBQJ9+ms7TyQNG+Y=;
 b=kiZM8vgbSi8oLAbUF2o0LJxj9yY2E9vgSDBw2OPvhgNxRQqiKPbfD/kR/7WFBdd7RHDB9UGCtE1cYVXuH0qhSh5gUVPxV12/iKbbUZVEkT10usNC03zkVEwGDvPkypdVdYuD2bTDa20eAd0MWH9HHR5VZtIocDr6DPCmL+4WRi8=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA2PR04MB7561.namprd04.prod.outlook.com (2603:10b6:806:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:11:59 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:11:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "armbru@redhat.com" <armbru@redhat.com>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Topic: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Index: AQHdYYIZE7nDV5di902s7yZQvCW9QbcJEkTegAB7SYCAAOf0gA==
Date: Fri, 23 Oct 2026 03:11:59 +0000
Message-ID: <78c83e89eaa740279c5c5fcdf23f8c009a19d98e.camel@wdc.com>
References: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
 <87ecdil1g3.fsf@pond.sub.org>
 <1ce16776-3338-4b3e-8206-48c17ad1a776@oss.qualcomm.com>
In-Reply-To: <1ce16776-3338-4b3e-8206-48c17ad1a776@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA2PR04MB7561:EE_
x-ms-office365-filtering-correlation-id: 66ae8d1c-acd5-48b7-fdcd-08df30b36712
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|19092799006|38070700021|56012099006|4143699003|11063799006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261022105027099003|261022075727099003;
x-microsoft-antispam-message-info: DZkdsrelYr8vZaqi+Hbbx0k/nykugZT3ZNHYwFXCAVrtHXPU2pNK6hxDnA+uyik7YtAB+7HO1fk0jCkroQKDWzem6x6Pp9VKJiPHVpKj0xkYtc13tTaRVItV1ImPZfdqoqCVLZbnZyMuBgANdlg4s4I3F7K6Z244witURMbwqbQPUorXjt/FKnIPW/NGupHDy1TKfsdbxTeNwpuMPoCsuoaGOE/yX2iTrYdWqZndCsGTDCt5hUoPpl1NYhh8aphGj+usfOK8PAjdlruvNFGSSSIwQdwdGTdeolmuJXDAtSSanbBQ4uASfBSUem6GpIVwcTvoNXmV9+LzTVBhebJaHJ/k6OdYrzovE2IlPLH5jeiWWYAAEwjwSGnjto4rnoU2UhP/PvWVYjuLEGDjYFUd1QincnAJFcH/EjlIUuvy57f8IP+NKPcIz7ToItaRKMXlf80P39tkLwCRS5RcsFLA5x3YwfZ2FNBmSZ941/1fbj+pC4ZhXg2HXEM1mdfpLarpmGr/ed58OqomZLVX6mriNNY8JO7YcXPtKt+FNodgB2iU3pT9TRUCeWJ3gEVCJ347PF3ObcvUYm3XK3BK1pVjuCYFAFQw6gSo4ijtVMyVMP12OGykvbpFIgF1zNf4JTqTvglS7JYEqiDG4AiZHC7aMb0aMIHq+BDXwDuqiL/1lZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(19092799006)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWVmMG1zcFdESkpnNGc3bFhOUzNqOWFTOVpOd0p0aDZSaVFVRmQrdFlNTEtB?=
 =?utf-8?B?ZHovZFpIMnNVK2RQZzErQk81d1pKUkpYWEt3RVNnZnNSb2oyUnNOck1vdEc2?=
 =?utf-8?B?L1RacUYwZmFPSHBGWFRKZEQ2bXpBcTJNeEcxYWJEeDlPL09RV2p4TlRLM1dM?=
 =?utf-8?B?ZjBabllxRFR5WGtrdE90eHV0QTZkdlRSRDFkU1dBOGdBbFh4OTFYK1YvUUNa?=
 =?utf-8?B?Rjc2WFBRNDdRMi9TWDNhUjhESDI0T1NKaXBaaVlXY3dxZUZKU0M0MDMxMDFJ?=
 =?utf-8?B?ZnFLL29xVWpiVFdWbHBLOGtSVXpadDRTTGR3dlVpZnE2enVDTlhhZFFFelMv?=
 =?utf-8?B?V0VYMmtDeWR0dnRIUlJBRjBHaS9YQlZjdUVEUnpOcXNDanNRZkZuNUY0dG1N?=
 =?utf-8?B?dDhHamtPOU5UK1VZRmY3cnBOYjZSbUdYWkpaeEFFbmdyN1hsZ2l0VU1GU2xQ?=
 =?utf-8?B?NmU0Zlp4eC91U1U2bDQ2ci9aWUVTdmRab3ovcWN1akVtaEMrUjJyeXc0ZzdO?=
 =?utf-8?B?bHdBUlE5b21La1JVc3FKV2ZJVmxsdiszb1hPOXVQSmZGcnhGS2FiVkJVQ2xz?=
 =?utf-8?B?amRCTjFQaUJjMXBSMExsc1dBajBPVFVvR005MlhJVVVPNnk0YndWWnRLR2ZO?=
 =?utf-8?B?ZmQvV2NSVmUvU0RLMEhxWEl5QU80RkEraDZPSHg0NDQ2ZEV6UktQRWRsTVd5?=
 =?utf-8?B?ZXFkb0FtYmFTNnRhaEFOTU4xUzBWd3c4eHNDRmVLUnBsTnBTc3hjdDRTbXlO?=
 =?utf-8?B?eFFMTTVFYURrc0pmbjB3dXhCTWNGdGdUaGQxTm5aK1hNb1VJR2MrTllkUVQv?=
 =?utf-8?B?cWlTbnNjc2NJeFhlYURMSklETjM1NHFCWFZYdHhvbmdZUzhZeWNmMC90UERm?=
 =?utf-8?B?dGRMOFZUWGprM3YyY2tRSTI4bWJDSXhTSW16SXhmbW5kRzkxeTFIakxGOUE4?=
 =?utf-8?B?cUI5V0VnV1VQWGZicHRZM0RxYlJmbVBvWm5NaDFTS2xlTXlhL3dFMlNpaklI?=
 =?utf-8?B?d1FXMFduN0x1MlhIQmVxb1RCekREbU1oaFRCRUd6MzlaNklPQ2lvRFMwaHJE?=
 =?utf-8?B?dE94TnhDSXd4dWEwSEl3eEpGL0d2QUhWK255cUF3VlhXaWNUcDlDSGNMVWx2?=
 =?utf-8?B?MjdZcHNaajFOaXVJWlZ2RnZHb292NDJIZ3ZDRHBlamJENjBZWVd6QmFiL25Q?=
 =?utf-8?B?a0V4VG01SHJwVUY0OGE2QnVMZFZNWlM1SndKQW4rN3JhYlpBaHVZMTlMelZS?=
 =?utf-8?B?YnBJajZEZXdOOG9VRUZkTkhUSjREWjByN1pKTXVMWnhPbk50UyttM0dIR0Jq?=
 =?utf-8?B?b2p2TFB2SUEvaVRIdWJkUmM4VzNqTllLUEtUVmdoMEYwTjE5cTFaa09xbitU?=
 =?utf-8?B?QzRsNkhsRU8vM0IxU01UTzZFM09ZVE91K1VFOGNFT0ZHOTFVQ0lCYTU5T0Ex?=
 =?utf-8?B?ZzRhcVQxaktyTUJmMkVLL2ZCdkNlell5ZWRLdmlzb0x3TUpnenJ5akpFcEZV?=
 =?utf-8?B?T2p0TmJvQ0RCV1huaEYxWWZOVExiN2pmYnVwTVdhaVRtNW1zbXRORFhtRHph?=
 =?utf-8?B?WW9YaVEwSnprTnBvTEVaOUJJY1BwL2FaaXIrWUNmalpRQktWYjg3ZW5jWHdG?=
 =?utf-8?B?WUhIMGNQWWxKOW5kQzdCdGYxK0xERUFXTU9kMUVzalF3RjJBZkpBdXJBU0Jv?=
 =?utf-8?B?STVJOG0yY1N4dGF4eHV2aThBVklSWW51cmEyclQ3KzJpSGFKcVp2QnBRMnRx?=
 =?utf-8?B?SVhZeVVBMmxKeGlnd0psd3FvdDFjQ2lma2NQZVBGbzhJemh6ZFlPVHQwNito?=
 =?utf-8?B?ZHAvWHNPVVZrY2JJTEswU2FBMmY0R08yR3IrOUoxTittZUVteGR2SkcxaEJh?=
 =?utf-8?B?MDdSWXJBbGtPNkl3V0lwRUh4VGUvS0ZucEg5NXdxN0lUcGFhZEJZZU5zWWlE?=
 =?utf-8?B?RjR0emRSYnoranFiZ2dNbkF3YVlyelZaY0dVNDZ4TUk0aDdnUXNVMGxheVdU?=
 =?utf-8?B?UldwVDZXS0hZZmFhaCtDS3RIRkFleTZrdnFqVTdpRjJDSFJMRGQxeUs1SUZu?=
 =?utf-8?B?L29OMGJ1SlNnOEpKRUNnd1NGWC8vbE9NRG9JRWFKazRHYkdNc2djRGJOZm0r?=
 =?utf-8?B?cHNoM2x6aXFSdVZNbXBVS3I3dmI0OUk5SEhmK2t6czl2azZ0VStuWWFKdmhw?=
 =?utf-8?B?ZStsQnNHblZUbUl6QXptdWNlbmlFd0dQNXMrZHpDTFBFZDFKQVBoM0dWWFJs?=
 =?utf-8?B?b2ZMaU9LbnU1a0IwcTJKSG1IZ0VjZEc3TXd6c05GLzEyV0VXSVZtb29zQzBl?=
 =?utf-8?B?UVh6a3hRQ0ppMGtiN3hneXFCcXFkZmw3SS9LNXVRZy9WaTFyczdBVzFoa3lP?=
 =?utf-8?Q?CF2BYggkWTVjAWzBuCWzEMZKVC0uNF6VtXvFnS4b7EEXi?=
x-ms-exchange-antispam-messagedata-1: KpY26uJax7F7GxsiZiogVz2HV19Fn2HMsKk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81821EE5B438864C9C28197A4E11F07C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lGy4qpPaemL/xXPW57c/XGUuI7XhIXLzWkxMonDwaxy4/Lup5sEzkATA9BNNIqT2QE+0xfspX2iGEn5ZQmEKazrw7NXfqmyjrqC4DkA8j9MzZ0wHt2DvlmmBPPYWndazpbJ9xrp7wgFsyBzynF9qhIw+X0/FxXvgfTFn37/EWcjJitL9Z7E7c1DJPoBnY4ii2HBtm2pcrepEcEnPFArDItX/2DYeKIxm/HOYFUDzG4i12zArG28+f7ZmnS6sp3kumzokM8OOK+E5JGpbqagfphpHhsmxW/Qtm7Dexo0OWLb09Skh7XSe8FWEZYtT+LFKpbDOQkvsZPRbUkhOgg366A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sCg6+tvsqfUHRZ52QaoV6MKpKFpEuEL9yi90GcXfvbyJyKq4S+3vBhvu3oJF3iUQkv3Hqs6b9qbXoNusrAtl0ThGU8NBe7jfpwW8JW1snPA13EaBzWAy4ogWjlvOPtjcAnqUovSqkTF/mauEe0ORNuJFM9KFgF4A9DD24nqTzLxF1ArzXNKRwFgC1apHQR4lwVsBlIDShe+V22ofqCBVkbMOJ04Ktyl8+gmM8YiPtKRiS6J0pO4a36hfOa+Z6vNeT9dUUe32kK/uW/7MznmZSaMebH9/4YW9q84BnDqmBadOBChPTV4Y95ljP6Zfelv28uUsnlSAgIO3SDjlF9BhVXdcn9Vp26cgF4FYEfsShfBBs/4lYipYjD5BqILHW5tiiZ3FfEVB9kfXlMkj/pRpwfezGoqawsKCxsXCfhYuwmX+1Ehw3a7pvzu/uRRz+WcEY7ojnPR5FksN3ck2cD4nJ5sGNiBzZWpoGmu43+/RCvmLI8ba6dQ/Os3bM9D37REVzGjXLQmWi2sXCJvzbwXyZsnK5a/JGQsdtPpuRADJq93hZ7BpUTPl+qSDb/nnT8xA1eneVw1fgJQ5yazJcYJvcBI+x70d970cI7Dxw4gGF4JZ89pd5g9ucl0QjGGjKXYS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ae8d1c-acd5-48b7-fdcd-08df30b36712
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 03:11:59.6216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0Pb5dqVc0Tgdxwe/vlYV3l/A+1934Ii2KmQtyGs4rrpDBuU87FIatVyg3JP4JJre79D0Hs97Czh8acgj9lZQKy5Vr/Ihg7r2cZvFjSPXjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7561
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDEwOjIxIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gDQo+IA0KPiBPbiAxMC8yMi8yMDI2IDM6MDAgQU0sIE1hcmt1cyBBcm1icnVz
dGVyIHdyb3RlOg0KPiA+IERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYW5pZWwuYmFyYm96YUBv
c3MucXVhbGNvbW0uY29tPiB3cml0ZXM6DQo+ID4gDQo+ID4gPiBNYXJ1a3MgcmVwb3J0ZWQgaW4g
WzFdIGEgcHJvYmxlbSB3aXRoIFFNUCBpbnRyb3NwZWN0aW9uIHdpdGgNCj4gDQo+IEp1c3Qgbm93
IG5vdGljZWQgdGhlIHR5cG8gOkQNCj4gDQo+IA0KPiBBbGlzdGFpciwgY2FuIHlvdSBmaXggaXQg
aW4tdHJlZSBvciBzaG91bGQgSSByZS1zZW5kP8KgIFRoYW5rcywNCg0KRml4ZWQgaXQgb24gbXkg
c2lkZQ0KDQpBbGlzdGFpcg0KDQo+IA0KPiBEYW5pZWwNCj4gDQo+ID4gPiBxZW11LXN5c3RlbS1y
aXNjdjY0IHRoYXQgaGFwcGVucyBhZnRlciBxdWVyeWluZyBhIHByb2ZpbGUgQ1BVLsKgDQo+ID4g
PiBRRU1VDQo+ID4gPiBjcmFzaGVzIGhpdHRpbmcgYW4gYWJvcnQgZHVyaW5nIHNhdHBfbW9kZSBs
b2dpYyB0aGF0LCBzb21laG93LCBpcw0KPiA+ID4gYmVpbmcNCj4gPiA+IHRyaWdnZXJlZCB2aWEg
cHJvZmlsZSBjb2RlLg0KPiA+ID4gDQo+ID4gPiBGb3IgZXZlcnkgcHJvZmlsZSBDUFUgdGhhdCBn
b2VzIHRocm91Z2ggaW5pdCB3ZSdyZSBzZXR0aW5nIGFuDQo+ID4gPiAnZW5hYmxlZCcNCj4gPiA+
IGZsYWcgaW4gdGhlIHN0YXRpYyBSSVNDVlByb2ZpbGUgb2JqZWN0LsKgIFRoaXMgc291bmRlZCBs
aWtlIGFuDQo+ID4gPiBva2F5IGlkZWENCj4gPiA+IGJhY2sgd2hlbiBwcm9maWxlcyB3ZXJlIGlu
dHJvZHVjZWQsIGJ1dCBub3cgd2UndmUgcmVhbGl6ZWQgdGhhdA0KPiA+ID4gUU1QIHdpbGwNCj4g
PiA+IHF1ZXJ5aW5nIENQVXMgd2l0aG91dCBleGl0aW5nIHRoZSBRRU1VIHByb2Nlc3Mgd2hpbGUg
YWxzbyBnb2luZw0KPiA+ID4gbXVsdGlwbGUNCj4gPiA+IHRpbWVzIHRocm91Z2ggY3B1X2luaXQo
KSBhbmQgZnJpZW5kcy7CoCBUaGUgcmVzdWx0IGlzIHRoYXQgd2UncmUNCj4gPiA+IGluIGENCj4g
PiA+IHNpdHVhdGlvbiB3aGVyZSB3ZSBoYXZlIHJ1bnRpbWUgaW5mb3JtYXRpb24gYmVpbmcgc3Rv
cmVkIGluDQo+ID4gPiBzdGF0aWMgYXJyYXlzDQo+ID4gPiB0aGF0IHBlcnNpc3RzIGJldHdlZW4g
Q1BVIGRlZmluaXRpb25zIGJlaW5nIGludHJvc3BlY3RlZC4NCj4gPiA+IA0KPiA+ID4gQSBwcm9w
ZXIgZml4IGlzIHRvIGdldCByaWQgb2YgcHJvZmlsZS0+ZW5hYmxlZCBhbmQgdHVybiBwcm9maWxl
cw0KPiA+ID4gaW50bw0KPiA+ID4gY3B1LT5jZmcgZmxhZ3MgbGlrZSB3ZSBkbyB3aXRoIGV2ZXJ5
IG90aGVyIGV4dGVuc2lvbi7CoA0KPiA+ID4gVW5mb3J0dW5hdGVseQ0KPiA+ID4gd2UndmUgYmVl
biB1c2luZyBwcm9maWxlLT5lbmFibGVkIGZvciBsb3RzIG9mIHRoaW5ncyBhbmQgYQ0KPiA+ID4g
cmVkZXNpZ24NCj4gPiA+IHdvdWxkIGJlIGluIG9yZGVyLCBvbmUgd2hpY2ggSSdtIG5vdCBjb21m
b3J0YWJsZSBkb2luZyByaWdodCBub3cNCj4gPiA+IC0gd2UncmUNCj4gPiA+IHRvbyBjbG9zZSB0
byB0aGUgUUVNVSAxMS4yIGNvZGUgZnJlZXplIGZvciBzdWNoIGEgY2hhbmdlLg0KPiA+ID4gDQo+
ID4gPiBGb3Igbm93IGxldCdzIHNpbHZlciB0YXBlIGEgZml4IGluIGNwdV9pbml0KCkgdG8gcmVz
ZXQgcHJvZmlsZS0NCj4gPiA+ID5lbmFibGVkDQo+ID4gPiBmb3IgYWxsIGF2YWlsYWJsZSBwcm9m
aWxlcy7CoCBXZSdsbCBkbyBhIHByb3BlciByZWRlc2lnbiBpbiB0aGUNCj4gPiA+IG5leHQNCj4g
PiA+IHJlbGVhc2UgY3ljbGUuDQo+ID4gPiANCj4gPiA+IFsxXQ0KPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC84N2xkN3JtZGk2LmZzZkBwb25kLnN1Yi5vcmcvDQo+ID4g
PiANCj4gPiA+IFJlcG9ydGVkLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5j
b20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA+ID4g
PGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+ID4gDQo+ID4gVGhhdCB3YXMgcXVp
Y2ssIHRoYW5rIHlvdSENCj4gPiANCj4gPiBUZXN0ZWQtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxh
cm1icnVAcmVkaGF0LmNvbT4NCj4gPiANCj4gDQo=

