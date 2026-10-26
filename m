Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A169606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ZFrPr6dR;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=xGvXAAL3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLUbN-0006F7-Ge; Mon, 26 Oct 2026 19:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUbJ-0006EX-9I; Mon, 26 Oct 2026 19:59:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUbF-0003sY-Gy; Mon, 26 Oct 2026 19:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793059173; x=1824595173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=U18P1XmccBIxMkn0rg2yNli9Xahd1z7ZNFl+z+7EPzY=;
 b=ZFrPr6dR5lRA5J8+5V9a3NAEC/Yysi/ybHTJYSoaw5/jU5lXVhF8bcnK
 bT7msmii7B9qxoppUwgoQaVN/GHSbzM3ls+/90fYN4guQXNQluxJmBjMD
 R2v1oM+eryzzH0w8NddCuRaaSYnEAPcs7Z2jyGbgNXUWLmSjlWhvDihI+
 aZjCZzrN65YBbUaX3W+CYIS3M1wnI7lK4bM+MXfIYP20SvM9FtJvj6FlE
 Fk1R2sDS6R1TiVr7XhT+PFEEpLN1ie27dpqXqTs2+L0XkySTHHVFUYqIo
 DWN2c7kAbHZvfeuLpA3M1uYUGQn9+tE5DYpigQIqOwIzw3sL4aYh59fy7 g==;
