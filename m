Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B88D29C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpzo-0000g7-Ot; Mon, 19 Jan 2026 09:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhpzo-0000eF-3c
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhpzl-0007qA-Mh
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768831959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yJcbJXxa0NBg6e/UZTm6jpNfPmN7vOTkKCXm18lRc0=;
 b=AYbdcU+JnT6eYYCcJ8WZpl9YaYMGEHXRBKHbTiXju/lepevKCWiVRavrOprtkfkXgq3dnB
 3YXMcLwGAeECgGbELwO6wH0CYGzmAyWI7aNRI42jnsAlvTTvyGwNcROe1RqQXR3McPnmwK
 CQkogD+wulwPV4TJwK5GBM5Z0L/gxBw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-9ZVokaLCNNuboceqdYhCTg-1; Mon, 19 Jan 2026 09:12:37 -0500
X-MC-Unique: 9ZVokaLCNNuboceqdYhCTg-1
X-Mimecast-MFC-AGG-ID: 9ZVokaLCNNuboceqdYhCTg_1768831957
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso40633955e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768831956; x=1769436756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yJcbJXxa0NBg6e/UZTm6jpNfPmN7vOTkKCXm18lRc0=;
 b=QPGsjUKcQeAs6prCrzZ+rdcIGIdosogv6VBbYT96XdFJX6m7PVrkxQG+qJOmQW5wY/
 NSBOrmRm6AE1tkEOTW8hjN3Vc+ueleD0aRA+b5IZ3gIwu5BpCLL62x3W7pUwgCoK9/DB
 9GfDPZel9tUW6S7lT+1aJKDSS+V5EG82Ymr8m2UQ9Vi69Qp1XZrL2wle485vXtNdmcL8
 ssG+lsI3Kvw0oRmJY4KM6tr++SNW0NpAJh+VzDU/vW9hIIVNlPnjzbX84WtGQklGfY9t
 fl7PPM8ln9e9thDxi9QHyRswjhI6gA+TCeEjrlNs+L3jsK3ckrFGxseNHjiWNAk/Rvi6
 5dUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwHlRYrRpjhhBJv13mjD2pCIz3HGxBRm4i9OGbqKtyJFZv1/ufX94HSnVW+f3hTm8zQKV0klzTzJNo@nongnu.org
X-Gm-Message-State: AOJu0Yx4IaXDqImQf/cI9E66xgXMaHerlck9ONuUQRfASayThOA/EmQx
 r1FaBL4d3yPfFdvPZnkqzLiE9daE7ANo3Iy4EQ8wZ7kw73+BbhtWXksMrcjjb8hFhVakmBH448u
 uWorNE5CJVa5t6SWIBjWacXbFEARK+Ona42C+YY9nEuqVD+TikefHWfBJtKJDGH3I
X-Gm-Gg: AY/fxX4fazult3n41uYKfzkRMiwgyOE38AwiO6IgzlJ5u1+6wraiat8kbJ/Ecu77Nd4
 Tix01uM4MlPgKsmpOtkngpFDylKgJHZ8l/hehVJSEyxGKdsdqPzeqZXDwxDYlvq9yBxup7MP54i
 Lvz+/54MtgMyxBgKpq39GfFihAwv3+uIp4Mb1aCDwJUBh6uFwHx35ckjAMLEH6Ty7c203d1AULo
 rvWZV99Ahv/+guDq41jmdQ44HxULe8lofj3kaZVHAMQU/uz+XtfV4SsZshIqVbTWou6eT2/fLyu
 k7yadSns/t/mSooSZ8PwePUBzKE7putP27V1DJtk34sdGj39qnuLwueS1tXHLdu8VSRgSK84N1Q
 j40xTp4XF4WfLxqLOZs83g74iC53rdFoXNrxXdodd73CguBHHr8EylobPSA==
X-Received: by 2002:a05:600c:5487:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4801e2f055amr141807715e9.8.1768831956302; 
 Mon, 19 Jan 2026 06:12:36 -0800 (PST)
X-Received: by 2002:a05:600c:5487:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4801e2f055amr141807355e9.8.1768831955838; 
 Mon, 19 Jan 2026 06:12:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d90b3sm200129445e9.15.2026.01.19.06.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:12:35 -0800 (PST)
Message-ID: <386995bf-b5fc-4cb3-9a9e-8d598c86927f@redhat.com>
Date: Mon, 19 Jan 2026 15:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/36] hw/pci: Factor out common PASID capability
 initialization
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-35-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260111195508.106943-35-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/11/26 8:53 PM, Shameer Kolothum wrote:
> Refactor PCIe PASID capability initialization by moving the common
> register init into a new helper, pcie_pasid_common_init().
>
> Subsequent patch to synthesize a vPASID will make use of this
> helper.
>
> No functional change intended.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci/pcie.c         | 19 ++++++++++++-------
>  include/hw/pci/pcie.h |  2 ++
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 8568a062a5..efd5588e96 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1273,18 +1273,13 @@ void pcie_acs_reset(PCIDevice *dev)
>      }
>  }
>  
> -/* PASID */
> -void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> -                     bool exec_perm, bool priv_mod)
> +void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
> +                            uint8_t pasid_width, bool exec_perm, bool priv_mod)
>  {
>      static const uint16_t control_reg_rw_mask = 0x07;
>      uint16_t capability_reg;
>  
>      assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
> -
> -    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
> -                        PCI_EXT_CAP_PASID_SIZEOF);
> -
>      capability_reg = ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIFT;
>      capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
>      capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
> @@ -1296,6 +1291,16 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>      pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
>  
>      dev->exp.pasid_cap = offset;
> +
> +}
> +
> +/* PASID */
> +void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> +                     bool exec_perm, bool priv_mod)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
> +                        PCI_EXT_CAP_PASID_SIZEOF);
> +    pcie_pasid_common_init(dev, offset, pasid_width, exec_perm, priv_mod);
>  }
>  
>  /* PRI */
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index d68bfa6257..fc02aeb169 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -155,6 +155,8 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp);
>  
> +void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
> +                            uint8_t pasid_width, bool exec_perm, bool priv_mod);
>  void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>                       bool exec_perm, bool priv_mod);
>  void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,


