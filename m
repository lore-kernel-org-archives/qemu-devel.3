Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D750DD0D151
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXln-0002AX-D0; Wed, 07 Jan 2026 12:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vdXll-00028S-Pk
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:56:30 -0500
Received: from p-west1-cluster3-host8-snip4-1.eps.apple.com ([57.103.66.54]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vdXlg-0007wV-OM
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:56:28 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPS id
 60FE61800DCD; Wed,  7 Jan 2026 17:56:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=VkWk2tFVnysJqky9KzH3vkmTcXs7gtlemJ+XvDsxMNw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WZgavM0DYYgoR5MncA0h5fjMh8a6BWNcxiKstxWVE1IwSToRo5CuHP+3064B+jPCsJRuXub9wIXZurXMIph5jWAnHi171ycWSvuuTzLXSXw3TvbEx2bDbfb0z+qqYxGSb1bOzXtovfrTwU5e6P6O999ezJhBAD7ajOz69euIHEkmQNUShNpKoRAilU+txhSCoTGG7Epb62SmlFuXNUWZwtn1YeL4P/5knlruS2My520KD7oenqCI98RReUXHWhMtNt+cqIbbzctwUmqJrecW37AfvaaBEWlBDOeFxAk3RtrLmLfFUmoYJdWmLbJHliph67B2SRmENvb4Hj0bP7EjEA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPSA id
 27F3D1800DE0; Wed,  7 Jan 2026 17:56:13 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: qemu whpx
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <OSZPR01MB8340BA4527E065073376C8FAB884A@OSZPR01MB8340.jpnprd01.prod.outlook.com>
Date: Wed, 7 Jan 2026 18:56:01 +0100
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F456E124-3B22-4CD1-97DE-89693E99989F@unpredictable.fr>
References: <OSZPR01MB8340BA4527E065073376C8FAB884A@OSZPR01MB8340.jpnprd01.prod.outlook.com>
To: Anquan Wu <leiqi96@hotmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info: v=2.4 cv=Vab6/Vp9 c=1 sm=1 tr=0 ts=695e9e3f
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=69EAbJreAAAA:8 a=sY0mEIUeoWJGdHbO3qwA:9
 a=QEXdDO2ut3YA:10 a=JADwSAh9lFIA:10
X-Proofpoint-GUID: 1J9GfzaNa8sTDPo3kTG6kQX-6_srn0TI
X-Proofpoint-ORIG-GUID: 1J9GfzaNa8sTDPo3kTG6kQX-6_srn0TI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0MiBTYWx0ZWRfX1bVFCXIfEtRl
 91HZV/m/NM4qHIkw9OEy/QCxJ13XW4WGphITRGVZZpSR9FBXOGxdMPMpU4oQhX7xPcqBkPtH8S2
 yx8dV4bYkfGK0uVv1ZSBbN78iNqpYzt2FU7dgTHY9pydcEBlfLHuTykS7FcYaurJ+yTfBrXdUbd
 r7OL8chLVYYNPNRHZEliukSe3FyODGVvaJKJED85GUQbsMs1RK8LLPUbEm34xsVFXDSXL/kbSza
 bBQGWX4olQCHlYkbRixpcM/E3Ryx9VCKBjuhTO+5BDQedkQ6dP02d41iNSp88/ydmXiVGUlIEsn
 kfrPl2JjFl1gQN7NeVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=724
 bulkscore=0 phishscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601070142
X-JNJ: AAAAAAABhnvRxgDBtCFVhRdv73vaJZu5gwtND/rLvrBKYTRy+jInHnU2b7JwqSvyV/Q7IWM+vmLB7GIt3aToZAk3NuxRYAb8X7Zyp8pU1eoFlISb8/pVaELKScKSk6IRG1do09/Gm5O4DmqeDg2h9dCDdBy4yAZDfuyrcMmk47ecyjroygTZGIHGwJ8soahSjVYW3AtmEG157eAgWCfxfPOUh1LCLZpQoBLs06AamelKyu6NRedz3WF7qcEefVKD/j8gLoF+9HNv0ebifPs0IY7Q5F0vnhNI4zG6e11Rh/eGrA5+D80kCbvWWifdPwIDPDVlFTjEYqFt7f2lIYcjhtJZWksx/27YQy0rgBgTFndoE6/V4vAHoWYbkbGER3z8YV3eddOL6qSkuPzoKDAXpYDoxNuVdWI9k4KEjRraGpXI6DWgdkh/+Q0ZiPD++hVn47d8OdbPsNGsMfHtIMNkDFTP1/NwCEVCf4UNbxWenfX2u2WQKN/ar9GjC1bwI7GkSVlGcDi0cOweCaSqMf8Vwxg2am3RQ1cMfd2yqHdh2HEXDmY4JrHrEQBEhgXcVjttTQcHaWPaZJ3REfBu
Received-SPF: pass client-ip=57.103.66.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 7. Jan 2026, at 08:18, Anquan Wu <leiqi96@hotmail.com> wrote:
>=20
> hello=EF=BC=8Call
>=20
> May I ask if QEMU on a Windows host can support nested virtualization =
through WHPX acceleration when the physical CPU is Intel?
>=20
> thanks

Hello,

This is not implemented in the WHPX backend today.=

