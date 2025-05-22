Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B33EC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBOt-0006gv-7E; Thu, 22 May 2025 15:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBOr-0006eI-If
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:16:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBOp-0008QS-Lx
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:16:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-231bf5851b7so65894155ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747941373; x=1748546173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7QZ2Y+d9ontZ5AS5vV9PwWRPW5GvjP8JsC5Z6NqYXE=;
 b=gsOXcYKWxNUziO3759rMd36umCaK2gsQqbSdjcbxmYTFUERZeUZf/o6LWvfrXLCGZ/
 fnHT4utDXI4Gorz7NWzMq7iblv1oBLqg5YvETMXHB565nxLqiN97gqBTKiA1A3eNs8AK
 0j47RGbRg15DwXz9G8+CoRJpreh5U8zmoHXhQrAnl3c1IMctvN0UGDQL6kRVn8epjyZW
 +NSanv27lQo56KoUvgVlzckn47G6kitlbj+Dq/PK/1c1KVzN8xBgC8bfZRrlmbHHxOUS
 69k/6GvvBYITaAXcSbzE+d49qd+ELQAAB1vaSFSZGjPVXO7AV9dGApmlKsSDpA7cVhDD
 fAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747941373; x=1748546173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7QZ2Y+d9ontZ5AS5vV9PwWRPW5GvjP8JsC5Z6NqYXE=;
 b=TonG1hlqq6WMEdreRaqTIhci8rRfn8SeFEE83TKkRAduIo9qItLU5Tn+p+q0tNlOX3
 TmvL/lEo1TIEbPyhaPZjGw+wVN7FGoqfIzMYlScDXBr+hk8eLLx+XLJLXdgmSKiCSV1f
 p5gOGBiSFCFvD17cyOj+vxLrfQD6zSF/qcYl5DLxsJBdeqP1ClcL8TPt9F1H0hksMtmQ
 tHpFscGjRCTR6Xaei52plLMM4E+yE/BRgcx21Q4WGb/qDwjC3UKIvWW7AURDU2TUfJjf
 5Jt5OnUCEGOkw07C2b9Dnh1iV6sEzUG5NRiuDnj0YuKNzhqnnOwcZe4rIzBMX4wkzHmN
 N/zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw61VdNILlqRGWCevqGcCefNFxctehqKzf8uL3DZ2MOvfscxug4CToecvb4G0qxyFLP6Lvll/C/rS4@nongnu.org
X-Gm-Message-State: AOJu0YwjLjvvgKWBXNhqSKroFfsy2TfchAszqjV7SUNv6/7Da39PUek8
 BG/alFJzu6/cKbzHbEPnULUltdThg6Iy5bXerHbtEj/4/3R72jJkcTS2rPyrEoheD4o=
X-Gm-Gg: ASbGncv40v0wiU7yi8BvPx4vqqewWO5q70treRsFJpKOAOO8IpaQ2mGD0/FLijBf4R9
 K1oE14qrlsu9/KkPLVMNylJZfstyp+WwsgSGOuPBcnBN7l+CsKROoq52hl3Zcf3YoCDNjlUXPpG
 hsCiQHHGgGGnA12kL5xFKHlIUoLcuv9XDVc9bgTbmgV96J6tTDpy2qnEUjCADcJfb5jt0L+PoX1
 WyioGYKfbARhDvWINmfAukaFR6t0iA7oRSjM+AFxR8U9kSVUhA06CAxC+w7xid5PvPJk8qUfDaz
 Kozn+XA93UlzGpuJWPtfFRnAE8n4FD5QSSl0BG0huPpaEpm7HGsTpDZ4EQpi30To
X-Google-Smtp-Source: AGHT+IHR+e9wJgvsn+1g3HrHxA4zpA/ngkjqJ/a9EIIyedRbVV2NQJ6iClP+UK0wU6Gj80cY1tHpng==
X-Received: by 2002:a17:903:264d:b0:22e:3ea4:b55c with SMTP id
 d9443c01a7336-233f23c5fe4mr1512385ad.30.1747941373498; 
 Thu, 22 May 2025 12:16:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf6f28csm11547050a12.22.2025.05.22.12.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 12:16:13 -0700 (PDT)
Message-ID: <bbbc7639-9ef0-4510-b481-0c3145b6ff11@linaro.org>
Date: Thu, 22 May 2025 12:16:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, Rowan Hart <rowanbhart@gmail.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
 <20250522115935.34716-3-neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250522115935.34716-3-neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/22/25 4:59 AM, Julian Ganz wrote:
> This definition strikes me as odd. What was your reason to assert
> `current_cpu` here, but not in the other two functions? Also a bit
> surprising is the declaration of `cpu` if you use it in just one place
> (rather than just use `current_cpu` directly as for the assertion).
> 
> And there is no reason in particular why the vCPU could not be a
> function parameter of `qemu_plugin_translate_vaddr`, right? You don't
> have the same restrictions as in `qemu_plugin_read_memory_hwaddr` or
> `qemu_plugin_hwaddr_operation_result` where you actually touch memory?
>

That's a good point, adding a "unsigned int vcpu_index" to the signature 
should be enough to query current or any other vcpu easily.

> Regards,
> Julian


