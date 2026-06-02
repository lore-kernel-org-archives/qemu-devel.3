Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38E9CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUOGl-0001o6-7E; Tue, 02 Jun 2026 08:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wUOGU-0001m0-In
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:30:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wUOGQ-0000cL-Mz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:30:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525vOmT221348; Tue, 2 Jun 2026 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xqkr5m7GCyVEkzTXivMe2VZd8yu7xMEHHc4/RfwXpvo=; b=
 ZsnvSFTL+AMZesgShNmJZeYYvWsJxIiOS2wAZLWlETeo+ycqVhFT5bQxR+Cc7sJN
 O6cVoHMEBXS/5BgyDJ1CjJ6xZ+lUZzQGssK732x48Gbl0P/zQLQ9//8/WbLdWWCW
 fsfmjd9ejjDc0Bkq2aV1AoGYGN0E9MbpN329LUkkuSQjZZYEuSgZ2xUtOVXpHuz6
 Dkso+PRvt8ygErtM0Sgj2ZXjA1v4W9tz4RRnNEBYepyaq46Pp+tQpRjfrIaRMG4G
 Zo5CHevE6uNFHd5eLF84o4TzrXaG9CN9rFYrtENfINogIjV79ogjNH9Nl96+S84d
 IZUt0jybMTRM2x++09lGbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpfxv0vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2026 12:30:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 652CUMgl024012; Tue, 2 Jun 2026 12:30:24 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4efpbqkvbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2026 12:30:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZZkLoclVOPn3cZMAQyKROYZmDP+KlxIT/E/DzfLvNiS0q6s+N07CwufDwQVr26p70ui14eow6LLIFMsy9P1Qchw4rvyy5Wb6WiKBh4rV+HN7jln2zD255dI0SA84nCcNxVfUvwKPPIgkx3jKPsgPkZtiwW0CvuolVxz7IXTUnAWfmZLbqydaW0Y+ToMgXwnUFT2C9A/2f9g5rTXXDSOAtybEe+vx65ILq34HV9rutPYtE+cvGBN5Z4fdcP740lynG3XgOmtUMYBtEzrrZ52eBkQfDgRwvW2uodzDYY5K8L7LbS7sMAiI0ag9kZW5CsbKBaELJJRERkdNHJCxtRF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqkr5m7GCyVEkzTXivMe2VZd8yu7xMEHHc4/RfwXpvo=;
 b=U7cypk3PDmPnSvUu53WQqd3gJXPgHsU4OBp7ywRqZZ1s1oxIapx7QfhD/wOnmcWnulU9B0kg1Dtw3XuLf5TAxJ7lv3cJmIYuH71/dVmNWR1Y4heMGd6rrHcUs77tDcZwrbY6UMnsWsWythzpuNo8txQ9pe+jlVLd4dgjL7RvIjvbmV4CkX4DzFbPap1Xv5ZAYQEMsZ0Z3rNMKZbxK1zDudjloQc/iG//39hLdU1s61JH5CPwGuedIs1MSeZGqwgtBZY3I/scN483vX5U6A5RMTZhexyFfK082DeKwc637/eOspnSdEsOwZN+uGc+IBNYxdr4s8Yw+XsdeoaVp1tniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqkr5m7GCyVEkzTXivMe2VZd8yu7xMEHHc4/RfwXpvo=;
 b=fTSFDb+fN9SE2mO+LG+HIhL+Es85gGQ+79YQhuS4iwe4i382ug7dJh0bUFlzhyXSwLeN+YXldDS4TVguc9/7Y6ds5hEAm4n5NenDZ++RR14UY93idJs5BuLF3IwJybTt26Ue/lLWMHSynZpPq48kgdZ56ke8C7aUFxMRj50VqVY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA2PR10MB4490.namprd10.prod.outlook.com (2603:10b6:806:f9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:29:29 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 12:29:29 +0000
Message-ID: <2e686792-4479-4ace-a1a7-9e4bf0981cdc@oracle.com>
Date: Tue, 2 Jun 2026 08:29:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest: Add amd-iommu command buffer head wrap
 test
To: Costas Argyris <costas.argyris@amd.com>, qemu-devel@nongnu.org
Cc: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20260517192314.355499-1-costas.argyris@amd.com>
 <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
 <20260530183458.7778-1-costas.argyris@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260530183458.7778-1-costas.argyris@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:408:e8::8) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA2PR10MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a74706-c75d-4b07-513d-08dec0a29731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wi6NtGkr4Uil5FRBdNba57N4EeecXgPCLs/K8vnV/TzxKcoD/vg7cEfgJ7sC98qr6S/lNVuv+ieUjSl5zXmgdu7DgXmyVjQcvh3lKAruwxsV5XXG9SUHFRcg4JFrRapurf7sV9bW/Lib6pO2ZqSJBUYIWd+2RvFIaVLdO2myWISEpOnOio8toT3HuUTZibA9dZG6hVUYajl1nakmoo4hqeQKGPWFI5xQnJ2eWroo+eAGjfjTrtagxBNDdpMZRc1iQhsq1w8WAeUM+/chhTShZtz2j4oQcPPpm3ko9U3anQHW7DETT0CEg98GrCc1nz9r4coxlWi09xGfhAsGcjy4TlqdHPDzqPphXahGxc2tyPwMAt3Qq0YnUaj/sEYqbAhtK70kAeTr0T2DGvcpRFNbek5RQMymPbeOxZZWOlwozPCDTNhKsPcuQFVekvWq6fH0hq19kQN52cm0/+9TUl//9YPFBGzhD/+BLSPgi62q6Qc4ln7g9MubbHEjOB6EAMxWinUW4htWZUEnudat0blxAH/gULszwHPizey6sXgwgEyPU9DUwlCiruCQOnJgLuu9AiHXdaOM7NJZP/B7lcnjsChjPgTK8I8SL4yYB5FiiFUgsU3Wzs+Katiiz2zuEoB/ZWfRG/c9juDAAd8uh+VY1HUuUujOcDtJOnOElu5J1EkoO6uUP06f+5FwbPP+6scG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpnOHdyS2xzZVZWWGYreGhCQzRlL0NobTl4RFlkWlE3Tjd4eGVLeG1pV0FB?=
 =?utf-8?B?OTR6SjVFU0ZxbVprbWxuOHNzOEtYWHhjeGJSRVBsUVJSTEJTM0x1cVNKRlUx?=
 =?utf-8?B?T1F6VXBPNExpaCtqT0l1UGJZbmpWclpMZ0VjR2Z3R1lBT0c3UzhqU2RXWU56?=
 =?utf-8?B?ZXhEUnBBYktBQVIxbmQ4RTc0V1YvamRkdlhPSjdqcnVITVFWU21ETUhtQktt?=
 =?utf-8?B?MXpXUTQxZDNnSlpaQlU5eDhsOTNQSUlxQjRpVXJ1bTdpL3lCbTMvdWJSMUhV?=
 =?utf-8?B?TVVmYTkwNUVVRGZGSHFCUW5YRVhkd2dKaEJFK0ViQ1krbU91TktwK1NhSXhP?=
 =?utf-8?B?RmJQQ0d3SHpvNTNIQnlUczBFczhTZFdnQk5UZkJRYXZzeXRRTkZobVpPck9O?=
 =?utf-8?B?RzIvY2oxRkJ0SXpueVBRSkJ2am0ybzBaWVJWOE5RODgzT1RiOEYxSWl1cFkx?=
 =?utf-8?B?VCtqOXdBK1V0WXdVZzV2MzBWRDJHR1JLTm5rUDRGRHIxYVFCbzMyZkxTV1py?=
 =?utf-8?B?QThxNUpseXdFOHhSTURXQlJDZEJCb2RMRUNhU2RSdi85ZHVGcDllaUplOTRC?=
 =?utf-8?B?a1lsVXF1OEcvdXJibTNlb1RlTFhjSFRpM2EwZlVjZUhFUmFsbHZoRjVPZkFK?=
 =?utf-8?B?VjBHUWwwWHVSNGtVdWJySWppQXk2R3IzRmlBNW1lM3Yzdkc3NGNPeUdLUTNM?=
 =?utf-8?B?dXd6Y1lHR1lWQ2pKaHhZT1gwelhwV2o0bkk4aU5JTGJuUEoyTzRZelFjWGJ0?=
 =?utf-8?B?b0pSNEhYd29MWXozdnFIK01WNGNnQ1UveXBOTEp0cUpNTWpSOEJESmF6Tlc5?=
 =?utf-8?B?dmRsMk5wSHZNNk8wNGRyb1NMdzBTNno1VFRJcG9ERDN3ZTdmeUl5TitmQ2gy?=
 =?utf-8?B?WlBtV2E5NG41NE8zZVJJZmxWV2hQUUFNNHBpb0laRmJQWkhUazM5Z3JVaE01?=
 =?utf-8?B?L3cyZ3dwcnhTWE5UcmVyM29QQS9qazRUbjBHY0JnSEtaSmc2SkRqNjVhRlBV?=
 =?utf-8?B?bCtCajRsY1RnNmM3WW9iNXNKYytqR2dBMXpGekM4RU5ZSURFQjRlSE5Hd0th?=
 =?utf-8?B?K1F5TkdRaGFIak5ybm10RFFMc210UnBEai96WlFaNDlGRG52OTFXWVp3K0NH?=
 =?utf-8?B?UEFCdGpkdktpZU1SaWp6Wm41TTd2MjhFV3ViZXFQWks0MHc2Zk9NL3RKNTdC?=
 =?utf-8?B?ZmtsMVAxblFnc3YxMlFtRUtiaFVON1lnWURUOWNLMDR6WlpCQ3djK0FhdFZo?=
 =?utf-8?B?NUVRekxFd2Rrb2RXVUFaQUpxbURCS3A4blZQc1F3Y3Nyb1d3ZTRidjR5ZFpH?=
 =?utf-8?B?T1NmL0l3d1NjYmVnc0k0eWowZUVLS05mWWNYMDQ5YXVvYnBSSWFuUVdJR3Jo?=
 =?utf-8?B?UFFKMjRZT1VDUE1yUHlHdjNGSUhVbzhhWkhscHdXOW9qVktESlZva1ZoLzVj?=
 =?utf-8?B?RGE1MVhOaTRtTno5cFlVWXcxWU9QR0Z1WmxCOE8vZzJhS1hOYUV2NnRVSXlm?=
 =?utf-8?B?NFVwTnNxb2dOUkRmdFdCaFArT21QTms2NjVoZVZ6Z0dtMnZRYk51ZTJrL2Vo?=
 =?utf-8?B?SlhoajJlK1RMUkRsVXk5TlNiSXY1QjIydm1SZjlhYklKWkVWMUdLalFOTTlX?=
 =?utf-8?B?c0pDem9DQUFEMGRuR0trTFpiODN2QThFNVhkS2RhSHNGT3B3eVRxVHlSZ2t4?=
 =?utf-8?B?eWtCRWswNUZjTGh4Z2RBUmMzemk4Ny9xc2M3T25oOS9KOFFnbHBvUFJNSkJi?=
 =?utf-8?B?Q09tdFBXZk1FOGVZc1B5ZE9kaTl0MzVTbm83VnBtYS8rTmh5RmxKZUw3U2F3?=
 =?utf-8?B?eTdrWTduYURqdFNLb3UzZG1FRzQ0VG5ScTdTdDBOQmFyMjI1Q0R4M1NrOS93?=
 =?utf-8?B?TzlnZEw2Zlcyc0duYnVpb1Q2NEJGZE9wYTRydmFwSDJRT243dGRFUUJpZ2N6?=
 =?utf-8?B?b1FHR1NjOVQ0ZHNlMmJFSHBRVFZEOFhVM2h0c0ZIN0tnYWpKSjROQytyOWhO?=
 =?utf-8?B?WkNHT3FxemNqbUFVUllpT0lNYk1wOEVoQzhWSC85VmRXaFl0WWNFWCt2MzJm?=
 =?utf-8?B?dWppYURUdkRHL1dRVGZUcGxyS294c212VDgxa2ZsQWwxd2RmUnplRjIycVN4?=
 =?utf-8?B?QXVHQnpuaEVWRktmMUFBUVNSNXZ5RTFneml6SmJCTUVZVG5Za2lXNnlKNU1K?=
 =?utf-8?B?NG4wRkFjUVVSbTJkMytxSHMrZDBPSk5Dd0c5dzlGR0dRMU1FZWRhYVV3YnF6?=
 =?utf-8?B?ems5MHkvT2NSaDcyMzVpYmd5OW11MnRuK00zTVBPcUk3QlZERkFlZWkydFNB?=
 =?utf-8?B?bEdIVnc0Mk9VYVZZazQ0MVJMYWdyc3hVdVRFQVFYb2NQdVcwWFI2aWx1UDlI?=
 =?utf-8?Q?ExbYTd9DT06Xcj8RnF/xvnK1IqQGSy4Qf/PcM?=
