Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCA2109C05C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ul6-0003Eg-8y; Wed, 25 Mar 2026 16:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ul3-0003E3-Nv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:23:18 -0400
Received: from ci-2003i-snip4-11.eps.apple.com ([57.103.91.221]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5Ul1-0006Ov-Hl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:23:17 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 45F5A180028F; Wed, 25 Mar 2026 20:23:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774470192; x=1777062192;
 bh=ciBGhMhCZ5Hq27StOQfDYXTl+bMsGQQe7B0OYqcFG80=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=VVsw0ri5Lg5j7Q1zgiXLUGu3El8u6X+LtJv0Xvn5Wgsc33/l2P1Aw+PWA/5vE/K4LusBcksNrEMmSMlTsvW7js77ZNpyKeNOTnJ6u2R45bXvvmhZ2295QYtAF3uRKvTIYSNMmxPznyueTxnVubIAq5jSLjZ0M566s1xse9cLBefHPiLsGNFVbX6XmdrN6/ura+dpsa7+6IX6ps5GjZpYVRO0wrIQ+dcyR4ckJB1rQauaFyL4YEKDBe4gzrQf86VH7QoJqLJ27LeAEvyYkTk8D58gLbnhhCwBrcLVcsiF0dkdR5r/u/+7sk5A0nD5F/Ssm/7R28kTmJJL9OUKrPH0sA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 89D55180010A; Wed, 25 Mar 2026 20:23:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
Date: Wed, 25 Mar 2026 21:22:48 +0100
Cc: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1MCBTYWx0ZWRfX6SC3eENelKFU
 w0m4e6SyT5wld5b/3t1ST85767ul6axQ+T/KG471WRoQ5+9xO3Dcwy+FrXI1c3ViJVhagzpbBej
 iFFcgoYFCF3KTlEz8Z4AspOzMZB0Fy1jPIfkxvJ2rJMF0nNdJNu8SBJx/4ucZkzLOqtU3vqS07s
 U4EbbUvnmr7VCfped9wclXOk4z59jbYEQj0hoAo1vp2XCX9ZcrZL9KiJcv7wH5oXQqo7AGEpqxm
 wj94aT9tGx+tuNgbPv4Ske/5qsZKhUm5SDI9+5rA0Xkls6vyaGgLteyTnX+52Z1lTd6tRERlmTC
 51cuKIBDvf8w1IgDYcD6xZ1RXmJUcscG7MwN9xzN5MolqRBSKmJNaFT9EO+GZI=
X-Authority-Info-Out: v=2.4 cv=JNQ2csKb c=1 sm=1 tr=0 ts=69c4442e
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=LD7-i-b1khbNo26fzBgA:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-ORIG-GUID: zVFmfnmsQb9sM0gF4Jcr9_ZyzzGaYyXF
X-Proofpoint-GUID: zVFmfnmsQb9sM0gF4Jcr9_ZyzzGaYyXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1030 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603250150
Received-SPF: pass client-ip=57.103.91.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


> On 25. Mar 2026, at 20:31, Stefan Berger <stefanb@linux.ibm.com> =
wrote:
>=20
>=20
> I remember having played around with TPM for QEMU on ARM64 (Raspberry =
5(?)) a while ago and had the impression that there was something =
related to caching that prevented the MMIO interface from working =
correctly and Peter may have confirmed this back then on IRC .. I am not =
sure what exactly it was that didn't work correctly when run natively on =
ARM hardware. It worked well when run in CPU emulation on x86_64 for =
example. So I am wondering whether there is a minimum requirement for an =
ARM CPU or ARM CPU features related to caching that someone needs to =
know about to be able to use TPM TIS successfully? If so, it would =
probably be good to mention it here as well. If you know.
>=20
> Otherwise this looks good to me.

Hi,

There are two things here:

- For Windows guests it=E2=80=99s a bit complicated

Windows guests LDP accesses on the TPM register range which doesn=E2=80=99=
t match ISV=3D1=20
syndrome requirements and needs a workaround in current QEMU.

I _think_ the QEMU-side workaround described below went in, which is:

If we map the TPM register range as read directly, trap on write to =
workaround=20
usage of LDP then we hit...

- FEAT_S2FWB

This is part of Armv8.4 onwards officially* and allows KVM to force a =
device=20
memory type read to be promoted to write-back.

That allows the (easiest) workaround for (1) to work.

However that=E2=80=99s not the _only_ workaround, you can remove it and =
include
https://patchew.org/QEMU/20260317174740.31674-1-lucaaamaral@gmail.com/ =
instead.

That works fine and removes reliance on FEAT_S2FWB.

* some older Arm chips implement equivalent semantics without signalling =
it, but
that might depend on SoC-level integration.

Thanks,
-Mohamed




