Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB13C88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mhC-00063z-Q2; Thu, 10 Sep 2026 17:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4lWg-0006Zo-JM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4lWK-0004rD-DU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRVNQ1738985
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frqr9LRXsoVGflf3+yMWjsgnpJ9MSmIB1M1gb8+/ask=; b=F6G070/Ia6tXGli3
 OxchscCWAq27DSs4QCErdgmRfRhEPS4yU7Q9bV3QTF79ttS0VjOp/bNfOMp5+3x+
 aEY1NcbzbPqrLltG9FFyb26cX1PF+BGBbCiJz3G2Z+H39A3KF+9N/ySeByiGNr+Y
 vshSaz5XBaVkWFbX5fHqcTTLonwKIE4S2hzUB5FQKDmde3P9u0/V7qOAuVZjUSyg
 1+sDgCIxvQhTDsW1slWBhJXjD1XAbAThkWY3OTvTAIVODy/GTEZsKg4wLfGTCVvw
 zhjOIDM8Zm88rjx0jzst2DgmtroryKVjDEtAhcEu1YMdzf7ZrH9pgf1WxgbEJd6r
 GWMlCA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwkwa0r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:36:52 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6bcff1b9fafso260844eaf.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789072611; cv=none;
 d=google.com; s=arc-20260327;
 b=h8pXYwOohfmtKRx9Ik8DlpnbXQ4dFsafpZqlzS72j13/Zhef22plWnjtBLGpcimED8
 jNuOtn6As3uSYTa8R7lDBg11HetLU3bKi1wnx2imm+4gFcI8wbInYuzPwV3hFlfEqb50
 5kjUDvCNAcUUFoRqoH1Pva99yw/VaEx36T1akC/sAhMUUFjPY0aIQlZeCParlLUx1iPr
 rc/isjnrP8ZWRAmZDn0ckTG5UU6DjEhLioULJhJ9ElODtL6BRD0HWAr8Y9XtHe2z8xlr
 hG+0ujRN+AOpwAklb9ZD4YJqanxCZae9fUAm5ca/0qfqEbz/ZDkn0VzoSSpvetD3vwzx
 cwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=frqr9LRXsoVGflf3+yMWjsgnpJ9MSmIB1M1gb8+/ask=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=A3jNS8ieH3PM592j5TedmCnIxoKX/ueKEMcwlynz2TslI1QNoLirmyy7TJzvE+zjZJ
 cLywDlkE/hagZ84oK0kZWOm57By2IsS6FLKDKPSZwjtm/SlZSxniHSvHUNQcGwMfj6NI
 /NPNWuM9raF2td/oXQeP9+2W3iyCTkXOJBFn0P9qerEWcX323C6ikKW7kYZA3ZfXO6lF
 uzvT9X6hpe0GoTmJU9mV5Ip6pXh+n9Pn+9/TaSPBTnbvNzhy2gd1grgwy2w6ne/X1lRI
 O0Aa2s3lUjbktNUZ+iuW3lkZRQ1IxBGpNPYQ1BBJ4O/TTyAMMt/QpZWNPfRDRJlQ9bGx
 +KRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789072611; x=1789677411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=frqr9LRXsoVGflf3+yMWjsgnpJ9MSmIB1M1gb8+/ask=;
 b=iJQtEccEvToFar1FNeU9Er94nMEo0AyGTzmfigqJOcLNCn84TJHhyIfJ1S1uvNE3pf
 cSORsO+ekhJp+blUa/NLBaiYLGQeAyB9MwZVTApksKVGmKXKtZ5YyJtUOMz02YaB+wGa
 5/DCV54iYgTjY2ph3d7/HRpqYi4EWPS8F7mAkr6agDDrC1x/LHemQtUEJDdY+8c+RbWJ
 3TqcaesEhABQI+ltJ/aaCz/g1bYMiV5vk3RNUC6c5K6Dww2I/tuSwR2McaS+0FtcDYC1
 qF7yIsWNL+gUBunUJfkfFX8vZa6fCG787nvw0uPyO5yD8fMHhTCWkyFmviWlfh0Tmsei
 wcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789072611; x=1789677411;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=frqr9LRXsoVGflf3+yMWjsgnpJ9MSmIB1M1gb8+/ask=;
 b=nWjF7haFk7w7eAUWpMcAza1uXQCUD+a0UMdgR98WdFg4cSspzxu6CF5hx+FHr94vYZ
 ih5zPtvbW7JXMpTByxwCXml4+QgWWMnvdoCp/gEcWTjVyJwehPMledpPuchWB8U67BV0
 56dPBlTJqrfg5AlPhU3M6tWu3u52RFWsb5iZLc2pjzfkjEkWXll3SUIdBw7jBqjB56EO
 feCRzRlUBDA8CC9jxTucgpvIxuY5AarkraSxqHNrciul6iMz4+FaQPa2HKmghSDlYxLF
 STKzAA1b7iD+knYdz+tAk5HGzZXbtgwUUUYoEwVJDj2CwHTSYaFz+NqlAQTBiz8WrnJA
 h89Q==
