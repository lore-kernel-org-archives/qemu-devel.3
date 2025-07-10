Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8129BC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrtI-00053P-0P; Thu, 10 Jul 2025 10:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZrnU-0007go-Ao
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:58:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZrnS-0001cw-M7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:58:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d54214adso7250705e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752155923; x=1752760723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vS2jT8PdZ1bnP0OsTovS1nsoWvtDLVLST5/TxHYjkg=;
 b=M/pZjqIT+G51XITO/WE9JwZ/1v5LK5TjpHeUpIgEvfDPjEXT9E3qiY3i/DxozYBHQB
 e4D3auYGmLsmm40ZRs/09lQVBuAE3b0qWDX+J1CgjhHbuBB9och0xj0Bh3W2/XFzEYPY
 hfH7DxU704Ab/HEJ0jmXsYYcvTKCcqpPUc6pR7UnY1y0GskW84WkpKV22smg+Hbg0r+h
 HDEjVr0Du+I9/ibgoQjGsZiuPJV5oHv+KrPMZ+3N1f7UGOZha8VWO/lH0UbB05qPL8gp
 nbqR8SA+QYfhy49DDFOiJJHps1LhUlHwvAJUKWyzCfGbYHzjQjloJQLNZBfevl4vWWsD
 Dx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752155923; x=1752760723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vS2jT8PdZ1bnP0OsTovS1nsoWvtDLVLST5/TxHYjkg=;
 b=fBGrDcOHpsT3exijl+2yx+HMi0OwAWV1DR8mmOVdCHtq7apjNzJtQNTMTv58RpPuSA
 KxrGDqJgQDwP2qN4qXRMXSd2o1LKuhkiO6e3WVYV76uFmJ4e0TbpRNnu6X7eGqsTDpbk
 GC4FPw8sCIfyd7fk3qgkRkN3qp2opvogUY9O1xX++D7QSaKzKMzOm8oEh5zih8ZK6dEe
 Klq4yqv8HGRhKodZLsyg7YHljPOzN8UwVFf4zy9oq8pyvBShMEnSAO4ozujWJJYmVkNp
 wMbFupeYaGeBtSZ/CGmhxu+vGkLIretl1bwy0S33GPmK5Xk5w5vPMYs2SLNENmY3NX/P
 q45A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7OftjmGs2zJA9F+pdG3utrKdXxSChz4XjEEAdC6ovJUWPNUYmFEnHtlIlBRN4zW3JN6oC+WMDdwlI@nongnu.org
X-Gm-Message-State: AOJu0YxTC1ofnU5XmKdBZ7fUYBE+y6P73vNJkrF1WRgZYUscBJxZeHyq
 tx87CO1280rFK40Bigpy62CFXC0+EdIzjlVBed3y9tL66ePu3uyroQVzB1TEsNd9fUI=
X-Gm-Gg: ASbGncsv9srYd/aQX8s76axLwqeYybDsPvKsjEmua6prUSZt7p/3F/3tjLTu9LgV2Zs
 jAwY2VsBY5srF0Ti1PAOkeqMOG7PdjXhBsoYYND0KUILFExGudQUo6O2AAvrFZVfv6jFR0w8Xi3
 uXG5woCEouq9ihLvKHRKhLj2XSTp/9FJIMX6szqf7gaQRI0UGOdJGdZSliWWlddw3TIRStrSUBP
 ga5rdWtzGq9swjkFKZOsFi+jL912LIXTGXJTK9P/MNr8XqF+gSoIpn/GiuktDf6qDGCJZd9uwOm
 9BkS97C27sT4XORVS4lVISZxJXipnILnhBXdJiyaKp6XTAsl/4k5uqQZoXi4N6QeXEjB4lo/zTU
 ubMgfFELSsL6wOmt7+BRgWxoU2hZwz/1Iv3RSK7vkHqmJX0Roo1fDnwR2uVU=
X-Google-Smtp-Source: AGHT+IH67AnxS/qY2jvNqf8gsKraz777Bn/lMLz5FvVh0rgq194sGI3lyUliUXGGz0pxYyzVM6zOIw==
X-Received: by 2002:a05:600c:c4a3:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-454d53a63dbmr66627805e9.18.1752155923447; 
 Thu, 10 Jul 2025 06:58:43 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd538b63sm20808805e9.19.2025.07.10.06.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 06:58:42 -0700 (PDT)
Message-ID: <40f55de4-7eb2-4a83-988a-b8ef3e342075@linaro.org>
Date: Thu, 10 Jul 2025 15:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement fchmodat2 syscall
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/7/25 13:31, Peter Maydell wrote:
> The fchmodat2 syscall is new from Linux 6.6; it is like the
> existing fchmodat syscall except that it takes a flags parameter.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: don't bother with trying to fall back to libc fchmodat();
> add missing braces for if()
> ---
>   linux-user/syscall.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


