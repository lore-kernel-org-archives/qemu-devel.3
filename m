Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB2FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiBR-0000fD-7y; Fri, 17 Jan 2025 03:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiBM-0000eG-Oi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiBK-0007We-6y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qPhFJxodvztzGMzbdk93Hqb7J69Qqw307bcQi5zBzbc=;
 b=hFWcaZw9G1f3cb6QO71z728o7BFnYWkiYmDnBBuFbcgXNOA8inC4RLooDfkZHEJY0tgTMM
 nWqyLlQbgZ6TlkuzmSeSvTeOr77JgEm/H8I0xxiIcCUalK9M7SPaLhJXsUpIjDlxgkOxch
 8rc5icyFPiqO8aV0Ya2sRs57ViXatKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-XLpCegtTOEOO8GyKM3Gsfg-1; Fri, 17 Jan 2025 03:58:18 -0500
X-MC-Unique: XLpCegtTOEOO8GyKM3Gsfg-1
X-Mimecast-MFC-AGG-ID: XLpCegtTOEOO8GyKM3Gsfg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d80576abso1388605f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104297; x=1737709097;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPhFJxodvztzGMzbdk93Hqb7J69Qqw307bcQi5zBzbc=;
 b=CPGCQWfa4YCHicXpAuSo7LBaTH8BfkQm7gck3P6PLX6fIZnZLEplInx7U1oxgxoUbM
 1YVdFlvEpN4SNCb+E2ckZtmKoZa+VXkgbxlRg1ToGvJT7BpER8MeOUAr3wk+SQWqr9Lh
 7dMLnGafTTXy2InsLk3PVFBw7nkkI1/XS8EhTsoL12P8rPGdCZQ3b9IQKsZenOu9QdRB
 eAsOsUqIZi9JwbnMdMUWiLK9YqIrJPDyEhiXSjGDwWz7QNe/HqxU82Uxn23CzX+/vW5M
 2DaY2NK7USzBJVmslYzbL1tkzLJ7W28zi69/gsJV1LrhP2xWbaRqJEgqJU6gn2mthiIv
 Iq6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBAnReL6zoHh7SKjWZXRQtICbd1HXt8kaTISvt1dskRVehkpP2jLz0ztdRwGVRJmL7fzQFYMP5f72@nongnu.org
X-Gm-Message-State: AOJu0YyzAncETW/lcZWtYaBGm0osDdEVqyVPtXE3EAbLRTPAFOCE5ADO
 QgpExLB+3cgoS8FLgm0EWkyD2FLQ2Xmn9+TAFE4Stpih0Teq44oXFv0A4N6fpZJq0HARwnxQPfb
 mUY39F/AAxzX6vysvr7TgjprSiI46OgeJAYTyr7iqywyDJYp3uC0m
X-Gm-Gg: ASbGncvPWji6bMJBL9RXepSYi19LqK10F9bjYx0RUxPKvI+Ip/ROkZbzQpUIttMi9rZ
 vJpzS8vnZsofhc4SuUKs6r7vyfQb1cWIHDEHQpD5w4vuK9747K/PRY88ZHCu/mszcZBIH0iL56s
 Z+4RFaBUwhBuqOEhBqclHeu+WMPZj5T+jxTySVqSo4F047Q+Y5FbFNHE43N3oxbCHJtjEO3tHKX
 jcjoWGoaaANPUXE6gcqUmZl4y1X0CsdFKwlcbQT2ps62UcY1JXp7VrempibuvIEsMSGhp/hnk3F
 pNmQQeFByy47
X-Received: by 2002:a5d:6489:0:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-38bf57bd824mr1270205f8f.50.1737104297267; 
 Fri, 17 Jan 2025 00:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7xMV/NrIJrF4+hxR2xkLqMfYMSgbk91HLkhKQ6glrBcn+T1OwXTsm4Zg8v/rNYGil5cMHQg==
X-Received: by 2002:a5d:6489:0:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-38bf57bd824mr1270180f8f.50.1737104296788; 
 Fri, 17 Jan 2025 00:58:16 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214fbdsm2004184f8f.19.2025.01.17.00.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 00:58:16 -0800 (PST)
Message-ID: <75e7805f-1ffa-421d-9415-5132131d80a7@redhat.com>
Date: Fri, 17 Jan 2025 09:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-9-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
> via the 'extra_mac_registers=off' property. We removed all
> machines using that array, lets remove all the code around
> E1000_FLAG_MAC.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/e1000.c | 63 +++++++++-----------------------------------------
>   1 file changed, 11 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 3d0b2277039..14d2133cd80 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -127,10 +127,8 @@ struct E1000State_st {
>       QEMUTimer *flush_queue_timer;
>   
>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
> -#define E1000_FLAG_MAC_BIT 2
>   #define E1000_FLAG_TSO_BIT 3
>   #define E1000_FLAG_VET_BIT 4
> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>   #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>   
> @@ -1218,46 +1216,17 @@ enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
>    * n - flag needed
>    * p - partially implenented */
>   static const uint8_t mac_reg_access[0x8000] = {
> -    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
> -    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
> -    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
> -    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
> -    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
> -    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
> -    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
> -    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
> -    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
> -    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
> -    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
> -    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
> -    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
> -    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
> -    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
> -    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
> -    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
> -    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
> -    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
> -    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
> -    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
> -    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
> -    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
> -    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
> -    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
> -    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
> -    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
> -    [BPTC]    = markflag(MAC),

I think this is wrong. All those registers should still be marked with 
MAC_ACCESS_FLAG_NEEDED, shouldn't they?

  Thomas


> -    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
> +    [TDFH]  = MAC_ACCESS_PARTIAL,
> +    [TDFT]  = MAC_ACCESS_PARTIAL,
> +    [TDFHS] = MAC_ACCESS_PARTIAL,
> +    [TDFTS] = MAC_ACCESS_PARTIAL,
> +    [TDFPC] = MAC_ACCESS_PARTIAL,
> +    [RDFH]  = MAC_ACCESS_PARTIAL,
> +    [RDFT]  = MAC_ACCESS_PARTIAL,
> +    [RDFHS] = MAC_ACCESS_PARTIAL,
> +    [RDFTS] = MAC_ACCESS_PARTIAL,
> +    [RDFPC] = MAC_ACCESS_PARTIAL,
> +    [PBM]   = MAC_ACCESS_PARTIAL,
>   };
>   
>   static void
> @@ -1419,13 +1388,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> -static bool e1000_full_mac_needed(void *opaque)
> -{
> -    E1000State *s = opaque;
> -
> -    return chkflag(MAC);
> -}
> -
>   static bool e1000_tso_state_needed(void *opaque)
>   {
>       E1000State *s = opaque;
> @@ -1451,7 +1413,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
>       .name = "e1000/full_mac_state",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .needed = e1000_full_mac_needed,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
>           VMSTATE_END_OF_LIST()
> @@ -1679,8 +1640,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
>   
>   static const Property e1000_properties[] = {
>       DEFINE_NIC_PROPERTIES(E1000State, conf),
> -    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
> -                    compat_flags, E1000_FLAG_MAC_BIT, true),
>       DEFINE_PROP_BIT("migrate_tso_props", E1000State,
>                       compat_flags, E1000_FLAG_TSO_BIT, true),
>       DEFINE_PROP_BIT("init-vet", E1000State,


