Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB7C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyToo-0002yc-Mo; Mon, 24 Aug 2026 08:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyTom-0002xY-7j
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:30:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyToj-0008JH-5K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:30:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMTIC1673133
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BHpP+PuDRgPb4YiCCnLaonqjRAXPShnppHYkLBmU/R8=; b=T7hsGj6BdzDwA7p1
 fX8USnnKzqCheFLk7Ck1O38xD3+19iPY+tAVbfGykw+s3vh4CIzooHHfjuvJnlcP
 1RlvlYmKtJ5uEp9EHeTg2icYfYZS5XrjKaGzUBXeLzZGBrxbaDGEuU+IrgHpCOn3
 BO7It8e5GDG9hDlOGy4DrP9c32RRZNCwUa8uZ41IrgSDwJn4knWmFaMIE1KnWM2W
 vQcdvu0QkF9Cl7L8VpBAmMFug+L8Njwy26vSS0G9Jv+SgB66jOaxoRbqVURDas89
 4a90TDaNP3svOOLebSjvtsMnPbCZapQK+dQsEf7M39vP5DCSGcSIEmfXbWVsn/Bj
 12ic2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf15t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:30:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso64044141cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787574619; x=1788179419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BHpP+PuDRgPb4YiCCnLaonqjRAXPShnppHYkLBmU/R8=;
 b=FaDrqXp50vLlDRku9YT6c5LEWB6bk1Lcf4nZ6Fu9eHOSTdmBIMUw3fLoIOmAMWs9yx
 7ATsjAP+WA69LijKTOdiW15+A++Dlumpoyh4VWlKjyIdGbDJwPD+G1Bo/hp3SAZtR0Gd
 KLXTPtoUFm5Up3s3GcR8PVmj/iHu+6mZBHrcYqhW/nGEAjQT55e9hHVRHc0pw3D9eB0u
 bUqc7STg+70QXdfyZOGdvX6/Dd1ND5X7t8WcCumLaDo3wAeoEKKsY2F1ECY5TNmpMExt
 VDbP4BxazJVJ0e4GtC0YwFxtXGWd8yBKKDUuda/Ti6sxT39IoHiCtBZK8vKt1+7HMoRp
 d/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787574619; x=1788179419;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHpP+PuDRgPb4YiCCnLaonqjRAXPShnppHYkLBmU/R8=;
 b=Zo/vxdUXOlBaZKezn1QZCVnGQUWx+/Uz6ojY+mSZbruFitb7OyU3bsgT0mb4ECSVCa
 8A7F2Breg2FXkvFucq5l44UPF6Yq/tH2Qh+nze54w7hf8yv3b73jz3GqmcFTuz/SU1nV
 OLlGuP4hNBrDjZOo0+fxFLD/buA7KGCovcOk/+tN0gpxC4dJbsxnVpXK9IWbCUPu+IdQ
 rLwFqb6RHfg9hfDsBsJrVN3h5eKYfdLi8vjrN0p9BDiAd/p+DyRDqI+Ny7chx8TrWw5u
 bULuVkXvx0o4fsrmRSmlZ09r2q90R+pGhSDnaFAxMnUphiVfLKFm5SlHaimKSGzPTA07
 9GZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rofh83V8AHUpgz3uCEEW0HYjYlhZZsu4sbKoykyj/4KcoP0NjN0VqRZJpSRYqPvDCZNbjbVxtTfc4Wa@nongnu.org
X-Gm-Message-State: AFuF++kaYWuFMHxNn6bBRGCScpYxWaweS3UhTaaktC6UT1S3SSCoL09e
 f2cG2rb1AdDD+dY776Cip6UmfCKfsB6hkdE35yGrbvONwxT4XNiK0VWP33wpnjwiELRG+iKL2KP
 Vbhp8agYbBnbvlTzn96HZERHbvl965q9HYYcOtqBKLAlLnoG30TUkY0difA==
X-Gm-Gg: AR+sD109G8bO9OXbI8Ji6mLgtd5enRcaQ2DtYRIx5+JNOJLXv2RGqy3E5L1h0Umo3XP
 KwbWl8bUB7X0vbEfh3232IJIQ9KiiEw5DG2WDwjaDGwtiUgiNSNT3coCqVhkoB1xOKuI8/dbqO3
 E2pdjz4UeVSjbnpdoQVuBY6dR8A9zK4VC+HsMbkMh6ADl8lccua155BEJs5GqM2B2siMnYTEXJS
 1liP7IFMeScUXMQbZHTZ3Ytb1ODVRuS9KypoQNCsbffxplsKJuyiBE1QfZPgxbvMdDx7dNQwZTd
 tcf2M/BGtqMCx9my+ov5FSwikgp23/BHHtM2xttrSwFnZ66n9xFieGnhnn45PkDlkmfZsntvDoK
 PYyl2nb/eQqjRw5OTauxwuNKNzYcea6eGXkrM
X-Received: by 2002:a05:622a:258c:b0:52d:8841:ef7c with SMTP id
 d75a77b69052e-52e09cca3dcmr184288631cf.31.1787574618316; 
 Mon, 24 Aug 2026 05:30:18 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:52d:8841:ef7c with SMTP id
 d75a77b69052e-52e09cca3dcmr184287481cf.31.1787574617668; 
 Mon, 24 Aug 2026 05:30:17 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2e56737sm14645841fa.6.2026.08.24.05.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:30:16 -0700 (PDT)
