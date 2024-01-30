Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA69C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtRt-0005Qh-OT; Tue, 30 Jan 2024 14:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1rUtRs-0005Pj-1M; Tue, 30 Jan 2024 14:07:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1rUtRq-0000vA-4H; Tue, 30 Jan 2024 14:07:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UHf9rC032753; Tue, 30 Jan 2024 19:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=3B85ZnPcPQcG35SV9t3ENQhd60jk3dEKeutjtWpmZc4=;
 b=iTs9GSc5lx67YbB3oljssoxwkwSxfihFTks6/zEBwB2AA+qV7t4wlvdK9wjKFm6Uol5n
 lZjcUbIohMRQsaGQzB7reikScsUlm8xNXrnmaQmdLwgpcAniooowgBf5IWvA6irkSXMq
 Nkk7/4v09TKAaU1iyaWLwGpUEspjbkNbuZ8yEYHR4JbCbh4F+C/VBE5laGim8anEpMWw
 ZxcnKw2I6ewAg4xFtBfyNk7EqOi0Y9zr+ebxzMD7RCnVUxNXo5kvzFdG/KAYxPvC6RkM
 2lmi2mkeuDm+p2hu/TK97msTIyYSKnJ45q02RAIuBnLCscT0PvXA1xFbJugw/YPDbFqR WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseufr6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 19:07:01 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40UHuAX9014553; Tue, 30 Jan 2024 19:07:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr97nhxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 19:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwQj9fYMAfwN7TSS3oQM1Mr+s3GiTjDBOFLZPZSSC+eq+8M2+GRYbjThQFEv38j+Nu8/9HlEWeX0lbEh/aA7bY756nM9YRzZ4AIYzIBNp2RyOZ5LqW42vdMgx3xliepE9WD2wd9l2w9WtOSK5HugQJ3I88V3TNWQYBkEA1VHgx5Q7VbtW1XkPoiLUGBxf4+2r300VgvqKir9+EXqddXhQl3tQB9J5IvxozB4ghk3KEHmVIly0oqZHMMp+yAOpcnBvtdf+jEhTwaBh5GsT9ODPgeio4LgZ/400E4BssR23PVj3fMw8U6WKDs2AZat+P2elGVUcryi5WUn7QjBI3rDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B85ZnPcPQcG35SV9t3ENQhd60jk3dEKeutjtWpmZc4=;
 b=WZr1CaR85jD9ySPTEJOX27txRatZeZpymLKGDgdECnUPmRUeemUcbv7wr5dgr1+gzZLMXrQZKGtcOj09UAJcwKp4N1TJVgCOjwHMFHiTxepO18Uv35usdXjxyRpxZoPRNfvin99vC6NCcheBK2kfsADUT6oMXtI2rh5jcT6NzDio1RLnIa3lyvGcxCkIgcFPmgjSy7ZDUZAZe6KBLy+APGP5uZpdWG4FckU14P9nNhnjvcGICuHizL8jqnYP99SsOioMBDe4js7vSwStiSrwfgigE6YxEbiYSx7soZ+2okmV8LhEAcsuP852cAac2xjG86P5lllSeJZhpg2OSSi7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B85ZnPcPQcG35SV9t3ENQhd60jk3dEKeutjtWpmZc4=;
 b=PbDIrq90u9VLTpHR6yNG8Z7AMWUY/NLqvZzN1+k2s4h9xouWW3fUT60/WkacwKJT3DQccb7g6T8UCV3/r4Sor8mUAiabFKdM4L/jgfH+Yo3TbGIfQLHMJIpaq82UNaLvCzI8AxnInsrWot7q5ueLo/PW6xzysTdmjTWFZkzfjAo=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SA1PR10MB6469.namprd10.prod.outlook.com (2603:10b6:806:29d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 19:06:58 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a1c9:d6c1:b94a:595]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a1c9:d6c1:b94a:595%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:06:58 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: qemu-arm@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com, william.roche@oracle.com
Subject: [PATCH v1 1/1] migration: prevent migration when VM has poisoned
 memory
