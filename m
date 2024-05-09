Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F5C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 02:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4tTH-0002sM-IF; Wed, 08 May 2024 22:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s4tTC-0002rS-GY
 for qemu-devel@nongnu.org; Wed, 08 May 2024 22:25:20 -0400
Received: from mail-psaapc01on2126.outbound.protection.outlook.com
 ([40.107.255.126] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s4tT9-0006Lb-B8
 for qemu-devel@nongnu.org; Wed, 08 May 2024 22:25:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN57T7pHwVtuK05zsbEl3ZF6YeZ/ayOvO9iXvijz+YJbfOsRnbgHtieClJWvOeB8SGWlH+9k9B8JeJ4MM95139ovYaymX5WYfDdHWV6D8mm3msdjH20YMU9PL63NyjHv9AUu9ABP+/Zt/BefpTsIrKGaHwJbMHXClFDzqOUm4dZ2VWKzwjK543AMJY1r1OrSd1eT/d4ZoQlbc3ZMWXk3DqqfdWg/xMa9yXoMeiJBIa0mCitqJ5yolw/r6IsLGOQRF2xIEcxDfGb7363S8SfvKXalvm31Mh1oeeEg/I0g44BbpXTr46OIniPe/Xp1SvR8V5XnP33NlWUemN14cpTC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9YjQQ2jsR1ffKYGmKO9j+g4OnOqFuQRnwnx30RvFcM=;
 b=FQE8Fc+B9N4tPC70c10qGaw8MxIfP3XqRn5VIvjrljTyRtQThWWXjTNc41vqEK4PvR0LIh6O9E/vXwUv4gR11PF+9I8X7EpTjl3+p7Um0twFEdEyL652De4bt+kyZ6hhLuG6d1qEaofhg35HqZNOsSj2KyGnPjCyQdUxq9txT7vpQMWCtiasYNf6A28gJhYTiM1ZbllEyDXM5oBYzX3AzKCbGIF/zb3qnAq7CBq9AJnJ3fzyIWsM3T12ihpSa9/IwvW4QNvDma2Uo/9a8qeHu/N6Bs8I55xfXsLStVCWgDwh3v+xPz47QROBUlyTiqOXlR8t5xo08XG019Q+wlv3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9YjQQ2jsR1ffKYGmKO9j+g4OnOqFuQRnwnx30RvFcM=;
 b=mCdCcZVbtQi4n6QcUQRkTbrWE292A4RnZlhIdYsImh0PDACIFTIgKP7BoOORBJihnCDmqpwmOGIapw3IN4B/jmzS9lHvq4xpZDYtsC6HOTtg19zjikDJUBy4YuU5fZcDkhTtIIr3tIyLwloFdvjzkM/5ST48KZVcjKiR88N0TotAYH0LKtJR3D2Z1eFrJb1P7yGv/J63591i2vKude0ein6B8Eelh/2wV7RhFjtQYZhvRxrlEPW7AFycKW0OM5DjUTGRZEYNXKIUH9YLGH2EQJHEuEeovEn5pVkhftLgS96UB5ave16Ss/YDzkth+JPyY1uOHuGWqifc1h4nP/RrUA==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KL1PR0601MB5509.apcprd06.prod.outlook.com (2603:1096:820:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 02:20:01 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 02:20:01 +0000
From: Wafer <wafer@jaguarmicro.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin
 <eperezma@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Angus Chen <angus.chen@jaguarmicro.com>, Lei Yang
 <leiyang@redhat.com>
Subject: RE: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Topic: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Index: AQHalFY2N838jhUkKUe7MN2Lx45RabGNZYeAgABa14CAAH/7YA==
Date: Thu, 9 May 2024 02:20:01 +0000
Message-ID: <PUZPR06MB47138D7EAFA0BB70931D4832A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
 <CAJaqyWcgMFJL8y7wXwFZa6dny34WKDRH+tuEaCdP8oFN4Qf5fQ@mail.gmail.com>
 <20240508141920-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240508141920-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|KL1PR0601MB5509:EE_
x-ms-office365-filtering-correlation-id: 5616d949-882a-4c8b-0cdc-08dc6fce880b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TFc3ZThWaHVTNC9CVlM0ckhTNU5iNVpzdWNEc2J3WS9CWUx0N21VMU1GRDhI?=
 =?utf-8?B?QTVhNndWenVtM2RBYmY3TzJscXRmQU1keUpJWDFpQzlTaStpVERJVllvM1ls?=
 =?utf-8?B?dFRMNVR5aGN1c2cvdHpJNFdRYlQ4TjI4UDhLTDBpekh1QXFyOWRiZ1FtQmt1?=
 =?utf-8?B?T2hZYXpUd2IwOEpVYlQyOFNDUUVaeE45RnBGSnBFTjdiUXJ0ci8zaThqZkpO?=
 =?utf-8?B?cjVZejNwSXFqZmw0aTVxN3YyRG1udUlYTFh6VkJqZXhtSWJIa2dHUUhQaXY1?=
 =?utf-8?B?Skt0dkw4ZHBLTGhmTGRXNEZUcG5lYlNvZlhJZHVLb1NMNHVkbE9tTzJoS1Zo?=
 =?utf-8?B?K0tZd0VCc3lYVzhEbld6MDJGenpnWC9GTEptelpFU3JnUTdSYUVQVlZpNmlK?=
 =?utf-8?B?Yk1lczFMQUdKZE5XaDBXQlJBNTlubjlISUpUV0wzSFdFTWs0cEUrVnE5R2hj?=
 =?utf-8?B?NXNVYkJmcjJzN0FXMXZUbWtmeEZSQVQ3NVdPYkxLd2xRRUFlWlJZakVhQjNN?=
 =?utf-8?B?N3hFTkEzbmtRK0FMWGx6Vk1EbUwrWHJSZjZQTW8vWXJqNk5NVkoxbkN4WTRw?=
 =?utf-8?B?YzBCMnV1cEJYYjRsTW91REROYjNHYUcrK3YvdTVTZmc0VW8xd0xCK2xieVVu?=
 =?utf-8?B?TlF2bUNyNlpBM0hLeGx0U1hXa2RiTjN0YlQ4b2NsV1VJbE8vQjIxVzFIT1V6?=
 =?utf-8?B?d3VxUEZiSTE5czVyTDUrZElEakR0ankzam5Za3JRMzJLMjdFQjZrVkRpWUcz?=
 =?utf-8?B?RlVoa1lWdGxNUUZDNHdTTThWaHk5VTI3a21vdGR4UkZUOWp3TTRud0VhdnJX?=
 =?utf-8?B?UlBZek9ya1ZIUnIwbEJmU2xLNkYzWGVLY2JUK0c5dWNHclBMUXJWU0xpVmdI?=
 =?utf-8?B?RkpQa0VHK0IyYTBIanpDeVdoV2hiWEd4b3YwS3RtMnViM1lYaUovL25teG0v?=
 =?utf-8?B?VWpYWndPZ2pwRDU1cC9wY0tLalo4eGVBK3JUNDZobm9sR2l5cmxSQVFFaVM1?=
 =?utf-8?B?aW1RdGNNN2Y3YVljTGoxUzhDV3MveVZzVTdTdVF6ZDV2WnBxZG9BQ3V6VmUx?=
 =?utf-8?B?anluVEhNK1JMb1dVOC9YOTRyKzNMY252enRxNTBsT3FMcUlYR00vOUhxUjVl?=
 =?utf-8?B?amF1RWFzeCtrVW9iMCtOQjFQMDV6UG5zOWZEMHNTMEpxYzY3QUdxYjZ6MXJo?=
 =?utf-8?B?SmlMSUtrOTJsdm5JR2w0d25TdUlpekI4ZXFhYktkcVRsa0pTRFRnVkljZGZU?=
 =?utf-8?B?aVpmY3F1S1ZmZjRzMGowcm45WWNJZE16cERtRG1TYXlRTnRWYjlNZDJQcFZS?=
 =?utf-8?B?dkN5MGxNTHFZalFPZk91Mm4yYll4T1FjbS9WMHdmZW9XUy93bFR4ZW5XSmxF?=
 =?utf-8?B?eU1tMERhenZQenRoMEhNYXdFSzlKNTkwM1pMR09KZzhNdnpwb2JQRk5ESU5X?=
 =?utf-8?B?K3gxdFo3R0hDYjNzMzN0SmY1UUFUN2xyWm92YTBSSzhrdG5DV2xjUTVjQUpH?=
 =?utf-8?B?V0oxZXNXREFGTTA3L0VkeXpkNmxrQTNzUDlBZHJLU1VPc3FLd3BHbXNZcC90?=
 =?utf-8?B?di9jVkE1VmNnMG9UbVdENkVCYzF6NWFOb1VOMlNVaFFiRWNlZWw0K29yRUI4?=
 =?utf-8?B?a1JwQzB5N25wVnh5ZEYwVjFFbjlKWkNTZTVYdFViNDRsc05RTlM3b2RwN3o1?=
 =?utf-8?B?Uzh2SXhHamh1eTgxbkJIVEhzcndTOUpRTVg4UkQrbFoxckszSjByRHZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWU5SWJvYkN3R1dUYkd4ejBXd0x3cmMvS2NIbUd1amJmeGo3SzR5ZGozdEZy?=
 =?utf-8?B?bFJ3WktWQVpuNWlWZGxPenFFSE96MzU5MTJxTkZJaFdWOE5UTG95QjNMWG5l?=
 =?utf-8?B?UHNkbEd2aVlEN1kwY3F5d3ZoM1V5SHdhNW1BU1FZM2FmdndjOFB5Q2tDbVZM?=
 =?utf-8?B?bnI0cXYyb1pZTVlqa2kwMzRPUmM2RFlsNUFnbGNxbDFtK1hqS0pPU0pVTTZK?=
 =?utf-8?B?UGVKeWxJMitQQmVDZStWSTRwVFlGVU5xcnpmTjRMYUFHMEd1YVN1WTBFWnUz?=
 =?utf-8?B?VlZRdzV4ZmE0SmQrVHFnV29pZFIvUXlINUlXUkdkeWVxN25UUGxZKzRiL0h4?=
 =?utf-8?B?UnlBUi91dlNCNTFmZm1uYm5zTnAvUmZ1U1p0cm13bHJHOVk1ckMwaEw5Sk9z?=
 =?utf-8?B?RHVuNUtzTUFzdzUwWE12dWVnZlI4N3JyZkZqb1lQVFRkVnBMQkxHeUpGVEIz?=
 =?utf-8?B?RzRTd0tJUHU4L0FYUG9ISnRmTUdOanU3d3VjY2FXYlJlZFhwVXc2dHVhVFEz?=
 =?utf-8?B?SXpUVk40a1dGMGx0WXJScTk3ZTUzWGwybEtXeE5ZTzkxSFNMbGhKZUpUZzI3?=
 =?utf-8?B?bkZFNmgzNzdHMjFpSnBIbjVqK0JKbVJKdzhNSVd2RUdwbjZUVlU1UkQ0cVRR?=
 =?utf-8?B?emJGYmNlZGZNZUNDeVNJcURiZEVvUkFreHVJWU1tYU83TVVjcm1xQUpMYWpM?=
 =?utf-8?B?Y0JobGIwUVIvYkJrUkxOdlRvalhHU004bzVhLzE1K3I4cFJVd3dTV1hSblNE?=
 =?utf-8?B?ZHZ6bUZjVzU2T2dlcy8vRnJtVnBSZTFxZjNQS3BQTldVU1lYZWdRbjJUbHZZ?=
 =?utf-8?B?UG8xcDUrSU9qTzgyWlZKTVE4WkZhOFpUdkx4MVZoYmtmdnpFTW9XM0l0dkph?=
 =?utf-8?B?M3lTQnBGR0dOTm1aRmNpVkZ2NUJSWWRjRERYeDNxMWZIcTVHUUs2VHEwVmg2?=
 =?utf-8?B?NDJ3RUQ0YmRlZ0c0MkVvZ2VBUnc1MmJyM2J3VFZZcEdiMjJvU21HNDVVSU5R?=
 =?utf-8?B?bGNUbEl2WThTZ2lBdENwMkNSeUxIQWorQmlVWWxUQnBlSmdaUGRsSnU1V0N0?=
 =?utf-8?B?Z2lPK09lRGpuMUtMNkxMOXlhbUNXYWN0QWdhMTRRbGtYOTNPOVlZNCtpUmVJ?=
 =?utf-8?B?ZEdFSEZiYWxYOEV3REFWSnNrbGpKc3dWM1dzdVd4cHplZWRQajhoMHFsL1lW?=
 =?utf-8?B?eFI1S2tlU2x5UWJOVU53Z3VISE9oaExJOHF6cEh4WHkvMkR5UDkvTEV5Rk45?=
 =?utf-8?B?Wk40UFhNTU0wYUxxZU9ndFdMNVZRUWsvenZTM2NKb2Z6cFdsVVM5MzIyeHRN?=
 =?utf-8?B?V3kyQjBHbDhJK0thUUpqbXgxUldNeFNLa3ZnSnJOZ0ZSZFpFcmlFRlhTSU1J?=
 =?utf-8?B?UWdyVm5mNUU2TkdyQU9mOEQ0Y2FRRlhORk8xWmVrYWRISExwcWE0dU9nRUVJ?=
 =?utf-8?B?aFBGVFozN3RVandtUmNHWTVvYStJTVcwL2FHamlPWm5zbEVIR1F3Mmp3TXcz?=
 =?utf-8?B?R1lsQUt1VUhiS2FYSHFXblN4YlB4emdZRUdkNloyTXJSRTNqckFYZmd0ditx?=
 =?utf-8?B?Q0xyS0MxR1VsZS95cnFRR0tTN1crVXhMU1pkcVoyRUFQSzBla05TUW1GRG0v?=
 =?utf-8?B?elJyQlp4Z3FQbHBQV3ZnOWVYOU1vUmJSMlpSYUk1UzNSaCtrZmNubTBKZity?=
 =?utf-8?B?RTl2blVoNkxRSEpXTFJLS0xIWnM2dXlWUnF4MmUxQTdsNW8yUEJhMGMvUFEv?=
 =?utf-8?B?L0F3bmZTbWpMVHQrMzRqQ2wwR2xScDRTc3UvS0F0cFc5L21XSmYwZzhxdVRJ?=
 =?utf-8?B?QlZ0UTBRc2FodUdiNmVKcTFINlI2QlF5cnE2UCtGazN4cGU0UHV6eklrWnJi?=
 =?utf-8?B?VG5LNFpERVdiU3JMbHlSaHlzcWgxc3IrU3pDdHNmN2Y2a3cvUTFBcHM4RHdk?=
 =?utf-8?B?MWNTT0JWWWovUXZ6bVVXa3p6cDVCWjNFSVFwQ3pHS1JzWEZjMldCVkdoZWgx?=
 =?utf-8?B?eHkyNTAwNUJ6blkwZmFBK0tnRXFuVmhWSFpCdE9oUmxVclVDaVlVNW03SW5C?=
 =?utf-8?B?OUZxZnNrbFhpZjFOaHZ2di9DWG51dFowVXhLOGRlKzdScXM4OUE4RFhSUk9p?=
 =?utf-8?Q?g6ON+XBRoKxeHs5gveoD663P1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5616d949-882a-4c8b-0cdc-08dc6fce880b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 02:20:01.5650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egN6PllN5Zy7TavzB8wlCfQ8xW94sFfv2/Al3HFoO0/s7mxxVAw6G/8C72FY88cQLNZ+LauL6UPFg9OZjYsUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5509
Received-SPF: pass client-ip=40.107.255.126;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIFRodSwgTWF5LCAyMDI0IGF0IDI6MjHigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4NCj4gT24gV2VkLCBNYXkgMDgsIDIwMjQgYXQgMDI6NTY6
MTFQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6DQo+ID4gT24gTW9uLCBBcHIg
MjIsIDIwMjQgYXQgMzo0MeKAr0FNIFdhZmVyIDx3YWZlckBqYWd1YXJtaWNyby5jb20+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IFRoZSB2aXJ0aW8tMS4zIHNwZWNpZmljYXRpb24NCj4gPiA+IDxodHRw
czovL2RvY3Mub2FzaXMtb3Blbi5vcmcvdmlydGlvL3ZpcnRpby92MS4zL3ZpcnRpby12MS4zLmh0
bWw+IHdyaXRlczoNCj4gPiA+IDIuOC42IE5leHQgRmxhZzogRGVzY3JpcHRvciBDaGFpbmluZw0K
PiA+ID4gICAgICAgQnVmZmVyIElEIGlzIGluY2x1ZGVkIGluIHRoZSBsYXN0IGRlc2NyaXB0b3Ig
aW4gdGhlIGxpc3QuDQo+ID4gPg0KPiA+ID4gSWYgdGhlIGZlYXR1cmUgKF9GX0lORElSRUNUX0RF
U0MpIGhhcyBiZWVuIG5lZ290aWF0ZWQsIGluc3RhbGwgb25seQ0KPiA+ID4gb25lIGRlc2NyaXB0
b3IgaW4gdGhlIHZpcnRxdWV1ZS4NCj4gPiA+IFRoZXJlZm9yIHRoZSBidWZmZXIgaWQgc2hvdWxk
IGJlIG9idGFpbmVkIGZyb20gdGhlIGZpcnN0IGRlc2NyaXB0b3IuDQo+ID4gPg0KPiA+ID4gSW4g
ZGVzY3JpcHRvciBjaGFpbmluZyBzY2VuYXJpb3MsIHRoZSBidWZmZXIgaWQgc2hvdWxkIGJlIG9i
dGFpbmVkDQo+ID4gPiBmcm9tIHRoZSBsYXN0IGRlc2NyaXB0b3IuDQo+ID4gPg0KPiA+DQo+ID4g
VGhpcyBpcyBhY3R1YWxseSB0cmlja2llci4gV2hpbGUgaXQgaXMgdHJ1ZSB0aGUgc3RhbmRhcmQg
bWFuZGF0ZXMgaXQsDQo+ID4gYm90aCBsaW51eCB2aXJ0aW9fcmluZyBkcml2ZXIgYW5kIFFFTVUg
dHJ1c3RzIHRoZSBJRCB3aWxsIGJlIHRoZSBmaXJzdA0KPiA+IGRlc2NyaXB0b3Igb2YgdGhlIGNo
YWluLiBEb2VzIG1lcmdpbmcgdGhpcyBjaGFuZ2UgaW4gUUVNVSB3aXRob3V0DQo+ID4gbWVyZ2lu
ZyB0aGUgY29ycmVzcG9uZGluZyBvbmUgaW4gdGhlIGxpbnV4IGtlcm5lbCBicmVhayB0aGluZ3M/
IE9yIGFtDQo+ID4gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gPg0KDQpUaGUgbGludXggdmlydGlv
X3JpbmcgZHJpdmVyIHNldCB0aGUgYnVmZmVyIGlkIGludG8gYWxsIHRoZSBkZXNjcmlwdG9ycyBv
ZiB0aGUgY2hhaW4uDQoNClNvIEJhZCB0aGluZ3MgY2FuJ3QgaGFwcGVuLCB3aXRoIHRoaXMgcGF0
Y2gsIHRoZSBMaW51eCBWaXJ0SU8gZHJpdmVyIGNhbiB3b3JrIHByb3Blcmx5LiANCg0KSSBoYXZl
IHRlc3RlZCBpdC4NCg0KPiA+IElmIGl0IGJyZWFrcyBJIGd1ZXNzIHRoaXMgcmVxdWlyZXMgbW9y
ZSB0aGlua2luZy4gSSBkaWRuJ3QgY2hlY2sgRFBESywNCj4gPiBuZWl0aGVyIGFzIGRyaXZlciBu
b3IgYXMgdmhvc3QtdXNlciBkZXZpY2UuDQo+ID4NCj4gPiBUaGFua3MhDQo+IA0KPiBJIHRoaW5r
IHRoYXQgaWYgdGhlIGRyaXZlciBpcyBvdXQgb2Ygc3BlYyB3ZSBzaG91bGQgZm9yIHN0YXJ0ZXJz
IGZpeCBpdCBBU0FQLg0KDQpUaGUgbGludXggZHJpdmVyIGlzIHdpdGhpbiBzcGVjLg0KDQo+IA0K
PiA+ID4gRml4ZXM6IDg2MDQ0YjI0ZTggKCJ2aXJ0aW86IGJhc2ljIHBhY2tlZCB2aXJ0cXVldWUg
c3VwcG9ydCIpDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2FmZXIgPHdhZmVyQGphZ3Vh
cm1pY3JvLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGh3L3ZpcnRpby92aXJ0aW8uYyB8IDUgKysr
KysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8uYyBiL2h3L3ZpcnRpby92aXJ0aW8uYyBpbmRl
eA0KPiA+ID4gODcxNjc0ZjliZS4uZjY1ZDRiNDE2MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L3Zp
cnRpby92aXJ0aW8uYw0KPiA+ID4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby5jDQo+ID4gPiBAQCAt
MTczOSw2ICsxNzM5LDExIEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVldWVfcGFja2VkX3BvcChWaXJ0
UXVldWUNCj4gKnZxLCBzaXplX3Qgc3opDQo+ID4gPiAgICAgICAgICAgICAgZ290byBlcnJfdW5k
b19tYXA7DQo+ID4gPiAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICAgICAgaWYgKGRlc2Nf
Y2FjaGUgIT0gJmluZGlyZWN0X2Rlc2NfY2FjaGUpIHsNCj4gPiA+ICsgICAgICAgICAgICAvKiBC
dWZmZXIgSUQgaXMgaW5jbHVkZWQgaW4gdGhlIGxhc3QgZGVzY3JpcHRvciBpbiB0aGUgbGlzdC4g
Ki8NCj4gPiA+ICsgICAgICAgICAgICBpZCA9IGRlc2MuaWQ7DQo+ID4gPiArICAgICAgICB9DQo+
ID4gPiArDQo+ID4gPiAgICAgICAgICByYyA9IHZpcnRxdWV1ZV9wYWNrZWRfcmVhZF9uZXh0X2Rl
c2ModnEsICZkZXNjLCBkZXNjX2NhY2hlLCBtYXgsDQo+ICZpLA0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NfY2FjaGUgPT0NCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5kaXJlY3RfZGVz
Y19jYWNoZSk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNy4wDQo+ID4gPg0KDQo=

