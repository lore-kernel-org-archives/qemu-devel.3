Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A5C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BwL-0003TJ-Vl; Mon, 14 Sep 2026 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6BwJ-0003T7-OD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:02:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6BwH-0007za-JJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:02:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIp86m1809455
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fjviuYDA7fDtNdVptYQZViDrqeXtcf4JLk62OFcQBtc=; b=bhQOXZWjbOVQsOTO
 PKYqDNA+5fN0Fd8WypohJDdLX0h6uWe4t8OnnzJT1vMCvCmCkjGxkjLI5y3BVYa1
 Kp3vn+8/EvTdQPvOFp/bF0n7jh+ST2UJLXYq074hqflg2WCTtYXbIDXQ/vj+zjMB
 uJpOw8GCaOqU2qKCEpDJCFMCVrM3+NKp8S7+FpH8u0GHBfJpGiDNRWSta6K+zBnT
 lzUBNyPof1poz6e9jwuR0chIGuikbhvNw7dOXRCrlS9wqUdtserd+h8gPsOKTgzi
 W85IuqwZ/MneIPb88Ii7m4KSD96onVgnhRkd9S7vrGjTb6F73OsSjTo9QtMfiDr5
 ohGwug==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5tm2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:01:58 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ab4ca7ce3fso3988271b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789412518; cv=none;
 d=google.com; s=arc-20260327;
 b=MfCorriWnpZcoFjvTtGNRpRZrh0Icrhbq178jZm27yTL93kkA9WCQ4eoLnthyFnRbf
 WulxSmb6Uy6567iGYfDmD6VXhKEGQ/GwWVD+zQJdxfy6VXioTU3Uq1twmDSuAYdJPGsK
 bvS4IU3Zf2AbxnB9H4HDW0xjxqPs4feIqUd2cxgnJn5LOfk00X9xgqHjKidl3m96KgfV
 QOnUD+UyDs22bJsBPkgfXFhEpYueFEeKG9pUnu5BZ/JeXFC3Jdq72HpQj5uh1hRJkasU
 K2HfoghtvI1EqXYf7gSGBnEFw9CQfAbpoSiSBxc7UFcEQuCgh4IcZeBGE5gyRowN85PY
 z5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fjviuYDA7fDtNdVptYQZViDrqeXtcf4JLk62OFcQBtc=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=WSNaVSpG+S2BDrZOXfFdTdiXDGIiBKWzlPPZ3r/UhvW1z2GugE4pT2M6xZNGA9clZ6
 vIedDtHj6iKjgbIurVcHUYopX0FROBKtd4/BRD98oDsQEM7KUNmWWwI9n/QY3MbBQFF0
 A8LFwGeCng7XlV/m1wgseel2OQZGAn9htnHkN/EbfED9xkO+6gxs0hE91ALO0z0WnguW
 btCypp1Zgj+2X/bq444JDMun77UYMw7U+/z9mD619SuEVEfNUEqUD0o6Bc2QTcG/n1bj
 cwklnmn4V14rCt4uQA1JqZ4eeJ00KafRh+gHlZnvErBrmx4DvrYP3k7HY1Q9UTKUvUz3
 lM3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789412518; x=1790017318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fjviuYDA7fDtNdVptYQZViDrqeXtcf4JLk62OFcQBtc=;
 b=ju+YH0foqnOzeyMeMLYBhQHVvhJnNIS9XoyXpdPaU9oYtolFIAtkFqCZAWKU/lweqi
 MBE1oeH5e+KTrbxt1cvolurWzo0ctXvKyXsd+KdNZl8RSzOr2xouPd7a4RZP7OUJr152
 PzNV68P/v5l9NZsacUH8uqdijnPdKyYzJvyD/lIt66kiRDBAoEIuR/2PkJU+EnPv2S/W
 vBa11L+d4MvLYDz0RxtEXRo7O6kFHi1ioSGqw637XwzT7hTHJ7Kg3q/Sy5FsFJSltKGj
 o4YHLuKtZ5/cjD15U2XIK+O9AcqXM28WrVKWZhJvhXgHIKWmLLsJcGUYyZf5vKbL0Nc8
 vYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789412518; x=1790017318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fjviuYDA7fDtNdVptYQZViDrqeXtcf4JLk62OFcQBtc=;
 b=sPug0uvSFDRkWDtWH2HzOsqiWY9qoaOXd0tOKBkgGIF0yNkKs/QIU4G4hsaEgPA2TC
 rttfZFspUmPrtUCHhilqAWg6GWUu0Jq4CiiFfahv02L/JGAT1BPT8wH5OFgD5ObUOyV4
 n1LaAS+Dh1ucjL7WhKsi3QV3uev5KCoFLqBwGg0Aa7ua5qf8li3Jt/T8jFNMxOAg3mGl
 M2SMQOPueL9fdY6jqLwqH4LhUzMd8AmQirYhb1IpyY2sMsQRm7+zDFFXuRuahuk5AGdl
 0edvkwPMqtCuL4G2GLgiagzj4J1pPLyOSUMHDNGRmR3jdigsq1a1D6DzB5rdEOBlkFZY
 FBEA==
