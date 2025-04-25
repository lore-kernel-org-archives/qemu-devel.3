Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41540C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jft-0004FI-Sz; Fri, 25 Apr 2025 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8HlC-0001hP-0f
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:26 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl6-0001Mx-PR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgtNJ2F+lsDyJm9uTPOpHxy0qXMAv/itmbAvDFbCJROnfK9iELu7FEO+cCw6JVHtR/JrTysdgAIigq8IeqU214KbkXe3ZOQD30pRwHe45oJ7ByLFSqFrwL3G/FAyw/qrqoJAstKAyit9b2Ef9GMdH9v20XGV/iSlRidLl3fnO0s6Z5H1ozzb7aDU8aNWJZ6KmAUh9/Ai2mkDwmtiwQqTD3PBZOC08yr31NsFAF4seiy9gG9EcPjmqcQq8YRKdQQO+SqiDZc0Br5dj0NoJG/6MBLihXUF2rAXYfQKtPCzWqFAEK4LMofZgfcQArkU6iins2Gs2fzz4ngf64hFTv4t7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQBDtxYLmkgTnsUn7T/5nLOWQCBBMdNYthJHVWhvYLs=;
 b=YpICKhQcdH/H0qtj1Q3mjyzpVcgvJhA5P616D23TS5bCDVvF83yI9Lagl2FPngy/R+wVpL2ywkWCEt41U27btIPPc4kEn0G3Fxr+0D5QCOjolcRe8ZNzhAhdO/QDrxQKUupbJTLymze+UwPzncognHO4jI5YRs15bS3DMoDW76KTJR6m4s5+oufyyUy0IPn4E5G5Al3n7DOlNWN1RLTDvpl9CFGX6zpHDAJA1XPd7VwtKHvJ0xbjXd9iqt/EpCNTMRpUUubBld3yB9xtf3RDTAhJVZLT2OMXfyB+17NEkgvvH9IyMnsHdKKC8KrkMEdIC9ucWbPOiPlS1Mga7l61Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQBDtxYLmkgTnsUn7T/5nLOWQCBBMdNYthJHVWhvYLs=;
 b=TLV27siKS2P8kJQgquWoESgptHexTOo9X6YuPIWOkWf0tK7Bi3ucUmea5iL6C8CSeYL0oL6XCPF30vjIbjdU16sttw2TZbX7bAncgofSRC2mC83njDABNCxoObaWBQv8X29/eYXugYTFKvaoucWPs4+iKeRX07pX/jQ5dvBpkw8/EEYtdrvPiriDqL9n6lsxA1lbuE5xDc2Z571jRk5g/8E5V/YkZ/m5la7gggnqOaaiT0wynNR2elgcV+lPVRD9o6VccCYxVwGB89SSayckuRg7OFgoGkISQI4J6xz8YWxrH2hvc+gDS53FYlXbxOSojfIC5sgjlkrY23GArHdirQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:47 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 8/9] configs/devices: Add MIPS Boston-aia board model to RISC-V
Thread-Topic: [PATCH 8/9] configs/devices: Add MIPS Boston-aia board model to
 RISC-V
