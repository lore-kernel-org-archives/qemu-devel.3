Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7825E674BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 14:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXhJW-0003PF-MT; Mon, 22 Dec 2025 09:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vXhJB-0003NG-71
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:54:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vXhJ9-0001m6-Hv
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766415282; x=1767020082; i=laurent@vivier.eu;
 bh=nRXx4IGx+Y353ZDf4AwtKBEvq28kB3LjIlAzXOwTVfg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TABm7HUpODIv1XNy45whcynoCzdhkmDIRJxwJN/yHDXZiYpXalX1yHhMXdYVxkCC
 LjDWJl791TrV2kUFkVFipcl/jP1A2VOGJjxFk92w2mQhm2sjsyiBMaggJbOn/vLJE
 6VAAvoAjwtPDgo4aWpAv1rYpcL7v2GeikfZ+ec4LyCTHTRKw7UkiVr2+Dd6WiZEP/
 hbH/40quZh+ShLhnLAMqZHUfrrpETycsb+7lKnXQ0PMcvI05VysbQnMnNwXzT6QZY
 Ee9sPg1l8dz611q/q6/dJOtkbB2bT6kr92//QEObXDr4pQdCVHhD3U7/46JniCU5B
 sa8uI9X7UZ4Z9nt20w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLR5f-1vGImP0IWx-00UDoQ; Mon, 22 Dec 2025 15:54:42 +0100
Message-ID: <6a739df1-366f-40f5-a5d7-4b16060f851a@vivier.eu>
Date: Mon, 22 Dec 2025 15:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/m68k: Improve CHK and CHK2; implement CMP2
To: William Hooper <wsh@wshooper.org>, qemu-devel@nongnu.org
References: <20251222002634.61480-1-wsh@wshooper.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251222002634.61480-1-wsh@wshooper.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Io5AgiH3I3doxeLjWqCPxKUTexUn2PUh5vBdi8Gc4n9io+FzRRu
 3YzhLApsSSFdfYKINxU718RNJTEXe8n0j5sKXc2zeJC+BGSpxsssZZ53DL4oVRBfYUiTBPn
 D6K75lOaZ8cGxGVZnbeHA7PYz3yWqzHf7fom4u37m00DB0Dko0he/QwvS75EhDu1w0hQC4f
 mMgX3aBpQu+VzqfOOQ6cQ==
