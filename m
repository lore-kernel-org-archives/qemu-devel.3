Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C771606AA29
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DirqL3oe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=isMyEHvE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAhf-00068s-C7; Tue, 20 Oct 2026 10:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJAhd-00068k-He
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:20:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJAhb-0000BC-TI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:20:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAEW91429985
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 14:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2KX80MlqHjNopehwrrckeR7gP8KsnyuJPSgFp59gVjk=; b=DirqL3oe7AJHwXeH
 +BYfhjz3P86n6FLZi+rWHlN7+KgVgCqQa8yTsS17P7A/jdb4i6KAYywjb2wQhR+j
 yjQhXEayelS5TufZ2pRiClYmP6YVDam1Lkd+x8TSz9G0ucNWYe2UokIP+wCQ89in
 6hJ4Cc+6yg6rpM0AVa6jrv7qw2v64pwMWzNwwXEiR0SthXuM1j/pUqY2JU5KcSpf
 LhbGSmF5yci2kqj0mZhE4Gc8nC4ZerE9i3gkrbP/YLIlTs7W/MeNAA4IyIOgSfp2
 l4NFnLL2jCP2uHKDw4YB/CwfYaCIrKoFqp5ashv2NsPggIn0oZLyEZHzdzdbymxk
 rRT7+w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qaufa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 14:20:29 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-82274137201so5262297a34.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792506029; cv=none;
 d=google.com; s=arc-20260327;
 b=qOLJrhjgDvifcPB2kYpGW9d9ehWNmuCCqOUzFuFsg9Q4y12zwy4hSNbjQKddAEMr9C
 Fb9RY+UWBD4E3uGuYa+yEz3YGlfdlUZ+UPXSdaoeZiKYf1AvMfYAWdamu/Ifcx1NXDcz
 MdEwRA7W2k8cWX3B3Nc41ApVbq+74+p7FDUHnRIVC+T9tc0pdujKGh4pB+bwxhl7tf/i
 aVWf4OhQFAIbgwoLm8jBX+TffYq7JyKabuQnAt7fViaDxpO6ZMg/T/v7XqTm4vNo3/4T
 p+V1ydSccQGx7Pos3i2Suns/fKk5PC2kC6oSuueLsBmnBp8cvKBRpqBXtnmE0xvvT9Fx
 XD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2KX80MlqHjNopehwrrckeR7gP8KsnyuJPSgFp59gVjk=;
 fh=p7vKGbV3kHmZwfDKw8DZlKLXpqfe/l+j4ZxZG+A7MSc=;
 b=jyuMWe7XWzRL4y9louDjsevzMWM7nbaEV+2A0qjRWITyZiv/FbHv2VkfcI5hC7Xmcu
 OgvqLL4doYFZfq0CxM5yfB2CTznfVcOBT+p7K30Oc/3ANUQigaaVVtls4pbIcJAFI2bi
 ftfrgseD56U4oP5CdyEEuW1F8ycfjZXSkwY0I8Mbtrw3MC8yI9NCR6HMxW1krGjwLUkI
 YIqN9ecU2tuJCeV3aImbjjzqZfgqlw/NCl3mb3G1iZQ008caGCRAhruIqnhsMfMhLZzp
 /L37QhMSzSGYzgdYc3Tw8u4cC9unbV+lbk3/NB/g5U2meZDUgyTUd/2I/fQ2A3QfsitT
 D5XQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792506029; x=1793110829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2KX80MlqHjNopehwrrckeR7gP8KsnyuJPSgFp59gVjk=;
 b=isMyEHvE6mXN6kETVpzKw51ivNB0mKFIxO7ybB+spS8sGeQZinNAWbiuWR4BzXMLld
 J0qZOPb/q9VKxsM+ZYZRNlpTD/8G43fPgyjOgaBmKNa3hbMK96QMI1oozRzXuNuqbpX4
 aaKtIrknZUNOpku3jHVXBd/62QWcTk9hmN8lzaRV1L15OxYF2UfQ1V4/l1FcevOuyeyD
 Bo3xTX+w4h6miSOduqzT+JoWIakor6ZYSmfuhc24m6fSQkmT4SqaANpCJT3drKtbNw8a
 F7VUcjLB7MSL723aQSFpL+2sD1xovjEawi/ZIQ9RJptp6EVrRcAYLCNqDJAjK70reM/h
 Z2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792506029; x=1793110829;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2KX80MlqHjNopehwrrckeR7gP8KsnyuJPSgFp59gVjk=;
 b=hP+r4CgEhPyF2dNWNlFrV1j47Lu6OQr52cohkqKjwuog32YVKOUmCynGBpCvmhXpBw
 B/ft0ZBjmiH/b1Bh30ZWtaIiXPXgrODyJ8beVoMEb/A106BGemZ4n7t+mcI+BDeJ8/iO
 tUObYwOHnA6Ua6aWKEOSPWdjIYoK3QalybV7qI9PrCy4acKFJ84fVlXYcM2zhdbUiZbm
 Vxz4UaBV5d+IKm0dx/MZ8T8XWEgeLvxbnfwkcQH/DwWhoTZlAxalOOYgqeN/9w0RlV+/
 CKcYnZ1qJTxbENnlNRW3+iSijh8mOPKdAqLd6p4+lPpnnIua7PSvcQG+q7CEj6txeNZD
 D+Rw==
