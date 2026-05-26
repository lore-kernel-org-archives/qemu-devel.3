Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415CDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtpZ-0008Rb-Mz; Tue, 26 May 2026 11:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wRtpU-0008N1-Mx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:36:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wRtpR-00021Z-EI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:36:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5Pjrx3174100; Tue, 26 May 2026 15:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=QyQMyCfQ9Lr3D4tD6UKhMIxxyQlqxZfvLIOobSeKEp8=; b=
 GT7L+n00+agaXNnWvjoPD4ZSq0j2D2blnm/CESc6lh7mDaQ8cdhquQyjin62/vij
 ltpjO0qHQEcgOydHpCo4CS9DVwbFHWWHdED9ejJczpMeYmdQxCz/yJ51tw4gCmBt
 Z4X6TzrgMCE2t8FvCkNgC9Zu8xAAP7HSSp5xezGzbggBGBDhFJmVhlQ4CiRueRWi
 Jyx96d6eu7ffH7DKln2QzuUphHBJCIO3EH/PVO8K4EUgoctsTfh9ytL+8eCEYqvN
 kr11pG2vKzjS6OzJrJ8rIzqNZAqf/VMqmv/yvTrzOn/afPyowd+dtj2SADdADuof
 GVDQV0sfxKo0Hu/JKaHADg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4awbujb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2026 15:36:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64QFYqGp030383; Tue, 26 May 2026 15:36:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ec08mjj7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2026 15:36:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaacXcZugCX4s/qCbbAj4rwXoTeLVo01WXejh/3lBwJKTSB3ABBARtzzgkGPzfGY6M8sRDcJ8F5s6rMPTB2khTPfUqeAtHD0q512J4ZqvDkniWN1jQKbQKCATIcVbmgE9l3+Rn3qD4WMsgUSMy6Z8KTwdkcxlbWe6vDKMixi6141O7/DJ99lL4VOxqc9wTzQqaYAYvbioqAyuqxX11W8+7dB5zMW+HasiWnhzdS6gzp/FQCQ12ic7bLT5A3dOARWFIRsZdjTZDIL8gn0Zfpz+9cb9qvV8WfPj0ZlCmrntO06uAgoImzARihv4uc/fXYMAd6sJSnhdNKtnzCKEYEopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyQMyCfQ9Lr3D4tD6UKhMIxxyQlqxZfvLIOobSeKEp8=;
 b=NwIRpckWkC0kZrGB0JyfqQGQ/gWOrrMTaCWrEYxKmt2qgZ6hgZ5aBYayRVrpn/4NKkxFq8LX9z453UDn6XOYSbWQyMRadbMFLeOzbq28pLaBlsEoxmLDZuQbSfn9l4hfe6neox5edLoJ5t97bJBT06HRzKy2cueB/rnk30+3g1sJ/kcAgPz+2BScWarsvnG0/9t/tFWtxV62vFSizl9Fghd1c8zl58dThjBECrPRCCtW/t/yRzcUntHoj4FJzYNrg6RicNeJ3I7qh1j8OCOiztdrGymE75vhnaFhcWL+LAjZXd66JwNJjfUnZZY4mQ70fChlxKLvj+S7nIryAzQk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyQMyCfQ9Lr3D4tD6UKhMIxxyQlqxZfvLIOobSeKEp8=;
 b=Jfkc+kjpR7nCRreGN7LSXxromngYkmnRgdiACHrgokCPt+e2P00+k8iFwzMXiRK69++AKRthtnAkQutJpJmwytdEgs30hRqcUONJUY9juOCFPZt6n+ZsDAeN1apBZCf/B1MDzTJDLbO3lCJdMZGX+GD6sWuQS3mRn+puxGOdBQc=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 15:36:16 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 15:36:13 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WIAAAVgA///FPgCAAEZ0AIAWXFkAgAWE3QCAAG1WAA==
Date: Tue, 26 May 2026 15:36:13 +0000
Message-ID: <4149B107-919F-4F92-A1BB-9E416CB23E39@oracle.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent> <FFB3F5F9-4F32-4836-B71B-35899536E5A4@oracle.com>
 <ahViKjbOqWrz7q11@lent>
