Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D68CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmNA-0000hj-QM; Thu, 09 Jul 2026 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmN9-0000hZ-ML
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:52:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmN8-0003Yu-4Z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:52:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669AiJwR1436949
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 10:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4bZPBg1Qdd8iQVzTuzL4i9IydjyDtKXGoZ2e4IXixO0=; b=kLsD7DN4RYXR4YVB
 DsJC/zsnsn6kjDedcBrV7ExEiiBV/jZq4WOOgvAvOnZWfySPusWL25tWgUEu4XBB
 Z1Zni4L85R3m7B/IxI4L0krqXWHulaWKCnTpKxyl9Zif354LGga3WrVbVyupfbFG
 W9sXI3fhzjPuS6xWKF62gA1COXIWCVpTmS7Cgg2gDK0yw/4Wl5sljzk5UBx6VVVV
 SoGmGlv5Q+FDG71CST2QrJIrb8JW4EqQOmrXRTkyT7Pp63Eg8F4C+9qnyY2Y8s48
 ykJHmKzbQKoPA94B2ehd5T7Z94eTXCtlqk3oDz4+3E9VgOpLS8cbzRP9EI75uJZK
 An9N5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3ct5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:52:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d30035dso12661621cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783594367; x=1784199167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4bZPBg1Qdd8iQVzTuzL4i9IydjyDtKXGoZ2e4IXixO0=;
 b=ddIo4QGTg0pPd347H+XxSQT1cP52qOKj8bBq1DpinKNEy6Xi3fJ6nJB82UjjMyKM55
 I+24H9YduBfLq9cjbOKArPzmeU/L2Qqt/BgIP5bJosWHBLJoeXiqlnn6LIhYpsVjE/i2
 2n1SfEgcCfx90p6EVJbPCLm1slUwZtC0eJ6UvieF8h7VwyO1Eo+JIlQIl2iR/PpNwb0F
 E2Ca19/IGk2VdlBJ5CPMWK7SCOMpbvZfTnaIWYpdEsRu/IkDElYZR8NKaEIx2ARZl0vg
 Q3UV0XbkC41Uvb2AzLDJZEe3J//54Gm7HCV16xowBSucjMI14akfn+UxU/YMqWbdNki8
 13Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594367; x=1784199167;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4bZPBg1Qdd8iQVzTuzL4i9IydjyDtKXGoZ2e4IXixO0=;
 b=LX46iHSdWhrcUhiBSYISzgWqFBP9CIy13hp0h+UZ+CB8nqlrwxg9UoFUtzqz0h5yeP
 Gb5AbDmN6hEb+fQ2T4y3w9P1D1xSTT5mF9u+5u/0Imbt8n8oveFBrnv7/R3fBq9sbREw
 YvyJ/OAWeOK/jNzLp5Ooiexjly+nyT/NN2PIbCc/tWZFUdb8RHS1n2kkUyPsmTJVf76I
 eTNNBuW0QOcni8FENxk/No6BKakc604ht4x4LT2qImaKZI3IXeedgSpmUxTaVQcJQ9k2
 nWBp7o7FUgsMLc146UFBsJ5PLx8YhPe518tDnXs2UQy1viLbL3WvKzg+bWI0AkIPPJHy
 tyMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFQB9CUoFU8RjNGdwSGYa4tndJ9SQ6EJGRGn05uN1+X2J1XywNgG7C0xEenyl57zxavrg+mZ98I+Fn@nongnu.org
X-Gm-Message-State: AOJu0Yw4R6G+FIhZXHO2L41kKPX0qJ5qpldu9mmk9lbm4ShER61A0bIp
 nMrCpVqFrg963ulmWQ3Gn+LNxNYISMFb1PGT5BR9hVTAAMPrZwFA0p0FMUgkJ5VWJkbGEdyCkcH
 IWs3fipmqEalkRtSqgK4LnEhu01g8hs1AOPrzKBEqJcDvGHgWmiYgkIhddQ==
