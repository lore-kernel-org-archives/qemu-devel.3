Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290A2F364C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxes-0005YV-Iq; Thu, 09 Apr 2026 18:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxeq-0005Xl-OX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:15:28 -0400
Received: from p-east2-cluster5-host7-snip4-3.eps.apple.com ([57.103.79.26]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxep-0002fU-8S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:15:28 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 D1ADD1800312; Thu, 09 Apr 2026 22:15:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775772926; x=1778364926;
 bh=/5Vbz+E96X2T1nAdWJTRiWqUg5QK2nKGppZ2ngbxNg0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=TNcHZdSIkKucD0ge1PfMhvOauN9o3N4FZ8WTeyWSmKa/+daLG8N96ZQVltosz0UVgB5xFQ5uVVOL0Qmic4ALvwkjnESEbbF7n52u5waKWgCXjHSvTY/czQ6WRCtpAtcbWUp+IKD3MNAKSztL5c3zfy5BTy+uwl+2/QgSwYX0OLB99lUk3/wK5c+LOhZtrVILo88X0YpR0nW78v9u0+wu4yvl5f0qvxaBh3smFWMkYroQXYRwRgzmOU/49MEpOkX9DZi1FcXrGNMdEGuuVNRYwoDsUOiCZqmh2PYkKR4D4gpuA/IGnYavFZdbqpjFWvA9oHq29NzC4LDZlEU/CBkQBg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 3768A18004D4; Thu, 09 Apr 2026 22:15:22 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 3/6] target/arm/emulate: add load/store pair
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409220614.65558-4-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:15:11 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: 7bit
Message-Id: <B3D25F3F-F62D-476F-9C11-E509E948ECEF@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-4-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: wM0UHdw3zNbOxmoNc8ErcgWwoRcbaDzf
X-Proofpoint-ORIG-GUID: wM0UHdw3zNbOxmoNc8ErcgWwoRcbaDzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNSBTYWx0ZWRfX79ZiDLsJZIIy
 2lDCKL6Tg7CD/+BQunbtosrJysTBS1wzxBZxY8aMqNep8OkKTVKEcTp3mk7uIEjnGWkkyjpr5me
 4cXU0zHrB/Z337QEcoLyj9g33DLtlLiMReLnAuPxwJhvtVaPN7nnDqq4bpvruAJGkzGTHX9rZgx
 5FOjL/nNQ3EfK2TqibN1xuH9yhYbOxzlqieFoVQQlIxzsmCS0yjuw56lmV3bLRl0EpPuGiPXZOX
 lyYoL2QRhuysXT62x7lFtlw1GO3SxYC+SHEzekBIQr6GceOwi+Li0+/ypFfROiFKNMh72gH7DNE
 9WBf0lwKPUllqYBYtEBTM58hwkP2KQwrPTO2zhQEsH+B0XdHcWnV5ChuOyvA0g=
X-Authority-Info-Out: v=2.4 cv=BoyQAIX5 c=1 sm=1 tr=0 ts=69d824fc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=pOlJZkMN3WBBWC9JYAQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=669 phishscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604090205
Received-SPF: pass client-ip=57.103.79.26;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 10. Apr 2026, at 00:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
> 
> Add emulation for load/store pair instructions (DDI 0487 C3.3.14 --
> C3.3.16).  All addressing modes are covered: non-temporal (STNP/LDNP),
> post-indexed, signed offset, and pre-indexed.
> 
> Instruction coverage:
>  - STP/LDP (GPR): 32/64-bit pairs, all addressing modes
>  - STP/LDP (SIMD/FP): 32/64/128-bit pairs, all addressing modes
>  - LDPSW: sign-extending 32-bit pair load
>  - STGP: store allocation tag pair (tag operation is NOP for MMIO)
> 
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/emulate/a64-ldst.decode |  68 ++++++++++++++++++
> target/arm/emulate/arm_emulate.c   | 108 +++++++++++++++++++++++++++++
> 2 files changed, 176 insertions(+)
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

