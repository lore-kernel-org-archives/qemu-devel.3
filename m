Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C56EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0SK-0003dV-IR; Fri, 16 Aug 2024 13:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf0SJ-0003d2-L2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:09:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf0SG-00077b-0V
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:09:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GFiSkE014821;
 Fri, 16 Aug 2024 17:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=SNfqrwgjQ1+kQblaobuIMVJDUhxwZrc5CY38SBhKnQc=; b=
 SJ93ZdFJKt38ga60ZRaD6VwjIiyD1nM1uZA7y0+fhZ4WqD/NS3LIchEc1TCmHk6a
 dzzGfhZQ89oroVnNyF4hRAY4Vou9jRBmLUEDTLhcwGgTKBO9nITKCdJ8iPkSXRhI
 mW1geH7X8ywCx6Ss4atkcJ9/s7Zdukr7QJK/5jehNxKNFZRasjCgdqRZhFY6/XFt
 BImAIlSXxk5H5aAt+xclAwqiL91o49a6q7krYBb0vp72IhSI743w7f6FKDel7ZOa
 IOoNpWykVmpRgU1hHtkFNCjmhXuXU9puDzjKEkf4h95Jgu1RS0zU7+1HEQiJoBVP
 3Gka2y7/mvDnGJzH/7zKYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy035584-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 17:09:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GGlhZX010633; Fri, 16 Aug 2024 17:09:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxncmpm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 17:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtUlRSL1RqUSRYJ8Lhv5ouoXlLcmpY1GZr9MM4wLvTFo5mzieVVmc39oi74JfjeaNuYh6yB0//YfXTKMjo5Yd73Ciz1caG8JA+dB2K81aAl09AQbgRz+9nW7O5MFfYTmVrUtwSGIdCbOAdgChPc267JkTkAKhy+ciS1XM8T86pF2cDmTgOgVBf2eLT/+MNf+2kkmJccnO8uJqFMfU/syPfE07kRFo/iek9cs0yDxTU1qs6plBn+mNmN+kIqbNHQRmWF5yc7dUrEbRImZiaf100WEGm7DaqhSfnA9yD27bpgOUVkvq5ywU7597MVFVh3W7iOa1cBET9G4k9rRGuuAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNfqrwgjQ1+kQblaobuIMVJDUhxwZrc5CY38SBhKnQc=;
 b=pZj+c1lLuHJeH9W0UXyv41w6d8SVirEeKUmafK/l4PDzLZ3qd1dtyo7BUB2YrEViBFgiPAkHwRgyIhB1ggHGh0dRBf9Z/jkNYMFNHxC/1dIACTIGy2X1Cdr6rmRFPGkJs3k3aQ+wC10G0sKikMI6iqkP0KieNauZRKhkZfsC90pM31E17D8wT7Mlvo6+qMdwuvROks3K2/mOjsrpGVN2hCAyvCshEB3wgxzDIXki2MFZPwV4oj1UbYhqtxk02735R4GtQSj04bZflEhkcqu7QNpgMu7D7YkJFM0jDvXIOOfzZ+G576wOd3NWKuUDc80gXvy7Q0437JN1tV5wQpitNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNfqrwgjQ1+kQblaobuIMVJDUhxwZrc5CY38SBhKnQc=;
 b=JTDvk10rFO7FmsHvjvdqtwRmhP/UHfDfqOlxyfW6v4rJfMHrVPLLpiRVPk/eOAw6tVKh6WBBL7hO9nuIIApIV8iBb52kdtiRu5MktI93QvkdptzZQq/qZ5gW9R+0sqXNOGuwdslup9L8rlvlCkEjRh7kk6wibioQdtFAiBzhoyQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7810.namprd10.prod.outlook.com (2603:10b6:a03:578::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Fri, 16 Aug
 2024 17:09:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:09:28 +0000
Message-ID: <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
Date: Fri, 16 Aug 2024 13:09:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com> <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com> <Zr9q4muKZmYCf9mv@x1n>
 <Zr9tYsmy8j2t8fq0@redhat.com> <Zr9xcmUfkYAWnXH-@x1n>
 <Zr93oOn9J5JLs2Rn@redhat.com> <Zr97ms6Ur9HH_EXG@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr97ms6Ur9HH_EXG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebc9915-1a3e-4365-2d90-08dcbe162fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTh2M29mM1BNWkhVOGJDVVpwT1N4aGhCQll6YXo4NHNEVHhlUm5iYm44dVh1?=
 =?utf-8?B?Wk96M3djM3lYSnJxazRwSTQ2OGxMS2Q3Ym5JMG9DVlBZL0dOajB0QzZzbTFX?=
 =?utf-8?B?aVVNNythNm83TUs0ZDVkWVhjcERnNFgzVWZhcGNKRWxVN2dhM1NKYmpkV2JG?=
 =?utf-8?B?YnFFd3QyRUhZVHo5NWZKZ1BIL2NMcW1QMVNETGltbnVSTUlUdDBnWms5SUdY?=
 =?utf-8?B?RnZwRWNNclhMNWJ5S1RucTFqQmo2RXNueDRGbVh2UjZncUhwSHJLLzFwMDhK?=
 =?utf-8?B?aWYwMW5xdGJjRXovQ093VFFLTHJ0T1ZlMTFpUmd3cENoRFVSQVhjYmRiZmky?=
 =?utf-8?B?S01wMDNDRzFxNno0bExabmJIWGwvTloxQXpMTXdrN2EwSmNObmoyTU9hYTJk?=
 =?utf-8?B?cmZYOUVpUEZpK3A0NS9BSUF2NTF4ZnFQUU5JT2R1TlJKc20rR3dza2YvcmV6?=
 =?utf-8?B?cWVoS2hvcWg0VlFvcUtDVUFnVm9EeWl3M3B1M2dzeWJWWXlDZFNMRUxwNnN3?=
 =?utf-8?B?TXZac1VMZzNjRFdEcU93WDJ4aG5Sb0dOTXVuN05XaUkvaDJHQytjV1FhMy83?=
 =?utf-8?B?QUtPbWlGV3ErWGw2dEg2UWkyZG0wQlFmbWQ3Yk5aUGh2eENiWkpkWEIwcnNO?=
 =?utf-8?B?RzR3cjNTek95NUQ3am1OTWdJRkM2VjVBRTBiRTkreU1NT2lhY1VFRThCb2lh?=
 =?utf-8?B?Wkl2TVZDWU9xZ2dJVW5vdXJPK1dueXZtZ0Nub200cityYm1FUndscXN5cTAy?=
 =?utf-8?B?djhxYnoxODBVaWNteWZkT3RLTkpieWJpU1EvakdvdUpOYnpacjZSQTI4d1dU?=
 =?utf-8?B?L2hiQlViSk4vVzVJVkR3c1lwYXhEWWZUUHdUaDN2eDFYQ21sRmM4cGEwZk51?=
 =?utf-8?B?NG11S09oeUtoekpma2REd0xubVdSeE04QlQweWEyaGFzVlBLOVg5NFNTNldR?=
 =?utf-8?B?WjV4RnpZbG1NSS9ZNGUyRWM4NXIvTmxYYVdQWFpValVoZGxPdkNwQy9tekRB?=
 =?utf-8?B?NGlCejVORmduQU0vckpKM01xSGUrUnJXeXAwYnlPZ2hIM1gxejF1QjhwYTJj?=
 =?utf-8?B?c2xQVWt1YXYwVHlEbG1aaXhscU1mcEpVZDY4YUhJejNHb3ZQWkdQeHdoUkJl?=
 =?utf-8?B?NElQMVNZYkpTOTVLTkxoSE5CbjJ6Qk9NckxadWx5UXVoL2hhZVk1WTA0YWhI?=
 =?utf-8?B?Kytmc2IybWZMWXNiUGhMZTE0dEE0cUY4UW1tR3FPenU3NjJQQ2s2ZzJleVlk?=
 =?utf-8?B?TmhHcklJRkNBMm03ejhzbTlBdURVVjF4d2RTNHRUMWxJOXppVmNkczd0L0Er?=
 =?utf-8?B?b3QzbVloclVja3I2akFORXRnQTgyQjZxV3ZSVVB6UUJCSldrWEtmb2RUcG9M?=
 =?utf-8?B?K3d1UHhKN3VYN0FQeVlJS0hCUGRSL3c0N2IvVEc0YWhzRFVrVG00UWZ5Y05U?=
 =?utf-8?B?dTB4ZzhMWGtLUnhlaHk3TnBWSS93cHlPVkZhNE5iR04yMDRtdHJKSUpzOTBX?=
 =?utf-8?B?WjR4TTk5ZTRBRERpaDdDOFVidVJEMGhTYUhDR3c0U05IV2ZlUGl5Zk4zMkRx?=
 =?utf-8?B?UGo2bUd4aUpLYU8zTFBXQWFsLzRmbFR3ZFdXTkpQTFJiMGt2clRmcTYyeGNp?=
 =?utf-8?B?bFNxVmJXWnBqSFNiS2NUTjU5RUQyazZKeDFSUnV4a0t0Y2kzZC9qa3lYVjY0?=
 =?utf-8?B?TFpzWXZpYWVSQVBEUXcyeGpxaXNqSjg0NDdlOWNXcWpMbWQrV3Z3QUpPa2hF?=
 =?utf-8?B?VFc4bk5UOTdnNExKTWRDcjRZT2g1cENVYnpzazJWYTZRbUJSZ0hzZ1VPcy93?=
 =?utf-8?B?WWdndkVMM2RXSnVqZ1JOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1liemRialdwbHl1Q1ZkaXZJOTFDMG9oeGhmMDQzMG14MWpHcFY0Zlk2OW50?=
 =?utf-8?B?T0NsSDJaa21YR3J2d1Jya2Z5YVpqYVI3Z092akJyUjE3L2NKM0I2ck1VU3I0?=
 =?utf-8?B?Q1hwY3dySUI5dkpHcWtWZHVWTlhqTXE3NXJyQ016T1ZFaEkvTllOTGtLamdu?=
 =?utf-8?B?eUhXNTdaUExrSG5iVis1YWRod3JTT1BKTEcyYTA4VTlIWSs5TmY2RFk2alBi?=
 =?utf-8?B?ZW1pNDkraklkcDE4NTdrYk5oZ0VvMW9PUEI4ZG9GVUlmV2ZoMUNOaUlFY21u?=
 =?utf-8?B?cVNnVUxZNFpTenJkSXRtTitFOHJvU1VwWVhnSlE4aWNUMzF2WjNXaGJ0UDE0?=
 =?utf-8?B?N3B0RWcrV3ZmR2FNL2Nvc1hGK3VQNldSOGI0eTE0K3gvN0lXbkRydHB2Q1ho?=
 =?utf-8?B?alR2WHFtZExJVENVUTlzMHJkdTdoYU9VVm5Tc3JaMytQRzQvM1EySVJYZjFT?=
 =?utf-8?B?M2JTTkx0aHNuQURoRmIzV01GQmxCSjVUVG5HWnBlWlZoS1Yxc09HTlpka2F1?=
 =?utf-8?B?M3l5bTBEbDd4cWdVM1Vkek9nakdQeWF6S0pJR3FyZFlub3NrTjRnQmFVd2ta?=
 =?utf-8?B?bTFydFpiUytPaGNHWUF3dldXTHhMM1VyNFRRWUdKMUlGY2p1cUc2Q2g3M3Rs?=
 =?utf-8?B?SDRvUHN6WC80ZGNOcVViV1hGWFF4WmNrejI0MWlzMmJXNWtHM3BZYjRLUGpH?=
 =?utf-8?B?Y3E3S2htT0pnWGxoaS9DelRsTTR0d01jUTltWUd2eHZ0eHdNUG94S1lzY2xm?=
 =?utf-8?B?aFFqVFZkRjJNNGZrUncyRys3ak9OeUJnS2xHMFpCbU5kL0J6WUJtbHBHNkdn?=
 =?utf-8?B?T1d5MmZwLzdlbzhrZkVVa01mdWw5YWhHWTQ4RUdGMWRuem1EVGx1TUNYM1hT?=
 =?utf-8?B?M0JzVlVHdlZyZE15ZEViRVp0UVdmejA1SzBlYmh3S3VzYU9HZXpqY1U5RzBk?=
 =?utf-8?B?TjhKYlFxeUdtdEtXcEljZmhabDA3R0hWZkZ0RTNMYXpuaGFGSmlGSDRWQzBh?=
 =?utf-8?B?cDVvVUc2RDNtRVArek44ZFAxK3p4TDhSQXM2MzI4ODA0b3hGMUM2S2dZTWpK?=
 =?utf-8?B?UzVEZlkreGV5V0FvRUlaT09OZzE0YXpXSGxpNkNBQkUwZlpXT0ZBanpCUjcx?=
 =?utf-8?B?d0hEMkI5SXFjaWZYV1kzQWhpSE1BNmgza2YyTTBNUTRYVjBJUXVlSHVUeWJk?=
 =?utf-8?B?ckFsL08wK1paa3lHYVJLMWN3M0V2eVNGWE1FMU9KeW9CRkZqZTVBd0hvNjNv?=
 =?utf-8?B?bk9VUVFiYi9zTkVGMmc1aVJWREdDb1N4bHNtbUlkQ25BcjlLaXNQNjRsUElB?=
 =?utf-8?B?K3ZCNUV1RldPaysyenZhVS9UNVpnNVBtajN4UmNSZVg2NS85QmNkMkpIQUFV?=
 =?utf-8?B?VjM2VERadVFxOFdWaytaVDBudTNhSFN3WUttc3p6cHY3VG5HOUw0Uk1EUlRC?=
 =?utf-8?B?OXVsTUt3MVlIUlZBcXpadFF5UXh1bUoyc2w3TlZ3bzJPVi9iQjgvTzIvU3Z6?=
 =?utf-8?B?U2dCZXdTWGI0WnEvV0loSTIydDB0b05kRHNCL3NLUS9YanlwUUkxVUNkQlBC?=
 =?utf-8?B?QW1GM2VGczNvcmE2SjZoT0VDSG9uT3NjTk0reEtYbGxkVGNqWlEyTlhhRmdh?=
 =?utf-8?B?clJFMXhkSGhZT3ZiVXJ6bXQyWitDaU5BZCtmTEFpc0w5OGthd1Qya3V5SGlv?=
 =?utf-8?B?NmJGSEx3QmlISWFJb0pleVhRNkRzckZYaURUbytwWGdnYUNTR29FcGtwUWVW?=
 =?utf-8?B?Rm5XQU1wRXF3OUdZdmk5RkgvWTRwTHJpcmpFKzR6Y01TZTgxRzYxdmpSNmJG?=
 =?utf-8?B?eFZRcXltMk5IUVRuY3gwZVlDT1Y2R3czb0I0czFXMU9xN0RUNklPK0lCcnFW?=
 =?utf-8?B?RW00KzlDNlBwUE9QSytrWE85QlJ0SmRnY1c5QytWd1BEOHFpRHdWQk4rWkQy?=
 =?utf-8?B?ZXlUaTNyMFdubkUzd2pqaEhsci96MTE5ZHRLSjJjOVdFUlJYWmpBVWJmT2hI?=
 =?utf-8?B?TGRFOUhFbndGa0NqZ2FvQ0QraHhBQXBGMWJWbGlvd1BJUnBKMjdFRzNSWHFJ?=
 =?utf-8?B?WEw5MnpJOTJaZEpYd05nWVdteVorUC9CUjQ5aStpQTBpbUVsVWJtWVRQa2JR?=
 =?utf-8?B?cGpocFZLaWNlUlplcTlOcFQ5eWRndkVGb0laeXFvVk82a1Z3NjdQRkdyWmZS?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0+5mSOKuCqLZLrnKMw0jwVN1Qhq0YTYjzx7GFVaEEd6hGESvcOV8ETXAdKIFMnflB/aZ+mc0QAg5AhY1kQ8mwqWO7bStM+hXSq9JL325SLTGt+cTpBhg7xynRxBED0ckjGHrnzh5ZMhJn8oAAqMea660S28zaMA/QOHk4ZlLJ9Kqj1uTWG+EkZWraD+ogdgsvqrjDOH2wZ6fjrizf+MkxB0dKepnMyRUnTTXmr+P2MhDhdpjQZkoQ9/oaaqLsu2++a2nxRr59+S7BEd183ZEEhPARIc5EHQkAuthra5hHThzSpZPLQAXRlL0THDYJ3rLtjXAEsCTh4bst5NTbDNXhkVRYoBW+mo94+/5JZSFUhbYrF7020PMeaqqZUfzoBqdOhtmPsv+IV7cZB+yCQs3viVlHIoE6++Uy2RNXno6hvZ/tP1qheWkJDrNJNKVofylOPFOzW0L7mCSe2QncBzEjjdD8xB4prN8ydo9DwaAsE2r1D74ZZui9M+T9Mpc1M+Wwg9gzgVAx9JSKPmlaZMLy5ZF4LXxC7MpBhoI8Z0ilipF2A+tcVRClAhpObeADHH2aXC+Kx6fcaNGW+iO/l6XIbdEVOlBCA05nQoGqw9Z27M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebc9915-1a3e-4365-2d90-08dcbe162fe3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:09:28.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoCI0HdYc00E2SMaKs5uA53xRZM8LFEmJSdw6IYy82b5u+UEXz1/goQoCRlkNQmZDg7xPmb61AuJNMqK49IxzeyLMhsWQQsnFBTB8Z8c3dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_11,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160121
X-Proofpoint-GUID: org5z07wTK1YTLSCgzSdBeA4lZquqZkt
X-Proofpoint-ORIG-GUID: org5z07wTK1YTLSCgzSdBeA4lZquqZkt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 12:17 PM, Peter Xu wrote:
> On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
>>> On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
>>>>> On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
>>>>>> On 8/13/2024 3:46 PM, Peter Xu wrote:
>>>>>>> On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
>>>>>>>>> The flipside, however, is that localhost migration via 2 separate QEMU
>>>>>>>>> processes has issues where both QEMUs want to be opening the very same
>>>>>>>>> file, and only 1 of them can ever have them open.
>>>>>>>
>>>>>>> I thought we used to have similar issue with block devices, but I assume
>>>>>>> it's solved for years (and whoever owns it will take proper file lock,
>>>>>>> IIRC, and QEMU migration should properly serialize the time window on who's
>>>>>>> going to take the file lock).
>>>>>>>
>>>>>>> Maybe this is about something else?
>>>>>>
>>>>>> I don't have an example where this fails.
>>>>>>
>>>>>> I can cause "Failed to get "write" lock" errors if two qemu instances open
>>>>>> the same block device, but the error is suppressed if you add the -incoming
>>>>>> argument, due to this code:
>>>>>>
>>>>>>    blk_attach_dev()
>>>>>>      if (runstate_check(RUN_STATE_INMIGRATE))
>>>>>>        blk->disable_perm = true;
>>>>>
>>>>> Yep, this one is pretty much expected.
>>>>>
>>>>>>
>>>>>>>> Indeed, and "files" includes unix domain sockets.
>>>>>>
>>>>>> More on this -- the second qemu to bind a unix domain socket for listening
>>>>>> wins, and the first qemu loses it (because second qemu unlinks and recreates
>>>>>> the socket path before binding on the assumption that it is stale).
>>>>>>
>>>>>> One must use a different name for the socket for second qemu, and clients
>>>>>> that wish to connect must be aware of the new port.
>>>>>>
>>>>>>>> Network ports also conflict.
>>>>>>>> cpr-exec avoids such problems, and is one of the advantages of the method that
>>>>>>>> I forgot to promote.
>>>>>>>
>>>>>>> I was thinking that's fine, as the host ports should be the backend of the
>>>>>>> VM ports only anyway so they don't need to be identical on both sides?
>>>>>>>
>>>>>>> IOW, my understanding is it's the guest IP/ports/... which should still be
>>>>>>> stable across migrations, where the host ports can be different as long as
>>>>>>> the host ports can forward guest port messages correctly?
>>>>>>
>>>>>> Yes, one must use a different host port number for the second qemu, and clients
>>>>>> that wish to connect must be aware of the new port.
>>>>>>
>>>>>> That is my point -- cpr-transfer requires fiddling with such things.
>>>>>> cpr-exec does not.
>>>>>
>>>>> Right, and my understanding is all these facilities are already there, so
>>>>> no new code should be needed on reconnect issues if to support cpr-transfer
>>>>> in Libvirt or similar management layers that supports migrations.
>>>>
>>>> Note Libvirt explicitly blocks localhost migration today because
>>>> solving all these clashing resource problems is a huge can of worms
>>>> and it can't be made invisible to the user of libvirt in any practical
>>>> way.
>>>
>>> Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
>>> supported local migration somehow on top of libvirt.
>>
>> Since kubevirt runs inside a container, "localhost" migration
>> is effectively migrating between 2 completely separate OS installs
>> (containers), that happen to be on the same physical host. IOW, it
>> is a cross-host migration from Libvirt & QEMU's POV, and there are
>> no clashing resources to worry about.
> 
> OK, makes sense.
> 
> Then do you think it's possible to support cpr-transfer in that scenario
> from Libvirt POV?
> 
>>
>>> Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
>>> to consume it (as cpr-* is only for local host migrations so far)?  Even if
>>> all the rest issues we're discussing with cpr-exec, is that the only way to
>>> go for Libvirt, then?
>>
>> cpr-exec is certainly appealing from the POV of avoiding the clashing
>> resources problem in libvirt.
>>
>> It has own issues though, because libvirt runs all QEMU processes with
>> seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
>> and thus don't want to allow it to exec anything !
>>
>> I don't know which is the lesser evil from libvirt's POV.
>>
>> Personally I see security controls as an overriding requirement for
>> everything.
> 
> One thing I am aware of is cpr-exec is not the only one who might start to
> use exec() in QEMU. TDX fundamentally will need to create another key VM to
> deliver the keys and the plan seems to be using exec() too.  However in
> that case per my understanding the exec() is optional - the key VM can also
> be created by Libvirt.
> 
> IOW, it looks like we can still stick with execve() being blocked yet so
> far except cpr-exec().
> 
> Hmm, this makes the decision harder to make.  We need to figure out a way
> on knowing how to consume this feature for at least open source virt
> stack..  So far it looks like it's only possible (if we take seccomp high
> priority) we use cpr-transfer but only in a container.

libvirt starts qemu with the -sandbox spawn=deny option which blocks fork, exec,
and change namespace operations.  I have a patch in my workspace to be submitted
later called "seccomp: fine-grained control of fork, exec, and namespace" that allows
libvirt to block fork and namespace but allow exec.

- Steve

