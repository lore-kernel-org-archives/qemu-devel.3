Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B1DC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSx0-0007rU-At; Sun, 23 Mar 2025 17:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSwz-0007r8-Au
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:33:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSwx-0007ST-Ft
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:33:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1868450f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765622; x=1743370422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ylrQWt0h5xEFAM4qqxXZohKA0hkHvssJF6C6Kbk9mmA=;
 b=sp3GMNqJ1o1gmiU9QtNkCQQgj0tRh1RVOeguBL8FUNz+P+7yYwzOXrygxK083rsJf0
 R6PIk4XjggsbZF22BCnR+n81IR3xSu6AmLFZyEXSmDsAzpVN+EsA6J42ff0aoo0wszCc
 f6nKcsdaPAxPNKVmtgdP7Ej/ZNhZt8+J0rYxddl+Zq2DLDh2uBOST1/3yM/BMMQt33je
 qN+YO7IwEsUhDcIFHGpV3pV3U7VNyFVkURSFN7m9ohP1liH/6sHWZc7QTe1/VIBMfZ58
 v0FDE1YUcGt/9uIesIJ/fQLg+9U8P1hmMmAqVoxzszUkchlOiGiN/ye6ysAcHKRcvqpd
 ynpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765622; x=1743370422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylrQWt0h5xEFAM4qqxXZohKA0hkHvssJF6C6Kbk9mmA=;
 b=eAyIW9moIto8WPg5r9Sw8/ECxbGRgeFajKi8XIpP/iCXhLX7jaVkiSSRx3srdAkfjd
 /rFUNdigFYwhVy9lYoa8TNtZ1Nt8DSLGZyG3aBKHCnAuE/i3S2WiYhgbrSPGZqbjmvYA
 59KNEYe4sHP1Lww3AMgrgBIQxFz2M3xwJgwMxLLmH1uAT3wYYiyqcf9KwFl+x/Q/HYdT
 Yho0GT7YOng4PtthdixnRc3OjZoqSZwh8hmFc5Ykob6Csq5babuxdkh7X8CwBYqB4cvA
 ukUJuG6r8RYtV5gR1lU5VSoXBwlDlhiZ4nZp8x4SsDoF8XoL7pbMITUWlNVZvAFgu7bk
 XzLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6a0nhPZo1qOOWhQXc1b6M6X4BcIpG+ytCzkC95Vvp5ugyh8TpDQhrt3/IcWpf1YBQaZz1JnfEmZrQ@nongnu.org
X-Gm-Message-State: AOJu0YyftFwyLyQAT6dRiX/XMXATqDRVGFEcc1d86WUiWYGFqf9B/yGU
 0xP+Eue6YNx4aE9evZk5KoK+oYzoRg64Q/KfDkOdc8kK+oZ5Ejwnx9xU28TJVvI=
X-Gm-Gg: ASbGncvAtlh5DHHI9Va029vrMwTL6SscTGT5Tiujk0m+4AQQzIMs7StZxdoGP5NWd1p
 DMiBdEIKGGvwK71rHYyNN2wKszN2XG5wFhNZh2hhevK9oeSgI1C6Dj9+iKN5ejQBprwacUSE3Y0
 l48PinGBQ78100B8A4t04Ew9P5w3DFuBuss4dZyVbqL9a6F6WBRJ/M4sd0R922VZ96SrRt/Zryu
 1yAqMReAu4YbEMYUBE3+eiofKN9FGf4soz6Ic7FkB9T70q7EaAJa/4yQ2/8cafEzMgVEvQ3IuHU
 d6vjQ3/PTA4TZ1L3YoDeFLLgnkthJrAnjHaaTPESAWyDUATF+uK4cvCOxqT928tAs5xfGJaR6Sy
 0LsaiUH6LRqP1VchScDnt6JKc70RW
X-Google-Smtp-Source: AGHT+IGL2p+2DDClV120nNCBzXLwXmnenwwGwxKTGjZlUW7/6v5y1fp1DeVlOkVmyjrSBdWYWUkUOg==
X-Received: by 2002:a05:6000:1547:b0:391:2d61:4542 with SMTP id
 ffacd0b85a97d-3997f8f2855mr9329673f8f.11.1742765621930; 
 Sun, 23 Mar 2025 14:33:41 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd277c9sm100932125e9.22.2025.03.23.14.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:33:41 -0700 (PDT)
Message-ID: <034460f0-b789-4e5c-8008-42c44d677eb2@linaro.org>
Date: Sun, 23 Mar 2025 22:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/avr: Implement CPUState.memory_rw_debug
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-12-richard.henderson@linaro.org>
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

On 23/3/25 18:37, Richard Henderson wrote:
> Prepare for offset_io being non-zero when accessing from gdb.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


