Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D16606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=amxfFRtb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kESvwnaf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnjw-00069y-Uz; Tue, 24 Nov 2026 05:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnjv-00069M-F0
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:27:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVnjs-00037D-Uq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:27:07 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8VjQM3225375
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W4lJsga6vCGwyI6bUn+di0uDbtJu/pFvl171hwE5iFk=; b=amxfFRtbaikuZ5Rc
 nMLGGV/xQ9/vMvvP1385u67L5yfjY2iFrKHF4EoAHqZxmz1x5eGmReCrjksvnoEJ
 1+lU1GSM1/h9s3LjdxlTL+WnOpYTPDyjTkmJNb21r3Df60Qnev1ir4DF/lEEN0nU
 3RNpc+VgX5o6bTZjgK55GRhwL8jePvaPi9eD7wWt2/nCIHsWvsEUxl6QkFCQghMG
 3Jv5Qj2mdaqqzWxoPCoknfu2kujfG+9aeswQhiX4JRFi3ABD937WES4ZS/sBVorp
 h7W0FTbB7j4VfU1czIuQtX6PsoQ4CRyq4+uwtevD/PMafxRVEBG/Ep3Mkw1vKTfS
 w+EtbQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f2hvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:27:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so684860885a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795516022; x=1796120822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W4lJsga6vCGwyI6bUn+di0uDbtJu/pFvl171hwE5iFk=;
 b=kESvwnafbuxDg1BOuzqvpweQEcjPv78QPFGmTuXLdkwSK/eD5UZJ3vNSMqCKtkyfnL
 CJIOdHJOM/24JSXiRQQ/Fw8RgZ8C5OkLUmpcucIFyIjHLE9lIUGD7x7ItrNcphIEyUiu
 /AIFR+4sG/k0upw686/vLvp91mR8xQiRInNSs+GkEJUQQLU0DYNRFG07n3PyMM/NL9CI
 VKAvldZdvol3lNjpR74DQbFJuyg7FPXMKhgJeNJkIuIcZGL26HRXXlJ41GnrTsTYtobU
 sbuprmEk5NuazgcrfQv7g8Yg58PjI3hhjxqCYQQT4Br5Xo9IL3YNWzHf6H4nzBWwnLmG
 cN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795516022; x=1796120822;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W4lJsga6vCGwyI6bUn+di0uDbtJu/pFvl171hwE5iFk=;
 b=gx7tNhvnxirNq8b+qYHA7ZEZbV4Uziw+Dt18y4X4xUxsVpHvHxS9n7sjTuBjvbIvz4
 +qV0tVUexqVJ+MyyDl1bZp0YulzfJHvnZmLizH3vmz4J3AlXsDxmmtK7WuOwpI3XN0PD
 p27crDS0TLqtsWHlZwO7XWGuSLp5cw0uBU2rhAcrUuBPtskxvUELcll7M9EBOF+XA+qi
 TQ6pa9VwZFKOLaCN8Jf6WoHfiZkLiCT7tB/1vUx+Nr0HqxUSeS1ooJe62sFLAQpo5b72
 w7yaFhmYpkA+pSGer7m8OcEQsJzZ3LTeOZ69Y9xg/bgMSd9dwixslbEN9LDsK74MITi+
 8DtA==
X-Forwarded-Encrypted: i=1;
 AL+hErHTo2TnCK/6JYuRaN1Odqt32J6vNWTIGPZ8iO/3E+Raq0NxGlcenbQCnQ5usqPQ7+5RtPI+mwSNydsv@nongnu.org
X-Gm-Message-State: APuU4Z8wjQgHSmhKkDFPZYDVnqnv6bLkXSvKUfLK+bYdQooL/LDS4fzq
 0WLTSALQ4gxl1ozK4uqEGsjnz7BeJjRCA9VffM8qg0lsM6W+O4/BP3XuAlGX03w5USGrZ22iWbD
 Jewubw8Jyj2GtKW3vmZ5eazE3eVeF9pv9503O8jdfP0xzzjT/OzR+96nnTQ==
