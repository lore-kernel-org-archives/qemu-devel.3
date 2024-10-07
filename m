Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C6CFB458
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtS0-00030B-QQ; Mon, 07 Oct 2024 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtRs-0002zO-Bx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtRn-0006HD-Uh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMe5A016440;
 Mon, 7 Oct 2024 19:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=9iDHrmUVj9kWxgu2ByGItmKMe6pRh9g5pKLunX8K9qQ=; b=
 JBrtyARHGvG5l+kl0ImG3mCXkuCvEP2gkZMsX/6G/tnZpXposWDtdb5zh/Tcb2nP
 vOzigNEYEN23OpYOz7ndx88UAfy3xrgUBo57uijyML8T+zcGVGmK1TXvDiq7z99d
 VQRYxMER11TbDErgePT0hgCX1Rw876URaeiM7oQPUeQwlJqfI0eZxzrtL21VgPTI
 L8m39IYIg6Fe202YNKhICofXdQRAbJfJwsQ8OD3f5YGLfg5UfbLG0I+ongRm38+f
 cNBdwt+0wuUukjstd1MkmceZIRp5ziqUcCCVhs4YdRGvTOx8ZT58nbN9wBa4Jz/k
 Cn50pLDV50rypTIcgKNZSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dm6vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497IjxNL023929; Mon, 7 Oct 2024 19:31:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwcgm36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evX+4Wa1FZusWFMT7lHGvTsnnNm2ye5jp6GkWBRIZBwBI8v+L0I9uL+iirysqo3c7UW+JKTq4Uk6ppyOCzcjeaaPH1AMyTCAeTI4ETfBrEzLT5jDWvfMmFJj0MSUxFTRD2J3/BpsM171i7ZkOEjNioyPQgnKZ+5fuzgUeSetiV01rzExWxNACT/cTPVWpjy6I92g4mrEe0Is2bUHv70fRpWJ2PJo1gu9+mtVX0FxgXzKSKUo3Se28kPgLWQSQ1IZdvX0PmWjrDEbmZ67HRQyzdairF9P683ZZWI+oixi0PyW4o4Pmm8HZTvzFe1VD/6GhnYqgL+A9ovvJcgDvD70IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iDHrmUVj9kWxgu2ByGItmKMe6pRh9g5pKLunX8K9qQ=;
 b=XygQ3vo5nZ2YSkns3MM4RtOb2y7cMuWXZMht3WWTuoCkLrofgR3XiyAWGr7rK1GI3+ZJbq3oi5VPxWxjaBLU9SXlRucrUYNHqCI1VtpXhxhsNtyaoKUplj9SaG2r262QtKT8m6IY8lCWCJkF3hK21LQTLcrSn4tlO+xoNGcN5dI8OPJgz92RhlzYRiyKIsoV3HtByb5QFqVUxws9MIlH0qXCVdR1h0MyZnNZW0ZNcPc8OQ5jZX275DYec8Q4rJI8nr0i7Qjzql/DH/X+ja6pr2xvMWE9ZHcX2MVhceKjjclh3FxJBL1fGoj3JhT62wt6lWcrnU552/+F3CgNQNtpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iDHrmUVj9kWxgu2ByGItmKMe6pRh9g5pKLunX8K9qQ=;
 b=PvN6kenlifXkO1bpDZ7ReBnX8IOrs7xw04sph/Xf++phMPk0E23Otppp9RTE+ee3pC1WzkKCL/9I1ppYEE7J1BEyYEDJ3qCTYyd0QWkGAHU78N76WJdTSUvLbYvvYoH9/CwBBMXvYLDeH1JZynRShZdHMgGqqMR0fb3b4vGm1s0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:31:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:31:00 +0000
