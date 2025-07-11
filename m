Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D74C83F20
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFab-0004Ov-J6; Fri, 11 Jul 2025 11:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFaI-00049C-EG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:22:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFaF-0004qb-Gc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:22:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEmW1n022019;
 Fri, 11 Jul 2025 15:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=TfEiEiaAB4XWZ8eeQ21XxlMKpdE64rUa48Zso3BY7xE=; b=
 lK7+DK/ctoCrbx3rTTvvcZ2ZVrQanVQSLEitZIKGr05pECZQePmzW1ABN0bvWKP/
 wm5uN1xH9pohzgDvgEn1USy1k7zPpnuIhHkCEN9SOriwE4PgYTw8L7+mqeB8XKe2
 /5QoAHjH4ttd5AfUW+8KKSZS1Bso2u0jKxI6s4SRslFeKJ1uavtd/4NJ6ieVR9Wv
 D9CtMpafT+jiVIWnIOR69XMwmwUKwRSqUUBLDAv5GpBTg3CfHgtzACDhnmqkX026
 Ez8K5OCME3yWaUzReaaPhsaJhHAKwfoZnJWFzNWRuRrFfKBxvjLGLiF31IjvPd6F
 +g0DiZe6EoP1fjDFo59+EQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u4nyr2mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:22:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BEAg5N027220; Fri, 11 Jul 2025 15:22:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdpjq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ1SanNWTZj5rtKL7bHP/8TEeG8jSEhrQ4hdd9m9qZJPXlBcc9P2y0e5jOb4ruHuxQeSiQ39WbfYHjp3nxs+90c1jZyoYs3KMj7l3UvmUJgl248R1p4AmhTTX2PNQcjtnY/i6m3NJgzDPawNXd7IuVvBQKplZME+pJrP0VxO5AINDGDe+VAfv/JqrWXciPkSbW3GpkOpnKimr9dovp6mgVMzRQ4oZFDMMjlrW8R4Fn5ue+/g+ILTVA4kcPMjVhLTjsZVwAfEgAXLP9zgFlAdiF670EpZ2IEuRYDHiw+LLvg16jGH5kzKjA8b9P+ixPgGsgk5Kebv8WjEaJpZngvHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfEiEiaAB4XWZ8eeQ21XxlMKpdE64rUa48Zso3BY7xE=;
 b=Yr+/qfKcOA5aieX/ByTUhfz+jDzBoI541WnxeYp/qAqAfseFhlUOrAt+8gspVWV194LR4wN7s3tJsRqlfXBmqhyBhOLgU01PaLYmW+LSnkM5GejtxVKGfw6ddoDQ3jevLA5UJE08kpeebPMc2ngJp6HUal/To5Mm5RpuUoa72up1vRl0F3aA0y9O0eB7XVmlXQcvXUINoU/L94TZFpxoRfyQurYM90r2IP6azl9RpPSyOXNprEGRF/g+k+FD86UUhED73nEB2meMRt2vfkkmmesXXCTSCqfwh+SEiT0KC2chhP+1TicP/X7z+CfIXu5SvZMa/8xYiZFqD2mMEToY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfEiEiaAB4XWZ8eeQ21XxlMKpdE64rUa48Zso3BY7xE=;
 b=cPJFj1p2uK24wIEI04YNiXz6uJRtGnnFEkpOZUfcMYOx/Ld0Rv09bRkhSvTrt+W6IH6DHhbRXgH3UlOsyu6JjVcIP+7bZNJT64Lwswp89dINbTvWNXojbP8xB0yJXDIgufKakUF1rkJaDEdIyIqDk24qFNuvp+UYIw4Su+ENmfM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 15:22:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 15:22:36 +0000
