Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF5606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=i7Za5Lcp;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=gJjm9zqF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR01v-0005rb-VS; Tue, 10 Nov 2026 23:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR01t-0005r7-J5; Tue, 10 Nov 2026 23:33:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR01r-0000iD-1P; Tue, 10 Nov 2026 23:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794371634; x=1825907634;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9msek1+3oqrMwR2C6tcFM10E1ll60NSwyrFWHNzs3WQ=;
 b=i7Za5Lcp3NSi0FVLsU8bxOoTfhiyCt3a+l1c9cvGm72IxZfETXU1EGkF
 KIC3kMacBRiDh4PD1jDsI0tHwboBPM6EqeykhgI6bPakLYXV9udpvq6i/
 hF2VisOBhlOCaDwfhaJ6WBwrqu5FOiQBAZjVEISMWpTO3UU9oeyyL5yby
 hnmOTnntx6e2flAvCUdrmWhFhr9UW4zDUoKelwSFhz+yU0f5CopR0VIsT
 Ag1jP5zDuPvqcP2o2Oq+A0nyL9OAqmY2yBY76THTDPxOia3vy8wwVFKbk
 KsG/nNY5M00WTjRy1f+Hvaxzi/q90lAM4IYcAYL31wxqBb8SmvN4o8nsg w==;
X-CSE-ConnectionGUID: tUfFFxEWS+uxzPj1BOofwQ==
X-CSE-MsgGUID: XzEYqOiURJyVKat5o/7ZgA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="160601796"
Received: from mail-northcentralusazon11013012.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:33:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsEv5kVgHNhXyaeM71DtD0l/uroRLRP3T7EP3xnziC4jbUI5+Kg/HDEwusC2J/BkPSobI+dx90vhFjRDwrxM0U648wM6aBWXuNmhQuaSzDRJXaHi65QCHCBSiUAJJJQ3hRe1zvRyQ66cp+iM5DP1g9aRi1ap6nst3MxTNxN7LqQsyxudVBSk/YUauYBzbfR32mrqGcRZB4Bj3eeHomVLzuZHVvqhvOt7QLa5JTU8tH7kNuG69ecQMU+swdYrIdV2weMcECwqmY+5Eim4Xu356V3CbwgTZG+rymYqmOd2LtH/98swOG3ZBcl1ABap2GxZrmBPPTnC/XgBIhFo/8L3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9msek1+3oqrMwR2C6tcFM10E1ll60NSwyrFWHNzs3WQ=;
 b=aH0ZmJmlSDcAlKdPvClURro4VJZX2qAdtrGapD16VGePJv77Vk0oK7YT8cgyZASuDZioyBXaHm9dOpGmbbc/uLSJLN1r9IHrJsLjyn/+5H02+IF6PpHDG/qFNq6gu6OEO8dl0ydzN8tPu9PNIk3FEH/vbrD0CfNdLMwEAlD9loNP4CaWa9+rDcMsjmxSsP7rzSdHAdf2iZWHgoKSv9uwoOTuhNyLhv2yyQbfi8kdvKDTZ0ANh8TMnDTft+vS+YbW/5q87T+vHfRVjt2QHdpD4taVNFtjV3LUHgAyDdXeqJs+jpZmPUelqOjG55zMW7XHdFDRPriB3A6IGTQQdcptug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9msek1+3oqrMwR2C6tcFM10E1ll60NSwyrFWHNzs3WQ=;
 b=gJjm9zqF/neYLRMQY+YZfN2DuWhfb5nEwFM9MzaXF77aTgZDXnk6/gJUA+A6PLPPAnAbBzyNehjTq1BPb1JLVrCZvG4cnq/eejBO1rfNXAaYI+3bpVI6fpERIrbPWSSaw7l5+Rpss73woPL4k5TwlZczfwqJxszzam+s84HOtdk=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH4PPF062E17813.namprd04.prod.outlook.com (2603:10b6:518:1::e44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 04:33:42 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:33:42 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "ralf@vmexit.de" <ralf@vmexit.de>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "ralf.ramsauer@oth-regensburg.de"
 <ralf.ramsauer@oth-regensburg.de>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "lukas.landgraf@st.oth-regensburg.de" <lukas.landgraf@st.oth-regensburg.de>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v3 1/4] target/riscv: add riscv_cpu_has_supervisor_mode()
