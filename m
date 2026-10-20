Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7F60A5BE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=KFTg2pbm;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=LtaPj1y5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBuH-0006LB-MH; Tue, 20 Oct 2026 11:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBuE-0006Kd-5R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:37:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBuC-0007Bq-85
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:37:37 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDCR943065801; Tue, 20 Oct 2026 08:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=bsgRoB+zpAznv47
 vW/doiAj5prykCgf2vBGpN1Spzuk=; b=KFTg2pbm42u58OFCUBsnWm4Q0o66ZgD
 U6zk6c91p7FkuAxnrSJwzHajQc1mV0Vv//Oi5i8/CjFWgi9pH9KOrG4uTmLhf0ly
 lM9TztvEYXV5Po9VueBX0gNdMbL6+Fa3nP5eGeQq33H7wA7EaNw3MSdmTkK7+6qT
 ZzCl6yKReUAK7+eh2zLxHvmztEspqYMN7GW/MFJRXRgp2qfoPLHbjzXauJShvSti
 GhL2E6c56qJVbcJFFSAxChOAr4Be1K+UHsN0sUbVktnvwnZoJGTbQrzv7upxgxsq
 QysZzSNaJA7MNx/ecBUL01JZ8A+Q03SiDWccg7tesZmamjxnS9mnr3g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020123.outbound.protection.outlook.com
 [40.93.198.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdw5r9v6a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 08:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMpEMGM4vxw7sH7kdFDA2fDZi/SihLN/RHENlVSpXCTYwsc+1VkONtEDUlYrK0Yt7V2JumRMnTuWxigVZwY3jqG3Fm6huA1rGQcXbtkx4wjDNMk7ir322lReWqkT2JKc7ogojrxXeXYI3+nGZVlZhM+UXieRRPaJzpI8zLhXoMH+14bE0EujzqJWyfccEjbg2oITyamLyNlLCLAOpQOESlMMmj7WVQpIalykyNQPYTvaLtT6Ez8/LSrlcl5wNrBllaAoW7bxpjUXDqClPR7F70y/BQbM4dAu0Rh0wYi2s/b9qpoWxY1rBfMtuMD7X/wCvv0rxhO4kM4+iBMpl3kwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsgRoB+zpAznv47vW/doiAj5prykCgf2vBGpN1Spzuk=;
 b=Y9PDZDrrMVEtr1syQyvbfNGawmMonNwHFI5Wlp3WRgdZLeRDJVxCzX04YrjsSKdEF/9lviUwqzotNwcflmNv6x5nr5rPaw8uj7c3l1eNGwo+nFG6n5vW7nm9MRIFz/WcdQekvSqkw4LJZM+jnnEZsib+4dJgoQEImDqey6N5Ys/8dzE3PEGcFYMEg9/UaiQx070egNOjL7JYrJdoEs2WUli9bnrG65aCcgW/C+QhNZztWIYOLWXK3FC/gSRktCX2KrBXb4VdSt5iGCCTSfa5Ea6EwgItIdkdgBJeVfrPLl/0kE58hnqqAT+i2GBRPkJJlvJVoBKKlCJr+ox1VcPwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsgRoB+zpAznv47vW/doiAj5prykCgf2vBGpN1Spzuk=;
 b=LtaPj1y5Dxb2W/xNHTRO0ge8FJrHpwa6tv0UO8/chdVkjzG99dryerykjj1k+bTWvSJGMxDwBvBevNEHDOgRDl3KKeZEBBGnhPdprmU24fyFZSVNc49kDvgfYG5PEc72RBaxb6SqIqFtemBJt+uutz2w37QxG7N5IeqlfImBryArUfj2WwIQozYHYH2c5O8/06WJvValTNvop0pfM1zUjDAL1pycWdGWx12ipDtCQuTlXXNhqIQDrpd1Urh1/VW4wD5f1poiH13PZL700GiisTqWfmKxdUProK8kBmk3bFxNUUdv3Q4Mrj/lN9ctPMftULQRiedNkToOelRdwXtJ0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by CYYPR02MB9928.namprd02.prod.outlook.com (2603:10b6:930:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:37:25 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:37:22 +0000
Date: Tue, 20 Oct 2026 16:37:12 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v5 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
Message-ID: <ateKqNnV5upNRk2Y@lent>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-3-namangulati@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211041.1087331-3-namangulati@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|CYYPR02MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: d0143a1c-31bb-4fbe-35e7-08df2ec004ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: IV98tU4D04KqNkezGp54ZDySBDyUhtYzNox+BMr7TjIW1g5HoFTvrlTn+gq+j6HZTMrBC+FkK95w2fZHiKK5sG5gJj5vir7VxMPAa9OD5e36pAQ9HnM67yU7cyT6qoLzwsuAehVvq5RQdlwYKCdOFyAggBmnm6Z6y2WoXNlWhERvvUAUwkAmXUoZrF5bAbTZimrGe98CayE88QirNBJluguLzHdf8VkKM+S+i+B7zYIoptoGochd2g9fN+AGl1S0Fms5IXyTjp1yIlwpm+euIkswjJlNzHl/Go7e/qkfB4W4n2epmgGAhHPh6yOwHU9aAgaHdUf8Fz5BIl2W7S8AGsccqZP97plYmMm8hebsvK0WKLqOZC084Enfv69ifdlEtQaf3Oe6GdoRMU37sNvZlw52YU+EtNAejX45YS/qoglDIVUvUbFyMN+5Mx6bPJsz7Ao+90s1f6IlBhTUOzfiG9r85Irnx3TBh2e1qg7wNMZ7LxA/dmGNKs8ulf/OEsl3thrJ+hafHM91Y2qcKrUPsYI+fNb2fQnN1kEDyxSSynnoZp6kU+ctEwajJDzDgmuURmTJ/0R+CS5srUDPsdMPGloVPc33E78j7HmeGGyyHaHr2Z+PIbwazJvfjUqmMy4rc4XRSSqC0NAhnOy5kMW5jTZka3tmteyGFfIm9Ve/Kg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8tKQZtv8ku9Sx48U8Uff3frf+2enK43gwsNNNL27QpqbZaVZd7cRGwIX/a1?=
 =?us-ascii?Q?SlN7wp4kyopzWtY3+ovmRTxUhk0v7NfAIW+QILOP8jvSwgCvjHGzBgm9JRDw?=
 =?us-ascii?Q?O4jptXr+bcYP7wyRoIvhj3ZYDWmsQJur00FC4h8h3MoAKoyfoP+rUWasnBPb?=
 =?us-ascii?Q?Frq2vtRlPJnXHyhMG8E1jOsQc1EC/4weh+pGZiQ+3IpvFX5c7EGkM3CvlvJj?=
 =?us-ascii?Q?Dy4748kfJL/V0qf2hxLh9q3IXFl9xYBDNY0L++1k9lQVkUxErBZIK7nnvZtL?=
 =?us-ascii?Q?Aap+y0HzlasYYLCjMOR7o+K2zbexCBdY24HnKJng2l6DwZCUECTORZZIk+fq?=
 =?us-ascii?Q?azen3y2eusaqxk02sUCMVLS3jaH3cUBZKpsiKKClEac4XbvrSyb8jfILIqMW?=
 =?us-ascii?Q?vFUrEkFU3Km0idjMkBpvcRwEyo/0T8IjChjyclz5jVoTf3Z9uypW35f1p1mg?=
 =?us-ascii?Q?QoHNCq+70A02iptZGOUCmHuopAGISxYfWFL+KcsYqi/RmFH+0DwkkmJ+cCik?=
 =?us-ascii?Q?N0n3QQBKRSWmjGeCO9lzkUX3wa2Nbmr3bOF6djTs7AWKr9x6iRnC5AQ7Cumc?=
 =?us-ascii?Q?aAS2UVXmzu/QlpecVl7/twkVunAf8svOmb9XAuDmiDTizNSGqf8SJjf/dGZX?=
 =?us-ascii?Q?Vf0hIQ7ndJrvCVxvWmMHHh9deiYbTGbMGUsbrjXgBCmEPmDbld7iQUsrkj4C?=
 =?us-ascii?Q?H3EGJyi2UNcRm1L7tSnA1YjNaqDbd8q8NaCmszrLLr/ANyAzCPgij6QmJXgs?=
 =?us-ascii?Q?9sTAd6iFjGQb9szFPfIyLDPbtl+mQHxwUodZ+iNZ8F97Bh3RpdVbxc3Ldrz1?=
 =?us-ascii?Q?oIWHa1hsFfpk4a7qsJNQ7qoUwBx9UWO51cXxCrPDNMm/KSQBTfI5kadD2y5U?=
 =?us-ascii?Q?nlAphUsDSRZlNZzty8v3H+/2M270U/aDc6p2bLfmGdi47Cc3vI7VEIiIvsow?=
 =?us-ascii?Q?DRgDUSLwkErr+Py62QxU2AEU9US5xTjO0KW/8pgS6vUQ79bjYMJCLwOZJzRn?=
 =?us-ascii?Q?H0PyHhyGbjKp9I3iqD626UGad4qTFb+9OSK6uLrkc20sFYDjnhooDorL0aEL?=
 =?us-ascii?Q?a2Jcq2+dfTNdD39R6BvWKbtr2pVJfmO1QXK1vxPVkDZu2y4yWyX/OmkEhQnF?=
 =?us-ascii?Q?15gEv+ekMxOsq7yQ5NuhuQ1KkWLjW+OnXttHM0ff7TZH6pfm6xyqnosm+Ka9?=
 =?us-ascii?Q?7MqoCBUjOYH8xeWfjcwWkj2+ItA2PslxHuG3OZvSr77nvb8dPAqvh8fleF3M?=
 =?us-ascii?Q?QsFk5PAgrYaNFVJ818QufuTEnrki7urQf1d34SwRCOy18RsXT6MzCNJY7sUE?=
 =?us-ascii?Q?fC02IdEQ3Nb4dfMnIhsmVMtMh8DXQl0Q3jltfBTjXMyAIji5CW7ZiBm+9C0j?=
 =?us-ascii?Q?S6MMuOK+s5hZnCBYuQLo47PVZZ3dqNvr36KepmCPZiimkovGZfF+dzycHA0i?=
 =?us-ascii?Q?MBesKpRKRkEecj2Ew0oHNYaMdpAwndsP6OG+09USc2NDyvuR1ZK5cuqd9G2i?=
 =?us-ascii?Q?sns+k1m4XjR1ujKsvGlVw/nSndWxR3JRkVc+NETyTfMc8/AD58DWCppm4Vfd?=
 =?us-ascii?Q?cS8cJilLPQ6DAL37oDRWlpOHwNrMDD7Jv8BiDa8yUkO1+hv6BjMEzED7uTid?=
 =?us-ascii?Q?IdwAgwUbYk7viHEamtLc9ErapWN+Gq1tQ+hvQpcxrPabql/PVOsrAtWyKBjq?=
 =?us-ascii?Q?9wQROtt6NWFmbm8r1RzKOAUzd32bjIbbiF7E/xBXV4DdiiIFYNYj1mLXIiiO?=
 =?us-ascii?Q?Vzm/n8stSA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZGa9zPwY/UPGADbi/KMqFe9d1NBSEhr/ScYdfPpNv+oMlOTEIFHO9ugz5lqonQHxLArHoirAI7uRgdhitKs6lCm178CR1oou2LTe2olS3QKE27JAn4vyYzn8EYYykcnL1PDg4wHPl/AUYE6VZWlv8F2tT728tGmrKY93jfIOPO1jnvHOT8gz17d2p3bGO+XbqPWVOkSloaf8/mNp2m1TnDI6IBs8iATskzNfBkz8t4oAewNU/NnAmTlGWkYcW2k92dUhP/i4MVoREKCfSWz+CvC53nNhPOI0LHoOMRwPyfDtXQdZgk3HT3Zpg3filibs+IyNkRCISOCnODQn+C548A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0143a1c-31bb-4fbe-35e7-08df2ec004ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:37:22.7754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNcAf6E6gRjz+LpVnfw8swdqXR2Njd9LLpOcqUBO1ZOgppYaWw6yUoiuTyFR8nPglBThk7rDI18SbtZP8oq94Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9928
X-Proofpoint-ORIG-GUID: y-nW19AqAZswXbHiethyikxkO48F58au
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX32/RPyYvqy0o
 yxKSBXOabuK2jwxneG0DZaci7AXEZAo1l1GUJKkp6IU9MhHlboJW9+L+aKOd74bDvdr+UZEsZa6
 4lfUywIii/xYKv6XMXpnxDhPnB4iZIg=
X-Proofpoint-GUID: y-nW19AqAZswXbHiethyikxkO48F58au
X-Authority-Analysis: v=2.4 cv=At97T+9P c=1 sm=1 tr=0 ts=6ad78aba cx=c_pps
 a=mLoR1drGahLtw5ViIJY7rA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8 a=XnMAwA5Up1jnvlsX2MQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX0D0XOD/kqF5A
 UAW3HtChx9a4267wZ24J/YXLujn8RGjoT+jwnjVIWIRxmxSNL13Ik3MtC6tQjJeYLIdJ6U24Akn
 xHjWkFMZzE/Oi7cqEV3FNtORBq7eD6Lb0YT4PoBY3Tz0dSoKYvcLSxqoePntPo84OI16JgB2zsd
 20JCyLFgAWkEEGiPoMYCzcG5tAQubLQSwMF4k+wFs1Zx4sa3A+W/pnpTsavAyqxJial5+VkbXRr
 /kaLPcg7vzbaLk+1yt4G7VNwCp2r9pInm7WtHNSFypFFZzN6dd9UL19dTLrMuyTpjRcEO5ddtt1
 xEPFDYDRkjZJsKchDmjcdLFVdDPoom1IEygKjCNojL9p1pxX+/kYNA1ALZpPa72SN6IDgDP3gPz
 W6m94T8UORVAUO85vXNiigeaU+pU3N8qS6OSXK2P5mCLkz5OuAKq8PBLg+GORBolR4YSHNU/Tn3
 YlP3Y70tIjhbo90fEHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 09:10:39PM +0000, Naman Gulati wrote:

> Allow each sparse mmap subregion to specify its own file descriptor and
> file offset for the mmap call.
> 
> Add 'fd' (set to -1 when the region fd should be used) and 'fd_offset'
> to VFIOMmap, and update vfio_region_mmap() to use them.
> 
> Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

thanks
john