In-Reply-To: <ahViKjbOqWrz7q11@lent>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|CH2PR10MB4247:EE_
x-ms-office365-filtering-correlation-id: e8ca9787-e264-459f-cef1-08debb3c84d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: AH5RSjIgNmulmivmqxlMM9IFqCtZBuNULdg9yUZLMNyh3k6rjIH/EakoY4IvF/xDPVKZKiVDNLU3UZl7HbjOLjoXtEwxmY+q0npqS+0Rc5z9KtiOBzgl3oU/l5sxxUfQmShSQ1wMHeSdJnV5GM8It7umQg7cwszeooqInH6AEL8ob6RVwKqi1Qb4jBmD1e/qnQTkElqITRTTTX2rwx+JQTwtEiR5hkO2W5fd7WnjMsYNEo+2AHbisLrRNBc81l33cPW8oCUmKd85RBuccXlyvMiBsO1XoaFIFaj9k5CQ/dqSXZnWCHXB+Aan0MbF84a+ikQNzUVBnmVsgDbu2ubmb3gDZyMxMpfQOxUzKp74KG/fnwi03GhChexAFelc1PvqRu6nvQKDKO78b9GoZ814DN9x4h/aqt6tMSzWUeqx0khKSHRSzGdaYkam4SQY586bKxR12g8BQrelEI1yYd9qr5s3bGVs1HMQs+5xQAfTBt0me7DDUOKiV58wuPi8D4Vqbhh0U2K2iq/crRQogzCSzFJhrh2TqZ0p9OwugcD9BQB1kQAtiYQTfhArb4p7CRavij2EYHlDM1ZSiKNiXItGeVrf5YxBT/Yb5ZV3701V+WHEFYQNSo19snB1EEbCY3NF+wpnGthuEK6JUVxeGCFDXWAvWABGH1bc3NVbhXEclE6GKzQcuYe/xEazAjwuYJFlVUJe717t1U+OxHMqcIVryu0eqoueaRQUJwPhx5fTuHqaQxdXvLHBhHp/lSMRVohn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXlyMTk3WW5MOGdRSmxOK1UrYm5xcFgyQjllWU5MdTlxOGd2eWZPbmJGT1Fo?=
 =?utf-8?B?TXFQbmJDYVJPVnI3blFPQXd5T20xaDcwVnB3WmNxd2ZDL2VwTllMQ2t0dklO?=
 =?utf-8?B?WW01UWNFb2hReHBMOWRiMDdERmFOUmkxdktVOWVTTFZLSG83aUkwa2pmNnI1?=
 =?utf-8?B?bzk1c1l0ZXc3NDN4R1ovNEZHRmRMbWpwT2RCamZzVVR2L3U4ejBLTFB6QlFS?=
 =?utf-8?B?S1h0aXcrbnVSZVRnN2FjR0NDNDZYbFdsRHV1b2dFbnpKajBMODhJVVZ6Tnh5?=
 =?utf-8?B?cFNXVk0xWWJlN1VGQXRackFwWEFmejY4SlVkTWtRSGpKbUxuSzRPSVc3YWwy?=
 =?utf-8?B?cVF0OG56bDNtSVgzWnZ4ZGVJNVc4bnd0UWlnM0lQR2t1enRrZ0ZoLzcyVldW?=
 =?utf-8?B?TmZYb29KS3lneUNvaU12QXVScndFL3Z4eVVxS0hlbzY3MXVqRC9rNlpDRXRU?=
 =?utf-8?B?Mko4WVFtdFNCL2JXQmlXVFpZRG05UG5kMUttcHMvQzlqTW9HL2VKbUxhMk11?=
 =?utf-8?B?TnBiaUYxSzdnZ3MxN01GUkdsVzJuZzB6eXdiT1pEMXFlNXNTUnBtWGxjNjFw?=
 =?utf-8?B?OXFEVGxXL2pBbnhoeVJ6QmhQYTNyNlpVdHgrK0pCTno1VTlLdVdxTUhNMHUz?=
 =?utf-8?B?NzY4bDNiSWJ1OGU4Z3FaS0dUQmovNXZwcGVGa3FEcEQ3ZU10Qk1KV2F0Tkdo?=
 =?utf-8?B?TTdTajdDMW5pOXlRTkMrZjVFZGgySTlpeHlJa1A1T3FQdGs4aFNFYVBqeTEv?=
 =?utf-8?B?YVVDVFNMNVRVUlVtS0VyaG90eENrRVVOMTU2NnQycHREQ05BdmIzT2ozeHJN?=
 =?utf-8?B?TmRNUjIzQS9iK2NQSEg1VjRuOUErNjJGeUlTL0hjdGcybFVSSXNKV1d1Lzl4?=
 =?utf-8?B?bjBaZzZwTEszYmdXdlp3aGdBRitLMmdQeTFMbENsMmhiTURkYzByQzF4cUhL?=
 =?utf-8?B?S2xqMVRHcnNiNFFKU3VJREl3VTIrUGY4OGo0U3d3VVUzeVA0c0srZkpnMGxo?=
 =?utf-8?B?bDRNODNXNlNoODUxZG1aaWZ5OW9WQlRkd1ZML0JNTFpxcGZwa29TZUxMNE41?=
 =?utf-8?B?V0RyR3o4Y2tRRFN3cWFqMVhmemZrOFhHVTFwKzlKNkE1TlpTcmtzd1BhVVdW?=
 =?utf-8?B?ZmI0SEdBL0RrT3RHQklEdGREWmw3cjdyTkxlYkFPK1grZmE5SFIwMnluVkN3?=
 =?utf-8?B?Z0FtMmJYcHEveXUyd1ZET0RtTysvaGZQcGVKc3VnTFZvTmZZa0xOc3I3Ry9V?=
 =?utf-8?B?NkZmUVRJSjRmbER3L3Z5b0FQbXZlZjBlWlJiQUMyMGZ4WmlhcWtHQUJyWjV4?=
 =?utf-8?B?TXFTWGc2a0lqemdmdVpWYVZWTzF6MmdqK2RxLzlsS2F0SEVwc1djYlI5WE0y?=
 =?utf-8?B?MU5DTlU5ZFhrdWcvdk9haHBIR3lweGhTVlR0QUFzK1ltdmJ4Y2hXMVVwSGwr?=
 =?utf-8?B?S0hNelo4TEZoRjVYY0YzVk5ITEZrdzQ5TEhRa0h1RDFSZXpmVFZtck1RaWpp?=
 =?utf-8?B?cFhpVkVNYm5hV2hjeTgyOFF0cFRwS3hMZmgzQ3lkaUl5VGtWT1pWN3VtVi9H?=
 =?utf-8?B?aVJYQzdCUXBGd3NNcVhQZHFVNWFPb3dEVml4K2FDMGJBUFAxOWtBdHRRUEtz?=
 =?utf-8?B?V2N6QjM5KzUyeFY2WCtTdkw2VXY0ZnlYYnV1WUdsY20yMk84TDh2OVJjdUZv?=
 =?utf-8?B?RjhvY2lzY0o3SHJFdENyRUIwOUxvNkNXMkY4eVdTRFhFSTh2SXFyYmlyRlRI?=
 =?utf-8?B?aisrcGNuazNrbTVscmJuNzNLd2NzTldEZGNWcFVLSjVBcE1oaEsvTjdOZXpm?=
 =?utf-8?B?RWRCcHZOazlVQlVBME5xVUNyN2tySlM1S0huZ3Y4cnN4YjE3K0ZJTEg4MGJi?=
 =?utf-8?B?ZmRzZHRnM0U4S3pyRDk4VE9yeXlLa0lST1lBMmpXSU5WN2I1RzYwcTBSa2dx?=
 =?utf-8?B?VWk2TkdMUEJmL3VkWFVEZTZPVGUwd2lHUUR6RWxYaDBneSs0QUVMVFVOREZD?=
 =?utf-8?B?Rm5rbksza1NRbEtvMzRFYk05eFVWeHBkekV4ZTRndk9kNkp5d3ZId2pNZHNE?=
 =?utf-8?B?ODZHNW9kS2tOYUhtSCtiZC9HTFN2WHVHb1FaUmU1by9yREhYNjkybEZNWVpt?=
 =?utf-8?B?OUpMSjZWRWlUR24rYU1scElJZmM2SUg3YjAzMkI1TkFtcm0zdW95QnE0Zlht?=
 =?utf-8?B?aVNvUk80T2JubEorWS9yWWJ3VDBmb2k0ZGp5S1R0SDEyd1Z3a2x3K1ptM2Rp?=
 =?utf-8?B?bC8vWmFCRi9Md2VzMlhWd29GZlJXVWgydTFWdkQvWlhSQkM4b1MzaENpU1BE?=
 =?utf-8?B?dHZZNkx6d3VLdXBkZ3d6cnJEQzNuWDlxU1crTDVRUGZieVZXcHF5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D79664576D87143B5046343348A20C0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rWlVEZNfJxGTNvF+fwR9j9BEFs259dBEsEEITePG21fEEO4IH6GLgmBQW29kfE8k2D01dS2QIZvxFAk5VMdrCbPwfU48Rog73uavfkee+YiHjHkqNn92kfKJximSRNw6CFG+7+Ow3/dts/0baXnJHPAAEpL8Vopuz6MSLkXNXXwckGUAqS3KXY4CAWewjdU1v76s2tXYUDjxSZzR/MfQtOZFCICAGU6rW0L/Zrps5UMsMj19Bf90KUhGzYk/qXu8ZSlpBY4Y/ahw0FLpVRabhdL1CVjkYLQGmfdMF2SKMGrpFyrCym5RJBPTshNGk6paFESFFT7FZBfGIiIzi6T8jg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lZlqq0HeBgPlIHowhltUsXplxBfREpKGzVqbm1bAQEmPY7qeaD2Bj2Nn22lV/Pu+iwodoJ9XVEKyCDtdyo+fxqc327081wzybdcQI2sg9NlIfpx1PU9SUosK1fv8tCPleT8ksMu8rgNROuLi7HXaOkchAD05eYrh+vUyDYePSX3DyxXqqUwHYck9V7Qw4+lVTrdW6hQ38LPvbmDJkfpuxHfwJJi6cyS/M5vLHx/gAl/a1+t0UgH50vtOkI9GbKssrHFdhs86+maXbTPGmqaf2HYFk3GSK/umERnjfko3TkEycNfvuqoBSkwyEPWp5xDiFpQyjnFqDPpM0pFZpBXfthtgZGZ+9R/FrukNCgdWdlWK8z7sHQGhh1O2JLbd54cTt3SC50W8oUrT48a1jzYyBgwHzFEKzKdqVQ6wOeF5n17okb1gGVB//T4aPHVq1eJe5IcrMlIeaiBStYz/2DT1E5j00IA7KuGekH3NSUG6184kWKgdTSLBWB7BwJJ9E/i3wqsdMN9NHX7grBVeE2HszaFaw2O6OkaT2JBTcM4958h9/78prKrvJfdiGI3Pl56mJpm/PwMg6EzfUDPN3PNxKS+kgLk8fAiCK336hOd+r4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ca9787-e264-459f-cef1-08debb3c84d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 15:36:13.3701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIZ2nKOHPppauZSIPFTFOkKPMu4o9Gk6aUGrxQ6QkyRgC2TQVuSYEcINUGJFY27G+F+oUtOcv5p1cr/nryRy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=824 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605260134
