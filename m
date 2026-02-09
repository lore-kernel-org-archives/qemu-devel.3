Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A9EF06EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGlz-0001bG-Pw; Sun, 08 Feb 2026 21:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGlx-0001aR-D9; Sun, 08 Feb 2026 21:13:09 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGlv-0005jQ-Du; Sun, 08 Feb 2026 21:13:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLyLRwBQyTfjg4Jfix4VdpefOlBL7YdzpL//RmbaPXPAywSnXwCEhlLsgn9SJuSikb6sOly/YV77XWKxwinu70QLcq2RfIyAFGNrEnJBmoJpLZjLOvQhnGHZues12Gl6a/oMy0pDXKyKbSgeiU1zaCIoY6lukbLHZwSUkLDtpxKO2hxeknbKPdc/aojBHoQcco6AxplXAbd5FoCJIGpVTondCV5SY7tBDpefl8O+v6fO7m4mx3Imw2I+INv92a6tcRjv0yhoKLASYSB6k267w1QVBUf03qEUf8VcqeWVDrDGjao4r7IsD6iZRXS99qFE0ivl3RiOanikAS2a79dh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMw+Q4fzuG8n6inOQf9Dwhng62w4J+1ZL/b+jgYCkqU=;
 b=quiq/pDDaySFswniXftl5gXeTIB88+x+b7I1w48gZVT4YY8KH3IPI5gk0N5ODXRZs7t3pEFCbauRHBqzQv2Hv010efBkikGCjjMUl8iXo48PRxgXjpwcI7wmsZwKPW3DSF20jdYCAg7ZHoT4UvrSCrqEEsCelkbVGcGmnSaLCfegBvsmT+7HOnV92JYZhIgFUQPfVZE5krOYYgRWw4ELhejibCpFvC6ih8vxmHxccm9on+leb7ydHPuXWqQhHHir3pflGWJNwBP9wjwAr0cERXn80qRuuJVbL1pMqrRiFKm2IAR0PWhE8TwoXCMI84XUfUF5YkFH8Asy5mnFKn7i6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMw+Q4fzuG8n6inOQf9Dwhng62w4J+1ZL/b+jgYCkqU=;
 b=SnW5kTgzfl6Sc//s25to+3pdsMz+iImFinUCdL9JZImbNPKp3cUyzm1xU4vAJkaMAuh61DdljwXx9knDui+xJFAnnhDhCwbKnOkTfUN6UzATRW38RT6gWuLTv3dUXt2BRPCxo1ohIIXCWbFlmpGDnFgj7bWUHbXRCbRj6MtR13kjI5KMXZg4VuVyiytVF6hfW2AUaB5uQ5pdK4almoeksYmia0bVjN4lJkCDoVAWhib0kN5J+BZEkOmXWTgeOTCBqQFMLfcGm1i88NrocnHNTUD0Vlk/OTyhS0SBNT7Mcb78/7u4KVsgrCKeII1Fflsek8BYet0wqpZSX1QmJxiO9A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB6938.apcprd06.prod.outlook.com (2603:1096:990:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 02:12:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:12:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 05/10] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
Thread-Topic: [PATCH v1 05/10] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC
 support
Thread-Index: AQHclyorpy3YLROiqEGBwycpLgpmH7V1aikAgAQ58xA=
Date: Mon, 9 Feb 2026 02:12:58 +0000
Message-ID: <TYPPR06MB8206A0B61F27656F22E4C4B5FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-7-jamin_lin@aspeedtech.com>
 <aa7417b1-e058-4b17-87a4-6214b6f79e7d@kaod.org>
