Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D6103E2E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RTA-0004uP-VX; Wed, 11 Mar 2026 17:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0RT7-0004pW-Ob
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:51:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0RT5-0000xZ-AE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:51:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BFoobo3601207
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OjCNSgu7YQ0KrYU4OrCfcxN/
 j7tKHgOvYd8iMYHcxps=; b=gPqxG6YzN8uzgbP/pyg55RAVuAhCxV3c5nlH3yQF
 aRYoDNGye69Qy5J1n62JASpmTkL6LK+E3KZJ89fqLhiuPO4deSoAZCQiLcW+rHU4
 mXUCXSXugKZeBCyRyH+IcBPHqT5PoMyVNxZYnfdlYxlJROfcBBlYnp5lYJ0vVZ3n
 UCGXZvusYIg5vFPf7srViC/3uo1dSaCNZkL40O6GClaE8Ley3F/LCXLolP8DRhYs
 NFUM4tXAvvuz8+5UkBSlqGdYNAt84b5/hW7t5ZwQkxTP2AzLjtTjA2+BugfzCFU/
 cxQB0KI0vih3S1o9Wl5UVZNb22PsKpTqNZj5FY2RetO8gQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cubd4s5su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:51:49 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79874ae3e49so10116767b3.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 14:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773265909; cv=none;
 d=google.com; s=arc-20240605;
 b=HlozKVIOvcwdID6nlRw5+aM+Bb98U72XDWPA2P8aWoKE+zILD9BNrr5Zj+G0mBwQff
 VcRljH1l4OE6GCjWiFAdI++T2+Fn8/RIevkn9z6RNp7ZFg9m5LrTzcv3hjwR4rNNG6V5
 CUgSXyk7j2rzep6PfPWfiVSgRgFfIPm3WeDpLm/CTJk9v84sKuHHDjOT+YSrHhNviuzt
 tISvx6TfY6Blo1O9ITvsXUP4uJw3wiflbEAF6OHclVbaRFEd7BXc0hQdUv0zAEWd8Xoy
 Q0VRRgTJNt1S+C+HpMG+/Efx9G9qAz5RQCzMu5Z1i9gHh935ImTIC47p13hPpPzAWsxL
 hkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OjCNSgu7YQ0KrYU4OrCfcxN/j7tKHgOvYd8iMYHcxps=;
 fh=1SE0EHILjgULJq5kzBArHfQC3uLeojri+7OvelsjBJw=;
 b=OR7M7Qwi773gvj7NLE8YbRIJzariCx565FTRdWNiRz9fjpOj5ScRZX25ij1p7Kmoeh
 8fgPtWQnicbT/aZ1zEyWCBJnhU01GK7+ODUjhIhMjkri20hSSECblJffd/JXmqYUWkQ0
 d5a6qKes2UstsX1g/DZRQFGWPBm1r3/ZzpREqz+PtUkNWRZDULcj6op5lWbIAKqRytZc
 hTKg7IgLET52kvQIzqlhmRH0DKaMl3wbPyJNkkiXLzjIO3fJ35uhnNv/dyMWWVd6uWCQ
 Vnhdo3UGIxtaZfwVcxpowfC+jzw7TWXeAqZ3Yl6U2TtdwVrsSSW/Gaq1gQU4ffSKOF2O
 mwHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773265909; x=1773870709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OjCNSgu7YQ0KrYU4OrCfcxN/j7tKHgOvYd8iMYHcxps=;
 b=bB/vbfzBmN/9H0ntHfEull6f7QzB1+CLlb3JsJ4ULhICAOnw9V9ovgDNFqXEs/JFYG
 2nbmY5MA2YNFkK5+DBxSmbzla2JLslfD2KUtlAdRdPrnDIWX0J6E0x+wHmXv7JDu3ZbM
 kzWjVlZFmrVjo4uW3JDoGdx+kJHufxNiE0Eaqzo0PUspjBEUNMvPzRdEIJXS91IXSL9o
 M5p+eLn0KJHCmijt7RJgbpfIi6gSibYREyW+0AMGIuTg45p7k2k6cRCVrog0etW6G3tZ
 LDFozfHYJ7oS0eQmZWUaesT0szQTcrvhNmJ8okz9OqAoPB2o1vibXeVhsdUP7Ln+35aW
 Y3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773265909; x=1773870709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjCNSgu7YQ0KrYU4OrCfcxN/j7tKHgOvYd8iMYHcxps=;
 b=C1YOvbxmq7CXePfmiB+92tEknOXuY7ZYGp5cKAL3GxL5gN3En6BwzY5djGwU/n1nXc
 77pUYfNkjQKwKXHZ19j6sG+gKyOVUeocCW6dNBf5On9VKdCaX/nXtxnf/989eA4RUdFY
 xfCeKRXfKvWRvKLycdZ1SP8sblfpO56jyqYlzGQMYP1+LDEBOG1SNZErKSlqtN+OlcGD
 JvuF4brvNPLyFo3JM6dwu2gX6+i8aq3XAsZTyNRCp8kJyUL2rfsxW5TJ3ovqkkwtF5v5
 71mtlTwY8248Q808iykYIcTnTmOxGyzVPxhtNOiICELkDrY2PyZhImucWbl50kdhbpmx
 wj5A==
