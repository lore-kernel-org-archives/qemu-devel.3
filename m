Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9E0C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHfn-0003aV-KW; Thu, 02 Jul 2026 09:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfHfm-0003Z9-If
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:41:46 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfHfl-0002uD-1X
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:41:46 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-37e15d4e2a7so424859a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782999703; x=1783604503; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rotkQl0CiDNdCAUi76CHdJlf5BWJzBqUM9PHD/wQaVk=;
 b=oSUDYtViI80bm4LKHWaRzEJTrhrczBMUa/Znju8qjA7xLoQqMwYheOyolrM+/Tnl8x
 oPM105O/nrBhsRiKxWSqWEQWvS2M3yMN2nT7hgFuvnWFZEBTyprm3ug+0npzYvw+rI7E
 EAp8LaaSipc3DNJHGWR2GsQgy6ir6TBTGk/OOsZcFZSazLpRsjuHoSodz5qiX1cQXeS7
 Ki/xGr4gZpTl9HVN5Zc8TEh5e1bCGQAoeTFcYK9YunRMZnPwdtVaw1Xh6/53HHl3eMkV
 MH0fFK9EIaL/EEt/FdhUw0y6D6/4cyHEw8XRUVv1tnCam/svqDWmVyetF24n15Ju6g/W
 1hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999703; x=1783604503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rotkQl0CiDNdCAUi76CHdJlf5BWJzBqUM9PHD/wQaVk=;
 b=b29mgVp6WOLF5UXAsfBnb255NMACHbX2yLjvyFnz8qcr8clSzI41liC24GqMlV9wzp
 mTG0lI0f2jLNOiJPxpGugbqvPvUy12/rwXgOWBQ6GeeaE2CKVkVn5gsU03nz/tZX3spH
 irNVHazSB4ldhv/GZrZWpH7QdaSb9mrIXBip4aIWe/vvjk7xLegfn0wnoMFTfKx79RWE
 7zhL1KepMy5P2YEPrPiqxM/qeNSBt/Ypj3S3eG0y7EYS04Pw/d0BzzC5P8e8oM4lV8yJ
 YlZnem16AdFGxRTi4tjB4Hy5alDU8S2U3uT+bYfUd+zLWaDN1hWCYrkVQFYu5z+LODHv
 b0nA==
X-Gm-Message-State: AOJu0YxqQowMEsFOekdeZPwN73boILIeA7ehpNBMHxJdkpyg8kEuqwuI
 4OqhdbD7JBJdv0UMbE3kr/RdSUt6KluVfatlo/nc+iSNta9WcyQPLILe
X-Gm-Gg: AfdE7ckqZ3FmFLF88j+0khIyYHte9blKaMBVdoFSMONFnrv3y006tvL+U+VMFNzBLWE
 ydk1oG2pbw3oBDsB509/77LBeeY/kkjo0Iw4RpjC0T0bzze/vhcLeuoak1MWZmaTi2dzjQm//SA
 t0T16Enb4FcNICL436NdBTl7kgaaN8LvVf0Sv4hrF76D1ZxkwF8Q0uWbqekTk8HR4orosYIPrNi
 BN5Go8FGq8QrjCf4FbuHW2RbyTCMRgXOLK3iz0X90ZTYHbXf8HlEX4gSYlbomQTrheoZzN3OFis
 whp91S20xeD/InobusaOnXuVp2ugZMi9FUapY4bGpQnjy73VrrxmS+4vfUFSYNEEayDj5g/M/Rx
 ixkX9xnW0sjkXaIm1RcRA3aIfU2fwu4JtjB+8Dwy3yeO22TLJgoalC4qUd1VNRDsSzxxTHiPi9o
 05vnXx9HIDAV4l19PASFr9hVoZ/ccE4TbcY0+VmgFha9rnfvg4TNBnEBTVF/Q=
X-Received: by 2002:a05:6a21:6f12:b0:3bf:7498:9cd1 with SMTP id
 adf61e73a8af0-3bff42b62a6mr6332890637.45.1782999703353; 
 Thu, 02 Jul 2026 06:41:43 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7ef728sm9401251c88.3.2026.07.02.06.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:41:42 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:41:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 1/7] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Message-ID: <akZqi6dSMGa_0igp@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610214133.1882563-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 10, 2026 at 06:41:27PM +0800, Daniel Henrique Barboza wrote:
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
> 
> This means that a vendor CPU can set .profile=rva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6423f2d548..e02d53cbba 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2744,7 +2744,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>          mcc->def->bare |= def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> -            assert(mcc->def->bare);
>              mcc->def->profile = def->profile;
>          }
>          if (def->misa_mxl_max) {
> -- 
> 2.43.0
> 

