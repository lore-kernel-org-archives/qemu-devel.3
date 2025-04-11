Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77795C369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Bs6-00055n-B2; Fri, 11 Apr 2025 06:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3Bs3-00051v-L3
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3Bs2-00007b-2R
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744368264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3kP+g8Jo+XYNE4nzh8bdED1stVeiqxY5q1ONgoQqZs8=;
 b=F9rXBGHOu7Q1ZuS4zdEb4F/Yy8f1rhREtIigvhMg+QDGLNlAvsroIoBtzXo2Gf/PJByjxw
 gDsBBYro/Ku3r/oRcPaLU/xrm18h0RvPm0LCGjTft8ZU467Al25Le6XGRpg4W0BLTe1tWX
 L9N5ZymZIYwkfrlQ/KLQEKfDG4ChnaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-4p5OZqZLNaifGWf9A4tLiw-1; Fri, 11 Apr 2025 06:44:22 -0400
X-MC-Unique: 4p5OZqZLNaifGWf9A4tLiw-1
X-Mimecast-MFC-AGG-ID: 4p5OZqZLNaifGWf9A4tLiw_1744368261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso12757625e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744368261; x=1744973061;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3kP+g8Jo+XYNE4nzh8bdED1stVeiqxY5q1ONgoQqZs8=;
 b=tYtotq/d0Y+wz3tvjhEvwctDSpyQ6JSD/EHyeo/ROsFwNtFpiYvJW68Ewd19BoOEzG
 c8eMPeKM4tTKUw6UOI0jstLcnxnUG4i8iPYbia/rmAqygJpAYo3a7QFqfJX4SNoVoA+P
 ulEE5Yk/dejla+SYOS0p6U73oujQnYQT6Ke4/n2DxRVHGXGzsgp7LCjwoFJM0tawczlN
 nx3vbPUYvLcM2Kry4pRHzjkMCxvkhnExozrqc0kD9h+lCPouLEip/MavEPF70nru4809
 fwAUZzkP8vp3/SBSiSmbhOge0QKrECJWOjDxYFqhwDwCVyx4DKkFhTw9mfbbPfRKaiwz
 /tXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhuYloM7aI1T84KRXBeVWyOdeanCr/NBy8xXSyw8HA38fNx6e9nO0WcB5F5kyOhPetW7ERhEzP1N0P@nongnu.org
X-Gm-Message-State: AOJu0YyAJWk5Oq1PU0DhBE/FbBvtMWd86F//6Kr1R5Xc924zuWvlvqVy
 nC6X/CTKnmg3tEpZam1dCI83/5AAqMN+gJuWhcuQacYgSIJIUnbnYn5jHUMbNsgtzhtmS+MQLCa
 QAiS7k0uO3lQLNo1mgY+DQewBVy1NGiBaMed1bKI2JVEZOnso+nNh
X-Gm-Gg: ASbGnctql5Vctblbq+V4ElZLUTIJxTGzifPdfM7AUAMvOUxKKeDQHfTsno7JVSE49vN
 vf073J0FWnQ0YGKOAIuI5Lbwt4v+14n3qOPMtF63p1pIqqv2eFh0TiYs0dbH+hr3StRj2vrvY+S
 P4uKQWNhyfcuqBGCSknTb43/gu30gZaq2IRVOAt+6+KjizBqqdeUVUI+335DUxEXXJqjCJe1wcD
 V2D44oX55Exp/oYqy7rULjAd+ePiEMeSgm1aK40angM1gfBB43c5QBERkksdgZNcTv8RbzxSbhs
 k1mwD/CWWouC95/Yv6thQOYvcVOwdeEg+gMIL4jLRzo=
X-Received: by 2002:a05:6000:4403:b0:39c:1257:cc28 with SMTP id
 ffacd0b85a97d-39eaaedc75fmr1287999f8f.59.1744368261416; 
 Fri, 11 Apr 2025 03:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6Ojgefj7j7zmljR2U7+ymxTtqd9EOozoEJYxll8siUa1vI7yO9CemjsDbZ66dPRkxALalQ==
X-Received: by 2002:a05:6000:4403:b0:39c:1257:cc28 with SMTP id
 ffacd0b85a97d-39eaaedc75fmr1287978f8f.59.1744368261037; 
 Fri, 11 Apr 2025 03:44:21 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207aeaccsm81571295e9.33.2025.04.11.03.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:44:20 -0700 (PDT)
Message-ID: <2e8a1ccf-5073-48dc-9641-c80d95d65b93@redhat.com>
Date: Fri, 11 Apr 2025 12:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/24] Add -boot-certificates /path/dir:/path/file
 option in QEMU command line
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-2-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> The `-boot-certificates /path/dir:/path/file` option is implemented
> to provide path to either a directory or a single certificate.
> 
> Multiple paths can be delineated using a colon.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   qemu-options.hx | 11 +++++++++++
>   system/vl.c     | 22 ++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..b460c63490 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1251,6 +1251,17 @@ SRST
>       Set system UUID.
>   ERST
>   
> +DEF("boot-certificates", HAS_ARG, QEMU_OPTION_boot_certificates,
> +    "-boot-certificates /path/directory:/path/file\n"
> +    "                  Provide a path to a directory or a boot certificate.\n"
> +    "                  A colon may be used to delineate multiple paths.\n",
> +    QEMU_ARCH_S390X)
> +SRST
> +``-boot-certificates /path/directory:/path/file``
> +    Provide a path to a directory or a boot certificate.
> +    A colon may be used to delineate multiple paths.
> +ERST

Unless there is a really, really good reason for introducing new top-level 
options to QEMU, this should rather be added to one of the existing options 
instead.

I assume this is very specific to s390x, isn't it? So the best way is likely 
to add this as a parameter of the machine type option, so that the user 
would specify:

  qemu-system-s390x -machine s390-ccw-virtio,boot-certificates=/path/to/certs

See the other object_class_property_add() statements in 
ccw_machine_class_init() for some examples how to do this.

  Thomas


