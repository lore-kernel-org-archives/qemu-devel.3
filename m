Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CDAC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJxa-0002mJ-QG; Tue, 20 Feb 2024 01:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJxY-0002lo-3z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:50:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJxW-0004tg-CF
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:50:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4126d65ace3so3474345e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708411827; x=1709016627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7IEnePugGgUoICeCL35mG4yEzWVLyAAMfq5V5GWMgX0=;
 b=phA1P7sWn6pcwHLYnsakWjbmzbnnJuoS1V4S7J/eUqkHtOlcOu1+Uv4OoQTv5I+aFK
 tJtYrCS2OItoFMoxStmZDrHB5Y5dK5SDb8q8rn8TLB8Pdsn5KCjANpenGnnix1V5htlT
 OHMhuDSXNWPC7oSuzhw1YwM5McjSTNcipznA3kwFM/Qimtfs3pRkRX4DP41Id9mIfsZz
 2SB7txVzLBsMtghnxiw5+1BEis9eBQ9O83uiuy+cnvHa06q7XQ2ojIIkN/OhNrykzhVG
 4jCLT3os7yEjEkjCdGRs53uHyeX6lRo8BSsRrqNnjHCoJFyNGhMuDxbT28ruxzS+HNs+
 fcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411827; x=1709016627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7IEnePugGgUoICeCL35mG4yEzWVLyAAMfq5V5GWMgX0=;
 b=CohEn0ajXrrHnT6tk6aWjzIaH1p1f6kYySBfLV7boAM2ayUOoJCMpertmFvEuu3VDi
 jOiQBU851Q2zL4mL3CEakpaYmakb7fDYxQiw5MlLgb8rkO0SEf8Iuhx1e0jH4HKVullZ
 C81mrrDO8NnpjdM+QExiPgwjY2AxrNNIgby2KpfjMEBGpkCQD7fE6rL9fhS15HqO65H1
 c/IW4L5osB65UCQVH8U5EXD8goLQ4VrrzQVvpsd5TDsX9u9zpVuAtO/uqxUwGpIEOed9
 1NXGIZE8rqxrAUd6aI/uOzRsIZj+0oLAIcpZxsTnhxSoqCu3OH5/MNsRvrMA0Kdi5sR3
 x9EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKD3sWxaOcJ4jeyzg9GDF7GP7GYSrvkEbqxZcEDNOuvOP1RRWUk70Q17otuMnIjJsF+mHZnQ1MwwnYaOqFmkYj6xC6vN8=
X-Gm-Message-State: AOJu0YwGpFCfIvBZa9dOABXbaWZONUEe3WqnCL02SKgbgrUpHij3dZKY
 ahDJCLwGxlNT5zbGfzXsjR2ZJlX78KaFr+iSfwaeC+avbcTY0ftOqChIJlcQ1iM=
X-Google-Smtp-Source: AGHT+IHxO0r30lxscG2YCRQIfJHxQ5ifYp/345djnp2UqyWvY1/X9dmS4mMVsBvkya0ymJckBG5wHw==
X-Received: by 2002:a05:600c:21d8:b0:411:e398:ca7a with SMTP id
 x24-20020a05600c21d800b00411e398ca7amr11654370wmj.39.1708411827713; 
 Mon, 19 Feb 2024 22:50:27 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 s6-20020a05600c45c600b00412696bd7d9sm3642279wmo.41.2024.02.19.22.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 22:50:27 -0800 (PST)
Message-ID: <429a5a27-21b9-45bd-a1a6-a1c2ccc484c9@linaro.org>
Date: Tue, 20 Feb 2024 07:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/xen: detect when running inside stubdomain
Content-Language: en-US
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/2/24 19:16, Marek Marczykowski-Górecki wrote:
> Introduce global xen_is_stubdomain variable when qemu is running inside
> a stubdomain instead of dom0. This will be relevant for subsequent
> patches, as few things like accessing PCI config space need to be done
> differently.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>   hw/xen/xen-legacy-backend.c | 15 +++++++++++++++
>   include/hw/xen/xen.h        |  1 +
>   system/globals.c            |  1 +
>   3 files changed, 17 insertions(+)


> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 37ecc91fc3..ecb89ecfc1 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -36,6 +36,7 @@ enum xen_mode {
>   extern uint32_t xen_domid;
>   extern enum xen_mode xen_mode;
>   extern bool xen_domid_restrict;
> +extern bool xen_is_stubdomain;
>   
>   int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>   int xen_set_pci_link_route(uint8_t link, uint8_t irq);
> diff --git a/system/globals.c b/system/globals.c
> index b6d4e72530..ac27d88bd4 100644
> --- a/system/globals.c
> +++ b/system/globals.c
> @@ -62,6 +62,7 @@ bool qemu_uuid_set;
>   uint32_t xen_domid;
>   enum xen_mode xen_mode = XEN_DISABLED;
>   bool xen_domid_restrict;
> +bool xen_is_stubdomain;

Note for myself, Paolo and Claudio, IIUC these fields belong
to TYPE_XEN_ACCEL in accel/xen/xen-all.c. Maybe resulting in
smth like:

-- >8 --
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 5ff0cb8bd9..fc25d8c912 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -24,11 +24,31 @@
  #include "migration/global_state.h"
  #include "hw/boards.h"

-bool xen_allowed;
+struct XenAccelState
+{
+    AccelState parent_obj;
+
+    bool xen_allowed;
+
+    enum xen_mode xen_mode;
+
+    uint32_t xen_domid;
+    bool xen_domid_restrict;

  xc_interface *xen_xc;
  xenforeignmemory_handle *xen_fmem;
  xendevicemodel_handle *xen_dmod;
+};
+
+struct XenAccelOpsClass
+{
+    AccelOpsClass parent_class;
+
+    struct evtchn_backend_ops *xen_evtchn_ops;
+    struct gnttab_backend_ops *xen_gnttab_ops;
+    struct foreignmem_backend_ops *xen_foreignmem_ops;
+    struct xenstore_backend_ops *xen_xenstore_ops;
+}

  static void xenstore_record_dm_state(const char *state)
  {
@@ -114,6 +134,13 @@ static int xen_init(MachineState *ms)
      return 0;
  }

+static void xen_accel_init(Object *obj)
+{
+    XenAccelState *s = XEN_ACCEL(obj);
+
+    s->xen_mode = XEN_DISABLED;
+}
+
  static void xen_accel_class_init(ObjectClass *oc, void *data)
  {
      AccelClass *ac = ACCEL_CLASS(oc);
@@ -142,6 +169,8 @@ static void xen_accel_class_init(ObjectClass *oc, 
void *data)
  static const TypeInfo xen_accel_type = {
      .name = TYPE_XEN_ACCEL,
      .parent = TYPE_ACCEL,
+    .instance_size = sizeof(XenAccelState),
+    .instance_init = xen_accel_init,
      .class_init = xen_accel_class_init,
  };

@@ -157,6 +186,7 @@ static const TypeInfo xen_accel_ops_type = {

      .parent = TYPE_ACCEL_OPS,
      .class_init = xen_accel_ops_class_init,
+    .class_size = sizeof(XenAccelOpsClass),
      .abstract = true,
  };

---

