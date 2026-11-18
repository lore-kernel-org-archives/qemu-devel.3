Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44084606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Xlco88e/;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Gu16gA0H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTV0W-0007bc-W0; Tue, 17 Nov 2026 21:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xTV0M-0007bF-06
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:02:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xTV0J-00087b-Ip
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:02:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMXeLq4128098; Wed, 18 Nov 2026 02:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wGD/3AyXYsiy8RDRsqnOQk3kOv/NKNc+B1zbIfiPd/w=; b=
 Xlco88e/szkD6Mkt7ELx1miUdEy8vTnBFv/R0HE8C2IweJAJqVYiuiqASjpDSlXK
 L3V7a1hAUloisuX9TtLlIVic0C5ZYWa0X9RBxo9hc5cs86BxOVG1nNhZSvyc9yAM
 pFP4I7qcDjbJgbm/3uiL6F6RXzORfHdjxjUDRk9O/MWVpmYq27FJTvKsqNZRg6C6
 3hvsHCxrQhqIzozLRNKn86SORQ4v8XI0MDha+u3gqanzReeWMEND3bqgjttw6W+w
 +X8NGUY7i9Y3C/N9ADzPHVKGr3b4dKJFpXlV39mOeiU6Lc3r2hMxN9Hxx8B1mMpb
 mhw3iSG3/BKULuSm/w72+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytr86du-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 02:02:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6AI1O5S23179361; Wed, 18 Nov 2026 02:02:24 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4j12argxv3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Wed, 18 Nov 2026 02:02:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJH7W0ch9btLIPHF7KFCox1WgxfIjxyTPil+IzvEvhQba/XoiAT+r3vGK+/BV95RaUJMFSC9B4puTuvj3esqXJje6d4KA9T4fIMIYtCwn1wYLOL9goMbXlEWAVqpR00qCZTvkXwJQNK7vGT1haNrqJAZ3CTOZb131f/qYv87cvRH0MMidw99uHbv+L74Fx+haXdsxzOkIES+ImMlbepe2cEG/nax1LlyaloX6pv3B+RSZHLIGcD3GyZ6+vwiiaKaDADuU0VG34lmAXFtXBzTmEdTtBzUbCcspWm+lSq/BGMfjbjD4a4wxJWVuGUoqUXGetPBYWDI9Qr1j7EVfF3vyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGD/3AyXYsiy8RDRsqnOQk3kOv/NKNc+B1zbIfiPd/w=;
 b=XLANF36bE1tV8gUZ1TuD+oFNc8BzGEnfoqQjFuwiZLk1KNr1TlUhFvpaQ9VvXsreyQOEcR+KyjfLvcRmYwHmBhaS9Wy+g2Xx65atUais4DpPz0Kbp2NtJ1AhQkK35vGg3z/eLEnBBNuW57/SY0hTDg3xIv7V0fsHtlR7ESAmugmEeZiUoEDkl/mhO4IDjHNdwYEZxNgklaWraLqRz4c3Un/xbrfrLPfa4rX/FAWK4XD4rkliECDVY2umpQZK/s9H2LThwrqyGFusCZwVgiTC5IAGBWksUBXyi5bLtf0gqEitgMGtPkPOv0cYpSF52Z1DcBgCBMiv9P9tP/77p3e9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGD/3AyXYsiy8RDRsqnOQk3kOv/NKNc+B1zbIfiPd/w=;
 b=Gu16gA0HbxIXPx0/Q8SmERWFKrfIj4dLYG7IhGV3kuNXemk9KTn5msekQu9M+5PWNStg9Y4ZfjxfE7nCYOQRoMS7n1mo1PwGFQMNl6s5Yqu/0VXf3rx7C0qFbkBGiCiebJxiCeZuEMLbVPYCFBO6ewEc5sfa8lGGFagR7wnQG9k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by DM3PPFA927664FB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 02:02:20 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 02:02:19 +0000
