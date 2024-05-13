Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A03C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bPA-0004Rx-67; Mon, 13 May 2024 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bP8-0004RZ-5k
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:32:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bP6-0000fq-3X
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:32:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DIsdmo005693; Mon, 13 May 2024 19:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HFxs6aAuHVEe5jqwKKAvUwsfYeq3hJEPSHVS+QjOqGY=;
 b=HbqiYNeYd+YOnGCGsMLDt9KnMaj1C7JVND8pUEqzG6G+t+ZlYomO444LMzCt4s/QqvuI
 VpfdMrvoaKhClorE5FbLpFaKQ+gE9TcU9HiyY5AbqPnC6lqelRiC6DnnLm1KVrE7ZdZD
 Ks1x5Rf6UaPvRuQS3YpcK2SZP2oMjh/ihHNZbUcHp6CSdpYdarRqSiyZ1d+cToa9e0jA
 YHhTVq8bWmAN9YwYSE4Ztqq1eMaZDlcvxkXq4/BKEUnyptZ1cJLQxsY6bK19L08XHwMY
 rSHt5mJyppxxlSrXJoPHaxayxKzje0zwvSIln6W+Bn3+YqGWdINadMHpDgW5zZFH9Sit Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3q2mgc1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:32:02 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIX1Xp019385; Mon, 13 May 2024 19:30:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y3r83t2sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvtFqQDZra+D5Rj5dG99gDItgrhT1g6GR7KltR/xo1hAds7PlyvATGJhk2gGy1Uqb/hbcP1mvlCEYFH2MkA3wQIQGBwyNB5qPcPFC0TI8cDuYhXtOj7t9+GebWejGrORCKsuYO1t9G+z4kRjDXWiIcBIjF97P87I2au1NLIP92PTzW/EzeKzar/YB/TNPVJKeOB1/z1VVD9MU6//xaOUPsh1Wn7wFmLQ+/s6EbuBViNUYLMpsNBwfLwcYp5EB51ztb2HZewdAYEwX/FCz79EH7WxWoYMWUlPHCX1pBpdmEZCeDqaMEPztV3ik54deZgZMAZd2WSgH1Hu/NMWfCbMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFxs6aAuHVEe5jqwKKAvUwsfYeq3hJEPSHVS+QjOqGY=;
 b=LfS47Km4vjh18Hlhn/n7LqK7FRVT+1eGRFezP/6ROu14opm7AT8BrWx5YkRL2MJGjxc34nlm+O+pc+xJ/wPgNy2DWbwg0NhJQCRnXhukWxowI/xqJqR+xRGHWrmmqNDjeKqHwxGxtvaqoXtUUIqq+5WGalXZ6Ak7o3R7eXVRNJNBXkSGtEnA54H12d5/Ralf1VmhgI6oj/0JEMFqtcGNLBJ1zrNeOsbdLt9dO4D6II2yHnJwJ0GuNG4jKtthNR7MOfpM+izeuvOiCBm3yqViTbaLf/s8H5eN/Dj9Hg01A5OvjtTBJTH7ki6imodLA/Qw0IZ0nfUqedyRXujzH5RQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFxs6aAuHVEe5jqwKKAvUwsfYeq3hJEPSHVS+QjOqGY=;
 b=VTLIHv30pCWbyHnfTAxo2RuyF3aEt5hw+dEK+HCMOL565ATf+GqYp8klTEHfSFdjLU395eY3sEzhw8nFJTzVemyvC54VHFMmfw1v6livEEpHIOjCqv5Rt5FBrkMrffEWjdhPPNN/LJtshq9nlQ3Wv+ABsdKDGl1ysOqs9fUxbEQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:30:23 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:30:23 +0000
