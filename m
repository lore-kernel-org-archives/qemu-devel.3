Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B265ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQoa-00038w-Ky; Tue, 02 Dec 2025 08:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQQoY-00038P-6K
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQQoV-0001tU-Vf
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764683586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ccZkKYpG6reUrqX/P/HODGfeaPwHtUq9ExmRzikWyPg=;
 b=Q9M6ZlbuOYvNOn5xDgPCk2m/yWplx6EGiP9XP1kwfbCpadJgIkjYITdPsW2PreLL8nhZp7
 f7XCkuq/fNXH+KY0G1arFSrEcD/gaFKpoMwNBC54glM5UhYqfpgn6/uuRiEcK2oSAF4ROU
 PYITR/9RFEbfmPGYCn60vYrduslG47I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5xyBNNL_P7Kp8cCMTFQkhw-1; Tue, 02 Dec 2025 08:53:05 -0500
X-MC-Unique: 5xyBNNL_P7Kp8cCMTFQkhw-1
X-Mimecast-MFC-AGG-ID: 5xyBNNL_P7Kp8cCMTFQkhw_1764683584
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e19c8558so1005652585a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 05:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764683584; x=1765288384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccZkKYpG6reUrqX/P/HODGfeaPwHtUq9ExmRzikWyPg=;
 b=FEdm7g+T84JJDDrenXgz4bvRdj/Ybht740vaJCvknDpprr103GsC9tsQM16Ag2CjSL
 COIarc71XysTdz5PDOz+tEgS2guG+0w98OoAdZ8W8ZEZusfkHvZKjSbe2OCMDJEDvVCv
 xORHoAZ3VaAplLkFtdwAJd/nOAuOh1R/cj/Mj51enZ1/Dd++u3eYnhDZ8ojdL+HJBuJQ
 YBH6Wt98S6ltyrC0WnDgabUXDQ9Xl8SxGia780bglIrXfLZNz8CPxkMVJbNdOhDMVOvs
 Rsc1JXMg+un4Iw1E37lu61ycendK60NVItM4aQfHuJVbNYTRmCUPmnTkQTMNsYqDD68G
 1gtw==
X-Gm-Message-State: AOJu0YyO6BHAxE3U5UmD/ihpyz4VYdLDRrF3m8Zfyn4liCGYXRzj1/du
 AmCPYtjtkrX4F5OtKnYpY9YJwnfyHqU1wkEFiyvl69kCxIs9FseiPanwguwlC5oBTn++g2JNkxW
 J4BIow2ngeXZq+NzSgwuplxOBIsedWT8Tv98zGifSTLH8dSV6yXS7c6xe
X-Gm-Gg: ASbGncsLdP9DoCspXI8xwZBFujOxhFz8jxf+BnaQGq+a+gUYnE5FjFQalwWRsVb0gLx
 X88YkV+GYAyNUwTS8xtViKfE1CbjwpYrx7twUFpn30wCUtjM966psJSYpQbZWpDQNo5dq5bEKUG
 mYuOOlgHNvZAundxZMLDEsNRiAKnAcNz2hvmojaeqZwhO6azleZYbcdilgnMZRd7ttJLKEo4G7S
 VqbisvX6Twh7o3Vh9hxjuNHWwp+AbgKub7rAveLhnIafvweMQbPap0YLgl0VMsVuReft4qH6HU7
 ti4CC31jlDHRQKdKueXJszwQJ2I17xtzG7amosKTdQDKmoVxUgxEWx1/pI7dalSVq9ndluuLmAP
 Gu3pu2sUStnyANBwfefxYDe02FswVOdGutSCpzOMbiaFJ1tpiTTlK+TZj3Q==
X-Received: by 2002:a05:620a:4012:b0:888:f40a:256 with SMTP id
 af79cd13be357-8b33d469e26mr5988566685a.65.1764683584294; 
 Tue, 02 Dec 2025 05:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmv7c8d2ZM3yY/6nK6zWHVp4LHdHRNNk8muK54O5kKPIoCSVgJChET2fbFhOsR4tMbtP1h2g==
