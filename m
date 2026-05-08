Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA97ECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLM5Q-0003Md-SZ; Fri, 08 May 2026 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLM5O-0003Je-Bq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:21:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLM5M-0003Fe-83
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:21:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486HF1G260963; Fri, 8 May 2026 14:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=1vzNIZhdIvoe4zz4EU
 0vywjA1H79w8hB2DY3o7LITaM=; b=cLWzod6HmAxKso7IRdFCtDHrShrKXar2VG
 zxfxpHeSsWgGOOTwSk2A/3eSs/KqeJ/3X0GiShmCA6Uk5ok3t9wCzZer7PB94pdE
 D5JDqUdM2RzOfWCbX/TBUw0kxgzCQKjZs3AhCps0HHaIW53b+XSz/WZkclg4zG+N
 a+aaLofDVsQHLCXYhkXSEe26dRjMaFiXhTj3jPByx2smInrV3GUNyBoKIQKyvW9/
 gtRD4Bv5BXxK8xe3jPmwIRudKRH7mylPLmk6NkBmUpj2vDol1w9ub/43Zr99DUdV
 AgWYo1D7LrxZpVDASLch/Kl/wnAvmLXqrBPSIKrVkwWmw9pPGdYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9tr321g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 14:21:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 648DttSp019395; Fri, 8 May 2026 14:21:44 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx57a0kpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 14:21:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d90OZD8athMXf+VTro6N9MYUE+8MPp4006MVxI/fdaXbO1mpPhXvNYcmtIq7GiQ+rORG5JB9I9UUhq6qLCcSYKGkXvpu2/T0TlQcBQbt7cZMn7AgzDTyCAf8Z6YfhBogHK9pJCTbE03Dbtvmh/DG0OEqLpyGRDNDvrmE76kfPvirpVHZrp8XAGZ7p1w3bJBHFAmSb/wosNDLqDYp2EbAtqQXM+5gy0psMWMO1DUb3jYL224f5ne/a+6g4VWYSNvEeQmC4al6ypr1d5gwsAuNg8CFolfeqV1eZcuFkNmx5fsFiMiezZA9uXZkUBUeuOtxX1LPgS7Aw770/Wl2NZvC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vzNIZhdIvoe4zz4EU0vywjA1H79w8hB2DY3o7LITaM=;
 b=y+vdRh8t3vYvX4LvZ3qc8VlEL9MHKDnxqAThBbReDZmq5/p0KSTOz17eCrax3P9l+9qu3BTTnbUuAJj0mtrQo66R/ZJOWSiFrFM+TClF1luFAp+AQdaCLrZXCMhic4bti2XZM/dPbI5nvWIlZ14KB9KW/pB3h5yk5SrDcS/Cv0+7cUeUPvndurZE4BcNFNxRdoxTwO7aKWek3eHUdbIfpPR4ikD4QTIVXzX/r2gMsZ9ZXiy3S7QX2olwVrXZcM9HPlbtOyusMauVbGSLmwojkOTl7/z8BWOPsLYNfDC18sA2p9GCYyIoymEUep50bqCGCUH5xK2egG0w+nCB6TwPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vzNIZhdIvoe4zz4EU0vywjA1H79w8hB2DY3o7LITaM=;
 b=kJEZ0CerTZdK6Os8uZmNvaxVoYILp4IlZ05S6cANybj+SfIHHI9TvFKqB4iBdZZGzTqoEgT3RgX4xYHBOwHQJ07d3mDylAdF4XEIoG3If29qWY2SFrSzCi4saPEHbJXs5iVLG14bPf7EHzikLBt3+wZqJLFIs7TM1UyQYP8r3TY=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:21:38 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 14:21:37 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "clg@redhat.com"
 <clg@redhat.com>, John Levon <john.levon@nutanix.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWm
Date: Fri, 8 May 2026 14:21:37 +0000
Message-ID: <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
In-Reply-To: <20260508102657.644247-1-john.levon@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-05-08T14:19:58.3403963Z;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients; MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|PH0PR10MB4805:EE_
x-ms-office365-filtering-correlation-id: a16a93b4-6577-4099-e26a-08dead0d1dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zoJELlEzzHnGDBPMDphgxdm293FqhrBtlPQDwtGBYwrHWHvK4H9g2WRIvyBgJjkcrpIBV8s0Y241onnn7g6RgzzfLRBUqj7I2n3TZMpkMxSR+t/bEdQmJ8TPnztqhsqg00W4oq9EiihOXUDpzIdZjUYZ2gASXBNNiL+iwHIgk7QOZVqDWW384u0UEpofXKJe4dsWbO6N9/QUFk/7NDvh60kZCJ0Q8SWpQEHBur88cTVvMgPVZ80mvyKLv93nduQ5DW7qrvtqs9AIAWKd90S0aS3O8Yrp4NLOsQFGfKILeCauhmRXHeXrvOMKVL5yxKmMnCvq9Y85OqxVLPBF6lPClOJ0fHPt/e33em2TG204XDDyxT6ifWxjyR44aXQzJv1Vvy8RAgVa8wbXVuzTmO39qSymgWb/WsR+qhES8O26CZ7ePRVwACbfstbC+/TXcZQyNKh6zF2EJToZ+PulF9Cawzj8MTBp4WIdWxKlak0zkBDZsF6oBOa0qaBjWfhA1YLHWwxxgzKnFgJZmaG+LY/UGHspOLAaw9vKwEW66mpNNWwwZ5HdCno6i6siHFv3GQ9hYhxk1RxE0E0wZlKa105a4C88HcSaU+Cno19dOTmfwI/N621OfbZBPfyodG7xXqDc8VVDGMJ3fAs88o99b8aLAuGBFdP7lq+KchKpz8kG28CM1GhNepmshBEFxHodkCYtLIv3+YRbLHh6rU5tx742FUsbFQJ1m83RysvdrAkSkiaqEeKbDR3F70PxPf/ORrmr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1ZaFhuZEUxN29yc1ZISkJNOXF5UVQ5RlZGU3lIN3cwajJma3ZVNTFQUTVH?=
 =?utf-8?B?dE9GS0srQjJrdmRDTVYxTkh1TDB6UStsZEVETE0rQXkvdEgrdEhSK3p6TUts?=
 =?utf-8?B?WUpLV3NySEJCbSt1S3B2bUFvMHEwOVJnV1JVL0xVZlVBMWlITHlpYkFHbVA5?=
 =?utf-8?B?N1VFTUFlbVE3T0NxZnBxVEh1dklkQUIxQzFtalprM2hWZnFub1lvcm9ZbTVF?=
 =?utf-8?B?RG1ITk9MR0hkVGJZWGJuemxVZVgrL1U0YTdabkpNUng2MGFiLzdPOTRuZ01k?=
 =?utf-8?B?bDI3Q1JFQnpVZ2k2Vm5EVEVXSDc3dGtDdU1vc1dndEovMmF4Z1l3cElWWXZ0?=
 =?utf-8?B?WDVxYWtKQklGY0xaZU84QURtWjhCU0JlTXZiSVFEc1J6NFNYNllMVVRZOVo4?=
 =?utf-8?B?U1VmbTFWc3RqU1l5VC9xTWpnclJJNTdNRzRKdXNnMTlMVGpka2Uxdm16UVEr?=
 =?utf-8?B?WmM4bElnVVF4WDJLUzFHaHQ1M0tjV3JmMDdTeW05a0lUT2Z5cGhPNHVUQVpC?=
 =?utf-8?B?eEFiY1h5QWVCNDdBV3h0bzZqb29ZQzhIc3lOTHdsdDFOdWdpQW9ndUQ4anBj?=
 =?utf-8?B?dGQxRXAxcktYa3AyYVVXWmd3azUxbVl3ektzUldpdFVVcUJScUd3UzZ2aTFH?=
 =?utf-8?B?RHpGbGR0NStLTEZ1cCs4SFFiQXRVam16WlpWOEdlazdnaCt5WHdPRWl3Z0I3?=
 =?utf-8?B?WUR1TDdjbjV1TUhERXdwL2lkejJjMmZGQUtKV2Z5eHhQcGJaNFZJWkdaK0tG?=
 =?utf-8?B?VU1JT0Juak4zMVZNcDhmVkZTUG1wRVZyVHB1d3pRSFFuL1ZOcHBZaldiM0Jw?=
 =?utf-8?B?LytuM1FRRnAzUVF4S3UwZEpSM2FScUFRRTlsNXhRbG1Da2FxaHJKL21LYVM0?=
 =?utf-8?B?OFBOTHV2N1V1OTJzUUd2Z1l1dWFoNVJNS0dBVDljaGlHSEREa1pjMk9iUi9B?=
 =?utf-8?B?Znd4TjNyMERiZi9wS1Y3QlpsK3o2QXlnaHRKNUI1cmF4YWtwTVF3YnlVMnBs?=
 =?utf-8?B?VWlFbE9FQzdPNFAyclZMdGM2dG1oQlhNazZ0OWxKVk54ZWgxMXovWXRSTldv?=
 =?utf-8?B?eUFyZWU1YmFxUXBzRDJNbjBoRXgzRmMvZ0pTRndRZU40eFlnaW9IdGRYT1I0?=
 =?utf-8?B?REVwbVlkQ1pxeXMvelBJT2VFc1NlNjdrY2szSjRDUHJNUDlLQ2s2S1gybWpO?=
 =?utf-8?B?MFZVckJjYUlZZERvWnlEZUVaOVVpZVBQbGVnLy83MjR2ZWVEUFduRXlvVlA3?=
 =?utf-8?B?TzArSGttRkVIYWZuTmh6SmpSV1Qya1FLcUF6QjdrbWVhQWxXMTJpOHdyTXVp?=
 =?utf-8?B?Q1JPMnR4bko3aC9ZUGhJMFZzaWViZFplUGlFN3o4UzVNdGZtWkd2U1lteVE3?=
 =?utf-8?B?VVUvYVN1RlZPcHVlWVJENWhqWHZlZUZ6MGpybW1WRzJnbGJIajM3c2E3ZjFU?=
 =?utf-8?B?U3NUSHhNOExUTHNUVERXZ2xTOWZoTHNycVE1dTcyNzhNVmpxclNCaEUvYU1a?=
 =?utf-8?B?MEJia0pkNUtyVXZ6eUZpMnA5YzVIN1R2dG9mdS9ZT1JpdFhzcllnVit5c2xB?=
 =?utf-8?B?aHBRTzR6SmJuZlRDa1hNckNMeTJBNGkxenFWS3hhdUxJdHh4RDhQQmhaY1lu?=
 =?utf-8?B?NjNEZmtNeTN6Wi9rbWZjdzJmem5CaUxSSHpKQzhzbXJKM041Mk1tT3JjQnpk?=
 =?utf-8?B?WTJsRWptTWNEUndZMHBWMXZsVDh5cDZmUDV4bDNsakNXdVNIcUNNd2JqbHFO?=
 =?utf-8?B?c2tHeHdFejY3a1liZm1TcTlHeFpVMEV0djVXRDZGR28yb0tWZmh3QzhLTjZP?=
 =?utf-8?B?ekdXVSswWjJOMlRORUNBTVpoTjBwb0JrbHlhd2xLQllMZGJFNVk4UDBmMXZy?=
 =?utf-8?B?RWNiM29GK0t0T0ZZeGZyNjQzZDh4T2dKNkQreElSbFNvYm5KNzFxNkpzWWxX?=
 =?utf-8?B?VVFqQ1ludFJmeXJ0d3R3WWFCTVZLcmZBaW9JUDVicU1xcHFLTXRTU1ZzS2R1?=
 =?utf-8?B?TTVjRXFmOTZJUG1lS1hGNHNkYUVBYmhCcDV4Z2JKaFQ0ZDBveTF0aUJ3UFZZ?=
 =?utf-8?B?R2xkbVEvUlBoVDJmTG1WYzFBRVBpSGJBcnJTd1YyNit3U1N3TjFTbmJjV0JG?=
 =?utf-8?B?T1JGZ3E1bEwxdHlsclNKbjBqaDFZWFFkRDJ6OTNEeVlSYytUR3FIb0pOUjVo?=
 =?utf-8?B?akRFU3A2bzhVTm9CckU0UEtiaEZDZHovUUEvS21mbklHNVdYV3J1QkswMUU4?=
 =?utf-8?B?dG9EbXh6TXorMEpHb2UwTm4vaGtZNTRPdnZ5dWF3QUZmV3Q0ZHJwRmRiU3hh?=
 =?utf-8?B?UGdLemR5bVp3cWZsOHNnWEN6eitkMll3RTRqajdJY0JmeURrVFZWK0VrSXhO?=
 =?utf-8?Q?T7TSdCacYTw73oMw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA4PR10MB8301FE3A10AA391212B387EE903D2IA4PR10MB8301namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G++FyU1TW/Avtu/1xdC68wvK4poukguklml6Pm0rUhGuEJsekVk777TkyEEt/ycHo+im1etIklmak6vI9K5QHUndr7uTywA6bRx2El25VxCHF3BIFSoBfo0UoshE0dY7mGTQzqLCZu5v7j/TMDDC3X7pcrDXuxJ7bsda2rqznxgAzALPiwen+sKJe2ais8sx5781huhR/xSoSAcpZOxIair3K2W/UU1PsdH2N3cyJ+taBMJdoMrfgjOvOSEXmDNA67HG7G1AQ1yJVLGz5O1fs6lkkbuoYLwQ7h/dEyLwSPefq11RthueWGczly3xiMhO5tmKkAzdRwVRPS0AUymIBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wa/iBjphgXxUjwoLHOi5wtArt5YbTeMIhCKVjISqNwtisNdVgXrROxtWh6RvIQf6RgxIf71XEHXCCFaai702L2Mg7E/SOt6GdwVLh7KUNd2wYyF4auE1E/imx+EHXG2cqCeOusMs6/VBNXSIaLPw2NMxkHzTTC/CPTc7hiREqA04SYcZAZ5f6rEWA2yvx63a7SnH3K0FTN04hM3M3FykFJDjSNyEf+MAqa7ZgpdXKGwfG62k7Kj8UrfMQGhlrE/pY0ibptasfPOhwaVdcpUVqzLUsihGMRAHbimLOHNDjHuxM7iFpjh35jFSDcHuTrmPFuhJ+c5mvtMJUGu5jCIxanvvjiQvU4dVdABILpUEN3M6TCKGnzbkisNmp2jN58AZiZEOjdEG1dDMVKWnu8dL+/XY1G8yYqymsZPUp+j5Zb6SZluGVsGcLI20HVZklNxoiQ5cJKZIPNOlzIKp0Hd+wgjQxyHD/umFveSsEAkPjhrCYkAAmBk90DBGginsvIjA+6+3bWXL4infSyZbLF5FvPfS+h+BCjy84o3HmUz9JDwb8pKGbT2vE3fXhB2n4JfESYHimHqima/X1uRqOXvsSZjIq/i8CIKU1n19dN5LGvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16a93b4-6577-4099-e26a-08dead0d1dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 14:21:37.8243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdXamqMX6MBhsxUicwIwTo+yoe91Kq6ScIa8ZSPcHP3GsAr165ggGhnE7ZkZFAbVMlBNOduxwGvENYs9iUcWag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605080143
