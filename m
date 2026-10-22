Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A44606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9kboTXu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYbM98bQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJyPw-0002yp-0I; Thu, 22 Oct 2026 15:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJyPs-0002xy-3u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:25:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJyPp-0001JB-Vp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:25:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtTKO387600
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Naukb8YH2aGMa9clIx31kSQB+1cc4KDDVoLMUrR7Wvw=; b=i9kboTXuxaLA0clM
 9ZBKl1Ujf5OO/owsvZX6ZEC1bHwtxQFw2KTm9To//Ulm3kTq6lGDCjgQI6S88FIa
 3IJmwlPZTKvfjCbHayx2HnsolpDVvsRq4N5P/ttOqMrDaViDiIvlg9FcE5tDdL3L
 MxDp5HzG7iHhaPwTUenEoT3r/jqB7/9K7Z+3B62r0urqEQxyIYDDq+wyKvCqapPK
 c//rWe2hdGNp0bO5YtyaqkuDXBH+Vjtn55gDktI5vVdNZf4UZCh4dMWbtdYq81w2
 cWW7kio62l8hQstOMv5tcyofh2MyohJMIpdayUWtiVcSEnHY5ybuYyZnS5Wd1Jts
 TxCTow==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq49ed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:25:27 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4519ef1babeso243460fac.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 12:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792697127; cv=none;
 d=google.com; s=arc-20260327;
 b=QjqO7On40ytIqcEbuiLVY1Ii4ZvMjwL3Pv5lB0v3v2vjwVc1A6x4T48vSsK4dA3Wn4
 yd0yt68pXoQU2PYRi5cDmJ6exZUoTPTduhh1QzSYvshE3E9yXeOH9Kl4NX5t15esyI6S
 Gz4fvn52LeCMN6NaiRNuyQKpZt92z48p+iMTmfiNN/67M7sDiFFTfIAUllCTQ/sN/ixZ
 6/YA6BJBoB1Aky3h0oC3mPuoaLCdWDVMoLImPga0xNXmPpPsfWNp3w2LiubIZPYOVcR6
 VZRYjWiryV/U4OB1RXDD1a5mCV29DOzGCrsqeSYwCBveJboqUvJ8lIq2v62gizvSqExl
 c7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Naukb8YH2aGMa9clIx31kSQB+1cc4KDDVoLMUrR7Wvw=;
 fh=X+mPrGF8PwPNFxjkNXNuYtliDikbywOcHBV8TCdDgCM=;
 b=VnFA4M/W6dNGFUelFOCWDhcmlZK6Mep8WD+RddFG9HGKjcnJOASh4ZWZ2DtAyaA2iX
 7Y6mM7Nq6AmWtgTfkjxDKP4RHlWByXMbF6uqltgNf7W7wWlW5kR4ZT3XYObB10N7Ooiz
 jEWRpeuJ1pRhlc5VMkP5Oa8Xtduvj6UQqwntTOL5qwB5GAtyGuFBiX4csrcxVjSgq+5E
 I+01xDa3LICzYCpmRlG9Xuy/146RCHcIJtl92gcHEKEGGcKXctxkyLL/+9O3CwPfMLug
 YRoc4e+/DAZPYJ7Gb+mbWHm/0+T9T0E9uBNQJLLy7HwmbJvWavfwx0AOpAaaz7tYt02v
 SW7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792697127; x=1793301927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Naukb8YH2aGMa9clIx31kSQB+1cc4KDDVoLMUrR7Wvw=;
 b=RYbM98bQGXy8kB+P2NwzTwTIHN0geBF7l9uYmSgeHtAOETAgijpGMWYz6Ue7ZZL5wx
 YjKmsir4JfwTl9TqpU/ey0U2MvPgn8MBPlx54liYrl/p5Ybkp7WYHsRsI6aWjdrpTUFa
 PfjOOka3ANoqvYKUjcZrIajllx0iNzHFDdT3yKfv3o7pGsTEqxAHmKybJJzWCJpxbOed
 jSNkWicTuyJLF/wRboZjUS4uRtRNkPQBqUPgIr8ZtiXFZpbmkBIEagDHx1Nrvx8tAzV5
 rOyVv12O5bnNAaDo9Vr+xPsilvDEQGz7cuiRQwRRfZk27u/uQPdyMc1FW0NGov5PVSyG
 uSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792697127; x=1793301927;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Naukb8YH2aGMa9clIx31kSQB+1cc4KDDVoLMUrR7Wvw=;
 b=GJUg704rai4h0rRtlCibGUmrVU6hFAn/vtoFioTa6XhPWshTgWDF7abSIno+PHH9Qk
 kKKPKDh9Y0RA8W8f0DCcvLVH3QBdhFS5bZgk1YcsKVB8t1BpeEa0bmEi+ADtC7GUtccZ
 uRsYfX4fx00ZR3EYOdOcFqdl9GRzpkTx5zsdvJNdAGgvn8yc+Vb6ahXen82iQk1G8N/t
 bwZcUlqso4wsScpFbN/PLRNVEvlN7temlXRmSVqIBsMqAyInMzkNInOWvdT1aau7Kxpf
 YI9cENVs/DIfch3ISZ/JUfJo3tBim3BT2Y0VRJQAGKQ133eJCSy+bWLZGGTdEvzAHSvD
 yZVw==