X-Gm-Message-State: AFuF++n62RNcB2obXcxy0GVnWC9i7SPWFurY1uEQUNThQ7z663BPGtEE
 uuFmfRzL1FaxHA9bP7/0pZiP9csihD6HRzJqiEgspahQJutj2ILbq/KNNYoysxcJ0SVEtvRT55N
 0yeBKRoPs405ch0hxiw7wx7WI3aUmb1LhrVlX4b9/C0+bxEPm6uGJfLuDnWUSWUtKcamTKZMmPm
 ZmxvUzqhNIN1UCocLsCQltRlvTGTK8zfUV
X-Gm-Gg: AYBFou1jN0YURcqfhem8O5bTKwKQ+lrWSlOEhTnFZ2QnvjkY8vJgUFdQ19YfZid5aSP
 1qDQLWy2xDtzf66V93ViUz07a2IsUHYe9BVGKzTFYxp9iT7ntw/M12MumPOE9NrH9oLiZK1CxOB
 CsUuo39RWct9f8Ktrig5w08HAxIBxMY5uQjdO9sDixI1rdXfMNoVpZUC3bZlaWBFUpSly1Nmq8g
 2Tz3ODr5+pF0xnHCQ==
X-Received: by 2002:a05:6820:612:b0:6b7:46fc:1dc with SMTP id
 006d021491bc7-6c542b2f818mr2440467eaf.59.1789412518276; 
 Mon, 14 Sep 2026 12:01:58 -0700 (PDT)
X-Received: by 2002:a05:6820:612:b0:6b7:46fc:1dc with SMTP id
 006d021491bc7-6c542b2f818mr2440413eaf.59.1789412517780; Mon, 14 Sep 2026
 12:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-6-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-6-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:01:47 -0500
X-Gm-Features: AcwNN1V_FiRT7AY2ZpuKQ9P_wvkf8PwvpX_wDAAbcbeKuwVd_z5oBNx0f6PGNR4
Message-ID: <CAJ+KCYPhm7+Zb613g41pL2NiyP3e=63NjGsWnyf8MkKkeZoW3A@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3MCBTYWx0ZWRfXxhYgYzNwES7N
 xBiEplzNioRgno9jDooTExgKIMKEdo5JQ2NrQmE+KtSTU1cOsTXYNeD2dc7d0JpeT95CEEEOAGC
 d9h4/O91+wdoi6jkWyd7JqB3+FrS6V8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3MCBTYWx0ZWRfXwWXkwDqde3J7
 A4l624r/joZq73rUrclyXn6f2xxCxhtb8qvXeYeu3ImCnN7Uv9G+tqHj4q9Brbj//nuC1Xj0zkR
 RFFRimsppk9E/pR+3iE795b93gnd/fGJp1VwZ1ZTNyi90KNIr1bU+cB481B1eNxaWx5cJujQ6qc
 tAsLQfZtuj+iu9XGY4Lk2f10+cEQJsb0kfKvdGdlXAdjJUI5f+aa/7TWQChnAKQXJX5YcLd6qZX
 1LCaRRpH415w33tk7yo2VYGEUvxSsr4G1KEGwUQEBYjOpFEQx9ZLG/7Iddq9xsZ0rw84Lu9S4Y/
 ILuCSRbUU4zFx7wz69aooFDvAos8f4/pP6E0OMT8ZibxKt6EgL+94QQlNFvgev61KsdJcF/JLgH
 9yzDNl2ih0yRXnAaNA1ElhA8AfA9WstZVaAu8O4D56yFZrsG7wvGkAfZfdcrTNE4FZ2rFwNtGTB
 gQLjqmAm62LS/6X5U3Q==
X-Proofpoint-GUID: dAUjIfP_sKOEascO_4Ydsm1DzV3QWqrT
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa844a7 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=_F2IdrW47-7jnxAmcWUA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: dAUjIfP_sKOEascO_4Ydsm1DzV3QWqrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140270
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

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  tests/tcg/hexagon/multiple-writes.c | 46 +++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build       |  2 +-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/mult=
iple-writes.c
> index 4305903547..b93f2ab32e 100644
> --- a/tests/tcg/hexagon/multiple-writes.c
> +++ b/tests/tcg/hexagon/multiple-writes.c
> @@ -199,6 +199,49 @@ static int test_post_increment3(void)
>      return sig;
>  }
>
> +static int test_vreg_legal_predicated(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "r1 =3D ##1f\n"
> +        "memw(%1) =3D r1\n"
> +        "r2 =3D #7\n"
> +        "r3 =3D #13\n"
> +        "p0 =3D cmp.eq(r2, r3)\n"
> +        "{\n"
> +        "    if (p0) v0 =3D v1\n"
> +        "    if (!p0) v0 =3D v2\n"
> +        "}\n"
> +        "1:\n"
> +        "%0 =3D #23\n"
> +        : "=3Dr"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
> +
> +    return sig;
> +}
> +
> +static int test_vreg_illegal(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "r1 =3D ##1f\n"
> +        "memw(%1) =3D r1\n"
> +        ".word 0x1e0361e0    /* { v0 =3D v1 */\n"
> +        ".word 0x1e03e2e0    /*   v0 =3D v2  } */\n"
> +        "1:\n"
> +        "%0 =3D r0\n"
> +        : "=3Dr"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +

Would it be useful to add a mixed predicated/unconditional test as well?

Such as:
if (p0) v0 =3D v1
v0 =3D v2

