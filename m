Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E799ECD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUE1-0007x6-3n; Fri, 22 May 2026 14:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUDz-0007wX-2X
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:03:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUDw-0004M4-B2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:03:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MH1RtM1801155
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lHemdVuxJvAvNicEiVAj8fDqL4Ks8bMbc9ST5+QKJE8=; b=ICltR8hRMZojM1A8
 nmN/oKeMqr76RS2jMqaQbwsiaJISAjyTIEshOk/W3RFg+S9XzvqqXxhYJAR2KiOL
 Xe/EQ3GzmQ2DGZBxlEg0mpKZoE7Px1tbuYH2xohZSS5MpfsfL2dvTBIhmJO8iPlu
 Yi6RS5WtZ+J+R21Sk5xvmE55Wjo1VK7uY2+abqj+SoXBnlVSW2/yu0uPPGkedorj
 4amkbZIVAKHa8N4f/vTj4TKc07nuwrVArt/G2RHHE9uqEgtQrQTqplMf2onfKZz/
 1dFoVf6+bPRKbT1iVj0rxzTCxcnzFdhfx67CLoS5bVqTN2Ar9iIroPay+l30JRGE
 AbYSQg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g1tjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:03:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so8738124eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779473029; x=1780077829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHemdVuxJvAvNicEiVAj8fDqL4Ks8bMbc9ST5+QKJE8=;
 b=Z6RM99s0EeD/v0jGJXPtYujn3TFmHNp8iJu34qOfmJmnckCM4LBCTf3YZtEpExb1/J
 pB+TMpCpRIoy0z97Az0y2tt/0uSGkih31h0oRrcdS5TuNI3om7qldm8LnqvrFPYvkWa5
 K5/NTIdfL9lJsvmoLd2uJ8z0Y+7e9LJBve78q28ia2MwUjD4jC+4iyuU5U+kZLlK7YsX
 rts961tedJQTBhlYQRf7qjz/SELSpVtmcMfZnTqz04MHuhqYxzVuEHgkDMnndYBms2MW
 6JrHcKI7b2kGIlnCtrp+iNB541gZjmDNtVR6JKNdsI5JTc0uXjIlJk7gSB62I280NEKm
 69fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473029; x=1780077829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHemdVuxJvAvNicEiVAj8fDqL4Ks8bMbc9ST5+QKJE8=;
 b=nMiBeyxeqQeV11FHVdvizjf/EAynl2QiLnr8dnEpNzrl0skC4mUR1rkQXdZTTz6+5+
 H3Pb+Hz3pAtj7e38MAAxvGaiV0yXFQA65jc8g1C5nBBA2dY+vt/a0/PV6wqDfIupm91+
 UMjNAJMF3FChRfjAbat8he4Cmlg78pDyfkcIDh7cBY9PL3dVt+9gnnKSee5ri82YmXBF
 f8UelPmM774AwLhVSFt2W8GE48eL5dK0iRXtfuk19FmTVE/rIugutTR24Q0BA9DN6dL4
 dpLReAhPdaIoTCKdkhs2XmeKIWSo+aqqpd12sU2jsa74TO4UEjgNnBkIGeZCtPwri9xp
 7kyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lBACjfbrkskOKznjPpeGZuOD6IPml1TVJvSU8xy5YgMAdL+zQWhmGFSv7M7NnlDEtvp/kaDUlnznJ@nongnu.org
X-Gm-Message-State: AOJu0YzDdwAtPcafIHXsta6Q3i5JEPHTOM6BWuqpU7GwHudY/uZ79Avx
 8G9R0khHfUKkqD/xAWO/wj3duabbBvWuU6wPbaQBmCzMVMSE5b0kAoGu1HUb/Z1Fc+qv/8ooGRW
 3YVeNXMSJDabO8jbynoZ9FEmQrNtGCq4XVJOm639N/4Z+x0SYj/l+F/SDcw==
