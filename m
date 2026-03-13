Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E558105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13tV-0000sg-Nx; Fri, 13 Mar 2026 10:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13tS-0000rx-Fn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:53:38 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13tQ-00084W-TW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773413617; x=1804949617;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=28frfsCWBmzsuPDd7z4+e1wI7fP+gVKXpoLqZ0zjDGI=;
 b=LZq6gV4AsZZCjcyNCRmcuQXBxhuPhJpBcrojxjl4pqvwknkcdHoYlyvg
 zknfo0L4m2jNgjsQvJ+ZLWYcEL4Ajn7zqivkWula+4hbuIgh0IAzL82Aa
 Gkrf85UzndN9VHjcdLSEa7NbSjH6vh/lvjH1XemF0Vber3XbetM0aNgFM
 Jc1XdK2najjSG/JIxy1f/3ZOCMIX7a4DWTGPWVTscvFMDFWkGQmC/s0td
 wiKV35ICqPe0y/+6oasjNVoghQc8wWV44grJth/v9IkK7tAfLXPVnHHk7
 tNdQ+0WyZ/NVzmloW9eRaVDeEV5ypyRz41OINR/E3p3g5eom/hX3u8oYu w==;
X-CSE-ConnectionGUID: dYsekATARgC1DbFL5sBhaA==
X-CSE-MsgGUID: 8J3a9Nv2QCKtVae+pVnY8Q==
IronPort-SDR: 69b424ec_mjdvqflsvnyyPN5wmvTBKvjzrBx6CafTGt88Ks5OKTmgkKo
 bk0+0sEOHCrzp1MP79Wun0+6ZQYGGJJUravJs4Q==
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; d="scan'208";a="49105961"
X-MGA-submission: =?us-ascii?q?MDECC3j6gRFjyXUnhsy0e9Lw0ZpsxVm+Vq5abO?=
 =?us-ascii?q?io/93MO3OyMDTfT9h0pmMsJ0jPMaRVaCO172usUh3yZf+6QUnPFRgY4B?=
 =?us-ascii?q?glAb5iA9E8qzRoYS7Asr46xJeLG+q27/WiGnUnIyuvPhRvfxQpaJ33lf?=
 =?us-ascii?q?HHk1jhI9Giv5E58Kfc6Oe/3w=3D=3D?=
Received: from mail-norwayeastazon11013052.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.52])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Mar 2026 15:53:31 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIO+/XpLoFyiHCp+JJGEmBff7kF+14b8EANrSAQrgEaS9XNQcZpnL7x/7wYyQOC44j8FgSwGqHPPBLHlRQSMqvngFZsX31P6q0FhhWsfcxRouq5eCgxxSm8bm92JN8EOZUUnk/OC3yBq+ICW6jz95I3sPDtUKK2lUV2hDThjEgUgoNbvoyfm8C0uvqI4KLro+kmN55GwUypd6FHStXSBthqfHfJFDxTZ0NXHn+SEWROnpMz+wOJgdefTdulNt8x+lg9Q5H8rIxIyG0Vslqlx35srO4LvcpbVJKj+5MgdzXBvuuzNzUwGzSY6PwaeWS4WkSeajQcA5SBhGaV6NWM3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1kpG+BgqNDTlard3KOYP0lpGe6HiNk9UrDHSYVk+qk=;
 b=P//dSm3KdpKvUbu75xnMUi3ubLJWrySbUT5lLZzoITGEQn8z3sQ8qKJDd2Fq1uJn8Y3ezhho5SPijoOpGNmUSO2bDHWY2fUswFmnCvdj9/dBnd887kfF5WwEmEDlsecLJ/npibypi9V0rIixuYUkWRxrb6eVYmhvaTMytsBL5thIj734tG4eijcmxPfbDuJY5DC/m8xYX8b0+lw3wACJDhaK9/bcXLZIGc0sHK0FIyTQNI7NDiShCchEBQ2cbk5qUEngsNScKLbC5gzPQYsJKzVlvfd/xkP+QygMNDFWZC87OG1WlzhFs1JnCV8skAI5sb0Qd1s6WTgVA/H7Q+QqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA6PR07MB11644.eurprd07.prod.outlook.com (2603:10a6:102:51b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 14:53:26 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:53:26 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "thuth@redhat.com"
 <thuth@redhat.com>, "pierrick.bouvier@linaro.org"
 <pierrick.bouvier@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@bull.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes write
 permission