Thread-Index: AQHbtdnR15SrJkGM7UudrfPFaYWd1w==
Date: Fri, 25 Apr 2025 12:01:46 +0000
Message-ID: <20250425115912.912889-9-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3713:EE_
x-ms-office365-filtering-correlation-id: 1106e6aa-c55b-4df2-a003-08dd83f0f45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tEl7MzWxQoQB5QNJFURxzO6P265c9hjX8MejTSMJ029XrPkQt+Zy5Q+HHy?=
 =?iso-8859-1?Q?qsW7DeKY0/2LbCveYq0aE7D7M12oGGFyXN/03FIaxOGsolTfnCfIRjLrxf?=
 =?iso-8859-1?Q?BUchIoPLuu4fPZKY2VRpCRYfMrGNpDp/wpvpeYUDaHoeAL26uuDWW+DhoU?=
 =?iso-8859-1?Q?MS4xKa+v2kuQF9MUxkvTTe4cBnPNDHVOP5o52dpwOM/WGxFIsUhRO3s1yn?=
 =?iso-8859-1?Q?1JbDU5mPz0nXz0fia70xzp9yPAjaGHSgOudICAr9drqPEzxePNXvo/RQRg?=
 =?iso-8859-1?Q?WOuqbAvD6k/5Gt+LYpyODJnE5ruoYS0wLm9yj/HuM+SUADDCi0UjcFow6b?=
 =?iso-8859-1?Q?dmgy6srlPNeD5Op6QeO2pZD/OveyWUXK3e8tFhuCOKjT/f263+XQb5sqvu?=
 =?iso-8859-1?Q?lCbqczgx4mjgbX6BvvoMdV7l+Rsxl0yJQnwqvKoBAoz9N9LEqBRzV9izVl?=
 =?iso-8859-1?Q?UosR8OIZ5p04zM26uZu30SWeHotqqaVTyXJtaODq6TudjsvEp/7qDYqaMs?=
 =?iso-8859-1?Q?AfH5mUm6GYFSmafTaG0ACnEmmoKDK24Oav6s+kz+gIRQrAV2smIFBV8T5o?=
 =?iso-8859-1?Q?WPxjh4cYgT1OF1DDRFuj5UWqjILcK68DXWnh9weV9Dqy5tfAV+rM3VaDVh?=
 =?iso-8859-1?Q?BMsjIUZfXd/7Zr2ebDAaXA2Hc5D3miKjTEsEypSCQ/X7p8URBO3PiZKv9C?=
 =?iso-8859-1?Q?g5akxreibMIPmwKBPlEOZxGv3+zh2z0CFO3HtPyB0SFy6tzo+4z0z/61LK?=
 =?iso-8859-1?Q?z8C1tg3W2kKxClMLzBcPvOW8S0mGd0roZbffLpbLYCFXbHr8aEyMAjfCs2?=
 =?iso-8859-1?Q?FrwLVo52OkncNATeOiGomplaZQLdF0sj3Nzl5PqZCjrYEguFTK0s9K4DZk?=
 =?iso-8859-1?Q?7zXZpTCxk3aTdXDlvFB50DCmacFUNHNylxjlwz/4A5zfqOiNxhB6G9mo70?=
 =?iso-8859-1?Q?hf0wT12r6ANvYgTpN4RQDap2342pLkUP/y+2RYtcCc+GyxtxiGKX+AfZTI?=
 =?iso-8859-1?Q?1AJ/RhEjMcnJ6DyG5xymNQQxaEUUvd8uEk/zW09aYqeSlkViKQWcrJYPTE?=
 =?iso-8859-1?Q?dNUNIRYHCwpuPqbZAAvM8rYvXz3BEjpEt4J+ec4YOTQQjgeE0LGoWS7Jvt?=
 =?iso-8859-1?Q?a9fIg3IknnRn6Nt59Dm8yp91i05EQmg14VZh7sG4m6aFrkAQyZe9vHiGWJ?=
 =?iso-8859-1?Q?dqXzEFG9Ex6Fw0GHb3tIL1sBdB48sN4q2pXb/VT7ergsfa7jmQA0dVkme7?=
 =?iso-8859-1?Q?G8XnRvyVM3tbx7fIbcCmQNN8ojvAEw8mTIZuGDZGAIr58JNVGOByYiOUp2?=
 =?iso-8859-1?Q?MpKvAGO3jjn7Uo9nmGK6r1cvQqd494AFc6CgqiFByqM8ABnj4Bx64q+yCv?=
 =?iso-8859-1?Q?3kF98knDDoUaasKGIlmfTRw+tNaJ3JQEostwnhpmSPPBibiEy3mGlbD4E1?=
 =?iso-8859-1?Q?rVixNpIh2QkeUgkH2VpyCEbpVv+XjFdczXAr4zc8rtBPoOeZRLvOm5LbxX?=
 =?iso-8859-1?Q?eDpOV3618zVNDUwf1WNMpv7/TUBjVo54C8LzE+oLMJRDrM1WytXWrCpZhD?=
 =?iso-8859-1?Q?vGUZdNM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?deCEqQwNn4BDIdOhqRPEcqrOSZJuK40y4K7RNX0eX08AXjP9CuXxEwNtit?=
 =?iso-8859-1?Q?7+fKjrXd74Kf3GdDbuB6rbwclgSR/tySOgxuRI03oV+jxYxaAjJIAyuoNj?=
 =?iso-8859-1?Q?DqxOYjeuVkvtvdX+i5ZDcoABqW5Q9/rxFqYc4EH0/2zeBfACv0Pj7HFU6x?=
 =?iso-8859-1?Q?DEbKG2IzVVtyub3xEQ5avYafpK6KnGY7GQzUSO6mFcI628Te2srgGjydXT?=
 =?iso-8859-1?Q?S4uDDcV3+ExW2qE8zGdhobvbJ3H1OQajQTa3r8ckhLBSesSji0bEEotqML?=
 =?iso-8859-1?Q?VK6yR205cYmyMIPiZy2Av7nlk+pOz/tInLXlvet2wMOyimiPX0mMp/7K2b?=
 =?iso-8859-1?Q?9Yi6Ykq2apnbp046eWVNNBU1ZIqPougDbUAFsW77Fa0YjSCDi3TDu60ujZ?=
 =?iso-8859-1?Q?y9DjRkxuyuRteSQRCa6J3cv3Q0yyg1mYkHH4aCOGxqDNyltz0kn5GWNAwF?=
 =?iso-8859-1?Q?XuwBSbDgGzUjgWpqttAWR50N/D1w7wH855MuuggMphC9RBCkaxVbRGGIFf?=
 =?iso-8859-1?Q?3BOZp7+kh/45pJswu6XsA0A8yMC4HznuJHV0Mk9luccuTyJQQfy8EY95dP?=
 =?iso-8859-1?Q?CMknoG1lBALBm1DX0oa67Dqmqkg8inl4UMBCE+xtW3Hvk0Q+ZgZ8LvgzhC?=
 =?iso-8859-1?Q?LOfdiMFAUR1dJrcEZ31J5zLcrCY9aVlpmid+zTAk2688wsIBUKilcOljJF?=
 =?iso-8859-1?Q?ujpSdjHB4Re9U/TupWwFImptpBxT/xfac1RRsTObuQfmQ7IH/16y40krsX?=
 =?iso-8859-1?Q?OT5bQheGG4Sokw/K0YhVyl91o8WwhmsBGLWTcvLMZVXcc91/FSrzhf0rZD?=
 =?iso-8859-1?Q?6pAxEv1ptMmvwy2QD/zqaJGBQZeTEdatYtjPExIw9jOZv9PXV5dRaBRkM0?=
 =?iso-8859-1?Q?lggCbtemkc4EMfCNGqmqWt4k7WSgAx0kGM80UuxCysyHPfd4CdtM5C1gK+?=
 =?iso-8859-1?Q?PKT7QhuQgiuCOxV9xiZoj+/fBkEzGb0NIn4+21YERp9/JryHMMyF15yT5R?=
 =?iso-8859-1?Q?x1rf/2MQCIP+vUrEMsgjMbbkH7kjSrj+0WwxGx95Kh7IoaW56/x5u5MY5F?=
 =?iso-8859-1?Q?D7DM0/IfG6jv/C2Po9k53XODOvElZ86A8HbS+bWWSVQGxLZYnY4GcnqQCO?=
 =?iso-8859-1?Q?ki70JI8JR6yKWJr+cnwq6OH0q6EKmtUiaCgrCen1RibKYoCnNkMPmD6m0k?=
 =?iso-8859-1?Q?KJH9YeK6pI+X8Ih31yOvmXm2/jEoE0+6pOl5GbwEv/FF9w5zabhSsBa6hf?=
 =?iso-8859-1?Q?N4jXN8At+IavdaSBXagGU4pq9U6ouKweRAo1QeNBQjwSgQhAEYhVdxBzwj?=
 =?iso-8859-1?Q?fmP3rlYKhsdGgg7c+vNcR2clS3mtk+4zmTkS4nEXIoRneUZZcraHXAbkBu?=
 =?iso-8859-1?Q?5z368ruZk8jrYHcxEUw6OAR2oLm4y/n7cJXccoRy2wv5OnZNFNsnWbkfxs?=
 =?iso-8859-1?Q?C/LrtE78xTBRPC5HiZX8o8ujLAxremof7y1SM5w0rhoGzWuKByxa+EshaQ?=
 =?iso-8859-1?Q?Jf+9UZpOlUo2sVW43Ka5i1aOj1CAUSrWrxwXY/2LVgVDRU4lfU/fGA6T1K?=
 =?iso-8859-1?Q?QWSnbV1poVCeYU126JPZKKXK2cThzT9utCjSeLMcFyA1kmLIJHR9UpHPj7?=
 =?iso-8859-1?Q?LwUBNw4DlSi7CImMRzc1IgL/aeHYb0Fu3i0fq3Uf+1NyzCzW6D3d4Mva0P?=
 =?iso-8859-1?Q?lfkjGRd6ITF75ZwepvI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1106e6aa-c55b-4df2-a003-08dd83f0f45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:46.9146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvNEh0uA17DOfyuH6pN1ojEELiftBf2eWEG3XnxM1sTeAsKSvt372YNfLQT7B4EUiHIyc5w6MKl4WboJZvJ6oDfqhS9HIkiaIRjLjZuXPhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=2a01:111:f403:2613::702;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