X-Gm-Message-State: AOJu0YzaQKlwB7Jsieafpk0AuEx14dC4Fh6FlMG65M9Sr9RLJDArmx2b
 q1i8YcJCBgJESGGy8YEk4mPwdABMEralVGlBIfd9MMxHuWc6DfMEYb5etmOpn3nrC+LD0VZUbyn
 Y9eC4PSBigjLTNv0812OVLhKQKr3WDF87/dwTSuMsPQ1+0IZ59rAMCwyKHVFGQuDIjePrex689p
 GMUNALQErNep90c11Ev2nHQE0gJpWLhKpb
X-Gm-Gg: ATEYQzxyp8l+nBMBv923ubIkxd1LTaWuDmj3aQuPbBoZAzb7fUtNZPGn7J/5+vtjDJl
 S6Ig+6i6upWcposJp7eCq4R7ZWvBnihanzT03ZUZrjrmdpNGWZDW5IZD+ZdSAvvhrYLX/8bPbmJ
 Tw/58r5MuV9jiMsuBkuOLgJOLoAaVJ3oE9avlCsAmNHml5CIbBxox1hhLcCV+cOq8tCfyCHV+XU
 3pAc98=
X-Received: by 2002:a05:690c:386:b0:799:1967:aa22 with SMTP id
 00721157ae682-7991967b28fmr33220507b3.6.1773265909120; 
 Wed, 11 Mar 2026 14:51:49 -0700 (PDT)
X-Received: by 2002:a05:690c:386:b0:799:1967:aa22 with SMTP id
 00721157ae682-7991967b28fmr33220327b3.6.1773265908633; Wed, 11 Mar 2026
 14:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-5-brian.cain@oss.qualcomm.com>
 <88a2420d-5927-47bc-8192-4c218f219531@linaro.org>
