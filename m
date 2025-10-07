Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B17CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 19:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6D0L-0005Tk-EF; Tue, 07 Oct 2025 15:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v6D0D-0005TV-4g
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:05:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v6D09-0006QK-4T
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:05:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597Is46w029710;
 Tue, 7 Oct 2025 19:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fryeTJaQETtn658bsCIt1A0gHVgqB+My6dhI0OTtDYY=; b=
 F/eNEqxWNhg6PJTftZi5vUw1gXvUps6UQIWBllRLWYF/UqESil9udG7SbtkF4WGw
 CcuQgGYsIXHSaIos/tUmgMtRc8KFbWk9GJHnhlDs45d1+P8jDJ3ILpRaFoshY3U0
 VHz5wXYEuVQryp4cb17GxUOyCmGI7s51PuZjFUgdHWGA4HKGMRU9BZ/pyekUyFMm
 FiZHRK+ocLT/nPejEO+KRhdzPAHAFeKEYOkuMi+9Z1+Pf2IjykUAH/ZqlZPS18UA
 QJn7eEWIlyTVIPKN7O471vGQozzS4JcFMZ5qQg0qmaEYQaNqQp9TB652gXGLyoca
 Y/Nd3ngfuSp7dwqzNmNExw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n7tpr44h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Oct 2025 19:05:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 597I2EsV036138; Tue, 7 Oct 2025 19:05:11 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49jt18mxpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Oct 2025 19:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeS3r/2Porf68hmi3EM1F7Cd6CIkdWDm8lfxfxoFCzhaWxQqDOSRo4ZBVE0Lw6FULmnpLqsZuR8RcbRgsyMFLOT2YzeLMl0DQD7eBenSRWgKzT06Jso69Ip5dxNthp2UtgL+naSD4Rjm0yRW6umlrsDVCcI6HZmKx+A9bs4pasQTCxtjRqp1370/PZnbE1H73M6iP7y3W3/ndmuQQu5lCc2OKMS/2SLazzZnBKel1sJ4/8qFEWRD11ZiFPeVwUABpXeuPOVbqmM8gKwubscsv5RyfVw4qPAxnHb5RR0JxhflHUnIwi3q/IxdO0pwlNYJ4+8WebPMOb8+4L+ytin9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fryeTJaQETtn658bsCIt1A0gHVgqB+My6dhI0OTtDYY=;
 b=qHayGzjTiNoxdigCbocRCiaZ4k8Ru4yeW6yO2PPxMhj2XERNWdv41gYEqBNIpsNmMkGBBStW+VEpTZntapLWDzZEvbMK9M4bmmkay1x3YWQ7+TMvC9TXfvg+D0Ljojl6BRDSRW+i4mn4cCXR6ktZFDTJThisqriS0gihXXNqQ7yoaPxkYwrW+HFMxY8XSLzAU1eKccazgfpxdGcHw0UTFR1AlXHdZMJNzPex3gC0/JbGI046nAd/hAurNgTyIQnVndnghrSjoWM5j9fhZ5YynzqS4EZlrwcgeyjUViKde9Rqa58d6yetQtfi9uBpDrLIlJTwir0BQt2YE2Ph5nt9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fryeTJaQETtn658bsCIt1A0gHVgqB+My6dhI0OTtDYY=;
 b=jDBqrzU+BiKXSNMqvNfRwpqEj9cCDMecdjMB6YcLxVDVraVJ2Bj8/5P3DR/Ba2lWq5NgqzVhBxvTUv4EeA822joNhM5SiHc4sgGRCFM3sMr7+Y3N/zExTSIdm75hyzqD0ysS140W+BGiJDiNhZxdEaEeNCOWVXNahjWsdn6uyeo=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by PH0PR10MB7063.namprd10.prod.outlook.com
 (2603:10b6:510:289::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 19:05:04 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 19:05:04 +0000
Message-ID: <08ce5d66-a644-44bc-9165-b46ac618545b@oracle.com>
Date: Tue, 7 Oct 2025 20:04:56 +0100
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, boris.ostrovsky@oracle.com,
 qemu-devel@nongnu.org
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
 <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
 <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca6374b-48b0-4187-931c-08de05d46c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZIWmlMTTVqNXJrN3h2OHFSRVN1Z2ZrWTRPbzVqc1lWUHU0dVBlNnRzbFI4?=
 =?utf-8?B?ZmttR1pQT1l1YlFzMU5IZW9tNFY5Nk91bnJFbmQ0RmFVYzhVVU9hc3NQMTFy?=
 =?utf-8?B?MzNwR1RrUWlEakhSRzlGNi9CMnoxQ1Brc2xpK3dva2loR01YYXYyQkFPMTJQ?=
 =?utf-8?B?dXcxNkFPbWRXMWQxbDRjZVVsTjBOTlpYVHJJQjRoc2FYRFd2ZlZ4WmxwdVV1?=
 =?utf-8?B?RVU3QWNrWEF5U21XVXdjMTV3Zlp1aEUvZUF2TjhJaWwwRFBxT1lGK3Rjckww?=
 =?utf-8?B?NUZSMkNUeGdTazlvTENyb05kT095YUQxK1ZKR01lM3lQTEpEdWE3V21ldVNG?=
 =?utf-8?B?cDlLZkxXWVdUMGxwdldWSlRxamRvNkJsUEl4eUZHNWZ4emNHclRvZEhzSy92?=
 =?utf-8?B?dkJaUVVOckMyTWdNS1ltUEE2L21CNWVsTWdoYVorYWVSdjZuUVRXTloxb3dw?=
 =?utf-8?B?Z20wVm9uWDcvelduY1daWmJzdlBPN0ZTaXhQRllrTnptYXc0YUFDTzIveitG?=
 =?utf-8?B?MnNCMHVLY01DSUdDWjIwUTBaZEdpeEMzR0JnSlEzSVBCakZ5UTlFd3lxZUcx?=
 =?utf-8?B?T1d3bW9iSWtGWWJGdGxLNlFFU1pqMlRsazFSaDRxaElFeEo3bEJtaFk1Qkxz?=
 =?utf-8?B?amxqNVBSV2RvU1AzU2E5U0tWT1ZidVp5SlJjZUw4Y3NjRG0zNm8yVVZ5ZGhN?=
 =?utf-8?B?ZU5VT20wK2lzalBmT1E3U1lFNnk0Q3k2anFXYUgwcUdZVTlEV0o5WHVrK1Mw?=
 =?utf-8?B?SWZXMDNwQ3R2YWJKWE0yZUtBNXNIUHN6bytBVFJRekdxcUh4am9LOERWdDln?=
 =?utf-8?B?eHVhLytCS254MkR6aVhvdXRGaGRFNThrL093TFo0S3A0Q2FLY01RRUYrOHFs?=
 =?utf-8?B?cDJaMEdhTVBJazFIUDdJdko4N0k4N1R5c2tsaUJMQ016TmdaTkQ5VWpobUNO?=
 =?utf-8?B?dDl4ODhqVlcrRXY0NmN6RGJJakoyenNUdzlQKzllUXNuUDhGekwvdnZpanlD?=
 =?utf-8?B?MHdOTzhycVVuZkNlSk5uZmF5TWl4bHpUYkxrSGdqYXNreWdKRlJRZ21UVm0w?=
 =?utf-8?B?ZzBXS0lqUXpkYWlZVnRwK2d3eEYrRE40Sjl3MGE5RUoxTzJGQ0RMRlFneHpa?=
 =?utf-8?B?czFOVWF1THBSMklEUTlzL2QxZm5reVE2eVQwd1dyNGhPZGNqR1lYdzhRdkU1?=
 =?utf-8?B?bGdPMlpoK1kzZTh0dmU0bUZMZXBGQzVjRnBnOTVvUGdhb0U3QW9oRS9lSXRW?=
 =?utf-8?B?SUgyMEszS2pyZ0djZEpaaGJXc2IrTU0yWTArN1h0c0lKVGE2NXk1eE5UZ0s2?=
 =?utf-8?B?d0RTVVA4RnhIQ0ppYjFQUUE4TGlKNWFOUit2dEpodVZoUXRrRFRQMGJuNkt0?=
 =?utf-8?B?dnkxSUVNWUdialM2NGdOTFFLWjdYa05HdHJYMmtmSUdpUGdvemo4ci83aVR5?=
 =?utf-8?B?QzBva0c0bHR1YVFlZ1VST3FlUUxpUzRyek5JYko3c3h3eDMyT0pKQWpzc1Yv?=
 =?utf-8?B?dmpWRGZ4NFRyQkpBcGNneUdaRGUvb25PVFFUejUxS3JUNnlvcXpZdVZCcFF4?=
 =?utf-8?B?NE9wWTh6RUhIOUhWbmxNY3c4aDY3djg3dW1IdEJyUUJnWjUzTGpSWVVwaDRx?=
 =?utf-8?B?b2FDNW00UTBseUZtMUpiczNpdEUvR3ZVdjUvTFRKYkdDK2V4ZXN5QnFnQUov?=
 =?utf-8?B?M04xOHRJMSt2MFhCaldHRW9UV2dLT1c0Zjh1WnFTTmxYVituREVEODJYbktk?=
 =?utf-8?B?OTU2RnlTejMwSW9pM0xwdFFaeExRU2Mxc0RPL29JVEFZdzlPNk5IZUxQR3V3?=
 =?utf-8?B?ZW1zMis4VTNYeWx2bHZrTVpVSGZobEVRZG5JTGlGWVljNmVGOWdycTA2M1RD?=
 =?utf-8?B?NFYvNk1zTk83aUZXb1lZWDFyYkF0VnZvNmpFekRQcks4VVNQbU0zd2loUlQx?=
 =?utf-8?Q?ca9skbUFfqEJJ4QvjCIJ2+AvNTTshdlH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmwvWjJSaHp1M0FkTVNJRmNwQTlNMnEzS3NSbWZsNE5ybzB4Tk8yTGN6VDRR?=
 =?utf-8?B?ZFhWbmVYL1Z1L3E5bk1MRXArcDI5UU1BaVFKelBFNUxCSkVhZERyZ0l4aXI2?=
 =?utf-8?B?cHJxTTF6ckhTTmsrUFN5cXFiVUV2ZmpTb1loQjZKWUxRZE9aTjAvYU1Td0Nl?=
 =?utf-8?B?NkcwV1VxdDdMd2JuOTVhTTZNSktra2FhYnpCdkFkRkUwMEYxWFY2OGdYODZX?=
 =?utf-8?B?bE1LZnAxWSszbXpXSkRxa0tRalp6d0wrZEozOS9kQXhRaDREeDhOT29PaElM?=
 =?utf-8?B?cHNwd01EbkxMN3VwZ0NXeWFHcnZzM0RZTzhkdGNaRDR4cUE0NmRZRnpIWi9n?=
 =?utf-8?B?cEJVY0tTK3FRZFNpaXZJNGlmeWcwdmNQS0sxRFNKRklLU09DbmVlSnYwTEhv?=
 =?utf-8?B?NVo0NjVtVy9YUXNsVFRVY1EzWlZlMjIzc1M3elpSMHVueFZOclpTa2xTK212?=
 =?utf-8?B?Z3NjUS9WUXNHRDNHeFhIaEFHeTkwTkJwY3ErY1JnU2hqbUhkYkptOEVkNE5l?=
 =?utf-8?B?dkdoaHN5d2V4RFpybzZKOUhDSk90c3lvaTJYVUxaUmdpdWRwQld4UzVmZzZE?=
 =?utf-8?B?cWs4QW5iYTVqU2diRGJ4eW5yYXlDbVlQSGZZb3dzY3BCalFBOTF3SG5EeGlZ?=
 =?utf-8?B?Tm0yV2NjUUN2MTJEcWJkZkl1amJvOG5wTFVnRzRZc1ljZHU0SmEzYkxnWlFm?=
 =?utf-8?B?SzU4NEp4cStxdkM1dnFIOWJuNG5FSGQ3TDRKYW9CUnVjRDAzazdyclVWbk9O?=
 =?utf-8?B?Y0l3Q3Z1K1Rwc1lvcldOMnpSaldTUlJwT1BWckpsejFBUHJXVVZQZ3o4RTRZ?=
 =?utf-8?B?Z01ySWVTMGY1ZVgxSzVtQnJib0FTWXpFT0pXaTdXd1FiWFpOUTVSQ2NBUGxE?=
 =?utf-8?B?Q3VIY01tWG9hY0F2VkQ5SWRSaFNGaWl5dXpnSEhjcTcyRWkwZDFaQzBua3BG?=
 =?utf-8?B?ZGQrWW93UEZ2Njk3bUZwQ0xuVXVTWW04ZFAvV2JSUFdkWldsd1NYdUZOWlY3?=
 =?utf-8?B?a2dmcklwYWY0NjIyaTVHK0hMUnp5WHR5WTZZOURmeVRTRmxHOGNxUUNuSzNZ?=
 =?utf-8?B?S3UzM08zOEsrV0Q4bDlMbHRlc1hTKzhaM3RrR09mbnc1VHlmOVdQbmkwa05F?=
 =?utf-8?B?VWtOSUd6ZUUzbCtsYkhhcml1bHRJVTJ5Unp0OE15aHZHYXFKNGIvL0tzaGs2?=
 =?utf-8?B?ODJOTm9IQ0p1TGRGbG1VNXdSREJUUWRXQWhsZkFRY2VJMHlqZkZpZHF3a1Ez?=
 =?utf-8?B?T2cwVHV5R3FmQlpXTUdaNGdUUUFPeGFuc0NoS09jNlUvUjR0cmZDN0ZML2NF?=
 =?utf-8?B?c3N5T2dVRW1HWkFIRTl0OE0vQnNLNjVLdjZTNkRxQ0Q1NHEvWXQ5bUZzRWVu?=
 =?utf-8?B?VzU4K1EzN2Q2RDlKUm5VREtLRnUwcTE0UmRoY1lGUVo5aXhuNGtjSzBlbFNV?=
 =?utf-8?B?Nk96TE1mWGFQNnpxaWRMWkJNSWNRNHVPcWo3YUpUZkZXNUZ5dTk4eXFWSUJ1?=
 =?utf-8?B?R0doSis5elJlbzk1a1oyd1M2Z0dkUlNaVUhhUzdXQmlPaDVmSzhNM2RlS21B?=
 =?utf-8?B?N1d4TXYzTkFoMk40K3NWbzdib0toa3NvQUF5RVIrOHVacXorN09ZUTRjcThl?=
 =?utf-8?B?QmRFQzc0UDBOOHJrNzdGY3dxNER1OXdOSVJhTStvcUgrMzJncXpaVzZ0eHFj?=
 =?utf-8?B?MGtxbEtlS1ZvMXpKdHY1aDhwSVZQeXRCQS9ObEZMNnFZK2RvNXhnRmdQT2Zk?=
 =?utf-8?B?bldIWDVnZHpuSExFWFFJSktYYmk0TTZ5SEJFUGwrVUJWdDVsc3BhVTJoWUlh?=
 =?utf-8?B?VTJhK2ErZUJZdFNLTDBGTzkzWmViaktvZzNna2p4eUhGK205bDVkcmZoRE5T?=
 =?utf-8?B?Qjd0dFlpK1ZqZGNpUjQ5bGcybFR0MXJhOVpwdzBnd3ZIVXZJMHFEblBXaml4?=
 =?utf-8?B?YytKWGtPK0hQaHlqZjlGMEVWMFQ0a2hoSjFaU2oycGRlQ2owSUhJVitFSC9H?=
 =?utf-8?B?NUJaekQyWmZLdE1KY0ZxbUgzeHkvaCtHNnoySG5CWDJlUExPcTR3V0pLRXcr?=
 =?utf-8?B?YVFYNW1wYzZjSmVNM21TdGpjMlZKNGxYRk5GUU5NUlI2T0ZvbEl0aXdSdkdO?=
 =?utf-8?B?UmRXTVNFSWU1Zkpqa0JQVWNFZnI1YVpmRkJCR2VyS2dESGtoWUV1QlYrRkpm?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qaCcHynX+x/PfOo8Fo4FkcBOkSPqgiLfrnUsELFXJSel1aJOAYGcIyw5MDGLHxVluNHvjyDsHDi6hCTykOEesxMjsl02X7CO0u1kdh23Neh3WNNxyODNIRK3Il+h/X6urMHdQw9pgeBwFesqtWz0G3eDLORwbLfI6ibOtMahwlN0zo6oj19FlFi3QH5k89CqW0lFFlaIaim0wNkyx2C4MUMhkx+bLVntUsgbahF2d0QXmqaxw725qYgZILzOV0sTQZyoHW0MlARQsKxHhj89bgO77QiaCNsxo2wqRbA08HAah7THsQUIcPcSUci/ok6KfWKIHjzLhLYE52OMbdrSMMoFYG01QyASGHfPDkwpaiwvpQW85+vgPpNpQL/GhvKpxok1h3LsrBPSAfsp0H1iwMG5eUOiukc08BlnUTabB+sdRofzN7988Vn5iaUvm+tkttoPoVkWeqYjmzhxjuZ+1wqQoeeDy4lxavHsJaw9kscjjQZpF0w/Wom0W3zjXhSQDZ7q0nZfY7cN82Jh6FAoU6Jf9rC34nFS4g+UNp7U1EeQBaNk99g57QG7crCtzy3K/JjzGHPC+wf/uiY9i2J0r8Ws4rsKdY7sKLi/M1eMiaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6374b-48b0-4187-931c-08de05d46c65
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:05:04.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al5sYcsCJ48ZEt3YHo4lRDIMR0nTB0N9DbZsPlPxVfKK1c3cGEV6RQa4ko+F30QQfHpQGThvVnrg/C1LdzDkViZW4pt50Ib9XLIOAiih9+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0MiBTYWx0ZWRfX7nDuQFNmz+5F
 QEhLkWhj6F1E8a12mxh9Xf39MdrXVYTAvDXhL8MrD64Yp582chJ5Bt7j5okbG6T6xmVU92y/J0b
 dQW7mFVKNN0uUoINUKJBHGOyGtvRpOPrq5wL31L1vj132FhAL/Plv2e0uGhmZheXSMBoFBIyaAH
 PfCz19E1MTl1bS/Mx4voilYMRBYAxVlX5xFO8iq+3DKHsSl8pQ2i4HFdUQVBh0Gj+o27qVgxdLM
 74YoEfbNbhjTJLONbmyS/N7qSQsdoBRRjz1fyRxDNL0bC3sOyAfMK4Vc5Z4xUwB/1mwSe2hHamC
 gCs/rKVY+tShSz5dLx2nOMoK8YJHLsZCtAxneo43/R+6/nEdoSPf+zVJwJkcEOjRQfIr8b71yqJ
 aJRIf7hHxbs4HxYVaxjEgHOPsFbQE/q6teqbjeiyPNSuSbpYsFo=
X-Proofpoint-GUID: AWW73US1sqhREDW9asNsJ9RDyBbB-SPx
X-Proofpoint-ORIG-GUID: AWW73US1sqhREDW9asNsJ9RDyBbB-SPx
X-Authority-Analysis: v=2.4 cv=W581lBWk c=1 sm=1 tr=0 ts=68e56468 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=b7sfcy8aNl4nq7isG3MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/10/2025 06:45, Cédric Le Goater wrote:
> Hello,
> 
> On 10/6/25 20:44, Alejandro Jimenez wrote:
>> Hi Cédric,
>>
>> On 10/6/25 12:07 PM, Cédric Le Goater wrote:
>>> Hello Alejandro,
>>>
>>> On 9/19/25 23:34, Alejandro Jimenez wrote:
>>
>> [...]
>>
>>>
>>>
>>> The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
>>> Since this series is about to be merged, should AMD-Vi be considered
>>> maintained now ?
>>
>> It should be considered maintained.
> 
> Great :)
>>> and if so by whom ?
>>>
>>
>> I volunteer as maintainer. Assuming no objections from the community, I will
>> send a follow up patch updating MAINTAINERS.
> 
> Thanks.
>> If there are additional suggestions/volunteers for co-maintainers, please
>> reply to this thread and I'll include them on the patch.
> This series includes a co-author who would make an excellent reviewer !
> 

Heh, I wasn't sure you were talking about me or Sairaj but FWIW: while I know
some things here and there, I am not nearly as deep into AMD-VI as Alejandro and
Sairaj. Hence why I haven't voluntereed :)

	Joao

