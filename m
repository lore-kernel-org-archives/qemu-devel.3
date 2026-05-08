Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BFFCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 23:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLUBC-0001Nj-PJ; Fri, 08 May 2026 19:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLUB9-0001MM-7u
 for qemu-devel@nongnu.org; Fri, 08 May 2026 19:00:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLUB4-00089n-La
 for qemu-devel@nongnu.org; Fri, 08 May 2026 19:00:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648HdnOO874045
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 23:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X4JMdP8HzmOcBE0paCzpkHX2xR9ktasv+gsuIs9D/Q8=; b=S9kdmsYWHz/YeEnK
 ho1EIfQCU4/W8kc7buP6Qnq8RDdWxEEfan/BpWClrqQHcG8+HuirMWMxOHUg3+sy
 eXIJJtsv5scHVt8sZBE6eu8+Db22/0e2dHe+RXgOV7dlwTzPNukLsEK7M67UCePN
 WQNbCf4i7GJUyhCvayPda274Md3J12Pog/L5/j2+KULwB4OCxN6Iz18zSasH+elE
 ppODfCiectgdv0/pH6z1MlDWzlKI2+shOqHk9VPmAy8/zr+hXDKXB9mhJUV+RZJ0
 4sOzJVE57iIoktjuRAu7vBC6HMXGGzcxfsqXzidjlIM2j2IE4S9wTw5l4OeM0kxj
 e3BC1w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me80v97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 23:00:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso3402811eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778281212; x=1778886012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4JMdP8HzmOcBE0paCzpkHX2xR9ktasv+gsuIs9D/Q8=;
 b=ktTETMekJzUaMF2HU2MVJAsFAvgpTtdaPIwnr5mpTgHZzH10Ku0+1yto/5X9+0PbJi
 2ooOl8ENWME9pojQcniGXMzZR5X1tsx/g5HNUQZzX72SBh+MKWPIC8d30xaUUh/PMBft
 yzjJGMHYI4pG6YmFih5jr4M9FUX3ukb8Xqt307RxC7Ftj2n9+r0iOHItqFC8CFGk+B8p
 1P7lZqAn4Zm/0QJFH4ucs9+3L9xLwo7eS2o0ydv9LtMQEKI5ANPgGSvNAHyY6rthBbx2
 ai6sUjFt7N4RviCHbq5fbRDIKT+7ks+BfyM0ulvSqUvAt3sSwiP3/tJ7ETn54j37ISoL
 sxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778281212; x=1778886012;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4JMdP8HzmOcBE0paCzpkHX2xR9ktasv+gsuIs9D/Q8=;
 b=ZtIb83Wg13Ls8vVkH/Sbxk2uVZ6r0Sc+0YRiYm73PqjcA8soTwp+626UIvR28SoxiH
 OCnsQgCzzZmhkV4pI9kqk07unxAfg7l4RG381ZSpWpAnPIxsIK3m5PqJtTfF0zZX1htN
 mrfvBOp5nKc7T3bGbVtgDu/gLUITX4sW0mqC9F8Y5RvdasbdAvj/XrPKYGvFJPy85MAQ
 pDaWm0maIghWCBHp6r3wb4piY0bNQNTVzmjGcvU6sxhUwoAzdFn9cJd6nNnxF2gawk9o
 VBlGLT6PtNfV0GGQU8rGMJDX8HZ4HX/Vtkuurpv/teRrEavNQnQSTgofDCT23ZOjrHpR
 kUkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MyF9jezwrkAxX4DzBqTWBaAqmqcI/Aio3fwdkvcUpIy1fdj4hDtuAmwRR7rZF4qXSBtA1pdfMhMHP@nongnu.org
X-Gm-Message-State: AOJu0Yz4qJ+0t8hhNOmNIbhTJbpx1IQVsVMx6asE3Tq/sDqK87FMK7iu
 iwze7305xXDVu+mcguf6GGbeyX880AD4qQXYE+NAgqMdnh3lp8fnSQtPZzmGGiBoYzvjyKxOmXS
 86eVKU1TDldEu1pZfAilzAnIVTSYuHGLp7aTopY7knqL2h9ISmUKjsar5gg==
