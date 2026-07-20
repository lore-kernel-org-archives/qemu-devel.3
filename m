Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA69C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljYU-0005EM-KF; Mon, 20 Jul 2026 04:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljYT-0005Dh-41
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:40:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljYR-0003OE-KJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:40:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7YYU02044966
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L0oNE6+duxQAcJ50aEgbhzeLujnpIgklrwRnZa1EXBo=; b=bU51+rtGtqoSp6bz
 elfFK9VfeCeLSEXFFtPoUXX6zNPE4+byfZ1V2yYyVCfzOJX5TyhkbGRTfGX94P4C
 La0V+j3/A+2/KA84hU0bbmtQo3gDFt8MFQVz6HDnQQ8HWST8FQGCjsUgOR1ZAI84
 0LnKHHRyzPHAB9W8zu6haBd/BCcAPJTiWb2OQFLHlQIYIv35ruNa96Wv+gXjBZnm
 kz+klN9XLyYBdBZxnf6/Zh1s0o/pmZfO9I3/QM89kGk91IZGP01iQAFLnAh4uVlu
 wxdd2Z7ZnubXIsn3rHgTfGzZiuU2dN2beRaJIwN6AcuhVoFfL2qARZCC6Brm2o1c
 TQAxEw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg7w7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:40:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso78027651cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536843; x=1785141643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L0oNE6+duxQAcJ50aEgbhzeLujnpIgklrwRnZa1EXBo=;
 b=PfOD84NGCphWmpojdXrJrfkBCV34o00w8lp1bIC/hpecm2TYRdGjW4Mi0nO+u1zvCN
 XKqRLYO0tBvq+keZC/eYLSh6MnmHh6QbixbsDD/J7bodfJn7Ho39Luoe8CDqHZgX7v7b
 8SYEdA1IviTzlvzFVvy8TQv5N1BnQgMKjtnbSAceRUdJBHaPm+Il6GQP3c49yR1Wcenc
 VHEVlgPFKnwKPqgUbS7rAEKXv2SeJCtbhaXnx/cS6IHH0JxGXhaHES/R8AFg82PgJAEH
 c8GGYmaYxYx3kvYRTTg8pnVvcgWHxoGmINOyZS98XpdR2Gt/EykjlPKyiBwWJwNBuP9Q
 snBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536843; x=1785141643;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L0oNE6+duxQAcJ50aEgbhzeLujnpIgklrwRnZa1EXBo=;
 b=aBZMXMlg6sMRRLqBC5itTK7sbSye8HggUdtqRUuGnMz3XpkVvLMB23uMhJmjOhG/A9
 6pclWCQ5djQI/FAYh3VtPfbgZNv5kE4BvflG7ed0qlK5KmnR26wZBugGsJ04IqjSpanF
 uEy3cfdV90aAmVky/X38ZeqiNT1erDDn6umS3Tq85b4F9/l8D4+M4+j8h9ZodIghEU0s
 inLO6gNFkgXRFK85lYcHaYUuRrY3PmBb6V6SXwIJbGQ8PeUvv2SshnjbYsbUnadp5rjd
 Bf2lKt3/8Nzz3IgIwwOcc4s2pwR/R+VShwY6B9k65CUKOu0xK3UDrs/6kUSEkd0lsdo3
 x3tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZe5v7oa+1pHVOSq0MfgwjgbgZ4VArDKnHXyCFD0th0VA6XLF6n3qDhcAXet+07/t8kzZ4q/VB+Nr0@nongnu.org
X-Gm-Message-State: AOJu0YwxzQtLYT/BOfkSfX397Ht0QFpG3qxoAQndxmBlKoDAyv+xo777
 BTWQt6OgElV/j1OTO67qrto8Ln1SxmG36upaEfWpuyBhKTbrXjxN2hXnAt/EL8HJ/6Q3cGfGzR0
 GjZIr28+ocyjTNg81o00JR8z0lgl3YllXQqTOECGKEgHujOLmbSW12UUajRVeGhb46Q==
X-Gm-Gg: AfdE7cm9v6ExfArgPQuzb0p6gsdncNG+eNo1elyPLJuJxru49z9jOSgPI8aL6uqJVWr
 wY/9wekkPBnO2tIOMG6YX+TUd4iMaaZSgW6LrIVuwz7D6f0h6sfe2Y0iCVT89FTY5l+BYnrFEJu
 UYoC5T4qoUhI/Ev8ATmLweCqEaEEep2VG3+74fC76XnmTtLvELt3INqYm7EtMbfRZyI4ETYqqVW
 brnfeHUkFymWCLczTPPT/XVa+vPG04NLVFjDbDTE5NbsOqKMv2Q/eKuGereYFZXgnxPDc4ecyyi
 LanL79hfvBJuENncg4POfVy4mRzeXG3TmdDZGyDLn5Idurb0bclHFwWRu3pdn50fwTu5IHs7ocQ
 +aSJnIGFkly/MslcUX5Jh4DCkKm6pMs6fITq2UkZi+klrnga0SDA=
X-Received: by 2002:ac8:598c:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-5213a385911mr137223101cf.3.1784536843524; 
 Mon, 20 Jul 2026 01:40:43 -0700 (PDT)
X-Received: by 2002:ac8:598c:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-5213a385911mr137222991cf.3.1784536843164; 
 Mon, 20 Jul 2026 01:40:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed244asm26746564f8f.20.2026.07.20.01.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:40:42 -0700 (PDT)
Message-ID: <17becc5a-233f-454c-8c4c-c89ab2beaee9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/arm: Expand dczid_bs in DisasContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wtjQzqCWJh_mXtt6EqsHkKwLLLpaUmK6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NSBTYWx0ZWRfX6zwgw4Oq+4hy
 9DSpv39ugPyEkYbw7DoZAr6ZpknWDsgBNkuBK4Qb1Olo7ErY+r143A+pVl8DXCl5PkxfZJeLPnU
 jbr/WqdDb17b9XcnuC0MTwW6Pk20KY2kV476R+kYcNT7OyrD+dI1+WnMkYLdrhTcPgmUdz3plkF
 6xzIw+gUzDO1vGC56Q4ttnHTWjKRKC1eNG5DxyGYHQ41/c44xff/gUOD4wskW/7TM96japf6Udr
 3PoudsfH+M0ocgW53lPpoRWgW7maX0KEdG1rHlvgX38mmlIUkifrT2zUpA3ZiUw7tLhhHdtkA5y
 xiCuNeZJLD/JWyo0RgrfXut69N+SfhzxMyKPri8O4W4Unv54XWT5dCH3WYwjibTU1xX1i4bzt0I
 VJ97BXkRWwuOmGX91riABaY+D24/AM4oNycyf7WfiKGSMxVkZ4ZuBnA8g7q9clpSBDdJCl1c3TQ
 6/nKAd+NKmnjI6jysYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NSBTYWx0ZWRfXzHustAxsBPK/
 S028+4h64pl4IjXeK4cdgyiOBCmXENTcFLoADnpSfWW3zA937DNX8Krbcts8KlaTbseX59BlMRo
 0JjHZdXxofaO51Qr6ynFnvahmJO/Gpc=
X-Proofpoint-GUID: wtjQzqCWJh_mXtt6EqsHkKwLLLpaUmK6
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5ddf0c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/7/26 01:22, Richard Henderson wrote:
> Store the true blocksize, not the encoding.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 4 ++--
>   target/arm/tcg/translate-a64.c | 5 ++---
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