X-Gm-Gg: Acq92OHpgYNSop3Xk+BAYZz9ydg1PNhjXGJdId3djVo9goL2zXh7f9GffXtnDFTnNxv
 sNO3dI4tQ+Ck+yF/p8f0/0h0GV+MEemGDT/V44/h6sruGT7PRjMSyeP8wG1rYFluc5B41yOJidk
 uFYUsB8i6JvaKP8wWXMATKGskuxvSZyWrY4slAGyD1wLZVeM4I5NfprUZBAJmlQf+4eV7m5aQNy
 HIBy8mrnIIx5RMbC3ovPVHWPA/GHWQFqHs4pIn4RqYEuwmT1i0jF/dWF15s6D/fOc3H+MBxJ/31
 GD3YJ8WXDrGwZ4Vbqd/bozFZb0RyIYgxcVNjJ9nMx8DQts72KNMRztRLtnvkhdXg+ny00aRhj0m
 Aq/Ncau3+63spIxYw1UWqmTxta29gknrRBAoR13SjtL4bXJOGrYDyZmurg6svmf/Yh2TCATgczJ
 oWKhcMbwsamGEGFw==
X-Received: by 2002:a05:7301:6588:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-3044904e215mr2562418eec.1.1779473029298; 
 Fri, 22 May 2026 11:03:49 -0700 (PDT)
X-Received: by 2002:a05:7301:6588:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-3044904e215mr2562406eec.1.1779473028593; 
 Fri, 22 May 2026 11:03:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f1f38bsm1474714eec.9.2026.05.22.11.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:03:48 -0700 (PDT)
Message-ID: <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:03:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i4R7JcAq1YQ37wXeAhJElbBb4UC0Jqw1
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a109a86 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=IqlzA_7BHg-eakqZsUUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: i4R7JcAq1YQ37wXeAhJElbBb4UC0Jqw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX4MxIftRJ6cPw
 6jJsOXe2T5kq2GHlYtKU+Ckf3ShE4uLR+K4C8rKbsFeK0Gm/SZLcNP39EHyPRrQB33I/jGXr8g6
 jdb4fXMheSCZ+yJzhfuYg/Wj5JqleCrbM65Z65ohIgiaxpxc7vlDngPUqoS+StqjG3O57hlzv8/
 0oX7ou42e+U9bGmhhgg2PzbnCmR2vrySuYV+4kruftYHcyYGJYb3yvNGJlsJ/RlUsaZs7Oks6rR
 vmjcllPeGHrQPbhRZ5HEnXwg7GGPuwnYz0LYqelcAj2U5urJiF5kYz8rNL1Fqs2t7ZTlvBjdxjO
 3u7uKUSdiaZrQXVl/nPxSTp2dAnAxxKMEGyjv5YKDvmpZ12JNpeHQBp5Ydqnovrowk+8SwJv8QM
 sfHim9V2yoahzDuwVb1PCdVgOhCEk8SahCj1PHQGzkAGhTo52q2/Kni7gzuTS8t7Oq1xF9cy1ml
 KffObdW/co/C8wSRS6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> Explicitly set the appropriate QEMU binary as a dependency so we can
> ensure they get built. This is especially important for MacOS which
> otherwise only builds the unsigned binaries on a normal "make all"
> run.
>

I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
unsigned binaries are plenty for it.

Which other binary is this building that is not built by default?

In general, if something is not included in "all" target, let's make
sure it's included there (meson.build?) instead of adding a workaround
here. Not only tests benefit this, but anyone doing a build on a
platform that might have optional binaries not built by default.

It's totally ok to build all binaries (even for other targets than one
tested), people have configure --target-list to restrict what is
globally built. Better to catch something broken elsewhere instead of
"oh sorry, my custom test command didn't build this at the time".

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ce6a0dccaf4..cf6f9e68245 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -57,6 +57,12 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
>  $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>          $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
>  
> +# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
> +get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
> +
> +$(foreach TARGET,$(TCG_TESTS_TARGETS), \
> +        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
> +
>  .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
>  $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
>  	$(call quiet-command, \

Regards,
Pierrick

