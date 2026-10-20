Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030C60A260B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=h707/bg7;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=wq/+KGXh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBub-0006RF-V2; Tue, 20 Oct 2026 11:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBua-0006QR-FW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:38:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBuY-0007CW-Md
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:38:00 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDBw3T3016882; Tue, 20 Oct 2026 08:37:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=K38BZO9hCKzK0TM
 oCTOjunKcQriNO4BDDoh2OUaMY/s=; b=h707/bg7r9A1lHi4szqzcrEf+cXK0A0
 wU4QJQEGUJ6FXlQdc9Ir3odWORcT8iiCegHegnLpZ8ZmxY4r1Niuog1RJP3B/bl/
 r+0UTYMACc6HllKu96tV12cHiyK/WSXcOOaZjQ7F4z+jBqt5vS85KyHm7+PNDvxn
 VOGMIp/MdYzsVrhmdvZLITX/IYIK2TixpJstzVeoxFmZUlsM8JROopfJI3p20ogr
 l67Xv+ksM2DNMVAF7ebPu53xmd0BOn9aM/wAeHltooYzDzE86iHKRvqusCpEhCJG
 T5WawcMSxfTGCFcb1IDPeuQK/e9pGYmFR5L3D5x6oNopuyvOp6LzOBQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020110.outbound.protection.outlook.com
 [40.93.198.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdw5p1v1e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 08:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLcpA0cB2U0BN9ZttOo+jYAkRG2z6LG7t58fJE2NoaPkwAJJQMKLDW+J22ykVhq5iwlwZmdu3imEF+39ZZUtn0pa1nW0Xzq0SERiss/3TlFq+USb8sehioa3RmCb1KWKwQMzG9r0C792fFTIVB8IgQzhY5Ipw0/Iz9lBIUj2Bakx/PLjosY/wq5QL4EamWHsNW+ePyQmBWl80S7oocxTYtjdRjIHIkJA5nB84QJUSbmbNk7s/Kh3HtVYYVWVA4AHuX2xLjPxx4b5Q3LAKDevITAqv0Ly5/T9W7pRdUcZoo/5g5S+FuD4phF9s2or7Kc1TRm8PCQLjYcOLJgRhnqWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K38BZO9hCKzK0TMoCTOjunKcQriNO4BDDoh2OUaMY/s=;
 b=L+YuuJOx5v2LVl0XgCtj6L5E3T3jSFWib4AKpAFc44uE2Cl4regEw8gsiK41vo0aoNVqBOWUG7APe6kc5ASmMVktoPOlhroxJYf5bEiSfJWxxDVMFBmNL6FNmqFijB0hioG5Tfkktf2ca+TABm6VlHz0OwcTbuVhgOJrGnAA+8ECOt9PnjnmDMkuW8nDim7LAYfxGpLXtsHXvYSaFh51jhg5+mbuq6NcRKTR/9p0Plo5EHyCL0PnVKJoPVrAyw4xJ4o0/Mv52bSOf/VmyhERWfR4Z/qK4bamaFCIcg7Laqw1X67ngRszqhcXMdKfvQBDp42yJ/Vwz8X79W0WTtFfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K38BZO9hCKzK0TMoCTOjunKcQriNO4BDDoh2OUaMY/s=;
 b=wq/+KGXhVbitJHsEDgxG+aq2OHPRVdmrJxiKdLZRT27wo1iRmbvQ5oc6Mrff0NqZUDOPPitdKkzFA8j7z/0OadC5zzynocKC/ccbZfKvU+PTHwxA6b3tSUq22wlTOFOIz2r9FpX1fsyZA081HyilxbyS/lLOQ8nsdrkoOBP/rilFvByWxvrF79UvE0TGqGfEZsDqQMwrRwsVN76TJtydwO4flwS0fOb1L8Lzy7w5gUwJI2IMxHf3AksZXXl1x5eG7yTEWu/QoAsAvZmW/ARkYIJN8r5lG+/f/GCnqh1m5/rzqOxnhxPYUFWBF0ya1hZBsff4DC9fFj+SUN5vNAg0sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by CYYPR02MB9928.namprd02.prod.outlook.com (2603:10b6:930:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:37:52 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:37:52 +0000
Date: Tue, 20 Oct 2026 16:37:48 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v5 1/4] vfio-user: add multi-fd region mmap capability
Message-ID: <ateKzEbdNeV5BaSB@lent>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-2-namangulati@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211041.1087331-2-namangulati@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|CYYPR02MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: ed122aeb-a683-4197-92d5-08df2ec01a64
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|3023799007|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: ZlxaA1dcYJiC+7t8aXvhFEJnAqIPQwJVqrOhVZvmWDX2/LN44kNqlKynEkyob6nHnmniYzmJbx6RK7ADAHysWWYpW8d+wwFbSf5IPMmVpPjueJzgjNjmF4inRhwGd/a9EPE9wFusHm/v38420mQ4lwbRdDlofaEs7f3wefPt+7xTM+A1+705C6ehyoeSc1hqqAqHBZxWMilZmso+fzdUpocHPWWsqqJzWYcV9f1yR2egIndU4d6vde0Rr8vk255VgoGFSUQwkgQO9Pk4h37jDHp3clvADmX7RHfueKqBg9pa5hgonr6AUJZkN3Z57SFOqFrgtWuXhru/dvbp+oS0fsj7wLx7m/+lR+HnwJAiLlzhzE3gUW0UFe3ZlXbmcPSShUjQOb+cJTLAG0AOUsmV6bPCvi2pd6nMECEzwnaFuxprsP3ZUhHWT0dQKK+MpUnSudO5PWTUtS8kdAz6dDr6O1vgExIwZMJ0gw8f7LaYuFANNqFdyge5jeIyIiYZbNre1eg/CQBV/LZFME7oQMiMAMX33GauwNP8lZb/We1b8J+m8nMw6EcK2tK0prMfDUt3lIycbm4UgUipOFqogtgFyAHKcsSnb7EYhCDJckEtXk7rj2LyaMOzfCTHjW6XTOMFnE+Waj04SZENJCxsS2ooGXSMJNB51RDd3wEcm9BnTUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGnzXjuCtCDFjhr+eCyORt/di4uyx4QYYc6kB5tZUOkFj57bP5Z6TSNRSV1i?=
 =?us-ascii?Q?Wkm90muj7iJxDJdT836OsHeCxN0nAc+DkFngs06yhBPLhi5jr260ZDk8nrEG?=
 =?us-ascii?Q?mmJPsqD5iKXhWCccjgwcGOCfRahlTWBF7PRGzHUZyr29jTVtOMfhgOaL2FQ3?=
 =?us-ascii?Q?I9m6KVtOu0hwZ5dGDpRVsqq/q/l9izBWWdBguaZbNbySoQLwvfDmiRYfdNoQ?=
 =?us-ascii?Q?J0S1VdE1ZyChKPE1oBG147j1d54GTKbCug4KVzras/zesZE+8Qzmm+Nh5bUr?=
 =?us-ascii?Q?bvpCbNFps3W5dmIHvbOqJvTrbonLeobahRq6Jnp6He29Y4DbaLN0NST1Ol9s?=
 =?us-ascii?Q?l+JJHoEmvuhInQWSVE/4EQ/VHZqtgMYe6JEF0Baxa4M1bqxS6YLYe96yFyJw?=
 =?us-ascii?Q?EXDEOEcPrAdTzgJ9sBgfD+poIyc/xeuko9dj6kaNUaXWGweUqeRX2UQLSbKb?=
 =?us-ascii?Q?Na/HdAGp6JX5trrkh8mfy84JSGtjta4CfnYuyUjJY0jxQZY5bSMhBp3FbD7t?=
 =?us-ascii?Q?SDDdmgYtBPq7cGqAOlr6mkPRhwZKYIMQ2VGkow2X0Dg9L1Rxyy2GYxm5tu1u?=
 =?us-ascii?Q?R+i5OrJuy5YYM1jJ0oeChP1ffljQjRw8qoF7oHCPOv7QaKJJHMIu99F/nFfI?=
 =?us-ascii?Q?vz15tiqKfUYwCw8XMkWGuRZFjUksxY6nmeXlv1A/BCXDMZh/iVQfh8KWdBTD?=
 =?us-ascii?Q?GHu3/J/CUmxQvlfyEg0A2ItTc4YkKf7+1vhG2gdWxtw64lz2bdT97t7Wm+R9?=
 =?us-ascii?Q?Iz0LUVG4aH6b6FET9PVYYqykPT34ZET0p/bJ9DSWgeGZqUmmwyGps4CXWDee?=
 =?us-ascii?Q?6XAiCyJWW2w6IbL6haa+QJCYn/3+zRHMRuRRtilm1dSVOEOvsUdTk7DclQyH?=
 =?us-ascii?Q?8OEGD3XQGgy2mfDJ1LS5+CRuUCcd6d1D7TwOWt9SDIY3kceTUNKo5a4mNUh7?=
 =?us-ascii?Q?W1U+hjFccNuds3EJ2y2cvALKARgi5uLfpg1IaH1evEH7yKfj3NWtdQnB2S7p?=
 =?us-ascii?Q?OjPFLlrWdpNxZf78ggL85LmBQ/28pG4mSGkzWQCpCpoZ+ET5RUCnUoGrQRXn?=
 =?us-ascii?Q?UTDKlMGXFXfDCfQtHBZa5jDIAY2oHCK39r+bY7zNXXgXKbb1GShyexIM8E1B?=
 =?us-ascii?Q?fdD91eU5BgWuLMMWMi06E2gYk5S9zVp9B1FCDLzQl/8/zHgrGblMDe0ULPtk?=
 =?us-ascii?Q?WMK9hnVfHOdERVkfxNHX7aQJWmz42Lqq21Q+sO6uKCXrtqvhGiVzRt7Y2tCQ?=
 =?us-ascii?Q?BpFGRbVzsjbbdTsW/+3JbF87q/Cu60iMApZXllwVmDaHrJZhmonhU4VKU4A/?=
 =?us-ascii?Q?YV2q//4LXyF0bV5P+EQGvMYZT/H/MTC7THqQeza84bxep0xzr6FdOO+Jfi4z?=
 =?us-ascii?Q?BdZ6PLHc+z6pNp1pHFsLtC1w4G/KktqXA3XrbTAyOTJhpxSXxn1HRlsvtDOR?=
 =?us-ascii?Q?0SO+taPzXus5st2phBliZqwAQr3IbBPrNH7hV43S4DjFc23gjiYL3KIBSGAa?=
 =?us-ascii?Q?U5gcVMYzg0pnRQzsiB86t7EbG03REFhYR+V6ylbPsrZO6pDY3cc8VneZMTzg?=
 =?us-ascii?Q?gaX+tGc4xmEA/vT+klkWEWnfTqGMlRDcANEEO8BD4ZubLTLRIxoWWEZMQXbI?=
 =?us-ascii?Q?0z1HNzDIf+Z2Exh/NTqYH2XRnQsK2d8ouKyD6RGb+G/zGKYQPmQwjHzCVkUv?=
 =?us-ascii?Q?3cwLK5huF769gZZaY2syjpPdrsxwR7qvjqlFXE35I2YyxBIM0VNKWwyk9WKl?=
 =?us-ascii?Q?Mp+8laN1bQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: gbvNjUUcUbU+2B739VdqodOsOK0nwBZTj5V/id1SQ5ilhPsBbyB+omOcJm/+12TPrgI5qDZXt29lHF+XXOj+nWpu+wYDgjZ8vIKiucsZt+wZ2NavpSYjZP2z3LSGMMyJao20VKD60EtfpG0bbT1Ue3TE5T5e843Bl/7obEpcOzoIe663Qy91pTvIyQqY70HZHXwjLoUVRyI9BLHNwc0ynn4g/kSof3siCisGb6p5F2OuW/VePZdQEkz9M5mExGBenAW9f0/g2ecIyaAd2f6BaY5BB2cHgSzm7wtA4Ao/cEcJ31XUBHWvcXNnVZXpeyups+1L0BC4FpJYf0tejNjd7w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed122aeb-a683-4197-92d5-08df2ec01a64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:37:52.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVhR+W2qO44ctjjdMPMVIPdBwF+4k7D3gY88ew6EY0Q9mNmkOG1ATANhDm3wkpniPD9FmkxEgnDVyaLuh6f92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9928
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX1Een9hP6zAEw
 12WWc3mL9v2JY47cWZMtEsRaxkB9/ElVrzgKomOCiv/zFfXRc7MsecOVNiJgifF25NLs92NLPcL
 E45o3uf2gzPPfzWs6Xca16LJdIm31GI=
X-Proofpoint-ORIG-GUID: u2_T9qrn21y7RRzWRgJaYwbhYNMP175Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX3KNTEF3ui9XG
 LEPDVVg6/cUyx+AOgJoc5ufdpQFwFvVvuujB/bLdtZTxrQDpsmI9znlY1x5y2HRON/y/0erKca4
 iwdEPWxVTWyzgEAqbbpqliSJWS7mJB5Skm31bbKKnNCUqON93QFrhf7laVynDH1aZ7nY6Daaisl
 hq9/xjB7rk859Zc0dwZJDymxr9zhzv9OJH5bNoKyB132qwafL+g/AcSNmgJM0tPuJh+shORhnSZ
 XeE5BgwfeUd/wktVfVF0OdSViAFVszF5LerTCqIWzlhKXl/0N/WGynDvhPjRbDyTwJw4HZeJgSZ
 /uQEFuOX0RmdEiwlS+d6EkdYGfKiVYeOOUeZoDw0qfGRGIdYwzdEW54keDnQ3OZFNcWMVLrnpR8
 be1qNNi9m378NPiNJxq0fAsjbUkNCqEQoPsNMHm+tpKitfvfXQEb9kfrRGW8xHeJqPtYgJ7dfIH
 NtZ5EhEpadn7EwiAKhA==
X-Authority-Analysis: v=2.4 cv=A8r5rKWG c=1 sm=1 tr=0 ts=6ad78ad2 cx=c_pps
 a=hCP4nzqXrcc9mCxPAALvyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8 a=aa-Pz-GE43kcOsPXFKgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: u2_T9qrn21y7RRzWRgJaYwbhYNMP175Q
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

On Wed, Oct 14, 2026 at 09:10:38PM +0000, Naman Gulati wrote:

> Extend the vfio-user protocol specification to allow servers to pass
> multiple file descriptors for different sparse memory areas within a
> single device region with capability
> VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS (0x8001), negotiated via the
> "sparse_mmap_fds" capability in VFIO_USER_VERSION.
> 
> VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS defines an array of sparse mmap
> areas where each area contains:
> - offset: Start of the area within the device region (BAR).
> - fd_offset: Start of the mapping within the backing file descriptor.
> - size: Size of the mappable area.
> - fd_index: Zero-based index into the array of file descriptors
>   received in the SCM_RIGHTS ancillary data of the
>   VFIO_USER_DEVICE_GET_REGION_INFO reply message.
> 
> Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