Thread-Topic: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Index: AQHcsvkl8cAJuGNefE2DOIzPvp7J8w==
Date: Fri, 13 Mar 2026 14:53:26 +0000
Message-ID: <20260313145244.1063405-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA6PR07MB11644:EE_
x-ms-office365-filtering-correlation-id: d2491a3d-709a-455a-2b57-08de81104871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: 3u5xPSmQAWiAa34ojObb+0eRDzUulV2IBirVZN6K8Eb48Zl1Kb+3h3iFj0As3yiyACKXPosUVlnC+te5Z+Z8FacD0vVlAwfG7FuUrc8Dwkj2osSFaj/KS4cUcw5dsHrE6X2EDsws4dHCPuFaWYKSlG+/pL76EnNLpUv+32sDKOauPBDxQ/3rWms4aelMhxK16mnucNIdnYueKlzGU+ZP6EvrgI+YVLOxFrf9V2HoYuFLc/vJKKAHlaeYuHVYJm7CWMUEug5jz+fQZbLddnwyjdrROo9vzcZELsC+Ofdj2ECG40kNEJxKAolSHD2VfB1IUE4nOy0NhmI/gSnzJMtS1r0nI4o0+pDmng8cnskdIC3RfjoCimWdAWc0WD+5PHZJ3aFT6fM3ggKmaz0VJwmi+DNvIIX4+xzvmDOz01j6/UxXcsKSN69QCeNkMOrZZmvXGe5Z9sTjBbtOXQd6T5P7vxpQbA032gx4kWnwW1M4OdGsosPQQjCrfDHk7P2yaEAWugaMI2JwITA8itJNo7ZAzLtrf1iFeJ+cMNzBdLl4qCYJRejiGQBgHJb335HhszEYPhFj485/Y4i6vj/NnLAgGPzIraifPK03L5teAvw00AeymxoJcq/UAm/OnFHhjyeMqYCm9lUxozBcQkakMm8tVp8/BP+qU+cHQUDvO563i3qqjQxJoKfb9ruazOTqsjcyod8ghfm77kRoiMOXy/fS8dFmvIZtNe4whe1MiDRcV1ZruRnzVEqpJXpf3YPV+kyRxe4/awfU0gnhPAgrJZsRBpvqap8+HB4EvBS77CkMKFc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?53uQ6WRdULr7pQfkE4k6ffRtXQLVvkosahmjccqdk5JRQ8Mq/K7DFwff+g?=
 =?iso-8859-1?Q?XdKcKfeFElUfD/wTz9iy0BTio/wLadFN8E/7O4KPG9RBJUWOZ2CpNev0/M?=
 =?iso-8859-1?Q?IeuyFsAIVUAH5EFWMvdtYMwF6tcrLy2iTmPXqTwvs1610qcIRG7jJDMQDP?=
 =?iso-8859-1?Q?ywhKlneQxsQDSzLVK3LaXoEkIKGSbzVz70TSGbIr+DE9oI+FMKoprWq9/r?=
 =?iso-8859-1?Q?uRFh7tI+92o/+jFIOIRhYYtUDU6bdwI0KJHGkqMpuzTU5p4Vo2z4gx0JA/?=
 =?iso-8859-1?Q?R25k+igg1PTKjufZh96Dag6p9rRwuIz0xu1YMaidXwhC+YkXC3oQr4RR1C?=
 =?iso-8859-1?Q?vSzgppyuv1jlvR1ALoCDwwlIgmVgMYBsM/vuMXl44ZXVpRRk2PAEOukU38?=
 =?iso-8859-1?Q?1xgt/9H0xj61zhzf9SJmcyrc/K5McjcW0sfhn5/9MAzRi1ewSYr3/HTLNV?=
 =?iso-8859-1?Q?PH2eXj/wLOmR29NvyCJ0toQXH/uSv5ro35SDrA//ZHdX16ZnIQcjin35Yb?=
 =?iso-8859-1?Q?MqYCmKzbJkGUXmDKMeGpLNMOl5pfP9DlCew2m1UmXHqSxAzzSul8CUw119?=
 =?iso-8859-1?Q?bu8+Q7onNKwbp+Eu+3WOWwOpW/0lufvLIkF8hQUYQudRYy/VCPMxsmameb?=
 =?iso-8859-1?Q?h3Tghukud/7mxnp0Y0XMLCv+0S+mFZ4Ih5obepFhqeqwJ4zmkU5ZP58Vm7?=
 =?iso-8859-1?Q?pMxq4jZKdYwWktnrNjX4BvrmD0GWeYqx0MgYJt3iTzVsB9kcBsXe7otra1?=
 =?iso-8859-1?Q?0siqXtbQGD1hQW7qiRtxTcS9ErEebylT/Wr9/wkaYhgHl4oXnu/lSffxzh?=
 =?iso-8859-1?Q?zVd4zYxxhU9jAuJmVvxnqfxpQknfxVcB/sdwfDhQao/lvE1tS9QtGuRkvv?=
 =?iso-8859-1?Q?xUsNMEcxbvYp1Pv07JMzvNnzi78oS/jmmZNMP2+fk/YvQpPE3KhTMxPT0F?=
 =?iso-8859-1?Q?qBXpxK5fAHE/lzfjryseA6JV+95IMkyGslkjKmhI5cx7ebs5TZt2i/D60b?=
 =?iso-8859-1?Q?zIJWIPxFhFeC5gmHzXToiaLOjPg0WptcJeqD2m3hn1fHWULaqZt1+WkNsf?=
 =?iso-8859-1?Q?tVIJi41H2uZzZPneitEDiJQwIky45Z1PHEnSkOYE4j97TZ4aBtNGBIcYHe?=
 =?iso-8859-1?Q?NXqES1fYL420vZznYFBxy+qiaZvMRe5aDcSEllO4osyBXdQKLoNu3dwVIE?=
 =?iso-8859-1?Q?j6tRwGpchKU64Lkn59sFimRzrMZeSm3s7HDdEg7NbxMmRIBKUhj06R/sQS?=
 =?iso-8859-1?Q?H5SokVTLlV++yhu3ZZVhFy+eOxefcmSU+uSR/JLRt05cUxgxdu0AYKXSQs?=
 =?iso-8859-1?Q?6gcaGyoUPffC0O1nB/AaK3xZgJQFcy26b/9eR25phtZGgjLRqvi2ula+7t?=
 =?iso-8859-1?Q?NfOAyu9PDUZ1OjO7Uq05k98Gnfxg78IuKebA7TcoE9fj6iZSQijukFdIIu?=
 =?iso-8859-1?Q?zy6F99e5yTHcPx+r6RdRcnrzqCexcN+6kvQc3EWQnvbUsjH1VLRUHss50v?=
 =?iso-8859-1?Q?Pks92hZz6DgU3UqRjlbq7AKYTS896UdaUK3vh1lBV1iaAiaUpMG69WJzSj?=
 =?iso-8859-1?Q?GJBASS+tpoWykBFe8TdxC6QEbj4pLp12q7007vpGyZDLF0uxhOBkCtU6WF?=
 =?iso-8859-1?Q?DdWlhyGv1P5SKhvoa8WkOnBxnkBDSkIP2nVCBYtoAxZush97DOQajA7BEw?=
 =?iso-8859-1?Q?Q92eXoVVdJgU9sUVCRR9U9a+vJtuNXeCsrPupxk/aylDp+truWVlYLjhIY?=
 =?iso-8859-1?Q?vDaqaaGdeAYecTU1U7szu9JvJpfeKCVbcOvbz5BNUvtbCcmO0/kjzp4qN1?=
 =?iso-8859-1?Q?/qF6OBfigLrU0Xkgq/T0sN0t/IGPc3KFbMJQM+RBu+3OVxxUuE3A?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rubg1i9L/cdXdGXM1U48BNDp9Dx9hOxrtCSUDprie8bM/O38oqu5loKyiFcAovnoW3RrguKEZUWKF/Ll8i7xJlLroTnQsmDzIBGmf1ED/VFvL+5Gq3GpGd6IjOB7rBOI6eWsFEXBdWHi18/DnbBrUxSRmbNR177GRgbtLbz9h363coAQbhNoSTD9i2U+gVh1Oh23vUEcTHPvVivGOc72a5aUKx4YiErMP+6dxpD3RCp1AAuP0qopviBQMmkyr780syDbGI+7MASxpGSufQAVQl48rswQi6e9x6x6EIL1g1KnvI54DpX2tcjDnxAkE+n++csiHsPb/S8VGKSodM9moA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2491a3d-709a-455a-2b57-08de81104871
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:53:26.7600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxbsH7bCvbIHnqpODeOWUWiHd9AYZft7fbWBLXFn23lTeT0TL7aBG+Lu8qM98aulwaXqQOy9dloW2JftdzXgOSWrmdcyjaOecdxvwdlHUXlZavyMjOBxMgQBpxadMCby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11644
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
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

Setting the dirty bit without the write bit in vIOMMU creates a spoofed
shadow stack PTE that misleads the guest OS. This results in infinite
PRI requests from the device, as no actual write permission is ever
granted - the guest OS treats the PTE as a legitimate shadow stack entry
and considers the permissions already correct.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
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