X-Exchange-RoutingPolicyChecked: f/R/YYBxvOXo849gZeMUvGTXySFYiIVcvA8tgiu2bHTcpk6eMx7FBArS9/DcfxPTsst8At+q2pscZvkr1eu+Bz0+DQid89h8P6gplR7LHquHhDQlJv0k+axiwh1iJcNlpzQcExBYR66ZVMMx3z4ALZ5HWU2WVHZaXsgVF7cuEV00j7GOLI6Ykgq5vbUgTauOWq//JWIPz9QCkooFH0tOKBuhL7Kd6P9Ykctgu1yjY5RycFV1SQgj+LoIWzxa08tLvOKpKN8x/V5eJcnxAfaQEuuPGiDtq1cKODkCSFQgs2tMKSDpkj9kdp+XHGmS/J0HHXw2MSl9iV1pF7QJKZmMOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mzwaj0aYnITaj93BHF+JmcSGRBr1QwkZnWdichSjcjvTeted5Kvdq2Kwe9LYMJJ2J3+RW49xZs8SJgDXwQeNuHSWlexl1EfO2mhFEl6Nxld6XkHB7w3eS3UZmOMJoVIHTMgVhsRvSRXRH/ZAFNMpFhfCC8PYbVbATzrfXwKu0l14k20EOO02RbVHMEKmzoVfx2V1Hd8pbRfYs9BgosJLpwtS4FvVdyZZ9M4dDsYID/fBfFrihkkxyAnzFFUpfgH7eAxWy4AnSmBd3d6J/X04qztWT+qIQLw2irW2AAdlSPmID/cysJN/LxczuGNhpcw6rfK+x6HEtAE9z+m8docXuFhRFVvggwynXnX2aoU4IVkQXs7HzNxudhYq0wnIqSTi6jzhRYx0/BMvGXXMZbCxeZ6lj1iuyVy01UWNpR8IRTAjpFftn/IqkFqtzQs25muPDu9n9Vs6F8uySGXgnMYJyZOCXmGMH6f5LceRehWmi8lgW+1K+iBIYfgDWqj0i6WZWl+N0pbdTfBXEL6xQ4O6Oun55JHvaQ1ksNUXjbDb0XW62WkZRUThuvLnBpK2NZb/cZfSDZnnyxS53M/IqltescsNU8seir0KHxZb0SXfxKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a74706-c75d-4b07-513d-08dec0a29731
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:29:29.1899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElQUCLZZdrVgTPz3/7g6ZmiJIwdtIseUD4mqy+yg3doqUYNCE3/JQrvvHvWvu+DUaDgu+jwAr/3EJqKwtrYaRERocqCWH2sWjWbrjSFeK2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606020120
X-Authority-Analysis: v=2.4 cv=FOMrAeos c=1 sm=1 tr=0 ts=6a1ecce1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=69wJf7TsAAAA:8 a=fvtuARZR8gGRFVwsUHgA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12302
X-Proofpoint-GUID: Twuef9PTfezeee55xvCMmF7K_rhwNOe2
X-Proofpoint-ORIG-GUID: Twuef9PTfezeee55xvCMmF7K_rhwNOe2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEyMCBTYWx0ZWRfX0LC1zsCw/Rde
 TXHk2I+lFg9JC/V9cgFoGSGWvce3TWhpJW7ZG4UVSRqc9OF+go4njsRK2e1hlULBTqoy+VIHgMO
 s9TrzvHh/3ikDunLW/ixUpkoi7ybXLylefNrNx2yf1zm39rBQHgGf06YUV3ZaQef1MPjmQbp84M
 iEUmn1IPrNpTus8Kz8h1tQbcBZUQDvfXt1bxzkJs7DmY8CS+nHRvP0JSjpJNx9T8r9C472VVMCF
 9J9SyVlsQKMh7JBPtdIwcQ5Nf2jBQQElpUpeCy+3M3RnRrOUyzaSppLUZ8fBMivzx0xL6o+wS73
 oKDysBY4s51BACUzkRugkhzi8xyjN6h22dsrjonMYgEvCf3KyYcr4nstPb5bFp23gPl3m6jZSCJ
 7fc+4b2n8MqCzuxeokIJHBLSbgfeDeKvVf3x1O4ggfD7Tj+psuC01GRvOj14+ol6LzA1Zp4clsc
 CW+6JWPOTbCMD49dQeCxPZgCLpnYjmbcv00XHl5o=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/30/26 2:34 PM, Costas Argyris wrote:
