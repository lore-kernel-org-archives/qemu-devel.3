Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C2606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FsHdcNgA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1N-0003fh-EY; Mon, 09 Nov 2026 15:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSzI-00063c-Gy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:17:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSzD-0004gR-RX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:16:54 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEmlL3699908
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=WGbMkPgMzJDNVUwgpo6Ew2w3ObEetq
 +oe9rEmUPGyPU=; b=FsHdcNgAKIWYUpM15uZRX8XU/71+CBU27vj8KaU6HHw1sY
 HsdKTt0FIk8Q3GF6rnFXpA+Xd3UgToj+0bIp6uS/RQuxjcPO4cXXoZ+mU+a9uRIX
 2st1H46zowKSJwhO+E4CxIOUwZotZVxGI4hHqZphz7MCZnLTLj64i+CRPvcnqaG8
 3seYPjlUAB0TqTbGCztxGSGAkxjavmxfnP2Wvgb0tVUURzO7Ypt2x8xnyFHDYzZs
 Fcph9EQc3CNsN4RpFnYtF/KEowd6O9LgmVLWbp43qcJuL15MzGDjy/MlvQGajHbt
 mLVdzCEgQCTBLrWcVu1LxZ34fZJJekwj8duR6Wtg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ynh8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:16:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Gkahj131384
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:16:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y1jeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:16:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HGiJA44892416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:16:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3186F20043;
 Mon,  9 Nov 2026 17:16:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1447E20040;
 Mon,  9 Nov 2026 17:16:44 +0000 (GMT)
Received: from localhost (unknown [9.111.181.177])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:16:44 +0000 (GMT)
Date: Mon, 9 Nov 2026 18:16:43 +0100
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>
Subject: Re: [RFC 0/8] Allow using KVM UAPI headers for mixed architectures
Message-ID: <20261109171636.GB56842@inux.ibm.com>
Mail-Followup-To: qemu-devel@nongnu.org, Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nzMJWcte/BMlGCIL"
Content-Disposition: inline
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HLoxA6lBQ3uvgOb7Z97F7hygw1bqY6s1
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af20001 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8
 a=8b70_0lO4OE0psGly2sA:9 a=CjuIK1q_8ugA:10 a=D8ZoacuIj1tAb0OcPl4A:9
X-Proofpoint-GUID: HLoxA6lBQ3uvgOb7Z97F7hygw1bqY6s1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2OCBTYWx0ZWRfXzCuKxx8lIBv3
 dQhyM+XuXqeTMkcPn5WqqygV1sAySZJ7w3U0mHioqzjek8wgTUGRKqz6lgE7osmdaX4YjBe1O9W
 KrLikGuGhvGjfwDQ0n7oaz7r7zi+qOeSMktgTQ06izeWpEtk0WlHXY1zDXDVXsuDhKE9lFG27XW
 +YZ8fSVmtjigo7OffYCFrRwT3c2jwW+NA2SuiVgZsJarNVP9gUgubeYgp0vbu4xKWgPdLMHiO4g
 9qhnRqE2nskbXvemRs6v4b1yd76J3l5/Dy/Lv/oweUgPr3SVa27j2Fi023y2vZSJB1I67nqNRwa
 Qi9Wou75V7kaMHMDLDLjnjCQGtKsVrOgpC6CjpMuNGbimuFMdj9ff3phuOZyAhhYyVASVikdL/N
 ej5yGHJfS2wbdQ1rc1Zl/ryhhOw1UCANKlZld3TqjaGEkQqY5BjPPix2j1sEDsDbjTHtBX07Cwv
 cGCWuaFb84blD2ldtjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2OCBTYWx0ZWRfX7K1ePaezBbrx
 Y9Wh9apwbNCt+4RyKS8eMCt1miNDrKycujPSbkjB7YohL4kd+Xkv0O1Kyfyh9a+PVsuPopnMkda
 h/+UY+X8LDpAuQ8mDAmreiGkK4Ge/gE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=bwalk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:04 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nzMJWcte/BMlGCIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bjoern Walk <bwalk@linux.ibm.com> [2026-11-09, 06:10PM +0100]:
> Tree: https://github.ibm.com/linuxonz/qemu/tree/canton/kvm-uapi-header-changes/rfc

Sorry, wrong link. Here's the correct one:
https://gitlab.com/bwalk/qemu/-/tree/canton/kvm-uapi-header-changes/rfc

--nzMJWcte/BMlGCIL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iMMEABYKAGsWIQSI0ogRa/W/X72RGmb1TY03qWm4PQUCavH/9BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwwLDMxFIAAAAAAFQATcGthLWFkZHJlc3NAZ251cGcub3Jn
YndhbGtAbGludXguaWJtLmNvbQAKCRD1TY03qWm4Pd9BAP9z0zeLRZpKeK4+F3DV
Z3RvN2I+iyXN5Kg1nTsBrVs5qQEAmnRV5bg0jiGJ297FIQm8IwMLbVEJ0MN+XB9U
o6mgHQQ=
=wChe
-----END PGP SIGNATURE-----

--nzMJWcte/BMlGCIL--


