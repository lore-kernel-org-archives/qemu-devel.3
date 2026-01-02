Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8B4FA3727
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb68-0004Vf-MT; Fri, 02 Jan 2026 04:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb63-0004R1-9n
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb61-0003ao-Od
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767344720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PXqkBvMzmuv+UquFcfGhe4AOOhs7b83UiEkV4Jhz/LE=;
 b=XTjUhJZHcHWadfACuYfF/RvBnKYAoc8YVWaeODSizXWO1hper0ltUvZ7chYpWz+8Cmsj6W
 DXYwvSmCVZl09ArdwJ6jASyBWbsBaZMQpyzQ2hIQADxuPXg41ioFo0xeGbqI3nepua7bnt
 YER44GhOPEMk2AwWpGCB3vGIcfkzEnk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-lc9ebsMWP92Bh4pbkLvJ4A-1; Fri, 02 Jan 2026 04:05:19 -0500
X-MC-Unique: lc9ebsMWP92Bh4pbkLvJ4A-1
X-Mimecast-MFC-AGG-ID: lc9ebsMWP92Bh4pbkLvJ4A_1767344718
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso82636695e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 01:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767344718; x=1767949518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PXqkBvMzmuv+UquFcfGhe4AOOhs7b83UiEkV4Jhz/LE=;
 b=nh09x7UKp3I47Y+EBhUAr+vvii69w/kpiVgSGutvuAwgjKUGcXCLqsSvzirMzDZ1uV
 wpC1VGD+6UsUJbRSRsx3mNBuEebPWJAr0DBzWydl39MRBgx37qLrDKGZi1CCA4HOYwq6
 JDF5PFAU6RIuoyC1IK0L4nOISRhthYeD52wd/bL///Y6laBOn+wLiDeo7/v/k7QuAwtz
 fDZsLERH1VBZTmaU1ihz9NoIB2rjT92+BbHIiIJHxYk9YKqUcFbBagmA636gN7f6R2RU
 iV7pKl+0KnIH85B3xL2znECzXUEHmKkQyx9FHzy8ujt2biR2p8o/zWQsZ1Cf7jtXOv1p
 1UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767344718; x=1767949518;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXqkBvMzmuv+UquFcfGhe4AOOhs7b83UiEkV4Jhz/LE=;
 b=P2pldVv7COWXKgoqgcC9C9rwLpuQzhr/NOjdR7k2FzfjLjhiFqxLFRww0Ej7QvV+Pc
 B3QzWvkauKHO+g2ZUvVqFS3etCupDMoUJsxJPpqaywFlsE0m0XI8CznYPrAEo0+mCQTg
 y69E4bWrwn5By03OsQs39cQmcDr9tQlQGO+XMvLB4npZWjlGiz+/LpWASgDx7VGyA7Z4
 6yYMoDjimNtdA6hISo8A1RU+CWswyA+Q3BfnSTZEHeQ5vIqSdorLgivj6wQ+bSuWfEnc
 o1IiKuyhJ0ReQFjI7K9ag7ghkj46sDlolpZpfYl9HggST1YquLyaAAfek5rKT0A2QOvz
 WCBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeI+sBqhkuXXuuC/5+imuBZeHt5OiGsGCSDN3+btLoD6YCHlK1/U0eWsbNH1xOnMaDFLm2EKqrHfb2@nongnu.org
X-Gm-Message-State: AOJu0YzP10cwqKd6lU09nnnRgDI9ECj2LGku54TDpRoghyxDiSdCRCq3
 rznT/hY9WxXzjApNK+uWCt4jGX1Ce79zE+Z7agIK1z2LpalCZQW5SXVnIowaU+PzA9RObq5BYDF
 2D6a9TIYzloMgyQD3LhWuUjYo/3bcMqDS9OxF9cpNT2cMbL1HCKk3/6Xv
X-Gm-Gg: AY/fxX69a8bTJrQRTSuAmTQTfdc1brx/KRQvoSKRX00ioXLx4UsANUNIio/7uFXwQaV
 BGWZTnuDaDXjIN9JwD32osp0X7/JotZ4Q1XXiM2D7z6tORbpPvt/qs+5qxh+UbJ0G6NPv6HCdad
 LNhR4e9QuqfaBC9UsudmWT5B8EWWI3rELJpWDrKwALFwR/o8Pixo0D2qYS00l0or9CzB2ulSHoE
 iF0/qGBf0HF+1pcQb3JvU6/5FF1zXTnT7FyUYkhfP3FFPMx76TRC5FhKUy5kL0YU9lyKzEU/Uob
 Aa5XNo2i2ovJCLo0oeLnl41hJYSBOZ0S1nCoengdkXSEoVxfpMqwuyj4obYW3sElXyHhH4Bbd9m
 12e2qk4g=
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id
 5b1f17b1804b1-47d19549a95mr451447525e9.8.1767344718057; 
 Fri, 02 Jan 2026 01:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9kqqtnjr7P9V2JXLolp6SQ36gENVilNAwCrKUe9sCVA8zKqJLimRjc2lEH2PonS3EwrrCgA==
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id
 5b1f17b1804b1-47d19549a95mr451447255e9.8.1767344717632; 
 Fri, 02 Jan 2026 01:05:17 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm780959825e9.3.2026.01.02.01.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:05:17 -0800 (PST)
Message-ID: <60d2fb61-608b-4844-8b65-eb39d5b1bc8b@redhat.com>
Date: Fri, 2 Jan 2026 10:05:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Fix coverage of
 tests/functional/acpi-bits/
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20251220173336.3781377-1-armbru@redhat.com>
 <20251220173336.3781377-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251220173336.3781377-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/12/2025 18.33, Markus Armbruster wrote:
> The pattern tests/functional/acpi-bits/* covers files in
> acpi-bits/ (there are none), but not the files in its
> subdirectories (there are five).  Drop the *.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


