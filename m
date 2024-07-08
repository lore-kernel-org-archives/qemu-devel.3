Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E849C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 04:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQfoN-0007TS-Hs; Mon, 08 Jul 2024 00:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1sQfkq-00071P-Ts
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:13:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1sQfko-0007kd-QB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:13:32 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467MWDwh003101;
 Mon, 8 Jul 2024 04:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=corp-2023-11-20; bh=eCIxiZFlz5G3to
 f9TTxs1vo9dbMez4vm2CNYEyp+tng=; b=jRe5sgCxBO9Flt8kz6R+FXX6FCgzRO
 4HGvcNPlVek6j6DSmk/hfCP6nGmhNC/sYhXWmfZgqBe4ILwWCz44kuo3J5dwnWZL
 Dblo6c6dY/adozEmZ6GclTJ5j71/dCwjsjB9sDF9ZMKiljok4RD480dNFaIrNszq
 bfT1VdYtLG86yZvCe4DPAyRsrUgwqxQ6z6EO7U7N5p6TBOU0C08fxlGl4mdCbyRJ
 cXPuYHVfs4NOCDKyKEel6sjrMqPFDaE2i7NdL8erkLSH3zK3IXNheEzKJTXLGRmR
 fV1zCQUhKsrrIAauoPSdyS6kkGe+9DNMkK0ErMOha41kCXKjOh/Jmycg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky1qvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 04:13:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4680UQTQ014388; Mon, 8 Jul 2024 04:13:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txevac8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 04:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRh+c0ifbVX1RBmB8/rn7iV70htN5bgceROb/fHEcr2arGqBQBXnKYoGxBjbkRYsC+dKbKolNDoPO07n0X4YAb1y8u29x2yoqxbuIjsyutTTWH05czOFzBP/+coIixjnCEHnWpSoZp5L1j1eF5kC5oT0AYzL5HDYYwORlA5rBuuwPRygTUmIG3obWebamcrR2SmPWLoFIQL+NyBxPfWu1yOGFDpgpcvKPcxVAtpyrOCGsDlEAX1dcyNb/t3qbPBKyZoro9veg2UuLSoliCwvHno3EcmaKOucasiB/aZZNLvhuqwEpZGrw22GJsGb0f2TpsrL7AdX8YX4YR2umoZANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCIxiZFlz5G3tof9TTxs1vo9dbMez4vm2CNYEyp+tng=;
 b=YJ4AZzc7qaDdCp9zzzIxteUx534vSjPcH/73yNujsq2fzakclwhK1WbUASSnX5Ob9KKt40NPBWHeOyQJ+LoiqxLhzrB91YNYFQEROztpsSXqb5gNq2jMKV+Q0SijuylByhrvaCCFZ0hxQaHBLJE2M1eUvKT6KxKj0ZDNjFFoFptikrieM5gX04BRZl/RzsbCsMAS+k7Lv+lSYhVSOvvFdC5rGYcYlWN0Ho/2A/NVYZtCrDYEiMRCtFpU8P7dCuM/SgUfQKK9CdqdG53MLnlhFsxWnOZhEu46zRkO+acG0WTjm0pIxCSBVwkTRUUt1Ck3Yd2OcKSegAjmLDk3PmMy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCIxiZFlz5G3tof9TTxs1vo9dbMez4vm2CNYEyp+tng=;
 b=cnwdGMxq+x4rcUwFGVBYocVzNdyEAR6txfYzf+3Ig2dhLbcvfepn3JsOJpP18mBaoMRp4fVJDsS3I1tnrTIpnJQM7WUDBr+pniBTzsnAvXqtguIl5plTZLp9/WEB5LXk5ACcyUSm4vc585ZJnqJGBRWy6WXBXchwoiJ7sDT+25I=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 04:13:21 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 04:13:20 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com,
 aswin.u.unnikrishnan@oracle.com, joe.jin@oracle.com
Subject: [PATCH 1/1] pci: don't skip function 0 occupancy verification for
 devfn auto assign
