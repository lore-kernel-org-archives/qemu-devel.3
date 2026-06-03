Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008A6CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhso-00062S-1j; Wed, 03 Jun 2026 05:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wUhsm-000620-8N; Wed, 03 Jun 2026 05:27:28 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wUhsk-0007jI-IO; Wed, 03 Jun 2026 05:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPHnIeouoKL6U1WC3YhMR83Du1Kj3Po9sl3V1vHyZUSHpv/UTy7ReTuH90/2b5NLSU+t+vOXF8D/QJjjSFL54n3SGtwn52SBzojc+UeEhQhB5uJRzX+O63B8w/HEsOT761caMhGrucatJ+W+WvCMxvxPetxjGJUCVOOkICAkq/GziSeiqU60TZLAQCtS6sJQ8vrSUvLd/HBGeR/wF93vxFHeHQzLldB3OLRC0rjwBfgOMsqOkrH9OSrPc8Irg4R1OZ9MC5lDksF6QjKyeGJUTLl7Ev2IUiphTRXh+GZmQJbEQakv61xQGVsnLAMVshyPBF/zuX0sTa13EL7sxazbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LskRRrcPpoCSWv3AvuDX9y4BRPfdNVUULWuv0g2+AM=;
 b=oI0k/33gE6fJtfHDcL9bMkfTV0WwbclQyp3Bf//FSUlg+ErEmzzNrYa4gyLMCP6t6dNlVTYbdniUEaSd0yVaT212LK9jfRGBeVppFbP5Dfvl6iJLFYLHr6EWN2Znl2oFyB5Qf19YyBo8P5dnwoOq/4kd+YgnCH6IcNkH+al/mgH+bv6xjXEdzc+BA8Y7PTQGFGVCO+CbEuOUcOmrgvhcb7OlRVVMFEbp8h++/hHUABInee3ioZQT0zIVa6L6EeB2jtgJn54RrjXZE0QlQ2HW+rGjny0+bPideX69OmoBZayyzyMZ1borBhUA4YWtyWK7XcFy351rJlJUqee/68H1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LskRRrcPpoCSWv3AvuDX9y4BRPfdNVUULWuv0g2+AM=;
 b=j+SowRIpBqLszJS6zSVwSPLATK0YQPgXiOmPJ2Gw1eZZLKqDHICnwi0Q0XPs95bAlgO3Nt5RVh4Y+0PkLCf+EA47uWVlRGSPLm/GhYZrl+i6tsT9YWvJbnIW1KTIX+7/CXaDnteyY36lv2DQt6mfmD6AxTSjFpbtMM65D+CA9rAWgvC6mIku4w4S8ymgGdIarv3eWd0CkC3Sx0d4oQVP8X2d/bfBzobLzSsevNFzR4IGJY+WRu6rKg2xp+mpDkYEu3EeRA//lMFbuDJLfXq77yohrMTBxqMkMBxEFD4EsGfokrOxS9eE29Dz+Rzoib89tmy00RjfOCVbXCIlmwc26w==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6954.apcprd04.prod.outlook.com (2603:1096:400:333::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:27:18 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 09:27:18 +0000
Message-ID: <SE3PR04MB8922C94211AEA9EE81E88EEAF3132@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 3 Jun 2026 17:27:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc: Fix KVM VM start failure when AIA is configured
 as aplic-imsic
