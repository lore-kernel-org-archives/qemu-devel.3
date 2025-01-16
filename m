Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45A3C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYMdt-0004yy-3E; Thu, 16 Jan 2025 04:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYMdn-0004xt-TX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYMdm-0006Hu-2h
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737021497;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sFJKT5PwoBigBKBXXKcZQtxhesUr2bMG8Xdr0FsQO0=;
 b=MsM8CdrfbwspKW5thq0bqoMsWIdAn8E/fVZ2ne436Hc+SbFn25iE+dT46uwFboYNs6/LY2
 z7Zr4jmWiiNvql5zDVaaK8BJOtvjoCZjbBO65gapLsZFrBQd/bcwUpa3OS+4CsSlqfYhJS
 D3DODUaaplA6CHQyFwZHJ/5SvCpaxnY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-kKgNM0esPKKm1N45bLaHDA-1; Thu,
 16 Jan 2025 04:58:10 -0500
X-MC-Unique: kKgNM0esPKKm1N45bLaHDA-1
X-Mimecast-MFC-AGG-ID: kKgNM0esPKKm1N45bLaHDA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76ACB19560B0; Thu, 16 Jan 2025 09:58:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0665D3003E7F; Thu, 16 Jan 2025 09:57:49 +0000 (UTC)
Date: Thu, 16 Jan 2025 09:57:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 08/21] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Message-ID: <Z4jYGbenC4UZKKp8@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115232247.30364-9-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 16, 2025 at 12:22:34AM +0100, Philippe Mathieu-Daudé wrote:
> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
> via the 'extra_mac_registers=off' property. We removed all
> machines using that array, lets remove all the code around
> E1000_FLAG_MAC.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/e1000.c | 63 +++++++++-----------------------------------------
>  1 file changed, 11 insertions(+), 52 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 3d0b2277039..14d2133cd80 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -127,10 +127,8 @@ struct E1000State_st {
>      QEMUTimer *flush_queue_timer;
>  
>  /* Compatibility flags for migration to/from qemu 1.3.0 and older */
> -#define E1000_FLAG_MAC_BIT 2
>  #define E1000_FLAG_TSO_BIT 3
>  #define E1000_FLAG_VET_BIT 4
> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>  #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>  #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>  
> @@ -1218,46 +1216,17 @@ enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
>   * n - flag needed
>   * p - partially implenented */
>  static const uint8_t mac_reg_access[0x8000] = {
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
> -
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

It seems like this is removing all use of the 'markflag' macro ?

If I'm correct, then that macro can be removed. That in turnm means
the 'MAC_ACCESS_FLAG_NEEDED' enum entry can also be removed, as well
as places in code that check this flag.

>  };
>  
>  static void
> @@ -1419,13 +1388,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -static bool e1000_full_mac_needed(void *opaque)
> -{
> -    E1000State *s = opaque;
> -
> -    return chkflag(MAC);
> -}
> -
>  static bool e1000_tso_state_needed(void *opaque)
>  {
>      E1000State *s = opaque;
> @@ -1451,7 +1413,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
>      .name = "e1000/full_mac_state",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .needed = e1000_full_mac_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
>          VMSTATE_END_OF_LIST()
> @@ -1679,8 +1640,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
>  
>  static const Property e1000_properties[] = {
>      DEFINE_NIC_PROPERTIES(E1000State, conf),
> -    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
> -                    compat_flags, E1000_FLAG_MAC_BIT, true),
>      DEFINE_PROP_BIT("migrate_tso_props", E1000State,
>                      compat_flags, E1000_FLAG_TSO_BIT, true),
>      DEFINE_PROP_BIT("init-vet", E1000State,
> -- 
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


