Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA5EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrS6-0000MU-KT; Tue, 13 Feb 2024 06:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZrS4-0000M0-Ka
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:59:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZrS2-0000DM-5Q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:59:52 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41D9HkN2026936; Tue, 13 Feb 2024 11:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kEPSp0fVNYiXHiIDy4o25Jht13TjGZJpohNAxX9EJwI=;
 b=HqyVe0gG4fGyHaCsE+NwOdrRY/UOhlnDXXS4Go7hj1gr3cjBlgn1OmuBHbAXuHoM8A3X
 0bSlHcZRLpMy5cH6sbLEJ4v0GIvYYg4agFpPhibMOfxnIy+qz31hiycljaB0I+CRCynv
 ldyOS7yUlxrBzzBEY6Y0L8MZwhhb10SDLvsQlwowGcYDc4uNJwCDE8R8ZdMDPm28f77I
 l6nLTpWp6Z/dVbFilbhGXniftAHCE8LDoPzF9iCA4Z3oa481X4ydmyCUxZhHp8o4DL2P
 CpB6Aix7UuN5EqGCWPolT9xwIXkpPE8ZdqP41ewxOD37z6gXYhwI0+yUgi/x7Df3hFyG TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w80kvrvt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 11:59:46 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41DBLLKN014988; Tue, 13 Feb 2024 11:59:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk6y5bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 11:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIIhUO5mt7P6rgOG0fhixOq7N3YAXiTV8yz8COgBhpjsJs8iwzS3cfK8redXq+Ix08VIz+frE3c5yTMYRuWvUhv+yZKgF5PbIOiwO2sxr35m0P3XwdGzugzATysRW+5lC/XuG05wzdVwPkTA8UtRvhJdbUuNnyuUce/U2H4UTI1LemPiONjhyrzahjWxxbhz2VDuly6u7v+73d8hPqLvhXONMq2+VtnMqoubClVAAhe0ilUD9jSpNU8VnTvTScuAm4H7+j7bjiS1/bCY69MSxCUJPYel/YHxabH48I9DFX2svf12/NDv48GAdvvc0agWBA3xyDeK0wUllaVnnIfTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEPSp0fVNYiXHiIDy4o25Jht13TjGZJpohNAxX9EJwI=;
 b=Hq4Pqv5/pHEnLQr7n+b1Hv+cJz+y6Ow/63e1qDYiA/S9b4cR7K8V2b8d/gKKDTUiP+jKH9V8giM2PV1ygIpESkCIFa6BzKzfDj5ufzGj9w+D1H654IIGKiQ4g8HH/qJ7qFDou5+A7qUqHWSf25yoj+sPuaBr73hzF+5yXaFBydzv2xpQFc6V88UWZmjr8TtnCpN+4FgXIVkBQ0K9qMHEbzwQXoWBk5RwFx+3yJpjx04/JV98viELSzj9B49PT8WwpkwSsZhq1AjISp02jEbcJ9NX6ogh79YdRTdrAJ4NFPZ5KtrYvkyTmcoGfYt5tZ1GF96XXA5Tp50U9aQ2kdik9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEPSp0fVNYiXHiIDy4o25Jht13TjGZJpohNAxX9EJwI=;
 b=Bm8S7FdcqDFTs78mxg4mD+tnn++tOIMyNpbBMGK0ZoRYncr0jQb3sxmAgAlF9kR7cX9ylw066g5eAG529PQN5dPi0rby8MgYASiLljfz7anN4Bp/Haz0ycjleNjYciEjfiYoTEfsXvFEbosxJUeQV2lnrHJQhKd97Sc6euvtJNQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Tue, 13 Feb
 2024 11:59:41 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 11:59:41 +0000
