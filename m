Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11D3CD6E60
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUwCr-0002KZ-2O; Wed, 03 Jun 2026 20:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUwCn-0002Hk-Sv
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:45:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUwCk-00089V-HS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:45:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653LeLuR3240201
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 00:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mc3ZWbPaUP7iv6VT2w71TPYqlZKyIJ7QvI4dzFshBck=; b=AArGYV7O1d3Hks+k
 4SfgxN1Cn6BPHreVCuFvUS4gS0BbnIsEcU8KYGKqserakftbMRgfre8xZdHFfrav
 EkEo1OmQI1+7hBIs+EHVk5c8xRETy1bX/Zo0eC+HLeOsAbldh6dRDkeFRCJRy527
 e10jxtiEk4bcbVqGw+H1XS+BbHIrG6u5iSq46W0xCh230bUBESSho/Gy9zURdkFx
 PPPrYsaIHdxviLfI8Qj/dKPAZbKVdVH0HTdjolLgYaxe2d2IRDUaOWpxrqui0sl/
 lKLXQIRX2VqAWpvSZHDuHyrkrFOqkEn8lkGKu7c01g4nmb0UZbWksJuFJZaRey5K
 uVR0pA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd08g9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 00:44:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137f2083280so509770c88.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780533898; cv=none;
 d=google.com; s=arc-20240605;
 b=c19opjAZ0pKSuLIo2Aj4ZREe6D3+O+Hu4SPHpzHtsXlZ94Xq54a6S+UrQPhkJw2Hwv
 3GXN6Iu38YG5VEe0mNkNCL1mBEy66vh/+P5qqMQjDNqlYFJlgDO97IKmbw0rCCtKCLt/
 G7b06MiC4GyBUTuPjrzQSew96EyQ55B5maWIHtcMFg5Pp1blE9cwR5T+v5W0YPnaiife
 OJzaZAzf5wf4pN4mcpAAlfqp+tpVQZ7kr7WbmIoPyxq+boaTqn9qp0E9VzrPUa1I9HCS
 0XWtKoNj6W+LYADoODXpkkg8CUv1E7IfS1v3SlG44zI19FTeMh9w/GSP3OcS5LFoQJpm
 OM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mc3ZWbPaUP7iv6VT2w71TPYqlZKyIJ7QvI4dzFshBck=;
 fh=bd4NqF8mWkw5BKad7KyyuY5CBD+jIgRsk3tsaCztl6A=;
 b=cp6ZyMEPs8sNXV8vH1RxRSMiZiH7hFwX6zzIDywF55YCAvxJY2hvllYsWlqN3HgtAB
 thATMzGC5yM+T7M23hx9ozoIUAsIbMhga8IZ3AxFKJ0LF4Bbta2QqRGmfXQs07gTCIl9
 CCuyU8J+G4mPxrwa67j8FpEPkJaywXw+lwUgTEg8Gq1bhSWOkFZ9dQzd1ZolIL/IN0Jr
 5xn3abK/ymO+s2dFsPe1Z5rsxyakPXW2BMP2/6cEHf6qOofaReMIUCZSvBaG9hz1BXwg
 lK00PuVgwdpMKiJt5P1GCTOJ4w6IywP5AxELm1OOXvoApIU1VYDBQvYHSRevDNT7S5w2
 J5QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780533898; x=1781138698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mc3ZWbPaUP7iv6VT2w71TPYqlZKyIJ7QvI4dzFshBck=;
 b=dSAqAYfZqGC3MZP5j94uJ4l8mIvcy7Xqgkn4aDSICNXUrmKBHCp2vzqDNjZrtjk2mT
 eB1pasaIwTfMQChj0YfJOxFUALVjx7PfdGc5pV0f3Elhm3+VCa6ZNf5ogY7u1as+e3c/
 9CfcvjYnvmDS3Ye9DgaF2RhEnkgU3G3U0k5lCY3LxYpK8j3yYfOTNWb9ha2HaYi21qJr
 N+Vta/V0R3yg1Czm+kWJaJ8WMnPJfcnGE6OMDW2fqLJ+yTDJ105Zxt6pLOmsUHriOMl0
 ZYLzz7KhAYokdk1mLQrwEIZ1lzqEqsjLB97aFaLKjFPPn1LtOAkJFewYDuV+Cha8urs3
 mCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533898; x=1781138698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mc3ZWbPaUP7iv6VT2w71TPYqlZKyIJ7QvI4dzFshBck=;
 b=tS1pn37oiFCkGw/ShgSwrzAZ3Z9J8Dbkx4BsLu9LhJBf/7M6m8J6jnI1z4tYeDwTBc
 tG0ScSVRj5q2e352OukVaA8esMeTmu0G1zRmFAeJrJgwSYBLD4IfXdNKBieCUODvHAV0
 i4vDFMy+exPi8fWGL/Mj4ixVJ91UCvxYpwZuhzAkKa28gpbxXhoyirqb2maalFRxCFgM
 QY/LkYiS2cI0XD46wju8e4sXetKDt0DXe6NvQKUquXOeaZ26AmC8oi3dhvagDbt4LcxB
 DHqYuM+ZD3RPJAMgR4ygw6QB47cwJf08YnU+MwED7genb9KYeW45jIQM9h6SpNUjWDET
 7Oig==
