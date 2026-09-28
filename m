Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC699CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9kY-0002Jq-3K; Mon, 28 Sep 2026 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9kR-0002Iz-Jb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:42:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9kQ-0002x1-26
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:42:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAPbg558663
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z49/2JaZ4oOE3XP028GM1sqmGR3P49pYZigkWpywuiE=; b=NRRgbEnzt0hjfmIa
 3VzLPebGAxAnYEJKrVmn+8bxFVbxaYIeZ7BF70l43B4xq4MYx+CXzZD1sQNdou4a
 mSbo6s8iRAAjVDZtYLENdueLNRkWOU+pytr9UVfCMW6RbqdpPWX1gbnTSt6Q+uGt
 03bfUrfHY0Xn9wYbrQ2tWSc64tQuaTqvqdjFbZLBU3mhKbNcRF4kTcnko1rrWTtN
 HkXoitSU73k58vgHAVveFaJ6lFYx2CiEfe8WGFtsezJVW1AmGQYGkOiY/rkNTjXD
 ngFBDmq3/j2aSUes0ImFN/n5AYmKZhhlAbSS6oN1MkakrGSAT/UxX4UzRAMByCWs
 667CuQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1xj0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:42:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5c205127so300019785a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790595735; x=1791200535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z49/2JaZ4oOE3XP028GM1sqmGR3P49pYZigkWpywuiE=;
 b=RL03ffCG35lOLo+GuVSB1iX0UFS+ReRPyfHphgqn5Ixb55/A+uaDSYmhQ3Z/qswMNe
 Jj3+8bHXkOlNUurmPSge9BMoSxKwc35bQ2BSqH/Q1eZDdnmee8VdKs3OEvFM5LRmzM3f
 KyZ+FheWrRWnIavE6O3pjkS+rmAFaBD7vSms08G5kg7roY26Oz8HlbEO5Pop9BMu+Deb
 rRx+SnTtkRrMLMPEyUWcaa3X7X3pvDNDIxnXhitQ52tlMt+tjoAxIiLVPbQ44ivHDDvg
 K8CXd/WIUr2TwVeLPETJPmGTmfcD3P5grnKKwOwCxACgpHAdFDdm6bdRSXw16NxGAlJ5
 15dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595735; x=1791200535;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z49/2JaZ4oOE3XP028GM1sqmGR3P49pYZigkWpywuiE=;
 b=t14MSux60EfFttU+0gT4+/DxF7JDs1+kdltwUhCal14Dor0xxLy1AgTlk6VePmDkWj
 0K6JQ5vfZ7aPOT0m6/Qk6YEf2n2/a8qu+2h1RGJYMsT39cz649azRVcUaC7XLlwS5b3h
 Up9mbi950OQPCxBjLjtaDbsP2qOMGAFcBMedx8KyROKq09vD4PGM1oaBt/LVywMAHl+e
 c6dw+/Kqe9oAI1Xtj08T7SYP+nvt/GG0mjQkboG1+EVd5X7MlhDz6CZApEbNptu9eUjI
 j4wN+X64E5awLAtuOGqTwdmVfZKr6uyZbmvKwvCgf+qfZGzCBiviWQzof6QY+lTfWcmx
 vbnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1ScfK60jDv7bsvup/wFnaJRF0lfkcpHlzD7QZiGQjlCPzD2IL0EvLNDzc1c28CP14Zv2743sGYofK@nongnu.org
X-Gm-Message-State: AFuF++kXVdqeU/s38J9dIKha1mCHXlVP/H6xf2+FBryGfz0rnHNCITq2
 d7yBsbstDvdjs8tUdG6NcWKAG+aCvu1aN0/6OfJkOMYNERFok3cNwKtMjkH/vFNuj/KCpFqIsio
 qk3wpinZpL4Ddo8JmMqGbpClh2Lt4USQGkHuPd9oGUejtk/YktCRUtsnyuA==
X-Gm-Gg: AYBFou0Ju3FtJxCpbSFlGCYk34nXikQlc+THcQiyicGHtnyqEDvM5Dpc7fbZlL1bEe5
 gIOXoyMPddFzWdIELlNpfDtl49x0h8qCKIEg3oLLHiIoRfbcj7UX+U1D/wONP5iT8GCutSiheVY
 S2Mhwb4u1tcUXXwXqeQL3ulpgDY3avKuNXj9Fr5MApk5tVxoRR/YoLEHl1zRYm9a5ke/IuNowB3
 3kzI9i9IOcarDTy3fscALkq870Im79HBgPGE+DwraYPcdWluhWCQTw/Fm7Dmf3gquAT6FiLCpdY
 L4f+sRdicWygXIKGVEW8O/QYbZbYBmrEB/c4wxYE9PPRhYHkc6i+86XH8+zUKa16nM7a9LFvUBR
 9BeDPcwAAhFWFXFsPAUBigfOd1vmZwJuHjw==
