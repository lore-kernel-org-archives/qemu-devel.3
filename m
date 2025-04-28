Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50F2C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Pt5-0006wg-ML; Mon, 28 Apr 2025 10:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1u9Pt2-0006w5-Me
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:55:13 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1u9Pt0-0004Lb-Sh
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:55:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C694DA4AFDD;
 Mon, 28 Apr 2025 14:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D32C4CEE4;
 Mon, 28 Apr 2025 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745852102;
 bh=zi6Vwcq4nnHq+r8Y7dxMQD3ZRIktPnY93hyecncn6yY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XGCzqkJ/CAbb5iJEKqB66iBVf+HeZWnOitTsVYthGd9ER+QN8BAH2uE68uc86isuz
 br+zRKh+e1lkSTcQbcM3MHFSWpS1eQ2TPVnlU707Zq8U/KIUHLGK4/he09TygaoAHp
 PmvZrss5KUxXt71gso+J2KIo+5HqRUapKEYC6C2oIVOm+fwLhXmwKHc8Q6ZzcEn67E
 hEutu/BeNPRHkv7IvugTqeIlfjLR/oDZ14PilxxRHd1/lk6p2qqXd/3i7ulAiF+nUz
 r0giMzrgUy6lVvsvSUEG4Hgv5f7icmaL/15QNjC2SwQ5Zlkm4TA4Oezk4EY7utI1cM
 g7OBNpSgbuUHQ==
Date: Mon, 28 Apr 2025 14:55:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v2] i386/emulate: remove rflags leftovers
Message-ID: <aA-WxBhhLqllyuau@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250428105108.196762-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428105108.196762-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=wei.liu@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Apr 28, 2025 at 12:51:08PM +0200, Magnus Kulke wrote:
> In c901905 rflags have been removed from `x86_decode`, but there were
> some leftovers.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

The code looks good -- it is doing what c901905ea670 did.

You can add an extra tag for ease of backporting:

Fixes: c901905ea670 ("target/i386/emulate: remove flags_mask")

Two nits:

The subject prefix. The majority of the patches start with
"target/i386", but I see ones start with "i386", too, so perhaps this is
not a big deal.

The length of the commit hash in the commit message should be longer.
Linux kernel uses 12 characters. Looking at some recent commits in the
QEMU tree, their commti hash length goes from 11 to 14.

Assuming you've built and tested this patch and with the minor issues
fixed:

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  target/i386/emulate/x86_decode.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 7fee219687..7efa2f570e 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
>  };
>  
>  struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false, NULL,
> -                                       NULL, decode_invalid, 0};
> +                                       NULL, decode_invalid};
>  
>  struct decode_x87_tbl _x87_inst[] = {
>      {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
> @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_st0, NULL, decode_d9_4},
>      {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
>       decode_x87_modrm_bytep, NULL, NULL},
> -    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL},
>      {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
>       decode_x87_modrm_bytep, NULL, NULL},
>  
> @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_st0, NULL},
>      {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
>       decode_x87_modrm_st0, NULL},
> -    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
>      {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true, decode_x87_modrm_st0,
>       decode_decode_x87_modrm_st0, NULL},
>      {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
> -    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
> -    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
>  
> @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_intp, NULL, NULL},
>      {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
>       decode_db_4},
> -    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
>       decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
>      {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
> -- 
> 2.34.1
> 

