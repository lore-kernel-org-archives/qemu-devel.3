Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49630CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvJA-0004iw-EH; Fri, 29 May 2026 07:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSvJ8-0004iR-Dh
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:23:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSvJ6-0001F1-6U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:23:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so6269736f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780053793; x=1780658593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uO3ry5GJpGwR5oEZ7CImM5uxK5VHyLGb1Ni2NED+2fo=;
 b=ZSkcYsbaAF1KIWWTTwcFh3o+qzJlc+OtFtRbLztYRMsgrPuibj6e19CcFNDtwU6lTU
 Cznpqu8O6b5UobG5vSsN6gt7KyOaklU06xTSEWDBt78PEchTmOtF0lyL7wnnF7xzP8fa
 94k6By6VfL0mNtaFdFd0eNAC2uKaHw8J81IBfUsBJJVz2cmsUuUUbjyfxQwFhZ8Y1NWi
 NYipfuuWeq+4L5JOKnQGbIWLGc975jXuG3Tl9Y/oIHOugcvog7DXpzNWCgxBCBQBAVsw
 gl+yyT1Vh7WGMfvLxGRkCHrWtX0z/srwdO8iNUYpxQGWKwwW0jx3tim5Uv0atJQgV03i
 qdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780053793; x=1780658593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uO3ry5GJpGwR5oEZ7CImM5uxK5VHyLGb1Ni2NED+2fo=;
 b=Daio2ZtT3WLioz6jNJavTu5eXLGDvYAGT+dDqhn25Cy3iVPNRKdvP200P4Gi6XAJRV
 bfZ/kXnJCMyhTOw2Q9ACmTTk6GozS8B6KlFJ/U1tOqG7acpY9QrY2pADkozIMzPHevbC
 5jO0PRHO44ptre4KJIcfeSWBVL/2guKK8VBalxAWt5Nbrk1koDB6oI9pOWQJNgch8wJe
 ksjfXAqck1EuDOl8IKxSh2Ob491xD2U2DVaWTNX9pNMmvYhQb+RWSAD2PmfJRVXh5clS
 IT4swlMTpalRx5JcdkgT8l/mEnTguCZZzJacQOxHWYYrHFl/G+76VmYLfWw+orekylBW
 zUsA==
X-Gm-Message-State: AOJu0YxscplvyknphgrPPmGeFc8bR6eZAZrkzty7uo7cuAL2ogVu1i7K
 tnoHQ8dwSpKVL5e2fCxQO7dgTlU6ZxIOo6VilbSIkglVd8UTrkDTUfEMeJ817hC/3P8=
X-Gm-Gg: Acq92OFGgpVAUPF5V6jH2mf2ccP5q+l9Yyy09Mw4KUWrnDXIo0LbfvPOQk+NKsTy/hW
 aguz2oG7PONs779ypDUE76ZAfcS/xc4AMGSsJDTI8Eor1R41iNQph9sn3PG3sNFKaKe1tLmQmYw
 mQrpWcl4Q5/A1h7iuWmk5HJm545XNeK5IxO64KfgU77AdlmeMct/NkKoqMCxqlQhG1gyn8pHlUe
 GuXAa0G1EoXQqVElRIVhsSG6DamGuwiNr2WMIPlQ/FYB3rsw5WAnvgibWq0s/lAvoCtB4MQtez1
 nM5F6e65f7loXypAXZwUUKJQuYFz8C392cn5MdjtEtGcdHHzAAFySMjVrDXI36JWX2KgPwPQ4pj
 TKDobiEE/zwVY+BiWQXoiq+cxg6Rt/C2UkIBKuxcV6pHAlUhxTGH9HHl8pYKNOOQgKUwGA3numG
 avIS8bjVK4CzNey+5/FM2L2kR6V4DD+MznBlCgAMs9lYdSsNHN5MtP5l0tp+yGmnNgJuM5grJFu
 pOO
X-Received: by 2002:a05:6000:114a:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-45ef145aacamr3916876f8f.23.1780053792860; 
 Fri, 29 May 2026 04:23:12 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef358c07bsm2883044f8f.36.2026.05.29.04.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 04:23:12 -0700 (PDT)
Message-ID: <e21880a2-f357-4ab8-a197-300417240ab6@linaro.org>
Date: Fri, 29 May 2026 13:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm_tis_sysbus: defer resource allocation to realizefn
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 peterx@redhat.com, richard.henderson@linaro.org, pierrick.bouvier@linaro.org
References: <20260528093123.55403-1-mbawa@redhat.com>
 <CAFEAcA8fEYODmPhbh1W=oPGvju-P=qWvN_dyWrPqAr-E9FK7UA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8fEYODmPhbh1W=oPGvju-P=qWvN_dyWrPqAr-E9FK7UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/5/26 11:15, Peter Maydell wrote:
> On Thu, 28 May 2026 at 10:31, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>>
>> Calling memory_region_init_ram_device_ptr() and
>> memory_region_init_io() from tpm_tis_sysbus_initfn() crashes
>> when the device is introspected without being realized, because
>> the memory subsystem has not been initialized at that point.
>>
>> So running:
>>    $ qemu-system-aarch64 -device tpm-tis-device,help
>>
>> triggers qdev_device_help() which creates the device object
>> to list its properties, calling instance_init, but never
>> realizefn. The memory region calls in instance_init then hit
>> uninitialized subsystems:
>>
>> With CONFIG_DEBUG_TCG:
>>    Assertion 'target_page.decided' failed. (physmem.c:2524)
>>
>> Without CONFIG_DEBUG_TCG:
>>    Assertion 'mutex->initialized' failed. (qemu-thread-posix.c:107)
>>
>> Since realizefn is only called when the device is actually
>> used in a running VM, moving resource allocation there avoids
>> the crash without breaking introspection.
>>
>>
>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> 
> This also fixes a memory leak that is reported by the address
> sanitizer during 'make check', because we currently allocate
> ppi.buf during instance_init and never free it. "Allocate in
> realize and never free" is less bad, because we don't currently
> support "unrealize and destroy a sysbus device".
> 
> Fixes: 46cd2c1050f ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")

Commit updated, thanks!


