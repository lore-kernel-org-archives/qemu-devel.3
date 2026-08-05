Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51CC55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrilF-0006yw-TZ; Wed, 05 Aug 2026 17:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhqq-000595-4d
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:04:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhqo-0005Pl-Qz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:04:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSTuu3889584
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nxBZgyeWRdkHM/yE3b4dLapkRZFV1e97rYASwVAy5cA=; b=RQE8u5igSPV13byI
 pr+NnGpuf5IBj/pitGcn7SNAbkGWVAR3FssBL2/jVf9aKeNf82vHzSfixy9a64FY
 sL126gkFrSGc4cjrFDmypXTt3N5s7Jrs0GtWvOEJ7viKDWJ8PaelKtyWf0PqB51L
 Ui4AZhJNred2GAF3BfCvPH8xrPBknKzcuBFgPUzF1Et4ATRnzepKa/8bkPfj1/ib
 iFh1jMxbS7I9gXagMa8zRejdLhgC8TivVNWMXTqCq/4jhrsxYVYm6lI20prHZN94
 bVEcJOBG5ePcX6ODvQGbd9gqKoYaesQVwZG18irN8E9OYfRotNpQRPll0YtHqChY
 Np/vPg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5swaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:04:28 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7f1da5e5b06so1688557a34.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785960268; cv=none;
 d=google.com; s=arc-20260327;
 b=YbaEjIFMJd26lKklYmS+HECNnBLNrugmBE9gGTohpaoOndCjVMaVMyWGajLy+TPkCW
 Pd+xUzKe/1uXZz7fKCwFer33Ph7qnCAa71xir94FvF4/rLj2OoA15Soinkva+MaXzxcT
 JUwvVcakV6MVJ6DqzzP05WOoVvfBsJYIRAHRShfj9ndtIqUoeTx4cFlNmm2K1CslV42b
 HiRWMP/7dpReOZsn1TjSIieDd7b8NFgMB3GFPUaxl8aMZXZYdy733ayjtKGfD/6Nw6kU
 lOW1mB2ORCDDD6QTqnvrzhHsed8NmxlrvWanT5mpRj7+RE2DaD1/XzVmzKbLXercrj0J
 B7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nxBZgyeWRdkHM/yE3b4dLapkRZFV1e97rYASwVAy5cA=;
 fh=Ojiz9TE6n0gwa8Sqy4epYViWg+Us2CPvSyvRXAzRpcM=;
 b=Beu0L/FrN4ibHDK/IcfyZO0CY63ueXlmAI7PuJ7RQy9kRbrrRvcmcFpLsZMmWleYLC
 +RJYJ+CTRBihDrCs4e5zszqnuuoN37b7r39F462XDowVmitwTK8RTcQGaDLnfSY5jsic
 DCB06tMFl3w7UvRXz1nAylSSEeXhWGDwoIEbEtPD0jlmslZ5D75L/v7FRwj2AvEl+RJ7
 S1lR1b76hw8g6l6n8ji5RCvksbmxZeJbndnAuezp9P5WHgQCxRm7ecATVYT6WPvfyykM
 W+y8H15XxzzY13dA6tKvKGjAjh82qQzuwcbgAYPiXvwyjGR0nUPImhLfn1XCZ0795uxR
 gy/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960268; x=1786565068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nxBZgyeWRdkHM/yE3b4dLapkRZFV1e97rYASwVAy5cA=;
 b=F/nocPJWW0OONYWG5UZtDvVQPf+7myC5eZIQ5cNNh80kFTnxed6R9///O89CeW84dc
 IrPkObi8LZR8bsQBfO7cE96ThzqFnzM6WxATPyQ4EU3g466iXy8p+novqJx9fMPA5jJl
 XmQLsztZJpV+t6Te7KfHU5t8ab/QlDpV6B2A2faZ2Llmh58K5LAWPzuZbB5FbMxeQHCl
 DB+q3U61YPBaBDg4iR3CndZVoHAnbPBw15pbfJSEma3EhkbQVSJmPAglb03ATVFTXENL
 Gdshi3ZQEUnPMDIi/v00gyM7fRC54TecQr/e1OFusCkNqQ04P3WOwGZ3QM5RIRVPMSyu
 S/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960268; x=1786565068;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nxBZgyeWRdkHM/yE3b4dLapkRZFV1e97rYASwVAy5cA=;
 b=WdNuD9t/oiW0X4Y8Zy8uxSJfTIcb/gb0vsrmYUWucFTu6wA06euh+svZdhhu5Tml7z
 Du/QfuVYy5uhZCgaUOsYp3ugYJcpsbR9C2zmKW9my6PDfYqb2V6m3nVP+lz2kWksp81h
 w83jtZZgzRhw5d2AdOTzRvXHsQX35lhis3zXC6TJ2MMGRU4n+J7Go4b65PwU8EuBpFbu
 C2NET39RJpaG2+gaKb/OdXU+gX53ZI9XQ6lV2hYfr6VXkVvXVT/3Zsj8pWPcXu9wz68C
 +yDK1lRnntCOJ+Bv973S5p0a0wiU5BLr7BBd0pbGBZGQevYkZWDDnCm3Z5Ou9Iafy9yU
 brIg==
