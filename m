Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=GjFJ84bo;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=tpESOOuP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSvDk-0003dH-Mq; Mon, 16 Nov 2026 06:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xSvDi-0003cs-MF
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:49:58 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xSvDg-0005HJ-6A
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:49:58 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBMI3f2075954; Mon, 16 Nov 2026 03:49:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=aBLN2Py4wUmd1
 VDauqzY5ANZvogVzeG6T+HkOLm8VwM=; b=GjFJ84boU3msTSC0/HKC+A2SK/bl4
 f1s8febFgnufvAI1GXd73VUYzZivj0NibL1QPy/OwfkCrzS8aDB4vOvpvjLVcanh
 2kYE+sCk7lt8JXEqbmrwak1JWw+P3WVfSad0FgSXgZ0OEwSZywLegUDb2VGCeRXf
 pvmyLrPLYYUswbq++6cIysmDnKNl8Xh4STKIYK/eyCSgkMlSNZrdDP2f57zCxd8s
 Xtut41mvrrN99pEchcsD0/IiHiPaOplZTlNSeHycrEqlZDraz7SAleGcE9rvBvQ+
 tNvRv1FxSWOkmso0gJI/bzNB+aCQxAAgt2vH+NRz6y3oav9nW7Ej4nZTw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022133.outbound.protection.outlook.com [52.101.53.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hxme9ufqt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Nov 2026 03:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acOokU9DTMSI+tw8NPqeXY7qG4xy7pBkmzsmgXVNqSrcgbqrIDHE0Uaa6DJEYFYoGLEk3oDe+XQDUsjWD3YDt44VV4RjBn7239e0cixmCVkCQOjm82VvEJ+RSDS8bQw1L8Z525YKYO6XKhT7EnK/NTq30kSDJjojILQ46USWz40Rg4Rr1D/PEvamLvZ9KereJ+KJdivNThc6rzDrbJdqboTrRvue8DdjWkZ7j5CndcvLJCDDp0vkVUrW8LOrFMYPVcFejM5qxomlmPNdLtfOR/qqZwc8eZ5utH52qFw4pAeKVLUBlVLSJ5PrXNqcdy42QKtn8ZxULJd3DnKXbzX68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBLN2Py4wUmd1VDauqzY5ANZvogVzeG6T+HkOLm8VwM=;
 b=HXGy4lX/K0BhhRotr5HqNXFQDGzNVPJgt6HCPYKD/l5eHWz4iXAPTVL2h/0swcDUqmzwJo+yr+0WOMBkRLh5hg2KRCV1PCnj9xOx8PfVMNQ7z7xYqmwUOXEA2+9uWxD8tDw+w9Y4v6Dgde8vPwQ2y9Zyz3OeUAwxCVP9ru7ec28XBbzSJyrrYI3K70bGq4kHRp+upSS/YvoUy/PIGjN09qwBPS1gX8Wm6vg3mJ/fTvY0DdfSWWu5QbGd0AJacNYpP9urZFgm2g2mmS2AvbW+V0iFrG1kxedQndeAktOZAkXN6ox+nYCg9XoAHl/suGJTu04xNHvnps9YPTXOA29oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBLN2Py4wUmd1VDauqzY5ANZvogVzeG6T+HkOLm8VwM=;
 b=tpESOOuPL8kzUGfQUuMyXM3vhipgtqxFKBF3Hb/Kqf2Zy9n/S59cp1Qb112bnN438chaq6vQM6le0h1B43knqqy8+RRvqj3G6+Y9qN4q6NW+Ugmo7W0yqLnu9VvVpA7mGq3G/KnWv9nWen1R4/z5w8NOkFPecWgi/W5VvFAEXJNS+BxZHzUySx1nOEysDz43i9Fx5s0kBqprti99Ttg6LlB3N9E4Z78OTz81XNKHILX8Ob56/o18gNVFprZV9APSaE/YnTUPgBSpS0Yt68xgP197qWT9OywuU8meqyOyruutKOMv1ZXM4LiYurrgnFIPOkQQy8K3kKfuDgqQ3pnv+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9511.namprd02.prod.outlook.com (2603:10b6:208:401::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:49:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:49:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: john.levon@nutanix.com, thanos.makatos@nutanix.com, clg@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] vfio-user.rst: clarify handling of VFIO_USER_VERSION
 capabilities
Date: Mon, 16 Nov 2026 11:48:35 +0000
Message-ID: <20261116114947.3365480-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: a70dbff5-3808-446c-7f6f-08df43d7b8ad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|261009223027099003|3023799007|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: nOKF6hjUz7NP4Ch5t7og8DLIDrKvGe14lLUrS6tWD1IGkMTh13lbePUqc8TtaS9adEkfDB8Ppka2ArxZoSJsGoYu0b4Imu2Vgqa70C8pHlm1RHfgnHA7vK7TMiqFIuNhUdBWEGprv6D5m6YAKaDeorfH/mnPwfT23KFYz6MkfvXRE733pHTwkcRCtgU0UXeFeybAfdFMCk8VoxzgLXJiYB2jAMpP4Fp/Kpas7cHUhLfFcy7KSIz5net6iawGmIt8eeLb4lAEslaSmBE+7FJEpNQ4qZggL9KmnidhW2EXw/15yLFJ/NGohXfNSN3Sp0akil70lo71bebIjxtSW99by0ssuh+tAVnvTAriD2D5Dm2fuNCviAo9QguDHliedNevBt5nXx5QKFCftZ52TwBor7koTx3tdvrmAeRq3fRedkFD2RCRjJYHBEvyJg7Hed8H2U+2mjZ+ZcJp7mWOAFEmmVvhRjkHezLoDTfxP9ClYmyfDRmEOJjBLRjQrgxVyT/okuxN7DRxjEqWpZlya3yYKX6EsZ+aHAYO4XaM51qxlBUjICxpWIaOOrOis+k7bOYvnZ1tYjofrRrKgEF39j2pmySSPGumFMoaNT/FGrJwF0SVbYrSl+sLVqvAJV0u6tSwaaqx3wlc8BxmsnR+m3stFHuVlnvjHcFSqzcNAg5bdvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mUvPcocGJ+qo41gDKa+mheLlAi//kI8hN6fe4CGTitW9BBCHavWnDSze4tu?=
 =?us-ascii?Q?ysBgP5pZhmBqKuFp7ydoY/QcE6eHtJer0ad9S9wB5oaGRJf032NNH08PZqap?=
 =?us-ascii?Q?cD0QSJq+eFZwoVEHtA/EoidR0Fo3/xnYPjOoXuku0rFNAAWTjTsiiVeQYlo+?=
 =?us-ascii?Q?5F3C5K+mUVJc+MqeFheD5wLOemTWm0kM6rC4XvkSqcJYyZFXoomw3BL8KhmQ?=
 =?us-ascii?Q?+PeBqljqAxr9Rm+M5jGO8fyrUn55b6gAEd9O5e19hMmG45BDYSeDOe9kebeL?=
 =?us-ascii?Q?QGH8Ql2RbFJIbHQRsScvx+KOhX1sfMGq+jWuIGp3O5fwmqFFQPDSswCmk2aT?=
 =?us-ascii?Q?btUrVxyuLIl4teJCsDOCtQMAR0XZaoqTlkywwLK7BDnnhRvaBIYzgVogR9Ik?=
 =?us-ascii?Q?+gHFo23eaitxIUItCZryT/Y0MvcuO2Vjoa6ZEscB53LtCUqPkdFRjdjpkVvB?=
 =?us-ascii?Q?gauUc6OWYF2RaLjDYPQ1Ic2R0U0Fz+OeUKAQjWBzKec99j3pwRuAeLa6SmuS?=
 =?us-ascii?Q?a1CXpQeLFqJt4kXyslZFukU9LKqFN5AmQ83NKH93jrdfQhzknKrNQd3Onxmn?=
 =?us-ascii?Q?1a5GvTBQRn3fOEeq4aiYoemW33VRclZikLnsbd289cwdHs9VwOICjiVI/WX+?=
 =?us-ascii?Q?kk4yiygggoptAQPiZXAfj9sIGqzgm8/P//JmsdQplO0uytqsdzwEQO9qOpAx?=
 =?us-ascii?Q?NaD5YpGCEjHqAceXwYuLcwRFD2DtkBxHikWSf0WPGNPdtxR7lkg9Nr1n0Lms?=
 =?us-ascii?Q?OSAkmAsVSj7qQkKuWd9tYcH73HOaWuSMkc+OQPg+gAbzVgHcOH8C0GurfI9O?=
 =?us-ascii?Q?aZYZv4U5cy001djSwGz5UoXS+ze+n+IKiHoHG/b/zSxjUntSEBMHyN++N2hk?=
 =?us-ascii?Q?RYva3NFeApw4Lj6SbWjpBRtBDnPA2bzfL7eDhmYmPWK4KmJyXQhFQyPwkCMl?=
 =?us-ascii?Q?VarakUOwETEU0+HYN3EYqAljudNAw/fLk9nqbfp+EmN21fvpeihQsLSHvIoj?=
 =?us-ascii?Q?9jX1h4GbQNflQ6K4S1OPaFgk5jhVMK/a+feb8kEePgAl3ZiVzyUHSQArU6aZ?=
 =?us-ascii?Q?Up31XdqICBBIA2w22tb1NerunqID2Zm9JR2fOhpjxvJEJaHinsZy6GjqBJt/?=
 =?us-ascii?Q?XDren+F74kt2WKndqwOhtV2/K+Qni7rJeK3LDhGbx//6I08cQ8hpNt6YZlI0?=
 =?us-ascii?Q?kSACnWaSrakTuJhXdMHLP3KmSfvHvmcoFLt4O4mz6bWrbba3aUwagKCfGEyM?=
 =?us-ascii?Q?mckzKucMxraaAN+I2McFLFmziusm4cU+lpHtitjq7UW/M4wl9holcLlhCrPY?=
 =?us-ascii?Q?X3xaZWxXOYDi2m4NGZzd2DHZAxv9rLNA/lD3+iuBhbULXLim5V3u+HUGCQ14?=
 =?us-ascii?Q?exrt62fyZkRlphmVfYJcXYl2y2rghIMPgUAK9G+V2C8oDpF7qqEsJ66t4guQ?=
 =?us-ascii?Q?iV57G82TGf50H+B2gpzzujykIo1qNFjmFStIX2q/J90Y84ACqB2B8c0di+b8?=
 =?us-ascii?Q?Bh7Z9yBIcUklMjABWlI2AqNVK6/rokL7jrWq5jY1ORKme6J4V9TgXTuTOwoU?=
 =?us-ascii?Q?ojJCDwq+tsHB9Km71ExGjX1IZY7pggRvpkDw0rIeXHQ83jPyTELlf0b+6BhU?=
 =?us-ascii?Q?OeZpzUeFSUAdt+n2bCo0hhZHO7gfnCXbU0aBnkvThrsQnYvjhPOQwryBUsS8?=
 =?us-ascii?Q?27JIdPrLp59DF7x918aLTsqVy3UCRPT6Auc8HmukbovhwI7xEMS8bvgYD8yj?=
 =?us-ascii?Q?olAbJidPL8CQMazSZdCY3GNFdKPQ5mg=3D?=
X-Exchange-RoutingPolicyChecked: oDU4xRf1hXxPCtpdWbixJx20J1kFR5gQqUT8WD9WxtadX8cBjgXeiGbx4WGyyiY0K9w80MAW9PJuggjbP1yNENXKzHp6yT2s2dXa+9Lb1Z6nedgWEE+Z5I09cKDqNUrHOAQI9GZPQ1pgFImorsRsACoWA/c2rEMwECUnUddNBqqIblvV5GjCwNIHIgBnmRbY1i9WnUCamF5w1+hlTvcBQ9BErV+GRPP7r87CKdfDX92yzE8Nq9Cpigan6zB7RlrEjwv069U6sN1Ur+DaHtWh41SzP1L3hf87PtjusVJDg3ORqAsvnCFGRJTMm3y7W1W9HB9nYG2w/ai+CgAp+FxyIQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70dbff5-3808-446c-7f6f-08df43d7b8ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:49:50.7493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDDXDS9rLyR1QHAlWokiGYirD9DF8DQT7C4FsYM6lNA/9sDCOl7PO8E+AtCYinAPoeIblO6lCyxo6JELjBfSuaO3LGC0JCrRTDYa8NAeJME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9511
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX/6s5PH71xffQ
 jVycSn4zgiXdE+OfHnV8GSlUHOMtsOFgASiNGFJijQtvoyMY13M4XN5dr1R2quUzjKxKUeg33td
 iuVjzs/E3BLJ2WqYyBT1Kyg/rm2Qxd5pMM043Rr8KNEvgNRM/+xF42cJyNuotLR71erdebS0oDW
 IzZpmCcVc/3+o1TuaUC368VD3aq1FDyJilFUtOskofWBMTaH48KKzOiGal8bhDJ2Xg1qhWf4ck9
 GQNJ12873J2i0+graiKxYkejcvnFiUxYLfQmIy+mJyQjUCebjMhUYJ/UurnTPboUHe6zFG+bOSq
 zNAOo0+orKMUOVIPn+EQV9KFwIiA0lH0XIvwGeQKcD2kzKMTiNHDYUcWQcqg9A5GbV+3urHEqHx
 YtUhBt+PA5AUFmaZGNKWHa6qxZMv5u3/ge08av0igDpXQ2q+2f1f5ra8keNNI36icQtc25vyimi
 d/ITc7ZR749awBYpHwg==
X-Proofpoint-GUID: KsL1FD3d4Q-SRuUNMIc0A_DjKHKESv9a
X-Authority-Analysis: v=2.4 cv=AOqr1qRJ c=1 sm=1 tr=0 ts=6afaede0 cx=c_pps
 a=nXg1BFrUXdgPQNEnN+3bHQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=JJ8y8awzfqrB_WgJ7LIA:9
X-Proofpoint-ORIG-GUID: KsL1FD3d4Q-SRuUNMIc0A_DjKHKESv9a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfXwh9Q1FIa0QQG
 WZXXz0YjbEWUWx6sAMiUK0ROaWPIbSl9+HDbx8xi25Q09848vQWbjf7Jh2LON7HfUk4huhhZ/3j
 8Qr+/cjZBBfgv+S1wBDFvLh1WHEAAt8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vfio-user protocol specification currently lists each individual capability
as being optional and provides an indication of the default value within the
description text.

Clarify that all VFIO_USER_VERSION capabilities are optional (including if no
capabilities are provided in "version data") and move the default values to
their own separate column within the capabilities table to make them more
visible.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 docs/interop/vfio-user.rst | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index b49781a755..4a5cfbb704 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -515,37 +515,36 @@ format:
 
 Capabilities:
 
-+--------------------+---------+-----------------------------------------------+
-| Name               | Type    | Description                                   |
-+====================+=========+===============================================+
-| max_msg_fds        | number  | Maximum number of file descriptors that can   |
-|                    |         | be received by the sender in one message.     |
-|                    |         | Optional. If not specified then the receiver  |
-|                    |         | must assume a value of ``1``.                 |
-+--------------------+---------+-----------------------------------------------+
-| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages; |
-|                    |         | see `Read and Write Operations`_. Optional,   |
-|                    |         | with a default value of 1048576 bytes.        |
-+--------------------+---------+-----------------------------------------------+
-| max_dma_maps       | number  | Maximum number DMA map windows that can be    |
-|                    |         | valid simultaneously.  Optional, with a       |
-|                    |         | value of 65535 (64k-1).                       |
-+--------------------+---------+-----------------------------------------------+
-| pgsizes            | number  | Page sizes supported in DMA map operations    |
-|                    |         | or'ed together. Optional, with a default      |
-|                    |         | value of supporting only 4k pages.            |
-+--------------------+---------+-----------------------------------------------+
-| twin_socket        | object  | Parameters for twin-socket mode, which        |
-|                    |         | handles server-to-client commands and their   |
-|                    |         | replies on a separate socket. Optional.       |
-+--------------------+---------+-----------------------------------------------+
-| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
-|                    |         | are supported if the value is ``true``.       |
-+--------------------+---------+-----------------------------------------------+
-| sparse_mmap_fds    | boolean | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
-|                    |         | capability is supported if the value is       |
-|                    |         | ``true``.                                     |
-+--------------------+---------+-----------------------------------------------+
+All capabilties are optional. If a capability is not included in the request
+sent by the client, the server should assume the default values specified in
+the table below:
+
++--------------------+---------+--------------------------+-----------------------------------------------+
+| Name               | Type    | Default (if unspecified) | Description                                   |
++====================+=========+==========================+===============================================+
+| max_msg_fds        | number  | ``1``                    | Maximum number of file descriptors that can   |
+|                    |         |                          | be received by the sender in one message.     |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| max_data_xfer_size | number  | ``1048576``              | Maximum ``count`` in bytes for data transfer  |
+|                    |         |                          | messages; see `Read and Write Operations`_.   |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| max_dma_maps       | number  | ``65535`` (64k-1)        | Maximum number DMA map windows that can be    |
+|                    |         |                          | valid simultaneously.                         |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| pgsizes            | number  | ``4096`` (4k pages only) | Page sizes supported in DMA map operations    |
+|                    |         |                          | or'ed together.                               |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| twin_socket        | object  | (empty)                  | Parameters for twin-socket mode, which        |
+|                    |         |                          | handles server-to-client commands and their   |
+|                    |         |                          | replies on a separate socket.                 |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| write_multiple     | boolean | ``false``                | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
+|                    |         |                          | are supported if the value is ``true``.       |
++--------------------+---------+--------------------------+-----------------------------------------------+
+| sparse_mmap_fds    | boolean | ``false``                | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
+|                    |         |                          | capability is supported if the value is       |
+|                    |         |                          | ``true``.                                     |
++--------------------+---------+--------------------------+-----------------------------------------------+
 
 The ``twin_socket`` capability object holds these name/value pairs:
 
-- 
2.43.0


