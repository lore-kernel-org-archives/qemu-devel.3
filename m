Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67236C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtGEZ-0004wA-EP; Sun, 09 Aug 2026 22:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGEX-0004vZ-K7
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:59:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGEW-00057a-9p
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:59:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L6iEb3791208
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dtNukDy+mriNHREpnujIMCaiaLmqiF8aFvwozsBV298=; b=nl3C0tqktXoJHjPE
 VnSXyU4az7igeExQRpFO6k8Jvcdm6+fOEBbZtuo2gdtxtqWeKJxNQCy/xVQAogse
 wK2INrxXLqHG4tNF1dS1ObsJlBcSeWUdFRUkH4Omo0HZZttGjee9mZpRIQzLZgd4
 BqOL8Pp6TXUl9/cHick0E3sh1pinJ5F5jIDxgt1f0eyA2pAIBw5cKwpqXgKdETXS
 v54LF57gXoVLHNO4CnsUhzaMJ8GJ2hhVuUyvTPWD3dX0gkt6UawK5IjE6j/7TVL1
 xFo40sSumnWcO0COca5NqrRyehwXVLf6/nxqWz0sYouDlsoOrUYoGCnLehRWrC2k
 TCp0/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwstp4dc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:59:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso19872441cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330762; x=1786935562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dtNukDy+mriNHREpnujIMCaiaLmqiF8aFvwozsBV298=;
 b=jjuLzo1c8i5g/CBcBlzEvphnHbDiRDzuu6E92GbbZa91Q7KMw2sYouKa0+BfpElEcV
 CbsA0H+SpRZVlQVNd8bfDllrx/shSgcGrl6NkieZ5r/KVLfCiO623qH6dTT2zLwtSap6
 x8V2frA7ujlcivGjtQISO8/ioeFJXNZmTdxjWfKRzkBIfFEwOZHbE1Ag4ArQ4jzK5znM
 I6Jb7rLjkwOrKsGwV9OPmGhw12wPVZPX3jG1BpZws81V0OPpQyARfPgJbiE3sA2IoJ5D
 RX0ePPHF6bFlEyBNTaFPAUR1qYVKhITlgH/hM9mzsvGH+9q/4hWRNXQr4tOyk94k2ZYw
 q8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330762; x=1786935562;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dtNukDy+mriNHREpnujIMCaiaLmqiF8aFvwozsBV298=;
 b=UStm4KZaYJVgIJVmjqMlCFJfBFu6VF916o+N/kiLQ4IAg5KkMdQRgrK77vXZAktXby
 MxPyYFfcziyxwjQcEA/wXTJEQ44atl/fKZQ27w9UcQk+IavnNQtV6gakHipYwOCBEiH7
 uPOGnoT2/9ngIlByV+jAxOIOh1PTnW0NB9rqRVrXNR021HFstedH/CgBgs0QKHjM8hhJ
 l7v/O3AQNIxkOJ01utSCXpIwhGgmBjyXEqUT/qjWwDfiSFS7s8Wck3Bnql1dTMRAobal
 VhxKo4kn34ocqtshh+ixmaHGY0x8QJJtKdgbq2mQk9ZfNHgO7WNgUfIKE1967MhOkFxz
 OOXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXmJDeE2OQPl1ioToguxh8/nEx2tsOIa9DYU+9ZFCASaFLWARkvjSurYplt/YKlfVIgpvgp7dfzlTe@nongnu.org
X-Gm-Message-State: AOJu0Yx77vD7b4LEgxXYXtqiCxG/+AQ5LBwiCEBusA4rIEh5gqxMxGWG
 p8550gsdVc0j0vx3fIfR5K51TiLqbFPZKDKDQvKrmEDD+5ITctxttL5CSZkH0qTSQv6P2vicAFV
 DYx+PQ3cbrDcM8tkgszBLI6lc2QNLpz2c76oTuCLXW6kadqTc5cRcXl3Gtw==
X-Gm-Gg: AR+sD10h5OADFOwsKIlz/EXw33eDH5b3aN12h60UnfHOWn5tJgcYK9UtqYVN9T5NZSh
 ZiuyA1bRbK9Qscj0Kp6qdK2zFY4MD1x8aixWFPgUbZP/ThwTJgnGfN5xyIKqTmygNeRxomzN/Be
 uGuMCooX3Lir13uKjVI7rBQ77AIYrhSj4/mLKptXSY+nKxsitGBkeBGfikGvrnrgtcQq2PlsWZx
 ncPdE7LiJHeugca2tZj6vKsmg9L2qW8NbYUAs/Y4Inn8pzsEjxUQshZcy0OugvpXwEVRs4Et/na
 u4ecvwFxJlHEjeFg53BcLo7NbUhQoP4hMwSag06mPxfRosZfR7hMGCWgcqyD9tCm5a1rW18UgHh
 +fzOAabea4FALEbn7mEV3ZRG9GzxJ6mBEpY0=
X-Received: by 2002:a05:622a:588d:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52d18e6b461mr233977591cf.10.1786330762512; 
 Sun, 09 Aug 2026 19:59:22 -0700 (PDT)
X-Received: by 2002:a05:622a:588d:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52d18e6b461mr233977411cf.10.1786330762120; 
 Sun, 09 Aug 2026 19:59:22 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e702dsm299484505e9.3.2026.08.09.19.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:59:21 -0700 (PDT)
Message-ID: <52aa39fe-5b82-4e7d-b86b-1698e617d911@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/56] disas/riscv: Sort riscv-op.c.inc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-57-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809223545.730664-57-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mopI8puUevGG8S4w_sl9sM9C0cUQLlDQ
X-Proofpoint-ORIG-GUID: mopI8puUevGG8S4w_sl9sM9C0cUQLlDQ
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a793e8b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX0uPae3L9hGjW
 RXGShzG8F34CzsigTH0CahpbHi0Dhu2t/DtkU4WfnzZfWIH8DHF/VM3GJHRmlRj3A+vA04I669e
 dba7444SS3/rjQ+airUiXCJGuWbPXx4hcWnq4A3nPZ9qZNSdWfLUBT66OQq3Uevcz5VhsY19gN4
 MLdt2LoWaq6tafOisAj1/zqUScOTK0mFyhSzCBzFRfNBbBl10vAGFXO8mfNjDXSxnhPPF9sJBB1
 qHjqOz1INhBRdC02IjxzhDzSV+zcxRT4ll+4sC2u5izQi1dDoS2dhRHKtJlaaDPT2rD0SmsuTyA
 e9F7fo0/vz/PVW3kY5d/KPSaiXGlTaPJ59BR0PvKqfXT8XQt1z5Cmr8BD0/eddPyiAfdp9aS5it
 J/QXWNbGv/CXwQfIh0Bznzen+Vdq5EbmP3JTYJP86I2vXp9RdhUth+tjeQpXMlWE+HmEbIlxW97
 KfSv7X+DnIkIBBRpvYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX5wPeAGmVHqbK
 Krw0mXoQdJ85eiWJAANB1ljuTx3a8IgH/uGHh39EMGeSE/jzItKZIykhnzGpPIPgmVvdTCzuFbE
 2hlmTMk7Xu9Qac1bCc1jy88GTgG3Ww0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100023
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/8/26 00:35, Richard Henderson wrote:
> To date, opcodes had to be added to the end of the list,
> resulting in quite the disorder.  Sort via 'LANG=C sort'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv-op.c.inc | 1704 +++++++++++++++++++++---------------------
>   1 file changed, 852 insertions(+), 852 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

