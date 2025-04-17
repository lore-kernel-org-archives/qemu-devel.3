Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73842C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UJD-0001du-HU; Thu, 17 Apr 2025 14:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UJB-0001S6-EY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:49:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UJ9-0005DM-JD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:49:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMqHi027588;
 Thu, 17 Apr 2025 18:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Dui5k3uoMQxn0PUc9kzZ5AaewX7xVf1/yk23+dgieTQ=; b=
 J3CRj9BKRQWFPvqKhOk9ksoRDYPDw5xGx62G7VNnq1OIzJApRaBBWrTrPd3RtFBG
 YnonbaljSf8hxebi2BlxkusovbqkB3lCWi5w+LMEtWQ37R3QQNQIQUbK5Z8h+Mjt
 wd+7En+z53H8BV4QbjEmhLS4QCdsoX07pZqg4Owses1drIixaxaFOpMyOfPJ0KA6
 vcol9zwtle8fNuvZaD2gz/Yau8GEXtidchhByv9dn2Fryru8CUPxFAwCK2VNYUbm
 yHM+uHchz4A/07rzLIU8ih/3tSttj8xsv7qG2zkR08yMGvrAvlHLHuwSTHBm0eOw
 a1+I4kU0SrRhdQ6YGXutBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617juf63y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:49:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HIGoLJ009161; Thu, 17 Apr 2025 18:49:48 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3nncj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D32yEmV6qWD0XSTNAgNC2WRtWGWgVolwMpMMRaYv+mTFGYKGRW0k8XhienF0ADyzsW0YFX4EX6oKeWROHRDUar2QyNMy/fABlhpScINjcgSIP3Ggr+BBVX7VS5tsfoLS9yDu9z1O+RHUL2RHu6lzHAwx62oSlhv2FXQYbyVJZ7EMiKqtNFkmQ/6zz7XxOEO/dY+0RLafyW8ertZraIDjXEdNN2OaTJ+uU3Tov7o6o5eGB0gc+zDae5Ysa4uj+b0MKShebjUQMpOwDCvkJKjsZwo6rVjNIyD4F1QYMSyIilfsh03B8CNxq36zm/J8Xjj/eQIsbdC+ZNDnb0YZltuLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dui5k3uoMQxn0PUc9kzZ5AaewX7xVf1/yk23+dgieTQ=;
 b=THSr7CMgzAJiNqWl+Rb+ahjMLfhRXuocm1x4fSISQWvIBoIj+0ElaJL9Gzv6UEGV6flvNXY72g2xHS32G7xGmbuppmq68+Mme+Y28ZDf/ag479xt60t3YemD1YhGGUZh1vMwZI9gM+5t4TI18qj+drSeWS6aOS5Hmi0n8PggJsT4uCmV2OmccjsvFmk9X+NGnYcyks+ehtMWwsL/f0w8EgqI/JWeaODP1H1xuhSGMS9L7J+zHlljW5s0zqgItSLjt20KU0+aOn07xouHZh4HtVPWHDencBggToxt3De0KmzsCLYpwZUcRLsNqDjKUd+EI/oBFqI0woxilc29rgIKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dui5k3uoMQxn0PUc9kzZ5AaewX7xVf1/yk23+dgieTQ=;
 b=VemU9mtBTAlnEMjlCee+p75m8C/vxZlGgj7Tby9034DHGBYTHS3Ep6a61ArL7cNlgNCC3/Qs5H9f1+OAnGrLgA/dh13NDY3MWfWKYJUFySaBNiPtDsXrslWCPaPterArl0PTztxOZ0WwJFO6DKBeEHfhntfrghPZYNTp4/M8Itk=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS7PR10MB4927.namprd10.prod.outlook.com (2603:10b6:5:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 18:49:45 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:49:43 +0000
Message-ID: <6db7d45b-66c9-4a41-b567-45fb16f679cf@oracle.com>
Date: Thu, 17 Apr 2025 14:49:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 09/13] microvm: enable sleep GED event
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204335.2999-1-annie.li@oracle.com>
 <0ba24f2c-7636-4fca-af34-a332863c0e03@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <0ba24f2c-7636-4fca-af34-a332863c0e03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0727.namprd03.prod.outlook.com
 (2603:10b6:408:110::12) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS7PR10MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec03e09-d209-455b-54e0-08dd7de09de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFk2eHpzZHhUUmVCUkQzckEreHdDMlc5S2Z6ditwbjZQRnZkUXJ3WituNEF0?=
 =?utf-8?B?dkxQTjl2ZE9KOG1pdlNvNDByNVdoaDJkb054R0lzdUYrdVVKcXgrSGo4SFFr?=
 =?utf-8?B?TjBOZll2OUV3SmdWWDFSSm5Tbm51di9zM1Y5bXpZY2FzUTNPTm9nc0JOUDZR?=
 =?utf-8?B?Z21FMHQ3bkpHdjRpSVpIa2J2T0VMRjdqeWVPeGNlNmdlYm40SWFrdnZwVkYw?=
 =?utf-8?B?ZTFGb1hMYTlUZGpicWNNZGV1MHNFUkFsL1lHUXc3QVRZSmFKZnVtTWMwMmla?=
 =?utf-8?B?cytpNDIxdUZMREJ1cHJHanpzNUNBcWdSTC9ObGt6RWVGNTRmK0N0WnYrQSsw?=
 =?utf-8?B?K2tNcXRqR0J1WEI3SlZXRkJLTkJlNENXU1VFK0kzMS81YTNYbkRHdWh6UUJS?=
 =?utf-8?B?c1RuMWtDYnFJMk95ZlpVT0RiV1NQaWRZZ2dUaFhxM25VWjgzdWRDZzg3YUNS?=
 =?utf-8?B?UkJxTDBiQnJmYVRiY3o3NXZhVDAwYzRUSUZ2ZXBUWnE5dlVVYUFsSnlTUW9L?=
 =?utf-8?B?RjdFb1JheWtFbkxPb1FwU0xSZ1NkQ0tmbXpXNFhZblBXLytzTlJnTWZjYU9V?=
 =?utf-8?B?WVQ4Yk1VY3BTSlNPNGh5STYvQlFhTGJKdWJoYzdIQlhxbU82Q01ZaUxTZ3pB?=
 =?utf-8?B?cjRvWVM3MXZQQkFUeUVnRXpkTUlOQU1JV256cm9rVC96UTZzbEw0Ty9TbVN4?=
 =?utf-8?B?MERIRkFOZ2V6M2U0MFBYYkVkWTFZWlVYK3ZGZlROSjM4OUIydVFtdUtVWlEz?=
 =?utf-8?B?ZVZFRXZHYjRsOHJBTHhOT2VLMGVHa25RaGQ2eGdOWjhYdnpiVWhhWlpwZmp1?=
 =?utf-8?B?dnNaakk1S3k1ekJRNUJPQWRzbGp1cGhSY3hVSVRqR2szeFdlZWZDaE5uVC92?=
 =?utf-8?B?U01mMGVIMlNheUljamNKZ0lpZXFic21qK3V6NEJ3Tk00akZpQ1FDTm9HWU5G?=
 =?utf-8?B?N2VJS0U2VXJRUXNGd2xtaUlZZ2l6ZWU4eEsyU2RXSU9wZ1FxRThiSE1nbmFV?=
 =?utf-8?B?MnBjbWhnSTNzVTdJc29FSnIrK1p0eThxbGxqdEp0RGJhVFAwVzZKSVdXWkl6?=
 =?utf-8?B?WHJFTXAyd01UMFEwT1NnTkVyT1FnS25jMnpBVWJKdm81cW5IMkdUbStYMmFU?=
 =?utf-8?B?YWtWRk51WnhiVkRpaDNyY0U5dzljOVhHNkhmMWZpekRWUVZ0cWI4SkJaTC9D?=
 =?utf-8?B?cFEvODYrNFZmZFJUS3I0c29RdVNNUEt5ZDBWQUFneWxXYUFkVHRrSHVoN0xQ?=
 =?utf-8?B?ZW1nUFpaS1oxMm8wK01CRVlGendUOVR3U2F6VEh0QUFLNUR0Y3p1ZFF3eUF2?=
 =?utf-8?B?RWNqTVhNbFlTbEE0Nm5kRXNJY1RYSTdSMm54QUlYL1VWeVJCZjBveEhWTXpm?=
 =?utf-8?B?VmkrM09xRytES3E1V2FFd0t2ejlibHd6U3EvTVl4czBWOUt1WjdHSlBqbGxn?=
 =?utf-8?B?QmlVdHhQd2xJNUxxSXdja2ZGeUp4aUtXRXJNeC9ZQ1BGdUdWVUlickhpaGM3?=
 =?utf-8?B?T3RPeS9mUmZtNnQ3dTVoUkFZOGhxRVJvM3A4VTNha0JjNGoydlZjYUd0OFdu?=
 =?utf-8?B?Vk5EQzJFdlhrY2plY3hOL3NGSUQvVEFRMlI4R1V4V0N4eW1uMUMrMElqUW5J?=
 =?utf-8?B?cTVFRFFHbXJ6c3NoenBMei9QVTJ6cWFQT2xnaGt1aU9YN3VMVXdOWVp5Ymcy?=
 =?utf-8?B?dkxIZ3Zrclo0TUxrYVIzZmxHWERObGpCMmVkVlVMbG5CRGErM05KVnUwbmI4?=
 =?utf-8?B?SDdxT0JrcGhkMmpwcWxPTmhYRzRpZkt0SXYzWGlzbFVwWExJQlM1NGxFRkdK?=
 =?utf-8?B?QXl3cFhackZvOWp0U01MOXFiL2lMcDI4Uzh5UEpLWHZFWjlWS0tReWFlanEw?=
 =?utf-8?B?OGNMVGk4UXo5Yk9yckx3aWVUMlQxa1RHMk8wbXFxdEpoVWZqNHgyM29TQWdi?=
 =?utf-8?Q?BscLDcx5Z14=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk5Ha3JQajFOK0pqYURQR1FmQW0zQTk4MGZkcjBYK0dDMExXQkIvc1J4a1Jv?=
 =?utf-8?B?aE9tQ3A0RWpSVWEyZTNCbnlHOHdnT1NsTU5tWGxHZm4vZ3FSLzVMQ0JSWWV1?=
 =?utf-8?B?L1BMcC9wQ0t1SmZPdVJFSllrbGRMVG1ZWWJ5RVk0Y2lHT2lRN0RrR3J4eXRN?=
 =?utf-8?B?ZStJT3V0TjlFQlJ2RDNkazFBSjNkeE1HYTM5d1V2WjlTcENGcHJsMldlZ2lw?=
 =?utf-8?B?SGRKbGNVSFN1VyttTGNURXBKU0R5TFgvYjg1UkRBa2NxbVdzaStkaEJCMWpO?=
 =?utf-8?B?WkdVSjVsN0tYWnZ1dHNQOWZPd1dVNElLbDUyMGpMQXVMUTZpekZjZ0lvSWU5?=
 =?utf-8?B?N2pzeFREOVV6b0NIeHMyeGVPWTEybmJnT095L0FJdnpKYm9WUnEzdDhrRjdJ?=
 =?utf-8?B?VVdzSHltYkZWMnROOUJXTDhTZXZTVzZwSmFHZDhIWVNQYlBDN1orMHAwUXlW?=
 =?utf-8?B?c0hxM0VWMWFhZWlBaHBlUjVKOGNEQys1K3JqSFJES0l2LzdvMjdOMldnZGVz?=
 =?utf-8?B?SXovSzJyTVpKN0RkQXZpZ0RoOXBlZ0dwQWZBSHBEVWRMTjRjeXZ6V2NEVFda?=
 =?utf-8?B?ZTEvamVhY3d2U1A4VXdnQnFJV09tMzB5SHBNR3A0SFJSQ29IQ01KaVRkVWRD?=
 =?utf-8?B?WURDeDFhRDF4V2x3UHh2K0FmT2lNRjMyVXJzbzRMeDNWUmdFNEtUWE9DM0ox?=
 =?utf-8?B?U2NyVEw3Mmt1R1gyWitRM3k2VGhZN0RJQ3ZJTHp3M1BWcFRTN2dBMVEzd0pH?=
 =?utf-8?B?WmxGYk84cFVQdHRMbnZGOEp0aUFlVzNQOHA5bFVGSElhL1Yyblc4NTB4WUxH?=
 =?utf-8?B?cWRpZjE4ZWZId21OdHY2d0xZSkRrN3lNS1lJVVRLUndUVmw3dHlUeVpSUlFT?=
 =?utf-8?B?enp4c0ZNbmVUNmdCSlI1akg1aThPYXplWEk0WWNLRWpOWGFRcFA2K1FORU9v?=
 =?utf-8?B?dXhFQXArRUE5WmpXb09haEh3L0RYb25vTklrMHYyc3EzZkVQelhZQzNVTTJO?=
 =?utf-8?B?S095ZW91WHFqcWxweGl3L01mL01DMUF5VHJEWW55RVVRcG1uTjNGQjkxWWM3?=
 =?utf-8?B?UUtKZmtLUWRUSXRqcXlzNDZTa093RHp6WGpyVTVCY0NCSEZGQnFBWU5jZDhK?=
 =?utf-8?B?SytDRGdnd08xRVNXTS94dkl6Qk9vTFdNck5CWkxpRERJbDhKQkFnMjlwTXJT?=
 =?utf-8?B?QkJWTVR0OEU1ekhGdFFNdmFkWndkVjkwaUNUbXhoV2RPd0ZCTjlJTC9wdlhX?=
 =?utf-8?B?WWNRR1VxSWdvRmYrOUpKYjBZRW8wVWdNSzQ5UVZpRC9XeUNHT04wa1dHS0F0?=
 =?utf-8?B?ckhndWc5WGIzRkt5WlRpUVlwWDhPMTluazVkTUZhc2Y1M0FyMzhWVHF0NHdr?=
 =?utf-8?B?bDZueGo4dkdrckk3eDBDODdyZW9LbXJ2dHZKOE9YRnZLTUUzWUFnT01WdUlR?=
 =?utf-8?B?ZG9SZ3cxWWdad01vUkl5MzNDYURVT2pQa3g4QW9xYnl5emd0ckZNbXA3MCtq?=
 =?utf-8?B?LzU2QVkvL1pyRkxnNTZyZkVtQ1YyV0ltVVBHaHg3SndhdGR2djM0a1dUa2dN?=
 =?utf-8?B?UDFtSUpxVlZ1U0M0K3lsUm1Wb3FUWnd5bG0rNzBnZ2h2VFhCcHp5bkUvSmtt?=
 =?utf-8?B?UExkUDAwV3lOUU1rOEFaaERCSzMrWDJWUVl1TUt0WW0vSmlWa2Q1VGhqY2RX?=
 =?utf-8?B?Mm9pZTdWa2ErbzE4ZkFPamM4SWU5NFRJK0gzL25BLzFoeksxQ01pTi9HUkN6?=
 =?utf-8?B?RmhhZ25iVTh3bkg4VHVHTjgzR1IzaXB1RWRKVzRRa2xYS0JQSlhuZCtKMzM0?=
 =?utf-8?B?L0J0WGhkcmlEUU9ITTNzd3NCZDVMUjR1ejcxK3pHQWJQemxMcGZKZ3dRSjM5?=
 =?utf-8?B?V0liNWw0bXhOcFEvbmxQeFhVSWJWNjAwaWQxN2UxSGE4eWcwbXo4eGFLQm81?=
 =?utf-8?B?blNhcjFZOUgwMVVycC93THROVCtXRldFZlVwKzlia3dtK1B5bW4xcmhhOWE2?=
 =?utf-8?B?QVV5cVNTYkU5QnFBSzdiSjdxRGNLcHIyd1NOeHcwZkkwWlZ5bzh6MktOYnNt?=
 =?utf-8?B?N0xBdXNkS2ppTGVjN0Mramt2alE5RFJuVnlCSjJPU1h0WXpGSmVIZms0NnJo?=
 =?utf-8?Q?VEZDmM5EFuIq7i8SwYWYjDw4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2QUpY+jYtGOzm966KufqNqLywl3dAx5jAsh0v745t0AI+/E/3hHktAt2HT/M9RJGxRc1oDhqNtfzJ5z2Ef4nVnVGhc28Fsloq6i0o6lBO+QkLzzldufVNYqvama8eWuYF9eUSId3gnf/k6uk+VJPl/u+0hAK9g4Zve4c7kYhFtZ1Goh+QZ7hLs68ccgm9lxuooeCM/Ue5NFfWR99HjfCxx9MQwXBle+PKgTFB/JW2sy5vNdcoGxAn5NaEw7aacYEg9PwczU2a0sy2OWzqskrsGSLoZuG50L9RmRMvtBgevxen6XXuxSX9BGS3RerpDF1EdK0jzb8bcDeb3/9Faos8oMOb2kqLyLnHo4Chp+wASqI9ZpKftx032cBbNpu2syXGaEX5TtG0OX6J+ZuGpkYfB0fpMzziO1ZfG9hAQmiS0BnIK7F3NNWWXnqEqBzrDv/ikfhgCq3hym4l8vJpxM8crl8LPRKIf2amj0i+iJZaJZB6L/Y8SzgF/EYe6jfgvIANUZV9CmhAP68zoHXUPBbdEHd0Pe7AW7wV2eDC/jLXdcGYe0hzxqsqQHt6Xx2OpCEzrfguHarLZDztyHiuk1uNoURbOvf+Q0T13bEJlBxzjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec03e09-d209-455b-54e0-08dd7de09de9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:49:43.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i6TIRYrNany/rgEwlvL1DvRFo1usaMhAyW9g4jHghz7OtrPxQeKs02Pi4xUyabMqPDFZBTMGW9wKjMw6a7YUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170138
