Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B34C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLy0A-0006Gq-Nw; Mon, 02 Jun 2025 01:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLxzG-00063G-Tm
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:45:33 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLxzE-0006T9-FV
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:45:29 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-52f298abd9eso2733651e0c.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748843127; x=1749447927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wgaVQM5JOk0cE5WtY1vo4wuuhYf0EVx9YzGQ7j6Rv0=;
 b=gvkv2VbC/3u0VcmwvxAfLpPIIGtHWG9KfKHdHrtQcbDmhD3zIgK2DDovZCYC+diFmT
 sr5XqT8LkQCOxVdLjJqQ1N4pRAQtowa6RkbI6RP7QYTug2y1Yt5wjGQNgZrezX8C6ojj
 zhV05MKtunniFLaSkogX5f/aI4jof/0CX8Q6qSqUxQCqemTM6Wvi+XV10SdQ/LPUDzWU
 wHLwLBzuBN7ujLAbFq8AMTsexp3aYxMU+l1zickE0UVMp3QTPcDoTkE457II1KAKKGHy
 LRp5C3GxYxlpsVCod8GAD2NgQeEE+aN4YUAoGqIZntNUEOXSUTjQDYSIdTFAUHRQkFsA
 YBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843127; x=1749447927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wgaVQM5JOk0cE5WtY1vo4wuuhYf0EVx9YzGQ7j6Rv0=;
 b=q2pG3lZ+lB7M7Ug2bNQWNh1TDI86aCXebsWq0hvww+U2XZEjTmmtAtnz9neqD6Ujzo
 fXpuBuNKKsFpaUuCKzWPzJjW7dc/3AB0xSNM9DJQhTbHPvJIcsHmJPWvB8mdWmyBhEgW
 s/5k2HZQK7gpbAGVGsWtupQFoGIhFNYT8BQ0wCtMMgFoGlROpw5/500dUgtEfEvdn15T
 Ca8EkzM94Hk5QXvdxcYf56TVnDALfw5T4pmuk3ONNOR63hRy8oY3fsdZsmetvAmWu53v
 +klc4OXBQUyDk5gvbom5Q8FMqyhgDYBCnMlnlsZ3GHOEef1ZU6lpo5C/KY+CnqbOjdC9
 XK5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUMeZyD/wdlAnSRLj4J9GjyNE+9W1ZHtYNM/n+Az4hbxYj5fFhMh/CzJBB21kQ8jalFSpvS9OO0Nbf@nongnu.org
X-Gm-Message-State: AOJu0YzTHtGXl4CHZqZqMVXNDmj5NN1funhfE0u7QX30l6ipAjIfr3P5
 QbqpgeMNoFHTva8mczHXCEYIP0O5i89RyzAmJZc1dUUU83SUiTb8ZmQmhx1XjvKXoYc=
X-Gm-Gg: ASbGncuO0DLocIrE4WgxBVtTD6Fv5IsnV58OA2EmE6VIc4oTlSS5ho4QlLen92pqhmr
 gYAg55DBsqTRa0BUS6UVoocBIkCIugRnyQjjYNX+TyenwUOwnmEe0//HZ61VApLRWrFu2rqZQT+
 VYwgviYo9QX2o/QK/8pK1jAG39FdDIGnG79MCHgdeRJ8v8UV7r+IDOgpWa1CdJxbjeG9aeaNosM
 mo7LYO/W7FYmkFMbHt2MN30WMdh4X0Qu8jHvvYkkQKQDxGH4G1yhtOqzu503RrnTj6KwK0tNuNm
 RNnceSCxS7lKIMrlE/kuM5v82m5KDUSd87GhNfUJ8NjhxnEGE4Mbp8R601SkMvSI0gY5YBAo1WD
 N
X-Google-Smtp-Source: AGHT+IEASqpdTxOXJHi/lxrbmZNTmg4f48ukCWyjorVuYf6dP4OlwoTInpTE4NLeSSvEATcoqYOhzw==
X-Received: by 2002:a05:6122:1da7:b0:530:7e05:3836 with SMTP id
 71dfb90a1353d-5309378fc36mr4325068e0c.9.1748843126707; 
 Sun, 01 Jun 2025 22:45:26 -0700 (PDT)
Received: from [192.168.0.102] ([179.180.194.137])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074aaf305sm6961786e0c.4.2025.06.01.22.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 22:45:25 -0700 (PDT)
Message-ID: <0dc27145-d748-44c2-b6a8-19df16254882@linaro.org>
Date: Mon, 2 Jun 2025 02:45:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/25] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
To: Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-9-eric.auger@redhat.com>
 <20250527143816.39c0dfab@imammedo.users.ipa.redhat.com>
 <20250527150357.03bfab2c@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250527150357.03bfab2c@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Igor and Eric,

On 5/27/25 10:03, Igor Mammedov wrote:
> On Tue, 27 May 2025 14:38:16 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Tue, 27 May 2025 09:40:10 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>
>>> This commit adds DSDT blobs to the whilelist in the prospect to
>>> allow changes in the GPEX _OSC method.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> I take it back,
> 
> test with x86 enabled breaks on microvm,
> so it's missing some DSTDs here

It's fixed in the series I've just posted in 24/25 as we discuss it. Thanks.


Cheers,
Gustavo

> 
>>
>>> ---
>>>   tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index dfb8523c8b..abe00ad4ee 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1 +1,6 @@
>>>   /* List of comma-separated changed AML files to ignore */
>>> +"tests/data/acpi/aarch64/virt/DSDT",
>>> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>>> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
>>> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
>>> +"tests/data/acpi/aarch64/virt/DSDT.topology",
>>
> 


