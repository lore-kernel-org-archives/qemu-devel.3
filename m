Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8794CF3959
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srIpT-0007ne-Dj; Thu, 19 Sep 2024 11:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1srIpR-0007me-Pf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:12:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1srIpP-0008Pe-Eo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:12:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JF4eKO001468;
 Thu, 19 Sep 2024 15:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=VkBjWZUA9jMROg75USHchPBqGW/Y477JFvpGamIH+
 hk=; b=evippUCFVyUS6dRMHq1yJXEBmP7QBb8AYZI8FOCZHEW5C9OZEgqdJI5Cd
 qjABEACfx9EZvgVHT4RAr8HCEUxuE9+SiLpGXkuKaLLrD7g2OJPH2EGsi0nrn6bX
 kpLYoOl462edaXu3zypiBYLToziSGQSZJJ1Q/xIhvnmreH7LfwH0WyngUfsV/nBZ
 aB8mHTc5Jm21SQdhfbXRXPubGtIKWciYpxHlpKLzfDq0IXM0G/tvWaylLSgQ94Is
 gYIVKeQk8cr7uEn7dcEOtSxkgjm4cEPyQOb2uY21IOLIrJf62XxEEeJ6otgY735Q
 LuOjbLrIpxXsB5LGkAcuGqL0UbwCw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rx49ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2024 15:12:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48JEsVVf008137; Thu, 19 Sep 2024 15:12:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyfeyfmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2024 15:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ+5TTmQn4vDP2WbIfafuA7Y7a3ebWqx9ti3v2LPQ27r1p28DW0/Lfl+9TqjqwhhWxFFhyZfjTuhpWUik0izEVVZJfi9ybNkK8gUW57vRE0C54tp8GP3tC0c5f5A/kBBJB1KJoQpfSx1+xLWI/VldNdqhEjV9/mCsKRVDq6gsWJc2lxnj92X+GIwAWiHiJty1h4PdOW/LXBlJktq0pql87D16xc7HesgmB95t0AxGxCAgyx/clm/hoGbREuNMIHasFikxphEws1KAA4mRCDLjwGxCAJ+2aPt7kGM+4Zqx9KpThR270cZc3SCbCUB5rOL1qXs3WXNZgvJAZ+urAIKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkBjWZUA9jMROg75USHchPBqGW/Y477JFvpGamIH+hk=;
 b=J+YhxUUZT+yzTGmtydsn2+oDhkPLCuC8fVNl05EWEYo0FQ8YrR9WmsTPk0XGUoO54CGfqwre6XsevGBOs+7LIVtBEncse0mEoxFXU1trHCV3bUTzfKUYohYuHKK8YLrDenA0GooSHrx0wPSHeaNTmAjUQcoj+Qwlac4DsM3QjydfSMo72EAuizzV3S4wwsnqKqksxEWA65AC59BUfOa2L7Gv7/Z04Eks5OARET21Bd5NAHoI2aBGf2xUDRka0CXmz6MThXsW83UNt/ShKogfXjKatDWQAEEvkjoC2Gl006sFIAW4ar6YdrD/JZPw/4KWjguNrP7fLXkAbwFY0dgwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkBjWZUA9jMROg75USHchPBqGW/Y477JFvpGamIH+hk=;
 b=BmP3chXF3FHkENBzQTb8XrDAn60ilB4EFmf993vC4VdmWA6Po9ySDg+ClQpUPfmF/yiMuL4OmadMB5CSXEp8lzU+lE4msKPcn2Q5s6+3VVIE8pbxewIIQ2hkaNwstNuAd4zLJNjEaKVd1CZvqf2YbtCZb1Xti110j5rL971+Hus=