X-Gm-Message-State: AOJu0YyurZtREyaRktlxpgROAXaym6JM3kozcGwAxjyNAI0RNd9lQCPf
 P6HvwUH9m/NTfVkTatzHu5+MYjKzct2YJ1S9Y7vQP+hios26zSRD5ivFoiixopFaoVxIezFRiSr
 7wCqUDJCJpWa2SCH+wH7zjRN9osXZCkORk5IeBnhDhvQniDPDEZD+ZxTpkZ2hXqFhnS8NYLowUN
 thyi+yugieinFJR3S/DOwlP+7MnzUBMO7Q
X-Gm-Gg: Acq92OGFdo4hyaWaaDOGYOurQT7hEllA0W7znjYJArMu/WwGJ0I3HfbK7TtV6ApiNkz
 xhckOgc8+1omrR8JQYbCiQrmunI4xQzgq+BUhIeLef9SSAzplpSb19c51lL056Flyb4LxCLf7NT
 xF5lgLr3Ve67w/D/9zMIbmfktHQXc5fuAMTGQ4jOdxDZH7QvjCyhwD8C1hcRuI+Liq4SCjaRZmX
 KCUKYsLpOhR1OSiNw==
X-Received: by 2002:a05:7022:2390:b0:137:ea56:370 with SMTP id
 a92af1059eb24-137f6bb37aemr2318184c88.20.1780533898095; 
 Wed, 03 Jun 2026 17:44:58 -0700 (PDT)
X-Received: by 2002:a05:7022:2390:b0:137:ea56:370 with SMTP id
 a92af1059eb24-137f6bb37aemr2318172c88.20.1780533897529; Wed, 03 Jun 2026
 17:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 19:44:40 -0500
X-Gm-Features: AVHnY4I_Jo7JS1p_sgmCzIaTy_XRPHekQm9uUeuC70Bz8NweA5urm409KXUiWmI
Message-ID: <CAEqNhNaqmdRQ-VX57Nx+iVyK9MbZa+MiBj-3KHSErufwWeUitg@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] hexagon: add missing HVX float instructions
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: lBCQN45UTn1KL04Gy-fbpvpfLzMT-dtx
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a20ca8b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SnclFv0j17a7PWJ5ACwA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: lBCQN45UTn1KL04Gy-fbpvpfLzMT-dtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAwNCBTYWx0ZWRfX/H0Gk0hqVVRB
 BDp65VZU5OG2BA49XV6rSxe0g9gjgZq/2oImH9h77yDlPOw3qBMgN9DZLH81I0XpLFk0bpGRgPo
 Bg9I6aNbz4XRfwjyIwikpvAeAJYiX5C2wJXNYXlW8U219GP9tlACDdiYpZU5sZ3neCyBu4wKp6M
 b/wdWYMfkVpoAprrXbnSmVPZXOgoupP1s4Qby7vdEF6gOm8TpoSFSPtgEIfPHZ+wYR1lyoAQ14l
 0Scrkrt5S+bpU3EQbmIM2Dvft+HcMTjEm17/OklCr1a1LD7cf4+Kf7bRWRZj0gXFPtHgexPFeee
 knOWG6odiMql6wKXzFMigK+BOp4UMn8FzAyK0PDORFksizvL6B0sL6/vUQ+MtIKvxhOK8JmZp41
 i/OAomQ5vr/uowDRABjJuErXhXVChbR6sVTMS/EkiZrb4OLahFVmnL1/qKYYQJSgCh/H/QZXXH0
 4/iMxuX9xDy1zdDS67w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040004
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

