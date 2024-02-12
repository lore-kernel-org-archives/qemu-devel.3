Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DCBC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 15:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYNh-0003DX-Ov; Mon, 12 Feb 2024 10:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rZYNf-0003D7-He
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:38:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rZYNd-00036D-8k
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:38:02 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDxPF7013947; Mon, 12 Feb 2024 15:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2MuSCSIrJxqIAb7kTQmRRQwMa8c4DN3ZZnkJvU5ta54=;
 b=hlMFzDahyoKoz79Yl5bQxInl1oj9omLk/12v+oas8WkCz2SE5LK7bZQS4UeURyIvT4iG
 coSMcf0tisVhGrwkgqGay76r2Qxy2G+DdeTREAYYlSbdBl1ZSrAiPUPa+p4pxAnWXDxO
 TJVGnJ03cmFOHwiulIyQNClIyI1iRRuzQikO8BHNvinvUpdurFkLZWncdEmeTwozx00i
 uRXQ7CoHIQmgj6uQ7/UvEVRGwnGyldGeyles5+uEEAtXhwHOyqFL4a6Wn/pIOKfgUoGI
 RSfgaFluvsrlMKftcBCjBDfiAO73/TYiYc1XbnYVESAk6VGKSp/tdYFjnS5GMPglvTJt Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqg81b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 15:37:56 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CExTV7000883; Mon, 12 Feb 2024 15:37:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk5x342-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 15:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn5Qb1AmKsucg2XZGPPh0P0/4vkJNV6W3ykoRgaQ/j+4ENrQ6/yewjfyCSv3FkEXtu/ssEKQr8mAte7YNTfIn/RKTsYiA0sZFEjQ8USdPH5zY4NeZPfUefg+CXYqbXfpOAbONmI/VnKLh324DXJ8Hfmpj4KnKWoJ1HibST4M0uTZ0bYHYw0yp2b8crVD4iFRZee9pEumUTX2r6sv/DH+IrnCTZcl2j69S4sctvuFj4lzbfpKOS7TEsU7J0jGaoFcR6GFH3aWYWWX1ILvKB5I0yuBs5C7sirK43oA2QbNHXCynUT1QxgmNAErZdei3uNprSnywQ9wTGo7zC8Z65QVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MuSCSIrJxqIAb7kTQmRRQwMa8c4DN3ZZnkJvU5ta54=;
 b=Smay/d5KkFC6UM7J2v0q+MiXmucIndQ6GeZiZzVVUAa2A+YGu6LGZFAZRIi9lPSub7/JLkNPxX54w0Y+dJhNntxCrZNsuFPoq+Kd9OW53tOyux1FmDKzzUjVt4Ua6Pwzgs/JBZ7bVb706r9ZmtEvw9h+nzNEhxhgo4iFvqSZzWZWOYvD6+2/BNkx9nFApXsmMsbvJw7C8b68PTg7YlpvHGOAAPcQ9peSoEpQXPIc9sF+35UhZtyWZztHdLBko5HSaGBqmwPZCfT2tODRHflrlcLq0BVjpMLHZ1ZzpqDdr4UPiecGyQN7jCawnpnccHGA22LwAM3WPecV3qb327Dp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MuSCSIrJxqIAb7kTQmRRQwMa8c4DN3ZZnkJvU5ta54=;
 b=c9P6vy6TIUkLWSm/XyFxBQxM3LpWzymgSuppShUtU4+QEt4AimP1xZbyPYemUkbwvAq7uIqiVkdj7r2DSqyu3zZcR+LJke6w/Y2SVKeMMOlPThgRH2bi70rQsoztX6fTlyr7EhqBnhvGfkXFeLjXsRkZ9tYeT0p0I8bK76jv/RI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 15:37:54 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 15:37:53 +0000
