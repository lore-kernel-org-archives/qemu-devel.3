Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC76C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdu5X-0007Sh-Q8; Tue, 13 Aug 2024 12:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sdu5S-0007Ra-0Z
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sdu5P-0003Sh-L7
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723565364;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVAVpyas4xXT0chItzS34DPuEZHElpSVb9SbyKoorik=;
 b=FqaUuy2uMHyLEAk+t8f1dOHqRXC2mkNatQ6zFt5o5YVymwYKkkZUMvTSgcEwEf12az/kCF
 wD0oN3UKuWmT4kwqcsWhHQa8hTL0FTSToRHHf2Ag5qekLvIWS0PHkcHxOrJzS5m4JsWywT
 tU//edeKRjiFXto3KWk2RjjJb+S7ToY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-rknoOXq6Ox-geuNS_p0ITg-1; Tue, 13 Aug 2024 12:09:21 -0400
X-MC-Unique: rknoOXq6Ox-geuNS_p0ITg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52efc9f2080so5734874e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723565360; x=1724170160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVAVpyas4xXT0chItzS34DPuEZHElpSVb9SbyKoorik=;
 b=gLs/UyHYjsAj+F481Yc+0FPkCdQhy1mumPk+m/8AfMdsyjbIL9Yyj7ggobzGZJtNYc
 mIEPcUtmevovgMIEYiPM1ikSgmU3u6Du1C8sF4zzEUtwFeGR8M+gBzWqxvca9c5tAAKl
 OKGiXZOrbAmLS4Rn9xmWxPqgaYVUhmQLMK7TrSPbDqhtLJO6HmhAuic/QP9i2xQzEoiS
 /XzfJNE1deUEucCTOui7KwPdLtmrGcf8/c36tc4KJgPkyzuu5soror/rJA1yvFXg5FEr
 3ySm309jZL4xu0cFBdyMmdZxeLwWg2Lzw2UzsTN7PiEN3KWqyltR65NnDraCiV+/Cn9y
 /T4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi8xQR7Qb/hlntJUl64t9L/3ulymkKt5PalxslGaSTvpaVUZ03DZqyt64ugVHsZ9+l96WmJP55kxTGvJFHapQQpnko1q0=
X-Gm-Message-State: AOJu0Yx8RmmYzh3SV4M9sTR7o6xXGSh7Uqn/swIR+HwsHIErFkcbfETS
 zbG92lXktdLaUawjFYDUrR20Koa2HzE+Ml0tQuVNT9+RBIa/DdQPPREwdUhE75e04vXtLhrEHlR
 7xhWboIkZKpu9CW+NGdt/xM1gzygiG3QMU70cLrQYpyxB70Fp6kfK
X-Received: by 2002:a05:6512:2351:b0:530:aa3f:7889 with SMTP id
 2adb3069b0e04-532136a3035mr2250507e87.56.1723565359602; 
 Tue, 13 Aug 2024 09:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCum4dukP+ZhI6d/Ip0cmqDq6kpIV5PxhMgyXBjNOPXlchnVa5+xG2bEOTbOSOZ17HUc7Zcg==
X-Received: by 2002:a05:6512:2351:b0:530:aa3f:7889 with SMTP id
 2adb3069b0e04-532136a3035mr2250486e87.56.1723565359000; 
 Tue, 13 Aug 2024 09:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4e51eb3csm10778187f8f.69.2024.08.13.09.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 09:09:18 -0700 (PDT)
