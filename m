Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CEDD26D8F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHVU-0004x5-Od; Fri, 09 Jan 2026 13:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veHVI-0004sB-Bn
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veHVC-0004bu-Gn
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767984383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w/OvfdGk624cAtXZGspHMQSdAQdutIyavYKPD3pOgVA=;
 b=ZKffYZGECn5pHXuyE9oXQM4bbIFESJkqokv3AMcMaYBIPogwUwzp7w2F+wuF7xbwXhRVmi
 vHlCkLjBx+NcdcNUcARGAwq7mv942/sufgqsB/SejeDM1jNiOh5Rj5gTgmTimV3l7DeLYB
 ZGahGo4UQAmXnL++Zqdb+xJhJAXhHB4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-6Cit8MkuPwOEYkg7fOgJjw-1; Fri, 09 Jan 2026 13:46:19 -0500
X-MC-Unique: 6Cit8MkuPwOEYkg7fOgJjw-1
X-Mimecast-MFC-AGG-ID: 6Cit8MkuPwOEYkg7fOgJjw_1767984379
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8012456296so439707266b.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767984378; x=1768589178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w/OvfdGk624cAtXZGspHMQSdAQdutIyavYKPD3pOgVA=;
 b=Q/XvMlntOY6zlU6LYloO8jd+R9dT4UvUDQCUirQqqI4JljloCUOZKc2hJgXH2z7/gJ
 1mWeAiqOQVkKLpxFZeCuEVl1N+yT960pHPvtfdM4XUrH8R0tMk3YYC0xtjtPna1AEFd0
 qB78wI79OrDoUWFviXrEq932mME827hlGemyK6iKepBJ9sxYwjB8SGzBNtWwdLwn+7TZ
 AUGSydvgg8h+CVVfj6ZZDipGuYtN3I0IKKqkymm0ST3doUJLPpNfOUJCcmNaLGyzPlE5
 LxIY6gf4jvLWszG65ZQYtgQMrKZZV0u2LQJ5jP+svE3dEltefr3KLy8YKffY1nF+aJ38
 qFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767984378; x=1768589178;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/OvfdGk624cAtXZGspHMQSdAQdutIyavYKPD3pOgVA=;
 b=DbimMCpVkxHKHOhONKXvYnAgH4xBZHbeShovOfUEa9yb31t+p6trwYHxEl0w6Zc92a
 EEj2MB95woQg3BbYeJHWZ0kaBw75BviAc4rvEdq4XoAVLdUaEX1+cbbLj+B0APeMawLV
 fzDuAz0K8y0cWpJLeaFebtPqtK+9qsreKrVY7Ep+vMgUPLXc0Vs/Yj0+9PGlNBf3du+G
 VNDYXHcEi7P3hqA3bQyRPJb3xd6J67L52hdKw5yHFnnyRVeYrF9WVRlG70KSgAQXkuuS
 fUkkHVMHcqfnWfqEGWdEBmfZ4VceJKS0hm+Hs/mVTv6ziU37zWmqlcBBocQW/7qPMBBq
 B5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbsqMifoYhs+VaHs9SCaaia83oh7/vsUVOezVG3aPLz0dLh7/Z2tNWPWSYmX7q353cLfonPCRzxPE2@nongnu.org
X-Gm-Message-State: AOJu0YwmiTjKm7MQY3yP69pql6mYtrjbrYwTYJuUrrX4O6PNE3JDmhLa
 jn1KPjkGuHhwJ1jKi/QBxhxONk6LSiyA+W9Y93j0i8ZZ0OWTIiG+MwNW4bJLvItSEHVEb73WsOL
 qxg2+bKuAAKSfrEH9Le6e/oEjc3ss1qoZAPu08euDmN/wZXE0IxMmBZia
X-Gm-Gg: AY/fxX6ls3XyH/Boa3FA4Uk4GWHrccKOwvemdPogTJa+Plhu2Hrb+IQ4Y5y+6mi/m14
 f68zFpHcLX2vTC2W4m8Q+m3ombq0m43ChYUOA0cXeibX1t84pZOssoLCpO1FhbucURFncq2uQdP
 azeg3aR3WJIiIYm/70Au6+Mc2O8CJn8+eupCVivY5SU/3eOY/xRhysAj2OTsAV3FXZeRPx1CLFZ
 DfrrXyW0psS62ovdkyqfU1XPlNTTmOHRL1rfCF96z7yZ7MQoCFOlZ357tSQgLPBRBBQhT95Dpe8
 AuxrM5DYK7CxfqTyIz2vPI2T9pEplaQhxqU3AR68X7PkKK51/faRWG7bt+yIse59s/k/6uUfPgg
 7N7s5/jY=
X-Received: by 2002:a17:907:268b:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8445283562mr1094916166b.27.1767984378634; 
 Fri, 09 Jan 2026 10:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsGuRTX9xJfDXPztcNW6vQNlbvDmKgkz1pTKlLlKFxKJSsI9QqJyufJJFOuEuf+zMB+iew0g==
X-Received: by 2002:a17:907:268b:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8445283562mr1094911966b.27.1767984378143; 
 Fri, 09 Jan 2026 10:46:18 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf667fcsm10816209a12.29.2026.01.09.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 10:46:17 -0800 (PST)
Message-ID: <e1b6bab8-f42e-4983-ba1c-853d25ec0116@redhat.com>
Date: Fri, 9 Jan 2026 19:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/29] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-20-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-20-zycai@linux.ibm.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> +static void cert_list_add(IplSignatureCertificateList *certs, int cert_index,
> +                          uint8_t *cert, uint64_t cert_len)
> +{
> +    if (cert_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring cert entry [%d] because it's over %d entires\n",

Typo: entires

... but maybe rather change the sentence around it, too:

  Ignoring cert entry #%d because only %d entries are supported

Or something similar?

> +                cert_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }
> +
> +    certs->cert_entries[cert_index].addr = (uint64_t)cert;
> +    certs->cert_entries[cert_index].len = cert_len;
> +    certs->ipl_info_header.len += sizeof(certs->cert_entries[cert_index]);
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comps, int comp_index,
> +                          int cert_index, uint64_t comp_addr,
> +                          uint64_t comp_len, uint8_t flags)
> +{
> +    if (comp_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring comp entry [%d] because it's over %d entires\n",

dito

> +                comp_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }

  Thomas


