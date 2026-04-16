Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C46F433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFTu-0002Mp-Fl; Thu, 16 Apr 2026 01:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDFTt-0002MY-64
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:41:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDFTq-0006gm-ST
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:41:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G27dZX4052561
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P8lfikykxm5siW13bDJwPXa8hrsDtJ/c5KLESjyJys0=; b=AMQuQ0VANRJRqw39
 +Usd7w2UWi9ZaeWQy6p23ShExaIvcwvv+uRCC3lfSyELMbHmQI4EOS79t2AABSpl
 AlktTrQvwO940YpiKQPkLr1hG4xbivz50ruhEYcAfqqxJUle7OlluqsDQL7CllF0
 YA7lKB121dLdUVALhECrc/znEtCc3h+pFsOIz8j3/Pd5Y6vDVl5B236XtK8m0lBb
 FgsYfkCVktXTduhN/VNBsIsnrTUmRQmRTARndwease6ug9SPJj5boHnx3wRnviX0
 0E+hXO+lPeBnRWzJdTCl9vNzEEwbWX0kr6ZH1rOgXGwNbxoTHxnCip3XfAMmaL49
 seT8XA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7s5unxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:41:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd1c74508cso6267505eec.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776318091; cv=none;
 d=google.com; s=arc-20240605;
 b=d2IM5BxMwVxaNcJ+TTVs1bUTfd7zWINjUuHw7JD5eIwr4jVxHMDn103Je7AijXOyNn
 6r/mXjzNbJtMaOPHzwM59Q3dsR46RVjfr5v9N0Z/OswRI5f/9NHoXVmus7nj8CwYGZ7v
 Zz4mL8/0F1/G9rFE7F85tSIRilj+MHJNxstGBtMa9PwKd0jRE+EDsf5veVWCjGCTF3zZ
 siNSKD2DtGqCAytRDcIwGcrtGSAsXElbYc/Oy+rVCVBKROAUcNffTFAfxk40/INPUm+f
 HIycAn/3PQtF6njS99pTHR9gTrZFWFj+k0CSCM+oE8uKBtt8R1oDTYWAkidO0LkjgBYd
 HWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P8lfikykxm5siW13bDJwPXa8hrsDtJ/c5KLESjyJys0=;
 fh=PkrySe7Iz6OkJaXSLqhvOT/1xZZtg64T259FluyFQxk=;
 b=FbzaEp/6AEv+BjpUryIlvMrT9I5xZNnzYv5G7Hl2NECVJOZpTgxu1Ouq69CW49x1tk
 b+lEFMNE8UN8t0kTODbghrjwSdsoH4mY0kHdX+5wFYfJa2EvCTEe4mhCtBVL7NBaTohn
 UlT8WI6nPNkibYoh/rM4g9pF8oMrogwxRHeSI3KZ7aefZzhRGNZdhr8ZcdOupz6PZwNJ
 PdXNCHec3bXkO94Xgj4DRYglyjrjWt5I0FCGnhLs20m9ZfI4GK92IlWU+zY3OAWV5YZH
 gSa0dRV1tmWspWGxckpFYYVjIoPpe9VmtK4vt6wfKeI0OKZ3wXZu2YQjbQPPWz+mVu82
 XS5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318091; x=1776922891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8lfikykxm5siW13bDJwPXa8hrsDtJ/c5KLESjyJys0=;
 b=XoOABbt/l2huyHaII0AyuzkohGlxPXL0irEMxDUZhtNEMVPx9lPefYr9vuntfJImVf
 BpUxWHEge8LT4uyXjmsxZYOmm8j2YkeM3JyknEBqAUWBEdJHKwdraYmGqmnj/QxwGJta
 UIJL9jUxXPrsCj8sFMy3hh+lzDntImdfdubyyZKP2OOHPYB9AfnMAYtNvuh7kilocJmk
 Cca2ghGDHRTe9/flEIWDDzaY1Wz887yMxzdGsG8HQI3LhiG5+F00nf/pTUS54VJwfib4
 LSxt4ovmc0Yd4IPIn0Gy23GERKyj2z6avvlgH6MxmLSeAlLF0kZBMuLmzvh4yfsj/gNL
 XoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318091; x=1776922891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P8lfikykxm5siW13bDJwPXa8hrsDtJ/c5KLESjyJys0=;
 b=Vz3bB9tSvemsme0cB7FeDVTCGePhKO8TTx8WLdwPLF6a1LeTtYsvgQQ8VSi7xQn3RO
 /8QVtKhEW4cQgrprAXFO63UAXOiNY0PDP1s2rMydSnrYgluaLWuJDv9UaDAOnSLkvBxO
 CCQZQfo1qYe3VOF3pq5FU1j+iLvMaKjg+xRG+g7Yul3F5GDkPvHsFBHUiDRhiBN7H808
 U5V7trUFlrMt0DOFsFQD1KEJHkxXQGFZS5loEsxn6Ovo87WevtJVYRTMNUjSQFwJwEbW
 nDunTjThkzVV0Pv7ACcan6h/PTavIcytLR660kk/DowjLkL7K79fsFhuqhalOg0QDByA
 o4zw==
X-Gm-Message-State: AOJu0Yxm/ExakqlK9iguVEnXdFo8H18PXqrCTUOXOmikvJAsfvR7roX0
 GokLMXR1g0PVme8pzrFAK9ls7ggyZAABYZM670YjzZ+5n7UUp0L9TZ6F4t8WGbQSo2ezZ9llDDD
 cOX0IWK1VYSzJ/vPmNhAwpvGZ2TWbo5MDVATFY3BB65656UOzQ6m4NBW4abC5sk/uKo0tz591A+
 l+JlHFIln8Ytd7GAFNz+HqBlepRD8yWxoG
