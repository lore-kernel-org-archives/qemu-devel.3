Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E73CEFC25
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syC3C-0000gz-3D; Tue, 08 Oct 2024 11:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC3A-0000gQ-Gr; Tue, 08 Oct 2024 11:23:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syC38-0008Vv-Eo; Tue, 08 Oct 2024 11:23:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtcYs020504;
 Tue, 8 Oct 2024 15:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=FbvFJ4Dfsj1Ivk5vMz
 4B6mfrrC4krYQKVLVXFCVWh4Y=; b=Mts5EvSvtx0yZL3w0gvgscJYzC08wApydF
 jtDmHIpWeFfIllYee4tVAvXpOkwkb8y9r1asYm5ZRJE8XdffCz88Kx/W3zndbGjr
 jIJ5yCozyZ0eUf+mgOhZoZ20zy7rzqEqMIIVd8kiR+AIwek1ADcWcXCL5csOL9EF
 uTIaGjyvsrB5x5x4aCtrYIZyp08JTGoAiC9NCXY699PWerHk8J30is1qUc0QUYRy
 2j8mWoZrCtkjDXEGCcNhn33YMsSob2zlzaa9zJUjvUiMvYathM01m7SiAAd20yXQ
 ahNU/kqBlIEzpeYevWzR8JlPBmGoooO5ef/tqlCaw/XgroJFmSfA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063p2y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:22:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498F2QJA004580; Tue, 8 Oct 2024 15:22:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7c8nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1gg0ePsf4U7g1tKCK9/cr2ysD27+0v29qe9PxTtULmouXgPHrH3BOlBJ56KUuiVUMoa0aOQxTtXVc9Vy+vM4AbbF9ZmodavNI+NDwJui6gXs6xaAe9TBjvYsE2+ceaqQfIXkFQ9R86cZGuiZAy3F9fFAI/H6n/jaIwukfcDprf9qwK0vrKebBqgUxvqQJaRGqy172LnbDwmKr9RUwkrVZc/LZn9zBP4qJvTKtnzJ0j897hpl6BCUpNbWvOE0JHpUaEUW4+yJTNEBGoL+s8VAGpIlQTy4dYHWKjy9M1uxdOhXFyCkDS98TvDDpGz9cEyq4HIFkY6mqtkSGf9Q1LRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbvFJ4Dfsj1Ivk5vMz4B6mfrrC4krYQKVLVXFCVWh4Y=;
 b=kpBRYE7/dxfWeuVWxs8wWlDGFGOTxnF356diuMtcfmZn98Jn6qKpg50n+mXO03yN3/HuonC8RfmPYMqMJTpcql4IJZ3935jyfs0kZ54X7sd4bNNqAYAILpPAajaLDb2s+u/P9gPIBA7IdCCTarNi0UU0uvuMgScMQnInBvPnM7yLoEoZSnmoA+kz9MyMjtjt8ooFwccNcRvp014f5s2Nvt3WEZtqNdvgOeD1t4jh9Y+SGU7xESxueRHZ3XXwE2IkZbNPkPmHpstVaXbZQn1tTGvqeokjksFMJ2t9d8PZ/opsReATINep6jxKwcwAFoEh+cxIb6YglCOIhGyKTJs2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbvFJ4Dfsj1Ivk5vMz4B6mfrrC4krYQKVLVXFCVWh4Y=;
 b=Ra57NI2hb7FSJ33kY6bRtmc8hBEXc2EhHG+XjBewpCFYO+18k2WGy5BArJbOOqO93O0crNdUvzUdFANfJTaKyBGoHx4i60raaBkiC7Cp4JhjkoNMg4ae1ULh4FBXxt7KIpVZ7V+Qc0AEH6aY4+JC5rfaHwxIYsw+GAx5M3/f4J8=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:22:43 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 15:22:43 +0000
Content-Type: multipart/alternative;
 boundary="------------U673doGRQFKhEgT2WH3AmxcW"
Message-ID: <120fc3a4-7601-4307-800d-bfa2637df81a@oracle.com>
Date: Tue, 8 Oct 2024 11:22:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 PATCH 02/11] acpi: Implement control method sleep button
To: Igor Mammedov <imammedo@redhat.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-3-annie.li@oracle.com>
 <20241007145950.0e53023c@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20241007145950.0e53023c@imammedo.users.ipa.redhat.com>
