Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5573D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cSV-0002Ei-95; Sun, 20 Oct 2024 16:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cSS-0002ES-Ft
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:23:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cSR-0005my-1s
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:23:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so2704983b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729455801; x=1730060601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dwz56yw6c7xZVb36WUndNgB2zhr6+UiewTcdZh3gvoA=;
 b=cH2uxdAS2Q8wZuasm2NVubRwF1OFvvYgA+3G8jSh+CNXTPJ8h39Te7G/6Zds7eIsR6
 HX0UFWvQAiLoiMCtbQ9QIfKpdQHuiizGMTYXCBNC9dOeG78YQGCJuUbCRvMJXaPW6eo8
 gdphcHhKpEXfrsBYUd+ETbX9m5RkwnoSlyB9C3roWte00d2oe4O3wkvvZ8B86dV0vANX
 i62+TWwBBxe0oreymaaN76z+inB11Aah473RYabjK+OVcoFetPjej7qY+5uTElPja3NC
 U9ofXg99VcR1EsNzaLhVODtmlERWE/zCf4no8WvMNtbRfQ6FnSVNLUBnVULpFPMXI8AM
 +anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455801; x=1730060601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dwz56yw6c7xZVb36WUndNgB2zhr6+UiewTcdZh3gvoA=;
 b=YuCztvcotoovEQesPUImFSC6ktPeikH8j1pg5OvbBnhmUwu5MRBA1kxZ/3b2gNqyKU
 69/n4QyZTOrRVWuEWssttmejHp1O4UROyocN95Lo9IBY9ib9fU0x9OituokmdkE0U6Hn
 eKn0/OINJY81043tmJlqzaHdWIAk7NUpviFFEOtxJQ779fkXEuhu3pusxJt/433e4ZQK
 TtKZ0TlId63N/0RZprTiBTcDM8X32lqqXO6P91ummm9JAv6ABAK/29yb2DURqyXd33kV
 KgVcbYWjqehu4AYqiSeF/mXZZURcA4HT+poMXmsVl+I3lfOcchj4NPzE9r3i6RHTgEq9
 V9Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7tl9z+TqQ6XcNbKAe1PZtA6Fuzk1AGMuSBpSRuUaT6qVKaODJiHOgs0jJzzPBs0Sx9mtr354mBVAD@nongnu.org
X-Gm-Message-State: AOJu0YzQIj8G25j1PWqOyu4Zfs4LveTmIdByb6C8rE/k2oIKZ78xEZ8Q
 o8NFMbkkx438zjywpESK7oVS97t8nd7/rIrpWCNah0q3iWVVe4BgQr/KW1HIQyuQcgCnnlshuC0
 w
X-Google-Smtp-Source: AGHT+IG5Q0LAscI8TZs6KozKMrMs6ooyYNPxSFXGB9j8UoDOzHBi/1bJ7hKzQ0MPD1oBneiDnIwrig==
X-Received: by 2002:a05:6a00:cca:b0:71e:5b4a:66d4 with SMTP id
 d2e1a72fcca58-71ea31fce95mr11320731b3a.9.1729455801250; 
 Sun, 20 Oct 2024 13:23:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1312df0sm1529708b3a.20.2024.10.20.13.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:23:20 -0700 (PDT)
Message-ID: <27f9ae0d-e3c2-4cbf-8d69-58ce89850284@linaro.org>
Date: Sun, 20 Oct 2024 13:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/i386: add a few more trivial CCPrepare cases
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