X-Gm-Message-State: AFq9FYLl5IFYdUpv1mHOFP+sN6aQAbMwwMAn48NDqMa/CCNP149kgmii
 OlSYFuxNC6e0rcogCODZk1hahJ0WwVAA0strEiO6jc/mIFwv0/GeLf9OfEbpJKFQypCaeMCHEA0
 E/w8mxM+KZVGaWvnnQ9hum2j5cHVJnN+1Pd3hXcHCpakTSfMdDXACBywFV61NkDLtBmQ/64/2tA
 7HX1OIBvQAyQuZ2FNPos7UvgNXjFoU2gks
X-Gm-Gg: AYBFou2634mXhLR2UAjbIbtPwAkLR7+3OSSNkpX6zv04Fu085zqIe6dEBdI5tVtwzgN
 RgmEzwZeZstjSmZCUadu1TyZBStYH71S2WtrynHohSHmmtrGHCWIWKGEetoWp4NTY2Yi23xjt88
 AFFjCCG9iWLxoLPr1iZPJJJmjtcXJsEyKc/dPy1GdJXZxdXe+fMWY8yLHBOmIfyNtKE9Aa0b1pZ
 SIAN9UTfsSWiENSAQ==
X-Received: by 2002:a05:6808:2389:b0:4f6:5279:5c89 with SMTP id
 5614622812f47-53cd20a4287mr8929130b6e.47.1792506028279; 
 Tue, 20 Oct 2026 07:20:28 -0700 (PDT)
X-Received: by 2002:a05:6808:2389:b0:4f6:5279:5c89 with SMTP id
 5614622812f47-53cd20a4287mr8929098b6e.47.1792506027758; Tue, 20 Oct 2026
 07:20:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020015154.3600098-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261020015154.3600098-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:20:16 -0500
X-Gm-Features: AclHuK-Uha5D0jAsPWWclPzFFdSd0bhPkQj-ntFB6PXG8rV2GrhVO6q0mse1HTA
Message-ID: <CAJ+KCYN-W5tk_ccbvRTHnuGiFYfonQRE8kU-S9S3LXqLDtDQkg@mail.gmail.com>
Subject: Re: [PATCH v2] target/hexagon: fix allocframe FRAMEKEY scrambling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: IqlMMCs9S08sGnbt7VU0nLK403Dtvu_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NyBTYWx0ZWRfXwDktHXOqNzpQ
 9tWRsaMV6/qIEDzpezkq/2/I8QaqcNiIS2XlqbDBne+2eBllinnMwhuRWBWoTSmOrZWzmx9wNbN
 wL9GjBpM4WGr6rei9/q1BMGLDxDTuKsq3Eg9xeMkyaVr3hHIsqZksKqoQHIMoTFOKgN8dg54m6p
 wLFIcwT1DYImffKKNxye0zn/2uWP/te7APnkt2VYumhaCDYrxCev4YxQwkcbdzXt584NXeCv8c2
 vfpiict9EYLhr9jqyDqK/HFcd52FR8S+1H7LLs+v0idJ3nEkUJwjQDBhevdJin+ztWDORfxSBoG
 5lo5EbgsPBZvLxBD1nP6Ipv0J5y5HJQlBk+EJE5XjSrHxonI6/lR/hm08Z3oJRPEFT1Il1R7syj
 VtX332c27yVRiaXA6Vj2MnJ/phxtpCn7WuZmGyCINDg+PQgNl9vgYT4jIFgIzxS4jXl128DbG4t
 iG40ShaQlZrq3DQJ73w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NyBTYWx0ZWRfX/yK8lbD8HxfF
 A76wcVbWtSd/YyvY9QsVKtPXfIfbWEddQv7nnc7nJK8sYUKP5t1SgA+emHfppEht0Ge4JzywvOz
 NaI0YIvHV58B7FQ5mhkixdifltP1fMo=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad778ad cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=EaiV291W8dNeE7VNLDEA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: IqlMMCs9S08sGnbt7VU0nLK403Dtvu_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200057
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 8:51=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The architecture scrambles only the LR word of the {FP, LR} frame that
> allocframe stores.  With the idef parser enabled, fFRAME_SCRAMBLE built
> the XOR key with FRAMEKEY in both halves of the 64-bit value, so the
> stored FP was scrambled as well.
>
> deallocframe is also parser-generated and applies the same incorrect
> transform a second time, which masks the error.  dealloc_return uses the
> hand-written TCG implementation that correctly descrambles only LR, so
> it leaves FP corrupt when returning from a frame allocated by the parser.
>
> Add a regression test that sets a nonzero FRAMEKEY, allocates a frame,
> and returns through dealloc_return to validate the restored FP.
>
> Uncovered by testing some boot images using QuRT.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/idef-parser/parser-helpers.c |  2 +-
>  tests/tcg/hexagon/framekey.c                | 54 +++++++++++++++++++++
>  tests/tcg/hexagon/meson.build               |  1 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/hexagon/framekey.c
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