Date: Sun,  7 Jul 2024 21:10:56 -0700
Message-Id: <20240708041056.54504-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:74::16) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA0PR10MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a25cf3-474a-41a8-0073-08dc9f044d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQRtdsRRWZ7wgv39Y63yYbprobyeuvSeENXeAeAQGpnHmbjx1Zfep09tv+rG?=
 =?us-ascii?Q?sl2gMOaHUiJGlAX+cMSUlJnf50AcfP6fdGOlmjJ44B5k8ypWnOdB2gwUkhV7?=
 =?us-ascii?Q?tD6wxcWp0gArPyXGva/zmgzLYdeBsRhYga6RU0Y7IQhZtbpilPBzQhlkmKDV?=
 =?us-ascii?Q?svS3FyKA7N8rbqyXHVqyD5so/ffxCh/u4gYpd8axU/UFKsXNRmmPpykkejCC?=
 =?us-ascii?Q?YSGffFRAyt4hBhyUzjDsHva7ChyVP/fN2Yo5pt414WUdf3/Qp+R62XPuRZHd?=
 =?us-ascii?Q?ofEs7tU2xhYIldpnfgBAxXpm2QFRaReiv3Kw3LejjpArr2IkAZG7rWqRazz3?=
 =?us-ascii?Q?Zl3qtgw6hu0zWRtlR7Wj/MC2X0Fq1GS1gtiD0Hg3Yhygka33iySNvq4E6bXO?=
 =?us-ascii?Q?CD/XgtbGri+7apWABKyEVtVEwaOlGlVl+z/odlBjKfbPLjRRji8vc2zlLs5w?=
 =?us-ascii?Q?1E/6fSxn6qEyIdX/LdsJw7RuHojnmMpmX+Y4mQawRFJQ/kWUSm5RqoDfFS4+?=
 =?us-ascii?Q?P4qlqeCNSKA/fBFSM7QcNGR7VDXrc7HQpWbqh+7bKLiGhuXT95+lupcfkh/+?=
 =?us-ascii?Q?uunjontna0UWTyd8vTFhUaU0vAov8S4XanyleWLtMf7nuABr4Oe4IGqjDzEd?=
 =?us-ascii?Q?qmeeWEiDCYCFx5pBHnMuLajPaIBDVY9R1U1a0+VlR/JcvBFPaXR/fk+8wj+c?=
 =?us-ascii?Q?DlZfaXD1VLbE4pPU0/rqkGdliOsts24UBqK/h/yB5NHhFu+EnwRNej4l8OJ1?=
 =?us-ascii?Q?SqBslNs+BwqFBtK3bahYBRUOxO+FUynBU8KFrDGbvofae52tYyrcnCjSm+XJ?=
 =?us-ascii?Q?Tt6fSM/vO8floSKc7F00v9/pqZySWUTrp3nuas1E0UJ7tk8TBrPObGwWsL3k?=
 =?us-ascii?Q?VreCGPHncADygKnFB+O78LfwAPo+qPS01UHDMXBFk38/bsiYxqAmdB5Yuz69?=
 =?us-ascii?Q?Ntbgy04ZHjg72f1NC0piQbf//VlW5eeYRZx1t2Iejy4RikXalL8BW3tcUuPv?=
 =?us-ascii?Q?Z24q/687F5qxi750pqnxnYYHaIjHxCg1py965+yiJ8tz1YhbBSqkFwBJmk0f?=
 =?us-ascii?Q?cocEeobY2exWFFQSX+w9vR+H1a/YMcMQtPp3lpeJI2ia+1U6yo6GRRqlXEFs?=
 =?us-ascii?Q?J2FIz9XU/tKZkncRLerN2BAOScmsvOZRZ5SBM8O2+/fmdYPz8NmQQcvAE7qZ?=
 =?us-ascii?Q?VyQGw+m7oFgPg2zWnQVaoMWi4zy3CHJOPxd0XSif7PqmTZSbbEVbEcTeCjd+?=
 =?us-ascii?Q?KXLMTS62cbzjg57sPvZdrJqqEydmuiopJFb1a5yAVxM79n23iphctxGZvV06?=
 =?us-ascii?Q?BlFg8TOOSsC4Eww/B1HNOJLj97ub+UKmliRcp5yPmT0Ezg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR10MB6425.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ex7RyYFH/EpdeSAiHBmBz7rgsqwAhZgBFaqOfgLe7XcoetXVWtckfB88qxIu?=
 =?us-ascii?Q?iK75qrEUrcYQ2DbswFAsjZzHU6Cyy9n7UFS5Y7jrHosh8arLuMUThdO0Xu/m?=
 =?us-ascii?Q?LQwc78yf7xkIfFR5o15KnCrTjXbvqgmj7ZsvXPkOAdAs1EGwuwTX3TyzJL7b?=
 =?us-ascii?Q?qW7yDcuF6Cs7oR7Ry1e/mxqcHETDVyTE+lDgMftMe9Hei+X1Akm5uS2fWZV3?=
 =?us-ascii?Q?udPRSuH4658ez941/Ry+zc017LDU/Oz9PHQKz3bjy44+A29lCFqXo8XfpeZl?=
 =?us-ascii?Q?wucAX1F68W3vTDzHVHHYFE9g73H7n0s0Ys4gV469jsrJug0YFBuLxPEspPqf?=
 =?us-ascii?Q?CV9uhZTCwfOzFikBiEPCLqbsr2r31Fv/KX9cCrOdyQxazcsQNKU5dt2xyasZ?=
 =?us-ascii?Q?vHlzVzHnPrEn2JuSUpVe/M7/GPOmxY8mG4rd5CZ8lpxYjiFfG6/sI5FKkpQf?=
 =?us-ascii?Q?IeinQRyeppfhReqfnuY+Smct/RLFCaWj08i1LQAb4O0XVrnUMOa4HcXIPePr?=
 =?us-ascii?Q?fP2E773Aum7cFKJ6RL4fAyG4fX4KnToiqVVKvoPxfjrphKaBgiS5lsvkWc0v?=
 =?us-ascii?Q?9POdgWGK/lPXxTvD5prLxO1Vc//N8O+mK28zqwbMdY/VXxryykvnKLIcXeGn?=
 =?us-ascii?Q?n1styPSAJYeJatmziMY616l2F2oTbGLiH3ejB4vmMRTKXvnzgkaCMtj2NBML?=
 =?us-ascii?Q?d2nZ95KPm9jKWWAxvJZFm1iOYQTJmiz+6zRVRAQNDM3XLo7Hu71h8rEOh41w?=
 =?us-ascii?Q?ztvZjA9TvDtmQGe5tjPFCj6dKa1ClIli9e2S7IXFoy4HFYkwEUUyMW+lV/IC?=
 =?us-ascii?Q?TFETikuOvsU5hDomvfOsdK4clqIO7qu4EECdzvmI/bMqEQm97FOa/FvLg2p8?=
 =?us-ascii?Q?yWBqZlMPr3s2ExxcMnoBF1IhuMq05AWIk0ElS7wmub2Jxnb3afUFNDbn/e1g?=
 =?us-ascii?Q?3YLJUDjKteeprbf4AcWTItnHrzyMEfS5HCJMlV1OGJCcetJZ4U5PCDPeXX22?=
 =?us-ascii?Q?cMvnW3cyXW30k6zhN6ZPoyp6L3hEbcCSdUiUCqoai/IY+nNjk6qVvtgbafZM?=
 =?us-ascii?Q?62Z3AbBWQyufDQML0685WGEoxVUPEDm/hEO1yVhGdYJT8PjRfzml+V7EsZt+?=
 =?us-ascii?Q?iA6J7pygAUhbyFzHWTF5oyLSpuSWkScu+uQVJnUyhddsqN1Wu275W8lWs9dp?=
 =?us-ascii?Q?xxaOSHTLft2+sdyLqRW7J9NrgYRBLXRyM+Yczjs0lp11N6PSEudYMnVcuAAR?=
 =?us-ascii?Q?eZ8jr4Z0+rr/Y+KbckdSW4Vq6klpemiQSt0UbfH/dDIrsPFu61WGQPpcwWVp?=
 =?us-ascii?Q?zJJES6+AVcB+v1FlKoPxJUrH3TW//twKvOavo2i7DPmm/SBI1hEcqjEK6myc?=
 =?us-ascii?Q?tg5dUvAKbA26leEH9+5vu2OmGIw7T/do+Pdwp7jQIlXMIGBYcGZ0+4OEaroI?=
 =?us-ascii?Q?6C4CJW0NDWn8hnVUERR07Ak5B1AnxrBaXdFo744G/TOxIr/etHtndbnopY/t?=
 =?us-ascii?Q?2d+2cwKjYMzU/76kMBvo/6NJQmv/wKN32wBhU2Lf73+J+NPk0r3NXwJKIr6V?=
 =?us-ascii?Q?wgd97nYyWhM0ZnWo69LPJZ5MnDR0w2XqOCZKPld+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /atEGzMmmzWUBt1jl6hfDB9v57Wk8Lzfcc3Ze2s+/CAYXz0vvzHSKH1Ohe8dkyT8YvDCrtYC5R82WlvHS6hZo2Q0BgvacDLAbi1GW1tKBjuqthAihOgwfoSo0GYlFeikbpJrv5Mywos9EX7TT0NZP5HjuBf+/KNTxkuw1Tpvke16Zw/LBsmZxqIUMGJuTaPgeUD2bREdyxAmrkpoN1BOe0RayBFjeRW53Z0ERX9tnuwm3/3BJXOD9LEVC5dafDJJsyeuTOq+I7SsC3zEzuzqbvM8sPDqTB+rF1xmVwCVCuGgkJfX3eaWywBhO2Pc0QCL6+X6IPqLFhopeKwyd2I/mpYp642dOg2NjrlN1KXjYwWtYrea/SR6LypPMtnxUQZW1eu5myKk7zNsuB6CqvLCZ9wjLHQzhBDlB/9/u48VOAhKWxX00OnzZUWa7rSvPyQx6XYEYBXxlaGgkuX8KRqZtQD5btBG5TQMs5cBJnHl538/DlNcis/aVw9kQX/HzKp6SCOhXaJDw9YS2fjg9MJKWvPv8dFsfNmDKIqmk2HHSXCvQqYbuTbEHYfPv02urgvgh0thL/0aItSYvrOex0SLv283LjkoMeyP1hISVMJm1P0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a25cf3-474a-41a8-0073-08dc9f044d46
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 04:13:20.6394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86uxy+7v/P8jhaUWyGbenmqctYRdg9Gg4mUbuQQ8jWxc+/cPJZeX8WkheP4IHCxq40wbOQMq7E1USUO/SSSnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080031
X-Proofpoint-ORIG-GUID: 1chrjT7v18soiQH1gqS_1Au8ui6A4-Ay
X-Proofpoint-GUID: 1chrjT7v18soiQH1gqS_1Au8ui6A4-Ay
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the devfn is already assigned in the command line, the
do_pci_register_device() may verify if the function 0 is already occupied.