Message-ID: <c40b9887-4e57-4129-bae9-cdbcaedcc3e2@oracle.com>
Date: Fri, 11 Jul 2025 11:22:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] qom: qom-list-get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-2-git-send-email-steven.sistare@oracle.com>
 <87bjpqx0b5.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87bjpqx0b5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH3PEPF000040A9.namprd05.prod.outlook.com
 (2603:10b6:518:1::4b) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e59c840-3cd1-4541-d9b3-08ddc08ec3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0dDbFViTGVRZ21qUktEdXNhaVVld1JoRGYzcDlHdTM4R2hhUWJaQUxRRWZP?=
 =?utf-8?B?Rlp1ZldoMlcxaFkwc0cwWUhXSTBnNTdOaGJMS0luQ3k1OVZsZHRaWkwybHlM?=
 =?utf-8?B?VXdPNFdHR3ZpTlpxcnRkL2NTbG5TNC9URk9kdHJQRStIYWlwa0lIeHVHdTJH?=
 =?utf-8?B?M0lyckc1K1RQVCt5R3B0VVl5dnQzTXJCTitnRXpxUHpXWG1GV2FOekVzbHpI?=
 =?utf-8?B?b1lEbWczVEVNSm0rb3VXOUcvUXhLQ1I3am9EamIyY2ZOMUJMbnRvb2ZqVUlX?=
 =?utf-8?B?NWxGRzQ2RzlRSHcwa3dHRStJbGIydkU0Nno4S2ZiSTFOWDVpcVYyQityRCtE?=
 =?utf-8?B?dHFjc2dyQ1hjQ0NZRmVZM1JjVnIvWVFYbmFBemthK0RsRGxFNEMzQU95YlVo?=
 =?utf-8?B?NzM1MUlqQlhZQkhRMFBGOXJUekVHRXZMMFhia2kxYVRWK1FkNTlnMWtUbHJQ?=
 =?utf-8?B?aERmeXFBR2pXb0ZqbnB6SDVsSHRTNmUyd2JwY1Y5KzB0aWhGMDZTSzFwbGw4?=
 =?utf-8?B?Q1dPdXdPUmp3eWtteXc1bkxUNUtNMjN4ZExoSk9mYU9yRXJVTm14K3VndFcr?=
 =?utf-8?B?VVhYeVRVdnhXYkJpckNkeGZwVzBPQmdxSzIyZ0N3bytXc3lMVWdnZ0ZUbVZL?=
 =?utf-8?B?ZE5icTlzR2J1a3JGNytla0RoRCtRNTUwZlpYa0g4RGRQMW8wTGphS0NlSmZS?=
 =?utf-8?B?a3BQQzRuRmRsY1JWUFgyOGlTSk9FQThlZ1B3aVBlTEtyWFRxdU4vaWhEY25U?=
 =?utf-8?B?WjJrWHo4SWtUSXliSFBSZDhtc2oxQW5Hak1OaEpBK3ZiQ3ljUDhsRGpNQTJs?=
 =?utf-8?B?blo0eDBuQmVjb1plT1pUUiszU3dKSUZUL2c2NFl3RTYwWFhxcFg5NHNNbnIr?=
 =?utf-8?B?MDREZUZva2tmQkNrWVBTbjJjYUVLazFQYnhISXhJNWlTbmY0cmtBclRtd1B4?=
 =?utf-8?B?NHY1cTlXeFM5RHpKcVRZZUlDZjVIQkpjMXJ3SWdmRXZKZUVrY0ZDbG9SOW5L?=
 =?utf-8?B?R0Vpa2JxUDVPSFVBQkRYM2RiVzZ2UU5UOHZIVzJML28weWk4VER5aGxPSVQ5?=
 =?utf-8?B?djlubktPNDhWZnlJK3UwZXhQUGtISDdHdi9WYlNkWW5paElkUy9sMWVPdG5D?=
 =?utf-8?B?L3FONXhEaGpOclo3RnZ1R1dseEN4b0JzUjIwT2IyU3dvZTd6bE5Gaysxck93?=
 =?utf-8?B?Si9DRWM2RUVRV1NYYjVnNEx0UUpUN2ZjRHl6b0dRQkJCeU5RenNPQXVFVHB4?=
 =?utf-8?B?VjNuK3drRXdYQnd2V1dINU9uVVpFSGlsZllWSHU1ODRqVGhCSHNKKzhUL0tF?=
 =?utf-8?B?a2VtMTdWY1R5MXd2NlJocWUrZHVUeHNEZ1FjQlBGZEYxek93d3dZUEk2bnB2?=
 =?utf-8?B?NndzYWl3SG5heXh2SUYzTGcyQ0FLTWc2MFdpUmhlbEpWMStkQzdFQ1BIaW5R?=
 =?utf-8?B?dndHSWdaWk81OVRNUDZGYUdGVVJYWjJkMXBuNEhaQzRici9MWW5sbFVJVnFk?=
 =?utf-8?B?Vmdpb0RtQTVld204VU9TOHBFeCtPMnJWNnoxOUltUjdWSnhBWlJLWXN1TjZW?=
 =?utf-8?B?WnFIdHJ6YjcvZjlQNVV6dlBHSjhScnlxaVhRWWNzSTR6ZXRPa1hsRmFWN28x?=
 =?utf-8?B?YmJ3SjRDSDNlZUpCK0x2TUZFQjVNZlJnaXhhL0MxajFyU2lwTVlTTy95dUZw?=
 =?utf-8?B?UWNqaGQ2Z1VOSk5xeGhrd3FuREJqK0wyMmpvUmlKeXhsREtKd2tSNzBRU0tD?=
 =?utf-8?B?bml5c0pjWGtFS1d3TEgvWENwTFl6S3JtOFNtNlBoWVJEOUkwRGFHZGI5WVpt?=
 =?utf-8?B?OFJoZ3VIbm5XcThXOXQ3b1dWWG9MWThlTXZSTE5ZQXVFNDdvRFpzUjlsQXlS?=
 =?utf-8?B?Z3k2Nm92WlFXdE9WL0YxcTRPcGtKa0JKMTg2cDlSSGFldGs1dmlrenllUStC?=
 =?utf-8?Q?mMwsIxMJpJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdMMytqNDNMSVBpV3p1YnBKclZpeUp4b3hrYnhiYUtBMEsza0NuSklJa2xn?=
 =?utf-8?B?eFFNUEJyN1JpNmpCZW5VU08yVUxuQlNWTU1FeUxzUWtHeUhUaW0wWGx0Tzda?=
 =?utf-8?B?N2NJUDl2QVpOUTVud2Fsa1BtVG1hNTdHZnRMMElNL2x3VXRzckZrNkdYN3Fo?=
 =?utf-8?B?RUtXaVRGL0UzVVRlTUs2RGdZT29lRmZBMFRXZW8ydjBYTi9sckt2N1BXT0Ry?=
 =?utf-8?B?OVp4YVliVWhzOWpBUTFRTW5jeXNYTzRtRDB5eTVSWlo2aytKK1EvV0F5YnRQ?=
 =?utf-8?B?S1VjQnJ5NVA2TEtPRndPY1crNFRkRDNxcVZNaXdOVDN1WE1LQk1zSVMvYXdX?=
 =?utf-8?B?d2RRMjdJZ2srMFAzczZQUDBmY25mdkV4RUJWWHpYSXdGdFVhUkloMWV0ZWQ0?=
 =?utf-8?B?NlNqYmpkOFc4TTlSREtKd1NBMjdobUNyRDZyT29uaE1UeVVRNEV4TlpidFV5?=
 =?utf-8?B?U1UrQ0hDM3lKckhaVThQT0YvL0pEV2UzOXFLeC9maXY1K0pQRElvRDNYYVFR?=
 =?utf-8?B?blVKaXdHREVuR0Nobi9BYXBIOXV3NjlKOStQUEU5SEpOTlM2QkQ5VGlaZSsz?=
 =?utf-8?B?U2QzbW44a3V6ckgvaXRhU0N2dFNnb1dYaE9Id2d0WTl4bDRFVVZXV0I3VXVN?=
 =?utf-8?B?WU8zekErNUpLQzlaNHdKSnFoS043RjJyQ1ZtQWNJdmc5ZUNhRXBxdzR5U2Qw?=
 =?utf-8?B?WGZocnIraTRFVEpqZ2ZTdUs3cS9oaE9RUE1Rb1dicVhycCtZa0lrRnJhcWh5?=
 =?utf-8?B?THNqMmRnZzlXYXBuQSs5RXRFMGZURHdLVVBNNG5wSlBvUGdHQmVOWGRvSGNS?=
 =?utf-8?B?c3RZbW9KNVk1QzZZYmd3QkxFZGlVbzVySVpjb2luNGczN3JEYjFOWVdDNlpX?=
 =?utf-8?B?QUdqeCtPK3BkUEhhZ0NTaENpS0IvdUZIQWUrRHdMKzM1MWFTaWRvUXd5czd6?=
 =?utf-8?B?Y2N6ZWdFU0JjbjRqUWU4cHJlZWFWa3ZscGZ1Y1U0cHVkOERncFhidEtFemJQ?=
 =?utf-8?B?Wk1aclZkTU5EZlhvT0F2K2pHY2QyTElOVXlPY3JycFMvdjc5M2grc1N5SjhM?=
 =?utf-8?B?djB5VXI0Y0xGR0MvT1VBa0Z6RUtmaitnSHFrbWZpTk85VkMzOWZVZjFNWnFH?=
 =?utf-8?B?N2ZPRytYcjkzS3RMU3RwOGVPNTYrdWVMeFljVUxsT09FcUs5THNYUGxqb3N5?=
 =?utf-8?B?SlVvWVJOOTZMNTZ6TjJzUmxVRGpGMjJMaFp0OGMyMmF3KzljdWZNY21xZ1NL?=
 =?utf-8?B?TTBKcXJScDNRM2lOM1FPeVVVeE5uNk1MTXZYeno2RXNtZHFPaDdUQjJVNXZh?=
 =?utf-8?B?MmNXbWYxbDViRFYvQzRrOStzbUpHRWxrMjJSaWkxb2JoRFlHbE1wVldrWlFk?=
 =?utf-8?B?ZHRCL2pyVTRTckdlZUVYZ2J2K0VsUDZBWHhvY3FMMGFvK3JmRVo1RkRaQzI0?=
 =?utf-8?B?Q1NIMVBWcGloS0dObFBjdXFiWi9WTitDRkpaRmwwanVQZG05Y254MWZ4TmpU?=
 =?utf-8?B?UHVjNitDS1F1SkIyNUkwUUpBc21CNERNUE1ZSUV5S2RkUzgxbWpiV1IwKzJL?=
 =?utf-8?B?MVkzR0JJR05GQUxsOHZIdWlmeTd6dE9VRjVpbUFNRWo2ci9oamk1UVVvS1Az?=
 =?utf-8?B?bXNnU25ZT0ZnQnorM2NSc1d2dkRuQWJLNkQyd1NMdHJzcVFpTkF1eVZRTTlE?=
 =?utf-8?B?SlZwR0M3amZGS2JrSmJ5YzVxZ0dCNUQveVB6VFkxRC9CT2pLYklWZzd6ZWNm?=
 =?utf-8?B?dVo0cUdWRWdNcm0xa0Jsb2xjKytvSlkrbWxmNmp6OE1UMU1Ga2laZjdiL0xI?=
 =?utf-8?B?eExTbm4zTVduOU9DT3VReW5ORUFRUFN0eDd2dkZGMllUMnA4dC9WY3hHNzNT?=
 =?utf-8?B?bjZLU1lGdGxYMnRtWWlyb0R0UjlQY2RMamZaYnRuUVB3NnBGTWtCNjRBLzVP?=
 =?utf-8?B?SU5lUmJXV0VaZFVVa0YvcGhJaEVGeXFwWkxVT3Z0WEdxMFR5MUxJalg3SG10?=
 =?utf-8?B?OVdzT3pNQ0hzNU1CV2NZTXk1azNhMjdqd2J1dXh4U1pDWkFqTDRDd28wdHlP?=
 =?utf-8?B?UTNwQ2NPemZSZndGbFlabi84a21CRlh2YmxlWFhxcFBKeFJ0ZGxIKzlKb0sw?=
 =?utf-8?B?VzQrTWdiZm1VWlIvQmsvQWFNbEFZNjdqRjRuZHRoTU9DejF3V1BGcVp6Qmdm?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KUuf6HoQ0pIFd7njYr2T+lRrWUMY8Uv0rxeexOuIvhbRKsmQyqnLOc02b/+0wQCN7Z0js8O5iC0hLdi3xkJqvKsc1BohrHwRR9F6F3igIRsq7UUXpvOi/RkfeW/GM4jIhPmeDR9VcsYVLboXsQ+1B4vqLSS/tq5eqHj92WHh85i2BR3QT6v8Xs3WunARDDYOfx1CDeCLPjBMbNdnOJHwvugiQ78c/zFgXhPexaQsiCeonxZf3uVxt4pUQlrGhFOMwauOXoFRfTRYBmRAYFhRquSe0uN/U9KPQwlfQfO+J2SHNAeR1f+onEj7YoY2qstDIqoEOTQ7OprjatOMcVPcGt2JDS4KMoRjTw7DrWBKQiCPojw7XvGlKuA9d3giOw2gp/S4lbNI1viQoEt5reKgjHrOmOFvV/3TX3EDhP8rDb+gVLc64oJC7mnpmJetjVcnyR+LYL9aaJ9Ffr1ORPoKxkTMaIGVLb+gpMcvublkDWOi4THj+Vm2rsDiQXGy+KrTQzehhsxdOQAU7S4qz00j3xX8odjyWV1idoQxoiP5uTH++hD6t2AYXsYW4TqGNDI0TETUQpaRkpyLHqdu8/wYsJZMX3Qz/988wzUWFaGQokE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e59c840-3cd1-4541-d9b3-08ddc08ec3f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:22:36.4212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T09SQTz3ETnwHzasVoF0kCLo+i5SvOITFw4guuqttc45gUJEVKOe0z1DCwa40geHcv1NyAa1G7g7mDJuqmDIPmCzniB6i3Z6dU1+eeDnnKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMCBTYWx0ZWRfX80kSZ7n6skfp
 qZTLD7neZrlv5lx7NWt+iAbenMJE9JqqcbA1NMC3o0xORDavyFbfqG+T5iLKmM0g7YHDdD8+GC3
 YqB6pYbraMOH9UbEBUU+o/mqpmuNSlOCrRqAWs75DGtYPn3/S95Z/NG7oFPbWhi0zM5xHmibog+
 XZAyuakeMNXi4FIaWifgDIAgCYkqZVja1tJKjFbHmEZ5UmWzc7wX3MckP41wi9fWCss8cnsHhro
 WVnC0+0ErbxVXoXGGGS6nZhb8b/4INUcc+vhO3xBAItDTAdHvY4vnRC0LAvF4LQnCU+3tXtvj4s
 ARpvBPc9TG6pmHXiTPvGAA/9duOscyleXyeuVfZ915RiOtcW5fHwUSjEJkbsXG9XQu56JhyXy7M
 ZF5nprGKpKVYzV+lPRdlgKbD3te4nMJxKHWhLz0V83kWMN60I8KlImbfDuQKWnLozH7xM6/4
