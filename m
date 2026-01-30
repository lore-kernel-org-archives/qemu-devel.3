Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CBAD49C90
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 09:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlkxt-0000Jk-Qy; Fri, 30 Jan 2026 04:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vlkxs-0000J3-6g
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 04:38:56 -0500
Received: from mail-westusazon11012070.outbound.protection.outlook.com
 ([52.101.43.70] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vlkxq-0003Tl-ET
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 04:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCO4O6M723/FeXCdtyIXhTCMwV+yeYSVJ4ijNVnFlnHjLDoaJsf9pUld0mrpn/XiunFsuvnJ8eGQgM2OcssnkE3xiQFU9plPXewG7ZPQQgPihmkP1105t7g1s587L48inpzkhf+qw6MJnWNjp7q7I7Pcoai0tlug496Gbiwyx34Q44/0Z5Qyp/l7szk7UBR69Z751aCiHeRujAG7cLsrio5AjXYaXes34zZgNSRBc3s5mlAybkcjKwnztiw71ZBAxrBkYrP+6ir6WsWC5tFsSbXVIzqiekH6NnJ8lwFMnfi46CxVrTjp/eK3gEF2xzW1qvCQJ2iBi8qyXnLHEQI8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvw38nO8Bs9DqU1R8P4HsebHLwNKftwkR7qTSb6f49w=;
 b=xMq3jEudKhH7/dVvnI0J2LwOO3EfbEhL6TlsH2V4j17J6JqKd0jF76paKwBDLvms1v52vD+FvLDer3L8+dYosVLIxZx+1a/tYaCXPBG+dHfrKgEBiMByMRnlBm9VcEjvJUdBJWr/vTCzIIQ8S95p4mvDcZiE+6mqhrlOUi6LimsWEW0Pj68yzE+hY61THbWrOiJNZgFYfx/ICHZ3LoipBYrPtDcQvmqm3KxWbRHrrqml+2qvgHDnvgGUOpj0GX5xmKNHQRtq0jmc4PyGs6m+AI36kjBUZ4i+hDdKsqUa1V61lMfv7sVNOAKbceLZBmGXTg7n8V6nhj/R3IM7B7QUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvw38nO8Bs9DqU1R8P4HsebHLwNKftwkR7qTSb6f49w=;
 b=bWxw2r5/YfTa4Xm14x5r6JbF5sVuUYmEakqXhP9oNtfUXMzUnfNH9CPyGohHBefutxIrriwperlJLnj0pKhIx44d3j62gLaOMd8Qbw/+opSjr6+klDiO2t0P636CiTRIncTKo7ps7yUDbtKqdru9XqwfOHUlpuqiWQUKyvH0ZlVhzXwl7C/5Ecr17dcLdfWHuWHfP7o8jgZidG88Mkv0NbDWMSHIxCn7cnfOed+/HMeEzNeGZn8j++4MB7TDBe4R6LCi3qSG8pQf3xxZ7uousjaXBTIqsh3gI/xyLKY0+7efoexIs+5gdB8DgnUaw+JrLnVEzlzfxfU77KT2pZD+oA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 09:33:45 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:33:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "clg@redhat.com" <clg@redhat.com>
CC: Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)"
 <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Topic: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Index: AQHckZ3nrHQ4F/cjtkOQhcOTrPnznbVqcsAw
Date: Fri, 30 Jan 2026 09:33:44 +0000
Message-ID: <CH3PR12MB7548F8415F5FF9EED90FA376AB9FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260130040649.42485-1-ankita@nvidia.com>
 <20260130040649.42485-2-ankita@nvidia.com>
