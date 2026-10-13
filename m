Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A09BCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGexX-0002A3-4x; Tue, 13 Oct 2026 12:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGevs-0001DR-G2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGevp-0007wg-N9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE43tt900331
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 65iobGMBDsqCGXa4pUiVkbK1NL/dB12YHS0tcG5CZts=; b=nqhXRlrIlynwSjQD
 SdWvqEzhNZTqKCuJLcm6y1N/RgctxPZPHI1ZyrvwmnWMAkIS9hwDiQj2QwMKBUU9
 335dn6aB14/F6J4LYtwdJK/b3Ix/Nb2/4fy9hZUXC0euS0fyiw70eQxufn9NoipI
 CIh22ozfNVMUVpuYMhsVtOSUEr2VnwYEFd9izMWCleCZnXa0DGHIAW31o1oRkY1b
 m6wMXuFGjrBv3zEe9gNtQmUDieOZjWFyeeMiuN9U8dhLhP3GYnT0MOPc2TwV7HJQ
 VZI82NOyptTmIyxM0KWwA3VHAU6VXTwVC9ddQLm7slHo4kPqcbLuiI89XrKDf5ES
 Acdx+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7uj5nq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 16:00:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso644917385a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791907246; x=1792512046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=65iobGMBDsqCGXa4pUiVkbK1NL/dB12YHS0tcG5CZts=;
 b=ILIp30c2HSGSLAF0Ja8bmcrZtR6KHgwMOTJCzageQwkVJ1i2vJ+P4n40b1jz0be6/R
 7wpZ8AMueOmmkx4f8k6DwPBHW+fOOZiZU35pjHo/WWyD7MY+aAd/TSiSzYthp6i9sIqr
 vzwd7dZNMvRrHlLGmze47Bi3lU06T/iQqeWQ6vh5ssp7h/TJHtcFGbJeRO8XZA8nL2x1
 2G4abI+PacDl8u4Rls3F0JJvfyRg+E+eKBLxB36uBNCVhuOtd7NJUvPlv3DJdLWztKKn
 5266sEoEQPbx7aFeAQxa3HfTCFXQzA8ySFPmxRXkLsY+UudrwNP4n61dRulE5t3iU5oP
 l6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907246; x=1792512046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=65iobGMBDsqCGXa4pUiVkbK1NL/dB12YHS0tcG5CZts=;
 b=Ob1aI7moZ8b0rrixCpIw8xBlAq3NjLWZvCe4ABNulplD6dMMSTf5qXuk+FjhdWyPPX
 2vuJPTHpkVl6MvkqbSNZ0jaT46Np+1IdFyIGO/nTthKaS1at+0Mv/wxsDq7Gh8MojBcX
 hEyvdyrKIJ834EjoLX9V+Nqw1Q6rYvkOO7CuiOAg2YPY0yqkXfdnFi/BT+UQi4KvL//t
 o2EVLt1YjSOxydQSPweVztsDR+UqAXC8XQCL6aeL7FMSoXRl3B9YSmmMP8+vza9630on
 ATijdq3D4EDzTpW+Eku1ZoRlot5gYJ56TLn0mvHsr9HKX92vk0S2Ui7tqQc+1LffyNNm
 EslQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMBOIfZOyH3Wim9qAjR+6VGCHKvwKfsfsdxf0q3gs2+AMLurH5RvEjjt3lb9aoWlqz22u1W3LBd3lY@nongnu.org
X-Gm-Message-State: AFq9FYLnHzV/Lg8E/DvKB05rApoYfroYY8BgYIZ+a1LYhZ6+ZvtHff6X
 Lh2OIrpOwVYX5kqZbjm8kFTrNBpnLtTMhZ/lSj4XnNPDxLwljZnp0ZBgMR8Zc2/Tbjdg/9BzkhE
 KZEzWe7wPJZ+szNaaSTYGLIjc8nvC8Hmdw03XDyYKhQ46Sbye2lX1V7mEgw==
X-Gm-Gg: AYBFou16N3un85nDAKN6cf0EweA1oGFvtTLpx5O279rEykmMgzMoIZxFrjKyGczkBdx
 /WgKZ8kxAGhwl31C78Tp71DcnnPKSrnrhk+LVxSqFblLSkGOb3Ztcw9QfGV6A9L84Oe5xyEzfin
 C29GXaY8uFo8Anq0/8IEMIBq1FNrBLdTfrSmam13C/Jh0yh9No380IaHfyenQsmnccwgAVNUMPT
 C1/ZCj/oR7yWvb+Tw88Vy78OAPUVxbEmx/XMLoy0jrlbRRpu1D/xSpTJzSqmunhXa6lqbo5Tml8
 zKbibeB3EO6XyRUVXe2fakOem6J/fiQ4wBKsYNryA0pn5gtX3bA+50bllzV7NBKWuPt+7QEr0T2
 EXazM3bR1W+mTu4wmJJlwJIwJffv1WovaARE=
X-Received: by 2002:a05:620a:371b:b0:93e:6c4f:bdfb with SMTP id
 af79cd13be357-93ebd22ab17mr2267547985a.48.1791907246224; 
 Tue, 13 Oct 2026 09:00:46 -0700 (PDT)
X-Received: by 2002:a05:620a:371b:b0:93e:6c4f:bdfb with SMTP id
 af79cd13be357-93ebd22ab17mr2267538185a.48.1791907245610; 
 Tue, 13 Oct 2026 09:00:45 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef502608bsm269171285a.25.2026.10.13.09.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:00:44 -0700 (PDT)
