Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ED7CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMKL-0001Wi-K5; Thu, 15 Oct 2026 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHMKK-0001WS-9Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHMKI-00042X-9X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792074057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DD5iEbr+JLWkq6bQIgWITScf5DDXuPDK80oahfo5A0o=;
 b=KRVO30vndYrT8q5l8BSnNiJegl+ElyN/IlgHUqBI48dBLKMddZ+IWarf7W+BkYGM0QSepR
 EdMIllYrw3dwEN0WO1eFrnna7A94X5tZVmz1x7LBorvyqpfawZfaI7u2sZalEZjSO9Zd6y
 sjzkeuJrJoOrTarpDmCzk5QIxr7ruEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-p7EeYiF3NLOw_XqNDDzqcQ-1; Thu, 15 Oct 2026 14:20:51 +0000
X-MC-Unique: p7EeYiF3NLOw_XqNDDzqcQ-1
X-Mimecast-MFC-AGG-ID: p7EeYiF3NLOw_XqNDDzqcQ_1792074050
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so16948895e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792074050; x=1792678850;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DD5iEbr+JLWkq6bQIgWITScf5DDXuPDK80oahfo5A0o=;
 b=gR+4ELz+ahly3nxfBcOoTs6HKCLXritQUtOHh1BJaSqvFOm72YrWotMzpq1OyTXtI3
 DkrGK92igHVwUhFL1sehoUUUkvcEY27gx4tnoTWRbhgp2I0lmIXJ6QNGYerEDom7pQ2U
 u6RBGmU4RjJ6+BPg6FVHPiCTObPj/RNKoho+6et2vzUk/j6sGyEzHPUWYtfEEEBcef5p
 KKdpstfQTt0nINXOQi94uSmJfuFpJft2CvMQw2x8QqlP1FHA/G8xNAMVxjGR+zAmAgN3
 tsk06aQowhnPHqVaP/2zk5z/ugh7XhgrSn09wWeQSfOSAXI/DqZZ8wHsrtj8RKpOe34W
 0yfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOqO6Xd/FBXeJ/TGM3eaXnoLWFI2qw2jJEWkIySDl+vasnWhpZA2ZKsREAGcGVR8zW8ntd/u/21XBQ@nongnu.org
X-Gm-Message-State: AFq9FYLpR9Csk/KVIatbm7VwlRtD3nigRiqMhSDGc3RDokm/xs0eS/Ke
 GHFiBFGabq4sDNS9lpM0Y80ALaVCMUsdDndTrTEMYA+iEnLA23Arq7EDTUUz3aJolEiTLrBNCqw
 DGdLKDAdTkPpznyqh+ApPBriz9Q5vx6m2zo/Wo8jEXaAL+lPNXB41jHw7
X-Gm-Gg: AYBFou3jntWvVwuzF+wDQ9k2gcEWwuf4jJ+hnLIJblppfTP/2FR7aMiXt+klmh79FsJ
 KyY+mLauT9B+0hoYMYKO+3qO9hR/Moes2kNbR54L9qF+a+sxj2QZew20gYyzhON5UAJdOyUYmPK
 x9KTimgwh9gYo6XK2Lyu12fBJlDcF4X4u7wDr4vDJdhwy03QIkBqsmBrMUA34woUUOrAHDlEBoB
 CM7O258mYBVBEKDTve7SBC0zKZwLl87EkGRtm48fCPLUkrYdL7gYMQcuKImrPbrtCXaqNQTebTI
 bnqL8Fgc0LFKKhI+NdVV4CziK1l/0H8WsLYVrDPE08J2tuH9CavkFodfGo8XKotAGIROuP3aU0p
 mscIcP7Gv97DBRAYUCwCPBucQEegc3uYpDokcg7dmCJ4Cp5Wm
X-Received: by 2002:a05:600c:a4b:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a1af68d397mr173681585e9.2.1792074049916; 
 Thu, 15 Oct 2026 07:20:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a4b:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a1af68d397mr173678615e9.2.1792074047479; 
 Thu, 15 Oct 2026 07:20:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd97ed33sm85893405e9.5.2026.10.15.07.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 07:20:46 -0700 (PDT)
Message-ID: <543a8f0a-bd66-4c13-8117-07f069a754d8@redhat.com>
Date: Thu, 15 Oct 2026 16:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 23/25] qmp: add query-cpu-props-info command
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-24-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-24-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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