In-Reply-To: <20260130040649.42485-2-ankita@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB5734:EE_
x-ms-office365-filtering-correlation-id: c427115f-a79a-4676-81cb-08de5fe2a95e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hx0kFALQ+f6O1tSvmusDRYtzfUBQ8jy8Gs4Rh9K98NT+VSTCmzXwChQbrplt?=
 =?us-ascii?Q?hlWg6kR6G2+DPw+2tU7aOgxrSITEW0g2/ZixrWmOkJZEbp/IVKwhN1bi9wZ1?=
 =?us-ascii?Q?Pw5VLnYDvd497nZwnsPlCOquVTMA+7ywHwaJeSz3p+Y2RuQSgPbOEBqhQBRn?=
 =?us-ascii?Q?0K5ttEuaZaPf83xNE5W3QOe/fPWocAR0OTx053iDGLbDr8EzTJMfb5X7YDbo?=
 =?us-ascii?Q?DqDSZjkAnq4rfi/3WWb34K4zQ+luTohEm6btsGatOObZAHt8Rwa0Esy8H3UE?=
 =?us-ascii?Q?MgL/7nbd97Wf0yEDI5gmT3ocEEufRpabCI/sm9OXvTzVyaCBnuM8WJn9vW4p?=
 =?us-ascii?Q?wN/cWdziHCY1kxesMkwUzj0NnU7Ud+myUnKebDiUPlr6zVU8NWHgl1EjJyXB?=
 =?us-ascii?Q?2VD3gonazbVyjMXKqz3Q4FnBzA3Vn5LNrm2tgLZo7lwxaRtk8FBe6zB1zrcR?=
 =?us-ascii?Q?+w6Sm/iI8ad5Mpn6eYMRW8mpStftNnhm7n8sYoyyDK/ngl8IgVAdFPGgJu2a?=
 =?us-ascii?Q?ndKtykW3Qt/4FkwslkAcvNAjpnocHuBpJoQt9OuUUjZbTrCj4SZRqiCo2s0z?=
 =?us-ascii?Q?mJfG24Hv8vf8ghE+Yjo8n3DB2J3prpEi6F7psPe4s4uR7KlVub7YWnNgjEZK?=
 =?us-ascii?Q?gVmfWO5UqVICTRXvRRsUXkf6dMtAvYq9jSS1Chn8FLXcjAaQ2aY22NIML12x?=
 =?us-ascii?Q?10mnC6Nfruvzqmhge8e499uZUXU9mfs44qZIorJEqykD4X428mjhZ0epXuLi?=
 =?us-ascii?Q?+wDfe6xfqiH4ZQN8YiwodyXDn9BYz8dsOHh3pdc/Vo6HygcPDBxByqaLmxy1?=
 =?us-ascii?Q?R9JemZD6Q8CfmbhxhWZTrmC1VG07+ZLYF37GKqCXZ8RJIwhPPZpIM6SRgtFS?=
 =?us-ascii?Q?w+kzCkkOm0gxaz1LyZ9zEWIjL3//U3iXk+47bglCBmdC/4g8ffNkG+1vjpox?=
 =?us-ascii?Q?afmTmKyqwAkDR+pOe3VsgAAuWBPfUEWXwzjLrd0KZBCbK6fW5aH+gtTucaw7?=
 =?us-ascii?Q?XuT6kbuk1xZ9s7G+UMEKEHpA3ITAoDh1+v3ETiiQZnsrzr2QlT13y4KKVGSG?=
 =?us-ascii?Q?Tv8sbfzGaqGU0zOJEDkNz/PXCcWRjZqDc24FEErIgXAuTS3esowwON8SOXA0?=
 =?us-ascii?Q?Np8xdde3tj60wiBcJePGJlT07kjAeG+B+XBo92USwOrxQGvr0Doq7fbQ/9I1?=
 =?us-ascii?Q?OU87pPWmOM6UAryvk29B/M1CrxIm3Xojis2f/wGiomv/QO8jBppkM2DdyNVv?=
 =?us-ascii?Q?Ja8nAysHW9p5+hG7AdV73CcR8ryCuWP5Gp8VfeU8p+YM7SUrMPNyZFkcwVl5?=
 =?us-ascii?Q?6F7IRa9UR2oDPjsRTsE7UkhIx/MamY0zI+WsVpm3hUj/T8J3o5KXV3U76x6i?=
 =?us-ascii?Q?IOtEAQfhhYvNgwGWsU0Q28zYIrP/aw4uwXq17XRv/tlAt+2RnK/M9X78gxl0?=
 =?us-ascii?Q?IPqbclqhDygxK1L3YGkoVgPAaT4lgeLS78T1B/D5ZPbws13MxqtYOtZHKhcd?=
 =?us-ascii?Q?kFrytEw0nCveZpqKtQV82E6MZrXPndEXFRGQS1VBggIUnMVANIstx5rn40FV?=
 =?us-ascii?Q?R1O8Abca/hX0WaQdgszPKps861FLTHw+Qe82P2tR3D60RZ7rz7mcsM79Qf6c?=
 =?us-ascii?Q?wkda5QoIhQBQ0P5tac4d3Ak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8ZpsMYst755dKQ33N+UAh1O2G0pVWXsw5F0ObAZRm90iGHRwCd6seK45atW?=
 =?us-ascii?Q?T7PgbFBHInuGwlR4/+IhL0PNgDivszQ9LxSGguM5+kQ7aH7N9L/jrVdYJ3r8?=
 =?us-ascii?Q?Q23CLXqs/o+ZLwQrxG8CvefoFXx79d4knh1iim5LCkcCedVzTRHJ5zg7FFAx?=
 =?us-ascii?Q?WHNmfXmPoCKcc9kRVKvkMQ9De47WFtd1h4eulN4r1bPoGGnBgPtM1ysMeC/r?=
 =?us-ascii?Q?BtILXRonUrqqzB0IrkI5hhOTqvmLRb9yTVnTFJDbMR7CEFenyI/btnTyQvOe?=
 =?us-ascii?Q?3ckleLbnkATcwqwQZQqFkxsceXeeWvP81gZk3uu3S5si5VPcQsrFgmpIAOxW?=
 =?us-ascii?Q?aEIIJcdbWLYWMlIazZ0gTsg7rfg0Jf6+4ZzxagxSzmSyM5UWUXCpk7+TB2eG?=
 =?us-ascii?Q?tsNMqveNRtzCnIDB+bU3dW7w0RAvQ0iYSSFldrOpKYD+Y9OLre4byAn8g447?=
 =?us-ascii?Q?4nGKNnObcl71d5Fol9N8epFuoopDEsZWVkIL20pMOW5HfRiUssTpUigcNIyv?=
 =?us-ascii?Q?cZ/gI5/AoFLDaacmdSUZCQZdQoeHLU6HZ7R/QuQmOc4AmP+jR+xLZgXs5TIm?=
 =?us-ascii?Q?Cj9e+FS5C5+xo8qt+/ZhKmQhAESNseCXPwWLVZF7qx7/sr6nMAhEAnvy7qXH?=
 =?us-ascii?Q?vGmt8YoNwhbXp5AIZlnhPIgSEU3GF/lJ6/bHK8bPar7ImCSW21mUeahKshjC?=
 =?us-ascii?Q?SRlcdAyRC0BiwdIIQW+XxKoNcoEOl5fuQQPcRl8/mMEGLaLInCbuziQzzsu9?=
 =?us-ascii?Q?lGcJ2cmu7NRqcqSCjByxNQjxExeCHw+o1J1RGAbYX3/celsirA3iSrB5OvZJ?=
 =?us-ascii?Q?wCIisp/nXb5Jvzv6rPUKhA5C+xRC+JIo5X8/Dxxk5+9Trb5Fo0rLcXHCsDXK?=
 =?us-ascii?Q?jdfS4g7tzhz0oF082zey6Dnm3xdo0aVhWsHTNGdb5RZmLXUnICSTOSmFzJiz?=
 =?us-ascii?Q?3yLnUdWfcxX4+9WyM5Mv+57pkRKYdwgO/B9Pqw1HO1LtypaxtypZKq+cLc0v?=
 =?us-ascii?Q?AdUecQDUCyGiF6YWYel76Xy5cjLo+Jj+2shUL5KP+T/T/pvk4m5jtZlzGXzQ?=
 =?us-ascii?Q?mLu2uPzCoa/BMijQVmV+Y1LCnBmtyvhRnthWcln2Fou80/XE6LVtW9rR58wu?=
 =?us-ascii?Q?pVtT5r76lfnTLsbWrqU8m3ta/kSaNXFW6996fhXzjgYFYx6aSATZWMpyyDdd?=
 =?us-ascii?Q?zCXX0gpn3G1zPHFyhDGZfv7Xz18ez8TLWWm2qWZm+iQWNXfzKOxqES+TJ20t?=
 =?us-ascii?Q?5Tdughp5AHz1NGJpOt/r/oel5LlhRgoCcr3EoyDrxOnLuMre9BEah5d35oZ5?=
 =?us-ascii?Q?USYtMgfFEW3Cw4ulHIVw8MT4cscfCKOTLwN6/TrLRmapFybbXk4aFHjqF8Ov?=
 =?us-ascii?Q?mz+tm8i2viKdl9jmZGGnnTjviKVrNC8W+m6Lqzie5vz8ooXt4hjgHZUEIzoP?=
 =?us-ascii?Q?JOtBThF/iPBlXMU+E7w/F+BTQFjs+6HZ3lRMPaA9f6qLNztPiB5walhaCqNN?=
 =?us-ascii?Q?e3K+s7Rtne3BuIcg1LFZm6/Uz+DaQ8HCAxCle/NsnU162xOUZPPBVJRNpWGD?=
 =?us-ascii?Q?KYaMg5fhZKq8yGNH9kfDNeM2XSMVEJWnF9mooXe7MMNrpAN1rkFUZzpt8cRc?=
 =?us-ascii?Q?+MBQaiIRanft6qq5hpj0sDEaK2pvUjUBeoLKHlKa8aYCzl2sUbdQ3t6cxKoW?=
 =?us-ascii?Q?9YY1JDNaUVdBKhONF+EeUJqLbTMd+pTIHBJ3gmZQCcf1Fln0CG/2ihOjflUq?=
 =?us-ascii?Q?U3aeaVI2Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c427115f-a79a-4676-81cb-08de5fe2a95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 09:33:44.1211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkGKVoYLHO3csv8jVBWP+p3SRxpBUYI7cWGmM0mLI2udztvVVmccmUrVUKnbrDbvOW3eOzD7w05KzYTXBRcqHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