X-Received: by 2002:a05:620a:4012:b0:888:f40a:256 with SMTP id
 af79cd13be357-8b33d469e26mr5988562285a.65.1764683583771; 
 Tue, 02 Dec 2025 05:53:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1df6b9sm1076584585a.53.2025.12.02.05.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 05:53:02 -0800 (PST)
Message-ID: <ac4ba17f-47ac-4c67-b2e6-c8d835ee0e6f@redhat.com>
Date: Tue, 2 Dec 2025 14:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-9-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-9-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 10/12/25 5:06 PM, Tao Tang wrote:
> According to the Arm architecture, SMMU-originated memory accesses,
> such as fetching commands or writing events for a secure stream, must
> target the Secure Physical Address (PA) space. The existing model sends
> all DMA to the global non-secure address_space_memory.
>
> This patch introduces the infrastructure to differentiate between secure
> and non-secure memory accesses. Firstly, SMMU_SEC_SID_S is added in
> SMMUSecSID enum to represent the secure context. Then a weak global
> symbol, arm_secure_address_space, is added, which can be provided by the
> machine model to represent the Secure PA space.
>
> A new helper, smmu_get_address_space(), selects the target address
> space based on SEC_SID. All internal DMA calls
> (dma_memory_read/write) will be updated to use this helper in follow-up
> patches.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         |  8 ++++++++
>  hw/arm/virt.c                |  5 +++++
>  include/hw/arm/smmu-common.h | 27 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 62a7612184..24db448683 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,14 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +/* Global state for secure address space availability */
> +bool arm_secure_as_available;
don't you need to initialize it?

why is it local to the SMMU. To me the secure address space sounds
global like address_space_memory usable by other IPs than the SMMU and
the CPUs.
> +
> +void smmu_enable_secure_address_space(void)
> +{
> +    arm_secure_as_available = true;
> +}
> +
>  /* IOTLB Management */
>  
>  static guint smmu_iotlb_key_hash(gconstpointer v)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 175023897a..83dc62a095 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -92,6 +92,8 @@
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
>  
> +AddressSpace arm_secure_address_space;
> +
>  static GlobalProperty arm_virt_compat[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>  };
> @@ -2257,6 +2259,9 @@ static void machvirt_init(MachineState *machine)
>          memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                             UINT64_MAX);
>          memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> +        address_space_init(&arm_secure_address_space, secure_sysmem,
> +                           "secure-memory-space");
besides using dynamic allocation like in cpu_address_space_init() would
allow to get rid of arm_secure_as_available
> +        smmu_enable_secure_address_space();
>      }
>  
>      firmware_loaded = virt_firmware_init(vms, sysmem,
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index b0dae18a62..d54558f94b 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -43,9 +43,36 @@
>  /* StreamID Security state */
>  typedef enum SMMUSecSID {
>      SMMU_SEC_SID_NS = 0,
> +    SMMU_SEC_SID_S,
>      SMMU_SEC_SID_NUM,
>  } SMMUSecSID;
>  
> +extern AddressSpace __attribute__((weak)) arm_secure_address_space;
> +extern bool arm_secure_as_available;
> +void smmu_enable_secure_address_space(void);
> +
> +/*
> + * Return the address space corresponding to the SEC_SID.
> + * If SEC_SID is Secure, but secure address space is not available,
> + * return NULL and print a warning message.
> + */
> +static inline AddressSpace *smmu_get_address_space(SMMUSecSID sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_SID_NS:
> +        return &address_space_memory;
> +    case SMMU_SEC_SID_S:
> +        if (!arm_secure_as_available || arm_secure_address_space.root == NULL) {
> +            printf("Secure address space requested but not available");
> +            return NULL;
> +        }
> +        return &arm_secure_address_space;
> +    default:
> +        printf("Unknown SEC_SID value %d", sec_sid);
> +        return NULL;
> +    }
> +}
> +
>  /*
>   * Page table walk error types
>   */
Thanks

Eric


