Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC3DC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXFaz-0004ID-Dj; Fri, 26 Jul 2024 03:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sXFas-0004Ec-Do
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:42:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sXFap-0000IJ-9d
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:42:26 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PLhXVn029275;
 Fri, 26 Jul 2024 07:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=wogjKxpKVF7j/0T
 ewcelHDLl8Ef3yq/oKlzqMNtqS+U=; b=F9+4HxJOMbTLw7iCBUrVtb7nBmIggrg
 I26b3XWr4VawWN2uiylehWfeCGOxcJCCI9yH29gHX+p1Sufv0jbF6j96UIFzmW7c
 GVW6qz8zd0SIP/LYetP9to0qC7uBjUDSrDy5LM/fWOmBy4RqpsGBSraP3ggFv9UI
 BU7XW1lOQkRrkxH9Tpj7/vIFSVONNq7qo0oLg8FmL0SE9e4zbgY7kkPkE1XbwMSB
 Oaxnyzgy7jTd4OQk/FlZp5kIOtr8BKA5lPpzIbhe5tuGLt49i6UQ+y2OTBlL3gST
 gZzTz7fbJFcr6N2QTVb3BX7ElP4G3krMsVU6LNU8Aich4YAR8bi57TQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgktd18d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 07:42:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46Q6QpPR013437; Fri, 26 Jul 2024 07:42:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2a5bqhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 07:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMPh3HjsNiFsR0os9Vi9BeFYvdcdv5NFd0gc8/5Wzt+8sK7Ws/+lXs7IuJF2OzeEHwgTKHTlTP0ZJz3YP6iHA9c0GY5LHYQVU/2bPxxnMz7HiEOeYgz5FPVcXZejVhduNx2XTNLiH0xfNM34ymk28hYFHj2myv0tENuKfKVtknq2oafAvpuVflVtzy0mOBt9rjCFjq3GXAP4HKN3RJtEenfD5U82LrzXrKMpBEscBSR0jizkBgxg43AHIgTjsnzgR4XxpOcuDrJMRRT7tRqLSKCHUzs94rRV8ySEY3VYTOVOkVIIpliTogD5P8Q4VKa+QVAOyNBimoIaUWf32kNFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wogjKxpKVF7j/0TewcelHDLl8Ef3yq/oKlzqMNtqS+U=;
 b=mJGbkOD/ffyXf2Q3HvzSWbEiUc4SVLl0+T1P43S7uRkXKjPeN1UYjaQb730KPuWgq9/h2DwGTO9LyCekmC1K1oe5X+boHU4KMIA9P2Q0f4x+OqPRb0KGzvZj/Xy1aQxVKDCc0t/XbbQlcs+TQ9W1834yWDHSnjfStz1pmbXsV/TaUxuUUzu4qQ+cSwCP6JQYlczCn8MNZETT477Vh8YOfEvjkF3a82rQlMQ3Xyt1rHOhVYnbsPxyzcRDVEQ1V1AyrR8GppdhvomXkb05RzfgpVyjMzys1QEeSr7v4BKgNLeFSjXC4JctVVAtwSmQN8wi4p0xuSoXcr8UJG8bFD6yIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wogjKxpKVF7j/0TewcelHDLl8Ef3yq/oKlzqMNtqS+U=;
 b=DQ9uJiCP6HbmUTrNi+OaJO8B09TdbFwhSQaVWqmio1L5x/nulrfys7JRMX2CCxg8fmnCaYEBCa0ZnpxhiCexW+bwlhjCb0rX2zhxPqfflYT3QJ14slshKGlTkTWFtSEIRRLGcmt0qDbAVIo3r9S+jJaJ46gZ8W8rERMAg6MvBVs=
