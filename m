Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C60C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Qyf-0007Vq-Ez; Tue, 07 May 2024 15:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Qyd-0007VZ-Vk
 for qemu-devel@nongnu.org; Tue, 07 May 2024 15:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Qyc-00064o-5R
 for qemu-devel@nongnu.org; Tue, 07 May 2024 15:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715111988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXHSctIBT5FlxGk0kj1EkZEZeOoDpM6z/Tp+FElWEak=;
 b=D+dyxUHUIlnZiG3vuDQzR0cxQg3cMBzAeOlnOXsiIZqCmgacznfQaaNcPAPzz60lN6gdAD
 rpwoVsr2wiU+hsr5+DkSJiYGvUGhuKyN8V5jPBXctBSkPLccLJW7WwawGyAaGFofRMpirS
 +oW4qvrGcudRFQTiA0cTTFaMnn1YogY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-GUa1qPhmOeiQfOjVi4kvfQ-1; Tue, 07 May 2024 15:59:46 -0400
X-MC-Unique: GUa1qPhmOeiQfOjVi4kvfQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79293218e22so73150985a.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 12:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715111986; x=1715716786;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VXHSctIBT5FlxGk0kj1EkZEZeOoDpM6z/Tp+FElWEak=;
 b=az2Lt2Yq9gH99JJtNgP5v7QAUduY5x48P4/xILnVkyH0WpR0LLjp/q+U1WBqKjMK8j
 PPzmmDI+Z+nJ0QSZeE54JmXv6+QEZUQnojK8FxLTU2l5OYhVgP+lp3dB9Rrton+SNmDy
 0V5EaL3dbaUpievMTMO7R5v++/NCdTT7YdGGDGSE3PnpsrvHzIn27YowC3A6wF+sewMs
 V2cAN4KCe+qlN7USPWPA/e8ZBJAraMVcE5fva4cyMvudHfNyNUBNaAYtfzaL9Zed2kBD
 9HnKJ8N5Ayo9eFpMVZ0exh8gCU+h3h3urYiCWEO029MywmzWz1+ZIrmWrWfxVhz3ILqQ
 EiKQ==
X-Gm-Message-State: AOJu0Ywk3eQ32qqqeMFUIx5Ybl60uY2COEPum9c+atXQE6ez4PEZ1MnR
 NoG5Fg2FGh7w/WRX7+Eulc/KNCiSXhNoSaqlO848zd5lE+XmPhG3zAbXEUAsT35ClpNwxeyUGHH
 fwxAV3m8S797AjdYmdQxuQ4eWfn0agi28rA7YllGxHb7I+2UdC1/A
X-Received: by 2002:a05:622a:5:b0:43a:2677:785c with SMTP id
 d75a77b69052e-43dbf74eae3mr6858921cf.4.1715111985583; 
 Tue, 07 May 2024 12:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6XwyJUG7RDOhQcn0xlYz7sP/pQoyTn2rnkVEykwjSFzl7GvXBkVHmbDe4PAxBY5IC/VEGw==
X-Received: by 2002:a05:622a:5:b0:43a:2677:785c with SMTP id
 d75a77b69052e-43dbf74eae3mr6858631cf.4.1715111984883; 
 Tue, 07 May 2024 12:59:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p16-20020ac84090000000b0043ae36dc25bsm6743525qtl.80.2024.05.07.12.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 12:59:44 -0700 (PDT)
Date: Tue, 7 May 2024 15:59:41 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
Message-ID: <ZjqILU7qxlTGN4OD@x1n>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507111920.1594897-4-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 07, 2024 at 03:19:19PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Depending on the version, use v1 or v2 of the scanout VM state.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..4fd72caf3f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1191,17 +1191,29 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
>      },
>  };
>  
> +static bool vmstate_before_v2(void *opaque, int version)
> +{
> +    return version <= 1;
> +}
> +
>  static const VMStateDescription vmstate_virtio_gpu_scanouts = {
>      .name = "virtio-gpu-scanouts",
> -    .version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
>          VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
>                               struct VirtIOGPU, NULL),
> -        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> -                                     parent_obj.conf.max_outputs, 1,
> -                                     vmstate_virtio_gpu_scanout,
> -                                     struct virtio_gpu_scanout),
> +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> +                                           vmstate_before_v2,
> +                                           parent_obj.conf.max_outputs, 1,
> +                                           vmstate_virtio_gpu_scanout,
> +                                           struct virtio_gpu_scanout, 1),
> +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
> +                                           NULL,
> +                                           parent_obj.conf.max_outputs, 2,
> +                                           vmstate_virtio_gpu_scanout,
> +                                           struct virtio_gpu_scanout, 2),

Personally I really wished struct_version_id never existed..  After these
years we only have 1 user of it (hw/ipmi/isa_ipmi_kcs.c), and we need to
keep that working.  I'm wondering whether there's way we can avoid adding
one more user, and even more complicated..

I think I get the reasoning behind "we define the same thing twice", but
this is really tricky and definitely needs rich documents, meanwhiel all of
these seem to rely on so many small details: one set .field_exists
properly, one leaving it to NULL; also the two versionings used here for
both parent vmsd, and the struct, and for each entry we need to set
different versions to different fields..

Would it work if we only make the new fields under control with
vmstate_before_v2()?  IOW, making all below with
.field_exists=vmstate_before_v2, so skip below when machine type is old?

         VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
         VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
         VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
         VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
         VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
         VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),

Thanks,

-- 
Peter Xu


