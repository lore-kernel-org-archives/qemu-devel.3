Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B408F3C992
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutqH-000773-EN; Tue, 24 Feb 2026 09:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vutqF-00076h-Hc
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:56:51 -0500
Received: from mail-westus2azon11012028.outbound.protection.outlook.com
 ([52.101.48.28] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vutqD-0004b7-HA
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBqgvoRUAc7NwqX8edzOQ1cG4fJFtpmDw1NbEaQjJmt07o25mPSOQfaeFjq2x7yM/sA0IJ+xesDhv/Whbm4zJV8zjdgU/YfKtTIJBiCronMxqmKx5aQJ8QxI9R0tgfnLY2LUoepefMNz9THZbOLVeS+RnXcAcM0cNbH3MuptY5rwl8llDzRbdU0bX2O84F/kVmr8HlIb4yn2G6f3ExIH33rpObkKy4MC8Cc3kvzoI3awRjZMV6RA3XI5G/4+9CXxl07+yROrHBLW+/99u8n2PrUM950EJ/uMk0Lhx9QQgkjmlPfP2dAZVN5Obt50Awy3U8KQ7vkI6h4NreIWWlZdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdssmh6FeuvhLsm5NLze1ChLk+QZzP2uBRqHyNCXSRY=;
 b=vxlAKbsGKXXvOu2ZYwwzX9xtumo/lRsAevJIbwvg0u+JFVXZNES1ZUQGnI2TTQ1ogTQEB2by4mFgA12zIidohGP9C0fc02wmAInc4D5oUhiujZ+qC3GA2DwmXGWu8gYKJzmQzt7zEKtJ3AqY5SBEOt3699VwRLV1ol9Q5WxirNjoR3uMrOhatsYwhIRI2iN7cRkAGCw6rBd3hxpf2KxVSpWyxCRW4NkTXPZE9UVhdtj+9r0Ne8DcQ5V1jlp7OIe/Oruhmm0EJdlX241p3olt2Thp5AzQ4TfjQhhpdnzAPzYNpnQSiAWKs79R+/KhzzUH2IpPlYe+eIR47Zy5ZEf0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdssmh6FeuvhLsm5NLze1ChLk+QZzP2uBRqHyNCXSRY=;
 b=osuk4EY/+tFZZK4E+kIoUzVxYhBv2dbcgi2mpOll6/88jJCpFRW84mLCId1SwlxtF03TRwU6qF3YedoWuMmpiUeZvI1AX+NTueIV2TBpYakpmb+SDqD5G4pOw1Rv3za4+Wg6wFCPw4eWp4rWiKbvn6y6FOtj4ZEztWLp0jafkCuSTFBXyB/8CyIK7zw4boG5eiQOv3meYLLoZIJzXxDre50wFfuOFo73QjknvX8ktk5h3ppKSWK3K/kxyH5JQnZJwcSXRTVLvYPSji6VxUQfDEggfe1lD43vQXvkhNff4qSg4aYIVZ5nJFdaXvCOniyhij5fRqtr2Qrj9/jxzFuX2Q==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:51:42 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:51:42 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, Shameer Kolothum
 Thodi <skolothumtho@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Thread-Topic: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Thread-Index: AQHco6Ae/zryn4xgMk+gEkicK+J837WP5KQAgAAFPZaAACDLgIAAGNMAgAG+fwCAAALoAIAAC4SAgAABXio=
Date: Tue, 24 Feb 2026 14:51:42 +0000
Message-ID: <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo> <20260223111302.00000081@huawei.com>
 <aZ2sylCydE9Js1ec@nvidia.com> <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
In-Reply-To: <aZ2449e8ucB8e3AJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DS0PR12MB999081:EE_
x-ms-office365-filtering-correlation-id: 9affa599-d418-4012-1f50-08de73b43904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?X+kftB4pQBrSTsBM3KU7S22YrzS5OOZAq4eHNessncu4BRGpPehmcNHgrE?=
 =?iso-8859-1?Q?TprKpZ0hVD2pJm/w0wh3PZhA/ChDUmXOpYEwQYGx76LPGALWFqAIX9kQkm?=
 =?iso-8859-1?Q?tFgAjfu2wOb23jEIsrGcLYONgj2u0gVIHtplU3GCuA1qnmfnbCJUTM8H/0?=
 =?iso-8859-1?Q?Vd9PPs0fci72YutuKHoJq0dctau6H5VXzRKMsDikLoRwe41Ke35L7gWJTa?=
 =?iso-8859-1?Q?OsnvYFfT1q0b1s/EVs4ADt1LZ9stEuGgetHg+2rxIfJ28IfYqIGIn+mh7o?=
 =?iso-8859-1?Q?ktu9fcpoEdmHaVXf8R8hiBJ2b0ixej030mDpUwH/BHyzYjbk14BHhAmeEZ?=
 =?iso-8859-1?Q?nJDlMzwZ0KagATTw5Say5KMA+opJUisSv23p7bGIi4kS6THYldBxBxbAbm?=
 =?iso-8859-1?Q?uoowZKAT20uI7RKSG1PpQ4bJ5lm6fbBuetrpplNx2uP8cvX7P56LD5iuDU?=
 =?iso-8859-1?Q?afsgm99gpJA8aqDOa5rSP48Z8obYSkm3NgxksVh/eJT9PZclAQf5xV0INA?=
 =?iso-8859-1?Q?N7qfK/6+IEcICQQmt7hY0L6z+/lbe+bPvkhHTLGLwp6/N4W7jPcXGu3g6r?=
 =?iso-8859-1?Q?8W81IUxNsV6vHA9lD6WHpbV2YUvybD6yUvkSgNCf9HgriK8PSkGAnHqDAg?=
 =?iso-8859-1?Q?qBOxkXcw7BX+GCJ8hG98v8IkOy1UKuOhVyVGUCokPelAYjxlTqlo2NGIk2?=
 =?iso-8859-1?Q?XO5N95aZEXES89llRIslJ8EBhY+4gX5pORpm5Nsp6Wc2K5QSu4pAcNeqnP?=
 =?iso-8859-1?Q?jTGTszlYeKw+CzwhpbAsRP2X6kZiAD6zyFH5tFpiZAmvKvsDY2rav0pv0g?=
 =?iso-8859-1?Q?8yTNgUUYSjhkd5vKIWMX2YiE29vbo+f68Kl+QqE3ziHjpbxRUrELQfBvon?=
 =?iso-8859-1?Q?Ns9NjwaXf+UVFEnMof7c/zHtcTrxbqn/QmkLOQbGXiKReMgp+qxlOMnilR?=
 =?iso-8859-1?Q?sm+UGHlODWLrI9ChXLM8nvJ0Z16P09ISAI7yd+90CwG9LZXq7i9GpQj45B?=
 =?iso-8859-1?Q?E4kZE/rv9f5xHdjPk6kUwUKPHyXfus+Udg1EG19tuDYY3pKdsYqUsmNGZa?=
 =?iso-8859-1?Q?y0uW2ThHv2Ic//Djz6s6RqxL5lyc3C7cxA5FOEhC/stquJE8FiiliMD9+9?=
 =?iso-8859-1?Q?UcP+0WrgkoebftTNxGB9TEoGDsyAKxQ9gbqtaBL7ls/AnoAKYjeooSbidO?=
 =?iso-8859-1?Q?sKa5f3B46mlxVZG9zBq7MNh7BMMX5B3ksxln47e+ggT8Ol9bqmHB41MLvp?=
 =?iso-8859-1?Q?x/ScMJ7jNpc8V9Ix2WaNlEd1VbmUjcpRO7u0UvNdg80ser6vTD2s+HEz8G?=
 =?iso-8859-1?Q?4v9VcGri9x5E5+pFJuSMisZfEHk7bNm+oZl+8dWuqA8QvLuDUZ4lZ7n7hz?=
 =?iso-8859-1?Q?bXvrfR6Ecg9MN9c0M3YGp+2RNNvvSIbISiFi2K+SDAUOfFiUtBw4ttdjvF?=
 =?iso-8859-1?Q?ky33kMAzG2fE41PkuW5h2Iw95gCa82KsPjDsPDX8PpqhGnywAlnru7mR3E?=
 =?iso-8859-1?Q?vNVHmzod4MlpzOCO8DOyjR9YLt3Wz1O1eWWSsk4catM7Eo84z8i+3N09+8?=
 =?iso-8859-1?Q?ZEVymhCt5epiLDLZz4AIhjQMv9SMhxpWk6lQ2ClTJ+/oXTPknRnCpj90sl?=
 =?iso-8859-1?Q?vl7P2S3TpepMlsThe06Pmudjswata5ydCD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yBdOdtxhmsNYGPXPISKiMARlgP5EsWI7bQR4GmrZCYa0V51iZxHbvD8I6J?=
 =?iso-8859-1?Q?YAL0qIwAXSkWtUW9Fud8aciyp/nLmKQurdM3C08tWbeH6hvgdwCd++hG+f?=
 =?iso-8859-1?Q?ihCM8+3y00XdS2d1OrQngy978FXtw57KV1EuWqfzVLJ2V90tJpqn/pkny2?=
 =?iso-8859-1?Q?+Z1E6vCUd0tEbtN1QHE5ujlxao61OgPF1IgmTgZSfMMOhc9NqacP3ZjfrR?=
 =?iso-8859-1?Q?KvvGx0d+8IEFwuaz/j62VmCq+CIIt7Wnl+gl7zasgoji4q4c6KcmzKP2Gv?=
 =?iso-8859-1?Q?+Ivdg6r71ky6jpdTErr/1gu5y6WZhx4f+UTfYq5+i2mnNut3+ZtyxQjhaV?=
 =?iso-8859-1?Q?n5pV6dFn3Bu2QLstdwyLjh+G2auReHwJYDpd1ZAWKklw2pu2kY5Kn3y862?=
 =?iso-8859-1?Q?4WT367sd+AbLk9REy+syRj+gGwu+kwceTuibVnAHDGXUbGJBu4Nza7QqcM?=
 =?iso-8859-1?Q?XsYpWxh4oWjPWAOd4PTnJiOHauFRQ77zrPK8VHh/Y1zVx3w6L3CSeSV+u3?=
 =?iso-8859-1?Q?Rk/7qXMumCwvT3MyX4pGEhzcwdHTIUVMRUW1S2yp0zZOmq8n2FZIXlhRJs?=
 =?iso-8859-1?Q?3BNTKkTN8azc7/4YQ5Fp5i7cl3jtQNnzP+Pxru2Qw+AJQDfVo62Doo84Wf?=
 =?iso-8859-1?Q?IBqs9oNtENxH4+zmQs8d4PWMHj8ssQA3X17QZSkG2PDJzrylwfOs83+eC7?=
 =?iso-8859-1?Q?2QrWwwWtC7LBShNj/h++hkaOqpcoOvXKSPR9SlInHr/KkJVdXSJqSc4ERh?=
 =?iso-8859-1?Q?J/Mngk+lefYwWwwbtANJUi3iJEvHV25NOoqqfXUj9JEdaMaKZGGh53nzql?=
 =?iso-8859-1?Q?0qzvv+wyeY5MdPpcS7TOLYr5SWMQgdTEtrI5mgySpw6W/gVivVXD+lOMmt?=
 =?iso-8859-1?Q?vyiwmxoCn721GHc+tjVoMjW6z+VqboI+D6IzILaXUMz7+RejSSvneS6VTW?=
 =?iso-8859-1?Q?ynFbbFKUCN4IEP0cEV4oB3VWqIM+1TX8W3Hb9/OI/bix3Wig+om5MZNikc?=
 =?iso-8859-1?Q?1FBkeIsu5tkstKD4B+IVpWM54ay2sTKxVJONrQRSwIVwuJgmPvClAaPeO0?=
 =?iso-8859-1?Q?Vg0hozNzFtrjmbjs01NQr7JPtPLhtm+r7InTa0zrV3SLoafDIArUkJ4+km?=
 =?iso-8859-1?Q?Z8mAGyf7JIMCdaRcYRWT5821eWWvBUtbVcmos1ZZ6jMe6QmsGDMKuofEu2?=
 =?iso-8859-1?Q?Zr50wCzkGXM/BLGQ5twdpqxi4TD0529Ehy2BjkIpHKiMz2hIIty2OBhYH0?=
 =?iso-8859-1?Q?igIikTvXbYLkSgZNzoiQbGbszuEn7tmsRu1br7VzKWGxoqv6vv8u02geTk?=
 =?iso-8859-1?Q?fnE8zRNfyt+hc57/5PXNA/ZF/YEk9jwm+i8+KcWdRxtHfcFT85e5sjqcYo?=
 =?iso-8859-1?Q?Irm135TnPMD85xouzuVg1dvZyTSx4+flJCSFre/mtuaaad7cr6G6cnrRfp?=
 =?iso-8859-1?Q?t6zEEgOZhXx9qdrbkJJNnBNBhTdlWJGMkHi+Yzmqg40qXm5GB8PPQrTi1t?=
 =?iso-8859-1?Q?CvZ/QRtrrfcAkhRknhdbov9GQ/EVqwxMjMeaQ7TvVtFGQ23AT9Bgvhc/fs?=
 =?iso-8859-1?Q?cZsHNn+/Zt1u1Ns8IoMGhPieaDOBA5D84OaG4TH9ZRkV2cQTKVu6XoIV0y?=
 =?iso-8859-1?Q?Jl1J5Dl2BSgDAPj5zwZOimi7/QHw4RN2vQmf75CPum7HIOQvhHabRgUI1x?=
 =?iso-8859-1?Q?O83qL5q88DsA1V5RWQzoi0vU9B2JHvupBGaLxol9cAyZTztUDqTUsJ744o?=
 =?iso-8859-1?Q?onzma6/Ti3xQt91RBW6eMSOgEUBEaFIKjjMcov4y+n816v?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9affa599-d418-4012-1f50-08de73b43904
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 14:51:42.0747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qV/I7WRbhOFl8XGqJsHXb4uA54Q6Y2pzPVqygjSc1q1vXi9pT161sEJKCyisvTehXhSk7AA7w9U/fEK3Xn7SOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
Received-SPF: permerror client-ip=52.101.48.28; envelope-from=ankita@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

>> =0A=
>> Not arguing against this, but if there's a linux bug it is important=0A=
>> to fix it as a 1st step. qemu work arounds for broken guests=0A=
>> notwithstanding. then we can check how long the uapi has been around,=0A=
>> how practical bugfix backport in linux is, and decide on whether=0A=
>> a host side work around is worth it.=0A=
>=0A=
> Yeah, Ankit should provide more details to check for kernel bugs, but=0A=
> I fear it is more userspace bugs in practice :\=0A=
>=0A=
> However, I think even if it is minor and easier to backport it still=0A=
> doesn't matter. The CSPs all built their VM types for this HW with the=0A=
> exepcted ACPI and this stuff is now very widely deployed. It makes no=0A=
> sense for qemu to be incompatible with everything pre-existing...=0A=
=0A=
I don't think this is a kernel bug. To give somewhat more details,=0A=
we pass memory-less, cpu-less NUMA node to the VM such as=0A=
the following through the command line.=0A=
=0A=
qemu-system-aarch64 \=0A=
..=0A=
-numa node,nodeid=3D2=0A=
-object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \=0A=
..=0A=
=0A=
The qemu code here only adds the numa node if the size > 0.=0A=
https://github.com/qemu/qemu/blob/stable-10.2/hw/arm/virt-acpi-build.c#L718=
=0A=
These nodes are thus discovered through the Generic Initiator=0A=
Affinity SRAT structures that is build for the acpi-generic-initiator=0A=
object such as the following.=0A=
=0A=
=0A=
[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affini=
ty]=0A=
[1A1h 0417 001h]                      Length : 20=0A=
=0A=
[1A2h 0418 001h]                   Reserved1 : 00=0A=
[1A3h 0419 001h]          Device Handle Type : 01=0A=
[1A4h 0420 004h]            Proximity Domain : 00000002=0A=
[1A8h 0424 010h]               Device Handle : 00 00 02 00 00 00 00 00 00 0=
0 00 00 00 00 00 00=0A=
[1B8h 0440 004h]       Flags (decoded below) : 00000001=0A=
                                     Enabled : 1=0A=
                  Architectural Transactions : 0=0A=
[1BCh 0444 004h]                   Reserved2 : 00000000=0A=
=0A=
=0A=
Now the kernel parse it in the sequence of their occurrence. A jumbled up=
=0A=
sequence thus results in a jumbled up assignment.=0A=
=0A=
Thanks=0A=
Ankit Agrawal=