Received: from IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13)
 by IA1PR10MB5897.namprd10.prod.outlook.com (2603:10b6:208:3d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 07:42:07 +0000
Received: from IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950]) by IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:42:07 +0000
Date: Fri, 26 Jul 2024 00:41:57 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <qo3ius6ts3zhon6xivwyfcib3ubhmga6d7r763v64xzblqnnjz@ki3sbi2vde55>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n>
 <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
 <ZnsUnKZHtsMKQc_2@x1n>
 <3af67d66-075d-4162-916b-b407332042e2@oracle.com>
 <Znxg3jyYAfJQIHUB@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znxg3jyYAfJQIHUB@x1n>
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To IA1PR10MB6172.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6172:EE_|IA1PR10MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 05938b20-e697-4a7e-fad2-08dcad4672d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JI//UIv9YeHTRHt93uwakjhx6dAQ2CXwws0YPNC1de33NsQTtH93w8yhJIno?=
 =?us-ascii?Q?ouF79txQkklq4EaxXCeSuj/PfGVnCEsRm2iCK5+4/Ixtncq1ZLgcGfIdhors?=
 =?us-ascii?Q?wLes8vnkjeQexDdmCq25rcC9F/43LF6lPxQULhBTi+l7IU/jfRHhzlYSFeFK?=
 =?us-ascii?Q?RJ5eT/tnnG6zt0O7WEW5VMx9snQQt3kgd28TkKa22qFlv5P5JTgeG+VyuJBc?=
 =?us-ascii?Q?GeNJB0UZW8ONroY5YtW82XE7vcBEnjSKNfO1I9MdzcnjDvnLJA0YenfTycHT?=
 =?us-ascii?Q?YDvpcz3QRXHOdcrCAQt3R+M5W+xLo/pdZgeiocep8C3/wtFeEAZxWWN+wTM8?=
 =?us-ascii?Q?lHLyODi62mXwkdGSj8oH6BmtY0EvQmuvHWBAI7be/rm3W3ikVrCIX2uZMERU?=
 =?us-ascii?Q?mxKh7r6x+57eR3+I/mgVsUcJOxwbbHq2M7CMbKK2ZGHxyDtHoVMWlz4L4sXJ?=
 =?us-ascii?Q?xnk6YUGVpE1f+R4LJVjMA+tztcvmNfUso06NMsPnQQiVYjgKpIkZD49BkBiF?=
 =?us-ascii?Q?ef5VuUXpQr4ILlKv8EKUfeBFy8UpeCyVBJG0GIlFiqmts/HWj0l09nhZoaG8?=
 =?us-ascii?Q?yNtHmDwX2+BippvkSKwTJ39fNUhAwbsPYhgsqtyvtFq6asxBEv3w8z02Rliz?=
 =?us-ascii?Q?ID4KOOueKlngELdV+IYKIjBapracrX4WYCr6SfybJnu07IGkj/3wBxbSickJ?=
 =?us-ascii?Q?wUWnEOdzMcdUYyMfasJ/40QGVi1JX7iLOYdP9G662bCkFuQBVIWW+8+nnOc/?=
 =?us-ascii?Q?gityd2buTeH6nLLvH8t63HM0kVRK2UbVeR5bi+cecnWZVGtkDVb+Qab2dIKi?=
 =?us-ascii?Q?pkXggM7FylswzE2gH87/4IEFYxcOxkHXQ9N1sjXnsOMkftRv63DmPcdjrQVB?=
 =?us-ascii?Q?z79vTsZjt3zYigzq2H5rA5sfpRxENHHb20ZSLkX7q9pDksRwT6M6BgbdI3pk?=
 =?us-ascii?Q?aS4IrV935Usyh4Z4Qg1C+PMCmefY7QExQg411CMHm3idYx2k58FlLlP0Svnx?=
 =?us-ascii?Q?dhBCfLYTfs3Ed6Tu5vXwiah8TmH+ga/EbaMffs1wIVEuVC/NwfcsmtxmA/8C?=
 =?us-ascii?Q?R50pOJ4aNEhElhMkA1rD9NrtP850IrfXTIrSBuYNB8qJnWpgiNffE40PybsI?=
 =?us-ascii?Q?iu0T3njPR+AjIkrxzHy5C5c+7taYhCMFSdVQEgsOKtmGiacIB1cFiYuz/Hw/?=
 =?us-ascii?Q?ldTCmNM9KXnup7aBMzNH4IlpKbjAoQs8tIhUZ0KcNOkPRPiUEk7C1ZVEHgBm?=
 =?us-ascii?Q?TGeDpdgPJqrhQ+fbhA+1ndDa7UXIMw1JMZPMFlazwtcrat4vaOKO9zusH+6r?=
 =?us-ascii?Q?XFCVRi/O/D7JVb4T1Ahh7p8r2LTiKaPh7QfPL4Dz2Ke3xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB6172.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WfEW7693dTBM5W9m1GMzvoc+vPai9iVLR/exZZtfy08LCTUFRAyYoBGkmP6g?=
 =?us-ascii?Q?XupYZ0qAbNbJpNUcxOu4tQXofF3dYKW7yjbUf5TaJ6iTcm3100RpcvM7drpW?=
 =?us-ascii?Q?SS5zyypHkDqDm7S41XgEkxGLwcszqE09TiBg8TM08lYGozBWMHLwiLA4t8i3?=
 =?us-ascii?Q?TqDBdMfaFm0elYeDSO7ZW3NZu82vyNvdmeKD/lZwD523nIZJlKkFrBF/p54T?=
 =?us-ascii?Q?42106EMflLx4dwVIGQLl5VZerQqF2FCJoUt824CJTj4fYcox/zngwP0qz7Uo?=
 =?us-ascii?Q?OIicnC/nBXwtL1OKhwlz598bjx8+XbUfexXlC8xJST7O0MlQTzzscyyoeUUX?=
 =?us-ascii?Q?edLn8HVrQgnqQEeg5uNhLqhrkOEoRBLehGDyzSzbc8u26G58h/2axJ41lHvQ?=
 =?us-ascii?Q?CgmVJwVvh/0YldaDC0LThDv4BLoa8U0ncElvL0U3wMHMiNr94jLOWP6Kfnks?=
 =?us-ascii?Q?Zl4hC88X6tPJADr/sTIXrChtUct4d3moqtXTjmOXqoQlGZ9GGQ6fApmSPwA3?=
 =?us-ascii?Q?5nsqZKUSE44uR6Ig//N1W05MCnlkvxf8yoByH3T+pcqqPSR9cKYDQuV33A5A?=
 =?us-ascii?Q?g0YPh159Gcyj/eNmendEFLAmhSsUPy0gNpIzXTpRIpffRcf7mnp6jFcgBNpH?=
 =?us-ascii?Q?8Zu2KaFZ1wMAs14vh5LVoBuG5PAobmTx4gibCe+4VUT6qKumU1XeU1eH0ueD?=
 =?us-ascii?Q?5LUaoLGMi0dbIzEtNSsRpyLKo1OzukZxTCfmadlidOj1jdcEsfwSyq8EpY/I?=
 =?us-ascii?Q?VUNsZVXqmR/TRYDEI4pEcmUGDQfHG8G2g2i6PjsNIIPgqpYQirB9pOzsOztc?=
 =?us-ascii?Q?+mM3fetc4J3Uli0xoj7sxxdGh9pAZrhPuanczSjKfsU7hdIa6UNpGP/gYQPz?=
 =?us-ascii?Q?kPdT4YSo29GspWujo5N/+0x39qjmElgMR0Bee9uD7waNm6305VVmuqZVzzIW?=
 =?us-ascii?Q?MTvFyzOd6gRdosOIvLBWdCAQKBMeu8ElnVEUtkqI57ovJlqJnu9HjzpQ8pag?=
 =?us-ascii?Q?JEBm0Kr7cn4Kd+/iNJfLn3/Fq9VO9zDFM5qLS7xHXR9Sd6tKbgbPIpLbI+yX?=
 =?us-ascii?Q?j2JMJzC3dDjibtZEYNb0+8PXDFR3HmmaaFrLNhH582OfbdG+RDT7ofkxoypl?=
 =?us-ascii?Q?XX7flLIQsvmHAt4m1WNpXugKTQJELxcif0CcVdL9Sr43orKBJU8SvOZi4pCQ?=
 =?us-ascii?Q?A4aOieN0pFALnjW8rLi6UHeVrFVIYANMwhzOcFIXcElDAu2qCsLi9KQck6pv?=
 =?us-ascii?Q?Z9Q/OKGHji7y7+y9eystr/fbjrj71+7FyawdZ6iVuF/mmzF0hRhVEwpeFLnA?=
 =?us-ascii?Q?VTnIDkH+cvEZeflhtbL0kIN5LetNozCl8qazAjM5iFAihZAfynZJJhZW02u2?=
 =?us-ascii?Q?v9XdTJzFGNjAPGc+C3SLYIAfO9ZzSV3FADrPR7DVvaOplkxlXKFuTFdXxBFS?=
 =?us-ascii?Q?IaJGX5gOG7q5dKWGYYdGkTbY4XX703z01BTVEyXJ0pxjomkMyA1TS4hfwrfb?=
 =?us-ascii?Q?oExyVIU5CF7i/roVH3hEoRZhEY2g0GzGEsM9k/7d8/CtARJ2b8DBI7jKHYA2?=
 =?us-ascii?Q?9SdOE5TbIhJW1ihqowHzZQk469NZ3wil3ysmhTvu4AMMpyoHtKPwFoMH4PzV?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M7iSrgLkcunkqFRNdN5gqMM/eAC3K46t3urzIK4xcAQfK4wH7vbutzHUWx6Vd5qArg0p6qXGfJuAZ5uC6ognK1786g5tnakEggWIc4H1yXrNfIzC7N1swtkOvCExtWMsSpEhlUqWrhNnqQ5ynulwzVV7i5sl7PTWXIeBOIVdKV3m2tHPIaRYm+uaPaepbGwcy9eQzNIE3bj+BoWvGO9qCk5vHMlbk2uQP6yDjK0F9dJHr7FOOLoXEBA+pL6hnvp/E6km9BzsjzSTd9RfWZRF+bY+3T577Tko3gTSAmJnFjjdclfRmBn0xYrrOdBPjSbX3gG79lxCaoOBlZg9ceKJjLjKJ1O5ivdz3dK79aVIZcN/TPpCQ+6+7qPb6EhA6ERiH5uY6XSbgo4H28/MCNWCb4RZi1TE7Kq9VwndA3i4ckah04e9wCa85Pag/qWVaoShzaSIp69gYnufd/nsup32aVT9RnDB+krUiB5fbp827UGC1OaJ/1RWPCuRGtU/8C53JB3nM1QQUsndHnyVokKZ8NlQkX9zLXkBIWaxAb4+Fwdh5QMJQmzvL5UjCCdB+6g+ju5wUDO+PCLZePQavlUg7ZZQ1m0spzSIcE7UydTmUwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05938b20-e697-4a7e-fad2-08dcad4672d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6172.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:42:07.2006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3miqoowPcwLulPAhwoanl//fwdDGlSBANN1ngKrhaHlQagG6vjwh+jkn9O+h8kzRHVgUmfZBlfHx7J6OMao9Hf9kn9NbQ5pDTc7LHyO3YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_05,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260050
