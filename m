Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A56CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyyq-0005r7-6f; Wed, 17 Sep 2025 16:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyyf-0005pg-1w
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:42:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyyb-0006Nb-1a
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6draQuF5eXrettDLp3Y0de9Z0wWAnYCEz1aBKQL5udU=; b=INzbCAE1vxgNkB2bHnQsBn8TNU
 zPILgDzOnIqn0QqzKoUnQKQeKHCn/oitHLq+xl7Z68eO9NPnB6/iJYAmAqoPN8ZTuHFG5ayWAremN
 BpnIXyGnAu4Z2F6tApRWnzQLnFufjWSRaGOIoNW5ouRHgYcup6ciLwz7KM+WulebAQyVqZJTRorZ+
 yn/LQuh9RX7A3CL1rtY/+Fcj++N2Eh4s37EuQbkXrBb1kOJehW+CH2H9hTKbXL+C1Ho9YMSlCWPCy
 DgTozcRCvpnl4NqjiKMZnWWxU2nx6pUeNdwb9z840tAGuhQuhFprmM0L2TT52G7DK2I15o+BSZ8MU
 m+fvuzwQFpno/9NDdg83jFckypbosLIs8rdNpImQ/zhScdaaxl0W6dQdHnG6+S/Xjel81Rusga4kx
 XBoH6w+8oJzylvHrU4Cd57UePtrPz7t63zNQSC5T//oDDgU6RjGEIIXJdTmYSqtTglXppbCQ3+pzj
 IO7fiwwGMpxJzbkXfxTEtucLr9tDR8PSQilrfY1x8qF3SwMGzId1Q2eaELO+3Y/SIqUjiInBmRkRL
 FIBz05FKPoOSc0Phxj647ybDLyWYwD7vK5PEglBZy7Asw6NykPGmzEfEWhnncR3pt++Zx/+Yv0zQz
 REiacRTAhDDTvmcNcl0eWUUa1YiXuUN8KCNRstvkQ=;
Received: from [2a02:8012:2f01:0:ff11:26c7:ce3f:b269]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyywZ-000ATa-ND; Wed, 17 Sep 2025 21:40:00 +0100
Message-ID: <7b88d9fd-ba71-47be-b8c7-cc325e179dac@ilande.co.uk>
Date: Wed, 17 Sep 2025 21:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <20250905115128.376295-8-richard.henderson@linaro.org>
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
In-Reply-To: <20250905115128.376295-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:ff11:26c7:ce3f:b269
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 7/7] target/sparc: Relax decode of rs2_or_imm for v7
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

On 05/09/2025 12:51, Richard Henderson wrote:

> For v7, bits [13:5] are ignored for !imm.

Should that be [12:5] here?

> For v8, those same bits are reserved, but are not trapped.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 56 ++++++++++++++++++++++++++--------------
>   1 file changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index cfdd9c1ce4..810e2491a6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2526,6 +2526,32 @@ static int extract_qfpreg(DisasContext *dc, int x)
>   # define avail_VIS4(C)    false
>   #endif
>   
> +/*
> + * We decoded bit 13 as imm, and bits [12:0] as rs2_or_imm.
> + * For v9, if !imm, then the unused bits [12:5] must be zero.
> + * For v7 and v8, the unused bits are ignored; clear them here.
> + */
> +static bool check_rs2(DisasContext *dc, int *rs2)
> +{
> +    if (unlikely(*rs2 & ~0x1f)) {
> +        if (avail_64(dc)) {
> +            return false;
> +        }
> +        *rs2 &= 0x1f;
> +    }
> +    return true;
> +}
> +
> +static bool check_r_r_ri(DisasContext *dc, arg_r_r_ri *a)
> +{
> +    return a->imm || check_rs2(dc, &a->rs2_or_imm);
> +}
> +
> +static bool check_r_r_ri_cc(DisasContext *dc, arg_r_r_ri_cc *a)
> +{
> +    return a->imm || check_rs2(dc, &a->rs2_or_imm);
> +}
> +
>   /* Default case for non jump instructions. */
>   static bool advance_pc(DisasContext *dc)
>   {
> @@ -3249,8 +3275,7 @@ static bool do_wr_special(DisasContext *dc, arg_r_r_ri *a, bool priv,
>   {
>       TCGv src;
>   
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
> +    if (!check_r_r_ri(dc, a)) {
>           return false;
>       }
>       if (!priv) {
> @@ -3693,8 +3718,7 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a,
>   {
>       TCGv dst, src1;
>   
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && a->rs2_or_imm & ~0x1f) {
> +    if (!check_r_r_ri_cc(dc, a)) {
>           return false;
>       }
>   
> @@ -3778,11 +3802,11 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
>   {
>       /* OR with %g0 is the canonical alias for MOV. */
>       if (!a->cc && a->rs1 == 0) {
> +        if (!check_r_r_ri_cc(dc, a)) {
> +            return false;
> +        }
>           if (a->imm || a->rs2_or_imm == 0) {
>               gen_store_gpr(dc, a->rd, tcg_constant_tl(a->rs2_or_imm));
> -        } else if (a->rs2_or_imm & ~0x1f) {
> -            /* For simplicity, we under-decoded the rs2 form. */
> -            return false;
>           } else {
>               gen_store_gpr(dc, a->rd, cpu_regs[a->rs2_or_imm]);
>           }
> @@ -3799,8 +3823,7 @@ static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
>       if (!avail_DIV(dc)) {
>           return false;
>       }
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && a->rs2_or_imm & ~0x1f) {
> +    if (!check_r_r_ri(dc, a)) {
>           return false;
>       }
>   
> @@ -3851,8 +3874,7 @@ static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
>       if (!avail_64(dc)) {
>           return false;
>       }
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && a->rs2_or_imm & ~0x1f) {
> +    if (!check_r_r_ri(dc, a)) {
>           return false;
>       }
>   
> @@ -3889,8 +3911,7 @@ static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
>       if (!avail_64(dc)) {
>           return false;
>       }
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && a->rs2_or_imm & ~0x1f) {
> +    if (!check_r_r_ri(dc, a)) {
>           return false;
>       }
>   
> @@ -4186,8 +4207,7 @@ TRANS(SRA_i, ALL, do_shift_i, a, false, false)
>   
>   static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
>   {
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!imm && rs2_or_imm & ~0x1f) {
> +    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
>           return NULL;
>       }
>       if (imm || rs2_or_imm == 0) {
> @@ -4250,8 +4270,7 @@ static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
>   {
>       TCGv src1, sum;
>   
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!a->imm && a->rs2_or_imm & ~0x1f) {
> +    if (!check_r_r_ri(dc, a)) {
>           return false;
>       }
>   
> @@ -4369,8 +4388,7 @@ static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
>   {
>       TCGv addr, tmp = NULL;
>   
> -    /* For simplicity, we under-decoded the rs2 form. */
> -    if (!imm && rs2_or_imm & ~0x1f) {
> +    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
>           return NULL;
>       }

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


