Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4028BC3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUv9-0002TY-LL; Wed, 10 Jul 2024 06:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRUv8-0002T2-Eb
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:51:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRUv6-0008M0-DW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:51:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fX96004054;
 Wed, 10 Jul 2024 10:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=PLMqlSINgeyMt3X5QLT5EkcRCpMgKkdbN2QxuspQ1nk=; b=
 ORrJkJ2YwJ6F0yFy8r4lIPRK8IHhIhM5h+lOHxj84JYczmjQGxGtC3lTQ1uPSAuN
 jLSvuDCt2A6obWNqttyuaSZBiDCDU6BW9UlntsrluhqPtI+AzoIzY/xIntXtSygJ
 2xWSyeWbCsAtQ1NtAssoWdrXulYvoUPnld4mJuiKxTs8Y8muUYCyyDQS5jb9bsaG
 seCTkyhLnR64cbIwYsaedHQMJoyo61vB5FHC+rAVTWKHgp+SC38V1MajIoDGkBHr
 K6BJ7ogt0tA8UIdKk6QvLZDvduwn8AcfcIGH7HVA+3+L8WHt6BImliZYOvFVgtF8
 I3VSkulMl+QFKBZlZcWHpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfspysh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 10:51:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46A90RsR004957; Wed, 10 Jul 2024 10:51:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tvf1aqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 10:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3WxeAjoliAP4mvjF5TK5AqGLM4UYomrZ70iTupFNBa0fvkwgPFiiXIXy3y9TSBHuRrryxiNPp0APZGD4UbXYvD4VL0YVXdSgPfTWaMGVkz6eDsRiigCuOe88ugswzq5PI3+cYrj/TuLOlrIX+IPFi8uTiuBFZKOGc9mXiM6MqXYDZiNR4BJzUcz7XX6nTxGIS+pj1adWpziApYTrwW/NCuC5piGRyZKqUCERB5xpyyeYbDRJfFEKiSN/xW10a1SG8nu7YzC+dQXtigiLExBICBeqO4MC/rCh5xwbUiTggYX68leedzR3q38iTzmrC54wNF/54O5bRgk+D3GhGHGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLMqlSINgeyMt3X5QLT5EkcRCpMgKkdbN2QxuspQ1nk=;
 b=QApRrnZ37p8v0KVjoUQyPW2rKXFthcOmMfkWwo61EvQIV5ZagpNq6GN7MZhq7BqKrKZVnhMQOVawu8dGE3uf47O61sntpb/aRR8Fc6f+gZbXasVY+MfmKLRxc4gUIr8ruVEgTjukBAWdeSQBAmLzHTWZ0G81fXe2BopJgOnX2f+WbJRmNuEwePl7vK8PDpiKis2RUww4Pe/t5ofdm5NeSAnVcmk9VBiP9nrsFEWV+FLBO5XcfCBAsgxSjggmV2m2Rh1VsCiXLKROcX2d9KN1kXBdeSnvw8tZS/eaaUltLnmLaOxs41M8pnwCTyNMkdTLjH2uQw9IhIq2aDguBzy+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLMqlSINgeyMt3X5QLT5EkcRCpMgKkdbN2QxuspQ1nk=;
 b=nvskvCvbeOZ/PL61rTiw6fiSeL0yas6s5TQz2HXONJ5vRY7gzzxoFOyuTkp3XoUXakQIz3KWENB9lDajylBH7yrkYE9fzC9HuaRmXvP7rfBFs4UwivCIwMgHl+1ZTM1VGkv2EQXspxx7J24sZT1SxejgAmPqkpEafgDzKAHnSd4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 10:51:25 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:51:25 +0000