X-Proofpoint-GUID: nb3LA6kycqO48PAWJUfMfDZIDLBt5Raa
X-Proofpoint-ORIG-GUID: nb3LA6kycqO48PAWJUfMfDZIDLBt5Raa
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 26, 2024 at 02:41:34PM -0400, Peter Xu wrote:
> On Wed, Jun 26, 2024 at 12:04:43PM +0100, Joao Martins wrote:
> > Are you thinking in something specifically?
> 
> Not really. I don't think I have any idea on how to make it better,
> unfortunately, but we did some measurement too quite some time ago and I
> can share some below.


Hello Peter

I apologize for such a long delay with the reply.

> 
> > 
> > Many "variables" affect this from the point we decide switchover, and at the
> > worst (likely) case it means having qemu subsystems declare empirical values on
> > how long it takes to suspend/resume/transfer-state to migration expected
> > downtime prediction equation. Part of the reason that having headroom within
> > downtime-limit was a simple 'catch-all' (from our PoV) in terms of
> > maintainability while giving user something to fallback for characterizing its
> > SLA.
> 
> Yes, I think this might be a way to go, by starting with something that can
> catch all.


Possibly the title "strict SLA" is not the best choice of
words as it creates impression that the guarantees will be met.
But essentially this switchover limit is a safeguard against the unknowns
that can contribute to the downtime during the stop-copy and can be not
that easy to account for (or even impossible due to hardware
implementation or other issues).

