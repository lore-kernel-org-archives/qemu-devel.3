Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC97CDD0FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MXI-0004xc-00; Tue, 22 Oct 2024 17:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t3MXF-0004we-TS; Tue, 22 Oct 2024 17:35:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t3MXD-0006jM-QU; Tue, 22 Oct 2024 17:35:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQbwR022771;
 Tue, 22 Oct 2024 21:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=yA5SGXqxap0vZEqvFgb2qBzg1DPOrZyTVMAb7dTFU+I=; b=
 AijDQy9HETJv8Z+3jEHPjMwWyYE4cWIg0eLgu5jap0IRZvmxRkjKOzY9FU2T29aB
 UF5eISVW+pyA9gyvQwXkT0RoLh/eYG4Hc19vxdjfqIW7ijJtVC1JAyCbwzf+rpNn
 eh/gO8aPeOKoXR95lspD26uayMKFDqrGlbUQ38mEGnwrYwxaesm46QsiIt/YMYkD
 SW6zhEKYlaU3pFC9iQNJ7Rs4jb6Syt7VjU8YBOGj7fKx5fVQLsP9BtKgVHyBKd3S
 Jwh/oGYlWGXEt9RgEcboc0NaNIyms0HkG4AWLGuEzU0v3pDTecGRfQvNUDVupfxS
 bKPAm0nAByg1ww1aiQPR3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5aserat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 21:35:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49ML4swM020265; Tue, 22 Oct 2024 21:35:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42c37egyk2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 21:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZnc0fa9EAUwUmeuM9u2GQZxsjB2K1vgUWeg8388d6b/yOGIzrIRSsCFtyapxJ4LhVv1pyhqZEXahb9sImhHKtmpK+un0r+ii0CS/Mf0gJKY4Ki3EAgRmzeK1lsAxbu7NCw7Hf4/7tQ23h7UEqKMRJJIQi1owSjyPXTfrkKlgKp4LFDvnmxvrC0tF6TJVT62uT/Xlc8TQFYOkFxL4aswhCURH5o77hAI8FyuT/bfvPB6FrjcgynuOdsCsEwi2vnfWfiL6yByFoXySrVFTrRrhK5ibndss4y5MoeZPCjn4PAMqacG7VpeufR0w0/Hv69oWhfAztyok0MszZ+TwcK+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA5SGXqxap0vZEqvFgb2qBzg1DPOrZyTVMAb7dTFU+I=;
 b=ZfILI5HhsuPRUjt/9uI4QRsl5gbzjhrSTwJNj/T72+JmS6IckybirzIzyfRBvKujCCMcjqdYhUd/I90fewqVKmyUxyVtCwAwak+xF7O1HVYjMjpd6lsI8h4VJZ4yvxUNRzrAy8byxxfQ3h1t3SHmkqpQzCtYUHDQA7QViuNSiMHVgWdJgzQDZXUWlO0tlPlk10kSUeSKIbR2Zq24iJSn54jmYr38mmO3xqYj26SqpujsSMvGPEcd3lXfa1Tw/yP4k59vETCjkePrJbHJ+LKbIWeWRwAliZNCzAM/3EkeawhhwqY9qVsfve0txOxn3TKeX1/EvDBwY79glsjWFpGcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA5SGXqxap0vZEqvFgb2qBzg1DPOrZyTVMAb7dTFU+I=;
 b=Z7QMbKt1sTLBUj7Iz/dSf9dc9xEIf5OVw+Xe6/b1i7B4x8ST7xXd2H2DiuopKVhNtHINYicD1MQM78v03njBtiUyg0wYg9SaRYE/Uvgj9j4+obzaA57z90I8YLhWrGsqfB/gr0OLIOHUJfeG1ijoSZnGB6W7gx4bLeQMcNVzBPU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 21:35:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 21:35:15 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: peterx@redhat.com, david@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [PATCH v1 3/4] system/physmem: Largepage punch hole before reset of
 memory pages
