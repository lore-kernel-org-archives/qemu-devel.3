Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9942606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=EgEneU4T;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=teqY+cj0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnOB-0000dr-86; Fri, 30 Oct 2026 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnO5-0000cn-0o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnO2-0002dn-5I
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:20 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBFxkw4129220; Fri, 30 Oct 2026 07:15:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R
 8U=; b=EgEneU4T16YsbCNPMqmqkyLa2kz4pdlz9MnThmByt9cQPWbLyE9GfXadN
 jMznzmodL/IPbHboiraOzs52jqmQ0+SEM89YpsssWTpXgbZ4SFybDhb0yU03PXMS
 tNGP+mIL3rXoDGruWk+lwcckRlFQAv3l1nxTLVdASdhHoXHkObK/edHmQ1q3liHB
 R4l9xpdUr9qQ+qvd/J6ZjC+D6x/oLCA1Csq2GSHDMI6ILOFTioWUm6U72zkfwZg9
 8d2DwHK9v2Z1Uqb2yuw83POzsHhCvLCaNYM+UKk3HX2ru91Oey5d4RtbAtsEzXwo
 KuVEJM6oO2t3URSQLVEo3wPtOdplQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020128.outbound.protection.outlook.com
 [40.93.198.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hmggqsj25-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 07:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY00YFJIbdgrW6pBzStDCeHcW9SRQWyF0OLRHWaJJP5pJDzLUJzsKenTDvhFuOTn12vYJXljX3h00c/s9thj7v8vH4+mEM8J1ZDYuyoiTGTDO6j1yQQI8yHyZE1d4JCHDvY5JcKPu4UkNMe5/AhKZk5LNHUqh1FB506x8PszJUKYiuzXKdhMlktwhiseaBNUJ1vixBQI4ME3cmc9WnENw47fSiW9IuTyGFriae1E4nX/vqiLIXQa1PCkMfSYUs9RU9QcDxVk+ciG9UlTgu1iTmYCjdCRqlIvIuixTyhSLtRMP1P4ft9aHuNZCBDtlYKpdw6PYza+hNXKJmCaN1U9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R8U=;
 b=voSaPUK9oARLBaYeHC17Co5qTxGQP2tlO3aYXyPsgrAZTC9MOEu+4MTlgWx8TCNYa2reu6W0Y9OemH6qeTMz2AoEKOfQ7V6HTuWngYPM3nBMqCQPeYBcZFnKpPZpUr3d04aO4vCaw4Om00y1G0P5lGdgsMXZdOtVi856SqNjhqv42RxaO8n7L9+1sDv2bWEx0ww0/+6D5rPh5TmyEywfqyfibcGUS9iFX8uzuLfxz6JHbCrAyoiE/X0RXCLRF4RjtWsNOt3lDxie8/x1cSzXrCLxFz++Mrot2n1b4yQQbuC3y4d/N7Y9n73S+sDSX1C6LXT4y0sfJLkgoAKSFh6hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkN5MiXkfjtGOwQE+blVI6MACFEP9Z7RruF5XH0/R8U=;
 b=teqY+cj03byNZKIkr9NQ7c3xdI043iYyJ736SyuKTvvEquvHKURbIO131ukcSyMDdU+ZQOwtKm239y282WABUsXQvU85VVWADmWPj4vDppGs4rphbz+fxglDd4Oa3LxMHDAV/6TKZMMWQm6Qo8wdvdD4Fqv8id/zqbwbzdMMLDDOSqFl9P5QcPw4uYFfaeZxaPVwj/zn2qKM/laM35atnRUfuBB2adIoVvWtu9AH16wyFt4Mb0VHxJGFGLrucKnSdc94MOwAsB0K9pXmoJ778IAJd8NeqkDeDfIils/dsTV5g6i/FaQ2HLYAKchCITqTs5u3+RO0HRTSqySNd7jrVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by CH3PR02MB9870.namprd02.prod.outlook.com
 (2603:10b6:610:175::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:15:03 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:15:03 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 3/4] ui/vnc-clipboard: factor out clipboard peer
 registration
Date: Fri, 30 Oct 2026 15:14:41 +0100
Message-ID: <20261030141442.264308-4-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|CH3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 82893e06-77b5-47ff-c512-08df369030f0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|10067099003|261021135927099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: u/W0JnYfgIA+kRhAFSLHYN6sRCBb0Lp5dau+mrmhq/v+n5JFHt5jrhFS7Uo+Yh/VSGQ3Y0Xa+yiFkbvHEKEwX+dsc+YxU8UmRN0dHK96Hx6Kqb6XjyZUqRnL1YjjLN+1wZrFFlm4MxmzjSVd57SmEiHGEhUodTQ/uND2dYv0YdO2lx4eaEANCwbOU2u5dt6jR2U9R3Kglw0XnmB/nfiSnfPkF2z2rBVboYtJBFCg/G+piIf4xeDAfTXR6id0FCciUFoRIu5FHl8IqZRLZ8XAo9rLx2EL6pHa8zHY5SQFRLLvOEzwplPyQbH83bxQqM3JitW+FwLoSectuYq0tLPpmAnTL/ZCPVD+uK7EUYEFm2TzwOE3SLKHB3woac6J7t6z0q8tm3YosQHBRmfSbagxpSiVDkXUOF66ttl5a6kfBJqqNZnnwg8fkGAXhg5ECz782OVrm5C99mkPUA326gCwZzFYHYu+JODCXt2r+jpfC0RlZFfxtgHQMGe/K3vX314Pamsxc6OrgRJc9PeEJoGt0yfmgVZd5Hoj1QrpSgMV9Go/aheKSVA78pC7rPACE4KpDrhPzCgGOivJLff+V3kORT0gifJ7yvTeS2SNB9QDbWzjaAdtrtHh7BbJMI3XRHssg8H2S3KO+lqY4YKUiMjTnde8+afIZ01ARLC0xpIBeOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWDye81qxlxPCKdyhJn+XvE1yNhjkK3sV3WYrJD4PkKbgiOu7PMyTHzqUGCS?=
 =?us-ascii?Q?syhh+UgPEpQ+KQa3nOp6RXPh2efNT8S0vtQJE4a4085N12Gib+XRjvLoZeCT?=
 =?us-ascii?Q?A01+WFbYO8ncbaQIbgv7iSNma/JcbtfCanQRFdNTaJ6Hg7MzSCq45xwuy0hu?=
 =?us-ascii?Q?4NaL7EY4ZhSMxHv5pmUhEsgdT6i8CmfvC6+wcKQ5rz6fpUzYpibpjojmGKcy?=
 =?us-ascii?Q?q8YcC4amme/bH17w/TBWHL3JICkYCWm942s4LZEl1zGygc+s+pUZNOvt2jc6?=
 =?us-ascii?Q?Kxt3tT6V7+zJkxjRd4OeqNG6rMoLYN5vEcYWcboQFm8YbNP+2HX1ro8/iibI?=
 =?us-ascii?Q?/tAJeGduWE8qGBWbarTXa3FFy+YfBSQJCmKxPDPqwvbeUhKnYBMx7iXgvYrx?=
 =?us-ascii?Q?zbGNHKqhsIYLslAhgb7yOAKphQwa7qEGUM792emSxJF2dnd7o/vPX32GkhyS?=
 =?us-ascii?Q?/NKYAZoxFNHeTsEnVZmuxmRe5YdQIwJISHkF053r05Bg3/YWFVgfxvBz/avB?=
 =?us-ascii?Q?Hy67SR6EOHrXxkFOB1D97xHb7ebkLCPIdcoIWqSs72aerp3axm2+lhROhAlG?=
 =?us-ascii?Q?erbMilcXIFcyuadbgIJn1vjrWez8TGEatfzSiDEecZv08KbMqQghuv2tAsHJ?=
 =?us-ascii?Q?qsiY8EqMEJl55cXlTRis0s5cpRpWP5DcQRb1v7aMhUc2/gJWER3LNd9N51wk?=
 =?us-ascii?Q?0wsflyY4PGETQmd6Ivvx1kGXP2Kc5g9p7JDIVyw2HNU24LUXemVA6UTFFmf1?=
 =?us-ascii?Q?TRxu3ICtjF4/wgsy0YXchtFvJXUhLmu66o6CzCWz15MtqytzZ4YlZnURZjjf?=
 =?us-ascii?Q?wt4pwnUcRulJXQ4rIG9W732b4kmwrMj4DezEQhgNbvCjeAefnlsVPPcUOGEd?=
 =?us-ascii?Q?uIkHg0sD/2NhyqXm+3pFlyrlXKZ2++TPzUOaVA1WxfWcORXPguugVKy9HwIm?=
 =?us-ascii?Q?/1loMe/GbEFGvj9GPDUDmUvBUWFpAzmCq5pwwT2ez6pdg8+Mu5LjEbiPBNdG?=
 =?us-ascii?Q?R/aP4BAY+93qljxFe2b775jnwu6LLvP+5c4dXAen0c+OJmS8h3Em8Xe/aALh?=
 =?us-ascii?Q?eNnQeKwUakfv+y6AgvTUwkDTiJQUX6x/52wC04u5QXvPTWr53/RBQ0dqCZHD?=
 =?us-ascii?Q?p5D2bcVe7g25W1qBk04CDD7t68b+U/gxyc27T2rUzY8R+ZShnHR98atxhZg5?=
 =?us-ascii?Q?0tzYquVa2V8b9JOBbq1RQXbOJHbnkzi807ryhiJm+zce8jfTy6c1AO7+wyl1?=
 =?us-ascii?Q?RFARXQryH7QgN8S/94G/6ozfDA0SIS/AzqUWL4y9QUglMzDgNkZhPd9ovZcm?=
 =?us-ascii?Q?uF3+Su8HpwpozyrhuUryi4iRX+RpxEBMstp9pXRZEFXfek2zlwTCfFWVzZFx?=
 =?us-ascii?Q?o2go7WC9RxzcG6nUl3cyaZI/75CkTG0Bq3uJ9KPV75NqdwbsZ725V+aBKpOK?=
 =?us-ascii?Q?l24sz/G3KfyXrQB8vDmePRvozVeFoJo/01aCEmJfvEPpyOl5uYdSy0GqdpjV?=
 =?us-ascii?Q?85O/geleErwdr48fP3YfjwXZwb9AyEBtWVC7zHktLwL11yhQALnpYaZ1d4oY?=
 =?us-ascii?Q?O76WUueuDrnjNX+vkHKtseqqV+VnMnXJ7kHhdKkWQkFtH0igucVF9ZvJNJXy?=
 =?us-ascii?Q?obqvmji5iAIgDlFMC6yrdJ2ys5Qx5kHD5eMfeBIjUUCoADTUAA/g8yE8l4uI?=
 =?us-ascii?Q?+0dpwRr7noHURnRGuJwdCV08Jh2JQFwMNqWl+6/gxu3CFBx4hhtyCPqj3oM+?=
 =?us-ascii?Q?CfkKi/Iohw=3D=3D?=
X-Exchange-RoutingPolicyChecked: s4AgIml0fVBEnfXixOMbAUtoqTXUS4f+4EutjvpTZqDVWFeTbZALUwa1OttID+hHxrYeB27Ou0qPG32ABBNNyNkb6RzsMANQlGN8n7ogbEVt5Iu50gI7mjFbW2jIqvkWgNrcYm+PuDiCyChpoOGDL1ZAUMsAsSK2t6R/vVtG5wFhxJWiFbkxasMzRtDBcRte55FRVozgFleuWthmHV+L8W4KvYGxfFENysKw8yh+LRlQNWWX7NoJQZmR8iej2T6vrj5tbhbMARofEi4qfVI7+PVY50xt06OeawfH4twR7XdRLEJb3gXKB9b/4RmpwSygnpuJrtHGheQFP9Z9zkQiMQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82893e06-77b5-47ff-c512-08df369030f0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:15:03.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqUsZWnnHm2Rv5DFJEFOFHX95L1a4QHDw702XWXn4IEtA9qUuvFh0rxT3L3Sx0pBh1z5kWCzhb7cn41K4K2pFFAxHnzAZkOaLWXCT3gfZTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9870
X-Proofpoint-GUID: XTlv85kE0Rgoxv7wwL-H8WYUzz4yahWR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXy+6G5fC4d47D
 SHCOaYQVr5G+nOAuy9WUlvruCcTRiTgP6GqF1chCZq2PvSotuEH6wK4ow3QJ3XbhW7mfsm2Hwdy
 3/CH4+u36W05ZsspUO9R3HuJe+n/nHg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXzsMv86v1M7hJ
 RnrQfcFglK3iaEbR/CS9y/2rNi7sSTJy5NjR+qP14VVrZMa5U33sUaiJTi55TSqIjI7oJcODUeD
 +YxCjxt2ESr8GhgzMXIgcrJVFohzj/El8hEiYOO3kPhVij2lNqgNueajegpbP47HUpCPZGCRUmH
 +zLgjHHpbxqkcYgckXFhbZDa/hZVRSD9dxcck9uQuNn5ZI+0IS2KTfL9ffGgmA8Wt+Z3uyTK7ZX
 eTdn1p2/nTwJEV0bq1+Bpamb8Lc9CczlelwnGyqMEW4hDMGTLl1anyLxaS8NVpuiavicT6SzKHm
 y42+QrpipT+jvNMLcFd/NmG/LA3WeBvVW2Ql7hb96bfra1kE7CM5fyldV6+vnca1FNrCcJmFnI8
 autJsQCCGfZlNPrGQ1fl6VeI6KdlY+ZiuNYih3jt9AiqYfzTZipXsfrV0ILwjQb0bNfCk7hMTH5
 EYUPKXyAakkZFRnET2g==
X-Authority-Analysis: v=2.4 cv=F/DC5ahN c=1 sm=1 tr=0 ts=6ae4a668 cx=c_pps
 a=kmMK+Fr1voQSSSuGttX3zQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=PIACHJi0fWsG_2wZ9OsA:9
X-Proofpoint-ORIG-GUID: XTlv85kE0Rgoxv7wwL-H8WYUzz4yahWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

VNC clipboard peer is registered inline from vnc_server_cut_text_caps.

Move the registration logic into a function so a subsequent change can
register the peer independently of extended clipboard capability.

No functional change.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 ui/vnc-clipboard.c | 17 +++++++++++------
 ui/vnc.h           |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index dfe830f819..67f710f6ed 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -325,6 +325,16 @@ void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text)
     qemu_clipboard_info_unref(info);
 }
 
+void vnc_clipboard_peer_register(VncState *vs)
+{
+    if (!vs->cbpeer.notifier.notify) {
+        vs->cbpeer.name = "vnc";
+        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
+        vs->cbpeer.request = vnc_clipboard_request;
+        qemu_clipboard_peer_register(&vs->cbpeer);
+    }
+}
+
 void vnc_server_cut_text_caps(VncState *vs)
 {
     uint32_t caps[2];
@@ -341,10 +351,5 @@ void vnc_server_cut_text_caps(VncState *vs)
     caps[1] = 0;
     vnc_clipboard_send(vs, 2, caps);
 
-    if (!vs->cbpeer.notifier.notify) {
-        vs->cbpeer.name = "vnc";
-        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
-        vs->cbpeer.request = vnc_clipboard_request;
-        qemu_clipboard_peer_register(&vs->cbpeer);
-    }
+    vnc_clipboard_peer_register(vs);
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index 88293ef497..d8b0070396 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -636,6 +636,7 @@ int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
 void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
+void vnc_clipboard_peer_register(VncState *vs);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
-- 
2.43.0