MIPS CPC, AIA plic, and AIA clint devices. The model can create
boot code, if there is no -bios parameter. We can specify -smp x,
cores=3Dy,thread=3Dz. Ex: Use 4 cores and 2 threads with each core to
have 8 smp cpus as follows.
  qemu-system-riscv64 -cpu mips-p8700 -m 2G -M boston-aia \
  -smp 8,cores=3D4,threads=3D2 -kernel fw_payload.bin \
  -drive file=3Drootfs.ext2,format=3Draw -serial stdio

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 203 +++++++++
 hw/misc/riscv_cpc.c                         | 221 +++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 479 ++++++++++++++++++++
 hw/riscv/cps.c                              | 184 ++++++++
 hw/riscv/meson.build                        |   1 +
 include/hw/misc/riscv_cmgcr.h               |  75 +++
 include/hw/misc/riscv_cpc.h                 |  66 +++
 include/hw/riscv/cps.h                      |  72 +++
 target/riscv/cpu.h                          |   1 +
 13 files changed, 1315 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/=
riscv64-softmmu/default.mak
index 39ed3a0061..2f4f92b978 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -11,3 +11,4 @@
 # CONFIG_RISCV_VIRT=3Dn
 # CONFIG_MICROCHIP_PFSOC=3Dn
 # CONFIG_SHAKTI_C=3Dn
