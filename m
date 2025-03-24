Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98520C36001
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 06:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twaw2-000652-B4; Mon, 24 Mar 2025 02:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twaw1-00064u-B6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twavz-0001Sa-Oh
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742796310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8mArOeIXTx7Qvl2KmCV43o+fXI8Eshm+aHXwitJkRU=;
 b=OHBl1w2VC2ldjm0J094odiTEMIBzUQG0LoA1U8LoyUPQmhyfTWq5i80vPJveL4Hw6S9zaY
 Q69VmMWDGVUvY4wAe/D/I+Ppl3Ua8+04hkml2bJm8E+oGM1NIGUFuS6TLiQWW7pthSYsMA
 qUPSv4V8Mw+3hj2eWabXQCeLgb0jsiw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113--ZhDXr4KPH2QlCrAQWU1Gw-1; Mon, 24 Mar 2025 02:05:08 -0400
X-MC-Unique: -ZhDXr4KPH2QlCrAQWU1Gw-1
X-Mimecast-MFC-AGG-ID: -ZhDXr4KPH2QlCrAQWU1Gw_1742796308
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e6136633b1so3073604a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 23:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742796307; x=1743401107;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8mArOeIXTx7Qvl2KmCV43o+fXI8Eshm+aHXwitJkRU=;
 b=nVSMYl3MlLKjV1m1vAfjZf34j74bqq5NwktWfM66P/0y+7EwrfKECXhRv6dWAdxlEz
 y8ml+bLV6lFnpdcDoJXhbfXhbj5/5mZmC9aWz267cNlDusY4m+XMdJNGIjj55cbjG7CR
 iTAoMG2h1y9pEU3xTC27SeTOjp584TQHqaAfcaeE8Nzt9rbyRRESzyD3HIGm1KWDAklE
 eWebmxRYuHC2Efpdq4oSdX+bWwRnT8XFbNoEgJCwJwOol/LnLVf6dstYTEU3HdzwZKiK
 VuF0wBQs95Jk3XXylhdkGdG+5XHWAaVI+0EC4lKBwh1zgPPkCOkdenh+fiSLukLX1hOe
 sfKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscMge5RkKJMlr6bshI6bRp4PYKaGbwy2GUk/0k7vvHS0/CBAbQMtH5oDf8wv6dNXiG7iVxSSAfWa0@nongnu.org
X-Gm-Message-State: AOJu0YyUEKFqlZTwDfFGb8m+n49gT7j0WAnjSg1CQEhqQHya6upGnwIT
 7VH0KkeoBvmqW0pS93dBgKXQqd0SK/9uFtE3UYgRnRCB5tOwaIkRjgDXrJKjSlrbhkytb0gJ472
 jGecIaGnnCP8tDyudzVmIOLcJAKFVb97Xfi3EnOtsJ4G9I9y9myPt
X-Gm-Gg: ASbGnctwvDz/Je1wA6V+BjSX5QJs6YkJHDUGObnAm+eJaapSsT3dKtNptEuvFJt9W27
 qxEt9JjUGEq51k3KbFH+UAHn24VsbWMB6i+UKVVBRhlj1C57WeETDiO56zBV19RxKGssn2Zpado
 lYClHnVwONwEB+PL4UiAJXIjrZj8OPGI06+xx7ZOZRUTt2tcA0srVIbrTC05f/aw7dYXqFNRBHB
 IoJqy94huvPScJNVvOVv+TI5uogOSn4zi1T8QMAASegCba/iL5cgoU72BXBTECg7QS57DL8Xj76
 /lruavXR9wl5xTEYw1Of4VQzfkTDScBruUHXGz9zLg==
X-Received: by 2002:a05:6402:2551:b0:5e5:bde4:755f with SMTP id
 4fb4d7f45d1cf-5ebcd433fffmr10922692a12.14.1742796307596; 
 Sun, 23 Mar 2025 23:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn5Hb14jKl0WIwfCzUn5qcLe4DzaFRQ5Bb96oQMQOVk4/5urLgVy/0mRFf2+lH9lJuR0pjuw==
X-Received: by 2002:a05:6402:2551:b0:5e5:bde4:755f with SMTP id
 4fb4d7f45d1cf-5ebcd433fffmr10922677a12.14.1742796307195; 
 Sun, 23 Mar 2025 23:05:07 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-2.web.vodafone.de. [109.42.50.2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccf84600sm5523859a12.19.2025.03.23.23.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 23:05:06 -0700 (PDT)
Message-ID: <b2a99dd6-3d19-46b1-9ef6-ee799ac7e021@redhat.com>
Date: Mon, 24 Mar 2025 07:05:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Fix a typo in s390_cpu_class_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org
References: <20250323153018.73491-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250323153018.73491-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/03/2025 16.30, Philippe Mathieu-Daudé wrote:
> Fixes: 41868f846d2 ("s390x/cpumodel: "host" and "qemu" as CPU subclasses")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index d73142600bf..1f75629ddc2 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -377,7 +377,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>       resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
>                                          &scc->parent_phases);
>   
> -    cc->class_by_name = s390_cpu_class_by_name,
> +    cc->class_by_name = s390_cpu_class_by_name;

Please add a proper patch description next time. I spent dozens of seconds 
to spot the typo in one of the words 'til I realized that it is the comma at 
the end ;-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


