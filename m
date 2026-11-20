Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA2606A6A1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dKsQYTEZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWYl-0001kU-DI; Fri, 20 Nov 2026 16:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWYj-0001jk-8U
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:54:17 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWYh-0001b6-HO
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:54:16 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2f03920c477so12081125ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795211654; x=1795816454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iWSaC+pg/A3a4vuwu14hR5LGl0fhGTephnxBE0x/52U=;
 b=dKsQYTEZ7IihnWqsZ9IYyUHtaQE9YIJO5E+xfYshRZ38A0qGCIhmD0UxLMGVQTPGUS
 FUh1ievwEQ67RNa1ym2y/bjNBUCCMGkpyJprtRO3Org6EpZ/IK+RMvRvCAEPqNG47tI7
 ZnNmHZgvF1zoWRsUAfPpDNHoR23p2zUDA8ULLbf/enazNnH+z7xsZ/US9IZcQE8NACDz
 4ROfmHuQdIBkBrkqv69ZsBrZotl19ZJoU4HFhwSqgj+tSADqFWVvEyx9/FPwwGeleXbG
 Z902YAkwse+Z1NcC5fK0MOVkfCXzzOtbMnRueVscldErCKmdHwZNK2to5wBcYqQrFySF
 zttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211654; x=1795816454;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iWSaC+pg/A3a4vuwu14hR5LGl0fhGTephnxBE0x/52U=;
 b=a3kPuRUbk9UjWkrUiVMvtBlyXQo4JYqdKC3NZXdAPHYhIhNF63JbigxO6FNtx7E8Ws
 72qL5PmrVShhWiFad6YE8KQU/8+mAYSxtT6PDAk9CYLSjaczXBPcF5ucd0XlgbaUec/2
 K7T3biHqqwrKh2beMO1DOwJbK+uWQuvWyLWLJVMqhqmoLQ0lIqbIIVpbI3MA0W4QrIo0
 ZFy4ST0RWZag6IxPCERLshvOjtCtpGDZT7qvJFCmiPvEJD/TyUbAxMAbDGrDF4lmKDoo
 ZVXn39Y+W7PmMhaEIf4VMaXc+8XOKA+/oIx9Z1aUlmanNW7q9OoKmWPc9KUHQTN9XmsX
 Bf6g==
X-Gm-Message-State: APuU4Z/KsWfGnj6a24mcF489zuPrQ65vZA6o0qKGz5Tuyo8rTSNC0/Uz
 rbV/gFv00KR1uzzPpVSXNZaFyhuqBGLnk01xVUtbRLJMAwRImjKZ0zZzZRHP3aXfP9U=
X-Gm-Gg: AZFdTZd07lcSrVNp6A1fdEOQ7uAB/yBMTv2Kn6qTjN9llOEvyHFGloSsazLMgS8LeBq
 Y2xJHov8HykH2wBgpGz5nVn1uux0G/bNhVvxQiBvTFMdCnMNjCbMy3t3wvsPvb4fYRF2Tg60Kji
 zasCNn2znhYiQjv88AJ0j1YDJyrsGRYXA0nHETh3ki2nIJ5c2baqGyg0Oergr2w48eRRvbJj1Y5
 SMXcXM9+7TA01r4j/T4hvV4osiT+7kZhkpI+z1Cx47R7q8qUMfHcogowq57KszWdgEmiMVgQM3o
 NVeGwwO5osU2ERDuN0gi2helHUOaZbs3MjZJEFNMYmvvRuoGN7q5pvqG2EACzB6Y2Cj+E6cR7H4
 3zktH8PSz+LmiPktcKPexxEExuooEqbpYVqGUbgrMA3ly2jgsIGwQro2+BTkkeP6xm39TOb0B64
 wNvCdyJe+Ue2k0hAihjj9jOJQctZG8DXsQ3FC41hJPFsOl/R6uAcH5f6zapXx8C2aRhMbOMPdyZ
 zNMIYOhLN+rkK0cKds/UtJkfwYMSqWVac9WPgq8JCh8rWZ1CXPV1JrFG7GCi2pHC4Vh7bydfICo
 n52Oq9jCY76fLz+yF7Urog+ops/UcWsMfMaDPYaEyTd2btQzSN8EBc3bVXdvn+szqO70Cio=
X-Received: by 2002:a17:902:e845:b0:2ed:379:159f with SMTP id
 d9443c01a7336-2f03f0fcd59mr43071795ad.20.1795211653538; 
 Fri, 20 Nov 2026 13:54:13 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0dc4f2sm19815255ad.30.2026.11.20.13.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 13:54:12 -0800 (PST)
Message-ID: <114d8912-4aee-4312-9527-69dce1b8d5e0@linaro.org>
Date: Fri, 20 Nov 2026 13:54:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] tests/functional: update sha digests for tuxrun
 kernels
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Eric Farman <farman@linux.ibm.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
 <20261120121458.3723625-3-berrange@redhat.com>
 <CAJ+F1C+eBx6qUmtLGw2vSgk+Pp=Zpt92_tokyyGsrCREaE45gQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAJ+F1C+eBx6qUmtLGw2vSgk+Pp=Zpt92_tokyyGsrCREaE45gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 04:23, Marc-André Lureau wrote:
> On Fri, Nov 20, 2026 at 4:16 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> The images appear to have been regenerated since the recorded
>> digests no longer match
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> See also
> https://patchew.org/QEMU/20261112133320.418012-2-marcandre.lureau@redhat.com/

Indeed, Marc's use of dated urls should avoid some of the issues, until 
the url is removed due to age.


r~