To show what kind of statistics we see in our environments and what
are the main contributors please see below.

Example 1: host migration, default downtime set to 300:

Checkpoints analysis:

  checkpoint=src-downtime-start -> checkpoint=src-vm-stopped:                   74244 (us)
  checkpoint=src-vm-stopped -> checkpoint=src-iterable-saved:                   154493 (us)
  checkpoint=src-iterable-saved -> checkpoint=src-non-iterable-saved:           4746 (us)
  checkpoint=src-non-iterable-saved -> checkpoint=dst-precopy-loadvm-completed: 224981 (us)
  checkpoint=dst-precopy-loadvm-completed -> checkpoint=dst-precopy-bh-enter:   36 (us)
  checkpoint=dst-precopy-bh-enter -> checkpoint=dst-precopy-bh-announced:       7859 (us)
  checkpoint=dst-precopy-bh-announced -> checkpoint=dst-precopy-bh-vm-started:  15995 (us)
  checkpoint=dst-precopy-bh-vm-started -> checkpoint=src-downtime-end:          236 (us)

Iterable device analysis:

  Device SAVE of                                      ram:  0 took     151054 (us)
  Device LOAD of                                      ram:  0 took     146855 (us)
  Device SAVE of              0000:20:04.0:00.0:00.0/vfio:  0 took       2127 (us)
  Device LOAD of              0000:20:04.0:00.0:00.0/vfio:  0 took     144202 (us)

