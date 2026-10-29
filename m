Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6CD606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DHfX1dul;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RQ5lTjbo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTX1-0002R9-54; Thu, 29 Oct 2026 13:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xMTWr-0002Ox-2G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xMTWn-0006wy-EA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793293377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hN6/N3osDyYnlpX1G6U9mmAtwp5NVZ/GqjL/7RL4rVs=;
 b=DHfX1dulvGGnKQTtXXgooAaTMp+vv43dzAYvtWQVP12wRBcPK2G1XERrFDoHkyWZxePkOm
 J/AeOXt7dqviXXnrexBAuqKytngQvAFFSne/rw68vX9JUhB+twCShu2YczYMsdngAi2alH
 XwehrGR+011wCYVSN6QX/ntAkYVtQH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-JJfESXd4OGKwG3NXYbQBCw-1; Thu, 29 Oct 2026 13:02:56 -0400
X-MC-Unique: JJfESXd4OGKwG3NXYbQBCw-1
X-Mimecast-MFC-AGG-ID: JJfESXd4OGKwG3NXYbQBCw_1793293375
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1895ffc83so16547495e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793293375; x=1793898175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hN6/N3osDyYnlpX1G6U9mmAtwp5NVZ/GqjL/7RL4rVs=;
 b=RQ5lTjbohMzI7DrM5mPbFHQsdzigKNj/f3LmMHkGS/dS0Tv9md0ywT7FS1afUZXrSV
 Qo78OHmFzexWiCTpUpwmqp7ZR3DXPZuzowncxDH3sjeToGRMjLYaMamZNM31nRfwcCx4
 fQ8QwtyFWMGYGifJTaOlk9Anh3uevC+RB36otz0bcpXiIdCG1j1W3ipX+7fgE7WhOg/T
 nixFTM0tesadS1IjzKsOm7m/G7/avaXAA9+LUnNdTpYPcI7LrKGhWn4Cb3uPp+uy6IMq
 LqsfLi6ZpvcPViBUrOqYQ3xmHdkpBiNnhlBQqMWNiD8sH2bWVpSIgH3PQFKbHzzET1wz
 7gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293375; x=1793898175;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hN6/N3osDyYnlpX1G6U9mmAtwp5NVZ/GqjL/7RL4rVs=;
 b=YWheFWcJAwyl4467z8vShYR7RTkAyODGtTGI4e72W3Y9QxMgtrtSieJAHU8FqHUzQ1
 LDAnBKQer2fg5zEYeYECVziK/DyrwRfhD5dofuxwrmZRsFAuTlvX31ydKRuAJCwO64LD
 wBkjG78GTgY6eKH8HH25uxiyf5tTTGZxYnAft2EnB+rtHw1rHLbX75wknPd0oZrgbsCL
 qDcsuLc2mwP/OrXY8WAh5ygdAMnY1EVMMo3Q5hbG3V6KE96qQufiZwRZlS/GoSM+V4GR
 s/1Qpi6GTqTX8pqSs4QrB3pAgcI8LXbt5owSUuE1RUKjAD6iGs3E2YiV24N3vA6IRYLt
 kzhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ32HnlBeh2sMFgztGXjXZz6bEptm2DtC+OzqKq+eq0hb0wnckqmEb/Tqj4x/bjBw5X1YkUCiBeT87@nongnu.org
X-Gm-Message-State: AFq9FYL4abo4839CrJSbiodX3S6tluPUSbYWs/II2l7cAl5gGzpV2m0q
 gzP2jRqTgNhTRZnjed07NanMIStFCFqxl74ENRFqmBh8UzPzlnCxAOdfL7AXZXN3oA2VHHosf6q
 4ky9Xbu1I/YiHTIYVY0wQ1K9SJC5IDjLNzKgcHMpx1jKoW0ANrLyRFEC6
X-Gm-Gg: AYBFou2QStwGpeT0qx6tiFk5whIq1TeobuSIxFto0YKyodPMpYSO5GvcoGkqiUXG4GP
 TEYobuom053OdMFaZsKP1WgIf+ck6Zb5tktuejRZgdi6tCMsjqIDuCC+cAQmbFyIq9buuzT8NXM
 g+wGa4EE2O/vYCx3LV1mLL0BtXgJUMuPuiUoVDWJr0YDtTOzrr/pnDahuny/iimrWz4rklqmzaB
 NPmaswkLUweAVbvEYm2j/bSRKmrjlzPfaVKyT/SJ8xqtW2+pqvGopdpyWf50LO09DUvG1BvO5Sa
 IDXFMybUEDyoEiuu9K6VZ7OcgTHtgGb47+W0OYQnV7CjQrsM88123h0hYA79/rQbLPA6VmhhNA7
 doslBUJbtelA6qn23FVwS64k+ylv90D9KfmT4WZmUBL9YNQ==
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a96695ec9cmr125080475e9.15.1793293374740; 
 Thu, 29 Oct 2026 10:02:54 -0700 (PDT)
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a96695ec9cmr125079985e9.15.1793293374350; 
 Thu, 29 Oct 2026 10:02:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7fdb75e0sm78048725e9.10.2026.10.29.10.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:02:52 -0700 (PDT)
Message-ID: <43616cc1-130d-4b21-8743-47beb5086738@redhat.com>
Date: Thu, 29 Oct 2026 18:02:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] tests/functional: remove @skipSlowTest from
 quanta_gsj test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029161310.2065290-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 17.13, Alex Bennée wrote:
> The full quanta_gsj test would have caught the regression caused by
> the WFxT implementation and isn't that slow (<60s) it needs to be
> gated.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/arm/test_quanta_gsj.py | 1 -
>   1 file changed, 1 deletion(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


