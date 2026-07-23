Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A5C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmygZ-0002PS-GT; Thu, 23 Jul 2026 15:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmygU-0002PB-Mr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:02:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmygS-0001Tl-Sk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:02:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIm2co974588
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 19:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ImKBjTnWIu7q6J3THpVvGKyuDAO3LAhuMh33KLUh5s4=; b=ioCpo1nhtBNDn7lX
 y8/0NAL7RvrDWSIt8537ju/Iohjv+uGq2sb47H0KoPwZT/rod5CHTaiiBGpYo2Sq
 7LxPWMYf+jZl9JoXznT7ccQl7sFzho7/yTYnaPRE9GGqZHEIOcS6GO/ibZ4Kn1mJ
 FImnLUxBSXg+vyw/6gjwVc9sR7r5hdo1lRRaeYpWBfm9Wa2qoFnB9PWQwAAb9YAg
 bbUY9raP/DDSE/f6Gr/rZMGUG+2v8Im0YLlSj4CohrNKCl9qmg0Q1tr4AVO1NIEf
 RtmUL9M8MmIqs/e/KrIXNVYVYtUxvgI3hIc2U5urAIM2J8WUZ54vB7Igx6/mMLCJ
 MUBZ8g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa08d0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 19:02:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85798977dcso1760880a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784833333; x=1785438133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ImKBjTnWIu7q6J3THpVvGKyuDAO3LAhuMh33KLUh5s4=;
 b=MARnE4axYEaJ9aWGe0+VHDapAUMNj7aum89swT/rBXbrb5TuVEjSsGcrxwnChhobwK
 6l3phfLdPECvG8s401E0umktrSpQTxcWqALsCeiP5YKfET/+BIDYTtUq26MivSddRj74
 OaGh6mnX+mF8HsSAEtEhApCQRmZUPAER1DT/td+IwGP2jaZ3v4CYuXGCI77Gw6btxmte
 3ylGhQLr12fmy9aW31z39QFzh/ASwWdJQaLiqkGblYFGSSjK7Qpe2mlpl30yTg0YUt2Z
 BP1mOl26zfY+CGKaCbjoDSZSOW8ivSbuc1BIfeCsXayJ0Jd+s9hVKlmy83jtzOq47Wrl
 WSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833333; x=1785438133;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ImKBjTnWIu7q6J3THpVvGKyuDAO3LAhuMh33KLUh5s4=;
 b=VvRSQnz4DjCJjbPwHS33YYux4BBVUz3kIUen7nkAbc0mWy5dkvHei2hrAKT69B+gnx
 D7FYvmIYRmy+RSgBIVO/zmKAlo35RdVNs4aUZJoNMJ6ZY8j/pQ58pajnmZBvtvU/RGVV
 VQQC/VuS1TpmmRJ9VVckj1icREvzjB5UA/lwUMpoJTt9s8NpmZ7FY+GalDWJjWrixq8e
 LtNKHEDPeuXlEp5gfm+wl6Po39IDLRRJLVHCgYRhPMUt+ZzXX62uBzcxJCV2bmHVV4Nj
 +Sw3XS9M7A0+XimOe/HoD/IKYIPIeoD2A02WhRSV0H2pXNDqh3AeK3vDzveRqPWVt8YY
 TpWA==
X-Gm-Message-State: AOJu0Yx4s5za+fC4vZ6RLYSqTOQjGgUerx1OFqn3yYZv+M73gBn8Mf5o
 +ckZr8XbE0OnlkMSQXAfyh85IQQkedq0A2tSrTYGrBDmCUeQrN4JrRz1DW0i6nbcOtFEOUzlynx
 bBMO2/pYCpthUyaDwA2zkhY0iuIF65b+zCs3RottefeZiraJdSq59LJy3Rg==
