Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E5C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsINj-0001Ct-Az; Fri, 07 Aug 2026 07:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsINi-0001CW-6X
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:04:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsINg-00068S-8S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:04:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6776C6gF3576204
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 11:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HnwgKbBW3JF2Vo+MkABsFuBwZTQx16q+MAGpnqX1guM=; b=JjoITSMQKi+zPpjl
 37uTorb3B5uijxy0qcm2rlUFL2RSjdDSBbaBFLOPROdViRQ0WHrvF6cmtfM0wfaK
 yYsD3BMkMLA7h3FQXx2KgeAqVBymsHEnC/4Nceyi3AtEcxaJz7iF9jKUU3NzgAl8
 7b2kRaSG5urbqZQyv810ux6A26py2RfHQj4ua3lAFFjjunb/37RWsulaiS/OINgW
 7jhWyYp7pOkKoqBQjJv4FwffzYYekfFxkdi8uohkl3857xolSEdgzLBgXNGi7nNo
 H8/sarfMVjtaGQX1Ng12w4jaiDXHEzbRTMnQVHlLZUx3SlMiuNgBMWMf4Ru7l3Ic
 BaMiRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu11v8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 11:04:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e55721a8cso313017285a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786100689; x=1786705489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HnwgKbBW3JF2Vo+MkABsFuBwZTQx16q+MAGpnqX1guM=;
 b=DWOBFoi2QvqYITohAkheJ33gI1jKNlRc7gm7k8RzMJaE7ERFWr0ISC4p+3PIocdwiY
 D2LlCovYlQAs5kp6Avzd53Y7djGoegUAQhoiqrJ01Uejn9HI5pXZc6LJcgp1oYtH+B82
 Uc5ejyXH463VGN/eaXGnBlMTXVExcZq8WytwY6YNwW+Kjl+ykzMiVNHrt9itOi/8Qr/H
 9zdTEa2HUGJ+Otd7Yi/Msk7akgbjtE3eEy7iWNucAVX5WOfN9gmnApgou/I7QUcl7jHt
 UrDezprj+tSkC3pPBqLZ3SpkF2HbgZbyc00ozBjmU3TmwJxyohfuRwJJ6frVo5VL5dx7
 oXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100689; x=1786705489;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnwgKbBW3JF2Vo+MkABsFuBwZTQx16q+MAGpnqX1guM=;
 b=k4oputLUx+2fJHKcSEcBH+Z+nd/vF5PS14xSLYNxAdYXhkxhf5CbzJUU6KOD2Yr8PU
 M1hsq1NpsXFGI7pNN5ZColrQXp3vn6IqfAqMTfI30MbT8yGoX7PbUu/d74wpWTcFbu6N
 e1YTVSpaT9OHjPx4Gk4ePYiBITz6Md3bRQIlSzujgfDoMXrbfVKV9PfcCYCnKbzw0MK8
 ymlJHIgKrvkEE7QGLbXxaqfJuKKO/iABNUULyGuWZgBbWP5+X13PLDvzaGy4c5rI+evP
 V7oKj/Kf6Smc6Xri+tuzxPR8vN2Yx1u4QNQiWAW6gpcSmi+PP/TOYLGYNaEk3l/HtNJI
 dBiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOZeraYh4DoKkgLl/Id4sdGVxcF84sMbfYmZS0qKwWssc8jt8Srz7vMVDhlSnAZfR9w0L1N1ZKzwOk@nongnu.org
X-Gm-Message-State: AOJu0YzBMmaR0g/gT66O95vQZCO+NaeESa5yNIfEU0AaZrwj9ehFcemH
 +ylm3y4P+m/JDfzvYxNVAk5Hm0U4VJx0MMSxgGMUA8CBHORMhZm/J68ATH9lWynL1dM4WYKbMqn
 9v1c7t0BySfdXpW5wPKxwVmLxRU+S5HdHkQZ5xzDMSct8SAs3FQQqsXd8eg==
X-Gm-Gg: AR+sD10ag5Y5sTaS6BFCxIjb72E3x/0pVKr6seWi4hIApN03MliyEA2DLRRqspWiIZa
 MtV8o1lJkKvjlyJUFBrsJ/OKr3uP79nqIERbZA5URPUZs0QPQz+jvxsu+SDOww2iR5CUr2RDsPu
 cRwIoBMouTb4b8BxN57Ln5YuPso27GU0WtWotvVQNFpEJHR+Eak5yGBpJDwlf+hLx1V6UYh/xsb
 sBIq1sLBfoXvFQtWQE9B5wYWrZnfevpZussYNZCopTWd2l+kQjBAId4f9B3e2r2tvO5nY5paEbF
 Ig6F6USDAwhz7P+t+kW6zKRUmvcVMjDfTzv2DyidM+hAELGqw8Z/kyObkAgCozeGoOgExGLzifQ
 DBYUHbCo4X8AW2TLqlFcbNOX6fVRDx4BCTqHv
