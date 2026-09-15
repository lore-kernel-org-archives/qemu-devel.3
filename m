Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF7C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HOz-0000lj-1j; Mon, 14 Sep 2026 20:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HOy-0000lY-65
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:52:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HOw-0004gb-GP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:51:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN03cM2336491
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hCjAdD+h5IxJZD65SQ/FWgqFxOBiUpT+otevLZoymPQ=; b=YfIyS5xfbbnHfN/J
 6i75z+MpFY8zb0qT/Lzt2ik+dsbvWD3wf30m3yZGKi2CHNMP3NtQ6A3Qfq72lpmS
 ipo+AKDh8khwKMdObiCfWGR0lFzv/UifqvBmQ/UwrcZHJygq+9zw6NamTyyHd42e
 DUYEo4yFglEf0VqRtZp/jLe8nA5I+iBhyqbum1dnyaoLirDkiUmX10nFH9DhOI4U
 JVfJqvlIhLwwz7aJFuT8cp1cqZaKjdQ2a+5wqJMlYHpMvasJeEUdl4x/ROIMAhoP
 ATmd8GE98AxRzOhIdtDu6Jtluj74rOAgd3y6Bd4yd6FqEERyBDPoLOkI69vnWLsV
 PQb4DQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5unx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:51:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so304430185a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433517; x=1790038317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hCjAdD+h5IxJZD65SQ/FWgqFxOBiUpT+otevLZoymPQ=;
 b=CW4zNtmhjyTEBX31OoAfz7jTQVDreRc3dHYmaR5K3eMU0mg+cpmy4jqwu74+wdmgVX
 KpwkZNy7JzioWy1rEA7BRpTKaCy9VQ8zNafw2ehdfPM8+7hWMLKCbrMh8czjfrlwJBGA
 F4ypU9LiLKJXhEgo3GoOheikmVusiFuxhPpCdE6QmGx8cGhIb+HLSHm7Jd4B+dC/xEqc
 lkOTf5CkMZkLt677kSU1DTbvAsm1p5Fvj/jbq1FWJZHUxPRN4GfdmttJCiUnJeCg6ouN
 1fOr6G/jojP769WEn0mR+EzMd2kN4I6UzdrJ6gTd2HgxdYpqq8ef8tx2eedE+BlH1T13
 jxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433517; x=1790038317;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hCjAdD+h5IxJZD65SQ/FWgqFxOBiUpT+otevLZoymPQ=;
 b=rgvWhl/QIz4oPEpSd9uv91MwLeHIOhcX0aVudV2GGWhYaYoaLXy1y5y6E4rNFZqkvS
 b1IVo0WIDA2p98T+Orf/0eTf9UFXGBuLZ0JqJCvDXnLwkY/Wn27XTILZJrNs8DBJZdpv
 Ze8bz1nZWTvMlR9MpUaVctdN9Dlp2qmNITS5+zMO3/UtQ8L4sH3XJKbqxvHS75JTYlXL
 26otwpsWmTDXz7nzigZjwOEunpRBoJmjkmJu6UTAfH0/wFsJY327kpyRSnM7ELLeDHSV
 V+sQ58UPtrD1EbQymS0/UhaZ07c4WSIKT7HA4/X8E9G8A0yAIH+q7nK9YiMxqj60EYfH
 zcfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn1H0xlOHhWsu5uQRrVe5rbBx/2cP2Xr/lR5/1MH+VW5CXe1g1HZ8OfS0aKpqoA+nhhwRY2y/w+4YL@nongnu.org
X-Gm-Message-State: AFuF++nXQQzPPnZkQ9N+DfYKEHX903vfW+dYACPhSJWZ2dwDs9kDZRmm
 qI0N0GuvRegbmErsbv9PUBXFTTMcUVpzpoF88mcK/Jyn4JQIWkr9bhahJoGWsCgMI3hEiqVXWrP
 GTWYtshPtz1FkNpk9Wsz3CbpLAORFsKmtJuHM5JHHw2ENjeV7vObUFmf6fg==
X-Gm-Gg: AYBFou2hpctquXs3MgcdBBFJyqjdr4mGHStgb17U1fw1WvQyLAppXd5vBoVTKMkO/5A
 /ujfjCdl12hGmehv7pe1lELmeS9/XYGwKWjFQIYf4eAXOFcqJiaCqIE8YfNQLvieGZnQJ2FjwAA
 3oloNxvwD8OUVKDEtu4jW+aEBsU+mKkbwbgg/9/1+aYRJiXNEo273upCE+QAf3SAnUMAo+Ujp7H
 stxdE9mOYwwTgrO2C6dZZE5Mz4WgqrAD5eVxOvllyFmWYnJnRPCOyyzUvViNSt6+3eGwnIys3gt
 DC9CXoYhoBrEXHE2mX9UU0thI7doib9uZhTqyuktAhZjZWVWv2d2Je6ZaeLZWM/lRyugc25vtgp
 Ex2Rpk2B+H5ehSg9gNlcEUqVJSHTu1UvEP+bThmxYabgwVmnZb6OoDVRPXqay
