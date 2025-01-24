Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9429DC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMTz-00086g-30; Fri, 24 Jan 2025 11:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMTr-00081v-1H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:24:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMTp-0004rK-Bh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:24:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361c705434so16645765e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735861; x=1738340661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ge6SL31JdlGp8n4hV+7epq1XhHXSxEb3UAoZ05AkZY=;
 b=Jt2c+9QXyV0q/aHQ3l6TnWmyWHEx/n9at3UAT1VzzHME4Ms/SclvWWPn/TBZvU7ltw
 fugOmdjlofoBOQ2STEA6MrAMwzolHPU20oneZXq3+hs/FEF3nGF9++tNVfI5Ni5E8Yri
 F99ei677AH9jKLxnIPdDFHKpvq2ywAiHJ8/m0goY0wCmwHRq7KW97j2pLHbW0uPBzLqD
 gQXJo/EEPHn7AGviOReQjGu+J1TMGY5w3DUpF2TZ4xVVZhrFEk6paSZEf/rT7DMwTcVK
 jNpivQY9YDmKm7gos9RcJXQ7X4/NBqZrj/Std1iE62cDEXWGL8ikBTdItKOhQa2+HA05
 7VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735861; x=1738340661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ge6SL31JdlGp8n4hV+7epq1XhHXSxEb3UAoZ05AkZY=;
 b=wHuMda6QZK4dI56WpGkgn+cGCg9Y2osNnWCTrtN/Yv6ZXMzeW4jBCy9hPOT6AUfHuu
 ZTi7d6+lGsHz3tTkYyC143qXse3cSvlYas66WAvVyDBR8VF1opBVuM4Uf+FK2E8GDCBI
 KpL1/icMYV6hQNyMIzSAKvAcvCDKzqJ+DC5M5LQ/oa82SpXLV+afu6jEWu1WvkeSKYgo
 D9rHh9ym4aHff0dS4Kwno8PabJywlTOWW476tC4wYVNMkxVNBZUBqCA3Q3sWGcCtwAv1
 GPtGvPmhnByg1d9b/lZ/j446TuLtiFHkOA98r1XgQncapxI3S+rD9RrA8Xh46I97UPj9
 Bgqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcaVRZDBQ7m1/eDiXSpglGKw74GMoJCIq5D0U2M+MLnG7ZR0s45O0KI8coAIA3dkt5v5S5T2cLdTg5@nongnu.org
X-Gm-Message-State: AOJu0YwYkpCUMry7TJNVPf2OAR95cNAe9+EZvQySzRhJiboLPiKC6yWr
 p9y73Brjxh8wzmtaxgUf0gOKWU8QUtfJkMVfUPplDP/lysQIgjWAkFKL+75cFf8=
X-Gm-Gg: ASbGnctG28rrvX/ERKI8MnlLosq/OmI1xROMaeopa+Cq5dUgoIy+2VdY6TIA7VAvdRo
 hkCPRyiUEM6mL82qjbk61VlEKgmPm95okSk3fVuF/N0mMpMQ3YmgdBXUxGkvVg43qYNNUHp3FSb
 TT6awVi+ttN9ggNlY9faqJU+GGOrzwGE7uueaFWuCbPdwRKGdveFydbW0VIGs7EO6Cwmv4orD4U
 B/LPX5Z5q1qvsO0Ogy0bP5WK5pUf4SKPWsOYVkmVE5vwcREMU6dPf53CInsRjkj2pfMsPef+90a
 8YbtD18L/g4f16YT/nNpfYJ3GcDxCWV/ViDoezhLqM94UhXD
X-Google-Smtp-Source: AGHT+IG6pkwXVsVvNqhFxDrW9IIqe/oQhLFutNfEEgTPdSlAnsVkezFo4LTY4O0Uc0zFxjv7OOiyfQ==
X-Received: by 2002:a05:600c:1e8b:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-438913bf885mr302118745e9.4.1737735861617; 
 Fri, 24 Jan 2025 08:24:21 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57517fsm30519815e9.38.2025.01.24.08.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:24:21 -0800 (PST)
Message-ID: <ed90d253-4dcf-4a44-83d6-c4047b46144a@linaro.org>
Date: Fri, 24 Jan 2025 17:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250124154533.3534250-1-david@redhat.com>
 <20250124154533.3534250-7-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124154533.3534250-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/25 16:45, David Hildenbrand wrote:
> We don't need the MemTxAttrs, so let's simply use the simpler function
> variant.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   monitor/hmp-cmds-target.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


