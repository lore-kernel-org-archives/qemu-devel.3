Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82567D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mtL-0008NL-AQ; Fri, 18 Oct 2024 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mtE-0008Me-Vv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:38 -0400
Received: from mail-am0eur02on20730.outbound.protection.outlook.com
 ([2a01:111:f403:2606::730]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mtD-0005ca-8C
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqbtvmfnNlgBbpA220Dz2Ly+U1qGVGwPxCeQ3rUWQ1JqgKAkqLg/hK9V48Y74dHGLzQQ7ZwdRrCVuRXxXWTK3P9A19B2EPxaOJHV7owhBXWXgs34KSbTtlbKD1K5jocTna08KWd4ZdzXfv+f4ZvO0exNLVbTFjBQ/5vtIkyqoyN/SqXLYZRMMPUsbEBl3s67Vim7aVrRtZbuanZbPSb9ZxSvQCaiMB/hVXCx8wl1QQh4OcDiq9DwGZejolRH2mI3dU5L7FCsvREURbGQD+kyqnagLFXtqL8U+4aPWhszYmcXMY7pWdfhg9eHO8G+myijbXORW0gwjspZVIer39rfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkevpJfmlsGSMyUP8vJGhx4J0UGT8NylVO7A0D4KapM=;
 b=YESUBjYbiS5UIRnFcm0U5NIz7WQy/WjOaVhAAewOXlu8ATF17w888SaBCJflE0620ABCEWYJg+ZfmGsDY7Ms/IPhJcq5r+PmrpkkBNb9/781H6bsF7qpJ2OICSN2DJAkv5ymu3zkZXc1vf9c1bIH8yiSHs/sXObXEIdXsv0kM6IEw9idaN7Axaylhb4PUNv4GmkqLYTSFv8VmNk/AGifdEnz9qSOzx0xBCSRStE7BGOq60EDleIUefsknSQZciq93Dxt2IPcEwOiKY0OQUVcJ/Z3BHTbUOulJOoteAnfdYBMd/2zaRCfC/JNDu0JeCmC3MOanxxC1FH6IFq1+7pGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkevpJfmlsGSMyUP8vJGhx4J0UGT8NylVO7A0D4KapM=;
 b=EWHqd6/43M6iPIG+JDRtrG8tq7wSijblceEWuthOmuHGGsP0SRO99ahdxhPd1tAY7+EvcLwYdwjrahprYDzK2cnfN1xoc0k2/rXuoDjZXr0YwISnRC1hHCe68cNX7ca4FjxwSPUdC2UvQvLEoJiQ3Ash9RQDzngaMQQ6CYSEsER+fIgmPd5X2RluYaC3PhpSM8JZ/ZdjwIXBSAz1eeZ4zXpCCL6VISeOhLKLJThKyMqZhfa7kXLtM4KuOv5ACEI0oF1q0h5I/YMaiEWhyijdLa9EIs08x936ctXZffe0DDscohDpDCGhuT8FKuRkRovi27G2TFWeoT1qsT0WurfUEA==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by GV2PR09MB5889.eurprd09.prod.outlook.com (2603:10a6:150:ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 13:19:31 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:19:31 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 3/8] GTM19-448: Fix script to work without realpath
Thread-Topic: [PATCH v2 3/8] GTM19-448: Fix script to work without realpath
Thread-Index: AQHbIVzWUPTYba2KSka2xB5Ywsxm/Q==
Date: Fri, 18 Oct 2024 13:19:31 +0000
Message-ID: <AM9PR09MB485154A57747BBF1FDFEB33B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|GV2PR09MB5889:EE_
x-ms-office365-filtering-correlation-id: aecdfb61-27be-4bb3-9e3e-08dcef7780b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?a03MpVzxBrcPf+JU770UzZn+aCnexo46XDqW3bhaMXgvtXDZ1fjU1FyvEg?=
 =?iso-8859-1?Q?LY2l65SHMR7z8iCsLuTqc1SWuxsWkO9oK2WRD25Id0V+lXSCmJBqDf0+i7?=
 =?iso-8859-1?Q?zA96fTOSisT1v7n+wv6gM73rDjXH4bKG6FVBgDec/+iDhsSbeELQMFxmXD?=
 =?iso-8859-1?Q?c9hL1TKS03U+9ouik0MDJAjx929/ISAoXeAgL2Xi9iF5W1uTzCFPxbf+1n?=
 =?iso-8859-1?Q?yt0cHO09iH2V4GKtILPocXQ7d5p5SVQgdZxXgKXJdMdRTLBvkzVdu3o34K?=
 =?iso-8859-1?Q?XwURDHYilYVsG2AHpI0famnCFhAFXdr44pl9r7DFCf8W7YSDdVet4AAgeg?=
 =?iso-8859-1?Q?tDyob4aDxW3u3zPxxSAM9VlIaeB/03H1SR/lZP+CeWkMjGZnipIr4MlHay?=
 =?iso-8859-1?Q?DpFcjIJ1qYlRN/FtQeWfzCy0nqtul4sQyZldHGswEHt15GvwAmF9ghfKSY?=
 =?iso-8859-1?Q?74m73PkJvKIUbfp60pMJ9zVhzK2r9vOy8WUhISb37FmaON/CQcvwGMgMMG?=
 =?iso-8859-1?Q?6RPxkQbjYHOuLr9VtaQpIJkOvReByCuYsRhpoI1LvzCagtlmmf5jFZwr0O?=
 =?iso-8859-1?Q?20LnsbTYTbwaWMsRjIvtkpb9XtdJ3M2DYvE/gzLjCJe+60FWB/E76QSErp?=
 =?iso-8859-1?Q?BPmLqhOGCe/qxeqQ+z9pNYOp2usJR8TTF7Lx85pdI5t3b/XrLIYYkZ6RLw?=
 =?iso-8859-1?Q?qIO46PphOfYcv87r5wFzYWXvO9reRyIavUxt9Sv1eb5BkuVg+edU02v259?=
 =?iso-8859-1?Q?KB2cdI57MunH879mqYNrRfSd0wS4NoGSzqJcBT92SU/qRJhImB2YhPlvr0?=
 =?iso-8859-1?Q?I/NgT3kY7W8wsnSI0VrtoPWK3rWQftFct0fUS9S5YTG8gqxDDGdxNsfjNo?=
 =?iso-8859-1?Q?To/+MkDCgPUK+R2OnZabZnj0OftLvwhGUJo0r355rgp/OCGMVYMtY26yHl?=
 =?iso-8859-1?Q?kphxVgWyGRtR96uXOJdDldiJ/UjfB1aNrmnSubpzNqZ9bDGM1tLTbeuLjX?=
 =?iso-8859-1?Q?T5qbkC/KMpQjozkCtuWsabNBpMKathRQcOGTEqCNvwIxISirKUkgGbdr4d?=
 =?iso-8859-1?Q?q0H1MQOaICNVNjE26Ysz9hysYjg0rv2n5sPLpXJWz0GNsNtEMZOQDcysDl?=
 =?iso-8859-1?Q?O6d8L0W5ONnHn5mD9DWXw+JIQfWqYOXrmPoYKEXKNWM+74ObXHWke7U13L?=
 =?iso-8859-1?Q?MWJUrIONh4/O9rPgCUrtTOUozXjQvVjdb8Kd9PQ+Dzf6GYv/GMvQU5VC/a?=
 =?iso-8859-1?Q?Oe5QtqDI9BUfKc0mCtaEhh1b6BzEnWuZqMLyufpFJWR0rhbi59DeYc0/G0?=
 =?iso-8859-1?Q?gTLn/RPuV9xIduvuup+WZ6IbZBS2nrNzDl+slqadjnsAYRLipaUivpNE3O?=
 =?iso-8859-1?Q?cy7ZI2TUcerSgMOJJo0XYDq76AGRlP9+MPMbaDNcnxsQlRne2ZJOTktuvu?=
 =?iso-8859-1?Q?OQYTgiwYTXkxumbY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2PWWaKAtw4cAYtAwrDY0xCLXkLXeeJ06CGlrzNI6lt5dhvVzTAhjupvDT1?=
 =?iso-8859-1?Q?gpLr9V/xSr3m8rZuyMj6Zzl4oYB/62Ao0apNt+q//HkD9zPAlvyQvu1hV+?=
 =?iso-8859-1?Q?12an+fjI8k8AG7sxg2cOsj2Je8ODqa4e4ROiyRCG1snHjnXdfsSEVSf8mv?=
 =?iso-8859-1?Q?gZKHp2VmSZmguJlJEGAiWlehq8pwiBQObwHh/5aCi8CPqXTgfX/v27u7Vy?=
 =?iso-8859-1?Q?bgCgTShuu6n1QRGFFfCz7Dwqp/xScrTBqCpzPc8wflbZlS+VuflUJ7xtps?=
 =?iso-8859-1?Q?unHk0DbEPzZtoBuexh1S2u/r47ACpX6dqhzinly0MQKYZ3DVA5n1c7AQSq?=
 =?iso-8859-1?Q?te/JPcE/bGcbWn6Cq8InCI+XdiSmfXRvo61oQ2Tn72UyNh1oqIc6gF0XCo?=
 =?iso-8859-1?Q?AfZUMH+OO/Qf/4RdRwEVS9qyVDlFa/nBteXtIyf9BtYk7U16kWQjNw0Dcq?=
 =?iso-8859-1?Q?D9ltiSvQbdEeBH2QO9I+mNnIvWa1r8J86kEy18ZuZVX8V82hP47wYoa4mM?=
 =?iso-8859-1?Q?Bf0shlPM8UVG3e1pR6XnI7pllak720VY+h+qa6oQ3CO+gc+D/NX/aextqv?=
 =?iso-8859-1?Q?f0a/QuJmuWKULhRiBhH5IodUEr0llCS6JIpvSNw2Nv9kP+xz3rmO8f3h8i?=
 =?iso-8859-1?Q?XMxaAlarcooEr8ukOOwaMB7ikTwXk/WciEfYLtGo2tsfXtMYukkdNxYHqY?=
 =?iso-8859-1?Q?GxMz4X4idNt9FcHb+8Xa8NfV83cyiUZb3ImK3anjMcuPJIinf2+sBPId/6?=
 =?iso-8859-1?Q?27rrlIvn5DROGzw1FKi5GqUGsWuVHBugQPS4JI7L6HOJKQI83TyCNPcoJH?=
 =?iso-8859-1?Q?9st2og1+TXiPBLuisP3PF/cf1W+rJkpzxi+11SxF30Y85kcQa8TrY8/kzU?=
 =?iso-8859-1?Q?12xIm0pI1khrixy1nculDcQ4K0A9cO6tQvxab3UlkTD8f8KnJxF3gd3kYP?=
 =?iso-8859-1?Q?kK/SkeeCRkKNv653EhYhnW/r7W4ndTXayraSYha0yu2C4vTLn6kenoEyp4?=
 =?iso-8859-1?Q?FWDfOFzhqqEtKVwKF9kRnkbCm36yRthMmph0OmNMvt4qOujYm50YExtePY?=
 =?iso-8859-1?Q?ZAMxqmMUA6GtRy/rFBsqJQJWfvXyf8X8mdnuYZNfgULEIk747I0Kms6dAj?=
 =?iso-8859-1?Q?ERKx9GM8m/EPE5S7kK5/RRMbvlfdWJxK66pfC7UwR8AE71CnvWz2xLhIQV?=
 =?iso-8859-1?Q?5ZLhqUCLlvcNZtBIOI7GkIgoVGr+OB58OQNTBAXVNqZ8qfAFaZIJRTgp3m?=
 =?iso-8859-1?Q?SL3r0j5APQTVpcj1DnsuJ8jIp1Jf+n/mK6aUZmE81SD/zu66GS98EOKIoK?=
 =?iso-8859-1?Q?OlKgWkOctauhrOZ/zaw4LWcLUGwItsjOv04oy0e9VIF31RT8DaGRi9lWeQ?=
 =?iso-8859-1?Q?TrRs1cSIZJk9IzpWLIb7Pj0lqk0XL7jwVzG8V4JXKUNb2FjhN0yUtRG/o6?=
 =?iso-8859-1?Q?uXE7HM9ah9FnQ2s3ojOVXFXvhqKkw9YUI5aVMFbxm4Px/53Eoi2bvcdCzF?=
 =?iso-8859-1?Q?jg00KxOBsgrfG5Dr93JXuRpv9aWgHR7goCLvFhG3M7074o0/bU91xAWnJZ?=
 =?iso-8859-1?Q?d/b5d/LSQVz/axY2Jm3Q3fqRqsbs3RNQ+JL/K/hrdirQX40luC2nT8FGtU?=
 =?iso-8859-1?Q?sx9PDXwRiMt/1kEdZKJiJ+GPq86EZjsI19BMrWBtxpr4mIGjE4R53ghw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecdfb61-27be-4bb3-9e3e-08dcef7780b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:19:31.9201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAa5JQop0xP8J4xkE9BFQfyd6Wkbm0/NldkQ7zWJsDquec9CG7ujlAWw+08jNLylwmif2sZxyJLKb0yb9T3NVTXolXAQKpnxvEXIsfaAehk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5889
Received-SPF: pass client-ip=2a01:111:f403:2606::730;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The archive-source.sh script depends on realpath command, which was=0A=
introduced in coreutils-8.15. CentOS-6 build systems use coreutils-4.7,=0A=
which does not have realpath, so fix the script to use 'readlink -e' to=0A=
perform the same action.=0A=
=0A=
Cherry-picked 5d1d5766f0219ce2bec4e41c2467317df920ec0a=0A=
and 8003ab4032772a0e5b46e5983fe06268d3469289=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Chao-ying Fu <cfu@mips.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 scripts/archive-source.sh | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh=0A=
index 65af8063e4..7f16803772 100755=0A=
--- a/scripts/archive-source.sh=0A=
+++ b/scripts/archive-source.sh=0A=
@@ -18,7 +18,13 @@ if test $# -lt 1; then=0A=
     error "Usage: $0 <output tarball>"=0A=
 fi=0A=
 =0A=
-tar_file=3D$(realpath "$1")=0A=
+which realpath=0A=
+if [ $? -eq 0 ]; then=0A=
+    tar_file=3D$(realpath -s "$1")=0A=
+else=0A=
+    d=3D$(dirname "$1")=0A=
+    tar_file=3D$(readlink -e "$d")"/"$(basename "$1")=0A=
+fi=0A=
 sub_tdir=3D$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")=0A=
 sub_file=3D"${sub_tdir}/submodule.tar"=0A=
 =0A=
-- =0A=
2.34.1=