Thread-Topic: [PATCH v3 1/4] target/riscv: add riscv_cpu_has_supervisor_mode()
Thread-Index: AQHdYmMPAmssVm4IdEKUYgYH3yYKBrcoZuAA
Date: Wed, 11 Nov 2026 04:33:42 +0000
Message-ID: <c3a0a1c1b1e9ac641de30ecc5f4057273cc6a9fa.camel@wdc.com>
References: <cover.1792700406.git.ralf@vmexit.de>
 <7ce612fe810e410dcac32b9da863182b1f6d2c5e.1792700406.git.ralf@vmexit.de>
In-Reply-To: <7ce612fe810e410dcac32b9da863182b1f6d2c5e.1792700406.git.ralf@vmexit.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH4PPF062E17813:EE_
x-ms-office365-filtering-correlation-id: 2e8e52aa-b135-411e-94e0-08df3facf724
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|10070799003|376014|1800799024|366016|19092799006|56012099006|261026121527099003|261021121427099003|38070700021|4143699003|11063799006|261026140227099003|261022105027099003|261028144727099003|261009223027099003|261102123227099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: yJgx7E53L97eU5GMM+pPgd/OdwPeQfgsM2S5rnegTSAElMFFOIwsX6Jd6c3+jpMgPyvzAfWPZyo6FySNdb2iSv+5GB66w0iHclQUDXo4cdGrcKdgN4f+bjyqaVln6XDn9dL7AyGQgd2unM0yAZ9i9lBnBleqhOweSn4r0unBG06r0+pLpxoPAc+sln0ta8IoMDmFMgCy7UwK8XxjaRAgUA19LCltdcCzKJtbsE0EOPVZkVoFjHkDSmhpd8/jyHeluilQnkoVN5cgqFuU2sXctpIKWI+QuTLTR0fz06z/SA/XZwHDylHn7Z8ZMR1W8tTYw0Pl2liB00H3r7KI/YjIhbn7rIyCFALZ0TDdCWCQaOVZeQjWPIQxaVKOVA8u4c1mesouQKsSYDEIr5dWQDgaAhP1o76qUp9LOOEsiQynQgVUKoPtObtowFU+wUj2NKmPdL+wFJpb5QPEe0YsZxLDu8A5YnB5qqkjGbUJ6dn3rA2bR7stMGBQdNRJ2N1ve6jVKYLsQ13xQ20HMOMUkBSn5poc0JGLDQmtYycQrtLK7p13upR7JF9KnBBNDEKQAskfy5Nd2FcYVCZ35cVAVhQdg5+xVgi3ksVfzcVARzpMhjAYjfDyYmlUdcaq81cGMnlDLM36D5ZoosFKHOcH7IZTz7J63SrMcTc2cSupnSmb3SUSLy2OdYrD14gcpQqIr8VzthK1TSmTPK5ilyCqTcrues9a1a4ej9hwKABqEOyNOhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(10070799003)(376014)(1800799024)(366016)(19092799006)(56012099006)(261026121527099003)(261021121427099003)(38070700021)(4143699003)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0lpQkNyTmxWcVJ3VXlHdTZZUXB5blFKcUxISjNhM0h4cXd6T2VnWnV4NGM2?=
 =?utf-8?B?QkorSDJVTE5XdVNhZHNmYkNKaDZleFRoYURDN1c4bHhrZThsNkN0QjhmQWp5?=
 =?utf-8?B?dG1DSlNpSjlVQ0swUjV1Y3M3Uzg5Z09IbmVQdkJlTnNIdnNXOUI5SGtEODg1?=
 =?utf-8?B?ZVo1UnhNSjJ2VEtTNVZmdzYzWXlXUy9oZVdpNlhtWUtOaFVtZC9rT0JnLzlM?=
 =?utf-8?B?bTZ2UUlzVlJtRUFkQmJCNDZpek9kcGdUQzAwaEU1YzZJNHo4TG4yS3AxSExD?=
 =?utf-8?B?ZU9CcVN5ZXo2WUlzY0N1VnAvWDJkaDBWczZnSGdoT3FvMk5uTVp4a3BiaEtj?=
 =?utf-8?B?Q2JzZ0htcnRzZ0hxV3lwR2tyRW1zSmRqQ1VKTCtBaFZkUWg5TFdaZC94OHhy?=
 =?utf-8?B?RVhhaE1WWUFNaDN4ZHpzcUpwNVlCZCtVdDY1Vnhkd1pVcUk5NXlCVmRpY1kz?=
 =?utf-8?B?UG1YZEtEK25WMlBuanNIZURJRHd4OC9jUGI5aVQwTU5jYTlHNFk5OXRjZVVO?=
 =?utf-8?B?SlVJUXcyVEZ2ejBZVm81dTRSdHkyeVA3Q3gvRXcySlBTczBRMEhtQVJxelg0?=
 =?utf-8?B?aDBFOVlKRTl3bzY5RXJNVDZnbVkyUXBSVmo3dTdobjNrWWlXYVRUNHkyU3FF?=
 =?utf-8?B?RkZsTHNmTmUvcU93QlBNa28yR2lXRFpKeVpaZ3FtV1RGMjJNMFkvZWcwOTFz?=
 =?utf-8?B?YmE1SS93TzN1KzFQY2NXNXgwOEJ6aExKSzhVSUNvVnN5akwwWHJ4bGlEd21s?=
 =?utf-8?B?czlibzJEVFJ6SFBBWmtSQTZrUFVrU1BEU3JjbFF5TlFCb2l1ZWk0VUFCbEhu?=
 =?utf-8?B?TUtoMVp5UXlqQnI5OXVxZjBpZE9JT0NlVTFOZFNDN29xeFF5d0tYcWhhQjUx?=
 =?utf-8?B?R3ZaMHFsWU1JYTl0b2RpTTZySXc4MGxTN0RDQ2t6TFFBNExlM2I1L1RtZWFN?=
 =?utf-8?B?UThzemlXNmE2aXlTdzZLd0NpZmpmSk5zS2dIWkl4aHlSTEhUUHJvZDd3YW5Q?=
 =?utf-8?B?ei9MTUxZR3BhUFpYREpSTmdhL1BUclpWSFg4QmVkOTVhVWtraXZFTmdTQno3?=
 =?utf-8?B?ZmUxZm9hTnh6cEpNTlRhb0lCYXB6SHZyNngrNmRJRU1CNGVkbjlXT0NhSXRC?=
 =?utf-8?B?WkdUaFkrUVVZVFo2eDBybFhsZnRTc0FPOGJ3SHo1K2NmeGNLY20yVE1GUUhk?=
 =?utf-8?B?OVphUXNtQnNZN2VDY3dkR0FrY1pDakpWcHRSR25LMkNLbXM4STBJeXFSQnRI?=
 =?utf-8?B?T2VIZzdFTUtLVXlWWkZhN0kzSFFtR2RSaFI3QkF2bVI4QkQrazVyN0ZmcFhV?=
 =?utf-8?B?NFNIdEswOVd3S0FRdjkrOVFGQmdQYjFHYnBnNFNnNmNhU0dlSWI2VHJBNUdw?=
 =?utf-8?B?WFlpQjdlNk5lZEhNbHIzQTVBR004ZXVvM3ZLSy9Vc2Vpa04wNjQxSklTNGlM?=
 =?utf-8?B?VC9LNThzS0JwODlIOTkvOTloeVIxQTJSS1dHQ0dNTnhiWmcwZmhhbVpHaHRS?=
 =?utf-8?B?SHlxRHB6U3RLY2dUVWdUako5MnpFeDZZOUsxOGxFYld6b2RsMU9ieXdNYmph?=
 =?utf-8?B?RU9xL1cweDY5OUk2Z281ZERXbGJsa29DNThjQUR5Q1h0SlJXVmJtOHNHT3BP?=
 =?utf-8?B?UERpdHpYZncwOERZZE44dlFPMDVQdERuZUhxSzBuZmg4UTNoUld1MnYwdDE1?=
 =?utf-8?B?OXRJa2dsaUxsbVhYeUZTUzVSNkc1UWkyV0ZKQWVTaUFQekZDN05rckQ1M24x?=
 =?utf-8?B?dlRLYWd1VXdRUVZMYU5MTUVEbjQ0VVNEV0lSMFM3VmV1K0pUOGhTYTRXcmVr?=
 =?utf-8?B?ZHkrR2dQTWlwVlhBUUp0YlNmdEpxTUdaTm1VMEt2NW1LR1RNdWlnTW9XNGlm?=
 =?utf-8?B?RUdMZ2d2YjZydWJjbDcwb2RyNHp6cGJhWExHcVZXS0RETzBwbTJZZFdQcmp4?=
 =?utf-8?B?Q3hZa2s3Z1h6cktvZ1JmbHFyQk1rRnZNVUZBSmE2Zm9UaHdtVXdldXJOeUtt?=
 =?utf-8?B?OEdKWlNZTGwrUmVWNUZFaGo3dU80UGpLc2JBbGhnQWZrZTBZZGlBNjhjVUFz?=
 =?utf-8?B?dThBanIra1gzdWpqUEo1aVloU2JHL0IvLzFTQno1amxWazZuLzZoRDlYWFo1?=
 =?utf-8?B?NldLU0Y3OFVOVXM0aVUvbGcram9ETnlvTDRid29jU3VSVTh6RzVybEJnUVBO?=
 =?utf-8?B?Y1pjSXVRRXNvanc5ZlppcW40MWFwaklBVHBhdVoycCtCeG9oZll3dXpEZWVC?=
 =?utf-8?B?a0gya05rVlNsMEJ5NStzSVJxMHdVOS92K1hqekoxQkJsQmJsc1FyZVN2TFA2?=
 =?utf-8?B?aGlGTWV4c2wxR1dOdWFyY3NtRTJ1SUFjZS9ER3JabFc5L2dxOHEvZ3FZQVgz?=
 =?utf-8?Q?qXeyiuIa902fHcrM4yVGnmUyKw7moWjTajIpx/lEIG+jF?=