X-Gm-Message-State: AFuF++k4cktHdoxrtvqsO4rbMKYqdou1EIYkxu4xAj2bqljMiz/6948s
 +b2E1duqZ98cvpon7MMqJVgYVL41nk16mo7i4UvXVletulbSxe8gJmE9T8608Sa+njqHNq8buDt
 swUJaNLqHlfBZWj3SGzbmp8iEw2Lo/+uhLmrEritw/4bnmXblTR1S4egG52yAClom4aBOktjwNI
 1RX1GltYL+vTyzRrKKVyIblfk/e7grTS6C
X-Gm-Gg: AYBFou3DUwmU9HNL2Q/We0cDxe5b6xYpueQhsom7SaLlVzmJ+sGfni5bcz8OocnWrOQ
 IZ4xsHe70EwuiXXKzk90mFp0RTjiFCh763VItoVFUeJnKDkqeOy2Kyt3PPKirRXx9HGl6otU05c
 YRU47q4haKaHeULk1qJZEYB4prYFrH21x7zm6rclFMDMg9W/3OyGgW5v68QOE=
X-Received: by 2002:a05:6820:55d8:20b0:6b3:611f:843a with SMTP id
 006d021491bc7-6c0bbce6a4bmr383747eaf.34.1789072611480; 
 Thu, 10 Sep 2026 13:36:51 -0700 (PDT)
X-Received: by 2002:a05:6820:55d8:20b0:6b3:611f:843a with SMTP id
 006d021491bc7-6c0bbce6a4bmr383721eaf.34.1789072610994; Thu, 10 Sep 2026
 13:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:36:39 -0500
X-Gm-Features: AcwNN1XKFiYHkh9d1iJRUtFKTp0y7wvNzorvHf8zUhzQkUGRLw92jGtrnMWNPDI
Message-ID: <CAJ+KCYM0rhMC9abfOU3n7an6Z3BKO_ZJNM1YntDdMQO8mwZLtw@mail.gmail.com>
Subject: Re: [PATCH 5/9] target/hexagon: reach the HVX register file through a
 pointer
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EZNd0/mC c=1 sm=1 tr=0 ts=6aa314e4 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=GaAAIUYdXR24ZEI6a_IA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI1NyBTYWx0ZWRfX2kyQYdYhDJUJ
 EYzIgZ9Y1LNfG0hsZnCisMJSUevcJtsXbLgNQ+XSp7ie35jSTx9DGd9kcAX/xzuXdX23I+7c6Hz
 k4iejGJaitDr4Ipe348pgFnn16Kxss8=
X-Proofpoint-ORIG-GUID: x0IpiAroJO8Ekxc_2WY7n0UQssSw7obg
X-Proofpoint-GUID: x0IpiAroJO8Ekxc_2WY7n0UQssSw7obg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI1NyBTYWx0ZWRfX1eCIdRSroB27
 yASMJSRgCm4oaa/sC1wHHpIDHDfcIlOlJpM8HqI7u88wb6MNXbYtdg+7oc+fJhiNfXnGfQ8o92m
 h7XhvX9jU5hrU8W1RPBFfNBMa/c6MOybrp8ak4dQuXLEycSa1lygYIY9yZ2SFi4CkMOjEnE2zKL
 EMxVbTNGydyHKbOSrQo8UG9+dAxTjRZ5ogra862UBpyFB7Jo1W6KSZ6epT0wu4i/skw2fxD+ZU0
 pmQkubcXIhP5rEDzj0q0xCGTwbhSntU7jHkauzrk3Rv0RmlFj5xkShMKIZO/Tq+E+2wHxsQNWOG
 WkGpNCHvlq/rtY3eHwqU5mEGps3hGNgv9HWSTgLzmQbA3JxyW+vwOCYURAudcUVMnXCqzNGKljn
 AVRtlytOhAaulYf5/iOHv0SHl2DC/1PA4/0ZjaknFWi9pnSzITzuVqYt0mRlMWuToHrK0DU65Pr
 UGiD8v419gr/t/0KEwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100257
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> The HVX register file belongs to an extension context, not a hw thread.
> A core has a number of contexts, and each thread's SSR:XA selects the one
> bound to it.
>
> Group the regs into HexagonHVXContext and reach them through
> CPUHexagonState::hvx.  Later patches move the storage into an object that
> can be shared by vCPUs.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h          | 10 ++++++++--
>  linux-user/hexagon/cpu_loop.c |  2 ++
>  target/hexagon/cpu.c          | 15 ++++++++------
>  target/hexagon/gdbstub.c      | 16 +++++++--------
>  target/hexagon/genptr.c       |  4 ++--
>  target/hexagon/op_helper.c    | 37 ++++++++++++++++++-----------------
>  target/hexagon/translate.c    | 14 ++++++-------
>  target/hexagon/hex_common.py  |  5 +++--
>  8 files changed, 58 insertions(+), 45 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