Message-ID: <50b5d91c-b017-44dd-9b7d-074ebd47cbd0@oracle.com>
Date: Wed, 10 Jul 2024 11:51:14 +0100
Subject: Re: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
 tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-11-joao.m.martins@oracle.com>
 <SJ0PR11MB67448EFD79F088F76FBE0E7492A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67448EFD79F088F76FBE0E7492A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: ead90031-4bb4-4bbb-50df-08dca0ce3e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2hsNDE1d2JPLzFqNVk1Wi8zc0JuTHVCSXJiS3VpL3p6a0w5VXlqckdLWjVz?=
 =?utf-8?B?eHdDNEZXbyt5MDd6N1hyR0t0TGFFMHN3L2J5VEx6YmZWN3pmYjZJMzZKMUVJ?=
 =?utf-8?B?MnlJSE9qWERwZFdhRklwODRvYTZkVEh0RW4vSG9GRmpiRnVRcUM5U1lyV0Vh?=
 =?utf-8?B?dHhIK3laN2dSem5hZU9tQzlKRUtiazlIWjF5S1ZUVzlTNWNHL2YrM05qaVY2?=
 =?utf-8?B?ZU81enJNV0hxNE5peHo3TGRkbmpaeVh3SWRwYlJjMWgwbjd5ZFhsWm5BZ3o5?=
 =?utf-8?B?NnFieGlFYmlBbk9Mc3lKYUNvVHpTcDhoaHFEWGZJUmhqYWdaNHdBR3ladGdM?=
 =?utf-8?B?QjJUaGxRakxReXl2cmFwWTlKMWkwSDlvbWdlTVlBRzdrOFB6US9NLzRhOFcy?=
 =?utf-8?B?WWJTbHo2K0NQNmZkSEtoOEY2SzBsdXJUQnhLTFdSOTI2SnhZbVdvRG9kNlE4?=
 =?utf-8?B?WlI5YVdqckowM0V6ZmRzaGl3aFYyb0REYkRkWVF6dmRySkErZk9MY0owdDRv?=
 =?utf-8?B?Sko4VEpJRmNYZlpCcUwxTjJpTDBxdldmNWpLbUl6SEhwd3dGek1BZ3gyVUsx?=
 =?utf-8?B?RDRlWE5xWkdrUDNUWlZQOXg2MTJDUkhuWEo3OVd3V2xYaGhMeVlMZ0c2Yzcy?=
 =?utf-8?B?eTUzejRITXo2ejFKU09oVXVYVVVJTHloMDBFbW4wTXNHZUR0VUEvUk1xTklP?=
 =?utf-8?B?UHRNNDdoa0ZJUmdPdStMT3U3eUVUVThzZmFKS1dpQ2hYaG5hVjB0ZFhUOXE2?=
 =?utf-8?B?VGthRjBnZllSSTJWbERHbHR1VXRDRldFSEZJV29LdllidEhtTFJmQ252OENi?=
 =?utf-8?B?VUhrRDhzd25Ec01wWGpNOUNiWmdYcGYrdWZicFlBZ0JudGZ1eUtlbUVmTnFK?=
 =?utf-8?B?bTZXSWgyY0w5eFhMRXlqNjN6cXhXMm5xcGJSdGtoZFJrMHErYVJ5ekNKNlNT?=
 =?utf-8?B?NmE5dmRWandQUW02SFBUdW5KdEhGSmg5c0oyUXpSUTFNcDlORm5rM1hlYXBj?=
 =?utf-8?B?Yjk4KzBUVC9YR3BvaDhXMzVDMXptS05NcHhJRG9FeUxyak9mWVhSdmlPSTM4?=
 =?utf-8?B?WnlWY0lCb2plYVBtNExTd0p3NVF4RGcyNStBT0ViUGFxYXQ3NHpPYlFXNWNs?=
 =?utf-8?B?Unpwa1B1UWR5ZHZmM3dmeGNYenVkRkwyYmdpUU9DbWNyUXN4dHhGdU9SNDJT?=
 =?utf-8?B?TDNnVnRWK0tHOTB3MVczc091QStTbXV3N1M0Y2E2aDFLdTQvMEcxZHBTZU9l?=
 =?utf-8?B?VERpK1diamZNZUZodmRPeTVEa3kweElKaTE1RElvcFVVbUp0M3h4ek12WXdw?=
 =?utf-8?B?RVcyN1owVkk2ZSt0WTIwcC91eDlDemJEM09Sa3VwUHZVQzBoekVMbVBTRm15?=
 =?utf-8?B?VkxhL2dtRE5hVVIwdVlDa0IrdS9SWkV5U25Cd1FQdWhFMC9RbjBxNk1RczRs?=
 =?utf-8?B?Z29yK2U0KzlneGxpNUZPQmhUVzVxbkJxb3laeVpVR1FhRWFYWUttZlVGUXNS?=
 =?utf-8?B?MGtINWZQdnp2cjBQMkZjdnl0RHZ2d0l1eVhnZ2hLUWUyNFg1SnArQ0lDZTVC?=
 =?utf-8?B?dU8xT2FBOVgrYmxVbE1TQjloa05vZkpBRWZzV0ZIaEpjcS9uS3ltczBhdzY4?=
 =?utf-8?B?YXhRSC9mZ3dFL3hhRGFEKzBZMGk3RDM1ZFlSNzQ3czA4NUc1RnFzWUxFMHlq?=
 =?utf-8?B?U2M0Q3lTSlNldDR4Vm9XbkU2TXY3TFlGczl5M09IcjdFRjVtbVcyRnl0VGc1?=
 =?utf-8?B?U1p2SW41N29qamJiUjFwRGRHbGRoWllycmwzU2EzZUN3TTJWWVF5enYxRkJ5?=
 =?utf-8?B?bHZOOWZpVE5ta2w0Z2Nydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhiOWRUbmpFaHBzUUNxMU9kNGFpUThPTW51MDNVOG44Szd5dmZFNkRTZitp?=
 =?utf-8?B?ZUVxclgrRVlDVmh1cHRUMVpFMkovS255U0FkYXBGS1RlYUtFM21MMzFOQVZh?=
 =?utf-8?B?WEF5K0R1SFc0WnJwMnRGQmM5ZG5nbFhjZ0ZNazZyUnpOTDUvZXNRYUVVaThE?=
 =?utf-8?B?bmpFT2NCRWJkTHQxU0M4YzQweDNxdGdTZTllK2xiM1FwV0M2NXFqNVFzbkZH?=
 =?utf-8?B?UkZQY2lBT2VrSXFxQ1ZGVUFTblFsVzhMTmtRZGQ3bTZZSTNtVGIwc1hkMmUr?=
 =?utf-8?B?RWMxTGhBdnRTYVhIeEFlOVpBeENrM0pKMmZrTDFjdzJMRS9Nb2FpWDFIM0d5?=
 =?utf-8?B?Q3gxTzhTenpXMkVpL0JTOWhTVlZsNTFYaW1JcUp5NEpVdDhRSzZKQUxpa3NM?=
 =?utf-8?B?aTZ1cE1kMWhlRXVEMTBRRmo5ckNIM01RZ2ovSlFqN1gzMytaQ0N3My8xSW5a?=
 =?utf-8?B?NktQSTQxdVlpYnhUaXE0OUZoYXB0QmgwY2xQSUhuYU56ZmpTMTdST3JVYTBx?=
 =?utf-8?B?eTVmZjlzb3l0M2QxRWR2bUJsNGh3aFo3NVUzMHRldWI4eW8wUHF6eGZyd0x4?=
 =?utf-8?B?eVJCdkFYMVN6VXpEcmxRandUeGJMU2UwK0ltRUdkMktwRGRyRXpIblJCVEFC?=
 =?utf-8?B?RXZuK1d5UURKU2xzU3BiVlVBd0xZZUJXSDEzZXN3Rkx0eUpObmxlU2pIY2Rj?=
 =?utf-8?B?RmlMb3VSR1FJRWtDUTRrU25wZytNOXVGRE9zVndWM05kNHA5OHVXOHpzVXRU?=
 =?utf-8?B?bERJODNNaVVQaFB0Y3BtZWpKQVp5d0tIaFlRMEpvdDcyQStUb0s0WVVJRldl?=
 =?utf-8?B?QVZ2clVaMlJ4amR4Rzg5dDF4QnNoT29acHpWUTg5VFNPbkxTaU1BZm1ubXJH?=
 =?utf-8?B?UmVWd0NuUlVIakxDS0EyWXFQdk5sZzFlVHh0akdhZEhFQmE4SmtWM21PMmVn?=
 =?utf-8?B?Nzh4cnRSWnhuazZ5Z1BGeGxvWnZMT2Zla0VSU2ZSTWZNdVBFckY5UG1GaFRK?=
 =?utf-8?B?Z0FHRmJMekZ3Kzl0OUpIc2ZjTlpBOUpqNlRRRUlMeThKWkNDQ3EyeXVEVWZy?=
 =?utf-8?B?THZQVENXcmdrNEJ3NEdMcTJ1UjJrSGRYRm03Q0pGbnpPMk5TZ0ZkWjNicnZt?=
 =?utf-8?B?RzZGQ1dESjJseHROa3hrRE1TRlR1RENmTGdBZHQ5dnFSK3BWQzZqTXZIT0Rp?=
 =?utf-8?B?UEtvaTFOYWlVYWtCdFVXR2FmR1FuaFpKOVErMzRJSkpDa3UvMUR6SG9QT25I?=
 =?utf-8?B?eE9UNnM1ZUZuTzYwQ24rMG5yZnhCMGFCMXZqNFR1MFcwT0pSTFV6WHpGYTEv?=
 =?utf-8?B?SjFwR1IvbWNwdWxSYVZzU2o3endmK29kTlpqcTlpWW83N3NPVmp0NnlnQkNL?=
 =?utf-8?B?MEtrNmh5eXFpbXJPa1dhK0pZVnZqN1RFcXhiZDN5Q3lvb2gySG5yMEh6Rmg3?=
 =?utf-8?B?M0haTTllWmdGblJrS1cyTUs0Qk1LdSswSklTQ3hnZk00YW92emY1UDdqS3NM?=
 =?utf-8?B?SWVsaGxPTm9GL29rZHB6K3VPa2RKTTNBYzczem4xOHFXWU5hZU4xbUoxYm1o?=
 =?utf-8?B?MmRTZmpMbjN2S3ZGQ05oSFFqMFV6bW51c3BNdHZCeEkvU3pRK2RnQ05uc20r?=
 =?utf-8?B?N1U5bGlTeDFVeTEyWEs3WkdYeXZwNzhlVHFVdTRBODJaT1RVdE5lU0dRV0RZ?=
 =?utf-8?B?NThsK255SDB1MmIza2FYYk1RRjhWWVBiYW0ycVBzKy9Ta3BTUVZTbTBqNi81?=
 =?utf-8?B?SlJveVBnVzNzS1d4ZTIzLzhpdTl1dWVmWkFJWGUwNWZ2RWRNb25DMUJXOXIv?=
 =?utf-8?B?WjNML1Z4cTVNRFc4akYzK1l6RzVMTitMTWNxV1Y1czl4d3RCeFQ3b3c0WTFO?=
 =?utf-8?B?dHBmNXRDMmlzUFdtQXZncE9kU1RlVWVFUk5HemFQWG5lY2gxNWNiRVFQenEx?=
 =?utf-8?B?YUVNS1hrcmdOeGVIVjlvRUQyS2tkeGpJNXJmUGVFc01ZWHJEdko0bWZ1bE8y?=
 =?utf-8?B?R3hmNEsxYnphZHJDSTFGVlNjMmJ5RXJKYldzQVpwdFJLRjBZRWNWcWRXSTNq?=
 =?utf-8?B?Q29OS2tKQ2NzYkl1QnZuUHowdVhHc3Y4WCtmY2w3d0ExK1l4ZC9JM0ZuKzRn?=
 =?utf-8?B?cGR5aERnTDEwNEEvVVJhNy9IeHFXbWlmLzJQcUZnT3NqRVBZZlZURmoxWkxI?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m4PSvQgE1W+jzfJqs70TLmpBCeivL0FuFBA7Zm6q2mupLqTs/TqZrjkB6FrZNmP31cP/yceeMt2sNhKuf7SGe960ATS5MXreIUKRGLVAsTc91C0mRSqdTZVZxGTYDI5JjRlP1hmH2tx+azKCnTSR8bKgkC5BEn4Z4UjBk+RMh7IixyhNFnLgQqxr5PvCFjW8gvYnCrSCLzzngC8kVY0KRgutho0/5pa7Wl8h2S8HyjTzg17u1prDmUMhNFg+kmK8swdQtKag+lR8tNisKKmMiPSvrQqCc4/Ajl1uyG9IMeceFQXxkRUN81GND7sFSBhG+BRcXcyRmJNANhQE6o+srTkFbo2L+uk2sZUwHVNb+PbUUhA1Ifrw+ReKPc+52WOJ2VKtgOG34tBG/4b6LBnN1OffbtvrDjsj3GlHGO6bC8AHNidYpxcq1thmYTuSK1t6CozLjrJZSdsHwj+AlWD1NLEq9YjjWUJViO0OGQ+de8gKiLD9aMG9JQYErnRKWx1/XB2i4Z0BbVm8X2TSbE7DFUlFGmHzb0RbZI0nBg/gW8xqj5hq6ovNbE8CcLjzfPLAoAQrYOeUtwTH8PxD+UTj9E+McwFkhbhb8u6xXZlBwrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead90031-4bb4-4bbb-50df-08dca0ce3e55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:51:25.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa/34LnD+9TRpb+hsKzxj7JVKM2fS9DNANBPym6C7NUj6Ybu2vYbWgXZymjcG4tJD9OADyL7n7L9Gln9qFNARHwH0JRRh4KvSu7uMO6x3Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100074
