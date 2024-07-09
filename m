Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F69C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9N1-0005n0-Bc; Tue, 09 Jul 2024 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR9Mz-0005hf-Qr
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR9My-0006MX-2d
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:53 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYEe007528;
 Tue, 9 Jul 2024 11:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=ml4/abThKwQ6kKT7jWQ1K99Pb8ENBiSGR9nrzUds3rU=; b=
 JVLKUyg8GFI6OuQ5DAH/qFAbnz8XE4/YHxfLUvTJiZ1+1Yhr2hUmLKutKd7ysyXg
 XucPSNDtDzXwNRYNcAtN/l81HetsxXEdOww/ooRAfR/T+E6w1rZ8zDD35Ov6u/gO
 E/De60IHM2JVkXBsYrmaJDWA6StYl2xUKekd1bQezAxhdoC8l8oa3K9Wh4eeg65H
 d0qPXsvtoIp8x39LRXwXaB7UNzqVGndKmzHLCt6bBXIowwdi4kW6O9j1+ewj53Df
 GRBXjXe0Y7FixpZgtb6AFqfcN7YZf+W9n9M4qeNNDRyPRlrRQ9YZbyUsSSDIwmyW
 CvH0zeguL4IEGtXcY0d1xA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmryd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 11:50:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469B13mT005008; Tue, 9 Jul 2024 11:50:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tvdhu6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 11:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpUXU0M/RGeKjce0/p4ZIk4AqljBHMmykaKp7f9F7lFP2bpBqvzwL94LTVY+1CDwsalomzg9S0NXAH9CHNdSvqM0YJp2YjCKzgVyDs9iT40BEVbzdSbxFYNaWP7zbgbSseF6PcGNnagTMiYBSJE4PAIYfHLjPS6sMWC5k17HtmsyFZmfdFL895MF88zB5MhazKw5yixGitRdQoUvc8y/2QJ4NDK7j8E9UIh3JPpkjM6fDSLsQVd/UDlAFGO+wPE1Na8W2log9lJHYlgRm3KbJ47iMz9mNuzfHziUIsPLG/gfsAAQtR+2+dOPKSVgXwBgSFJ9yACxa0NpYykBRot24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml4/abThKwQ6kKT7jWQ1K99Pb8ENBiSGR9nrzUds3rU=;
 b=L8oFecfvsZwL0rp2eAX9oRCaXze6qDfKhqZKVLZbn0sSO4dHRQioRd7ykeh35ZTyPYzyagQPFwuJZZoAXJaayPIblAEihJzHcbCNMWrlyKn2zQx5+WixuZ/7ntnk867SD+vbUJSkIpNr7UgnMw3TESavFWQ0L5Am8wNdrfKLZ3Of38QQid0oNfHqNCnaWIqoCy/Xc+lqdJSb3uaPazK0iFaqs9kyDiK46NfL1M4/VVs3CvPCj5mt5gFoCjY6ABW0+MC88iYTPiqQLrmaRcFC9B5V+mDfQ9iDbvoMlcT/M+Ruol7T1VP/z3G3s9nmXqaRYCcJyAblUiRLseZ13YxWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml4/abThKwQ6kKT7jWQ1K99Pb8ENBiSGR9nrzUds3rU=;
 b=lPGk4grrG0ORe6IcjxOejvJKjZrhqd95XmuzXOtoNANB1NS0JAplJkQeTnhp8LGug72qEXkFrlDQ8zc7WjGY5ZWaXj+4GUxsHqEpx7yRmQgUYmylpaLng3YiLzK+3QPXN+LBl4VtU9eDuCqOkFxE5wrN23LVHIh4GLdSkCFEcj0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7301.namprd10.prod.outlook.com (2603:10b6:208:404::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 9 Jul
 2024 11:50:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:50:45 +0000
Message-ID: <47f86137-a47a-4fa7-a899-39c8f3bf4cbf@oracle.com>
Date: Tue, 9 Jul 2024 12:50:38 +0100
Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
 <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
Content-Language: en-US
In-Reply-To: <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a2a3e3-908e-44f6-a621-08dca00d5e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFRyQys0UVVXaW1BaTU1Z2d0bnMrUkdyelhTWTNJd0J6WjNvWDFVSlAwaXN5?=
 =?utf-8?B?anExdFdGUDJyRk1obHUya1EwVkVKR3liM2lET09pMkpsWGhtM3daVlhjTU92?=
 =?utf-8?B?ekFpSjNrQjE3ZDRvMGtHQnducHdmSCtuamhJOUxJb1VUODVoSUQ1UmJMakZh?=
 =?utf-8?B?SUwyVU13OE96eXFKK3NDeVZFRDlMYzZYL25KVkJObXdJV3JraG9sMzBiNWhx?=
 =?utf-8?B?NURjYUpwcjRtOHlUU0QzSlozdTQvKy8rNXdKK0NZS1AzSVZmdS9oSXVZWm15?=
 =?utf-8?B?aWxtZzZScllaQkltV0lobzJpR0IvdXFkdSs1WmhJRG5Od25mRFYwNk5qdXdS?=
 =?utf-8?B?WEt5YVhQVFJIZVdNR21CUExwcXN0a0x6S1dncGYrN0VYajZuL0VBQVZhRWNW?=
 =?utf-8?B?R1FQalNxNE5GOXpNT1UwWTFuUldZbHM5MldwckxiaHJBS3U2RW9oZ010bGp6?=
 =?utf-8?B?OEdleDdNTFd6Y0dFUGtHUzc4RHkzSFZlWEcwUDkyRzY1ZVkyUEJTelhuWFZF?=
 =?utf-8?B?ZG5WeGI1blpkUVhFTDlvMmN6LzNsaElPeUJ6UVM3R214Z1lqVjN6aEcrZUg3?=
 =?utf-8?B?YThLbXNpdlZnOWNCQUs5VWd6NVRvKzF4Q2hPV0FQLzc3RUVLU3pTNi96cEZk?=
 =?utf-8?B?RHBUNlhZQWFzMGd4K0lFRE5DbERGbm96RExhLzJNdmtBSUVUQmc2NENQOTJy?=
 =?utf-8?B?aXhoSWF3L0FEeXpkZXJwVXVlWWZJOUFFb1U5ZzhpNXFaYTBkbFhUQVJVSlYr?=
 =?utf-8?B?U1BOdUwxZW5EWmNlK3RjRW80Y1NUQ2dSMHRmY3V2SC9EcGNFNDZUcWFvNXZo?=
 =?utf-8?B?RWV4REovUENDcWhUdyt1RkhlMi9jOHN0ZGZrSVNXODl5LzNPc2oxclpJa0hW?=
 =?utf-8?B?VThTdFpsNHJuQTZlWFpXZ2ZJV2tlVzJBYStYbW53SFdkaFN2RTNLekluMjB3?=
 =?utf-8?B?U0RMTVJYU2hVbitCMXE5dWdWUzk0UmZiUUxBZyt2Z1NTMEExY2dxTWdwdDdL?=
 =?utf-8?B?MWhmaU9oYmNFNjB1ZENLRUYzWEN3TW16ejR3MWNkTXo2MVB6NWY1bHF5OXZ0?=
 =?utf-8?B?Ylh4WjExenREcEZDc0tDRkhtTURnR05SNkRocml4blpkV0I5ZnNqWEQyNlhJ?=
 =?utf-8?B?SjhhNUVQcm5MZlZrbHBtdytFVUFyUnRRNVRxNmMyUHdVNzZXWkZHeEUzUE1r?=
 =?utf-8?B?Vjh1L05ZbE9aL1N2MGlCVjl2c1FQUTJROGw0bWNUYTl0enhUM0dXR0hkMHVU?=
 =?utf-8?B?WktVeDJXUUlUQzMzeUdlN3lmd05VZ05xUFpvTjFhc2VZS2JYZ3NSSHdHWjFF?=
 =?utf-8?B?L1BlUVd0MCtkNnI5Rjd1cEZ2enNueHJySVlsZjdoMkZMa084dnlLMmRuaVJR?=
 =?utf-8?B?Vm8vZTVna3VmRFhVaURDWHVOVlVqVUZ6eSs4dkdYUjNZcXdKNjNTa0ExUWtt?=
 =?utf-8?B?OXNXQUtnT2UrbWJFVWRiZmwrNTNqT015QmdqamcvdkpZVXhnQm9xaGFyRTRS?=
 =?utf-8?B?VDZBVjJvMWJaSVNFeG5YUHhlSC9TTWxIWmM3NjBzL1FnOFRmTnRPOHhSbmNM?=
 =?utf-8?B?dXJmY01KdGtMdXU1eG52bERnYkFGNEFzRkRUaGJ0N3o0QzVGWENQZlM2bXhq?=
 =?utf-8?B?MjVtM1A2WmpGNlIvY0JTRFUyM3lDcjhYYXlrdElzKytacVhKbFNnTkZMSGxx?=
 =?utf-8?B?TGxtMTQ5c3dNZ05zVHJWWUlmYVYwSDNEYkVvYll1N3U4LytCakg5NjlZUXQ1?=
 =?utf-8?B?TjliQnZOQ1VlbjFKS01aTGp4Yjkxdm94azFZZ3BoS0wzZWl3UGlveWV1YU9D?=
 =?utf-8?B?dHVXYTROZHVaTWxPOWZGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTA5N3FlQ1hGcXNFbzU2dHVZOFlYQVVuS1BMMnNqSm5aZ0ZlczM3R0dMczg2?=
 =?utf-8?B?TURXeDEyRU9QYWJIUVNVeEJRK1Z6RkVvOCtpVG9saHYrNGRqOC9sY2VWdWtJ?=
 =?utf-8?B?OWVycTYzZldlc0d4alBFbGRlZFpOTS9YWnBkQ3lDcTUwcGFZYVRQbzhVb2g1?=
 =?utf-8?B?T1cyalVkbmFBY1V6NnorejNPL0NzeFJjRWZKVERmcjlQcVFMS0V3UFVtZXMv?=
 =?utf-8?B?UzhkeklrSHFkOVducjBEdjdvZWNmdG55TENjY09rdEZVNEttT0o1UTBqR1hT?=
 =?utf-8?B?R2NxR3c3S0xqQzZFeS80a1lUMENRU2dOQXhYSUp3bnpya1hEWGtLcFBlVktH?=
 =?utf-8?B?Z1pOSVVxb002QVh1blZDV2VnMU1YYmdHUDlnckE4d0FyK1l5Vm9CenJhT0x6?=
 =?utf-8?B?d1h4Z2JEZGlpNWhHK1lVaERpOU1MaXJacXY1VC9SYjRmejhBak9XbWZ1YWVU?=
 =?utf-8?B?d0ViUHZNWlNaWklqSXhyR1krN2kvYytxWlpKdFpWRE9XUE5zdDM5aitaZWc4?=
 =?utf-8?B?bzFHUEZ1WnhreHZxSklIdE04MU01dW1XTklzVVUzL0tiVDB4S21jUmNMd0V2?=
 =?utf-8?B?TFYySDB0ajhSUmFZWTFUL21uSzIxL2VuOHVGdC9aUWhnaTNWeURIRFJSNkxX?=
 =?utf-8?B?TjNhRjl1RHkyTlZVTGJITk9iOUgxNE5UMEVDUXMxODYxaDFHZ1BVd3RlakNO?=
 =?utf-8?B?bHB3TUowMytISmhTMSt6eFBGaVMvMVUweGdUd24vK09jMGl3ZCtzL2R6UVdR?=
 =?utf-8?B?S0ZxbG00UmJvSkxrYUVUbWpWcVl4QWszT3dsR2VoQ21WTngwTzRWb0tYU2Ry?=
 =?utf-8?B?KzdkYytWK1ljTGpBdXRCZmZqRENTb29HZWcyZjVJWEEzc2lMWHZXUDJML0lU?=
 =?utf-8?B?N2d4WFE4VW9iZjRpRXUxR0l5UVhyTlNva3R6OFRabk5ZMEpRK2ZOSVkxS2xD?=
 =?utf-8?B?bnhsUGdxRU9TSERydElUQWo2RlVJOXByZi9UUDdDRU5OYWlad1Q2OVNTcXNP?=
 =?utf-8?B?YzBJVEtLNlI4SUNQMVdIL1QrZmh1YWIxL2lxbWxnbjdEdUY4ZDBtak84S2hq?=
 =?utf-8?B?RzdEWndSbGw3Si9LdFFYKzIzaEs2ZzNRbnJFd0ozUXE5aXl6VDJVcDU0VVg2?=
 =?utf-8?B?djhkM0ZZUGZTTXBXM0toaEpRMGk0eHlwbWplZlpZbVA4b05GbjFrUGJCUDhC?=
 =?utf-8?B?UnNSZnpCdFQ0YlVjZVZSM1FPOEtSQ1IveU54VTBVRyt4bEM5cUJockVtb1hY?=
 =?utf-8?B?azlGamQvS3J6dmpCdjJvQnQrVzhaK0hXejUvTnI1R2IvU2c0NEFrZ0pxd3NP?=
 =?utf-8?B?RTRPNldkeGxZb2wrcEMwbFA5TjdWaEdWNEVzMG5ybklRY1Z4S0ZnTXBvcmpL?=
 =?utf-8?B?a3p5d0UrckxoZys1M296VlI3VWRzY1lhREY5aHBPcDFsSS9wdlh5aHlOMVdF?=
 =?utf-8?B?OGYvZ1JwV29UYVA3T2xSVXVWSHdmaEMwa3NHRXA2MUNmbmdMbENlZmZmR2pj?=
 =?utf-8?B?VVNkWHllRjlXbUNCYVZ5QmdZVjI5djQ0T3R1d1ZKaTRGYlNHUXdaZjRUS0ov?=
 =?utf-8?B?SXFOaFpna0NaV1ZGazdaeksxZFRUWjgzcmxmV1FVNVA0Z3ZiWS9KK0lxaGFM?=
 =?utf-8?B?YWxmUG9tM056NnhXRlg2TzF2ZEVnK3ZpRFZrbThZOHFYM2ZkNkFicUQwc0hk?=
 =?utf-8?B?dmVWeGw4NmxCNGlpbUQxK085UnltUy94Qm41UHpvWExUbTJYVEFnNjhTNHBI?=
 =?utf-8?B?M3hzOHEzWnBwL1V4VXg3dzIzalJKRkFxZGF3RjI2dktQZGR3VGlrVWk2NGF2?=
 =?utf-8?B?SlBUMU05ZWx5L01id0YzMEpGaWtYRDdEMnJidDY1aVpBYU5wczgzWVVkcnRP?=
 =?utf-8?B?SlBuT29kTCswT2FleE93dkg4bUExU3Y3WjFsNUo3UUF5MWxKa3d0Z2lRVmJV?=
 =?utf-8?B?bUNGVVdLT2F2WHhHK1NKK1NOLythcWtEY3dPT2xQTGNqVXlpV2g4NkJVQTZv?=
 =?utf-8?B?UHJFdW8vam1mZkdpNXRyak5FWStieWFlQmN2ajA2M0JEVmdRdTdTb0dMeVpz?=
 =?utf-8?B?VFlnYlVQcVN1WnRSOUZJdjZaSGx6Qmx1VTJKN1kxUkcxdzc0R3c3OE1NRDd5?=
 =?utf-8?B?NG8zelZ0dHJpekNNUFIwWUd0Y0lwZGNTQkhCcWlnOVN2bS83YkNkUlBOWHJp?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tfRhVrhaJF/v2HpaKq9LHEsVFWA3qd5UxWE2cXye4C6lFm0RlD0CMioH/goM2RsBerRVZIhirBfFx8OcUITteKEgySQeHexTe5QhFr+R0RCwoGwSHBWOHejqjECKDn0ONve3TOUUrGZh1Tu2NTzMQKEqJ8LjTESjAtzEnttq1LiNm6uLVz4ABXmExGCSgY5iZat6aF8qUg7D+d1nn2fSHJZzIE13QlEtlBw4VWI5LwR3djg68R6mUxNufU8ONUz3R/gqP8Ez+yIN1UdUJnCCttw9rfz/YX/Ivvr31JbHHVHr7m1Vbolwnz9o7UJSDOhvik2XaVZSYW77AmehxaQf5uGFwZkb3ibV6tT3cJUnjHkSfZR7jPMBxeCr2ZrEzamF1jete7kpkkK999ogkjoo/BS5cXq5VAiMkcPs+i6E2K/TlU+WLvGyd0Q/mWMj6RUeZK+wRixdcv/Awege25m4riHFb0fIzGGvc0e4XCNmKVWpcs+fk43OtuH7WHvYAutjmZrNv1h96Iu2ImAJesR08TNKW2T4cdQjxEqTHesnYd89Et5No0ewoc487MSr3I0lGX2lDHr2DfchgGta9GvEEGz4GWcBcplXDFWoTjtmJoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a2a3e3-908e-44f6-a621-08dca00d5e00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:50:45.4326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djHE8iKIevQAipUP8pcWu3EOzU9/D0R6zLYW5M01TPOgK8j0g+UWJrIWSjiKufSOLEVutqAZR8uOt6knK3cti2xkHulrltrQcfvN/GWOddA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090079
X-Proofpoint-GUID: KpwD88S41PPfOCIc0ODKjyQxkmfopUVA
X-Proofpoint-ORIG-GUID: KpwD88S41PPfOCIc0ODKjyQxkmfopUVA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 09/07/2024 12:45, Joao Martins wrote:
> On 09/07/2024 09:56, Joao Martins wrote:
>> On 09/07/2024 04:43, Duan, Zhenzhong wrote:
>>> Hi Joao,
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>>>> IOMMU_GET_HW_INFO failure
>>>>
>>>> mdevs aren't "physical" devices and when asking for backing IOMMU info, it
>>>> fails the entire provisioning of the guest. Fix that by filling caps info
>>>> when IOMMU_GET_HW_INFO succeeds plus discarding the error we would
>>>> get into
>>>> iommufd_backend_get_device_info().
>>>>
>>>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Fixes: 930589520128 ("vfio/iommufd: Implement
>>>> HostIOMMUDeviceClass::realize() handler")
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> hw/vfio/iommufd.c | 12 +++++-------
>>>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index c2f158e60386..a4d23f488b01 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -631,15 +631,13 @@ static bool
>>>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>>
>>>>     hiod->agent = opaque;
>>>>
>>>> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>>> -                                         &type, &data, sizeof(data), errp)) {
>>>> -        return false;
>>>> +    if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>>> +                                         &type, &data, sizeof(data), NULL)) {
>>>
>>> This will make us miss the real error. What about bypassing host IOMMU device
>>> creation for mdev as it's not "physical device", passing corresponding host IOMMU
>>> device to vIOMMU make no sense.
>>
>> Yeap -- This was my second alternative.
>>
>> I can add an helper for vfio_is_mdev()) and just call
>> iommufd_backend_get_device_info() if !vfio_is_mdev().  I am assuming you meant
>> to skip the initialization of HostIOMMUDeviceCaps::caps as I think that
>> initializing hiod still makes sense as we are still using a
>> TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO somewhat?
>>
> Something like this is what I've done with this patch, see below. I think it
> matches what you suggested? Naturally there's a precedent patch that introduces
> vfio_is_mdev().
> 

Sorry ignore the previous snip, it was the wrong version, see below instead.

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c2f158e60386..987dd9779f94 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -631,6 +631,10 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice
*hiod, void *opaque,

     hiod->agent = opaque;

+    if (vfio_is_mdev(vdev)) {
+        return true;
+    }
+
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
                                          &type, &data, sizeof(data), errp)) {
         return false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d95aa6b65788..f092c1537999 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3115,7 +3115,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)

     vfio_bars_register(vdev);

-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
@@ -3238,7 +3238,9 @@ out_deregister:
         timer_free(vdev->intx.mmap_timer);
     }
 out_unset_idev:
-    pci_device_unset_iommu_device(pdev);
+    if (!is_mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3268,6 +3270,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
+    bool is_mdev = vfio_is_mdev(vbasedev);

     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3283,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
-    pci_device_unset_iommu_device(pdev);
+    if (!is_mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 }


