Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A1CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umD2l-0004PX-53; Wed, 13 Aug 2025 11:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umD2j-0004Ow-2M
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 11:05:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umD2f-0002yo-Pw
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 11:05:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so7685305e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755097524; x=1755702324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zFqV9YfUCTYdu44lZXIcCqfnefFSaIKoC3NkPezqGE=;
 b=TkqFZZUIfKCZ//o0i0UXnZ4VRpIK6ExzOIPYWWQiam38xg22tc8VE+EJUbark7zlQU
 h1vmS5Oy8KyetjBs8hs7mmhc2/mYB2XUBH75cS9sbQLxDO2dLc5BK9RIgiiqMCaugPt4
 OEd/WiEjo2GUi4R+tGq/522jK3Sn1Q4xnD4cPiA80hOhxku7UVqao/Gw2XhixFPaCEw7
 UJkvzdPNSy3CGpPS1+2kmG5kar+s84XOtUrALwI53sB2K3YdVq3O9sSjDFeoZSMmDhyV
 xLJbXC2jE4hx4kInIbdB+E4AWVEMWGvMp/x8ghRVJdu8GfhcB/o1NYJc49qZoOE6AHe7
 XyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755097524; x=1755702324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zFqV9YfUCTYdu44lZXIcCqfnefFSaIKoC3NkPezqGE=;
 b=R41OE7WujfSY84mJWx2bFpux515eOLE6XBPrgbj2//JaKTQIvGAvBcYzFr/Z6LQPwu
 wl7jxAxsvYgbBCsTnaVRcA4/tuI83m89pVwRvGqHVIFdt3OYJ2qj+xuJaQzVF8j2Z5zQ
 tt9MiTZFL4PczyzEaE88jo+yKyhk8knW/kESPGq3U5eD4Abc5JwTsvvqowKuns/KOh+D
 v0WvSW4Ve2IlVC5IHJdYKt/NOQXJy48wPF11plNUzFiYvFE3Pc2nMwewasNipbjFwu5W
 OyyrkOKzHqd3uYbxJD1YU6B6Sm3/Ap7KHHL7Wf3t718jZoMruA3+0xQ8Io9pBIYHA3XK
 V8GQ==
X-Gm-Message-State: AOJu0Yx4jyMURvGR8lOjY/ZJdcS0xpr3QWBpbuN/NgOQU5faUzIhEwUA
 k2Jtt/AsNvDRkOsh0uVJN9fOvw5DNHab5SVVA93dPfnISzvBhHlRb0bFI8wdXdPsbxZBz4ajFB1
 1OUZS
X-Gm-Gg: ASbGncuN8fi2Ekyn4YSndzkfVkkjMOPuYuAcyxzVY1iAjUQQfDQ+hP6VH1nj8/721MI
 PN6q1mEPxT4JO9TskOReg53iAzLya7N6jifBd3UaMiB0ZMBZBGM0KP4DzlJAJs6Vl4hkQfpWI5z
 Am51uiEjWnqknVWWAYNkQ0yNIOfLo3Ljp7ZcKiO/0WhfuX+6i3L0WNd3UZBYby65CKUrSZUHdFc
 SV8db//aJezoJzEECgz4zlS7mEJ5fNXTTg6OsdlXRBmS8/0l7ZUdR+uXBJdP0HUAXlHkeYRlpi9
 7r9SSRstXO0pYqYcSmjG9Lifgw856DiPiaak9wsSY9Vh7D+0exGpVzju6pooK7MNLvCDlSK2mC3
 YjxgUorpUcv7Vn/D85OPYDxca+ritJuo4FTL+sZUbUd5k2SLOING2WJONWVQ4SEnfJA==
X-Google-Smtp-Source: AGHT+IF8XHg5TZlOM5SAMjEcxXUwrVfHdTZWgpjN6hlCDNihp0uNjx7LYZCG4mmjSm93J0SJKDzjEA==
X-Received: by 2002:a05:600c:1c9a:b0:456:189e:223a with SMTP id
 5b1f17b1804b1-45a19ad8354mr11567255e9.10.1755097523905; 
 Wed, 13 Aug 2025 08:05:23 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a50b9e6sm6768665e9.6.2025.08.13.08.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 08:05:23 -0700 (PDT)
Message-ID: <a57b581b-6cd7-478c-ab2c-59111515c1da@linaro.org>
Date: Wed, 13 Aug 2025 17:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: set error on cpr failure
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/8/25 16:17, Steve Sistare wrote:
> Set an error message if vfio_cpr_ram_discard_register_listener fails so
> the fail label gets a valid error object.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/listener.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23..5ebafaa 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -574,6 +574,9 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>               vfio_ram_discard_register_listener(bcontainer, section);
>           } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
>                                                              section)) {

Looking at commit 8947d7fc4e7 ("memory: Introduce RamDiscardManager for
RAM memory regions"):

     typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
                                      MemoryRegionSection *section);

     /*
      * @notify_populate:
      *
      * Notification that previously discarded memory is about to get
      * populated.
      * Listeners are able to object. If any listener objects, already
      * successfully notified listeners are notified about a discard
      * again.
      *
      * @rdl: the #RamDiscardListener getting notified
      * @section: the #MemoryRegionSection to get populated. The section
      *           is aligned within the memory region to the minimum
      *           granularity unless it would exceed the registered
      *           section.
      *
      * Returns 0 on success. If the notification is rejected by the
      * listener, an error is returned.
      */
     NotifyRamPopulate notify_populate;

Not sure what error is returned by this prototype (errno?), but if what
error is not relevant, maybe it should take an Error** parameter and
return a boolean value instead.