Non-iterable device analysis:

  Device LOAD of              0000:20:04.0:00.0:00.0/vfio:  0 took      67470 (us)
  Device LOAD of                         0000:00:01.0/vga:  0 took       7527 (us)
  Device LOAD of                      0000:00:02.0/e1000e:  0 took       1715 (us)
  Device LOAD of                              kvm-tpr-opt:  0 took       1697 (us)
  Device LOAD of                  0000:00:03.0/virtio-blk:  0 took       1340 (us)
  Device SAVE of                      0000:00:02.0/e1000e:  0 took       1036 (us)
  Device LOAD of                         0000:00:00.0/mch:  0 took       1035 (us)
  Device LOAD of         0000:20:04.0:00.0/pcie-root-port:  0 took        976 (us)
  Device LOAD of                     0000:00:1f.0/ICH9LPC:  0 took        851 (us)
  Device LOAD of                   0000:00:1f.2/ich9_ahci:  0 took        578 (us)

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
Migration status: completed
total time: 5927 ms
downtime: 483 ms
setup: 78 ms
transferred ram: 883709 kbytes
throughput: 1237.71 mbps
remaining ram: 0 kbytes
total ram: 33571656 kbytes
duplicate: 8192488 pages
skipped: 0 pages
normal: 201300 pages
normal bytes: 805200 kbytes
dirty sync count: 3
page size: 4 kbytes
multifd bytes: 0 kbytes
pages-per-second: 958776
precopy ram: 480464 kbytes
downtime ram: 398313 kbytes
vfio device transferred: 4496 kbytes

Example 2: different system than above,  live migration over 100Gbit/s 
connection and 2 vfio virtual functions (the guest has no workload and
vfio devices are not engaged in VM and have same amount of data to live
migrate).

Displayed outliers that are larger than 3 us.

Save:
252812@1721976657.700972:vmstate_downtime_checkpoint src-downtime-start
252812@1721976657.829180:vmstate_downtime_checkpoint src-vm-stopped
252812@1721976657.967987:vmstate_downtime_save type=iterable idstr=ram instance_id=0 downtime=138005
252812@1721976658.093218:vmstate_downtime_save type=iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=125188
252812@1721976658.318101:vmstate_downtime_save type=iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=224857
252812@1721976658.318125:vmstate_downtime_checkpoint src-iterable-saved
...

