Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02146606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=YDwNGQQN;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=UBzxMgjf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlI-0000WI-O1; Fri, 23 Oct 2026 11:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl3-0000GG-Vc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl0-0002fG-Ay
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:37 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE7ZQw004443
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6YbbPuH8tnBNoAHRmFtgAy59cyNzfJccEauqIrQ+P
 fk=; b=YDwNGQQNRA6im3njEqfB1sje2icyzbufN2SM7lpaxDwQgn5ivb/+pdcQK
 UQzrGQD+0YQsgqSTK1qwJSrMx5N0dYcCewzQ4EwXhmaj2/OcTIagNxIHUbK5EaAF
 sNGrLED4SsabGHuhZrdYkUh7Cjeps+Dg8MUkpez7IjUNO774MnrLVpr+GrZmF74C
 8OXB/BhrOtwHvcLAEW52dgxaNKOO/LT4vqokDlnFpbzNUWhNbIpYY8SEwUpePsOa
 jNBkaDNgZRe9BLmUVrIBqHYLRkVRhCeLJYEWk5oXhXEdid3QkPxIyjd4MF2clhUs
 OcfrtxhtpfqBg8Os6iVrgBNiAo5/w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022083.outbound.protection.outlook.com
 [40.93.195.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hg6c30gpx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VijmJPLLTkVLBoh6hkI6tWABht6kE/cqP07FBUP+d+r3kOH6PlJc6NQ11kTl0PJb2NqIsJI37psFCmREXhu0qbW+SSq7E2OmoZG77nf2y3xUQI7/n5VOpxG5uvQGDuybj67W2R9DSjUALOiDNGWfdW4JkyguBxXP3ThknIYmwbsaRJAOTu38VqziZ188jZLkco9ux65SLUc511NyIoSGIwS8cJqejQZk42Xql9s3TNj2BUs+t4gbDGEDG0zn9+ZsMST6dzdFAJI7D3js0yayc9K5MeyWDKlBt2j6PHV2ZLx1CYv/73wr1H2jIW2dZOTP7280S2FQVBa/6AGSEl8a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YbbPuH8tnBNoAHRmFtgAy59cyNzfJccEauqIrQ+Pfk=;
 b=Ic6sawXnuI5cp1HDzqqlPnDLPuFkmMzN/c7IMKRtp4C58cae5V1Myw+/bypGXGfqLCt0s7ZCVsd+ngUw8mQeXp2ufei4MDual1AKs059eL1ysY9SF1w2wgCanpOLG+B8lne/r9Wmy795pqlu0xfL0X5DRyx3CCTRQWhF6l72mz9Lm6xBEnuprHa2ffuhp3JUuqOJ3xYgKfOu5Z2rd3LcXekuysgIocGF9vyg1d9nTmFRyqWtB57QU0s7klYef/Z9hIDUk9rWt/b5R/vHzW98MoDXjgzpox6Au/e0vbeHgYVJL0zU62KP2korTrF+5J9NJGqfLAPe5rglNDcDhmUO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YbbPuH8tnBNoAHRmFtgAy59cyNzfJccEauqIrQ+Pfk=;
 b=UBzxMgjfORMfaUtv4+B7LKfnVRu0wyZwvW5gKBTkX3qhq1mDg//wvaB2OpevB4bqR6pvC+NdlZI06yM9zDubc2DO5oI4Yzuers8IidAH2poU8gQOO1ii94HXyJeoYli5c8yAKV1vtndhsVlpi2WszVkNWcZSXqwHDN60/iztK3ZsRs/9VEr2MHKBkzyI7sJdPcEgIPSeoCxNWJE2W2COw9jm+QZWxq8Zix6CD2ulN5ymaCm911JMiP34ZzpBZejXmiQ1RgfbPOKg0ayLydguS7z8CER0S7rGe2DAoP8jsqeVKa8SIJkyZDANjDXGtcer0vYCsDaqC6MXZ0sZtNClVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS3PR02MB11571.namprd02.prod.outlook.com (2603:10b6:8:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 15:00:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/28] i8259_common.c: remove static irq_count and irq_level
 variables
Date: Fri, 23 Oct 2026 15:58:33 +0100
Message-ID: <20261023145839.34909-28-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS3PR02MB11571:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc7f230-cc09-4642-cd41-08df311661e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wi0x6A+OHCZIdJ9tjkVGBPjIBvXUJHNeAA3wUg9uazr3FZjmPhdM0ka75OsA39QY4/gJvmJLYA4PhwCI0YhjeAtxRunfG5UPBTBZ5Odw9FXgZHR1lSko8InRGTnFMtu+xX0khwqHaXqTa+v6bQ2MryqqoREtxKjiLlSJJ5oLLOnMh2n7Vma5ZQ1WakHp8IfElQk3EKqA6zRLzdQKTnotgcQU/xr3pbYNyWYW6WT6gxejJHm752sdWdOaZdba5NiQsBMWh+C7U/uXZkS6mw3arfsvOxYcowW7qiWlYQgg+dcIj520YyLvVqMhcLzSdUFrCucJs83eW++wmPXKDf+HVRRaeP9/3NXORUUK++Bpzsl7p01OAcKxfaZMZ6yuOC8yeABz5YExr2czzWa/pszZUcDBWu0L+D65JiDa7GPgqpBCHMtrJPMzvb0j2E82YArUPLmHmlId4s/9DybT+XoMkr3qvUrvJWI4Hy4oF3Zn9LV848mYFqVi30YAV0eTOUctBU9RTANBK/c32MnlG4FOMJcFmUMZCXoZ+GITz+7C/4hgA2Dpo0IsYwWtg2XC8FE08hcSE+jr/azLi6Af8Tptp7SJAem4ARGotOSHvV3EuakESApP5s4APXPmzpbqK4AA1HNtyism5djkPyjLeK9QQk2G6O39pf1k3KxiaGk6MuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ntt3AHXIiIcWyJbEd462dbvQpJQketme4lfOAWNjleduJkyOssnI4hhyhkgC?=
 =?us-ascii?Q?cU0UfhynfjNZqyyrmK6kt4m2N1G1+SST9xwCLokGpKQ4DmggelicJGMbYLcI?=
 =?us-ascii?Q?11Kih5zgCfHNqBhPZCKWGwk6tCH1KXdPhyEsyr7Qj3exZvZ6QHqFJhzX+NF5?=
 =?us-ascii?Q?0rb/+ZC1KUkPEqW3mJ3DkkXKQAeYXSEDAfE8FwwNKwl78A4fC3T9SbbF6sr0?=
 =?us-ascii?Q?d0H1kUzbL6OvVxa9hGtGUxJ26gisJjJXAcnMz99nUpyM9ycLJ35WZiQShiUC?=
 =?us-ascii?Q?oBu2SRLoeS0VGFP6sJOJrKhbcJu5JhCDz2QwWqgA9D6HC239GzI4H6W0V67M?=
 =?us-ascii?Q?T/ofORexP/vummK91H/1q0dMcN3TmhFoQFsd+/PzB7HfsNCYYyvUthfCvqaJ?=
 =?us-ascii?Q?OFp5U0cbUOwqw1M6plzjw10RB735jaVuXM4iv6NKVniLE4SlV/uDtQUKv18L?=
 =?us-ascii?Q?6bJXmJY9Vldj7unhuX8EynqcSFHyPnFMqNF1Xr9b9oEYmoWkMkkkmJQ3Fcmh?=
 =?us-ascii?Q?uYUmNmkKcwrRMyUJXDff+DpsvS0qbYHi/tyRuCulyGXUnAp5BAxFkGpRkOUH?=
 =?us-ascii?Q?BzYRtC1/i71FY9yGleY2+5190uOQCJaBV1tq91in8WQ46W3EGwlPrDVT1ufv?=
 =?us-ascii?Q?bThkoJ8o5G1ZLW6kHVnEelMdL1f0KzFCfxnoPRPuZ2U5TQluS0+XFMYYw2Ta?=
 =?us-ascii?Q?PT/lw8yLTFYKOSdsASYqLSvA3BnZjuXOBSPWWdQ4FFHAy+Uf43Eg9F6fqmUN?=
 =?us-ascii?Q?Wl4ZcbgZ4BLvUNjRPTYHerfW55J6XQq3+lUpBvn8jMpy0VhU8q/7eEQj+4no?=
 =?us-ascii?Q?kBa0w5y95vNzKnQ/ORH4GekNrUcZ4Al/UjE23H2tdSLN2PJ6WDRUdxmNRFve?=
 =?us-ascii?Q?UXehQTr+EodmKGpcmmxUbDTF2uoC+7rO3/uRsZSo6onvFt3HOwQ+dD0sFKWc?=
 =?us-ascii?Q?lBCzk78GGBacBAQ6+mZW9jOTaVWWllaFulpUt6/FyQ46edLF4IRqK4fj2dNr?=
 =?us-ascii?Q?hiovYFy26FJyKA29YqaONSWFgNOTj7+ImcZ/9/k9eJtycEom9KYLxXg7mHxu?=
 =?us-ascii?Q?Pt9wD+RP7WKqjaNW8VFdeAcBwbPphHel4UvDgdx6UJFLpLNrLjH9LV5SPq3j?=
 =?us-ascii?Q?gEwTovrI32bMQvq59+cOMd7jolmaPjBNujy3H7YluRYU2dINrjkDYaQq28X1?=
 =?us-ascii?Q?IattM9iWHl1g5npQQ3W/qH9Y2ZRjBf/bah6Hs/sdQ0GedQD5pyXtITbHw1Yn?=
 =?us-ascii?Q?8FLi7SDG5t/rQXM9Yj4q+UOg33325GXx9SIWcR+Zn1nTM3vVOCF13mEr2GML?=
 =?us-ascii?Q?PVb0OlVZS0IALQQH9Ii4+zxvZDYRjFk7heGT/tG3/mVC4Fczwyy6QXQqvwcr?=
 =?us-ascii?Q?pD5r5sLZfFEXAUaoCL0KFvWrkvIGsBM7G3rhkYONqw64Csmo7wDZHuqfWYbH?=
 =?us-ascii?Q?u4Z9h/buuNr91r4w/bPsuuz3RGxQekcYWW2x68DHqtpof2Ypu5MrjzwjeQGm?=
 =?us-ascii?Q?sOai2FIlDlg7eipKQnubLAUTIU2lsfKovDMsV8Qyw9ycYHGYCA6PhrYzI/MG?=
 =?us-ascii?Q?Kmv/a/fVOmKqV4yFdjZ/dJZ+8rYbrBQUrCS5dpruqDHvr0HGHnVCoyMaug0A?=
 =?us-ascii?Q?u7AQy0SYuPJvQQ3dlYMHJrsTTvtP/2v5RePEL6SInQmroTzUpXYQXxgjzx+0?=
 =?us-ascii?Q?y17W5OCE3MUEyvYXKMb5aOWCcRq/vS4sgf6V+HqZsAyR5m+EzS3cnSzbjJuk?=
 =?us-ascii?Q?fupL/rObqZRNEzVsRkNxRll29t22K5A=3D?=
X-Exchange-RoutingPolicyChecked: fhxFrtNRaJxndzIfRik9zspSnrcAvlt/zE+FAy/FJtcUasMIzezigtlTh04VWSA7aodH9xVM26QnvrdjNc4wMZiixN/gIP+NGsCZGieP1qOOrKKxs4euFg9/ViWvRZeqy9NH++NeQwIbTfh31qJlTnH+UgwBTPaEjzjzCXqKScAeReZZXBQ55x6t1EzZgcU7v8cYi7ptwQ4YFym/pd6Se6BjXO3WLdHoKBy9u42Atcsn+1aSPmLn9L25diD88/o3j0uzk9W0KMKVMB+zm1bPCLGYLiwEocJmX6+yhLZT6JMYbw/4KcALsNqpVjgx//BVWQNrG8J1wZfbpFPHsz9Rcg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc7f230-cc09-4642-cd41-08df311661e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:31.5156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8gx71/2iRyg+ghICh5eaCfsvEVC/XYj5336/jmSHDXytx79HAHA65KNd3LwkatknUzW9ANjWCAacIZetFVvzTPD2c0wi+Qrw7OdMitDzz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR02MB11571
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXzU2PBKRWofzR
 C0lSTGh0/uxIRW+5xUSyZaYZ37dxwYzgfcMWjpIJHOSPGWkqCInnj+s3ET7ZbdBerd9OBI/Hwym
 oal6B7zQcUtNtcJ77jsXwAfRo4rCDCw=
X-Proofpoint-GUID: M8O0DZJe4B2Rqe0WSiI9QPm_r791e0qu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXwLtfZF/Drsr5
 qMdYcVqPjnr2q6WSl/oQkD2HbJ1Lycm3lWRoaKhrySG1Qm2PpndFGgy+E/GQb9BDXJM05Y5wa01
 F05hmVSQcL93haLuRDTM5J1tm556jAb5YsZF6Z4dLtI4o7j6jEfqVKDShs47C6H6TQ9QQ9JGqy8
 zHsL7/EiTEw4mcXbB2wchUfblRA3zZ4TMMqNEwNMf/KNPrytd/QyCV1y0k79SRC1v+kH11/0ObT
 xw073NFWViAno0wseQAnS4Y3tdPOiZtEXqbq31x3HweL6Q19ucdNEMd0ir60GRuLKTsGrc3Gv/G
 fGyisQl8v5f9z3h6Dq4wRtxEgjU9dKKyl813VUhCecJwU01prKdgqL0/U+UYWGdIGiK93epWimR
 2068W3TRZxJSwzQdC50Ecd1cm4pUKl2VW2bYCKyMAt9BPebtslluXjz4n0GAy6yaLTxmeB2RX+Y
 um8t3ua0R66myV2C6KQ==
X-Proofpoint-ORIG-GUID: M8O0DZJe4B2Rqe0WSiI9QPm_r791e0qu
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6adb7690 cx=c_pps
 a=qXrkyhrtrlo5bn8cMY6OCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m9Rx451XjQ6kX_1OFlEA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
to the irq_count and irq_level arrays, and then move the arrays into the
corresponding i8259 PIC and KVM PIC devices.

Doing this allows the statistics capture logic in i8259_set_irq() that handles
incoming cascading interrupts to be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-28-mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  3 ---
 include/hw/isa/i8259_internal.h |  3 ++-
 hw/i386/kvm/i8259.c             | 20 +++++++++++++++--
 hw/intc/i8259.c                 | 40 ++++++++++++++++++++++-----------
 hw/intc/i8259_common.c          | 21 +++++------------
 5 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 4922f88d5b..42d6f992ac 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -20,9 +20,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259PICState *s);
 int pic_read_irq(I8259PICState *s);
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs);
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 2807409eff..e0002843a1 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,6 +70,7 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-void i8259_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(uint64_t *irq_levels, int *irq_counts,
+                           int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 8cea5fb12b..bf5ae334b9 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -45,6 +45,9 @@ struct KVMI8259PICState {
 
     ISABus *isabus;
     KVMI8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
@@ -117,6 +120,18 @@ static void kvm_i8259_put(I8259CommonState *cs)
     }
 }
 
