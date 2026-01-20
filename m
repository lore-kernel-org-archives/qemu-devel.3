Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A00D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7OB-0000ig-Pr; Tue, 20 Jan 2026 03:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7O9-0000fz-1U
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7O6-0006nQ-Bt
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768898817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dI6LtlSV9UMySJmNwGZuinrpo8UN1BY+wxIsISW55e0=;
 b=bpvsth+9hf+IvzLjetv3OHFkwaFt9KTPf8FBR4yUs6lTA2mJtcdYZ8DRdAGvUSJ7mtUlaj
 raQqto3Lafs7YKwUWNe+k6xdsKASDED2ZAq/Nm14d3sjgIPYpHYX68w8hQ5fhFJu5egr+w
 pYOQLQQZv5bOuwUxw+kDRh/UIsnAbDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-D8_FnoeANa-ruvTAOcQlew-1; Tue, 20 Jan 2026 03:46:55 -0500
X-MC-Unique: D8_FnoeANa-ruvTAOcQlew-1
X-Mimecast-MFC-AGG-ID: D8_FnoeANa-ruvTAOcQlew_1768898814
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so38564185e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768898814; x=1769503614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dI6LtlSV9UMySJmNwGZuinrpo8UN1BY+wxIsISW55e0=;
 b=QU/NHjU7dpll6izjwwqTk2ocks4BU+p7MWzk7KCGOolOPdY3q1v12LF7MOdacwSxq+
 isERNcSTv0Esp6SezK4ttfsPPvnF45w+HqbZ2RdKaXElidjjGXKkm2WeOzWDjxBYt+xL
 a9N4kwJxmDL1eerkqJUcZTlqqfptXoNXb4wtheXCBzxnEmzlnmMNpS8uCUJJnNKklEhu
 j7yZCBL0G99ot1JPhMwDEAbuXPpizqADVqJq1oxH08oTiQpNI4+H047x8hZ03J8lTqWf
 zYYaL7C3K5YcUbj7uIjyP6oD8qXEDE5pJRFeyCGvTnazvFslVK2KOpMYITufgOJzYANv
 lSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768898814; x=1769503614;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI6LtlSV9UMySJmNwGZuinrpo8UN1BY+wxIsISW55e0=;
 b=qywbwPiJOHBPhu6vcF0vUhNroSMtCEV1ZoHE8zUo3bdq5Ync4DtFLNyC4o246gQyHx
 K166y9quiAeJ90DO0mJPjeZGssxSFRYlOc6bne00Db9njBWw2LKOWt13e7pf4mQ2HdA2
 5ZLdYKRPTU4QrULYQYFo9XPe8Cnq/z2jRCzKUHQPF//wcxH7cxFA1GXQGo4g8tSUa7p3
 UGaXvw9AIH3GhGtDGpz+DcPeyycbU0VWndGIbLdMqUB2anfMH0Ndis2bP0z/3cVL1//O
 IKWX6AyVsa/CG+Kj3psKMOjnfEOdQubx62VPkqFjlxmAT7HOamnbQFdlxmO7kO48wEa9
 c+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhh/HyGNxh/RqkyFABtCKLsPjGEtX7j1Pb55P9lj4pPA7lq/wXSfx6SLvnlVGHKjdMEkxJQA8ZWclQ@nongnu.org
X-Gm-Message-State: AOJu0Yz/EWbF2wF0YBRtokihSx0gCUFVrfDTA8GAkE1CP4tyDUblRKkH
 3DSCK3Nzopq1DFfpoqKJppc1BKYs8oiqUgc8C0i0bBp2lHdi7qNW+rgX2+64NKlAb2bCVuDkSPa
 X6JY/tLfdiiBn5CKj8Tsk5WumtELHpu57kCTHBnsRzA4f5QxDmJqv9mSO
X-Gm-Gg: AZuq6aKBtcNEVKEYXIXV4S3/lBl5OVg09G8EGHJYUnot+3x+MtFpxOXc9WsvdiEmQzu
 YaRaZJ0c1JqmmSglZISagp79caHHB9LjKVc5YpVPHRZoheSM4SX7sQb3Y/a+ANhMgY4D/Ys7GTY
 4v6KCqaxGiG77PAoZ1rktdHr+mG5fXTwU5wEmUkL3ZsyTDLlEhgftaIev4YDrd/NrH0DVC3KcdI
 ip+AjB+G8z2NmGsL5CmkA6JOjciOd5ovlhXtPlEVR1H67rDChrzHnKTLXGGniY8fKHag0QZlq8r
 Ev9xq508tcssQkCSQ/P4ixFR2HZHVKkhVlvdg83Y5i/f0aQlDSua622PkYwdHQ6fmnKSjaAIoFT
 TSQ7OMPZPRNXuJo6hrgktj/+D+AIyKQeIR0M=
X-Received: by 2002:a05:6000:26c2:b0:435:94c1:3714 with SMTP id
 ffacd0b85a97d-43594c13c01mr413205f8f.0.1768898813865; 
 Tue, 20 Jan 2026 00:46:53 -0800 (PST)
X-Received: by 2002:a05:6000:26c2:b0:435:94c1:3714 with SMTP id
 ffacd0b85a97d-43594c13c01mr413163f8f.0.1768898813480; 
 Tue, 20 Jan 2026 00:46:53 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569998240sm27568296f8f.43.2026.01.20.00.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 00:46:53 -0800 (PST)
Message-ID: <2c6e3a76-02b0-4910-ac0d-50f7011716c7@redhat.com>
Date: Tue, 20 Jan 2026 09:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] tests: use "run" script to execute
 device-crash-test
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-8-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260119212744.1275455-8-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/01/2026 22.27, John Snow wrote:
> Instead of invoking python from the configure venv manually, instruct
> developers to use the "run" script instead. Change the test invocation
> to be a good example going forward.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 6 +++---
>   scripts/device-crash-test  | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


