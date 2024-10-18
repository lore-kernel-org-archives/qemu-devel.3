Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D4D2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p5S-0003FC-DT; Fri, 18 Oct 2024 11:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1p5Q-0003F2-4k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:40:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1p5O-0000v8-2A
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:40:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBgi1019364;
 Fri, 18 Oct 2024 15:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sanmgCzp7c0949W1dKq3MI+jPugmEywRQfAYT9MezzI=; b=
 T3pj40CMYeVeSTuv9weOLpXe/kjANBcCETjRZ6AVIOYJ1lCOv8+RIcWcdACsEiYl
 bZZX6Wz2v3VknqxK13Vab9nF5xy1U9JM8f+xkWDiYyotMHetADaVRwx2gvtKbaUN
 2H64GmZCfdV46OK179VxLhUdfJ+neGy8HCFTAI6rEfXLaT1bXgRLkMmBcl5VUGvM
 PBz89KifXqK1nXFsfggFPtytmagtZ8mAXH7QtDQLLTls6uA3dJMYAGqjzVALG5uj
 5SnBc9rfJ8Qo3s/insFpllPp63tm7UgwrC+V6s9CJu9l27GClZIWu6hdQKwxRKqf
 9Gu66DkBDmtdMzO83XqVzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcrr21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 15:40:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49IF8sNx013980; Fri, 18 Oct 2024 15:40:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjbqmmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 15:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjpXje4uNINyGfGUAYSS1svL6fn8GxtdGCbcAbGKVsIXCgDHMt2vmdTchYHgvV9vDaYe+XdjQMV140n4ry+MjU2v5SZnzFcoQ+8YUH0trUBATKrfSlOMOsLxd1O/5pc3gst5SKFa1ni8oHF87A9zwUIHq2sfE34fyZXoK2Dy+/nTSFPZrqztE1lznqLQ9zrHBndOZ2N1ItCiLT82r/VeVlekcfREBOeM5HR58F7kC91+xHQOtaayZMg7mD88kHtw/FAdOjQmPCodFzL/sjrlrOGLIAU56yEiZd1kDB5l98bn9XMBRJZHcO+zTA8nnONmOtS3zWjoGAWHPzEB4SPnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sanmgCzp7c0949W1dKq3MI+jPugmEywRQfAYT9MezzI=;
 b=tWF5/0jN5BmAatzQRy4d8y/qgjH376g7QMvy0diS7gchXQw3VDQEFfDj5oY21JTjmEOFfXAE90BuQMyQ0CToUWQvW+bFrpuvbuHk50KZfpZEkpUp28t+e0X/k9RjRJb29hbolHloTlvBTd00F51ty3oTzBan2eFigjCF7aIViTdKg4qjXncVpizHWZKdU7RSkxFqUeWJAoHi9wf0Td4Bwd3qTlBcKBUT2qI/0uCDkDPIuEGxGygEWZQO6S9DdsBWMdEKS8KvWoCL7KFI90ql5tf9tPNAsLubs0peLYAACtRODlHFxSwnWukzHyc9L9Wc14NzoUvLs7vQVfNf7ezqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sanmgCzp7c0949W1dKq3MI+jPugmEywRQfAYT9MezzI=;
 b=wdbzUC41X/wYxlG5ZkdQyeucuqXs2PBVDvC1tHauZ2zApbdF2KOK9GP4SfHJ53Y/b/IYxZ0Gryg7c+qgOva2k/QgY6u++a+SyPVNvOtJiGUxVzUBYoMDI+fe97OxxaCxyqvxwGDIwAhTpwyoZ8/MIgIMbdCajBTHiXpgZjJUEoY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 15:40:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:40:11 +0000
