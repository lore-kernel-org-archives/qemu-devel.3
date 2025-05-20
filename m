Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQ5y-0005ct-3L; Tue, 20 May 2025 12:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQ5Y-0005T7-Kh
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:45:12 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQ5W-0005U1-F6
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:45:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso6552677a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747759509; x=1748364309; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+7SV2xh38BX70rkK3rxPOunQ+UQDLRyf1uVTWn74ko=;
 b=Qb4m2w6xaseEI7c/5Yd4334wTdeWZ8I8UVO9gUnVU6OEroD0J50xr48XjhMAB0BsJD
 eCoLVh45ibQ7JgrGpxEahCsnzjOgmbLrXehus7UFUWNm1dnIDKoXBLqVH6a1F0O1XaSf
 79cD5eWOp6qku7PpvYJZRKUWunj6mXvXaZaKOVYHnryAlzpqU70q8WSUkiwqhVlklxFs
 WNtQogVzN6fAroRam4Ew7ztA1tppxTqBoG1vhKJK9yhhdwz9F7F6zM3stDZa+idEVsW7
 Ll6FkrTnMxhy7HeI4dM3hTZ7sn1JT14DMvrMQ7NhkUj6GjIB8SEiZ4evtQFi5mbFQx5e
 HPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747759509; x=1748364309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+7SV2xh38BX70rkK3rxPOunQ+UQDLRyf1uVTWn74ko=;
 b=Rrwz/6Z0/JcAKuzNmMX9rGZ4jwpEEwAHS0tbke6lb0L0Ed62ctyshJrWqnnLY9l4QV
 gESKG1iEL9+NDdEVetGmoc7JnvjxvpZAyzQdy3Q0HKxw0sGQ5fkAuDx2NJMf9juktLbu
 VHjz+2sTNIDZg5YV3ddudRSxtTNJDRPuHqxrKuKH9TOZrEjy0UGvP9L0qjNKUn9+taKD
 FeUzmqOYK/NdbPDA6FNe7oT5I5LyzF8VaVViLuSUPhFMo2N+fE3MZlqh//h0xA0TkjE+
 ZTwYkyKmYRFCPJH3+BWrtAPpIv0d9sI4Hwv2d4Pp8eXpUVnhL78fGVk1v0U8pP7dLSSr
 z8gw==
X-Gm-Message-State: AOJu0Yw8Lo7SgXE5lnmq/Q0NfIcAAozNzAzU1N/IuDO72X34VgycmM85
 DfKGTDUtHkpLIibHCUCRSuanTXFU91EbrM1ezQ0C5bUrt9U5mtpt4TfSuNDN5Q==
X-Gm-Gg: ASbGnctQR7bzdn1T18vXEMB0NRvsGudLF5IAfp3KPDQwZTeOdFndK9thBq/Cpw4r/SE
 XVND27HcxHqNgHG5vRaZMifkXgxzJXNMQrVRvrmoH4kbn7Xt1jrYm74bIqYTL1OysfwAHW2gRtT
 TTJOSX+IpvhE3dY3YJ1VKBB+HBot7eA5rdCStAMxJf8U+Ku8XnbvVLGHD0/UHIY2UGmzAJrrMXc
 gwj7aCGDvc4Iob0uLbowIUgHU6ijBWI5mn1BiZfiVfyFUYJBt8j60PR3eO9f7Ip9+SPggWc6Sxg
 mzcyW+VG/uWY66Yvo0FxejwY1cPeYSvjjG/NhzHcug==
X-Google-Smtp-Source: AGHT+IFYCgM3TXmWDKu3+6RnTMM49ylrOwg9WGXbHuSOn26XlFcn63AoApwUU7jmZQgDlbaxxsvmTw==
X-Received: by 2002:a05:6a00:a81:b0:742:9f58:ccce with SMTP id
 d2e1a72fcca58-742acce364cmr22946284b3a.12.1747759498132; 
 Tue, 20 May 2025 09:44:58 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96deaf4sm8144837b3a.23.2025.05.20.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:44:57 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:44:55 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 05/10] cxl_events.h: Move definition for
 dynamic_capacity_uuid and enum for DC event types
Message-ID: <aCyxh8oN-NtI7eXo@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-6-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-6-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 08, 2025 at 12:01:01AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Move definition/enum to cxl_events.h for shared use in next patch
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c          | 15 ---------------
>  include/hw/cxl/cxl_events.h | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 05d4c861f1..6ad48f55ce 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1982,21 +1982,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> -/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> -static const QemuUUID dynamic_capacity_uuid = {
> -    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> -                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> -};
> -
> -typedef enum CXLDCEventType {
> -    DC_EVENT_ADD_CAPACITY = 0x0,
> -    DC_EVENT_RELEASE_CAPACITY = 0x1,
> -    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> -    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> -    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> -    DC_EVENT_CAPACITY_RELEASED = 0x5,
> -} CXLDCEventType;
> -
>  /*
>   * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
>   * the list.
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..758b075a64 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
>      uint32_t tags_avail;
>  } QEMU_PACKED CXLEventDynamicCapacity;
>  
> +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +} CXLDCEventType;
> +
>  #endif /* CXL_EVENTS_H */
> -- 
> 2.47.2
> 

-- 
Fan Ni

