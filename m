Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E980E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBS4-0008My-AR; Mon, 16 Dec 2024 08:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.malaschonok@sit.fraunhofer.de>)
 id 1tNBRv-0008M8-Cl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:47:54 -0500
Received: from mail-edgemuc218.fraunhofer.de ([192.102.154.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.malaschonok@sit.fraunhofer.de>)
 id 1tNBRr-0004c5-0F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=sit.fraunhofer.de; i=@sit.fraunhofer.de; q=dns/txt;
 s=emailbd1; t=1734356867; x=1765892867;
 h=message-id:date:from:subject:to:cc:
 content-transfer-encoding:mime-version;
 bh=O6Fp/SkmBpCvwRmweyp+HZyGUnh/9nt0bsjaxUvAfF0=;
 b=qklxB4dDnVl9y4DGBJc4BNNMgIbB+0Ik4nUUb8XTwjAuyCfU90X08d+a
 Q8Q6BQ5HzNRpY6NDHmBaj2CcBPYHQpswbAUT2vaUGvpxWMUAGMjDx+Weq
 1fyKKHWyN1llL1qf2/irhaQL+jUgMZAEpvuSgi/wB623jhH3V9QResE+4
 g9qJyNMyppCzwrBo9k1HZ+7ihi2RfEUuoDzwJSy6XHOrKBYuwLHj0rMr9
 LV/W36z5GCZ0ARd1Ei70MqRumS+vgfDNb6j3EK0SraA4ql952WLbK3okf
 7WYtSdqATEb64u6UzNyAkueg5R3v/VhcEKYD9QEiHZBarplzaNvlQV7z0 Q==;
X-CSE-ConnectionGUID: 2bv82GtYQzaRK3RcxK3GtA==
X-CSE-MsgGUID: S75+IMyLSwGeqYYDEVBfhA==
Authentication-Results: mail-edgeMUC218.fraunhofer.de;
 dkim=pass (signature verified)
 header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ERBwA1lN9m/8ejZsBDF4EJgU+CHCiCYYRWkUEtnGqBL?=
 =?us-ascii?q?BSBEQNWDwEBAQEBAQEBAQcBAUQEAQEDBIUAiXonNQgOAQIBAwEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEFAQEGAQEBAQEBBgcCgR2FL0YNhAaBJgEBAQEBAQEBAQEBAR0CN?=
 =?us-ascii?q?X8VCAEBNwE0AiYCMysOBQIBAYJ8gjEDMbMvW4EygQGCDAEBBoJn2D0YYYFjC?=
 =?us-ascii?q?QkBgRAug3uEUAGLEYFVRIE8CwOBBoE3doQqZoMOgmmGXoESgnSEH4JyDQ6CC?=
 =?us-ascii?q?gYKiT0XJYExiCeOY4FNHANZIRMBVRMXCwkFiTmDKSmBa4QYgUcBg1+BZwlgi?=
 =?us-ascii?q?VeBPoFagzhLhVCBBoJUa048Ag0CN4IpgROCXoEvBAWBTB1AAgELbT01CQsbQ?=
 =?us-ascii?q?6wdgmgHexSBeDwpCwtOo2ahMjQHgjeBYoFdBp9dBhMvl0ySeAGYcqMdTIUKA?=
 =?us-ascii?q?gQCBAUCDwiBaAGCFHGDNlIZD44tFoEMAQKCSctcdwI5AgcLAQEDCY01AQE?=
IronPort-PHdr: A9a23:DPaoDBF8AhJz0PaItVYRXJ1Gf3JNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuRPafLb4kAzEirVxiDa2OPerdrdkexSM1
 LxMajbUzzUmaQwEqGDqsJBZ15MO83fD7xYq4b7ee4awG8puL5HXfotEHlFgVfRcVy9CLriFN
 LQyBeYaGv1ojZPgnHUT9wHnFQuoJKTEyRVjmX/044AQj90wHSLvjQcJBNYK6XbfitTyaKYQe
 +G4zrHp1xWeYP4Ihx72t7jBXQ8bh8qjWJdZLNDXxmM3KgzovgWahZPCIDHF+uQyqXij8tFyd
 smGhXFg9gt7gBiU/J4SqNTRo6lKm2r60yB62IU7C9i2Ex58NI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vSZ/OKVrWjuEuzEuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
X-Talos-CUID: 9a23:s8bhTW1qsEbDnoC6pkaYybxfQMo7Iify0EbpMUaCKj1TQ622EnCM0fYx
X-Talos-MUID: 9a23:s/Iw5AaiWbSiFeBTjGCxxxBHJeNT/IujEXE8vbg4kceEHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,215,1719871200"; 
   d="scan'208";a="6261441"
Received: from mail-mtabi199.fraunhofer.de ([192.102.163.199])
 by mail-edgeMUC218.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Dec 2024 14:47:36 +0100
X-CSE-ConnectionGUID: MLWVjENvS0uOq1MCDOPyOQ==
X-CSE-MsgGUID: a+Wp9ac+Q6Wk7nLNXnI9+A==
IronPort-SDR: 67602f77_n6tUcESzjqxLTzcBAVKKiWS16jptirRW7T919w+oKY2d1me
 3RaovmQfGSAf/82NNSxhU7NmRnt80+jqkMJyi6A==
X-IPAS-Result: =?us-ascii?q?A0BjEwCWLmBn/3+zYZlDF4EJCRyBLoFyKigHPoEUgQiEV?=
 =?us-ascii?q?YNNAQGFLYZRAYFzLTycM4EsFIERA1YPAQMBAQEBAQcBAUQEAQGFB4ptAic2B?=
 =?us-ascii?q?w4BAgEBAgEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBBgWBDhOFew2GXRYRF?=
 =?us-ascii?q?QgBARQjATQCJgIzByQOBQIBAR6CX4IxAzECAgKkVQGBQAKKSluBMoEBggwBA?=
 =?us-ascii?q?QYEBIJg2D4YYYFkCQkBgRAug3uBcIJjAYsYgVVEgTwLA4EGgTd2hCpmgw6Ca?=
 =?us-ascii?q?YI+hmCdVoFNHANZMgFVExcLBwWBcwOBFYNggQOCSmlJNwINAjaCInyCTYElB?=
 =?us-ascii?q?AWDaoRhhFiGGoIXghYuHUACAQttPTcJCxtDnG5Gg10HexSBeDwpCwtOpAChO?=
 =?us-ascii?q?jQHgjiBZYFdBp9oBhMvl1GSfwGYe6MoTIUMAgQCBAUCDwEBBoFuBy6BWXGDN?=
 =?us-ascii?q?k8DGQ+OLRaBDAECgknAT0QzAjoCBwsBAQMJkUMBAQ?=
IronPort-PHdr: A9a23:TatBaBOhmi7G/eLQ8UUl6nZVDBdPi9zP1nM99M9+2PpHJ7649tH5P
 EWFuKs+xFScR4jf4uJJh63MvqTpSWEMsvPj+HxXfoZFShkFjssbhUonBsuEAlf8N/nkc2oxG
 8ERHEQw5Hy/PENJH9ykIlPIq2C07TkcFw+6MgxwJ+/vHZXVgdjy3Oe3qPixKwUdqiC6ZOFeJ
 Qm7/z7MvMsbipcwD6sq0RLGrz5pV7Z9wmV0KFSP2irt/sri2b9G3mFutug69slGA5W/Wp99Y
 KxTDD0gPG1w38DtuRTZZCek5nYXUTZz8FJCA13HzDPbV7XWjBelurpi9CygYPbxHZIUdw+5y
 IVCdFj6qXk1CmY4zVuLo5dB2fE+wlqr8j5PyZXTRa6lJKtMdKCFI4ghZGFzU8ZSVAB6O9iDU
 oEDFM0aDcRCsrLTugEU9Au8ASnrL+DF4SBIhEHb9/EDwugCOFDN9RckG4sMu1LVq4n0No0TX
 OKt7bPokDrOMa1/0mjN4afXSDYajvSpdO9qd8X70XQgOjOVhHmPjpPnbx+V6f4di3Wg/clLf
 OywzDMtoSNRmQL2+OVxkqzi2dMv9HbB9j16zqgwK4boTxsoKc7hEYFXsTmdLZczWM45XmV07
 T4z0aZV0XbaVC0DyZBiwgLWQd3eItnO7AjqSeCRJjl1njRpdeH3ixWz9B24w/bnHomv0VlMp
 zZYiNSEqH0X1hLS58TGAvtw90usw3COgijd8OhZJ0Azm6fBbZknx787jJ0ItkrfWCTxnS3L
IronPort-Data: A9a23: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
 UXhjp5CPDyDQFhkX3fo381bPqI=
IronPort-HdrOrdr: A9a23:UDeWxKG9voKcLQ+3pLqE4MeALOsnbusQ8zAXPiFKJCC9F/by/f
 xG885rtiMc9wxhPU3I9eruBEDiewK/yXcW2+ks1N6ZNWHbUQCTTb2Kg7GN/9V7cxeTygdV79
 YFT5RD
X-Talos-CUID: 9a23:Tiz2JG/kUHp36IYvs/KVv2swJf4nX1vD9y/NBFbhLE1Fb4WEbmbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AXENBEQz+a2Zlasu7lVm/ySfSfYmaqK3tN1hcmJ5?=
 =?us-ascii?q?Fgpe7NnN2HxGtihXmAaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,238,1728943200"; d="scan'208";a="13422280"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO
 smtp.exch.fraunhofer.de) ([153.97.179.127])
 by mail-mtaBI199.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 14:47:35 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 14:47:35 +0100
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.48) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Mon, 16 Dec 2024 14:47:35 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPaW1gaS2bviTmtO7d0WtjVuDMiYor/isexdKcmXFBEYDC2ugh0cOFgr7/HJXS5fggvi+eR9V4rmrtaTStHdSyA9378/7CMSwuPie6tUWOl99uIuj3R1kzLGNif25wOIq1FCrATIVxeCAp5haXUT14vhQkGMGjYPmb+LhfpNE50vA5un3NVWbpjpuZ0laTOEHvCIpvkPsXPbhpDKqEsXL/yxCY/3+1xnGh7kNQxjCpSlW2hM2S7I9dCyVx11zPDszenGxSUawhBQUR6Pxc39OZIfkIntskUrAG4S4M8sI0oLi9IaRVrJuxPqEyLJzvE1wRcDS+xik/Ca7EO/YG5q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHJIaJOVT7d8wDmR5So8JHFSsOJAT/zI6ZU0iUR4A3Y=;
 b=A712NNCjbKAPoqQ1QOKEY3PNW5pLOpWKe5eRXeGrrYh/EKKN7qbw6AolulXMmG2puA6/Df+k5GBKYbAdjW49SlTEyd5fckXFXiuD7bQXQK/KyLx4D863GNJ4LhRtFuzi/CRiInVhzKCD8QkEmKqUaOVfRlX8Sca0XwhhlnWF1U0ybuzdfCu3oKqZQCzqBVp6wfQ65Jfa2a+u8o/zEL6l2HRn0xdNS4kpLgoQuN8TP4aWKh8PhRKj1/2Vb19JaDfOComSW5yIwUJVATJPn5zuvmNST5iG/HQNa2utdI5DlTikqMe7lF/nDSAG0BotOBSWIejpVolyq//vpW3qsEG5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sit.fraunhofer.de; dmarc=pass action=none
 header.from=sit.fraunhofer.de; dkim=pass header.d=sit.fraunhofer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHJIaJOVT7d8wDmR5So8JHFSsOJAT/zI6ZU0iUR4A3Y=;
 b=JXbsoMGXx9Zbk063SIcZehkkDSQ3WUbdsOsXJruSFu2r1xjlH/CkBCwhjVEB4QydKA9cAsll1jcNio4ijBiejpIrH5ge66Ac7XaGwRNSGmMA5rngBpUgEX8bDwOwj8DhWrxPuSzKCAfw/5bbJHSR1VJ5pMC79RVNmkpkfFmf38o=
