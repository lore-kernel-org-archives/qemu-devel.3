Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD915CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 02:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGTRp-0000dr-2y; Tue, 04 Nov 2025 21:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGTRm-0000dI-Ja
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:40:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGTRf-0003wn-9s
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:40:30 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4KfmVx2978792
 for <qemu-devel@nongnu.org>; Wed, 5 Nov 2025 02:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/Jeda2SeXlnaVSaGlKH7jE+c
 qZkH7RlZ8vZUhcAlahI=; b=NcfAYvOePLspExbzB/TrjVi1s1ecIacGOZQr3vQL
 yKISUgqBpFttmIQN1mRJQhzmZ94WnlNUppketwJSmH1bWpVGYdaIzm7/7itvooxN
 uqPCRWiDGKG282j52+aJ9lpdFUueuF6vYMIRctiQmqDB9xtlEbkkXltenCfz2wCE
 KuBe1R8SB0iB7rzihU8Azbp3rSR679PtnM/WvqxDv7IlkcDNqQXzdfyMUa2nyzzT
 VXCyglw4EGEI6xTBNmonT+r17vSKwdM9B/hMZOO//G4JScMkMxS+1r4AyFJnx/sD
 dD1Vo7hzsbSUkMyy3vzK3g0TOTXCrxNKxo5g0Qya2BF3OA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7hbjtapq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 02:40:20 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5db1ec1daa9so916948137.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762310420; x=1762915220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Jeda2SeXlnaVSaGlKH7jE+cqZkH7RlZ8vZUhcAlahI=;
 b=gtDVbt/Fr6tWf5/7xjibuxyVZmtwVmzC+Rwx8mfaiZafWD8AFyCt0R+5oiobw7IZ80
 4zB+PmQ9Shw0T8q+QCjwk6ifN7X54pta6ke+ptDka4ZNrtO0iEH6xAv1WwT1HeA7D488
 iYdpBEFMuS0FAIEPbDgc5xo1fVSKaT3Rkn7FqvuaRWpIr2sjfidKniMIyjeI83BKfTTr
 eDkfHk41Br9Xmp/c66p3wJVR96BnV04wLVT47EZRJvl7cJOAi7AYTH81uoYC599oO6so
 Linq4MJJ3vwwOI7OgPC1DWTWyFhpSSzPvLBna6HYIBez8Ug9Ut6fASseU+awIw/CVP0i
 oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762310420; x=1762915220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Jeda2SeXlnaVSaGlKH7jE+cqZkH7RlZ8vZUhcAlahI=;
 b=Qqip6UrzFSQbuYQxFWjv6y+HczvafV6CiWm/lv5dhkiDI3VQzBOZ6BIPkDlJYBvua4
 AiePJoVSeH09sDYNZCiLyfPFU7zhMfeXbKv6LaTkCMgYFvU0BOmipTioXCqek5dy39zI
 VJe164+mLZ92sp2u/+0FGmcdKdeQn4daxc9X16FOaYTLfivEIDU3XU70zi6jBV9mDInT
 6CE68ARGc76h2/PZFuClT9dpPED6rJCiomEePRJxQA1bFxKs2h/fmgd4EYc560s1ivUb
 Yera1Jak82GgpELOVDJJqlOBqWM5lklfqCVVU/NESlqCUG84yVTR323oBZUTESAGSyfg
 t7xg==
X-Gm-Message-State: AOJu0YylMn+QeV4WyfaNnE2vT85BfFruMtu9Mv870GzkERtDXaVbIh/n
 740VvrIUJaxg3iKP6guQf8TagzOM6vhkOBEwXvfSQmw66mNVks4e3NtNmxYltF6HtY+Y4DcpwG4
 ENdchO2Lib+lmWKFqgDAJ44RL7Yr3XJTa2KhMle1wmrRCj7O5Qf96cVPn7go4IfGoxxvwo3bdmp
 QEVu6uX+gk7KpkcLBch7FG7Gx0EOwmu5Z/
X-Gm-Gg: ASbGncuN7NeePHMX62oYy+SkKcyii1oEy2C4JsPZhYwI08+YwZb3/Ir1x54Z0KLV35a
 suCfXPccCxvKN5qZcVKzjE4qu8AGbwA2r4eXLbtO7HorJCHzm6kja+uMd2d46OOh2SE80P8lh0u
 dTQXlfylslAU7kmmgj0X2iH61cngYczjag+8i84EfC1xaGtyYTCjM5gW0GllBy+EDQfCowN8tiK
 LSNFXD4Ee2VYbSQOw==
X-Received: by 2002:a05:6102:510a:b0:5db:f031:84c7 with SMTP id
 ada2fe7eead31-5dd8923c01fmr587208137.30.1762310419294; 
 Tue, 04 Nov 2025 18:40:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw+hwpCDUsf78VCvc5F24uSc0xaVrDGg01vzsH93Xp5HH733cw+HzU7NnkeWsQYTDp20vDsZHZ4+X6wuLLpyE=
X-Received: by 2002:a05:6102:510a:b0:5db:f031:84c7 with SMTP id
 ada2fe7eead31-5dd8923c01fmr587199137.30.1762310418562; Tue, 04 Nov 2025
 18:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
 <20251104222548.108264-2-ltaylorsimpson@gmail.com>
In-Reply-To: <20251104222548.108264-2-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 20:40:06 -0600
X-Gm-Features: AWmQ_blvy9kocF_nBdr1Qmnn5BPPDKwsnQRfYo2ZGqL5z9MOEMXm5Lgp8C-5BMQ
Message-ID: <CAEqNhNbKn4bj5Nb_SzKWpYpeRhLp-zf=QVDbuOnRJsTC7aWq_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Hexagon (target/hexagon) Add pkt_need_commit
 argument to arch_fpop_end
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000007b8e130642cfdeb2"
X-Authority-Analysis: v=2.4 cv=Uv5u9uwB c=1 sm=1 tr=0 ts=690ab915 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=xTqcJ6J2rWbyfoXjtpEA:9 a=QEXdDO2ut3YA:10 a=NrRhmnfNmRTcEjZxUMQA:9
 a=u1kn_rKUJCvUMetH:21 a=lqcHg5cX4UMA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: fNg9ldMHuVT7_hCtc48eS2z9DzPZjnJZ
X-Proofpoint-GUID: fNg9ldMHuVT7_hCtc48eS2z9DzPZjnJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNSBTYWx0ZWRfX2z8Sr8IizZaZ
 k2f7Vh7b3i7baZRNew2iCDsQ4X62bShx2Th65BPeylohnCagTUxSyMqAG1ySi+eI2udsmmoIC51
 zZgJVOtMXnYKuekiKtmdxp1EIfReeXtu+G0+iW4sf3jOI0ulRTIJgbqKklTuvG/bbo7BzAXT8P7
 MMK+nOiUO9fnCoSJGRYgh5ETXZ6Gh9fdzWvy+bTjZeQxvNGw5HA2kRxBqL1A78SupT/31C4FUGW
 Mu+uWULzarYH81k2bP3EUepJkA/qZPlW3tj38uaaimWpsNfpiocsFXb8LbKe3FtLqsCO7PsKcfK
 bZO26NBeUeuGi6i8dj3CbSofpH2fIC3IUdwKmmtaYgiP7cfWeVlSVQLvSFHRFeZtlHmPYhrAEWf
 RWb2bGe9P4IyyPPuqz6OUl79+9+Xqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050015
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007b8e130642cfdeb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:25=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com>
wrote:

> The arch_fpop_end function converts the softfloat fp_status flags to
> bits set in Hexagon USR.  It is hard-coded that the packet must need
> a commit.  We add an argument to the function and update all the helper
> call sites.
>
> In a subsequent commit, we will change the code that forces a commit
> when the packet contains an floating point instruction.
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



