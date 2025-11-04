Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A28CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIht-0004jN-IB; Tue, 04 Nov 2025 10:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGIhr-0004jA-SM; Tue, 04 Nov 2025 10:12:23 -0500
Received: from mail-northeuropeazon11021135.outbound.protection.outlook.com
 ([52.101.65.135] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGIhq-0000vX-4P; Tue, 04 Nov 2025 10:12:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xru5aG+b65hj1yJtZBY6czZ0H/sAU9x/iHysH5FM8LVzs8RM5OVSm6C5CbvPqgZ4IDngnbbq20RwWbGHdwW7x9xon6TL7EDElqxaHMSsFPp8tBztlypkouuZ3CJOMot4hDZzJZmlb/ktM08IeRe4oNNGsH+2LSE6U0Ef/2GmfYRJVyLCPt+DzGt5RJrODZjDLhKxP2h9+0F17J0qeWWmvl0dUHlpHmlDTKJ37c1kJojlRYwCKqP3/m+fFv+A5dSD759TH2F1xPjKDYRaxKMKyiYMOp+Zn/K9ZGy2MU1UXpPf2YO0PEbMCo7PKnWB3Oj8N/GZ7/DB+ki4LxGHz0jxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5loYhK2ZgW7nHj70rL8Xu/I5xnXM6n5P8h/xvw+cTmU=;
 b=vHbGVTXR+tenAgVUTPcpGkhfC/sQ/MkuOZ7w5WOJVhfd+TEfND0On7kpCxip5L36DR2bjq0JWaZSsUdvWVq3Tnes5bJT4B92i27vMFvbqn/EVvptwD2fhrPimsKAtVPX8jsYZxpkyMjUogvmP5Rjhe6surJWMMNzx7B/l5IY+X4fR55fvFRzN/RRNx3b9dyHdf0esEuUfvKP9mooxaOkOTmbwZ7auqk9WFptMOsHcvDrnmhvHVgLPUz0VSfNW1ULzaavOAzPPK7207m3Y0zhwf6AveJtM9ZcxjErYl9AqdVDmc4V4JCE/4y9lGgowV1y23RpS18R+TReppiSJ+wmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5loYhK2ZgW7nHj70rL8Xu/I5xnXM6n5P8h/xvw+cTmU=;
 b=iwONZ22D+FGBjkd3CLK8zDsNQ6dHkw6FF1P8C3rJO+EpURrVGh6CfyNWaOH31PUYVbRVo74mfcsB5/tmg+8vDrGw7ckW4uqFLVaI5xcsVrlq1vIfXU/VQ+c1iYD3FCt+I1GLT7m5A51PlSYARXscdkkj4X5GV0zGdnHya02qi9E4cS6Xgg5lGK3/3bbRhVK0ITCat5WOhfxpI1biQuIJT7+B9J+LthU04S/D0YzIPW51nN5Lu3+E34hJ+3b3qeQXolG4U1UBVRtIBh8Tr+KAVwTEbkwkg5LC/EC+wPZgli0fh8dngQgooe6jwcVV+pXK4rS0QFZXmmqLvc9VFmNNKw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4155.eurprd09.prod.outlook.com (2603:10a6:10:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:07:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:07:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v1 1/1] riscv: Update MIPS vendor id
Thread-Topic: [PATCH v1 1/1] riscv: Update MIPS vendor id
Thread-Index: AQHcTZy1Sd15rcbdwEyQ5vI1NegyOg==
Date: Tue, 4 Nov 2025 15:07:16 +0000
Message-ID: <20251104150708.3345289-2-djordje.todorovic@htecgroup.com>
References: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4155:EE_
x-ms-office365-filtering-correlation-id: bb6c8a57-ac61-4e44-4990-08de1bb3d7bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?m+mrO7vwGpOFG5TzrWW6Ab3YbUnfXrOgLsFrYlJlpQL8Ygcu8pm6Zio8Oj?=
 =?iso-8859-1?Q?z+Yw2Vx97dZEnAUVNiaEdnsXQlQtY6xmEEHLORg5rvH2zuBhW62Dp4lHd2?=
 =?iso-8859-1?Q?gCoYOVvh9kizLM+CeP5jMTabuVZluh2cKorsmWOxXjusJTlppQx/z0fda5?=
 =?iso-8859-1?Q?7KYqdlMtxNwiIIDeWkLIVZZXnZuMPkromIUYZwgeurHumP8JwjbDAUAhky?=
 =?iso-8859-1?Q?oYnXTWToUD6HEgvF1fueqDDgzZj+kQBeAvHEjN8bZNV4Baj7yqWJlG2QMo?=
 =?iso-8859-1?Q?/55UxVM/P7obaub7j2ctcvjizJob7HK1XI6I5dlWnivhvvZynlnCeLk4Wj?=
 =?iso-8859-1?Q?k+cG3wndkjqkmmsbYAlzOsIZ5ZORJze70Hci7CR7J/wmrIqSXcmQrShPMS?=
 =?iso-8859-1?Q?yDsDDuHNPKDmyTGzw4yRMXgiWdM5OJRITglP/MWM4nlD4nejySwzJIYifI?=
 =?iso-8859-1?Q?YgP+LGXB1Hh55wfiaaT94XckDre0cfVfZdCOB828EL/A2KiyxmhlVa6QUP?=
 =?iso-8859-1?Q?xbPwCMyC+PGKKjtRXUEZB4BUHvdRV4R/jTtlyppOfcrRBZ5EDFiw99FUgo?=
 =?iso-8859-1?Q?b0ZEJfXPbb6SD+leOjOcdKd5WioPnFHcZorXui2pr5BnmSLVMbF3S/qL3n?=
 =?iso-8859-1?Q?kkSO0gewgH5zGaMUxj9GNxNmacoEY7PQ7k+RFy6J+ORMu/mQH3ftG0Bfwq?=
 =?iso-8859-1?Q?AGzFHZlpgkJ9R1uvn4v44y0gkxkTvF6JANoY8MxoK9JTrDKaiLsxT/Nrw8?=
 =?iso-8859-1?Q?92DmgZTRZMxPkBA9rwNV13btS/QqniYQXD2kEmgIdzE/T9rAXMMMVYUjB2?=
 =?iso-8859-1?Q?jhxjNU9EpfJffwvPdSFPI2BCFXRyp4oFE+E9bK6IruM5nMmHyTHMy6ctwX?=
 =?iso-8859-1?Q?9goFWgnLrL32DWAgBy3ZgvzTGGEXKkhGXbTefs57V28w3ewwpJ91XV5D2J?=
 =?iso-8859-1?Q?foNp95S+adsTQFEeDoIlmsbdP4CXQCmwlJdCR+g4tp2Dou3m0jSeIi0BPU?=
 =?iso-8859-1?Q?uPx4Tot8bycRYJ2505/CtGSc5QlAdg8n13uHG96YDV2oAlmelUwgQ5RSyz?=
 =?iso-8859-1?Q?HEyUyi6zH/dQ9dszjnMhOLVzbVjbFho+4Ibha/DGr0h1b9DC55Z2aQztSz?=
 =?iso-8859-1?Q?CO/bP7adN+TovnuB9mG6n5uCTkmjq3Wb6i8+hBl9kJxX68xfMSHXEgQ3JM?=
 =?iso-8859-1?Q?yHI+OPhN8TpvzXOfyHIUQQPF6sxSZVtqbs1uohOtnYjraUCinYTKsGkJnP?=
 =?iso-8859-1?Q?22Ho8T0k2c1g8qYL0YeQ7AtaXebSgtfGefsl9uYkRPt9fHMg3cqD+Fv+Yy?=
 =?iso-8859-1?Q?oVyElN0Zo5h2cCi1+qiYt4LB9gdzgIqMoqeX7KAJIVcpWOvGsqvwqemmgj?=
 =?iso-8859-1?Q?t8qhI5hgQd+2PV4oQTRZl3T641pVp81W+30bVjMseONmLFcD1XzUhou8PK?=
 =?iso-8859-1?Q?nG/jOBooDtD5RLmZEL7bFPyFx5Xu3j98Z6QmULzkR/SbfEyyfid4DUe26/?=
 =?iso-8859-1?Q?YUENeS+1HJnRDtVwiEy1LyaRFEKqOeVH8cSLXbDSXB/lngU00Xs5UeHWGe?=
 =?iso-8859-1?Q?W7S+99nB2N57CXV2nepmFyDh3KVv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vtkIq0nyjID4CryahE9X9uIsZB3g+8PuzMDzdIhaoYS8cilmz6yIJa3/4o?=
 =?iso-8859-1?Q?gNM9G/1EHFc814QrnGlV/XSVbvTKCpOVFV56mZSmKgMySzrtIeLtwpqDy8?=
 =?iso-8859-1?Q?pVF+kO+j/vQj7i8vu6u/YfgY/QmkFBEsMCbU2a2fB8LzCkBjhSL5c7LvfR?=
 =?iso-8859-1?Q?cA7YoSLRdrTVL1wLaMpjzgI/F01hAy/g7rYUWSLkvxcc85+V2lDiRkPxXQ?=
 =?iso-8859-1?Q?IW3FvZ1XMdNqHAT4aZ5cbvSs64KbEVR80SzWwaOAY61gjBIl/X9AIatY4I?=
 =?iso-8859-1?Q?O+J07m63cNt+gWnXSNkoUj325Hfum/ZdB3iaWzJAfJQOg2iCxwWjcEpIPS?=
 =?iso-8859-1?Q?FhczvwXfTljoLG5TiMowd7zK4H6VhGa8RJjDdfNVaB+WdUZ38zsY4mdqQs?=
 =?iso-8859-1?Q?Pp+5QPGbKODA4ErnSovirl3Fft4iEiiRJaux4tZGV2eQvgzzVijMh+Fdge?=
 =?iso-8859-1?Q?NBp6LVIINXpcANhfpOkywHwxqDf469ahIoo6l9s/yIZnVmkpZn+nJAD/rx?=
 =?iso-8859-1?Q?DlaO1L7Na1YZCdZKLUTPqOs+oZkU5DVnvV+Z6gC4tbdfvVr0fLNw7JZF8L?=
 =?iso-8859-1?Q?biEXbMWNxkY9CPp9pIXMdu1I0lDi8Q724WKuRetjbpqtI8TLc1rbfT1pQ3?=
 =?iso-8859-1?Q?/Aq7rJ/OevfMQZ1CZIDl+aAqwrlU8DnJ2jZ46pv3xUlEbKuG3ZyXUFZTOE?=
 =?iso-8859-1?Q?mFkOG+6Lm+yMs+H8oD5CJh7HAaWL30qodMCG8MM+MFxg3YE5SU/SPPxUxv?=
 =?iso-8859-1?Q?NX8id4LYr70RtrnALxhCFHFZuoAA7bV+Czzk746CaQ530ycyUgxfIvTQ/I?=
 =?iso-8859-1?Q?da+wIbifFvqH0AIbND5b39gh2GXFG1ss9UNSFoOpbCq//4a0zT2UP9zyVv?=
 =?iso-8859-1?Q?3O3f9JEgBXAv1Hspkh8BOtgPnDQzPMMw3RSFXol88/5km37JWxUvYLLxpY?=
 =?iso-8859-1?Q?sZvjJkp00yqe7oLC0hhdCKZmT2bpED967ZvBQ4Q1aQqe6eDlJNovThKzH4?=
 =?iso-8859-1?Q?2EIehl+x73XE3WEbPuyFb3tqROFwA1J4PF59pGTYnLsJyHq6+8EdpNkCOJ?=
 =?iso-8859-1?Q?mUPXyHM2sduNSseVtCLVjG/nTK+SLay4XCJnqg4gqsIx2VUz/uGO+Vw/2/?=
 =?iso-8859-1?Q?B6tdH0kNhrv1azakAZpfMxHS/Ba2U1LEJEbxLdPKlR3dndhYQx5Wo5vZ/a?=
 =?iso-8859-1?Q?vAK7zsgD7WBaLCfUMyPGUOFa6T3coB9iLASpy8GOI1+UD5XlBIvrL+y3BZ?=
 =?iso-8859-1?Q?cOTzdvqD/WGYo3WTfWr3ay4RRFDCHE1WRsYJw6oLNyP3q87HeH8PnAzW5M?=
 =?iso-8859-1?Q?Zv4Edu9i9JmTdpaYDPgLz4cFDBmk06fjSEiGIVz/qnBl1aC+tPgwUmsuF5?=
 =?iso-8859-1?Q?0mB4+UAqY/FRP4SEqBRdip67Hs+GPGBBiF6a2l22oXtvRxALTy0T25Rd7n?=
 =?iso-8859-1?Q?E1EqO2EFDhDS+RuInnAA2MVvIjIgRWrIOXy272i9IpLgYSQvPVPSt6TBai?=
 =?iso-8859-1?Q?UUUwYJZNiZtlLbw/gr1JJezzbkJ07JbVwx805heeXetiSZYPC7xDZERvRE?=
 =?iso-8859-1?Q?KMLFoZJojPCJ/ciy7Aej9AG+g/3PHqZO/t3BlRb7TibObVt1lyuwoLPEzs?=
 =?iso-8859-1?Q?Pz54To+etL1Bdnmyqpyzkx9qWZUeW9eY2rEscnLfvTRrBJz9FWXT5UtdIR?=
 =?iso-8859-1?Q?JrzO+CTE5ptzpTlgRMw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c8a57-ac61-4e44-4990-08de1bb3d7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 15:07:16.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdS/EkecfeEN02yBWECFK37dRPTkH6JbLvGlx73PGwqoInamLb0GcDVWSRs43nQo2R51i3wWke31OE+9sjRKIUBrD3y3p/CkD+sqLVyhJwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4155
Received-SPF: pass client-ip=52.101.65.135;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

According to MIPS programming guide, the id is 0x127.
A patch for this has been sent on Linux mailing list as well.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu_vendorid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 28f0ce9370..f1ffc66542 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,7 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
-#define MIPS_VENDOR_ID          0x722
+#define MIPS_VENDOR_ID          0x127
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

