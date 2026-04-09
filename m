Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3EEF364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxeT-0004rX-HA; Thu, 09 Apr 2026 18:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxeS-0004qz-22
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:15:04 -0400
Received: from p-east2-cluster6-host7-snip4-10.eps.apple.com ([57.103.76.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxeQ-0002Pi-DZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:15:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 EA2F51800314; Thu, 09 Apr 2026 22:15:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775772901; x=1778364901;
 bh=7VLIdZSrJkKvwROHunJGnsooiZKYyiK3MoB3QY6d2JE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NMtVJBmzkHdUOlX/NL3Y4bBwPk8br0j4yRMVNQ9nKArgJkBoFKoGZhrbsHviCSI9Q9zKJ1uxcTU+uHZpvEAwx7LIUGyII+GLpX+Kso67y7dR6nTcJuVI5yQodGpFzWgnyiZ095d0c6ayiAxwGQXmeNdPkSROOEGV0kvk63YRe5jO8yVGminKd3Dvs+a7HIgKPeMzQ0BDtDyveARzGA8PnaewalnPZGSrZhsgKViIlEyQrI5rf12SW1wCXTAUgjaA4aQz3x0BFTaRvleb7UJiCAgXJS1Yb8tUKXK6iYIrKmqM6JodStjDFVmvVCYD/3vqW9VOjgyPHh9ps+YsP7utSg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 B7431180010B; Thu, 09 Apr 2026 22:14:59 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 2/6] target/arm/emulate: add load/store register offset
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409220614.65558-3-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:14:49 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: 7bit
Message-Id: <AEADE78C-3C60-4ACA-9BA2-C505276CC8ED@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-3-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=I4Johdgg c=1 sm=1 tr=0 ts=69d824e5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=b-oFJ_PZsC50UvAg2yYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5ZVux91z_1Tud4-ESZsJRjvtG_ELxzvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNSBTYWx0ZWRfX1tMDBCscFe4p
 pVblqXotxrkaHQVN4RsOZYaIAsAOeDG2X4z7vP0NX+GXEt428S95RFimCpmKm7HrNochvVfN3VH
 ovCNR2CDVj1QmJGudnhihYbTxVqUM4HUYW0tTPKCOUU1kJk7XRi9MV/jErvJI6IksqoOXM9QFyl
 L33lHZv+pZe7yldcXHxa7mbroXKnRLXjGHEzgzzRogzwALL/bi2giCdy5R5fMd2r0OYvtG5CQQS
 NOZFCZMOF6yBy9u+AWGkfFUZPSw2mpdikVCfjYOOKHmGUpXLODgI7KCdD3JbOYtrSEHUhDqZEWN
 ptwUl4nX+UsrwiEBXSDw8A21tulCFoe6V/w81sLEoPX/teaFYIpP150vgLSVZU=
X-Proofpoint-GUID: 5ZVux91z_1Tud4-ESZsJRjvtG_ELxzvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842
 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0
 clxscore=1030 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090205
Received-SPF: pass client-ip=57.103.76.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add emulation for load/store register offset addressing mode
> (DDI 0487 C3.3.9).  The offset register value is extended via
> UXTB/UXTH/UXTW/UXTX/SXTB/SXTH/SXTW/SXTX and optionally
> shifted by the element size.
> 
> Instruction coverage:
>  - STR/LDR (GPR): register offset with extend, all sizes
>  - STR/LDR (SIMD/FP): register offset with extend, 8-128 bit
>  - PRFM register offset: NOP
> 
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>


