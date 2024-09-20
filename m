Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75678CF9C5F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srkDb-0000cJ-9c; Fri, 20 Sep 2024 16:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkDW-0000Of-O6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:27:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkDU-00048u-U2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:27:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItWL0005868;
 Fri, 20 Sep 2024 20:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=st0AgsvWhBiPXCg9BBfP9gZ+r7VkDHXhK0TR5fymHVw=; b=
 WSGGwBcUxLdrA1YnbD7mYj3wIpoPvH1eoQow47LsnNZz1yMv87JcHwIAAZBCiGHb
 QaSymmd4TcirAeOjs6lOmswLaEQFirVnjdBrd22LpIq3i/85cEeh0BcVhgZylBLr
 KBNlwEfKwdoAyXK/G3bkt1sOAEvmuY4N2kogXYo6dSj7GSD4fnM8ELYE9p/rmbXv
 LralGuU6S7xJnb3V4yOS8ISVUToz/jZdLjBKfHNzEvIi9Anw08QGk9LFhXcwxmwO
 UCXP4dcev56jViqJDOWMQgA1iE3wKKJke1IfQfWjJt3SGVhN5Ar6bCHszGtlpf3m
 doFmPdAi4AZyYC9kQV4Hyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfyr5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48KK91Ju008294; Fri, 20 Sep 2024 20:26:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyfgn6ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyB7asiHFWZHX0i07e+4VTeDENjQbsFxnoFRkxr7LtjEtU+JpmWE6+i89wNLUBK105y71p5XaBwpGUZtqqryLfvpRoJr+WmyZLy58lLdzShfoQWRl91SK/aP9RIo2fz4g7nVA0Z2lU3qLqO80yPUYjrNw3pjnHLjkUOBRxJvCdoWMImc+ozHx9SBe6fkRjGAaYdRFjQgaH1Fr8a5I5pNs5gaYVnmxuLzGpka2Om+b6kaRnIzSTNubGmKv9bYBE1cAycLqdj5XxsoeFJpNRuRj4U+84yJSGjh5EmgfSuE9OQqgkoBz3VAJ4vyScMm9xMBeUlcF/5Kpi1K0jVYd77Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st0AgsvWhBiPXCg9BBfP9gZ+r7VkDHXhK0TR5fymHVw=;
 b=PosfcBrUdtuQ8wa8SEzJpodhtu4Q2bB397iWMeQdjDBUB7Imyg8iM105Kr2IpXOxJXVlXBC8UaVLL0aMtuKbRGQYeI5AedhV/2bBDg5WYFFcIbFJmAjvhCAD240SuSyso3hQFQk0NqWq2F6qIXHVUswyvVvznFKj00l/9MlGo73oSi8Fzv3WlarS2PPflBm0w3puvXh5KgFsVOxjEpDRf7eYYxZxdCK/OGZMVJ2NEZLSmStrN5b58DNRGJS5JRgPS5McxNJZgI3j71dZx2Lr3CR9kS1OeBxyDqwVoIlNbwOETWIiWlq/0iXxcUQrQ+OsEi4dxxZ9yJ5mkhRLvO3Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st0AgsvWhBiPXCg9BBfP9gZ+r7VkDHXhK0TR5fymHVw=;
 b=R3CSp2MQwcAd7jdfGRh/0aAIK494oqnQJjhkWfGftXdwhHEqTsP32mBqdHAnw8T5jq7F43zd1f/tA8Ci0FA4gCpz/9YjCcMnwkhkUvEL4HwnaXO7Nv5xPrNU8pc24fJg70N8sjbOlCqGUlLbzJmZkDNX3qeKq0OZDOcFXcuGPKE=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Fri, 20 Sep 2024 20:26:55 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 20:26:55 +0000
