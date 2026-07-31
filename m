Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF042C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wph3u-0007T5-RF; Fri, 31 Jul 2026 02:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wph3s-0007Sb-Rb
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:49:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wph3q-0002nX-LG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:49:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V6glxU3140222
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aV9499miaokKje4uxfGrh+AyuYg2OfLjuDuINFSujCs=; b=ObhDy82iDmKL1PmV
 xckjZ3SAUJgdEBPNuXv/1CrDVYt79qIQCFtUrYJIpSaEVYoCbUjDPVnx/iQpBT+4
 f/MhQhWSL+VLtE5GXYuhRQ0AXT7rBN+mWP3Nnu0Q1QDDx7g53XPaknyfptHg1vmJ
 u6WTbXucd/zfDfVrKjcAR+7pOqGNsK5FN5CKrqOKGEigqc76Kp3T3xaLyNuC09J9
 OxWdme4ZZ0md24xX3CIbvxoNKA45toDr2QUwW60J91cPsCgHV1jQbC5BJQykuGsq
 GPfJxI7gI/jClJLqUkvKiCuP5xA3T2ElnsWWIABeDiGGFXhoAXUtvTpxdJH+fAli
 fCsy3Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frpp700v5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:49:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8fdace20927so6619426d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785480576; x=1786085376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aV9499miaokKje4uxfGrh+AyuYg2OfLjuDuINFSujCs=;
 b=NqQGmKXhHl1TFABF0h7NLdMSeRY+oosNuRgRh2DRfyD4nRC282vwsjxEBZoNjk4kGZ
 LW7rtUG36GrpsoIqNz70FM3dYQuZtBgUrty6Xd0WWhM95wc5YTgpyb9aZEO5PHysjFoX
 T7gJg0GCdvcu/FPDfk4agVJeRYRShTJQHSUOZ3cgP8uKsGg6TUuYAPpTnBIF7yWiQF3f
 15iVVEJxLUnLRUjlkyTvMWb1xF/5vIyzeX+8FSMy+Atq+QpyxUbTbwoKIrNMQCNmkSeI
 4XzXxAMfhC1pqj10mwe0a52LBDb/akBCv3faiMiFD10Km4Fwy7kNRt3FJilmFh8Jr8e/
 ijiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480576; x=1786085376;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aV9499miaokKje4uxfGrh+AyuYg2OfLjuDuINFSujCs=;
 b=mC3KQj3K5AjrliDwR058gPXhQ1xHnqyieLuTv6Zfg29b82lnFsokt0Hk8QSIw5KtVH
 keG/znPovNtQZeOKTIzK55HH/lKNi4F+2H4akXPe33jd5kaEsdv1JZtwKCaADxmgg85I
 Sf0NjCIvPKV6/VS19ZP/ZIVoDxo6pCZvZJU5E7vAn3YC41d2kXwBnZk8sRDhmcP/dGhh
 HRa9w0CYKz17z9pNj6U32GNs3CHvfCgUDV5qH+QWlkB9lPDk6fg4SPnSoy9yVKHS0Cp8
 13Ur5yxGarP05xlrwm6h0qHy2Ru7YdZQU2A4yi47xPOXcVrXnASQUym5nJ1XFWitp1w9
 8rkg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3otq+PNXFHtk2mid5AjUFoLX260+FiGIyABDdlrviN0oiUqMfSZGlRzJVX/BNbIRHvEjmHUie9IS5@nongnu.org
X-Gm-Message-State: AOJu0YxJzf8A6DEef4MNmPVVC/7U5dripuRd20E5t/Qvm0qzQxpcP9ss
 a7Vq4pKjk0APGY+Agm/BWV7vSgadCO5OMi86TlOCoXc8/epvaizUH3to9hedDL2sVxcgHZFqjPq
 3i6114sUuknPmoCJ0k5KKv5qLqrWtOGf0ywKRy7w58oXpU8KVhf6a2akQyw==
