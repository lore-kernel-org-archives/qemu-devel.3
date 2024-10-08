Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49E2CEFC24
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syC1o-0007mr-AR; Tue, 08 Oct 2024 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC1m-0007m9-Mv; Tue, 08 Oct 2024 11:21:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC1k-0008OF-7z; Tue, 08 Oct 2024 11:21:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtZVj008590;
 Tue, 8 Oct 2024 15:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=zWywVMpcuXm26xRJfowhqS3Hlp+nCd4WfLbpDbju50Q=; b=
 h5aeuXy0rzXAPSgRee1Wdq6Lh0x1XNmY+zKpgjLqwuy0mM/0xOQdy9wicDzYjP6I
 UScL7InpiwD2lGYNoAvTkI91agqJ5D4sb0vHcC/WdX0MrtjXlka2/948O3Ciczt6
 fxUgqiOvDeYVmHblbrTc7h3UwtSvMMH53cNHbThI/raMPgfzqr96xfjNqi5B6bBa
 Fb4/ko/r1kmyj+xCRoxuZQdhDXfqWhaCZDEVRFJqJQ0+RYBPMMUUViggglxChwtt
 qZ6+SAXhvyYYWHYEwVIhIakE2ko+Or/G2M5/kk6lbgrKbo1dPVgA5kAFAOIY2K09
 twxpe5kQLagKoiAM7CogPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034pa88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:21:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498EFFIO012038; Tue, 8 Oct 2024 15:21:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7aues-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF2cDdnWy7IN1D/lpUI24QvLX88ZOyh9WmsuwPF/F3xp7gBApoOM1/NJtmiR8OwNMagWwm+siD1rJArEOwbR9zl00orb9PS2baQOGj6Z0DRp5GyGSWtGBiW5q8rOrPZSkBqnYJEzsMPXI1Jx9yWqmAdqB2OnjHk0oS6mK3QWMBmpnDRQVcUk+ObHd5S1AzectQR2dS902OMoyhA1+a0OSKPKodtg6hxcD8gmnwURvHWLPDP0oKC4QX5ndcluYLJsnhuD501r+hpequiw1ahA145hoRstGaUsMmnJJxsCcbiAQJScIu12RzP3Tu8Nhc+Jv1+jaoqs4+fFCZO0ApdE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWywVMpcuXm26xRJfowhqS3Hlp+nCd4WfLbpDbju50Q=;
 b=iV4FIVQo9za7nXr2hZyXz7In0yhJJmMI8/kj3MpApUrungxSQCb4D/OctUs6D3Ukz9g54R1KxmIzz3ELOgwT31yo+mxBAa03GzwYYRYrHmpa5WP69BQb629L/V7gXr6DN07iphqQ417Tu4sxL5vlimacddXmjrpQfvMbvN8MwsWniKNQBXMXjwYzyPeuiDQNOKQUP3svquL6wa1B0Ujski22l5wbVig4lvW4ZevufmZ1uyOpXSe8Q+HqWHtPnlmjg6PmRS+ArAYEoRceJjF/VOoBhMwcPujyFhiMZpYuqU/4her6IytjpBSCePOEzFIu04Z606DDxsK9qq+Ojw275A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWywVMpcuXm26xRJfowhqS3Hlp+nCd4WfLbpDbju50Q=;
 b=HM6NjtBnuMTQW81IX+t9Up6HcEfKrbTyTiudvx/BCmWnawFgmm1OJ2fa3S6QILwggRn3DcTG7fSAwPC1UXNfaKMWAm0EgHHQe0vk3rHZeIS/ROyOSuW3Es8YLE03fGbNJBe8G7h8gyLYSzwdSXSRFoagJZuMukM+Y4PfgQKAN1s=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 15:21:14 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 15:21:13 +0000
