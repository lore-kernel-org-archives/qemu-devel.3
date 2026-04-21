Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A457DF327B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF67G-0008GK-9n; Tue, 21 Apr 2026 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF679-0008Fn-6p
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:05:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF676-0001aW-SX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:05:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso9560055e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776758743; x=1777363543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ioNpLyRL2ygl7Q7zyz32ip1tk+gDnNfqbuS8W1KPjWc=;
 b=ivfzItslgeL6u/Oa7F15I2I0+IvCGXW7s9xAWsqrKEtDEX71fNdBLnDy3ClqauM1M9
 YSsYOUP2NSxsXcD2pEHIytE8pf0zlCGQlMieLeqpnHBDpIMzz0MQ7Mb1M7Rq9V81i446
 TmzO5VCINOJG65CfiJYHtmXOZ4ZkayNIQ1r+gm0Cr/gS4rN7JHhHFUakS+kQQhGkouhr
 t8BIdWEwobi0l/S9MbpE/yodpk63+Sp4YoKSNsXBy0h6N4+xEXiP+8lanTv2lh9a9UG4
 WD+tIEH4XDve/qSi32DQB4XWzBcQXugKlIDM0T2CrKkt8o9vd0EX8ThGYamN/lLwVqD3
 A25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758743; x=1777363543;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ioNpLyRL2ygl7Q7zyz32ip1tk+gDnNfqbuS8W1KPjWc=;
 b=jE2Yq/HedbCjZXtIYZmBRUAkJYY9Lalw0nU7j9JRx7vD27H6oCN6a32AQik/5fxc9p
 CjrKddfUoIPpYuikxtdlciiM9nBTrykAsLnzbHbFpFNKo6OPQUwVaYqr51No4JR2aGAj
 I5pDWZYlDB9QKcWqC1v4mnNmdYG2GDe3DF3W6qgBipSjPuHOhn+ZV7kpWNHnuCHiCHBY
 eHS7HijI2BTw8c6OUm2g0DWtutaL0I69qcphx19HZGt429YghAMceh1VF+o2KpUROi8d
 BEZcErOK+26Td7XJ5ZnbiQc4g9W6aDBSd4jfX2pz+1Qy75JQIQewrHnPibQ2kfbryyAZ
 3bNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yInsFO7rPNfooGh6u241Mldiez+Ah1GlZrop5JNaEpQcY/UGvJ3qJ5ZUZOZyM5KrXxKoedvADnf9P@nongnu.org
X-Gm-Message-State: AOJu0YwxCoDKI39LvpzQZZvzIEsHQLYsXiwkIoPUeb+hGaSgp5qyAfWv
 Ap0OXqQ8jc3TInvHcOnTMjJDfTG2xN+IodhuNYu38SE+vavb+kccLPjU/laodpicGtY=
X-Gm-Gg: AeBDietLw4NOqZq/6UJ/tZqOYoiO9QyvAqtCD/b6xxHTynPKN1JHHKzJtB8APO4TERN
 I3heb/r4rGEgHRaZkU/uf+O8RAo8VLpDSnendqMKUXXTkhLi7+6NrP+RKbwnaRq0K0dAFEO11/w
 rlKwcRPOq1RiiwCWDuBLQZDT88GprBNJdJWcF6/Zg8iNkVx7i6BJT9ukOg2RokPQqi8G2BTY1M1
 wfhb2IgOHBSc89zcgrNlEWwAKf8+zSNraKu3tq6UJfT8Q8PpAFHXKgtI0r3cR6mQaNbYAZouumj
 Z3m6KrejWM6tO1dtSph6iT1Mdvy0pX9q6WLAAaWARX8vgvsiykaGZ7Y8TefTDQX8jFiVag+gO4g
 JiGkAEFAVS47Cw7RJGT4rPlAgp9Bb2THxWgzq5HjKjuIW1CX2YPlSuxZXx0g1AUY/ZGT/QVv+Oc
 yVT5kxB3Q3s4JbY2suzqbnKeB+Itv6P6Mal36HIN0l7RXHU/xUTlEGObMS67k39Lbx5NaXfrgSO
 hwZ
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id
 5b1f17b1804b1-48a563cd0eemr16579785e9.7.1776758742189; 
 Tue, 21 Apr 2026 01:05:42 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm111084025e9.7.2026.04.21.01.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 01:05:41 -0700 (PDT)
Message-ID: <57762b70-3bd5-4e83-b7d1-2d625c1d4ea6@linaro.org>
Date: Tue, 21 Apr 2026 10:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163452.327350-2-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420163452.327350-2-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 20/4/26 18:34, Osama Abdelkader wrote:
> exec/target_page.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/hyperv/hyperv.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks.

