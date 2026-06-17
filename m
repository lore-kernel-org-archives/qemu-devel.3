Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5549CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZm7w-0004OM-Oe; Wed, 17 Jun 2026 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wZm7u-0004NK-D2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wZm7s-0006bi-M7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781686799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c02hf33DdgzjAVGOLCeOgnML1B3Mm3pAYOvAzjAcWY4=;
 b=is+FZC+OCRR74zsEs4MQhdt4ofYb9H7n2vREdgo+ISu4WiRfgqXQEz65J3ggTyRxlSU2v5
 cY5aWD9g1/ssaBVmIvlnzzE8itWPG/y5DbaihFhh18NH1Z9i8KnKRb6ABLfgoHiw0MwMQY
 +FK2uDKDMTgbLTmtNFxR8/B+WqZREuE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-HdJrCXNuOGeAnikqpD_XOQ-1; Wed, 17 Jun 2026 04:59:57 -0400
X-MC-Unique: HdJrCXNuOGeAnikqpD_XOQ-1
X-Mimecast-MFC-AGG-ID: HdJrCXNuOGeAnikqpD_XOQ_1781686796
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ae016853so40796995e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781686796; x=1782291596; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c02hf33DdgzjAVGOLCeOgnML1B3Mm3pAYOvAzjAcWY4=;
 b=LUHO6d9VILhpeGCwqmzlYNSmhYloJMh0YCuGcAVZ7nRvaFxytw+k5fSrxwwPeDVbN/
 lR/weB76XbCjK85Vk3wDWJcojkkC4vQQujncim2YjkKRK9d46iaR8ks2h511j6AA3r5V
 ws8PML0n/OMh0FNSKHFK9tRqMbEXRRR0Nn94QIt5MkJO8hAoULR9LAkpbrV5Srhr6ERE
 4PIueKbqnJCRO+ri+SIn67u9NnGuroZpnEUn5Jf5y+7IOBJPJnqugWAcf/KlwdtX7vBq
 nHu+yYBn3cChxAla8k7+XTuHwI336avg3MN+wDK5Lkg1xIWN5S69nq61MxYJ758EIxt5
 zbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781686796; x=1782291596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c02hf33DdgzjAVGOLCeOgnML1B3Mm3pAYOvAzjAcWY4=;
 b=D00nYfjy4iYe+mTTn22l5g1ZNszv28lQNCeJ+XIvoj9X8XfIeEuZE1OrKhR5koXF+Z
 uiGdSKFKZZGeHfQMTEqJJoHstCPMrE0A1mhIDha+7lIqpmGhPIFP5tBTGW6nHmGq5Q+h
 Ejf0FsrcqhfN5n2koaDNTHg4jeT8kr6kxUebepxzu+ztU+pxyovRj3vYgE17OjPW7Nab
 aaUE9qxzwPGLRLyKn8GQa2br5mDnUaNnY5JHtwT9NqL45ZAP0tUJoBkK9XjS/DQnhSX2
 iruopOS6v+usFDgdMzEa3wL7UaoKLmg1Wn36lBhFKvJ2uo42DKZo+njEZeMScw7DFOia
 9nCg==
X-Gm-Message-State: AOJu0YwpSCSCvZc08JdJZaweH48CL4NaqxUYxA5uH1fd8xdZQRtteEGO
 WoJnMQT6BjbKS/5q7nT0Eq60uq1CNj0/J9qsY7d+sDV2B4/lkTi4fuwm3O3nrz0JnkSkQ4r28Sw
 8tZxtBJN+RGDCPj3lfPszWT67GXvdzxrb+RTErUSw3u0yTkmnDpYbMkkK
X-Gm-Gg: Acq92OEu2jsYobuutl2xkv8+H6ydRkS3+8JW2eu/xtuDlI8wPFhhBf9hOLNLYfYWrEo
 ZXTg16TAmbJDU9lnMqlalXjVHHf2gc9UptsOjKf2rUN4ifLOca5b+tOkmkeqm1o+TH5VlNgnWDw
 UYJ3ObkBWEcbMbmEkLZQYe4LN4KKukOIeP+xbHHmV1UXi4gcDmWIEIjE3wlbk6SBR0QlJaLoUTN
 E5Vp4kRd9p5TPVF6eP/7wMI3oczz3+g6XG3ZZoMzwfTSGZropx7+gAJ/mNB8ZfP6BG30fAH0A/n
 QJe6Xd7x12Ho3YG3ULtdD9DeVDH6r35JLbxJXsrmcbxkEqnvKSEyq36V84aipCrOAytRX9wFnbE
 QQA8vXZMzvCa2R81xHHpKgm3ixr6f0O+s+27UGT/WW65CHNVKGfjmem4MEBzX
X-Received: by 2002:a05:600c:8b52:b0:490:e281:287d with SMTP id
 5b1f17b1804b1-492340ff916mr42228215e9.1.1781686796537; 
 Wed, 17 Jun 2026 01:59:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b52:b0:490:e281:287d with SMTP id
 5b1f17b1804b1-492340ff916mr42227775e9.1.1781686796104; 
 Wed, 17 Jun 2026 01:59:56 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm253983665e9.14.2026.06.17.01.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:59:55 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:59:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v4] igvm: add device tree parameter support
Message-ID: <ajJhzopQfKWorBiu@sgarzare-redhat>
References: <20260615-microvm_device_tree-v4-1-128a59fd2f78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615-microvm_device_tree-v4-1-128a59fd2f78@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 15, 2026 at 11:11:53AM +0200, Luigi Leonardi wrote:
>Coconut SVSM, with the upcoming device tree support [1], will use
>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>devices instead of relying on the fw_cfg interface, which is
>QEMU-specific.
>
>The device tree is packed before copying into the IGVM parameter area
>to reduce its size, since IGVM files can define tighter memory
>constraints for parameter areas. Packing is done in the generic IGVM
>backend rather than in per-architecture device tree setup code, so
>that each architecture does not need to handle it individually.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>This device tree will be consumed by Coconut SVSM with the upcoming device
>tree support [1]. This will allow SVSM to run on a normal CPU
>(not AMD SEV-SNP) and execute all its tests using upstream QEMU.
>
>Eventually edk2 will also be able to consume DT via IGVM, but the work
>has not started yet.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>To: qemu-devel@nongnu.org
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Richard Henderson <richard.henderson@linaro.org>
>Cc: Gerd Hoffmann <kraxel@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Ani Sinha <anisinha@redhat.com>
>Cc: Zhao Liu <zhao1.liu@intel.com>
>Cc: Oliver Steffen <osteffen@redhat.com>
>---
>Changes in v4:
>- Using g_memdup2 [Stefano]
>- madt directive is now protected by CONFIG_FDT [Stefano]
>- Link to v3: https://lore.kernel.org/qemu-devel/20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com

Thanks for the update, LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