X-Gm-Gg: AR+sD11tww2mo1D7Kb/8X1kuwezvNgOOweSCrKZGuVUo0OyjxPyJJNAPEwN85IIvthT
 G12Wa31lEGMi13+og5myvyIDZEjHIwU3K6/MQhhVop4u/hHaIrr0l6D/dm3sxYS9g22LVqsZM5T
 /7lv15MAcCjFbBg6QuM1wl2DEoMH+JmPmkWy4Z22mc56HJAakvsc9AjkGiS+Qx+hMBWFsJk0ih0
 x+MjYv66IaPPqfOnbhP/wdgatj/nnMLmM0MNKUQrlQ/Ex4qUTVJo43XY9pPgA/PAabG2zxfUblu
 aEbyFvMnxERIyyOibmOt4C0cdmT9d9U0dSXtBdeqHgHlogt3cNr5UL0eEgOWTd1orNF3nl80FfU
 LOGqt9ciSNYxDakKka3tuIQ983+A49Al4N1ZN2MmyRhuQvIgE7lg=
X-Received: by 2002:a05:622a:4897:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-52b4af24401mr8224831cf.21.1785480575698; 
 Thu, 30 Jul 2026 23:49:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4897:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-52b4af24401mr8224631cf.21.1785480575305; 
 Thu, 30 Jul 2026 23:49:35 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2961sm1393239f8f.13.2026.07.30.23.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:49:34 -0700 (PDT)
Message-ID: <348faafd-2346-43dd-85d0-4ed7fe965ebb@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Add tcg_gen_revbit{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfX4VAt6QtT2jbb
 VJ73Hxty7O/mCqGNTQUNeF0kTwe2QFdcBDZqrJZTBSD6atYzoKR5ezMSf8XWbAM1x1hSWIihxHB
 4xJwSsyoojAf8lvHp6F2bHHRILv3SOr5AVGjU1H/oIl987O7lPSF24peRwClS9kFFbr7rOniRi8
 +jK/mgaAq9veSxqy1qTyo+WygelD5jRx+pKY0pmosdv2bs78UGZIxJiNabStmsY0H60k8kAfEFK
 7Hp7h6CordllSataQev4DCRAGNbTbKlpqXq8lpdOXt03Bet0YpxsUpbqd3xvjY+cNKYnpLBAL7v
 /JSV4stBmB088u78PoNCM2QwsuDMyn6GzsvJln0RjeWhIg6gPHD46NkjP0HRCBok7C2qGhVGOfz
 1rX4lPzhpOENlYbQQ64zKSPSne9+2YNV0XLufJgQ66g0TxYykUJIuQ8kD7V/G5FBWWvcL45jur9
 T6TE7LKwaoQum17YtqA==
X-Proofpoint-ORIG-GUID: ulymyZ3AUJmz98SByA3iaQub3ktEWFDc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfX8hd6elNu7hdQ
 ECJzd+0/H7qBcctO+4wt5ZRxZGRcXW6Fl423FkHKMZv0H9AotM04Tz7RzASdRcbjnvD0zLHv3Jc
 vYvRbdizq8KKn3CzBWyp4I0VRE4JOJg=
X-Proofpoint-GUID: ulymyZ3AUJmz98SByA3iaQub3ktEWFDc
X-Authority-Analysis: v=2.4 cv=AsXeGu9P c=1 sm=1 tr=0 ts=6a6c4580 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=CkTU4zPvt2Zb_C_0CqoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Richard,

On 31/7/26 02:04, Richard Henderson wrote:
> Add generic expanders for reversing bits within a word.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  3 ++
>   include/tcg/tcg-op.h        |  5 ++++
>   tcg/tcg-op.c                | 59 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
> 
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 1fe342db0d..91f59dc11e 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h

> @@ -275,6 +276,8 @@ void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
> +void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
> +void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);

Could the bswap flag be defined once per target?

- output sign-extended (TCG_BSWAP_OS):

   alpha, hppa, loongarch, m68k, mips, riscv, rx, sh4, tricore

- output zero-extended (TCG_BSWAP_OZ):

   arm, avr, hexagon, microblaze, openrisc, ppc, sparc, x86, xtensa

- input/output zero-extended (TCG_BSWAP_IZ | TCG_BSWAP_OZ):

   s390x

Having to manually encode it on each frontend doesn't sound optimal.

Note, we have some target-specific TCG information in TCGCPUOps
(useful at runtime for heterogeneous emulation).