X-Gm-Gg: AfdE7cmAyDPq4dHA9klXcQQyYpR6YAoQ5wXeAiEl2xl1izX4qTKxOQYPl1HGuATY1Zz
 B3zjHbGAeF+0NM93bhNw0PEmyQaAk/pZTh0D7rzY9L7iQN+1ACek+7TAfPCHGHGdhiEbOOAmQB3
 nq9In5N71v/PmmtLQ1B4J30ESHle4KrjzQ4mQF9cGxjsfQoQqkQPvXaN4TPG9KD4i5Xh/sZJKS5
 zlJULuARAxJvSkP36/MtlXPNPD9iYhRir3CAgkIWKBfG9yWTkUzBSoJHMKBKOy6xuHx27EFrMTB
 anFh0enPILeRygXLoi9FhVvjxmpb7B1gwDP5qaDr6W8843jOyxDkDu7ssRJJ/tV1w/TZLr/5U2A
 vqbhY1/u1zaSOENPPhCxjenxyANNlMq6S36fNcQ79GbgAZEnkIrcgyb90mD7pKw==
X-Received: by 2002:a05:622a:1647:b0:51c:ebd:fb42 with SMTP id
 d75a77b69052e-51c8b5659abmr66383701cf.59.1783594367332; 
 Thu, 09 Jul 2026 03:52:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1647:b0:51c:ebd:fb42 with SMTP id
 d75a77b69052e-51c8b5659abmr66383431cf.59.1783594366942; 
 Thu, 09 Jul 2026 03:52:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm52262122f8f.21.2026.07.09.03.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 03:52:46 -0700 (PDT)
Message-ID: <36b2f272-d0fe-4366-b515-260a93bc2061@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 69/91] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-70-pierrick.bouvier@oss.qualcomm.com>
 <c9854a25-5b80-4c8d-a86b-ffdf118349d8@oss.qualcomm.com>
 <7148b2c9-8874-4e9a-9217-577ffe8432e6@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7148b2c9-8874-4e9a-9217-577ffe8432e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwMyBTYWx0ZWRfXw3HRPzOAUSLI
 71Ox7DtaFEoBxYLh/tI3dVZCeUWNBithGYoBc3Y8DT2aXcgWWF5ueC3rjz+J2+DEjOAUCUPR1/X
 eWXc17tbQ6VxAIlJHs/cnwc7+T9hy3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwMyBTYWx0ZWRfX9RfWumaGa6/B
 bJAT7veKp1m4F662bXpKtRqc0yhb05eTKnOoZxvydgJVvDtSBoXc2LqIRcWcDnmgnjl+qx1KYSv
 IGv5020ZuQiEs1kUSFgxjw9gLHsTHkKHz0Rvnu93gZsErDJNvGAEoRRIr6hZxnQXYKgDN1vxvSp
 suY2Drg9MOwz/FvbnhGanSSLJ63QR9KVAMl5+5J9BF6SJoWIIkxVtUDYqijJGzkfN/fdIFhbG8W
 PaDZl/DQHkDuI5Z6YtRvWcQh+GbDUU08ge2IK7nouibXa19m8/G3VCjOqTd5UtK304hfogt1sFw
 1nOv0O64k+vmz+5T5Us3OoIPMqeSTdpT1y0wLMg7/jqqdJeebToVLROFL5Kl9nGWKyUwcusEUQr
 f8LUTZOm6rcxDIgfHXw4QB6HSUYeD9AxCZ0OYL06FaYpkVCENbaxInzoryv0a5S8g3r6HiIT07F
 eufxhUsRDVql3N4qYMA==
X-Proofpoint-GUID: VmejygGQ0nqIu4yN7WpuucLBZ37TwiCI
X-Proofpoint-ORIG-GUID: VmejygGQ0nqIu4yN7WpuucLBZ37TwiCI
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f7d80 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=lwf6GcVn5n0xlIBaInYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090103
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

On 7/7/26 18:25, Pierrick Bouvier wrote:
> On 7/6/2026 11:16 PM, Philippe Mathieu-Daudé wrote:
>> On 7/7/26 00:33, Pierrick Bouvier wrote:
>>> Replace definition of vector attribute, remove unlikely, and detect
>>> endianness from __BYTE_ORDER__.
>>
>> Why remove the dependency on qemu/compiler.h?
>>
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/ppc64/vector.c      | 11 ++++++-----
>>>    tests/tcg/ppc64/vsx_f2i_nan.c |  7 ++++---
>>>    2 files changed, 10 insertions(+), 8 deletions(-)
>>
> 
> It's the only tests that use this, so for consistency, I think it's
> better to not make special rules all the time. Also, not having this
> include path by defaults prevents anyone from having the "good" idea to
> reuse any other header from qemu in the future.
> 
> What do you think?

Yes you are right. Please just use this comment as description, with that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


