Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF075CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEl6V-0002pt-KB; Fri, 31 Oct 2025 05:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEl6S-0002pO-3x
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEl6J-00083o-2B
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761901629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6oxqYwFAhws+qxiwnGA7hTzxza9DnPp87hJNznnvNA=;
 b=A8yrgZHSzLpmpejAufW54Lcrq63Hsp5iWJqBpAGM8egii6yOCTvro30CnPz75cOALIAHWl
 IUV2jNDfcc9zee3VP+7vMtFqGXR2k2bZ1SUIWPoqAbWRz3wB4sTmMHTkT8ZWJvf8nOli6/
 PCP1kbtfW/+uah33wl46sfMfHKgXLOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-VPrgmGKLNlKbjaaBMmJ0CQ-1; Fri, 31 Oct 2025 05:07:07 -0400
X-MC-Unique: VPrgmGKLNlKbjaaBMmJ0CQ-1
X-Mimecast-MFC-AGG-ID: VPrgmGKLNlKbjaaBMmJ0CQ_1761901626
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso14996995e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761901626; x=1762506426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6oxqYwFAhws+qxiwnGA7hTzxza9DnPp87hJNznnvNA=;
 b=VAiWQKXT2yBSYDIoZOkwcUPQYEaIsKx9vd8Kuu6wRGH7IQRPv3cybfs+AFUY7c9esF
 tMH6rhtZTK/N7FCMfbdgqZY6sNF9ZmdgcdhpzhiOOV9PfR4rV1FAzhSJhInjiqTCpq8U
 yecB/fhf0QCz8/ar/K+vz0ORIboob8xsOSF/eqiOGuE40cU1W9fRAISIcNJMJKoMP+ww
 zaMYn6s+5AV61Xk3oMC5eK1/QEbDd573I/FLYW9a1KmuCjpffxDesHAIDXTFNLVn7mLN
 bvexbM+IL4bd50+9Geh0rkIqYe7Vbk4vziqC/IcC6wVL7vHlURjaaUyVpEZNR0X7INCg
 sMxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSb36Pi8zwjb2z1JONFnf1xKCo6fGVJxPIOJkQ9EQxCAuaIQcljvx5m5JxxEhSB8E/31YHvzr2ZKAg@nongnu.org
X-Gm-Message-State: AOJu0YzZn0Ezo26DE+fV1erMzE1N7fbyIhkXuz7SLrAKhnsGRNAY7eG9
 KXBcJ6Gf4UUPF+NFPKaoYs94S3A9rR+W7IQ39g2oxHTBvD7ZWe/7fQ+pCnmlko4i7qi8p4Ap4bS
 VXzWX2iwpvz1Iv/Kj1c4uqAj6WNOEuyVdWUUOQtK9x5/MOGUeMkH+dX7C
X-Gm-Gg: ASbGncvGdHLjQYgxQ+C1R+2NwKicPQJJd8UHhidZPLuNXx2jRppLl+ZIbBIkdz9lxqU
 Ntgu2tt0eFxoZT6Wh50q4AOi7JqhpbzqPeEcBU1oRnW5cSezZx3dIY7xJlO0Hk8CMrX4jiewaNr
 UnBfW7jnSkXJmU/qYlSD7X9lv7tDFATva1t8uhOYYlWIJJkfGXPtPtgKyOhHglmRJ9Wsa+vcyOg
 L0og9rR2uH7nIR8WM9ZEWQDFsbk6lVtK/nQumMrqe9nQO7Yo+omWdGwzZwel2PRp0XJzze8pIGY
 ptLxuAY0qyYlwlkF1bZUVAynNTn9MlypwxDlIP3ATntlIG7TNYBePO3H5jQ3K+RYlgICYeojJYm
 bFynMSFx/I6Ckelr8AKAqnFtnCoii2gS7PqoJVZzf/jGfINqm7aBQfKLp/4xC5rp4GJ3Ccf5x8Z
 V8XRgMiuCWMQvpM+Or3EfnZJ9japvL
X-Received: by 2002:a05:600c:5021:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-477308b1a99mr21715545e9.39.1761901626129; 
 Fri, 31 Oct 2025 02:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0kf+kIOt8nKlPSJkBny1PB9fsRt02hOgt6kpoqe9L10lzv1AXYO5/+S5VWXZdVXL7hQmsmw==
X-Received: by 2002:a05:600c:5021:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-477308b1a99mr21715155e9.39.1761901625703; 
 Fri, 31 Oct 2025 02:07:05 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ddd0a3sm22704215e9.5.2025.10.31.02.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:07:03 -0700 (PDT)
Message-ID: <5206b3f2-42c7-48a2-aa92-5580f2733ae3@redhat.com>
Date: Fri, 31 Oct 2025 10:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_03/16=5D_iscsi=3A_Run_co_BH_CB_in_the_coro?=
 =?UTF-8?Q?utine=E2=80=99s_AioContext?=
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-4-hreitz@redhat.com> <aQIkQ8q9CaUYw8Ob@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQIkQ8q9CaUYw8Ob@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 29.10.25 15:27, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> For rbd (and others), as described in “rbd: Run co BH CB in the
>> coroutine’s AioContext”, the pattern of setting a completion flag and
>> waking a coroutine that yields while the flag is not set can only work
>> when both run in the same thread.
>>
>> iscsi has the same pattern, but the details are a bit different:
>> iscsi_co_generic_cb() can (as far as I understand) only run through
>> iscsi_service(), not just from a random thread at a random time.
>> iscsi_service() in turn can only be run after iscsi_set_events() set up
>> an FD event handler, which is done in iscsi_co_wait_for_task().
>>
>> As a result, iscsi_co_wait_for_task() will always yield exactly once,
>> because iscsi_co_generic_cb() can only run after iscsi_set_events(),
>> after the completion flag has already been checked, and the yielding
>> coroutine will then be woken only once the completion flag was set to
>> true.  So as far as I can tell, iscsi has no bug and already works fine.
>>
>> Still, we don’t need the completion flag because we know we have to
>> yield exactly once, so we can drop it.  This simplifies the code and
>> makes it more obvious that the “rbd bug” isn’t present here.
>>
>> This makes iscsi_co_generic_bh_cb() and iscsi_retry_timer_expired() a
>> bit boring, and actually, for the former, we could drop it and run
>> aio_co_wake() directly from scsi_co_generic_cb() to the same effect; but
>> that would remove the replay_bh_schedule_oneshot_event(), and I assume
>> we shouldn’t do that.  At least schedule both the BH and the timer in
>> the coroutine’s AioContext to make them simple wrappers around
>> qemu_coroutine_enter(), without a further BH indirection.
> I don't think we have to keep the BH. Is your concern about replay? I
> doubt that this works across different QEMU versions anyway, and if it
> does, it's pure luck.

It is solely about replay, yes.  I assumed the 
replay_bh_schedule_oneshot_event() would be a replay point, so removing 
it would, well, remove a replay point.  I suppose we’re going to have 
one replay point per request anyway (when going through the blkreplay 
driver), so maybe it doesn’t matter much?

Anyway, it seemed safer to keep it.  But apart from replay, I don’t have 
any concern about dropping the BH.

>> Finally, remove the iTask->co != NULL checks: This field is set by
>> iscsi_co_init_iscsitask(), which all users of IscsiTask run before even
>> setting up iscsi_co_generic_cb() as the callback, and it is never set or
>> cleared elsewhere, so it is impossible to not be set in
>> iscsi_co_generic_cb().
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> Kevin
>