X-Received: by 2002:a05:620a:261c:b0:93c:72d2:ccc1 with SMTP id
 af79cd13be357-93c72d2cf15mr694683085a.18.1790595735219; 
 Mon, 28 Sep 2026 04:42:15 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:93c:72d2:ccc1 with SMTP id
 af79cd13be357-93c72d2cf15mr694677885a.18.1790595734622; 
 Mon, 28 Sep 2026 04:42:14 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f3e68sm134141125e9.9.2026.09.28.04.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 04:42:13 -0700 (PDT)
Message-ID: <c34f9f8e-ed6e-4560-9100-05a911654047@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 13:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 098/101] tcg: Generic expansion of tcg_gen_qemu_st_chk
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-99-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-99-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: s7uCSqFlPUvLVqwac4nZ4oWI9aV3RYY8
X-Proofpoint-GUID: s7uCSqFlPUvLVqwac4nZ4oWI9aV3RYY8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfXwjCul1NTjDU/
 2Io7StlWWCrDGmCIVetNLPxa1+YfWXJ0v/z8vlOcQzpYW4xquu7YNugZzcqeO8SwsfpDABJWCwX
 +8hc67U5RvDWCjDDTv0Dm51FncWdEFE=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba5298 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=8nvS8mFBlntTEaBoOTYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfXwN0Jp9hCs793
 /jrvjZvkLa7ZSQmffFdF3BAlnAsY759SYPpB40Ps2Q9FXxMZXEyQYAZ3fv4IsiR9U1qQ+ihigMu
 0PeeJpPGexkgaE9KdBCtvNRn4Usdooukz/+Y7/WoGVSQg7500FUYr+CdIoF17iSYcbGOElj9+zh
 3D6mARv+dxhbRHZDB/YhkQnB5Hz+p0ki1RB0YYWdniGDmZ9NOy7DSBnFia/znhXzhwhOj/UsYYd
 HtVeJZL1nCwY6za9cvvIXBz86BkwTz0Vi+N9TJ2huzl7g1PsEaEzTNa4DGEMz+qAUzkdvLrjdaW
 JJ4CAdMdx8ZYBkq3NWfPDeKEJ1BOKomFCJBeMMDlQuXbOb2WarlSAXBL6mk1cKK5SVfe5WTTW02
 i+OySchSmSScvLgYEcuB+8laiUw2CGvujfJjBxqE65STKUjaLLZZqjzmlo386i5mbzPKCyX3Gy+
 y3DajGFoc1PFqfteBuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |   6 +-
>   include/tcg/tcg-op-mem.h     |   6 +-
>   include/tcg/tcg-op-def.h.inc |   1 +
>   tcg/tcg-op-ldst.c            | 114 ++++++-----------------------------
>   4 files changed, 25 insertions(+), 102 deletions(-)


> -static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
> -                                    TCGArg idx, MemOp memop)
> +static void tcg_gen_qemu_st_int(TCGType type, TCGTemp *orig_val,
> +                                TCGTemp *addr, unsigned idx, MemOp memop)
>   {
> -    TCGv_i32 val = orig_val;
> +    TCGTemp *val = orig_val;
>       MemOpIdx orig_oi, oi;
>       TCGTemp *addr_new;
>   
>       tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
> -    memop = tcg_canonicalize_memop(memop, 0, 1);
> +    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 1);
>       orig_oi = oi = make_memop_idx(memop, idx);
>   
>       if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
> -        val = tcg_temp_ebb_new_i32();
> -        switch (memop & MO_SIZE) {
> -        case MO_16:
> -            tcg_gen_bswap16_i32(val, orig_val, 0);
> -            break;
> -        case MO_32:
> -            tcg_gen_bswap32_i32(val, orig_val);
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> +        val = tcg_temp_new_ebb(type);
> +        tcg_gen_bswap(type, val, orig_val, 0, memop);
>           memop &= ~MO_BSWAP;
>           oi = make_memop_idx(memop, idx);
>       }
>   
>       addr_new = tci_extend_addr(addr);
> -    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
> -    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
> -                                 QEMU_PLUGIN_MEM_W);
> +    tcg_gen_op_tti(INDEX_op_qemu_st, type, val, addr_new, oi);
> +    plugin_gen_mem_callbacks_tmp(type, orig_val, NULL, addr,
> +                                 orig_oi, QEMU_PLUGIN_MEM_W);
>       maybe_free_addr(addr, addr_new);
>   
>       if (val != orig_val) {
> -        tcg_temp_free_i32(val);
> +        tcg_temp_free_internal(val);
>       }

Directly:

         maybe_free_addr(val, orig_val);

>   }

