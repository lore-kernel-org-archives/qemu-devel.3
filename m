Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE7BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETp8-0004iW-RG; Mon, 12 May 2025 10:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETp7-0004iI-AL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:08:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETp5-0004fS-JY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:08:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a206845eadso842947f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747058882; x=1747663682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UYnm8QtxKb5zAwcVnPa2mfaA5wGsEYG81oTj7FUmXZc=;
 b=kCRAOEbFUNv0G4WpnVAvxgOlQ26ZKIxq0GJriyYpBaZMFrVJebJZxZuEe4dKdFYh0Z
 4Sw7zFOzckb9G7DWoP38OQV4Tg53/CKdyGFLL1RvaYHHK3rKt5LM8RgTEhwxjn0pJJUv
 NuaOp/FYdrIpBTz6I1D3kx5sf9MQq9Ifcpk0nbsfmYqp3pt9F80eQXNVFCUdtImx9hcp
 Cuuph9Isk1SmaaWZX6FI8kyiUE5PfwiNxYyCPYtUvaE0efy2F7rO85vfsDjuSUNQV92+
 Ch8KcSsBtaYY351K33I0XH8CR3ke6nXxjxAGlivPFdeNEuSgdPDunkeEqyoeLn6DRlnd
 oizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747058882; x=1747663682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYnm8QtxKb5zAwcVnPa2mfaA5wGsEYG81oTj7FUmXZc=;
 b=qM9iamEXEfu7RQnoxU7kooBnq1jxOZo8ylrc+AohS+gEXCvrJdf957IAgSqgIelCaT
 wkmm+/9BgeudwAlfi1SsEWPHCm4CHDPIUb04J+wfZWNQC++RFMk3dXPourWoxsKftHfG
 3WyYC4aVgBIkLSNOuoIiRJkdneaKs9XbCAbvOoGkO1VSfGJaUWhNXCe9hBmIIm0Nns0T
 kV6We5MpO24cj8ebUvV9xFKxaY8luI7Cv1Bi2uI0dZlmCZo4jtYTv40BGJOX5J/fHD99
 cWxx75EANP7SimiVURf8m1V8Vn5vikoVSbGcRoSPQKloUrWZS2ziOE+g6rHViNYLD1al
 WCsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUd+Fjd8xn8/oVgzSl5b/CxQXfLZrWgWTFz4LV7aI46xXq32AOy2i4qDTNTOrCovEwHPsU+3XGk1sW@nongnu.org
X-Gm-Message-State: AOJu0Ywd5srjREr5KtJwMu+Su25RavnzCFLWkF1ai70UK5O4KXRoo37a
 tjnsmOd29Pt2qt6iDPOrgoLnptrJDhny8KYhBtH0m0t1xEeWhEdGrOmOvKSnrvw=
X-Gm-Gg: ASbGncuRM3xvQzjddZsvyz57QrIK3NsmtvPXj5ZV+usO4wzxetfR50qxc5HHH+1TzD6
 dsbEL3eZcQ5n7nxDWYm2loi2awS4YYWUZsCkqFk0SAB64W3G4QpTAT/ndfHByfWb6K8yuzNDxor
 U0iu8wS8VembHmC+w8TxN2i1i0VMWWIvefu7PEooURB5ezIbPCz6XAf6f71WHvUVJOPFhodL/Qw
 5RD2oQ9x8v0yeQsXXiPTwbM+TL3nDPC6TRjGiSGYdaBPyyY0TV5VDdwv7cdpfR+K/HgwY6Yf6B6
 5HOZc6Ym7/klzuFSoOnssjzwdR9KPcLRp75Zz8EoxlMh5OTPoPkaVjlU2gq2sJ2zdxmEZhbXYpw
 u3gIHDzcT7SW9+qwFX6vPwSvfPeN/
X-Google-Smtp-Source: AGHT+IHriF2ZLUkLI1e6xOfcSCyUFg5baHNuDV3x7bOwfw/vpkNlkp6U8kPIhyDNtM1tlaFQT7AWfw==
X-Received: by 2002:adf:ed92:0:b0:3a1:fcd4:eada with SMTP id
 ffacd0b85a97d-3a1fcd4ecdemr7149990f8f.4.1747058881297; 
 Mon, 12 May 2025 07:08:01 -0700 (PDT)
Received: from [172.19.170.213] (90.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2d3sm12723325f8f.63.2025.05.12.07.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:08:00 -0700 (PDT)
Message-ID: <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
Date: Mon, 12 May 2025 16:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250509174938.25935-1-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250509174938.25935-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/5/25 19:49, Fabiano Rosas wrote:
> ASAN spotted a leaking string in machine_set_loadparm():
> 
> Direct leak of 9 byte(s) in 1 object(s) allocated from:
>      #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
>      #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
>      #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
>      #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject-input-visitor.c:542:12
>      #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
>      #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390-virtio-ccw.c:802:10
>      #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
>      #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom-qobject.c:28:10
>      #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
>      #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ipl.c:569:9
>      #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ipl.c:594:5
>      #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
>      #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/misc_helper.c:137:9
>      #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


