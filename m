Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9540CCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZxl-0003yW-VM; Fri, 19 Jun 2026 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waZxk-0003yO-Lc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:12:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waZxi-0004v9-Np
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:12:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDCJbJ746386
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 14:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1DNFpWuRhUabXaf2FAU1lRhifdCKLRsE8nK3q2fqo/g=; b=nHUuOKGusv6ZsKw9
 oKwxj0olihcKadV0Enn6gkmUn+zr+eekEuHU3kOcSwA0dAzcGniW+JZAEQdVZ4hZ
 gG6uoE/+WhN8bflEbOpykss55vnh+i34SfejFB4QUR1QLvOGAVP/0WiQnsU7zh+x
 0Tkatj5IMxxXg7BSuIleVItFIBGzcmqIRUu//1NWFl4ZSeaE2ITpqfxPhd8NL77P
 EmTXDJHuUvwPivt1uIJcynvuHYlfCJ4slTv0ANWHtkiFj+PZyXNDvGvhp8CKfLOV
 wyoOSK2h18RrltOav7MTg57AsLVOHdA46kOUIsoMqBq+H/lAfyiyyW1tOO038NAK
 LTV08A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sbjj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 14:12:48 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso731522c88.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781878367; cv=none;
 d=google.com; s=arc-20240605;
 b=ifBfAJJ8IXJttdxAyE0JrbMPRQ6n6YeLL0rUc23qBif76SVhFcrQmWfrlJp17JAK2l
 P5y3FykREM4IQWbc4jVPXc5BzKjzU86DRp6XE6Aref6HF04HnXOZPgb521EviRoLP3bk
 uaHBYeguDCRNhI+FsPa29yo7U3hCKPmjG8rZNxH3P6cuGPmFgKGeLpGNOnAXrCm7iUaa
 BkbQWO5taZQkNlZtCuhkIGBJKWb3hWohh9Bq43u2sQ/a33gRHWzoXHv3UA1DI3akK2fS
 pspPtiO0Sd0xc64aRRYZjgWT6lHL8L1dwd/ja8Li+4Vh/Gt2C50H0KxWarGuP4xVXwPK
 WA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1DNFpWuRhUabXaf2FAU1lRhifdCKLRsE8nK3q2fqo/g=;
 fh=Lf2W3xo7mc+DVh/Qx7PkXuNkpaTX4UNAB575nde0PtI=;
 b=VMabkSuEctGpnHzVQ8toQUFiDxVS/fOfoK8qkhe/j48loj/rlUIox+Ur00NXHKYhnM
 fCueKm37NK4sDKGr6kSWf5JVfhEAu5DGxPDqCcCS1JhsGol9WQ8uxKvjSmi0HOMdqNrY
 v11SYReNCawMKVOMXNzY2PuknFs7zxM052o3Lt5LLx05L1d7V/nfkLKgXrAGEjhqWimh
 Yw0lH4BqbVrGRW7qQImOJFF/nVWw3KXkmIgDxg4wYDsTrVnuiJQ3BtF+yAjTLt7mxmpD
 dqwwR77YRSdWsyAVrNcpaN4dXGD3qK/MXhIjyCUEYTQ+vFocveK9MJkDmxrZVCzLNZYQ
 yg0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781878367; x=1782483167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DNFpWuRhUabXaf2FAU1lRhifdCKLRsE8nK3q2fqo/g=;
 b=Uuucsd9nSaxdinuNvQPLXt1OhRVJlGHXK4NidTNO3FktaLP0eHnCuptwITvdOL1VSa
 dbtnOtwRWkjOqlrp9UG7lg2LZ/pjpAkRIjicwyIlED6BP4/zejkUxvTf3dJTYOzozqOH
 duOoI2AZubfG6ryxRRGK2gHYAYZwwXxn0EhJLmORDqNO/HYPUAPdtA/IacFBiV+lUat+
 Raospjuq+JCbOLHocV2eiuSopqK4QssMn/7KjPMEAH384rW9GVBpQisS6megWkGDaMGq
 oX68wXkomNp5H+XnCReB3HRUyAO0IygM8YArFKo8VaQrU3HHDAf+7xm/PWUXT5erFtdp
 YPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781878367; x=1782483167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1DNFpWuRhUabXaf2FAU1lRhifdCKLRsE8nK3q2fqo/g=;
 b=dWW1Ah/+U3Skklp13zphOAqBhfsKVlqQaxXzK+9NYnf91HMUpQO44o1BwH1qAr+ASg
 DQyDUPjZnq0bGufjQRbpwXhjKBt7z+QbcpnSJm3dm8/gkgHmgqqJ/zB6gAmz+nHATvFP
 tANMhpFe1Od7ZkDxRMPlBmL66dyTiOgiyoOyVJ7pdJL/ADuDS8OrfXsIJdPWGFgcku8A
 776qar/72iwOzCyZLHyT/p0K/iaep7+Fgv9tvDQfBsP8nBD+uxP34vH3iQArBSSGStP1
 5n8+yctwXrWQEqaCGn1fln1/33hnLqoKOzdp9Izy2wlHHIInyM2NDWcz8sbDKxbfEb91
 As4g==
X-Gm-Message-State: AOJu0YxqxFp2u/mcdYknbedQS7TZpSqlMSGS/0nxoQ46DXR+iWc8gTEt
 RO/noLQwQh2vJZwnecx1zbqXe7uGrQFOmwCI8mRFxTA0A2TKj4kGYzFQ3132arolGGVshKYhmIZ
 bmJCda1XUJ2DMdJfR4D6+N8OPGUMxnEYNXsVQImTXK938jl9aYSc6Aa3deiECj6BUwjzjOnxLPS
 PN/MeiDGW6cGmJDRVnM8hdtF39TlOQwkjF