UI-OutboundReport: notjunk:1;M01:P0:jc76E8ThOtg=;7eqkLZACsJ0pW/ah6MEuWGInqa9
 tBxuVREQm2Pn+uEdU7gqsoeTXNQNyZiJK1GCNZuFGPHdElYBBDhdefLfXTMVPmtkHU7aNJAzF
 fTqjneDaWHapaNoYiisfHvBkUtbeRtLnGHW8qgP4n8eWQMlpaarZ2pYzdGjK/m+Wx8oDSPk2W
 9df0KvkDQB0eF5Up4MjOnbIQkeNJ2MPqA2HYxr8Y+QyEUWgWCnqnF+1nCPlm1QCOv4vfhdsn6
 LgobMi0MZp/2YAHg0SlP4ZJBa3p6YO5/oTy0bW8BPb6RkeOBlu10coVDdmHXXUYrdeV1N7rAo
 9jv83OKNrdNrlJsvia6T2d97a0sl7MLSQz8LiB8zEU2Z3wpNzCY3EDGj+Rx/ctsEhNek1+mNe
 IjPRoDXGVzXggsYmMsjQ3q1Q0wpG6EOVxUGKl2BTDBbmg8Qn8NYASrs3BlyS2kw51fGckjK2r
 ezVkwT2p7Cg7IyJXpFWEHT6fz3wP4k3yk8Ef+ZllYViWIHiVdVKp/DB1Mu/Cty8Upilz8TP1u
 e/SxYM/YY7t9C0iGm/HC30W36dciC5bNGor40rUd9fIutu/BxcUZf0nkTu8vCWQ2kwY3/2Xhk
 hvfxXpkgzk2F/qLjUmt0ZJYG30941wetXjqwaiotSLlu+7lCORTSM/+sM+W9NrWvrux64asnF
 QlLq0z8/VeAWmYCT6qYmoWO0UpwEKLziheVBQ7oYUZVpi/dwpE53aJjMnLKQbyxkYy3Xp8vUK
 jpwDm/DqIySasaD30D1jG2LAYbva6hcwhKxe7dZ3Pbaq9/BLqji/7ol8KIfVnNGTetTOCR2Ms
 RNRKnnUkjMx96cQ2EHPaXzh0/aHyaJT5C90wyqSPgFaeQhDy112+X2aNXNI0kPEKK2iFWPXVo
 zOxy5asH67hCVsjkmowz30YNndr4XXxEW6AaT7+gYnRCchc3D6s//Cm/DKPUGXabjMGWFR/eZ
 qU3G5rRhL7HhPY+fJ2Q3+h7YvGSkdhZoRxW7c/vhxiF6gNLK5eJbxKL5ktOkjAyPrf9eXxKXW
 oG6bJOiddXrkwdcZdL0hqxJR6J+i5ue9bl6/xoCxgGvRc0/FXx4zFnMQMY/IpamSUTpQCCGCy
 Q+RHMiQrij/uWvwquDnUc5AxyZ1Iy0jN8/4gY1d8/5NW6KZ4iWIZQNfultTAVH3zJlpnCUe/3
 6grblHBW9Q6ZCkyc2Wxx6ly+5RKrZAZJqfi0UFMhoj5yGJP8qh46fJkx4TX6ZYa/PBcoUY/BB
 h64GRZlF+KMbsPnBMk7/ajhpw/PJU1rQtD1Mym436Dwti8KcwmAuunxb3wMrXjJD7OVYTPZvi
 nk4Qeue1Ri79danGJR8zifOdEFkHT1ikojSjNBJMmZeHH0MfsZvyfmjaUHxCebS7McrRhLVc9
 E3ccT59+IXEThV1ahqEt/IjxpM68Qzb7ZQXIRgpUI+Mlj2MdR6Z051AyH5hyuNZflSKU3XtKJ
 M/jAnZYp16RTxL0/kftD2DBGA9wyv4STJYPP0SL9RkMxFYhDYlGOD+tZfOumMWLTTm+HakM09
 5AAtUzk3KDqNV6PaaOsPa2aHbbenwRRgcOOyl9QfXWzBlO0BDdEdv+VL7f0lPTxedF3ENIRb7
 +2m7IQn0yoBAUKf72r36Quxbjl88ZKPoLafmQXYH/id6kaF5yo8wStVfFhCX3Nqhc6mrUClfu
 Qys+kSd+rrW6HFF3N59siMc1yv6Wolj/1rmg5g1CDRkV0uWSAraExt2No0uceMI/PNdAOdfx3
 jpwcoXi/JCW3I0bRBjzTu2cdsaSScgaaIVskC77A0gf4ZJT1i3XUpawE=
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 22/12/2025 =C3=A0 01:26, William Hooper a =C3=A9crit=C2=A0:
> Some CHK2 (Check Register Against Bounds) instructions, such as opcode
> 02FA, cause spurious illegal instruction exceptions, despite being valid
> on Motorola MC68020 and later processors and used in existing software.
>=20
> With this patch, QEMU:
>=20
> - Translates CHK2 and CMP2 (Compare Register Against Bounds)
>    instructions [1] having any valid size or effective address. CHK2 and
>    CMP2 use the same opcodes but differ in bit 11 of the extension word.
>    (BITREV or BYTEREV instructions for ColdFire family processors [2],
>    which use similar opcodes, are not captured, however.)
>=20
> - Implements CMP2, which "is identical to CHK2 except that it sets
>    condition codes rather than taking an exception" [1].
>=20
> - Populates the correct "logical address of the instruction following
>    the instruction that caused the trap" [3] in the exception stack fram=
e
>    for CHK and CHK2 exceptions, according to the number of words in the
>    instruction, including extension words, rather than default lengths.
>=20
> An existing test for CHK2 is enabled, and tests are added for CHK, CHK2,
> and CMP2.
>=20
> References:
> [1] Motorola M68000 Family Programmer's Reference Manual (M68000PM/AD),
>      Rev. 1, 1992, pages 4-72 to 4-73 and 4-82 to 4-83.
> [2] Freescale Semiconductor, ColdFire Family Programmer's Reference Manu=
al
>      (CFPRM), Rev. 3, 2005, pages 4-19 and 4-26.
> [3] Motorola M68040 User's Manual (M68040UM/AD), 1993, page 8-8.
>=20
> Signed-off-by: William Hooper <wsh@wshooper.org>
> ---
>   target/m68k/helper.h    |   5 +-
>   target/m68k/op_helper.c |  16 ++++--
>   target/m68k/translate.c |  31 ++++++++----
>   tests/tcg/m68k/trap.c   | 105 ++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 137 insertions(+), 20 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

