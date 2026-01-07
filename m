Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93A5CF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKRL-00047k-QD; Tue, 06 Jan 2026 22:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRK-00047W-R6
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:42:30 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRJ-0006js-B2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:42:30 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so11324155ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767757348; x=1768362148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JSj9g5yh9qbnGT5qogFzOvdaHzJwN5LwgnloYAZF9h8=;
 b=xg3Fc5wx+5mBAxJcXElsXlMOYcrdG+wEJumXpCI+b3fdkIwEJh7RKOYc0T9+8neyfz
 zxvJgLlwkLxlSWFqDo3NxcVQxbwj2mH9y/Z5G/FYmPeZ2V3a+EX6h/KjiLFgEZyAKTQK
 ZauW7XNlHQsWxsnGS2x/kzf+dwkjDOud1fBga9NVRW17NBw770+tc27l6SOLTjVkJAg+
 wPWy36vCu1UzxkQa7UW6aZpHHW3EYL5TznUA6HoxImlAJqJ8HfJ9Jmnt38iZMQuUHyYh
 qe4MnemKM+w6fzRDshpQ1IYczc0Hrm91dumNvl6aNZ46cNtbF2iqrHfKCaBrP16eQHsj
 d4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767757348; x=1768362148;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSj9g5yh9qbnGT5qogFzOvdaHzJwN5LwgnloYAZF9h8=;
 b=Ejbk5JD5DoHEMBsj/pyXFO8M8N86Cgw/3QyRD0Sw983k63Os4TVxZ4GLWn6y0top1r
 426kp9Io0G2/5y551UaRDiiiJdcLl6cUc1+6Vc+zHIXnH08/7K3b6+vz9WBk328OroTs
 KeHq04P6mfQHR7WcjWUXTkgkqrtoBoHxRa7Xbh5EazpQfGsKQgOcKVT31WXMMzQPMBAy
 /fOCvkmkEhzzBgtANXptRDyNtwXFL27CcNKsXwGbuf6k/vLqUA08EGvSYC+IS44/00eq
 aCWyqshiJlEryJjgSbFuKbCSzZoCJSCsX+xIB1OMwYUkwtgzX0hW2pSAU3q66w/+c35E
 zsbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlrCb4qFArIINCEqNEqUqKtAEpRH6OAI3/Wp7mERWCkkeuoh5hXnFD7r1J91ZaB5Iq7n44izpIT/Cn@nongnu.org
X-Gm-Message-State: AOJu0Yz87vjwyC0f/lyM+6iZjr/VotQybn+EOqNQb41Fm8ELKbeAiYGI
 /r2ifYgRAxmQRbtJECTV2JVNHDyYWlSdxtQdttTG59yr8BFt4mRSEWpvvpEoCDsj0uo=
X-Gm-Gg: AY/fxX553AhnfDKANd1UBQmawIyQ/VmgOMYPZag2KUSLv7wrIIrHvZ+asL3/eFFJP/F
 4b7zRXxy3Tl338FQSqq+iG+qEdHbVkgAtLBdkwpYGFWDEoxUO7mcvLHMHp6D6fz7+zSRJMuEZyu
 innMn6MbzxxdVRmnku6LPRCVWmnGQYif5hM0i+SDWQkc/5ckBYPIp5kAn++VyTOcHD+X4UJsZh+
 s9dmj/EVJ4dP8WLwsSqyElZzytx9kdq9ES/uNNHGXZkuCB5boMtKdM9Q54lW87fnqoywMlha3BZ
 Bo7UYQqGE6gENicV9cbCuN4ZzEuxzc/4GqGGDCmZvQohEdmAVh4IeY/H9Cd0IQfkVFAjGUKIUT+
 l0sUOgHDYLq0VAbIrH/Fq0uUzDvHr5GbZnLeDbxbhUGvidwb/0z2Kj/eNUoG826EF5cBE+jOXoe
 cBpVi9HHxHCH/C9Ne7c2JK3M+QlR7CL+pQXKOQet/d8PF2BYk1JjvSgit7Znjuy28fU3M=
X-Google-Smtp-Source: AGHT+IH1liwV8OCPGUMBE5khCGPd08hNFFLaGJwRwJor6wzxBQ9wJb4uCIFKv8VsTeWvYWIOqwfDyQ==
X-Received: by 2002:a17:902:ce92:b0:2a0:b62e:e016 with SMTP id
 d9443c01a7336-2a3ee4aad5amr9426795ad.32.1767757347520; 
 Tue, 06 Jan 2026 19:42:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88d8sm34622755ad.80.2026.01.06.19.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 19:42:27 -0800 (PST)
Message-ID: <550b6f30-bc6a-460c-9515-02cd5a8d3e1a@linaro.org>
Date: Tue, 6 Jan 2026 19:42:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/microblaze: Avoid target-specific migration
 headers in machine.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20260106235333.22752-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header requiered:
> "migration/qemu-file-types.h" and "migration/vmstate.h", which
> are not target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

