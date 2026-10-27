Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F502606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wl/2iLdr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLqbR-0004Ln-DD; Tue, 27 Oct 2026 19:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xLqbO-0004JL-4A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:29:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1xLqbM-0008NT-CJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:29:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so250119b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793143745; x=1793748545; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ln10d+mgN0LQwoxe6WFCwLj+G0pXkKeGxjA0i13u1Mg=;
 b=Wl/2iLdrKiXIOQvGChdlbq2iZlyhBdMRtUqwObZziI8A74AFFZ3zpeApUsYrdjX+ZG
 Pk/8TD9tFYtHw94khi2EyiRsWFDIZoSACdxKHM65rh8LwiCPi1wuWlyEf2BMLnepbhL7
 BRsuTsJaG+n8piCV52lR9T1LNebEqZr8croDzRCd6fBUwWSZDQ7WkJEgI4m6PJ2CkVC/
 WPNLTOYSpIHAKN7pNXMibNf5d5mgWHCkuKsHS7WJuK5skbUqqs3fFZgT04IJp0toRdek
 nw2tsKC4XUfG2E6UJY2trdzOdHQ+6Mk8NemmvAgayekLASxJXxMwE1gir6rNVysKNZTU
 hj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793143745; x=1793748545;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ln10d+mgN0LQwoxe6WFCwLj+G0pXkKeGxjA0i13u1Mg=;
 b=X2CHFT6wlUnv++h35lItOYpS0OnqeuHvSJ2y2tjeYyjO05GirgVZaU93b4RSdCRUfJ
 U5BFizloSyZIe0ZeHICZ1I15WzjgGB526qHrKqBZQwlwel+AGDKNwY9bGihI8ncQsC8U
 qRlXkOG5gpJXxpOkDCvQbYAwWoVAvGar2sujiOBCLFW9LSzwzoq1G6qjCI2aw2HOS6qo
 dz+feot1LHyDt8W/YIrcgm/A4jJjO9OftmiEIQ/tRCuJIFNE8OtACkaWHG64Fn5Y/xau
 uChp8Vbgr1bE3a7iTIuc8o/i/kwJb9Qa/KSho+hGYsnU+dwghPB/6SG+CA6PbGU8lRT3
 r8ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBws8phqtUndT0rl13sWrznVjUS/W2NBCdITmOOF+iHkb+v0SvqwWBtAoF9ua8cngHg4U/8FNyuix6C3@nongnu.org
X-Gm-Message-State: AFq9FYKlQc51B0bQuxcfe0MYoBohrNa0KxIGbhOc/wwpv17MNYJg7LMf
 WD9gJZqQKfrPTrHB7tvmFjVbkZtoRISNI1GU2dQ9sq+3sl5A4GD829SR3GH0Oel1
X-Gm-Gg: AYBFou1OrMleGGM0OgIcbW8ve3/y1ROxjn/BXWtUG2tt0GE9TG2DbZj9OmyChUy+ii2
 E4QEGsPJVbc0VpGmdWB+zIm2bZrtlipmHYmd3iuPcJDPcvxnxYwxebB7oTYphHFjaLmj5YohcJT
 757RP/GStHC/3nJtoz76kPaHKNePJaImVCFAsh6zfYRYLQtyf12YF7PZsyMvMHT2Cz7esbatAPx
 7E2aq/zK0bWpDSpNgrFd+tOPEJtrkOVJv0CLTVylsEuYvgZDg/x9doRAkNrMHkZs5BxMQlZ3lcV
 U33LlgsFWxqpYj+Hig8AlQndQCn/aHATcFaAi0Url2Fi6EuBtF5S7z+o8Hyjpsz9bnhS08amAzR
 kA43PWIrSGUQxWVOy/yOw9au/BbJx9I+nSkwdc5h407VeHmBqdlwg3nMaOgYLdDvk1dLVOKmIK+
 OLlag6f2/tCACRv7LMgw2h6kN3wxboTKnxqLnSZRM5uLqN58HWw3sS7VIjKRPWiJuXnMLEK1Rsl
 E15OB03nzZYWXJrid7xkUlRblQJlHvDoX04tU3zM0qpvM6EZxs=