Received: from FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:2b::14)
 by FR0P281MB1579.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:47:35 +0000
Received: from FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a96f:2c20:d1b2:5c91]) by FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a96f:2c20:d1b2:5c91%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:47:34 +0000
Message-ID: <99ec7cb0-1ed9-4761-8aff-e109862939c6@sit.fraunhofer.de>
Date: Mon, 16 Dec 2024 14:47:34 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: David Malaschonok <david.malaschonok@sit.fraunhofer.de>
Subject: [PATCH] gdbstub: implement reset in system mode
Autocrypt: addr=david.malaschonok@sit.fraunhofer.de; keydata=
 xjMEZlBMqRYJKwYBBAHaRw8BAQdAwX7WP5WU2bLmrnUTPDlHqM9OKrtiEQOABoLH6CScK5TN
 N0RhdmlkIE1hbGFzY2hvbm9rIDxkYXZpZC5tYWxhc2Nob25va0BzaXQuZnJhdW5ob2Zlci5k
 ZT7CjwQTFggANxYhBKtyZqNlaP89AoqNOFlMnlKDpXHtBQJmUEypBQkB4TOAAhsDBAsJCAcF
 FQgJCgsFFgIDAQAACgkQWUyeUoOlce3/FwEAseQh1jB+OSmuV89sE9h1f/zaxs/ofYc7Myey
 uIwHAuYA/2VHheBvKA1O4HUchdZLNasYE/kjeuC69Y874sdU840NzjgEZlBMqRIKKwYBBAGX
 VQEFAQEHQMQrx70qy5iQWUYGT40i3+wSNRbTNmYdM+QTXQObekkRAwEIB8J+BBgWCAAmFiEE
 q3Jmo2Vo/z0Cio04WUyeUoOlce0FAmZQTKkFCQHhM4ACGwwACgkQWUyeUoOlce0E9gD/eqoX
 eVBRgUPeTVpbN3yWc/MFq8E6PQvNvWzQf8hLRbgBAPkAfwfx6/9fGrzSgqYTnx2hI0zRsnF/
 anPQGY36Z8cJ