Date: Tue, 30 Jan 2024 19:06:40 +0000
Message-Id: <20240130190640.139364-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130190640.139364-1-william.roche@oracle.com>
References: <ZUwCZdZj-vZD1NJC@x1n>
 <20240130190640.139364-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SA1PR10MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea8170d-f46f-4ccd-a3a1-08dc21c6a1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlQJIEAlcQ8ohqhmo7s7VjY704jD7NHyHFow3Nm/NVeemrpJOqI5cSPvbgh8zaktle2u71YQDNKDlTeg0XtNUulVtzaWIlvoYmzEQgVWrxw1vqwvtq1FsLzlswGVDFXU5zG2vNpNj/Vdq674LUh17N4MkNIp0lVIorcF1q0PRJd0HrADr7VUL9PjdUZiSYzmkoU4Rt/qQDQLAHLH0+YJdICxYx4Ow2HKqkvWRY5ecG+7UsygRoXG+0v2g4iHxf8J/pHcZVZ6ceXuEVrpuL3rO4inmDiBpgnuJitM8RHC8VPx0GZwP6lKv87irykMOq0K33zW9EZWqaTEKoGCmxGE5EQoWhGIMT8HgxullCrg6uSaKwgBr1zzSRvuXPwJPpMS9wMEGFInFr3YAgOuwbt7gNzoAXtI5Qf7txBfFlz+97YAl6zRHA9qIOSw3Bb/SjIyxMhZyMvZAFAH1xFbg6IFw63k4JeWhBQESvhukBj6xTg7ItABbRKT6BT5ULkQCpLCnOX5yjnt9TMrLha4mdSX5liq+cpJlmI9d/PsYJsVlyVDduPxzrGUlaXr/AhoPFRz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2906002)(5660300002)(66556008)(6486002)(41300700001)(316002)(4326008)(66476007)(38100700002)(2616005)(1076003)(6512007)(26005)(8936002)(8676002)(107886003)(478600001)(66946007)(6666004)(6506007)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUIyjc6g5Q8fI34OzneFimBH9wifLfjhwR/cNE+1RBgKnwkl49S86ja+cOtq?=
 =?us-ascii?Q?N1nViF823b4FuP2SqoquJYRloFKRqLbCuP2qkHIXRKj/3ChwcojuVaF2arfV?=
 =?us-ascii?Q?JI84MeGOFVDMlimjtiihtvfultnTdMF7iV2eKFXUXLg/YFll0T+2ftpBfB16?=
 =?us-ascii?Q?tF3dG1ja5ts8hMIfcg2IP0Pc6+P1O82AMCIbZtUlNR8d2etNkxvS/GR3bCC2?=
 =?us-ascii?Q?Lrky/TvTVy3aoAMYoY6kGSnpfTYooxg60I3fG74uE6tnH1qrwrd/c+juhp/O?=
 =?us-ascii?Q?QdyIFukbaiOPHocTe02Wlv95yty9fq/sGRJVTNlYKvsnoL/Tw+719vt97oyO?=
 =?us-ascii?Q?6yMqEcAg9i6ghw2X6wE80iOy8BWUAYOKTHIH2JhLKbfyfvQfo69cy//kMYfu?=
 =?us-ascii?Q?OMTi5d5S67gs23b7/WqCbkzYB7giFMjJOeTv40xqnWaaDfHlA1VElBjyY7g8?=
 =?us-ascii?Q?xZJqICuRrVs5FOadyGJshMNN1Gj0W1q27YLduZ++J/0vPZeLhcHyL70kQFXO?=
 =?us-ascii?Q?RqvNohjra7khjLMRUucnnEhkkxskqIxeY7D11LBmNVV1ignuCDhw4y5h4xBD?=
 =?us-ascii?Q?7bap1ijzyPO8vm6aqr5q/onAdq16ypUdL3h6dOQW/4XY+spQzmgB7yZR/tWQ?=
 =?us-ascii?Q?+C/mgeAHA0/bNDYxwKy3SxtnZ/4QQRkM6GvkZ6Ihy7ADpoEsntVjBljppvrW?=
 =?us-ascii?Q?nDKve6r4eehVFNHqtUvTthuWpEc5eJu7ozQv/BVy0Y5JdbKrFXKp9ZlLztY0?=
 =?us-ascii?Q?I4yL1TRAXCKgUU37B28BI5pPzp6sDH966fYgRtEn6vtpedgnBy0SrU5VK0IT?=
 =?us-ascii?Q?yb+za0+eIVsHWBCjg7FMNawvu/euxPvRks+ve1R32s8no2NlTxY4qhUPdL62?=
 =?us-ascii?Q?os8zWNa7+U7R8IQVQXEHN9OdjjNQ4Nkb3hLO++KN07s+pmrzSpVZkVMdobpK?=
 =?us-ascii?Q?QL5umb/pDnA4YkVVPHLbQYhrf7ElXBp6gbAGXkm8F3F3mE1INH+J9kaZJZNW?=
 =?us-ascii?Q?4hJRA0kZMupa7oWUwRi1u1eDVUoOYQRd16E7WR7NR8kWrIO5Pre6ldJ5iYDs?=
 =?us-ascii?Q?f3u00Z5P6lmyuxyY7E+0qGB5+ubPPS+Z4VdxVpq4sAJp0szzWJnvTm6JmuGy?=
 =?us-ascii?Q?WueYYYSQPJWa7zMV2dVA4vbce3HPuSdZgmh8OO58k9uEo1vxr3SnCdX97fQv?=
 =?us-ascii?Q?WgBGaw9cQWiiEdAsTvaW4HLpYYSPm6nYdi+PcijkcAi877PNQ2pD3thQTV6V?=
 =?us-ascii?Q?6DrXT33gWtOiX5O7wBdhYL2A1uQtaBbmBTOvtceXp+rNChykuupULs1RHsWS?=
 =?us-ascii?Q?4NdPaIpn8jcuQjUUp5EDp1P9sQDuPvVHqatPIkCJmkbGByCgN+SHmy2tqpaK?=
 =?us-ascii?Q?0cPG6U5nPlIJpRDPK3XGWJpt5R4tzq/aE8fdDsOGZxkdjbGhnQFk4H8q5Je0?=
 =?us-ascii?Q?6GR/Wj/b8u2vlJRxB6zy45GmH6Lc0y9SYCxm3JvnxalqPBCb2y4XmGNetHJy?=
 =?us-ascii?Q?IyjwDHbcE23x/skxNPlYzWgSD4g+CWh8XHwlOzfgVOKDUtkvos/RlvMMqq9f?=
 =?us-ascii?Q?nJ+m/9BntwiM348haVtEgFeKkuiKeXvTnpXuaOLNqzNAU+MNbzVudPOQ2GNl?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m1epKzf1hQ97hertN1Xy1nBNjIK9pVSDLer+/v5139Qv3WdJejyYrMaFYTu/YRqdoxj2Ot0/1TdejL1vOLhcISHz5kZBxFJJmD/kril+oZvWW9xJ0qrush0PdfAMKbMTyZWLZlkRaINC5Co5qceoc6lstDCe72fL4Q00vj23TPSGDKBP2fypTA3LnyBWJrQT1pqycPyIhacOurw8J6IWEykPySFcN0qN6v7wcoOke2tGhL1+LzhyfxwbfotU8AhcOXYYgAyrroHBJLGQ119japPMyI6VEL8xey4QiBn8lmyuWYE7kOjrN3pGU2e5/VoR7L4PPwt5qrvrgLgUIRR5l/y2FyaoK2rPkH/ev8G89v/ek98Mis82lQdCxGpwiUXojQR09lRSzr+8AZ7GyvlUFhlMJZMZMCqYFJUIZsDEKnSwjVrVRqNKmwMbUnjmgtF7i0O33OVXXFc9oq23FxV1FYRz13KuAzKt8X5O8CSBSo7gd0JbkPzEWSrPvnn1+VwriuSXTU4IdDSwnPJ2FfKi/DZ43TuTHJp170XVLWFXfSEFP7Y4FZvkathEm9Gy4rDpO2RcL0yyPLJbpK1QzdgB5Dz3AQUWAxVzh8hzeOfN3F4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea8170d-f46f-4ccd-a3a1-08dc21c6a1b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:06:58.1388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKVDZy6JxIav2AKgYmwRavLEhc3KovKCm++RMlmcsD1EUv+1nXHtKKr4QQWhqVP8UdHVGWNR8s++EdfozTsQtkyhRAPPxRwmxrDiiQDsg5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300141
