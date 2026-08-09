Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C437C5AD55
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 21:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtB0d-0002Fp-PW; Sun, 09 Aug 2026 17:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtB0b-0002FZ-GE
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 17:24:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtB0Z-0005hm-JX
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 17:24:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LEN3N4105242
 for <qemu-devel@nongnu.org>; Sun, 9 Aug 2026 21:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wttEPTwkJQhemrx/ec7+HyIj2QYEdn2ffXGH3vhBQxM=; b=G8mMJD6swyeZ9+od
 X83eAjszbufL6Nz6ex2YeJbeQWdCgIb0jocPxuEcuw/s8wNWbv0YPToro9SrYzfR
 BxB3gszFd1EDaEUprXZlP+B8cf89kGeiWBi8qrwmxU73cJPkcIxTaIhbys5Hev9y
 7pPjtPMiwkG231HcHoLGqsyq1P8Y94eXa0JceDxf+txhKhiej4ikecE75VvK3Fbk
 /2T/qnnxq/2Rp+X6rhRcd6FFix3RQ3c+8caPRopfB38nfuhB+b0HyigsvTqT1hYP
 nsvwuUsIILgMt7bPFpQLjDZ+/8dEyMsFUzRBuV2SP5bYvxqQtdzBbEAVze6dqepx
 CMJfpQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xr0dn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 21:24:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so2038376a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 14:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786310675; cv=none;
 d=google.com; s=arc-20260327;
 b=kzzvCmIknM+qPSYZU4Wb8evKUepMMywICkoIkEm+tgq0ggeQHD9hF+n7E71t1D/Y23
 leo0oq+z+4Sj/xc6A8ot7dZXd/IVoQOXMrG0SbQw9akMTAaOP364geX4PaUK1Nl6bldC
 IbKGp++7uBT763i6D2X3w5JeeK5wCr6DFFj8AbgvSooSPEDIaFkAiIlg56eULnv1pSHF
 WXPyl9D19JQV5L1LKrdQLunLoLKcx1NSjZGxEUDyK8YHtc0+O/ZiNb5X+yHtZyu5KyAI
 br7SqwwaK1OxW+5rktIR26eRgj+zVZ7oYdUL3ASAGxo18E0mSbXPeGR7cHVXwFFSw2q5
 T9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wttEPTwkJQhemrx/ec7+HyIj2QYEdn2ffXGH3vhBQxM=;
 fh=pQfrUsPvuHwuGmXnByWlUoSLEsSGHDyjQSnThozXPak=;
 b=Klmow0Asj7fWOHAF591iqGJ9bKaGHlMILg2mC3spY2nN0akxtK4MR2IIYPN2aM05hc
 gsduU1PZ0IbuauGolOydMV1VrHKwVgxHsAScVbhol3yIkljp5PEov68y/HV88ZnEUekN
 iRCml4knE6iEepWUMRy5wv9Pe8pqlu6EbEZnYopkGoa6nIUxWoiXlONCVpxHTwR76vBs
 ETw7P6Lb/2m36v/Xw69z3jR0o2Cnb5wincF8LsOHT3m9Ht5r+RnNAMe0W6ubWm3XRIqG
 JGTiLa3S3eYObbaJ4Yn1Fn1cHWCS9rC60nNmUemk4fo0zfdjPxrQsB2cDrd2E08gANLN
 chFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786310675; x=1786915475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wttEPTwkJQhemrx/ec7+HyIj2QYEdn2ffXGH3vhBQxM=;
 b=eGC8mYtqwCWxx6Z9SSTXgxVP+duMWB7pkUkuhWVwke/XaPQZcterVlaeSVBDdCYNQy
 xsoULsHvfuABwNTYW3Rf7i2UQv1/geIZoC+FVyZTYj7zYdgOu2rX4PhmonACF3vQwRtA
 /A/fsJJTVkSCw8w8AODyyGMslzvT4day2JUOA6gbgxZjJpSR/YUNpRxmEen987CFv3rd
 lKvi/+XXITmEB4S585v9Wza5kvYWUUprpboOJ2q+bnkikfmSfDCVlXOgpdcrXwEAej1+
 Wbj9BoWw2dosgWxm8MM7XNvcROD4SuQ1+fYapZyRpKx/Izrs6YaUMwKX7DZp72L635pp
 5fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786310675; x=1786915475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wttEPTwkJQhemrx/ec7+HyIj2QYEdn2ffXGH3vhBQxM=;
 b=LJeT9dOHMnDEGlkFsCaduiwrRZcCMNSI5D6VewKblSlW5LPeT1sUD3Z8cHp1koCYAM
 Lnh8QufVkmE/36tpNqMohWqCqAegzRdjcxpnSVCooQEEn3qkkfhSa1XiSQ0Tjx1KKoOq
 im0TUI7Urs7jERPSgSx0TMHHyiGqats0ATbggXChflPZTmouby3LkEH2tguIzBHaS4zX
 fBkjghrtPwDCBjZ2H6LDH85qFHp5uVN3X1LHxziR69yfwO0f9HPCPh8BTHte5GqHLn2S
 YqLCN2YQ/QT3v4RxhRgF5l+n7FL8JbWeAISUpZFvuBkX4ICMDsumfz83jDkWv7jklYEU
 jAiQ==
