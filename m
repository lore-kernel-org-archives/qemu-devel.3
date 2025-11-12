Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9627ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ6IY-0002nL-81; Wed, 12 Nov 2025 03:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ6ID-0002ku-8d
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:33:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ6IA-00010d-4b
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:33:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so4041355e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 00:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762936404; x=1763541204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qmmwg7B3/mG4SkMgu3jo22uLPe1oOewXbQ98SlU/dbY=;
 b=bk+ItkLfW5jT3eQdXdwuEOuu+kT7RuHKyUUmjumOYNMREcGW2Ew8BicWXY/V6aTgNI
 EkaS5KXVfMvdIZsMeePKoqQm7toRjwOnPpqDmQr74ccB9iWth9LSN2tTsjW+RlY01miM
 veGFvZ3QIyT+TycXqdF2/4bHcC21ItvM9uAP1TGdn90Dno7udEsW5EN9+Qk14meuKgzQ
 p6yIEPC8VT1XmFJ0T2DbWjwWPTfN78LQKrDhAbt/x42I2YOgnFbdPTE5hS6LFGwNi71K
 EUqCrgmTDeXUIrOf3kcSPC0uEjym129mUEbxaCBdrgl3WJyRsWndp1BXj5VmkRAqdyYG
 FIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762936404; x=1763541204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qmmwg7B3/mG4SkMgu3jo22uLPe1oOewXbQ98SlU/dbY=;
 b=XsDtWdTdSFK4y31wrSckmgGqG8HOaofwkw0VqccDaHaKPG7eZd7dK1cyYZ5pz/0VMK
 ffRlCOYbPurkxPj49H7dAzGJAL4btuA8aGwxqH3WYCs7vG5inR06Wuc+vFiYl0kJm6Md
 D0p5aptUfltXaiK+kH1hBBfmCK6U+DHWKJ4gp7hYZuxDglqAr2f66BlQJBX9xZiDScC+
 meW8nltFNfZ+eBk+aW/D+pyh4HOrNcVPG0tuwljiTn8lDaCLm3R785yXpAV0JQMBjrm8
 1SHfzaJuBfAbwqV29DgHoRKUoVmeBlo15mwDAF7dO4H7olYNu4Hery2vPBelfrETei63
 t8CA==
X-Gm-Message-State: AOJu0YzgwdH03QoNuEKD/q/uhgyqUQvbFRnA6f661w88u7HXs8i31uhq
 C9F6p0Wtl6Ds8cQwhdXf9RAmwsbvfgOvfaPGNw14QPrXxckkjby85Csp1iQhXGboz0p4CDBhZpM
 h6fsoajUcxhi5
X-Gm-Gg: ASbGncu/lpHT7N1VTfyEMie6JNpz/L8LSuXvcctw6dM1XcQ3dnnmeGsuEVMi3TtAuu4
 7Nrr4UMXxg8vHxTFndQPCxvbRm/vIAm6gGs0ip/wjCvdHT+Mek/M8TJ7r1q7ORWny2UUnZuMjjN
 A5XDz39EgMtP5Ilpr7P9mcSqXjKrJjk8Lo4zrlSe0FoXUJzMeSFvBE0zfO+0opvSQ5q1CPBlIg7
 PJB0x8VatgmHYsHMUOvzxJrVHLcQkbJ41kR0Gf0MLru2pGTlyt/Zmd5xhqQyQ7MNFOmz7004kdv
 YxXxup4tUldhqhYCFRwHzlT6Rcw8E+E1kJ1GI9OvE4QnVoIebo0tZR6LenTR990lHxM9X2RSc1M
 lRcVNVKTfjdQx9f1AG2goPoraDbBKoB8o4uf6YlxmLUuO/Re2PnQhh8dpRfKrOQ4weySp6JmDUv
 9GbglpKZ10KhM9h6K+fFtPqRlIyRGgFfiRA4erOIWBPQM=
X-Google-Smtp-Source: AGHT+IGM/V9s0KGc5J+tLO+5r9UwANvjdflzXVPYHGwAkQ/5aYOJdpq7jaIdZnTn/mJNEk5zUIzN6w==
X-Received: by 2002:a05:600c:1f08:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-4778706703dmr14979955e9.18.1762936403638; 
 Wed, 12 Nov 2025 00:33:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787daab3fsm26079805e9.0.2025.11.12.00.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 00:33:23 -0800 (PST)
Message-ID: <8be63b9b-28d2-455c-8f67-ec0ed1ed7ee7@linaro.org>
Date: Wed, 12 Nov 2025 09:33:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-8-philmd@linaro.org>
 <d29d2888-0a95-464b-a5f9-e8433be2b895@linaro.org>
 <CAFEAcA_7w2u6VU07caQoRbR203RG0EGmRjcB5rmyzXoe1qFMPg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_7w2u6VU07caQoRbR203RG0EGmRjcB5rmyzXoe1qFMPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 28/10/25 15:25, Peter Maydell wrote:
> On Wed, 22 Oct 2025 at 16:14, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 22/10/25 17:07, Philippe Mathieu-Daudé wrote:
>>> qemu_chr_write() dispatches to ChardevClass::chr_write(),
>>> and is expected to propagate the backend error, not some
>>> unrelated one produce by "best effort" logfile or replay.
>>> Preserve and return the relevant %errno.
>>>
>>> Cc: qemu-stable@nongnu.org
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> ...did I? I remember being confused by the errno usage
> in these functions but I don't remember what I thought
> was the best way to untangle it...

In March when reviewing PL011 TX FIFO patches ;)

https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/