X-Proofpoint-ORIG-GUID: RzHAKuqJU1joK779Oo-kA_6S6TfXFcOH
X-Proofpoint-GUID: RzHAKuqJU1joK779Oo-kA_6S6TfXFcOH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A memory page poisoned from the hypervisor level is no longer readable.
The migration of a VM will crash Qemu when it tries to read the
memory address space and stumbles on the poisoned page with a similar
stack trace:

Program terminated with signal SIGBUS, Bus error.
#0  _mm256_loadu_si256
#1  buffer_zero_avx2
#2  select_accel_fn
#3  buffer_is_zero
#4  save_zero_page
#5  ram_save_target_page_legacy
#6  ram_save_host_page
#7  ram_find_and_save_block
#8  ram_save_iterate
#9  qemu_savevm_state_iterate
#10 migration_iteration_run
#11 migration_thread
#12 qemu_thread_start

To avoid this VM crash during the migration, prevent the migration
when a known hardware poison exists on the VM.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c    | 10 ++++++++++
 accel/stubs/kvm-stub.c |  5 +++++
 include/sysemu/kvm.h   |  6 ++++++
 migration/migration.c  |  7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 49e755ec4a..a8cecd040e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1119,6 +1119,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
+/*
+ * We track the poisoned pages to be able to:
+ * - replace them on VM reset
+ * - block a migration for a VM with a poisoned page
+ */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
     QLIST_ENTRY(HWPoisonPage) list;
@@ -1152,6 +1157,11 @@ void kvm_hwpoison_page_add(ram_addr_t ram_addr)
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
+bool kvm_hwpoisoned_mem(void)
+{
+    return !QLIST_EMPTY(&hwpoison_page_list);
+}
+
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 1b37d9a302..ca38172884 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -124,3 +124,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_mem(void)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d614878164..fad9a7e8ff 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -538,4 +538,10 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+/**
+ * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
+ * reported for the VM.
+ */
+bool kvm_hwpoisoned_mem(void);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index d5f705ceef..b574e66f7b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -67,6 +67,7 @@
 #include "options.h"
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
+#include "sysemu/kvm.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -1906,6 +1907,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (kvm_hwpoisoned_mem()) {
+        error_setg(errp, "Can't migrate this vm with hardware poisoned memory, "
+                   "please reboot the vm and try again");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
-- 
2.39.3