X-ClientProxiedBy: CWLP265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1b7::19) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: c6739884-94a4-444a-b317-08dce7ad0e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dytFY1B3MVJVVFk1dVMxVEpteWhUT2RRVWg4WktTWXVNOURhV1h5ODlPand2?=
 =?utf-8?B?OXRkeDgvc0JPUnk1OHpyaXVOMnJvU0YybmFHMGpIZGhBKytrVzd2bWVTWlQx?=
 =?utf-8?B?ZnY2ellOSVN4bmNYYzh6SnFtNXlWSHUxckdOQWJCOElXWW1Lc3Z2aE44UmFU?=
 =?utf-8?B?dmpuMDVwMWY5c0dleU5rSTlaU1FKVjk0aGxhZlNNaGJSdUorYm4xSUZBdDAv?=
 =?utf-8?B?UnpnZE1kdVBvTUxvTWF1U3Z3amN2MDhBNExCRU5samJ3RzRaT3J3SDdZdTdt?=
 =?utf-8?B?Vlc5bnE3YjNpVnNveXhFazBvZWpON0FMNHhwZCt6V215VThXL3hyYU5kV3JJ?=
 =?utf-8?B?UzlFYnNyVjZNK1dRaUpzK0RCSnFUMWpZeEhSVjFFZVpQQ296dlRjREpuT04r?=
 =?utf-8?B?L2Z4WW5KNkszR0NuSElDcDNLa09IMnFIZ2xEc1ZxcXZiRG9Wd01xSWNraGFp?=
 =?utf-8?B?YnlmdytNOFFOeG5wNEVxUjdNeUxYdlZibmZpcThReWZFNFRYdWZpZUpISVRx?=
 =?utf-8?B?RVMzd3RBalhucWRCbWVRSVJvY1ZObXE3RkhqOGl5QkFncGZNVmtVTXNNYUw2?=
 =?utf-8?B?OWdJd2orUnA1aEZQRmttRnNBRWJ2a2pPQ0lMZDNWQ1Z3Qmo2bXBJZ2dSa2ZT?=
 =?utf-8?B?c0FCMHBGL0lKQ0FpNXpJd3ViKy9UemVPS3J1ejhjWjRialAxSksyZWJEZzNC?=
 =?utf-8?B?bzVyZHEyS1g2RzA3SWhnV1ZnVFVqd1Fybnd4NlNIeEpNcjdjQTNKcVluQnVG?=
 =?utf-8?B?VUh6a3B5NDcva1VkR1FlV2ZsYVd4Mm9uMXlDVUxiaVM4a3dtTVhnMzA0OFZi?=
 =?utf-8?B?OTZNZ3E3VHFJdWdpQlltcUpLV2FPRWpEdjNFWlY1SzM5K2Y3ZEZtYUJlNEx0?=
 =?utf-8?B?U2ZPWnpWb1h0bXBZZmNhbGlMZkp3dGUvWSt2QVhSeTJVVGRkUWlpU2QrZjFN?=
 =?utf-8?B?NHo2VEpHT0hZVnFnNDdiRzVid1o5dVRwd0dnS0g3V240TlJ3V1Z5NEkreEJZ?=
 =?utf-8?B?YkYzajA0SjY2WGxGSlUrdTl1cUxORzBNZGJkY3JVcnpEUkJlS3MzNzE3TGZ0?=
 =?utf-8?B?MHZNYm1iZkRkbmQ3enBESjVGc2ZYenloc2lScGcreDMzaUJ2NWhnSzBMdFNw?=
 =?utf-8?B?eEFCbU53U1FJSnpwZDRGdGlnQmxITXZSVjNHQU15S3VZUVBnU3ZqdjV5VlBK?=
 =?utf-8?B?WkhEUzNjWFJJSytMcXdueGUvUGRZUlAwWTJBMEZFdWhjRnk5d3YveWNzSlVB?=
 =?utf-8?B?K0lPQVdNc2VnWHg5SzY4cnJyVWZ1czJYLzErcmJpS1ZycWI2YlU3SWpES2tV?=
 =?utf-8?B?RnEvaVQ3ZWRVdytHaFdnM3Q4MUo0bW5lcjExTHNwNG9NMkJGcCtuNzJYS2hq?=
 =?utf-8?B?dEdTVytkWXU3L3JHWUtEczBvZUQzYm5JcHVTMWlDTGlkalhWSDVaZGRlWDVq?=
 =?utf-8?B?d3JsWHRqK2VRTjJUNWRza1NNa0ZzLzA3QW9VODhaMGp4ZlNoZkQ0VDFVbXpT?=
 =?utf-8?B?QmVWS0NTcm5idktZcHVEU2NOTHcwTFVFbkVncnNvOFlMK2xkTm1BK2NaYUto?=
 =?utf-8?B?TVVUWGdJNUFkQjAwSjczbUE0RWFnNlBOTld3ekRtNlNpbWxGdjZuWjRjck5J?=
 =?utf-8?B?MXNGOVpzdEQwT3FZRmVEVWdPWTY5NUMwWi95M3dWb3kwcXZrMlVRTUUxSnNa?=
 =?utf-8?B?V3oxV2tvZmZTZUlwT25yVHhZZVVZeU56bEVjbTVZakdLRDZOU0ZSS2JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTV1dy9naUNxUEhrZ2c0aTdId1k0SEhwSFhEdVFJMzRPZlp6ZHZHZmdVUy8v?=
 =?utf-8?B?cjlOSFJlcVJFeFBLTUVzSjlzNERVZnI2Rm9PRHFBY1pSSHVQVTU0aHdneFU2?=
 =?utf-8?B?dThoRUYyRlh1YXpLWjFuVCtGZXdnOEFoOWViOFRCRFRuZUl4KzYyS0hleDZL?=
 =?utf-8?B?aHBaS2piVWJnT055SzA1K3JaQ3N3VzRmVmFieEo5Z2toR0tSWDUxcDlQMDZj?=
 =?utf-8?B?Uko3QXFnMFB2MXh3WnJzSE02RnpydmdRUmlBbXhUUUdmckhmTlliaVZiZUt6?=
 =?utf-8?B?ZTliMjExenFFR1cxWjVtUjNYQ3A5VmwrdU5lMnlDR0JtMnpsWlJrWkg4ZW5W?=
 =?utf-8?B?QnFTZGUxOUtyYlp3Q3NDWiswZkY4UWpSZmpoMnBMMVFlVlhPUGhycll1OWpS?=
 =?utf-8?B?WXpUQjFEZXp3TC9aTm8rcW56Y21abHI3OFY2QWFFMCt4Q2ppQnc3WTJvYlF2?=
 =?utf-8?B?UVc3YmJCRUFsTUhXMGZzMytlT2tSWW0zdUVpV0N4RUQ0ZFdmQlBxVlNZQ0dJ?=
 =?utf-8?B?ZFBsM0FTMXhlam1rSHc3TEtPNGc0TUFVWFRlUk9zci9nUWJPdURHTkdoalVw?=
 =?utf-8?B?cWhydzQyVXpmRmhaTWgxTnJNckNLVmNOcGFqYzAwZnMxTUk1Q09JMGJ3dm91?=
 =?utf-8?B?NzdVZ2dESjZyd2dRTElwOUR6cTBwTVhxOVRTeVM1c1FUeFZxeE1GTnFxVmNh?=
 =?utf-8?B?NW5WSUpsNlY5dW11MG54cDN3dXkvKzRHeE1IZFFJYmN5ckdEaVZEZS9iZStp?=
 =?utf-8?B?V0p4ci9aamc4dGR6YkVsR1JEeXdFbHRuRVJrUW9od3hWWEhKeWxyQlhQQThh?=
 =?utf-8?B?NmxOcVpqRlpEUGJrdXBwYUFUNmpVN0ZGTnk4Nk5nL0wrTnRveU9MUXpranhl?=
 =?utf-8?B?TVloeFBhY3h4VTM5M0x0RElRaVNqdmpUMWw0V1krc0M0ZzRSQ1gvdDhZS1B3?=
 =?utf-8?B?c1ZsLzJzYTA5TUlxUGJJbkFHQUk0dkQzcStZcmtVZWR0akwwd1E5dnZYbjlG?=
 =?utf-8?B?d1FuQnpaMmhFREF1ZjNxRk8zN2hzVGJ4WkJLU3k3OW5jeG04MnpobitPVEZB?=
 =?utf-8?B?czBJOUJUdjdvbGpQanA0RG9EbkF6OHFEQTgrd05Zc2VkblhReHFqelFrUk1w?=
 =?utf-8?B?b1BmQkR2ZFd4VUpTT1UrUldDbkEzc1RWWXRUbzNXV1c1Z3VUUGdQeEFQTUNk?=
 =?utf-8?B?ZDhRYWI3SHM2QmFYczFtM0pWZTdNaGI5c2ZPV3JPTzRXZlJOZkhkTkYzU1NP?=
 =?utf-8?B?TmlFeFNvWHJ6WVdBMVhjWitVUk9CdVBQcmpuV0RVN00rY2xjSUFBcG1idW91?=
 =?utf-8?B?NENvUlEwRlJGeFM3WFI2NmFtVXJZSzBSdFIyNVBjSE9FOC9HcGhxY2ZjRU01?=
 =?utf-8?B?UUxEdEV4cTdSRDMzK3U1NTVvYXpOYUNDSXBPWkdqMDd2UVdERHBISGdRaDU5?=
 =?utf-8?B?RXhMQWFSU3JiMk1MendxeFFLQURVN1AvV1FVNWtoL29GVmdyU1l4cUh5Qlc5?=
 =?utf-8?B?VG5WOEpsdWl3dGFlR2IwZ1B2K0N4UHZ0cUtwbnRqdW9RWU5FT1BYaVZUbU45?=
 =?utf-8?B?RWVoUm5IekhPc1djUlVtZW9lOVBQdHpnWnZlQWdrbkVwcmhmbmxuYllsd3Z2?=
 =?utf-8?B?QWM5Y21VRy9aVGpicm1tR1JzTVZVenhlQk9tdC9rN1lCRVFnVlhMazc4eTJQ?=
 =?utf-8?B?enJna2sxWDM0WW1hWUZzdDJ5RVViVmEvSDRPTEJjZ0J0STN5Y0luNnp5V2R1?=
 =?utf-8?B?VEhxcUhaMkMvZmpGTEtTRGkrdjdXcFUzbHNqaFE3SDhlbVFyQm0yZkFGL3pN?=
 =?utf-8?B?VjJ4WGZIcFhFUjFaQTZ4UngzUzdlcGhDSURqOFFQdGdONkxFVjNmU1BPMm5k?=
 =?utf-8?B?Nzltc3RnRExtUTlwdEtHZndGM0JNalc1WHVXUDNsUUYrT1ByUUk5ZXVPY2Nu?=
 =?utf-8?B?aS9nZ0VqcDZvVUlpbWNiL0NreDdabEoxaE9wTTVubE5kYjgrTUU4ekN4NjFu?=
 =?utf-8?B?YWk3Uk9RUEx4d1AyaE5zaVFlOTVHM3dRTFV6eXpRRm5LbGdLeVQ1RmdmWlZt?=
 =?utf-8?B?M25WRXdqUTk4K3YwWmsxclN5R1d1Tmo3SlZ2Wk9uNStZN0x5ZUlaWlpMZC9S?=
 =?utf-8?Q?r0FmAxetF9lYWwon+odBfH1jz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A/XsGQ32qFx9yRaJQ1n89vB+j7E0538aKCQJeBKv6ueCJOjvFb/Ff/4HJzRpRn6Eht57hXzf0R628h8WnROOERV/REK7zTQgeSm7lzTl3ZhyXYKQ4pqMy2xLdoLKqJUc45f6B4dML8r7ybHJhsX3zc/IT6wBbFJGLYxIY3FtdaHObZCSS4iJr2VnTHwRlufJK92Gw4c4kfbMVq2nktW3kYs/unRUsfY9zcE2QY1/r8f3XSEYB+BTIWGcvph2/D3rCTPXLo3lEx1FRzL4Y34SRWR3rWmjJzdudMx4YoPXpwwpLWbn4+Ui18TMpVgf+UgHq+P8IBJmbcVRDjAWfD9iQgaPwQjcfKslRmwu/XZlS6VAx3mWbqzs2oo5DZSdWSYgiOglrNMMuHwD0StBmL6buJZS9M1bXlvtNOUADyhCKdKgwwdzdhW5vQ0YJ0l2SJBEj22jOlo5deUO/7M8YtxasZ1OQkyBNMidUhymFDakSVOGtKHn0z4V5rXzIdH925IoBRG+324vBLtObu4ddJ6XfYiH84QL/ks1e5JYkGaXUgnvy4DLqn+2mYEnSKdJ7z3o4Aox50a9HLIMDgJGDeU5YtmvuGEutxlhCEwKBwrI+S0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6739884-94a4-444a-b317-08dce7ad0e1a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:22:43.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLTLoul8JsrJHT2HMiXFd5YCR3/r2U39l+iWg4jZH+4tzgwT5gd1+RY1xgF8xQ7xvmszvl6amE0D5/bEmR1BEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080097
