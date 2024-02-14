Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28316C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raI54-0004Se-MS; Wed, 14 Feb 2024 11:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1raI4w-0004OO-TP
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:25:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1raI4p-0008H6-7V
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:25:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EGEOxU022440; Wed, 14 Feb 2024 16:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3rceAz+4wy688jCAizDieDi85Jkf/XGwmgMH+3fuyUA=;
 b=VrJPqAI9sJEdgNKCRLhJPRbrlN5NACel9URHPdjq7BwAws93G0RQzTDjPCt4Nu33LTJO
 gY+f8UqcpkDNuVeyIXaf5XD3gTRi+mldv8SF8jImmeiK6OZnRyUO9skEbwgAJhnrymsh
 wVVAa/DUtjRGYH54svES+tcIc0CiV/YSK9L/7wRoBpiCMU9qKu62+AentAFO/2V6+xAT
 c6j6RQ9wNUuqPmcIfU7NpxYnE7dTWv8opk1i7cig2bOqEkZuFxP1EtbXQatLea9hyp7h
 2FQ8Ev9FQHZ7fU/IDit1nnHd8RqGno+iBNARp8S5agBdi0O4eSkbinCZPBQdTDlgqPrO Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8y6cgdwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 16:25:29 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EFCLFp000640; Wed, 14 Feb 2024 16:25:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk96jcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 16:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5IViUR++ORVPiv+aCNDVA6KE3iOEu5sJJ4qO8anfUudwyVPT82eRKj0eaJFbN7ZyszxhOeyO33BN8sGpQISIas1fUNmPpGtQvNfxR6cJ7VzJcpOfe+r0Iq0fHFibS/nMW5u6RTSiw+856tfyktMWIyIKwkn9EicCunjak9UxmCiDHokiResDB1IBIynD4zsKnuJKXzrpFB9p5Ss0ASLQfzk8D/p5uQjNOGrZs+p4jHpQnF6Zvg/8BbGSDXX5xV2dqGFKmUnZcmipyYXJPR3PABiiKR/zOkSYe3VZ9oNIPVsm48jcgRVd8F8e8Faw7gSkPml1Y2Hcjfgz5rkIVwrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rceAz+4wy688jCAizDieDi85Jkf/XGwmgMH+3fuyUA=;
 b=MlAd0KrR9wCSh6VmLONWJIpTwKZ5DqVxf5IY4XKfdv2kFysmZJhPVeLpVwkOBG+idVzKwz9l/UzRP2NK9yYRI/WENR8UfdRcGMCAbRUOvFit/PCruUPmXBhEc+/BDlOp6sBjg3s9ButumKGOkBiiTRCXZtxCjSo9pvOPFg400un9BxM43/U8vOyi8ZlHJcQGFSEVQMetBxETUGRLR1cFKJIidg/mE05PlJ93VY6SBsA0pW67QLBEd/JC3Dx9b5OWfV+8Beu/cpsERYqV66NulITQJVq8IRYSn/NvAc1zhQRbb5ANRrsttbj0SaOPW8bHqf9/8CAGSsBzEXswN9dIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rceAz+4wy688jCAizDieDi85Jkf/XGwmgMH+3fuyUA=;
 b=UYPvvv+thpTLqsRXANhlSxG2fDcv5Xx0ZP90NBf6+SUQw2IG5LDZAINVs3oS2RK8jQHRkYMnduQNw11n7F990+4Q5j9Yp7mljl7rd9TXG0TwmXXS5xpXasbWuKGp5F7S+aV8iCON7Ag0LrVvdieQ0bzsymd/QB1RDypXtJyWlkw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Wed, 14 Feb
 2024 16:25:25 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.042; Wed, 14 Feb 2024
 16:25:25 +0000
