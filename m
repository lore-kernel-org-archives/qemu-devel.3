Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE3E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSUD-00087a-1Q; Sat, 14 Dec 2024 08:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTQ-0007hj-Vg; Sat, 14 Dec 2024 08:46:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTP-0002mq-11; Sat, 14 Dec 2024 08:46:24 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE5mOYh019978;
 Sat, 14 Dec 2024 13:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=; b=
 j23i0IeGK1ElwzWidUwFKp9gC7l/3HsKfE5mgRsLxRgFzBP5tVsm7LLOB43aXHLd
 88t7UXl4TSSdSKa7rHTcWLUd7p7I6SGr2AVH4rrApfX/9DZLgCpu05EDo7SczwxT
 94nzzbQ3l0DRnLEXmmKL8QpTcNfJFCR9qHG/MRlgYL5Dc63+OqP2ZYyDwbthDvTg
 TR41ZU7ZYTE01CCrtlo1zY47vXfXfyNSK2DjPotDBU2t1AFqx5y9WnonYS/7Rh5X
 H3AJ1s8Bz6OCHzqR9dvolnA6Pa0NQsQ9uZbr043aDC/75a3V5M35X4fDLDqzB61R
 IONhMLKzzLgAB8NKlYioUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xarfk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BEAHq7H032785; Sat, 14 Dec 2024 13:46:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fbu0px-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOnpJBUUhsm5VL+vd8oK0uGK5yQpAXZhDLl+wwPlKpspesi/N8Q6quyXPPK/2FZLWEq5KnPrg8gZ4yxC/ggkrvZbyZ05UdJPDky2Dc4MbqhYyUMgh0vtT5llpKh0J9xbcZPbA2o+lZ/7faJPwkaladRaoFFjXH0nDx9YHi0sTA5Y8DnGd/OXH4/0pa8+e6NoigantmpS6Dzn1zt/kKY7XFKEDNVOND7EaRRj0OXIpFRyQw69u+YJrwcCOs9jSKiIqnLrdeE7PAR9od5CyJFxknub5mOfsW6s4zJ/GVgqSpeh/AuKIykHjBtKTtV8XT9uhhKhK1OQ+DSPQ2saWnT0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=;
 b=fxinawElQFQdJ0HdEhtQMh3llGLzh5gaNMNwpNjd7/4a0OO2lbRnCJoaUYf2fKE8AInyCH/vPMZzJOgrtPQB5IZmMKhdgmD5AxaPp3585cPfoz1CK8iZTXnIp5Fvki6sQJCqYrl8qJ672DaqHqxncR+V3J5HAIt56S2wC5Cz4GA+0zIrVHvcHWviC2eX6UUbhFLc1LJrsqhuJvmkbU+mEV+/pVOnIm3XWbsjOUbjz408yPye9IAbBxMhZd6o9gQ8A8E9QyC+TMJ50ElEKT0jsGDWdscGBQ1lm5EnGg8fK5qEXmTEFXLXbV4/QeZG0JVRjX7j8DhUKrEM89PT+7+wJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMm7sfsa5tMZm+9vPsMqJy+JU6H3ZOklscSFRUBodPg=;
 b=ArmCv8/euiqMM6mwQ1gRo9mWldkCGnW24a2z6I/qNCrMfkxvG07Ui/eOtymxExD+02F7xAefSDInWMNBbLsX9wmNewVCTwlERNjdoS6sFYFk3wrE9fj8z9PNWNUl6asvDpRMe+P2EcwEkDJgPBKSdA0ma5PSnxXWEMzzYr7VXak=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 13:46:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 13:46:08 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 5/7] hostmem: Factor out applying settings
