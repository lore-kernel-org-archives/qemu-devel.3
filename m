Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93ACD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 19:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZcg-0008Qd-Df; Tue, 03 Sep 2024 15:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slZcd-0008PO-Gi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:55:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1slZcW-0002mi-6g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:55:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JXTGd024441;
 Tue, 3 Sep 2024 19:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=corp-2023-11-20; bh=8SAjJIJepvkRL5e
 DDuV9MZItzMdfwiEFuaAlHOZ54mU=; b=BBpiVpzXfv7Dhk2tnfotlTWFTpI9fKM
 xHwpyIK6IDMKy+5EVxxTPS6qOPmZgZibP/w7feNcYk29XDH4G0Vw3c2bL0NRrLMi
 QXajQ7A9hP/7/sqAv0cICWPh2yP/5wL/II6dyM6zd9GEtFs3rmnoen5LfniitqLT
 m5PtoOrl2AyU1pnDIg5pQHlTpKfOEbU12rTSSww/lLnEfa8W9+4IbTdVyVCXBJXp
 JFHr18JCBhz3U/PJIRFZX5/lXL9RSjxNtOWFeu13VTNRfq+YyMqFwQYhdg5lvQc4
 2vjYDVyk0xt3KzUf7B27Yb0jjNW1MtgTbhIVCPBaaXY2R5INJpHxT4g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsa9u3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2024 19:55:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 483JSQnj023545; Tue, 3 Sep 2024 19:55:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41bsm8nrp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2024 19:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2oz36NHL0/kQyjxsGu1o6BH+ANQcEz13h5wUoMgiygieBpfWdi8z3u+8jLjSAS/ay1m2HN2S9Wtk1ZYe2EQVIkUdUOZu2sbT0pfEYIb6k7ap8cTTyzpUBFAHP49ewHP11ZDAhUJXk31+D2xgqmHOtkGBKrgVjutUf9P1QlmamP2MNYNWKweQ2Zcza7a8qnpj5lC3jSMLXH25J3lkNMdi1vX8RD9CRnczogK7SGQKmUI+srMQCng6C3NlmTqswpvztL1/+oVWnWM2fqACtWJUBxrBHpJWu+2Vu1lR99fIzd8O8owseM43gPVe5BJBI3CxS7U9sN43Pc1QSEJGkO5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAjJIJepvkRL5eDDuV9MZItzMdfwiEFuaAlHOZ54mU=;
 b=nP0DMk3ULc3H7L8fT7qMS8OilG4kzXq1k4YnFY/syKnFJwwVAQquvQZPV8fDkSV0BM+XfPJIW2K6pX2GdDyXDUBuLwIql1AvTbGvSwhvsGH029MD4Y3+CsbHmMWl/X6xyAsqgBxfIlzupTgAC/PBGDr6Q/Nq00hukxlspbx5Dl6i/fJ1rt/8plIzHJqLXHldprlvwWhuOx47STgr1WFD5F5nm4fs2xAhB0TNcGcHslMwv9xQ47p7HLSsJsXg0qPq9znGFYNRsBKYmZAYoDzRNeS2OgoDPMnXxdUvHUhhMvFQG9wafNotMt1c7uOrrNPJZV2KUx6LX5fp2a477b6VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAjJIJepvkRL5eDDuV9MZItzMdfwiEFuaAlHOZ54mU=;
 b=TLN9q436VTy7y/HkwQE5paDJnP5rCHJx4fxsXIHvpTlBSsxYSRFKgN3Vb+I4QVDR2GZbxRL33QMOm1mqVkWQsjqXB+TTwBu9T27Pt+AwdJY7dlntgu5lJsG3yQY9b6Mf7o2dkulWfPzYq+0v774Fe5fxYAz9Tn7rhGGpHAxMUbY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB7543.namprd10.prod.outlook.com (2603:10b6:208:473::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 19:55:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7939.010; Tue, 3 Sep 2024
 19:55:11 +0000
Content-Type: multipart/mixed; boundary="------------1XrvXeKVO4iA48O36CYtTfHG"
Message-ID: <fa95c40d-b5e5-41eb-bba7-7842bca2f73e@oracle.com>
Date: Tue, 3 Sep 2024 15:55:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/6] Revert "vhost-backend: remove
 vhost_kernel_reset_device()"
To: Euan Turner <euan.turner@nutanix.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
 <1725018997-363706-2-git-send-email-steven.sistare@oracle.com>
 <c7eaca75-1824-4f46-af97-9905c2a214ba@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c7eaca75-1824-4f46-af97-9905c2a214ba@nutanix.com>