Message-ID: <c054111e-252f-44c7-9cb5-77c6127176ba@oracle.com>
Date: Mon, 13 May 2024 15:30:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 13/26] physmem: ram_block_create
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-14-git-send-email-steven.sistare@oracle.com>
 <87a5ktfthx.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87a5ktfthx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c437c0-53ad-4fb6-0524-08dc7383222f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHZtS2xXWDF5dm5UZGdzZUw2KzV0VjZPczR2em40YUo2NVlYRTZ4Qk54NWlJ?=
 =?utf-8?B?T0MwVys3LzUvUFM3ODFaWkRwVW41VGVXYi91dlNpS3hHWDBGRjE1aXFEcFFL?=
 =?utf-8?B?ZHA0bDBlR2hxSFA1RW5ST1cwUnlzOUhrbVpWSDU3VWh6cjVpWVQ3Z1BBTXFi?=
 =?utf-8?B?U3ZWcGRNMlkrOGw2TUlUTE5DcGdsM1NORnMzejZmLzg0T0RuUXI5eHpmMFlQ?=
 =?utf-8?B?TEh2ZmVXeVJYNmJ3d1o0akVGWDNiRXhQZ1B2NUJiQUYxV2JCUFlVaWF0YUVI?=
 =?utf-8?B?c3daQkVKSGNEVE1NZ2F3Rm9PUDVqNkw2YTlZUkxHdWExK0RKVUI3NVhRSVph?=
 =?utf-8?B?ZjMvOW5GbUNUb05wek1tV0N3RUpsSEhRdktCV09aeWEwUVVrVk15aXVxN2ZL?=
 =?utf-8?B?WjZJQytkRWphbm5wTTFJQjJJdjFRbWhKUVdPYXFPM1JWQ2dWMU1YYVU2cmpF?=
 =?utf-8?B?SXdLb0RKa3pQM245QTY0dysrUlNsYnFCYk5pV0xZL3djY1g0blBJeS9PVnpE?=
 =?utf-8?B?WkZpdmVHanNwS2trNnZkY0xGdWU4Z3UvYXBTQ2JuRU1jWXhpN1FaTTA5cndy?=
 =?utf-8?B?RkVnY01kYXNNOW1xNzRET1FXZnJ2ZnJsOG1aVHpWNFRFMjdvNFdObkt2TzZF?=
 =?utf-8?B?ZExWd3EvVDJ4YURWcFlLM0lCVUlFUWZ6d0p0T0xtUTByQUJXYzVtOWY1VEtT?=
 =?utf-8?B?Y0VpcW5abEN6NkUzaTZNT3FsK0VFMERCcXFKV1hQM0JvaFV6L0xST0NUSzhv?=
 =?utf-8?B?WFhHNjRXeVNVRStzNDk0dVB3WUw3UWNpZGFzOUFoZzMvTUNLNmRNMFJwRi94?=
 =?utf-8?B?UmtieFVKQ3BzRzZsMzNXMEdGZ2VOeFFFWmVrRVh3TUw3UEFVVitwNTFPSHUz?=
 =?utf-8?B?WFhZT3U5NTVHWlFremFmaURGcjlzUDF6OXZKVVRPckU1NlpKTkIyR1dvOVBV?=
 =?utf-8?B?REhLbm5majVQbG01ZGk0YzhJdFZzZmh3ZVhyR3ZKSEZuSENsMkpabU9nMzFX?=
 =?utf-8?B?OEVpMFJBVlFDZ092N1dKNkZ0MTRUWWhRU3RQUHljcjZSM2xIWjJIL2J5QWRi?=
 =?utf-8?B?TDJrMEFUOXFyWWJkaUVLWHFkblFCMGlKOGw4UWcwMS9JMkVEcFZ1K1lSajVP?=
 =?utf-8?B?VXZWZ3dGWFVPSUpvM3VFQy84UHFEYUtPeU5wLzkweEpMZ2I1emRBOTd1L0xp?=
 =?utf-8?B?RVNsOG4vK1o1RVIzZS9ubHFvQTJacWpXZWlxQUNUNmZyUmFLeklibms4eStL?=
 =?utf-8?B?Ri9WV0JQeUFHTDUyTTZCWU1ZWVhlWXFJTVI2WSt5VGxBUjBQd29rOWxqUTlY?=
 =?utf-8?B?akZqNDltcUJjbEthZG5kZXhsTklhQzlzaFpPYW5vbnQwNWpRaFROSjZqWjBv?=
 =?utf-8?B?U1RYcWoxNWsxVW5SS3lBbGJTWTVHVE05OGY4TFpLTjhsME1mUUJlNUhLYXJv?=
 =?utf-8?B?dXlyWTY5b09DcWVxTm9pdmJXRFR5RTdCZ3dmY2lKdXk3VTJDS0ZrUkthMExo?=
 =?utf-8?B?TVJtQUk4QlZhTXJGSVZxQzZhMWlBSWlWR3FhTVF0dkttWEhnS3BRRDkvUVo2?=
 =?utf-8?B?OGhzblllZ04rYTFRUGlSOFpodkwva3hrWXk3U1owaENJbnB3NG4xUXVhejdK?=
 =?utf-8?B?eFk4NElhOHY1eUZGa1pWdTJTRWQ4WVB3MVhKa21UbDhyQVNaN0xZbGtOd3Zl?=
 =?utf-8?B?ci9aV0lPKzBaZGsxQ3RJcjlMUm5yVmJJUm9qci9ab2hGcEV0bU5oV3ZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVON3pIRHJraDk1K1pEK0JvNHJMR2l6blBwV2hEc08rZ1NzM25HOGZVbUxG?=
 =?utf-8?B?Z25INGk0dWUwbk5sMk5NQXEyM3puRDlSZGEvQzJrcHE1Wnd4Um5WcVlyRXlF?=
 =?utf-8?B?bDBRVnpDQ2NsTUpVb1F5bXFOY2ZKU1dkU3ArNmNrZ3ZPWjlIb3l0aFd6YnJw?=
 =?utf-8?B?NjVBSmU0R3JPRzRIQjBKNzhqelRrZWM0VlE0WEovdXdBNXd1eENuN0xYdVN1?=
 =?utf-8?B?K2tKYmFzYjNSVXVzNDVPRWRNQ2NGWDRaTGVIYkhKWnVRR3BpWXlRTVlWbTg0?=
 =?utf-8?B?eDQ2aHlUZEFYczZVbi9McjJJVXBmdUQ4VFdFd0hFV2dOUHh6OXBSdHNJWGZt?=
 =?utf-8?B?aDJaSm1waU9DcXZnS0szaTNRaERWbTFZeG5MdEJNNTk5Y3k2Qzl3T2xhb0d1?=
 =?utf-8?B?N25DRHRJMkNkY3duTzJ3MU5zS0k1MElLa1VqVDNzUWxYdFpHTi9WcVdUd25G?=
 =?utf-8?B?bDBxY2dvRXVpTUQ2Mnc2Y0pSeldZSkczMXUwN0ZzWnVnMEdJL0tVd0RRWlZz?=
 =?utf-8?B?QjdWck1mT1ZTRFFndWh4anc0MjhMVjdDcEdBYkkrSHhMM1JsQU1EYmJGR3pt?=
 =?utf-8?B?ZmNXY3FhV2JvZng3NzRSZGdoRnhwY0U1dTg4SzN1UElBanExbUJSK0Y5TGhj?=
 =?utf-8?B?cVoreGVUcWxMVUdneVN6OWRxc0RmQVZaakxPZVdHZzF6cFdldnNSZkp3U0VO?=
 =?utf-8?B?aEdyS2d5NVV5UkVYK0Ricm9aamVtSGNHdzc0UWJIbDZuM0xvU096S2NZRmRC?=
 =?utf-8?B?aUN5Z0pGc2t0Z2ozY1BpcmNJNTh6dDVITWV3T1RYSGR5NkY3alA3MGMwWnNU?=
 =?utf-8?B?VVIyU2FXVEpWVzdiRnBuODBRSDRUQWozbDBUWXJRTHRQT3U4VDFHR3l6Yy9w?=
 =?utf-8?B?bW8vMmxFamdzR2Q4Rlk2Vmh4bk8xYWpUTVMydXJycmpIR1dPVnZYenZUQ1ZZ?=
 =?utf-8?B?TDYrakVXaWtaL090bzVFKzNUM0lRaTFxZWVua0p4Wnc3aFZNRWxXQ004V3I2?=
 =?utf-8?B?WC9JZmZXV0RsbmJueHNhd3VLdFNzSzZnTVNVZXdQeGZwVld1M01lNTJZbE5t?=
 =?utf-8?B?eGJaN3lIaFloeUdPdXZGZXJzMnlua2J4UDFQQ0hrM2ZCUDhmeEY4cHdUdWpw?=
 =?utf-8?B?bWI0QVBXa1BmRzJXSDN3OVdoZk82dVcvcU50a01KYm11Y1pVdExncUhiQzlX?=
 =?utf-8?B?dFJtY0xGM2RRdlhzVnFuM1dTSFlsU1QrRE0zdW92MGJPZnJ0aUF1K2U1amtY?=
 =?utf-8?B?MHNpRVZ5Ryt0S1dxcWgxeWhhcS91T2kwTFlYUnYvWnVrdzlnMjg3QjArM2pG?=
 =?utf-8?B?b0RXd05HeXZrS0lSYi9HODg3VU00bHY5UjliMXF4RW9zZGNyYVM1eVUvQ2FN?=
 =?utf-8?B?TmFneXZsR1ZwTmlEbDlpMlkzSkdLWU5mZmN2c1daUkdTamVsRGN0ZFNxYit3?=
 =?utf-8?B?RWlsckIrTzhqalEyRFg2OUlXN0hpS1JoODBWeEZzWWpJbWZ1c2xuWnZ4L3lN?=
 =?utf-8?B?Z2IxZVo5MnE2cXZRcTdtZThUa0o0c0g0SzlIL2I1MzZJVThQbThRNGIvL1ZM?=
 =?utf-8?B?MGxxNmswZ3hWSlY2S3ZPVFZTL0J5ek95M0RFWUhRSzB6WEo1NDd6Y0lPbmtC?=
 =?utf-8?B?K3pNUlE0SWx1NEIzK25XazM2dFRpNW42Si94c1VhNGlrUkZrcGVRV3lIU1ls?=
 =?utf-8?B?MkRGamU0ZFFwWnkzb0xSVlFpSjNid1BrYXpDc0tHUU9YTUNJT2VPYVVjdkI5?=
 =?utf-8?B?Q2xBMFE2Z1FobEJqbnppM2t6dzhlY3FJN0Y1Yk5ZckRHZEhoM1Fnb042RHhW?=
 =?utf-8?B?ZWtsRXhEUFdsTzJHWWEyRW5reWhUdlpLMTFlWGVJUGVtUnVWcU5JajdoNGRJ?=
 =?utf-8?B?SHdpWTRRaHBia0Q4bUJFMVRlU3JmT2RrUU5ISy80WnVuR0MvbEF2SGhlaWpS?=
 =?utf-8?B?WFBINXNObG1YSmhzSGVLbk1NME5UWEs0UDI0OWZiTFg5UUdSRVdrd1FwbDQw?=
 =?utf-8?B?ODdiL1N5VWV4ekRoTGpMeHBVa3hVVHVtSlFvZXFBNnNVa1FjNEl1aVhWYk1k?=
 =?utf-8?B?U3NJUWoxRitBcXpyVEFiK256VHl0R2gySUErUmpoZHAwUzRncExPbm40SmVF?=
 =?utf-8?B?T0FtMEh5RWRsN09CS1N4YlFzemJiQkFYaExUaGtEYk1sQWdKMFFwVXVyZUF2?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: klVUn+br7M1Epno82qn6eOOE5tZM2Uf/CqHZlhoy6RnOwp8OnlsDrn+yDYFbJM+X0ZYeoae5RDJEimSg7tPlk2ZamJubDk2/m/uSN5/6MhhbOB/6mGnKQJnTOyAjG5yBcuyZZ3iIPdIavJkpPugns1ueKknQwDNIf+bJrcrCR9LCrebLShRSCvpIpemSOs+UUKgP0+f8bikzP/t4Io+TB8xvJSkVupqomCwEZi1bqJlkQ4jBQ+0Q7vzUdPxRvwxxpZLvV9l5z/ShfzH/KTTHGiNKc68N5tNg4Ah75Pazs36Z+oZbsZc4D1Ry7nKe9rQt5nnwovmu4oISowuQ7nKKZWVmUT4szCy1SYltD8yt0WRTFrZdeJonBlJzWbf2QpNRuwE+LYI8JFTFKcK1AvQ2muryxJnhFBuKbxX1vF83fAi4oQCy9w6Jyucw7pcPBKZsW1KTzt7d+2SyLu2hNMhNTHGTiqyjT2rQxS1bJSITh6PVLHv0TQqGmubh8twq3yQaEbut8fTasbgO5P5C/RfKbZ7xFCJZo8xV+ATp8GoAFc3ZHrmsbH2KJM9Ul2t8kh4cAU7apwOnKsBhNEZQLy5MBE65NnMWGrNaJJbZAS/9JX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c437c0-53ad-4fb6-0524-08dc7383222f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:30:23.2337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDemhsUPwwFL+29oOXs78U6AGVlZC0JU2xmJlpOtstURH8vDgkHBv+C+wJbIX7p/Q/ODoCcIxr9W3fu9wzAzAxCTff7W1pjp0uyUb682+a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130132