On 9/21/26 2:32 PM, Khushit Shah wrote:
> Introduce the 'query-cpu-props-info' QMP command. For each CPU model
> property, it reports the type (boolean or number) and the set of values
> supported under the active accelerator and host.
>
> This helps the management stack to discover which values are supported
> for a given CPU property. This is especially important for non-boolean
> properties, where knowing that the host has value 'x' does not
> inherently reveal the full range of valid values supported on the host.
> For example, an Arm host with CTR_EL0.L1Ip=3 (PIPT) also allows 2
> (VIPT) but a host with CTR_EL0.L1Ip=2 does not allow CTR_EL0.L1Ip=3
> for a guest.
>
> For numerical properties, the supported values are expressed as a list
> of inclusive {min, max} ranges. For boolean properties, they are
> represented as a list of true/false values.
>
> The command and its return types (CpuPropertyType, CpuPropertyInfo and
> friends) are defined in qapi/machine.json rather than an Arm-specific
> schema, since the concept applies to other targets (e.g. x86, RISC-V)
> too. Targets that do not implement it return an error.
> (The following commit implements the command for Arm KVM.)
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  qapi/machine.json          | 82 ++++++++++++++++++++++++++++++++++++++
>  stubs/meson.build          |  1 +
>  stubs/qmp-cpu-props-info.c | 12 ++++++
>  tests/qtest/qmp-cmd-test.c |  1 +
>  4 files changed, 96 insertions(+)
>  create mode 100644 stubs/qmp-cpu-props-info.c
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 2d63c1bac3..6e65bdad86 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -2291,3 +2291,85 @@
>  # Since: 1.2
>  ##
>  { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
> +
> +##
> +# @CpuPropertyType:
> +#
> +# The type of a CPU model property.
> +#
> +# @boolean: the property is of type boolean.
> +#
> +# @number: the property is of type unsigned integer.
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'CpuPropertyType',
> +  'data': [ 'boolean', 'number' ] }
why do we still need the boolean type? Can't we simplify and stick to
uint64_t for all SYSREG props?
> +
> +##
> +# @CpuPropertyValueRange:
> +#
> +# An inclusive range of numeric values supported for the property.
> +#
> +# @min: the lowest supported value.
> +#
> +# @max: the highest supported value.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'CpuPropertyValueRange',
> +  'data': { 'min': 'uint64', 'max': 'uint64' } }
> +
> +##
> +# @CpuPropertyInfoBoolean:
> +#
> +# @supported-values: list of boolean values supported for the
> +#     property.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'CpuPropertyInfoBoolean',
> +  'data': { 'supported-values': ['bool'] } }
why can't you model that with a range too?
> +
> +##
> +# @CpuPropertyInfoNumber:
> +#
> +# @supported-values: list of numeric value ranges supported
> +#     for the property.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'CpuPropertyInfoNumber',
> +  'data': { 'supported-values': ['CpuPropertyValueRange'] } }
> +
> +##
> +# @CpuPropertyInfo:
> +#
> +# Information about a single CPU model property, including the values
> +# the host/accelerator supports for it.
> +#
> +# @name: the name of the property.
> +#
> +# @type: the type of the property, which selects the layout of
> +#     @supported-values.
> +#
> +# Since: 11.2
> +##
> +{ 'union': 'CpuPropertyInfo',
> +  'base': { 'name': 'str',
> +            'type': 'CpuPropertyType' },
> +  'discriminator': 'type',
> +  'data': { 'boolean': 'CpuPropertyInfoBoolean',
> +            'number': 'CpuPropertyInfoNumber' } }
> +
> +##
> +# @query-cpu-props-info:
> +#
> +# Return information about the CPU model properties.  For each
> +# property it reports the values supported under the active
> +# accelerator and host.
> +#
> +# Since: 11.2
> +##
> +{ 'command': 'query-cpu-props-info',
> +  'returns': ['CpuPropertyInfo'] }
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 3b2f2680b1..3bb4028bab 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -83,6 +83,7 @@ if have_system
>    stub_ss.add(files('qmp-i386-sgx.c'))
>    stub_ss.add(files('qmp-i386-xen.c'))
>    stub_ss.add(files('qmp-cpu.c'))
> +  stub_ss.add(files('qmp-cpu-props-info.c'))
>    stub_ss.add(files('qmp-cpu-s390x.c'))
>    stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
>    stub_ss.add(files('hmp-cmd-info_mem.c'))
> diff --git a/stubs/qmp-cpu-props-info.c b/stubs/qmp-cpu-props-info.c
> new file mode 100644
> index 0000000000..36b0530b98
> --- /dev/null
> +++ b/stubs/qmp-cpu-props-info.c
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +
> +CpuPropertyInfoList *
> +qmp_query_cpu_props_info(Error **errp)
> +{
> +    error_setg(errp, "query-cpu-props-info not supported on this target");
> +    return NULL;
> +}
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 279a8f5614..2c25dbd8cb 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -100,6 +100,7 @@ static bool query_is_ignored(const char *cmd)
>          "add-fd",
>          /* Success depends on target arch: */
>          "query-cpu-definitions",  /* arm, i386, ppc, s390x */
> +        "query-cpu-props-info", /* arm + kvm */
>          "query-gic-capabilities", /* arm */
>          "query-s390x-cpu-polarization", /* s390x */
>          /* Success depends on target-specific build configuration: */
Thanks

Eric


