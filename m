Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6972D10FC456
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcrI-00024j-MD; Wed, 08 Apr 2026 20:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAcrC-00022z-1r
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 20:02:50 -0400
Received: from p-east2-cluster6-host9-snip4-10.eps.apple.com ([57.103.76.201]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAcr7-0006RE-Q1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 20:02:48 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPS id
 06D4018003C6; Thu, 09 Apr 2026 00:02:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775692963; x=1778284963;
 bh=cS+J/WWye3jUhGe3sg2B2pndM8g5c5+4hjjmc4bM4uo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FL3E8j4IeZjNlVIzcFY8Ssg1EJMGcL4Bw50VPoJa2UeyxtB6ElBOvWXKrlDzvtAoNSwJJWn0OH2PNf/RCgqs+6Nb0ggvy8DSRSSdyFSFMLPh59mafMO/mxG2DJKNXGvZpLZDYlvGsazC5A5u8RNHmg/3grvktwg0YB8RgTyca35Nhq9IEZrM2VaBY1CsYlCkRSV2ykU4Hbzej4iKieQWqVNEiWLYCx9QIphTiQZy3gS3goMfDGSAGz1xnc8Iq8iUzU0hQre4UjIjHZk+MO6DM2Q2Vv5uhvmkcjYLW0FwY7pGFqf1eoKtH4eGnUFFXcBoxg/VsbH5nigUpykSs5miwg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPSA id
 A804B18003E1; Thu, 09 Apr 2026 00:02:37 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DHO5ZTWY64G0.1AIDXSKEL01UU@gmail.com>
Date: Thu, 9 Apr 2026 02:02:25 +0200
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu,
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C35B5E97-73F2-4A60-951B-B064A882BD1E@unpredictable.fr>
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
 <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
 <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
 <97D215C3-5794-4250-BA33-F07C6A753477@unpredictable.fr>
 <DHO2FDRRIEGO.FEORPWSGCJE9@gmail.com>
 <7929BC15-D10B-4CF7-875C-0A168811CA72@unpredictable.fr>
 <DHO5ZTWY64G0.1AIDXSKEL01UU@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=BsOQAIX5 c=1 sm=1 tr=0 ts=69d6eca1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=N_UXvhnrE_qSsDvRhxkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIyMiBTYWx0ZWRfX4c0Xgqgm2o0x
 w24in2z1H8C8XlbuZyi91pl9bMkeDRI4eu1OwLLPARHQCLL34AGHwEaRLxkvbdtPDFHOgkXL7Cx
 A1MXqes9D+DSiHBBy7OCfGxekLuFB+RXWXAChTCmW3IEh4DT3vCiOgGGhetzkVSge+PQ7k5iuai
 rKHRq8h5s+jIjHwWwRswhsxN+h0wWG/HyBliscnNga/Zczp+287he/crlNy3gDcaLKJppT3L//6
 LyN5idIKohbr7lCwLfwlHtSxj4vpa8WiUrC7pGEUZrZoCAtT371LfGbAGhczQNp4rv4CBHwvPb7
 CsPJTu2H118qM67+66lexhpBRfmuNsQ7xEtiy3mg9Dr69kYl9HY4Kq9Ls2GYPg=
X-Proofpoint-ORIG-GUID: HgOiitjzn67TDhbI4ZZH_lqkfKzABKA-
X-Proofpoint-GUID: HgOiitjzn67TDhbI4ZZH_lqkfKzABKA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 clxscore=1030 bulkscore=0 spamscore=0 mlxlogscore=694
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604080222
Received-SPF: pass client-ip=57.103.76.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 9. Apr 2026, at 01:33, Scott J. Goldman <scottjgo@gmail.com> wrote:
>=20
> My possibly incorrect read of the strings and some disassembly of
> Virtulization.framework is that they look for
> IOServiceMatching("PCIPassthrough") which is simply not exported by
> anything I can find on my Mac. For internal builds maybe they ship
> another kext for this?
>=20

Hello,

Looked further and tried to run that code=E2=80=A6

The related service names queried at runtime by =
com.apple.Virtualization.VirtualMachine
passed to IOServiceMatching in this case are IOPCIDevice=E2=80=A6 and =
PCIPassthroughController

As the internet has no mention of PCIPassthroughController and it=E2=80=99=
s not
there on my machine running macOS 26.4, and I don=E2=80=99t see any =
reference of
the com.apple.private.PCIPassthrough.access entitlement anywhere outside
of the VirtualMachine service entitlements list, it=E2=80=99s possible =
to definitely
conclude that the kernel side of this isn=E2=80=99t shipped by Apple at =
this point.

And that=E2=80=99s pretty unfortunate but oh well :/ Hopefully was worth =
looking at though.=

