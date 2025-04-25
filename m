Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65AC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfn-00048r-64; Fri, 25 Apr 2025 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8HpT-0004Iw-Dr
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:06:52 -0400
Received: from mail-dbaeur03on2128.outbound.protection.outlook.com
 ([40.107.104.128] helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8HpR-00024p-9z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZn/34uTDQPRHPOxUG/Cd5aK14X4zTc69V28bxshh+JSOSDQSKqXs0hA7J2Halfi+1ybLMzLvByevSbD1vLcM7FEM7dXHFIsp54WGiVO18uF7hLQgEGmv1FGIvifA7t0f32Ej0nZZieZh6bHnLWyEP/rqLUpJ28/aETb5ekZcSAoQkSMOr+iG2dBCXt41aIpEH9BFpmBRm9/1GT1bPm6d2NBMAZNeRq8dXQYpprSJwytQ2IYg3iWIXMHjO68lSH/ViXZhpkdojUigE/0c/CWg1YvYqcvPThXKVjtsh5ajFez7+6OAgIX8kicYW4StNRDBATAxTZ9/LOcxiqGV10Pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUaJscyj/sNlQuG1ATUTDHubLgSLOugc79OTNReJszk=;
 b=hZRuCyPyU4BkourW8t+xJdRwtb9fMRmn3bgyCYW0k2gXdg3lJvJCEhpFD/veW1C/GnIeO6m7q3dXKDYKL97sydeecttLZILmt9TF0caT4CoBc/zHdVHA3Lmo9w7dAHSKQfIqb2Jzjyau5hKxMxA56mLcOLc4QFdolbhTLweFNb3uqW4S5VhdTtBJI4LqHNT08Df8taLjSGdhnIl40bxEIwrsQUJ7c1DmL3SPaZHTkESjKH+dUFe1r3FylptiF4JbI6bPz/BEO9B7Cy+xRcXq+gPSUNl7P4giBTbe0lcBCQCxtLgh+StbVb49nO7wecUt53YM84oLsZjhWlEAmaqaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUaJscyj/sNlQuG1ATUTDHubLgSLOugc79OTNReJszk=;
 b=sU4UlZbKJwO1m+btbgXlnnHtu1myJp8yDMd1Rna+9/K4os9Mrtudu2uX2ghoiHPjbFeLuyGz/oCWHK1kJkgm5LLSfqS3nwpO0FA+wWPvDzFd5/xUMyH5SIIX1OfLucCzgH0KeHVlddndQL85zm3PI+7mxrr7mCdHhYIiV6NaggurNQh9pGfQYpRTiJigIVzW7Z9BsU7ATIJTwhpmXJxwWkyojtZJr3TzSb7deAznmIA4CP9v9PxYzrU8zMMRYfaJXj6wH8eZ0vVVVj6IE2IMbQvBLCftIBVa+sUgt/xj4j8Y8yvEf581tBogKOpD22AFGjpBbYhX5CdlXXdivUWLlg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM7PR09MB3976.eurprd09.prod.outlook.com (2603:10a6:20b:114::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 12:01:43 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHbtdnPg6UqGZxYdk299xj/enHZGA==
Date: Fri, 25 Apr 2025 12:01:43 +0000
Message-ID: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM7PR09MB3976:EE_
x-ms-office365-filtering-correlation-id: 099c146b-87f1-4347-7f61-08dd83f0f1f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?W7ovYexjcyvhprBwvqW3waaxyggkIXrrUKGwg0rEYKR4725ZcgKBBjo47I?=
 =?iso-8859-1?Q?LPPUx5bpZfGQhmpFjDMnys9G5Ms1bC0139R+FTR5e3BvEvxgod8Mhs9Z9j?=
 =?iso-8859-1?Q?splmfMctxzvr+i+2N2PAJr/viiNcycppCuqwCDXc/0uGUIn9etvANrC7jy?=
 =?iso-8859-1?Q?EvXrp4qT+cMHpZkeZ4aD3Row7ObkyslAsqJQMtLs6zje3b6egcj2uzyK9Y?=
 =?iso-8859-1?Q?6uEihLLUPwX4NlNGMinXj2kLxK/IdMl7PGLlUi7vIkPQ4lCRnHlWCvM4GY?=
 =?iso-8859-1?Q?vs3BTZ6xdJE1CMD4uot7dhUFJZT2AQ1ZKpRI+SKH7KRqNt9H1RzyuntVke?=
 =?iso-8859-1?Q?GJ0wsLz+tsPx+U8JSDfWJtM5dZuGtlNrgjDsbosbtb9CSIiTFDaR6kDEna?=
 =?iso-8859-1?Q?8TNYOLCBPhOY56HhhdXvATo4dhImyw/UkbgvUPfeIq2E5181VK449Q7p0S?=
 =?iso-8859-1?Q?oL993hJm/nJoTqMOeT2f9IItGbTA4CZRK4yhUB4VzDcMLdbmfy2qDBtI1/?=
 =?iso-8859-1?Q?U3EhMSWog0gS7IiuF+LYZrYfGTWSoQPes5YHdBzpHsf3ZhjMWlPYuucMNz?=
 =?iso-8859-1?Q?pmby7FkvPkWM/sEPp6b4xUsLSXOIg8/VTN7LmYPZh7ljBkEvjHZJDVqdyx?=
 =?iso-8859-1?Q?5hDqzv8s7cW+PE/WV+WUC4XN3WylcOVXSF2Ux6OGEZ+1Q9CSCOZEXQdX9d?=
 =?iso-8859-1?Q?zXh5qjBquv9UxPOF4wVPRuRictKfzYDgCRsnFs4tHNKEG+pYp59LQsV5X4?=
 =?iso-8859-1?Q?miWLTowvX0B9Ui14qUoHI7QLPphgnD3go8lxHrMEWYCeoZr7mr7KSXjIgp?=
 =?iso-8859-1?Q?syz7bLB7d79JjsGiah8tyvFkwE57KKICwhDljZp3LUrgCzIJUnNY6OQ235?=
 =?iso-8859-1?Q?rbUYrCX0359VrPxQtjZOqUJrcA3H6/ONuYto1V2W0tGO/ijYn1b2n+t65M?=
 =?iso-8859-1?Q?q1PVK4a+2/CN3TsKvEYOCTQAU0FBdvlCRfB0D5H0KYi4z5ODP0NSEydvFp?=
 =?iso-8859-1?Q?XQcTtCk3MgbQ37UEnbbDm/PS7sjOcsfkyGQ36XycQPJ+glFykp9fX+bxF1?=
 =?iso-8859-1?Q?fKXy/U/SBTSIEicx2sZPiKwCobUrl30fA6I7FY2MsOmCSc20Sl+zuTKtfQ?=
 =?iso-8859-1?Q?dpFiwf9N1yHo5j2mgdSOZexa5+zwAp51Fha3iEEK9xIS/lNpgeGl8anfnh?=
 =?iso-8859-1?Q?uLFJjk4CpuRUZbaBCMUFy/jwiUC+pSfwg08sevP/+4AbeGt1uz7Ku4r2B2?=
 =?iso-8859-1?Q?PfCwrcAXPyu+tmey5uPwfI9O9uRcL7kfFLFDN/OA10eEV4dbZLRhXCAvqW?=
 =?iso-8859-1?Q?3efNpt4BFErq0d7aBODUve/XqRhz/mLWrCLF4IUIlmlYMNpuDWW1gWnxR1?=
 =?iso-8859-1?Q?+HsoLWlCJqyr34G/HIB1JZcR7Jjc5FHz8b+qzd1aZqdH2yN/ISXDhcA8Uf?=
 =?iso-8859-1?Q?J7KuvLX6qplO3ocO9pZA2vPr16UOK6ckydWBno5pf3xE8MfyOrbcxsxgsi?=
 =?iso-8859-1?Q?0ANhRwfM+rUVpAoxwBcRW3oyo2ggnbHfa4GQaKrU5SD1xs9d1GgP33FMho?=
 =?iso-8859-1?Q?xOe3RuE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yA6w+fudoETaD9Bcn8fSmTiwTsBzivUOzlHcU9vBWYdYPGPKX/D1imBS2D?=
 =?iso-8859-1?Q?NlgKQwRITIZ4w71Trx18HicAbpSEFjd+UMx8gq+f3O3HtQNdE/nJD+z8Zh?=
 =?iso-8859-1?Q?IFgxJoMBIoBgNCbi9tyH3NAuifrqWpXwJbAC71lqd0m0Ox3n4axq0wgpwr?=
 =?iso-8859-1?Q?g+EgSPDmozDphDk1IYBsI3B26QCplEvD5eArHx0cGmQXwC7IkI25xaSvoj?=
 =?iso-8859-1?Q?MQnxjSfNWMTNYNhqlb92MmoS+pLCdaz+RaaA7YPMhfSu+9VfFZhZvFIYyR?=
 =?iso-8859-1?Q?vPWJkLaeWkX68Fo1ld3GGFl8E5se6nLmT0VIXyv+zUHQHCKSIxYsZBZLF/?=
 =?iso-8859-1?Q?n5x8gt8WISsIajIp4Qr+aTzcvMgim9++LZsgb/lmQFRx76T65qjHQ6nQb5?=
 =?iso-8859-1?Q?F1FHpWbgTpR4RDDo2T+gfM497N7JUKV0fJVMFtf5ojaQUYftOHFlO8kkPt?=
 =?iso-8859-1?Q?r9QSJQrlbX1F0S+vmVa87MDQ+d9qYvGmJ4lqloSfdb4Aan19qlBCIAoZZg?=
 =?iso-8859-1?Q?udYtHqfVtSTfTqJ+ZwX0wC/PIK82d7c4CUyK/gA/M+2747REyhXRc4LTDg?=
 =?iso-8859-1?Q?9vzwVIIX760PDi0Jb6QSy/V7QhGuKjexyUVY0n00yyQ+ss2/IrccbxX9E6?=
 =?iso-8859-1?Q?gaYXKlFW2o3f6KvkG4116ZkPMwit6PZGrY1mf8Nr63tKW2gjyIKuXSSIyT?=
 =?iso-8859-1?Q?SNoAwsljLbRaxou8HGPtJZMi6NahJdumg8ZBEb44s4zeqQ9W/9mb1oYY0+?=
 =?iso-8859-1?Q?WyW3IJNQ808zw25mjBah8Lvmnhk+JmIKJjkQSLM9F3idf0SelS0xO65QDJ?=
 =?iso-8859-1?Q?DAySIBxamzm1vfpuzBa1MLYTfM9xh3ig8Va2W/S0qYeyT/fm7hubjLERs7?=
 =?iso-8859-1?Q?n8e6gRHE+JpERONjLiBEPDRfvJsFaNwQGcFR5OvKIZDxZJkWquBxmeDcpr?=
 =?iso-8859-1?Q?Iv8eeduUWPLGYC8idIBFoF/KDBNpMBGxD0CWWNPbhAqBYZcbLpmXNsDpQl?=
 =?iso-8859-1?Q?StgKJt3jnUQ/VV0ViWiVfFX6/WGoEPH94fx5jwj9ZYQqO+8cImry47ZHJ8?=
 =?iso-8859-1?Q?aU/TeiiO9tsvj2p/VJvXlJ3yI4J3RqV/H1dW8oMXFPB36P04rDk+0+Fcuc?=
 =?iso-8859-1?Q?2H6f1OAXYbMCoTFGtK3zzyOG/JrEz+PrOX1FGu7jiCqXWyLp4+wfUysh/C?=
 =?iso-8859-1?Q?ZsooSsQhm8E9dAREOGvLHM+m7D/HpEbdO/eZuCvsHIu9U6RMOsmtav99wV?=
 =?iso-8859-1?Q?6T7IsJw/kF3HUMI2EDANCVhlGe/eAw1/dpwMpsuOfhKHNqF+DBocUS65FB?=
 =?iso-8859-1?Q?I34OJCnQ2l9MVYV7v/8W8/hpL8sAn4mgHcjMUM4hlp3fAuCYI0sJ55D5xl?=
 =?iso-8859-1?Q?Gcm7vxqW08g6Y/9OY0zZ2yFU8Ao+V5iyPg/bp+gCMgoXPmxzsEug0NEYGl?=
 =?iso-8859-1?Q?8kfGlmI2CD2pg0hU6S8M1gKpsbpOdQyWoAjkqqvDAXsDMq7ZPDB3p+QXl5?=
 =?iso-8859-1?Q?ROyeIpmwU+UdWVbNRTHa6naOgIAASKYGBG3t7Kr7W/+tYQ2haV1jGG42gW?=
 =?iso-8859-1?Q?frdQzb61SiI+fumwR9pyEvGbVod6vZ1GoQk1aecgX9cPbfTfHRlwJBNeme?=
 =?iso-8859-1?Q?YCO/03VyGG3eyIDoS8NGzPCfCdW7e3h2K0hUNnjUHO6fT2D4oadSEGFvHO?=
 =?iso-8859-1?Q?sFjKqcU5dlgVDTXCYVY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099c146b-87f1-4347-7f61-08dd83f0f1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:43.1489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtUiWQjlyRqdKVD6GpjMRHTNbQWOclDMpr2Fvey8mA9gyuZiQL5vUiPKP/NbUAU3qnLz58fBgAGZpZVi//2i/7lY1MzqVfdjNoi6HUAbfl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3976
Received-SPF: pass client-ip=40.107.104.128;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds support for MIPS P8700 CPU based on RISC-V.

The P8700 is a high-performance processor from MIPS designed to meet
the demands of modern workloads, offering exceptional scalability and
efficiency. It builds on MIPS's established architectural strengths
while introducing enhancements that set it apart. For more details,
you can check out the official product page here:
https://mips.com/products/hardware/p8700/.

Djordje Todorovic (9):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  configs/devices: Add MIPS Boston-aia board model to RISC-V
  hw/riscv: Add a network device e1000e to the boston-aia

 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/intc/riscv_aclint.c                      |  24 +-
 hw/intc/riscv_aplic.c                       |   9 +-
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 203 ++++++++
 hw/misc/riscv_cpc.c                         | 221 +++++++++
 hw/pci/pci.c                                |  23 +-
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 484 ++++++++++++++++++++
 hw/riscv/cps.c                              | 184 ++++++++
 hw/riscv/meson.build                        |   1 +
 include/hw/misc/riscv_cmgcr.h               |  75 +++
 include/hw/misc/riscv_cpc.h                 |  66 +++
 include/hw/riscv/cps.h                      |  72 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  39 ++
 target/riscv/cpu.h                          |   9 +
 target/riscv/cpu_cfg.h                      |   8 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 226 +++++++++
 target/riscv/translate.c                    |  11 +
 target/riscv/xmips.decode                   |  39 ++
 24 files changed, 1830 insertions(+), 16 deletions(-)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode

--=20
2.34.1