X-Gm-Message-State: AOJu0Yz7XsGhpyTpK36poB4mXF5VmACfnYkpY5ru2bgVisyUZeLMA6eW
 9VOfi0VFtckYWLb8QIUMg21XtkF3poYnZJdJ1NQaXTS7Xk4yJ+RJN7Qb2AUxVWrqlmKU5L5R/YQ
 P2YOi1cXVvXfShYatTmelO9+7JpHqKJfYlQcsTbUFDIb6lYCCF7dBrIxjjww8lzXv2KIyUSAGEZ
 ZT9OmpIzOE+RFMoxa4VEjshzElHJBXGnkz
X-Gm-Gg: AR+sD10Fh5nokiAkK8LEjw39oB2RZASl7h5oUCdqrpoZf06RAfL5JctKYsiPTspa6wm
 kaj4coPWF+3Dp/PC2PhWMquhFvn8D42ggIoI3x1YCRVSd1d6nl8uEmN4DjXFUr1H1XzFVVOZb/1
 KLbt7YS8BPaRCpvRkhgczeBgM9xj+q5jYo4b9MYvKJakY7AO8hc3CVGEBDowE=
X-Received: by 2002:a05:6820:1905:b0:6aa:e524:fd7f with SMTP id
 006d021491bc7-6ae970b941bmr4809451eaf.34.1785960267936; 
 Wed, 05 Aug 2026 13:04:27 -0700 (PDT)
X-Received: by 2002:a05:6820:1905:b0:6aa:e524:fd7f with SMTP id
 006d021491bc7-6ae970b941bmr4809421eaf.34.1785960267405; Wed, 05 Aug 2026
 13:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260805165225.3117924-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:04:16 -0500
X-Gm-Features: AUfX_myLLoSQjIL322GtMI2ooa4TgdxmDYNgmccZZOOna5zirS-pjwH7uffwYEY
Message-ID: <CAJ+KCYNap0CZBTdTzT3NkHvYRQcSeS2pgQn4b=1OvSLyi_tKVw@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/hexagon: add GVec overrides for HVX saturating
 add/sub
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a73974c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: _Lc_TlqYobeyKiccgY76t_P-HPbdN6TK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX6aBsHKjyAYn2
 cwOegeUwjRDKSkPDs03+nEa6xKvl6F8eVKJ2D6Z3ScPW5PhyvuX/0of6IUbnRE/Do/eKcERg0v6
 sh5cXVjhOohvD//J0KchEXamqL7zfjtLUfuZLWSoJmsTSzFJeUtKXr1piAyXkYwCid1qMVDQbN0
 oFDAvIQePe/HRQcDC7dm4mJT+KlZU+8gGJMthPOWFRlVD5bi8fUKbII2RYa/+JZxkhsOV8auq2L
 yY3BC9IDmqspCPGE85/hwp9XwIH2fhvY8J9enausjZepa7b+cOGSdxEF7epooHQdq//OVowcxaj
 jC4t4e7GajdNJSlTFKgejJiojhj4viYJNgsqKZb5qJjdgW83DMSMW7gDkwdXIa6tSwSBWzhauA1
 jVxqFV9A4c5YHPET4qWuRK0F4PTkdq1JVtaH+vW2rJN1Sr6pe2HdJop0VfsGhmdlFMNyeOFsx6R
 rSrofJbUVVciL54RAIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX2C6OndVK+svU
 bqeqlK2kn72bWlQb6Xb2ZaMp48QYTlQyZOhN2CIu1jLnEJF4J+j6O8hoPFkx3TOwcFsPxDeZ1pE
 gQRlbRQG1OKTgDiaUr8VGwaghzssQZI=
X-Proofpoint-ORIG-GUID: _Lc_TlqYobeyKiccgY76t_P-HPbdN6TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050164
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
X-Mailman-Approved-At: Wed, 05 Aug 2026 17:02:48 -0400
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

On Wed, Aug 5, 2026 at 11:52=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h | 93 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

