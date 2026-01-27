Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E6D2FEF3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 22:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkrZ2-0002EJ-9S; Tue, 27 Jan 2026 17:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrYp-0001lG-V1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:29:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrYo-0005rh-4p
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:29:23 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RJ0gFI2436401
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PfcHlOqRAXlAl4ByZ1aP8CaTQbG/37TFwZBe6fFEN3s=; b=SAvjE6Myi4/9fhdr
 GgqnfhkXkbWanKAfzLL9vYIe8qyYmS2cLcIkr3xqCGjatDGYeJpH7ptQ4seKtBdS
 6rS4/uvxYwuUKPTI4fCeFj6e2tkl7OOIrWy7Ocn5VZBL5OKSuaK1z8u1a8nHV4Sj
 aqWA3hGZiQzaNojfFm7yI27Z37INw1Kl2oGrwA/KEa+T4E6/XwBZEgetX2SqMTX4
 hfEKSr59x72APIgW4v5+cusB/6RSaQj4PoDgwrsjLYDK03JrvBDo1Bzv1NV9jzxl
 NlT9GjYZrK0RqbLuvmzoLPuNV3apfxyvR3GCnMAfDIj+C1xKnCoW+HrBFfABsI5N
 hiEl0w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355rj9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:29:19 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6495d7d6a30so6977544d50.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 14:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769552958; cv=none;
 d=google.com; s=arc-20240605;
 b=Wf57CrxKc1xbokxdmKT6Qes1hrHo7wJy+T25ZuFm10zNNOJgxN2AgG8I8TOCopw2/3
 HVpGrg7UPHSkWB6MGXGitsCE/5Py9SXU4mjoUEjQTy+8vqmfEKkuQ3K99JSnNDR6zp9U
 Bm80TT7HuThFF18adQI/+XKjz0TPXYhySDNbRmmVNraE1X0/eRpqmg8GyIZn+r/QbCRY
 PUA8+9MtRc3/T9OTpfUaKRdaUJN75kM3MNUW0u5baS5y0xiOLrPohp5LwyHc8oNYAF6V
 XGOK8VqB0dJrrz3ZrEFG7q8qt8RZo/CuxKOxKfNcS4hSZ3XMRIUBDatgAe4AgVmlOqgu
 2xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PfcHlOqRAXlAl4ByZ1aP8CaTQbG/37TFwZBe6fFEN3s=;
 fh=C2pn343JHALtp+BLnOEAOBn8b4w2r0KQXTKKCtxCVSg=;
 b=Ci5q8rJ7dEs/o0AzY9lQng+MWfYr1YA8n11Y8Sd9v1EUgbjHEauC0BTEBUkb6W11Az
 BjPqEifvuT4fqzk/LNBMUIYMaJyCWVvRzr3+VJmNOAoJuUmwgikfmkv4WVPSpcOnwzYX
 quAyevqYDtxOjAwluvQHgXUfhe2Ahx09HZKdtXNZ37LmOH+ZlK7ELccV6gc5LlMVCyEy
 5LSWohEH86dZcFj3iyiBRRWjxhMwtUiqrpQHGsFIRXdnoJkST+psvD1muX5k/zRL8hI1
 HuFDpAltD0+laL1T9ctnsVMQTqB3gAscIUmz515ioItNBM6nu+HbNzdO5rpZ4LU6Rmpi
 E1UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769552958; x=1770157758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfcHlOqRAXlAl4ByZ1aP8CaTQbG/37TFwZBe6fFEN3s=;
 b=awXeIRet7lzurnhaR4HeEhX+8HYfg31eguosqrlYTKLgb7BKjfRvtN7+5wXyq2oR90
 XYHyuQcRI4ggaf+NCW6CMf1J8miyjsmjIDARGObfIbrO3KvOy+J31v23LwS3slu9wibW
 DG2tb7r3350kqvtER18q8eqOu4S5KmlY8WB9tF/WED9SvxOfol0r53r1O4QJPsoXkWnE
 hj5oDMKKy24DLUgY7nbbqNsobrslYs6m49fyXbWKCmrNWNp7OSJCTpwAQ9d0TZ00IBpb
 WfMTmxbpj4evyxO4g6kAMjtj4+3M1FtLJroWYVOUWBvCquB6XmBWALAXMsU3kYsJMDvL
 Z9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769552958; x=1770157758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfcHlOqRAXlAl4ByZ1aP8CaTQbG/37TFwZBe6fFEN3s=;
 b=jfQf2GxGftmWx7QN6QFlkWvTK7QzHNHv547RyRcptOojeR6u3pcdBuzE9pPj+TeTlf
 DK/Uba/suauJw1se+Niz94d/hgRMI0AIrQTl7qA3lwWQx9v7mqh0esQeo6DlI27qtvyB
 P2lIQXh0CjMMN1R2jzNZ/ews4u5p0Zr+vfPM6x/jaXrbSjEGhTcq2bf0jqxf/W53Da2V
 edQXxR+7QgH0hsAQdTqQ8U6xNkBIfb8KZF7bPQYXG2hAC8/KmygVXrkF2x1uDkFTNcwo
 Gh5Xz5Nip4E7zAptdyanj1hwvPLIMIQhYOSeEDKqvwAvltIfkqz5LzAjQDQa03/3KdL9
 PYFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKo6Ets8wW64dO7luMr2FdbctthVY4RyZ/EMdbOZZZDEMeJwUnz9fqUdajpxwisRKKB/OsQsddcrom@nongnu.org