X-Proofpoint-GUID: EVkA5g-gkErg8-fL6LHk0QWMbDziuxzx
X-Proofpoint-ORIG-GUID: EVkA5g-gkErg8-fL6LHk0QWMbDziuxzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0OCBTYWx0ZWRfX0b8tYgTxKpyT
 VvzIM/WnOe6qoIhpg4gD2ZIddtz6poMkmlGPjpm3uwB95vMlcUkQOBm7XUiPT6ZTbqcv66RYNZl
 eK4lll9gWfRdEmontRonLCCWVhLZrZQsvmycIErciwX3WlZcMAMipoiTzmINFfYeJ/C8lIDzRyt
 OkcnlVDKxVTqNKQ8xU923onD+1CvROT90xcO2u7GA0enRn88Gn1VlP6Y+KlEMBvGomFp2iOUK4Y
 uzA8wM5Fo5S3e3jvtBQpO/a52h2n04iPM4BevwQQlaxw59/glLA7ECpGYYjw+qnL6+J3vqXA5Nb
 EQC4EcfmnGMD2TykTP37o9fD1NMEUXKhtOs0D10M7l1Eu1t1NTV3S10Y5MyI9UswIiXE/vMbnMZ
 5n92xxBBfXzGEvysj+tsFpN7Kj/COPpHMNo00yqJZI++jeyGmT74NovW1qwb3OHy5deW6TIFNGE
 XovSl2EyKxPNk0I5Mzw==
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=69fdf179 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Bk_zsZLjAmpNi6qa2wMA:9 a=QEXdDO2ut3YA:10 a=fZJDEAiFCdA8lYAP:21
 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_IA4PR10MB8301FE3A10AA391212B387EE903D2IA4PR10MB8301namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCg0KDQoNCg0KQ29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1
