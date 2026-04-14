Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD51F9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 23:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmlz-00077n-AE; Tue, 14 Apr 2026 19:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wCmlx-00077d-L7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:02:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wCmlv-0006Ym-TP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:02:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EHqE6h2071441
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AaLJccO/TDQFm0YhFoHR0ZKD77ExJjgWxpUPLKHmR5I=; b=UiR3zTC4aO+duMJ+
 n87jtTNLXFd4YHdinvVniZPnCxcYvM8mCorjd1ejYq2sRKDsTawF0V7nX/Wsv7lD
 0uvcnhJM9E9nD8CO80f0DhVkkW3k/YiqXE9vypRRQGhYLNQPbyMyokyCdrdNpzMW
 TdNHLpij7TSeImPno5o1NiT5RiD+scvOi14PZlNz1GQL5T8OfZSEDkCzQuVsRM/5
 fJ8nJYgrE+s9h2TrIB3IzuRLKe/AsIJimVNUcdESpZww7wE+pOY/Se3tXW5SR77H
 YdHQ+y2ihBqLtWuRym32HJaAlMxVsuW4ckib7hsZ3f9Ddvj2q63lbu3/sKor0M9I
 tw94lg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhtc28u7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:02:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd1c74508cso3017459eec.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776207737; cv=none;
 d=google.com; s=arc-20240605;
 b=S+AfRozBz3AnZe6Tc8j6FMnrThCxY0GtTgTuyD8TspkhZCoMoju5pjF73Wos5FZ2/a
 axWdiM5k8sz2+2FOWZDTYArIUsJ6l908YQO1179/JZkdjvlvq2FKb5IZ4dk9YuGVS2PE
 ytMwj5jzy0CQK4EVl9dBKgxgqy2bQDwq2Xe1rBUfJqAoQ2YDu8akws6Y+O1bN5GNmW9e
 IeV3/2W2B47sUeeZzrTrzLx3vBddDW8ei4FzwFvq1lX7fHhwKkWKgG2Q/gd0a4MktyRu
 H5lp7AxlZvNgDAsrP5J/2w+pucypOYboudPwwHys07yHpuD6I/sWwTlRSkrKrWcUI4uI
 OQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AaLJccO/TDQFm0YhFoHR0ZKD77ExJjgWxpUPLKHmR5I=;
 fh=hoMXCrJnauR1QzJmhe2dmsXmHFwojppyyJeZbn8p/n0=;
 b=HIdxA1c6+NrB6WerWdBb81ZkcX2f/MghYIfbioKZEkyMDxOlP7M1ph0vM82VbeejHI
 nGbFCxAGPlg6FnAM5bGzJz7JRs9q0PaSa9kcMQXleAfnJp1Ic2HbVFo7RhI+9U13nSoN
 X0FWEp6vTY4Dm7jIyEkiUjUL+v4668AJnmEV8X23SNqKkvz8MHB4PXxZTk139pF+UwCR
 SlbXnnTk9B+OL3q6ogTdFaN+Dl3SfEIW5trKhqVdyi5orwmnQH7fZ7c+9ffRhj/M/pty
 MmKZQeV+f/GelRQml2dOxDBYplgmbTYKRGdIWzT5cVx+t0Mbq9LxzJVnvobDd1fEl7it
 DbbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776207737; x=1776812537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaLJccO/TDQFm0YhFoHR0ZKD77ExJjgWxpUPLKHmR5I=;
 b=QX/jcCBA7ICgy6EQrPuGQ8Mo/mVMclsl2phMyp94cBgwlnFaGwLelwnp7CmQbiI/0/
 vf8BjCp/mKn4eMvxV8Ujcjw7eyO7GEipUaFE238J9BJG8EkHOB7Svm3cWOcopvThpiYK
 PWsZBsSVcv35WkUJvco4eAGYH9jaLY9vGoBOWxByJyS6VGqRLjw7oD6wcP8ClyReAl+a
 wQui87OX+VUF053wO5fjqoqTbp+uSO8Rdv/xzuzfMgTaNxYSC6/DqniBxOIYfB3quUJH
 qGWgRacmMgcjPj8dDPI4bDrRkgQHNKGM+Dv3B8j/JhoHDNz0d2j51Z/kaZpl+m81Yv3Z
 wJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776207737; x=1776812537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AaLJccO/TDQFm0YhFoHR0ZKD77ExJjgWxpUPLKHmR5I=;
 b=S1Z3QbgamDtM867lBYABEW8zP2FFNIRoIFyHmjfgVJvsfX+UnrUZk9bP7rjmAErMLr
 Fb06qJ7yoGGRoTdQutsaP9mH7nJHLBab6yLviqGt+tsBmsTgBkV0sqnYm0SJK2qPAAeO
 vfr7qmxhQdFqHCGSd5AxAF+0Hil4zEoCyU7I0UWmsLL7bnKqwTp3VYU2pfwZUm2zI8a9
 sjqwKrk1mrZMvRRK8JPr31NBn9axQIW0I6kpHXLThwvIbDs1FCYZWLaJuKd0R8eyqttU
 cY1NJuE+9+o9NZhahAxE3EYpxMJhboCs+YGj0KTtdVBwweuHN04blK8idaaY1IlpK/o0
 topQ==