+# CONFIG_MIPS_BOSTON_AIA=3Dn
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..65a89637ed 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -108,6 +108,11 @@ config STM32L4X5_RCC
 config MIPS_ITU
     bool
=20
+config MIPS_BOSTON_AIA
+    bool
+    default n
+    depends on RISCV64
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..05b1c0f3cc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,6 +152,7 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
=20
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+specific_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('riscv_cmgc=
r.c', 'riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..879c8fe093
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,203 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+void cpu_set_exception_base(int vp_index, target_ulong address);
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+       cpc automatically. */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+        return 0;
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * 0x100 + h * 8) {
+                  cpu_index =3D c * gcr->num_hart + h;
+                  current_vps =3D &gcr->vps[cpu_index];
+                  current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK=
;
+                  cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                         gcr->num_core * gcr->num_hart,
+                                         get_exception_base(current_vps));
+                  return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D 0x1FC00000 & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..61352dead5
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,221 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    if (cpc->num_vp =3D=3D 64)
+        return 0xffffffffffffffff;
+    return (1ULL << cpc->num_vp) - 1;
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+    cpc->vp_running |=3D 1ULL << cs->cpu_index;
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_run & ~cpc->vp_running) {
+            /*
+             * To avoid racing with a CPU we are just kicking off.
+             * We do the final bit of preparation for the work in
+             * the target CPUs context.
+             */
+            async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                                  RUN_ON_CPU_HOST_PTR(cpc));
+        }
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vp_stop)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_stop & cpc->vp_running) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            cpc->vp_running &=3D ~i;
+        }
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * 0x100) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * 0x100) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * 0x100)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "riscv-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    if (s->vp_start_running > cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp =
=3D %d",
+                   s->vp_running, s->num_vp);
+        return;
+    }
+}
+
+static void riscv_cpc_reset(DeviceState *dev)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vp_running =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vp_start_running);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "riscv-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vp_running, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vp-start-running", RISCVCPCState, vp_start_running=
, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    device_class_set_legacy_reset(dc, riscv_cpc_reset);
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..047c6d8ae7 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -119,3 +119,9 @@ config SPIKE
     select HTIF
     select RISCV_ACLINT
     select SIFIVE_PLIC
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    select PCI_EXPRESS
+    select PCI_EXPRESS_XILINX
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
new file mode 100644
index 0000000000..e075dca33a
--- /dev/null
+++ b/hw/riscv/boston-aia.c
@@ -0,0 +1,479 @@
+/*
+ * MIPS Boston-aia development board emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+
+#include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/loader.h"
+#include "hw/riscv/cps.h"
+#include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+
+#include <libfdt.h>
+#include "qom/object.h"
+
+#define TYPE_MIPS_BOSTON_AIA "mips-boston-aia"
+typedef struct BostonState BostonState;
+DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
+                         TYPE_MIPS_BOSTON_AIA)
+
+enum {
+    BOSTON_PCIE2,
+    BOSTON_PCIE2_MMIO,
+    BOSTON_PLATREG,
+    BOSTON_UART,
+    BOSTON_LCD,
+    BOSTON_FLASH,
+    BOSTON_HIGHDDR,
+};
+
+static const MemMapEntry boston_memmap[] =3D {
+    [BOSTON_PCIE2] =3D      { 0x14000000,     0x2000000 },
+    [BOSTON_PCIE2_MMIO] =3D { 0x16000000,      0x100000 },
+    [BOSTON_PLATREG] =3D    { 0x17ffd000,        0x1000 },
+    [BOSTON_UART] =3D       { 0x17ffe000,          0x20 },
+    [BOSTON_LCD] =3D        { 0x17fff000,           0x8 },
+    [BOSTON_FLASH] =3D      { 0x18000000,     0x8000000 },
+    [BOSTON_HIGHDDR] =3D    { 0x80000000,           0x0 },
+};
+
+/* Interrupt numbers for APLIC. */
+#define UART_INT 4
+#define PCIE2_INT 7
+
+struct BostonState {
+    SysBusDevice parent_obj;
+
+    MachineState *mach;
+    RISCVCPSState cps;
+    SerialMM *uart;
+
+    CharBackend lcd_display;
+    char lcd_content[8];
+    bool lcd_inited;
+};
+
+enum boston_plat_reg {
+    PLAT_FPGA_BUILD     =3D 0x00,
+    PLAT_CORE_CL        =3D 0x04,
+    PLAT_WRAPPER_CL     =3D 0x08,
+    PLAT_SYSCLK_STATUS  =3D 0x0c,
+    PLAT_SOFTRST_CTL    =3D 0x10,
+#define PLAT_SOFTRST_CTL_SYSRESET       (1 << 4)
+    PLAT_DDR3_STATUS    =3D 0x14,
+#define PLAT_DDR3_STATUS_LOCKED         (1 << 0)
+#define PLAT_DDR3_STATUS_CALIBRATED     (1 << 2)
+#define PLAT_DDR3_INTERFACE_RESET       (1 << 3)
+    PLAT_PCIE_STATUS    =3D 0x18,
+#define PLAT_PCIE_STATUS_PCIE0_LOCKED   (1 << 0)
+#define PLAT_PCIE_STATUS_PCIE1_LOCKED   (1 << 8)
+#define PLAT_PCIE_STATUS_PCIE2_LOCKED   (1 << 16)
+    PLAT_FLASH_CTL      =3D 0x1c,
+    PLAT_SPARE0         =3D 0x20,
+    PLAT_SPARE1         =3D 0x24,
+    PLAT_SPARE2         =3D 0x28,
+    PLAT_SPARE3         =3D 0x2c,
+    PLAT_MMCM_DIV       =3D 0x30,
+#define PLAT_MMCM_DIV_CLK0DIV_SHIFT     0
+#define PLAT_MMCM_DIV_INPUT_SHIFT       8
+#define PLAT_MMCM_DIV_MUL_SHIFT         16
+#define PLAT_MMCM_DIV_CLK1DIV_SHIFT     24
+    PLAT_BUILD_CFG      =3D 0x34,
+#define PLAT_BUILD_CFG_IOCU_EN          (1 << 0)
+#define PLAT_BUILD_CFG_PCIE0_EN         (1 << 1)
+#define PLAT_BUILD_CFG_PCIE1_EN         (1 << 2)
+#define PLAT_BUILD_CFG_PCIE2_EN         (1 << 3)
+    PLAT_DDR_CFG        =3D 0x38,
+#define PLAT_DDR_CFG_SIZE               (0xf << 0)
+#define PLAT_DDR_CFG_MHZ                (0xfff << 4)
+    PLAT_NOC_PCIE0_ADDR =3D 0x3c,
+    PLAT_NOC_PCIE1_ADDR =3D 0x40,
+    PLAT_NOC_PCIE2_ADDR =3D 0x44,
+    PLAT_SYS_CTL        =3D 0x48,
+};
+
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
+{
+    BostonState *s =3D opaque;
+    if (event =3D=3D CHR_EVENT_OPENED && !s->lcd_inited) {
+        qemu_chr_fe_printf(&s->lcd_display, "        ");
+        s->lcd_inited =3D true;
+    }
+}
+
+static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint64_t val =3D 0;
+
+    switch (size) {
+    case 8:
+        val |=3D (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
+        val |=3D (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
+        val |=3D (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
+        val |=3D (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
+        /* fall through */
+    case 4:
+        val |=3D (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
+        val |=3D (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
+        /* fall through */
+    case 2:
+        val |=3D (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
+        /* fall through */
+    case 1:
+        val |=3D (uint64_t)s->lcd_content[(addr + 0) & 0x7];
+        break;
+    }
+
+    return val;
+}
+
+static void boston_lcd_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    BostonState *s =3D opaque;
+
+    switch (size) {
+    case 8:
+        s->lcd_content[(addr + 7) & 0x7] =3D val >> 56;
+        s->lcd_content[(addr + 6) & 0x7] =3D val >> 48;
+        s->lcd_content[(addr + 5) & 0x7] =3D val >> 40;
+        s->lcd_content[(addr + 4) & 0x7] =3D val >> 32;
+        /* fall through */
+    case 4:
+        s->lcd_content[(addr + 3) & 0x7] =3D val >> 24;
+        s->lcd_content[(addr + 2) & 0x7] =3D val >> 16;
+        /* fall through */
+    case 2:
+        s->lcd_content[(addr + 1) & 0x7] =3D val >> 8;
+        /* fall through */
+    case 1:
+        s->lcd_content[(addr + 0) & 0x7] =3D val;
+        break;
+    }
+
+    qemu_chr_fe_printf(&s->lcd_display,
+                       "\r%-8.8s", s->lcd_content);
+}
+
+static const MemoryRegionOps boston_lcd_ops =3D {
+    .read =3D boston_lcd_read,
+    .write =3D boston_lcd_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint32_t gic_freq, val;
+
+    if (size !=3D 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register read\n", size);
+        return 0;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+        return 0;
+    case PLAT_DDR3_STATUS:
+        return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED
+               | PLAT_DDR3_INTERFACE_RESET;
+    case PLAT_MMCM_DIV:
+        gic_freq =3D 25000000 / 1000000;
+        val =3D gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_MUL_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK1DIV_SHIFT;
+        return val;
+    case PLAT_BUILD_CFG:
+        val =3D PLAT_BUILD_CFG_PCIE0_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE1_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE2_EN;
+        return val;
+    case PLAT_DDR_CFG:
+        val =3D s->mach->ram_size / GiB;
+        assert(!(val & ~PLAT_DDR_CFG_SIZE));
+        val |=3D PLAT_DDR_CFG_MHZ;
+        return val;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx =
"\n",
+                      addr & 0xffff);
+        return 0;
+    }
+}
+
+static void boston_platreg_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    if (size !=3D 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
+        return;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+    case PLAT_DDR3_STATUS:
+    case PLAT_PCIE_STATUS:
+    case PLAT_MMCM_DIV:
+    case PLAT_BUILD_CFG:
+    case PLAT_DDR_CFG:
+        /* read only */
+        break;
+    case PLAT_SOFTRST_CTL:
+        if (val & PLAT_SOFTRST_CTL_SYSRESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
+                      " =3D 0x%" PRIx64 "\n", addr & 0xffff, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps boston_platreg_ops =3D {
+    .read =3D boston_platreg_read,
+    .write =3D boston_platreg_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static const TypeInfo boston_device =3D {
+    .name          =3D TYPE_MIPS_BOSTON_AIA,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(BostonState),
+};
+
+static void boston_register_types(void)
+{
+    type_register_static(&boston_device);
+}
+type_init(boston_register_types)
+
+#define NUM_INSNS	6
+static void gen_firmware(uint32_t *p)
+{
+    int i;
+    uint32_t reset_vec[NUM_INSNS] =3D {
+           /* CM relocate */
+           0x1fb802b7,     /* li   t0,0x1fb80000   */
+           0x16100337,     /* li   t1,0x16100000   */
+           0x0062b423,     /* sd   t1,8(t0)        */
+           /* Jump to 0x80000000 */
+           0x00100293,     /* li   t0,1            */
+           0x01f29293,     /* slli t0,t0,1f        */
+           0x00028067      /* jr   t0              */
+    };
+
+    for (i =3D 0; i < NUM_INSNS; i ++)
+           *p++ =3D reset_vec[i];
+}
+
+static inline XilinxPCIEHost *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev =3D qdev_new(TYPE_XILINX_PCIE_HOST);
+
+    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
+    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
+    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
+    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    cfg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return XILINX_PCIE_HOST(dev);
+}
+
+static void boston_mach_init(MachineState *machine)
+{
+    DeviceState *dev;
+    BostonState *s;
+    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
+    MemoryRegion *sys_mem =3D get_system_memory();
+    XilinxPCIEHost *pcie2;
+    PCIDevice *pdev;
+    AHCIPCIState *ich9;
+    DriveInfo *hd[6];
+    Chardev *chr;
+    int fw_size;
+
+    if ((machine->ram_size % GiB) ||
+        (machine->ram_size > (4 * GiB))) {
+        error_report("Memory size must be 1GB, 2GB, 3GB, or 4GB");
+        exit(1);
+    }
+
+    if (machine->smp.cpus / machine->smp.cores / machine->smp.threads > 1)=
 {
+        error_report("Invalid -smp x,cores=3Dy,threads=3Dz. The max number=
 of clusters supported is 1");
+        exit(1);
+    }
+
+    dev =3D qdev_new(TYPE_MIPS_BOSTON_AIA);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s =3D BOSTON(dev);
+    s->mach =3D machine;
+
+    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_RISCV_CP=
S);
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type=
,
+                            &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-hart", machine->smp.thr=
eads,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-core", machine->smp.cor=
es,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "gcr-base", GCR_BASE_ADDR,
+                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
+
+    flash =3D  g_new(MemoryRegion, 1);
+    memory_region_init_rom(flash, NULL, "boston.flash",
+                           boston_memmap[BOSTON_FLASH].size, &error_fatal)=
;
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_FLASH].base,
+                                        flash, 0);
+
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_HIGHDDR].base=
,
+                                        machine->ram, 0);
+
+    ddr_low_alias =3D g_new(MemoryRegion, 1);
+    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+                             machine->ram, 0,
+                             MIN(machine->ram_size, (256 * MiB)));
+    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
+
+    pcie2 =3D xilinx_pcie_init(sys_mem, 2,
+                             boston_memmap[BOSTON_PCIE2].base,
+                             boston_memmap[BOSTON_PCIE2].size,
+                             boston_memmap[BOSTON_PCIE2_MMIO].base,
+                             boston_memmap[BOSTON_PCIE2_MMIO].size,
+                             qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
+
+    platreg =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+                          "boston-platregs",
+                          boston_memmap[BOSTON_PLATREG].size);
+    memory_region_add_subregion_overlap(sys_mem,
+                          boston_memmap[BOSTON_PLATREG].base, platreg, 0);
+
+    s->uart =3D serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2=
,
+                             qdev_get_gpio_in(s->cps.aplic, UART_INT), 100=
00000,
+                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    lcd =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8=
);
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_LCD].base, lc=
d, 0);
+
+    chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
+    qemu_chr_fe_init(&s->lcd_display, chr, NULL);
+    qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
+                             boston_lcd_event, NULL, s, NULL, true);
+
+    pdev =3D pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->se=
c_bus,
+                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI=
);
+    ich9 =3D ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
+    ahci_ide_create_devs(&ich9->ahci, hd);
+
+    if (machine->firmware) {
+        fw_size =3D load_image_targphys(machine->firmware,
+                                      0x1fc00000, 4 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load firmware image '%s'",
+                          machine->firmware);
+            exit(1);
+        }
+	if (machine->kernel_filename) {
+            fw_size =3D load_image_targphys(machine->kernel_filename,
+                                          0x80000000, 64 * MiB);
+            if (fw_size =3D=3D -1) {
+                error_report("unable to load kernel image '%s'",
+                              machine->kernel_filename);
+                exit(1);
+            }
+	}
+    } else if (machine->kernel_filename) {
+        fw_size =3D load_image_targphys(machine->kernel_filename,
+                                      0x80000000, 64 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load kernel image '%s'",
+                          machine->kernel_filename);
+            exit(1);
+        }
+
+        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000);
+    } else if (!qtest_enabled()) {
+        error_report("Please provide either a -kernel or -bios argument");
+        exit(1);
+    }
+}
+
+static void boston_mach_class_init(MachineClass *mc)
+{
+    mc->desc =3D "MIPS Boston-aia";
+    mc->init =3D boston_mach_init;
+    mc->block_default_type =3D IF_IDE;
+    mc->default_ram_size =3D 2 * GiB;
+    mc->default_ram_id =3D "boston.ddr";
+    mc->max_cpus =3D MAX_HARTS;
+    mc->default_cpu_type =3D TYPE_RISCV_CPU_MIPS_P8700;
+}
+
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..f982b32ec8
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,184 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    RISCVCPU *cpu =3D opaque;
+    CPUState *cs =3D CPU(cpu);
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, cpu);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
+                            &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i ++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, // hartid_base
+                                      MAX_HARTS, // num_harts
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, // hartid_base
+                           MAX_HARTS, // num_harts
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index c22f3a7216..76a038f60e 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-ac=
pi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-h=
pm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
+riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'=
, 'cps.c'))
=20
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..1bd2c21196
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,75 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..66eba0a525
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,66 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "riscv-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t vp_start_running; /* VPs running from restart */
+
+    MemoryRegion mr;
+    uint64_t vp_running; /* Indicates which VPs are in the run state */
+} RISCVCPCState;
+
+#endif /* RISCV_CPC_H */
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..7caa60fb18
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,72 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/* The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+   bit 0. */
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 // Arbitray maximum number of interrupts
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+} RISCVCPSState;
+
+#endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f403a743b2..1e06e407ed 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -637,6 +637,7 @@ target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
 void cpu_set_exception_base(int vp_index, target_ulong address);
+
 #include "exec/cpu-all.h"
=20
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
--=20
2.34.1