X-Proofpoint-ORIG-GUID: RkFCfuy62whinEY3V5AXEwVP-HjYyhWX
X-Proofpoint-GUID: RkFCfuy62whinEY3V5AXEwVP-HjYyhWX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/07/2024 11:42, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
>> tracking
>>
>> The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
>> tracking of VF pre-copy phase of dirty page tracking, though it means
>> that it will only be used at the start of the switchover phase.
>>
>> Add an option that disables the VF dirty page tracking, and fall
>> back into container-based dirty page tracking. This also allows to
>> use IOMMU dirty tracking even on VFs with their own dirty
>> tracker scheme.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h | 1 +
>> hw/vfio/common.c              | 3 +++
>> hw/vfio/migration.c           | 3 ++-
>> hw/vfio/pci.c                 | 3 +++
>> 4 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index 7ce925cfab19..9db3fd31cfae 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -137,6 +137,7 @@ typedef struct VFIODevice {
>>     VFIOMigration *migration;
>>     Error *migration_blocker;
>>     OnOffAuto pre_copy_dirty_page_tracking;
>> +    OnOffAuto device_dirty_page_tracking;
>>     bool dirty_pages_supported;
>>     bool dirty_tracking;
>>     HostIOMMUDevice *hiod;
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7cdb969fd396..eaa33d9ee037 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const
>> VFIOContainerBase *bcontainer)
>>     VFIODevice *vbasedev;
>>
>>     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> +        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
>> +            return false;
> 
> Maybe we can initialize vbasedev->dirty_pages_supported to false by checking vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF?
> This way we can avoid extra check.
> 