ZGluZyBFeHRlcm5hbCBSZWNpcGllbnRzDQoNCkZyb206IEpvaG4gTGV2b24gPGpvaG4ubGV2b25A
bnV0YW5peC5jb20+DQpEYXRlOiBGcmlkYXksIE1heSA4LCAyMDI2IGF0IDY6MjfigK9BTQ0KVG86
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KQ2M6IEVsZW5h
IFVmaW10c2V2YSA8ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20+OyBKYWcgUmFtYW4gPGphZy5y
YW1hbkBvcmFjbGUuY29tPjsgY2xnQHJlZGhhdC5jb20gPGNsZ0ByZWRoYXQuY29tPjsgSm9obiBM
ZXZvbiA8am9obi5sZXZvbkBudXRhbml4LmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gTWFyayBNdWx0
aS1Qcm9jZXNzIFFFTVUgYXMgT3JwaGFuZWQNCg0KVGhpcyBzdWJzeXN0ZW0gaXMgbm8gbG9uZ2Vy
IHNlZWluZyBhbnkgZGV2ZWxvcG1lbnQsIGFuZCB0aGUgcHJpbWFyeQ0KY29udGFjdCBsaXN0ZWQg
YXMgbWFpbnRhaW5lciBoYXMgY29uZmlybWVkIHRoZXkncmUgZHJvcHBpbmcgc3VwcG9ydCBvZg0K
aXQgYWx0b2dldGhlci4NCg0KU2lnbmVkLW9mZi1ieTogSm9obiBMZXZvbiA8am9obi5sZXZvbkBu
dXRhbml4LmNvbT4NCi0tLQ0KIE1BSU5UQUlORVJTIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUw0KaW5kZXggMGE5MDIwNGFlOS4uY2UyYjQ5NDA4NiAxMDA2NDQNCi0tLSBh
L01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVSUw0KQEAgLTQ0MjksNyArNDQyOSw3IEBAIEY6
IHRlc3RzL3RjZy9hYXJjaDY0L3N5c3RlbS9zZW1paGVhcC5jDQogTXVsdGktcHJvY2VzcyBRRU1V
DQogTTogRWxlbmEgVWZpbXRzZXZhIDxlbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbT4NCiBNOiBK
YWdhbm5hdGhhbiBSYW1hbiA8amFnLnJhbWFuQG9yYWNsZS5jb20+DQotUzogTWFpbnRhaW5lZA0K
K1M6IE9ycGhhbg0KIEY6IGRvY3MvZGV2ZWwvbXVsdGktcHJvY2Vzcy5yc3QNCiBGOiBkb2NzL3N5
c3RlbS9tdWx0aS1wcm9jZXNzLnJzdA0KIEY6IGh3L3BjaS1ob3N0L3JlbW90ZS5jDQoNClRoYW5r
cyBmb3IgdGhlIHJlbWluZGVyLCBKb2huISBJ4oCZbGwgc2VuZCBhIFBSIHNob3J0bHkgcmVtb3Zp
bmcgcGFydHMgd2UgYXJlIG5vdCBsb25nZXIgdXNpbmcuDQoNCkkgZ290IGRpc3RyYWN0ZWQgZnJv
bSB0aGlzIHRhc2sgZ2l2ZW4gc29tZSByZW9yZ2FuaXphdGlvbiBhdCBteSBlbXBsb3llci4gSeKA
mWxsIHNlbmQgdGhlIHBhdGNoIG91dCBieSB0b21vcnJvdy4NCg0KVGhhbmsgeW91LA0KSmFnDQoN
Ci0tDQoyLjQzLjANCg0K