X-ClientProxiedBy: LO4P123CA0602.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: a181e021-dde9-4419-b16c-08dccc5251f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjJ2N04yclZNRzJQRFRqQlIxbndCSG1SNUxjazl2V3QyZzIrRit5UDFZOC9H?=
 =?utf-8?B?TXpRMWZBZ3UzOEt3amoxM3IyUzJzL1praERxdmhNU1ZBVHJBWGxXcGNyaDhV?=
 =?utf-8?B?eDBueU5tZjA3a3BkVXM4UUYzUVNHa3Eva3duSExIK1FuV0h5eUp2bWl0L25L?=
 =?utf-8?B?azZaZHlOTkEydzRkL2ZMYWZ0R2FKQzJhZkl3Y1l4OVlvbGtqTmErWVVFaWx6?=
 =?utf-8?B?djFlVms3SDFLVW5taitwNCtZdmpIN3dtM0tjVS9MVE1aeDdlOFgxRkUwUjNz?=
 =?utf-8?B?YUo1dEIybFJVOWdGVVgwaUxTVzVidVY4RWZRZzh1N1c5UXpPekxjOGFwSVJK?=
 =?utf-8?B?Zm9IcEY5aWVCeXJKMEdabHY3TWdaM2s4RGxGR2pxSkNpK3pIZEZEN0tZSjBF?=
 =?utf-8?B?aTlXeGRFRXUwUDdwQnpvR29ZbmgvRUxPYW5ES0Q4ZU1mSTRJQTN6NXF4Q3pL?=
 =?utf-8?B?cnRGMEtCSDhNQ2ttWHl2UmsxMUFLaHhFTGtGZXJGb0tiOGtTYURUNmVMNGhT?=
 =?utf-8?B?eU4vRTRZMUpla0VsUFNFUlJtM0JxY2xFdVdKSGk4YW1tU0RIaTduZG5sc0xX?=
 =?utf-8?B?SnVRbVhhMUZhbVpEb3dWTmV2WGNUV3c1L2RLWUxDdlk1cDlzckQ4L0dXcGtK?=
 =?utf-8?B?TFpNUThmMkd1YkpmQVBwN2NOYVE0dUE4SlFrS1ZWaEQ1T3ByejhDWXNmWnJ6?=
 =?utf-8?B?RjJ1ODlvNWdGMEg0VXY5TEtDalJoUlNuTXNjVnV2SjI0YVVMSWlMeThnWXJW?=
 =?utf-8?B?OUdjNzkxYy9mays5aGdXZXJUajFnVFI5U3lhOXFWRDNTSmVMeGhWTlAvUjlE?=
 =?utf-8?B?Rm9hemdHT1YwaFRONVd2TlZkT1hRUHYzSXdSRDJkd09sVkVGY3dvL2ZGck5i?=
 =?utf-8?B?blRnQmwwcGR3aWtVRkx4cmZHeG1FanBtV2RPNkR5VERUQ2VUWlhDNEN2c0lJ?=
 =?utf-8?B?Y1hPeGQxTGxXdjJxVFdCWUVESDgrbmZsN2htR05td1ZZeHdMamxyZ0JSR0pt?=
 =?utf-8?B?RGQ3bCtxUi9JUUVyamZFQ3BNK2lMZFNHb3hvdzNMVnFGcmhSQ0F2Q3dSZjlu?=
 =?utf-8?B?d29NK3FYbHl2Qk56c3VwTmEvZmpHSHc5SFpOcnVVeWU5ajRzQm8za0hUZmZJ?=
 =?utf-8?B?L05SS2dCUGFVM1NGR09pYXd4akNBR2pSRng3Z2RablhKZmMvOWF2ZS83WlQz?=
 =?utf-8?B?OG9NQXpvWEFPVjVlZGU1TEYrRTRvMGYycjBrWUw3RWF0bEF0YW5VcGpBMGdl?=
 =?utf-8?B?ZEJ4TXk2cWUralBxV05PQXZCd29pS0VUd0c2ajllNjBISXVqbW1jWjZBSWVv?=
 =?utf-8?B?dTgzN0c1dTI4OEZyTVZkRzZIN1lVSUV2a0lobFNCQjFCVmVSV1MyLzJHYlov?=
 =?utf-8?B?T2M1QURLWEFzMmJHTXFoTDFqMCtOK0RhQmlJb2JiZ1FsVE55czBsTG5lZkFl?=
 =?utf-8?B?eUl4bDFNZ0ZPNlc4ZXRZQ2lYMUFQS0VIOTNpaXBOYzNpMnpoZE05MVZYZi9X?=
 =?utf-8?B?WXZsTlpWdG53RWNxS3E5VmsrUXIwaXlUZ05YdGlMVzlkN0NSdHQ1aUJjN3Rr?=
 =?utf-8?B?QjJuMEc0c0VGQ3hPRWFCTCtqOGxGY0ZralphTFR1aFlYUHRPbXFKeHdLV3lW?=
 =?utf-8?B?WXhiSjNlbGVpMFdiZHpDNFhQREpuVTlua05zZnBhWHErMGRXTWM3bFJBcVJB?=
 =?utf-8?B?KytoMTVST21Ia2g3aStGblZmejZKQUg1d0UwQzhBRnRvVllweDNaKzRzbmIw?=
 =?utf-8?B?eEpsSmpiTUxWTHNWTnVueFIvMWI4WjFBZHNLV2R1VDU1UWI4Vkt0Q0JpcDE0?=
 =?utf-8?B?L1RkeDNORDNEeHRQQzM1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJzUmhrdHlpK2hycXRBeHh4WTdqQ05GeVZkTkxtRGFnUEpKUVg5VzFoVlJV?=
 =?utf-8?B?Y0dFVVVudXNpVmFmMHNKWERLdGgvWTFwSEtHR0RGT3FQcDJXTE5FYXVBU3ho?=
 =?utf-8?B?b0pOWHJjK3dncDRpamxIUFlUaW5od3ZWK3NGTEtnbUdDeUNZMHpvVWdMclVF?=
 =?utf-8?B?MXF0VHNlR3UzMlpBdVpyRllDU3lSanVBNlNuYmdyRHYzNDBJTllWeXllZVFK?=
 =?utf-8?B?QlJEUlpQcUtxMDlEeUYrQ0F1ZUNFYktCZ0dnK2JIRHR4ZVpXRlFsWWYzT1J4?=
 =?utf-8?B?Z2c2QXBXWWxsRjFJbWh4ZFVFalM4dUxsUStXR3g4bzU3bXZTRWR6MFhNWkVi?=
 =?utf-8?B?VlVENzVyLzRhbUFZbW0wVUg2TUxmSm5FczBsTnhFSWdYeVV0WVgrQnc5RnFw?=
 =?utf-8?B?dXczd0Y0T3oxV1FQcXBxS3Q2ZUs3NkMweERRa1JtNzh1SGhNQjlITTVQVXRo?=
 =?utf-8?B?ZDNYOGtvQk5IZ201OVRrSTZOb0RqSTVYQ0hsUi9nQ3p6V3NvN01QM1NpdGRy?=
 =?utf-8?B?NDQ0cm1ucVJWT3BLNG9lTnhSd0ZKanQ5ZUljcmFnOUdkVnFrcVVRN281MG40?=
 =?utf-8?B?T1d1N040R0JSNExKTlBYMEdYaGVNdWhMaXFtbFVuenZmUU9RaVNCa2JuSVQw?=
 =?utf-8?B?OVV1bkVtYXY0UWZ4a3JUYWlvMGh1eTZGQjBodFlCcGRUTG9DbFhvejFoTnpj?=
 =?utf-8?B?bjdBT2J4bFJLZHBjbjI1Y1pFWnVDMFNQdDFsSkVhWWkvTTJYdTBHV2E1T0tL?=
 =?utf-8?B?ZHA0MG9pMVArQmlnK0ZpLzBVRkNKK3gyWlhnL1ZnT05wTC9DK3RScXJBa2FL?=
 =?utf-8?B?bHJ1amdIZ1BRTkorYnQ2akUwRmVoSXZxMTJUM1cyMWhtVnFlelVsL29QM1U2?=
 =?utf-8?B?ejlNUmFnbkt3Z3JKdTRONFNrUHRnZC8zV3dSaDVJNEkybEY0ci9xaDEvcUN4?=
 =?utf-8?B?K01zWm80Wno2RVZTeWllZ2Y0T3IwSmhEUHJ4bjNBaUd2NnBRaDJNTGJaZ2E0?=
 =?utf-8?B?MXNqY2tpdTFoZk0wUkFLdjhjQkpjamRQck45Tjg5RkZyLzE3UlVSVjZpOVpq?=
 =?utf-8?B?by9IYmdzWld1NmVXM3M5SlFmcHlxN2wzSXU1b3pqZkdDRVYrRCtiQTB3WkpN?=
 =?utf-8?B?bTVodHFmcE95OXhoNE0zQXdSZ1RyWjdGRGlxQUE1dXVmQUFmK0pQTG5RRS9u?=
 =?utf-8?B?MkQyWmpwNCswcHpqOVV6SVdKSmxYVGZOMGY4blhmSmVpMCtvTTlublFJU2pv?=
 =?utf-8?B?c1Q0RFlLVG9nSnNmd1c3WlN5Z1lRZjVmVVFNNnlCcS8yNWJRNExRUVVibHJh?=
 =?utf-8?B?QkxwOHZMTjI4RmtYdEMxNktxMUQ3VCtzUjZlbHR4ZlNKWDRud1dCbFhoSmtJ?=
 =?utf-8?B?RjQyeWF1STR5UFUxYVJxa0hkOFovTjR5RE5lSW1HVUprTlQ1bnRld0dRajFM?=
 =?utf-8?B?N2lLVU1zZTREeWYwS2xDUlBoNHFMWlRvL3kzZFJxd1JOTzN5WmJsSDJkY3lD?=
 =?utf-8?B?ZlRqR3FmNDZNUHUrN3NNVS9DMHZzM3l2aWE2OU9iMGY1SHVIN1JtWVVxRm1W?=
 =?utf-8?B?QTRRbU83Mmp3ZGd3THFWNEg4WEM1RFdGcVllSXhxZHJYM0VGUHhTZkU3cm0w?=
 =?utf-8?B?YndZTit2a1FIZ1BORjZDamNRYnBhUUhxaVB5TzhhRU9Qem9LS1pCUjlVaFg3?=
 =?utf-8?B?dnFkeWJ4YjNLejJ2aStoajVPc0FHVWlXa29iL0ZJZE9pOTJibktlK0ZjOE1R?=
 =?utf-8?B?bnhpZnowTDR3Z3A2VTVpYzZ0NHFqOWFEaXV6WEhGR0oxNHZZR1ArZERFNFpV?=
 =?utf-8?B?Y05Pb2NmYkVyZ0Z0dlhuZTd2YU9jUXdMTnhNZ2Q0bWYzR2MwaHZrdFM1d2dB?=
 =?utf-8?B?YVh2ZFhvM1ZwYUJuKzUzTTlIdGxhcEMzTjRUMVpra3Q3T3pZMkgxdVhrbXdV?=
 =?utf-8?B?cEw2OFZJQW00SlljUzJTVStjOGdhcTRwQUFNUTMyUkc2cmV2ZUo4eUE3bkpr?=
 =?utf-8?B?OGlFZEcvdWZCL0tWTGNWemUwekNCSmNPRXVaNm5acXZVUFRJeXhwb292bFRs?=
 =?utf-8?B?UDZOYXN2cG1SbFlSSUVSZ2VlQUxqbzlHUzZ3UDBwaFRQMkp6RnJwMEZlc3g0?=
 =?utf-8?B?MzZ5WEJ1LzQzZXgzSXd4dlJHczVRZGZKemZQWjIzSWljOUlhTzRGMEhaRDVC?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lWr35WMIwQsjWoNLfX78WZHrr4aN5aAEG1+S/e7girzKO8ifeoKOJorCNInFqC+DTwf1xCeKwyBjr35vahG4G+evxg3JWRIqyXOldNWsq+14bbjLvFlOOfaFLRdenvGnZJFvPD2Yq5s5qVo32Vxiwh/OeWnxJ+UxuIfQWSUMgOXs0Ar9CKhrESND+DP3BQeER99T5TKtaoTCQA4PGWdXDNuTuYUqmAAoU3Ouz7jYiV1G1utspg1VyINa3YCA13K9zhllI9Qbs6OpxJiObqvCj4UQ4oOL1nXZPLIWYtlutiQm9tiEzADqGOwW5SiVGwHP8lnd8Q/mgnoGgCyBDadYkEC48s29Q1dgq4FqGvzUMAud7LVn+9xt1YHFDvUrnvkSgqZlkOXBCZ+J7g1QZjNFWvyfQWivQ4cxM8wr682sErcZ+AHc0sdX68sMeD8xENU32+yepZEWORDBiVeEDOszKIzjslm5PV6v6/lsq99w/EDaUnOnPBwx9bLXuK06wZyfnE7kUBgImwjolLUXD2hYUsgHlmSIvLbJf2LiixyqFzawNXVtvl4PG2qY1fI1MrECe1MuvKtopLge3DKCwuliXGZtYVPsdmsu2kiYSKZkOb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a181e021-dde9-4419-b16c-08dccc5251f8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 19:55:11.6599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZejTpgT7WTIFA2xI67fQ8aLI8eF9586dhTNCqV82/hYG7hif+/EfW3FEEfdiSOux2TlPjJtBGB3mnrdYaNh7G7DIsqYqr2BnmXErpe8oBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_07,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030160