Hmm, I guess it's a matter of style i.e. the device may support it
(vbasedev::dirty_pages_supported), but user disabled
(vbasedev::device_dirty_page_tracking). It's true that it simplifies, but feels
somewhat misleading?

>> +        }
>>         if (!vbasedev->dirty_pages_supported) {
>>             return false;
>>         }
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 89195928666f..35d67332db20 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1037,7 +1037,8 @@ bool vfio_migration_realize(VFIODevice
>> *vbasedev, Error **errp)
>>         return !vfio_block_migration(vbasedev, err, errp);
>>     }
>>
>> -    if (!vbasedev->dirty_pages_supported &&
>> +    if ((!vbasedev->dirty_pages_supported ||
>> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
>>         (vbasedev->iommufd &&
>>          !hiodc->get_cap(vbasedev->hiod,
>>                          HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index e03d9f3ba546..22819b2036b3 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3362,6 +3362,9 @@ static Property vfio_pci_dev_properties[] = {
>>     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking",
>> VFIOPCIDevice,
>>                             vbasedev.pre_copy_dirty_page_tracking,
>>                             ON_OFF_AUTO_ON),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking",
>> VFIOPCIDevice,
>> +                            vbasedev.device_dirty_page_tracking,
>> +                            ON_OFF_AUTO_ON),
>>     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>                             display, ON_OFF_AUTO_OFF),
>>     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>> --
>> 2.17.2
> 


