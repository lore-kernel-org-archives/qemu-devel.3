Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C74CE9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb12-0002pd-Cg; Fri, 02 Jan 2026 04:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb11-0002p8-Eh
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb0y-0002sE-Vi
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767344407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=imx4UItI+el2nvnuh4SU4RxGqKX4d6ACLx/C77TkI9Q=;
 b=W4qB5iYe2Jyzw3lMcKAOpbOZji90O6yMsdr+uQq/n4LDkrLN+0/Y1bA7fiQkOhRFJILt/v
 AS/wkJS7XZ4wuA38Sb0revfIRD1aOasynVU/ZRtoGmnrjKxAesLw6K56V24m4DDkQfvqdG
 PzricHnH+q0pJd+bGnO49cO+OIjucH4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-MEuQA53ONAq4wiUJQaHQrw-1; Fri, 02 Jan 2026 04:00:03 -0500
X-MC-Unique: MEuQA53ONAq4wiUJQaHQrw-1
X-Mimecast-MFC-AGG-ID: MEuQA53ONAq4wiUJQaHQrw_1767344402
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so74381845e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767344402; x=1767949202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=imx4UItI+el2nvnuh4SU4RxGqKX4d6ACLx/C77TkI9Q=;
 b=KN8ojNJr3hcUQUr66BvdujzXWC1jNyybtq+ARznhyQyUwlpDsZ/xLXk8BKHUe/HI3K
 FG+InjMkZ9nQYqiwLD0N0O9YaQZ02W/9WyslDa0mlrJS+AAkrDgyM1xsYWtoxfkOBMD5
 lt+PN3irJ3kPo5tk4higV7Wceubg22Wf5wE+yrfyfbAdWoKIz/oj6aQt6B3FzL1Ewqkc
 Ecl2ML7m6dwSdGkd3iipoCTALoC0xMDEGUq75BFortyy/8uNV3HykqbZFlFdmnQRJpel
 wzeMK6b6SIjE5S8kCrfyodHzSTt2zHzDt6ALk3hYXMHj5Sn9txfpbtzr4YpMCzaUHPfz
 rdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767344402; x=1767949202;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imx4UItI+el2nvnuh4SU4RxGqKX4d6ACLx/C77TkI9Q=;
 b=Gbadt9vt5jaRpW/9T2RzPC9nVLc+dQH63KuFj2xvc2O3sS8HHx1Vyx0/XeGx2OeZK8
 xAR6ePpdmvU1qgfWyry4SYy+2vV5h9E3Dcb2lXMKU5+CYf75BdRXzZ9ih/Pq9rIZ5RDC
 vwMroiCpPzcraEC8lWjS2uu5NHXjeK8u0WexzaA05rGgOXPti9iOkQrjbmFz58d6xMd5
 1Y44TvFqm20oE46SlA3y6TcUQ3zvoDsEUzwRaskg84DHgVV7janKDSlWymBvNCf2LnM9
 kagpPwIoPkgsGpNNZXkl17HIhA4199pJcwo1CffseTSB6SqLQ/wjSAmyzX3cjWyf3jdK
 yldw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDy1AUVV/kxc3oKjit/xg7xSsHZaGQUCy8dH/7KnykSA68eZrJw5qKs9HggH2npiKXeUWXAoSWS767@nongnu.org
X-Gm-Message-State: AOJu0YwW2e/hMwpjaY64uVzt3byqZ/PXqUj93T8h2AF6dOAyHypWdIX6
 jnNN+Gt0CxSzM4nkuTzMPPaaDH/GC/Dpau5/csn5rKQtiWo9gpqvSqk8cMxOx4fNEv4ZOiCTXx3
 m4fxzjTuXmwYy/9O6Y78c3+2hlzh2uvwaHyG904kEBhaKe7mhLgce0NCa
X-Gm-Gg: AY/fxX4des8FVRE7uMirE1f+5+O8Lz4u2AJ7uX5KSo+EoTJoSTEl+G6bjk2EwJh0SWd
 3y7hSai0HnOgQfzatd9GALZRa3jXn3mbUqCeHxf3rk4bdfCVS5UTpD8rGvh5EI2x7ZROidzu2Oh
 7exK5bhybdkuSv/8O+Ap1BC8hAbcuQqJ+TAb7de99WnD9yOSL5MdwrqLJ7eDfs/Kph2TfVWU6+2
 xqRKzmrKfk4VFg2q/IqYAKT1uU4DJOm60oR0Rv7VwWwuaV3LCb7+CdHenCEYQsYwOms0f6L5ph0
 MvrWz1+++cwiNtnSbUEQBxScHHkA+g1+t+mPcZ7E0FdE2D4PPKviYqEg15o7+d+a0JldYFtCoq7
 Ci+Z9jB4=
X-Received: by 2002:a05:600c:c0c7:b0:47d:264e:b37d with SMTP id
 5b1f17b1804b1-47d264eb725mr365540885e9.22.1767344402433; 
 Fri, 02 Jan 2026 01:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTbAz0kqD8Nc6dioMOIEdxv6Dl7qjoB03Pm4rRXz0Rvyj016hgvDzSL4q9LlOeZ7Qd9SF2NQ==
X-Received: by 2002:a05:600c:c0c7:b0:47d:264e:b37d with SMTP id
 5b1f17b1804b1-47d264eb725mr365540695e9.22.1767344402019; 
 Fri, 02 Jan 2026 01:00:02 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193522cdsm701270785e9.4.2026.01.02.01.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:00:01 -0800 (PST)
Message-ID: <55dfe9c9-448b-4d62-b4c0-7114a99e568e@redhat.com>
Date: Fri, 2 Jan 2026 10:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] MAINTAINERS: Fix coverage of
 tests/functional/acpi-bits/
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20251220072416.3745923-1-armbru@redhat.com>
 <20251220072416.3745923-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251220072416.3745923-2-armbru@redhat.com>
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

On 20/12/2025 08.24, Markus Armbruster wrote:
> The pattern tests/functional/acpi-bits/* covers files in
> acpi-bits/ (there are none), but not the files in its
> subdirectories (there are five).  Drop the *.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..fcb60c0c02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2183,7 +2183,7 @@ ACPI/FUNCTIONAL/BIOSBITS
>   M: Ani Sinha <anisinha@redhat.com>
>   M: Michael S. Tsirkin <mst@redhat.com>
>   S: Supported
> -F: tests/functional/acpi-bits/*
> +F: tests/functional/acpi-bits/
>   F: tests/functional/x86_64/test_acpi_bits.py
>   F: docs/devel/testing/acpi-bits.rst

Reviewed-by: Thomas Huth <thuth@redhat.com>