X-Received: by 2002:a05:620a:2904:b0:930:9091:f0ce with SMTP id
 af79cd13be357-93a2985a593mr814712285a.22.1789433516953; 
 Mon, 14 Sep 2026 17:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:2904:b0:930:9091:f0ce with SMTP id
 af79cd13be357-93a2985a593mr814709685a.22.1789433516559; 
 Mon, 14 Sep 2026 17:51:56 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120ef650a6sm109485036d6.0.2026.09.14.17.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:51:55 -0700 (PDT)
Message-ID: <f3775344-23ed-4914-9b86-d2dece8f9019@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 19:51:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] Hexagon (target/hexagon) Check for qreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-7-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-7-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfXyTHSnxYM2+gX
 BG1jSfIpz+NMIEKQ0+Xvy/CZWO7npklmf3SsuvrzRg4kR6nw4+s8D+eQzhBy9TbU6AGXs12G/r4
 Ut6slcIOqLVtI5dnW9jdn1V2gXyaF0g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfXy/wAnpSfKLXK
 XxIf5J87fNKoScZLmJGgn0nfXLMlVW4imuNWtfdRlJjso4ofQCFdIKn29M2oWpIr3ydDvYYS3vT
 BTaUb9Bm3ffF2kkjNoQOe1YGdxq5FbWnRa0OYpze0tzBm2A7FfeDYcLQYUBfPjca435nRQ8flhp
 Hf+2KG5P7/K8YwykKQvX4QxaGqZVx13TDFOZE2UiW0bHyCOstTixLYGZm2xw4boV9TcZgnRhpHl
 GZLwiJlmncNsTcqVINfgf2zlWsK0fSXt4OtBIsWV/oMDaz/QHCQiVKjLFUp61mlDR9iQH85jNvC
 SMwt++NFJaWxoBnq6mBvnjW8ZKZarwBDkxtc5mVo1UsBks600nvqo1CSBroHlttgUTSb/4divGV
 85NPt+HFtehM+Vm22hnrFRBKZonS2xY1qAxfZk+FwSMKARlFL+0s//lzjvTiaOjM5J0bz8ADsje
 uFCKj3H1K4u/RthC/oQ==
X-Proofpoint-GUID: JSdaBfDOud9HIsD_OWMH2mksspKWru3u
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa896ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=UWCK2ViMfwJ6BMZbXdkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: JSdaBfDOud9HIsD_OWMH2mksspKWru3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150008
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/14/2026 4:50 PM, Taylor Simpson wrote:
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   target/hexagon/translate.h | 7 ++++++-
>   target/hexagon/translate.c | 5 +++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 9ee5f25365..b6cdf51c20 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -76,6 +76,7 @@ typedef struct DisasContext {
>       int qreg_log[NUM_QREGS];
>       int qreg_log_idx;
>       DECLARE_BITMAP(qregs_written, NUM_QREGS);
> +    DECLARE_BITMAP(qregs_multi_write, NUM_QREGS);
>       DECLARE_BITMAP(insn_qregs_written, NUM_QREGS);
>       DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
>       bool pre_commit;
> @@ -308,7 +309,11 @@ static inline void ctx_log_qreg_write(DisasContext *ctx,
>               ctx->has_hvx_overlap = true;
>           }
>       }
> -    set_bit(rnum, ctx->qregs_written);
> +    if (!test_bit(rnum, ctx->qregs_written)) {
> +        set_bit(rnum, ctx->qregs_written);
> +    } else {
> +        set_bit(rnum, ctx->qregs_multi_write);
> +    }
>       ctx->qreg_log[ctx->qreg_log_idx] = rnum;
>       ctx->qreg_log_idx++;
>   }
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index ca22bae28f..815eecb60a 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -593,6 +593,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
>       bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
>       bitmap_zero(ctx->qregs_written, NUM_QREGS);
> +    bitmap_zero(ctx->qregs_multi_write, NUM_QREGS);
>       ctx->qreg_log_idx = 0;
>       for (i = 0; i < STORES_MAX; i++) {
>           ctx->store_width[i] = 0;
> @@ -624,6 +625,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
>           return true;
>       }
>   
> +    if (!bitmap_empty(ctx->qregs_multi_write, NUM_QREGS)) {
> +        return true;
> +    }
> +
>       return false;
>   }
>   

