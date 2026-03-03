Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7181CEC047B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxLzf-0002TW-5u; Tue, 03 Mar 2026 04:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxLzd-0002Qp-0P
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:24:41 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxLzY-00048l-10
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772529867; x=1773134667; i=deller@gmx.de;
 bh=EoOvB9OsphbLMOc5WjcYD7vTB+Pu3ZWMIIuTiLi/Qgc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=efXPU/EGYmx4VN46RAZ17jDiKyYoXWkxzGFlGt99YFrGCJEK+MIrX2RJPVVIFWgA
 ysYJQXaLuXYZvMtdziEYpxdquAx/B1Lwmko1WH5Z4cGZgwsstEh7vt/lPCERmwU+U
 3G/vIdijji/V9kHKL+xQgMkMSgWnKMETs9SccbCwptDHkh5pKuHj3VjeRW7lKVsV5
 efrS1QmK/KP/8sUv+jkCQ/8nsCwQ4csQyuHRZpaw9sr9FlBDP/Zo3A6XaouInf0m5
 ztR9P8RoJwUe6A3IudGJg/TiCGoj1c/dqT/2MdMw8a/nyK/JQgaVfQ+0sFZlVuQwZ
 fjE+EFWVQWAENmwB1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1vFBU30LHk-00glCs; Tue, 03
 Mar 2026 10:24:27 +0100
Message-ID: <ec6a1b5f-5b44-4817-832e-0d4080a191d5@gmx.de>
Date: Tue, 3 Mar 2026 10:24:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hppa: Introduce HPPACPUDef
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-2-447a800da8cc@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260302-hppa-c3600-v4-2-447a800da8cc@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:woWg+x2TdDdf7eMlgLYlrQ/Z1wLqBKzjs+1cKnXatgR0Xy9BMe1
 oASxayhAJEdTDrGQHfbaak6m0XrZ50OTvnoZXD+ZlcPGjm1qrw4kFOyRsT8iJQaBokRpqYR
 o9RIbajTjcrdpfNwAgICGIYAVLAB80iYfm5CqQLzA5LWUS5wlsTVchH1K4wU2MSQehrzOWV
 oRTDDu7+Yi0119Q71NROQ==
UI-OutboundReport: notjunk:1;M01:P0:/GzOcDzwA8g=;jIKKtxxwbPggXmm2W84L0+8aUt6
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 12:56, Anton Johansson wrote:
> In preparation for handling different physical address spaces sizes (32,
> 40, 44 bits) a CPU model configuration struct is added to HPPACPUClass.
>=20
> Two fields are added describing the size of the physical address space,
> and whether or not the CPU uses the PA-RISC 2.0 architecture.  The
> latter was previously a field in CPUHPPAState.
>=20
> phys_addr_bits is currently set but unused, and will be used in the
> following commit.  Likewise, PA-8700 is moved to use 44 bit physical
> addresses in a followup commit to not bisection.
>=20
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu.h | 24 ++++++++++++++++++++----
>   target/hppa/cpu.c | 31 +++++++++++++++++++++----------
>   2 files changed, 41 insertions(+), 14 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>