Organization: Fraunhofer SIT
To: <qemu-devel@nongnu.org>
CC: <alex.bennee@linaro.org>, <philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:2b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3P281MB2064:EE_|FR0P281MB1579:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa78a84-74a6-44c6-5764-08dd1dd8321c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEIvbS9YZGJjZDVJWVJlSkpJbFpuTHFsZWRnZzZoaU91VHBjVUVlR3VsYzlo?=
 =?utf-8?B?Vmt6SG42Tzl0KzlCVHN5L2txMVhXeHlxaTF3ZzgxOGJRSkJ2M1VFMlhZYnNT?=
 =?utf-8?B?dXd5YmF1RmFoMlJEdlRuM3BPZlhnME5KRGs4SnN6MWlpazdCQmRrTDNiUXhM?=
 =?utf-8?B?djExbHZKai9YTzU3ZHRiTjFWdnRYVHBvemRBcHA4d3RkOEVNOVJseVYvNGlX?=
 =?utf-8?B?RXltWWZsNFEya3p1TGgyWkI5N1N1N3p6djBlTXF1dFB4Y3VQTWhhb0JiZ1gv?=
 =?utf-8?B?aDBCc245S3B1QU85em9Pa2NiZDVXRjYvS1dBMG9rcWtpQkpKUzJsWWdjTyt1?=
 =?utf-8?B?YXk3Q05iNTBpbGVUZHFVa1lybmdUSXpydnlXOEk0UDR1UTh4TkNTQUVJVFgv?=
 =?utf-8?B?NTZ6NFdEdThQV3NHQkdJZG1QdG5KTWNteVNjOFVWem1DSmRJeHFCdFpaNzQy?=
 =?utf-8?B?Smt0WThIa0JDQW9pYW1POHJPb2QrOFF4c20yRlNIeVk5UXA4NUlCUWc5c0Mv?=
 =?utf-8?B?OU8yaXRCbUo2VzRJanFVQzE2bTJOTkx3V2F4d1N6MCtaZVhINTh3akdzYlRC?=
 =?utf-8?B?UTVyVlV6ZENGZ0UwVW9ndDdQUHRKRG84cjh3K1FUekszckFwdUEzbC9ZK2Uz?=
 =?utf-8?B?OU5uUi9zZG51STVvM21kM1JOdFF2ZkJKVXVvcWVPSGpLdnhvZnFrdVNKZGtW?=
 =?utf-8?B?MlVLNXVHRVB4c25yTm1lblVhdjl5cGM1aWtXbXNrVGJhUkVhUDhEdjBiZHZq?=
 =?utf-8?B?bk5abUpiTnFrZTJQNit6d0RJZEJqM2hzRHp1OFJSWENZVGR0MUZycGJndVdm?=
 =?utf-8?B?N25vd1lWL2hUelg5WmpNZ05jQzlQcTY1SXRxckt0OHlNd0k3b0NoRDZPT1hy?=
 =?utf-8?B?S2hHU2ZMQVJqZEpKYmR1eUFFbE5vMVdLVmFPa29PQVh2Yjc0NW9LaUVTMU9G?=
 =?utf-8?B?dWJEQmpIbVVKaGp2bmw1dkJlREZZbzl2c3IwdzZSZjNWY1dSa1ZyYVcyTTBw?=
 =?utf-8?B?ZTNVWGVGVUpBK2h5YzNpVzdXbDFiMnhnUi94djZpWlY1VnJlcGxKa3JzMFR1?=
 =?utf-8?B?VCtCTzE0V1c5Q1l0b0x3b2JsMFh3SXN0ZDQ0UG1lQnVLUG1zVWhJMHY1c2JN?=
 =?utf-8?B?aThIMDlUbFU5VnV4RHFKcWtUK1F4UVpWYmwzZE9kQWJaLzdrQ1pYTnU1TkNL?=
 =?utf-8?B?ZFVXTWNISjVUUlBtWE5KcllaVzYwYVNMTkJ5cTRoOEMwMzFFa1c3c2MrTHE4?=
 =?utf-8?B?MXhzZzdHWFlRQTFMVUowRWVTYXhYUk4zc2R6V09TMkNKMllkMFlIRkNMVXlW?=
 =?utf-8?B?c0x3WE9CYmVsUDJzQ3J0QW9ndUlZeksvT0VlL01IRGI0WXh3ak5xRHFEaktt?=
 =?utf-8?B?M3RNdTZzWDZ5YXlCWTZKaE5vaXRrUmZtcmphVCtIeTJjRWNyWG9aVlU5bFRx?=
 =?utf-8?B?dlFLa1ZIbUxTSGMxYTk0Z3A5TE9RNVpaZXJaMFVCWXhldVdZSkFVM1hsSGtS?=
 =?utf-8?B?bTA5VGZpVndESDFIczJONmpZUGtvWWVrRXJwUkQ2ZHlFUjNGL3lmLzJPQlpz?=
 =?utf-8?B?dVhTYmlnWXdTcjFDaU5iaW92VGtLNXV5b2EzeVJQbTl1bEE5bTRlV0FBT2cr?=
 =?utf-8?B?WVJuUmZNeUZHNWxqcHpXa01aemN5RVh4NHBpTmFEeEY2L1Y5YXBPbWM4dVZV?=
 =?utf-8?B?SG5lbnNMNDMzZGpwNDRsMVdXeDNPZHp1bkMzcHBVTEpJWGJzT21xbENGRkxo?=
 =?utf-8?B?QUxINmdNN2gxcmdQdFBXYm5ORWxNWnBXL0Y3SG4rTk5yVVovdGEwQ003bFZt?=
 =?utf-8?B?OGhxbXBRWURIVHdNSXJTc3o4NWZWNEpzNG91dnRBOFhsdlcweTFIS1UzeGcx?=
 =?utf-8?Q?wKAkyPphKv9xw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTQwR2NYQzY1QlVUNC9VaHRhandpV2VMeVlBdzVHanBYVHFuendxVmJwRWMr?=
 =?utf-8?B?aGJiK000TEJob0NqOGdQSEtodmVzMnBTTEcxL2NPWFRiU0pidnJPYi8vdU85?=
 =?utf-8?B?V0dQWFBMeVhrT1ZTMDVnbENCUlBWK0EySWx1anl2dGFQNnZHMXJEdVBoSERy?=
 =?utf-8?B?TXZDSFhuWlZsaWtEaTFraXpzeUcyTkIwc21YWkp3WUM2c3lpSkh1d1A2aFFh?=
 =?utf-8?B?bUk5aFNjejQ4SDgxN3J0OHByeTFnb25sY21xMThGYThqdEJwV0YvL0Npd0Zx?=
 =?utf-8?B?WmZSaWJuamkzRDV5d1ZOLzg4NUlqT05VN2xCSzRHalcrRm5hSEU4QnVTa2NT?=
 =?utf-8?B?VjhsOWg3OHZJS2hLc2tlcG1TQ0h5Mk8ydnRBdjliVUFQZ3BzMkxuWGFUeUM4?=
 =?utf-8?B?Uk83d0FNUXpvbnRwZkxaS0JyRjhZRCthZjczV0c3SUxITy9pU3ZiMk84M3RY?=
 =?utf-8?B?cUl6Si8xOVdiRlJKUlJCdW5Qalpta3oxR3I4UERKdkovanVEbFpidUx6Y3la?=
 =?utf-8?B?ZSs4NjU4Q2U4alEvbG11d3FpMDVFU1l2bk9kdkxQM3NHTi9CV2hvRHVhdCtE?=
 =?utf-8?B?UFdKR0p5L1R0QlBFLzk5QXdnelMveHlVbGhteTA1YmdhU2duYU1JeG8rZHJm?=
 =?utf-8?B?L1dGL0dCZUhGMnhNL1ZTckdlYXhhR0VpOGdNZ0tobGJQYXdnYmJPa3k0c0JI?=
 =?utf-8?B?Vk5HNW1xNjFwMnR6a1FiRFR2VU9Jd082NktzSXJjWlExYnhlbmRsNllGQTZo?=
 =?utf-8?B?bk0rR2gxK3NybmpTc2wzK2hPeENYK2J4dW5MMnFickxWczRFWmIzZ1g3c3o4?=
 =?utf-8?B?d2QxTEpuQlJWR0M4Nm1sL040YWcvZ3FBTkE2aEtQZnptdml0VnVCTE1SbXdr?=
 =?utf-8?B?UlVQVHVTRThzMGxYOHNhKzZOZXVQOTNyWGs5dFZZOTVFTWxlaTl4WkdZYnZG?=
 =?utf-8?B?U1VTYXUyblBhb2JnWk42QTMzTGR3Qm1VZzhDNXFDYVNjdm9lNGJ1WFdvMEd5?=
 =?utf-8?B?aXF2cmRIOEkxeWlzbk9xekJaYWhpb1crQkFiRUxaNzlqbmZldTF5R0cvSDJ4?=
 =?utf-8?B?Q3lhR1ZSck9SeGFTcnNFWURGL01xRC9odmVOOS9ESWhXTzh1NEh5YkFJVWFj?=
 =?utf-8?B?TWp6azFsMUpxdE5YN0tuY1RKZWpJK1pGR3pmY2lxdzBWdDliWm9kSkxFbDdH?=
 =?utf-8?B?MFE0Q3VSZ0JkQURNL3o0K3l0ZTFINmlhSitqbEtaNjd1UnUxbkpFOG1weDVn?=
 =?utf-8?B?VmNidjhEcy8xaDk2NFpoVGdPK3M5cGZ4RjN3YUZDM2hMcDQyVkhWeHFrVk1H?=
 =?utf-8?B?MFNtaHBRV3F2TkJFb2QwQnd6UmF4RnlWZHZtMWNlaFRRdGhzcjUvSVNTYmt4?=
 =?utf-8?B?M3FjWnRRMGNmZkhiUzNVRHhMN1BBcVRtbVIzNTYxeGttZzBzVTNSK0F2Ymo0?=
 =?utf-8?B?SXBoeEJ4VSszZ3hobXdZZkpKRXJpQ3JHOHIzRTlpZ3ZsaHEvOVNmNkdRdFFv?=
 =?utf-8?B?c0tHSFh0bEs4YzJQdlZJdmhmTGtmdkNKL1pKOTYwUjlnWldoVDhHRXd6aU5x?=
 =?utf-8?B?UEdrcEE1dUE5elB4TmZEVmlwaEdpVmlNZHY0eVE3dzAwSnZJemxjYlg3UmZQ?=
 =?utf-8?B?Z0NIRmQ3VHhZbXBpa2cxZzh3dXpJTTl2clJKdER4c1dXQXhQamh0QzQyUGp3?=
 =?utf-8?B?WE1LeHZGMi9GRkFLc3FnRmpDbDBCL1FjV0lGNDRWcDNNeHZvRkpwL1I1Zjd0?=
 =?utf-8?B?T2pVUFJHVXdqcVlFeHRxMVQzbkhvdFNvcEh6MHVTUmpOYkFoTEJXam1aT1hu?=
 =?utf-8?B?ZFkrV01FeVpHeVROOExBbmFJcURkUWNsVDJnd1BwektUMml6U2tVcms5MXBB?=
 =?utf-8?B?R2hHaXU3V0Npcndtd0dNdHVwckwyUDd1Tkg2Z0VaYy9Za05PNmtZTjVkMVN4?=
 =?utf-8?B?T1JwKytWTjVMK2tCRzVsVE9TbFBPSmJOdEdHRzV4cFBDSS9LT1RQdVY3akRr?=
 =?utf-8?B?QUljVGNCNkpnSzkvZCtCcXE2di92aXU4ek51eDNpOU1NTlJiRFlKOVl3eDJn?=
 =?utf-8?B?enR3ZmhKRFBmR09NSW9lUGtXc3RYUFFlL3h5VUxTcEFZMDh1ak5YSkpBV3g1?=
 =?utf-8?B?bmVNQXNrRXNtamNTVmg3b2VsaEpkYjFRdVRTSnB3M3dwYkJZbVRLMnhjUThp?=
 =?utf-8?Q?Izf9Zs/fR9Dzo2BWAgwQm4E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa78a84-74a6-44c6-5764-08dd1dd8321c
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2064.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:47:34.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta+4F8wkuKJJfTAtkUxSiyejTTKjNvztGxwymNRP7BKpsLHQ+HlrU1TW1O+YrwLnEYLUIF6iK6WyxvXHEKF4WOgShIx0qN4rKpwZSSYjsJLl/WKjXutrOAW20AGxUC9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1579
X-OriginatorOrg: sit.fraunhofer.de
Received-SPF: pass client-ip=192.102.154.218;
 envelope-from=david.malaschonok@sit.fraunhofer.de;
 helo=mail-edgeMUC218.fraunhofer.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Added a handler for RSP reset commands `R` and `r`. In system mode, we