Message-ID: <ef1e5fd3-0121-4b00-8917-09d8bf688333@redhat.com>
Date: Tue, 13 Aug 2024 18:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] docs: Fix some typos (found by typos) and grammar
 issues
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Blake <eblake@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240813125638.395461-1-sw@weilnetz.de>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240813125638.395461-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 8/13/24 14:56, Stefan Weil via wrote:
> Fix the misspellings of "overriden" also in code comments.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  docs/devel/migration/uadk-compression.rst | 4 ++--
>  docs/interop/qemu-ga.rst                  | 2 +-
>  docs/tools/qemu-vmsr-helper.rst           | 4 ++--
>  hw/arm/smmu-common.c                      | 2 +-
>  include/exec/memory.h                     | 2 +-
>  qapi/rocker.json                          | 4 ++--
>  qga/main.c                                | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/docs/devel/migration/uadk-compression.rst b/docs/devel/migration/uadk-compression.rst
> index 3f73345dd5..64cadebd21 100644
> --- a/docs/devel/migration/uadk-compression.rst
> +++ b/docs/devel/migration/uadk-compression.rst
> @@ -114,7 +114,7 @@ Make sure all these above kernel configurations are selected.
>  
>  Accelerator dev node permissions
>  --------------------------------
> -Harware accelerators(eg: HiSilicon Kunpeng Zip accelerator) gets registered to
> +Hardware accelerators (eg: HiSilicon Kunpeng Zip accelerator) gets registered to
>  UADK and char devices are created in dev directory. In order to access resources
>  on hardware accelerator devices, write permission should be provided to user.
>  
> @@ -134,7 +134,7 @@ How To Use UADK Compression In QEMU Migration
>    Set ``migrate_set_parameter multifd-compression uadk``
>  
>  Since UADK uses Shared Virtual Addressing(SVA) and device access virtual memory
> -directly it is possible that SMMUv3 may enounter page faults while walking the
> +directly it is possible that SMMUv3 may encounter page faults while walking the
>  IO page tables. This may impact the performance. In order to mitigate this,
>  please make sure to specify ``-mem-prealloc`` parameter to the destination VM
>  boot parameters.
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 9c7380896a..11f7bae460 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -50,7 +50,7 @@ Options
>  .. option:: -c, --config=PATH
>  
>    Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
> -  unless overriden by the QGA_CONF environment variable)
> +  unless overridden by the QGA_CONF environment variable)
>  
>  .. option:: -m, --method=METHOD
>  
> diff --git a/docs/tools/qemu-vmsr-helper.rst b/docs/tools/qemu-vmsr-helper.rst
> index 6ec87b49d9..9ce10b9af9 100644
> --- a/docs/tools/qemu-vmsr-helper.rst
> +++ b/docs/tools/qemu-vmsr-helper.rst
> @@ -17,8 +17,8 @@ driver to advertise and monitor the power consumption or accumulated energy
>  consumption of different power domains, such as CPU packages, DRAM, and other
>  components when available.
>  
> -However those register are accesible under priviliged access (CAP_SYS_RAWIO).
> -QEMU can use an external helper to access those priviliged register.
> +However those registers are accessible under privileged access (CAP_SYS_RAWIO).
> +QEMU can use an external helper to access those privileged registers.
>  
>  :program:`qemu-vmsr-helper` is that external helper; it creates a listener
>  socket which will accept incoming connections for communication with QEMU.
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index d73ad62211..3f82728758 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -674,7 +674,7 @@ error:
>  
>  /*
>   * combine S1 and S2 TLB entries into a single entry.
> - * As a result the S1 entry is overriden with combined data.
> + * As a result the S1 entry is overridden with combined data.
>   */
>  static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>                          dma_addr_t iova, SMMUTransCfg *cfg)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 02f7528ec0..296fd068c0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1852,7 +1852,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
>   * memory_region_unregister_iommu_notifier: unregister a notifier for
>   * changes to IOMMU translation entries.
>   *
> - * @mr: the memory region which was observed and for which notity_stopped()
> + * @mr: the memory region which was observed and for which notify_stopped()
>   *      needs to be called
>   * @n: the notifier to be removed.
>   */
> diff --git a/qapi/rocker.json b/qapi/rocker.json
> index 6950ca9602..73c7363b16 100644
> --- a/qapi/rocker.json
> +++ b/qapi/rocker.json
> @@ -42,7 +42,7 @@
>  ##
>  # @RockerPortDuplex:
>  #
> -# An eumeration of port duplex states.
> +# An enumeration of port duplex states.
>  #
>  # @half: half duplex
>  #
> @@ -55,7 +55,7 @@
>  ##
>  # @RockerPortAutoneg:
>  #
> -# An eumeration of port autoneg states.
> +# An enumeration of port autoneg states.
>  #
>  # @off: autoneg is off
>  #
> diff --git a/qga/main.c b/qga/main.c
> index b8f7b1e4a3..50186760bf 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -257,7 +257,7 @@ QEMU_COPYRIGHT "\n"
>  "\n"
>  "  -c, --config=PATH configuration file path (default is\n"
>  "                    %s/qemu-ga.conf\n"
> -"                    unless overriden by the QGA_CONF environment variable)\n"
> +"                    unless overridden by the QGA_CONF environment variable)\n"
>  "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
>  "                    isa-serial, or vsock-listen (virtio-serial is the default)\n"
>  "  -p, --path        device/socket path (the default for virtio-serial is:\n"


