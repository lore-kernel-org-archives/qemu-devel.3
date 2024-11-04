Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0BD1BDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80af-0005WN-5Z; Mon, 04 Nov 2024 12:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t80ae-0005Uz-7L
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:10:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t80aW-0006Q0-ON
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730740198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFeisZyKjab9DBMxlw5RHMVKj7JFUpwBhmXREaCFMWw=;
 b=fPp3d9X/OzmMTIdiXU5FD5eUpkONuv/hxMD9V/s/EgiGM3EDrUue0Yn2qMAyXQtSkjx3yr
 Fk1Cg5VmFvnAyjV8k2x/ErwUugZTHD1XmME6afmUK+nPj84DDfQZ6tErQ+d0uonvCz+BAX
 nq36FZVKU45pG4Xdpn+5m6R4Dzw7A08=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-5jgX4feAOFitqrlaclzgYw-1; Mon, 04 Nov 2024 12:09:57 -0500
X-MC-Unique: 5jgX4feAOFitqrlaclzgYw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539f7abe2e6so3132252e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740196; x=1731344996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFeisZyKjab9DBMxlw5RHMVKj7JFUpwBhmXREaCFMWw=;
 b=MHPyd5h0+t/bZXPQxEANhZi1zOsrIv2+k4qLGS5ykWJ9WEw4e+ZStJ7imP0sY82drB
 AEa8ayycptBuj5TvP8V79KT4S5Oc36cInVhJir0Dv6hRa51UTfLggxmKx06rsB0r2fdM
 RUk4oiS80b0ogGiUamFDLLccinVUpeYZVoYIj83Jl3tUJl4ed2Yv/TJjroHkvsy1x1h5
 ZFOO9wqQ3VYo7P9d1y6vZyqPyj7ApblNw7AFawW7ECRchnk/KwAejUv4mUKOUXAp7BsT
 MjI2KO+TLDS24yVz3pCAbBC9ac5Obtv2OYsny8VEBuRsg73oDUTxh2UjLBWt0f8cRb+X
 do/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv6p1M7SEqtQ0/ISR0cmQkOFvywLxSlGfkyE24iHXKEuW9tUisYSkHWUfDUDYKlv/WSv+pVNSugOQ/@nongnu.org
X-Gm-Message-State: AOJu0YwcI+hKNRqhP1HoZIItS645p2tH7wfSCnH1aljOvEE/SqeS1Dx9
 jTxBBLpodrPy+ZB8JzVQ36XuvyIII1HmtqHY+Ve56EXF9i1FDMZ2Vh+0aGXfbevXM0sbjDpMPET
 pr1oR+dR0OCUYf4y5BCd0sVyzhAs0qVU4SWi4OYyrd11mP2cLXipl
X-Received: by 2002:a05:6512:1597:b0:536:54d6:e6d6 with SMTP id
 2adb3069b0e04-53b7ecdece7mr10191502e87.17.1730740195807; 
 Mon, 04 Nov 2024 09:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7xwAcB+0QbfJoyh/EUDF5R2PpiYAI9Gm+fjNdJNgyQYB+bVZrmUS2hrGWdvpWlmtJrg2xzQ==
X-Received: by 2002:a05:6512:1597:b0:536:54d6:e6d6 with SMTP id
 2adb3069b0e04-53b7ecdece7mr10191473e87.17.1730740195319; 
 Mon, 04 Nov 2024 09:09:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9a53sm188454675e9.30.2024.11.04.09.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 09:09:54 -0800 (PST)
Message-ID: <6c05fc4e-ce14-4000-bb2a-63496bce9e98@redhat.com>
Date: Mon, 4 Nov 2024 18:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_CU9eeQByANMRW@linux.dev>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zx_CU9eeQByANMRW@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Oliver,

On 10/28/24 17:56, Oliver Upton wrote:
> On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
>> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
>>>> On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>> On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
>>>>>> On 10/25/24 15:06, Daniel P. Berrangé wrote:
>>>>>>> Also, is this naming convention really the same one that users
>>>>>>> will see when they look at /proc/cpuinfo to view features ? It
>>>>>> No it is not. I do agree that the custom cpu model is very low level. It
>>>>>> is very well suited to test all series turning ID regs as writable but
>>>>>> this would require an extra layer that adapts /proc/cpuinfo feature
>>>>>> level to this regid/field abstraction.
>>>>>>
>>>>>> In /cpu/proc you will see somethink like:
>>>>>>  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
>>>>>> asimdhp cpuid asimdrdm lrcpc dcpop asimddp
>>>>> Right, IMHO, this is the terminology that QEMU must use in user
>>>>> facing APIs.
>>>> /proc/cpuinfo's naming is rather weird for historical
>>>> reasons (for instance there is only one FEAT_FP16 feature
>>>> but cpuinfo lists "fphp" and "asimdhp" separately).
>>> There's plenty of wierd history in x86 too. In this
>>> case I might suggest just picking one of the two
>>> common names, and ignoring the other.
>>>
>>> If we really wanted to, we could alias the 2nd name
>>> to the first, but its likely not worth the bother.
>> Or we could use the standard set of architectural
>> feature names, and not have the problem at all, and not
>> have to document what we mean by our nonstandard names.
> +1
>
> There's existing documentation [*] for the standard feature names, which
> provides:
>
>  - A short description of what the feature does
>  - Any dependencies a particular feature has (e.g.FEAT_VHE implies
>    FEAT_LSE, FEAT_Debugv8p1, and FEAT_AA64EL2)
>  - The register fields/values that are used to discover the feature.
>
> This seems like the most user-friendly option...
>
> [*]: https://developer.arm.com/documentation/109697/2024_09

Was just wondering if all the writable ID reg fields were associated to
an official FEAT_ listed in this feature list.
Let's take for instance CTR_EL0.DIC. Is it associated to a given
extension or is it just implementation defined?

Thanks

Eric
>


