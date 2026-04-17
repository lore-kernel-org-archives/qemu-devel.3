Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00004F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZdc-00007l-Pr; Thu, 16 Apr 2026 23:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDZda-00007K-Mc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:12:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDZdY-0002I2-LC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:12:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H0fp9c1981913
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2ucZWn2/SWPwXdnSW1Em0L+dmdSxJibSzkjO4ghxA1M=; b=kjVW4Awm32CcV37z
 RJWxVgInQpNie8O8mXV1mVAjNRN6xlDRBocXU572z8tBsHL0AXqGtEx8asLhjRWi
 JRECM23zKQwgT2ZHH9qsy70EtpUdL14fNFAbiq0t01Yt60ZXxXevX7D+2WH+P7zw
 TKLbjNYFRVulOjBuDBylKwO0bsUJ8Ui8qfpQWygzQKfpQ1qTcweJ42ElCAtjFoOT
 jsbRUlZvKEsCw1S8oKujm5QE0EV4P8Ff3QC2E9gnhPEsjKCDh9evz1rq8ZBtopHw
 vtu6HhsCZwHMlU4vZSdxLrWywWyCQbWpFYouWmEobetestXUSKCnRFnz2n+QISFt
 yN70mA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk52jhc2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:12:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so1349277eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776395572; cv=none;
 d=google.com; s=arc-20240605;
 b=lmRfHIKPLJDqFJ80v5DcWijR3ay1tfjqHTlpV2afhPShhHHIIvvSLxKBAxBPgWOsV0
 BEsqqjjYlqMIIclIjv72ae5OIRQk2aI/0YeN0fZt2wGyxik5C33YoU0FCvGTmIehZPq+
 4Bjgsrbm7euTIuGJcO/f4PO0H6PjQprEf48joAmmzg5akSWTSNV9Ipl/Iq2/xKjNtBFx
 H9fm18eylgHDF8QWoi9S8vf6FuAW1goYYvT/UWzReT8eYGTR9mS5Q8gQabRQg6msPWCj
 25qs6Hftzdr5cKJvDZHbwMfFAOKWnzfhpK9xAwN94255r/WsY5sIbOm+NZlLfqawHSHS
 tncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ucZWn2/SWPwXdnSW1Em0L+dmdSxJibSzkjO4ghxA1M=;
 fh=jQRhXpETpd1sB/XIML4TfIwWM4+mqb2S5Y9I9ufe3jc=;
 b=Qf63A2VL3up4crf2wdlWfGH330evvqrrpXj5uJZ28LuOnwHkmRMn8ZYEYk4mzvm0lJ
 3GsLLZbeyOZOIlKOUTAQB+UKfvCPfmFLW8ZU2XKERdApDaVu7GdURvQQdRk8DJsYwEyU
 CUUKmz89uQzH4D5VXx8CqFkP8JgZc+UzN2z0W+HhG2OZjgDqWzklCMj/aZqC71ffVH1c
 q6S0k7K69D/tgz90EIN+Eaj1eMpbAX6u5cZ3XZvQTwwfF5s8djEPW5UNRiwPynEAGIpe
 bDPMvbQF4pGU1btphp9w+Lx5LSEqLVHcFKbHREfaC+MOlnOCSjPJVCMUHiatRTNOpULz
 bNUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776395572; x=1777000372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ucZWn2/SWPwXdnSW1Em0L+dmdSxJibSzkjO4ghxA1M=;
 b=bsmeG3viIaf48sJ8Lw1IIjLSzlcevJgDVINlVhjHOYy+dmEqG51ZbEVTT1+N1Xx34r
 DmOM5FBuvLsYuiM//q8xgbg6Ub2riTGT9qTlffc83iAbd4IlZwTo6boNT7b9S5Bx1/IH
 WpzvyMReA3Jclnd7TipL6WzXKudtdftwIO2nAKtK8AUE0Shy4lIDDgYqWz26ddHUG+CB
 3nyIQtGa/IHt935F5ceUVCmQ+cA63aP1oHI9H+8wuSRX1y70u0KTO4DaAYXHZ4yO8QgD
 suijFBhIqf6HVR5xYBR8Twy8qorLD8tn+yDBk9u92tSlwLZ+hvYeEFzBM+WN4pnMxHtr
 AGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776395572; x=1777000372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ucZWn2/SWPwXdnSW1Em0L+dmdSxJibSzkjO4ghxA1M=;
 b=YmR0wMQ785SPohFJprMP42BmcCqHDHuN1tO5pGYS8MisrmG7T6M346ca+zlv1TXuJI
 DnQos3hYMI6CEG9V2lhz0rW2lZvBYFaBUdccUm0eMeVHvO1cDx5q5nKJL35Hzr5R7GUR
 EsbH+obZ3iVZnJgb7cZUY/PpM1nn+mql1rWemdSJsDgB21jqscRjxj5VKfbpV5vIungH
 aFzcP12GeeoOuZy7cazdBtEYr6KLN7PXfcdtJtRJxb0djzfq/B+Q8WaF5gbZurA7Z1nu
 lh0oQ6+bsPiN+GqWOrL4DCBHE98q0SJmAnjtidc9+tqGqnzCGyqtg1H2RtoNrJ+hbF5D
 A+4Q==