Message-ID: <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
Date: Fri, 18 Oct 2024 11:40:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de> <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 503df3b4-bd45-415a-7a38-08dcef8b26f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dXdENNN3hhZTdhUURERmt0eVI0Q0FQZm42OHlYaytzbHE4dllpZ21kdnU3?=
 =?utf-8?B?Nk1iUHEySXhaemFxT0M5TE1LaFQyb0t5bmdobjYwbnczZHFHeXRjRUJ1UkJ0?=
 =?utf-8?B?UForOWpDTHV1bnBCT1FaTTVCZ1Z1aGFIdnYrTjhULzBCT210RC9TMk4rYnVN?=
 =?utf-8?B?OFdRVDhjcnNIZGkwNVpOQzNJSkk0eUhGbmRWK0NabXNwQ0ZTKzg0UmFrVlFt?=
 =?utf-8?B?WDhuRmRvWldRVFhDU3U0SVVKSkdhekNueW5lN3h4YnYxeWxjdTYvZDlTc2JP?=
 =?utf-8?B?RWdhZm5FTWlmbGprVzdUWFFGSXBJWnRkeGZhY3BDSk9SWWJ2UjZ6Z2t5cjNw?=
 =?utf-8?B?RVgwQThFK1JSbUtZTHJxeVJvVWo4UkdiT2xzeGJZRThKZTZ6dWFrSjRQTnJy?=
 =?utf-8?B?YkovbFFJTDQwOWo3Z3Qxb1lhUjZUSTB4Ykk4KzB1aHBUeG0rSER2dmJtOGdY?=
 =?utf-8?B?bmk3ZjNXVjEyVmpWeWdMZm1Nb0FzdTBzNTI0Tm1yTEtOR2ZGT0hyb3oyQ05l?=
 =?utf-8?B?b1hMdDhWR1BCYXJQeUFnak5EdnFqdW96WVpJMjBubzZJOC9COGh4UzFTdUl2?=
 =?utf-8?B?K3hrOWVZS0x4UlZaS0pPTlhENmJqWGZyUGR0cGtpVklkdTFxaTlRcUdSRTVL?=
 =?utf-8?B?UDhrTEdOOWZwRFhwaGJGRzdhTUxVcHQ1MDNRazNKQXlrZ2ZzRG11dXFteVNi?=
 =?utf-8?B?WG92d1hvcXVrZFkwc3FaTVhkTmRYeTI1WVJpcGkzZklVTzl3ZnBJT0ZyVXJy?=
 =?utf-8?B?WkFqNmdnVkl3TXFWeDdTLzNFMzAzMytZbm9jUVkwWGZJUEZCanJWTm4xWFhG?=
 =?utf-8?B?S3JRemVLRU0raktPWHVJeHJ4dDBUMXhac0RpNXhvQ0ZFM0hKZ3ZUZC9LK0lk?=
 =?utf-8?B?N1JJUGZwL1NaRWxSa0Z3akp4Wm9wVG11RFlpNzJnc3drMlVya2RlNkMyTDVw?=
 =?utf-8?B?NHZWdEc1OU5SelUyLzhqcm44RnlmdjZqVWxYaVQ4Q2JFNmNMeGRsR0Nyb3A0?=
 =?utf-8?B?RlJvSnBhTERYQ1JFZjA2MmRybUNibVJpOVExdnNvcUYxQzhvcTBlR2JaYVJJ?=
 =?utf-8?B?bmlwTEZJZ0QvQ2lNd2hadXdXVmNvRFdtQU45UlhRT0wvL3hRdXFxL2Fabkl6?=
 =?utf-8?B?QnR4N3VYbDJONkdEazVYT3BCZmo1dmphcHdtT2o4allicjdGemxTRjc1V3hw?=
 =?utf-8?B?K3lIZTZaWVRFNFRqUGlrVEJVT2lXZzQ5RFRoYzh2RkR5VU5uZUJvcnFiTHFI?=
 =?utf-8?B?ZkRkR0tOSGtKRW5SNEszQ29WTXZLWWFMKy96ZzB3RzdINDMyU2d3Z29JOGxO?=
 =?utf-8?B?QUlpb3plR0RzbldlWnNDemlORDRSTEZLZmNDdWVYdVJDZlBTNERueStxa2Ez?=
 =?utf-8?B?NXB6SjdidVdrOFJuOTlHZENhSUllbFR4UUIzVHFBRTBiaWdmb2xvV2ErUmgz?=
 =?utf-8?B?Ynh6OFVjMXl6cldGQ3hJNVQrWU9FQVF5TDU1YU5lMlBGdHZlZVl0aGU4c2Z2?=
 =?utf-8?B?dWIxbU5vbVF2elovN0I1QmYybEVjallESmpKVkZoL1B4QzViU0xCdWprSXNE?=
 =?utf-8?B?YTBaWExuaERqS0dkMmh6SzkvcTlVOWtLUWwyUWZnZUJad01HN1VsRlJnM2RS?=
 =?utf-8?B?VTFnQlZaRDNNT0hJNnBPRDFEMzlSTUlNdURCbGZmRDBVMGZuQzZoOWNCNGQ2?=
 =?utf-8?B?MFY0aWtjVEcrU1hTemduSWVJa3M4ZFhNdXQySFNpMlN3dlRjTDl3cUVKQ1Zk?=
 =?utf-8?Q?qjFFrWlniTKPGUs0Wb1+WJdTgiy8dvK40xIK552?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFV5WGVoSWs4Tk1wQnNScG9uVk03Z0EraHZpQnZvZG94akg2V3kxcElhRjdI?=
 =?utf-8?B?dUVMQUREaE1CZGEyaktEdU0wQlAvNUlLTlN5dzdBRkE1cEE5OWlZbGM4RW1j?=
 =?utf-8?B?M2lrSGs4WVpOakhBVnp0SWtqeFA0OVdOUlE1Z05GZjlYOG13Y1RrZHhLYWpo?=
 =?utf-8?B?QXpXY3M0SlJ4MGNaOGZ1UmUxcnorOGVUTW9jMnovRjlLMXlrTXlIb3JqQXZ3?=
 =?utf-8?B?eHF6aDlGN0FEZlduNDY0RzJMMGRZb2pkRnQ5aWZIcDg0bitxTmNUUEhIekoz?=
 =?utf-8?B?Z21HR25oTDF5dmVKNDRLWFNPWTN6TzVXQXBQSmFrU0JHdS9OaW4xaVRZcVFE?=
 =?utf-8?B?WVp1QUlZZ2xWbGpJMnQyK05EN2ZBTUhPTHNvRG5xTG5tNXVSczBXTFFZRXNz?=
 =?utf-8?B?OUlJVmgxUXJUSlBrVlVTNW9QR3N2bEE4VFJjU25DREl5cWpvTStWNlU4U0Q1?=
 =?utf-8?B?Z2FoOTYzUnpndWljelg2RDVNQjZYQ0d2ZFFuYTl6NDlmT3lkY2o4Y0tLY0RL?=
 =?utf-8?B?RmlMa2NtNGlnb3ZVa2Iva0J1dXVBVER6SHlPaVdKVFRXczFKRW9DbC9kZzVU?=
 =?utf-8?B?d2d1TktKaWJGcU5FSXNRdThIelNvaGNJcEQxSytsQ082cWRoMEJHVWFTSjRQ?=
 =?utf-8?B?cjRUWk1BSWZ4MVZNS1ZkM2VYT2lFK3VsMUFSKzBtVkVCRnJNV3cwTmxNRC9o?=
 =?utf-8?B?MXcyL0hRZmN4Q3JjMzhMYWYyQnFLQW93TklmU3BFbFphR214aVVON0p5U3do?=
 =?utf-8?B?TEk5ZnZRQ1h3ZTVpZFhEa3FrUmpCSXNVeU1MRnhKclh3cWNrR1gzS1Y0N3Br?=
 =?utf-8?B?N1JDMFpWOTdSVG93QlBZRnp0NTBSZEptbnAxa1hNL3lmRHkzYVZycEtGWGlU?=
 =?utf-8?B?L3VpYXRwM3dnYzhneVhQeG9CeVFiMTBkQkZCWnRGbTM3UlRnb0NvMGVKVUh6?=
 =?utf-8?B?QSt5SG44Zm9yVi9TTXo5UkQ0S2xwTllvVEp0QnJ1Nkh2bVYvUUdLUjJyOEpp?=
 =?utf-8?B?SHU3SEdqVk44SER6cTljWnpBMU52M0NNbnhLcGhFRW1EM21obzNKNVRPeTA2?=
 =?utf-8?B?ZlZ0K1lQR2xjaWYrOHgySkQyMmFpUWVnMjBKcDRDb3lSZVM1YnQyVzJ2SE51?=
 =?utf-8?B?MmFKQkN3OGtXY1l1cHRYVGp5NlQ1eWQrcmIxbUU1QTZXbThPSTI4TXVqVndM?=
 =?utf-8?B?TFVXYkd0VUtmYjZYVUlzTTgreWRiVU0wcVlhZDVFWTdwOHljQTJ3RmNQMmtW?=
 =?utf-8?B?T1BudUt1VW9CaHZVcmk0c0FYTUhOK0pTTHVDekVtdmMySDMrblY4Z3M2bDBZ?=
 =?utf-8?B?aTJRWVNSQ0tuNTQ2Ykp1cW94Z3dDTUhqclpSRGxjelFvWW9hVFlUQWVuaWRK?=
 =?utf-8?B?TFM5UUNEU2dlbHdEVDVQbDNlUWpwamtVM1BtUkNwcUhNeVY3bzczWGh5Tk1E?=
 =?utf-8?B?aUp3Zy8wWTVMQ0NFQ0dMYVVsMWx4ZThFUDNDRU0yWmFBSDdsTXJNeWxLM3lK?=
 =?utf-8?B?Rk1xL0VXSTRDcHJISXE5TW1yQ0lsYW5NMjA5THV1eE5xbkdOS0liOG5heHlM?=
 =?utf-8?B?aEUzZmR6dlUzSzk1RlQ3MXpBaGlKWHZScG5CTW4wdzhSdmpNY0FVTXcrQmtt?=
 =?utf-8?B?bnpEUlFucVlWcGp1dW9FVUtFNnBKWkJoSWxWTWJGWVI5RGduczA2K3kzeUhh?=
 =?utf-8?B?Y3hrZVM3NitCNnhrWEx1TTBhR29TelQ2NzAvbi93cFhUdWdzSEY4WUYycWlB?=
 =?utf-8?B?eUZndC9sclJ2enlPcENQdEhOVWJlZ0ZBNXIzUFE3eFBkOTh6d0hLeVMwOFFE?=
 =?utf-8?B?dGhZMklLZGdwTktNVnBITkgzcEFZMy9jaU4yTTR6cXppa3YvZ2ZiVDhvRkJl?=
 =?utf-8?B?TWg5VExsN1dOTENXd2xyeEp4YkVFTVFOQTdYSkg2SFJQNVZ3Rzl1c0Fta3h1?=
 =?utf-8?B?NGdtTENsMEw4eDNUbTZHbzMrSnpmdDFEdlhrVjU0NGxVNmMrN2JraElubnpO?=
 =?utf-8?B?VzFJTk5reWJzRU43Qjl1MGNkVSs0Ni9ERzg4dWhqUVJTek1DZCs3WGovd0VL?=
 =?utf-8?B?M01RM1FPdE1WVStlRStZTGc4M0Z5RTVQTUdyZTQrSVd5Mk9IeGw4djVGVDQ1?=
 =?utf-8?B?YTNUdDJMTmlXMldPZW9mc0xXbHA1cXdLeFVoTjVRdWxPUTVMaTBCWmtHVjE2?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ChuvW00OV1X3uDxT6PwlwDngSTXb33idN/cgD9y/Kz2UTmZ+9EvrZmkDVIhUY1BKwHNXbFjdHbpFGF78EetenNdfZUAqDA16GNxsnOT4rhbUyFSh+/Gjjp8p+XXONoP7pYcugxQOsJ4DNEx1hhyi9KTFijt2c1yAcH5TxIVecXfXPqTPCwDNA1/OPVQcsQQEFxcrhbhT2xzlRHjBpdE1Q40PYUWcD3E8Qwv/E5K0n0YKf/6JWmuYmUWra3NuUaS/RLhbCnINAmzBDRjX/xUnuwmd2VU4UdhTN4UtRSiVrElSOGSnRkSByMXEaJwjWIY17+f3YM3Q/+H/uzWxbKPswvcesK10orR/kQfckZ7uyhW6m0/uv7fzjwjZtwb4QWcwOOQFmwNVCfL1HynWn3lPR1NNZMXeTNYpcD1I3fwHzJOHtayFrMAmHFZnoEZoPpyqNrBL1ZzW2USfYa14RRReR/i9TUE/+udA3588SwEhy9M8SRvZf9khQ87tZccL9xP6BbGcdvlDhemJPMklqJn0OKas0kOQ7kZlVFgDJOaWbk5oaqXa76FzijpwlT9D3jKkyOVYvN176WDIR9iXep+KWYMsxNLUjg1f5nVanyHqwc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503df3b4-bd45-415a-7a38-08dcef8b26f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:40:11.3902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WavXbjzeN26GCPkfADlgI8TbrRVfL4MogqozKS7jfGgG/GM1TyFjYpbcJyRpaZ/Lo0lA5dC09vZ3aoxJVRSbGyakqZFgE8vM4SkWrYSWY3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180100