Received-SPF: permerror client-ip=52.101.43.70;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Ankit Agrawal <ankita@nvidia.com>
> Sent: 30 January 2026 04:07
> To: Ankit Agrawal <ankita@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>;
> Jason Gunthorpe <jgg@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; alex@shazbot.org; clg@redhat.com
> Cc: Aniket Agashe <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti
> Wankhede <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU)
> <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; qemu-
> devel@nongnu.org
> Subject: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
> offset
>=20
> From: Ankit Agrawal <ankita@nvidia.com>
>=20
> Sort sparse mmap regions by offset during region setup to ensure
> predictable mapping order, avoid overlaps and a proper handling
> of the gaps between sub-regions.
>=20
> Add validation to detect overlapping sparse regions early during
> setup before any mapping operations begin.
>=20
> The sorting is performed on the subregions ranges during
> vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
> mapping code can rely on subregions being in ascending offset order.
>=20
> This is preparatory work for alignment adjustments needed to support
> hugepfnmap on systems where device memory (e.g., Grace-based systems)
> may have non-power-of-2 sizes.
>=20
> cc: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ab39d77574..7622ae5683 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops =3D {
>      },
>  };
>=20
> +static int vfio_mmap_compare_offset(const void *a, const void *b)
> +{
> +    const VFIOMmap *mmap_a =3D a;
> +    const VFIOMmap *mmap_b =3D b;
> +
> +    if (mmap_a->offset < mmap_b->offset) {
> +        return -1;
> +    } else if (mmap_a->offset > mmap_b->offset) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                            struct vfio_region_info *info)
>  {
> @@ -182,6 +195,34 @@ static int
> vfio_setup_region_sparse_mmaps(VFIORegion *region,
>      region->nr_mmaps =3D j;
>      region->mmaps =3D g_realloc(region->mmaps, j * sizeof(VFIOMmap));
>=20
> +    /*
> +     * Sort sparse mmaps by offset to ensure proper handling of gaps
> +     * and predictable mapping order in vfio_region_mmap().
> +     */
> +    if (region->nr_mmaps > 1) {
> +        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
> +              vfio_mmap_compare_offset);
> +
> +        /*
> +         * Validate that sparse regions dont overlap after sorting.
> +         */
> +        for (i =3D 1; i < region->nr_mmaps; i++) {
> +            off_t prev_end =3D region->mmaps[i - 1].offset +
> +                             region->mmaps[i - 1].size;
> +            if (prev_end > region->mmaps[i].offset) {
> +                error_report("%s: overlapping sparse mmap regions detect=
ed "
> +                             "in region %d: [0x%lx-0x%lx] overlaps with =
[0x%lx-0x%lx]",
> +                             __func__, region->nr, region->mmaps[i - 1].=
offset,
> +                             prev_end - 1, region->mmaps[i].offset,
> +                             region->mmaps[i].offset + region->mmaps[i].=
size - 1);
> +                g_free(region->mmaps);
> +                region->mmaps =3D NULL;
> +                region->nr_mmaps =3D 0;
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>=20
> @@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice
> *vbasedev, VFIORegion *region,
>=20
>              ret =3D vfio_setup_region_sparse_mmaps(region, info);
>=20
> -            if (ret) {
> +            if (ret =3D=3D -ENODEV) {
>                  region->nr_mmaps =3D 1;
>                  region->mmaps =3D g_new0(VFIOMmap, region->nr_mmaps);
>                  region->mmaps[0].offset =3D 0;
>                  region->mmaps[0].size =3D region->size;
> +            } else {
> +                return ret;
>              }

Is this now returns without the trace_xxx , right?

With that fixed:
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

>          }
>      }
> --
> 2.34.1


