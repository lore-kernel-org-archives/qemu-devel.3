Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91B2C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIaD-0005JI-Hv; Wed, 26 Feb 2025 09:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIaA-0005CJ-FU; Wed, 26 Feb 2025 09:40:18 -0500
Received: from mail-francecentralazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::2] helo=PAUP264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tnIa6-0003G1-Vt; Wed, 26 Feb 2025 09:40:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgPMjgu39ZLwLSobvk+rMJXT7lfQDOvjv9GrSL+7gDvud5AE9SBjB+Vn5Vp77q8dLfTUKxLTuyWm10TwI9p678DKOCS6zDHaiVzoD+eq6EbVmFwg/bJ+Aaj9QdObommSoJHjORezwXJKQoUA6jeZJx9FGFSDzikcw4kCISHUMc4hD7X+3fYrxx8Mec2yaqeWb1ksy410Bc/qDrFJBJlwY4R0mtO+Y8vd1r+QPhPa9S86cY3/t1aIRhkJFQgqxnBT3UEpVkQx12obcRFdlJsRImdrMTuL03uxyHyQR4fD494ODGpylpTwUCtCzhDocfmJQYuQ0yNnBfvOc4+uzsJsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR4tZSQDD5qma9bM5S1o0VA6cQc8X7UEUwiUUgEXSfA=;
 b=blToqfB1wBg8HrBu7AZTyF0MfFpYfi0I3evZqF/iwj8XzR5doa7tmCmv50nYCbxlnaXXDZGcbNPe0o+AaHAkUurHL8RWR8ZruGn7j21h9zz5tqBB/pgbsvz6ytP50xeOlkIjxzJDNtLszLk9d0/SuOyKVwzRLbQgXcP5c0u1FG9YP5WytKvtQpNlYhaPQUoD0PS7+54ESou88H9m3bePFXqjK6o6Pp8jmZOzSVR2v/fiKDnp1imUtfpjpyoxGBYcg5M7mFI49lvOA8plW5kfO3dEpQEJBvxyaNnqhG54hChMIy56A3sF/JNX0aNvrmJ/agkgBfejDj76Aaq6Ovp4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR4tZSQDD5qma9bM5S1o0VA6cQc8X7UEUwiUUgEXSfA=;
 b=E/LXoE1KMhm9DcDqXWRHXy415hk3wxg2MxBvTPUfZNoIgdV+pxwtDM8fcH3GnBm59XUCd3MgUgsd3uWw7K6JQJ4QHvzFKK06oYrdENN3S66yNEldzmch+CztTu70YYkx9kw5wl/+5z/N6HYmcaJchIjFgB+9ZFD7nIJ/xJu6lg1n4TnjqpADZ+ZfIX9M7wXzq7asybb78ExMOorLRCmMt6OCbUSpzXyEjzJZAzJsDmpWQTgmP+vvtMTI/IR61Veb/fUbA8H6BA3YucYVA7hk9yUgrU77Y+6Hn//Tm0jNRE3Ad7D8Oq76PCvEnL14V14EWtxI6uZZIj1BtEoij+ak8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5513.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 14:40:06 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:40:06 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/2] target/riscv: Support scontext-based trigger matching