X-Proofpoint-ORIG-GUID: i9jp_J3rgsBb6N49iW3OiscYRQKUlyHf
X-Proofpoint-GUID: i9jp_J3rgsBb6N49iW3OiscYRQKUlyHf
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------U673doGRQFKhEgT2WH3AmxcW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/2024 8:59 AM, Igor Mammedov wrote:
> On Fri, 27 Sep 2024 14:38:57 -0400
> Annie Li<annie.li@oracle.com> wrote:
>
>> The control method sleep button is added, as well as its GPE event
>> handler.
>>
>> Co-developed-by: Miguel Luis<miguel.luis@oracle.com>
>> Signed-off-by: Annie Li<annie.li@oracle.com>
>> ---
>>   hw/acpi/control_method_device.c         | 54 +++++++++++++++++++++++++
>>   hw/acpi/meson.build                     |  1 +
>>   include/hw/acpi/control_method_device.h | 25 ++++++++++++
>>   3 files changed, 80 insertions(+)
>>
>> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
>> new file mode 100644
>> index 0000000000..f52c190352
>> --- /dev/null
>> +++ b/hw/acpi/control_method_device.c
>> @@ -0,0 +1,54 @@
>> +/*
>> + * Control method devices
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li<annie.li@oracle.com>
>> + *
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
> replace it with SPDX-License-Identifier like it's done elsewhere
Nod
>
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/control_method_device.h"
>> +#include "hw/mem/nvdimm.h"
>> +
>> +void acpi_dsdt_add_sleep_button(Aml *scope)
>> +{
>> +    Aml *dev = aml_device("\\_SB."ACPI_SLEEP_BUTTON_DEVICE);
> drop "\\_SB." here and below as well,
Make sense here since the scope parameter is "_SB", but for the "_SB"
in acpi_dsdt_add_sleep_gpe_event_handler where the scope parameter is 
"_GPE", I suppose "\\_SB." is necessary.
>
>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
>> +    Aml *pkg = aml_package(2);
>> +    aml_append(pkg, aml_int(0x01));
>> +    aml_append(pkg, aml_int(0x04));
>> +    aml_append(dev, aml_name_decl("_PRW", pkg));
>> +    aml_append(dev, aml_operation_region("\\Boo", AML_SYSTEM_IO,
> use some sensible name for opreg
will do
>> +                                         aml_int(0x201), 0x1));
>> +    Aml *field = aml_field("\\Boo", AML_BYTE_ACC, AML_NOLOCK,
>> +                           AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("SBP", 1));
>> +    aml_append(field, aml_named_field("SBW", 1));
>> +    aml_append(dev, field);
>> +    aml_append(scope, dev);
>> +}
> also above and below lacks any documentation,
> add comments for relevant spec references, like we do with other ACPI
> functions. Also perhaps, it's out of order, reviewer has not clue
> where from above registers come and how it is supposed to work.
>
> if you invented those registers, there should be a preceding doc patch
> that documents them.
>
> Suggest to reorder after patch that implements above registers in hw,
> and also comment here where to look for them.

Thanks for the feedback.

Thanks
Annie

>> +
>> +void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope)
>> +{
>> +     Aml *method = aml_method("_L07", 0, AML_NOTSERIALIZED);
>> +     Aml *condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
>> +     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));
>> +     aml_append(condition,
>> +                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
>> +                                    aml_int(0x80)));
>> +     aml_append(method, condition);
>> +     condition = aml_if(aml_name("\\_SB.SLPB.SBW"));
>> +     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBW")));
>> +     aml_append(condition,
>> +                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
>> +                                    aml_int(0x2)));
>> +     aml_append(method, condition);
>> +     aml_append(scope, method);
>> +}
>> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
>> index fa5c07db90..0b4f1b432d 100644
>> --- a/hw/acpi/meson.build
>> +++ b/hw/acpi/meson.build
>> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
>> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
>> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
>> new file mode 100644
>> index 0000000000..87f8d6fd59
>> --- /dev/null
>> +++ b/include/hw/acpi/control_method_device.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * Control method devices
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li<annie.li@oracle.com>
>> + *
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +
>> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
>> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
>> +
>> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
>> +
>> +void acpi_dsdt_add_sleep_button(Aml *scope);
>> +void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope);
>> +
>> +#endif
--------------U673doGRQFKhEgT2WH3AmxcW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/7/2024 8:59 AM, Igor Mammedov
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241007145950.0e53023c@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 27 Sep 2024 14:38:57 -0400
Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The control method sleep button is added, as well as its GPE event
handler.

Co-developed-by: Miguel Luis <a class="moz-txt-link-rfc2396E" href="mailto:miguel.luis@oracle.com">&lt;miguel.luis@oracle.com&gt;</a>
Signed-off-by: Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
---
 hw/acpi/control_method_device.c         | 54 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 25 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
new file mode 100644
index 0000000000..f52c190352
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,54 @@
+/*
+ * Control method devices
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
+ *
+ *
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
replace it with SPDX-License-Identifier like it's done elsewhere</pre>
    </blockquote>
    Nod<br>
    <blockquote type="cite" cite="mid:20241007145950.0e53023c@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+ *
+ */
+
+#include &quot;qemu/osdep.h&quot;
+#include &quot;hw/acpi/control_method_device.h&quot;
+#include &quot;hw/mem/nvdimm.h&quot;
+
+void acpi_dsdt_add_sleep_button(Aml *scope)
+{
+    Aml *dev = aml_device(&quot;\\_SB.&quot;ACPI_SLEEP_BUTTON_DEVICE);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
drop &quot;\\_SB.&quot; here and below as well, </pre>
    </blockquote>
    Make sense here since the scope parameter is &quot;_SB&quot;, but for the
    &quot;_SB&quot;<br>
    in <span style="white-space: pre-wrap">acpi_dsdt_add_sleep_gpe_event_handler where the scope parameter
is &quot;_GPE&quot;, I suppose &quot;\\_SB.&quot; is necessary.
</span>
    <blockquote type="cite" cite="mid:20241007145950.0e53023c@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    aml_append(dev, aml_name_decl(&quot;_HID&quot;, aml_eisaid(&quot;PNP0C0E&quot;)));
+    Aml *pkg = aml_package(2);
+    aml_append(pkg, aml_int(0x01));
+    aml_append(pkg, aml_int(0x04));
+    aml_append(dev, aml_name_decl(&quot;_PRW&quot;, pkg));
+    aml_append(dev, aml_operation_region(&quot;\\Boo&quot;, AML_SYSTEM_IO,
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">use some sensible name for opreg
</pre>
    </blockquote>
    will do<br>
    <blockquote type="cite" cite="mid:20241007145950.0e53023c@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+                                         aml_int(0x201), 0x1));
+    Aml *field = aml_field(&quot;\\Boo&quot;, AML_BYTE_ACC, AML_NOLOCK,
+                           AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field(&quot;SBP&quot;, 1));
+    aml_append(field, aml_named_field(&quot;SBW&quot;, 1));
+    aml_append(dev, field);
+    aml_append(scope, dev);
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
also above and below lacks any documentation,
add comments for relevant spec references, like we do with other ACPI
functions. Also perhaps, it's out of order, reviewer has not clue
where from above registers come and how it is supposed to work.

if you invented those registers, there should be a preceding doc patch
that documents them.

Suggest to reorder after patch that implements above registers in hw,
and also comment here where to look for them.
</pre>
    </blockquote>
    <p>Thanks for the feedback.<br>
    </p>
    <p>Thanks<br>
      Annie<br>
    </p>
    <blockquote type="cite" cite="mid:20241007145950.0e53023c@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope)
+{
+     Aml *method = aml_method(&quot;_L07&quot;, 0, AML_NOTSERIALIZED);
+     Aml *condition = aml_if(aml_name(&quot;\\_SB.SLPB.SBP&quot;));
+     aml_append(condition, aml_store(aml_int(1), aml_name(&quot;\\_SB.SLPB.SBP&quot;)));
+     aml_append(condition,
+                aml_notify(aml_name(&quot;\\_SB.&quot;ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x80)));
+     aml_append(method, condition);
+     condition = aml_if(aml_name(&quot;\\_SB.SLPB.SBW&quot;));
+     aml_append(condition, aml_store(aml_int(1), aml_name(&quot;\\_SB.SLPB.SBW&quot;)));
+     aml_append(condition,
+                aml_notify(aml_name(&quot;\\_SB.&quot;ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x2)));
+     aml_append(method, condition);
+     aml_append(scope, method);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db90..0b4f1b432d 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
new file mode 100644
index 0000000000..87f8d6fd59
--- /dev/null
+++ b/include/hw/acpi/control_method_device.h
@@ -0,0 +1,25 @@
+/*
+ * Control method devices
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
+ *
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+
+#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
+#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
+
+#define ACPI_SLEEP_BUTTON_DEVICE &quot;SLPB&quot;
+
+void acpi_dsdt_add_sleep_button(Aml *scope);
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope);
+
+#endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------U673doGRQFKhEgT2WH3AmxcW--