Message-ID: <f2600f08-73a0-4259-9175-7f644997c366@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:00:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: rick@sloservers.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <mhng-29CE4AFA-6FA7-4BFC-8C6F-F6719A684302@Palmers-Mini.rwc.dabbelt.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <mhng-29CE4AFA-6FA7-4BFC-8C6F-F6719A684302@Palmers-Mini.rwc.dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX8/Lr5K7BDtT2
 iZykd2eVALEldKuF1Puryb5fNc9omXUgpsdHKBXH5nN0Vn/GMaK7A2XYJXwBQjJ7Kitro4nb2+E
 /SZkr6KKSeKzliXFDJeLYvchuWXQ63ofI/X2G9e5Z1hKN2PFT4/mqCzWNMuTeG/8B7DaMuQBM6M
 6DHpSu0xXodCkG4FH6YpdVZZjosi2BOSFWnT1sYzqt/LfPpnl66bkeSCMPBSYc4Q650YWy7+SjE
 vWlBGf6kZQdT/MGx7xur7jGOd5hv6OidWpCppueacBjE4y1VPnOUAmCctCD+mZmxKBAopaRiJGf
 z5Wqx4/CtlyaGdrTXEMv4Q9Jes70zSpVItk+hWGot8SI03kP7ji/Ytk57Lqz/6FMoPmxcXEfjhY
 99nCItJ/DJJ3ykctTds26Uu55VjJln85s0l1OtZvjeOuuSP75qJiL9PACXL2kdXvNlaSPuHxEvP
 tFSslCwvCXiInnGYROg==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace55af cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_O3DOGVWAAAA:8 a=F-tV29oOAAAA:8 a=k__Iyt3_JXw3inKg9pMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=2TKV-7w1aU1AVAwN0oqT:22 a=Y2dezMJzicAI2PZykhZh:22
X-Proofpoint-ORIG-GUID: wmED7lPpGEwrvf7aP4cNg0faKrEEjelB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfXzNb6BUjhfkA4
 s66QxA02wqcvY1SUAcHtvyTazwAa/3VxxAyMktSfidFaNMaArAbKH7XXQoRi2Xr6sspgtB3nAa/
 4R4wiidK+hIFChKChKBScvM2Oh0ra/g=
X-Proofpoint-GUID: wmED7lPpGEwrvf7aP4cNg0faKrEEjelB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/13/2026 10:14 AM, Palmer Dabbelt wrote:
> On Tue, 13 Oct 2026 04:57:49 PDT (-0700), daniel.barboza@oss.qualcomm.com wrote:
>>
>>
>> On 10/2/2026 10:47 AM, Rick Richard wrote:
>>> With Ztso, plain loads and stores follow RVTSO, but the barriers
>>> around them use TCG_MO_ALL.  That also orders a store before a later
>>> load, which TSO doesn't require, and is expensive: on x86 hosts it
>>> adds a locked instruction around every load and store in a
>>> multi-threaded guest.
> 
> Thanks.  I'm not quite sure why I had TCG_MO_ALL in there, I think maybe I just misread the TCG_MO_* vs TCG_BAR_* blurb?
> 
> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
> 
>>> The barrier after a load now only keeps later loads and stores
>>> behind it, and the barrier before a store only keeps earlier loads
>>> and stores ahead of it.  That is all TSO needs.
>>>
>>
>> Fixes: 09c4e88759 ("RISC-V: Add support for Ztso")
>>
>>> Signed-off-by: Rick Richard <rick@sloservers.com>
>>> ---
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>>> I found this while looking into why riscv64 guests were so much
>>> slower than aarch64 ones under bsd-user on FreeBSD.  The default -cpu
>>> max enables Ztso, and turning it off with ztso=false accounted for
>>> most of the difference.
> 
> Maybe we shouldn't default to Ztso, or at least not default to Ztso on host systems that themselves aren't TSO?

I vote to disable it in the 'max' CPU.  Changing the mem model from RVWMO to
RVTSO seems like a decision users have to make in the command line, not
something we decided to do because this particular CPU model must have all
possible extensions enabled.

In theory we could enable it depending on the host affinity with TSO, but I'd
rather not create a precedent where a TCG CPU model delivers different
extensions based on host capabilities.  We have enough of that in the KVM
driver.


Thanks,
Daniel

> 
>>> On an x86-64 host the patch made xz almost four times faster and cut
>>> the time of a clang compile by about 30%, the same as running with
>>> ztso=false.  The output didn't change.
>>>
>>> I also tested it on a Raspberry Pi 3B+, which is arm64 and doesn't
>>> give TSO ordering in hardware, to make sure the weaker barriers still
>>> hold up there.  Everything ran correctly, and xz was about 12% faster.
>>>
>>>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
>>>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>> index 40b4c9aa..d31e4295 100644
>>> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>> @@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>>>       }
>>>
>>>       if (ctx->ztso) {
>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>>       }
>>>
>>>       return out;
>>> @@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>>>       TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>>>
>>>       if (ctx->ztso) {
>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>>       }
>>>
>>>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>>> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> index a22e2cae..8c21ab87 100644
>>> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>> @@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>>        * around the loop.
>>>        */
>>>       if (is_store && s->ztso) {
>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>>       }
>>>
>>>       mark_vs_dirty(s);
>>> @@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>>       fn(dest, mask, base, tcg_env, desc);
>>>
>>>       if (!is_store && s->ztso) {
>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>>       }
>>>
>>>       finalize_rvv_inst(s);