X-Gm-Message-State: AFq9FYJvJ6kPaQ4HuNwe1rM0S9i5VukyGlgIwD6kVQolp6h6GncWmoz0
 38m91i6WOH9rlmjLI2rQkIst6laboyUYCBEa6jWEX54e6blPVkN5hrQu+zC7Hy8CSdLbLhW2jiA
 9vKyUPdD36Xeqw106VAmM7STORSejiHEo/F+Q0YvwLA1IXoeqeQ3ieK+h5oHTsp8dWlxAlMTflI
 I+P6BLd/Qpcvi4DkKloA8lDo3dLseMvLnH
X-Gm-Gg: AYBFou0waUJ0240q+yT7mIkqLOhef2hZrbR0N2nbvVjosQ0zIionLnrZVNYOsB8+lJy
 QpN6tQBGo7NArKu9GArj2JG0O3PV5oQSrxeuP/sKAGTGJoEM1aoBIdfeIZcNbNIGBtFs7Y/ZghW
 6Jz9IBXfLYXjJZ6Rr6iFzUdv/4Q/iPtVxmAtwEeNbid6dNu+IknUcPgkkCKlIw+U16NC5DPHPhe
 aY/9O5hRF7VH5Ps4sU=
X-Received: by 2002:a05:6808:2208:b0:4f5:98d:d1ae with SMTP id
 5614622812f47-55be83213a8mr48509b6e.55.1792697126650; 
 Thu, 22 Oct 2026 12:25:26 -0700 (PDT)
X-Received: by 2002:a05:6808:2208:b0:4f5:98d:d1ae with SMTP id
 5614622812f47-55be83213a8mr48490b6e.55.1792697126139; Thu, 22 Oct 2026
 12:25:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
 <20261022183147.1535585-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261022183147.1535585-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:25:15 -0500
X-Gm-Features: AclHuK_xdOE5RRB_Ru0wshpBv49h7z8XWUA9ctZORjdt2nU3rMr8nqHAKkSyL5I
Message-ID: <CAJ+KCYPMxmVpquQsrY=m5cEONPtmSDY636f89fTm9xnyKF8BUQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 5JNIaZzatdlUH2aa5tZnLlzXHM4wER-P
X-Proofpoint-ORIG-GUID: 5JNIaZzatdlUH2aa5tZnLlzXHM4wER-P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NyBTYWx0ZWRfX4D6jwlS7afGZ
 psd6Txjr/Yso/fvz61k1hWb+Y+mhfE3Afm/FgGLx0LkB7997m6pE1sDVFyycj2ocNuSHPPUYNdB
 w52VNCbXAEO4adNIJbUL4tKaEFbA9/Y=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada6327 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=4LkgUH6z6pi3v63jlOMA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NyBTYWx0ZWRfX+wvNBbCtgp0t
 1S2ws8WexSv4lGqf8q+EpCnAN4Tj7qo0IRYVToIJA04F6Q4sdydhn73Js4pgUSPzOWFgBGVRs+u
 /vd4+fILZwBgWFHJ1a5UqOC6VZ1RDuKdUaHLjIV1xG7QmVTwf7ynQQjz/Ih+O41goK5dPjtUYbJ
 RG4m2jUwnhOpGLZIrZc1CssZljrDeictrK3w7ko+T5syR7QbgY4EnnGWl/9IjKIWL/i4hEWAbNJ
 AU6UIStb5RT6t7887WjmC/zjgJDAcI1RWKOYB+kUzd6js8F+yqql4PS4n9dApo0pE9Nc7cAcCmp
 rKimpyMyr0I/vhWBC2dzz8LHJUbLsQZgAVcY5oKB71aqgjiTYqhHY0vrfgYult0+KKPEowWEk1M
 uGgCPCcFmaaMvjMAHhBovQ+SqxwKGWNSY6vuJcPJLgzqrgm+7+43gs8+9fATrGopTvKShXtpqcL
 zjcrNpnvwuYCFcpafng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220077
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

On Thu, Oct 22, 2026 at 1:32=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add decode and translation for trap2 and the vallocframe and vdeallocfram=
e
> instruction forms introduced with v83. Model vector stack overflow as a
> precise exception and report it to linux-user as SIGSEGV.
>
> Teach the IDEF parser about VSP and vector frame checks. Describe the
> vallocframe and vdeallocframe instruction semantics in system.idef, and m=
ove
> the vector stack overflow check into a shared TCG generator helper.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h                   |  2 +
>  target/hexagon/gen_tcg.h                    | 51 +++++++++++++++++++++
>  target/hexagon/genptr.h                     |  1 +
>  target/hexagon/hex_regs.h                   |  2 +
>  target/hexagon/idef-parser/parser-helpers.h |  1 +
>  target/hexagon/translate.h                  |  1 +
>  linux-user/hexagon/cpu_loop.c               |  5 ++
>  target/hexagon/cpu.c                        |  2 +-
>  target/hexagon/decode.c                     |  1 +
>  target/hexagon/genptr.c                     | 21 +++++++++
>  target/hexagon/hexswi.c                     | 25 +++++++++-
>  target/hexagon/iclass.c                     |  1 +
>  target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>  target/hexagon/translate.c                  |  2 +-
>  target/hexagon/tag_rev_info.c.inc           | 10 ++++
>  target/hexagon/gen_idef_parser_funcs.py     |  2 +-
>  target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>  target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>  target/hexagon/imported/encode_pp.def       |  5 ++
>  target/hexagon/imported/system.idef         |  8 ++++
>  20 files changed, 166 insertions(+), 5 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

