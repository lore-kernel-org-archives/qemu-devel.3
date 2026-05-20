Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C33CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlep-0001Cs-RK; Wed, 20 May 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcw-00053C-IS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:43 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcv-0002Yg-2w
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so4205966a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301599; x=1779906399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSZG5X9CZUwXqYG/i2Xu10x6ZkVLOm19dRBYdvWghoc=;
 b=YDkJ5lPDy62IUszINqN0yacM1zYwdEWT9Lus2ueSlm1NXZA0oqGNe3U8eo0dpfITLG
 BBE78M8jU38icck5HR+OtbL6FVvWVN/6baeAXNOEo4q074qpdZTbQKn+L9PMP6IQ/z/1
 iGpN89yboWjO9Uxx8pldAcUx4/Evm/GBbB4A2Dv+7ATIPn8T/Egj2rMIxWcH7mLrOgQ6
 CIG6JXdr3OHcDauD4O64IRnScrPtuGk67aaCsTUACCzlafXWgrA/IoTKYBQhSBS+V5i9
 qtmfZmeDA9YJLz2BU1vCOFcK5qVjxoRD83E92NYQLgaY6GKJWOE5qYRq+jcjtqAar1Jq
 8upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301599; x=1779906399;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSZG5X9CZUwXqYG/i2Xu10x6ZkVLOm19dRBYdvWghoc=;
 b=SpJKSbKm4v8ouQ3j7DWgxd+gVQvx4xmDi/7Wx5BrsmuTTVR4/2OQwTMRDXnkoG+tsP
 4H3LYJEinrGPXh+Thqos19OkuysOHoW/8ow5Asb/R0cyP6/Egi6Ko8I/NAScehzf9F9K
 zDuduaN4EuiB/6vSiN0WG2QTO5aMKAadWf7VawZpmKQBTmCPY/swqs7gHfT7cqco7wUh
 yNeN+uyGIX/py4NXBKFVz22bDyl5Zr0VBDkS53hMbUd7HUVxkwZixQyXbpveT0vNk6pq
 mHcxqiJcQ1Qx33Tasp/HdmhOjQ896e1m1PknGUkESCLJxStUtZ50cftAuaQVFGm2c3os
 KuSA==
X-Gm-Message-State: AOJu0YwW9I0SdZOg3hywv8XHNquuYQMh6gBaB/0/dJhmV8E+wj90ZC2E
 ZEQmqiWnLaCLns9tyABlSAZp1c8DWGHjQMSa8p3fFeM1vM6Ed6UVuWudRKOpne6p8zo=
X-Gm-Gg: Acq92OHgrfO/XA8HLg4pK6OqsUMuYXVGzR73D+g5QpUhtIzCr/7Xx3W0+jyNSVFyzHp
 0qcbWpVxqMBXdYtLXaXPsKPKwZ8lAmkX/sw5oW8EK3PhnltX2dLT0oikTmeKCzJgnemJpI65eRe
 5hISpM/Gs6s9FmNHaevbOxzMQq50rTryG9ZaZ46ShLyop2BbQvRrMT7Gb6bWSToJylLSohVX2vj
 dJE331cZiZP2ooIlzfBH5m8n0VzmPGZa7EAZPoeFMHZxehQFdgRGPljLjCsiEmUZHg9ZfPEKomM
 ftQ4NUIvlOTa1mllWyhpVbbwDVKZTpaFpqbd3aac4016EFPq3xkLNoTEd3Y0fq2DLl93edZvghZ
 SDuW0sNvEhD8+7bpq3Qoo9BXZlc3sQLKqg8WOxwoVUF/FCmm/sfUXwPSYfvMXUV9XoB3rL/3LBu
 FBWYg+QekCo9D0u8P7vwhIt8Mvtqj96otvNTAA
X-Received: by 2002:a05:6a20:3d1d:b0:3a1:90ef:7e37 with SMTP id
 adf61e73a8af0-3b22ebe1b1amr29589763637.33.1779301599503; 
 Wed, 20 May 2026 11:26:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb114c08sm21385068a12.23.2026.05.20.11.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 11:26:39 -0700 (PDT)
Message-ID: <498188db-167b-479f-abec-1e7967f0b967@linaro.org>
Date: Wed, 20 May 2026 11:26:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-30-richard.henderson@linaro.org>
 <CAFEAcA9tXNossXoMC=LSa7Aw0CZzsmtkppKqEGqcdSgy-X_GOw@mail.gmail.com>
 <CAFEAcA9X-2+_LgGaT3Jf3tC7p3RSH0qRQ0CK_3BhySzS_cxqWg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9X-2+_LgGaT3Jf3tC7p3RSH0qRQ0CK_3BhySzS_cxqWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/20/26 11:21, Peter Maydell wrote:
>>> +                break;
>>> +            }
>>> +            g_assert_not_reached();
> 
> ...ah, I misread it. I think it would be clearer to
> have the float_expmax_normal case be "g_assert_not_reached()"
> rather than "break, and rely on the thing immediately next
> after the switch to be g_assert_not_reached()", because
> it more obviously says "this case can't occur".

Mm.  I wrote the switch to let -Wall diagnose a missing enumerator, rather than

     case float_expmax_normal:
     default:
         g_assert_not_reached();


r~