> Add a qtest for AMD IOMMU command buffer head pointer wraparound.
> The test programs a command buffer, fills it with COMPLETION_WAIT commands,
> advances the tail to consume all but the final entry, then wraps the tail
> to zero to force the final command to advance CmdHeadPtr past the end of
> the buffer. The guest-visible CmdHeadPtr register must then wrap back to zero.
> 
> This covers the case fixed by an earlier CmdHeadPtr wraparound patch.
> 
> The Linux kernel AMD IOMMU driver is not affected by this bug because it
> uses COMPLETION_WAIT with a memory store doorbell to detect command progress.
> 
> Signed-off-by: Costas Argyris <costas.argyris@amd.com>

Hi Costas,

Quick note on good practices: it is preferred that you send a v2 as a new
thread (with an optional link to v1) rather than in reply to the initial
thread. Not an issue in this instance since I am aware of what is
happening, but it could make it harder/confusing for other reviewers to see
the follow up if it is buried in the original thread.

I'm offline this week, but wanted to at least ACK your reply. Will review
again and apply to my tree once I am back (and it will also leave time for
others to review).

Thank you,
Alejandro

> ---
> Changes since v1:
>  - Drop the amd_iommu.c fix.
>  - Reframe as a test-only patch.
>  - Derive CMDBUF_ENTRIES from CMDBUF_LEN_FIELD.
>  - Skip the test when the q35 machine is not built.
> 
>  MAINTAINERS                  |  1 +
>  tests/qtest/amd-iommu-test.c | 76 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100644 tests/qtest/amd-iommu-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80d28e618d..750d415389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4052,6 +4052,7 @@ M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>  R: Sairaj Kodilkar <sarunkod@amd.com>
>  S: Supported
>  F: hw/i386/amd_iommu*
> +F: tests/qtest/amd-iommu-test.c
>  
>  OpenSBI Firmware
>  L: qemu-riscv@nongnu.org
> diff --git a/tests/qtest/amd-iommu-test.c b/tests/qtest/amd-iommu-test.c
> new file mode 100644
> index 0000000000..fb28511588
> --- /dev/null
> +++ b/tests/qtest/amd-iommu-test.c
> @@ -0,0 +1,76 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/i386/amd_iommu.h"
> +
> +#define CMDBUF_ADDR       0x200000
> +#define CMDBUF_LEN_FIELD  8
> +#define CMDBUF_ENTRIES    (1U << CMDBUF_LEN_FIELD)
> +
> +static inline uint64_t amdvi_reg_readq(QTestState *s, uint64_t offset)
> +{
> +    return qtest_readq(s, AMDVI_BASE_ADDR + offset);
> +}
> +
> +static inline void amdvi_reg_writeq(QTestState *s, uint64_t offset,
> +                                    uint64_t val)
> +{
> +    qtest_writeq(s, AMDVI_BASE_ADDR + offset, val);
> +}
> +
> +static void test_cmdbuf_head_wrap(void)
> +{
> +    QTestState *s;
> +    uint64_t head;
> +    int i;
> +    /* 16 bytes per command */
> +    struct {
> +        uint64_t qw0;
> +        uint64_t qw1;
> +    } cmdbuf[CMDBUF_ENTRIES];
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    s = qtest_init("-M q35 -device amd-iommu");
> +
> +    /* fill the command buffer with COMPLETION_WAIT (no-op) commands */
> +    for (i = 0; i < CMDBUF_ENTRIES; i++) {
> +        cmdbuf[i].qw0 = (uint64_t)AMDVI_CMD_COMPLETION_WAIT << 60;
> +        cmdbuf[i].qw1 = 0;
> +    }
> +    qtest_memwrite(s, CMDBUF_ADDR, cmdbuf, sizeof(cmdbuf));
> +
> +    /* point the IOMMU at the command buffer and set its length */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_BASE,
> +                     CMDBUF_ADDR | ((uint64_t)CMDBUF_LEN_FIELD << 56));
> +
> +    /* enable the IOMMU and its command buffer processor */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_CONTROL,
> +                     AMDVI_MMIO_CONTROL_AMDVIEN | AMDVI_MMIO_CONTROL_CMDBUFLEN);
> +
> +    /* advance tail to the last entry, consuming all but the final entry */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL,
> +                     (CMDBUF_ENTRIES - 1) * AMDVI_COMMAND_SIZE);
> +
> +    /* wrap tail to 0, consuming the final entry and completing the buffer */
> +    amdvi_reg_writeq(s, AMDVI_MMIO_COMMAND_TAIL, 0);
> +
> +    /* after consuming all entries the IOMMU must wrap CmdHeadPtr to 0 */
> +    head = amdvi_reg_readq(s, AMDVI_MMIO_COMMAND_HEAD);
> +    g_assert((head & AMDVI_MMIO_CMDBUF_HEAD_MASK) == 0);
> +
> +    qtest_quit(s);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/q35/amd-iommu/cmdbuf-head-wrap", test_cmdbuf_head_wrap);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 728dde54b3..67eea5c71a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -95,6 +95,7 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
>    (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
>    (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_VTD') and
>     config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \


