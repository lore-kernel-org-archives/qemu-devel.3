Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670D606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VEHftplq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=im6pVnS/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0SQ-0002jq-18; Wed, 11 Nov 2026 00:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR0SI-0002jA-JS
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 00:01:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR0SF-0004Ty-Sk
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 00:01:06 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB29951450394
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VsDojqlaGUGP0ADTIRvRgz6D
 V6E0iLeb7a5pCNvtQmk=; b=VEHftplqjMpd2BxYQBPaeQL3ML/Wkn3fNnJPgP18
 WOE0BDaI2KIfr9HZrgQfY+xo/VZVBo5A56OxUkKRmL85wn0gQoknfh/+aDuWwgys
 JISJoZvmpCYoNOqvQdSlqLGnXc/QzCBzOcMxTGYXxzDm9/o5iCT05FfQPMD/y98N
 bVe4nkzix3g9koCThBxL3pOQEcY7JibZzQlzIhxXMuGQwKfai2LDMzws7CzPb6Ia
 A5UGeEOshKMkQIDJAZ1grEZ0wIYwIFgbmiHgot1PmQCMf+uMeXclwphk4FQYQWsF
 jCDvrjE1iVmVj9HLV5pIBMtcFfknttDsoFBSfk6zJtxG8A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawggxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:00:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5627810eec.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794373259; x=1794978059; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VsDojqlaGUGP0ADTIRvRgz6DV6E0iLeb7a5pCNvtQmk=;
 b=im6pVnS/QBaVvGJ4+imttSQjoDJCKP2XolltJ+G70Dji0Uudq/PUEXETYtmigVWZuw
 eNwD046ScEXWvKziULEm7P+34cmR8AXS8MkrvAkPREe0EBdMu5fpkBpOENLlVlF27Qre
 yuIKkm7fD7gbzvjPOTfvjiSlmicWCA+3u0OMsaomfKUBYCQu5zAdZhNaQ7Jnw4wg+fVT
 cvqf5GzeUN6O3IQYWOBKYC3pqc09fvUZDtyg281db44rtWHbiU9aqNWwt5flKkXwtNSN
 ljJbW0CfVnyey4bNfhGtXltvY92CNjQ6CuyWRgiGR8EcE8vNzeFBBIXP76fa5xeAcyAP
 v4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794373259; x=1794978059;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VsDojqlaGUGP0ADTIRvRgz6DV6E0iLeb7a5pCNvtQmk=;
 b=mcrFcgCguS+a0T2S5CBM2oKqb4f1jw3HGYxEjGVRuNtLku7NxRjTMGW4AA+6uhXcrh
 rmYET+g9KIQBeqA9Og+lj1fy+dFJPs/tyiXmZk1+OkQp/QY5XUYGN/h4SGVgZjRuGRvp
 7WhtsZuwXlw/Kb7UR8S8IGjruNiRJeNwINegZepix7pljnejjpZuvhvtqj0/Do7XDPpH
 Fj4hS8G+TIdo/hE/FsFfxZWkul4nVPA8ARwxzfZFm3JTpRt1zmlGMX5kolG2UeivO44f
 GSuywU1pp4DHis4Khbr/+7SUSmVzOsTuMBRNHGBDQCrUfj8H1vwfd/Sco/DJj6tfPjGP
 vJVQ==
X-Gm-Message-State: APuU4Z+3cqBP+26u7jfK97j1iHtMMzLQPxfzS+WHMfqtYecG6rUnHXnO
 RsKZm1bJy4qH60TWwh3xTxAGck7zOIUl5AoQb6ccqWaHx5IvZnvdW9JyKNHPSlsbmeydRDhg+9W
 IZVa8cdxkALjLJzIIXJrRxfVwuRgV0+7mFT92MDmx9sJ7XMha+agPdnfj6w==
X-Gm-Gg: AYBFou1JlLZSlZ3uFo4AnR7Ao5PInDZcBn/8tCW+k4sRPrglxm3lVzogemDKGWJWAO9
 GBMuEQFnxLOtT/xA8my3QbxMC4j/gpZNzz6bTBF5B15i9+ZiBEBmRFvHdU85DkJb8yNywNHNpxU
 XEdviIpQ1DiAGGpk14d+VGdPHn8Obsk0goXEJXWNXkXR/mndKhlU66jSYup6jSQF/ju8bCf51jR
 h3up1Iac6RocPr6OVuliVlhiQg7aY5C33bkRFthX0JnuLdtexJVIANVU4oMoVIZAoWMbg/aO0WE
 8Da3xvsr6xPOzxoynnMZp5uxZWQIFyEObLBBM4+aO618E6eKySFxlqodkmrSsyLBw7ZhoHaBQJ1
 6SVbNzJ0TQwT28mmiRiQDqIhCGZ0PCou8pqNdr6NDwq6ypSc/Cu3Y6wpjMkgKyrkSsWZzhKDfVl
 85Y3bevArGfXeZG/pVexJzYsLTkrU0L3QdJG64bXtwssyv2vBsxqZ1NLltu0+sKxxIJ/kMJ+Jr
X-Received: by 2002:a05:7301:795:b0:36e:e349:f2cb with SMTP id
 5a478bee46e88-3768579dfa3mr1907102eec.19.1794373258959; 
 Tue, 10 Nov 2026 21:00:58 -0800 (PST)
X-Received: by 2002:a05:7301:795:b0:36e:e349:f2cb with SMTP id
 5a478bee46e88-3768579dfa3mr1907058eec.19.1794373258181; 
 Tue, 10 Nov 2026 21:00:58 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm13005741eec.25.2026.11.10.21.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 21:00:57 -0800 (PST)
Date: Wed, 11 Nov 2026 10:30:52 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] target/riscv: Fix icount trigger exception PC
Message-ID: <avP2hBUx3pydweyB@hu-himchau-blr.qualcomm.com>
References: <20261108110107.1752051-1-himanshu.chauhan@oss.qualcomm.com>
 <d76ec165-fb11-4e63-8e20-a8ee5062701d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76ec165-fb11-4e63-8e20-a8ee5062701d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxOSBTYWx0ZWRfX5X50BGiOYlAQ
 Ut1If8nUYfG6ZeT1UjhGhXCgP0HzDF8bLrWj7cuYpdTNna+vYpaLctIMWL6sSbJQqoIzCOv4NE/
 VY8Ow5HMkVhVC+a5VsBxkpB+yFLKC8M=
X-Proofpoint-ORIG-GUID: KPZGDevsKBZKNNy6oL2Xua4cuWUQkP81
X-Proofpoint-GUID: KPZGDevsKBZKNNy6oL2Xua4cuWUQkP81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxOSBTYWx0ZWRfX/hJA61VsA+G7
 aAcOi4aTt5bFOTQnOiVc6Vi+bwJWCNh1Ur6qEMczNOc5kz7Mkd1QPGZnTOjKYrJEVPufZApgCar
 /+VC9W2Afw8Twjf0iQc4WwhfqhG8HJFczS9/iIyOS6GLR7dugbn4qU/e0Pd2zpw5/9C7in0WLhE
 Uc/FI2IBbnpYhv+9Kvc/PKN8rFbrtnGvPeE9u7lmmI4T1wml8x9GODxiRAEf7jiIjCHADRgBhaT
 hUq0V6w3Sw1jzFER8Gexz/PWjQEuaJEVHjVB9nfof9dFemZaP/VkzsgirvwNZEyb9Ft+FW9f03Q
 su3t8rTyE6ybQ8FDFUQojOuX0esvqudU35+VRLo6hfjcGqaP3n4if/j7M4oEV9Z7CiWzOt4IMTh
 lqUeVGZDlVRrJR4DIpZ83qkTMzM1dcLj++tIVmzXc6OiMepW7Gg/hnuVtvsl5KQORGGjb+oCHjF
 Ldiex6R6TgtNA7eZAcg==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af3f68b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_SDNzCGYTCzR-oxaiGgA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 04:11:57PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/8/2026 8:01 AM, Himanshu Chauhan wrote:
> > Per the Sdtrig specification, on a breakpoint exception with icount, the
> > xepc must contain the virtual address of the next instruction that must
> > be executed to preserve the program flow.
> > 
> > Since SBI DBTR exposes these trigger encodings to supervisor software, an
> > icount trigger used as a one-instruction step must fire only after the
> > counted instruction retires and the architectural successor PC is known,
> > which for a taken branch is the branch target, not the trigger install
> > address or fallthrough.
> > 
> > QEMU previously disabled the translated-block trigger flag when icount was
> > enabled and relied on timer and privilege-change callbacks to update the
> > count, so the trigger could fire outside instruction retirement before the
> > guest PC advanced, causing Linux to observe the old PC and re-enter the same
> > breakpoint while single-stepping with icount.
> > 
> > Fix this by
> >    - publishing the icount trigger flag in translated blocks even with
> >      icount enabled
> >    - making the helper decrement the trigger count after the
> >      instruction has committed its successor PC and raise the trigger
> >      action only then
> >    - privilege-change callbacks refresh cached enabled state because itriggers
> >      tied to privilege mode.
> > 
> > Also make trigger data CSR availability depend on an implemented trigger slot
> > rather than the currently selected trigger type, so software can disable a
> > trigger with type zero and still write the rest of the slot state before
> > selecting another supported type.
> > 
> > itrigger timers are completely removed as they are not required now.
> > 
> > Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> > ---
> 
> 
> LGTM.  I took a look at other instances of itrigger_enabled and seems like we're
> missing one instance in this patch:
> 
> target/riscv/machine.c, debug_post_load():
> 
>      RISCVCPU *cpu = opaque;
>      CPURISCVState *env = &cpu->env;
> 
>     if (icount_enabled()) {
>         env->itrigger_enabled = riscv_itrigger_enabled(env);
>     }
>

Hi Daniel,

Thanks for looking at it and pointing this out. I will send a revision
which fixes this and the sashiko reports.

Regards
Himanshu