X-Gm-Message-State: AOJu0Yz889PcGTvP78IhJ6rQhGCp0UoYfMaFxh3IuwEYTCNiDk8D5Z+V
 RLrDBgx5ovl9Zek2PW+gNg+NPXcrFULB6vKNWs2D7MUIDHBnhn4wJGCt1QyIgOz78Iw0wFH4iLa
 h1Zjsh0lMwyRPRlwdNbylxLJPvpjPj2XjrkDRq9G8sVvu1wRgJ5Bep/lTMpLwS97jZkVOuaEz+y
 XskpUyEUner39SvX3XZFYjDtB4RCKvLR28
X-Gm-Gg: AZuq6aI2lMU8W0NLkUyfyupHgDi30thLctokPd6Kn4eIsVNrKgHAPl3wW+9QaWvmeMF
 nGyTSJqzNzyzum5xeiPsNK0FGiH+g0ZZXsiWQEw/dS9gEGvSOrvez9uNRpoCVmzEUxF2XdR1Dku
 XxgxUdjohaIm+Stg9DsGeUXnyHAIiurn4P/jkBRjKM/ZUoWaByhX0sLDR9hst7XgdYPjA=
X-Received: by 2002:a53:e1cf:0:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-6498fc7741amr1850496d50.88.1769552958264; 
 Tue, 27 Jan 2026 14:29:18 -0800 (PST)
X-Received: by 2002:a53:e1cf:0:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-6498fc7741amr1850489d50.88.1769552957908; Tue, 27 Jan 2026
 14:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20260126223439.46974-1-marco.liebel@oss.qualcomm.com>
 <CAATN3NoaG4T2iNy2twsHi=7LJDa9=kqkj=Z8fQ6BxJawJ_QUTg@mail.gmail.com>
In-Reply-To: <CAATN3NoaG4T2iNy2twsHi=7LJDa9=kqkj=Z8fQ6BxJawJ_QUTg@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 16:29:02 -0600
X-Gm-Features: AZwV_QjD6iiOIejEvtTnQ6cFp4ft2F3xh-vhu601Kylmk43M1tREzWwMJKKg9rA
Message-ID: <CAEqNhNZ1c9X9+VbF4TNgR6dT613gXi7a--FkTFxrbJomVFxw5g@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Remove unused EXT_IDX enum
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=69793c3f cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=UYruiWjeTYj1Mvwndz4A:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: OWcFiV5D0fT3MwpoL4sqn_2owS1z4BWa
X-Proofpoint-GUID: OWcFiV5D0fT3MwpoL4sqn_2owS1z4BWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE4MyBTYWx0ZWRfX7D75QGBnHh/m
 D8LI+4wgW1Q4/lfOPhvtD2I+sC53nYuKMcI0dEyfMDzVYk9ctOH50PrqJ8R6cpc1RdU66zlWllG
 ftGBNaC9w2Chh8LJWbyW/fDLKwuLa+8RAoQMW+kjg4+mLvcQc12zr0rD3Y8ns9KWJaI7xL5GRTY
 OkVMu+dNU1pEO/V3eQC0BM6OeD1mZnmOySZlmLYAXKWmAqPHcvFbaFmFbHkJtEFBsWaj0Zz5IjE
 bPEatHlFnKjROEMhsZXKLwllR2gxipkKF4m54uAxjEcPfKf3Igvvpn6W2+Y2ew3lNW2MM9F0MWT
 OqDHLilkI13CsWE9uW5WB74rmIdzccDikvm9/avQjsz8vVOyLdj2VZydZ7olBelP5pl2vevIqRL
 lGmIv0J2TNuOxX2E4oANLWa8FS31NCl8ausyLlmdv7/swMSk0jiau0sgs1IxJaYml6KiLMQSziX
 rh/c7bpsk3hVm93OtJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jan 27, 2026 at 1:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Jan 26, 2026 at 3:34=E2=80=AFPM Marco Liebel <marco.liebel@oss.qu=
alcomm.com> wrote:
>>
>> The EXT_IDX_noext, EXT_IDX_mmvec, and XX_LAST_EXT_IDX enum
>> constants are defined but never referenced anywhere in the
>> codebase.
>>
>> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
>> ---
>>  target/hexagon/decode.c | 8 --------
>>  1 file changed, 8 deletions(-)
>
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

