Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F6CCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHH67-0005qo-LM; Thu, 15 Oct 2026 04:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHH65-0005qZ-2d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHH63-00016b-DM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792053953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XUxIq/JKuZiYr6JOemJl67D5U9t+yUxe3n5LJquaf9g=;
 b=LTetTyTpIiCJnapP4+ywCG3tCSMx+wsuju8bPwSHujYudArUrRK4LBXtW35xzoGcEvP7s9
 hM3VKK4qY0UAGWx+LtLEVCLBxNBj7m66dH+WwqUutaptyr1StHSias575iYL+MmpLlb1hI
 Zw0TNw/6FEK7Cqi/PInfYWJP8I4GmEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-aaJyabB5NBK4v3bl9CUlYQ-1; Thu,
 15 Oct 2026 08:45:52 +0000
X-MC-Unique: aaJyabB5NBK4v3bl9CUlYQ-1
X-Mimecast-MFC-AGG-ID: aaJyabB5NBK4v3bl9CUlYQ_1792053951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38717180065F; Thu, 15 Oct 2026 08:45:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65E543000735; Thu, 15 Oct 2026 08:45:48 +0000 (UTC)
Date: Thu, 15 Oct 2026 09:45:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] pci id: clarify pci subsystem id usage
Message-ID: <atCSufyPp8vdreSI@redhat.com>
References: <20261015081544.40310-1-kraxel@redhat.com>
 <20261015081544.40310-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015081544.40310-2-kraxel@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 10:15:43AM +0200, Gerd Hoffmann wrote:
> Qemu uses the pci subsystem id not only for emulated devices, but also
> for virtio devices and generic pci class devices such as pci bridges,
> xhci + nvme controllers etc.  Update the documentation accordingly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/specs/pci-ids.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359fe5..832f8bd1b802 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -46,8 +46,9 @@ maintained as part of the virtio specification.
>    upstream merge or shipping a distro/product) to avoid conflicts.
>  
>  1af4:1100
> -  Used as PCI Subsystem ID for existing hardware devices emulated
> -  by QEMU.
> +  Used as PCI Subsystem ID for existing hardware devices emulated by
> +  QEMU, such as the intel chipset devices.  Also used for virtio
> +  devices and generic pci class devices (1b36:00xx, see below).

When talking virtio devices, does that include virtio devices
implemented outside QEMU via vhostuser, or only in-QEMU virtio
devices ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