call qemu_system_reset_request. In user mode, no reset is implemented.
An error packet is sent instead.

Signed-off-by: David Malaschonok <david.malaschonok@sit.fraunhofer.de>
---
  gdbstub/gdbstub.c   |  5 +++++
  gdbstub/internals.h |  5 +++++
  gdbstub/system.c    |  9 +++++++++
  gdbstub/user.c      | 13 +++++++++++++
  4 files changed, 32 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d..ce2e2e8291 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2093,6 +2093,11 @@ static int gdb_handle_packet(const char *line_buf)
          gdb_exit(0);
          gdb_qemu_exit(0);
          break;
+    case 'r':
+    case 'R':
+        /* Reset the target */
+        gdb_reset();
+        break;
      case 'D':
          {
              static const GdbCmdParseEntry detach_cmd_desc = {
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c6302..c5b448e38d 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -154,6 +154,11 @@ void gdb_continue(void);
   */
  int gdb_continue_partial(char *newstates);

+/**
+ * gdb_reset() - reset target in mode specific way.
+ */
+void gdb_reset(void);
+
  /*
   * Helpers with separate system and user implementations
   */
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c9f236e94f..3636502c6d 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -603,6 +603,15 @@ int gdb_continue_partial(char *newstates)
      return res;
  }

+/*
+ * Reset the system.
+ */
+
+void gdb_reset(void)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
  /*
   * Signal Handling - in system mode we only need SIGINT and SIGTRAP; other
   * signals are not yet supported.
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c48..6886cbfc20 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -657,6 +657,18 @@ int gdb_continue_partial(char *newstates)
      return res;
  }

+/*
+ * Reset target. (currently not implemented)
+ */
+
+void gdb_reset(void)
+{
+    // Not implemented.
+    // By default, the RSP reset command does not trigger a response. 
We respond with an
+    // error code here, so the client does not assume the system has 
been reset.
+    gdb_put_packet("E00");
+}
+
  /*
   * Memory access helpers
   */
@@ -751,6 +763,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
      cpu_breakpoint_remove_all(cs, BP_GDB);
  }

+
  /*
   * For user-mode syscall support we send the system call immediately
   * and then return control to gdb for it to process the syscall request.
-- 
2.43.0


