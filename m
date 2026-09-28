Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D8C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7wz-0003Eq-65; Mon, 28 Sep 2026 05:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7wo-0003EQ-3O
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:46:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7wm-0007f0-Gk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:46:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9ME64954452
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8d0cJu1XR1J+fXSsKfbp0d+6ehpAlc0zWeu2aMtadA=; b=SpTnzCpuwW3S7bL/
 gGTLdH5Jx7y7n1lZHgVX/hOaYdNNaXUgteoaxJhKuKSxDs0YpjjjuVif5phUcMyF
 GSPmXt6SMTuS8jxrQpM27pgacOSB0oW+LXvOm6V+wPALlm4S/+JcUMnoIbFkMkCh
 za1FpLwicLgrGCof1P8GkLOaMNXdrnHs/KtrtGV/Xn3uqu2pM70hNmryhfl1Jb5E
 H3UWq/7N2ct1XWJxctH2jJ7Sr+F/hU4WVMDR+T18kScdsh6Ec4l1StYH8Emd/X5W
 BzoF2DgF/jExyr65LDId5jAlaO4FambnX+kpaS8xvOunbF57lHZJuZdRKVQJuHL3
 NcJTGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc04kt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:46:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5328dae1305so29025011cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588814; x=1791193614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f8d0cJu1XR1J+fXSsKfbp0d+6ehpAlc0zWeu2aMtadA=;
 b=fPYTs96p6PT/5iSmmZwOs05JpmNxl+I7KNqLUc+5BYbgBqf824vg77YvCdtktVncLH
 QzVLRp3QexZMvfu/1xRBbzUnnQbn5TPIEFgPLmlgZUe/bSyypNCGe2hTfDQFStHzWvGF
 k3N6Kw1dahBciEsSPkwBL5FhCiR+9FsqMT8Vaw8PWE+BBpu1V9/YaSQvN4gZppgYbzjk
 +2ML+sXqQsL5x63OuAp2xXKZVSwuObbpgiPmz+t2F1IMBEQWNWgo1j6R7Y2xbg/Di8MV
 Gm4IkecgCXuPrAABG+2TsCu+tzPD2A0T3RU4ndtFRORSHsVbZyNhTEaLCRou4EZW0lmH
 aGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588814; x=1791193614;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8d0cJu1XR1J+fXSsKfbp0d+6ehpAlc0zWeu2aMtadA=;
 b=2ZUt3LL028cw6AAgRNiff5G2uOYvGJCtHj9OLQSyZB3+g7AcAcSNPRRcGdNhL2dl+8
 XzKG+/gFNkMKedTRr12k4reeJjIdFR2eVwPFvegrsyYFWcYu3NvUafqcKg84daf+5xGJ
 OuUbhpM8VXAeWCaxG4pb4ZFchYuxQH/IhlxDkvzHCPvVAxb3al/8LM5SJsVkQ8S9rScc
 CsM9+LcEC6RmqnOkkZws9/COwnnLsYPCRVedbXvpGScMZsIbDDkWpr+1GnA132Q5Nj/P
 7V4aymbr2WQ4Kr0YW61lnrNbinmK4lvaa5l3QsEruDHWAFp3gTMiNCjFKDBahqotprjt
 z6RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfWUaMmsLXljTuGRjXSTFxOvF8Aa9Ojh395dTmXop9+Uj4iIs/5HhHFLdIvRdOpNMR470rmnS+UPVr@nongnu.org
X-Gm-Message-State: AFuF++krVZXWNcMz0CEytyvfeeXZovxiFBYxpuyE+AorDht76fywtXwK
 wyOMSXm+rjvwxbQVBUCXXqG+DqOCRoJP+sDbaM1lfIwjm2F4pW57R+4wa7cudgowKlMDeUY+TfM
 PESPBjdUemiHBLnyNTOTuPkQ1qKJSojHgQzxCmmD5GclHrPmb/Cw9qJVorQ==
X-Gm-Gg: AYBFou0jTuKv5MF/G39/OQKfUXnNDAn8VmF6T2xhrMbFBkKWb9rKiRNNgZmtDnf9/qz
 MKV9AA+mxjWs2WQIh2hx61D0ERXsBzF4TACdzGSFSp+7+TCKFqjyN5Op5mHkhrU0TtOmM4U/tLD
 fjSf/Kk2fG0xxob4g3e/hf2qbbJKmH5vwPSvLPbEix2yPI9E379KSR34/9CjG3nUTJnp0YInaUM
 xOYSXoP6nTD9tqCXkyx7I1yXeAaf1TU//lDzyfIzsyz6Aegn/J5mgZBvzXJergiCiBJRS36M0cv
 coHtYRzc5oOHHo1H5vPatxzurWShIEXhhs4C5TR43FHsRJV1I7Al+PVAUAgfdjY0r7nWCrsO9LY
 5uJelg+kNf0/F899fttD501jw/M2yFgzc5g==
X-Received: by 2002:a05:620a:84c2:b0:939:744:b5a3 with SMTP id
 af79cd13be357-93c43d3e018mr1814036885a.29.1790588813917; 
 Mon, 28 Sep 2026 02:46:53 -0700 (PDT)
X-Received: by 2002:a05:620a:84c2:b0:939:744:b5a3 with SMTP id
 af79cd13be357-93c43d3e018mr1814035085a.29.1790588813563; 
 Mon, 28 Sep 2026 02:46:53 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018dd5easm127027135e9.3.2026.09.28.02.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:46:52 -0700 (PDT)
Message-ID: <47e7e33d-4d44-4fb4-b5f8-272e1e5ab04f@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 025/101] tcg: Generic expansion of tcg_gen_shli_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba378e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: A_vl5XNtU52RSXC4HnD2LodcequkWIDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX2wqV0+812Mfk
 nqYcdO7AoddsJ/Q+1dxDrlkIeqpgthTcqL+j11U6jae0L1F2P1df3y0krYXBr0ug4ejIzyzFO6A
 9XJsz2/8YXkQwr8BbsE8cju8YzJu8kcMmW5m5zVzk+9ErXVvOjvFMEZfnY4rCkvxS58Buh7AlRJ
 4vt4rUPLKlUADXfs3HkQoL2HGmL7+0bbw40nyd+xIt1pNVGFLFbretck8/08adeAgs3V4MSFRMZ
 UXM46XuvFBA4q+rB/8vBz1fAtqg4IJ2rpZh9OlUoig/Geoy8uIzuF9kH8eAExKSGLZHPJni+9hD
 Alf8oiI2dQgIfgbLIS1zDB0MQxq6ug9UWc2qEgp8UGVlZZxjcuhcKrQA/6ipqpbM1CMRN6Ht8ve
 YlRK5F3L17NXB55UIduDYreHpNBHrFNyAUchtLG+HD9zPLH1bSCdeePRMtGT5VleVciY3C9IERd
 n2wk2dRfV/+f4Oj9xiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXyvhw4BPzW/Wv
 y8U0QeIjjTjctfBHy1KgMTWFVmZGCsRBe9yfgpRSlYo330TsNLJZCQJQWvdd3b8iKUb8lCGV9XY
 LKeOuTdRDc3R73u1dKRsZtFVd3XQKIQ=
X-Proofpoint-ORIG-GUID: A_vl5XNtU52RSXC4HnD2LodcequkWIDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)


> +void tcg_gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
> +{
> +    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);

Can we add a tcg_type_bits() helper?

> +    if (src2 == 0) {
> +        tcg_gen_mov(type, dst, src1);
> +    } else {
> +        tcg_gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
> +    }
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


