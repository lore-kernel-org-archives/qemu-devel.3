Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYKX-0000hj-Tu; Wed, 24 Apr 2024 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzYKW-0000hD-3A
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:50:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzYKU-0003qV-4j
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:50:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so5807044f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713948607; x=1714553407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PgWU7c6xVvq8dMmdrX+1j8bffq8+CdDKO0rLzq/P2qc=;
 b=LtqrgEDUXOgwAZ8qISN5lpED1uQGxDuA6qPD84x5fKynQaKVylzOKr3yLUWAm6JKQa
 IqytwKAdOLbf/emE+nLrxtANqi+97nNX8NJWNgQ4kH0r81TkKJICJ8SkHKjLPW6fqNpi
 Xn3nTqj5DwUs9RlofgMU1NPqTc2uB7r5o9WAzYz/m4zbTpxu2OLqYouB/YsJfArN6+7a
 FbICwNS7D5Rn/ig7L4R9LwfqFSVhRYaYUMj87npv229k2T2M+GzRJIRHQfegArX6ZtYJ
 N13WFyU5+/5ks2nNBu9MsIvfEiNGxRf558Ta+ViKbYSofPS0kzq50st5XiihsJ5O/Lrn
 KLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713948607; x=1714553407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PgWU7c6xVvq8dMmdrX+1j8bffq8+CdDKO0rLzq/P2qc=;
 b=leUmqfjVplEDo+EqCND1dqj+ZbAWkNbI68h6ilbzq0g8dEzwrge66ztKdbUzC8+pRg
 zMkcARDE4znlZ5Pe3pCwhyy86gr2pf8Ykynu+RVk4xa9VJuRPp5+NA7is8ZlbxwhS1ZS
 r6qOqFyj6ed2y7COcybPv/0Vg7KO0YW10WGpH9FOiphcyTmc5tfR1e67JzX66UoGlAVq
 Z75DuOpVX++Pyk8aseiaYFVsBZuB8C7y/3KxUuuRKcI6w2qkIpWi/Sc6xpPaTOxHqXaZ
 QioyLSVEOrLnZJwxAaciOY8FF4i+24oFDIzpukAdRAH65smRmx3fggFmZHFuydWIj9p0
 oSww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDt4UL00eRLCb3f2J98EJDqHeSha5rsWfsFszmd6zP9fgGOJeL4AfTewiGzjtp3Opz4YAW24OJcFi6jHFTt0fUUQzWeTk=
X-Gm-Message-State: AOJu0Yyp/S2DAAx67s0bRWtwJEzQG8D02MEcVcrU3ViTA301udfQgVLT
 H+jZ18d+yRQPtJSCuV3j83+0dg1ohyHa3MzAtDDfnjUtuzg41iut6qRCpN/G+/w=
X-Google-Smtp-Source: AGHT+IFY1/DP7cv6eF9xfpq+bp1h2hGHq8PAG5QLGtZPueoSl5xUiP+USkRTVM7XxRz0njkYs0XT1Q==
X-Received: by 2002:a5d:4fc4:0:b0:348:1ee3:48fa with SMTP id
 h4-20020a5d4fc4000000b003481ee348famr1181988wrw.47.1713948607620; 
 Wed, 24 Apr 2024 01:50:07 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 n2-20020adfe342000000b00343eac2acc4sm16538025wrj.111.2024.04.24.01.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 01:50:07 -0700 (PDT)
Message-ID: <3688d32a-a265-4d00-b698-ca2bd71d3342@linaro.org>
Date: Wed, 24 Apr 2024 10:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] target/nios2: Remove the deprecated Nios
 II target
To: Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Sandra Loosemore <sloosemore@baylibre.com>,
 Chung-Lin Tang <cltang@baylibre.com>, andrew@reenigne.org,
 Yao Qi <qiyaoltc@gmail.com>
Cc: devel@lists.libvirt.org, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-3-philmd@linaro.org>
 <fd68f7e5-11ed-4459-96ac-b4a417dc9aa0@linaro.org>
 <892a0a7d-5f74-4207-90e0-e747be0b3df1@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <892a0a7d-5f74-4207-90e0-e747be0b3df1@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Marek,

On 18/4/24 14:04, Marek Vasut wrote:
> On 4/18/24 1:10 PM, Philippe Mathieu-Daudé wrote:
>> On 27/3/24 15:48, Philippe Mathieu-Daudé wrote:
>>> The Nios II target is deprecated since v8.2 in commit 9997771bc1
>>> ("target/nios2: Deprecate the Nios II architecture").
>>>
>>> Remove:
>>> - Buildsys / CI infra
>>> - User emulation
>>> - System emulation (10m50-ghrd & nios2-generic-nommu machines)
>>> - Tests
>>>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thank you

Thank you for adding NiosII user emulation and the
10M50 board to QEMU :)

Can I use your Ack-by tag on this commit?

Regards,

Phil.