Message-ID: <b1db8a19-42b0-4016-9ee5-8a0afad1eef1@oracle.com>
Date: Mon, 12 Feb 2024 10:37:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/13] migration: notifier error checking
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-10-git-send-email-steven.sistare@oracle.com>
 <3e610f67-415f-4cc8-9ef5-5f9587414271@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3e610f67-415f-4cc8-9ef5-5f9587414271@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f52623-fd39-4ac9-e0c6-08dc2be0940f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCBCk/dwe6t5NeNjEZ1TYYilus/rbTkX06IWSYDc1F4UC9Ov2ogOLnaf8qZWw/aeMO4zSZeEYwaRRgT66eqXtONdElFFyEt3K3d/hhWnWrK1BcEYIUfBBcc2BEouQuIRXy+IcvMpF9rPxZOLEy6AQleOsdnh/xwRa7hRkWigbCI1xFPfYNSrf4Ia15iysSawfsGusF8ORtqjZ2gbRJRVyJBsCb6LTVr+aLbR6RLA3wDsNdhlB0pzf6l3EbrQfc37cKSkhkUYXz3SPbjQuooieHFuoU/VrJK+w/s+i/wQbAH2rjN2r3hUFQz2MsiZZDNnJxw04iGxB2BJCDab328uQsMc3auL/UHbORyosEGAQyxRxw38LmkyAcriXRFEt3X93wA0sas3ymWfI1pF1K8JaSQl2I0cY15DWu054NdyXop8QE52FrCfus688GS6G11IifmCMRFeRjshqSE8z2iNQ8mhcFll2sYJNYaYHDb57BKNnfLvOH4VcO4HgsJkKZ2WI1KjP8M5mfN0pE07tDI/okvW38XKh/PszwEro8LbkFWa9Qvm5woYdxtUiOjDNF08
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(36916002)(53546011)(83380400001)(6666004)(6486002)(478600001)(2616005)(44832011)(6512007)(26005)(2906002)(4744005)(7416002)(5660300002)(54906003)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(86362001)(316002)(31696002)(38100700002)(66899024)(36756003)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1F3RXVUbW1MOHd2VmVnOE55T2VqdHNWcFVSQzE0SlBJa3NDczFQL056L3pO?=
 =?utf-8?B?NmgzMmZXeWh2MzZySGtiSXVUVUUxY1ZJdTl5cHMwYzN6VHZVZDh6K1FzTE1v?=
 =?utf-8?B?UVVQTVo5a0pYbmdQWUZWRGw1RGhSWXEwNURDK2hVbjhUOXlQN1p2K1lZS1lJ?=
 =?utf-8?B?cWROdlVDQWUxMEtsazBLSzlFc29EalRSdXVpenRLS0JhekJQRWFyQmR4Qy9G?=
 =?utf-8?B?aW11dWlHMnFCRUd2RmFJcERJQXFBcXhtMndpcHFGOWNwUWt0NHhKUmp1Lzc2?=
 =?utf-8?B?WjlSeGIzYXN0b3JGWUZzcWpHbFhFRWN6Mlg5VWNmUEI4a1NoTFNDUUJlUDd1?=
 =?utf-8?B?dWsxKzNOVzRSd2tHSWlOVUlwQ2M1amtLSlRKVlh3SUhxYXM1ZTk4Ly9MTSsx?=
 =?utf-8?B?U05iSGorUXl0LzJrQUhQSWxHa0hNUjZSbFJ0dnRCZzdreGZOTG5VVnhtMlA5?=
 =?utf-8?B?eFgwQnhOcjhyWm1YOCtiRzVabElyTDlVTnRXemtlMzdKUVpVR3c0SEJWVElY?=
 =?utf-8?B?a0FDbTBQdlB0QUJJQ3gvMW1SN2dNVGpUVlVndGVCTHFCcmp2Q1JTRXZxZEJt?=
 =?utf-8?B?YW94RUpHRkpuVlJHUDBJUGYzbDMzVXpwd2YxVzVTUzNRWnhaa1U0Y1ZzRzYr?=
 =?utf-8?B?ZFNSV3R3MnJZNFVQNUtENmZub2JSUEhWc2o2eXZlL2VSemxXYlJnNGpKditt?=
 =?utf-8?B?bWovbGdPdUR4NHlCelZqb3B2NDdIUnl2YkRWUGZGblJ1cVZ6eFhWV3pPSTMz?=
 =?utf-8?B?MXdGYXIyWTR1dURRYTgrWm1EMnlRY2Z0ZWFST2h0bUVlRXpFaGQ2S0RCZTFt?=
 =?utf-8?B?d3FMVEVMaUVmZEU4d3loRG1zMWQwMzJHOGxxQ3VGUFl6T1JMSURUSFYwTUtJ?=
 =?utf-8?B?RU9LbHQrSFlPbWRCaERJZzZUVWFqMjNGR1JETXRzNGFjajVVM29KT2E0SkxR?=
 =?utf-8?B?K2k0ZFRJc1RMVHI0MWVBSlB2TS82RG1CRE5VSkgreENDaDdNNDhRRVN6STBC?=
 =?utf-8?B?dEphWW1ISWE2VkFFY0RyMHBGdGw3TG9ORGJteG5jd3ZNY2MxbjBZbHlCbHJG?=
 =?utf-8?B?djdiYlQydFZLQndrZ1ZlbzBncWM0KytDemxVOS9BWHZWdnd2LzI5SndjNU5G?=
 =?utf-8?B?SXBqZjY3d01lWEJ0MGtSYklKVk1UaXpmWXpodHRoUHp3MWd1S0s1Z2xGS0pw?=
 =?utf-8?B?bWczQllaL0lNLzFtdjh5MFV6bXprbFB5djVNSGpuOEtVM2JRVXc3d2RQTWIv?=
 =?utf-8?B?Z3U4a05ZUGMyejJRdFMxNncyRHlTc25UVEhPWXgvdnNuUFRadXhZRHlZYlBo?=
 =?utf-8?B?akxjWU4yaFExWGZKRmJuc28yUDVnTVNMUnNEMk5odEpSWDlVMnJOeXlRZVpk?=
 =?utf-8?B?L3A3UUJ1SjhBM3VmRVJuaHhrYUg1R3A2NHBsZEhUbVBuUWZBSm0wWE84TE5B?=
 =?utf-8?B?amFrTHd2QVV0bm9GVjVkMVFPVGdGRVQwNlMyTlZHUXRCb0JVWUlEY21yc2pX?=
 =?utf-8?B?d0ZwN1JkWm5EVFUzaHMyN3lqdXlYR1kyQWZLK2xETGZqeGhybTByMVV2OEM5?=
 =?utf-8?B?dnFIS3RTRGViWktPMG8waEczOVZZVndOUkFIbEMzR2FCUVZZLzZOS3BWQmNu?=
 =?utf-8?B?WXNRa3E4ZitqNFYxdEptWEhNRlZOL2Rwdm5uczdGTVJhR1MzbEprWFNwMEJO?=
 =?utf-8?B?WG9uWCtCellsdXlqS1pQTFl0VHVwb2R3ZDZVckpzdVBSSnZFZkI5MDU3Nnhq?=
 =?utf-8?B?Uy9sS1QwVEM0YVN2ZjRZRkNPZVNpeERUVlcyREZrMGtxRjVJVm5WZVVNUVNt?=
 =?utf-8?B?VVpTQjZHazR1Uk5HZlBkWlNQZWc1SDBpNElnem53NlYvSGhBMEJ2dWhZYyt5?=
 =?utf-8?B?Mzl0TmhPVU85VDZ2RDVSeTV3OEdrdHlONXNnOTR0cUZQUmp3S1hzb3BFcDBa?=
 =?utf-8?B?Z2FlaFo4Zyt1NmlkcmhSRWtwNGdJdENyN0hFWGRCQWM4eTBrT0dhcldoVnlJ?=
 =?utf-8?B?Q3JySW5EZU5Zc2JLRGZCVk9mUE50TXo4NjlrWTBVWU5UNVI3Z0NkSHEzdU5l?=
 =?utf-8?B?em93RUVyZDNDTFFEL2gwcXRwTUcwc0ZYZlNpNG9VR1ZxUHFaMmFvNmYyeFZS?=
 =?utf-8?B?RGl2NkxyM3RxSk9xaFBYWUl0enJIS2VxSm5lT1V4cVg3cmFUZllrUk5jRXZl?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wiQjUluffpL0ozJfzOf/FPWGuRdpJlw2/O+EH8DI9JyEjBjhIx3pNt7zPCqyQRoQ9Uoygd7l6jFy6A0hqdc01tGUOaW44lSiLCIogOvSuDtpTzFJtqEEsmP1piMJ4ck76lXFksJS2ZnSx7lCm4yKafHfX1BE6jXmCCngZfy3GvoPBVGpE1P5jVf8FI9vx0PpeffHT9iE0eyxhFbIAQrCIHvHfyiJAQnINlm/iEjz8ohi4tD7F7+yo7JT8j2nq3biJh8QkT26fAlo/3ZjpvBJQhDs1Y57uzZXaHBc6zyRsMAytivTRQuXN/Dyxfr3k4YIRMEKs6hhIlWYBV6lfF5DvyN6CBYAt0r/tFI/cxI1DECNGMG7lB4p5odbnKvfK7l3VXCZCaU3zIDRTTLgI8fiVY57hyfF6gjywJubPsMTxztPhtQ44HGK8iwE2ASe922N6etZz4QxoEGpSDdEeceG2wVS3qhcq8XQhVBxRioDztN493b35N2uAvVcrtHK4UKvQTTIPyr+VwOymNt2HWcz3V5aSHhzTD4N3G9tkWoiXegtoZVJp6FUfDqf6irCiQP8RoHjRak/CD/AutEa7AtRdubKYbSrPFRKXi2Itr+YFR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f52623-fd39-4ac9-e0c6-08dc2be0940f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:37:53.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdm08lo/qs9DvM0S6MGNg59T5Sp/nqBtNuTxqyimaC3XhQ9pkEQS29AACIztFunwVLC+qXQGl9zvUZDDLT1/Zmbi78F6RoUhCH7LVWoYkI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=869
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120118
X-Proofpoint-GUID: sjn6kyNTKQtMcXFHRh0IVoPRjqhCy6dy
X-Proofpoint-ORIG-GUID: sjn6kyNTKQtMcXFHRh0IVoPRjqhCy6dy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/12/2024 4:24 AM, David Hildenbrand wrote:
> On 08.02.24 19:54, Steve Sistare wrote:
>> Check the status returned by migration notifiers and report errors.
>> If notifiers fail, call the notifiers again so they can clean up.
> 
> IIUC, if any of the notifiers will actually start to fail, say, during MIG_EVENT_PRECOPY_SETUP, you will call MIG_EVENT_PRECOPY_FAILED on all notifiers.
> 
> That will include notifiers that have never seen a MIG_EVENT_PRECOPY_SETUP call.

Correct.

> Is that what we expect notifiers to be able to deal with? Can we document that?

The notifiers have always needed to handle failure without knowing the previous migration
states, and are robust about unwinding their own internal state.  I will document it.

Thanks for all the RBs.

- Steve

