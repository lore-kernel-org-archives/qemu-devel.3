Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECACC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwfX-0002s5-Is; Tue, 27 May 2025 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJwfV-0002rL-H6; Tue, 27 May 2025 11:56:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJwfQ-0005Of-Ld; Tue, 27 May 2025 11:56:45 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RFu5ku030188;
 Tue, 27 May 2025 15:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=89IClZCbYvQCyO35B1CnPsy8F8Kvakjm5vFBdFKq6vE=; b=
 cvwGrET6/RpsfEp0hvTiLts2P5uir43rxy4Jnnn07dYRFe7Zr1YQYabIvcMUUBGR
 TbxthLmnIpngng/Hwerhmmvw4TDNZHJLFypYZIxuBN1x6OnYHiWaMFogP8bnfvnd
 gUTfRtbb48t6588pyynaNfznOy64cm1jV1iQgexzQ4+P8np/Fy9JQV+pkIPvrCgm
 UYtDR9m1UGJLEUaon4l2IkNbjp6JbKHiqFquYUr+KhqXy02Duo+jmRN74OAqiCO/
 D+vFW8AgGP8K/liTfm+wU5uv5gNnd8I5RZIwHm8DpRXFqhzSNQzA7+/2vIivhDVf
 girhrWu+QA2Qx3NdguNg+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2bphq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 15:56:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RFaJA0035707; Tue, 27 May 2025 15:55:36 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4ja2mde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 15:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDxBfOQE3cLu+4TJFgY7Eqz0oq0qfOYi/I6cYXFsKoUOrk3TaX+MemS9NIN9AbCTfbaw8s1HfL9bGl9yHvbyRQUxsl6lm9C0/HdzAnudjRGhtYaYdYJH4NGjENM4JnQZnRq8J0UhcRMLqaNIRsBvM2BJYMaHzrRwiRQaNDbvq+iQreTiMjNYYZXWn17lPr/LGBFWBpmFbiH5BtFHm3qzVM+mjneLE/1i65pmGy0uNx+k6IwIJ3wkwayiYRNt9vhSQdCojww9ccDKugHVW7+6BulpXNqU91clfwgBhm2Cg+CFOcLO1xchnGd3cxvSS+htT/mqwP3pTajL8SP2wF065w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89IClZCbYvQCyO35B1CnPsy8F8Kvakjm5vFBdFKq6vE=;
 b=h9AI0yMn2X/+Qe/iAsyZ1hf7s0qHnO07j24zo4S5sC8560YER7p2cyzKlYqfayLlCgd2OBtfVHcnQa4OYsCghrXU+tthvuytUdogyMjPvTFnkrSFY5+E2G9d9k1e6a+k8Hqom2kcH5Fu3zTIb48vvSZcWRWxZhrym9HoOZebakAwnbZ2LWmLEONefsYEi78Fr6YemOXiD5EuVDfV5JsNuvyQhCt8abMa2xmMCSSj21PiKB+GFzPh/07SxRcjf7WP7rsNLaSQ4m9IH0inMyAm6xLxHEmnlNcw4D+meDgwKRYye352CAl6KnVhtolTRmviXLGiK2Q0KLalTRGOG4SyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89IClZCbYvQCyO35B1CnPsy8F8Kvakjm5vFBdFKq6vE=;
 b=L4t5ZNdbGsFU4aILU5BNrGkfZNPAt8Ckm6y68fKEufQjsZfphzR46zcvtB80QpBv0YU9s+Dj2somEvtPZRJdCz/fTtOd2fxThjUXx7SWTomuYAr2DkJ0QY01IZJ/J9k7IwfWr3R6UAbafc2jYT0t+ykyQ1NbuiT81F1q4wO3myI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 27 May
 2025 15:55:32 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 15:55:32 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Marc Zyngier <maz@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmF3GAgABDNICAAAY4gIAAFtEAgAAGLACAACQFgA==
Date: Tue, 27 May 2025 15:55:32 +0000
Message-ID: <A3872288-67B7-4C99-84F0-19812758FCF0@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
 <63FE2592-DF4D-4CCF-BC76-D8656C9EFA0A@oracle.com>
 <86jz62dzxa.wl-maz@kernel.org>
 <A5135210-4984-4532-B0AF-9CDC8255CBD0@oracle.com>
 <86iklmdv4d.wl-maz@kernel.org>