To: liu.xuemei1@zte.com.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260601111637608gw-0SX_SUzpTzaHRaZftH@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260601111637608gw-0SX_SUzpTzaHRaZftH@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::12) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <51edf9b6-dea3-4931-a054-12e7a8d1903f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: cee4f769-b040-452e-6a01-08dec1524e5d
X-MS-Exchange-SLBlob-MailProps: AlkLxVwsndm0VyxXF8Qt5+inPVJ6WOFFUD46XjF9sLLjvtMhgW/DsRYS7Yi1PFmUdomz5n+u9KE3cuZ3EdvHW+nA8KRKoz9Sz3/5MiPq3gQfvXPOUu/fr8hXIGKHNmgG0F/A8TraU90fMKpNVRWAOyznqW094jY58/DMTTEtxfw6FXAoiw6ujytSB52sSrZ3Drhruz22xEKA3jRHEiVgAS14zBoIMO5k4Ktx/yNuEOrcob9C+4I5UCw8heN89kPj9vfkUClFZ+UxxjPI3Av1kZAYCWlRUD2Fu0shD7m22um/gImnJ4R1bKfo+peEzZiSQWQooZ3f8Wr+3UNqPwIl9Zw93OWEYtSXNoPQHmGli5lKdiZE422cbZ2hUf4XC3ZB/bhlw0/c1KeuiurK0yGFjWpwdz8AS8JsaoKPyQ6QbTDU+LcesmzjMow4z19ngMls/HuegnLACHX/+otmPRoeBpKG1r4ZFRHJfkNBXUlOsZ6PN1BbDsiwCjq+5qGqe/tbXZIVQSLUUt6rchRJBmws7kKibq3DVXCx7KftADulJUX9UQ+akvUZCvUMRPQvm8jVOKhP/T6vctY7TFCJkCokB5SY+xCvpV76IMISSHa5RY3RiaiSOl5P8Qwj+p+LUKWwyzkjqKVQ4vNRDl7q5yS6SWCV1jXDnJhXiTonbUkz8d9YReo0CAvs0THHrGtsGRx7V0IDO3lkB3UJ8sd8d0ZDbsR9MiaMwMCZxtGxCa4LAO5Ii9vRGNetrJXMAJVRPJCTKeQ+0/POxtpku4wUde6g777U8B+Tt0wy
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|45011099003|51005399006|19110799012|8060799015|6090799003|15080799012|23021999003|12121999013|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzQySzh6RTVjeUMyTDNmbnNiMmtJZk9NeTZWR0E5aWhQc1NqeXZYTjFjQXV5?=
 =?utf-8?B?ZmVwWE1xdFU0NUYrUUsvQldkcWJDekxOK2hHZTVmU2pRVFd4bE1JVEdTcDhX?=
 =?utf-8?B?VU9heXc0Mm5rcktzK21jQllRV09ubDJUeTVuUDlFb0QyVStyTUgzZVFESGNR?=
 =?utf-8?B?ZHNNRFpTd2t4bWczckZXVEQreHRhT0tsRDZzeUo3YmptSDRrUVJZVDRtTkZM?=
 =?utf-8?B?MkZRY3R5OUZvakRicHdJUFpWbHZMemlXT1hCRWxzTlp0R0hlMVByc2ZOYkpQ?=
 =?utf-8?B?N0pMME01Q2RsTElpLzFncGVxRVpNRWp2ckVCc1dQb3dWNHJSb3NZRndqeUxa?=
 =?utf-8?B?dGl5MWtyVG44SUE1WFFsNU9pVVZHVFltbWNOQUZjR0dwb2hDRWRFWkRsbFMy?=
 =?utf-8?B?dVRtSEV5R2xFNkxhdndXWjVjZzhjQXRObEY3RFZ0K2ZNU0tpSDlSZk9MUWJH?=
 =?utf-8?B?N1BKSE43NHBaWHRwTE9rMlIrWUxIcFpnR0VmOWNodHNWdjJNY2VtZGNZZnhB?=
 =?utf-8?B?WFJaSVpKb2wwZEgwbmg2QzdHcHhUSmhkZ01JZGdoMEhNVFNSTnJwMTFJS1lN?=
 =?utf-8?B?N0Y3aXZ2SDN2MzFQOUJaVkJ1dy9VVmRKNXYvcFMxODUreVFkWXRPVkFQcUx1?=
 =?utf-8?B?bUt1NEZCd2haRVdTbnk4K3Z4eTZzMmw2SXNEMWQvYVkxdWRreWRqY1UyVnBN?=
 =?utf-8?B?VVY4cVZzUDA5QUNGTXQ3V3ArQmRUMkcwNTQvdzhPWmFGWVExU29ubG5xa2Mz?=
 =?utf-8?B?S2tDbGN4WFFrY0oySldBUjlnTDJPTjNpRTBkUU80Wnl4d1pHUlNaRHNLUVoz?=
 =?utf-8?B?QksxODQ2K0pJYlBmdC9Lclhwbk1xRzE2dzM5TkRvZXk4Q1hhQ05kR1B3cVEz?=
 =?utf-8?B?WGdyRHMzTXFEM0YvVEtLMUJLUC9EeTcyRUZ0dXIwaGQyYzgxYjdManFFMTFs?=
 =?utf-8?B?YSt0K0N2REVVSk5hOS9FeERMbTcyT3hPMFY3N1VYcHNtSUN4UldueHoxYWNn?=
 =?utf-8?B?L05oL1N2VDcvZG93Yk1iN0JORFFxeWh1YkVwMkZRaGlLZDJnVElaaFkwci9K?=
 =?utf-8?B?Q3Z2M0YvMVhycXQ0dHhnNGdrbFJ5M0tsc0hWNnQvSEhSdzF0SjR6Q0ZvYUl5?=
 =?utf-8?B?SC9LN0lTa3h2U1EvMmlkZlVvZG12b2MwS25tdHJ2ZWFudy9tdkhnS3U3QXho?=
 =?utf-8?B?RzJ5eGlpdk12Z1dSTWR3N3NIVWFOdzhMOER0TmxORmhwbDM0TWpGYjBIdlY3?=
 =?utf-8?B?c0wyWGsyblZEWTlmdmRWczQwSkJVbkJDVzNlNXlCMUtGVlpxM0c3anRoaUtE?=
 =?utf-8?Q?QCzBl0ra+APwe54dmDEA5xnnJMtayUA3Kj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlqZ21oSklkSjQ0eEdBcWUrb3Y1cTNYTUJhclZVOUdHZFlLUENjWkJrYS9Z?=
 =?utf-8?B?VXdTOGFrZ2dBV1ZPTERxN1BaWDRSb1ZWWDA3SHF2NC9VdEQrN01hc2xjQWMz?=
 =?utf-8?B?dmVpaGR1VkhNeE5pYkR6NGZpNHo4Vms3Q2lzeDRoWUk3dE1hcExnL2EyQWFD?=
 =?utf-8?B?TTNWbk5OazZoREd3ZCtPN2dPWml4UFBqTEJQcTJaaURMUUNGdHpUV3JZSy9p?=
 =?utf-8?B?R0l1QzFKbTFQQ1pDM0lFVW5yTUZ0aVk3amdMWWlldTN5NDdtVDh3Wmw1dlUv?=
 =?utf-8?B?RTdWRDdUdDJuNjdRWm9OcWk2clgvQkNZKzM5bWdJTnVIYkt5Rkw5RlRONXVu?=
 =?utf-8?B?Wm9yTWo4c1EvWG84UFc0RC80UVpHTWRjN3RhMVNnK2JkZklmMHhLYkFsdG82?=
 =?utf-8?B?NWFHUVpQNlIvdTBBSjZieittTTlsbjNqeDBVTWhWVm93ZjNUZlRkdk9aL1dx?=
 =?utf-8?B?bGlFUFBOSGkwUS9SMzd0N1JTUTlGWWxYTzdZa2gySUpWaHpxa3ZHOEhnaGds?=
 =?utf-8?B?UTZudnViWEJieHdDT3RRcjZlUGh2KzZYQlVnNnpvb0d4N2JCKzl6MGppT09V?=
 =?utf-8?B?ZTlJY09TNGdENU5BL1h1YllpTDhnUSthdklsS0Q5WEZUTkhhQ05WVXJCbm5L?=
 =?utf-8?B?NndKSE9XTnk1eklRdFBMMWY2bWZoYW5xMHNBU0xJbms0dmZnREhacVN4d2dy?=
 =?utf-8?B?akc5T05ZU3h6bHhrU0pHQzB2TkFFY1k1U09iVU9DNHNLOW9pM3hUNmVTelkz?=
 =?utf-8?B?c0llQmEzZkpWMVRMK1VaaGpDVTIrOGJVVkM4U1R5SlMvbjVpbFZldVBhVU9Z?=
 =?utf-8?B?UjkrSmtaUGlnOWlveDRNeDl1RWpCaklpelA0Qk5hYndkcWlpKytHTzRDNXFw?=
 =?utf-8?B?SW5PT3BDUWI0VmFwTHRFemdWS0FVTFBqTTFTaGJSd0JCOE9XUDZyUnVWWXU5?=
 =?utf-8?B?ck9JcmdKODN5MEd4MUp6aE1wMnBnSzlTWW85RUpPdlFjcmV6dFZ0SUwyaUVW?=
 =?utf-8?B?c2tnc29lT3hCVzE1RTJwVUZBSnp3c2o3VkVhZUc5eWFxZW8rcDlJZWYzNlRG?=
 =?utf-8?B?amtJWEthYXBSL2dtMkx4elQwNllocVJPVEZmYXMzbDFaSHFIS1lDVXlXN0hy?=
 =?utf-8?B?V2VoTDExV3FPT0VSTml2SUlZUGQxbG5udSt4TGJMRTlmZHhIZkFZR1MyVkEx?=
 =?utf-8?B?dkVlWlRWdDB6VW1abDVFUlp1Y2R2RjQzWi9uTUxwdnN5Z0lGWkk4WUNqVEph?=
 =?utf-8?B?ZnVuTEtaSTRqbHJLWnNFS3JLdkJzVjBZTXUxUCtmVTlRMHVuN1dEY2RjS1Fl?=
 =?utf-8?B?LzVWNURkZEgzKzQvOU9qVUdJYVV6N3F3TEl6bVZxT2N5bWpjSU1ReDJ5aFJL?=
 =?utf-8?B?ZVl4MVE0NUxSb1oyaUpsMzJuVUpHRnJtRzd2UURuQy9iQUJwcjZHSmVRMFJW?=
 =?utf-8?B?aGwrUkY3U2cwZmVDajVhb3AxdVRaRjg2aGNaRDYzOFhieUdSY2R6RlErc3J0?=
 =?utf-8?B?aThzOWltZURrWE04WUpZWExJaytLb2lka1h5QVgrbXh6WW0xUFRyWVRJUzZy?=
 =?utf-8?B?VGtWTy9VVDhOWTY1YjM5eS82R3ZYNnJndENkTVFPZXZLQThHU2I5RFpSTUpv?=
 =?utf-8?B?ZDVpT1dFb3BCb3hWVGhKQlFQZWFHWjVKbURXUUYrTVU3ZFZJR1NBWmZSRjBR?=
 =?utf-8?B?NThaZDNWeEZ6SDlWWkx1SkxkckhNVy9YM01qVHMxdGlZWEZaUDhIa0VtaDRx?=
 =?utf-8?B?NUZDcTN0Wkxvci9Kc0VuNWkxczlUT2NsQUZWd0RNWExKTGV3VkU3NHAvWDFh?=
 =?utf-8?B?Z0hpZFJuSjdhUTcvT2xYTXpaeVEwY29URDNybjM0WnYzcDJySVc1ajhoTGx6?=
 =?utf-8?Q?96X0Cr0/B4ZLu?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4f769-b040-452e-6a01-08dec1524e5d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:27:18.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6954
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/1/2026 11:16 AM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Since commits 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
> and 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC"), when KVM
> acceleration is used and AIA is configured as aplic-imsic, the APLIC and
> IMSIC devices are not emulated (they are handled in-kernel). In such
> cases, the realize functions do not allocate memory for their internal
> register state, leaving the corresponding pointers NULL.
>
> The reset functions riscv_aplic_reset_enter() and riscv_imsic_reset_enter()
> subsequently attempt to access these NULL pointers (e.g., via memset),
> causing a segmentation fault and VM start failure.
>
> Fix this by guarding the reset operations with condition checks that
> skip the emulated‑specific logic when the in‑kernel mode is active:
> - For APLIC, check riscv_use_emulated_aplic(aplic->msimode).
> - For IMSIC, check !kvm_irqchip_in_kernel().
>
> Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
> Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
It would be better to split this patch into two fix patches.
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/intc/riscv_aplic.c | 52 ++++++++++++++++++++++---------------------
>   hw/intc/riscv_imsic.c | 16 +++++++------
>   2 files changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index c2c67c29e6..0f61b67fc5 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -910,35 +910,37 @@ static void riscv_aplic_reset_enter(Object *obj, ResetType type)
>       RISCVAPLICState *aplic = RISCV_APLIC(obj);
>       int i;
>
> -    aplic->domaincfg = 0;
> -    memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
> -    memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
> -    if (!aplic->msimode) {
> -        for (i = 0; i < aplic->num_irqs; i++) {
> -            aplic->target[i] = 1;
> +    if (riscv_use_emulated_aplic(aplic->msimode)) {
> +        aplic->domaincfg = 0;
> +        memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
> +        memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
> +        if (!aplic->msimode) {
> +            for (i = 0; i < aplic->num_irqs; i++) {
> +                aplic->target[i] = 1;
> +            }
>           }
> -    }
>
> -    for (i = 0; i < aplic->num_irqs ; i++) {
> -        riscv_aplic_set_enabled_raw(aplic, i, false);
> -    }
> -
> -    /* Need to unlock [ms]msicfgaddrh.L */
> -    aplic->mmsicfgaddr = 0;
> -    aplic->mmsicfgaddrH = 0;
> -    aplic->smsicfgaddr = 0;
> -    aplic->smsicfgaddrH = 0;
> -
> -    if (!aplic->msimode) {
> -        /* Reset IDC registers only in non-MSI mode */
> -        for (i = 0; i < aplic->num_harts; i++) {
> -            aplic->idelivery[i] = 0;
> -            aplic->iforce[i] = 0;
> -            aplic->ithreshold[i] = 0;
> +        for (i = 0; i < aplic->num_irqs ; i++) {
> +            riscv_aplic_set_enabled_raw(aplic, i, false);
>           }
>
> -        for (i = 0; i < aplic->num_harts; i++) {
> -            qemu_irq_lower(aplic->external_irqs[i]);
> +        /* Need to unlock [ms]msicfgaddrh.L */
> +        aplic->mmsicfgaddr = 0;
> +        aplic->mmsicfgaddrH = 0;
> +        aplic->smsicfgaddr = 0;
> +        aplic->smsicfgaddrH = 0;
> +
> +        if (!aplic->msimode) {
> +            /* Reset IDC registers only in non-MSI mode */
> +            for (i = 0; i < aplic->num_harts; i++) {
> +                aplic->idelivery[i] = 0;
> +                aplic->iforce[i] = 0;
> +                aplic->ithreshold[i] = 0;
> +            }
> +
> +            for (i = 0; i < aplic->num_harts; i++) {
> +                qemu_irq_lower(aplic->external_irqs[i]);
> +            }
>           }
>       }
>   }
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index ac59496c22..6dbbc152a2 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -347,15 +347,17 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
>       RISCVIMSICState *imsic = RISCV_IMSIC(obj);
>       int i;
>
> -    memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
> -    memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
> +    if (!kvm_irqchip_in_kernel()) {
> +        memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
> +        memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
>
> -    for (i = 0; i < imsic->num_eistate; i++) {
> -        imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
> -    }
> +        for (i = 0; i < imsic->num_eistate; i++) {
> +            imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
> +        }
>
> -    for (i = 0; i < imsic->num_pages; i++) {
> -        qemu_irq_lower(imsic->external_irqs[i]);
> +        for (i = 0; i < imsic->num_pages; i++) {
> +            qemu_irq_lower(imsic->external_irqs[i]);
> +        }
>       }
>   }
>