Message-ID: <7af9b8e7-1cc6-4ec0-b957-2116b43e1257@oracle.com>
Date: Mon, 7 Oct 2024 15:30:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/13] migration: cpr-state
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-3-git-send-email-steven.sistare@oracle.com>
 <ZwPsyRQVfmeNCt2z@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwPsyRQVfmeNCt2z@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7216ec23-6f1f-4174-0c64-08dce706933f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW1RN1g1SDVaS2VMazZaRDRjeGR1U1RSdjMvY1JScFE5RFFGMUx3RHBzbkdR?=
 =?utf-8?B?QU1qdE1uVnJ3aEx6WFpQeFRVczRqK0VmZGkyUUEvS1pWdmdzQnQ5Wnh0OEls?=
 =?utf-8?B?ZUtVN1NaSWdMMGVIbk01L3V4ODVscVAvYXQwNVcvNlVXZnBJK1J6dTRTbFJW?=
 =?utf-8?B?Y3U4RnJyTnowQzk3SDlWbHYvVDNoRk1sZmYwM3A2TDMwNzhsUCtLYjJWcE9j?=
 =?utf-8?B?U2pyMDZ5K0wrR2pqWE0vVDl1Z0NHaVFMd2NUOGRLMkpMZmlycXF4TTAwTmZt?=
 =?utf-8?B?UEFCbCtNbXJlZXo2bWhQU0JqNDV2QllwOGN5RnBUd2xGeER2Vi9XQnNaMUdq?=
 =?utf-8?B?T1JxRHhWVDIwWGV6bTQrcDlZeDhWcHFmdVNEMkdsQjhrcThuSXBSa0paY1Z6?=
 =?utf-8?B?ek41bEJnQ016YnVvdnlLOXdPVXFQcWVFTzdYOEZyMDI5RnQwZmx0RzBSSlN2?=
 =?utf-8?B?K2FSWExFZVZCK2lJS294d2dQbk0xcWcxaHBPd1EycFhQdUhFdjJENjY2T0w1?=
 =?utf-8?B?MitnZG00MWVVYk9SUHduRmM2ckhWaHAxY3Axc2l6NStaSm9mc0NGSGtqUWZj?=
 =?utf-8?B?Uk9Wa2taajJaMWNyemJzc2g4K1BXbmxnVEN2WnEvRzFnQzVSU0YwU1l3akR0?=
 =?utf-8?B?OEllWkRRV3FpeHFWenVkMjFURFRNdUtNUW5FV04rMlFHMld0K3V2bTV6dFJI?=
 =?utf-8?B?cUNpcU1nNU1ReXM5U0N5L3ltWHc5UmorYVBYVTdXdWRVcmZNUE9YVUxYbFJL?=
 =?utf-8?B?cmY2YzhuVnhiNG9QSlpqN0Ivb1hVaElKWWZmc3lDNVYxekgwQjgrTE5VUzdI?=
 =?utf-8?B?ZjFzSE93Z3RJM1Z3V2xVQThra3hyWVBEem1Ua215YjU5UUpuSFRGdGlNQ1Bz?=
 =?utf-8?B?elkwaUh4cW1waTNLOS9tSWszK082c2R1R0hVVG1VbjdrU1M4R2sxT2VXM2po?=
 =?utf-8?B?eFFvMnVwaHlidUFuTUdHcVVjRXphWDdPdTVoNGVxN2VoMDN3eWhsRGE0WXY1?=
 =?utf-8?B?UW9hbHBUdkhlU2luTnZSZVBlOG5MMWlvSEl3TXQrSzllcmYrVCtJcnFuL3R1?=
 =?utf-8?B?WkQ2TnpQSll1dkN6L3NhUVd2RkI5eUhQQ1A3MWxlOFg0QlpIYXZBUUo1NU0y?=
 =?utf-8?B?M1hZQXpYRzNEMjRieWhEZUNIbzdjODNCaU56czJxbWhJN3lKNFYyOHFJbVpw?=
 =?utf-8?B?WUxPQkdtMTBwWHl6aE5oalVjTTIxYVlHUU5vSGkreXVrRmpmSzJ1SS9LbUly?=
 =?utf-8?B?bGFLTWdOOFBHZWZLQXFOT05DNFlRak81clRyZ1BzS0dFV2RwVG4yaUFyeHAr?=
 =?utf-8?B?VSs4ZXJoV2N3anp2UnMydktNYTVzRU8zMU9ibHN2MXUvUm9XNjNxMUdodkU0?=
 =?utf-8?B?emZaUFJtUnA4TExQRW5oUnJUZmtEQ05WZUxKVVlGMi83TE5wZndBRXpVekYz?=
 =?utf-8?B?endLUmJKQ0o1N3A3TEpGeWpBcVdMK1RJMGkvRGtUZjlXQ1RXb2s5YXo3QWNH?=
 =?utf-8?B?c0tGSG16RWlIZnQ5WlpTTGpVLzhQR1huZXRid1FicnV5aEFVQ2g5cE9jbWxS?=
 =?utf-8?B?aEgwSWZQeGFRNk5mTlRpYnVrSlFTWlZIWFIvYXdacjZ6dGl2OUw4ZTRYUHh2?=
 =?utf-8?B?QUNwTmVwbk1FYnJZTkJEc0NNTjNNMlVMM2Q0WDNocml4TUpMNC9aNmtlYVgx?=
 =?utf-8?B?WUtsbmx6K2xPVWhRb0JNWi9Fc2FxbjIzU0cwQ2FnVHhVelA3cVU0c29nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRZOC9zUDIzYm1jZHphUThiczVWYlg2dHdsM0RWcTR4SVhqZ0ZIYit0SnR2?=
 =?utf-8?B?dlhCdi9HQjMwd2tBV0ZLK0c5cmpjVlAwWnkxa3VnTmFYQUplQW5jRTNBRWgx?=
 =?utf-8?B?aVpOZ1NGZUx1MlNibnVmVnJIZzc3a05ldExCazgyNjhmNjVmY3U0bGRnV1F2?=
 =?utf-8?B?a1d2bmhDNVRSd3hOSW1Vc0ZtSld6QjVLSmwybW9KaTFVTExhNGJ0NnVNV3F4?=
 =?utf-8?B?UytVOTJxWGhSaFpsVWFTT1c2TW9nbVJpREZ3ckVJMmxmRXJwUzRsU2lEWU4z?=
 =?utf-8?B?RVRZVHZKTnNuTGQwNWVxd2pWZmgva2VDWkREMHV0M0UzQlVuZGZVNEJvWlpE?=
 =?utf-8?B?bmVndnpERGxOVmd2OXp6VmdDL09nVFVxYXRaYkI0c3NhandtK211SWtOS00w?=
 =?utf-8?B?ZnFTL3hUaFJwd0Fock5nQmphTW9GNUo1YkZ2UGlSUDZMUFBUbWdhZDdSUWoz?=
 =?utf-8?B?NG1tMitONUdrQ1JmbEQvaFNGNW1STjFMTG9XK3UzN1BQNVlLMEJtaWpKcENG?=
 =?utf-8?B?WlJzUXBSUmRFcFFXSm1qWkJDTVNUSHRDRlYzaUlFdmh2YVlWcHc2OGI2VUNu?=
 =?utf-8?B?b2VlSis1TXZ2aHp2Slk4MTBHNVhhdDV2SENwNWNpMjB1N0dlbDdOeDdkb1l0?=
 =?utf-8?B?TUFuMTIwRkVuV0tNRjRKS2FUOTVYTC9rMlgzM3c0enpTVWJzbXJmUkJhNzV2?=
 =?utf-8?B?dm1mQ0RzbXZQRWZDbm9kN3BVMnlKbERwcHVqNkVDZTZCS2V5c1FlNnI4ME1o?=
 =?utf-8?B?dWVEMElITXZDQ3NtZ053SzNHNVdVOHdWVVB6VzExdnBLTUJiRkZHUVFoemN3?=
 =?utf-8?B?TmdLQTlQL3BLZmthSWpzY2ZXb085WXArNXh6QlA0aGZhVFEveFZLVm11a2dU?=
 =?utf-8?B?NlRpdmV3STRJUlRLU0JpT3Rsd2xMdmRGeGhtSG1IN2lBakZtTHA5Nlhpd3ZG?=
 =?utf-8?B?bk5DUUE4N0xhR1N5WTFId2k0WDAxcC9IQ0I2RW41bFJxSEFFYmVqd3VHVTZj?=
 =?utf-8?B?ODVPdHloRnYvQmxHdGRuZ0d2QjBUVnI4SU1lRjhycW5xSHhLaTQ2UVRGbmp1?=
 =?utf-8?B?RUNSakFPRmVoa0F2ZndGeGJ0a20rYzdTV2g0WWRhRDYxRldTalVIUENoQkUv?=
 =?utf-8?B?aC80bnNkT2ZlYVd4OWFSSEZiT2lTVHVPZHhaamg4cTVGWUxNdDZhUU1JbjZu?=
 =?utf-8?B?RENZMy84a1Q2ZjNvNTc1Q1ViUXdjSm5oRmJaM2laNlFCR05ycE9lUjJpUGdo?=
 =?utf-8?B?STJiMFRpYnRTQzJmREFYRm1pdGRCZktpNVZZdmx1SHBRT0h3Qi94WlluSGJI?=
 =?utf-8?B?djJkeGhOUWd6NlJSNmM4dkxXSnBKcnI2NGtsUnJmOE1UTnZvWlFGQ2lSVURz?=
 =?utf-8?B?eFYrTnRwSUMzUHJjT083YXc3QnRGR3h2bEZHZ1YzU1JVTXdLSURvbDRHVkZu?=
 =?utf-8?B?MXdtY3B6a3Q2clJGMmk2YUhRRGZRenM3ckZCRjRZTUZCNU1hT1BPdHRMOWY2?=
 =?utf-8?B?dVczUFR6L0gweUVtRTRsNUM3ZFlqS2JkalhuRktjUlYvN0FCNzNISk0rR01W?=
 =?utf-8?B?ZGdmL3p6RDBjNEFmcFRZVE5VV1A2eklRcFJIdVQ1akx1WXFvbEJHR1Vkelh6?=
 =?utf-8?B?dlBrN1VFUUxnT1J4UnBVR2JmM1lJc0s1S3AxN2dZbFp4ZDQ2SktZUXJqd2lC?=
 =?utf-8?B?bC9KNHM2TTE1c0dVYy9kOXp3MGhrb3BENTVhQUZSU0hOcHFHQTlEWEE1aUJ1?=
 =?utf-8?B?ajJOMFo3Rnd2VHNvUjI5aTZDWVAyeXNXa012c0RNVEMreU5EMEh3d2FLaXc2?=
 =?utf-8?B?Z1VOUGdGNWgrOSt4dGU0M2htOExDcEtkcXdVU3RDajJrZ3ZpUitIdW9TY0V6?=
 =?utf-8?B?ZDBJN2paRi8ycTNEZ1ZwTlhSRExMOWlzbHF2emgyTHJ0RWlzNHFYM1BlZldj?=
 =?utf-8?B?K3owUjl4bkdUaVQ1SHlOc1l3a3F4MWtQdE5NN09kWEtaS0wrNnNSNnMrOEtn?=
 =?utf-8?B?Yk5scWpLM0pQY2w1bWwvanBYQytCWklsU0k4SURUTlpWRTRyZVRzWFNUKzg1?=
 =?utf-8?B?L00yeWgvc0ZuRTNzcFR6UUpqVDFybytieUdDU3JnNmY2UEhNU291QzJBbmNs?=
 =?utf-8?B?YUI5ZkVyTXZzYkpjemMybTRiZXFRQkR1a01KYjgzOEE1T2c1T0JvdEM4MTBL?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kn4DeZQKWnsQaj9+C0CAkvW06nuLlmgYtFOex7LT9dMgsZhIdCjcJW8miEqidjHmlbdGktEkviJpzB7mr4PCvj9bPep/WSxaiJFbF/3p5qL46Gz5IbQ5paHBdwIb5zFCR2hd89RTt58qAMVam6DF6EVVSW09hGkPJiuM03KAm8gRcyV7tdhEV55TCm7M7PyPf00hZyQZsIrfjfTDMAGscqhimzVss60j0//7uy4qjgjj6La5aJ/MDuPWOUzuXNsqFj4WKK7LYD1aaffuMJh7XxL+e/V7lkfypQxApdgXx9mGuErYD5RgRGcQHTXu5qDZpShdwnaFKMIof78ML35m2LJPmvayr0oPdQQnkS58YNkgEkD5HdqAIMRf1dzk9ic76qClb7914sWE/rNqkwzbaOTAIRZWyTJrF5NAyNZWSnJuTBQLX0LpUti/juYebZZZkvZ1vsWnZZzkJ65cl+cibPa9rn9SkeyuTzeJ+actXSUpeMLExc8DvAJ1G1mxofbI8x5LOdceFRHmq2A6pMTPGvohZLV0sj0IH4/UMa6g3V4hdIw0lSpFCKO88VooCEwmlbKeZnMhySyycBbLPy2AlJRkwuwuqAQZfvukFMcTCPc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7216ec23-6f1f-4174-0c64-08dce706933f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:31:00.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOedB0T/OE/07/PaPrl0JQZJLNH61CBAGgKKXcyeKh9MEo9eE49g9z4zliOeyewlGSAX//vUecDFJWaMFeGUlansawgXwO7Oh0Ioqefzvag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070134
