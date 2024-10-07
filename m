Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187D8CFB459
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtSS-00035h-17; Mon, 07 Oct 2024 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtSP-00032d-7h
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtSN-0006J0-GL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:49 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMa2Z022202;
 Mon, 7 Oct 2024 19:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=lt398wqi/hmH/WMBVlKe2SKvD0oBWrT5+XsYrkROBRw=; b=
 bJmBxbmmq9CaROWXy89tlsg3y+AA5aTtFhuyTvbs7RyTwrKgss3dChb/KR6DQ6JS
 l7Zh9rDZwKHfaAG1r3XbbzMeN3OrO71slyS6God0xAN5wUPta8rMOpVH/e4KqQQo
 +/AfIH1hmtHx7MF6CgbeA0FApKmwU0EFXw+GqO3Gc8+vkLVS5L8c4U2iLswZcKny
 gla+k8BF4lJIcNaxkx5O1vpZDmDOdExtBomfvwxSoBTAmV+Xto6rAVSFYm4aVu1u
 jRnQjE5KBkTFkuXhWmdep/Ge2dimwkGTsbhVQctGPiA79Tk9GMmvsl2y3LFYWn0Q
 lJV5eDH4OM8Audupt+0lRg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034mcrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497Iepqb024883; Mon, 7 Oct 2024 19:31:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwcgmww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvGjsBRgqwUaFRAbYCi2cy9zXlgGMswlAXniNVkXHGq4RdSCwsmabvHDkfdQ6x+JnzlGjM9SG9gWIHTtFY8BOgRH7RPUUvyOM4S5wUqhr6IpABLm8voXpCVgs78P3t3fjJSKpREe6+LZS9DRsq8de3AW0yyfA7xha4zh6xyHWBWWNgdp+cdNaLL+yfyT53tjFjIhhMgj4cMSSZh6vn953OpDYP3BmFOkVFWki9B3b7o1wVqp+IK9cRbbdsMYJ+P4J/FJuA2Wsdc7TfRCoznLXoaFMthb6w3QeqVtSmbRWkQEh7tCoUdmd2sE7+WRLKgcWD2vvAQn3wfdzryl2EwfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt398wqi/hmH/WMBVlKe2SKvD0oBWrT5+XsYrkROBRw=;
 b=Wf6fdyivgVR+DE+HPKxk6rZXfVOaMBOzAwwA/kTpHb/9Wol1YJJrmwX00O/9jNQqeSSU9SW+4uKvDruODc0+hYAZz/bpnUY52Dc8nuLu4rUrwnW9qYr8Cq+BTjn0QCDRVyrG1jYvYysyz2zBweS/5s/N9O8yaQIr8IvJHJ2roeXHQIqyXCCjFWeHZlQ8HuxRFSi2P27MvvI0JRn0hoC3wTaf+wLzo7Vqft82IBNqK6kXx79rYNR5LMhB/yp2eWZMFC/t4BGfwHxn0i8m5IEEg0IV0rsx6DPRSd6/DDe3cV5p3Ux5RkxEX8/bXyx/CNQgtRVkMtnXpINK84hL1325jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt398wqi/hmH/WMBVlKe2SKvD0oBWrT5+XsYrkROBRw=;
 b=MbaEBPS8hNDIkGB8urZKWILpQaqXLF1ATQfHfB9twf7+y0KAD/JRoCHianCHWNRwH5W0f5Au7d0Yvrs+oc9qyp5S2YHGOXn99srCJpaaSYnuv1DmrWFR9acfHqa8QXOFMJDN2EYLve5yYhwSzBkj9jSBlioCO/Lq4/0Jy2zZHG4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:31:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:31:38 +0000
