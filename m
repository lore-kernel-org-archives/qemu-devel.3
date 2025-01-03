Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5276FE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTieg-0004nh-LT; Fri, 03 Jan 2025 09:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTiec-0004nK-Fh
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:27:59 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTieU-0001WK-FO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:27:52 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso13591639a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914469; x=1736519269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5p9SkT98wbLWuImiaUJLXHc6NHbfqtSch+TPB5Qv+H4=;
 b=y29DPVBM6EYVO0LR9peN/t1RCaXVqQWN0dXQzpjL8xyzZYINHDdUQiB1O864XYYEmh
 Ybn/5OGxIe+VE8ift7J/uiOreUcQ9blSCqIXT32vCw0dxe/L/DUQNdZGdo+xYmG5IkI4
 iU/mMmtRu/psFCfKZ76zZJfnTU+ssr25iK0oPSQLceW/ULAXwXwVwig0qWQ/osBMSUaI
 KSbEkjoTzZlc/Redgok1LSKqMGlQnF5iW3gN4T3Bd5usFdPmWqcOYb6IfVt8DYGXhYZX
 8o8EBd3JZu1OLSQehgS1KGS5dpKp/rE+Ndic0ut5iHp5aoUGSDQcW+pDWjfs3XeZiiGp
 rwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914469; x=1736519269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5p9SkT98wbLWuImiaUJLXHc6NHbfqtSch+TPB5Qv+H4=;
 b=Fy37+3I/wOr+GnF9GfPDSilAAi2kj/PokoNodv9xP9SEn9UjvesrE0684xroFQZJ2D
 r+rZsP+SuYWkZYQmw/wgGXdHxTGb88JgQp+67CkhVR4GD6SRbdaaqvMxpqZJKLlmj4US
 +8bEsAer2oLeo5JV04QdefpQZgKSrjFo5u6dac3riu9VoHKx0j7CbYx5/1NeMmTEWBVh
 syJxqlfw0rz4pHmdvctUyqNM8mGwsPH+1V62xeJiNfZPUl+UMW0nJvc0475lLNJ4URS0
 QqvySO/ZYVgbxvP+03skIt9iYr8JujmDQJb3tZTsmPMSYn+2IVNncaWd6QsBPRhQDJHq
 HmtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4wPAa3CFoeEYnHqT0sLqfLLuQiCMOwci+ggzuehJcotkJocVDcitZck8wyqM1Rvl1yR1w6S2RYgA9@nongnu.org
X-Gm-Message-State: AOJu0YwN+StNFI73KNTJI0xU31qXkSgRBQjjNS9rtqjh/u+CjaMARUTd
 T8GgfzGZGJYJN/+x74399gZ02mek3sVeHsL3lmtoLcU4EzWp9Rp4h9vkKMh3oKvLK9qPgWJzykg
 Z
X-Gm-Gg: ASbGnct/QuIYayNpbUHWAa91aLacDjBALYuOwMhNJZiZ6PBILw53U95+INCxoxZfE3Y
 g/6D3jjshoSF4bX1ETYpeumHqbg6TrcyEkAdn8QyE/gCDQOlpfeec6x5Pektpw4wvzlksqxqJFp
 pg6uIekRml75LvTtXHXpt2stcQ9FavXg+pnd8BVnVh9cbuOwm6jrtb9ntFUp2HgmS+Ahzf4ZYlo
 0hB8h7ULWeWHTSzrXbHbKfwyVQtpztlavYzLJlC7l3PsMlE0gt8tuw6Y1xUvF1+omShHQo=
X-Google-Smtp-Source: AGHT+IG8FyxxWVzFeWKYKMAW7YF4iar+pooe7FdHlcB+NCaW5uhimOWXV1Qa0sK3emxCrmIJrNTckQ==
X-Received: by 2002:a17:90a:c2ce:b0:2ee:4513:f1d1 with SMTP id
 98e67ed59e1d1-2f452eb24b8mr66390191a91.23.1735914468836; 
 Fri, 03 Jan 2025 06:27:48 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52cf40sm33453048a91.1.2025.01.03.06.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:27:48 -0800 (PST)
Message-ID: <483b30f7-1205-4677-a9bc-53e8488c522c@linaro.org>
Date: Fri, 3 Jan 2025 06:27:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] qdev: Add machine_get_container()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Add a helper to fetch machine containers.  Add some sanity check around.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-ID: <20241121192202.4155849-10-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/qdev-core.h | 10 ++++++++++
>   hw/core/qdev.c         | 11 +++++++++++
>   2 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

