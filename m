Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CD0CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHn3B-0007Tb-K9; Fri, 16 Oct 2026 14:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHn39-0007TB-9x
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:53:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHn37-0005zM-EO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:53:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI8UxZ3018291
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7m6wkse2cY3Tel/LaJLzDjcd4virz0c0XIgCGwhWEO8=; b=jAOMSTa01JsixRVT
 J1xQyLMDxCiWGclsm41aM/ZWdedKFDGsYRBmL8S8ZhsgqeledWTIKtQJq73uGTzh
 GOosGzULfqIDvqs3+RBznAjF+IJX5tvkfcunrnMuYy16gSqVc3oGHVsNLpQGXxV3
 zQsF3RVGckQhcUohl2jKuMbxlsPt+35mP6S9ph+8zn8BKf0PoTzAHR3bK0i7nSYQ
 dt/fSGIoypDhc6ywGNw/O2ajt7K3su1N6h/BFciANhN+gGDxmi02+CxTWSDGfilA
 j+mYKESCBoBiDgw3Lh/RsLw5GYMeMGtFVi0lT2N0Cjs5a/WwdiwdDqIOXoafD+qZ
 iR9acA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrwmr534-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:52:58 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4f2040e10d8so295967b6e.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792176778; cv=none;
 d=google.com; s=arc-20260327;
 b=ExH3iGE3+BBxEx/7ZLBGQtA+bEat8WfF0QWsJ1VqE0rJY8qsQ9DcfDRamhLaFxmDG/
 cH2KEOKiVljdoFOMJNBmarW2lgiu4JZmtYUsLKJ8LmK3gR6mS0mVOPYPyR3zNnzHg5DW
 Bt5cPxQsBB/46E56NMCx2qUwSur6yoQ9Me2LOPkpXHqA7a5PDB5GJLI+LtRKEt+LYXoJ
 CIk+DQZdAFdgTM1uqX6l6Ni9oiZFJ0Syt/ZADfx9HNibBnllsabvwuQKJNO4q4F4W3LA
 gCcTZU3IEmPM5VDjTT+eHdoA7iNFFW9QjE5+RbMLu8rlG6xUKm+S3WkHVrgBG2uLGoK0
 J1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7m6wkse2cY3Tel/LaJLzDjcd4virz0c0XIgCGwhWEO8=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=YGogtoR69MxiRcODcCad2XQyAS13VdfBa1NWM80uPItXcT6BOcAR40JejSSmwaE0a7
 Ne0aRq7r16iOyR6hSSoHLMGhDfZ3XoOgnm2uwMNXeK76hEegZgUuvbKJb+t7MggsV+jq
 eZcmELFOxIqY0xSN1CTLH+X28Ck835JykNuEorp6gSdr27kB8niQoPvb2WV9nfB/r9Ys
 OYjgFV5bNMDYesHYGR1pLcAb563OVMY8siMhaRy2InGUN3CiRy7svkzZHxpLepQe5Pjc
 eeYEF2Wd5fXFsJuKNHygAFCenQNuOE2//CUtp8o526Hc/ANB61I68QFTWkZwiRuJ9PAf
 78Gw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792176778; x=1792781578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7m6wkse2cY3Tel/LaJLzDjcd4virz0c0XIgCGwhWEO8=;
 b=XgGWBmO/qwm61n3uqB9+1thBu1fGz29Z7vkeb/C1YF+LHf9gc+Ew/E52Xs8Q4kFf+A
 29eXx77jt+xcyJ5Z9frh6oACC25TztlorF7dkVGiCgXC6eEhRNym6mvoNYhNPNYtQXQI
 2GqVam54IuDs3YfQz1OE5MdjYx7f1pxYnU1x0WKXtyrXiiusstL2L6C9xChJgCViYzcB
 ZKDEyu+MXxADJiCbrjo+MY8cEFia5wbaLzM3OsLFaQS8KUyThTT+FJNuvz9E6XeL2d/I
 sluRu/UA0y+3Nr0HWS84ngYpqfsYinuBEVvGParQ7iaBsUNruhKHRQHMRsAZQgXvZKxS
 SpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792176778; x=1792781578;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7m6wkse2cY3Tel/LaJLzDjcd4virz0c0XIgCGwhWEO8=;
 b=wsM0byWVqTDiDgSGFL4ihcaJmXhZHJM0URnuahZEcknAEGzyiPWK/MuPO860QvUAY+
 ONeKymvpa6bqEEo7/45lJrKt4uf2OnBsG5YBR9SpkXVBXJM2CzHAJOkyu4SHnXCh+bat
 qZroJxZleX4tTnqQ6XwTtaIEtFaDBbhD6+SCeRKlBRVS3uh0WDweTmwx4O3Dx8VF3Oag
 XWr6XxlNF8uZ6YUPHrqcyC584xcdsPQrpOAiAZNJALiC/OEAUY92J36RSUBJqJc+XVOX
 HUNRFQlv/Pj1x0uGcNfmBtSjBwPo8NDn2LTBBI+Qz3PQYIlG3x/HfVS5G4erTyYuk5Yk
 VAOg==
