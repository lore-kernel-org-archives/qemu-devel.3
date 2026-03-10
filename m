Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F7DFCC9D1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzr2h-0006k0-6m; Tue, 10 Mar 2026 02:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzr28-0006hf-7F
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:57:42 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzr26-0007qh-EX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773125856; x=1804661856;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=8smb5Pms6bD4Ko2oSvksc+rNo/7EPFKLmvz/okE0nKo=;
 b=pynZLc8LoQIqpEMQHkCac5xt2jepn26lVZSvhKjygL5aY8s4ZFH3sZP/
 lRdd2MQciasJ3G1oOY0m/4JSPP/dv3zViiFUARExO2yY9DiwnDh2W5ez9
 ShhohoXs4M5YPd2wXzyWnwAA7zNCUqIILmENPLZ6LgjMr5KdSxsnLl7p8
 xXF0jCVEyQz8oIois3Mb7OMrCT4UpsPxDMlBAew3femPMa2W2Nbh/r7PL
 0k4Xd8DgO49oqp6xcqgFzJ2ZwXB6CxRputX/HqsdPHgCcq5uCRlsOvU81
 G9tH7voIRUtMYu28d9ZuhwF6RnHrRhfOKJpVqTUA6PPQcet36HLNcq0Nh w==;
X-CSE-ConnectionGUID: K53NR3VSR72itNRurLuKAw==
X-CSE-MsgGUID: 1imdiJS6QAWPW9K5C3QWug==
IronPort-SDR: 69afc0d9_BSLp5rg7rMfFMM6qXLqnPRDX2fZwzLaoIhwRm29SUvZMPKG
 d0w3S4w1o8WxKFgGU5gLYFG5txannTov9xpZkGw==
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; d="scan'208";a="46930365"
X-MGA-submission: =?us-ascii?q?MDG9RJl+CTQutRcfJwJ5pAiqHunS7J5g88EbnY?=
 =?us-ascii?q?aqeN2PXy2T5vmbgmfl8EKImyCxSjD0wRu7o+UPercpgJkEBfbv3ixdjr?=
 =?us-ascii?q?uoEynEm2CYzD90JG2l5mISQ9S1NmPA+muWuvV+2hEX0+UAaUd88kbF8b?=
 =?us-ascii?q?Gm03/9NDj3V4B3bpeU6wMYSQ=3D=3D?=