Message-ID: <80483b29-2334-46a2-a95c-649d898a1fd6@oracle.com>
Date: Tue, 8 Oct 2024 11:21:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 PATCH 00/11] Support ACPI Control Method Sleep button
To: Igor Mammedov <imammedo@redhat.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20241007154150.6d406a7b@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20241007154150.6d406a7b@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e6c85a-6c0d-4def-7634-08dce7acd8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVlyd2pORmwxVGMvQWtNaU40MU9EMkc1NGluWnVoZWNNc00xcldPMHFFWTlJ?=
 =?utf-8?B?a2JlT3FaQ203cjM1cmd5OFBsTG5lUmcyb3puUkdpMnlhNWhNbUdRZUlHV0ta?=
 =?utf-8?B?L3g5QXJ6UnF5emdPTUx1aFZVb0F5SnlTKzdYbTEya2hrdkxwcHM4cUVwdUM5?=
 =?utf-8?B?SzFrS25DTEluNHRZeDJWakRMc3BPT0NtdFlQZkFzYU4zM3BJK3ZFc1BxNFVL?=
 =?utf-8?B?MzNHWmdKMzYwNi9wclN0ZWJaZVFPcFZwKzlEcXBjUmdnYzNZYStpWEJuTDdq?=
 =?utf-8?B?MkVCb1NBUmVlS1cxdDJCTEVPaXhZTlk3bDBKb2Y5YWpKeUtLMkFWS2ZOUDZM?=
 =?utf-8?B?eFc4ang3NUVOQVQwK2Vpd3VGaVVxcG5ZcDJSZWdZMmtOMU5qTGlkS0d0TTJ5?=
 =?utf-8?B?WDdYVDhYNGp2MnEybDFiT2k3ek5Ta2toSkdSdWQvRGloMGZ4N0FGZWdaMEU0?=
 =?utf-8?B?L1liUFdkSC9hQzhhRHcwRGlXbXVtelIxZ08weW9YODRmcmRLc0g5cVcyR2Ir?=
 =?utf-8?B?Rm5hRUJJUVlSd25OMGxRemxDaGM0TWxJbFJxWWI2cGU1K3Y0K01Kb2t4T2ZQ?=
 =?utf-8?B?bnlucTJQays4OEtqY1pKWjh2SUgzUzJGL3pNQmdlZHEvYkN5VUErcE5oOERk?=
 =?utf-8?B?cTV4SUoxY1hTVTdocWNlc0hZdTBaUEgvQjJCYzg5enFmZnZNdHJTbjNyWERN?=
 =?utf-8?B?bUNGMXUxR25wNVpxRmU2RDZ2VXYwWk5NczBaWHc5MUk2ejlLbklGUTF5QWx2?=
 =?utf-8?B?ZmZ3UFJlYytyLzYvYzZsMTFJYUpzQWlmc0wwWmh6MW92NFN5NnNINFhPbzFo?=
 =?utf-8?B?bUpmSmt0d3F6V25kQVlrTzd2UlFWZWwzL0wyUlBpNktIbGRoNFB0NncxQTE4?=
 =?utf-8?B?Y1ZzMHc1NDV5TW1yWUxwVTlldHNqRDlUWit5S3d5Y2NLeWJTWVVFUVFBSlBx?=
 =?utf-8?B?WUUvT0hETS9XVUFNNUkreGF2NS9QZkRjVnpmSjM4TVFGOXNxZ1lnSlo0elJE?=
 =?utf-8?B?OE9SaHp1YUNuRW9Xdis5UmtmMnVCeWtyWE5DY2p1bm9IVFdwcGZHZjg3VXpN?=
 =?utf-8?B?RnZCWGxwWUNySTVVVVNtbnB3Wmk0SlprTDF5MWFhbk9VUmJqclJib1FqbTZq?=
 =?utf-8?B?VXU5aytiRkhZT2U1aGh4QjUxRDh1blFjUTdMVG5nNTBmQUFCWUF2NXFyR1pN?=
 =?utf-8?B?alpDQmFyTEg3RThhOGxMTkFmeVNhRUZYb0VNbEltUDVjZGFSc0ROclIvZmxv?=
 =?utf-8?B?R1M2d2pyTkxvQW5iVS9rMnk0RUJlejRKTmtWdzhkZnFrSUlldTl2cng0SGJv?=
 =?utf-8?B?dW5tNHlJOFhJYUszb0o1SGdiSkZ3ZWVGU21zU0U2b0Z3ckY0M2I0QXdvYWV1?=
 =?utf-8?B?ZmY1dy95bjNzYWlUY1k0VGtIVmsyVDFzRFhkQkJ3SEhWWGo2NVVZYlNyOHFn?=
 =?utf-8?B?dmpPMTNNbWp5R05uZmdsak0zQkF2Z1ZRZTJyTnNtOWw1bFUxTmh3aEZDRE1E?=
 =?utf-8?B?NitQRFAvKzFFMndvRE5tS092MUFxZnUxMmV5UTF4c05BaHBiMDRoN3h4R1B2?=
 =?utf-8?B?SnRkZ2p3K1VNYW5kdmFUc3VQTG9TalhZY3paVTJTaVJhbzlSTlh6MVR2QzRU?=
 =?utf-8?Q?2W0Cp+xOFo9Id9XkiF7L5+svsmibUqNRLJGBOHZD1Vvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJnNWwyZFo0VnVMUzRmUldXSVV5WTdFRWNDbUpJaDg2bytnUVRSMmxJZFJ5?=
 =?utf-8?B?SmRCbjBBSkR1TTJ0bUR6VStuZ0h6TEEyK3NzOFRSdHE1d0MvQ0loaGdTa1J6?=
 =?utf-8?B?L3NrYWNHUU1CcHE3a1lhSEh2V2VUUit3ZjBaRkhUdktnNG9YRzV6bFl0L0NE?=
 =?utf-8?B?NUNSWi9CdUtEa3ZrS1hVUyttQVRkYnpBSi9CSFpxcTJ4MTF5TXJtMUxrZU0x?=
 =?utf-8?B?UXRQUkVmWW9UODZYNlhEUm53c3hDOG9xWDQwVGovOTFEREFkUFVzZVZhcXRB?=
 =?utf-8?B?cDZDeExCbUJoL0dqdWhWVFRiUnI3V1ExRjlZYlJ5VHJNSjcvaWZvc1UvV3Y2?=
 =?utf-8?B?bUpFNnlDcTlBN1dldjdSNHFuTWU1VWErV3RtTkVvNkFGdE9KbmZaVUtKUjN0?=
 =?utf-8?B?SnRITURTdnFmelZnanFjbWF0MkFLUlZ4b1RaY1dKOUJWVmZ4cngzNlNnYWJn?=
 =?utf-8?B?SmpUOWFtUy81V0RiVW1sNEErSjJYTFhJd1V4UmxFUS8zd1Npa2tHTVJwbUJ0?=
 =?utf-8?B?MUNNSDFOOXBwa3JZRzF6dU9SbXlJTUQ1MGxZTkJqcmNVYlczbEcyL1lFb1ZV?=
 =?utf-8?B?MzlTUm1LZ3JlWW9KWVEzUkZDMlh5MVI2ZEhOc2dFWVNOa2JkN1QyYk9IdzhT?=
 =?utf-8?B?UEhYcDljUXJ6WVMwZkd0ZDJpek85Nm0vamNjRnRGNWFXNFRSSmd4WG9abFMy?=
 =?utf-8?B?SUlqWGxaYnpqSkFuWGVKVXlOUUlLVzBGdE56WU9Qb0Rya3cycXJ6cTM1SWpO?=
 =?utf-8?B?VUdTTG92ZS9GMmptSWpjaDJGMHN1eGlCUmF3M3J3L1czelVwV2tOMzd2T3pM?=
 =?utf-8?B?VVZ5V2NEakZMQ1h3VmFzRzdZOU5QNVo3L3l6Vi9BRlhaemlROEpaZUJqakp6?=
 =?utf-8?B?RE16TC8zbFEzK0JRMGY4MUtCQ01NcnprR3BZQXhNaUJDR3Q4NS9DMzhpUW4v?=
 =?utf-8?B?TDg3V1pEOGNoc2VIZkNwZXRQNzd4QmYxcHpqSHVlV3ZpN2NQeld5S00vaWJh?=
 =?utf-8?B?eVVyTmp3QW02WngyV3lDTCtlRE9iMmRuV3BJUGpTVk5KNittMVBvbDBSN2hh?=
 =?utf-8?B?cEJOaVlyYUd6QmI5aHlrUVN3TGlzekU0UVZTSEZOeVdad2pxd2ZxSUpUR2FI?=
 =?utf-8?B?VVlKTzQzd1B3RG41N1lrY2N1Y3JibDhXVy9TbDRqVjZSdEQ3UDBQaWREeFho?=
 =?utf-8?B?Qm9TR1R3UFhiZ3A5Q3RTQWRWNFQ4dUNTZHVYYjQ5TWFsclFSZ2ZIMlBWY2hw?=
 =?utf-8?B?ZmRpVDc4SC93TEFkZkZMcmNmdUNrOEpKUU5JVlJlWi9PTnJhNVBWM2E2Y0NC?=
 =?utf-8?B?YmNJcjBySEpTOGljc0UvRHN1OHU4a0o1cnUyUzFWTVhVcDkzYUQ1ZzFTWXdL?=
 =?utf-8?B?V3VHMFY5TDA3eUhNMnJSVEFXWUZqL01CeGVXOUEwelg0d1U4MmVqNFJFNFVk?=
 =?utf-8?B?RDlPZ0JIRTlrZGkrcFpLRlY1QVJ4N2xDbnlCVUZvK0c3b1RKM0pqSnYyVWI3?=
 =?utf-8?B?S1ZFVllJZytLUDlGeXBVMmdydDR1dVlhVEdaV1dteFBnUWNSOFNZRVE2dzYx?=
 =?utf-8?B?V0ZoQ3FjRHRTQ29TcEozSFkzdHhTSmUxR1JQRzNWMStCVXl0RVpqSXJhaXlm?=
 =?utf-8?B?L21Wa2pXRWtTZkh0eFhjSXV3MmRyeUt1aWxzWHp2WTJ6a2FWQnRCWEFpTnl5?=
 =?utf-8?B?c2pFcVIzaTZjR092cGNvWGxERHU3QVlBYjlNRDFTa3Q3a1RhN2NBY2VZWGNx?=
 =?utf-8?B?Y0ZEazJhMHBGR25FV0RXelR4bk04eEt4UHZYNXFOTmpFQ3BOMFJVWEhUR1Ra?=
 =?utf-8?B?YmNJcy9oeng3Umlaamc5V0xFNHZuQlgyamhBc1F3bUZ2aGRlaERWYis1SGRs?=
 =?utf-8?B?TEZla1BqdW9NdFFkSnNONDJEdG5qN3BtSlJOaXg4enUvN1I2dTVIUHAzM2Nh?=
 =?utf-8?B?ZXhxZ2t3bFFlUlIrV3pxZGZPdG5TNWsvVWR4KzY0aHRmWUpKNlpLalJMN0pG?=
 =?utf-8?B?ejdySTRldlFoQkorbGdFVUF4UGFDQVJKMGNYbXkrVktmYTZKYThtazZPRmxJ?=
 =?utf-8?B?RHJKTHBiV2JiZ0I4alNGQ2lVY05ONlZlc1hXbGxYY2dYQW15bms2b1V3OWl2?=
 =?utf-8?Q?ozlvZ2KnftgF7AxCY7ofJ+Mqq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oll9HDbkRa1rPTaWwmkDQj79DlY6TbN78PgKl/176+GHdCghhg0M9NJAXcxDgLZQX5Kb6ztY3nAoqUfY+vSoUyLQ0Ss8Ipsc1udNwzkxM+xTn9fU6TcnXLGlR0DgQ9Hi5LTnGLkkXii6qVgJ7SFMn7AgdgQqIUrRQEuN6eer6eaN7d1Zj7NLFHlfBjagic8lqxFxBDnQiN6SOykMrR/dm7ho7LTOoNIhFCzbhGKOg4FCOGq8kohfGFGg0BXESQLjBQFejudcqiiNdA3DIfSfX9AZ7KGruVUB9ea02HkPoCT85Guql/94NGywdfvoN55hNq2raapN96mUm6VD1Ul6UDaKVGPaDDuYdHXd2r5mq0sQbTBGtl2nV0VBv/CbzxpFdsY02ryNpoClWQR1k+uFwauEo/XiEpqFU0uRkOABU+CvRTLkk2/zXemTzlscBOjEDqhrDggBTMGX+PIZG3jzlw4n+PHpl1/bmDYhnvbDUvYqN+PaYKiOKXgRwmmfcyBIjAGc12VEIXwqB+as3LFlEy+e9FxHRHdJU6Gha7OeXinCapxOrPBt/LMajMryvdDYHMilM1ytmnEt9QQ1aLLLnolkqf04Mur1To2otKi6hLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6c85a-6c0d-4def-7634-08dce7acd8bc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:21:13.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gXnzIAIcz0nVpIdnuzRMy/sJKdjwDqOt4c1UsTWYHq14mr/CT+IHvgKKA3uJFJNVTRfJ84MfuCkP0m3k4Zktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080097
