Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A89C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJmW-0000wN-Ar; Fri, 10 Jul 2026 18:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJmT-0000w7-MF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:33:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJmS-00020C-4D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:33:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Gi01621358
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5WoEhrTq+9lMFSAg+6m8TBQ/rte7SNtwjbfgMEKcRdI=; b=LBop9AfOZZnusPpA
 p5QSIGUg/u/1bpYWhQ+l8TgbgOFTJov5waPjJyeCiFxK3yeZkgfVyI03/dJ8jf46
 uqj7cTWpawz2L5EOwSPbKLz3RMtM8Sc4D+/nEBsHt9cUhBDx5vuI5T4nm76irVXl
 FddYAXNhRTiXot/cK0V21kEsWZL2hJH9FSlMBzy6eDmnNR/lazT5qhac5KbCbBgO
 N0ke9ZSZQhPx5v89Xnr/hZWYggZvlD+E9zNE0dr3ziBTIQraipbWlHMs/+rZJEcO
 Bbb/s+6S0GHFYBfTZaDCMG/z2L9igrF6mPbBm4jEM7SvDHmvEJoas/rWJNZuJfiI
 1/ojBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8ywf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:33:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso22055701cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722789; x=1784327589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WoEhrTq+9lMFSAg+6m8TBQ/rte7SNtwjbfgMEKcRdI=;
 b=Fq9p4rVe5Zt4NGbqeXQHW2qtFZTfhZPUx88szv4DGv0QKc3Auv2NKCgV3pGWPeEBok
 q7hvVc9Ev9MLERRGzglV7rttoD8NLnfMFu0kvmruBj9sc440CbG6B2vs9GkH9rbO6sjM
 GrOgekCo9WRuJEV80FeSH9gJsqfIjwOD8OarSoRoc8mTMrkCCrRoXTZnz2QJ/107kD9s
 hklFlhWgMzXQJ323/1Ev5nCwz/rfm6hk1c0LscNhpekQ149CMXM4IYbGgu/PB2+M9f4y
 zf/6kc5m6iAIea8QOgvZeb8E44clbX55J1KDihYUwXUi7VoJfRpfN9/xNdhZVAf8unJU
 3b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722789; x=1784327589;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5WoEhrTq+9lMFSAg+6m8TBQ/rte7SNtwjbfgMEKcRdI=;
 b=M63s4w7/FF2FUlaoCy54cgxcqEZOJAb3pXIEQlLx+IBwRF6KOwxZse3t4QMn4xh7ar
 Teu08QeAvl0o2oAGgYVHvEKW2um+SdWnQOTET5hWbuFuBVVfjRqZ36J8pcnhGKz1254r
 wG3vE7rfGwgaXKPFaf/8tFK3M5+Xfl2Gr46wB5yss4oo5e+NL/6GmlNTN7iqLfGYiIgU
 /BA4heMPOqz61u9z/femsp9ohKsSR3JFneDdZaEUndulaZOzABGIpsaqsyjjg6i0Vwlb
 J/iGyx2hy0GWN1A1SQL8W61DE1q1RHvRtJu9KyN5jsDE8e454zpVTptBTYKckPNQ15cb
 jJkw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8MCknzSXYQkd/YQJVodn8PWFbDVQVMBm6KZPrq7AdwD3Txh/bDZBSuroxxaFButcl2sPjYSv9yS5U@nongnu.org
X-Gm-Message-State: AOJu0YyKS2pPVc40FuT/RVALeD+65ihFLam4LZ4irTt5uXATRwdbQxoa
 mWIwNrp54ZnXPAXL3YWqG1+kohZ/e2Y6tvKR+qAFoJJrkL3pLPX/wtgrwuZCrBl9RhtZiNtGqPw
 RrwPwhd5YqrzXcrNOl7x96lHyEE/ltAkchWfVwV1AsNpSV+CE7U8j+RuxdA==
X-Gm-Gg: AfdE7cmmIZ2RhEaBDz944oYbqdvhYLJvhDFm9ifIIOu0IV13+KJL2At3JuaAEBlTGw1
 H5rs7wbsuXdFzi+1fF7egXCma0hoi5yx7KubPlYHP8/CC3t4NA3wYC8nu3+hA+8ynrm1KE8qNQq
 N/Ew1o138pkRVWYM5d7GFnrvie45LoiBfEzw/MK0CM1mLaAj1NwDRXQsFjD+R+tDGp229ifldZL
 M4tkPPz8x6c7neiJmh7cGQQcSdJn/xJGcNB+OGjnwFFrGiYIGwlWTHKPY/Y08keMTqJGdOsKTQS
 eT32QBH+nPinnQNeQ+BrvtmJEEw+IbsibwB0PQrvyJiEU6l/5JTrOe55U2cXPkGH5gm7ndUcBvi
 sWSawVDvnDUhPBopkrBWkKjlAC1yWIkWGLLedA8QI4uG6MA7gLIQam7iNa8y32Q==
X-Received: by 2002:a05:622a:1825:b0:517:64b2:2388 with SMTP id
 d75a77b69052e-51caa08a913mr61820091cf.15.1783722789344; 
 Fri, 10 Jul 2026 15:33:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1825:b0:517:64b2:2388 with SMTP id
 d75a77b69052e-51caa08a913mr61819851cf.15.1783722788877; 
 Fri, 10 Jul 2026 15:33:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm110304275e9.10.2026.07.10.15.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:33:08 -0700 (PDT)
Message-ID: <c4e0874d-5f89-4e47-8bdb-95d9811d763c@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 78/98] tests/tcg/riscv64: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-79-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-79-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SNZ1SxMYJo99ohsjtfHJ4JHDaQrwSNo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX6ZCHlyUTAZGb
 qOuknPjoE61Ab38funHYwuLdEimGujp9OQbjcY80m6M1b8gs4kNanbNsYEwi2GfbEDXmHa7NBiF
 hi7QY7qiRKgrh0kumGqxLogVf1et85U5Nkt323Qv+gMsvEGmV/qjij4fGqKYvkz2GRltF8jTVqL
 2Tggg8lZZuMmjEgGayPhq1Aoa2t9M10Ld5YSu4zIqaepGE22wWpECf+9SVRJASNli3RtkeKllUl
 Z/IhNLglmgSRJgLkO8b/Mql0IF6Ux/1qrkki4+30y7OUR4uT+Dc7OcdbUCj6d9TxRiA8Oja022l
 EpKi6L095FAz+bmtkGIqX1W2Oalaj3SoQrr6pZIgJW6EHumAqpEHzY5HsTh+v0lL2q7BMeiUbsr
 XrHKQpIaYekQm7yFCUn/z56NhzSVHAblfc6+TNR8DLeOwhrMeZBZsN4vg/iF245ZEA/glsg9hme
 ghnhiUXfrmNzeTa5IXA==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a517326 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: SNZ1SxMYJo99ohsjtfHJ4JHDaQrwSNo_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX3PENGQDU8cfs
 iSqksXuZx44P7VRmLGDW008K6o+8qizKG1CuOdi7j2hXYTOz+MK0Zko7YUzcfcVrNBu4472sX5V
 sUOuAUKIqDrb3+OEsZbPZft6yV9ZOuI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100226
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build             |  1 +
>   tests/tcg/riscv64/Makefile.target | 20 -----------------
>   tests/tcg/riscv64/meson.build     | 36 +++++++++++++++++++++++++++++++
>   3 files changed, 37 insertions(+), 20 deletions(-)
>   delete mode 100644 tests/tcg/riscv64/Makefile.target
>   create mode 100644 tests/tcg/riscv64/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

