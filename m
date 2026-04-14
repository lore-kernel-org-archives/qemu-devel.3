Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6988F9D0DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 23:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCml7-0006yy-RN; Tue, 14 Apr 2026 19:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wCml6-0006xd-FU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:01:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wCml4-0006TW-Bs
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:01:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EGBoAt1779139
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4RfMEEa0CpZFWy1j/ciFSr3YrCHOMZsVnSFnCFDDDc=; b=iWMROM2PSJ5vCxcv
 JMmwHkxdoBAf983sjO9h9bXEP2xyi7lFVEz7CXYXhfYVZkFEUvnx9FdYYlpGChlC
 keqnd+Vo5SLgMydwnD+Esew+8T/zK7dvGWEvqUic6hBQHYalnXePe0I4FvYszW3L
 Dje+sgYsrfdQf2j32ZazSO40220hT7Ia3q5+QMR+hmcyJ7DL8K53+LJQiMT2Lonm
 IX7iQyYK47hCeJ2RBXfUdBCx8xksSVAB9JEQvRKSoFxpQ1+jPQlCBidh5JvfP1WA
 vpFPoKef7oqQE3uYtm1nSImaUxA/IQOrzanZ4uCd1KPNqqqcLScNCOJztxWeL2Hj
 meF/Hg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw017s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:01:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c56ad1a90so9365440c88.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776207681; cv=none;
 d=google.com; s=arc-20240605;
 b=EAAKU6f7F9M4c0L2cBUuF39bYxUGwICBR79iiz4MA4HQm6mmKdWnP5Qam4P8Cc02Pj
 2pNwcnKarP+fTuAnzaVgYua/JZ+q9pHa6v3tcYgsMzHyw86P2lt4la94ahRsA+Qk5Uif
 NNHUVIXXHMYvLC7Emgx4Py8vmgAo4DD/EbDtUVyJJKF+a5AYeHZPFociVmwVrhBW5PlB
 qu6Qb5O4h+PyMWeVzQTDIC8dUj4gC6fwh6JPcenAGxLSqmo2R+LM8q40uHjEShPco5Gx
 8aGx0a+oPZFm3vFAPFIcVQIjGLCSGp3QsMx6ldS7jYIntKr8RP4MRago9Q9Jugpkzu/I
 s2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y4RfMEEa0CpZFWy1j/ciFSr3YrCHOMZsVnSFnCFDDDc=;
 fh=hoMXCrJnauR1QzJmhe2dmsXmHFwojppyyJeZbn8p/n0=;
 b=WasgiZz2YOrMwkI7Bxa/qUJlQwb7oFjLymm7v5W6ofXcc849DDZA8GYXThUWIDOnz3
 QyB0Jmv8w+4cGU8Hm1gtmZ3R356zMF7NiN1sxSsRPkch01qUSrqVuWv+LzOu6Rml4rD1
 6suORPKRJt+Ty9jBLbcuph73dU938G6VepfuxIsFed3/hc93Q7jv83UwlNZokGj0uHnx
 FF8k6C6RyixRIEr16xe8zOG+W2Uh2foQrxSo9+ti42K814wOv/bSis/8WCODc8o8cgtM
 awBk/x9aISYGZq+rD1OmVbJ5j0zAAU0j2k35DpszH8Oxcw+45y8K/nL2w5u8TRbeqFWv
 x6+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776207681; x=1776812481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4RfMEEa0CpZFWy1j/ciFSr3YrCHOMZsVnSFnCFDDDc=;
 b=iz3D/5rwRT2VYY3PxByDV7xM7r0TMZ1EC1MSB1ZZnxuQdMtJgo5g5d7A8IfgNuTEZu
 Hw/NFw0SuKcZtNqlYjs/7Itdhg3UJ0IwfJfkV+h8sGjPT6ud3Rps82HFDIEYfFTeXk1v
 qFVi17Rdk4q3u7oIuM/dFeK4n/lb3Fgh0fQcXUhtMHMU2tpI37O5AHbiY9Ytc8LkFp3R
 MI18Z7NPumgPV4hSRWdpn7BV6ba/Y7iavU+10JWe6wpFIlGUs1oIL40juNX8fEPw8tx8
 7retElPyj4/PqWF9auM0HLntCj61AZl3XQTQBXBEOjJA7BNGE7cln39nrLWa2kGPUFm3
 ocNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776207681; x=1776812481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y4RfMEEa0CpZFWy1j/ciFSr3YrCHOMZsVnSFnCFDDDc=;
 b=tQ2zadzZnEBdBUwY+iEh99sxdP3SPsJvQUke36p2/uX+JuTc9/FTBAxzfclG7kaihC
 hr0RcfXwXvRA0dBDtb9dlrsugqJBAFLuZTkhwJQ+dBy9EjkTmsbV2yjnSut+Rq7bnBBG
 clkFctJJvQIOx/9Bq+d50C4sSSgTmRMDYvhG9PcNSzli46nKzSOb7kg9XOEC3SKQzLKt
 BBELZij/X12E5BxdnBcuXCf1ow+4xQXNGTUAzlHwJ9tajcwH015QMscJRdZn01vQKOB/
 Ln3Bgp5rhiEN4TA9ntRPn9epbC/vnGK7c4V9Kd3uLPORpjlXA637TkZ3acxSgbN9MYXS
 duFA==