X-Authority-Analysis: v=2.4 cv=PJYP+eqC c=1 sm=1 tr=0 ts=68712c40 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=0nv_B0XlBo6S4oSGUc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: 6QWItyE5eS_rebPG1PeRmVwl0KSXc-fg
X-Proofpoint-ORIG-GUID: 6QWItyE5eS_rebPG1PeRmVwl0KSXc-fg
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

On 7/11/2025 10:35 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the qom-list-get command, which fetches all the properties and
>> values for a list of paths.  This is faster than qom-list plus qom-get,
>> especially when fetching a large subset of the QOM tree.  Some managers
>> do so when starting a new VM, and this cost can be a substantial fraction
>> of start-up time.
> 
> You give such nice rationale in your cover letter...  What about this:
> 
>    Using qom-list and qom-get to get all the nodes and property values in
>    a QOM tree can take multiple seconds because it requires 1000's of
>    individual QOM requests.  Some managers fetch the entire tree or a
>    large subset of it when starting a new VM, and this cost is a
>    substantial fraction of start up time.
> 
>    Define the qom-list-get command, which fetches all the properties and
>    values for a list of paths.  This can be much faster than qom-list
>    plus qom-get.  When getting an entire QOM tree, I measured a 10x
>    speedup in elapsed time.

Will do.  I'll send a V5 with the remaining tweaks and RBs.

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I think you missed
> 
>    Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Indeed, and I appreciate the testing effort. Will add it.

