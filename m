Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDCAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iWz-00031i-Lo; Tue, 30 Apr 2024 04:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1iWv-00031M-JX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:08:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1iWs-0000iO-SA
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L6gyvdo5rOdEhsG6Wrwu7Ii2dcaTF0PmtVxprNViezM=; b=NB+7lW7f1sl9t/w7u9RvEZ+IMT
 9vI3kyd0C1GoMZBFHvEC64jB2GCHhcIn+ZzgXa15BUJL/U1m7rQ6XFtBxaGvYLO1EMgGa396CwX3o
 kU3OfvBlMjAVpJyvlUMKF7UcqXtCJvUj9rDptiJzMbJNrqE2IaH7Rj/6l3+2HD118Agk/y+LyzH8z
 iqnCq+7CCIrgq+2ahDuTYGPhqtM7IFyvZLMWvK28i+IE1SGoE0swNcyr1r24xAG+OIgoj0bbtZjzh
 ywVpzLn2K7dzlIknHAa4XZEqWB4mOIXpgcsLAErEOMKfFeAhZMNb+Ihlen2Ny1VnMBelYJgA7QTrL
 VU39cvFCMVNeMFkUiO5qBCsrObXZTVmvIGgTfGonlKc7BjBzCEx2Zk31TuVbIpq0RjwtbwIMilNa1
 ojgnuhLwbNL+LY8rNlhgCMo5CHrLHzXqaa3oUWe+BDvl7ldXsKdR7fcZ5WkOdB2jkU8NLqnyyB94n
 IDmRG6BkNTdfNlE9TnZo5PCNIjMKV5pg4ZfXQyXHeoHSmKvy9cV/RNjIvKj4Rw4bRb0DRiICTTluo
 hYCs0dgBf7cw/Hn4ePk5Z9ihuNOXwstL/uDMZQiKqTfW9BJU8s2SANxQqQkmTOrZPq0k6Bqz/ZI4O
 0s81dFPCEWAUaNN41GEqnmu3UQCew5PO/XfndTvyw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s1iVl-0003yV-0g; Tue, 30 Apr 2024 09:06:53 +0100
Message-ID: <190f1cec-7b91-4bdc-bea7-4ec3dab76e42@ilande.co.uk>
Date: Tue, 30 Apr 2024 09:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-5-richard.henderson@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240302051601.53649-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 04/41] target/sparc: Fix FMUL8x16A{U,L}
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 02/03/2024 05:15, Richard Henderson wrote:

> These instructions have f32 inputs, which changes the decode
> of the register numbers.  While we're fixing things, use a
> common helper for both insns, extracting the 16-bit scalar
> in tcg beforehand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  3 +--
>   target/sparc/translate.c  | 38 ++++++++++++++++++++++++++++++----
>   target/sparc/vis_helper.c | 43 +++++++++------------------------------
>   3 files changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index adc1b87319..9e0b8b463e 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -93,8 +93,7 @@ DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
>   
>   DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
> -DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> -DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
>   DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 5144fe4ed9..598cfcf0ac 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -45,6 +45,7 @@
>   # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
>   # define gen_helper_done(E)                     qemu_build_not_reached()
>   # define gen_helper_flushw(E)                   qemu_build_not_reached()
> +# define gen_helper_fmul8x16a(D, S1, S2)        qemu_build_not_reached()
>   # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
>   # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
>   # define gen_helper_restored(E)                 qemu_build_not_reached()
> @@ -72,8 +73,6 @@
>   # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
> -# define gen_helper_fmul8x16al           ({ qemu_build_not_reached(); NULL; })
> -# define gen_helper_fmul8x16au           ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
> @@ -719,6 +718,18 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
>   #endif
>   }
>   
> +static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    tcg_gen_ext16s_i32(src2, src2);
> +    gen_helper_fmul8x16a(dst, src1, src2);
> +}
> +
> +static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    tcg_gen_sari_i32(src2, src2, 16);
> +    gen_helper_fmul8x16a(dst, src1, src2);
> +}
> +
>   static void finishing_insn(DisasContext *dc)
>   {
>       /*
> @@ -4539,6 +4550,27 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
>   TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
>   TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
>   
> +static bool do_dff(DisasContext *dc, arg_r_r_r *a,
> +                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i32))
> +{
> +    TCGv_i64 dst;
> +    TCGv_i32 src1, src2;
> +
> +    if (gen_trap_ifnofpu(dc)) {
> +        return true;
> +    }
> +
> +    dst = gen_dest_fpr_D(dc, a->rd);
> +    src1 = gen_load_fpr_F(dc, a->rs1);
> +    src2 = gen_load_fpr_F(dc, a->rs2);
> +    func(dst, src1, src2);
> +    gen_store_fpr_D(dc, a->rd, dst);
> +    return advance_pc(dc);
> +}
> +
> +TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
> +TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
> +
>   static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
>                      void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
>   {
> @@ -4576,8 +4608,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
>       return advance_pc(dc);
>   }
>   
> -TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
> -TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
>   TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
>   TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
>   TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
> diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
> index 7728ffe9c6..5c7f5536bc 100644
> --- a/target/sparc/vis_helper.c
> +++ b/target/sparc/vis_helper.c
> @@ -119,43 +119,20 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
>       return d.ll;
>   }
>   
> -uint64_t helper_fmul8x16al(uint64_t src1, uint64_t src2)
> +uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
>   {
> -    VIS64 s, d;
> +    VIS32 s;
> +    VIS64 d;
>       uint32_t tmp;
>   
> -    s.ll = src1;
> -    d.ll = src2;
> +    s.l = src1;
> +    d.ll = 0;
>   
> -#define PMUL(r)                                                 \
> -    tmp = (int32_t)d.VIS_SW64(1) * (int32_t)s.VIS_B64(r);       \
> -    if ((tmp & 0xff) > 0x7f) {                                  \
> -        tmp += 0x100;                                           \
> -    }                                                           \
> -    d.VIS_W64(r) = tmp >> 8;
> -
> -    PMUL(0);
> -    PMUL(1);
> -    PMUL(2);
> -    PMUL(3);
> -#undef PMUL
> -
> -    return d.ll;
> -}
> -
> -uint64_t helper_fmul8x16au(uint64_t src1, uint64_t src2)
> -{
> -    VIS64 s, d;
> -    uint32_t tmp;
> -
> -    s.ll = src1;
> -    d.ll = src2;
> -
> -#define PMUL(r)                                                 \
> -    tmp = (int32_t)d.VIS_SW64(0) * (int32_t)s.VIS_B64(r);       \
> -    if ((tmp & 0xff) > 0x7f) {                                  \
> -        tmp += 0x100;                                           \
> -    }                                                           \
> +#define PMUL(r)                                \
> +    tmp = src2 * (int32_t)s.VIS_B64(r);        \
> +    if ((tmp & 0xff) > 0x7f) {                 \
> +        tmp += 0x100;                          \
> +    }                                          \
>       d.VIS_W64(r) = tmp >> 8;
>   
>       PMUL(0);

Hi Richard,

This patch is showing a couple of issues after a run through the GitLab pipeline:

1) From checkpatch (https://gitlab.com/mcayland/qemu/-/jobs/6743594359#L44):

ERROR: Macros with multiple statements should be enclosed in a do - while loop
total: 2 errors, 0 warnings, 130 lines checked

2) From the s390x runners (https://gitlab.com/mcayland/qemu/-/jobs/6743594301#L4792):

../target/sparc/vis_helper.c: In function ‘helper_fmul8x16a’:
../target/sparc/vis_helper.c:46:21: error: array subscript 7 is above array bounds of 
‘uint8_t[4]’ {aka ‘unsigned char[4]’} [-Werror=array-bounds]
    46 | #define VIS_B64(n) b[7 - (n)]
       |                     ^
../target/sparc/vis_helper.c:133:29: note: in expansion of macro ‘VIS_B64’
   133 |     tmp = src2 * (int32_t)s.VIS_B64(r);        \
       |                             ^~~~~~~
../target/sparc/vis_helper.c:139:5: note: in expansion of macro ‘PMUL’
   139 |     PMUL(0);
       |     ^~~~
../target/sparc/vis_helper.c:71:13: note: while referencing ‘b’
    71 |     uint8_t b[4];
       |             ^
../target/sparc/vis_helper.c:46:21: error: array subscript 6 is above array bounds of 
‘uint8_t[4]’ {aka ‘unsigned char[4]’} [-Werror=array-bounds]
    46 | #define VIS_B64(n) b[7 - (n)]
       |                     ^
../target/sparc/vis_helper.c:133:29: note: in expansion of macro ‘VIS_B64’
   133 |     tmp = src2 * (int32_t)s.VIS_B64(r);        \
       |                             ^~~~~~~
../target/sparc/vis_helper.c:140:5: note: in expansion of macro ‘PMUL’
   140 |     PMUL(1);
       |     ^~~~
../target/sparc/vis_helper.c:71:13: note: while referencing ‘b’
    71 |     uint8_t b[4];
       |             ^
../target/sparc/vis_helper.c:46:21: error: array subscript 5 is above array bounds of 
‘uint8_t[4]’ {aka ‘unsigned char[4]’} [-Werror=array-bounds]
    46 | #define VIS_B64(n) b[7 - (n)]
       |                     ^
../target/sparc/vis_helper.c:133:29: note: in expansion of macro ‘VIS_B64’
   133 |     tmp = src2 * (int32_t)s.VIS_B64(r);        \
       |                             ^~~~~~~
../target/sparc/vis_helper.c:141:5: note: in expansion of macro ‘PMUL’
   141 |     PMUL(2);
       |     ^~~~
../target/sparc/vis_helper.c:71:13: note: while referencing ‘b’
    71 |     uint8_t b[4];
       |             ^
../target/sparc/vis_helper.c:46:21: error: array subscript 4 is above array bounds of 
‘uint8_t[4]’ {aka ‘unsigned char[4]’} [-Werror=array-bounds]
    46 | #define VIS_B64(n) b[7 - (n)]
       |                     ^
../target/sparc/vis_helper.c:133:29: note: in expansion of macro ‘VIS_B64’
   133 |     tmp = src2 * (int32_t)s.VIS_B64(r);        \
       |                             ^~~~~~~
../target/sparc/vis_helper.c:142:5: note: in expansion of macro ‘PMUL’
   142 |     PMUL(3);
       |     ^~~~
../target/sparc/vis_helper.c:71:13: note: while referencing ‘b’
    71 |     uint8_t b[4];
       |             ^
cc1: all warnings being treated as errors
[4028/5573] Compiling C object libqemu-sparc64-softmmu.fa.p/trace_control-target.c.o
[4029/5573] Compiling C object libqemu-sparc64-softmmu.fa.p/target_sparc_translate.c.o
ninja: build stopped: subcommand failed.
make: *** [Makefile:167: run-ninja] Error 1


ATB,

Mark.


