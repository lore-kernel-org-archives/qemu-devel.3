Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C885C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whB0q-00079B-Ar; Tue, 07 Jul 2026 14:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whB0o-00078H-Fh
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:59:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whB0m-00054z-JM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:59:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT39t4130292
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FjbMXTu7NqpqMWXvZ08lxR1A2fI5DY4lM3IHul3yFpQ=; b=J0zizZobL5/hMItQ
 4jRvSMl8biHj0flKluJo6jSYCWi8Mr9H3tG6CDEQdEY02jRHjWQ63uOp+5lsSxzt
 E7I07qKrzfLIHrQZ04dzmFFtAKG7VBkPuaEqsvcwzqi4jjPtrZSIf82IXCYN67aC
 5wEcMFCrQrqe2iyegObsTtbt7/LfiSJ1p82o9mfUoe5r/P5sj1pEqt30E5ld4VE9
 jJXDwe0KfaN3+2NAB6JcmKZg6vCZPuNwaH9mWzobs6aBwqYWYJPPGTNWhNctWILq
 0JXzYlZKq206qZ0DcGgR1cK9W50jSFgrR/oYYCFJ0aL/x1e3B2fj5iet0puad2sj
 4E0yYw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15brjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:59:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so933849a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783450753; x=1784055553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FjbMXTu7NqpqMWXvZ08lxR1A2fI5DY4lM3IHul3yFpQ=;
 b=SLfNXZ61iXfP1sTtd2itY4dxYqIQQNsWGxN5YT0p0D9b8ne+AB767Ob8243ajnL7xF
 ihB8ZXKBxPoMXjK+PQt8Tg6Y7PbuHK5i9tA5Udy97MZTleMGnHukXKp3Pmx8gN3KT+Bh
 VlX4TfxiAo3dJjtSyqF5lyFEA+UPXn86BEcJae78mYAYXa/1YDqQPR0uumbyv6SsqBA9
 MHBCl5amFHWdpzAiTujj4frQBZ2n6a1YFS3R/L3YrgsNJ7+5DILTVKeQia+10sZH3PMZ
 HIZfmkz12qMiasRrThFw2BNl3+kQX9juzqZn2SjjxSa26l4zM9rEGlJe/dXLKDdMb/r+
 fgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783450753; x=1784055553;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjbMXTu7NqpqMWXvZ08lxR1A2fI5DY4lM3IHul3yFpQ=;
 b=n9ILue+XmLXNHhimgjhSjTcl9Y3GxTLdT5kU2lMqfyaepveEthygsp4LQxyeTS6saC
 XbT8quHuGdVBaXgY0jgdklG2/ZnO1pLHnFCc1N7ow0GxASH/s/pPIwfOoiSu7Mc7TQfC
 AgvkXo/b460zFTjU18Al4Q7Mpf9t8e05lG9AuwRSorGLsPdWXS9AAANciMr17l5H/N47
 WBJ8/i59Wz9L+zWJuc3aFkBOY8thm2W8/U+zAGC7PShHK5m9dl0dfYxmTPEdBYAuGp+i
 fi7erdB7oL6JBBUmV01S+wniGv35d0y1C4PevQf5wWdmi4RD1n5e3dW0RBb/2J6x7+fr
 JB0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rot9QEm/HxH7EVeB6rJzT+aMTIF4uTCLyIPbpNawvuF7tWWoxckqFWJgMsm+7Fba3CvDK38H+DOEX/u@nongnu.org
X-Gm-Message-State: AOJu0Yy7/iyQbki0FFrPm2uz+f/dJptiMcjbdGOZe4/0dv/DxU2uqR9S
 ugJLV4/wWiaIE/E7YespQzylme/KO2g3I2P61KCziwW9nj/b7RlM5orNOWBF2Al4Kc2+UHnv41z
 ZbnwH1Mn1znb7zqpCC3OcD2I623YemrzP9fqCZwx6gJm7V23F/dIda++r9Q==
X-Gm-Gg: AfdE7cl0AUBsme0UJDEAECoaOnu7fw7Hh54KfnHLPFfyhWEI4o8DoaecI9Ic5LRP1Wx
 t9luScFi3HZyl0h+zOvowYNJNsETOe/eW///w6BojXJz5urScA7N2wjoFWSRWQzXm8k3lhAP+ej
 V7VLqn4eDj3w7Zi2HzGn18eMhYNKpqncxtIo9QwQLk11ajvBtTYlqjaf2RLeI0GjhvP4vkj1s/G
 Lx1q+yvoy0eX6J7Jt3GPELW9saSqpoDixqsUIVD+FhvIeBozBV6rT90lcROtDfVzSDStyFMFkOD
 uTA3elueJRujNhKU4AFRK2hYFkfD2eUouAMDv8+OcBWhZHeuQ8A8bR7c65lv1iqOkPbAzhxUg7f
 faEcbIxUxBZy2NXiyPR++89UsrT6YRBSnTe0PqHPDypZlcWztUJTST5Nc2RnsYBiLguyztnD1Kr
 PExro=