X-Authority-Analysis: v=2.4 cv=QrluG1yd c=1 sm=1 tr=0 ts=6a15bdf5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=64Cc0HZtAAAA:8 a=AYF-ktLJIOxSOfmZtRMA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13706
X-Proofpoint-GUID: vqNUtF6vVcw7z8k6K9ajDYMeJBrwd07y
X-Proofpoint-ORIG-GUID: vqNUtF6vVcw7z8k6K9ajDYMeJBrwd07y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNCBTYWx0ZWRfX/59Hu2B5UJHK
 G+mVP0+SfvTRM+2al+EKbpcPGx7NTZglkPAFyLElwC9llApEOwlw+Ae7GYk26/IHqhBYJOGJxAz
 w/t7wkE2QXMkUM4Ph46WVtv2Y+Gre3X+/0AOYeUN75K/Wy9VDYw+HHRKzvQ/u/fmoWFYkpCcaYu
 IVsnYp3DHq/YltiYdjggzNUDAWLOV+f4iUgljjilE9/p2SVN8etRSKUR9AiIPLz0mc8DmqbDeON
 wpw6ELdiMFeod2J3HE7oOXu+A/wV5d2CT5eQFTgzyLZiq67zNBQUzdzS6sAA9BmM2YrU2/vtpMe
 3Wjzrc79qahIqvX60S4/9aoDMikhkpA45JYd2mOmEU1T5VdtPRhFewv/YHuE+hVMwUZK3cq7kd0
 rJnVGIUVDS3YYGwRkTqHGAkSg68WDI+BhG8MNfQrzAjcZv/PTAsz6FW4U+LuAVpdcgUCIWMxjxv
 ZOtelM2CqI0jm60/6vLX2WYkPr3LA4/H3UIRfbVY=
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

