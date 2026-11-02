Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD585606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fO3gELXe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoG1-0007RU-VC; Mon, 02 Nov 2026 04:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFD-0007JH-Jl; Mon, 02 Nov 2026 04:22:24 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFB-0000WI-2Y; Mon, 02 Nov 2026 04:22:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8Vi98TCqip7N31hxV8+V59HTn7yaT19B3tRHbnd93ctmY73Z3eLhI1eUprm6vwfK03SwfcJAblHOohavQp2fdOkW+o093BnF79LwOmAgmfyl+TJC+ZaLl/aaKyGPps/HiDWlFdaOecjYKFwPSbs1k0DojifNpbgVUb+wu+zncrOFTLVzbYKa+LulP+NDUgx9rJa2DqWwtJ6VVIHsVmHcYUN6qkZ33tTvyDkAiRpSl4PZYpDckPZGHVSNi+HjFrXBLzBAU0LZxCXnbCf81KbNnQJ6Ig0VCNhC5H1O3Jb/qQJ5TBYwgGqulqA8YOqVPSCjvzMt0nQYCTWYfWvhFhQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq/0xTQzt4r4qACD3SKq9qG7f3wnpPsxLchH1uuagd8=;
 b=KJcWLPU4J+P/wRNsfFzbvjSniv3vKWILphZAICpA29BJ5Aphi0hcW86k4q1lIFVkI9PkRyRZc9gS5JXJkVXox6p/4xFANmkAS7Id/VHtc61EFDKqTfCsGHPjgVk3njcMvxOoO4h2d2gBgO0wf4S6M6c/Ipilxs+v7rZTYvqEyNiBzhywG37ho5248q70XvtmJ4epyVAf/1peGbSRqnqTFc8qXom8s9AOQeo9kDCaJ6VcBo8bd7YfES+mFGjMmEq51dt15Se6embpmphUuM4H0kahNNsrTQoXHwT5YuFCM6gDzO73QIkoKnJMT/PLDyfCSOdWhtjXDuN6gejHSotGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq/0xTQzt4r4qACD3SKq9qG7f3wnpPsxLchH1uuagd8=;
 b=fO3gELXebgs/DmfeJDsb7Br7VwQZTfjha/e8YPGYiHZ7depdtCKig+QLDyn6ZU5H/Ijifw4NBdTM6bs83KMcTWBZENWVaBB3tfFwvXW2i7xGfWKx1rdnC0t6AdlRtE2jctPid06lTYQBohqFUqizgQuRVNCwY+1u5cPaKhwjp+oZWJB7BL38BKLzkqsTzkllg+z0SlJEB+KDUqyWVocCAc2wPM1c0iW4e4Slt/4yeWuwUrAjIoRHwAF7/OHRA3LuwEocPfJx5suvTszGt71t4jlBPdjwZsGa+JePBTLhGJ5aH4Hw5rWnnSahIfsBT4SWUlMUkTzDDIS6yXYDSmGTWg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE2PPF4565C7005.apcprd06.prod.outlook.com (2603:1096:108:1::7cf)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.6; Mon, 2 Nov 2026
 09:22:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 03/18] hw/usb/hcd-ehci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v8 03/18] hw/usb/hcd-ehci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaquhga6t5nVRcEGa+nf3TCiRHQ==
