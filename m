Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EaO-0001Ju-R8; Wed, 15 May 2024 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaM-0001Ji-0G
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:22 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaH-0007GI-LY
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqa5/4E85Cqrx9nR69XtHTaRh5vFgb4Q+SCxfoUbrXWw48HeiEZI5pRXMByD4828+jQ4c7Pp8AJyBO6Wa90UEIZfjqwZ74WapdFiFoivfF1bW9Q+dAG6MhMX1WXY9U9Y1QPZwEknKe7nB+8cJ9BcpQiLnWiuY/bD8SxGxwNd3IhctG+I5MAdaG6mxX5EDV2qmx8M+f3a0SOHpBYmAuRi4o7xdD1miUoXUqT4HqxjT6PBWGuNV4WzgkRPdb1wrokUH14p2MRc+WzsMbDVVDnSCItRqE7A2s4MpRYphIcYffb0JMxxerMHERSGQ6U/gU+g9CRB+UeO/T01RQTgW+hRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3v4MwIILt0hVpRGgXts2QqxePURMW4ShrS6/Ze6KEA=;
 b=Rlo7XbFdOs0wbkRtgL/9S5Lbfdpv1KOZW+0pyQQrmox45TQQfiY3tx3s0pfmLv1goGf8fpVcvMOO3ENKKIGXbC8wENeth9E5VdZ35S0oztsbPcuI3xNQZRmeK7dowkBsR/ybC7dvnVr59AwJb+bt1e3qz/CkP8aaGQeoyC9Co/saprEeUMgVTVncSd38p8o+ZBSF0YG1kTpeS52EmYl2bC8BdY+VyCg4ddhUplEqh95uGayDutdpdMCKoGyw1wmRY3WRESxt2pukigC2y75AxQ22Xnh2blf7rRxD54yGTZCBqwj1dLYF/rOCYXPdPaxz9Z33xtggWntxuBlVUpOscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3v4MwIILt0hVpRGgXts2QqxePURMW4ShrS6/Ze6KEA=;
 b=iKjp7w2ur88GY3tXLdgZ416Py1sLu62YCS78XTolFuJyHMK9WFzOvkTWEBdmREomTOyVpieE9bHSM2wjJJwUxvDfQw8nWtjcSm9300dt1e7AJK4Q1/DlwSHQnBSd9yuXkNQT6XSr2kPMJGjwuAtHhCgaNeMUOjT9aspY6nc2nrYSmo+OZvl6OlI1SyTujiCu8UVHdYjDfWxqlZ50nykKsfCILMFJewg0KT5ZdE0GRFU7ooNtRGbKHflpp/RSMGmsbI8sRV6GWMz7E+oUJ2nRouyiaqxczm2PyyLnL5lzSbIZj7dLNgKoasg8VCQCt3FNwNo5mRYEe53Oj1CrlyCEcw==
Received: from BL1PR13CA0147.namprd13.prod.outlook.com (2603:10b6:208:2bb::32)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 13:22:11 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::d0) by BL1PR13CA0147.outlook.office365.com
 (2603:10b6:208:2bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.9 via Frontend
 Transport; Wed, 15 May 2024 13:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 13:22:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 06:21:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 06:21:41 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 15 May 2024 06:21:39 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 0/4] qapi/vfio: Add VFIO migration QAPI event