Load:
353062@1721976488.995582:vmstate_downtime_load type=iterable idstr=ram instance_id=0 downtime=117294
353062@1721976489.235227:vmstate_downtime_load type=iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=239586
353062@1721976489.449736:vmstate_downtime_load type=iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=214462
353062@1721976489.463260:vmstate_downtime_load type=non-iterable idstr=0000:00:01.0/vga instance_id=0 downtime=7522
353062@1721976489.575383:vmstate_downtime_load type=non-iterable idstr=0000:00:02.0/vfio instance_id=0 downtime=112113
353062@1721976489.686961:vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/vfio instance_id=0 downtime=111545
...

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
Migration status: completed
total time: 23510 ms
downtime: 1018 ms
setup: 380 ms
transferred ram: 5317587 kbytes
throughput: 1883.34 mbps
remaining ram: 0 kbytes
total ram: 209732424 kbytes
duplicate: 51628634 pages
skipped: 0 pages
normal: 1159697 pages
normal bytes: 4638788 kbytes
dirty sync count: 4
page size: 4 kbytes
multifd bytes: 4653988 kbytes
pages-per-second: 1150272
precopy ram: 453652 kbytes
downtime ram: 118 kbytes
vfio device transferred: 209431 kbytes

As it can be seen from above, the downtime gets violated and the main
contributors are vfio devices. Also it can very depending on the
firmare version.
I have to note that in one of 10 tests, the ram downtime is being much
larger and becomes then the outlier. This is being investigated
currently.

This switchover overshoot is usually being reported as timed out queries.
And to comment on precision, yes, this overshoot safeguard is not
precise.
In fact, the current implementation is not precise and has a granularity of the savevm_
handlers as it would only check the downtime overshoot after it is being
completed. Maybe this part can be improved by delegating to some of the known
abusers to observe the downtime overshoot on its own.

> 
> > Personally, I think there's a tiny bit disconnect between what the user
> > desires when setting downtime-limit vs what it really does. downtime-limit right
> > now looks to be best viewed as 'precopy-ram-downtime-limit' :)
> 
> That's fair to say indeed.. QEMU can try to do better on this, it's just
> not yet straightforward to know how.

Could be that the better known part of the downtime (and predictable
taken the bandwidth is accurate), i.e. currently what is downtime-limit, serve
as a starting point and be named as ram-downtime-limit and everything
else would have switchover allowance of downtime_limit - ram-downtime-limit?
The correct value of ram-downtime-limit would take few iterations
after dirty sync to get established.

I think that is somewhat similar to what Joao is thinking below in 1) and 2)?

Thanks!

Elena
> 
> > Unless the accuracy work you're thinking is just having a better
> > migration algorithm at obtaining the best possible downtime for
> > outstanding-data/RAM *even if* downtime-limit is set at a high limit,
> > like giving 1) a grace period in the beginning of migration post first
> > dirty sync
> 
> Can you elaborate on this one a bit?

> 
> > or 2) a measured value with continually incrementing target downtime
> > limit until max downtime-limit set by user hits ... before defaulting to
> > the current behaviour of migrating as soon as expected downtime is within
> > the downtime-limit. As discussed in the last response, this could create
> > the 'downtime headroom' for getting the enforcement/SLA better
> > honored. Is this maybe your line of thinking?
>