X-Gm-Gg: AfdE7ckVGb3s2IyuV3jA3UorYNUHn73r74i6daScVbCkZx9GsXJgHjJZKstq0/6hhID
 2wxXbjFY+SSkm42e23QBgYmqdQjr/gxMwE6zGICeenJTtcL6Ir6oNG18vmYVKDfH+AdE7t2AyvH
 59jFzRFN7xWIjUAoGz48LFp9qOY7jZwokba640lfmmQH0cKXgb+Cwf4XMlsCU1NKT5STYv
X-Received: by 2002:a05:7022:609a:b0:138:51c:c5aa with SMTP id
 a92af1059eb24-139a367c994mr1629442c88.27.1781878367046; 
 Fri, 19 Jun 2026 07:12:47 -0700 (PDT)
X-Received: by 2002:a05:7022:609a:b0:138:51c:c5aa with SMTP id
 a92af1059eb24-139a367c994mr1629425c88.27.1781878366552; Fri, 19 Jun 2026
 07:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
 <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:12:30 -0500
X-Gm-Features: AVVi8Ccs5d-psvJHWKTfmzeNyhG2TTB6WDZrlDacjLwDN0f74RDukMSQR6al_KI
Message-ID: <CAEqNhNaa9mfy94QGz2vf2EdGSM8iPxZh5w1-wwq5LHaHCEWvew@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: t28XlmN8w-UWW5wBqQHXUnU5l9hYGE_w
X-Proofpoint-ORIG-GUID: t28XlmN8w-UWW5wBqQHXUnU5l9hYGE_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEzNCBTYWx0ZWRfX+WLw6+Trfc4/
 thvJQEB06Lu6arFmVEr8nkvb+Tfh5TZlyfnOP4qtV9xzoJpFmy/7gP9ZAd1r6GVAgZ6DqE0Kz8d
 SiDII+pOJMm+j40Fp5yIBY7dKI31XitJrHUEPK080ncRJyX2bgaSJNX1BXApBCA+na1YDxei1nn
 K4zfXID0WqbEzf9Tk1G67IAYgLjHzyaJvJi2fSZAHi0kNzPiYP5IaGcQldVYHdCNA6bv5TaKMTs
 C3yM+6+5VNzoF3p4CrHisdVUjY/bo+9qtqbqAz/qUUXF+HuTdY5nltFr3PQtr2z51sFSV7nxtYn
 07vNOuNjxfM0uiK5ClhUYD0Miw8eHtLSPiEqawhEVOtJuuQ7K+lNXeP29XCckSbNiZTQ6CNYSA1
 igjwfZ61iOb4ypx7Cce4RMIUOmNBlVUG6nyRB79h/8F+QPQETiLmqgnnTa+kkx4A3ta6EvA/m5j
 m3vr1VbEpgOE9jMI9zA==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a354e60 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8
 a=hFKQHaFbY6gXYoHRevwA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEzNCBTYWx0ZWRfX/0spYWX0yovH
 QgtDAC75XU0uL3VO2uQVdwTHZHn1DR6oDeVAGpdE4pGsT2T9ZpMKuu4/r0hUeqTOLDmG+MFrCw4
 GcDC/wbGEwYhLdHmU3HKMzpgGfFJb/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190134
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

On Fri, Jun 19, 2026 at 8:53=E2=80=AFAM Matheus Tavares Bernardino
<matheus.bernardino@oss.qualcomm.com> wrote:
>
> On Thu, 18 Jun 2026 21:31:59 -0700 Brian Cain <brian.cain@oss.qualcomm.co=
m> wrote:
> >
> ...
> >
> > Download the tarball to a file and ignore tar errors during extraction
> > with --no-same-owner and --no-same-permissions.
>
> tar's man page says --no-same-owner and --no-same-permissions are "defaul=
t for
> ordinary users". Isn't that the case for rootless podman?
>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  tests/docker/dockerfiles/debian-hexagon-cross.docker | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tes=
ts/docker/dockerfiles/debian-hexagon-cross.docker
> > index 23e8bb2fb26..817c903246a 100644
> > --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> > @@ -49,7 +49,12 @@ ENV TOOLCHAIN_BASENAME=3Dclang+llvm-${TOOLCHAIN_RELE=
ASE}-cross-hexagon-unknown-lin
> >  ENV TOOLCHAIN_URL=3Dhttps://artifacts.codelinaro.org/artifactory/codel=
inaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar=
.zst
> >  ENV CCACHE_WRAPPERSDIR=3D/usr/libexec/ccache-wrappers
> >
> > -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
> > +# Ignore tar's chmod/lchmod EPERM on the toolchain symlinks and direct=
ories,
> > +# which rootless podman's overlay storage rejects (harmless mode metad=
ata).
> > +RUN curl -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
> > +    { tar --zstd --no-same-owner --no-same-permissions \
> > +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; =
} && \
> > +    rm -f /tmp/toolchain.tar.zst
>
> Hmm, I think the "|| true" may mask some real failures. For example, if
> the URL is invalid, curl would still exit with no error code, but the out=
put
> file would contain something like "errors" : [ { "status" : 404 } ]. Then=
,
> tar would fail to unpack that but || true would mask it.

Hmm - good point.  I'll rethink it.

> >  ENV PATH=3D$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-lin=
ux-gnu/bin
> >  ENV MAKE=3D/usr/bin/make
> >  # As a final step configure the user (if env is defined)
> > --
> > 2.34.1
> >