Message-ID: <2540a4d3-c370-407f-8b97-9100615d2920@oracle.com>
Date: Tue, 13 Feb 2024 11:59:34 +0000
Subject: Re: [PATCH RFCv2 0/8] vfio/iommufd: IOMMUFD Dirty Tracking
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH2PR10MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a10ba84-bbb7-450d-ec04-08dc2c8b42c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2SlAJ5XGc4Lu+eJ/WQVMxodo5pkI248x0pxoq7JXMkPc55KVSn1pV24qxrsFbPd7mVHTZOTA6woT5+j9avO2WPigD7L91ouZ9j876EgJnormIDnJ23ormeKUI9TxdxcGN7j15HQv09sScoBMaQvSSGf7Nd37HWYMTzCMlpbw34De0PZK+BBLoVnnhg6U+dzaW+g2ydrj3zq+twIH78+U62/478lZbkgKrP5NxnBj08Xypb7s5O0XIYFTleNOy6aUQ+UO4tCqvg6d2hGMRWwvjpDr41DOLnZbKmbkSLCUQF51F0H0SqQq11pJFBBzTJjDUBeOZURQ1QNBREcVISBNHRLxynyZnJWFn9YpJmny+XMBBuK2SVe2d2qiUiKx8MpBXbHogsocCC4CbEz2lC65bKsmlYVboTVfSO4VCZ+f3fGhVGQATsT0V6qaQBIYeBT80Uh1ldlm1eBxj1mRHZLicbqC2uiz940ZiQ+Ve+Urer4JSzjqiZGNCzA99BfRdTPPQnwTueXii0M4Jw9wTqu6H9QUjXVEQ4tCjJMbGp8wGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7416002)(8676002)(8936002)(5660300002)(66556008)(66946007)(66476007)(66899024)(6916009)(4326008)(2906002)(36756003)(31696002)(86362001)(38100700002)(83380400001)(478600001)(6666004)(54906003)(53546011)(6512007)(6506007)(6486002)(966005)(316002)(26005)(2616005)(41300700001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlHc3AyaU81UUFZeWJnd3VnN0k0V3FsWEVBTUJyRVprTzlEckJQYURKQkd1?=
 =?utf-8?B?MUZwUW9rL1lkK0dybjRXVVo5MzRFdUdiaDJtNmhuVFFQS3hDSldOa0UyeVox?=
 =?utf-8?B?em5SZGkxQ3Uyb005My9razdMTlNyaVY4Sk9GWnc4MkpTVmloN0JsUS8xVGs5?=
 =?utf-8?B?ZVpIR1VvazBQaGMwR042YXp6Vk9XK1pEbTRLZ2N1RXlFVUdnSnkwVkUwZEU3?=
 =?utf-8?B?TDRIQW1BOUFMOHd6WE5iZGdLNml1blREeFdZNVpGMjJJQVVYa3lXVURVNmdx?=
 =?utf-8?B?QjNlL0h5NUhiazN2azhWcUhwL0RVVEwvZHo1eSs4TFhsZEVFREl2NXl0SGw1?=
 =?utf-8?B?cGIrMFZSbzlydHlaa2ppNDBhWGNsMmc3ZkNJUjNVUWhieDlpNzZKaVhpK3hv?=
 =?utf-8?B?NU5yZmR4VlljQ0hPVlNJSndJMFNjM0VCTjFuMXRQTGtoM1RtTjJXUnNKRFFy?=
 =?utf-8?B?V1dqY0N5S2JMWlYyUlA4dU5MbDA4Ukl5MUJsUWNSM0VWNUt0dDRmVS9XMksx?=
 =?utf-8?B?N09pSGRtWTR0a2JWVnB3SUxOS2pMNE5IMjJLV2NXRUt6SC9FRnludzJQVE9R?=
 =?utf-8?B?eWtIY3V2bmhlNVFaZnlCeElLb0dKOXlxSXp6VlJqNUtQQXF2ai9qL2JqNWVL?=
 =?utf-8?B?SzZPUHg1Q1FrNmw1MHI2bTFhVHVQR2lzdUUzRi9JckwxUE1NelRLblMvZzYz?=
 =?utf-8?B?aVVERTdqYm14U3dFY29tckFlK3pLaG9Xb3Fzb3hRQ0U2NS9TUEFhb0hjRWN5?=
 =?utf-8?B?cVhndmFrOCtEYkVpbDZIRUhZYi9xcHlJa1MvcjBuVUUrYTBlL2pQSUh0YXJ1?=
 =?utf-8?B?VU1hWTVwMjVoYXJHTWRXMEtzelZDc3d6eWx6OHNhY2s4enVTSnlLMVhVOXZi?=
 =?utf-8?B?bmVwUXJxRTBiOUdYL1ZVaUJoT1J3MnRRajRqU2wveUJmbkRpRGFSZ1NweTJm?=
 =?utf-8?B?cVpvM0FZMllaSEtXUzBva08rakt1YTBLS1B1eHJ3Zk04Q084aUJ5NFVpdk1k?=
 =?utf-8?B?V2IyTzBjNlNHUGVDOXJQcHUzM2RRYzN4K3dYSnpKUmtYN3R1aDlUdGJqYnQ3?=
 =?utf-8?B?QytaZ2t2QjZCU3F4S0FwYWpKNWhSNk05N2lxa2FVOVljczZSRHZsYzlveTg1?=
 =?utf-8?B?cjV1QjdxR2ZFRE9pd3NYcDBSWGNMdFpncVVMOG8yM3lDWjZ0WUxZc2NUa0sx?=
 =?utf-8?B?S3AyUzFBdENJcjhnb3ZiK0VNTnhvSGpEaDVIZmo2RW52aTNVRUVrTXluQkJW?=
 =?utf-8?B?SStGMDFoc1lMWkhkMG5mWFNCYnpYVUVYbnFnS0JKUlVsU2JCQmdaSVlGRjFj?=
 =?utf-8?B?YnVWdzhPeGpCSEN5VUlxak51Vm1ZcVZWc0l5NnQrcGFDL1B6RENNL3ZXeVBW?=
 =?utf-8?B?aERjNEY1VDFKSWVSUHZSeUxKM3ZIdlpVWFZta3Yvb1N5UlQwcUVISlBob0Jo?=
 =?utf-8?B?L0FJTmRKVmd1VUduNUVZdDduZW5ScVRnRjg1WEU1RUtScGpWVDhoVWR1RnNH?=
 =?utf-8?B?YytTbFh3YTNuRWg4UHdWcXZibzBwS2YyVXpKSEh1bDlkaXd0d3MrSXpTTGZP?=
 =?utf-8?B?Q1lEUDdzb1dVTjJIdW1ORGtMVVRKZnBPMWZ6SnBFTHZPSmtUU3JXc0xlcXJB?=
 =?utf-8?B?bUQwckVkMmlaSkZKNkVURHMrK2Q3OTQ4T0UzU1NSWXh4SlJ5SGNRTlB2VStH?=
 =?utf-8?B?ODZxTllqOUtqSDRhVHhBa0VGUWFvRWFDc09pbFlvSUFvWWFwTWhyY1pJaktM?=
 =?utf-8?B?MHYvWk1kTVpvU2tKYkozakFUOFNEMFRCN3lSUTZvTzJScndaa1lRNjQwL0h6?=
 =?utf-8?B?YWpQOHZpUXNIbVhSUEpmeFdMTmxBdjVzY2R3bjI2R01RQWk1U1NvVTZrbmly?=
 =?utf-8?B?M2RSSDRxOWczK1F1Q0Vib0NRejgxdVpBSTJRVmo4OWJEZUN6U2FhV2R4SlBQ?=
 =?utf-8?B?bTY4U0JTTWZyR2g2eHJoMlozcHJWWHB2cmZDdnNFMjExZUdqdngxU1JieERi?=
 =?utf-8?B?MU9QaWlkeVVyOEtlKzNhZnJ2b285NVZ1dW5NYnhYUDlVM1o1VFNyZStBWTdz?=
 =?utf-8?B?eU9WM293S1RpY21BandVTG5GandTckx0Vlhuamp0WG9VbGFCS1hEMkFycHVR?=
 =?utf-8?B?YTJ2c3MxdGpTRUtWUG52YlNIdVV5cEwyWDd3TUk3eVZHb2tibUN5TnFVNU94?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CvEnCwBB1vXqbFuCMTg5/ssWWEP88WYtxe2P7g9zuK3pNPIH34/OEC7JsPZE7cfjQoVFv5funtC/wau+qbmxxnOneTKR5/XwUZLT0VMOTyq/7gp08qc75SJDueopXXd6SWxyssH3OV3LWYKpknggWDpoE3YDyprCJtaA06FjgfugTPmejPyA0VIOnoqQ2rHyERf2F/tfhoVgFA7TFih2lcrKBNank+cbTXTk+slBsiPhq9bsniG3aFf0dfaOqHAx/Cn5Y+PaGH2LnUfAkGHjMShGivBMJbgA9wJVhGs13MiqPqz6e9YZimgZe7Ou9kHzh1Sy1aNCDMLeqCkAQ9UyZQNX44b9WVIOPXHKLnYhtnY5geY9cL4EHcRl1N2pWhp/Van4O/9QaUGrXG2wKv8VIeLbg0Q6rozm75oaqII5txHELs8vGdHVV5TltguyhtuzsUi37mVRZx2BhaH1DU2osx67fg6K8hkrI1g4+uuTb5CcF4khzhPP5kwIoMaEH5kxr/voWyL+j/F3h60R6d5IW9sDngaqFtQcSZ80hH+L5qSteDR+5Brh8xcVw1XfRMXgtWQmrhLtS3IUy8flucGtUZv7GMNELrO7QlDiKJKmHic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a10ba84-bbb7-450d-ec04-08dc2c8b42c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:59:41.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nelTDqN433ltBiM2AZOLbSORShQRmor8F691Ao3WsnI2hfSJpWYUge0IEYWGHKBYtO5c/naeXKQAlAbzfL+0OhOAI5R3gj5IumqPUqZPF4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130095
X-Proofpoint-GUID: 1pUL3SLlZzG9neVH0sMDLAVIW5KJpHfk
X-Proofpoint-ORIG-GUID: 1pUL3SLlZzG9neVH0sMDLAVIW5KJpHfk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/02/2024 13:56, Joao Martins wrote:
> This small series adds support for Dirty Tracking in IOMMUFD backend.
> The sole reason I still made it RFC is because of the second patch,
> where we are implementing user-managed auto domains.
> 
> In essence it is quite similar to the original IOMMUFD series where we
> would allocate a HWPT, until we switched later on into a IOAS attach.
> Patch 2 goes into more detail, but the gist is that there's two modes of
> using IOMMUFD and by keep using kernel managed auto domains we would end
> up duplicating the same flags we have in HWPT but into the VFIO IOAS
> attach. While it is true that just adding a flag is simpler, it also
> creates duplication and motivates duplicate what hwpt-alloc already has.
> But there's a chance I have the wrong expectation here, so any feedback
> welcome.
> 
> The series is divided into:
> 
> * Patch 1: Adds a simple helper to get device capabilities;
> 
> * Patches 2 - 5: IOMMUFD backend support for dirty tracking;
> 
> The workflow is relatively simple:
> 
> 1) Probe device and allow dirty tracking in the HWPT
> 2) Toggling dirty tracking on/off
> 3) Read-and-clear of Dirty IOVAs
> 
> The heuristics selected for (1) were to enable it *if* device supports
> migration but doesn't support VF dirty tracking or IOMMU dirty tracking
> is supported. The latter is for the hotplug case where we can add a device
> without a tracker and thus still support migration.
> 
> The unmap case is deferred until further vIOMMU support with migration
> is added[3] which will then introduce the usage of
> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
> dma unmap bitmap flow.
> 
> * Patches 6-8: Add disabling of hugepages to allow tracking at base
> page; avoid blocking live migration where there's no VF dirty
> tracker, considering that we have IOMMU dirty tracking. And allow
> disabling VF dirty tracker via qemu command line.
> 
> This series builds on top of Zhengzhong series[0], but only requires the
> first 9 patches i.e. up to ("vfio/pci: Initialize host iommu device
> instance after attachment")[1] that are more generic IOMMUFD device
> plumbing, and doesn't require the nesting counterpart.
> 
I need to add that this series doesn't *need* to be based on Zhengzhong series.
Though given that he is consolidating how an IOMMUFD device info is represented
it felt the correct thing to do. For dirty tracking we mainly need the
dev_id/iommufd available when we are going to attach, that's it.

I've pushed this series version that doesn't have such dependency, let me know
if you want me to pursue this version instead going forward:

https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps

> This is stored on github:
> https://github.com/jpemartins/qemu/commits/iommufd-v5
> 
> Note: While Linux v6.7 has IOMMU dirty tracking feature, I suggest folks
> use the latest for-rc of iommufd kernel tree as there's some fixes there.
> 
> Comments and feedback appreciated.
> 
> Cheers,
>         Joao
> 
> Chances since RFCv1[2]:
> * Remove intel/amd dirty tracking emulation enabling
> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
> [Will pursue these two in separate series]
> * Introduce auto domains support
> * Enforce dirty tracking following the IOMMUFD UAPI for this
> * Add support for toggling hugepages in IOMMUFD
> * Auto enable support when VF supports migration to use IOMMU
> when it doesn't have VF dirty tracking
> * Add a parameter to toggle VF dirty tracking
> 
> [0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> 
> Joao Martins (8):
>   backends/iommufd: Introduce helper function
>     iommufd_device_get_hw_capabilities()
>   vfio/iommufd: Introduce auto domain creation
>   vfio/iommufd: Probe and request hwpt dirty tracking capability
>   vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>   vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>   backends/iommufd: Add ability to disable hugepages
>   vfio/migration: Don't block migration device dirty tracking is
>     unsupported
>   vfio/common: Allow disabling device dirty page tracking
> 
>  backends/iommufd.c            | 133 ++++++++++++++++++++++++++++
>  backends/trace-events         |   4 +
>  hw/vfio/common.c              |  32 ++++++-
>  hw/vfio/iommufd.c             | 162 ++++++++++++++++++++++++++++++++++
>  hw/vfio/migration.c           |   5 +-
>  hw/vfio/pci.c                 |   3 +
>  include/hw/vfio/vfio-common.h |  12 +++
>  include/sysemu/iommufd.h      |  17 ++++
>  qapi/qom.json                 |   2 +-
>  9 files changed, 367 insertions(+), 3 deletions(-)
> 