Date: Sat, 14 Dec 2024 13:45:53 +0000
Message-ID: <20241214134555.440097-6-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241214134555.440097-1-william.roche@oracle.com>
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: a201c0f3-0344-49a3-aab6-08dd1c45a9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iNwoRHxKJ4LEC1MG3EBQUEvQF5jbb4hlGXY66YaYd+D7cZhbsFMw4aJjGvu6?=
 =?us-ascii?Q?OlQC6bVy7v4povyuAPkf+lAY2TcClqgMMdzA6XjUkuEC4yyCfNxsRKK4gWeB?=
 =?us-ascii?Q?m3gfk6NxPY+ucThkU3J89xvfwo/p29foPngGduEPwrbNvuvhdRftOcRpsCwi?=
 =?us-ascii?Q?DbSObn4M72io3U8sdrZFuT6F/m54MWF6xlmrwq4FnDvxzlDtBx32Bb0ZjumV?=
 =?us-ascii?Q?pec744MVqAMm8VEY7p+cm3pgy9HewAvotW/BBefVWTmuYHbxPXMZIdZgL2/I?=
 =?us-ascii?Q?P1UmW/Ei1mK+5S0r04ZpVgNEqv7KnzOJ0W107mrv1X3C4tbCP9QK9EmxQyKx?=
 =?us-ascii?Q?AtgnlkOKPy9dkk/t8XeN0eUcCWtteJeX9+AOqPp8Y20pXsoJkb5IacAr2xjW?=
 =?us-ascii?Q?FqbQvPvld2o+qL2OF+j8X0Itm99h5QmpvAi1xve7KjBxBnn5A+2/WgETJmmb?=
 =?us-ascii?Q?o+ipg9EVC/Rbv0BJVk1cuiyMcMt7WT3DWbqpIOmDZLniuq53naouoG7v6ZCT?=
 =?us-ascii?Q?Nu4OTVy9+f6AwVpH6M0fRM6HAu832dqDiNpTddUaDJrJ5PtFOgM8laaC3nAx?=
 =?us-ascii?Q?v3DmxgKifMWOZQRohE+Hyf1bSBbZbbgM9022Qxs56LgQg1SR0UuxiUXoaLGs?=
 =?us-ascii?Q?wMg5mj6nFs88EyneZZ9ieI7U+xvaanEyA+wXxk4DC/iD/CYa1W5sSR0VJq/K?=
 =?us-ascii?Q?S5bPacuWIHJ+RWFBEnVak55b9wgGbQdAnd/xlC7uCS+l94ab3zR9qYuPeKnB?=
 =?us-ascii?Q?g6ySKSpfaDvPn+pLN872yyjECx4w/q8FJ9FMQN3rIjatxDkkfbJaJBVByKRH?=
 =?us-ascii?Q?CjYERLrQDAoUHDCxPefK0m6cXuSv4ibZVc7UBbtfXOzEP0rOUsqZQJ6mRDHj?=
 =?us-ascii?Q?/A1VXefxmc8cdqoNXhdd4wN/fMqTlKNak2kV5m1DJMgzlT2M0RgGakGT2pV0?=
 =?us-ascii?Q?H71xu2hzRTeAN2xk+et+pTcmBVVgBy03oadLFOifA6lJFeF74HFMSiuqL5uS?=
 =?us-ascii?Q?CwOwYOsNUIZy//vOxH1FI1aCK0ji5/eYL0ECKoILiBOed2ql5NYhiBm/0Cr0?=
 =?us-ascii?Q?fbomC3Ga6/WReQbEH7q2z+XB0VWjHXbSiHaTOy/DXWPMDOD7D9Nc/kWZKCWR?=
 =?us-ascii?Q?tnpSZSLCkTp3NVUQECwPggAcYn6I/FR+YBmpennUs2/g3gNu78avkhkeSSOD?=
 =?us-ascii?Q?2dd7pN+rig4nh4XDkDvTwqWs0eXHk/QPrQ7JFuTs+4XXN8mFfi+wVsGT9cGk?=
 =?us-ascii?Q?g+7z9maLx/tGoqgCPXQOXvsGsMpo7HBJRH1h3daJ8LT6zh7bmpYR0c3BDRej?=
 =?us-ascii?Q?hfPcZEsmBLTmVyWYdG8jaACLzDaknt4+8fZeKQyZWz+KlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dW4ObsNZsB+H/0lV+r/hiO+QdUhq1G37wrXndBUwuEvQtxMZrunxgSailies?=
 =?us-ascii?Q?QIkmSx+46w+ELp1UrQk3g/gB199usDkbbzkzo3ATZhZY8IRAsjWXG15zX0Rc?=
 =?us-ascii?Q?CyFuL992/C/7wGMRfOqDLvuqJVleNMfk19LaADJpD38F2e+CTkcesxxZDZRB?=
 =?us-ascii?Q?SiiIOpqXfj52RpwG0gnI+69zjyTV4Su5/Gz5Mk54OifPMUkNw18DqnBZ9D+6?=
 =?us-ascii?Q?SgLaP8mBHI6odr5r/utgSQAn1xb6Qjq9S6r39E11eyAST5IrMnolgKNycAK3?=
 =?us-ascii?Q?weTsxRjKkAsoVF/rUAd8DV/SGV0N1SP7dXRxuleJNFBO3n1/gdvjtH1lnFXE?=
 =?us-ascii?Q?r8SlMxNXoVMiT/G3JJdghYINXkEODBIN7l6ba7jr/+2g9rl7t9yX54MZsocM?=
 =?us-ascii?Q?QMUP0sMBw8BXpTVadroBtlza7uplIVjr2jL/AdnD6rext6nACt3ff+UPxIkx?=
 =?us-ascii?Q?/MLjW9IUSY2hL8FJNGGkam8yUzOJXbvcq1gcpdWzGvyW1hB9Kzdn5685G/Gn?=
 =?us-ascii?Q?9kqfCtiRlggWlHFhovI6UBqZoNI5+Fb3kNGYeo8ycOSr5II7dUE+cWNpxk+Y?=
 =?us-ascii?Q?4uxe9/tfC2fV3dVFry9RqiUNOJRhMCZKB/bS+DXCDbvN/Fu6TrhxZQxMmSKQ?=
 =?us-ascii?Q?bqbfCHVKpH68YRoh0ZpBT64ij1FseMAiff2f2POQsvlsA98XnHIEPcDB23lC?=
 =?us-ascii?Q?v4/OTonMeYskxD/csE51UWDPEa295Kymj7fG/pyjb6A6trmgCe6opB8NnsUn?=
 =?us-ascii?Q?mti2teOOo6zWk4ynp31ZJ8E/FwvAJS2WWHak452dg8JWIL07a6YRXpm1dcRB?=
 =?us-ascii?Q?O3tl7p0Y8+MYKOPTftQQdYk58sKN7rpAreTbVYm/vmi3y91dpIaAjJEhf1Qz?=
 =?us-ascii?Q?kSnEcOA2Pxjmcc8HJYaz1Y7fXofJZL4WQtWnXMyjCf+gvq22StcS0Jry6rB9?=
 =?us-ascii?Q?ewrs9eMOTNrFDtNDH91mlry23za8cNU26BT9pOocuBg1PhPoOWsy/6Jr0hF7?=
 =?us-ascii?Q?OBGQTafu2S0Ne1fsXznAiNQDqKAm60jzrklGdbxtfEBrMsnPsIZlMB1iVNXC?=
 =?us-ascii?Q?0L9LUwG7fyqdrvjE1KiLejEalK6QD2p86d6aKPaFFJtpSeD5cc4t7ouQ74UR?=
 =?us-ascii?Q?O1ikhSTzooJuBUD1xlbXsAc2QESpgQS1O2RLHB4HG1L4aAyH0jI6z5QTyEK4?=
 =?us-ascii?Q?xpuNOgW5QF/dckGqIN8GAGZf+65bNxfyFdaO14RgI52nF5v5l1p0lDzsbt3a?=
 =?us-ascii?Q?zEoMpJLZaY/96bIKyLNtCKsvE9obGqnk8o+qn9Lr7gueDrCl9YrYRGZGZMKY?=
 =?us-ascii?Q?uK8meLOB05EyZPdE7yHba83hNBHFEKNM4uDvaXND3exW9iDFEUbsA8siS56e?=
 =?us-ascii?Q?7ulaBS+lKXourrC3fwLv2sVokLmTjy8ch5QedUrjgMNRsGAhhWpIUnjP2WR/?=
 =?us-ascii?Q?IQGxy9GDrBep9jOkKRzD3TRodd6a6E4d2oL6ChOHYWv/Okyb/j0MX/KjmEpU?=
 =?us-ascii?Q?DZ1Y4t1Tf9vFAFeuUduRCBRAJ07ehTpph7AjokfNPwyIgzFqeuac84fE6Ezp?=
 =?us-ascii?Q?+uznwFgfC0i3SQ5tA1QQpxHa4llzkox+Ce1aPszfrk9QKhcc0Jh9Ycn0jml2?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8+cdn3TIN+YVb/m/OctY2AFK7R+klyzSgzQPOWpOzduqHFWwiP1i7P/QagQi+ustsu7k41mmP2GvACkecfwCLhjZBsWR42HLjaQwbgCXyb0zI4bMrGeoxQSkIb2LYE8lbtAyve9MbULxgzJw6slU4rGIqjyPym7XU441hVA9AYDYNPM6LBM3Gixrp5OVBZrxbrXHQMHXHfrK3qfqiR5w4P/AKMjPvZ2zmeZdbHDXobZHLBRHMSGIfeo3JdgNDlfipFI0bQMg4xsrAxZ9UNQf9xD0bQ7atRwiMKK37FHGnY4G3XmJTVQrYDIGa3LacrsDjiroc/ngwkFMDfehBbcRcTIKRYCc9SnJH/uVvbQH3Cw4Gn4Z5f2A2tdWAOtlNzzkcVWMwJuji9H8nZc1C1Unu0wujxXHPd8ZGH8Kv61Ld4uSqjv5KFbDPduqVM5lGrG+/WsEh6Cb191Mxdym7gtu/iRl7rjE14zRhb10wza94x3ECQd8kgqjzO9T2EOQV/N7BB5cYXBAOuyd4zdHpaCFmL2ErbcWDt1UOTevPArgPfPKSpp9KOkMyrjyrkN+KyY2HhTMB7Vfgu77FYpCmxQ6V+UL78IQ9cGOSMvi6lrueRU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a201c0f3-0344-49a3-aab6-08dd1c45a9d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 13:46:08.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgo3/qY64DKea3JGRMy5O7L1yhGLHJQsAE1u4tL6SVHMwVAitQPJr5dWFcaNcbUHwJJnVp/z/w/Xm2TSepKTiRmfSVFpdbcpGGDXrAT8Y8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_05,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140112