Message-ID: <fa74f48d-dfd2-4336-8ea2-a53d46004e72@oracle.com>
Date: Tue, 17 Nov 2026 18:02:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com> <875wxvs2na.fsf@suse.de>
 <avyqPuj7jz3QKM7K@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <avyqPuj7jz3QKM7K@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|DM3PPFA927664FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fefc62c-a66b-4f9c-fafc-08df4517fa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|22082099003|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: +Z5PVYg0Hs2VyyUu69K6/FotKFCXhaBQJSzJa2Y75BiLYR0Yruw+Q50Xvie63N1DpqL70MdnXWsZPTTYYhh98rBQ/jhKMC8zlUk7Jl3xi7feth+/8s67p81swL6S+TzoOxZ9G9I44ekh5Gx+ARazz1iDvxdCiBgZm2kCr770GrUrKZ3rM845Ar8BY+FGgVKkQssbSaeOj30LOhczIqldDrjZ9AJlazHprK6CXavcfRbzE3UOor4tx1Fy/NGwZLpO6HoYvBoKq48IucComyuIYRKl1MJHwrJxkKq/pe0ptVuzBix9BkETPAqIgUmF/4a9OD8XgBTpICLf0Sr5PPdB7QRallpIEDJH4Shgmqp1D4cCVP6tZXJSS9E0YMvWvP9Otnzn0bKUJxeXvzpq9ZCydx6LhGyudptJ7RVs5KPHZbfdIo29sWVMLN4IAJm3SqQ6rd+4dhjBdH9mH2jn4P9prFZQdfGl59takgMKYet0U3nBwhIgjNCF3fFKEOfdZ1SYgcpkOYapJonGDr11Dvn//3osmh5a/00by7TZ6cj4BX9GgU4vWa4dYI7bVsYwJWUY8QSiEL/7XJLKMSHNHYF7Ckf//kuD9dnTPn6fqZMxXD3cjowRA+arvxPomKrPmw4msWubf8Mg5Wwde+cbHecg+unXyMoErl6hZucpdvfuq3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWQvWDJCclZIMmh5WnhTTVNYa2lQYXVwT3QvMjdTN2QwNU5nUWxocGpDb3Vq?=
 =?utf-8?B?T0ZOdWJpdXdId1Zjc1E5MGpYQUVRbHBsTzh1b0ptc3NtekVKdFUxMnpla2VW?=
 =?utf-8?B?TUdFaVhtakpNQzNDR1R3STI5aDQ0SUlXd2tzbDA4QzQzTGpyejRoNkVwa1lw?=
 =?utf-8?B?WWwxcjNsTTB1VXVTUTRaQm9QUm9UL1RZR2xOTmJYZjY0RVFyTzFKaW9vSHFt?=
 =?utf-8?B?NktNU2F5MWRWcjVUVWdER0pzWWNUUTA2Uk9jMTM0OFdlTzFFckt3d0owZm1Z?=
 =?utf-8?B?YWhyc29zSG1JNENNd3FNRkRrTGFZV3VYTTArZjhrazdOUDY0K0NFUGhWdnh6?=
 =?utf-8?B?RlZPVnNvYlZLZEhNVlRmbEROU214MHhnS2VFWkdRbFhsdGV5UzJ6MGRvUS8w?=
 =?utf-8?B?T3gxZjBrUVN6ODIrK2d0WEJpMWEvWXNIMXpXVlRVRGM1a3dyNlY5SzNsbzk5?=
 =?utf-8?B?THp2bXc5L0Vld2MxVFo3SzJEaDA3TllvWDdzYjhFN21TMCtrSEZoZjNVU1hB?=
 =?utf-8?B?eXlCN3dsM3UwdWE0c1JTRHFlUjZlMnhCWS9oYTNnN0VBYlVXQWp0S2srNXcv?=
 =?utf-8?B?VnF6NEFraitpUXVMV1FTenpVQVZwUURkUUQ5cDdzeTJkUUFLdisvU053aVRr?=
 =?utf-8?B?dUJsWXZHcjh1RG1VUnE5SFZDVS9nbWI2ZEVyY3UwZ2xMR2VDSjVLVFl5UW54?=
 =?utf-8?B?eVN6QzFRbi9FRUVWelVvKzFKTlMycUxwdmFuUGtFa3VGSjQ0bWp1RVh0OGVr?=
 =?utf-8?B?UzF6eTIyVWJ3SWZqWjZWMzRpdTNyTnc3YnlDakk0OGYwYVFBWnRoQUEyRFhy?=
 =?utf-8?B?SU9zOXU1QlVjWlUwbEplSDZCQWlZVkJDUm9ITWxZVU5hRHFuTWN2UWFSeDFk?=
 =?utf-8?B?ZE4vT0oxMEZsR3kyT1dNOFI0R0piT1hLdkhSTGttdGpGY3hPa2ZucUtNdEV6?=
 =?utf-8?B?eDBHK0Q5MmU2aG5CT3JjRy9iT3lOR0xMa2IvR0FoZkFqcWtIeWVDYWhmOVQw?=
 =?utf-8?B?dDhJYVRjV1FQQld1dVcwUEU5eHg2aW0zKzdxckE2U0E3Y3Y2NmRTenppd1do?=
 =?utf-8?B?Z3VCcmtpTkpxS251eDBwVWh6V2dTM3M3M3pyb3dtOEphQVVKazlPKzlQRE5B?=
 =?utf-8?B?ZCtxTEdETnR4ekRYLzZGNXZNZ0hVM0ZsbDZ4WnZqYmxwYjV3cnFlblNPelN5?=
 =?utf-8?B?dU8vU2lweGtNdzdsR3htRTc3QWk5a2pvQU1tYlUvU0hCTkRUbkJmUzBhOUI1?=
 =?utf-8?B?QitPWWRBOGdsYmQ5VjRyVUhYN2RSTURlVmEwY1hCcmw2dUNYWHNLMU1OM2Ri?=
 =?utf-8?B?MGQxK054d2ZYbElQNkZnMWhFZ1Q1ZE95Nzc4cG9JU2hCRmwrOGJCYVVScG5j?=
 =?utf-8?B?Z1dhUm1haHNKYUo4MnZOdU9QQlRhOW1QbTJpb09aTTRHdzBlOHI0d2dIZDBJ?=
 =?utf-8?B?RHE5N3pqVjVBRlJsZDNITmpZYnIyZ2h5Q3cwbXFCc2RvM0t0ZmF0aU85ajF6?=
 =?utf-8?B?Y3B5bEEzSGs5QVNUN2IzSThvSXI1L1A5OXJPSHYyaTVZdjVEWi9SWUZnKy9T?=
 =?utf-8?B?d2VlMHpOVG9kWUNDZ1lyVEZteHZxQ0VpSlBGUnBSZTRKNU1mQ2NrcHQ5dU9k?=
 =?utf-8?B?UlN1Z2J4Z2JaWEJJTlRWRStUUFQzaGk5Vkx3RFQ2Z1J0NEppVkhjVE5XalpO?=
 =?utf-8?B?VDVlbE9hYXJwT3duK2lEVS9qZ0cyYTlTYUp2NWJzNXp3TXgrNWh5cSsrSHZ5?=
 =?utf-8?B?eHdDRkVSWGhVbWJxMHZZSE5RS0lCR0pOb1habDdVN0Q3MWc0RkM3RXdobFhB?=
 =?utf-8?B?TWgrL0VVZmlsYXJUSlVwSnE4ZWpkVlFMbFhUQUwvdkVEME9YK0V1bGZ0WVND?=
 =?utf-8?B?SDFaVWsyUVJWUGxJcy9lVlFpdGFkOGEwaDhDZE5hc2RvdVllam9HTnpwN2l5?=
 =?utf-8?B?M3Bybjk2ZW43cDNGcWgzN0NqOStwT2NiTUUzaWY0ZUxOVTlGdHV6UitFbHlV?=
 =?utf-8?B?QXlTbXFmZEdRTnRQaFFYTnVpelJDRndZV29LSVUveEk2SHVyS0FET0JERnJB?=
 =?utf-8?B?ZWlDZ2o0Q2N2VmRUWEY3WVBSRlJPeGZIVlppempTUFF4ZisvY0NkclowR2sv?=
 =?utf-8?B?MERGbnRoY2tXK0tGc0lZcGswbUs5ZU8vNjl0dlVMK3d5Z3FwbDhmNk4xdFpv?=
 =?utf-8?B?cGFJVnAzR1R5MWljeEpSR3J0bmJKc1JDN3RiVDVlbDN4TzEzUkV5N3Q4YUtE?=
 =?utf-8?B?bmpWc3gxQUhKMVJOT3hrVTEzV2R4SHpmSXZ2b2x5OXg4RWtQcGU1cWUvd1JD?=
 =?utf-8?B?UDdxeThPa3VvMHFlWElGVGQ3ei82T2Jlb0I4QzBaWE83SlZJdVJVWFo5OXdW?=
 =?utf-8?Q?RfDMCwN27yDu//X8=3D?=