However, when devfn < 0, the verification is skipped because it is part of
the last "else if".

For instance, suppose there is already a device at addr=00.00 of a port.

-device pcie-root-port,bus=pcie.0,chassis=115,id=port01,addr=0e.00 \
-device virtio-net-pci,bus=port01,id=vnet01,addr=00.00 \

When 'addr' is specified for the 2nd device, the hotplug is denied.

(qemu) device_add virtio-net-pci,bus=port01,id=vnet02,addr=01.00
Error: PCI: slot 0 function 0 already occupied by virtio-net-pci, new func virtio-net-pci cannot be exposed to guest.

When 'addr' is automatically assigned, the hotplug is not denied. This is
because the verification is skipped.

(qemu) device_add virtio-net-pci,bus=port01,id=vnet02
warning: PCI: slot 1 is not valid for virtio-net-pci, parent device only allows plugging into slot 0.

Fix the issue by moving the verification into an independent 'if'
statement.

Fixes: 3f1e1478db2d ("enable multi-function hot-add")
Reported-by: Aswin Unnikrishnan <aswin.u.unnikrishnan@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/pci/pci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..82ebd243d0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1186,14 +1186,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } /*
-       * Populating function 0 triggers a scan from the guest that
-       * exposes other non-zero functions. Hence we need to ensure that
-       * function 0 wasn't added yet.
-       */
-    else if (dev->hotplugged &&
-             !pci_is_vf(pci_dev) &&
-             pci_get_function_0(pci_dev)) {
+    }
+
+    /*
+     * Populating function 0 triggers a scan from the guest that
+     * exposes other non-zero functions. Hence we need to ensure that
+     * function 0 wasn't added yet.
+     */
+    if (dev->hotplugged && !pci_is_vf(pci_dev) &&
+        pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
2.34.1


