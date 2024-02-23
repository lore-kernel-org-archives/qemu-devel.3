Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D7DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUHQ-0004YL-WB; Fri, 23 Feb 2024 07:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdUHP-0004Y0-3b
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:03:51 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdUHN-000379-39
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:03:50 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mkn8B-1rChu31Ll1-00mILl; Fri, 23 Feb 2024 13:03:44 +0100
Message-ID: <6ee33d49-4add-4354-964e-788ba6c9a13d@vivier.eu>
Date: Fri, 23 Feb 2024 13:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Fix exception frame format for 68010
Content-Language: fr
To: Daniel Palmer <daniel@0x0f.com>
Cc: qemu-devel@nongnu.org
References: <20240115101643.2165387-1-daniel@0x0f.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20240115101643.2165387-1-daniel@0x0f.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SIPbm9CWv79bNyg4y838DcNo53BcOPBbRMJZ/YnUIFDtcC20E1b
 sIdLByAuMEbmYJW4pjPnuI2nYBGZOerH0Gfach3dX9F/Gn1ZzO4+8xcf9kHMM1XLEieyIBd
 Q28/RaS4EzGM0ut7AeyZ3bi0n9Rzx3rPZbLsj/ioCcYxxuYH3ysSNdcjF1vV/kMJhBeIhVw
 tQaX+QoTkWirKtqCZ00yw==
UI-OutboundReport: notjunk:1;M01:P0:rAusvNAoNNk=;VAe5+tScgam9YcZkByaIWzB6KHK
 7G7UL4qq2P9ZgSl5FsDBNechqnPYe21odRI7y2gy5cv1WIGUb+ldM1tzR9gYfToSvn3SaOaVX
 rm/4oGBMZ8qrLdLreMoJW5AisZblyO6ftm43UoIO0y72vE1awGVN80olYdtJpjQA47KZtz8ly
 FJEJxCgM7FS98arzk9siYlkI99VUrkxW8X1pkQEVtKqEyJRvTvnICIR98w2pIID+1m2Tsw0Y0
 qQaPyLPI8bc9cl1KqZgABAXxk5+l8b3QCuPjTt/0L27poKsY4y5OHtdA5Y2n/5Eew/iZ3QLbC
 qu9VG4jIa9sBDVzeedPrBg5wLIiPLjTORy5kyBozQhMEQdC0YpvofrBs0IfwYhYMg4Os1jomA
 qMvSsB7IK6pavR4R3YgN8uKURcJa3xhfz5+EPTeIurFHWM1U9sugFUhP22NSJSb/4uJ1BsPsZ
 n4mDzBTH6PKNmUDE3zacOUEWIqfTHWqnnfmC+HP4PQyLKdocqDFaSfzjbhA+x5dLbC5p/SKtp
 HpBFOes41VfGP4H5xpx8EZ6aJEM3PWG1BwlQygHQAs1QUBLRcPl+iVQ0jDBGoKg7dFWE7TCgL
 hFgfiUZ8KWZRAR4dEL3vRS39Rtrfk53iPacoPrRbHP4G4JohczkRV/UJHNMPdYiPADtZytPyt
 OGuJ04fm0cXmhE+c5xoBZ7VfG2ZduU24Fjf0eNcg+4ZPm1/hGniEJYdVOSrmwDZczItNH6KnU
 GhiHvbnglWBdU9Nk50K0FDTb7MTL1Q+JpksdFhU/RjTvqAt6CKzZPw=
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 15/01/2024 à 11:16, Daniel Palmer a écrit :
>  From the 68010 a word with the frame format and exception vector
> are placed on the stack before the PC and SR.
> 
> M68K_FEATURE_QUAD_MULDIV is currently checked to workout if to do
> this or not for the configured CPU but that flag isn't set for
> 68010 so currently the exception stack when 68010 is configured
> is incorrect.
> 
> It seems like checking M68K_FEATURE_MOVEFROMSR_PRIV would do but
> adding a new flag that shows exactly what is going on here is
> maybe clearer.
> 
> Add a new flag for the behaviour, M68K_FEATURE_EXCEPTION_FORMAT_VEC,
> and set it for 68010 and above, and then use it to control if the
> format and vector word are pushed/pop during exception entry/exit.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   target/m68k/cpu.c       | 4 +++-
>   target/m68k/cpu.h       | 2 ++
>   target/m68k/op_helper.c | 4 ++--
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 1421e77c2c07..20718944b4c8 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -137,7 +137,8 @@ static void m68000_cpu_initfn(Object *obj)
>   }
>   
>   /*
> - * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
> + * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD,
> + *      format+vector in exception frame.
>    */
>   static void m68010_cpu_initfn(Object *obj)
>   {
> @@ -150,6 +151,7 @@ static void m68010_cpu_initfn(Object *obj)
>       m68k_set_feature(env, M68K_FEATURE_BKPT);
>       m68k_set_feature(env, M68K_FEATURE_MOVEC);
>       m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
> +    m68k_set_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC);
>   }
>   
>   /*
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index d13427b0fe61..0fc591e618f6 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -549,6 +549,8 @@ enum m68k_features {
>       M68K_FEATURE_TRAPCC,
>       /* MOVE from SR privileged (from 68010) */
>       M68K_FEATURE_MOVEFROMSR_PRIV,
> +    /* Exception frame with format+vector (from 68010) */
> +    M68K_FEATURE_EXCEPTION_FORMAT_VEC,
>   };
>   
>   static inline bool m68k_feature(CPUM68KState *env, int feature)
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 1ce850bbc594..b09771672dec 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -52,7 +52,7 @@ throwaway:
>       sp += 2;
>       env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>       sp += 4;
> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>           /*  all except 68000 */
>           fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>           sp += 2;
> @@ -256,7 +256,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
>                                     uint16_t format, uint16_t sr,
>                                     uint32_t addr, uint32_t retaddr)
>   {
> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>           /*  all except 68000 */
>           CPUState *cs = env_cpu(env);
>           switch (format) {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

