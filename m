Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA957C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 06:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUi3Y-0007AJ-Av; Tue, 30 Jan 2024 01:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUi3S-00079o-W8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:57:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUi3P-0003Nl-1x
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:57:09 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ae6f4fd78so1589070f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 22:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706597825; x=1707202625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8wK1Tn4DlpdX0pfE1wr7+uOyoOXlYB4azBKxga7pWVQ=;
 b=m+1CeacUS3KV3xnsq9LvNusq71FLW1VBqzUTV/FHbHmfs8wd1NmEshZ5zLI3GHb6wo
 JFPiQSCQ/ftaS/vV0lbrTCtUB70vwuQbw2+SoF0i0Z4r7RPrm4zMqMDwwvqMczctEfHp
 VU7QW5d10mEpLNv6H4dm6SpVnW4+XcswZ5pqBqPTqOTMk1tLcQW2RzlbYSslJMZT5XsR
 a+oEmxRypmnXn9LBcTne0o7xMKfDthygVUN16u5j8/thxbOviIHYEJg9hmzd4/WQgDB8
 fvnvM44AKqutQnV9O7dCedeZFe+AOMvdwQghjnbouvr5hR9uzqplfmYpjZhSQCc6DHqQ
 7C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706597825; x=1707202625;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wK1Tn4DlpdX0pfE1wr7+uOyoOXlYB4azBKxga7pWVQ=;
 b=m1rUhDI6LPnbLoEerAV9+jL9X7sUTzoHAt72gXxjAiwsfrYKT4ubf6DY4w0PKm7s22
 jV0V4+K5Sz4/IqbNlk/fVrZPKSiWXDAeq/1trjLbunWGjop3lnFhrGshsHEIe7ZEnNmd
 XaZ23ZZkU1NXUJQSgFuo6pkuKBDMDaOZ3J0G0K7r/UVh2wznhBWqNvZXKLv88MXqJuhd
 hat/s40gYmW5ygTqUuJ/eiymz5ahJ0RtatVoPQgkrxp9wleZ8bUlK716/QjGOeI2tt4K
 Mkdq/c3YbVdeF5X/LET3n8VcF+F3bI9+YHlYFthpyC3q22qHGNjCkN5W2rTUd05EB8AT
 ll/Q==
X-Gm-Message-State: AOJu0Yx/l+DYEA2H9EGxQ3OYg02b5D/rPLeXNevLc7j6919AXyMCLxPf
 puH9QYFMFjFSYYufPOQ0YXQpgQoXK3qodIAWxHvuoafkpVE+xq3CWEooRydIUF0=
X-Google-Smtp-Source: AGHT+IF13ozkUzWEEScDc8qVt1pyLBJEfipUJkmBHPCKULuV1L74lgATURBxleaqozEDaHHLPl+9oA==
X-Received: by 2002:a05:6000:1f16:b0:33a:ec23:4563 with SMTP id
 bv22-20020a0560001f1600b0033aec234563mr3932649wrb.22.1706597824790; 
 Mon, 29 Jan 2024 22:57:04 -0800 (PST)
Received: from meli.delivery (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 ck14-20020a5d5e8e000000b0033afc81fc00sm482813wrb.41.2024.01.29.22.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 22:57:04 -0800 (PST)
Date: Tue, 30 Jan 2024 08:53:58 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alyssa Ross <hi@alyssa.is>
Subject: Re: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
User-Agent: meli 0.8.5-rc.3
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
 <CAAfnVBk1jsOxvOd0k2otPOEz65v5ngN4E98LMHhTr5Vtc2fOcQ@mail.gmail.com>
In-Reply-To: <CAAfnVBk1jsOxvOd0k2otPOEz65v5ngN4E98LMHhTr5Vtc2fOcQ@mail.gmail.com>
Message-ID: <82bb2.rl2cr4qt6406@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 03:26, Gurchetan Singh <gurchetansingh@chromium.org> wrote:
>On Mon, Jan 29, 2024 at 7:46 AM Manos Pitsidianakis <
>manos.pitsidianakis@linaro.org> wrote:
>
>> When the Rutabaga GPU device frees resources, it calls
>> rutabaga_resource_unref for that resource_id. However, when the generic
>> VirtIOGPU functions destroys resources, it only removes the
>> virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
>> The rutabaga resource associated with that resource_id is then leaked.
>>
>> This commit overrides the resource_destroy class method introduced in
>> the previous commit to fix this.
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
>>  1 file changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-rutabaga.c
>> b/hw/display/virtio-gpu-rutabaga.c
>> index 9e67f9bd51..6ac0776005 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>>  }
>>
>>  static void
>> +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
>> +                                   struct virtio_gpu_simple_resource *res,
>> +                                   Error **errp)
>> +{
>> +    int32_t result;
>> +    const char *strerror = NULL;
>> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>> +
>> +    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
>> +    if (result) {
>> +        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi32
>> +                   " for resource_id = %"PRIu32, __func__, result,
>> +                   res->resource_id);
>> +        strerror = strerrorname_np((int)result);
>> +        if (strerror != NULL) {
>> +            error_append_hint(errp, "%s: %s\n",
>> +                              strerror, strerrordesc_np((int)result) ? :
>> "");
>> +        }
>>
>
>Can't we rely on virtio_gpu_rutabaga_debug_cb(..) to report an error when
>the resource ID is not found?


IIUC that callback is called from the external library, and uses its own 
type (const struct rutabaga *debug) which is not how the interface works 
here. rutabaga_resource_unref() returns an int32_t. Besides this isn't a 
debug print but an error print.

>
>> +    }
>> +
>> +    if (res->image) {
>> +        pixman_image_unref(res->image);
>> +    }
>> +
>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>> +    g_free(res);
>> +}
>> +
>> +static void
>>  rutabaga_cmd_resource_unref(VirtIOGPU *g,
>>                              struct virtio_gpu_ctrl_command *cmd)
>>  {
>> -    int32_t result;
>> +    int32_t result = 0;
>>      struct virtio_gpu_simple_resource *res;
>>      struct virtio_gpu_resource_unref unref;
>> -
>> -    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>> +    Error *local_err = NULL;
>>
>>      VIRTIO_GPU_FILL_CMD(unref);
>>
>> @@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
>>      res = virtio_gpu_find_resource(g, unref.resource_id);
>>      CHECK(res, cmd);
>>
>> -    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
>> -    CHECK(!result, cmd);
>> -
>> -    if (res->image) {
>> -        pixman_image_unref(res->image);
>> +    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +        /* local_err was freed, do not reuse it. */
>> +        local_err = NULL;
>> +        result = 1;
>>      }
>> -
>> -    QTAILQ_REMOVE(&g->reslist, res, next);
>> -    g_free(res);
>> +    CHECK(!result, cmd);
>>  }
>>
>>  static void
>> @@ -1099,7 +1126,7 @@ static void
>> virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
>>      vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
>>      vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
>>      vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
>> -
>> +    vgc->resource_destroy = virtio_gpu_rutabaga_resource_unref;
>>      vdc->realize = virtio_gpu_rutabaga_realize;
>>      device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>>  }
>> --
>> γαῖα πυρί μιχθήτω
>>
>>