X-Proofpoint-ORIG-GUID: 10_zvfpoAO2qv5nGsOHrTQ2fiw0RBtRl
X-Proofpoint-GUID: 10_zvfpoAO2qv5nGsOHrTQ2fiw0RBtRl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/2024 2:37 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Create a common subroutine to allocate a RAMBlock, de-duping the code to
>> populate its common fields.  Add a trace point for good measure.
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/physmem.c    | 47 ++++++++++++++++++++++++++---------------------
>>   system/trace-events |  3 +++
>>   2 files changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index c3d04ca..6216b14 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -52,6 +52,7 @@
>>   #include "sysemu/hw_accel.h"
>>   #include "sysemu/xen-mapcache.h"
>>   #include "trace/trace-root.h"
>> +#include "trace.h"
>>   
>>   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>   #include <linux/falloc.h>
>> @@ -1918,11 +1919,29 @@ out_free:
>>       }
>>   }
>>   
>> +static RAMBlock *ram_block_create(MemoryRegion *mr, ram_addr_t size,
>> +                                  ram_addr_t max_size, uint32_t ram_flags)
>> +{
>> +    RAMBlock *rb = g_malloc0(sizeof(*rb));
>> +
>> +    rb->used_length = size;
>> +    rb->max_length = max_size;
>> +    rb->fd = -1;
>> +    rb->flags = ram_flags;
>> +    rb->page_size = qemu_real_host_page_size();
>> +    rb->mr = mr;
>> +    rb->guest_memfd = -1;
>> +    trace_ram_block_create(rb->idstr, rb->flags, rb->fd, rb->used_length,
> 
> There's no idstr at this point, is there? I think this needs to be
> memory_region_name(mr).

Thanks, will fix. That is a bug in my patch factoring.  I add the call to
qemu_ram_set_idstr in patch "physmem: set ram block idstr earlier".

- Steve

>> +                           rb->max_length, mr->align);
>> +    return rb;
>> +}
>> +
>>   #ifdef CONFIG_POSIX
>>   RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd, off_t offset,
>>                                    Error **errp)
>>   {
>> +    void *host;
>>       RAMBlock *new_block;
>>       Error *local_err = NULL;
>>       int64_t file_size, file_align;
>> @@ -1962,19 +1981,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>           return NULL;
>>       }
>>   
>> -    new_block = g_malloc0(sizeof(*new_block));
>> -    new_block->mr = mr;
>> -    new_block->used_length = size;
>> -    new_block->max_length = size;
>> -    new_block->flags = ram_flags;
>> -    new_block->guest_memfd = -1;
>> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>> -                                     errp);
>> -    if (!new_block->host) {
>> +    new_block = ram_block_create(mr, size, size, ram_flags);
>> +    host = file_ram_alloc(new_block, size, fd, !file_size, offset, errp);
>> +    if (!host) {
>>           g_free(new_block);
>>           return NULL;
>>       }
>>   
>> +    new_block->host = host;
>>       ram_block_add(new_block, &local_err);
>>       if (local_err) {
>>           g_free(new_block);
>> @@ -1982,7 +1996,6 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>           return NULL;
>>       }
>>       return new_block;
>> -
>>   }
>>   
>>   
>> @@ -2054,18 +2067,10 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>       align = MAX(align, TARGET_PAGE_SIZE);
>>       size = ROUND_UP(size, align);
>>       max_size = ROUND_UP(max_size, align);
>> -
>> -    new_block = g_malloc0(sizeof(*new_block));
>> -    new_block->mr = mr;
>> -    new_block->resized = resized;
>> -    new_block->used_length = size;
>> -    new_block->max_length = max_size;
>>       assert(max_size >= size);
>> -    new_block->fd = -1;
>> -    new_block->guest_memfd = -1;
>> -    new_block->page_size = qemu_real_host_page_size();
>> -    new_block->host = host;
>> -    new_block->flags = ram_flags;
>> +    new_block = ram_block_create(mr, size, max_size, ram_flags);
>> +    new_block->resized = resized;
>> +
>>       ram_block_add(new_block, &local_err);
>>       if (local_err) {
>>           g_free(new_block);
>> diff --git a/system/trace-events b/system/trace-events
>> index 69c9044..f0a80ba 100644
>> --- a/system/trace-events
>> +++ b/system/trace-events
>> @@ -38,3 +38,6 @@ dirtylimit_state_finalize(void)
>>   dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
>>   dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
>>   dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
>> +
>> +# physmem.c
>> +ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"