X-Proofpoint-GUID: mBLMmU6gJpt5eE_NJ6ieEP_Gx9vSYOuq
X-Proofpoint-ORIG-GUID: mBLMmU6gJpt5eE_NJ6ieEP_Gx9vSYOuq
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 10/7/2024 9:41 AM, Igor Mammedov wrote:
> On Fri, 27 Sep 2024 14:38:55 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> The ACPI sleep button can be implemented as a fixed hardware button
>> or Control Method Sleep button.
>>
>> The patch of implementing a fixed hardware sleep button was posted
>> here 1). More discussions can be found here 2). Essentially, the
>> discussion mainly focuses on whether the sleep button is implemented
>> as a fixed hardware button or Control Method Sleep button. The latter
>> benefits various architectures since the code can be shared among
>> them.
>>
>> This patch set implements Control Method Sleep button for both x86
>> and ARM platform.(The patch set was posted previously here 3). We
>> rebase all the patches on QEMU9.1.0 and re-post it).
>>
>> For x86, a sleep button GPE event handler is implemented, so a GPE
>> event is triggered to indicate the OSPM the sleep button is pressed.
>> Tests have been done for Linux guest, and Windows Server guest,
>> the sleep button works as expected.
>>
>> For ARM, a GED event is triggered to notify the OSPM. With proper
>> debug knobs it is possible to see the guest OSPM acknowledges the
>> sleep event:
> Series also missed 'microvm', that uses GED
> (it's likely the same amount of work as for arm/virt board)
I haven't implement this for 'microvm' yet, will work on this part, as 
well as
things you mentioned below.

Thanks
Annie

>
> also test all boards you are touching, to make sure you
> didn't break them.
>
> Note: commit messages should be more verbose explaining why and what
> patches are doing.
>
> PS:
> Also keep  changelog in cover letter, for a short list of changes
> between series revisions,
> see '[PATCH v3 0/1] hw/nvme: add atomic write support' for an example
>
>> (qemu) system_sleep
>> (qemu) [6.744138] exregion-0179 ex_system_memory_space: System-Memory (width 32) R/W 0 Address=0000000009080000
>> [6.746003] evmisc-0132 ev_queue_notify_reques: Dispatching Notify on [SLPB] (Device) Value 0x80 (Status Change) Node 00000000f0e6819e
>> [6.802873] PM: suspend entry (s2idle)
>> [6.806201] Filesystems sync: 0.002 seconds
>> [6.807580] Freezing user space processes
>> [6.809478] Freezing user space processes completed (elapsed 0.001 seconds)
>> [6.810602] OOM killer disabled.
>> [6.811111] Freezing remaining freezable tasks
>> [6.812953] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [6.814126] printk: Suspending console(s) (use no_console_suspend to debug)
>>
>> But that seems to be all, depicting that sleep/wakeup for ARM is broken
>> and there are still missing some pieces of the puzzle.
>>
>> Nonetheless, we would like to take this RFC as an opportunity for updates
>> on this subject as possible roadmaps.
>>
>> 1) https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html__;!!ACWV5N9M2RV99hQ!PLz2MGkywgnU4MB6tbITFe4-fMs6CqdUQY9Jhgbi2vIdAVf94Uz2OI-yBQOYElEQb-dsvtN323zzSb8$
>> 2) https://urldefense.com/v3/__https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/*mfe24f89778020deeacfe45083f3eea3cf9f55961__;Iw!!ACWV5N9M2RV99hQ!PLz2MGkywgnU4MB6tbITFe4-fMs6CqdUQY9Jhgbi2vIdAVf94Uz2OI-yBQOYElEQb-dsvtN34RUikoM$
>> 3) https://urldefense.com/v3/__https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/__;!!ACWV5N9M2RV99hQ!PLz2MGkywgnU4MB6tbITFe4-fMs6CqdUQY9Jhgbi2vIdAVf94Uz2OI-yBQOYElEQb-dsvtN3zrJlck4$
>>
>>
>> Annie Li (6):
>>    acpi: hmp/qmp: Add hmp/qmp support for system_sleep
>>    acpi: Implement control method sleep button
>>    test/acpi: allow DSDT table changes
>>    acpi: Support Control Method sleep button for x86
>>    tests/acpi: Update DSDT tables for Control method sleep button
>>    acpi: Send the GPE event of suspend and wakeup for x86
>>
>> Miguel Luis (5):
>>    hw/acpi: Add ACPI GED support for the sleep event
>>    tests/acpi: allow FACP and DSDT table changes for arm/virt
>>    hw/arm: enable sleep support for arm/virt
>>    tests/acpi: Update FACP and DSDT tables for sleep button
>>    arm/virt: enable sleep support
>>
>>   hmp-commands.hx                               |  14 +++++
>>   hw/acpi/control_method_device.c               |  54 ++++++++++++++++++
>>   hw/acpi/core.c                                |  17 ++++--
>>   hw/acpi/generic_event_device.c                |   9 +++
>>   hw/acpi/meson.build                           |   1 +
>>   hw/arm/virt-acpi-build.c                      |  13 +++++
>>   hw/arm/virt.c                                 |  14 ++++-
>>   hw/core/machine-hmp-cmds.c                    |   5 ++
>>   hw/core/machine-qmp-cmds.c                    |  11 ++++
>>   hw/i386/acpi-build.c                          |   9 +++
>>   include/hw/acpi/acpi.h                        |   1 +
>>   include/hw/acpi/acpi_dev_interface.h          |   1 +
>>   include/hw/acpi/control_method_device.h       |  25 ++++++++
>>   include/hw/acpi/generic_event_device.h        |   1 +
>>   include/hw/arm/virt.h                         |   1 +
>>   include/monitor/hmp.h                         |   1 +
>>   qapi/machine.json                             |  18 ++++++
>>   qapi/pragma.json                              |   1 +
>>   tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5278 bytes
>>   .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5364 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6639 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7761 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5480 bytes
>>   tests/data/acpi/aarch64/virt/FACP             | Bin 276 -> 276 bytes
>>   tests/data/acpi/x86/pc/DSDT                   | Bin 6830 -> 7012 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 6741 -> 6923 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 8155 -> 8337 bytes
>>   tests/data/acpi/x86/pc/DSDT.bridge            | Bin 13701 -> 13883 bytes
>>   tests/data/acpi/x86/pc/DSDT.cphp              | Bin 7294 -> 7476 bytes
>>   tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 8484 -> 8666 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 6781 -> 6963 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 3337 -> 3519 bytes
>>   tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 6902 -> 7084 bytes
>>   tests/data/acpi/x86/pc/DSDT.memhp             | Bin 8189 -> 8371 bytes
>>   tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 6688 -> 6870 bytes
>>   tests/data/acpi/x86/pc/DSDT.numamem           | Bin 6836 -> 7018 bytes
>>   tests/data/acpi/x86/pc/DSDT.roothp            | Bin 10623 -> 10805 bytes
>>   tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8537 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8554 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9862 bytes
>>   .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8816 bytes
>>   tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8583 bytes
>>   tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12150 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 13095 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33952 bytes
>>   tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 9001 bytes
>>   tests/data/acpi/x86/q35/DSDT.cxl              | Bin 9714 -> 9896 bytes
>>   tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10191 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8612 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8625 bytes
>>   tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8554 bytes
>>   tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9896 bytes
>>   tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9667 bytes
>>   tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13390 bytes
>>   tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8417 bytes
>>   tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8395 bytes
>>   tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8543 bytes
>>   tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8638 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 13095 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33952 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9143 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9169 bytes
>>   tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18771 bytes
>>   tests/data/acpi/x86/q35/DSDT.viot             | Bin 9464 -> 9646 bytes
>>   tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35900 bytes
>>   65 files changed, 191 insertions(+), 5 deletions(-)
>>   create mode 100644 hw/acpi/control_method_device.c
>>   create mode 100644 include/hw/acpi/control_method_device.h
>>