X-CSE-ConnectionGUID: Ue5Di6PBQMClAl3C47ODQA==
X-CSE-MsgGUID: 34xzqPR8SUuiB2wAmlW1lA==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; d="scan'208";a="154831161"
Received: from mail-westcentralusazon11013003.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.3])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Oct 2026 07:59:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5Kq6DDec8PtpN9ii8lElEx2S0K0xEvkM8X+TlBPaK/ILtZROoD7efZ3dvgC+5INt6YB9euHLT0jnBS6lTEzchOUVpJtyVYgdE1uZhwFcLBV4ubTvTLFJuhkvnv7vfkh7y5ikx5Bb1Q7JJ8nDIY0AB70SAfv7HpP0P0Ep5Lwav/2EW+LaQgvpPP0Bw2JS3flk5Vl0fhSeckpsJEpkLk5r03hCobQBx2F+3/qRrT8L/2WSXz0Up6ke8UIE5cWL9xnWKExRgjZyY9e4ZMjGI29CqcEy/YA80KOVfwB+TDjzfVJfinbCpcpMrMRKqar28X58H5aXDwdbNlesGupc6irpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U18P1XmccBIxMkn0rg2yNli9Xahd1z7ZNFl+z+7EPzY=;
 b=HoTqieljPBrjSdN39zB55O7FrzK5ivOquhJrLjETLEwcF+RjaX3uihZ2e/yfHiY7+kgRri0/9iHj+zJx/BXgIX+u5Kx/Km8BbFisYRjilbNuKOyiCaB/CsU0TWmn/WX2W6HyO4yLHIWuGDWmpYeyMPef3M9DiyOaORrCoywhbWcTwmLi2fNHAhBLYr6Y4MjfsRhQ0Q0cbpfpdP8v2oHXAvTeMZjBHd9AYGpjg4AkeEWfjyE2WoWTxPmpvzVL1UigWnikNeny9WoiUguiBY7DW2gCzsc2/thlWzG+tMa2UDFpCbJxLzK7Dp9v+WmiSzmOl0cq1HeeFfWqhYN6bgwxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U18P1XmccBIxMkn0rg2yNli9Xahd1z7ZNFl+z+7EPzY=;
 b=xGvXAAL3PDssVVH7uSIVU51kVYV8RLKoZo4ORfv7KKW+8XqRcFdibIt9XDz9RG+FDrWJuBQMIjiX5YNV8PU7s8D8mMPCaUsx1Y7TtmNm6vREhtgNMWiTux3dzrJjr+3I1QweMs6qIiVLq2jD97IUlJi0PEGGhqaOrcrqK9HO49E=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB993579.namprd04.prod.outlook.com (2603:10b6:8:432::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:59:28 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:59:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fustini@kernel.org" <fustini@kernel.org>, "sunilvl@oss.qualcomm.com"
 <sunilvl@oss.qualcomm.com>
CC: "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "shankar.c@oss.qualcomm.com" <shankar.c@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "prajwal.n@oss.qualcomm.com"
 <prajwal.n@oss.qualcomm.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "mst@redhat.com" <mst@redhat.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Topic: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Index: AQHdXHGe0JoR77z4oE68l74n64s/PrcJCamAgAIJGICAAjKXAIADTdWA
Date: Mon, 26 Oct 2026 23:59:28 +0000
Message-ID: <006d2c10757afae0de37e150a447b3f251216da0.camel@wdc.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
 <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
 <at0j1iQQVBCvcSI4@thelio>
In-Reply-To: <at0j1iQQVBCvcSI4@thelio>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB993579:EE_
x-ms-office365-filtering-correlation-id: eced86e6-c555-46ad-7686-08df33bd2bc7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|19092799006|23010399003|1800799024|261026140227099003|38070700021|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|261021135927099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: oyxr1VhuIclR6DWVjR4WGtgSVo4mjwAKn7nZbZMbXHc1Kx6nLcAsib/gRsIqlxZMgRSEXNYpTHJ5sjVjI3Xhh5HmJcU+98SUrr6DwR3KITycxemwxu2E5/0TunEk2SFAIfFbqahvpmOTdvimeYCnpE22JM2Fgr3Pi32AwZlz4bQXyfSQcWohnd0nE3IhNGWBtCIEFlk+b6QishVHmcixem1CcBiSvzrKxt1INofrzQo3Hx+AezniE6OjK5CRHNV+bmDGwY9Ek25hib/mNUsZkbmPVfpJu6jWXas8L+uoJ5jEDIkjtb3Zc8nMUFEWupRL36UULpoc14r6b8vfMRJzF0uadd5rDs4ypTrxS0tX6MT/qOusx6Q21ZKIjYY//J1sRnasSPIfUlk8DfftPpChUH+g5LdfF25JZ63rshU3hBOUYIK17UpNzZaaaQH+JZJignfCuUJnXlI+JyJq8tSrRfCfne7uM0XY9XfG/wXJtN1tSTnD4g5qL2lUsyHKS59D8SeGLvYRZwYRTkjZyCs+SKkJCzul3gUBeiO6fJ45sH8D65UX7JRDARcNZKHpt1CBm24LYTQGp+QgFe6kjF1Xb6CL9nzUNcw5uPmQBL6gdtJxWVRjbQdoq1SoTvslyqO75uRo/IJprlXUnuvcNy6drgg3vT784Xfe0HcBtfVAq8l5hP/SV+UqKZFjEt5yT0Gq/6oojFU9POiubvtrNxr1tl7Gb9jvfRfuauppAvp21g0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(19092799006)(23010399003)(1800799024)(261026140227099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021135927099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVhDcXVaTDU1eXg1Tkd6NkxOVUlIc2JyY29mRGtLSXNvTUJvalJHSmxUN0cy?=
 =?utf-8?B?bXdiT29hcWFvTUdIMEhCNU93b2cvYlM1cWowdXkxZ2F4dGJUZkhlY3gyWkNa?=
 =?utf-8?B?dHBZVGVERzVxTVNXZ1pUaHJhTmpmdUxMUXBKODU4alJWMXNCOFBaQlo2Ny9F?=
 =?utf-8?B?WGtJZjN5NEFXZjZxNzk2ZzZBNmV2NG9obG96ZjZOc0pIdFF0Qy93YUpjR2ZU?=
 =?utf-8?B?OTNFcXlQQ0xwRjNMZFoxeXJOblJmMlQ4SVJxMjVodFZBWStHMWV2Uktkenpj?=
 =?utf-8?B?cHpFTDJUZXJBZHIrb1FlQld5bnd1RHlWSXRpNTBZZm5HZ0F0QlJXem5ZSFB0?=
 =?utf-8?B?MjVRQ0p6NXZ1NG05KzZXQjVUdEk3ekI5ZUo4Vm5PY20vYzQvQmJURVBEeWgw?=
 =?utf-8?B?RUVTa1RRclVIcXZlNVMzV09WaGtlZXVIdzZlSkdhdk9DYXVHZTRZTUFXbHc4?=
 =?utf-8?B?VDREUVFpWFc3VERXejlGS1lBTEFjMjZPYmplRTNGR1I2TEZoSW9sU3h0Tndu?=
 =?utf-8?B?V25JZjhpaXVpZGU3U0FYWFFJSkF0YmZZVUxueVJWM2VTT1pEVG1KR0NkMU4r?=
 =?utf-8?B?UEYyUEkyMll4SEI0Z0JJTERnQy9IUFlvdkRqUkUvNk9FRTVYaExka1FtNDJ0?=
 =?utf-8?B?ZTZ4KzdYNS9hQk5yWEdzc2h1L0MyYkFKdkxXVGFuV0ZWa2VPaHZUUCtZUitL?=
 =?utf-8?B?TERMK01paWVkdit4cElWMTBuOEJ5U3BrZWtqVDNCRGgvOHU2Q21RQ3pNbFFI?=
 =?utf-8?B?cklidUp5WFhraDVXL2g1VVpsRUx1Y3FyVVBkblViemxMMU1SbStBZkR2ZWtR?=
 =?utf-8?B?U1lhZFE0aGd6QXpwOUZkakFmM2xJeDlWOUJ4ZnVFOUZ4eEFDOUVnTnVqeFZv?=
 =?utf-8?B?MDhDYXV1YTBSK2djcGZuV2NuWUUxS2tnaXV2UGFKVnY3bTlpRE9FSnFVNjVX?=
 =?utf-8?B?ZUducldpS0hpVGNmS3RhTFd1emY5M0IyVUlpUGwxekRLNE0wUWtGNHYwV0R3?=
 =?utf-8?B?dE5RZThac0U0cTZzdXp5aUluUk0yZGdIUjBqUm0xSEgxTHBGdzlnTVRLNU45?=
 =?utf-8?B?NDNvYmlmSGR5N1FJTXV6ZUMrbHk5NGVYcDQ1L08xV3Z4anJqMnBZUFJCZXNy?=
 =?utf-8?B?ZkN4dTc0bnhNQzh0YW5XaHcvY2NRZWkxa0hkWFdJYnVMaHpSRUFDUjd6WTUv?=
 =?utf-8?B?blhXOE5iSHlZQzRFRkYvRjM2Z0duUHNQc0kxMXlzSVZlaGVIMTREZy9Kb3hY?=
 =?utf-8?B?RktWS25nUHJPUmtYTklhNGNUd3NCQ240QWwvNENkcnJzWkEyRzkrc1BucWdq?=
 =?utf-8?B?T2s5ZWl5VTArbjVDL1QwUTMrUFBYZWo5MHNGcWdVV0w3Mm5adHpXdXAzWCtw?=
 =?utf-8?B?bVFzZFRTK0FEaU9FaVVvT0ZOcC9KWGdIQzBqUWpxMXJyeHA2THd2VFgyaVp4?=
 =?utf-8?B?ZUwwMVl2UWJycmUwbEFZaFVkbzd0SzZrZlZ1Z0xncnM1bXRKY1M3ZERzb0dx?=
 =?utf-8?B?YkdVSGNZdGV5QzlrMzRmRUJmT0h4Y04wWktYOUZMUXNBekFSN0pjRHpDeWFP?=
 =?utf-8?B?MU8xbnJwM1RpS0V6UFV1aG1wc0ZoT2FLT0ticGtxK25ZWWthUkV2TEtxaDMr?=
 =?utf-8?B?Z0pkMmVqUkw5cVJBVkFhdDVmOHl0L1p3aTUySVI0Ung5OEhXWVpPU0NGNFNI?=
 =?utf-8?B?K0VLajVpMEpoV3hTdkZOVHU5ZDRRUHdEVGFZNisxd3BUckRoek1UWWUxdTQ4?=
 =?utf-8?B?dVRMdkNCR01TeHIvdWg3c3VyeVAzTlgrNkFwTys4K0hxM0lEaExqTDNMdzE0?=
 =?utf-8?B?Ukl1bFhrUjF2dnJud1h6bzFLRXR1K3o0bkJWNkRhZW9tanlTdzMzZkxWK1dr?=
 =?utf-8?B?SVRLczVNNGJ4aXRsYXV3TUZXS0lqS3o0anlEMXFiSXJtd1I5VVhvY1FDeE9x?=
 =?utf-8?B?RnJtL0diMG5KdS9qRUR3dVV6T3RrVFVqdS95MGZ3VlBwNUFObTJESi9ZemVp?=
 =?utf-8?B?ZVlyVDNvZ3VzbkdwOHQ3TFNPcktoUExaRXFJc3NQMU52MUdab3I2RFFzdDRN?=
 =?utf-8?B?QUJsS3g1dGxiM3lUSHZEc0F2R0FON2lUSzlIWWJiQkxTZzA2bmZKTk13a0Er?=
 =?utf-8?B?NVgranlYR2g1azF0ZTYyOEtFbjM5TjBsdWZVdXRQa2NiNXVsRTlFMWJ4aW94?=
 =?utf-8?B?eXNiSDE2NUhSdytKcUFSekhuTnFQbzJKZ0RFZ2x5K2hNejEzWFJ5aDhsMWZL?=
 =?utf-8?B?TVRnMHRNLzVsZ1Qyb1dnUTYrRWFRVG9tK0YzMmZwQWp2QkVLTlhsN0dkajhV?=
 =?utf-8?B?cFZ1VTc3SXA1Q2FqRzh5S1RuQ3RxRkI0VzF2SUw2RUIxclJtaWdEZU1LeFhG?=
 =?utf-8?Q?nJRlMl6gfjTc4pfRyIpSz62XPdH0b7Qdj2fVRpBcRTdem?=
x-ms-exchange-antispam-messagedata-1: bBlPtaR+9xyNFoC1d/iGMNjkfz/xL2Mg9bY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658E56B26623C74295A220BD18C44F5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yR78X626cMhCgfXIA4VvD7QRvyIn0qHrAg065hqfl3wk+qzKwUVjbT0J25wxjh+n5rH4fyk7WBoTv45awsXsxXc+0oVGxmuQ4coQeB7QzRjJiE/O1bvEdB9d4N3Dwc8pFDV8iiaZX/QdQ/IMIIl5E05zYv0D+vKTKZ95g71XDi4lFxd7nZ2H+qkFo+PgTolDzT8DP72WOOSPDIqasKRHGFOHsr7Ur+019l4b5uMzTLJo+UZ6hSvDZMXsxBHcyjI7aCLvdAF+Ut2Hw6q4XaYkmySQmtlZSjrb97ptiT8STh9Ui2BLh36/OTQLBXdCjSsiC6lvZuegOiqNPQ+suAQFvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oVSpoj74bYdJUqXoult1pZJmeBSBmn8xFUClvBx+vLn/oxiV9gvI77WCoSQU7JuYnUEyVs0JJ4YVce1F6VrIlJ5Sc3ML2/5Q9ZM1L4RA+vthnDT3g2BygzUS/OsIT/v+vGMgKFFemgg19fn7WeB/e2p3x/+q2J+LJAuk27oQt2f8D6wUBWH0Y1k5czVe/7m2o/8ZX9Nbwigm/D3LoZvIxbfQ0hnnWG2OVWG+Q0fLO/2Dd5v9xSzYq6ZkgPrmrNigFqtTw4gs9RYjQN5bdF2SsOkYBqWDgFhMF1gQwL2JBeJViix/nMWjAeHtZ72cuWAam2ty7xafHJFzkGCgKR2foIkLGQ1kB85W2AduT/AcUIXE0QZ/8NHIFhXp0SpCC4fkH2Ny3HPKajpg/kOL8mEMG9H4Ah6wAjl/kq1BwJUCotfXs/OvlWeegcHtNqvRRjfSk7u17IegsaCwz9PKVB6twYGgJIhZ5MifpVQFePwUtbus/H+lrSQsnhwtLZnpiyibTRNKKMYB0aWW/Uaccbcku2NoyPy72YdwwkvdJNbG0golDr7af8xCIjU0nbJXI3j+eU7x/NC4qSGier7TKKvjYM0Oc64u+USzPYgjS8S5T9Q+95ki3aJYViY6PKX7563t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eced86e6-c555-46ad-7686-08df33bd2bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 23:59:28.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXdFT7eMxgkjo+wAHxmETfUKdqcZ4ylwQiE0emJ1e4Xp5vVam84j9T/ums/XGzCjfYpmKGI6ZneWmn60/t4qiWjJQhJRWwalV4mfVDMZANc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB993579
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTI0IGF0IDE0OjMyIC0wNzAwLCBEcmV3IEZ1c3Rpbmkgd3JvdGU6DQo+
IE9uIEZyaSwgT2N0IDIzLCAyMDI2IGF0IDA1OjI4OjMxUE0gKzA1MzAsIFN1bmlsIFYgTCB3cm90
ZToNCj4gPiBPbiBUaHUsIE9jdCAyMiwgMjAyNiBhdCAxMDoyM+KAr0FNIEFsaXN0YWlyIEZyYW5j
aXMNCj4gPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEyOjE5ICswNTMwLCBTdW5pbCBWIEwgd3JvdGU6DQo+ID4g
PiA+IEhpIGFsaWwsDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHNlcmllcyBhZGRzIEFDUEkgUHJv
Y2Vzc29yIFByb3BlcnRpZXMgVG9wb2xvZ3kgVGFibGUNCj4gPiA+ID4gKFBQVFQpDQo+IFsuLl0N
Cj4gPiA+ID4gZnV0dXJlLCBpdCBjYW4gYmUgZW5oYW5jZWQgdG8gc3VwcG9ydCB2ZW5kb3IgY3B1
L3NvYyBzcGVjaWZpYw0KPiA+ID4gPiBjYWNoZQ0KPiA+ID4gPiBpbmZvcm1hdGlvbiB0byBvdmVy
cmlkZSB0aGlzIGRlZmF1bHQgaGFyZGNvZGVkIGNhY2hlIGRldGFpbHMuDQo+ID4gPiANCj4gPiA+
IFdoeSBub3QgYWRkIGEgdmVuZG9yIGNwdS9zb2Mgc3BlY2lmaWMgb25lIHRvIGEgdmVuZG9yIGJv
YXJkPyBUaGF0DQo+ID4gPiB3YXkNCj4gPiA+IGl0IGFjdHVhbGx5IG1vZGVsIGhhcmR3YXJlIGlu
c3RlYWQgb2YganVzdCBwcm92aWRpbmcgdGhlIGd1ZXN0DQo+ID4gPiBzb21lDQo+ID4gPiBtYWRl
IHVwIGluZm9ybWF0aW9uLg0KPiA+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2shDQo+
ID4gDQo+ID4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIgc3VnZ2VzdGlvbiBj
b3JyZWN0bHk6IHNob3VsZCB3ZQ0KPiA+IGF2b2lkDQo+ID4gZGVmaW5pbmcgYSBoYXJkY29kZWQg
Y2FjaGUgdG9wb2xvZ3kgZm9yIHRoZSBnZW5lcmljIENQVSBvbiB2aXJ0LA0KPiA+IGFuZCBnZW5l
cmF0ZQ0KPiA+IFBQVFQgY2FjaGUgaW5mb3JtYXRpb24gb25seSBmb3IgQ1BVIG1vZGVscyB0aGF0
IHByb3ZpZGUgYW4NCj4gPiBhcHByb3ByaWF0ZSBjYWNoZQ0KPiA+IGhpZXJhcmNoeT8NCj4gPiAN
Cj4gPiBJIGNhbiBjZXJ0YWlubHkgb21pdCB0aGUgY2FjaGUgaW5mb3JtYXRpb24gZm9yIHRoZSBn
ZW5lcmljIENQVS4gVGhlDQo+ID4gY29uc2VxdWVuY2UNCj4gPiBpcyB0aGF0IERyZXcncyBDQlFS
SSBzZXJpZXMsIHdoaWNoIHJlcXVpcmVzIGNhY2hlIGluZm9ybWF0aW9uLA0KPiA+IHdvdWxkIG5l
ZWQgYQ0KPiA+IHN1aXRhYmxlIENQVSBtb2RlbCBiZWZvcmUgaXQgY2FuIGJlIHVzZWQgd2l0aCB2
aXJ0LiBEcmV3LCBwbGVhc2UNCj4gPiBzaGFyZQ0KPiA+IHlvdXIgdGhvdWdodHMuDQo+IA0KPiBS
UVNDIGlzIGEgUklTQy1WIHN0YW5kYXJkIHNvIEkgdGhpbmsgaXQgd291bGQgYmUgbmljZSBmb3Ig
dGhlIGdlbmVyaWMNCj4gY3B1IHRvIGhhdmUgYSBzZXQgb2YgY2FjaGVzIGRlZmluZWQuIFRoaXMg
d291bGQgYWxsb3cgdGhlIEFDUEkgdmlydA0KDQpMb3RzIG9mIHRoaW5ncyBhcmUgUklTQy1WIHN0
YW5kYXJkcywgaXQgZG9lc24ndCBtZWFuIGl0IG5lY2Vzc2FyaWx5DQptYWtlcyBzZW5zZSBmb3Ig
ZXZlcnkgYm9hcmQuDQoNCkJ1dCB0aGVyZSBhcmUgbm8gYWN0dWFsIGNhY2hlcyBoZXJlLCB3aGlj
aCBpcyB3aHkgaXQgc2VlbXMgYSBiaXQNCnN0cmFuZ2UNCg0KQWxpc3RhaXINCg0KPiBtYWNoaW5l
IHRvIHByb2R1Y2UgYSBQUFRUIHdpdGggY2FjaGUgSURzIHRoYXQgUlFTQyBjYW4gcmVmZXJlbmNl
LCBhbmQNCj4gaXQNCj4gd291bGQgc2ltcGxpZnkgdGVzdGluZyBmb3IgdGhlIFJJU0MtViBRb1Mg
c3VwcG9ydCB0aGF0IEkgYW0gdHJ5aW5nIHRvDQo+IHVwc3RyZWFtIGludG8gTGludXguDQo+IA0K
PiBUaGFua3MsDQo+IERyZXcNCg==