Message-ID: <34eeb085-22f8-4e7f-9814-8cae599b9747@oracle.com>
Date: Fri, 20 Sep 2024 16:26:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] amd_iommu: Check APIC ID > 255 for XTSup
To: Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com,
 mtosatti@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-6-santosh.shukla@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240916143116.169693-6-santosh.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: b129368a-ceaa-4ca3-4615-08dcd9b291aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1d0aks3ZGw4OXdJUVFFRTEvbDAxRjV2RzFzRVprdEZHdEhUcmh5c0VvNGNw?=
 =?utf-8?B?cTJjTkxKeWVVS1hlQnJhT0p1d3BHY3lGK0FKUkpEMERPWEhHaTVXb1hZQ0R0?=
 =?utf-8?B?VWt0eks5c1lLVWgxKzhoTDJ6TktRQXBiZWVCajFDdllyTlFqaVRiV3dobFV3?=
 =?utf-8?B?cmE2UXRLOHpPK3FKaDJ2ZVVZaDJYUkVCWVJ5L084ZXVzcE1MSXN4WTFzbktH?=
 =?utf-8?B?Qnl6czd4eGU3VkJxK3lJVE1jYkRIYTlwR1pIQlBocEZJMzlBZ1A0VU85RlVM?=
 =?utf-8?B?N1o2c3FUc0podEdudk5DMkpmTS9YWE5TajRBNFkxL2Z4Yk1jdm54QnhScUlG?=
 =?utf-8?B?SnVxMHQ0OEp2WVZaYmxTZmovbHM4dkdwaWpWdTFUUXJTZTRHV3c2d0ozUitT?=
 =?utf-8?B?Q0xxQUk0Z2NXaUZ3TXdjbjhGRS9DbGVra1paTWNHdWh3TncrdnBzbkF3ZHdU?=
 =?utf-8?B?Mm1EaVpNaEVybnNIRm1GZ1pMdlc4VlJQUFdIcTF0NFloQ1NhS3Nvdld0eHd4?=
 =?utf-8?B?ZDR5ZkVPdE1HUWhsMFVaaEdvY2ZYVWdFczlzU0MzZWMxUUF0K0c1KzRZTE15?=
 =?utf-8?B?NE1qK0Q3SkRReW5PRDFSR1VCeExqeFFjMnpJalRwdmNrU21Hc3IzSVFhWHpu?=
 =?utf-8?B?QXBKMkxuL3ZUVDRXODFUZ2NMM1NJK0J3bXVsaXpYVUp0M3I1bDFMNFl5ZU1K?=
 =?utf-8?B?WktjdkgvYXRmTGttTjZXMnQyRFkzWEEwSVBaSE9UeXAyaVlZMHBBK044Y291?=
 =?utf-8?B?dU5qQkp1VE16TXpPOUllSHVWOWZ5c2g4YnNZUVI1SURrbEY1a2JEQjc0MWRE?=
 =?utf-8?B?QjN1QU5GaUVoN3I0UHErZ2hTd2tXa1JFVmJ1ZlZQcTMwamtFdUxnS2t4WTZr?=
 =?utf-8?B?MVAyQytDRmQzZW82MzBmNW5SMlc0bGdncHpTVEZsY3U4ak9maE1BT3pqWUJp?=
 =?utf-8?B?U09xNDJKR2lQOGJ6VUFDeDdwNU1yTS9ZMHhuV3VMVG82WEpwQUtqZ2c4WUlu?=
 =?utf-8?B?NWo4QTNxVGhURy9HZWFLN3dDN2xqQWJ4RmZwczlRdGhRa09GU0NJZWlqeHNF?=
 =?utf-8?B?cW5Na2RwVWcxQ0VvUHlkTWl4aG9uVXdNcDg2RVJDQStzZnVYc1ErNkdKeDRJ?=
 =?utf-8?B?b2RKSGg5WEl2TGhSREJxN2dpZUltN1dVd0w3MlFPRXZYZm9aK3lPeVRod252?=
 =?utf-8?B?NW0xalNxWXIyenZFZmR5UWpESlM0b04zZEw2N3haSUExS0NST0lpMFhwdGpq?=
 =?utf-8?B?QThmaXhIbkJpM0hmOHpueXhWdzNGYkRndCtwbzNCbEx4RHk4M3ZnV3pJeWFT?=
 =?utf-8?B?UmRyZ0Mvb0VwRXpjS3ZlRnBGbDZzOEJNcHhWOUtLK3VmTDc5dWZWZ1ErZmxq?=
 =?utf-8?B?QmdMMXJHK2l0M2RIRTlIZWp3L2YrVWR6N01iaDBqNG9CcDFVMGJCRWptdXBj?=
 =?utf-8?B?SnhMZ3FlUVdqaGZ5Ty8zejRQRWM0ZnFVYzB3cEMzRzZwY0J4WE91dzNuNFNt?=
 =?utf-8?B?dWlpcmlyOVgrK3c4UVM2MG54ZkFYR2crM1BtU1ljdStMQVh2NHV4YzVsUml0?=
 =?utf-8?B?RGlaZ1oxdkF4ZWN6cWxWZzR2b1BCb1V6WmRsTDVkWEh6R0tnSENiYWdhODhs?=
 =?utf-8?B?bWFOdWN1eTRVd3dTV3FEQ2pubWVERVoyN3RNcDhwZ0RwV3JONTRkZERxMnI3?=
 =?utf-8?B?dFkrM1JaM0kzM3dTdmVtWVBVb1BtWVhkbVRyZ3llMUlOcmxaUGVmWXU2cnRs?=
 =?utf-8?B?ZDVpYzNhUUpIOFNoYkVpR3Q4SjJMT0JzNjE0TzhWbEcvMVhFUlZUUUdjOW1M?=
 =?utf-8?B?UW1nV0hMMDBpMkx6UUdydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERRSFk4MWt1OTJjendzWFpNVVJ0SWl5TUFmWTJUcEJJZ241TGNWZHVTL25u?=
 =?utf-8?B?SXFPaDMwS0JaWlkySHNLS1RpbDB5Zks1NGFYZWUrN3RMVmFYb3I1aHE3MGJQ?=
 =?utf-8?B?S2FZbVg1T3BjWDdPNnlod1VGdXZqSlVBbkI2UG1mU2lhVm5WdWNybENFQkhW?=
 =?utf-8?B?MVZFQ0FmQnhVSHhYaEpLREEyeVRsTTZYaW52RWVJTDF6a0NkZlFKYzQ1Vnkv?=
 =?utf-8?B?eW0zNnhkSnhNZzJra1R2UTlZUjV2WEV3WG1vQ24xSU1ySWg1WVdZYjdrbWQv?=
 =?utf-8?B?SXBBdHZ3VGRybnNiSHFPRzZvTk9OY3hXVzV1d0FIZVVmbFg4UW1hNVUzTGxE?=
 =?utf-8?B?a0lwS2lKYzAzMmhuV21ZWU1xckF4THZDdkdlQnI1S1dXeDJUYWpFcitsMUlr?=
 =?utf-8?B?VDdpY2ZtRkxBQ0x1TGlvVFZ0Y1QxY3FqdVkrbzR3QnVHaVdWZDJNQjFLMXRo?=
 =?utf-8?B?MXdERzJmZVYzZ21zZVZBVENFUy9USmVMRFR5WUhQUXNLNTFzWGEzaG9HaHk1?=
 =?utf-8?B?VmNwQTNKRE9ydHMxNkhVWE5DaHVPMWVDeHhNSmluMDZkOXYzdlpsQk4vUTd3?=
 =?utf-8?B?bHcvMFZjZDhoY1FZMDU5MkVhZUtuQzJmcmRWQlFYUzU1bGtML3ZBdjkxUUhm?=
 =?utf-8?B?ZS9UMXdjM0lYRmpQYUhOSGk1TzRVT2IvZ09maG5rSEJidDNnMzdUVGNBaEtv?=
 =?utf-8?B?eDFYd29vd2tjdjJVNDlvcGRlMnVHYTh2dS9wanJwc2lBV3AvYjBoNWJ4bmEx?=
 =?utf-8?B?NzlSeXBYckQwVm8xWTBDc2FkLzk2blFoWGM3aGNodHY3L2NVOFJSaDV0TUU0?=
 =?utf-8?B?UUhtTWFPcXl2eW1hL0FzcXNRdUxUdFlQTkFuTE9wazQ0MnE3UUNpcVJiOEZu?=
 =?utf-8?B?RU5ic2s0WFNTUjZJVkFsQmNZbW5jUDErc2FnZ1BGR3ZZQ0JwcEtqc3k2SDdG?=
 =?utf-8?B?cXlhcFE4am9VREF2cW5raHY0NW1TTVZqSnF1TG5FTlBCRFBKT1pDSEgwQzYv?=
 =?utf-8?B?ekhyVE5FYlZiajBmMDM0SVpKbTNjTFl0bGZheWh6MlNnU2tkVXdCcSttYlQr?=
 =?utf-8?B?c1B2Wk1kdDY4b2tobVk5L3dZb2NBeHFyekxjL0ZCNTVjSHVrdDMzaTFlVThG?=
 =?utf-8?B?MklRaVN3eG4xb3Evd2tWZXp1dFVocEhTQmsrUU5ySVpkN3VEd3k1WUFJTksy?=
 =?utf-8?B?ZUl0MmlENDJ1RDQ4dHRiN2p4V3crOEVuUm14Q3MrTkNXdXkwUUVSS0Q5ZlBG?=
 =?utf-8?B?aVlKZlphNDUwR3NjQUpyZzZlS1Avbmk2emhwZlo5MUU2enJoeEVwbDhOa1pY?=
 =?utf-8?B?ckl2anpCRVNKTENnaGJuLzBtQzY0d1lRS1lmbUNKdkRCaGJvWEQ4Y2pmNGYw?=
 =?utf-8?B?V3NUTjhHWHB1bDhicUZpbHZEd1o4TVNCVjVlU1pxdENmSmdUWmN5WjcwcXVH?=
 =?utf-8?B?bHdoTndLR0tFK2hwb2MxZ0FOcW1oNG04a204SmhRSlpBKyt4WDlxZ2xURk1x?=
 =?utf-8?B?YWR4OUVEdFZsZjJWbkJFanN0RDgyUDgxbmg2MFVyeERnZ2FSa1pOSDhaaVkv?=
 =?utf-8?B?c29OTGkrVXgrZHFTc0M5ck4rNmNpWmNYOWhTUHhrT3VmNTFWcDNtYWo5ME8x?=
 =?utf-8?B?WUhMT1FDVU9rbzlMMEFmOE5MWDdoa1NwZGhLTmN2cDNqKzRETzRLdUlORktU?=
 =?utf-8?B?cDlwRFRRd2pMSTRFalhyVUJlS3hhMUZ6MG5FdjhhR3lSVXhSdWF4N1EwUTZL?=
 =?utf-8?B?ZWQrbXd1WnByR1Y2bTZiVWdxNzZLbjVFV2l6djFodUxJSWZNM1Yva2s0Si81?=
 =?utf-8?B?WHdOdnhONHBTelFCSlRGVEh5NUd0MDR4aFhMN3FhS0txM1U3a00xYmp0THgz?=
 =?utf-8?B?S2EzS3lnSXhNb09rYW4vZ3E2ak1qVUhUUnFCaXY5WkxoT0JGdUNYb0dpaWxY?=
 =?utf-8?B?dGRPTEQ0RXluckYzK0dXMk96czJROFczSUlHTmprQkVQNUx3MDl6dnVKMHEx?=
 =?utf-8?B?MWlRL2cxUkNMODNzV2prZ1FaRStsMEx0c2VtS3VIWHZCL1NBWjIvdHlBY1RW?=
 =?utf-8?B?M1pXY0o3eHpIZkxqbWU0T0lPTEc1OVhGajZESTlGU0xvWmozSUp4SnVMRWFB?=
 =?utf-8?B?T25Zbi9INkdCNjBJdUoxYm4zZEFFTUVqV2FiSWZHTW0rckdZdFFQYlBHc0ZU?=
 =?utf-8?Q?0xwlI2B+8NuJwb46v279D0s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MSyt+JIpeJjW7HSr6czf0R6yVZwVJc/FFkdmcLHDgcuTtoZyX7jn40OhET8Qq45hEqkLBt3hECBdrTOGV2c0T5JOJe5M2uI71dNDN3HVRIyY4YNW8Z//eqORuhWVXbcUoVKLaeaZyWQJxdZHCw4owO0V0jOfZbV0sIfJwgoNCsAZj5+JzuBH9kQAgq9mx/QKENyXtRnlRfyn9BaHoPAuIaiwFQ/yQDF85N8bEkobrZ0UisHplVosgNlqLQxQJK4ePbc9kiRfhyyQ4fH72keM/KDgkf5tKtkVMFlTTd0wkNUCkj9GSorir8qRqV8qEkxB+qLh1MILL7AN7BuG3dHTUhsqz0mxs3Ec+QlMCorfkRf/xuqbenu1w+Adsy8yCCZXsipCZDZWADoFuw8NRSLNJR1iiGI1VBU7OX4kp05dQO4GTKcXSZqScOwxL3vP9g8KivgwGkBGSdeWulXwSYGGsWzjFlrD6ONjkB06rykapPH3eNiY1rIoDctJ4JwA+xzBNR+UppgoXHAFzmjraWbU6x4MJAIo/Mk6TVk1RmIR6PGOaz45HT5UY7nd7Y2QZaen4nayQZcQQ/CYQc75ykqDVYoUpL0+HHRlWgXbUa3jGIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b129368a-ceaa-4ca3-4615-08dcd9b291aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 20:26:55.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqmaUzh6CZQ/kDmGhDtFHgL7cuNPhleBH4WYEUn97ZbAr1TdN97qyfy2/a2Ftu/XJ82zFCxi1vmPN3gkAP0IotSsOFMH1ZOs0ehK963yd1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200147