Date: Mon, 2 Nov 2026 09:22:07 +0000
Message-ID: <20261102092201.1729245-4-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE2PPF4565C7005:EE_
x-ms-office365-filtering-correlation-id: 8d3a3f8f-560d-4e3c-10ed-08df38c2c404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|921020|38070700021|261021121427099003|261021123027099003|261009223027099003|56012099006|261022113327099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: XepseZPBYtKEWGKlREqSDeQB39eMv6vPozkcgHzK7teyKVFyjUazJvJKtECcGggWI0ciBL7pEGEdw1iRb0Fk1hR5Ow0u/LZYn6KPhz2e4CO6bJ7qiR70HpNbkd1nl/6NIbaBp8nSJFZ2SICYxlWNpp/3yP+fEOcVd6k797ULsgtUlKQbm4r3He6xdfWvJpxSxAJui0BRW7LpzH0NeRQ0oSvvusi6o7GGz4FJ0idhv2s2Xy7+HsFzdMyybkK85CyaIe+3SizoDBhN45JB9Vub1B8sgPcjPkJWlpw78Qo2uaZF8stmsb1JRxw9v6maKtdic901Drm2UAbYSWVpEfKD5fOuOYSHGmx2Or32FsuLkKIvoB3Jazrzf1BPaq5Ps/lSqURz9JqEKSe+gGkn9zL44dXa46+W5RxuqVjNX+hi3kwzPthR0BEQIkqtiqWO3HDdVGnVB3G8PTfKuFwaAy263MZ4eJZuUH9x6uQRu/RACeDJXi/o8ledTRLn5gTl3ps6hRMk84UAG7Y5JT62hIVoNt4LEkyyPCHnvPxKvn4P/zLMJjptYOIcMpFyu1Wd7jKNhxueKRc4rfhmod1ELsDROE+49jZu+rKDyzQInXSNxSeIiMSPe0InT6Ht8mCbFLbPyJxLdJHPo0QTsE89T6jWrt8IR2ykqfMclN3klUxPavoV9YOyQnlTg3GpPGd9BY6kmuTDDC4UTCSGOSiFhnbpbxDnOu8zprAiTe/vqXPNi+k0M/vMRBA9Ly09+F0EsXAr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(921020)(38070700021)(261021121427099003)(261021123027099003)(261009223027099003)(56012099006)(261022113327099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Heo+qSmxRfLp6eUorv/e2YuYFMY+BjnujU0HbRfeu+331YM06HhmwsdqHy?=
 =?iso-8859-1?Q?6mw6VzcAXpQzU44dHrPMm3iiOZmtapdly0YUWNvoAVk/m/RxwV06/1Ns+k?=
 =?iso-8859-1?Q?SsSguDLHGbTkgDbLw1EfRO9p3ixV9Mv4iS2CD9vhqQt6ealjjNV3sZrXik?=
 =?iso-8859-1?Q?mrEWCKgcHjUkqOWCcMDBVuz9DBKc62gJXadUW7MJbVQxRWW+SwDs9shFZK?=
 =?iso-8859-1?Q?w1cOWwQ63E0ZzW5J59yPPvri6wQIwoSqh6O4ap9Huug/9S+EibKfvXVHTh?=
 =?iso-8859-1?Q?TJraQAakDZJtnrqqj7GjxZWnlYWR1LXR/4ib/sxWqEBX8Evya07v4MuWFb?=
 =?iso-8859-1?Q?fZ2jr+fEQlnHINIbaMujZTNoHZU5RVB/Iu4HtaX7q2E35OrHOAMgMe8u31?=
 =?iso-8859-1?Q?Tpd84Jj7N1Mke+F1LmjfwlCOt8zVgQp8SBJzKgqAJ3AvOpy2qlbRbADO9h?=
 =?iso-8859-1?Q?4oTmDs9G7z59lEZC8zRUwz7XuKEc2/T7oH5a3z3ckOMJXowp7mVYoqFP29?=
 =?iso-8859-1?Q?IpzvjQgVP1Q6uPw+C4S4KASVAcQPXdXN8F7WlfrtrcO8vUSpXku4Gpr44l?=
 =?iso-8859-1?Q?XS5k+j1TP2WuTDn54D+m3DrLr2RuyDjuxtyaLUxAf1Fpb/Gp8Ut+3rPwLj?=
 =?iso-8859-1?Q?lWsZ5wtLSOfvqKRmfgfhjnCP/Mix+IWcn31uDmgPjOUzXYvOcwIQpoQm/W?=
 =?iso-8859-1?Q?r+2vl/IjLxc33hVJMg8yFZq9SPijKrAJcV7OjKADVqG4tDbC2N0vBVgaVQ?=
 =?iso-8859-1?Q?fGaXM7Xh8a52natRlp/F1b/vgvx2Hz1qXl4gy9IHTzrmH2WhUZCI+xATry?=
 =?iso-8859-1?Q?rDyfdkbCqKmGS7STTIg3OOKDaindk01uk72/Bfz6HjPVRAAxpMG8b7HI2L?=
 =?iso-8859-1?Q?2pB9X7DRpHYpG5EQSdanmNkeTZck529XkXStRMtbgPjodk8XUx7sN2boW2?=
 =?iso-8859-1?Q?ehh9nSrJwvnVa52TDjRwiqnU8DTqjc2szcn0IHGB1dbJmrRPSMbXvhBfk6?=
 =?iso-8859-1?Q?rdQfR7PzPsMNnN785I0OOrWrqXYb6xTRlnghSCPNvcKoD4PWfr1tIIbnFZ?=
 =?iso-8859-1?Q?v87f+PAlc3ps+/KXI1qj8x9mNbxe6H6C9QaC8zZPqCtFa+qVbaJyE645Cq?=
 =?iso-8859-1?Q?LthUg6uL783cPJs0P0EdpdbXbuahWT7Ty8qcphtUVznmk8/BNmRpV1nkWf?=
 =?iso-8859-1?Q?CwEgDXt3zlHS+hjdzzYgtnhcmN0z9TEByGwj2CvgbO/QziSI6Hn3RkYZ0w?=
 =?iso-8859-1?Q?YytcSMm80wuHdPbIyDSC1exzxYHHJ0kTACs7yfklwRXWQjBj9TCdPbTAJQ?=
 =?iso-8859-1?Q?bYp5qWPuBqj12fso8Wt60KwxVuIgK32y6b3HKBJnjeciWqr0cpuZZiq4+V?=
 =?iso-8859-1?Q?JKBdwCXWpGW9mY4GiZ18FDvLx+JOYTiKelU0GTCnsFB5fSd2EXuu2IxxeY?=
 =?iso-8859-1?Q?6Z3kJ/ivNY1PObHVFXRX7LvuRHQwIOLnT6Q7isKv1QjvfVlampXYRalCn9?=
 =?iso-8859-1?Q?WNzXxFD+FHcbX3dLxnfaWdiZ0PRJKeZwWfXww+H809dAt1S9OV7CdQQwVv?=
 =?iso-8859-1?Q?+LPTfNU8PfxUSZzGI+LtS6P8Z50aFvY3dO9pimJj47WRR7usQjMuwYrFAy?=
 =?iso-8859-1?Q?ERckibLYMCcdIbz/E6WSImrRf66yBPxIRQFN/A0YqCwuWbuZLGm/asNU0r?=
 =?iso-8859-1?Q?MyMNtI+uSWdHrf/9bnKnyPA/HfHibCm9gmeBwGbVtX2jCbyJf+kh5WxAv6?=
 =?iso-8859-1?Q?ChAWn4xJgPaoCgbhvzaB8g4MkWkTFIMLoYVzk5x+JYb5yygc85EF4B3u/s?=
 =?iso-8859-1?Q?h1a5LdB04w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BbbSCS2G2+/sb23kY9GWEe7c1+ktDpEL/XePwQzu9yBgoFPk+lV0mBqEmhrVJSrx5ppnSzGc0HIsIXAZoiu6yPVQ0BiWR14JpKr1Qwpy+8T+4nugAOX5L/oOOzIQtWh0qm1PcIKOrKcngz4G93C7ry+9dJe33vCMqee50viH3lZcVn2ZLehU+OKCFKLgK2OHsMfRCDjsd2lrrwdCIFAGHo3/Bb/2U+n4RTWL7z9FMqd+x+YpEfazCqUl8EcTFUi6wWNTCqusgyKk8QeGP0/BHUJ8zFGQ/pdRo/t2YKj4FeAIIcpxquok1SmaMOBk5xz2339un7GklfyFKqHzct27Bg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3a3f8f-560d-4e3c-10ed-08df38c2c404
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:07.3164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhIOV1tgRM4pKE6mxxQLAtLtdwNnuuExeqCIN8wgMRqwiInU7BBTVhKURwMw4Nx6O3Gyehb4JtrP3b8FVY3OeIr3FK/1KO1Gi7/OQDPgBQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF4565C7005
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 4 +++-=0A=
 hw/core/machine.c | 2 ++=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 3 files changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index b5ac9c8670..db9db537ff 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -269,6 +269,7 @@ struct EHCIState {=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
     uint32_t ctrldssegment_default;=0A=
+    bool auto_hub;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -336,7 +337,8 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
                      ehci.caps_64bit_addr, false), \=0A=
     DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
-                       ehci.ctrldssegment_default, 0)=0A=
+                       ehci.ctrldssegment_default, 0), \=0A=
+    DEFINE_PROP_BOOL("auto-hub", _state, ehci.auto_hub, false)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index f8f5b01117..0103038cad 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -43,6 +43,8 @@=0A=
 GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "sysbus-ehci-usb", "auto-hub", "on" },=0A=
+    { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index f371e567f3..29b85869c3 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2636,6 +2636,7 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
 =0A=
     usb_bus_new(&s->bus, sizeof(s->bus), s->companion_enable ?=0A=
                 &ehci_bus_ops_companion : &ehci_bus_ops_standalone, dev);=
=0A=
+    s->bus.auto_hub =3D s->auto_hub;=0A=
     for (i =3D 0; i < s->portnr; i++) {=0A=
         usb_register_port(&s->bus, &s->ports[i], s, i, &ehci_port_ops,=0A=
                           USB_SPEED_MASK_HIGH);=0A=
-- =0A=
2.43.0=0A=

