Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3054C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuY-0006hW-FH; Tue, 04 Aug 2026 11:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuW-0006hE-Jb
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:32 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuV-0004oi-6Q
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vacd+SCzxvX7SFlh5grUVIAJebEKcC362AgDS2spbgtgt0qBqx2NXU3K2NXPsRVOBbeKc/Qvuwg60O3OHa92ZCnX4ivNqD0K0lGQcRnk9l+6gvYwg9d9bxaIewuRP7Zc9l6z8po986R7wVcfSgKNZzW4lsCW6Lnp4ajIDa1BrBwFroW4oMVQJm62VnehCIsM7v7bFp61beoik1LAS+F5tacp5weoDpbKFvPfk9aOVKtVUYk5yN8IGgRBECJ4kBgamGbDv52FCOEk75tQD+tKD3S7aHlnq2AuTcdipIRnXpyyhC0mdfX7fxD5BbSLAPHNS6R3uJYv5bZf8b/OhFXXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM/XTX9a5yZ/49e319ztZVtyYdRSpmMr3tBX/ZDs8nQ=;
 b=o2TXg7ungnGfcbEKwES4bwNuCOoDNdnorDEIz2D1BzaqDhBdf4iyFt8EddQYcA/MKBKDmlZPxmnr+KLam7akIOrFJo87bFK0SOvjaFnQJfnhaq+cXwrQAtqPGIFLi4d2LuyPWCNj+v0h1Jxmi06XBUZrMg5XA8pDo+9weOZjnJ/zCpXbFjfZV5WHqgVq940Q7dEORXsgSIIfCrPnerLul82ELEDds1pJ2ICgJuXmxI98QNOD38Fjus4pDinf+bs5uJMkwu6fQJr0Ebg3jnwqCREpLcZZSM0IWzq0+uL72CJTRcIw7RbcyGgpPIiqOakIjApq+FDe763DekYoObldTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM/XTX9a5yZ/49e319ztZVtyYdRSpmMr3tBX/ZDs8nQ=;
 b=cBoDD0NOzL04Xua3lsg3hwW3tKAsXdvULVmjwIdM5MCmBs5Cgc1Nyi7GQYvpxTDvptwQuzWY6F2rzkn+w6BfoMincDtTG11WeFBlC6+7aRTJeZ/0oaDUnHyAEPd1jWHfr9Glt6DMEeIau0WPpb3GjuZfwbZnsDX6gwFWoxVXX/XP/vqlGMAMMGhp/35amYpdYJiTO9tzDM+hKgFmGVb9nYEw/Xr7aKXO5IAx9kMyzsVX/4pmnFVTXAPTUdfy/Bs5TAoLQWFtCsCfNbWs/07BnO1iv0KD1KD03rnMJ+oATYzCdrYBhSO3F6foaQr0DfnsIKnysS8uHSIK+zV9wWlUjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB11713.eurprd08.prod.outlook.com
 (2603:10a6:150:2be::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:17:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 0/9] scripts/qemugdb: some fixes for 'qemu bt' / 'qemu
 coroutine' commands