X-Gm-Message-State: AOJu0Ywq5N2LtDLnjNIPdt/9XZw4ZsC8ovqP2DyAgsJS/IUtzVlkSyKf
 yp7RMoGtTaKIKL4IKEmYLdu1UF9gDuNXrYwZBszDpCBAZb4gyOiODWFpovFcwrcX/uU/F8kkvG/
 TJIX5/DWiaGU9OTdYgY6ZbNVSwzxmNHnbe5U4PY/nFnFDtUS3huPn6kCLeGD8k0wdZHJMNOvH2/
 ECQtsWPtHpHoQLty/NC4VkQbwQ5sYQs4zp
X-Gm-Gg: AeBDietLeiJyDYRlWOaMzSAsEGdjncmqX3Tz7n90viTpMs+i40lJsNf/e3bOp2jFyDT
 T1OoQG1fkvzSbgKY/L8VZEvMvV53QdUTVfzSNHfkRLYlcSKSyEbQZ0XYaXG6OjOS/Pbq4V9b7pt
 EHLXwInErTRRInDLXUAfmr9QoqYcYlMY4KqD0/eS2FiY7y+xRMXIEwvc98D87NXtIeEbWjKR8pG
 Aqu3Z4=
X-Received: by 2002:a05:701b:2205:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12c34ecf751mr7400361c88.17.1776207681123; 
 Tue, 14 Apr 2026 16:01:21 -0700 (PDT)
X-Received: by 2002:a05:701b:2205:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12c34ecf751mr7400339c88.17.1776207680363; Tue, 14 Apr 2026
 16:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
 <20260414223604.104290-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260414223604.104290-3-pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 18:01:04 -0500
X-Gm-Features: AQROBzC5rLE0-gzs7V9PqusOeb2zYFGRUg-luGThj47yTui7MrhPy1jp8wnkaGU
Message-ID: <CAEqNhNb=niMdcr-Af71yasv356Gmrr7QeEmADd7Mnvwfowokxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add new reviewer for Hexagon target
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
X-Proofpoint-GUID: -wv1NEXuNXApwwyjwid5-GNeb6sbb9r5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIxNSBTYWx0ZWRfXwtWW5jn5Krzu
 b8UQ/zmE7e4NxG5Q4OCR491el9flHgV8qy8mMEp9GkTI5GV11nc34MZhR4ggTu2/52ueeisiqVe
 QI1zmPqTE5WqN8kKJeOt/FsfsF6ndGUJ9UPve0hyMAOrodcHkDj6Y9H2FWcOBEMu1qGI8nUtbKX
 5pw7+RpgZtyNvGARyeXddlQa8Oh1z/IWKEOV8FRhFizpRezbMCDSnXG3ceN3sEOmzS4DfpITapd
 vanJonw1jG5UOXUTeQa80iaWBvUJf12V7FkIa7XqBIETba+FYszraddR0y4bjSoTvtTMMY8FHts
 Y1Uv8vUz5jAapf/Sd2VXqj2xxvMO7IVvlKY78fROkGpGQi7lOmy3ES7W9NrJ8MBm4Vwc57DJNzp
 NUjeyMW8XzF4skhdicO8lE3NJhCa1CjJeeRET6j2jkNLN1+m1sgn13mfA/4kA9DK73vlYxhO9YG
 GH+VfDOYHmFb95o0exA==
X-Proofpoint-ORIG-GUID: -wv1NEXuNXApwwyjwid5-GNeb6sbb9r5
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69dec741 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=yk-8APeZfJODsI6Ux2QA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
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
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14bd822ddbe..0a90204ae93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -244,6 +244,7 @@ F: tests/functional/avr/
>
>  Hexagon TCG CPUs
>  M: Brian Cain <brian.cain@oss.qualcomm.com>
> +R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Supported
>  F: target/hexagon/
>  X: target/hexagon/idef-parser/
> --
> 2.47.3
>

