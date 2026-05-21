Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD286CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzMf-0004Lp-Jz; Thu, 21 May 2026 05:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPzMe-0004Lb-64
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPzMb-000458-CL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779354403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2noWBtuPgFh7MkUW4sqR1vRJYRpLXxZIDQdEnFYtFlc=;
 b=VQU62PyRwGr1JOCcC+YuT0H0apDOh/k6A9X8kj2e7pJxoQDsOdzDDYFvku9qlA1CoI8JMs
 jOiyz4JOCtqJHFBCDrYWMqeVxm42gGnib4l/Lluie1H/agbv0PhqYANVxQ+tSvvPlxyr0W
 zJvGOA0ZODZ/H+eg1qeeQsIDC2DBKqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-uvvFxGYjNmGIvRqeb_O90g-1; Thu, 21 May 2026 05:06:41 -0400
X-MC-Unique: uvvFxGYjNmGIvRqeb_O90g-1
X-Mimecast-MFC-AGG-ID: uvvFxGYjNmGIvRqeb_O90g_1779354400
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd2b502e2so50353255e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779354400; x=1779959200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2noWBtuPgFh7MkUW4sqR1vRJYRpLXxZIDQdEnFYtFlc=;
 b=L0ooKjhtXc1jxwFWYvTRKCysOW1Dl2qXVeVr7WrbSKW1/PlHwVUL3K+mAMaAH3QH+g
 PDkivVas4PcsrPXr+5D91KiDMG23+mXFx/0kaYUh2HJVu4AfYAv4lbTt4UAhNUcKcBc5
 IZrZH5JltrCZMV2XrcLpPh8ydTTX4SDJtpPl92Vb7gEF2IrqO6NvmDuT74kySalsJUrb
 Fpb3GvgUpcxxYEVQsLtwfQZg10IRd6G9uaeXmCNhxUD09Q/uNeJc47APm4HyWdt7oi9C
 qAyk3TwlwbyJy2hLS1gjrzBzL6BgaVTZmYqYhw3syIcgPbMbAfBbOwHaGTQxo+a9b8DI
 3l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779354400; x=1779959200;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2noWBtuPgFh7MkUW4sqR1vRJYRpLXxZIDQdEnFYtFlc=;
 b=bKCsauKH6GJ4pnqC/Di4jvdH0Tm/TKDoRxdp3GqTE9h0/WW+W1LRsya91VTiC/FfR8
 Km0KkZ+cKI/PFNJvm4F8D0t/jMHMkczgeUqc8OJ97CnSoarkLQxOXUGuxm3TfV/n8P52
 CJe+BkK9VmM2J+YnS9KDjhzBFqN+Yki4Je9Wtw4TXqzHP/dBHw0FhCVCsNJAxmPA9WGf
 Vsg6GczjFmlsihPq6Q9vprTOni0vsZbP1C8KrQzs2YzeX0kvXJfGNwgMnVqRakzdkrzc
 heZd3rgqU70b0jKl83JnI+z0kVb6sq+4GZc+kZro1f17pJtpGjqEzdQyzqOqu58vR7ca
 ISGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xdoJzbJb3486YvD84pbchv5vULhPyGv8i5Oygv/dNqsAp7nTW5PvampBxbsp2U4LRNwnmfgtIK8jX@nongnu.org
X-Gm-Message-State: AOJu0Yys6Q+j8LTz+Xzwyg13i8dtqizITOVeXA4Lnf3xPDSXAsRCQ7ak
 V8MmxXJrCu9LNtZN7Dmw/Q26t+4WVxAM64IcUfBWMaGCuLtR94BYJfKgwbehuuYKLAaEXtGjHb7
 505M8HbZ/oIkmKbhJdvvVAyOb/ePnkOhHknzUE3i4hOaakE14WRnkhF2o
X-Gm-Gg: Acq92OH3CWRPkYN1yL19DnKOs8oPAS5JzT0WUgNhpNWfsX1Hu6Oaj7D0shRbIPe529I
 eoUOLzpaK2yy7KXiTqKZsZkzvvcaVlo7qB42+Vi7DNxN5vuULRQprS7Z+hkS3YAYZCGdjtVl57W
 uzpt6JTzxpSrackaM0ewNtXkeY9h5EGiWrmFgLiHcVo5S2tbTXB5OhJ1I2Aer/9BQp5c5bndvg8
 T/LUYIfbOu/eYP7PNU2BAcMbr/5etM1iXIA52uo5f+lGGxw8iD8Ch5CG3kbH9bQdItf+KerB6CH
 0lwWiM6jCltO50l57zDgG7OhOOCvmr+HT0aYTTVOB3GWZuk/SLUJ9JLxHSc0tVrWgoafEAD2ZtF
 8Nt5TJdQQYipXHpwmRud4xs8egEQj7Q==
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a1b with SMTP id
 5b1f17b1804b1-490360ecf11mr24140285e9.30.1779354400391; 
 Thu, 21 May 2026 02:06:40 -0700 (PDT)
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a1b with SMTP id
 5b1f17b1804b1-490360ecf11mr24139895e9.30.1779354399975; 
 Thu, 21 May 2026 02:06:39 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3515asm59195555e9.1.2026.05.21.02.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 02:06:39 -0700 (PDT)
Message-ID: <7468ff74-f558-434a-99b7-13dec1784f39@redhat.com>
Date: Thu, 21 May 2026 11:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] iotests: mark 151, 181, 185 & 308 as flaky tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260521085148.1492614-2-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260521085148.1492614-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/05/2026 10.51, Daniel P. Berrangé wrote:
> Introduce a "_flaky_test" function for shell based I/O tests which
> accepts a GitLab issue URL, and causes the I/O test to be skipped
> unless the $QEMU_TEST_FLAKY_TESTS environment variable is set.
> 
> The equivalent "skip_flaky" test decorator is added for python based
> I/O tests with the same behaviour.
> 
> This is used by:
> 
>    * Test 151 which fails in QEMU private AWS runners due to failure
>      to make progress in time
>    * Test 181 which fails with a non-responsive QEMU on AWS runners
>      with the QED format
>    * Test 185 which fails in GitLab shared runners
>    * Test 308 which fails to see disk usage increase after fallocate
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Previously posted as part of the larger I/O tests series. Attempted
> to merge but it failed on AWS private runners, while still passing
> on GitLab shared runners.
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04939.html
> 
> To skip the further tests we needed changes to iotests.py too, hence
> posting for re-review before proposing for merge again

Looks sane to me!

Reviewed-by: Thomas Huth <thuth@redhat.com>