X-Gm-Gg: AZFdTZedG5q2PiUAByrQwGr6Tmu8s1eDPbVloTry+Dhq6U72j17HD/g2wFjLsDN2XAU
 tbhi7RT+CIrrfZ9PIfVjt6xuBXCpfQdbMciDKIzGX6iV6YJQh1rFvaaaUlq+D5KLT7MbFLk3rIq
 kxYKeBk0X2r/bD7FQir6H9LmH74DJ6q5uwNL/s/A0i3VaJXKJ08OQ0DURSNNuXV5Rky/CDT+Z1b
 8ra38nEtJt4zWHu1jRgeCL/X6bNmjLrIEwophooONaMzxbPH+KIixyowA2qmp0bFy+xKcMMgOc5
 XNWcyfdicT7eofrIDwFfUFVNrtzCD3KumINzsROxnWYAh0G0jNckJpvWCDr/2oaeSX8UrATesyo
 VRsU9aMKyYwaoVHzvZ6NOZypUqDcfNNUVFnINxBCUP+IobTbkaD8RAveppnjlQTf819+TbkLfN5
 uW0mN0GPM=
X-Received: by 2002:a05:620a:4386:b0:949:ba11:9612 with SMTP id
 af79cd13be357-949bab0cc38mr2158332285a.69.1795516021806; 
 Tue, 24 Nov 2026 02:27:01 -0800 (PST)
X-Received: by 2002:a05:620a:4386:b0:949:ba11:9612 with SMTP id
 af79cd13be357-949bab0cc38mr2158329485a.69.1795516021345; 
 Tue, 24 Nov 2026 02:27:01 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm243966425e9.1.2026.11.24.02.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:27:00 -0800 (PST)
Message-ID: <f47de7f2-3499-42fa-8b6c-0a3a813deec2@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:26:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 3/4] hw/display/vmware_vga: Reject attempts to
 set resolution outside VRAM size
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261124095719.4126146-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX6oL8eWo3Ebe+
 RuDtNfiG+lIT+2onVrEl14Jfb1a8ame9hMHALptagfirgAiRNzESiIKSOcIsTT/hxJMODutxSRm
 2jKiwDOzdPwg+pdtfkncSQcP61E8/z0=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b056676 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=7RBIUIFb-yIJpm9zkEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ffCnd4dILIP6_54P05yQWqtcSgOHizcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX2eihdrURF6m+
 y5FMIb9yZx45/ITWZvKmllJBpzP8+t+pWll/Wq+y1gsVNX4b2LGCyLzPf46NS6TVOilsc8T20Iw
 8vIeK9rbkEoKmIN6EGSNnkg1iv/6r1wTUcBj9Te1qJnwB9pxtQC8PuADLwhln4Uno3JbTk9tsec
 P3uovvzTbIhN4VRLw4/ZZUk1HkSPC3av38hv+SLlU2F0CJzoHzdpNOul/M8X+7aySiXhF2LEqEh
 mwGmTx36cc6AiyjFH7WVVxT/G7JyLYnJF4hPRYea+b/izX6FcM057CLvAkmj5A38J7A8vxDB52m
 oC8+JCUbgQBOk5y16mhg2wAAL9LZPXB7Hw8rHhEQ3qjz2Xh2zlws3zh9f7uwEOrKHirrYvpNreu
 DyXLB+60sa50vpZU7dS1Gfo6Eb4UOBQ9qyHNosTbuqV44Hryu3WghGX0ssXsu+AF+0BELLqF5IQ
 zhmRHm7s4CjQnJN9HQQ==
X-Proofpoint-ORIG-GUID: ffCnd4dILIP6_54P05yQWqtcSgOHizcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240040
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 10:57, Peter Maydell wrote:
> The vmware_vga device limits the maximum width and height of the
> screen, but the maximum total resolution those limits allow (2368 x
> 1770) can be too large for the configured VRAM size, if the user has
> set that to something smaller than the 16MB default.  We don't check
> that, so we will set up a display surface bigger than the backing
> VRAM and QEMU will crash when we try to draw it.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4898
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/vmware_vga.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index 49b8f94b6cc..263a08c9000 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -1136,6 +1136,11 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
>           pixman_format_code_t format =
>               qemu_default_pixman_format(s->new_depth, true);
>           trace_vmware_setmode(s->new_width, s->new_height, s->new_depth);
> +
> +        /* Ignore attempts to set a resolution too large for the VRAM */
> +        if ((uint64_t)s->new_height * stride > s->vga.vram_size) {
> +            return;
> +        }

Matter of style, personally I prefer avoiding having to use cast to
force integer promotion, using division instead:

   uint32_t stride = s->new_depth * s->new_width / 8;

   if (s->new_height < 0 ||
      (s->new_height > 0 && stride > s->vga.vram_size / s->new_height)) {
      return;
   }

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>           surface = qemu_create_displaysurface_from(s->new_width, s->new_height,
>                                                     format, stride,
>                                                     s->vga.vram_ptr);


