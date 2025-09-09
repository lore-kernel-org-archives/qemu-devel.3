Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6623DCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuW6-0006RF-TV; Tue, 09 Sep 2025 05:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuW4-0006Qf-S7
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuVr-0007pn-3g
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757409581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tQxGEDyiD5csPqCyhu4BPxW1dvm7kWBwjyOqicrXsLM=;
 b=AqeCf2qX2WKDV2z8O7zR3DcwzURqnECEcPohkMk++yGbYU4Cca3qIdA66VNpIY/kGwwPWC
 sT8hS7n7suYFjGCIat9sVNCkrzhn81c66NgmcNtorLEPMOCp6DGZGd8amah94nTc2Fgx4P
 kVoW5eUjgw2I1koQ31PpFncLMNQ/T9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-VWmMsmA9NTil-UT1Orup3A-1; Tue,
 09 Sep 2025 05:19:37 -0400
X-MC-Unique: VWmMsmA9NTil-UT1Orup3A-1
X-Mimecast-MFC-AGG-ID: VWmMsmA9NTil-UT1Orup3A_1757409576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C9E31955F2A; Tue,  9 Sep 2025 09:19:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E65C1800446; Tue,  9 Sep 2025 09:19:35 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:19:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] Support per-head resolutions with virtio-gpu
Message-ID: <aL_xJCxOMQdIkH9S@redhat.com>
References: <20250902141312.750525-1-ankeesler@google.com>
 <20250902141312.750525-2-ankeesler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902141312.750525-2-ankeesler@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 02, 2025 at 02:13:12PM +0000, Andrew Keesler wrote:
> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
> 
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
> 
>   -display vnc=localhost:0,id=aaa,display=vga,head=0 \
>   -display vnc=localhost:1,id=bbb,display=vga,head=1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>                  "xres":111,
>                  "yres":222
>               },
>               {
>                  "name":"BBB",
>                  "xres":333,
>                  "yres":444
>               }
>             ]}'
> 
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
> 
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
> 
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
> 
> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> 
> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

This commit lacks the Signed-off-by line to assert compliance
with the DCO. Assuming  you agree, can you just reply to this
mail with your S-o-b and then I'll queue this.

> ---
>  hw/display/virtio-gpu-base.c | 10 ++++++++++
>  qapi/virtio.json             | 10 ++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 7269477a1c..6adb5312a4 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
>  
> +    for (output_idx = 0, node = g->conf.outputs;
> +         node && output_idx < g->conf.max_outputs;
> +         output_idx++, node = node->next) {
> +        if (node->value->has_xres && node->value->has_yres) {
> +            g->enabled_output_bitmask |= (1 << output_idx);
> +            g->req_state[output_idx].width = node->value->xres;
> +            g->req_state[output_idx].height = node->value->yres;
> +        }
> +    }
> +
>      g->hw_ops = &virtio_gpu_ops;
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..9469c63e81 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -966,15 +966,21 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output. If both xres and
> +# yres are set, they take precedence over root virtio-gpu
> +# resolution configuration and enable the corresponding output.
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)
> +#
>  # Since: 10.1
>  ##
>  
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>  
>  ##
>  # @DummyVirtioForceArrays:
> -- 
> 2.51.0.338.gd7d06c2dae-goog
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


