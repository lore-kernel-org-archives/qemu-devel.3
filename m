Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1AC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSEZ-0004v1-4I; Fri, 21 Aug 2026 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wxSEW-0004qu-H4; Fri, 21 Aug 2026 12:36:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wxSEU-0007WT-E4; Fri, 21 Aug 2026 12:36:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LG1lJg1906972; Fri, 21 Aug 2026 16:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=//a5e4Icf+TDnJVxRYRQOC+2Yh7V+W4zOybV0KRLJvg=; b=ZXD1T4cJgCBt
 H9Dl/yjlhqTPUQ3oBKcrAdLMhnRS2uW1EWetqpbzveuXW6c77YbgPWNo9t2LowEg
 HPCztfTmFVCfwt+w4TJKWJh9qYJ49n07xQEfrq2ncAv8Q3DU6NU+y6Ous0kL5uTu
 zO1c9htRxlQFvKGTM9Pt/HuXhkHrhYO5P6tY/f9RPFhpYTGcmyZAQNwpAwGmS+nM
 GWzDwVS5F9DwaFAhcPXwu/gakR4WjUOTBVNZMmfBki3GRfC25fYClseerFKx0rP7
 yJHZHgw0WxgyoflyYnbhxuWgpTaadt1gP9TXNnMtd54BE+qKjMPsOWRIPrzz2r/9
 RTOgFRuybA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4jn6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 16:36:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LGQH9L002938;
 Fri, 21 Aug 2026 16:36:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngwfsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 16:36:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LGabIG28574226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 16:36:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B98AF5805F;
 Fri, 21 Aug 2026 16:36:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DDE45805D;
 Fri, 21 Aug 2026 16:36:37 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 16:36:37 +0000 (GMT)
Message-ID: <0652cff525cfb620198b1705ddbcb9c639faedf0.camel@linux.ibm.com>
Subject: Re: [PATCH 19/29] target/ppc: Refactor sleep and its variants to
 use a common helper
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: ojaswin@linux.ibm.com
Date: Fri, 21 Aug 2026 11:36:31 -0500
In-Reply-To: <2a98f24f-0af7-4778-a8f1-f813bc48139e@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-20-rathc@linux.ibm.com>
 <3fea696f5ee62656ecca7aa72118da1d458a6018.camel@linux.ibm.com>
 <2a98f24f-0af7-4778-a8f1-f813bc48139e@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfXy3G6Q9QD0v9D
 wMCxL0UIRFUAxhPufSCR16ArAIBPwgEFvyGOoiNVNtj/ZxDnqvadYxGp8IBcxwAAQO+qUvoPHlG
 dFpEIKFI0XvrzzhCn2IB6qs0thChe8s=
X-Proofpoint-GUID: Q9NN7KIa6mJsT0iZqNws5wuSKia5Mhl5
X-Proofpoint-ORIG-GUID: Q9NN7KIa6mJsT0iZqNws5wuSKia5Mhl5
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a887e97 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=YUEbG25dech8SPtm_1IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfXzq6K1p3iU0Mr
 N2uOqKlrk/mKaxr1sKMXl2koGqo5GbGIeOvs0B5hz5/rg4wzcaTS9a+HmGIbmxveryQP5RipPT1
 phLw623Zgjw5Q5iFPIelgltYCp0GR+uFcQ1NInM6WsDrOCvJd+zDwIYhyiypvq2FJQXWmHEObhe
 0p89l7M5VzhV5muRUaBm1hxF4svs9yopSkOUbfhxlHB3t2ByjwnHlapTKPD/LSn4O1RxGpNWJKw
 ILiO2CUKbdMGP/DmSiQHZHwVn4Sjsqmn8y+gk9edVnP++Jix6ezfMx9j8tYzQWXhjlue9IrFIuc
 x4ZWkozcCPPbTGNJUvSS031dSYjv3mid75IcpFkvnhHYhUm2xFeaFx9FVAndO4mQYV+C1HEk24P
 IVB6jNhFgObdlb7ZxE6ebC6pZJINu3NyFclWzjCIko0+jH/odCr8wgyEw8w6fB7LPE1zAqLp2Zl
 pOfvMaqwicERgZ5W4Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Chinmay,

I was only suggesting that it might be good to add a comment to the
commit message stating that this commit was preparatory to moving the
sleep instructions to decodetree.  No need to squash them.

On Fri, 2026-08-21 at 12:57 +0530, Chinmay Rath wrote:
> On 8/20/26 20:45, Miles Glenn wrote:
> > Chinmay,
> > 
> > This commit seems out of the scope of moving instructions to
> > decodetree.  Was this change necessary in order to move the
> > instructions to decodetree?  If so, it would be helpful to add that to
> > the commit message.  Otherwise, I would submit this separately from the
> > decodetree commits.
> Hi Glenn,
> 
> It is common practice to merge helper functions in helper files and/or 
> translation functions in the translate.c or translate directory files 
> during instruction movement to decodetree, if they have common logic.
> Speaking of which, ideally this commit should have been squashed along 
> with the previous commit where those insns were actually moved. The 
> author of the patch has instead created two separate patches. Though it 
> is not technically wrong, since neither of the patch are incomplete 
> functionally, let me know if you think this should be squashed with the 
> previous commit, will do that.
> 
> PS: Please feel free to review other patches as well. It would be of 
> great help :)
> 
> Regards,
> Chinmay

Hi Chinmay,

I was only suggesting that it might be good to add a comment to the
commit message stating that this commit was preparatory to moving the
sleep instructions to decodetree.  No need to squash the two commits.

Thanks,

Glenn