X-Gm-Message-State: AOJu0YyIClzzxsd4iwPgzc6xkEwlu79vwAnNYXnhPCPrfIYK/tM0euMG
 LF3e/8C0kOV4ezjed536hTHqAxO1bEPIpas7lMYkGHXsNvLI2zKx9b7kgMdcFZX6ihNkGUIasqi
 ZrEXyGyYMJSFEA8GlRRIHNVTb8rw19B3o9B93dvqDy1AKugTXe3JqwS0YM4oYQFBhOMlIRduU+M
 Z8NnJIHfcp4E0k4jBcIfs/bApg51avFQ5d5dujhC5C
X-Gm-Gg: AR+sD10TgQXbxRRE8mMMijuR8b12PDw3mEgHjLgJXfcDVHulyKa0K5Rcyp5+uJa7Tpy
 Gy4bKNpoVw3CCh4iczzxwckIUXG1wOeknxFzSQKopssOv0GN2fFdX5WpMyh2Rh+sfTtlEMeyhYP
 HBhrwRtCkrTpVAnyKbO1/5QT9S8DgH0rhFW1rDBhNdkYS52Oh5poZ6QqaeHgU=
X-Received: by 2002:a17:90b:288b:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-3903c54d9a2mr40868016a91.6.1786310674598; 
 Sun, 09 Aug 2026 14:24:34 -0700 (PDT)
X-Received: by 2002:a17:90b:288b:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-3903c54d9a2mr40867986a91.6.1786310674113; Sun, 09 Aug 2026
 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
 <CAJSP0QWud9jnr8vYLwoUYeQnpxK_YSy4K7+RQUgtisMcBq_G7g@mail.gmail.com>
In-Reply-To: <CAJSP0QWud9jnr8vYLwoUYeQnpxK_YSy4K7+RQUgtisMcBq_G7g@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Sun, 9 Aug 2026 16:24:17 -0500
X-Gm-Features: AUfX_mz9Ya1t3hp_TswD80ILaEzhJzd0E0tPnsvd9W2y2bNiuNOhsHPCpxMnXVk
Message-ID: <CAEqNhNaNUqTv04gxgYUjPoBUj8UMhWijbyzxWYHKX84Q63Gw5A@mail.gmail.com>
Subject: Re: [PULL 0/3] Hex queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE5NCBTYWx0ZWRfX6qjce2ofwf1q
 xjtkQpms1WFIBF7UxzqEJEDoHHY3LmijYU7whS65lxg1jRunTCDbZbE9yfYNbaNPmGPQ5Piphi3
 6KQclbVsV6wCTooUDgl8Vo5NPbG4aro=