X-Proofpoint-ORIG-GUID: wDLdfhHvKG2O33NZQM0DQ72yrQB09j1Y
X-Proofpoint-GUID: wDLdfhHvKG2O33NZQM0DQ72yrQB09j1Y
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/7/2024 10:14 AM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:33PM -0700, Steve Sistare wrote:
>> CPR must save state that is needed after QEMU is restarted, when devices
>> are realized.  Thus the extra state cannot be saved in the migration stream,
>> as objects must already exist before that stream can be loaded.  Instead,
>> define auxilliary state structures and vmstate descriptions, not associated
>> with any registered object, and serialize the aux state to a cpr-specific
>> stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
>> restarts, before devices are realized.
>>
>> Provide accessors for clients to register file descriptors for saving.
>> The mechanism for passing the fd's to the new process will be specific
>> to each migration mode, and added in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Only two trivial comments below.
> 
>> ---
>>   include/migration/cpr.h |  26 ++++++
>>   migration/cpr.c         | 217 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/meson.build   |   1 +
>>   migration/migration.c   |   6 ++
>>   migration/trace-events  |   5 ++
>>   system/vl.c             |   7 ++
>>   6 files changed, 262 insertions(+)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr.c
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> new file mode 100644
>> index 0000000..e7b898b
>> --- /dev/null
>> +++ b/include/migration/cpr.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Copyright (c) 2021, 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef MIGRATION_CPR_H
>> +#define MIGRATION_CPR_H
>> +
>> +#define QEMU_CPR_FILE_MAGIC     0x51435052
>> +#define QEMU_CPR_FILE_VERSION   0x00000001
>> +
>> +typedef int (*cpr_walk_fd_cb)(int fd);
>> +void cpr_save_fd(const char *name, int id, int fd);
>> +void cpr_delete_fd(const char *name, int id);
>> +int cpr_find_fd(const char *name, int id);
>> +int cpr_walk_fd(cpr_walk_fd_cb cb);
>> +void cpr_resave_fd(const char *name, int id, int fd);
>> +
>> +int cpr_state_save(Error **errp);
>> +int cpr_state_load(Error **errp);
>> +void cpr_state_close(void);
>> +struct QIOChannel *cpr_state_ioc(void);
>> +
>> +#endif
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> new file mode 100644
>> index 0000000..e50fc75
>> --- /dev/null
>> +++ b/migration/cpr.c
>> @@ -0,0 +1,217 @@
>> +/*
>> + * Copyright (c) 2021-2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "migration/cpr.h"
>> +#include "migration/misc.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/savevm.h"
>> +#include "migration/vmstate.h"
>> +#include "sysemu/runstate.h"
>> +#include "trace.h"
>> +
>> +/*************************************************************************/
>> +/* cpr state container for all information to be saved. */
>> +
>> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>> +
>> +typedef struct CprState {
>> +    CprFdList fds;
>> +} CprState;
>> +
>> +static CprState cpr_state;
>> +
>> +/****************************************************************************/
>> +
>> +typedef struct CprFd {
>> +    char *name;
>> +    unsigned int namelen;
>> +    int id;
>> +    int fd;
>> +    QLIST_ENTRY(CprFd) next;
>> +} CprFd;
>> +
>> +static const VMStateDescription vmstate_cpr_fd = {
>> +    .name = "cpr fd",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(namelen, CprFd),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>> +        VMSTATE_INT32(id, CprFd),
>> +        VMSTATE_INT32(fd, CprFd),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +void cpr_save_fd(const char *name, int id, int fd)
>> +{
>> +    CprFd *elem = g_new0(CprFd, 1);
>> +
>> +    trace_cpr_save_fd(name, id, fd);
>> +    elem->name = g_strdup(name);
>> +    elem->namelen = strlen(name) + 1;
>> +    elem->id = id;
>> +    elem->fd = fd;
>> +    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
>> +}
>> +
>> +static CprFd *find_fd(CprFdList *head, const char *name, int id)
>> +{
>> +    CprFd *elem;
>> +
>> +    QLIST_FOREACH(elem, head, next) {
>> +        if (!strcmp(elem->name, name) && elem->id == id) {
>> +            return elem;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +void cpr_delete_fd(const char *name, int id)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +
>> +    if (elem) {
>> +        QLIST_REMOVE(elem, next);
>> +        g_free(elem->name);
>> +        g_free(elem);
>> +    }
>> +
>> +    trace_cpr_delete_fd(name, id);
>> +}
>> +
>> +int cpr_find_fd(const char *name, int id)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +    int fd = elem ? elem->fd : -1;
>> +
>> +    trace_cpr_find_fd(name, id, fd);
>> +    return fd;
>> +}
>> +
>> +int cpr_walk_fd(cpr_walk_fd_cb cb)
>> +{
>> +    CprFd *elem;
>> +
>> +    QLIST_FOREACH(elem, &cpr_state.fds, next) {
>> +        if (elem->fd >= 0 && cb(elem->fd)) {
>> +            return 1;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_resave_fd(const char *name, int id, int fd)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +    int old_fd = elem ? elem->fd : -1;
>> +
>> +    if (old_fd < 0) {
>> +        cpr_save_fd(name, id, fd);
>> +    } else if (old_fd != fd) {
>> +        error_setg(&error_fatal,
>> +                   "internal error: cpr fd '%s' id %d value %d "
>> +                   "already saved with a different value %d",
>> +                   name, id, fd, old_fd);
>> +    }
>> +}
> 
> I remember I commented this, maybe not.. cpr_walk_fd() and cpr_resave_fd()
> are not used in this series.  Suggest introduce them only when they're
> used.

Thanks, you probably did.  I just edited my tree, so I will not forget again.

>> +/*************************************************************************/
>> +#define CPR_STATE "CprState"
>> +
>> +static const VMStateDescription vmstate_cpr_state = {
>> +    .name = CPR_STATE,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +/*************************************************************************/
>> +
>> +static QEMUFile *cpr_state_file;
>> +
>> +QIOChannel *cpr_state_ioc(void)
>> +{
>> +    return qemu_file_get_ioc(cpr_state_file);
>> +}
>> +
>> +int cpr_state_save(Error **errp)
>> +{
>> +    int ret;
>> +    QEMUFile *f;
>> +
>> +    /* set f based on mode in a later patch in this series */
>> +    return 0;
>> +
>> +    qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
>> +    qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
>> +
>> +    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
>> +    if (ret) {
>> +        error_setg(errp, "vmstate_save_state error %d", ret);
>> +        qemu_fclose(f);
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Close the socket only partially so we can later detect when the other
>> +     * end closes by getting a HUP event.
>> +     */
>> +    qemu_fflush(f);
>> +    qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
>> +                         NULL);
> 
> What happens if we send everything and close immediately?
> 
> I didn't see how this cached file is used later throughout the whole
> series.  Is it used in some follow up series?

The complete usage and rationale is in the last patch, "migration: cpr-transfer mode"

- Steve

>> +    cpr_state_file = f;
>> +    return 0;
>> +}
>> +
>> +int cpr_state_load(Error **errp)
>> +{
>> +    int ret;
>> +    uint32_t v;
>> +    QEMUFile *f;
>> +
>> +    /* set f based on mode in a later patch in this series */
>> +    return 0;
>> +
>> +    v = qemu_get_be32(f);
>> +    if (v != QEMU_CPR_FILE_MAGIC) {
>> +        error_setg(errp, "Not a migration stream (bad magic %x)", v);
>> +        qemu_fclose(f);
>> +        return -EINVAL;
>> +    }
>> +    v = qemu_get_be32(f);
>> +    if (v != QEMU_CPR_FILE_VERSION) {
>> +        error_setg(errp, "Unsupported migration stream version %d", v);
>> +        qemu_fclose(f);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
>> +    if (ret) {
>> +        error_setg(errp, "vmstate_load_state error %d", ret);
>> +        qemu_fclose(f);
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Let the caller decide when to close the socket (and generate a HUP event
>> +     * for the sending side).
>> +     */
>> +    cpr_state_file = f;
>> +    return ret;
>> +}
>> +
>> +void cpr_state_close(void)
>> +{
>> +    if (cpr_state_file) {
>> +        qemu_fclose(cpr_state_file);
>> +        cpr_state_file = NULL;
>> +    }
>> +}
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 66d3de8..e5f4211 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -13,6 +13,7 @@ system_ss.add(files(
>>     'block-dirty-bitmap.c',
>>     'channel.c',
>>     'channel-block.c',
>> +  'cpr.c',
>>     'dirtyrate.c',
>>     'exec.c',
>>     'fd.c',
>> diff --git a/migration/migration.c b/migration/migration.c
>> index ae2be31..834b0a2 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -27,6 +27,7 @@
>>   #include "sysemu/cpu-throttle.h"
>>   #include "rdma.h"
>>   #include "ram.h"
>> +#include "migration/cpr.h"
>>   #include "migration/global_state.h"
>>   #include "migration/misc.h"
>>   #include "migration.h"
>> @@ -2123,6 +2124,10 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           }
>>       }
>>   
>> +    if (cpr_state_save(&local_err)) {
>> +        goto out;
>> +    }
>> +
>>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>           SocketAddress *saddr = &addr->u.socket;
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>> @@ -2147,6 +2152,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                             MIGRATION_STATUS_FAILED);
>>       }
>>   
>> +out:
>>       if (local_err) {
>>           if (!resume_requested) {
>>               yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index c65902f..5356fb5 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -341,6 +341,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
>>   # colo-failover.c
>>   colo_failover_set_state(const char *new_state) "new state %s"
>>   
>> +# cpr.c
>> +cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
>> +cpr_delete_fd(const char *name, int id) "%s, id %d"
>> +cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
>> +
>>   # block-dirty-bitmap.c
>>   send_bitmap_header_enter(void) ""
>>   send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
>> diff --git a/system/vl.c b/system/vl.c
>> index 752a1da..565d932 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -77,6 +77,7 @@
>>   #include "hw/block/block.h"
>>   #include "hw/i386/x86.h"
>>   #include "hw/i386/pc.h"
>> +#include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration/snapshot.h"
>>   #include "sysemu/tpm.h"
>> @@ -3720,6 +3721,12 @@ void qemu_init(int argc, char **argv)
>>   
>>       qemu_create_machine(machine_opts_dict);
>>   
>> +    /*
>> +     * Load incoming CPR state before any devices are created, because it
>> +     * contains file descriptors that are needed in device initialization code.
>> +     */
>> +    cpr_state_load(&error_fatal);
>> +
>>       suspend_mux_open();
>>   
>>       qemu_disable_default_devices();
>> -- 
>> 1.8.3.1
>>
> 