Date: Wed, 15 May 2024 16:21:34 +0300
Message-ID: <20240515132138.4560-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b52d72-7019-44c1-59d0-08dc74e206ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHhCcXR2UmFBZXlOL1dNSHdzaWk1dVFzcGkvak5OWitkVzFINnFDSUdqZzAy?=
 =?utf-8?B?UHhmSENpbzkybExYT254VmZUZDFoMERtVDNIbXE5bzkzUUlHblNlckkwN3d1?=
 =?utf-8?B?aGxjeUp6OGk2dGpDSjAxbmg4QmxOZDdSVXo4MzYzY21jRUpoUndUbjE2K3pL?=
 =?utf-8?B?Vmd3UmxyZUttY0F4aXhiTHc1U1NyYklZMGhlZ2ZSUlVrQkZjSCt0azVRVnRB?=
 =?utf-8?B?cldKVVVkMk1mT09IYWpuYm1Kb0E5Q1dXaEhyMExjL0wzRzJvTjR6eHNFV1VR?=
 =?utf-8?B?WWFBQnNwU0o0ejJJSVhlcVBhSlRoeGVMUERGUzREbHZFZmZlRTlISWJiVTdS?=
 =?utf-8?B?U3ZONFlUd3pyQitLSVpSSmI2QTBKQVVCU2x6Qkt3U2I3WTA4SmxFOWx1b0ly?=
 =?utf-8?B?YWs0MWdRVk9TaFNsNjlEVndNSWNaQnh6RVV3WFZTQmNNRFEvbkVlUVJ1Nm9l?=
 =?utf-8?B?S2UzZVZESFRIeTA3OTJqSnRyQS9HVkdURWVIOWtGQ0xLTHhnNFRRZlJyNUFY?=
 =?utf-8?B?d0ZPbUtXNTJxamhNY041a05yNHB4bWtTbTFoN2U1NnFPbVNFMHY1ZDJoZzd3?=
 =?utf-8?B?N1dGUXRQMTBtRXlHY3VWdDNZYTVJeDB6b3IveThWRXBFNGJhdDR1TUs4VmFz?=
 =?utf-8?B?TGJENi9wWTlod1VMdW9xKzBkUnN2ODRId3kzQTFyak8yaUd3ZTZjcDhDejUw?=
 =?utf-8?B?YmVWMm55eldLNzNpdmVXMExKUGJ5TjRIY1gyUGwrTFJ0aVd2bFdxZm1mNzJJ?=
 =?utf-8?B?YVRrNGo3cGtOMFhsRGFXM25CZytsZHk0QldHamUyVHo4L0E1YmZtcjhHWkFo?=
 =?utf-8?B?YWFJWlNyQUpub3hjbDFEWis0dHFFK2JpbzVubmE2WnRTWGZFY2xLMkw0TDJt?=
 =?utf-8?B?ZkpXQ21ydnQzTGRYR0xpZGYzYjBwaEVZNnA2aFBocStDaG5rakswV1hJVTlX?=
 =?utf-8?B?cHpodDJvT3dyRjd5QjhWRk8zMlVCaytaekJRUWR0Tm0wWkdKOEtCaXliSS81?=
 =?utf-8?B?SWlGbmtjTE9nK3d6Y0NqRnU5d0kxeUNQZFp0UXFDQkZTdzZTeXB2SElaYSs5?=
 =?utf-8?B?RGtNcjRqbzFtWThwc3kwbnArSFBacEM2VHJzb3gxemhEdWhraGZ2eDFreTht?=
 =?utf-8?B?K0JDVDlRSUJNVWZid2NPOFVNb25KL1FMSjludjZoUU0rV1dVenFXaXpQTjFu?=
 =?utf-8?B?RWNWc3NxU2FtZzFTSUd3NUQwdXZhQ3hsVlhIVXovSVR2c0ZWbUlocGFobmd5?=
 =?utf-8?B?d3FpOGVrRnhIa0crOHluRVVxc2tIbGxnOFcvNUtTdFdRT0J2UnJoNnJOdkx5?=
 =?utf-8?B?aXJYblB1cUEwQ1p6L0RNZnZMT3pqcDdiQngrZUJWOWhMN3Z3OFpxT3VMR2M3?=
 =?utf-8?B?NW1zMFNucDNJSGttdmpsbkJZYnJWV2RXWnNpcWdXbS9SeW5mTHJEM1ZIb1hr?=
 =?utf-8?B?eXBJeDZ1aXBhc0dkM3JscU9XMHZtdlNha2RFMllhVlJJT0IrbVB2c3pJd0dC?=
 =?utf-8?B?ZDY1QXYweHBsYVMrSnd6NDZOTU5aU1hTL0F6TFVLNmJHN2NyaWIwUHJsWWpY?=
 =?utf-8?B?eDRtaUFlNjhMdlptT05lL2tiNFRCM0dvSjJFZEhuMVJMbk1UblV5ZE5pQk1x?=
 =?utf-8?B?Z1B2UnJNblcrbGE1VjlUWjJtaGZDV0tWejkyRWpidlFnK0NIUi84ZEpERC9S?=
 =?utf-8?B?VnFVQVM3OW85RXN6RUlOY3dDTTBpV3B5dXdUaUo4Z0RsdHlWanZkZkNxd0FE?=
 =?utf-8?B?UmsyRHQ5OU0vM1RaZmxjeEZxdXYxWktPUnA3bmlDcUt2WXBIeW9jZmdOUzIx?=
 =?utf-8?B?UVhvcFRFN3h1cVgvVkxYbk1mOW5OZWFhRXZvUGE3N2VsUTlEZDBwTXh2V21X?=
 =?utf-8?Q?szpQQv4Zwdfwm?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:22:10.0904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b52d72-7019-44c1-59d0-08dc74e206ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
Received-SPF: softfail client-ip=2a01:111:f403:240a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This series adds a new QAPI event for VFIO device migration state 
change. This event will be emitted when a VFIO device changes its
state, for example, during migration or when stopping/starting the
guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Feedback/comments are appreciated,

Thanks.

Changes from v2 [2]:
* Added assert for vbasedev->ops->vfio_get_object and obj. (Cedric)
* Renamed set_state() to vfio_migration_set_device_state(). (Cedric)
* Enhanced tracing of device state change. (Cedric)
* Added Cedric's R-b.

Changes from v1 [1]:
* Added more info to patch #1 commit mesasge. (Markus)
* Renamed VFIODeviceMigState to VfioMigrationState and
  VFIO_DEVICE_MIG_STATE_CHANGED to VFIO_MIGRATION. (Joao, Markus)
* Added qom-path and qdev id to VFIO_MIGRATION event data. (Markus)
* Handled no-op state transitions in vfio_migration_set_state().
  (Cedric)
* Added helper to set VFIO state and emit VFIO event. (Peter)

[1]
https://lore.kernel.org/qemu-devel/20240430051621.19597-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20240509090954.16447-1-avihaih@nvidia.com/

Avihai Horon (4):
  qapi/vfio: Add VFIO migration QAPI event
  vfio/migration: Emit VFIO migration QAPI event
  vfio/migration: Don't emit STOP_COPY VFIO migration QAPI event twice
  vfio/migration: Enhance VFIO migration state tracing

 MAINTAINERS                   |  1 +
 qapi/qapi-schema.json         |  1 +
 qapi/vfio.json                | 67 +++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 71 ++++++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |  2 +
 hw/vfio/trace-events          |  3 +-
 qapi/meson.build              |  1 +
 8 files changed, 141 insertions(+), 6 deletions(-)
 create mode 100644 qapi/vfio.json

-- 
2.26.3


