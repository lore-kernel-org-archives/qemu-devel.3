Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCDC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 06:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfZIH-0007cP-Rs; Wed, 05 Feb 2025 01:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZIE-0007bZ-QX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 01:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZID-0002rf-Bf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 01:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738738428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FQpotS8t1qpAV2RXMssVYH0ipPbjKzLpPtYf0S6kgz8=;
 b=af4YWwNWuCyzeiXTgUJpIkZKsKfkZnuz2dwWjqJE0CXSF+PhzgOUXhf8wWLlbQOG/wmgDt
 IER1vM2t8gmGTVvIXtixdsrus5kf0xaSWyDu1kuMY53Ssq0Xwp+sIpav7IflKXVR/hKB1K
 EqknNm67G9rSVz9ui1XbyRG81vZpMco=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-I0V01Y_ONCWKI2VkWKNAMQ-1; Wed, 05 Feb 2025 01:53:46 -0500
X-MC-Unique: I0V01Y_ONCWKI2VkWKNAMQ-1
X-Mimecast-MFC-AGG-ID: I0V01Y_ONCWKI2VkWKNAMQ
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5dcd8f32414so738921a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 22:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738738425; x=1739343225;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQpotS8t1qpAV2RXMssVYH0ipPbjKzLpPtYf0S6kgz8=;
 b=SPTGahgCBahUm+5+7BWERmMzc6dRzCI9TbYkcaNKm1FZZCFDCCT81umBflVUQA6TRg
 6ReAoDLIl0fyzYTjgwjLI0ALCPgAp37upGzHzPiHs9igvbFnPkf5RqXNJuC26v1HRRTX
 nos9G0gx6Oqy0+B3f3ZvnSx+P8t56cgOsXWfjIQsEzDVcFkq//1d7ZLRhUujuFZdS6+x
 gez1+5Kb5hrLwAFGq+C4WjgA+0qIARpL4XArV5IXkgtk1Jh4PB4KGwrsiQPPfJfTl9m9
 WnvJ69qTJETmqA0wCn8+IMBiZhvInlLThe3RKyndSQnL7ZYlYooba8I1BaW79bqz5v8u
 qK4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWol0jDqDkCv69iryToctr5sVAlJ9c4NPWnJEYB8y9SaSpm6G67uUzEeBYQlGYVxUdPQwU3osk9mINW@nongnu.org
X-Gm-Message-State: AOJu0YyhD1aknTWrhjko6AA+BKkJCDvpGmdVT72qOBREOT1hsZPpBkz2
 +oqh4sH2dnluE2fz62LNyI7Jrs5cLeL5hLZ0bHfUsZEvZnaZ4Ud0irtXro3rI3RcUYFDRlPv7D5
 iuS5U7ic+ZX+vspBKoX5J4jiHmLYaQioNCyWripfXy60c4Tspodhb
X-Gm-Gg: ASbGnctGnkgNMriMCb9EkR1lv5pRfeM8XQIgLjyFlxQKbdeLFcO7Wr4CFjqs64rOLGz
 wdgtYd/kKdI1t3hliAxvQcF473dT5BNsmIm/fVG6G2jeQO3VfO7cCuGyZpfRHA7Rjp/5CfIqaN5
 NOANpJgKE0ozMkRduOUlFOb3lekLQpeg52X8HQijb+ItEoZaxBX6eBEX3We2bH28Aze/EeKkcbV
 ozsAyO5DQGeJBZzudz9Um+P3jfGmxYZd2mTdk8bEo4pTBIWWIq/q2eOgEvaWMTyVdLtDDVw4uMB
 dhx9mvPIZd7dhW59pMvlkTw7QsCiv81h33Ec
X-Received: by 2002:a05:6402:5d0:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5dcdb717872mr1901031a12.9.1738738425507; 
 Tue, 04 Feb 2025 22:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnccPqJ8FKGxkGApvGZREbbLrZ3DcuXvk9yLvFRWvt3+JrnEh/IK6vDOFSkFDeZEl819avHw==
X-Received: by 2002:a05:6402:5d0:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5dcdb717872mr1901010a12.9.1738738425134; 
 Tue, 04 Feb 2025 22:53:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcc6617876sm2202543a12.73.2025.02.04.22.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 22:53:43 -0800 (PST)
Message-ID: <e74ff709-3c36-4d2f-94e7-60a80a5c0cc1@redhat.com>
Date: Wed, 5 Feb 2025 07:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] meson: Disallow 64-bit on 32-bit emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-11-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204215359.1238808-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/02/2025 22.53, Richard Henderson wrote:
> For system mode, we can rarely support the amount of RAM that
> the guest requires. TCG emulation is restricted to round-robin
> mode, which solves many of the atomicity issues, but not those
> associated with virtio.  In any case, round-robin does nothing
> to help the speed of emulation.
> 
> For user mode, most emulation does not succeed at all.  Most
> of the time we cannot even load 64-bit non-PIE binaries due
> to lack of a 64-bit address space.  Threads are run in
> parallel, not round-robin, which means that atomicity
> is not handled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


