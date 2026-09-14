Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C44C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Cw4-0002md-GA; Mon, 14 Sep 2026 16:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Cw2-0002mF-Tz
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:05:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Cw1-0003Xd-EK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:05:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYUwS1485292
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 20:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TgI6UxXm9JH55nmOiT38peh1w3muJH339dgHdpw+r7E=; b=c5sqDhVEM4vZP/U6
 Wm06gUCJ+JcHL0uND/x8xFjCq7QaDbCjtf+PgCgBI5VChy9+Q7t1hdKgtBAuxzhU
 OEmFMwn8MQVoFlDP5PvY90zVZSZ4a6hfuIVaytZtVPpPRYMNsr2THigzVvTkngru
 GzixCG8CggqotYFPGLj+UTcA9eYdZqhTZoIwrHsbIWaUz4WnRRwfijYglwQV++qY
 PhRTp9l6Q/LquEo/JmKsJN/0wcOEinYeTwf+BaFZCvtceNoM5pXT4t7YIe76np9Q
 J461aXszcvNOL71+FAYP1/irxeY31OVy8gYSzFqrG/7DHp8M3APHtNLCYtlGwhAD
 wD1kgg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2kt4p8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 20:05:47 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6c18e7d53b9so319873eaf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 13:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789416347; cv=none;
 d=google.com; s=arc-20260327;
 b=s/mKmvxYEyHVtcILizAFZyzXx5eLp+zK1xY07dDmbAJCEJ9aIgaSqEfwWY2cDYyCvX
 mbW8WG7KVHbAWXm9o+e5brR348izlzgzrtjnrPr0tAnethi0yOdyzcmvD5hkKE++Lahu
 dys4F1sVkE9w81VrQ9TXWDZU/Ry66ZWssrjBTAKgIM729BANT3+aID2CROuTnu+M7kLI
 mBpjD479/1a7Hw1wcQoGuCIFFsZUlVNvO9wIVxuc5t7HaN3fdBBSkvW9rCnO3wbaP6Bd
 o9dKCLOiBrhl76sGyaStdLoxx4v9hV6+vAayQG2Mj14XKqRtC9HTmXtq2f9Vm5t0d69K
 7YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TgI6UxXm9JH55nmOiT38peh1w3muJH339dgHdpw+r7E=;
 fh=M7lBbyxpxdZUkm62BllzSUSiqSG3KrVNq9NUgWMynG8=;
 b=U3595I2Ig7ZVfPW91jMuXwVEaWavaFhJP8FA7yjTdtnfsClvAN6du4+EoOmfkgsgwE
 xtUfYJ/vJqVvs9jJ9PUhpUQISgPdva23RT1saVvTuczhoB9WFsgDO+4dJRc7+Zfp833J
 /qoZtEHJEHoIikG1bT2UMr2RqpT1qHj+CAsj+6N5GK5oc9s+/uiEImkDiHgUbn1ew5td
 8b2mVEXZWByOVU7olpJ4RZ+kJ01NbY/S4o36FA9adBZVBjE0BczKlJ9EemcU+5XAs0jJ
 /Fq4hbcNXvRJg0qYxNTfVslGS2OyWLjcadFchOiTIiAeKOgjy1aXSpJXMMxKBhvlTIpW
 0zjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789416347; x=1790021147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TgI6UxXm9JH55nmOiT38peh1w3muJH339dgHdpw+r7E=;
 b=c+qWaWE1M8ihguk2FvpNyzEu6iEszhnfyiVtqPXp+v1zpXjYZn3jPzrUK/0QSOeXpo
 6XKJfdpqrkCd32wj3jwvTiXWFjSq1HLApksAf/wEgb27k9eifFNfSSTG3fDIoKNneyWb
 /Odh09IADYEfZO4j8mwK63NlrqKJZs6jOWXvz2JHyH6/L2dbIJNOXwoDoKzO8PbB2DCk
 Z0hqagTzTZhPvL/bwfGSUZJzYNuZXiX8sC46BS3lpvuWHDOb5pCpj33uzgGNlG48djJy
 BFS41dsIMXLJR4kDxmSiFLKaOm8GCycqGHZo/L2zs2ojA9qRTjjozSV905Uu0W9cthrS
 77CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416347; x=1790021147;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TgI6UxXm9JH55nmOiT38peh1w3muJH339dgHdpw+r7E=;
 b=fMJMFitMz16MXn7s9XhAG8z//A9ToXHTZeV8yPHLhG4gU8wtifvQF+XImgpjMV1Qz0
 eId9pr8PYXMXpTpWqzqThvIAXIjRRqt8ap3rh/pcf/9yejKu5MYUsShWJTAT7zC/kn3N
 oTdps/LN+BqQ9VTQv83VtBionF2425ZN+2R5IHnFNF+F4iGGxIJifq2i8aD/xKGcA3Wr
 IUSMTouimjcebI3ffHPuf/41nOmsP2Ap4qUxRooD3KeaJJ5InyyQ5sgCNL689m2dIN43
 IlmeFLYEaeDepl4Ug5VkX8qlewJzBZqlxno53/JEvsludNHUYAaurDnmw2aQkHXphWCn
 wFVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLGHZEaXCPlPkGQ0J/Ya4IawMQcRz0YgT/c56MfozW5oNI8BmbQYmSbDvt6nzFlXekLy2QpSADJqC/@nongnu.org
