Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8243C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8hl-0001e2-U2; Wed, 15 Jan 2025 14:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY8hd-0001Oh-Fe
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY8ha-0006d3-U4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736967916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kowpaTu7bnYtvxT2FQEB41f+g099wMLJLcSIxVKxhkY=;
 b=HobGDa8chU8aDVgtC4XpBcQeV166dZAuasswqCsOgDKFLSUZBWed3blb1xPRgTi1tzV+HY
 gJGOn9gpEN/t+qlaD5NUXL8LOSjwXejGPx31vE5Eu2EkGFicQA/ac3c3vsJ41iPQB6v2cc
 YCtpWVLvEIEo76DBzu0KmCA3Wr9W2Vw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-gWuO2TkcNSehVq0hTYerCg-1; Wed, 15 Jan 2025 14:05:14 -0500
X-MC-Unique: gWuO2TkcNSehVq0hTYerCg-1
X-Mimecast-MFC-AGG-ID: gWuO2TkcNSehVq0hTYerCg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso225785e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736967913; x=1737572713;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kowpaTu7bnYtvxT2FQEB41f+g099wMLJLcSIxVKxhkY=;
 b=V0DiUMsAdZXPqHuAByjt7csrXMGVopXEd+X1GOsv3XPMeOX01RgKHVvl7MMRWf2/55
 Nrr6i2n3Dgcb8b16m4h6Oq/GSCDIPuDmY9CpHGb0Z+9XHsoML+AlF280DSqgDg3W3faR
 lWN1STK83fOWBu6/G3pDhCzkz+7lM+enQehubLnXnYA44htCCvg4zGs5l/TOnPiPjZk4
 w8APbqg49q3fESHf+zEAL7gwLh2d/dmeHcQ/zbY7eCqEodz6SVqLrJKBoGaV13hrcVQK
 Z5yv96WFSyMENnku05KAD6DeaLxdsESJ3QKp7C5vyHNoqmqOkgmJtz3W4vwM76u6/xey
 WNrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViuTnyhOEVhIbmGysKtHCniZHSJ+p30h2cDoWWjEVm5RKUOhd6bPmCUFIBc/RUHS3XEGXg2Pf1PEwr@nongnu.org
X-Gm-Message-State: AOJu0Yy/GDfRfWIMZUDPyKK73UAoz4ZOj69pkt1unL9VN5MwZECUPUg0
 QNu68G6MuNF8/+tQokiqH9GnKHocntN0lXCQs+xhMvxqjicjQOImvtnta++B3uRACFF2AtQx84z
 d9Lod2qsDvVfJ5lOit00qMGZ9ElVatJwhUy8TVCoiORxF9PK9n4fH
X-Gm-Gg: ASbGncvaWKC8jr896mUa4Px+x109zW64tny4ZdGIt1Dnvo7uG7de8SP8HLvzgZ2EL33
 6g2CAyEMbTso9smI3rCP+a4PSAEXhhamc/SPU6nco2IR6Qf/iNuPKAH+0rrrG2FRZIJHLICEypO
 c6O978dXaXILR4NwClo/5J7szxcjCcfi1qSCrCshTqfJHRfTGHgS6uG11quVC1SnW+sMDWvlDHa
 MqhxPA1Ac19fn6IwIOd6RYPJvItnFvEuvVMbH0ene/AW3ug50aepf4XiQnt
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-436e26e28cemr271163725e9.20.1736967913612; 
 Wed, 15 Jan 2025 11:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9lrBcPfHS079Mcedf4reDWCRUrvEEohimeIyr++zSjZUNT9GeY4kByFU016uSBG0S5wrR/A==
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-436e26e28cemr271163475e9.20.1736967913210; 
 Wed, 15 Jan 2025 11:05:13 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c1d6sm18690132f8f.50.2025.01.15.11.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 11:05:12 -0800 (PST)
Message-ID: <8dff3836-1c96-4ae8-a9d8-f86f97d78986@redhat.com>
Date: Wed, 15 Jan 2025 20:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/runstate: Fix regression, clarify BQL status of
 exit notifiers
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, akihiko.odaki@daynix.com, dwmw2@infradead.org
References: <20250112212609.17996-1-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250112212609.17996-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/12/25 22:26, Phil Dennis-Jordan wrote:
> By changing the way the main QEMU event loop is invoked, I inadvertently
> changed the BQL status of exit notifiers: some of them implicitly
> assumed they would be called with the BQL held; the BQL is however
> not held during the exit(status) call in qemu_default_main().
> 
> Instead of attempting to ensuring we always call exit() from the BQL -
> including any transitive calls - this change adds a BQL lock guard to
> qemu_run_exit_notifiers, ensuring the BQL will always be held in the
> exit notifiers.
> 
> Additionally, the BQL promise is now documented at the
> qemu_{add,remove}_exit_notifier() declarations.
> 
> Fixes: f5ab12caba4f ("ui & main loop: Redesign of system-specific main
> thread event handling")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2771
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

I'm worried that this breaks for exit() calls that happen within a 
BQL-taken area (for example, anything that uses error_fatal) due to...

void bql_lock_impl(const char *file, int line)
{
     QemuMutexLockFunc bql_lock_fn = qatomic_read(&bql_mutex_lock_func);

     g_assert(!bql_locked()); // <--- this
     bql_lock_fn(&bql, file, line);
     set_bql_locked(true);
}

Paolo