Message-ID: <69e35528-21c3-4798-a847-119939236347@oracle.com>
Date: Wed, 14 Feb 2024 16:25:18 +0000
Subject: Re: [PATCH RFCv2 0/8] vfio/iommufd: IOMMUFD Dirty Tracking
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <2540a4d3-c370-407f-8b97-9100615d2920@oracle.com>
 <a2ec891e-76fb-4985-a63d-b6609100af3c@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a2ec891e-76fb-4985-a63d-b6609100af3c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0383.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::35) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca0881f-e8bc-4f1d-2247-08dc2d798c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noL/HA5py3uK7o/iMwi9yzspMo0wT9nrzmbUgF8Y0HK0qDOlKMqjiTddi7woet23xVpV1D5fHTbuE9thfaj55KnoZfs4Y011j22iPu/MdJZVjbVkHYAQriXiVvd4374jaZuEumtLlUnWW8S3ogA418PhevHUjMheykr1cm2WBjRc55P4Zj2dzd3qm/6+Z3865YcEiPjomvBwhY96VTyHOXTWiG9CXhYVp7imXWsh+T2Mut0AxKNDds3T7qFcTTbuNORzqS/iVMRmx3Z/XeyBpPwJZs7AQSZjZzl7VHR2/dOYDCEWY1+pomb5O3KCCZVi2v5PdweKK1L06xSXMTH/T89+xXFyzC6jfLGROLeFRHMQbE+e6PDv+SBuR5P+GqigHhXVBQcgAzII7y/2G4K2+1TjsIjM25yE5r2i5yic6GoPHoTp1MZ3iTQh5pvAWQsvaeECzcKoZjo/ZsCiOknDAT5krto4few4Sqbz0hZ24SQs1uMv3wJfB/JjmZnYeFV4xPqfHfEdA4HoXnakwBvkTZ0qVt3DgWiBpVhu6KzHhkdN2TGdC/Z4tsQX8Qqq267t2BYKCHWbGxW+MC6BJpux0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(6486002)(966005)(478600001)(31686004)(41300700001)(66899024)(8676002)(8936002)(4326008)(2906002)(7416002)(5660300002)(53546011)(6506007)(86362001)(6666004)(66476007)(66556008)(54906003)(66946007)(316002)(83380400001)(2616005)(66574015)(31696002)(38100700002)(26005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1cwYVd1Zk5CYXJnRHpOaHl6Y3hCUmJrSGZHeWcyRzdkRjRYZnRaeEpqVml0?=
 =?utf-8?B?WloxQzRFREp1MVZ3QWlLc1FZREhxRnh5bHNYNkpGelJSNGJLa1h6Q3VKWmp6?=
 =?utf-8?B?S2JiSzhvRElINWdOaW9nZ1Qwb05kTkEyTjFPZnpCOHQ1QmJFa00zb0FTVjFt?=
 =?utf-8?B?azJ5cWF5NnY5UEwzVWhpNUJkbHRIbUJWSjZVM3lDWXIxK3RwdEpuOGdxMWd0?=
 =?utf-8?B?YzdsV25SSWVXanRvTlBWZncxaWdDWTA4MHVETFlwTlNWR2laL3E1VHA3R01U?=
 =?utf-8?B?dEpZTnhockN0Q0JOWEl0cUdidXZNbHY2RVBvK0hpa2pqaUlFcUpOc1RwdHNM?=
 =?utf-8?B?UFprSDVtdVF5QXJLV2oxN2lWdUhFUytBOHZ0ZVRhL0M4em04dGlqWm5aaDY4?=
 =?utf-8?B?ZjNBTFVRU2dNY2NLVm9kSyszNXBEYUZyNzlTYUdkVktwZXpkSlB4THMzajZB?=
 =?utf-8?B?RkxETzBDazN4RURqMXY0QWx2N3llZHdNTW5QMnpyUzJNN3ZxMWRUSmtoa1Fp?=
 =?utf-8?B?ZnNCT3kzTnhnaTdlUnlwYzQ5emFkNjBVYk9OaW1VNjBxRUw0SlZvY0JtQkp2?=
 =?utf-8?B?dXJOUkNGRTdkRWZyK052aTJNRWdXWTFFRXFDN0VWTHk1ai80Y0JROVNET3N4?=
 =?utf-8?B?b29rK2RuQy9CbHR0OHNBQ3JkSUJITGIxN2VYcTVYZHVuOGt6V0pjLzg5cnJo?=
 =?utf-8?B?WlhjZWJES1lsN1ZDSysxN2ZXVjR3N244amROUjAwbFRIR2tDOTFmUklLeVAz?=
 =?utf-8?B?NjVvWVRydmFXZGFETHhVY096VEsrb2k0cmZieG5hQXFuVHgxSkMwL3ZWTVcr?=
 =?utf-8?B?aThHM3FMOTRvRmRacGxmRzg5Q09RM3F2UStZNjZaWXd1VzJqUzBxT25rNldx?=
 =?utf-8?B?VFlFNjQ0VHg0SFEyL3ZsWVdtRGU1b0lrOC95RTB4ODZCOW9SNjRNaWY3ODZn?=
 =?utf-8?B?WjhKdkl2NzQyYjd0QkUzRUthdzdXOVZ5dStWaUw2Qjd0TWlTVG5zNHFkRDVQ?=
 =?utf-8?B?M21QTFpZZHl2SzB4M25tYnljenBTTk5XcmtrQ2ZvMTV2RUpoK2N2RTEwRnF1?=
 =?utf-8?B?TkNBMWhYL2xzTkZFZzlhWGVIWEJITW0wSHpub0l6cDRIR1l1dVBwRVkrb21F?=
 =?utf-8?B?cWtFbTVQVytndm16TGJ5TjdpTXAxN0s4T3BnU1ArYjIwVkZ5VCs4Zlowb29p?=
 =?utf-8?B?M3ZkZUVLSklyWmRVaDRPOFpDaDF4NnQyR1FoOExVRzQvNFk0dXRNZ2J0UXRK?=
 =?utf-8?B?cDZSaDcvRDN4VGNFb2hibElQYUdDeVhaczVpYklnZEtERjVjdlBhS00xVmJ2?=
 =?utf-8?B?ck52clhXRWZ1ZVY3cG1YQS9tNmFQemttWTRjTUk3NnZoSHNncEY4eHVPZ2ls?=
 =?utf-8?B?Z1lDcnBxOE5MSzNTbkFrSjAzdUhlL25nZU9ndzZsR1B6MEdQWUZnZkoxMzlE?=
 =?utf-8?B?SitpZlgxbWNkc3pOZnZuUTRWN2ZQYWV3Tkl2ZjB4YkhzUUF0Rjc5NXV4c3Rh?=
 =?utf-8?B?QjVrdk83a0V6N3VJQURadVlFNW9sTGJuODhjSkROeXIzbWhRcGhOTjFuVDJk?=
 =?utf-8?B?MTVsazgweXNWUjRqVFlBWm1uc0F2eEZpVnVja2IxWVpRd21QVkVVOFBQdjIw?=
 =?utf-8?B?ZGZJQzlrZWJEdU9zMzZnVnNkYUU5UVBFT0RCY3pLcUpmV2tSRVdmU0k0VGJw?=
 =?utf-8?B?eUlwQlVWODVTamRvYTBlbFdPM1NSeEt1M2cwVVhib3hLNU9pd0ZxdmR3WVVH?=
 =?utf-8?B?bFRzNnFBSE45eWJ2YU9uTWR4dURjdytqbFlFa2w5RVI1ZTB6QURLMEtIZnl2?=
 =?utf-8?B?ZW9adE1aMjQ4aCtVeXgrMmk0MGpyVGJOMmNSZkYvbHJKb28yQVVjWFFrclBK?=
 =?utf-8?B?Y1JMd3ZaWG5YUERUUFZjOVRoVmt6enRlYlFLS1BxaHNzQXVSNSs1bGVFQklM?=
 =?utf-8?B?cWZTcFJnV1h5RERUYmF3cTdFRURnT2l3QzlQWUFhdkZya21wVTdpM1RvTktI?=
 =?utf-8?B?aU8wNVl6c3JlWmVMS3pPdmNuTFhnenVvcFpvTGRBd3BWeitub0lmcCtXRWY5?=
 =?utf-8?B?M28xTTg1MUdJTDRSSSsrWnR4VFg1VFpTWEkvSytTRHVVTThGdzBKK2JJMVE3?=
 =?utf-8?B?eER0bWpra0hvZVVlVnNDNEFSZ3VIRXpZQytIZE5MYW1JUjU0NTREaUNhVFlu?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DwXoWaaCPHBeopw7VcbSEqoIcWaRm7UShdg2IzxpJ5SVTEaD5rl2hvjw86ZsOabKk6O9ztFl+KVVclYvpuR4BjrePghvNJ0414ZLiN8fA1g9pUltUbWwMDoxDG7nh2fuGg2wya0XkfuA9QRBtjYGaGEhVxhpPfEuNwX6//kaSmSaV2GlqC4P3tdjcRskR3+cpQN/q5jXWbpl2I2waK5vmTgEKZTBYlJe4xO/05B/QLUolrC9AVP8dNezX8S5OrvdcgxQs34U9Pxawwf8rS6DbBw39SFKqTNesUHSlZBtczL4iflPuNkxCQztJT7cknn1xbNlHzgQswnR2Bj7I6T6v0/rVcPawEVICQJ8lOWod/PDU54iKN3wiyCaXkNee7gzLnwTrLPVJ9tZ3mQ1zCynbv1x3xWsOaGAF+rak/ylC47ChqJ5k2HP//hoLllc3KJ/PzUjd2aENYTHoXHAzB/A0AIrwxHPW0aqSNMQyisDzZiyEwnpp8uAoN1nMJEzOWRFVqtB0MPc+k+yfgBQFVKOErh0sazRNFcVNLdD8K235vwqxyXRgUF7XurGS+wT9jVQyThss23GH+lkXyPLPX5fZWjCm7NEtYkfdFJoGKHcGRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca0881f-e8bc-4f1d-2247-08dc2d798c63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:25:25.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VLt+iOK0McBB1VzlITb/Sg05xHdBwtsUBIVX8C8sNwHJ1lh9EkKijkb7KN++LLG9T0lanA9BLVME+Z2P/Ua/keW5NOR+dB/S9k2e3Yvt6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140127
X-Proofpoint-GUID: bi5s9RZN9S75nJY-F81QIvAZ4qINQQGI
X-Proofpoint-ORIG-GUID: bi5s9RZN9S75nJY-F81QIvAZ4qINQQGI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 14/02/2024 15:40, Cédric Le Goater wrote:
> Hello Joao,
> 
> On 2/13/24 12:59, Joao Martins wrote:
>> On 12/02/2024 13:56, Joao Martins wrote:
>>> This small series adds support for Dirty Tracking in IOMMUFD backend.
>>> The sole reason I still made it RFC is because of the second patch,
>>> where we are implementing user-managed auto domains.
>>>
>>> In essence it is quite similar to the original IOMMUFD series where we
>>> would allocate a HWPT, until we switched later on into a IOAS attach.
>>> Patch 2 goes into more detail, but the gist is that there's two modes of
>>> using IOMMUFD and by keep using kernel managed auto domains we would end
>>> up duplicating the same flags we have in HWPT but into the VFIO IOAS
>>> attach. While it is true that just adding a flag is simpler, it also
>>> creates duplication and motivates duplicate what hwpt-alloc already has.
>>> But there's a chance I have the wrong expectation here, so any feedback
>>> welcome.
>>>
>>> The series is divided into:
>>>
>>> * Patch 1: Adds a simple helper to get device capabilities;
>>>
>>> * Patches 2 - 5: IOMMUFD backend support for dirty tracking;
>>>
>>> The workflow is relatively simple:
>>>
>>> 1) Probe device and allow dirty tracking in the HWPT
>>> 2) Toggling dirty tracking on/off
>>> 3) Read-and-clear of Dirty IOVAs
>>>
>>> The heuristics selected for (1) were to enable it *if* device supports
>>> migration but doesn't support VF dirty tracking or IOMMU dirty tracking
>>> is supported. The latter is for the hotplug case where we can add a device
>>> without a tracker and thus still support migration.
>>>
>>> The unmap case is deferred until further vIOMMU support with migration
>>> is added[3] which will then introduce the usage of
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>>> dma unmap bitmap flow.
>>>
>>> * Patches 6-8: Add disabling of hugepages to allow tracking at base
>>> page; avoid blocking live migration where there's no VF dirty
>>> tracker, considering that we have IOMMU dirty tracking. And allow
>>> disabling VF dirty tracker via qemu command line.
>>>
>>> This series builds on top of Zhengzhong series[0], but only requires the
>>> first 9 patches i.e. up to ("vfio/pci: Initialize host iommu device
>>> instance after attachment")[1] that are more generic IOMMUFD device
>>> plumbing, and doesn't require the nesting counterpart.
>>>
>> I need to add that this series doesn't *need* to be based on Zhengzhong series.
>> Though given that he is consolidating how an IOMMUFD device info is represented
>> it felt the correct thing to do. For dirty tracking we mainly need the
>> dev_id/iommufd available when we are going to attach, that's it.
>>
>> I've pushed this series version that doesn't have such dependency, let me know
>> if you want me to pursue this version instead going forward:
>>
>> https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps
> 
> I feel I have lost track of all the different patchsets.
> 
> To recap, there is yours :
> 
> * vfio/iommufd: IOMMUFD Dirty Tracking
>  
> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
> 
> Zhengzhong's :
> 
> * [PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU
>  
> https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
> 

There's also this one from Zhenzhong which depends on this set above:

	https://lore.kernel.org/qemu-devel/20240115103735.132209-1-zhenzhong.duan@intel.com/

But I suspect that part of it is stale already, considering a whole lot of
IOMMUFDDevice was reworked. Though the series is about bringup intel-iommu
nesting support.

> Eric's :
> 
> * [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged
> devices
>   https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/
> 
> Steve's:
> 
> * [PATCH V3 00/13] allow cpr-reboot for vfio
>  
> https://lore.kernel.org/qemu-devel/1707418446-134863-1-git-send-email-steven.sistare@oracle.com/
> 
> Mine, which should be an RFC :
> 
> * [PATCH 00/14] migration: Improve error reporting
>   https://lore.kernel.org/qemu-devel/20240207133347.1115903-1-clg@redhat.com/
> 
> Anything else ?

In terms of major series, I think you only forgot one. The rest look to be
what's out there.

Just to avoid confusion, yesterday's message was just providing an alternative
of this same series but it that wouldn't be dependent on:

	[PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU

... which is what is posted in this link:

	https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps

While the series, as posted, is here:

	https://github.com/jpemartins/qemu/commits/iommufd-v5