Date: Tue,  4 Aug 2026 18:17:34 +0300
Message-ID: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e69253d-1bf9-4177-f750-08def23b8d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: i0dgOs/whrb0YytbWgJzeEUtxOAm0oQ26DkNiQTJChv5wIzTpmK8xSJxbg1fkRCW0dffQwsIstuY7NFR+TepFFCZ2yhwmc/SlBEgaqOO5m2Yy+7Nfme8wWZgxyoxKer14unmkjf7jjmkRz+CEgPKyj/8VWmoKQvC5KHKG3XMaZ8/uJreZKiQxLaW7aBs+eEL3PpRbn75zNq/oCpZDg2XvQIQKMvW2AGlJ1JcUsfgUYVX67AT4tUAPwBz+TcD2YBS/KtwAFyjqvRT7xx4X40Bl5WREkmXJJhx84c4wksEJOJOKX2JU0/+zVNlYaDe472iCYfSVWGHAN6wVyIoi35AOk3qFkwDAkPNi6HrDwGwBxTH35G1gM/Kri8HBzJqS9Xk+f/Jj/PhG28NYfgrBaMhQnGJM1hTNe1PhXUA4b8t2fOz3cclGlQnDZamzmeOsKQQ9Hp58jGQE1yLB4/ZidjIPwL4r+88yH8RapWPvn0yYmr414axFSzYUAXvzIGsSlCNaWZGw151eGPmey5IXWeOQCTzOsZ36Jf6ouD6Iwm3jgiiU/tXkixTVDgr/1Qs3nKtIghxCsZksErUSlHBDmr/4dykFAKYaK5joED36NyB6hzlRgngiH8r3cUkJZUc8ZnlNthEOkjA/RlxJ/RXTXgGdFTx8CyEhhvoUm/hRNnOUpag1qpEkD7MMNzKMB4ahumrEBLG9sw9FrrK+5ZbMlJKDF9b8LRBhjVwogfFdztHczk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqbbbIF7unr0afHE6QZwP9P+/yh522Ni1syBenalOmOlZvEGOeqShna7ojIt?=
 =?us-ascii?Q?5pRd+7StEr7pNF4EtCk73X5iWAVgQ2I26icFpr62Kb/bu8XDCxHX2l1DM/re?=
 =?us-ascii?Q?uP8KMAqKDm5TmMIkzjgeHkTC3lp7iUgfrNY8J9uWY5zqXXjBc6y0pzIxsXRd?=
 =?us-ascii?Q?BMLEzWXgy3faUvH/qrfYEXFvzOVHdTJ2P0DqMi5Fp7BRgXqytQBWuKWG86Ph?=
 =?us-ascii?Q?kEHF8AxBja2StGciMJmJUiGq8veLYxIBowrsI4vqhylr5117H6nyrz96fSRV?=
 =?us-ascii?Q?kZW7cJ72VaImy7J8X6H+a/YLAM9yfkx+crpHYepQwiJ6REoyoK6jQyBhQg6C?=
 =?us-ascii?Q?Tl00crNutpoXK8JqoSQDcMYlMpEbKeyeAnzpVM6wYOSrlKiW9zwHEkFMhS6T?=
 =?us-ascii?Q?xVcMh05s30uC3G+20mivBbMn6d9mBRcwuV7ycKytiebpnGbS106yerqnJ5ZY?=
 =?us-ascii?Q?R1SNrRQIxoPZ5+308E984N98hbGXVqh60Or90rCUtmgt+nXUniU3fNd0nAs4?=
 =?us-ascii?Q?7o0u7MxtlOeAxIprcO+Qg4kTZWnSHBIFg7sQCe/IEOdfWMIIQ1MOd3yaK2Mh?=
 =?us-ascii?Q?HgZhq2WxswQNffxP/5CvC/DBdUaz7WrbPmh2kSV7bRt/vga52qH7V4EuYFxt?=
 =?us-ascii?Q?+PUX9WOyKuEXfYlz2mqJdxCXGM1BrNqAUX/7jiqPl9JNHNN3rLdXX5EWfn8t?=
 =?us-ascii?Q?HAkM49OqfOyOCp22qV40sgIHEXR6LOpCUL+ZWKkzfkpoVGhWN1HieVXoRwNS?=
 =?us-ascii?Q?zSkrPKX6Zw2JEcjNDKOpW6PkCtsrpLv+PSz1P819AO482R2KuEubbd2ixo+h?=
 =?us-ascii?Q?eIi28DCU2mhuRQ9UKeNS1Xs+yog7oBzNHDSKSKAq85WiTJ1LXltYatZA14/I?=
 =?us-ascii?Q?TClnKzu7bV8csUNnylEGfJqqlhudO0R52nc87QP2ApjjWRoeP6+k+lyM8Yjc?=
 =?us-ascii?Q?Z1f1aX9/gnhX3aaGXfITEAAmk+98FfU0jBdZTBOqSjCu35ZhO2Q6N+7ajvEj?=
 =?us-ascii?Q?4FGY2ZwqgzoYqtwnTzlmEVB2fy+oBFfaEMOsU7CmaTzsFtT5DkppOBlxurA9?=
 =?us-ascii?Q?TIRK+GhXmF9yxwzAl8YVoLAwd/18wZnGThrwMt9PXVYIovEQeoEdC9xhr9De?=
 =?us-ascii?Q?FfOy40kzYKWDyN479ig6SwbDkUv5aL+5h9g4TEeAuyJljjdjXehgHrI/AyV7?=
 =?us-ascii?Q?KXxsUR1TEx8afiFzqXuqvO2lfrLl0hxbWmrMSWShDAGmNshZIEqU+Zl0kgBz?=
 =?us-ascii?Q?uLTgirx+yDPePURPGB1RRu2213h4oc4rvCxhzBKLNiBOUWTkMlf+Z5/bq7Tw?=
 =?us-ascii?Q?BLqc376QLseLxGs46YxxYIFjwEky+YyEoSwXblPdwNgjYgMrZJOfcJHcbfq1?=
 =?us-ascii?Q?WB5mNcHAKsmEjUXVMEWx1AmRhZwJxB/LVTZG0OIyd691RS3zJSdAnQvsj6rW?=
 =?us-ascii?Q?wL99EJJOdEpeKHd8Ge1LsRx1zw/BtfUJ1s+Gs+bMLtGBPXMFGHVdNkSisgJE?=
 =?us-ascii?Q?/3EnBWAve5i9/dTb0dPGDPhkAQitQ4LSx3ELXmHKRI2uBkxe4i3Hzz4EZP2t?=
 =?us-ascii?Q?vrSFs/GODiO9DCP9d5VvH6/BoiPFgirqKJ9yJNxZ4nmDJZkCj9K1di4Ay5s7?=
 =?us-ascii?Q?nfjKIbBicynp0rdoFVS/3enC/PNzQVuyT0zlMSnZkiboT3EqExkaM51PuFHC?=
 =?us-ascii?Q?go6JF7vgKc8qW2xZPGfq6Cl3+oM0KsAavo98tEFEyN+etICX2N9p2IqTV2Tz?=
 =?us-ascii?Q?A+IRKsdbgvYRHcyfVD+x9tsGAHL7q2w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e69253d-1bf9-4177-f750-08def23b8d41
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:52.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhS91hbcpb4uEf72syQ7fizbaWW8VSyJkYiThZ458S8X3RCDKCwoUVUHlifzTnRN0Kg88B9NfXE/fTqvwZgio4T9P8dudWosYAnxXDPXTys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11713
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

A bunch of fixes for functional bugs, cosmetic improvements and fixes
for annoying failures and corner cases which I encounter when using this
script in gdb sessions.  Most of them are basically fixups for my previous
commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
detailed trace in coredump").  Still I did split them up cause it'd be a
mess putting them all together.

Andrey Drobyshev (9):
  scripts/qemugdb: coroutine: Fix selected frame leak on error path
  scripts/qemugdb: coroutine: Get rid of fallback pattern when dumping
    backtrace
  scripts/qemugdb: coroutine: Only attempt to restore regs in coredump
  scripts/qemugdb: coroutine: Don't unwind past the outermost frame
  scripts/qemugdb: coroutine: Fix patching pt_regs in the coredump
  scripts/qemugdb: coroutine: Fix '--detailed' description
  scripts/qemugdb: coroutine: Handle target absence gracefully
  scripts/qemugdb: coroutine: Speed up coroutine lookup in a coredump
  scripts/qemugdb: coroutine: Don't touch the coredump for a plain
    backtrace

 scripts/qemugdb/coroutine.py | 135 ++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 49 deletions(-)

-- 
2.47.1


