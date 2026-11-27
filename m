Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6507606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=dLA6PUXc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=sYv64kOj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=d//VpwksDrxJHiN1WT8vojAA6eFXgPF/FYpf5Pda8mI=; b=dLA6PUXcEJuSlVhTNUcT
	L8033zssa7zwMwXh+5fCBSI6l4yp9EouhSl1lwvDcIGUpmVxCu/iRS6RH7y1P8R3VN7DiZoFOm86Z
	dgKEDUqdlXfgtKky1BUVv5HLNl+Ub0LsgdvWojeQ0DuPsmFsdEBB8CDjaiymyyoWn5RXwg1i3+opz
	utAW2VyPW007NiRsSFyGH8I1WyrCfTiRqhL3kI3TKtzauIxEHpVBR7ng+K0SRBlHFeB9m5T/pvDrW
	IPNmyu14mzgeWwiHX1m23UpGM3ZtebsVfKDC1w3V4evPwyZoFCaqTk4RYoMuzreKE5HxpbjSx179q
	P4/1ryFFlzdHOA==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtx1-0008MZ-9m; Fri, 27 Nov 2026 06:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtwy-0008KZ-4h; Fri, 27 Nov 2026 06:17:09 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtww-0006rs-Gv; Fri, 27 Nov 2026 06:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=d//VpwksDrxJHiN1WT8vojAA6eFXgPF/FYpf5Pda8mI=; b=sYv64kOjwnXetfy
 TcLhugV3DDy79a1LreopLexXsOB3R+4n0oT6IG2Au78AcQxo4Um790kfGotlCjrS9nLf9vCuPeVk7
 1xLW1LvOlMEuuyKac9NxfN/gRGmjSQKSnhdFhssswOLErPngTvxmIzwSiKdr8S0bxywvNrjfhWVEb
 88=;
Date: Fri, 27 Nov 2026 12:23:30 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 16/24] target/riscv: Use 64-bit TB flags
Message-ID: <awln93rvy6I9IDbH@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-17-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-17-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/riscv/tcg/tcg-cpu.c   | 46 ++++++++++++++++++------------------
>  target/riscv/tcg/translate.c | 42 ++++++++++++++++----------------
>  2 files changed, 44 insertions(+), 44 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>

