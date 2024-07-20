Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D8EC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 04:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV1Vl-0008EF-NX; Sat, 20 Jul 2024 00:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV1Vi-0008DL-F1
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 00:15:54 -0400
Received: from mail-sgaapc01olkn2047.outbound.protection.outlook.com
 ([40.92.53.47] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV1Vh-0000mz-1V
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 00:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xls3mX89bmAL4VCxI1mIlx3ulYN0wIBZNJ34iYh0aAILbr4of9Y6YlL6rROB6BVrbZ/F97LjZ2xQulrAnR9M9hf9Prs4cy6nRoFQDcUR8hPr3DdB1xEGtG+d4bKJ89ptY4+5eS8ZqBF7IXNhrJoQbbGyAkXAJEAyMVpWVo2D1Fu9kdWZ7BSBhJnMvWuPZdIGmr5BbpWWT7AQnmmVWLwY09CZvI+DSKQGauC3e7zowL3ytb9k4eELM3S6VD7MF1TENTYoOZ+yuqEz5evbv6UDw97itVWnvHHElzwpZgo5T1+c9GeqB03u0ThkLwpNTCO0XAKko4BKwU/s/SWYgOSGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtJ3hrhvmZvN1N/j3WdRYYTZXeEbYwHGCnwBG/VXjnc=;
 b=hDxqIlwIhDDSGDHncbVunFQXLixwRkv0+bVolubXb/flH0mmV1f/yWOEPbGkaSb8D6QJYOk/bvA7D3y9jFmaiCrtC3GXiObSyenUzGJUVnzkVwLq2PCNTm1IS4BdGnzmxNjKFvB5c0Y0ZkGBcOdUXCStcJ1byRcnn0FyIkavI7z5zbT8/IEc+xI5ElCSImE86SDtHEofyy9BuenVulHxyJjmbMmSl1dENs92aFpO7OfPM0ZhztCE5Kl5U7vjpgKadR0W1EplP6OqQ+Yz6Ql5+T4aZf7FbT43/+NldQUPUuJ7SWi81FlBSIMXcOia0AkUMp9RfXBGTjXMwxnppZuQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtJ3hrhvmZvN1N/j3WdRYYTZXeEbYwHGCnwBG/VXjnc=;
 b=ql2D04HuG9Cm5Bs3MjJh/8X6Ok12S7OxX3zl/DGiBn4z2gEvCBPZsFiB1eLyU7tOXJBX7c02qGaCbHvAUCBEghP0EuOCvlGb/9KjdmrK/qUevTkCY+JBWtIa50GYA0YdhW9lXRB+ecFaGirkSBCuQr9/1C4HvEjQ+ACgl7ikXLxi95usn9TBkzEjrdLxZMuIjWMB7ockpBjEujrM0Swh5njMJ/GqIkSKEZ2KmVBuXE/mVsWrQ3DpkEc1cIHwx0vZpjQMj4sYPNtYpuOca2PvUXgi/lhgpDKVWZcfsEL0st2nBXmuzN5TJ03g63lHDqFp7rY8pJhWudfvJg7gzor/Iw==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by TYZPR01MB5691.apcprd01.prod.exchangelabs.com
 (2603:1096:400:420::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sat, 20 Jul
 2024 04:10:43 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%7]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 04:10:43 +0000
From: TaiseiIto <taisei1212@outlook.jp>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	pbonzini@redhat.com,
	TaiseiIto <taisei1212@outlook.jp>
Subject: [PING][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I/O
 APIC
Date: Sat, 20 Jul 2024 04:10:23 +0000
Message-ID: <TY0PR0101MB4285F854DABE77D5E1529819A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [UK4h7cImombejqCfSOrI4FS7s9dIk/IN]
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11)
X-Microsoft-Original-Message-ID: <20240720041023.835-1-taisei1212@outlook.jp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4285:EE_|TYZPR01MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d69922-856b-4642-127b-08dca871ec8b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: JdJ89B21u0WbabZoqVSDicUpFXUrrPof8iv9zgt4jOODW76S19LQ65McHauRXP5ktzBWhKq2ZVvfhNx/nyK3FxhMXjKj4I1y1RQVmi0CENppxhmVd2NscyzLxzp0vJkwtksPUczC/sztkv6xCJ+Rqz33OHcv4NdfXvOeLR2oE3jcbEPNszP2oCasjRXw6CgtLWLCGBAdn/2NYDCrUCR2fVhpSk3R8SAQB2uXD5s0bIFTLxZy+sYy2x4lkCH7mwPlPS4vfdODNuatfyAyYlldKw3xNbXTDgiTiEhMk5I1QPannS4sNgt6qz/aUm6yFW4xR4NlPAqdHPIA38eU0+0qdAj2bZO0CHH6ugayr1wtqnvfvC5tVCsvMZj/P+YAZQfHbeKUKWn6U+sEeacOeJcBgkTRcIMSpwuyF8wowjK/4qK6h6YF/tzmI9/XCkGKhKEFlnu82r3dOtXShIKoJLxbRmIxPtFqsQ1jfsHeyFReo17IaJeQ8n67B7cHDS0nKIj3NwQe+03oOfd73hKE992K6Gw450efkaILnf13kLzi0aWvUpQKQE1G22I2R3pTqTJh9xo2VL87pzDGgfwH/OuqtCoOUoZfFeV+PIaBmQ3Hf6FYYln0rBYOTy7YqiYp0PubgR1l8s/412L+fxISTvGkbeD/GWsc739u80bploydywk9D0Oz12phLO+jcstqjADTUh8YWQz4XLEW+ej4iUZbWhMtmks+WyzfgTADXSfaDsw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9AYj9IPbquRde/WsfEcPTHZzUm/4zDrYUrC/d9SR+GOwvQy+IUtnN9AMVTWZ?=
 =?us-ascii?Q?dq9UgiwqjBUZcwr0HvPBRJtbgm9kpjPWeEoE1lKot/LG1zo8g686MBIOILAe?=
 =?us-ascii?Q?4wQkYwg6Ej09zC91sRU9o/vy+MzwM7fzWBFVJtru1kpPs2m6hGnqFzcpYVBF?=
 =?us-ascii?Q?uf98ObtCm2cqUymSxjzu7ASwZ92l0+SLvtG6nsfeZQxhx5hS5Z5MdAlcdWOg?=
 =?us-ascii?Q?f+8iOLTLgQWrKVUK4sYz9s5ALNRy1GcJmQb1o1Au1l2bnNsoiDWpNmI/nOl2?=
 =?us-ascii?Q?M6hz5dUm0Bf72q4IN/C5Izu9QXM6QDRJN5D6Tjfc4cr49c31uIWI6PkSqy4f?=
 =?us-ascii?Q?W18FbI/LRE1Qs32YlQ6NRTpxen0RTSn01b9jcXdfoebvFKOcjUIU+GlyrMi/?=
 =?us-ascii?Q?u1t7bqRXHikVvSnO4dJWbaxGJUk1oJYZNJ8CmDLy05YrOoBNqQ5Ve2oAIge4?=
 =?us-ascii?Q?yN0uIrpDJdfy2d83VFiHvfZDxGU0dXL86rGwAqjewvBnqTijjdgreAhHQ/1x?=
 =?us-ascii?Q?ea1otwg9iTqcrSs20ZB4DQgmyOuQiIBu6y6P4AYtwCsQlGqGFF7+YedpP1Zd?=
 =?us-ascii?Q?T1pALcZyuSdnpU5PA6DKxPZdytRVBJ2H/zOLQfP3R+45gtec2G6sYaQn99Iu?=
 =?us-ascii?Q?pXjFVvcHJUqFztJEPRIkyZ43bZtDpouIRfaf3B+TwsE41j8N4pM9755hTVms?=
 =?us-ascii?Q?6Xvv7LAQx+oX9LMfKb5MrVoXgUddgPOk5fwGmcozxn9HyBewU+ldPVa999Km?=
 =?us-ascii?Q?kPYAvVGqcP+uT/26aWeU1dIH/0gbMmPkN7G7/xBmOujkxym0EuXHkLasidtL?=
 =?us-ascii?Q?g2Rte0lzh0GtITZGM2d8AilH3zbiJALfPA9MIcGRPo23UPl7goCGLbg/VLnA?=
 =?us-ascii?Q?/C6p8YBkJHKbAd05n3qR8EVgt9JgBAPT4WYd3l2enLNhtBm+W2vs5TlDH7jR?=
 =?us-ascii?Q?Df6eRyJokXceLWgFr4GmG1hLTlYFhrnkUQfOD7sLGkZl6XSbU7bN2w1LSipc?=
 =?us-ascii?Q?Hglwj3gr1phl0D+tnwk29Vz0MRBZbQUOx47fyTEezyHU7fkrpKTvtZB04vr3?=
 =?us-ascii?Q?q+kdSaEbzkgUMJGpcZhoR9+93lnxi98XAA1mBMADovXxAxO/xjiRUdvK+Kd1?=
 =?us-ascii?Q?26H8TeaurMUV3rdNHaIo0YQ3Slqud3yvOXHtvFg5PZZ0APZGOfNGb7JtTdhn?=
 =?us-ascii?Q?Zzu7a9Fm24OeHxg5AgC0OWJbxF07JUXTLoCdNKVoP7/LpymHD6/G5pMAtfg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d69922-856b-4642-127b-08dca871ec8b
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 04:10:43.5508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5691
Received-SPF: pass client-ip=40.92.53.47; envelope-from=taisei1212@outlook.jp;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

This is a ping for the patch below.

https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/