> Not what I was referring, but I think such logic existed for years, it was
> just not implemented in QEMU.  I know at least OpenStack implemented
> exactly that, where instead of keeping an internal smaller downtime_limit
> and keep increasing that, OpenStack will keep adjusting downtime_limit
> parameter from time to time, starting with a relatively low value.
> 
> That is also what I would suggest to most people who cares about downtime,
> because QEMU does treat it pretty simple: if QEMU thinks it can switchover
> within the downtime specified, QEMU will just do it, even if it's not the
> best it can do.
> 
> Do you think such idea should be instead implemented in QEMU, too?  Note
> that this will also be not about "making downtime accurate", but "reducing
> downtime", it may depend on how we define downtime_limit in the context,
> perhaps, where in OpenStack's case it simply won't directly feed that
> parameter with the real max downtime the user allows.
> 
> Since that wasn't my original purpose, what I meant is simply see ways to
> make downtime_limit accurate, and by analyzing the current downtimes (as
> you mentioned, using the downtime tracepoints; and I'd say kudos to you on
> suggesting that in a formal patch).
> 
> Here's something we collected by our QE team, for example, on a pretty
> loaded system of 384 cores + 12TB:
> 
> Checkpoints analysis:
> 
>             downtime-start ->               vm-stopped:             267635.2 (us)
>                 vm-stopped ->           iterable-saved:            3558506.2 (us)
>             iterable-saved ->       non-iterable-saved:             270352.2 (us)
>         non-iterable-saved ->             downtime-end:             144264.2 (us)
>                                         total downtime:            4240758.0 (us)
> 
> Iterable device analysis:
> 
>   Device SAVE of                                      ram:  0 took    3470420 (us)
> 
> Non-iterable device analysis:
> 
>   Device SAVE of                                      cpu:121 took     118090 (us)
>   Device SAVE of                                     apic:167 took       6899 (us)
>   Device SAVE of                                      cpu:296 took       3795 (us)
>   Device SAVE of             0000:00:02.2:00.0/virtio-blk:  0 took        638 (us)
>   Device SAVE of                                      cpu:213 took        630 (us)
>   Device SAVE of             0000:00:02.0:00.0/virtio-net:  0 took        534 (us)
>   Device SAVE of                                      cpu:374 took        517 (us)
>   Device SAVE of                                      cpu: 31 took        503 (us)
>   Device SAVE of                                      cpu:346 took        497 (us)
>   Device SAVE of             0000:00:02.0:00.1/virtio-net:  0 took        492 (us)
>   (1341 vmsd omitted)
> 
> In this case we also see the SLA violations since we specified something
> much lower than 4.2sec as downtime_limit.
> 
> This might not be a good example, as I think when capturing the traces we
> used to still have the issue on inaccurate bw estimations, and that was why
> I introduced switchover-bandwidth parameter, I wished after that the result
> can be closer to downtime_limit but we never tried to test again.  I am not
> sure either on whether that's the best way to address this.
> 
> But let's just ignore the iterable save() huge delays (which can be
> explained, and hopefully will still be covered by downtime_limit
> calculations when it can try to get closer to right), and we can also see
> at least a few things we didn't account:
> 
>   - stop vm: 268ms
>   - non-iterables: 270ms
>   - dest load until complete: 144ms
> 
> For the last one, we did see another outlier where it can only be seen from
> dest:
> 
> Non-iterable device analysis:
> 
>   Device LOAD of                              kvm-tpr-opt:  0 took     123976 (us)  <----- this one
>   Device LOAD of              0000:00:02.0/pcie-root-port:  0 took       6362 (us)
>   Device LOAD of             0000:00:02.0:00.0/virtio-net:  0 took       4583 (us)
>   Device LOAD of             0000:00:02.0:00.1/virtio-net:  0 took       4440 (us)
>   Device LOAD of                         0000:00:01.0/vga:  0 took       3740 (us)
>   Device LOAD of                         0000:00:00.0/mch:  0 took       3557 (us)
>   Device LOAD of             0000:00:02.2:00.0/virtio-blk:  0 took       3530 (us)
>   Device LOAD of                   0000:00:02.1:00.0/xhci:  0 took       2712 (us)
>   Device LOAD of              0000:00:02.1/pcie-root-port:  0 took       2046 (us)
>   Device LOAD of              0000:00:02.2/pcie-root-port:  0 took       1890 (us)
> 
> So we found either cpu save() taking 100+ms, or kvm-tpr-opt load() taking
> 100+ms.  None of them sounds normal, and I didn't look into them.
>



> Now with a global ratio perhaps start to reflect "how much ratio of
> downtime_limit should we account into data transfer", then we'll also need
> to answer how the user should set that ratio value, and maybe there's a
> sane way to calculate that by the VM setup?  I'm not sure, but those
> questions may need to be answered together in the next post, so that such
> parameter can be consumable.

> 
> The answer doesn't need to be accurate, but I hope that can be based on
> some similar analysis like above (where I didn't do it well; as I don't
> think I looked into any of the issues, and maybe they're fix-able).  But
> just to show what I meant.  It'll be also great when doing the analysis we
> found issues fix-able, then it'll be great we fix the issues intead.
> That's the part when I mentioned "I still prefer fixing downtime_limit
> itself".
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