Received: from CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12)
 by BLAPR10MB5121.namprd10.prod.outlook.com (2603:10b6:208:334::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Thu, 19 Sep
 2024 15:12:08 +0000
Received: from CH0PR10MB5004.namprd10.prod.outlook.com
 ([fe80::400c:6e9f:d137:4a2d]) by CH0PR10MB5004.namprd10.prod.outlook.com
 ([fe80::400c:6e9f:d137:4a2d%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 15:12:08 +0000
From: Jag Raman <jag.raman@oracle.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: of remote_iohub_finalize
Thread-Topic: of remote_iohub_finalize
Thread-Index: AQHbCexPrbqdV6ObKEKMKHLlzNmVjrJfOLCA
Date: Thu, 19 Sep 2024 15:12:08 +0000
Message-ID: <38410E7A-7058-466A-ADAC-AFA494BF4890@oracle.com>
References: <ZusHMRnxjeS5qOd6@gallifrey>
In-Reply-To: <ZusHMRnxjeS5qOd6@gallifrey>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5004:EE_|BLAPR10MB5121:EE_
x-ms-office365-filtering-correlation-id: ade05c54-8cd0-429c-fffd-08dcd8bd6df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MzJEVXlQVEFMN0NPQmo1SWVGcmJFd3ozRU1mdUFwNVRiNmVsYWlJNU5oOUJp?=
 =?utf-8?B?Q3BKRVJmcUVBd1hWVzl4L1I3VEZzWEdpYWFSZDBEYU9jOGNBK0hBdHh1alZX?=
 =?utf-8?B?Tk1HRkhuZDk0TENKcFUxVHdESUdmL1c4K1N0MytwM0tUakVxTVFMU2dmaDhJ?=
 =?utf-8?B?d2VUcWsyMVI2bFBoN2hEVjJFRXFwaGpYWVEwVExqa1hOaFdIbUNoL2dZR1hy?=
 =?utf-8?B?MFNmUVV4NzF3WGJRUUxPQzdpYm5sTHQrelhqalFBSUFVeGNHSlRYTXRsZmd4?=
 =?utf-8?B?YUIrVnZqTExja1FOUWhpMWZIbllsenFkaU5sY1pkTStCVTdBRjRyVFNuWkg3?=
 =?utf-8?B?RXdEYzNLcVlHeXlwL1U5bktrSnQ2Mkx2WHJ4R3dJeVhaa01WVS9KVldJcUxK?=
 =?utf-8?B?emtuS3NCcFBSbDhjY1NxOGdnWGwrUEtxRmtGaERmWW5oaklqNWlRa1lReGhk?=
 =?utf-8?B?WExKMmREam9OSklZSGk0eStrYmFWdVUyRVpGN2d4MlNDakN0UmM4eXh5ZS9S?=
 =?utf-8?B?RTZ3TW85aFhQOE9JRWREUFpiTmlTWDR3bll1bVJoM2ExV1FFeENaQWFGclE0?=
 =?utf-8?B?Q2Y5dnlaUjNYVkhNRUt3dHhOWmtDUER6QmordHB3VVFRS2JTVDk1cHBzdTUx?=
 =?utf-8?B?Mkx6cG5NSUFkQXFndTVrdExUMUF2MERPWUgvZGtEd3Z4N2t4MVRTeEpCb2I3?=
 =?utf-8?B?aVRONURRL1BpQWpVcWROMHorUEZYWjlJZDZLZXNsN3Z1ZG9LRU0wVHlmc3k4?=
 =?utf-8?B?WDNwcVU0L29BZzFzQjk3VVhJNHhXZENsU25vazZ2Z0x5NkNPTlhnSkp4VThB?=
 =?utf-8?B?MWF4QUdxY1RmRnlpRnNxOGdMVGJiSHlWNE5ld0xCek10SlZXcXg0UlV1aENJ?=
 =?utf-8?B?c0lPWWMxUWhta0lqdUxBNE1nY2RxNE5jRVFsdThUZ3JnckQ2eW9oVlNCY0ha?=
 =?utf-8?B?RC8yUzJpd2RQQVdYZzM0NjhEb2ZsSVpYSGgyQWk4QVhJcE0vWko5LzIrK1ZX?=
 =?utf-8?B?ZUNidmUrNjZXS1RWbDhKQ2Y2VHZlWk4rQ1dYL0ppNkI1L0lVU1V1UVcwdUky?=
 =?utf-8?B?ZmNxTVhZRTBWZDdtSDE3cE5WMmxQbmZTQ0RKVmIyQUZJWjNiZC9WZkwwcUZU?=
 =?utf-8?B?bkJMUVgyd1hQdEdPQnBmL0FuaUJ0NVFZU0dla0pLVnZWVzJ0MzRGeElMaGly?=
 =?utf-8?B?VFIrUVEwYmdKa2REa2gzMGwvYlo2b1FwekVtRTg2OCtzN3VUZlFuRGtMcFdF?=
 =?utf-8?B?QzNYM2FzTXZlWFBmTTRkc1FFSGFtVEpzUVpSczlBU3NZZ0dqVE95ZDJoNlF1?=
 =?utf-8?B?ckNTZVNHcFlGOVlpbmxKSnkyZE00U0NodUR0d0k1N3lJN3hNNFY0cmNUaXhU?=
 =?utf-8?B?aWhEM2lnejBGakkzUXNVODhHYUYyZjJGTUI3YXB0YjR6VlZkenRyTnBEaUVS?=
 =?utf-8?B?NnZhSmYzR2xzSkdSSlJQZG1RZ2VaWnQyVUJEUDhRd2FTYkxOY2ZCbzdVYUEz?=
 =?utf-8?B?TGlNYzF0UXRNWmYxeElpT2NKUXpSa1d5ME15cjVQOGs5TXFVMHp2ZFRLQzBn?=
 =?utf-8?B?YnBzQVFKdjVtZkVLSUlMdURXV0hFdy9JcC9CZzkreHV1ZFJPQm1BRHgyaUU2?=
 =?utf-8?B?TU5aQkZOS2JUTnBkQkNLSEtYNk1OcEgxclFRcmxEWGRiMVpWNUR3MU1uSkJT?=
 =?utf-8?B?ak5RRWN0cm1odGR5elo4cjQrZnc0c2lLelFwVHZwMG1PaC9LNE5zTnhaMjJF?=
 =?utf-8?B?TDJ0QlNucW5RQTM4M2o5bmJMRWU5R042MkgzNld6ZWFHQ1Q2a0wydGtpUVVS?=
 =?utf-8?B?SFc3aks2ZEVGTEtabGVCUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR10MB5004.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdrdk5qQlVwTGNKRWY5VTFQT0dyUlNzNk9UbS9JWkpQYUpXMFhsRUcwb0Q5?=
 =?utf-8?B?MG5INVl1YnZIZWhLanEya2d5OGFpM1ZZS2NDWWdvNjUrSVZVSUpLcnhlb1J2?=
 =?utf-8?B?aGswVkQwc2RqZGU2T1h1cEEvM21OdGljOTFwd1VFUnVnSVdvRjR4L1Z3bXVV?=
 =?utf-8?B?eVlvdG9ITUJHZFdDeGlHUURabVpDaVNyUTdTVkYzU2JYaGNmN21INnQxSDZX?=
 =?utf-8?B?R2hiMDRUSzB2cTBrWE9TeG5WL2Niam84bldiK3lxQUw3dWtUT2RkNTZhMmxo?=
 =?utf-8?B?QjVzK01kY3J4RDBDdytxOVZ1bjJ1aitiVGV1NHh2QmJ5ZWVXVW1xTUdZdm9w?=
 =?utf-8?B?Z2JFZ2RNNUdyWGxFams2L2lPK3JQejRCRnFVRzZ6eGxLOThsb3h2N0hpY0tz?=
 =?utf-8?B?WTNkU0Q2MjdkQmtzYVRsTkJzemlqbHd1NngrM3ZFMmppL0ZIOU8xR0NqYzRU?=
 =?utf-8?B?ekhPY2I5V283WUI4THQzVzhDQkYvT283Ryt0M1d2WTFNWlFRTnpweWo2Y2h6?=
 =?utf-8?B?ajI1a2RqdENES3pGZGNpTDhoUS9RUE55dFl0Sm84aHNBMlpPTDFEejFKMTdr?=
 =?utf-8?B?cElrU0RlN21GeEF3YnNUOU1neFkzVlBvVVRYbkhVV0RKSnVmL3Z1bXA2NUdF?=
 =?utf-8?B?UVhIUitJdVd6QUpGTFZSR2lzVm55SCt2RXZsekdsQ3BpVUZDZGJ0aUdDbm9r?=
 =?utf-8?B?UTBWcHZ4NDNBODUwSXVZQTdDRE5TTElPWU4zdmZFZGtaWWZNNmRVdENzVXYv?=
 =?utf-8?B?dlZxRHNMdGMvUXUxenQ0d3BieFRxNmgyS05mNlAyUkxzcGlNN1BpSkswNWF1?=
 =?utf-8?B?TnAyRnY0bU56NTRtbUVhVEQraGVVbjRISjBnM3poZlRVZjZiTWtkTWxHRFQ1?=
 =?utf-8?B?N0d1UGUzM1JlQXYxb1NnYmI2OElYaThvZDQ5cUZVV1NRQjdrbzJNbG10Umxy?=
 =?utf-8?B?cTN3dEpBNXFXMUltVkE2S0hZd3NmNGo3TzlPdDdTV2ZmMUtScno2U1JiSmFZ?=
 =?utf-8?B?VUNkSjRxWXBjZTdrMWxaOXpOWUprdlNUeDgreFpaT1VmWW5aZGlNbEF1aHJV?=
 =?utf-8?B?T3lkdThzN1ZLWER5ekk0VCtNdTRDQ0RLWUtacWtxenVLaVZvM1UvUXIxcFpo?=
 =?utf-8?B?em8rbHhobXJqNW9RRGhhSU0rYm0zdGRicjZCRnRiRlcwaExiTVp5SHN0NjFj?=
 =?utf-8?B?VkhmQ1huejY5dXllN0xuajdCZ3E4ZmNNcFZITnVuc0Jnc1d1MVNWUzZ0eUxR?=
 =?utf-8?B?enlrYjlOUGpQZ3ZKMGtEZXo2WCtRVnlpbkhpcnZYV2xXNThmdTAvbGhJcTI5?=
 =?utf-8?B?ZzBTQVVRR3lxTk1WMXJ2TzlpSGx6T2JHSzQvdjV5Z09KNisvaTlFcDgrMXBY?=
 =?utf-8?B?bHVHUno1WXF4UVpwckxiS01DZkhMN3dQTEJjYk9PRGZYbjZkeTdzdE5XYWUy?=
 =?utf-8?B?YkV4UWhJcm9SeHBoS3RDRi9YU1g2dGlMZVRpUlNhWW1TMzRZbjM2ZFRhQVpL?=
 =?utf-8?B?MlBLNmhTZzBIaGh1cXBUT1hBQzk2NGRWT0x4Ri9URW0rTUhsY3M1c1NyWTZj?=
 =?utf-8?B?TVRYVHlucloxUFlndWxyQXhNRkFCVEVUNy9UeElIWUd1aDRzVlEwOFcrZXhy?=
 =?utf-8?B?c3pNUjI5WmJwOUlMQ3FLQ0lCVm5NVklORjVrNWYzUllTU2xpcWhOeC9tRUdN?=
 =?utf-8?B?THN5ZHhqSmxRSElrOWlzVUJsbTA1LzZzKzRNL1Z3M29reElIcCtmVm1kRWlJ?=
 =?utf-8?B?UWpNRmtmMVlJTkZOQWR0SVVJNWJVWUg2Y2Jlb09KKzFNYzF2WThxSXdBWlo5?=
 =?utf-8?B?QTl5c01yZFV3V3NZcGpYTFkzOXBHQTNWMS95T1N4dlNvdlF4SFFmbGVLcW9O?=
 =?utf-8?B?bXFFcVhKVW4wb3UvTzhySUVrd0t5SktGc0R0ODFpbW1xYzJ1MWkveW5xUHdn?=
 =?utf-8?B?MTZYMno4YkxUMSsrWlczSmJ0dXJ2UFhya1JHY3hSNHZuUm1FN1RHVWJ6VUpw?=
 =?utf-8?B?TzJhbkwvSi9sNXpmMjNvZ2xkNm94VEtuamVSamRLWWF4cWxNaWZIQkc0a1FD?=
 =?utf-8?B?eGxzOThtQnMrK3pCUGpJUGdtdC9RZUZjdkxPcitYUXc5Tk11TWpyVThjTXJl?=
 =?utf-8?B?aWhmU2lFSzVVU1ZOYWhpVnVzekd4S1p5eFVMUTlUek9aUVNESWxZSzIvUkJ0?=
 =?utf-8?Q?BTf0WSA3S4mnzsROHEBVNPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD29CD26937A7C48BFAABC4830279787@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZBL7SeEcIueYRTGyo/YWL+hcE8/Ph8Mkv/H3TUANaQsN7CTbda1mlNHZZradyqODcK5pkXbL/zLrLBMAaON5RJQbOeSStLskKsHURlY/HDpHVY5H9/Nuubi5YBV2bgwV3ON6ve5KxIyHm44xFlRD2abgLRKCiPfZx7zGE+WVfZow07zzSeZrcGi4wQ198cBmxNVHNkGFTXoPa918jPfbhK2KTdXiQgnGv0moHJLYtOJw1qE8giB+0GgPt8GXxSV+ipHDgnnEbATg8wvGAP884hKhVCMmeQFJLQhGo7c1j8pelNulry3zUrGR/gMaalmMbNXMJmi2ATrArNRvQYswc4A1vHwqzWuNchQ42kwuG/uBuyQtH+azx7OmKbIYNbNOfXMuf/RMBp8hJ2LZvg0eyAvhUskeHxsQV7+sagZDxGY1vKkO+fJ2fkq45fvNuJo0MwehWeY8OtJlcc5qfncXjUrODqW0jePXlSGvJVunSRGqPHJRAUFWyHWjAWNajden5ECOOpz7Ym8NFQcZRJ9e69t/r5LfeJd4+950CGWeI4nDqzUkqW0M7/dkE/MdrEJjGexxr76V1Y8Z7cqQnIbWmEvaS6reZc/GZqcF14A1fzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5004.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade05c54-8cd0-429c-fffd-08dcd8bd6df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 15:12:08.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pr1MZNwxNhakavrvinaXn3X9SkBgeN7NZ7yCL3MgPgNnHGeFpMmyHPQQElMn41TxfZDfuPWryVZBZEaCZ2j6TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_12,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=966
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190100
X-Proofpoint-GUID: y6Qz6sMaUeWV_Lqdg7gWTGfpEUK3HZf1
X-Proofpoint-ORIG-GUID: y6Qz6sMaUeWV_Lqdg7gWTGfpEUK3HZf1
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_LACKS_WORDS=1.831 autolearn=no autolearn_force=no
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

SGkgRGF2ZSwNCg0KVGhhbmtzIGZvciBjaGVja2luZyENCg0KcmVtb3RlX2lvaHViX2ZpbmFsaXpl
KCkgaXMgYSByZWxpYyBmcm9tIHdoZW4gcmVtb3RlIGlvaHViIHdhcyBhIHNlcGFyYXRlIHR5cGUu
IFdlIGFyZW4ndCBjYWxsaW5nIGl0IGFueXdoZXJlOyB3ZSBjYW4gcmVtb3ZlIGl0Lg0KDQpDaGVl
cnMsDQpKYWcNCg0KPiBPbiBTZXAgMTgsIDIwMjQsIGF0IDE6MDDigK9QTSwgRHIuIERhdmlkIEFs
YW4gR2lsYmVydCA8ZGF2ZUB0cmVibGlnLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBKYWcsDQo+ICBP
bmUgb2YgbXkgc2NyaXB0cyBub3RpY2VkIHRoYXQgJ3JlbW90ZV9pb2h1Yl9maW5hbGl6ZScgaW4N
Cj4gaHcvcmVtb3RlL2lvaHViLmMgaXMgdW51c2VkOyBiZWZvcmUgSSBnbyBhbmQgZGVsZXRlIGl0
IGFzIGRlYWRjb2RlLA0KPiBpcyB0aGF0IGFjdHVhbGx5IGp1c3QgYSBtaXNzaW5nIGNhbGwgc29t
ZXdoZXJlPw0KPiANCj4gRGF2ZQ0KPiANCj4gLS0gDQo+IC0tLS0tT3BlbiB1cCB5b3VyIGV5ZXMs
IG9wZW4gdXAgeW91ciBtaW5kLCBvcGVuIHVwIHlvdXIgY29kZSAtLS0tLS0tICAgDQo+IC8gRHIu
IERhdmlkIEFsYW4gR2lsYmVydCAgICB8ICAgICAgIFJ1bm5pbmcgR05VL0xpbnV4ICAgICAgIHwg
SGFwcHkgIFwgDQo+IFwgICAgICAgIGRhdmUgQCB0cmVibGlnLm9yZyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgSW4gSGV4IC8NCj4gXCBfX19fX19fX19fX19fX19fX19fX19fX19f
fF9fX19fIGh0dHA6Ly93d3cudHJlYmxpZy5vcmcgICB8X19fX19fXy8NCg0K