X-Gm-Message-State: AOJu0Yynq3itbCN9vrf8nrbokD5RP91GisyVz0G6Uo0ikAW5UlzP/rvb
 mFXKHnwWConkVvgW3s8t/t+B5U3WlW5Fczq4zmwiPkE4PeFubbSZ/J1RWR4vx7OUI2cJWsnAy44
 iPVl/YKylAPihR5OOTUioaj0cn4x3czysTG0MSGwe7BRHv7v8jQMAky5kMzjaOy3ar2bZdkwmn7
 QhYYUr34Y7HWvBNe6MerRXrC8r6w4vEhLO
X-Gm-Gg: AeBDieu3bl0xWO0m/86JzhCokCWscOs0x+k3bNsOgfxozBBMaWZR91EPoXGcSommpql
 xw33hfrS2h23+6wPEI0NMZUmH+4T5yf8MstJxBF83TGVk/lcVUjg/Xe848Vmlojc6wU5ay5Tl/G
 MNrPKcC+Qtam+qOvRMX6hg62Vma9hDw7e6MhunW89Ggd41hDYfT0QQNB0oyh9KZP3JuCr0AScHd
 Oi9hQM=
X-Received: by 2002:a05:7023:b0f:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12c34f09283mr10391519c88.30.1776207737225; 
 Tue, 14 Apr 2026 16:02:17 -0700 (PDT)
X-Received: by 2002:a05:7023:b0f:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12c34f09283mr10391497c88.30.1776207736570; Tue, 14 Apr 2026
 16:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
 <20260414223604.104290-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260414223604.104290-2-pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 18:02:00 -0500
X-Gm-Features: AQROBzA7iYwrF7c4-nvL15Kj4Hux8o8qwUGskfsi_jMog_In4AcqUi8yHJJDLqM
Message-ID: <CAEqNhNYmiU1OEOJm-hrT-fhgrj+Awqn7vRMiUNGXfiFS_uycEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: update address
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LbTLC-cBbbTkejYk9TcQpxm0kcz5-qGb
X-Proofpoint-GUID: LbTLC-cBbbTkejYk9TcQpxm0kcz5-qGb
X-Authority-Analysis: v=2.4 cv=HpNG3UTS c=1 sm=1 tr=0 ts=69dec77a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=cplnpDx6AAAA:8 a=dGsWvjqBAAAA:8 a=pGLkceISAAAA:8
 a=SqMvC5kiAAAA:8 a=jl3Fm_G9QMiiPW_CtGYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22 a=bHwCOBSOUrNypjIvOSWD:22
 a=EwAE0RQWx3bH85eTCWcH:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIxNSBTYWx0ZWRfX3YQz8r0gyno3
 rAyivEaaFpHHlcU9YpRNZyv4K39b9Fuh2wexX2DhyS23nhgt7M7nm8z65ApnY/ZjT16LAVkJprC
 aMgdZ43+124EfeEt8rPckM5xi2hlJzHiePBoPT6GnJ9hjOo4OcVaRYRtERgDs1XYpWMWm9RjCpW
 7naksQYHTl+8l3wHdjmSwsZKkzJMYyVnPsjQ+Kevro9aVR+4AuG0PGqT0pv7R771uewjRRhpgkg
 kYIVFgJMnfYDRSDe/Gfgc536qWwX3slr7PFpTW+zsEigl2AwbBgoIxHJODF0yQ/nJ1goi9Qz9P/
 fr8uz+BrR/B6c/eYi8RO5I5OKcIo3bUY4UI3JnBrQZ9uVFSW2rvq2R9TSAM63+KkKVnVLnROJbP
 MeF29hwmx69hdhmEoEFVtGbkmP0K9dqGKc8F1fMc7YPQ3isvd70UTjDS223znwwyKooT0De105d
 E+z36bfdttpk/eXcqUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140215
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

On Tue, Apr 14, 2026 at 5:36=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced84..14bd822ddbe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2038,7 +2038,7 @@ F: tests/functional/generic/test_empty_cpu_model.py
>  F: tests/unit/test-smp-parse.c
>
>  TargetInfo API
> -M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  S: Supported
>  F: include/qemu/target-info*.h
> @@ -4075,7 +4075,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-us=
er bsd-user-rebase-3.1
>
>  Linux user
>  M: Laurent Vivier <laurent@vivier.eu>
> -R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Odd Fixes
>  F: linux-user/
>  F: configs/targets/*linux-user.mak
> @@ -4094,7 +4094,7 @@ F: include/tcg/
>
>  TCG Plugins
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> -M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  T: git https://gitlab.com/stsquad/qemu plugins/next
>  R: Alexandre Iooss <erdnaxe@crans.org>
>  R: Mahmoud Mandour <ma.mandourr@gmail.com>
> @@ -4556,7 +4556,7 @@ L: devel@lists.libvirt.org
>  F: docs/about/deprecated.rst
>
>  General Documentation
> -M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Maintained
>  F: docs/
>
> --
> 2.47.3
>

