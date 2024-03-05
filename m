Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E96FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhX4Z-0000OX-CL; Tue, 05 Mar 2024 10:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhX4W-0000ON-TG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:51:16 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhX4V-0007Mf-7h
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:51:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so533547f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653873; x=1710258673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dm6l6PfIksSdR29ispgG3Rt2suMFawhN66ke9hIjHHs=;
 b=exm0CRYexud/AZL8E3738U41JcdvntgiXB9K1kOi7fTUo4GwkB/Z6r/hhPYuY8ul06
 QLQvDIJ0EMnbvRouz0/T35wyHGnJmwaEC+5hbFOpO+u/hSovb3yccpkAg23pIk3LjhCv
 n+2OBUOJdc4aGyL3CdV46gEmUv534VlQX1wSAKup6sVkc2hcR8kPDD97Az9Cz4/zLgYA
 u5mC/zILokKjT5wYtC3IToANmjDHYlJaZB6qVC4nQffWt7hA6bhJCi/2XHmS0gEAUPl1
 vERI2pubdUWFdVk+5/Gb/cyv14eBlGO7DoXm+5vUI7rhb2mZlSymxh2K8/95ruvF5QyM
 du3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653873; x=1710258673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dm6l6PfIksSdR29ispgG3Rt2suMFawhN66ke9hIjHHs=;
 b=kxeAlizfFUFrs4YDfIxMZoHHF8C5/Vlg7EM0pBLJ4tmVcbXD9RvTwovs3OHTTOFu9i
 TRP8MX9FbEpap2sF/kiSsxChf6ZDWMrPz+4Oe3bTDZLw6I29Iw1ufn4arcz/hQEN5w6z
 7fWTmz+6sP36bs/fzVxdA6QWYXzQ84VEbqJxkRi9dYe9pzP9lSAFEmfwQ3mzAnTBdt/s
 iQEEr6uwnY0hnQNXllLAgP1EqWG3TxC661VpYz6cVJtoAX7LAsdDGEn8cWOrFAgsUiG1
 5HbstguP2XAhI60B+/oc8GHGO1FyezKJTgMrkCOzx5nV2ceGZ8uNuI0AB/3TMoo4JID+
 oeAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7o/M3O+PJixK12etJOFkwVL/XVYNOsv8hdn5/0vB1yu3pZxX4idvOq4/OcM83QJPbBmRt2ZGePEuKlw585e1b2nRXuQo=
X-Gm-Message-State: AOJu0Yy4gYJv/TP+Uk8y6iVB4gLD13P21o8aac28BxsJjsuIK0T/v5Ox
 fuQRX7RNVyYWiRfv6OM51GGPvRVmSMVdqtfZKtNPXC+Qm/o8pX7mwEjC+Ah7Qdg=
X-Google-Smtp-Source: AGHT+IFVjOvjg9Yw52kYfS3v3xCnyvI7xZguu7DbGzvchroDBK59U0SmRhMVYJSg9L36cacqawBQlA==
X-Received: by 2002:adf:fc8e:0:b0:33d:2f2f:b135 with SMTP id
 g14-20020adffc8e000000b0033d2f2fb135mr10172856wrr.46.1709653872769; 
 Tue, 05 Mar 2024 07:51:12 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 j3-20020adff003000000b0033e01e397d6sm15208015wro.54.2024.03.05.07.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:51:12 -0800 (PST)
Message-ID: <ce5356ac-81e2-4eb1-845d-c444fcd48abe@linaro.org>
Date: Tue, 5 Mar 2024 16:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/i386/pc: Remove "rtc_state" link again
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20240303185332.1408-1-shentey@gmail.com>
 <20240303185332.1408-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240303185332.1408-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/3/24 19:53, Bernhard Beschow wrote:
> Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made linking
> the "rtc_state" property unnecessary and removed it. Commit 84e945aad2d0 "vl,
> pc: turn -no-fd-bootchk into a machine property" accidently reintroduced the
> link. Remove it again since it is not needed.

Argh 🤦

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine property"
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc.c | 8 --------
>   1 file changed, 8 deletions(-)