--_000_IA4PR10MB8301FE3A10AA391212B387EE903D2IA4PR10MB8301namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPHAgc3R5bGU9ImZv
bnQtZmFtaWx5OkNhbGlicmk7Zm9udC1zaXplOjEwcHQ7Y29sb3I6IzAwMDAwMDttYXJnaW46NXB0
O2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDt0ZXh0LWRlY29yYXRpb246bm9u
ZTsiIGFsaWduPSJMZWZ0Ij4NCkNvbmZpZGVudGlhbCAtIE9yYWNsZSBSZXN0cmljdGVkIFxJbmNs
dWRpbmcgRXh0ZXJuYWwgUmVjaXBpZW50czxicj4NCjwvcD4NCjxicj4NCjxkaXYgc3R5bGU9ImRp
cmVjdGlvbjogbHRyOyBmb250LWZhbWlseTogQXB0b3MsIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMt
c2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9k
aXY+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsgZm9udC1mYW1pbHk6IEFwdG9zLCBBcmlh
bCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwg
MCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0ibWFpbC1lZGl0b3ItcmVmZXJlbmNlLW1l
c3NhZ2UtY29udGFpbmVyIj4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxlLXJlZmVyZW5j
ZS1tZXNzYWdlIHNraXBQcm9vZmluZyI+DQo8bWV0YSBuYW1lPSJHZW5lcmF0b3IiIGNvbnRlbnQ9
Ik1pY3Jvc29mdCBFeGNoYW5nZSBTZXJ2ZXIiPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJwYWRkaW5n
OiAzcHQgMGluIDBpbjsgYm9yZGVyLXdpZHRoOiAxcHQgbWVkaXVtIG1lZGl1bTsgYm9yZGVyLXN0
eWxlOiBzb2xpZCBub25lIG5vbmU7IGJvcmRlci1jb2xvcjogcmdiKDE4MSwgMTk2LCAyMjMpIGN1
cnJlbnRjb2xvciBjdXJyZW50Y29sb3I7Ij4NCjxkaXYgY2xhc3M9Im1zLW91dGxvb2stbW9iaWxl
LXJlZmVyZW5jZS1tZXNzYWdlIHNraXBQcm9vZmluZyIgc3R5bGU9InRleHQtYWxpZ246IGxlZnQ7
IGZvbnQtZmFtaWx5OiBBcHRvczsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogYmxhY2s7Ij4NCjxi
Pjxicj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpO2ZvbnQtc2l6ZToxMHB0O2NvbG9y
OiMwMDAwMDA7bWFyZ2luOjVwdDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
dGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBhbGlnbj0iTGVmdCI+DQpDb25maWRlbnRpYWwgLSBPcmFj
bGUgUmVzdHJpY3RlZCBcSW5jbHVkaW5nIEV4dGVybmFsIFJlY2lwaWVudHM8YnI+DQo8L3A+DQpG
cm9tOiA8L2I+Sm9obiBMZXZvbiAmbHQ7am9obi5sZXZvbkBudXRhbml4LmNvbSZndDs8YnI+DQo8
Yj5EYXRlOiA8L2I+RnJpZGF5LCBNYXkgOCwgMjAyNiBhdCA2OjI34oCvQU08YnI+DQo8Yj5Ubzog
PC9iPnFlbXUtZGV2ZWxAbm9uZ251Lm9yZyAmbHQ7cWVtdS1kZXZlbEBub25nbnUub3JnJmd0Ozxi
cj4NCjxiPkNjOiA8L2I+RWxlbmEgVWZpbXRzZXZhICZsdDtlbGVuYS51ZmltdHNldmFAb3JhY2xl
LmNvbSZndDs7IEphZyBSYW1hbiAmbHQ7amFnLnJhbWFuQG9yYWNsZS5jb20mZ3Q7OyBjbGdAcmVk
aGF0LmNvbSAmbHQ7Y2xnQHJlZGhhdC5jb20mZ3Q7OyBKb2huIExldm9uICZsdDtqb2huLmxldm9u
QG51dGFuaXguY29tJmd0Ozxicj4NCjxiPlN1YmplY3Q6IDwvYj5bUEFUQ0hdIE1hcmsgTXVsdGkt
UHJvY2VzcyBRRU1VIGFzIE9ycGhhbmVkPGJyPg0KPGJyPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXYg
Y2xhc3M9IlBsYWluVGV4dCIgc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsiPlRoaXMgc3Vic3lzdGVt
IGlzIG5vIGxvbmdlciBzZWVpbmcgYW55IGRldmVsb3BtZW50LCBhbmQgdGhlIHByaW1hcnk8YnI+
DQpjb250YWN0IGxpc3RlZCBhcyBtYWludGFpbmVyIGhhcyBjb25maXJtZWQgdGhleSdyZSBkcm9w
cGluZyBzdXBwb3J0IG9mPGJyPg0KaXQgYWx0b2dldGhlci48YnI+DQo8YnI+DQpTaWduZWQtb2Zm
LWJ5OiBKb2huIExldm9uICZsdDtqb2huLmxldm9uQG51dGFuaXguY29tJmd0Ozxicj4NCi0tLTxi
cj4NCiZuYnNwO01BSU5UQUlORVJTIHwgMiArLTxicj4NCiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9NQUlO
VEFJTkVSUyBiL01BSU5UQUlORVJTPGJyPg0KaW5kZXggMGE5MDIwNGFlOS4uY2UyYjQ5NDA4NiAx
MDA2NDQ8YnI+DQotLS0gYS9NQUlOVEFJTkVSUzxicj4NCisrKyBiL01BSU5UQUlORVJTPGJyPg0K
QEAgLTQ0MjksNyArNDQyOSw3IEBAIEY6IHRlc3RzL3RjZy9hYXJjaDY0L3N5c3RlbS9zZW1paGVh
cC5jPGJyPg0KJm5ic3A7TXVsdGktcHJvY2VzcyBRRU1VPGJyPg0KJm5ic3A7TTogRWxlbmEgVWZp
bXRzZXZhICZsdDtlbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbSZndDs8YnI+DQombmJzcDtNOiBK
YWdhbm5hdGhhbiBSYW1hbiAmbHQ7amFnLnJhbWFuQG9yYWNsZS5jb20mZ3Q7PGJyPg0KLVM6IE1h
aW50YWluZWQ8YnI+DQorUzogT3JwaGFuPGJyPg0KJm5ic3A7RjogZG9jcy9kZXZlbC9tdWx0aS1w
cm9jZXNzLnJzdDxicj4NCiZuYnNwO0Y6IGRvY3Mvc3lzdGVtL211bHRpLXByb2Nlc3MucnN0PGJy
Pg0KJm5ic3A7RjogaHcvcGNpLWhvc3QvcmVtb3RlLmM8L2Rpdj4NCjxkaXYgY2xhc3M9IlBsYWlu
VGV4dCIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBmb250LXNpemU6IDExcHQ7Ij48YnI+DQo8L2Rp
dj4NCjxkaXYgY2xhc3M9IlBsYWluVGV4dCIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBmb250LXNp
emU6IDExcHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NClRoYW5rcyBmb3IgdGhlIHJlbWluZGVy
LCBKb2huISBJ4oCZbGwgc2VuZCBhIFBSIHNob3J0bHkgcmVtb3ZpbmcgcGFydHMgd2UgYXJlIG5v
dCBsb25nZXIgdXNpbmcuPC9kaXY+DQo8ZGl2IGNsYXNzPSJQbGFpblRleHQiIHN0eWxlPSJkaXJl
Y3Rpb246IGx0cjsgZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+
DQo8L2Rpdj4NCjxkaXYgY2xhc3M9IlBsYWluVGV4dCIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBm
b250LXNpemU6IDExcHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCkkgZ290IGRpc3RyYWN0ZWQg
ZnJvbSB0aGlzIHRhc2sgZ2l2ZW4gc29tZSByZW9yZ2FuaXphdGlvbiBhdCBteSBlbXBsb3llci4g
SeKAmWxsIHNlbmQgdGhlIHBhdGNoIG91dCBieSB0b21vcnJvdy48L2Rpdj4NCjxkaXYgY2xhc3M9
IlBsYWluVGV4dCIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBmb250LXNpemU6IDExcHQ7IGNvbG9y
OiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBz
dHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiPg0KVGhhbmsgeW91LDwvZGl2Pg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0IiBzdHlsZT0iZGly
ZWN0aW9uOiBsdHI7IGZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KSmFn
PC9kaXY+DQo8ZGl2IGNsYXNzPSJQbGFpblRleHQiIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij48
YnI+DQotLTxicj4NCjIuNDMuMDxicj4NCjxicj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8
L2h0bWw+DQo=

--_000_IA4PR10MB8301FE3A10AA391212B387EE903D2IA4PR10MB8301namp_--