On Thu, Apr 16, 2026 at 6:39=E2=80=AFAM Matheus Tavares Bernardino
<matheus.bernardino@oss.qualcomm.com> wrote:
>
> This patchset adds 59 HVX floating point instructions from Hexagon
> revisions v68 and v73 that were missing in qemu. Tests are also added at
> the end.
>
> v4: https://lore.kernel.org/qemu-devel/cover.1775843299.git.matheus.berna=
rdino@oss.qualcomm.com/
> v3: https://lore.kernel.org/qemu-devel/cover.1775665981.git.matheus.berna=
rdino@oss.qualcomm.com/
> v2: https://lore.kernel.org/qemu-devel/cover.1775122853.git.matheus.berna=
rdino@oss.qualcomm.com/
> v1: https://lore.kernel.org/qemu-devel/cover.1774271525.git.matheus.berna=
rdino@oss.qualcomm.com/
>
> Changes in v5:
>         - patch 11: fixed copy-and-paste error (s/vmax/vmin)
>         - patch 16: replaced float16 value for BF_* constants for
>           clearity
>

For the series:

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> Brian Cain (1):
>   tests/docker: Update hexagon cross toolchain to 22.1.0
>
> Matheus Tavares Bernardino (15):
>   target/hexagon: fix incorrect/too-permissive HVX encodings
>   target/hexagon/cpu: add HVX IEEE FP extension
>   hexagon: group cpu configurations in their own struct
>   hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
>   target/hexagon: add v68 HVX IEEE float arithmetic insns
>   target/hexagon: add v68 HVX IEEE float min/max insns
>   target/hexagon: add v68 HVX IEEE float misc insns
>   target/hexagon: add v68 HVX IEEE float conversion insns
>   target/hexagon: add v68 HVX IEEE float compare insns
>   target/hexagon: add v73 HVX IEEE bfloat16 insns
>   tests/hexagon: add tests for v68 HVX IEEE float arithmetics
>   tests/hexagon: add tests for v68 HVX IEEE float min/max
>   tests/hexagon: add tests for v68 HVX IEEE float conversions
>   tests/hexagon: add tests for v68 HVX IEEE float comparisons
>   tests/hexagon: add tests for HVX bfloat
>
>  target/hexagon/cpu.h                          |  10 +-
>  target/hexagon/cpu_bits.h                     |  10 +-
>  target/hexagon/mmvec/hvx_ieee_fp.h            |  69 ++++
>  target/hexagon/mmvec/macros.h                 |   8 +
>  target/hexagon/mmvec/mmvec.h                  |   3 +
>  target/hexagon/printinsn.h                    |   2 +-
>  target/hexagon/translate.h                    |   1 +
>  tests/tcg/hexagon/hex_test.h                  |  32 ++
>  tests/tcg/hexagon/hvx_misc.h                  |  73 ++++
>  target/hexagon/attribs_def.h.inc              |   9 +
>  disas/hexagon.c                               |   3 +-
>  target/hexagon/arch.c                         |   8 +
>  target/hexagon/cpu.c                          |  18 +-
>  target/hexagon/decode.c                       |   4 +-
>  target/hexagon/mmvec/hvx_ieee_fp.c            | 137 +++++++
>  target/hexagon/printinsn.c                    |   7 +-
>  target/hexagon/translate.c                    |   5 +-
>  tests/tcg/hexagon/fp_hvx.c                    | 226 +++++++++++
>  tests/tcg/hexagon/fp_hvx_cmp.c                | 275 +++++++++++++
>  tests/tcg/hexagon/fp_hvx_cvt.c                | 219 +++++++++++
>  tests/tcg/hexagon/fp_hvx_disabled.c           |  57 +++
>  target/hexagon/gen_tcg_funcs.py               |  11 +
>  target/hexagon/hex_common.py                  |  27 ++
>  target/hexagon/imported/mmvec/encode_ext.def  | 126 ++++--
>  target/hexagon/imported/mmvec/ext.idef        | 369 +++++++++++++++++-
>  target/hexagon/meson.build                    |   1 +
>  .../dockerfiles/debian-hexagon-cross.docker   |  10 +-
>  tests/tcg/hexagon/Makefile.target             |  14 +
>  28 files changed, 1686 insertions(+), 48 deletions(-)
>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
>  create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c
>
> Range-diff against v4:
>  1:  1440dd86da =3D  1:  e94d57178d tests/docker: Update hexagon cross to=
olchain to 22.1.0
>  2:  b9a5a46b82 =3D  2:  1fe4b8a0fc target/hexagon: fix incorrect/too-per=
missive HVX encodings
>  3:  7889db953a =3D  3:  10fb5b86db target/hexagon/cpu: add HVX IEEE FP e=
xtension
>  4:  ac72a36fd8 =3D  4:  8f9a2e2ccf hexagon: group cpu configurations in =
their own struct
>  5:  e24b76d95a =3D  5:  1bdc772e4a hexagon: print info on "-d in_asm" fo=
r disabled IEEE FP instructions
>  6:  8c9ded658c =3D  6:  8923b6c6bc target/hexagon: add v68 HVX IEEE floa=
t arithmetic insns
>  7:  a89b231b2c =3D  7:  8e274a7a10 target/hexagon: add v68 HVX IEEE floa=
t min/max insns
>  8:  27a5ca1ce3 =3D  8:  0bd3279ca0 target/hexagon: add v68 HVX IEEE floa=
t misc insns
>  9:  7fecae322c =3D  9:  beca620d2e target/hexagon: add v68 HVX IEEE floa=
t conversion insns
> 10:  ebc920dfcf =3D 10:  96e27588ad target/hexagon: add v68 HVX IEEE floa=
t compare insns
> 11:  d408ee2b2c ! 11:  1a25337356 target/hexagon: add v73 HVX IEEE bfloat=
16 insns
>     @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_SHIFT_SLOT_F=
LT(16, vconv_h
>      +    "Vector IEEE max: bf", VdV.bf[i] =3D fp_max_bf(VuV.bf[i], VvV.b=
f[i]);
>      +    fBFLOAT())
>      +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmin_bf, "Vd32.bf=3Dvmin(Vu32.=
bf,Vv32.bf)",
>     -+    "Vector IEEE max: bf", VdV.bf[i] =3D fp_min_bf(VuV.bf[i], VvV.b=
f[i]);
>     ++    "Vector IEEE min: bf", VdV.bf[i] =3D fp_min_bf(VuV.bf[i], VvV.b=
f[i]);
>      +    fBFLOAT())
>
>       /******************************************************************=
************
> 12:  cde613d444 =3D 12:  791f122bfd tests/hexagon: add tests for v68 HVX =
IEEE float arithmetics
> 13:  08abae5ee5 =3D 13:  7fdbc12ed4 tests/hexagon: add tests for v68 HVX =
IEEE float min/max
> 14:  c20a21aad6 =3D 14:  ec6af07a28 tests/hexagon: add tests for v68 HVX =
IEEE float conversions
> 15:  6b473acaf5 =3D 15:  53e7370709 tests/hexagon: add tests for v68 HVX =
IEEE float comparisons
> 16:  10ebb63b81 ! 16:  392114c4c1 tests/hexagon: add tests for HVX bfloat
>     @@ tests/tcg/hexagon/fp_hvx_cmp.c: static void test_cmp_hf(void)
>      +
>      +    /* Common numbers */
>      +    PREP_TEST();
>     -+    TEST_CMP_GT(bf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.1));
>     -+    TEST_CMP_GT(bf, raw_hf((_Float16)0),    raw_hf((_Float16)-2.2))=
;
>     ++    TEST_CMP_GT(bf, BF_two, BF_one);
>     ++    TEST_CMP_GT(bf, BF_one, BF_zero);
>      +    CHECK(bf, 2);
>      +
>      +    /* Infinity vs Infinity/NaN */
> --
> 2.37.2
>