X-Received: by 2002:a17:90b:4f8d:b0:387:d9cc:7dc3 with SMTP id
 98e67ed59e1d1-387d9cc8dcemr4981618a91.21.1783450753527; 
 Tue, 07 Jul 2026 11:59:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8d:b0:387:d9cc:7dc3 with SMTP id
 98e67ed59e1d1-387d9cc8dcemr4981597a91.21.1783450753062; 
 Tue, 07 Jul 2026 11:59:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31189cd8234sm637346eec.9.2026.07.07.11.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:59:12 -0700 (PDT)
Message-ID: <99c7bbd9-5a77-4145-bba9-9f5ab6f2a74f@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:59:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/49] tests/tcg/arm: Tests for new FPRCVT instructions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
 <20260706103752.320511-10-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706103752.320511-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DNwkDkJkdNkcWVhLG2jlciTArC5oVW-K
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d4c82 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=CJNEwxlfiRy7C4Yk5AMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DNwkDkJkdNkcWVhLG2jlciTArC5oVW-K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4NiBTYWx0ZWRfX7wFTqWBOlziQ
 SOdLtbnoBj353vOO4P6qJcArb3BSUN1HLGSavFfBd8YGxOKch73iJvB/vCWCPmB0q+jKKQ5qFB1
 B7e8i8GKb+xVlfcvfEzn9UZQVZ9E5H4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4NiBTYWx0ZWRfX7o4qxrCtEoEr
 LzukZo0pfpQmaMdt8+9U0N5fUxrC9T6nwilS3cezoA0F6zfkPO7PkeVtYZTUp7x/RsicSJ4FVZX
 wglo5ZofEkxduor223WcRNcXxwJqlBsoZaOr/oaoNSv/263GcqOcNf1EXF7kMjpRAtUqYFKlXw5
 VqBVa0Eg6v+mHkSxfHbyg9dTkCAtoGjukeT1ujN1vKwUkVHZ2uvqMfvwCXcko4FaO984HCtwrB2
 moNtLKr/ZyvnBoLbRhF/i71H+PiwLtO5EEdoerQkSwcBAa1yepExNhgYbjxClDORV/yCDikJcQW
 GhPlSTB3EJ25G56CeBN4BKj7C41gusl+y0u/zQ4ArYIgWndBWHeei4KLJr5Y+XO3EeyuPvfUsrZ
 fBv/jHtdCU9zEwwZTMpsYm0KSThakGQ0zBL+C8lCS3ezCp1bqiYJfMBQWmMQjCVe8q/j4QRpIZ9
 aynUviUd7iFV4GwtilQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/6/2026 3:37 AM, Peter Maydell wrote:
> From: Jim MacArthur <jim.macarthur@linaro.org>
> 
> We autodetect the presence of FPRCVT in the test cross compiler,
> which is a recent feature in GCC and not supported by many distros
> yet. If this is in place, we compile the existing fcvt.c test with
> an extra compiler flag which uses the new SIMD instructions; the
> output from the test is unchanged.
>

Regarding the current work for moving tcg tests to meson, it creates an
issue since compiler embedded in debian-all-test-cross does not support it.

Should we update the gcc-aarch64-linux-gnu compiler to support it, so it
runs out of the box? Else, this test is basically dead in our CI and
most devs machine, until next debian lands.

Regards,
Pierrick

> The existing [US]CVTF instructions do not have a test, so no new
> tests are added for the SIMD versions. They have been tested manually
> to check the new SIMD versions produce the same numerical results as
> the existing versions.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> Message-id: 20260630-jmac-fprcvt-v3-6-f4840d5e0a7f@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target | 14 +++++++++++++-
>  tests/tcg/arm/fcvt.c              |  7 +++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 6203ac9b51..32f2689273 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -28,9 +28,21 @@ config-cc.mak: Makefile
>  	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
>  	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
>  	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
> -	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
> +	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
> +	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
>  -include config-cc.mak
>  
> +ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
> +AARCH64_TESTS += fcvt-fprcvt
> +fcvt-fprcvt: LDFLAGS += -lm
> +fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
> +fcvt-fprcvt: fcvt.c
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +run-fcvt-fprcvt: fcvt-fprcvt
> +	$(call run-test,$<,$(QEMU) $<)
> +	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
> +endif
> +
>  ifneq ($(CROSS_CC_HAS_ARMV8_2),)
>  AARCH64_TESTS += dcpop
>  dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
> diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
> index ecebbb0247..7c0cc4367e 100644
> --- a/tests/tcg/arm/fcvt.c
> +++ b/tests/tcg/arm/fcvt.c
> @@ -171,8 +171,14 @@ static void convert_single_to_integer(void)
>  #if defined(__arm__)
>          /* asm("vcvt.s32.f32 %s0, %s1" : "=t" (output) : "t" (input)); */
>          output = input;
> +#else
> +#ifdef FPRCVT
> +        asm("fcvtzs d0, %s1\r\n"
> +            "fmov %0, d0" :
> +            "=r" (output) : "w" (input));
>  #else
>          asm("fcvtzs %0, %s1" : "=r" (output) : "w" (input));
> +#endif
>  #endif
>          print_int64(i, output);
>      }
> @@ -425,6 +431,7 @@ int main(int argc, char *argv[argc])
>      convert_double_to_integer();
>      convert_half_to_integer();
>  
> +
>      /* And now with ARM alternative FP16 */
>  #if defined(__arm__)
>      asm("vmrs r1, fpscr\n\t"