X-Gm-Gg: AR+sD11Xa21XkCcu85YHYUC1oI53TwPUD7piGeu+xBco9J1jQgCaMVqWFDepXX/sI4/
 yWsvo46OdzjK8YDOBH3FwKtZedUCj7gysMzDkf5xPomAzNDFusR72ows8UKF5AM+c0gdlr+9w+n
 BRolqY9gFQbtY/WKxI7y1029Hb/bDtQyhWgxNdfHeogoaDcYgvwMHX55kQro1vTkT2tY3IiQ4eO
 x/15M3drTMRNegB4YhMZI9wwjNoGZU9GHLlYZb8Hfybvr7dAcwv9gBQxFzbhPR8PPxb7/ma6mGW
 xCxT41fOGeJdvnZu6J5mG65+lg7c50axt7Cc+l6g/6DJ3kBMRm/uoLTjndd4qPUxxXJfx1kCZTR
 YIJu0UQTdqOvLxhWary3I74hFasDKxO1bCdXgektjDE6lRCAPhGW9zpMeEEa8Q3PfYaR+
X-Received: by 2002:a05:6a20:7344:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3c44afaabf8mr4786622637.7.1784833333066; 
 Thu, 23 Jul 2026 12:02:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:7344:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3c44afaabf8mr4786571637.7.1784833332538; 
 Thu, 23 Jul 2026 12:02:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147d47960dsm20956194eec.0.2026.07.23.12.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 12:02:11 -0700 (PDT)
Message-ID: <c98a5417-a850-4d21-82c2-6a2f230512c4@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <839C9D34-F349-48A9-A56B-0FB305B2492E@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <839C9D34-F349-48A9-A56B-0FB305B2492E@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wLgCIExZwUh1i4jvsIfrlyqiaviIzfH_
X-Proofpoint-GUID: wLgCIExZwUh1i4jvsIfrlyqiaviIzfH_
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a626535 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=-dybzMG3OQcZ69-SO-cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NSBTYWx0ZWRfX0348Mf2DaGn7
 4wAu/YEEkevunkvYuJfVBsedNGl2DIjfph4ED5Xp7ilfzSLJ6WZ7i4KxnIjnqAByKEGV5FVlr0f
 DS86tA+HwYe0U7YWPI8OAIRyG2oQJb4I4wW2iuTnI1ieOnDo0OKACie8yojMk0ThzNlUygL/Ia6
 tyM0Tya6Z4Na7eWI1CBOX71C3LYCwg2XYNhbpI/T/MBUHtC/Rd/GEMigeH8oGz04yooANn9B+eo
 IvdaORj9MFPZz0VvP/5eRf/nIu4hSWlT/kH+TSxv56X9cr0fj+M4wZTpEXjQfSGPQLCVWFc+OvM
 3pmLJpzaYvJt/lzDz7WVK7ZZTG6OaJcxjrduL1A2LUXnlbKorSF/giDGLBLNhIqX8oKWel20rbU
 4SqF53M+xhvwHx5lEj3jc3Zule1s9AvedXEsx84htbyP0Q2aYgNCuMzXPFPEf1fA8EVL4uxgbvB
 OvtkeWf4TPRmMQ86riQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NSBTYWx0ZWRfX1lpDcUeQGnKa
 c54h6Wq7KxEeBuwaWBPDvL6SdAtD16ColJ12ATVHb3rp4GFAwCdgu9ns7jsBO6W+xxxgm2RtdjF
 l6tUdbwzAxFUskoT01eM57SCdDZKIT4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230185
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

On 7/23/2026 11:45 AM, Mohamed Mediouni wrote:
> 
> 
>> On 10. Jul 2026, at 23:43, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> Those options were useful a few years ago, before containers were
>> available as an alternative for missing cross compilers. Simplify the
>> workflow by removing those options and maintaining only the container
>> based approach.
>>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> configure | 473 ------------------------------------------------------
>> 1 file changed, 473 deletions(-)
>>
> Hi,
> 
> It’s nowhere near an upstream state, but we might want to consider some
> architectures where Linux is not supported.
> 
> An extreme example (which not remotely anywhere near going in tree yet):
> there’s a working IA-64 system emulation tree around (on top of QEMU 11.0)
> that can boot Windows and Linux guests. Linux and glibc do not have upstream
> support anymore for that architecture.
>

So you can probably build the "latest" version available, even if it
means going back to debian last last last stable.
In this case, we go back to "it works on my machine", and would be nice
to make it work for anyone by doing the small effort to write a docker
container for that.

> aarch64_be might also be going that route in the not-too-far-away future...
> 
> And there’s also macOS hosts and others, so while containers as a default
> are very nice, there should still be an option to opt-out I think.
>

They are not mandatory, and I implemented the existing --disable-containers.


