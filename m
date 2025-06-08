Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2501C61CE7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOPNL-0004ff-GA; Sun, 08 Jun 2025 19:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOPNJ-0004fN-L1
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:24:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOPNI-0006MP-2a
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:24:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so4684820b3a.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749425062; x=1750029862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5eD+u1ZW3Lr8a+vGQaEredxT+am7OpXo7NrfN7WV1J0=;
 b=jeDh1jeV7P3g9OV7+nJbfhPfqLrr7UXU3gsieCSeZgX5EVAxW6YfTY5vbm9Hy8n9xF
 r4CPHafzHI/YTSWs3dC2yz4FJOKolpCAAy4QICUAn6KFTX6UfYWr4GNrM5hrH/CnS7iw
 baqw1Re7F+wIz1LrVSQgv7OsKSJB+XHRFGHOjUtNYdiqINu4VFRxlLzGOqm29lntZK2c
 YncscMKSS+1s2NEKHY9Cj52x2pjxXLcob3R+H0vjl8hPv3BzZDIquPVSPycL1rQKfvij
 dpEGzoCuapK5Z8JxF+7KczFMnJf/R2pTmOOtd9kpDx9Yozyb9Mm3pAdo4ta9+oNXnqt/
 RchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749425062; x=1750029862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5eD+u1ZW3Lr8a+vGQaEredxT+am7OpXo7NrfN7WV1J0=;
 b=aAcHB6tAnZOUaSysJUY1T2dyFLpMU+80ZRVwdweGlrE9R1jVCFDq6TifwtPD9ZhBA4
 l2KcGT+zl4KpErLzj62S+9UFDsJ1d+vRswk33zip2fNmj2qFjbeio9VKzFJVolq07h18
 0fjGBLuchuZZH3D1r1wyB42m9K1GkhHKGwvw24jPA34BJEYjX9j511GEkdPXDuCPK6rE
 mv00+ot99oS0HG+VFVOKUwxrb4wRqavQpV9Zg9BaECAu9BC1TmyD/P0Ed1klUc4e1Wok
 fn7Wd3j/7KnXqR9VJeSu80SvhWnz32aumSj4g39O6pyfDOUlsTArnjF7Be4F4mZ+Xjpg
 Fg+w==
X-Gm-Message-State: AOJu0YztQRdT34FIO8YbG8t5EqMifKN6xG5uMS75qkGeMH86ZgNtS61d
 6efQefFL0SN0YkoAot6FWsXwjvNYNRvHJSuJDtORJkWNgvqPDo+AW1nsuY9cccciH1s=
X-Gm-Gg: ASbGnctFeQWDub/44kHQToP+P3VuCXUCgL2BM7mQePOtz1nnLXEsFX8QETd6uUOHUII
 vNHjxcGojK/xauld3Vzw99egd/JSAQWo3MKLKHstXfSm7wHjuHKu2OAH0/wppe3Jv8r3UO31q7n
 81LBIjRw9PDEx4VJUf287X7l231l7QL8PPG8zXdWaIt9lrNLRjaWldtS91KIL7O7dbtMFJElou+
 bJx7K/f67mhXFcliUpGwHhb8J8HyATIr6z+sd+QyEuo53ejgA1wGZf3Yuo0t1yHyLZQUeymEeqL
 qUxhGNoMxZr/DE/2sPxXb5BQAMRL/PKXthv2X7VZtxJ4kS4LVYAZBvg=
X-Google-Smtp-Source: AGHT+IGfgKkwDNv1SSIsGICDhijZZpFKwTx0nRTVtkdOGqHWfeVjARjTpDjy3vIx+3Upnh8GhZu05w==
X-Received: by 2002:a05:6a00:b42:b0:748:33f3:8da8 with SMTP id
 d2e1a72fcca58-74833f38e49mr9478411b3a.5.1749425062322; 
 Sun, 08 Jun 2025 16:24:22 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af7a216sm4454530b3a.40.2025.06.08.16.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 16:24:22 -0700 (PDT)
Message-ID: <2a61d08c-97de-4500-85d2-06fd8ba8e583@gmail.com>
Date: Sun, 8 Jun 2025 16:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Add additional plugin API functions to read and
 write memory and registers
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I added another update I missed to v9, so please disregard this version 
and check 
https://lore.kernel.org/qemu-devel/20250608230819.3382527-1-rowanbhart@gmail.com/T/#t 
instead.


-Rowan


