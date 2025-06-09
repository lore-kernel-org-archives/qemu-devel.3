Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A94C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiON-0005Tv-GP; Mon, 09 Jun 2025 15:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiOG-0005TC-5o
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:42:41 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiOC-0004jX-6B
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:42:37 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3138b2f0249so1030258a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749498154; x=1750102954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HH31cQvanv0VcVTnKjzKP2d8HhvfOkFNhLUJLEq3rF8=;
 b=MULDqiXQXf3pucF+P3OTg+WYhI9t3YA0M1LhjKECeLqKwAXBou4MlRUWh+KF7rcoNX
 vyheDvHUcmOospmcPoKNdxx0HK2FiNJ5Z3VnoDg+uuib/b1THfCdbjid5iFexq/BGquf
 2nE5D1/s16u6B8V3Fk4/snGLYyefeqZaB1RuXE33I1S94EBpbcjtHPfmYKaMWj9Vk/A8
 7o2Ch22jv3zQCqbi2ifyJdQ7uARUDsBJR//EK6hMT17V0q4QwRnWDkgB3wLx8jWn9FEN
 NXcY3qlGEMmEGKTOAEYHho5wbIXWOUWPmCUNmnNf6fhhbuTlPG9h5Z+qXkwn2ROh2uW6
 WyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749498154; x=1750102954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HH31cQvanv0VcVTnKjzKP2d8HhvfOkFNhLUJLEq3rF8=;
 b=klwx0hUvAuMmT2hTA8YZ166l6w6FQzweXDYJZIdUP3L+alMwYAKXQXkHEyiI47kI7X
 es/mBlTWl4chSKqZVsPXyfAs2ygWKl3Fb++UCTy2FWnqI/TCja/rgkSqVdQBwyDcGANo
 odoN3NMKQnrKYNhiljppPutO5z7vghTfrVgzCnsDHhPLErl3sc9mVBML+mO5BePBaOtB
 vQg53ZWnusV+pPZOweIY/xA33T0I8z7Lr/pTJr0RXWzbYLyFAWM9Nie8pVdpaJ4/QVl9
 I+A86Qg1HsbLriZVPWVfRVqxp+K0h8+HonNT9pF0RIriOTjM9cujexYiD5q0ujQG1GtW
 w7gg==
X-Gm-Message-State: AOJu0YxOgM69hpZ9Nn6uIP5RQ1lrRZ8Idhb/SYfHMLGdQRo1vf4FC9MI
 pICn5nEx1u4kq8GxTQ739lIGAc2nW1G8bAquPUcMHpCrg2N/j4YMCasUNwMhqbczTOs=
X-Gm-Gg: ASbGncs7SdJYvaLxwCjTHVRO4t3ofAisnhW1leLXv5mmerRHmY0dtcZuZRdsGzY3Oaz
 fWQN4JMZ0hT/EuUUBx7jCjXMCPs/maGAvmkwOhyyOnJY+E2wLRrZWWnn6udF2ybN1RnHEl0+yam
 kTuIskbqFeNOKOY4SbhpBNp1vkEhfVkCnef3ShvbuOEX4OTlrvQAGNmzICke4FioY1BWV2pp36r
 GB8zS9GwA6/VbA7LPQTcfb9A3nBCI3b+iWV7YMrOQREbfvEMu9u1qqHwGvS+EWuWpI+/G+DfRCL
 8KRautTM6zbUqMnYnDFJ1lEMzuHAyYCD2ZlXA7zNTpoAmM/VzaNvqt6bayrgcl9XBQ==
X-Google-Smtp-Source: AGHT+IH2Zcj+pQE4S7NJbviVPML2z90+aE5/XWha+5g63mXYeJrykM7u+A1Y1oGsJEUAZ8oweMEZhA==
X-Received: by 2002:a17:90b:1dc2:b0:313:176b:7384 with SMTP id
 98e67ed59e1d1-313472fcd74mr23995257a91.11.1749498153730; 
 Mon, 09 Jun 2025 12:42:33 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f1910fsm6080921a91.1.2025.06.09.12.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 12:42:33 -0700 (PDT)
Message-ID: <d0ce88b8-235e-4475-a387-676eed3d2894@gmail.com>
Date: Mon, 9 Jun 2025 12:42:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] Add additional plugin API functions to read and
 write memory and registers
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102c.google.com
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

I've addressed comments by Alex and Julian WRT the new restrictions on 
flags for calling qemu_plugin_read/write_register by relaxing those 
restrictions using the same system for setting and getting the current 
flag state, and adding a set/clear before each callback invocation. 
Please check 
https://lore.kernel.org/qemu-devel/20250609193841.348076-1-rowanbhart@gmail.com/T/#t 
for those updates.

