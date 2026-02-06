Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA36EE20A0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voM7l-0007gV-U8; Fri, 06 Feb 2026 08:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voM7j-0007gB-CR
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voM7h-0002e8-GC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770385426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tXYCaHxEn323QQFFJGA2Va0sGCkf+2VKGZlgk8yfUnE=;
 b=ak9GKr4LtxEHccaEx2sVvVY21LX3zHg6Cxrg5cJmII+5PgihbtAAa/YBnXxYV/Qr4E7JUg
 6zoF4On8eiTww82icHDDvc1nxCCQgBaWu9rM2KExydTPEw03jNTUe8Ft2S5dF+7j2BKN7n
 CSeUYlHr3maiSIdSFMjCdALrwOklz5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-GvGGGosvMJe6Nptv6BhoWA-1; Fri, 06 Feb 2026 08:43:45 -0500
X-MC-Unique: GvGGGosvMJe6Nptv6BhoWA-1
X-Mimecast-MFC-AGG-ID: GvGGGosvMJe6Nptv6BhoWA_1770385424
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483129eb5ccso26023985e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770385424; x=1770990224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tXYCaHxEn323QQFFJGA2Va0sGCkf+2VKGZlgk8yfUnE=;
 b=CB3ttGQ8iki3YnxySydOTH/I4l3iLFKYAYtdbPjOM6bgoEWUf+zKRqQ+CEkS/9APXS
 8s4dvvRu0kFyCQhKMlOTgK/aHD+s8ltQPzPaOE2UhzHNwUdWFbiKL8ous2aSm23yItId
 vBB3/P57TOuU/t20yb9zDflmji9e9TOo9T3i1239vgpoax1SeVx+pkYGDJXT22a36BKV
 degjSP4MCEGqm7lvd6pvCn4EkqrsXdT/aQp+P2TwM6GAokUrR5+iXJrXe7gg2z18zfQQ
 0icHrvHIoHje2NSflhqt1jigWsY8Kc+sB1wRoH7sV4u62diYbXBi9SL7JsEusG2SvbP/
 OOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385424; x=1770990224;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXYCaHxEn323QQFFJGA2Va0sGCkf+2VKGZlgk8yfUnE=;
 b=CZYaWzQ566jCA9C5H8sNUTuPSyzum+eLnGvx+buBYC2mnwxPvmDLTb+voJjuNme7qw
 SwABL1+0MRZ3MHUFnfiRc+d5urm/fXHYuDxt5uEqiMXip/plPjXCceYc5QOng+Aroosk
 NsNqVMeLAp60Unxh7Vnw7l/9IrW3YIASYOVzefQvF0ctwiWlXfxv4S2qxm4jEksIxUsA
 /m3RaYwCNkMYNJID9V/BnpnTTcTNa4nGTb3rn0Fo/LthX1LFJXqWVsQDra0RfA8VetVX
 SMLq6p5QeW8yXyeZ/xkbKbk98Ohtrnl29CM5nbdXopAPAnCvDmqX89vaL08TeHB+AtPL
 drSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkXXXcPpk5IZXXlN+V05WSGZ8uFJU1DWvqq/M9A4azxV/gq4UYXf0ufpG22vISYe5PTHAsba9nZgP9@nongnu.org
X-Gm-Message-State: AOJu0YwvR3GZ9YG6praPfYE3/NUnZiLaE6S9rLNfOodNHYB0emV49f+w
 BX0mWdGtCgoq+HPxpSursIIhGrPqzkNgoGT86dLWANnV1NfxXFRsdUaoIYkSswRaeL20uQ4+kVk
 A5uH31iBDDE0QSkBRUAiDMGAUGfIyoY3No+gC0r13N6w2y0T7qumMmsh3
X-Gm-Gg: AZuq6aLLUus/5G0gNjIyX0i3c9kFBagla/5D3eDxMsp7aWufZrOHmiKAOfk9ZoKqOsU
 a65/C9gSNgdNjQT41eJN26rpDC51hMKxL8IF3msqkYI4n+8Sis5nT+xp8FQYrgpFW2Z/lDPQcvH
 8qtgFGX/gSBQTtt6P3ivX1tdOy1d0wyGbiTUFQ1wtgfuFWeNLxPIYE4qkeS2MJe9E74MllzHHYX
 PDmTaS/66ztIzDlnSwxUijU5qh/TTZOf4efKExcAja7tvzYOwSMEXAQh/miYGwtyQ4hZBHLwhg7
 JszAfJzmfJJsVGFDqrwDuN013X5bbgjbkYW/c9VD/LrJwlOqRSZwvjYVLhi9m9dvn421KpQeqUT
 7es3/jrc=
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483201dd216mr39726445e9.1.1770385424067; 
 Fri, 06 Feb 2026 05:43:44 -0800 (PST)
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483201dd216mr39726155e9.1.1770385423645; 
 Fri, 06 Feb 2026 05:43:43 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e5b63sm35100065e9.1.2026.02.06.05.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 05:43:43 -0800 (PST)
Message-ID: <6cf141af-a3dd-4d20-b46d-f59b3e39d935@redhat.com>
Date: Fri, 6 Feb 2026 14:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/docker: improve handling of docker probes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260107130145.1495219-1-berrange@redhat.com>
 <20260107130145.1495219-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130145.1495219-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 07/01/2026 14.01, Daniel P. Berrangé wrote:
> The docker.py script has logic to guess the container command and
> detects one of
> 
>    * docker
>    * sudo -n docker
>    * podman
> 
> but the "docker.py probe" command then throws away the detected argv
> and prints a slightly different argv based soley on the detected

s/soley/solely/ ?

> argv[0]. The result is that 'probe' will print
> 
>    * docker
>    * sudo docker
>    * podman
> 
> which means that if sudo was detected & the result of 'probe' were
> used direclty, it would end up prompting for password interaction

s/direclty/directly/

> every time.
> 
> The 'configure' script, however, runs 'probe' and then throws away
> the printed argv again, reporting only 'podman' or 'docker', which
> is used to set the $(RUNC) variable for tests/docker/Makefile.include
> which is in turn used to pass --engine to docker.py. So the docker.py
> command will re-detect the need for 'sudo -n' and use it correctly
> 
> The problem with this is that some commands in Makefile.include do
> not call docker.py at all, they invoke $(RUNC) directly. Since
> configure threw away the 'sudo' command prefix Makefile.in won't
> be adding either 'sudo' or 'sudo -n', it'll just run plani 'docker'
>

s/plani/plain/

Apart from the nits:
Reviewed-by: Thomas Huth <thuth@redhat.com>