> > Thanks,
> > 
> > Glenn
> > 
> > On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> > > From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > 
> > > Refactor sleep, doze, nap, rvwinkle and stop to use a common helper
> > > since they share majority of the code. Also refactor gen_hlper_pminsn()
> > > to gen_helper_PMINSN()
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> > > ---
> > >   target/ppc/helper.h                           |  2 +-
> > >   target/ppc/tcg-excp_helper.c                  |  2 +-
> > >   .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
> > >   3 files changed, 16 insertions(+), 87 deletions(-)
> > > 
> > > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > > index cd2a0948a3..7e15676122 100644
> > > --- a/target/ppc/helper.h
> > > +++ b/target/ppc/helper.h
> > > @@ -18,7 +18,7 @@ DEF_HELPER_1(rfdi, void, env)
> > >   DEF_HELPER_1(rfmci, void, env)
> > >   #if defined(TARGET_PPC64)
> > >   DEF_HELPER_2(scv, noreturn, env, i32)
> > > -DEF_HELPER_2(pminsn, void, env, i32)
> > > +DEF_HELPER_2(PMINSN, void, env, i32)
> > >   DEF_HELPER_1(rfid, void, env)
> > >   DEF_HELPER_1(rfscv, void, env)
> > >   DEF_HELPER_1(hrfid, void, env)
> > > diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> > > index b04f07a637..c4ffa2dfbb 100644
> > > --- a/target/ppc/tcg-excp_helper.c
> > > +++ b/target/ppc/tcg-excp_helper.c
> > > @@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
> > >       }
> > >   }
> > >   
> > > -void helper_pminsn(CPUPPCState *env, uint32_t insn)
> > > +void helper_PMINSN(CPUPPCState *env, uint32_t insn)
> > >   {
> > >       CPUState *cs = env_cpu(env);
> > >   
> > > diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
> > > index bdbc195294..3b3ed3019a 100644
> > > --- a/target/ppc/translate/processor-ctrl-impl.c.inc
> > > +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
> > > @@ -104,103 +104,32 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
> > >       return true;
> > >   }
> > >   
> > > -static bool do_doze(DisasContext *ctx, arg_DOZE *a)
> > > -{
> > > -    REQUIRE_64BIT(ctx);
> > > -
> > > -#if defined(CONFIG_USER_ONLY)
> > > -    gen_priv_opc(ctx);
> > > -#else
> > > -    TCGv_i32 t;
> > > -
> > > -    REQUIRE_HV(ctx);
> > > -    translator_io_start(&ctx->base);
> > > -    t = tcg_constant_i32(PPC_PM_DOZE);
> > > -    gen_helper_pminsn(tcg_env, t);
> > > -    /* Stop translation, as the CPU is supposed to sleep from now */
> > > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > -#endif /* defined(CONFIG_USER_ONLY) */
> > > -
> > > -    return true;
> > > -}
> > > -TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
> > > -
> > > -static bool do_nap(DisasContext *ctx, arg_NAP *a)
> > > -{
> > > -    REQUIRE_64BIT(ctx);
> > > -
> > > -#if defined(CONFIG_USER_ONLY)
> > > -    gen_priv_opc(ctx);
> > > -#else
> > > -    TCGv_i32 t;
> > > -
> > > -    REQUIRE_HV(ctx);
> > > -    translator_io_start(&ctx->base);
> > > -    t = tcg_constant_i32(PPC_PM_NAP);
> > > -    gen_helper_pminsn(tcg_env, t);
> > > -    /* Stop translation, as the CPU is supposed to sleep from now */
> > > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > -#endif /* defined(CONFIG_USER_ONLY) */
> > > -    return true;
> > > -}
> > > -TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
> > > -
> > > -static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
> > > -{
> > > -    REQUIRE_64BIT(ctx);
> > > -
> > > -#if defined(CONFIG_USER_ONLY)
> > > -    gen_priv_opc(ctx);
> > > -#else
> > > -    TCGv_i32 t;
> > > -
> > > -    REQUIRE_HV(ctx);
> > > -    translator_io_start(&ctx->base);
> > > -    t = tcg_constant_i32(PPC_PM_SLEEP);
> > > -    gen_helper_pminsn(tcg_env, t);
> > > -    /* Stop translation, as the CPU is supposed to sleep from now */
> > > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > -#endif /* defined(CONFIG_USER_ONLY) */
> > > -    return true;
> > > -}
> > > -TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
> > > -
> > > -static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
> > > +/*
> > > + * Helper to handle DOZE, NAP, SLEEP, RVWINKLE & STOP. Since none of them use
> > > + * any arguments just use a placeholder arg_SLEEP.
> > > + */
> > > +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a, powerpc_pm_insn_t type)
> > >   {
> > >       REQUIRE_64BIT(ctx);
> > >   
> > >   #if defined(CONFIG_USER_ONLY)
> > >       gen_priv_opc(ctx);
> > > -#else
> > > +#elif defined(TARGET_PPC64)
> > >       TCGv_i32 t;
> > >   
> > >       REQUIRE_HV(ctx);
> > >       translator_io_start(&ctx->base);
> > > -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
> > > -    gen_helper_pminsn(tcg_env, t);
> > > +    t = tcg_constant_i32(type);
> > > +    gen_helper_PMINSN(tcg_env, t);
> > >       /* Stop translation, as the CPU is supposed to sleep from now */
> > >       gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > -#endif /* defined(CONFIG_USER_ONLY) */
> > > -    return true;
> > > -}
> > > -TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
> > > -
> > > -static bool do_stop(DisasContext *ctx, arg_STOP *a)
> > > -{
> > > -    REQUIRE_64BIT(ctx);
> > > -
> > > -#if defined(CONFIG_USER_ONLY)
> > > -    gen_priv_opc(ctx);
> > >   #else
> > > -    TCGv_i32 t;
> > > -
> > > -    REQUIRE_HV(ctx);
> > > -    translator_io_start(&ctx->base);
> > > -    t = tcg_constant_i32(PPC_PM_STOP);
> > > -    gen_helper_pminsn(tcg_env, t);
> > > -    /* Stop translation, as the CPU is supposed to sleep from now */
> > > -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> > > +    qemu_build_not_reached();
> > >   #endif
> > >       return true;
> > >   }
> > > -TRANS_FLAGS2(ISA300, STOP, do_stop);
> > > +TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
> > > +TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
> > > +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
> > > +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
> > > +TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);


