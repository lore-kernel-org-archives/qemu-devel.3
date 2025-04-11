Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08779C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ee2-0003GT-7H; Fri, 11 Apr 2025 09:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Ee0-0003GE-S8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:42:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Edz-0002Ax-DO
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:42:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1182119f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378924; x=1744983724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qHVSwHMGqo30ydWCmy3wUs6OU36WReUvV9ZmQvWtsk=;
 b=px2F+3M1Z58FuJxjdhAUYuc3um48rnLTh41AuLLNXydSZrntsg+pxoIywuiZLmdiUS
 qgubeV+6EN9roTFFbvbojojafVImkb+s7K6kCXbsrqLAzcufleIwbNjZXCm8IBoyFfEI
 DFEBsgFt2RgUgAO8hcBhQ4D50T/Jr2RUgHen1qDFuYjJfVMx/48cABcaf14S5AYeQCp5
 BmkPWpbAiXB4Luo+MuS3akxcWTUo4TjyD3Ycp0XURhMaXF66qxV/X8CqmAhoWyD8TFci
 Ge4vDrbBlPvvfUOqucvqiRS0LmihZSV/WysmtdTK8i1XU1Pk/SemGKN87MSgYKy6bBkX
 WmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378924; x=1744983724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qHVSwHMGqo30ydWCmy3wUs6OU36WReUvV9ZmQvWtsk=;
 b=JVzrUZgThphIR/L+l9cmjChdfBXrAtz5Coie/UJSHJ2S3RBwK8Gnz3i/+oa5gzlArS
 ul332pVKyJ0l1QIVAl4yDBxEnOASBk/S0WIOC8DieJ3kiC7xENocYdJ72R8g46QYsvUn
 xhMg37xoXkkhuH2NBP7YJWbwS+WBIQClDTGVl9uQafqRQld0DhlbJ+LOxVVPVPwJFYqx
 fVkJ6epvI9Gx9WxSlzKwAifgWl3Y70KxencGL98WA4ibGSh/d4rlrTj+H6QquRKfqUUw
 7YL6m9QQ8uOEFj1qdumeIioUrUPTnrE1Wl4B0iHkR8t3qFDjb2WrXz9w24MSONvW28X2
 erdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1lwn8juGzd8+wnVghHQ5Zg9kHoe1bSdZ9t10tTm29w32jfQ59U6qwrSeRB8rUfcYGr0sm+EydetGL@nongnu.org
X-Gm-Message-State: AOJu0YwMKZ9K8TjIiAHpx5fKdKWQpiI0khj+O8raYsDwuPfTwBzG0Z6H
 4Ru8EcxK3topsz8IWu728LtmAbZ5bFDFWKsgoEq5vc/vLuuYOaUw3mJ+9Rzj0M4=
X-Gm-Gg: ASbGncvYno8LZPXQ9FNgfatl0S3sccgstMUSI2mao1mHumQBZcXTyuvl0RgtsOGjHpg
 nSf1eVrXq8rMH/61img8KW7/imNFC3kOOtsOmzLxGjSlYnAjHQl/knHvCEe39/nPsN9yP8SyEfx
 R7mTImQEWK3qCrQt1eHNA9o1+SLQjzEKpSlnxBfdLAHcsDk0ehvjxfoG9xlAv/X2myGDAmD3ATt
 uqatfARC7rgpX3kIYxwsXlEs3oZCOXNkH566IvnnxXiFAU3Sv1pzpBeBJW1PzH2Ip4/F0BhU3xz
 lycVLAfAwrKUz6VR6x432KKe0XaNAmQDT48hKIt+fK4EuHccN6U6vVco46j338gvN8/VmrCcXL+
 lyxW0Uw3yAyQ0dg==
X-Google-Smtp-Source: AGHT+IFCzYH9TeNmyE0jZCkHHkkdOTQQdyXwmeAQTAyAseqNR15GNMtfjF6kJiCreYHV8ZCDgqJYdg==
X-Received: by 2002:a05:6000:2282:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39ea51f5c52mr2392976f8f.17.1744378924284; 
 Fri, 11 Apr 2025 06:42:04 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206332d9sm86589085e9.13.2025.04.11.06.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:42:03 -0700 (PDT)
Message-ID: <63ba432a-31f8-4189-811e-409bb6a5b9be@linaro.org>
Date: Fri, 11 Apr 2025 15:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix record/replay on MacOS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/4/25 00:55, Pierrick Bouvier wrote:

> Pierrick Bouvier (2):
>    system/main: transfer replay mutex ownership from main thread to main
>      loop thread
>    tests/functional/test_aarch64_replay: reenable on macos

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