X-Received: by 2002:a05:620a:a918:b0:92e:c93a:65e2 with SMTP id
 af79cd13be357-936492aee28mr1976263385a.39.1786100689044; 
 Fri, 07 Aug 2026 04:04:49 -0700 (PDT)
X-Received: by 2002:a05:620a:a918:b0:92e:c93a:65e2 with SMTP id
 af79cd13be357-936492aee28mr1976257585a.39.1786100688615; 
 Fri, 07 Aug 2026 04:04:48 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e261918sm121192485a.34.2026.08.07.04.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 04:04:47 -0700 (PDT)
Message-ID: <896d54b5-a373-428e-8256-9003b2697744@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 08:04:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI
 exception handling
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260730181852.1622-1-ahshehab24@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730181852.1622-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rI1B_UdD8COqFcs4Wlqjtul4Lyg6EvS9
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a75bbd2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=UFTaeZGCLHsyUKFxc-IA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NSBTYWx0ZWRfX6qAO3ClGhnl6
 k3eksDGyJ3E6fg047TKf3wRKbDm2GV7Uw/cN8FmitRdoxEsW0eEw5sqQLf/JWR+DvWhF3j4sCl+
 H/o79sRZjNTkm8jAgM4EW3RfS8sUZPU=
X-Proofpoint-GUID: rI1B_UdD8COqFcs4Wlqjtul4Lyg6EvS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NSBTYWx0ZWRfX5ffkh72EWbEk
 LkZr4VyCaAaWarlIda7yacS8qpgcrFqbWBsvfpyZh86QZQat1yEpl49gg6FIyoMIVy4FSSqamY/
 MJmCbxPLnBwK9OwWCLV1a75dOEEQINfjRLx+MyeJGzxODMWOFKW6THEgoHPW581Q6K7XrH7GKMp
 9lFJ6WyLKLSzzOwBNsWlsNgkZLx7T/PZ5WazgmgdDdHvg5G9kqd9BpkIqUr3A8kpchNyzbyIQIH
 HUOTD89qWnEUZHjk11jKHvQU6tfMKPAr5/Bp6O7MGYXCU1lEszjpUclsAe3wybbxxh2L2WMdtMc
 69Zj9cg5QRIti3F1BA04k6vy6r9I5UwpdCE/AsF7OXzNlpx6jaPSERIHlJNATTtmqKlr4dmbwL6
 VHYgTM95I9blnRgAAzYoLgEuMlV+9RZ10wkmkLALJbtmS6og5/BY7EdLx6VoUPwdlfSqCC4RO6k
 FKoSe7xMgdg138+r67Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/30/2026 3:18 PM, A-Shehab wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> Move gen_update_pc call before conditional logic to ensure consistent
> PC state regardless of execution path.
> 
> Previously, the host instructions generated to update the cpu_pc were
> only executed in the failure path when shadow stack validation failed.
> This created inconsistent PC synchronization.
> 
> This inconsistency caused issues in CF_PCREL mode where subsequent
> instructions calculated wrong relative offsets from stale pc_save
> values, and could lead to incorrect exception return addresses.
> 
> This fix ensures PC is always synchronized before any helper that
> might raise an exception, maintaining consistent translator state
> across all execution paths.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [ahshehab: rebased on current master; file moved to
>   target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
> Tested-by: A-Shehab <ahshehab24@gmail.com>
> Signed-off-by: A-Shehab <ahshehab24@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> This is a repost of Max Chou's patch from 2025-11-05 [1], which did not
> receive any review. Rebased onto current master: the file moved to
> target/riscv/tcg/insn_trans/ and the ssp load is now a 64-bit load, so
> the original patch no longer applies.
> 
> I opened a GitLab issue (#4118) with a minimal, self-contained bare-metal
> reproducer for this bug. It runs an sspopchk that matches the shadow stack
> (the common case) followed by an auipc in the same translation block; on
> current master the auipc returns an address 4 bytes too low (exit 42) and
> with this patch it is correct (exit 0). The reproducer is included in the
> issue.
> 
> [1] https://lore.kernel.org/qemu-devel/20251105134331.2865581-1-max.chou@sifive.com/
> 
>   target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> index a813232887..d47a9f9c7d 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> @@ -32,6 +32,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>       TCGLabel *skip = gen_new_label();
>       uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
>       TCGv data = tcg_temp_new();
> +    gen_update_pc(ctx, 0);
>       TCGv_i64 wide_addr = tcg_temp_new_i64();
>       tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
>       tcg_gen_trunc_i64_tl(addr, wide_addr);
> @@ -42,7 +43,6 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>       tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
>       tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
>                       tcg_env, offsetof(CPURISCVState, sw_check_code));
> -    gen_update_pc(ctx, 0);
>       gen_helper_raise_exception(tcg_env,
>                     tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>       gen_set_label(skip);


