Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52601C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNRy-0000S1-9y; Tue, 20 Feb 2024 05:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNRw-0000Rh-AD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:34:08 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNRu-0000kC-It
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:34:08 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3122b70439so640555566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708425244; x=1709030044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t4RdxejK1ghaAdX89a7x+8iJQMT/HxQf89rCE/iqR8I=;
 b=M78WYKtypGnreJsaEG2PKrdRPEbGGqYGfc5/Jh7n8jC0TQXXO1BKWmqJsscqsaqZQ5
 VT3g0WB8uvonamyOFx9x6u1dfdGB/U9Fm/TFln/7QWNS1qgFMuxdJ51GVayskWmPoNHS
 TACM+tA0bLG0WHjA9z3qzskBugo0h1QqecDH95DQEN1VHNfwzdIKuRZaeoIJYDq0nWmx
 qMk4Y6iKqMgUB76R3BG36eE6vWIPtzlZfz6f7cDjXb1frCpQ03EWWC1qqat+kLbBn4IC
 WxaFrvvin69fPcdEw6jCXkL5T1r+jC2zhwUcFGea3VXC3ElJfJEUeY3dhytSAmspRMRS
 0JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425244; x=1709030044;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t4RdxejK1ghaAdX89a7x+8iJQMT/HxQf89rCE/iqR8I=;
 b=UaXTyk1gFfWulZ4zq4i60NqRduN2Nb/LS43ziiM59wLPBvFr+F4gxQo/KFcSLuIhDF
 0VSTfJwB9ZpI0w8QxcFdpg9VPUybW61RJvP38wRLIFvfe8HXyEDE+uAL2aasMv/VjlLy
 whyPHdLNcxmK3cN1AHkUHJCBsmUguGY/5atLaJOHlOer4HqZlNql1XBae5iRmeXDHw+X
 QA0PPNcGaptg/3fYy+wUNPT7Ub8Ad91LAvBajcJkhc19l2KrfiI9Fs1OFHvM7vgTRI4A
 dsMalN2dFTH2cogsH7CIJUyQcOKCyxcT4baX0hKtTMTSOLGc0FRoAjctdRXX5Jhc5wrM
 ntMw==
X-Gm-Message-State: AOJu0YwMbD8IN79uYbsOcYOhomI/dvwmIWHQRWokRXWpYc/HUsZ1xqI0
 p6CMeu/KHSYaTh8JpPItugzq0tYa9Y54l9PgfOJ/KtP4QnSe1m1FsreCxS60Zf8pEMkHTCHTnq/
 +d7g=
X-Google-Smtp-Source: AGHT+IGMAbl4kuL/2VxZguxEHWR+qJVUGBbwmPkJ0s+Qq9d9cRI803ko8pRj9jECIrjg/nahqvZeBQ==
X-Received: by 2002:a17:906:e98:b0:a3e:8b5d:cd27 with SMTP id
 p24-20020a1709060e9800b00a3e8b5dcd27mr4145075ejf.13.1708425244282; 
 Tue, 20 Feb 2024 02:34:04 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 ae2-20020a17090725c200b00a3e643e61e1sm2566334ejc.214.2024.02.20.02.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:34:04 -0800 (PST)
Date: Tue, 20 Feb 2024 12:28:48 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v4 2/5] hw/virtio: document SharedObject structures
User-Agent: meli 0.8.5-rc.3
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-3-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-3-aesteve@redhat.com>
Message-ID: <95hcp.21l4vcaudvyq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
>Change VirtioSharedObject value type from
>a generic pointer to a union storing the different
>supported underlying types, which makes naming
>less confusing.
>
>With the update, use the chance to add kdoc
>to both the SharedObjectType enum and
>VirtioSharedObject struct.
>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/display/virtio-dmabuf.c        |  8 ++++----
> include/hw/virtio/virtio-dmabuf.h | 25 ++++++++++++++++++++++++-
> 2 files changed, 28 insertions(+), 5 deletions(-)
>
>diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>index 3dba4577ca..497cb6fa7c 100644
>--- a/hw/display/virtio-dmabuf.c
>+++ b/hw/display/virtio-dmabuf.c
>@@ -57,7 +57,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
>     }
>     vso = g_new(VirtioSharedObject, 1);
>     vso->type = TYPE_DMABUF;
>-    vso->value = GINT_TO_POINTER(udmabuf_fd);
>+    vso->value.udma_buf = udmabuf_fd;
>     result = virtio_add_resource(uuid, vso);
>     if (!result) {
>         g_free(vso);
>@@ -75,7 +75,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
>     }
>     vso = g_new(VirtioSharedObject, 1);
>     vso->type = TYPE_VHOST_DEV;
>-    vso->value = dev;
>+    vso->value.dev = dev;
>     result = virtio_add_resource(uuid, vso);
>     if (!result) {
>         g_free(vso);
>@@ -114,7 +114,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
>         return -1;
>     }
>     assert(vso->type == TYPE_DMABUF);
>-    return GPOINTER_TO_INT(vso->value);
>+    return vso->value.udma_buf;
> }
> 
> struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
>@@ -124,7 +124,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
>         return NULL;
>     }
>     assert(vso->type == TYPE_VHOST_DEV);
>-    return (struct vhost_dev *) vso->value;
>+    return (struct vhost_dev *) vso->value.dev;

Is the casting still required?


> }
> 
> SharedObjectType virtio_object_type(const QemuUUID *uuid)
>diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
>index 627c3b6db7..891a43162d 100644
>--- a/include/hw/virtio/virtio-dmabuf.h
>+++ b/include/hw/virtio/virtio-dmabuf.h
>@@ -16,15 +16,38 @@
> #include "qemu/uuid.h"
> #include "vhost.h"
> 
>+/**
>+ * SharedObjectType:
>+ *
>+ * Identifies the type of the underlying type that the current lookup
>+ * table entry is holding.
>+ * 
>+ * TYPE_INVALID: Invalid entry
>+ * TYPE_DMABUF: Entry is a dmabuf file descriptor that can be directly
>+ *              shared with the requestor
>+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding
>+ *                 the shared object.


nit:

+ * TYPE_INVALID:   Invalid entry.
+ * TYPE_DMABUF:    Entry is a dmabuf file descriptor that can be
+ *                 directly shared with the requestor.
+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding
+ *                 the shared object.


>+ */
> typedef enum SharedObjectType {
>     TYPE_INVALID = 0,
>     TYPE_DMABUF,
>     TYPE_VHOST_DEV,
> } SharedObjectType;
> 
>+/**
>+ * VirtioSharedObject:
>+ * @type: Shared object type identifier
>+ * @value: Union containing to the underlying type
>+ * 
>+ * The VirtioSharedObject object provides a way to distinguish,
>+ * store, and handle the different types supported by the lookup table.
>+ */
> typedef struct VirtioSharedObject {
>     SharedObjectType type;
>-    gpointer value;
>+    union {
>+        struct vhost_dev *dev;  /* TYPE_VHOST_DEV */
>+        int udma_buf;           /* TYPE_DMABUF */
>+    } value;
> } VirtioSharedObject;
> 
> /**
>-- 
>2.43.1
>
>

