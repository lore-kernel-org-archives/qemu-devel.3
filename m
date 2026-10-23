Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=yJQMWTcA;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=cue8Gfag
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlW-0000ox-H0; Fri, 23 Oct 2026 11:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl5-0000GX-8B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl2-0002ea-O5
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:38 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6XOL3757985
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CbGQw2h5a5mMlJr1xP1BrEPQvwWwsqlNZkq5r2Y1S
 Kg=; b=yJQMWTcAqBJhxSCm5DvhgEWPI9Z3CA3UhLLGOLTN/FY5bO0Zr4bGLDuH6
 iY0FW2u5wuSJC6MEW1Z69dUKWFlnQjblB9uLFkbdcBel9EGGFtgtClORKX5RzdP3
 oWxFMsK8MpeOtAfFV7PSbZ+cdEJxhAMsVhmL9dF9jInkVG6FWNl93WMThLRuj4UX
 QnDIA6chCHazf2UbKsc2uCSEQ2mNBVAdZWPwfoH5zC75a5jK7J3lJWir/nrPy0he
 OLFDs35EN9WTHwVb5kfc5KK8VQBs6jaP5A1k4LYSqMwzsGW9iBVIycejWEbmzHlX
 PfFG5ThBwFITRLK0L75mD8nQcgOaw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022076.outbound.protection.outlook.com
 [40.93.195.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975d039-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONTfAb3vDFdlmzWfuvfJPTUL1ldF/iJ8uE7vSd5CpIwie0HpJyC6aAh2ooTSMZB1QaQv2marUCFZZSV4roUWDi9aew5f/Q79gL1+jvS4VI8UwHCRcdXSu6Smduh1x+8oSPorDnT8JPQ1Zoer9K/nkFJttcnfSFgiE3X40ES6CJbsXYymecxdj+8asnFbRfbAhkkJvye3Dqp08uH3KmJDatCjsLsfZ3K1VfWNkM7bfzC4sqnpWUg9PB3yEufgtLKqSQ5gmsi62S1ZH20I6gSNFYKDbrW06LzBSOSzwUxFcJiIABUK6AtRCh44e5A8g9tq4r/ycl4rBvuyVs7WSOy7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbGQw2h5a5mMlJr1xP1BrEPQvwWwsqlNZkq5r2Y1SKg=;
 b=gVqZy/l5M5HJwoiWcCiMKZ7invsqMcIM55pOHqL5+NswHcC3skIEzD9kdCxXnn6P5aALbClJjEuCSxcaZHLUOg1B59vM5He/pReLc0lRv/FUigBNE7349ntlC0Jz7iBTAIkSk4sfAy5CLzLTUfo4gJcpHUfWRmdbCbWOoiBYYsXhkpmEYsIs3RPZWsoC2pKkikgtfyYG3zmR39qb33jXB1Q8hHugGpLM6pOjfEtk38NlqnDnQ11PX64TZLD9TcysZM92j3XMBIL/Oifu7vuCi0b3PToaXWUz51hc/vsb442s2iraB/i7/khI+Y13kfYhLl3YhOys6/gkHvJmahqc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbGQw2h5a5mMlJr1xP1BrEPQvwWwsqlNZkq5r2Y1SKg=;
 b=cue8GfagS2eRCKhgY+fe2E1tCmOKEg1GRMSXbjE235IsIox9I9yfqguwtUE+KoHW3Mhn3pcjOSn3zymLXavxxkIHIMpPF/uaVu5AWi0NsSrDgk0uY864IoNeiok+ECKOFcnYr1dS9xxExtiEGaMizyjczf8jDU9pVnhkI4YqVi9/F54yGhOmK9amYcnKk2VMBNANOStTZqr35i+6dBJjzK8Hul21onroBlc7ZQehAOE0undQC+vplTqyoBlhqbOebqYV9iXiKyERiFSu0wACfri7pzFyzDLoJi9nAsrskqpBu9CD14TIdqB78XvDf4GYAVQs0W51/Ukoi/XXReUUPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS3PR02MB11571.namprd02.prod.outlook.com (2603:10b6:8:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 15:00:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/28] i8259: move InterruptStatsProviderClass get_statistics()
 from i8259 to PIC
Date: Fri, 23 Oct 2026 15:58:31 +0100
Message-ID: <20261023145839.34909-26-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS3PR02MB11571:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e5c5eb-c75c-4be1-01c4-08df31165d9b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3HPu9Yc3hpZ4Z8++0GQRGkzxd7mWMPs5f57pxRZyEA+Ht+k8FD94UVEIsJakZD5llPq3G2YYZ68gc7q0n/B5oQCHChliEjqnFfOtoTj6//8vJoTYDDQ0zO2oEU8888u8W5r7yU40fIgystvGDC0dYqiFpTR+BOVsTvCrpCfxQL5wXxCfemBw/KPKhSgKYeNmo3dtPeLCX0dTmlStgBzlNp3amznM3gaHG5+5xzC49HF96hfShKDv+axVWU9FLzVWebvujHvolcDxS/nHhpoMuiLcmk2rmo3qED8lz+40P/jt/cMEcKxQL9+kBZQvbwfwNWr1RrDqDXNMA+9msPrdl2ogspwC1SPpYd7Zaw+B/nY5n/L4gaJYb+vHuoSD7QRMrb/jsG/yxeiFtnK/CRUuaMcnP4+nRKAct6pOJB824ICrG+VR3nvhW5C/mouTBs03CgEOHj0m8gjoDBRF80BeQkRe+exWxpKZRanY5rzr4auiI2UUIGxzbxxTnfEWwB5aCKgvMX8chNTtw8oP9Do9D9Fq2j0ZQNjwP/rFfIJ0HSS6KUinN+iH+7DvTTix9LsdHvC+yhiL8Ob6pxGmmK9xxd4ewM/n9Q5H/loRdOHiNvi2//FIGTijh9k43VeLlBGuYX3nDVMOBLlmZvG6ExhsN5D6iKVMbydJVVHpOlYlAVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRW/lTwBk9Qqip9vwXmidx1J4q0UiLhjCFWQ5ahZdx25ywkEfdJt5EtMpV0T?=
 =?us-ascii?Q?kU4wqp5nhXbVssi6blxvaLHblpvJdA6hHQyqMy8A8/paLQyL0J+dZVIcbF9J?=
 =?us-ascii?Q?p+oqS3kjFDMgY5ppse2S6OLNaRIvxJf0l29CCvGcy2vklZHihvd1GCwU0wdu?=
 =?us-ascii?Q?Jk7M/zvFNMtLNmy/pPzB1006RQZPH/jD+tq4Sxb3EvyBQER1dH3xCuqGxU62?=
 =?us-ascii?Q?eS2NKiFZCfI4l1PiAnZgdLzfwexKJEcN22KodePGq9pXTgdmacaYRqpjtjuK?=
 =?us-ascii?Q?jVbTh52tFBosUUuxjWazVYtlSWqssrp6w9wYcRK2Z4XdXf4inCveC2yFPkDt?=
 =?us-ascii?Q?oFZ9oGhh2v+ZPb/G9in0kliB+fdtWsTFHmEIqkTAZeRWBZ2BYDBYQI4A8Mwt?=
 =?us-ascii?Q?OezIoNWPNH8q30ZupgrDCF5sETLdttsFcgzRt9MrCHq0pY5tooCeavtKYlfi?=
 =?us-ascii?Q?GTGYssm9B7yV1XDpmhIZgttTgwAtYnY+n6Z7QobWC4nNXoVfT5JxcBJ/u1sO?=
 =?us-ascii?Q?SF5C3U70uLwX6swnr5fyQQG8+/FC1XFEwZjnybKqXRRw1/HEydnlHapef0O/?=
 =?us-ascii?Q?mh4yftYk1iDghnRotbIgA8WtetmV73kGrGhtYB2py+ppiv4lJEGOG30+Gzn8?=
 =?us-ascii?Q?XgzngXNGU3SfxRfXT9dExJL4poc/2w66QO5yFfW+8O5vlpTgNykKRqtY7u4v?=
 =?us-ascii?Q?WN8NDqZnv2/WWpZMpEVzxn+leCeeJTdERLO3zpce/OfhFUC0hv3j0J0EndSE?=
 =?us-ascii?Q?vbvaYPXIzEV+jEtaSFhtaq1pgRZmwBkkS7wIypKseZ1I4U2gdgbR85+ikyIR?=
 =?us-ascii?Q?1K4Q8vwM0tT8EUhnVYy1TZnHkhm7D5643Ych20mQPBhpjf+7Zff/uK/gG0bK?=
 =?us-ascii?Q?GWq9F9tRtIoEd/loSj8NqrY5KWIb+sWEPFGOuKyQImB8rMuAws0gelUvbb0j?=
 =?us-ascii?Q?/lOvd2kba0zomTY8uPzkmaIaEO3EjfrvE0Ps/uYVu1ZH9BUN0DmChFnwmhNl?=
 =?us-ascii?Q?qWayUiBUZ98Ns78C4iet7M/oiEaCqGfH4N6tvYtbYS2FAnOMJBURTfkZAYwW?=
 =?us-ascii?Q?ASmcomrRQV70N4o8EViHORutMTzBLdzn5HmqyXOboQl9Drlz1gCH5Bv3x9lp?=
 =?us-ascii?Q?15mRtpYgZy52lEtOgHEaBwLcKBtwAO6kbyjm+sVA0DzVD+aaGLA9H3jhDmN/?=
 =?us-ascii?Q?FmZJdUPyGKH+pqMrs4IH99gpl0yYtInmO5axA6nfxX4v/3rFh23BcMOMXewV?=
 =?us-ascii?Q?RGMkAsIZjab/drQy1fM65NgA62k9LNFeUYScvxWu3SiuIj/62P8mkuRzjInp?=
 =?us-ascii?Q?ffWZb+7Yffdueytc3vi/YzhZQTHmDgr/Bq84TX209TEkCs/q0VmuD5FwpwhD?=
 =?us-ascii?Q?1To4Co7ZgIIp7F6T5Ba7tkz00MjICFmMG+kK0Q5HsFmynB1HqJ8BLa9x5CZ0?=
 =?us-ascii?Q?m7wlUqZdGKC0wGSmV2Az1+qfnycg8fulGPhNn5oZuipIJr9YSy9IHXq1wrIc?=
 =?us-ascii?Q?zGnjvC/0AwESA9Gl1oISAvrHxRQOkDbjHoHggT88Bgwd0CLxMfZyejQo0Trs?=
 =?us-ascii?Q?Bnp1QDy9EuaLSXT6W9Dtk32NW7rHDGaM0W2LWDdbG3bIXBUsOEPTvB8x/WAY?=
 =?us-ascii?Q?9nFoqK7aRuj/anULWVc+b9LbPcRIF+O9gFqQRpiEON4vFVkzaUKdpWCy+9Ll?=
 =?us-ascii?Q?sCrDMEYKcNPwleyN+qbFeAtERJzJdfpt4afvahhH3ew5OMP2fInLcMME8Q+/?=
 =?us-ascii?Q?YJZ3VsnM+loxk32P2G+gZf5HsHc7wf4=3D?=
X-Exchange-RoutingPolicyChecked: rpvCSMnmYbD8zsYJxeVXDeJs2QsR3pfeiX0GhS6iR65jln1ATQs6HYruGxwuTvRjJRYiSFyRMw9d8zrZu2oYAEXRQy79VikpuvoVkgsjNd+FhVin52I9euyNP+4nx/ceywzdIQ3ZWzq8Pk5Lgl1AIEN1I+pfoSfmSej38RiA3uR5Ka59nXwESrySFoYUqLQkgqD/nbwIt4fkIZwUHEpH5rSqRivpOVg/1UGPez1xW6qqViMi1pMmBwToy9rFrT/D3z/ggExoR80KxjlZp4xLHMMzXri74lfEY1DLuqaHSSsdl84SH1KWftxXa9srr+OrkIgHo9CcBogRY6yDTnqiJg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e5c5eb-c75c-4be1-01c4-08df31165d9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:24.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRRzpPJxU/GN7y6M6D4CzH3XRtourTEMwJFF5u4dr3kspGDb1g63OtJa20ZC7nY7LhrtibPiw9H1Pbq6s2wnPjO5jbEqESbCllzi/aIv094=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR02MB11571
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7689 cx=c_pps
 a=eCb8aTw/9lghk0zZp47djg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=A7cMN0_0mIGH7w_oRUwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX510QG29kXGwb
 rQpc0t32h0AZ8qrVQvNCG5axrTsEvPh7JjZliKWfjOgCOrk4Kzo20+2oBZV7K0f5cWWEkRs6zp0
 X9Gu+WdGrHhr47TzHxHCmTvCluq1o/NPu3LYfKdlpyz5WEpjpdJQ7CM6fw2HiLIo2NZ7xv4t+Zr
 1WsUBaqh9VpqyAwqsWk0GYxsyr7zoWKE4Hrhe2I+5Z+4gYvSMYsbVQ0BE5EAaqf16zdgGkHKbRT
 m+ZDHhC4YkdYUbSteOLsiS8RikEM6GzUsfyB5cSr2Ix4LA5t0VvY0WAoa2efExpO5QfR7gYN00u
 PBqFuBBjY0VYomLRj/sxrpiMw6L2gGEFIa1K9FgIS9ZW8/n6dZ6xM037WIDZfa574qQsRJXMDRu
 YC0Ef4bS9/BAWB4ltDJw0FEw88KL5KkEb3gwJw7355W04fsaDjgEXIC4IW+gJLVfnNit/3d9mR0
 ASkk45A0ziu1sGRL+Hg==
X-Proofpoint-GUID: A6oeXPhS8Hp-e4DHaAks43hjKPntYwXd
X-Proofpoint-ORIG-GUID: A6oeXPhS8Hp-e4DHaAks43hjKPntYwXd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXwakXWpyQyOpa
 Zp4RFq9jmOTJ4nJmCqRJ/JfQxElXzy2om0wMkHRVcIn9/21JdDDj2QlZuF8RtzWTbeENeXcjo1v
 30soZ2peRX/Yh9oZT5VVpEfTLVUm0Ek=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The internal i8259 implementation has workaround logic for storing interrupt
statistics since these are currently recorded at the PIC level (i.e. for all
16 interrupt lines) whilst being stored in the master i8259 device which only
has 8 physical interrupt lines.

Move the get_statistics() implementation from the individual i8259 device to
the containing PIC device in preparation for removing this hack. Note that
this has a visible change to the "info pic" HMP monitor output since the named
device displayed by "info irq" is now the PIC and not the individual i8259:

Before (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 68
 4: 1
IRQ statistics for isa-i8259:
 0: 68
 4: 1

After (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 47
 4: 1
IRQ statistics for isa-i8259-pic:
 0: 47
 4: 1

Before (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 4: 1
IRQ statistics for kvm-i8259:
 4: 1

After (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 1: 3
 4: 1
IRQ statistics for kvm-i8259-pic:
 1: 3
 4: 1

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-26-mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  6 ++++++
 include/hw/isa/i8259_internal.h |  1 -
 hw/i386/kvm/i8259.c             |  7 +++++++
 hw/intc/i8259.c                 |  7 +++++++
 hw/intc/i8259_common.c          | 27 ++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 87ccd55a4d..d51a7fde32 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -1,6 +1,8 @@
 #ifndef HW_I8259_H
 #define HW_I8259_H
 
+#include "hw/intc/intc.h"
+
 /* i8259.c */
 
 typedef struct I8259State I8259State;
@@ -18,5 +20,9 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259State *s);
 int pic_read_irq(I8259State *s);
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs);
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index dd255fac24..2807409eff 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -26,7 +26,6 @@
 #define QEMU_I8259_INTERNAL_H
 
 #include "hw/isa/isa.h"
-#include "hw/intc/intc.h"
 #include "hw/intc/i8259.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 48282db58e..8cea5fb12b 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -223,9 +223,12 @@ static const Property kvm_i8259_pic_properties[] = {
 static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -246,6 +249,10 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_pic_class_init,
         .instance_init = kvm_i8259_pic_init,
         .instance_size = sizeof(KVMI8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index d713795ae0..c3a3199b8e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -540,9 +540,12 @@ static const Property i8259_pic_properties[] = {
 static void i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = i8259_pic_realize;
     device_class_set_props(dc, i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -563,6 +566,10 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init    = i8259_pic_class_init,
         .instance_init = i8259_pic_init,
         .instance_size = sizeof(I8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 5fa38fbc5f..684290fb2d 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -99,19 +99,28 @@ void i8259_stat_update_irq(int irq, int level)
     }
 }
 
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs)
+{
+    *irq_counts = irq_count;
+    *nb_irqs = ARRAY_SIZE(irq_count);
+
+    return true;
+}
+
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    /* No information for i8259-based PICs */
+    return;
+}
+
 static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
                                         uint64_t **irq_counts,
                                         unsigned int *nb_irqs)
 {
-    I8259CommonState *cs = I8259_COMMON(obj);
-
-    if (cs->master) {
-        *irq_counts = irq_count;
-        *nb_irqs = ARRAY_SIZE(irq_count);
-    } else {
-        *irq_counts = NULL;
-        *nb_irqs = 0;
-    }
+    /* No statistics for individual i8259s */
+    *nb_irqs = 0;
 
     return true;
 }
-- 
2.43.0


