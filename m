Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B1606A320
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H8d13emV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=owj9vq6Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDwY-0006mu-4z; Sun, 08 Nov 2026 20:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDwT-0006mW-N9
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDwS-0000YY-1J
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794186779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMKDPSX15n3k5c8suHXe3BQVDbtKgFUS5GkgIpP9LjU=;
 b=H8d13emVEaiv6W1yDOyGU3hECG/E9pZVLRi2ywx1jjs5c1jrUA2kJwyIveBGhMf3a6cYm1
 53unxQAKu0cPt2h6of7IT3VkdXnQQt83MSvFeydVrjU59jsabwd09TvCgmnuM+Uaq2Ddfn
 ujnalKLtzdAHt0vAMU9jgcn15nGf1M4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-gd9DNVlkPV-dgapOJM_5Xg-1; Sun, 08 Nov 2026 20:12:57 -0500
X-MC-Unique: gd9DNVlkPV-dgapOJM_5Xg-1
X-Mimecast-MFC-AGG-ID: gd9DNVlkPV-dgapOJM_5Xg_1794186777
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4b764ffc014so3173155e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 17:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794186776; x=1794791576; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kMKDPSX15n3k5c8suHXe3BQVDbtKgFUS5GkgIpP9LjU=;
 b=owj9vq6ZuHZUkX4XsEBs/daORREn/mfc67KA8zVJogX2q9fMPcXpnooeYPtpDanDok
 5yk+Wuo43ysJn7Pma+/sTjGB5Xuv+MdsLDhS1XGgn+1mjt4tfhb5e38oIAoa8wyDDOhu
 fB6FxQE0f15YCEXyMVZWPPV3bnCenU+hRHB6Oywv6PhiUDOk9poAXd5rDc4Y6cqQA/cC
 /F+79GrBSDo+cpCFeN9OFeTwCfWVN7RKw7tPAXWZ/l1HaweFv1YMKMN1jE9Rawb3vPDL
 Rrrl6sQmxgDktmsd7/kIOT6A/xgX/iftBDos8xtUvsncGqmozUrtTy92zjyAs/gwqjk5
 jICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794186776; x=1794791576;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMKDPSX15n3k5c8suHXe3BQVDbtKgFUS5GkgIpP9LjU=;
 b=JGq5LY1D/ckevT4FxD+r2DWAuYBBZbQqxVNTgq8k5k6GnmMTm5X56OPPweOz2LqGTz
 YxhQZ/Ugp+6eWPxo5OVzc+M5nNkmn93aZRQO0tfsBlASmENYDSyZwiO8OYC+ecrMzUVV
 aNVOt5y8BZNx9Fiw5fF7MpjfbQ+FKZ5D0+KA8AitjM1qz09WU9MNCdsUYdyKUvU+tcsq
 lICtmwg1HmZ3ecpFLmn2jnj8HbRTZpAHDLIxOBOWLz7ZIswXXYAYUR+u7OBY2o2MvfFe
 /BC3gM7FacrqGtF0gQf8RHxWA3LSBaL74zPL0ohwqgNWmJuYPrNdtgiysS5+G29Je/C7
 7vFg==
X-Gm-Message-State: APuU4Z/bbac/BjYPq+4yLzNu4/vCU6VycvtEknHsJm3d5uURPqtu0S2D
 XZT5YG1D2BDunHyGXzNv9pnrSmWKt2CMZImtaJEOHdlrt9J51ZCFV8+TqDPlRVPyG3GYJvfT0yw
 pBNpLRLLA8OnNnvikBVX0ZkJ8urHbJRB4N6wRfoHVIKxwvpfheyCha07v
X-Gm-Gg: AYBFou1GZbYKz8yhAILZryTMsmUqd1/wxTQgXfyz1lcAUJ2OF1wVYclFMagJkx63+iv
 lVgAkfuFs4+qn2dV+dCSE8zorJPcxYjGUn1OlW3V8BazPElYScvIv4vFz3SPmoA7L93zWJHk4RL
 VlnLm7yroIU6GM+WX7dzSu0wSpCAm3WU36uW2kH839WYwnd4WEkzmY50FXaT2H2f9cduEy77PpM
 QmfgeUcIbxS1c0l7hXGwyXnoUHdT5NVMDexO4EuwJ/PchilS8VSrh9WpBn5bHwgpZ8itjXDrVK3
 No3shv3p+VNYYphVAicTPy86QxHH5+IJOylJkurMSE2tfnTS5W97XUkjSfjqG6C8aSyZXiIEXWN
 PmnA9icbW/eOQ+BBYUtjH7TQL2zbW2k59
X-Received: by 2002:a05:600c:198a:b0:4b6:b2cf:3088 with SMTP id
 5b1f17b1804b1-4b963c84b2amr52202505e9.14.1794186776607; 
 Sun, 08 Nov 2026 17:12:56 -0800 (PST)
X-Received: by 2002:a05:600c:198a:b0:4b6:b2cf:3088 with SMTP id
 5b1f17b1804b1-4b963c84b2amr52202385e9.14.1794186776281; 
 Sun, 08 Nov 2026 17:12:56 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795038782sm127785495e9.3.2026.11.08.17.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:12:55 -0800 (PST)
Date: Mon, 9 Nov 2026 02:12:53 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] hw/pci: More comments in pcie.c
Message-ID: <mwbg2n45yj4pu3fvbirux5sbvdzzirkqxh4yfehu34kwo47rmm@t6jzjuoentwe>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-4-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-4-212d2409563e@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jim,

On Thu, Oct 29, 2026 at 03:05:13PM +0000, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci/pcie.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index bf2c184cfc..c333ae01b2 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1017,12 +1017,15 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
>   * uint16_t ext_cap_size
>   */
>  
> +/* Looks through the capability list and finds one matching the cap_id */
> +
>  /* Passing a cap_id value > 0xffff will return 0 and put end of list in prev */
>  static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
>                                            uint16_t *prev_p)
>  {
>      uint16_t prev = 0;
>      uint16_t next;
> +    /* Find the first header, after the main 'config' (legacy) space */
>      uint32_t header = pci_get_long(dev->config + PCI_CONFIG_SPACE_SIZE);

Drop "legacy" and call it instead "PCI Configuration Space" as per the names in
the layout in "Figure 7-3 PCI Express Configuration Space Layout", p.
1055, spec rev. 7?


>  
>      if (!header) {
> @@ -1030,6 +1033,8 @@ static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
>          next = 0;
>          goto out;
>      }
> +
> +    /* Iterate through the PCIe config space, using the next cap offset */
>      for (next = PCI_CONFIG_SPACE_SIZE; next;
>           prev = next, next = PCI_EXT_CAP_NEXT(header)) {
>  
> @@ -1049,11 +1054,19 @@ out:
>      return next;
>  }
>  
> +/*
> + * As above, but ignoring the 'prev' parameter.
> + * Returns offset of that capability in the config space.
> + */
>  uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id)
>  {
>      return pcie_find_capability_list(dev, cap_id, NULL);
>  }
>  
> +/*
> + * Given a capability at position pos, set that's capability's
> + * next capability offset to 'next'.
> + */
>  static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>  {
>      uint32_t header = pci_get_long(dev->config + pos);
> @@ -1083,6 +1096,7 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>  bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                              uint16_t offset, uint16_t size)
>  {
> +    /* Start at the PCI Extended configuration space */
>      uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
>      uint32_t header;
>  
> 
> -- 
> 2.43.0
> 
> 

Please, enhance the commit title and add a commit message.


Cheers,
Gustavo


