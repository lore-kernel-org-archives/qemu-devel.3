Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E98C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 06:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toG5Z-0006M9-GD; Sat, 01 Mar 2025 01:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1toG5X-0006Jx-MN
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1toG5V-0007PR-DA
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740809556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v5C+T8N5/c2RApiUczeOPSwOOBYUdW0OyrBs11yU5Fs=;
 b=hYC9vt1V3hkiQIf6WMkcW5uwVaLO4DLIucO1F1LvEE/rv1qCxcO/qOX361mhki5X6lCXNv
 mpOr8KNWZ/UMPmjfTEMDNv7m6jIU95TFe4wpFkTptxPH9yOIBmjCIsYM86CigxI+iYUjDl
 Riu1iD2ijm6uXGABOB8ZtLDMKVZiLYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-R5bk0MVQMDytEyvP7Cpq1A-1; Sat, 01 Mar 2025 01:12:33 -0500
X-MC-Unique: R5bk0MVQMDytEyvP7Cpq1A-1
X-Mimecast-MFC-AGG-ID: R5bk0MVQMDytEyvP7Cpq1A_1740809552
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso26171585e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 22:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740809552; x=1741414352;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5C+T8N5/c2RApiUczeOPSwOOBYUdW0OyrBs11yU5Fs=;
 b=Flv6xgUnGjpyD1zTa0XmdwWiT6tY5hW3SjfKy9Zxu4zjXI87BNF2CEVrWHbB5/BocX
 9COFcwqdhv+tPhcZM0O3/0StjQJYt4sb41K0/xDWGwow3xNPvW/Fh0rT7FnZG6WH+8zj
 BlQKJgeZaSV6bQx+4vgkINQtFfV57vIRyPG0ATn9KgVMH7Ao/DRpi3J0eYHXD1RIhkH1
 iv8FgxsS2zP82jw+DbAy/yQQWCiagQImdqz2TlxyMKslbbgDx9vCQXJzZMoje4PV/VRk
 k5mXko1gADCgv11BK/X/mBlHTV6mo2VEt1rYYKYf5MFKvnQE5Y+CELRWu7Ol4fyvU/85
 db8Q==
X-Gm-Message-State: AOJu0YzaRrtHvOJo6ziL8PGhJ1oo0Fnlhe/SHzDzDd6J4cLJPfRO4MOA
 10dOb6CrgU9jwQjnXaDgzQlySwEO78JImByrScM4QmmvomOkyCeojzkQJvK0fBP1xbGli3Q/XiW
 RC1r/z7o4XKDlyqD5XtRGLYw6bV2fl2zxE534nGZhcMiQpzYNACGR
X-Gm-Gg: ASbGnctNGL2P8JRjN3JzW+fc89/v9PX9Nwdqbdvww0nj11fVmFq8GfzrKiy81aKQGll
 Q52Xe5RZ2UaBlxPrE7esBLnMsmAsRtWInmv5K59e1sNYaHvFyjOaj2nLEckhg/rUhyRN8jdoSTw
 syDvsfquG04BDmO/TovDsPNjK9IYagSKhqS0zwofxlxNSHRWfEOZaHw9QzrxdcbOyrFBwkrt41P
 McJuxlzNKfkCL1y2or6N4HJbc68Kl5UuQEIV6m+Vkpj1Wzho+iDmd19r5RC8uNN/HD2Fu1IGx5X
 okBg+niQHa9u8ubCQ7oe
X-Received: by 2002:a05:600c:1c8c:b0:439:9f97:7d5b with SMTP id
 5b1f17b1804b1-43ba674cb46mr55503995e9.23.1740809551862; 
 Fri, 28 Feb 2025 22:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXjPWXMFKrJDW2VV28UiCA0PpqW4i9rwjzW0QSUNkhLn+fjm7W8g3wiJ1dZdUlPoT4WsLkog==
X-Received: by 2002:a05:600c:1c8c:b0:439:9f97:7d5b with SMTP id
 5b1f17b1804b1-43ba674cb46mr55503815e9.23.1740809551470; 
 Fri, 28 Feb 2025 22:12:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-390e479608fsm7444660f8f.14.2025.02.28.22.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 22:12:30 -0800 (PST)
Message-ID: <fc1f2750-f4c7-419f-b667-301fb0bb2edf@redhat.com>
Date: Sat, 1 Mar 2025 07:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/keyval: fix msan findings
To: Patrick Venture <venture@google.com>, peter.maydell@linaro.org,
 armbru@redhat.com
Cc: qemu-devel@nongnu.org, Peter Foley <pefoley@google.com>
References: <20250228212039.1768614-1-venture@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250228212039.1768614-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/28/25 22:20, Patrick Venture wrote:
> From: Peter Foley <pefoley@google.com>
> 
> e.g.
> qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
> qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>

This is not a fix, since there's no bug to fix.  It's just the tool 
complaining about something it can't reason on.

Paolo

> ---
>   util/keyval.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/keyval.c b/util/keyval.c
> index a70629a481..f33c64079d 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>   {
>       const char *key, *key_end, *val_end, *s, *end;
>       size_t len;
> -    char key_in_cur[128];
> +    char key_in_cur[128] = {};
>       QDict *cur;
>       int ret;
>       QObject *next;