Message-ID: <d64d4399-3a41-4440-aabb-935401746837@oracle.com>
Date: Mon, 7 Oct 2024 15:31:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/13] migration: VMSTATE_FD
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-9-git-send-email-steven.sistare@oracle.com>
 <ZwQOChgaKst9uCZn@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwQOChgaKst9uCZn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c737a64-1510-4480-4c2b-08dce706a9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnZkeVFkSGRNVWQ2S1IxL0lVQVBMLzNzSklYNGJ2Z2lmYUZpMTZGM2laYTlN?=
 =?utf-8?B?ejVST3NHT0FCcERkNkM0L3lNYmltNUs3VWZpa0tZMEhPaUtIV1ZBRHFZQUNK?=
 =?utf-8?B?V2llSXpKRzg3c2ZaOGJBSTM3Y3NweVBQSWU2OXBkRDNkVHVLeDhBdnlnNFM1?=
 =?utf-8?B?ZHdGenBmY3dvOFVWMitCWmZ4dnBvS0dKQy8yRjNRQnVXU25qVFd5K3BocWFy?=
 =?utf-8?B?QzBHNmtuUEZYT05oQkZvZXN1ZmlsRzJ2MkZPQmhhMlU3a0VaYjZjYTVnb0tu?=
 =?utf-8?B?N0ZyRlJaZGp5MzNWSG5aUGNSc3BjYjN6M2NIUzBTcGs4Z2sranM2cjZSQlNP?=
 =?utf-8?B?L1NPRzB3clExUVZwMndQY3B5TVhJQjBPNnVyblFmKzIzaHY5NW80Y0J5c2s0?=
 =?utf-8?B?ZjNKa2t0dnkzV01KOE1RMDdEM0pscm5ndkJKSHZseDdDd1FiZlZmQmR1VWlW?=
 =?utf-8?B?SE1FZ0x6MG15bVFVY2lOZE1jczRLOEo1R1J2MlpSNnRwby9ZVXltVlUydHNp?=
 =?utf-8?B?TmVwem5XY0ZGakdhSEVWcm0xdm5KWFR5d1lWN2dEOUgyenkxNENKOVNzNUpO?=
 =?utf-8?B?engwUTR4NVF6TGZ2MUd2QkFXQmRFU3hIREI4NldrNis2ajk0bHRleU84TTc3?=
 =?utf-8?B?OFFlUm1RZ2R3eElGQjZwcWdVK0IrQzRMRnUxSm1wcEplUTMyWFo4cUpWV1Jr?=
 =?utf-8?B?OGU3enBCdldkb1djUURFcWpiN0cydGk3SERRb3ZoMzFpVHE3TmFpQndBVExF?=
 =?utf-8?B?VXZPWU1qTG9Od21MOHRyR0wwZSs2QjNsUFpXcExuMDNHcFE4SFRPazJhdjVl?=
 =?utf-8?B?aCs4VmZqVlNhK3ptNFhQdHIvNE5VS1d3Z3FjQkE4Z2hOL2JnNDdLZWlCNW5S?=
 =?utf-8?B?NlJXQlNSdUpETTlZTWlWSXpoVS8vR2lINnhOdGZ2NU02WFNWUytBZjFzaXVr?=
 =?utf-8?B?VU9OYUJ0WE8rWEw5M2xBY1Bnb2JzY3pzTkV0MEVrSWV4VTFic1hkRHdBWG9v?=
 =?utf-8?B?ZWJJUzRjRHIyVDg0R2FJYUJVSGl4UC9oeUozNWpabnRoU1RzZ1JkNngzamhF?=
 =?utf-8?B?QW1URWdZZDdRZzkvdndzSFdLck8zWEdqK1ozUnRVMlN1Vkhhd0ZZLzR2S0gx?=
 =?utf-8?B?TGRGUHZOTUlTSUVKZUZBSnBWTDYybHJ6a3NXWTAyMkc3bXpKRWFnRW1XdjV0?=
 =?utf-8?B?ZGkrb1hiU2lzcU4ycnI0dk12aGt5MC9nNU5HMWZ6bFltejloR0U4UmtPdHdL?=
 =?utf-8?B?enAySzVnOG55VUl5bDVLdnZYSDdrTmpjNExvZlVlRVpxS1JLWCtaam0ra05v?=
 =?utf-8?B?cmR6bVk1RFRWcFQzQkc4SjcyRTNIWksvNXQ4NWk3OEV0MXRINGp3YXJNYTZh?=
 =?utf-8?B?TzRiTXlzMm9UNllyd3JHdERJTm5rWFYvUGd6ZldPU1hsYUhpUHkvTnYwUUtz?=
 =?utf-8?B?SHZlaWJpdG1rUkdCNUNXdnV6UC9lMDFyYkxTbXVnT1RDYllpaEhQTC95MmYr?=
 =?utf-8?B?eGpqQ1NQVXp1WVZaV2grZUNIYmw3dzREa2Y1UUE2TjhJRlR3Z3k2SUI3ZEI3?=
 =?utf-8?B?dzJZL3JQZWtDN2JUMCtLYktNN29ZclNGaG1mbTJPNnpqY3hMSmhubm9ETnNJ?=
 =?utf-8?B?MGtySFZUcitFWHRvaVpCMFZ1STgvRDh5djlSc2NnY1VOVE8rbEN1Y1haaTdW?=
 =?utf-8?B?WGIyV1hPWVROTzlJc2FRejFab2s2TVErSTZYWnY4cXhsUDlZakM2cGVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDd3a3Uvak1Ea1NrN0IvOFUwYWh4cEo5SVUyS2F2NXZtaWJTYWd2ZjBVejNn?=
 =?utf-8?B?TVd3Y1JHb0lNZE9KZm1rLzRxVnUwbDMyMDlmS2t2blNOYVVpVGpLZUdRd2cw?=
 =?utf-8?B?S1I5L1NLYnZNb1I4RDM2THI2RXFCbWRNc0NNOEdGWEdlRUJWZzhwdmpKcUNi?=
 =?utf-8?B?dkJIV3F0emtTUkp3YTNxY1dRdlJvUU9BWDdTaWEyYXZZeXVxNWIzUm9TbEdu?=
 =?utf-8?B?Vm1URHpXaVRwYll3T1ZFRCtoRVNVSG1HSXlsaHh1cUExblBXWXczUjF2TGNC?=
 =?utf-8?B?R2twTlhoeGFDcTd0REZ4M05yMm9QRCtVenZYa0Ura3E1dllRY3orWDlwaVpv?=
 =?utf-8?B?ZWszeXJzUWszWDhRVTMrTjhrZWZaWmRmVjlDY3JoQ2ZIM2hJWUVyQVJWTlU0?=
 =?utf-8?B?VkxCQ2RHVlNES2JiYlBJTUFOV3VyMVJoZjFiRStBMVBIS3lnb0w3MG04Y083?=
 =?utf-8?B?UmV2MmRPdmpzUEVmZ3VCREtxWUF3a2NLNjJrV0d3Z3pmbVdRUDY1Qzh5SGx3?=
 =?utf-8?B?bHJCNE5QWVFKUmJCNmZCV21weW82Mmdka2lXVVhSeFVkeVQxdmQ5VGxwQ0ps?=
 =?utf-8?B?NWlJRXJGdmdnbWd6d28yTHJnZjBxaHNyVXlFMU5razRLZUN5a2NQdTJVOUlw?=
 =?utf-8?B?VG5EREhHYU1IRzVIaS9NQlhwVWJzUjlTNkZ6TEVFS25zOFdzYllCdVVWOWtT?=
 =?utf-8?B?NnBkSmNOMWNYYW0yLzRZWWZEK1FPaVQrcEtxa3FDZUo1blBGZGdhODE3bkJw?=
 =?utf-8?B?V0ZVb3piVVFRQldaODZZaXBHN0N5RWpHUy9VakpzdHJHNURXQStnVFZidWc5?=
 =?utf-8?B?T0Eva2JXRGV2a3p2NXh0aUNrMVJQV2tPcktCVEsrZFJDRFZ4c0lueHJFMU8v?=
 =?utf-8?B?WUFTa2tyT2ZFMnZadnkzSXhhTDVaS0hvTHp0SU5ZUDN6TVlIUTVHSWswUmFW?=
 =?utf-8?B?S0U1ZlA5VDdFTS9NdFJSSUFsemR2SDhmWXRZemp0QlJGYVU0VG1IUVh0dENT?=
 =?utf-8?B?dVN6V0dvaFc0V0xadDZSL3liYXFCM2JSdTl1VytyVGF0WnVSVk9kcjR2ZG1w?=
 =?utf-8?B?TU5zZmh0ZERCZU01RkNFSE91NkVvVVVBbDI4SjRUdmw5L0lUS0hDMi9aMEs0?=
 =?utf-8?B?cmtUV2VOR1kzZEJXRG5oTGZlOEVkQTYwQXBBYXFpZUh5dW9PUnd1VkdkVHlV?=
 =?utf-8?B?YXo5ZHR6bVV4M25XWSt1d3dlUXl3cmwwMFRjUWh1cDdmZnA3V0t3M05Sam03?=
 =?utf-8?B?UXF3RVp3N1FwL1BwZGgyeWt3enBiOUFlWnZtUjdLa3puK3NJQkYySVE3UFNs?=
 =?utf-8?B?dVlyTmJOaThidHEwMHJtZmN1S3QvYlVhby9CYWZOM2RIM3NpcHUyT2pieW9l?=
 =?utf-8?B?akRWa3RIanoxb3pmMGx2YVN4blBMRmFYZWFLdHdLSWMxVWtoQnJOekNQZXdn?=
 =?utf-8?B?SEg3bEJFaVNLaEg3cjRpcE9rYkgvZ01zYW45Z3FoOFRRVGVUN3R0UURSck5E?=
 =?utf-8?B?aDJiTUZ3U2l0Y3pIdHhCWFQ2VGdRcTIvaUd1Nmk1QnpSdmhaOGdqUGhNcE9U?=
 =?utf-8?B?V3JqdWdNNFlzbzgrVnNzWFU0WFJXTEFyMjFQRFlyRU5EWlhsc2t1dDNaTEVS?=
 =?utf-8?B?YmRKRnQzRFZyOHFSdjk0c1dELzU3TGY5dGlEMnhMTFR1NzhGTVg1aUJabEo3?=
 =?utf-8?B?eXpzMHdRYnFCd0hxVzZSeEpsZE95bXNWM0VHYzQyaXpsSnRndHpzK0JXRm9a?=
 =?utf-8?B?dEllWWZENXA3WFJycG95RUtzcmdJQXA5cGNuL0xUd3FiZis1WWh5dy9YaTR5?=
 =?utf-8?B?c2xZc2xpZkZtQ2wzb0dUUDVWcCtVRkhEUDZyNXcxN0FBOGVMUnBxTndyQXJK?=
 =?utf-8?B?ZWgvajd4RnBxMFl2WkJFSHhmbkZFYlF0TWxTSG03QWZSMU5NaGFQQXVqQ2I0?=
 =?utf-8?B?SFVqUHVWQ0doVmErNE9OeCt0NkN3cGlwM1YwbXBZUzMzVFBpSGNYWjl3Q2lI?=
 =?utf-8?B?S0dpaWtEeE9yNUl4VGxqNUJMcnNZamgyTWhFOUY3a0d4MXhralFETTlWNmxy?=
 =?utf-8?B?NkpNMU5EbXlwcFh5WVpFdHVvblo5U243WXkrcSs1VTBqc3hRLzN6YzVpZGsv?=
 =?utf-8?B?YWhTb1hiWGFJbTdxYzR3MWdQM1JVYkVDWUF0NThSZ25JOEtmdlVMK01xN2tK?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nEzgGu/MGw5JVPceJTNa7dk2QOtUClhYwxVKUtMbAk1o9OpEUWWcoxE+HeYS/PPnHlHPF/g4pZGHuqSk2gfSQaidLT9kas413T0y18z+cV0k3AZCl6HKnVZtuEIOrw5Plc5+SKpz2FzxQrDJUlxWVdW5HW3TQfD4pgRK7/ywtaD2DaGXpm7JOo7Oz7V++bjyuTmPW0ZUb65TO9aBNOWw4L3ADYYz2TzsOMr1PQobr6g+nkiPwLKRrp+ZLyjGAq/qhrSJEIuAgyZShhSYa0PC7fOQeAMYJPWrz8FEyvFa/Qcb+Ye3tgnm/aprrHXGhOYf4FcK/my1J/QZLRCbCtd4O/B5C1tWBNNvON7ya4ZljOdImqm2h4GskI/vVaA/CrVkS8mpd78Ctg6fjbYmgvCcrQbYk8HeIa7m4gQCV+0X/1QANg5v0750U+E7U6KxmdaqfvvvQSQQqnc1jcnppA0TUKcelluY53xu00a6wsiiIbEV0qwlD4YlopTGl4zcralKJF3hWOp6KSbPfSPwXQ1p2pYT9XycPGU5M2mPLZjiD56rr0sAO+9l3NKU+aWiCdZvELPNjyYxamrmuLccMl8UxjCzzMaqjnKgxVO+jCSbzQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c737a64-1510-4480-4c2b-08dce706a9b4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:31:38.4311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiplXpg/sawe8AtZPJcVOw5kp9537/InOqik8E6MNckpm7r55klYNP9ks+YCfs+X1PVgXk0pk0FGdcscIT+aioknsJGcTEsMlddhuHdAEjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070134