DQoNCj4gT24gTWF5IDI2LCAyMDI2LCBhdCA1OjA04oCvQU0sIEpvaG4gTGV2b24gPGpvaG4ubGV2
b25AbnV0YW5peC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBNYXkgMjIsIDIwMjYgYXQgMDg6
NDg6MDNQTSArMDAwMCwgSmFnIFJhbWFuIHdyb3RlOg0KPiANCj4+PiAzKSBpZiB3ZSBkb24ndCBz
ZWUgYW55IGZ1cnRoZXIgd29yayBvbiBjb252ZXJ0aW5nIG1wcWVtdSBvdmVyIHRvIHZmaW8tdXNl
cg0KPj4+IHByb3Blcmx5IG92ZXIsIHNheSwgdGhlIG5leHQgY2FsZW5kYXIgeWVhciwgdGhlbiBy
ZW1vdmUgdGhlIHdob2xlIGZlYXR1cmUuDQo+PiANCj4+IFRvIHN3aXRjaCB0aGUgZnVuY3Rpb25h
bCB0ZXN0IHRvIHVzZSB2ZmlvLXVzZXIsIHdlIG5lZWQgdG8gZW5hYmxlIHRoZQ0KPj4geC12Zmlv
LXVzZXItc2VydmVyIG9iamVjdCBieSBkZWZhdWx0IHVzaW5nIC0tZW5hYmxlLXZmaW8tdXNlci1z
ZXJ2ZXIuIElzIHRoYXQNCj4+IE9LPw0KPiANCj4gUHJlc3VtYWJseSB5b3UgY2FuIGVuYWJsZSBp
dCBieSBkZWZhdWx0IGlmIC0tZW5hYmxlLW11bHRpcHJvY2VzcyBpcyBzZXQ/DQoNCkkgYWdyZWUu
IFdlIGRpZG7igJl0IGVuYWJsZSB4LXZmaW8tdXNlci1zZXJ2ZXIgYnkgZGVmYXVsdCBiZWNhdXNl
IHRoZSB2ZmlvLXVzZXINCmNsaWVudCB3YXNu4oCZdCByZWFkeSBhdCB0aGUgdGltZS4gTm93IHRo
YXQgdGhlIHZmaW8tdXNlciBjbGllbnQgaXMgYXZhaWxhYmxlLA0Kd2UgY2FuIGVuYWJsZSB2Zmlv
LXVzZXItc2VydmVyIGFuZCB0dXJuIG9mZiBtdWx0aXByb2Nlc3MgYnkgZGVmYXVsdC4NCg0KVGhh
bmtzLA0KSmFnDQoNCj4gDQo+IHJlZ2FyZHMNCj4gam9obg0KPiANCg0K

