Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5C6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX9q-0003sL-81; Mon, 25 May 2026 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9m-0003of-6F
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRX9k-0004qH-Dn
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:23:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PDciKu1842262
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9nNr+4ewzQZLxhh602OuPu2x7MJHFZxV/8fvkHa09Sk=; b=OPLB7MFZU6GiG1Yw
 eDm/Oa5r7RrbJ8pXMISzE91DlQCQ5MVeA9gPEdTQRkaHZI3hau4HaF/b5Lp+8Io9
 /sKvYn+xuvqGUuH3pa9xPZfyrHCGltG8GDcCMmv/JJCEe4LkeQiOxRZQc3Ir6Srw
 UHlTuR+AavkyQPGm8aWJ74W2VdZ/PpA9yNq29iEA9xA5nOF7a+29M0rCX27tINxN
 1pS6XosMVRFpLXSaWje6C8CyKw7zQmT2SINBDsxU8+K6Bt8zlKI8H+nCVyb2bfep
 CGvwts4D2jvL8LmfCxzz+mdEt0Qqt7ofNVE4iOo7PqzK2e0VKL7H9I/BY1SvzH8m
 /RFD9w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0xctf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:23:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1353ac304f3so13855800c88.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779722630; x=1780327430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9nNr+4ewzQZLxhh602OuPu2x7MJHFZxV/8fvkHa09Sk=;
 b=ibKG5+l2XTn6MGxYx55nlv6HO96TH9NBqn7gqaZRZr3rrkHVq3Tk7RYMItGRLmZu25
 rTcQ1JGZ1LLLHjvTQktWiXsTjfFmwJeFAyplWg2JbEWOXjAef7uuHpIVdvnUhkm+ItA5
 Idy0rUbI26U8Ejj8wvRUtApc9mdPLjKmQ3/jlHwVMbhP9/SGRy6S/7vF0I4zFVkddy21
 ljkA8OgfAA5Ab76/YAKPN+RLoyk5xOGCuUdQOYVY0+NTM/7oX5nbv+OxLqj/jIGcyrFo
 8+ZlZ0cO1RFle9xfMIRAfFPA20MA+41a5pI8d8NYhSz+lVp8W9kvJ9VB1gRhVyvSEjLv
 gUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722630; x=1780327430;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9nNr+4ewzQZLxhh602OuPu2x7MJHFZxV/8fvkHa09Sk=;
 b=lZO0TanQULpW5HtSMtwra0yKNnxg8A7SUD1cJ4NEq/d0nc1eBUPkKsaj/9rn++Jlay
 96HmRZyvVDYg9TgmMLmHdh5nDoGK7ucDxH+zB4LS3mDs8iT/yF7tC+sJGdLaTjykUn7R
 kzvni/vD/ln2pS7+EmvkZ9z/p/R9FLAPvvHTeJwEwh8gWDOJCBsqFJZ4XIc9uZhX5PQy
 QNt8wFYuF/OCDNOT8AXDnm+L95euJ/uRn3mUAkmUK+h/umfs7ArK+a01K+4/d45jtnkd
 wxj0gGDnABcu3YIyf0dLdq1HSmf0iLsswXV+9rcolIw4mT5vyHLg5x6Is/8chhbVI87d
 KY7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lis8es/lyQmlwgf+nPSNycAEPJRkHDm4zUtSNkwGDTG004+Rg1S1CkdijQQsL4DM164Gco43lIvIs@nongnu.org
X-Gm-Message-State: AOJu0YxdRZcK1osNajz9o0mR30MvP4z+cq5RFpSo/gBtk356ng8dzQ9c
 jh+4g3/UcnKHWWbpsySjX79kY8FTyxyCbI5gf8GBh+A/262Gc6+n5b3Q64MxIbll/0AvNoYNYE7
 9+ynZYPNf4/4fSZprn68lxX2K8/iZ+myRuDY7lIWz2qvcnQPJrcOIcpYVyw==