X-Exchange-RoutingPolicyChecked: Jm8tOmuiq6so5Ez6u0DbPdHP/rluPDiK0ZFDazs7ZKPkHkqKMkMxddrS1xZMg6KbJpDlWuhGi75fgnLO9tTmx84ktxxmgoFia1PvfKl50ZVC0L8Wq5yciYQ88i1qZZFR/zmQZPmygb98FmN/05sAQZMSQhmzO5g/8p+VWCePcPocApu2QIv2TT4jaVxEZQkNq3Q7QXdoiH+coI5/V4i2flphtD9dPeOudKqcD7N4+un6yuMWeh3ZlplhgNmIOzopKMbmGysD8TvOYAKhbi4uNDwfl+tHq+lQ2hckk4dWq0eke/5e7rDVb2BE0HWQD0AXxvm68QztSmAP+a2EMSPSgg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YELUhTjwkWDz5+NEVQQbPG+wNoBrv6H8uE3s6+YKlXOmFJsPL/pIRqosHVzxfOdMA1Lpb/d6fFH+KiXWYMcmwLseK74mCT81O+ChhMRmjTBLNi2fanMTmcH07X8X25/ljLtd8jc0fbKwI89e010/8cYTXL+Bmd7frKyfwcJdbld4BYAMUcA4gRTANs4FPxYZ+tggn9If3kNQYQtEwX7ACV4zPya2VChoPugCicQgtXrXoVkAwubOMnOoDX5b5OsOiiQAwEpTzLpgWl97nZ1y/LSOxarHcbyUFn9t0noVyY+tg1JMbk8htxxAgxRg7Hbf+OjCJ351DE5184TNPtPMYiPONmYPQ/q/Pv+PmirnLPwwjnlx66xd5Eoqb/dMlrKYg5TyECxrkXyrV3Drqu1o4Ei4U87k/VgZDYfeLiRekeMKR35xTSIMsu944kjLUch51ZEwWHdc00dZOaZF2BVfMEgGvwUoxtupF4yIcOOjbEgW3AYPm74/ejJo9u6ofbVYr9xZA8q/ADAUhPpALO67S3iTuie6rp9kly4gRvgUjLlTfDd4DmOuECskbAOB5LIm9CHEQGRyGBN0gRjz9FVRIbgdHg3qNHy4zlV1OuzRULk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fefc62c-a66b-4f9c-fafc-08df4517fa60
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 02:02:19.8111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BULtwPNlbuRVEvaebgXJQ5QG9VtOhn3/mxTAgIHH1h/atC78/WpkoAUeyflzRlSQl6L2YjsG3bedWq/QpP81qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA927664FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180007
X-Authority-Analysis: v=2.4 cv=f+Ldl+yM c=1 sm=1 tr=0 ts=6afd0731 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=td_4hULFa98kxQEYAjQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: -CFmHAhT-whMRRyBQowBdl06iaMbZE0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfXxUaf9V5C1CGD
 YN28wtZF4bFpTuai1J59+amGImDwjg0yiqpB1QDHQEhc5UbUn/x48MqvWFqX0Aynx47ojvIyS2h
 MDCT/5kMsvFhR+UVxHMiulbG/lTMePn+d8/Ywpfq6O5oUDUv/I8w7EO4EtVc0FVXC4zHa81cBHh
 oBt6eEUoWFUVOZw0jJbjW5YF2dRbQ0sQdMYM7qJovZHezLMiz1YWxqQUQh8em0fAWeuqHxeRP3c
 N8ZNJLn3bfYlIpslRk+OaUYARLt1D3oz1BKhhDq7sGkjKEwyjPNzmwsE+tSqkuwPYFKcThQ7nBi
 RNkQTWS1pfRwMCadsDAo9Fj2CD6XThp3j+4PtIq6vEPqWQP4nPsT+C4O/6mh3rzeeo0KsRnY6Zc
 VySki+aFOBPtXx91IvmRc3Vz5fUN1o13I8aCbYTQJnPxnmEy7Kpt0SO2Go8e7s1bU9H1QyFoYKG
 SwjullB3TG02vYfLJqrfm6CtLhwaNVlRyTeP79RA=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX5Ozy170UfFIR
 /2SPYglHNvXqcsfow6OcZHtbTUkPeX1e7pkpYI7dy1isJpCL8r1T+Ivhp3fe55/PQU1g3z6a2P1
 lg6TsSYvyoVQ7I+8fiab7G1BOzzn2OP91ECsAiOcuW64ShKxDbrn