X-Gm-Gg: AeBDieu25tvYhZLPqWyd+pwt645Jx7aVxpESpojhk0uZsaaiI2HLUfi3Vjxfmr+0N28
 RnvRdoxuimAvs5bdsTBMeMuJRfdJ9Qsl/e0FngCQgdEFgxlmDLMClP4Xn4nq/fK6t2kQ6e+PRvv
 +erAeoI0UWw75Xa/1d3XeFtGGLO0pY6e9AK6QqwQDRP6rxnzKujdol3r9Wx+qMf2BhT1zGw7p2V
 CIybqA=
X-Received: by 2002:a05:7022:389:b0:12b:f8f0:80c7 with SMTP id
 a92af1059eb24-12c34eed8d6mr12530997c88.21.1776318090498; 
 Wed, 15 Apr 2026 22:41:30 -0700 (PDT)
X-Received: by 2002:a05:7022:389:b0:12b:f8f0:80c7 with SMTP id
 a92af1059eb24-12c34eed8d6mr12530983c88.21.1776318089895; Wed, 15 Apr 2026
 22:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
 <20260408042149.1902796-4-brian.cain@oss.qualcomm.com>
 <9e3d8ee8-0988-48dc-8cd9-938a21c7dcb2@linaro.org>
In-Reply-To: <9e3d8ee8-0988-48dc-8cd9-938a21c7dcb2@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 00:41:13 -0500
X-Gm-Features: AQROBzAKTFiaUWc5V1XsibzxIiGSn8PY8qljPW3MX1rfnVjsecWjhjoi9g0pbOY
Message-ID: <CAEqNhNbxfzMtGEHpiriShRNq=R0JReH+32RTD9B57tt3qx9PtQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] hw/hexagon: Add machine configs for sysemu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mike Lambert <mlambert@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=A7Zc+aWG c=1 sm=1 tr=0 ts=69e0768b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=RRKGVEWSvAwmeymheLQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BTV4GxY2H3Azx1mcT5gGnJTYcHI_9Bjs
X-Proofpoint-GUID: BTV4GxY2H3Azx1mcT5gGnJTYcHI_9Bjs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX8yPEfS0cIXYg
 lYhF3oAs3DI3es2e8tieWLxewfXgin+l53TLaCdvMu5Z8+B5HehYsmAHDrYcgttxNKlv3hg/kZv
 30g3WU6VPhnvV4ZCyhnGe/IP526cnvcjHM0+O0qmFTsxcORou+lI1LKGpYM7yuwoAfpJ7mwRFLg
 Tbpzyf5JzKEoFTsLzjhpGrGv4PKipZBePoVfOz45NYqzm1yhSBC2KvXWgQUop4bwvtrg/nqEfFo
 2gnw0cJEZH5q11CAvmfxUgnTOpYZNWEf4ntiObcXq0Tg1frAn7Zy/AoG/KRNni17pSZIeJiAheD
 AomVOLCyd+hsA96OJKeSG3hFaASDXmccnP8r4vccKafGPS75WDNLH8+kt/IRtnINCPo6pwIzn9D
 31ivSPNpHKKPlFzpl3wj0wvc62Va5AU2RlydC32o2X0adlKyH2aFgwM2fgtLHi2iCiXTdw7mnGr
 4mbNZ5xBE/F1JKrxs2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 9, 2026 at 4:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Brian,
>
> On 8/4/26 06:21, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > Some header includes are modified here: these are uniquely required for
> > basic system emulation functionality and had not been required for linu=
x-user.
> >
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> > Co-authored-by: Sid Manning <sidneym@quicinc.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   MAINTAINERS                            |   2 +
> >   include/hw/hexagon/hexagon.h           | 150 +++++++++++++++++++++++
> >   hw/hexagon/machine_cfg_v66g_1024.h.inc |  64 ++++++++++
> >   hw/hexagon/hexagon_dsp.c               | 161 ++++++++++++++++++++++++=
+
> >   system/qdev-monitor.c                  |   2 +-
> >   target/hexagon/translate.c             |   1 +
> >   hw/Kconfig                             |   1 +
> >   hw/hexagon/Kconfig                     |   5 +
> >   hw/hexagon/meson.build                 |   6 +
> >   hw/meson.build                         |   1 +
> >   10 files changed, 392 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/hexagon/hexagon.h
> >   create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
> >   create mode 100644 hw/hexagon/hexagon_dsp.c
> >   create mode 100644 hw/hexagon/Kconfig
> >   create mode 100644 hw/hexagon/meson.build
>
>
> > diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> > index ae980c087f0..15258a203b3 100644
> > --- a/target/hexagon/translate.c
> > +++ b/target/hexagon/translate.c
> > @@ -32,6 +32,7 @@
> >   #include "translate.h"
> >   #include "genptr.h"
> >   #include "printinsn.h"
> > +#include "exec/target_page.h"
>
> Why? Rebase left-over?

Will be removed.

>
> >   #define HELPER_H "helper.h"
> >   #include "exec/helper-info.c.inc"
>
>
> > diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> > new file mode 100644
> > index 00000000000..7b9577f68f7
> > --- /dev/null
> > +++ b/hw/hexagon/Kconfig
> > @@ -0,0 +1,5 @@
> > +config HEX_DSP
> > +    bool
> > +    default y
> > +    depends on HEXAGON && TCG
>
> No need to check for TCG.
>
> > +    imply PTIMER
>
> Usually you want "select" here, not "imply", but
> I don't see any PTIMER code being used.

Thanks - I will include fixes for these in v5.