X-Proofpoint-GUID: WqB5zX0IZx4hkvM1yUDeLKeZxbcmbAuf
X-Proofpoint-ORIG-GUID: WqB5zX0IZx4hkvM1yUDeLKeZxbcmbAuf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 9/16/24 10:31, Santosh Shukla wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
> to support vcpu w/ APIC ID > 255.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
> v2:
> - Fixed non-kvm build issue by adding a check for kvm_irqchip_is_split()
> 
>   hw/i386/amd_iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 9095146525e6..24eebf053df0 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -32,6 +32,7 @@
>   #include "trace.h"
>   #include "hw/i386/apic-msidef.h"
>   #include "hw/qdev-properties.h"
> +#include "kvm/kvm_i386.h"
>   
>   /* used AMD-Vi MMIO registers */
>   const char *amdvi_mmio_low[] = {
> @@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
>                                           &s->mr_ir, 1);
>   
> +    /* AMD IOMMU with x2APIC mode requires xtsup=on */
> +    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
> +        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
> +        exit(EXIT_FAILURE);
> +    }
> +    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +        error_report("AMD IOMMU xt=on requires support on the KVM side");

Use "xtsup=on" on the error message, "xt" is not a valid option IIUC.

Alejandro

> +        exit(EXIT_FAILURE);
> +    }
> +
>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>       amdvi_init(s);
>   }