X-Proofpoint-ORIG-GUID: L9hDJPW6X_9YuCuqgnWCQKZJAXKwRPh5
X-Proofpoint-GUID: L9hDJPW6X_9YuCuqgnWCQKZJAXKwRPh5
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a78f013 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=D2MVzjJuKHPeURSvi2sA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE5NCBTYWx0ZWRfX3DepzwCoFDBV
 3lUta2JxY5GJdD49mXs5EUrPf4zmiogaiAGwfF30VuElkKLHjT98geEaSjjWgli+Ognhb80B6Gh
 Yb6+tpnBUvOgxI47+xx6Ei95dFxlTXkQesHN0eokFMo1QwpCuq5CCI+3QjdHCFJ7pj67TnwYR+9
 ixDOV7+ADQyR1g+WaX4uN2/YoROmqwOOlqOzB+3GvOIOMKSe2FsWW+VzicUKa8Qob2d8j0V1xm3
 Ps9XDdRgWp2woYtuiMI6i6S+mjm08s61/2CAtizTHlAV81CRa1VjBZ4YXNQ6LUQFl5gHxCQmRWy
 2LaKWY1mvwBaJgFPCWL4HeoF2FEeErA3UIOGchzdBpxKKF404ZlJik41PyPzYgRn7P8e8YG+KOe
 53PLnQ8U9xvztpWns7sAFSseR4647uGuft2GmpwkEI3qvSiVSx2VleXgpb3N2P0MRQOhXfNhUqj
 XuceRU17AMWyRjnTtig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090194
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

On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Thu, Aug 6, 2026 at 5:38=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
> >
> > The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de3=
0e22:
> >
> >   Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/qualcomm/qemu tags/hex-20260806-pull-request
> >
> > for you to fetch changes up to 8f5bf4fa0aa2f5648f016b8265d86d4b05b42307=
:
> >
> >   target/hexagon: don't let an idef-parser dest clobber its own source =
(2026-08-06 08:18:51 -0700)
> >
> > ----------------------------------------------------------------
> > hexagon: fix cmpy*(), same-slot packets
> >
> > Fixes for these two bugs:
> > * short-circuited packets with `cmpy(Rs,Rt)` would get the wrong result
> > when Rs is the same register as Rt.
> > * some packets with slot constraints were incorrectly rejected as havin=
g
> > an invalid encoding/shuffle.
>
> Hi Brian,
> Are these fixes critical for QEMU v11.1.0?
>
> Once -rc3 is reached, only critical fixes are merged so that the
> release converges. Critical fixes include regressions since the
> previous release, high severity security fixes, and build fixes.
>
> If they are not critical, I will merge them once QEMU v11.1.0 has been
> released (it should happen within the next week or two) and the
> -stable tree can pick them up.

Sorry - I misunderstood.  No - they're not recent regressions and can
land post-release.

Thanks!

>
> Thanks,
> Stefan
>
> >
> > ----------------------------------------------------------------
> >
> > Brian Cain (3):
> >   target/hexagon: accept valid packets rejected by check
> >   tests/tcg/hexagon: add slot-assignment tests
> >   target/hexagon: don't let an idef-parser dest clobber its own source
> >
> >  target/hexagon/genptr.h                |  1 +
> >  target/hexagon/decode.c                | 30 ++++++++---
> >  target/hexagon/genptr.c                | 11 ++++
> >  tests/tcg/hexagon/invalid-slots.c      | 72 ++++++++++++++++++++++++++
> >  tests/tcg/hexagon/read_write_overlap.c | 47 +++++++++++++++++
> >  tests/tcg/hexagon/valid-slots.c        | 62 ++++++++++++++++++++++
> >  target/hexagon/gen_tcg_funcs.py        | 15 ++++++
> >  target/hexagon/hex_common.py           | 12 +++++
> >  tests/tcg/hexagon/Makefile.target      |  1 +
> >  9 files changed, 243 insertions(+), 8 deletions(-)
> >  create mode 100644 tests/tcg/hexagon/valid-slots.c
> >
> > --
> > 2.34.1
> >