X-Proofpoint-GUID: LKRDuFK__jb-9w-W4dyBN9HHBMOeo0OQ
X-Proofpoint-ORIG-GUID: LKRDuFK__jb-9w-W4dyBN9HHBMOeo0OQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/7/2024 12:36 PM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:39PM -0700, Steve Sistare wrote:
>> Define VMSTATE_FD for declaring a file descriptor field in a
>> VMStateDescription.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/vmstate.h |  9 +++++++++
>>   migration/vmstate-types.c   | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index f313f2f..a1dfab4 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -230,6 +230,7 @@ extern const VMStateInfo vmstate_info_uint8;
>>   extern const VMStateInfo vmstate_info_uint16;
>>   extern const VMStateInfo vmstate_info_uint32;
>>   extern const VMStateInfo vmstate_info_uint64;
>> +extern const VMStateInfo vmstate_info_fd;
>>   
>>   /** Put this in the stream when migrating a null pointer.*/
>>   #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
>> @@ -902,6 +903,9 @@ extern const VMStateInfo vmstate_info_qlist;
>>   #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
>>       VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
>>   
>> +#define VMSTATE_FD_V(_f, _s, _v)                                  \
>> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_fd, int32_t)
>> +
>>   #ifdef CONFIG_LINUX
>>   
>>   #define VMSTATE_U8_V(_f, _s, _v)                                   \
>> @@ -936,6 +940,9 @@ extern const VMStateInfo vmstate_info_qlist;
>>   #define VMSTATE_UINT64(_f, _s)                                        \
>>       VMSTATE_UINT64_V(_f, _s, 0)
>>   
>> +#define VMSTATE_FD(_f, _s)                                            \
>> +    VMSTATE_FD_V(_f, _s, 0)
>> +
>>   #ifdef CONFIG_LINUX
>>   
>>   #define VMSTATE_U8(_f, _s)                                         \
>> @@ -1009,6 +1016,8 @@ extern const VMStateInfo vmstate_info_qlist;
>>   #define VMSTATE_UINT64_TEST(_f, _s, _t)                                  \
>>       VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
>>   
>> +#define VMSTATE_FD_TEST(_f, _s, _t)                                            \
>> +    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_fd, int32_t)
>>   
>>   #define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
>>       VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index e83bfcc..6e45a4a 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -314,6 +314,38 @@ const VMStateInfo vmstate_info_uint64 = {
>>       .put  = put_uint64,
>>   };
>>   
>> +/* File descriptor communicated via SCM_RIGHTS */
>> +
>> +static int get_fd(QEMUFile *f, void *pv, size_t size,
>> +                  const VMStateField *field)
>> +{
>> +    int32_t *v = pv;
>> +    qemu_get_sbe32s(f, v);
> 
> Why we need to send/recv the fd integer alone?  Can't that change anyway
> across migration?  What happens if we drop this (and the put side)?

This is a remnant from cpr-exec mode, where the fd value did not change across
exec, and SCM_RIGHTS was not used.  I will delete it, and I will delete the mode
test that appears in the "cpr-transfer mode" patch:

     qemu_get_sbe32s(f, v);
     if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
         return 0;
     }

- Steve

>> +    if (*v < 0) {
>> +        return 0;
>> +    }
>> +    *v = qemu_file_get_fd(f);
>> +    return 0;
>> +}
>> +
>> +static int put_fd(QEMUFile *f, void *pv, size_t size,
>> +                  const VMStateField *field, JSONWriter *vmdesc)
>> +{
>> +    int32_t *v = pv;
>> +
>> +    qemu_put_sbe32s(f, v);
>> +    if (*v < 0) {
>> +        return 0;
>> +    }
>> +    return qemu_file_put_fd(f, *v);
>> +}
>> +
>> +const VMStateInfo vmstate_info_fd = {
>> +    .name = "fd",
>> +    .get  = get_fd,
>> +    .put  = put_fd,
>> +};
>> +
>>   static int get_nullptr(QEMUFile *f, void *pv, size_t size,
>>                          const VMStateField *field)
>>   
>> -- 
>> 1.8.3.1
>>
> 