X-Gm-Gg: Acq92OEaO9f/5ScXEiQhvKNIrl1eDPxVDuS4thkgCTBEDvyw1gTpowt51SJuFzfKEus
 bsdnDZMGDDRdTVwbqhTHLamrlckdb8P0t/Df/MsbQtsOoupg+PBfjV5BcfwkeZzHnPW95DWwLU1
 nikh4C21fEUgeInB3mrrlhlPoHWXcjvciOuIXRzk6muNTzVqv6JcUarOOUDcqWTYpjkpO7AtFO5
 dqQpJY3cLMrwDCl1cLHS3w1+QauVZsnrmQEpXwkiUQZu3JIdFhd4exIc8p+MyyvmqIMuuMAvnf6
 2n78L7NMrasBNMZKXM8SgBRzRgkCNLRX55FzLdZbR0n8Cjf5ayodJEyiwgw/73qL/R7tMgx804S
 2YsEkhmBNw2KDibZa2G7cJJIFT2lrVlB5Ss/25PuYM/X4tD712nGbgCVrDxvg3quOHWufmJ1Uo0
 DFgmMwps7CjpCXMw==
X-Received: by 2002:a05:693c:2c17:b0:2c5:60d0:702e with SMTP id
 5a478bee46e88-2fb4d68f418mr37688eec.18.1778281211224; 
 Fri, 08 May 2026 16:00:11 -0700 (PDT)
X-Received: by 2002:a05:693c:2c17:b0:2c5:60d0:702e with SMTP id
 5a478bee46e88-2fb4d68f418mr37647eec.18.1778281210281; 
 Fri, 08 May 2026 16:00:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm4233923eec.12.2026.05.08.16.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 16:00:09 -0700 (PDT)
Message-ID: <43653762-78c2-405b-ab79-6ea6697ae830@oss.qualcomm.com>
Date: Fri, 8 May 2026 16:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Add -fzero-init-padding-bits=all
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260508104723.2144051-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260508104723.2144051-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIyNyBTYWx0ZWRfX7k2zHtREMqjf
 H143gs3eYRTR6AbkFrNHN9d9Tqgfj8uO4mxorIZoY+V2tI9YzMbtWeW/3tOh7fNpFiHi6Pvvdzw
 5xsDhxBlmQy+EsDQOdyr471HMg/forw2glIHNv3Nlo1/7hzRBVehy7Rr0BDYlivo3GtM5t6h4xM
 9UeNldvpkH/0EyKjknz2OBxilBGxkOGTstACmMInln2y8EfCTb6q63OSI6SIkkFX5ZS8S3Ioy5o
 7IN9gtwiVqujYcgt74odOf0xZcJldsqEwGfSLLFvHJlYfcUMwFdsosjCqX9nmOqum1SPd7+DaMM
 Cdv4gc9mSPlVlq/RhNn0ydzsVU3JHqepeZ7jD49ms3QUTIcf3wzPSAJY4eW+OtxyfTF5A7kUwVF
 dPCwfYBDZ+AahM2BJUwHVeLpsBtAqOnkVYYpjP9RnSARkvAe1yn+Fe7Rv00jUZrCQqx0HKKcILV
 h4VbdILRYsffOOpJwcg==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fe6afd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Twlkf-z8AAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=9M8uRWh7XenBEgj6lUEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=-74SuR6ZdpOK_LpdRCUo:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: G5Mhdw-06jKMiVd7TSfViXqLAXSbOCvn
X-Proofpoint-ORIG-GUID: G5Mhdw-06jKMiVd7TSfViXqLAXSbOCvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080227
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

On 5/8/2026 3:47 AM, Peter Maydell wrote:
> The C standard doesn't always guarantee that struct and union padding
> bits are zero initialized, even if the code initializes a struct.
> For QEMU, this is potentially problematic, because we often have
> structs that match data structures in guest memory, where we
> initialize them and then bulk copy them into the guest.  If the
> compiler didn't zero init the whole of the memory containing the
> struct, we could potentially leak random data from the host into the
> guest via the padding bytes.
> 
> We already use -ftrivial-auto-var-init=zero, which will zero out
> padding in many of these cases, but -fzero-init-padding-bits=all
> closes some gaps, for example cases where we initialize a
> variable with a struct initializer, and cases involving unions.
> 
> Follow the Linux kernel in using both options. Compare kernel
> commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").
> 
> This option exists in gcc-15 and above; it's not supported
> by clang, but clang documents that it guarantees zero init
> of these cases always:
> https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
> Older gcc which don't have the option behave as if it were set.
> 
> (These options are passed through the cc.get_supported_arguments()
> filter, so we don't need to do anything extra to avoid passing it to
> a compiler that doesn't recognize it.)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> CC stable just as a precautionary thing; it's safe and we
> might as well make sure the hardening options are set there.
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

