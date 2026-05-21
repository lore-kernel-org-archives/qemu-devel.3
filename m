Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E934CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4aW-0002Rf-A6; Thu, 21 May 2026 10:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQ4aT-0002Ov-Ch
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:41:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQ4aR-0001r0-KM
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:41:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L1MgkR3895286; Thu, 21 May 2026 14:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qj3BoIvQ4aJ7RfkfU9jC0XyF4f+OtrjRbdIgGMLxQmg=; b=
 TvgsGRiFk4aYLq2/NSzExREFwPEQzgL6JhJ2QEN+6x4VIUil5ul5XnkcsMhS89rF
 tubK78QEZMfrUOhR/si5wVQxNqEjmLQm+1OTYq78VxsfvFjPYdqrncbN9LCkBzRM
 IW7PJ57tzliGHIpYC+70ZingWaGRsFPY1pYGlBmgJYDwcLrLs0LCkIeOxvIKUuzI
 VdWh6+Gv6iyGSLvrYi/LfWCI0s8J+/azZBCI+ZL1fM5g3x44f5twd0kPGxI4bE//
 OV3tIoW7twkeNH8KOZQlkcvBgm5rQhtLueFHliuwvwd50d9zqtHNtSuoWBmsjUl7
 1rfewUGwMmATbcuuRzy8Dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4q9dv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 14:41:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64LETwdb008127; Thu, 21 May 2026 14:41:21 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e6f1dqygs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 14:41:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwHOLFPIo3TnxZQfPLsmBQEJiElS20iC8VQkB6GkMlytbTTGUis+z6jhAk4im+bN1ZXS1wpNUWc7CUrzqHGfNMuBiQUSwh+PHQwEudNPXE+t46dVgzovB4I4yqbc1MhfLzefABsfr+XoQpowOpgclWhb2l8cFltYM3Sdnrcwl6/4qQ7MOmkb+vDHQ5RHXpGcCSDP5dFr8tb3gk9ZYJ69sRQuthEoXVjbU6h7qQzzFhStHA24l6q0pis626OI1pDxk0tuDEh8x+i0RjQUOtXLrjA9J9GO+mTmHL4pRp881rWHtDpX6LMr/h2Vg9ktrIjZx745xomROYQOR2IRisX+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj3BoIvQ4aJ7RfkfU9jC0XyF4f+OtrjRbdIgGMLxQmg=;
 b=TXwcwHGH5R6LENSkbWlxOC7J9jTrwbcsnHIazmYIDsYULBt1uKKAtQkU4WvEet68jDhIiurA843+264RWv3LyIrTO0bSm85WNpva/5+o0GeXBhcDDJYaYGYp5kNQB9eG+D5WI0Zl4cQtOG+Z6sFzrSPiC5Xu+3802Xuv33adgMLWEqYtw4/nhoWyLD/foIEoTOQrZiz1HPZCEtuYFIxWeA3hB/JSwzJWwPyCj9Ts5BjdibyCt7sW0xpSipd7bF/lqzVmPxuAT+dHB9Bnb2nSqBvZh9vf/nBu/kiUC/2inwkoTGnTHQP4ZfY1epA0bzz5pBxB6yxL8d4WSQ/wVjP4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj3BoIvQ4aJ7RfkfU9jC0XyF4f+OtrjRbdIgGMLxQmg=;
 b=hnzJIeRWaece0y91uI25RlLhBC8kAeh1nymC2zH2Ry50j1OR4FD1/5d41wuAoO5PwVozBglq8lq1zL8HPuvFjin5eNOX30Gp1OUL9GxG1gzLxaAe6neB+cjZ8AWptamSbNjmlVegGFRxHS56QPXDM/Oy2wrr0d+w3gggoBu0c5w=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by LV3PR10MB7794.namprd10.prod.outlook.com (2603:10b6:408:1b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:41:13 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:41:13 +0000
From: Jag Raman <jag.raman@oracle.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: John Levon <john.levon@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WIAAAVgA///FPgCAAEZ0AP//wVuAgBQ414CAAGlVgA==
Date: Thu, 21 May 2026 14:41:13 +0000
Message-ID: <AFCACCA1-C406-4E5C-A338-A40265962598@oracle.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent> <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
 <67f25191-a755-47e4-a560-3d1c755fb77d@redhat.com>
In-Reply-To: <67f25191-a755-47e4-a560-3d1c755fb77d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|LV3PR10MB7794:EE_
x-ms-office365-filtering-correlation-id: 8c33fd8b-9a5e-4ad2-b9c8-08deb74701ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|4143699003;
x-microsoft-antispam-message-info: owLj+AAdwerb6bqSuYR8dEHwC0LJxxcGPLDilDZ75xtzxoiM/Q1G9liULtJfHqb0cwuDR3CxMKzW03815ZLV5Ox0Q7vmU3Q9ecTtCLw6g5jfRVcGEFYWYXMuScQlPlma2rMkNEQqTj6Oik3TejjREYm0QV2jRgn4eQiKl3HbMo+dcFnOfUnUHWwgg4+KDSJisTCjv/zktmK/gcDu9r4LGIvy5gM/+CNA0+cbVEj+s/a3IxQAZHq2a+hj3GL4v7KtElcLJhBt0upmhc/2AXb3g/wf+50ZEjozreriyA7fHl70PgvsapY8X0e951qAZJnFhNHDOu0+Uwp2m+flL5FM8f1r30Rzl2pU4R0J2SMFywj89Ks/zwW7SsMyG9FjgtmXKM8K/LsBEN9iGeWY4iwPKh1Wrt4rsC/nUtAzhX73H72S3yFxSHaRofsqLLKrZ/yyBFQEnA1H0yusfkOhzq7Tf56o6Jk807WirJ/avQi4EZINaYmsubEiubiXx1QR9PvEjPo9XrKOVKNAYj54mTh1qkk62nPx8VAF0zKBLfGpzz0uxFCoY2KJIModdmJZKwR44TFJVLQMU3CImMZFdfMSdEUjjMKGJ2t4WSaz1UOT6IIQRhM0XNZgU42VZaIl032KovKRRHIVakjohnihxZppX7xpcybeeSAzRuTHz3BQfGl/mL5nYssXLR2HF2bJF9Mlt5c4AHJKGraXKv3EYdhUD/ysF/0WEjV7XvS4djZ3vQLdDG+3J9FfIwzh0PKkumnM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJwZGFySkhxNWhkeTFha2dSYnRaOE5PZmNuSllXK0hYMUludmR3MVJtMDk0?=
 =?utf-8?B?WUtRNXBBaXdhM0N2cjYvaGp3Z0p4a29NeXdQQmVtR3pDM2VrUXFXTkI1eFZO?=
 =?utf-8?B?MDU5cnp2TmR5eWxPRnc3UUxhaFdqZ3FXK2dCK1N4TG5HSW40ZGRFamIxNUNB?=
 =?utf-8?B?d1A1ZVZXVFBGbXRveGdJOWwwYzBUNURKcy93TmgvSjlFUmtKbU93TzhsRm9E?=
 =?utf-8?B?QlVaV3liLytYd2lOcER0bmRoV2laTGNBSzZYK3NucHI4YmVHNXJOTmtHQk1Q?=
 =?utf-8?B?Ujl0MCs1NUNKTHhaVG4wME5wcVQzSTVDT2VxbGlISUpJcDZDSC9NVzhydUZZ?=
 =?utf-8?B?Qy9OcTJNbnRLbmNEZmhpSWxNeVZ6SUNmempoeVRGN093bENxakFyLzBpak84?=
 =?utf-8?B?anhzb3V0ejg2YjFTemo3MEdQaE9Vd1QwTHE1LzJxUWN5bmROQWE0dFlHSXp4?=
 =?utf-8?B?NCtvQzZOdVRXQUhWczlKeHJtbCsxaXJlSWhCNXJ0UzF1cHY1R0hYMEpMREdN?=
 =?utf-8?B?cktzTmRSVEtpZGRCRk54TXgzZkpyYzFsKzV6clUydlFqVE0vT3Qwc3pzNzNJ?=
 =?utf-8?B?SnpsVVhsTDVvcDZzRnQ3MFZaUXBybng1eEphN1pjcFRTWmU2ZjUvTnNzL0ll?=
 =?utf-8?B?NSs4VWhxUlN1TGs0UHhKTnJXbG1OTllVNEx3elllc2FqQmJxNStIcEdYYnBU?=
 =?utf-8?B?bjZCbEJRb1FkVGFzR2h6M1NodDYva3QyTGY1Z0tjT2VlM1ZXMG1ML3Z3MGhH?=
 =?utf-8?B?N1NsUnArSVhUM040alJUSlZJTkR2TDhXQkxTRkNuc2RpenloU2FwcmFQbENj?=
 =?utf-8?B?YnZYblRHdTFxcTc4aFcwdGQ5c09aemRsWC95elB6K2hmZEdUaStpemFoa0ZO?=
 =?utf-8?B?TDhCZVpIcFkwWldtTWhwcy8vQmpVdDNianNHbFlXakNaMUo0aTBNYUQxRk1I?=
 =?utf-8?B?aUdyWDd4Wml1bXhNM2tsV2FDRWZuWnVnVDFnS29RdngyRGtzWHE0Z1diSGVO?=
 =?utf-8?B?cUhGcEdZZm8xT2NkOUdqbXIvdkJ3d2lTNzJqNHZvQ2loL2RmTW5yNzI3Q3Vq?=
 =?utf-8?B?c1ZuYUdlMHRvVTdxR0hRQWdIdW8yS2phTHJFWTVlZTRidUVxWUZzNVFuSito?=
 =?utf-8?B?cER0VEpIbUFmOXp5Q09FMWtIbzA2ZXhXSnRTdmxIM1htOUpWWXFONmFPWVp5?=
 =?utf-8?B?L2s5a04zeVc1cU9FdlBBRC8yMkR6NzMrRVZ5Q0ZQeld4Z0dTeHBOLzhUcFQ3?=
 =?utf-8?B?UFVaWE14Rm14ZTdsTmRTTFc4SzNUZUYzZmtWZ2x0Slc4WUthdjQ0RjdrTGJE?=
 =?utf-8?B?WCs5Ri9PQVBLM0IyaVJWS3lBc0ZwNEwxRExSQ0dKcFhMOW02SGZiMk5ZRXlE?=
 =?utf-8?B?WkNYelBSS1hDbjRBM292OWl5M0thZGwzM1FJcTk4ZVlFYTZHdjJNeWMzMmpW?=
 =?utf-8?B?QlJtMkxZaDBQOWd5KzJUZ2dLMTMxZ2UvMlVXWWM2UnhzUUozTk5uYVk0Q1I5?=
 =?utf-8?B?NG1vVSt1VUYyOUE2SGt2c0ZndW1jV21zN2hGbGxBVEZDaUd4WFc5elJBQnRp?=
 =?utf-8?B?bzJrbnVVQmY2Z2dnbnkzMkJZL1JjbnpKWkY1cVZZbnJVTnM3TjdQYVVORExR?=
 =?utf-8?B?TmdCZ0h4cU9lNG9CUXh1YlNMUG5jT3l2UklsM1hsMjk4MlN0WlJzZVV3Wnh5?=
 =?utf-8?B?Q2NBUzBQdjNTRVluK0Q3elcwazU1SDRXdVZ5ZllGL1BwY2hKYW8yR0tyQlVs?=
 =?utf-8?B?dUUzSWY4SmZyL0FsUFU4VEdMMzAxRzZqdlkxQUN4R1d4cDQxbzFJQzlCaHBM?=
 =?utf-8?B?MmFuREVHS0VrMSthQmtOb0pkQzFuTjYrRkpnRXhtOHR1MmZlUG92QnRqNTBo?=
 =?utf-8?B?NGlqNW9DdUF1MFNaYVFlNDJucTB4OWxnU3BYeElRR1hpNXBpMitLR3pBZ0hL?=
 =?utf-8?B?YVZ5cWFLemFSYzcvc2lyQ3NXbXppZ2pOZkhFRjNjOVRra2hvODlESFZYUDBu?=
 =?utf-8?B?eGtQQVBzbzdEeHAwU3M2WHYzN002NjFYeEZHTW5renZNNTFRVzAza2Zhb1NI?=
 =?utf-8?B?OEdpYjNpbHZNU2Ewa0NSSXptL25tbHJSdExlajU3LzRsWWtoWVMzVC9oV1NI?=
 =?utf-8?B?VnJNUTZjbGZDS3c2YlU3d3NTQ1M0NzRIZ3NwTS9RQ1pkTHFFeGFuZlVUb0NO?=
 =?utf-8?B?UVFwUEsvdXM4SEhWWTBGTlIwTnEwM1JvU2JFenFieXBhbFY1T2hvWSsvMWVB?=
 =?utf-8?B?MjczcTVjdFNKdHZ5VnhSSHVYZmh4czRzU09rOGxDeE94MlQ0ci82b0Q1T2tZ?=
 =?utf-8?B?Ly9yTW0zVUU4dmRoaFM5eitSMUhPd1Nqc0V3Yy9CdU84MUNrZGJHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2E602109C96E842B68E491B84774717@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U9sjuoDn1zhMatTlUy0FDmfrQQ6iKj7g26LWn69mDUntiJ+ofKDFnnTyyO5ey/hrjKiMfhMEh5OD6jOBEo4Hp+Qq5r65jAZzRQpjACDyupcV3IOrIuWuUI4ZVYXEHi19EFJX0hxxzVZy6MiN1ouMu7H9AXDD2blBkYmQqd7uVU+dDdz6Fj7nnQVWJ1RZEzTWZOs1bS1Ve9eRMq06wtvOJ17OXDgKL/ItBNWGOWC7wg2+ZXLLeRAv+tM0b9e3GmsDs5noRpkWrgDf9Pd4+h3E6jTtHOD/lXtXcamjrYFMBlu0LcURwiizXvaYgh/u2duO4V92dOJ2yI4Blw1p+N2QUA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iTA1rCCVtLZ95G29uSoeycteKJ5uVaFjOtpfHyJl+KUcu2MOwz3PQav8X/1ulNaeaQPCYss0XanrgeSafIyW7rCdYSuwqOSv1/oL/PDTttWt5xbrgvz64+pn/C60jYntnEhGSzchgJ/Ybx9unxzXa1IH1m4EHbT2tLjVOE4hosaJxKU/UNI19RWIoMoxdpRB7AVvGopy7IrD2YUtmcYGgDDV1WeloaVP1LLs0NMcik3fzyBLI2HSL3pd+QoIQ5Rj85iykv8pGVzlj2FskOjlrpZk79B8J/VB1QpCpem1ap/irPRffUnuJPjZ7KmuX6VSIRukrTtUaVdh4Q0zXPSUafylutiTrJBc4jjCOWYAADwVqKCwJXgyM8eMf6efNGKS46sjKEyd/4UbqryLFU1jNidElPRr/HsjIX9tq9WFxMo1qaYDchNT/UTvOl2fgOFPXDY6VJpxoKhTDTstZDPk+wzntf+dQYKvaIqt3t9pqERdFUaXBPgHzcLFzkSRwzXEyrwu1eObZ3privkG85v7Yh9HnaEjr8+/BwoTgpmINq/hp6qDULiXYBzhQwD5fqzx8zVB73gOQkYmeILE6XN40m8ZRisxtQxUrTjUzdMLYOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c33fd8b-9a5e-4ad2-b9c8-08deb74701ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 14:41:13.5796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HebMkr1yIXyIb9Lam/De+fUx6fa8HseXVcj7AnPmG7dcThzrTqVtZAUMRKugthHze+6YASim30Uwe2tKoaOmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210146
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0f1991 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=20KFwNOVAAAA:8 a=c6-lWCYRRaKthrSp6tMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: gstwUgkLLpT4S1M7WU0PecitZPCJQOKe
X-Proofpoint-ORIG-GUID: gstwUgkLLpT4S1M7WU0PecitZPCJQOKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NyBTYWx0ZWRfXzzUVS/EgT/S/
 5rG3Ffgo49oYrUWX+qVoDARWaHJ3NA/mJRD8qMQSTEbJvJSoomdYokFO3eECJnoPOGxLFTchb75
 y2qjeZwkBNhnBvkyexFVigrC2rDe6DBUcsig1A4pe08oDynXBvjhXvcEGVah00KeImN2PHHUUAY
 84dGIbFFlIUHYvb4loflLi175EHRiy5qhWaClPfcjvIILLEm03hIJtDZEpSLBewaiALg38CeX1q
 IOa2EsHXKs5z7y4BThhqgon6vjY2coZtj+NemQtH7UBKgUXy6oshrtez7QA/9VXppfkahmovrMZ
 fXa/dQuzTHzRdy3e0Y4gFsz7QZ77s4i/Duq0bGQrb9oTu15N5IZDWdMyAvje8vbIZ7DOegdMrfX
 WOeGhJYDa7Y0S9mG/oiEA4LOBuBiNUltz0XgGUPbILAwGHoZvKI6MJpn5nI/NBiUjHyhESqLD5I
 gHBTx04KJ2OwfaSp90Q==
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gT24gTWF5IDIxLCAyMDI2LCBhdCA0OjI04oCvQU0sIEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+Pj4gSG93IGFib3V0IHRoZSBm
b2xsb3dpbmc6DQo+Pj4gDQo+Pj4gMSkgbWFyayB0aGUgd2hvbGUgc3Vic3lzdGVtIGFzIE9kZCBG
aXhlcw0KPj4+IA0KPj4+IDIpIG1hcmsgdGhlIGxlZ2FjeSBiYWNrZW5kIGFzIE9ic29sZXRlDQo+
Pj4gDQo+Pj4gMykgaWYgd2UgZG9uJ3Qgc2VlIGFueSBmdXJ0aGVyIHdvcmsgb24gY29udmVydGlu
ZyBtcHFlbXUgb3ZlciB0byB2ZmlvLXVzZXINCj4+PiBwcm9wZXJseSBvdmVyLCBzYXksIHRoZSBu
ZXh0IGNhbGVuZGFyIHllYXIsIHRoZW4gcmVtb3ZlIHRoZSB3aG9sZSBmZWF0dXJlLg0KPj4gVGhl
IGFib3ZlIHN0cmF0ZWd5IHNvdW5kcyBnb29kIHRvIG1lLg0KPj4gVGhhbmtzIQ0KPiBXZXJlIGNo
YW5nZXMgc2VudCBmb3Igc3RlcCAxLDIgPw0KDQpIaSBDZWRyaWMsDQoNClRoYW5rcyBmb3IgY2hl
Y2tpbmcuIEkgd2FzIGJhdGNoaW5nIHRoaXMgcGF0Y2ggd2l0aCBhbm90aGVyIHBlbmRpbmcgdGFz
aywgYnV0IEnigJl2ZSBqdXN0IHNlbnQgaXQgb3V0IGluIGNhc2UgeW914oCZcmUgdHJhY2tpbmcg
dGhpcyBzZXBhcmF0ZWx5Lg0KDQpKYWcNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoN
Cg==