X-Received: by 2002:a05:6a20:4327:b0:3e2:89c3:2fb0 with SMTP id
 adf61e73a8af0-3e902107ceamr548447637.7.1793143745236; 
 Tue, 27 Oct 2026 16:29:05 -0700 (PDT)
Received: from cxlqual ([220.120.90.131]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6c2485703sm352437b3a.49.2026.10.27.16.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:29:04 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 28 Oct 2026 08:30:32 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] hw/cxl: Align mailbox payload backing storage
Message-ID: <auE0GKAvRSufpJuZ@cxlqual>
References: <20261027102227.4976-1-icheng@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027102227.4976-1-icheng@nvidia.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 06:22:27PM +0800, Richard Cheng wrote:
> The Get Supported Features handler treats payload_out as a 16-byte
> aligned structure. However, the mailbox register is aligned to 8 bytes.
> Since the payload starts at A_CXL_DEV_CMD_PAYLOAD, a misaligned union
> will produce a misaligned payload pointer.
> 
> The bug can be triggered when QEMU built with UBSAN:
> 
>   hw/cxl/cxl-mailbox-utils.c:1571:39: runtime error:
>   member access within misaligned address 0xff7772f3d628 for type
>   'struct <unknown>', which requires 16 byte alignment
> 
> QEMU aborts while handling GET_SUPPORTED_FEATURES
> 
> Didn't see a strong evidence why QEMU would treat it as 16-byte aligned,
> so I want to raise the RFC and see what's the actual corrected fix,
> rather than dropping the aligned tag directly.
> 
> Align the mailbox backing union to 16 bytes. Since the payload offset is
> 0x20, payload_out now satisfies the handlers' existing alignment
> requirement.
> 
Hello Richard,

It looks like Jonathan already has this commit in his tree:

https://github.com/qualcomm/qemu/commit/271340b769bdf4b2614fcff76455a813f154d77b

I'm not really sure why the features handlers require QEMU_ALIGNED(16). I don't
see anything in the spec that requires the 16B alignment. And the Get Supported
Features input payload is padded from 8B to 16B because of QEMU_ALIGNED(16),
which seems not right?

The commit message from 271340b7 says:

"hw/cxl: Ensure the register space for the mailbox registers is 16 byte aligned.

Given there are some carefully aligned UUIDs in the registers,
enforce the alignment to solve ubscan issue..."

but if that refers to the UUID of output->feature_entries[x]:
the output payload has an 8B header, so the UUID of any feature entries
won't start at a 16B-aligned address anyway?

/*
 * Get Supported Features Supported Feature Entry
 * CXL r3.1 section 8.2.9.6.1 Table 8-97
 */
typedef struct CXLSupportedFeatureEntry {
    QemuUUID uuid;
    uint16_t feat_index;
    uint16_t get_feat_size;
    uint16_t set_feat_size;
    uint32_t attr_flags;
    uint8_t get_feat_version;
    uint8_t set_feat_version;
    uint16_t set_feat_effects;
    uint8_t rsvd[18];
} QEMU_PACKED CXLSupportedFeatureEntry;

struct {
        CXLSupportedFeatureHeader hdr; <--- 8B
        CXLSupportedFeatureEntry feat_entries[];
    }


If QEMU_ALIGNED(16) is not needed for Get Supported Features, then I think it should also
be dropped from the other Features handlers, and Get Log (Opcode 0401h).
I don't see anything in specification that requires 16B alignment for those
commands.

Thanks,
Anisa

> Fixes: d80378943a6b ("hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Reproduce with:
> 
>     1. Configure QEMU with --enable-ubsan.
>     2. Start QEMU with UBSAN_OPTIONS=halt_on_error=1 and a cxl-type3
>        device.
>     3. Boot a guest with CONFIG_CXL_FEATURES=y, or reprobe the endpoint:
> 
>        # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/unbind
>        # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/bind
> 
> Best regards,
> Richard Cheng.
> ---
>  include/hw/cxl/cxl_device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ba551fa..2191b7c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -248,7 +248,7 @@ typedef struct cxl_device_state {
>              uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
>              uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
>              uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
> -        };
> +        } QEMU_ALIGNED(16);
>      };
>  
>      /* Stash the memory device status value */
> -- 
> 2.43.0
> 