Date: Tue, 22 Oct 2024 21:35:02 +0000
Message-ID: <20241022213503.1189954-4-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022213503.1189954-1-william.roche@oracle.com>
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0971.namprd03.prod.outlook.com
 (2603:10b6:408:109::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 49084a3a-3a25-4ecf-60f3-08dcf2e16ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?52m4ycQxcOLGWK3JwN0NJR7gNcxCHZwtO18QVRJz7S0xbMufbcrkjwgdchga?=
 =?us-ascii?Q?2J89DKfAmpg2hWk3NmGfcQJ/fFzk1+fBQ7DNbdov+ZcAsRin9NsjRD21hMaK?=
 =?us-ascii?Q?GCt2si8t7GlBL/Z8v7HrBOcqItxXsnxmC6upuLsUuj38E/oFiaQoHtZHveCS?=
 =?us-ascii?Q?VdL0eKmr2rjRyrURl/9N+2GwDf1v8gFrxV2nohcj/QH0T+WonAImqx1/Mb10?=
 =?us-ascii?Q?0zI5gjxFGkTVUCHrwtETAdfuFfVkhqDMGDSOFBzzhFdRyCxnoHjsiuBXY7Qd?=
 =?us-ascii?Q?9aRMZTZnZA2Tvnzpe+UD+c8KjAAakCHYABEYrRxbvf7IP1JOdUvsE7musgKw?=
 =?us-ascii?Q?pIMyUiPdMLN+zrAkXQVEGm9ky2u3FTFEjMLAeS/YeQNLBaBNj9m9lbub52U5?=
 =?us-ascii?Q?9hD5eUqQrXKapZEQtc0lQ60OMWwNLLr8zqVbMCBxy7Lb9npg4F3CZPH0zWVK?=
 =?us-ascii?Q?rT+tqM6RBHW9rnoAY2r6Z5nEoZ6/SSLyKNkcY3wr7FbYH3B1PHEZa6LmOKoh?=
 =?us-ascii?Q?LaAQS6Pe/hayLNREcXRmAdP3SUNhQMEWoT1lYz4e+iubwLmPtfv7OYFHgyCV?=
 =?us-ascii?Q?hW+V8/hUbwIsD1Fafyv7KczkMJrRgshUplyMDvVOejXEwDLDUgn4xEx+1SMa?=
 =?us-ascii?Q?s2Rt6TaDUdw9KwjUVQs/T85QBFJQesqUhroBeOWaRXawib679AUJBUzl1BS+?=
 =?us-ascii?Q?pK0Cx9qatAI5y8M4/JGUPCs4V2xv9Fr/rU2pwQZdhOKOZcl9Yiwoutzm76mF?=
 =?us-ascii?Q?FczyGZW9TyZKybvXDE74oWhTGXfxTOusf6X3Zxrrn6ab0Vv+r8Hz2LK0xOdF?=
 =?us-ascii?Q?MfKoBxqp4G1T0PCQY6Y8bsHOv2KSI0FyMSCAFgbN7gmM5t80c3jsEe9AGje5?=
 =?us-ascii?Q?rjpKyRnuhofjC+6j/k1HtDqoCW++4HDlwkMUjfEtK4RHbONXtMES5wkzGWAv?=
 =?us-ascii?Q?iNcpguu4EaSEQcOa3iAF21dWOVknFYVkH6r7shGCtAb/oulvZ0r6iwlNB/2Z?=
 =?us-ascii?Q?j9/pzbyGNA+9DM8dIj1nufhIorA2TZwl3WRTN39eMpYYeKnUmwTVmyQuurjV?=
 =?us-ascii?Q?ZuRZsEhDQRmh8EDoxsllCivFt4Ln8v4XJ09zDVA6GGoXRCfwMfP4QycvPSrA?=
 =?us-ascii?Q?IqqGwqpQkVcZWfapu8nZP5JTUgP8jfyYoB2ztLfA0Jwj1sVFvUNkYrp/68Qh?=
 =?us-ascii?Q?j8Bj2vbQvKMIpIlgKLv1FPjsxO6URNCE+jp0DNT5CiyygD7cRwQkNvlJEpxB?=
 =?us-ascii?Q?ADhhhrym2LywMBCk/bY2hK/+xnBd4ham2IfxNELqaO41azSyZ4RSF2TIAQgE?=
 =?us-ascii?Q?ikX24ZbkFX9cAY6WVl+AgOpBSD+HX4k2H+YszpYbxba7FtyGX+zIRTe04KDZ?=
 =?us-ascii?Q?ZA+U+zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+HZsTy5oSttN001piD2iQQTAANs6hGctJaX1UeCe5vI6dEUQRB5xa8wXTbz?=
 =?us-ascii?Q?wbEsk65tSdjTPusWgyaDnivMTrI6xE9Ev5FCvYfmQJJvZqZqttjBuUOU7z2O?=
 =?us-ascii?Q?43MrEkuO2U/l27ZzXWWXqS9F6/qz/7pySA52PPTU37/WkZGb/EJ4xETp4RYe?=
 =?us-ascii?Q?0Nv1fdIHxhljN6UAuSUe4J818lVBc4GBQ2LXljLOnsrj022JBx0YO7JXV4fH?=
 =?us-ascii?Q?Ij1xR4lYGgnrW1r5ZwZjXag8K1LoOWjLKPqfMM45NqzwuHBUffeyQ+bYBzQp?=
 =?us-ascii?Q?GgDcnBi7gNkKTeUJKvD7R2fEZYacB6n6aSMcXV9USWlZDMBxSPGm/mieLimA?=
 =?us-ascii?Q?ZUXZs5Lq2MFYx6hdNrQ55gG7lI2SSiy0C8i6RlT//bVNoMCORW3oWRgrExQ0?=
 =?us-ascii?Q?WnIENpJQZ7TQifITmTTIXT19pFvd7/WZob4Bxzu5hwk4IELdA2JQ31JPg3fA?=
 =?us-ascii?Q?5NWx0szkJIn9qXbASHe7hjWTaEjw+MSawDtxQvbwx2TyAOYpL01l6SnNs9oY?=
 =?us-ascii?Q?gCVO545nPhUBQwgMlKE9cuI8Hrf+WTGu+1GJWpUA8c1w2VJSzJgOiBZ6HBR/?=
 =?us-ascii?Q?2ds41Jsae7wzgzYl7Z6XD4HrIFz/imPCWExHUy59LoFQI400jNi5p4bhVv/+?=
 =?us-ascii?Q?LHJtVkiV02KtTL+mHFF5hy8oPOrVVocopXBGZer2bdUXewef5OLBhRytaQY7?=
 =?us-ascii?Q?8jT7/wogQ5rYYGLlnRT9S0GmgECBizpmYFPANDqxgXTdz5r93CHOeSd/RmUm?=
 =?us-ascii?Q?o/jlYGiEVD8HALEk6zr2GeThoLyG40ROQYDDuwLjpMqhjcvgMytZ9xxmQTQl?=
 =?us-ascii?Q?h+bd2FPbvWJE6PFS1iY+DDzuA9Xp3kdkqew5sY1zIR2yYZyYvVaWd8ArBLJU?=
 =?us-ascii?Q?XOUiqnV1Jt08ni3vCjxXoCbEXNXq1cd56eI9ntxV5ymXEqPwoAiabUMDlVwC?=
 =?us-ascii?Q?zqYHXENux1lS45K5xxC8WzJDgbM4spKb8SbsVxCIdK0dbkVQmGrr2JsHGRmZ?=
 =?us-ascii?Q?bWnLLWnguaCPG8ZsXXEKDhaeMIoswoOUZlI0WU0Cn8tjVT4E0xr+sTb//gG9?=
 =?us-ascii?Q?E3rHv6sL68cUICkjm4iW8MNmIVM3TuTyIgHPAYuJeni+HThatVSNNhZPh9cN?=
 =?us-ascii?Q?5XA6lGz4J1HkRANoSTPRKCF9VDLEYH5QbQyHulsQwd+79NYvh1yPE6fOZTJl?=
 =?us-ascii?Q?kSnW0oLRHYsCUfqaFz5Rn5ps0e3vxOJNKo/LifE0haNV0ZW62ApSkY4eda/9?=
 =?us-ascii?Q?tL9C2LSxb6B91VXkxrrnhJxWdPGoshZj0FKTsz8A1Vb3kkmV0h7e+nnznzm3?=
 =?us-ascii?Q?cVFG3+e6/rq1ThVmFFhj9SLXHQL6EeE1GBmyNOakxPe5CpRr/8Tm4lHH+DVk?=
 =?us-ascii?Q?g8C3MHaaed2gBtU/3/NPm8XjdfT3BEEvgiUPDFykDBnSceGtMBc2pZfGqb6Z?=
 =?us-ascii?Q?x04NlZjChHba094px4w15/I+0SRUKwIx8+3uor9FMk5DnYTcK928195YAuKv?=
 =?us-ascii?Q?HtuCDAwkrPr6w/5tgCoSwRNq8Mw0/uRWpz180NABjhk+7f3/0+JMexLgVhHO?=
 =?us-ascii?Q?qfScqW9+8cAlCsY7DkaSoV9Pmi7nBrxOexkBO7dlpqn644dyvC7QQRVuKcjx?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SmMfP8Gm9nLBRFI52+M452qF77n4o6Po6HtTg67lJxMtXDcg/072zEpyZxJ+vcqb/ZZi5ESPHZN6oxGJNz97uavzaMR/MPVaXxphLtIy37VGETy3eHM18Z4RsjltQa7ljSlWtHzj4QfIrwTfeO8PYR/cXovhtlLq3UU2nPZZ593ymTdyNUYLzb3IBUt585P0NyuLF8R2xmsyurQpMkhFuE+SHNMLqUAfNRCH+5m8Ph9Uo2202xm0d2otPwVkD87QuoQQ3fYilWn0t4XCmGJTy2WwAgE8nf5wwe8jcVGASFPWkFI0EQmKNFS4ZN1rzRxLEMG87BnneEG0dFApY2xmzul/mOov8UtzoIf708sfO4cUpKf27ZzqOp2lUIRSfzWs6Od4jSzkGDdAE8sZYfhON14nP6mokZ7a5RmtkRDSkOKF5d0huq8gd2jjyirFVwdAbvouVwEqRE7cJRyGvQkkUFCA4dorMd+7p3G+gkxqL29LLf2XA9sCs/PrUepF5d7hPpvModFBUlRrK+y/5E/P0d/treeYPcP4cYV6nsiCqtq79cmXy5Fal5G8NZW6VIYGibG1fZckkZGOh86pdpniPEJ35zKvQki8rKh3mmlrpt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49084a3a-3a25-4ecf-60f3-08dcf2e16ace
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:35:15.4930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYl6350lDZOgQhzKx3WbgaD2SGh1IglWwFsBMaUKfKZDJLaMPNiotjsluY+W8l1Y4v0Buu2BLwaay6GLx+q8zjz+UY64A/G0KD2YFPoGf7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220140
X-Proofpoint-GUID: YoTjuLtpRFYnHesFQiS80yYBVEGzU_c2
X-Proofpoint-ORIG-GUID: YoTjuLtpRFYnHesFQiS80yYBVEGzU_c2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

From: William Roche <william.roche@oracle.com>

When the VM reboots, a memory reset is performed calling
qemu_ram_remap() on all hwpoisoned pages.
While we take into account the recorded page sizes to repair the
memory locations, a large page also needs to punch a hole in the
backend file to regenerate a usable memory, cleaning the HW
poisoned section. This is mandatory for hugetlbfs case for example.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 3757428336..3f6024a92d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2211,6 +2211,14 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 prot = PROT_READ;
                 prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
+                    if (length > TARGET_PAGE_SIZE && fallocate(block->fd,
+                        FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+                        offset + block->fd_offset, length) != 0) {
+                        error_report("Could not recreate the file hole for "
+                                     "addr: " RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                     length, addr);
+                        exit(1);
+                    }
                     area = mmap(vaddr, length, prot, flags, block->fd,
                                 offset + block->fd_offset);
                 } else {
-- 
2.43.5