>  target/hexagon/arch.h              |   2 +-
>  target/hexagon/gen_tcg.h           | 114 ++++++------
>  target/hexagon/helper.h            | 114 ++++++------
>  target/hexagon/arch.c              |   3 +-
>  target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
>  target/hexagon/gen_helper_funcs.py |   8 +-
>  target/hexagon/gen_tcg_funcs.py    |   4 +
>  7 files changed, 294 insertions(+), 238 deletions(-)
>
> diff --git a/target/hexagon/arch.h b/target/hexagon/arch.h
> index 70918065d3..c295a86600 100644
> --- a/target/hexagon/arch.h
> +++ b/target/hexagon/arch.h
> @@ -28,7 +28,7 @@ uint64_t interleave(uint32_t odd, uint32_t even);
>  uint64_t deinterleave(uint64_t src);
>  int32_t conv_round(int32_t a, int n);
>  void arch_fpop_start(CPUHexagonState *env);
> -void arch_fpop_end(CPUHexagonState *env);
> +void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit);
>  int arch_sf_recip_common(float32 *Rs, float32 *Rt, float32 *Rd,
>                           int *adjust, float_status *fp_status);
>  int arch_sf_invsqrt_common(float32 *Rs, float32 *Rd, int *adjust,
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 8a3b801287..f17eac2f1a 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -613,7 +613,7 @@
>  #define fGEN_TCG_F2_sfrecipa(SHORTCODE) \
>      do { \
>          TCGv_i64 tmp =3D tcg_temp_new_i64(); \
> -        gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV);  \
> +        gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV, pkt_need_commit);  \
>          tcg_gen_extrh_i64_i32(RdV, tmp); \
>          tcg_gen_extrl_i64_i32(PeV, tmp); \
>      } while (0)
> @@ -628,7 +628,7 @@
>  #define fGEN_TCG_F2_sfinvsqrta(SHORTCODE) \
>      do { \
>          TCGv_i64 tmp =3D tcg_temp_new_i64(); \
> -        gen_helper_sfinvsqrta(tmp, tcg_env, RsV); \
> +        gen_helper_sfinvsqrta(tmp, tcg_env, RsV, pkt_need_commit); \
>          tcg_gen_extrh_i64_i32(RdV, tmp); \
>          tcg_gen_extrl_i64_i32(PeV, tmp); \
>      } while (0)
> @@ -1204,122 +1204,122 @@
>
>  /* Floating point */
>  #define fGEN_TCG_F2_conv_sf2df(SHORTCODE) \
> -    gen_helper_conv_sf2df(RddV, tcg_env, RsV)
> +    gen_helper_conv_sf2df(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2sf(SHORTCODE) \
> -    gen_helper_conv_df2sf(RdV, tcg_env, RssV)
> +    gen_helper_conv_df2sf(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_uw2sf(SHORTCODE) \
> -    gen_helper_conv_uw2sf(RdV, tcg_env, RsV)
> +    gen_helper_conv_uw2sf(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_uw2df(SHORTCODE) \
> -    gen_helper_conv_uw2df(RddV, tcg_env, RsV)
> +    gen_helper_conv_uw2df(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_w2sf(SHORTCODE) \
> -    gen_helper_conv_w2sf(RdV, tcg_env, RsV)
> +    gen_helper_conv_w2sf(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_w2df(SHORTCODE) \
> -    gen_helper_conv_w2df(RddV, tcg_env, RsV)
> +    gen_helper_conv_w2df(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_ud2sf(SHORTCODE) \
> -    gen_helper_conv_ud2sf(RdV, tcg_env, RssV)
> +    gen_helper_conv_ud2sf(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_ud2df(SHORTCODE) \
> -    gen_helper_conv_ud2df(RddV, tcg_env, RssV)
> +    gen_helper_conv_ud2df(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_d2sf(SHORTCODE) \
> -    gen_helper_conv_d2sf(RdV, tcg_env, RssV)
> +    gen_helper_conv_d2sf(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_d2df(SHORTCODE) \
> -    gen_helper_conv_d2df(RddV, tcg_env, RssV)
> +    gen_helper_conv_d2df(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2uw(SHORTCODE) \
> -    gen_helper_conv_sf2uw(RdV, tcg_env, RsV)
> +    gen_helper_conv_sf2uw(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2w(SHORTCODE) \
> -    gen_helper_conv_sf2w(RdV, tcg_env, RsV)
> +    gen_helper_conv_sf2w(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2ud(SHORTCODE) \
> -    gen_helper_conv_sf2ud(RddV, tcg_env, RsV)
> +    gen_helper_conv_sf2ud(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2d(SHORTCODE) \
> -    gen_helper_conv_sf2d(RddV, tcg_env, RsV)
> +    gen_helper_conv_sf2d(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2uw(SHORTCODE) \
> -    gen_helper_conv_df2uw(RdV, tcg_env, RssV)
> +    gen_helper_conv_df2uw(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2w(SHORTCODE) \
> -    gen_helper_conv_df2w(RdV, tcg_env, RssV)
> +    gen_helper_conv_df2w(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2ud(SHORTCODE) \
> -    gen_helper_conv_df2ud(RddV, tcg_env, RssV)
> +    gen_helper_conv_df2ud(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2d(SHORTCODE) \
> -    gen_helper_conv_df2d(RddV, tcg_env, RssV)
> +    gen_helper_conv_df2d(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2uw_chop(SHORTCODE) \
> -    gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV)
> +    gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2w_chop(SHORTCODE) \
> -    gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV)
> +    gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2ud_chop(SHORTCODE) \
> -    gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV)
> +    gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_sf2d_chop(SHORTCODE) \
> -    gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV)
> +    gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2uw_chop(SHORTCODE) \
> -    gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV)
> +    gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2w_chop(SHORTCODE) \
> -    gen_helper_conv_df2w_chop(RdV, tcg_env, RssV)
> +    gen_helper_conv_df2w_chop(RdV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2ud_chop(SHORTCODE) \
> -    gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV)
> +    gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_conv_df2d_chop(SHORTCODE) \
> -    gen_helper_conv_df2d_chop(RddV, tcg_env, RssV)
> +    gen_helper_conv_df2d_chop(RddV, tcg_env, RssV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfadd(SHORTCODE) \
> -    gen_helper_sfadd(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sfadd(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfsub(SHORTCODE) \
> -    gen_helper_sfsub(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sfsub(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfcmpeq(SHORTCODE) \
> -    gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV)
> +    gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfcmpgt(SHORTCODE) \
> -    gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV)
> +    gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfcmpge(SHORTCODE) \
> -    gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV)
> +    gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfcmpuo(SHORTCODE) \
> -    gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV)
> +    gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfmax(SHORTCODE) \
> -    gen_helper_sfmax(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sfmax(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfmin(SHORTCODE) \
> -    gen_helper_sfmin(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sfmin(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sfclass(SHORTCODE) \
>      do { \
>          TCGv imm =3D tcg_constant_tl(uiV); \
> -        gen_helper_sfclass(PdV, tcg_env, RsV, imm); \
> +        gen_helper_sfclass(PdV, tcg_env, RsV, imm, pkt_need_commit); \
>      } while (0)
>  #define fGEN_TCG_F2_sffixupn(SHORTCODE) \
> -    gen_helper_sffixupn(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sffixupn(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffixupd(SHORTCODE) \
> -    gen_helper_sffixupd(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sffixupd(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffixupr(SHORTCODE) \
> -    gen_helper_sffixupr(RdV, tcg_env, RsV)
> +    gen_helper_sffixupr(RdV, tcg_env, RsV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfadd(SHORTCODE) \
> -    gen_helper_dfadd(RddV, tcg_env, RssV, RttV)
> +    gen_helper_dfadd(RddV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfsub(SHORTCODE) \
> -    gen_helper_dfsub(RddV, tcg_env, RssV, RttV)
> +    gen_helper_dfsub(RddV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfmax(SHORTCODE) \
> -    gen_helper_dfmax(RddV, tcg_env, RssV, RttV)
> +    gen_helper_dfmax(RddV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfmin(SHORTCODE) \
> -    gen_helper_dfmin(RddV, tcg_env, RssV, RttV)
> +    gen_helper_dfmin(RddV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfcmpeq(SHORTCODE) \
> -    gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV)
> +    gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfcmpgt(SHORTCODE) \
> -    gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV)
> +    gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfcmpge(SHORTCODE) \
> -    gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV)
> +    gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfcmpuo(SHORTCODE) \
> -    gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV)
> +    gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfclass(SHORTCODE) \
>      do { \
>          TCGv imm =3D tcg_constant_tl(uiV); \
> -        gen_helper_dfclass(PdV, tcg_env, RssV, imm); \
> +        gen_helper_dfclass(PdV, tcg_env, RssV, imm, pkt_need_commit); \
>      } while (0)
>  #define fGEN_TCG_F2_sfmpy(SHORTCODE) \
> -    gen_helper_sfmpy(RdV, tcg_env, RsV, RtV)
> +    gen_helper_sfmpy(RdV, tcg_env, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffma(SHORTCODE) \
> -    gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV)
> +    gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffma_sc(SHORTCODE) \
> -    gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV)
> +    gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV, pkt_need_commi=
t)
>  #define fGEN_TCG_F2_sffms(SHORTCODE) \
> -    gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV)
> +    gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffma_lib(SHORTCODE) \
> -    gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV)
> +    gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
>  #define fGEN_TCG_F2_sffms_lib(SHORTCODE) \
> -    gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV)
> +    gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
>
>  #define fGEN_TCG_F2_dfmpyfix(SHORTCODE) \
> -    gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV)
> +    gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV, pkt_need_commit)
>  #define fGEN_TCG_F2_dfmpyhh(SHORTCODE) \
> -    gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV)
> +    gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV, pkt_need_commit)
>
>  /* Nothing to do for these in qemu, need to suppress compiler warnings *=
/
>  #define fGEN_TCG_Y4_l2fetch(SHORTCODE) \
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index f8baa599c8..64456822bc 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -24,72 +24,72 @@ DEF_HELPER_3(gather_store, void, env, i32, int)
>  DEF_HELPER_1(commit_hvx_stores, void, env)
>  DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32=
)
>  DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
> -DEF_HELPER_3(sfrecipa, i64, env, f32, f32)
> -DEF_HELPER_2(sfinvsqrta, i64, env, f32)
> +DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
> +DEF_HELPER_3(sfinvsqrta, i64, env, f32, i32)
>  DEF_HELPER_5(vacsh_val, s64, env, s64, s64, s64, i32)
>  DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32, env, s64, s64,
> s64)
>  DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>  DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
>
>  /* Floating point */
> -DEF_HELPER_2(conv_sf2df, f64, env, f32)
> -DEF_HELPER_2(conv_df2sf, f32, env, f64)
> -DEF_HELPER_2(conv_uw2sf, f32, env, s32)
> -DEF_HELPER_2(conv_uw2df, f64, env, s32)
> -DEF_HELPER_2(conv_w2sf, f32, env, s32)
> -DEF_HELPER_2(conv_w2df, f64, env, s32)
> -DEF_HELPER_2(conv_ud2sf, f32, env, s64)
> -DEF_HELPER_2(conv_ud2df, f64, env, s64)
> -DEF_HELPER_2(conv_d2sf, f32, env, s64)
> -DEF_HELPER_2(conv_d2df, f64, env, s64)
> -DEF_HELPER_2(conv_sf2uw, i32, env, f32)
> -DEF_HELPER_2(conv_sf2w, s32, env, f32)
> -DEF_HELPER_2(conv_sf2ud, i64, env, f32)
> -DEF_HELPER_2(conv_sf2d, s64, env, f32)
> -DEF_HELPER_2(conv_df2uw, i32, env, f64)
> -DEF_HELPER_2(conv_df2w, s32, env, f64)
> -DEF_HELPER_2(conv_df2ud, i64, env, f64)
> -DEF_HELPER_2(conv_df2d, s64, env, f64)
> -DEF_HELPER_2(conv_sf2uw_chop, i32, env, f32)
> -DEF_HELPER_2(conv_sf2w_chop, s32, env, f32)
> -DEF_HELPER_2(conv_sf2ud_chop, i64, env, f32)
> -DEF_HELPER_2(conv_sf2d_chop, s64, env, f32)
> -DEF_HELPER_2(conv_df2uw_chop, i32, env, f64)
> -DEF_HELPER_2(conv_df2w_chop, s32, env, f64)
> -DEF_HELPER_2(conv_df2ud_chop, i64, env, f64)
> -DEF_HELPER_2(conv_df2d_chop, s64, env, f64)
> -DEF_HELPER_3(sfadd, f32, env, f32, f32)
> -DEF_HELPER_3(sfsub, f32, env, f32, f32)
> -DEF_HELPER_3(sfcmpeq, s32, env, f32, f32)
> -DEF_HELPER_3(sfcmpgt, s32, env, f32, f32)
> -DEF_HELPER_3(sfcmpge, s32, env, f32, f32)
> -DEF_HELPER_3(sfcmpuo, s32, env, f32, f32)
> -DEF_HELPER_3(sfmax, f32, env, f32, f32)
> -DEF_HELPER_3(sfmin, f32, env, f32, f32)
> -DEF_HELPER_3(sfclass, s32, env, f32, s32)
> -DEF_HELPER_3(sffixupn, f32, env, f32, f32)
> -DEF_HELPER_3(sffixupd, f32, env, f32, f32)
> -DEF_HELPER_2(sffixupr, f32, env, f32)
> +DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
> +DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
> +DEF_HELPER_3(conv_uw2sf, f32, env, s32, i32)
> +DEF_HELPER_3(conv_uw2df, f64, env, s32, i32)
> +DEF_HELPER_3(conv_w2sf, f32, env, s32, i32)
> +DEF_HELPER_3(conv_w2df, f64, env, s32, i32)
> +DEF_HELPER_3(conv_ud2sf, f32, env, s64, i32)
> +DEF_HELPER_3(conv_ud2df, f64, env, s64, i32)
> +DEF_HELPER_3(conv_d2sf, f32, env, s64, i32)
> +DEF_HELPER_3(conv_d2df, f64, env, s64, i32)
> +DEF_HELPER_3(conv_sf2uw, i32, env, f32, i32)
> +DEF_HELPER_3(conv_sf2w, s32, env, f32, i32)
> +DEF_HELPER_3(conv_sf2ud, i64, env, f32, i32)
> +DEF_HELPER_3(conv_sf2d, s64, env, f32, i32)
> +DEF_HELPER_3(conv_df2uw, i32, env, f64, i32)
> +DEF_HELPER_3(conv_df2w, s32, env, f64, i32)
> +DEF_HELPER_3(conv_df2ud, i64, env, f64, i32)
> +DEF_HELPER_3(conv_df2d, s64, env, f64, i32)
> +DEF_HELPER_3(conv_sf2uw_chop, i32, env, f32, i32)
> +DEF_HELPER_3(conv_sf2w_chop, s32, env, f32, i32)
> +DEF_HELPER_3(conv_sf2ud_chop, i64, env, f32, i32)
> +DEF_HELPER_3(conv_sf2d_chop, s64, env, f32, i32)
> +DEF_HELPER_3(conv_df2uw_chop, i32, env, f64, i32)
> +DEF_HELPER_3(conv_df2w_chop, s32, env, f64, i32)
> +DEF_HELPER_3(conv_df2ud_chop, i64, env, f64, i32)
> +DEF_HELPER_3(conv_df2d_chop, s64, env, f64, i32)
> +DEF_HELPER_4(sfadd, f32, env, f32, f32, i32)
> +DEF_HELPER_4(sfsub, f32, env, f32, f32, i32)
> +DEF_HELPER_4(sfcmpeq, s32, env, f32, f32, i32)
> +DEF_HELPER_4(sfcmpgt, s32, env, f32, f32, i32)
> +DEF_HELPER_4(sfcmpge, s32, env, f32, f32, i32)
> +DEF_HELPER_4(sfcmpuo, s32, env, f32, f32, i32)
> +DEF_HELPER_4(sfmax, f32, env, f32, f32, i32)
> +DEF_HELPER_4(sfmin, f32, env, f32, f32, i32)
> +DEF_HELPER_4(sfclass, s32, env, f32, s32, i32)
> +DEF_HELPER_4(sffixupn, f32, env, f32, f32, i32)
> +DEF_HELPER_4(sffixupd, f32, env, f32, f32, i32)
> +DEF_HELPER_3(sffixupr, f32, env, f32, i32)
>
> -DEF_HELPER_3(dfadd, f64, env, f64, f64)
> -DEF_HELPER_3(dfsub, f64, env, f64, f64)
> -DEF_HELPER_3(dfmax, f64, env, f64, f64)
> -DEF_HELPER_3(dfmin, f64, env, f64, f64)
> -DEF_HELPER_3(dfcmpeq, s32, env, f64, f64)
> -DEF_HELPER_3(dfcmpgt, s32, env, f64, f64)
> -DEF_HELPER_3(dfcmpge, s32, env, f64, f64)
> -DEF_HELPER_3(dfcmpuo, s32, env, f64, f64)
> -DEF_HELPER_3(dfclass, s32, env, f64, s32)
> +DEF_HELPER_4(dfadd, f64, env, f64, f64, i32)
> +DEF_HELPER_4(dfsub, f64, env, f64, f64, i32)
> +DEF_HELPER_4(dfmax, f64, env, f64, f64, i32)
> +DEF_HELPER_4(dfmin, f64, env, f64, f64, i32)
> +DEF_HELPER_4(dfcmpeq, s32, env, f64, f64, i32)
> +DEF_HELPER_4(dfcmpgt, s32, env, f64, f64, i32)
> +DEF_HELPER_4(dfcmpge, s32, env, f64, f64, i32)
> +DEF_HELPER_4(dfcmpuo, s32, env, f64, f64, i32)
> +DEF_HELPER_4(dfclass, s32, env, f64, s32, i32)
>
> -DEF_HELPER_3(sfmpy, f32, env, f32, f32)
> -DEF_HELPER_4(sffma, f32, env, f32, f32, f32)
> -DEF_HELPER_5(sffma_sc, f32, env, f32, f32, f32, f32)
> -DEF_HELPER_4(sffms, f32, env, f32, f32, f32)
> -DEF_HELPER_4(sffma_lib, f32, env, f32, f32, f32)
> -DEF_HELPER_4(sffms_lib, f32, env, f32, f32, f32)
> +DEF_HELPER_4(sfmpy, f32, env, f32, f32, i32)
> +DEF_HELPER_5(sffma, f32, env, f32, f32, f32, i32)
> +DEF_HELPER_6(sffma_sc, f32, env, f32, f32, f32, f32, i32)
> +DEF_HELPER_5(sffms, f32, env, f32, f32, f32, i32)
> +DEF_HELPER_5(sffma_lib, f32, env, f32, f32, f32, i32)
> +DEF_HELPER_5(sffms_lib, f32, env, f32, f32, f32, i32)
>
> -DEF_HELPER_3(dfmpyfix, f64, env, f64, f64)
> -DEF_HELPER_4(dfmpyhh, f64, env, f64, f64, f64)
> +DEF_HELPER_4(dfmpyfix, f64, env, f64, f64, i32)
> +DEF_HELPER_5(dfmpyhh, f64, env, f64, f64, f64, i32)
>
>  /* Histogram instructions */
>  DEF_HELPER_1(vhist, void, env)
> diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
> index d053d68487..e17e714a6a 100644
> --- a/target/hexagon/arch.c
> +++ b/target/hexagon/arch.c
> @@ -222,9 +222,8 @@ void arch_fpop_start(CPUHexagonState *env)
>          } \
>      } while (0)
>
> -void arch_fpop_end(CPUHexagonState *env)
> +void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit)
>  {
> -    const bool pkt_need_commit =3D true;
>      int flags =3D get_float_exception_flags(&env->fp_status);
>      if (flags !=3D 0) {
>          SOFTFLOAT_TEST_FLAG(float_flag_inexact, FPINPF, FPINPE);
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index e2e80ca7ef..554e7dd447 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -200,7 +200,8 @@ static float32 build_float32(uint8_t sign, uint32_t
> exp, uint32_t mant)
>   * Since helpers can only return a single value, we pack the two results
>   * into a 64-bit value.
>   */
> -uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV=
)
> +uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV=
,
> +                          uint32_t pkt_need_commit)
>  {
>      int32_t PeV =3D 0;
>      float32 RdV;
> @@ -217,11 +218,12 @@ uint64_t HELPER(sfrecipa)(CPUHexagonState *env,
> float32 RsV, float32 RtV)
>          exp =3D SF_BIAS - (float32_getexp(RtV) - SF_BIAS) - 1;
>          RdV =3D build_float32(extract32(RtV, 31, 1), exp, mant);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return ((uint64_t)RdV << 32) | PeV;
>  }
>
> -uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV)
> +uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV,
> +                            uint32_t pkt_need_commit)
>  {
>      int PeV =3D 0;
>      float32 RdV;
> @@ -238,7 +240,7 @@ uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env,
> float32 RsV)
>          exp =3D SF_BIAS - ((float32_getexp(RsV) - SF_BIAS) >> 1) - 1;
>          RdV =3D build_float32(extract32(RsV, 31, 1), exp, mant);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return ((uint64_t)RdV << 32) | PeV;
>  }
>
> @@ -476,97 +478,108 @@ static void check_noshuf(CPUHexagonState *env, boo=
l
> pkt_has_scalar_store_s1,
>  #endif
>
>  /* Floating point */
> -float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV)
> +float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV,
> +                           uint32_t pkt_need_commit)
>  {
>      float64 out_f64;
>      arch_fpop_start(env);
>      out_f64 =3D float32_to_float64(RsV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return out_f64;
>  }
>
> -float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV)
> +float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV,
> +                           uint32_t pkt_need_commit)
>  {
>      float32 out_f32;
>      arch_fpop_start(env);
>      out_f32 =3D float64_to_float32(RssV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return out_f32;
>  }
>
> -float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV)
> +float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV,
> +                           uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D uint32_to_float32(RsV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV)
> +float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV,
> +                           uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D uint32_to_float64(RsV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV)
> +float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV,
> +                          uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D int32_to_float32(RsV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV)
> +float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV,
> +                          uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D int32_to_float64(RsV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV)
> +float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV,
> +                           uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D uint64_to_float32(RssV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV)
> +float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV,
> +                           uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D uint64_to_float64(RssV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV)
> +float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV,
> +                          uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D int64_to_float32(RssV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV)
> +float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV,
> +                          uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D int64_to_float64(RssV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)
> +uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV,
> +                            uint32_t pkt_need_commit)
>  {
>      uint32_t RdV;
>      arch_fpop_start(env);
> @@ -577,11 +590,12 @@ uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env,
> float32 RsV)
>      } else {
>          RdV =3D float32_to_uint32(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV)
> +int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV,
> +                          uint32_t pkt_need_commit)
>  {
>      int32_t RdV;
>      arch_fpop_start(env);
> @@ -592,11 +606,12 @@ int32_t HELPER(conv_sf2w)(CPUHexagonState *env,
> float32 RsV)
>      } else {
>          RdV =3D float32_to_int32(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)
> +uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV,
> +                            uint32_t pkt_need_commit)
>  {
>      uint64_t RddV;
>      arch_fpop_start(env);
> @@ -607,11 +622,12 @@ uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env,
> float32 RsV)
>      } else {
>          RddV =3D float32_to_uint64(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV)
> +int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV,
> +                          uint32_t pkt_need_commit)
>  {
>      int64_t RddV;
>      arch_fpop_start(env);
> @@ -622,11 +638,12 @@ int64_t HELPER(conv_sf2d)(CPUHexagonState *env,
> float32 RsV)
>      } else {
>          RddV =3D float32_to_int64(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)
> +uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV,
> +                            uint32_t pkt_need_commit)
>  {
>      uint32_t RdV;
>      arch_fpop_start(env);
> @@ -637,11 +654,12 @@ uint32_t HELPER(conv_df2uw)(CPUHexagonState *env,
> float64 RssV)
>      } else {
>          RdV =3D float64_to_uint32(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV)
> +int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV,
> +                          uint32_t pkt_need_commit)
>  {
>      int32_t RdV;
>      arch_fpop_start(env);
> @@ -652,11 +670,12 @@ int32_t HELPER(conv_df2w)(CPUHexagonState *env,
> float64 RssV)
>      } else {
>          RdV =3D float64_to_int32(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)
> +uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV,
> +                            uint32_t pkt_need_commit)
>  {
>      uint64_t RddV;
>      arch_fpop_start(env);
> @@ -667,11 +686,12 @@ uint64_t HELPER(conv_df2ud)(CPUHexagonState *env,
> float64 RssV)
>      } else {
>          RddV =3D float64_to_uint64(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV)
> +int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV,
> +                          uint32_t pkt_need_commit)
>  {
>      int64_t RddV;
>      arch_fpop_start(env);
> @@ -682,11 +702,12 @@ int64_t HELPER(conv_df2d)(CPUHexagonState *env,
> float64 RssV)
>      } else {
>          RddV =3D float64_to_int64(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)
> +uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV,
> +                                 uint32_t pkt_need_commit)
>  {
>      uint32_t RdV;
>      arch_fpop_start(env);
> @@ -697,11 +718,12 @@ uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState
> *env, float32 RsV)
>      } else {
>          RdV =3D float32_to_uint32_round_to_zero(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV)
> +int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV,
> +                               uint32_t pkt_need_commit)
>  {
>      int32_t RdV;
>      arch_fpop_start(env);
> @@ -712,11 +734,12 @@ int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env=
,
> float32 RsV)
>      } else {
>          RdV =3D float32_to_int32_round_to_zero(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)
> +uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV,
> +                                 uint32_t pkt_need_commit)
>  {
>      uint64_t RddV;
>      arch_fpop_start(env);
> @@ -727,11 +750,12 @@ uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState
> *env, float32 RsV)
>      } else {
>          RddV =3D float32_to_uint64_round_to_zero(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV)
> +int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV,
> +                               uint32_t pkt_need_commit)
>  {
>      int64_t RddV;
>      arch_fpop_start(env);
> @@ -742,11 +766,12 @@ int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env=
,
> float32 RsV)
>      } else {
>          RddV =3D float32_to_int64_round_to_zero(RsV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)
> +uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV,
> +                                 uint32_t pkt_need_commit)
>  {
>      uint32_t RdV;
>      arch_fpop_start(env);
> @@ -757,11 +782,12 @@ uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState
> *env, float64 RssV)
>      } else {
>          RdV =3D float64_to_uint32_round_to_zero(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV)
> +int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV,
> +                               uint32_t pkt_need_commit)
>  {
>      int32_t RdV;
>      arch_fpop_start(env);
> @@ -772,11 +798,12 @@ int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env=
,
> float64 RssV)
>      } else {
>          RdV =3D float64_to_int32_round_to_zero(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)
> +uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV,
> +                                 uint32_t pkt_need_commit)
>  {
>      uint64_t RddV;
>      arch_fpop_start(env);
> @@ -787,11 +814,12 @@ uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState
> *env, float64 RssV)
>      } else {
>          RddV =3D float64_to_uint64_round_to_zero(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV)
> +int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV,
> +                               uint32_t pkt_need_commit)
>  {
>      int64_t RddV;
>      arch_fpop_start(env);
> @@ -802,49 +830,54 @@ int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env=
,
> float64 RssV)
>      } else {
>          RddV =3D float64_to_int64_round_to_zero(RssV, &env->fp_status);
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D float32_add(RsV, RtV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D float32_sub(RsV, RtV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV;
>      arch_fpop_start(env);
>      PdV =3D f8BITSOF(float32_eq_quiet(RsV, RtV, &env->fp_status));
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                        uint32_t pkt_need_commit)
>  {
>      int cmp;
>      int32_t PdV;
>      arch_fpop_start(env);
>      cmp =3D float32_compare_quiet(RsV, RtV, &env->fp_status);
>      PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                        uint32_t pkt_need_commit)
>  {
>      int cmp;
>      int32_t PdV;
> @@ -852,38 +885,42 @@ int32_t HELPER(sfcmpge)(CPUHexagonState *env,
> float32 RsV, float32 RtV)
>      cmp =3D float32_compare_quiet(RsV, RtV, &env->fp_status);
>      PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater ||
>                     cmp =3D=3D float_relation_equal);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV;
>      arch_fpop_start(env);
>      PdV =3D f8BITSOF(float32_unordered_quiet(RsV, RtV, &env->fp_status))=
;
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D float32_maximum_number(RsV, RtV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D float32_minimum_number(RsV, RtV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV)
> +int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV =3D 0;
>      arch_fpop_start(env);
> @@ -903,100 +940,110 @@ int32_t HELPER(sfclass)(CPUHexagonState *env,
> float32 RsV, int32_t uiV)
>          PdV =3D 0xff;
>      }
>      set_float_exception_flags(0, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                         uint32_t pkt_need_commit)
>  {
>      float32 RdV =3D 0;
>      int adjust;
>      arch_fpop_start(env);
>      arch_sf_recip_common(&RsV, &RtV, &RdV, &adjust, &env->fp_status);
>      RdV =3D RsV;
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                         uint32_t pkt_need_commit)
>  {
>      float32 RdV =3D 0;
>      int adjust;
>      arch_fpop_start(env);
>      arch_sf_recip_common(&RsV, &RtV, &RdV, &adjust, &env->fp_status);
>      RdV =3D RtV;
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV)
> +float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV,
> +                         uint32_t pkt_need_commit)
>  {
>      float32 RdV =3D 0;
>      int adjust;
>      arch_fpop_start(env);
>      arch_sf_invsqrt_common(&RsV, &RdV, &adjust, &env->fp_status);
>      RdV =3D RsV;
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
> -float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV)
> +float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV,
> +                      uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D float64_add(RssV, RttV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV)
> +float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV,
> +                      uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D float64_sub(RssV, RttV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV)
> +float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV,
> +                      uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D float64_maximum_number(RssV, RttV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV)
> +float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV,
> +                      uint32_t pkt_need_commit)
>  {
>      float64 RddV;
>      arch_fpop_start(env);
>      RddV =3D float64_minimum_number(RssV, RttV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
> -int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV=
)
> +int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV=
,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV;
>      arch_fpop_start(env);
>      PdV =3D f8BITSOF(float64_eq_quiet(RssV, RttV, &env->fp_status));
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV=
)
> +int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV=
,
> +                        uint32_t pkt_need_commit)
>  {
>      int cmp;
>      int32_t PdV;
>      arch_fpop_start(env);
>      cmp =3D float64_compare_quiet(RssV, RttV, &env->fp_status);
>      PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV=
)
> +int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV=
,
> +                        uint32_t pkt_need_commit)
>  {
>      int cmp;
>      int32_t PdV;
> @@ -1004,20 +1051,22 @@ int32_t HELPER(dfcmpge)(CPUHexagonState *env,
> float64 RssV, float64 RttV)
>      cmp =3D float64_compare_quiet(RssV, RttV, &env->fp_status);
>      PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater ||
>                     cmp =3D=3D float_relation_equal);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV=
)
> +int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV=
,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV;
>      arch_fpop_start(env);
>      PdV =3D f8BITSOF(float64_unordered_quiet(RssV, RttV, &env->fp_status=
));
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV)
> +int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV,
> +                        uint32_t pkt_need_commit)
>  {
>      int32_t PdV =3D 0;
>      arch_fpop_start(env);
> @@ -1037,51 +1086,55 @@ int32_t HELPER(dfclass)(CPUHexagonState *env,
> float64 RssV, int32_t uiV)
>          PdV =3D 0xff;
>      }
>      set_float_exception_flags(0, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return PdV;
>  }
>
> -float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)
> +float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      float32 RdV;
>      arch_fpop_start(env);
>      RdV =3D float32_mul(RsV, RtV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RdV;
>  }
>
>  float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
> -                      float32 RsV, float32 RtV)
> +                      float32 RsV, float32 RtV,
> +                      uint32_t pkt_need_commit)
>  {
>      arch_fpop_start(env);
>      RxV =3D float32_muladd(RsV, RtV, RxV, 0, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RxV;
>  }
>
>  float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
> -                         float32 RsV, float32 RtV, float32 PuV)
> +                         float32 RsV, float32 RtV, float32 PuV,
> +                         uint32_t pkt_need_commit)
>  {
>      arch_fpop_start(env);
>      RxV =3D float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 64, PuV),
>                                  float_muladd_suppress_add_product_zero,
>                                  &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RxV;
>  }
>
>  float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
> -                      float32 RsV, float32 RtV)
> +                      float32 RsV, float32 RtV, uint32_t pkt_need_commit=
)
>  {
>      arch_fpop_start(env);
>      RxV =3D float32_muladd(RsV, RtV, RxV, float_muladd_negate_product,
>                           &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RxV;
>  }
>
>  static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,
> -                            float32 RsV, float32 RtV, int negate)
> +                            float32 RsV, float32 RtV, int negate,
> +                            uint32_t pkt_need_commit)
>  {
>      int flags;
>
> @@ -1103,23 +1156,25 @@ static float32 do_sffma_lib(CPUHexagonState *env,
> float32 RxV,
>          }
>      }
>
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RxV;
>  }
>
>  float32 HELPER(sffma_lib)(CPUHexagonState *env, float32 RxV,
> -                          float32 RsV, float32 RtV)
> +                          float32 RsV, float32 RtV, uint32_t
> pkt_need_commit)
>  {
> -    return do_sffma_lib(env, RxV, RsV, RtV, 0);
> +    return do_sffma_lib(env, RxV, RsV, RtV, 0, pkt_need_commit);
>  }
>
>  float32 HELPER(sffms_lib)(CPUHexagonState *env, float32 RxV,
> -                          float32 RsV, float32 RtV)
> +                          float32 RsV, float32 RtV, uint32_t
> pkt_need_commit)
>  {
> -    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product)=
;
> +    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product,
> +                        pkt_need_commit);
>  }
>
> -float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 Rtt=
V)
> +float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 Rtt=
V,
> +                         uint32_t pkt_need_commit)
>  {
>      int64_t RddV;
>      arch_fpop_start(env);
> @@ -1136,16 +1191,16 @@ float64 HELPER(dfmpyfix)(CPUHexagonState *env,
> float64 RssV, float64 RttV)
>      } else {
>          RddV =3D RssV;
>      }
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RddV;
>  }
>
>  float64 HELPER(dfmpyhh)(CPUHexagonState *env, float64 RxxV,
> -                        float64 RssV, float64 RttV)
> +                        float64 RssV, float64 RttV, uint32_t
> pkt_need_commit)
>  {
>      arch_fpop_start(env);
>      RxxV =3D internal_mpyhh(RssV, RttV, RxxV, &env->fp_status);
> -    arch_fpop_end(env);
> +    arch_fpop_end(env, pkt_need_commit);
>      return RxxV;
>  }
>
> diff --git a/target/hexagon/gen_helper_funcs.py
> b/target/hexagon/gen_helper_funcs.py
> index a9c0e27a80..6206104424 100755
> --- a/target/hexagon/gen_helper_funcs.py
> +++ b/target/hexagon/gen_helper_funcs.py
> @@ -84,11 +84,6 @@ def gen_helper_function(f, tag, tagregs, tagimms):
>          {hex_common.semdict[tag]}
>      """))
>
> -    if "A_FPOP" in hex_common.attribdict[tag]:
> -        f.write(hex_common.code_fmt(f"""\
> -            arch_fpop_end(env);
> -        """))
> -
>      ## Return the scalar result
>      for regtype, regid in regs:
>          reg =3D hex_common.get_register(tag, regtype, regid)
> @@ -116,6 +111,9 @@ def main():
>              ## Skip the guest instructions
>              if "A_GUEST" in hex_common.attribdict[tag]:
>                  continue
> +            ## Skip the floating point instructions
> +            if "A_FPOP" in hex_common.attribdict[tag]:
> +                continue
>              ## Skip the diag instructions
>              if tag =3D=3D "Y6_diag":
>                  continue
> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py
> index c2ba91ddc0..91b6a1e9d0 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -77,6 +77,10 @@ def gen_tcg_func(f, tag, regs, imms):
>          f.write(f"    emit_{tag}({arguments});\n")
>
>      elif hex_common.skip_qemu_helper(tag):
> +        if "A_FPOP" in hex_common.attribdict[tag]:
> +            f.write("    TCGv pkt_need_commit =3D ")
> +            f.write("tcg_constant_tl(ctx->need_commit);\n")
> +
>          f.write(f"    fGEN_TCG_{tag}({hex_common.semdict[tag]});\n")
>      else:
>          ## Generate the call to the helper
> --
> 2.43.0
>
>

--0000000000007b8e130642cfdeb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 4, =
2025 at 4:25=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson=
@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">The arch_fpop_end function converts the=
 softfloat fp_status flags to<br>
bits set in Hexagon USR.=C2=A0 It is hard-coded that the packet must need<b=
r>
a commit.=C2=A0 We add an argument to the function and update all the helpe=
r<br>
call sites.<br>
<br>
In a subsequent commit, we will change the code that forces a commit<br>
when the packet contains an floating point instruction.<br>
<br>
Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail-gs" style=3D"margin:=
0px;min-width:0px;padding:0px 0px 20px;width:auto;font-family:&quot;Google =
Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:medium">=
<div class=3D"gmail-"><div id=3D"gmail-:mm" class=3D"gmail-ii gmail-gt gmai=
l-adO" style=3D"direction:ltr;margin:8px 0px 0px;padding:0px;font-size:0.87=
5rem;overflow-x:hidden"><div id=3D"gmail-:ml" class=3D"gmail-a3s gmail-aiL"=
 style=3D"direction:ltr;font-variant-numeric:normal;font-variant-east-asian=
:normal;font-variant-alternates:normal;font-size-adjust:none;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;font-size:small;line-h=
eight:1.5;font-family:Arial,Helvetica,sans-serif;overflow:auto hidden"><div=
 dir=3D"ltr"><div class=3D"gmail_quote"><div>Reviewed-by: Brian Cain &lt;<a=
 href=3D"mailto:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@o=
ss.qualcomm.com</a>&gt;</div></div></div></div></div><div class=3D"gmail-Wh=
mR8e" id=3D"gmail-avWBGd-67" style=3D"clear:both"></div></div></div><br cla=
ss=3D"gmail-Apple-interchange-newline"><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11=
4 ++++++------<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
4 ++++++------<br>
=C2=A0target/hexagon/arch.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A03 +-<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 287 +++=
++++++++++++++------------<br>
=C2=A0target/hexagon/gen_helper_funcs.py |=C2=A0 =C2=A08 +-<br>
=C2=A0target/hexagon/gen_tcg_funcs.py=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A07 files changed, 294 insertions(+), 238 deletions(-)<br>
<br>
diff --git a/target/hexagon/arch.h b/target/hexagon/arch.h<br>
index 70918065d3..c295a86600 100644<br>
--- a/target/hexagon/arch.h<br>
+++ b/target/hexagon/arch.h<br>
@@ -28,7 +28,7 @@ uint64_t interleave(uint32_t odd, uint32_t even);<br>
=C2=A0uint64_t deinterleave(uint64_t src);<br>
=C2=A0int32_t conv_round(int32_t a, int n);<br>
=C2=A0void arch_fpop_start(CPUHexagonState *env);<br>
-void arch_fpop_end(CPUHexagonState *env);<br>
+void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit);<br>
=C2=A0int arch_sf_recip_common(float32 *Rs, float32 *Rt, float32 *Rd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int *adjust, float_status *fp_status);<br>
=C2=A0int arch_sf_invsqrt_common(float32 *Rs, float32 *Rd, int *adjust,<br>
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 8a3b801287..f17eac2f1a 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br>
@@ -613,7 +613,7 @@<br>
=C2=A0#define fGEN_TCG_F2_sfrecipa(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 tmp =3D tcg_temp_new_i64(); \<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV);=
=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV, pk=
t_need_commit);=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_extrh_i64_i32(RdV, tmp); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_extrl_i64_i32(PeV, tmp); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
@@ -628,7 +628,7 @@<br>
=C2=A0#define fGEN_TCG_F2_sfinvsqrta(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 tmp =3D tcg_temp_new_i64(); \<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfinvsqrta(tmp, tcg_env, RsV); \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfinvsqrta(tmp, tcg_env, RsV, pkt_n=
eed_commit); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_extrh_i64_i32(RdV, tmp); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_extrl_i64_i32(PeV, tmp); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
@@ -1204,122 +1204,122 @@<br>
<br>
=C2=A0/* Floating point */<br>
=C2=A0#define fGEN_TCG_F2_conv_sf2df(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2df(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2df(RddV, tcg_env, RsV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_df2sf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2sf(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2sf(RdV, tcg_env, RssV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_uw2sf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_uw2sf(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_uw2sf(RdV, tcg_env, RsV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_uw2df(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_uw2df(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_uw2df(RddV, tcg_env, RsV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_w2sf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_w2sf(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_w2sf(RdV, tcg_env, RsV, pkt_need_commit)<br>
=C2=A0#define fGEN_TCG_F2_conv_w2df(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_w2df(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_w2df(RddV, tcg_env, RsV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_ud2sf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_ud2sf(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_ud2sf(RdV, tcg_env, RssV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_ud2df(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_ud2df(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_ud2df(RddV, tcg_env, RssV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_conv_d2sf(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_d2sf(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_d2sf(RdV, tcg_env, RssV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_d2df(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_d2df(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_d2df(RddV, tcg_env, RssV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_sf2uw(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2uw(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2uw(RdV, tcg_env, RsV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_sf2w(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2w(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2w(RdV, tcg_env, RsV, pkt_need_commit)<br>
=C2=A0#define fGEN_TCG_F2_conv_sf2ud(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2ud(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2ud(RddV, tcg_env, RsV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_sf2d(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2d(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2d(RddV, tcg_env, RsV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_df2uw(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2uw(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2uw(RdV, tcg_env, RssV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_df2w(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2w(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2w(RdV, tcg_env, RssV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_conv_df2ud(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2ud(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2ud(RddV, tcg_env, RssV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_conv_df2d(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2d(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2d(RddV, tcg_env, RssV, pkt_need_commit)<b=
r>
=C2=A0#define fGEN_TCG_F2_conv_sf2uw_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV, pkt_need_commi=
t)<br>
=C2=A0#define fGEN_TCG_F2_conv_sf2w_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV, pkt_need_commit=
)<br>
=C2=A0#define fGEN_TCG_F2_conv_sf2ud_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV, pkt_need_comm=
it)<br>
=C2=A0#define fGEN_TCG_F2_conv_sf2d_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV, pkt_need_commi=
t)<br>
=C2=A0#define fGEN_TCG_F2_conv_df2uw_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV, pkt_need_comm=
it)<br>
=C2=A0#define fGEN_TCG_F2_conv_df2w_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2w_chop(RdV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2w_chop(RdV, tcg_env, RssV, pkt_need_commi=
t)<br>
=C2=A0#define fGEN_TCG_F2_conv_df2ud_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV, pkt_need_com=
mit)<br>
=C2=A0#define fGEN_TCG_F2_conv_df2d_chop(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_conv_df2d_chop(RddV, tcg_env, RssV)<br>
+=C2=A0 =C2=A0 gen_helper_conv_df2d_chop(RddV, tcg_env, RssV, pkt_need_comm=
it)<br>
=C2=A0#define fGEN_TCG_F2_sfadd(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfadd(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfadd(RdV, tcg_env, RsV, RtV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_sfsub(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfsub(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfsub(RdV, tcg_env, RsV, RtV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_sfcmpeq(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_sfcmpgt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_sfcmpge(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_sfcmpuo(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV, pkt_need_commit)<=
br>
=C2=A0#define fGEN_TCG_F2_sfmax(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfmax(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfmax(RdV, tcg_env, RsV, RtV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_sfmin(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfmin(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfmin(RdV, tcg_env, RsV, RtV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_sfclass(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv imm =3D tcg_constant_tl(uiV); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfclass(PdV, tcg_env, RsV, imm); \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_sfclass(PdV, tcg_env, RsV, imm, pkt=
_need_commit); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
=C2=A0#define fGEN_TCG_F2_sffixupn(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffixupn(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffixupn(RdV, tcg_env, RsV, RtV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_sffixupd(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffixupd(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffixupd(RdV, tcg_env, RsV, RtV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_sffixupr(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffixupr(RdV, tcg_env, RsV)<br>
+=C2=A0 =C2=A0 gen_helper_sffixupr(RdV, tcg_env, RsV, pkt_need_commit)<br>
=C2=A0#define fGEN_TCG_F2_dfadd(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfadd(RddV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfadd(RddV, tcg_env, RssV, RttV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_dfsub(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfsub(RddV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfsub(RddV, tcg_env, RssV, RttV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_dfmax(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfmax(RddV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfmax(RddV, tcg_env, RssV, RttV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_dfmin(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfmin(RddV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfmin(RddV, tcg_env, RssV, RttV, pkt_need_commit)=
<br>
=C2=A0#define fGEN_TCG_F2_dfcmpeq(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV, pkt_need_commit=
)<br>
=C2=A0#define fGEN_TCG_F2_dfcmpgt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV, pkt_need_commit=
)<br>
=C2=A0#define fGEN_TCG_F2_dfcmpge(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV, pkt_need_commit=
)<br>
=C2=A0#define fGEN_TCG_F2_dfcmpuo(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV, pkt_need_commit=
)<br>
=C2=A0#define fGEN_TCG_F2_dfclass(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv imm =3D tcg_constant_tl(uiV); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_dfclass(PdV, tcg_env, RssV, imm); \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_dfclass(PdV, tcg_env, RssV, imm, pk=
t_need_commit); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
=C2=A0#define fGEN_TCG_F2_sfmpy(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sfmpy(RdV, tcg_env, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sfmpy(RdV, tcg_env, RsV, RtV, pkt_need_commit)<br=
>
=C2=A0#define fGEN_TCG_F2_sffma(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commi=
t)<br>
=C2=A0#define fGEN_TCG_F2_sffma_sc(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV)<br>
+=C2=A0 =C2=A0 gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV, pkt_ne=
ed_commit)<br>
=C2=A0#define fGEN_TCG_F2_sffms(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commi=
t)<br>
=C2=A0#define fGEN_TCG_F2_sffma_lib(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_c=
ommit)<br>
=C2=A0#define fGEN_TCG_F2_sffms_lib(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV)<br>
+=C2=A0 =C2=A0 gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_c=
ommit)<br>
<br>
=C2=A0#define fGEN_TCG_F2_dfmpyfix(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV, pkt_need_comm=
it)<br>
=C2=A0#define fGEN_TCG_F2_dfmpyhh(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV)<br>
+=C2=A0 =C2=A0 gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV, pkt_need=
_commit)<br>
<br>
=C2=A0/* Nothing to do for these in qemu, need to suppress compiler warning=
s */<br>
=C2=A0#define fGEN_TCG_Y4_l2fetch(SHORTCODE) \<br>
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h<br>
index f8baa599c8..64456822bc 100644<br>
--- a/target/hexagon/helper.h<br>
+++ b/target/hexagon/helper.h<br>
@@ -24,72 +24,72 @@ DEF_HELPER_3(gather_store, void, env, i32, int)<br>
=C2=A0DEF_HELPER_1(commit_hvx_stores, void, env)<br>
=C2=A0DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, =
s32)<br>
=C2=A0DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)<br>
-DEF_HELPER_3(sfrecipa, i64, env, f32, f32)<br>
-DEF_HELPER_2(sfinvsqrta, i64, env, f32)<br>
+DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)<br>
+DEF_HELPER_3(sfinvsqrta, i64, env, f32, i32)<br>
=C2=A0DEF_HELPER_5(vacsh_val, s64, env, s64, s64, s64, i32)<br>
=C2=A0DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32, env, s64, s64=
, s64)<br>
=C2=A0DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64=
)<br>
=C2=A0DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s6=
4)<br>
<br>
=C2=A0/* Floating point */<br>
-DEF_HELPER_2(conv_sf2df, f64, env, f32)<br>
-DEF_HELPER_2(conv_df2sf, f32, env, f64)<br>
-DEF_HELPER_2(conv_uw2sf, f32, env, s32)<br>
-DEF_HELPER_2(conv_uw2df, f64, env, s32)<br>
-DEF_HELPER_2(conv_w2sf, f32, env, s32)<br>
-DEF_HELPER_2(conv_w2df, f64, env, s32)<br>
-DEF_HELPER_2(conv_ud2sf, f32, env, s64)<br>
-DEF_HELPER_2(conv_ud2df, f64, env, s64)<br>
-DEF_HELPER_2(conv_d2sf, f32, env, s64)<br>
-DEF_HELPER_2(conv_d2df, f64, env, s64)<br>
-DEF_HELPER_2(conv_sf2uw, i32, env, f32)<br>
-DEF_HELPER_2(conv_sf2w, s32, env, f32)<br>
-DEF_HELPER_2(conv_sf2ud, i64, env, f32)<br>
-DEF_HELPER_2(conv_sf2d, s64, env, f32)<br>
-DEF_HELPER_2(conv_df2uw, i32, env, f64)<br>
-DEF_HELPER_2(conv_df2w, s32, env, f64)<br>
-DEF_HELPER_2(conv_df2ud, i64, env, f64)<br>
-DEF_HELPER_2(conv_df2d, s64, env, f64)<br>
-DEF_HELPER_2(conv_sf2uw_chop, i32, env, f32)<br>
-DEF_HELPER_2(conv_sf2w_chop, s32, env, f32)<br>
-DEF_HELPER_2(conv_sf2ud_chop, i64, env, f32)<br>
-DEF_HELPER_2(conv_sf2d_chop, s64, env, f32)<br>
-DEF_HELPER_2(conv_df2uw_chop, i32, env, f64)<br>
-DEF_HELPER_2(conv_df2w_chop, s32, env, f64)<br>
-DEF_HELPER_2(conv_df2ud_chop, i64, env, f64)<br>
-DEF_HELPER_2(conv_df2d_chop, s64, env, f64)<br>
-DEF_HELPER_3(sfadd, f32, env, f32, f32)<br>
-DEF_HELPER_3(sfsub, f32, env, f32, f32)<br>
-DEF_HELPER_3(sfcmpeq, s32, env, f32, f32)<br>
-DEF_HELPER_3(sfcmpgt, s32, env, f32, f32)<br>
-DEF_HELPER_3(sfcmpge, s32, env, f32, f32)<br>
-DEF_HELPER_3(sfcmpuo, s32, env, f32, f32)<br>
-DEF_HELPER_3(sfmax, f32, env, f32, f32)<br>
-DEF_HELPER_3(sfmin, f32, env, f32, f32)<br>
-DEF_HELPER_3(sfclass, s32, env, f32, s32)<br>
-DEF_HELPER_3(sffixupn, f32, env, f32, f32)<br>
-DEF_HELPER_3(sffixupd, f32, env, f32, f32)<br>
-DEF_HELPER_2(sffixupr, f32, env, f32)<br>
+DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)<br>
+DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)<br>
+DEF_HELPER_3(conv_uw2sf, f32, env, s32, i32)<br>
+DEF_HELPER_3(conv_uw2df, f64, env, s32, i32)<br>
+DEF_HELPER_3(conv_w2sf, f32, env, s32, i32)<br>
+DEF_HELPER_3(conv_w2df, f64, env, s32, i32)<br>
+DEF_HELPER_3(conv_ud2sf, f32, env, s64, i32)<br>
+DEF_HELPER_3(conv_ud2df, f64, env, s64, i32)<br>
+DEF_HELPER_3(conv_d2sf, f32, env, s64, i32)<br>
+DEF_HELPER_3(conv_d2df, f64, env, s64, i32)<br>
+DEF_HELPER_3(conv_sf2uw, i32, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2w, s32, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2ud, i64, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2d, s64, env, f32, i32)<br>
+DEF_HELPER_3(conv_df2uw, i32, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2w, s32, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2ud, i64, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2d, s64, env, f64, i32)<br>
+DEF_HELPER_3(conv_sf2uw_chop, i32, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2w_chop, s32, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2ud_chop, i64, env, f32, i32)<br>
+DEF_HELPER_3(conv_sf2d_chop, s64, env, f32, i32)<br>
+DEF_HELPER_3(conv_df2uw_chop, i32, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2w_chop, s32, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2ud_chop, i64, env, f64, i32)<br>
+DEF_HELPER_3(conv_df2d_chop, s64, env, f64, i32)<br>
+DEF_HELPER_4(sfadd, f32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfsub, f32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfcmpeq, s32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfcmpgt, s32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfcmpge, s32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfcmpuo, s32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfmax, f32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfmin, f32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sfclass, s32, env, f32, s32, i32)<br>
+DEF_HELPER_4(sffixupn, f32, env, f32, f32, i32)<br>
+DEF_HELPER_4(sffixupd, f32, env, f32, f32, i32)<br>
+DEF_HELPER_3(sffixupr, f32, env, f32, i32)<br>
<br>
-DEF_HELPER_3(dfadd, f64, env, f64, f64)<br>
-DEF_HELPER_3(dfsub, f64, env, f64, f64)<br>
-DEF_HELPER_3(dfmax, f64, env, f64, f64)<br>
-DEF_HELPER_3(dfmin, f64, env, f64, f64)<br>
-DEF_HELPER_3(dfcmpeq, s32, env, f64, f64)<br>
-DEF_HELPER_3(dfcmpgt, s32, env, f64, f64)<br>
-DEF_HELPER_3(dfcmpge, s32, env, f64, f64)<br>
-DEF_HELPER_3(dfcmpuo, s32, env, f64, f64)<br>
-DEF_HELPER_3(dfclass, s32, env, f64, s32)<br>
+DEF_HELPER_4(dfadd, f64, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfsub, f64, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfmax, f64, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfmin, f64, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfcmpeq, s32, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfcmpgt, s32, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfcmpge, s32, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfcmpuo, s32, env, f64, f64, i32)<br>
+DEF_HELPER_4(dfclass, s32, env, f64, s32, i32)<br>
<br>
-DEF_HELPER_3(sfmpy, f32, env, f32, f32)<br>
-DEF_HELPER_4(sffma, f32, env, f32, f32, f32)<br>
-DEF_HELPER_5(sffma_sc, f32, env, f32, f32, f32, f32)<br>
-DEF_HELPER_4(sffms, f32, env, f32, f32, f32)<br>
-DEF_HELPER_4(sffma_lib, f32, env, f32, f32, f32)<br>
-DEF_HELPER_4(sffms_lib, f32, env, f32, f32, f32)<br>
+DEF_HELPER_4(sfmpy, f32, env, f32, f32, i32)<br>
+DEF_HELPER_5(sffma, f32, env, f32, f32, f32, i32)<br>
+DEF_HELPER_6(sffma_sc, f32, env, f32, f32, f32, f32, i32)<br>
+DEF_HELPER_5(sffms, f32, env, f32, f32, f32, i32)<br>
+DEF_HELPER_5(sffma_lib, f32, env, f32, f32, f32, i32)<br>
+DEF_HELPER_5(sffms_lib, f32, env, f32, f32, f32, i32)<br>
<br>
-DEF_HELPER_3(dfmpyfix, f64, env, f64, f64)<br>
-DEF_HELPER_4(dfmpyhh, f64, env, f64, f64, f64)<br>
+DEF_HELPER_4(dfmpyfix, f64, env, f64, f64, i32)<br>
+DEF_HELPER_5(dfmpyhh, f64, env, f64, f64, f64, i32)<br>
<br>
=C2=A0/* Histogram instructions */<br>
=C2=A0DEF_HELPER_1(vhist, void, env)<br>
diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c<br>
index d053d68487..e17e714a6a 100644<br>
--- a/target/hexagon/arch.c<br>
+++ b/target/hexagon/arch.c<br>
@@ -222,9 +222,8 @@ void arch_fpop_start(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
-void arch_fpop_end(CPUHexagonState *env)<br>
+void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const bool pkt_need_commit =3D true;<br>
=C2=A0 =C2=A0 =C2=A0int flags =3D get_float_exception_flags(&amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0if (flags !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SOFTFLOAT_TEST_FLAG(float_flag_inexact, F=
PINPF, FPINPE);<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index e2e80ca7ef..554e7dd447 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -200,7 +200,8 @@ static float32 build_float32(uint8_t sign, uint32_t exp=
, uint32_t mant)<br>
=C2=A0 * Since helpers can only return a single value, we pack the two resu=
lts<br>
=C2=A0 * into a 64-bit value.<br>
=C2=A0 */<br>
-uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV)<=
br>
+uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PeV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
@@ -217,11 +218,12 @@ uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float=
32 RsV, float32 RtV)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exp =3D SF_BIAS - (float32_getexp(RtV) - =
SF_BIAS) - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D build_float32(extract32(RtV, 31, =
1), exp, mant);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return ((uint64_t)RdV &lt;&lt; 32) | PeV;<br>
=C2=A0}<br>
<br>
-uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV)<br>
+uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int PeV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
@@ -238,7 +240,7 @@ uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float=
32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exp =3D SF_BIAS - ((float32_getexp(RsV) -=
 SF_BIAS) &gt;&gt; 1) - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D build_float32(extract32(RsV, 31, =
1), exp, mant);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return ((uint64_t)RdV &lt;&lt; 32) | PeV;<br>
=C2=A0}<br>
<br>
@@ -476,97 +478,108 @@ static void check_noshuf(CPUHexagonState *env, bool =
pkt_has_scalar_store_s1,<br>
=C2=A0#endif<br>
<br>
=C2=A0/* Floating point */<br>
-float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV)<br>
+float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 out_f64;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0out_f64 =3D float32_to_float64(RsV, &amp;env-&gt;fp_sta=
tus);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return out_f64;<br>
=C2=A0}<br>
<br>
-float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV)<br>
+float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 out_f32;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0out_f32 =3D float64_to_float32(RssV, &amp;env-&gt;fp_st=
atus);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return out_f32;<br>
=C2=A0}<br>
<br>
-float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV)<br>
+float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D uint32_to_float32(RsV, &amp;env-&gt;fp_status);=
<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV)<br>
+float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D uint32_to_float64(RsV, &amp;env-&gt;fp_status)=
;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV)<br>
+float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D int32_to_float32(RsV, &amp;env-&gt;fp_status);<=
br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV)<br>
+float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D int32_to_float64(RsV, &amp;env-&gt;fp_status);=
<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV)<br>
+float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D uint64_to_float32(RssV, &amp;env-&gt;fp_status)=
;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV)<br>
+float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D uint64_to_float64(RssV, &amp;env-&gt;fp_status=
);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV)<br>
+float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D int64_to_float32(RssV, &amp;env-&gt;fp_status);=
<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV)<br>
+float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D int64_to_float64(RssV, &amp;env-&gt;fp_status)=
;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)<br>
+uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -577,11 +590,12 @@ uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, flo=
at32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float32_to_uint32(RsV, &amp;env-&=
gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV)<br>
+int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -592,11 +606,12 @@ int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float=
32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float32_to_int32(RsV, &amp;env-&g=
t;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)<br>
+uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -607,11 +622,12 @@ uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, flo=
at32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float32_to_uint64(RsV, &amp;env-=
&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV)<br>
+int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -622,11 +638,12 @@ int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float=
32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float32_to_int64(RsV, &amp;env-&=
gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)<br>
+uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -637,11 +654,12 @@ uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, flo=
at64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float64_to_uint32(RssV, &amp;env-=
&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV)<br>
+int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -652,11 +670,12 @@ int32_t HELPER(conv_df2w)(CPUHexagonState *env, float=
64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float64_to_int32(RssV, &amp;env-&=
gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)<br>
+uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -667,11 +686,12 @@ uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, flo=
at64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float64_to_uint64(RssV, &amp;env=
-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV)<br>
+int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -682,11 +702,12 @@ int64_t HELPER(conv_df2d)(CPUHexagonState *env, float=
64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float64_to_int64(RssV, &amp;env-=
&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)<br>
+uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -697,11 +718,12 @@ uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env=
, float32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float32_to_uint32_round_to_zero(R=
sV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV)<br>
+int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -712,11 +734,12 @@ int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, =
float32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float32_to_int32_round_to_zero(Rs=
V, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)<br>
+uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -727,11 +750,12 @@ uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env=
, float32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float32_to_uint64_round_to_zero(=
RsV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV)<br>
+int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -742,11 +766,12 @@ int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, =
float32 RsV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float32_to_int64_round_to_zero(R=
sV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)<br>
+uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -757,11 +782,12 @@ uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env=
, float64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float64_to_uint32_round_to_zero(R=
ssV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV)<br>
+int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -772,11 +798,12 @@ int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, =
float64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RdV =3D float64_to_int32_round_to_zero(Rs=
sV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)<br>
+uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -787,11 +814,12 @@ uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env=
, float64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float64_to_uint64_round_to_zero(=
RssV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV)<br>
+int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -802,49 +830,54 @@ int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, =
float64 RssV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D float64_to_int64_round_to_zero(R=
ssV, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV)<br>
+float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D float32_add(RsV, RtV, &amp;env-&gt;fp_status);<=
br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV)<br>
+float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D float32_sub(RsV, RtV, &amp;env-&gt;fp_status);<=
br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV)<br=
>
+int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(float32_eq_quiet(RsV, RtV, &amp;env-&g=
t;fp_status));<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV)<br=
>
+int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int cmp;<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0cmp =3D float32_compare_quiet(RsV, RtV, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater);<br=
>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV)<br=
>
+int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int cmp;<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
@@ -852,38 +885,42 @@ int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32=
 RsV, float32 RtV)<br>
=C2=A0 =C2=A0 =C2=A0cmp =3D float32_compare_quiet(RsV, RtV, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater ||<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmp =
=3D=3D float_relation_equal);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV)<br=
>
+int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(float32_unordered_quiet(RsV, RtV, &amp=
;env-&gt;fp_status));<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV)<br>
+float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D float32_maximum_number(RsV, RtV, &amp;env-&gt;f=
p_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV)<br>
+float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D float32_minimum_number(RsV, RtV, &amp;env-&gt;f=
p_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV)<br=
>
+int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -903,100 +940,110 @@ int32_t HELPER(sfclass)(CPUHexagonState *env, float=
32 RsV, int32_t uiV)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PdV =3D 0xff;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;env-&gt;fp_status);<b=
r>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV)<b=
r>
+float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int adjust;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0arch_sf_recip_common(&amp;RsV, &amp;RtV, &amp;RdV, &amp=
;adjust, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D RsV;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV)<b=
r>
+float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int adjust;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0arch_sf_recip_common(&amp;RsV, &amp;RtV, &amp;RdV, &amp=
;adjust, &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D RtV;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV)<br>
+float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int adjust;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0arch_sf_invsqrt_common(&amp;RsV, &amp;RdV, &amp;adjust,=
 &amp;env-&gt;fp_status);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D RsV;<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV)<br=
>
+float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D float64_add(RssV, RttV, &amp;env-&gt;fp_status=
);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV)<br=
>
+float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D float64_sub(RssV, RttV, &amp;env-&gt;fp_status=
);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV)<br=
>
+float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D float64_maximum_number(RssV, RttV, &amp;env-&g=
t;fp_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV)<br=
>
+float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float64 RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RddV =3D float64_minimum_number(RssV, RttV, &amp;env-&g=
t;fp_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV)<=
br>
+int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(float64_eq_quiet(RssV, RttV, &amp;env-=
&gt;fp_status));<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV)<=
br>
+int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int cmp;<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0cmp =3D float64_compare_quiet(RssV, RttV, &amp;env-&gt;=
fp_status);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater);<br=
>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV)<=
br>
+int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int cmp;<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
@@ -1004,20 +1051,22 @@ int32_t HELPER(dfcmpge)(CPUHexagonState *env, float=
64 RssV, float64 RttV)<br>
=C2=A0 =C2=A0 =C2=A0cmp =3D float64_compare_quiet(RssV, RttV, &amp;env-&gt;=
fp_status);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(cmp =3D=3D float_relation_greater ||<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmp =
=3D=3D float_relation_equal);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV)<=
br>
+int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0PdV =3D f8BITSOF(float64_unordered_quiet(RssV, RttV, &a=
mp;env-&gt;fp_status));<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV)<b=
r>
+int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t PdV =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -1037,51 +1086,55 @@ int32_t HELPER(dfclass)(CPUHexagonState *env, float=
64 RssV, int32_t uiV)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PdV =3D 0xff;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;env-&gt;fp_status);<b=
r>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return PdV;<br>
=C2=A0}<br>
<br>
-float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)<br>
+float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float32 RdV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RdV =3D float32_mul(RsV, RtV, &amp;env-&gt;fp_status);<=
br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RdV;<br>
=C2=A0}<br>
<br>
=C2=A0float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 float32 RsV, float32 RtV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 float32 RsV, float32 RtV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RxV =3D float32_muladd(RsV, RtV, RxV, 0, &amp;env-&gt;f=
p_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RxV;<br>
=C2=A0}<br>
<br>
=C2=A0float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0float32 RsV, float32 RtV, float32 PuV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0float32 RsV, float32 RtV, float32 PuV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RxV =3D float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 6=
4, PuV),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_muladd_suppress_add_prod=
uct_zero,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;env-&gt;fp_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RxV;<br>
=C2=A0}<br>
<br>
=C2=A0float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 float32 RsV, float32 RtV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 float32 RsV, float32 RtV, uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RxV =3D float32_muladd(RsV, RtV, RxV, float_muladd_nega=
te_product,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;env-&gt;fp_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RxV;<br>
=C2=A0}<br>
<br>
=C2=A0static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV, int negate)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV, int negate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int flags;<br>
<br>
@@ -1103,23 +1156,25 @@ static float32 do_sffma_lib(CPUHexagonState *env, f=
loat32 RxV,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RxV;<br>
=C2=A0}<br>
<br>
=C2=A0float32 HELPER(sffma_lib)(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV, uint32_t pkt_need_commit)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return do_sffma_lib(env, RxV, RsV, RtV, 0);<br>
+=C2=A0 =C2=A0 return do_sffma_lib(env, RxV, RsV, RtV, 0, pkt_need_commit);=
<br>
=C2=A0}<br>
<br>
=C2=A0float32 HELPER(sffms_lib)(CPUHexagonState *env, float32 RxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float32 RsV, float32 RtV, uint32_t pkt_need_commit)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_=
product);<br>
+=C2=A0 =C2=A0 return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_=
product,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pkt_need_commit);<br>
=C2=A0}<br>
<br>
-float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV)=
<br>
+float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t RddV;<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
@@ -1136,16 +1191,16 @@ float64 HELPER(dfmpyfix)(CPUHexagonState *env, floa=
t64 RssV, float64 RttV)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RddV =3D RssV;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RddV;<br>
=C2=A0}<br>
<br>
=C2=A0float64 HELPER(dfmpyhh)(CPUHexagonState *env, float64 RxxV,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 float64 RssV, float64 RttV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 float64 RssV, float64 RttV, uint32_t pkt_need_commit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0arch_fpop_start(env);<br>
=C2=A0 =C2=A0 =C2=A0RxxV =3D internal_mpyhh(RssV, RttV, RxxV, &amp;env-&gt;=
fp_status);<br>
-=C2=A0 =C2=A0 arch_fpop_end(env);<br>
+=C2=A0 =C2=A0 arch_fpop_end(env, pkt_need_commit);<br>
=C2=A0 =C2=A0 =C2=A0return RxxV;<br>
=C2=A0}<br>
<br>
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper=
_funcs.py<br>
index a9c0e27a80..6206104424 100755<br>
--- a/target/hexagon/gen_helper_funcs.py<br>
+++ b/target/hexagon/gen_helper_funcs.py<br>
@@ -84,11 +84,6 @@ def gen_helper_function(f, tag, tagregs, tagimms):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{hex_common.semdict[tag]}<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
<br>
-=C2=A0 =C2=A0 if &quot;A_FPOP&quot; in hex_common.attribdict[tag]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(hex_common.code_fmt(f&quot;&quot;&quot=
;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arch_fpop_end(env);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
-<br>
=C2=A0 =C2=A0 =C2=A0## Return the scalar result<br>
=C2=A0 =C2=A0 =C2=A0for regtype, regid in regs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D hex_common.get_register(tag, regt=
ype, regid)<br>
@@ -116,6 +111,9 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## Skip the guest instructi=
ons<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;A_GUEST&quot; in h=
ex_common.attribdict[tag]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ## Skip the floating point instr=
uctions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;A_FPOP&quot; in hex_com=
mon.attribdict[tag]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## Skip the diag instructio=
ns<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if tag =3D=3D &quot;Y6_diag=
&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs=
.py<br>
index c2ba91ddc0..91b6a1e9d0 100755<br>
--- a/target/hexagon/gen_tcg_funcs.py<br>
+++ b/target/hexagon/gen_tcg_funcs.py<br>
@@ -77,6 +77,10 @@ def gen_tcg_func(f, tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(f&quot;=C2=A0 =C2=A0 emit_{tag}({=
arguments});\n&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0elif hex_common.skip_qemu_helper(tag):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;A_FPOP&quot; in hex_common.attribdict=
[tag]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;=C2=A0 =C2=A0 TCGv=
 pkt_need_commit =3D &quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;tcg_constant_tl(ct=
x-&gt;need_commit);\n&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(f&quot;=C2=A0 =C2=A0 fGEN_TCG_{ta=
g}({hex_common.semdict[tag]});\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## Generate the call to the helper<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000007b8e130642cfdeb2--