Received: from mail-francesouthazon11011021.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.21])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Mar 2026 07:57:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNCQjjMDzTWlbEnb2XX8oCFDfv5aQAdoR2754B4YLkYGqTz+bQnrTCHEaSi+0WAZYabbxkYnQD60lXWkvmMY6miZGolKlY+DWhwl1IoyWhmPzzs4WgvQTQZNd6P3C+TOFq/HZ3hlzIW9qnwnAsxyQhI9P5aybwA+XCOaYLcGsZ+nXqh1qBR/RtzxeSsPqhJXCkigf/8u//ipD3aPMvqVuIN45QmG/DFEphEyEJgd6pwisP56BeFGN0tXo4S/Evy7KcH2K5DU510wnBi3XrmuJG+gjScHLxDTsEvWysec78ufcXJ2cN7LW1Z2tjnR5wsPJ33ia0/LHgAK9mSsmWgglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gLQnvIGu2Wst9wqRnO9C92AzloMxYEXlqd9lM78D64=;
 b=wNiTGe2JSdtXpsA/xQgINCVRh0qBO2k8ZgaRcGzyaseCCPzp48T2O+qIIR7wNM5LSULJdWERg2afNNp1OvuSqBc5u741s5ULJzcpg2v/dDvCpciu/aRAX79k/mhx9aHzUuD73Yg7LISeDtpsrklzyM2vkilK1hJ2u5rBLN93GhoTEullnPbKoykb3DrdggtGYxE6cdugKjWvekKpsaWo3pYps0uySJzIDGVyokozHyuyFHMrM2DaB6c8w5xA+jLrwCQcVb5o3ezMkB07QI33YjbaQnrSmZuh7UxRKxy5zKFeVj2CJ5xiVhx+gqkOO9BXF98cnsSFRPsevTrzPSRRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB7020.eurprd07.prod.outlook.com (2603:10a6:102:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:57:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:57:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>
Subject: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes write
 permission
Thread-Topic: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Index: AQHcsFskubOEgFc8HEeHP9N2sSLBHg==
Date: Tue, 10 Mar 2026 06:57:22 +0000
Message-ID: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB7020:EE_
x-ms-office365-filtering-correlation-id: a9533a6a-097e-49a5-abd0-08de7e724771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: SuN0nNqfTWTwhPC2ITtBikNG9NqsGwf4qOflwLQJcqL5amDBQXD9W+1g83F6aglkM1iUo5wrs5oIIg8pwXWtBOWw1DbFy6kyA+0SGQIUJ0VpNO1F0/2gnB7GJJZy2yEjNaPcvnSvlB5KhxXeTMnjd3SRhMIHHQkSKeBP4DF165X6aPYOCQR1Lj5mFGmtur7EWku4R9Bx82nvyVfwwkXwNl4MnvjTN27bYIjRQjPabQOPpR2hP74Tsi615UbS0Y06Y/9vI581VSEuvW79V0RutgJbcD8bHQGFd8me+j8E8BgeZ5C8otYP6JGGHcEFsDBNnFLLgfvz2dKq2Nifa3t/D+ChFEoCal3prNbPH428mcxiTHHM28tZLnyvgouJK3B1U4bswXPj6B0C9MdrplP2ec4/QjPk4Et1HkcJJagvIStiadaVDMuQxh5p/qd99qUDjglBvjcmIgLBUfk7DTvULLtwHfiJNuyhS1D2VNtsmOEU2hPKp6MPtj1GzbOcVDIlkOPL5SVNYCMdrtffwcjsT+WLu6Q1SXAbbYIi5VXlUwKPwvSsBpFSOCDFBnsT7fV4jtHlUXppGAA1c0VmIDOUTXXXkaKfp7xAwIR4FtJn630TPFbKflqtZklvG47aPD+vqLrhNM9CVLnsKUwEllZHNB8Oznni8v3aD8U6gRM2Iftr5bS0R8AhRFBEBEkmlOtFf+7yMKutCG/lwgnC8SoIo+v6frGyslMZzhaWouD/bQQ4omoM2ECRDHwNkPAfIr8uUwrWwzQuTodtv1TSw9U7CcIqdK16FEiZPbzZMgCL9Rc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y/999L3zPOJ1lGuIjrmFrtEe9Ak5pH5pieks//b1vDlHpX9wtCYQQLoLho?=
 =?iso-8859-1?Q?W3N3S0ijjNUGOaYI2ZQ/esSWZl8GyOIL/Ez7dtZwOeDC0HBwkGdQ/3R7lR?=
 =?iso-8859-1?Q?r43Du8J9Tz3UTVkf8ZCKpIqpayAtjPkJ6tuMKn1ZGkE7pBTogZAxvuFEOP?=
 =?iso-8859-1?Q?sYIZnDKsJc8dC2NmQXGcw7/7i0qwVksF6H1KzFYMe7av3Ke8q9GIfSRnNC?=
 =?iso-8859-1?Q?gw1XygDgsfoWXtGM+nNU0MsBLkOpgWt2bNwAVSbAF0323iIn9JOC/nhhgl?=
 =?iso-8859-1?Q?NUDbsBisCugwXVy/H5Tjf/Qz+9ZdKeNfqRMXU7F7k4YoXE1V+djMLGUqzk?=
 =?iso-8859-1?Q?aUgj5X16aRC2gGWGX9msBAzRTSpcPIWBdBxFKO9yGJARc+/CxfVBRcAipu?=
 =?iso-8859-1?Q?xTXyglfBQc7sCYossPdTfZj/3XxJSsTAD3lGDkEiI+W1LhtXQnUWWr/lLO?=
 =?iso-8859-1?Q?Zz8qlPUFewvIQeYalTCAz9skiW1vecCqIq49bcSrj5MmFYz5OuYt+AqhBp?=
 =?iso-8859-1?Q?uJLpD9K89A2Gk9fryePEVieRt1zMfWRxqJlucv9fr7BtVjQLNWar9lkaR0?=
 =?iso-8859-1?Q?I+WZzj6YGRexJ3XQ4bw0Z8ky0jI3xI1581apAvJhXZcllX/YiPWA2W1k7T?=
 =?iso-8859-1?Q?dyeQ7j1OCPxHpL6HYpxSmLQtNgyshh3elzy8Ac/oT0t5sMcDN6HjIHt2DK?=
 =?iso-8859-1?Q?A/e8nYyCAtFJMFtNRZMms8+sjf4PFT5GiKZm7g927J/A3TPnlfxmNBU1nr?=
 =?iso-8859-1?Q?4HrN/I5vnTzJCh4HBgQbS8pJRxX62QVZnnCsw7JpWq36hjq6unCWYXlncd?=
 =?iso-8859-1?Q?A3Y4xVz0fTe65sxdqnObUmcYti+B9tTBF6eqAiWADbmcJ84vH95K9Ir5TU?=
 =?iso-8859-1?Q?84NKF7LBiUHo3zRzE8A5J38N3uq221UY/MKIkpWr1AnM8AxSK9HSgehrJv?=
 =?iso-8859-1?Q?PK9DK4KSCYS8Xlpl0G/Yi/CGTxXdLYJ7MLZ71TDMJP+TKILhHBxVrC0gVC?=
 =?iso-8859-1?Q?0huk6uG0d04c8iJ6tL6FAsduR8wM2teR0f2SOikanpw1UC42Dxwk2cYUEa?=
 =?iso-8859-1?Q?9P7Kv6YPubTk8u5pUOPkYbwx7ImJoUP6M9lg8B7OL1gGoJDLFCYfBvZv3+?=
 =?iso-8859-1?Q?SlBRe4KJJsSLMrq4UkDRkl84g8DyRMd0APy34dJrckapVsf9n6ukIcjyTi?=
 =?iso-8859-1?Q?TYGTiL3xJCw/SwcwGOOsVDzh23A0sc3SqXQkV/URy4rv68vNfrWIzvTEIS?=
 =?iso-8859-1?Q?gpRFz3ud7Ln4SDnVFdZs+rLDTktp2xb95CoU4tWNgTtuGKejh3F7aAHdry?=
 =?iso-8859-1?Q?ZHLMZkDF6xtDeAlobO0rqODPwxHv/E9TL25CSw0d/V9pGlDWf0AkkRYHjs?=
 =?iso-8859-1?Q?anGh0hrUvPwC2kTw5sgNW6R8Ti2JYYl0b7WGpZT4RlcNJW0n/Tra5YAakx?=
 =?iso-8859-1?Q?rvvSCMEV18ZmTlDTtGgFkNk1eurj0XlgQaQTGnnnhppxTVWKiAAmN4TGsX?=
 =?iso-8859-1?Q?QTiHnuHMOj+GGj7Va+7KUR/ZdYBX7fgV5CZ6ktRayWuLJp6dBut8OvXIvQ?=
 =?iso-8859-1?Q?a1B5449U0l2bcnnQCsbix3EwjlJfffaqlf+U/4v+ZJXJwYjgEIvx/04yAN?=
 =?iso-8859-1?Q?CYCbEGRJlUKEfuW1nRTP3ZZH6n95hzjtX0lzXr25XC3hkVAzigEU3RJCs9?=
 =?iso-8859-1?Q?xB7NqUf3nB6sQAtXKnXfYLVmpW5C9Aan/MPByqWnO7mDRCSOx0mUDLjf56?=
 =?iso-8859-1?Q?I2c1YIgmpc/tcpV/1M7QNEAfwEc2lPoms4qUbH0bYJbMS3C9MXUxstYJPY?=
 =?iso-8859-1?Q?Cc3gXK1QiX+/HNBbwiRGaT5GqV2SrAaTi6dD2YtLwrLiPDvAB+TL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fsWbEV7bQa4Ym3hPKqeMEr8jIgeGs0gfovIZfTpZhUf/8hq1Ic4rwOJu1uZsm+J328zak389DSJ2dgKOkLjEYKvkEi5nhKTLY6oZJL9UYKDDX+9C/xwarb+rvUF8zDHDeeokdq7teCB4XqbV1sr/x297EB412l5flmT+hZH40wlhna99NXpZIeg6rrbwwQS15GxIkth0lNuNIOu5P857/ZjXjm4VQQPnEoeb+YLJrl2183fAfVA85vvw8Ffb9/ugn00oB2wQIRH0BtUP5x9GgzS1ZFwsM65WOkwitnBVFnNyWU9WXJisTX4vuJBH9SJ5iH+rKb8BIqjDj/BPAQjZOw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9533a6a-097e-49a5-abd0-08de7e724771
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:57:22.2726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVSPfr2xNDR+UGjECS/PDBKtfg/+wUrjMH8RMD61jerWJMKeubNpjhc0EDSeq25OM+sk/zD1q1T0PxJID/dMxfmkDsMC61Cd2gPHBHgQ1e+7dMvocOijSBmbIrVzRgMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB7020
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid unintentionally flagging the entry as a shadow stack entry.
In the current implementation, the dirty bit is always set in the pte.
Hence, an ATS device requesting an RW translation for a copy-on-write
page is likely to trigger a PRI request for a region that has just been
marked as dirty by the IOMMU. However, CPUs that support shadow stacks
give special meaning to PTEs reporting W=3D0 and D=3D1. Setting these value=
s
can cause PRI requests to complete successfully without granting the
expected write permission, which leads the device to enter an infinite
loop of ATS/PRI requests.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d24ba989bf..56146aafc1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2066,7 +2066,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
+        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
             flag_ad |=3D VTD_FS_D;
         }
=20
--=20
2.53.0