> 
> Since itrigger_enabled is no longer reliant on icount_enabled() we need to
> remove the icount_enabled() from machine.c too.
> 
> 
> Thanks,
> Daniel
> 
> >   target/riscv/cpu.h            |   5 +-
> >   target/riscv/tcg/cpu_helper.c |  10 +-
> >   target/riscv/tcg/debug.c      | 169 ++++++++++------------------------
> >   target/riscv/tcg/tcg-cpu.c    |   7 +-
> >   4 files changed, 59 insertions(+), 132 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 49a1186bdb..3109d71470 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -484,8 +484,7 @@ struct CPUArchState {
> >       uint8_t trigger_cur;
> >       /*
> >        * num_triggers is the length of tdata1, tdata2, tdata3,
> > -     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
> > -     * arrays.
> > +     * cpu_breakpoint and cpu_watchpoint arrays.
> >        */
> >       uint32_t num_triggers;
> >       uint64_t *tdata1;
> > @@ -493,8 +492,6 @@ struct CPUArchState {
> >       uint64_t *tdata3;
> >       struct CPUBreakpoint **cpu_breakpoint;
> >       struct CPUWatchpoint **cpu_watchpoint;
> > -    QEMUTimer **itrigger_timer;
> > -    int64_t last_icount;
> >       bool itrigger_enabled;
> >       /* machine specific rdtime callback */
> > diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> > index 58e98e975c..0375b930be 100644
> > --- a/target/riscv/tcg/cpu_helper.c
> > +++ b/target/riscv/tcg/cpu_helper.c
> > @@ -940,10 +940,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
> >       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
> >       if (newpriv != env->priv || env->virt_enabled != virt_en) {
> > -        if (icount_enabled()) {
> > -            riscv_itrigger_update_priv(env);
> > -        }
> > -
> >           riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
> >       }
> > @@ -982,6 +978,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
> >               riscv_cpu_interrupt(env);
> >           }
> >       }
> > +
> > +    /*
> > +     * Icount triggers are scoped by U/S/M and VU/VS mode bits.  Refresh the
> > +     * cached translated-block flag after privilege or virtualization changes.
> > +     */
> > +    riscv_itrigger_update_priv(env);
> >   }
> >   /*
> > diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> > index 8b58cbd07a..2c9c251643 100644
> > --- a/target/riscv/tcg/debug.c
> > +++ b/target/riscv/tcg/debug.c
> > @@ -32,8 +32,6 @@
> >   #include "trace.h"
> >   #include "exec/helper-proto.h"
> >   #include "exec/watchpoint.h"
> > -#include "system/cpu-timers.h"
> > -#include "exec/icount.h"
> >   #include "accel/tcg/cpu-loop.h"
> >   /*
> > @@ -53,20 +51,6 @@
> >    *     1 |    2 |         tdata1, tdata2 | Address / Data Match
> >    */
> > -/* tdata availability of a trigger */
> > -typedef bool tdata_avail[TDATA_NUM];
> > -
> > -static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
> > -    [TRIGGER_TYPE_NO_EXIST] = { false, false, false },
> > -    [TRIGGER_TYPE_AD_MATCH] = { true, true, true },
> > -    [TRIGGER_TYPE_INST_CNT] = { true, false, true },
> > -    [TRIGGER_TYPE_INT] = { true, true, true },
> > -    [TRIGGER_TYPE_EXCP] = { true, true, true },
> > -    [TRIGGER_TYPE_AD_MATCH6] = { true, true, true },
> > -    [TRIGGER_TYPE_EXT_SRC] = { true, false, false },
> > -    [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
> > -};
> > -
> >   /* only breakpoint size 1/2/4/8 supported */
> >   static int access_size[SIZE_NUM] = {
> >       [SIZE_ANY] = 0,
> > @@ -165,13 +149,17 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
> >   bool tdata_available(CPURISCVState *env, int tdata_index)
> >   {
> > -    int trigger_type = get_trigger_type(env, env->trigger_cur);
> > -
> >       if (unlikely(tdata_index >= TDATA_NUM)) {
> >           return false;
> >       }
> > -    return tdata_mapping[trigger_type][tdata_index];
> > +    /*
> > +     * tdata CSRs belong to the trigger slot, not to the currently selected
> > +     * trigger type.  A type-zero trigger is disabled, but the slot still
> > +     * exists, so software must still be able to write tdata2/tdata3 before
> > +     * selecting a supported trigger type.
> > +     */
> > +    return env->trigger_cur < env->num_triggers;
> >   }
> >   target_ulong tselect_csr_read(CPURISCVState *env)
> > @@ -729,6 +717,30 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
> >       }
> >   }
> > +static void no_trigger_reg_write(CPURISCVState *env, target_ulong index,
> > +                                 int tdata_index, target_ulong val)
> > +{
> > +    /*
> > +     * OpenSBI programs DBTR slots by first writing type zero to tdata1, then
> > +     * writing tdata2/tdata3, and finally writing the desired trigger type.
> > +     */
> > +    switch (tdata_index) {
> > +    case TDATA1:
> > +        type2_breakpoint_remove(env, index);
> > +        env->tdata1[index] = 0;
> > +        env->itrigger_enabled = riscv_itrigger_enabled(env);
> > +        break;
> > +    case TDATA2:
> > +        env->tdata2[index] = val;
> > +        break;
> > +    case TDATA3:
> > +        env->tdata3[index] = textra_validate(env, val);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +}
> > +
> >   /* icount trigger type */
> >   static inline int
> >   itrigger_get_count(CPURISCVState *env, int index)
> > @@ -754,21 +766,6 @@ itrigger_set_pending(CPURISCVState *env, int index, int val)
> >                                      ITRIGGER_PENDING, val);
> >   }
> > -static bool check_itrigger_priv(CPURISCVState *env, int index)
> > -{
> > -    target_ulong tdata1 = env->tdata1[index];
> > -    if (env->virt_enabled) {
> > -        /* check VU/VS bit against current privilege level */
> > -        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
> > -               (get_field(tdata1, ITRIGGER_VU) == env->priv);
> > -    } else {
> > -        /* check U/S/M bit against current privilege level */
> > -        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
> > -               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
> > -               (get_field(tdata1, ITRIGGER_U) == env->priv);
> > -    }
> > -}
> > -
> >   bool riscv_itrigger_enabled(CPURISCVState *env)
> >   {
> >       int count;
> > @@ -776,7 +773,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
> >           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
> >               continue;
> >           }
> > -        if (check_itrigger_priv(env, i)) {
> > +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
> >               continue;
> >           }
> >           count = itrigger_get_count(env, i);
> > @@ -803,7 +800,12 @@ void HELPER(itrigger_match)(CPURISCVState *env)
> >           if (!count) {
> >               continue;
> >           }
> > -        itrigger_set_count(env, i, count--);
> > +        /*
> > +         * This helper is emitted at TB exit after one guest instruction and
> > +         * after the translator has committed env->pc to the successor PC.
> > +         */
> > +        count--;
> > +        itrigger_set_count(env, i, count);
> >           if (!count) {
> >               /*
> >                * From the 1.0 spec: "When pending is set, the trigger
> > @@ -822,61 +824,21 @@ void HELPER(itrigger_match)(CPURISCVState *env)
> >               itrigger_set_pending(env, i, 1);
> >               env->itrigger_enabled = riscv_itrigger_enabled(env);
> > -            do_trigger_action(env, i);
> >               itrigger_set_pending(env, i, 0);
> > +            do_trigger_action(env, i);
> >           }
> >       }
> >   }
> >   static void riscv_itrigger_update_count(CPURISCVState *env)
> >   {
> > -    int count, executed;
> >       /*
> > -     * Record last icount, so that we can evaluate the executed instructions
> > -     * since last privilege mode change or timer expire.
> > +     * Icount triggers are matched from translated code after an instruction
> > +     * has committed its successor PC.  Timer and privilege-change callbacks
> > +     * therefore must not decrement count or fire the action here; they only
> > +     * refresh the cached TB flag state.
> >        */
> > -    int64_t last_icount = env->last_icount, current_icount;
> > -    current_icount = env->last_icount = icount_get_raw();
> > -
> > -    for (int i = 0; i < env->num_triggers; i++) {
> > -        if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
> > -            continue;
> > -        }
> > -        count = itrigger_get_count(env, i);
> > -        if (!count) {
> > -            continue;
> > -        }
> > -        /*
> > -         * Only when privilege is changed or itrigger timer expires,
> > -         * the count field in itrigger tdata1 register is updated.
> > -         * And the count field in itrigger only contains remaining value.
> > -         */
> > -        if (check_itrigger_priv(env, i)) {
> > -            /*
> > -             * If itrigger enabled in this privilege mode, the number of
> > -             * executed instructions since last privilege change
> > -             * should be reduced from current itrigger count.
> > -             */
> > -            executed = current_icount - last_icount;
> > -            itrigger_set_count(env, i, count - executed);
> > -            if (count == executed) {
> > -                do_trigger_action(env, i);
> > -            }
> > -        } else {
> > -            /*
> > -             * If itrigger is not enabled in this privilege mode,
> > -             * the number of executed instructions will be discard and
> > -             * the count field in itrigger will not change.
> > -             */
> > -            timer_mod(env->itrigger_timer[i],
> > -                      current_icount + count);
> > -        }
> > -    }
> > -}
> > -
> > -static void riscv_itrigger_timer_cb(void *opaque)
> > -{
> > -    riscv_itrigger_update_count((CPURISCVState *)opaque);
> > +    env->itrigger_enabled = riscv_itrigger_enabled(env);
> >   }
> >   void riscv_itrigger_update_priv(CPURISCVState *env)
> > @@ -911,18 +873,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
> >       switch (tdata_index) {
> >       case TDATA1:
> > -        /* set timer for icount */
> >           new_val = itrigger_validate(env, val);
> >           if (new_val != env->tdata1[index]) {
> >               env->tdata1[index] = new_val;
> > -            if (icount_enabled()) {
> > -                env->last_icount = icount_get_raw();
> > -                /* set the count to timer */
> > -                timer_mod(env->itrigger_timer[index],
> > -                          env->last_icount + itrigger_get_count(env, index));
> > -            } else {
> > -                env->itrigger_enabled = riscv_itrigger_enabled(env);
> > -            }
> > +            env->itrigger_enabled = riscv_itrigger_enabled(env);
> >           }
> >           break;
> >       case TDATA2:
> > @@ -937,27 +891,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
> >       }
> >   }
> > -static int itrigger_get_adjust_count(CPURISCVState *env)
> > -{
> > -    int count = itrigger_get_count(env, env->trigger_cur), executed;
> > -    if ((count != 0) && check_itrigger_priv(env, env->trigger_cur)) {
> > -        executed = icount_get_raw() - env->last_icount;
> > -        count += executed;
> > -    }
> > -    return count;
> > -}
> > -
> >   target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
> >   {
> > -    int trigger_type;
> >       switch (tdata_index) {
> >       case TDATA1:
> > -        trigger_type = extract_trigger_type(env,
> > -                                            env->tdata1[env->trigger_cur]);
> > -        if ((trigger_type == TRIGGER_TYPE_INST_CNT) && icount_enabled()) {
> > -            return deposit64(env->tdata1[env->trigger_cur], 10, 14,
> > -                             itrigger_get_adjust_count(env));
> > -        }
> >           return env->tdata1[env->trigger_cur];
> >       case TDATA2:
> >           return env->tdata2[env->trigger_cur];
> > @@ -995,6 +932,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
> >                         trigger_type);
> >           break;
> >       case TRIGGER_TYPE_NO_EXIST:
> > +        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
> > +        break;
> >       case TRIGGER_TYPE_UNAVAIL:
> >           qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
> >                         trigger_type);
> > @@ -1147,8 +1086,6 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
> >   void riscv_trigger_realize(CPURISCVState *env)
> >   {
> > -    int i;
> > -
> >       if (env->num_triggers > RV_MAX_TRIGGERS) {
> >           error_report(
> >                   "Invalid configuration: 'num-triggers' must be less than %u",
> > @@ -1161,12 +1098,6 @@ void riscv_trigger_realize(CPURISCVState *env)
> >       env->tdata3 = g_new0(uint64_t, env->num_triggers);
> >       env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
> >       env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
> > -    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
> > -
> > -    for (i = 0; i < env->num_triggers; i++) {
> > -        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > -                                              riscv_itrigger_timer_cb, env);
> > -    }
> >   }
> >   void riscv_trigger_unrealize(CPURISCVState *env)
> > @@ -1177,11 +1108,6 @@ void riscv_trigger_unrealize(CPURISCVState *env)
> >       g_free(env->cpu_breakpoint);
> >       g_free(env->cpu_watchpoint);
> > -
> > -    for (int i = 0; i < env->num_triggers; i++) {
> > -        timer_free(env->itrigger_timer[i]);
> > -    }
> > -    g_free(env->itrigger_timer);
> >   }
> >   void riscv_trigger_reset_hold(CPURISCVState *env)
> > @@ -1209,7 +1135,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
> >           env->tdata3[i] = 0;
> >           env->cpu_breakpoint[i] = NULL;
> >           env->cpu_watchpoint[i] = NULL;
> > -        timer_del(env->itrigger_timer[i]);
> >       }
> >       env->mcontext = 0;
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 5834ec1524..027fe5b46a 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -181,8 +181,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
> >                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
> >       }
> > -    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
> > -        && !icount_enabled()) {
> > +    /*
> > +     * Publish itrigger state even when QEMU icount is enabled.  The helper
> > +     * runs from translated code after committing the guest successor PC.
> > +     */
> > +    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
> >           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
> >       }
> >   #endif
> 