X-Proofpoint-ORIG-GUID: W7x-JHVZTTI7z3Mu7XQxscBN4o3DAGtY
X-Proofpoint-GUID: W7x-JHVZTTI7z3Mu7XQxscBN4o3DAGtY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--------------1XrvXeKVO4iA48O36CYtTfHG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/2024 6:44 AM, Euan Turner wrote:
> Hi Steve,
> 
> On 30/08/2024 12:56, Steve Sistare wrote:
>> This reverts commit e6383293eb01928692047e617665a742cca87e23.
>> The reset function is needed for CPR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/virtio/vhost-backend.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
>> index 833804d..9b75141 100644
>> --- a/hw/virtio/vhost-backend.c
>> +++ b/hw/virtio/vhost-backend.c
>> @@ -221,6 +221,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
>>       return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
>>   }
>> +static int vhost_kernel_reset_device(struct vhost_dev *dev)
>> +{
>> +    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
>> +}
>> +
> How does this series avoid falling foul of c0c4f147291f37765a5275aa24c3e1195468903b (which follows the commit reverted here)?
> 
> I've been playing around with this patch series a bit, in the context of cpr-transfer, and am seeing the issues highlighted in that c0c4... commit message:
> Since vhost-kernel now has a reset_device, this is called in virtio_reset as part of qemu_machine_creation_done. (I have the full backtrace if it's helpful). Subsequent ioctls then fail (with ownership errors) due to the RESET_OWNER:
> 
> 2024-09-02T15:40:56.860541Z qemu-kvm: vhost_set_vring_call failed 1
> 2024-09-02T15:40:56.860908Z qemu-kvm: vhost_set_vring_call failed 1
> 2024-09-02T15:40:56.861253Z qemu-kvm: vhost_set_mem_table failed: Operation not permitted (1)
> 2024-09-02T15:40:56.861586Z qemu-kvm: vhost_set_vring_call failed 1
> 2024-09-02T15:40:56.861831Z qemu-kvm: vhost_set_vring_call failed 1
> 2024-09-02T15:40:56.862199Z qemu-kvm: unable to start vhost net: 1: falling back on userspace virtio
> 
> For me the NIC then fails during the migration, although the migration as a whole appears to succeed. (At least, prior the the migration, I could ssh into the VM and ping out to 8.8.8.8, but then I lose the ssh connection during the migration, and cannot ssh back in again afterwards on the new QEMU).
> 
> Do you think this could be because of QEMU falling back from the vhost backend to use virtio?
> 
> It may be down to some misconfiguration on my part, here's the netdev command line I had for reference:
> On the source QEMU:
> 
> -netdev '{"type":"tap","fd":"39","vhost":true,"vhostfd":"40","id":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1"}' \
> -device '{"driver":"virtio-net-pci","rx_queue_size":256,"netdev":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","id":"ua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","mac":"50:6b:8d:0c:03:e0","bus":"pci.1","addr":"0x0"}' \
> 
> On the destination QEMU:
> -netdev '{"type":"tap","fd":"-1","vhostfd":"-1","id":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1"}' \
> -device '{"driver":"virtio-net-pci","rx_queue_size":256,"netdev":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","id":"ua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","mac":"50:6b:8d:0c:03:e0","bus":"pci.1","addr":"0x0"}' \
> 
>>   static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
>>   {
>>       assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
>> @@ -345,6 +350,7 @@ const VhostOps kernel_ops = {
>>           .vhost_get_features = vhost_kernel_get_features,
>>           .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>>           .vhost_set_owner = vhost_kernel_set_owner,
>> +        .vhost_reset_device = vhost_kernel_reset_device,
>>           .vhost_get_vq_index = vhost_kernel_get_vq_index,
>>           .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
>>           .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
> 

The 6 patches in this series are only sufficient for cpr-exec mode, but I have
attached the 2 additional patches you need for cpr-transfer mode.  That mode
works fine for me with those patches. When I run a similar test, vhost_reset_device
is not called on target QEMU because vhost_started is false:

   qemu_machine_creation_done()
     virtio_reset()
       if (vdev->vhost_started && k->get_vhost)
         vhost_reset_device(k->get_vhost(vdev));

I don't know why you are seeing the vhost_set_vring_call failures.  I don't see those,
with or without the 2 additional patches.

- Steve
--------------1XrvXeKVO4iA48O36CYtTfHG
Content-Type: text/plain; charset=UTF-8;
 name="0001-migration-cpr-setup-notifier.patch"
Content-Disposition: attachment;
 filename="0001-migration-cpr-setup-notifier.patch"
Content-Transfer-Encoding: base64

RnJvbSA0ZjcxOTE3OTU0NmU5MzI3Y2JhM2I3NGU4NmQyYTQwM2UzNmM1ZDcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDIwIEF1ZyAyMDI0IDA1OjM2OjE1IC0wNzAwClN1YmplY3Q6IFtQQVRD
SCAxLzJdIG1pZ3JhdGlvbjogY3ByIHNldHVwIG5vdGlmaWVyCgpBZGQgYSBjcHItc2V0dXAgbm90
aWZpY2F0aW9uIHBvaW50IHdoaWNoIGlzIGNhbGxlZCBiZWZvcmUgZ2VuZXJhbCBzZXR1cC4KSXQg
aXMgbmVlZGVkIGZvciByZXNldHRpbmcgdmhvc3QgZGV2aWNlcywgYXMgZXhwbGFpbmVkIGluIHRo
ZSBuZXh0IHBhdGNoLgoKU2lnbmVkLW9mZi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3Rh
cmVAb3JhY2xlLmNvbT4KLS0tCiBpbmNsdWRlL21pZ3JhdGlvbi9taXNjLmggfCA3ICsrKystLS0K
IG1pZ3JhdGlvbi9taWdyYXRpb24uYyAgICB8IDUgKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWlncmF0
aW9uL21pc2MuaCBiL2luY2x1ZGUvbWlncmF0aW9uL21pc2MuaAppbmRleCBiY2I2ZjM1Li5iZDA1
ZmUyIDEwMDY0NAotLS0gYS9pbmNsdWRlL21pZ3JhdGlvbi9taXNjLmgKKysrIGIvaW5jbHVkZS9t
aWdyYXRpb24vbWlzYy5oCkBAIC02MCw2ICs2MCw3IEBAIGJvb2wgbWlncmF0aW9uX3RocmVhZF9p
c19zZWxmKHZvaWQpOwogYm9vbCBtaWdyYXRpb25faXNfc2V0dXBfb3JfYWN0aXZlKHZvaWQpOwog
CiB0eXBlZGVmIGVudW0gTWlncmF0aW9uRXZlbnRUeXBlIHsKKyAgICBNSUdfRVZFTlRfUFJFQ09Q
WV9DUFJfU0VUVVAsCiAgICAgTUlHX0VWRU5UX1BSRUNPUFlfU0VUVVAsCiAgICAgTUlHX0VWRU5U
X1BSRUNPUFlfRE9ORSwKICAgICBNSUdfRVZFTlRfUFJFQ09QWV9GQUlMRUQsCkBAIC03MSw5ICs3
Miw5IEBAIHR5cGVkZWYgc3RydWN0IE1pZ3JhdGlvbkV2ZW50IHsKIH0gTWlncmF0aW9uRXZlbnQ7
CiAKIC8qCi0gKiBBIE1pZ3JhdGlvbk5vdGlmeUZ1bmMgbWF5IHJldHVybiBhbiBlcnJvciBjb2Rl
IGFuZCBhbiBFcnJvciBvYmplY3QsCi0gKiBidXQgb25seSB3aGVuIEBlLT50eXBlIGlzIE1JR19F
VkVOVF9QUkVDT1BZX1NFVFVQLiAgVGhlIGNvZGUgaXMgYW4gaW50Ci0gKiB0byBhbGxvdyBmb3Ig
ZGlmZmVyZW50IGZhaWx1cmUgbW9kZXMgYW5kIHJlY292ZXJ5IGFjdGlvbnMuCisgKiBBIE1pZ3Jh
dGlvbk5vdGlmeUZ1bmMgbWF5IHJldHVybiBhbiBlcnJvciBjb2RlIGFuZCBhbiBFcnJvciBvYmpl
Y3QsIGJ1dAorICogb25seSB3aGVuIEBlLT50eXBlIGlzIE1JR19FVkVOVF9QUkVDT1BZX1NFVFVQ
IG9yIE1JR19FVkVOVF9QUkVDT1BZX0NQUl9TRVRVUC4KKyAqIFRoZSBjb2RlIGlzIGFuIGludCB0
byBhbGxvdyBmb3IgZGlmZmVyZW50IGZhaWx1cmUgbW9kZXMgYW5kIHJlY292ZXJ5IGFjdGlvbnMu
CiAgKi8KIHR5cGVkZWYgaW50ICgqTWlncmF0aW9uTm90aWZ5RnVuYykoTm90aWZpZXJXaXRoUmV0
dXJuICpub3RpZnksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1pZ3JhdGlv
bkV2ZW50ICplLCBFcnJvciAqKmVycnApOwpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21pZ3JhdGlv
bi5jIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jCmluZGV4IDE1YWM4ZjUuLjhiYzE5NzUgMTAwNjQ0
Ci0tLSBhL21pZ3JhdGlvbi9taWdyYXRpb24uYworKysgYi9taWdyYXRpb24vbWlncmF0aW9uLmMK
QEAgLTIyMDEsNyArMjIwMSwxMiBAQCB2b2lkIHFtcF9taWdyYXRlKGNvbnN0IGNoYXIgKnVyaSwg
Ym9vbCBoYXNfY2hhbm5lbHMsCiAgICAgICAgIHN0b3BwZWQgPSB0cnVlOwogICAgIH0KIAorICAg
IGlmIChtaWdyYXRpb25fY2FsbF9ub3RpZmllcnMocywgTUlHX0VWRU5UX1BSRUNPUFlfQ1BSX1NF
VFVQLCAmbG9jYWxfZXJyKSkgeworICAgICAgICBnb3RvIG91dDsKKyAgICB9CisKICAgICBpZiAo
Y3ByX3N0YXRlX3NhdmUoJmxvY2FsX2VycikpIHsKKyAgICAgICAgbWlncmF0aW9uX2NhbGxfbm90
aWZpZXJzKHMsIE1JR19FVkVOVF9QUkVDT1BZX0ZBSUxFRCwgTlVMTCk7CiAgICAgICAgIGdvdG8g
b3V0OwogICAgIH0KIAotLSAKMS44LjMuMQoK

--------------1XrvXeKVO4iA48O36CYtTfHG
Content-Type: text/plain; charset=UTF-8;
 name="0002-vhost-cpr-transfer-support.patch"
Content-Disposition: attachment;
 filename="0002-vhost-cpr-transfer-support.patch"
Content-Transfer-Encoding: base64

RnJvbSAwZjA5NzgxZGYyMTUwODZmMDk1ZTQwYjQyNjYyZGQyZjMzNzhjYTdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDIwIEF1ZyAyMDI0IDA1OjQ4OjA4IC0wNzAwClN1YmplY3Q6IFtQQVRD
SCAyLzJdIHZob3N0IGNwci10cmFuc2ZlciBzdXBwb3J0CgpGb3IgY3ByLXRyYW5zZmVyIG1vZGUs
IGEgdmhvc3QgZGV2aWNlIG11c3QgYmUgcmVzZXQgYmVmb3JlIENQUiBzdGF0ZQppcyBzZW50IHRv
IG5ldyBRRU1VLCBiZWNhdXNlIGFmdGVyIHN0YXRlIGlzIHNlbnQsIG5ldyBRRU1VIGluaXRpYWxp
emVzCnRoZSBkZXZpY2UgYW5kIGNhbGxzIHNldF9vd25lci4gIEluc3RhbGwgYSBjcHItc2V0dXAg
bm90aWZpZXIgdG8gZG8gc28uClRoaXMgc3RpbGwgd29ya3MgZm9yIGNwci1leGVjIG1vZGUuCgpT
aWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPgot
LS0KIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgfCAxNyArKysrKysrKysrKysrKystLQogaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QuaCB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QuYyBi
L2h3L3ZpcnRpby92aG9zdC5jCmluZGV4IDU0YzVlYzcuLjMxYzcyZDEgMTAwNjQ0Ci0tLSBhL2h3
L3ZpcnRpby92aG9zdC5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC5jCkBAIC0xNTEzLDE2ICsxNTEz
LDI0IEBAIHN0YXRpYyBpbnQgdmhvc3RfY3ByX25vdGlmaWVyKE5vdGlmaWVyV2l0aFJldHVybiAq
bm90aWZpZXIsCiAgICAgc3RydWN0IHZob3N0X2RldiAqZGV2OwogICAgIGludCByOwogCi0gICAg
ZGV2ID0gY29udGFpbmVyX29mKG5vdGlmaWVyLCBzdHJ1Y3Qgdmhvc3RfZGV2LCBjcHJfZXhlY19u
b3RpZmllcik7CisgICAgZGV2ID0gKG1pZ3JhdGVfbW9kZSgpID09IE1JR19NT0RFX0NQUl9FWEVD
KSA/CisgICAgICAgIGNvbnRhaW5lcl9vZihub3RpZmllciwgc3RydWN0IHZob3N0X2RldiwgY3By
X2V4ZWNfbm90aWZpZXIpIDoKKyAgICAgICAgY29udGFpbmVyX29mKG5vdGlmaWVyLCBzdHJ1Y3Qg
dmhvc3RfZGV2LCBjcHJfdHJhbnNmZXJfbm90aWZpZXIpOworCiAgICAgaWYgKGRldi0+dmhvc3Rf
b3BzLT5iYWNrZW5kX3R5cGUgIT0gVkhPU1RfQkFDS0VORF9UWVBFX0tFUk5FTCkgewogICAgICAg
ICByZXR1cm4gMDsKICAgICB9CiAKLSAgICBpZiAoZS0+dHlwZSA9PSBNSUdfRVZFTlRfUFJFQ09Q
WV9ET05FKSB7CisgICAgaWYgKGUtPnR5cGUgPT0gTUlHX0VWRU5UX1BSRUNPUFlfQ1BSX1NFVFVQ
KSB7CiAgICAgICAgIHIgPSBkZXYtPnZob3N0X29wcy0+dmhvc3RfcmVzZXRfZGV2aWNlKGRldik7
CiAgICAgICAgIGlmIChyIDwgMCkgewogICAgICAgICAgICAgVkhPU1RfT1BTX0RFQlVHKHIsICJ2
aG9zdF9yZXNldF9kZXZpY2UgZmFpbGVkIik7CiAgICAgICAgIH0KKyAgICB9IGVsc2UgaWYgKGUt
PnR5cGUgPT0gTUlHX0VWRU5UX1BSRUNPUFlfRkFJTEVEKSB7CisgICAgICAgIHIgPSBkZXYtPnZo
b3N0X29wcy0+dmhvc3Rfc2V0X293bmVyKGRldik7CisgICAgICAgIGlmIChyIDwgMCkgeworICAg
ICAgICAgICAgVkhPU1RfT1BTX0RFQlVHKHIsICJ2aG9zdF9zZXRfb3duZXIgZmFpbGVkIik7Cisg
ICAgICAgIH0KICAgICB9CiAgICAgcmV0dXJuIDA7CiB9CkBAIC0xNTM4LDYgKzE1NDYsNyBAQCBp
bnQgdmhvc3RfZGV2X2luaXQoc3RydWN0IHZob3N0X2RldiAqaGRldiwgdm9pZCAqb3BhcXVlLAog
ICAgIGhkZXYtPnZkZXYgPSBOVUxMOwogICAgIGhkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyID0gTlVM
TDsKICAgICBoZGV2LT5jcHJfZXhlY19ub3RpZmllci5ub3RpZnkgPSBOVUxMOworICAgIGhkZXYt
PmNwcl90cmFuc2Zlcl9ub3RpZmllci5ub3RpZnkgPSBOVUxMOwogCiAgICAgciA9IHZob3N0X3Nl
dF9iYWNrZW5kX3R5cGUoaGRldiwgYmFja2VuZF90eXBlKTsKICAgICBhc3NlcnQociA+PSAwKTsK
QEAgLTE2NDEsNiArMTY1MCw5IEBAIGludCB2aG9zdF9kZXZfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2
ICpoZGV2LCB2b2lkICpvcGFxdWUsCiAgICAgbWlncmF0aW9uX2FkZF9ub3RpZmllcl9tb2RlKCZo
ZGV2LT5jcHJfZXhlY19ub3RpZmllciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmhvc3RfY3ByX25vdGlmaWVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNSUdf
TU9ERV9DUFJfRVhFQyk7CisgICAgbWlncmF0aW9uX2FkZF9ub3RpZmllcl9tb2RlKCZoZGV2LT5j
cHJfdHJhbnNmZXJfbm90aWZpZXIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZo
b3N0X2Nwcl9ub3RpZmllciwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01P
REVfQ1BSX1RSQU5TRkVSKTsKICAgICBRTElTVF9JTlNFUlRfSEVBRCgmdmhvc3RfZGV2aWNlcywg
aGRldiwgZW50cnkpOwogCiAgICAgLyoKQEAgLTE2OTgsNiArMTcxMCw3IEBAIHZvaWQgdmhvc3Rf
ZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqaGRldikKICAgICB9CiAgICAgbWlncmF0ZV9k
ZWxfYmxvY2tlcigmaGRldi0+bWlncmF0aW9uX2Jsb2NrZXIpOwogICAgIG1pZ3JhdGlvbl9yZW1v
dmVfbm90aWZpZXIoJmhkZXYtPmNwcl9leGVjX25vdGlmaWVyKTsKKyAgICBtaWdyYXRpb25fcmVt
b3ZlX25vdGlmaWVyKCZoZGV2LT5jcHJfdHJhbnNmZXJfbm90aWZpZXIpOwogICAgIGdfZnJlZSho
ZGV2LT5tZW0pOwogICAgIGdfZnJlZShoZGV2LT5tZW1fc2VjdGlvbnMpOwogICAgIGlmIChoZGV2
LT52aG9zdF9vcHMpIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggYi9p
bmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oCmluZGV4IGU5YWNhMTEuLmFiN2U4NzQgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhv
c3QuaApAQCAtMTMzLDYgKzEzMyw3IEBAIHN0cnVjdCB2aG9zdF9kZXYgewogICAgIFFMSVNUX0hF
QUQoLCB2aG9zdF9pb21tdSkgaW9tbXVfbGlzdDsKICAgICBJT01NVU5vdGlmaWVyIG47CiAgICAg
Tm90aWZpZXJXaXRoUmV0dXJuIGNwcl9leGVjX25vdGlmaWVyOworICAgIE5vdGlmaWVyV2l0aFJl
dHVybiBjcHJfdHJhbnNmZXJfbm90aWZpZXI7CiAgICAgY29uc3QgVmhvc3REZXZDb25maWdPcHMg
KmNvbmZpZ19vcHM7CiB9OwogCi0tIAoxLjguMy4xCgo=

--------------1XrvXeKVO4iA48O36CYtTfHG--