X-Gm-Message-State: AFq9FYJrOUg89k7XWP9axEasSHpgFxxhEKBC72UjYFLHZMsg3M8Y+W6p
 25WJ1nhT6Ox6VO3zD2M83fwEbpnqYYBISSxOLXrLaLcPFyNOfdeILKrRz/pS0Y9J395mNN6VuQ0
 KuzNzpX+j63K1oMJa00rigDJu4eIeegXW+wVlYSJOXk3hnRDGaSFMyiImwOvfIPDIxQQafHv7uU
 UuiMpM6erPDA8JvdeDnuuA4v9904GKAtqL
X-Gm-Gg: AYBFou3xUttecVZ6h+U/BWXL6GTczG93YWMn55PBrgg31qzJc9W59D5YSkUg+YaPgXk
 sVMwbCVgB4eKoZJCh6lu5FCDERpi/IQ/mPPna0F4NhM3InbrY/8Gbo/m3C/wvc0HI52xe2R3W8t
 ndwPsv8N7PQ9Wf4at+WwqoMOnhXEiXFi5YSNvHF63L/72LPr+OHvs9f1ijSs7eRng1evu3Vy+wh
 R20Nxlb+/ZRyjDP+VQ=
X-Received: by 2002:a05:6808:4f5f:b0:4b9:e5fa:8a14 with SMTP id
 5614622812f47-53cce84f0e3mr507291b6e.25.1792176777796; 
 Fri, 16 Oct 2026 11:52:57 -0700 (PDT)
X-Received: by 2002:a05:6808:4f5f:b0:4b9:e5fa:8a14 with SMTP id
 5614622812f47-53cce84f0e3mr507273b6e.25.1792176777289; Fri, 16 Oct 2026
 11:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:52:27 -0500
X-Gm-Features: AclHuK_NiLX7h7PYtpy97grDxxA1OoxLE1mXXzJ8uNC-PfHlOyUvzSq4XIuAHEA
Message-ID: <CAJ+KCYP4L_JamaaVJVu1jJzuTzW2xea5tzNMbXXRgc+xci9S5w@mail.gmail.com>
Subject: Re: [PATCH 08/12] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=B4osQ+tM c=1 sm=1 tr=0 ts=6ad2728a cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=7DSz-Noya--EP7XBUNYA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3NSBTYWx0ZWRfX3DxRdbeg7ruj
 v+r4ZC5gNA9woRwBmEbHphYBlKP3TsqFk2ViB2M1qwYMW22ptkltiaAipxbQb0YjyF/L5zAfCk3
 0BYjqz+fCxpiUUXK9qPzglQr0xOCZ+ckjlKsAwuoQ95tFOQPPjjS8YS5X8MLLtBfz5wc3ilvaDd
 IAGUgFk90qPfShH+6hkG7tVmcoP3pF5BUIdNn7O2s92tX0sJndCqyQaZZQ8gNwUVoSxUPEvHt3P
 Qo9A4hYHHOZfWUspfb8TP4BfinPyYPaFaWCe11jSWLT9Ozpt9VFjncPWyi9/RSbiF3FeI4h7pSm
 dYrpQnutBCtAkiZG1VZcY/YzpIgOY6+6gOVn6aEv3l6n3aJknAI74RAzTGNWmF1Vg25o0CPpuRk
 qnzP1i15nATU0PIOcPaIhBL/LnNidoICtxJ1vmcoK0VuqYSoCAgN6YLhYey8aed04nU2XfQHh8I
 oqheb8dvTCzg0W2iuug==
X-Proofpoint-ORIG-GUID: tZ1rvyLBuZ_uB58Lo6udE5o4Qy7JC2wH
X-Proofpoint-GUID: tZ1rvyLBuZ_uB58Lo6udE5o4Qy7JC2wH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3NSBTYWx0ZWRfX2o4WoKO5/9sc
 rdkfGmIvlTVZZUVZPK1/HpuHg2tDARx5XFCiWbo16wLBWHaTWfAkuRHohFrEUvB17Ap1dIIPChh
 Nfjbz/J0sVKvw+vmEQv+sEiLxk5Z300=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Bit 7 of L4_loadw_phys is valid through v81 but reserved starting
> with v83. Decode it as a legacy don't-care bit, then reject it for v83
> and later.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index 89e961331ff..9e8ff5d608c 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -721,6 +721,11 @@ int decode_packet(DisasContext *ctx, int max_words, =
const uint32_t *words,
>              /* Invalid instruction encoding */
>              return 0;
>          }
> +        /* Bit 7 of L4_loadw_phys became reserved in v83. */
> +        if (ctx->hex_def->hex_version >=3D HEX_VER_V83 &&

The check should include hex_version !=3D HEX_VER_ANY, otherwise it breaks
-d in_asm for any version below 83

> +            insn->opcode =3D=3D L4_loadw_phys && (encoding32 & 0x80)) {
> +            return 0;
> +        }
>          /*
>           * If we saw an extender, mark next word extended so immediate
>           * decode works
> --
> 2.34.1
>

