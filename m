Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF497CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT24Q-0005Vn-QR; Fri, 29 May 2026 14:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT24O-0005Sw-7j
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:36:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT24M-00013g-EI
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:36:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2GDs518364
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=; b=fz/XNF6/GfXjQFNX
 0UfcuCtloIVagGtD2+GvOtQGw8+Qf7lrJtaNYE5Ixumx2tn12ObRsAyZEVbu0S2N
 F/9QInpSsmfg/5zHR04qy+juDSw/qCvhDvgkZnKTXXkvqduFaUOBn8u3wPeLiSPo
 uthc5JZEmuTo+Ab1x0L2ZTnPWeOdqgeyd6tKbwF/dqfP7rctsFD5/YKEG1XChL6d
 pfVErFptt7TYD9Jbt2yc6xxxWFcX8Lm8JZf0rjl9F6cctSM3MHXFQlIMGtGQyT8p
 ltL+Ow1mQxjGnJtsQxQFWyZ55W7s2U6UY9HQ6H9Mor5LKNJzUx/XrYkcQvSQNDXF
 QiNkkA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechgumn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:36:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1353a6f29deso4810021c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079789; x=1780684589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=;
 b=P+0hsr6jAXz4I4dd/OxFM+tjUpbdwuwysKg/KWI0Li4Xh9o55FEKgFc4HH5hNFDjGp
 7kg5voGWpbqZIaZiENIMuoOkxx02FnrBUmRknO8FZF4pMYnlPE798u3jiY2OxZq1ZkOH
 KrlHy1ntLnASD4NXhMVpWyeAhRky3pvo/J0X6CoE/74MW9VJ9PSE7n69AV4RhL86zGzG
 POV/cV9HuP4ods0fqsY8zngJv3qf71UfaVZ/arzd0uoLKNJLdUIsBW/QKASgklTWFBbD
 1BJ/GlYaq6JHof7iSxoo/WBx+/7poFwmnReT2MtLPttjJNbInmnQSiDkkywaZeAQUGXE
 ThHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079789; x=1780684589;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwetY48q6jZKjFlfIkES0/E/aJ1gDs1xBquYmzI+n/I=;
 b=I7JoGsGnTAm2feS3f86zmXYrTiU9YHlQFcoEM8IfSYjLKVeWDFTkrJ+xPYUAZKIx6g
 XJCUxuptJtBNqboQgACSz8xUmm/+A+UVdPOyk1SPjwx3KSy/14yoYs96WK3FN9TNfWwz
 gJuqhKhIzo7dLRLNpDlEiT4jlng1BNBa+m0ok9jNWm6geUYHNsfbh/cMS28x4d283vTO
 XJ75cGa0TGRgeF5aV3DcIqH5EgNkdvWGq2F5FMMocsPn50l6JBHxLZ/kDIxyuuXx0CRN
 Z3BhXubGxTjePLk9uYVaZ1w/8w9F6wp5NqHzfouFT6K3sblHrcJU7S6DbR+WxYZx3KS/
 f9pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XPg2Iz2DsghZt0Slcv2ztTOzAKBr7zDKHA8RcIEKBsZYbwblv4RlqfmiA5WVF3Dsq5t9EZ1xGeThc@nongnu.org
X-Gm-Message-State: AOJu0YwfsbcpZUaRxqg+ZAkQ0fTfdVczisfwD3wB3raeMnhCAL8Ou+KO
 oX+sL705PnPdSYqmB74IgFNOwAVmp+N6OsdXmWfQdQod6WkO7zt5fn3BozP9gPbaW9H5Rh2iVT/
 CbWwi+ECrll8nFxnLx1hCYUvxUEIiFe7qrhitwwHHplux5XEtQsf52BpFiw==
X-Gm-Gg: Acq92OGLW0A+enUyMF4QLWxme+VDlhQ1N01Z8CP+p4H02xwqmYkF+KSc2lLU8GpFdNo
 OZ1jq3ndc5cDbGQMfb43IzX9BYX3lJZawhUnrosYo3ffuKLpKb5WHoRaGCOujAAMXyYCW5FcIGn
 amJ4aaFfblpG4L20mxZbA54iPDPeGXBXXYe1zoXHnJJVLxCYXcrhWAhWKUKfUkgRCA+6Wlt14UM
 1Z1o5KymMVMXHlJqOBSIIclX7y8gYqs/0papIT+0cZrv+oKhZPofkZ7T77Mr7+bHhXKFBauo8QM
 kxIt0p3QXQELFcGrqJJj6quYE1lkkjDglwxrKg19jjZ/Dt4pzCiS4WXFhwlES/1sUqvQon9lgFw
 clHMdd/L5a587AKGTamf09Lg1JXGob4+4NvP5nj+q03vJ5zl76qOzqBlvAPn/VHu8HJYrmxDhJU
 3Zy9w9tQ/CN1S2N+kG5llPDH2S
X-Received: by 2002:a05:7022:503:b0:136:4a60:43ce with SMTP id
 a92af1059eb24-137d3e11dccmr448189c88.11.1780079788543; 
 Fri, 29 May 2026 11:36:28 -0700 (PDT)
X-Received: by 2002:a05:7022:503:b0:136:4a60:43ce with SMTP id
 a92af1059eb24-137d3e11dccmr448155c88.11.1780079788022; 
 Fri, 29 May 2026 11:36:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36af6edsm1682252c88.5.2026.05.29.11.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:36:27 -0700 (PDT)
Message-ID: <7f3da38a-96d0-496c-8c8e-e8a51624fdaf@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] accel/nvmm: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V0QVkfSEljUklH6RjaH-dNm-XG12okui
X-Proofpoint-GUID: V0QVkfSEljUklH6RjaH-dNm-XG12okui
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a19dcad cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Kyjw8ylCigwU-0_J9SUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX4H8nlqJt2v1s
 uKSId/E+3zOfmF+WQHPlW0d9oWEWyxieI8R3sqNTQtX792P3+mD3OzBKC7s3lgrmPgafnYJsSlL
 zYjdaLT+D5KUXHGv6bP746X8DIucFHjqrF9HfIVW3mQDxBIDm01k5Z9HJAf8KbF+xeh3kKKkiK2
 C8HIE2xDWL7r5W0Pz1e5D0uASNVmZT8GfFtFrYP6UYEw9J2C1u9SPC4m5Bgpo4u4Mji3g0PfmSI
 zrGyhHMmJpdbHtd2gXRP5Uwz5sX2PHikN661+qA2p5bFwRlNrNkFj56akEelLiILx+ggBXa0SVB
 9A294iTsH60NtvcDRibYiSAeUH7gylJjPlOhoFIbE/JNN8MXQuFQgBINLxn+3G4w3Xmvc6Fw3W3
 CnpZ5ZOlRtpuF4ktujbJginAXqhndK9GyC/Ox0q55ilgZnT69ZkvrBktfyQY6xwvn27YglytUK3
 AmxU+4ikV717Co7HFag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register the new AccelOpsClass::cpu_instance_init hook.
> 
> ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/nvmm/nvmm-accel-ops.h |  2 ++
>  target/i386/nvmm/nvmm-accel-ops.c |  2 ++
>  target/i386/nvmm/nvmm-all.c       | 19 +------------------
>  3 files changed, 5 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