X-Gm-Message-State: AFuF++kBoMEoOxkUfJYKdwGC4RsQDSFQ5fAf06vCs39mRqIDAbSMz34g
 Oq+wEdfkZcv8cEiRsE4z/hX3RibY1G6tFLTbC1JsiwJ2fCfN/ibk5lV41cw2bHYIfzJAh9P2sk4
 EoXC5WPboDVD/rNQDSW/IWPaVJaNAi1w7LrvINX2pm64s1HL+vaLaYchr2z4D/ycn+Huy2Wo5bC
 pXsZj7374hKxwZFcBAbdKTO0CfiGN88V4Y
X-Gm-Gg: AYBFou2Tg8YzzDCw6vY00GvrJr/lMIgaIyu4utUI0x7wvOMOS1hl8vG9KRRtazUIr1p
 M7NNT+1cM3JvU/lJlWLrmq5pu4ANfyQ6twEcchfWzOpVpfzs89ghHjiQ54hN0GX68PdjSMlk+X0
 1e6ws2tuzJu32MX2BqG2FtWvpIEBacxBTqruRxAJddIer9RYfdd8/x/bRq31SlCaPqOx0SUL3zE
 ymnhy8wANNKeXUD2Q==
X-Received: by 2002:a05:6820:2004:b0:6b1:a146:1297 with SMTP id
 006d021491bc7-6c636f2a1dcmr448066eaf.1.1789416346429; 
 Mon, 14 Sep 2026 13:05:46 -0700 (PDT)
X-Received: by 2002:a05:6820:2004:b0:6b1:a146:1297 with SMTP id
 006d021491bc7-6c636f2a1dcmr448042eaf.1.1789416345586; Mon, 14 Sep 2026
 13:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-11-ltaylorsimpson@gmail.com>
 <edf37742-23fa-41cf-abc5-47eedecaec4b@oss.qualcomm.com>
In-Reply-To: <edf37742-23fa-41cf-abc5-47eedecaec4b@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 15:05:33 -0500
X-Gm-Features: AcwNN1W43KINY4LGPIrx0jR4DW4hdxcEt3Ju8I4FyhG9MKAte8jtmJdiv3kbNDM
Message-ID: <CAJ+KCYPkjWwLn-Tsn0D9CZ+GoYEVh3Wic5s+ve-0h6_Tk39zEQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] Hexagon (target/hexagon) Remove old way of
 detecting register multiwrites
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: mYmILBed1jV2yFGB1fGQl3eIpns1UbK8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4NyBTYWx0ZWRfX0lf6CvNp1VIo
 sAmRgw6L5n9vISxJBCgdWIitty3DDETkGw9IQGFE3L8dFphMqaGKGguIThJNP2R8yPQih4ebf9X
 27ypLkF+9yyyu/ZRfgH47hbIdtzxUby231zhN6tA0GcpVzHA6vJCc8IpBXbXw+9rEhOVylUf7Cu
 0tJDnbDob3KYW0emQiaan8uwlm+lavcYNntSCT2AQIOSSGbTtOAcy/R2O8h26HTXngeOMkm+OWD
 t4s+bmmzOfX/G2GxRBCkAGFzKA12G9440h/TqCw0svSln12nkUPw8oFAMOH/gJC0I7pNsaYoAOX
 3Z9l1CgCkv8WO6ANRs2+4FXqN0tfFnQpTJW3276HS1vHVhSBaRNbrIjqiTPnXjefPAaMRfIH4Rj
 Zpn1po/JODKlieAtkW8d5o+i6FXFa9GUE9eQN1rPrNPVj57X2Hg3yRCcSX0FqsKFyDUs/GIGpSy
 quEZV50iibSScgaMz8g==
X-Proofpoint-GUID: mYmILBed1jV2yFGB1fGQl3eIpns1UbK8
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa8539b cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=8somZEBab1bAJaWR5bIA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4NyBTYWx0ZWRfXzllOyGOH0U6z
 C5TmNMmqtVLii/QRmB9F0K+TuhB1qWu4izUCnYuGfFijwLoA4W+pumX5c7wmMaWBLbZ0pZj+ksM
 m+10rkDp2UohirxLhGZSqahpt5IPmoY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140287
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
> We now detect register multiwrites in packet analyzis instead of
> packet decoding
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/insn.h             |  4 ---
>  target/hexagon/decode.c           | 54 -------------------------------
>  target/hexagon/translate.c        |  6 ----
>  target/hexagon/gen_trans_funcs.py | 10 ------
>  4 files changed, 74 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

