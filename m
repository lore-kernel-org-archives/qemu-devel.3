Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0537D4A604
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vge0J-0003Zj-6Z; Fri, 16 Jan 2026 02:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vge0G-0003XA-Po
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:12:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vge0C-0001Ae-Ud
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:12:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso876418f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768547529; x=1769152329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1B+l+dzGo9lhySuM53KvC5ptYdIE7EZDoyhBzo6VSlU=;
 b=TQgWLlMWfNdI6J3uefkq6f1IYsU4xasBL6is40EiDUwDViiprnJJmjdt5S2+qCyPF+
 tNQStzt4f5SW4wSW4QUT0JjwcfQIEj4fP6vG6FR1U0M8AK6bczPkjjuRdr+4jaWCzRge
 R4rg2SaPLP3djTlzVJaQiF/AHIxcUj6BLGN5GeVUvVrVHwKwqDl3m3AoFvedjXClK/lc
 FsFWItPDvlQdvDJOEUx1ZuKZqdLzhr0ShmjbOVVO3g5tb0VEyhUl8Y3jPMlUvurqUP6w
 xyGuWVAp60zqaq9ZECqMZ4gkdz9YGwS4YGbgn4WUdbSvXPmccHOjfIz6hqMl5x+z+1ty
 zKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547529; x=1769152329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1B+l+dzGo9lhySuM53KvC5ptYdIE7EZDoyhBzo6VSlU=;
 b=PxwL7dIKPSG8mgzaQTVRBQBN9ySaPTEhmoPikDi9uwoofkbJwHaXUrqyqhUFp5fDEz
 fERTwKmdXPl/d3BbO5HPWvQSeMswrEo3ii7FTBdbV51K6Hd/ZgHrVUMn7uN9jl/IyVzk
 xT5kucgeZWT8sxPT09iRWiXp88AgHA6snF5tohZ9Rx0liPiB1b/a4WAKzbVvglrKKAUG
 F0tvqJlwdkwla6Nl4Tsmv/K1zZrNr+4jMtIM2AalOoaEQR1HECMfpen5C3G5a3REumxB
 aepXfzejOw9WF7ZvnHtlwCF3jVURcUYAF9T3aXTOBV/aXnXfnzJUFNalrA77nWRv3Uig
 n5Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWArKA9qQbA2WlHoejW661eZulWvHV9/4jO4cDEkJ299BT1gN2PVKHUGi1uHDjHRS7cgHNo5yijmLbn@nongnu.org
X-Gm-Message-State: AOJu0YzoHm5IFP2qXSORb2jMz/uT110ND0bLxvKf8g2p8+gDXqQBXM+N
 +PQ/4BOXjDoHxKC9HRdS0XdJk21H63VwVamPZztR6JQCjSEz0BBjuW2ifb+OcvG4ISI=
X-Gm-Gg: AY/fxX6u3f9NeuFsUspQhVqM5rJbBUmV9yq/6yqj/9UPbZijREHTH4seS3xkn9wdmC3
 s/4KmwOrLHbq37jR6YD8GYLla2gtWb8a5EP7OOYr44gnpPBiWvjPZ3G70FhpWjUsBLCEhziJDcT
 Tb+2Om31FkGe1oaG2krkKvjhdk9SsPCQi7k2X1qq94ZONf9jNU6aWMyMzZF7f3iUCGc7+sHq0t+
 OM+k/4cwSlMhfLJIBXARUA0jKm7wdeqh6xP0bIkj/nFjkA1LdPjWGqZ6y9OsGw/v/LH8uqIoVn6
 HmS2MoxLroc8yE0+OYQ5yv5OBkAM3IyVX0mjSfSsX2bk1OIhkqFeM9Gp6H64H5Jz/YtfJsn2E/O
 P7+To3eU/PaXOhImEj8/gGw0B4jyNHBg05bXMpo6p68dlnuMfBl7o/NzF7Z1SGoiaO677clj84b
 Z+JTj3Toolp+Y+f/ADzW0X7RMxUeJEjYFD9oNfTc1Je1XOTTC6OSN8bw==
X-Received: by 2002:a05:6000:2911:b0:431:327:5dc2 with SMTP id
 ffacd0b85a97d-43569bcc0acmr1992520f8f.51.1768547528688; 
 Thu, 15 Jan 2026 23:12:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699271dfsm3351011f8f.15.2026.01.15.23.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:12:08 -0800 (PST)
Message-ID: <2a68ffa0-ea8a-410c-b8c5-a4803d042b05@linaro.org>
Date: Fri, 16 Jan 2026 08:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] include/gdbstub/syscalls: Add EIO and ENOSYS GDB
 File-I/O errno values
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
 <20260116014612.226183-2-yodel.eldar@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116014612.226183-2-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 16/1/26 02:46, Yodel Eldar wrote:
> This patch adds the EIO and ENOSYS errno values that were missing from
> the GDB Manual [1] when the other errno values were defined.
> 
> [1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   include/gdbstub/syscalls.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

