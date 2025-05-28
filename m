Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80A9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBhX-0002Ka-5C; Wed, 28 May 2025 03:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@icloud.com>)
 id 1uKBhV-0002KF-WD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:59:50 -0400
Received: from p-east3-cluster2-host8-snip4-10.eps.apple.com ([57.103.87.211]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@icloud.com>)
 id 1uKBhU-0002tf-8g
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=Awqfq+dVWCScwexE6cs0aWELoN4bTg32k2Y70iLJjpA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=rEkvSdRn0NffXWR8RTSkXhZ/zCnuQa+8eohPYlTv95GKuOdeafw2D/wFpGq75WV5C
 JucNuxVJOga2oBNpJgf1IPtZ0sgD2j95fArrM8j/c5tJCnkgS/Ag9lUOGJzsyPS38Y
 uJ9fQTpewW9Q2GYRW53P56l3yB3PyVzJ2vPSY5eclwkv4KjRH14v/VfTOu1H1JZKFw
 7FGtAPjr2qRhulJYDaVFvcrqRQ5vytFUP/MUGk3S9wNrKM+Aoy3RWrhyZ0As249Jxz
 t5gwgxiygmZyRIySnotWkAk3wPSuYBVbwzYkh+/mSJdEpqCph6804p/KCQR113v4Xk
 UEI5LLixl75FQ==
Received: from outbound.qs.icloud.com (localhost [127.0.0.1])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 3DBC8180029A;
 Wed, 28 May 2025 07:59:37 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id C0C0518002A4;
 Wed, 28 May 2025 07:59:35 +0000 (UTC)
From: elisey.konstantinov@icloud.com
Message-Id: <242C7401-E5C7-465D-AA2F-6664C4496254@icloud.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_FBCC503C-AC72-4DEF-AC13-248B2E2B5907"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
Date: Wed, 28 May 2025 10:59:04 +0300
In-Reply-To: <aDaCJTkoDYsdJFmJ@intel.com>
Cc: elisey.konstantinov@icloud.com, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com
To: qemu-devel@nongnu.org
References: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
 <aDaCJTkoDYsdJFmJ@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: wu7oea3CgXiTRB9asys1FNZAfod1mhOs
X-Proofpoint-ORIG-GUID: wu7oea3CgXiTRB9asys1FNZAfod1mhOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505280068
Received-SPF: pass client-ip=57.103.87.211;
 envelope-from=elisey.konstantinov@icloud.com; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_FBCC503C-AC72-4DEF-AC13-248B2E2B5907
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Zhao,

Thanks again for the info!

You're right =E2=80=94 I just tested the latest master (including =
commits 5979f50fa9fd and 7a4861230676), and the issue is indeed fixed =
there. macOS guests now boot successfully with TCG and multiple vCPUs, =
without needing my patch.

I=E2=80=99ll go ahead and drop the revert then =E2=80=94 great to see it =
resolved upstream!

Best regards,
Elisey=

--Apple-Mail=_FBCC503C-AC72-4DEF-AC13-248B2E2B5907
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><p =
data-start=3D"659" data-end=3D"667" style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">Hi Zhao,</p><p data-start=3D"669" data-end=3D"695" =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Thanks again =
for the info!</p><p data-start=3D"697" data-end=3D"927" =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">You're right =
=E2=80=94 I just tested the latest&nbsp;<code data-start=3D"737" =
data-end=3D"745">master</code>&nbsp;(including commits&nbsp;<code =
data-start=3D"765" =
data-end=3D"779">5979f50fa9fd</code>&nbsp;and&nbsp;<code =
data-start=3D"784" data-end=3D"798">7a4861230676</code>), and the issue =
is indeed fixed there. macOS guests now boot successfully with TCG and =
multiple vCPUs, without needing my patch.</p><p data-start=3D"929" =
data-end=3D"1004" style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">I=E2=80=99ll go ahead and drop the revert then =E2=80=94 great to =
see it resolved upstream!</p><p data-start=3D"1006" data-end=3D"1028" =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">Best =
regards,<br data-start=3D"1019" data-end=3D"1022">Elisey</p></body></html>=

--Apple-Mail=_FBCC503C-AC72-4DEF-AC13-248B2E2B5907--