X-Proofpoint-ORIG-GUID: -CFmHAhT-whMRRyBQowBdl06iaMbZE0e
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Fabiano and Peter,

On Tue, Nov 17, 2026 11:25:50AM -0800, Peter Xu wrote:
> On Tue, Nov 17, 2026 at 04: 01: 45PM -0300, Fabiano Rosas wrote: > Sorry for the
> delay, we're all swimming in slop these days. The only > feedback I have at the
> moment is that this feature needs tests. What's > your plan in this regard?
> 
> On Tue, Nov 17, 2026 at 04:01:45PM -0300, Fabiano Rosas wrote:
>> Sorry for the delay, we're all swimming in slop these days. The only
>> feedback I have at the moment is that this feature needs tests. What's
>> your plan in this regard? Can this run with nested virtualization? Or
>> perhaps is there a way to mock the kernel interfaces and ensure QEMU
>> does the right thing even without them? We don't need much, but the code
>> definitely needs to be exercised somehow.

Thank you very much for the response and suggestion. I will follow this to make
the feature more robust.

So far, the only way to test it is through kexec, which not only takes time but
also isn't friendly to unit testing.

Based on my understanding of LUO/KHO, with the latest mainline Linux kernel,
once the fds are preserved, there is no way to retrieve them until after kexec.

Therefore, perhaps we could implement the LUO API functions in QEMU through an
ops interface.

1. The first idea is to implement an emulator so that the ops interface can
support both the real API and a test API. The test API would talk to the
emulator to emulate the preserve/retrieve procedure.

2. The second idea is to implement a set of test ops, with QEMU launched by a
parent process. The source QEMU could preserve fds, and the target QEMU could
retrieve them through the parent process.

3. The third idea is to implement something in the kernel to emulate a quick
switch between outgoing and incoming fds so that we can retrieve them
immediately after preserving them.

Options (1) and (2) seem better. While (2) looks easier to implement for quick
unit testing, (1) would be better for testing with arbitrary devices and
configurations in cpr-luo mode.

Thank you very much!

Dongli Zhang

> 
> Apologize from my side too on being slow, I'm going to start reading mails
> on the list this week, but it'll still be slow, together with other things.
> Just to say, this one is on my review list.  Sorry again.
> 
> -- 
> Peter Xu
> 

