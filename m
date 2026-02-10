Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5012BEA3F3A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplEX-0007U0-KV; Tue, 10 Feb 2026 05:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vplEV-0007TR-Qu; Tue, 10 Feb 2026 05:44:39 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vplET-0007z6-Da; Tue, 10 Feb 2026 05:44:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHNMucFQKJY2G2yPFqJ7kAcG+gQeJ9M63TW1ALJcpG+9O6boSqYx1iWXquaFFA2L1aEo46wjVsASn8ujS4WCsCt4Uw+Tt3N5rqoxR5wJyx9PtRsLBulI6RbsWwArmZeUFNdqPe0TqY6xjY/ypMXCXMcGDEvxITFfn5suIfMdKaEnaWHsafI8qPmimrIr1WKeGjgOrhZrjrZz4Duhv+Ok1w6/HwXpJOA2XiYRlKpzOH/bIgR2lBR1TkdyFbELgHPCFWW3Y+AoSILM9dHZwPyafEO0aZeXEwx1ZKYWtcjy0opRIXwOXP4h46uUjyCnNPj8q/LePCuOOoUeJt0LfLPU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3lwgWdi/yGkmyZGz8cbTdYxJohOrqRx+eu7eGNKCWI=;
 b=tVpH0T9hCET2PG7n4MZSXe/b28oAeZ5CtIBjZ9W8SJ5C+x2eCI4rEUluWSKQWo9NIINbIlmQruHAFTr0lhm428qvaqOQyHeHENYrOSlZw0gcJx9KNXtGP9RMQywq607XPBGQJbBahXLM0ZJSJnJe8XYh1WKLbEmTd8e1vYq/VpH0eXaABy7zAZF5FCMccqAmm/nqKKn1efM/WcwGk5kb+YetYKArWAfXqktmbCWkCfRBeEtkslIj7tywkS9wBLq7IRfxWIr74/iZGpWWHF5R3cDHG/JY2F0QkV1KtIl5TZbQtXZFx2sA7zxFG7h6oWJKqEibQdvVzSeFCNLtRNvdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3lwgWdi/yGkmyZGz8cbTdYxJohOrqRx+eu7eGNKCWI=;
 b=BkdWoZWFDK3uYM7wIjsP7jHSk1LmEJFkaPMwGWuOjF7H+le3Np1h8u5XO8qNW7n5MP82OpUzRzhg/L/8iJGBqUF+nO5CeVqDjRyqbaOO51KcRfxA2PtXWvn1N+JDeKPKd0v88/QX1NDLmCXMi263vS5hUaHHkLzkhcc+uwz+yjrz22B0b50H1zNy6fg/iPuZ1OsXZAPF3xtpfvIEdcldjNQwrvdVxHowGt07UbW1pUhz6f/GSM4tPwVsGfwfaIGdHHtqDbqWcQLGkP89OasjgNVmweUTzLxGxJ3CAiZ75Rs+NprJD8E0jQpblMP8kLPoDgXfzp/MggLFj6Daz9AdDQ==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by TYPPR06MB8077.apcprd06.prod.outlook.com (2603:1096:405:31b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:44:31 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:44:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/1] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Thread-Topic: [PATCH v2 0/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
Thread-Index: AQHcmno84Hv5/YuglESHWmaDJP91Gw==
Date: Tue, 10 Feb 2026 10:44:30 +0000
Message-ID: <20260210104428.424420-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|TYPPR06MB8077:EE_
x-ms-office365-filtering-correlation-id: 1366dc2b-64e7-438f-4e01-08de68915f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?O42YTFWhNYCiygrF54KiVvmS/8tOpr6dQaySnnnJBujnRRe1KB0FT1z//H?=
 =?iso-8859-1?Q?/DmAEsUvaYTU5+B7YG/htnH+2lLOnr6Q8wS98kPiSWdjpdPJGTjgySi7hM?=
 =?iso-8859-1?Q?jxNNujBfiFcyNER838dt8c7yraK/W9eF/TOVYcWeRGBdfE6j4Cy0Igc7Pv?=
 =?iso-8859-1?Q?IHz4ZnjauahMkM8mvpJf9hPfFe2xkj4F4Ki300WnUX8svNTYpzEp8uJ6Y1?=
 =?iso-8859-1?Q?VgKxp/gPJS3KpE8pHIF/qZYQ7zk7DqSdc4vRVQC/Nd7ZloBZjfVISALvyl?=
 =?iso-8859-1?Q?qtIIZ2ahipn2fiFa9MkJojnQP2aXP7W8CpU0zaq6yDPU28srm6BdEEAJG2?=
 =?iso-8859-1?Q?kNRWONRskQ+aUBn0xVD9f0XKWv8HG5pjOoWufSAGNXUFtkYOELznbYkidq?=
 =?iso-8859-1?Q?/+RAB5/PR/nny5+40ePPNitz9CqJjafmUCkA5Je4Ut9gsP2JF98odjrl/K?=
 =?iso-8859-1?Q?Ykub3c8GdgnEspc9UwRq8Ykh/oclfsozv2eaZLY6Hap3ca2m1umGmpTLvj?=
 =?iso-8859-1?Q?CnWjTQAJOOaajhxVnamVbrH0IfHC54IISCYlArVi/13dstUWLS/3AzAldw?=
 =?iso-8859-1?Q?jMfKfsA1yKeyNOZpaGenULz+y1eI6qHPm+FZnXN6LjkBYbriasrH7j0lX7?=
 =?iso-8859-1?Q?45xfGXPaX8r448A1RF8hfrucPvJL5h0s58xDpeJOWdm9z/dl0o8S8hSE2B?=
 =?iso-8859-1?Q?tWoDQU4f3ht6UL0rmvzvJLs7wYdVTb9TadQGCqR6EX3ZW3bWwScgJbxIIn?=
 =?iso-8859-1?Q?E4O1HfEjRdZ3nhvzABTOEf7MH/uOlr2b1RE7K9GJrfFcrP7WmXPris5XOC?=
 =?iso-8859-1?Q?gdzW2M2Ux68TthQPQdILxotbjmS5yJHxL+uuPLbMDygEZX09T/zihF7DHG?=
 =?iso-8859-1?Q?PEBK+oPNsVRjWi/g3AKyrbcsMaFOkzK1uBSOUieR8Ixg91U2MXKmWvVJ4F?=
 =?iso-8859-1?Q?axem5LM7Ud5V3+LBj5/XUHhta4+yWMzk+/TRG61oUsF8eezZtk1hv45zV/?=
 =?iso-8859-1?Q?SAIgJt6MR9XGMBrV/F0NUkZlYQJ4i+Yi5IbS3alLlHm/nHWfyZvUZggD43?=
 =?iso-8859-1?Q?+UNqPmYGXerIXLAAilmIQ9Bb13ljKWXoYIirw3vpkA7f/I3gOCRDglihxX?=
 =?iso-8859-1?Q?d8eooqps4+XaMJiKV7ccjdQHEIQRhZm8cdrOZCdiH+ncHhSZH2xA7qYhmd?=
 =?iso-8859-1?Q?8R4FVPhNWxao5SzfoV0SIzW8ampmWfDoFYRZqO7bauaCdnBHZpBesG0d+E?=
 =?iso-8859-1?Q?TISY0Z5tSUrF6ba5kUlKmBovEASntAVQW/BGBlLwNWKFzs8Cml0mv9WvEz?=
 =?iso-8859-1?Q?ro0LBXxF1q8DdZ1FDewI7keRhwAEFh58EuwfboHVJYaYr0idKWswbGRRPY?=
 =?iso-8859-1?Q?vN/B8DTIXD7oIwuJM1J4iLWu2LMgrpiJoefMxaY7l+InDtcTEt3KWh/73V?=
 =?iso-8859-1?Q?BsK+CZuxdFxRhgEaiID7ghhEmXjwAMcsgGmPxrCQgl5siCv35dsiAAZP9j?=
 =?iso-8859-1?Q?Ma6gJR/+ODTV/HNbzgT4Jq73bE1f5XOiSmqswHV0aISnfla9PnuKVN3KyR?=
 =?iso-8859-1?Q?6BhoMiQ1JZBGe3U0Sht50kmdLvF83zkRSzgNPR6VFJH83sKD0GM/mtZEy5?=
 =?iso-8859-1?Q?cE/bp0QjHp6xoDkZphKIosJN8J0zXyGzRTGTgFe3f1/IhqAIWKs9dy6hDm?=
 =?iso-8859-1?Q?4mKX8x0ecdtFiqnOWm8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?se9p5LzY1DO6CYYFZsVeBI+pb7i3dxWEKjHXwmGAcThcDDHd78lpIGosbl?=
 =?iso-8859-1?Q?Xh2XYLLf1etERP+YPmEvwHvu+PCIA/krDJ9d/4WxNdQlQlmODOzz/y/w33?=
 =?iso-8859-1?Q?8ex3cY/AXIVq+eZee+2db0CoGDZ0q8rdgABOei5OsFQHu4xsvGhCz7gTAI?=
 =?iso-8859-1?Q?WvswOB5joKAh/2/QJ9i0S4mFi+g4u2S8zj9R7RB53kNzA6URusbozNIcrz?=
 =?iso-8859-1?Q?9E0KEA7O4GUUZQesg8a8KFm6kvWQUdiNyRkQmjhIY7aVYLHpoGzarCkSjb?=
 =?iso-8859-1?Q?urazaA1gS7rhBvPzrZsI/wfNmQY4aMGfeF0NN7u/aRfzi+ms/tTrUh7A4l?=
 =?iso-8859-1?Q?jANL07MvD170WUon1NOd87VgjqEf4ebq53d0l0QIrqoTLHXc0t1oSfwfOp?=
 =?iso-8859-1?Q?TSH/PnjtjvgexfDNAAM6d/vRaNnyOvnR/gPLybJW182hi5TX5JmDMCamLH?=
 =?iso-8859-1?Q?Gg08mUYIQ6FSuQ7BpRpdiDxUgeVxPxpQFawOrFL8nCdOj4KU6Mb8Qlnaha?=
 =?iso-8859-1?Q?Ybiv+Lv1g/QgtVwbiGk1TtRc8S034AxcpuF2yzw0q5VRyNE83FA2ekf7xf?=
 =?iso-8859-1?Q?73z3pOV0dnPGFJd6fDLgvlStAXM9zTLmFovyWjT4QvScu6Bnvix4TDLsY5?=
 =?iso-8859-1?Q?A1tZSa+2OjSxtvUqfy8ghYs9rV5QTqkrNhlgJLVCr8cgyM8NC96H3yEcyo?=
 =?iso-8859-1?Q?DTG4iKURk8ENdeNw9WpEde5I8tkLe0XMR4LO6m2uNw6clOXHBOpxiAFGaT?=
 =?iso-8859-1?Q?Rivg4+U4TQkhgmSpyUpEewULqi0KPO+byNv4Fm2jwpFFC7FBkE+zOGeUGo?=
 =?iso-8859-1?Q?2je6I0Pc5jFRY2eItFQzbAgve/sxngnYtHrzQ1SbbfBR83c4DRmpHJoryC?=
 =?iso-8859-1?Q?BAOHmV69+6XNEZcyWvo8JV9K1peSlUf01+hlhvlU/j3S5cxOiI+0/BaCOZ?=
 =?iso-8859-1?Q?dn0RFxMCrxY2WBEvESy/5r5AnIVrCsKpvF5r0axgyAWZlP7eDubAvHlnG1?=
 =?iso-8859-1?Q?lwUcaIizOpweiVRJpQAUSP18W7qn1eLqdBtGl/AZZ3qbgdujbhT/fS9zVs?=
 =?iso-8859-1?Q?oIb5xru79y2M5URKgyZPSjoW8Nf7SMmA5kq4bHAFLMyTASEYpb/JNe63eF?=
 =?iso-8859-1?Q?WZqZDEivICyEuO1hkUw/TC2PiIwTmdnNWwM8VwfwqrES9Bv9xKWLEW+d3c?=
 =?iso-8859-1?Q?B/sn6tVp1yaTUC0+9mqs94MqUI9gybWT2lSfY9+VZswtQU50YID7u7ZnCw?=
 =?iso-8859-1?Q?8+7RaVp2kHbIl7qdDcMdh8oNuVEzKa3ysc7XTdQAqJPzJgtLzeV3czERci?=
 =?iso-8859-1?Q?u6ubZXEZlYURc8AN0aNdugm1fG6V00VAlOjHnsH8ZubnWONfJdXbaIsoAX?=
 =?iso-8859-1?Q?cpuVv/nOwej962SZvQD7jP62SIN7vhvUNZ64LHZoiURUCHkdw1xGEGRE8z?=
 =?iso-8859-1?Q?9832yhqyCsfIDgB614LOVFfgGxmrKOyrdIJ4iy/9E3+J3e4D6HoPVPIjMU?=
 =?iso-8859-1?Q?67HOStHbsXRboawPKQElJoFoIA6Fwfrix7BRLNLB1QwHRmkFZd/rveVdWj?=
 =?iso-8859-1?Q?CmlW6JrzKSmf9DCPRSOUp8G6paIAvMB8SF6qQmyhfS0rAeDVXjGTQDLba7?=
 =?iso-8859-1?Q?OMKhbMmOaY6uEItz+DJGkI6kOeJ099Ke7AkpqvcoBdhd/x4buNSlcMECyC?=
 =?iso-8859-1?Q?nTiO/Iopntf1gC3W57uWvWGYr/s4GynF8HMvEMLcR3xK1iXSfY9asIS7sI?=
 =?iso-8859-1?Q?A+OXD6rdKzD3lJgCLdbHRzZJJ++Gtv5TRVlkAMSQDqOf/w6HAe//st4RYM?=
 =?iso-8859-1?Q?6tC9lhzQyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1366dc2b-64e7-438f-4e01-08de68915f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 10:44:31.0279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvLtiiS9JTIRo3QhOPCxozyFsAEfRBA7fGTBOkQgVtQnJOYEoIjJnngZC/XNYesqPeCsTERnn1sRtsqYAYLgzZxeDDbjNQYgHV1RQTD9J7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8077
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi all,=0A=
=0A=
This series enhances the AST2600 OTP functional test by introducing=0A=
cross-stage verification. While the previous test focused on basic=0A=
system boot-up, this update ensures OTP data persistence and=0A=
correctness through various execution environments (U-Boot and Linux).=0A=
=0A=
The updated test logic implements the following flow:=0A=
1. Boot into U-Boot and modify OTP strap settings via CLI.=0A=
2. Boot into Linux to verify the consistency of these settings.=0A=
3. Trigger a reboot to ensure that OTP configurations persist back =0A=
   into the U-Boot stage.=0A=
=0A=
Note: This series is based on the aspeed-next branch.=0A=
=0A=
Any feedback or suggestions are appreciated.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
---=0A=
Changlog:=0A=
v2: Change title for grouping the patch=0A=
=0A=
v1: Initial version=0A=
---=0A=
Kane-Chen-AS (1):=0A=
  tests/functional/arm/aspeed_ast2600: Enhance OTP test with functional=0A=
    validation=0A=
=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 35 ++++++++++++++++---=0A=
 1 file changed, 31 insertions(+), 4 deletions(-)=0A=
=0A=
-- =0A=
2.51.0=0A=

