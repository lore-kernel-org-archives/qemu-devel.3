Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A00CCD186
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6SSq-0003FH-Lh; Wed, 08 Oct 2025 07:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6SSo-0003EP-HU
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:10 -0400
Received: from p-east3-cluster1-host12-snip4-6.eps.apple.com ([57.103.87.119]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6SSk-0006gS-Sv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:10 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id
 06E7118004DD; Wed,  8 Oct 2025 11:36:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=f1Pbcg3fVKJmv3dCg3ZQaZBGC+6jeUasiVzqBAL5huk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=bLcvEBAJksfreqYlmyyF4jU89bIUDw0x/Hi05LavK/V19hIhIObP3CT75ZwMouL3sp+1eaGiLzJgdQ5G9ANXOCg9SdSnj2It/jKT0hxIza481uxQSJnupKbfDKg3zfq/mnUWcLW0cFUxH/zeb+MG8uRZSHeP30b/IokM+/MgYdQa3t56H3xIX2aScQEsi0lUrYsZQ/4YjxCHm4e9KQYdCjmtH1D1Usv+vF3aoiUEa7zZNc0F7dvMMYM2Eln1pu1IZvsaX9cmHBEZl4XC1kYwJxnU/15mnjBYFyX/XEaKXG/X4Eu/U6fNyGWu1P6uf+V03S3zFvY4dQryTNaRamuU9w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id
 53823180015E; Wed,  8 Oct 2025 11:36:00 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC v2 2/4] hvf: arm64: add workaround for Apple M4 to run older
 macOS versions
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <184ed096-60d1-41d7-a0af-c1af75cfd014@csgraf.de>
Date: Wed, 8 Oct 2025 13:35:48 +0200
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2399E8DA-E73F-4B59-8E06-F989BA2B462E@unpredictable.fr>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
 <20251007203153.30136-3-mohamed@unpredictable.fr>
 <184ed096-60d1-41d7-a0af-c1af75cfd014@csgraf.de>
To: Alexander Graf <agraf@csgraf.de>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-GUID: U5GoMbDa4py-ewmchPwdspxK2wWB5ZWO
X-Proofpoint-ORIG-GUID: U5GoMbDa4py-ewmchPwdspxK2wWB5ZWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA4MCBTYWx0ZWRfX+2eNaf/Gcmam
 Xksrs2WuBSSEsqeNeGOmtIw0s9/KpEfJ7PK90lDt2TnwiDzcXiB+tbP62mGXTcjCjQU/VY8OIfi
 f0lsmorL/bmpH5PqhVIaJvb7rQQoXzXGFYQ/wkikFA9LQjvIET7LAEZ22HGY1j2wuc96bSjm28W
 ivX/PfTCo5RhDAQ+ZWmGtTgpuLCkpU8+LLeaOiZ8mZQmIfyws/d+7pMWvBbPbukQ+JvFhk3EI8j
 8hVqQiJa7javxC9tROJ4lHYsAdx4p1h2TTT2CeuKIVt0mjy4cCOMUhmDiM+MKG7V5sYQ7aO9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510080080
Received-SPF: pass client-ip=57.103.87.119;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 7. Oct 2025, at 23:12, Alexander Graf <agraf@csgraf.de> wrote:
>=20
>=20
> On 07.10.25 22:31, Mohamed Mediouni wrote:
>> Apple M4 removes FEAT_SSBS. However, older macOS releases
>> do misbehave in such a configuration and do not boot.
>>=20
>> Use private API to trap SCTLR_EL1 accesses through FGT.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
>=20
> These old macOS versions did not include M4 support, correct? So =
wouldn't it make more sense to make more recent macOS work instead?
>=20
> Alex
>=20
Apple ships such a workaround in Virtualization.framework to allow older =
macOS VMs to work=