In-Reply-To: <88a2420d-5927-47bc-8192-4c218f219531@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 16:51:32 -0500
X-Gm-Features: AaiRm513rfHWQl_HfzHZNT_cmVHSc6a83coNs-jZiI5SQj_WuSwYR1dnGsCzhGc
Message-ID: <CAEqNhNZ2=reXiDaNGOaUyZZFfdLMV_eoTWjVvbwq7EB89jGJFA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000093a23b064cc6a408"
X-Proofpoint-ORIG-GUID: aUuAaqnLGhvs9BCK6bpVaRBCVQfCeDfH
X-Proofpoint-GUID: aUuAaqnLGhvs9BCK6bpVaRBCVQfCeDfH
X-Authority-Analysis: v=2.4 cv=QLBlhwLL c=1 sm=1 tr=0 ts=69b1e3f5 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=qLx7fMown63OLscfs78A:9 a=QEXdDO2ut3YA:10 a=XEW-zMkiL7cRUJwsvXgA:9
 a=nbkW-B2-T2QjavY2:21 a=lqcHg5cX4UMA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE4NSBTYWx0ZWRfX67bDlKC/yRk6
 NcbaZjSAu8IsuIUmGCcCAjg+mRtAPtTGXMEnGGDmD+tRHljeBbnuwjURhW0HHouWyr5AjUTmS4j
 d6E/ViQ3AAvT0iTYZRPNwFLUaaO/lA4Z4Ud5K/+luKytE6LebsVNxwfw4GzyST00VvdsX9sTiIg
 xg6BnMuUldzHvoZN4RRvBNprdhsjNDGISF/PWnC4OxPhqVgFOSsEms1R5N86kE4fix2N7q0bzJc
 dEHwcJZhaNTZPC+sdU2AJZE+Eg4wG41zTopy5FAS4bzjlmvMiP7YP2aJNOvrgSG5XWsQB0GOS2a
 NqYnDDJDaEjz9bK0bPJ0T3bBfDlOfoUW9r1kO/ZppLoGcSuBPMlrWReFnAMDS3IpDwmrhO+DAl0
 uP8Kdczy+GD3Cr/WxBVxhPSnSIVSKoT014OOoHt+Ss1Jy20n71wTD9K4Bm9rXRbrapvto++Vw3S
 66jf4CszbJ5qPvfITxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000093a23b064cc6a408
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 11/3/26 05:20, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 64 ++++++++++++++++++++++
> >   hw/hexagon/machine_cfg_v68n_1024.h.inc    | 65 ++++++++++++++++++++++=
+
> >   2 files changed, 129 insertions(+)
> >   create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> >   create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
> >
> > diff --git a/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> > new file mode 100644
> > index 00000000000..3d787c104ff
> > --- /dev/null
> > +++ b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +static
>
> const
>
>    struct hexagon_machine_config SA8775P_cdsp0 =3D {
> > +    .cfgbase =3D         0x24000000 + 0x180000,
> > +    .l2tcm_size =3D      0x00000000,
> > +    .l2vic_base =3D      0x26300000 + 0x90000,
> > +    .l2vic_size =3D      0x00001000,
> > +    .csr_base =3D        0x26300000,
> > +    .qtmr_region =3D     0x26300000 + 0xA1000,
> > +    .cfgtable =3D {
> > +        .l2tcm_base =3D 0x00002400,
> > +        .reserved0 =3D 0x00000000,
> > +        .subsystem_base =3D 0x00002638,
> > +        .etm_base =3D 0x00002419,
> > +        .l2cfg_base =3D 0x0000241a,
> > +        .reserved1 =3D 0x0000241b,
> > +        .l1s0_base =3D 0x00002500,
> > +        .axi2_lowaddr =3D 0x00000000,
> > +        .streamer_base =3D 0x00000000,
> > +        .reserved2 =3D 0x00000000,
> > +        .fastl2vic_base =3D 0x0000241e,
> > +        .jtlb_size_entries =3D 0x00000080,
> > +        .coproc_present =3D 0x00000001,
> > +        .ext_contexts =3D 0x00000004,
> > +        .vtcm_base =3D 0x00002500,
> > +        .vtcm_size_kb =3D 0x00002000,
> > +        .l2tag_size =3D 0x00000400,
> > +        .l2ecomem_size =3D 0x00000000,
> > +        .thread_enable_mask =3D 0x0000003f,
> > +        .eccreg_base =3D 0x0000241f,
> > +        .l2line_size =3D 0x00000080,
> > +        .tiny_core =3D 0x00000000,
> > +        .l2itcm_size =3D 0x00000000,
> > +        .l2itcm_base =3D 0x00002400,
> > +        .reserved3 =3D 0x00000000,
> > +        .dtm_present =3D 0x00000000,
> > +        .dma_version =3D 0x00000003,
> > +        .hvx_vec_log_length =3D 0x00000007,
> > +        .core_id =3D 0x00000000,
> > +        .core_count =3D 0x00000000,
> > +        .coproc2_reg0 =3D 0x00000040,
> > +        .coproc2_reg1 =3D 0x00000020,
> > +        .v2x_mode =3D 0x00000001,
> > +        .coproc2_reg2 =3D 0x00000008,
> > +        .coproc2_reg3 =3D 0x00000020,
> > +        .coproc2_reg4 =3D 0x00000000,
> > +        .coproc2_reg5 =3D 0x00000002,
> > +        .coproc2_reg6 =3D 0x00000016,
> > +        .coproc2_reg7 =3D 0x00000006,
> > +        .acd_preset =3D 0x00000001,
> > +        .mnd_preset =3D 0x00000000,
> > +        .l1d_size_kb =3D 0x00000010,
> > +        .l1i_size_kb =3D 0x00000020,
> > +        .l1d_write_policy =3D 0x00000002,
> > +        .vtcm_bank_width =3D 0x00000080,
> > +        .reserved4 =3D 0x00000001,
> > +        .reserved5 =3D 0x00000000,
> > +        .reserved6 =3D 0x00000003,
> > +        .coproc2_cvt_mpy_size =3D 0x0000000a,
> > +        .consistency_domain =3D 0x000000e0,
> > +        .capacity_domain =3D 0x00000080,
> > +        .axi3_lowaddr =3D 0x00000000,
> > +    },
> > +};
> > diff --git a/hw/hexagon/machine_cfg_v68n_1024.h.inc
> b/hw/hexagon/machine_cfg_v68n_1024.h.inc
> > new file mode 100644
> > index 00000000000..734a12a2f12
> > --- /dev/null
> > +++ b/hw/hexagon/machine_cfg_v68n_1024.h.inc
> > @@ -0,0 +1,65 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +static struct hexagon_machine_config v68n_1024 =3D {
>
> Ditto.
>
> > +    .cfgbase =3D           0xde000000,
> > +    .l2tcm_size =3D        0x00000000,
> > +    .l2vic_base =3D        0xfc910000,
> > +    .l2vic_size =3D        0x00001000,
> > +    .csr_base =3D          0xfc900000,
> > +    .qtmr_region =3D       0xfc921000,
> > +    .cfgtable =3D {
> > +        .l2tcm_base =3D 0x0000d800,
> > +        .reserved0 =3D 0x00000000,
> > +        .subsystem_base =3D 0x0000fc90,
> > +        .etm_base =3D 0x0000d819,
> > +        .l2cfg_base =3D 0x0000d81a,
> > +        .reserved1 =3D 0x00000000,
> > +        .l1s0_base =3D 0x0000d840,
> > +        .axi2_lowaddr =3D 0x00003000,
> > +        .streamer_base =3D 0x0000d81c,
> > +        .reserved2 =3D 0x0000d81d,
> > +        .fastl2vic_base =3D 0x0000d81e,
> > +        .jtlb_size_entries =3D 0x00000080,
> > +        .coproc_present =3D 0x00000001,
> > +        .ext_contexts =3D 0x00000004,
> > +        .vtcm_base =3D 0x0000d840,
> > +        .vtcm_size_kb =3D 0x00001000,
> > +        .l2tag_size =3D 0x00000400,
> > +        .l2ecomem_size =3D 0x00000400,
> > +        .thread_enable_mask =3D 0x0000003f,
> > +        .eccreg_base =3D 0x0000d81f,
> > +        .l2line_size =3D 0x00000080,
> > +        .tiny_core =3D 0x00000000,
> > +        .l2itcm_size =3D 0x00000000,
> > +        .l2itcm_base =3D 0x0000d820,
> > +        .reserved3 =3D 0x00000000,
> > +        .dtm_present =3D 0x00000000,
> > +        .dma_version =3D 0x00000001,
> > +        .hvx_vec_log_length =3D 0x00000007,
> > +        .core_id =3D 0x00000000,
> > +        .core_count =3D 0x00000000,
> > +        .coproc2_reg0 =3D 0x00000040,
> > +        .coproc2_reg1 =3D 0x00000020,
> > +        .v2x_mode =3D 0x1f1f1f1f,
> > +        .coproc2_reg2 =3D 0x1f1f1f1f,
> > +        .coproc2_reg3 =3D 0x1f1f1f1f,
> > +        .coproc2_reg4 =3D 0x1f1f1f1f,
> > +        .coproc2_reg5 =3D 0x1f1f1f1f,
> > +        .coproc2_reg6 =3D 0x1f1f1f1f,
> > +        .coproc2_reg7 =3D 0x1f1f1f1f,
> > +        .acd_preset =3D 0x1f1f1f1f,
> > +        .mnd_preset =3D 0x1f1f1f1f,
> > +        .l1d_size_kb =3D 0x1f1f1f1f,
> > +        .l1i_size_kb =3D 0x1f1f1f1f,
> > +        .l1d_write_policy =3D 0x1f1f1f1f,
> > +        .vtcm_bank_width =3D 0x1f1f1f1f,
> > +        .reserved4 =3D 0x1f1f1f1f,
> > +        .reserved5 =3D 0x1f1f1f1f,
> > +        .reserved6 =3D 0x1f1f1f1f,
> > +        .coproc2_cvt_mpy_size =3D 0x1f1f1f1f,
> > +        .consistency_domain =3D 0x1f1f1f1f,
> > +        .capacity_domain =3D 0x1f1f1f1f,
> > +        .axi3_lowaddr =3D 0x1f1f1f1f,
> > +    },
> > +};
> > +
>
> Are these configs generated?
>