Date: Wed, 26 Feb 2025 15:39:12 +0100
Message-ID: <20250226143914.769112-1-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::15) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR0P264MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 21caba86-a45e-4153-2229-08dd5673767a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Siwf+PUpMKG8keW+H/Sn+A5k9ZzLuiYf/zoT7DiC0x8M5u0z8FOb9W8/gE8?=
 =?us-ascii?Q?xvkglZrRfExFbanmqq1F71H+nZj9+yxbua/elljCjF0JlxCYU7StIVQWtLNo?=
 =?us-ascii?Q?vDVTOkn6rq9SZSxrM4hawgXkOYOghNfOOxuTz4Oti6ZsajyMf8JElo26768N?=
 =?us-ascii?Q?E4us+Cd+EQ+Js7je9mH9Ac1miRbKH1q2Kt9Va7bB3qGJW1g0sIpTc91xt6aV?=
 =?us-ascii?Q?gylqZaz0f/SLfYzRTx3JsYxHqV2VA7yEOY1c2nAdImPKmczfOdJC2t6vQRAI?=
 =?us-ascii?Q?bVdqXHZ+suCHmiVm75DtqHcaaECz1d3OdUXEqhMI0IEIlinEg8Ivhw3KR032?=
 =?us-ascii?Q?/ZJS0JhDoIfwztnJN56qKeSufvdCwr4MSiIPqWWqXYiVYXdYfvBLSVPP0PKU?=
 =?us-ascii?Q?/sfHXgP9TJbwqspx+vVb3B8JzR7f54ov/QLt33VBfzoWKhoe9WE5/KJeF+1k?=
 =?us-ascii?Q?68R3Yf+Mhca3dT8+vfWuWDRUkIS1/qf7GCjOWIV4mNCQ2xIzQrfB+SrwpCQQ?=
 =?us-ascii?Q?FitkJ2pt/QstdI5WItTUhgy0SPpT13EGl0ohMOGl7o62ofnHXo4AlsMfKyh1?=
 =?us-ascii?Q?3QrywedHjOz5PK4/XSS0XiOswSIvqu1UMlaGII1thswLvm/aV+5VwrWP0nRV?=
 =?us-ascii?Q?RbpgnbnCyrezQGRzJYu+ANyEiriaSt6UsUSUVPq3EmooECUvtckAAH7ClK2t?=
 =?us-ascii?Q?beH7+WoyrFjFeNklwvRDVZtIzahBAB7JTrutQvGylOdLR5Brbjedjeq6U0ia?=
 =?us-ascii?Q?JgKmmcwFz3KSgqxO1PIoU7UuG2MteJaMqm01BjG6bxii7Xu+cA7AWX/xpQjZ?=
 =?us-ascii?Q?2eopLcm6lpGp3QZUwA2FwbATIo/zn8/o4wu08pdoPvA1EKp2M2Cid95y52MG?=
 =?us-ascii?Q?7NCezBsQcCamxOyxjSlDtm1rCywLEEdMfhjeqaJsIVVfF1cMAriGTg6HEavw?=
 =?us-ascii?Q?nObWY3LF2H0TkY066AgcYeu45rboWOZqjWwKp3j0OpPWcg6678irZvlWcW1g?=
 =?us-ascii?Q?Xz23LFJubo7XJnwVVr1KZodnHKPWz2K32JcC3pM7veAysITUyMTg2jn0k5wf?=
 =?us-ascii?Q?4NLi+Xix0T7L6fbLAYcShRXLsosafYwKaeYexiwCeExaiSo4RyTwKwC4Be8U?=
 =?us-ascii?Q?hn6N4ken7w0Tt75nQvw3FnYx7csdJUF54ULgPNO62RZtMPB9WM+N2HOVEskt?=
 =?us-ascii?Q?+EUmdm/+anfM2JR3iw99EM84XXW0wXvIxs4ZQEM+eCAGYZ996CrKhMgCuvP1?=
 =?us-ascii?Q?yx/hO2qhFfEjnLjKmPhQfxxOnGSjr6JGaPP0X2gRliqBcgOmyrUvrzqyJjXP?=
 =?us-ascii?Q?DgIEN26KtCbRhXol1iUgqkBCjdDPzjxTAJuHD+kGcEM3GOY9VLhIIiH28i/v?=
 =?us-ascii?Q?A/zrRCf5bWZ7GanwbYJ4tlr6T9ww?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYCQV15uB+5Zkp9uZ69cf0OlowyWBQgRPdkoINWAmmak67UdrpjQPTGJ3FQF?=
 =?us-ascii?Q?bknCqFiyOAtjTunwE3Rt3AlgwdNh8Is/FA0BbqaV6+9n0pils8qeAb5GBolp?=
 =?us-ascii?Q?X01FXkqW1fJw1Fll+KaKRSmGyuLlS251fjGY2NSLyypmggI58zpWHLckL2lc?=
 =?us-ascii?Q?Uf6Jld2OJbDiwuaGbtEAkpVEqUdJy8TMZW/EPdRYos2RaLwvj4xJDXZHjVwj?=
 =?us-ascii?Q?WPbxCVk0XfHLcsCkKbNw3ZSvtS9KKbUZNeadToGXMsx3OSRbzO4IgL0p4L4+?=
 =?us-ascii?Q?uXhpJwCmXuBN9wH/lYrPhuICwD6qGPZLMBZjCo6ZRCswOHH/Ezet3xQCkr6S?=
 =?us-ascii?Q?GwcIn74LB4e9RscPed1XBHfR5DMojzdiafmZ5W6ef3uUGfXWap+4/gIXUg0Z?=
 =?us-ascii?Q?tDQ7mp8jH/w0Hb7LsX+UmuAdJi3o7gPpw8ONsgIFh0nXu7dEYFZXUf9bIL27?=
 =?us-ascii?Q?g66q3TT+tTMcFREYHB8ckFAOoPksXD8YWdKrRQNLAHS8BIIJbukdbKbx7GRl?=
 =?us-ascii?Q?wZGKvsJUXX/h5qHvS/19tDKUchNPOH4pdBlrACqTcfAEc1CXqNIa3mZs1Zji?=
 =?us-ascii?Q?Q04LJbxXZjP9xOY8tlXjdrrGm9WmxxwFk3oM5U/IJvkXkq5zoiAicgQeExFn?=
 =?us-ascii?Q?Lm2aM9De3URQX3klFfbxubnOxrk8OkgawwH4ooWTwG3HoczhJL+DZYAnqXyE?=
 =?us-ascii?Q?jHqSjgUnT+rZjAbyr+eFIhfPe0h53fDPnaFBPkvEjNhpzK8ibQzxs8YDXpDk?=
 =?us-ascii?Q?x0QG0dbiX1CAOyTpRG+Fc/WC96uJ1yneG4X04/vvsXlDzTinROFPhlrbf3xt?=
 =?us-ascii?Q?89UlP13e2+hTVg4m1foRpvwV8X3iQZNEIsZSovQ43jnBi96en3dtPxCshzeO?=
 =?us-ascii?Q?OOKz6wj2ynAaHUcdxGXDlzFsxgtcp2LDpcBGA+23msqiyg3YUUdtyk067rHD?=
 =?us-ascii?Q?oTThVrhCDjxtnCoB+v7BdTaZXoXDMomVDJWtG9/Z8z4Vc+0SsV9WJsT/AYFj?=
 =?us-ascii?Q?CFW5zhD3YUmbKqk4XftayOE0/zDoHU6E7jMkEZRk0Nd3OMoa4T2fKiQHw9An?=
 =?us-ascii?Q?m+FHPUy44N3Yl+Lo+LL5/v5vumXgkSoqskVlvibLXxS88mffwVu+fpB+I6yQ?=
 =?us-ascii?Q?pRw4IlcbLEzn8qD9JJShvl0CBhW9lTWH2+NbSsh//bp0Ew5DACbU1Ykm0N3a?=
 =?us-ascii?Q?8OIUZ2wvOahcINCsE7vOAUR/xFKgoX6yO18htvVPVYF2MChGAxvc+nKp35iq?=
 =?us-ascii?Q?6GPuG7kRdABy1CX5qpwpFLbEiklDXJXZQf1XKBpP5FABdUXv1hfp44LQgZVL?=
 =?us-ascii?Q?jePukKO576W6SdI4io4lNJxWmApJWtHbw7Cj7oHFC0+CJ1xw8T1RICQABsPg?=
 =?us-ascii?Q?kkv5pfBQ9cVqyg5SilVDW3c44lYZe4gUDS1nOj5lbzm5XiikCZysD+DNl0Yk?=
 =?us-ascii?Q?8A2vWxjBhI2YVh28TtZf/frB0rT6ShnC+hys5MSNgA4eYjbaqzIOs9yXjg2z?=
 =?us-ascii?Q?cfuPbH0TFu0wCs6yE2u0BLC0VlXbasTl2xM6lWLKlFElhdwKYli2CZnG2KII?=
 =?us-ascii?Q?vyPmpq3K6AYDuY3BTMctLNLggps/R0IDKd50NY4G/aZC2zoxw6RAHwWlPVOz?=
 =?us-ascii?Q?yy7Gr3kUh59hRGiZSqoakRmWpO7YegMb8TH71lAPUdj13ulDDu4BjAVfP+xI?=
 =?us-ascii?Q?uv54HQ=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21caba86-a45e-4153-2229-08dd5673767a
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:40:06.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyZCw0UbjKqS28DjqbRflVkVcGHgmJ+T4DUJflXtcet+C/nJLS/r1Og4dh1X5CxIoXtQVFjoVzkWA+WApdLd8WRAT62HW0lNu/BoHGFcYtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5513
Received-SPF: pass client-ip=2a01:111:f403:c20a::2;
 envelope-from=florian.lugou@provenrun.com;
 helo=PAUP264CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi,

These 2 patches allow scontext-based trigger matching as specified by the Sdtrig
extension. Patch 1 allows access to the scontext CSR and patch 2 enforces
scontext matching as specified by the textra CSRs.

Florian Lugou (2):
  target/riscv: Add scontext CSR handling
  target/riscv: Support matching scontext in Sdtrig's textra CSRs

 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  5 +++
 target/riscv/csr.c      | 36 +++++++++++++++++++
 target/riscv/debug.c    | 76 +++++++++++++++++++++++++++++------------
 target/riscv/debug.h    |  3 ++
 5 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.43.0