>> ---
>>   qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 103 insertions(+)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index b133b06..49214d2 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -46,6 +46,34 @@
>>               '*default-value': 'any' } }
>>   
>>   ##
>> +# @ObjectPropertyValue:
>> +#
>> +# @name: the name of the property.
>> +#
>> +# @type: the type of the property, as described in @ObjectPropertyInfo.
> 
> `ObjectPropertyInfo`
> 
> See John Snow's "[PATCH 00/18] QAPI: add cross-references to qapi docs"
> rewrites things so they become links in generated HTML.

Thanks, I missed this one.

>> +#
>> +# @value: the value of the property.  Absent when the property cannot
>> +#     be read.
>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertyValue',
>> +  'data': { 'name': 'str',
>> +            'type': 'str',
>> +            '*value': 'any' } }
>> +
>> +##
>> +# @ObjectPropertiesValues:
>> +#
>> +# @properties: a list of properties.
>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertiesValues',
>> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
>> +
>> +
>> +##
>>   # @qom-list:
>>   #
>>   # This command will list any properties of a object given a path in
>> @@ -126,6 +154,28 @@
>>     'allow-preconfig': true }
>>   
>>   ##
>> +# @qom-list-get:
>> +#
>> +# List properties and their values for each object path in the input
>> +# list.
>> +#
>> +# @paths: The absolute or partial path for each object, as described
>> +#     in `qom-get`.
>> +#
>> +# Errors:
>> +#     - If any path is not valid or is ambiguous
>> +#
>> +# Returns: A list where each element is the result for the
>> +#     corresponding element of @paths.
>> +#
>> +# Since 10.1
>> +##
>> +{ 'command': 'qom-list-get',
>> +  'data': { 'paths': [ 'str' ] },
>> +  'returns': [ 'ObjectPropertiesValues' ],
>> +  'allow-preconfig': true }
>> +
>> +##
>>   # @qom-set:
>>   #
>>   # This command will set a property from a object model path.
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
>> index 293755f..57f1898 100644
>> --- a/qom/qom-qmp-cmds.c
>> +++ b/qom/qom-qmp-cmds.c
>> @@ -69,6 +69,59 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
>>       return props;
>>   }
>>   
>> +static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
>> +                                        ObjectPropertyValueList **props)
>> +{
>> +    ObjectPropertyValue *item = g_new0(ObjectPropertyValue, 1);
>> +
>> +    QAPI_LIST_PREPEND(*props, item);
>> +
>> +    item->name = g_strdup(prop->name);
>> +    item->type = g_strdup(prop->type);
>> +    item->value = object_property_get_qobject(obj, prop->name, NULL);
>> +}
>> +
>> +static ObjectPropertyValueList *qom_get_property_value_list(const char *path,
>> +                                                            Error **errp)
>> +{
>> +    Object *obj;
>> +    ObjectProperty *prop;
>> +    ObjectPropertyIterator iter;
>> +    ObjectPropertyValueList *props = NULL;
>> +
>> +    obj = qom_resolve_path(path, errp);
>> +    if (obj == NULL) {
>> +        return NULL;
>> +    }
>> +
>> +    object_property_iter_init(&iter, obj);
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        qom_list_add_property_value(obj, prop, &props);
>> +    }
>> +
>> +    return props;
>> +}
>> +
>> +ObjectPropertiesValuesList *qmp_qom_list_get(strList *paths, Error **errp)
>> +{
>> +    ObjectPropertiesValuesList *head = NULL, **tail = &head;
>> +    strList *path;
>> +
>> +    for (path = paths; path; path = path->next) {
>> +        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
>> +
>> +        QAPI_LIST_APPEND(tail, item);
>> +
>> +        item->properties = qom_get_property_value_list(path->value, errp);
>> +        if (!item->properties) {
>> +            qapi_free_ObjectPropertiesValuesList(head);
>> +            return NULL;
>> +        }
>> +    }
>> +
>> +    return head;
>> +}
>> +
>>   void qmp_qom_set(const char *path, const char *property, QObject *value,
>>                    Error **errp)
>>   {
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Cool.  Thanks!

- Steve