X-Gm-Message-State: AOJu0YzOgzG/DSJ6c+yZ5yFFnF/8abeR9KrOazVcFJkYEJR0rO+vVDa3
 uz6cEbUG/dKNKcyXIC3Kns6XjS/1mdV8+r6mcIwyoUP6HuBKt0eeByDWWBkyvVApoMT+g5n9/5m
 055huUCGteXgOSwD1ub99yIQMv8z1Q6JSO2P+Ovez2+wEvRhPCNlJ07soNUOBmBKbEE+rwgku46
 O8fphyGmn4w/pB07Hj1VXiM9UlVQ4HIKpa
X-Gm-Gg: AeBDieu1XiiFvvCYRNr3OMvbtSFOUW6avZKL/rW3yJgykQnmAbel8hU0gMn7NTiOa7H
 MnaRq7iNLzh1ngCG8krEOIee54G2xTPGbm4WJoaa4KLh9gXD7aEbIEGJipvZ5MDDvud1aR+olts
 6n2Ocb75MSULJgrr2EJbpGA1DOuSwYf/VoqXJEmZ+KFIGRC4uRu/IunU5jYYZPxZ6ss7+158Yw/
 OWS3XA3Qg27yv4Zqg==
X-Received: by 2002:a05:7022:69a:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-12c73f9f519mr460170c88.25.1776395572032; 
 Thu, 16 Apr 2026 20:12:52 -0700 (PDT)
X-Received: by 2002:a05:7022:69a:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-12c73f9f519mr460144c88.25.1776395571437; Thu, 16 Apr 2026
 20:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
 <46a10ac4-a267-458e-973e-a784173460a3@linaro.org>
In-Reply-To: <46a10ac4-a267-458e-973e-a784173460a3@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 22:12:34 -0500
X-Gm-Features: AQROBzDuAPtdi1DTc6LMPh2nEAxxs0i4Jm-X2oyAPFPUVBst07Tg7cdckz8YLbw
Message-ID: <CAEqNhNbOJfne+0OTazYfYzzxbReNDng9pm=iNmsyFiEhasXoKA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=buR8wkai c=1 sm=1 tr=0 ts=69e1a534 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=BBaM-auP7JXH7TC1EJgA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sYnc03koGqHjM6mer6u_7YKiHNRmbTSJ
X-Proofpoint-ORIG-GUID: sYnc03koGqHjM6mer6u_7YKiHNRmbTSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAzMCBTYWx0ZWRfXz4t8qOu0YZ6k
 8rMOIggw8wvHookovmgVIG7JICYzV5hWo38SDo1XAZYk3TfQDR6IqzsWuNa+pCoBlvaK5yAf52v
 lwmYPqYn9N84CbXXsOxHiqmmC3ZBcRpL8+5ZhXlAQqoDyngDq+74+gteVYAbmW89h7nv0S2/rM5
 D2fRNPiJ3RFOLDU4EzE5kpzJVFwz+lSr5c47qKqsKkz0SFydceKeFlnalXkF/o8W3qPf9ZcYJ9f
 WMdGQA5v4lDllKBPq0laK1tjxeFwjMR0dO1ETDNyVkbW1BLcmZKEbImNs7kX53Itorwqrs1k/Za
 I0mE1QtOl9fHD7++X/PaVSACobYCj8akMizkmTak0Zb7z2Ia8PZrxZSXOFkBuplPyTXZGtA1fLg
 AzebvW2APUV22PeLHdHqCuIyE7kP5zJSGsTZZAoDPqCbk8PVRSF5hukSIEgDz4IEWxKXydXsnS1
 6F0No7fnQGQct5tCHZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170030
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

On Thu, Apr 16, 2026 at 4:19=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 16/4/26 23:03, Brian Cain wrote:
> > Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   MAINTAINERS                                 |  1 +
> >   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
> >   configs/targets/hexagon-softmmu.mak         |  7 +++++++
> >   target/hexagon/cpu.h                        |  7 +------
> >   target/hexagon/cpu.c                        |  3 +--
> >   target/Kconfig                              |  1 +
> >   target/hexagon/Kconfig                      |  2 ++
> >   target/hexagon/meson.build                  | 13 ++++++++++++-
> >   8 files changed, 32 insertions(+), 9 deletions(-)
> >   create mode 100644 configs/devices/hexagon-softmmu/default.mak
> >   create mode 100644 configs/targets/hexagon-softmmu.mak
> >   create mode 100644 target/hexagon/Kconfig
>
>
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index 9883c4d1681..355abb4fd24 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -713,9 +713,8 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, int=
 mmu_idx,
> >   #endif
> >
> >   static const TCGCPUOps hexagon_tcg_ops =3D {
> > -    /* MTTCG not yet supported: require strict ordering */
> >       .guest_default_memory_order =3D TCG_MO_ALL,
> > -    .mttcg_supported =3D false,
> > +    .mttcg_supported =3D true,
> >       .initialize =3D hexagon_translate_init,
> >       .translate_code =3D hexagon_translate_code,
> >       .get_tb_cpu_state =3D hexagon_get_tb_cpu_state,
>
> Please commit this change as a separate patch, explaining why
> we can do that in the description.

I think I'll drop it for now, and revisit after this series.