Message-ID: <62af219a-0813-40e5-93fb-1ae623248f67@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:30:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Fix RCsc ordering of Zalasr
 store-release
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 chao.liu@processmission.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
 <20260821064032.49556-2-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260821064032.49556-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX7E0bcgaUh2GQ
 sAKM06v/WsO22BH7luqX04nRI30MxAaynq9Dt/o2pzlWKtFJ+SAZNjzZizcZTzWqWFnvLdVPoK/
 4rlH05Z+vGmTR5ABFa+X5aopjmngGVM=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c395b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=SRrdq9N9AAAA:8 a=V4zo2IF0AAAA:8 a=EUspDBNiAAAA:8 a=UI-TSrfoyZab33DARoIA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 5HZralnZv15HDa_XW5Aovtk0KXy30zqV
X-Proofpoint-GUID: 5HZralnZv15HDa_XW5Aovtk0KXy30zqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX8YBpReFhb6mO
 +5MVbM3fX6dJXLbq+Sy4MXVfnniHLhM2wY40ridl86DwKnTnhiuKkPCJggIa2pUBdEZ4Th1zMpc
 Z7sY/dDzaYVuC2d8MCElB5LcXIst4dAeteu1Jc53M8uobUD+BnW945eTGaTN1fHKa0DkBfmVcIc
 yuAJtwLwWoKatMPn+vEDwMQQdEa7D6sH8MDPGUcBV0+cYE81oEV4ng3fIKHu563adkJ94DW8j2A
 rdVyInBsAkKtrIIRAKTmG0aMr0ThyjhHqlaBPQGPDtXTlkn1KQvIV63DBvTophGSmV+p1Xu5E29
 fr4mIi89xH9BCGZoUZ1AkJ+BV/Ia70xFOF1DOmVEas2/0zYRq4Lr2XcnjKwvM9x0b6cQSpKLeOD
 KhbM1o5JvpXHrpwJFRoNNkmvGXrGiLwFN1wxeafUYGQkxXvIh5DTi9tXMRnvZ6Hg34+Gmti7Ddr
 z2NEywkCYOuSAlb3YPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/21/2026 3:40 AM, LIU Zhiwei wrote:
> The Zalasr load-acquire instructions carry an acquire-RCsc annotation
> and the store-release instructions carry a release-RCsc annotation;
> the extension has no RCpc variant (Zalasr specification, chapter 2).
> 
> Per Rule 7 of the RVWMO preserved program order rules ("a and b both
> have RCsc annotations"), a Zalasr store-release must precede any
> subsequent RCsc memory operation of the same hart in the global
> memory order.  In particular "sw.rl X=1; lw.aq r1=Y" must be ordered,
> which is what forbids the [0,0] outcome of a Store Buffering litmus
> test that runs this pair on two harts.
> 
> gen_store_release() only emits a barrier before the store, which
> orders the memory operations preceding the store before the store
> itself (Rule 6, release semantics).  Nothing prevents the store from
> being reordered with the memory operations that follow it, so under
> MTTCG the host CPU may execute the load-acquire that immediately
> follows a store-release before the store has left its store buffer:
> 
>    * on an x86 host (TSO), store-load is the only reordering the
>      hardware may perform, and it is exactly the ordering that is
>      missing here;
> 
>    * on an aarch64 host, no dmb follows the store either.
> 
> The defect is easily observed with a bare-metal Store Buffering
> litmus test on a 4 vCPU guest: "sw.rl X=1; lw.aq r1=Y" on hart 0 and
> "sw.rl Y=1; lw.aq r2=X" on hart 1 produce the architecturally
> forbidden [0,0] result in 89881 out of 100000 iterations.
> 
> Fix this by emitting a full barrier after the store as well, which
> mirrors the FENCE translation.  The TCG_MO_ST_LD bit included in
> TCG_MO_ALL makes the x86 backend emit a serializing lock-prefixed
> instruction after the store, draining the store buffer before any
> subsequent load executes, and the aarch64 backend emit dmb ish; the
> store therefore becomes globally visible before any subsequent memory
> operation of the same vCPU, and Rule 7 is satisfied.  This is
> stronger than Rule 7 strictly requires, since the barrier also orders
> the store with respect to subsequent non-RCsc operations, but this
> matches how QEMU already implements FENCE and keeps the fix simple.
> 
> The load-acquire side needs no change: the barrier emitted after the
> load already orders it with all subsequent memory operations, which
> covers Rule 5 and the remaining Rule 7 combinations (load-load and
> load-store).
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Co-authored-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
> Signed-off-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> index 79b0b2c63b..28d9b13c55 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> @@ -86,6 +86,14 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
>       tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
>   
>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> +
> +    /*
> +     * Zalasr annotations are always RCsc: per RVWMO Rule 7, the store
> +     * must also be ordered before any subsequent memory operation,
> +     * e.g. a load-acquire in a Store Buffering litmus test.  The
> +     * barrier above only orders previous memory ops before the store.
> +     */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>       return true;
>   }
>   