X-Gm-Gg: Acq92OEq7auRJ3B7MaDu7ZEFMNIESTlTViT5ZEUnDHItvTrY3nTGxg4auCOlWWyQtNi
 2opaT//UQteGNS1eJwc02W80jbYgNmV+hVngM/Ttgbt9erMG/ekWB3CNa/6bh9jBhj8CHSsHQGl
 4pTbnHzdELquCVVrOpALTqqHMVXur3HWjQfsdM/LGkq95EpH6nCi3xoQGid3QklteFwjHoJL70N
 HMm50IPSLe++IaQP+4nyiM8s3B8TszHWc9hLXmL6SqmU+iIBP63ZYG2sGXhw2sccBYdhXfWZTxs
 rac2nOnQvGhCfHNKM0V+J4z8ckwSOylZ4HUwZxYSRYzywRJazjKcWy095h/qmO6n5F73c+gOlOL
 HSlrMjNkBPzgMm1I4y9vCT9Pkq7LUU233+coYustMH17M9katcGeFAJQxjYWlptAVBelYKw9JoQ
 oB90ic1K25KuuxhQ==
X-Received: by 2002:a05:7022:511:b0:130:73ed:215 with SMTP id
 a92af1059eb24-1365f811b2bmr4840852c88.16.1779722630181; 
 Mon, 25 May 2026 08:23:50 -0700 (PDT)
X-Received: by 2002:a05:7022:511:b0:130:73ed:215 with SMTP id
 a92af1059eb24-1365f811b2bmr4840834c88.16.1779722629516; 
 Mon, 25 May 2026 08:23:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e686fsm6381730c88.1.2026.05.25.08.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 08:23:49 -0700 (PDT)
Message-ID: <80042a33-c69b-4787-a2b5-55e3e0197aa1@oss.qualcomm.com>
Date: Mon, 25 May 2026 08:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/qom: Fix some editing errors
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _27z00OLEqHOvU7s47xF0aYklVwRfsad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE1NiBTYWx0ZWRfX/713wkP3moCH
 ZDP71qFiwKHumc7o5ImyQHiNOtEhavv1F3zw+DzkLBZyMpQCI7w/A/bL9/MC8jz9XgyxNdxiW/U
 K9Z8JxGTbncgaQM/2rgyPhBN9W4DBC5eLQ0zhQUaQMTrIJIJBmF62U11iI3Rox8dmZ6M0SaMN/f
 qEjn6qbNHRbVR1PJfys72PSN9V/aFzTA3zK1vwr+nt4kN0hcvBZovczCNT7Git5NIwVzhcXOYjU
 RyToNasUB9ZEOwdCbmu0zZnxgcQW6Rz/b+f+R1cofq4Qe4sO1NsZ0EupAtHPwVFWUbQiTHVZ8eW
 aF7nrG8KMNbuMeMZMzgD5dpMN9t5kUadBh78Z0AiLHhkqnowXJMQwCPCGVsbRXMuHj03wSPk7t+
 UaXiSjIc1xLOE4Ckdks+fHEJhOvoXNCmToIFqNkF825A2x/J//HThZvZkphI3OURqCWzhYsGzTS
 qcqfMwCNNxCf3YVht6A==
X-Proofpoint-GUID: _27z00OLEqHOvU7s47xF0aYklVwRfsad
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a146986 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=PzGKxP3WAAAA:8 a=gXoBCMzGXRRVMpZuEKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/20/2026 4:15 AM, J. Neuschäfer wrote:
> "devices have an two additional [...]" -> "devices have two additional",
> and also a case of "were" vs. "where".
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/qom.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 5870745ba27b108726da0756aa2b90109d5e0bd6..935bb1004a7839c8e963985e765c866d5b980c53 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -435,14 +435,14 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
>  Device Life-cycle
>  =================
>  
> -As class initialisation cannot fail devices have an two additional
> +As class initialisation cannot fail, devices have two additional
>  methods to handle the creation of dynamic devices. The ``realize``
>  function is called with ``Error **`` pointer which should be set if
>  the device cannot complete its setup. Otherwise on successful
>  completion of the ``realize`` method the device object is added to the
>  QOM tree and made visible to the guest.
>  
> -The reverse function is ``unrealize`` and should be were clean-up
> +The reverse function is ``unrealize`` and should be where clean-up
>  code lives to tidy up after the system is done with the device.
>  
>  All devices can be instantiated by C code, however only some can
> 
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260520-qom-76537da673b6
> 
> Best regards,

This was merged into master (cbf877d67a812be17a9ce404a589e1bdf722c1f6).
Thank you for your contribution!

Regards,
Pierrick