In-Reply-To: <aa7417b1-e058-4b17-87a4-6214b6f79e7d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB6938:EE_
x-ms-office365-filtering-correlation-id: 24327bed-fea2-4c08-8f27-08de6780beef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?SlRSc1pSUkY4MHpBalFNQlJ4aUpkT0FjcEcyTVo4N0VkdU40TzA0SEFnQlJs?=
 =?utf-8?B?c0lZLzFJd3BwU2NUamdkbEFHeFJoTVU4SnJaMEwvbktZVnBzeXpGb0YrYTl1?=
 =?utf-8?B?VU9QaEFrd3pKOEhNQy9uekNrU1RyUFp0VzlxSWZMOExrWThTZTNGWDg0ZlNJ?=
 =?utf-8?B?cWlXTnMzOXl4dkNYWGRKeVVHcWpZZEE4L3hPK283MFYrV0ZTVXRCbnFyWC9K?=
 =?utf-8?B?YVB3UXc1NWthdlRJZlRtTk1WYVVHdnZXU1BGdWVxQWlhL3A2RE5OWXBGMDE0?=
 =?utf-8?B?WmRvQUN4bkZORjl5SEE4NFQrSnplUWZlODlJSHFsU2V1V3lVYUpsa05rWENV?=
 =?utf-8?B?UWFSSHpCRlRwOVNac3M1RlgxWU96TTNWZGJobVJTd3kzNnVteVN2RXdCa3BE?=
 =?utf-8?B?TDZqTllXVU5Pc2F1QTFCVkRNWDFBdHpGUDMvbGlTaHE0WDFNU3NRSTd0cUtr?=
 =?utf-8?B?bWdWTTNtWXlVdmVPWjVQZVk2OGw5TVA2Ky9FUElITTBaaFFKSnFmNVdiVVNL?=
 =?utf-8?B?TXd2UXZSNldLaE13ZmZzTENtVExtZjZNZndwYmkxNFlZZGxYQVRCOHZKeEcx?=
 =?utf-8?B?SEJSUERWTGZKVEhVZnN5QkpLSUtCKzM4NjY5WEhVS2ZKRm54M1hBRWJ5SXB2?=
 =?utf-8?B?RkVxUE50WlBkV3BTVFlZZHJYTERJR3VRSDFMKzZNei9EMHJMeU81RDdVcFUy?=
 =?utf-8?B?d3NzREpERFdxOWRBM1VqZE5ZRUZLME9ta1U0TElJWFd0QmdhOEFnYmNOWVI4?=
 =?utf-8?B?UnVGVDJKL2krTWM3TEg0d0RQYjFjdGt6NEI4NWQxM0lQdjEwb2FRK3NsVVQ5?=
 =?utf-8?B?QXBXQ2NnTU1Ibno3UW1IM0NSNnIwOUdRY0dZcTAxTFRRUCtiTVgvU2lPVjNw?=
 =?utf-8?B?aDkyR2dqMVkwRjRrQUtubTRiZFltd1hoM1VTSkRUOWVSTVlma2hKVlhiSzA4?=
 =?utf-8?B?TGZDS3lma1FWL3ZOd0VqVHViVEE4cEVMOWpqUW5PcnVYVFNEN1NoVndLNDBw?=
 =?utf-8?B?bndMbFFEM0hKcjhPYXdsazBNd3JRWE1DNDJFd3lPY3RuNmlxck5OQXprNkFL?=
 =?utf-8?B?Rm1VbWpWOFNaUzVibEh4Y3ZXT09zSmQxMDNuZEU0a0ZKQmlIdEoySlJNNjVF?=
 =?utf-8?B?a1phcStodDdRYk1rRk5LMGpQU3F2UzRuZjBNblJMNFZnMzlPSVB1TFY4am8z?=
 =?utf-8?B?c1VkbGFoaHZ5WU42WVZvaCt0RzZSSGZIWjFOa3BFaWg3UXBwUWtpS3NtTWEr?=
 =?utf-8?B?NXZlVFZBWFB4TkVOdEd2cTJvZGRqYWwrdzVRdVp1YnovdXYwSm9QdTB0Rm5W?=
 =?utf-8?B?VTV2UFZEanVjaTdzTEpJUEI1VFRDaGtCR3doMlRtak4yMEs1NmVvSlFvMGxC?=
 =?utf-8?B?MWNycTZyRGdJZ3RUTUduTjZGeWRxQ25FSlgrTUN0eXp6YzFkMGlIbkkyMy81?=
 =?utf-8?B?ajFaMzdVeTd6eldVbDFVMSswbmtvVmQvNmNIREtGTTJKeml5Njg3NnluVWdE?=
 =?utf-8?B?T05hTFkzdXhCR0xDZzhTM3FFbWtWd0Jkenc1OXhTWkNxUHF0ZWdGM0R3b1lH?=
 =?utf-8?B?cGxKUnpWa2FrUnIrbWY0ckhhSTAzSzJ4amkwVzhWTTRyQ0tDemRqamRoTlpj?=
 =?utf-8?B?NFFYbUZNV3hxSlgxT1NwTUdNdnRObU1aRWZOUGJPZ283T1lORzV0b0JIUEtI?=
 =?utf-8?B?emlhSjk4cExkRVdxRnRhVE5pT3I3S29EY1Jva3VXM1dENzVOcmhCK3o0WWdp?=
 =?utf-8?B?SEI2czgwOVgvUUZOZm0xSjJhWHpUS3dGSzFPVnhCZHJRRzBrOXZWNmQrWWZP?=
 =?utf-8?B?dEl4MlRnZ0x2c24wN3lQZDdBQzVKSk1xbHVjSkdTQVRWdUxzaU5qT1NMWWtU?=
 =?utf-8?B?bFpsTkVsaWROajlRbDhxMENTMm1oT0xNeXJ2MU1VTkY0bExLT0lkbFM4SHpr?=
 =?utf-8?B?TFQwbHVGUzgvUFRzTG5WNTNkZ2ZIekhEMHpQWHJuVGhQUWMzcms0TnBBazFj?=
 =?utf-8?B?OXNwL3JxeVRONHBnVGNwSXRtQmRGSHJEeFRSZjVzZDJDeFdQOHpIVk1lUEQy?=
 =?utf-8?B?RmV6ZTJ2NERxblpjdFNBUDRIZHNmeHdBREwrY214WVVDNlZpbGV6RmROblkr?=
 =?utf-8?B?RFU2TC85ZWdjQ2FIRmtGR29ZRXJiVkp4dUNzTlUzZnoxWTJRTDdwVnI0L29M?=
 =?utf-8?Q?+7uMqjTPqFaDzWJT3QgZO4wLUVmdjT2AcBuQHLPdcv7E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVN1KzZsQTFycjFMQWVHRXVZRUZRUEFXdjNWeWlKcHhvbnQrMWlMUkU5WmV2?=
 =?utf-8?B?VFdneGtxb1NzdFZPMUptdU1VWUdHWGlNMFFtaVBzUVpOYmVMR0REZkhFdjVr?=
 =?utf-8?B?dWF4ejdDbmxBOHlXcUNDbHRRbloweEg5YnE0bVFqdFVQVHIwd25peGxZMWE3?=
 =?utf-8?B?YUZjNmJHK2c3aUxkMXVGcVYxSy9lUmh3SnA3RnNXZjhHY04rS2RSamsvUGpP?=
 =?utf-8?B?em1WL1hZdUpWSVgzaGdzbHljVE5VLzByUkRHMW9vcmVvRjRGSE5yV3pUd1Iw?=
 =?utf-8?B?WldBT2FGYXJXVWtncmxpRDhOVXBFcEtjMEVxL0dvV21jdFBwMEhCbTA5U01u?=
 =?utf-8?B?TW92SWNMN3g0K0ZYTkt5TEdxNERkV2hVQkQ0c2RmZUdFclFoSUtEUXhoSkxT?=
 =?utf-8?B?MmlvWE9wanl1QThCZWRIQXFrdjVUQmdibjVIVDFxVEZOcVFtTkt1M01xQW5z?=
 =?utf-8?B?azM1ajgwUUpPUXpycElZb09OZTJ2ZFNRZ1FrK0J5QmRGS3BkTG1HdXF4aTcv?=
 =?utf-8?B?dVdOZkNkU1JBREo3cWRXZmViRkNpSUNJTlZOMWpzRCthUXRGK1FtT3hub2Np?=
 =?utf-8?B?VDV6bnFCRG9WeC90T2J4bGJZc0ZhVndKY2szYitNaTAzendSeXJrZWZuY2Yy?=
 =?utf-8?B?M0tKS2dVeFk0U2tsRmF5RjA2NzR2UExVSWlTTzlTRkg2ZEpxTW41Q1VHMUxr?=
 =?utf-8?B?K2kxa1UvSUNHeXJsVHMvUWVOeG4yWmVqbjlSTDhYZDZURGQ5QzgvbmF1WWxn?=
 =?utf-8?B?bW5PL2JseE5iYUZWUVB3emlGMHhadjhKNE93Mnp0QXpzTm5XTXRiN1NWcXNs?=
 =?utf-8?B?OU9sQXlJQm0rNmN2NzRhY2w1YTh2OHIvdm9qbFBrb1Uyc0FvZEdzYVkzaTE5?=
 =?utf-8?B?OUgzM1lsV3E2TWtLOS94Z1JiQ2g0aHR2OFcxRG5nZTRMODVtQ0liRlZxcGJS?=
 =?utf-8?B?T2pmN1V6OGMvR0pKRm1BRHNxZ2VvdWJVaVB0b1VPZEYvYUJyeitUODRmRDdQ?=
 =?utf-8?B?RE1TSi9XRjZVUHg2eTJsbGc2OC9YN3E0dGgrVm10d3hDdEVsZEl1YWJmZk82?=
 =?utf-8?B?dmlWaUhyQkdKd25kZ3dCODJJN2pmZ3JJSkNBSjJiWHU2U3RGbmRxcm85VVQx?=
 =?utf-8?B?Vm5FMG13LzNhMDJRYnRvZlVWck1lYlRkdjRGR0VJRVVqaVE5VmdxcXBuMXlk?=
 =?utf-8?B?bUU1YkJpTXJTY2ZER0ZBYnhKcDFrWHRReGtQbTdBS0pvNXIzdldIRjQ5ZnJI?=
 =?utf-8?B?V1FtQmgyZEV0MU80WnZpY0FJT09YbVJ5dkFKb0Y0c1Uwdk1TbjlWdDRqVUJ5?=
 =?utf-8?B?ZEhTenU1M2lQbmJNWTBjc0lmaHJrdm9Yd1ZDYVhGeHMyTTFreHMwOGp6TG12?=
 =?utf-8?B?QkRWbmJhYm53SExuL1FwUmphMFdtdTVmRDYxdU40ZndaYkM1aHd1R0hHaDZM?=
 =?utf-8?B?WUNUSWdULzIxQ3lBeitVbjNiMWZJS0JjWFM3N2lSQzY5RkJrbEJ5OXFPK05L?=
 =?utf-8?B?a3dCellBOFRvM1dwbTh6MlZKbEkwdkdzMkF2c1VrRVMwUHR1d0toV1lvVlZD?=
 =?utf-8?B?UjZiVHhBUnNLNHY1MlVNd2tYZGNOZS9RZjVhZjFqWW1zZEN2S3YyOTVqdmxn?=
 =?utf-8?B?d0lXOW1IU3RGQys1Q0RNNitiT0UyNjVSM0FjZmxRWVFCNVRpcXVDa09VMWlU?=
 =?utf-8?B?SG5sMkFRQmllQU9ORmhCNHFReEdVRCtKMlE4UExjOWtBYi82cS9meXd4VFFG?=
 =?utf-8?B?ZzdZWXVzUmh4RTVxcnZnYmx2Y2NTUnlnK1IxN3NGRUFjbDdiS1M4akNQS2Z2?=
 =?utf-8?B?bXZLKzFrdmJUNjdzVHBCTmw0VndmRWFPNFh3cE1xamdkTktHV1NEVWwrNXJU?=
 =?utf-8?B?Z1JGTTNUZ3RmVDErdXZUY21jaTlxUi9YR1NzL3YvNnZqdXl5SlljZ29uYjBQ?=
 =?utf-8?B?QzdsMXp6ZlZSTGJrcklNQ2cwNzJqSU5rOUFlSysxZGQxc0ZGSDFTeGpHZDhT?=
 =?utf-8?B?akl3OU5nd08ySnZsZDdRaEtMMkJ0VkRuNmc1aUp6MjBGRm9xWXptYXdFYXB4?=
 =?utf-8?B?eHBMRDRpZHVmaWNGcXR4L3dZY0JNMnp3b1NOWFIyNVphOVcvODRBa0lTbzZY?=
 =?utf-8?B?ZFhkNGhLSGdySlpTV2Z2S05EeS9kMjY0eFl1WFBRUGtYODVTQ2lxVTlUTVB4?=
 =?utf-8?B?YWtwc3J6cGNhY0RBSUdaRUl6SVdjZ21ORjVkMkQrTlZMRFo4djBsaStiWUNu?=
 =?utf-8?B?Wk9XdmFzU25Gdjg1NGIvaFA3WUNkcFdLSjg5R1VWcTFiaFVrSy95Q2c3RWZJ?=
 =?utf-8?B?M2wzb1VNS2FMb2tNREloZk83M25RR2h6Ni9zSGJTSzNZaVpWMG4wQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24327bed-fea2-4c08-8f27-08de6780beef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 02:12:58.9938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WEYAq4+js2IzQvZnvjVmmajWNHwZV65nrEp+0UtgufLwZESVeOyS56YZvkAW8w2RbKXQ12RAgMzusHf2mcq3AjgREiWSSwrKLNOLaD3CCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6938
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA1LzEwXSBody9hcm0vYXNw
ZWVkX2FzdDI3eDA6IEFkZCBBU1QyNzAwIEEyIFNvQw0KPiBzdXBwb3J0DQo+IA0KPiBPbiAyLzYv
MjYgMDY6MzMsIEphbWluIExpbiB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYSBuZXcgQVNUMjcwMCBB
MiBTb0MgdmFyaWFudCBieSBhZGRpbmcgYSBkZWRpY2F0ZWQgY2xhc3MNCj4gPiBpbml0aWFsaXph
dGlvbiBmdW5jdGlvbi4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IHNldHMgdGhlIEEyIHNpbGljb24g
cmV2aXNpb24gYW5kIGRlZmluZXMgaXRzIFNvQw0KPiA+IGNhcGFiaWxpdGllcywgaW5jbHVkaW5n
IENQVSB0eXBlLCBTUkFNIHNpemUsIHBlcmlwaGVyYWwgY291bnRzLCBhbmQNCj4gPiBDUFUgdG9w
b2xvZ3ksIHdoaWxlIHJldXNpbmcgdGhlIGV4aXN0aW5nIElSUSBhbmQgbWVtb3J5IG1hcHMuDQo+
IA0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBicmllZmx5IGRvY3VtZW50IHRoZSBkaWZmZXJlbmNl
cyB3aXRoIHRoZSBBMSA/DQo+IA0KPiBUaGFua3MsDQoNCkkgaGF2ZSB1cGRhdGVkIHRoZSBjb21t
aXQgbG9nIGFzIGZvbGxvd3M6DQoNCkFTVDI3MDAgQTIgaXMgZnVuY3Rpb25hbGx5IGlkZW50aWNh
bCB0byBBU1QyNzAwIEExLg0KVGhlcmUgYXJlIG5vIGNoYW5nZXMgdG8gdGhlIElSUSBsYXlvdXQs
IG1lbW9yeSBtYXAsIG9yIHBlcmlwaGVyYWwNCmNvbmZpZ3VyYXRpb24uIFRoZSBvbmx5IGRpZmZl
cmVuY2UgaXMgdGhlIHNpbGljb24gcmV2aXNpb24uDQoNClRoaXMgY29tbWl0IGludHJvZHVjZXMg
YSBkZWRpY2F0ZWQgQVNUMjcwMCBBMiBTb0MgdHlwZSBieSByZXVzaW5nDQp0aGUgZXhpc3Rpbmcg
QVNUMjcwMCBBMSBpbXBsZW1lbnRhdGlvbiBhbmQgc2V0dGluZyB0aGUgQTIgc2lsaWNvbg0KcmV2
aXNpb24gYWNjb3JkaW5nbHkuDQoNClRoYW5rcywNCkphbWluDQo+IA0KPiBDLg0KPiANCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgfCAzNg0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMg
Yi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IDYxNzkwZWExY2MuLjg3ZGNiODJl
MWIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC0xMTY2LDYgKzExNjYsMzYgQEAgc3RhdGlj
IHZvaWQNCj4gYXNwZWVkX3NvY19hc3QyNzAwYTFfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2Ms
IGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICAgICAgc2MtPm1lbW1hcCAgICAgICA9IGFzcGVlZF9z
b2NfYXN0MjcwMF9tZW1tYXA7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYXNwZWVk
X3NvY19hc3QyNzAwYTJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0DQo+ID4gK3Zv
aWQgKmRhdGEpIHsNCj4gPiArICAgIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdmFsaWRfY3B1
X3R5cGVzW10gPSB7DQo+ID4gKyAgICAgICAgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hMzUi
KSwNCj4gPiArICAgICAgICBOVUxMDQo+ID4gKyAgICB9Ow0KPiA+ICsgICAgRGV2aWNlQ2xhc3Mg
KmRjID0gREVWSUNFX0NMQVNTKG9jKTsNCj4gPiArICAgIEFzcGVlZFNvQ0NsYXNzICpzYyA9IEFT
UEVFRF9TT0NfQ0xBU1Mob2MpOw0KPiA+ICsNCj4gPiArICAgIC8qIFJlYXNvbjogVGhlIEFzcGVl
ZCBTb0MgY2FuIG9ubHkgYmUgaW5zdGFudGlhdGVkIGZyb20gYSBib2FyZCAqLw0KPiA+ICsgICAg
ZGMtPnVzZXJfY3JlYXRhYmxlID0gZmFsc2U7DQo+ID4gKyAgICBkYy0+cmVhbGl6ZSAgICAgID0g
YXNwZWVkX3NvY19hc3QyNzAwX3JlYWxpemU7DQo+ID4gKw0KPiA+ICsgICAgc2MtPnZhbGlkX2Nw
dV90eXBlcyA9IHZhbGlkX2NwdV90eXBlczsNCj4gPiArICAgIHNjLT5zaWxpY29uX3JldiAgPSBB
U1QyNzAwX0EyX1NJTElDT05fUkVWOw0KPiA+ICsgICAgc2MtPnNyYW1fc2l6ZSAgICA9IDB4MjAw
MDA7DQo+ID4gKyAgICBzYy0+cGNpZV9udW0gICAgID0gMzsNCj4gPiArICAgIHNjLT5zcGlzX251
bSAgICAgPSAzOw0KPiA+ICsgICAgc2MtPnNncGlvX251bSAgICA9IDI7DQo+ID4gKyAgICBzYy0+
ZWhjaXNfbnVtICAgID0gNDsNCj4gPiArICAgIHNjLT53ZHRzX251bSAgICAgPSA4Ow0KPiA+ICsg
ICAgc2MtPm1hY3NfbnVtICAgICA9IDM7DQo+ID4gKyAgICBzYy0+dWFydHNfbnVtICAgID0gMTM7
DQo+ID4gKyAgICBzYy0+bnVtX2NwdXMgICAgID0gNDsNCj4gPiArICAgIHNjLT5pb2V4cF9udW0g
ICAgPSAyOw0KPiA+ICsgICAgc2MtPnVhcnRzX2Jhc2UgICA9IEFTUEVFRF9ERVZfVUFSVDA7DQo+
ID4gKyAgICBzYy0+aXJxbWFwICAgICAgID0gYXNwZWVkX3NvY19hc3QyNzAwYTFfaXJxbWFwOw0K
PiA+ICsgICAgc2MtPm1lbW1hcCAgICAgICA9IGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXA7DQo+
ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX3NvY19hc3Qy
N3gwX3R5cGVzW10gPSB7DQo+ID4gICAgICAgew0KPiA+ICAgICAgICAgICAubmFtZSAgICAgICAg
ICAgPSBUWVBFX0FTUEVFRDI3WDBfU09DLA0KPiA+IEBAIC0xMTc5LDYgKzEyMDksMTIgQEAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9zb2NfYXN0Mjd4MF90eXBlc1tdDQo+ID0gew0KPiA+
ICAgICAgICAgICAuaW5zdGFuY2VfaW5pdCAgPSBhc3BlZWRfc29jX2FzdDI3MDBfaW5pdCwNCj4g
PiAgICAgICAgICAgLmNsYXNzX2luaXQgICAgID0gYXNwZWVkX3NvY19hc3QyNzAwYTFfY2xhc3Nf
aW5pdCwNCj4gPiAgICAgICB9LA0KPiA+ICsgICAgew0KPiA+ICsgICAgICAgIC5uYW1lICAgICAg
ICAgICA9ICJhc3QyNzAwLWEyIiwNCj4gPiArICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBF
X0FTUEVFRDI3WDBfU09DLA0KPiA+ICsgICAgICAgIC5pbnN0YW5jZV9pbml0ICA9IGFzcGVlZF9z
b2NfYXN0MjcwMF9pbml0LA0KPiA+ICsgICAgICAgIC5jbGFzc19pbml0ICAgICA9IGFzcGVlZF9z
b2NfYXN0MjcwMGEyX2NsYXNzX2luaXQsDQo+ID4gKyAgICB9LA0KPiA+ICAgfTsNCj4gPg0KPiA+
ICAgREVGSU5FX1RZUEVTKGFzcGVlZF9zb2NfYXN0Mjd4MF90eXBlcykNCg0K