x-ms-exchange-antispam-messagedata-1: x7v/4BZguzz3s34UlH7gtmEYbUEKoRHoP+s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC38EA92A56CF14DB548FAF0C22EC904@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D/j0U2PjN8U/4I6RnPHPIUE4eKkDqImyWIXWb+F9f1XM6NfqiTdIpFeBGsYdYuqgria5VEFCz+h/uY5zWDI5rcqVRUbHgDRgd89c5CxZQrCMyvMxpkltpxyQ/oAXnmiN3Z95kQjd1f3IX/ZFf3EKmTYziJfxjnEtXMeFhIQSuSd3nWJq+WtIE4xowMA0VvxakvQsc2LYrYyJfeLfWCFGpOF5eS8zshr/xeX6TSaC/ZM6HOqu86QLBq6Lcg0D24DKFThqXjuAyyJ3+Gp1JNq1SuRs3rRww8V6+UFa7aFHqcCFQVhWQUMrBUkYOYLI8s45vocd3kWKzrWPU9YSg7thJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dVlrtMCrpjrnj0hWd2wGgl7kHXhd5GpojbwLsG5OOqKsthLyLRpYCR4DDrk9c0W40qc83ZKt0AzNLrVeCYcoh3CdpwLwcWletpjSEb2P32OMDQUvRfrmtpne0Q+7t34MMst5jf+xxA9A9tzUZlOr9I3ZI5T7kTwVgA3QyRtvguoNrr6IRLWmA32Dz2JZZvTFuZIx1+kk4L46nrvcVEvyvk+Q4CX7ThxQ7VRDdZg8n8ju3UaBDytss0nsb59IunRueuoAcVjHPLROQwdvfLBpTq1JDDAG/Z5iiJIYNbw3N0vjw7jknaiDJnVJvFHfrF38Er6U6yo/oVzKouq/Q5csmvBb+QLOYhvp5zeMiHqeElX8naZ2tQIMB/CtfRfLGef59qI1wToGAHde3gGY2/wQlyM7xIKCHgKCnG0T75mBimxCBaewrsJ9BNcoWAu0cL8H2eKnSb3O3CNVsv+9bq8dc3evGqeOQ0nq+ll7Z8yVkGmZ3m2qYZCPF9T9ucaDc5f+QWkkTtuGgTtLXL+9lqQ9Wmnytt9p6bjrXNUIfOpmVm1X1n6FlsGEfM9Zo5t05IHIUAFFI8K72jkzuM5vL6rz/KiywGxyJ5e3AYXnQI9590RVpztVA9MCNmIHhvhzMzcD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8e52aa-b135-411e-94e0-08df3facf724
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:33:42.2605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vXxQtdWnMCwAAG+ku/UJUwSfqb0fidx2b1/iQCvgH/FnRriLe2Dtczz+8TbtQEwfZ1Onq68uK3LbQsU1ZfealxmcEkrnqjbMJDjzuKlGxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPF062E17813
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIyOjIyICswMjAwLCBSYWxmIFJhbXNhdWVyIHdyb3RlOg0K
PiBGcm9tOiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJhbXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPg0K
PiANCj4gV2hldGhlciBhIGhhcnQgaGFzIHN1cGVydmlzb3IgbW9kZSBpcyBkZWNpZGVkIGluIHR3
byBwbGFjZXM6IEtWTQ0KPiBoYXJ0cw0KPiBhbHdheXMgaGF2ZSBpdCwgYW5kIGZvciBUQ0cgaXQg
Zm9sbG93cyBmcm9tIFJWUyBpbiB0aGUgSVNBIHN0cmluZy4NCj4gcmlzY3ZfcGxpY19oYXJ0X2Nv
bmZpZ19zdHJpbmcoKSBhbHJlYWR5IHNwZWxscyBvdXQgYm90aCBjYXNlcy4NCj4gDQo+IEJvYXJk
IGNvZGUgbmVlZHMgdGhlIHNhbWUgYW5zd2VyIHRvIGRlc2NyaWJlIHRoZSBpbnRlcnJ1cHQNCj4g
Y29udHJvbGxlciwNCj4gYnV0IGl0IHNob3VsZCBub3QgaGF2ZSB0byByZWFjaCBpbnRvIENQVVJJ
U0NWU3RhdGUgZm9yIGl0LsKgIEFkZCBhDQo+IGhlbHBlcg0KPiBuZXh0IHRvIHJpc2N2X2NwdV9p
c192ZW5kb3IoKSBzbyB0aGUgbmV4dCBwYXRjaGVzIGNhbiBhc2sgdGhlIENQVQ0KPiBpbnN0ZWFk
IG9mIGluc3BlY3RpbmcgaXRzIGludGVybmFscy4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogRGFuaWVs
IEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFJhbGYgUmFtc2F1ZXIgPHJhbGYucmFtc2F1ZXJAb3RoLXJlZ2Vuc2J1
cmcuZGU+DQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVs
LmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0
YXJnZXQvcmlzY3YvY3B1LmMgfCAxNCArKysrKysrKysrKysrKw0KPiDCoHRhcmdldC9yaXNjdi9j
cHUuaCB8wqAgMSArDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+
IGluZGV4IDA4YTRkMTRlYTEuLjdiZTFjNjU5MDIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di9jcHUuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gQEAgLTMzOCw2ICszMzgsMjAg
QEAgYm9vbCByaXNjdl9jcHVfaXNfdmVuZG9yKE9iamVjdCAqY3B1X29iaikNCj4gwqDCoMKgwqAg
cmV0dXJuIG9iamVjdF9keW5hbWljX2Nhc3QoY3B1X29iaiwgVFlQRV9SSVNDVl9WRU5ET1JfQ1BV
KSAhPQ0KPiBOVUxMOw0KPiDCoH0NCj4gwqANCj4gK2Jvb2wgcmlzY3ZfY3B1X2hhc19zdXBlcnZp
c29yX21vZGUoUklTQ1ZDUFUgKmNwdSkNCj4gK3sNCj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05M
WQ0KPiArwqDCoMKgIC8qIEtWTSBhbHdheXMgcHJvdmlkZXMgc3VwZXJ2aXNvciBtb2RlLCByZWdh
cmRsZXNzIG9mIHRoZSBJU0ENCj4gc3RyaW5nICovDQo+ICvCoMKgwqAgaWYgKGt2bV9lbmFibGVk
KCkpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiArwqDCoMKgIH0NCj4gKw0K
PiArwqDCoMKgIHJldHVybiByaXNjdl9oYXNfZXh0KCZjcHUtPmVudiwgUlZTKTsNCj4gKyNlbHNl
DQo+ICvCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiArI2VuZGlmDQo+ICt9DQo+ICsNCj4gwqBjb25z
dCBjaGFyICogY29uc3QgcmlzY3ZfaW50X3JlZ25hbWVzW10gPSB7DQo+IMKgwqDCoMKgICJ4MC96
ZXJvIiwgIngxL3JhIizCoCAieDIvc3AiLMKgICJ4My9ncCIswqAgIng0L3RwIizCoCAieDUvdDAi
LMKgwqANCj4gIng2L3QxIiwNCj4gwqDCoMKgwqAgIng3L3QyIizCoMKgICJ4OC9zMCIswqAgIng5
L3MxIizCoCAieDEwL2EwIiwgIngxMS9hMSIsICJ4MTIvYTIiLMKgDQo+ICJ4MTMvYTMiLA0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IGlu
ZGV4IGI2NWQ2MzE5OTQuLmE3NTA5YjAxMTQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9j
cHUuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gQEAgLTk5NSw2ICs5OTUsNyBAQCB2
b2lkIGlzYV9leHRfdXBkYXRlX2VuYWJsZWQoUklTQ1ZDUFUgKmNwdSwNCj4gdWludDMyX3QgZXh0
X29mZnNldCwgYm9vbCBlbik7DQo+IMKgYm9vbCBpc2FfZXh0X2lzX2VuYWJsZWQoUklTQ1ZDUFUg
KmNwdSwgdWludDMyX3QgZXh0X29mZnNldCk7DQo+IMKgdm9pZCByaXNjdl9jcHVfc2V0X21pc2Ff
ZXh0KENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMyX3QgZXh0KTsNCj4gwqBib29sIHJpc2N2X2Nw
dV9pc192ZW5kb3IoT2JqZWN0ICpjcHVfb2JqKTsNCj4gK2Jvb2wgcmlzY3ZfY3B1X2hhc19zdXBl
cnZpc29yX21vZGUoUklTQ1ZDUFUgKmNwdSk7DQo+IMKgDQo+IMKgdHlwZWRlZiBzdHJ1Y3QgaXNh
X2V4dF9kYXRhIHsNCj4gwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZTsNCg==