X-Proofpoint-GUID: LzINy-ySDDgO_yqgiqQhjLnlyB7HbrH-
X-Proofpoint-ORIG-GUID: LzINy-ySDDgO_yqgiqQhjLnlyB7HbrH-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/18/2024 11:32 AM, Steven Sistare wrote:
> On 10/18/2024 11:08 AM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Make all global and compat properties available before the first objects
>>> are created.  Set accelerator compatibility properties in
>>> configure_accelerators, when the accelerator is chosen, and call
>>> configure_accelerators earlier.  Set machine options earlier.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   accel/accel-system.c |  2 --
>>>   system/vl.c          | 34 ++++++++++++++++++----------------
>>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>>> index f6c947d..c8aeae4 100644
>>> --- a/accel/accel-system.c
>>> +++ b/accel/accel-system.c
>>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>>           ms->accelerator = NULL;
>>>           *(acc->allowed) = false;
>>>           object_unref(OBJECT(accel));
>>> -    } else {
>>> -        object_set_accelerator_compat_props(acc->compat_props);
>>>       }
>>>       return ret;
>>>   }
>>> diff --git a/system/vl.c b/system/vl.c
>>> index b94a6b9..bca2292 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>>           goto bad;
>>>       }
>>> +    object_set_accelerator_compat_props(ac->compat_props);
>>>       acs->accel = accel;
>>>       return 1;
>>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>>       parse_memory_options();
>>>       qemu_create_machine(machine_opts_dict);
>>> -
>>> -    suspend_mux_open();
>>> -
>>> -    qemu_disable_default_devices();
>>> -    qemu_setup_display();
>>> -    qemu_create_default_devices();
>>> -    qemu_create_early_backends();
>>> -
>>>       qemu_apply_legacy_machine_options(machine_opts_dict);
>>>       qemu_apply_machine_options(machine_opts_dict);
>>>       qobject_unref(machine_opts_dict);
>>> -    phase_advance(PHASE_MACHINE_CREATED);
>>> -    /*
>>> -     * Note: uses machine properties such as kernel-irqchip, must run
>>> -     * after qemu_apply_machine_options.
>>> -     */
>>>       accel = configure_accelerators(argv[0]);
>>> -    create_accelerator(accel);
>>> -    phase_advance(PHASE_ACCEL_CREATED);
>>>       /*
>>> -     * Beware, QOM objects created before this point miss global and
>>> +     * QOM objects created after this point see all global and
>>>        * compat properties.
>>>        *
>>>        * Global properties get set up by qdev_prop_register_global(),
>>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>>        * called from do_configure_accelerator().
>>>        */
>>> +    suspend_mux_open();
>>> +
>>> +    qemu_disable_default_devices();
>>> +    qemu_setup_display();
>>> +    qemu_create_default_devices();
>>> +    qemu_create_early_backends();
>>> +
>>> +    phase_advance(PHASE_MACHINE_CREATED);
>>> +
>>> +    /*
>>> +     * Note: uses machine properties such as kernel-irqchip, must run
>>> +     * after qemu_apply_machine_options.
>>> +     */
>>> +    create_accelerator(accel);
>>> +    phase_advance(PHASE_ACCEL_CREATED);
>>> +
>>>       machine_class = MACHINE_GET_CLASS(current_machine);
>>>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>>>           warn_report("Machine type '%s' is deprecated: %s",
>>
>> Hi Steve,
>>
>> after this commit:
>>
>> $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
>> # random seed: R02Saf9b44f2d88dd417052905692ee79981
>> 1..5
>> # Start of aarch64 tests
>> # Start of net tests
>> # Start of can tests
>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
>> qemu-system-aarch64: Device 'canbus' not found
>>
>> I tried briefly to figure out what the issue is, but I don't really
>> understand the dependencies involved. Hope you can tell us.
> 
> Thanks! I forgot to define the preinit method for the qtest accelerator in patch 1.
> I'll verify that fixes the problem and send you a one-off patch if you want to continue
> testing.

Actually that is not a problem.  qtest qtest_init_accel does nothing, so preinit will do
nothing, so it is OK to not define preinit.

Still looking.

- Steve