X-Proofpoint-GUID: sscXoThwkW0UTePRrf5Y8p-fEkJpY1gi
X-Proofpoint-ORIG-GUID: sscXoThwkW0UTePRrf5Y8p-fEkJpY1gi
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:35 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:43, Annie Li wrote:
>> The sleep GED event is enabled for MicroVM. Also, the system
>> suspend is enabled when the GED register is set for sleep.
>
> nit: in the commit messages, please stick with a single case
> for microvm (or MicroVM, etc).

Will fix this.
Thanks for the review.

Annie

>
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/i386/microvm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> index d0a236c74f..eba33c4365 100644
>> --- a/hw/i386/microvm.c
>> +++ b/hw/i386/microvm.c
>> @@ -205,7 +205,8 @@ static void 
>> microvm_devices_init(MicrovmMachineState *mms)
>>       /* Optional and legacy devices */
>>       if (x86_machine_is_acpi_enabled(x86ms)) {
>>           DeviceState *dev = qdev_new(TYPE_ACPI_GED);
>> -        qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
>> +        qdev_prop_set_uint32(dev, "ged-event",
>> +                             ACPI_GED_PWR_DOWN_EVT | 
>> ACPI_GED_SLEEP_EVT);
>>           sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
>>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>>           /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 
>> GED_MMIO_BASE_MEMHP); */
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo

