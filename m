Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03106CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZOlF-0007vP-Dr; Tue, 16 Jun 2026 04:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZOlD-0007uV-0d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZOlB-0007AZ-HI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781596980;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kN2kbp0ZO+hLE5oZ/5WuYNrtaRI3M4w+bQORE2OJafs=;
 b=NWiwTFHOFDrGzjCtE1LGaPcofSzPSnRHuVCaug1M9zYeXzeOO/A+r6ZHy/QWNfre0PE3WM
 N7sh+g6GuheDL5azgNl3g5NnjHqQBdXG3vrPDncBYqAYwrXmPdqxioKfdQLjgk2vt6guI0
 WjDeaiJaEQxkNIqjomp0s9UylOuu+CA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-G39RZlRmNJSHT9dnRbEpdw-1; Tue, 16 Jun 2026 04:02:59 -0400
X-MC-Unique: G39RZlRmNJSHT9dnRbEpdw-1
X-Mimecast-MFC-AGG-ID: G39RZlRmNJSHT9dnRbEpdw_1781596978
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bf4ba05fd18so491486766b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781596978; x=1782201778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN2kbp0ZO+hLE5oZ/5WuYNrtaRI3M4w+bQORE2OJafs=;
 b=n8vY+bl5p+4sE8NE6Yl393+/HD5bAbcy9doytNeweTsmXuyw5X1DNHuBrV0dLEFtKL
 K7kY83OfNZQl6jn7yVvImdf6jXwOmhuqAoaW9hKEJhnfgQq1jJKXT324iIyLJUNk/Ald
 zxX19k0IBaUQh/gQjegZ4N9ek6ftDh1H499R915DL5vEMRvI6oWa3u9F9B3R0VQc30DH
 v30NDA9IAXk8TIjrvgcLEOhgEAdULkfpHQYtxOTPSyARPLDJZ7x9QpzrsoaYbJ/uzbnK
 wFVnUfZUL1emUvXbExDDVxp4GqfSJSwlpKY7Ie/QEN2TJHyDh1+/6Z0ayO1dYGgYw8La
 UF1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qc9d/3xEiVyOYPJDaGTk1EXnMJnkBJzWHtblpD77qLDPi9NQyasLTzqqEqocya+oQAnQtX3iRET0C@nongnu.org
X-Gm-Message-State: AOJu0YzUXfQjkdMl4UpnFfY3arD62p9rQtJWas+vtNLaYswKeKQyF5iz
 JB+QA9VzvScz8EoxjzMh0F7w+3z+zcZ5gmE8Tlthnteby/J6KZHgYzX0SzBBobwGGd9XFimxYmF
 DE2ycI7j7CX6wIRbT4fHK1OPSnX/C4dj6PEM8v9dQyYCoCgHaVujb4WBF
X-Gm-Gg: Acq92OGed7/tAUJsmynfQckvcbnbj7Cv4ItyizxjWa8Bs88ohzhBJPk794/lF17caPQ
 BEFpSuAitMo8D3IX/mopgqnpnOUSGOz9hhWubu1FD09nvH7DFplbbT2OggJCWCycN8sbvYSLSeB
 CbVGbKZbyjQ7x31CEPH1Gp/5mp3VIoAmKfoAkDv+hwoUZdyl8IwWdD9oI3FkAa9TnWuAL3U+M8/
 jw50b3pxfpW7uTIuDBmbBe4Fg9iic7J+xNhWXSTQm5oC/w1didQSObE8v4wCSrO0KwUkOahDQmQ
 wwYdDUs4g+lX7KpoS3m7+nps6SOW4eawNJWmUOxdUrAOfqLLY752jOAMd02VOlj56LkVLizLHmU
 3jmB4lDCIc3nxJSjSlGkvz15H9Y6aheZtOgbJ2UfXSemVoQnevk0YMmLd5Y3FikrUcqM1wg==
X-Received: by 2002:a17:907:1c9f:b0:ba6:e18f:1568 with SMTP id
 a640c23a62f3a-bfe2a2195a4mr925276366b.32.1781596977404; 
 Tue, 16 Jun 2026 01:02:57 -0700 (PDT)
X-Received: by 2002:a17:907:1c9f:b0:ba6:e18f:1568 with SMTP id
 a640c23a62f3a-bfe2a2195a4mr925270166b.32.1781596976848; 
 Tue, 16 Jun 2026 01:02:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb522167dsm592049266b.25.2026.06.16.01.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 01:02:56 -0700 (PDT)
Message-ID: <4c1bdb4a-2d9c-4a01-87c9-da2ad2c8f254@redhat.com>
Date: Tue, 16 Jun 2026 10:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/18] arm-qmp-cmds: introspection for ID register props
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, yangjinqian1@huawei.com, cohuck@redhat.com,
 richard.henderson@linaro.org, skolothumtho@nvidia.com, philmd@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-18-eric.auger@redhat.com>
 <10ae56f5-6fc7-fe58-1e17-7c3b968045be@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <10ae56f5-6fc7-fe58-1e17-7c3b968045be@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/27/26 8:29 AM, Sebastian Ott wrote:
> On Tue, 19 May 2026, Eric Auger wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Implement the capability to query available ID register values by
>> adding SYSREG_* options and values to the cpu model expansion for the
>> host model, if available.
>>
>> Excerpt:
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
>> {"return": {"model": {"name": "host", "props":
>> {"SYSREG_ID_AA64PFR0_EL1_EL3": 1224979098931106066,
>                  ^
> This looks wrong - more like the full reg value and not just EL3.. 
effectively! Fixed.
>
>> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
>> ../..
>>
>> So this allows the upper stack to detect available writable ID
>> regs and the "host passthrough model" values.
>>
>> [CH: moved SYSREG_* values to host model]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>
> Reviewed-by: Sebastian Ott <sebott@redhat.com> 
I added the write part now

Thanks

Eric


