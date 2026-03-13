Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930FD106FD6F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0tCz-00073C-05; Thu, 12 Mar 2026 23:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tCx-00072w-Pz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:29:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tCv-0004nq-Vt
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:29:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso28466335e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372540; x=1773977340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JgddVKVl/gHR1FlzR4UJ792G2rnj4c9292s2Rq71njM=;
 b=UCloMHmttMgwFiOe6/nxDntyGBWTtqpJu1Qm3mAIMmAF2GeDlkdxGIGE0GHBSdYqBf
 TKoQSYiUvDcSp9RS/ydk1/AsGCifuQLdBsMmZqvXa+agWu9Zwelhh78Zp6Rt/Jsjjwur
 gqneRquMWvvBmj4VTzEx1G8dTmVgI2AVJwxsUVsdiml9ho4d0/5RMSbBKTO7Vyr05AIH
 Ne5bW2NCkw0XDeIQ06XoHSZjiOROAQQ3s8XZCffHzANJ2OTrfAjSHv4rNCBwAx4iGH1F
 fbIrtTgPomTWWDuY0Kq69kOQcIV3VMsm6HokTNoHwj5MRUrFVpL+fl4dlVyeirjttb+i
 hEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372540; x=1773977340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JgddVKVl/gHR1FlzR4UJ792G2rnj4c9292s2Rq71njM=;
 b=I1Cwjyw3w7LbjY9va916+aw0SOcPl3HEI5Y+Gme//Lw3a6eBl/HUZ4oqTTHIlfqzmg
 QYtKaUcNqZoAl5LRvcaFXzkC/yOmXtmhERp1pfuMlzggn0m+iHoEHLqBuSc1qNHzlroE
 TbFtRa2M2Ck0sEAmT6TRN9XjLVRp3aLphFbvhwKtcqwZ4W3VxiGYglwcj1rR4fnaRaTH
 nMlFPBC4/II4Cr9XL9DjbD+2rmNlkvGhvk/nYMNGqu/iCndSUk7z2x4qWROKq26riI7j
 Ryo5oWSrlW5FA3yEjSJcsy8Fu5sF4nIceYOW0r2w7qUIKUI9WkuGMHDN0449tXr5li5N
 Gzqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXJgsSXad9cKhirbB+GliiyC0Kqdj4p+OEmWPT4KtyiQLpzfQLaEcmosL858UACLItJVAazwVAGfBF@nongnu.org
X-Gm-Message-State: AOJu0Yy/xB8ZqDbx2BG6/kWgJ/UtP3DzmEAS8UVhLx09ah1Ck4s2bjXE
 f3uJIg6Q6ij0v4JY2oYOI70xTpcRAGMnZ28JdBScGsCeHSXU6Ydth1zn9k2GHPZ7Vh8=
X-Gm-Gg: ATEYQzwKsuW6nj215mwHj2P0nbdF2X12etER2ilBZ+P5cwkPs5M8EhbhIpZhTW4Tw9M
 yxVWMGp3Z6Z8EfFMobj7QNGWrm2FQzKxnNwzbQP1QSYyXfyjjFA6eM2LWzGqQgFpSxDNL0rMFd3
 50hmVGBgCek2No0GnYklI3VekpI/dHXQtofk9/F9OgoXxBZ7DZycUedwdmohfuhHchEAM+jZ+ts
 w5hbGFHelamY9vUQINfW5xLpj0eHzwBoaLZ8IkvvGb1q0doCqQaguyGzjwN3lsNrGN8M8fOtt2u
 tcL4D93yRNybHMPGGgGRa3K5i9QT1juzfgUM3fJv+ARo51jxJa1OUtPXNrp9rzVjDJWckWQL/KN
 Ai09tEsHm8yrlRhWRYYxpoBnqvVyVemveHkUx/TAx29v+W8LcwIFPnqCcCVeQKPDC5YEX6GjPrJ
 faKzsSm/zKmuALsvU5pbdfOxHBN55kiXdyguGhyrIp2b0ltzIQ3u4/fTVPUKGLzKs71w==
X-Received: by 2002:a05:600c:34cb:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48555ab09d6mr27805435e9.2.1773372540373; 
 Thu, 12 Mar 2026 20:29:00 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fe27sm182510875e9.9.2026.03.12.20.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:28:59 -0700 (PDT)
Message-ID: <6386b33f-daf2-4fbc-9bcd-3b87cae1b52f@linaro.org>
Date: Fri, 13 Mar 2026 04:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Since this function needs kvm specific types, we need to extract in
> another file and link it only for KVM builds.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/kvm-spapr.h | 12 ++++++++++++
>   hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c |  8 ++++++++
>   hw/vfio/spapr.c     | 30 ++++-------------------------
>   hw/vfio/meson.build |  1 +
>   5 files changed, 72 insertions(+), 26 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/kvm-spapr.c


> @@ -406,33 +407,10 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
>       vfio_host_win_add(scontainer, section->offset_within_address_space,
>                         section->offset_within_address_space +
>                         int128_get64(section->size) - 1, pgsize);
> -#ifdef CONFIG_KVM
> -    if (kvm_enabled()) {
> -        VFIOGroup *group;
> -        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -        struct kvm_vfio_spapr_tce param;
> -        struct kvm_device_attr attr = {
> -            .group = KVM_DEV_VFIO_GROUP,
> -            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> -            .addr = (uint64_t)(unsigned long)&param,
> -        };
> -
> -        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> -                                          &param.tablefd)) {
> -            QLIST_FOREACH(group, &container->group_list, container_next) {
> -                param.groupfd = group->fd;
> -                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                    error_setg_errno(errp, errno,
> -                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
> -                                     "KVM VFIO device %d and group fd %d",
> -                                     param.tablefd, param.groupfd);
> -                    return false;
> -                }
> -                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> -            }
> -        }
> +    if (kvm_enabled() && !vfio_spapr_kvm_attach_tce(bcontainer, section, errp)) {

This is the kvm_enabled() check in caller kind I'm asking in patch 5 ;)
(It feels more natural to me when reviewing).

> +        return false;
>       }
> -#endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