In-Reply-To: <86iklmdv4d.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CH0PR10MB5033:EE_
x-ms-office365-filtering-correlation-id: b71cca32-0837-43b1-aa03-08dd9d36e990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHNpZVQzUTdzRWh3NllwTmtBOXM0eWtER2JYTGJYc1BLK2QvdnFSUkp3aWxD?=
 =?utf-8?B?NVptaENDYldQRWdNWGJsNUxrSHp5WngxdEdlVXZzaHY3RE5DanAyY0JHRjVE?=
 =?utf-8?B?Y3hJTkxZamhQZXBxUGZRTnk0VS9CZnZ1cEEyWU8wSVpKZm5nSkZ2d1JzN2Zu?=
 =?utf-8?B?L0hVRG81MmpKWll2K3FSSW8xdWZjb0ZMczcwdDNpRExIWUhyd1VxUkxDRlBP?=
 =?utf-8?B?dTVBc2F5c0d3azZNb1gvVTVGTmhiNXdkQnhPZ2FNcVNtZzl6d1VsNFRDQXQ2?=
 =?utf-8?B?alR2cXVOWXdtaEZLaHdjK0NKM2NBVEo0NGlQTWFvUHBiRGo3ZXUvSnRNSzJx?=
 =?utf-8?B?VHlLSzAyY1JQUE5GcU9SclV2eE1SekFJUG5QaCtvTjNuYmpBZDZST2FZNGQ5?=
 =?utf-8?B?UzdKVDkxZitVYm0xdWl1dkhKMTlSVkY1NXNvUDF6eHN6djYrUkhHOXRMOVUw?=
 =?utf-8?B?UGQvc3hXd0wyVGZRNWVhcWlldHdNZG9KVXd0MGVLY2FQeDl1Ull4Y2tDMFBL?=
 =?utf-8?B?TkduYVVUdXZiKzR2YUl1SFByYzk5c1k0YU00MDEwalYvbjgvbkNNZXd1QmRn?=
 =?utf-8?B?dmFnTnd0cVZCSFQxMTUxRUhkZ1hhWHBBcTBBNnJielU3V2NWSzZMM2ZwUHhl?=
 =?utf-8?B?bEpyWTlwRWRTT1gvNzVVOUNYd0V1TGdEYXpuRVRXV2k4Zlp5N1lNd2Z2L3dP?=
 =?utf-8?B?ai9WODFxQS9TOEFyMW9TZE40UmpHdTBsUS9iTlJZRXNNc0ZXM0pqNUtXZzRB?=
 =?utf-8?B?Sjd0Zy9VNzBRR0thTDU1UHhSZFBIa0ZtQ3ZPbWNtZmVXWnNHdy9pMnV2cFg5?=
 =?utf-8?B?U0lEdWFpQ2ExdEZZcFAyUnVGSFdIb0lxN21BWjI5L2M0aGFTTDQ3dXhqTXVX?=
 =?utf-8?B?bFpEbkdaMW0wOWFDRExFOS9KZFpmYmVkOFZjanErc0VEZThHUmR3dldJdzhh?=
 =?utf-8?B?SG1PMjE3Q0xiMXBPSlZMeCtCcE9OcUhuYUhoY0NWRE05TmtXZnAwb2sxeUJw?=
 =?utf-8?B?b09odk12ajRuMU8yMWdudU80K2N5bG9KZVVGTWRaOFR3VUdxamk2b3FGNjcx?=
 =?utf-8?B?SVdPekZXb0R1Y0tlM2FIN0drVWdJb0UrbnpBdE1ObVA2SkRkdkJ1d1J6NW8v?=
 =?utf-8?B?T3E5cG9uSEpLekRXVUFEekdhM0ZCZlJ4SmZINGhRd1JIbE5BdWNQdUlubzlS?=
 =?utf-8?B?WnlCS2luSzVtSFhhMEhzNGtERnR6eDRGWVg4TGdUM09yR3dKK2xMYjBqUmlK?=
 =?utf-8?B?ZDFWcVRhWEtCRFlHdGx2aVdWU2h6bU9nTkMxY21NbXQ4VFJUaFpZdHQ5dk1J?=
 =?utf-8?B?bE91OGNRNndWeVdzSW52Ulo2V01XRGFHSWVzOU1BR0Q4Vkg0TWpWbUVWZVE0?=
 =?utf-8?B?aWI0czhyMlNSTHNsRU5YZTdrMG5CaVhPdkFhaENCQXBKbmZVdjlDa1JBNTlx?=
 =?utf-8?B?MWdBUGlJWnl3cnVJNjZZamtObjd0cEZ4eWlGWXZHL3VyRmQrQ3dRV2pCaDZa?=
 =?utf-8?B?WmZrN0o2ZDdoSktwQXBrVnBxZGFDc1piV3hNcWNzMXlkay9vbWxHc3BwRGhJ?=
 =?utf-8?B?M29UTU5OZk14b3gwNm5wRjZWYUMzVFRPQlJNcHBzOFF2dE9FYlkyUm9WbmZ4?=
 =?utf-8?B?aUFZREltYWR5Wk5iNEQxS2p5U3hXMTRZQkYySVFXQ0Z0dGUyUmdUdVdKaW00?=
 =?utf-8?B?eXVaM2FpUWFKdW9zVERVSFFOUkVQUnBrUW9IcWt2Z2xtdVJpdkhSSUdIWU5V?=
 =?utf-8?B?NzVhZ2dzS2xSdjN0anY1MXBWTVh1clpEYThPUWIrUkQ3NDFOMDJid2NQZDNw?=
 =?utf-8?B?QXNITFlnYmtyQzNvSmhJMmJhb2krWk5qQm8zM0RnYjJTU2IxMzFVMTNwTndH?=
 =?utf-8?B?WmVmTVFhdXdHTnJ4ZnNPUitpYjhtMW4zUm02YUIrLzdTaFdmdXVyQnRJNnlN?=
 =?utf-8?B?QlVQY2dKeStCK0xmQmxHMXA2YjN5RnNUY2IyRThtSXVteDlHSjQzU2swczly?=
 =?utf-8?Q?wWZIclaTM+mpKSsBRCw4fKYiL1UMA4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9MSjN4Nmplc0VqZkUwam9PUEJ6SUJkL0owcnJHY1NadlkrSnZSaE9uekdF?=
 =?utf-8?B?Z05GV0F0cVRkcXl2R09wT01SejE3RGhORG5xQUx5bjk1TEMrN2NOalViWkJv?=
 =?utf-8?B?VlFYY1RRL3VGeEpuWWpyZlpzQVV5Z3pnZHhIVHF2d0o2L3NyMkd2dDVPeFFu?=
 =?utf-8?B?QXNsMzJKNzI4ZUphYWxVTGQ5MFo5VytKZjhndTAza0tFRVJFY0ZjaEZDRkpG?=
 =?utf-8?B?OXJtSzJNL1V4OE9vQ0M3UkZaYUYrNGQyN1BLMnByMkRUL3Y3ZXNINFFhb1Fr?=
 =?utf-8?B?bW1oN1IvN3ZqVnptTlFzNmJIeDVFcmx4N25Zdjg3YWNoUTlabXNBSWNwNWpn?=
 =?utf-8?B?YjYyMDBlSTNmN3dkOWxwNGh1S3Nac1pXakI2ck5aSnhhUmRyUWpzZG5Wa3pT?=
 =?utf-8?B?WXIxWDZORk1pbkw4cENrc0hBWFFycjc2enhxaFFwUVFiTkd6M1IxRDlVSEJn?=
 =?utf-8?B?TjJ0RHVoZEZHdklpT2hSUEs2dG5EUjJXSm00czN4UTQyYy9GNnN4N3YwbTdO?=
 =?utf-8?B?Ym9VQ3prU0lDQjBNUkJlMXFqeFRaWlBrVVZHT2VQYmtCRlF4eVBHeFl3WUlB?=
 =?utf-8?B?UkloRjREM1lKS0ZUNkpXV1duVEg3Uml1eUJLNjNUbkZqRC9PSTBjdnJJMHlV?=
 =?utf-8?B?aWtNNmtneFVhKzkrZm1EMmtCaFIrOTA4ME5qc1IvVTZoNVNibDVwWmd3MDBq?=
 =?utf-8?B?dEErRWY4eWE2TVpUR09HTzhMTCtRclByWEZjcmtERUxlYW4wRE1SR0lRaXNj?=
 =?utf-8?B?NmUza25VN25aREg1R2psYnN4cXpBYzg0aE81NGU3QXJEazFCOGRCWGc0aWpp?=
 =?utf-8?B?R2dKQUc3WFlLU0ppMTdIbnFyNHJCbHBTUGVSUmJhNzZtUTFQRTlQZkFOZzhw?=
 =?utf-8?B?bDVrRFk2U0tGakExdnZwU1FNMnJRV2hLd0VyTTZ2aTJ1alVTMDh4ZTZkUTAr?=
 =?utf-8?B?RmdXUW54eFVQNXdXc3FJaEFuWGlWWnFyd1g5QU1lY0YyS3M4WmFONzdPZ0NQ?=
 =?utf-8?B?V0pwUXY3TmUwYXEzbXkzVUhNN1ljUzV2OW9WZjk0bFlQYjhLQ1NiT3ZWdmZn?=
 =?utf-8?B?eXcyODFSTlVYMDFWMzlkY08yOEQzNFdsS0owSDQvZEJCc1VESFN1YTUyOUVO?=
 =?utf-8?B?ZmpId1ZLMjY3eElDYUwrS3dvaFpZamhrdUgrLzBUdE1Ud056MlIrRzhkcjZj?=
 =?utf-8?B?alZTUUo5ZXRZT003SW1CVWsxL3RVTi9Cd3cxUHRlNWFNR2haMzh0MWNLV25Z?=
 =?utf-8?B?bElNL2VUQVFONVdJN3FZM2M1QmgrdW40MTBwcG5lRjkxMmNqUlUvLzhGTzRn?=
 =?utf-8?B?UXVMVGdrbUlFS1JVb3pGemxFd3A0SHRiYzV6TzlldEZQZzZ6aUtXRGsycXZC?=
 =?utf-8?B?Q0oxeVZrdENzM0toMENGRnhxZlM3OGh0YnNzc1g1R0Z3OXVwL04wc1p1YmEv?=
 =?utf-8?B?K3liMFpZbVlaOWQ2Qi84UlZDTk1hV3B0WE15blZ6YSt4Zkx0ZnJDVE5sNTNn?=
 =?utf-8?B?RzhCOXBIZTdjc3MyTHRSMHczWkNWL3NZanVOajFnb0VLN3BpUHY2K3RSY0sz?=
 =?utf-8?B?UVVlRDcrdGlPb1hDc2phbFhnYlRPY0x5MlNpb2pVVXVVMFlWTmZNY3F0VFQz?=
 =?utf-8?B?UjR6dk1IVldJdEZqbDlFUSt2bU5vOXFQNm9GQ25XaDF6QXZEaWlYbGVnM1Nm?=
 =?utf-8?B?YUJYRVc4UUpFbmxZbFB3Uk5BTE14ZEhMMlVlNWtLOTlzdWE5d25XUmQxMFBY?=
 =?utf-8?B?OGphUis2Z0oyU0lRc3RZYm5Yc1gyU2ZsNUhqYlFqdWxkYUt1SDd5czNydlpO?=
 =?utf-8?B?L051K3pYSjludTZOZTZOd1IwejZuK0sxSlZsazBta0NWNVlFVHVlbFJiKzY1?=
 =?utf-8?B?Mm8yd0VKci9hU3FiQnBkQVRtR3pmYU9XZjl3VHEwOS9JY1dVbXpkUThVbnhY?=
 =?utf-8?B?TXNiTUxtZk9ERnp5ZEVWZWM3VTRkWi9td1RITzhLd3NxZndFZlFUY0Fhb3Ju?=
 =?utf-8?B?dEJWZDluaTJRQmhlZ2hiY2EvZktqM1lxT1RTNjRjQnRsbXRKMStiTXZCY1hs?=
 =?utf-8?B?NGJSUmZ4cURGUC9IZ28zNTBrOUdZNVJzcC83QlU4N2gwVGNzWUNWUGtnM0JS?=
 =?utf-8?B?K0tFWE1WMklNRnBjdnJ3QmI3N3A2RmRiTEcyMkl0bWdzQWlPcFZ2Sm1GZVdR?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7ABD4AE5D704F478930F27117985BC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4y2Utc9xAZT+p3smgQngwc6P+F+/8+o5Kx1269gDFl5x1v9pB0rzGWHqujNY0oCRvhm/2LUu30BaKh54UgK293hU+yGpZYK1mIw0aqVFl5pTARpJDr7CG8fMCG5N8gasqnbRX4lrKvVLq8GY+gFcaB4Rr/LtqtNw1DwFyELIlw5F4h9kNGjosuGxVrP9ZyK1z9Zt9f/Ib6lAAU5n+9qgOYMhhEhFX1UT64K62VPEufdFKYSOCrtKSr5QJd84YDOvXVMi71BUgxGNNMleYlL6UqJgn1kcBtwb3y43suIVG9U2romvVLNj9g6aF/kl+ECIow7017T4XfeF27+7N1zk44s/B9OEzv/fCoHzOVfIK4J2mVOfI50a7Vl7ybVrXj6+zzt20aLUZwTx5MjYOjOzMmfwHbyCGcoSLZ1tnIuo39BTuAZk9JpE8aCH1NCh9ZztzVnDw3xH/QOOJKy9SyDbik64fQxOiXOd2KrlkaUwDa2QKO1GKawyIKMm4G1xhX2n+s2pHCJX7dBM/8B1W1VOEK+gFbd4zIihcyH862/A5MvXxUHE1twRspnV6zE5Qo1uG3duZX3M4lPXtIrwlXvDk4RpQgWb53/HpzXlT4MARn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71cca32-0837-43b1-aa03-08dd9d36e990
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 15:55:32.8535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IKnnso0rNDgqTJqYTgrt+SGkNmizZjWvBsBr+O0yc1rKahhSKhq/+5F32HX5cK1M5jsepCTXWFrHwIQ2MUOsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505270131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEzMSBTYWx0ZWRfX/tByWVHYKoeu
 B18Ig4Q1fuzBcfKk6K3La2C/7y8SeKVIOtRhNl1tmUTImSDjEy64zjmicBEe6esOeUHEoWRHjaR
 565lB6lui1ST9yMhIVpyZFrz1qYKlujGuFEMW+Qba3Q3roh1JibkjStS9bcXWFBM2Z3Dlbc46g/
 JCUbSV3V8kdOsvq2CQEVgro+6z8CV1mRvoi82kSC4L63jLQ4pWXoPIpkCHE5LHGrbpVQZdiee/X
 cjROY55fA7FKng2q7EiJz8BDG3t5HcpAi1fxu7RQFfekqhR4cdCe7U8pDSWHpP3+G6BJwEYqLXm
 OtvgBKY351f9GDFfW0JkDpiuuQufusyovDV3nxwccOYGCLQ/BxbjipHipSdqYvVZD+Fh2JqeyhH
 hBNKqNXCeeshfj9zLVOnnQx2lcAEwqstGl0G1GDwO32CEe4CzVCXRy9d2mU1Q+8gEIqqw9Me
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6835e0a5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=WXNyBEICJGXpLUgoSnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rkEVk36nmk07yViZH4c9VtSktkdJHtFY
X-Proofpoint-GUID: rkEVk36nmk07yViZH4c9VtSktkdJHtFY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgTWFyYywNCg0KPiBPbiAyNyBNYXkgMjAyNSwgYXQgMTM6NDYsIE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyNyBNYXkgMjAyNSAxNDoyNDozMSAr
MDEwMCwNCj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIDI3IE1heSAyMDI1LCBhdCAxMjowMiwgTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCAyNyBNYXkgMjAyNSAxMjo0
MDozNSArMDEwMCwNCj4+PiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+Pj4+IA0KPj4+PiBIaSBNYXJjLA0KPj4+PiANCj4+Pj4+IE9uIDI3IE1heSAyMDI1LCBh
dCAwNzozOSwgTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+
Pj4+IEhpIEVyaWMsDQo+Pj4+PiANCj4+Pj4+IE9uIFR1ZSwgMjcgTWF5IDIwMjUgMDc6MjQ6MzIg
KzAxMDAsDQo+Pj4+PiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+IHdyb3RlOg0K
Pj4+Pj4+IA0KPj4+Pj4+IE5vdyB0aGF0IEFSTSBuZXN0ZWQgdmlydCBoYXMgbGFuZGVkIGluIGt2
bS9uZXh0LCBsZXQncyB0dXJuIHRoZSBzZXJpZXMNCj4+Pj4+PiBpbnRvIGEgUEFUQ0ggc2VyaWVz
LiBUaGUgbGludXggaGVhZGVyIHVwZGF0ZSB3YXMgbWFkZSBhZ2FpbnN0IGt2bS9uZXh0Lg0KPj4+
Pj4+IA0KPj4+Pj4+IEZvciBnYWluaW5nIHZpcnQgZnVuY3Rpb25hbGl0eSBpbiBLVk0gYWNjZWxl
cmF0ZWQgTDEsIFRoZSBob3N0IG5lZWRzIHRvDQo+Pj4+Pj4gYmUgYm9vdGVkIHdpdGggImt2bS1h
cm0ubW9kZT1uZXN0ZWQiIG9wdGlvbiBhbmQgcWVtdSBuZWVkcyB0byBiZSBpbnZva2VkDQo+Pj4+
Pj4gd2l0aDogLW1hY2hpbmUgdmlydCx2aXJ0dWFsaXphdGlvbj1vbi4NCj4+Pj4+IA0KPj4+Pj4g
VGhhbmtzIGZvciByZXNwaW5uaW5nIHRoaXMgc2VyaWVzLg0KPj4+Pj4gDQo+Pj4+PiBEbyB5b3Ug
aGF2ZSBhbnkgcGxhbiB0byBzdXBwb3J0IHRoZSBub24tVkhFIHZlcnNpb24gb2YgdGhlIE5WIHN1
cHBvcnQNCj4+Pj4+IChhcyBhZHZlcnRpc2VkIGJ5IEtWTV9DQVBfQVJNX0VMMl9FMkgwKT8gSXQg
d291bGQgYWxsb3cgcnVubmluZyBsZXNzZXINCj4+Pj4+IGh5cGVydmlzb3JzIChzdWNoIGFzICpj
b3VnaCogWGVuICpjb3VnaCopLCB3aGljaCBjb21wbGV0ZWx5IHJlbHkgb24NCj4+Pj4+IEhDUl9F
TDIuRTJIIGJlaW5nIDA/DQo+Pj4+PiANCj4+Pj4gDQo+Pj4+IFNvbWV0aGluZyB0aGF0IHBvcHMg
dXAgaXMgZWFybHlfa3ZtX21vZGVfY2ZnIHRyeWluZyB0byBoYW5kbGUgbmVzdGVkIG1vZGUNCj4+
Pj4gd2hpbGUgS1ZNX0FSTV9WQ1BVX0hBU19FTDJfRTJIMCBpcyBzZXQuDQo+Pj4gDQo+Pj4gQ2Fy
ZSB0byBlbGFib3JhdGU/DQo+Pj4gDQo+PiANCj4+IFNheSBob3N0IGlzIGJvb3RlZCBpbiBuZXN0
ZWQgbW9kZSAoa3ZtLWFybS5tb2RlPW5lc3RlZCkgYW5kIGhvc3QncyBLVk0gc3VwcG9ydHMNCj4+
IGJvdGggS1ZNX0NBUF9BUk1fRUwyIGFuZCBLVk1fQ0FQX0FSTV9FMkgwLg0KPj4gDQo+PiBBIEwx
IGd1ZXN0IGJvb3RzIHNldHRpbmcgYm90aCBLVk1fQVJNX1ZDUFVfSEFTX0VMMiBhbmQNCj4+IEtW
TV9BUk1fVkNQVV9IQVNfRUwyX0UySDAgYW5kIGd1ZXN0IGtlcm5lbCdzIGNvbW1hbmQgbGluZSBz
dGF0ZQ0KPj4ga3ZtLWFybS5tb2RlPW5lc3RlZC4NCj4+IA0KPj4gVGhpcyBzcGxhdHMgdGhlIGtl
cm5lbCBmcm9tIGVhcmx5X2t2bV9tb2RlX2NmZyBhbG9uZyBhIG1hbGZvcm1lZCBlYXJseSBvcHRp
b24NCj4+IG1lc3NhZ2UuDQo+IA0KPiBCRUJLQUMuIFlvdSBhcmUgYXNraW5nIGZvciBuZXN0ZWQg
b24gYSAodmlydHVhbCkgbWFjaGluZSB0aGF0IGRvZXNuJ3QNCj4gc3VwcG9ydCBpdCwgYW5kIHRo
ZSBrZXJuZWwgdGVsbHMgeW91IHNvIHdpdGggYSB3YXJuaW5nLiBUcnkgdGhlIHNhbWUNCj4gdGhp
bmcgb24gYSBwaHlzaWNhbCBtYWNoaW5lIHRoYXQgZG9lc24ndCBoYXZlIE5WLCBhbmQgb2JzZXJ2
ZSB0aGUNCj4gcmVzdWx0Lg0KPiANCg0KQWNrLg0KDQpJIGZpbmQgdHJ5aW5nIHRoZW0gYSBncmVh
dCB3YXkgdG8gaW1wcm92ZSByZXNpbGllbmNlLg0KSeKAmXZlIHRyaWVkIHRoZSBzY2VuYXJpb3Mg
YmVsb3cgd2hpY2ggaGF2ZSBzaW1pbGFyIHJlc3VsdHMgb24gdGhlIGd1ZXN0Og0KDQoxLg0KSG9z
dDoga3ZtLWFybS5tb2RlPW5lc3RlZA0KDQpMMSBHdWVzdDoga3ZtLWFybS5tb2RlPW52aGUgc2V0
dGluZyBib3RoDQpLVk1fQVJNX1ZDUFVfSEFTX0VMMiBhbmQgS1ZNX0FSTV9WQ1BVX0hBU19FTDJf
RTJIMA0KDQpSZXN1bHQgb24gdGhlIGd1ZXN0OiBObyBlYXJseV9rdm1fbW9kZV9jZmcgc3BsYXQs
IGJvb3QgcHJvY2VlZHMsIGVuZHMgdXAgaW4gYSBoYXJkIGxvY2t1cCBzcGxhdC4NCg0KMi4NCkhv
c3Q6IGt2bS1hcm0ubW9kZT1uZXN0ZWQNCg0KTDEgR3Vlc3Q6IGt2bS1hcm0ubW9kZT1uZXN0ZWQg
c2V0dGluZyBib3RoDQpLVk1fQVJNX1ZDUFVfSEFTX0VMMiBhbmQgS1ZNX0FSTV9WQ1BVX0hBU19F
TDJfRTJIMA0KDQpSZXN1bHQgb24gdGhlIGd1ZXN0OiBTcGxhdCBhdCBlYXJseV9rdm1fbW9kZV9j
ZmcsIGJvb3QgcHJvY2VlZHMsIGVuZHMgdXAgaW4gaGFyZCBsb2NrdXAgc3BsYXQuDQoNCkRvZXMg
dGhpcyBtZWFucyB0aGVyZeKAmXMgYSBkZWZhdWx0IGZhbGxiYWNrIG1vZGUgaW4gd2hpY2ggbnYg
Z2V0cyBvbiB3aGVuIA0Ka3ZtLWFybS5tb2RlIGZlZCB0byB0aGUgZ3Vlc3Qga2VybmVsIGNtZGxp
bmUgZGlmZmVycyBmcm9tIHRoZSBleHBlY3RlZD8NCg0KTWlndWVsDQoNCj4gTS4NCj4gDQo+IC0t
IA0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9z
c2libGUuDQoNCg0K

