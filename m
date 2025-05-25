Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD85C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD7O-0003xZ-Bo; Sun, 25 May 2025 11:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD7H-0003vs-HG
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:18:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD7F-0006sb-W0
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:18:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a37d24e607so1444656f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186300; x=1748791100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vr/pbhByActHs1ar2a+X+XNZlO98ZE1daapFhpfPLRo=;
 b=rKl/NyZ7R1m8GhRtphxiKWay5qdRAPS9+BxLbUkFl/MvyKHep8Y96J4IqyJTauymp7
 +0QOOjlHRm6ZaMDEqFQOdg7t35VjiYlBSsZCtDwyiusz5DYShPVdStBtRFq5MKAzPz+l
 mooQf1THcDQneCYd3dPYENvUNIynvczaT3W+ui1utSTMsjxobzRxy8g7qLMdWime6alm
 uES1dSCZogDUZSQPzj9ffk4RXYjF8XHZRXmdKBuS/3SIPw6RqS6JSEgUHwYXqH83Tl6H
 tCPqun4fSAylvsgyO/PMckRJ4NIijiL1yLc7fv8K8aH1lusrq8hSoYSIJwyR9vqeshjJ
 2tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186300; x=1748791100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vr/pbhByActHs1ar2a+X+XNZlO98ZE1daapFhpfPLRo=;
 b=pzilD7IBv9/w5a9U/VjPSX5mXfhgFyll4oOTMca8vt/N6y2s6jLYQJEAGD+/vJAPOl
 490hg1P8QfKWMiBOsDOqvHNODyTEgzIWSz7zRieMP1c5YWeT2pk+rv8l+A7HIqOt+H3P
 MnCso72K502bNQw6mkhH3a+WMgR7UL1zVG4gO+8NLX6OdwKDFywDHJPTF20qmZXfHKpz
 kdlLA1Gwfzt8zIrHewedJ+9NYFfdSEnhLvX9fevmk/iBkyhmpHU+CDXfibVIcnFWC0L3
 vIvU8fx9E/MVNTN4D+tbvVlmQuH9JyntnKJWhWSj0jcvCJluceSG8hmJBnZnXEWlkRBO
 VAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfrlxE+Uacy58JBxVDs0V6snwq4yWp24h81DEZzqXsSf92dHm7Ed7OYc7aGT3d29ND7HHVOMbEzrQP@nongnu.org
X-Gm-Message-State: AOJu0YzFsRDDJu4Koo9hGyREe74Rmp/tqyKVwiWQko744mUYFHEhFywA
 z8rRzXapTIqJ7IB8q1w3XQl/uRUigdRYTiIzD9fnWpEmo7GOu+VXTE0pYQ0sRfOvpWeT8+U0jP3
 7ChPr
X-Gm-Gg: ASbGnctBMU+9MfLIkX2Uj7yUJBGxkqWuO+wCHeXw/l767Tqj6iw/fRKW/PLfOm1TXVP
 ZYVu7B/wfKJYSJSuGUNX6DKm/Dw3YMECssvgZ5/3sS1FlJaeTWbQ4jzrgSYdEmk1IVkftPgZxjA
 Y8D1b4+jvappmuOA2a1v1CbNK5T80IYYj/GJEVWL6IX9sOVeoERx+9Luaj+1tU6n4swKCPXBBli
 +Wr7MyxiSlinY5XmzlojB/ZiBQ4hyg4TsUmL2AjcsADllECumDjjNlTXB+DQtqDZs27BgCiz4SE
 4Kvs9tJG/RGgAuM4GuY4vMUCtE3H2O4Gl1yMBLV5elkjdIMLae2dVmyJvCY2DHjIsRBtOE2vn+K
 FrCNhbz2LS10+BrCP/n6UEQWSR4U=
X-Google-Smtp-Source: AGHT+IGyuAiJfDtlqmc+S2wZPDOgMF9AVZEuWH32nIsxuPwYIQU0kga/d/mPrOnThrsXgfVqaMl/hA==
X-Received: by 2002:a05:6000:2503:b0:3a4:d048:125c with SMTP id
 ffacd0b85a97d-3a4d04813ffmr3831852f8f.35.1748186300377; 
 Sun, 25 May 2025 08:18:20 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ccc2c88dsm5076314f8f.69.2025.05.25.08.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:18:19 -0700 (PDT)
Message-ID: <41694d45-fac3-425c-bef9-7ea0ec1cb773@linaro.org>
Date: Sun, 25 May 2025 17:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] tests/qtest: fix igb test failure under
 --enable-ubsan
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-5-alex.bennee@linaro.org>
 <acc76a26-d6b5-4ff4-a8d6-3595873157ea@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <acc76a26-d6b5-4ff4-a8d6-3595873157ea@daynix.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/5/25 06:19, Akihiko Odaki wrote:
> On 2025/05/22 1:42, Alex Bennée wrote:
>> From: Nabih Estefan <nabihestefan@google.com>
>>
>>    ../tests/qtest/libqos/igb.c:106:5: runtime error: load of 
>> misaligned address 0x562040be8e33 for type 'uint32_t', which requires 
>> 4 byte alignment
>>
>> Instead of straight casting the uint8_t array, we can use ldl_le_p and
>> lduw_l_p to assure the unaligned access working properly against
>> uint32_t and uint16_t.
> 
> I think the subject should mention the problem (the unaligned access) 
> instead of the method used to detect it (UBSan).

"tests/qtest: Avoid unaligned access in IGB test"

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