No - but they are taken via a dump from a donor system.

--00000000000093a23b064cc6a408
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2026 at=
 12:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 11/3/26 05:20, Brian Cain wrote:<br>
&gt; From: Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com" target=3D"_b=
lank">bcain@quicinc.com</a>&gt;<br>
&gt; <br>
&gt; Acked-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcom=
m.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 64 +++++++++++=
+++++++++++<br>
&gt;=C2=A0 =C2=A0hw/hexagon/machine_cfg_v68n_1024.h.inc=C2=A0 =C2=A0 | 65 +=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 129 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.i=
nc<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc<=
br>
&gt; <br>
&gt; diff --git a/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc b/hw/hexagon/ma=
chine_cfg_sa8775_cdsp0.h.inc<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..3d787c104ff<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc<br>
&gt; @@ -0,0 +1,64 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt; +<br>
&gt; +static <br>
<br>
const<br>
<br>
=C2=A0 =C2=A0struct hexagon_machine_config SA8775P_cdsp0 =3D {<br>
&gt; +=C2=A0 =C2=A0 .cfgbase =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2400000=
0 + 0x180000,<br>
&gt; +=C2=A0 =C2=A0 .l2tcm_size =3D=C2=A0 =C2=A0 =C2=A0 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 .l2vic_base =3D=C2=A0 =C2=A0 =C2=A0 0x26300000 + 0x9000=
0,<br>
&gt; +=C2=A0 =C2=A0 .l2vic_size =3D=C2=A0 =C2=A0 =C2=A0 0x00001000,<br>
&gt; +=C2=A0 =C2=A0 .csr_base =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x26300000,<br=
>
&gt; +=C2=A0 =C2=A0 .qtmr_region =3D=C2=A0 =C2=A0 =C2=A00x26300000 + 0xA100=
0,<br>
&gt; +=C2=A0 =C2=A0 .cfgtable =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2tcm_base =3D 0x00002400,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved0 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .subsystem_base =3D 0x00002638,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .etm_base =3D 0x00002419,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2cfg_base =3D 0x0000241a,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved1 =3D 0x0000241b,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1s0_base =3D 0x00002500,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .axi2_lowaddr =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .streamer_base =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved2 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .fastl2vic_base =3D 0x0000241e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .jtlb_size_entries =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc_present =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ext_contexts =3D 0x00000004,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_base =3D 0x00002500,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_size_kb =3D 0x00002000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2tag_size =3D 0x00000400,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2ecomem_size =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .thread_enable_mask =3D 0x0000003f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eccreg_base =3D 0x0000241f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2line_size =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tiny_core =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2itcm_size =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2itcm_base =3D 0x00002400,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved3 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dtm_present =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dma_version =3D 0x00000003,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hvx_vec_log_length =3D 0x00000007,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .core_id =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .core_count =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg0 =3D 0x00000040,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg1 =3D 0x00000020,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .v2x_mode =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg2 =3D 0x00000008,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg3 =3D 0x00000020,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg4 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg5 =3D 0x00000002,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg6 =3D 0x00000016,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg7 =3D 0x00000006,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .acd_preset =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mnd_preset =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1d_size_kb =3D 0x00000010,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1i_size_kb =3D 0x00000020,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1d_write_policy =3D 0x00000002,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_bank_width =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved4 =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved5 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved6 =3D 0x00000003,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_cvt_mpy_size =3D 0x0000000a,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .consistency_domain =3D 0x000000e0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .capacity_domain =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .axi3_lowaddr =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; diff --git a/hw/hexagon/machine_cfg_v68n_1024.h.inc b/hw/hexagon/machi=
ne_cfg_v68n_1024.h.inc<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..734a12a2f12<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/hexagon/machine_cfg_v68n_1024.h.inc<br>
&gt; @@ -0,0 +1,65 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt; +<br>
&gt; +static struct hexagon_machine_config v68n_1024 =3D {<br>
<br>
Ditto.<br>
<br>
&gt; +=C2=A0 =C2=A0 .cfgbase =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
de000000,<br>
&gt; +=C2=A0 =C2=A0 .l2tcm_size =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,<=
br>
&gt; +=C2=A0 =C2=A0 .l2vic_base =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xfc910000,<=
br>
&gt; +=C2=A0 =C2=A0 .l2vic_size =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00001000,<=
br>
&gt; +=C2=A0 =C2=A0 .csr_base =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xfc900=
000,<br>
&gt; +=C2=A0 =C2=A0 .qtmr_region =3D=C2=A0 =C2=A0 =C2=A0 =C2=A00xfc921000,<=
br>
&gt; +=C2=A0 =C2=A0 .cfgtable =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2tcm_base =3D 0x0000d800,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved0 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .subsystem_base =3D 0x0000fc90,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .etm_base =3D 0x0000d819,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2cfg_base =3D 0x0000d81a,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved1 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1s0_base =3D 0x0000d840,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .axi2_lowaddr =3D 0x00003000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .streamer_base =3D 0x0000d81c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved2 =3D 0x0000d81d,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .fastl2vic_base =3D 0x0000d81e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .jtlb_size_entries =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc_present =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ext_contexts =3D 0x00000004,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_base =3D 0x0000d840,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_size_kb =3D 0x00001000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2tag_size =3D 0x00000400,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2ecomem_size =3D 0x00000400,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .thread_enable_mask =3D 0x0000003f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .eccreg_base =3D 0x0000d81f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2line_size =3D 0x00000080,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tiny_core =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2itcm_size =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l2itcm_base =3D 0x0000d820,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved3 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dtm_present =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .dma_version =3D 0x00000001,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hvx_vec_log_length =3D 0x00000007,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .core_id =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .core_count =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg0 =3D 0x00000040,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg1 =3D 0x00000020,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .v2x_mode =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg2 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg3 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg4 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg5 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg6 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_reg7 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .acd_preset =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mnd_preset =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1d_size_kb =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1i_size_kb =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .l1d_write_policy =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vtcm_bank_width =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved4 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved5 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reserved6 =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .coproc2_cvt_mpy_size =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .consistency_domain =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .capacity_domain =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .axi3_lowaddr =3D 0x1f1f1f1f,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
<br>
Are these configs generated?<br></blockquote><div><br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace">No - but they are taken via a=
 dump from a donor system.</div></div></div>

--00000000000093a23b064cc6a408--