X-Proofpoint-GUID: ht-mitOSnzYUjs-LlczVuEoI1G_Rqoh4
X-Proofpoint-ORIG-GUID: ht-mitOSnzYUjs-LlczVuEoI1G_Rqoh4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

From: David Hildenbrand <david@redhat.com>

We want to reuse the functionality when remapping or resizing RAM.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: William Roche <william.roche@oracle.com>
---
 backends/hostmem.c | 155 ++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 73 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 181446626a..bf85d716e5 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -36,6 +36,87 @@ QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_BIND != MPOL_BIND);
 QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_INTERLEAVE != MPOL_INTERLEAVE);
 #endif
 
+static void host_memory_backend_apply_settings(HostMemoryBackend *backend,
+                                               void *ptr, uint64_t size,
+                                               Error **errp)
+{
+    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
+
+    if (backend->merge) {
+        qemu_madvise(ptr, size, QEMU_MADV_MERGEABLE);
+    }
+    if (!backend->dump) {
+        qemu_madvise(ptr, size, QEMU_MADV_DONTDUMP);
+    }
+#ifdef CONFIG_NUMA
+    unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
+    /* lastbit == MAX_NODES means maxnode = 0 */
+    unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
+    /*
+     * Ensure policy won't be ignored in case memory is preallocated
+     * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
+     * this doesn't catch hugepage case.
+     */
+    unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
+    int mode = backend->policy;
+
+    /*
+     * Check for invalid host-nodes and policies and give more verbose
+     * error messages than mbind().
+     */
+    if (maxnode && backend->policy == MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be empty for policy default,"
+                   " or you should explicitly specify a policy other"
+                   " than default");
+        return;
+    } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
+        error_setg(errp, "host-nodes must be set for policy %s",
+                   HostMemPolicy_str(backend->policy));
+        return;
+    }
+
+    /*
+     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+     * as argument to mbind() due to an old Linux bug (feature?) which
+     * cuts off the last specified node. This means backend->host_nodes
+     * must have MAX_NODES+1 bits available.
+     */
+    assert(sizeof(backend->host_nodes) >=
+           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
+    assert(maxnode <= MAX_NODES);
+
+#ifdef HAVE_NUMA_HAS_PREFERRED_MANY
+    if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
+        /*
+         * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
+         * silently picks the first node.
+         */
+        mode = MPOL_PREFERRED_MANY;
+    }
+#endif
+
+    if (maxnode &&
+        mbind(ptr, size, mode, backend->host_nodes, maxnode + 1, flags)) {
+        if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
+            error_setg_errno(errp, errno,
+                             "cannot bind memory to host NUMA nodes");
+            return;
+        }
+    }
+#endif
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated.
+     * This is necessary to guarantee memory is allocated with
+     * specified NUMA policy in place.
+     */
+    if (backend->prealloc &&
+        !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
+                           ptr, size, backend->prealloc_threads,
+                           backend->prealloc_context, async, errp)) {
+        return;
+    }
+}
+
 char *
 host_memory_backend_get_name(HostMemoryBackend *backend)
 {
@@ -337,7 +418,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     void *ptr;
     uint64_t sz;
     size_t pagesize;
-    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
         return;
@@ -357,78 +437,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (backend->merge) {
-        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
-    }
-    if (!backend->dump) {
-        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
-    }
-#ifdef CONFIG_NUMA
-    unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
-    /* lastbit == MAX_NODES means maxnode = 0 */
-    unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-    /*
-     * Ensure policy won't be ignored in case memory is preallocated
-     * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-     * this doesn't catch hugepage case.
-     */
-    unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
-    int mode = backend->policy;
-
-    /* check for invalid host-nodes and policies and give more verbose
-     * error messages than mbind(). */
-    if (maxnode && backend->policy == MPOL_DEFAULT) {
-        error_setg(errp, "host-nodes must be empty for policy default,"
-                   " or you should explicitly specify a policy other"
-                   " than default");
-        return;
-    } else if (maxnode == 0 && backend->policy != MPOL_DEFAULT) {
-        error_setg(errp, "host-nodes must be set for policy %s",
-                   HostMemPolicy_str(backend->policy));
-        return;
-    }
-
-    /*
-     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
-     * as argument to mbind() due to an old Linux bug (feature?) which
-     * cuts off the last specified node. This means backend->host_nodes
-     * must have MAX_NODES+1 bits available.
-     */
-    assert(sizeof(backend->host_nodes) >=
-           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
-    assert(maxnode <= MAX_NODES);
-
-#ifdef HAVE_NUMA_HAS_PREFERRED_MANY
-    if (mode == MPOL_PREFERRED && numa_has_preferred_many() > 0) {
-        /*
-         * Replace with MPOL_PREFERRED_MANY otherwise the mbind() below
-         * silently picks the first node.
-         */
-        mode = MPOL_PREFERRED_MANY;
-    }
-#endif
-
-    if (maxnode &&
-        mbind(ptr, sz, mode, backend->host_nodes, maxnode + 1, flags)) {
-        if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
-            error_setg_errno(errp, errno,
-                             "cannot bind memory to host NUMA nodes");
-            return;
-        }
-    }
-#endif
-    /*
-     * Preallocate memory after the NUMA policy has been instantiated.
-     * This is necessary to guarantee memory is allocated with
-     * specified NUMA policy in place.
-     */
-    if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
-                                                ptr, sz,
-                                                backend->prealloc_threads,
-                                                backend->prealloc_context,
-                                                async, errp)) {
-        return;
-    }
+    host_memory_backend_apply_settings(backend, ptr, sz, errp);
 }
 
 static bool
-- 
2.43.5