+static bool kvm_i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                         uint64_t **irq_counts,
+                                         unsigned int *nb_irqs)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void kvm_i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
@@ -129,9 +144,10 @@ static void kvm_i8259_reset(DeviceState *dev)
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
+    KVMI8259PICState *s = opaque;
     int delivered;
 
-    i8259_stat_update_irq(irq, level);
+    i8259_stat_update_irq(s->irq_count, s->irq_level, irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
@@ -227,7 +243,7 @@ static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
-    ic->get_statistics = i8259_pic_get_statistics;
+    ic->get_statistics = kvm_i8259_pic_get_statistics;
     ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index b59e26cbc6..79b5e603bc 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -64,14 +64,16 @@ struct I8259PICState {
     ISABus *isabus;
     IRQState i8259_primary_out_irq;
     I8259State i8259[2];
+
+    int irq_level[ISA_NUM_IRQS];
+    uint64_t irq_count[ISA_NUM_IRQS];
+#ifdef DEBUG_IRQ_LATENCY
+    int64_t irq_time[ISA_NUM_IRQS];
+#endif
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 
-
-#ifdef DEBUG_IRQ_LATENCY
-static int64_t irq_time[16];
-#endif
 I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
@@ -138,16 +140,8 @@ static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *cs = opaque;
     int mask = 1 << irq;
-    int irq_index = cs->master ? irq : irq + 8;
 
     trace_i8259_set_irq(cs->master, irq, level);
-    i8259_stat_update_irq(irq_index, level);
-
-#ifdef DEBUG_IRQ_LATENCY
-    if (level) {
-        irq_time[irq_index] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-#endif
 
     if (cs->ltim || (cs->elcr & mask)) {
         /* level triggered */
@@ -224,7 +218,7 @@ int pic_read_irq(I8259PICState *s)
     printf("IRQ%d latency=%0.3fus\n",
            irq,
            (double)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
-                    irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
+                    s->irq_time[irq]) * 1000000.0 / NANOSECONDS_PER_SECOND);
 #endif
 
     trace_pic_interrupt(irq, intno);
@@ -456,10 +450,30 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 }
 
 
+static bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                                     uint64_t **irq_counts,
+                                     unsigned int *nb_irqs)
+{
+    I8259PICState *s = I8259_PIC(obj);
+
+    *irq_counts = s->irq_count;
+    *nb_irqs = ARRAY_SIZE(s->irq_count);
+
+    return true;
+}
+
 static void i8259_pic_set_irq(void *opaque, int n, int level)
 {
     I8259PICState *s = opaque;
 
+    i8259_stat_update_irq(s->irq_count, s->irq_level, n, level);
+
+#ifdef DEBUG_IRQ_LATENCY
+    if (level) {
+        s->irq_time[n] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+#endif
+
     qemu_set_irq(s->pass_irqs[n], level);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 684290fb2d..3bafd81ea7 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -30,8 +30,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
-static int irq_level[16];
-static uint64_t irq_count[16];
 
 void i8259_common_reset(I8259CommonState *cs)
 {
@@ -89,26 +87,17 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-void i8259_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(uint64_t *irq_counts, int *irq_levels,
+                           int irq, int level)
 {
-    if (level != irq_level[irq]) {
-        irq_level[irq] = level;
+    if (level != irq_levels[irq]) {
+        irq_levels[irq] = level;
         if (level == 1) {
-            irq_count[irq]++;
+            irq_counts[irq]++;
         }
     }
 }
 
-bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
-                              uint64_t **irq_counts,
-                              unsigned int *nb_irqs)
-{
-    *irq_counts = irq_count;
-    *nb_irqs = ARRAY_SIZE(irq_count);
-
-    return true;
-}
-
 void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     /* No information for i8259-based PICs */
-- 
2.43.0


